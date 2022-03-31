Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872834ED842
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 13:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbiCaLMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 07:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbiCaLMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 07:12:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A33404BB9C
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 04:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648725024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gYiG+zrQ7bvd1JeHBYiSlrjQIazTX9E1fix0Lyjk3A4=;
        b=WigqcBlA+sA25ivn7roJ9LoyGzz+5dTwqr8XnAuDGOiCv+F8GeK+oe/PJK3GWB1FmlclKe
        cpVSX6dbKfQLl9NgNru8ElfSzloQy6Wt9SlHvlF9goaXPBIzgcj+XL3tlvNO657TotvF0a
        uwo9oDUCeFTUANRI9MUIo2pZFLGfvwY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-253-ATMD9QDIOGagmWYxElrslw-1; Thu, 31 Mar 2022 07:10:21 -0400
X-MC-Unique: ATMD9QDIOGagmWYxElrslw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A407E80159B;
        Thu, 31 Mar 2022 11:10:20 +0000 (UTC)
Received: from localhost (ovpn-13-26.pek2.redhat.com [10.72.13.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 57C4B40D0160;
        Thu, 31 Mar 2022 11:10:19 +0000 (UTC)
Date:   Thu, 31 Mar 2022 19:10:15 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v5 8/8] x86/crash: Add x86 crash hotplug support for
 kexec_load
Message-ID: <YkWMFzxJpkiTjKvL@MiWiFi-R3L-srv>
References: <20220303162725.49640-1-eric.devolder@oracle.com>
 <20220303162725.49640-9-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303162725.49640-9-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/22 at 11:27am, Eric DeVolder wrote:
> For kexec_file_load support, the loading of the crash kernel occurs
> entirely within the kernel, and as such the elfcorehdr is readily
> identified (so that it can be modified upon hotplug events).
> 
> This change enables support for kexec_load by identifying the
> elfcorehdr segment in the arch_crash_hotplug_handler(), if it has
> not already been identified.
> 
> In general, support for kexec_load requires corresponding changes
> to the userspace kexec-tools utility. It is the responsibility of
> the userspace kexec utility to ensure that:
>  - the elfcorehdr segment is sufficiently large enough to accommodate
>    hotplug changes, ala CRASH_HOTPLUG_ELFCOREHDR_SZ.
>  - provides a purgatory that excludes the elfcorehdr from its list of
>    run-time segments to check.
> These changes to the userspace kexec utility are available, but not
> yet accepted upstream.

These backgroud information should be put in cover letter, or in patch
where they won't be grabbed into the final commit log. 

> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
Here, if you want to put some status or backgroud information and expect
they are not got into log, this is a appropriate place.


>  arch/x86/kernel/crash.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 5da30e2bc780..45cc6e3af63e 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -486,6 +486,32 @@ void arch_crash_hotplug_handler(struct kimage *image,
>  	void *elfbuf = NULL;
>  	unsigned long mem, memsz;
>  
> +	/*
> +	 * When the struct kimage is alloced, it is wiped to zero, so
> +	 * the elf_index_valid defaults to false. It is set on the
> +	 * kexec_file_load path, or here for kexec_load.

         I would make the last line as:
	 kexec_file_load path, or here for kexec_load if not already
         identified..

> +	 */
> +	if (!image->elf_index_valid) {
> +		unsigned int n;
> +
> +		for (n = 0; n < image->nr_segments; n++) {
> +			mem = image->segment[n].mem;
> +			memsz = image->segment[n].memsz;
> +			ptr = map_crash_pages(mem, memsz);
> +			if (ptr) {
> +				/* The segment containing elfcorehdr */
> +				if ((ptr[0] == 0x7F) &&
> +					(ptr[1] == 'E') &&
> +					(ptr[2] == 'L') &&
> +					(ptr[3] == 'F')) {

Can it be like memcmp(ptr, ELFMAG, SELFMAG) as we have done in
parse_crash_elf_headers()? With that, one line is taken.

> +					image->elf_index = (int)n;
> +					image->elf_index_valid = true;
> +				}
> +			}
> +			unmap_crash_pages((void **)&ptr);
> +		}
> +	}
> +
>  	/* Must have valid elfcorehdr index */
>  	if (!image->elf_index_valid) {
>  		pr_err("crash hp: unable to locate elfcorehdr segment");
> -- 
> 2.27.0
> 

