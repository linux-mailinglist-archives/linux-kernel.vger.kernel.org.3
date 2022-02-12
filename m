Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC644B3881
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 00:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbiBLXKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 18:10:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbiBLXKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 18:10:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E4835847
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 15:10:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A53CC60EB6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 23:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0771C340E7;
        Sat, 12 Feb 2022 23:10:31 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Mi54mLqK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644707430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7YG/XJSzqlxZ/i5enG7WzcJaWlr/mo39yNxPsg19l0U=;
        b=Mi54mLqKAQ8+gxKCEYIIbblPt8ebvET9YP3lq7qa2UeMAobn7iHHPV2hbjCHPnuyo2AOnY
        h0sLnPU1mYDSxUiPVxuDTdw7NXMcTsOLxcfeIowQJkfPKUhswDAAABIMyrK5eVrLBXpodc
        9KI2TwSTsawXAihnKnEgBHp3tZntfQY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 67145f2c (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 12 Feb 2022 23:10:29 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 0/3] cleanup init-time fast/slow key loading
Date:   Sun, 13 Feb 2022 00:10:19 +0100
Message-Id: <20220212231022.679926-1-Jason@zx2c4.com>
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

The crng direct key loading functions used at early boot were
inconsistent and there were a few subtle bugs around their usage. This
short series cleans that up.

Jason A. Donenfeld (3):
  random: unify early init crng load accounting
  random: check for crng_init == 0, not crng_ready() in
    add_device_randomness()
  random: use trylock in irq handler rather than spinning

 drivers/char/random.c | 120 +++++++++++++++++++++---------------------
 1 file changed, 60 insertions(+), 60 deletions(-)

-- 
2.35.0

