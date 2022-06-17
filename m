Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D273A54FC60
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 19:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383307AbiFQRqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 13:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383268AbiFQRqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 13:46:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CDE42EF9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 10:46:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB18561F09
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 17:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DD3C3411B;
        Fri, 17 Jun 2022 17:46:26 +0000 (UTC)
Date:   Fri, 17 Jun 2022 18:46:22 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     will@kernel.org, mike.kravetz@oracle.com, songmuchun@bytedance.com,
        anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] arm64/hugetlb: Simplify the huge_ptep_set_access_flags()
Message-ID: <Yqy97gXI4Nqb7dYo@arm.com>
References: <d81f1c3215000d0f238900dbfa0a0976d8d00cd3.1653470369.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d81f1c3215000d0f238900dbfa0a0976d8d00cd3.1653470369.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 06:31:09PM +0800, Baolin Wang wrote:
> After commit bc5dfb4fd7bd ("arm64/hugetlb: Implement arm64 specific
> huge_ptep_get()"), the arm64 specific huge_ptep_get() will always
> consider the subpages' dirty and young state for CONT-PTE/PMD hugetlb,
> so there is no need to check them again when setting the access flags
> for CONT-PTE/PMD hugetlb in huge_ptep_set_access_flags().
> 
> Meanwhile this also fixes an issue when users want to make the CONT-PTE/PMD
> hugetlb's pte entry old, which will be failed to make the pte entry old
> since the original code will always consider the subpages' young state
> if the subpages' young state is set. For example, we will make the
> CONT-PTE/PMD hugetlb pte entry old in DAMON to monitoring the accesses,
> but we'll failed to monitoring the actual accesses of the CONT-PTE/PMD
> hugetlb page, due to we can not make its pte old.
> 
> Thus remove the code considering the subpages' dirty and young state in
> huge_ptep_set_access_flags() to fix this issue and simplify the function.

The ptep_set_access_flags() semantics (non-huge) never clear the access
flag, so mkold is not allowed. I think damon_hugetlb_mkold() is wrong in
assuming that huge_ptep_set_access_flags() allows a young->old huge pte
transition.

-- 
Catalin
