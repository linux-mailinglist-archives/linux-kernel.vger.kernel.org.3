Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8149A5AD56A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbiIEOqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 10:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238667AbiIEOqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:46:14 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3807E4E631
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 07:45:42 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id og21so17590054ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 07:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=XGIcRg1B/WMKCTWfzRQTvjcLlVMIJq95zVingDihcFo=;
        b=OjSvsVdgrO63woLrFTGzt0xUu1dybi43zDxZa0LWbEGaIEgm5iMJbwavnULkhf37Aq
         glMuadg5pOnt7QDUNPmZSkzv0MPUCwwm0/14f16UdOO7W/BgeNGMnqoHBQAxlRd6oEHL
         4veB3CqQVXm1873EtPnO9Fj0MWbz1VN5kzS8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XGIcRg1B/WMKCTWfzRQTvjcLlVMIJq95zVingDihcFo=;
        b=HGKpfBmvMn6pM95FOaPPKJexxdhJ/7BmqaW+JHDAbkyqf/ycDqLDyzQ2qNHFNyyeDU
         Z/wQeuqZYmFtJrTHhMLlKLXvI0lLfD8v0mcZbZFg3rcvbM/7HABoVNJxarT2row03u59
         piiwiufmeXrZYYYF/jmHD1vZVJsiqHyUGguW0nwq9pSlBj7UA4E1R7NdoDgCnCuNqZsc
         YuFEa9bSR8dvlvNd8d0rv3NchL/JHPSYqSaKvOd0ufsqujKDB8JqetQRLyoR50wFapCf
         8TPiL17ivcd4wFCSs58IdeH2U4RpVg1FO+yiDJfezDDXdEoZaCDquMqV0y8vvwe7lwPB
         sPmA==
X-Gm-Message-State: ACgBeo20INHIGBBaRZ+3kf/L/39AjNi8/h9qIP1goi4IFoJPsYK1yKWJ
        5WaXGQRzqrMTXVUcs4cY5tCNR+lXtv/uRA==
X-Google-Smtp-Source: AA6agR4RIT9i6lnMkqGTFD/WQ32Ck+Pryym7KvN4t8yazQsznkmopyj3DjAPxR19t18x4acfk8hs2w==
X-Received: by 2002:a17:907:20d1:b0:731:5169:106b with SMTP id qq17-20020a17090720d100b007315169106bmr37257765ejb.667.1662389141393;
        Mon, 05 Sep 2022 07:45:41 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:902a])
        by smtp.gmail.com with ESMTPSA id j2-20020a17090623e200b0073d638a7a89sm5206224ejg.99.2022.09.05.07.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 07:45:40 -0700 (PDT)
Date:   Mon, 5 Sep 2022 15:45:40 +0100
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
Message-ID: <YxYLlHYyttowJLSy@chrisdown.name>
References: <cover.1658339046.git.chris@chrisdown.name>
 <732ee897b2bd49ada3f7dee396475c5a2195071b.1658339046.git.chris@chrisdown.name>
 <Yw80MmyBl4js09If@alley>
 <YxYLKU8TWZ4T5ONF@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YxYLKU8TWZ4T5ONF@chrisdown.name>
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

Chris Down writes:
>[code]

Er, forgot to update that for the one used in the test:

---

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
	printf("level set: %d\n", !!(con.flags & CON_LOGLEVEL));
}
