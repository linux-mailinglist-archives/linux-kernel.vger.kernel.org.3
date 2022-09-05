Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F785AD55C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238730AbiIEOpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 10:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238615AbiIEOoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:44:14 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE694DF48
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 07:43:55 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id lx1so17499730ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 07:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=/K//7CyyIk6mTUm6I5PG1r35sm06kAazu5QFLJvFTiw=;
        b=mrX+nhJpmARTFimfcBwelfCUZnkHIZnphKWk7QT8Y16GEtZbQQ6kqdFfLWlYpRljAF
         vKyGUwYK3ZpJRQHB6awUpaebXHBi4+2Zvw0tCTM64sq58Nlpaef6vyj0DDHH7oSDMBZI
         LRgi6YLupayfGBPdtn1p0BrVjnwUiBDpmb0Ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/K//7CyyIk6mTUm6I5PG1r35sm06kAazu5QFLJvFTiw=;
        b=oLV9buF7NrwWy0j6mk7HJQZnKM2+6XpNtWkgJ1mnfXddADP7aMb+V/yxrV0Fih0Qk2
         aFj6OViWuMZWJJLSbpuGEshQVudmOR9M8veweo9jfMI2EdSx9MXx1iHNUKfZHYItJCUU
         6ycnH8+ZWyKlYhuRuqzJ9uTlZnIt0OulFJPAAlokHZO/V5oG6FYemzibZJ3XOCbTKxD6
         jiEaOL24YvHByHtHwYMuo7zZOuCqdxaxfVdpTcN6rBW2S29dabhWmuoVAsx6fIUz3Lv0
         QK6AwvGm+wn3EFsNyVoJJ7CJHK/KaHdnQ2f709Tlpb3egHUt7u6dux30/v0hazqQUQpE
         JcCQ==
X-Gm-Message-State: ACgBeo1I217FuEpVHzHRKiPHwiylESjbeoBgLDBv9IyIglwDuCs7GqJ0
        eSA14puiSorR+gBL7ihLP/SypTkMIkgXbA==
X-Google-Smtp-Source: AA6agR4vC0ENwqITqmAsOVlAKPL/vhKWMxI8wzd+jL+RRlSXAuhqNcWfNMrviUChCcSXuWt3rfFTjg==
X-Received: by 2002:a17:907:75c6:b0:741:75a0:b82b with SMTP id jl6-20020a17090775c600b0074175a0b82bmr11207385ejc.465.1662389034165;
        Mon, 05 Sep 2022 07:43:54 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:902a])
        by smtp.gmail.com with ESMTPSA id dv25-20020a170906b81900b0074a8293424esm5170931ejb.53.2022.09.05.07.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 07:43:53 -0700 (PDT)
Date:   Mon, 5 Sep 2022 15:43:53 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: [PATCH v3 1/2] printk: console: Create console= parser that
 supports named options
Message-ID: <YxYLKU8TWZ4T5ONF@chrisdown.name>
References: <cover.1658339046.git.chris@chrisdown.name>
 <732ee897b2bd49ada3f7dee396475c5a2195071b.1658339046.git.chris@chrisdown.name>
 <Yw80MmyBl4js09If@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Yw80MmyBl4js09If@alley>
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

Thanks a lot for looking this over!

Petr Mladek writes:
>I think that the function does not work as expected.
>
>> +	bool seen_serial_opts = false;
>> +	char *key;
>> +
>> +	while ((key = strsep(&options, ",")) != NULL) {
>> +		char *value;
>
>strsep() replaces ',' with '\0'.
>
>> +
>> +		value = strchr(key, ':');
>> +		if (value)
>> +			*(value++) = '\0';
>
>This replaces ':' with '\0'.
>
>> +
>> +		if (!seen_serial_opts && isdigit(key[0]) && !value) {
>
>This catches the classic options in the format "bbbbpnf".
>
>> +			seen_serial_opts = true;
>> +			c->options = key;
>> +			continue;
>> +		}
>> +
>> +		pr_err("ignoring invalid console option: '%s%s%s'\n", key,
>> +		       value ? ":" : "", value ?: "");
>
>IMHO, this would warn even about "io", "mmio", ...  that are used by:

Oh dear, I should have known it won't be that simple :-D

>
>		console=uart[8250],io,<addr>[,options]
>		console=uart[8250],mmio,<addr>[,options]
>
>Warning: I am not completely sure about this. It seems that
>	 this format is handled by univ8250_console_match().
>
>	 IMHO, the "8250" is taken as "idx" in console_setup().
>	 And "idx" parameter is ignored by univ8250_console_match().
>	 This probably explains why "8250" is optional in console=
>	 parameter.
>
>> +	}
>> +}
>
>Sigh, the parsing of console= parameter is really hacky. Very old code.
>The name and idx is handled in console_setup(). The rest
>is handled by particular drivers via "options".
>
>This patch makes it even more tricky. It tries to handle some
>*options in add_preferred_console(). But it replaces all ','
>and ':' by '\0' so that drivers do not see the original *options
>any longer.

Other than the mmio/io stuff, I think it works properly, right? Maybe I'm 
missing something? :-)

Here's a userspace test for the parser that seems to work.  
parse_console_cmdline_options() should also ignore empty options instead of 
warning, but it still functions correctly in that case, it's just noisy right 
now.

---

/* Only change is pr_err to fprintf */

#define _DEFAULT_SOURCE

#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <ctype.h>
#include <stdlib.h>

#define clamp(a, b, c) (a)
#define CON_LOGLEVEL 128

struct console_cmdline {
	char *options;
	int level;
	short flags;
};

static void parse_console_cmdline_options(struct console_cmdline *c,
					  char *options)
{
	bool seen_serial_opts = false;
	char *key;

	while ((key = strsep(&options, ",")) != NULL) {
		char *value;

		value = strchr(key, ':');
		if (value)
			*(value++) = '\0';

		if (strcmp(key, "loglevel") == 0 && value &&
		    isdigit(value[0]) && strlen(value) == 1) {
			c->level = clamp(value[0] - '0', LOGLEVEL_EMERG,
					 LOGLEVEL_DEBUG + 1);
			c->flags |= CON_LOGLEVEL;
			continue;
		}

		if (!seen_serial_opts && isdigit(key[0]) && !value) {
			seen_serial_opts = true;
			c->options = key;
			continue;
		}

		fprintf(stderr,
			"ignoring invalid console option: '%s%s%s'\n", key,
			value ? ":" : "", value ?: "");
	}
}

int main(int argc, char *argv[])
{
	struct console_cmdline con = { 0 };

	if (argc != 2)
		return EXIT_FAILURE;

	parse_console_cmdline_options(&con, argv[1]);
	printf("options: %s\n", con.options);
	printf("level: %d\n", con.level);
}

---

% make CFLAGS='-Wall -Wextra -Werror' loglevel
cc -Wall -Wextra -Werror    loglevel.c   -o loglevel
% ./loglevel 9600n8
options: 9600n8
level: 0
level set: 0
% ./loglevel 9600n8,loglevel:3
options: 9600n8
level: 3
level set: 1
% ./loglevel 9600n8,loglevel:123
ignoring invalid console option: 'loglevel:123'
options: 9600n8
level: 0
level set: 0
% ./loglevel 9600n8,loglevel:3,foo:bar
ignoring invalid console option: 'foo:bar'
options: 9600n8
level: 3
level set: 1
% ./loglevel 9600n8,loglevel
ignoring invalid console option: 'loglevel'
options: 9600n8
level: 0
level set: 0
% ./loglevel loglevel
ignoring invalid console option: 'loglevel'
options: (null)
level: 0
level set: 0
% ./loglevel loglevel:7
options: (null)
level: 7
level set: 1

---

Seems to work ok as far as I can tell, maybe I've misunderstood your concern?  
Or maybe your concern is just about the mmio/io case where the driver wants 
that as part of the options?

>I thought a lot how to do it a clean way. IMHO, it would be great to
>parse everything at a single place but it might require updating
>all drivers. I am not sure if it is worth it.
>
>So, I suggest to do it another way. We could implement a generic
>function to find in the new key[:value] format. It would check
>if the given option (key) exists and read the optional value.
>
>The optional value would allow to define another new options
>that would not need any value, e.g. "kthread" or "atomic" that
>might be used in the upcoming code that allows to offload
>console handling to kthreads.

This could also work, and avoids the current null pointer shoving. It also can 
make the ordering less strict, which seems like a good thing.

I will think about it some more. I'm curious about your comments on the above 
test still though.

Thanks a lot for the detailed review and ideas!

Chris
