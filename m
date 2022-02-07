Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301C24ACB16
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbiBGVS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbiBGVS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:18:26 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9C8C061355;
        Mon,  7 Feb 2022 13:18:25 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id o2so4003027lfd.1;
        Mon, 07 Feb 2022 13:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2hxorUUp0t634DZQae5n7+kTN25Fy6VHoakv6Qb7QV8=;
        b=Y9hFiqVC7Xqysad+0JRz0TFEV0QKkjLoRqvHbKlaISjT4dgRf6bnOllP3kklMYV+qG
         DZ9Yg2D3+GFh2EJ7ckbhkipMSO6TaiGDgpv1IOsAAoySROe3ZyJWh9DGI/C4OS50hKy8
         bKRmww2ebPyHi+mOuf3gOyLLdX3R+KSv919RFJ7zrwu3eR26yT4ChGhma//3lDZ0XetS
         UhNdgAW2S1d/FNoqjs5FT4OwTyBnISDOh0GWHK84W8yGq31VdeKd4AFu6yjTHm8Ut3/9
         dBAk6sR+xem8yroCf6PKowhV39K8wi71dJMH2hSS7mj/H2pohifOSNAxK3J+efYfOEp5
         TRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2hxorUUp0t634DZQae5n7+kTN25Fy6VHoakv6Qb7QV8=;
        b=PLqxmPx5k4cvA+EyaXLfScoSTDWnT2Pz017zG5us3AqiNPAHZmkt7Q8ItrRnRZ+99D
         rRqUQaEmGKxcZaVfX0fSVYnX7h4Vr9Gx8jp56IuEzFMLkaFeXvNENso8JOZEuYbHHu1r
         b0syzU4oRAW1HvhmPTymdWjRzdm08FOSA7p65WI1MWhUCMJ76zeNS0ndbY0eV7PdsGT8
         N3Cni15vgO1kdDIw8MVkT9RpY3yi6k5JdhIzqJhs0VFZZZ/q9Bc4wxmN2dUEkzIcRR3Y
         XkBKRZCPss5QKyoBBJ22E8+xeM3l//4uYoAhRKQWrTv/rExtAl45xs8s3C8J3/idclGc
         ealw==
X-Gm-Message-State: AOAM531PQ2QVR7UH+Lbp2+x7nNMagigcqV19yfbtaATcUdsj9DAy+6sL
        h6TP7jpD+l+qafoFpjuQH2HefkqUek8=
X-Google-Smtp-Source: ABdhPJwUrD4o9kmczzCrVMBvlkl9TiH+NKP+zkcqGdi1m+YE3IvCWKbxVPfjDImO0vOiUiVKQZsf1Q==
X-Received: by 2002:a05:6512:2386:: with SMTP id c6mr928046lfv.299.1644268703712;
        Mon, 07 Feb 2022 13:18:23 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id s30sm1637978lfp.93.2022.02.07.13.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:18:23 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 0/3] MIPS: Constify static irq_domain_ops structs
Date:   Mon,  7 Feb 2022 22:18:13 +0100
Message-Id: <20220207211816.57860-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify a number of static irq_domain_ops structs that were never
modified. This allows the compiler to put them in read-only memory.

Rikard Falkeborn (3):
  MIPS: OCTEON: Constify static irq_domain_ops
  MIPS: ath25: Constify static irq_domain_ops
  MIPS: pci-ar2315: Constify static irq_domain_ops

 arch/mips/ath25/ar2315.c             |  2 +-
 arch/mips/ath25/ar5312.c             |  2 +-
 arch/mips/cavium-octeon/octeon-irq.c | 10 +++++-----
 arch/mips/pci/pci-ar2315.c           |  2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.35.1

