Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9E85AFD9A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiIGHd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiIGHdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:33:46 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426B4A4051;
        Wed,  7 Sep 2022 00:33:29 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id EE9656732D; Wed,  7 Sep 2022 09:33:24 +0200 (CEST)
Date:   Wed, 7 Sep 2022 09:33:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Dusty Mabe <dusty@dustymabe.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, linux-raid@vger.kernel.org
Subject: Re: regression caused by block: freeze the queue earlier in
 del_gendisk
Message-ID: <20220907073324.GB23826@lst.de>
References: <017845ae-fbae-70f6-5f9e-29aff2742b8c@dustymabe.com> <YxBZ4BBjxvAkvI2A@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxBZ4BBjxvAkvI2A@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 03:06:08PM +0800, Ming Lei wrote:
> It is a bit hard to associate the above commit with reported issue.

So the messages clearly are about something trying to open a device
that went away at the block layer, but somehow does not get removed
in time by udev (which seems to be a userspace bug in CoreOS).  But
even with that we really should not hang.

Now that fact that it did hang before and this now becomes reproducible
also makes me assume the change is not the root cause.  It might still
be a good vehicle to fix the issue for real, but it really broadens
the scope.
