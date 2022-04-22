Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D2850C070
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 21:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiDVTff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 15:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiDVTf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 15:35:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5A72715FB;
        Fri, 22 Apr 2022 12:13:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAC5C61772;
        Fri, 22 Apr 2022 19:01:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4CA2C385A0;
        Fri, 22 Apr 2022 19:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650654077;
        bh=IppT2R5TmZBgoejAuAjih5UgAJJvNanNsyybwMJzd5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fi6U9+IDQcTBxm+CXXQsZtee8+hWCRJ2lBwOi/utPqHiwVoNC3jg+eFCDsDJh7SrC
         I5rz7bKmFt8Fp/ieoYCYEMpUeWMPAWcgWGCdO48gckmz/EXAFO/AwaZvv9Pe1qYU23
         in0x9QlG2A198XJKZY5G9pbZWIHWCbv4727wa6+LITX0p0VWkFD2UhMFomRuu+cq87
         aIlADhdG9f1py1ctOiM1BYNW3ZaW08d8nWZ0bINTh02KuaLqj1cgqZ63So9WOaHwDe
         1rUq0ZLBS7AC5YHvDMWMxAgTaw9IiToqwv6P0BpCXKOueNrvDHhk2yhXOohgxkTCQu
         GovpyAwYd13DQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AA394400B1; Fri, 22 Apr 2022 16:01:13 -0300 (-03)
Date:   Fri, 22 Apr 2022 16:01:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Matt Turner <mattst88@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        linux-perf-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jelle van der Waa <jvanderwaa@redhat.com>
Subject: Re: [PATCH] tools: port perf ui from GTK 2 to GTK 3
Message-ID: <YmL7eQBtPHQn0GcD@kernel.org>
References: <20220415050003.3257645-1-mattst88@gmail.com>
 <YmA+DyEZJr1Eb8TA@kernel.org>
 <CAEdQ38Ec8mWkoy7hDE1ew6vEtXmEMSWp6u2HBzqdqtCBX3jTtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEdQ38Ec8mWkoy7hDE1ew6vEtXmEMSWp6u2HBzqdqtCBX3jTtA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 21, 2022 at 02:02:49PM -0700, Matt Turner escreveu:
> On Wed, Apr 20, 2022 at 10:08 AM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Thu, Apr 14, 2022 at 10:00:03PM -0700, Matt Turner escreveu:
> > > From: Jelle van der Waa <jvanderwaa@redhat.com>
> > >
> > > GTK 2 is a legacy API and the newer version is GTK 3 which changes a few
> > > API functions. gtk_tree_view_set_rules_hint is no longer required since
> > > theme's are now responsible to handle this, gtk_vbox_new is deprecated
> > > and replaced by passing the orientation to gtk_box_new. Apart from these
> > > changes the accessing of the screen changed in GTK which requires using
> > > new functions for getting geometry. Lastly the GTK_STOCK_OK define is
> > > deprecated in GTK 3.
> > >
> > > Signed-off-by: Jelle van der Waa <jvanderwaa@redhat.com>
> > > Signed-off-by: Matt Turner <mattst88@gmail.com>
> > > ---
> > > Originally sent in 2019. I've rebased it and given it a test.
> > >
> > > One problem I've noticed is that C++ symbol names are often broken.
> > > E.g.:
> > >
> > > (perf:3254940): Gtk-WARNING **: 21:47:46.663: Failed to set text from
> > > markup due to error parsing markup: Error on line 1 char 95:
> > > “std::char_traits<char” is not a valid name: “<”
> > >
> > > Presumably we need to call g_markup_escape_text() somewhere, but I
> > > struggled to find the right place.
> > >
> > > Without the patch, the GTK-2 version repeatedly segfaults, so this is an
> > > improvement regardless.
> >
> > I'm trying to test build this but failing:
> >
> > 1. uninstalled gtk2-devel, which removed several other packages
> >
> > 2. installed gtk3-devel, which installed several other packages
> >
> > 3.:
> >
> > Auto-detecting system features:
> > ...                         dwarf: [ on  ]
> > ...            dwarf_getlocations: [ on  ]
> > ...                         glibc: [ on  ]
> > ...                          gtk3: [ OFF ]
> > ...                        libbfd: [ on  ]
> > ...                libbfd-buildid: [ on  ]
> >
> > Looking at how that OFF is deduced:
> >
> > ⬢[acme@toolbox perf]$ cat /tmp/build/perf/feature/test-
> > Display all 150 possibilities? (y or n)
> > ⬢[acme@toolbox perf]$ cat /tmp/build/perf/feature/test-all.make.output
> > In file included from test-all.c:74:
> > test-gtk3.c:3:10: fatal error: gtk/gtk.h: No such file or directory
> >     3 | #include <gtk/gtk.h>
> >       |          ^~~~~~~~~~~
> > compilation terminated.
> > ⬢[acme@toolbox perf]$
> >
> > ⬢[acme@toolbox perf]$ find /usr/include -name gtk.h
> > /usr/include/gtk-3.0/gtk/gtk.h
> > ⬢[acme@toolbox perf]$ rpm -qf /usr/include/gtk-3.0/gtk/gtk.h
> > gtk3-devel-3.24.31-2.fc35.x86_64
> > ⬢[acme@toolbox perf]$
> >
> > And that pkg-config line produces:
> >
> > ⬢[acme@toolbox perf]$ pkg-config --libs --cflags gtk+-3.0
> > -I/usr/include/gtk-3.0 -I/usr/include/pango-1.0 -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/include/sysprof-4 -I/usr/include/harfbuzz -I/usr/include/freetype2 -I/usr/include/libpng16 -I/usr/include/libmount -I/usr/include/blkid -I/usr/include/fribidi -I/usr/include/libxml2 -I/usr/include/cairo -I/usr/include/pixman-1 -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/gio-unix-2.0 -I/usr/include/cloudproviders -I/usr/include/atk-1.0 -I/usr/include/at-spi2-atk/2.0 -I/usr/include/dbus-1.0 -I/usr/lib64/dbus-1.0/include -I/usr/include/at-spi-2.0 -pthread -lgtk-3 -lgdk-3 -lz -lpangocairo-1.0 -lpango-1.0 -lharfbuzz -latk-1.0 -lcairo-gobject -lcairo -lgdk_pixbuf-2.0 -lgio-2.0 -lgobject-2.0 -lglib-2.0
> > ⬢[acme@toolbox perf]$
> >
> > I'm testing this on fedora 35 silverblue, in a perf build container:
> >
> > ⬢[acme@toolbox perf]$ rpm -qa | grep gtk
> > gtk-update-icon-cache-3.24.31-2.fc35.x86_64
> > libcanberra-gtk3-0.30-27.fc35.x86_64
> > gtk3-3.24.31-2.fc35.x86_64
> > libcanberra-gtk2-0.30-27.fc35.x86_64
> > gtk2-2.24.33-7.fc35.x86_64
> > gtk3-devel-3.24.31-2.fc35.x86_64
> > ⬢[acme@toolbox perf]$
> >
> > Ideas?
> 
> Just to be clear, are you building with 'GTK3=1 make'? Since commit

No, I'm not, as I first test without enabling it, and in that case
test-all.c is now failing, since these lines were added there:

diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 5ffafb967b6e..5ec093498cfc 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -70,6 +70,14 @@
 # include "test-libslang.c"
 #undef main

+#define main main_test_gtk3
+# include "test-gtk3.c"
+#undef main
+
+#define main main_test_gtk3_infobar
+# include "test-gtk3-infobar.c"
+#undef main
+
 #define main main_test_libbfd
 # include "test-libbfd.c"
 #undef main
@@ -187,6 +195,8 @@ int main(int argc, char *argv[])
        main_test_libelf_getshdrstrndx();
        main_test_libunwind();
        main_test_libslang();
+	main_test_gtk3(argc, argv);
+	main_test_gtk3_infobar(argc, argv);
        main_test_libbfd();
        main_test_libbfd_buildid();
        main_test_backtrace();
diff --git a/tools/build/feature/test-gtk2-infobar.c b/tools/build/feature/test-gtk3-infobar.c

------------

test-all.c is what we expect to be enabled in most places, i.e. that it
will build successfully and we then don't have to test the features one
by one, speeding up the process.

So please don't add those entries in tools/build/feature/test-all.c.

After the common case is tested and doesn't regress, we can move on to
test with explicitely enabling the GTK code, ok?

- Arnaldo


> 4751bddd3f98 ("perf tools: Make GTK2 support opt-in") it's required to
> enable GTK support explicitly. (IMO, leaving it disabled by default
> makes sense to me, given some of the problems)
