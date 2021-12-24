Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCBE47EF6B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 15:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352875AbhLXOMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 09:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352866AbhLXOMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 09:12:38 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179AAC061401;
        Fri, 24 Dec 2021 06:12:38 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so11694700pja.1;
        Fri, 24 Dec 2021 06:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ClX7KW0PIL7QXcserN/OWxZM7FB+UOOy301ajqBt20I=;
        b=ZUqAD4m5ScwVopUxBc6DLY7Xt0JjjyzBfYAaiDsazvwTg2iWTb6HgGWxYs+lXWOHAL
         uN9lwGMpVv3yLVpD9C/jZD+fjKh3ggrzbjvwu0wG+Jj6uiyqKWWh6CObPXUqteze5E1D
         fxFX+Bi7sOxebqf+nPH64N9ODdT1r9Q/b+oBdXxwo+HroNtx2HfN6oHzyksuf71JCoi6
         5Kb/5XIm3hrDeriQE8RJvPpBKyoTakXXm6LJAltmqBRZb0dGq+1uBWFJyX4tTkRMkbiF
         vm+zWn4DlOYz9hPLBL6soiErO8Jrhd++b9O98ZqsQwisn95SKAoJUM5q8lsdtvU0c7wi
         9s8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ClX7KW0PIL7QXcserN/OWxZM7FB+UOOy301ajqBt20I=;
        b=4Y/k3CNuYsv0278ZlyrilJcc3O03yJgyDjss8qr7m0xS0HayNc1C1oEAItqQvoYOsS
         MeBPEXXjaf1OEGw00WJP3i/6EeMiexqNvaFaI5l33NENNLOwHHEc8TJAG+b86jsUpq+l
         Egbp1dqI+ezKB8t7dRsTEDIxU09+G6RQMhm7DEb3R+AjnuQsqBQ4sNEbJxq4oaZIL5Lx
         DWGPDaIUXNdT4/vDdkzaDdnZeEtbilkpKAGW1MlJ/LTgu6c6mnyQqA7sI5KWnmUXvBEY
         pO/IJbYF9+m4MkQKnXqij/wb8stejbs5SvC+U8LDhd+MtIBZ+rColK64GDs/cpYo+/V8
         CEVA==
X-Gm-Message-State: AOAM531BNAcxsuoCbVPLvAZAiLKDmqspOK2QLn/ONMAvJ3LICH6dCAkf
        FUaXe7rk6QayPErBuoLunDM=
X-Google-Smtp-Source: ABdhPJxKkwwAvZhs9Lkj79rNrg2CWQYhRbSsolinHSrGYZ+vjmvJlZ0d/O4wP2XHb4cp8c8ue8/aZw==
X-Received: by 2002:a17:903:300c:b0:148:ac76:b30a with SMTP id o12-20020a170903300c00b00148ac76b30amr6725636pla.125.1640355157681;
        Fri, 24 Dec 2021 06:12:37 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([240e:47a:800:94db:99e3:c3c:2dfc:8554])
        by smtp.gmail.com with ESMTPSA id h7sm9919140pfv.35.2021.12.24.06.12.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Dec 2021 06:12:37 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     kevin3.tang@gmail.com, pony1.wu@gmail.com, orsonzhai@gmail.com,
        dan.carpenter@oracle.com, zou_wei@huawei.com,
        lukas.bulwahn@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 1/2] drm/sprd: remove the selected DRM_KMS_CMA_HELPER in kconfig
Date:   Fri, 24 Dec 2021 22:12:12 +0800
Message-Id: <20211224141213.27612-2-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211224141213.27612-1-kevin3.tang@gmail.com>
References: <20211224141213.27612-1-kevin3.tang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On linux-next, commit 43531edd53f0 ("drm/sprd: add Unisoc's drm kms master") adds the config DRM_SPRD,
which selects DRM_KMS_CMA_HELPER.

However, commit 09717af7d13d ("drm: Remove CONFIG_DRM_KMS_CMA_HELPER option") just removed the
DRM_KMS_CMA_HELPER. So, the select DRM_KMS_CMA_HELPER refers to a non-existing kconfig symbol.

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
---
 drivers/gpu/drm/sprd/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/sprd/Kconfig b/drivers/gpu/drm/sprd/Kconfig
index 3edeaeca0..9a9c7ebfc 100644
--- a/drivers/gpu/drm/sprd/Kconfig
+++ b/drivers/gpu/drm/sprd/Kconfig
@@ -3,7 +3,6 @@ config DRM_SPRD
 	depends on ARCH_SPRD || COMPILE_TEST
 	depends on DRM && OF
 	select DRM_GEM_CMA_HELPER
-	select DRM_KMS_CMA_HELPER
 	select DRM_KMS_HELPER
 	select DRM_MIPI_DSI
 	select VIDEOMODE_HELPERS
-- 
2.29.0

