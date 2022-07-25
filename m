Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D928857FAB0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbiGYIAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbiGYIAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:00:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09F713D19;
        Mon, 25 Jul 2022 01:00:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66CC5B80E07;
        Mon, 25 Jul 2022 08:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0545C341CF;
        Mon, 25 Jul 2022 08:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658736001;
        bh=bEsGf8Dsd9YtmoSRkVmOvqodgZEJC62LZm2jA6Q/xow=;
        h=From:To:Cc:Subject:Date:From;
        b=FzftwkCl7SnTTxs7ziR8+GlhmXhTYRLjw8MG60JFbSOxSVYHKIEWmTL1Lrd7pEVx6
         XY+rK5/IeU205W1/X+iFgdtlk0RjVUBM7O48vKhHJadogtic+UfXMJGVeC1aeXJ9Fn
         5gshOdM2T/aW59n0FNbiNgVW5CysuMguTsjvlZuleVwdKE1l7ZuDD581tK5LP4kM7c
         x7d/rqxMnGTObudVKOIksXZcXt9MOFUTyX0KAAMrB4MsppFC/pVFtlNR00W+2VNkHJ
         hnxsFETOEEtYqJI10xl5MVfkt9z/6jFkIvA4im9KMYNSIOnTk8Ezkd7e2T3XPUp3Ir
         NO1k9Brx/p6bw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oFt0d-0000Jz-4J; Mon, 25 Jul 2022 10:00:11 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Yan Xinyu <sdlyyxy@bupt.edu.cn>, linux-staging@lists.linux.dev,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/7] USB: cdc: add control and state defines
Date:   Mon, 25 Jul 2022 09:58:34 +0200
Message-Id: <20220725075841.1187-1-johan@kernel.org>
X-Mailer: git-send-email 2.35.1
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

Several drivers use the control-line and serial-state bitmap values from
the CDC spec, but there were no matching defines in the global CDC
(UAPI) header.

This series adds the missing defines and converts cdc-acm and f_acm to
use them.

One staging driver also had an unused set of CDC defines which are
removed.

The final patch by Yan Xinyu, which triggered this work, converts the
usb_wwan driver to use CDC defines instead of hardcoded values in its
line-control handling.

Greg, are you ok with me taking these through USB serial (where there
are a few more drivers that could potentially use them) or do you want
to take the lot through your tree directly?

Johan


Johan Hovold (6):
  USB: cdc: add control-signal defines
  USB: cdc: add serial-state defines
  USB: cdc-acm: use CDC control-line defines
  USB: cdc-acm: use CDC serial-state defines
  staging: gdm724x: drop unused CDC defines
  USB: gadget: f_acm: use CDC defines

Yan Xinyu (1):
  USB: serial: usb_wwan: replace DTR/RTS magic numbers with macros

 drivers/staging/gdm724x/gdm_tty.c   |  6 -----
 drivers/usb/class/cdc-acm.c         | 42 ++++++++++++++---------------
 drivers/usb/class/cdc-acm.h         | 20 --------------
 drivers/usb/gadget/function/f_acm.c | 20 ++++----------
 drivers/usb/serial/usb_wwan.c       | 10 ++++---
 include/uapi/linux/usb/cdc.h        | 13 +++++++++
 6 files changed, 45 insertions(+), 66 deletions(-)

-- 
2.35.1

