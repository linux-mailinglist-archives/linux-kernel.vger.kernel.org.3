Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7C34E26B2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347489AbiCUMie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347467AbiCUMia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:38:30 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3877B165BA7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:37:05 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id dr20so29167270ejc.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7me8S3DIeK4bexe2TBxZLK2PJKyh4lTG51mZlWXkZww=;
        b=C19FsPW3byM6bnKzUkgtA47+KFtmLiWrmr4t6hSJGULj2k309rEBEtN2OGQsQRiwuq
         Tf7pGGbRpBWabv9ws0LjfO1OL+rhABFTf+vjU+HIUUnAQRbmDhdFLmJpMp+yjZ8xSV4B
         KUfeNsDBZsJHX3FP8Lk7r2hiXgERWOOIBOGZ3FcOfhKTIgdhYHT3bknlW4P2YOYCrDXv
         5rkAOgvhMbmPGyyfARZBgE1MHiem0Ujlefjvar28MLDqRVXhaMP1F5tXGn792CIrUp8i
         qMmwJn+4Tj+g36DpgP5vT9kKWi3ykd/ErottJfQwACHtJmP9342GGljWeMeJpbxpoRYQ
         9WVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7me8S3DIeK4bexe2TBxZLK2PJKyh4lTG51mZlWXkZww=;
        b=a1t7bjFy0JpxNCw9KdmYENtI1U9v9rGtYg1oQj2i7wTvNNhWc6viV+NCJgp+BRsSqI
         WXXGaNFKbasvR+YtgqqfwNVSkTQrXH7XcLpBXTM4Rhw54oLtzRiz5XKw7zOBionyWdkv
         /Ra7W9u+YYrIPWlCeTZy2HXd5fRUtmX0XfmRACqBdDt4NgZQ1SkKqWBsV45/LxavHnWw
         zI5HdCNytki3AiO+9YScfhMYN3X3nyuMyBAnsiztljWd43w5vgl7ImewJ02p5tJcTlAF
         Gtjrv+AQaImFhDOXCzTPg5hw2UCFIkv6/6EZ7blYOP4gF7qRBsSj3hH8JmaQ40epbOiX
         4CtQ==
X-Gm-Message-State: AOAM5304yZq/sjwsVNMuJcXwobBqz6DDa/bdf13RjnklZczP/dzzsJRw
        qnV7bAhfILT+vH1Lq+A4gdM=
X-Google-Smtp-Source: ABdhPJz//+/NzM8a26O+rIuAgQzPd3NBsmf9i2GYdkXJe3FDISS5jPq35iB6eXU0g5Afq1Abig9xGQ==
X-Received: by 2002:a17:906:dc90:b0:6df:f5fb:cf91 with SMTP id cs16-20020a170906dc9000b006dff5fbcf91mr7190371ejc.429.1647866223710;
        Mon, 21 Mar 2022 05:37:03 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id q16-20020a170906145000b006bdaf981589sm6836241ejc.81.2022.03.21.05.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 05:37:03 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Vaibhav Agarwal <vaibhav.sr@gmail.com>
Cc:     Jakob Koschel <jakobkoschel@gmail.com>,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: [PATCH] staging: greybus: codecs: fix type confusion of list iterator variable
Date:   Mon, 21 Mar 2022 13:36:26 +0100
Message-Id: <20220321123626.3068639-1-jakobkoschel@gmail.com>
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

If the list does not exit early then data == NULL and 'module' does not
point to a valid list element.
Using 'module' in such a case is not valid and was therefore removed.

Fixes: 6dd67645f22c ("greybus: audio: Use single codec driver registration")
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/staging/greybus/audio_codec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
index b589cf6b1d03..e19b91e7a72e 100644
--- a/drivers/staging/greybus/audio_codec.c
+++ b/drivers/staging/greybus/audio_codec.c
@@ -599,8 +599,8 @@ static int gbcodec_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 			break;
 	}
 	if (!data) {
-		dev_err(dai->dev, "%s:%s DATA connection missing\n",
-			dai->name, module->name);
+		dev_err(dai->dev, "%s DATA connection missing\n",
+			dai->name);
 		mutex_unlock(&codec->lock);
 		return -ENODEV;
 	}

base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
2.25.1

