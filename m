Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE5553BC4F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 18:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbiFBQSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 12:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiFBQS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 12:18:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F49966AE2;
        Thu,  2 Jun 2022 09:18:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16113B81F1B;
        Thu,  2 Jun 2022 16:18:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50ACC385A5;
        Thu,  2 Jun 2022 16:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654186702;
        bh=7V0y/ZW966JADd4R8xjyTkPmLwvVxuyoXRlhbmeyn0g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CL2qs9DX6AOYlVKAq5RD4aLfaxjM7lqNolI5z6e241jviXa7XvHU4hMepnOIh5Obz
         wVOdZ3hoKsTaJDjWOEErtQf4UerwJRQXLXdraRAejbZzzxc4uRj+CYJa3nu6RVXT26
         Zf5T4VkHz5HqQFxRFxTD37VFPgdPfmbn0Q15eEnaZPH1uT055zV+ZdQ6eRukMW4qG+
         3J6e7Sslkz3GM+p/qdhVeoshIlqxSUVyyMtDaSNtV/IAlrWuj6Wxbtm90O3tRYfNBu
         y/xcmOOLkxysY1guP2FHutrQGovN4NOKM+Tc9DEeNk4MEjN47tc+smx+IJe4BRbTTQ
         YatyQEcxtqi4w==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2ef5380669cso56428297b3.9;
        Thu, 02 Jun 2022 09:18:22 -0700 (PDT)
X-Gm-Message-State: AOAM530o7risNguj2/061d+vRW2NF5rpKM4f0HbR8gCJ1bZ41lxjBhu0
        vrLsAMcnUIhMeO7g3nykZnZhEC0ZZ5bCfd+Kb28=
X-Google-Smtp-Source: ABdhPJxovnL02BvPqYSXWr4MroPObCPVq7tSHLA99lR6suneLeJ+y7EomaATc3KSXJD7rrDjUZc2w5C3D51O8XUJeTI=
X-Received: by 2002:a0d:fc83:0:b0:2e5:b0f4:c125 with SMTP id
 m125-20020a0dfc83000000b002e5b0f4c125mr6542276ywf.347.1654186701949; Thu, 02
 Jun 2022 09:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a1mkHEjRJgJPsRy+kuN=48=JEDJAeR2z9n+O71qbJ8hSA@mail.gmail.com>
 <6caf53e059758234ee12a236f967412f1df1f8a0.camel@linux.intel.com>
In-Reply-To: <6caf53e059758234ee12a236f967412f1df1f8a0.camel@linux.intel.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 2 Jun 2022 18:18:05 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1mHe3TkZa443fzsPnGUP1XT3w-DN3U5KAL6NBhc2nEsw@mail.gmail.com>
Message-ID: <CAK8P3a1mHe3TkZa443fzsPnGUP1XT3w-DN3U5KAL6NBhc2nEsw@mail.gmail.com>
Subject: Re: x86/mce/therm_throt incorrect THERM_STATUS_CLEAR_CORE_MASK?
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Len Brown <len.brown@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 2, 2022 at 5:52 PM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Thu, 2022-06-02 at 11:19 +0200, Arnd Bergmann wrote:
> > I have a Xeon W-2265 (family 6, model 85, stepping 7) that started
> > constantly spewing messages from the therm_throt driver after one
> > core overheated:
> >
> I think this is a Cascade Lake system. Have you tried the latest micro-
> code?

Thanks for your quick reply. I have installed the latest microcode 0x5003302
now (manually, because the version provided by the distro was still using
version 0x5003102).

After that, I tried writing the value 0x2a80 from userspace, and
that did not cause a trap, so I assume that fixed it.

It's hard to be sure, as the system has only run into the broken
state twice during its life, and now it's fine. I'll reply here if it
ever comes back with the new microcode.

Thanks a lot!

       Arnd
