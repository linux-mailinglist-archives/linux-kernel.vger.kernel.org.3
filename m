Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6FB49BBFD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 20:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiAYTVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 14:21:06 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34844 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiAYTTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 14:19:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09AFEB818C2;
        Tue, 25 Jan 2022 19:19:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118A1C340E0;
        Tue, 25 Jan 2022 19:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643138388;
        bh=uqDC31ymycx+13e+X3l+SfAMSoIqwEOmqiRflFpE9BU=;
        h=Date:From:To:Cc:Subject:From;
        b=QpP4AkUmRkqerJMgs8ED5wO7VPAKGbOijgtvDl3NIWOgj5RGh5ffI94Bom8wKoK9S
         9kWniWywjr/cB6ap88gI9oTBWmmEmWxiZCE+nct+1S8xzILN1jlYRPs6PDSnNDAd2U
         0gCSq7l333iz9/YRW806DcCUeYP1jLXtNGLmlqg1QY0OLolj+tEorYLfqtu914Da2L
         QSUxMS0AaXv0ESkdQfaFtiqawmr8U8AUKGGVGF9HYBS1smMOzTUPvyFnOUHkSaMPQm
         9+s/Fs/e2GuogoPSlkpurZVYsvoKpwBZZ+Yn2x/q1VO2BChocZhCpVdPAylWhfTz9P
         u6lMg0nR8ZBaQ==
Date:   Tue, 25 Jan 2022 13:26:34 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] extcon: usbc-cros-ec: Use struct_size() helper in
 kzalloc()
Message-ID: <20220125192634.GA70834@embeddedor>
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
drivers/extcon/extcon-usbc-cros-ec.c:71:23: warning: using sizeof on a flexible structure

Link: https://github.com/KSPP/linux/issues/174
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/extcon/extcon-usbc-cros-ec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-usbc-cros-ec.c b/drivers/extcon/extcon-usbc-cros-ec.c
index 5290cc2d19d9..fde1db62be0d 100644
--- a/drivers/extcon/extcon-usbc-cros-ec.c
+++ b/drivers/extcon/extcon-usbc-cros-ec.c
@@ -68,7 +68,7 @@ static int cros_ec_pd_command(struct cros_ec_extcon_info *info,
 	struct cros_ec_command *msg;
 	int ret;
 
-	msg = kzalloc(sizeof(*msg) + max(outsize, insize), GFP_KERNEL);
+	msg = kzalloc(struct_size(msg, data, max(outsize, insize)), GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
 
-- 
2.27.0

