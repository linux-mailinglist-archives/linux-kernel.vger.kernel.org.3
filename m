Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B088853BF56
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 22:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237157AbiFBUJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 16:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237569AbiFBUJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 16:09:43 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8803021AC;
        Thu,  2 Jun 2022 13:09:41 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-f3381207a5so8159527fac.4;
        Thu, 02 Jun 2022 13:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AcNwfkxQR7d/YlmiTtCr3hnpdL0LWDXQZRLEfx+qgjo=;
        b=6ZhAdWcQeqvervg5fAxzMOx7lYMKi1n2qvtNE7tm/S7IED5xW1lPaPWHj2kHjfTRDI
         idYZOWgjj6hcDqI2HWo0sS+HO3sAau4zgV76mHUEl8F2EYqW0npgxDCsc8mMj5r2+sdj
         I4TftKCi9+2hp3mHwofDDchUGOvEkMsw7qP8Y+WtDLFURjEcatUQY8fhjP/lIWiAnh6m
         Ydkad2NK9ibzQGWrkngbB1rHyWAcAlUlZQRLv6TAIWCiUDX0CjU5wPWMkNq7q9fICa8A
         +rbTlBuyEGWb1dKNxUqg6HqXQXTprEUaGmpqs2R4WJu0J00chSbfqgM3YQDAUJmWC5rT
         Exxg==
X-Gm-Message-State: AOAM530BDxnGGuISadcjDKaML2j6f2L+U9KanhUOS7B17gRzpZKwgeue
        Y30aY3twF95O7yL8J3OVypbQMY/xEjnCaAdiy3E=
X-Google-Smtp-Source: ABdhPJyAncQxPhnFubLXK+rW6BtKMShVaYITN8d1ys7TuwWhX7qbMSrSfeU2DU+OSoxYUdaUjFDjUWzWkD3jzZTysUw=
X-Received: by 2002:a05:6870:d1cd:b0:e1:e7ee:faa0 with SMTP id
 b13-20020a056870d1cd00b000e1e7eefaa0mr21146892oac.5.1654200580847; Thu, 02
 Jun 2022 13:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220601065846.456965-1-namhyung@kernel.org> <20220601065846.456965-5-namhyung@kernel.org>
 <CAP-5=fVniyi3dtvH=-0h9ugmkcanyMa7wdxwrPR4OkFdws=x_w@mail.gmail.com>
In-Reply-To: <CAP-5=fVniyi3dtvH=-0h9ugmkcanyMa7wdxwrPR4OkFdws=x_w@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 2 Jun 2022 13:09:29 -0700
Message-ID: <CAM9d7cgzkhCpLHGyFRi51G=qw1ijX28W2zu6G04dFGhP6n8TaA@mail.gmail.com>
Subject: Re: [PATCH 4/5] perf record: Allow to specify max stack depth of fp callchain
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 1, 2022 at 11:30 PM Ian Rogers <irogers@google.com> wrote:
>
> On Tue, May 31, 2022 at 11:58 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Currently it has no interface to specify the max stack depth for perf
> > record.  Extend the command line parameter to accept a number after
> > 'fp' to specify the depth like '--call-graph fp,32'.
>
> It is valid to have call-graph=fp as a modifier on an event. To
> support a depth with that we couldn't use ',' as it is already the
> separator between modifiers. For consistency maybe a different
> separator should be used here?

But it's already there for dwarf stack dump size like
'--call-graph dwarf,4096'.  Maybe we can add a new config term
for the event parser.

Thanks,
Namhyung
