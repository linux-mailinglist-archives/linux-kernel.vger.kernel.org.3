Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126AC58901F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 18:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236779AbiHCQYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 12:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbiHCQYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 12:24:38 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476A12A276;
        Wed,  3 Aug 2022 09:24:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A7AD3CE23C6;
        Wed,  3 Aug 2022 16:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD03C433D6;
        Wed,  3 Aug 2022 16:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659543873;
        bh=xGHHD9/3TQpqNCp6NqNDfgu8k1f28r0DEMxhdQ88hOI=;
        h=From:To:Cc:Subject:Date:From;
        b=oITW05rFffyqdh7e6veJZcEZfV1CIVOUxJWMZFFKDvFdPoUziqnVn//ysYqGp/WQ5
         wCmKTz88cTXDKXSA0ksMruU06mWXKKUmpZKl+z8fmLTX37H1HuOkiYI6IX2pcCBnUi
         hOZ+h43ZRTHeSLTXGPrnVa/pBQ/KDKjb3KiC3TKVG0/RDncJdvqCTA/Zpdm/yhEQ/x
         eNQKJJi57GkmY2nErxiL3dBnVwJiRVf4sxUUdpfnNQ0YP1wRC2uldHhXN8KDg2nXF4
         6/89YFggI0uNNW0QisvotjQNrsK6dgaOUthGyb2lx52KsECK6SGIJKaUhnSVMvUxwx
         6DGibLvAfkJgg==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Andrey Strachuk <strochuk@ispras.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] usb: cdns3: Don't use priv_dev uninitialized in cdns3_gadget_ep_enable()
Date:   Wed,  3 Aug 2022 09:24:22 -0700
Message-Id: <20220803162422.2981308-1-nathan@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

  drivers/usb/cdns3/cdns3-gadget.c:2290:11: error: variable 'priv_dev' is uninitialized when used here [-Werror,-Wuninitialized]
                  dev_dbg(priv_dev->dev, "usbss: invalid parameters\n");
                          ^~~~~~~~
  include/linux/dev_printk.h:155:18: note: expanded from macro 'dev_dbg'
          dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
                          ^~~
  include/linux/dynamic_debug.h:167:7: note: expanded from macro 'dynamic_dev_dbg'
                          dev, fmt, ##__VA_ARGS__)
                          ^~~
  include/linux/dynamic_debug.h:152:56: note: expanded from macro '_dynamic_func_call'
          __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
                                                              ^~~~~~~~~~~
  include/linux/dynamic_debug.h:134:15: note: expanded from macro '__dynamic_func_call'
                  func(&id, ##__VA_ARGS__);               \
                              ^~~~~~~~~~~
  drivers/usb/cdns3/cdns3-gadget.c:2278:31: note: initialize the variable 'priv_dev' to silence this warning
          struct cdns3_device *priv_dev;
                                      ^
                                      = NULL
  1 error generated.

The priv_dev assignment was moved below the if statement to avoid
potentially dereferencing ep before it was checked but priv_dev is used
in the dev_dbg() call.

To fix this, move the priv_dev and comp_desc assignments back to their
original spot and hoist the ep check above those assignments with a call
to pr_debug() instead of dev_dbg().

Fixes: c3ffc9c4ca44 ("usb: cdns3: change place of 'priv_ep' assignment in cdns3_gadget_ep_dequeue(), cdns3_gadget_ep_enable()")
Link: https://github.com/ClangBuiltLinux/linux/issues/1680
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/usb/cdns3/cdns3-gadget.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 9ac7d0a8c5da..d21b69997e75 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -2284,16 +2284,20 @@ static int cdns3_gadget_ep_enable(struct usb_ep *ep,
 	int ret = 0;
 	int val;
 
+	if (!ep) {
+		pr_debug("usbss: ep not configured?\n");
+		return -EINVAL;
+	}
+
 	priv_ep = ep_to_cdns3_ep(ep);
+	priv_dev = priv_ep->cdns3_dev;
+	comp_desc = priv_ep->endpoint.comp_desc;
 
-	if (!ep || !desc || desc->bDescriptorType != USB_DT_ENDPOINT) {
+	if (!desc || desc->bDescriptorType != USB_DT_ENDPOINT) {
 		dev_dbg(priv_dev->dev, "usbss: invalid parameters\n");
 		return -EINVAL;
 	}
 
-	comp_desc = priv_ep->endpoint.comp_desc;
-	priv_dev = priv_ep->cdns3_dev;
-
 	if (!desc->wMaxPacketSize) {
 		dev_err(priv_dev->dev, "usbss: missing wMaxPacketSize\n");
 		return -EINVAL;

base-commit: 8288c99fc263bcafc5df5fa8c278b2eb8106364e
-- 
2.37.1

