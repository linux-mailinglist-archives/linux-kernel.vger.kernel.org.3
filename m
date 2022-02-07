Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782D04AC19E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 15:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383199AbiBGOoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 09:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239167AbiBGOl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:41:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F120AC0401C4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 06:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644244885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U9/EMlgIN9QXIzc+zISwktBd/gJFAPg2HMGjyGTDEMA=;
        b=ZUp4rcLbJ0Cb80o088jdmrrQdKcThep8KZPa8a3AAEEl/MNZK8dqwpBbrfAUufh+jhIEc9
        2fnw7K2fl1zG+ZAlM2aj16gLV0mMWCi2lvN0VNvjVx8PuEWeONjakteZ3e7N4Yoai/23Y3
        PwkbFtFEwsWhe9SwE1k/hDFJdHX571A=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-0Vt_HepzPaKflEVVGSBJRg-1; Mon, 07 Feb 2022 09:41:23 -0500
X-MC-Unique: 0Vt_HepzPaKflEVVGSBJRg-1
Received: by mail-ed1-f72.google.com with SMTP id 30-20020a508e5e000000b0040f6642e814so1964005edx.19
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 06:41:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=U9/EMlgIN9QXIzc+zISwktBd/gJFAPg2HMGjyGTDEMA=;
        b=62dXt8YBDZKfD5XEMhxAaErwq3R+URBCZtSweT9W6X2CZ6nW1LcYpazo3XzoFIgE/C
         TaPVmW+McHer2jlV0Rsd0PBCLpB8RSgWxRs2U+IE22k9yAf0LkQp9E0yHe0FXh6zSAvX
         TS+iunGV+QwoIE4D0FYqYH5ZmtRkxInV9GcHC/snV4PCGPQfBsMbCXPQmWaOC84EgCzA
         v1lLrgf5+eS/72F7mo4aWh+Iehe4bnQPAmtP8nc5hGXtYawlNMM7LXKLwBHivxcPWXwU
         W0SGKVUl4xcav544jwjJ8Ubz8hYmaLeA5q0TLJ0dP/4MKF9eWQqnkFlz1XbEdxwal03U
         6UWQ==
X-Gm-Message-State: AOAM530G7Y6LjcmAfx18fp+bFqrRuU8UubD+m7UM0qxL7TRt6Gt+TyaJ
        hjUShc68RGKfXys3aJ7w1571oExIFy6/Wf8fT8oB6AXWbQlTop4GmNpkcylMMJaI6Owo+Zsfg9T
        pivMdhe3U5U5smwY5jouIRwG/
X-Received: by 2002:a17:907:2d14:: with SMTP id gs20mr38343ejc.149.1644244882615;
        Mon, 07 Feb 2022 06:41:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz4IMukBv8fxsbw6O/G7HxMpzkkml2E+JB1htfZ/eDniqAe1gLNoBCTjInbUP2QXv6052x03g==
X-Received: by 2002:a17:907:2d14:: with SMTP id gs20mr38320ejc.149.1644244882287;
        Mon, 07 Feb 2022 06:41:22 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:6300:a751:d742:1f76:8639? (p200300cbc7096300a751d7421f768639.dip0.t-ipconnect.de. [2003:cb:c709:6300:a751:d742:1f76:8639])
        by smtp.gmail.com with ESMTPSA id j1sm390581ejx.123.2022.02.07.06.41.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 06:41:21 -0800 (PST)
Message-ID: <21cec396-9d6a-03b7-716d-2a84c79eeb73@redhat.com>
Date:   Mon, 7 Feb 2022 15:41:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/4] mm/memory_hotplug: remove obsolete comment of
 __add_pages
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220207133643.23427-1-linmiaohe@huawei.com>
 <20220207133643.23427-2-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220207133643.23427-2-linmiaohe@huawei.com>
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
> Since commit f1dd2cd13c4b ("mm, memory_hotplug: do not associate hotadded
> memory to zones until online"), there is no need to pass in the zone.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/memory_hotplug.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index a4f69d399929..cbc67c27e0dd 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -296,10 +296,7 @@ struct page *pfn_to_online_page(unsigned long pfn)
>  EXPORT_SYMBOL_GPL(pfn_to_online_page);
>  
>  /*
> - * Reasonably generic function for adding memory.  It is
> - * expected that archs that support memory hotplug will
> - * call this function after deciding the zone to which to
> - * add the new pages.
> + * Reasonably generic function for adding memory.
>   */
>  int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
>  		struct mhp_params *params)

I'd suggest just removing the comment completely.

-- 
Thanks,

David / dhildenb

