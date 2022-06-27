Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811D655DF7A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238058AbiF0PUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237854AbiF0PTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:19:25 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B640615FD7;
        Mon, 27 Jun 2022 08:19:24 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id cf14so13530052edb.8;
        Mon, 27 Jun 2022 08:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iUi8PRt1C1hxriDLpqIJwYgJ7+Ti+qx1RIsoZc3JWOw=;
        b=bfzJZMSrLClLHbt1G5H03y4ulCRznQDgHU77oL1p5y+rwFWsnrknNBj6PuVqNX8lQg
         b87b76r1ryfwhAM12BB6huxCzsSmx1lsNvI9qlC4qWuuxyAomhpErXHXeuP++MNpADL2
         ukgcOjokHVkjqYoHnWjBEaeSK07tNIBNPcZq/o2cbqmRLaF835o7Ye/CIo7HmW4igtWl
         KfTANRZA2xfXOqUnknz1lffuDipWm7wySS6Ub/TW/DdpiRmP2zEH02d4qxiHWWXmSELO
         B9nEwzC1K00J3XpqbbKL9ov4XDLd5Mv0oZn7487IvvdbR219B7MvljhSXXIVMocEvaPq
         y0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iUi8PRt1C1hxriDLpqIJwYgJ7+Ti+qx1RIsoZc3JWOw=;
        b=sIVMGLLLRzaq0DMcaZVXEPHCSLjbE/hAnhCffenqQzfnpzUBdevZtCAWF6amk+tkoM
         8woFUJ/TILdUWobzXaAP1uXK2AzHAuFfFUJJ8eNvb06AMb6/uQx8EzqblLuQQBFlbiJH
         My+g0O10wUvR1rhMtOsDsKluoF8FUh0cz2Jl1ROY7xTWceo2sitlOMCfJxFuabWj4Nha
         zlV2wA89WiTJ56lPYdLtDGZO427X/XNIyZ18qR+PskzuWfy9q4661/ZMO8+awULWB8TS
         ZFKu2rD/zDanz5Scw2V3PIciWAQaObUfz6ycNOS6v7Db24dKiSzWdCwdK1MFJYcmGR9B
         K0Kg==
X-Gm-Message-State: AJIora8qnDaltO102qJ0DX/zCUwwyl3kmyG8+gO6AjBZr891HI8SLV9T
        Bx2TpZo24gvKgIOmfE2CNtw=
X-Google-Smtp-Source: AGRyM1slJBMDBsuNHpBj4n7MqHsIZaDLMAhmKyrXOce9iFdlI007tFK5W5uPJ8jNdY9haIjz73z1yA==
X-Received: by 2002:aa7:c45a:0:b0:435:d7a4:99bc with SMTP id n26-20020aa7c45a000000b00435d7a499bcmr17000932edr.158.1656343163248;
        Mon, 27 Jun 2022 08:19:23 -0700 (PDT)
Received: from felia.fritz.box (200116b826511b0021a0c74157938809.dip.versatel-1u1.de. [2001:16b8:2651:1b00:21a0:c741:5793:8809])
        by smtp.gmail.com with ESMTPSA id z8-20020a170906434800b00722f2a0944fsm5076901ejm.107.2022.06.27.08.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 08:19:22 -0700 (PDT)
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
Subject: [RFC PATCH 05/11] docs: admin: devices:  drop confusing outdated statement on Latex
Date:   Mon, 27 Jun 2022 17:18:13 +0200
Message-Id: <20220627151819.22694-6-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220627151819.22694-1-lukas.bulwahn@gmail.com>
References: <20220627151819.22694-1-lukas.bulwahn@gmail.com>
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

