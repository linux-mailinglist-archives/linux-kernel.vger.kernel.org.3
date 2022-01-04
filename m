Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6B048474E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 18:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236025AbiADR6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 12:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235999AbiADR6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 12:58:30 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60190C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 09:58:30 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id e202so67581199ybf.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 09:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lKYugI14weLPX72dba0R8OyZDrnFDsVWJDf+XD0rZGo=;
        b=dXgIwxD8i4PoqUe119pPc/sEWYIzl+sLHg+NEe1rLa9tFyMlJVpl1FG86uMmlsnyHB
         2DYJn8udr6JTTYCX02TKcjSakwE+4wAaa9EjA0r1ZH/MngxxT/liU9sT6JBmVJyWXQCu
         2l44McQXoBdQqaaAOc1Z7f26GR6+7BK8FCxQcn1Qu+bouDGzvKelWFqx7ZGzymc6cma7
         I5N/UJmEu8QkA/ADb+T61W1rIzfc1Al7mVC/eIF/mmztF8l+XpV0newj5oGye1ENG3B6
         t0Br0D9QGpFk22n8QaHtipwIicjdMLmXVmBBwFbnrkeiMAuG8WEjIRAYu5ODAys7emo9
         Lm7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lKYugI14weLPX72dba0R8OyZDrnFDsVWJDf+XD0rZGo=;
        b=PH5a22j+iurjLSuxfQa7Uqo4Ju2b/Qig5WzZyPAnYqEfhXeGTrGqd91ckelAiHsjSy
         LztTUN4DUEWSoUPztT61k1vzz/3OfzbdvstmIDsYmPpuV3bzpxBs6tfkpb+dVMDsi2i6
         Bhu87t53tZbGZ5P/edUokBcGgqyLGBXTPMhDclRtu/Y3JZiJAGpPUuicixA3Qq9ZjH1+
         hs9jSZKejhuTiqc7UHbChLKuEMYnNPRy9tttp+wYmJZ41vcZHymehh9R5x/RG64IVjmW
         HRjW1S7RdhsIEYApQ9jEvvJAkE5y0MLk9Z80eCRJ9ke2DVO/Biyp/QI1dhnT4vj4EWGb
         0GLw==
X-Gm-Message-State: AOAM532ZhV9Py2sniMfQ5Sx9bN+llmeuYhPV2OUtmk6KockjLh40L2i8
        ni+Hf6eJpTXNoboKo0WVie5D4C87ctCjDzuqD0284g==
X-Google-Smtp-Source: ABdhPJx7iE9F4XiDdZX0VcwtfzkIvbL155r3HPzcjPWDmI4J3EegNVpdjVjYfIHTFYaDTjlFY8z/HCRg04KPU3IVCxM=
X-Received: by 2002:a25:2786:: with SMTP id n128mr27908830ybn.491.1641319109224;
 Tue, 04 Jan 2022 09:58:29 -0800 (PST)
MIME-Version: 1.0
References: <1640262603-19339-1-git-send-email-CruzZhao@linux.alibaba.com> <048124e2-8436-62e3-6205-f122ec386763@linux.alibaba.com>
In-Reply-To: <048124e2-8436-62e3-6205-f122ec386763@linux.alibaba.com>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 4 Jan 2022 09:58:18 -0800
Message-ID: <CABk29Ntcq-ou=2JPBRs4HhOUcOcsL-hdG5ns55-TTHCOePhnZg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Forced idle time accounting per cpu
To:     cruzzhao <cruzzhao@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 3, 2022 at 11:15 PM cruzzhao <cruzzhao@linux.alibaba.com> wrote:
>
> Ping.
> Accounting forced idle time for per cpu can help us measure the cost of
> enabling core scheduling from a global perspective. Mind having a look
> at it?

Sorry, just got back from vacation. I'll have a look at the patches
later today, but the idea sounds reasonable.

Best,
Josh
