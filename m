Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E97556AC0B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 21:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236422AbiGGTqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 15:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235994AbiGGTql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:46:41 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3122BB18;
        Thu,  7 Jul 2022 12:46:40 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id sb34so34152898ejc.11;
        Thu, 07 Jul 2022 12:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f4kRqvDXJLS7GmZtsXFWRLLZtfHq29P8onQ8FdHB/nc=;
        b=obemIAbufVUX0Je/5XsBCs2IbAeoJaqeC0Ye2dg4etoDg4Gx4IJ/GuGRTSEo0/+t1c
         MaVLtDhbQo8kX6EnbsrEOZqQOG0JJJhb82CgRsw5P28sFAsJ6qQdGiKgWqFrlktmgaEY
         6ILuKXzCrONa5M3aGa81w6a8nRBozHzdBFkh0DYQI0EpXYx2v4rCiksmNal2s+TSwp/5
         itz3hUzy8TzLA0SvjzSJSJwqWijO9DjiOpsAxfAq5c0gzU654gzCgKmJgABigIPSejcN
         dMUdPaTvEH5kifwV3HjSYduzHjtCYicNobHEaR1N+m3xkfFXO4Ptiztez8AUgbgZmmaT
         h9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f4kRqvDXJLS7GmZtsXFWRLLZtfHq29P8onQ8FdHB/nc=;
        b=QMYvC+FHtjd6yDho05NQ8O6OViXN010E0Q6iZad60Y/BYl4ADCXwo4dAl+PJHgrSCe
         pdf5h88oHz+tkXZGbZBlfXo3HvVTMyHZnS8zCFzeUMAmEB8cQyI6X4VmXwOg6GLVW4N1
         2WCndVShl5hHLdDfJ7HMur2xwIdWOJSeeJVN35VBfgbwdAdiGSec7hyrjqb0otVJo6fr
         5woV4JNMGcxJOoK/+akrNab6pQT28mBFz/GsTX+tcrXIDoXgrmbtfi9CJCt/9SqHNLSE
         LpaxKH76WOqnenK9kgGQvntb7HPjBWCaRaB4qagcZRtWtc0t0T3dQ2XeDj2NfGo8r1TV
         /VBA==
X-Gm-Message-State: AJIora/mmLrVara23BtzxMu9LCyWA/dOu+c1Ga0cDhGquMH3AhXszhlW
        OnPtmMwf6sRpnD7wWLEloiA=
X-Google-Smtp-Source: AGRyM1tYDIOipNBlPWqFzK1Y0g8kMPF5iQqDRhDwSVrvLwVWbXfp5Rd4m5iNHpkpQS9eh2EXVw6t/A==
X-Received: by 2002:a17:907:2ce8:b0:72a:6315:9412 with SMTP id hz8-20020a1709072ce800b0072a63159412mr39942235ejc.47.1657223198907;
        Thu, 07 Jul 2022 12:46:38 -0700 (PDT)
Received: from localhost (92.40.202.166.threembb.co.uk. [92.40.202.166])
        by smtp.gmail.com with ESMTPSA id lb23-20020a170907785700b0072af0b036f3sm3656613ejc.41.2022.07.07.12.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 12:46:38 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/11] ASoC: cleanups and improvements for jz4740-i2s
Date:   Thu,  7 Jul 2022 20:46:44 +0100
Message-Id: <20220707194655.312892-1-aidanmacdonald.0x0@gmail.com>
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
adding support for a new SoC. The last two patches lift unnecessary
restrictions on sample rates and formats -- the existing ones appear
to be derived from the limitations of the JZ4740's internal codec and
don't reflect the actual capabilities of the I2S controller.

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

Aidan MacDonald (11):
  ASoC: jz4740-i2s: Remove unused 'mem' resource
  ASoC: jz4740-i2s: Convert to regmap API
  ASoC: jz4740-i2s: Simplify using regmap fields
  ASoC: jz4740-i2s: Handle independent FIFO flush bits
  ASoC: jz4740-i2s: Use FIELD_PREP() macros in hw_params callback
  ASoC: jz4740-i2s: Align macro values and sort includes
  ASoC: jz4740-i2s: Make the PLL clock name SoC-specific
  ASoC: jz4740-i2s: Support S20_LE and S24_LE sample formats
  ASoC: jz4740-i2s: Support continuous sample rate
  ASoC: jz4740-i2s: Move component functions near the component driver
  ASoC: jz4740-i2s: Refactor DAI probe/remove ops as component ops

 sound/soc/jz4740/Kconfig      |   1 +
 sound/soc/jz4740/jz4740-i2s.c | 460 ++++++++++++++++++----------------
 2 files changed, 247 insertions(+), 214 deletions(-)

-- 
2.35.1

