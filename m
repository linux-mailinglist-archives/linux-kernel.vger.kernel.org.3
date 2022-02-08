Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B564AE15C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385365AbiBHSrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385429AbiBHSre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:47:34 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954F7C03FED7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 10:47:28 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id z13so55331pfa.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 10:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e3mDsgPoCgCrdjC5qFpp5/iSytvlH62dGtUdddIuE3E=;
        b=CghqlIsbj6Rxbr80iMIRS6hVt5LWGI8A122UztcA3EyxvmEzTAZf+cC2u7rAg0LAHk
         8YHiwwLBwgBG9Y58GoUbf7fgYICCy+ds0fSHZSNO4Q2WmUWZpyukUTRY1wbSVP1CuvQ0
         6UDu+NUJX2oH0K5yUWl0QhVR11y9bfGXgIhJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e3mDsgPoCgCrdjC5qFpp5/iSytvlH62dGtUdddIuE3E=;
        b=NmE6E602N0Lrds+0p4yWPb8H/7rdq5tohgnJxuWUEIn/rrQzq1Equ+REiv281OPjUE
         Y+zla7jjPij2VufHCZFZVPfErd3o7G0o+shIZbvppeHWN6WH1nzMoNrJaaWILNNSODSY
         qRviqhBj6NCODdNDWEGOTtZfGTMXYvjPLReMXmgdFboT+TVTeiTyRe1FueiclMFdhwNt
         EHFcjVum9lLgwcJj4i5I0IIlPW6Kv2N9cNUscbopbIb9iaVM0X5vSoAz6hJS3vtDCElG
         c+iDiKKVUUJ2emcdZhqHfhqnhdEn7j2GUZ7htVLEmFbZDbh+ZYOsXQ26CSxQMF+KNl7k
         /nhQ==
X-Gm-Message-State: AOAM531OSr1xviHXjG/QEWC5SRURztr8cgSy2u+TA87ZR46uH+8QBsf4
        H9utvJO4Cir53Kl8KF/PhKUonPd3W6Uwhw==
X-Google-Smtp-Source: ABdhPJwmmlG3Hr5gYkqZeLrgLcdQSx95Xr9IgrXutd+5QJRvfxQljD50gKaZjrJ7XAyNISUBOUFOIQ==
X-Received: by 2002:a63:4743:: with SMTP id w3mr286743pgk.207.1644346047783;
        Tue, 08 Feb 2022 10:47:27 -0800 (PST)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id gk15sm3594453pjb.3.2022.02.08.10.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 10:47:27 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        chrome-platform@lists.linux.dev (open list:CHROMEOS EC USB TYPE-C
        DRIVER), Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v2 0/4] platform/chrome: cros_ec_typec: Reorganize mux configuration
Date:   Tue,  8 Feb 2022 18:47:16 +0000
Message-Id: <20220208184721.1697194-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a short series that reorganizes when mux configuration occurs
during Type C port updates. The first 2 patches are minor refactors
which move some of the mux update logic to within
cros_typec_configure_mux(). The third patch moves
cros_typec_configure_mux() itself to be earlier in
cros_typec_port_update().

The final patch updates the stashed mux flag when a partner removal has
occured.

v1:
https://lore.kernel.org/chrome-platform/20220207214026.1526151-1-pmalani@chromium.org/

Changes in v2:
- Addressed minor comments (unrelated variable initialization. variable
  name change, return value can be 0).

Prashant Malani (4):
  platform/chrome: cros_ec_typec: Move mux flag checks
  platform/chrome: cros_ec_typec: Get mux state inside configure_mux
  platform/chrome: cros_ec_typec: Configure muxes at start of port
    update
  platform/chrome: cros_ec_typec: Update mux flags during partner
    removal

 drivers/platform/chrome/cros_ec_typec.c | 76 +++++++++++--------------
 1 file changed, 34 insertions(+), 42 deletions(-)

-- 
2.35.0.263.gb82422642f-goog

