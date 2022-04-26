Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC7950F470
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345158AbiDZIgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345172AbiDZIeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:34:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A956E8FE;
        Tue, 26 Apr 2022 01:26:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26F98B81CF9;
        Tue, 26 Apr 2022 08:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B103AC385A4;
        Tue, 26 Apr 2022 08:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650961577;
        bh=NVUJ0VORKi7g0jZiS1qERChpaAaP2AdAWHVP0rm62mI=;
        h=From:To:Cc:Subject:Date:From;
        b=RDMfNqTLJeauKUffKk9z6elUttJ2T3yrOJhLD/2W9oSrW/xrzV4m9NyT0ubeMi1vi
         PzmDKvPgzBbw/Efv5yOeBL45LZvmyFJ0FUESFeWEql3jgE/mKr4DAWRBdzdGp1JCPR
         I7b6G+KWS/Tbyz1KLRdP5/RL03iYot09ye9uo9r37vz9lFFIUiMcaiIJ1ebY81UMgH
         2W4DMKjpWPBekpMp4zlYX0wSjt8UZ1PTvelgmSTx2T4fMwGaS/jvcJAshRcdj1uVa4
         HCT/EV4FwhKZBnK8+CfzFVs9eY4pYiOHYEEeVP8uoTDb0DWboYp76HiuGY46rh3z+R
         oXAaC81v093Yw==
From:   Roger Quadros <rogerq@kernel.org>
To:     krzk@kernel.org
Cc:     miquel.raynal@bootlin.com, tony@atomide.com, vigneshr@ti.com,
        kishon@ti.com, nm@ti.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v4 0/2] memory: omap-gpmc: Allow module build
Date:   Tue, 26 Apr 2022 11:26:09 +0300
Message-Id: <20220426082611.24427-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These patches allow OMAP_GPMC config to be visible in menuconfig
and buildable as a module.

cheers,
-roger

Changelog:
v4:
- drop COMPILE_TEST as include/linux/irqdomain.h does not have
fallbacks if CONFIG_IRQ_DOMAIN is not available. So build will
fail with COMPILE_TEST on platforms not having CONFIG_IRQ_DOMAIN.
- use GPL instead of GPL v2 for MODULE_LICENSE. Fixes checkpatch
warning.

v3:
- Remove not required MODULE_ALIAS
- Mention in commit message why we need to remove of_match_node() call

v2:
- Allow building as a module

Roger Quadros (2):
  memory: omap-gpmc: Make OMAP_GPMC config visible and selectable
  memory: omap-gpmc: Allow building as a module

 drivers/memory/Kconfig     |  2 +-
 drivers/memory/omap-gpmc.c | 43 ++++++++++++++++++++------------------
 2 files changed, 24 insertions(+), 21 deletions(-)

-- 
2.17.1

