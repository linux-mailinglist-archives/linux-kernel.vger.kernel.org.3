Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C7952F8C7
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 06:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237509AbiEUE6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 00:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiEUE6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 00:58:03 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6894A16D13D
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 21:57:55 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id w17-20020a17090a529100b001db302efed6so9327357pjh.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 21:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=THgJXLsn0Ot2fDV0cFcGYcE4RJPtFgenCQ+HURhdl4I=;
        b=FZgy8N6BAuXSCGbfu81TBLlDLTF+i6kV679S+qdqUFHkHjZlnqOlsw3F5i0pc6/QLF
         u8gLDsiw/sS7p8DxPJ2gqf5duzMa4rNUWNrHa5lQEDQmivPIAg+UgCoWvrvRYm+31H5t
         2siQRu0qw3C+np34TzZi/7IbMKidVFSi2ArnpljolplZN3rcDL3vKXmNFwMveFfJ22K+
         BkyCrDfGGQd/g7v5i94nRri/RMrbjPu3+YRC86w9zrpBq+LO0Byjz6rhDyJHzu0B1Umh
         H5kLVl1k8Ym3C+aJ9bV1zsHIM3NsjWDjO57A2c0D0hpJueAbYMhTNC5SucH5/jWQnt8Y
         Auow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=THgJXLsn0Ot2fDV0cFcGYcE4RJPtFgenCQ+HURhdl4I=;
        b=fvgzhIM8CpJ7dRNU5T/H8fVwmPfJh9G6Uf/5FZgH7n5mbIXSLMuyS2QSssHLdTaszU
         Qo4TtPT3WlkjChCt+sp2CuujZPQN3rbEeW2QT2XmoZW8DFEQeb5neB4m/QdN6W4MrDjY
         sxS6Yj3xJeop/46WzpcJgIr7nnGQvW0GgH+mxtkmeBWCJwkhfaiJbJDkiJzh6bMs6SDX
         fJmmiDOnahN2Rwwej924UahxSd9HzFp89guDJB3a4XJNw2P5E9hWmY4vKfpt1pVONzJU
         DsOusJ55rHvziHGmJbFyOK0TNgg4eEAzp4QdFWUXzgO+ogLBchEaVypCbJv2OcSzXnMW
         qRCw==
X-Gm-Message-State: AOAM532GVhtnktLVcVqtOIZ3tq2hks7BofEnEnbXR+E8h+31XHcMK55Z
        HeitYwHkf9+/xxm5HvWpn+M=
X-Google-Smtp-Source: ABdhPJxOadA772Cc5R6WFp+H45uHE9aeJ0zS9S8FF4APLyO64LwVqCzK7+SDgnOZDArp1s1uMX3f/A==
X-Received: by 2002:a17:90b:4a4d:b0:1df:53dc:c094 with SMTP id lb13-20020a17090b4a4d00b001df53dcc094mr15193310pjb.69.1653109074763;
        Fri, 20 May 2022 21:57:54 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:1761])
        by smtp.gmail.com with ESMTPSA id c2-20020a62f842000000b0051800111b2fsm2699075pfm.216.2022.05.20.21.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 21:57:54 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 20 May 2022 18:57:52 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] workqueue: Wrap flush_workqueue() using a macro
Message-ID: <YohxUC45xk523g9I@slm.duckdns.org>
References: <a0d6b5e4-b9c8-1a43-570f-4c73b0f6fc0c@I-love.SAKURA.ne.jp>
 <Yn0538VavQPv+/Ws@slm.duckdns.org>
 <7b2fecdb-59ae-2c54-5a5b-774ef7054d1b@I-love.SAKURA.ne.jp>
 <1c1b272b-239c-e1d1-84de-47d02feb911e@I-love.SAKURA.ne.jp>
 <YodK1czmhZtGmJ8E@slm.duckdns.org>
 <5f417d30-34a7-8da1-0ad5-33bd750582c7@I-love.SAKURA.ne.jp>
 <Yod3S8jmle+LYlES@slm.duckdns.org>
 <1a1634ac-db0e-a44c-b286-a3aba55ad695@I-love.SAKURA.ne.jp>
 <YofLmMTAjNVM+9nQ@slm.duckdns.org>
 <d05f4745-ba08-61eb-4780-ddfe50d0f1b9@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d05f4745-ba08-61eb-4780-ddfe50d0f1b9@I-love.SAKURA.ne.jp>
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

On Sat, May 21, 2022 at 10:14:36AM +0900, Tetsuo Handa wrote:
> On 2022/05/21 2:10, Tejun Heo wrote:
> > On Fri, May 20, 2022 at 08:43:41PM +0900, Tetsuo Handa wrote:
> >> All flush_workqueue(system_*_wq) users are gone in linux-next.git, and this patch
> >> is for preventing new flush_workqueue(system_*_wq) users from coming in.
> > 
> > Are we fully sure? Also, there can be other changes in flight which aren't
> > covered. It's just not nice in general to intentionally trigger build
> > failures without an easy way to remediate it.
> 
> Yes, we are fully sure. Subset of this patch is already in linux-next.git without problems.
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20220520&id=5015b3b61696f8f44e7113e5bc14f4a20cbf57ff
> There aren't other changes in flight which aren't covered.
> 
> I believe that it is safe to replace the commit above with this patch when Linus released
> 5.18 final (or maybe 5.18-rc8) is released next Sunday. I also believe that it is safe to
> send this patch right before Linus releases 5.19-rc1.
> 
> I guess that there are several out-of-tree kernel modules which will start
> failing with this patch. But they can use
> 
> 	#undef flush_workqueue
> 
> as a temporary workaround (if they can't remediate easily) until we add WARN_ON()
> as a run-time check. We will need to wait for several months until we can add
> WARN_ON() as a run-time check, for that happens after all flush_scheduled_work()
> users are gone.

How is that better tho? If we can just trigger build warning, that's way
better than asking people to hunt down some random define and shoot it down.
How would they do that?

> >> Therefore, triggering a build error (by sending this patch to linux.git right
> >> before 5.19-rc1 in order to make sure that developers will not use
> >> flush_workqueue(system_*_wq) again) is what this patch is for.
> > 
> > What I'm trying to say is that, if we can trigger build warnings, that'd be
> > a better way to go about it.
> 
> Some unlucky users (if any) can workaround this build failure using #undef.
> Nothing to bother with how to emit warning messages instead of error messages.

We're talking in circles. If we can trigger warning, I don't see a reason
why we'd want to trigger build failures. It's a really bad user experience
for anybody who doesn't know what is going on exactly. So, nack on the
current patch.

Thanks.

-- 
tejun
