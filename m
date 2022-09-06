Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3215AE476
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 11:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbiIFJku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 05:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239445AbiIFJkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 05:40:40 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E846715C;
        Tue,  6 Sep 2022 02:40:37 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id bn9so11635537ljb.6;
        Tue, 06 Sep 2022 02:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=0+DYhezzLoWJqNIc57WnwGVIa9MiDZ24BuWYzD1fu+E=;
        b=QfhVfLE7cbyCLEVbhkK2byK+qK6mOOuYXbIjS4LmizJCcEOX7fqAR2ogsRIGL4C9Nv
         o3mDYc04W7CshfYS9DFquBLGiOA2RTwXckd5CbDmOqRWoRs9SJcvqHmr3zj22Blermkr
         6viFYSYUaZr8sey5m+vPz4QiFoZbddss0ecdvyrnggDuZi6l2QUQ0tIaTGriGRIlWQfL
         wFNErzbCFDFn34fQTHHAjvREuryKHoopG3gH8H0v3OB12Yetzmrq1LRCZRoO79H6V2CE
         hUFk9S5pbZX7ku+XGhSAXuc1b4Zg4f7LEc0Y52mcDFgoMVBhOACez1yLlFfyyaVp9sT9
         nVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=0+DYhezzLoWJqNIc57WnwGVIa9MiDZ24BuWYzD1fu+E=;
        b=Fwbur+mvJZFBPe5UVWy4DTGuVucIhQLobobEaTDRNZO8McRIdr8gQg41870U9L4D2S
         WMZr5HHPgUWHYB8T1RrX5qccfYdiyAzinrf6XYIgqm08sg0jtx9oJHp80JAYQoK3u/x2
         V6BsQ+KXQX1AdHQPwCsKmlcjdP3gRppNAph6LnDu4VaCWqH2qBGXccjbg6N72ibQP7Y0
         i1w25CNyWoSvhZElHkCQuo9IZxNrE6hoG0j4LBkpDybu+rRp7vmw3Kyw/XF5xY9a+jVp
         /UNv7mMFwElcyak8E/AyqAEmBelNglTS1Whoen8CoXatiwdBQDOPoqb/rol682i9C9LA
         D9ZA==
X-Gm-Message-State: ACgBeo3ElMXRNUM7NwCyGnKl52d7Stk1pHTP02m7F100L0M1gFiM6xyP
        X6COK9lfJOVosrV/Okr8RppEGW+oQoZNtNqpUFU=
X-Google-Smtp-Source: AA6agR5YuY4SFg1XgmCZPq4Aud7zXbg+NlWVbVfhM+/2UuQ+H7lRm8h/SYVKor0DYHsA7gDwIc3iFXSEq5/j7dw6ifY=
X-Received: by 2002:a2e:9d94:0:b0:263:c964:4970 with SMTP id
 c20-20020a2e9d94000000b00263c9644970mr12003839ljj.345.1662457235608; Tue, 06
 Sep 2022 02:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <CABwm_eTnARC1GwMD-JF176k8WXU1Z0+H190mvXn61yr369qt6g@mail.gmail.com>
 <YwfYyLE3ajSFVHGQ@kernel.org> <CABwm_eSvcnygceTU0sNXLkBFaNfEfrThFVmwH=TS4hN=HVGrGg@mail.gmail.com>
 <CAM9d7cjsbhHnaAiHSBb6qAfH0bNgdKrBHdg16esRCt+4DPmvtQ@mail.gmail.com>
In-Reply-To: <CAM9d7cjsbhHnaAiHSBb6qAfH0bNgdKrBHdg16esRCt+4DPmvtQ@mail.gmail.com>
From:   Zixuan Tan <tanzixuan.me@gmail.com>
Date:   Tue, 6 Sep 2022 17:40:24 +0800
Message-ID: <CABwm_eT=BHQB=ELEWTZtXG61WyYVqQfp+gy85aD3xMRycKtLwA@mail.gmail.com>
Subject: Re: [PATCH] perf/genelf: Switch deprecated openssl MD5_* functions to
 new EVP API
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

Hi Arnaldo, are there any updates?

Thanks,
- Zixuan

On Sat, Aug 27, 2022 at 2:32 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> On Fri, Aug 26, 2022 at 10:22 AM Zixuan Tan <tanzixuan.me@gmail.com> wrote:
> >
> > On Fri, Aug 26, 2022 at 4:17 AM Arnaldo Carvalho de Melo
> > <arnaldo.melo@gmail.com> wrote:
> > >
> > > Em Fri, Aug 26, 2022 at 01:00:58AM +0800, Zixuan Tan escreveu:
> > > > Switch to the flavored EVP API like in test-libcrypto.c, and remove the
> > > > bad gcc #pragma.
> > > >
> > > > Inspired-By: 5b245985a6de ("tools build: Switch to new openssl API for
> > > > test-libcrypto")
> > >
> > > How did you test the end result? Can you please describe step by step?
> > >
> > > Also please consider adding a 'perf test' entry to make sure this
> > > doesn't regress.
> >
> > Sorry but I don't get what you mean, what results do I need to test?
> >
> > These EVP_* APIs are just replacements for the deprecated MD5_* APIs in
> > openssl v3 [1][2]. With the same input, they produce the same MD5 digest.
> >
> > And this patch just does the migration work for the upgrade and does not
> > change the logic of the code. so...what should I test?
>
> Yeah, I understand that this merely changes the MD5 APIs.
> While it's good to have a test case for the genelf code, I don't think
> it belongs to this patch.  So,
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
>
>
> >
> > Links:
> > [1] https://www.openssl.org/docs/man3.0/man3/MD5.html
> > [2] https://stackoverflow.com/questions/69806220/advice-needed-for-migration-of-low-level-openssl-api-to-high-level-openssl-apis
