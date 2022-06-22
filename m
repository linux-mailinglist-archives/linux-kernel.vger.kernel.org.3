Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B0755538A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 20:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377018AbiFVStU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 14:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376899AbiFVStP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 14:49:15 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8696A31925;
        Wed, 22 Jun 2022 11:49:12 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i10so20923749wrc.0;
        Wed, 22 Jun 2022 11:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PRt21XGDrOQmvCWAO1/+rp6bkBghl2OkkGlvxy40ZeQ=;
        b=MaylSmk4Ls7iH07YR1di4/Vxb2bhaasS6XPolJn8RtYFIUfzOW86+rFC5Q/ImrNLjK
         PjsBNJDIQXAze6d71FYEIOTgDmSHzUxBdHSgvZvjl6I+3jtUdW85qGA7h7fHKGN2Oj2R
         v7wa794oTyARQKIITO/B2/rZLUJwvQesKSnAnRPblUBadPnK3v0lFRRBK6lFd+lKpy2g
         gCxNiIAq3qWw71jdO+yhLj0FhgIuIaU7GPNZpTH4sOMwSP0foB0sTCa+8rw+/xBL6OfD
         WmWA7DVwxmVBsInIkUVk6HoaDGmOIsiO4qcRndCdmCxl1Nq0koo4rlraCPODW1DQd5ZG
         cHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PRt21XGDrOQmvCWAO1/+rp6bkBghl2OkkGlvxy40ZeQ=;
        b=QhXAc9qz7BluyhB9A3MIfUpLoCf6BpoK1a/fsxpQc6Bfv4XLu7KkLndsJNm3EFHmOG
         x3dvSwUs3ouTB9BW3SKbhX+oEuHtj8c5f2wFURwQk1uweCHwasR2YuLum8/Ucu6o8ra5
         Gl+IUdSQPCL0Ey475E0E/y1BAg/zBEufvan22xmiQ4n1x/qP/bfu4QAA3xPnitMgwKO/
         PMYBM4ZN8ocYxDZy/4kz0RV/wkiKP0LSttsPg5388UXllYhX/Pxs4AJFo8Qu4lR1pB00
         AgTn5nAPcAMfPAlbDv1PZecuGJLiPZwEG+NkzTaOl6wF7+iIEtfxwH+XcSOEG4adnkgy
         kHWQ==
X-Gm-Message-State: AJIora9zCCKlYYtXis3HqT+gSdM0J//6jZQMpjogIGKLCmWuZTDIYsjl
        2r1eJN9gU975vWHyhATXroA=
X-Google-Smtp-Source: AGRyM1sQYdQ36ov+1FAxWsDg8Y70mC3Dx1oAb0UW7Wz+GFn6MeWwpltQVD4ByWu87R5OShMulhiA9Q==
X-Received: by 2002:adf:fb43:0:b0:21a:22eb:da43 with SMTP id c3-20020adffb43000000b0021a22ebda43mr4591639wrs.347.1655923751050;
        Wed, 22 Jun 2022 11:49:11 -0700 (PDT)
Received: from localhost (92.40.170.233.threembb.co.uk. [92.40.170.233])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c461300b0039db7f1a3f5sm188332wmo.45.2022.06.22.11.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 11:49:10 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org
Cc:     paul@crapouillou.net, maz@kernel.org, andy.shevchenko@gmail.com,
        linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] pinctrl: ingenic: Convert to immutable irq chip
Date:   Wed, 22 Jun 2022 19:50:08 +0100
Message-Id: <20220622185010.2022515-1-aidanmacdonald.0x0@gmail.com>
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

Two cleanup patches for pinctrl-ingenic.

v3:
* Put includes into alphabetical order.

v2:
* Add print_chip callback to avoid changing /proc/interrupts output
* Add patch to use irqd_to_hwirq()

Aidan MacDonald (2):
  pinctrl: ingenic: Use irqd_to_hwirq()
  pinctrl: ingenic: Convert to immutable irq chip

 drivers/pinctrl/pinctrl-ingenic.c | 64 +++++++++++++++++++------------
 1 file changed, 40 insertions(+), 24 deletions(-)

-- 
2.35.1

