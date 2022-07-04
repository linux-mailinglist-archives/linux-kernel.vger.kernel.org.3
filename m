Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725D4565531
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbiGDM0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbiGDM0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:26:38 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AC3B869;
        Mon,  4 Jul 2022 05:26:26 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id h23so16405357ejj.12;
        Mon, 04 Jul 2022 05:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iUi8PRt1C1hxriDLpqIJwYgJ7+Ti+qx1RIsoZc3JWOw=;
        b=k7h1y9DFvCYtbl838KmZYkRLDF4P3wrqASacRmFN7wLT6VuAyih+r3kPwVDOm/tSRZ
         VFr9CHKCY9l31YAr/NnTOfpGOHTBJBSSdSi2D1biUXLG+80TT0qA+HHpcy71rJ/CDUXd
         hYxuxyOeQayXYNWFQNIyv0Q94zQCA3uFbTJD+7rCyuuHFkhaPx02Q4Nv5LhZL7Pq7YGF
         jJMUkg2gnDVWQgjlcwM18wG2SsuTVrBtOV+bgmLxDpo9yYU27OSNHMq7tY/9fVimsIFE
         klIulxxrR48XSRI7GpTU2Arx+EUUVdsemN6lKZlpvY3u0/ziJdXqrYoIfjuXjCFzDQ/o
         lY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iUi8PRt1C1hxriDLpqIJwYgJ7+Ti+qx1RIsoZc3JWOw=;
        b=KJyEXJwydOoUI25ZSdh4tWRaYMw+Xzj2zAXl6BDQm+UuCe7t3rRIhyQmrtpZH+p0lp
         u4W6nLiLjvx8x8aPVI1TZODDzhuQUut9NoJkklvyVmEOECakRY+CIJDgOQfI0qxhBSyR
         F93Ica69P33/2iubZAuTbHtYHXmNJyGEUo0dlN8RfIlwMlVv3zmmyM+fXDUd7nUnrorU
         7wOwttjmYwjAqv35xJkApfevzL2FZu8GlC7Mdt8jBi8N23PwcVMiOHxlKTKv1AG+ErIz
         UUvv8VzcGAJqSOYsOvJnBTKa2Rf8LSpA1Q2T4kQJMeuPLmnmk5wWAOktKpuA+686fI44
         8laQ==
X-Gm-Message-State: AJIora807MnYw4SXGsOb4jVq3GPCbxv8zCyZaozvUJSEy+y3Tyyr4Rfr
        tQrJziFwrySoOj0v13oBxII=
X-Google-Smtp-Source: AGRyM1vfM9ua5WMQ5qdJPmRfUcid1CgMVYbqO7UK+/qO8DHUYblHW0vJPzb7rBIiHZz9oW1oogyV5Q==
X-Received: by 2002:a17:906:4985:b0:727:c6ac:5b31 with SMTP id p5-20020a170906498500b00727c6ac5b31mr28160841eju.501.1656937584678;
        Mon, 04 Jul 2022 05:26:24 -0700 (PDT)
Received: from felia.fritz.box (200116b826716b008998943ac77556e4.dip.versatel-1u1.de. [2001:16b8:2671:6b00:8998:943a:c775:56e4])
        by smtp.gmail.com with ESMTPSA id k20-20020a1709063fd400b00722f66fb36csm13974467ejj.112.2022.07.04.05.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:26:24 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 05/11] docs: admin: devices:  drop confusing outdated statement on Latex
Date:   Mon,  4 Jul 2022 14:25:31 +0200
Message-Id: <20220704122537.3407-6-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220704122537.3407-1-lukas.bulwahn@gmail.com>
References: <20220704122537.3407-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The statement that the Latex version of Linux Device List is unmaintained,
must go back to some historic time where there were actually two separate
document sources, one in a txt format and another in a tex format (maybe
even just on lanana.org).

Nowadays, html and tex are generated from the ReST document file and the
statement might be confused, believing the actual generated LaTeX document
from the maintained ReST document could be an unmaintained one.

Remove this statement on the LaTeX version and only keep pointing out that
the version on lanana.org is no longer maintained.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 Documentation/admin-guide/devices.rst | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/devices.rst b/Documentation/admin-guide/devices.rst
index 035275fedbdd..e3776d77374b 100644
--- a/Documentation/admin-guide/devices.rst
+++ b/Documentation/admin-guide/devices.rst
@@ -7,10 +7,9 @@ This list is the Linux Device List, the official registry of allocated
 device numbers and ``/dev`` directory nodes for the Linux operating
 system.
 
-The LaTeX version of this document is no longer maintained, nor is
-the document that used to reside at lanana.org.  This version in the
-mainline Linux kernel is the master document.  Updates shall be sent
-as patches to the kernel maintainers (see the
+The version of this document at lanana.org is no longer maintained.  This
+version in the mainline Linux kernel is the master document.  Updates
+shall be sent as patches to the kernel maintainers (see the
 :ref:`Documentation/process/submitting-patches.rst <submittingpatches>` document).
 Specifically explore the sections titled "CHAR and MISC DRIVERS", and
 "BLOCK LAYER" in the MAINTAINERS file to find the right maintainers
-- 
2.17.1

