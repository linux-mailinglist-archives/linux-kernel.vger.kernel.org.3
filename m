Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C8E569AA5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 08:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbiGGGnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 02:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbiGGGnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 02:43:12 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17922A25F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 23:43:11 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-3137316bb69so160748757b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 23:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B2XYaqgI1q6Tr76zsFUZ/+G5812LFpRJdzVWjY8m2JI=;
        b=Og3SqjvsKbDfTKlFDb+3VuOMZ47VAEaoBU5L7Blp/3O5w5cWKFJHkU0WhiiqVK7/Yq
         66nWCmx0bkcb/Wf+0R9YBaMie5b2cSOwz7ABsSTjPsnu5Q6F1HKC84ddr3C/HuLljx23
         jy6MF4q6aNQCX/1Orgu47l9xewoBfIeUmNLTcAgqIPDTaLfXh6NOSHHN8ARlsUkLrnwr
         xE9l1ALuC13obilX2gW1KOFfRmM10Eavw6IaPIdNGDh7cp4nlEgq5sV5k4ufGn9A4DJP
         RdM9eCrnGOa46fRce5KjNZywnuNDEuv2IsPmu79qDPu3sjBmttK6aWGJuJMAe2qXe4rn
         sQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B2XYaqgI1q6Tr76zsFUZ/+G5812LFpRJdzVWjY8m2JI=;
        b=J0muqdAXH2hq+nPhgmZptMnrl6AAqmVwQUFCIhp/K3HF9fpUp7bBfZi7+ct8Cj6XNJ
         gbMAgl57iLOqnd+VeTNSNZt++V/qT9+eo2Heb4N7tC8e9caWfOyArfHoM1HdgTIMiv2v
         Fhn1bALIc39VgODf5ws2JalJ7KP1/r9ajcaNGiVAZ1sqc+Pb9PZTQZEbt6h5/djPGLPr
         NTTezfhBoZm1z0T1g6EBPLYcQPXe3piWlRBaV1d0UciNDZWPFJm36l8f2WFJJW/LALkW
         cJUkhwka45ZBrBt2RMXDQin8myLaYbZVImjOPMJlneV1bgYuwZiRAEbkPJJon3ThZ6TB
         zZlA==
X-Gm-Message-State: AJIora/4wrGqNykHQplNTnMcklM8Wl9Dy+CCIaQTNpkjdioyY9jrDuEq
        ayORjV7IKDtyaiVrlBn9wV9PaF40Nu5jU3q5ifBq1w==
X-Google-Smtp-Source: AGRyM1uwvPHbgGsT/BFDSi4s3hIHjWvOeZtXiRryx1NVO85TcbW0s41YeXR3tKNoZusLMZm7p3UlHv4TiLqP1WY4RLM=
X-Received: by 2002:a81:4891:0:b0:31d:db7:7ea9 with SMTP id
 v139-20020a814891000000b0031d0db77ea9mr777066ywa.228.1657176190869; Wed, 06
 Jul 2022 23:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220702045254.22922-1-vincent.guittot@linaro.org>
 <e830e6eb-6606-74f1-c356-cb61c6f46e99@huawei.com> <BYAPR02MB44888C0FE86220485A38363694819@BYAPR02MB4488.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB44888C0FE86220485A38363694819@BYAPR02MB4488.namprd02.prod.outlook.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 7 Jul 2022 08:42:59 +0200
Message-ID: <CAKfTPtCTrHpNTU66ozFqL0uPy6Rwz-PppbummH4Rd_E7ZUzbnw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: fix case with reduced capacity CPU
To:     David Chen <david.chen@nutanix.com>
Cc:     Zhang Qiao <zhangqiao22@huawei.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2022 at 01:50, David Chen <david.chen@nutanix.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Zhang Qiao <zhangqiao22@huawei.com>
> > Sent: Tuesday, July 5, 2022 1:23 AM
> > To: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: mingo@redhat.com; peterz@infradead.org; juri.lelli@redhat.com; diet=
mar.eggemann@arm.com; rostedt@goodmis.org;
> > bsegall@google.com; mgorman@suse.de; bristot@redhat.com; vschneid@redha=
t.com; linux-kernel@vger.kernel.org; David Chen
> > <david.chen@nutanix.com>
> > Subject: Re: [PATCH] sched/fair: fix case with reduced capacity CPU
> >
> >
> >
> > =E5=9C=A8 2022/7/2 12:52, Vincent Guittot =E5=86=99=E9=81=93:
> > > The capacity of the CPU available for CFS tasks can be reduced becaus=
e of
> > > other activities running on the latter. In such case, it's worth tryi=
ng to
> > > move CFS tasks on a CPU with more available capacity.
> > >
> > > The rework of the load balance has filterd the case when the CPU is
> > > classified to be fully busy but its capacity is reduced.
> > >
> > > Check if CPU's capacity is reduced while gathering load balance stati=
stics
> > > and classify it group_misfit_task instead of group_fully_busy so we c=
an
> > > try to move the load on another CPU.
> > >
> > > Reported-by: David Chen <david.chen@nutanix.com>
> > > Reported-by: Zhang Qiao <zhangqiao22@huawei.com>
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > ---
> > >
> > > David, Zhang,
> > >
> > > I haven't put your tested-by because I have reworked and cleaned the =
patch to
> > > cover more cases.
> > >
> > > Could you run some tests with this version ?
> >
> > I tested with this version, it is ok.
> >
> > Tested-by: Zhang Qiao <zhangqiao22@huawei.com>
> >
> > Thanks
>
> This version works fine with me.
> Tested-by: David Chen <david.chen@nutanix.com>

Thanks

>
> Thanks
>

> > >
