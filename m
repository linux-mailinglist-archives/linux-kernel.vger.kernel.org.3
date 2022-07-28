Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D861F5845CD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiG1SVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 14:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiG1SVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 14:21:37 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5775A8B9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:21:36 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4LtzW401JqzDrRb;
        Thu, 28 Jul 2022 18:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1659032496; bh=zS8FhQ0szhg5qxpEAL2or4ejjBssUI7B/eremX+6cyQ=;
        h=From:To:Cc:Subject:Date:From;
        b=E3v7U8JtYusWn7U/eBmKwpWVnPLpNWSvzSl2qstE1GsPMgHqPUl84+iEQBkBfCE7f
         ELTbWXs7OPjbrha5S5AclPFMzzgGmvZwDMuEdSRIusoYJHr2PZs4vdXp2+ahg6V7vu
         2lB5rc1SfkcUwI1wydcPWsYSKIrjq4Q/iv6857H8=
X-Riseup-User-ID: D190A6AF3E4EF6422053A736E8208A1B059E112028FE98AC1BEAD5B92598DBC2
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4LtzVy1nHYz5vMX;
        Thu, 28 Jul 2022 18:21:29 +0000 (UTC)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        mwen@igalia.com, andrealmeid@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
Subject: [PATCH 00/16] Remove entries from struct vba_vars_st
Date:   Thu, 28 Jul 2022 15:20:32 -0300
Message-Id: <20220728182047.264825-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A while ago, I sent a patch removing some entries from the struct vba_vars_st
[1]. At that time, I used git grep and checked if they were used anywhere else
manually. But the struct vba_vars_st has more than 900 variables, so git grep
every variable is a pretty huge work. So, I grabbed all the variables' names
and put them in a text file, and wrote a bash script to analyze if the
variables were used.

I ended up finding a bunch of variables that were only assigned but never used.
I manually checked the results of the script in order to make sure that no
functional changes were made to the code.

I only removed variables that were only assigned but never used or variables
that were never even mentioned.

Best Regards,
- Maíra Canal

[1] https://lore.kernel.org/amd-gfx/20220630215316.1078841-1-mairacanal@riseup.net/T/#u

Maíra Canal (16):
  drm/amd/display: Remove NonUrgentLatencyTolerance VBA variable
  drm/amd/display: Remove CompBufReservedSpace* VBA variable
  drm/amd/display: Remove DSCCLK_calculated VBA variable
  drm/amd/display: Remove AllowDRAMSelfRefreshDuringVBlank VBA variable
  drm/amd/display: Remove VStartupMargin and FirstMainPlane VBA
    variables
  drm/amd/display: Remove ImmediateFlipSupportedSurface VBA variable
  drm/amd/display: Remove WritebackAllowFCLKChangeEndPosition VBA
    variable
  drm/amd/display: Remove some XFC variables from VBA
  drm/amd/display: Remove SwathWidthCSingleDPP VBA variable
  drm/amd/display: Remove ModeIsSupported VBA variable
  drm/amd/display: Remove MPCCombineEnable VBA variable
  drm/amd/display: Remove NumberOfDP2p0Support VBA variable
  drm/amd/display: Remove TFinalxFill VBA variable
  drm/amd/display: Remove MaximumDCCCompressionYSurface VBA variable
  drm/amd/display: Remove only mencioned once VBA variables
  drm/amd/display: Remove never used VBA variables

 .../dc/dml/dcn20/display_mode_vba_20.c        | 83 ++-----------------
 .../dc/dml/dcn20/display_mode_vba_20v2.c      | 83 ++-----------------
 .../dc/dml/dcn21/display_mode_vba_21.c        | 75 +----------------
 .../dc/dml/dcn30/display_mode_vba_30.c        | 43 ++--------
 .../dc/dml/dcn31/display_mode_vba_31.c        | 26 +-----
 .../dc/dml/dcn314/display_mode_vba_314.c      | 26 +-----
 .../dc/dml/dcn32/display_mode_vba_32.c        | 44 +---------
 .../drm/amd/display/dc/dml/display_mode_vba.c | 18 +---
 .../drm/amd/display/dc/dml/display_mode_vba.h | 45 ----------
 9 files changed, 30 insertions(+), 413 deletions(-)

-- 
2.37.1

