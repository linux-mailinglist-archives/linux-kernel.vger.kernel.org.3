Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7615567F7F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 09:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbiGFHFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 03:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiGFHFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 03:05:23 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B019922536;
        Wed,  6 Jul 2022 00:05:20 -0700 (PDT)
Received: from mail-yw1-f174.google.com ([209.85.128.174]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MQMm9-1nvYz6481J-00MIfJ; Wed, 06 Jul 2022 09:05:18 +0200
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-31c86fe1dddso83275417b3.1;
        Wed, 06 Jul 2022 00:05:15 -0700 (PDT)
X-Gm-Message-State: AJIora/yyXFuxC0iH8udXG4GKzeQDfZVFj5/5/aXY+3OG8rcG8jffJLV
        2V+NVKVyV6CbxZT52ddqge0oe5EQDCQFt7Y66jU=
X-Google-Smtp-Source: AGRyM1sFkLoTiaaVIBkcDzO6lGV11chQSm3x6oRhEtv1xOtqIu5uDObFEe7OPQNG4jMZlSfDIkbGiGD4cv9otOB20XA=
X-Received: by 2002:a81:f8f:0:b0:31c:bd9f:31ce with SMTP id
 137-20020a810f8f000000b0031cbd9f31cemr10731679ywp.347.1657091114041; Wed, 06
 Jul 2022 00:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220630051630.1718927-1-anshuman.khandual@arm.com>
 <8a6ccbae-7d7c-6e08-cc28-eeb649f86112@arm.com> <85fff3f6-373f-3e6a-325e-0fa8ad46273a@csgroup.eu>
In-Reply-To: <85fff3f6-373f-3e6a-325e-0fa8ad46273a@csgroup.eu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 6 Jul 2022 09:04:56 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1gb1Xrg4AGnncFpN=aDxVKfjkt1TmSvZXXADZTv7eE-g@mail.gmail.com>
Message-ID: <CAK8P3a1gb1Xrg4AGnncFpN=aDxVKfjkt1TmSvZXXADZTv7eE-g@mail.gmail.com>
Subject: Re: [PATCH V6 00/26] mm/mmap: Drop __SXXX/__PXXX macros from across platforms
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:eoj/BCXKdmN3+Jtii2tnT9++PxDX3Qg7gtjTIvPC9UxI/6aBcxJ
 tTae1o1xAarRHKJSP3rYt1b1/eDeegzTy0D2zVasyMJuuUa+41stGutBBXc1JX0IWj+OuEm
 4ASghrYondSGEJVdD4r91TCAANQlj5byQGbFpEa9jhmxGwVvHYU/Vtoar9ZPDQqoHW43WeM
 R3ozEe+h4nV01gc2XgZ2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:prrS9+g5wIQ=:AH9lcMoXqt1xOcLbdnz0v3
 FlSve9D0sISO715668G4rmmOOym/lRAuFwSwKOrEgM87WsNd50hr6zzm6CkRQaWsQNRfb3JMD
 pcZW7ztueF93/tWxu/udv1r5lnePhIz3byRArXnmXPWihtuIM7AQ9Ky3KkRQOmYKT78as29UQ
 r0cGiEnz6bcQpvcqYSjK3TJdLhS7PpmL3x90cG6xm+NZ6gIxuJEClno37wYHSZUPbBMVs/C9A
 IOAAi+/oi7gWMWmtjHJarqw8Y+I2uYCh9CrF0dt8bUjvuK2QFTKEwKPEsaHgVWA42u9wlem+y
 4sIgHUzW0/TuymIwELBXL/ElFVOdfLORt8KL4MTwAICBILbSZS3XVWwMDkjgBf8D4QCI5c+R9
 00HOPOriisiG7YnK8L6mjd+xGcjfeCvzVC9XOhM+28BR7CteM5su05ac/6hzrpkJLyILrKNRs
 HvaTSN1FwRqUy9Kj+WI1P6jXqu8d2IBxZMLKsnAXha4VVlcdtrH2kDJLkchXUmu8Y/f31xGor
 TVUj0G1hyIitAC5nxF36puqdvyGzqw1EjycEk73/bwY8lkE1YYSQMhVTNIdROMV1pqvwgLPdl
 IaRqUJkq0ZbXME5jinzrOPR2K+0f/rNmGTOO72ZJ2xElw39Q0uqHGgmN6++BKG4JNqK9MlBbi
 DSfhIbUxaRzTzPoPxj2i8ePp+cVwJBWGqB9PqvGAd6DX6y27uTIL9evkQviyXz4YCMv3vnrFq
 lsDcsJpMxdcr5+T5dz0YqL8w/tJakl/IqUgEw6m0VYya+EPCL+0rI2VwcHBY2Xj2z72Kibici
 54Y/uROUkJKI0rqrBWN7XoacPQ1MfP1Mq5mgKzoRwHNbT+W58ZL9IU8OR3lzsTjY6dj34FUgG
 OKtnA6/3GxUCV6shdv1Q==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 6, 2022 at 8:33 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:

> As far as I can see in Kconfig, CONFIG_MMU is user selectable on the
> following architectures:
> - ARM
> - M68K
> - RISCV
> - SH
>
> And is disabled by default on XTENSA.

Right, the list is complete, though it's also default-enabled for
every CPU core on xtensa, and you can only disable it for
"custom" CPU cores.

        Arnd
