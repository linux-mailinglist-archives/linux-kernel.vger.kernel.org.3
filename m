Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98CC4474DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 23:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbhLNWIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 17:08:53 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:59942 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhLNWIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 17:08:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BFB33CE1AE3;
        Tue, 14 Dec 2021 22:08:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F6AC34600;
        Tue, 14 Dec 2021 22:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639519728;
        bh=EBCK6cfvPK7Cn7mDPBKvjOcOPEz9uzpGWlhQmLLcX9k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lQPCRk71nBmpfZ5AXLT7WI+baE4psFduocX49AfCF6YI5CwyENAazWWdLRg/GKbfw
         ky8q8+DNLl9L1RXUYiNOI/hT+JQBU9BgY2k9xsyjFET91BsZhRkFYYeAHjSCsC2SF6
         IIJJKO6NPBQIwT87uIXvGWLkTosFoty/VTyPg6xLtf6CAY0hsv7lr9e6ND57TjxM9O
         tbWPQjxk3JUnhGaf63GRIzH5+F+yP9S5PyMFqpHSm+TrGFDvY316BCExKjBaj/lye7
         GwDaoKeDpy72b5lYQag123HgXLEUDLeKKRsMeqq2HIVC4C8KlI3rQ7Z1DfqJDY7Bes
         0W58LeYULijTg==
Received: by mail-ed1-f50.google.com with SMTP id z7so6816391edc.11;
        Tue, 14 Dec 2021 14:08:48 -0800 (PST)
X-Gm-Message-State: AOAM531HuQTy2ulvktL6NbAGOb4pcgDlB2fhOfqxx9xTA7D+QRTEd2v6
        n9HeDWIcRkSkWawvblS4Llh4PCTZDDLw4SrLsg==
X-Google-Smtp-Source: ABdhPJypuHgfwPsR657zl2ibcOgaM2Nuj68R9Nv3Uf4665ATnwZJAQvdfApuWhfKlV8TvOX5W5Xpxr133VMowxvjfKo=
X-Received: by 2002:a17:907:94c2:: with SMTP id dn2mr8172545ejc.325.1639519727296;
 Tue, 14 Dec 2021 14:08:47 -0800 (PST)
MIME-Version: 1.0
References: <20211214215630.4025090-1-robh@kernel.org>
In-Reply-To: <20211214215630.4025090-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 14 Dec 2021 16:08:35 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+F1x-spV4hatHLFmFHo8e4U-gf8goz69_MPihfPirTXw@mail.gmail.com>
Message-ID: <CAL_Jsq+F1x-spV4hatHLFmFHo8e4U-gf8goz69_MPihfPirTXw@mail.gmail.com>
Subject: Re: [PATCH v8] libperf: Add arm64 support to perf_mmap__read_self()
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-perf-users@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 3:56 PM Rob Herring <robh@kernel.org> wrote:
>
> Add the arm64 variants for read_perf_counter() and read_timestamp().
> Unfortunately the counter number is encoded into the instruction, so the
> code is a bit verbose to enumerate all possible counters.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v8:
>  - Set attr.config1 to request user access on arm64

Hit send a bit too quick. The kernel side[1] has now been applied by
Will, so hopefully the libperf enabling can land in 5.17 too.

Rob

[1] https://lore.kernel.org/all/163948145564.2060329.17036263207999776606.b4-ty@kernel.org/
