Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FAC524E4C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354451AbiELNaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354447AbiELNa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:30:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10070254732
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652362224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mhgzQ0sYOrkkd/icNMNnVcPCn+/prPaIhVzGXVb8GiY=;
        b=UCi3IjF9XeeL5oCCnXuVhrNj1WG4Tygz/EArcb2U/kkIfS7BzT3jDcjRVM5PipEpv7BoQ6
        O//U6jTibHtWOivKE0MmcdqD/dXr+H2XMhkmKB6qT+Jtql2RTujBLb4Wg5f9Hm00LDmmWp
        H/cPvBaXsq5gZHF0TUSDV2hirrj00qM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-LzGPgdlVMMKZg14URQzOYA-1; Thu, 12 May 2022 09:30:22 -0400
X-MC-Unique: LzGPgdlVMMKZg14URQzOYA-1
Received: by mail-wm1-f69.google.com with SMTP id k35-20020a05600c1ca300b003946a9764baso4408499wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=mhgzQ0sYOrkkd/icNMNnVcPCn+/prPaIhVzGXVb8GiY=;
        b=qd5Apr4EX1kcmx64MWE8HYIvC+dN1NtwAWYTqo50i4LxMqZbF24H7ErrB7aKNfYIsf
         PkA2BACaCpH0Ic4bzromq3IRU7QTSHW+uIQRAWc46Z6g0jexx8fRRWbMO5yTQ98d7OIY
         SSWgF8c1TWdIeJRqWwYXzsvVtDxYKz42XovMNc4BwzIUDyTiy43kYP0en9/zF1qufaj2
         MIwKtKpT7xNO7eeq/yV/z89AhQZVgCDvF0d4PJyegpwgSYk+cCkaMxmpb+9SubOeeQXO
         7lNqUh8hFgpTOTkPTL67ojee1hug2vWEFlZrTH5xVlW85K1ClZdzwMPMo9BV187+CTt2
         oiDA==
X-Gm-Message-State: AOAM530nd2+j93gcozhVdZHwUQxxWIM5DiWlbXIvn862NeZ8ozaWgoq5
        mnDLL/09mFb0CPVf+YtLbhowTNgiGHU3OpdZCroKFhtEj9QAznCgZZCzpw6u9kHvgQS1eVDU/Fd
        izHYUWgXHj7mxkywR9tcbbNs8
X-Received: by 2002:a05:600c:19c8:b0:394:7cb0:717b with SMTP id u8-20020a05600c19c800b003947cb0717bmr10336791wmq.136.1652362221785;
        Thu, 12 May 2022 06:30:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwverS5Puo2YeeGw5pQo/ZdVqDE+SwXK3m37sixe0PYqzGfxHuFJSC81mVsBxlHyxPIsbs3AQ==
X-Received: by 2002:a05:600c:19c8:b0:394:7cb0:717b with SMTP id u8-20020a05600c19c800b003947cb0717bmr10336771wmq.136.1652362221596;
        Thu, 12 May 2022 06:30:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:d200:ee5d:1275:f171:136d? (p200300cbc701d200ee5d1275f171136d.dip0.t-ipconnect.de. [2003:cb:c701:d200:ee5d:1275:f171:136d])
        by smtp.gmail.com with ESMTPSA id s19-20020a1cf213000000b003942a244edfsm2697674wmc.36.2022.05.12.06.30.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 06:30:20 -0700 (PDT)
Message-ID: <c6efff47-5cf1-f88a-2504-43da1664fbb7@redhat.com>
Date:   Thu, 12 May 2022 15:30:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 04/15] mm/swap: remove unneeded return value of
 free_swap_slot
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     willy@infradead.org, vbabka@suse.cz, dhowells@redhat.com,
        neilb@suse.de, apopple@nvidia.com, surenb@google.com,
        peterx@redhat.com, naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220509131416.17553-1-linmiaohe@huawei.com>
 <20220509131416.17553-5-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220509131416.17553-5-linmiaohe@huawei.com>
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
> The return value of free_swap_slot is always 0 and also ignored now.
> Remove it to clean up the code.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

