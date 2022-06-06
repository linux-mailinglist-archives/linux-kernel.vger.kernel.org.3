Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE9A53E72E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbiFFKGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbiFFKFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:05:40 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C6E72215;
        Mon,  6 Jun 2022 03:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654509934; x=1686045934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a3xiWY53ELIfaqncp7g4ITt07ZnohdpPD8QPL9eVyFY=;
  b=Q+XY1j14M0Xs2P8k8LIlYVlydLEfPK1/EiRwnHW1kGjCSNNKL8bPkvwh
   HdUjbh9nSHe3kC4yt/JVFLqtkQ1dwNwsdb0YxKPntbB/e43WY3+CvIMiM
   y1MUyXCtjsXHPxQ9sgK1ZLADTdrLbNKJSyqINxOijMeHgi1RKTW+1Xo0g
   ozpLrs0IKZXtp1zZTbEYVqBSK5/AVGtN4LoVM4POKekfx1HgOtQStT64H
   hoVzpWtG7mj1Z1wrY19sabVwz610C5ie9/P25bEq/zSRMYooDLdFioqVi
   NMcb2rmF7trMILOdI1bbwTz6G1QjTo/pWXZLgFB9uG5+oyLsT0fMuBi4J
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="362987049"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="362987049"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:05:21 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635523630"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:05:20 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 10/36] serial: 8250_of: Use serial8250_em485_supported
Date:   Mon,  6 Jun 2022 13:04:07 +0300
Message-Id: <20220606100433.13793-11-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220606100433.13793-1-ilpo.jarvinen@linux.intel.com>
References: <20220606100433.13793-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

8250_of uses em485, fill in rs485_supported accordingly.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_of.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 5a699a1aa79c..65cccd559db2 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -165,6 +165,7 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 
 	port->dev = &ofdev->dev;
 	port->rs485_config = serial8250_em485_config;
+	port->rs485_supported = &serial8250_em485_supported;
 	up->rs485_start_tx = serial8250_em485_start_tx;
 	up->rs485_stop_tx = serial8250_em485_stop_tx;
 
-- 
2.30.2

