Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD374523081
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 12:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236255AbiEKKOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 06:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241945AbiEKKOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 06:14:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0C44227B69
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 03:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652264007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZL+idh8z82yGfceUpUMDcLt25Q+LynjrWsRec67ynZc=;
        b=KbhDJUEovVpine+4H2+jv/WLr2Q6aVuJWgWWV9m4O8jF328sQ0gEpTamXK+t2hRxhwUugm
        z1YNaJRWLkJ+F6wpvUyWHum4ZrbF72BU1dk+IBmbeNQ2/fQeHl3CBUIy4fdJ8h2DV0Hw2d
        Dr6/aaPbI8Qu1V0Mq9Wja9oJVHkf7bI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-NPXEhp-JM5uUgxxvhIbx-w-1; Wed, 11 May 2022 06:13:24 -0400
X-MC-Unique: NPXEhp-JM5uUgxxvhIbx-w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CEA04800882;
        Wed, 11 May 2022 10:13:23 +0000 (UTC)
Received: from localhost (ovpn-13-194.pek2.redhat.com [10.72.13.194])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 592091121314;
        Wed, 11 May 2022 10:13:15 +0000 (UTC)
Date:   Wed, 11 May 2022 18:13:09 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v8 5/7] kexec: exclude hot remove cpu from elfcorehdr
 notes
Message-ID: <20220511101309.GI122876@MiWiFi-R3L-srv>
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <20220505184603.1548-6-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505184603.1548-6-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/22 at 02:46pm, Eric DeVolder wrote:
> Due to use of CPUHP_AP_ONLINE_DYN, upon CPU unplug, the CPU is
> still in the for_each_present_cpu() list when within the
> handle_hotplug_event(). Thus the CPU must be explicitly excluded
> when building the new list of CPUs.
> 
> This change identifies in handle_hotplug_event() the CPU to be
> excluded, and the check for excluding the CPU in
> crash_prepare_elf64_headers().
> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> ---
>  kernel/crash_core.c | 10 ++++++++++
>  kernel/kexec_file.c |  5 +++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index f197af50def6..7ba43f058d82 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -520,6 +520,16 @@ static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
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
> +				cpu : KEXEC_CRASH_HP_INVALID_CPU;
> +
>  		/* Now invoke arch-specific update handler */
>  		arch_crash_handle_hotplug_event(kexec_crash_image, hp_action, cpu);
>  
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index aacdf93c3507..d68e5769b428 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -1314,6 +1314,11 @@ int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
>  
>  	/* Prepare one phdr of type PT_NOTE for each present CPU */
>  	for_each_present_cpu(cpu) {
> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
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

