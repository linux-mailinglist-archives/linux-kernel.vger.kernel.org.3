Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B62150AA71
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 23:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441793AbiDUVFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 17:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239054AbiDUVFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 17:05:51 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F156550;
        Thu, 21 Apr 2022 14:03:01 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id h1so6072412pfv.12;
        Thu, 21 Apr 2022 14:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YbZbeehjOwa1zcwY7/oYQebGTo7GYWfHsvty5m0I7p4=;
        b=O+3vHyiX4W74H7N7GTRRSTCVSR8YtG23oXnZzh7AKsq0UYc5wq7iVhVJ0dq38fwKC5
         Q+iVqprnZ2mfFQvIJxv+doANHS5kX7z+wQKDGLeCqJfor6CIT9AJTgHQEK/u0Gez8NUT
         tJ5T5rx6uSiTzRwTcfYPGuAX9nkjRRpqi9WinPzU/y3QYyOlZPZOFCjA9tMGD8u+mwre
         GSijakJT7kJf8rYHD4gMX8G3zP0ZYwq5PdhteCrjVuiYf3KREk4Lpbzgw4GFI1PApEq9
         CgKMlGQH9IBG+GAkqZMg7tjNbnqv37RX1wj9pE9ZTTlE6bLSn7o7c5KLaENbASwkDzjW
         J2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YbZbeehjOwa1zcwY7/oYQebGTo7GYWfHsvty5m0I7p4=;
        b=1gf26iNwm6S0eFAzNAnKBF9WTjxTgTF2777EHC33KII6fbf6cd7NO/9mzK+j4oQTEj
         yEpm5ZRjFQ2euLxOwAQ7Xzi8ouVl604aG5b63x7y0/rsWC2bqop0umVwRzzzM7TJ5Q/8
         LAOOA52dMiei0b0sXG80ayNeUnfjRhj2//+K2oEOV2zMWX5x0yDOuLfMjbfzqGvpHd15
         IZL2I52cmXGPo1y/6D+XCgOa/q5tilDxJdSshEMQgR7UuKks/yx7E05oZ3oskJnO2VKL
         lqRES6IfxviF4/SlWyC4gKEniZt8HYJtYaKUNjSgls7s39UZO2smPpa4y5zXakTVPyYO
         Q1rQ==
X-Gm-Message-State: AOAM530OwBI4SNbdwf2KYMdkEYmaHksI7GQ/uYRQnddt1BB0e1vJRl8Q
        Vc2ENInfzZxT7zl6M/nUFWiQIvmZjF7v+XqGiLg=
X-Google-Smtp-Source: ABdhPJxp1M7qmfpyWXkSB2x+uDUtP7MA83fHYdjVtWi8W4pfLq1hF9eZzAQWErIBGlUwIylCwXjbDRnN/YIW33HYaX4=
X-Received: by 2002:a05:6a00:1a11:b0:50a:6c39:4c1f with SMTP id
 g17-20020a056a001a1100b0050a6c394c1fmr1305895pfv.55.1650574980514; Thu, 21
 Apr 2022 14:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220415050003.3257645-1-mattst88@gmail.com> <YmA+DyEZJr1Eb8TA@kernel.org>
In-Reply-To: <YmA+DyEZJr1Eb8TA@kernel.org>
From:   Matt Turner <mattst88@gmail.com>
Date:   Thu, 21 Apr 2022 14:02:49 -0700
Message-ID: <CAEdQ38Ec8mWkoy7hDE1ew6vEtXmEMSWp6u2HBzqdqtCBX3jTtA@mail.gmail.com>
Subject: Re: [PATCH] tools: port perf ui from GTK 2 to GTK 3
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     linux-perf-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jelle van der Waa <jvanderwaa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 10:08 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Thu, Apr 14, 2022 at 10:00:03PM -0700, Matt Turner escreveu:
> > From: Jelle van der Waa <jvanderwaa@redhat.com>
> >
> > GTK 2 is a legacy API and the newer version is GTK 3 which changes a fe=
w
> > API functions. gtk_tree_view_set_rules_hint is no longer required since
> > theme's are now responsible to handle this, gtk_vbox_new is deprecated
> > and replaced by passing the orientation to gtk_box_new. Apart from thes=
e
> > changes the accessing of the screen changed in GTK which requires using
> > new functions for getting geometry. Lastly the GTK_STOCK_OK define is
> > deprecated in GTK 3.
> >
> > Signed-off-by: Jelle van der Waa <jvanderwaa@redhat.com>
> > Signed-off-by: Matt Turner <mattst88@gmail.com>
> > ---
> > Originally sent in 2019. I've rebased it and given it a test.
> >
> > One problem I've noticed is that C++ symbol names are often broken.
> > E.g.:
> >
> > (perf:3254940): Gtk-WARNING **: 21:47:46.663: Failed to set text from
> > markup due to error parsing markup: Error on line 1 char 95:
> > =E2=80=9Cstd::char_traits<char=E2=80=9D is not a valid name: =E2=80=9C<=
=E2=80=9D
> >
> > Presumably we need to call g_markup_escape_text() somewhere, but I
> > struggled to find the right place.
> >
> > Without the patch, the GTK-2 version repeatedly segfaults, so this is a=
n
> > improvement regardless.
>
> I'm trying to test build this but failing:
>
> 1. uninstalled gtk2-devel, which removed several other packages
>
> 2. installed gtk3-devel, which installed several other packages
>
> 3.:
>
> Auto-detecting system features:
> ...                         dwarf: [ on  ]
> ...            dwarf_getlocations: [ on  ]
> ...                         glibc: [ on  ]
> ...                          gtk3: [ OFF ]
> ...                        libbfd: [ on  ]
> ...                libbfd-buildid: [ on  ]
>
> Looking at how that OFF is deduced:
>
> =E2=AC=A2[acme@toolbox perf]$ cat /tmp/build/perf/feature/test-
> Display all 150 possibilities? (y or n)
> =E2=AC=A2[acme@toolbox perf]$ cat /tmp/build/perf/feature/test-all.make.o=
utput
> In file included from test-all.c:74:
> test-gtk3.c:3:10: fatal error: gtk/gtk.h: No such file or directory
>     3 | #include <gtk/gtk.h>
>       |          ^~~~~~~~~~~
> compilation terminated.
> =E2=AC=A2[acme@toolbox perf]$
>
> =E2=AC=A2[acme@toolbox perf]$ find /usr/include -name gtk.h
> /usr/include/gtk-3.0/gtk/gtk.h
> =E2=AC=A2[acme@toolbox perf]$ rpm -qf /usr/include/gtk-3.0/gtk/gtk.h
> gtk3-devel-3.24.31-2.fc35.x86_64
> =E2=AC=A2[acme@toolbox perf]$
>
> And that pkg-config line produces:
>
> =E2=AC=A2[acme@toolbox perf]$ pkg-config --libs --cflags gtk+-3.0
> -I/usr/include/gtk-3.0 -I/usr/include/pango-1.0 -I/usr/include/glib-2.0 -=
I/usr/lib64/glib-2.0/include -I/usr/include/sysprof-4 -I/usr/include/harfbu=
zz -I/usr/include/freetype2 -I/usr/include/libpng16 -I/usr/include/libmount=
 -I/usr/include/blkid -I/usr/include/fribidi -I/usr/include/libxml2 -I/usr/=
include/cairo -I/usr/include/pixman-1 -I/usr/include/gdk-pixbuf-2.0 -I/usr/=
include/gio-unix-2.0 -I/usr/include/cloudproviders -I/usr/include/atk-1.0 -=
I/usr/include/at-spi2-atk/2.0 -I/usr/include/dbus-1.0 -I/usr/lib64/dbus-1.0=
/include -I/usr/include/at-spi-2.0 -pthread -lgtk-3 -lgdk-3 -lz -lpangocair=
o-1.0 -lpango-1.0 -lharfbuzz -latk-1.0 -lcairo-gobject -lcairo -lgdk_pixbuf=
-2.0 -lgio-2.0 -lgobject-2.0 -lglib-2.0
> =E2=AC=A2[acme@toolbox perf]$
>
> I'm testing this on fedora 35 silverblue, in a perf build container:
>
> =E2=AC=A2[acme@toolbox perf]$ rpm -qa | grep gtk
> gtk-update-icon-cache-3.24.31-2.fc35.x86_64
> libcanberra-gtk3-0.30-27.fc35.x86_64
> gtk3-3.24.31-2.fc35.x86_64
> libcanberra-gtk2-0.30-27.fc35.x86_64
> gtk2-2.24.33-7.fc35.x86_64
> gtk3-devel-3.24.31-2.fc35.x86_64
> =E2=AC=A2[acme@toolbox perf]$
>
> Ideas?

Just to be clear, are you building with 'GTK3=3D1 make'? Since commit
4751bddd3f98 ("perf tools: Make GTK2 support opt-in") it's required to
enable GTK support explicitly. (IMO, leaving it disabled by default
makes sense to me, given some of the problems)
