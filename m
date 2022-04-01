Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC214EFA95
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 21:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349415AbiDATty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 15:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348752AbiDATtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 15:49:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FCCC1D7D83
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 12:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648842480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8yU+4t/rW+YFNbdqOagodLy2byNHGn7oDJru4qzRMQk=;
        b=I2EP+ponP/VvSIlNMy9Dv6enloApgjz5G3SDbUvpoP8lrh8hhGAwWNPLi/4giIDftIEzg8
        hrvUnjkRm9jKoOa3DIMWNhkI0ZCWkssWvcHIh/3Mfr+FN3RLehE6ig2EEweEpp6YfRMCSl
        JqdjMfmWtMjSr5n2GaDBtV5/kW2uXYo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-599-9ek7tJcnPtm8NstXdq-B9g-1; Fri, 01 Apr 2022 15:47:56 -0400
X-MC-Unique: 9ek7tJcnPtm8NstXdq-B9g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D5E553C01D82;
        Fri,  1 Apr 2022 19:47:55 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.10.139])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F36634292C8;
        Fri,  1 Apr 2022 19:47:50 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wander Lairson Costa <wander@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        linux-serial@vger.kernel.org (open list:SERIAL DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     ilpo.jarvinen@linux.intel.com, rostedt@goodmis.org,
        senozhatsky@chromium.org, andre.goddard@gmail.com,
        sudipm.mukherjee@gmail.com, andy.shevchenko@gmail.com,
        David.Laight@aculab.com, jonathanh@nvidia.com, phil@raspberrypi.com
Subject: [PATCH v6 0/1] serial/8250: Use fifo in 8250 console driver
Date:   Fri,  1 Apr 2022 16:46:41 -0300
Message-Id: <20220401194645.1738747-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v6 of the serial fifo patch. In relation to the previous
reverted patch, I describe the main changes in the "What changed from
v3" section.

What changed from v5
--------------------

* Fixed a typo in patch patch "port-state" becomes "port->state".

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

