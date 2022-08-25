Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DFA5A0B9F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbiHYIfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbiHYIfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:35:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB0E76949;
        Thu, 25 Aug 2022 01:34:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85722B826A7;
        Thu, 25 Aug 2022 08:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED436C433D6;
        Thu, 25 Aug 2022 08:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661416495;
        bh=QGpTCX8/HfN5hvQze+1GDH+74QUwhn3lQzXYB2SxQr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bCmqXkhg3IBspMymlihwn/ikInT5yG/azkc9HMiuRjeKQKZ678G97a+wMasT0lE3N
         gKK+ltUSN0jgnF2GkxIT+c/CiUPHeyC2/Nhr3ja/jRQAetHisu8ALxZS4N6KomqTm9
         tEaq71Gd4/4STvDx4eMG+JTcUTvKspf8IHw9D0jDy77WOJnMLbrCEgPSrf/pQVmYtC
         0l7qREbbdbflear2clSSjqDiQRd6JM64A9X44WaTLkdUknxX3mrSgmcb/qGzEqi/wR
         h4nY0tVyi1pTjcKcU7niKEcrhD+iQY12s1hy3swTy6O7EGrVbNeD4+Vd1w7oqikE7e
         n+167m4n4j85g==
Date:   Thu, 25 Aug 2022 11:34:48 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Haitao Huang <haitao.huang@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Reinette Chatre <reinette.chatre@intel.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>, linux-sgx@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: WARNING: CPU: 1 PID: 83 at arch/x86/kernel/cpu/sgx/main.c:446
 ksgxd+0x1b7/0x1d0
Message-ID: <Ywc0KNYSm4sc+lnq@kernel.org>
References: <ce0b4d26-3a6e-7c5a-5f66-44cba05f9f35@molgen.mpg.de>
 <4253695b-85aa-a2fb-fbf6-718db8b6c20c@molgen.mpg.de>
 <46e3483b-a5ab-2a05-8a28-f9ea87e881c3@intel.com>
 <04c9d5fa-5861-bbc3-3e2f-e18a73866645@molgen.mpg.de>
 <63a60042-4a4a-3bc3-5fa1-4495d80cc06c@molgen.mpg.de>
 <op.1rfpqgjrwjvjmi@hhuan26-mobl1.mshome.net>
 <YwcNfpLpzk8EIT88@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YwcNfpLpzk8EIT88@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 08:49:53AM +0300, Jarkko Sakkinen wrote:
> On Wed, Aug 24, 2022 at 09:12:06PM -0500, Haitao Huang wrote:
> > Hi Paul
> > 
> > On Tue, 23 Aug 2022 08:48:52 -0500, Paul Menzel <pmenzel@molgen.mpg.de>
> > wrote:
> > 
> > > Dear Dave,
> > > 
> > > 
> > > Am 20.08.22 um 08:13 schrieb Paul Menzel:
> > > 
> > > > Am 19.08.22 um 20:28 schrieb Dave Hansen:
> > > > > On 8/19/22 09:02, Paul Menzel wrote:
> > > > > > On the Dell XPS 13 9370, Linux 5.18.16 prints the warning below:
> > > > > > 
> > > > > > ```
> > > > > > [    0.000000] Linux version 5.18.0-4-amd64
> > > > > > (debian-kernel@lists.debian.org) (gcc-11 (Debian 11.3.0-5)
> > > > > > 11.3.0, GNU ld (GNU Binutils for Debian) 2.38.90.20220713)
> > > > > > #1 SMP PREEMPT_DYNAMIC Debian 5.18.16-1 (2022-08-10)
> > > > > > [    0.000000] Command line:
> > > > > > BOOT_IMAGE=/vmlinuz-5.18.0-4-amd64
> > > > > > root=UUID=56f398e0-1e25-4fda-aa9f-611dece4b333 ro quiet
> > > > > > […]
> > > > > > [    0.000000] DMI: Dell Inc. XPS 13 9370/0RMYH9, BIOS
> > > > > > 1.21.0 07/06/2022
> > > > > > […]
> > > > > > [    0.235418] sgx: EPC section 0x40200000-0x45f7ffff
> > > > 
> > > > > Would you be able to send the entire dmesg, along with:
> > > >  The log message are attached to the first message, where I missed
> > > > to carbon-copy linux-sgx@ [1].
> > > > 
> > > > >     cat /proc/iomem # (as root)
> > > > > and
> > > > >     cpuid -1 --raw
> > > >  I am going to provide that next week. (Side note, Intel might have
> > > > some Dell XPS 9370 test machines in some QA lab.)
> > > 
> > > Please find both outputs at the end of the file.
> > > 
> > 
> > Could you also check output of "sudo rdmsr -x 0x3a"?
> > Also was CONFIG_X86_SGX_KVM set?
> > 
> > If CONFIG_X86_SGX_KVM is not set and bit 17 (SGX_LC) of the MSR 3A not set,
> > then I think following sequence during sgx_init is possible:
> > 
> > sgx_page_cache_init -> sgx_setup_epc_section
> >                        ->put all physical EPC pages in sgx_dirty_page_list.
> > Kick off ksgxd.
> > Later, sgx_drv_init returns none-zero due to this check:
> >     if (!cpu_feature_enabled(X86_FEATURE_SGX_LC))
> >         return -ENODEV;
> > sgx_vepc_init also returns none-zero if CONFIG_X86_SGX_KVM was not set.
> > 
> > And sgx_init will call kthread_stop(ksgxd_tsk):
> >     ret = sgx_drv_init();
> > 
> >     if (sgx_vepc_init() && ret)
> >         goto err_provision;
> > ...
> > err_provision:
> >     misc_deregister(&sgx_dev_provision);
> > 
> > err_kthread:
> >     kthread_stop(ksgxd_tsk);
> > 
> > 
> > That triggers __sgx_sanitize_pages return early due to these lines:
> >     /* dirty_page_list is thread-local, no need for a lock: */
> >     while (!list_empty(dirty_page_list)) {
> >         if (kthread_should_stop())
> >             return;
> > 
> > And that would trigger (depends on timing?) the warning in ksgxd due to
> > non-empty sgx_dirty_page_list
> > at that moment.
> 
> You're correct, and it's not a bug but completely legit behaviour.
> 
> And given that non-empty dirty page list is legit behavior WARN_ON()
> is not what should be used in here.
> 
> Fix coming in a bit.

https://lore.kernel.org/linux-sgx/20220825080802.259528-1-jarkko@kernel.org/T/#u

BR, Jarkko
