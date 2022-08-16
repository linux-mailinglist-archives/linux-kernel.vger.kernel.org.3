Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606A55960C2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 19:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236718AbiHPRBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 13:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236711AbiHPRBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 13:01:50 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA9780E89
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 10:01:50 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id d1so8326336qvs.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 10:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=YMl9KRPZA1tYlpY7uwctkgt1uil4+N34mu7o843qNlM=;
        b=BE6TH2bExTZsoiHpqlDIgw05eAEJ6ZRzNepEZ80SsbRWw+olYfdtnLgZrIGZxX6REY
         enoYyfkq8EQthlhq1aCXkwoX9+Sy4MB7eI0NVAHhTyInYPmEi83k8IgqduOBA6Pu27cV
         1yzA5lB5rszbVO3H2c4qvLSGpCHiXiGh7Z58+OWeU8dr+pzqvrqpaIr7/f3vzOKC4ODu
         c0Rije/86zqWuYz8CHuc1EPU50vkNVzLoG4aSOW4g/7eajrAPtA20SkRWEPoVquvMner
         +oZuXIOCZ+msQ9sBkWtC2rERiq4fxGvPUWF0TkP4tIuow7HLxfAukP0t5sl2NsKgAEqB
         J2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=YMl9KRPZA1tYlpY7uwctkgt1uil4+N34mu7o843qNlM=;
        b=Xx+Uo1GCuVhxFRdWLFmNoZDt1UBPWpkXUQKLmYEVrjfdtetDt4S9cX27ZsRSxIgwkk
         aIbFELbzEvITw79sw0OSgkbUiQTMZk55E4Kym4DiGs84pXMe4SSnlXHOHVGKOxZTT740
         2GW4mxbA7cjn5Gp4clva0EBY36zyxyOLVpvZzEbp/pil2b6mfE3gHorCDW3OTZCFyJRI
         l5b6FCE0io6GwgumOLWcs8ujNBRB+17OiZcUGVWU8+cDV6wrszK55Yp5UsKFk2KvbQHl
         PsL6JdSOee7I3ZgsPt0axoYaOvyUzipGVcMjXLmlazLNp+Dn9ncAX9VaaLOCvGHO5+h7
         UGlQ==
X-Gm-Message-State: ACgBeo0RrBaUI2YRA4Dhc/v0Z75QoYXMobE8NwtsRzgswXb0d0AxqDyQ
        j7xcPqfp7f5ybQcozpGklb7a5qMwr7zX0g6XJ1W6vQ==
X-Google-Smtp-Source: AA6agR6ky4IGIxPLHhYV/8b2uxiAAYt+pZFHM3JktXk12uHP3jVa/AarKFhfi8Td1DFgzcnQxQKbVuSvWbob6B028VI=
X-Received: by 2002:a05:6214:2267:b0:474:8ff7:a21c with SMTP id
 gs7-20020a056214226700b004748ff7a21cmr18778338qvb.56.1660669308955; Tue, 16
 Aug 2022 10:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220808155248.2475981-1-void@manifault.com> <CA+khW7iuENZHvbyWUkq1T1ieV9Yz+MJyRs=7Kd6N59kPTjz7Rg@mail.gmail.com>
 <20220810011510.c3chrli27e6ebftt@maniforge> <CA+khW7iBeAW9tzuZqVaafcAFQZhNwjdEBwE8C-zAaq8gkyujFQ@mail.gmail.com>
 <YvuzNaam90n4AJcm@maniforge.dhcp.thefacebook.com>
In-Reply-To: <YvuzNaam90n4AJcm@maniforge.dhcp.thefacebook.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 16 Aug 2022 10:01:38 -0700
Message-ID: <CA+khW7gXXEtRg-m5NY16PG1hCMJb2-Bnfrp7rkedAz8JHC5HWA@mail.gmail.com>
Subject: Re: [PATCH 0/5] bpf: Add user-space-publisher ringbuffer map type
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, john.fastabend@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        jolsa@kernel.org, tj@kernel.org, joannelkoong@gmail.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 8:10 AM David Vernet <void@manifault.com> wrote:
>
> On Mon, Aug 15, 2022 at 02:13:13PM -0700, Hao Luo wrote:
> > >
> > > Iters allow userspace to kick the kernel, but IMO they're meant to enable
> > > data extraction from the kernel, and dumping kernel data into user-space.
> >
> > Not necessarily extracting data and dumping data. It could be used to
> > do operations on a set of objects, the operation could be
> > notification. Iterating and notifying are orthogonal IMHO.
> >
> > > What I'm proposing is a more generalizable way of driving logic in the
> > > kernel from user-space.
> > > Does that make sense? Looking forward to hearing your thoughts.
> >
> > Yes, sort of. I see the difference between iter and the proposed
> > interface. But I am not clear about the motivation of a new APis for
> > kicking callbacks from userspace. I guess maybe it will become clear,
> > when you publish a concerte RFC of that interface and integrates with
> > your userspace publisher.
>
> Fair enough -- let me remove this from the cover letter in future
> versions of the patch-set. To your point, there's probably little to be
> gained in debating the merits of adding such APIs until there's a
> concrete use-case.
>

Yep, sounds good. I don't mean to debate :) I would like to help. If
we could build on top of existing infra and make improvements, IMHO it
would be easier to maintain. Anyway, I'm looking forward to your
proposed APIs.

> Thanks,
> David
