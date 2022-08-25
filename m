Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D335A083E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 06:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbiHYE5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 00:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiHYE5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 00:57:39 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D2C9E123;
        Wed, 24 Aug 2022 21:57:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CA943CE2550;
        Thu, 25 Aug 2022 04:57:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D73C433D6;
        Thu, 25 Aug 2022 04:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661403454;
        bh=Pg4ZVXtnQv/FMSmoj3+68h6Hrxo+qoEdyYM3we1niEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t7OJ6QRqrLY9YNh/95dhZF7RAM+XW9Ck6lOrIZuAL6a2E7D5k5V3uJxfuWjYSMQV1
         ELAUtY0h28k0mPC8Yl0s+dA4tLmKFZahiR5t/wLFjBC9r8nxUTT0PZ7TX/xodmnDCY
         46CFeF9126ps9VlNij47FPsJDV+ovS8FpwFQUuE4i3qoMvCPc4+AIKNx+G3GilYeij
         VDBnJMbDaU8ty4YfsohSsF+L4qmF/HltjoxDwjxYR+fdR1pVW3s3O5UBGBm8sgEenQ
         8EWY4QEWD2+Y2vuYB0YIY8aBpWoVEFgcLH9Mqy3jv6JDyVG2aY106fh1LuElOrASe1
         VWaGu6TOR7QVg==
Date:   Thu, 25 Aug 2022 07:57:27 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "Chatre, Reinette" <reinette.chatre@intel.com>,
        linux-sgx@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: WARNING: CPU: 1 PID: 83 at arch/x86/kernel/cpu/sgx/main.c:446
 ksgxd+0x1b7/0x1d0
Message-ID: <YwcBN+1Q7JiYC7cb@kernel.org>
References: <ce0b4d26-3a6e-7c5a-5f66-44cba05f9f35@molgen.mpg.de>
 <4253695b-85aa-a2fb-fbf6-718db8b6c20c@molgen.mpg.de>
 <46e3483b-a5ab-2a05-8a28-f9ea87e881c3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46e3483b-a5ab-2a05-8a28-f9ea87e881c3@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 11:28:24AM -0700, Dave Hansen wrote:
> On 8/19/22 09:02, Paul Menzel wrote:
> > On the Dell XPS 13 9370, Linux 5.18.16 prints the warning below:
> > 
> > ```
> > [    0.000000] Linux version 5.18.0-4-amd64
> > (debian-kernel@lists.debian.org) (gcc-11 (Debian 11.3.0-5) 11.3.0, GNU
> > ld (GNU Binutils for Debian) 2.38.90.20220713) #1 SMP PREEMPT_DYNAMIC
> > Debian 5.18.16-1 (2022-08-10)
> > [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-5.18.0-4-amd64
> > root=UUID=56f398e0-1e25-4fda-aa9f-611dece4b333 ro quiet
> > […]
> > [    0.000000] DMI: Dell Inc. XPS 13 9370/0RMYH9, BIOS 1.21.0 07/06/2022
> > […]
> > [    0.235418] sgx: EPC section 0x40200000-0x45f7ffff
> 
> Hi Paul,
> 
> Would you be able to send the entire dmesg, along with:
> 
> 	cat /proc/iomem # (as root)
> and
> 	cpuid -1 --raw
> 
> I'm suspecting either a BIOS problem.  Reinette (cc'd) also thought this
> might be a case of the SGX initialization getting a bit too far along
> when it should have been disabled.
> 
> We had some bugs where we didn't stop fast enough after spitting out the
> "SGX Launch Control is locked..." errors.

For some reason the pages do not get properly sanitized:

	/* sanity check: */
	WARN_ON(!list_empty(&sgx_dirty_page_list));

EPC should be good, given that EREMOVE does not fail.
If SGX would be disabled, also EREMOVE should fail.

BR, Jarkko
