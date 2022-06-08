Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7802A542B5D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbiFHJUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbiFHJTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:19:12 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFA32309A4;
        Wed,  8 Jun 2022 01:41:32 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gc3-20020a17090b310300b001e33092c737so17710416pjb.3;
        Wed, 08 Jun 2022 01:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hHkedwJj/HENazSRh10iqNTbeup4cO7vLg1WpgNFr1o=;
        b=CMXhZZ+2L9gC73xafarc2LyxiVvEakzSUBq1+9q47cddUq/zAMwzRNX0DzccXieEM6
         SbhKBkwyktyRoBWWSi2RtFNzEYlXAxq6KlF3G9kTNtxgERdeAbVwhhEQKFn89/Eepo2p
         gtYyJam0AHJ7ANn6j9GMU/nDaic0NRUDJ+I8utcdMwRx+njSwI/JkGxBKrjYGyisizJ4
         3FivjpU1CpbLJHw5AVzjlI/A1HxlvsPIqVp/ik7glq9OB1xvP+OvZYZBTVCsnkhq6VJ3
         DsSZltm6S0cBS/57xjZA93F2GAb70eh2TsSqr6npl2nfkzgdmvJ00tbC1eziWv1zMn5s
         A8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hHkedwJj/HENazSRh10iqNTbeup4cO7vLg1WpgNFr1o=;
        b=tExnYCLcVc4cY++o0+nJyZuwv/7+2ptyPAX2zy/kSmTgjovP+nK9GJhscyczLqQrTK
         7wYIiWTtteeqCLnPBQ8aC7V4e4G2d/Z2We+7IQyZp9/LFPX/MxG7ZtiP2Ui34HbEfkon
         RGQIktH9N/Qmfs+P3VA3iZhNREgpzTK0ARQfZ2cjUZALUD8sx/FHcDjmU2noAOyBvNNt
         cJvrXCskD+p1cJgLcwIIXGldZjO60HHOKUh25BB2ODbzFoKKhsW/bN/+wx/iuUtvIcf/
         LzvKtXg+KlII41e0gWzua0SAcIBwqbJ/F7j9pzCQmBBpuIJ1VvQ6ug1JMWCkR4tvw6j8
         VZwg==
X-Gm-Message-State: AOAM532dtw8cCKHz6YLH0EhO66QEsu6rpffwJMIrpZjuqd8e3CGKf7iL
        zoRJc+2kjJihcYTwezt/0hw=
X-Google-Smtp-Source: ABdhPJzxDgIx3QKVftstVQ8aFxJFGsBRl+3Gkgpx8Nyi5EhYtsysbCak+XjtddVMSSZpCxvbNnJnrA==
X-Received: by 2002:a17:90b:4c10:b0:1e8:d377:4998 with SMTP id na16-20020a17090b4c1000b001e8d3774998mr6155161pjb.227.1654677691646;
        Wed, 08 Jun 2022 01:41:31 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:479:837b:38ad:1ae9:1239:b178])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902f34400b0015e8d4eb263sm13902217ple.173.2022.06.08.01.41.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jun 2022 01:41:31 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com
Cc:     pavel@ucw.cz, deller@gmx.de, cy_huang@richtek.com,
        lucas_tsai@richtek.com, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: backlight: rt4831: Add the new ocp level property
Date:   Wed,  8 Jun 2022 16:41:13 +0800
Message-Id: <1654677674-15417-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654677674-15417-1-git-send-email-u0084500@gmail.com>
References: <1654677674-15417-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add 'richtek,bled-ocp-microamp' property to make it chooseable.

The wrong backlight ocp level may affect the backlight channel output
current smaller than configured.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Since v2:
- Change the property name from 'richtek,bled-ocp-sel' to 'richtek,bled-ocp-microamp'.

---
 .../devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
index e0ac686..0f4beeb 100644
--- a/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
@@ -47,6 +47,11 @@ properties:
     minimum: 0
     maximum: 3
 
+  richtek,bled-ocp-microamp:
+    description: |
+      Backlight over current protection level, unit in microamp. The current
+      supported level is 0.9A/1.2A/1.5A/1.8A.
+
   richtek,channel-use:
     description: |
       Backlight LED channel to be used.
-- 
2.7.4

