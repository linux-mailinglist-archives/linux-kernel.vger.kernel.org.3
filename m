Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B964CB052
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243907AbiCBUyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbiCBUyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:54:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320ADCA0C8;
        Wed,  2 Mar 2022 12:53:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD650B82231;
        Wed,  2 Mar 2022 20:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22413C340E9;
        Wed,  2 Mar 2022 20:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1646254410;
        bh=TgloV4B2vCHdyFP/LtMGAUPUvrUDGKFnl1FOodTZlcI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ju0i4BULb8yoAdghQyVOOuGhBEhxPN1NBrXlxuAeZbje+6657mDkuLw9rQvumpEx0
         x8BvHCVbA8QBeOZNJ+lGhMfCgDJQlANOCRKSLmElPKAgu50rpcT00004hN4HLdDT39
         VyRrPTW+nM4/gLe253KnWBeB4BUEyH95lbGZn6ZA=
Date:   Wed, 2 Mar 2022 12:53:29 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     SeongJae Park <sj@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-mm@kvack.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/sysfs: Fix an array out-of-bounds read error
 due
Message-Id: <20220302125329.65bc251ab9c2df865146a5ae@linux-foundation.org>
In-Reply-To: <20220302180252.1099406-1-colin.i.king@gmail.com>
References: <20220302180252.1099406-1-colin.i.king@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  2 Mar 2022 18:02:52 +0000 Colin Ian King <colin.i.king@gmail.com> wrote:

> There is an off-by-one error in the upper limit to a for-loop that
> causes an out-of-bounds read error on the array
> damon_sysfs_wmark_metric_strs. Fix the comparison by replacing
> the <= operator with <.
> 

Thanks, we already have
https://lkml.kernel.org/r/20220301185619.2904-1-sj@kernel.org
