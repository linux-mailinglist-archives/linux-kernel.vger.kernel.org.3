Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49928593366
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiHOQoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiHOQo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:44:29 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7061658C;
        Mon, 15 Aug 2022 09:44:27 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id p14-20020a17090a74ce00b001f4d04492faso7226988pjl.4;
        Mon, 15 Aug 2022 09:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=zdnW8/HnF3fzfN+wPGf0u6fOxn7CNDqF5X85xYp73sg=;
        b=AMNriioHY+ljxtKHe70MO2ZdyI2UUiyuRD4/roIwOOzyLsyDljL+oIbcR2g6Z3ne+l
         D+juDlTrbQmNAZpKwWqRgXqfYLWreINF5/F7sy75KdhoVWAPQOk/aKg1Kb+7hlE3VrT7
         sE2uje/K/tv77FAC/Q9GvKOvHtYzsdhDKebIR0/454C4fno/7uOU8NqUutyZeNFpflXy
         zn3ScS+sSdOOkDlGBKQOZMBGpCTBki63CnOkhA+gGl4Ij9P64aedFXqYiMK1u0uzpw4v
         6R6XW8QolR4QrjoMfaVHdO88YlWGhk28j+vhQbNuEFNvTxoedWWBxj6uHjK4maxEVaZa
         MjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=zdnW8/HnF3fzfN+wPGf0u6fOxn7CNDqF5X85xYp73sg=;
        b=S8i9cx24vugYZEZlhUyQaBl5qto9XOqPFABDDeLUBbuk7Ow/dG9wBqbkyoQKCCzT6q
         0P3gO/rCKs7rOU8z0E2Oft7wBLtadRXn+oyXA69nkgkLAxwP9sgv+xNQ0yv9sXWzgMEj
         IVUUC2CRCKKk2Te0KvRvUQSR7kINwVbOiJIFdMgw2UUYu956olf4l6migvf0irZmX1fc
         29bZla77FzB9MPoi0HajbmrH1Omb91fVDRz9T7jwE49D5gPzn0ARPglHsBbSRzF1ZzmH
         xDYca/f5Z7W2BuAUybPkJEbHd4j8RQB1II3SH0/ZDXTcJvDJ4bmWfxkA4J0TrUxQvG7B
         ugYw==
X-Gm-Message-State: ACgBeo1A8oClsnNo18mdYQQ1iGSqbNc9MI6Ff6ZJ8DLbcgDfTUMvxI4Q
        a7/5AH62CTIQeKX0qd2GIEOI0mxpX47oZA==
X-Google-Smtp-Source: AA6agR64Uo5Pfca0en/5+dTGxB+FKUKN6/5LFVYEtv9Sx9Uri1inap5EclxIZCSClugQKLDF7rVpjg==
X-Received: by 2002:a17:902:bc49:b0:170:9ba1:f390 with SMTP id t9-20020a170902bc4900b001709ba1f390mr17276673plz.93.1660581867199;
        Mon, 15 Aug 2022 09:44:27 -0700 (PDT)
Received: from fedora.. ([60.177.173.246])
        by smtp.gmail.com with ESMTPSA id h35-20020a631223000000b0040d75537824sm6014358pgl.86.2022.08.15.09.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 09:44:26 -0700 (PDT)
From:   Wenchao Hao <haowenchao22@gmail.com>
X-Google-Original-From: Wenchao Hao <haowenchao@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wenchao Hao <haowenchao@huawei.com>
Subject: [PATCH] scsi: increase scsi device's iodone_cnt in scsi_timeout()
Date:   Tue, 16 Aug 2022 00:43:25 +0800
Message-Id: <20220815164324.645550-1-haowenchao@huawei.com>
X-Mailer: git-send-email 2.35.3
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

The iodone_cnt might be less than iorequest_cnt because
we did not increase the iodone_cnt when a command is done
from timeout.

Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
---
 drivers/scsi/scsi_error.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 448748e3fba5..d21ae0090166 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -355,6 +355,7 @@ enum blk_eh_timer_return scsi_timeout(struct request *req)
 		 */
 		if (test_and_set_bit(SCMD_STATE_COMPLETE, &scmd->state))
 			return BLK_EH_RESET_TIMER;
+		atomic_inc(&scmd->device->iodone_cnt);
 		if (scsi_abort_command(scmd) != SUCCESS) {
 			set_host_byte(scmd, DID_TIME_OUT);
 			scsi_eh_scmd_add(scmd);
-- 
2.35.3

