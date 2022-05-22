Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FE4530580
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 21:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350246AbiEVTsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 15:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiEVTso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 15:48:44 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB23938BD9
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 12:48:41 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id en5so16732970edb.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 12:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=cal+UUAdqVRtgFFdWFWVka7hHFm8ijtTTm++T222BFc=;
        b=PMNdlQIFLJ94dGRdMrBfjNoJp3MEHek6CcUoZedEt2akvfGYLWYS1bmW+4RB4Dj3zK
         8Uo40MQcuprhAyobBAbz+omBb6pKvt13IEINVCBvvPGvU6cdjgKEtQZ6d7o9u2DPUKAI
         3Psje1kimgnZmywyyojgFyt8pmIFkXdr6Vj1XUCp+4KRZsjY/BZLgXsAgo8aeV20AGlH
         cySgh8yCsnrFtFoMuRKEmX6C0SaBaxUd5ClD1dMbqABAor0EW6VjtEAyoyRCz/0rgWM2
         3wlGwyLh7DYwdj69JBd9vBq1nQtvgs7BNXwEqOXNekYogSsyrrNTEsnqiuMR3RuuLI6r
         2J9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=cal+UUAdqVRtgFFdWFWVka7hHFm8ijtTTm++T222BFc=;
        b=YVMSMpQDvymH966ce/41Ofc4klsZHFgry2Cehbq8YMHXBwa4sPxQf5Cr6GzTKn2qPu
         wF5BQsAV/oiXpOqt41n8mgr0rpHBG7ldkogOzgDBno63qK3d5RXi7fEsUAbcooyrVE73
         ks2WsHvgG2jVNoXIm9uuA/aDavA1sH+LBGGuyvc9jhSTvcvQylXJVZcEyfj9DlgPELBf
         EMfpLjAMh6gtKuGKezPP96mXlFnSDrBye0FYQyGWeCp+34zS6xtzctg9PyE+QmOFyTvV
         FvMK72hiONDypva/ZGUKwwpuRKVCdXC3mkVY3pC+wYAMgz1gO/hSU15YKpuJhDy4wtGB
         5+YA==
X-Gm-Message-State: AOAM532j2O3PVB7Jm0OuCYxo9cXHpHmxm571j4yyG2Xka3Clh+ZQrgnc
        cQO7JP4S+L5YPogY2hCRd60=
X-Google-Smtp-Source: ABdhPJzC1qddUXh8u05N5xaK7gedpL0zcp0K8nAyFx2iPrKRYNTQhFpTHHUmrH9XRMPAPX1kbVV01A==
X-Received: by 2002:a05:6402:1399:b0:410:9fa2:60d6 with SMTP id b25-20020a056402139900b004109fa260d6mr20654315edv.35.1653248920381;
        Sun, 22 May 2022 12:48:40 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935774.dip0.t-ipconnect.de. [87.147.87.116])
        by smtp.gmail.com with ESMTPSA id g20-20020a056402181400b0042ab9da73e6sm7340682edy.94.2022.05.22.12.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 12:48:39 -0700 (PDT)
Date:   Sun, 22 May 2022 21:48:37 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] staging: vt6655: Replace macro VNSvOutPortW,D with
 iowrite16,32()
Message-ID: <cover.1653203927.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace macro VNSvOutPortW with iowrite16.
Replace macro VNSvOutPortD with iowrite32.
The name of macros and the arguments use CamelCase which
is not accepted by checkpatch.pl

Add missing big-endian support on 2x iowrite32.

Tested with vt6655 on mini PCI Module
Transferred this patch over wlan connection of vt6655

Philipp Hortmann (11):
  staging: vt6655: Replace MACvSetCurrBCNLength with VNSvOutPortW
  staging: vt6655: Replace VNSvOutPortW with iowrite16
  staging: vt6655: Replace MACvWriteISR with VNSvOutPortD
  staging: vt6655: Replace MACvIntEnable with VNSvOutPortD
  staging: vt6655: Replace MACvIntDisable with VNSvOutPortD
  staging: vt6655: Replace MACvSetCurrBCNTxDescAddr with VNSvOutPortD
  staging: vt6655: Replace MACvRx0PerPktMode with VNSvOutPortD
  staging: vt6655: Replace MACvRx1PerPktMode with VNSvOutPortD
  staging: vt6655: Replace VNSvOutPortD with iowrite32
  staging: vt6655: Add missing BE support on 2x iowrite32
  staging: vt6655: Delete upc.h

 drivers/staging/vt6655/baseband.c    |  2 +-
 drivers/staging/vt6655/card.c        | 67 ++++++++++++----------------
 drivers/staging/vt6655/device_main.c | 28 +++++-------
 drivers/staging/vt6655/mac.c         |  2 +-
 drivers/staging/vt6655/mac.h         | 57 +++++++----------------
 drivers/staging/vt6655/power.c       |  4 +-
 drivers/staging/vt6655/rf.c          |  4 +-
 drivers/staging/vt6655/rxtx.c        |  4 +-
 drivers/staging/vt6655/srom.c        |  2 +-
 drivers/staging/vt6655/upc.h         | 35 ---------------
 10 files changed, 66 insertions(+), 139 deletions(-)
 delete mode 100644 drivers/staging/vt6655/upc.h

-- 
2.25.1

