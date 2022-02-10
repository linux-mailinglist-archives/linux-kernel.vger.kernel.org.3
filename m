Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303534B16F3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 21:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344272AbiBJU23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 15:28:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344231AbiBJU2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 15:28:17 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D584B85;
        Thu, 10 Feb 2022 12:28:18 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id z20so9671246ljo.6;
        Thu, 10 Feb 2022 12:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8+PCp8VzJ36gwuUuZGOgQHhyJLFNLNE5NPa+Wd4bAXE=;
        b=IxkmG76bFLc42upQAfX2viuaO+Zvq3ggpHoSw+8vGvIebuVzIO6ZrfDobBHGTLCz/0
         XxSVDXbvnnPdX3AHIcnKxds+3eXeP98U5QwwlsvBgxzCuJ3xghhmj7P86XOeZInnm2kW
         67PWvKh7LRd5qrbmweNMQYdV0+luLt0NEUzLnF4niDSeBadknLCZ3GpsON+l75M/58Ht
         1yRKzdRE4XmQETPnFD8jjo594ks3Xl9ftEIqDM1GTyhEjB5nDjZPonp4G0gEFFV0ydNM
         eINwZkxY/ZrWyOHBSgTUWbnOkBoGzuezMESL9NHSo+GuU/Akj2EKuJo32/wyI1sFGeR2
         Jfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8+PCp8VzJ36gwuUuZGOgQHhyJLFNLNE5NPa+Wd4bAXE=;
        b=xKKP8O2cu6G0X6YSmfU/B5+QnH1UKTG+MnJTFJRlApXKaSyQEq2d/ZssdUPXuOPVhB
         4Z+NGL18MMgA41wbtqfF+SPnyLAIYexessHlA8fgCjHN4TL/lWtF9HO97eD6uaYikd6y
         fxncVsrom4kb8BIN0bcS3WVdKiIbuIicPjBXixZgNoG7o6EGnDYEGEjH0/h7UpxyyK8v
         nOb92JsTTc8KS54brvY2/+9aND9gjjUOjFn2u9FYCCVSe0yXYnWHXrRrwdajF+QGZ8bn
         Hg9tIQcE/6A6IZBosAC2XI7Q62m7k6fFREJoovfLyc1S+N4LqrDIQ/V/xygVQdncQR+/
         mO2Q==
X-Gm-Message-State: AOAM532pWrV5Um+/ugq+t5PFJglau2LFB3URZNPuFRRSx8PleDqQWk/j
        LabMekH9WHBLMJTM71+OqMM=
X-Google-Smtp-Source: ABdhPJxnkMhH+WCNQmT2YfTiDN+Fw9oTWgT0Xe73gy81YT+zJxyQZKdlb9nW6RBG26W2nxeMV9nUfQ==
X-Received: by 2002:a2e:bc20:: with SMTP id b32mr5976744ljf.214.1644524896908;
        Thu, 10 Feb 2022 12:28:16 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id d19sm1223881lfg.108.2022.02.10.12.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 12:28:16 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 3/3] crypto/nx: Constify static attribute_group structs
Date:   Thu, 10 Feb 2022 21:28:05 +0100
Message-Id: <20220210202805.7750-4-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220210202805.7750-1-rikard.falkeborn@gmail.com>
References: <20220210202805.7750-1-rikard.falkeborn@gmail.com>
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

The only usage of these is to pass their address to
sysfs_{create,remove}_group(), which takes pointers to const struct
attribute_group. Make them const to allow the compiler to put them in
read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/crypto/nx/nx-common-pseries.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/nx/nx-common-pseries.c b/drivers/crypto/nx/nx-common-pseries.c
index 4e304f6081e4..7584a34ba88c 100644
--- a/drivers/crypto/nx/nx-common-pseries.c
+++ b/drivers/crypto/nx/nx-common-pseries.c
@@ -962,7 +962,7 @@ static struct attribute *nx842_sysfs_entries[] = {
 	NULL,
 };
 
-static struct attribute_group nx842_attribute_group = {
+static const struct attribute_group nx842_attribute_group = {
 	.name = NULL,		/* put in device directory */
 	.attrs = nx842_sysfs_entries,
 };
@@ -992,7 +992,7 @@ static struct attribute *nxcop_caps_sysfs_entries[] = {
 	NULL,
 };
 
-static struct attribute_group nxcop_caps_attr_group = {
+static const struct attribute_group nxcop_caps_attr_group = {
 	.name	=	"nx_gzip_caps",
 	.attrs	=	nxcop_caps_sysfs_entries,
 };
-- 
2.35.1

