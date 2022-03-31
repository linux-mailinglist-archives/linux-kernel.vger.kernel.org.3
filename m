Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C574EE148
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 21:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238656AbiCaTFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 15:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238577AbiCaTFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:05:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 565AA1728A4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 12:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648753438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FwgU8ObIp8xL0aPzK5GNickvJ2Wwx2TZEWFhuitUlKU=;
        b=O4YihXWM0lq75/75h5hUDMInf1MR0VQZxN9VwPZMYxC9db7/xVZxDJhknVfkKxIGmdBhhg
        rCJLcb4dHI78d5MzAIUWihBI5bsbZepf5Gq00QkSkIiUdUPcugS6BoWa3Iy/AvM/n0qsBC
        FhyeNHtgpEZdjkkCRcIAMqtfqo5MIVE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-xr3ADvWvNPmfZ8J5hZslAA-1; Thu, 31 Mar 2022 15:03:52 -0400
X-MC-Unique: xr3ADvWvNPmfZ8J5hZslAA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9DAF718A6582;
        Thu, 31 Mar 2022 19:03:51 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.35.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 523A353CD;
        Thu, 31 Mar 2022 19:03:24 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Wander Lairson Costa <wander@redhat.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        linux-serial@vger.kernel.org (open list:SERIAL DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     rostedt@goodmis.org, senozhatsky@chromium.org,
        andre.goddard@gmail.com, sudipm.mukherjee@gmail.com,
        andy.shevchenko@gmail.com, David.Laight@aculab.com,
        jonathanh@nvidia.com, phil@raspberrypi.com
Subject: [PATCH v5 0/1] serial/8250: Use fifo in 8250 console driver
Date:   Thu, 31 Mar 2022 16:02:54 -0300
Message-Id: <20220331190257.101781-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v5 of the serial fifo patch. In relation to the previous
reverted patch, I describe the main changes in the "What changed from
v3" section.

What changed from v4
--------------------

* It squashes all the patches in a single patch
* It adds `port-state &&` check in the `use_fifo` condition as a
* preventive measure.

What changed from v3
--------------------

* Reads the FCR value from the port struct. The earlier patch
erroneously read the value from the controller, but FCR is a write-only
register. Thanks to Jiri Slaby for point this out.

* Use tx_loadsz as the transmitter fifo size. We previously used the
port->fifosize field, which caused data loss in some controllers. Thanks
Jon Hunter for the bug report.

* Exclude the BCM283x from fifo write. This is based on Phil Elwell's
original patch [1].

* Check if the port is initialized before write through fifo.
The serial driver set the value of uart_8250_port.fcr in the function
serial8250_config_port, but only writes the value to the controller
register later in the initalization code. That opens a small window in
which is not safe to use the fifo for console write. Unfortunately, I
lost track of who originally reported the issue. If s/he is reading
this, please speak up so I can give you the due credit.

[1] https://lore.kernel.org/all/20220126141124.4086065-1-phil@raspberrypi.com/

Wander Lairson Costa (1):
  serial/8250: Use fifo in 8250 console driver

 drivers/tty/serial/8250/8250_port.c | 68 ++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 6 deletions(-)

-- 
2.35.1

