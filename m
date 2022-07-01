Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FEC563748
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 17:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiGAP7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 11:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiGAP7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 11:59:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 003BB237F8
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 08:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656691177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3ViBZTo7+P6CuULplF5aZdglMlpqIG92IWrr6hqoZuI=;
        b=fIgUFr1Afd9mUY+d48iSRr2qmgTQBrJNOofiNN7z7Qxzw4f3VmOChpZA5DVRgiUMu1vZqQ
        HeKNvf3pv/KzF20+1MHz4VZITEVkvvbnbcxCnZdbVq7sKG3JiEFh4SFmxuuCIl0aPpHD2t
        nqfIexhGlOp4JptYGikPLEDrRVg5OXs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-Hg6ATMNXP8uKvW0RWeo6BQ-1; Fri, 01 Jul 2022 11:59:36 -0400
X-MC-Unique: Hg6ATMNXP8uKvW0RWeo6BQ-1
Received: by mail-qv1-f72.google.com with SMTP id b18-20020a0ccd12000000b004703d1b04e8so2827048qvm.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 08:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3ViBZTo7+P6CuULplF5aZdglMlpqIG92IWrr6hqoZuI=;
        b=gqsrqcxtoPW9MLYlF+Zrsl7p0bc2TcxTD5NU2BhsKVRCH4SeQxdWZzmK/y+VFZINh8
         s56yENTZr+EwWac9i8ia+v4PYwSuPNyH2KpTE1CjPhQz/ePHPrMff7abtWScUkeJSQUA
         9UkzzPoYfljYexxmRPUYuwUZ7RoK2IQRWelmxR5atdZa+8SWcNaGuhnlHBZysyqYoxHA
         wzxvDoKTtg5wb3nHZcr9e8fCE4YjfqpI0CltcV0Gz59/b5WEm5EyVcO4gf4p6gaQ0vo/
         w0717Lyfp0ENYWGfQwa/wIF4BaVnXZeSWWQjOJSBpZbh+vKxptPScMONPNtdXwCzguYY
         10Yg==
X-Gm-Message-State: AJIora91nKmhc0q/rSXVYyBsE3sHONFDl0/89bj0cWXeFa4ug9Cw/EEK
        rm6lJLh52SbGGz4fMKSGZ04SHQ6YmakyhBlZrKdA3xJCml72tjDkj+eeRnhoGpsbQEzbtShB+c8
        ctBM463w/F2DY8BcHL178SQtl
X-Received: by 2002:a37:887:0:b0:6af:147c:fed8 with SMTP id 129-20020a370887000000b006af147cfed8mr11398393qki.70.1656691175342;
        Fri, 01 Jul 2022 08:59:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uDN5DQ7LAZQpRQ7ZnFyAXmPCSLgKuUxkxMsCn5VlYgkvegKTTuDpjUoPZ9Z4CpwnlALkDIAA==
X-Received: by 2002:a37:887:0:b0:6af:147c:fed8 with SMTP id 129-20020a370887000000b006af147cfed8mr11398381qki.70.1656691175122;
        Fri, 01 Jul 2022 08:59:35 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y18-20020a05622a121200b002f90a33c78csm16127153qtx.67.2022.07.01.08.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 08:59:34 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     srinivas.kandagatla@linaro.org, bgoswami@quicinc.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, nathan@kernel.org, ndesaulniers@google.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] ASoC: codecs: wsa883x: fix fallthrough error
Date:   Fri,  1 Jul 2022 11:59:30 -0400
Message-Id: <20220701155930.262278-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang build fails with
sound/soc/codecs/wsa883x.c:1207:3: error: unannotated fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
                default:

Add the missing break.

Fixes: cdb09e623143 ("ASoC: codecs: wsa883x: add control, dapm widgets and map")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 sound/soc/codecs/wsa883x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index 40c7d64a9c41..dcd88175b9cd 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -1204,6 +1204,7 @@ static int wsa883x_spkr_event(struct snd_soc_dapm_widget *w,
 						      WSA883X_SPKR_PWM_FREQ_F300KHZ);
 			snd_soc_component_write_field(component, WSA883X_DRE_CTL_0,
 						       WSA883X_DRE_PROG_DELAY_MASK, 0x9);
+			break;
 		default:
 			break;
 		}
-- 
2.27.0

