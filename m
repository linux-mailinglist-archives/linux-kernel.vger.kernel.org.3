Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D13658A7CF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 10:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237392AbiHEIK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 04:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240222AbiHEIK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 04:10:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8BB31C135
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 01:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659687024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Atr+DhHiSOWmg4pa/shGgRsQSRBKuEt9aU4m/334aTs=;
        b=GyVo8EhCni5tUPsEOcoow2dNAwefz5ozYQZkL88kgEGIz7krMek9CHyhbjGh1MDcm7njXp
        E7+VQbSsfsqiowBnXMb3Gj0geF3oGHTeyUF3FMXydfHTBeiKLGLODOtruEc3n9U0sXOrPM
        S/3sDqxv9i5CH+qswjbGkMCFmNa6SP4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-9UkwCuKLNqSUuKvquGkHlg-1; Fri, 05 Aug 2022 04:10:22 -0400
X-MC-Unique: 9UkwCuKLNqSUuKvquGkHlg-1
Received: by mail-wm1-f72.google.com with SMTP id 189-20020a1c02c6000000b003a50fa69823so993133wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 01:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=Atr+DhHiSOWmg4pa/shGgRsQSRBKuEt9aU4m/334aTs=;
        b=0sOONnBS/u1LSpHHuKxrZw/IYn8uUP93kxBaHtnt78C9w5aq0Y9vwxYA6Mw7U5a4Fo
         kfcct+MSUSO0yWBf09IUjA4Hjlwa5TW27duKK5Py8PXogI4yH50Ktyf5DBDAD4IBVKUf
         ahS8GFwFLRfgFlOm7SUzCtXdQLWLmV8FIq0+Prius9lFk0NDyxjAdfT41N80lXldXT07
         /tYZXU+USs7uSMpBZH53kMN3mheZsIlkiVSo9qhcY032P0RSlmIBJvX8Xm826xofGtyv
         dJB3vig5PHy7GDOPWyC+uqa2zRD1S4d+zQX2NV7BrjeaHmBCg1JaJpWzCwDkZByFCDdz
         MhtQ==
X-Gm-Message-State: ACgBeo09fq/Dnnyj7BCAMtwJ/HsQaOFJuHz2NlYwTFfG1bGDC0IZOe5k
        gvuQNue7aF0nW07GzfjjgMqh3EpLsx++qy+zM+tnTX89ZPjCCLssJuG4PCJieZPEDziYUvbC6Ud
        QMuF094aJq73mZ/iCXadzKPpl
X-Received: by 2002:a05:600c:1d16:b0:3a5:2240:da2e with SMTP id l22-20020a05600c1d1600b003a52240da2emr416846wms.136.1659687021806;
        Fri, 05 Aug 2022 01:10:21 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7KqFFWWJFPfWJSaVVoqqHnK3ueHfpqrvra3oyJst8TIyPiytSvU5+peoIm9xxviMav/0gp2A==
X-Received: by 2002:a05:600c:1d16:b0:3a5:2240:da2e with SMTP id l22-20020a05600c1d1600b003a52240da2emr416830wms.136.1659687021608;
        Fri, 05 Aug 2022 01:10:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:fb00:f5c3:24b2:3d03:9d52? (p200300cbc706fb00f5c324b23d039d52.dip0.t-ipconnect.de. [2003:cb:c706:fb00:f5c3:24b2:3d03:9d52])
        by smtp.gmail.com with ESMTPSA id i17-20020a05600011d100b0021e9d98bec4sm3218381wrx.88.2022.08.05.01.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 01:10:21 -0700 (PDT)
Message-ID: <cb695e26-350a-0857-5430-b7e4f81607b1@redhat.com>
Date:   Fri, 5 Aug 2022 10:10:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] mm/gup.c: Don't pass gup_flags to
 check_and_migrate_movable_pages()
Content-Language: en-US
To:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Ralph Campbell <rcampbell@nvidia.com>
References: <3e20a542e756bbc0f66435c9344ff674f3ff7ac7.1659680600.git-series.apopple@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <3e20a542e756bbc0f66435c9344ff674f3ff7ac7.1659680600.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.08.22 08:29, Alistair Popple wrote:
> gup_flags is passed to check_and_migrate_movable_pages() so that it can
> call either put_page() or unpin_user_page() to drop the page reference.
> However check_and_migrate_movable_pages() is only called for
> FOLL_LONGTERM, which implies FOLL_PIN so there is no need to pass
> gup_flags.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  mm/gup.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

