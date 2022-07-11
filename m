Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB8D57083E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 18:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbiGKQZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 12:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiGKQZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:25:10 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396934B0D6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:25:10 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id c15so30771pla.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ukc3FdWjfLcH/LmKOFw9wVHJnBYxyOJ3TZo5iySD7CM=;
        b=mos/Mg0hb/2sKrl+1pyR3cc5pWrcxHNMusFW9vCuu+2DGtN5aBipvTN30Jc6drre+T
         /RFl5RGuERg3AZGdQXD0762fpVS5LkIrZ+Dmfr0iPstEiYmS197oZdnqO/gsd0V2LLrA
         dMbFtl9QauwEhNzOkDMmTLhCVI/jC7ytB3nJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ukc3FdWjfLcH/LmKOFw9wVHJnBYxyOJ3TZo5iySD7CM=;
        b=Py+qk9WuZbz1XrNu+2EgxzA6giPnHTvPfaZUf6IIZuW0cE8m4QET4e3fkdnHli6PLD
         llDqztOoyn+LsQITzzFmHVyyReYEEFOxMgmxiYuRRZCbolMxR+5yZNusFxl4Nr/QvjnG
         enicZHVFRwaB+QvWq+NLdM4ZhgcZof4bqFK7Def5ewgarRHApvgxXThzueCiIR0O7T+5
         i+a+JrbTA7GDG0hQnJeHNAKpR3PNzDpL/zn7PViWzDff3K7BE2KfTw6DfqTwkQDJj9er
         zqzxxbwS0CKKYC95bfG/wg7FKOZeRYDvvp745bCCcR2SXpVtWWdBjM9/faW1/JgX4gwS
         IlhA==
X-Gm-Message-State: AJIora9yGYg0bOm+o4ChsX+f44ih+Tp5paRzEW/nSvAuUpsilBKGbeaN
        u4dJlw4ggaDoUN/0c7JBGlDeXA==
X-Google-Smtp-Source: AGRyM1sqfkSPHvkTxOaPtZOcTNkMYSm2yWVjkihbwLCJH3gYz50+9KRFnfZffXUT+5VHv4SdyYdA7g==
X-Received: by 2002:a17:902:f64f:b0:16c:23c2:e2dd with SMTP id m15-20020a170902f64f00b0016c23c2e2ddmr19017073plg.3.1657556709786;
        Mon, 11 Jul 2022 09:25:09 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:7b75:79f4:3be2:2c65])
        by smtp.gmail.com with UTF8SMTPSA id e7-20020aa79807000000b0052a8128699fsm4967587pfl.207.2022.07.11.09.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 09:25:09 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject: [PATCH] usb: misc: onboard_hub: Fix 'missing prototype' warning
Date:   Mon, 11 Jul 2022 09:25:05 -0700
Message-Id: <20220711092431.1.I4016c759fd7fe2b32dd482994a20661f36e2cae3@changeid>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with 'W=1' the compiler complains about missing
prototypes for onboard_hub_create/destroy_pdevs(). Include the
header with the prototypes to fix this.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 drivers/usb/misc/onboard_usb_hub_pdevs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/misc/onboard_usb_hub_pdevs.c b/drivers/usb/misc/onboard_usb_hub_pdevs.c
index a0a5f719129f..ed22a18f4ab7 100644
--- a/drivers/usb/misc/onboard_usb_hub_pdevs.c
+++ b/drivers/usb/misc/onboard_usb_hub_pdevs.c
@@ -15,6 +15,7 @@
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
 #include <linux/usb/of.h>
+#include <linux/usb/onboard_hub.h>
 
 #include "onboard_usb_hub.h"
 
-- 
2.37.0.rc0.161.g10f37bed90-goog

