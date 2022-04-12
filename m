Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4294FDE8D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbiDLLyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349398AbiDLLuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:50:55 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F44A5C672
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:36:35 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bh17so36415872ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4PcsMg+q67rUY+iwTUmqhjT1/lhzigUjVIV5oK/dKWQ=;
        b=MWjq2X3LXfOy9aWDfdMxrIpa3BKedC4klyMHBw3bmnWe7Tve27AEctjKwz5Nn6mPnz
         NeRaifIMQDGdTECwFcSVeSE0ZTtzfxfmFPKPXQI6TdZiiIZ8FU1GcLHC66r844TWfXNA
         2hNAM4SPO94hgWlIjWrQwPjOom4mCEoWh4XQ0qdyVN7gM/E2MYlKMXVP6Mpv2cdvIvaF
         yIBcKAe7O6Mah9lRRHG36sW6/8dbphjP5+4xqsPdtMpHMlPxWOyLDxya/pb7HCRhKGur
         UoycDElxIgfRUe2bfBKFieO35Ld1dTnLILjQWdIsdvmoIx+L6L5zOTr6MeUUXwolzkUk
         0aRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4PcsMg+q67rUY+iwTUmqhjT1/lhzigUjVIV5oK/dKWQ=;
        b=lWayFpz8OP5/xm3CTYoUeV8AD0VG2Qvsqwo0UNu5rO/J49XQTTI5j+IZejOJfkIieb
         hhIEgqz4QISsq6dytftaopArBM9bu9mB2VGZr5tpNaH4pKJM0XVma5UXZp8CE8lyLVPL
         Eij3ztEHp9F/bJ1RAZGsIbnAyzmyJlQ4sGEyZFmRIKsru1N/ky00NV7PqIv7as8exstb
         MZ8QaAZsnGRBbxfgfwnwKG3Ux6kgfGYzjmsUJ5pzMcfYdCURUkEJA8QMKjotKXbFwSHE
         81KHx1SoXD0UjgZKlRWnXaZ4i8IplY5pw0xeUXm0J+f5D7kmVvZAVArwsFVQBWppmsSb
         x/6g==
X-Gm-Message-State: AOAM530+ccVxaiTesNsdp5GtSHMgwE6GmpyJ/dC/Ia6dKOY6ektd3mk3
        c9VkTFGVPpJXflWI2s3oNOY=
X-Google-Smtp-Source: ABdhPJyWCclXWoRuMsc2m37Yrqt4HQVOqNDv7jXpsEhBrDVXdVN+L5thfGR7t3HzdtDEarE5Y0YpsQ==
X-Received: by 2002:a17:906:58d3:b0:6da:bdb2:2727 with SMTP id e19-20020a17090658d300b006dabdb22727mr33698192ejs.549.1649759793668;
        Tue, 12 Apr 2022 03:36:33 -0700 (PDT)
Received: from localhost.localdomain (host-82-60-208-254.retail.telecomitalia.it. [82.60.208.254])
        by smtp.gmail.com with ESMTPSA id o14-20020a170906774e00b006d5b915f27dsm13032798ejn.169.2022.04.12.03.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 03:36:32 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liu Junqi <liujunqi@pku.edu.cn>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        sparmaintainer@unisys.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2] MAINTAINERS: Remove D. Kershner from Unisys S-PAR maintainers
Date:   Tue, 12 Apr 2022 12:36:29 +0200
Message-Id: <20220412103629.8029-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The email address of David Kershner is no more reachable. Remove his
entry from the MAINTAINERS file for UNISYS S-PAR DRIVERS and change
the status to "Orphan".

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v1->v2: Change also the status of the entry to "Orphan" and rework the
commit message. (Thanks to Greg Kroah-Hartman).

 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3ed62dcd144e..9283c63565b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20184,9 +20184,8 @@ F:	include/linux/cdrom.h
 F:	include/uapi/linux/cdrom.h
 
 UNISYS S-PAR DRIVERS
-M:	David Kershner <david.kershner@unisys.com>
 L:	sparmaintainer@unisys.com (Unisys internal)
-S:	Supported
+S:	Orphan
 F:	drivers/staging/unisys/
 F:	drivers/visorbus/
 F:	include/linux/visorbus.h
-- 
2.34.1

