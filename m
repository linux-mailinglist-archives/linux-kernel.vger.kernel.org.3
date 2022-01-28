Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E89549F8DB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 13:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348180AbiA1MEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 07:04:25 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58892 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242285AbiA1MEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 07:04:24 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 372A521102;
        Fri, 28 Jan 2022 12:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643371463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eScZUL/hK44czXnWhXbOJCWGqu8dIN75GFAtP6MX5Uw=;
        b=VKH2RypvIkSL1QDYbFOdrGDxMAJxW5Te+WPE7Krx1EU5G6z1pIH34dQMNkI86bJIirEmoh
        gf5JQAVAweOmQqVmIkYAIAm6A8SDuwobcEDzFcXj4LR/qY37i5XBHFjqq+mTDGmygmVMq9
        uGT0iBlGOowHv/u9yhYKK5HrpIO4QgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643371463;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eScZUL/hK44czXnWhXbOJCWGqu8dIN75GFAtP6MX5Uw=;
        b=50xxrgkimoLBvNbLPjJEvTRM14Te5jLk1bI/d9zo+tcpb4xAzgTDBcyRP0IK6eIFfpvGMW
        bL/XZex+fXn+kTCg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B814FA3B84;
        Fri, 28 Jan 2022 12:04:21 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5B1E4A05E6; Fri, 28 Jan 2022 13:04:21 +0100 (CET)
Date:   Fri, 28 Jan 2022 13:04:21 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Antti Palosaari <crope@iki.fi>, Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        David Airlie <airlied@linux.ie>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Kees Cook <keescook@chromium.org>,
        Lukas Middendorf <kernel@tuxforce.de>,
        Mark Fasheh <mark@fasheh.com>, Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Qing Wang <wangqing@vivo.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Stephen Kitt <steve@sk2.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jani Nikula <jani.nikula@intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [ocfs2] c42ff46f97: sysctl_table_check_failed
Message-ID: <20220128120421.kzo5iduigr7k55bs@quack3.lan>
References: <20220128065310.GF8421@xsang-OptiPlex-9020>
 <CAHk-=wgT6wuBB=pK2bGNQbioNCdJHT8Jnvs+4oT25jX1JFyhgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgT6wuBB=pK2bGNQbioNCdJHT8Jnvs+4oT25jX1JFyhgg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 28-01-22 10:00:29, Linus Torvalds wrote:
> On Fri, Jan 28, 2022 at 8:53 AM kernel test robot <oliver.sang@intel.com> wrote:
> >
> > commit: 46e33fd45a52bf03769906e64d8a8a1ab317777d ("ocfs2: simplify subdirectory
> > registration with register_sysctl()")
> 
> Well, it's apparently commit c42ff46f97c1 ("ocfs2: simplify
> subdirectory registration with register_sysctl()") in mainline now.
> 
> What worries me a bit is that the commit was auto-generated, and when
> reading the commit message it reads as if it wasn't supposed to cause
> any semantic changes at all.
> 
> Is the cause of this that 'nm' is supposed to be a directory, and
> register_sysctl() doesn't handle directories?
> 
> I don't know this code at all, should it have been simplified even
> further with something (TOTALLY UNTESTED) like the attached?

Yep, I've tested the patch and it fixes the failure for me. Feel free to
add:

Tested-by: Jan Kara <jack@suse.cz>

Also the change makes sense to me as far as I'm reading register_sysctl()
so you can also add:

Reviewed-by: Jan Kara <jack@suse.cz>



								Honza

> diff --git a/fs/ocfs2/stackglue.c b/fs/ocfs2/stackglue.c
> index 731558a6f27d..dd77b7aaabf5 100644
> --- a/fs/ocfs2/stackglue.c
> +++ b/fs/ocfs2/stackglue.c
> @@ -661,17 +661,6 @@ static struct ctl_table ocfs2_nm_table[] = {
>  	{ }
>  };
>  
> -static struct ctl_table ocfs2_mod_table[] = {
> -	{
> -		.procname	= "nm",
> -		.data		= NULL,
> -		.maxlen		= 0,
> -		.mode		= 0555,
> -		.child		= ocfs2_nm_table
> -	},
> -	{ }
> -};
> -
>  static struct ctl_table_header *ocfs2_table_header;
>  
>  /*
> @@ -682,7 +671,7 @@ static int __init ocfs2_stack_glue_init(void)
>  {
>  	strcpy(cluster_stack_name, OCFS2_STACK_PLUGIN_O2CB);
>  
> -	ocfs2_table_header = register_sysctl("fs/ocfs2", ocfs2_mod_table);
> +	ocfs2_table_header = register_sysctl("fs/ocfs2/nm", ocfs2_nm_table);
>  	if (!ocfs2_table_header) {
>  		printk(KERN_ERR
>  		       "ocfs2 stack glue: unable to register sysctl\n");

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
