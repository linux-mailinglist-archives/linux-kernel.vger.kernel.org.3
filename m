Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B8A48DADD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 16:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbiAMPoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 10:44:30 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33042 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236213AbiAMPo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:44:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDE7860CA0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 15:44:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26B3C36AE9;
        Thu, 13 Jan 2022 15:44:27 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="As3RgnPS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1642088666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=//hC7B/fMPnzJam43NIjPCJ7jgKt0JVRW0xM9AnOBUI=;
        b=As3RgnPSh86aPHrTpxbNbzePQyftFxnzqxuazkiJSthM1fh7DVAiDsUzTWbfx5ywWbWwaf
        f9g7jqS56cpFdYTDJNm/qQLMpdSFI9o0sH+31z/UFUu1TQraMcz28Zd9PV7TXivbZYNwEd
        Ez85/09sArJpNy0y6RMr2KueQMGF3qo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f5550ca5 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 13 Jan 2022 15:44:26 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, tytso@mit.edu
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 0/7] first in overall series of rng code house cleaning
Date:   Thu, 13 Jan 2022 16:44:06 +0100
Message-Id: <20220113154413.29513-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RNG has been through a lot of changes over the years, and the code
could use a bit of house cleaning. This is the first series in what I
anticipate will be a few of these. The goal is to have each component of
it clearly analyzable for what it is, which should make the job of
analyzing its security as well as overall maintenance easier.

Jason A. Donenfeld (7):
  random: cleanup poolinfo abstraction
  random: cleanup integer types
  random: remove incomplete last_data logic
  random: remove unused reserved argument
  random: rather than entropy_store abstraction, use global
  random: remove unused OUTPUT_POOL constants
  random: de-duplicate INPUT_POOL constants

 drivers/char/random.c         | 430 ++++++++++++++--------------------
 include/trace/events/random.h |  56 ++---
 2 files changed, 198 insertions(+), 288 deletions(-)

-- 
2.34.1

