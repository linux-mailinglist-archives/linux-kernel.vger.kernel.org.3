Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2365A7B1C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 12:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiHaKNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 06:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiHaKNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:13:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A84B7297
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 03:13:08 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2D67C1F8B4;
        Wed, 31 Aug 2022 10:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661940787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c9pEbKJ0mKqrh+Xf6q+4xuz8+/phCp3VSN5hbx//vlo=;
        b=EL1BV27+FTgSEztd0wX7hCLCOIZwqlARRYsC4tG+FumfviYX49L5RPOE6YvnA42hlHM645
        SM660e1tvhQ1YKOJ7MD5cAPK2zo/CaoJiTN6eLc0oxuLQ4Dza8ECnSYSuEW/IwMPAD5Fjd
        YA+MkuwF7DndPqD08ASw9egFWCsvqRg=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F15352C142;
        Wed, 31 Aug 2022 10:13:06 +0000 (UTC)
Date:   Wed, 31 Aug 2022 12:13:06 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: [PATCH v3 1/2] printk: console: Create console= parser that
 supports named options
Message-ID: <Yw80MmyBl4js09If@alley>
References: <cover.1658339046.git.chris@chrisdown.name>
 <732ee897b2bd49ada3f7dee396475c5a2195071b.1658339046.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <732ee897b2bd49ada3f7dee396475c5a2195071b.1658339046.git.chris@chrisdown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-07-20 18:48:11, Chris Down wrote:
> This will be used in the next patch, and for future changes like the
> proposed sync/nothread named options. This avoids having to use sigils
> like "/" to get different semantic meaning for different parts of the
> option string, and helps to make things more human readable and
> easily extensible.
> 
> There are no functional changes for existing console= users.
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>
> ---
>  kernel/printk/printk.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index b49c6ff6dca0..6094f773ad4a 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2368,6 +2368,30 @@ static void set_user_specified(struct console_cmdline *c, bool user_specified)
>  	console_set_on_cmdline = 1;
>  }
>  
> +static void parse_console_cmdline_options(struct console_cmdline *c,
> +					  char *options)
> +{

I think that the function does not work as expected.

> +	bool seen_serial_opts = false;
> +	char *key;
> +
> +	while ((key = strsep(&options, ",")) != NULL) {
> +		char *value;

strsep() replaces ',' with '\0'.

> +
> +		value = strchr(key, ':');
> +		if (value)
> +			*(value++) = '\0';

This replaces ':' with '\0'.

> +
> +		if (!seen_serial_opts && isdigit(key[0]) && !value) {

This catches the classic options in the format "bbbbpnf".

> +			seen_serial_opts = true;
> +			c->options = key;
> +			continue;
> +		}
> +
> +		pr_err("ignoring invalid console option: '%s%s%s'\n", key,
> +		       value ? ":" : "", value ?: "");

IMHO, this would warn even about "io", "mmio", ...  that are used by:

		console=uart[8250],io,<addr>[,options]
		console=uart[8250],mmio,<addr>[,options]

Warning: I am not completely sure about this. It seems that
	 this format is handled by univ8250_console_match().

	 IMHO, the "8250" is taken as "idx" in console_setup().
	 And "idx" parameter is ignored by univ8250_console_match().
	 This probably explains why "8250" is optional in console=
	 parameter.

> +	}
> +}

Sigh, the parsing of console= parameter is really hacky. Very old code.
The name and idx is handled in console_setup(). The rest
is handled by particular drivers via "options".

This patch makes it even more tricky. It tries to handle some
*options in add_preferred_console(). But it replaces all ','
and ':' by '\0' so that drivers do not see the original *options
any longer.

I thought a lot how to do it a clean way. IMHO, it would be great to
parse everything at a single place but it might require updating
all drivers. I am not sure if it is worth it.

So, I suggest to do it another way. We could implement a generic
function to find in the new key[:value] format. It would check
if the given option (key) exists and read the optional value.

The optional value would allow to define another new options
that would not need any value, e.g. "kthread" or "atomic" that
might be used in the upcoming code that allows to offload
console handling to kthreads.

The function would look like:

/**
  * find_and_remove_console_option() - find and remove particular option from
  *	console= parameter
  *
  * @options: pointer to the buffer with original "options"
  * @key: option name to be found
  * @buf: buffer for the found value, might be NULL
  *
  * Try to find "key[:value]" in the given @options string. Copy the value
  * into the given @buf when any.
  *
  * Warning: The function is designed only to handle new generic console
  *	options. The found "key[:value]" is removed from the given
  *	@options string. The aim is to pass only the driver specific
  *	options to the legacy driver code.
  *
  *	The new options might stay when all console drivers are able
  *	to handle it.
  *
  *     The given @options buffer is modified to avoid allocations. It
  *     makes the life easier during early boot.
  */
bool find_and_remove_console_option(char *options, const char *key,
				    char *buf, int size)
{
	bool found = false, copy_failed = false. trailing_comma = false;
	char *opt, *val;

	/* Find the option: key[:value] */
	while (options && *options) {
		opt = options;

		options = strchr(options, ",");
		if (options)
			*options++ = '\0';

		val = strchr(opt, ":");
		if (val)
			*val++ = '\0';

		if (strcmp(opt, key) == 0) {
			found = true;
			break;
		}

		/* Not our key. Keep it in options. */
		if (options) {
			*(options - 1) = ',';
			trailing_comma = 1;
		}
		if (val)
			*(val - 1) = ':';
	}

	/* Copy the value if found. */
	if (found && val) {
		if (buf && size > strlen(val)) {
			strscpy(buf, val, size);
		} else {
			pr_warn("Can't copy console= option value. Ignoring %s:%s\n",
				opt, val);
			copy_failed = true;
		}
	}

	/* Remove the found option. */
	if (found) {
		if (options) {
			strcpy(opt, options);
			options = opt;
		} else if (trailing_comma) {
			/* Removing last option */
			*(opt - 1) = '\0';
		} else
			*(opt) = '\0';
		}
	}

	return found && !copy_failed;
}

then we could do something like:

void handle_per_console_loglevel_option(struct console_cmdline *c, char *options)
{
	char buf[10];
	int loglevel, ret;

	if (!find_and_remove_console_option("options, "loglevel", buf, sizeof(buf)))
		return;

	if (kstrtoint(buf, 10, &loglevel)) {
		pr_warn("Invalid console loglevel:%s\n", buf);
		return;
	}

	if (loglevel < CONSOLE_LOGLEVEL_MIN || loglevel > CONSOLE_MOTORMOUTH) {
		pr_warn("Console loglevel out of range: %d\n", loglevel);
		return;
	}

	c->loglevel = loglevel;
	c->flags |= CON_LOGLEVEL;
}

Note that the code is not even compile tested.

Any better ideas are highly appreciated.

Best Regards,
Petr
