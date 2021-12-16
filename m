Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3F3476B6F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 09:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbhLPIH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 03:07:57 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:39471 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbhLPIHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 03:07:53 -0500
Received: by mail-ed1-f44.google.com with SMTP id b7so24572337edd.6;
        Thu, 16 Dec 2021 00:07:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=B1dCGNE6Asc15QtzoN3T9KZucJE0Zy9VdUaTThMxTwM=;
        b=o/+RL0EYFzBxC+Yth/B/bKRLABwixamMp99z/+Imjvcj3Bqom9f9BqdwD2IF/amNs4
         28n/g8PM5ikKnNeBxvlrQAtncCyiaGfWy/YRshbRiuuggVzJEKihEAejLwCE6laxaFNy
         LjJ1D5L94+ZShWR7T66+z79K5AdEmnPxRer8jLyi4qhELwZ3ZOBQhzeeBjxob1r3uD1A
         ZSULTnp0dMm4cXTrzDel8GjI+NMnAU6clrrElp5MRlJx4HajjTzKe+LK8Cx06Jm0738A
         623C9oVcOAsT98X1mk9Yl5LgfABDOVmGz2ufOmJQFMuy7IEwBIjETzFpe2qoLheEVTe1
         Ln3g==
X-Gm-Message-State: AOAM531sTM8bKlZFFkwwaJqRyPwt2VlByD2sHoyabrbsnmAQqJGYuI2t
        KDlyQqY4YbQ4XqoxV1vFGqw=
X-Google-Smtp-Source: ABdhPJwDtn7isN+9tUuLN7MDegOWlqxV9xYLaCuE2KjMB7ND875Fz3Tzav+ULBI4zNECCjyxko0cwQ==
X-Received: by 2002:a17:906:b003:: with SMTP id v3mr14837935ejy.770.1639642071889;
        Thu, 16 Dec 2021 00:07:51 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id p7sm2020784edu.84.2021.12.16.00.07.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 00:07:51 -0800 (PST)
Message-ID: <bc2b0786-8965-1bcd-2316-9d9bb37b9c31@kernel.org>
Date:   Thu, 16 Dec 2021 09:07:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 4/4] libtraceevent: Increase libtraceevent logging when
 verbose
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     eranian@google.com
References: <20210923001024.550263-1-irogers@google.com>
 <20210923001024.550263-4-irogers@google.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20210923001024.550263-4-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23. 09. 21, 2:10, Ian Rogers wrote:
> libtraceevent has added more levels of debug printout and with changes
> like:
> https://lore.kernel.org/linux-trace-devel/20210507095022.1079364-3-tz.stoyanov@gmail.com
> previously generated output like "registering plugin" is no longer
> displayed. This change makes it so that if perf's verbose debug output
> is enabled then the debug and info libtraceevent messages can be
> displayed.
> The code is conditionally enabled based on the libtraceevent version as
> discussed in the RFC:
> https://lore.kernel.org/lkml/20210610060643.595673-1-irogers@google.com/
> 
> v2. Is a rebase and handles the case of building without
>      LIBTRACEEVENT_DYNAMIC.

It breaks build with LIBTRACEEVENT_DYNAMIC and version 1.3.0:
 > util/debug.c: In function ‘perf_debug_option’:
 > util/debug.c:243:17: error: implicit declaration of function 
‘tep_set_loglevel’ [-Werror=implicit-function-declaration]
 >   243 |                 tep_set_loglevel(TEP_LOG_INFO);
 >       |                 ^~~~~~~~~~~~~~~~
 > util/debug.c:243:34: error: ‘TEP_LOG_INFO’ undeclared (first use in 
this function); did you mean ‘TEP_PRINT_INFO’?
 >   243 |                 tep_set_loglevel(TEP_LOG_INFO);
 >       |                                  ^~~~~~~~~~~~
 >       |                                  TEP_PRINT_INFO
 > util/debug.c:243:34: note: each undeclared identifier is reported 
only once for each function it appears in
 > util/debug.c:245:34: error: ‘TEP_LOG_DEBUG’ undeclared (first use in 
this function)
 >   245 |                 tep_set_loglevel(TEP_LOG_DEBUG);
 >       |                                  ^~~~~~~~~~~~~
 > util/debug.c:247:34: error: ‘TEP_LOG_ALL’ undeclared (first use in 
this function)
 >   247 |                 tep_set_loglevel(TEP_LOG_ALL);
 >       |                                  ^~~~~~~~~~~

It is because the gcc's command line looks like:
gcc
...
-I/home/abuild/rpmbuild/BUILD/tools/lib/
...
-DLIBTRACEEVENT_VERSION=65790
...

So:


> --- a/tools/perf/util/debug.c
> +++ b/tools/perf/util/debug.c
> @@ -24,6 +24,16 @@
>   #include "util/parse-sublevel-options.h"
>   
>   #include <linux/ctype.h>
> +#include <traceevent/event-parse.h>

/home/abuild/rpmbuild/BUILD/tools/lib/traceevent/event-parse.h is taken 
here.

> @@ -228,6 +238,15 @@ int perf_debug_option(const char *str)
>   	/* Allow only verbose value in range (0, 10), otherwise set 0. */
>   	verbose = (verbose < 0) || (verbose > 10) ? 0 : verbose;
>   
> +#if MAKE_LIBTRACEEVENT_VERSION(1, 3, 0) <= LIBTRACEEVENT_VERSION

But
-DLIBTRACEEVENT_VERSION=65790
is taken here (which is 1.3.0).

> +	if (verbose == 1)
> +		tep_set_loglevel(TEP_LOG_INFO);
> +	else if (verbose == 2)
> +		tep_set_loglevel(TEP_LOG_DEBUG);
> +	else if (verbose >= 3)
> +		tep_set_loglevel(TEP_LOG_ALL);
> +#endif
> +
>   	return 0;
>   }
>   

regards,
-- 
js
suse labs
