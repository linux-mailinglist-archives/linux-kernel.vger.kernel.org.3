Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E7D4AF9EF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 19:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238655AbiBIS2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 13:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbiBIS23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 13:28:29 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2D3C0613C9;
        Wed,  9 Feb 2022 10:28:32 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id g145so2383255qke.3;
        Wed, 09 Feb 2022 10:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bn0WKXvV0wH64Fyn35769rJ1j57jq4L1z8r72QPkfFc=;
        b=mk35s4az97TJp7WfXMKqywtvIL/s3xNeyXIfFuo5hIiD8kYz7JSXzA7iPm9s93qzia
         rb9GnE5LW7nRpZ5aApDa/VEWjtoepo5/CyhjVaBUdBoy+s6YmL5mMXqhqTveEu2JO6ig
         acHz36mOOUPVnZ/e87ob1egzCaZQlawtlR2btLGEwhgHF68EfsS+2QcmFuQlR6w9ddkC
         ko1PzC494fLN6e9THRBv01pXvoFr01ts5EwGBi5MyI3IcDPQdsUOdjYRKqsH4MSehPV2
         6iD5ZLJLjhdlURGdbduaTHkRstqsfgK4kkffV4QSa6AH4AAUjSL+rVzPKnfrwBnjD36v
         vPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bn0WKXvV0wH64Fyn35769rJ1j57jq4L1z8r72QPkfFc=;
        b=4pZN49pjxBX1E0zORTBujEtykZxz1BrChcZVv6eABMeN5nKPFUPawekPtt2eSaU27/
         Zgstm6JrxLXYjCf2W4YUk0hKboL5iKJ7DpLrqgqwNS2pHQtSR8tyJQD8sq17cKffhvCP
         zF2NBx/NlnvVdwcF57/74uCHVQQ391kT+9Dj55tjXXvGtR+ROw8M5vrqeQT9db6cTFpa
         SXumzXAC+3ggXq12AAsUX6+9zrUaqOxExD4+pFRdInckINR1SUEkwJt+rrIwbhuq3eP8
         3kjNal0HSPz+P5MPfEYXPPOMy912Fd9q2gv22UgFs43FBrCKQXsbRuY0bjnhUG4pQDgx
         UWAw==
X-Gm-Message-State: AOAM532X2yu/9f+PioajrLZvUKTuMNZFkcrFFiujfllhzhz58Jy3DKgl
        mK/DlOt8nKX5XzIXZDKmcNk=
X-Google-Smtp-Source: ABdhPJwYVNCTYVD+5C3ouMfC747bld6PVChncLlfcf5qjZ4TddDhI+r6fR1YfMvelphlJtWlOxiYGA==
X-Received: by 2002:a05:620a:25d2:: with SMTP id y18mr1886373qko.522.1644431311724;
        Wed, 09 Feb 2022 10:28:31 -0800 (PST)
Received: from godwin.fios-router.home (pool-108-18-137-133.washdc.fios.verizon.net. [108.18.137.133])
        by smtp.gmail.com with ESMTPSA id z4sm9831131qtw.4.2022.02.09.10.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 10:28:31 -0800 (PST)
From:   Sean Anderson <seanga2@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Sean Anderson <seanga2@gmail.com>
Subject: [PATCH] pinctrl: k210: Fix bias-pull-up
Date:   Wed,  9 Feb 2022 13:28:22 -0500
Message-Id: <20220209182822.640905-1-seanga2@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using bias-pull-up would actually cause the pin to have its pull-down
enabled. Fix this.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 drivers/pinctrl/pinctrl-k210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-k210.c b/drivers/pinctrl/pinctrl-k210.c
index 49e32684dbb2..1ad61b32ec88 100644
--- a/drivers/pinctrl/pinctrl-k210.c
+++ b/drivers/pinctrl/pinctrl-k210.c
@@ -527,7 +527,7 @@ static int k210_pinconf_set_param(struct pinctrl_dev *pctldev,
 	case PIN_CONFIG_BIAS_PULL_UP:
 		if (!arg)
 			return -EINVAL;
-		val |= K210_PC_PD;
+		val |= K210_PC_PU;
 		break;
 	case PIN_CONFIG_DRIVE_STRENGTH:
 		arg *= 1000;
-- 
2.34.1

