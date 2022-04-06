Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02014F6125
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbiDFOQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234600AbiDFOQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:16:35 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEE942BBA3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 18:49:21 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id h23-20020a17090a051700b001c9c1dd3acbso1259276pjh.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 18:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/YAk+fWUU+ETvZMAahO94+Nmhx8ga8SOKFjIYbyRo2A=;
        b=TdiuHKaZORaWPGQTvEUC06LmhEQ2Hv4BGNuu+2WWjop40q0AwxKFUcVd+SuxV1iC2f
         fqTGkOvq2So+26pvLbXOPbG++jhun+FsmlEBb7ZVx0joMcOhwx6tONZKnOGOSWcLcAfc
         /hqRG+wM3LeeAcZ6vYUV1vNuR2rb/C7Aet6wY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/YAk+fWUU+ETvZMAahO94+Nmhx8ga8SOKFjIYbyRo2A=;
        b=io3wni3UFXlhh+FBegAIdj35BjEihWdWho/MozR6o97dyMd3F2/LUCaWJ7w1YpGHOO
         VMFEJ019qthkT8XvQfGGyMLuTGcxy8yjn5JOM88OZ/4R1f5xRVhwmZknfRRQc0WPWG3X
         bRfxFoPGngUX0GhQa8yJ7CpD1aajirBopWg38GVLLJktLc5EAVB0s0VXowrIrZ2WLDJ6
         VljGbFPHX7cJ05g5coHZCVTHllvrBtYtPsd0b0or/2M7UuFUdcgdXy5CFhAc1mdFG++8
         IinMCeggmLeycwUmlsLNPNZ5lnOxIhAmMgbQnmyR8ayDVlfuHhBmaEwM/vPJXbpwiXrQ
         XZbw==
X-Gm-Message-State: AOAM530j6DLyJpdf7FbrlcRtqzWoTaX6rp0ShSfJQj4fgFc7QBj0NixG
        M19usrEEAUnIhRvjllAHG2WtkQ==
X-Google-Smtp-Source: ABdhPJxRiO+aF5ru+VVliawznjkQgTfqyIcNS4jn2oAT5iUCxwlpZhGj0CMVfVLc/UCVkgor6cxH+g==
X-Received: by 2002:a17:90a:c253:b0:1c9:ada2:f28d with SMTP id d19-20020a17090ac25300b001c9ada2f28dmr7240326pjx.17.1649209761200;
        Tue, 05 Apr 2022 18:49:21 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6903:769c:e1f5:9c25])
        by smtp.gmail.com with UTF8SMTPSA id t69-20020a638148000000b0039822f39a40sm13620410pgd.25.2022.04.05.18.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 18:49:20 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-kernel@vger.kernel.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        linux-pm@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>
Subject: [RFC PATCH 0/2] rockchip / devfreq: Coordinate DRAM controller resources between ATF and kernel
Date:   Tue,  5 Apr 2022 18:48:40 -0700
Message-Id: <20220406014842.2771799-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Rockchip RK3399, there are a few hardware resources that are shared
between firmware (ARM Trusted Firmware) and kernel (power domain
driver) that need to be coordinated properly for DRAM DVFS to work
reliably. See patch 1 for plenty more description.

These fixes are based in part on the specification in the RK3399, and in
part based on extrapolation and observation. Any confirmation about the
behavior of PMU_CRU_GATEDIS_CON0, etc., is welcome.

Otherwise, see the patches.

Regards,
Brian


Brian Norris (2):
  soc: rockchip: power-domain: Manage resource conflicts with firmware
  PM / devfreq: rk3399_dmc: Block PMU during transitions

 drivers/devfreq/rk3399_dmc.c      |  13 ++++
 drivers/soc/rockchip/pm_domains.c | 118 ++++++++++++++++++++++++++++++
 include/soc/rockchip/pm_domains.h |  25 +++++++
 3 files changed, 156 insertions(+)
 create mode 100644 include/soc/rockchip/pm_domains.h

-- 
2.35.1.1094.g7c7d902a7c-goog

