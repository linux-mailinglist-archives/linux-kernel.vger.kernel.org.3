Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A3A52E940
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 11:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347293AbiETJpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 05:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344170AbiETJpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 05:45:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B48149AA1
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 02:45:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A822061C5D
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE16C385A9;
        Fri, 20 May 2022 09:45:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="J1hf1cvN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653039909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gluKqLQjTYA5IB7SjL2h7eVAHJ1g9P2uH3eS6g9vEhw=;
        b=J1hf1cvNPesHqkL5vcFxpUpVVPDhXqniRYdAbE5lCftYrHHHYeYK2ELjoUGfRAGY+ibm7S
        CwC/bwHWEj029tAcrnaMSdMyjvmG3WUPeNggc1VmhU3HDP730AbOlLmzEIueHyrabKQ5V+
        f0sotF609BOCuxBIJAkBVAj3Zj034kY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8236fa8f (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 20 May 2022 09:45:09 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jens Axboe <axboe@kernel.dk>, Theodore Ts'o <tytso@mit.edu>,
        Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v4 0/3] random: convert to using iters, for Al Viro
Date:   Fri, 20 May 2022 11:44:56 +0200
Message-Id: <20220520094459.116240-1-Jason@zx2c4.com>
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

Hi Al,

I've incorporated your suggestions into Jens' patches and simplified a
lot of the control flow. Could you take a look at these and let me know
if it looks sane? In particular, I'm using the property you mentioned in
which copy_{to,from}_iter() can take a maximum and do less if the
remaining length is too small.

Jason

Jens Axboe (3):
  random: convert to using fops->read_iter()
  random: convert to using fops->write_iter()
  random: wire up fops->splice_{read,write}_iter()

 drivers/char/random.c | 126 +++++++++++++++++++++---------------------
 1 file changed, 63 insertions(+), 63 deletions(-)

-- 
2.35.1

