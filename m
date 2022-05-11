Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F7652305C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 12:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240994AbiEKKLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 06:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241716AbiEKKLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 06:11:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B3221EECD
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 03:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652263882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XCj2Z97ce7GQjTbLjIuBVzSR6XFl1tJ+PE4XNz6XBww=;
        b=Txn213msIX50CiVHBQiQAFU1xhv8E/9DNY+xZ2SX915XHBWLfngL0CVRbg6mVknWe/hyNo
        EixOFDVGfg63eYT7708n/vFQcwSFi5NONuxJyO3CvwXOqiU2bI0fiVaLhS2sFmh7fTBzMi
        7jZ+9TKhO/Yzec7fAlYJQ9mjE98urs8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-hZ9xVXK-NJuX0P10ylegXw-1; Wed, 11 May 2022 06:11:18 -0400
X-MC-Unique: hZ9xVXK-NJuX0P10ylegXw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A8B24811E75;
        Wed, 11 May 2022 10:11:17 +0000 (UTC)
Received: from localhost (ovpn-13-194.pek2.redhat.com [10.72.13.194])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D1E89400E115;
        Wed, 11 May 2022 10:11:16 +0000 (UTC)
Date:   Wed, 11 May 2022 18:11:13 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v8 4/7] kexec: exclude elfcorehdr from the segment digest
Message-ID: <20220511101113.GH122876@MiWiFi-R3L-srv>
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <20220505184603.1548-5-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505184603.1548-5-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
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

Remember I acked this one. Seems that is dropped, assuming no change is
made since v7. Anyway,

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>  kernel/kexec_file.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 801d0d0a5012..aacdf93c3507 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -765,6 +765,12 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  	for (j = i = 0; i < image->nr_segments; i++) {
>  		struct kexec_segment *ksegment;
>  
> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> +		/* This segment excluded to allow future changes via hotplug */
> +		if (image->elfcorehdr_index_valid && (j == image->elfcorehdr_index))
> +			continue;
> +#endif
> +
>  		ksegment = &image->segment[i];
>  		/*
>  		 * Skip purgatory as it will be modified once we put digest
> -- 
> 2.27.0
> 

