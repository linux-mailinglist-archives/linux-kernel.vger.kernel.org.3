Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF4452209D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346952AbiEJQJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347919AbiEJQHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:07:20 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6002233A4C
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:59:46 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso2390801pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KuCtcNBo2th0pyg6CQP5aLGHC2ZuCU/pAXEksyolVoU=;
        b=lgotZpreFtTnnYoimROqXkO4uhY57bam/rtfjWKifG/AuGv+HsZqvuPhBnGSgTaPIF
         r7ETfUUBr3FS5NT66Fk2LR3UNtOglgYktF3EiL7ZVSq5qtZa2aa/HthnUFjX4+Wdi2k8
         S//9aaN3jKuDbnqAPuo/IqPM1LhGt0DvsAaBwqCPhALM48a4cymQbZQkyPxHQM4rWRGw
         vZxPUyNDdMMtbye0LXX0ayBr/Fe1iGF8FqoK06Y+O8+HunfIhmszFQlb4wcjBePmEUw+
         LsUFUFcY6VrSS7eWNkIUlzgL3LS6ri5RkWa6Sp48hI6qhRSFZPpp1O9nIhodgaY1rLux
         eIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KuCtcNBo2th0pyg6CQP5aLGHC2ZuCU/pAXEksyolVoU=;
        b=6PjLYjU2E1Ccl3EP96uAkkD3BQSyxBIF8ZYm5yAUrJqP+YITo5twDTNE3RGq8RPZWR
         4d/fIo8U8c8nCJ2gr2lPl9u0CIpfoUR8iNzXqHqmivDU1oM4L289GZDZN4KJWYX7C0av
         TubX28VKA+zhxdrSNcoHKB2iKNip6vpIeLKCCrdUyjFhXsFPxCcdeXTYTR/KmE9HYfrH
         WLGIkFvogBj8S35EbqN9NYUjZj7cDTpPScFqVTNVK5/NGWhgSqiP14YeSRpYLJ+Hp0vV
         +4Bq4I0hRPiutogXuOcIei6AxXgxRIKHjdMt8QU2tLRsmmKZ3KguSTfzpUUHQVteythq
         gXgQ==
X-Gm-Message-State: AOAM533uzsEt8lLLRteFv/0m97oo1fXq5limM2tHPvYIj+9OI6HUCEgm
        oQuZR44RWkZEd0bTmw4JNKu0wA==
X-Google-Smtp-Source: ABdhPJxlpU+UaeWLUkm8hatrmy72Dil0hhUtITD5l3Yx7ekqlkw15OjfCbtf7aFVGEXDjdTtLnehQg==
X-Received: by 2002:a17:90b:38c7:b0:1dc:77aa:e3d5 with SMTP id nn7-20020a17090b38c700b001dc77aae3d5mr626801pjb.51.1652198385814;
        Tue, 10 May 2022 08:59:45 -0700 (PDT)
Received: from localhost ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id s43-20020a056a001c6b00b0050dc762819dsm10600511pfw.119.2022.05.10.08.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:59:45 -0700 (PDT)
Date:   Tue, 10 May 2022 23:59:41 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, willy@infradead.org,
        anshuman.khandual@arm.com, christophe.leroy@csgroup.eu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/2] arm64/hugetlb: Implement arm64 specific
 huge_ptep_get()
Message-ID: <YnqL7aLv+5fLsj/L@FVFYT0MHHV2J.usts.net>
References: <cover.1652180088.git.baolin.wang@linux.alibaba.com>
 <de94fc10e396668537909b71939aff6fd2579dfb.1652180088.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de94fc10e396668537909b71939aff6fd2579dfb.1652180088.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 07:12:53PM +0800, Baolin Wang wrote:
> Now we use huge_ptep_get() to get the pte value of a hugetlb page,
> however it will only return one specific pte value for the CONT-PTE
> or CONT-PMD size hugetlb on ARM64 system, which can contain seravel
> continuous pte or pmd entries with same page table attributes. And it
> will not take into account the subpages' dirty or young bits of a
> CONT-PTE/PMD size hugetlb page.
> 
> So the huge_ptep_get() is inconsistent with huge_ptep_get_and_clear(),
> which already takes account the dirty or young bits for any subpages
> in this CONT-PTE/PMD size hugetlb [1]. Meanwhile we can miss dirty or
> young flags statistics for hugetlb pages with current huge_ptep_get(),
> such as the gather_hugetlb_stats() function, and CONT-PTE/PMD hugetlb
> monitoring with DAMON.
> 
> Thus define an ARM64 specific  huge_ptep_get() implementation, that will
> take into account any subpages' dirty or young bits for CONT-PTE/PMD size
> hugetlb page, for those functions that want to check the dirty and young
> flags of a hugetlb page.
> 
> [1] https://lore.kernel.org/linux-mm/85bd80b4-b4fd-0d3f-a2e5-149559f2f387@oracle.com/
> 
> Suggested-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

LGTM. Thanks for your work.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
