Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F995ADE98
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 06:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiIFEqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 00:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiIFEp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 00:45:58 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FEA644E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 21:45:52 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6A4AA68AA6; Tue,  6 Sep 2022 06:45:49 +0200 (CEST)
Date:   Tue, 6 Sep 2022 06:45:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dennis Maisenbacher <Dennis.Maisenbacher@wdc.com>
Cc:     linux-nvme@lists.infradead.org,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: fix mar and mor off-by-one errors
Message-ID: <20220906044549.GC32413@lst.de>
References: <20220905122116.2678206-1-Dennis.Maisenbacher@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905122116.2678206-1-Dennis.Maisenbacher@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 02:21:16PM +0200, Dennis Maisenbacher wrote:
> Cast the unsigned int values that are returned by bdev_max_open_zones and
> bdev_max_active_zones into u32 vales which need to be decremented as the
> returned values of the block layer helpers are not 0's based.
> The cast to u32 is necessary because the size of unsigned int is
> architecture dependent and a 0 reported by the block layer helpers
> indicates no limit, thus it needs to be converted to 0xffffffff which
> happens by underflowing the u32.

unsigned int (in Linux, not the C standard) is not architecture
dependent but always a 32-bit unsigned integer type.

But I'd much rather see an explicit check for 0 and conversion to
0xffffffff anyway.  Yes, unsigned integer underflow is well defined,
but having the explicit check explains much better to the read that it
is intentional.

Can you also add a Fixes tag, please?
