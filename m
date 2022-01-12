Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C00748BF6F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351363AbiALIEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237577AbiALIEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:04:04 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41930C06173F;
        Wed, 12 Jan 2022 00:04:04 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id w27so1644203qkj.7;
        Wed, 12 Jan 2022 00:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iKcG1xCQXSx894OSDj80kVGbsOH6ABlaWdg6vUCjwJk=;
        b=kqn7X5Ji/e/zT9xWmm9QJOB1LnmJbjjxqOYjtbdYBCD9/MQXPBYOP6QSu62TKiJWzf
         bO/cBGKpwuIbEeIfc2VwaTe2+5SUj2qcZYFBAtd+239RoP7NP3jxvYyvZPrBX6L3/laP
         cYie+OUvvMqc5zzlkSEAxfcELLFfqSSSyaDowKvl1kneNTLOJS1iKT52H+kSHEfBiRXW
         9KUbAbuG4Rdmm/b4MgkctU5ZFjIdXdRLrMiDFIjCAnPxSSlC+aNJuX53JIIruwwREI9b
         UoN9GAvq6C8Wi7Pnf8FnND414FlZQcPpJH0KDCH8u5mZ3YU/McAvzHIK7+J3iK1FXtxN
         YWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iKcG1xCQXSx894OSDj80kVGbsOH6ABlaWdg6vUCjwJk=;
        b=AnacGRgbpy7lQoTysWmMokb3DFLNwnKAGYK6/uG/Ins0ORtulAql05Y+tPovj4lZaQ
         2/tyW3Pf7wEnDp0eTG2E1l2KtuGo/KlUx4IXySz8dnH9J3JSDJGGe/IGk/LaGwa3LCgM
         JLlmDc3sguzrB+MrILm485/bd9NPcs2szukwoqG8jwppFiCw2jyvtFVXnIfW6q1fh4BC
         HqnDskh39znivF6/L+Fl8IpEtEyWhwfIh746DHfyzepn8Qrumu8wQB3zia9IzePdymnp
         Xa6gyD0ArKORaf04mAIdrnvsw158gsK247W/+vH4dVhURwSbJOH0kQxs/hPAr3cT2Pt6
         otmg==
X-Gm-Message-State: AOAM531/7wXJ4C7CHq4IYU3sSFTszN5y1x9bwhtWP+1XFLv8ucVyKFYL
        PIYbk7zK0i7R24QTDMEAOCCBnpzRxUg=
X-Google-Smtp-Source: ABdhPJxxzbyNZ5BIA7SVfdszmBXrUWRaPv4dmZklaaS2eyEU6TXF1C/L1EZdYcWWxfhsWDP8YMj/fw==
X-Received: by 2002:a05:620a:2104:: with SMTP id l4mr5618261qkl.659.1641974643499;
        Wed, 12 Jan 2022 00:04:03 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id o10sm8698271qtx.33.2022.01.12.00.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 00:04:03 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     john.johansen@canonical.com
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] security/apparmor: remove redundant ret variable
Date:   Wed, 12 Jan 2022 08:03:56 +0000
Message-Id: <20220112080356.666999-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value from nf_register_net_hooks() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 security/apparmor/lsm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index ce7d96627810..f3deeb8b712e 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1799,11 +1799,8 @@ static const struct nf_hook_ops apparmor_nf_ops[] = {
 
 static int __net_init apparmor_nf_register(struct net *net)
 {
-	int ret;
-
-	ret = nf_register_net_hooks(net, apparmor_nf_ops,
+	return nf_register_net_hooks(net, apparmor_nf_ops,
 				    ARRAY_SIZE(apparmor_nf_ops));
-	return ret;
 }
 
 static void __net_exit apparmor_nf_unregister(struct net *net)
-- 
2.25.1

