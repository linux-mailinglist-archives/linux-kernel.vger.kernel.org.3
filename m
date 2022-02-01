Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18A34A57CC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 08:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbiBAHeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 02:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbiBAHeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 02:34:24 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A39C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 23:34:23 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id d188so20052430iof.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 23:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N/ZspiK4r9TEaoVNgI7Lic8oA3IpgMqPBVL6eqdGsnI=;
        b=d7EVS9w5ma5cTVIaW11AlKFdNKa2r8O2xD3G5tSzSoYSEuScaZ++BE8HWBgeNEv3Iw
         ZneqFMPx49l6xSNdozrJLmdIeoQqgPDsFpr4KdRo+VAS1brUV4gtpEEovKmLjAcVPDb7
         O2GiOzzwLdnHYmV2nVQPGawPGnP7j6zN+SYg3d1wmiJSSn0uAxezPmTQF2T0w/FvxpZ3
         qc9FlWDzc6wv4ohmoM7/RU9ld3Qt5zR2+qe68g0BtgYjgiZD5RS8NElZ3hB4ETh04Erk
         uQ2oHCqJ2qE+zpil4ph8+8HH+agGB14yU5HxhvEwXwBV/kjLqaeYuOtgQ5y2DuAcYOYl
         A8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N/ZspiK4r9TEaoVNgI7Lic8oA3IpgMqPBVL6eqdGsnI=;
        b=tm6fkmc/mbTz5fmuqyYLpN4qD7C+b6cQ2le5drvCNMLr2Bi/uFGnuQIFJzrua3k6ZR
         t1Rq/V9zJ13m3k/xk9s6QS/MRp3eKnlduoBvaarkuCU8GTmmYs/3rIvXuk7W4XpShng9
         n4w5SXAciGmuudIcJBm8Bdb4A/jwZM9Wf3KzQM0bZSp6hb7OtlEOfgBzhNDFv3anvOXu
         PntPyl0xUShia0jlfXBuAmQOuAUf6Qq6+vGJCSF+LXH7NYXm/EgGen1NRb80YQpeesSO
         Gb++W8LIwyb0YHafBzAyfMrubFyXpo6OHpIKFrNS8QGr1lmzkSnh0IL6ntN2ndXJhp8k
         wjUA==
X-Gm-Message-State: AOAM533hIfuHUb53AKXH2wCSJT1Vq/ZBPCpcgzoIC/1yhoYcPTEXzDQ9
        34/fzqxIYvf7fMfCGsGpaYjssrn6cquRvNfFfT0MPw==
X-Google-Smtp-Source: ABdhPJwE7580YfAtXz3sSrqtMSUmUt6YjuDRViAejJlmpMG1XckbnuJKpbeNOEy8J0Q9Vp2xgXHwGbhp5cOnJkWSF9o=
X-Received: by 2002:a6b:e20a:: with SMTP id z10mr13195524ioc.49.1643700863232;
 Mon, 31 Jan 2022 23:34:23 -0800 (PST)
MIME-Version: 1.0
References: <20220126233454.3362047-1-eranian@google.com> <20220126233454.3362047-10-eranian@google.com>
 <YfKZBQRpZAY/kMpn@hirez.programming.kicks-ass.net>
In-Reply-To: <YfKZBQRpZAY/kMpn@hirez.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 31 Jan 2022 23:34:12 -0800
Message-ID: <CABPqkBRXyV-D8qDHHRqFR7pft=4Hk268znfV8qjxVNhjRxH0tw@mail.gmail.com>
Subject: Re: [PATCH v5 09/13] perf/x86/amd: add idle hooks for branch sampling
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kim.phillips@amd.com,
        acme@redhat.com, jolsa@redhat.com, songliubraving@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 5:07 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Jan 26, 2022 at 03:34:50PM -0800, Stephane Eranian wrote:
> > +static inline void perf_lopwr_cb(bool mode)
> > +{
> > +     /* key enabled only when BRS is available */
> > +     if (static_branch_unlikely(&perf_lopwr_needed))
> > +             perf_amd_brs_lopwr_cb(mode);
> > +}
>
> static_call() might be better at this point..
Ok, I will fix this in v6.
Thanks.
