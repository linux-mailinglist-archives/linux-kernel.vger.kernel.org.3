Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D95F54045F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 19:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345432AbiFGRIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 13:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237340AbiFGRIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 13:08:47 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595175A086
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:08:46 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q140so1382224pgq.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 10:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gj4nNQAESP5jflqurRD9VKGtQTZmCuItcAgDDc3/EP4=;
        b=VYwP9VNwE6R1T0NhlSkX0nAVef8l+qQgnXhfjYJ4L2IvV9TzQb4EosNHbjdNFF5WWK
         u7hddhZJX6di6aNLxhWTTmz9LK+kcr/U5w0YWmbSu3uptMWh57gPnBIaBkf2Bt3JXMVp
         FPXHEqlhuDQ1qh5UFKpugBGyAyi0l6TUB2vBW/QyPVF97k6v4c2ua4E0eh2ZYm8Uyas3
         FZDXl4UxY18YBgmvUTQMJgkd+26j+QrYgXxCilvPS+YLqVuL43nPVHSLWvJam9Q0sHCP
         sl5MAEx/yHbA7xAmHMs71NOYGYKOhN+wKHfapkODDJ8tRn0eU5OvwkVEN4TF22tPTD8I
         uv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Gj4nNQAESP5jflqurRD9VKGtQTZmCuItcAgDDc3/EP4=;
        b=4SsG65k/pQ2a8CzzXWEHW819+8zJjTlNrq0FDxpUk6h9aAgZah0ZpqLkrEMvcuLjRI
         cNabPgfklXisPVOSoKJI3AIJiUZCJHImPEcEOsQTP8+SIvNavtrsMSU4eaiue8HX1EeG
         a2mdbw3RhusfGUPRlYxdUYX4l/UAb+Fa8VQOWDva6ibZvj0OmgfS6fRTtIKBJaUKl1/P
         c0MnPjICIyO1rPJIBHd+KGe3meg+KZbZCz1mME/vwOi1lsFtuMkU4AdLEAw2AMQ/hL8S
         /LUGZz30d4Q3j1uaOr5VNzZ1SYeWvd9x6aTFDfbHfpxLxBYB4iSdAm57JWYKYF2xMcpa
         c/Lg==
X-Gm-Message-State: AOAM532zpjBbnj/RZo8nmVZDbe4Ev6X6wkTJTOnOmos6DinF4LRW921Y
        fUJ+3krF+b8qpHzkXW+TufvnoYXwnSY=
X-Google-Smtp-Source: ABdhPJzT80uFXzM351e5ip7Ri7nKrY0DNtEhGpO2KgP4KTgo2GWVDfRpShu695EU5F0scbftzYjDuA==
X-Received: by 2002:a05:6a00:2999:b0:51b:e3c8:9e30 with SMTP id cj25-20020a056a00299900b0051be3c89e30mr22769172pfb.41.1654621725450;
        Tue, 07 Jun 2022 10:08:45 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:fa4d])
        by smtp.gmail.com with ESMTPSA id z8-20020a17090a1fc800b001e0c5da6a51sm12148384pjz.50.2022.06.07.10.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 10:08:43 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 7 Jun 2022 07:08:42 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] workqueue: Wrap flush_workqueue() using a macro
Message-ID: <Yp+GGhQ8ZpbPgeQQ@slm.duckdns.org>
References: <f8c281cd-6ce7-818d-8c43-6024a7b3b481@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8c281cd-6ce7-818d-8c43-6024a7b3b481@I-love.SAKURA.ne.jp>
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

On Wed, Jun 01, 2022 at 04:32:47PM +0900, Tetsuo Handa wrote:
> Since flush operation synchronously waits for completion, flushing
> system-wide WQs (e.g. system_wq) might introduce possibility of deadlock
> due to unexpected locking dependency. Tejun Heo commented at [1] that it
> makes no sense at all to call flush_workqueue() on the shared WQs as the
> caller has no idea what it's gonna end up waiting for.
> 
> Although there is flush_scheduled_work() which flushes system_wq WQ with
> "Think twice before calling this function! It's very easy to get into
> trouble if you don't take great care." warning message, syzbot found a
> circular locking dependency caused by flushing system_wq WQ [2].
> 
> Therefore, let's change the direction to that developers had better use
> their local WQs if flush_scheduled_work()/flush_workqueue(system_*_wq) is
> inevitable.
> 
> Steps for converting system-wide WQs into local WQs are explained at [3],
> and a conversion to stop flushing system-wide WQs is in progress. Now we
> want some mechanism for preventing developers who are not aware of this
> conversion from again start flushing system-wide WQs.
> 
> Since I found that WARN_ON() is complete but awkward approach for teaching
> developers about this problem, let's use __compiletime_warning() for
> incomplete but handy approach. For completeness, we will also insert
> WARN_ON() into __flush_workqueue() after all in-tree users stopped calling
> flush_scheduled_work().
> 
> Link: https://lore.kernel.org/all/YgnQGZWT%2Fn3VAITX@slm.duckdns.org/ [1]
> Link: https://syzkaller.appspot.com/bug?extid=bde0f89deacca7c765b8 [2]
> Link: https://lkml.kernel.org/r/49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.SAKURA.ne.jp [3]
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Applied to wq/for-5.19-fixes.

Thanks.

-- 
tejun
