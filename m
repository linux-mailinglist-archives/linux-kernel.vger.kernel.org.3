Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7884D4BF404
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiBVIsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 03:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiBVIsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:48:12 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27598A2F32;
        Tue, 22 Feb 2022 00:47:48 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nMQpn-0001CP-03; Tue, 22 Feb 2022 09:47:47 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 66702C2609; Tue, 22 Feb 2022 09:46:48 +0100 (CET)
Date:   Tue, 22 Feb 2022 09:46:48 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: sibyte: Add missing __user annotations in
 sb_tbprof.c
Message-ID: <20220222084648.GA7123@alpha.franken.de>
References: <20220217142117.107976-1-tsbogend@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217142117.107976-1-tsbogend@alpha.franken.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 03:21:17PM +0100, Thomas Bogendoerfer wrote:
> Add missing __user annotations to fix sparse errors.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
>  arch/mips/sibyte/common/sb_tbprof.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/mips/sibyte/common/sb_tbprof.c b/arch/mips/sibyte/common/sb_tbprof.c
> index f80d7a710333..bc47681e825a 100644
> --- a/arch/mips/sibyte/common/sb_tbprof.c
> +++ b/arch/mips/sibyte/common/sb_tbprof.c
> @@ -437,13 +437,13 @@ static int sbprof_tb_release(struct inode *inode, struct file *filp)
>  	return 0;
>  }
>  
> -static ssize_t sbprof_tb_read(struct file *filp, char *buf,
> +static ssize_t sbprof_tb_read(struct file *filp, char __user *buf,
>  			      size_t size, loff_t *offp)
>  {
>  	int cur_sample, sample_off, cur_count, sample_left;
>  	char *src;
>  	int   count   =	 0;
> -	char *dest    =	 buf;
> +	char __user *dest    =	 buf;
>  	long  cur_off = *offp;
>  
>  	if (!access_ok(buf, size))
> @@ -512,7 +512,7 @@ static long sbprof_tb_ioctl(struct file *filp,
>  		if (err)
>  			break;
>  
> -		err = put_user(TB_FULL, (int *) arg);
> +		err = put_user(TB_FULL, (int __user *) arg);
>  		break;
>  	}
>  
> -- 
> 2.29.2

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
