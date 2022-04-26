Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A478D50FB76
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346516AbiDZKyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344794AbiDZKyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:54:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D7A811AF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 03:51:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D76EF617A2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 10:51:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65E9C385A0;
        Tue, 26 Apr 2022 10:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650970273;
        bh=Gu4pPCeKKrUEqOGHSXtxxkYMfQZMFX7rjsXT5ou/zXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tB5mHnPksek/UtHA4dSYZoqvlk1dS6EN+oOcilNx4C3Gt4unNBdMaQJlTJQy7PtZr
         pfkZj7NUmsXTMoM0N+NRe38SqSMOFvs0LoX8n/Rg+izIMA4vNSsYo5jaAxagdqHxOb
         LbD7vkvlBgImNV/AGmd/8WASAFHSjOIlrD0nr60w=
Date:   Tue, 26 Apr 2022 12:51:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Junwen Wu <wudaemon@163.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] char: misc:use DEFINE_PROC_SHOW_ATTRIBUTE
 micro to simplify misc proc_fops
Message-ID: <YmfOncISX6vjQW2I@kroah.com>
References: <20220410151628.288568-1-wudaemon@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220410151628.288568-1-wudaemon@163.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2022 at 03:16:27PM +0000, Junwen Wu wrote:
> From: wujunwen <wudaemon@163.com>
> 
> DEFINE_PROC_SHOW_ATTRIBUTE is used to simply seq_file flow ,so
> we can use it to simplify misc proc_fops.
> 
> Signed-off-by: wujunwen <wudaemon@163.com>
> ---
> V1 -> V2: Fix compile error with no "CONFIG_PROC_FS"
> 
>  drivers/char/misc.c | 41 ++++++++++++++---------------------------
>  1 file changed, 14 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/char/misc.c b/drivers/char/misc.c
> index ca5141ed5ef3..076b7f08aa7a 100644
> --- a/drivers/char/misc.c
> +++ b/drivers/char/misc.c
> @@ -64,40 +64,23 @@ static DEFINE_MUTEX(misc_mtx);
>  static DECLARE_BITMAP(misc_minors, DYNAMIC_MINORS);
>  
>  #ifdef CONFIG_PROC_FS
> -static void *misc_seq_start(struct seq_file *seq, loff_t *pos)
> -{
> -	mutex_lock(&misc_mtx);
> -	return seq_list_start(&misc_list, *pos);
> -}
>  
> -static void *misc_seq_next(struct seq_file *seq, void *v, loff_t *pos)
> +static int misc_show(struct seq_file *seq, void *v)
>  {
> -	return seq_list_next(v, &misc_list, pos);
> -}
> +	const struct miscdevice *p;
>  
> -static void misc_seq_stop(struct seq_file *seq, void *v)
> -{
> +	mutex_lock(&misc_mtx);
> +	list_for_each_entry(p, &misc_list, list) {
> +		seq_printf(seq, "%3i %s\n", p->minor, p->name ? p->name : "");
> +	}
>  	mutex_unlock(&misc_mtx);
> -}
> -
> -static int misc_seq_show(struct seq_file *seq, void *v)
> -{
> -	const struct miscdevice *p = list_entry(v, struct miscdevice, list);
> -
> -	seq_printf(seq, "%3i %s\n", p->minor, p->name ? p->name : "");
>  	return 0;
>  }
>  
> -
> -static const struct seq_operations misc_seq_ops = {
> -	.start = misc_seq_start,
> -	.next  = misc_seq_next,
> -	.stop  = misc_seq_stop,
> -	.show  = misc_seq_show,
> -};
> +DEFINE_PROC_SHOW_ATTRIBUTE(misc);
>  #endif
>  
> -static int misc_open(struct inode *inode, struct file *file)
> +static int misc_fops_open(struct inode *inode, struct file *file)
>  {
>  	int minor = iminor(inode);
>  	struct miscdevice *c;
> @@ -148,7 +131,7 @@ static struct class *misc_class;
>  
>  static const struct file_operations misc_fops = {
>  	.owner		= THIS_MODULE,
> -	.open		= misc_open,
> +	.open		= misc_fops_open,
>  	.llseek		= noop_llseek,
>  };
>  
> @@ -266,9 +249,11 @@ static char *misc_devnode(struct device *dev, umode_t *mode)
>  static int __init misc_init(void)
>  {
>  	int err;
> +#ifdef CONFIG_PROC_FS
>  	struct proc_dir_entry *ret;
>  
> -	ret = proc_create_seq("misc", 0, NULL, &misc_seq_ops);
> +	ret = proc_create("misc", 0, NULL, &misc_proc_ops);
> +#endif

Any way to do this without the #ifdef in the middle of the function?
Otherwise it's not worth taking this change at all.

thanks,

greg k-h
