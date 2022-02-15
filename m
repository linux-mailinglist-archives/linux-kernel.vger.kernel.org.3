Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C9A4B79CD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 22:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbiBOVXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 16:23:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiBOVXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 16:23:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0593BD64DC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 13:23:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56953B81CFA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 21:23:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A06C340EB;
        Tue, 15 Feb 2022 21:23:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="aVWy754E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644960180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tvTbX6Pe1XbtfXBBqGBLmCFd3rOkDoAEeQ9gDayuOrk=;
        b=aVWy754E7Rb0yvcp2d21ByjSaDmeSXk3f1HtgtZPhtMAImZ+xqSbmEBHd4+whp7fTa72xW
        wTwlS/F/CzHxBZLRyuRSgDtNNSJAlRdhUi8V8rrqVegBgrboJ8CpPTKxDkyTD16D8OBeVt
        9NpxmLrD6/Ur69ili0+ohV7QW0nc9GQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id af02fa27 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 15 Feb 2022 21:23:00 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        linux@dominikbrodowski.net, sultan@kerneltoast.com
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v4 0/2] cpuhp enhancements
Date:   Tue, 15 Feb 2022 22:22:53 +0100
Message-Id: <20220215212255.273253-1-Jason@zx2c4.com>
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
random.c. v3 uses prepare instead of teardown. v4 guards the added
function with CONFIG_SMP, since it's not used on !CONFIG_SMP.

Jason A. Donenfeld (2):
  random: set fast pool count to zero in cpuhp prepare
  random: invalidate crngs and batches in cpuhp prepare

 drivers/char/random.c      | 47 ++++++++++++++++++++++++++------------
 include/linux/cpuhotplug.h |  1 +
 include/linux/random.h     |  4 ++++
 kernel/cpu.c               |  6 +++++
 4 files changed, 43 insertions(+), 15 deletions(-)

-- 
2.35.0

