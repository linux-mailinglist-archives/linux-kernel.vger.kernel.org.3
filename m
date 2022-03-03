Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D934CCA54
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 00:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237332AbiCCX5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 18:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiCCX5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 18:57:37 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334AF16AA6D;
        Thu,  3 Mar 2022 15:56:50 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id m6so10155587wrr.10;
        Thu, 03 Mar 2022 15:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yr78uIWmXtIgqxD87zJiQsDzLde5k7TOsUmqwlNeg1c=;
        b=RSYUdd1VvAbwc7K9Evn57j4GQCnNE8+fjkx+BreFOJO/HFV403ttxU7SRz3tF7wAVX
         lyeNqttfCAgDTJ7BE/sCeu42fuQUkgWVoXDoCYBZHxFqNbjtg7eWhH9fm/67KNuAePq/
         RoUJa8+DQTkUldVj9sd82hZBOU8mul6dQn1tE76cWZj3RSla1Q8f9222rLe+3rTnx4MI
         qxDnI9ZUbFt1BLwz2kqd8/rxg3TFW9VQLj6X5tEcImsZl31g1O4KNWjT1HTdh67UCfz5
         QRAzf4E95zQdiEEzmjXKFvaOkF+8pSDsyYurjvBcXOEcNvsUJyjEaBGcLgJKAulYTStp
         2yMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yr78uIWmXtIgqxD87zJiQsDzLde5k7TOsUmqwlNeg1c=;
        b=bEu5+QuYNGFtDGoxUxMEMTHslFyoFFFo9nMqJEOp6/Ae7BIAo5s0U8X7dz0lUuGbDf
         DaD79WBOJ3tJn+ZWUetBGAcr3wvk6NrvmUBqFdypGNIXMuMpjF8NMjSdK2/M/dO4n6y9
         XRDNoN/ND4nIM5TB/IKbBcBeEpzv4bMGZqHkwSRupGg7+7iVpDffuSIpnl6y/dhl6iai
         LOBBnUNExEFR2jNUl9ogBARHkTGJG2/wUqnkxKKGOPdHRqFM6nNaxQ0om/4KmQabh1JB
         cvWG+k5hjsz1C+UQAcHf0LZJveUGwa7vLvx1v+ZSFsyNL6wS8/Srekvbf1A5MBhRDHdB
         w3wg==
X-Gm-Message-State: AOAM531CNgN6mdMlBFEy7iSG6Fsyy6b7mxe71ay/JwfIUMbX1g7HxmlA
        WBeZo4K1pEHzlQBRSbrKi+k11intBgs=
X-Google-Smtp-Source: ABdhPJwq1v6qcISk06IDEBMZd8EiMJQIVM3GQW3dJR4UC5yQuA3i9vSYby2lLUrRuFuGeIML64nIEg==
X-Received: by 2002:a5d:64c4:0:b0:1f0:36ee:15c with SMTP id f4-20020a5d64c4000000b001f036ee015cmr7109758wri.126.1646351808709;
        Thu, 03 Mar 2022 15:56:48 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id w9-20020a5d6089000000b001f0256761b9sm4294043wrt.45.2022.03.03.15.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 15:56:48 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] netfs: fix uninitilalized value in ret being returned
Date:   Thu,  3 Mar 2022 23:56:47 +0000
Message-Id: <20220303235647.1297171-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

In the case where sync is not true the variable ret not being
set and a garbage value is being returned. Fix this by ensuring
ret is initialized to 0.

Fixes: c19a5d31b470 ("netfs: Add a function to consolidate beginning a read")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/netfs/io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index 3db9356eb7c2..05fbe6665508 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -601,7 +601,7 @@ static bool netfs_rreq_submit_slice(struct netfs_io_request *rreq,
 int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
 {
 	unsigned int debug_index = 0;
-	int ret;
+	int ret = 0;
 
 	_enter("R=%x %llx-%llx",
 	       rreq->debug_id, rreq->start, rreq->start + rreq->len - 1);
-- 
2.34.1

