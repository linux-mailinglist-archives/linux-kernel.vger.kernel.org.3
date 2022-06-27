Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4149755C83A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239508AbiF0QgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 12:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239481AbiF0QgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:36:23 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B041FDF88
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:36:22 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id x8so4985516pgj.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ANhhO7JNrRXiqBfOWIC5+O/LvdCECTScDPQomu1+/z0=;
        b=n/WUxi56hKE+TeD/xqZTEZq6eQ+SE3Hq6EH9EpACo3HipGWBP2dl+buQfwfZRYO+ZO
         PV97im0rX7N1bqz9o4X8jkXnf+QROcyi8m1+MPmUsJzpShTF7kJx8FRLH13hapDhHLYK
         94P44qNWmMOtuBo0j06S3GZauxvG+v90zNsMUF8yj7bjHtAwSN71yxsPEPZQC50AaObx
         xU5gOOqRYp/28DddoR9NTW1mJwjwgeGsJGWBe2Vrhx6S/E8DMZ6dOrn/NquZFZxYkjqu
         nm74iKLM5V5WgHloSZwaRj1OX6gPPr3zNAEUf1NiU05HefW+7Z+xYzVG1t7FsxoDavBr
         N7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ANhhO7JNrRXiqBfOWIC5+O/LvdCECTScDPQomu1+/z0=;
        b=W1HMfe8PugPShp4/ulSThyJO/0jAiyXNOUnU6qh/YTutVaAXtzhL7zNMzY0YktNpbG
         lBOBOgxIfGXv8MZqYqQUblWDIrbVeU2D0/v7mgUmYxsR12qzwWIKWrkp2r0VlPhE8DZc
         z0S8hfgZYBO+aXjbHrWmvrSu/C8s68JaiWGPteRGcMjaShBL8lSc9IuFmpLo3884U17k
         T7Sm10M1hjBo27WMLs8zRFX4sCCoNRg+VAHBYfRY4+jNIUxnYk1ElDbHklqqno72xZKP
         ZsLSkCRq72N7O+yyWJ4Os5NLPnPNs31yERXuwAuI0cch7EcSx0KMMoTIip2Bl34vYcCq
         O37w==
X-Gm-Message-State: AJIora/sKfElUKDFnNEcqHjB1HWqVLpg5xxA1DRzLW46HIGFYwptaXEk
        W9LRJMQcMEViQ7TjfyEdRGIc7H6Ms1xClU0Fy7Thkg==
X-Google-Smtp-Source: AGRyM1sYurXg7zhV7xDjfkN1S1RoUpkwPJguY2/emx2Lcgx6o+cg//P+aKubXVRN42wpU0NAEJ1emY7Y6/HkqjJg7UQ=
X-Received: by 2002:a63:5449:0:b0:40d:c8d4:ed6a with SMTP id
 e9-20020a635449000000b0040dc8d4ed6amr10392717pgm.9.1656347782030; Mon, 27 Jun
 2022 09:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com> <YrYCeYy0rjfGhT/W@casper.infradead.org>
In-Reply-To: <YrYCeYy0rjfGhT/W@casper.infradead.org>
From:   James Houghton <jthoughton@google.com>
Date:   Mon, 27 Jun 2022 09:36:11 -0700
Message-ID: <CADrL8HUtdd=yEtY=bhHRYVjA30O1CAd6XEj+oTNjviWkSmzowQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/26] hugetlb: Introduce HugeTLB high-granularity mapping
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Fri, Jun 24, 2022 at 11:29 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Jun 24, 2022 at 05:36:30PM +0000, James Houghton wrote:
> > [1] This used to be called HugeTLB double mapping, a bad and confusing
> >     name. "High-granularity mapping" is not a great name either. I am open
> >     to better names.
>
> Oh good, I was grinding my teeth every time I read it ;-)
>
> How does "Fine granularity" work for you?
> "sub-page mapping" might work too.

"Granularity", as I've come to realize, is hard to say, so I think I
prefer sub-page mapping. :) So to recap the suggestions I have so far:

1. Sub-page mapping
2. Granular mapping
3. Flexible mapping

I'll pick one of these (or maybe some other one that works better) for
the next version of this series.
