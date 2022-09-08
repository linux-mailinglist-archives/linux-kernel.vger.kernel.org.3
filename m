Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EF85B1529
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiIHGvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiIHGvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:51:36 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636773887;
        Wed,  7 Sep 2022 23:51:35 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-11eab59db71so41871030fac.11;
        Wed, 07 Sep 2022 23:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=nZhyFiVZ5FmrbCVH3yiFfyThQCmFYCChpsu7PErUvUk=;
        b=lWy18AVfC9mgtwSPqch+EKd2XTjoLOFtwelwrOSL/GZJwaVyr5KcfrNAZgLroHNkrU
         vTrueWx9317OF1LRT1a4EaVzulQAN1yBKMHvLbw09oWGyD1i3w+iicbBIRKwkB5qPhwp
         MkCnjE7nc6+M0TX+bI2On7eZB9WcAi2utbEEjJRz+0e073aTCYVG0HetWnXkk/4MEK8D
         vMvA76yaxH+jcGUCY+djNTwjnfnsdGwh8AYZs1Zv2Vh796uxf3NoabvCB2058ez/XPL4
         ymtMTtTyfM56Yjf3SH8q65dAd4D8e9Mx5Cgc49B3vt8+cGBy7jOf+paBc7FiyOQLFir3
         k7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=nZhyFiVZ5FmrbCVH3yiFfyThQCmFYCChpsu7PErUvUk=;
        b=Lkll/IXxK9l/Y32hDvt+g2NIpeHvQ6mOXA6WTPdUZgTPoDN0QwS52qmoBejZkVUqlV
         BrAv2Wv29nujZXNF9S4Q3mDj23+dDp2i0oTPci4YJPJfuz6kTd0pbUfNT9/vLQ+H3H4c
         ZLjmKy1NpvJYL494qDXFBRWSs+Rm+nlvZFEw10V2hGvfZBPYC7Vs/qfAVoYIXhrKului
         gGujMQxKrm4ro79IVfk6TyVnIlShmIF3pKREVVvlPeVNlObs0pMixFhs0IFcKTwyzWi2
         5Hup717Gz9ARTByreEmefjqk7NXMAsQU1D8T5luObO0elejuafs2lfJfMetqgdoewTOC
         2PLw==
X-Gm-Message-State: ACgBeo0A6AVGZSQF7BcwMcp7eQwrm3QglXOu607ze9nWE5i+6DtD6ext
        CEGZmGFutNpPoYGYPC9qsiExOJxjOQnAQWa6MhxzSWMUeAQ0wg==
X-Google-Smtp-Source: AA6agR4WYyumoB3bBlR7x1MAZJ6ZRBxi4dFfUksq/C+dxYntHY1I5leYEOMrhfoOVGXygUbS06bZQbdklwokgBOmahg=
X-Received: by 2002:a05:6870:4586:b0:10d:2ec7:be6 with SMTP id
 y6-20020a056870458600b0010d2ec70be6mr1134861oao.7.1662619894223; Wed, 07 Sep
 2022 23:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220907132205.28021-1-andrea.merello@iit.it> <1b30d814-3570-1cb7-573b-9bca90d5d3fd@gmail.com>
In-Reply-To: <1b30d814-3570-1cb7-573b-9bca90d5d3fd@gmail.com>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Thu, 8 Sep 2022 08:51:23 +0200
Message-ID: <CAN8YU5P1qjKtmSskA_+vLMnC6wHFmhk4ZvP+a-9KLr0OsY0FdA@mail.gmail.com>
Subject: Re: [v7 00/14] Add support for Bosch BNO055 IMU
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     andrea.merello@iit.it, jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        andy.shevchenko@gmail.com, matt.ranostay@konsulko.com,
        ardeleanalex@gmail.com, jacopo@jmondi.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il giorno gio 8 set 2022 alle ore 05:47 Bagas Sanjaya
<bagasdotme@gmail.com> ha scritto:
>
> On 9/7/22 20:21, andrea.merello@iit.it wrote:
> > Differences wrt v6:
> >
> > - fix some typos.
> > - fix some style issues.
> > - get rid of ifdefs for CONFIG_DEBUG_FS.
> > - avoid pushing data to the IIO layer if we actually failed reading it.
> > - rework debugfs file creating failure path.
> > - fix errors and warning found by kernel test robot <lkp@intel.com>
> > - rebase
>
> Rebased on what tree (and what commit)? I can't cleanly apply patch
> [05/14].

Sorry, it looks like I've raced against recent updates on iio-togreg
branch (i.e. I've rebased, then I've got preemped by something else,
then I've tested and sent the series some days later - I should have
rebased again).

BTW patches can be applied on the top of this
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=togreg&id=2bc9cd66eb25d0fefbb081421d6586495e25840e

I'll prepare a v8 anyway.

> Thanks.
>
> --
> An old man doll... just what I always wanted! - Clara
