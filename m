Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7766D4D4210
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 08:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240051AbiCJHzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 02:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbiCJHzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 02:55:38 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F5C5F93
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 23:54:36 -0800 (PST)
Received: from mail-wm1-f54.google.com ([209.85.128.54]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MD9Gh-1nJ6wV3OFt-00973Q for <linux-kernel@vger.kernel.org>; Thu, 10 Mar
 2022 08:54:34 +0100
Received: by mail-wm1-f54.google.com with SMTP id r65so2721646wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 23:54:34 -0800 (PST)
X-Gm-Message-State: AOAM533bEJL6IXZSyx2ARZWCByMgZ9I9GlGqQEDLUJ4mCjtfH5kVzUv0
        vVIXqzMoIdY5zJBoFB/PpB/l0aTr1R3lMBIMduM=
X-Google-Smtp-Source: ABdhPJw6lJK7oDWz/cNAeVzWeOPph+sSjK3afpc+MK4se73oxRJof+LBgbnocQ/Dt2GG0ZcchC+GX8WIOl1cD+k9HRE=
X-Received: by 2002:a05:600c:384a:b0:37c:2d14:a2d3 with SMTP id
 s10-20020a05600c384a00b0037c2d14a2d3mr2468122wmr.20.1646898874485; Wed, 09
 Mar 2022 23:54:34 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2Mr_z6h7eg1O8ZN5_qE-o+8KFFBum3CxyuDYeF50s1dw@mail.gmail.com>
 <mhng-1ed81282-b17a-43ef-9030-fc538d96892b@palmer-mbp2014>
In-Reply-To: <mhng-1ed81282-b17a-43ef-9030-fc538d96892b@palmer-mbp2014>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 10 Mar 2022 08:54:17 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3mzax-OiaxBcxM_RgKNsd6N8HW0odRmw38u2jKE5aYaQ@mail.gmail.com>
Message-ID: <CAK8P3a3mzax-OiaxBcxM_RgKNsd6N8HW0odRmw38u2jKE5aYaQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: Work to remove kernel dependence on the M-extension
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Michael T. Kloos" <michael@michaelkloos.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:EGx1efBcBh/A8oOM/qe2evQUV2FvjpV51SlloJaZTJHq9PM6X8G
 1RaWjEv2DseT1aXNfUYlLnI11Sd/AS/jVjIP+p+LEfVP4q99gqxsbUyOQ70Z7hDA7a80Q5A
 LUMy3V90bDPhq/HelI+Jcd+M6NM+bgD90QTCUy18RwjWuE+Frw66+Rumi/biyfduKjF81tq
 XkV5pX8YaAr+T3Lch2N9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nYOxPSgJKZA=:hNyXsoBVQAbq76/BIwtxws
 B9OVBcUjzCOEQfEsOMrtio9DjoBz0GOPkoqO5517pCaN75vpAcM6qDyfaBepEMhXzuZGzRW6p
 nU1sRaNnJyg7kv18c/Fn2vztCT+gRk19JS0kEzEijnLss/Rdsn1GT+Sdb/KzQhXOFxsLHWYwc
 m+a4IZzO9GnEAPGtCepcisNzMCPCc1wK2Okw6vTm3K+4TDCFjtnooGEGes3EZ9mAOk2/CX7h0
 Zpz01dfTsT1AIbf5NDE8dIxYugW4JXmC6gJ3/yRRwZVexXVidJBk5VL/Bl/CGS8xad6cQhY/s
 wBMguNnPGft305AEgY9BK3D338eOyXPxB2UgXoRDHV2zKGXQPmcsTaI46y763cGpY+TkNKhca
 jlVru6x9ARJGxSMgrvEY8cTeku2Ue56NHhgBr6th4QBWVlAL0dzy9lJYhhMNS5djpqSbh9+JP
 vv3KVxxZ7gcsUvkEwVQa7EM+iaf1XyAEoq0B4upHySG9YTaZy5NH9vI/KN7zEBLS8HHL86RkD
 o3K/OE2TP0r7ARUQJm7wiGc9vew67IHrW8lJ7XnFE0HtUaeEc8qz4sFKOaOqbojtohoAx/kZy
 OZHexYr5+9uYdE0n7hey1yTF3Ft4J2bxWOXN0n1YI/twVELpsezlyIEZi8VvtrvU7CX0z/fGW
 VHcaSnUj7WqElgDhKgMIytkOchrkyjTxqkDhJgyDxUZ9Ioobwt83J6+ULPMz8o7+Yoa4tz74s
 TsgOcVemG6XpJwNdht4GAYcC0JzgARj4BX1tdtyGdGIMiZks7dWq5oWbngnBHJGmgRh0RbN7H
 +h1tKdfrE8mXaq/7qheGjl6u/1oijWaa4N5yomK9eYYPXIL5OQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 8:34 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> On Wed, 09 Mar 2022 02:02:27 PST (-0800), Arnd Bergmann wrote:
> > On Wed, Mar 9, 2022 at 6:28 AM Michael T. Kloos <michael@michaelkloos.com> wrote:
>
> That'd be wonderful, but unfortunately we're trending the other way --
> we're at the point where "words in the specification have meaning" is
> controversial, so trying to talk about which flavors of the
> specification are standard is just meaningless.  I obviously hope that
> gets sorted out, as we've clearly been pointed straight off a cliff for
> a while now, but LMKL isn't the place to have that discussion.  We've
> all seen this before, nobody needs to be convinced this leads to a mess.
>
> Until we get to the point where "I wrote 'RISC-V' on that potato I found
> in my couch" can be conclusively determined not compliant with the spec,
> it's just silly to try and talk about what is.

I would argue that codifying the required extensions through kernel source
code is much stronger than interpreting a specification. Ideally the
specification
would match what the kernel requires, but it's not the end of the world if
the kernel ends up making decisions that are different: If Linux can do
runtime detection of non-M, non-A or pre-standard extensions and handle
them correctly without a notable performance impact, it can do that. Or
Linux could end up requiring things that are normally there but not
in the scope of the spec.

Regardless of who determines what the compatible subset is, I think there
is value in splitting out Kconfig options that prevent booting on normal
RV64GC machines (XIP, NOMMU, 32-bit, ...). This would probably
not include the non-M option, as long as a non-M kernel works as
expected on CPUs with the M instructions.

        Arnd
