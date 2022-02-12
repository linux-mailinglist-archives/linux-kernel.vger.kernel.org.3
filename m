Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D1E4B34E4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 13:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbiBLMXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 07:23:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiBLMXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 07:23:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B940A24BE5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 04:23:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89F2A60D36
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 12:23:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719B2C340E7;
        Sat, 12 Feb 2022 12:23:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZmgvObLo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644668605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Edu78Slk3keL46bYXPo4PPqvMk1tMqWFnH0+9/7BiN8=;
        b=ZmgvObLoxfPudW0Y8I05OQ8JcGxmBsniS2IKVWxHJiuynZLEVuQgFc4DJghc5lg0N0/ll6
        /tmSsAIETAiazbnkXHX4h1nEKV37K3E+uswIO5OL2U2Quh2Le6lzUVpTQx3hm7soU/1Wf8
        A5g5O9LPp9MwbYHVnqexKBnN0XdkNkI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6b7f3265 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 12 Feb 2022 12:23:24 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v2 00/10] random: re-group and re-document functions
Date:   Sat, 12 Feb 2022 13:23:08 +0100
Message-Id: <20220212122318.623435-1-Jason@zx2c4.com>
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

Jason A. Donenfeld (10):
  random: introduce drain_entropy() helper to declutter crng_reseed()
  random: remove useless header comment
  random: remove whitespace and reorder includes
  random: group initialization wait functions
  random: group crng functions
  random: group entropy extraction functions
  random: group entropy collection functions
  random: group userspace read/write functions
  random: group sysctl functions
  random: rewrite header introductory comment

 drivers/char/random.c  | 1899 ++++++++++++++++++++--------------------
 include/linux/random.h |    6 +-
 2 files changed, 950 insertions(+), 955 deletions(-)

-- 
2.35.0

