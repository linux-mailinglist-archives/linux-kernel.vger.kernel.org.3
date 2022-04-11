Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748A24FC164
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348233AbiDKPt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348224AbiDKPt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:49:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177A3765A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:47:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3B59B816F6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 15:47:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC1AC385A9;
        Mon, 11 Apr 2022 15:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649692059;
        bh=Cu18FhMcLE9GUS3nv00BMlQy6Yb5Jq7E80PLO8mOKw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U/HA1oCKQJg8pY/Musht4irN6qZjUFa97/F0Rf/v9JiTAsTybP9KqCwl60/M+gFDR
         iifcSFLRG/rfJcVe/N5/eu1AFK5RlKZ+OZ1Qstp7ikrfd1pn+Kr9wLYQIArOqf5BSP
         IiNVv4unDb85l2SI/TzB7qRxBUSY90C25BkO3igq69g2FVCWQEfZP3APPWA+KqAOOY
         Zlweqwz5xSoDcXrY1CqrWMHWs3hMX0aLZ6l1bySF9FmT+vpEiVHzmrvuU6mCwhdsur
         ljRhOXd0U+mwhmFmmSROhGbh/CKX4fJ+4Tf3a2luU5jGalHELXRmU9spEtaJCPBqMb
         gTOKJ2d67G7Lg==
Date:   Mon, 11 Apr 2022 08:47:37 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Michal Orzel <michalorzel.eng@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ipc/sem: Remove redundant assignments
Message-ID: <YlRNmXucZwNasoFq@thelio-3990X>
References: <20220409101933.207157-1-michalorzel.eng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409101933.207157-1-michalorzel.eng@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Sat, Apr 09, 2022 at 12:19:31PM +0200, Michal Orzel wrote:
> Get rid of redundant assignments which end up in values not being
> read either because they are overwritten or the function ends.
> 
> Reported by clang-tidy [deadcode.DeadStores]
> 
> Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>

Thank you for the patch! This should go through Andrew Morton, now CC'd.

For the future, having some history behind the origin of these warnings
would make review a little easier. I'll comment on each below.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  ipc/sem.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/ipc/sem.c b/ipc/sem.c
> index 0dbdb98fdf2d..38ef91a63edd 100644
> --- a/ipc/sem.c
> +++ b/ipc/sem.c
> @@ -766,7 +766,6 @@ static int perform_atomic_semop(struct sem_array *sma, struct sem_queue *q)
>  	for (sop = sops; sop < sops + nsops; sop++) {
>  		curr = &sma->sems[sop->sem_num];
>  		sem_op = sop->sem_op;
> -		result = curr->semval;

Caused by commit 4ce33ec2e42d ("ipc/sem: optimize
perform_atomic_semop()"). Seems like a simple copy and paste bug.

>  		if (sop->sem_flg & SEM_UNDO) {
>  			int undo = un->semadj[sop->sem_num] - sem_op;
> @@ -1430,7 +1429,6 @@ static int semctl_main(struct ipc_namespace *ns, int semid, int semnum,
>  	if (err)
>  		goto out_rcu_wakeup;
>  
> -	err = -EACCES;

I was not able to figure out this one but it does look correct, as err
is either set properly in the switch statement below or we skip over it
to the 'err = -EINVAL'.

>  	switch (cmd) {
>  	case GETALL:
>  	{
> -- 
> 2.25.1
> 
