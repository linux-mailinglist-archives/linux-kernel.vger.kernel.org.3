Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E38E58A77D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 09:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237419AbiHEHu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 03:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240091AbiHEHuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 03:50:22 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFA7CC7
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 00:50:18 -0700 (PDT)
Received: from mail-ej1-f48.google.com ([209.85.218.48]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N0WwO-1nWBor0HAa-00wX5x for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022
 09:50:17 +0200
Received: by mail-ej1-f48.google.com with SMTP id kb8so3624597ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 00:50:17 -0700 (PDT)
X-Gm-Message-State: ACgBeo3yfFMWpd/mjCIzO4tPwZVWqyPjgJsarziOPK6rC3YmTGCWijR4
        bYvORjAH8tASliNk1wSJXKk9gVVDxmloZmOMDm8=
X-Google-Smtp-Source: AA6agR5NJ8x3IJAZusVkE31jks/Araokv5ThDh3zMc25RyEnxEL/t/dhDrVkohlRlbX1uu8Dkus/WGGqaR2Rz5a5Svc=
X-Received: by 2002:a17:906:9b08:b0:730:5d3c:4b1b with SMTP id
 eo8-20020a1709069b0800b007305d3c4b1bmr4372456ejc.606.1659685816744; Fri, 05
 Aug 2022 00:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220802065325.39740-1-zhengqi.arch@bytedance.com> <5dbced25-7cef-7078-78a9-f47545e6a9fe@bytedance.com>
In-Reply-To: <5dbced25-7cef-7078-78a9-f47545e6a9fe@bytedance.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 5 Aug 2022 09:50:00 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1NmgTEiXDgYyXzAsBDj9cW5_Km=VRyrOX_Sr4dJ1aknw@mail.gmail.com>
Message-ID: <CAK8P3a1NmgTEiXDgYyXzAsBDj9cW5_Km=VRyrOX_Sr4dJ1aknw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: run softirqs on the per-CPU IRQ stack
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:LUFvCa+NkK5OFqRlBDrSQkNA1j9iavkAgAc37pCjSiddECGc+zj
 k55ZwHzP+tN5/IOSW3zpCh2SP5W5QxRyuSQUTpzxCmVtjZ1DyZMwqXcxWRKlOljFhSwdJNB
 19f9r13F1rg44iLpkmLv+b/gJRHnX1KYJEjIf4Gq0pd1qHjLh+r9kHwolb5zD7OeDpVv5VT
 FC9ZdVSpTjQMRKNa2f8TQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WjTqJiJzobg=:BJ6Kx9AT1ZE60r+IF5/Lkg
 Mn2Lxl4WIp9Fan2MB25xty1OQxU/rAUDquWnYfXZN39cki3pRIrTWvkL2WN69gTKThzlzRJXx
 DeD1N/35vzg2wkaOmvLkgg9mh77SXmuwIIK55da7RdZ2Fk9ncJx8jFaodhDRTcvhl7pFSifMk
 sEnvqdorpqcS3uEkuGTp8FEpN5LQl6PJOCIHsjd2nPLtXEz3uPQPeZ5qL6urYkrN+QFNfR/dj
 ZlaynlxQAFMpfJj878eXoMK/5xnWNglVRzcYb3PPKqkku0qzq6BiOlWcu+5W/babLJuEXUg/y
 zG7Z5ksy/5ZItWp/weNoV+2L929FVVSpPrGyyA/mSOG0Zf//XZywXnB3vdA8LbeKPItEBxk3z
 WRDWfBrCtSCfUA6Qm/K+oAbJPD3wAvIyEXlS8PUCvvp+M9Eue5A7wxVsAlwHUozd9pZcefIdl
 Sv9gdpqTwOR6eOVnbvBTYXG9nzePdLcPlkQDVBp7cCSvP2ZSLsrI0n7Jl7gb+f0iXaTXuU84l
 ODBOSLP8BU8ZgKaY+5DOMtXFZZ6c/YFyd/nl0w+SKp7FzQITVjW16oeFZX9Km6nlsSlJSgy+K
 4txpHoKRZ2FlfdL/sOLKMEhf65GiOPocNoRUUVdsaxgKK40KD+PRURCG38rUUhLw2kf5lKAS2
 G2Th+Kqvt0NJgpc8Sc4ZjFhdIPkjImW/kf/n6VqZk0Uiw1JqhsaD/jYtC5tmXEG1mhCbM/nCJ
 kjzkSbAelmuWrMikjDwpFDyYxjCgBgMvk75mYQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 5, 2022 at 9:10 AM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> On 2022/8/2 14:53, Qi Zheng wrote:
> > Currently arm64 supports per-CPU IRQ stack, but softirqs
> > are still handled in the task context.
> >
> > Since any call to local_bh_enable() at any level in the task's
> > call stack may trigger a softirq processing run, which could
> > potentially cause a task stack overflow if the combined stack
> > footprints exceed the stack's size, let's run these softirqs
> > on the IRQ stack as well.
> >
> > Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> > Acked-by: Will Deacon <will@kernel.org>
>
> Are we good to merge it into 6.0-rc1?

I think you misunderstood the timing that Will proposed in

https://lore.kernel.org/linux-arm-kernel/d540aaff-ec6a-3f25-dd79-b27b4ad81b36@bytedance.com/

You should send your patch after 6.0-rc1 has been released, to be merged
into the linux-next tree and sent as part of the 6.1 merge window.

The two ways patches get merged are:

- bugfixes can get merged into maintainer trees at any time and sent
  upstream regardless of the merge window, these never need to wait

- non-bugfix patches can get merged into maintainer trees based on an
   -rc release and then sent upstream during the following merge window.

        Arnd
