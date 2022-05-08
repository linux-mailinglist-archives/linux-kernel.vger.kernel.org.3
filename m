Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0637251F036
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiEHTfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbiEHTel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 15:34:41 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2452DDA8
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 12:29:57 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b19so16752196wrh.11
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 12:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9QFfIJ0zp70wh1r3yoFEFoWLM1BFKqSY/ZHhqFBuEHU=;
        b=K0B2dbK50dmNsQRADIawwixlc0oGeFyei7luQ72eUhwixypxD7XDnpB+5MCas5ERSL
         MagCpv6cGyCJmsdb2VOFklkryezDNP0miWtTEoAE9ATIagrv4AK4+0ytgQqUC0p8hzM/
         05RDoGQovT+ApFN48lVRi7RdQKXViVbRG6CsJMpN8ahlqcx6GPAm3kxWs+cD6fMGnZZj
         j8kXANGYE3rueiecDUId4qE2McsElMuuflrYK7LU5DtjfrB9A0Xuvyl6cUPfl9RHAXOc
         w/GD8b/rhNH1tptwNTRTdbgmRr016UR/jvkv8twd9AKR0uXTBu7ypGc6wfjhfDrS52Xl
         gduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9QFfIJ0zp70wh1r3yoFEFoWLM1BFKqSY/ZHhqFBuEHU=;
        b=hPVPi7ZetBVq7FgDLF+JlPQWHfEZ+h10zAQ/GXNClaJGF/fQZovi1/8uy5LEEL9NLb
         pjpOM3z7c18YvJR3WKbQTlZw92EquFKji2RtqSvI3AaKIqDb7miMhwW1+/KyAYlIfFnD
         ulEHdI/cgI+A/SkW8ywzf2YFh9Dun9/LUNRN3yI2rnEIMp24vXAvS1/t88Hc8dg6QrHK
         lYsDrHWPwtHFMIdgBnphbB+4Zz0lhAebHFP6ss+rjFkc9rzFt8EV+HHDteSkdMS/s5So
         oP+u+MWG3feDyKTify8RFsYf5tQMNH3NvbeUsDKxJIO24pjeMRN2TTZ1pbEkG/Sd2Lcu
         W8Tw==
X-Gm-Message-State: AOAM533geqlAQD99Wcmkfa2E/2/USFJq+IaB5+ax6w6R5cVYPOcXOM4q
        tw70jxm+wCaco1Fu3J7X1845khC5+RgEnA==
X-Google-Smtp-Source: ABdhPJzBhvpRzlaZ+zFniePfD11YbZVWuBlYVqhc6u53QLgiVzaD5tnNP1PQe2Ry12pW+OgxzDE/yw==
X-Received: by 2002:a5d:414a:0:b0:20a:d5f9:8b62 with SMTP id c10-20020a5d414a000000b0020ad5f98b62mr11303133wrq.492.1652038195747;
        Sun, 08 May 2022 12:29:55 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p200300c78f3ed42031f51b0dd5fb7060.dip0.t-ipconnect.de. [2003:c7:8f3e:d420:31f5:1b0d:d5fb:7060])
        by smtp.gmail.com with ESMTPSA id bv7-20020a0560001f0700b0020c5253d8d7sm8840402wrb.35.2022.05.08.12.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 12:29:55 -0700 (PDT)
Date:   Sun, 8 May 2022 21:29:53 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] staging: vt6655: Replace MACvStart with VNSvOutPortB
Message-ID: <d998305b4dec2827b0e13e49938e68a32517c487.1651957741.git.philipp.g.hortmann@gmail.com>
References: <cover.1651957741.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1651957741.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace macro MACvStart with VNSvOutPortB and as it
was the only user, it can now be removed.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/device_main.c | 3 ++-
 drivers/staging/vt6655/mac.h         | 4 ----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 4f26f5c7e84f..1ab7c1c3644d 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -406,7 +406,8 @@ static void device_init_registers(struct vnt_private *priv)
 	MACvReceive1(priv->port_offset);
 
 	/* start the adapter */
-	MACvStart(priv->port_offset);
+	VNSvOutPortB(priv->port_offset + MAC_REG_HOSTCR,
+		     (HOSTCR_MACEN | HOSTCR_RXON | HOSTCR_TXON));
 }
 
 static void device_print_info(struct vnt_private *priv)
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 5b684194745c..3a32a0146c85 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -605,10 +605,6 @@ do {								\
 	VNSvOutPortB(iobase + MAC_REG_PAGE1SEL, 0);		\
 } while (0)
 
-#define MACvStart(iobase)						\
-	VNSvOutPortB(iobase + MAC_REG_HOSTCR,				\
-		     (HOSTCR_MACEN | HOSTCR_RXON | HOSTCR_TXON))
-
 #define MACvRx0PerPktMode(iobase)					\
 	VNSvOutPortD(iobase + MAC_REG_RXDMACTL0, RX_PERPKT)
 
-- 
2.25.1

