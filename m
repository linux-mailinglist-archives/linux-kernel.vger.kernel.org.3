Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886FB59E7E3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245557AbiHWQsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344205AbiHWQq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:46:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A028C7436;
        Tue, 23 Aug 2022 07:25:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF2B5615A8;
        Tue, 23 Aug 2022 14:25:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDEFC433C1;
        Tue, 23 Aug 2022 14:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661264740;
        bh=HYR1Nqy5GDUx1o1Dte+qnx5P34XauDkV8xn4Z6FHDfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HDfdRj6FoLpL5SwyUT9huPnbxiEAdPaHNFOA6FncnGRxTyfp+TN8pY9om2rBGc8nZ
         rdDiEb313MtevfBGSlXPDFEoSG6j8rgTIZO/sWhs5ytVOk6ix8XUdC5DB9uZZLuuwz
         eRmIH9blQerJ/4zu3+oiQ7n59DDKU+Go5E8Y9SOFXwpzEecN912WD4cEdx1DHD16Xg
         vZG6yNfpzyX2kPlj4BPK+ulb5axpe0G30apzFStBVi7dFFXjMlqrL+87IwM18V0Be2
         3hf1ynE19bBL0jnGd8UT4dR122lLxhP6pgbS/KCLBB1gKmRGHC/Lxvj4/r7ROgEkIz
         HCMAueCrrVRQQ==
Date:   Tue, 23 Aug 2022 07:25:39 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     zhaomzhao@126.com
Cc:     corbet@lwn.net, linux-xfs@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhao Mengmeng <zhaomengmeng@kylinos.cn>
Subject: Re: [PATCH v1] Documentation: filesystems: xfs: update pseudocode
 and typo fixes
Message-ID: <YwTjYxhhuJBZ9h8Z@magnolia>
References: <20220823013653.203469-1-zhaomzhao@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823013653.203469-1-zhaomzhao@126.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 09:36:53PM -0400, zhaomzhao@126.com wrote:
> From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> 
> According to the implementation of xfs_trans_roll(), it calls
> xfs_trans_reserve(), which reserves not only log space, but also
> free disk blocks. In short, the "transaction stuff". So change
> xfs_log_reserve() to xfs_trans_reserve().
> 
> Besides, fix several typo issues.
> 
> Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> ---
>  .../filesystems/xfs-delayed-logging-design.rst       | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/filesystems/xfs-delayed-logging-design.rst b/Documentation/filesystems/xfs-delayed-logging-design.rst
> index 4ef419f54663..02b32030bab3 100644
> --- a/Documentation/filesystems/xfs-delayed-logging-design.rst
> +++ b/Documentation/filesystems/xfs-delayed-logging-design.rst
> @@ -100,7 +100,7 @@ transactions together::
>  
>  	ntp = xfs_trans_dup(tp);
>  	xfs_trans_commit(tp);
> -	xfs_log_reserve(ntp);
> +	xfs_trans_reserve(ntp);
>  
>  This results in a series of "rolling transactions" where the inode is locked
>  across the entire chain of transactions.  Hence while this series of rolling
> @@ -191,7 +191,7 @@ transaction rolling mechanism to re-reserve space on every transaction roll. We
>  know from the implementation of the permanent transactions how many transaction
>  rolls are likely for the common modifications that need to be made.
>  
> -For example, and inode allocation is typically two transactions - one to
> +For example, an inode allocation is typically two transactions - one to
>  physically allocate a free inode chunk on disk, and another to allocate an inode
>  from an inode chunk that has free inodes in it.  Hence for an inode allocation
>  transaction, we might set the reservation log count to a value of 2 to indicate
> @@ -200,7 +200,7 @@ chain. Each time a permanent transaction rolls, it consumes an entire unit
>  reservation.
>  
>  Hence when the permanent transaction is first allocated, the log space
> -reservation is increases from a single unit reservation to multiple unit
> +reservation is increased from a single unit reservation to multiple unit
>  reservations. That multiple is defined by the reservation log count, and this
>  means we can roll the transaction multiple times before we have to re-reserve
>  log space when we roll the transaction. This ensures that the common
> @@ -259,7 +259,7 @@ the next transaction in the sequeunce, but we have none remaining. We cannot
>  sleep during the transaction commit process waiting for new log space to become
>  available, as we may end up on the end of the FIFO queue and the items we have
>  locked while we sleep could end up pinning the tail of the log before there is
> -enough free space in the log to fulfil all of the pending reservations and
> +enough free space in the log to fulfill all of the pending reservations and
>  then wake up transaction commit in progress.
>  
>  To take a new reservation without sleeping requires us to be able to take a
> @@ -615,7 +615,7 @@ those changes into the current checkpoint context. We then initialise a new
>  context and attach that to the CIL for aggregation of new transactions.
>  
>  This allows us to unlock the CIL immediately after transfer of all the
> -committed items and effectively allow new transactions to be issued while we
> +committed items and effectively allows new transactions to be issued while we
>  are formatting the checkpoint into the log. It also allows concurrent
>  checkpoints to be written into the log buffers in the case of log force heavy
>  workloads, just like the existing transaction commit code does. This, however,
> @@ -886,7 +886,7 @@ can be multiple outstanding checkpoint contexts, we can still see elevated pin
>  counts, but as each checkpoint completes the pin count will retain the correct
>  value according to it's context.
>  
> -Just to make matters more slightly more complex, this checkpoint level context
> +Just to make matters slightly more complex, this checkpoint level context

Thanks for the editing :)

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  for the pin count means that the pinning of an item must take place under the
>  CIL commit/flush lock. If we pin the object outside this lock, we cannot
>  guarantee which context the pin count is associated with. This is because of
> -- 
> 2.37.1
> 
