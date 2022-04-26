Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E9850FE8F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350772AbiDZNOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350722AbiDZNOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:14:32 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AC6606C8;
        Tue, 26 Apr 2022 06:11:19 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q23so12527713wra.1;
        Tue, 26 Apr 2022 06:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9BnF53lWXq+Kioy1WHRA6GamlF6438787W3udo1iOFU=;
        b=JilcEUE1wgZLXWf8Yn3HiwwoAj0pXjtSrzPDdPxIRmOKN6ZBzQGxE2NyRRSwq49YXx
         QZZsnyZc9ybd0ypQXxONwcCQ81cuV2J5IDHvjakJ6oZd92McSoBKSOBw57va77z+bSD6
         h2yPQwRtTccr/4Ht5i1zuNgledGXNxGdqc8cpqwWEYIF+5Kbbc2edB50R3AiVBCLjwTu
         o+wpD7d2qApO9kURTK2TpjDuScmUrKvL/Yu1PuFrltHBGvDybdlSSOruTj2Fs1IaqkiB
         1S2iyOepxnz+0hyX3siuIWRSiSTLkC5NB37YuXW2UHsTy5D4NG9Z3xSswmawkOob+mNW
         i/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9BnF53lWXq+Kioy1WHRA6GamlF6438787W3udo1iOFU=;
        b=k00+oBh3GiNcd6A2Mwl996hoOoCneTBDITEDmIVyPTCdx/qg+9LT08V4K9fKdKna8M
         TkxG9ermPhIq70sK8TToo8riHgd9Dc7jkg2CxqVKZqVNZgMLvjy4HiPjbXOHyh9MM7n5
         SGzHLS0aLbYr5a+7kbVkS2jXP883C5bJ6TShDc/BwjCrhEIS3JExpTAkJnWrYLmGcc2g
         RxOJ2FsbJYneEhatUtNRzkWFMpgz+/0XcXq2PaWdhYGyZ5wo9eKMOIITHaflftVT8ySw
         3NdfawUacakiGKj0zFQdJvbt3FERS++ozCDcNQGeajE9q3SWR/nrGg9mNELXZsPiLWbr
         Tulw==
X-Gm-Message-State: AOAM5322zjSy3tahq6ND26Rr79S4nOwzLVGZExh6Rva705W5m+oI/FLK
        Hjq19WXIpq1Ac20zM9mIjSUaEQ3zTzNDb+VcUNo=
X-Google-Smtp-Source: ABdhPJznLVsaJbLER81NSCZq/7VKIgeji7kKy+jdHakN4G6/Bz4tyR3hnXyT13UO14OcT5iba305jg==
X-Received: by 2002:a05:6000:381:b0:20a:8690:9ac6 with SMTP id u1-20020a056000038100b0020a86909ac6mr18205670wrf.209.1650978678054;
        Tue, 26 Apr 2022 06:11:18 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c350900b00393f01c8f00sm3262910wmq.47.2022.04.26.06.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 06:11:17 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: [v5 10/14] iio: document "serialnumber" sysfs attribute
Date:   Tue, 26 Apr 2022 15:10:58 +0200
Message-Id: <20220426131102.23966-11-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426131102.23966-1-andrea.merello@gmail.com>
References: <20220426131102.23966-1-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Merello <andrea.merello@iit.it>

Add ABI documentation for the new "serialnumber" sysfs attribute. The
first user is the bno055 IIO driver.

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 2a6954ea1c71..eadf0326a56e 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2048,3 +2048,10 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Raw (unscaled) euler angles readings. Units after
 		application of scale are deg.
+
+What:		/sys/bus/iio/devices/iio:deviceX/serialnumber
+KernelVersion:	5.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		An example format is 16-bytes, 2-digits-per-byte, HEX-string
+		representing the sensor unique ID number.
-- 
2.17.1

