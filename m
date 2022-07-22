Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3908557E16A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 14:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbiGVMaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 08:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiGVMaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 08:30:12 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD5A626F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 05:30:08 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id t3so5703714edd.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 05:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zh7X5Uda6egpjw+fh4SnYbKXp8IFNuJykfc8eOEqRcY=;
        b=oJJbA0UIQDRXkXqxroc0ESaeLjykv5Hz8mdjOy7mQTVNVeHBiL16d+C1Tqddf8l4be
         rrBWUhDXEF6hudZbp3Q4OwuUqGx4GtTYIptvgB+2bYbzvcfhMVXTV/jO+/R5LaSqYvy8
         xVkvnuqtJDQfE1amhM8+BZRKepDGwiDVKz4fM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zh7X5Uda6egpjw+fh4SnYbKXp8IFNuJykfc8eOEqRcY=;
        b=I8ItOnp/3XuKphPibaHtEVWwdLfsIacfPoCTYMMOEAJbugX0pcdNQGLWVP8ftWKWT6
         IrFUVVXr5p+oAx7qdF6a51imQEVrNdbhG2EYs+00+Wev5NDCV+Baxhz5eSmLqmsSOIsZ
         BfIQ6xaXFIFhEozyeKaA8hcXxoTQG8+7g8bcFnpe7sEQk2mxNcuTkYQCDztcj72CjcZ0
         UMiaFtvkGLmpwZzm2Rlc/ZmUOhfR9eQAmHCIn/1mTJoEGodx+bTw9eBu9GHWkL9+Inve
         kPccdsE2OCZvQF/Ga610iS7a6KDGNv3XsFWeKwG9Bszb1Idj3HhLM8QuxjSJu5pbFauS
         FuFw==
X-Gm-Message-State: AJIora9TyS65IJwAMNeQicfgYaUvsuvytq26jrJl+ZGVWWKkG8bndNwu
        15Tkqbg6sevamRz6zld4VTK+rw==
X-Google-Smtp-Source: AGRyM1ux80QqQUW+EIA/65Ein87S3N52C0FoamGrt7MvX+qr5lpBaUeLzY66cSjKh/GK9bob3xmuBA==
X-Received: by 2002:a05:6402:1d4a:b0:43a:ca49:abc6 with SMTP id dz10-20020a0564021d4a00b0043aca49abc6mr418056edb.376.1658493006349;
        Fri, 22 Jul 2022 05:30:06 -0700 (PDT)
Received: from localhost.localdomain (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id f6-20020a05640214c600b0043a6df72c11sm2462432edx.63.2022.07.22.05.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 05:30:05 -0700 (PDT)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH -next 0/2] brcmfmac: AP STA concurrency patches from Cypress/Infineon
Date:   Fri, 22 Jul 2022 14:29:53 +0200
Message-Id: <20220722122956.841786-1-alvin@pqrs.dk>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

We are using these two patches from Infineon (formerly Cypress) to
enable AP+STA mode on our CYW89359-based platform. They come from the
FMAC driver release package distributed by Infineon.

The key thing here is that apsta needs to be set to 1 in order for AP
mode to work concurrently with STA mode. I cannot speak for other
chipsets so a review from the Broadcom side would be welcome here.

For the ARP/ND offload being disabled in AP mode, I am of the view that
this is correct, but while Arend has given his Reviewed-by on it
previously, it was part of a different series [1], so I am sending
without in order to jog some memories.

[1] https://lore.kernel.org/linux-wireless/20201020022812.37064-3-wright.feng@cypress.com/#t

Soontak Lee (1):
  brcmfmac: Support multiple AP interfaces and fix STA disconnection
    issue

Ting-Ying Li (1):
  brcmfmac: don't allow arp/nd offload to be enabled if ap mode exists

 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 65 +++++++++++++++----
 .../broadcom/brcm80211/brcmfmac/cfg80211.h    |  2 +
 .../broadcom/brcm80211/brcmfmac/common.c      |  5 ++
 .../broadcom/brcm80211/brcmfmac/core.c        |  5 ++
 4 files changed, 66 insertions(+), 11 deletions(-)

-- 
2.37.0

