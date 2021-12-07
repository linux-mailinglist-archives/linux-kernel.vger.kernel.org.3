Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4099E46B9AF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 12:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbhLGLEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 06:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbhLGLEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 06:04:33 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E925CC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 03:01:02 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id w1so55327577edc.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 03:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ptsvV1kleA1LtJa+QFl6NmI3SOUoq7RBkJ0eF/rWVyU=;
        b=AkuoJj6cCFFXgQqRtrrmz1i66mQV9j6h2awDmburQUuGzBr86ub6W2c4ZcdtbT324j
         DvrThKp2QleDKBIrI25cGkr9BJZGNlDmH/TeC/KkrmrhzFW3l6T5oSovmvGsI+GVULlx
         dyMuU3ZwI2Ct1Bf5lqpZqbOfWZY41FfZA/ygU+egJjQT2C+CBQnKxYhu72bm4Bmi3Vgn
         f4aLfvyIsDhlN7gfSHNv70b1g+CleSswJAb2YHgHp11D9Ml987EItr6T2T/70yCpRCRi
         Icij1+d6W+EIDT2n0CAcGCUtrdDs/RxozhUhiKV17RI6+7VKAyiK2BKAGAdUNzYfEVXc
         +nZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ptsvV1kleA1LtJa+QFl6NmI3SOUoq7RBkJ0eF/rWVyU=;
        b=Fb+wJbLd7eWMJ6CAGleQ1KFcEO/0GPEhR6/Il3B3AIaosWYW3aQPu/H8DB2mhvNNC7
         aru9c0GePYlQs2obipDXgLk7ySZIcS4qn1R3v1IrqPClfuqjOQoX/1D7HSr9oB8YcbgL
         4WdPj4/u2ng90mQBS4mXHfXYqFVipegD8fQFXJKcXBRAV2sTkUvR0r1nfCxBePckPvij
         bTxNWblDAJLNWrv10pWBApHxACDCzdCRbOpEe4ejo2iPLfLo0+A+Ce+ny597Hjc1lwCd
         R5xNapDW+LvqdM2ZEj957nR/xMai17/98oJBXf2iG+mruRBBf+qk7nd+K0P/ygoJRVJv
         R0KQ==
X-Gm-Message-State: AOAM532+8IdGvIyoMO5Dm2JbjmrOgOUHfvL5JNHJN8Eh4VLOZ3QJeD7Q
        qZuoA4NGCNh7KHanF7nl6qIjbg==
X-Google-Smtp-Source: ABdhPJyL8WuOA2aVcFyjxLd0b5iozXAcekRxzldlcNfDg1/+YC8Ucg0r3084WvyJl0shdFPPBaIbRg==
X-Received: by 2002:a05:6402:147:: with SMTP id s7mr7987920edu.8.1638874861500;
        Tue, 07 Dec 2021 03:01:01 -0800 (PST)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id h10sm9939533edr.95.2021.12.07.03.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 03:01:01 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     perex@perex.cz, tiwai@suse.com
Cc:     nathan@kernel.org, ndesaulniers@google.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH] sound: ppc: beep: fix clang -Wimplicit-fallthrough
Date:   Tue,  7 Dec 2021 12:00:53 +0100
Message-Id: <20211207110053.695712-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

sound/ppc/beep.c:103:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
        case SND_TONE: break;
        ^
sound/ppc/beep.c:103:2: note: insert 'break;' to avoid fall-through
        case SND_TONE: break;
        ^
        break;
1 warning generated.

Clang is more pedantic than GCC, which does not warn when failing
through to a case that is just break or return. Clang's version
is more in line with the kernel's own stance in deprecated.rst.
Add athe missing break to silence the warning.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 sound/ppc/beep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/ppc/beep.c b/sound/ppc/beep.c
index 0f4bce1c0d4f..bf289783eafd 100644
--- a/sound/ppc/beep.c
+++ b/sound/ppc/beep.c
@@ -99,7 +99,7 @@ static int snd_pmac_beep_event(struct input_dev *dev, unsigned int type,
 		return -1;
 
 	switch (code) {
-	case SND_BELL: if (hz) hz = 1000;
+	case SND_BELL: if (hz) hz = 1000; break;
 	case SND_TONE: break;
 	default: return -1;
 	}
-- 
2.33.0

