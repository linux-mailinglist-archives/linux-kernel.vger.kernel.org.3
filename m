Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E427A51F4C3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 08:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbiEIGtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 02:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236089AbiEIGqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:46:16 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EBB122B73
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 23:42:22 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id bo5so11442288pfb.4
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 23:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KwBbyH87QLuFybJCJK1L3o2HCzGQtzlhndyFtKBo1+M=;
        b=YUWb9VnH9CLdCOFSCg0EgRuHaol/guxgUnIE24J/u98QZ3I3dvqShcw6bHn8PbLn33
         De91e3fLiUGBZs3puXjUkFqnGkfsceO/2eweNFJzxUeEtvloQSE+QJUqsSR4B/n5rCXn
         fOwQjXfTmiY/r6o87bGR+3OcaUM524WjnTrpTYj/0PlXxJLh/+Gh7NH9mmwLwHUNU7RV
         798mKiROjo4EcdLxdwMlUkdsZDYVb3TJer8JHISDq/bQz+F1seNMMayMZJHD4rOjmga0
         GVFw2YGdi2fk3IJL1R+yM+i5a8XRpkgqS57S/UyObr/jP4lzVJidIkm4bfeiGNsDsFN7
         rlTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KwBbyH87QLuFybJCJK1L3o2HCzGQtzlhndyFtKBo1+M=;
        b=KiBl2dnFL/1GoYqabYHZTzv3Zoty4nUBItpM0Bfe8FRyUFZO7g0fFEfflyzCB4BtI+
         ynMKuKxwyk9miZW6NgwPTrJNnSGMlzHzed3wsEXbedWlHySHgFdxvvAZqFB2waRPQU8j
         ygmsgcD2NC6n3vEM4MmBweOfIUpNB55h5nXlPnjP5ojdvc8LjGANSVRm1lc65uVSlc59
         O2yCodqR18ET48a2gnu+c/D6SHZ3rB/cbNCObghktrmcqZUs9SRxzKh0k9ZPr97ahVN3
         jdTYcQgXvPhR9NgCJa6izIaXZ/nJhhOMhGa5QWcy565xKB6dPmfWmLKVO3LeU348KgdE
         3hfA==
X-Gm-Message-State: AOAM530DnuwUbovvDhZGCxdvhiXbSwf4CXqlbgqPvW3ip5m2tIGF6bDV
        MehPQg34pV83mpvbbuVcsxedPQ==
X-Google-Smtp-Source: ABdhPJzri2xI4eu2ZTD8cGUcHrOUq+LTIb9Xrei/K8/ULY+fOTzB8m7m6qoWPFqlzvQXcDaMYRtrhA==
X-Received: by 2002:a63:6987:0:b0:3c6:c3ce:5097 with SMTP id e129-20020a636987000000b003c6c3ce5097mr2699720pgc.293.1652078540543;
        Sun, 08 May 2022 23:42:20 -0700 (PDT)
Received: from localhost ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id r10-20020a170903020a00b0015e8d4eb21bsm6178989plh.101.2022.05.08.23.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 23:42:20 -0700 (PDT)
Date:   Mon, 9 May 2022 14:42:17 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        catalin.marinas@arm.com, will@kernel.org,
        tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org,
        davem@davemloft.net, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 3/3] mm: rmap: Fix CONT-PTE/PMD size hugetlb issue
 when unmapping
Message-ID: <Yni3yTLblEF5aJw5@FVFYT0MHHV2J.usts.net>
References: <cover.1652002221.git.baolin.wang@linux.alibaba.com>
 <43b11b69e9f0d9d7e7960b86661db27cc404d0c7.1652002221.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43b11b69e9f0d9d7e7960b86661db27cc404d0c7.1652002221.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 08, 2022 at 05:36:41PM +0800, Baolin Wang wrote:
> On some architectures (like ARM64), it can support CONT-PTE/PMD size
> hugetlb, which means it can support not only PMD/PUD size hugetlb:
> 2M and 1G, but also CONT-PTE/PMD size: 64K and 32M if a 4K page
> size specified.
> 
> When unmapping a hugetlb page, we will get the relevant page table
> entry by huge_pte_offset() only once to nuke it. This is correct
> for PMD or PUD size hugetlb, since they always contain only one
> pmd entry or pud entry in the page table.
> 
> However this is incorrect for CONT-PTE and CONT-PMD size hugetlb,
> since they can contain several continuous pte or pmd entry with
> same page table attributes, so we will nuke only one pte or pmd
> entry for this CONT-PTE/PMD size hugetlb page.
> 
> And now try_to_unmap() is only passed a hugetlb page in the case
> where the hugetlb page is poisoned. Which means now we will unmap
> only one pte entry for a CONT-PTE or CONT-PMD size poisoned hugetlb
> page, and we can still access other subpages of a CONT-PTE or CONT-PMD
> size poisoned hugetlb page, which will cause serious issues possibly.
> 
> So we should change to use huge_ptep_clear_flush() to nuke the
> hugetlb page table to fix this issue, which already considered
> CONT-PTE and CONT-PMD size hugetlb.
> 
> We've already used set_huge_swap_pte_at() to set a poisoned
> swap entry for a poisoned hugetlb page. Meanwhile adding a VM_BUG_ON()
> to make sure the passed hugetlb page is poisoned in try_to_unmap().
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
