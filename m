Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49AC4A6EDF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237446AbiBBKlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiBBKlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:41:01 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7E0C061714;
        Wed,  2 Feb 2022 02:41:01 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id i132so47479wma.1;
        Wed, 02 Feb 2022 02:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kroW8T87ODh2aoNqqwf6ZNFEi9qAb1WRvnyNc4fg4XE=;
        b=N4c/iBWEAtqS3U7P8xZFi+tlzeZJLjGcNeZgbo6ADkEGv0MuD5TqNilOphkGQBDE6w
         dLXZrSjBAcik0hXhEKYkev0NeQpVBk5P5XPeqYszZwDKRrn6218+vLbZwQaURPxFDNsm
         N/IErhS+glWd3lPjW3Sfo+P0/8KfW8sA0cn+EIoNaE5LKEh2mFDP5oDBUcZG422foTM1
         2dFTNKgVK/xMuDWOg4yri5kgwH1vYpd7xLiqe1HSDRnHlvTgqCL9/OQIYYUUnyntpr5v
         0RsdWQO66ivewIUyleRzW7mnNmKDZp5y5jUcAg9T/edLigNYhNheiMJRVLLa87D/ZA04
         KYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kroW8T87ODh2aoNqqwf6ZNFEi9qAb1WRvnyNc4fg4XE=;
        b=0Bstl8tupLdxFf95xLuUcZwxjSSUhc66Ut4eoXaSNhl1YiCpA6IrWvDbsNqGY3xxgk
         CzHOet4mBxTLDtGYmHi/GinggCucwxxxAOtv5CRlsnhyaCyz3LP6EIBMfqIYyk+X2SX6
         n1ubmnMizx8tvgWxPEgMZRyFYcf2uBQ5wcqrnWmhZzPy6KodyO+5ydkze3DyL/QJMnzp
         zMa1a68uotW2EgZB/SIGI7z0HEW62cb7XAwkqJaLN4ppY214xuOfe3rtdBeFs/SCCFVl
         g8ryah4hUKrCrSo435pdBAAC7F8uH6HJE7SvPWTMWP2oJjmirAKfCgmYzMj7eK4YnNKP
         qxlQ==
X-Gm-Message-State: AOAM530Skwqsr2oUR+H4brIsFhaJiU9Z4wijV4CgbcqRHhDUjowsU8aR
        L5ZoEbX3OQ8OOFWSN8Rm5Jw=
X-Google-Smtp-Source: ABdhPJx7p4wOpsEBAPYzyrvAoma6a4T+0aDPLPPoyIX1M+383SaQQ4szMhJ31g7lvB33K8d1J9W9Kw==
X-Received: by 2002:a05:600c:364f:: with SMTP id y15mr5611580wmq.125.1643798459967;
        Wed, 02 Feb 2022 02:40:59 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id 1sm20324550wry.52.2022.02.02.02.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 02:40:59 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pawel Laszczak <pawell@cadence.com>, linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel.hofman@ivitera.com
Subject: [PATCH][next][V2] usb: gadget: f_uac2: change maxpctksize/maxpcktsize to wMaxPacketSize
Date:   Wed,  2 Feb 2022 10:40:58 +0000
Message-Id: <20220202104058.590312-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spelling of maxpctksize and maxpcktsize is inconsistent, rename them
both to wMaxPacketSize instead.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
V2: change both strings to wMaxPacketSize
---
 drivers/usb/gadget/function/f_uac2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index f2237bcdba7c..2bc63e577b3b 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -755,11 +755,11 @@ static int set_ep_max_packet_size_bint(struct device *dev, const struct f_uac2_o
 
 	if (max_size_bw <= max_size_ep)
 		dev_dbg(dev,
-			"%s %s: Would use maxpctksize %d and bInterval %d\n",
+			"%s %s: Would use wMaxPacketSize %d and bInterval %d\n",
 			speed_names[speed], dir, max_size_bw, bint);
 	else {
 		dev_warn(dev,
-			"%s %s: Req. maxpcktsize %d at bInterval %d > max ISOC %d, may drop data!\n",
+			"%s %s: Req. wMaxPacketSize %d at bInterval %d > max ISOC %d, may drop data!\n",
 			speed_names[speed], dir, max_size_bw, bint, max_size_ep);
 		max_size_bw = max_size_ep;
 	}
-- 
2.34.1

