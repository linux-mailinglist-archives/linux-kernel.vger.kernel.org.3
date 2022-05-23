Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024875310E6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbiEWLNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbiEWLM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:12:58 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7D841F94;
        Mon, 23 May 2022 04:12:57 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id m1so12787155plx.3;
        Mon, 23 May 2022 04:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/CO4r6dDcO84oJFTRxSFLeXsxnOUmtVlG/EiTQvijD4=;
        b=C5g6EhCQs7Zk7Kg5xGiZcIWD51iADIJRb9NPnTh+6QZovpfJ3bu21lFDBUFe6mO2pD
         iRYK/onK50f87tqpDsGUV9Gj5j6rGXBSgqMZ3JNqpPQMsLtQHDnOVa4yEzNCiY9Nd0V0
         ZL58Y1gzagnZSK3raehGzwPwCwAp+xktB2qosYa9d84wF9BBTqmN9vy3DqGysyz8ue1Y
         G2QjzEt0Me1hvJbaECv+RUm44UGjEQN9UcEPgcYFCnzcnajF/IGJoiHK016Vuz3ho2GY
         HbTi3iaKjdIXfkl1cdHDW/Yq9Ne/0XxDihhWhHvpE2Rhj0lRCbUWULhJ4CYF6xaRRoSy
         +2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/CO4r6dDcO84oJFTRxSFLeXsxnOUmtVlG/EiTQvijD4=;
        b=yWw5qV5EBiAMp/NvFdCC5daPCruYVNFVacaoQfmULNKe+E+FFeF8och0c148l+p88r
         +kCh0oyUY5xJvH8fKdM9Bu1E5x65Fe+gkgYD9IF6pbsLZc/FsLGpl9dDi/DrGvrvNZe3
         g8v/dVLsE4Qf4MUrbkugGh/NuPswT0e0oumYpXKxToFTGE5/PvbkCaNiEyupfmmU+/OM
         kEgKnA8xmPyUQnLrThdGK9KWrrxCtNya9fUgykgK8bvQuyASDoEOaMCSdP9Ydo/JQq63
         mC2P2WH27y/L9HhtNY2LX3xn2QvekK9XrM4TVAxPAv7hQ6ePPocUpwHkylEPiIEJDb5z
         z+9g==
X-Gm-Message-State: AOAM531eV+GJoCG3qL4WAniiDIMOw+1M9C9i7NhfX8DYtQ7YCGcBm1ko
        4jGn/XbuKT3Jjz3rTywNwPLERl0YshI=
X-Google-Smtp-Source: ABdhPJxZlkcsCc5sqmmbkynirnFlppBgdu1pXZVrmXMLy5DdhvZSHyLu2yZov1/DSBRmu4LIiMrgfA==
X-Received: by 2002:a17:90a:4417:b0:1ca:a861:3fbf with SMTP id s23-20020a17090a441700b001caa8613fbfmr26286445pjg.80.1653304377269;
        Mon, 23 May 2022 04:12:57 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id n89-20020a17090a5ae200b001df6173700dsm6858310pji.49.2022.05.23.04.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 04:12:56 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     dvhart@infradead.org
Cc:     andy@infradead.org, tglx@linutronix.de,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] x86, olpc: Avoid leak OF node on error
Date:   Mon, 23 May 2022 11:12:53 +0000
Message-Id: <20220523111253.3114-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Minghao Chi <chi.minghao@zte.com.cn>

The OF node should be put before returning error in xo1_rtc_init(),
otherwise node's refcount will be leaked.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 arch/x86/platform/olpc/olpc-xo1-rtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/olpc/olpc-xo1-rtc.c b/arch/x86/platform/olpc/olpc-xo1-rtc.c
index 57f210cda761..dc5ac56cd9dd 100644
--- a/arch/x86/platform/olpc/olpc-xo1-rtc.c
+++ b/arch/x86/platform/olpc/olpc-xo1-rtc.c
@@ -59,9 +59,9 @@ static int __init xo1_rtc_init(void)
 	struct device_node *node;
 
 	node = of_find_compatible_node(NULL, NULL, "olpc,xo1-rtc");
+	of_node_put(node);
 	if (!node)
 		return 0;
-	of_node_put(node);
 
 	pr_info("olpc-xo1-rtc: Initializing OLPC XO-1 RTC\n");
 	rdmsrl(MSR_RTC_DOMA_OFFSET, rtc_info.rtc_day_alarm);
-- 
2.25.1


