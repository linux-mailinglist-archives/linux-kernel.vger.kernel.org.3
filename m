Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77D25293DA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 00:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347009AbiEPWx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 18:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiEPWxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 18:53:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7792B41982
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 15:53:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A810B816A1
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 22:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68104C385B8;
        Mon, 16 May 2022 22:53:18 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>, will@kernel.org
Cc:     christophe.leroy@csgroup.eu, anshuman.khandual@arm.com,
        akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mike.kravetz@oracle.com, willy@infradead.org,
        songmuchun@bytedance.com
Subject: Re: [PATCH v3 0/2] Implement arm64 specific huge_ptep_get()
Date:   Mon, 16 May 2022 23:53:15 +0100
Message-Id: <165274157825.4033361.18236433604256004496.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1652496622.git.baolin.wang@linux.alibaba.com>
References: <cover.1652496622.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2022 08:55:56 +0800, Baolin Wang wrote:
> As Mike pointed out [1], the huge_ptep_get() will only return one specific
> pte value for the CONT-PTE or CONT-PMD size hugetlb on ARM64 system, which
> will not take into account the subpages' dirty or young bits of a CONT-PTE/PMD
> size hugetlb page. That will make us miss dirty or young flags of a CONT-PTE/PMD
> size hugetlb page for those functions that want to check the dirty or
> young flags of a hugetlb page. For example, the gather_hugetlb_stats() will
> get inaccurate dirty hugetlb page statistics, and the DAMON for hugetlb monitoring
> will also get inaccurate access statistics.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/2] arm64/hugetlb: Use ptep_get() to get the pte value of a huge page
      https://git.kernel.org/arm64/c/f0d9d79ec793
[2/2] arm64/hugetlb: Implement arm64 specific huge_ptep_get()
      https://git.kernel.org/arm64/c/bc5dfb4fd7bd

-- 
Catalin

