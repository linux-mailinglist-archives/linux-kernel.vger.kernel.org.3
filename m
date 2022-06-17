Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CB254F8DD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 16:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382604AbiFQOEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 10:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbiFQOEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:04:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FC513FAD;
        Fri, 17 Jun 2022 07:04:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F55EB82A3F;
        Fri, 17 Jun 2022 14:04:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC5EC3411B;
        Fri, 17 Jun 2022 14:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655474673;
        bh=Zf8c2aIaTSHv0y2u4YrMfalwNIOLPu62kHzTrv8BfLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D3goTISFFxCpOY5iYC/ordW7UlIOvY9urCbEEOprR/4LCahHN8jtoro6U4wZxqFTh
         xcmONjiHAnx63AYv0LGZG16Q9xCD4r0OEWAC1H8A9kfD9xxF12uauuUi37HdTrOvMw
         ByNhhPGLZt2Ju51CVoe1picmbdQBX0g642dtfZ0gYq65RDd0peNyx5zMCDEUYD/mxG
         yZY/uzwTPCAVaBu7oLuDOZbDxrmqzl5UjKSmneFidmQ+zwPzEG4UrOnUha4apZ8OaW
         LI9+gniXcaXMDLMP2iO0L5B/hZG049xzePxUSIlzoo3vAhvg7JJ2BuRemde0Xh76/S
         94YDIMzRQNwKg==
Date:   Fri, 17 Jun 2022 08:04:29 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, jack@suse.cz,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH RFC -next] sbitmap: fix possible io hung due to lost
 wakeups
Message-ID: <YqyJ7dwUB0z0puNc@kbusch-mbp.dhcp.thefacebook.com>
References: <20220617141125.3024491-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617141125.3024491-1-yukuai3@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 10:11:25PM +0800, Yu Kuai wrote:
> 
> What's worse, io hung is possible in theory because wakeups might be
> missed. For example, 2 * wake_batch tags are put, while only wake_batch
> threads are worken:

Not just in theory, io hanging sounds like the problem reported here:

  https://bugzilla.kernel.org/show_bug.cgi?id=215679

I only knew that it had nothing to do with the nvme driver, though, but they
closed the bug after it stopped happening with different hardware.
