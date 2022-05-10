Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0D6521055
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238437AbiEJJM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238411AbiEJJMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:12:55 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0C12555B8;
        Tue, 10 May 2022 02:08:59 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id o11so13048058qtp.13;
        Tue, 10 May 2022 02:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=D8Qz/xvrsWKKpXL9RLp/nvSMlMtetnF+P9aicmm6cuo=;
        b=LXGst13RLeQoCnT/V5H/Yibwn3XE5hfpV+SYcB+jBsH2oKzLLpgX2juQOvjPJFtRdR
         wQtlW2PLGPabzn4MzarVdysE1DHIPC3bYOKsJYHeT2yIij7XndAMSXok1l3rQhjA9EKO
         SzPiiOK+kbhXSFFuf3d2qvOAkQhvMWW5nUe8IKBZex6cc/LRXg2nuaW3Ci8SyK1P4TfJ
         Yw1NXjz2DT8+FJD3ruvFEtWD83Bx/2EcAitvJnS7msvmhCagDsTOLYH+xiMpMXDvBK9+
         LJhApIdKp5eizrUXkWFKTngbgDeT7Bqc5V1bic11LialdJKJvB7mBg6+2j50eLAafcik
         vnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=D8Qz/xvrsWKKpXL9RLp/nvSMlMtetnF+P9aicmm6cuo=;
        b=Nq7+xFma/xcAfbpSPWKTzMqzKWOaTpB7e8laHDLdDSe+/oPmV2iQ5NCPxS5pcpsR5Z
         V/CPtuzbpPww6tZDthqZAVQVuolLGAcvjeHXMU37OTLug0Yxmzh0KgP3eaoIsbeEhbMn
         YcMdkW976i1ij9diVDS3YAu8/9h3hWGxvcOFFRW8TcK/AsS5dGBq+g5QXrzSaEbrSuZU
         FTzksgWyUg4hIKHQ82ey9cv66lP9O6PtfZ6bU3q6gpQyxRrn2xmwHqWbXJTDqIRQI7na
         W9cTcDwNBXIYoR8771uI8OUvFafjdkIAq2noM99VV0LQQViZ/BUBBHOCtmivP635P/IN
         zsqw==
X-Gm-Message-State: AOAM531CLkckdqgWVXyeZzdtJiPWupUZWn0WaIZGlDAdH175QlGNyS5m
        pv2pwjD9oNzs/XXSrK6EHY6mSAKrVvR3L9wIoGGTmfw3Snk=
X-Google-Smtp-Source: ABdhPJz3WyqGc1yRJ+ONjj33N+wEbfAaxiSWmGK8cUyyTFgyM2FuaQpxls2+tDG9GY10TJTPgS3GMDbRHgQ8oHdXaaA=
X-Received: by 2002:a05:622a:4d1:b0:2f3:d1c7:b31f with SMTP id
 q17-20020a05622a04d100b002f3d1c7b31fmr12895238qtx.163.1652173738572; Tue, 10
 May 2022 02:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220509120337.92472-1-cw00.choi@samsung.com> <CAGXv+5Fp0c23=4C8QG6AcDS9furMqJhfrUF1Hj0RyBHebvCy6w@mail.gmail.com>
In-Reply-To: <CAGXv+5Fp0c23=4C8QG6AcDS9furMqJhfrUF1Hj0RyBHebvCy6w@mail.gmail.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Tue, 10 May 2022 18:08:22 +0900
Message-ID: <CAGTfZH1yujq-aWUkJMf37e53Gf=tSn=9LExnQgKw=qAFnim2hA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] PM / devfreq: Add cpu based scaling support to
 passive governor
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        jia-wei.chang@mediatek.com, andrew-sh.cheng@mediatek.com,
        hsinyi@chromium.org, Saravana Kannan <saravanak@google.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen-Yu,

On Tue, May 10, 2022 at 6:00 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> On Mon, May 9, 2022 at 8:03 PM Chanwoo Choi <cwchoi00@gmail.com> wrote:
> >
> > The devfreq passive governor has already supported the devfreq parent device
> > for coupling the frequency change if some hardware have the constraints
> > such as power sharing and so on.
> >
> > Add cpu based scaling support to passive governor with required-opp property.
> > It uses the cpufreq notifier to catch the frequency change timing of cpufreq
> > and get the next frequency according to new cpu frequency by using required-opp
> > property. It is based on patch[1] and then just code clean-up by myself.
> >
> > Make the common code for both passive_devfreq and passive_cpufreq
> > parent type to remove the duplicate code.
> >
> > [1] [RFC,v2] PM / devfreq: Add cpu based scaling support to passive_governor
> > - https://lore.kernel.org/patchwork/patch/1101049/
> >
> > Changes from v2:
> > : https://patchwork.kernel.org/project/linux-pm/cover/20220507150145.531864-1-cw00.choi@samsung.com/
> > - Drop the following patch ("PM / devfreq: passive: Update frequency when start governor")
> > - Move p_data->this initialization into cpufreq_passive_regiser_notifier()
> >
> > Changes from v1:
> > : https://patchwork.kernel.org/project/linux-pm/cover/20210617060546.26933-1-cw00.choi@samsung.com/
> > - Rename cpu_data variable to parent_cpu_data to avoid build fail
> > - Use for_each_possible_cpu macro when register cpufreq transition notifier
> > - Add missing exception handling when cpufreq_passive_register_notifier is failed
> > - Keep cpufreq_policy for posible cpus instead of NR_CPU in order to avoid
> >   the memory waste when NR_CPU is too high.
> > - Add reviewed-by tag of Matthias Kaehlcke for patch1
> >
> >
> > Chanwoo Choi (3):
> >   PM / devfreq: Export devfreq_get_freq_range symbol within devfreq
> >   PM / devfreq: passive: Reduce duplicate code when passive_devfreq case
> >   PM / devfreq: passive: Keep cpufreq_policy for possible cpus
> >
> > Saravana Kannan (1):
> >   PM / devfreq: Add cpu based scaling support to passive governor
>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
>
> on next-20220509 in conjunction with the MediaTek cpufreq [1], CCI devfreq [2]
> & SVS [3] series, as well as some fix-ups [4]. AFAICT the CCI devfreq device
> is reacting and making frequency changes.
>
>
> Regards
> ChenYu
>
> [1] https://lore.kernel.org/all/20220422075239.16437-1-rex-bc.chen@mediatek.com/
> [2] https://lore.kernel.org/all/20220408052150.22536-1-johnson.wang@mediatek.com/
> [3] https://lore.kernel.org/all/20220420102044.10832-1-roger.lu@mediatek.com/
> [4] https://github.com/wens/linux/commits/mt8183-cpufreq-cci-svs-test

Thanks for your test.

-- 
Best Regards,
Chanwoo Choi
