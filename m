Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1D44FE444
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 16:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356807AbiDLPB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242923AbiDLPBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:01:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A8EC4D63A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 07:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649775575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+RMao/icjZOR7b/VhfyeZ5DmNqqniWO1wzUexEJFUx4=;
        b=S4wSXCm0SR7AjQ9MIFwGdJ9ko96+zYmLN2/mHS6CTvl0t+WPHvC/Siat34vSbkLDzRni7D
        6/egsv+jgS93LBFmY4xL2JDVFCWeBwUWKbKHZThkBxoDGqItLN6ip7nq08nHPcVmN/RleJ
        iBfBZLf9fPoOl0umCEnEa+E6vMOy6aM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-394-iUNEU0ziNruloCAoZ778BQ-1; Tue, 12 Apr 2022 10:59:34 -0400
X-MC-Unique: iUNEU0ziNruloCAoZ778BQ-1
Received: by mail-wr1-f70.google.com with SMTP id j67-20020adf9149000000b00203e6b7d151so4106293wrj.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 07:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=+RMao/icjZOR7b/VhfyeZ5DmNqqniWO1wzUexEJFUx4=;
        b=srK5KMeIs2i3pMD4e7dAJSwobEPnc3785JyAI8dQelZa2O+VqzD+M8IyKDbY3+3qGP
         iyoTlRcumUTfjIDIQqnLQipDIEtaayurW2a9djkkfTAhdGOSCixEiqOkTSAkcG22bKPh
         wrDBnKdMfbUII87H6bGO6ugXIsaq4uIf4gP8f9I2kqJ0rpOdKyeQ1giUppkpwf8bNOTI
         v+DImyEJK2qh3JX/Jl+g5Vu5mnLnqC3d4Xi6mC3964IDvP3/9dbC8KiTOx4GKXtC6FQw
         mTvgiMf6GyS47FxX3GDSGCkX9YCd2QJA4BwqDhaHSGiAiOIcrFl/fgF6q2Hps9idZp4j
         teFg==
X-Gm-Message-State: AOAM533tLU8JsB3501XUHhMJOUNCxnm2lgsMbD+FGli25i/O0ta30RMP
        5qBV91nppUcDSPeWDc70wKyfWayN7pmKgb1bw3OD9aU/NylKpT+0ViMirKBtwjUKA+4G+WL6pRw
        RIU5r5oIH7uml2W+gLduqcWw9
X-Received: by 2002:adf:ed8f:0:b0:207:ac33:801f with SMTP id c15-20020adfed8f000000b00207ac33801fmr4562910wro.453.1649775573381;
        Tue, 12 Apr 2022 07:59:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLIpWvCj37SohK2EXJPy09eJg+fXmpEUsKlr6HFfmxumMiwnsh1WJNnv09XjQ/431Bs8Hs9A==
X-Received: by 2002:adf:ed8f:0:b0:207:ac33:801f with SMTP id c15-20020adfed8f000000b00207ac33801fmr4562895wro.453.1649775573157;
        Tue, 12 Apr 2022 07:59:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:1800:7c14:16cc:5291:a9f3? (p200300cbc70718007c1416cc5291a9f3.dip0.t-ipconnect.de. [2003:cb:c707:1800:7c14:16cc:5291:a9f3])
        by smtp.gmail.com with ESMTPSA id b14-20020a7bc24e000000b003899c8053e1sm2742525wmj.41.2022.04.12.07.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 07:59:32 -0700 (PDT)
Message-ID: <b153b758-ce11-364a-2699-753b21250508@redhat.com>
Date:   Tue, 12 Apr 2022 16:59:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 2/9] mm/vmscan: remove unneeded can_split_huge_page
 check
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>,
        Oscar Salvador <osalvador@suse.de>
Cc:     akpm@linux-foundation.org, ying.huang@intel.com,
        songmuchun@bytedance.com, hch@infradead.org, willy@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220409093500.10329-1-linmiaohe@huawei.com>
 <20220409093500.10329-3-linmiaohe@huawei.com>
 <YlU/h0fdE1L846Bd@localhost.localdomain>
 <7455b680-3d89-5d3e-ba0e-6e4358b114a2@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <7455b680-3d89-5d3e-ba0e-6e4358b114a2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.04.22 15:42, Miaohe Lin wrote:
> On 2022/4/12 16:59, Oscar Salvador wrote:
>> On Sat, Apr 09, 2022 at 05:34:53PM +0800, Miaohe Lin wrote:
>>> We don't need to check can_split_folio() because folio_maybe_dma_pinned()
>>> is checked before. It will avoid the long term pinned pages to be swapped
>>> out. And we can live with short term pinned pages. Without can_split_folio
>>> checking we can simplify the code. Also activate_locked can be changed to
>>> keep_locked as it's just short term pinning.
>>
>> What do you mean by "we can live with short term pinned pages"?
>> Does it mean that it was not pinned when we check
>> folio_maybe_dma_pinned() but now it is?
>>
>> To me it looks like the pinning is fluctuating and we rely on
>> split_folio_to_list() to see whether we succeed or not, and if not
>> we give it another spin in the next round?
> 
> Yes. Short term pinned pages is relative to long term pinned pages and these pages won't be
> pinned for a noticeable time. So it's expected to split the folio successfully in the next
> round as the pinning is really fluctuating. Or am I miss something?
> 

Just so we're on the same page. folio_maybe_dma_pinned() only capture
FOLL_PIN, but not FOLL_GET. You can have long-term FOLL_GET right now
via vmsplice().

can_split_folio() is more precise then folio_maybe_dma_pinned(), but
both are racy as long as the page is still mapped.


-- 
Thanks,

David / dhildenb

