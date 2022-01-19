Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512C049364F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352456AbiASI13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:27:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24428 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352447AbiASI12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:27:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642580847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6HfB/CCibhN76Cw5SwhZEDbSHmGjrJsGRZEl273e4Qw=;
        b=KnEwe1oTV3kvBNGjj/OkMWtMz1VuUQQDNy0FQGC79QWPtQDJOiyUErBmVynaWHO4oW6900
        fDjFL8H1ky7oItnZ8ntPY3L5g364CvzvmA7mKRI4AJhSX2/aMbbjvBOEIPSv7m8r5ggZtc
        xOZTytvsR8XkcqeSEo5C1vy+UQDazDQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-375-dKLtk-rbNmGJpfr8Z28wbw-1; Wed, 19 Jan 2022 03:27:24 -0500
X-MC-Unique: dKLtk-rbNmGJpfr8Z28wbw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3060E1006AA7;
        Wed, 19 Jan 2022 08:27:22 +0000 (UTC)
Received: from localhost (ovpn-12-206.pek2.redhat.com [10.72.12.206])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A4A0A5E4BB;
        Wed, 19 Jan 2022 08:26:48 +0000 (UTC)
Date:   Wed, 19 Jan 2022 16:26:45 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v3 3/6] crash hp: definitions and prototype changes
Message-ID: <20220119082645.GA6349@MiWiFi-R3L-srv>
References: <20220110195727.1682-1-eric.devolder@oracle.com>
 <20220110195727.1682-4-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110195727.1682-4-eric.devolder@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/22 at 02:57pm, Eric DeVolder wrote:
> This change adds members to struct kimage to facilitate crash
> hotplug support.
> 
> This change also defines crash hotplug events and associated
> prototypes.
> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>  include/linux/kexec.h | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 0c994ae37729..068f853f1c65 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -221,8 +221,9 @@ struct crash_mem {
>  extern int crash_exclude_mem_range(struct crash_mem *mem,
>  				   unsigned long long mstart,
>  				   unsigned long long mend);
> -extern int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
> -				       void **addr, unsigned long *sz);
> +extern int crash_prepare_elf64_headers(struct kimage *image,
> +					struct crash_mem *mem, int kernel_map,
> +					void **addr, unsigned long *sz);
>  #endif /* CONFIG_KEXEC_FILE */
>  
>  #ifdef CONFIG_KEXEC_ELF
> @@ -299,6 +300,13 @@ struct kimage {
>  
>  	/* Information for loading purgatory */
>  	struct purgatory_info purgatory_info;
> +
> +#ifdef CONFIG_CRASH_HOTPLUG
> +	bool hotplug_event;
> +	int offlinecpu;
> +	bool elf_index_valid;
> +	int elf_index;

Do we really need elf_index_valid? Can we initialize elf_index to , e.g '-1',
then check if the value is valid?

> +#endif
>  #endif
>  
>  #ifdef CONFIG_IMA_KEXEC
> @@ -315,6 +323,15 @@ struct kimage {
>  	unsigned long elf_load_addr;
>  };
>  
> +#ifdef CONFIG_CRASH_HOTPLUG
> +void arch_crash_hotplug_handler(struct kimage *image,
> +	unsigned int hp_action, unsigned long a, unsigned long b);
> +#define KEXEC_CRASH_HP_REMOVE_CPU   0
> +#define KEXEC_CRASH_HP_ADD_CPU      1
> +#define KEXEC_CRASH_HP_REMOVE_MEMORY 2
> +#define KEXEC_CRASH_HP_ADD_MEMORY   3
> +#endif /* CONFIG_CRASH_HOTPLUG */
> +
>  /* kexec interface functions */
>  extern void machine_kexec(struct kimage *image);
>  extern int machine_kexec_prepare(struct kimage *image);
> -- 
> 2.27.0
> 

