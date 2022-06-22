Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B86555160
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358817AbiFVQjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiFVQjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:39:08 -0400
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8723135AAD;
        Wed, 22 Jun 2022 09:39:06 -0700 (PDT)
Received: by mail-pg1-f171.google.com with SMTP id q140so16567348pgq.6;
        Wed, 22 Jun 2022 09:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=kvH9tIFDBGzF2qqwqEbwZArTSprppY4/+ZltmbRD2YY=;
        b=RaWL/5kSJeK+vPk2VPAOsJ+1AkSbrSMv8rqLV46+OwdUgo5KTueZdH5npYBYHZgPIb
         RYL2U+xfJ+enjhcDgrlDNi0UGf0VDpBpkEpt6LkT0IyE0KIT75lZFlBbGrimPLTRmX+a
         yp38AZ7WnFHJzFCcosQ+czC3JB4kPbq4+4LF3NdgkTTEdO1sHUgKp8qtEfbPNv0mePAs
         zdwptqcXAufEihDcSH9KK24kW0MLr0ZlFMpS3KSioP9q96m3DvGL2RtQTrp01QLmILeP
         yJRAhtE5nZmwO+k77RqgAk6Qdq0PwsV774MSqAYymnnS2wjzzTyvM6MNEhO9wTF9RTux
         0xAw==
X-Gm-Message-State: AJIora9GqBNFzbtvX7BmbBrgQHko/x3L6LPIxJD9yjcvqw4Uh0iD92Xa
        +y1Ir8hhOlH2IY1yLYrjWgc=
X-Google-Smtp-Source: AGRyM1tiDa8CHLnECkxikPK9fTT0aLy9coDBf0pW7aC6otzSHNcUm2IPvFXPzE/NFAt3WeeYbZK/gQ==
X-Received: by 2002:a63:6943:0:b0:40c:3020:d0b with SMTP id e64-20020a636943000000b0040c30200d0bmr3701584pgc.34.1655915946090;
        Wed, 22 Jun 2022 09:39:06 -0700 (PDT)
Received: from karthik-strix-linux.karthek.com ([117.208.185.173])
        by smtp.gmail.com with ESMTPSA id d15-20020a63a70f000000b0040c762eb57esm9300449pgf.82.2022.06.22.09.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 09:39:05 -0700 (PDT)
Date:   Wed, 22 Jun 2022 22:09:00 +0530
From:   Karthik Alapati <mail@karthek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xu Wang <vulab@iscas.ac.cn>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: media/atomisp: use max() impl
Message-ID: <YrNFpF2qvTxpZP8e@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix a coccinelle warning by replacing opencoded max()
implementation with max()

WARNING opportunity for max()

Signed-off-by: Karthik Alapati <mail@karthek.com>
---
 drivers/staging/media/atomisp/pci/runtime/frame/src/frame.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/runtime/frame/src/frame.c b/drivers/staging/media/atomisp/pci/runtime/frame/src/frame.c
index a3aae638b0bf..0fa91628a463 100644
--- a/drivers/staging/media/atomisp/pci/runtime/frame/src/frame.c
+++ b/drivers/staging/media/atomisp/pci/runtime/frame/src/frame.c
@@ -460,10 +460,7 @@ void ia_css_frame_info_set_width(struct ia_css_frame_info *info,
 		IA_CSS_LEAVE_PRIVATE("");
 		return;
 	}
-	if (min_padded_width > width)
-		align = min_padded_width;
-	else
-		align = width;
+	align = max(min_padded_width, width);
 
 	info->res.width = width;
 	/* frames with a U and V plane of 8 bits per pixel need to have
-- 
2.36.1

