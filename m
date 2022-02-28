Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1871A4C6F47
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237102AbiB1O0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237099AbiB1O0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:26:02 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213506D1B4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:25:22 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id p4so2743107edi.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t89NhqJYorEFTw8WrVtJVWyHHmbVnl5aLtAxBdRQbyU=;
        b=XhXH3g7w69442RPA1I5M5/K8M1qvIrQSI2wWBRk3Rtw6la/HhkC0ud+M4OxwK4jHbE
         ZHDHRpEiplIwdsIqTShexd2pbaNzsdkX75dxSIQDwnWM/omTHoUp7oIfpj716pUmQk6h
         0MEKVNCRE13ruMxNqOc+zvibmaUfAjIxBFnWmxDdlSBrCuVt+luarFbAbpx8SebKxfKI
         RVYrAlfpv0VGCiwdx93Z7+tpDINxXHaDcVl7OLPNqvfjBjFP+jaBR3kbYNXc01sfxfKl
         gnuJwe+zxdbeB5jHT/tX78TiFmpr9fm2X23LTpOfqPZ6Yw1OQLTcDURBxpuue7yVAbWs
         xrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t89NhqJYorEFTw8WrVtJVWyHHmbVnl5aLtAxBdRQbyU=;
        b=xCTv1NAmVlniExj8JibQMBkMNtEWPX3ANdyPgLbQdfGqT0bPHKQWcMsO259U0cRU5f
         4fieSMAuv9RUj934AQoCcg4ULNYKUAyWileyte0jO/t+pkuUmrsLqWpB96Reu0uE8TIu
         IWW2ypoR7HwJ3irLMl2b/ipAAS4pdX+aAP6OZ/FVNBlNDjrzWc3Ss3RVoUtX0vmDlHrq
         /V7HsxxQeoos2NOwmRsr5zluqcR7X0ARNTcdE9PxxF9Oe5RZQp7oq42bxb//TdgMylQv
         XM0jVkAOFXOR8hXfWIOM9ZnCbb1qG58mB4ornKzLhBqGBo6ON1x0UD9POxzU4xKHH5C5
         gqfA==
X-Gm-Message-State: AOAM5301viqp51SV8syHd9h58+AR2g9RdXT+b9RaKxNtaeqEMJlD45Q3
        yC0WMCQxIA8QTsW7Za+s00o=
X-Google-Smtp-Source: ABdhPJxOxtmXMvYcLKAjDOX0lh9MhTomTdWMimmV0Cfq/XIN4jDu+unVS7ejvfrzCMb440clF5fS2w==
X-Received: by 2002:a50:d711:0:b0:410:a51a:77c5 with SMTP id t17-20020a50d711000000b00410a51a77c5mr20374819edi.154.1646058320341;
        Mon, 28 Feb 2022 06:25:20 -0800 (PST)
Received: from localhost.localdomain (dhcp-077-250-038-153.chello.nl. [77.250.38.153])
        by smtp.googlemail.com with ESMTPSA id ov6-20020a170906fc0600b006cf54ef58ddsm4494527ejb.149.2022.02.28.06.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 06:25:19 -0800 (PST)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Jakob Koschel <jakobkoschel@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Anton Vorontsov <avorontsov@ru.mvista.com>,
        Kumar Gala <galak@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/sysdev: fix incorrect use to determine if list is empty
Date:   Mon, 28 Feb 2022 15:24:33 +0100
Message-Id: <20220228142434.576226-1-jakobkoschel@gmail.com>
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

'gtm' will *always* be set by list_for_each_entry().
It is incorrect to assume that the iterator value will be NULL if the
list is empty.

Instead of checking the pointer it should be checked if
the list is empty.

Fixes: 83ff9dcf375c ("powerpc/sysdev: implement FSL GTM support")
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 arch/powerpc/sysdev/fsl_gtm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_gtm.c b/arch/powerpc/sysdev/fsl_gtm.c
index 8963eaffb1b7..39186ad6b3c3 100644
--- a/arch/powerpc/sysdev/fsl_gtm.c
+++ b/arch/powerpc/sysdev/fsl_gtm.c
@@ -86,7 +86,7 @@ static LIST_HEAD(gtms);
  */
 struct gtm_timer *gtm_get_timer16(void)
 {
-	struct gtm *gtm = NULL;
+	struct gtm *gtm;
 	int i;

 	list_for_each_entry(gtm, &gtms, list_node) {
@@ -103,7 +103,7 @@ struct gtm_timer *gtm_get_timer16(void)
 		spin_unlock_irq(&gtm->lock);
 	}

-	if (gtm)
+	if (!list_empty(&gtms))
 		return ERR_PTR(-EBUSY);
 	return ERR_PTR(-ENODEV);
 }

base-commit: 7ee022567bf9e2e0b3cd92461a2f4986ecc99673
--
2.25.1

