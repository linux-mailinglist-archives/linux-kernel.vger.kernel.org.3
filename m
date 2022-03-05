Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3501A4CE751
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 22:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbiCEV7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 16:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiCEV7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 16:59:33 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9E83D4A4;
        Sat,  5 Mar 2022 13:58:41 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id bc10so10345048qtb.5;
        Sat, 05 Mar 2022 13:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DIx9K9RJDUrDmNZanDKXxxk7CV46iR0tswozjr8hy+s=;
        b=bAc3BRu8jKiSyzaZi1EjxUBXXI7kqHegUWBiPskQcQMHtcltamHZULn+HD006kujJ8
         G+4rLgv0tTepehZ2KHvQNyzOxGQLiOFWlL7fCcp9EWg01EAiqf/2Bv/qCU+WWVQ/ILd1
         cf7eXFDQWBbjEXYXfdCryAAjuuNzV2a1gFscFdUrB0EGFtjONTUF3EDrbKUIuB1zn58s
         JH2iZEDXBcIe0R3f14rMpgMHDcqjic7F29pw4oW2heIGTOJa4DC8C2k5vuNm3ADO/xqK
         FRiQe5oTN8wWkdajt+fB1HdnUKULSSIJz1r1yrkBAjTmja8V2wuAPl/GeHIMGym284+a
         UiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DIx9K9RJDUrDmNZanDKXxxk7CV46iR0tswozjr8hy+s=;
        b=4fo4Nw4LEZn1hdVCTIH4cc2tzakB/EpPEIrFrro1xbyBMyHqITLmWosjvenb4KQT4U
         0VZbazX6SvwaXf6qameqd5oTCLt2KrFvrFQunv5y3SLuCpsMlLT6UrnXuv79Ib0bm7tg
         oxI3RkIptMWHwp4CMjtpTd0rQ0lEdZ501ELz9u3Qr8oAoEq/o3cmevJJDwGU0XmRNXmO
         Cz/jA/F7VGv7SsfUrkTNPILnlSLWderCzsp7m2jKtSsxZ9I6hgBvjxFspyAC4J1dfROj
         LhogPJk4jCssonYGbw8+CYNuu7Z2lUa5kQB78n8POe97amTHnyoLz7mginTjR1FZN48c
         xV9Q==
X-Gm-Message-State: AOAM5317rmSaphiugGbLtgvGEuCwax59BW5EVRC/maGSV+jp9IcHu7Jz
        fXcZveODPlBGuJi+RptnsM0=
X-Google-Smtp-Source: ABdhPJzfTcXCrWx9v/ZGHY5w8QSH2c4kePkdPYZEMCN9VCXy6oIwNP/X43/ccSKgjTz3tul+cmEZQw==
X-Received: by 2002:ac8:5bc2:0:b0:2de:adca:6624 with SMTP id b2-20020ac85bc2000000b002deadca6624mr4178178qtb.120.1646517520873;
        Sat, 05 Mar 2022 13:58:40 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id h188-20020a376cc5000000b00648d7e2a36bsm4230067qkc.117.2022.03.05.13.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 13:58:40 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
Cc:     robin.murphy@arm.com, linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] fix dw-mmc-rockchip rk356x clock rates
Date:   Sat,  5 Mar 2022 16:58:33 -0500
Message-Id: <20220305215835.2210388-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cc: Jaehoon Chung <jh80.chung@samsung.com>
cc: Ulf Hansson <ulf.hansson@linaro.org>
cc: Heiko Stuebner <heiko@sntech.de>
cc: linux-mmc@vger.kernel.org
cc: linux-arm-kernel@lists.infradead.org
cc: linux-rockchip@lists.infradead.org
cc: linux-kernel@vger.kernel.org

While lighting off support for the SoQuartz module, it was discoved the
dw-mmc-rockchip driver has tremendous log spam when the cd-broken flag
is enabled and no card is inserted.
The SoQuart requires the cd-broken flag as the CM4 module pinout it
follows has no card-detect pin.
These errors occur during card initialization on all rk356x chips, but
are amplified by cd-broken as the function is called multiple times each
poll cycle.

It was discovered the lowest possible clock rate the rk356x cru can
provide for the ciu clock in the default configuration is 750khz. There 
is an internal clock divider that makes the final minimum clock 375khz.
We could hardcode this, but it is possible it could change if the
default clock configuration changes.

To fix this, we must make two changes:
First, the dw-mmc core needs to be updated to allow a host driver to
save its requested minimum frequency. This is necessary as the mmc_host
struct isn't available when the host drivers initialization code is
called. The dw-mmc core can then apply the f_min later when the struct
is available.
Second, the dw-mmc-rockchip driver is extended to test the frequencies
mmc core will use during card initialization. It finds the lowest
supported frequency from the cru and saves it for later use by dw-mmc
core.


Changelog:
v3:
- add support in dw_mmc core for saving the minimum frequency (fixes
  setting f_min)
- add test for the lowest supported frequency to avoid clamping configs
  that don't have an error

v2:
- change from muting the error to attempting to fix the underlying issue
  by setting f_min in driver initialization

Peter Geis (2):
  mmc: host: dw_mmc: support setting f_min from host drivers
  mmc: host: dw-mmc-rockchip: fix handling invalid clock rates

 drivers/mmc/host/dw_mmc-rockchip.c | 27 +++++++++++++++++++++++----
 drivers/mmc/host/dw_mmc.c          |  7 ++++++-
 drivers/mmc/host/dw_mmc.h          |  2 ++
 3 files changed, 31 insertions(+), 5 deletions(-)

-- 
2.25.1

