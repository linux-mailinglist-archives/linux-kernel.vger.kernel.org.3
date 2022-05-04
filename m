Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0122151A3FE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352344AbiEDP22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiEDP2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:28:22 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A9C4474B;
        Wed,  4 May 2022 08:24:44 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso3452146wma.0;
        Wed, 04 May 2022 08:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z1nMz8AV1XcW5h20PdvGECZTKrNaeXZIC73UZ/jHwIc=;
        b=U1q/DgV8WmHyHZrPnWTw4Mo6VNO40cDt5sFdZXGGwGSxj2C10Jt3V1kH94HvOhuBhe
         Jl58Qqn39NgwpUAmANvXeQtsJy0Nax0dkVCNShi05Hy301IjRC2k1QU9QzOJ93J7EiZO
         HsFSSKIKUdY+JpyEOEWWTH+IcEJQ/GXRQhijjqvrQIm6AMRuIBYVEPz6JUQ/lYoqNYk5
         BQxzaBS+WRw0c+FGsnwAPoq0O8YrRs6DAN7DWLiZ9bP6dBetN5sSWVbKHnDuDUulaCb1
         rlMbBYlmUfyechE2jVkwe7h2dXXzNoVzOk+37N2qKKwk8S0mTzz1qGS2GyV7m6khsm1d
         W5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z1nMz8AV1XcW5h20PdvGECZTKrNaeXZIC73UZ/jHwIc=;
        b=tqPJWKQ8HuOpHQPSngtIkXGAmKUpgnI2uG1Jt08xOl4s2q2IMS6z1ACg78r8Wf1C90
         qfF17GYufrGjroYaKarnQ4toO8TP4HnSWuVMdSQSv+vCxietz+BLnObDMKLpsEsy6gWd
         cA66NJ6Q/Pq5QnoZnp4bK2aaI3IPE21GphrEFuWCzH3nccqzzAJJoHzzRWuIWEQh0BML
         WLO1DFY3JLptmrqxU3fbZS/qNXptGqlXrmOQ7EGsHXSZ9h7FJIX+C3NVkY7lmuC/GFZT
         eOZwXco6P1CpZKUNHVGo18OmbTYEPc1yUjfguVm2gdyZzvGGxO5UplkZWF7UKJgEh4Um
         tEVA==
X-Gm-Message-State: AOAM530+yj+1GGUC0ROX0MRzPJNmC/hDHYyB6wb4kXwpLUlwuUktzQ2K
        W9DhP0iKFZM3RHSdhgwECbwe9FSdsi4=
X-Google-Smtp-Source: ABdhPJy1kzYMGNLYhbuRv3y4d/PByfjuQojOI9mbcBzhZ5nvU8Rajr0jtKJHSHEkhIbjyJdnVi+45Q==
X-Received: by 2002:a05:600c:12c9:b0:394:54ab:52c5 with SMTP id v9-20020a05600c12c900b0039454ab52c5mr5415489wmd.141.1651677883397;
        Wed, 04 May 2022 08:24:43 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id s14-20020adfa28e000000b0020c5253d91csm11541041wra.104.2022.05.04.08.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 08:24:43 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Lin Meng-Bo <linmengbo0689@protonmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 0/3] Add support for Imagis IST3038B
Date:   Wed,  4 May 2022 18:24:02 +0300
Message-Id: <20220504152406.8730-1-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for Imagis IST3038B IC support, which
is a variant of Imagis IST3038 IC. It has a different register map
(labeled protocol b), but otherwise it seems to be the same IC.
It is also possible to support various other Imagis ICs using
protocol b, such as (but not limited to) IST3044B, IST3026, IST3032,
IST3026B, IST3032B. However, most of them (all except IST3044B)
use a different coordinate format, so extra effort would be needed
to support those.

Tested by Lin Meng-Bo on Samsung Galaxy Core Prime.

Cc: Lin Meng-Bo <linmengbo0689@protonmail.com>

Markuss Broks (3):
  input/touchscreen: imagis: Correct the maximum touch area value
  dt-bindings: input/touchscreen: Add compatible for IST3038B
  input/touchscreen: imagis: Add support for Imagis IST3038B

 .../input/touchscreen/imagis,ist3038c.yaml    |  1 +
 drivers/input/touchscreen/imagis.c            | 60 +++++++++++++++----
 2 files changed, 49 insertions(+), 12 deletions(-)

-- 
2.35.1

