Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C7147D187
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 13:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240454AbhLVMK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 07:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbhLVMKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 07:10:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A84C061574;
        Wed, 22 Dec 2021 04:10:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7773618A9;
        Wed, 22 Dec 2021 12:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1AF9C36AE8;
        Wed, 22 Dec 2021 12:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640175024;
        bh=40w+Lr5xEnFUwUpBjGgQmNLYcnS1l+O8MN42TYGTWDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QN92JuiM1ujWj/quffGeLoWc9uKURBbszWd6vF0EO8IpEc5+2a4x0dGu334YwR4gL
         MPScDV/0UOuscAeeAkl8lZwFBvyEPtl99yUDEaOEsvi0ESb50zDd4pL5+lf7lSPKud
         DcyduWvchvhxJUZn7fr4A6wiuXXThK0jNPc1v4qY=
Date:   Wed, 22 Dec 2021 13:10:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     jack@suse.cz, paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH linux-4.19.y 0/5] fix memleak of bfq weights_tree node
Message-ID: <YcMVpesszGG2EABJ@kroah.com>
References: <20211221113849.2219126-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221113849.2219126-1-yukuai3@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 07:38:44PM +0800, Yu Kuai wrote:
> Our test found that bfq_weight_counter can leak quite easy. This problem
> can be fixed by patch 4, and other patches is needed to backport patch
> 4.
> 
> Federico Motta (2):
>   block, bfq: improve asymmetric scenarios detection
>   block, bfq: fix asymmetric scenarios detection
> 
> Paolo Valente (3):
>   block, bfq: fix decrement of num_active_groups
>   block, bfq: fix queue removal from weights tree
>   block, bfq: fix use after free in bfq_bfqq_expire
> 
>  block/bfq-iosched.c | 287 +++++++++++++++++++++++++++-----------------
>  block/bfq-iosched.h |  76 +++++++++---
>  block/bfq-wf2q.c    |  56 +++++----
>  3 files changed, 270 insertions(+), 149 deletions(-)
> 
> -- 
> 2.31.1
> 

All now queued up, thanks.

greg k-h
