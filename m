Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685DC4B060F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 07:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbiBJGIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 01:08:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235022AbiBJGIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 01:08:10 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06E81E6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 22:08:11 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id 200so3871663qki.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 22:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b350Wl0VMceiJC3Swb0UabBZ5Vh81zaMpkDROb2RE6s=;
        b=qitJCd3TMvStsCo0PhbT6b6rUT6TLl0NwK6BsY3/uDGoySzqmhXvJaXpYrlqMe4Rop
         NkG4jd9l7EwdMfCxmqRq5h3KwDz7BvqxIvU71/eDdGdP3dIgneWolQMmlbJuNEPQVmtJ
         effMR0ily+rcN5OT/WNF7wmuLYnZZoAdJscpIkeOBsLFYytRBxSSXmtv1o7wFHeFDVd8
         lsb45fiYqzhrYctAo6aEpG1VmPX4e29598smHfMfXjtuJ0CwpMWOdQeCkWCw6yY1dn+4
         bLyNL73v5UjFiy/Phv/qfw+ZKVKyc99mgG27ZYbqvtrKcGfGoB5fFk4YjV7NSUcy9qFA
         sy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b350Wl0VMceiJC3Swb0UabBZ5Vh81zaMpkDROb2RE6s=;
        b=r/n8obKayFki6P2tKcmySBl/vXmV/mP0aUC8UHOQIfq1Dtg8SE3pwCkOJKurEKO7NN
         0f1gyy43/PWApz3uBY/XgvZuOh92bQPkRts3X9oOIaTBzeW5W++GMoW7QGWbS6rJ3amO
         rDy1lKDAs1ql6DB/orxuJnHli4GLSq+7Oi2mNgUTik8prZd03p0/Y1f/dSHgtPKZQ8h1
         7zAQiiqjipXwWbfuKYH+MX98NUqMPsLUTSizmm8c4OId7r5I4Thof/PZ++KnCSzq4YQz
         0l2wgNj9cHkcyKWfZ8hoodSgg+xwfKyF/6nh4LX/6qQKW2Jbu+tG2Rzjav6IJzvxdtgI
         xVVg==
X-Gm-Message-State: AOAM532TfW09+PapOX9yTUFeAbFFqWkYgjFUpO82CS4m5m6Lz4AYqSoC
        v7XizLAbriyB8KASq/ua1Uc=
X-Google-Smtp-Source: ABdhPJwBWc13kiK0vC+W7G4h7jxvn2PXms2HPDb1+edK2QXRj032AlWU4FKZAPTbk6P4Cipy8L07DA==
X-Received: by 2002:a05:620a:1678:: with SMTP id d24mr3037940qko.477.1644473291074;
        Wed, 09 Feb 2022 22:08:11 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id g21sm10467362qtb.70.2022.02.09.22.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 22:08:10 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     stefanr@s5r6.in-berlin.de
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>
Subject: [PATCH V2] drivers/firewire: use struct_size over open coded arithmetic
Date:   Thu, 10 Feb 2022 06:08:05 +0000
Message-Id: <20220210060805.1608198-1-chi.minghao@zte.com.cn>
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

From: "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>

Replace zero-length array with flexible-array member and make use
of the struct_size() helper in kmalloc(). For example:

struct fw_request {
    ...
    u32 data[];
}

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
---
 drivers/firewire/core-transaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index ac487c96bb71..563fdf8b2657 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -777,7 +777,7 @@ static struct fw_request *allocate_request(struct fw_card *card,
 		return NULL;
 	}
 
-	request = kmalloc(sizeof(*request) + length, GFP_ATOMIC);
+	request = kmalloc(struct_size(request, data, length), GFP_ATOMIC);
 	if (request == NULL)
 		return NULL;
 
-- 
2.25.1

