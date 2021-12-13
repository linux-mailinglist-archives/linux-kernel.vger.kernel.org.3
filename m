Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC1D47219D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 08:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbhLMHVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 02:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhLMHVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 02:21:21 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E764C06173F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 23:21:21 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso12621572pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 23:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=HVnnmDHMSAlLudHh2weJdjgBJk3noTgCFu3aVuhxzkY=;
        b=MAdYUJKJdsGLKqAVTkt2cBe7+7KjiOX3Aa6AEVkEwCXhRwOKzmlnnuyCrIxDdI+eTS
         98JtjgVazDST37Wp0dLG54KZ6D4GgYZMMLLoUxXIVYlO+NqgREpy4my9cHMqNsOEOsd4
         bP0FX8vsnC2fSoU3fL5SrfNOTPBkop32ML/ucRsuPfFQSvKWekqYF06QxTWy/qtTZ4If
         wHnSb27/+TyPcXsj7T/nsWQF6If0YVVNrJUPuuDoOZxPZRPSf2aoL+q4QgAYmmldDhVq
         sMxLZT8eGDB3KLcMU0CKL8llLC9VdFwforaWmkfsd9Lukb7wiefb8CGoOaIJDIIkQ8DK
         5Kmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HVnnmDHMSAlLudHh2weJdjgBJk3noTgCFu3aVuhxzkY=;
        b=KujQDUG1T5lbsrlLKHjTWSNn8y6IhUtr/wLRxjo4g/uiTaFyVzBcygNg6OmGm7+7J1
         UmlRXKZP6cqfDDcfW8rhD8kG00UkFStyTMDpcrhm/uEO+ZRqhotF0OqJJo/f86MdQhbc
         MZCuTFhLZ34TGkQ2l+JNbZUsg4aTG0CmoJ7LXUsf+IetIj7KH+w3vpe1IqIXrvn2GaKa
         vJIttlgG8XQVwI/mauVokDh1SwHTxobYzJrgaO59teSSLchLkkilbybDbdPaZxEsq04D
         nLP8rEtDT2IL31RLDT2RMDsRL2Ockh2hptENeGjSJdxnbdtm3d4ZLaSyFgbEg9WRMXqD
         tY0w==
X-Gm-Message-State: AOAM530gNM8sDfmmKaL/8GC3cjwjqVbQfhZKOKytWKgJL6x8f+UsHZe/
        01AnKjU6u+wzuwuXyUmt6Xw=
X-Google-Smtp-Source: ABdhPJxxd9MY8IUrj1xFEfZXUxZ+y6bUFGcoD/7/OXAJyQ6k+fYHa2H2eB4Iw7r/NsOymwDkTrMhTg==
X-Received: by 2002:a17:902:bf4b:b0:143:aa96:f608 with SMTP id u11-20020a170902bf4b00b00143aa96f608mr93035834pls.23.1639380081096;
        Sun, 12 Dec 2021 23:21:21 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id y190sm10913520pfg.153.2021.12.12.23.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 23:21:20 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] udmabuf: Fix NULL vs IS_ERR() checking
Date:   Mon, 13 Dec 2021 07:21:15 +0000
Message-Id: <20211213072115.18098-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The get_sg_table() function does not return NULL.
It returns error pointers.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/arm/malidp_planes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
index 0562bdaac00c..2ef8feae8c4e 100644
--- a/drivers/gpu/drm/arm/malidp_planes.c
+++ b/drivers/gpu/drm/arm/malidp_planes.c
@@ -348,7 +348,7 @@ static bool malidp_check_pages_threshold(struct malidp_plane_state *ms,
 		else
 			sgt = obj->funcs->get_sg_table(obj);
 
-		if (!sgt)
+		if (IS_ERR(sgt))
 			return false;
 
 		sgl = sgt->sgl;
-- 
2.17.1

