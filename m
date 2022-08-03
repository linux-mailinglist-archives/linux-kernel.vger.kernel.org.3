Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BF958910F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbiHCRON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236024AbiHCROL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:14:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF6251A03;
        Wed,  3 Aug 2022 10:14:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE6CF60B4D;
        Wed,  3 Aug 2022 17:14:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6ABDC433D6;
        Wed,  3 Aug 2022 17:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659546849;
        bh=bkDv/IJGf4huqlJShfUhZJTAGsDhgiK7rkVACQwjEj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AfmV3uyW1sqz8a+hoj6x2h5jMxXZvPxYyy1fX++srDGYIcV0GsLXYhisM9NDZfntU
         JZAk3+z4d+ZxdCDhhfl9sRd4Y1iopv4r4+Q9FBA0bKm1QmbrT1DJVZRbjVvekVztpL
         ss1hv/ru/EW5ye4/K+wk9JOScIwDNDAYDW/zlgg6NULRFE0eRCNf6Iz8+LWNlfu5PZ
         7FuUi+eDRkIIBiuibub0k3tJPflpnOjdOLe8ZxeajGLolUsmmapSSghgS2r6Mzep5j
         0Ux4edssawTsc63/hKJyt1bTlQCoaAxYAb4TuXgLVJhlRqugKQ6nC8ybUMEKc/XgEY
         jTZUqO73ClBgw==
Date:   Wed, 3 Aug 2022 20:14:05 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     dave@sr71.net, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Haitao Huang <haitao.huang@linux.intel.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] x86/sgx: Allow enclaves to use Asynchrounous Exit
 Notification
Message-ID: <Yuqs3ZdyBMkgQUd6@kernel.org>
References: <20220720191347.1343986-1-dave.hansen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720191347.1343986-1-dave.hansen@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 12:13:47PM -0700, Dave Hansen wrote:
> Changes from v1:
>  * Make sure SGX_ATTR_ASYNC_EXIT_NOTIFY is in the masks that are
>    used at bare-metal enclave initialization and that enumerates
>    available attributes to KVM guests.
> 
> --
> 
> Short Version:
> 
> Allow enclaves to use the new Asynchronous EXit (AEX)
> notification mechanism.  This mechanism lets enclaves run a
> handler after an AEX event.  These handlers can run mitigations
> for things like SGX-Step[1].
> 
> AEX Notify will be made available both on upcoming processors and
> on some older processors through microcode updates.
> 
> Long Version:
> 
> == SGX Attribute Background ==
> 
> The SGX architecture includes a list of SGX "attributes".  These
> attributes ensure consistency and transparency around specific
> enclave features.
> 
> As a simple example, the "DEBUG" attribute allows an enclave to
> be debugged, but also destroys virtually all of SGX security.
> Using attributes, enclaves can know that they are being debugged.
> Attributes also affect enclave attestation so an enclave can, for
> instance, be denied access to secrets while it is being debugged.
> 
> The kernel keeps a list of known attributes and will only
> initialize enclaves that use a known set of attributes.  This
> kernel policy eliminates the chance that a new SGX attribute
> could cause undesired effects.
> 
> For example, imagine a new attribute was added called
> "PROVISIONKEY2" that provided similar functionality to
> "PROVISIIONKEY".  A kernel policy that allowed indiscriminate use
> of unknown attributes and thus PROVISIONKEY2 would undermine the
> existing kernel policy which limits use of PROVISIONKEY enclaves.
> 
> == AEX Notify Background ==
> 
> "Intel Architecture Instruction Set Extensions and Future
> Features - Version 45" is out[2].  There is a new chapter:
> 
> 	Asynchronous Enclave Exit Notify and the EDECCSSA User Leaf Function.
> 
> Enclaves exit can be either synchronous and consensual (EEXIT for
> instance) or asynchronous (on an interrupt or fault).  The
> asynchronous ones can evidently be exploited to single step
> enclaves[1], on top of which other naughty things can be built.
> 
> AEX Notify will be made available both on upcoming processors and
> on some older processors through microcode updates.
> 
> == The Problem ==
> 
> These attacks are currently entirely opaque to the enclave since
> the hardware does the save/restore under the covers. The
> Asynchronous Enclave Exit Notify (AEX Notify) mechanism provides
> enclaves an ability to detect and mitigate potential exposure to
> these kinds of attacks.
> 
> == The Solution ==
> 
> Define the new attribute value for AEX Notification.  Ensure the
> attribute is cleared from the list reserved attributes.  Instead
> of adding to the open-coded lists of individual attributes,
> add named lists of privileged (disallowed by default) and
> unprivileged (allowed by default) attributes.  Add the AEX notify
> attribute as an unprivileged attribute, which will keep the kernel
> from rejecting enclaves with it set.
> 
> I just built this and ran it to make sure there were no obvious
> regressions since I do not have the hardware (and new microcde)
> to test it.
> 
> Testing on bare-metal and in VMs accompanied by Tested-by's
> would be much appreciated.  (This means you, Intel folks who
> actually have systems with the microcode that can do this.)
> 
> 1. https://github.com/jovanbulck/sgx-step
> 2. https://cdrdv2.intel.com/v1/dl/getContent/671368?explicitVersion=true
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Kai Huang <kai.huang@intel.com>
> Cc: Haitao Huang <haitao.huang@linux.intel.com>
> Cc: x86@kernel.org
> Cc: linux-sgx@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

I think it would make sense to have a co-maintainer with better
access to unreleased ucode patches, if anyone is willing to
consider. Perhaps someone from Intel given the constraints.

This would help with features such as AEX Notify. I can work
out issues with existing hardware and also make sure that the
whole stack is usable (as I'm also consumer for SGX).

BR, Jarkko
