Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CEA5A12E5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242166AbiHYODV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241430AbiHYOC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:02:59 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DC125F8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:02:54 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1661436170; bh=ELGy1lUsHhPdvqtxh1bn64AYOFQqdlpEPx8nzBVvc/Q=;
        h=From:To:Cc:Subject:Date;
        b=hv7CXhgLy6WgpqX3UhKZwyPXlNgVtxyprcluDZBE80PKmGq3Rfv2ewtadZaKh86mY
         oVcHp3SuYeBvnqN0AD/KIjSLmw5qVbjsEiAy3vLYXCxscRoHVZM9td56eRj1b3l8BY
         TblbGZnNpko+m1A0bNOmMflMqB+d9jWpmkQKynDg=
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     navada@ti.com, shenghao-ding@ti.com, asyrus@ti.com,
        raphael-xu@ti.com,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Stephen Kitt <steve@sk2.org>, Dan Murphy <dmurphy@ti.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Subject: [PATCH 0/5] TAS2764 fixes/extensions
Date:   Thu, 25 Aug 2022 16:02:36 +0200
Message-Id: <20220825140241.53963-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First three patches are fixes analogical to those recently done to
the TAS2770 driver.
Link: https://lore.kernel.org/asahi/20220808141246.5749-1-povik+lin@cutebit.org/T/#t

The latter two add IRQ handler to log faults and expose a new control.

Martin Povišer (5):
  ASoC: tas2764: Allow mono streams
  ASoC: tas2764: Drop conflicting set_bias_level power setting
  ASoC: tas2764: Fix mute/unmute
  ASoC: tas2764: Add IRQ handling
  ASoC: tas2764: Export highpass filter setting

 sound/soc/codecs/tas2764.c | 181 ++++++++++++++++++++++++++-----------
 sound/soc/codecs/tas2764.h |  23 +++++
 2 files changed, 152 insertions(+), 52 deletions(-)

-- 
2.33.0

