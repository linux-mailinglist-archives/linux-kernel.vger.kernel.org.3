Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8104642AE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345521AbhK3X2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345169AbhK3X10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:27:26 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15ADC06174A;
        Tue, 30 Nov 2021 15:24:05 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id k2so44336439lji.4;
        Tue, 30 Nov 2021 15:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oh6QUonw7MrnLiKi5GFBt9OmRLKhM/HqDNHd5NkKg7U=;
        b=W+xc93Zkk1bw+3A/dpYtj4prTpbCTRMxSBk86PP2rqZQ9t+a377in0swWhYNA8zBuy
         d8ka9sIfousYLsqWAYfgb2RE0h/MbHYoDRTgXZq8cICNj/oXmS5Icl+00dxUGunQnJyz
         GHKqDzAQ4d003bOiR25Xay9wSrFsM0aUt6b3TxF+oxfhZRfAVbxPAIkL3uqQrTPkVMJM
         9b7ga58/r8fUNYBe9ezRsoTNI8Li0tbAAjCcn7LEgJipcrepYw3m0gy3Urpt3JtuC0/C
         hSwO8yaQlRs69sBLZzh6vZydbE5yQFC93bIaqyLBKQuVeJ8G0GOk+4lwSiijmBQxCHzT
         LwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oh6QUonw7MrnLiKi5GFBt9OmRLKhM/HqDNHd5NkKg7U=;
        b=YCuAeJB2WxI8tPjvpRykvpT3mZ4Ix4ZKKZKxn+DLyRCAPxwqPhzxVjoDLhz8DsWfoE
         8qKja60UkDuUGytrNno6auHJkTSpt9uq/Aqj+TkACgyyNnvUqZdUa31GTftZ8IvBXF5t
         GigRNbJpNlzxfZ1WjaJaz5T5wRx18VgMYKUK1QlysPUbbrjJ9Q5XdqAX4prqxsMhxhb7
         T8AW9d/Z/r91uYYY0sFSCtDC9iJNBkMN8SktzWV5qXiQmYQ4CP6kf+g7XuKZFkzNx88u
         38bb+HJxuBcqKEzBZn+MPmNVG1kXhZOk6V/0t8RDzjQ2vbBUmnfRpj9nWuL9LeBnfmSk
         wiSA==
X-Gm-Message-State: AOAM530x1+Y3LJP8nCixWB5xXkbnP0mBSvIMZysZF4sDgAhwAY4ahJIM
        1dbSj79AfP2Smbgs3hRJIB0=
X-Google-Smtp-Source: ABdhPJxVxIo7wUYLozkf+NW+FFAvxz91eeUJJrgGcg10KppagMhX48rWWV8d4B0ES0rdjmGbUl/roQ==
X-Received: by 2002:a05:651c:218:: with SMTP id y24mr1918262ljn.50.1638314643936;
        Tue, 30 Nov 2021 15:24:03 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id x199sm1860735lff.284.2021.11.30.15.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 15:24:03 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: [PATCH v16 09/40] gpu: host1x: Add host1x_channel_stop()
Date:   Wed,  1 Dec 2021 02:23:16 +0300
Message-Id: <20211130232347.950-10-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211130232347.950-1-digetx@gmail.com>
References: <20211130232347.950-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add host1x_channel_stop() which waits till channel becomes idle and then
stops the channel hardware. This is needed for supporting suspend/resume
by host1x drivers since the hardware state is lost after power-gating,
thus the channel needs to be stopped before client enters into suspend.

Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/host1x/channel.c | 8 ++++++++
 include/linux/host1x.h       | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/host1x/channel.c b/drivers/gpu/host1x/channel.c
index 4cd212bb570d..2a9a3a8d5931 100644
--- a/drivers/gpu/host1x/channel.c
+++ b/drivers/gpu/host1x/channel.c
@@ -75,6 +75,14 @@ struct host1x_channel *host1x_channel_get_index(struct host1x *host,
 	return ch;
 }
 
+void host1x_channel_stop(struct host1x_channel *channel)
+{
+	struct host1x *host = dev_get_drvdata(channel->dev->parent);
+
+	host1x_hw_cdma_stop(host, &channel->cdma);
+}
+EXPORT_SYMBOL(host1x_channel_stop);
+
 static void release_channel(struct kref *kref)
 {
 	struct host1x_channel *channel =
diff --git a/include/linux/host1x.h b/include/linux/host1x.h
index 2ca53d7ed7ca..e8dc5bc41f79 100644
--- a/include/linux/host1x.h
+++ b/include/linux/host1x.h
@@ -226,6 +226,7 @@ struct host1x_job;
 
 struct host1x_channel *host1x_channel_request(struct host1x_client *client);
 struct host1x_channel *host1x_channel_get(struct host1x_channel *channel);
+void host1x_channel_stop(struct host1x_channel *channel);
 void host1x_channel_put(struct host1x_channel *channel);
 int host1x_job_submit(struct host1x_job *job);
 
-- 
2.33.1

