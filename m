Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7160C521EDE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345857AbiEJPhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345837AbiEJPhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:37:09 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500052DB
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:33:11 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t11-20020a17090ad50b00b001d95bf21996so2327580pju.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xJ1k9EA/+UNXzelEfz5rFqh3v1klZbFy5zSffXSzp80=;
        b=PTDPu+0KKykd2FPVJTIXDso5T7TGfhUaukX+OcOvJ19CTh2naLi+X2R1Xy/i/zzQ7H
         Tj1//nuXPdiYjbU8j496ocJuWP0aQOEr0L0c3Z81Zwr8UGIOwh/Os/uQ1uxYGGn763Hi
         bAREukfFWUH4RYbRdHU8MBxTyzXq1GwDG1h3swrDRU+ZTCC2E4sdljBBYICAQ+8S4WO9
         86yYv0seNUKXFZNRngJnL0GW9MJiQGUv8BZHdf5mXcjuaT8zW/iPavwfWI4xrAklxN3b
         i/mrBVpV6cX5i1EWr7rkx8peC2PqD8l4A/X2JqPxONICetxdx0mAnPHREYqsA+2fCit3
         Jn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xJ1k9EA/+UNXzelEfz5rFqh3v1klZbFy5zSffXSzp80=;
        b=zUMXf2XQifS3ggm6jp+FNADDC6bjzn6I4wPivH0d7+Rcl+kFCn6u3iZfQSedq6BYNO
         HqDQpy8Z/HddE0H5PTgR/o3fdbF2HysjcIOcXBAO+IXbdFTVMinmIC/njMzr3Zf5bqxm
         gRPghQXw2pyEJhB5lrh8U6a728IV3M3M+IyH1NEijupHmVZR3eg+3g+FFzIDJyWpSEVZ
         8CkG/PoWx43nIBh1fR2TjmWQjZnjYoEsUbnTP2L19FL8D96+cAW2N879LQUTUQFxxa07
         gjtRJHKaTRhQOoEkOp2UGtZ8yurGQoRSF6EbP5IrOJCt/uP5k88AP1Wn4vkD8rcNldk2
         VEBw==
X-Gm-Message-State: AOAM530GMtH+42yDHIWWCkhud3BGLsPdotR/8Wf4ZatuZy+2SNeYxYWj
        qj41Or9PKeUDbNaZlmFMKQ==
X-Google-Smtp-Source: ABdhPJz4gMh3dWEt+3+7fdc6o8dDMll05DHzp4cZDTjY7RzE3YMoSXSmSUc7p8a58rKvteYkM3EeLg==
X-Received: by 2002:a17:902:7594:b0:15e:bbac:8d49 with SMTP id j20-20020a170902759400b0015ebbac8d49mr20928350pll.124.1652196790823;
        Tue, 10 May 2022 08:33:10 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id cd10-20020a056a00420a00b0050dc76281d0sm11104248pfb.170.2022.05.10.08.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:33:10 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     james.schulman@cirrus.com, david.rhodes@cirrus.com,
        tanureal@opensource.cirrus.com, rf@opensource.cirrus.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, oder_chiou@realtek.com
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH 0/6] ASOC: Fix the error handling code of the probe
Date:   Tue, 10 May 2022 23:32:45 +0800
Message-Id: <20220510153251.1741210-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
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

These drivers mishandle the regulator resource in the probe function,
failing to disable the regulator for probing failure.

Zheyu Ma (6):
  ASoC: cs42l52: Fix the error handling of cs42l56_i2c_probe()
  ASoC: cs35l36: Fix the error handling of cs35l36_i2c_probe()
  ASoC: rt5645: Fix the error handling of rt5645_i2c_probe()
  ASoC: tas571x: Fix the error handling of tas571x_i2c_probe()
  ASoC: tas6424: Fix the error handling of tas6424_i2c_probe()
  ASoC: wm8903: Fix the error handling of wm8903_i2c_probe()

 sound/soc/codecs/cs35l36.c | 2 +-
 sound/soc/codecs/cs42l56.c | 2 +-
 sound/soc/codecs/rt5645.c  | 4 ++--
 sound/soc/codecs/tas571x.c | 6 ++++--
 sound/soc/codecs/tas6424.c | 8 ++++++--
 sound/soc/codecs/wm8903.c  | 2 +-
 6 files changed, 15 insertions(+), 9 deletions(-)

-- 
2.25.1

