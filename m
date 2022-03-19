Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF144DE6FE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 09:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242485AbiCSIYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 04:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbiCSIYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 04:24:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF7DB91A4;
        Sat, 19 Mar 2022 01:22:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ACCE4B80123;
        Sat, 19 Mar 2022 08:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21ECC340EC;
        Sat, 19 Mar 2022 08:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647678176;
        bh=DvlVI+fRtqJ5Nex75pvCEOziwgTL6bOpeX1iGWCgsGA=;
        h=Date:From:To:Cc:Subject:From;
        b=Fb2yAvJaoyfFdJDrktjdmfOR1L9Af9UWwo7NTIsd7nm+QPx19uuESlrb7MBtm4Jp1
         xIJ4pysYZEbyzcW6Yoo7s4+tEUwmL4JTiiu6jAFTyvs+HOMY1lwL4f/yj9/jpN//1G
         EgfnKhFc0LCcMpgnEEiJe1pe2mpvkV83gzWNNcX4=
Date:   Sat, 19 Mar 2022 09:22:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 5.17-final
Message-ID: <YjWS3CaN65nJNHEj@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3:

  Linux 5.17-rc6 (2022-02-27 14:36:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.17-final

for you to fetch changes up to 16b1941eac2bd499f065a6739a40ce0011a3d740:

  usb: gadget: Fix use-after-free bug by not setting udc->dev.driver (2022-03-15 18:46:01 +0100)

----------------------------------------------------------------
USB fixes for 5.17

Here are some small remaining USB fixes for 5.17-final.

They include:
	- two USB gadget driver fixes for reported problems
	- usbtmc driver fix for syzbot found issues
	- musb patch partial revert to resolve a reported regression.

All of these have been in linux-next this week with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (2):
      usb: usbtmc: Fix bug in pipe direction for control transfers
      usb: gadget: Fix use-after-free bug by not setting udc->dev.driver

Dan Carpenter (1):
      usb: gadget: rndis: prevent integer overflow in rndis_set_response()

H. Nikolaus Schaller (1):
      partially Revert "usb: musb: Set the DT node on the child device"

 drivers/usb/class/usbtmc.c          | 13 ++++++++++---
 drivers/usb/gadget/function/rndis.c |  1 +
 drivers/usb/gadget/udc/core.c       |  3 ---
 drivers/usb/musb/omap2430.c         |  1 -
 4 files changed, 11 insertions(+), 7 deletions(-)
