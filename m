Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39024D7E51
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237846AbiCNJPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbiCNJPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:15:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A5A3ED36;
        Mon, 14 Mar 2022 02:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647249280; x=1678785280;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QegVvWDmTK9SMt8wg/WFpqT3Mlvx5z2zQ2x0dvzullA=;
  b=DfJQGDyRZX5AJb2GfkeCIR5aNcbDLQRzK+PS5OtfGD/WFPkCWp7NxxwY
   AE/o3A45dc7oRgPf0f8YB6rEfhVhdDHFDYKvKZXu9oSRSE40ZrqeD9f9c
   1KrbO0c1sHe4INiH9EythpAeG2jRd1uHrgjRWUF4rNPPv4sn7BK0Bt1u4
   8OooW6ode8VkRynS6GaWbj3oY0J0Xpf+7q0R/Wdo2WvDkEulGYAqDzVjO
   PzBgcH2r+/pC5+QSmEdfWqgaMpLvEkFiJhvHnWKtHkHmF3W8OpX/J8ABr
   E8vEt/pP2rMyHuVRblrmhXY6ivrnRIMTLRdOEIvp9ydm3fSranaYc1VcV
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="243422940"
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; 
   d="scan'208";a="243422940"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 02:14:39 -0700
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; 
   d="scan'208";a="556322449"
Received: from srafikbh-mobl1.gar.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.54.232])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 02:14:36 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lukas Wunner <lukas@wunner.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Gilles Buloz <gilles.buloz@kontron.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/1] Fix 8250 XON/XOFF for DMA-capable devices
Date:   Mon, 14 Mar 2022 11:14:31 +0200
Message-Id: <20220314091432.4288-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA-capable 8250 was not properly taking XON/XOFF into account
right since it was introduced in 2013. There was no attempt to
send x_char out at all which is fixed by this patch.

After making this fix, it was further reported by Gilles Buloz
that also rx side fails to work as expected if the receiving
side is not reading from tty. I took look into that issue and
and determined that XOFF char gets stuck in an intermediate
buffer until enough data can be processed in receive_buf().
So it's not very useful from flow control perspective :-). While
the problem is more likely to occur with DMA, the code does not
look robust and the problem can likely occur also w/o DMA.

I was thinking of fixing the rx side issue by adding lookahead.
The most natural place to call lookahead handler would seem
to be from flush_to_ldisc() in the case when receive_buf() does
not eat all characters that were passed to it. Does anybody have
other opinions on how it should be fixed?

Ilpo Järvinen (1):
  serial: 8250: fix XOFF/XON sending when DMA is used

 drivers/tty/serial/8250/8250_dma.c  | 11 ++++++++++-
 drivers/tty/serial/8250/8250_port.c |  4 +---
 drivers/tty/serial/serial_core.c    | 14 ++++++++++++++
 include/linux/serial_core.h         |  2 ++
 4 files changed, 27 insertions(+), 4 deletions(-)

-- 
2.30.2

