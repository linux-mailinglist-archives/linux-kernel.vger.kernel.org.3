Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878EC46E7C4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 12:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236882AbhLILzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 06:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbhLILzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 06:55:04 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02AEC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 03:51:30 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso4630368pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 03:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=UtNBeYFsaWjUOBjcjiCmcLYkBZOBUTSUxLJTx5J2sWY=;
        b=l4IM/2R8RZYwYTIknCFyCrtU7GLyzKukzuPmqh7775f+gNUNOUQ7Uja91WlvqSoAjI
         ZIIg5oK8eSHumMKWdcyml7GQdEUZ/j9NWL3ndUg4jebvqmVg1H0LtrsOZxS7iAs3rxrA
         uWZRI+/EL0varxcrea2zI33Rt8tij/bexkJnApnlTQKUiG41B6V9slBQ1wWUx+lcjI0e
         FQ/uj/uHO17h32iPPnlIeWE9xgEIxiRAaTA0M0P6B6Qh34+yOGJFD4EWKnku1m2Rycbl
         zTKe5jYmVV3udd7YJfPIbTQ8HIGIyExhjZgAdLCoMQbLKfikQFijKPNzf0bp9FehXalH
         NT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UtNBeYFsaWjUOBjcjiCmcLYkBZOBUTSUxLJTx5J2sWY=;
        b=0TbCVRGqH2efVHQXn+zau4nPZoyI2yf+w/t8NEDcBZgEaA99didnjELnitNYmUNvoD
         mXm8++BbLNSqHO4KQ2EB1RnAY2muH9ulMT5Ub77nBEkBQgD+2Y3B+Bvx8WHiPSO8jvH3
         125uyKdqhhtEMm/FmJSvWBTcSPVvfMoCLN18EdicWk/IsvullEIaj44PBwe0qL3LK401
         3rlyyZavdYjZHdfBOvslILkrljtOAM8wgh/QJ/jYFllR4CqnPn6rjRog43Ri0IVp1kvc
         Ir17XMqhiD26jGfhKsbI6fDze6gs8X3cT+BRDXQ/R0baaeEvgSj8xmVQNU90P6i0qUSz
         UIyw==
X-Gm-Message-State: AOAM530rn6grycniVr0nYCpqXTR2hzFBDqbbN/BPHnQUGMWIkdddaumR
        SDoiSqCAHKcBKTS8jvPtlg8=
X-Google-Smtp-Source: ABdhPJwvh5osQ1ikW22yT/NOsPI//T9UTSGuv0IrcDe4RFr8dawSNxeRL7Lw2RVTc5Lx0fjabA/Ahw==
X-Received: by 2002:a17:902:f68b:b0:142:c60:475 with SMTP id l11-20020a170902f68b00b001420c600475mr66274169plg.8.1639050690387;
        Thu, 09 Dec 2021 03:51:30 -0800 (PST)
Received: from [30.240.97.54] ([205.204.117.110])
        by smtp.gmail.com with ESMTPSA id x9sm9099452pjq.50.2021.12.09.03.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 03:51:29 -0800 (PST)
Message-ID: <a4e2099d-b543-e2e3-f189-0cdfcc38420e@gmail.com>
Date:   Thu, 9 Dec 2021 19:51:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH v1 2/2] virtio-mem: prepare fake page onlining code for
 granularity smaller than MAX_ORDER - 1
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Gavin Shan <gshan@redhat.com>, Hui Zhu <teawater@gmail.com>,
        Sebastien Boeuf <sebastien.boeuf@intel.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org
References: <20211126134209.17332-1-david@redhat.com>
 <20211126134209.17332-3-david@redhat.com>
From:   Eric Ren <renzhengeek@gmail.com>
In-Reply-To: <20211126134209.17332-3-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2021/11/26 21:42, David Hildenbrand wrote:
> Let's prepare our fake page onlining code for subblock size smaller than
> MAX_ORDER - 1: we might get called for ranges not covering properly
> aligned MAX_ORDER - 1 pages. We have to detect the order to use
> dynamically.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   drivers/virtio/virtio_mem.c | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 03e1c5743699..50de7582c9f8 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -1121,15 +1121,18 @@ static void virtio_mem_clear_fake_offline(unsigned long pfn,
>    */
>   static void virtio_mem_fake_online(unsigned long pfn, unsigned long nr_pages)
>   {
> -	const unsigned long max_nr_pages = MAX_ORDER_NR_PAGES;
> +	unsigned long order = MAX_ORDER - 1;
>   	unsigned long i;
>   
>   	/*
> -	 * We are always called at least with MAX_ORDER_NR_PAGES
> -	 * granularity/alignment (e.g., the way subblocks work). All pages
> -	 * inside such a block are alike.
> +	 * We might get called for ranges that don't cover properly aligned
> +	 * MAX_ORDER - 1 pages; however, we can only online properly aligned
> +	 * pages with an order of MAX_ORDER - 1 at maximum.
>   	 */
> -	for (i = 0; i < nr_pages; i += max_nr_pages) {
> +	while (!IS_ALIGNED(pfn | nr_pages, 1 << order))
> +		order--;
> +
> +	for (i = 0; i < nr_pages; i += 1 << order) {
>   		struct page *page = pfn_to_page(pfn + i);
>   
>   		/*
> @@ -1139,14 +1142,12 @@ static void virtio_mem_fake_online(unsigned long pfn, unsigned long nr_pages)
>   		 * alike.
>   		 */
>   		if (PageDirty(page)) {
> -			virtio_mem_clear_fake_offline(pfn + i, max_nr_pages,
> -						      false);
> -			generic_online_page(page, MAX_ORDER - 1);
> +			virtio_mem_clear_fake_offline(pfn + i, 1 << order, false);
> +			generic_online_page(page, order);
>   		} else {
> -			virtio_mem_clear_fake_offline(pfn + i, max_nr_pages,
> -						      true);
> -			free_contig_range(pfn + i, max_nr_pages);
> -			adjust_managed_page_count(page, max_nr_pages);
> +			virtio_mem_clear_fake_offline(pfn + i, 1 << order, true);
> +			free_contig_range(pfn + i, 1 << order);
> +			adjust_managed_page_count(page, 1 << order);
In the loop, pfn + i, 1 << order are repeatedly calculated. 1 << order 
is a step size, pfn + i  is each step position.
Better to figure the numer once each iter?

LGTL.
LGTM.
Reviewed-by: Eric Ren <renzhengeek@gmail.com>
>   		}
>   	}
>   }
> @@ -2477,7 +2478,6 @@ static int virtio_mem_init_hotplug(struct virtio_mem *vm)
>   	/*
>   	 * We want subblocks to span at least MAX_ORDER_NR_PAGES and
>   	 * pageblock_nr_pages pages. This:
> -	 * - Simplifies our fake page onlining code (virtio_mem_fake_online).
>   	 * - Is required for now for alloc_contig_range() to work reliably -
>   	 *   it doesn't properly handle smaller granularity on ZONE_NORMAL.
>   	 */

