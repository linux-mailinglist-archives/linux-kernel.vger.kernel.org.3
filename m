Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C12C50FE87
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350761AbiDZNOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350694AbiDZNOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:14:22 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC8D606F6;
        Tue, 26 Apr 2022 06:11:14 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x18so25462917wrc.0;
        Tue, 26 Apr 2022 06:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ksg7Lipg/QDZpzLTDNfH1njMSA1a7RkRZdUpeV0/xjQ=;
        b=S3qLop8ldQW7N+ApJM0MTHHTcVuvMZ0ybG3snWKfUh2zvuZmOjPA70dDnATGwiJPus
         0qAcoH7kPsI92kkYYgLq6qLrUi+QtP9E3WCVcciChVxQMASGAKebmgfrzGTB1Q/yGxQW
         CpSh3Olyiy10zIItpXUlabT9o8TE84sFytm6YntjPmH1Ytio7TPVKjTIJFXqJz13NV76
         DACL5g+4QNSBLThV+mth40P9B7tjjNDjMPGd61/vgzVZ1ZMZ0nC+TyNqcOGYGTYaRaZk
         Z7yKJdZ89SP1c6JAJ8eKFlhDLIzNCxb4zz8QkNE4fl4nW+v26BkCButyvsRzHvFu3qNT
         FDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ksg7Lipg/QDZpzLTDNfH1njMSA1a7RkRZdUpeV0/xjQ=;
        b=5EUW2Jq4m3WoszGFFcoU1LLHJ3ciiXi5JiHDyQwncu84fz64MnhyGx3Shq8jayFGbq
         EkJNik5klv3I34TBgD8c4mC2UAhc0+rCxJq+q1Z+xtKoksxmvWeB3st/Tb6SG5CdNVhw
         D0w+dy3aYj6zvzyxUmgWikdWMvU9Oi3SPC5kcBwbl+c9KfGXU50E6ScMwmL5e1iFO9ZX
         OAvpFQFibosQkh7tr8+dUdhc6B0tNW91gXvt2n3sbOidRPhz2HtMOFTZCZBo70HwNISS
         c6uyViOYciw87JW3z+gTTC/tzowDSlTyF87L106pyWUdGN583g6CJIacVvVfyd15Kimb
         AJ9w==
X-Gm-Message-State: AOAM533gDxnMC121WljitWtFa+SjtvKP4CTG3mNNKyxIPeNrBvEauY0F
        50Kr6N3g+p8IkL+DWfhN+xU=
X-Google-Smtp-Source: ABdhPJxE//6qs3icy5uLxJhZykhA4BcQpQNnM8mbYWLTnGUQ2Hkt6oE4Otq9NYjnX1zGnGdmeC8uiA==
X-Received: by 2002:a5d:4581:0:b0:20a:bb95:bd0f with SMTP id p1-20020a5d4581000000b0020abb95bd0fmr18628358wrq.502.1650978672858;
        Tue, 26 Apr 2022 06:11:12 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c350900b00393f01c8f00sm3262910wmq.47.2022.04.26.06.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 06:11:12 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: [v5 05/14] iio: document pitch, yaw, roll modifiers
Date:   Tue, 26 Apr 2022 15:10:53 +0200
Message-Id: <20220426131102.23966-6-andrea.merello@gmail.com>
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

Introduce ABI documentation for new modifiers used for reporting rotations
expressed as euler angles (i.e. yaw, pitch, roll).

It looks like we have some unit inconsistency along various IIO modifiers:
it seems that incli is in deg, angl is in radians and rot isn't documented,
but at least the adis16209 driver has rot in deg.

Here we use deg (so angl is the only one using radians).

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 Documentation/ABI/testing/sysfs-bus-iio | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index aadddd43bf22..2a6954ea1c71 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2039,3 +2039,12 @@ Description:
 		Available range for the forced calibration value, expressed as:
 
 		- a range specified as "[min step max]"
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_rot_yaw_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_rot_pitch_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_rot_roll_raw
+KernelVersion:	5.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw (unscaled) euler angles readings. Units after
+		application of scale are deg.
-- 
2.17.1

