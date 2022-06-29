Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22F355F253
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 02:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiF2AXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 20:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiF2AXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 20:23:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DB41AF39;
        Tue, 28 Jun 2022 17:23:26 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LXhyN1FFhz4xD9;
        Wed, 29 Jun 2022 10:23:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1656462204;
        bh=sCA8sdGdi8D7HK/qLBQbMyrc5P/ekYEHXdkbiKXKcIg=;
        h=Date:From:To:Cc:Subject:From;
        b=eX7Rzs+w/JnqPWtnZutim4URBsD/y3wGBWCsFmb3pxU2RDhvaj28MY5CXodSzm4Sh
         r/c/K6O2fcQFBMZAB444PVI+ydGJ3Tlbrc2cFs9IaRHUHwW2DERjCn5J0KOMcHxyAN
         oukMvD3PyM3817E55qWxs27U0cnEhRPU2vWtq31un6IozNdITwVP0SOBnb+Noy8gX8
         zMvkOqH95AG9etvyPgTzvhr/nZzLuNJ0SgbPhk9zSgQhZipiyXYRifxB3u5is0O4N+
         7TOjV77oLw9+y+L9w8QWy/3ufHnasc2iOz1Jt2jJIl+Iynq32JsKyLUxpSkSYCqqt6
         9MIPdqGs6xQww==
Date:   Wed, 29 Jun 2022 10:23:04 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the pm tree
Message-ID: <20220629102304.6d924362@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LbU_JmBcLFP5PSw8U38wYDV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LbU_JmBcLFP5PSw8U38wYDV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pm tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

In file included from include/linux/list.h:5,
                 from include/linux/kobject.h:19,
                 from include/linux/of.h:17,
                 from include/linux/irqdomain.h:35,
                 from include/linux/acpi.h:13,
                 from drivers/bus/hisi_lpc.c:9:
drivers/bus/hisi_lpc.c: In function 'hisi_lpc_acpi_remove':
drivers/bus/hisi_lpc.c:488:41: error: 'struct acpi_device' has no member na=
med 'children'
  488 |         list_for_each_entry(child, &adev->children, node)
      |                                         ^~
include/linux/container_of.h:18:33: note: in definition of macro 'container=
_of'
   18 |         void *__mptr =3D (void *)(ptr);                            =
       \
      |                                 ^~~
include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
  531 |         list_entry((ptr)->next, type, member)
      |         ^~~~~~~~~~
include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'
  674 |         for (pos =3D list_first_entry(head, typeof(*pos), member); =
       \
      |                    ^~~~~~~~~~~~~~~~
drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_en=
try'
  488 |         list_for_each_entry(child, &adev->children, node)
      |         ^~~~~~~~~~~~~~~~~~~
In file included from include/linux/bits.h:22,
                 from include/linux/ioport.h:13,
                 from include/linux/acpi.h:12,
                 from drivers/bus/hisi_lpc.c:9:
drivers/bus/hisi_lpc.c:488:41: error: 'struct acpi_device' has no member na=
med 'children'
  488 |         list_for_each_entry(child, &adev->children, node)
      |                                         ^~
include/linux/build_bug.h:78:56: note: in definition of macro '__static_ass=
ert'
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
include/linux/container_of.h:19:9: note: in expansion of macro 'static_asse=
rt'
   19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||  =
     \
      |         ^~~~~~~~~~~~~
include/linux/container_of.h:19:23: note: in expansion of macro '__same_typ=
e'
   19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||  =
     \
      |                       ^~~~~~~~~~~
include/linux/list.h:520:9: note: in expansion of macro 'container_of'
  520 |         container_of(ptr, type, member)
      |         ^~~~~~~~~~~~
include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
  531 |         list_entry((ptr)->next, type, member)
      |         ^~~~~~~~~~
include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'
  674 |         for (pos =3D list_first_entry(head, typeof(*pos), member); =
       \
      |                    ^~~~~~~~~~~~~~~~
drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_en=
try'
  488 |         list_for_each_entry(child, &adev->children, node)
      |         ^~~~~~~~~~~~~~~~~~~
drivers/bus/hisi_lpc.c:488:53: error: 'struct acpi_device' has no member na=
med 'node'; did you mean 'fwnode'?
  488 |         list_for_each_entry(child, &adev->children, node)
      |                                                     ^~~~
include/linux/build_bug.h:78:56: note: in definition of macro '__static_ass=
ert'
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
include/linux/container_of.h:19:9: note: in expansion of macro 'static_asse=
rt'
   19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||  =
     \
      |         ^~~~~~~~~~~~~
include/linux/container_of.h:19:23: note: in expansion of macro '__same_typ=
e'
   19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||  =
     \
      |                       ^~~~~~~~~~~
include/linux/list.h:520:9: note: in expansion of macro 'container_of'
  520 |         container_of(ptr, type, member)
      |         ^~~~~~~~~~~~
include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
  531 |         list_entry((ptr)->next, type, member)
      |         ^~~~~~~~~~
include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'
  674 |         for (pos =3D list_first_entry(head, typeof(*pos), member); =
       \
      |                    ^~~~~~~~~~~~~~~~
drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_en=
try'
  488 |         list_for_each_entry(child, &adev->children, node)
      |         ^~~~~~~~~~~~~~~~~~~
drivers/bus/hisi_lpc.c:488:41: error: 'struct acpi_device' has no member na=
med 'children'
  488 |         list_for_each_entry(child, &adev->children, node)
      |                                         ^~
include/linux/build_bug.h:78:56: note: in definition of macro '__static_ass=
ert'
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
include/linux/container_of.h:19:9: note: in expansion of macro 'static_asse=
rt'
   19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||  =
     \
      |         ^~~~~~~~~~~~~
include/linux/container_of.h:20:23: note: in expansion of macro '__same_typ=
e'
   20 |                       __same_type(*(ptr), void),                   =
     \
      |                       ^~~~~~~~~~~
include/linux/list.h:520:9: note: in expansion of macro 'container_of'
  520 |         container_of(ptr, type, member)
      |         ^~~~~~~~~~~~
include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
  531 |         list_entry((ptr)->next, type, member)
      |         ^~~~~~~~~~
include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'
  674 |         for (pos =3D list_first_entry(head, typeof(*pos), member); =
       \
      |                    ^~~~~~~~~~~~~~~~
drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_en=
try'
  488 |         list_for_each_entry(child, &adev->children, node)
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/compiler_types.h:293:27: error: expression in static assertio=
n is not an integer
  293 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), t=
ypeof(b))
      |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:78:56: note: in definition of macro '__static_ass=
ert'
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
include/linux/container_of.h:19:9: note: in expansion of macro 'static_asse=
rt'
   19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||  =
     \
      |         ^~~~~~~~~~~~~
include/linux/container_of.h:19:23: note: in expansion of macro '__same_typ=
e'
   19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||  =
     \
      |                       ^~~~~~~~~~~
include/linux/list.h:520:9: note: in expansion of macro 'container_of'
  520 |         container_of(ptr, type, member)
      |         ^~~~~~~~~~~~
include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
  531 |         list_entry((ptr)->next, type, member)
      |         ^~~~~~~~~~
include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'
  674 |         for (pos =3D list_first_entry(head, typeof(*pos), member); =
       \
      |                    ^~~~~~~~~~~~~~~~
drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_en=
try'
  488 |         list_for_each_entry(child, &adev->children, node)
      |         ^~~~~~~~~~~~~~~~~~~
In file included from include/uapi/linux/posix_types.h:5,
                 from include/uapi/linux/types.h:14,
                 from include/linux/types.h:6,
                 from include/linux/kasan-checks.h:5,
                 from include/asm-generic/rwonce.h:26,
                 from ./arch/x86/include/generated/asm/rwonce.h:1,
                 from include/linux/compiler.h:248,
                 from include/linux/build_bug.h:5,
                 from include/linux/bits.h:22,
                 from include/linux/ioport.h:13,
                 from include/linux/acpi.h:12,
                 from drivers/bus/hisi_lpc.c:9:
drivers/bus/hisi_lpc.c:488:53: error: 'struct acpi_device' has no member na=
med 'node'; did you mean 'fwnode'?
  488 |         list_for_each_entry(child, &adev->children, node)
      |                                                     ^~~~
include/linux/stddef.h:16:58: note: in definition of macro 'offsetof'
   16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
      |                                                          ^~~~~~
include/linux/list.h:520:9: note: in expansion of macro 'container_of'
  520 |         container_of(ptr, type, member)
      |         ^~~~~~~~~~~~
include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
  531 |         list_entry((ptr)->next, type, member)
      |         ^~~~~~~~~~
include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'
  674 |         for (pos =3D list_first_entry(head, typeof(*pos), member); =
       \
      |                    ^~~~~~~~~~~~~~~~
drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_en=
try'
  488 |         list_for_each_entry(child, &adev->children, node)
      |         ^~~~~~~~~~~~~~~~~~~
In file included from include/linux/kobject.h:19,
                 from include/linux/of.h:17,
                 from include/linux/irqdomain.h:35,
                 from include/linux/acpi.h:13,
                 from drivers/bus/hisi_lpc.c:9:
drivers/bus/hisi_lpc.c:488:53: error: 'struct acpi_device' has no member na=
med 'node'; did you mean 'fwnode'?
  488 |         list_for_each_entry(child, &adev->children, node)
      |                                                     ^~~~
include/linux/list.h:665:16: note: in definition of macro 'list_entry_is_he=
ad'
  665 |         (&pos->member =3D=3D (head))
      |                ^~~~~~
drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_en=
try'
  488 |         list_for_each_entry(child, &adev->children, node)
      |         ^~~~~~~~~~~~~~~~~~~
drivers/bus/hisi_lpc.c:488:41: error: 'struct acpi_device' has no member na=
med 'children'
  488 |         list_for_each_entry(child, &adev->children, node)
      |                                         ^~
include/linux/list.h:665:27: note: in definition of macro 'list_entry_is_he=
ad'
  665 |         (&pos->member =3D=3D (head))
      |                           ^~~~
drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_en=
try'
  488 |         list_for_each_entry(child, &adev->children, node)
      |         ^~~~~~~~~~~~~~~~~~~
In file included from include/linux/list.h:5,
                 from include/linux/kobject.h:19,
                 from include/linux/of.h:17,
                 from include/linux/irqdomain.h:35,
                 from include/linux/acpi.h:13,
                 from drivers/bus/hisi_lpc.c:9:
drivers/bus/hisi_lpc.c:488:53: error: 'struct acpi_device' has no member na=
med 'node'; did you mean 'fwnode'?
  488 |         list_for_each_entry(child, &adev->children, node)
      |                                                     ^~~~
include/linux/container_of.h:18:33: note: in definition of macro 'container=
_of'
   18 |         void *__mptr =3D (void *)(ptr);                            =
       \
      |                                 ^~~
include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
  564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
      |         ^~~~~~~~~~
include/linux/list.h:676:20: note: in expansion of macro 'list_next_entry'
  676 |              pos =3D list_next_entry(pos, member))
      |                    ^~~~~~~~~~~~~~~
drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_en=
try'
  488 |         list_for_each_entry(child, &adev->children, node)
      |         ^~~~~~~~~~~~~~~~~~~
In file included from include/linux/bits.h:22,
                 from include/linux/ioport.h:13,
                 from include/linux/acpi.h:12,
                 from drivers/bus/hisi_lpc.c:9:
drivers/bus/hisi_lpc.c:488:53: error: 'struct acpi_device' has no member na=
med 'node'; did you mean 'fwnode'?
  488 |         list_for_each_entry(child, &adev->children, node)
      |                                                     ^~~~
include/linux/build_bug.h:78:56: note: in definition of macro '__static_ass=
ert'
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
include/linux/container_of.h:19:9: note: in expansion of macro 'static_asse=
rt'
   19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||  =
     \
      |         ^~~~~~~~~~~~~
include/linux/container_of.h:19:23: note: in expansion of macro '__same_typ=
e'
   19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||  =
     \
      |                       ^~~~~~~~~~~
include/linux/list.h:520:9: note: in expansion of macro 'container_of'
  520 |         container_of(ptr, type, member)
      |         ^~~~~~~~~~~~
include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
  564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
      |         ^~~~~~~~~~
include/linux/list.h:676:20: note: in expansion of macro 'list_next_entry'
  676 |              pos =3D list_next_entry(pos, member))
      |                    ^~~~~~~~~~~~~~~
drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_en=
try'
  488 |         list_for_each_entry(child, &adev->children, node)
      |         ^~~~~~~~~~~~~~~~~~~
drivers/bus/hisi_lpc.c:488:53: error: 'struct acpi_device' has no member na=
med 'node'; did you mean 'fwnode'?
  488 |         list_for_each_entry(child, &adev->children, node)
      |                                                     ^~~~
include/linux/build_bug.h:78:56: note: in definition of macro '__static_ass=
ert'
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
include/linux/container_of.h:19:9: note: in expansion of macro 'static_asse=
rt'
   19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||  =
     \
      |         ^~~~~~~~~~~~~
include/linux/container_of.h:19:23: note: in expansion of macro '__same_typ=
e'
   19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||  =
     \
      |                       ^~~~~~~~~~~
include/linux/list.h:520:9: note: in expansion of macro 'container_of'
  520 |         container_of(ptr, type, member)
      |         ^~~~~~~~~~~~
include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
  564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
      |         ^~~~~~~~~~
include/linux/list.h:676:20: note: in expansion of macro 'list_next_entry'
  676 |              pos =3D list_next_entry(pos, member))
      |                    ^~~~~~~~~~~~~~~
drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_en=
try'
  488 |         list_for_each_entry(child, &adev->children, node)
      |         ^~~~~~~~~~~~~~~~~~~
drivers/bus/hisi_lpc.c:488:53: error: 'struct acpi_device' has no member na=
med 'node'; did you mean 'fwnode'?
  488 |         list_for_each_entry(child, &adev->children, node)
      |                                                     ^~~~
include/linux/build_bug.h:78:56: note: in definition of macro '__static_ass=
ert'
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
include/linux/container_of.h:19:9: note: in expansion of macro 'static_asse=
rt'
   19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||  =
     \
      |         ^~~~~~~~~~~~~
include/linux/container_of.h:20:23: note: in expansion of macro '__same_typ=
e'
   20 |                       __same_type(*(ptr), void),                   =
     \
      |                       ^~~~~~~~~~~
include/linux/list.h:520:9: note: in expansion of macro 'container_of'
  520 |         container_of(ptr, type, member)
      |         ^~~~~~~~~~~~
include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
  564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
      |         ^~~~~~~~~~
include/linux/list.h:676:20: note: in expansion of macro 'list_next_entry'
  676 |              pos =3D list_next_entry(pos, member))
      |                    ^~~~~~~~~~~~~~~
drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_en=
try'
  488 |         list_for_each_entry(child, &adev->children, node)
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/compiler_types.h:293:27: error: expression in static assertio=
n is not an integer
  293 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), t=
ypeof(b))
      |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:78:56: note: in definition of macro '__static_ass=
ert'
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
include/linux/container_of.h:19:9: note: in expansion of macro 'static_asse=
rt'
   19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||  =
     \
      |         ^~~~~~~~~~~~~
include/linux/container_of.h:19:23: note: in expansion of macro '__same_typ=
e'
   19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||  =
     \
      |                       ^~~~~~~~~~~
include/linux/list.h:520:9: note: in expansion of macro 'container_of'
  520 |         container_of(ptr, type, member)
      |         ^~~~~~~~~~~~
include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
  564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
      |         ^~~~~~~~~~
include/linux/list.h:676:20: note: in expansion of macro 'list_next_entry'
  676 |              pos =3D list_next_entry(pos, member))
      |                    ^~~~~~~~~~~~~~~
drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_en=
try'
  488 |         list_for_each_entry(child, &adev->children, node)
      |         ^~~~~~~~~~~~~~~~~~~
In file included from include/uapi/linux/posix_types.h:5,
                 from include/uapi/linux/types.h:14,
                 from include/linux/types.h:6,
                 from include/linux/kasan-checks.h:5,
                 from include/asm-generic/rwonce.h:26,
                 from ./arch/x86/include/generated/asm/rwonce.h:1,
                 from include/linux/compiler.h:248,
                 from include/linux/build_bug.h:5,
                 from include/linux/bits.h:22,
                 from include/linux/ioport.h:13,
                 from include/linux/acpi.h:12,
                 from drivers/bus/hisi_lpc.c:9:
drivers/bus/hisi_lpc.c:488:53: error: 'struct acpi_device' has no member na=
med 'node'; did you mean 'fwnode'?
  488 |         list_for_each_entry(child, &adev->children, node)
      |                                                     ^~~~
include/linux/stddef.h:16:58: note: in definition of macro 'offsetof'
   16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
      |                                                          ^~~~~~
include/linux/list.h:520:9: note: in expansion of macro 'container_of'
  520 |         container_of(ptr, type, member)
      |         ^~~~~~~~~~~~
include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
  564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
      |         ^~~~~~~~~~
include/linux/list.h:676:20: note: in expansion of macro 'list_next_entry'
  676 |              pos =3D list_next_entry(pos, member))
      |                    ^~~~~~~~~~~~~~~
drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_en=
try'
  488 |         list_for_each_entry(child, &adev->children, node)
      |         ^~~~~~~~~~~~~~~~~~~
In file included from include/linux/list.h:5,
                 from include/linux/kobject.h:19,
                 from include/linux/of.h:17,
                 from include/linux/irqdomain.h:35,
                 from include/linux/acpi.h:13,
                 from drivers/bus/hisi_lpc.c:9:
drivers/bus/hisi_lpc.c: In function 'hisi_lpc_acpi_probe':
drivers/bus/hisi_lpc.c:509:41: error: 'struct acpi_device' has no member na=
med 'children'
  509 |         list_for_each_entry(child, &adev->children, node) {
      |                                         ^~
include/linux/container_of.h:18:33: note: in definition of macro 'container=
_of'
   18 |         void *__mptr =3D (void *)(ptr);                            =
       \
      |                                 ^~~
include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
  531 |         list_entry((ptr)->next, type, member)
      |         ^~~~~~~~~~
include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'
  674 |         for (pos =3D list_first_entry(head, typeof(*pos), member); =
       \
      |                    ^~~~~~~~~~~~~~~~
drivers/bus/hisi_lpc.c:509:9: note: in expansion of macro 'list_for_each_en=
try'
  509 |         list_for_each_entry(child, &adev->children, node) {
      |         ^~~~~~~~~~~~~~~~~~~
In file included from include/linux/bits.h:22,
                 from include/linux/ioport.h:13,
                 from include/linux/acpi.h:12,
                 from drivers/bus/hisi_lpc.c:9:
drivers/bus/hisi_lpc.c:509:41: error: 'struct acpi_device' has no member na=
med 'children'
  509 |         list_for_each_entry(child, &adev->children, node) {
      |                                         ^~
include/linux/build_bug.h:78:56: note: in definition of macro '__static_ass=
ert'
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
include/linux/container_of.h:19:9: note: in expansion of macro 'static_asse=
rt'
   19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||  =
     \
      |         ^~~~~~~~~~~~~
include/linux/container_of.h:19:23: note: in expansion of macro '__same_typ=
e'
   19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||  =
     \
      |                       ^~~~~~~~~~~
include/linux/list.h:520:9: note: in expansion of macro 'container_of'
  520 |         container_of(ptr, type, member)
      |         ^~~~~~~~~~~~
include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
  531 |         list_entry((ptr)->next, type, member)
      |         ^~~~~~~~~~
include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'
  674 |         for (pos =3D list_first_entry(head, typeof(*pos), member); =
       \
      |                    ^~~~~~~~~~~~~~~~
drivers/bus/hisi_lpc.c:509:9: note: in expansion of macro 'list_for_each_en=
try'
  509 |         list_for_each_entry(child, &adev->children, node) {
      |         ^~~~~~~~~~~~~~~~~~~
drivers/bus/hisi_lpc.c:509:53: error: 'struct acpi_device' has no member na=
med 'node'; did you mean 'fwnode'?
  509 |         list_for_each_entry(child, &adev->children, node) {
      |                                                     ^~~~
include/linux/build_bug.h:78:56: note: in definition of macro '__static_ass=
ert'
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
include/linux/container_of.h:19:9: note: in expansion of macro 'static_asse=
rt'
   19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||  =
     \
      |         ^~~~~~~~~~~~~
include/linux/container_of.h:19:23: note: in expansion of macro '__same_typ=
e'
   19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||  =
     \
      |                       ^~~~~~~~~~~
include/linux/list.h:520:9: note: in expansion of macro 'container_of'
  520 |         container_of(ptr, type, member)
      |         ^~~~~~~~~~~~
include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
  531 |         list_entry((ptr)->next, type, member)
      |         ^~~~~~~~~~
include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'
  674 |         for (pos =3D list_first_entry(head, typeof(*pos), member); =
       \
      |                    ^~~~~~~~~~~~~~~~
drivers/bus/hisi_lpc.c:509:9: note: in expansion of macro 'list_for_each_en=
try'
  509 |         list_for_each_entry(child, &adev->children, node) {
      |         ^~~~~~~~~~~~~~~~~~~
drivers/bus/hisi_lpc.c:509:41: error: 'struct acpi_device' has no member na=
med 'children'
  509 |         list_for_each_entry(child, &adev->children, node) {
      |                                         ^~
include/linux/build_bug.h:78:56: note: in definition of macro '__static_ass=
ert'
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
include/linux/container_of.h:19:9: note: in expansion of macro 'static_asse=
rt'
   19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||  =
     \
      |         ^~~~~~~~~~~~~
include/linux/container_of.h:20:23: note: in expansion of macro '__same_typ=
e'
   20 |                       __same_type(*(ptr), void),                   =
     \
      |                       ^~~~~~~~~~~
include/linux/list.h:520:9: note: in expansion of macro 'container_of'
  520 |         container_of(ptr, type, member)
      |         ^~~~~~~~~~~~
include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
  531 |         list_entry((ptr)->next, type, member)
      |         ^~~~~~~~~~
include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'
  674 |         for (pos =3D list_first_entry(head, typeof(*pos), member); =
       \
      |                    ^~~~~~~~~~~~~~~~
drivers/bus/hisi_lpc.c:509:9: note: in expansion of macro 'list_for_each_en=
try'
  509 |         list_for_each_entry(child, &adev->children, node) {
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/compiler_types.h:293:27: error: expression in static assertio=
n is not an integer
  293 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), t=
ypeof(b))
      |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:78:56: note: in definition of macro '__static_ass=
ert'
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
include/linux/container_of.h:19:9: note: in expansion of macro 'static_asse=
rt'
   19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||  =
     \
      |         ^~~~~~~~~~~~~
include/linux/container_of.h:19:23: note: in expansion of macro '__same_typ=
e'
   19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||  =
     \
      |                       ^~~~~~~~~~~
include/linux/list.h:520:9: note: in expansion of macro 'container_of'
  520 |         container_of(ptr, type, member)
      |         ^~~~~~~~~~~~
include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
  531 |         list_entry((ptr)->next, type, member)
      |         ^~~~~~~~~~
include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'
  674 |         for (pos =3D list_first_entry(head, typeof(*pos), member); =
       \
      |                    ^~~~~~~~~~~~~~~~
drivers/bus/hisi_lpc.c:509:9: note: in expansion of macro 'list_for_each_en=
try'
  509 |         list_for_each_entry(child, &adev->children, node) {
      |         ^~~~~~~~~~~~~~~~~~~
In file included from include/uapi/linux/posix_types.h:5,
                 from include/uapi/linux/types.h:14,
                 from include/linux/types.h:6,
                 from include/linux/kasan-checks.h:5,
                 from include/asm-generic/rwonce.h:26,
                 from ./arch/x86/include/generated/asm/rwonce.h:1,
                 from include/linux/compiler.h:248,
                 from include/linux/build_bug.h:5,
                 from include/linux/bits.h:22,
                 from include/linux/ioport.h:13,
                 from include/linux/acpi.h:12,
                 from drivers/bus/hisi_lpc.c:9:
drivers/bus/hisi_lpc.c:509:53: error: 'struct acpi_device' has no member na=
med 'node'; did you mean 'fwnode'?
  509 |         list_for_each_entry(child, &adev->children, node) {
      |                                                     ^~~~
include/linux/stddef.h:16:58: note: in definition of macro 'offsetof'
   16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
      |                                                          ^~~~~~
include/linux/list.h:520:9: note: in expansion of macro 'container_of'
  520 |         container_of(ptr, type, member)
      |         ^~~~~~~~~~~~
include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
  531 |         list_entry((ptr)->next, type, member)
      |         ^~~~~~~~~~
include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'
  674 |         for (pos =3D list_first_entry(head, typeof(*pos), member); =
       \
      |                    ^~~~~~~~~~~~~~~~
drivers/bus/hisi_lpc.c:509:9: note: in expansion of macro 'list_for_each_en=
try'
  509 |         list_for_each_entry(child, &adev->children, node) {
      |         ^~~~~~~~~~~~~~~~~~~
In file included from include/linux/kobject.h:19,
                 from include/linux/of.h:17,
                 from include/linux/irqdomain.h:35,
                 from include/linux/acpi.h:13,
                 from drivers/bus/hisi_lpc.c:9:
drivers/bus/hisi_lpc.c:509:53: error: 'struct acpi_device' has no member na=
med 'node'; did you mean 'fwnode'?
  509 |         list_for_each_entry(child, &adev->children, node) {
      |                                                     ^~~~
include/linux/list.h:665:16: note: in definition of macro 'list_entry_is_he=
ad'
  665 |         (&pos->member =3D=3D (head))
      |                ^~~~~~
drivers/bus/hisi_lpc.c:509:9: note: in expansion of macro 'list_for_each_en=
try'
  509 |         list_for_each_entry(child, &adev->children, node) {
      |         ^~~~~~~~~~~~~~~~~~~
drivers/bus/hisi_lpc.c:509:41: error: 'struct acpi_device' has no member na=
med 'children'
  509 |         list_for_each_entry(child, &adev->children, node) {
      |                                         ^~
include/linux/list.h:665:27: note: in definition of macro 'list_entry_is_he=
ad'
  665 |         (&pos->member =3D=3D (head))
      |                           ^~~~
drivers/bus/hisi_lpc.c:509:9: note: in expansion of macro 'list_for_each_en=
try'
  509 |         list_for_each_entry(child, &adev->children, node) {
      |         ^~~~~~~~~~~~~~~~~~~
In file included from include/linux/list.h:5,
                 from include/linux/kobject.h:19,
                 from include/linux/of.h:17,
                 from include/linux/irqdomain.h:35,
                 from include/linux/acpi.h:13,
                 from drivers/bus/hisi_lpc.c:9:
drivers/bus/hisi_lpc.c:509:53: error: 'struct acpi_device' has no member na=
med 'node'; did you mean 'fwnode'?
  509 |         list_for_each_entry(child, &adev->children, node) {
      |                                                     ^~~~
include/linux/container_of.h:18:33: note: in definition of macro 'container=
_of'
   18 |         void *__mptr =3D (void *)(ptr);                            =
       \
      |                                 ^~~
include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
  564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
      |         ^~~~~~~~~~
include/linux/list.h:676:20: note: in expansion of macro 'list_next_entry'
  676 |              pos =3D list_next_entry(pos, member))
      |                    ^~~~~~~~~~~~~~~
drivers/bus/hisi_lpc.c:509:9: note: in expansion of macro 'list_for_each_en=
try'
  509 |         list_for_each_entry(child, &adev->children, node) {
      |         ^~~~~~~~~~~~~~~~~~~
In file included from include/linux/bits.h:22,
                 from include/linux/ioport.h:13,
                 from include/linux/acpi.h:12,
                 from drivers/bus/hisi_lpc.c:9:
drivers/bus/hisi_lpc.c:509:53: error: 'struct acpi_device' has no member na=
med 'node'; did you mean 'fwnode'?
  509 |         list_for_each_entry(child, &adev->children, node) {
      |                                                     ^~~~
include/linux/build_bug.h:78:56: note: in definition of macro '__static_ass=
ert'
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
include/linux/container_of.h:19:9: note: in expansion of macro 'static_asse=
rt'
   19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||  =
     \
      |         ^~~~~~~~~~~~~
include/linux/container_of.h:19:23: note: in expansion of macro '__same_typ=
e'
   19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||  =
     \
      |                       ^~~~~~~~~~~
include/linux/list.h:520:9: note: in expansion of macro 'container_of'
  520 |         container_of(ptr, type, member)
      |         ^~~~~~~~~~~~
include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
  564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
      |         ^~~~~~~~~~
include/linux/list.h:676:20: note: in expansion of macro 'list_next_entry'
  676 |              pos =3D list_next_entry(pos, member))
      |                    ^~~~~~~~~~~~~~~
drivers/bus/hisi_lpc.c:509:9: note: in expansion of macro 'list_for_each_en=
try'
  509 |         list_for_each_entry(child, &adev->children, node) {
      |         ^~~~~~~~~~~~~~~~~~~
drivers/bus/hisi_lpc.c:509:53: error: 'struct acpi_device' has no member na=
med 'node'; did you mean 'fwnode'?
  509 |         list_for_each_entry(child, &adev->children, node) {
      |                                                     ^~~~
include/linux/build_bug.h:78:56: note: in definition of macro '__static_ass=
ert'
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
include/linux/container_of.h:19:9: note: in expansion of macro 'static_asse=
rt'
   19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||  =
     \
      |         ^~~~~~~~~~~~~
include/linux/container_of.h:19:23: note: in expansion of macro '__same_typ=
e'
   19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||  =
     \
      |                       ^~~~~~~~~~~
include/linux/list.h:520:9: note: in expansion of macro 'container_of'
  520 |         container_of(ptr, type, member)
      |         ^~~~~~~~~~~~
include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
  564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
      |         ^~~~~~~~~~
include/linux/list.h:676:20: note: in expansion of macro 'list_next_entry'
  676 |              pos =3D list_next_entry(pos, member))
      |                    ^~~~~~~~~~~~~~~
drivers/bus/hisi_lpc.c:509:9: note: in expansion of macro 'list_for_each_en=
try'
  509 |         list_for_each_entry(child, &adev->children, node) {
      |         ^~~~~~~~~~~~~~~~~~~
drivers/bus/hisi_lpc.c:509:53: error: 'struct acpi_device' has no member na=
med 'node'; did you mean 'fwnode'?
  509 |         list_for_each_entry(child, &adev->children, node) {
      |                                                     ^~~~
include/linux/build_bug.h:78:56: note: in definition of macro '__static_ass=
ert'
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
include/linux/container_of.h:19:9: note: in expansion of macro 'static_asse=
rt'
   19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||  =
     \
      |         ^~~~~~~~~~~~~
include/linux/container_of.h:20:23: note: in expansion of macro '__same_typ=
e'
   20 |                       __same_type(*(ptr), void),                   =
     \
      |                       ^~~~~~~~~~~
include/linux/list.h:520:9: note: in expansion of macro 'container_of'
  520 |         container_of(ptr, type, member)
      |         ^~~~~~~~~~~~
include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
  564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
      |         ^~~~~~~~~~
include/linux/list.h:676:20: note: in expansion of macro 'list_next_entry'
  676 |              pos =3D list_next_entry(pos, member))
      |                    ^~~~~~~~~~~~~~~
drivers/bus/hisi_lpc.c:509:9: note: in expansion of macro 'list_for_each_en=
try'
  509 |         list_for_each_entry(child, &adev->children, node) {
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/compiler_types.h:293:27: error: expression in static assertio=
n is not an integer
  293 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), t=
ypeof(b))
      |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:78:56: note: in definition of macro '__static_ass=
ert'
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
include/linux/container_of.h:19:9: note: in expansion of macro 'static_asse=
rt'
   19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||  =
     \
      |         ^~~~~~~~~~~~~
include/linux/container_of.h:19:23: note: in expansion of macro '__same_typ=
e'
   19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||  =
     \
      |                       ^~~~~~~~~~~
include/linux/list.h:520:9: note: in expansion of macro 'container_of'
  520 |         container_of(ptr, type, member)
      |         ^~~~~~~~~~~~
include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
  564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
      |         ^~~~~~~~~~
include/linux/list.h:676:20: note: in expansion of macro 'list_next_entry'
  676 |              pos =3D list_next_entry(pos, member))
      |                    ^~~~~~~~~~~~~~~
drivers/bus/hisi_lpc.c:509:9: note: in expansion of macro 'list_for_each_en=
try'
  509 |         list_for_each_entry(child, &adev->children, node) {
      |         ^~~~~~~~~~~~~~~~~~~
In file included from include/uapi/linux/posix_types.h:5,
                 from include/uapi/linux/types.h:14,
                 from include/linux/types.h:6,
                 from include/linux/kasan-checks.h:5,
                 from include/asm-generic/rwonce.h:26,
                 from ./arch/x86/include/generated/asm/rwonce.h:1,
                 from include/linux/compiler.h:248,
                 from include/linux/build_bug.h:5,
                 from include/linux/bits.h:22,
                 from include/linux/ioport.h:13,
                 from include/linux/acpi.h:12,
                 from drivers/bus/hisi_lpc.c:9:
drivers/bus/hisi_lpc.c:509:53: error: 'struct acpi_device' has no member na=
med 'node'; did you mean 'fwnode'?
  509 |         list_for_each_entry(child, &adev->children, node) {
      |                                                     ^~~~
include/linux/stddef.h:16:58: note: in definition of macro 'offsetof'
   16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
      |                                                          ^~~~~~
include/linux/list.h:520:9: note: in expansion of macro 'container_of'
  520 |         container_of(ptr, type, member)
      |         ^~~~~~~~~~~~
include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
  564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
      |         ^~~~~~~~~~
include/linux/list.h:676:20: note: in expansion of macro 'list_next_entry'
  676 |              pos =3D list_next_entry(pos, member))
      |                    ^~~~~~~~~~~~~~~
drivers/bus/hisi_lpc.c:509:9: note: in expansion of macro 'list_for_each_en=
try'
  509 |         list_for_each_entry(child, &adev->children, node) {
      |         ^~~~~~~~~~~~~~~~~~~

Caused by commit

  647590eb6f34 ("ACPI: bus: Drop unused list heads from struct acpi_device")

I have used the pm tree from next-20220628 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/LbU_JmBcLFP5PSw8U38wYDV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmK7m2gACgkQAVBC80lX
0Gz0SAf/fM3wXGLVN+al7K/b/xHc1dghQws9beNASMuerrlYZFlU4rx5MSn1lQN+
rP2VfUEdp27EpR+VTA476sCzkVfw69I6SZ/irqDEPOJzPcyQF66/DM8KwaCGWj+Y
WsKnMZkCR+uH4JauJr+TIpGkn6MWwBeSyXCd8LB8PMPKiPMruBFVRk4KWF6fmpTY
1WzaLrp4ohzKIiptdcNLlyWmGk7S6r2QvxWuqHAoDBg470Q1zm3Ir3Ks+t5wnbnx
qg/6K5oIvPO2vllris6xLlqHM6/E0lFrRunD9Y04xrYyJnzPCgQsrDNrNefJg0oa
S55YEJso141CkANTNngG3WCMFTx7kw==
=DEJC
-----END PGP SIGNATURE-----

--Sig_/LbU_JmBcLFP5PSw8U38wYDV--
