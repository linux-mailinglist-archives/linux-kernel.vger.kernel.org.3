Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC0149C097
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 02:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbiAZBSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 20:18:48 -0500
Received: from mga09.intel.com ([134.134.136.24]:5200 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235684AbiAZBSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 20:18:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643159913; x=1674695913;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=h64EeMv4yhUSNqyVY599nfi6XpGRNHkuBvZCeGF55d8=;
  b=NPzItKG/LzWjiIuvBLphYQORhZtQDdXNGjvcFIIEKE7rsg2oe+tV/UNv
   KPNnaq1bzliY2F/4y9HDK9ThGI8tL5eMCMrYmm3nI7+/A2FXac49WPcqh
   4hZkPtrFSiNRGsapTVy6UtqKqN4ZqJ2E/1DP/3A81tZdU3Ayj966wiJkD
   b0ymhLLxxMAXpfmDFv3AWZe509PXBZPWSrTU44E1jYrI40tld/FJPi1cX
   sjZvapeYtnotfPQKB1fkxa3C0jYXRV7hS6HpPFqbalmtW88vZ6ExLm97Z
   c4p7GPOBzUfW891IaTIceXgP/95MKPmh6XogsZNRi+20Klk5CCxQETIh5
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246236256"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="246236256"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:18:18 -0800
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="520617680"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:18:16 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 19/19] soundwire: stream: make enable/disable/deprepare idempotent
Date:   Wed, 26 Jan 2022 09:17:15 +0800
Message-Id: <20220126011715.28204-20-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
References: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The stream management currently flags an 'inconsistent state' error
when a change is requested multiple times. This was added on purpose
to identify programming mistakes.

In hindsight, there was no real reason to fail if the logic at the
ASoC-DPCM level invokes the same callback multiple times. It's
perfectly acceptable to just return and not flag an error when there
is nothing to do. The main concern with the state management is to
trap errors such as trying to enable a stream that was not prepared
first.

This patch suggests allowing the stream functions to be idempotent,
i.e. they can be called multiple times.

Note that the prepare case was already handling multiple calls, this
was added in commit c32464c9393d ("soundwire: stream: only prepare
stream when it is configured.")

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/stream.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index ccf3c99dd579..f273459b2023 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1505,6 +1505,11 @@ int sdw_enable_stream(struct sdw_stream_runtime *stream)
 
 	sdw_acquire_bus_lock(stream);
 
+	if (stream->state == SDW_STREAM_ENABLED) {
+		ret = 0;
+		goto state_err;
+	}
+
 	if (stream->state != SDW_STREAM_PREPARED &&
 	    stream->state != SDW_STREAM_DISABLED) {
 		pr_err("%s: %s: inconsistent state state %d\n",
@@ -1588,6 +1593,11 @@ int sdw_disable_stream(struct sdw_stream_runtime *stream)
 
 	sdw_acquire_bus_lock(stream);
 
+	if (stream->state == SDW_STREAM_DISABLED) {
+		ret = 0;
+		goto state_err;
+	}
+
 	if (stream->state != SDW_STREAM_ENABLED) {
 		pr_err("%s: %s: inconsistent state state %d\n",
 		       __func__, stream->name, stream->state);
@@ -1663,6 +1673,11 @@ int sdw_deprepare_stream(struct sdw_stream_runtime *stream)
 
 	sdw_acquire_bus_lock(stream);
 
+	if (stream->state == SDW_STREAM_DEPREPARED) {
+		ret = 0;
+		goto state_err;
+	}
+
 	if (stream->state != SDW_STREAM_PREPARED &&
 	    stream->state != SDW_STREAM_DISABLED) {
 		pr_err("%s: %s: inconsistent state state %d\n",
-- 
2.17.1

