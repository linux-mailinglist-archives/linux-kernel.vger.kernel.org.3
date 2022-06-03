Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4AB53CA4D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244475AbiFCNAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 09:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbiFCNAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:00:46 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B9533E00
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 06:00:46 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id q12-20020a17090a304c00b001e2d4fb0eb4so11999795pjl.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 06:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Yg5+QfDwgeA6HTgAKJPX8MPDCtSRFgD1mu+1/EW38Q=;
        b=Ljg0TpD1gjHkEpZ8QvJzJ74WM1GkK1YQBZlBU4vH9aOBuLjUUMd64H3AWD6miIcteS
         2ruqx6EbvA3ET+F7xlgQ1G7/RY7NIMFq7WNMVTpAJZx4hPRgiOab3tFuOSxDc5sn85Xi
         x3taHngaRGtYjgmTwRUZ925+PAxPqzHedG2pXAWDbtDvC2zhmT+UkBH2TxqwwgWoAs/d
         gXyWfdCnkC5k80ReKOR/2iByIwMmfZ3Pa+tiRoB77wQjw3IxrZxqT1970+k4a8/+ojh5
         fLemkMxm/Lxjv8NODqP7fsSuGmGYr1YrAB8c6wd36KT9102f7TlZsQ2EelhZZ0Rri7Qc
         bZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Yg5+QfDwgeA6HTgAKJPX8MPDCtSRFgD1mu+1/EW38Q=;
        b=2NtKaI+1UMUs1baA5Fqyw7hEhV6sl0G8A17td/0GqL+PcP850tDPucCP4X5wV3RWxj
         pu1+kjotPdVFBShHLRvCROuhicBvuiuaHGWUyQjdBIkBUWE0CYpvHNubml/d3RQecx0a
         t9w46t4Uk3APy8w4d235xSrkC7YUJUSLpcAfv1WbrGZdzO1pVNRfGWcVRIcJj2cROt+b
         KM31rxjjqROWiDhLig5qcGRjx2uIh9C9jiOP+e7HDacftv2eYLZJ8kNVsG+0ynuMSGLu
         dCovfpk4MbngF9B+COneOv4pgTzNlsZADcRUUk4/F8/4b28ZfzRqOJr2Nq/01e8yLiv5
         vFDA==
X-Gm-Message-State: AOAM531UEBeRFufOpgXHrqL4Lw90OOe22plafbaTGHW9oljhWaHxjeAY
        zWAnwumn0nvvRDAUWarPm+4=
X-Google-Smtp-Source: ABdhPJwymQsCj33OWVSkMPuDvtNEUqNPrrH3qoe3Fm9EQ4gAEE8/0MgEsPXDCZLo1CMa9aJu8uwucg==
X-Received: by 2002:a17:90a:bf02:b0:1e2:fadf:3f15 with SMTP id c2-20020a17090abf0200b001e2fadf3f15mr10892485pjs.91.1654261245326;
        Fri, 03 Jun 2022 06:00:45 -0700 (PDT)
Received: from f34-buildvm.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id p20-20020a170902a41400b00163f7935772sm5327553plq.46.2022.06.03.06.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 06:00:44 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, yesshedi@gmail.com,
        Shreenidhi Shedi <sshedi@vmware.com>
Subject: [PATCH 1/2] char: lp: ensure that index has not exceeded LP_NO
Date:   Fri,  3 Jun 2022 18:30:39 +0530
Message-Id: <20220603130040.601673-1-sshedi@vmware.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shreenidhi Shedi <sshedi@vmware.com>

After finishing the loop, index value can be equal to LP_NO and lp_table
array is of size LP_NO, so this can end up in accessing an out of bound
address in lp_register function.

Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
---
 drivers/char/lp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/lp.c b/drivers/char/lp.c
index 0e22e3b0a..d474d02b6 100644
--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -972,7 +972,7 @@ static void lp_attach(struct parport *port)
 			if (port_num[i] == -1)
 				break;

-		if (!lp_register(i, port))
+		if (i < LP_NO && !lp_register(i, port))
 			lp_count++;
 		break;

--
2.36.1

