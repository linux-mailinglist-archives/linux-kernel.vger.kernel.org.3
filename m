Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC5C482EFF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 09:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbiACIZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 03:25:31 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:40855 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiACIZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 03:25:30 -0500
Received: by mail-ed1-f41.google.com with SMTP id z29so133016946edl.7;
        Mon, 03 Jan 2022 00:25:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=CBJZYM5dIvVh1LZ/08BPIecuK+5dT2rJ2KIj8gS4ELY=;
        b=wteyXYMKFAFOZg9wtdRH5KwKiC/8pral/iuWCbyRg9xoScrIyChlgeL9zu9hwflk/R
         GFqjRJPUHazIsp6/39ldPJSdsrB8qndFZ1nvn8/IKVc+G1Y3QK+MJMFp0lVEcBXRjGwt
         gh+NAFbJ2mI41ACntLyrwTzH0yC0/Or7HBcrFOHNrGB+XliI/jgLZKgrrywkO32yRJVL
         SMXFKgrsz/8On0lSzbgX7o/hkqVKWifCKa7NNBm5t78Su9JaecFn/MVD70DmybkREL6i
         uP4/YDKO6qWdPtITU3gHvh+s0lmKg32K9WIQ4xRmyzCnM5hNN1Sg/b9RQB2An8T9ma9g
         mezw==
X-Gm-Message-State: AOAM531ksZ0i2QNZX18Ypmow3e4TTa0G3z8bc+eLm2mWxhfpLZq6kIlr
        NoOPOrjiLlyEfe8IJFDGCF0=
X-Google-Smtp-Source: ABdhPJx8SD4yKYxAykbEYkU9aFOM3fHYKCVBK4UUlYflSOXrmG9OPNz2TErcT23Ext45k60kraTKWg==
X-Received: by 2002:a17:906:3456:: with SMTP id d22mr35296673ejb.655.1641198328652;
        Mon, 03 Jan 2022 00:25:28 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id dm6sm10459703ejc.89.2022.01.03.00.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 00:25:28 -0800 (PST)
Message-ID: <c19ca2a2-54c9-88b1-b705-5a2cd4dd9580@kernel.org>
Date:   Mon, 3 Jan 2022 09:25:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: [was: libtraceevent: Increase libtraceevent logging when verbose]
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
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
        Steven Rostedt <rostedt@goodmis.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Cc:     eranian@google.com
References: <20210923001024.550263-1-irogers@google.com>
 <20210923001024.550263-4-irogers@google.com>
 <bc2b0786-8965-1bcd-2316-9d9bb37b9c31@kernel.org>
In-Reply-To: <bc2b0786-8965-1bcd-2316-9d9bb37b9c31@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping -- perf build is still broken in 5.16-rc8 due to this.

On 16. 12. 21, 9:07, Jiri Slaby wrote:
> Hi,
> 
> On 23. 09. 21, 2:10, Ian Rogers wrote:
>> libtraceevent has added more levels of debug printout and with changes
>> like:
>> https://lore.kernel.org/linux-trace-devel/20210507095022.1079364-3-tz.stoyanov@gmail.com 
>>
>> previously generated output like "registering plugin" is no longer
>> displayed. This change makes it so that if perf's verbose debug output
>> is enabled then the debug and info libtraceevent messages can be
>> displayed.
>> The code is conditionally enabled based on the libtraceevent version as
>> discussed in the RFC:
>> https://lore.kernel.org/lkml/20210610060643.595673-1-irogers@google.com/
>>
>> v2. Is a rebase and handles the case of building without
>>      LIBTRACEEVENT_DYNAMIC.
> 
> It breaks build with LIBTRACEEVENT_DYNAMIC and version 1.3.0:
>  > util/debug.c: In function ‘perf_debug_option’:
>  > util/debug.c:243:17: error: implicit declaration of function 
> ‘tep_set_loglevel’ [-Werror=implicit-function-declaration]
>  >   243 |                 tep_set_loglevel(TEP_LOG_INFO);
>  >       |                 ^~~~~~~~~~~~~~~~
>  > util/debug.c:243:34: error: ‘TEP_LOG_INFO’ undeclared (first use in 
> this function); did you mean ‘TEP_PRINT_INFO’?
>  >   243 |                 tep_set_loglevel(TEP_LOG_INFO);
>  >       |                                  ^~~~~~~~~~~~
>  >       |                                  TEP_PRINT_INFO
>  > util/debug.c:243:34: note: each undeclared identifier is reported 
> only once for each function it appears in
>  > util/debug.c:245:34: error: ‘TEP_LOG_DEBUG’ undeclared (first use in 
> this function)
>  >   245 |                 tep_set_loglevel(TEP_LOG_DEBUG);
>  >       |                                  ^~~~~~~~~~~~~
>  > util/debug.c:247:34: error: ‘TEP_LOG_ALL’ undeclared (first use in 
> this function)
>  >   247 |                 tep_set_loglevel(TEP_LOG_ALL);
>  >       |                                  ^~~~~~~~~~~
> 
> It is because the gcc's command line looks like:
> gcc
> ...
> -I/home/abuild/rpmbuild/BUILD/tools/lib/
> ...
> -DLIBTRACEEVENT_VERSION=65790
> ...
> 
> So:
> 
> 
>> --- a/tools/perf/util/debug.c
>> +++ b/tools/perf/util/debug.c
>> @@ -24,6 +24,16 @@
>>   #include "util/parse-sublevel-options.h"
>>   #include <linux/ctype.h>
>> +#include <traceevent/event-parse.h>
> 
> /home/abuild/rpmbuild/BUILD/tools/lib/traceevent/event-parse.h is taken 
> here.
> 
>> @@ -228,6 +238,15 @@ int perf_debug_option(const char *str)
>>       /* Allow only verbose value in range (0, 10), otherwise set 0. */
>>       verbose = (verbose < 0) || (verbose > 10) ? 0 : verbose;
>> +#if MAKE_LIBTRACEEVENT_VERSION(1, 3, 0) <= LIBTRACEEVENT_VERSION
> 
> But
> -DLIBTRACEEVENT_VERSION=65790
> is taken here (which is 1.3.0).
> 
>> +    if (verbose == 1)
>> +        tep_set_loglevel(TEP_LOG_INFO);
>> +    else if (verbose == 2)
>> +        tep_set_loglevel(TEP_LOG_DEBUG);
>> +    else if (verbose >= 3)
>> +        tep_set_loglevel(TEP_LOG_ALL);
>> +#endif
>> +
>>       return 0;
>>   }
> 
> regards,


-- 
js
suse labs
