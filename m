Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B689248AC4C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 12:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238652AbiAKLWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 06:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238045AbiAKLWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 06:22:50 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05780C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 03:22:49 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id l16-20020a17090a409000b001b2e9628c9cso5234594pjg.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 03:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o3RGIjUh3zkO2TSrEh9ANB63AzKRIvsxnYvzUQhlL+o=;
        b=Y80ZsRuSH0nHMEuCQfy5g+v40fpq3LOUz5/ICaGJahs4F6d7BAGPybV22cQRHOcYPx
         xRpvG/MnkTRUy3brFfZewsw3Hh0jlKLdyZ7xdPFoAqBzzMQKO+rbS7hBxqQj9qMRT7+u
         TkTEyuHdR5L1A3WSaQcxv2/b1Hf6vutNMLgoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o3RGIjUh3zkO2TSrEh9ANB63AzKRIvsxnYvzUQhlL+o=;
        b=khoa3ArYiZepEJI5z53uAAgA29gyfdQT6gt9YWv3x+vduxyG0gVNcqaYcFqVLTDehu
         FNus4dU0dzPT+7TmQy+CQ9xfmHm5j7Oxb9IW8ZeKN0ccTTF4qiDbdn1VY7jl0gA+WkTT
         KuMic8stKOVc6oTnSvmxqcs4Ud3RAPeUFtwPrtlepGYuV+zoaM0MJSD+2U/2D/+1iydP
         lNAvvb1/HFYz8gGtEJwrApLvQ1E6uoQuxcOOI3vg/Uzo9KDUJ3DfMn7x/NK1ljq1ZkGf
         BJN+0yoqFkLQEQjw2o76xp5EEx16r2gi2Eu9imJJYfKi1e34fiPD/O7YkDyvmqQCOVHk
         +Nfw==
X-Gm-Message-State: AOAM533d++SwUL+HFqZabdCAn+0C3amBi8ZcK8Uc5qawErlSSRW86gWK
        g/4CFTshnzB95HnAfZLaiU3vvA==
X-Google-Smtp-Source: ABdhPJxyb6khCxx8QJ4wZdF/qzdXMCwXXuWyr+5j5JU9u6njT4vwx0W1aH0tkLphD00UBXSQl+BSiw==
X-Received: by 2002:a17:902:b58c:b0:149:57d2:3165 with SMTP id a12-20020a170902b58c00b0014957d23165mr3791864pls.29.1641900169486;
        Tue, 11 Jan 2022 03:22:49 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:e7ee:1824:8575:bc5c])
        by smtp.gmail.com with ESMTPSA id f9sm2053845pjh.18.2022.01.11.03.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 03:22:49 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Guodong Liu <guodong.liu@mediatek.com>
Subject: [PATCH 0/7] pinctrl: mediatek: Fixes and minor improvements
Date:   Tue, 11 Jan 2022 19:22:37 +0800
Message-Id: <20220111112244.1483783-1-wenst@chromium.org>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

Here are some fixes and minor improvements to generic pinconf and the
Mediatek Paris pinctrl driver.

Patch 1 makes the generic pinconf library print out arguments for
PIN_CONFIG_BIAS_PULL_* in debugfs.

Patch 2 fixes bogus readback of PIN_CONFIG_BIAS_DISABLE being always
present.

Patch 3 fixes the type of the "argument" argument in mtk_pinconf_get().
This was erroneously typed as an enum when it should have been u32.

Patch 4 fixes the pingroup config state readback to actually do
readback.

Patch 5 drops an extra newline in the pinconf debugfs output.

Patch 6 cleans up the debugfs output, skipping the custom hardware state
output on the virtual GPIOs, which have no corresponding hardware.

Patch 7 adds support for PIN_CONFIG_DRIVE_STRENGTH_UA (drive-strength-uA)
to the Mediatek Paris pinctrl library. The goal is to replace the vendor
specific "mtk,drive-strength-adv" property with the generic one.

Later on we might want to deprecate "mtk,drive-strength-adv".

Please have a look.


Regards
ChenYu


Chen-Yu Tsai (7):
  pinctrl: pinconf-generic: Print arguments for bias-pull-*
  pinctrl: mediatek: paris: Fix PIN_CONFIG_BIAS_DISABLE readback
  pinctrl: mediatek: paris: Fix "argument" argument type for
    mtk_pinconf_get()
  pinctrl: mediatek: paris: Fix pingroup pin config state readback
  pinctrl: mediatek: paris: Drop extra newline in
    mtk_pctrl_show_one_pin()
  pinctrl: mediatek: paris: Skip custom extra pin config dump for vrtual
    GPIOs
  pinctrl: mediatek: paris: Support generic PIN_CONFIG_DRIVE_STRENGTH_UA

 drivers/pinctrl/mediatek/pinctrl-paris.c | 106 ++++++++++++++++++++---
 drivers/pinctrl/pinconf-generic.c        |   6 +-
 2 files changed, 98 insertions(+), 14 deletions(-)

-- 
2.34.1.575.g55b058a8bb-goog

