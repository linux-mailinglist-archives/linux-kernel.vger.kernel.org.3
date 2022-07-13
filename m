Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA195738EB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbiGMOch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbiGMOce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:32:34 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC1137F8C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:32:32 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id dn9so20180353ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nQlPK35aSKZZ7lMrZGh0KdwOGWHjQLZYCKq0tBHKwGI=;
        b=EFNcHNtuMTLyt8LG/RPJK/O9Y6h8qrjM1DdlnofvRAgiESn37BiebUMSDp4ebeIbLO
         Rr//brj5bh/HJwhxyJWDdCXya7TDi+Kj+WTQ1BlIUWn53EwYkM9buJ5iAAJaJewlzjxF
         wjy8VLU7ZhVUdE6otCYaPFooYR2JOFnbB+VP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nQlPK35aSKZZ7lMrZGh0KdwOGWHjQLZYCKq0tBHKwGI=;
        b=TX0xea17G62jrqxWKSUsNj7X5iIrzU7ByD7y3k7YMe8yGLgVambSL+n05VCzzTqc+D
         ofUrWeWtPMfw3Ye03VFPkqkj8sHJgwulvKl66Y8gqc3uEH9UvqOjr8kROOKefHOgSPwV
         QyQvKWlL2H8sJNH6x5UGzcvG35hLEFW3cxyZUJYmEGPsSzj96YU7U77UXBvy8lIWrLex
         YEoJTicL/GnMxVUY4B0jwHuUdAZdFLs1WeE6UNpiDFf7JCZhtROtHUH6V2M9pm48HukD
         83GPKMsbfe3Z/LAblOjg5jckXLrvBHwGWd00WCc+pPQ2guoRMgmkoEdZOQ4bcjrbM6mU
         oXJA==
X-Gm-Message-State: AJIora86yfIFxgjatKiL9487D2IGlzFMpWnfLICeQILA1xPw1g4EEjzL
        trmyar3WtfV+NlMpk0x8Mrec5w==
X-Google-Smtp-Source: AGRyM1unfDTG8CfhpbGPjbHeOPdgvd4KMvD0kr0ZQjXUJQE84NWv9vi/CJIYEz6Lmef/eEAVRw4KFg==
X-Received: by 2002:a17:907:2c74:b0:72b:5ba7:d96f with SMTP id ib20-20020a1709072c7400b0072b5ba7d96fmr3848709ejc.33.1657722752130;
        Wed, 13 Jul 2022 07:32:32 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:b372])
        by smtp.gmail.com with ESMTPSA id 4-20020a170906308400b0072b145124f4sm5019132ejv.155.2022.07.13.07.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 07:32:29 -0700 (PDT)
Date:   Wed, 13 Jul 2022 15:32:27 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: [RFC PATCH v2] printk: console: Allow each console to have its
 own loglevel
Message-ID: <Ys7Xe8iSOYzmQeIu@chrisdown.name>
References: <YoeQLxhDeIk4VSmx@chrisdown.name>
 <7c57004c1f9a2580b34ea6708065260ec2706122.camel@surriel.com>
 <Ysbv3HUYJTzRpjeq@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Ysbv3HUYJTzRpjeq@alley>
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

Petr Mladek writes:
>The problem is clear. But the big part of the problem is that printk()
>tries to show the messages on all consoles immediately.
>
>I wonder how much the per-console loglevel would be needed
>when the console handling is offloaded to per-console kthreads, see
>https://lore.kernel.org/all/20220421212250.565456-1-john.ogness@linutronix.de/
>It causes that printk() should "never" block and each console might
>run on its own speed.
>
>It still might be useful from some reasons:
>
>    + Serial consoles might miss messages because the old messages are
>      over-written before they reach the console. It might be solved
>      by big enough buffer.
>
>    + printk() still tries to show the messages immediately in some
>      critical situations, for example, early boot, watchdog warnings,
>      suspend, reboot, OOps, panic(). The slow consoles might still
>      cause stalls and put the system into its knees.
>
>    + People might need to explicitly disable the kthreads, for
>      example, when debugging a situation when kthreads are not
>      scheduled.

Indeed. In addition to these, there are cases (like the pstore case mentioned 
by Vincent) where we want to bump the console loglevel up to the maximum for 
debugging, but it still doesn't make sense to emit it over all consoles -- 
especially netconsoles where processing capacity on the netconsole 
receiver/server is likely limited. The same is true for things like baseboard 
management controllers where they may blindly store the console output in a 
similar fashion.

The kthread offloading is definitely going to help a lot here here, but to 
capably be able to use netconsole in prod we're going to need both.

>PS: I am sorry for the late response. I am still snowed under
>many tasks. The printk kthreads are complicated and need
>a lot of attention. Plus there was a sickness, vacations,
>and other tasks.

Don't worry, I totally understand :-) I really appreciate you getting back.
