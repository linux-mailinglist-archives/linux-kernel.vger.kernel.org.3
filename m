Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FA454D1E8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 21:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350306AbiFOTqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 15:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244636AbiFOTqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 15:46:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE8F54BE9;
        Wed, 15 Jun 2022 12:46:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5461C60C32;
        Wed, 15 Jun 2022 19:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4532C341C0;
        Wed, 15 Jun 2022 19:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655322407;
        bh=nOopfbmMyE0zFSTGtfblVa/zt6IbMPT2M5vyvVqxC5U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nkWj9LfdIx6JvO6oHl690f+EQlTF17ydQgfzXPAWXAo0DSHZlOK+Kqs+8WYA8mq3f
         7gX46Xr0YGAUjYyWIlFcQgWnSb/u4L7BVMrAFUYOd/I1oZpO65eoRM6I5FR71JY4vl
         XPySLRD+shq5NFDfeyTP2stBiEv3h2ESeq9l24LsRZYu0zewefobGoeMPNNkvYP2wo
         hKcZ82b5JaYW10RdqEbMSgrMkvh1wiWn1EeOd5v+862g2qgAQ8xXtDcg7s1AYFX+84
         TIFLlC5tbvCuWUznULVZNfpwS6KCfSHKnZHipgPT8T3rmtmZhSsXDm7/iOynAzpXJU
         ATUES8wzHzJoA==
Received: by mail-vk1-f174.google.com with SMTP id c11so4647773vkn.5;
        Wed, 15 Jun 2022 12:46:47 -0700 (PDT)
X-Gm-Message-State: AJIora8os1VPqroVHgUKnySi3/wRxJ6EAkUqbQ6EbB+u2nLNTOUaPBsL
        nM1RbqHRKoi8FtThKVXsX2pL4Z8TnpuJdkNrGQ==
X-Google-Smtp-Source: AGRyM1spP8wpUv515CCMbtNvuylDnX5ozPVOexUvJfKJpfu+CcNlYJMF+vd1Acbtc6mwAep1k0kVJcWbjEQpD/ZgXDg=
X-Received: by 2002:a1f:a1c6:0:b0:35e:3f6a:b8b8 with SMTP id
 k189-20020a1fa1c6000000b0035e3f6ab8b8mr898915vke.26.1655322406702; Wed, 15
 Jun 2022 12:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <30d95df2-c3b-b3e3-d65e-c6be0355fb1@maine.edu>
In-Reply-To: <30d95df2-c3b-b3e3-d65e-c6be0355fb1@maine.edu>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 15 Jun 2022 13:46:35 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL+0z1vc+T+9m-faoM-4W=x=7-UBu5=S-QGjTwU2biGNw@mail.gmail.com>
Message-ID: <CAL_JsqL+0z1vc+T+9m-faoM-4W=x=7-UBu5=S-QGjTwU2biGNw@mail.gmail.com>
Subject: Re: [perf] why is /proc/sys/kernel/perf_user_access ARM64 only?
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 11:57 AM Vince Weaver <vincent.weaver@maine.edu> wrote:
>
>
> Just wasted a lot of time tracking down why rdpmc() event reading wasn't
> working on an ARM64 machine.
>
> It turns out ARM64 has added a custom
>         "/proc/sys/kernel/perf_user_access"
> to control rdpmc access, but only on ARM64.
>         e2012600810c9ded81f6f63a8d04781be3c300ad
>
> Why is this ARM64-only?  Why isn't this generic perf infrastructure?

Adding it on x86 would break users at least if default off.

> How is this different from the existing
>         /sys/bus/event_source/devices/cpu/rdpmc
> tooling?

big.LITTLE

We need a single point of control. Otherwise, there's dealing with
mismatched state of multiple PMUs.

> Also, when user events are disabled, why is the ARMv8 PMU not disabling
> the cap_user_rdpmc bit in the perf mmap() page?

Humm, maybe that should be changed. The current behavior of
cap_user_rdpmc is static for the event and set means user access may
be enabled at some point. Several factors can still prevent userspace
from getting an event index. A counter couldn't be allocated or
perf_user_access is disabled.

Should the event open fail if perf_user_access is disabled? Current
operation is it isn't considered and perf_user_access can change while
the event is opened.

> rdpmc was trouble before, but now it's an even bigger
> architecture-dependent mess just trying to figure out if the feature is
> enabled or not.

The thing is that x86 started with access being wide open and has
since been trying to lock things down without breaking userspace. It
still has questionable uses enabled which complicates the
implementation. For arm, we're starting with access being an explicit
request on open and only for task bound events. If there's a real need
for other scenarios, then we can revisit that.

Rob
