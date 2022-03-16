Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469D94DADE8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 10:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355031AbiCPJz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 05:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355006AbiCPJzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 05:55:55 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7498635276;
        Wed, 16 Mar 2022 02:54:42 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o6-20020a17090a9f8600b001c6562049d9so1894823pjp.3;
        Wed, 16 Mar 2022 02:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5HEeDWvyKc61OwYD144KurvuXL1gSzUPJ7XnWNlx5BQ=;
        b=k6njl9rzcYTOX8SoZMx5ZIwhxePbjzP3OPyAotg9CKGUnIn02RO4uzOLUAOz3iU5xc
         I1gvStiyQFoDeOhOxP8o0iUHmX8fO3iTjT3LHEX2JO95sek2q/eii3ETiaZtM7t6RnVt
         Lt0tBW48COiNWf2NaRqaR7XqK7Qe3rvAkhSAX/zxfguVJYR9HvQMF9C/hs4PWoHMzBUr
         W+N6/F3i3lMXMcyZQjl0RcSOVeTpKSqbnK67u/M3EY2eMjWVfZ9Mh7YcZwPagQaDk8bC
         C3qchFEL3gj4GYNc66PHNRcLQi0xeRPgm0r2g8iI7C4HQbqP6Vsu5auBkhvJxsRuVK72
         dymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5HEeDWvyKc61OwYD144KurvuXL1gSzUPJ7XnWNlx5BQ=;
        b=ND9RYnDa7q4PViGE7USguqE0NdGnQxRDwYUsnSyLarNIvnUjAnA0sFSYkzCmNWV+4S
         xyZCl+b6bJF3eFpv/VTGjD0VblckVwJsvVkJXOMYjaP+KQsRY/AnSRVgq4Ns/25mevYl
         yVGnA6VAZybBs8eYgR37ZH0YK/fBSKtqgBNPzgavhr0wJQ2wGuM9ROUMcwVrP56Nb4Xz
         VNxMwkeOqtaYFhYcrcERnPV+sFQyQNX8X0NKD25ugc1F6cY2j8TicGvEvgmfbcN8R7Sg
         3y+KDKiFbeu2uPDGoDSUX0jffFJrtVy6/bWrQc/hlaFefoGGtO0do6VZE9OdJL3DWxox
         P2jA==
X-Gm-Message-State: AOAM5300gU9VZoAovrEumA/FMQV5SSNl15YDHCdvvvpnumPI75fvai0y
        9Nxd4UyikC2Z1To4uXQk/cSecjzBdCY=
X-Google-Smtp-Source: ABdhPJx7ZdJK8dmXbJze90KgqX7GClV+UlqEuvytHIEDR7jsgMG9leqf134qLM6j8p4THLW0rQTiZw==
X-Received: by 2002:a17:90a:4809:b0:1bf:72b5:af9c with SMTP id a9-20020a17090a480900b001bf72b5af9cmr9304544pjh.190.1647424481767;
        Wed, 16 Mar 2022 02:54:41 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id a22-20020a056a000c9600b004f7b8b3a44csm2567070pfv.29.2022.03.16.02.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 02:54:41 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/3] Fix dtbs warnings for arch timer
Date:   Wed, 16 Mar 2022 15:24:29 +0530
Message-Id: <20220316095433.20225-1-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
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

This patchset is an attempt to resolve 'make dtbs_check' warning for
arch timer.

Patch 1 is done in preparation for following patches which defines
compatibles order in more clear way.
Patch 2 documents arm,cortex-a7-timer entry in bindings similar to an
existing entry arm,cortex-a15-timer.
Patch 3 adds above 2 properties in of_match list to bring them in
use. 

Please note, this patchset is based on
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git, master

Kuldeep Singh (3):
  dt-bindings: timer: Rearrange compatible entries of arch timer
  dt-bindings: timer: Document arm,cortex-a7-timer for arch timer
  clocksource: arch_timer: Add arm,cortex-a7/15-timer in of_match list

 .../devicetree/bindings/timer/arm,arch_timer.yaml   | 13 +++++--------
 drivers/clocksource/arm_arch_timer.c                |  2 ++
 2 files changed, 7 insertions(+), 8 deletions(-)

-- 
2.25.1

