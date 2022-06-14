Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0334754AA4D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354169AbiFNHN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353748AbiFNHNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:13:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88A8614093
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655190800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LKlOpt8qSD0CmMZjWRzdbcAIzpT8dnJiO5KsKOkq/7A=;
        b=Dsy+hVDt0Q/U7b8EXXyZ0FitvOX6FVjKHUIQb5uWnXxyBNfOLS8Z9G/KJKZ7PmWaIpeRoj
        RD2qcOZQcJZ1Ob8uvsqU5Sjv69PxN4zfR1hJkendxThkVeYnjBS++kev5A6cPffDy3d9Xt
        Yzcf3SGZ90dWmaKrRq36+rCFRjsalzE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-499-MxFFbL5zOnuJZluGKZeZUQ-1; Tue, 14 Jun 2022 03:13:19 -0400
X-MC-Unique: MxFFbL5zOnuJZluGKZeZUQ-1
Received: by mail-wr1-f71.google.com with SMTP id q14-20020a5d61ce000000b00210353e32b0so1006481wrv.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=LKlOpt8qSD0CmMZjWRzdbcAIzpT8dnJiO5KsKOkq/7A=;
        b=cgXFEyG4biME4VhxWcOqLAUb/ZuVj2RdB0PDU5KACLZLBG4QerEfESVZUFu1gYT+3k
         4ARBe8FSf4LpUvhMk0Ly5qdBKSNeXvjCTyfKBYRlgIO8byyThB8rZiOudWxgOu+AgYqw
         wkpYTrgEVtZlkY2DjG5hqn3hMEoDnbNvjhdBDNRhN/ITJn63mlH/lPrAbR9h7E4NPGHO
         LfvxE8tFc/Q1NnQlo8qXsSQTSohDrPNDcg9j67lYE8n8cYAQ5WIA3yExDt1fvCJ1pYaS
         szEa+fyuO748dDNX2nYSMbtMHX3oHuUWgKknI8b0Jz5w1U9IUkVnYffj08saHmJ4grGI
         GPNw==
X-Gm-Message-State: AJIora8BBzpisiXvs5desh9td0JF+Cd5X4vZ+61yc1xEKGRVOgXB6qND
        /uvpw+wGjJn4m5AUqyNIF6qatUCZu2sRpw5ah41Pz6NjRcb8zhJXxZW1c6xr50VzS85PMLbmk97
        9oJWaTXgfZgsacunFK42AIECO
X-Received: by 2002:adf:e488:0:b0:20f:d981:4b42 with SMTP id i8-20020adfe488000000b0020fd9814b42mr3418607wrm.455.1655190798191;
        Tue, 14 Jun 2022 00:13:18 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sgovKaDqFV8QpEkIw4k+j83HoLwRExh4nSqw3y81ZcWHWy4RxHq503W6SY/MetIN7pvGyF+w==
X-Received: by 2002:adf:e488:0:b0:20f:d981:4b42 with SMTP id i8-20020adfe488000000b0020fd9814b42mr3418591wrm.455.1655190797985;
        Tue, 14 Jun 2022 00:13:17 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:cf00:aace:de16:d459:d411? (p200300cbc70bcf00aacede16d459d411.dip0.t-ipconnect.de. [2003:cb:c70b:cf00:aace:de16:d459:d411])
        by smtp.gmail.com with ESMTPSA id f6-20020a05600c4e8600b0039c6ce32a2dsm18645125wmq.33.2022.06.14.00.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 00:13:17 -0700 (PDT)
Message-ID: <66c43dac-32ac-5801-c76c-01607d68e38b@redhat.com>
Date:   Tue, 14 Jun 2022 09:13:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4 1/2] mm/memory-failure: introduce "hwpoisoned-pages"
 entry
Content-Language: en-US
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, zhenwei pi <pizhenwei@bytedance.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>
References: <20220614043830.99607-1-pizhenwei@bytedance.com>
 <20220614043830.99607-2-pizhenwei@bytedance.com>
 <20220614070934.GA1627546@hori.linux.bs1.fc.nec.co.jp>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220614070934.GA1627546@hori.linux.bs1.fc.nec.co.jp>
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

	   &hwpoisoned_pages);
> 
> I'm not sure how useful this interface from userspace (controlling test process
> with this?).  Do we really need to expose this to userspace? 
> 
> 
> TBH I feel that another approach like below is more desirable:
> 
>   - define a new flag in "enum mf_flags" (for example named MF_SW_SIMULATED),
>   - set the flag when calling memory_failure() from the three callers
>     mentioned above,
>   - define a global variable (typed bool) in mm/memory_failure.c_to show that
>     the system has experienced a real hardware memory error events.
>   - once memory_failure() is called without MF_SW_SIMULATED, the new global
>     bool variable is set, and afterward unpoison_memory always fails with
>     -EOPNOTSUPP.

Exactly what I had in mind.

-- 
Thanks,

David / dhildenb

