Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB41472B20
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbhLMLRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbhLMLRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:17:08 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23446C061574;
        Mon, 13 Dec 2021 03:17:08 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso10708429wmh.0;
        Mon, 13 Dec 2021 03:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uMRBfgWTYGWrAoh1xYDEsd3By2T32yUhl9tQpBijeUw=;
        b=P8KULp4RxAz/ZT3rc5HBAu6BiRCKUwkHxSWSabJl6DUuHUToGmquWXEu0dmZjTSdEx
         p58Z2hLKMJI5qfFo06+WZfEidkd9apgHIGq2nugu4cqCfEh0jmhX/C79kp8Hq+fwqYOn
         JJS2J7BviG5r+grRwCg1xKEsS0sFHr3b6BFji/ffF0FBl3FrZ5JxxwshELUZYginOLfr
         3S/5V0HsimlPq2K/tem1OcjUf2Sm6OaTqqimAjiQ4mU04BG5rweeJG3l2H+qp0oZR+uA
         WTQsjqA5S2i2KwJwF+XBJSwOQuIfj4n9mUMmHx/RDep16pBClT75n+1+BfVTbGj8NKcK
         3Esg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uMRBfgWTYGWrAoh1xYDEsd3By2T32yUhl9tQpBijeUw=;
        b=2DfpJF5NunM7838wRZ1udTGDCND7vRhp8qicDQF5ieRi6Yt18Y6PL2R3+iASuFAqN0
         E25v8b6GC3KDlPsgpwd9yd26KlTrSNGkp/bEEVaA1a53qlLtzkATWzQTIIbgzyu+XZeZ
         Ds9a1Jxw+1SBQ5HqroxBJZZWdiWkwYcH5sAxSoNyXDi7Mo+3Y+eUKo/qnCQGRAq98L2a
         kwP0FQ3163dC9fN+JLUIoE6h9sXZfSNznX+M+XRAL2xbm8v8TtYzN+yPz59UCjiIzRRa
         BCtHhiPlB+Xq7e1feB+N27k3/XZjbFgL1DAsB8TH88V0EQbAjbZGmoxmhP7a7gU/piMO
         OLsQ==
X-Gm-Message-State: AOAM533FLma7X8IKTuZpK2TxIP7pbaAGw1/xgLMklW4Q16zarLgf6sIC
        6xq7UPLdxkdeuyEjDzIXQCLP6yhtjH8=
X-Google-Smtp-Source: ABdhPJxRGYfYxeyJl459scyOTisugPEc2QmERThdCAzY4wLxtONPCFT8jSjVxD+jQL3W3deInk0dcQ==
X-Received: by 2002:a1c:1d04:: with SMTP id d4mr35779758wmd.103.1639394226732;
        Mon, 13 Dec 2021 03:17:06 -0800 (PST)
Received: from DEL01603w.ebgroup.elektrobit.com (eth1-fw1-nbg6.eb.noris.de. [213.95.148.172])
        by smtp.gmail.com with ESMTPSA id t17sm7255255wmq.15.2021.12.13.03.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 03:17:06 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Sander Vanheule <sander@svanheule.net>,
        Bert Vermeulen <bert@biot.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Daniel Silsby <dansilsby@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 7/9] mips: alchemy: remove historic comment on gpio build constraints
Date:   Mon, 13 Dec 2021 12:16:40 +0100
Message-Id: <20211213111642.11317-8-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211213111642.11317-1-lukas.bulwahn@gmail.com>
References: <20211213111642.11317-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ./arch/mips/alchemy/common/gpiolib.c, the comment points out certain
build constraints on CONFIG_GPIOLIB and CONFIG_ALCHEMY_GPIO_INDIRECT.

The commit 832f5dacfa0b ("MIPS: Remove all the uses of custom gpio.h")
makes all mips machines use the common gpio.h and removes the config
ALCHEMY_GPIO_INDIRECT. So, this makes the comment in alchemy's gpiolib.c
historic and obsolete, and can be removed after the commit above.

The issue on the reference to a non-existing Kconfig symbol was identified
with ./scripts/checkkconfigsymbols.py. This script has been quite useful
to identify a number of bugs with Kconfig symbols and deserves to be
executed and checked regularly.

So, remove the historic comment to reduce the reports made the script and
simplify to use this script, as new issues are easier to spot when the
list of reports is shorter.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/mips/alchemy/common/gpiolib.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/alchemy/common/gpiolib.c b/arch/mips/alchemy/common/gpiolib.c
index 7d5da5edd74d..a17d7a8909c4 100644
--- a/arch/mips/alchemy/common/gpiolib.c
+++ b/arch/mips/alchemy/common/gpiolib.c
@@ -23,8 +23,6 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  *
  *  Notes :
- *	This file must ONLY be built when CONFIG_GPIOLIB=y and
- *	 CONFIG_ALCHEMY_GPIO_INDIRECT=n, otherwise compilation will fail!
  *	au1000 SoC have only one GPIO block : GPIO1
  *	Au1100, Au15x0, Au12x0 have a second one : GPIO2
  *	Au1300 is totally different: 1 block with up to 128 GPIOs
-- 
2.26.2

