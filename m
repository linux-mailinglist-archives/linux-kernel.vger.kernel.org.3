Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB88592554
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 18:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243339AbiHNQnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 12:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243254AbiHNQk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 12:40:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00216B26
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 09:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660494643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7OqIGNvFWmwJKsWdnZAcHQuajnrJ8LLtzZZWISo0x+A=;
        b=IewzpnhsEWIFVFNIXc7kseJZddxtMhbXSlfXOVOS2pUpYwcPUwFwHkQFruNdRLIDTlCYhE
        2aaWTAd1RrlFaGbqUpCpfUGBYhsWsK8uKKftnaGg6gT6lhJrOdKaiTJ0OZepnDiQqX3DCN
        nO49vYBSVsPeVz2OvpVJtgApdmreONM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-182-v0OUzfyaPOaYp-8-niKZug-1; Sun, 14 Aug 2022 12:30:42 -0400
X-MC-Unique: v0OUzfyaPOaYp-8-niKZug-1
Received: by mail-wm1-f72.google.com with SMTP id c66-20020a1c3545000000b003a37b7e0764so7437725wma.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 09:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=7OqIGNvFWmwJKsWdnZAcHQuajnrJ8LLtzZZWISo0x+A=;
        b=IEkXpbtJt3Xp855Gn4Z7WcOeIComIE8l+xhJks1Zc/vldEIQA5pbuFpKWfJ4mV4r3i
         hi8CtYOj29ryxZlyEfiLf6l+EavszfoWKDUoHLoHpnuIze8PMfk0Pun69cm0LDHEHsA0
         aTuosvSOiLfdgj9bLAigh4JoPfpp0wCcQuLzX4s6feodGHBZ3LMmQMPWHD2NSKOIdfvs
         f9+ei4ff4eU1RdJNup0YnPCZjQFtDPeZhKGTjj76B4i3WICkW88d883Off38LGQLyOBM
         qplzStrQz98vfQZ53KODdBPZGmqW072W08OVnWS6SB3fe2ovd3uy1ycx582CXr2x7FOB
         PixA==
X-Gm-Message-State: ACgBeo0jlslCDPVOXHHHw9eymfhvM7hSgMfTdxjOmqxbZTbkc8ICTkbl
        3V2kfxnbhhGY14tazHPXjlTDRgddWtkBmgv9g8t+KlWMnMP74tRLh7uL3/JvL0vj6JYL1kM94UQ
        ypZiv3byKNesImuc0rg+LajDB
X-Received: by 2002:a05:600c:2cc5:b0:3a5:4fae:1288 with SMTP id l5-20020a05600c2cc500b003a54fae1288mr14405195wmc.79.1660494641161;
        Sun, 14 Aug 2022 09:30:41 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4zbFVBaiyOjyDfdYEQM8eStx9y5x2XOUmTcHScJeTFx/pQEQl90jmcMKpcqRGyL/qMwFxAzQ==
X-Received: by 2002:a05:600c:2cc5:b0:3a5:4fae:1288 with SMTP id l5-20020a05600c2cc500b003a54fae1288mr14405186wmc.79.1660494640879;
        Sun, 14 Aug 2022 09:30:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72a:1e00:10cf:131b:999d:9b4a? (p200300cbc72a1e0010cf131b999d9b4a.dip0.t-ipconnect.de. [2003:cb:c72a:1e00:10cf:131b:999d:9b4a])
        by smtp.gmail.com with ESMTPSA id h23-20020a05600c145700b003a529b7bc27sm6664588wmi.9.2022.08.14.09.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Aug 2022 09:30:40 -0700 (PDT)
Message-ID: <2298704f-03f9-c932-e00e-4e6006a6dffa@redhat.com>
Date:   Sun, 14 Aug 2022 18:30:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/3] mm: revert handling Non-LRU pages returned by
 follow_page
Content-Language: en-US
To:     Haiyue Wang <haiyue.wang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, linmiaohe@huawei.com,
        ying.huang@intel.com, songmuchun@bytedance.com,
        naoya.horiguchi@linux.dev, alex.sierra@amd.com
References: <20220812084921.409142-1-haiyue.wang@intel.com>
 <20220814140534.363348-1-haiyue.wang@intel.com>
 <20220814140534.363348-2-haiyue.wang@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220814140534.363348-2-haiyue.wang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.08.22 16:05, Haiyue Wang wrote:
> The commit
> 3218f8712d6b ("mm: handling Non-LRU pages returned by vm_normal_pages")
> doesn't handle the follow_page with flag FOLL_GET correctly, this will
> do get_page on page, it shouldn't just return directly without put_page.
> 
> So revert the related fix to prepare for clean patch to handle Non-LRU
> pages returned by follow_page.

What? Why?

Just fix it.

-- 
Thanks,

David / dhildenb

