Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C214E5AF372
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 20:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiIFSUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 14:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiIFSUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 14:20:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246C0647DD
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 11:20:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5382B819CB
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 18:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2692C433D6;
        Tue,  6 Sep 2022 18:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662488408;
        bh=GEJkql041XXCsjNgtcCyFYYz65fNAGYwfs5meFdVjWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KBxn9Hm/BZ1H6OGeq5gyTeP5SB8glt+bMpRbFHQvBuKeJTYFnraod3Fsa1syirqGk
         1Q1zyaVGYR8KZ0TPNq+f7xNnMgUAaDTocIJogGjT3HsnWTBXAiZl8hX36aAcFB6yXV
         s/zuxdvIShLJytiqyG7rYtt3IJgRpXoJe33ZIl5JWWJOVjzxE0vAMfIMbGgLDSDfoX
         rQiI/BKObHqA73TV86kC2MUuamKgBIL8XpB6uqEd/PmrlzslOkj0q94buhCm7yQzCo
         geVFa1I+rbuRpVhG45hs2UdFHrWD1k17zafVMfD87VeGLaXS8fd4FeIcomP9wUIH1t
         +iPVNd/SsxSNg==
From:   SeongJae Park <sj@kernel.org>
To:     xiakaixu1987@gmail.com
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH] mm/damon/core: iterate the regions list from current point in damon_set_regions()
Date:   Tue,  6 Sep 2022 18:20:06 +0000
Message-Id: <20220906182006.50955-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1662477527-13003-1-git-send-email-kaixuxia@tencent.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kaixu,

On Tue, 6 Sep 2022 23:18:47 +0800 xiakaixu1987@gmail.com wrote:

> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> We iterate the whole regions list every time to get the first/last regions
> intersecting with the specific range in damon_set_regions(), in order to
> add new region or resize existing regions to fit in the specific range.
> Actually, it is unnecessary to iterate the new added regions and the
> front regions that have been checked. Just iterate the regions list from
> the current point using list_for_each_entry_from() every time to improve
> performance.
> The kunit tests passed:
>  [PASSED] damon_test_apply_three_regions1
>  [PASSED] damon_test_apply_three_regions2
>  [PASSED] damon_test_apply_three_regions3
>  [PASSED] damon_test_apply_three_regions4
> 
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
