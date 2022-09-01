Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC125A995F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbiIANrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiIANrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:47:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6398B4BB;
        Thu,  1 Sep 2022 06:47:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98BC0B82639;
        Thu,  1 Sep 2022 13:47:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33E3C433C1;
        Thu,  1 Sep 2022 13:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662040069;
        bh=vuVIZawZ9Wnxn37Lh9V1DnkOYn/crY5zCr59oWUarXI=;
        h=From:To:Cc:Subject:Date:From;
        b=wn9j/Jcfpel6MEfsiKPgtOboixHcXMPg2TjtR28J4Mu+znvkuJ0hCL8DiD31odUoV
         tmLAFs4raZsWv/EEdv1V/u9+9u3yOXUkwUVGGq2PGhApgRHfs87eHuDz3S/eB+yk1I
         rXFJhKSHOpSYzq2viFBhlZmDQruLCAzmZCo5QaP8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     mathias.nyman@intel.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: xhci: make xhci_get_endpoint_address static
Date:   Thu,  1 Sep 2022 15:47:44 +0200
Message-Id: <20220901134744.2039891-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1743; i=gregkh@linuxfoundation.org; h=from:subject; bh=vuVIZawZ9Wnxn37Lh9V1DnkOYn/crY5zCr59oWUarXI=; b=owGbwMvMwCRo6H6F97bub03G02pJDMkC2/+Fb30h7vVIzSP8o/aDZwIur9scExVdTS/sFJnEcuji A7kbHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRQ4kM86zUlqe1zNzedFph/0q/XQ J7p7x6O51hrkT/Cr6mSTOvsc0V1Gx22lS1+tjZywA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is only called in the xhci.c file, so make the symbol static.

Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci.c | 2 +-
 drivers/usb/host/xhci.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 65858f607437..7a854ce7cc62 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1491,7 +1491,7 @@ EXPORT_SYMBOL_GPL(xhci_get_endpoint_index);
 /* The reverse operation to xhci_get_endpoint_index. Calculate the USB endpoint
  * address from the XHCI endpoint index.
  */
-unsigned int xhci_get_endpoint_address(unsigned int ep_index)
+static unsigned int xhci_get_endpoint_address(unsigned int ep_index)
 {
 	unsigned int number = DIV_ROUND_UP(ep_index, 2);
 	unsigned int direction = ep_index % 2 ? USB_DIR_OUT : USB_DIR_IN;
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 1960b47acfb2..5b110b78db60 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -2041,7 +2041,6 @@ int xhci_setup_addressable_virt_dev(struct xhci_hcd *xhci, struct usb_device *ud
 void xhci_copy_ep0_dequeue_into_input_ctx(struct xhci_hcd *xhci,
 		struct usb_device *udev);
 unsigned int xhci_get_endpoint_index(struct usb_endpoint_descriptor *desc);
-unsigned int xhci_get_endpoint_address(unsigned int ep_index);
 unsigned int xhci_last_valid_endpoint(u32 added_ctxs);
 void xhci_endpoint_zero(struct xhci_hcd *xhci, struct xhci_virt_device *virt_dev, struct usb_host_endpoint *ep);
 void xhci_update_tt_active_eps(struct xhci_hcd *xhci,
-- 
2.37.3

