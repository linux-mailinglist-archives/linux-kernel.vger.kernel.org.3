Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4D3589926
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 10:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238944AbiHDIQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 04:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239470AbiHDIQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 04:16:45 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904506564F;
        Thu,  4 Aug 2022 01:16:36 -0700 (PDT)
Received: from mail-ej1-f49.google.com ([209.85.218.49]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M7s1M-1oNNuy3ele-004z2a; Thu, 04 Aug 2022 10:16:34 +0200
Received: by mail-ej1-f49.google.com with SMTP id gk3so23334911ejb.8;
        Thu, 04 Aug 2022 01:16:34 -0700 (PDT)
X-Gm-Message-State: ACgBeo2MJ/SGRoMGiPsa4MzvUq42cJCMCZ4KQSCcekc6hRMmxyk84ljm
        unrL0+SfRGP2b4I6pTU4Sz46udLxovaSNklJufA=
X-Google-Smtp-Source: AA6agR6Jg653+yBBOUyAYrjW3VBIXsaHZRBgf5YvZt1uhUezA9TFx1DbJkqof0fuLkHWcFEb9AVXoO4ROyCCP0sW+j0=
X-Received: by 2002:a17:907:7395:b0:730:b636:2c89 with SMTP id
 er21-20020a170907739500b00730b6362c89mr572107ejc.547.1659600994444; Thu, 04
 Aug 2022 01:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220706231536.2041855-5-heiko@sntech.de> <mhng-d90c67dc-ace1-4413-9010-f9f26c60d3da@palmer-ri-x1c9>
In-Reply-To: <mhng-d90c67dc-ace1-4413-9010-f9f26c60d3da@palmer-ri-x1c9>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 4 Aug 2022 10:16:18 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1kE0FAbeUoO-JwzHKPsDVyTT7GGCsLoow=V2zKdSr0_Q@mail.gmail.com>
Message-ID: <CAK8P3a1kE0FAbeUoO-JwzHKPsDVyTT7GGCsLoow=V2zKdSr0_Q@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] riscv: implement cache-management errata for
 T-Head SoCs
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Fu <wefu@redhat.com>, Guo Ren <guoren@kernel.org>,
        Christoph Muellner <cmuellner@linux.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        Samuel Holland <samuel@sholland.org>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Drew Fustini <drew@beagleboard.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:MpEaQL2z72TA8qDsmM+HfNA8MYZVzn5f99pf51FMQyKL/UmAWy3
 H3u8qUyz1rgyAhXYod/ulCVxBm7WYQXYS6k8i/EfAp4onbAynCFI0EDwhc9k+KhE0x3XkRC
 85znXWSkrxCZ6r9txHUU2lSX5z3ACjEmu6UgH4/KXiq4M/WQzGU54/XQWsYmpWbu5Y+On04
 sd+PPL1vymPEaLniMPjUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XC4b6I/2uvU=:hDYHUgDsPJYSVAZ2pVm6Zy
 50QgSwFrhTNBoR++Meg+QWkWZlwyOr8FSIQlnNaAgUF3uMve9oc4CQ2p7T3U08/rhKpnkDn1Q
 HGRBJUzkvG5UgdXipdAN2V8E3ERLh0WHbfcDHR/A/A+43wg0k05EHIGHARM9wNgFANnkqmGaO
 F//sBS28SLLYdAIcU8QlP10y65iw31lzotNyquk2aMKdL1CbFKgEtLsCPpS+0qzk7Oc6MRaNu
 8gC2sUS9nVU2imae/GdC55HYT/CWBLPLR4uZI7WeYP/F+L7FKKqJivS1hNARvRMPTcwTX3yG9
 RWY5eBalKnBldgzoSJ9Offb4j85w0dvZ1rjd7g8tDYTedD7v1oK1YG6e0WZNGHUzEg6bdmt/X
 1WkYMbH3UnCgf99FXGkTYeTLopEcYeEKoyUZe+ETwtXFlPG7ZQy9cww8PcTLmnFlnOAzkSI+H
 dbYOEThZ2GEEReTbu2az5TaK12hsUJX6eoabTW9fhM21DWuPGBa5dc/M0A1XkS00nNURGsN0l
 LbJSCgfD5RqVaFTHG5LsGz/AQleAnaXGoMfl0TV0VdWVDSKQ3hGKUmfOAf+j2BIqkK0+C+Zkj
 nyU6YByDygUJQoI684ub+OZvDqe2RvqAFgsJj4sEX2BvwU0ri6e2iErxY83FSy12iFPMMQTv9
 ZBtKfO9y//mkWICuJHMep5q5+nutIW9rYyJolTLvnWb88Xw6165Iy+ZgWamSlDC0NjLNJhekj
 my9zekznES6iW3aLsbXoWfdKkjPBCPpAowsGYPj1NGoOjgTo+gosognJjd8ZnAObbdM9ZPxG8
 yp3m3PWKL2CiSTp2lbrlvgOfVgLgS7ADaDLydtU+0S5/51sFbvM1tNlu6g+TMJYfV1/6yafjL
 r3QkF6H6g9AMHQcdgONQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 4, 2022 at 2:28 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:

> I know I said I really don't want the executable .long stuff for this,
> and IIRC that's a pretty common sentiment.  I'm not sure if I'm just fed
> up with all the craziness, but I'm kind of inclined to just merge this
> as-is -- at least that way we can get the hardware working.

There is usually not much choice here if you want to allow building
with older toolchains. You might want to add a comment for each one
of those to reference the (projected) binutils version that adds support
so it can be cleaned up after you raise the minimum toolchain
requirements, but that takes years.

        Arnd
