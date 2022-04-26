Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69F25100E4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351705AbiDZOw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiDZOwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:52:53 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E10540919;
        Tue, 26 Apr 2022 07:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650984586; x=1682520586;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x2r0qf7CGW3qQKUKivRGC90kHdh3Fn98vNeYvhJ7UX8=;
  b=GaPTq95Ichjp098Mgyn2K3oRhpOtggbj7g6MZIint+bYG/5Y8wZwNZEG
   WvxzKEGoSx+buZgp9ERqhWT4rYvwQa2GEi9o9UyE7+pA6isR4X3og+TN4
   RufRvJ45Wfz0BHwpDvV2r5PhFUKdsW+SyO4BvGo4ZWXHNTvmZO5oDlNMe
   QQNFAr/FpR8kZ0lVb8EULBloUm77H5U1PNpOLnaTgJfTy+EBi9xd0mG63
   oYiqnqzRO/bCPERwfBNtUxENYHj6g/nUxnFMyZbpcaLGoWmluqH7buHjK
   E1OsD4z1aIDnFQFT+Ch/Ug8/o68iiojiaKgbJfrEmuAyOVLYhqvFUxT/a
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="352040392"
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="352040392"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 07:49:45 -0700
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="579932919"
Received: from mmilkovx-mobl.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.47.245])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 07:49:43 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Gilles Buloz <gilles.buloz@kontron.com>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 0/3] tty/serial: Process XON/XOFF robustly
Date:   Tue, 26 Apr 2022 17:49:32 +0300
Message-Id: <20220426144935.54893-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For this v4, I dropped Gilles' Tested-by as I made rather major
modifications to the patch series so I don't want to claim he has
tested this version (earlier versions are known to fix his problem and
this one should too).

XON/XOFF are used for software flow-control on serial lines. XON and
XOFF appear as characters within the stream but should be processed as
soon as possible.

The characters received by the UART drivers are in intermediate buffers
until TTY receives them. In the case where the TTY is not read from,
the characters may get stuck into those intermediate buffers until
user-space reads from the TTY. Among the characters stuck in the
buffers, can also be those XON/XOFF flow control characters. A stuck
flow-control character is not very useful.

This patch series addresses the issue by checking if TTY is slow to
process characters, that is, eats less than the given amount. If TTY is
slow, a lookahead is invoked for the characters that remain in the
intermediate buffer(s).

Then at a later time, receive_buf needs to ensure the flow-control
actions are not retaken when those same characters get pushed to TTY.

This patch series fixes an issue but I'm not able to pinpoint to a
specific commit id to provide a Fixes tag. The last patch of the series
is not needed for minimal fix (and has a small chance of regression
too), thus that patch shouldn't be sent to stable.

v1 -> v2:
- Add flow ctrl char funcs in separate change & rework logic a bit.
  I believe it's now cleaner than it would have been with the
  suggestions during v1 review, please recheck.
- Renamed n_tty_lookahead_special to n_tty_lookahead_flow_ctrl
- Fixed logic for START_CHAR == STOP_CHAR case
- Use unsigned int for lookahead_count in receive_buf call chain
- Use consistent types in lookahead call chain
- Improved indentation & line splits for function params
- Corrected tty_ldisc.h comments documenting tty_ldisc_ops
- Tweaked comment format

v2 -> v3:
- Split preparatory patch moving/rearranging code to two
- Fix closing path giving change for ... || xx to execute
  instead of skipping the flow-control char
- Use the same flow-control char function on closing path
  (just a cleanup, non-fix as last patch, a small change of
  regression exists)

v3 -> v4:
- Rework lookahead_count, it is now kept internal to n_tty ldisc rather
  than passed around through the whole callchain
- Dropped Gilles' Tested-by due to major changes
- Improve comments & changelogs

Ilpo Järvinen (3):
  tty: Rework receive flow control char logic
  tty: Implement lookahead to process XON/XOFF timely
  tty: Use flow-control char function on closing path

 drivers/tty/n_tty.c        | 107 ++++++++++++++++++++++++++++---------
 drivers/tty/tty_buffer.c   |  59 ++++++++++++++++----
 drivers/tty/tty_port.c     |  21 ++++++++
 include/linux/tty_buffer.h |   1 +
 include/linux/tty_ldisc.h  |  13 +++++
 include/linux/tty_port.h   |   2 +
 6 files changed, 170 insertions(+), 33 deletions(-)

-- 
2.30.2

