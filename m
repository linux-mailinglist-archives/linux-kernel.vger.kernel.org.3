Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864004CFBE8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241476AbiCGKu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 05:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242287AbiCGKs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:48:59 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C8934647;
        Mon,  7 Mar 2022 02:08:32 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id mg21-20020a17090b371500b001bef9e4657cso12781494pjb.0;
        Mon, 07 Mar 2022 02:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=O2coRuhEIrl0a7CkbyCAavU37hnx143W043Ona7gE3w=;
        b=GXrnHnawlWP/2IB3kP7j/wJD+F+XvE65om3okd0Z2FpN1TG8TyAswl9yUjABqHuESe
         b1xMjCN5AgSGRvWugCfdrR/a/F/ms3Q+Z4E052GdrC6eYb0WaN/LK2EjKhtQTRXMS9RB
         4SRPuyuoRl7UGfTlhkFckGCfKAQ8QEJY9w1+Fc+1hyGbNjL1imYSD/3BlbRkx8NIqlkP
         zDU8e2mBUsU0tOE/G4H+1GgQAimEY5tFqAJFY/+I5Sb8ClgoeyRDlI7ln8SbGLpX59QD
         6rDFFhR5g+dK69JRgMoYhJjggQw6OczVC/hBYCq6TX3ugt4Ph4LxkT6R2NbkiIBeooVe
         Se9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O2coRuhEIrl0a7CkbyCAavU37hnx143W043Ona7gE3w=;
        b=vjbAYgSCIzej6T2uMlG6+rTgMhSdUagdRQcLXLbqCjCiPTMSbQwdDuqIf3yg1CaYis
         sZ3l5LO57d02Pb+EPwrQasDX/GrqS9pupFlSYRC/qjE9WpUFe4Lye7CMoz44+xF7o4Bt
         kt12BYONTIIDwIsFk8rFLYJFHz0bsJEboUoUWEuoctoHwavisL/ZEwk2KBzt2QjhzrvK
         UjDDZ1FAXhUE6Fx3OEU9EJFZ5pjhgOqldWjt5Z8P0IwFY5TV1MMxIn2iJbyYhD96bVCq
         NuP4eQ1dAAyymKLWAhVL3dTyJSuUvIC7at1eQw1LSxv4oZO59+xyDXg8/pss1I3yATms
         yV3A==
X-Gm-Message-State: AOAM532abK8fMKWBCHLXEwT52bHNmOnAY+U7wh/YBxnyYEsvasYrgWmt
        49NdvRjBK+ZFOpm8z8VnjdL417yteYA=
X-Google-Smtp-Source: ABdhPJyevKlg4CVtaU+0dy/Cu2n8fMu1C7KlHxl9ZkPtSNK5oKd9XCUQa/Yhf1vYz1hTeOY9M9eh0g==
X-Received: by 2002:a17:90a:528b:b0:1bc:c5f9:82a with SMTP id w11-20020a17090a528b00b001bcc5f9082amr24174248pjh.210.1646647712204;
        Mon, 07 Mar 2022 02:08:32 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:486:4335:5d3f:ee29:17d3:65af])
        by smtp.gmail.com with ESMTPSA id n22-20020a056a0007d600b004f3ba7c23e2sm15140125pfu.37.2022.03.07.02.08.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Mar 2022 02:08:31 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 0/2] Add Richtek RT5190A PMIC support
Date:   Mon,  7 Mar 2022 18:08:22 +0800
Message-Id: <1646647704-2331-1-git-send-email-u0084500@gmail.com>
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

This patch series add Richtek RT5190A PMIC support.

ChiYuan Huang (2):
  dt-bindings: regulator: Add bindings for Richtek RT5190A PMIC
  regulator: rt5190a: Add support for Richtek RT5190A PMIC

 .../regulator/richtek,rt5190a-regulator.yaml       | 138 ++++++
 drivers/regulator/Kconfig                          |  10 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/rt5190a-regulator.c              | 461 +++++++++++++++++++++
 4 files changed, 610 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5190a-regulator.yaml
 create mode 100644 drivers/regulator/rt5190a-regulator.c

-- 
2.7.4

