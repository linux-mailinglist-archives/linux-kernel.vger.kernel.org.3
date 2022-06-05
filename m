Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF9F53DAE4
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 10:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350867AbiFEItF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 04:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiFEItE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 04:49:04 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283332CC9A
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 01:49:03 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id d12-20020a17090abf8c00b001e2eb431ce4so10332725pjs.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 01:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f2zpvH+KVD/8jHsV0ASeB9VNDeynxoyrvxGNU6QM330=;
        b=eg+LMOs8KRy3SKWUqYqmF3UmIcozRovoZonPV3hqBETWIWunZJOM6IvuWQIndQO2Ha
         XZOFkRzp+HbcJd6H6vu+JYmnAw9PchYBWA0nVZWdTan05OGTWYxZYv8sXz0IEA9Yz1Dl
         3x6futirJa+lG7de+zUXeAunI1zClMmuvg/u4C2BgE5fshGq+WxQBHI6E6bWlqDQhm+B
         GLPs71TLsoihULrY5CrEPNNwYsK6dtmNksLjT3plRDgw+xtLtNQyonNXCDDKhIkarfsS
         x8GH7ryQz9n337B7dUPzFzFUWGIUEL8iw8d1LCSq0OLv97raR0c9GjqInI2HoFpDAqfo
         hi7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f2zpvH+KVD/8jHsV0ASeB9VNDeynxoyrvxGNU6QM330=;
        b=eAcIWPPb5CNhfGo5zIR527OlZIg+f54Vsd7a0CyGoa/fuGrg6E5U9Jly+Bqh0OoiFF
         3WDycegzZ+r4RSJ0c6sN4Xq2QhpFgsbL4dmWeO6Ofdp84xtYUOJzhDrWR4YWS4cJpSi3
         Uof3qFem7Rs1XT1BXfZUSn9CoEMYPPP/m9Z/gsfxyTOQSL1K5EzD+L3g5Q7jgvgxvB6y
         QRfD/csig7jkrSW0C4/frgWvQFBSshp8iq9tq1hET8zAw/RCC7vzXjCl1Hakwrxsz4Ba
         jWbMrlgQdBErsgKFn87JkQdfI+S2+jhbCblR7u4d34XNrRt9w2M3iKFdLWnzmqYV7NUW
         0VJw==
X-Gm-Message-State: AOAM5319fuML6ZUT2AFRFf5pRBOfIyFBOcLzHVgtxFFypv1beX/R6hax
        GHPtWtEnFTItfzoEtjaAWSs=
X-Google-Smtp-Source: ABdhPJy1zI5Cef0GS97dq7Q+aUXs+4F80remtmuxSShzQbOqk2+Dvm2wCo2XpimuxEfS3BRHmDALow==
X-Received: by 2002:a17:90a:c202:b0:1e2:e772:5f0a with SMTP id e2-20020a17090ac20200b001e2e7725f0amr20144538pjt.109.1654418942672;
        Sun, 05 Jun 2022 01:49:02 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id y188-20020a6232c5000000b0051bb79437f7sm8271867pfy.37.2022.06.05.01.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 01:49:02 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] ARM: versatile: Fix refcount leak in ap_init_of
Date:   Sun,  5 Jun 2022 12:48:54 +0400
Message-Id: <20220605084854.29659-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_matching_node() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: e67ae6be734d ("ARM: integrator: hook the AP into the SoC bus")
Fixes: df36680f1a71 ("ARM: integrator: core module registers from compatible strings")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/arm/mach-versatile/integrator_ap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-versatile/integrator_ap.c b/arch/arm/mach-versatile/integrator_ap.c
index e216fac917d0..6b2a69acc6b0 100644
--- a/arch/arm/mach-versatile/integrator_ap.c
+++ b/arch/arm/mach-versatile/integrator_ap.c
@@ -175,6 +175,7 @@ static void __init ap_init_of(void)
 	if (!syscon)
 		return;
 	ap_syscon_map = syscon_node_to_regmap(syscon);
+	of_node_put(syscon);
 	if (IS_ERR(ap_syscon_map)) {
 		pr_crit("could not find Integrator/AP system controller\n");
 		return;
-- 
2.25.1

