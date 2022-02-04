Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534534A9A5C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353441AbiBDNxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239939AbiBDNxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:53:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA10C061714;
        Fri,  4 Feb 2022 05:53:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A36BB83065;
        Fri,  4 Feb 2022 13:53:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099B0C340EF;
        Fri,  4 Feb 2022 13:53:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hyWNwQeE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1643982821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=p0jZ15a9ixlBtDx4q/qzBaarnd5vvme9cOUwD7BaOEo=;
        b=hyWNwQeEjLIqaUpaZDBj8O2NBGV4cKMZ3cT1//DbHOzS0qEpu7kn5M1vF4Tx5ii+C9hbqz
        dsROASHysdc7f9m8wbdxEl0OJ6qG23CSevsABEqnqqtGr4gpmFL3A7EDUMRwqXiIatB04K
        BX9UKkPXGxEfLeKkodwQBjkB98qQaMk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e9daf5cb (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 4 Feb 2022 13:53:40 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v2 0/4] random: use computational hash for entropy extraction, and related fixes
Date:   Fri,  4 Feb 2022 14:53:21 +0100
Message-Id: <20220204135325.8327-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bulk of the motivation for this and description of crypto
vulnerabilities is in the first patch of this series. The following two
patches then fix up entropy accounting for the new model. The last patch
fixes a minor code safety issue.

This v2 improves some documentation comments and unifies these patches
into one patchset.

Jason A. Donenfeld (4):
  random: use computational hash for entropy extraction
  random: simplify entropy debiting
  random: use linear min-entropy accumulation crediting
  random: make credit_entropy_bits() always safe

 drivers/char/random.c         | 490 ++++++----------------------------
 include/trace/events/random.h |  30 +--
 2 files changed, 87 insertions(+), 433 deletions(-)

-- 
2.35.0

