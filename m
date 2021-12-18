Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30350479843
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 03:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhLRC4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 21:56:40 -0500
Received: from mx-lax3-2.ucr.edu ([169.235.156.37]:25904 "EHLO
        mx-lax3-2.ucr.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhLRC4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 21:56:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1639796199; x=1671332199;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Vhh2Wojmk5xxnlKfiyWrawrHKzGyzr84ZKM1o8pV+po=;
  b=S3MlUdyKd4MXrlEnOvPFnVc3SRh5gm/0uTO5NkVkvTPnoKRJDZ8ldAZ2
   xAgeYzBo5cvGB9isctUqlfKu041lFBn0oAnptgDcSqKoV8sOKWQJelz6W
   rDPMNAIIZWm1UfVSd0qXxmcQBUI5+gjYOYBuClkI0DgeKjIVwRPjp7gxH
   DSX2l4bxr2vc/fTSD3tGataOCiQufCY5LfypXb/090m+qNQ4M/p4ocAlj
   SdjtQLvnYwCf1Dtq3uv4fdwag36uM1Tj5LOPqLwzkZ9CeHOBqufeQmaPy
   pQErPvcY5D9YgxbfN/bsEmsgi9al7Q4S/88FHiF4WbsIbuhKlq88R+yl9
   w==;
IronPort-SDR: qu6tgvRK7Zeo5yskQxsFSl0sM+DGcaXU3N6TUlErvLF1zrmN2nS9KAKe4VFszE4JkbOp+mH9Ex
 9mqtuCvRNY+WjXwupFcLIMvZG/mKv9P0aUiV/6O7CZ2SogOtG+1edgnFPoeRsV1+CAmL7xPpkz
 kvKLNg+2mjaRvig4onRrfdC+BoVe15W8FyMZ/L4eTWNWOCeG/kVZgwBdhFtk6BGK305cAl+6Gg
 jrexywrSTI020kNg7lEpUTi9zeafkaw3H+Vua6Mg45xOd2A+nA7muJKqx12ePIo/VtGLs7/4ba
 nPFlEykH6jDHuvX3PU5kQGIB
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="91926189"
Received: from mail-qk1-f198.google.com ([209.85.222.198])
  by smtp-lax3-2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Dec 2021 18:56:38 -0800
Received: by mail-qk1-f198.google.com with SMTP id az44-20020a05620a172c00b0046a828b4684so2211174qkb.22
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 18:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W/oW4xcGaHD/Q9q+L8wKlfwu0bwPMu3EEaXJ1rCZ7r8=;
        b=Q1p+R3mC+VX9kDcyIZHntGkxKhbBd1chuPJ73wN16OAQ/DfnmvLJpQcHRIU2WoU7Zq
         tMDLlXWxqTIUo1WvrzD36E0gfnySwXT6rY6UQs9nb+9GXnekte7W8LvZLG6zEtyWu/Al
         FsP2C5hPSiTsbWEQBzH3/3CSPKY18FDzVtEgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W/oW4xcGaHD/Q9q+L8wKlfwu0bwPMu3EEaXJ1rCZ7r8=;
        b=avycw26HQl7os/n7eZWLS8dVer0dbmEsNtmJzbgSY6UNT7gC4ugzdR5BDmyEQEUAGn
         Y6YDFnJgbOcIGumvNTy2GXxABWE7U0q79fhxncELsBIUxeVI2XrZSDx4yKejHUtFhMlL
         mAX72eGooC5MM4OgfhoIMIWVaYoo9Jdod9dfwb4Si5u+WCJK3XSosShCKRmGxviaB3gH
         EjtMvFMU7efy5nANvj5fnG7qOBUGxFvaLgIac0C3UI57X3Fkeq7A5u4TKuxs0QC4KWYX
         zpVhS0qozjG6miLSk8Hw4hBIngyhuQ8cgvbTgdslq/HL0uRD21Q97HcEirUESKpfQqRY
         PX+A==
X-Gm-Message-State: AOAM533E+ssjUD8xuobJXEC1vO6NaCmyLTctCVPAC6w0O7PnTkWD6Py1
        jIZRm9ya4pHSkShLzuFofaJNP/6UdnYRS/Bs3H+vBgFa8x0fH7CWGc9Y7jAreGEgE6YF13tCMpP
        +zvwZOX+alrYCZ9uTWmu2/xYHJQ==
X-Received: by 2002:ad4:594e:: with SMTP id eo14mr5090063qvb.99.1639796197992;
        Fri, 17 Dec 2021 18:56:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzNSeR5+Y93fUCIc7POaHKnPLRzL0hlcG5CdAYxVV5YFjohfuBdG0RQ94oMtIxeknO4m2da8g==
X-Received: by 2002:ad4:594e:: with SMTP id eo14mr5090057qvb.99.1639796197839;
        Fri, 17 Dec 2021 18:56:37 -0800 (PST)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.googlemail.com with ESMTPSA id m1sm8455617qtk.34.2021.12.17.18.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 18:56:37 -0800 (PST)
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     lyude@redhat.com, Yizhuo Zhai <yzhai003@ucr.edu>,
        stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/core/object: Fix the uninitialized use of "type"
Date:   Fri, 17 Dec 2021 18:56:30 -0800
Message-Id: <20211218025632.2514288-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function nvkm_ioctl_map(), the variable "type" could be
uninitialized if "nvkm_object_map()" returns error code, however,
it does not check the return value and directly use the "type" in
the if statement, which is potentially unsafe.

Cc: stable@vger.kernel.org
Fixes: 01326050391c ("drm/nouveau/core/object: allow arguments to be passed to map function")
Signed-off-by: Yizhuo Zhai <yzhai003@ucr.edu>
---
 drivers/gpu/drm/nouveau/nvkm/core/ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/core/ioctl.c b/drivers/gpu/drm/nouveau/nvkm/core/ioctl.c
index 735cb6816f10..4264d9d79783 100644
--- a/drivers/gpu/drm/nouveau/nvkm/core/ioctl.c
+++ b/drivers/gpu/drm/nouveau/nvkm/core/ioctl.c
@@ -266,6 +266,8 @@ nvkm_ioctl_map(struct nvkm_client *client,
 		ret = nvkm_object_map(object, data, size, &type,
 				      &args->v0.handle,
 				      &args->v0.length);
+		if (ret)
+			return ret;
 		if (type == NVKM_OBJECT_MAP_IO)
 			args->v0.type = NVIF_IOCTL_MAP_V0_IO;
 		else
-- 
2.25.1

