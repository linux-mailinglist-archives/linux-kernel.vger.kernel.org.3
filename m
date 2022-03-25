Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028ED4E6BBA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 02:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357112AbiCYBIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 21:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241524AbiCYBIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 21:08:23 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD63BBE14;
        Thu, 24 Mar 2022 18:06:50 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id q11so6501765pln.11;
        Thu, 24 Mar 2022 18:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=v14eIjflLmW8LswNvgKKUtTAQJQUZbv/tpvCgkXmGX4=;
        b=HMdExKOrJg51vcBi3Uk8GbpCzaKzNcYM8pdq+8gzIC1qK/q0No2/WzJ3CNokEV8TJ/
         R0jf7nuD5jWyZjPkv5HXMdbejNboz3+nK28pfwI/dbQ0R+cCTbtE6fy0Z2UJ+SDYsS5t
         rY9Ea99TMxIu05gewV4ew3lEbgrYLKdQOtweCmLLXYpWiVFRkuchgW7ckbB7Q7EgbAOh
         sk/o6ssxdTEOthK36JBv3PYWz4EQn+vT3MLVoJ8ve+z5gaQMljP4xaTE5X8+2tYElw62
         bDjtpJAcXXBCA7DoJst80u6momvjwo4A3yNTMHPpKau3UiSTRrceFCRY4OQsj2dLE2IO
         MpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v14eIjflLmW8LswNvgKKUtTAQJQUZbv/tpvCgkXmGX4=;
        b=pus2ElB9p2gTYSl39nVSCoYVsHY1SZDkz3yDx00NfTvYsJ3FiHAdxi+dE+Oc9WaLKI
         ihQfPU9ASxLgVEmjZA6CbhkXG5gmqqhYascGKVYYj3/tkUkJcvNubU4Wy51Dz5WRHPLp
         lAscd/5+FTTr05uTJmlg/V2eAaWL72k5+A1Nhgvrc+kq0S9HZNpDjRK3TdbdUXB+ZEpj
         7PubQMYQdDENCGToTU5DDcDZ1/xRND2Zx1iiFCZqJeVrQc5hvPF9OvWs8rsGVyg1ZgjF
         0ir+fwYl4hZJWyby2zt9QCbpqcaQK9x9VYBc3DJV4AflNAdvUZECG0BYDULWN9AZvBIA
         FHOw==
X-Gm-Message-State: AOAM530R8FPPp2pIxSNFPLBVk1gx5kULsLYr/s7TbqZ8E2mR521lXtn1
        b0dV5NR3uwO2gro0riFSxSA=
X-Google-Smtp-Source: ABdhPJxx9TIVvDRf8BQyZcqJP33pW4A2/IQjgo7Swn/sxuEJYencNdqeMQApbdzDFOd0qmVAvAkhsQ==
X-Received: by 2002:a17:90a:5913:b0:1c7:2b71:65d8 with SMTP id k19-20020a17090a591300b001c72b7165d8mr9430995pji.87.1648170410043;
        Thu, 24 Mar 2022 18:06:50 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:56a:d674:140:d261:4ff3:2835])
        by smtp.gmail.com with ESMTPSA id kk11-20020a17090b4a0b00b001c73933d803sm10971483pjb.10.2022.03.24.18.06.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Mar 2022 18:06:49 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com, gene_chen@richtek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 0/2] Add Richtek RT5759 buck converter support
Date:   Fri, 25 Mar 2022 09:06:39 +0800
Message-Id: <1648170401-6351-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

This patch series add Richtek RT5759 buck coverter support.

ChiYuan Huang (2):
  dt-bindings: regulator: Add binding for Richtek RT5759 DCDC converter
  regulator: rt5759: Add support for Richtek RT5759 DCDC converter

 .../regulator/richtek,rt5759-regulator.yaml        |  90 +++++
 drivers/regulator/Kconfig                          |  10 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/rt5759-regulator.c               | 372 +++++++++++++++++++++
 4 files changed, 473 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5759-regulator.yaml
 create mode 100644 drivers/regulator/rt5759-regulator.c

-- 
2.7.4

