Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E864FB16C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 03:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244267AbiDKBjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 21:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiDKBjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 21:39:14 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7385A44756;
        Sun, 10 Apr 2022 18:37:02 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id s4so9548368qkh.0;
        Sun, 10 Apr 2022 18:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UkxHGgn4YJBPlk25zh9PGFZqZ3wjtsZgFqYO+Io+0Vo=;
        b=eX/qToAEh3fUmerBCAQdhIIJEVvzDsXp6xsYO9VX2ktc+oXx7W7U52fugi0R3Wz8vb
         iyyASX0a+qnVXX0cs2eW211fZEQMd3Ho4YQREJAHkPJ7R29UrG0aSSV65svsFBAJ/gsr
         GbC+4f7ur6jIQHKRMtrIic/UJBRsBDY+ihRCMQAnR0Mu+2asUPOksIptPPMna9ztNscG
         y5iaALiiR7hVKuDq9hphPOZpo7b93lxRoxqCyBBqWlCWJ3ojMmEcXky3dgrVO/b7H0l5
         kGhs34ZSrImDWH+cQ+JC7nlA2ZBJMD8l+Enlfcf8PGaPd+r96mVKxouMVtUiFr2lXUHT
         T+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UkxHGgn4YJBPlk25zh9PGFZqZ3wjtsZgFqYO+Io+0Vo=;
        b=YogPpC2D5/U+SfdUBHw9dNZzvd//+3vQugJ2nnDWuJb5DGk7WeJh1pmzo12P1+iElD
         Glec9jATXee7/HKvJlc2riEPRgQT4QIjnpYSuQZZfpwyBlrmaEOtDKsx7dYaX5pTAnNq
         xmLWAJswageiwdHST3pTTdr3aVZj2Lh8FBSSFkyFowb6L2SUIzTTGAZx+vFweh3e7G7/
         7MbQ/T7jnKYU9U1BcdnOnU+VOd37pjGCkVhVobBylmuo9qcR+yzA0NJ5VSBWEUoEdBxm
         JqYO9YdE7AjUbgWYW8FiCfPVi3BY2qykKgmSYtrMssoQakAdWeCQGoCq/G9nF8I1FXkI
         HjcA==
X-Gm-Message-State: AOAM5323bUAkSbA27O1JDne/OyFTkp5+VFlA/534cjNRCkKkUVTZh8go
        qwCksoMHVcyOsUjwh4E4C3E9yQOFwZo=
X-Google-Smtp-Source: ABdhPJw1cX3ShZhFRemD6RIMaN/zN45MsdoLXoS7wLzSfcsJjqUa3Ne59RW7Np4PEGNUZYO76bKz8A==
X-Received: by 2002:a05:620a:13f9:b0:69a:17b:7a0a with SMTP id h25-20020a05620a13f900b0069a017b7a0amr12862609qkl.67.1649641021669;
        Sun, 10 Apr 2022 18:37:01 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e7-20020ac85987000000b002e1b7fa2201sm24122996qte.56.2022.04.10.18.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 18:37:01 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     bjorn.andersson@linaro.org
Cc:     mathieu.poirier@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] remoteproc: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Mon, 11 Apr 2022 01:36:56 +0000
Message-Id: <20220411013656.2517150-1-chi.minghao@zte.com.cn>
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

Using pm_runtime_resume_and_get is more appropriate
for simplifing code

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/remoteproc/keystone_remoteproc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/remoteproc/keystone_remoteproc.c b/drivers/remoteproc/keystone_remoteproc.c
index 54781f553f4e..594a9b43b7ae 100644
--- a/drivers/remoteproc/keystone_remoteproc.c
+++ b/drivers/remoteproc/keystone_remoteproc.c
@@ -410,10 +410,9 @@ static int keystone_rproc_probe(struct platform_device *pdev)
 
 	/* enable clock for accessing DSP internal memories */
 	pm_runtime_enable(dev);
-	ret = pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0) {
 		dev_err(dev, "failed to enable clock, status = %d\n", ret);
-		pm_runtime_put_noidle(dev);
 		goto disable_rpm;
 	}
 
-- 
2.25.1

