Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A3E4945A9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 02:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358130AbiATBzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 20:55:24 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46728 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbiATBzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 20:55:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BFD3DB81C97;
        Thu, 20 Jan 2022 01:55:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53833C004E1;
        Thu, 20 Jan 2022 01:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642643720;
        bh=UBA9EAgXb+ndoEEnlylpF1zO8z2g96V3hPj15HRcAfo=;
        h=Date:From:To:Cc:Subject:From;
        b=hTAD6NZzQUZRVWlrg08cB/oSXOrRYxSxV43MFikx9DTJBxdy2ucAbg84idFWkdNRV
         B/RDhzWSaiRnbsCVaoksK6xFGqjGYypV3fgghZqQ8a3pV+b3yM3C3odylOF+l5UT8P
         3I31vwTMa9reYVdt0tVbUKM6tXyDkgcuhE/Lahh6VX/WId8kWRRsAwUQYRCWiFa9IN
         g1DuJawcjB8ViBxapaF4dYorah58Z9hSOtigQWJ/rIjYVtPHoz/Y2/LyF4b0b8aPyI
         X3Cegww/ufVf8wgpbvKbHT0QanEPrE/oVOY71G75SRvz5PL2pmtUmvEjAp5fcHnooN
         545XOG3Iz5T2g==
Date:   Wed, 19 Jan 2022 20:01:55 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] usb: gadget: f_phonet: Use struct_size() helper in
 kzalloc()
Message-ID: <20220120020155.GA76981@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version,
in order to avoid any potential type mistakes or integer overflows that,
in the worst scenario, could lead to heap overflows.

Also, address the following sparse warnings:
drivers/usb/gadget/function/f_phonet.c:673:16: warning: using sizeof on a flexible structure

Link: https://github.com/KSPP/linux/issues/160
Link: https://github.com/KSPP/linux/issues/174
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/usb/gadget/function/f_phonet.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/function/f_phonet.c b/drivers/usb/gadget/function/f_phonet.c
index 068ed8417e5a..0bebbdf3f213 100644
--- a/drivers/usb/gadget/function/f_phonet.c
+++ b/drivers/usb/gadget/function/f_phonet.c
@@ -668,10 +668,8 @@ static struct usb_function *phonet_alloc(struct usb_function_instance *fi)
 {
 	struct f_phonet *fp;
 	struct f_phonet_opts *opts;
-	int size;
 
-	size = sizeof(*fp) + (phonet_rxq_size * sizeof(struct usb_request *));
-	fp = kzalloc(size, GFP_KERNEL);
+	fp = kzalloc(struct_size(fp, out_reqv, phonet_rxq_size), GFP_KERNEL);
 	if (!fp)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.27.0

