Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2342F4BA5BA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243177AbiBQQ1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:27:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243123AbiBQQ1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:27:42 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FB19AD9B;
        Thu, 17 Feb 2022 08:27:28 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a23so8581664eju.3;
        Thu, 17 Feb 2022 08:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hw2Jui/kNYseL0KVgLc40Ac/EwZ3g3QErB9gIo0wOQA=;
        b=gYc3fv2qUFO4rr7likmfGjcDiFRd/MCKILMn9lx45vtGgNRBOEjRGr5N+t0jiMK9z8
         1O6KFmPVf2BifwDmhsLc/J7T/5+YNJmNoDlhwVTDiXMFIuAZMXAhp648LpH3e08rDjI2
         v9b5QOr99k5wXny8y5kS+AR8NAiU3kVOWXOOX5LXkD2usg8gSgAzgumzRv3eovBUQhk3
         2PyirFoxMInET8M5l4cMlMaJrayah4awWIvfmIjiaE6NVWyGWVJFHIUM2v0tQusN75nb
         oQsX5gmWTjORILkOe0z3TLgXZ6d5BiEBe1yXG18lZN14oXDBrgDmffNb4vLf0sOVP7tp
         iPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hw2Jui/kNYseL0KVgLc40Ac/EwZ3g3QErB9gIo0wOQA=;
        b=MUE2eOXu9ld9iqF9Q6vH1i56LH7SBp4szgW2YKexIOgmHYNb8ssXRYJOb+dfC6aplQ
         o487e+d5ubxO4pX31EdataolCBo26aQpjMwEWAAHOn5GtVaQrTk6v7xtonFdh4WX/YS8
         UqLnPPksaWtLaPN/ZOIZzVdSbcoWjDcYTvasicigbzAu2SWOyUE+p8qbpk7luG+aECz7
         jDOhAeZFRwNPwUJ/NL02pzbAJrwSbTZfwNobdwaiJzPup6URp8iRJCgQ2Yt+5u0gBx++
         NftL1EKLzFlTvQOA/uElttDfxBPAwmQd5bxtuWOu60BFnHXXZpMS9CgRQ3LM1SAEYxnt
         yAGQ==
X-Gm-Message-State: AOAM532vvYv6Cq1F5ZfNn4S4FHo1E0Tc0UF0AscpXyM5CFkbx2r1N2x9
        rHisZYyUp3LluFez0ByVtDY=
X-Google-Smtp-Source: ABdhPJwV2JJ0iu1JHh4CbKZB2JCiDqotDzX1Wvux/dnMjKVBHhliMnFjimIDo/Xvf+cDESseEUJnrw==
X-Received: by 2002:a17:906:7714:b0:6ba:8a6a:b464 with SMTP id q20-20020a170906771400b006ba8a6ab464mr2961475ejm.613.1645115246662;
        Thu, 17 Feb 2022 08:27:26 -0800 (PST)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id j13sm3653742edw.24.2022.02.17.08.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 08:27:26 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@gmail.com>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [v3 04/13] iio: add modifers for pitch, yaw, roll
Date:   Thu, 17 Feb 2022 17:27:01 +0100
Message-Id: <20220217162710.33615-5-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217162710.33615-1-andrea.merello@gmail.com>
References: <20220217162710.33615-1-andrea.merello@gmail.com>
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

This patch adds modifiers for reporting rotations as euler angles (i.e.
yaw, pitch and roll).

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 drivers/iio/industrialio-core.c | 3 +++
 include/uapi/linux/iio/types.h  | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 252dbe3444cc..8a5ba32d3963 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -137,6 +137,9 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_LINEAR_X] = "linear_x",
 	[IIO_MOD_LINEAR_Y] = "linear_y",
 	[IIO_MOD_LINEAR_Z] = "linear_z",
+	[IIO_MOD_PITCH] = "pitch",
+	[IIO_MOD_YAW] = "yaw",
+	[IIO_MOD_ROLL] = "roll",
 };
 
 /* relies on pairs of these shared then separate */
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 387a1b5cd1a9..4a7481cdaf7a 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -98,6 +98,9 @@ enum iio_modifier {
 	IIO_MOD_LINEAR_X,
 	IIO_MOD_LINEAR_Y,
 	IIO_MOD_LINEAR_Z,
+	IIO_MOD_PITCH,
+	IIO_MOD_YAW,
+	IIO_MOD_ROLL,
 };
 
 enum iio_event_type {
-- 
2.17.1

