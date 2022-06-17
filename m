Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C4454F2E0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380977AbiFQI0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 04:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380969AbiFQI03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:26:29 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24ED26898C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:26:28 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id b12-20020a17090a6acc00b001ec2b181c98so2372194pjm.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yr0ixUanPwolWpl8lCaQhXzB90rLEzIJZVwDXXKPA0U=;
        b=T0JCgWDTB1C2DISDgdZ4UDVFOWnRp2zy2MnmauLXScjZ1nAwZFhugPqk7LJHr/ZqYR
         gS7AQ2LY7MCi12zojIG7f8Ph+i4IbqU+gY2wftHcxhfe5I/JxipjHT9G+VpC1zh5K6vU
         duBUQkQeO+lYH2S0APPy5npNumr73wIpqlOnbbnKsqaOmmaPmmMnefSyRGqfn72oeVHY
         4XT/louGb1lBLYbfoesSgG/+I51syqllEu+lF2uvmS6543R3TVlllAbeuSojS2oaZNiz
         0vsqAzWz7egUsoU66blaHOD0ko2YmWG/bFdUR0JWK3PFEfpAyeZtKbMvGonQ25pbr7g8
         /rng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yr0ixUanPwolWpl8lCaQhXzB90rLEzIJZVwDXXKPA0U=;
        b=nyf1vQFjiE8lTWVV1Rb9U8cAIMs+pfkQLUK19UyD+fxbI/DJNFJQro3q+XhZ+NkDDI
         cQ6yTMzl9gyENkRWtjtgmejxIr97myOsYkuxG7Iy9RlifdR1f8aiJ6YRd0nZQXHP0nOy
         4QuKYovi7w7ViUCAAIoVPt2zaJqrs2RBfbbWX1WBFUSj07ZFcOt+UupG5T1Qfz9DtRzS
         xHfIMwkkhlmZXgvdGlQkLVjGEcD/7m83FbeaY+XVo8niXjHRLvz79VdB41sU5ohgC0rF
         nNJRG5rPuoeMoQOZH8/vaXZN7ixoexzTgB341XI3gTA8jliuE+ZHilufwOQ066bCVdhN
         iSXg==
X-Gm-Message-State: AJIora/i7MjdpsuIQZCpfwOsmfj8iN969sXhPzUNbxzzBtO20N9Zp4Wy
        krw4NIAzUb1yijmoVUo2UwBEwQ==
X-Google-Smtp-Source: AGRyM1t5yEL1BPz7y9ug30F37C0ubzhxM59TWM8YWNbgEGd6O1gO2tufJo02mvgvoeRwcOdvYuG/tA==
X-Received: by 2002:a17:903:22cb:b0:167:992f:60c3 with SMTP id y11-20020a17090322cb00b00167992f60c3mr8629830plg.59.1655454387624;
        Fri, 17 Jun 2022 01:26:27 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902cf0c00b001677fa34a07sm2974542plg.43.2022.06.17.01.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 01:26:27 -0700 (PDT)
Date:   Fri, 17 Jun 2022 16:26:23 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        catalin.marinas@arm.com, will@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/4] arm64/hugetlb: Implement arm64 specific
 hugetlb_mask_last_page
Message-ID: <Yqw6r0/r34sZdrsk@FVFYT0MHHV2J.usts.net>
References: <20220616210518.125287-1-mike.kravetz@oracle.com>
 <20220616210518.125287-3-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616210518.125287-3-mike.kravetz@oracle.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 02:05:16PM -0700, Mike Kravetz wrote:
> From: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> The HugeTLB address ranges are linearly scanned during fork, unmap and
> remap operations, and the linear scan can skip to the end of range mapped
> by the page table page if hitting a non-present entry, which can help
> to speed linear scanning of the HugeTLB address ranges.
> 
> So hugetlb_mask_last_page() is introduced to help to update the address in
> the loop of HugeTLB linear scanning with getting the last huge page mapped
> by the associated page table page[1], when a non-present entry is encountered.
> 
> Considering ARM64 specific cont-pte/pmd size HugeTLB, this patch implemented
> an ARM64 specific hugetlb_mask_last_page() to help this case.
> 
> [1] https://lore.kernel.org/linux-mm/20220527225849.284839-1-mike.kravetz@oracle.com/
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Acked-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
