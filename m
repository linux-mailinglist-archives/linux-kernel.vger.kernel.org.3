Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F114A700E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343948AbiBBLgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343860AbiBBLgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:36:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79507C06173B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 03:36:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05B81B83091
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 11:36:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A958CC340E4;
        Wed,  2 Feb 2022 11:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643801767;
        bh=VuV5fpBatcVQSnnj4klzi06+IGvxAlBN/tidRdh2Omo=;
        h=From:To:Cc:Subject:Date:From;
        b=ivi2c6YeVPnjyA3frWcRmlgkNcOR/h9DPPZJB0X5UpLiUwIzDdOJyq7g+8BytP7rC
         5O2dVCwSxdUHZt14OQBHOBQ/tK4W6KkBCc6Lh3iK3GEnIsN6hY9o8N+wDUp15VoeIP
         X/e0HckJ1TL5HZ/pAoeyoEoRLuXMcK/e9wpZcC74rvl6apMwBooc3/UsQ8aC2wuuOL
         ur0u/POaFQhk6KLqV5P/+Wu/kILE8iUJtDtvM8+7b6PJxQtVhWd5EeY8flim/9tPxZ
         4nkMoF3JQdhFsVZDlwCRv10UlkD5YzZlGntxgyQ4oC68Zn6dxMKinhjhxSCroYY/RK
         9OpC8mIkPFEtg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nFDvT-0000Lv-4R; Wed, 02 Feb 2022 12:35:51 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Mitchell Tasman <tasman@leaflabs.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] greybus: svc: fix hello processing
Date:   Wed,  2 Feb 2022 12:33:44 +0100
Message-Id: <20220202113347.1288-1-johan@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan found and fixed a bug in the SVC HELLO request error handling which
was introduced when adding a temporary hack to reconfigure the link at
HELLO.

The implementation of the hack abuses the deferred-request processing
mechanism to send the link-configuration request, which makes the
HELLO processing a bit hard to follow.

The last two patches attempt to remedy this.

This could go into either 5.17-rc or -next.

Johan


Dan Carpenter (1):
  greybus: svc: fix an error handling bug in gb_svc_hello()

Johan Hovold (2):
  greybus: svc: clean up hello error path
  greybus: svc: clean up link configuration hack at hello

 drivers/greybus/svc.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

-- 
2.34.1

