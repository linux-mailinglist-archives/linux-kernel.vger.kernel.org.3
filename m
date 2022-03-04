Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4294CD16E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239259AbiCDJmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239307AbiCDJmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:42:00 -0500
X-Greylist: delayed 696 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Mar 2022 01:40:38 PST
Received: from smtp.tom.com (smtprz15.163.net [106.3.154.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669811B01AC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 01:40:38 -0800 (PST)
Received: from my-app02.tom.com (my-app02.tom.com [127.0.0.1])
        by freemail02.tom.com (Postfix) with ESMTP id C5753B00D46
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 17:29:00 +0800 (CST)
Received: from my-app02.tom.com (HELO smtp.tom.com) ([127.0.0.1])
          by my-app02 (TOM SMTP Server) with SMTP ID -1236235500
          for <linux-kernel@vger.kernel.org>;
          Fri, 04 Mar 2022 17:29:00 +0800 (CST)
Received: from antispam1.tom.com (unknown [172.25.16.55])
        by freemail02.tom.com (Postfix) with ESMTP id AD304B00D36
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 17:29:00 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=201807;
        t=1646386140; bh=aMp8az1QxA+F+29KIpcxkWlKDGd5ciQhH043yvhJWFo=;
        h=From:To:Cc:Subject:Date:From;
        b=BwRCRcBL1GNJoOwLyqLLs8a2lUqCqExBvNGmkJw/HPjoFF/kJ6P46p+yjhqvA4tgh
         BcL3/usI0yYCE7EW2sU9+/EjCcO1baytLYspPCYnbGSBsl8bubxQe+r1qtRh3hdg0b
         fqevfXdFLlaZO64BT1i07ekn1iCNJss9Sq82+zP8=
Received: from antispam1.tom.com (antispam1.tom.com [127.0.0.1])
        by antispam1.tom.com (Postfix) with ESMTP id A5C5AD41598
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 17:29:00 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam1.tom.com
Received: from antispam1.tom.com ([127.0.0.1])
        by antispam1.tom.com (antispam1.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rgKzJ2yFQgKK for <linux-kernel@vger.kernel.org>;
        Fri,  4 Mar 2022 17:28:59 +0800 (CST)
Received: from localhost.localdomain (unknown [39.144.44.23])
        by antispam1.tom.com (Postfix) with ESMTPA id 1C9CFD41502;
        Fri,  4 Mar 2022 17:28:58 +0800 (CST)
From:   Mingbao Sun <sunmingbao@tom.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     sunmingbao@tom.com, tyler.sun@dell.com, ping.gan@dell.com,
        yanxiu.cai@dell.com, libin.zhang@dell.com, ao.sun@dell.com
Subject: [PATCH 0/2] NVMe_over_TCP: support specifying the congestion-control
Date:   Fri,  4 Mar 2022 17:27:52 +0800
Message-Id: <20220304092754.2721-1-sunmingbao@tom.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mingbao Sun <tyler.sun@dell.com>

Hi all,

congestion-control could have a noticeable impaction on the
performance of TCP-based communications. This is of course true
to NVMe_over_TCP.

Different congestion-controls (e.g., cubic, dctcp) are suitable for
different scenarios. Proper adoption of congestion control would benefit
the performance. On the contrary, the performance could be destroyed.

Though we can specify the congestion-control of NVMe_over_TCP via
writing '/proc/sys/net/ipv4/tcp_congestion_control', but this also
changes the congestion-control of all the future TCP sockets that
have not been explicitly assigned the congestion-control, thus bringing
potential impaction on their performance.

So it makes sense to make NVMe_over_TCP support specifying the
congestion-control.

The first commit addresses the target side, and the second one
addresses the host side.

Mingbao Sun (2):
  nvmet-tcp: support specifying the congestion-control
  nvme-tcp: support specifying the congestion-control

 drivers/nvme/host/fabrics.c    | 24 ++++++++++++++++
 drivers/nvme/host/fabrics.h    |  2 ++
 drivers/nvme/host/tcp.c        | 20 ++++++++++++-
 drivers/nvme/target/configfs.c | 52 ++++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/tcp.c      | 27 ++++++++++++++++++
 6 files changed, 125 insertions(+), 1 deletion(-)

-- 
2.26.2

