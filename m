Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984A757392B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbiGMOt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiGMOtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:49:23 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F98BE004
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:49:22 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id y4so14411065edc.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CPQXf2/FNIrbUvBOltPuXarESOTLgxR0JVpEyzg9cas=;
        b=wyIpHd17GJflWwiIMfPxZGr5lwnhC/plOqcwzcTXCREM8sbtBngr7EwYKqNXsr9r9Q
         aDhOp92BMEFHSNkyvHPZQbTsrvpZNCou2kY5hcvv2gBRNy+CVWBumpFCmcbxUd4mIKVp
         NvpkLbAlMLNSpQEAPk+yPzW6s1jBX6IgsmcFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CPQXf2/FNIrbUvBOltPuXarESOTLgxR0JVpEyzg9cas=;
        b=mhteDyX2qsU3Zau7LtRY87OC1+LjK+1g7eppgHmAou8YGkkAGFdQiDEkYfwV5KI4Ot
         MlGSjSpZ6zLJP+DJjGHfQEm12kJz3bfCm96KPELK+8D7dBy9oP+FtrpHvX30VFiu+zK9
         y2Gd1qqjGqdbbk03JyR4ZQYftrUi2eZG4mRTJ2BqMx86QaheC+Mz2QhuLbNWzgKJE4E5
         AMBW9p45khTPSnkhBwOEvugbNKvklyVAqMQPcIG00WvvXPa3XzEqdtPR6aMeJu0OFG1l
         DT/b/ZVCjOkyEJ/cKn0g2LjUdJfybzw6lYWfwiQ97qXbcDn4fS3uX1Dh0Vv5AvV/P15M
         rnQA==
X-Gm-Message-State: AJIora/fMZ8iAxD4HtNvmepHcjqzLYgHnOE0KGZcD3TBRsjoVl0Jkdk/
        /U/g2X+GREczSENNfPADIlI+Uw==
X-Google-Smtp-Source: AGRyM1t0Pz0r+/Lv3hba7PeWubsYUz/V8mHaqISf3fVKh6APltm4jBzFAorSYePxuMSyC6N2mAJJiA==
X-Received: by 2002:a05:6402:355:b0:43a:4f13:56d2 with SMTP id r21-20020a056402035500b0043a4f1356d2mr5500205edw.312.1657723760877;
        Wed, 13 Jul 2022 07:49:20 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:b372])
        by smtp.gmail.com with ESMTPSA id c10-20020a17090618aa00b006fe9209a9edsm4538162ejf.128.2022.07.13.07.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 07:49:20 -0700 (PDT)
Date:   Wed, 13 Jul 2022 15:49:19 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: design: was: Re: [RFC PATCH v2] printk: console: Allow each
 console to have its own loglevel
Message-ID: <Ys7bb8+/G0iMWfzb@chrisdown.name>
References: <YoeQLxhDeIk4VSmx@chrisdown.name>
 <YshL2M8VdIEONDdc@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YshL2M8VdIEONDdc@alley>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the detailed feedback! Anything not explicitly discussed is acked 
for v3. :-)

Petr Mladek writes:
>> +    * ``minimum``: The global minimum loglevel
>> +      (``kernel.minimum_console_loglevel``) is in effect. Set a higher
>> +      console-specific loglevel to override it.
>
>This is confusing. It might be because I am not a native speaker. It
>sounds like a higher console-specific loglevel might update (override)
>the minimum value.

Ah, yes. I think this higher/lower confusion also has something to do with the 
historic artefacts of using lower-numbered integers to represent 
higher-priority messages.
>
>A better explanation is that it is a limit. Neither the global nor the per-console
>loglevel could be set below this value.

Yes, that sounds better. :-)

>> +    * ``forced_minimum``: The global minimum loglevel
>> +      (``kernel.minimum_console_loglevel``) is in effect. Even if the local
>> +      console-specific loglevel is higher, it is in effect because the global
>> +      forced loglevel (``kernel.force_console_loglevel``) is present, but is
>> +      below ``kernel.minimum_console_loglevel``. Write "unset" to
>> +      ``kernel.force_console_loglevel`` to disable the forcing, and make sure
>> +      ``kernel.minimum_console_loglevel`` is below the local console loglevel
>> +      if you want the per-console loglevel to take effect.
>> +      console-specific loglevel to override it.
>
>IMHO, this makes things too complicated. A better solution is to do
>not allow to set any log level below this limit in the first place.

Hmm, how should we then handle the case that you have set the per-console 
loglevel to 3 and minimum_console_loglevel later gets changed to 5?

We had this problem when designing cgroup v2 as well, for example in cases 
where a child requests a higher memory protection than can be afforded by the 
parent, or where a child sets a higher memory limit than a parent specifies. We 
went back and forth and eventually settled on allowing these, because the 
alternatives seemed difficult to reason about or unnecessarily inflexible.

 From the per-console loglevel side, one option is to return ERANGE or EINVAL on 
values we know won't be honoured when setting the per-console loglevel. The 
problem with that is that it doesn't allow to specify a "desired" limit in case 
the external factors (in this case, the minimum loglevel) change. This is even 
more difficult to reason about in our case because the minimum loglevel may be 
changed dynamically outside of user control.

Another is to disallow setting the minimum loglevel without first resetting 
consoles which are above the value that is desired to be set, but this seems 
really cumbersome, and again it doesn't account for cases like panic() and 
elsewhere where we blindly change it anyway.

Maybe you have another idea about how it should work in the case that the 
minimum loglevel would take precedence over an existing loglevel?

>> +    * ``ignore_loglevel``: ``ignore_loglevel`` was specified on the kernel
>> +      command line. Restart without it to use other controls.
>> +
>> +* ``enabled`` (r): Whether the console is enabled.
>> +* ``loglevel`` (rw): The local loglevel for this console. This will be in
>> +  effect if no other global control overrides it. Look at
>> +  ``effective_loglevel`` and ``effective_loglevel_source`` to verify that.
>>
>> +Deprecated
>> +~~~~~~~~~~
>> +
>> +* ``syslog(SYSLOG_ACTION_CONSOLE_*)``: This sets
>
>Why does it use "_*"? It looks like the entire syslog interface is
>obsolete. But this patch affects only three actions: ON, OFF, LEVEL.

Not totally sure I know what you mean -- SYSLOG_ACTION_CONSOLE_* limits it to 
those, no?

     % git grep -ho 'SYSLOG_ACTION_CONSOLE_[A-Z0-9]\+' | sort -u
     SYSLOG_ACTION_CONSOLE_LEVEL
     SYSLOG_ACTION_CONSOLE_OFF
     SYSLOG_ACTION_CONSOLE_ON

>> +  ``kernel.force_console_loglevel``. It is unaware of per-console loglevel
>> +  semantics and is not recommended. A warning will be emitted if it is used
>> +  while local loglevels are in effect.
>
>Do we really want to obsolete it? It might be enough to say
>that it works as force_console_loglevel.

That's also fine -- my only concern with syslog() is that it's not very 
explicit about what will happen to consoles with a per-console loglevel set.

That said, once this is merged I suppose we can make it more clear in 
downstream consumers like `dmesg -n`, so not a big issue either way. :-)

>I have one idea. A big difference might be replacing
>"force_console_loglevel" value with "ignore_per_console_loglevel" parameter.
>
>[...]
>
>The main logic difference is that we do not have 4 loglevel values
>(global,per-console,minimum,forced) and complicated rules which one
>will be used in the end.
>
>Instead we have only two values: global, and optional
>console-specific. 2nd one is used when and only when defined.
>Plus one or both might ignored when the "ignore*" parameter is used.
>
>Everything else are ways how to set the values at build/boot/run time.
>
>How does it sounds, please?

This sounds pretty good! It had bothered me that we have these two 
default/forced options, and I think this does make things simpler.

Thanks for your detailed feedback! I will incorporate it into v3.
