Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C594E8D9A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 07:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237993AbiC1FxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 01:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238212AbiC1FxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 01:53:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFCA33341
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 22:51:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AFA461090
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:51:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F36C340F0;
        Mon, 28 Mar 2022 05:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648446682;
        bh=5yhqlk3zoR0qYGQNQjMGzqhRFu97MESVIycfNGiorlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kUHr6LRqEbUjvrgdgMedy8ONSD6waL1CSDeYs4uhY4dTAYKj1/Y5jw4fKUWmVGLPy
         6Ap2FPeZ2gzdORBsiMF1MMXqJF41MYHeNyIf8hJTCR3d1ElNUmX3wvGH9bpDt83TAA
         0FzkJ9mT4M6st1ivaGI8UnNRFccsA60QVriK/8R8=
Date:   Mon, 28 Mar 2022 07:51:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     wujunwen <wudaemon@163.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] char: misc:use DEFINE_PROC_SHOW_ATTRIBUTE micro to
 simplify misc proc_fops
Message-ID: <YkFM2Ko21j8Ehca8@kroah.com>
References: <20220327143254.226844-1-wudaemon@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220327143254.226844-1-wudaemon@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2022 at 02:32:54PM +0000, wujunwen wrote:
> DEFINE_PROC_SHOW_ATTRIBUTE is used to simply seq_file flow ,so
> we can use it to simplify misc proc_fops.
> 
> Signed-off-by: wujunwen <wudaemon@163.com>
> ---
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
>  	misc_class = class_create(THIS_MODULE, "misc");
>  	err = PTR_ERR(misc_class);
>  	if (IS_ERR(misc_class))
> @@ -284,8 +269,10 @@ static int __init misc_init(void)
>  	pr_err("unable to get major %d for misc devices\n", MISC_MAJOR);
>  	class_destroy(misc_class);
>  fail_remove:
> +#ifdef CONFIG_PROC_FS
>  	if (ret)
>  		remove_proc_entry("misc", NULL);
> +#endif
>  	return err;
>  }
>  subsys_initcall(misc_init);
> -- 
> 2.25.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
