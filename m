Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1476154F085
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 07:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379683AbiFQFVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 01:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379928AbiFQFVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 01:21:31 -0400
Received: from mx0b-00256a01.pphosted.com (mx0b-00256a01.pphosted.com [67.231.153.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC3F6542D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 22:21:30 -0700 (PDT)
Received: from pps.filterd (m0144081.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25GMdj1S021203
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding;
 s=20180315; bh=QKErT/DfxhZ300qNRsf1ijx1r9TNlZjtzOb7IB9qsls=;
 b=fIOGRB9ibdaB9Qbas07yDQfsb8pgsR/9C+WC272Ay5qxpwDCQxAZ1l0mDKR48pvFS5iT
 QbCrvAapigv1+Qxc8/MWUkhAlNuPmzIExv5kdZj8G/EKBkjqXAB0qIk6l6SNYqqZreqx
 elbA6NmKBlnFwdceM1g/TKzn2NeqQ79EykveD5jD2iOxmMYwBd5Fdv4V8bNcaDNMCXpa
 8HCBONpyUTlZuBHNo5BWg3XNDxIWiMFinlrNx6qX0xbb3ArLzTSUcMYIF6A970lXsxma
 os4UoTi8f3nEN/MQDIJqhMe5mmQyU3zb6C0+eckh4x2LvfQxK3rWO7pujBzTTjsttNKM Og== 
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
        by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 3grapaym8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:49:02 -0400
Received: by mail-qv1-f69.google.com with SMTP id x17-20020a0cfe11000000b004645917e45cso3669285qvr.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 21:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QKErT/DfxhZ300qNRsf1ijx1r9TNlZjtzOb7IB9qsls=;
        b=EfPg4Tv1FNWStGrlQieNy1rBJ8bHka37kjV5Je0ld28y/6AdQ6m+GoUxvPnlMt8eNr
         6NJvyYhI6aCPJpTbtpgHOk7yMlrtFYCXR7gPwdSkUDrANA3U72C3O8EMZS3B02yC+m+B
         9liG4gGlEdJQPYV0PP4D+AuxwwF0rPWZBc03PZPX+sEV8F6GyuvcF421luKXPttRa62R
         pC8/YcH8hE+P/uG3qkMZXhXwS1XRuACVGKjJfhf6MJms75bJaeh+BYX10Qc/BPOzVx86
         0W6Cw1gN0z5I3uH5jB8LZOn5xDThZwed804ikRgxpxJqUfXq9mnszANOJRk6pWQY8fuD
         t3cg==
X-Gm-Message-State: AJIora8Z2g1tM02z/GJjbXpg1KRdRvwtDTZaqnY3OD/GfU6J0WwGDr2Q
        inoS1031WTBuw+HFa6OfcK9Q24yCw4u/YVhKDdD2w/tBUaMIGFiZv5aYJfIdZbb6G6eECE5R8Bo
        8MV++40CzcWSuZt+jJn2BoS0=
X-Received: by 2002:a05:622a:3d2:b0:305:3477:4486 with SMTP id k18-20020a05622a03d200b0030534774486mr6921623qtx.209.1655441342339;
        Thu, 16 Jun 2022 21:49:02 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tEBIiQkI1C+Aj5hd4g4sckIWlOyMCymnzAxzejv9VUyJuqSoVZS8GRKQzz1Tz0lXmujZcCyw==
X-Received: by 2002:a05:622a:3d2:b0:305:3477:4486 with SMTP id k18-20020a05622a03d200b0030534774486mr6921613qtx.209.1655441342116;
        Thu, 16 Jun 2022 21:49:02 -0700 (PDT)
Received: from localhost.localdomain (cpe-66-65-49-54.nyc.res.rr.com. [66.65.49.54])
        by smtp.gmail.com with ESMTPSA id h7-20020a05620a284700b006a65c58db99sm3446799qkp.64.2022.06.16.21.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 21:49:01 -0700 (PDT)
From:   HighW4y2H3ll <huzh@nyu.edu>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     HighW4y2H3ll <huzh@nyu.edu>, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix use of uninitialized variable in rts5261_init_from_hw, when efuse_valid == 1.
Date:   Fri, 17 Jun 2022 00:47:55 -0400
Message-Id: <20220617044755.37535-1-huzh@nyu.edu>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0WCB6dlBv8LC1mza7LAWuvB0gNnIOigR
X-Proofpoint-ORIG-GUID: 0WCB6dlBv8LC1mza7LAWuvB0gNnIOigR
X-Orig-IP: 209.85.219.69
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0 priorityscore=1501
 clxscore=1011 mlxscore=0 suspectscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206170021
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: zhenghao hu <huzh@nyu.edu>
---
 drivers/misc/cardreader/rts5261.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
index 749cc5a46d13..f22634b14dc8 100644
--- a/drivers/misc/cardreader/rts5261.c
+++ b/drivers/misc/cardreader/rts5261.c
@@ -403,7 +403,7 @@ static void rts5261_init_from_hw(struct rtsx_pcr *pcr)
 			setting_reg1 = PCR_SETTING_REG4;
 			setting_reg2 = PCR_SETTING_REG5;
 		}
-	} else if (efuse_valid == 0) {
+	} else {
 		// default
 		setting_reg1 = PCR_SETTING_REG1;
 		setting_reg2 = PCR_SETTING_REG2;
-- 
2.35.1

