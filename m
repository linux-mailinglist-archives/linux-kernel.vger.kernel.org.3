Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7437C5123F1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 22:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236505AbiD0Udp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 16:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235608AbiD0Udl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 16:33:41 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122E8BF69
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 13:30:29 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id p6so2552283plf.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 13:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0An4PsvfV0601Q48LoUPqvVr8Bqsk0vm3xIqSwfj0Xo=;
        b=C1jLISe/eHjTAY7Yp96I7k+1AB2QekHwbYrjOoF6fNLDKBX394wxFdxk7wumcpQIo0
         zDRxwZnw9o9TOxnsypU1mn4zAd1Bni+SjNoxpVt2QxvYm56wioHwufVYBrnlt3aGc6tN
         mdVln6h2XLZ3Fjf4UMvmUnzxgWVXhzRHDpYu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0An4PsvfV0601Q48LoUPqvVr8Bqsk0vm3xIqSwfj0Xo=;
        b=OzDd9ogha4zwsjiMV7uo9P2aoseBqixcQWTSSieM/f/NQVnQcp1VckMRyv/biK8FPj
         74sxDZ5HfZ1JZaD80n6QXQkHgj3N4PMdZtpXh/A5r4HfQC3adLzSTkuZx1t1pwuBgshU
         pu/Rq/iCL1HQIebjOZsJQ/tSAvWZlICKYECOHPKpbNdFlK+FWpLS+eJ67HkXLGZEsI3r
         te/2YSy3R1+0Si3rkRTRtFpHnyI4uMCr8V1ak+7T7Q9dHym09dQozWW3KSvRmlZbeNOi
         dXz2R5DZANTTtamhSsUDDSEzIXnZnji2USJ/jrSwRejivnCOzzULvDSrxwk+ZDF9ZhQa
         h5zQ==
X-Gm-Message-State: AOAM533ye9XtblExhcBE7HOjN2aw98U0uWsDiCV+/3CXkPtfgjOG1htQ
        7fP/HQ/4w0E6ogY6Jz7E3E1Z8g==
X-Google-Smtp-Source: ABdhPJzZNWd2rOVEB4rsikOmKbzoJwM/16jcMtIJTw1nlAHLR+EFFNGpmmgtG99tnrf4SY15QyBCZQ==
X-Received: by 2002:a17:902:edc5:b0:158:4065:a5ce with SMTP id q5-20020a170902edc500b001584065a5cemr30951557plk.55.1651091428570;
        Wed, 27 Apr 2022 13:30:28 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:482e:60bc:84d1:bf5c])
        by smtp.gmail.com with ESMTPSA id 7-20020a17090a000700b001da3920d985sm3858552pja.12.2022.04.27.13.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 13:30:28 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
Subject: [PATCH 0/2] Input: cros-ec-keyb: Better matrixless support
Date:   Wed, 27 Apr 2022 13:30:24 -0700
Message-Id: <20220427203026.828183-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a followup to my previous patch[1] that skips keyboard registration
when the matrix properties aren't present. This adds a compatible string
for this scenario so we can ease existing DTBs over to the new design.

Stephen Boyd (2):
  dt-bindings: google,cros-ec-keyb: Introduce switches only compatible
  Input: cros-ec-keyb - skip keyboard registration for switches
    compatible

 .../bindings/input/google,cros-ec-keyb.yaml          | 12 +++++++++---
 drivers/input/keyboard/cros_ec_keyb.c                |  8 ++++++++
 2 files changed, 17 insertions(+), 3 deletions(-)

Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: <devicetree@vger.kernel.org>
Cc: Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: "Joseph S. Barrera III" <joebar@chromium.org>

[1] https://lore.kernel.org/all/20220425210726.3813477-1-swboyd@chromium.org/

base-commit: 4352e23a7ff2f8a4ff229dd1283ed2f2b708ec51
-- 
https://chromeos.dev

