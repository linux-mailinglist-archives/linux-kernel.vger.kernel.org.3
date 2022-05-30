Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F575374F8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbiE3GmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 02:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiE3Gl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 02:41:58 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53A92E6B1;
        Sun, 29 May 2022 23:41:56 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id e66so9325955pgc.8;
        Sun, 29 May 2022 23:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gHi7sfDkWSGQyFcI8BoQxzCXchHKCpyPbiqXNicxgx0=;
        b=NlMYSwV0KMtZs43xH1LoNZ7eAhM1aR7OXBiZZe9Rl5ZSoUI1YHvBlnSZkpSv084jq+
         rzwXZKf++77ANXoArZm/N9Fzp/AgmvWx6lYgA03OUEVmVM5qaHRAWX3bOPpVLmrrvh6B
         iz0VVYEXKgzBp2oVOlWt1ntwJP2SB97nTfu21gVgNRoHpEj1zmUU5XJbiNz6wbUJCu4+
         mpaDq3mG5M5e4wf8bbrnBCA1C3hsyn2lHtHf9qu8MFYQA+WAN/ktFnpgFboj2H2raDuG
         wWiWvD3RrQ0iKqqROlyNJ5LILa9fqTZK59GlcGy39hs1o5IPaphDpntK8zU4WAEyAfpy
         Kz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gHi7sfDkWSGQyFcI8BoQxzCXchHKCpyPbiqXNicxgx0=;
        b=PHwYRagFZ9mRPyhXr/4Bw9pVIlOY5/tvhgCgFPkYzCwLz6aEjRlx4x+VNN7FfTB6ve
         xw9bw+dnCihY59qDjV7w1jT0ugZd/7gS2dqs6b9Jo6uXo9nBDN6RQ5S0ms2M2WfgRIBH
         V5J0CiFrnXIVuYqaIgWYmuZE4xWuF6UTdcC6rqtvupX+QdzMxuYbIpDQ7fy4KGr2+U1d
         oeqxk8H1fns+V+pGHjX6n2ysh8I9QKbde9+mhFFneKw3Vjej6aGcLzwg3mThDb9nJm4U
         9onWN8ZqDO3CtCqUdgGIJ77eYa/9FTdqSiEJ6n9nXvHY30xLLdNAmAkxpEK6vJ4TxWeF
         1GSg==
X-Gm-Message-State: AOAM533glIClplPPoXY8sn1K4bfszh5DldEUXRiae/SIpYMi62gHus08
        DxzlVWKOijI+v+uDvUBXSxlH91S0HZ0n3OaLvyw=
X-Google-Smtp-Source: ABdhPJyadpwvJ7jgcamhg2q6er/pQIzVTSfVslfbaApzXRkF7vvYeE4LW9LBeT7ePXNjyX0RkLWNsQ==
X-Received: by 2002:a63:de01:0:b0:3fa:1a35:36e0 with SMTP id f1-20020a63de01000000b003fa1a3536e0mr34132357pgg.92.1653892916390;
        Sun, 29 May 2022 23:41:56 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.3])
        by smtp.gmail.com with ESMTPSA id bb4-20020a170902bc8400b0015e8d4eb2d8sm8168569plb.290.2022.05.29.23.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 23:41:56 -0700 (PDT)
From:   iamhswang@gmail.com
X-Google-Original-From: haisuwang@tencent.com
To:     axboe@kernel.dk
Cc:     zhangwensheng5@huawei.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Haisu Wang <haisuwang@tencent.com>,
        samuelliao <samuelliao@tencent.com>
Subject: [PATCH] blk-mq: do not update io_ticks with passthrough requests
Date:   Mon, 30 May 2022 14:40:59 +0800
Message-Id: <20220530064059.1120058-1-haisuwang@tencent.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haisu Wang <haisuwang@tencent.com>

Flush or passthrough requests are not accounted as normal IO in completion.
To reflect iostat for slow IO, io_ticks is updated when stat show called
based on inflight numbers.
It may cause inconsistent io_ticks calculation result.

So do not account non-passthrough request when check inflight.

Fixes: 86d7331299fd ("block: update io_ticks when io hang")
Signed-off-by: Haisu Wang <haisuwang@tencent.com>
Reviewed-by: samuelliao <samuelliao@tencent.com>
---
 block/blk-mq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ae116b755648..3912cae42da3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -133,7 +133,8 @@ static bool blk_mq_check_inflight(struct request *rq, void *priv,
 {
 	struct mq_inflight *mi = priv;
 
-	if ((!mi->part->bd_partno || rq->part == mi->part) &&
+	if (rq->part && blk_do_io_stat(rq) &&
+	    (!mi->part->bd_partno || rq->part == mi->part) &&
 	    blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT)
 		mi->inflight[rq_data_dir(rq)]++;
 
-- 
2.27.0

