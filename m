Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B254C0AA6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 04:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236694AbiBWDoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 22:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiBWDn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:43:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49EC4606D0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 19:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645587812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q9U/EQUtsq8zq02Ou6EkIRfkqNfsRx54212UYgYxfY4=;
        b=QyVSIrVI9XYouDT2/LbljM6BshSh770+0/u8gLb5HI7HiGa+IyiQHW+/eCSNYnMDJI/Yyt
        iOniSvQWMxlBno1qvagM8BKvk9ZFCXIomlJ5A+5medUavkn3aDgyoRnS/Vx1vfysbr9SK8
        O1IsENJs2HR8F1OlpyWUvGMQpx5VcQM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-464-sGKCFAQOMX29HomZtDACMg-1; Tue, 22 Feb 2022 22:43:31 -0500
X-MC-Unique: sGKCFAQOMX29HomZtDACMg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15D06180FD71;
        Wed, 23 Feb 2022 03:43:29 +0000 (UTC)
Received: from localhost (ovpn-14-1.pek2.redhat.com [10.72.14.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5657AE717;
        Wed, 23 Feb 2022 03:43:08 +0000 (UTC)
Date:   Wed, 23 Feb 2022 11:43:05 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v4 03/10] crash hp: definitions and prototype changes
Message-ID: <YhWtSWbKbr6aLezO@MiWiFi-R3L-srv>
References: <20220209195706.51522-1-eric.devolder@oracle.com>
 <20220209195706.51522-4-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209195706.51522-4-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/22 at 02:56pm, Eric DeVolder wrote:
> This change adds members to struct kimage to facilitate crash
> hotplug support.
> 
> This change also defines crash hotplug events and associated
> prototypes.
> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>  include/linux/kexec.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 0c994ae37729..13c238c2da48 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -299,6 +299,13 @@ struct kimage {
>  
>  	/* Information for loading purgatory */
>  	struct purgatory_info purgatory_info;
> +
> +#ifdef CONFIG_CRASH_HOTPLUG
> +	bool hotplug_event;
> +	int offlinecpu;
> +	bool elf_index_valid;
> +	int elf_index;
> +#endif
>  #endif
>  
>  #ifdef CONFIG_IMA_KEXEC
> @@ -315,6 +322,15 @@ struct kimage {
>  	unsigned long elf_load_addr;
>  };
>  
> +#ifdef CONFIG_CRASH_HOTPLUG
> +void arch_crash_hotplug_handler(struct kimage *image,
> +	unsigned int hp_action, unsigned long a, unsigned long b);

Seems this patch can be merged with patch 6/10. I don't see prototype
change in this patch.

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

