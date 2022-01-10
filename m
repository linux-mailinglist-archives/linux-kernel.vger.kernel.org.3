Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1844894F4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243109AbiAJJOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242619AbiAJJMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:12:34 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEAEC034000;
        Mon, 10 Jan 2022 01:12:21 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id q14so11283658plx.4;
        Mon, 10 Jan 2022 01:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l3XXcURerpYJD7VuNrikwmg4jwTKIhd5e7FpXq8T7WM=;
        b=fHcMn2z/pwtFurWbFk+PvvXhhsECkSUJRSeDouKx2K3qSyHOeQCx0ODMAbPN8El0QP
         telhh3eIadEfgXcfabxrMoHxBWtwQEDxUFPnHSUoMYuQjl7Q/wKbKzg/vr3frL4TnMCK
         1F9bYuidAwClzGUOBSFhx48y84eJB2JCeH3ykYA9nnFa4i1cqitYiY5aV7j0FvaHbI/W
         ymVmZM5lJT1KN0Yzwazb/8vV/3HpufljjxhuMgjMHnC9PKYGKkExWuZUjl27XukI79gK
         04kHEA5/0klFJaYbrotzHyc2S+sMq/B8Q2u6qA7ngHmvghmRfFHsU9qkkkEec+Km4ERj
         KY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l3XXcURerpYJD7VuNrikwmg4jwTKIhd5e7FpXq8T7WM=;
        b=3vKVTuv8qYCyY0nzVkGe1Z0clwKDN92burt3D/3Z3uwwmgh0fy8oF47DsvrIfBT/NE
         T3c5t+mnCoeBSC8SubLak9QqNojAceQRvXNwVhcZ4Oow/nXvpQmSKO0re0h+pJALwDWn
         bnXLqTlwnZ3ATk9xfaAqTRpoQd56EajWe9DQiA3H0hc4702QiS/DiQFxLI661GWlc6sf
         +2sp8RkZBI5MO1hb5I1hvdL8cBhYJTt6esOB8cRuEGqOqNHsQ4v37uT1+aUOyXc2k0B2
         tq1V8tdCXTEW4+6QzIob9xUM0q4jHbKHyp6LtaK6t2t8InKB5+GcQufC8a3AFmU30RkL
         4CEA==
X-Gm-Message-State: AOAM530GSTjZ2hYBxSPB+0vUICGMTfkgx5LQv3J3QJ7Y5QfVShTVmijc
        TnJRXY6dlWFxRxUa67Db3fpdPLVqNPRM7AH7
X-Google-Smtp-Source: ABdhPJyvtR5CwApsfmKKBwNyqfQ/icTdLXB/W5BcF2uOaQo9PRlbBZ3mJELp6oUzlr39glr+NV+RKg==
X-Received: by 2002:a17:90a:bb91:: with SMTP id v17mr28008022pjr.238.1641805941140;
        Mon, 10 Jan 2022 01:12:21 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.250])
        by smtp.gmail.com with ESMTPSA id j22sm6293910pfj.29.2022.01.10.01.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 01:12:20 -0800 (PST)
From:   Wang Jianchao <jianchao.wan9@gmail.com>
To:     axboe@kernel.dk
Cc:     jbacik@fb.com, tj@kernel.org, bvanassche@acm.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/13] blk: remove unused BLK_RQ_IO_DATA_LEN
Date:   Mon, 10 Jan 2022 17:10:39 +0800
Message-Id: <20220110091046.17010-7-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110091046.17010-1-jianchao.wan9@gmail.com>
References: <20220110091046.17010-1-jianchao.wan9@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Jianchao <wangjianchao@kuaishou.com>

Remove it as nobody use it any more.

Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
---
 block/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/Kconfig b/block/Kconfig
index 1c0d05df2aec..50cc1b56852c 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -133,7 +133,6 @@ config BLK_CGROUP_FC_APPID
 config BLK_CGROUP_IOCOST
 	bool "Enable support for cost model based cgroup IO controller"
 	depends on BLK_CGROUP
-	select BLK_RQ_IO_DATA_LEN
 	select BLK_RQ_ALLOC_TIME
 	help
 	Enabling this option enables the .weight interface for cost
-- 
2.17.1

