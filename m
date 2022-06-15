Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A7254D427
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 00:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350257AbiFOWCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 18:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350313AbiFOWCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 18:02:09 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A09562E4;
        Wed, 15 Jun 2022 15:02:06 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-fe4ac3b87fso18305258fac.3;
        Wed, 15 Jun 2022 15:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MP7VotlrPEyj/O+W/dC48V8Z9sBFEGUxNcsRE9QzJ5s=;
        b=5STeACigjbALQQ2433Mb+kalDCgCUlbXXdHzs6BIhUPD+kxQ1S4/Q7fIO9hoHVq/1a
         2zD+FqFE6yeg0WCD8K+ZhdnOJCpR3q3tQ+zwPK1BTmZPJP+YMql89maUOCUvfVnRku+z
         TghTjgJCOdsIQ0itK03M9/g5Vw+EGDBzSwWRDgQd2Q8ue5d8Qt3/yumKxAU2TQvYXtiX
         2KILe4x6PZlmOfrZRfvxP/zNSdODpWddUK93Nl6SmLIkYoUOUJehT2y23JMxPxuqMeIG
         C9XV9LJQwHmYzyEGJk+ac4Xkm+LOyEKV9v/sxdLUn2X+C6mVpqLTdnikk4VxTB9G8tHU
         PULg==
X-Gm-Message-State: AJIora9p1gfVA10hTruA/69Gs4T8oy7kyQC0TXq/KdajSBKcA5065cSO
        YzVeO9ZusYwidr8kSrMBckviQY0EBb+SYaC1yhc=
X-Google-Smtp-Source: AGRyM1vMuSb76jKXhHqf6SJ6Rmy3KOcpBgVTC5+7mAlBwDXHBEKUi0DNDKUOgg5/yNLeYZBVJX3l4hUFfiN3X9TUBLg=
X-Received: by 2002:a05:6870:1cb:b0:fe:f0b:e0ac with SMTP id
 n11-20020a05687001cb00b000fe0f0be0acmr6761958oad.5.1655330526165; Wed, 15 Jun
 2022 15:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220613094605.208401-1-yangjihong1@huawei.com>
 <20220613094605.208401-7-yangjihong1@huawei.com> <CAM9d7ci9R4=LuyDJAHSqtxc3nOZG+N8e7_WKJUKtL5j3xXqqtA@mail.gmail.com>
 <2953080a-a1bd-0a1c-8466-96c4b58de2e6@huawei.com>
In-Reply-To: <2953080a-a1bd-0a1c-8466-96c4b58de2e6@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 15 Jun 2022 15:01:55 -0700
Message-ID: <CAM9d7ci2XGE6jTnN1UrM=v4E55KswwQHUxmgCL71LgaCn+cFVQ@mail.gmail.com>
Subject: Re: [RFC 06/13] perf kwork: Implement perf kwork report
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 8:12 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>
> Hello,
>
> On 2022/6/15 5:49, Namhyung Kim wrote:
> > On Mon, Jun 13, 2022 at 2:48 AM Yang Jihong <yangjihong1@huawei.com> wrote:
> >>
> >> Implements framework of perf kwork report, which is used to report time
> >> properties such as run time and frequency:
> >>
> >> test case:
> >>
> >>    Kwork Name                | Cpu  | Avg delay     | Frequency | Max delay     | Max delay start     | Max delay end       |
> >>   ---------------------------------------------------------------------------------------------------------------------------
> >>   ---------------------------------------------------------------------------------------------------------------------------
> >>
> >> Since there are no report supported events, the output is empty.
> >>
> >> Briefly describe the data structure:
> >> 1. "class" indicates event type. For example, irq and softiq correspond
> >> to different types.
> >> 2. "cluster" refers to a specific event corresponding to a type. For
> >> example, RCU and TIMER in softirq correspond to different clusters,
> >> which contains three types of events: raise, entry, and exit.
> >
> > I'm not good at naming but how about calling it "work" instead?
> > It's all about kernel works anyway..
> >
> How about calling it "work_atoms" ?
> Otherwise, "work" feels a little similar to kwork_class in the first step.

Didn't you already have "atom"?  I think we can have a hierarchy like
class (IRQ) - work (eth0) - atom.

Thanks,
Namhyung
