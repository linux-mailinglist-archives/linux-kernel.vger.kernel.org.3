Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489DB569AA4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 08:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbiGGGmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 02:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiGGGmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 02:42:45 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD3A2A25D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 23:42:44 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id i7so30929256ybe.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 23:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ARyEMGb7Gnx1ypJRSOXqpnOMXk+sCah5U8o5NgEKH1k=;
        b=iE917FCok5mxNe/aLMhgBfhOys9PvD4Yb4s41S/7YjiGTqswIGTDw8aH4V7b/t00YC
         ktREKQDgcRDXcyi5hc/YAn+BkQn0zU06fzE3eCCKBvjQkq2x8I/TQXqtAgfYKQ9+hODj
         beamcGmWCjM+xCzAC4UR3hxz7i99sF7jtWvmBnYPJWUA4hdmebmQaozASUXDiJXCV923
         o9Bmf0D3xhdaJ1JGNqmuIGaI90P/tt3u2LV5xtGY4kXBgT/HeksRaUlonaDhypa9K6JB
         HoKFrQG/yTcu4abVuLVdTbPs65kBoyA7xOw2kkA4MyQ77QvKApVIkA9gym3kpU7Ra+xl
         1FiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ARyEMGb7Gnx1ypJRSOXqpnOMXk+sCah5U8o5NgEKH1k=;
        b=w7dqx2sAL9qTZ+WrpuQ8OIAcVnl/vL7ihUXh8lgIW5+6yfgeG90HlUzqEEa3h+Cy7F
         PalKw2Qxwa3PIMhYUraGbLiFA9wlEfjojI1Z8nVAVXXrMQwTGmdxCmEyR97RAwy4iR0o
         SwOZWP57+51riSwvVtJE/HUeHz+DGpsS3J6+W45Y4lYJh9Ty0pYOJWbMp8fGLIOYiQSV
         JSZOkKsIUers+4s9D6gUBTYASf2mSaa/24lYfX1rKQixf7WMrHM5AHBO4unFO1MkC4q7
         m+L2h3/beXHjHvWvKNfF83k1BvxixPy4Eoa5n0NuPfpid/Po0UgQB0w0Ux9e51NkZjNO
         wmGQ==
X-Gm-Message-State: AJIora+Yd2wt2cRQS+0LhyWuJVZz3JtQ37wjLrvelDvSUDrwx1fBWoqY
        rRXfXuMSXvBLOLBjWDSf8J6df9JPBaAdE+efkMe08A==
X-Google-Smtp-Source: AGRyM1tIPV6TJ2LPOCvsfP03cd5AzLoNkKLey0F6Ow1kxwN4IraGTOqnKESKrsnuLLMVHaQKfcWtxGYX2FbIbmpsVCE=
X-Received: by 2002:a25:9382:0:b0:66d:ae8e:19e8 with SMTP id
 a2-20020a259382000000b0066dae8e19e8mr41176715ybm.236.1657176163646; Wed, 06
 Jul 2022 23:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220702045254.22922-1-vincent.guittot@linaro.org> <e830e6eb-6606-74f1-c356-cb61c6f46e99@huawei.com>
In-Reply-To: <e830e6eb-6606-74f1-c356-cb61c6f46e99@huawei.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 7 Jul 2022 08:42:32 +0200
Message-ID: <CAKfTPtA1fARYDTapz3LL=-XOhJ5=TAj8YP0RP6ANit_67XhE0g@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: fix case with reduced capacity CPU
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, david.chen@nutanix.com
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

On Tue, 5 Jul 2022 at 10:23, Zhang Qiao <zhangqiao22@huawei.com> wrote:
>
>
>
> =E5=9C=A8 2022/7/2 12:52, Vincent Guittot =E5=86=99=E9=81=93:
> > The capacity of the CPU available for CFS tasks can be reduced because =
of
> > other activities running on the latter. In such case, it's worth trying=
 to
> > move CFS tasks on a CPU with more available capacity.
> >
> > The rework of the load balance has filterd the case when the CPU is
> > classified to be fully busy but its capacity is reduced.
> >
> > Check if CPU's capacity is reduced while gathering load balance statist=
ics
> > and classify it group_misfit_task instead of group_fully_busy so we can
> > try to move the load on another CPU.
> >
> > Reported-by: David Chen <david.chen@nutanix.com>
> > Reported-by: Zhang Qiao <zhangqiao22@huawei.com>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >
> > David, Zhang,
> >
> > I haven't put your tested-by because I have reworked and cleaned the pa=
tch to
> > cover more cases.
> >
> > Could you run some tests with this version ?
>
> I tested with this version, it is ok.
>
> Tested-by: Zhang Qiao <zhangqiao22@huawei.com>

Thanks

>
> Thanks
>
> >

> >
