Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7469F4E899F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 21:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbiC0TSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 15:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiC0TSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 15:18:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15259340D8;
        Sun, 27 Mar 2022 12:16:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8962B61170;
        Sun, 27 Mar 2022 19:16:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BBDC340EC;
        Sun, 27 Mar 2022 19:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648408611;
        bh=0FgrUYhZwyHsZ//zYr3OA8nkGcmah3Fqzo+GHO0FW6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SLHOqD/4M73F4ZGztGFvLudEKgUyQ1u6ag1ppYblwfgA+n3VM/IqYFKp7N1GKLjz7
         z61tp2SkkyyyzHReFg/Z5CU1h9hvewP+i2QvkIqSvLNMTQs/wUyMamQeBAnZNS5uYu
         53xl21X/8HCSQjcjjLo0No33wJBiNNnauVWbdTCVe1P9bjI1e6y4/zskwTTmWHL4cJ
         rrAElg+YO4dPSFKJDnJLMDsPrQTxPpifSZko4QVBvAl735WlpgPbD5W/9hnJapl5xn
         ikKBE8GYFZWeFZBcu7LX6tPKKbIWlyvmde2lwX4ZCL+dN+LsvPzIJuXKdi8oLGBGpo
         T2GyD5ozrs2Fw==
Date:   Sun, 27 Mar 2022 13:16:49 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: move lower_48_bits() to block
Message-ID: <20220327191648.GA25077@keith-busch>
References: <20220327173316.315-1-kbusch@kernel.org>
 <CAHk-=whktuOOGYoNC=pAVX3KOMo4AD8dFsVdD_CAesMqef_9JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whktuOOGYoNC=pAVX3KOMo4AD8dFsVdD_CAesMqef_9JQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2022 at 10:53:42AM -0700, Linus Torvalds wrote:
> On Sun, Mar 27, 2022 at 10:33 AM <kbusch@kernel.org> wrote:
> >
> > The function is not generally applicable enough to be included in the core
> > kernel header. Move it to block since it's the only subsystem using it.
> 
> Thanks.
> 
> Btw - replying on the list too, because at least last time you were on
> the participants list, I got bounces about "mailbox too large".
> 
> WTH? Are you living in some hut in the wilderness in the good old
> nineties using AOL for email?

Hah, my kernel.org had an entry pointing to a recently defunct
forwarding address. I think that was the problem, and should be fixed
now.
