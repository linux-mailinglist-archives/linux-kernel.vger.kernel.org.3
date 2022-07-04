Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3A656564D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbiGDM7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbiGDM70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:59:26 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730DC6412
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:59:25 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g1so3989593edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 05:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/c6NceqZOpxdz9Qz7DmI9OpDXWn4svfSNEjpEIxhvhs=;
        b=Q2ebZ8Mhph5/9lloeYNrWYsc5hEOr3nuSoZKTfjTidn2Gs+3gJJ1byWcNlyrW2z8dX
         VNa3AOXM1VT/lVeDK8uFzjL/pC1uXEgUD2g2vjSXUIMCy/nkuiZTRk80SxpgP48XLXyK
         Vads9y66dzpkbsivM5jUvmFxmJPlL38+yBgLZNSftAxV7y/+ZS5JR6+Ge5hbmg3QK2P6
         1rgu3t9GyQf+JEakrtJXmX6GFs4828sXLsxUlavkRustDeckrhVKXuhKhNDmnxTACBay
         QrXmRoJA04eGslw3dXDxgDtE7BsyOKUf5rOicakq64PhUi3lUM+J+lI8GLXbCzuggEah
         /Pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/c6NceqZOpxdz9Qz7DmI9OpDXWn4svfSNEjpEIxhvhs=;
        b=uyQDE+v68a+rVPn2yUZRo5x1LX93yOeRdABiOMC5GaGtpIM99760gknnacbHajUZUt
         6Qu4oFw95cd7rf7AN/754xcxhE72WrnvBactKP4RGzKTE++vEbpsuplSm5hTUbNaCB03
         myt7U559FtJe84ZyOx5quanpK2tOzSO8TEbNqA1k9O1IVkodS7hZHoE7yVZ7phtjOhY9
         6cfXnrcHnPpWNkxH/QSIZ2Vp/AIpHNldkFJNaqlnHX3eu+9YyweW48HY0MGjyXpfhNDy
         G3FZTl9jiCqbGGRbxTGLNTcN+gclVWBfvfs+AIJ6AhVj/e3T/BrqS/m0psBkpFtZuHXD
         KKSQ==
X-Gm-Message-State: AJIora+wHeb6q2BbfV/DU7lRPooqZ6Kpzz3MoRc6av+rYIQx2Y0x6sVC
        1j7zj+mFT+C9PS3Ja/BAa8ek
X-Google-Smtp-Source: AGRyM1u8pdloSzgIJDGaHAuj3T6Est3niK05Lma89CQs3LVc4e5iydpJhBJDd8eCxcXm1yqeGeLomQ==
X-Received: by 2002:a05:6402:1bda:b0:43a:55d7:9f2f with SMTP id ch26-20020a0564021bda00b0043a55d79f2fmr6649669edb.360.1656939563820;
        Mon, 04 Jul 2022 05:59:23 -0700 (PDT)
Received: from google.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id s12-20020a1709064d8c00b00722e50e259asm14050507eju.102.2022.07.04.05.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:59:23 -0700 (PDT)
Date:   Mon, 4 Jul 2022 12:59:19 +0000
From:   Wedson Almeida Filho <wedsonaf@google.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] char: misc: make misc_open() and misc_register() killable
Message-ID: <YsLkJ1LMMnM9Mo0K@google.com>
References: <000000000000d9ff3a05bb37069e@google.com>
 <72e74af9-f1b6-e383-a2c3-6ee8a0aea5e0@I-love.SAKURA.ne.jp>
 <YsKW6VvWqvcMRBSl@kroah.com>
 <100f445e-9fa8-4f37-76aa-8359f0008c59@I-love.SAKURA.ne.jp>
 <YsLIepAXeBKT0AF/@kroah.com>
 <01a93294-e323-b9ca-7e95-a33d4b89dc47@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01a93294-e323-b9ca-7e95-a33d4b89dc47@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 09:34:04PM +0900, Tetsuo Handa wrote:
> On 2022/07/04 20:01, Greg KH wrote:
> > On Mon, Jul 04, 2022 at 07:25:44PM +0900, Tetsuo Handa wrote:
> >> On 2022/07/04 16:29, Greg KH wrote:
> >>> On Mon, Jul 04, 2022 at 03:44:07PM +0900, Tetsuo Handa wrote:
> >>>> syzbot is reporting hung task at misc_open() [1], for snapshot_open() from
> >>>> misc_open() might sleep for long with misc_mtx held whereas userspace can
> >>>> flood with concurrent misc_open() requests. Mitigate this problem by making
> >>>> misc_open() and misc_register() killable.
> >>>
> >>> I do not understand, why not just fix snapshot_open()?  Why add this
> >>> complexity to the misc core for a foolish individual misc device?  Why
> >>> not add the fix there where it is spinning instead?
> >>
> >> Quoting an example from [1]. Multiple processes are calling misc_open() and
> >> all but one processes are blocked at mutex_lock(&misc_mtx). The one which is
> >> not blocked at mutex_lock(&misc_mtx) is also holding system_transition_mutex.
> > 
> > And that is because of that one misc device, right?  Why not fix that
> > instead of papering over the issue in the misc core?
> 
> Since "struct file_operations"->open() is allowed to sleep, calling
> "struct file_operations"->open() via reassignment by "struct miscdevice"->fops
> with locks held can cause problems.
> 
> Assuming that this is not a deadlock hidden by device_initialize(), current
> mutex_lock(&misc_mtx) is as problematic as major_names_lock mentioned at
> https://lkml.kernel.org/r/b2af8a5b-3c1b-204e-7f56-bea0b15848d6@i-love.sakura.ne.jp .
> 
> >> If you don't like mutex_lock_killable(&misc_mtx), we will need to consider moving
> >> file->f_op->open() from misc_open() to after mutex_unlock(&misc_mtx).
> 
> Below is minimal changes for avoid calling "struct file_operations"->open() with
> misc_mtx held. This would be nothing but moving hung task warning from misc_open()
> to snapshot_open() (and therefore we would need to introduce killable version of
> lock_system_sleep()), but we can avoid making misc_mtx like major_names_lock above.
> 
> Greg, can you accept this minimal change?
> 
>  drivers/char/misc.c        | 4 ++++
>  include/linux/miscdevice.h | 1 +
>  kernel/power/user.c        | 1 +
>  3 files changed, 6 insertions(+)
> 
> diff --git a/drivers/char/misc.c b/drivers/char/misc.c
> index cba19bfdc44d..292c86c090b9 100644
> --- a/drivers/char/misc.c
> +++ b/drivers/char/misc.c
> @@ -139,6 +139,10 @@ static int misc_open(struct inode *inode, struct file *file)
>  
>  	err = 0;
>  	replace_fops(file, new_fops);
> +	if (iter->unlocked_open && file->f_op->open) {
> +		mutex_unlock(&misc_mtx);
> +		return file->f_op->open(inode, file);
> +	}

One of the invariants of miscdev is that once misc_deregister() returns,
no new calls to f_op->open() are made. (Although, of course, you can
still have open files but that's a whole different problem.)

This change breaks this invariant which I think is problematic because
drivers then can't know when new calls to open() are guaranteed to stop
coming.

>  	if (file->f_op->open)
>  		err = file->f_op->open(inode, file);
>  fail:
> diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
> index 0676f18093f9..e112ef9e3b7b 100644
> --- a/include/linux/miscdevice.h
> +++ b/include/linux/miscdevice.h
> @@ -86,6 +86,7 @@ struct miscdevice  {
>  	const struct attribute_group **groups;
>  	const char *nodename;
>  	umode_t mode;
> +	bool unlocked_open;
>  };
>  
>  extern int misc_register(struct miscdevice *misc);
> diff --git a/kernel/power/user.c b/kernel/power/user.c
> index ad241b4ff64c..69a269c4fb46 100644
> --- a/kernel/power/user.c
> +++ b/kernel/power/user.c
> @@ -441,6 +441,7 @@ static struct miscdevice snapshot_device = {
>  	.minor = SNAPSHOT_MINOR,
>  	.name = "snapshot",
>  	.fops = &snapshot_fops,
> +	.unlocked_open = true,
>  };
>  
>  static int __init snapshot_device_init(void)
> -- 
> 2.34.1
> 
