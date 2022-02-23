Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B36D4C0AC8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 05:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237177AbiBWEFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 23:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiBWEFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 23:05:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E08AD6663E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 20:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645589078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eJF0wow5NREQJKs6cXxre87VWpZhgMJGm8H995FYX4w=;
        b=DjvNB3uQ80zxcV2vTIxbv/qG65pFZ0Ib66+iLs1zSJFVKwxh1VwZijKSHmTjwinVcifhoh
        VTmIZwH/hvwfdS8MMTfwR2Qah1M7fGSjPiWfYFNFCNeTR0ZHx3O3HITe03sZzfkNKRq/Hw
        RGXXxcfiCbbU6cgvZpzJcpYwKxqOc3s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-161-8gB86jm1MUqS5-XeobdXBg-1; Tue, 22 Feb 2022 23:04:34 -0500
X-MC-Unique: 8gB86jm1MUqS5-XeobdXBg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A2B1801AAD;
        Wed, 23 Feb 2022 04:04:32 +0000 (UTC)
Received: from localhost (ovpn-14-1.pek2.redhat.com [10.72.14.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8046D5E267;
        Wed, 23 Feb 2022 04:04:28 +0000 (UTC)
Date:   Wed, 23 Feb 2022 12:04:25 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v4 08/10] crash hp: exclude hot remove cpu from
 elfcorehdr notes
Message-ID: <YhWySYFks0qwk2JB@MiWiFi-R3L-srv>
References: <20220209195706.51522-1-eric.devolder@oracle.com>
 <20220209195706.51522-9-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209195706.51522-9-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/22 at 02:57pm, Eric DeVolder wrote:
> Due to use of CPUHP_AP_ONLINE_DYN, upon CPU unplug, the CPU is
> still in the for_each_present_cpu() list when within the
> crash_hotplug_handler(). Thus the CPU must be explicitly excluded
> when building the new list of CPUs.
> 
> This change identifies in crash_hotplug_handler() the CPU to be
> excluded, and the check for excluding the CPU in
> crash_prepare_elf64_headers().

This looks good to me, and the particularity of cpu hotplug can be
understood well by other code reader. Thanks.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>  kernel/crash_core.c | 10 ++++++++++
>  kernel/kexec_file.c |  5 +++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 524470e18883..b6942e04a188 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -550,6 +550,16 @@ static void crash_hotplug_handler(unsigned int hp_action,
>  		/* Flag to differentiate between normal load and hotplug */
>  		kexec_crash_image->hotplug_event = true;
>  
> +		/*
> +		 * Due to use of CPUHP_AP_ONLINE_DYN, upon unplug and during
> +		 * this callback, the CPU is still in the for_each_present_cpu()
> +		 * list. Must explicitly look to exclude this CPU when building
> +		 * new list.
> +		 */
> +		kexec_crash_image->offlinecpu =
> +			(hp_action == KEXEC_CRASH_HP_REMOVE_CPU) ?
> +				(unsigned int)a : ~0U;
> +
>  		/* Now invoke arch-specific update handler */
>  		arch_crash_hotplug_handler(kexec_crash_image, hp_action, a, b);
>  
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 93bb0c0ce66c..339995d42169 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -1314,6 +1314,11 @@ int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
>  
>  	/* Prepare one phdr of type PT_NOTE for each present CPU */
>  	for_each_present_cpu(cpu) {
> +#ifdef CONFIG_CRASH_HOTPLUG
> +		/* Skip the soon-to-be offlined cpu */
> +		if (image->hotplug_event && (cpu == image->offlinecpu))
> +			continue;
> +#endif
>  		phdr->p_type = PT_NOTE;
>  		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
>  		phdr->p_offset = phdr->p_paddr = notes_addr;
> -- 
> 2.27.0
> 

