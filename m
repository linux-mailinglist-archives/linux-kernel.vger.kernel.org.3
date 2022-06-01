Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E38153A05B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350478AbiFAJaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350477AbiFAJaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:30:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F34E35DA54
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 02:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654075798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xgyHZKDlB7p0BuLqs9M8WohBIMnlgdhuu+3hRlyeW88=;
        b=AiDy20If9cS9YXS6vLszxDL8mnL3zw7v2h2i4qPsAi2nMXbVDWtZWr9SaRK194n/74fDkg
        MKNiFkFiVrr7awfsM/EcmBxvBXbrfHQNCqmKFvrU7s33/uDk/Tdwn37e1LzzS1EOvhrSTr
        10Ts8ZJltdJ2XLkt+Ie9785i97MvB6Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-103-KjLXDmhFMYyymM_WmH0kOA-1; Wed, 01 Jun 2022 05:29:57 -0400
X-MC-Unique: KjLXDmhFMYyymM_WmH0kOA-1
Received: by mail-wm1-f70.google.com with SMTP id u12-20020a05600c19cc00b0038ec265155fso3057285wmq.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 02:29:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=xgyHZKDlB7p0BuLqs9M8WohBIMnlgdhuu+3hRlyeW88=;
        b=m6YJPD9PxPADcmipNHSuPYyCzwV2coqf8KxzqiD4c2TL+giCyuHXZbm0nTxm7AqOSR
         +VZCqFwLgf99/N7/O4bbbCK30IoAm1JVPpmY46sJslHufizGrjyKs54HTt7u+I1dNctt
         bQnBEB1Z/y4IrPR54LadYoR7MoRk7Bdra9OPyAFlfZx0CxynDzDXM6U4fFvSkKwW70Rj
         f2MOyie5J3cBeEezZ5deBPvqumdNBgQFPu19bUeokxtZRwjtVEpfyDaXs1/PdGzoT74Z
         B9cr4gEZNoRfUU5t2WVS0jHqU3tGPhEJINFWB5waDEoLQu9MNFZI20KiiLSsC2Wzly27
         x1pw==
X-Gm-Message-State: AOAM533qrfsMFcDdWbWr14pqbyPCrXEozoHvLo95GfcPX+QP8Hl9JFen
        UbOHLvcf2WpVgnYDD2MD36cm1CpkKBSr1UM6LHEcAAEduZtObtJd7jT8O3hsaiU2Zv4IfHEBW4O
        H0oX1Arxdzg1CGYsnwMiDTkJx
X-Received: by 2002:a5d:5686:0:b0:20e:63e7:8769 with SMTP id f6-20020a5d5686000000b0020e63e78769mr51278095wrv.419.1654075795909;
        Wed, 01 Jun 2022 02:29:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcIqqZdHxN0sh9iYav8gIoBSPR/rcvqW5Zg8PD/o3XgcU5QpPwH6r/7z/TzcYhFY+iy06BqQ==
X-Received: by 2002:a5d:5686:0:b0:20e:63e7:8769 with SMTP id f6-20020a5d5686000000b0020e63e78769mr51278080wrv.419.1654075795718;
        Wed, 01 Jun 2022 02:29:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:2600:951d:63df:c091:3b45? (p200300cbc7052600951d63dfc0913b45.dip0.t-ipconnect.de. [2003:cb:c705:2600:951d:63df:c091:3b45])
        by smtp.gmail.com with ESMTPSA id y18-20020a05600c365200b003942a244f54sm5510819wmq.45.2022.06.01.02.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 02:29:55 -0700 (PDT)
Message-ID: <77ae3b7d-a7d7-2484-cac1-d352d873ed1c@redhat.com>
Date:   Wed, 1 Jun 2022 11:29:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/3] mm: hugetlb_vmemmap: cleanup
 hugetlb_free_vmemmap_enabled*
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, mike.kravetz@oracle.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        smuchun@bytedance.com
References: <20220404074652.68024-1-songmuchun@bytedance.com>
 <20220404074652.68024-3-songmuchun@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220404074652.68024-3-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.04.22 09:46, Muchun Song wrote:
> The word of "free" is not expressive enough to express the feature of optimizing
> vmemmap pages associated with each HugeTLB, rename this keywork to "optimeze".
> In this patch , cheanup the static key and hugetlb_free_vmemmap_enabled() to make
> code more expressive.
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

