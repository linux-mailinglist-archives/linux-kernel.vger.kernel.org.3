Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C52474F73
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 01:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238603AbhLOAqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 19:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbhLOAql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 19:46:41 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0D0C061574;
        Tue, 14 Dec 2021 16:46:41 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id m9so27446875iop.0;
        Tue, 14 Dec 2021 16:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TsxVm/nBHbmV/4yA20eRpZCerBTIIqpAtNm+TzyfRMc=;
        b=CiriOTZ3zJ1nN8OcVg5a1lR0WEgbKwYvIj/uiMxFH88adp3Dq76A7fuT3EjE9lV/eW
         eb0LcYXSB0PAzxSqB9YvvIn8GwDKlOcQYmvvUCT+ubGaUY0EtA6us+j9IhLhVm89nEwD
         0DFX4WVwUVMM4jZJUvWTG18EYNQVKFKYIpaHKyeF/6KcAjrE4zaxat/HnMqZY0O5FZiR
         L358XpwTefW16RcAf1iTma4vuCSJtFtJ47OkZuvr1Gk3GMNBHJM9B4VEJUyLbzO5Hmk1
         QudoLhR6lWgFe/XB5QWsaahWkBhwQ7v0h7BsteKJZV76+CIb5EnV9UOZDvEDbosse8m/
         sV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TsxVm/nBHbmV/4yA20eRpZCerBTIIqpAtNm+TzyfRMc=;
        b=J4HWl5jnCemHs6ULv/pOZbyPZJbr84D2T2l8gvREwZQ8v7Ljazt9a9cfkJO6jOt1xt
         6NXQjnhN4dWuU8Dhx/oo0kPq21Dj3nc+DYhuw+MxFUmHlu5GcHlONvdNJWQ6lGO4MJag
         ntkNTeDmlgiyZqNJYS/ztGuk/omBSKlo47ntoqVcaUGBmalyH9l2IEQdQ9zEwDoVC1Vc
         /TvOoDnwPjmO7Efu+Ojb/cAFKzZ988T3GrXiLkxPKr/mqei0VlcTtY7Tze5/o67EeegO
         97vWKvo5+mPiwf033qcOLRYNOKUXmeSdkd3wY6qCpqxEP+67piHgDtusTFWwsSlrpVIH
         2Fwg==
X-Gm-Message-State: AOAM533DltUsSxY+AJ+P3yAyjdII6rfN4mI8sb+U8hN76yFd3HNYQ++7
        JOxB5MUxvrPjNlRcdxFpNrw=
X-Google-Smtp-Source: ABdhPJy12WWwpsykdsDt2quBfCFzIlmVv94rwZBrTeLWWE5IUudQCFp6YRRRx+6tP9S0DhAHpKQw3A==
X-Received: by 2002:a02:cb0d:: with SMTP id j13mr4568955jap.775.1639529200272;
        Tue, 14 Dec 2021 16:46:40 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:8256:b93c:84fb:458b])
        by smtp.gmail.com with ESMTPSA id y8sm218857iox.32.2021.12.14.16.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 16:46:39 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     tharvey@gateworks.com, aford@beaconembedded.com,
        michael@amarulasolutions.com, jagan@amarulasolutions.com,
        Adam Ford <aford173@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 1/9] soc: imx: gpcv2: keep i.MX8MN gpumix bus clock enabled
Date:   Tue, 14 Dec 2021 18:46:18 -0600
Message-Id: <20211215004626.2241839-2-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211215004626.2241839-1-aford173@gmail.com>
References: <20211215004626.2241839-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like the i.MX8MM, keep the gpumix clocks running when the
domain is active.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 8176380b02e6..a0eab9f41a71 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -841,6 +841,7 @@ static const struct imx_pgc_domain imx8mn_pgc_domains[] = {
 			.hskack = IMX8MN_GPUMIX_HSK_PWRDNACKN,
 		},
 		.pgc   = BIT(IMX8MN_PGC_GPUMIX),
+		.keep_clocks = true,
 	},
 };
 
-- 
2.32.0

