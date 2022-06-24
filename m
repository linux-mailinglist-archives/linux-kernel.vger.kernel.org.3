Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD831559343
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 08:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiFXGWj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 24 Jun 2022 02:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiFXGWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 02:22:31 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC87429806;
        Thu, 23 Jun 2022 23:22:28 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id y77so2445467oia.3;
        Thu, 23 Jun 2022 23:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hSpectRvYq6DsCmRNXGz7AExKucd6LMcxFZxCsIXSBw=;
        b=d3VRDdf0tz5mufyW21DCkPvAyotsis8BuFh/syhtN3EKJTb7Oh9TWs3SQRUZlpQvfO
         orI0Fo2ZyLAzPhaXaVOa43/ICsAv+hT9WXs7e+4KudQzngOkJCwTA+ZqxvPVmT29Gb41
         d+0mOrMZw3U5GHQouvWj4zgBF7ypdcvDJveWS+wd1rtZfu/zIcpoZH6NgDVOMmsBxWbK
         aD0qUdXjmNbydSDoYJTdcRigkfdgQFUCz3/HSjnWo8VW6pBxts/x+wEKUgO3Iv0dlVog
         kXh/ekJaEi+xX+rPLbHmSBBHxXbPDTctV4UYddLOiZF2BJId1lutG3pvsuD0gBhM0LHy
         rotw==
X-Gm-Message-State: AJIora8pzEtVJYmfk2uGRgeQaucmvZvEMXz7Oc6qNqO/YBcgxolAtJG5
        gCOoUcFnByCtjKjxw2k7XdY/8GWbr/UrPsgcaM8=
X-Google-Smtp-Source: AGRyM1vBjU1NdQV4VjER73vQV72loH9nfVspFCLK90tN88MNy+w/dR9vjVFfEsumZn0wTc0FdtNjCg8tCjm832zgjV4=
X-Received: by 2002:a05:6808:1385:b0:32f:729e:4869 with SMTP id
 c5-20020a056808138500b0032f729e4869mr1030252oiw.5.1656051747907; Thu, 23 Jun
 2022 23:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220616230546.1390813-1-namhyung@kernel.org> <20220617073840.GA45710@leoy-ThinkPad-X240s>
 <20220617074517.GB45710@leoy-ThinkPad-X240s>
In-Reply-To: <20220617074517.GB45710@leoy-ThinkPad-X240s>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 23 Jun 2022 23:22:16 -0700
Message-ID: <CAM9d7ci8pLo=dKFgF8O8610eHTx532d+1TKTf18ibPMtdZp5Lg@mail.gmail.com>
Subject: Re: [PATCH v2] perf test: Add ARM SPE system wide test
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        German Gomez <german.gomez@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On Fri, Jun 17, 2022 at 12:45 AM Leo Yan <leo.yan@linaro.org> wrote:
>
> On Fri, Jun 17, 2022 at 03:38:40PM +0800, Leo Yan wrote:
> > Hi Namhyung,
> >
> > On Thu, Jun 16, 2022 at 04:05:46PM -0700, Namhyung Kim wrote:
> >
> > [...]
> >
> > > +arm_spe_system_wide_test() {
> > > +   echo "Recording trace with system-wide mode $perfdata"
> > > +   perf record -o ${perfdata} -e arm_spe// -a \
> > > +           -- dd if=/dev/zero of=/dev/null count=100000 > /dev/null 2>&1
> > > +
> > > +   if [ $? != 0 ]; then
> > > +           arm_spe_report "SPE system-wide testing" 2
> > > +           return
> > > +   fi
> >
> > I am awared the root permission issue after I saw German's suggestion.
> >
> > If the snapshot test is passed, no matter the system wide test is passed
> > or not, we will always return 0 for 'passed' result.  But we might miss
> > to capture the system-wide testing failure.
> >
> > How about use 'dummy' event to verіfy the root permission?
> > (actually I referred to intel-pt test):
> >
> >         perf record -o ${perfdata} -B -N --no-bpf-event -e dummy:u -a true 2>&1 >/dev/null
> >         if [ $? != 0 ]; then
> >               arm_spe_report "SPE system-wide testing" 2
> >               return
> >         fi
> >
> >         perf record -o ${perfdata} -e arm_spe// -a \
> >                   -- dd if=/dev/zero of=/dev/null count=100000 > /dev/null 2>&1

Ok, will add the change.

Thanks,
Namhyung
