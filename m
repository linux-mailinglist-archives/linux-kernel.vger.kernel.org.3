Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109DE50046C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 04:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239626AbiDNCvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 22:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239587AbiDNCvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 22:51:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D14BE1FCE7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 19:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649904518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2IYtH+7P1kPtyVJEIQCs8Bz8HaKNDlGQTLQHNn1c+YA=;
        b=I/nzM9jPtMi0UdWhJ0sRKbrdWCrGRbv6EwqhyCtiVL8k6Nf+6AyyNavNDrskivYxEaZdm7
        DcZjbbJQPq9qPBuKMavcGn9nYcbbHVCFIR+8CX0L/1KhS3L2I4fq4i5SBNdWuvQj26+DNR
        AWnZXXnEJkMbtuaRPTelbl9t0oS7WM0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279-EhFkcpnFMAmahWvFh1PTjw-1; Wed, 13 Apr 2022 22:48:34 -0400
X-MC-Unique: EhFkcpnFMAmahWvFh1PTjw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D0BA29DD9AF;
        Thu, 14 Apr 2022 02:48:34 +0000 (UTC)
Received: from localhost (ovpn-13-186.pek2.redhat.com [10.72.13.186])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 674F2145B97B;
        Thu, 14 Apr 2022 02:48:33 +0000 (UTC)
Date:   Thu, 14 Apr 2022 10:48:30 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v7 6/8] kexec: exclude hot remove cpu from elfcorehdr
 notes
Message-ID: <YleLfoQcDXnlB/ZW@MiWiFi-R3L-srv>
References: <20220413164237.20845-1-eric.devolder@oracle.com>
 <20220413164237.20845-7-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413164237.20845-7-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/13/22 at 12:42pm, Eric DeVolder wrote:
> Due to use of CPUHP_AP_ONLINE_DYN, upon CPU unplug, the CPU is
> still in the for_each_present_cpu() list when within the
> crash_hotplug_handler(). Thus the CPU must be explicitly excluded
> when building the new list of CPUs.
> 
> This change identifies in crash_hotplug_handler() the CPU to be
> excluded, and the check for excluding the CPU in
> crash_prepare_elf64_headers().
> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> Acked-by: Baoquan He <bhe@redhat.com>

This patch is updated, the old ack should be removed. It looks better to
put the offlinecpu assignment here.

Ack it again.

Acked-by: Baoquan He <bhe@redhat.com>

> ---
>  kernel/crash_core.c | 9 +++++++++
>  kernel/kexec_file.c | 5 +++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index ecf746243ab2..036243b1f252 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -521,6 +521,15 @@ static void crash_hotplug_handler(unsigned int hp_action,
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
> +			(hp_action == KEXEC_CRASH_HP_REMOVE_CPU) ? cpu : ~0U;
> +
>  		/* Now invoke arch-specific update handler */
>  		arch_crash_hotplug_handler(kexec_crash_image, hp_action, cpu);
>  
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 94a459209111..9d5c4eea0179 100644
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

