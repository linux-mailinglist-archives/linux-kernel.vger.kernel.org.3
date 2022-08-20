Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C112A59AC04
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 09:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245086AbiHTHR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 03:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343799AbiHTHR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 03:17:26 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E64C6978;
        Sat, 20 Aug 2022 00:17:26 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y127so3140262pfy.5;
        Sat, 20 Aug 2022 00:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Seg+UsTU9seYZei7wiY/0xEcb4bTv9pLii1wsg0IFuU=;
        b=OqOiIWHZbbliX2kj7yStifnR763uDol11zzXqTc7qecZFIyvqGTmARRMiqW795F+re
         ZVpiHegWHhMck98+3x7p3Rq2ImeDIZ4PQsAKfHM+jlhotAmrZRp/Pj3ckEpI0IX6bz7U
         tpEjQohU8/eW42SmcexAcUKUnt8u+HLhiMesZN2cmF0DFD5nC4Fojs+/R9ZpTOEOONT7
         R3rPt7zo3UB1LXcdexJ+PU7vcyNOsvWVgTWLSTmrMrgarH+WkV3D5EFbX5E9uA+oLfyx
         sHKBxFOZerqah+gN8OEHt3Rf0fMs2nYNb2YiLfh3i3YmeqIjsYP/uYHQnYI79jYLkk+4
         ZM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Seg+UsTU9seYZei7wiY/0xEcb4bTv9pLii1wsg0IFuU=;
        b=4VrNlkW7g4Zty66jH46kqddMQ9btiWo+HoHkLsIXV0bWnZHHmzrWTKemtnwhvrzogL
         okVPoagfpsgpiKWVWPfF2CzuFOhbTAJkJplRk+rG0fX42F8n2L+oSNUR7k08QxDy+6Yx
         FBBm6v847eRKG54kLyP52+Jv068o6t5o9vzDKy/8HRWpc12UZxnPva9QeuTH8/AUNf6D
         wxiXj/HwbK+d8SySL5a6bKYtn1DiGvHSo2t9eUmWeJYFXXJ6/ExEzcQdyRR5A0I9DG82
         /R1XU0aXN6Y8g3erwucAd37gyUhfGLzdbyLa2hTnkeJVFbo3Xngc/T4Dv/nrcEjTdkwo
         TEjw==
X-Gm-Message-State: ACgBeo31QaiQeX4aiPruzdV0tMsvzbECmTxKSfXBK87SK4vN7rvsSlq8
        HOTeP+pDf2eXedsIkjCX4U2CfSh5QPLjEbGijzc=
X-Google-Smtp-Source: AA6agR4utyPoQwMxsveMu7ZzFckkhnkh6nJBcGJxw0aWrH3KMKuRLV0i/8HSkC/HfEwEhuh8fqjVsw==
X-Received: by 2002:a05:6a00:3406:b0:535:f76f:c971 with SMTP id cn6-20020a056a00340600b00535f76fc971mr9026502pfb.5.1660979845476;
        Sat, 20 Aug 2022 00:17:25 -0700 (PDT)
Received: from mithil.localdomain ([103.19.226.223])
        by smtp.gmail.com with ESMTPSA id j15-20020a17090a694f00b001faf273e4afsm1459019pjm.35.2022.08.20.00.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 00:17:25 -0700 (PDT)
From:   Mithil Bavishi <bavishimithil@gmail.com>
To:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org, sre@kernel.org,
        tony@atomide.com, linux@armlinux.org.uk, bavishimithil@gmail.com,
        contact@paulk.fr
Subject: [PATCH 02/10] dt-bindings: power: reset: Move twl4030-power from mfd to power/reset
Date:   Sat, 20 Aug 2022 12:46:52 +0530
Message-Id: <20220820071659.1215-3-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220820071659.1215-1-bavishimithil@gmail.com>
References: <20220820071659.1215-1-bavishimithil@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the documentation for twl4030-power from mfd to power/reset

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
---
 .../devicetree/bindings/{mfd => power/reset}/twl4030-power.txt    | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{mfd => power/reset}/twl4030-power.txt (100%)

diff --git a/Documentation/devicetree/bindings/mfd/twl4030-power.txt b/Documentation/devicetree/bindings/power/reset/twl4030-power.txt
similarity index 100%
rename from Documentation/devicetree/bindings/mfd/twl4030-power.txt
rename to Documentation/devicetree/bindings/power/reset/twl4030-power.txt
-- 
2.25.1

