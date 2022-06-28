Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BFB55EB86
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 19:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbiF1R5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 13:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbiF1R5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:57:21 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DB863EF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 10:57:21 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 128so12658261pfv.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 10:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SyXP69UMdpWhbeCjVMeoYpoBgv9ZnYwJYIVHkhJptJk=;
        b=W7LI5MjRbDRJuY3TkbfMVg3CvpLTFQpVGwBoa75khlNp1ZdHPydtPqdBx90PVaeKYs
         E8P4BqbFG2iFDfzssjEaMp6oRYfSQ5GVOB3st43drA1/x6wgqiVSTY2eUWCnuI3XnYac
         FP9IqQ0sMrhEjeu0VtA9uOQiAqAP2K4UDjW+e51WoJm7ZrDNXOrdXFIzP6E8oycOftbm
         KHPNga83xVw1OsGbgOAuoG+FIPteLglULZxn7ndByqXmFxCSZWeEXNE9RP95HtgIzCJ4
         oHM/i7Y3zY6hTGGtD2jVBXeuj6bveEobxbx+NANP00zUU4wknXeP2rksKhNbzmzRjBL5
         bhag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=SyXP69UMdpWhbeCjVMeoYpoBgv9ZnYwJYIVHkhJptJk=;
        b=7MMdZdH1oDw8wIE3TSB091IkFCvWCHmFaj5J3uIW+g2gokBmjhbbcI3Aw/ZXZemDD6
         V8HAF24uQm/EuVAp7IlrBc/BCjw8Djsn/27UySnhQ90nHHLCYfHW8/mmJf8c2IvlU20O
         aSoRmntIWAJOf5vqKfU3hWzs9PK2/K/IBy4iNKgasQoSPjOHpzv3Ze0x7oXZIJET9NY6
         oXv837+OM/JocqSUv9jy0W7/04zOY4eT7cSUPITLsZq6on5jG9Ws1qTdfo7TKt6VU6NE
         HwlEQ9NQejGrUEu4tTfsUHVKJn3vByGzGuY8h14miEBvfxm51z97NuuUwUNGdOFD3Woh
         78WQ==
X-Gm-Message-State: AJIora+GPEVPIGNzSLhoi6GUy8R+5rUFpHEeDe7D4S+igsgnGOS/jTPU
        7iXDBDiq+7HurCp6JOM7k+w=
X-Google-Smtp-Source: AGRyM1u0MylCDOrOADEDOsEI79Kl+AhmOEou6aOx32/kntofp1Hvc/6pHilVAWq2OMJj6Un2XIsWKg==
X-Received: by 2002:a05:6a00:3498:b0:525:448a:de0 with SMTP id cp24-20020a056a00349800b00525448a0de0mr5892554pfb.85.1656439040742;
        Tue, 28 Jun 2022 10:57:20 -0700 (PDT)
Received: from localhost ([121.167.227.144])
        by smtp.gmail.com with ESMTPSA id n24-20020a170902969800b0016a034ae481sm9610429plp.176.2022.06.28.10.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 10:57:20 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 29 Jun 2022 02:57:17 +0900
From:   Tejun Heo <tj@kernel.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Cruz Zhao <CruzZhao@linux.alibaba.com>
Subject: Re: [PATCH v3] sched/core: add forced idle accounting for cgroups
Message-ID: <YrtA/ZksAYaxqcx3@mtj.duckdns.org>
References: <20220621234443.3506529-1-joshdon@google.com>
 <Yrl1Tdds6g7h60F3@mtj.duckdns.org>
 <CABk29NvMRWbJgZ7VdzdeDVz0v=PKJJJ0gFk=+X884U25ZJhbsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29NvMRWbJgZ7VdzdeDVz0v=PKJJJ0gFk=+X884U25ZJhbsA@mail.gmail.com>
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

On Mon, Jun 27, 2022 at 03:35:21PM -0700, Josh Don wrote:
> > Would it make sense to namespace the name to reflect the fact that
> > this is tied to core scheduling? e.g. something like
> > core.force_idle_usec (and yeah, underscore between words, please). I
> > kinda hate that the feature is named "core". The word is so
> > overloaded.
> 
> Sure, although a namespace of "core_sched" would be a bit clearer,
> since as you point out "core" is pretty overloaded :)

Yeah, core_sched is probabaly better and hopefully it'll get better as
we get used to the name.

> Lack of underscore for forceidle was to be consistent with
> "core_forceidle_sum" being dumped from /proc/pid/sched, but I'm fine
> with it either way.
> 
> So,
> 
> core_sched.force_idle_usec ?

Yeah, that'd be my preference.

Thanks.

-- 
tejun
