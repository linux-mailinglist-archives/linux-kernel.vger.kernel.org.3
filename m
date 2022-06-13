Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19B05495E7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355515AbiFMM5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 08:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357752AbiFMMyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 08:54:44 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D01A6668C;
        Mon, 13 Jun 2022 04:13:16 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g186so5263190pgc.1;
        Mon, 13 Jun 2022 04:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hf4jIbSC0d5YY8s9rqomM6DgVm8XNv+YrOYwUOgBoNA=;
        b=LXWqlDW2i8o2CD+D6fikYhundWq6bCB6giHGiPurlzrtGHlwsplK3mx8a1NdxqTICD
         wQUiqLRKDT8VJLctE8Qyo1+yYsGZFNdBFubmnLWippbPRgB6MF9yVDZQoRuKJIdueXwO
         FM0jRPYl1fOnL/6rWLdXogGSFa2a5FpcWfZvQwec1lfsdVIoykmgXW9fd6LWHSAckdDP
         uxwPG0WS7/ESWkyuaAWgiASgRQQTdn9KLVQX1N8MvZI5kykft1vw8fvoOyjrwfEHNHKq
         p+yMOHkQEeFAkgJboqBBrgVM9NFCYLmM+itqsX9KU3HC5HJKe4SKoCUiaIXnJh74LlB5
         p/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hf4jIbSC0d5YY8s9rqomM6DgVm8XNv+YrOYwUOgBoNA=;
        b=NmwbDYhl3VGN2ebjU71r6d69RRr9cIfeejRJz9ljtFxe0LRcJYyvWpX6ndRG4lZOFQ
         01vrftUsjYJQz68lfwVGFg1MlfdD8eMK1/KQPuBvUR3hpOvCDaLUtjM4iF5L6VkXEaNh
         igbzEmI98k/PvwYF/YtRvq9kQISOGoGhjCWWacbB8o1esThgCww2yFY6xlju2zxDmhCP
         05Tb/tRtuHxRfHkf8Fs6R7gh89jYILAxM1sjhEX9sI8ILkZujq158R4cqB80xw7jQPP0
         +fxLiPcZATTAK0x7VqfF3+GYtwTw358hP109Oq0nW05wm7lLKd8Rd3zU0gRDoH72/A3K
         0/vw==
X-Gm-Message-State: AOAM533zOyYifau3evdfQzm6/0Yafz0v/kAy+f7vfg9dKJV/ok0Cc0Tk
        /IvC37P5SlFPch0qUICBmZ8=
X-Google-Smtp-Source: ABdhPJy91L1cAhQPwaeU8vYLmrVlKb6COYEVKqbPaII+8J9gUc3Xz+wkNkvJMcJwWCAFDLtI1fb5tQ==
X-Received: by 2002:a05:6a00:18a9:b0:51b:f63b:6f7c with SMTP id x41-20020a056a0018a900b0051bf63b6f7cmr47127824pfh.49.1655118796098;
        Mon, 13 Jun 2022 04:13:16 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-72-115-109.emome-ip.hinet.net. [42.72.115.109])
        by smtp.gmail.com with ESMTPSA id g17-20020a056a000b9100b0051b4e53c487sm5199989pfj.45.2022.06.13.04.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 04:13:15 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, matthias.bgg@gmail.com,
        lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com, ChiaEn Wu <chiaen_wu@richtek.com>
Subject: [PATCH v2 07/15] Documentation: ABI: testing: mt6370: Add ADC sysfs guideline
Date:   Mon, 13 Jun 2022 19:11:38 +0800
Message-Id: <20220613111146.25221-8-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613111146.25221-1-peterwu.pub@gmail.com>
References: <20220613111146.25221-1-peterwu.pub@gmail.com>
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

From: ChiaEn Wu <chiaen_wu@richtek.com>

Add ABI documentation for mt6370 non-standard ADC sysfs interfaces.

Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---
 .../ABI/testing/sysfs-bus-iio-adc-mt6370      | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-mt6370

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-mt6370 b/Documentation/ABI/testing/sysfs-bus-iio-adc-mt6370
new file mode 100644
index 000000000000..039b3381176a
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-mt6370
@@ -0,0 +1,36 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage0_raw
+KernelVersion:	5.18
+Contact:	chiaen_wu@richtek.com
+Description:
+		Indicated MT6370 VBUS ADC with lower accuracy(+-75mA)
+		higher measure range(1~22V)
+		Calculating with scale returns voltage in uV
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage1_raw
+KernelVersion:	5.18
+Contact:	chiaen_wu@richtek.com
+Description:
+		Indicated MT6370 VBUS ADC with higher accuracy(+-30mA)
+		lower measure range(1~9.76V)
+		Calculating with scale offset returns voltage in uV
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage4_raw
+KernelVersion:	5.18
+Contact:	chiaen_wu@richtek.com
+Description:
+		Indicated MT6370 TS_BAT ADC
+		Calculating with scale returns voltage in uV
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage7_raw
+KernelVersion:	5.18
+Contact:	chiaen_wu@richtek.com
+Description:
+		Indicated MT6370 CHG_VDDP ADC
+		Calculating with scale returns voltage in mV
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_temp8_raw
+KernelVersion:	5.18
+Contact:	chiaen_wu@richtek.com
+Description:
+		Indicated MT6370 IC junction temperature
+		Calculating with scale and offset returns temperature in degree
-- 
2.25.1

