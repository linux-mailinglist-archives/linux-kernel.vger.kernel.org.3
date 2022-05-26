Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC8153493E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 05:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbiEZDQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 23:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiEZDQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 23:16:45 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AB8EE3C;
        Wed, 25 May 2022 20:16:44 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d22so376229plr.9;
        Wed, 25 May 2022 20:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=f6jLMtJrLguZvRlHX76uP5bxS6yNfg/KmTP+kPMFw2A=;
        b=NeNH04nEYmKlxRrFKbjU/A5gGFIWu4QfR8rsFuFLIoMj/OrRI/CL7ER+lH9qLFt6v7
         ooZ8tD4znoyV6cfroKC0X30K+JpBNll7tDwyoQEOt1T0x31lWIx3QTniGgdXW7dIvOtc
         b4aaIVHO7NsdfcTDz7PzU/L+pt0XpbvhZgKefdOaQjl+N/0EiOKDACOvqf0WbJ2hsd8J
         4w2hNrFaONz10ivo7QxmqlKWabHG9lJ26TdaR4QRjHgfuLuKGy51TlVwRzWEHXe1l3Yn
         SOYziVzsEMKCg13T/uWvBClWFNplGswFouHdSq9sQdGi607cYz47CyI8t2H7vZtNMnC7
         gTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f6jLMtJrLguZvRlHX76uP5bxS6yNfg/KmTP+kPMFw2A=;
        b=b6rcC9AyD+wbdUJyly86o70sIoLBKFjVjtqKpryGGBZ9nmr4QzJOoX6Hqq3UySO/3O
         JtzvtDeWn/XbJFxn4dfTMH2jubhUV3aGDn/fPDk9c6q04yKCseRjxuJY8F0sC4L6HDZV
         ngOKMup9yrkS6yLzd9ei+BHdW9dzCMBaeO9Y981hSbosxUR+kPTRZtGWA053lfoP/AGk
         Svk5nOKJhecCSpn9b7lXPqcNiWTBvEs6XETuvRdtrV0jLPOSGpA6r/KZfe9ASSNYTxEc
         ZmRLG97PX7BQexq6Z2hwHVsgLVEv/BIERLM1DtTN5p12qeFj54fS5lrctzV/hRWlUYkM
         jDZg==
X-Gm-Message-State: AOAM532xvOHA3t5pG2FUPNCTdA415M6nlLuWI3yXZV7E9nD1cQBxJfTk
        UcMsJrcIqPuW9yf7adG3zYg=
X-Google-Smtp-Source: ABdhPJz/ng9MEzMr2C0bCqTgfwmdUaqu1tPBtgobFs5R3bzVReetE9dkkSyLpZEelrkVQ1dPShLBuQ==
X-Received: by 2002:a17:903:2309:b0:163:5c82:640e with SMTP id d9-20020a170903230900b001635c82640emr5614243plh.100.1653535003625;
        Wed, 25 May 2022 20:16:43 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:6b12:f420:101e:bfc0:b57c])
        by smtp.gmail.com with ESMTPSA id t25-20020aa79479000000b0050dc7628181sm152964pfq.91.2022.05.25.20.16.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 May 2022 20:16:43 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com
Cc:     pavel@ucw.cz, deller@gmx.de, cy_huang@richtek.com,
        lucas_tsai@richtek.com, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add the property to make ocp level selectable
Date:   Thu, 26 May 2022 11:16:33 +0800
Message-Id: <1653534995-30794-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
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

This patch series is to make ocp level selectable.

Some application design use small inductor. And it's easy to trigger the
over current protection. Due to the OCP limit, It make the brightness current
not match the configured value.

To meet the HW design, the ocp level have to be selectable.

ChiYuan Huang (2):
  dt-bindings: backlight: rt4831: Add the new property for ocp level
    selection
  backlight: rt4831: Add the property parsing for ocp level selection

 .../bindings/leds/backlight/richtek,rt4831-backlight.yaml   |  8 ++++++++
 drivers/video/backlight/rt4831-backlight.c                  | 13 +++++++++++++
 include/dt-bindings/leds/rt4831-backlight.h                 |  5 +++++
 3 files changed, 26 insertions(+)

-- 
2.7.4

