Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3A5487206
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 06:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbiAGFNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 00:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiAGFNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 00:13:40 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4258C061245;
        Thu,  6 Jan 2022 21:13:39 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id a9so4495349qvd.12;
        Thu, 06 Jan 2022 21:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZMydJcrYBWYfz++yrfm9numu8P51rovdFWjDysMdzMU=;
        b=a5jrSCUy1qzOk0ZWI58bGTSzjl7h9MI33mTRLrzjp7eqX8vy2OgCMm2NqzCxatLtgR
         pTyMLjRvp+Yy8AnNOsoPYCIwX9PbUxcjR+7GXviasb2iEPKt42v23yzYdFuP4F20S2QP
         8AXrB2iCLHTvGO2pwE7gjPdo2W/qBDPULbtokC0xvegiSt+EGi5yr2N2t86uh72aUZuQ
         l/RbSq9sPih1MRDegj4CtJbcpmy5aHfi35ffmVMBNb5D2lNoTRHlUV19yUEvcDHv9ppz
         OK94V3/VZj/t1WYEFVmH0UmVq00C4l2JTO04PRoGjMNn79VG74R78n3cfnkDRVEoJ143
         7HxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZMydJcrYBWYfz++yrfm9numu8P51rovdFWjDysMdzMU=;
        b=MF6/+z89BqpoBmnk8OCjY7UQhxxZroO1IOAvJXmAwAd5CRKXINSLiUwIv+Y/Wf6Izm
         b3R8Xj7yHhEeFCIXtkuuwRDm3zHd5JTed/fAbVkC5UEgcjaeOkf1kuosCkmOAXRv0Nk4
         C9kV9aIlzHdN11JM4NxFWkN2oP4PiL75mNHvKVDaEy1iiqI3Ev/G2s0VeMaJAtW08xi9
         gLeaIRwMdqBBRN3Iwceg/3FHoNGQK8lo4r/F1hrOV3W6wa9+aI0VSntLUUkVuJKyG5yW
         IGclCuNU6CmBb1VHU23gxh82zWR387HXDxaCwsljB7MXKtcKSQudpWoQ/gP1xqDrANjN
         ZIDQ==
X-Gm-Message-State: AOAM530UdbA8v5c3EdNjPW4ihjkZo7FdDGmqAE0BWdjfnsuOzEdJTQg4
        8Lg0DdnTizaKGTcJsPalj2Q=
X-Google-Smtp-Source: ABdhPJzQlCJkK20myaaVTzColneVsGaenQ+DXHtAqF3mYdlYfCIYFWj4CwHF5nOdIFNiuMhMRqGISA==
X-Received: by 2002:ad4:5beb:: with SMTP id k11mr53243086qvc.120.1641532418778;
        Thu, 06 Jan 2022 21:13:38 -0800 (PST)
Received: from master-x64.sparksnet (c-98-233-193-225.hsd1.dc.comcast.net. [98.233.193.225])
        by smtp.gmail.com with ESMTPSA id d15sm1651461qka.3.2022.01.06.21.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 21:13:38 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Peter Geis <pgwipeout@gmail.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: display: panel: feiyang,fy07024di26a30d: make reset gpio optional
Date:   Fri,  7 Jan 2022 00:13:32 -0500
Message-Id: <20220107051335.3812535-2-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107051335.3812535-1-pgwipeout@gmail.com>
References: <20220107051335.3812535-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some implementations do not use the reset signal, instead tying it to dvdd.
Make the reset gpio optional to permit this.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 .../bindings/display/panel/feiyang,fy07024di26a30d.yaml          | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml b/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml
index 95acf9e96f1c..1cf84c8dd85e 100644
--- a/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml
+++ b/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml
@@ -35,7 +35,6 @@ required:
   - reg
   - avdd-supply
   - dvdd-supply
-  - reset-gpios
 
 additionalProperties: false
 
-- 
2.32.0

