Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B496F4CF3D1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 09:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbiCGImR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 03:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbiCGImQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 03:42:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0416536B4F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 00:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646642482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WZ/jRjm903Qd3wvvBRPNuh4p9MGGDlugM+CNft25NUA=;
        b=LmoEMjF3cVhbtbF9UEopoJSFahYPWIOpJzN6UUkHJ4FDgNz4COXP8fxJOEkjsbCegTEBVd
        IDlG/pc3EYSe+8g551td4+8K+P0G8RiB51R8jiyyVvFbneXDsQDo9kBUmAIiQqtAJfIyNN
        wYxAwdR+yhQSnSBpnh3SAvWKgQIPNRQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-225-sfZCj0BLNReEmT8D7U72Mw-1; Mon, 07 Mar 2022 03:41:20 -0500
X-MC-Unique: sfZCj0BLNReEmT8D7U72Mw-1
Received: by mail-wr1-f72.google.com with SMTP id n4-20020a5d4844000000b001f1ed76e943so357702wrs.22
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 00:41:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=WZ/jRjm903Qd3wvvBRPNuh4p9MGGDlugM+CNft25NUA=;
        b=FgUcfLk7xKmpE9szdG3rtkKO4SAZD66D/VWcRE8X9yCB3HKl3ClIflst08s46In6Qa
         nYt6LDf3che1MVHBYTfC9Xq30yuqp0aro/uklFBV3gEDlWeuNeOcPCLyIWlOS1ehAuUA
         cgX+NIVXvR4bpzpay4/rgZS8wQE6AD1jL1XrLMEO2RHik9qPOZ7WKbfk3hNO4ysf/6M2
         1WyhEQQW/26uGtNFsSbgAZ/X9kRKJu7LGQE0iw4M5BoLTAQLjxBe+F8y1ZIBe2h1y76E
         Veqglq2f/F1npW4gDmPzVYkQEz0+XxJf+4aYnpAQI0rqMF7QR09iIjN6huzmmjOG0k25
         yo2A==
X-Gm-Message-State: AOAM5321sS11GXUpV9TGbGWQXG4Ks0DXz33WJcWWz2Lz4W/Fwe1XsDiZ
        TEbGIITearE+tC8Fji8UKlxzRDbaAQUPhKOoaRNFjQz9S2+Fr2K28xyag6mroJ6dJHjDlKDJz4z
        x7iUE3uJ8siB8AECY54Ds4bj1
X-Received: by 2002:a05:600c:3487:b0:382:aa28:fe1f with SMTP id a7-20020a05600c348700b00382aa28fe1fmr8466868wmq.170.1646642479629;
        Mon, 07 Mar 2022 00:41:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzh3j8bOrlKZVeuOO6ZBdw54ZKnMPAH6OWecAGua1WoBrret/+L6m+6T54iTZ88hifVbfDIvQ==
X-Received: by 2002:a05:600c:3487:b0:382:aa28:fe1f with SMTP id a7-20020a05600c348700b00382aa28fe1fmr8466859wmq.170.1646642479426;
        Mon, 07 Mar 2022 00:41:19 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:1e00:8d67:f75a:a8ae:dc02? (p200300cbc7051e008d67f75aa8aedc02.dip0.t-ipconnect.de. [2003:cb:c705:1e00:8d67:f75a:a8ae:dc02])
        by smtp.gmail.com with ESMTPSA id r20-20020adfa154000000b001f0326a23e1sm10674958wrr.88.2022.03.07.00.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 00:41:19 -0800 (PST)
Message-ID: <8c73ec79-d580-81a4-b8d4-a06a48a35f7a@redhat.com>
Date:   Mon, 7 Mar 2022 09:41:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH mmotm v2] mm: delete __ClearPageWaiters()
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <351df0af-78f2-c20-2a6d-e5f978e5ca1@google.com>
 <a2f6aa01-8003-6791-718d-3898f77ef643@redhat.com>
 <9dda55d5-eafa-3177-2a4c-32ccb7e146e3@google.com>
 <90aafe84-fe7d-c70e-8e15-c222869f30fc@redhat.com>
 <6e5262ff-8596-a86-7388-eddb2b2c53c@google.com>
 <3eafa969-5b1a-accf-88fe-318784c791a@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <3eafa969-5b1a-accf-88fe-318784c791a@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.03.22 22:25, Hugh Dickins wrote:
> The PG_waiters bit is not included in PAGE_FLAGS_CHECK_AT_FREE, and
> vmscan.c's free_unref_page_list() callers rely on that not to generate
> bad_page() alerts.  So __page_cache_release(), put_pages_list() and
> release_pages() (and presumably copy-and-pasted free_zone_device_page())
> are redundant and misleading to make a special point of clearing it (as
> the "__" implies, it could only safely be used on the freeing path).
> 
> Delete __ClearPageWaiters().  Remark on this in one of the "possible"
> comments in folio_wake_bit(), and delete the superfluous comments.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Tested-by: Yu Zhao <yuzhao@google.com>

Thanks

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

