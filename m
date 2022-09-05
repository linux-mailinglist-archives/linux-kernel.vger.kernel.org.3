Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471675AD5F0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237907AbiIEPNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237816AbiIEPM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:12:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3B3110E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:12:21 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7C66933D1E;
        Mon,  5 Sep 2022 15:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662390739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hObMCSRjGaA64MN6hMJJwF3Wk1+3FIhA8Eih0G9Sk6M=;
        b=KUKqOkYyi0ZGXOi+VsoZ+82tPLXeo8b3WwgMisIXJtiTHPQYcDVHdo19gWHgi0DkRw2h5i
        r9sptFXXj4iXpj3MKE9TxOcUXL2/UNcD+5n3o4Ttnq3K8ljffRsr8iTirBCkNPPa95s6HZ
        km0u2Ixv1mFBq+MUS+THBK3Z/4sgJT4=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1D7BB2C141;
        Mon,  5 Sep 2022 15:12:18 +0000 (UTC)
Date:   Mon, 5 Sep 2022 17:12:15 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: [PATCH v3 2/2] printk: console: Support console-specific
 loglevels
Message-ID: <YxYRzw/W+3LwtGFv@alley>
References: <cover.1658339046.git.chris@chrisdown.name>
 <b9fa85cfed3a97ab4292daca51476e4e23da2f9a.1658339046.git.chris@chrisdown.name>
 <YxB845DNwLTEUVgw@alley>
 <YxYCsC6I/KcTVUVY@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxYCsC6I/KcTVUVY@chrisdown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-09-05 15:07:44, Chris Down wrote:
> Hi Petr,
> 
> Thanks a lot for getting back! :-)
> 
> Any comments not explicitly addressed are acked.
> 
> Petr Mladek writes:
> > On Wed 2022-07-20 18:48:16, Chris Down wrote:
> > > In terms of technical implementation, this patch embeds a device pointer
> > > in the console struct, and registers each console using it so we can
> > > expose attributes in sysfs.
> > > 
> > > For information on the precedence and application of the new controls,
> > > see Documentation/ABI/testing/sysfs-class-console and
> > > Documentation/admin-guide/per-console-loglevel.rst.

> > > @@ -1701,12 +1806,14 @@ int do_syslog(int type, char __user *buf, int len, int source)
> > >  		break;
> > >  	/* Disable logging to console */
> > >  	case SYSLOG_ACTION_CONSOLE_OFF:
> > > +		warn_on_local_loglevel();
> > >  		if (saved_console_loglevel == LOGLEVEL_DEFAULT)
> > >  			saved_console_loglevel = console_loglevel;
> > >  		console_loglevel = minimum_console_loglevel;
> > >  		break;
> > 
> > We actually could disable logging on all consoles by setting
> > ignore_per_console_loglevel. Something like:
> > 
> > 	case SYSLOG_ACTION_CONSOLE_OFF:
> > 		if (saved_console_loglevel == LOGLEVEL_DEFAULT) {
> > 			saved_console_loglevel = console_loglevel;
> > 			saved_ignore_per_console_loglevel = ignore_per_console_loglevel;
> > 		}
> > 		console_loglevel = minimum_console_loglevel;
> > 		ignore_per_console_loglevel = true;
> > 		break;
> 
> Oh, that's very true. Thanks!
> 
> > > +		warn_on_local_loglevel();
> > 
> > I would keep it simple:
> > 
> > 		if (!ignore_per_console_loglevel)
> > 			pr_warn_once("SYSLOG_ACTION_CONSOLE_LEVEL is ignored by consoles with explicitely set per-console loglevel, see Documentation/admin-guide/per-console-loglevel\n");
> 
> My concern with this is that this will then warn on basically any first
> syslog() use, even for people who don't care about the per-console loglevel
> semantics. They will now get the warning, since by default
> ignore_per_console_loglevel isn't true -- however no per-console loglevel is
> set either, so it's not really relevant.
> 
> That's why I implemented it as warn_on_local_loglevel() checking for
> CON_LOGLEVEL, because otherwise it seems noisy for those that are not using
> the feature.

IMHO, the question is if any commonly used tool is using syslog
SYSLOG_ACTION_CONSOLE_ON/OFF these days.

It is supported by dmesg but I am not sure if anyone is really
using it. And I am not sure if anyone uses this during boot, suspend,
or so.

I think that I really should open the discussion whether to obsolete syslog
syscall in general. I am sure that it won't me possible to remove
it anytime soon, maybe it would need to stay forever. Anyway, it has
many problems because they modify global variables. And even reading
does not work well when there are more readers.

I am going to send it. Well, I would need to some time to think
about it.

In the meantime, you could either do it the conservative way or
always show it for these operations. It would be simple to fix
when anyone complains.

> > > +static ssize_t loglevel_store(struct device *dev, struct device_attribute *attr,
> > > +			      const char *buf, size_t size)
> > > +{
> > > +	struct console *con = classdev_to_console(dev);
> > > +	ssize_t ret;
> > > +	int tmp;
> > > +
> > > +	if (!strcmp(buf, "unset") || !strcmp(buf, "unset\n")) {
> > > +		con->flags &= ~CON_LOGLEVEL;
> > > +		return size;
> > > +	}
> > > +
> > > +	ret = kstrtoint(buf, 10, &tmp);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	if (tmp < LOGLEVEL_EMERG || tmp > LOGLEVEL_DEBUG + 1)
> > > +		return -ERANGE;
> > > +
> > > +	if (tmp < minimum_console_loglevel)
> > > +		return -EINVAL;
> > 
> > This looks superfluous. Please, use minimum_console_loglevel
> > instead of LOGLEVEL_EMERG in the above range check.
> 
> That's fair. In which case we probably end up with one error for all cases:
> do you prefer we should return -EINVAL or -ERANGE?

I prefer -ERANGE.

> > > +
> > >  static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
> > >  				void *buffer, size_t *lenp, loff_t *ppos)
> > >  {
> > > @@ -76,6 +122,22 @@ static struct ctl_table printk_sysctls[] = {
> > >  		.extra1		= SYSCTL_ZERO,
> > >  		.extra2		= SYSCTL_TWO,
> > >  	},
> > > +	{
> > > +		.procname	= "console_loglevel",
> > > +		.data		= &console_loglevel,
> > > +		.maxlen		= sizeof(int),
> > > +		.mode		= 0644,
> > > +		.proc_handler	= printk_console_loglevel,
> > > +	},
> > > +	{
> > > +		.procname	= "default_message_loglevel",
> > > +		.data		= &default_message_loglevel,
> > > +		.maxlen		= sizeof(int),
> > > +		.mode		= 0644,
> > > +		.proc_handler	= proc_dointvec_minmax,
> > > +		.extra1		= &min_loglevel,
> > > +		.extra2		= &max_loglevel,
> > > +	},
> > 
> > Is there any chance to add this into /sys/class/console instead?
> > I mean:
> > 
> > 	/sys/class/console/loglevel
> > 	/sys/class/console/default_message_loglevel
> > 
> > It would be nice to have the things are on the same place.
> > Especially it would be nice to have the global loglevel there.
> 
> I think this one is a little complicated: on the one hand, yes, it does seem
> more ergonomic to keep everything together in /sys/class/console. On the
> other hand, this means that users can no longer use the sysctl
> infrastructure, which makes things more unwieldy than with kernel.printk.
> 
> Not really a problem with sysfs as much as a problem with userspace
> ergonomics: sysctls have a really easy way to set them at boot, but sysfs
> stuff, not so. You can hack it with systemd-tmpfiles, a boot unit, or
> similar, but the infrastructure is a lot less specialised and requires more
> work. I am worried that people may complain that that's unhelpful,
> especially since we're deprecating kernel.printk.

Good point. Let's keep the global values in /proc so that they might
be modified by sysctl.

Best Regards,
Petr
