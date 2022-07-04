Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B7A565548
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbiGDM1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbiGDM0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:26:48 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB18211445;
        Mon,  4 Jul 2022 05:26:35 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g1so3878269edb.12;
        Mon, 04 Jul 2022 05:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A57xIfZLi+2djoYykZ8gRv7aiC4YCwj7z7nIR/tXI5o=;
        b=coR324dl9u8bJdxNIPw+0PjsEaehvlW2soGBvNcXFpAg0zszQjxOAzFUryxP8HMcUo
         W9Kyf55jA2KcgZb/ZbVWF93GEaAPw7Ie3wZMNNlWOgYxUkQRJ5j0IfkOmjGcpmUIVsVO
         TS+ARHBKneTf8Kk7sXq437wwNn+WUgL1LxvSpGO0wVOMGSfNK2Yj/f+PhxcGWPTAKR+j
         aynLg34JC0EPANGT5XJ3tNjmoeX1IAGf+kQA8yetQU+QRIGNz9wFa6sFlRYkW5eR0uK5
         /JYlaL8Wa3iRHf1CNgze4zOKswWErNxgFjmDhv2AnWlR5sc49c8ISS6HfWKSHj35DoDr
         1BHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A57xIfZLi+2djoYykZ8gRv7aiC4YCwj7z7nIR/tXI5o=;
        b=FfVt3/wA7uCx620E0VMYxjg3T6+kOzeq8obTXPtMlizLdN2bBMMtMXumZyMDdRwD+K
         m5WG851RJcAine8MknicdURkTX5HE+ONmicoDAD+j5Vn2repvZL+S1Fj3W/tQgOhRTtb
         FQ/f7lNfNKOlmCE23YXsr0hOuZpiND2CrcOJaPpCSP+hUe+MSstmL0CgO0BeSziM+jON
         HKn4U9IXniYtNfgsHwR3L1JORB1bK/0eqq9zD0KSHWCZSLZX9RQ8dN+PDf+uKad94VUV
         uVW51KyGtZ8Wv7MfOW58jLiNdMO4QYKEDvY7oBfBdNYsdBNahfbTx34DHT0Q6LjymIZn
         3m6g==
X-Gm-Message-State: AJIora8pjEDBJ2FYcDQ1Ep7HbvPzAzse5gnNl8a4sdlz8nwtQJUeRT8q
        aVnIyMDNu8n7p6ee8lsXr9g=
X-Google-Smtp-Source: AGRyM1vgrGt/0CrKhkuyy0/ICHgqiirR8e9FCx4Oeo062lESI0A/ZVOBp6oq5nmMnL/qoMhd8QYcCA==
X-Received: by 2002:a05:6402:2497:b0:437:a341:9286 with SMTP id q23-20020a056402249700b00437a3419286mr38271266eda.156.1656937594290;
        Mon, 04 Jul 2022 05:26:34 -0700 (PDT)
Received: from felia.fritz.box (200116b826716b008998943ac77556e4.dip.versatel-1u1.de. [2001:16b8:2671:6b00:8998:943a:c775:56e4])
        by smtp.gmail.com with ESMTPSA id k20-20020a1709063fd400b00722f66fb36csm13974467ejj.112.2022.07.04.05.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:26:34 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 09/11] docs: ko_KR: howto: remove reference to removed submitting-drivers
Date:   Mon,  4 Jul 2022 14:25:35 +0200
Message-Id: <20220704122537.3407-10-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220704122537.3407-1-lukas.bulwahn@gmail.com>
References: <20220704122537.3407-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The document submitting-drivers.rst was deleted. This removes the
corresponding reference in the Korean translation of the howto.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 Documentation/translations/ko_KR/howto.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/ko_KR/howto.rst b/Documentation/translations/ko_KR/howto.rst
index e3cdf0c84892..e43970584ca4 100644
--- a/Documentation/translations/ko_KR/howto.rst
+++ b/Documentation/translations/ko_KR/howto.rst
@@ -124,7 +124,7 @@ mtk.manpages@gmail.com의 메인테이너에게 보낼 것을 권장한다.
     메인테이너들은 이 규칙을 따르는 패치들만을 받아들일 것이고 많은 사람들이
     그 패치가 올바른 스타일일 경우만 코드를 검토할 것이다.
 
-  :ref:`Documentation/process/submitting-patches.rst <submittingpatches>` 와 :ref:`Documentation/process/submitting-drivers.rst <submittingdrivers>`
+  :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
     이 파일들은 성공적으로 패치를 만들고 보내는 법을 다음의 내용들로
     굉장히 상세히 설명하고 있다(그러나 다음으로 한정되진 않는다).
 
-- 
2.17.1

