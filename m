Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4D84F8997
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiDGWLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 18:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbiDGWKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 18:10:48 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE6E1F0471
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 14:58:05 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-df22f50e0cso7895142fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 14:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sm0IWfxGyffOFZXNQYRhCW6ro23Zzjc3gxx6xoqwL5g=;
        b=KOM+NcAd5BsSCaAZ6D5pFwJiJBpTlCrXUhuAOOPIO7PJEIzfDkuJ66WkmVxtsu7iNI
         PZ3Im2w96XGMSN6q2zkfrwF71iMSbfc0e1+IR9z+sWakHJY5BnMaZQtGtmAfZguJK80/
         fZh2a2uULqtocofNd18UH60VvRKFKa0PIZcMIq/eOtvcnDsK5ARDd2k+XN//RYt+XjIX
         h9nbzRlOpS9SNkOKxiOzN1AqdSZNxSzbZxPVgh9gWwNUu91lu/FxB+7mLR8JYNGumGyT
         fg2X1rVUpbAOKaqamwSk7SeW7eiVK22LuvkekziB+3tUraGw3mrern7mviMsjoy7ZJgm
         ajlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=sm0IWfxGyffOFZXNQYRhCW6ro23Zzjc3gxx6xoqwL5g=;
        b=hrLC2uT50QYwdmgbp/O4N5dM+jQhTFQbh3T7ZnQn7djLgefD/HsRk8gnkLp0cXuz0W
         dE4rqWPbbrzqwyNJ6cCzUMODwl5ofiJtIuhD03pYCUgOBl4UYCBZKeCKslTVZE0EiY05
         OwyTbNZtUD8pIudEGqUvIDEy8OSpltzlLGOcaqTmKLNbCDaVZ6gRKtl0zguwz22iznOS
         ZtLtLrEPIA3i0EGZnYkJs6m/HTV2kAjosHZZljltOBKSf14hcpxjc0e+VP6SldWkUueC
         ip9B32kms/X8JffgUx2OMGrh9P2mXzMBl3UqzumQiGh4BhMYtxP782cQi5EM7qzasY0V
         f1pw==
X-Gm-Message-State: AOAM532d4fQlbyLDvKy8rPUPDPxTzpx8qL9F3hLWv+yvcK92AjT1jes6
        f2zdy5rVbBsCtzTQMNIpIzE=
X-Google-Smtp-Source: ABdhPJyI8bownT0OvaoptfHowom/5ke88pGN98pZue24p0Z2W3SMttqo2FFfInWZTDUr8To9vEM6KA==
X-Received: by 2002:a05:6870:a928:b0:da:b3f:320a with SMTP id eq40-20020a056870a92800b000da0b3f320amr7058024oab.186.1649368683898;
        Thu, 07 Apr 2022 14:58:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id pc10-20020a0568701eca00b000e275bdfa43sm730536oab.8.2022.04.07.14.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 14:58:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 7 Apr 2022 14:58:02 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, jstultz@google.com,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [RFC][PATCH] timers: Add del_time_free() to be called before
 freeing timers
Message-ID: <20220407215802.GB186606@roeck-us.net>
References: <20220407161745.7d6754b3@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407161745.7d6754b3@gandalf.local.home>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Thu, Apr 07, 2022 at 04:17:45PM -0400, Steven Rostedt wrote:
> [
>   This is an RFC patch. As we hit a few bugs were del_timer() is called
>   instead of del_timer_sync() before the timer is freed, and there could
>   be bugs where even del_timer_sync() is used, but the timer gets rearmed,
>   I decided to introduce a "del_timer_free()" function that can be used
>   instead. This will at least educate developers on what to call before they
>   free a structure that holds a timer.
> 
>   In this RFC, I modified hci_qca.c as a use case, even though that change
>   needs some work, because the workqueue could still rearm it (I'm looking
>   to see if I can trigger the warning).
> 
>   If this approach is acceptable, then I will remove the hci_qca.c portion
>   from this patch, and create a series of patches to use the
>   del_timer_free() in all the locations in the kernel that remove the timer
>   before freeing.
> ]
> 
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> We are hitting a common bug were a timer is being triggered after it is
> freed. This causes a corruption in the timer link list and crashes the
> kernel. Unfortunately it is not easy to know what timer it was that was
> freed. Looking at the code, it appears that there are several cases that
> del_timer() is used when del_timer_sync() should have been.
> 
> Add a del_timer_free() that not only does a del_timer_sync() but will mark

This limits the use case to situations where del_timer_sync() can actually
be called. There is, however, code where this is not possible.
Specifically, it doesn't work if the code triggered with the timer uses a
lock, and del_timer() is also called under that same lock. An example for
that is the code in sound/synth/emux/emux.c. How do you suggest to handle
that situation ?

Thanks,
Guenter
