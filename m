Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AED59A436
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351667AbiHSRqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354787AbiHSRpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:45:30 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B00B1B81
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 10:09:11 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id p125so4858806pfp.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 10:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=9tclK/v9g50KwV+RLBZQMeHODjCGNk5Pk0kzAABIBN4=;
        b=SVUHc0QVIE7RwsM5tECaG+ih+zr0KA2/p4V2kDsO+fKZzFpSkLcK7ni5sebA18KMa7
         LF32TyIIkLMiWoAyP7mOKXdDveWyTioev61RmCh2dJ9tm/bIbyIy3BmAWHKIy+cRCANY
         jeFS66lDeohKToWNEqjUJc7FegMW5N/BeHtbz33h/7ARPr4W4QF2loU8kebWe1GgCdBv
         vFvSwvh3wpb20YoxbdoSuJx4F4DBmsVN6xQwKK1DBMYHMIPUr4SJRVCBDmtpSBJ5qn6x
         1qLMqYfqyHIZb8OoX4Gv6TpFYcHKr4D1oudJJV/17juQUTWSIE+cK9rLIdXTPf9pwQs7
         f7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9tclK/v9g50KwV+RLBZQMeHODjCGNk5Pk0kzAABIBN4=;
        b=wox0EpN7I9Z81J53WNkp2aH2XQOC5gZgbMEUBUy1vRdwwI2r66h/4jgBt+VROIbOQX
         TXomSfsyl23ymGIk6MohQYM8HoTI125xVrIqjQGZd+GxHWtU5JcoXuMNmAZhykyjWoc4
         m2GJW0LTlP7tTDCuAaN4lKOPdBadfqfjXn5U9h2sWcglnYpb23zpLwg6WfmBU8wYZBjm
         oso2eD9f0p07ws1Ja9Fyozfn1n+4VX1Qd75Tfyq1Hgyjlg85GO5a+ueIMNajig3PLvgQ
         lVeZgT2LDpjiCYK+ZeBlMMrg/MvaRWgPiKw13WVmZyvbnmILdiU1UmkeXBVYqB1wZzYz
         IK1w==
X-Gm-Message-State: ACgBeo2xlfkQgns8djj7jzCKuvbeLOP5Fajacu/yA0dEwlsJNY2FnrEJ
        M2oGO4EfL2SYquuWMyQS9RsJibK1D+HdjnNp8KwQmw==
X-Google-Smtp-Source: AA6agR4r6nOr7e7UHjQKukfhDciN5qxxdsKDLpTaOyGNSooGQW2n6IZHFTj/AwKK7s6dobuh/iNS4vy52dqr29ga0As=
X-Received: by 2002:a62:6497:0:b0:52e:e0cd:1963 with SMTP id
 y145-20020a626497000000b0052ee0cd1963mr8818122pfb.58.1660928950562; Fri, 19
 Aug 2022 10:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <1660908562-17409-1-git-send-email-zhaoyang.huang@unisoc.com> <Yv+6YjaGAv52yvq9@slm.duckdns.org>
In-Reply-To: <Yv+6YjaGAv52yvq9@slm.duckdns.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 19 Aug 2022 10:08:59 -0700
Message-ID: <CALvZod7QdLSMdBoD2WztL72qS8kJe7F79JuCH6t19rRcw6Pn1w@mail.gmail.com>
Subject: Re: [RFC PATCH] memcg: use root_mem_cgroup when css is inherited
To:     Tejun Heo <tj@kernel.org>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, ke.wang@unisoc.com,
        Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 9:29 AM Tejun Heo <tj@kernel.org> wrote:
>
> On Fri, Aug 19, 2022 at 07:29:22PM +0800, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > It is observed in android system where per-app cgroup is demanded by freezer
> > subsys and part of groups require memory control. The hierarchy could be simplized
> > as bellowing where memory charged on group B abserved while we only want have
> > group E's memory be controlled and B's descendants compete freely for memory.
> > This should be the consequences of unified hierarchy.
> > Under this scenario, less efficient memory reclaim is observed when comparing
> > with no memory control. It is believed that multi LRU scanning introduces some
> > of the overhead. Furthermore, page thrashing is also heavier than global LRU
> > which could be the consequences of partial failure of WORKINGSET mechanism as
> > LRU is too short to protect the active pages.
> >
> > A(subtree_control = memory) - B(subtree_control = NULL) - C()
> >                                                       \ D()
> >                           - E(subtree_control = memory) - F()
> >                                                         \ G()
> >
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> Just in case it wasn't clear.
>
> Nacked-by: Tejun Heo <tj@kernel.org>
>
> Thanks.
>

Was there a previous discussion on this? The commit message is unreadable.
