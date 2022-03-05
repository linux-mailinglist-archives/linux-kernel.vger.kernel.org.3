Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A285E4CE35A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 08:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiCEHKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 02:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiCEHKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 02:10:05 -0500
Received: from smtp.tom.com (smtprz15.163.net [106.3.154.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C818D220FD2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 23:09:15 -0800 (PST)
Received: from my-app02.tom.com (my-app02.tom.com [127.0.0.1])
        by freemail02.tom.com (Postfix) with ESMTP id B075DB00CC2
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 15:09:13 +0800 (CST)
Received: from my-app02.tom.com (HELO smtp.tom.com) ([127.0.0.1])
          by my-app02 (TOM SMTP Server) with SMTP ID 653284539
          for <linux-kernel@vger.kernel.org>;
          Sat, 05 Mar 2022 15:09:13 +0800 (CST)
Received: from antispam1.tom.com (unknown [172.25.16.55])
        by freemail02.tom.com (Postfix) with ESMTP id 9FF4DB00D30
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 15:09:13 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=201807;
        t=1646464153; bh=eNSZNCIQvJX3BIsPSVxmvt3kCFvgkMDpfMtpQFtvFKk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MSuUsI3uWf0AtRseaOViOhhCSlQvi0Aopj+QQKGFcdh+zcl+30hSDQ5/3f1+ONiuq
         dP3dNZBPMnvx8GsERgLrjZIS+fPuqyQwog/2soieSChu7O3BOxXP3HLlfs7D7D45Mk
         XbCRl8Emnbw27rJRP3C80h3xXJeIrn2lrkuSliX0=
Received: from antispam1.tom.com (antispam1.tom.com [127.0.0.1])
        by antispam1.tom.com (Postfix) with ESMTP id A83C9D4159C
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 15:09:11 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam1.tom.com
Received: from antispam1.tom.com ([127.0.0.1])
        by antispam1.tom.com (antispam1.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9K1Mese6hSzr for <linux-kernel@vger.kernel.org>;
        Sat,  5 Mar 2022 15:09:08 +0800 (CST)
Received: from localhost (unknown [101.93.196.13])
        by antispam1.tom.com (Postfix) with ESMTPA id 0F053D41550;
        Sat,  5 Mar 2022 15:09:06 +0800 (CST)
Date:   Sat, 5 Mar 2022 15:09:15 +0800
From:   Mingbao Sun <sunmingbao@tom.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        tyler.sun@dell.com, ping.gan@dell.com, yanxiu.cai@dell.com,
        libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH 2/2] nvme-tcp: support specifying the congestion-control
Message-ID: <20220305150915.00006b44@tom.com>
In-Reply-To: <20220304162032.GA12250@lst.de>
References: <20220304092754.2721-1-sunmingbao@tom.com>
        <20220304092754.2721-3-sunmingbao@tom.com>
        <20220304162032.GA12250@lst.de>
Organization: DELL
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

On Fri, 4 Mar 2022 17:20:32 +0100
Christoph Hellwig <hch@lst.de> wrote:

> I'll let the NVMe/TCP maintainer comment on the actual functionality,
> but:
> 
> > +			p = match_strdup(args);
> > +			if (!p) {
> > +				ret = -ENOMEM;
> > +				goto out;
> > +			}
> > +
> > +			key = tcp_ca_get_key_by_name(NULL, p,
> > &ecn_ca);
> > +			if (key == TCP_CA_UNSPEC) {
> > +				pr_err("congestion control %s not
> > found.\n",
> > +				       p);
> > +				ret = -EINVAL;
> > +				kfree(p);
> > +				goto out;
> > +			}  
> 
> We can't just call networking code from nvme-fabrics.ko

Well, actually I did have thought whether the calling of network API
here is proper. Since I did find that there is no call to APIs of
PCI/RDMA/TCP in fabrics.c.

But I hope the following could make a defense for it:

Anyway, we need to validate the tcp_congestion passed in from
user-space, right?
And it's reasonable to validate it via network API, right?

The role of nvmf_parse_options is similar to that of
drivers/nvme/target/configfs.c from the target side.
And both of them can not avoid handling specific options of the
sub-classes (e.g., NVMF_OPT_HDR_DIGEST, NVMF_OPT_TOS, NVMF_OPT_KATO).

Given the fact that the configfs.c already contains some RDMA-specific
code and has the calls to PCI-specific APIs pci_p2pdma_enable_store and
pci_p2pdma_enable_show, so I added the calling of network APIs in
configfs.c for the validation of tcp_congestion specified by the user.

So I feel this is also acceptable for nvme-fabrics.ko.
