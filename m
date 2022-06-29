Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5225600D9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 15:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbiF2NCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 09:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbiF2NB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 09:01:58 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBC63BBE4;
        Wed, 29 Jun 2022 06:01:54 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 1b23cf66b47ad00d; Wed, 29 Jun 2022 15:01:53 +0200
Received: from kreacher.localnet (unknown [213.134.175.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 54C1266C9F7;
        Wed, 29 Jun 2022 15:01:52 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the pm tree
Date:   Wed, 29 Jun 2022 15:01:51 +0200
Message-ID: <5855454.lOV4Wx5bFT@kreacher>
In-Reply-To: <20220629102304.6d924362@canb.auug.org.au>
References: <20220629102304.6d924362@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.150
X-CLIENT-HOSTNAME: 213.134.175.150
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudegledgheekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppedvudefrddufeegrddujeehrdduhedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudejhedrudehtddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepfedprhgtphhtthhopehsfhhrsegtrghnsgdrrghuuhhgrdhorhhgrdgruhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhnvgigthesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, June 29, 2022 2:23:04 AM CEST Stephen Rothwell wrote:
> Hi all,
> 
> After merging the pm tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
> 
> In file included from include/linux/list.h:5,
>                  from include/linux/kobject.h:19,
>                  from include/linux/of.h:17,
>                  from include/linux/irqdomain.h:35,
>                  from include/linux/acpi.h:13,
>                  from drivers/bus/hisi_lpc.c:9:
> drivers/bus/hisi_lpc.c: In function 'hisi_lpc_acpi_remove':
> drivers/bus/hisi_lpc.c:488:41: error: 'struct acpi_device' has no member named 'children'
>   488 |         list_for_each_entry(child, &adev->children, node)
>       |                                         ^~
> include/linux/container_of.h:18:33: note: in definition of macro 'container_of'
>    18 |         void *__mptr = (void *)(ptr);                                   \
>       |                                 ^~~
> include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
>   531 |         list_entry((ptr)->next, type, member)
>       |         ^~~~~~~~~~
> include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'
>   674 |         for (pos = list_first_entry(head, typeof(*pos), member);        \
>       |                    ^~~~~~~~~~~~~~~~
> drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_entry'
>   488 |         list_for_each_entry(child, &adev->children, node)
>       |         ^~~~~~~~~~~~~~~~~~~
> In file included from include/linux/bits.h:22,
>                  from include/linux/ioport.h:13,
>                  from include/linux/acpi.h:12,
>                  from drivers/bus/hisi_lpc.c:9:
> drivers/bus/hisi_lpc.c:488:41: error: 'struct acpi_device' has no member named 'children'
>   488 |         list_for_each_entry(child, &adev->children, node)
>       |                                         ^~
> include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
>    78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>       |                                                        ^~~~
> include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
>    19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>       |         ^~~~~~~~~~~~~
> include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
>    19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>       |                       ^~~~~~~~~~~
> include/linux/list.h:520:9: note: in expansion of macro 'container_of'
>   520 |         container_of(ptr, type, member)
>       |         ^~~~~~~~~~~~
> include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
>   531 |         list_entry((ptr)->next, type, member)
>       |         ^~~~~~~~~~
> include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'
>   674 |         for (pos = list_first_entry(head, typeof(*pos), member);        \
>       |                    ^~~~~~~~~~~~~~~~
> drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_entry'
>   488 |         list_for_each_entry(child, &adev->children, node)
>       |         ^~~~~~~~~~~~~~~~~~~
> drivers/bus/hisi_lpc.c:488:53: error: 'struct acpi_device' has no member named 'node'; did you mean 'fwnode'?
>   488 |         list_for_each_entry(child, &adev->children, node)
>       |                                                     ^~~~
> include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
>    78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>       |                                                        ^~~~
> include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
>    19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>       |         ^~~~~~~~~~~~~
> include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
>    19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>       |                       ^~~~~~~~~~~
> include/linux/list.h:520:9: note: in expansion of macro 'container_of'
>   520 |         container_of(ptr, type, member)
>       |         ^~~~~~~~~~~~
> include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
>   531 |         list_entry((ptr)->next, type, member)
>       |         ^~~~~~~~~~
> include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'
>   674 |         for (pos = list_first_entry(head, typeof(*pos), member);        \
>       |                    ^~~~~~~~~~~~~~~~
> drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_entry'
>   488 |         list_for_each_entry(child, &adev->children, node)
>       |         ^~~~~~~~~~~~~~~~~~~
> drivers/bus/hisi_lpc.c:488:41: error: 'struct acpi_device' has no member named 'children'
>   488 |         list_for_each_entry(child, &adev->children, node)
>       |                                         ^~
> include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
>    78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>       |                                                        ^~~~
> include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
>    19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>       |         ^~~~~~~~~~~~~
> include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
>    20 |                       __same_type(*(ptr), void),                        \
>       |                       ^~~~~~~~~~~
> include/linux/list.h:520:9: note: in expansion of macro 'container_of'
>   520 |         container_of(ptr, type, member)
>       |         ^~~~~~~~~~~~
> include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
>   531 |         list_entry((ptr)->next, type, member)
>       |         ^~~~~~~~~~
> include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'
>   674 |         for (pos = list_first_entry(head, typeof(*pos), member);        \
>       |                    ^~~~~~~~~~~~~~~~
> drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_entry'
>   488 |         list_for_each_entry(child, &adev->children, node)
>       |         ^~~~~~~~~~~~~~~~~~~
> include/linux/compiler_types.h:293:27: error: expression in static assertion is not an integer
>   293 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
>       |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
>    78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>       |                                                        ^~~~
> include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
>    19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>       |         ^~~~~~~~~~~~~
> include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
>    19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>       |                       ^~~~~~~~~~~
> include/linux/list.h:520:9: note: in expansion of macro 'container_of'
>   520 |         container_of(ptr, type, member)
>       |         ^~~~~~~~~~~~
> include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
>   531 |         list_entry((ptr)->next, type, member)
>       |         ^~~~~~~~~~
> include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'
>   674 |         for (pos = list_first_entry(head, typeof(*pos), member);        \
>       |                    ^~~~~~~~~~~~~~~~
> drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_entry'
>   488 |         list_for_each_entry(child, &adev->children, node)
>       |         ^~~~~~~~~~~~~~~~~~~
> In file included from include/uapi/linux/posix_types.h:5,
>                  from include/uapi/linux/types.h:14,
>                  from include/linux/types.h:6,
>                  from include/linux/kasan-checks.h:5,
>                  from include/asm-generic/rwonce.h:26,
>                  from ./arch/x86/include/generated/asm/rwonce.h:1,
>                  from include/linux/compiler.h:248,
>                  from include/linux/build_bug.h:5,
>                  from include/linux/bits.h:22,
>                  from include/linux/ioport.h:13,
>                  from include/linux/acpi.h:12,
>                  from drivers/bus/hisi_lpc.c:9:
> drivers/bus/hisi_lpc.c:488:53: error: 'struct acpi_device' has no member named 'node'; did you mean 'fwnode'?
>   488 |         list_for_each_entry(child, &adev->children, node)
>       |                                                     ^~~~
> include/linux/stddef.h:16:58: note: in definition of macro 'offsetof'
>    16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
>       |                                                          ^~~~~~
> include/linux/list.h:520:9: note: in expansion of macro 'container_of'
>   520 |         container_of(ptr, type, member)
>       |         ^~~~~~~~~~~~
> include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
>   531 |         list_entry((ptr)->next, type, member)
>       |         ^~~~~~~~~~
> include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'
>   674 |         for (pos = list_first_entry(head, typeof(*pos), member);        \
>       |                    ^~~~~~~~~~~~~~~~
> drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_entry'
>   488 |         list_for_each_entry(child, &adev->children, node)
>       |         ^~~~~~~~~~~~~~~~~~~
> In file included from include/linux/kobject.h:19,
>                  from include/linux/of.h:17,
>                  from include/linux/irqdomain.h:35,
>                  from include/linux/acpi.h:13,
>                  from drivers/bus/hisi_lpc.c:9:
> drivers/bus/hisi_lpc.c:488:53: error: 'struct acpi_device' has no member named 'node'; did you mean 'fwnode'?
>   488 |         list_for_each_entry(child, &adev->children, node)
>       |                                                     ^~~~
> include/linux/list.h:665:16: note: in definition of macro 'list_entry_is_head'
>   665 |         (&pos->member == (head))
>       |                ^~~~~~
> drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_entry'
>   488 |         list_for_each_entry(child, &adev->children, node)
>       |         ^~~~~~~~~~~~~~~~~~~
> drivers/bus/hisi_lpc.c:488:41: error: 'struct acpi_device' has no member named 'children'
>   488 |         list_for_each_entry(child, &adev->children, node)
>       |                                         ^~
> include/linux/list.h:665:27: note: in definition of macro 'list_entry_is_head'
>   665 |         (&pos->member == (head))
>       |                           ^~~~
> drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_entry'
>   488 |         list_for_each_entry(child, &adev->children, node)
>       |         ^~~~~~~~~~~~~~~~~~~
> In file included from include/linux/list.h:5,
>                  from include/linux/kobject.h:19,
>                  from include/linux/of.h:17,
>                  from include/linux/irqdomain.h:35,
>                  from include/linux/acpi.h:13,
>                  from drivers/bus/hisi_lpc.c:9:
> drivers/bus/hisi_lpc.c:488:53: error: 'struct acpi_device' has no member named 'node'; did you mean 'fwnode'?
>   488 |         list_for_each_entry(child, &adev->children, node)
>       |                                                     ^~~~
> include/linux/container_of.h:18:33: note: in definition of macro 'container_of'
>    18 |         void *__mptr = (void *)(ptr);                                   \
>       |                                 ^~~
> include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
>   564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
>       |         ^~~~~~~~~~
> include/linux/list.h:676:20: note: in expansion of macro 'list_next_entry'
>   676 |              pos = list_next_entry(pos, member))
>       |                    ^~~~~~~~~~~~~~~
> drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_entry'
>   488 |         list_for_each_entry(child, &adev->children, node)
>       |         ^~~~~~~~~~~~~~~~~~~
> In file included from include/linux/bits.h:22,
>                  from include/linux/ioport.h:13,
>                  from include/linux/acpi.h:12,
>                  from drivers/bus/hisi_lpc.c:9:
> drivers/bus/hisi_lpc.c:488:53: error: 'struct acpi_device' has no member named 'node'; did you mean 'fwnode'?
>   488 |         list_for_each_entry(child, &adev->children, node)
>       |                                                     ^~~~
> include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
>    78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>       |                                                        ^~~~
> include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
>    19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>       |         ^~~~~~~~~~~~~
> include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
>    19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>       |                       ^~~~~~~~~~~
> include/linux/list.h:520:9: note: in expansion of macro 'container_of'
>   520 |         container_of(ptr, type, member)
>       |         ^~~~~~~~~~~~
> include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
>   564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
>       |         ^~~~~~~~~~
> include/linux/list.h:676:20: note: in expansion of macro 'list_next_entry'
>   676 |              pos = list_next_entry(pos, member))
>       |                    ^~~~~~~~~~~~~~~
> drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_entry'
>   488 |         list_for_each_entry(child, &adev->children, node)
>       |         ^~~~~~~~~~~~~~~~~~~
> drivers/bus/hisi_lpc.c:488:53: error: 'struct acpi_device' has no member named 'node'; did you mean 'fwnode'?
>   488 |         list_for_each_entry(child, &adev->children, node)
>       |                                                     ^~~~
> include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
>    78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>       |                                                        ^~~~
> include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
>    19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>       |         ^~~~~~~~~~~~~
> include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
>    19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>       |                       ^~~~~~~~~~~
> include/linux/list.h:520:9: note: in expansion of macro 'container_of'
>   520 |         container_of(ptr, type, member)
>       |         ^~~~~~~~~~~~
> include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
>   564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
>       |         ^~~~~~~~~~
> include/linux/list.h:676:20: note: in expansion of macro 'list_next_entry'
>   676 |              pos = list_next_entry(pos, member))
>       |                    ^~~~~~~~~~~~~~~
> drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_entry'
>   488 |         list_for_each_entry(child, &adev->children, node)
>       |         ^~~~~~~~~~~~~~~~~~~
> drivers/bus/hisi_lpc.c:488:53: error: 'struct acpi_device' has no member named 'node'; did you mean 'fwnode'?
>   488 |         list_for_each_entry(child, &adev->children, node)
>       |                                                     ^~~~
> include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
>    78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>       |                                                        ^~~~
> include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
>    19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>       |         ^~~~~~~~~~~~~
> include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
>    20 |                       __same_type(*(ptr), void),                        \
>       |                       ^~~~~~~~~~~
> include/linux/list.h:520:9: note: in expansion of macro 'container_of'
>   520 |         container_of(ptr, type, member)
>       |         ^~~~~~~~~~~~
> include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
>   564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
>       |         ^~~~~~~~~~
> include/linux/list.h:676:20: note: in expansion of macro 'list_next_entry'
>   676 |              pos = list_next_entry(pos, member))
>       |                    ^~~~~~~~~~~~~~~
> drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_entry'
>   488 |         list_for_each_entry(child, &adev->children, node)
>       |         ^~~~~~~~~~~~~~~~~~~
> include/linux/compiler_types.h:293:27: error: expression in static assertion is not an integer
>   293 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
>       |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
>    78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>       |                                                        ^~~~
> include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
>    19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>       |         ^~~~~~~~~~~~~
> include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
>    19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>       |                       ^~~~~~~~~~~
> include/linux/list.h:520:9: note: in expansion of macro 'container_of'
>   520 |         container_of(ptr, type, member)
>       |         ^~~~~~~~~~~~
> include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
>   564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
>       |         ^~~~~~~~~~
> include/linux/list.h:676:20: note: in expansion of macro 'list_next_entry'
>   676 |              pos = list_next_entry(pos, member))
>       |                    ^~~~~~~~~~~~~~~
> drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_entry'
>   488 |         list_for_each_entry(child, &adev->children, node)
>       |         ^~~~~~~~~~~~~~~~~~~
> In file included from include/uapi/linux/posix_types.h:5,
>                  from include/uapi/linux/types.h:14,
>                  from include/linux/types.h:6,
>                  from include/linux/kasan-checks.h:5,
>                  from include/asm-generic/rwonce.h:26,
>                  from ./arch/x86/include/generated/asm/rwonce.h:1,
>                  from include/linux/compiler.h:248,
>                  from include/linux/build_bug.h:5,
>                  from include/linux/bits.h:22,
>                  from include/linux/ioport.h:13,
>                  from include/linux/acpi.h:12,
>                  from drivers/bus/hisi_lpc.c:9:
> drivers/bus/hisi_lpc.c:488:53: error: 'struct acpi_device' has no member named 'node'; did you mean 'fwnode'?
>   488 |         list_for_each_entry(child, &adev->children, node)
>       |                                                     ^~~~
> include/linux/stddef.h:16:58: note: in definition of macro 'offsetof'
>    16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
>       |                                                          ^~~~~~
> include/linux/list.h:520:9: note: in expansion of macro 'container_of'
>   520 |         container_of(ptr, type, member)
>       |         ^~~~~~~~~~~~
> include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
>   564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
>       |         ^~~~~~~~~~
> include/linux/list.h:676:20: note: in expansion of macro 'list_next_entry'
>   676 |              pos = list_next_entry(pos, member))
>       |                    ^~~~~~~~~~~~~~~
> drivers/bus/hisi_lpc.c:488:9: note: in expansion of macro 'list_for_each_entry'
>   488 |         list_for_each_entry(child, &adev->children, node)
>       |         ^~~~~~~~~~~~~~~~~~~
> In file included from include/linux/list.h:5,
>                  from include/linux/kobject.h:19,
>                  from include/linux/of.h:17,
>                  from include/linux/irqdomain.h:35,
>                  from include/linux/acpi.h:13,
>                  from drivers/bus/hisi_lpc.c:9:
> drivers/bus/hisi_lpc.c: In function 'hisi_lpc_acpi_probe':
> drivers/bus/hisi_lpc.c:509:41: error: 'struct acpi_device' has no member named 'children'
>   509 |         list_for_each_entry(child, &adev->children, node) {
>       |                                         ^~
> include/linux/container_of.h:18:33: note: in definition of macro 'container_of'
>    18 |         void *__mptr = (void *)(ptr);                                   \
>       |                                 ^~~
> include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
>   531 |         list_entry((ptr)->next, type, member)
>       |         ^~~~~~~~~~
> include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'
>   674 |         for (pos = list_first_entry(head, typeof(*pos), member);        \
>       |                    ^~~~~~~~~~~~~~~~
> drivers/bus/hisi_lpc.c:509:9: note: in expansion of macro 'list_for_each_entry'
>   509 |         list_for_each_entry(child, &adev->children, node) {
>       |         ^~~~~~~~~~~~~~~~~~~
> In file included from include/linux/bits.h:22,
>                  from include/linux/ioport.h:13,
>                  from include/linux/acpi.h:12,
>                  from drivers/bus/hisi_lpc.c:9:
> drivers/bus/hisi_lpc.c:509:41: error: 'struct acpi_device' has no member named 'children'
>   509 |         list_for_each_entry(child, &adev->children, node) {
>       |                                         ^~
> include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
>    78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>       |                                                        ^~~~
> include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
>    19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>       |         ^~~~~~~~~~~~~
> include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
>    19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>       |                       ^~~~~~~~~~~
> include/linux/list.h:520:9: note: in expansion of macro 'container_of'
>   520 |         container_of(ptr, type, member)
>       |         ^~~~~~~~~~~~
> include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
>   531 |         list_entry((ptr)->next, type, member)
>       |         ^~~~~~~~~~
> include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'
>   674 |         for (pos = list_first_entry(head, typeof(*pos), member);        \
>       |                    ^~~~~~~~~~~~~~~~
> drivers/bus/hisi_lpc.c:509:9: note: in expansion of macro 'list_for_each_entry'
>   509 |         list_for_each_entry(child, &adev->children, node) {
>       |         ^~~~~~~~~~~~~~~~~~~
> drivers/bus/hisi_lpc.c:509:53: error: 'struct acpi_device' has no member named 'node'; did you mean 'fwnode'?
>   509 |         list_for_each_entry(child, &adev->children, node) {
>       |                                                     ^~~~
> include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
>    78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>       |                                                        ^~~~
> include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
>    19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>       |         ^~~~~~~~~~~~~
> include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
>    19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>       |                       ^~~~~~~~~~~
> include/linux/list.h:520:9: note: in expansion of macro 'container_of'
>   520 |         container_of(ptr, type, member)
>       |         ^~~~~~~~~~~~
> include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
>   531 |         list_entry((ptr)->next, type, member)
>       |         ^~~~~~~~~~
> include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'
>   674 |         for (pos = list_first_entry(head, typeof(*pos), member);        \
>       |                    ^~~~~~~~~~~~~~~~
> drivers/bus/hisi_lpc.c:509:9: note: in expansion of macro 'list_for_each_entry'
>   509 |         list_for_each_entry(child, &adev->children, node) {
>       |         ^~~~~~~~~~~~~~~~~~~
> drivers/bus/hisi_lpc.c:509:41: error: 'struct acpi_device' has no member named 'children'
>   509 |         list_for_each_entry(child, &adev->children, node) {
>       |                                         ^~
> include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
>    78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>       |                                                        ^~~~
> include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
>    19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>       |         ^~~~~~~~~~~~~
> include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
>    20 |                       __same_type(*(ptr), void),                        \
>       |                       ^~~~~~~~~~~
> include/linux/list.h:520:9: note: in expansion of macro 'container_of'
>   520 |         container_of(ptr, type, member)
>       |         ^~~~~~~~~~~~
> include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
>   531 |         list_entry((ptr)->next, type, member)
>       |         ^~~~~~~~~~
> include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'
>   674 |         for (pos = list_first_entry(head, typeof(*pos), member);        \
>       |                    ^~~~~~~~~~~~~~~~
> drivers/bus/hisi_lpc.c:509:9: note: in expansion of macro 'list_for_each_entry'
>   509 |         list_for_each_entry(child, &adev->children, node) {
>       |         ^~~~~~~~~~~~~~~~~~~
> include/linux/compiler_types.h:293:27: error: expression in static assertion is not an integer
>   293 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
>       |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
>    78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>       |                                                        ^~~~
> include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
>    19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>       |         ^~~~~~~~~~~~~
> include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
>    19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>       |                       ^~~~~~~~~~~
> include/linux/list.h:520:9: note: in expansion of macro 'container_of'
>   520 |         container_of(ptr, type, member)
>       |         ^~~~~~~~~~~~
> include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
>   531 |         list_entry((ptr)->next, type, member)
>       |         ^~~~~~~~~~
> include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'
>   674 |         for (pos = list_first_entry(head, typeof(*pos), member);        \
>       |                    ^~~~~~~~~~~~~~~~
> drivers/bus/hisi_lpc.c:509:9: note: in expansion of macro 'list_for_each_entry'
>   509 |         list_for_each_entry(child, &adev->children, node) {
>       |         ^~~~~~~~~~~~~~~~~~~
> In file included from include/uapi/linux/posix_types.h:5,
>                  from include/uapi/linux/types.h:14,
>                  from include/linux/types.h:6,
>                  from include/linux/kasan-checks.h:5,
>                  from include/asm-generic/rwonce.h:26,
>                  from ./arch/x86/include/generated/asm/rwonce.h:1,
>                  from include/linux/compiler.h:248,
>                  from include/linux/build_bug.h:5,
>                  from include/linux/bits.h:22,
>                  from include/linux/ioport.h:13,
>                  from include/linux/acpi.h:12,
>                  from drivers/bus/hisi_lpc.c:9:
> drivers/bus/hisi_lpc.c:509:53: error: 'struct acpi_device' has no member named 'node'; did you mean 'fwnode'?
>   509 |         list_for_each_entry(child, &adev->children, node) {
>       |                                                     ^~~~
> include/linux/stddef.h:16:58: note: in definition of macro 'offsetof'
>    16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
>       |                                                          ^~~~~~
> include/linux/list.h:520:9: note: in expansion of macro 'container_of'
>   520 |         container_of(ptr, type, member)
>       |         ^~~~~~~~~~~~
> include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
>   531 |         list_entry((ptr)->next, type, member)
>       |         ^~~~~~~~~~
> include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'
>   674 |         for (pos = list_first_entry(head, typeof(*pos), member);        \
>       |                    ^~~~~~~~~~~~~~~~
> drivers/bus/hisi_lpc.c:509:9: note: in expansion of macro 'list_for_each_entry'
>   509 |         list_for_each_entry(child, &adev->children, node) {
>       |         ^~~~~~~~~~~~~~~~~~~
> In file included from include/linux/kobject.h:19,
>                  from include/linux/of.h:17,
>                  from include/linux/irqdomain.h:35,
>                  from include/linux/acpi.h:13,
>                  from drivers/bus/hisi_lpc.c:9:
> drivers/bus/hisi_lpc.c:509:53: error: 'struct acpi_device' has no member named 'node'; did you mean 'fwnode'?
>   509 |         list_for_each_entry(child, &adev->children, node) {
>       |                                                     ^~~~
> include/linux/list.h:665:16: note: in definition of macro 'list_entry_is_head'
>   665 |         (&pos->member == (head))
>       |                ^~~~~~
> drivers/bus/hisi_lpc.c:509:9: note: in expansion of macro 'list_for_each_entry'
>   509 |         list_for_each_entry(child, &adev->children, node) {
>       |         ^~~~~~~~~~~~~~~~~~~
> drivers/bus/hisi_lpc.c:509:41: error: 'struct acpi_device' has no member named 'children'
>   509 |         list_for_each_entry(child, &adev->children, node) {
>       |                                         ^~
> include/linux/list.h:665:27: note: in definition of macro 'list_entry_is_head'
>   665 |         (&pos->member == (head))
>       |                           ^~~~
> drivers/bus/hisi_lpc.c:509:9: note: in expansion of macro 'list_for_each_entry'
>   509 |         list_for_each_entry(child, &adev->children, node) {
>       |         ^~~~~~~~~~~~~~~~~~~
> In file included from include/linux/list.h:5,
>                  from include/linux/kobject.h:19,
>                  from include/linux/of.h:17,
>                  from include/linux/irqdomain.h:35,
>                  from include/linux/acpi.h:13,
>                  from drivers/bus/hisi_lpc.c:9:
> drivers/bus/hisi_lpc.c:509:53: error: 'struct acpi_device' has no member named 'node'; did you mean 'fwnode'?
>   509 |         list_for_each_entry(child, &adev->children, node) {
>       |                                                     ^~~~
> include/linux/container_of.h:18:33: note: in definition of macro 'container_of'
>    18 |         void *__mptr = (void *)(ptr);                                   \
>       |                                 ^~~
> include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
>   564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
>       |         ^~~~~~~~~~
> include/linux/list.h:676:20: note: in expansion of macro 'list_next_entry'
>   676 |              pos = list_next_entry(pos, member))
>       |                    ^~~~~~~~~~~~~~~
> drivers/bus/hisi_lpc.c:509:9: note: in expansion of macro 'list_for_each_entry'
>   509 |         list_for_each_entry(child, &adev->children, node) {
>       |         ^~~~~~~~~~~~~~~~~~~
> In file included from include/linux/bits.h:22,
>                  from include/linux/ioport.h:13,
>                  from include/linux/acpi.h:12,
>                  from drivers/bus/hisi_lpc.c:9:
> drivers/bus/hisi_lpc.c:509:53: error: 'struct acpi_device' has no member named 'node'; did you mean 'fwnode'?
>   509 |         list_for_each_entry(child, &adev->children, node) {
>       |                                                     ^~~~
> include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
>    78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>       |                                                        ^~~~
> include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
>    19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>       |         ^~~~~~~~~~~~~
> include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
>    19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>       |                       ^~~~~~~~~~~
> include/linux/list.h:520:9: note: in expansion of macro 'container_of'
>   520 |         container_of(ptr, type, member)
>       |         ^~~~~~~~~~~~
> include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
>   564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
>       |         ^~~~~~~~~~
> include/linux/list.h:676:20: note: in expansion of macro 'list_next_entry'
>   676 |              pos = list_next_entry(pos, member))
>       |                    ^~~~~~~~~~~~~~~
> drivers/bus/hisi_lpc.c:509:9: note: in expansion of macro 'list_for_each_entry'
>   509 |         list_for_each_entry(child, &adev->children, node) {
>       |         ^~~~~~~~~~~~~~~~~~~
> drivers/bus/hisi_lpc.c:509:53: error: 'struct acpi_device' has no member named 'node'; did you mean 'fwnode'?
>   509 |         list_for_each_entry(child, &adev->children, node) {
>       |                                                     ^~~~
> include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
>    78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>       |                                                        ^~~~
> include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
>    19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>       |         ^~~~~~~~~~~~~
> include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
>    19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>       |                       ^~~~~~~~~~~
> include/linux/list.h:520:9: note: in expansion of macro 'container_of'
>   520 |         container_of(ptr, type, member)
>       |         ^~~~~~~~~~~~
> include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
>   564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
>       |         ^~~~~~~~~~
> include/linux/list.h:676:20: note: in expansion of macro 'list_next_entry'
>   676 |              pos = list_next_entry(pos, member))
>       |                    ^~~~~~~~~~~~~~~
> drivers/bus/hisi_lpc.c:509:9: note: in expansion of macro 'list_for_each_entry'
>   509 |         list_for_each_entry(child, &adev->children, node) {
>       |         ^~~~~~~~~~~~~~~~~~~
> drivers/bus/hisi_lpc.c:509:53: error: 'struct acpi_device' has no member named 'node'; did you mean 'fwnode'?
>   509 |         list_for_each_entry(child, &adev->children, node) {
>       |                                                     ^~~~
> include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
>    78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>       |                                                        ^~~~
> include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
>    19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>       |         ^~~~~~~~~~~~~
> include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
>    20 |                       __same_type(*(ptr), void),                        \
>       |                       ^~~~~~~~~~~
> include/linux/list.h:520:9: note: in expansion of macro 'container_of'
>   520 |         container_of(ptr, type, member)
>       |         ^~~~~~~~~~~~
> include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
>   564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
>       |         ^~~~~~~~~~
> include/linux/list.h:676:20: note: in expansion of macro 'list_next_entry'
>   676 |              pos = list_next_entry(pos, member))
>       |                    ^~~~~~~~~~~~~~~
> drivers/bus/hisi_lpc.c:509:9: note: in expansion of macro 'list_for_each_entry'
>   509 |         list_for_each_entry(child, &adev->children, node) {
>       |         ^~~~~~~~~~~~~~~~~~~
> include/linux/compiler_types.h:293:27: error: expression in static assertion is not an integer
>   293 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
>       |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
>    78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>       |                                                        ^~~~
> include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
>    19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>       |         ^~~~~~~~~~~~~
> include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
>    19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>       |                       ^~~~~~~~~~~
> include/linux/list.h:520:9: note: in expansion of macro 'container_of'
>   520 |         container_of(ptr, type, member)
>       |         ^~~~~~~~~~~~
> include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
>   564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
>       |         ^~~~~~~~~~
> include/linux/list.h:676:20: note: in expansion of macro 'list_next_entry'
>   676 |              pos = list_next_entry(pos, member))
>       |                    ^~~~~~~~~~~~~~~
> drivers/bus/hisi_lpc.c:509:9: note: in expansion of macro 'list_for_each_entry'
>   509 |         list_for_each_entry(child, &adev->children, node) {
>       |         ^~~~~~~~~~~~~~~~~~~
> In file included from include/uapi/linux/posix_types.h:5,
>                  from include/uapi/linux/types.h:14,
>                  from include/linux/types.h:6,
>                  from include/linux/kasan-checks.h:5,
>                  from include/asm-generic/rwonce.h:26,
>                  from ./arch/x86/include/generated/asm/rwonce.h:1,
>                  from include/linux/compiler.h:248,
>                  from include/linux/build_bug.h:5,
>                  from include/linux/bits.h:22,
>                  from include/linux/ioport.h:13,
>                  from include/linux/acpi.h:12,
>                  from drivers/bus/hisi_lpc.c:9:
> drivers/bus/hisi_lpc.c:509:53: error: 'struct acpi_device' has no member named 'node'; did you mean 'fwnode'?
>   509 |         list_for_each_entry(child, &adev->children, node) {
>       |                                                     ^~~~
> include/linux/stddef.h:16:58: note: in definition of macro 'offsetof'
>    16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
>       |                                                          ^~~~~~
> include/linux/list.h:520:9: note: in expansion of macro 'container_of'
>   520 |         container_of(ptr, type, member)
>       |         ^~~~~~~~~~~~
> include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
>   564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
>       |         ^~~~~~~~~~
> include/linux/list.h:676:20: note: in expansion of macro 'list_next_entry'
>   676 |              pos = list_next_entry(pos, member))
>       |                    ^~~~~~~~~~~~~~~
> drivers/bus/hisi_lpc.c:509:9: note: in expansion of macro 'list_for_each_entry'
>   509 |         list_for_each_entry(child, &adev->children, node) {
>       |         ^~~~~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>   647590eb6f34 ("ACPI: bus: Drop unused list heads from struct acpi_device")
> 
> I have used the pm tree from next-20220628 for today.

Thanks for the report, should be addressed now.

Cheers,
Rafael



