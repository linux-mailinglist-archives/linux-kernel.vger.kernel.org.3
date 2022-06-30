Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134DA5624B2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 23:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236785AbiF3VAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 17:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiF3VAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 17:00:09 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B6D4881E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 14:00:08 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v9so317523wrp.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 14:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y1/852Kpl379DkY8IyHRAhEAKB1VElvfB/9xeoKwddc=;
        b=g5iaMxpsnZVPeiR6mp8wdabUx6Wei2zb1VMqZvBvpOVmyciM0fiy4UUa5xEf2Df6Cn
         E+nnCdIAShcZOvGltX2sMdz3ldP3j1u8XNXQ3FYnKg6LE31KqIMXjaPLmRHkqVBrKP6c
         mr7KABDhIh5XDVPz2IIpQl6S20UeM0J9mI0/kCmvsdtZ3pplt91D3pDbdSyKl2xjZFoo
         DuBxPIFD3H4kLhrg7c/gqphG4YuiaTl/HOAFU0nupdkrR4Z+qFbppe4JGKy2lQySMXmE
         GJSfC1tet0saTgMCOGN0TRWCeBhN0O+X1KIh7vUMyNdD6KDhNmA+KJQTr3oT8bog1ZGO
         UVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y1/852Kpl379DkY8IyHRAhEAKB1VElvfB/9xeoKwddc=;
        b=k8vGV4SGLZBzR0wvaRbQLxhIbmYJVwNhSoI+XrzHdgUEkcJJNVOarkKdPtnZqLVyv1
         mxo7I87WfdmnXqIu+VsmAUzJPQDUat5fArAYLCWrKEE/eHh7QRzC2J5+VyXcZpNCmd5+
         9T7uIzgmlNU+IZkeYzCiGHrKhLtUSh7Bs5QP5F10IIRBvnfvyCb4sU/9wk46N7Funwm0
         vdyILDDgcLp2O0EJlYIJ6+vNoo3WEaaAR3XJEE+ZeHbmjFibRAu8RTJbZG1TQSJNiFXY
         RVBTzQdf/vY6xIJJXTWcCuLEtExvtfsXYxKszfLP7RRv5cil3ukIjr0uDJoEuTleILOW
         y3VA==
X-Gm-Message-State: AJIora89M90KKkgdGteHfk+5q5VyOhj/qxcz87QyXW6qBZBvVD2t38jx
        2hRU84lb/mIFNF2u1qNHiAsCYxYSRJc2zlTwLgWR0w==
X-Google-Smtp-Source: AGRyM1tK4gBdtJYZ7ivkabtQEl5FWGBcZiAP8LVIytEjl138vvcvZTC5U8ID7obXg4LJdMhrl/X8V0UWvdpSphlUT9U=
X-Received: by 2002:a5d:5983:0:b0:21b:b7cb:f84e with SMTP id
 n3-20020a5d5983000000b0021bb7cbf84emr10592230wri.654.1656622806498; Thu, 30
 Jun 2022 14:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220629034007.332804-1-irogers@google.com> <Yr1ozmP2E8Fer11e@worktop.programming.kicks-ass.net>
In-Reply-To: <Yr1ozmP2E8Fer11e@worktop.programming.kicks-ass.net>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 30 Jun 2022 13:59:54 -0700
Message-ID: <CAP-5=fXRxvSB9WrcTEM+2rnALuzPBdPz=v+WGhvN_SS2Ba2MTw@mail.gmail.com>
Subject: Re: [PATCH] perf test: Skip for paranoid 3
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Claire Jensen <cjense@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
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

On Thu, Jun 30, 2022 at 2:11 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jun 28, 2022 at 08:40:07PM -0700, Ian Rogers wrote:
> > Add skip tests for paranoid level being 3.
> > Rather than skipping lines starting "Failed", skip lines containing
> > "failed" - making the behavior consistent with the previous python
> > version.
>
> paranoid 3 is an out of tree patch.

Thanks, what is the right way to resolve this? My desktop appears to
be carrying the patch and I'd like the tests to be as green as
possible.

Thanks,
Ian
