Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7F4482B9B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 15:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbiABOr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 09:47:59 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56152 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiABOr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 09:47:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 151E660EB6
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 14:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4577BC36AEE;
        Sun,  2 Jan 2022 14:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641134877;
        bh=cB+fa+WheTCJVrwer8gc3I2M2C/JBkGr/+r0pm2W0Us=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d/lE6nRWyVQyYVisHuhd8JGZKZ9dlIJD8Eu3GPx9kmGdtZoD2xmlHNkGeq5qPHQZs
         MKotZIPGFsLDapBj6qKn1fMSomKLOunfHHZPCola4gHZo3mad6NB5DjsubKi1Qlzgm
         9cKEJKj4JR/uQlzdct+ChGJab8Q3z9v3rDlpEF0qgPRIKsWiSjNsfTGLDi8vb9vyGT
         Z/bud/qA4lVKTsTbMCZ5XVZynaIPngKNI9+nkdPNWtjxKfKkt2PJ5O68cNDMSzYoxE
         wxlObYDvIj9C58tlLzLLVj+KbaJbcQHzqyobo/8H0pYe3NHwmS4vXlcNjgFTXduzqt
         bINCCk3P5hcLQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3634840B92; Sun,  2 Jan 2022 11:47:55 -0300 (-03)
Date:   Sun, 2 Jan 2022 11:47:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     yaowenbin <yaowenbin1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        hewenliang4@huawei.com, wuxu.wu@huawei.com
Subject: Re: [PATCH] perf top: add concurrent access protection of the SLsmg
 screen management
Message-ID: <YdG7GwIvehIOwUfJ@kernel.org>
References: <a91e3943-7ddc-f5c0-a7f5-360f073c20e6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a91e3943-7ddc-f5c0-a7f5-360f073c20e6@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 29, 2021 at 04:55:19PM +0800, yaowenbin escreveu:
> When the following command is executed several times, a coredump file is generated.
> 	$ timeout -k 9 5 perf top -e task-clock
> 	*******
> 	*******
> 	*******
> 	0.01%  [kernel]                  [k] __do_softirq
> 	0.01%  libpthread-2.28.so        [.] __pthread_mutex_lock
> 	0.01%  [kernel]                  [k] __ll_sc_atomic64_sub_return
> 	double free or corruption (!prev) perf top --sort comm,dso
> 	timeout: the monitored command dumped core

Thanks, tested, reproduced the problem without the patch, not managed to
reproduce in 50 calls to the reproducer after applying the patch.

- Arnaldo
 
> When we terminate "perf top" using sending signal method, SLsmg_reset_smg
> function is called. SLsmg_reset_smg resets the SLsmg screen management routines
> by freeing all memory allocated while it was active. However SLsmg_reinit_smg
> function maybe be called by another thread. SLsmg_reinit_smg function will
> free the same memory accessed by SLsmg_reset_smg functon, thus it results
> in double free. SLsmg_reinit_smg function is called already protected by
> ui__lock, so we fix the problem by adding pthread_mutex_trylock of ui__lock
> when calling SLsmg_reset_smg function.
> 
> Signed-off-by: yaowenbin <yaowenbin1@huawei.com>
> Signed-off-by: hewenliang <hewenliang4@huawei.com>
> Signed-off-by: Wenyu Liu <liuwenyu7@huawei.com>
> ---
>  tools/perf/ui/tui/setup.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/ui/tui/setup.c b/tools/perf/ui/tui/setup.c
> index d4ac41679..1fdf92062 100644
> --- a/tools/perf/ui/tui/setup.c
> +++ b/tools/perf/ui/tui/setup.c
> @@ -170,9 +170,11 @@ void ui__exit(bool wait_for_ok)
>  				    "Press any key...", 0);
> 
>  	SLtt_set_cursor_visibility(1);
> -	SLsmg_refresh();
> -	SLsmg_reset_smg();
> +	if (!pthread_mutex_trylock(&ui__lock)) {
> +		SLsmg_refresh();
> +		SLsmg_reset_smg();
> +		pthread_mutex_unlock(&ui__lock);
> +	}
>  	SLang_reset_tty();
> -
>  	perf_error__unregister(&perf_tui_eops);
>  }
> --
> 2.27.0

-- 

- Arnaldo
