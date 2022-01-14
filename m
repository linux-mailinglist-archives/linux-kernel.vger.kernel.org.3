Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEBF48EABF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 14:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241254AbiANNdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 08:33:22 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57896 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiANNdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 08:33:21 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 2ADCB1F46992
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642167199;
        bh=bIGZkqg8TQB584qijqAGY+JJJVnU59xCz/eRyLXwgkI=;
        h=From:To:Cc:Subject:Date:From;
        b=c5xKYpgSzYg0CLKJsgl7jrbku95RwK5bFFjlw7yyT9Nz+yuzagvspFdbKMAKOsMi1
         Hq0GGOPfQXh9rWbmanKrVXZpogKs0WbrEb/31KMoFTi9sqgMCFTkZtb/UfsJ9r02Ij
         dhc2no736Q3KKl9d2rtsdSvEpk5H+KRbo9CIAohmwvZw5y5DZNX2lmg9F4CImiJBGx
         GeqUtjv0uWfaVIcL5ZZDO2wZYMvocWWBH69QsNJZXZEZ6w5z9WzwtgWK2ls6WZ/Us9
         3ldfMfw8W6BvshG4g7GmX5SzBYRV9has5kA5aDuzvfXal6zDxXudEFOiX6fWg6rAI6
         byF9mb1dXHWeA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     agross@kernel.org
Cc:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2] rpmsg: qcom_smd: Fix redundant channel->registered assignment
Date:   Fri, 14 Jan 2022 14:32:59 +0100
Message-Id: <20220114133259.247726-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In qcom_channel_state_worker(), we are setting channel->registered
to true when registering a channel, but this is getting repeated both
before and after re-locking the channels_lock spinlock, which is
obviously a typo.
Remove the assignment done out of the spinlock to fix this redundancy.

Fixes: 53e2822e56c7 ("rpmsg: Introduce Qualcomm SMD backend")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
v2: Fixed funny typo in commit title (channel->assigned => channel->registered)

 drivers/rpmsg/qcom_smd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
index 540e027f08c4..0ee3f7ddabb0 100644
--- a/drivers/rpmsg/qcom_smd.c
+++ b/drivers/rpmsg/qcom_smd.c
@@ -1298,9 +1298,7 @@ static void qcom_channel_state_worker(struct work_struct *work)
 
 		spin_unlock_irqrestore(&edge->channels_lock, flags);
 		qcom_smd_create_device(channel);
-		channel->registered = true;
 		spin_lock_irqsave(&edge->channels_lock, flags);
-
 		channel->registered = true;
 	}
 
-- 
2.33.1

