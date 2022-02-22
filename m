Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61ECB4C0396
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 22:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbiBVVNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 16:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbiBVVNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 16:13:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5F2A1BE3;
        Tue, 22 Feb 2022 13:13:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A914B81B7E;
        Tue, 22 Feb 2022 21:13:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3E8C340E8;
        Tue, 22 Feb 2022 21:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645564382;
        bh=CLbIagV/MQB2m5ZSEv0peS7rGmq6ywXWnF5bfGM9/fs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gp7PHdqad+8kJwY3wRhTp+cjV9ERuetXszY1q80C8Va9yxWMsK2NOkXQjPQfFdfQC
         qqz5VOWI5Yns5t6QoYokVLWNQgUKUhe6y7Px2LXjzGfFiYsfM2hizdO3yRoBLL6bhu
         xe47u6y+Uy6nGqvgcfIb5MIlvpy4FQXLCPksBiqwURTCB7zVu1pfcBgy7/5D3WUsmR
         PLXgoGqvPDF95yCeWgpMDMT+o6HiV0Fyvb/vd0q6+UNEImxFQ2WNaOdDlCH22mChCQ
         FcyDldGo6uQPcnz1tO/riGgINC/7s3WSUoaemjLQ7qGfoISFguDGIHhsp0e2pc6pIp
         y4BM1wZoVx3Fg==
Date:   Tue, 22 Feb 2022 13:12:59 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "colyli@suse.de" <colyli@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCHv3 04/10] linux/kernel: introduce lower_48_bits macro
Message-ID: <20220222211259.GC1782741@dhcp-10-100-145-180.wdc.com>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-5-kbusch@kernel.org>
 <66a0c8210cf9e7dfcc3fa2d247de1eebd5a8acb7.camel@perches.com>
 <20220222165045.GA14168@lst.de>
 <20220222165613.GB1497257@dhcp-10-100-145-180.wdc.com>
 <603f9243bb9e1c4c50aaec83a527266b48ab9e20.camel@perches.com>
 <65fd7d9525b443fcbb15468176fca16a@AcuMS.aculab.com>
 <eef8db106e310e20faff4563580fa0eeb064d17b.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eef8db106e310e20faff4563580fa0eeb064d17b.camel@perches.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 12:31:30PM -0800, Joe Perches wrote:
> > I'd only use something GENMASK() for bit ranges.
> > Even then it is often easier to just write the value in hex.
> 
> Mostly it's the count of the repeated f that's difficult to
> quickly verify visually.

I admit I made this counting mistake in earlier versions of this series.

I think the earlier suggested "(1ull << 48) - 1" style in an inline
function seems good, and it doesn't appear to cause compiler concerns.
