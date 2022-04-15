Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD77502AC2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 15:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241354AbiDONDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 09:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353895AbiDONDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 09:03:04 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70179396B0;
        Fri, 15 Apr 2022 06:00:35 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 11so4835441edw.0;
        Fri, 15 Apr 2022 06:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WyOK4bZC6pkuuNreO1YwvAEYd7CzAZCb4Uh3rCmNv5g=;
        b=I8lFUW2/EaCMfpApLC+8BtRzOql27t/4Opksx9gxHHXjvlyBRhHyCYjyxXAVWFwWX/
         cOqHbqj4XkxBkaC0khlT1w9lUqlaW9SwaTvxYovFbPIR6LURITAuadZwVMTbpKVtzk94
         pRjr86H6TS7h4hte+C2PzonZwxIfeOqLoU80oy6w5Vy8p7RIRRYklWTS23O71o02qLxE
         VgTihik+CKfmjcwMGxBVFLlKHO97saTy+SqlXYLaAIQEh7bh1T+bDwgOxATSkqXAoN06
         lTbGlTGGFyfytXaoGHpNNpBo6EVkvnq8teRLO8FJHjwUv1BxjkXEvQmpsCm9OUSP0AM2
         czlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WyOK4bZC6pkuuNreO1YwvAEYd7CzAZCb4Uh3rCmNv5g=;
        b=oplUNk0WvDFCMgfsFN0FcpEnmQOPybC/Mijci+tyHjyIHibN7wevHFvzclSr7MSO6l
         1BCM3cEchIRoeVgY6pSGEVAdQYHKVD9DxZLISFkGyuId53Bv7IDXl6Uaf6FBxBsQDoMu
         SLPTkKp7D2u8Pt3bamFlLofaFjHo4z+qBllNk757Ny84TrUoNqUkWxbbguP7guBZEv4o
         8ux39NnkCTXHQwhUeMDUkT4mRnUGcBaUWdIpSlvzet5B6a2cnV8mfL8KaM/9YaFCkyxc
         uWZAZUw0HyZQAxPotGLe/GcD97ifjHrJBa5ASi+k8yo7R/Tb46F+hAXhvoqqBYXG0vTH
         eniw==
X-Gm-Message-State: AOAM531ZhiY/x+aSc5pnjm5wi4/U1xD6HnNpzErWuMJbg0gfRBs0XtQX
        Eu1e/LHn3nONWfyfahP4UJ8=
X-Google-Smtp-Source: ABdhPJxDAjrqE5QTiCVW2p+uqGYMOjrVmct7SHT9SCbgjznCPItIobN2X0m2fPenhQcl4n1WWnp0mw==
X-Received: by 2002:a05:6402:218:b0:419:d804:9483 with SMTP id t24-20020a056402021800b00419d8049483mr8278954edv.396.1650027633950;
        Fri, 15 Apr 2022 06:00:33 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id i26-20020a50d75a000000b0041e84bb406fsm2704715edj.0.2022.04.15.06.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 06:00:33 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: [v4 10/14] iio: document "serial_number" sysfs attribute
Date:   Fri, 15 Apr 2022 15:00:01 +0200
Message-Id: <20220415130005.85879-11-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220415130005.85879-1-andrea.merello@gmail.com>
References: <20220415130005.85879-1-andrea.merello@gmail.com>
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

From: Andrea Merello <andrea.merello@iit.it>

This patch adds ABI documentation for the new "serial_number" sysfs
attribute. The first user is the bno055 IIO driver.

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 2a6954ea1c71..3be613f64843 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2048,3 +2048,10 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Raw (unscaled) euler angles readings. Units after
 		application of scale are deg.
+
+What:		/sys/bus/iio/devices/iio:deviceX/serial_number
+KernelVersion:	5.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		An example format is 16-bytes, 2-digits-per-byte, HEX-string
+		representing the sensor unique ID number.
-- 
2.17.1

