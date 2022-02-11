Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9AE4B25E1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350131AbiBKMgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:36:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239724AbiBKMgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 07:36:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309E7D52
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 04:36:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB1AAB829DB
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 12:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E670C340E9;
        Fri, 11 Feb 2022 12:36:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="UWmHL3u9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644582962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iCGr98JUQHqxOqZQ4ZwMPXTmnJlXf1jMu/AA4yiTmQM=;
        b=UWmHL3u93MArr4eEUt1XCDIzglpxW38wPi1a1lx3CBh3rPqblyYrI1FzM4GWrsW9hQo6pF
        LrN/52eTosu32IEq/ko6bZcLUu+E2SgW57RqjdjS6DWouXuw/LCH9RkEy847qeACkLvp0n
        aettbroUp5JE261FpJl/9gbknIkjDq4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 948ce582 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 11 Feb 2022 12:36:02 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 0/9] random: re-group and re-document functions
Date:   Fri, 11 Feb 2022 13:35:37 +0100
Message-Id: <20220211123546.474952-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We previously had massive documentation comments and functions strewn
all about. This attempts to restore sanity by dividing the code into a
few sections:

- Initialization and readiness waiting.
- Fast key erasure RNG.
- Entropy accumulation and extraction.
- Entropy collection.
- Userspace read/write.
- Sysctl.

The result of this ordering and this grouping is only 2 forward
declarations, indicating that this is probably a sensible grouping.
Also, some documentation that was just hopelessly out of date been
removed. We'll later look into re-adding parts of this to the Linux man
pages project.

No functional changes.

Jason A. Donenfeld (9):
  random: introduce drain_entropy() helper to declutter crng_reseed()
  random: remove useless header comment
  random: rewrite header introductory comment
  random: group initialization wait functions
  random: group crng functions
  random: group entropy extraction functions
  random: group entropy collection functions
  random: group userspace read/write functions
  random: group sysctl functions

 drivers/char/random.c  | 1912 ++++++++++++++++++++--------------------
 include/linux/random.h |    6 +-
 2 files changed, 952 insertions(+), 966 deletions(-)

-- 
2.35.0

