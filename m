Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E585767B5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 21:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiGOTrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 15:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiGOTrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 15:47:42 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BC77CB58;
        Fri, 15 Jul 2022 12:47:41 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id w7so4023198ply.12;
        Fri, 15 Jul 2022 12:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y68CIXXs3ukywQOQXM62GtoaSLAuCT5qgkpdsQVVlwU=;
        b=pupEMAIT7M2r1usqkw0p2n+HGAPN3E9ixvgWSGWYTUqO3tr/aqV0xcBrgT4TncjXYE
         FxMVXrNarv1Ui+1QXckbdQXFg9cTwHcWu0XIn+COy8uReD5FO6+20wMoXZQ489ibuGXT
         kQMo6uKUWv9+5GRTVurCVT+ZhouCd73gYodLHnRvj0E24dQ/pywsOHp59+exdadBa76C
         t7b+C/FViO7b0ecHbxfL9XPII8fbPFsoy3oXwp+WszwALhMPWA434VXZfSzH9q3EG5bK
         Kcx+lK7IlghVr1gKbAhoVtUY+6XqiAoRctGPA+deEaAL46avsQQdGHFr+UEFUOSkqNJb
         4tWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y68CIXXs3ukywQOQXM62GtoaSLAuCT5qgkpdsQVVlwU=;
        b=Dj5zEl9byIXl2xy2ZeAi6fJJV5CP0l9SvZU0wqnvJlN+zxFkGxDIlHVieqzihshMPB
         jGSdWQKdKP42Nv6fL3yF20bwIOWzfuxzdUdQ3DamPIvqaIttUyap/HJKFqD3yssMrBtD
         +5Wc7Ryzm85z5fk569Idxmw+u5WxvMqA4OKB/l3ANshnWhGmXyNqhZZQSFk8XUk10vwO
         0mGzcLrBRcnzxYpbWm9HLR4pPC82kpb6sP+yq1qUCbQ/NLUNnxas1JMl+3k15wRhrTv3
         xlq2+Y6E4JxqJoQoXIs04BHTX+zPC410OQIsFfazShwuhKQJTcyZl0EXHM1fUtR6IGok
         3paQ==
X-Gm-Message-State: AJIora/uGCCfDEcLPfzqKTPbOdXUrtphQMoyTtzhW0oYF2hNTbC+EaNE
        OC4060ywsntVwwJDD1niZd39DluW+Oo=
X-Google-Smtp-Source: AGRyM1te3fwsMOksuQcGCAd0/19ZQ3Yp8pKZcxZQ6sLCAcbxKBj/oh9wNOMkkXeGkNdgfIPSkE1g7w==
X-Received: by 2002:a17:902:dac7:b0:16c:34a3:e4a2 with SMTP id q7-20020a170902dac700b0016c34a3e4a2mr15731388plx.11.1657914460338;
        Fri, 15 Jul 2022 12:47:40 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d82-20020a621d55000000b0052ab6590290sm4247227pfd.88.2022.07.15.12.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 12:47:39 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/2] MIPS: BMIPS: Improved early panic support
Date:   Fri, 15 Jul 2022 12:47:35 -0700
Message-Id: <20220715194737.4174717-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

This patch series adds support for cfe_die() which can be used during
early platform initialization when we do not yet have a valid DTB to
infer an earlycon console from. This is useful while bringing up new
platforms/DTBs as well.

Thanks!

Florian Fainelli (2):
  MIPS: CFE: Add cfe_die()
  MIPS: BMIPS: Utilize cfe_die() for invalid DTB

 arch/mips/Kconfig                      |  1 +
 arch/mips/bmips/setup.c                | 14 +++++++-
 arch/mips/fw/cfe/cfe_api.c             | 48 +++++++++++++++++++++++++-
 arch/mips/include/asm/fw/cfe/cfe_api.h |  2 ++
 4 files changed, 63 insertions(+), 2 deletions(-)

-- 
2.25.1

