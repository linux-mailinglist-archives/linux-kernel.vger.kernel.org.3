Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E5A4CF381
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 09:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbiCGI04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 03:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiCGI0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 03:26:53 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193B460AB8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 00:25:59 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DBD7C3F614
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 08:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646641557;
        bh=4WIPZDs1A+/ztSWSMIGd9RnjoSgJeXHblH2bIob06Us=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=BEs9Ctn9PdO9AMWnHl8aa3x2zZ7m6g4akw7eaDUpfXk95ewtSv8sfTL5yc9pFF9o4
         lC1718cP5MEO2Zt5KMgfyGjygL36Gl2+Fxu6fU02uTyQUkwKjhEGDyJryosGsS/tzo
         XVV+ibMOvDn3t2ksbesTK34omnJO0lMWZRy51h4eMAmdT0YtYrup9fO2WOOyhuquJA
         giBaDuZZQvpMFdSmqWLgRsZc+llISk7xfcZQ2SphBH7Iq/NIOASK50wDr1Yx+SRNtK
         nzRFfi3X5bu6eg9WAy0JexA2gxiZQVaQ54Eip/M+eU/eP3m3rMsJEWob9VKhGh1g8x
         iaB8nn3GsUoPA==
Received: by mail-ed1-f71.google.com with SMTP id h17-20020a05640250d100b004133863d836so8203086edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 00:25:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4WIPZDs1A+/ztSWSMIGd9RnjoSgJeXHblH2bIob06Us=;
        b=t21djC/qQL3Xh4XLHfdLufVT2sBon+iQ2YTwZRpvZcCN3MzutBMmyS5Dixli72RtLR
         AApctsyVcYmT9AJBegwBWL/axGGop5ybj0G86cKj6S96Xfcn7rMnO0WfpfhWmNLUJa9A
         sPM6OZ7bbY5KpcG0qQnlcXRKxpHRc2rTzr+5ZvSYeKmF3r8YCxwvNRd1VSgumBAabCqJ
         3H1G7/7YjqXOclo8fsbDU2ctnXbbscKSWaGmK57w669zl+osZH/MUV4jQVpRiwlVBbz3
         Yc76cpx4Livqg519W9iwGqApU1nC7HANsRfVr3nMQXcdplZ+VgmKHNedUbmu59rWKhQi
         iVXQ==
X-Gm-Message-State: AOAM530xXCyPC/DZReyG5ypzpPg1Ch+Ps5b3P7whErIsNd+OWwi4yN0P
        N6usp5Ix1AB2WLYWbqUSmaB7pIhFePOgxS54dQV0TlNlk/JIucbNmWumkvM7ecKEOdnXWmv4xy8
        p5IfC21Tzs4uOUGWCuIl4vblvJK7g5StgnX0wwD0rkQ==
X-Received: by 2002:a17:907:1b20:b0:6da:649b:d99e with SMTP id mp32-20020a1709071b2000b006da649bd99emr8063231ejc.712.1646641557282;
        Mon, 07 Mar 2022 00:25:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw3PnjZMFJvegI51mXQwwX0sRYgYwW8EY4J4ZgrQfsyrHK1k4RLdJcsXQGEpnSPKZJdgRK8AA==
X-Received: by 2002:a17:907:1b20:b0:6da:649b:d99e with SMTP id mp32-20020a1709071b2000b006da649bd99emr8063220ejc.712.1646641557106;
        Mon, 07 Mar 2022 00:25:57 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id qp3-20020a170907206300b006da96b87e9csm4207080ejb.181.2022.03.07.00.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 00:25:56 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] memory: drivers for v5.18, part two, late
Date:   Mon,  7 Mar 2022 09:25:52 +0100
Message-Id: <20220307082552.55719-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Late minor fixes for v5.18 memory drivers. On top of previous pull
(tags/memory-controller-drv, soc branch: memory/drivers).

If these are too late, please consider it also for fixes after merge window.
These are not typical merge-window fixes though (issues existed for long time).

Best regards,
Krzysztof

The following changes since commit a06bf59d07f45a0a6ab4ab8ac69c1d708d3fadcb:

  memory: Update of_memory lpddr2 revision-id binding (2022-02-25 13:36:49 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-5.18-2

for you to fetch changes up to 69d6941949ea8a113ffc89410b0cb79bc7b35a0b:

  dt-bindings: memory: renesas,rpc-if: Document RZ/V2L SoC (2022-03-04 09:09:52 +0100)

----------------------------------------------------------------
Memory controller drivers for v5.18, part two

1. TI: Two fixes for TI EMIF driver for quite old error path issues (so
   for unlikely scenarios).
2. Renesas: Document RZ/V2L SoC in bindings.

----------------------------------------------------------------
Jia-Ju Bai (1):
      memory: emif: check the pointer temp in get_device_details()

Jiasheng Jiang (1):
      memory: emif: Add check for setup_interrupts

Lad Prabhakar (1):
      dt-bindings: memory: renesas,rpc-if: Document RZ/V2L SoC

 .../devicetree/bindings/memory-controllers/renesas,rpc-if.yaml    | 3 ++-
 drivers/memory/emif.c                                             | 8 +++++---
 2 files changed, 7 insertions(+), 4 deletions(-)
