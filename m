Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F0F49BF77
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 00:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbiAYXSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 18:18:41 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36928 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbiAYXSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 18:18:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8244B61245;
        Tue, 25 Jan 2022 23:18:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65519C340E0;
        Tue, 25 Jan 2022 23:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643152718;
        bh=n1VEybndR/BWFpxIeiPPk6LEiEOujbaxi3aCa0daOV8=;
        h=Date:From:To:Cc:Subject:From;
        b=Mld1rJjAY78xN8cu5NzxFFchzV9a/lwE7wdYoBu6ssbzzZ8KbSx3CnWtnBCQ+X/xN
         mCb5LjTEdH5R78XdzxqYZCEBFEpsJtB6CNpfG185UBd3l88XYoaGF7nVnrZMCF4QXO
         azr0jLX6QMH9mGz7QcqUFz1Wo/Bbunv8fPSapv+xIsJugNa8iBe0VRZH6CJIj7WyZu
         kJQ51XcoyUoYJUpi9h/5ab4Uw/7COTAj8rplX/MqywdR7wH7s70sDNtYwA1d2TASOH
         9hdDazjO3IPPMhO7iDhm+gb0DJLvKDZjwA5uTbPybWXrYPL4OlzrDla+acUpIqsvAP
         hySYIi3bM0mLg==
Date:   Tue, 25 Jan 2022 17:25:25 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] comedi: das16: Use struct_size() helper in
 comedi_alloc_spriv()
Message-ID: <20220125232525.GA80228@embeddedor>
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
drivers/comedi/drivers/das16.c:964:45: warning: using sizeof on a flexible structure
drivers/comedi/drivers/das16.c:998:45: warning: using sizeof on a flexible structure

Link: https://github.com/KSPP/linux/issues/174
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/comedi/drivers/das16.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/comedi/drivers/das16.c b/drivers/comedi/drivers/das16.c
index 937a69ce0977..728dc02156c8 100644
--- a/drivers/comedi/drivers/das16.c
+++ b/drivers/comedi/drivers/das16.c
@@ -961,7 +961,7 @@ static const struct comedi_lrange *das16_ai_range(struct comedi_device *dev,
 
 		/* allocate single-range range table */
 		lrange = comedi_alloc_spriv(s,
-					    sizeof(*lrange) + sizeof(*krange));
+					    struct_size(lrange, range, 1));
 		if (!lrange)
 			return &range_unknown;
 
@@ -995,7 +995,7 @@ static const struct comedi_lrange *das16_ao_range(struct comedi_device *dev,
 
 		/* allocate single-range range table */
 		lrange = comedi_alloc_spriv(s,
-					    sizeof(*lrange) + sizeof(*krange));
+					    struct_size(lrange, range, 1));
 		if (!lrange)
 			return &range_unknown;
 
-- 
2.27.0

