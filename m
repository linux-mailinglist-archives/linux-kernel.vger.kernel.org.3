Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD07958E70B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 08:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbiHJGBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 02:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiHJGA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 02:00:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD57D6543
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 23:00:56 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id m11-20020a5b040b000000b0066fcc60d1a0so11399548ybp.19
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 23:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=YZpb5QMLSiLGJVomN8fbI7EvU2NAh/GQGzK/ScajhVo=;
        b=kdufMKJarzPJUSUXa9Lkyppvpmugt3JrF1lgKjodq0AS8PmSnyNnsq5cSojkvWFydP
         4SlosfOvXqDnb9Otj4vuNf4C9sjbZeyEg/pJMTXQe026M/y9/1hjbxROqrTHxBCE1754
         oBloAVDejrDfhsaIqrAL6utmIa3sceIQqZEseSzOdVx/5c7Xg+AOdDBJ+nkSyNuwTOPd
         qotXnqs5f2mFDey1C4raGc6DlxYepToi5rZGMEx5ZpcTB4d54i3ScEmzcurJy+/1YfTe
         CH/n1d3h37wT/JtauKwkMlnMGxKOuLKCxLdzeVmnrYXONHl60Vld8ABImyxhgBPBLYqj
         frqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=YZpb5QMLSiLGJVomN8fbI7EvU2NAh/GQGzK/ScajhVo=;
        b=mPtVHu/z+X2I4vOAXBmoJ1GMAAXJeUweWsrWxplMModTFgRgkIIsmqsXh6gMclbco9
         yX8ApakcG9ciCKdBXOxa2FXhgHl+d1HEmHMd9nKXOclfC/oFIy1UkMXcGfm7zzqvIW6f
         K4cy9K79sNUKQAWKFK1d/mA3S1OcKhSiUQSvGC07aerSrf9rMAyOKmTGVd8AqZ62yFSS
         HA/AJBhzj64tdqdlmV+zI8iEqeuJGZqwpLZWYu469dZ8py3zVBkvKRVUD86wwf+5/KkL
         zjUdDl6eO1fVY2C9oGMixkcG/wZ8+uh1vV2ua1FcCmEK5N9SdtFRJtVbEgX/Uf4cXMXL
         4W5g==
X-Gm-Message-State: ACgBeo0nefQNkROqhtoF4Z+n4QW2bvZfCxdVB0akQiuSeoJyKv2snaIp
        was37ttgcaKUHPcGnHv/1ueEakz/D9+Nv0M=
X-Google-Smtp-Source: AA6agR7ZTfYG48/VyeszVgW+xw1hG2i1zXLZfrMjpmwx4bEiOBYzEVkJ83eHKaSOJD8LIzkwYIYdbUt4DUfVhhY=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:f21:76ca:766f:e0ab])
 (user=saravanak job=sendgmr) by 2002:a0d:cc8b:0:b0:328:3005:37a0 with SMTP id
 o133-20020a0dcc8b000000b00328300537a0mr27540603ywd.470.1660111255729; Tue, 09
 Aug 2022 23:00:55 -0700 (PDT)
Date:   Tue,  9 Aug 2022 23:00:32 -0700
In-Reply-To: <20220810060040.321697-1-saravanak@google.com>
Message-Id: <20220810060040.321697-4-saravanak@google.com>
Mime-Version: 1.0
References: <20220810060040.321697-1-saravanak@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v1 3/9] soc: renesas: Move away from using OF_POPULATED for fw_devlink
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Tony Lindgren <tony@atomide.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OF_POPULATED flag was set to let fw_devlink know that the device
tree node will not have a struct device created for it. This information
is used by fw_devlink to avoid deferring the probe of consumers of this
device tree node.

Let's use fwnode_dev_initialized() instead because it achieves the same
effect without using OF specific flags. This allows more generic code to
be written in driver core.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/soc/renesas/rcar-sysc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index b0a80de34c98..03246ed4a79e 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -437,7 +437,7 @@ static int __init rcar_sysc_pd_init(void)
 
 	error = of_genpd_add_provider_onecell(np, &domains->onecell_data);
 	if (!error)
-		of_node_set_flag(np, OF_POPULATED);
+		fwnode_dev_initialized(&np->fwnode, true);
 
 out_put:
 	of_node_put(np);
-- 
2.37.1.559.g78731f0fdb-goog

