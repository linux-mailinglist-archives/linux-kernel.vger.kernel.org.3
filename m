Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0602156BD67
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238945AbiGHQCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238948AbiGHQCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:02:08 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10344747B3;
        Fri,  8 Jul 2022 09:02:07 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q9so31145458wrd.8;
        Fri, 08 Jul 2022 09:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pro0cyE0Jn+rZnK315lxKLlhsCvoJbHZNzW9Cc6PhUM=;
        b=DdALFxmXrrrET3rMR34tN44U4tdHIi66lU8JJgJj1T+SoKhoWIuZ47YnYx+bWP5dtT
         cs/CICnTVgvS1+SkZUajmRDjZrJ5R/RW6WTpBSpbMk6iPxvPhcZfBonyBcskW+wwVZbe
         mu1lyy0jcDbzhNGPVrMfL5d5yi8nb+7apnV2Z1M9R6TxH1OjkQBVLvlW7eAfHMxNvyOf
         +BygGQmUPY2z7O6TUeO4f+5YMnMUqLq1zvNRXH5MPDfOl90Gg5BoDc0C1r3BeyxpRlTY
         ghYCg5nwEBFB/1n0iy2HoPyxR2IIWY363ohyY1ZA2JB9+N7V41sp66Da85ibY1DIVUEE
         cu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pro0cyE0Jn+rZnK315lxKLlhsCvoJbHZNzW9Cc6PhUM=;
        b=Fan8Lr7Krwhoz9vhy8dTStrATX7WoK2CBOS2IZHApnO9RQllVNzW4Q7aa0Mxqkr6kj
         OeJ5GDyOTXX9lgmcEgBUPhBB5DTGGwwB3SjAiM8Fhz+K8A9GnpMmEfGEDbNpxWoOfUY4
         5cLPiV+fA/FMtJQpDFDNEqM8+SxqpJXkoKvIi0lDAZ4V/aSUcz9dJvO05UVcqijt+TRe
         EWyb4FSDJxKjwCrEjl3ZnsHkpJ2CHSakqAcV/CpSmSb8zukwx39uucKQb68Wp4/5y5oW
         Qydl81pKNt+ejjAb36OQxg6livTJdYHkbmhpJKceSqsO2cN/p1GqcNmRhUiL18PlYYYm
         qMmA==
X-Gm-Message-State: AJIora9it2dMULIGrWo5VFIoLUqFMF+REeEhi4AlmDaChTbxj0+cK3ih
        03V3Hj0D2o5/gEZ608bjUYk=
X-Google-Smtp-Source: AGRyM1sa1uwt7GX0FBbOcHiYKkmpTtcghJDD6LEDkMeWFUrD+Gsb5I/JS8R0WTKA5jwMbEcyVxHehw==
X-Received: by 2002:a5d:59a6:0:b0:21b:a234:8314 with SMTP id p6-20020a5d59a6000000b0021ba2348314mr4026407wrr.316.1657296125630;
        Fri, 08 Jul 2022 09:02:05 -0700 (PDT)
Received: from localhost (92.40.203.144.threembb.co.uk. [92.40.203.144])
        by smtp.gmail.com with ESMTPSA id u18-20020adfdd52000000b002185d79dc7fsm18237827wrm.75.2022.07.08.09.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 09:02:04 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/11] ASoC: cleanups and improvements for jz4740-i2s
Date:   Fri,  8 Jul 2022 17:02:33 +0100
Message-Id: <20220708160244.21933-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a preparatory cleanup of the jz4740-i2s driver before
adding support for a new SoC. The two improvements are lifting
unnecessary restrictions on sample rates and formats -- the existing
ones appear to be derived from the limitations of the JZ4740's internal
codec and don't reflect the actual capabilities of the I2S controller.

I'm unable to test the series on any JZ47xx SoCs, but I have tested
on an X1000 (which is the SoC I'll be adding in a followup series).

Changes in v2:

* Drop two patches already in sound for-next.
* Squash two removal patches into the regmap fields patch.
* Remove the unused 'mem' resource in the driver private struct.
* Use regmap_set_bits() and regmap_clear_bits() to improve readability.
* Add fix for SoCs with independent FIFO flush bits (ie. most of them).
* Update sample formats patch with a more informative commit message.
* Add two new patches to refactor DAI/component probing.

Changes in v3:

* Fix missing 'ret' in patch 11 (yes, that was pretty silly of me)

Changes in v4:

* Refactor FIFO flush bits fix so it doesn't depend on regmap conversion.

Aidan MacDonald (11):
  ASoC: jz4740-i2s: Handle independent FIFO flush bits
  ASoC: jz4740-i2s: Remove unused 'mem' resource
  ASoC: jz4740-i2s: Convert to regmap API
  ASoC: jz4740-i2s: Simplify using regmap fields
  ASoC: jz4740-i2s: Use FIELD_PREP() macros in hw_params callback
  ASoC: jz4740-i2s: Align macro values and sort includes
  ASoC: jz4740-i2s: Make the PLL clock name SoC-specific
  ASoC: jz4740-i2s: Support S20_LE and S24_LE sample formats
  ASoC: jz4740-i2s: Support continuous sample rate
  ASoC: jz4740-i2s: Move component functions near the component driver
  ASoC: jz4740-i2s: Refactor DAI probe/remove ops as component ops

 sound/soc/jz4740/Kconfig      |   1 +
 sound/soc/jz4740/jz4740-i2s.c | 461 ++++++++++++++++++----------------
 2 files changed, 248 insertions(+), 214 deletions(-)

-- 
2.35.1

