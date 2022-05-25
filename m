Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9333533FE5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237356AbiEYPHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiEYPHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:07:15 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4D26CF5E
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:07:13 -0700 (PDT)
Date:   Wed, 25 May 2022 17:07:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1653491231;
        bh=rFHjdAfF0vz1/EFBNiyD0IsPskYLMYVsfnaqUJagK+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FZ4+397wV+yur3tcyedrqXlDlkbOodpY5/0kHi7EWFw7Ytp7g51swEj7WCXyxb9oX
         95j+EaZrQ0fmy6EUJs0cymexxPa6Og5/U7x75SPFWY+2E9jpILiTVSYihazzU2B0ny
         1nqeLKZ9ng/W9ou0jCLXZkgnDKnL6xgFhfhRsgXE=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: fix host memory buffer allocation size
Message-ID: <b39c568b-338f-45bb-92f9-0175a909c3f8@t-8ch.de>
References: <20220428101922.14216-1-linux@weissschuh.net>
 <20220428143603.GA20460@lst.de>
 <5060d75e-46c0-4d29-a334-62c7e9714fa7@t-8ch.de>
 <20220428150644.GA22685@lst.de>
 <676c02ef-4bbc-43f3-b3e6-27a7d353f974@t-8ch.de>
 <20220510070356.GA11660@lst.de>
 <6123b484-bf2c-49f0-a657-6085c7333b2e@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6123b484-bf2c-49f0-a657-6085c7333b2e@t-8ch.de>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-10 12:20+0200, Thomas Weißschuh wrote:
> [..]
> > We could look into removing the min with
> > PAGE_SIZE * MAX_ORDER_NR_PAGES to try to do larger segments for
> > "segment challenged" controllers now that it could work on a lot
> > of iommu enabled setups.  But I'd rather have a very good reason for
> > that.
> 
> On my current setup (WD SN770 on ThinkPad X1 Carbon Gen9) frequently the NVME
> controller stops responding. Switching from no scheduler to mq-deadline reduced
> this but did not eliminate it.
> Since switching to HMB of 1 * 200MiB and no scheduler this did not happen anymore.
> (But I'll need some more time to gain real confidence in this)

So this patch dramatically improves the stability of my disk.

Without it and queue/scheduler=none the controller stops responding after a few
minutes. mq-deadline reduced it to every few hours.

With the patch it happens roughly once a week.

I'll still RMA the disk and see if the replacement changes anything.

Maybe some of the Western Digital employees here could take a look or check if
there is a new firmware available.
(The official updater requires Windows and there is no external documentation
about the firmware)

Not sure if a change from very broken to only slightly broken would be enough
of a good reason to be honest.

Thomas
