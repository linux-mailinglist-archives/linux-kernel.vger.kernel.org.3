Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035C652E14B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 02:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344124AbiETAlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 20:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344076AbiETAlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 20:41:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803C936307
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:41:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 966A3B82953
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:41:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D10C385AA;
        Fri, 20 May 2022 00:41:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="AFqex79Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653007263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4CVRZKz4SXuTElhNV5oufNGTwb7jmJkgu5o5HNo6Pkk=;
        b=AFqex79ZnjhgCB4J9wFMzm4FMlHU3KMlxrqcDwnJhUO4hhz8UzvEWxN3QSjABccgb4vDvD
        ziO4jkgZpZS900pdw4zNMpbJoz5uiTZpKFnsQbuwkzzlB+mKabYoBXUFw4oDwIAMnMemqr
        MBsaE2Hq4IqmfzWeCWnM7CIUiXg0Iz4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7a8074f3 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 20 May 2022 00:41:03 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v3 0/3] random: Jens' {read,write}_iter respin
Date:   Fri, 20 May 2022 02:40:55 +0200
Message-Id: <20220520004058.96691-1-Jason@zx2c4.com>
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

Hey Jens,

Here's what I've done to your patches. Could you let me know if I've
mangled anything in the process?

Jason

Jens Axboe (3):
  random: convert to using fops->read_iter()
  random: convert to using fops->write_iter()
  random: wire up fops->splice_{read,write}_iter()

 drivers/char/random.c | 121 ++++++++++++++++++++++--------------------
 1 file changed, 63 insertions(+), 58 deletions(-)

-- 
2.35.1

