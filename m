Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710CF53CA03
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 14:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244356AbiFCM3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 08:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiFCM33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 08:29:29 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A8B3A5DD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 05:29:27 -0700 (PDT)
Received: from mail-yw1-f180.google.com ([209.85.128.180]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M42X0-1nx6Qf2hgu-0005id for <linux-kernel@vger.kernel.org>; Fri, 03 Jun
 2022 14:29:25 +0200
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2ff7b90e635so80594497b3.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 05:29:25 -0700 (PDT)
X-Gm-Message-State: AOAM531GB12Cxt/zhpR9+9ZukxdDl20OAVd5I521w5Uc/htBRaiJe5hp
        mpgXSspAxMYsdWS4zVs0/fVvnBGxQagr+cLakLs=
X-Google-Smtp-Source: ABdhPJwPRDHayXMhzKVvfOBzB4bKOA9yDoqELtkL+X1dv1bUQP2eZEA4w7q/Ibq+/NpLoDg5jCofQwQ1d19kE6KBYqE=
X-Received: by 2002:a81:b03:0:b0:310:1375:fca9 with SMTP id
 3-20020a810b03000000b003101375fca9mr3711947ywl.135.1654259364450; Fri, 03 Jun
 2022 05:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220603121543.22884-1-linmq006@gmail.com>
In-Reply-To: <20220603121543.22884-1-linmq006@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 3 Jun 2022 14:29:07 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1ayYJ4P8UKndaSUBH=5i6CBMeeerpz-GyHESgbteuSyg@mail.gmail.com>
Message-ID: <CAK8P3a1ayYJ4P8UKndaSUBH=5i6CBMeeerpz-GyHESgbteuSyg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/spufs: Fix refcount leak in spufs_init_isolated_loader
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:11JGH4/yWoAlqHenoTIAbnwXfg94/NQPtaPz+P5XvC1cC7CqgRz
 eNG4zwjhQUOOoP42jyS4C/x4zqFoFcqbLB/WakY7Wqca7Ttf1/0OGs8sYHrbfBc0TcY8FSw
 /Pp5YjjcUQdGwLsK3KZUZyB/ynpqjZGV7MnjZhlrsdMev33xrYntIvs7djxZkEvU7mEduQZ
 K3XyStu78DgSgGUGwJluQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:s9divb7K6iU=:W0SAxVrpuuQR7CbQwgI8Ay
 jNmoYz3ScSyrrjq2RICKdv+umRQoeszPQn/+wRtmEC93uH3k8oCi8IprVNxNUj/J8usbj+e/m
 isKw5AT139TuGKApKA6Ee0RI6JP4BpTCHgWp/mQocmCGCYDCjc6DiBRGPjFbIwCfmybBZRQN1
 OLhsMISql5JXcEWQbuvWGT+GNXBeej8uN47rDYk0vWp9nQiHIqbEwlsX6MA1KZIR0awsd2w4l
 E4HalFnDKDG7lfEFq4e9bCCJPRY3IR6kDUwT86dTwlCJocFy9pTd+uZOsbNkc925P/WZuCgg5
 Yc02Du3OrGsGJPdaQz6JT8nGvhDbOYm7REv0WuY4S13i/TKKNhg3fKlZaautxfnLdKCXa3eh3
 ydwmsmNdPXpGwN8Gl9AQD2CPgzh2VR/PVZV5DA01sMJgNN7TceUGUPhIYm/HNXAxGb+cB+g5I
 j1dbl+057Ge+MTn6+kQz3ZlNbbYtA1+IwXsgFJQtGV6dxagG2XwEGFV05PXep+tbKBj+6Banv
 XrzpLERhF0nkZARwMjzzyG0J6HmETc8+tRkENmY8KvV38Yz9EiGB3XKE8mbhECT0RVfwpD7gs
 8yvF8kegwpjI/ce1Ap3qcY16tCT57z9l4TmFJO8SBXtPFDGNAiYJ2K7RSkGnDZrjnvuXQ/IBL
 RFgnvGOr0hv3LaAvrX3odkzcVeixwkRmUDkacm2olGqlezhtBoXSGaIj3ehiY3Xln8GUuglMC
 IyEV/U5TzEVedrG6ijn+OjykzcrtbgC7r4dhgw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 3, 2022 at 2:15 PM Miaoqian Lin <linmq006@gmail.com> wrote:
>
> of_find_node_by_path() returns remote device nodepointer with
> refcount incremented, we should use of_node_put() on it when done.
> Add missing of_node_put() to avoid refcount leak.
>
> Fixes: 0afacde3df4c ("[POWERPC] spufs: allow isolated mode apps by starting the SPE loader")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>


Acked-by: Arnd Bergmann <arnd@arndb.de>
