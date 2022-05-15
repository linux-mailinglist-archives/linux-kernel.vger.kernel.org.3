Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67705527644
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 09:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbiEOHbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 03:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiEOHbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 03:31:38 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD6A13F9A
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 00:31:37 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so11491286pjq.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 00:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SAlHBmhRXSG1w6+RO5Otw0BeQCwtfqDdnloabN9+jc0=;
        b=pjGychsbvEWxCzLmZBM5mXN3AAfgSNYlgqKlkSX/XeQc+xXJIce93j/F7qhlD3TgEU
         0aBKkHWzJo9rd6KEnGwKr+GivnVGvdXbab6rkZ6mW8coMIWOnkp6/ciovP19zKsWSz8S
         gsONBidAKVO+tJjQobpBOVfqyZnGt4KtjuaUOvU2JcYjkZwNZSM4b/qhhjLhbLDUL+2H
         /u+Tp+wp5nQ/nvJ4g2eAYDApHEQ1JlEglj7wl8cryfeAWG1YeOSilXiz3aSqDcqSPczg
         2EUb6WZ7q65CFeuVqvtC5C2BbTFMigvCzLlmbGtEVdmPL6kCpLaGI0NzNx8DCls8CT6F
         VNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SAlHBmhRXSG1w6+RO5Otw0BeQCwtfqDdnloabN9+jc0=;
        b=xs2bs3PfSL6zouw6VUTtF2yfZzeEX/QFxUIKmCcEKCIKu0JjsTkzhsyhJoNZ10bG0y
         xrT33+1y4wHjdf73G8O6IIOnk25NGGJdOa9vcCpFNUOER0fK9qVmW8R+qsA/XlPSAcdX
         KKeeu6VTwq43Of7vB7pTx1aYXJjDrTjj0gQQqbRf4oETO/EqDJToWw8lMl6uGOP1S8gw
         VNeMPYivKJo7e13n/q1YBhYxuOTbr9hdWqBMyCMMRrHcFOGlM8/5qvGnhdwYV505AS3K
         zZffoaXUZ7rhJfhPwfGK7mRcXejnLDbQieZnqzG4/XJeBaevZO3klMWY2i8omos1wIie
         eu6A==
X-Gm-Message-State: AOAM532Q2SET860D9/OjTrQwaL41higyWxp//JGoQ2v/TqSgZh3DvVpe
        moiO7VaXUMsAxciBl/7wN3ZpnX/5m6P59HLQPpOaoA==
X-Google-Smtp-Source: ABdhPJyuMTl8iF2ROz1Gdyl9VRD5Z6pWvB0mydIwwGio29wsfjjZPr0N67GC2YN9tufpMUjRpubjtQ==
X-Received: by 2002:a17:90a:d3d2:b0:1dd:30bb:6a45 with SMTP id d18-20020a17090ad3d200b001dd30bb6a45mr25034221pjw.206.1652599897067;
        Sun, 15 May 2022 00:31:37 -0700 (PDT)
Received: from f34-buildvm.eng.vmware.com ([66.170.99.2])
        by smtp.googlemail.com with ESMTPSA id t12-20020a1709028c8c00b0015e8d4eb28esm1767058plo.216.2022.05.15.00.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 00:31:36 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     paul@paul-moore.com, eparis@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        yesshedi@gmail.com, Shreenidhi Shedi <sshedi@vmware.com>
Subject: [PATCH 1/2] audit: remove redundant data_len check
Date:   Sun, 15 May 2022 13:01:09 +0530
Message-Id: <20220515073110.304193-1-sshedi@vmware.com>
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

data_len is already getting checked if it's less than 2 earlier in this
function.

Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
---
 kernel/audit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 7690c29d4..0749211d5 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1390,7 +1390,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 						 str);
 			} else {
 				audit_log_format(ab, " data=");
-				if (data_len > 0 && str[data_len - 1] == '\0')
+				if (str[data_len - 1] == '\0')
 					data_len--;
 				audit_log_n_untrustedstring(ab, str, data_len);
 			}
-- 
2.36.1

