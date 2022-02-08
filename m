Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183034ACDDD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345798AbiBHBL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbiBHBAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 20:00:42 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF582C061355;
        Mon,  7 Feb 2022 17:00:40 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id og43so23227193ejc.0;
        Mon, 07 Feb 2022 17:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vOsFYs8M1ICwGJG7PLwZ9dqci40OC3z1WYDbknJ2Ydw=;
        b=L685HJqIZwer95uTAt0qz3Gviz5M9rYSeXPrEPQiBf8DIudPbCUojjRXI6Lil0kGnh
         vXHo4247ZDV9YMag0Xk4Gy9Ze4nwbq5+6BfyX1NChdqYaeuQ3NNlTtIAftbThrICQJhk
         HCdxvzMjFxv7ICgC5RRXmqZtTb+bQ/rpgR4NJJu2FyqxSQoUT6RnS7mhFJaabdAaTAFB
         tAePAVDwJgnrA8LdAd5oqmQitezdyxksenRfoCjoSGdb9a4pdKHT554uiHmkW2KhvEmG
         Ki7CrIRV+zUjlo1IDkqAOzkkuLCz6zJJUGPJoheChWMdUoPNJbVUPO22iQAwKvDOUcKg
         0+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vOsFYs8M1ICwGJG7PLwZ9dqci40OC3z1WYDbknJ2Ydw=;
        b=ajoKIjncx/+79CAXF7qvJGordnpKbZrR69FqzAVsEjssHyLy8aOQXQa7x5OKTpaW3b
         AUH0gClSY5qZZ53oQzTt/+vWnjG6a3JxAOnkZzQpRGTQaTGUiAvfpSOikQ2J7mheDIb6
         1ovxlb7Axd2Jys+99Ypd/2e6G9YTEz9p+RnmWrT8AS24kfzqE1uBcE121ady5TFYqEPG
         VT4x326shvKvfNV9CLi4tZ3hZ2GWw7TOQ2rEL9CEyg/BlNHX+gbclkqxOK/1k9ViMslJ
         ojWnjX8v+1ATTAPp8M3aUqV/9Cr0g8zTOt6pU1DmbKuLlMvWFQzKTTMZpIzzpVUdZUd6
         qTxw==
X-Gm-Message-State: AOAM533h9p24gCmXgymQxXGtIPHaImksHyUYnFgBTyrH2qsvnnTRXtOs
        G0Jn2arPKHbCE3622cq5fu8=
X-Google-Smtp-Source: ABdhPJxrxooHH091K6iGi4dvPy4w5KUFYEWQFCftHnHSy7c7G5XkfuBJD/RYTmmBz6dFelAFXkYEHQ==
X-Received: by 2002:a17:906:3e49:: with SMTP id t9mr1707493eji.683.1644282039253;
        Mon, 07 Feb 2022 17:00:39 -0800 (PST)
Received: from localhost (92.40.202.227.threembb.co.uk. [92.40.202.227])
        by smtp.gmail.com with ESMTPSA id p19sm4197644ejc.42.2022.02.07.17.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 17:00:38 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Clock fixes for Ingenic SoCs
Date:   Tue,  8 Feb 2022 01:00:45 +0000
Message-Id: <20220208010048.211691-1-aidanmacdonald.0x0@gmail.com>
X-Mailer: git-send-email 2.34.1
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

I ran across a problem trying to get Linux running on an Ingenic X1000 SoC:
since the memory clock isn't referenced by any driver, it appears unused and
gets disabled automatically. After that, the system hangs on any RAM access.

There is a hack in board-ingenic.c to forcibly enable the CPU clock, but this
is insufficient for the X1000 since the memory clock has its own gate and mux
that isn't tied to the CPU.

This patch series fixes the bug by adding CLK_IS_CRITICAL flags to important
clocks, which seems to be the approach used in many other SoC clock drivers.

It's my first time submitting patches to the kernel so let me know if I
messed anything up.

Aidan MacDonald (3):
  clk: ingenic: Allow specifying common clock flags
  clk: ingenic: Mark critical clocks in Ingenic SoCs
  mips: ingenic: Do not manually reference the CPU clock

 arch/mips/generic/board-ingenic.c | 26 --------------------------
 drivers/clk/ingenic/cgu.c         |  2 +-
 drivers/clk/ingenic/cgu.h         |  3 +++
 drivers/clk/ingenic/jz4725b-cgu.c |  2 ++
 drivers/clk/ingenic/jz4740-cgu.c  |  2 ++
 drivers/clk/ingenic/jz4760-cgu.c  |  2 ++
 drivers/clk/ingenic/jz4770-cgu.c  |  1 +
 drivers/clk/ingenic/jz4780-cgu.c  |  3 +++
 drivers/clk/ingenic/x1000-cgu.c   |  3 +++
 drivers/clk/ingenic/x1830-cgu.c   |  3 +++
 10 files changed, 20 insertions(+), 27 deletions(-)

-- 
2.34.1

