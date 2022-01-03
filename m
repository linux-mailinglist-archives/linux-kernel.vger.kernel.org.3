Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED76483762
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbiACTIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235986AbiACTIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:08:45 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754C4C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:08:45 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id j6so139296798edw.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y2saZdtsDQ+rJsaXPQDxkl7huOB4aOMJMDco+QMBneA=;
        b=YDAvLJikdJ+gHcfk3XdNZ5E3rAVWIqAWMJlJsHkd7Au4Owjtjo0Du0lazZnsZXwz9c
         2TnPnZnxjR0e4xNBDPqOuElJg/RAGtDpx0x5W0Ta24yCD08tR5+jaPFiDAYilQKdyMFM
         OFwisKgfwLbFLwBeYtGXdNB8xkoc8tIpp6P35S3ygISD84dy/+hZz/gq3V80lnDvzvW0
         sYu+dHci8yyOkPEVt0IUX9QN5D77g1rKA1lfdDJ2Ss58+kg0hVv9v2vvsYDpyq2NPksh
         l7iDymy4Mm9bhw/DaUAqpQxv+auPl4Iyh3Epa0vBcmnma/i+kiI0JXlvP56tATEi3xJM
         IPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y2saZdtsDQ+rJsaXPQDxkl7huOB4aOMJMDco+QMBneA=;
        b=5gfX3bYV0myNjaz2dZmKGEDWbDeczlZicXOy9EoWfDeTkOXdlMCgABBZxQXXN6vdpN
         GQ7LTrG4KsHpwqmlJV/5IayPW9vIRgV3Pjr0Snjt5C8D9S1IMQc52s69OtjNNzWyDSjV
         9UbevCjiDnE/rOKDjFMamyx672TBzHNGGZ9CDC43hJ0PQtXJ6tlODvXGEIb3FEYZ13bo
         j+idMDWO2/clngmoLqo2fdUTn/ImtppwKX2SEH3SwVFoahRScLKfyCg9XpSmiZosSv3u
         HylyyEnHhjKYylfJ0Jx2wTPNMgzP2qchBNCWnjpFzUPEtCWhvVtAcQfDKZM4gwnKdiBe
         BaeQ==
X-Gm-Message-State: AOAM533yYghg30nF5XIEu3X5h3amO8aMq7Tdr3jHRt+NrPC8+3uxQ9Ji
        2JY5z1TqWC9r3popfyzGINM2YbQKYcA=
X-Google-Smtp-Source: ABdhPJzg+2i7o0qKMomu0HVSa+TguGR55F9HFCxxexEE4BKfpRI+0yEhWBjpgIjdWVCmXLvTd3O9HA==
X-Received: by 2002:a05:6402:5216:: with SMTP id s22mr41592533edd.394.1641236924110;
        Mon, 03 Jan 2022 11:08:44 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:08:43 -0800 (PST)
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc:     alb3rt0.m3rciai@gmail.com, linuxfancy@googlegroups.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Ivan Safonov <insafonov@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zameer Manji <zmanji@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/56] staging: r8188eu: add parenthesis to macro SetFrDs
Date:   Mon,  3 Jan 2022 20:01:39 +0100
Message-Id: <20220103190326.363960-5-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enclose in parenthesis complex macro SetFrDs

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/include/wifi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 487a4b7eafd6..07195a11aa78 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -169,7 +169,7 @@ enum WIFI_REG_DOMAIN {
 #define GetToDs(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_TO_DS_)) != 0)
 
 #define SetFrDs(pbuf)	\
-	*(__le16 *)(pbuf) |= cpu_to_le16(_FROM_DS_)
+	(*(__le16 *)(pbuf) |= cpu_to_le16(_FROM_DS_))
 
 #define GetFrDs(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_FROM_DS_)) != 0)
 
-- 
2.25.1

