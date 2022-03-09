Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400694D2980
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiCIHdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiCIHdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:33:38 -0500
Received: from smtp.tom.com (smtprz15.163.net [106.3.154.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C00B7C6E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 23:32:38 -0800 (PST)
Received: from my-app01.tom.com (my-app01.tom.com [127.0.0.1])
        by freemail01.tom.com (Postfix) with ESMTP id E1B771E8C1F0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 15:32:35 +0800 (CST)
Received: from my-app01.tom.com (HELO smtp.tom.com) ([127.0.0.1])
          by my-app01 (TOM SMTP Server) with SMTP ID -156080194
          for <linux-kernel@vger.kernel.org>;
          Wed, 09 Mar 2022 15:32:35 +0800 (CST)
Received: from antispam3.tom.com (unknown [172.25.16.54])
        by freemail01.tom.com (Postfix) with ESMTP id D2E581E8C0A7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 15:32:35 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=201807;
        t=1646811155; bh=B1TXx7YwcolI6PgRXcjcE/hEwVsy2ADYRgU4ApmkzN8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GvWTYJkpbx7U5pvUYn7VyyolqtXzcmzt9+1fm5zwtRCKxFtel4gxfwXGDjoWocxig
         jaj1bbXsGEDD0+xJa/40j8fn/3ht3vg5exh2CYt0wHGCUdFjHHn6Qjx6z+eRyJGmrb
         8ZiTbWwLmZ7ztJ15xo+psCe+frOUO0P3MkEmz8Jk=
Received: from antispam3.tom.com (antispam3.tom.com [127.0.0.1])
        by antispam3.tom.com (Postfix) with ESMTP id C66289C1C2A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 15:32:35 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam3.tom.com
Received: from antispam3.tom.com ([127.0.0.1])
        by antispam3.tom.com (antispam3.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Czo5gYHFIBmV for <linux-kernel@vger.kernel.org>;
        Wed,  9 Mar 2022 15:32:35 +0800 (CST)
Received: from localhost (unknown [101.93.196.13])
        by antispam3.tom.com (Postfix) with ESMTPA id 71EEB9C192B;
        Wed,  9 Mar 2022 15:32:34 +0800 (CST)
Date:   Wed, 9 Mar 2022 15:32:33 +0800
From:   Mingbao Sun <sunmingbao@tom.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        tyler.sun@dell.com, ping.gan@dell.com, yanxiu.cai@dell.com,
        libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH v2 2/2] nvme-tcp: support specifying the
 congestion-control
Message-ID: <20220309153136.000048e1@tom.com>
In-Reply-To: <20220309061442.GA31316@lst.de>
References: <20220308151606.2563-1-sunmingbao@tom.com>
        <20220309061442.GA31316@lst.de>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > @@ -1447,6 +1449,21 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
> >  	if (nctrl->opts->tos >= 0)
> >  		ip_sock_set_tos(queue->sock->sk, nctrl->opts->tos);
> >  
> > +	if (nctrl->opts->mask & NVMF_OPT_TCP_CONGESTION) {
> > +		strncpy(ca_name, nctrl->opts->tcp_congestion,
> > +			TCP_CA_NAME_MAX-1);
> > +		optval = KERNEL_SOCKPTR(ca_name);
> > +		ret = sock_common_setsockopt(queue->sock, IPPROTO_TCP,
> > +					     TCP_CONGESTION, optval,
> > +					     strlen(ca_name));  
> 
> This needs to use kernel_setsockopt.  I also can see absolutely no
> need for the optval local variable, and I also don't really see why
> we need ca_name either - if we need to limit the length and terminate
> it (but why?) that can be done during option parsing.

Well, actually at the beginning I did use kernel_setsockopt.
But the compilation failed.

Then I found the API kernel_setsockopt disappeared from kernel v5.8.
So I use sock_common_setsockopt instead.
The birth of variable ca_name and optval is just because of the
the relevant definitions related to the prototype of
sock_common_setsockopt.

But now through thinking your comments and investigating the story of
the disappearance of kernel_setsockopt, I feel I should use
tcp_set_congestion_control instead of sock_common_setsockopt.
Just as target/tcp.c replaced kernel_setsockopt with ip_sock_set_tos.

As for the length limitation of the ca name, I will (if required) move
them into the phase of option parsing in the next version.
