Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B2B536FD8
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 08:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiE2FzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 01:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiE2FzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 01:55:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384AF56423
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 22:55:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFE1F60DEA
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 05:55:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3731CC34119;
        Sun, 29 May 2022 05:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653803715;
        bh=H52FMjaGR3TckVvkXZ+DeEnK4PrDJ0ytTMGlgH8OYUA=;
        h=From:To:Cc:Subject:Date:From;
        b=pQoXMVRPUiy1F+Q4V/u1diZEFbGNnKBdiPeFyDt6V2FeY5CVZ4/bmfMjTJEqWk2OK
         ZNnU3xVEDwgKBXAnI3hz7bfMZBXKZtbUfti6yIgC9k841vU2CZERlPAT73VH4tO6zK
         4USJjLQxzcdUiq9yQLfmXZEBX7xlWCWCTMutvHpxorAKreGShLmJCjR5lHuqu97aRr
         BzCqGSpiWK2B0RVnHl3S5FaCupev8TLtrkn4lW81wSadL3vzYGUmnulAI7IYupyk9M
         NYcYqG3Kc4TPIPtx+gXngJocqPM16aWa/ItYR9K50aphWzZD7+T3uKLqnLcfcXuxq4
         ZJZh7QBJPg/LQ==
From:   Gao Xiang <xiang@kernel.org>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 0/3] erofs: random decompression cleanups
Date:   Sun, 29 May 2022 13:54:22 +0800
Message-Id: <20220529055425.226363-1-xiang@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <hsiangkao@linux.alibaba.com>

Hi folks,

Now I'm working on cleanuping decompression code and doing some
folio adaption for the next 5.20 cycle, see:

https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git/log/?h=erofs/folios

This cleanup work completely gets rid of PageError usage finally
and tries to prepare for introducing rolling hashing for EROFS
since EROFS supports compressing variable-sized data instead of
fixed-sized clusters.

Therefore, EROFS can support rolling hash easily and our mechanism
can make full use of filesystem interfaces (byte-addressed) naturally.

Before that, I'd like to submit some trivial cleanups in advance for
the 5.19 cycle. All patches are without any logical change, so I can
have a more recent codebase for the next rework cycle.

Thanks,
Gao Xiang

Gao Xiang (3):
  erofs: get rid of `struct z_erofs_collection'
  erofs: get rid of label `restart_now'
  erofs: simplify z_erofs_pcluster_readmore()

 fs/erofs/zdata.c | 165 +++++++++++++++++++----------------------------
 fs/erofs/zdata.h |  50 +++++++-------
 2 files changed, 88 insertions(+), 127 deletions(-)

-- 
2.30.2

