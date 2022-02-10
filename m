Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E050A4B125E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244021AbiBJQJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:09:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236919AbiBJQJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:09:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F4DC2A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:09:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D237B82502
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7BFC004E1;
        Thu, 10 Feb 2022 16:09:32 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bWd7dfHC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644509371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=N3dD0tXTnwc6MdQY+PdYpzjIVrGQYs8c4jWPh9hZHek=;
        b=bWd7dfHCZjvPGX4rUMojBtgWBXgQHIGDiOiBKyIfmOoSKwUvpHl9KdMcsGAxHtv3mGPOif
        kSj1HUW2rFfSvwOa2Nd2B7tRQa9Jxt9W0FsCPMAvN/DfW8VO/RmS9Kec4eVMJlsdsQ0Ltm
        xGj4tALZQZPWil0PVKYbphO7ASa3PCM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7b3711a2 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 10 Feb 2022 16:09:31 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux@dominikbrodowski.net, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 0/2] random: make irq collector clearer
Date:   Thu, 10 Feb 2022 17:09:23 +0100
Message-Id: <20220210160925.156697-1-Jason@zx2c4.com>
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

This trivial series moves functions around and introduces a union rather
than having manual bit arithmetic.

Jason A. Donenfeld (2):
  random: move fast_pool/fast_mix definitions to site of use
  random: deobfuscate irq u32/u64 contributions

 drivers/char/random.c | 141 ++++++++++++++++++++++--------------------
 1 file changed, 74 insertions(+), 67 deletions(-)

-- 
2.35.0

