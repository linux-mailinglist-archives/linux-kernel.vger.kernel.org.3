Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB8F53FFA6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 15:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244403AbiFGNE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 09:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiFGNEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 09:04:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6755F21E1F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 06:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654607087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=61bnyqyJdljMgWauKzNAeiK3UFSxfHw8zeO9sU7UtQI=;
        b=Iq4lGShQwoRrHpa4pQmh5hE6TuiHyW8OWHjKsRakjQiamX0QG+1iMs2cT5wcpJ7P+wv0cM
        GtQ18WCFGujHTt/4O9K6aY4pe/Cx4e7znprvoDbwfsj9iww6ZXh1sK27v2iKdQPlrfk5Vf
        aBxx/XGzLy0BqBQJeeacgQveLmGSHME=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-DmdnNpdVN_meNgL6rENW0g-1; Tue, 07 Jun 2022 09:04:43 -0400
X-MC-Unique: DmdnNpdVN_meNgL6rENW0g-1
Received: by mail-wm1-f72.google.com with SMTP id bg40-20020a05600c3ca800b00394779649b1so12740053wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 06:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=61bnyqyJdljMgWauKzNAeiK3UFSxfHw8zeO9sU7UtQI=;
        b=R56xqbO/WqP5yJwPcD8dnt8e+Tzi4omEUPGC5SHnxcQmADXZEsa9uZCvVIQCNuTrWX
         s8/pP48bxt8gG2B7ZKa8Qjitvtd2rFCk4gPcOHFvshARrIYy5OTSz8XJ9ZtIarp2jk/x
         c1bgOfTfCb8gu4wHOqrpPZ3v4axQGEgliWHmoGj4xWhcyjix0Roqdf68RtHC2B+z/IS2
         0yX2acy89c/vAiOmA35g6lQCZx7+gtrsuJ8udDF7HGWBCVPjm44R229dAZWelonjw6pm
         mqA6n8iRlIfGMg8S80YEPuUmQvz6LSdqd46KBC07ZDb+FAUPBZrtQJcuc8eBYuzL1QWU
         7MOA==
X-Gm-Message-State: AOAM530DWjWcDG6rlNFVQl8aci/FXeiYFg/Q3sXF1W0A2TsQSJk7kNec
        nvmREiX0Fo7pTPpP6W0x5SqI85tunZ1EaPO/OOEz53r1aSkz71SgnRuBalDymj0h5HcUCWsBob8
        RNmyPVegRwYcGa55gRv3p5kjx
X-Received: by 2002:a5d:69c9:0:b0:213:aba0:68e4 with SMTP id s9-20020a5d69c9000000b00213aba068e4mr24852317wrw.439.1654607082000;
        Tue, 07 Jun 2022 06:04:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEOMvXBpQiGJoB6og7b14BDGC56mZ5xdCu1DT1LSArW5bcsP7kRr0ulkFQ7o1h31xLYpfkVQ==
X-Received: by 2002:a5d:69c9:0:b0:213:aba0:68e4 with SMTP id s9-20020a5d69c9000000b00213aba068e4mr24852269wrw.439.1654607081664;
        Tue, 07 Jun 2022 06:04:41 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:500:4c8d:4886:f874:7b6f? (p200300cbc70905004c8d4886f8747b6f.dip0.t-ipconnect.de. [2003:cb:c709:500:4c8d:4886:f874:7b6f])
        by smtp.gmail.com with ESMTPSA id bp3-20020a5d5a83000000b0020cff559b1dsm17827729wrb.47.2022.06.07.06.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 06:04:28 -0700 (PDT)
Message-ID: <ea4cc6c8-a772-dce0-a7a3-4c3ceb31735f@redhat.com>
Date:   Tue, 7 Jun 2022 15:04:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v1 1/5] mm, hwpoison, hugetlb: introduce
 SUBPAGE_INDEX_HWPOISON to save raw error page
Content-Language: en-US
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
References: <20220602050631.771414-1-naoya.horiguchi@linux.dev>
 <20220602050631.771414-2-naoya.horiguchi@linux.dev>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220602050631.771414-2-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.06.22 07:06, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> When handling memory error on a hugetlb page, the error handler tries to
> dissolve and turn it into 4kB pages.  If it's successfully dissolved,
> PageHWPoison flag is moved to the raw error page, so that's all right.
> However, dissolve sometimes fails, then the error page is left as
> hwpoisoned hugepage. It's useful if we can retry to dissolve it to save
> healthy pages, but that's not possible now because the information about
> where the raw error page is lost.
> 
> Use the private field of a tail page to keep that information.  The code
> path of shrinking hugepage pool used this info to try delayed dissolve.
> This only keeps one hwpoison page for now, which might be OK because it's
> simple and multiple hwpoison pages in a hugepage can be rare. But it can
> be extended in the future.
> 
>

But what would happen now if you have multiple successive MCE events on
such a page now?

-- 
Thanks,

David / dhildenb

