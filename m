Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA96451AEA8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377823AbiEDULv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245750AbiEDULq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:11:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71652220F2
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 13:08:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D3B9B8278E
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 20:08:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44497C385A4;
        Wed,  4 May 2022 20:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651694887;
        bh=FszPMrkUR8iR4oaqeA8GMiDU4Uhf7c3OI7I4qlR7I1o=;
        h=From:To:Cc:Subject:Date:From;
        b=UGtRSvRkBhB3r157OJ1djQrrAEH2E0aQKPlJP6FahBcQ9f2HT+DXCRoTgbxKIXZKk
         +FI5Qx/MDWCvq98QFEs9xUI/ZGD3IyBmdzaRiLZnIfv1SR6vTa6BRnaXmGH1D71a76
         OIeaHR1idLsIHr5bvDWyQGynHbNkCX35Ce2/RGvIGTfzBOXPU7ZpdPS8NwZQa6MfrJ
         CHs+JwP3/QtmyTOZXhr3gRTH/fSCrb1ndbDerSkQWe06xx5TE40JvwIoE947AXswnQ
         knIpEUJ1pmDt8D7I7NUWbFeqBnAOXbJ2rQIIIBL9nhGTJAjuVcS92HEqnjcEO6jt6S
         Ygj0tn4miefJg==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org, willy@infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH for mm-unstable 0/3] Fix build errors due to folio_test_large() misuse
Date:   Wed,  4 May 2022 20:07:55 +0000
Message-Id: <20220504200758.314478-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several commits on 'mm-unstable' replaces 'PageTransHuge()' with
'folio_test_large()' instead of 'folio_test_transhuge()'.  As a result,
several build errors occur when 'CONFIG_TRANSPARENT_HUGEPAGE' is unset.

This patchset fixes the issues by replacing the check to use
'folio_test_transhuge()'.

SeongJae Park (3):
  mm/vmscan: Use folio_test_transhuge() for THP check
  mm/shmem: Use folio_test_transhuge() for THP check
  mm/shmem: Use folio_test_transhuge() for THP check

 mm/shmem.c  | 8 ++++----
 mm/vmscan.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.25.1

