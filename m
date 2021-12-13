Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9409472AB1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhLMK4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:56:24 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:34168
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229695AbhLMK4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:56:23 -0500
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BBA433F1B3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639392981;
        bh=ypxj31NXOXep6r8v6xUX2SzdEwCFZerMwm+Y2YLDhFU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=EJKt8afdEpQg7NtI/fZnYsQea953hH+cbfKRXEnGj2MCvb2na0MF+Khf+CpXcS+Ir
         1xpiS2tY5+5V6SuRLdU8h2ybdrHCSf/Iw0Qrcn8iFarQPJx22awA2sDkUE8yDJv/Qg
         FNRZTqXJo6Gfo3hECATUl8O35IXjCdGMGRwmxx/JCPk6vyeY0Jlct0ZLE9lJGw0zW9
         /vplCdlDAPxF/o9OuyPXwvPjyQDEwBCDQ+ojlNP0IzA6o4K9Br/3Gszouh/skQiRIv
         bxEjFjHJZkMjYpsnGAAZg/IzvUG+ZXR6PzT3LbIHDpAzdkxnG4byGOnhRh9gzxkvbk
         nlGozX0DPzC9A==
Received: by mail-lf1-f70.google.com with SMTP id u20-20020ac24c34000000b0041fcb2ca86eso5113622lfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 02:56:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ypxj31NXOXep6r8v6xUX2SzdEwCFZerMwm+Y2YLDhFU=;
        b=zoBWPo6w5rw1oxKkzV//XM0F7Y8fnNkZNZo5dsYFzNPRyGeiX7jLPE1ogRsjVQxP+E
         GWBB1b/tZ6N9Bt1NdZMq5g90J5zk18UbFcCvGY2HvkTbFPyst1vFZf3YTeOEO45uGRKI
         ETaIckO5YI2128o82y8AhsH1ygQLV+8JiW4LMs5CaKdyeHUxsbW0pdAfPsCh+1tMUnRs
         n5IV50FCDxd/ym3LnTniJjgTv2VOhhPgYWjY2I4dN7e8cIQvEy6KeUeNjilOxWo/+c+C
         x8yhDh4O2tpJNtWWXxGBxLIgpvtnzaTs/7cEydxjGRpCvZz0pG2w0EXH7dURVcljAjhg
         jn9A==
X-Gm-Message-State: AOAM531O2RlSjBD0EKzg1S4QVAz/RQgFk99HjwqSog2YDiEGvR27NLE4
        xey3sUIp59EWM5egEajHnagc8p6E82A3yAhfdd7k45lBXCs5jqzbBh+rcIuSwvWj1yORSv2D83C
        uF1QOo5iqdtehKl5AoMb6j5ep55asgyb1P8/ofiVmuw==
X-Received: by 2002:a2e:9bd4:: with SMTP id w20mr29114893ljj.69.1639392980962;
        Mon, 13 Dec 2021 02:56:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw20XvVgW53GgrnkGRz97Uy3jjvZ4gfho8DP8Raz18xqUx07tsJ2qqJXjK/1jvbbCjvgqNDOQ==
X-Received: by 2002:a2e:9bd4:: with SMTP id w20mr29114873ljj.69.1639392980727;
        Mon, 13 Dec 2021 02:56:20 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id a24sm1407478ljd.25.2021.12.13.02.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 02:56:20 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [GIT PULL] memory: renesas drivers for v5.17
Date:   Mon, 13 Dec 2021 11:56:18 +0100
Message-Id: <20211213105618.5686-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Topic branch with Renesas related memory controller driver changes.

Best regards,
Krzysztof


The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-renesas-5.17

for you to fetch changes up to 3542de6a5b159fac0e7ca84d77a57ea99125d6b1:

  memory: renesas-rpc-if: refactor MOIIO and IOFV macros (2021-11-22 10:53:26 +0100)

----------------------------------------------------------------
Memory controller drivers for v5.17 - Renesas

Changes to the Renesas RPC-IF driver:
1. Add support for R9A07G044 / RZ/G2L.
2. Several minor fixes and improvements to the driver.

----------------------------------------------------------------
Lad Prabhakar (6):
      dt-bindings: memory: renesas,rpc-if: Add support for the R9A07G044
      dt-bindings: memory: renesas,rpc-if: Add optional interrupts property
      memory: renesas-rpc-if: Return error in case devm_ioremap_resource() fails
      memory: renesas-rpc-if: Drop usage of RPCIF_DIRMAP_SIZE macro
      memory: renesas-rpc-if: Add support for RZ/G2L
      memory: renesas-rpc-if: Silence clang warning

Wolfram Sang (3):
      memory: renesas-rpc-if: simplify register update
      memory: renesas-rpc-if: avoid use of undocumented bits
      memory: renesas-rpc-if: refactor MOIIO and IOFV macros

 .../memory-controllers/renesas,rpc-if.yaml         |  54 +++++++---
 drivers/memory/renesas-rpc-if.c                    | 109 +++++++++++++--------
 drivers/mtd/hyperbus/rpc-if.c                      |   4 +-
 drivers/spi/spi-rpc-if.c                           |   4 +-
 include/memory/renesas-rpc-if.h                    |   8 +-
 5 files changed, 122 insertions(+), 57 deletions(-)
