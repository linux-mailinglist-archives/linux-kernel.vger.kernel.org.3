Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613154DEB2F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 22:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244258AbiCSV4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 17:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239515AbiCSV4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 17:56:20 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488EE1546A9;
        Sat, 19 Mar 2022 14:54:58 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id dr20so22867392ejc.6;
        Sat, 19 Mar 2022 14:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1fEsi44knXzqz2tTms88j6nWi9V7o0RMTmg/ml1FxAw=;
        b=kD52D5G8l/1inwCWRQmaKXKZV/EgbsBDIYForu18mwumDjNGzDVpqUdjGgYpUVQIVx
         EfKjZBMTGe861L0mhsH/jRPR28wMxcfl2X0CHejWldb/Wnno6+q3bNisBNh6ik2JMfHM
         w86MHdmuv80E/IIKG4a5bHvhHPxOTff39aPWGK1GQE7KjCpSS3KDMnzksA8Gpglpaen7
         mok0Ia3MAIR1sRjQqEYuU1aP/pYedtUnJHmFiea8syQ87KUUaVlcuVUMtDe2AyaOjJXl
         jw+ab3sz2iw2HWRmP7CQoIuN1vxFD2MOQBLiagJxz76zQMJxfo5s6Owvhn/FCrCURiZP
         YEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1fEsi44knXzqz2tTms88j6nWi9V7o0RMTmg/ml1FxAw=;
        b=lugqaCwIJ9Vy+qFYMuxsu5acLf27KwULAv8PXu7YBpESnAVPwNOqkHOlg6xOfNKE8c
         Hdeyqv1xoTlWXzG1ntRIHzWjScJbXxEOzRA6DcgY0uYoOA4EP0UZmqOPVaB/z8IjxztH
         taJe5bZg17NMhgBFc7k5lnhgopzWcm3x0lXnAdjkTLjzCDxA3jVBSNBFfJVWw5iy6gzT
         kNYp4MiIzUk+NFDknTR1eU6319z35F9QkwUfB0MsC4MgKbB7RorSePdaB33mTgQfwxdY
         BBnfPMpJvAg4dnqCg/rvo3wv+GFPSC7EkLNdekGREUFLMD2afzmjYKzr/imDbNrEUqCc
         TmRQ==
X-Gm-Message-State: AOAM532AXIz+gHVUUHA54T3DXYmAGcLKYDbp7SoRMem0uld2Prqa7HI8
        gTRXMKcdr9hEQfvmh4YnJHg=
X-Google-Smtp-Source: ABdhPJx8dEVyK4cwz0CGRJRxZ8Icwj3iDAgSyEXqGU20EmYY7dbFtbzAHQVAl/T4Lt7uXrAIPBp+BA==
X-Received: by 2002:a17:907:a0c9:b0:6df:8c00:cadd with SMTP id hw9-20020a170907a0c900b006df8c00caddmr13483134ejc.248.1647726896595;
        Sat, 19 Mar 2022 14:54:56 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id z8-20020a170906270800b006bbd3efa6b8sm5180664ejc.80.2022.03.19.14.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 14:54:56 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jakob Koschel <jakobkoschel@gmail.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: [PATCH] ACPI, APEI: fix using the correct variable for sizeof()
Date:   Sat, 19 Mar 2022 22:54:47 +0100
Message-Id: <20220319215447.2625681-1-jakobkoschel@gmail.com>
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

While the original code is valid, it is not the obvious choice for the
sizeof() call and in preparation to limit the scope of the list iterator
variable the sizeof should be changed to the size of the variable
being allocated.

Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/acpi/apei/apei-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index c7fdb12c3310..33b7fbbeda82 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -319,7 +319,7 @@ static int apei_res_add(struct list_head *res_list,
 	if (res_ins)
 		list_add(&res_ins->list, res_list);
 	else {
-		res_ins = kmalloc(sizeof(*res), GFP_KERNEL);
+		res_ins = kmalloc(sizeof(*res_ins), GFP_KERNEL);
 		if (!res_ins)
 			return -ENOMEM;
 		res_ins->start = start;

base-commit: 34e047aa16c0123bbae8e2f6df33e5ecc1f56601
-- 
2.25.1

