Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DA64DB360
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 15:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbiCPOir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 10:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbiCPOio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:38:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8413952E29
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 07:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647441449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tHEFNI4QFddUzu0LQQmFlfD1SkQZMssJQZsRu1wTjdk=;
        b=e0HkKuxHnRX5OF33Y0pTsgqwOjDFnIo7+y2clnSN+HD4MdcQaHn61PcIwY2ExxriQAA6NN
        hvZMUoUm1iPuVsqZf9E3YMzkkEcu94wsW76E13Pl8y/RG5G1/bhGv+/BnRdidS63IFpXC8
        FwT6jOi00abqCaBZjNhKJNfPAks6rYU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-81-7Mew6Dc-N5mvjWn8E9OFhQ-1; Wed, 16 Mar 2022 10:37:26 -0400
X-MC-Unique: 7Mew6Dc-N5mvjWn8E9OFhQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4CA958D3765;
        Wed, 16 Mar 2022 14:37:24 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.19.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AAA9940F9D53;
        Wed, 16 Mar 2022 14:37:20 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Wander Lairson Costa <wander@redhat.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        linux-serial@vger.kernel.org (open list:SERIAL DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     rostedt@goodmis.org, senozhatsky@chromium.org,
        andre.goddard@gmail.com, sudipm.mukherjee@gmail.com,
        andy.shevchenko@gmail.com, David.Laight@aculab.com,
        jonathanh@nvidia.com, phil@raspberrypi.com
Subject: [PATCH v4 0/5] tty/8250: Use fifo in 8250 console driver
Date:   Wed, 16 Mar 2022 11:36:39 -0300
Message-Id: <20220316143646.13301-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This version fixes the bugs reported in version v3. The first patch
is the same patch of v3 as is. The following commits fix the issues in the
original patch. For details, please check the commit log of each patch.

I tested these patches in the following systems:

* IBM X3550 M3
* HP ProLiant DL380 Gen9
* HP ProLiant BL480c G1
* Dell PowerEdge R910
* Cisco UCSC-C220-M3S

I cc everybody that reported problems with the previous version of this
patch so they can retest and confirm their systems work flawlessly.

Wander Lairson Costa (5):
  serial/8250: Use fifo in 8250 console driver
  serial/8250: Use the cache value of the FCR register
  serial/8250: Use tx_loadsz as the transmitter fifo size
  serial/8250: exclude BCM283x from console_fifo_write
  serial/8250: Only use fifo after the port is initialized in
    console_write

 drivers/tty/serial/8250/8250_port.c | 67 ++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 6 deletions(-)

-- 
2.35.1

