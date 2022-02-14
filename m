Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFD54B544D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355684AbiBNPOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:14:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344516AbiBNPOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:14:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F968D66
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:14:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F99761269
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 15:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0E3C340E9;
        Mon, 14 Feb 2022 15:14:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mHdKILnE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644851666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=V62yM0aklzEJ+7yFnFdsV3GEbLzbrL4e4e4vtXrNot4=;
        b=mHdKILnEIPB1YJFoHYhbeHd57pNsnnF+/+cCmCnmqM6d8bs8TyxhddPf3cCzYzkZwU1/YA
        kOyCKXa9AbH0jjcyGSnkUXribYRtsd542SDlbVlKFTOSbV4juyszfEMDeMgtYOcQymhhMz
        rlP3QqLycHd06ArMdR3cKlHaCJv7zTs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b2f26a59 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 14 Feb 2022 15:14:26 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        linux@dominikbrodowski.net, sultan@kerneltoast.com
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v3 0/2] random: cpuhp enhancements
Date:   Mon, 14 Feb 2022 16:14:13 +0100
Message-Id: <20220214151415.1108141-1-Jason@zx2c4.com>
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

This series combines the two uses thus far identified for cpuhp in
random.c. v3 now uses prepare instead of teardown.

Jason A. Donenfeld (2):
  random: set fast pool count to zero in cpuhp prepare
  random: invalidate crngs and batches in cpuhp prepare

 drivers/char/random.c      | 45 +++++++++++++++++++++++++-------------
 include/linux/cpuhotplug.h |  1 +
 include/linux/random.h     |  2 ++
 kernel/cpu.c               |  6 +++++
 4 files changed, 39 insertions(+), 15 deletions(-)

-- 
2.35.0

