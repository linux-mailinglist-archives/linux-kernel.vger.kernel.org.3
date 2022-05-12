Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA3E524E70
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354515AbiELNlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353158AbiELNlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:41:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91F054F9D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652362890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zPJIz37sPGbYwqao0wempLNgo/4LnaU4Rpq9/l1/JMA=;
        b=Ey1aLMYdJYK4OX3CGypy+vklQRLnjT82U/CjGFgQVflZQo5tgUZeF/QahQ0wv/qNARRzr9
        zP5RxXw2iVPss6+bxVFzd3nM61k4CXuwhrRwdhM9tcwqaBQKQh0FoP7v110iRpJULsmkUK
        lrB24jtkyemZp8jBgPJlY0OAD9lMKV8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-luyfei5ROvy-W6amXFdUgA-1; Thu, 12 May 2022 09:41:28 -0400
X-MC-Unique: luyfei5ROvy-W6amXFdUgA-1
Received: by mail-wm1-f72.google.com with SMTP id k5-20020a05600c0b4500b003941ca130f9so1649737wmr.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=zPJIz37sPGbYwqao0wempLNgo/4LnaU4Rpq9/l1/JMA=;
        b=iJF7w77n2KKnqnldfHv5bao9+hk2gq0oi96kqMPfxSaibCdM5jtdX6DiE6za1lAcxH
         oJpt4klv4nhaHJv/60OzS1xUfMegdNX0yHjUAJEHwP6nSGkCzolzH2jV7jt19OgDO/0G
         SPawr9b39awLTPyh6teV9Ye77eniNouQpxqbkqLckJG6yOJpYvR8XucItAJ2+PVozA41
         dmXZ3NF16U6Nb/icBZHX8zJOnXTWyINHmfk1fsrBp6nm0rR0v/FbtIKfblzz7vsZ9gdY
         ufR6S6FdanRVA1Lk1dWfOrbfeLIs7vSmHyLWIBIaLqNpn4dBV9c84MPb5NcQAEVxfHZR
         2sKw==
X-Gm-Message-State: AOAM533TSoFZxSY/D7CC+J/ch/rnQrzV0CIH8W1KwRVgRQ9bkkmTkyHE
        h2zfnXH/RcewdFutfBbCf1tTqWYjtIK5c2HTtsJCyqNjxLgAAczrvr7f2kzTnO8p4Dna/bTw9Sw
        EAek7gVdtJZ48I6GHoyv+s7iR
X-Received: by 2002:a5d:5954:0:b0:20c:4d55:1388 with SMTP id e20-20020a5d5954000000b0020c4d551388mr27423892wri.90.1652362887224;
        Thu, 12 May 2022 06:41:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4TmlfxJzmRoM3GMGqcbhMOtugFkXiALQYvjC/futtXs9toOTQf9jWiGS8oiw3u1s2mN5e5w==
X-Received: by 2002:a5d:5954:0:b0:20c:4d55:1388 with SMTP id e20-20020a5d5954000000b0020c4d551388mr27423871wri.90.1652362886937;
        Thu, 12 May 2022 06:41:26 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:d200:ee5d:1275:f171:136d? (p200300cbc701d200ee5d1275f171136d.dip0.t-ipconnect.de. [2003:cb:c701:d200:ee5d:1275:f171:136d])
        by smtp.gmail.com with ESMTPSA id r6-20020adfdc86000000b0020c5253d8bdsm5295659wrj.9.2022.05.12.06.41.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 06:41:26 -0700 (PDT)
Message-ID: <59f1867f-8e56-78c1-2d5e-0cb429bdd40f@redhat.com>
Date:   Thu, 12 May 2022 15:41:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 12/15] mm/swap: fix the obsolete comment for
 SWP_TYPE_SHIFT
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     willy@infradead.org, vbabka@suse.cz, dhowells@redhat.com,
        neilb@suse.de, apopple@nvidia.com, surenb@google.com,
        peterx@redhat.com, naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220509131416.17553-1-linmiaohe@huawei.com>
 <20220509131416.17553-13-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220509131416.17553-13-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.05.22 15:14, Miaohe Lin wrote:
> Since commit 3159f943aafd ("xarray: Replace exceptional entries"), there
> is only one bit of 'type' can be shifted up. Update the corresponding
> comment.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  include/linux/swapops.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index 7db424e2dcb1..bb7afd03a324 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -13,10 +13,10 @@
>   * get good packing density in that tree, so the index should be dense in
>   * the low-order bits.
>   *
> - * We arrange the `type' and `offset' fields so that `type' is at the seven
> + * We arrange the `type' and `offset' fields so that `type' is at the six
>   * high-order bits of the swp_entry_t and `offset' is right-aligned in the
>   * remaining bits.  Although `type' itself needs only five bits, we allow for
> - * shmem/tmpfs to shift it all up a further two bits: see swp_to_radix_entry().
> + * shmem/tmpfs to shift it all up a further one bit: see swp_to_radix_entry().

Actually, the shift magic is in xa_mk_value() :)

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

