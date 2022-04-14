Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B88501B9E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242337AbiDNTRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243690AbiDNTRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:17:15 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935AF5576C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:14:47 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id s14so5451067plk.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OLpoNikIwKzHyxOkuuLmqnVg9l69T4aIpkTmaIZU6cI=;
        b=36P/S+TPGjuP18o4mfymROCEfJKxomfzeZgS8zhE51/8vWk21IADf9c/9tJGPRsyUW
         quaFJ74T08IZ6XsilNDIyiIi2N0yKFNspdo6lYalpBWd3EQjK4zAeO5T3rVvyzD1tN6s
         5mvciKzugNEvwPIGzaUbPrrco/Nu43QutjtEGT3busF9wGRkLl2BsYtkZ9tLwPF4OEzD
         lGkzSwQ/HvKC6JIy/Lt/t0YV8YqA1x/4QEBjmbkguV+G/1r2gHqPRPToW1aXkBZZ2utN
         S/kt0hCn0CgmfOlrZDpfgH4zc/kDpuFKumminBBjIXvTLJvpiNxRXueWmQiZAJnMuzzv
         fVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OLpoNikIwKzHyxOkuuLmqnVg9l69T4aIpkTmaIZU6cI=;
        b=5zXzfA1sKMI4puf6isxNru99vX7vmhnvISPUcv51fbMJskxZSRHOIfUXOXe5lTME9n
         OfmGHhhlvBfB3QlwR/rT8WJMoFr00CAzGt3GpLOiyu5Pwxwcf6/y3kmgFoRKW4wgwGf+
         Mgi+Evme8X8jJzlYM4XkTGt7Xb+oL0tphizGjxLRoYCYYxuyrM+z8F45VVhXYIh3NfSr
         DmszNx5P5Cr+Ciq7WWsjFCRkPzxIEqNRuKLfUouBMu2DKaKKS7DXdczUGr0v1ey+NqiB
         AevdU9kBmBMAgKX0VMUAYnxPc7jKPn9rnj1ESHxTuUWXctZDMtC1HR9Kf3ZI3F6AW+uK
         rhGA==
X-Gm-Message-State: AOAM532j7bnWml6/KHyN6tvVYxXQmOPrT3gNNRJ6gx6Xe9kTREO/NXIQ
        nKi4QCcoaPaaCrvPE/AQPiCHYMDmwEFRFw==
X-Google-Smtp-Source: ABdhPJwPtSuZ0eBGCgl7AiJMO7dVGNMmnw3CbwKeP2CO7PB8SMhgf/CJnXhWpKDI0Ntmta4j4oiy9g==
X-Received: by 2002:a17:902:e2d3:b0:158:9fcc:e0f9 with SMTP id l19-20020a170902e2d300b001589fcce0f9mr9669561plc.9.1649963687062;
        Thu, 14 Apr 2022 12:14:47 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1001:7090:5b60:6a76:138d:2646])
        by smtp.gmail.com with ESMTPSA id e12-20020a056a001a8c00b004fab88d7de8sm614148pfv.132.2022.04.14.12.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 12:14:46 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Drew Fustini <dfustini@baylibre.com>
Subject: [PATCH v2 0/2] soc: ti: wkup_m3_ipc: Add support for IO Isolation
Date:   Thu, 14 Apr 2022 12:12:48 -0700
Message-Id: <20220414191250.2969282-1-dfustini@baylibre.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI AM437x SoCs support isolation of the IOs so that control is taken
from the peripheral they are connected to and overridden by values
present in the control register for that pad. This series documents a
new property 'ti,set-io-isolation' and updates the wkup_m3_ipc driver to
inform the CM3 firmware when that property is set.

A prerequisite for this series is:
[PATCH v2 0/2] soc: ti: wkup_m3_ipc: support vtt toggle
https://lore.kernel.org/lkml/20220409211215.2529387-1-dfustini@baylibre.com/T/

Changes from v1:
- correct typo of 'ti,set-io-isolation' property
- make 'ti,set-io-isolation' only valid for 'ti,am4372-wkup-m3-ipc'

Dave Gerlach (1):
  soc: ti: wkup_m3_ipc: Add support for IO Isolation

Drew Fustini (1):
  dt-bindings: wkup-m3-ipc: Add ti,set-io-isolation property

 .../bindings/soc/ti/wkup-m3-ipc.yaml          | 79 +++++++++++++++++--
 drivers/soc/ti/wkup_m3_ipc.c                  | 14 +++-
 include/linux/wkup_m3_ipc.h                   |  1 +
 3 files changed, 87 insertions(+), 7 deletions(-)

-- 
2.32.0

