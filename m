Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8D05448A8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242251AbiFIKUu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Jun 2022 06:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiFIKUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:20:45 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27655366AB;
        Thu,  9 Jun 2022 03:20:43 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-31336535373so85124857b3.2;
        Thu, 09 Jun 2022 03:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6UMvM2Od2zd3FK0Vx+mbZXyfmn7so9sKMco52kVS4vI=;
        b=u8BCgFG9FoHEd+EDzpKZSKymPjfA+oCsTWR7pxdwQLMP971nYB2e7FRIbSFoVXTtej
         dRs3M6unf/wGxdOlLAageGCbnnh4qy+dWcRyxGqnbo7Spmz+T3ZBKJpx/rj+OgcEyHud
         PwHWBu2LkR8RVsulVgcUwZYKs9j0dn+dnHHgHZMCy6779Phap/fa4nnpwBdh54j3Pjfh
         RvaQhgf1wntXG+UDKwhohKq2/UPrbfV9MTQjRJU2qC4tQCHhl+Qeg0DVZ8eSYXyXCgzY
         WwM8aRsFPEBE3dF75W6r+imDzmSL9UtG/fZfhpeGWIQIVdRg2XYVI2/k94FfDaIGMtzn
         wulg==
X-Gm-Message-State: AOAM531P2+TZqBc12hujRgvalZLrMHDXs6YOIOWLpnLv0KmStbjR7cpx
        9ySBfuBWxsQTAuKykIq+wGDWJV9acdP0/MF/NnLFiLL6pl8=
X-Google-Smtp-Source: ABdhPJx8V1va8MPi99jGEZGUmafmjgzGfiLzAR8cpH6L+rWX736AiJTComkjSe00FioyENanmEbvDoXwVZvLs4kVh8w=
X-Received: by 2002:a0d:c442:0:b0:2fe:beab:1fef with SMTP id
 g63-20020a0dc442000000b002febeab1fefmr42566152ywd.196.1654770042242; Thu, 09
 Jun 2022 03:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0hjp2-yLN_UyQvMwhoPreTkA3xU0g3boYtxgLi6TWqabA@mail.gmail.com>
 <CAJZ5v0iLoGsauHTh+H7EemsjGApXpant0RQFEDZRQMiGoHzpCg@mail.gmail.com>
In-Reply-To: <CAJZ5v0iLoGsauHTh+H7EemsjGApXpant0RQFEDZRQMiGoHzpCg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Jun 2022 12:20:31 +0200
Message-ID: <CAJZ5v0hEodhL2P50=MwN-jW7EF_k21CnQOnwiqTAGHyDo=2u3Q@mail.gmail.com>
Subject: Re: [CFP] Power Management and Thermal Control MC at LPC 2022
To:     Linux PM <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <len.brown@intel.com>,
        Saravana Kannan <saravanak@google.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[I see I sent this from my personal e-mail address, sorry for the confusion.]

On Tue, Jun 7, 2022 at 5:30 PM Rafał Wysocki <rjwysocki@gmail.com> wrote:
>
> Hi All,
>
> On Wed, May 25, 2022 at 7:48 PM Rafał Wysocki <rjwysocki@gmail.com> wrote:
> >
> > Hi All,
> >
> > The Power Management and Thermal Control micro-conference:
> >
> > https://lpc.events/event/16/contributions/1158/
> >
> > has been accepted for the LPC 2022, so if you have a topic for
> > discussion in that session, please submit it through the LPC web page:
> >
> > https://lpc.events/event/16/abstracts/
> >
> > (please choose Power Management and Thermal Control MC as the track).
> > Please also submit topics already listed in the MC description.
> >
> > Please note that the LPC is mostly about discussing work in progress
> > and development proposals, so make sure that your topic falls into
> > this category.  In particular, please avoid submitting topics
> > regarding work that has already been done.
> >
> > The LPC will be held in Dublin this year, but it should be possible to
> > participate in the sessions remotely, so it should be fine to submit a
> > topic even if you cannot go to Dublin in person.
> >
> > Looking forward to seeing you all at the LPC!
>
> The deadline for topic submissions is approaching (it appears to be June 15).

There are 5 topics submitted ATM, 4 from Intel and 1 from AMD.  ARM is
obviously underrepresented.
