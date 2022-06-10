Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCEC546093
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343961AbiFJIzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244829AbiFJIzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:55:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33ABE271A8D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654851297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CVVKI4thPicYfGWEh0/VZSA/WgrtJPotaQ3dMufekN0=;
        b=RFjFsg6WuyTOZyYfvn554lLo2xuGJ9bWhW8hkdMK4mZ7HUQLXrZ4GIRC2+FbXG4IAi1eGX
        VYXN2q+dnwRWOGnW7d/epYfeiSwdwdWMTyjVTk4DVoCh4c89viNRoozLEaxHwptPSru6iK
        teDkvUbDVuHPU0qXdvMplCggJ11zODU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-TOnYboKGNsOI3PfJMX5U6w-1; Fri, 10 Jun 2022 04:54:55 -0400
X-MC-Unique: TOnYboKGNsOI3PfJMX5U6w-1
Received: by mail-wr1-f70.google.com with SMTP id h2-20020adfe982000000b002102da95c71so5978055wrm.23
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CVVKI4thPicYfGWEh0/VZSA/WgrtJPotaQ3dMufekN0=;
        b=VlgY/7dvBoc5jpdamCDvnpIqZsfO35RJfZPZKMIn+ngDOeEVRlilVAtvYSYhDGz8o2
         juKHYgNHXpgpw0xTPoTot12sX3lgNnPnW5YCiIQwEjLV3aFUB3BZnHO01Ymi1cKVfCjy
         TsR+DR+UEIW3/+pzfR9jH8YqbJYlnR1xX4f9FL+b7Q92Vd6Wg5kF/hlChXMIvg9KQ3I2
         C4iq1DYtsFJ+xzEA35k/RlSf3611sI/IE1pLWaw27VbyKT6dwOffiiF7xhUQzjuxY+EN
         VNJRNk2OslIAWOzzWK6pqpfkCaNd3umUMBuWqkI+7brFrFJPWqBUr6TFSzys010s2SJP
         RXlw==
X-Gm-Message-State: AOAM531U4gdJTFiyIaPVOkCmd9I6JHmdzlT2YQCAnDmTkXyN9+dMH5uT
        YUAG2H+M+aProIsHwSmoSNjTSIUMoKsZn6RywS7svQwd1cH4J4VWikJTHweWEqVpm2PevTsjbDM
        ee5JJHIWAPOPgJk3NgJD4YaRkvsTxTUSZUdgloFs/6JqvXxJPpNPm1Oo9cDSVDrl2QqooF2FDLo
        A=
X-Received: by 2002:adf:e70e:0:b0:210:2b0f:723 with SMTP id c14-20020adfe70e000000b002102b0f0723mr42414575wrm.47.1654851294428;
        Fri, 10 Jun 2022 01:54:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRaUo7tvKddPeRO3iR2vMIJXWPBMkMuQ1f5xqNCYbyRxuzm4GDWk8ljLiP3gvkDwiWfLSALw==
X-Received: by 2002:adf:e70e:0:b0:210:2b0f:723 with SMTP id c14-20020adfe70e000000b002102b0f0723mr42414548wrm.47.1654851294148;
        Fri, 10 Jun 2022 01:54:54 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h7-20020a7bc927000000b0039740903c39sm2267836wml.7.2022.06.10.01.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 01:54:53 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Javier Martinez Canillas <javierm@redhat.com>,
        kernel test robot <lkp@intel.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH] Revert "fbdev: vesafb: Allow to be built if COMPILE_TEST is enabled"
Date:   Fri, 10 Jun 2022 10:54:50 +0200
Message-Id: <20220610085450.1341880-1-javierm@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit fa0e256450f27a7d85f65c63f05e6897954a1d53. The kernel
test robot reported that attempting to build the vesafb driver fails on
some architectures, because these don't define a `struct screen_info`.

This leads to linking errors, for example on parisc with allyesconfig:

  hppa-linux-ld: drivers/video/fbdev/vesafb.o: in function `vesafb_probe':
>> (.text+0x738): undefined reference to `screen_info'
>> hppa-linux-ld: (.text+0x73c): undefined reference to `screen_info'
   hppa-linux-ld: drivers/firmware/sysfb.o: in function `sysfb_init':
>> (.init.text+0x28): undefined reference to `screen_info'
>> hppa-linux-ld: (.init.text+0x30): undefined reference to `screen_info'
   hppa-linux-ld: (.init.text+0x78): undefined reference to `screen_info'

The goal of commit fa0e256450f2 ("fbdev: vesafb: Allow to be built if
COMPILE_TEST is enabled") was to have more build coverage for the driver
but it wrongly assumed that all architectures would define a screen_info.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/video/fbdev/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index bd849013f16f..f2a6b81e45c4 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -616,7 +616,7 @@ config FB_UVESA
 
 config FB_VESA
 	bool "VESA VGA graphics support"
-	depends on (FB = y) && (X86 || COMPILE_TEST)
+	depends on (FB = y) && X86
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
2.36.1

