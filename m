Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C475A086F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 07:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbiHYF1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 01:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbiHYF1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 01:27:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EFD9E699;
        Wed, 24 Aug 2022 22:27:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5F04B826BE;
        Thu, 25 Aug 2022 05:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A04C433C1;
        Thu, 25 Aug 2022 05:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661405236;
        bh=55WRc3r81+KqehUFDPLaZGPRJj5RndzvHEoTp5C4cUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wks7HLeB6uGcDRapulU6NwmStjzpVhsK9gujc8f2S0Q4CWpk6Pp97tbPQ7OxmtDBD
         y9nAe+DJDvtUGsYkcpWAtSviKMtgoDQjtpAoa/X+tdCa2YriTAMbGIGtLokp2l4RbS
         WQluyX38oEvP7uYH5TJ+cx41dsj1kpHmHdwwDIZ3WGxiybxA9ls0r7ju5dR/jysPMs
         PocbQb29KGNWwGjZDKRMafa990NQwyTEV9gB7RhFZPGZucjkJl9WA3Cv5pxkjbftpu
         CiCWd8Hmhepum/jTvWlSWN77h46EVn0rAz3SbIw+muRW1UhrLY2paWeLDsjOQyQRLg
         v7itMfvH40+cw==
Date:   Thu, 25 Aug 2022 08:27:09 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Reinette Chatre <reinette.chatre@intel.com>,
        linux-sgx@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: WARNING: CPU: 1 PID: 83 at arch/x86/kernel/cpu/sgx/main.c:446
 ksgxd+0x1b7/0x1d0
Message-ID: <YwcILSTYBMnig4uF@kernel.org>
References: <ce0b4d26-3a6e-7c5a-5f66-44cba05f9f35@molgen.mpg.de>
 <4253695b-85aa-a2fb-fbf6-718db8b6c20c@molgen.mpg.de>
 <46e3483b-a5ab-2a05-8a28-f9ea87e881c3@intel.com>
 <04c9d5fa-5861-bbc3-3e2f-e18a73866645@molgen.mpg.de>
 <63a60042-4a4a-3bc3-5fa1-4495d80cc06c@molgen.mpg.de>
 <beabe16c-b28b-cd65-f6b6-4242bc74926d@intel.com>
 <33c2a495-13ad-97ac-f2c2-4096cf8f5b58@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33c2a495-13ad-97ac-f2c2-4096cf8f5b58@molgen.mpg.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 12:33:07AM +0200, Paul Menzel wrote:
> Dear Dave,
> 
> 
> Thank you for your reply.
> 
> Am 23.08.22 um 18:32 schrieb Dave Hansen:
> > On 8/23/22 06:48, Paul Menzel wrote:
> > > > > I'm suspecting either a BIOS problem.  Reinette (cc'd) also thought this
> > > > > might be a case of the SGX initialization getting a bit too far along
> > > > > when it should have been disabled.
> > > > > 
> > > > > We had some bugs where we didn't stop fast enough after spitting out the
> > > > > "SGX Launch Control is locked..." errors.
> > > 
> > > Let’s hope it’s something known to you.
> > 
> > Thanks for the extra debug info.  Unfortunately, nothing is really
> > sticking out as an obvious problem.
> > 
> > The EREMOVE return codes would be interesting to know, as well as an
> > idea what the physical addresses are that fail and the _counts_ of how
> > many pages get sanitized versus fail.
> 
> Is there a knob to print out this information? Or way to get this
> information using ftrace? I’d like to avoid rebuilding the Linux kernel.

Since __sgx_sanitize_pages() is a local symbol, it's not possible
to attach kprobe into it, so we actually do require a code change
to see inside.

BR, Jarkko
