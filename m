Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A65D5929CE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 08:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240960AbiHOGqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 02:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiHOGqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 02:46:51 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6320F1274B
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 23:46:50 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id u133so5972957pfc.10
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 23:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=1w/+dFs3qHXbDgwwcXAk7wk0nI9cjI/ETzQwM0WXM7M=;
        b=c+Ok3qnKqp9fTdGMCOumYQW8c7kdDIeshFpol5j9R1lh85E9ONXyN9Ks5tp5BKso1r
         IcapWSIm+VQmVbWWdGuvB7X358tWZR0/Ury571YiT43L1wQrv+nc6FZoT56hCNEDzK5u
         aXpwpLDf4f3WJL1E7tUbzy+wn6B0Mo1K1yabc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=1w/+dFs3qHXbDgwwcXAk7wk0nI9cjI/ETzQwM0WXM7M=;
        b=1tw3i1rZ41wyZ7NfUgS9kUK+HGgF0SGPcojufarSPDb6Y7aNZpWEAvKjwJNTfIyxS7
         Re0oaM3wgNFQEmhTMdy5J+Ip8HpHc6NPU7k90v2GXX7e+jpaVoK9R466t08d9D9qcfHV
         5zkFqXpx0CXqtnOAT4Pm0YYbO2CqZeYpnVaOeLEFo/4PPGaDNBpIE4TjYoF/D1qUiOS9
         YZ3UGhyNo5wv1AJ4bpFLYJxOb9T6/mXq3lttNYiAn0xZq6VwZHGycqWwZJ/5qtul7QdW
         fdpY6mfzuPlW7pEkRsYN92pH5AulC9xJnmHI0obsE97JXitpOJWHeLzXLHI2QQgkaMFg
         +NXQ==
X-Gm-Message-State: ACgBeo0YQWqbDvExCfy+dCnplDWZNhArZ9pHuu7jXWGKOF0qpk5s+VTY
        4S2mVqVX9DEI7MvwzOGFGNmtSyGF+fAeuQ==
X-Google-Smtp-Source: AA6agR5II5bdhSqLWarYZ2IWhos4bAF5oIBs5Mk8jg7lxj85GCJRpLEucneEznC0TaAzBMuusm1rWw==
X-Received: by 2002:a63:8a44:0:b0:41c:cd7b:eda0 with SMTP id y65-20020a638a44000000b0041ccd7beda0mr13088494pgd.117.1660546009677;
        Sun, 14 Aug 2022 23:46:49 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id 200-20020a6214d1000000b0052db82ad8b2sm5988233pfu.123.2022.08.14.23.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 23:46:49 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Cc:     bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH v5 6/7] platform/chrome: cros_ec_typec: Cleanup switch handle return paths
Date:   Mon, 15 Aug 2022 06:34:28 +0000
Message-Id: <20220815063555.1384505-7-pmalani@chromium.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
In-Reply-To: <20220815063555.1384505-1-pmalani@chromium.org>
References: <20220815063555.1384505-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Changes since v4:
- No changes.

Changes since v3:
- No changes.

Changes since v2:
- No changes.

Changes since v1:
- No changes.

 drivers/platform/chrome/cros_ec_typec.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index de6ee0f926a6..ee54add992db 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -158,12 +158,10 @@ static int cros_typec_get_switch_handles(struct cros_typec_port *port,
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
2.37.1.595.g718a3a8f04-goog

