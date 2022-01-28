Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EE949FDE7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350050AbiA1QUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350046AbiA1QUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:20:18 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBA1C061747
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 08:20:18 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id u14so12749141lfo.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 08:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UGBFjinD6yJ5HceIOydMt3QOO6lels/1FGluycv/zYc=;
        b=G02sjb+2szznjNomETifI9YkohtNQ5Ie4jFYsqRjS68XxVJWgCSgGyKGgbYaUAJam/
         2xwhNM3jsb1fqTgx1OdfQ+Qlrmsp9Xw1Danw3gmDcQdfs/l1nlJ4ZBl6eDIpdDTeq35O
         cm7dJ1AO4KG1npRR9zOw1Din8StBatdTPzoQyoEp+DKQmy4z++cNDw+iZWOBd+o5gLqn
         JY3siIf4mZqdrMjjR4w2BrtqKz6YK2O0HN7DI6RBicicwMku23XLJNbo38QDFrXXOQ0q
         6AGzxq2sxVohsWJrugkib4llBEsYOugitESKemCQ874EGK4IzUkwkPhwuqtIQE7lIbB6
         LZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UGBFjinD6yJ5HceIOydMt3QOO6lels/1FGluycv/zYc=;
        b=wTL/NvUswcz8OvgV5krYfcV9TfLygqkxAZ1J6YI8IIRZyuZELAQvXLZ0PJPO+VeIhV
         jNwn1eSxaglvgeXzucXceniTOtRBB/DZjk0oFhiAyVn0+CWRjKYfgIR8QsFuO6r/9QVs
         GKF04ucxQsRo96+IJW4Rq1YQDLGk+oCClo+DF78drigvIZid2se5edHVakUYRuRrIAMI
         MLbDt+WkjS/EpGS0PrEPM/bT1qhYuJd1wKs4k5T/URZYVWr2KqhAzLrSDm3g7gwOvdpQ
         zyEZu8Hv4MIClJarOWr5TiQT/H740cva2Q+1WT5TRAPQvYW9xilaVBJyOS1e9YhivKGf
         plUw==
X-Gm-Message-State: AOAM531WoK5uy4EW0oELu19mo+TUSd7XQUzsKSdO2AKwErJVO8K+7I4a
        6F45VwIDO/FT0Y2Bx+lfUmWKJcy2c/ajAfe5sq/k3g==
X-Google-Smtp-Source: ABdhPJzSer2f6I/KxwwyaLBqT3ti10NERd3yZ/GqEspFJPWSG/rr+F9z7DJ6EdBp0LIqUxROOUQXhQAdrKuL92AhJUA=
X-Received: by 2002:ac2:5095:: with SMTP id f21mr6697631lfm.20.1643386816184;
 Fri, 28 Jan 2022 08:20:16 -0800 (PST)
MIME-Version: 1.0
References: <20220127162636.3461256-1-shakeelb@google.com> <YfPgRU7Swo0VczUd@dhcp22.suse.cz>
In-Reply-To: <YfPgRU7Swo0VczUd@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 28 Jan 2022 08:20:04 -0800
Message-ID: <CALvZod4Tg8VAPOYriNfQAdW1TM1vf9rQu+7N6jc0Mod096RFCA@mail.gmail.com>
Subject: Re: [PATCH] memcg: replace in_interrupt() with !in_task()
To:     Michal Hocko <mhocko@suse.com>
Cc:     Vasily Averin <vvs@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 4:23 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 27-01-22 08:26:36, Shakeel Butt wrote:
> > Replace the deprecated in_interrupt() with !in_task() because
> > in_interrupt() returns true for BH disabled even if the call happens in
> > the task context. in_task() is the right interface to differentiate
> > task context from NMI, hard IRQ and softirq contexts.
>
> Makes sense. I do not think this will have any visible effect. Except
> for removing a deprecated call, right?

Correct, that is my understanding as well.
