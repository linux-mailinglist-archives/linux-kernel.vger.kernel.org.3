Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDDF5794A2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235847AbiGSH4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbiGSH4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:56:01 -0400
Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03AFE6549;
        Tue, 19 Jul 2022 00:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=HF412
        /wHUz+0a5LIVNz1VvcPVzrrXujuay7goG5yM10=; b=dGts/y/bkFT4/FOcwnk7+
        dumD7t+iXyeIgWa1B2xdubk3if1xEEnjPgM0iBqOpYyxILo1f36YwnvpFQBMiJXW
        OQWLqj97sLAIpVSIBXm0tLwqh6wtEacXLrwHChiK3ttf6RThAhiRYzK76QYSMH0X
        mjJXB8CzV8EqtagARWd784=
Received: from DESKTOP-KE2DLLP.localdomain (unknown [223.87.207.239])
        by smtp7 (Coremail) with SMTP id C8CowAAHR05OY9Zi69XQOQ--.41313S2;
        Tue, 19 Jul 2022 15:54:56 +0800 (CST)
From:   Yang Hao <yanghao_ht@163.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Hao <yanghao_ht@163.com>
Subject: [RFC] scsi: ch: add scsi_device_put in ch_readconfig
Date:   Tue, 19 Jul 2022 15:54:42 +0800
Message-Id: <20220719075442.6215-1-yanghao_ht@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowAAHR05OY9Zi69XQOQ--.41313S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF43GryftF4xtryUXFyfCrg_yoWxCwb_ua
        yI9Fy7Xr4FvFWkK342gry3urZ29w4jvwn8u3Wvqr95Z3yxXF1UX3WUAFy7Cw15KF4UXr9r
        JF1qvr1Yk34UujkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUU0JmUUUUUU==
X-Originating-IP: [223.87.207.239]
X-CM-SenderInfo: p1dqwxhdrbx3i6rwjhhfrp/1tbiGgdD31aECjiT9wAAsF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ch_probe
  ch_readconfig
    scsi_device_lookup
      scsi_device_get
      ...

when the dev is found, the related refcnt of dev will increase,
and there is no 'scsi_device_put' to decrease it, which will lead
to refcnt leak.

Signed-off-by: Yang Hao <yanghao_ht@163.com>
---
 drivers/scsi/ch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/ch.c b/drivers/scsi/ch.c
index 27012908b..70ba5d63e 100644
--- a/drivers/scsi/ch.c
+++ b/drivers/scsi/ch.c
@@ -407,6 +407,8 @@ ch_readconfig(scsi_changer *ch)
 					ch->dt[elem]->vendor,
 					ch->dt[elem]->model,
 					ch->dt[elem]->rev);
+				scsi_device_put(ch->dt[elem]);
+				ch->dt[elem] = NULL;
 			}
 		}
 	}
-- 
2.25.1

