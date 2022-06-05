Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5551E53DD44
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 19:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351361AbiFERDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 13:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238415AbiFERDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 13:03:07 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A308B36B61
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 10:03:05 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id q21so24904811ejm.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 10:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N5b25hqu/oE4geFfetpQJ/jX/t8e9orYohIiTzR/6iw=;
        b=VxlXBXJjqQHn1Fbpgcto9a0Mxhp6Yn8ZBIuuBEInS/ODX1BE5qJbw97CjE6yI3osnA
         frIQSMZ0qRiVr4xaEBoTPbGkhHhO3JbcVMiBMD4SfPxKxhTDc5Q7k4GJ7aVB/bYwtGrR
         rqsCP8mZIYjT55X0Ip37pPgpsSK0ZIq1zv8WU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N5b25hqu/oE4geFfetpQJ/jX/t8e9orYohIiTzR/6iw=;
        b=m5asTOyxgyGo690pHFvj6SeNoLrAlAZnS5CDCKJ93Po+qNvgi6Myxrs7B+DJtMXFHy
         f7XGukAyHWZtQmCI5K8POIZ8ZfXhfrIN9bwA3f4vAD8gklGXkk4yvVRIjXN5yl97z17N
         a0le5amreLGBWEWiCkDGN6V0yqpJ6ffPlZh+HXdjwG9dnUBYY+VpLqKxn5CGjCMue6Fb
         zlo8iSrWkCO0F3RUshITeVcmdqDG8VEHX+z0kvOCy5MD9xWXnTAmy/YiZKwQUnZU5eww
         Dbo2UfVCiqfuygSkbzhr03UEbKEkgtA1lU2M6Tl+V8f7nxxEz9iU+iRmk+t93qvBoIc8
         YAYw==
X-Gm-Message-State: AOAM533O6d4VrGKI5vetTksblDjoYpsdUhZfejjZAmLc/3VlN38LbDJv
        2ExZgpznew3hTHDHyg1gYScYiQ==
X-Google-Smtp-Source: ABdhPJxQmBnXBPiPE2vOpdCYH20kp4YSwXcbJcRi5YwGvKE7otoXWpFgoCCemnx0wc86ZDPK4mTc3w==
X-Received: by 2002:a17:907:1689:b0:6fe:fcf4:128e with SMTP id hc9-20020a170907168900b006fefcf4128emr18390079ejc.446.1654448584176;
        Sun, 05 Jun 2022 10:03:04 -0700 (PDT)
Received: from localhost.localdomain (mob-83-225-9-201.net.vodafone.it. [83.225.9.201])
        by smtp.gmail.com with ESMTPSA id h22-20020aa7c616000000b0042ab2127051sm6948204edq.64.2022.06.05.10.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 10:03:03 -0700 (PDT)
From:   Michael Trimarchi <michael@amarulasolutions.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com
Subject: [RFC PATCH 0/3] Enable clk-critical to bd718x7
Date:   Sun,  5 Jun 2022 19:02:59 +0200
Message-Id: <20220605170300.1565632-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx8mn cpu smms2 module is clocked by the pmic that provides
clk32K. If the pmic clk driver is loaded the device can not boot. This
series try to make this configuration possible. We mark the
pmic clock as critical.

Open question:
clock-critical is not documentated as dts properties and could be
clock-critical can be changed as no-int one.
This is a follow up of [1]

[1] https://lore.kernel.org/linux-devicetree/20220604183905.1025201-1-michael@amarulasolutions.com/T/#u

Michael Trimarchi (3):
  clk: bd718x7: Clean up the code, no functional changes
  clk: bd718x7: Enable the possibility to mark the clock as critical
  arm64: dts: imx8mn-bsh-smm-s2/pro: Add pmic clock connection

 .../freescale/imx8mn-bsh-smm-s2-common.dtsi   |  5 ++++
 drivers/clk/clk-bd718x7.c                     | 23 +++++++++++--------
 2 files changed, 19 insertions(+), 9 deletions(-)

-- 
2.25.1

