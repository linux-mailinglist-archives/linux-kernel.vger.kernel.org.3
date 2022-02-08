Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47814ACEA1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 03:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345261AbiBHCJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 21:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345468AbiBHCFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 21:05:15 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A6FC061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 18:05:15 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id v47so20623243ybi.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 18:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KD2mhkvCSD9l5DS6DbIhgn3YmMbk8ySuicBlkkQACtc=;
        b=cqySIEy9bKgJKJ7/J7NeKqC3EVMbDwk/apfX1u6+XEeO0ytFU0hNat47ynchPwDIvK
         +FyhYeCyEoFgI3wRksRZm8A6RIGyjxloYmYxadw/KEYQ755rBiuDOJcSeQMSg5eF+XMw
         poZ0GAwwOtvBUtYVuZjz5/jjY93/2zQfg0c1+7bbWOR1kIsl8y72eNE6czFLu4NwELhg
         +2KLKzfwV2QHFyD9k7qYBT3wp6je0O8o3Jv509qgiIgNvIlHrnEwIylA80nVHV8Mj/c5
         y6Fv6x8nZITAIxuWzPZFJPbmREJwcmYPoGUsZZeyTdTA/4gymiIw5Ik+d7CJ/0gZFqhi
         Yatg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KD2mhkvCSD9l5DS6DbIhgn3YmMbk8ySuicBlkkQACtc=;
        b=46MGLA1G8BAUWI/bIqMAl8u1jOjUp/AQPObJjy9Bot67nBLXLJHHfBeLe/vXPa8TK3
         PelQ4xFJyamvucFlkP3wdr1op1TZ8uZNWtthfwzYnQ0z+ZSMrg9AQTSfG41b9D4IPNVX
         cpgTG/7KwSAhSjlvIw2UEI5/2Lny3NsxychCYTqhMnAl0Os0BhLcq41s0qqoqcocZZZD
         5QOg3r5DNJLU7giAEcgKqQuBmkUidX1bSXTgvlAg8a8FuW1awAtuTiygb9wUxcgPPFFM
         q2t7mt3rNGytkrHyt9cm2qYu2iUiIoXpgQ49shtELbg2Peo1xYnd3bTj6h6A7nr1JHfW
         Sg5A==
X-Gm-Message-State: AOAM530SsAXUUiSiBaodvYc1xOX2+3cA87HErcokF6op59XR/pdmzncw
        baQVj37HrXcwk5FqCmvT/9bGyZnduFucI3qLFRI=
X-Google-Smtp-Source: ABdhPJxeHugI3DEllGx+J2WDZamQf12x0W60JKjf1YUmXbHrs+2Lfdq4/jr6emHIFyZ/anRDxr2TC6phuups104YuN0=
X-Received: by 2002:a05:6902:c4:: with SMTP id i4mr2597802ybs.343.1644285914274;
 Mon, 07 Feb 2022 18:05:14 -0800 (PST)
MIME-Version: 1.0
References: <20220203131237.298090-1-pedrodemargomes@gmail.com> <c4128a09-1dc7-24b3-8ff2-eaf61f3de5e5@redhat.com>
In-Reply-To: <c4128a09-1dc7-24b3-8ff2-eaf61f3de5e5@redhat.com>
From:   Pedro Gomes <pedrodemargomes@gmail.com>
Date:   Mon, 7 Feb 2022 23:05:03 -0300
Message-ID: <CACpbsfapGSbno_n7ZJYJ2E4KkqWdWe_Wz8PuECBa3PZBp2Xnxw@mail.gmail.com>
Subject: Re: [PATCH] mm/damon: Add option to monitor only writes
To:     David Hildenbrand <david@redhat.com>
Cc:     SeongJae Park <sj@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 7, 2022 at 7:32 AM David Hildenbrand <david@redhat.com> wrote:
>
> Just like clearrefs, this can race against GUP-fast to detect pinned
> pages. And just like clearrefs, we're not handling PMDs properly. And
> just like anything that write-protects random anon pages right now, this
> does not consider O_DIRECT as is.
>
> Fortunately, there are not too many users of clearreefs/softdirty
> tracking out there (my search a while ago returned no open source
> users). My assumption is that your feature might see more widespread use.
>
> Adding more random write protection until we fixed the COW issues [1]
> really makes my stomach hurt on a Monday morning.

I was not aware of these issues.

> Please, let's defer any more features that rely on write-protecting
> random anon pages until we have ways in place to not corrupt random user
> space.
>
> That is:
> 1) Teaching the COW logic to not copy pages that are pinned -- I'm
> working on that.
> 2) Converting O_DIRECT to use FOLL_PIN instead of FOLL_GET. John is
> working on that.
>
> So I'm not against this change. I'm against this change at this point in
> time.

I agree. I will wait until the COW problems are solved to send this patch.


-- 
Atenciosamente,
Pedro Demarchi Gomes.
