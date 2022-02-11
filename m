Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472804B1E7B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 07:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbiBKGRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 01:17:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiBKGRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:17:12 -0500
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B38825CC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 22:17:12 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id k18so11072260lji.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 22:17:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CNKy2lqXMDz+EOd6V+yV/K/AeeyEWZQOrqzjQottx18=;
        b=AkdANf2WTQyPUQorXKtFsUuNMtrFPKduH19wtJ6EcwNsGz/+5XRQlNo7d6BjKK1C1l
         tEgy9r96HL6WMfDbnvhTPPtF2Ekf6Prkko5ujVBVNiE52r8LcTC9GGI9kv6iq1No6iZe
         7Xr5pXklaeodpStHe/oR3puUw/RKUSJAhO0TUT6T8P4RYPyYMfSg5T9IZf+zCGYU53or
         ytnXKEKvMkVbg+0QP4aH88zHgEPXI/oE9UOxW4v6vsG6gx+EZ8LajRAv0P0VERTk8Qvg
         BnGelRNHD4L1pKZOwF/ip31XE2kYVetJxugC/RvLJiuvvwbrswnP+f+gMs3okJhywt+E
         9nbw==
X-Gm-Message-State: AOAM530HrYMi8GxailKa7Sk1fYnWa2y68/i3I7fjFEWp2miyPbiz/4oN
        OBYPg+jOMyDR4qdD8B3UG/iv6pOEjEAJ8SQ5HdM=
X-Google-Smtp-Source: ABdhPJwidqNLmU3Pglr80N29CRCVWGXIkylino9scaLETcDPEc/UFfuxh2kOIcSCtdRZtXzTxqDBEZKUjjpqOZim8lQ=
X-Received: by 2002:a05:651c:a04:: with SMTP id k4mr115814ljq.180.1644560230207;
 Thu, 10 Feb 2022 22:17:10 -0800 (PST)
MIME-Version: 1.0
References: <20220202070828.143303-1-namhyung@kernel.org> <YgVa0/B7MUKRz88C@kernel.org>
In-Reply-To: <YgVa0/B7MUKRz88C@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 10 Feb 2022 22:16:59 -0800
Message-ID: <CAM9d7cikhttPHQ7CXRvNq5mLfoojt-ke_2bKz0T3Z1o+hTFb8A@mail.gmail.com>
Subject: Re: [PATCH 0/4] Handle chroot tasks properly (v2)
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Thu, Feb 10, 2022 at 10:35 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Feb 01, 2022 at 11:08:24PM -0800, Namhyung Kim escreveu:
> > Hello,
> >
> > I found that perf tools don't work well with tasks in a chroot.  The
> > filenames in MMAP record are from the root directory of the task so
> > it's different than what it sees from outside.
> >
> >  * changes in v2)
> >   - add Jiri's Acked-by
> >   - split stderr setup for objdump
>
> Applied 1/4 to perf/urgent, its already upstream.
>
> The others are bit big for this time, so I've added it to perf/core.

Perfect, thanks for your work!

Namhyung
