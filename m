Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC570493E4A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 17:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356115AbiASQ34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 11:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbiASQ3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 11:29:54 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2316C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 08:29:53 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id r3so2189385iln.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 08:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Tg/o9Q4Kbn+I0820wcP01USyhFKpxhXCCDd08r5ctiY=;
        b=CHZa9XKhvL4JtdhiGWaHO9wUILQlMegd6a44gX0MkYPusVedgHxEyuW+TH5shc5Sz4
         Qwx3i/6vFZQKJ46JFMV/n64kdKHMHcsiNPKAuITwqj+mf9WPVK0I+h9J340V9Dcpw8S2
         JOwrCUmoB1PxAv0mpOIJmZIje2I+TJ5iTVIvoSjls3hp9uab5O4aGQknaf8xEV+Gfv1M
         jFXMlAcrVOI7IEZ16JslwplYPPp2v3Gecm+tbETlZ+/sIHCJsGlgJ9GXDl55MaB6Ne4f
         vMWPV6F+1tIAtgUVdrbuH/irFiOT6tUwGucCYkkjaC9vPg1EMMSrOz1dVJVhXpy+ljTj
         YYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Tg/o9Q4Kbn+I0820wcP01USyhFKpxhXCCDd08r5ctiY=;
        b=yJwQrYS2zhx0pvvjK6EOTHwrrfvslgishdvtvDagH0ozdXV4xEw7sg8rnX/lW+zDFs
         Bq+zSiqVvTf0bQ6ME/m+6wri9a2Asdv47baOrA63TFmcOXVMTP0ueY99z1kcLKxvGRcU
         t3x5rNZ3R8izjrxfcoxwU6O8vl/LfeD0hbIn+3Znndvw9rwk5Is+oXi6qbTz2/6yvpzK
         buT+rZD0nZCYv80y2TIhkps9AkThxaycVxki5XiyJgEstUSqLmz2lv2h+i3ZjQ4VW6rl
         qjqRoErDq+TU8zrgKONFVYyQu5n9x5AjaEpehWDJ67HLhZLFEOH2P1RNbeCBZD9pR46+
         kJXA==
X-Gm-Message-State: AOAM5321ES1AbfUpYZ+2tWlsqWnpHFHyaEYAoZ1lfPk6Fa0fplCbS1tc
        LdjB4OXaSKJGY6eA9xeE5yJ/E+sueEEKLgTrXtrXpg==
X-Google-Smtp-Source: ABdhPJxpa3KneiA5a8oIkCm4YRbDLbdiTy/mB/l8XArAz2qyIY0AlhvUm9vlVu+sChGJdZNH0AlvXkaomY2szYbzVvQ=
X-Received: by 2002:a92:c9c8:: with SMTP id k8mr9105247ilq.2.1642609792961;
 Wed, 19 Jan 2022 08:29:52 -0800 (PST)
MIME-Version: 1.0
References: <YebZKjwgfdOz0lAs@kernel.org>
In-Reply-To: <YebZKjwgfdOz0lAs@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 19 Jan 2022 08:29:40 -0800
Message-ID: <CAP-5=fVGf70w6wXTHfh8M4eimkONvLdjrz=dmd9_P=oW0cTFrg@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf machine: Use path__join() to compose a path
 instead of snprintf(dir, '/', filename)
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 7:13 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Its more intention revealing, and if we're interested in the odd cases
> where this may end up truncating we can do debug checks at one
> centralized place.
>
> Motivation, of all the container builds, fedora rawhide started
> complaining of:
>
>   util/machine.c: In function =E2=80=98machine__create_modules=E2=80=99:
>   util/machine.c:1419:50: error: =E2=80=98%s=E2=80=99 directive output ma=
y be truncated writing up to 255 bytes into a region of size between 0 and =
4095 [-Werror=3Dformat-truncation=3D]
>    1419 |                 snprintf(path, sizeof(path), "%s/%s", dir_name,=
 dent->d_name);
>         |                                                  ^~
>   In file included from /usr/include/stdio.h:894,
>                    from util/branch.h:9,
>                    from util/callchain.h:8,
>                    from util/machine.c:7:
>   In function =E2=80=98snprintf=E2=80=99,
>       inlined from =E2=80=98maps__set_modules_path_dir=E2=80=99 at util/m=
achine.c:1419:3,
>       inlined from =E2=80=98machine__set_modules_path=E2=80=99 at util/ma=
chine.c:1473:9,
>       inlined from =E2=80=98machine__create_modules=E2=80=99 at util/mach=
ine.c:1519:7:
>   /usr/include/bits/stdio2.h:71:10: note: =E2=80=98__builtin___snprintf_c=
hk=E2=80=99 output between 2 and 4352 bytes into a destination of size 4096
>
> There are other places where we should use path__join(), but lets get rid=
 of
> this one first.

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/machine.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 3901440aeff92652..f70ba56912d4f9f8 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -16,6 +16,7 @@
>  #include "map_symbol.h"
>  #include "branch.h"
>  #include "mem-events.h"
> +#include "path.h"
>  #include "srcline.h"
>  #include "symbol.h"
>  #include "sort.h"
> @@ -1416,7 +1417,7 @@ static int maps__set_modules_path_dir(struct maps *=
maps, const char *dir_name, i
>                 struct stat st;
>
>                 /*sshfs might return bad dent->d_type, so we have to stat=
*/
> -               snprintf(path, sizeof(path), "%s/%s", dir_name, dent->d_n=
ame);
> +               path__join(path, sizeof(path), dir_name, dent->d_name);
>                 if (stat(path, &st))
>                         continue;
>
> --
> 2.34.1
>
