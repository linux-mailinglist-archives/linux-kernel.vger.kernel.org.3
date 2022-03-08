Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4B14D1166
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 08:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344711AbiCHH66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 02:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237428AbiCHH64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 02:58:56 -0500
Received: from smtp.tom.com (smtprz15.163.net [106.3.154.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24EF1E3C2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 23:57:59 -0800 (PST)
Received: from my-app01.tom.com (my-app01.tom.com [127.0.0.1])
        by freemail01.tom.com (Postfix) with ESMTP id 772E31E8C276
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 15:57:57 +0800 (CST)
Received: from my-app01.tom.com (HELO smtp.tom.com) ([127.0.0.1])
          by my-app01 (TOM SMTP Server) with SMTP ID -382177656
          for <linux-kernel@vger.kernel.org>;
          Tue, 08 Mar 2022 15:57:57 +0800 (CST)
Received: from antispam3.tom.com (unknown [172.25.16.54])
        by freemail01.tom.com (Postfix) with ESMTP id 622C81E8C1EC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 15:57:57 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=201807;
        t=1646726277; bh=VE2APZ2EUOPto3xCBpDlYUdKULx5+IcuTAJTyrhmCSY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TNT6WwpA6WPDWkpnUpBeyhZ3XaXoCUbuYbSiYJQMfBC4HMHd1xTBLGZ6JMbizzmCX
         dqxSgolOwBa0WAn5mM2dMrLv53vMSIpVc1JQZeCGl4qCfjHolHXGZI34gQMLFb90+D
         rfv36HFA6yHB/TqABxeBkaso7WNc3Cig1h8TIDPg=
Received: from antispam3.tom.com (antispam3.tom.com [127.0.0.1])
        by antispam3.tom.com (Postfix) with ESMTP id 3C6949C1C1F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 15:57:57 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam3.tom.com
Received: from antispam3.tom.com ([127.0.0.1])
        by antispam3.tom.com (antispam3.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 97zfaMQx5y_b for <linux-kernel@vger.kernel.org>;
        Tue,  8 Mar 2022 15:57:56 +0800 (CST)
Received: from localhost (unknown [223.104.210.22])
        by antispam3.tom.com (Postfix) with ESMTPA id 4B4899C0839;
        Tue,  8 Mar 2022 15:57:55 +0800 (CST)
Date:   Tue, 8 Mar 2022 15:57:54 +0800
From:   Mingbao Sun <sunmingbao@tom.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        tyler.sun@dell.com, ping.gan@dell.com, yanxiu.cai@dell.com,
        libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH 2/2] nvme-tcp: support specifying the congestion-control
Message-ID: <20220308155754.000029bb@tom.com>
In-Reply-To: <20220308071227.GB24575@lst.de>
References: <20220304092754.2721-1-sunmingbao@tom.com>
        <20220304092754.2721-3-sunmingbao@tom.com>
        <20220304162032.GA12250@lst.de>
        <20220305150915.00006b44@tom.com>
        <20220308071227.GB24575@lst.de>
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

On Tue, 8 Mar 2022 08:12:27 +0100
Christoph Hellwig <hch@lst.de> wrote:

> On Sat, Mar 05, 2022 at 03:09:15PM +0800, Mingbao Sun wrote:
> > Well, actually I did have thought whether the calling of network API
> > here is proper. Since I did find that there is no call to APIs of
> > PCI/RDMA/TCP in fabrics.c.  
> 
> Yes - for a good reason.  Without networking support your patch won't
> even compile (both the host and target side).

accept.

Will remove the calls to networking APIs in the next version.
With investigation, I found the tcp_congestion could also get checked
later within sock_common_setsockopt in nvme_tcp_alloc_queue.
And this brings no difference to the command 'nvme connect'.

> 
> > But I hope the following could make a defense for it:
> > 
> > Anyway, we need to validate the tcp_congestion passed in from
> > user-space, right?  
> 
> Do we?  It seems like no one else really calls this routine to verify
> things.  In fact it has no modular users at all in the current tree.

OK. Got it.

> 
> > The role of nvmf_parse_options is similar to that of
> > drivers/nvme/target/configfs.c from the target side.
> > And both of them can not avoid handling specific options of the
> > sub-classes (e.g., NVMF_OPT_HDR_DIGEST, NVMF_OPT_TOS, NVMF_OPT_KATO).  
> 
> NVMF_OPT_KATO is completely generic, but yes, there other two are
> transport specific.  None of them calls out into other modules
> that would need dependecies, though.

Yeah, NVMF_OPT_KATO is generic. Sorry for the mistake.

> 
> I'm also a little concerned that no other in kernel user like iSCSI,
> NBD or NFS has any code like this.

Well, at least I could first remove the calls to networking APIs on the
host side. And it brings no downside.

