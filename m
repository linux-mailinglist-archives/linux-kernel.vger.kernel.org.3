Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB0A57002C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbiGKLWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiGKLVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:21:54 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C6B97A23;
        Mon, 11 Jul 2022 03:46:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F129BCE1019;
        Mon, 11 Jul 2022 10:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B147AC34115;
        Mon, 11 Jul 2022 10:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657536394;
        bh=JwzvluCbjKHIwByWKYCylSImU+uaO2xsuE5ZVQxhsNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=USE9QiW13JHBxOl2Xr6E1hdWhCKo/XfzImc4fk9hXdfu/I8CsaSgETr5PcqNS6SGM
         97UHrpFIYW3SsvLumVSrbwmQUuVxbewr9fDPZYxnSgCAcVvPI8Ek5hzzImmMWU4KM8
         3fTC933e21fqm4ZDpntUIht4afbn3pxzAa6Xdm7tIUYw5G9UdXUVd3BNa8L/2DM8PK
         FZeOyXJwQBp3EB8sv88PUWTLyFdZxMWgLF7WVOE37iW+VTqgocceLAxgIDoBndTvNL
         dp3ASlZ+buGhuMrZgqo6heX/dXgYIZVtpCOInsI3ZIIsZn7hOf4ai9T1r5ey5GoYe8
         Vifgb2mDpAj1A==
Date:   Mon, 11 Jul 2022 13:46:31 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-sgx@vger.kernel.org, Harald Hoyer <harald@profian.com>,
        Nathaniel McCallum <nathaniel@profian.com>
Subject: Re: [PATCH] x86/sgx: Allow enclaves to use Asynchrounous Exit
 Notification
Message-ID: <Ysv/h31LvLUaXKj5@kernel.org>
References: <20220705183648.3739111-1-dave.hansen@linux.intel.com>
 <YsuMK0JIYqqjtVdk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsuMK0JIYqqjtVdk@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 05:34:48AM +0300, Jarkko Sakkinen wrote:
> On Tue, Jul 05, 2022 at 11:36:48AM -0700, Dave Hansen wrote:
> > Short Version:
> > 
> > Allow enclaves to use the new Asynchronous EXit (AEX)
> > notification mechanism.  This mechanism lets enclaves run a
> > handler after an AEX event.  These handlers can run mitigations
> > for things like SGX-Step[1].
> > 
> > AEX Notify will be made available both on upcoming processors and
> > on some older processors through microcode updates.
> > 
> > Long Version:
> > 
> > == SGX Attribute Background ==
> > 
> > The SGX architecture includes a list of SGX "attributes".  These
> > attributes ensure consistency and transparency around specific
> > enclave features.
> > 
> > As a simple example, the "DEBUG" attribute allows an enclave to
> > be debugged, but also destroys virtually all of SGX security.
> > Using attributes, enclaves can know that they are being debugged.
> > Attributes also affect enclave attestation so an enclave can, for
> > instance, be denied access to secrets while it is being debugged.
> > 
> > The kernel keeps a list of known attributes and will only
> > initialize enclaves that use a known set of attributes.  This
> > kernel policy eliminates the chance that a new SGX attribute
> > could cause undesired effects.
> > 
> > For example, imagine a new attribute was added called
> > "PROVISIONKEY2" that provided similar functionality to
> > "PROVISIIONKEY".  A kernel policy that allowed indiscriminate use
> > of unknown attributes and thus PROVISIONKEY2 would undermine the
> > existing kernel policy which limits use of PROVISIONKEY enclaves.
> > 
> > == AEX Notify Background ==
> > 
> > "Intel Architecture Instruction Set Extensions and Future
> > Features - Version 45" is out[2].  There is a new chapter:
> > 
> > 	Asynchronous Enclave Exit Notify and the EDECCSSA User Leaf Function.
> > 
> > Enclaves exit can be either synchronous and consensual (EEXIT for
> > instance) or asynchronous (on an interrupt or fault).  The
> > asynchronous ones can evidently be exploited to single step
> > enclaves[1], on top of which other naughty things can be built.
> > 
> > AEX Notify will be made available both on upcoming processors and
> > on some older processors through microcode updates.
> > 
> > == The Problem ==
> > 
> > These attacks are currently entirely opaque to the enclave since
> > the hardware does the save/restore under the covers. The
> > Asynchronous Enclave Exit Notify (AEX Notify) mechanism provides
> > enclaves an ability to detect and mitigate potential exposure to
> > these kinds of attacks.
> > 
> > == The Solution ==
> > 
> > Define the new attribute value for AEX Notification.  Ensure the
> > attribute is cleared from the list reserved attributes which
> > allows it to be used in enclaves.
> > 
> > I just built this and ran it to make sure there were no obvious
> > regressions since I do not have the hardware to test it handy.
> > Tested-by's would be much appreciated.
> 
> Is this available on recent ucode updates e.g. for Icelake
> or Geminilake?

I mean it would not take me long to upgrade our exception handling flow
to this. Then I can run our full test suite on it. But this will of
course require ucode update for Icelake.

AEX Notify will actually just simplify everything. We kind of simulate
"AEX Notify" already with EENTER to execute in-enclave exception handler
before doing actual ERESUME.

BR, Jarkko
