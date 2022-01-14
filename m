Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A5848E994
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 12:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240933AbiANL74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 06:59:56 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57194 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240924AbiANL7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 06:59:54 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 19B361F413B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642161591;
        bh=C2OaY+DhNtPJtmQACKGNG+vM/ZeGsj7cOskW2Yvq4yY=;
        h=From:To:Cc:Subject:Date:From;
        b=E1BpdhOfREAsM1kb5H4XmdiOodQfLrc7/B5fm1ZFE84qLmp6xn5QE8GaGsGYIQh5d
         3fs2wnYLKjalX4aLqEifEKwBzNiXYCZI65EFYgv4fqe89E8rCt1z/blUidgsnBLNP7
         hCOrEHoWk957bTe1vjBjKpQr1pu+zZAUFKfYc8Gg9EzMzWca51m85+lnhQ7JTbCX37
         h7Z/snujy7GxfIgwlM4fiLi51WFz5e3LRJ+GxE6h8UZU2dskrI1qSB9gLms76I5cF5
         SyWWaVIPAgCw9IozDVY8Ma+KhB4vIZhVdU3LyJNfUfQflKXuthSZIv4o6sDatiGXIr
         AxqoFjPVWhD1w==
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
Subject: [PATCH] rpmsg: qcom_smd: Fix redundant channel->assigned assignment
Date:   Fri, 14 Jan 2022 12:59:39 +0100
Message-Id: <20220114115939.146434-1-angelogioacchino.delregno@collabora.com>
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

