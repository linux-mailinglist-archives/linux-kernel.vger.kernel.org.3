Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9188059CE60
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 04:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239366AbiHWCP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 22:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239541AbiHWCPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 22:15:36 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601C15141E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 19:15:35 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso13088585pjh.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 19:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=B0JpBG7vfvINdfy3QKpBmCt4CGFBZCPyhAEjcgH4wpY=;
        b=IoHx2leDlH1m3usj9yAsA2ml/T5wMRc+Ddg+YSiAwua3ncg90a+cxcZNr2I+Pnndah
         0qC6stFRHN2B31JdNYH4Ah29U7AfhLGu6a3lw3O2/BxeHpgbaAmjAcZVfI2OJq9MwPCb
         2Wg8XJ2wWUPCOziO6QqYy5ESZ+gpuUiDUt/qD1YdiwHqoC5CWMb74Mp1Zil9T+ya1fSs
         XX/9m6j4ZTYF05KJ6v8CftWr12Ps2ALlhRkheafdOpUJgc62Kzcxk5WvxrTSH0dNLntc
         SBL3nVeGya3nQOWe0mvLOlcVaXWBf9tuTTOE/VNyAXyoMlr4JPyACEYh+sOxwoVLQmuM
         cyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=B0JpBG7vfvINdfy3QKpBmCt4CGFBZCPyhAEjcgH4wpY=;
        b=Oc24SXlseTEq09BhXizLleaN6SEWWUm/4tZmLxjtxhmbhHd9A8vFTP1puRP5LkL5aS
         gF16nq111jLkks1N+OeDGm5APVc/j46mgt4PYAFeK3AORwER7hgB6LMSuCrxm7Nk3TVD
         KiDtsXrXzGNoeQ++YGV0dqiL4E1jAd3xf6lpnQ2D5J8ueAUGZ4tcAr69pi1beNxhiWzR
         PqVpMWqBSL46Y5MsZY8vxcDog3w80Q2zAQixIWbtv8YPpNcavlZgKgXZgT8yUmk2SpQt
         3zwstgF5zBBC/oAYUaSi0qmz9I0vUDa8uLWL3fNpcONEboW0D4B7FKEXNIEKkE4tYIwi
         yAyA==
X-Gm-Message-State: ACgBeo2u/ipAYDp1R8x7/mfh307KX0Zhyb2T4FZXYGZHLIgsGpcR0Mvy
        dWYIzeCCvpu+0s4bX5ckdOrokxd1emS0ww==
X-Google-Smtp-Source: AA6agR4KgiV9ISu+QYM0ZotHbgkMBxHsRLvuLR2wTHfHoMQ9ysl6CCm5zMRJjzu2UOYTnSZZytGrBQ==
X-Received: by 2002:a17:902:8605:b0:16b:e755:3c6e with SMTP id f5-20020a170902860500b0016be7553c6emr22523021plo.42.1661220934878;
        Mon, 22 Aug 2022 19:15:34 -0700 (PDT)
Received: from localhost.localdomain ([103.181.13.196])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902d50200b0016a0bf0ce32sm9138171plg.70.2022.08.22.19.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 19:15:34 -0700 (PDT)
From:   Genjian <zhanggenjian123@gmail.com>
X-Google-Original-From: Genjian <zhanggenjian@kylinos.cn>
To:     hch@lst.de, sagi@grimberg.me, kch@nvidia.com
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhanggenjian123@gmail.com, Genjian Zhang <zhanggenjian@kylinos.cn>
Subject: [PATCH v2] nvmet-auth: remove redundant parameters req
Date:   Tue, 23 Aug 2022 10:14:41 +0800
Message-Id: <20220823021441.968488-1-zhanggenjian@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Genjian Zhang <zhanggenjian@kylinos.cn>

The parameter is not used in this function, so remove it.

Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index ebdf9aa81041..e467be86db78 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -177,7 +177,7 @@ static u16 nvmet_auth_reply(struct nvmet_req *req, void *d)
 	return 0;
 }
 
-static u16 nvmet_auth_failure2(struct nvmet_req *req, void *d)
+static u16 nvmet_auth_failure2(void *d)
 {
 	struct nvmf_auth_dhchap_failure_data *data = d;
 
@@ -310,7 +310,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 		goto done_kfree;
 		break;
 	case NVME_AUTH_DHCHAP_MESSAGE_FAILURE2:
-		status = nvmet_auth_failure2(req, d);
+		status = nvmet_auth_failure2(d);
 		if (status) {
 			pr_warn("ctrl %d qid %d: authentication failed (%d)\n",
 				ctrl->cntlid, req->sq->qid, status);
-- 
2.25.1

