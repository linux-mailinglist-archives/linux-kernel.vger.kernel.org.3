Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2D14FC8F7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 01:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbiDKXvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 19:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbiDKXvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 19:51:12 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EA03A1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 16:48:56 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 847731F43D1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649720935;
        bh=oI6hnYERusLhtLVPGlcNsCzVUU5OzY2uWiz/zUkB3DM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=gDnPu7T7KFO0lxkOhRZ5NrzbFXQ1z2DxyhFkNGTxIPB7+7NamQlXgfa1Z/meNWHWG
         HkTpBhJXDUjM48VmNlmpixeFKaIfu6oUxbQu9cod4IvAkXkJ4CUfQxB+IfVABR/G4l
         tp6VrA3kpDKwBw1RVTWBAN8x5748pJ3cXiEX5gMNkS/b0NTtEm3pj1c96HZhQdnV0M
         iq4U1PJjjEQXx26DfOnRDVsjgw+koK+b5JBB8jGDuMC+/Z1Nc1i/nloq/d+FM+MkL+
         ViioQVeXkmwNjgvUIK5lpXTDZ3Cc0zEXfCF5aU0InT+ZcavuvLaRRUvMRwqXUx+r1J
         fB31U9szgnVLw==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Khazhismel Kumykov <khazhy@google.com>
Cc:     Mike Snitzer <snitzer@kernel.org>,
        Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dm mpath: fixup sched_clock() usage in historical selector
Organization: Collabora
References: <20220411220335.1235363-1-khazhy@google.com>
Date:   Mon, 11 Apr 2022 19:48:53 -0400
In-Reply-To: <20220411220335.1235363-1-khazhy@google.com> (Khazhismel
        Kumykov's message of "Mon, 11 Apr 2022 15:03:35 -0700")
Message-ID: <87wnfvxjtm.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Khazhismel Kumykov <khazhy@google.com> writes:

> mixing sched_clock() and ktime_get_ns() will give bad results, don't do
> it
>
> Fixes: 2613eab11996 ("dm mpath: add Historical Service Time Path Selector")
> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>

Looks good.

Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>


> ---
>  drivers/md/dm-ps-historical-service-time.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/md/dm-ps-historical-service-time.c b/drivers/md/dm-ps-historical-service-time.c
> index 875bca30a0dd..82f2a06153dc 100644
> --- a/drivers/md/dm-ps-historical-service-time.c
> +++ b/drivers/md/dm-ps-historical-service-time.c
> @@ -27,7 +27,6 @@
>  #include <linux/blkdev.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> -#include <linux/sched/clock.h>
>  
>  
>  #define DM_MSG_PREFIX	"multipath historical-service-time"
> @@ -433,7 +432,7 @@ static struct dm_path *hst_select_path(struct path_selector *ps,
>  {
>  	struct selector *s = ps->context;
>  	struct path_info *pi = NULL, *best = NULL;
> -	u64 time_now = sched_clock();
> +	u64 time_now = ktime_get_ns();
>  	struct dm_path *ret = NULL;
>  	unsigned long flags;
>  
> @@ -474,7 +473,7 @@ static int hst_start_io(struct path_selector *ps, struct dm_path *path,
>  
>  static u64 path_service_time(struct path_info *pi, u64 start_time)
>  {
> -	u64 sched_now = ktime_get_ns();
> +	u64 now = ktime_get_ns();
>  
>  	/* if a previous disk request has finished after this IO was
>  	 * sent to the hardware, pretend the submission happened
> @@ -483,11 +482,11 @@ static u64 path_service_time(struct path_info *pi, u64 start_time)
>  	if (time_after64(pi->last_finish, start_time))
>  		start_time = pi->last_finish;
>  
> -	pi->last_finish = sched_now;
> -	if (time_before64(sched_now, start_time))
> +	pi->last_finish = now;
> +	if (time_before64(now, start_time))
>  		return 0;
>  
> -	return sched_now - start_time;
> +	return now - start_time;
>  }
>  
>  static int hst_end_io(struct path_selector *ps, struct dm_path *path,

-- 
Gabriel Krisman Bertazi
