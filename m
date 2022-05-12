Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C24524E41
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354430AbiELN2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354432AbiELN2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:28:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84AA5254725
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652362117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KT6h28c6FQD8WyyLf1kzx7k7ZU7RBGOfeeKfHOgWvew=;
        b=IKpQBp5wK0MKmeho4/YTkWZL6xendf8sP5oJU6vPQHPj0KW/pfZmSfcI4kXbzVOGRtZAe8
        cDkGMeDw3XPPqUvcF/BSbTDpNec4pdcwBcwLi0GME9lTvENexmjh7uplMChrGHf8lSsTBB
        MKK06cMC6vqENuBpWi+8ARS9Yarl0mQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-548-EzkCloEANGG1I3aGwdA-3g-1; Thu, 12 May 2022 09:28:33 -0400
X-MC-Unique: EzkCloEANGG1I3aGwdA-3g-1
Received: by mail-wm1-f70.google.com with SMTP id v9-20020a05600c214900b00393fedddf26so2021765wml.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=KT6h28c6FQD8WyyLf1kzx7k7ZU7RBGOfeeKfHOgWvew=;
        b=N2yRexL/t5NnEDel5Pk8264TWdBThLSkDDGELgKcnQkHBdBUzZ3Kp5Gb10Qs+nG93a
         KvomGswrsQhx2tKG6Kntbrjx+iCg4opyM9rHgTs8EkUfZw25o1W5AcK3am8Vidf5whid
         Vn5hp9CTKgw2Ggwbvh2HlDg8cHmEMCh7g8PS2WlmDYDIL1tEJ6JvOOfRInipQQEVTrQB
         oSkazwCXyCQf+RYD6lxZOuklVw6FELJMFawvOySluD74pMVnkzod1KUVUOKrS9mWOdOk
         UKmZlmO8FnWLwV7XcybBdC7mbl1T1j84xKOolKjeQpxDzvQ1cZUBTZ1UpjTjoF/fRFFZ
         0u1Q==
X-Gm-Message-State: AOAM531cx2fvIoBwxUk1hmvzFsn3JMpmuWA6apeTFEUJeh4iWECgvemV
        RrAAbV6Blg2OwJ2eZvAIGhWK+HMmDbvdzt72sQ8lupRl1Ay5Z8XHm/cY+uBPAoR2mEbKHPuOOmR
        qX4Wj1gd9z/Dxaw3W3DfaMgVu
X-Received: by 2002:a7b:c081:0:b0:394:789b:915 with SMTP id r1-20020a7bc081000000b00394789b0915mr9956593wmh.105.1652362111721;
        Thu, 12 May 2022 06:28:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyII1WkT/1UdDy3LvquMc1vUiRzlC0CdL+SwCEEo9ml4cLb6aQnHL5auQcdvNCZjvP/2rzAHw==
X-Received: by 2002:a7b:c081:0:b0:394:789b:915 with SMTP id r1-20020a7bc081000000b00394789b0915mr9956581wmh.105.1652362111508;
        Thu, 12 May 2022 06:28:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:d200:ee5d:1275:f171:136d? (p200300cbc701d200ee5d1275f171136d.dip0.t-ipconnect.de. [2003:cb:c701:d200:ee5d:1275:f171:136d])
        by smtp.gmail.com with ESMTPSA id x14-20020a7bc20e000000b003942a244f31sm2708341wmi.10.2022.05.12.06.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 06:28:30 -0700 (PDT)
Message-ID: <110e1d53-3377-57b2-c92c-e6a64a508be6@redhat.com>
Date:   Thu, 12 May 2022 15:28:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 02/15] mm/swap: use helper macro __ATTR_RW
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     willy@infradead.org, vbabka@suse.cz, dhowells@redhat.com,
        neilb@suse.de, apopple@nvidia.com, surenb@google.com,
        peterx@redhat.com, naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220509131416.17553-1-linmiaohe@huawei.com>
 <20220509131416.17553-3-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220509131416.17553-3-linmiaohe@huawei.com>
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
> Use helper macro __ATTR_RW to define vma_ra_enabled_attr to make code more
> clear. Minor readability improvement.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

