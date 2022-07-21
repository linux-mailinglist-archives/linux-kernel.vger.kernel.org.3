Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF5D57C8E0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbiGUKYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbiGUKYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:24:53 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671102CCAF
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 03:24:52 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id z23so2364161eju.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 03:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=js2Eh3haubuIRskNzXp6VshzHcfnwwSq/J4hZwGa8l0=;
        b=pWH3L3YdrnLoQ0HNw6c8F8JSC0WIcwKfvAYAvRTvAT74zSHYLr1ppVDZP8FqZ9Pw1l
         fcKkU5OHG44EouQ0AKVRaXvR2VuJ7f+glaXIkU3gX9B5qjx9sZPMKn3WYFZ9QlgFl3Ok
         BmZRghKqPyrqxKo0p5JNilCuUV/VAQFBfOjUZZPTNT+W9jPWXeaCsUH6jBzRUZD+h8og
         0mBmEqKlZMq2O/pvlPt//VLczJVdqUMinaucnnPQL7FyNkCJcvkHzGrPdayYIll/5kA6
         sIloPUOznZkGPsiQ7hvy2T3BPLVSPHA2uqlWgiLsNOEgCG6UAxMOU+/H3toK2vFyQncZ
         Qgkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=js2Eh3haubuIRskNzXp6VshzHcfnwwSq/J4hZwGa8l0=;
        b=PkRRvtlZZHX6UOocJo2OQFnpHs710Uq5ZzO1gPqhmX+oSmT4YbCcPTg9fpWSk1g2Ws
         uVJhojvLQCdyJCQmYOFjepSsC6BbNoEsDoTagX8z+u+Mtda6+o2bEsUfejk62slFtSAA
         r4cQmYJzDbzt1g27RT2NbDSv0WBH3tTfCNRylkQwwXEZskvGs5EcF5h5x3bVEVvNb7jQ
         gW9/7U5fVllu8IFxYt2lfStunYnE+JPU4x7+b5TYgeYVoovt86dsWeEL67hgH8QnO0nd
         Cd6j+DAcdfuqobvsVaGbFyPcdcz4kQ9nq+E3tsbXhIqK65Z13N/eJSlDfHDpjkzoAG2p
         luAg==
X-Gm-Message-State: AJIora/5JRGHSjToUiDOBPL6XhU9xYIIGBoHrePQVKnUtpCtlcmyNXih
        x/gboEAN9LGyBPvo2Ge74Jk=
X-Google-Smtp-Source: AGRyM1tKJwVoGz2W4igzRFa8hiAZg6uksdGJy65ol3fYIbo2Eg2E0HyiNn+2TXrKwtPhHsYzOna3bg==
X-Received: by 2002:a17:906:a402:b0:72b:8e6e:64ea with SMTP id l2-20020a170906a40200b0072b8e6e64eamr40419195ejz.469.1658399090943;
        Thu, 21 Jul 2022 03:24:50 -0700 (PDT)
Received: from localhost (92.40.202.7.threembb.co.uk. [92.40.202.7])
        by smtp.gmail.com with ESMTPSA id j9-20020a17090623e900b006fed93bf71fsm699981ejg.18.2022.07.21.03.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 03:24:50 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, srinivas.kandagatla@linaro.org,
        bgoswami@quicinc.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH -next 0/2] ASoC: Cleanup deprecated regmap-irq functionality
Date:   Thu, 21 Jul 2022 11:25:56 +0100
Message-Id: <20220721102558.25457-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update two ASoC codec drivers to remove uses of regmap-irq type
registers, which have recently been deprecated by the "regmap-irq
cleanups and refactoring" series in linux-next.

Link: https://lore.kernel.org/lkml/20220623211420.918875-1-aidanmacdonald.0x0@gmail.com/

Aidan MacDonald (2):
  sound: soc: codecs: wcd9335: Convert irq chip to config regs
  sound: soc: codecs: wcd938x: Remove spurious type_base from irq chip

 sound/soc/codecs/wcd9335.c | 10 ++++++++--
 sound/soc/codecs/wcd938x.c |  1 -
 2 files changed, 8 insertions(+), 3 deletions(-)


base-commit: 353f7988dd8413c47718f7ca79c030b6fb62cfe5
prerequisite-patch-id: a45db1cac7537769dc10087fc61f977dc150744c
prerequisite-patch-id: cb8aa009c7bb7a6575eb05e3af65342dc8d0efa3
prerequisite-patch-id: 8d32557e53b894d1fb17250d2d0eb3673f068d37
prerequisite-patch-id: 5b293867ef81e3697892ac51b941bb53680a70dc
prerequisite-patch-id: 8138d39a4817e804141bfe8c2ad37d9c55456a40
prerequisite-patch-id: b01216129e887519d441cf556bbc75c397871773
prerequisite-patch-id: b5dcf0c0609113c2d81bc557c1fc95ef23f40811
prerequisite-patch-id: 622ca1c10e851b1889aaa567c1d2a0adf43cca44
prerequisite-patch-id: d28c5187f9bf0e43f27b2f4aa8dcf7fd91842a03
prerequisite-patch-id: d29d54b756be73304f844abeeaf9b46a5c0119d5
prerequisite-patch-id: 5d405790ae89c0831b46a359f86e94bac5a67470
prerequisite-patch-id: c90120e79acbb52ffa148bfedee1df9d35b5eced
prerequisite-patch-id: 2e35247a5cfe5a28565c9272b85fc6835011b032
-- 
2.35.1

