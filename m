Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213634C99FC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 01:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238769AbiCBAmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 19:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiCBAmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 19:42:51 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3F08F63E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 16:42:09 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id x200so135891ybe.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 16:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gPxkNU5srYWhOMugp/TjpZ9megKMxmp0wKoKBovN3Fg=;
        b=nhyLijIjL5cQld7+VL8olLi6GtQrChmsJK4gIpNpx/yOMBdq/GnzJhEJyRXh9l0awV
         dpW1ndykg+jPL3pimYTkpV8MxZbrknQrDkpGef/7pi61XL+S7Rf9+7L3qfn6KCwhw3j9
         ixNuc+v1OT0414ZG2cHPIZeHafwFYqo6CeUfMG9qfCaRKXONK07wFUfEsl13Q4PQeTzC
         ZQkY09b9Rnk4WZG/ZyxE27wtZe5q1IbgHgLGhEFuPAxvRH/KI5ayq7WF2Y45z0DO4fJ5
         7RkMCgpM2e/yYE1C3TulFsKUSXn/jZ5H+3aID9eorqHDfu1twjFS6K2QHH3gopanO40d
         wj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gPxkNU5srYWhOMugp/TjpZ9megKMxmp0wKoKBovN3Fg=;
        b=1wz0eoeMz71A8Duc7JABRcIWdvP43WSiSjfhcysXb7DbJelZTATWhl+bbt+QHkfSkC
         wLra4FmiLCoakwIcYtIFKT1thuchPbR/z5lMW38igvIF4QcCGQqh1nIi+aIEiiRvpHT2
         +vxA5WUBMI5hlA6XQfY+e/H44r5eZBy05iotonH16XyboUbrXrdoC3C1IrmhbLQ0DyEc
         r1KWN63aZbSDBngreH/TgHO8S1B3dy2//53eapcY/03q4sJDBfyaYlzkuJDwkBQYgRyA
         m4yCT7HgUW8Ii1oKClnCRFY2g4hWUS/0xQsvBwOBcxVwhM03Ub3Ye0m5mpYCDBwpMtgc
         evDA==
X-Gm-Message-State: AOAM530BuPpsmTfI+vgzK9bwAjRR+OxpYJOZhCoyJFwRkXbwmFF0o4gI
        B/+DQck1/Msd6D7AgIS5Iw4tRd6md1vov3ZOgglp1g==
X-Google-Smtp-Source: ABdhPJyrdguBYv88RQ/+J5FnGQV2BGKSB8bx0c3WlaJ1XzN+XNyB3PfqPAlAPIRLP9SPPhFx8aF24HaCnBQLGKwXSc0=
X-Received: by 2002:a25:b991:0:b0:610:bf4e:1b33 with SMTP id
 r17-20020a25b991000000b00610bf4e1b33mr27830616ybg.352.1646181728305; Tue, 01
 Mar 2022 16:42:08 -0800 (PST)
MIME-Version: 1.0
References: <20220217154403.6497-1-wuyun.abel@bytedance.com>
 <20220224164711.GA4363@suse.de> <99805673-50a1-78cd-b710-0f00ce7de809@bytedance.com>
 <20220225101625.GB4363@suse.de> <6737ab1a-a794-7e06-fbb1-8f154c4e901b@bytedance.com>
In-Reply-To: <6737ab1a-a794-7e06-fbb1-8f154c4e901b@bytedance.com>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 1 Mar 2022 16:41:57 -0800
Message-ID: <CABk29NsXc6J_zM+WaZxdjLtx_NC6+86VpMrtXrGZZ4WoQ_PPvg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] introduce sched-idle balancing
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Mel Gorman <mgorman@suse.de>, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 5:36 AM Abel Wu <wuyun.abel@bytedance.com> wrote:
[snip]
> > Also place the filter first and do any measurements of any change to
> > balancing versus the filter. I'm suggesting placing the filter first
> > because it's less controversial than a new balancer. Just be aware that
> > the filter alone is not a guarantee of merging as there have been a few
> > approaches to filtering and so far all of them had downsides on either cost
>
> Yes, understood. I will adjust the patches as you suggested and send v2
> together with more tests next week.

+1 to trying the filter rather than introducing a new balance path.

We've found the sched_idle_cpu() checks in the wakeup path to be
adequate in allowing non-idle tasks to fully consume cpu resources
(but that of course relies on wakeup balancing, and not periodic
balancing).

Please cc me on the next series.

Thanks,
Josh
