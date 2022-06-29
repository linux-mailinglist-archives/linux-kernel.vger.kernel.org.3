Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7E2560687
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiF2QtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbiF2Qs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:48:56 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1153F332
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:47:35 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id h186-20020a1c21c3000000b003a03567d5e9so36637wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hS0iWXw2vBwf07hRw+AJMaKL/+/P5ivyQ+NC1agijLM=;
        b=UTPJK6vrgyh5TnMtMa1HKMxiXFPTLDxlke2Q8G4jm+4uxsef+BI0ytD9mAf/f4uMB7
         U6AIMURbzNn50OYHjNi140ZxAmSV/rBOeMBF4Y5UJAZOpqSaCycRF38vD6YWz5XGLBws
         8tHtGQ47NDwpdfrKSTnIs5ZhRiirWZefqcMDPsTIydbTSGbycFInJiquD+w1C0yfVmPU
         n49TZOSp3dpA2rEgnWS6o9zshGGFVbKaDe/IiqiDyPymvgOmTgvIjboUCPfLsDUKID1f
         MVp1O8U/IzvP3+CZuvALPnmix8A1ogKBq3P157+OnajtfQHr0sUfJSXdZF+Fo4X+ZuY7
         fcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hS0iWXw2vBwf07hRw+AJMaKL/+/P5ivyQ+NC1agijLM=;
        b=b07JQ+Xibq/rb6PnAbMyHs5WDaHHyBsxLKiKY7EuBMUFlwsj/6liI73amhPPge0Zih
         cj3FmszMyN2/lWnUDDnSL0TXk/os4Him/mddwfDtVxAImh8Kxg6U1tJWfuyKBO0rKpzY
         rrVwkavCnw1v+9OtaZU6qWH8NPQOQGz6y4+w9zIU1ctogXL4Er8D7WRbc6nTE6nCHwOA
         WvwA9NTn2RHDIAHtAViwKNPJy8k66MTv7sRWR6SX3p9wn4ihmBVP57evGMztemC7pzaf
         n75rpieVrWOA3yFp1t8G0Ajcanv0IXcqK+nl7Z04WxsH8xc1lQJapgDISAjiQ9Som+LW
         ox+g==
X-Gm-Message-State: AJIora+R10byTcjDGydL0iP13PN/AGgKbdtyp6IxpM1zjwxA/aufNTXN
        60GJLIuYvEXXBX3d01zDdqSPuDNV2AYiFL0JYxDsDQ==
X-Google-Smtp-Source: AGRyM1uxkhcSA3OsIObuOFN5p+XSrzXK099UTPZg+lPZ9LA/gThbRH5Xl6cD4CYYXDihOH3PPu8P55Igo59ImMRq3jc=
X-Received: by 2002:a7b:c10c:0:b0:3a0:439d:6d66 with SMTP id
 w12-20020a7bc10c000000b003a0439d6d66mr4835817wmi.149.1656521253873; Wed, 29
 Jun 2022 09:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220627025744.106527-1-irogers@google.com> <6f9649d7-8129-57cf-8ab5-03abacd9cb6e@huawei.com>
In-Reply-To: <6f9649d7-8129-57cf-8ab5-03abacd9cb6e@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 29 Jun 2022 09:47:21 -0700
Message-ID: <CAP-5=fVxc7H75mb=j23gTD-eMYD3vru5U9QFGQDmODb57aykPA@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Rewrite jevents program in python
To:     John Garry <john.garry@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Felix Fietkau <nbd@nbd.name>, Qi Liu <liuqi115@huawei.com>,
        Like Xu <likexu@tencent.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com, sandipan.das@amd.com,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>,
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

On Mon, Jun 27, 2022 at 10:27 AM John Garry <john.garry@huawei.com> wrote:
>
> On 27/06/2022 03:57, Ian Rogers wrote:
> > A challenge with this code is in avoiding regressions. For this reason
> > the jevents.py produces identical output to jevents.c, validated with a
> > test script and build target.
> >
> > v6. Adds Tested-by from Zhengjun Xing<zhengjun.xing@linux.intel.com>
> >      and Thomas Richter<tmricht@linux.ibm.com>. Fixes issues spotted
> >      by Jiri Olsa<jolsa@kernel.org>, jsmn.c wasn't deleted and the
> >      empty pmu-events.c didn't pass the pmu-events test. It also adds a
> >      missing mkdir which is necessary before creating pmu-events.c and
> >      tweaks the quiet display code in the empty case to display a gen.
> > v5. Adds a 2>/dev/null as suggested by David Laight
>
>
> Hmmm... shouldn't this be v7? Anyway what I got with message-id
> 20220627025744.106527-1-irogers@google.com now seems to build and the
> output looks ok.
>
> Thanks,
> John

Thanks John, I think I've confused myself by working on greater than 1
machine wrt version numbers. I can re-send as v7, would it be okay to
put on a Tested-by: John Garry <john.garry@huawei.com> ?

Ian
