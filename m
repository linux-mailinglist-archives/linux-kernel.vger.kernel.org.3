Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D515AFBF9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 07:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiIGFwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 01:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiIGFw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 01:52:27 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BB1857D5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 22:52:26 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so6951703pjh.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 22:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecs-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=bvTlivoQ5nSfF+84cpi2CPQhnbe+HsBBNxx0q5XLX00=;
        b=Q/KLNCRA2xa8jICb0syTNT70zAyV4GYgAbKjXw7aOOASeUAPJL8QSxe5J1J1TUSuZM
         HOjQUg1WsftqprdKQllNd5uXqA0TqOWuoGvayz0wEEmthXDOaqkX+R8VzQlt424NI+1f
         58ZawkQe6GGxrJlT/Ur5OYYBM9cAj4OUyb/m0fiQxCjTm/CCWoqyEtoIEwnzrgWq/VDe
         ikuP/jg/zv5yY42iejBh82tp+eP5tURoXL4RRLKriglpZfNNOE/5HtCb2WmP22tDajre
         YWUsotGlWrj4u2vdxPqCGWjkScrZHYn+WLG2tyqfH+NgDTz69eCGGJA+QuaFQMNIPdIy
         hc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=bvTlivoQ5nSfF+84cpi2CPQhnbe+HsBBNxx0q5XLX00=;
        b=u+Aj+O7dOtw1MiZrZC2cEX8+WMF9YZh64M0/cQYfttC9OD5NiG1nCKwH4w8syyqvh8
         nIBoRJChHak3sL2HSBOZR3eGT/K0LLY4375M5EaW7+s57NcxXCqo75SSHat4Lf8rK259
         ZBYTTsFr5be+VNzm/A9R1G+hL/c5jAtBdp8H0aT1Ti3yTtgvFIcDHrsjwYslqCw8U/4z
         wdZIepVydoywbOlswCW/aMcoAXcj+LGwHReHfSK7vKgxv+FcS47GfZZtggPbwrBH/S0o
         lU8eaDIqtppvvynKA6yoSk82qEIES0ILMnbdpzgEa4XFIr9Ft6iqKrFiyp4rIzU+sg87
         8roQ==
X-Gm-Message-State: ACgBeo2oqJsVltu5fsbb+BOpiXanvxdERXncSbRG+0yT1bQ3oV9iWLwN
        B+HRCYaWBGpIQzXUoPS5oJ3ukWMe+Y5hfoV+Ii4=
X-Google-Smtp-Source: AA6agR6Fq1L+4wbXgW5BJVytbMb2uao4jrmnWUce3Pk6gF//IFaE2wNpEeaS8T6JZcR/lQBK8ti6jg==
X-Received: by 2002:a17:90a:5d88:b0:1fa:b5c4:608b with SMTP id t8-20020a17090a5d8800b001fab5c4608bmr28508282pji.22.1662529945944;
        Tue, 06 Sep 2022 22:52:25 -0700 (PDT)
Received: from localhost.localdomain ([103.104.171.43])
        by smtp.gmail.com with ESMTPSA id d6-20020a170902654600b00172dc6e1916sm6168094pln.220.2022.09.06.22.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 22:52:25 -0700 (PDT)
From:   Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Bob Moragues <moragues@chromium.org>,
        Yunlong Jia <yunlong.jia@ecs.com.tw>,
        Henry Sun <henrysun@google.com>,
        Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>,
        David Heidelberg <david@ixit.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: input: touchscreen: elants_i2c: Add eth3915n touchscreen chip
Date:   Wed,  7 Sep 2022 05:52:03 +0000
Message-Id: <20220907054805.v2.1.I1168feec10de16e0f130dfe72ce7976762597dba@changeid>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an elan touch screen chip eth3915n.
This chip requires more delay time than the eth3500.

Signed-off-by: Yunlong Jia <yunlong.jia@ecs.com.tw>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 .../devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml b/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml
index a9b53c2e6f0ab..d28625372f5ac 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml
@@ -17,6 +17,7 @@ properties:
     enum:
       - elan,ektf3624
       - elan,ekth3500
+      - elan,ekth3915
 
   reg:
     maxItems: 1
-- 
2.17.1

