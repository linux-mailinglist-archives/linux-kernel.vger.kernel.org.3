Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0AF4EC3D4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 14:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244856AbiC3MTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 08:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344293AbiC3MAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 08:00:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4F9340E9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 04:55:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADCC8B81C25
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:55:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF547C340EE;
        Wed, 30 Mar 2022 11:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648641319;
        bh=1HPyfRo5DHhp9R70XYYumzCEapXTyvDbHoQuEdQvgE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=Jl094britH6ONTd25NFMz9UnjM6d2m3/9NnfHo46z3Um8fGDWUcOui/GLBWC38RRA
         xdE6zLhqI6xQgQ2ZJgjbF3yoRsb7ht61yQaMVgXHfKp79I2dGR8JnZa2KUY3DGVHC7
         Jp+gUYYD3n/3EEpx7/3BztsEaTT5caTyvoW60YurT+x3gYc1bV50tKoekAHRvDxLx2
         Qn/ugnd6Z2FxOrF8T8+ZfHbQfAofOwn9qYza0QbhfeHznqAkPiVuHV+xUctk/M9Xno
         UAkVENvrobHHp5JLTjRooFbFs2hb1AtvPzz18PhHorKwvs8Ql9qGbEFbJLp7tJEwa0
         Kg4JC23/KGPhQ==
From:   sj@kernel.org
To:     Jonghyeon Kim <tome01@ajou.ac.kr>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: prevent activated scheme from sleeping by deactivated schemes
Date:   Wed, 30 Mar 2022 11:55:16 +0000
Message-Id: <20220330115516.32126-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220330105302.32114-1-tome01@ajou.ac.kr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonghyeon,

On Wed, 30 Mar 2022 19:53:02 +0900 Jonghyeon Kim <tome01@ajou.ac.kr> wrote:

> In the DAMON, the minimum wait time of the schemes decides whether the
> kernel wakes up 'kdamon_fn()'. But since the minimum wait time is
> initialized to zero, there are corner cases against the original objective.
> 
> For example, if we have several schemes for one target, and if the wait
> time of the first scheme is zero, the minimum wait time will set zero,
> which means 'kdamond_fn()' should wake up to apply this scheme. However,
> in the following scheme, wait time can be set to non-zero. Thus, the
> mininum wait time will be set to non-zero, which can cause sleeping this
> interval for 'kdamon_fn()' due to one deactivated last scheme.

Good catch, thanks!

> 
> This commit prevents making DAMON monitoring inactive state due to other
> deactivated schemes.
> 
> Signed-off-by: Jonghyeon Kim <tome01@ajou.ac.kr>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  mm/damon/core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index c1e0fed4e877..5ce8d7c867f0 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1019,12 +1019,15 @@ static int kdamond_wait_activation(struct damon_ctx *ctx)
>  	struct damos *s;
>  	unsigned long wait_time;
>  	unsigned long min_wait_time = 0;
> +	bool init_wait_time = false;
>  
>  	while (!kdamond_need_stop(ctx)) {
>  		damon_for_each_scheme(s, ctx) {
>  			wait_time = damos_wmark_wait_us(s);
> -			if (!min_wait_time || wait_time < min_wait_time)
> +			if (!init_wait_time || wait_time < min_wait_time) {
> +				init_wait_time = true;
>  				min_wait_time = wait_time;
> +			}
>  		}
>  		if (!min_wait_time)
>  			return 0;
> -- 
> 2.17.1
> 
