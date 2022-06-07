Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8CC540380
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 18:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344920AbiFGQMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 12:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344909AbiFGQL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:11:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F0D100520
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 09:11:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 455A161680
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 16:11:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC74C34114;
        Tue,  7 Jun 2022 16:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654618316;
        bh=xnZyLh9MglV87sUUDApLik+cZvW272wQ3/jfI2c35fs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BLBTWbogFDKfUCKZhFSv1kCiTqK7tJkvsL1Ac/1ZnVmWUl9L46R//RhIlXghOIQjY
         /xkGFzjIAF8IRjsM/R4lOIXA5IcRAEXnYFMg+Im6OdfZbt7EuPTAH6DZ2JsMC1vt98
         GFG9CM6yLgnIUHq2bQhJji2N7+NWe9O1GrCZ3xSpwdk5p8jd2zIbUf4Kd/JPBputXr
         g8aS3SdrtNVKoaUJ638U3Xj8RZV12dLB7YgWGp06B7s8rzhyk4fcE3oCCnzmX03WKE
         HBHtoXFL/Y2cZJUxhgH2ygWcvZL6KdBwn7vQ/T9ocyIk3L067o6NZAwGPtNzLKy0GC
         qhtNt+MLiJayw==
Date:   Tue, 7 Jun 2022 10:11:53 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: add device name to warning in uuid_show()
Message-ID: <Yp94yTFrrkbBYqsj@kbusch-mbp.dhcp.thefacebook.com>
References: <20220607155555.8623-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220607155555.8623-1-linux@weissschuh.net>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 05:55:55PM +0200, Thomas Weißschuh wrote:
>  	if (uuid_is_null(&ids->uuid)) {
> -		printk_ratelimited(KERN_WARNING
> -				   "No UUID available providing old NGUID\n");
> +		dev_warn_ratelimited(dev, "No UUID available providing old NGUID\n");
>  		return sysfs_emit(buf, "%pU\n", ids->nguid);

The line split was correct to prevent this overly long line. But otherwise,
this looks good, though I'm wondering why this needs to be printed every time
someone reads the attribute.
