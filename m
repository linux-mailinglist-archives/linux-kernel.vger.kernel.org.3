Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264AB48159A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 18:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241082AbhL2REi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 12:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240941AbhL2REe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 12:04:34 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C445C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 09:04:33 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id bm14so88544002edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 09:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zzzoaw9nwT/sLWjoXAxYNO4/5wEGpc2LGKlTzw2/Nmo=;
        b=rRDXfOV2riF8m3eENMG6TCo7kUtjkSO7KgaD6hrRGKOU1U0LATdWx2kSuO/omigerc
         HS3uReuDDRQlwThLronJmYerKaQqTjTMT2Dlx49JF02IhDDfWTuoXqBp0rsEfZdkXUQw
         zgI2tlBxkxMrogtxhUBTycLyyqLd/yiscHkf5sTBp6T/NNlmHrIYIUKT9q6qJk53hGqD
         TVN2RUQ11SELxcFA/QLI+6TJnZaekMVJgle0EsB4gEj7GInfpW5EvYfWZFuC7DGHiepA
         POf76H95BxcZhO/RA0QBORriwITuyRFcezZEVLti7aDrcFzbwN0vhI1XIzKULE8SMCeB
         qQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zzzoaw9nwT/sLWjoXAxYNO4/5wEGpc2LGKlTzw2/Nmo=;
        b=uKkh0M6alzTNO4Q0bNZx+Xp9rJzBHCu0at8h4MPIuG334A42WskQuJCB3sqVtzlKLi
         fBrOtZ31KjAKRAKs4WS2s0yEr0ovSkpVAfDdaezqpen2M7E9aZi2XiqD/iLYdDa3ENi2
         nTgGbMs5x7i//H8LtmNW4gD46et33cjQWRkHaRnoQ0WotB1V717Lj/ECwUPstkyfvdXe
         KEr/IU+/37/nYDGXJRQ9VfYIDq8X03r/aRMMc+VTO3KKn3yjxAMCuOSCMVs+8jG+NBbw
         0QxHYQ//MGcNwu2gQjNz3gwoygVqSji2KP2qSPmSj/TfTPCrP2oifg3TGkTHtzM0zCkq
         f5VQ==
X-Gm-Message-State: AOAM531Nz5Ef0ByP6SJ7i/YOkDYjgeJt2yIVExVg2eZ5ajQg2/Msp9WX
        JxsJDMs81Q4RG6a7Mf/U00TiYGrIiwe1X4ci
X-Google-Smtp-Source: ABdhPJyw3/QGNXRpt1eE5AdOGe9of2v2ZlyzW2iOuugasp3Ck/Ai66iFDEh5sqOB1BU76Lr5YkJe0Q==
X-Received: by 2002:aa7:c481:: with SMTP id m1mr26088776edq.204.1640797471615;
        Wed, 29 Dec 2021 09:04:31 -0800 (PST)
Received: from localhost.localdomain ([2a02:a210:20c5:8c80:7d0a:cd68:c339:f426])
        by smtp.gmail.com with ESMTPSA id w11sm8546153edv.65.2021.12.29.09.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 09:04:31 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] backlight: qcom-wled: Add PM6150L compatible
Date:   Wed, 29 Dec 2021 18:03:56 +0100
Message-Id: <20211229170358.2457006-3-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229170358.2457006-1-luca.weiss@fairphone.com>
References: <20211229170358.2457006-1-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PM6150L contains WLED of version 5. Add support ofr it to the driver.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/video/backlight/qcom-wled.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index 306bcc6ccb92..527210e85795 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -1734,6 +1734,7 @@ static const struct of_device_id wled_match_table[] = {
 	{ .compatible = "qcom,pmi8994-wled", .data = (void *)4 },
 	{ .compatible = "qcom,pmi8998-wled", .data = (void *)4 },
 	{ .compatible = "qcom,pm660l-wled", .data = (void *)4 },
+	{ .compatible = "qcom,pm6150l-wled", .data = (void *)5 },
 	{ .compatible = "qcom,pm8150l-wled", .data = (void *)5 },
 	{}
 };
-- 
2.34.1

