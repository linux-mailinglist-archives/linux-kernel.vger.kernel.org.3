Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA5A5AD480
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238268AbiIEOHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 10:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237234AbiIEOHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:07:48 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE003C8D3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 07:07:47 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id se27so17327767ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 07:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=dek28SgTVnFykRuIRj3Z0tQGsFvPOGhPBXnWYp+1b7Y=;
        b=PhktUdEgftFZnR9jDISXl83K95FoEu4xD/+hR7JS8KetewhkXbThmf1VOhLt6Crc8W
         0kncmief6Lyr2JTMf/S2jK6Bx3Blu96WQ5s8N3+pJt49fRe8UeUlX/vUsOKLpypF5JT6
         3FZtEz03UJLUMSf7elBf/6jtMBvAyV6cU+14g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dek28SgTVnFykRuIRj3Z0tQGsFvPOGhPBXnWYp+1b7Y=;
        b=JZ9c/DA74INu3Z5ZKm/ANMSbnOuEus60pSBEPpTER79GtcRPRhm70w0cOL3UwHqxwu
         gHvvTV0qghi7IAnKj7bdJophxoqlcLf3mYbygCo1chUKvk36oGquV0N9g7KVvGSEqFcB
         cW3BqII1KaI/IGUVDpEozIDZUB/1eeH8Zadcn86tJAuiszYh9/HG/MhUXpXSLBp4W4rS
         ybEGEagqmUZGM+jxrVVk8A8Kymve2pFd6R9pWi7OO8EjYUws2nIRP3LpQ+JcGrJJsauB
         7MRBfo7xH1H9qpTXVNr3OOTtmu4qk9lAh1ROG23Su+6EhawgXPbTV8BSmHyJhZurpFvh
         YpDw==
X-Gm-Message-State: ACgBeo2A2DFXRowIemwWGeM5xTye7zwNwK+Y1EnRcPEbZNZ74n7Bo33n
        wrq+LoCmKBzAUpgFj3+2LWmLlA==
X-Google-Smtp-Source: AA6agR7lAFjh+T16xduRnS3DC/6vsP17Y6vxo67IAx0UezYdNvrIpe7vahJWMWctjqYSvCiRp7P4IQ==
X-Received: by 2002:a17:907:9605:b0:6f5:c66:7c13 with SMTP id gb5-20020a170907960500b006f50c667c13mr37839493ejc.66.1662386865548;
        Mon, 05 Sep 2022 07:07:45 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:902a])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906218100b0073872f367cesm5057129eju.112.2022.09.05.07.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 07:07:44 -0700 (PDT)
Date:   Mon, 5 Sep 2022 15:07:44 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: [PATCH v3 2/2] printk: console: Support console-specific
 loglevels
Message-ID: <YxYCsC6I/KcTVUVY@chrisdown.name>
References: <cover.1658339046.git.chris@chrisdown.name>
 <b9fa85cfed3a97ab4292daca51476e4e23da2f9a.1658339046.git.chris@chrisdown.name>
 <YxB845DNwLTEUVgw@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YxB845DNwLTEUVgw@alley>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

Thanks a lot for getting back! :-)

Any comments not explicitly addressed are acked.

Petr Mladek writes:
>On Wed 2022-07-20 18:48:16, Chris Down wrote:
>> In terms of technical implementation, this patch embeds a device pointer
>> in the console struct, and registers each console using it so we can
>> expose attributes in sysfs.
>>
>> For information on the precedence and application of the new controls,
>> see Documentation/ABI/testing/sysfs-class-console and
>> Documentation/admin-guide/per-console-loglevel.rst.
>
>The overall logic looks good to me. I finally have good feeling that
>the behavior is "easy" to understand.

That's great! Thank you for all your help improving it.

>> + */
>> +#define CON_LOGLEVEL	(128) /* Level set locally for this console */
>
>I would write:
>
>#define CON_LOGLEVEL	(128) /* Local (per-console) loglevel is set. */
>
>Alternatively we could avoid the flag completely. The per-console
>loglevel is set when con->level > 0. A valid value must never
>be below CONSOLE_MIN_LOGLEVEL which is 1. And it is perfectly fine
>to say that 0 or -1 is not a valid loglevel. The same effect could
>be achieved by disabling the console completely.
>
>I do not have strong opinion. The flag has obvious meaning and might
>make the code better readable. On the other hand, it adds an extra
>code and complexity.
>
>I slightly prefer to do it without the flag.
>
>Anyway, if we add the new flag, we should also show it in
>/proc/consoles, see fs/proc/consoles.c.

Hmm, it's true it can be done without the flag, I mostly preferred to do it 
this way out of a concern for code readability.

That said, with the changes suggested below to just show -1 instead of "unset", 
maybe the best solution is just to set -1.

I will think about it some more before v4 and probably just have -1 mean unset. 
Thanks!

>> +static int console_effective_loglevel(const struct console *con,
>> +				      enum loglevel_source *source)
>> +{
>> +	enum loglevel_source lsource;
>> +	int level;
>> +
>> +	if (ignore_loglevel) {
>> +		lsource = LLS_IGNORE_LOGLEVEL;
>> +		level = CONSOLE_LOGLEVEL_MOTORMOUTH;
>> +		goto out;
>> +	}
>> +
>> +	if (!ignore_per_console_loglevel &&
>> +	    (con && (con->flags & CON_LOGLEVEL))) {
>> +		lsource = LLS_LOCAL;
>> +		level = con->level;
>> +		goto out;
>> +	}
>> +
>> +	lsource = LLS_GLOBAL;
>> +	level = console_loglevel;
>> +
>> +out:
>> +	*source = lsource;
>> +	return level;
>> +}
>
>It might be a matter of taste. But I would probably do it the
>following way (note that these would not be used in
>boot_delay_msec()):
>
>static int console_effective_loglevel(const struct console *con)
>{
>	enum loglevel_source source;
>	int level;
>
>	if (WARN_ON_ONCE(!con))
>		return;
>
>	source = console_effective_loglevel_source(con);
>
>	switch (source) {
>	case LLS_IGNORE_LOGLEVEL:
>		level = CONSOLE_LOGLEVEL_MOTORMOUTH;
>		break;
>	case LSS_LOCAL:
>		level = con->level;
>		break;
>	case LSS_GLOBAL:
>		level = console_loglevel;
>		break;
>	default:
>		pr_warn("Unhandled console loglevel source: %d,	source);
>		level = default_console_loglevel;
>		break;
>	}
>
>	return level;
>}
>
>static const char *console_effective_loglevel_source_str(const struct *con)
>{
>	enum loglevel_source source;
>	const char *str;
>
>	if (WARN_ON_ONCE(!con))
>		return;
>
>	source = console_effective_loglevel_source(con);
>
>	switch (source) {
>	case LLS_IGNORE_LOGLEVEL:
>		str = "ignore_loglevel";
>		break;
>	case LSS_LOCAL:
>		str = "local"
>		break;
>	case LSS_GLOBAL:
>		str = "global";
>		break;
>	default:
>		pr_warn("Unhandled console loglevel source: %d,	source);
>		str = "unknown";
>		break;
>	}
>
>	return str;
>}
>
>static enum loglevel_source
>console_effective_loglevel_source(const struct console *con)
>{
>	if (WARN_ON_ONCE(!con))
>		return;
>
>	if (ignore_loglevel)
>		return LLS_IGNORE_LOGLEVEL;
>
>	if (con->flags & CON_LOGLEVEL && !ignore_per_console_loglevel))
>		return LLS_LOCAL;
>
>	return LLS_GLOBAL;
>}
>
>It looks like a bit cleaner and better separated (layered) logic.
>
>There is no need to define "enum loglevel_source" variable when
>the caller is interested only into the loglevel value.
>
>The advantage of console_effective_loglevel_source_str() is that it
>always returns a valid string. It prevents a potential out-of-bound
>access to loglevel_source_names[].

No strong opinions, so I'll do this for v4. Thanks!

>>
>> @@ -1701,12 +1806,14 @@ int do_syslog(int type, char __user *buf, int len, int source)
>>  		break;
>>  	/* Disable logging to console */
>>  	case SYSLOG_ACTION_CONSOLE_OFF:
>> +		warn_on_local_loglevel();
>>  		if (saved_console_loglevel == LOGLEVEL_DEFAULT)
>>  			saved_console_loglevel = console_loglevel;
>>  		console_loglevel = minimum_console_loglevel;
>>  		break;
>
>We actually could disable logging on all consoles by setting
>ignore_per_console_loglevel. Something like:
>
>	case SYSLOG_ACTION_CONSOLE_OFF:
>		if (saved_console_loglevel == LOGLEVEL_DEFAULT) {
>			saved_console_loglevel = console_loglevel;
>			saved_ignore_per_console_loglevel = ignore_per_console_loglevel;
>		}
>		console_loglevel = minimum_console_loglevel;
>		ignore_per_console_loglevel = true;
>		break;

Oh, that's very true. Thanks!

>> +		warn_on_local_loglevel();
>
>I would keep it simple:
>
>		if (!ignore_per_console_loglevel)
>			pr_warn_once("SYSLOG_ACTION_CONSOLE_LEVEL is ignored by consoles with explicitely set per-console loglevel, see Documentation/admin-guide/per-console-loglevel\n");

My concern with this is that this will then warn on basically any first 
syslog() use, even for people who don't care about the per-console loglevel 
semantics. They will now get the warning, since by default 
ignore_per_console_loglevel isn't true -- however no per-console loglevel is 
set either, so it's not really relevant.

That's why I implemented it as warn_on_local_loglevel() checking for 
CON_LOGLEVEL, because otherwise it seems noisy for those that are not using the 
feature.

Maybe you have thoughts on that? :-)

>> +static ssize_t loglevel_store(struct device *dev, struct device_attribute *attr,
>> +			      const char *buf, size_t size)
>> +{
>> +	struct console *con = classdev_to_console(dev);
>> +	ssize_t ret;
>> +	int tmp;
>> +
>> +	if (!strcmp(buf, "unset") || !strcmp(buf, "unset\n")) {
>> +		con->flags &= ~CON_LOGLEVEL;
>> +		return size;
>> +	}
>> +
>> +	ret = kstrtoint(buf, 10, &tmp);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	if (tmp < LOGLEVEL_EMERG || tmp > LOGLEVEL_DEBUG + 1)
>> +		return -ERANGE;
>> +
>> +	if (tmp < minimum_console_loglevel)
>> +		return -EINVAL;
>
>This looks superfluous. Please, use minimum_console_loglevel
>instead of LOGLEVEL_EMERG in the above range check.

That's fair. In which case we probably end up with one error for all cases: do 
you prefer we should return -EINVAL or -ERANGE?

>> +
>>  static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
>>  				void *buffer, size_t *lenp, loff_t *ppos)
>>  {
>> @@ -76,6 +122,22 @@ static struct ctl_table printk_sysctls[] = {
>>  		.extra1		= SYSCTL_ZERO,
>>  		.extra2		= SYSCTL_TWO,
>>  	},
>> +	{
>> +		.procname	= "console_loglevel",
>> +		.data		= &console_loglevel,
>> +		.maxlen		= sizeof(int),
>> +		.mode		= 0644,
>> +		.proc_handler	= printk_console_loglevel,
>> +	},
>> +	{
>> +		.procname	= "default_message_loglevel",
>> +		.data		= &default_message_loglevel,
>> +		.maxlen		= sizeof(int),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dointvec_minmax,
>> +		.extra1		= &min_loglevel,
>> +		.extra2		= &max_loglevel,
>> +	},
>
>Is there any chance to add this into /sys/class/console instead?
>I mean:
>
>	/sys/class/console/loglevel
>	/sys/class/console/default_message_loglevel
>
>It would be nice to have the things are on the same place.
>Especially it would be nice to have the global loglevel there.

I think this one is a little complicated: on the one hand, yes, it does seem 
more ergonomic to keep everything together in /sys/class/console. On the other 
hand, this means that users can no longer use the sysctl infrastructure, which 
makes things more unwieldy than with kernel.printk.

Not really a problem with sysfs as much as a problem with userspace ergonomics: 
sysctls have a really easy way to set them at boot, but sysfs stuff, not so. 
You can hack it with systemd-tmpfiles, a boot unit, or similar, but the 
infrastructure is a lot less specialised and requires more work. I am worried 
that people may complain that that's unhelpful, especially since we're 
deprecating kernel.printk.

Maybe I shouldn't worry about that so much? I'm curious to hear your further 
thoughts.

Thanks a lot for the detailed feedback!

Chris
