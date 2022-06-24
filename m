Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DE655A135
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbiFXSk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiFXSk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:40:57 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C43D7E007
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:40:57 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id jb13so2807472plb.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ONsbNtaIj+2QckCbaSTtKTSn8S/ItxiojyAwz7e9USc=;
        b=cYLbrnirigZc9e24pjc6GvP6fvS5I7GIHhuZ1xkZbJEKdHhli3jKq0oNtLOOrhTBii
         OuuMg9jUcYJoVNn5/05AyqnRAXLvLN/sKPv9lJhLG0FMvvQtlPUMKtyCqXXHftUNKFzY
         BVbgsvv65PYSJ6an2Z4KK0svZOO7TCReB+EiZZIrtw6dYh5znz721u4AXR9NhaSgw0Fc
         co1zFzpLSe5ghj8fIWIVv8ZNRaZOJueRv2Cp3552VD+BxHdbaZ1N/bAEf7+Lg62JV0y1
         19w2cBFP1vyb+JzfBOdaV9Ftv57XzBqScmgvEFpHR0jzj9Z/YEHn3HLrPZUtBy+dRxLi
         8y8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ONsbNtaIj+2QckCbaSTtKTSn8S/ItxiojyAwz7e9USc=;
        b=y/E5NOqVjN7KG6liOc53fbExtFIz7ox8dEHHqBWj8VSHFnClZ3zvh4F/RuVb4hwwTP
         uKcCiqbe9qLWc03f7Wo6xIZxr+4POg41ihyjQUPR5P0eQM6oFDMn2mMNYxmfFXGmOoeu
         hxZkPI9cbgPYJISD60U3Kz+jyiB7EDD7gaachQp3fOJQDWz5KYepk3E4GUdDE4gDV1Bj
         zgsIR9AEBCx9q0olEWlPxiG3a5Y7ycCAMLaVsdUgOlGS439Tvvk1f6V2S6ksh4jGDdHV
         wT2jksWSx1ls67yo4/ugg05nAOL3gS5g04AKwN9pRKGE7PGfh4dTwbUQJOqnkMoIsLuy
         h8mQ==
X-Gm-Message-State: AJIora8YyZt86+FgJH3Hpvu9H2IWXlTtj5dEeMtQ6DCDF/kEkRA5GEhQ
        O5TWabKesAhuPFJL4xeRvGmzNPB8pcVDBw==
X-Google-Smtp-Source: AGRyM1vGr/sif3V7DYQiRNsgTb/FtTyE8ZlsUKZjm/7O5khucthxuW043co6l+yxIPQnKACg5C44Vg==
X-Received: by 2002:a17:902:8eca:b0:16a:285e:5878 with SMTP id x10-20020a1709028eca00b0016a285e5878mr425735plo.59.1656096056633;
        Fri, 24 Jun 2022 11:40:56 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id t5-20020a17090abc4500b001ea629a431bsm2120609pjv.8.2022.06.24.11.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 11:40:55 -0700 (PDT)
Date:   Fri, 24 Jun 2022 11:40:51 -0700
From:   Zach O'Keefe <zokeefe@google.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        akpm@linux-foundation.org, shy828301@gmail.com,
        willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/16] mm/huge_memory: access vm_page_prot with READ_ONCE
 in remove_migration_pmd
Message-ID: <YrYFM+xKu4Q7XJxz@google.com>
References: <20220622170627.19786-1-linmiaohe@huawei.com>
 <20220622170627.19786-3-linmiaohe@huawei.com>
 <20220623031401.wdyt5ylin4aijzhh@box.shutemov.name>
 <7ee4a597-d7cb-f387-5613-f51b17262745@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ee4a597-d7cb-f387-5613-f51b17262745@huawei.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Jun 20:03, Miaohe Lin wrote:
> On 2022/6/23 11:14, Kirill A. Shutemov wrote:
> > On Thu, Jun 23, 2022 at 01:06:13AM +0800, Miaohe Lin wrote:
> >> vma->vm_page_prot is read lockless from the rmap_walk, it may be updated
> >> concurrently. Using READ_ONCE to prevent the risk of reading intermediate
> >> values.
> > 
> > Have you checked all other vm_page_prot reads that they hold mmap_lock?
> 
> I took a glance when I made this patch.
> 
> > 
> > I think the right fix would be to provide a helper to read vm_page_prot
> > which does READ_ONCE() and use it everywhere. This seems more sustainable.
> > 
> 
> This patch is inspired from the below commit
>   6d2329f8872f ("mm: vm_page_prot: update with WRITE_ONCE/READ_ONCE")
> 
> It changed all the places that need to use READ_ONCE. But remove_migration_pmd
> is missed due to it's introduced later. It looks fine to add a helper to read
> vm_page_prot which does READ_ONCE() but READ_ONCE is unneeded while under the
> mmap_lock, so might it be a little overkill to add a helper because the helper
> is used iff mmap_lock is not held?
> 
> Thanks.

IMO adding the READ_ONCE() as proposed in fine. Adding a helper to be called
dependent on locking context still requires the caller / dev to know what the
locking context is - so I don't think it provides much benefit.
