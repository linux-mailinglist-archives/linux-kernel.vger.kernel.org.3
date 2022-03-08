Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13364D189B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 14:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346451AbiCHNE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 08:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245664AbiCHNEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:04:25 -0500
Received: from smtp.tom.com (smtprz15.163.net [106.3.154.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD120473BE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 05:03:27 -0800 (PST)
Received: from my-app02.tom.com (my-app02.tom.com [127.0.0.1])
        by freemail02.tom.com (Postfix) with ESMTP id 5385BB00D32
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 21:03:25 +0800 (CST)
Received: from my-app02.tom.com (HELO smtp.tom.com) ([127.0.0.1])
          by my-app02 (TOM SMTP Server) with SMTP ID -1951528683
          for <linux-kernel@vger.kernel.org>;
          Tue, 08 Mar 2022 21:03:25 +0800 (CST)
Received: from antispam1.tom.com (unknown [172.25.16.55])
        by freemail02.tom.com (Postfix) with ESMTP id 418A9B00CC2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 21:03:25 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=201807;
        t=1646744605; bh=BwJ+5quvHMWTci0mC33vVMP7HVey1Hn1WFiQ5Ovu7QA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DiHOJfSUTjhjmOXKJ9pdAcc6nxXI9SQN00+uytZaXEq+Cv2+mrIh0FkzDOjrR1SKd
         chDCraa5I2QlTXb2wzv04ooQcZoiFjLyPk/0eEps767vdCB+8tRUtRKHWPCwehhqCA
         gZIJkPGi44OGYOOXPGcJjNXXg7yOh1IXYC3oBeiY=
Received: from antispam1.tom.com (antispam1.tom.com [127.0.0.1])
        by antispam1.tom.com (Postfix) with ESMTP id 3E487D415A5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 21:03:25 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam1.tom.com
Received: from antispam1.tom.com ([127.0.0.1])
        by antispam1.tom.com (antispam1.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yoGNTDAwyYmY for <linux-kernel@vger.kernel.org>;
        Tue,  8 Mar 2022 21:03:24 +0800 (CST)
Received: from localhost (unknown [101.93.196.13])
        by antispam1.tom.com (Postfix) with ESMTPA id 77F9DD41599;
        Tue,  8 Mar 2022 21:03:21 +0800 (CST)
Date:   Tue, 8 Mar 2022 21:03:20 +0800
From:   Mingbao Sun <sunmingbao@tom.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     tyler.sun@dell.com, ping.gan@dell.com, yanxiu.cai@dell.com,
        libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH 0/2] NVMe_over_TCP: support specifying the
 congestion-control
Message-ID: <20220308210320.000013ca@tom.com>
In-Reply-To: <20220304092754.2721-1-sunmingbao@tom.com>
References: <20220304092754.2721-1-sunmingbao@tom.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I feel that I'd better address this a little bit more to express the
meaning behind this feature.

You know, InfiniBand/RoCE provides NVMe-oF a lossless network
environment (that is zero packet loss), which is a great advantage
to performance.

In contrast, 'TCP/IP + ethernet' is often used as a lossy network
environment (packet dropping often occurs).=20
And once packet dropping occurs, timeout-retransmission would be
triggered. But once timeout-retransmission was triggered, it=E2=80=99s a gr=
eat
damage to the performance.

So although NVMe/TCP may have a bandwidth competitive to that of
NVMe/RDMA, but the packet dropping of the former is a flaw to
its performance.

However, with the combination of the following conditions, NVMe/TCP
can almost be as competitive as NVMe/RDMA in the data center.

  - Ethernet NICs supporting QoS configuration (support mapping TOS/DSCP
    in IP header into priority, support PFC)

  - Ethernet Switches supporting ECN marking, supporting adjusting
    buffer size of each priority.

  - NVMe/TCP supports specifying the tos for its TCP traffic
    (already implemented)

  - NVMe/TCP supports specifying dctcp as the congestion-control of its
    TCP sockets (the work of this feature)

So this feature is the last item from the software aspect to form up the
above combination.

