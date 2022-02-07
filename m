Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A1A4AC2A3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442829AbiBGPJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442465AbiBGOvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:51:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1694C0401C3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 06:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644245459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zikTiAYNsW3FX50KxVFGIBWDk9jSNH8ecGKPu+J72PI=;
        b=CGXyEX9VNN1hPtQbRgV87I1Dvp8irXNjulG+i5SU5yX8Q4JgdtduPRZWV1gAaYQaCLGO6Z
        4eZ8r1n1A/zASTgqV6DvH3gdBEDFfhO+XG63hckMo7TSHwGbwdf2n4z4n7PVkzOrP2CMoJ
        WhEleZD0Q5EF38H4em3kfsQJ4veee7c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-7e8sX7e9NJmsyxEfDLYR4w-1; Mon, 07 Feb 2022 09:50:58 -0500
X-MC-Unique: 7e8sX7e9NJmsyxEfDLYR4w-1
Received: by mail-wm1-f71.google.com with SMTP id bg16-20020a05600c3c9000b0034bea12c043so12356943wmb.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 06:50:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=zikTiAYNsW3FX50KxVFGIBWDk9jSNH8ecGKPu+J72PI=;
        b=uNK9u2oDZDDy0/dPRRopP+KYa8iWS21r0nnNnn/4t90ykpooLIhVFmzqM1EajuRuHw
         FvWGRaVaV+dY0YlIR3GW+4VXA/BYgNSOdv9kqvdl5lmcFPswv/3s/15pm+JpByYv/Z22
         AiGRuGiz4p097Ot/Ivrajd0pzTfNX8E4MXVu0Wh5ja/fxhbjoLLxymBlX0S3o1E9mIFe
         7zMWN9Ex42+X+J1cxlZAPI1fJX4q4/JgVE3WA3BFxxFcCEKrc7vJ5U3KHZkxZ0B0CrG8
         Xjdhbu9hghOFEGvyWrYZCOjLXICwQg39Y2fAc1j+moB/jRjM291IpiKJGVrxfZQ2nE4I
         voyA==
X-Gm-Message-State: AOAM532lPFQgr2KwZqnCpx9KAvDSfG5tJLuKfP5i86SQ1Bze+jdKn268
        tRCYERBjrRAPfHqAjcaOnsHS1h8Hjuy6l0E34foHLHbrKsKR0gOGINenIPgAkmNL2LKLeBxKbVT
        a1LtOmgETR5SW5gwsUUcBZ0D5
X-Received: by 2002:a05:600c:28d2:: with SMTP id h18mr10299117wmd.56.1644245455841;
        Mon, 07 Feb 2022 06:50:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyLpe2hgXZ2il+Wvv9VULju4pkFVV31oFWKYZl79U3Bxo66VYH7T4BN2SHO+24n0lcDktcc6g==
X-Received: by 2002:a05:600c:28d2:: with SMTP id h18mr10299106wmd.56.1644245455667;
        Mon, 07 Feb 2022 06:50:55 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:6300:a751:d742:1f76:8639? (p200300cbc7096300a751d7421f768639.dip0.t-ipconnect.de. [2003:cb:c709:6300:a751:d742:1f76:8639])
        by smtp.gmail.com with ESMTPSA id l10sm11993306wry.79.2022.02.07.06.50.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 06:50:55 -0800 (PST)
Message-ID: <c8d704f2-cc1c-52d2-3898-bf07dcb76e1a@redhat.com>
Date:   Mon, 7 Feb 2022 15:50:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/4] mm/memory_hotplug: avoid calling zone_intersects()
 for ZONE_NORMAL
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220207133643.23427-1-linmiaohe@huawei.com>
 <20220207133643.23427-3-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220207133643.23427-3-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.02.22 14:36, Miaohe Lin wrote:
> If zid reaches ZONE_NORMAL, the caller will always get the NORMAL zone no
> matter what zone_intersects() returns. So we can save some possible cpu
> cycles by avoid calling zone_intersects() for ZONE_NORMAL.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/memory_hotplug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index cbc67c27e0dd..140809e60e9a 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -826,7 +826,7 @@ static struct zone *default_kernel_zone_for_pfn(int nid, unsigned long start_pfn
>  	struct pglist_data *pgdat = NODE_DATA(nid);
>  	int zid;
>  
> -	for (zid = 0; zid <= ZONE_NORMAL; zid++) {
> +	for (zid = 0; zid < ZONE_NORMAL; zid++) {
>  		struct zone *zone = &pgdat->node_zones[zid];
>  
>  		if (zone_intersects(zone, start_pfn, nr_pages))


Makes sense, although we just don't care about the CPU cycles at that point.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

