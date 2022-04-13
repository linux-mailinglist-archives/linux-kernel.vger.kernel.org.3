Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF524FF77C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 15:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235728AbiDMNQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 09:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiDMNQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 09:16:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54AA9219E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649855658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ptx+gd5Xcpvwi0zykl42PukCQL84p4yfvhPVM+/hh+4=;
        b=Q3o8JYwPrJgiOyLpqVwuM2RK9osN2m8IDfQkYkKBD+PEHOEZZ7ohc7mG20UF5Cw/quNg1i
        pOLO91z37kTGrVi6ir9/jBmzUyPIm8WiauDefLxhD3mDzZBOlwU8yQ/v65r8dYo77XKL25
        k77+ugq/GHt4lSuEXbZG+9yfubDMNPk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-vxbEqr8aOY2ahWnf52x2KA-1; Wed, 13 Apr 2022 09:14:15 -0400
X-MC-Unique: vxbEqr8aOY2ahWnf52x2KA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 865B18117B0;
        Wed, 13 Apr 2022 13:14:14 +0000 (UTC)
Received: from localhost (ovpn-12-51.pek2.redhat.com [10.72.12.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1108B200E21A;
        Wed, 13 Apr 2022 13:14:02 +0000 (UTC)
Date:   Wed, 13 Apr 2022 21:13:59 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v6 8/8] x86/crash: Add x86 crash hotplug support for
 kexec_load
Message-ID: <YlbMlw3WJBQN0l8W@MiWiFi-R3L-srv>
References: <20220401183040.1624-1-eric.devolder@oracle.com>
 <20220401183040.1624-9-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401183040.1624-9-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/22 at 02:30pm, Eric DeVolder wrote:
> For kexec_file_load support, the loading of the crash kernel occurs
> entirely within the kernel, and as such the elfcorehdr is readily
> identified (so that it can be modified upon hotplug events).
> 
> This change enables support for kexec_load by identifying the
> elfcorehdr segment in the arch_crash_hotplug_handler(), if it has
> not already been identified.
> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> ---
>  arch/x86/kernel/crash.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 101c030ac038..682f130b83e3 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -486,6 +486,30 @@ void arch_crash_hotplug_handler(struct kimage *image,
>  	void *elfbuf = NULL;
>  	unsigned long mem, memsz;
>  
> +	/*
> +	 * When the struct kimage is alloced, it is wiped to zero, so
> +	 * the elfcorehdr_index_valid defaults to false. It is set on the
> +	 * kexec_file_load path, or here for kexec_load, if not already
> +	 * identified.
> +	 */
> +	if (!image->elfcorehdr_index_valid) {
> +		unsigned int n;
> +
> +		for (n = 0; n < image->nr_segments; n++) {
> +			mem = image->segment[n].mem;
> +			memsz = image->segment[n].memsz;
> +			ptr = map_crash_pages(mem, memsz);
> +			if (ptr) {
> +				/* The segment containing elfcorehdr */
> +				if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
> +					image->elfcorehdr_index = (int)n;
> +					image->elfcorehdr_index_valid = true;
> +				}
> +			}
> +			unmap_crash_pages((void **)&ptr);
> +		}
> +	}
> +
>  	if (!image->elfcorehdr_index_valid) {
>  		pr_err("crash hp: unable to locate elfcorehdr segment");
>  		goto out;
> -- 
> 2.27.0
> 

