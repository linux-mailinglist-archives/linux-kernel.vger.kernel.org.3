Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2A2530586
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 21:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350265AbiEVTsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 15:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiEVTst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 15:48:49 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B73C38BE9
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 12:48:47 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id gh17so11721326ejc.6
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 12:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c0kDX2w0usdtJZ1wjubssadkVa9RQCCYPM/2J54JHbU=;
        b=Zx+JfWo20KMaPBqsbs3SpMWK3e8JgYZeZkJ6cRLH2PdWs9omM9WN84HKnrNxAoMP+p
         X/C6xyowLMTB8LLHNCZlWpcdh7aikJJcWnN2aSqhxQEIsIlb7uvDo3PWSaKz3M3xuMnX
         ma7SxF6IU2pjYx9xD5OtGbi8fSAvTDEsiqLrVu00zcNAFoPtoTY8fRshyRzxNZklM+Kp
         bs7CWirKEMduEM1K3eBtLfRdSfRZt68Jnn+TxzQ31hzRJouINVZHNjN+dkvg0ye++vzg
         RUklCL7YYLa2xmpY3PYuyEc2ryKX/35L2KRmjQZAoZxjweaDwBxhOAggs3cQMMczqWhh
         LsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c0kDX2w0usdtJZ1wjubssadkVa9RQCCYPM/2J54JHbU=;
        b=30GyrZREJgGmcCngM8SR5PYX3/z5o1E0Ew4af2fqZVMkw7yyXU9w+rFly/4cnhN0LI
         dr8LA6DOsT7AI9Rlu+cNps+CGAkyQwubitEL3JicRls83pwf7JIXdsyd6KDjqDhHgveJ
         u2iZnsnIH/DDMxaH/98dHmM35G/W1mMXj9qYaDUYMjMTBFCBiQhIeyW4CsRwo1GplJjq
         AQ9CAKnXM39G0IVIdviowj1VuQXMpRRolRRDPQED8Nhr9RE7MeM1aJZ+P/9ddhOMGL1o
         b5fZeFZiycXHgWpLNcvhXBVyhghnpLMWUKPZthy5ix57TY7hX56aEmuHr60q60ISxZLa
         jflA==
X-Gm-Message-State: AOAM532HrUmF7dRDfhtT2yz36YBOcJtTe/bVwhMBMViUZshfZS/qxmz+
        /ZZllXu6c+YXDhr3dqrtL5q0wPe9Xe8=
X-Google-Smtp-Source: ABdhPJxmWErdjdV8qfgsfdFM33uNPONcPlWXYRfVcUQcBUVa3xbGAwA2MHBZP4HfxL6lR5nrfX6XWQ==
X-Received: by 2002:a17:907:94cd:b0:6fe:a2ae:a696 with SMTP id dn13-20020a17090794cd00b006fea2aea696mr13129035ejc.656.1653248925573;
        Sun, 22 May 2022 12:48:45 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935774.dip0.t-ipconnect.de. [87.147.87.116])
        by smtp.gmail.com with ESMTPSA id n20-20020a509354000000b0042aa23fa93bsm7523895eda.20.2022.05.22.12.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 12:48:45 -0700 (PDT)
Date:   Sun, 22 May 2022 21:48:43 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] staging: vt6655: Replace MACvSetCurrBCNLength with
 VNSvOutPortW
Message-ID: <8ff556c84b3a4a70e8151965bcf6357e1de61bd1.1653203927.git.philipp.g.hortmann@gmail.com>
References: <cover.1653203927.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1653203927.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace macro MACvSetCurrBCNLength with VNSvOutPortW and as it
was the only user, it can now be removed.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/mac.h  | 5 -----
 drivers/staging/vt6655/rxtx.c | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 57ae3bdbdb2d..23ebae99e0ae 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -570,11 +570,6 @@ do {									\
 	VNSvOutPortD(iobase + MAC_REG_BCNDMAPTR,		\
 		     dwCurrDescAddr)
 
-/* set the chip with current BCN length */
-#define MACvSetCurrBCNLength(iobase, wCurrBCNLength)		\
-	VNSvOutPortW(iobase + MAC_REG_BCNDMACTL + 2,		\
-		     wCurrBCNLength)
-
 #define MACvWriteBSSIDAddress(iobase, pbyEtherAddr)		\
 do {								\
 	iowrite8(1, iobase + MAC_REG_PAGE1SEL);			\
diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 71cbfa607d96..54b0556f500f 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -1422,7 +1422,7 @@ static int vnt_beacon_xmit(struct vnt_private *priv,
 
 	MACvSetCurrBCNTxDescAddr(priv->port_offset, priv->tx_beacon_dma);
 
-	MACvSetCurrBCNLength(priv->port_offset, priv->wBCNBufLen);
+	VNSvOutPortW(priv->port_offset + MAC_REG_BCNDMACTL + 2, priv->wBCNBufLen);
 	/* Set auto Transmit on */
 	MACvRegBitsOn(priv->port_offset, MAC_REG_TCR, TCR_AUTOBCNTX);
 	/* Poll Transmit the adapter */
-- 
2.25.1

