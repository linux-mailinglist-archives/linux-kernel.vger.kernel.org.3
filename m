Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457EA5722B4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 20:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbiGLSeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 14:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiGLSeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 14:34:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF5BBDBB4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 11:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=fHgrQHCc655FJdPY9x1bi0PKduTmHmcw0it6E+N218Y=; b=XlC5k9uRWiremsaPvGS7ESW3hA
        oNqmGAnAr7nNLazIs8RZvLUmArQgsfeI59rHHactAUdcpd3OHq2oNueDQeQ8WXeU4FowwzpgRSZ4E
        dZKDCdlDTyqNcuIXThuSALyFAwTRw8QHxDe9f9WxXXbr3hVUaahOCBOjODw5ntjtJYn2C8iOeZhLG
        XqBdDJURMP+XYKFykdbLqGTTFfkjMDoGyoVHXWI1UZm48sQWr04a7WDdask6S9akqJv3yjsur9z+L
        TlCLmPH036fn5ycNN6M6APUq/jZdAkh/MhwRgQEDCTMymHj/YhIN/dwdrpYZ/C3uul3Q8XqM70mR7
        O4VO/2VQ==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBKho-007C5w-3h; Tue, 12 Jul 2022 18:33:57 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH -next] ASoC: amd: fix Jadeite kconfig warning and build errors
Date:   Tue, 12 Jul 2022 11:33:48 -0700
Message-Id: <20220712183348.31046-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since SND_SOC_ES8316 has a hard dependency on I2C and since 'select'
does not follow any dependency chains, SND_SOC_AMD_ST_ES8336_MACH
also needs to have a hard dependency on I2C.

Fixes a kconfig warning and subsequent build errors:

WARNING: unmet direct dependencies detected for SND_SOC_ES8316
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && I2C [=n]
  Selected by [y]:
  - SND_SOC_AMD_ST_ES8336_MACH [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_AMD_ACP [=y] && ACPI [=y] && (I2C [=n] || COMPILE_TEST [=y])

sound/soc/codecs/es8316.c:866:1: warning: data definition has no type or storage class
  866 | module_i2c_driver(es8316_i2c_driver);
sound/soc/codecs/es8316.c:866:1: error: type defaults to ‘int’ in declaration of ‘module_i2c_driver’ [-Werror=implicit-int]
sound/soc/codecs/es8316.c:866:1: warning: parameter names (without types) in function declaration
sound/soc/codecs/es8316.c:857:26: warning: ‘es8316_i2c_driver’ defined but not used [-Wunused-variable]
  857 | static struct i2c_driver es8316_i2c_driver = {

Fixes: f94fa8405801 ("ASoC: amd: enable machine driver build for Jadeite platform")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
---
 sound/soc/amd/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -28,7 +28,7 @@ config SND_SOC_AMD_ST_ES8336_MACH
 	select SND_SOC_ACPI if ACPI
 	select SND_SOC_ES8316
 	depends on SND_SOC_AMD_ACP && ACPI
-	depends on I2C || COMPILE_TEST
+	depends on I2C
 	help
 	 This option enables machine driver for Jadeite platform
 	 using es8336 codec.
