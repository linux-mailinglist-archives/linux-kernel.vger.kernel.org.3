Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CA24C0AC7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 05:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238053AbiBWEBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 23:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiBWEBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 23:01:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 812E6654B9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 20:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645588881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YzQtzaVO1Z4U7y1IenZT534HvM8HDX/vO3aOxWE8Xpc=;
        b=T4yWZ8IsEkWa6ChCEIsz3kkbIGXaFQjNizxi673aGNIM3zSycWu5Alna+L+R3cZRCFKBrI
        Gxb5p2HiduyESAFryBRcBkoe6RBuDyVYCBoYZ+RwzmwPKkeVnb3F9pxbU+FW+ef19LNYee
        ipj/FMBs4KcfGQRo4d12NIm+65eehWU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-CYAJtxUOOMaCIAG_UD0N-A-1; Tue, 22 Feb 2022 23:01:18 -0500
X-MC-Unique: CYAJtxUOOMaCIAG_UD0N-A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1631F800425;
        Wed, 23 Feb 2022 04:01:16 +0000 (UTC)
Received: from localhost (ovpn-14-1.pek2.redhat.com [10.72.14.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9642370129;
        Wed, 23 Feb 2022 04:00:59 +0000 (UTC)
Date:   Wed, 23 Feb 2022 12:00:57 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v4 07/10] crash hp: exclude elfcorehdr from the segment
 digest
Message-ID: <YhWxeSG3GfJwOGOV@MiWiFi-R3L-srv>
References: <20220209195706.51522-1-eric.devolder@oracle.com>
 <20220209195706.51522-8-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209195706.51522-8-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
> When a crash kernel is loaded via the kexec_file_load syscall, the
> kernel places the various segments (ie crash kernel, crash initrd,
> boot_params, elfcorehdr, purgatory, etc) in memory. For those
> architectures that utilize purgatory, a hash digest of the segments
> is calculated for integrity checking. This digest is embedded into
> the purgatory image prior to placing purgatory in memory.
> 
> Since hotplug events cause changes to the elfcorehdr, purgatory
> integrity checking fails (at crash time, and no kdump created).
> As a result, this change explicitly excludes the elfcorehdr segment
> from the list of segments used to create the digest. By doing so,
> this permits changes to the elfcorehdr in response to hotplug events,
> without having to also reload purgatory due to the change to the
> digest.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>  kernel/kexec_file.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 801d0d0a5012..93bb0c0ce66c 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -765,6 +765,12 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  	for (j = i = 0; i < image->nr_segments; i++) {
>  		struct kexec_segment *ksegment;
>  
> +#ifdef CONFIG_CRASH_HOTPLUG
> +		/* This segment excluded to allow future changes via hotplug */
> +		if (image->elf_index_valid && (j == image->elf_index))
> +			continue;
> +#endif
> +
>  		ksegment = &image->segment[i];
>  		/*
>  		 * Skip purgatory as it will be modified once we put digest
> -- 
> 2.27.0
> 

