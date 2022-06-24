Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A877F5592BE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 08:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiFXGCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 02:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiFXGCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 02:02:51 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E83769270
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 23:02:50 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id e2so1982993edv.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 23:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+LB609c/jYmQtqojEPch2ria3pGib1paFUkDRzDn6ac=;
        b=I3bfm4XDkKJiTYM8lT+COphHeM4VHVojYTWh5p+4beMt3kfoXt+YHBeZJQeNt80HF5
         8Xk/cS1yGnBWeaf81Cc6elRO1ziuf7/GHURaz5se1841pydRMxIXtSQEqPJUPPWF4S5B
         3I4imrdorm/sWyCfPOtU8RPRYlvn94balDGiZYFuOqHXOHzeJ/HzfGPo5XgTb/2X2aD2
         nkHKe3Q5e0djZyqTmIj4k5qwIaHBMb1TyVmHHzWTxEsVtr2VCSPlgJWAlJ+DRVBgprDe
         KyIMi57snvs6H7uvYQCkLTF4+WGlzWEXu3APE57wqEfZ/dzaZ9VQQx/d9smbGiftYdm8
         KXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+LB609c/jYmQtqojEPch2ria3pGib1paFUkDRzDn6ac=;
        b=OqMyLSQF0Pj/Lb58s17cnE9gNR5QdkFu9cYD1ecjznlYKgt4M6S04dWwi/+S248fWH
         o9ua7Ieo41a9Zek8mZnRQO0upc3NMTo55Z/R6XshqwOFkSuqHjGAYcaAHLYYUmcWx0K7
         1fJAvwNPzvE48TCTaY61I6+qwHT/euP3EKYt0mJIPUn6D43urfq54GGem0VHZZHEbggu
         n5HFS5l6GFSE7+bmbfydamMpzT09uB00FBnUI9oAlQyV0BODt88u7HVBQzguRUnAlgGV
         RItvfwoT9JK9CWgmN5aPJdcGfrAO/S5xepypSrpspfiYZSB+sBjbu2Du0bqVqfjEY9L3
         MfMQ==
X-Gm-Message-State: AJIora8aGrFi7S3biELiI/f35lf5cT8Bg8aoEZc+yUDc5ESj4A3iPjpw
        NuMJ7SN//JqPcMB5o+P/Ly8oyc9IjJsC+/csW31MJYjwT7o=
X-Google-Smtp-Source: AGRyM1sPCL4IZeRy5438DyfeOwib7ruP6F5Y3Lx776mw47yo3g1XQs4GIkwpZVNZO1pkqc30d6UM7TmeZwclwK7MMM4=
X-Received: by 2002:a05:6402:354d:b0:435:93f9:fc0b with SMTP id
 f13-20020a056402354d00b0043593f9fc0bmr15474165edd.288.1656050568672; Thu, 23
 Jun 2022 23:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220601151441.9128-1-daniel.lezcano@linaro.org>
 <20220601151441.9128-3-daniel.lezcano@linaro.org> <be8395e3-98d7-7a8f-7153-c491b22d4463@arm.com>
 <cb35e356-bc90-2a67-6983-1a4c3a0ea62d@linaro.org> <eada018c-b857-7946-ae4b-2532e6866a45@arm.com>
 <CAHRSSEz9ExOgvByycztKYf1ncxCKeoy3uHuyQcnUC1r5nujc2w@mail.gmail.com> <0ca654c0-d7b4-b955-7e9b-542452659694@linaro.org>
In-Reply-To: <0ca654c0-d7b4-b955-7e9b-542452659694@linaro.org>
From:   Wei Wang <wvw@google.com>
Date:   Thu, 23 Jun 2022 23:02:37 -0700
Message-ID: <CAGXk5yqCNUpGpHkecVP8U=ys9NF6dJAMu6R0E+jpgvcSVFN+Ug@mail.gmail.com>
Subject: Re: [PATCH 3/3] thermal/sysfs: Remove cooling device sysfs statistics
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 3, 2022 at 4:04 AM Daniel Lezcano <daniel.lezcano@linaro.org> w=
rote:
>
>
> Hi Todd,
>
> [adding Wei]
>
> On 02/06/2022 21:02, Todd Kjos wrote:
> > On Thu, Jun 2, 2022 at 2:16 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> [ ... ]
>
> >> I see, it makes sense. Let's see if Todd and Android folks don't
> >> use this thermal sysfs stats, so we could remove them.
> >
> > Android HALs do use the thermal sysfs stats. debugfs isn't a viable
> > replacement since debugfs must not be mounted during normal operation.
>
> Thanks for your answer.
>
> I'm curious, what is the purpose of getting the statistics, especially
> the transitions stats from normal operation?
>
> There were some complains about systems having a high number of cooling
> devices with a lot of states. The state transitions are represented as a
> matrix and result in up to hundred of megabytes of memory wasted.
>
> Moreover, sysfs being limited a page size, the output is often truncated.
>
> As it is automatically enabled for GKI, this waste of memory which is
> not negligible for system with low memory can not be avoided.
>
> I went through the thermal HAL but did not find an usage of these
> statistics, do you have a pointer to the code using them ?
>
> Thanks
>
>    -- Daniel
>
>

Sorry for the late reply, trying to catch up on emails after sick
recovery. We use it for stats collection to understand thermal
residency, and it is not in the HAL code, we don't use the transition
table heavily though. Are some of the devices having too many cooling
devices? Can we have a config to enable stats for a given cooling
device?

Thanks!
-Wei

>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
