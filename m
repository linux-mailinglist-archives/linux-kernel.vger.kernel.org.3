Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043A34EE7D9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 07:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245141AbiDAFt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 01:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238796AbiDAFtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 01:49:25 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EBD248792
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 22:47:36 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id u26so1647681eda.12
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 22:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w92NLA3TMQsYKuR9CXX+L2Tvsy/pumxbCD/vKiNzt/8=;
        b=RrGd6fDL+BlZgiJiYDlk1afYMuo/wxX5kFOVTYynem0oxFMrwjZb3hB7Bju7pz0WJ5
         CqSl/I+qy0nKeqMCA+hHT115kgVy6EaTH1nxCOluYxe1hWv67AuVlYeTVsp1sMM3VP9z
         tscXTUtG3PR+1Ts022kRGQCECRCRU8bq2GazE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w92NLA3TMQsYKuR9CXX+L2Tvsy/pumxbCD/vKiNzt/8=;
        b=VB2Kl/s5kCqU6RI6RiJPzIpWn09CeF2kW4zl8fECBF1xv2oDLyentsYZlfgQIx2YSY
         /sGPLgCEx5SRctqCC0mcxtOcZQkkqVqJ9NEpVEnqN+9pVSo/m/kAhJGJx58UfQ2xnMFe
         i008Wv8omaibsA5lfX1w56BdnqysiuArkaLyNCirrijoHOMfcw0/4MXfL9XdNCHL7bCt
         ALarPR8oD2GX4+dqFvDn5WnV8eEBa0g0CSqd2PEArQUbGJizbF5mv+JE08TRG4dj0ot4
         Uhjzpc+mYAo2cpOnur25Imq9S25G5tQ4iT5S4mZKUSNMsaCuG80P9gYD+/MlterHZb6Z
         nM8A==
X-Gm-Message-State: AOAM532/05WNHk3YntPfZnhpJFukLWCjfChpTM/FOGa5kDMbpqGTleKe
        1K5AxtcfdCWXSbJPy7+y7guHElyiTc3tkPeCiMUjVn/oCeQ=
X-Google-Smtp-Source: ABdhPJyfuPxec2DZyNCbiEggRHvedTz2z7UWAXESzkgSyo7XF/dLiybkn0eMtMv3PKBjeTtUuvcfQlIL8phX0K382lo=
X-Received: by 2002:a05:6402:350b:b0:419:1c11:23ed with SMTP id
 b11-20020a056402350b00b004191c1123edmr19717204edd.8.1648792055453; Thu, 31
 Mar 2022 22:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220330031130.2152327-1-denik@chromium.org> <77fa14e8-6630-c0e9-21fc-2603f7383f5f@arm.com>
In-Reply-To: <77fa14e8-6630-c0e9-21fc-2603f7383f5f@arm.com>
From:   Denis Nikitin <denik@chromium.org>
Date:   Thu, 31 Mar 2022 22:47:24 -0700
Message-ID: <CADDJ8CVjOe4E-2uAP=vXdSFrn3+8cj4s6yDO-qqS2S0E55kjJw@mail.gmail.com>
Subject: Re: [PATCH] perf session: Remap buf if there is no space for event
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        jolsa@kernel.org, alexey.budankov@linux.intel.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Thanks for your review.

On Thu, Mar 31, 2022 at 7:20 AM James Clark <james.clark@arm.com> wrote:
>
>
>
> On 30/03/2022 04:11, Denis Nikitin wrote:
> > If a perf event doesn't fit into remaining buffer space return NULL to
> > remap buf and fetch the event again.
> > Keep the logic to error out on inadequate input from fuzzing.
> >
> > This fixes perf failing on ChromeOS (with 32b userspace):
> >
> >   $ perf report -v -i perf.data
> >   ...
> >   prefetch_event: head=0x1fffff8 event->header_size=0x30, mmap_size=0x2000000: fuzzed or compressed perf.data?
> >   Error:
> >   failed to process sample
> >
> > Fixes: 57fc032ad643 ("perf session: Avoid infinite loop when seeing invalid header.size")
> > Signed-off-by: Denis Nikitin <denik@chromium.org>
>
> Hi Denis,
>
> I tested this and it does fix the issue with a 32bit build. One concern is that the calculation to
> see if it will fit in the next map is dependent on the implementation of reader__mmap(). I think it
> would be possible for that to change slightly and then you could still get an infinite loop.
>
> But I can't really see a better way to do it, and it's unlikely for reader__mmap() to be modified
> to map data in a way to waste part of the buffer so it's probably fine.
>
> Maybe you could extract a function to calculate where the new offset would be in the buffer and share
> it between here and reader__mmap(). That would also make it more obvious what the 'head % page_size'
> bit is for.

Good point. I will send a separate patch to handle this.

Thanks,
Denis

>
> Either way:
>
> Reviewed-by: James Clark <james.clark@arm.com>
>
