Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42CD510EC7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 04:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357179AbiD0C3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 22:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357112AbiD0C3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 22:29:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036DE1D33E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 19:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=WSjKmLQyR2S4LIY/EUzD5iaRuwjMdR4LCRRTo1tRKDw=; b=0yyZDH3T9G+9uEoWfpiaa0EEN3
        TwJqiepQ7r24lVaBLSptvN5txJAseD3OQWREhdDnbiAblN0MBxQgEvAQxnwrhwfCC6btXEZfARsSc
        V8vt6obH1DrDTRbFC1Z0jYa9sU+4ScJYNsL4iyi7sHBBJKkPaweTVbeG0dg66UHz29QALzJS2xunO
        U+WqkksYMdF5okSiNJcYj8EHeZszYxLix14GDUcY6gVX4+JNK74jhKg61LtL4S8KkWr/bpGKhjuN5
        /Zi8L/Zk4I4dloS6Xb90VHOieUlZtfNzYxY6ELvwNtkjYlbJrb71+OyqU2oXLBi0XGOjPJ1cjVTWc
        6gmDj62g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1njXNQ-00H3sZ-PI; Wed, 27 Apr 2022 02:26:00 +0000
Date:   Tue, 26 Apr 2022 19:26:00 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     tangmeng@uniontech.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] reboot: Fix build warning without CONFIG_SYSFS
Message-ID: <YmipuA+t9YcRI5X7@bombadil.infradead.org>
References: <20220407074807.1580-1-yuehaibing@huawei.com>
 <3d54a148-922d-3da4-b564-44996ca56241@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d54a148-922d-3da4-b564-44996ca56241@huawei.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Your subject says CONFIG_SYSFS but this is for CONFIG_SYSCTL right?
Can you fix and resubmit  and based it on sysctl-next [0]?

If I've missed any other patches please resubmit as well and use
the [PATCH sysctl-next] as prefix.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=sysctl-next

  Luis

On Wed, Apr 27, 2022 at 09:56:35AM +0800, YueHaibing wrote:
> ping...
> 
> On 2022/4/7 15:48, YueHaibing wrote:
> > If CONFIG_SYSFS is n, build warn:
> > 
> > kernel/reboot.c:443:20: error: ‘kernel_reboot_sysctls_init’ defined but not used [-Werror=unused-function]
> >  static void __init kernel_reboot_sysctls_init(void)
> >                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > Move kernel_reboot_sysctls_init() to #ifdef block to fix this.
> > 
> > Fixes: 6e73c8344931 ("kernel/reboot: move reboot sysctls to its own file")
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >  kernel/reboot.c | 54 ++++++++++++++++++++++++-------------------------
> >  1 file changed, 27 insertions(+), 27 deletions(-)
> > 
> > diff --git a/kernel/reboot.c b/kernel/reboot.c
> > index ed4e6dfb7d44..ecbf09ea03c5 100644
> > --- a/kernel/reboot.c
> > +++ b/kernel/reboot.c
> > @@ -421,33 +421,6 @@ void ctrl_alt_del(void)
> >  static char poweroff_cmd[POWEROFF_CMD_PATH_LEN] = "/sbin/poweroff";
> >  static const char reboot_cmd[] = "/sbin/reboot";
> >  
> > -#ifdef CONFIG_SYSCTL
> > -static struct ctl_table kern_reboot_table[] = {
> > -	{
> > -		.procname       = "poweroff_cmd",
> > -		.data           = &poweroff_cmd,
> > -		.maxlen         = POWEROFF_CMD_PATH_LEN,
> > -		.mode           = 0644,
> > -		.proc_handler   = proc_dostring,
> > -	},
> > -	{
> > -		.procname       = "ctrl-alt-del",
> > -		.data           = &C_A_D,
> > -		.maxlen         = sizeof(int),
> > -		.mode           = 0644,
> > -		.proc_handler   = proc_dointvec,
> > -	},
> > -	{ }
> > -};
> > -
> > -static void __init kernel_reboot_sysctls_init(void)
> > -{
> > -	register_sysctl_init("kernel", kern_reboot_table);
> > -}
> > -#else
> > -#define kernel_reboot_sysctls_init() do { } while (0)
> > -#endif /* CONFIG_SYSCTL */
> > -
> >  static int run_cmd(const char *cmd)
> >  {
> >  	char **argv;
> > @@ -895,6 +868,33 @@ static struct attribute *reboot_attrs[] = {
> >  	NULL,
> >  };
> >  
> > +#ifdef CONFIG_SYSCTL
> > +static struct ctl_table kern_reboot_table[] = {
> > +	{
> > +		.procname       = "poweroff_cmd",
> > +		.data           = &poweroff_cmd,
> > +		.maxlen         = POWEROFF_CMD_PATH_LEN,
> > +		.mode           = 0644,
> > +		.proc_handler   = proc_dostring,
> > +	},
> > +	{
> > +		.procname       = "ctrl-alt-del",
> > +		.data           = &C_A_D,
> > +		.maxlen         = sizeof(int),
> > +		.mode           = 0644,
> > +		.proc_handler   = proc_dointvec,
> > +	},
> > +	{ }
> > +};
> > +
> > +static void __init kernel_reboot_sysctls_init(void)
> > +{
> > +	register_sysctl_init("kernel", kern_reboot_table);
> > +}
> > +#else
> > +#define kernel_reboot_sysctls_init() do { } while (0)
> > +#endif /* CONFIG_SYSCTL */
> > +
> >  static const struct attribute_group reboot_attr_group = {
> >  	.attrs = reboot_attrs,
> >  };
> > 
