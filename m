Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FEF52F151
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 19:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352056AbiETRKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 13:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350298AbiETRKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 13:10:52 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EB714028
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 10:10:51 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id pq9-20020a17090b3d8900b001df622bf81dso8373906pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 10:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gt3+n62GG0NiMio1LppG1snx6qkVMDzzWEgSc2HDsyw=;
        b=gVI5OKLxuSVjmr7Mt3K4ab0Ce49zjKYNMJmG/5yql1CX6MLwC45ZuEG28VWXrv/Ifc
         knOwcTn2+V8pY5z+hfm/Rr988cvpL8QnGiI6RfJOLLVxKVH+XDLG4Fxf0llI8c8Wlouk
         jZhpWG/OPd5jAm2iDk+/7jOaSFkvqBY+io6iL0yAAbWLzpCJ4eeVyDDMjrFchyzd1YEu
         /+7hd8OQkviS8bOQmlogN9f7YeXPaw+I0ZteDYUFdX5R3F1/U73GE+o2Stv+ZnAgDcHI
         QKa9T6iasQgV5Q3fE1Kl5+7041vSR5sM2YuL5sj/pa1EQya8r0BWiaYmXqeXsjAosZbV
         6LrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=gt3+n62GG0NiMio1LppG1snx6qkVMDzzWEgSc2HDsyw=;
        b=2sFCViVxFqRHPp0mfDGPbGqPmOOqHWjl448qq8xNdQoMUqJX/C1W5ImQhZUg85qceL
         x6xm5zVLMMlIKgV8+OpOFE96ZU982JzQtP15C2zfZX6dDcpClI9wEt4nQQ2D7gayCrgE
         b0Xg2fl9XzMxYNND5dFMEZXNJenDHg/rOlPJ1V12pk6QtIyQCFIdyNnBQvrpP0bUvAht
         2U4tsOHobhtRDbB5gqPvcOlFEkrRNXoqWlZHc0qRr6LqAOBw3qvfmvWL3AHF5ciihtw6
         MwVt0n0vOd0LblORRlzaLMO30MF83lWiSfsTNQcxiwnd3JZL6tM9RI6J8HEswF9HOBbX
         c1dQ==
X-Gm-Message-State: AOAM531GIQ4UVNC44MaMFG9pb7/vT2Y/D8sWqAvTlEm6GzDcliP7O6LS
        buJimaUVajQ1zdDxhVBya6wBP+fpZQY=
X-Google-Smtp-Source: ABdhPJxIf1eLLsFbddI85HMJtob/7LT4HPzY0Zs5D9c3PKPkPg9DTn1pDzIVHA7Y9eLTS/IVHJhh4A==
X-Received: by 2002:a17:90a:8d82:b0:1d8:a5a9:5489 with SMTP id d2-20020a17090a8d8200b001d8a5a95489mr11976787pjo.102.1653066650501;
        Fri, 20 May 2022 10:10:50 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:1761])
        by smtp.gmail.com with ESMTPSA id a13-20020a170902b58d00b0015e8d4eb289sm5814416pls.211.2022.05.20.10.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 10:10:49 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 20 May 2022 07:10:48 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] workqueue: Wrap flush_workqueue() using a macro
Message-ID: <YofLmMTAjNVM+9nQ@slm.duckdns.org>
References: <738afe71-2983-05d5-f0fc-d94efbdf7634@I-love.SAKURA.ne.jp>
 <YnQKNea6KWFaWNis@slm.duckdns.org>
 <a0d6b5e4-b9c8-1a43-570f-4c73b0f6fc0c@I-love.SAKURA.ne.jp>
 <Yn0538VavQPv+/Ws@slm.duckdns.org>
 <7b2fecdb-59ae-2c54-5a5b-774ef7054d1b@I-love.SAKURA.ne.jp>
 <1c1b272b-239c-e1d1-84de-47d02feb911e@I-love.SAKURA.ne.jp>
 <YodK1czmhZtGmJ8E@slm.duckdns.org>
 <5f417d30-34a7-8da1-0ad5-33bd750582c7@I-love.SAKURA.ne.jp>
 <Yod3S8jmle+LYlES@slm.duckdns.org>
 <1a1634ac-db0e-a44c-b286-a3aba55ad695@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a1634ac-db0e-a44c-b286-a3aba55ad695@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, May 20, 2022 at 08:43:41PM +0900, Tetsuo Handa wrote:
> All flush_workqueue(system_*_wq) users are gone in linux-next.git, and this patch
> is for preventing new flush_workqueue(system_*_wq) users from coming in.

Are we fully sure? Also, there can be other changes in flight which aren't
covered. It's just not nice in general to intentionally trigger build
failures without an easy way to remediate it.

> Therefore, triggering a build error (by sending this patch to linux.git right
> before 5.19-rc1 in order to make sure that developers will not use
> flush_workqueue(system_*_wq) again) is what this patch is for.

What I'm trying to say is that, if we can trigger build warnings, that'd be
a better way to go about it.

> We will also remove flush_scheduled_work() after
> all flush_scheduled_work() users are gone.

Yeah, that'd be great.

> >> And use of #warning directive breaks building with -Werror option.
> > 
> > If the user wants to fail build on warnings, sure. That's different from
> > kernel failing to build in a way which may require non-trivial changes to
> > fix.
> 
> How can #warning directive be utilized inside #define or inline function, for
> we can't do like
> 
>   #define flush_workqueue(wq)						\
>   #if wq == "system_wq"                                                \
>   #warning Please avoid flushing system_wq.                            \
>   #endif                                                               \
>   __flush_workqueue(wq)
> 
> or
> 
>   static inline void flush_workqueue(struct workqueue_struct *wq)
>   {
>   #if wq == "system_wq"
>   #warning Please avoid flushing system_wq.
>   #endif
>   	__flush_workqueue(wq);
>   }
> 
> . We can use BUiLD_BUG_ON() but I don't think we can use #warning directive.

Hmm.... there's __compiletime_warning() which uses gcc's __warning__
attribute, so we can define a function which is tagged with it and call it
on constant_p match. Would that work?

> >>> Maybe rename the function to __flush_workqueue() instead of undef'ing the
> >>> macro?
> >>
> >> I prefer not adding __ prefix, for flush_workqueue() is meant as a public function.
> >> For easier life of kernel message parsers, I don't feel reason to dare to rename.
> > 
> > You mean the WARN_ON messages? Given how they never trigger, I doubt there's
> > much to break. Maybe some kprobe users? But they can survive.
> 
> WARN_ON() by passing system-wide workqueues should not happen.
> But backtrace of a warning message while inside __flush_workqueue() will be
> still possible.

I think it'd be fine to rename the function.

Thanks.

-- 
tejun
