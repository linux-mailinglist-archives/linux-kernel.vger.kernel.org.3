Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8515459A617
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 21:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351238AbiHSTJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 15:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351147AbiHSTIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:08:38 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF3E20F7C
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 12:08:36 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id 20so4879160plo.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 12:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=DqrEek4KEewVAx/BWFwpw/lOY/BhLwmErxM0R0EWxLo=;
        b=MwFNBQo0TZ6ZipDVfvyCnneHe7+leBOXAzZu5KqzchrPPb9Yjc/vvEEVuvx+qV39vO
         V5YCldxxCyOYEdgy093cDUANWG7mMGS+mR3UEfYCTayQ2a4lv/xVijHlz9ZSl8fLus7o
         3YcHWTykQ89fdE+pG+jslDjXurkjxMpD/BRHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=DqrEek4KEewVAx/BWFwpw/lOY/BhLwmErxM0R0EWxLo=;
        b=c27RviL+l3J/AhnA6MMW3KNSvcXSkkc1ikFsDHibduU3ds3Yvplc09RUKTKoU+mh0q
         ryGVXykiViOFESMWuaEehonCWKagWp08HnkJH1Xs0vYkWRc3GpjywSQmxw+bemgRVGiT
         SSro/Q8G0zl+oaOQZ54iG8aiNPlz0ph5QzTFS6hHcvnodzaKTInBp2/sTErLuOOCidZG
         yCHwSuucPkjQ3BlAFIpl+Dk2VHpiV1of+TRDTNQP1bHlFwIvw4dz/svWi/wJuDuyibTJ
         DrL80KaXlsZ3re9izlexuPF4s6g1MVnfCTNuir0dbHmvQ+lrT5W/V7/rtab9aTQb+sBc
         b7BA==
X-Gm-Message-State: ACgBeo0s0kmvFngwJalXMuvIZRiPPNOuWd6TDnVzpxzMR0wGi3B+qrEo
        ZGyi1EKHTfW4H4iBv3+rOA2czgRXcN73EA==
X-Google-Smtp-Source: AA6agR4T/qUdLe4Pb2e1At9eR7z2ZJw11QKB/5L2FNFC3ZuaAZNkzzsZtZz5GcksgRnluCf8GT0Tyw==
X-Received: by 2002:a17:90b:4b89:b0:1f5:68b:b14e with SMTP id lr9-20020a17090b4b8900b001f5068bb14emr16054333pjb.30.1660936115902;
        Fri, 19 Aug 2022 12:08:35 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id b14-20020a170903228e00b00172a567d910sm3499775plh.289.2022.08.19.12.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 12:08:35 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Cc:     bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 4/4] platform/chrome: cros_ec_typec: Use Type-C driver data
Date:   Fri, 19 Aug 2022 19:08:05 +0000
Message-Id: <20220819190807.1275937-5-pmalani@chromium.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
In-Reply-To: <20220819190807.1275937-1-pmalani@chromium.org>
References: <20220819190807.1275937-1-pmalani@chromium.org>
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

Altmode driver callbacks need EC-specific port information to
communicate with the ChromeOS EC. To accomplish this, save a
pointer to the driver-specific port struct in the Type-C port's
driver data field.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 7daf4207c11e..e3f75440030d 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -379,6 +379,7 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 		ret = cros_typec_parse_port_props(cap, fwnode, dev);
 		if (ret < 0)
 			goto unregister_ports;
+		cap->driver_data = cros_port;
 
 		cros_port->port = typec_register_port(dev, cap);
 		if (IS_ERR(cros_port->port)) {
-- 
2.37.1.595.g718a3a8f04-goog

