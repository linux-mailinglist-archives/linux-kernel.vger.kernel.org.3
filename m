Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9304CD79A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240266AbiCDPX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240222AbiCDPXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:23:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DDD3880;
        Fri,  4 Mar 2022 07:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=QIlhvxTHHS/nanVwwxtHal6Wu98/SCmslE6BWXHduno=; b=X6qLG+ac8+En9eKNFpe+lA8tfA
        tgakWYuk8MeZZ7sI7+z0NuZXZ2XrIQu+i4DdINWK9aD+TIDms/Dg59lB2yGMx8GtCx3ug/okC3Ghf
        VFr9vCOdMpVwcyE3LExAIPfk8E8FwW5wncTwJx9Blm25+Qd/mEuTa0/11QDR3r8pBIK+kQwPD7TGS
        ZnS6KGd15FNfofasKdHqPsDl8ePIlPqC9QFxYj+MSWFv1mzlVmNTbd+F0sjJ4BUC7zq/8y8BV7RMY
        Ln74b7DK8Lpad8CIxczhTNSx5xCCOVGR3TFcQHg+Dfkbhs0G/Sr4fq8ebkFjxah2XV9yFKQtRmWMk
        UxFbVk9w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQ9l3-00Cjnd-UU; Fri, 04 Mar 2022 15:22:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 88433300472;
        Fri,  4 Mar 2022 16:22:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7111E2C546F85; Fri,  4 Mar 2022 16:22:17 +0100 (CET)
Message-ID: <20220304152136.035911620@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 04 Mar 2022 16:19:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, mathias.nyman@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        rdunlap@infradead.org, linux-usb@vger.kernel.org
Subject: [PATCH 3/3] usb: early: xhci-dbc: Fix xdbc number parsing
References: <20220304151953.830111479@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kstrtoul() assumes the string contains the number only and is \0
terminated, this is not the case, as such things like:

	earlyprintk=xdbc1,keep

go completely sideways. Use simple_strtoul() instead.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/usb/early/xhci-dbc.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/usb/early/xhci-dbc.c
+++ b/drivers/usb/early/xhci-dbc.c
@@ -603,6 +603,7 @@ int __init early_xdbc_parse_parameter(ch
 {
 	unsigned long dbgp_num = 0;
 	u32 bus, dev, func, offset;
+	char *e;
 	int ret;
 
 	if (!early_pci_allowed())
@@ -613,8 +614,11 @@ int __init early_xdbc_parse_parameter(ch
 	if (xdbc.xdbc_reg)
 		return 0;
 
-	if (*s && kstrtoul(s, 0, &dbgp_num))
-		dbgp_num = 0;
+	if (*s) {
+	       dbgp_num = simple_strtoul(s, &e, 10);
+	       if (s == e)
+		       dbgp_num = 0;
+	}
 
 	pr_notice("dbgp_num: %lu\n", dbgp_num);
 


