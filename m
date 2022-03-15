Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B114D9429
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 06:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345039AbiCOFyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 01:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237121AbiCOFyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 01:54:52 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08B2275C0;
        Mon, 14 Mar 2022 22:53:40 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id t1so22574950edc.3;
        Mon, 14 Mar 2022 22:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=gcxe7Q67Er+91W8CGkt9CKVxyZovdKpQHbbislZxMaI=;
        b=T8t6aNIF28F/RLXMTBj4EVH+NN/fLhb23LBLmy2AgzTgdRtQajf0XbbzbYVGJOQNxb
         B8zbxhg6kZzPaHWpSLtJdo+OtDUq4HEqLmHRw4nBl2bOVFo3vhmy9QeTSYpZOiKsphs6
         RDuMWsztvWsB+WF0Hx1X9ihSKaTn4YcGUsD8w7xW68/vTky6JO9CWVibNvDDtmZyW4S7
         JX5DxR5ERSQ7AeeXbjtBYQsO9Eo/fE2kpAu6DwTrXQ+ybbRUyNyC4WDPV+EUgMAbMt9G
         ynqbM94johYsXzLB22ZyWK4pG2pLi8MzagEeIIvHo6yfNIWirShdjWxhxbpAqD7ZRY9f
         tehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gcxe7Q67Er+91W8CGkt9CKVxyZovdKpQHbbislZxMaI=;
        b=apf9MEZIZg53/0XnEh7AIqg8utECby3B/cZvNaMfpA4YHq/EY/iACuyZSW3bafwbzG
         Dukeeo0jniZKGdakIBA59hvy9tVmyVVkAt8EzcRUuxAZv1+vwXNScdnDURelt2vneZki
         uw4kX0ZVKy5FDv4PyNR6zuQ5aE4rsYnmFSNR9A+KfB0sGC/4HXHgsL8bIiiusvca8OLs
         7H002f2aOcsq8UfdJjvDCiRWOkmak9xIlLoRPxj+23ZZj/nIlqIqesr0Z440jD0dhxMI
         hAOg9FdT2N7wdmIAh0d17erMh7jcK15q73CHkwv7/aPP65C8uZVbePhuaAdIzO+M7ixL
         haJQ==
X-Gm-Message-State: AOAM5324s/rMm/w5L/DWTWjVuyB8I90630kkAnyb1tLAxktYZbXzYYSg
        ctkuH+kWZu/p7cIeNekncpU=
X-Google-Smtp-Source: ABdhPJyzYgQANwP4WOlef1dijASUQbxEe0O+IhciGaJOsPldIamf22MbJdJIkmlxSd2c3ZBPJ/5hXA==
X-Received: by 2002:a05:6402:2896:b0:418:58c2:7254 with SMTP id eg22-20020a056402289600b0041858c27254mr13663551edb.283.1647323619067;
        Mon, 14 Mar 2022 22:53:39 -0700 (PDT)
Received: from felia.fritz.box (200116b8264e9400282aff0ca67bda3e.dip.versatel-1u1.de. [2001:16b8:264e:9400:282a:ff0c:a67b:da3e])
        by smtp.gmail.com with ESMTPSA id re27-20020a170906d8db00b006d76251f4e7sm7613799ejb.109.2022.03.14.22.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 22:53:38 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] scsi: bsg: drop needless assignment in scsi_bsg_sg_io_fn()
Date:   Tue, 15 Mar 2022 06:53:25 +0100
Message-Id: <20220315055325.14974-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ce70fd9a551a ("scsi: core: Remove the cmd field from struct
scsi_request") refactored scsi_bsg_sg_io_fn(), so that it does not
allocate directly and hence does not return -ENOMEM in its error case.
That makes a remaining assignment of -ENOMEM to the return variable
needless.

Drop this needless assignment in scsi_bsg_sg_io_fn().

No functional change. No change in resulting object code.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Christoph, please ack.

Martin, please pick this minor clean-up on your -next tree on top of the
commit above.

 drivers/scsi/scsi_bsg.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/scsi_bsg.c b/drivers/scsi/scsi_bsg.c
index 8039c3c11a6e..96ee35256a16 100644
--- a/drivers/scsi/scsi_bsg.c
+++ b/drivers/scsi/scsi_bsg.c
@@ -31,7 +31,6 @@ static int scsi_bsg_sg_io_fn(struct request_queue *q, struct sg_io_v4 *hdr,
 		return PTR_ERR(rq);
 	rq->timeout = timeout;
 
-	ret = -ENOMEM;
 	scmd = blk_mq_rq_to_pdu(rq);
 	scmd->cmd_len = hdr->request_len;
 	if (scmd->cmd_len > sizeof(scmd->cmnd)) {
-- 
2.17.1

