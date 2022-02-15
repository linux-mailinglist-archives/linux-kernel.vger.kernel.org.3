Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FD94B6E6F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbiBOOLG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Feb 2022 09:11:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiBOOLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:11:05 -0500
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE047D2AB;
        Tue, 15 Feb 2022 06:10:55 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id v186so56458626ybg.1;
        Tue, 15 Feb 2022 06:10:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xHfL1XY2GV6QdZjIkT4vEos4l6sqpCi5W/kB5ImUf2I=;
        b=wnzmPXUvPcJ3683Ztz3p4zLPfMTTG/bb8eWY++hxELKDoT6zzqN0s2jirNyjljnSH1
         XKcpCqCdVbf4FVZ7JO7uzipctkQniwFpkd1vWA0kBt2CrddXBnp+CeEIy1hnEfWYBCVY
         Zxp8DfoRdSxJRf+FsKjSsXEcIccEgLqFNW1jGxOg4sX/RW8V2yRhjckkjDJDSWUDzbBD
         wMjxtDS6ftC9yn/DiX/XM80hP16OwZsR7MfDklm1fepwNt8VNuxM6OOIY/1vvvDXkq+U
         58A7ytNAB7DIBjyiU4DdpIHOBaj18TmBjoMMoMa5cCqmITtDVg/K5yxUnqcOviBjR6JC
         lY5w==
X-Gm-Message-State: AOAM533j8oAm+Xvy6xGBCW+G8WP6hK53dsK+QxPOCoqD0d51Ii0XA/yf
        zD9EEF5osp0ozaGKyaysEwyoUBk6nQlB88BO7lo=
X-Google-Smtp-Source: ABdhPJyzKs4yuHR0FjNoP2vBK2JooJ+jaKb9zNbBcgSMbloPOXlk3Ph/57kK0MjTlHGlf9VIII46DM2AyYGoEq0H1eg=
X-Received: by 2002:a81:1f0b:: with SMTP id f11mr3887472ywf.149.1644934254475;
 Tue, 15 Feb 2022 06:10:54 -0800 (PST)
MIME-Version: 1.0
References: <20220121103938.2602637-1-amadeuszx.slawinski@linux.intel.com>
 <59ef4cd5-5703-2356-c893-9858985f91e0@intel.com> <f6e5f716-f191-c126-cc81-cf872ad4e750@linux.intel.com>
In-Reply-To: <f6e5f716-f191-c126-cc81-cf872ad4e750@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Feb 2022 15:10:43 +0100
Message-ID: <CAJZ5v0jV5H9a66utA5Ch--X2iiV-MOSmX6CVL6s+veYpzOaezg@mail.gmail.com>
Subject: Re: [PATCH] x86: Preserve ACPI memory area during hibernation
To:     =?UTF-8?B?QW1hZGV1c3ogU8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 1:22 PM Amadeusz Sławiński
<amadeuszx.slawinski@linux.intel.com> wrote:
>
> On 2/14/2022 8:34 PM, Rafael J. Wysocki wrote:
> > On 1/21/2022 11:39 AM, Amadeusz Sławiński wrote:
> >> When overriding NHLT ACPI-table tests show that on some platforms
> >> there is problem that NHLT contains garbage after hibernation/resume
> >> cycle.
> >>
> >> Problem stems from the fact that ACPI override performs early memory
> >> allocation using memblock_phys_alloc_range() in
> >> memblock_phys_alloc_range(). This memory block is later being marked as
> >> ACPI memory block in arch_reserve_mem_area(). Later when memory areas
> >> are considered for hibernation it is being marked as nosave in
> >> e820__register_nosave_regions().
> >>
> >> Fix this by skipping ACPI memory area altogether when considering areas
> >> to mark as nosave.
> >
> > This patch looks correct to me and I'm going to apply it as 5.18
> > material unless there are any objections or concerns (in which case
> > please let me know).
> >
> >
>
> Well, what do you know? I've checked with validation team to make sure
> that it works as expected and while it causes no problem on almost all
> platforms and fixes problem with NHLT ACPI-table override, there is this
> one platform where it causes oops on hibernation which of course is gone
> after reverting the patch.
>
>   ? set_direct_map_default_noflush+0x130/0x130
>   ? memory_bm_test_bit+0x29/0x60
>   saveable_page+0xce/0xf2
>   count_data_pages+0x50/0x76
>   hibernate_preallocate_memory+0x9c/0x377
>   ? __mutex_lock_slowpath+0x20/0x20
>   hibernation_snapshot+0x1cf/0x610
>   snapshot_ioctl+0x3d2/0x690
>   ? snapshot_release+0xd0/0xd0
>   ? new_sync_write+0x36b/0x390
>   __x64_sys_ioctl+0x6dc/0xe20
>   ? vfs_fileattr_set+0x520/0x520
>   ? _raw_read_unlock+0x2a/0x50
>   ? __kasan_check_read+0x11/0x20
>   ? vfs_write+0x131/0x3d0
>   ? ksys_write+0x13b/0x170
>   ? debug_smp_processor_id+0x17/0x20
>   ? fpregs_assert_state_consistent+0x5f/0x70
>   ? exit_to_user_mode_prepare+0x3e/0x170
>   do_syscall_64+0x43/0x90
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> Above trace points at functions using pfn, so I suspect there may be
> need for some additional checks, but I will need to investigate.
> I guess you can skip this patch for now, until I figure what exactly is
> going on.

I'll do that, thanks!
