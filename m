Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F19A4F4190
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445800AbiDEUIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1455441AbiDEQAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:00:02 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1133E17077
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:15:29 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F21321EC04AD;
        Tue,  5 Apr 2022 17:15:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649171724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=Hu6/55Y5RP0JeHRRHFzJWTLf8RYPBg7nbGCBlr4S73o=;
        b=MnDYNBG22EWthkUZ/Ya63+V8MCVMmDtfcDxQItzPpBKA0JdMvsrm3P8FFsQ3YUnama26/p
        Ot7+9BAebypZI1hG1PVISCd2eCHJECNaDOg9OBvmKFaVjqSM/Oft4sjf9A2M/35kxznZIP
        inB4ZisU32YbZ5siQHNo3JdtyjO1oic=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 00/11] treewide: Fix a bunch of shift overflows
Date:   Tue,  5 Apr 2022 17:15:06 +0200
Message-Id: <20220405151517.29753-1-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi all,

so this is the result of me trying to make allmodconfig actually build
here.

Due to some recent changes which added -fsanitize-shift to the build
options of an allmodconfig, it started failing here with an old gcc
because getting an overflow while shifting is undefined C99 behavior.

gcc warns/errors out with -Werror about this only on newer versions
where -pedantic is present while older ones do so even without it. The
whole details here:

  https://lore.kernel.org/r/YkwQ6%2BtIH8GQpuct@zn.tnic

Fixing all those is trivial so please pick up at your convenience.

In order to avoid spamming people unnecessarily, I'm not CCing everyone
on each patch but only the relevant maintainers and lists.

Thx.

Borislav Petkov (11):
  scsi: aacraid: Fix undefined behavior due to shift overflowing the
    constant
  ALSA: usb-audio: Fix undefined behavior due to shift overflowing the
    constant
  bnx2x: Fix undefined behavior due to shift overflowing the constant
  drm/r128: Fix undefined behavior due to shift overflowing the constant
  i2c: ismt: Fix undefined behavior due to shift overflowing the
    constant
  brcmfmac: sdio: Fix undefined behavior due to shift overflowing the
    constant
  usb: typec: tcpm: Fix undefined behavior due to shift overflowing the
    constant
  mt76: Fix undefined behavior due to shift overflowing the constant
  perf/imx_ddr: Fix undefined behavior due to shift overflowing the
    constant
  IB/mlx5: Fix undefined behavior due to shift overflowing the constant
  drm/i915: Fix undefined behavior due to shift overflowing the constant

 .../gpu/drm/i915/gt/uc/abi/guc_actions_abi.h   |  2 +-
 .../i915/gt/uc/abi/guc_communication_ctb_abi.h |  2 +-
 .../gpu/drm/i915/gt/uc/abi/guc_messages_abi.h  |  2 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_reg.h     |  2 +-
 drivers/gpu/drm/i915/i915_reg.h                | 18 +++++++++---------
 drivers/gpu/drm/r128/r128_drv.h                |  4 ++--
 drivers/i2c/busses/i2c-ismt.c                  |  4 ++--
 .../net/ethernet/broadcom/bnx2x/bnx2x_reg.h    |  2 +-
 .../broadcom/brcm80211/brcmfmac/sdio.c         |  2 +-
 .../net/wireless/mediatek/mt76/mt76x2/pci.c    |  2 +-
 drivers/perf/fsl_imx8_ddr_perf.c               |  2 +-
 drivers/scsi/aacraid/aacraid.h                 |  2 +-
 include/linux/mlx5/port.h                      |  2 +-
 include/linux/usb/pd_bdo.h                     |  2 +-
 sound/usb/usbaudio.h                           |  2 +-
 15 files changed, 25 insertions(+), 25 deletions(-)

-- 
2.35.1

