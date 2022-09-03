Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F8A5ABBF8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 02:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbiICA42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 20:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbiICA4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 20:56:12 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839069F8D2;
        Fri,  2 Sep 2022 17:56:10 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 199so3461218pfz.2;
        Fri, 02 Sep 2022 17:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=xGmWZlVa2R1S/KqsTQgaTSfS4nP2t0LKMUf6y1XEKCM=;
        b=cDIIEd7M8nnSQlDC54Z7Yo3UrnqUi4A7TAmBRN9WcheMU+U47MOqWivq6KYl2zhBCK
         DFo3S9U2VAvyGjHem9H+pvg8GHd3ZsbGtdmWSMC+U7wSoET/gUAAeFlBuOSgJjcUFYj3
         hA05nrVI6Lvpnk4G+4Nrc91wwiYZkpkdhjMws/chzHcRyy2RruVPETwXDWz4hsDaTxRW
         noWsCNqAmZ8kVXflGEuruSpgRVAEaStc4qR/LWT84rl6hV/Qkf8dGdPKWmqeA+GPygM7
         It9Z/1faq3SmPTC9iGdpUSn18gU4UdBec5lsYqmmyKDQ5eQU6J4wM4YDO/RwZ9CNWjiG
         Qugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=xGmWZlVa2R1S/KqsTQgaTSfS4nP2t0LKMUf6y1XEKCM=;
        b=XyImFRyWPz8bH1pWt6Ojw1Ih1jmpKrh2tMcPLd4/NngYaAHGXnGafxl4NY30ViAJt0
         oiIyQOd03LyMZjt1aVPv9urPBCXIERfjoTTMe9wy17IIgfFLraoiJqMdXK2mQ7RSL4ca
         BL5uwO3Nxoxq5tNph9h3j9qu1pqENztrb7rZt57aG6TOMIpJ/4bwuAXTlEaSqpOzyaD1
         aO5tQDZbRu9cR216HH7HBzidqDpm7+qQ78VlNC8FcdpZ/wTJ9eqPze7dChwt6npd7Db0
         8s4oKzXvCnXISLgyS61ZWj8NeNIosqAvSap86mjvULqiKv0TDgh7I2IpuLQBxIuGKS2b
         FCBA==
X-Gm-Message-State: ACgBeo0b41Up9NMVEISGR++KPlgbdlMUYTP1ttEOboptCVFomTiFaGtH
        gn39Ala19FCajzF+oX6h5zM=
X-Google-Smtp-Source: AA6agR5yHlx2bsV0Dsen7pKGH67Qa8RzkllI3HqfK2dkf3NB2D1r2P53kQ2iMCX5kFPtPpEFAwC54A==
X-Received: by 2002:a63:6e09:0:b0:430:663:7757 with SMTP id j9-20020a636e09000000b0043006637757mr14626722pgc.340.1662166569922;
        Fri, 02 Sep 2022 17:56:09 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:ea21:afd4:e65e:539c])
        by smtp.gmail.com with ESMTPSA id nn5-20020a17090b38c500b001f7a76d6f28sm2152933pjb.18.2022.09.02.17.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 17:56:09 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH v1 3/3] gpiolib: remove devm_fwnode_get_[index_]gpiod_from_child()
Date:   Fri,  2 Sep 2022 17:55:27 -0700
Message-Id: <20220902-get_gpiod_from_child-remove-v1-3-1e47125df20f@gmail.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220902-get_gpiod_from_child-remove-v1-0-1e47125df20f@gmail.com>
References: <20220902-get_gpiod_from_child-remove-v1-0-1e47125df20f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.10.0-dev-fc921
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

Now that there are no more users of these APIs in the kernel we can
remove them.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index fe0f460d9a3b..2ccda8567533 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -594,27 +594,6 @@ struct gpio_desc *devm_fwnode_gpiod_get(struct device *dev,
 					   flags, label);
 }
 
-static inline
-struct gpio_desc *devm_fwnode_get_index_gpiod_from_child(struct device *dev,
-						const char *con_id, int index,
-						struct fwnode_handle *child,
-						enum gpiod_flags flags,
-						const char *label)
-{
-	return devm_fwnode_gpiod_get_index(dev, child, con_id, index,
-					   flags, label);
-}
-
-static inline
-struct gpio_desc *devm_fwnode_get_gpiod_from_child(struct device *dev,
-						   const char *con_id,
-						   struct fwnode_handle *child,
-						   enum gpiod_flags flags,
-						   const char *label)
-{
-	return devm_fwnode_gpiod_get_index(dev, child, con_id, 0, flags, label);
-}
-
 #if IS_ENABLED(CONFIG_GPIOLIB) && IS_ENABLED(CONFIG_OF_GPIO)
 struct device_node;
 

-- 
b4 0.10.0-dev-fc921
