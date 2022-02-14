Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9A14B5B84
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiBNUxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 15:53:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiBNUxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 15:53:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E743F192F31
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 12:52:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD973B81686
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 20:17:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821D1C340F3;
        Mon, 14 Feb 2022 20:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644869850;
        bh=bXedr7UYLlyWE7FAXfDmfEHymhA7Ze+P5ADWEtsZEic=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XPCbTkjP1VOKsDUMzqRYehjXZhYthTIrtpBGr8H0ZzYaQftPi9E96AvzWlsECj3od
         ybGN/h2z0/9LE0PHegdMnRe2GK0jn48FgZs4vur8NnXdyaaUNX82APoekloLzGGa+l
         BmRXENTBjJJZMx0HUAho4F4DG+Se2O87upjPEDZhSFi7FYFdDiUVJi4uWNUmHGHZME
         zvdOhhONFmU6NrbBkfcCcr6fDLTyYAytGzRsivGOedC8KJE/XGAInWwyeemT11Gkdn
         RIcq7MT3ZG17lyIF9uthSy4H6AhbdKG/3DLgeLJA43ZKQzjBqVDX4Qzqq2CkIBxxXY
         nBOvy3QArrg5Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 472305C0388; Mon, 14 Feb 2022 12:17:30 -0800 (PST)
Date:   Mon, 14 Feb 2022 12:17:30 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/42] tools/nolibc/types: make FD_SETSIZE configurable
Message-ID: <20220214201730.GA4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220207162354.14293-1-w@1wt.eu>
 <20220207162354.14293-13-w@1wt.eu>
 <20220213085301.GB31914@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220213085301.GB31914@1wt.eu>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2022 at 09:53:01AM +0100, Willy Tarreau wrote:
> The macro was hard-coded to 256 but it's common to see it redefined.
> Let's support this and make sure we always allocate enough entries for
> the cases where it wouldn't be multiple of 32.
> 
> Signed-off-by: Willy Tarreau <w@1wt.eu>

I queued both in place of their earlier versions, thank you!

							Thanx, Paul

> ---
> v2:
> - rebase on top of v2 of previous patch
> ---
>  tools/include/nolibc/types.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
> index a4dda0a22fc2..563dbbad0496 100644
> --- a/tools/include/nolibc/types.h
> +++ b/tools/include/nolibc/types.h
> @@ -45,7 +45,9 @@
>  #define DT_SOCK        0xc
>  
>  /* commonly an fd_set represents 256 FDs */
> +#ifndef FD_SETSIZE
>  #define FD_SETSIZE     256
> +#endif
>  
>  /* Special FD used by all the *at functions */
>  #ifndef AT_FDCWD
> @@ -72,7 +74,7 @@
>  
>  /* for select() */
>  typedef struct {
> -	uint32_t fd32[FD_SETSIZE / 32];
> +	uint32_t fd32[(FD_SETSIZE + 31) / 32];
>  } fd_set;
>  
>  #define FD_CLR(fd, set) do {                                            \
> @@ -101,7 +103,7 @@ typedef struct {
>  #define FD_ZERO(set) do {                                               \
>  		fd_set *__set = (set);                                  \
>  		int __idx;                                              \
> -		for (__idx = 0; __idx < FD_SETSIZE / 32; __idx ++)      \
> +		for (__idx = 0; __idx < (FD_SETSIZE+31) / 32; __idx ++) \
>  			__set->fd32[__idx] = 0;                         \
>  	} while (0)
>  
> -- 
> 2.35.1
