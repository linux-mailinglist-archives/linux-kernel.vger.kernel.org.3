Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7362A560DAB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 01:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiF2XkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 19:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiF2XkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 19:40:12 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B757679
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 16:40:11 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id g20-20020a17090a579400b001ed52939d72so1015378pji.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 16:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QRbeot/MuGcqM6NZGZgB9B0h/YlW+GCV/NmCj8D78sc=;
        b=DdlpdV5bCDZGoOcRiumEE3M8qO1XA4NR58Hn0k2DAMnCsFQdg1G5MUhFt8XnNZ1xsx
         IRSTVkMLmB70VB8r5y5sTOiOGihytY/lbwsWejaUtr5+A1GQFaSD3dNfMoU3HQAyWESe
         SolplSffVxkCIZup4rLOnMVbrDbihKQZ9ThTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QRbeot/MuGcqM6NZGZgB9B0h/YlW+GCV/NmCj8D78sc=;
        b=e3pVpS2440nANdC2Ewdb7VPvRZlBKdNzVsZRYs67H3yAE/r7q/bcXemqUAsNARN78f
         zHmc5hoHmEaCUGDXjcPs3y68rk1Tcu+P5d3k197vozEMvAzqz00Unfx2GMkwnKENe1Pu
         9aTuJHH3VpCIToqPelmD8CdEmYkusUT18qCGINEegkl7rtmqbLCKvAEN9Gh/Vkcggo+0
         mQhbBYHZTIOieAO+A8O/sMjEH3UgWlJMRV9Wak6ZQIjT5rK5G1tblbPPHv4kVRL8RYZd
         4YKzDWX6KjCJ3EQPx5T/ciJExp5XRHcMydVZ8f6pMFE8YBZUAbOg3NcXPY39AJP9dJiu
         ft4g==
X-Gm-Message-State: AJIora/2a2L7BmyAJiemqyOgYJJYfkUgJKvClSln18gLsD4GaN90LV2t
        VDHAVqM05amB9QUj4Mz1vosJ6Bv/Mz5jYQ==
X-Google-Smtp-Source: AGRyM1sRWxPwy3uGWZPwxBdeXGbZYOch5+sAQm6m3ULiSuqR1NRow9vm5zjBjP3lHcRZcr0OyWqSXA==
X-Received: by 2002:a17:90a:8413:b0:1ea:ebf4:7079 with SMTP id j19-20020a17090a841300b001eaebf47079mr6862922pjn.48.1656546010854;
        Wed, 29 Jun 2022 16:40:10 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id rm1-20020a17090b3ec100b001ed27d132c1sm127305pjb.2.2022.06.29.16.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:40:09 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        chrome-platform@lists.linux.dev
Cc:     bleung@chromium.org, heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH 8/9] platform/chrome: cros_ec_typec: Cleanup switch handle return paths
Date:   Wed, 29 Jun 2022 23:32:26 +0000
Message-Id: <20220629233314.3540377-9-pmalani@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233314.3540377-1-pmalani@chromium.org>
References: <20220629233314.3540377-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the return paths for the cros_typec_get_switch_handles()
aren't necessary. Clean up the return paths to only undo the handle
get's which succeeded.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 7cb2e35c4ded..39e6fd4491a9 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -157,12 +157,10 @@ static int cros_typec_get_switch_handles(struct cros_typec_port *port,
 	return 0;
 
 role_sw_err:
-	usb_role_switch_put(port->role_sw);
-ori_sw_err:
 	typec_switch_put(port->ori_sw);
-mux_err:
+ori_sw_err:
 	typec_mux_put(port->mux);
-
+mux_err:
 	return -ENODEV;
 }
 
-- 
2.37.0.rc0.161.g10f37bed90-goog

