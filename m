Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9DF54E53D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 16:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376948AbiFPOov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 10:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbiFPOou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 10:44:50 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306ED3917A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 07:44:49 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v14so2179804wra.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 07:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aZrB3adH98zZgiXaq8Bh/9GJWNUDyfOL1k5/hjqAukY=;
        b=i7KdIrhqZdq6ZlMvRRYL6JqbqJtW+/N/SZB9K4+/MYCGxrYWeIriIbE86kg1pl0rMN
         RCUe624jCQwW36o/S+Ll1mlvj8GFzzMEExZX63UIsnVhROA8ZXzB/8+xDMt6QtiTtFMo
         3xKcZyau7piOLyjudAGwavEhIIF+g+xffLhG7AtZEmvtESzMzlVBRSqxxG+MkR+ZbFjS
         5BMl3ikDcuXVwDdmVkMLchBjQ8Oqr/GN+50rI8fYW+9f1uG63meRtT0CEKoFaqn4/0CQ
         d0IoRvwkQaxt0vtddiGgXqSbmdIsSbwMaXpnE4AISLFxJd0ITZwZKleop3v+MXNi/OWN
         fuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aZrB3adH98zZgiXaq8Bh/9GJWNUDyfOL1k5/hjqAukY=;
        b=lHf/5+q2R72htMW1sx/nh3XZnvIhtBDQTJNKryQZ8nlKLCzqL2RN86ChFwCTKJI4EA
         iCmeVdACY56c9M2QbRQKoWkHA9YMZx/ueANoh4M18MfaKnT8JHF3N4UUPJueQ93rnq0t
         70B/EwGEfyNnDgDzoxMiyCDo0MKrdGpejCKtTkNj6hHhel1ejs1F5aIstp04nEahRH2A
         BeWRe7N469n4tYHS9iFxifS32RZh5s8YjIAeLsmGFHyP7ZR+EDKGQPVIof1flruGBL8o
         qEuGMMFt9P6kh9/VTs6K9xQQFwz+LzcvOCcS0jz4GgHUzfruw+QO94xxG0e+cWhXLBH4
         qG+g==
X-Gm-Message-State: AJIora+Lt3U4ZPFblN81X+KHzYycpku4lQrsw/4oB7Vszt3UAoNZKNjg
        MjMfo++G4tec931bc6/ujz0w88FPDMKfL6OldFTsQQ==
X-Google-Smtp-Source: AGRyM1uNGC1zkDykBzIAEnHz1xG3XXKqONvzJxyE5WBpt+GrhUUUJ3azHm2m+15Ro8lnIo+h/CB5CZZaZaZHpWYltUA=
X-Received: by 2002:a5d:648e:0:b0:217:d2cb:d6b2 with SMTP id
 o14-20020a5d648e000000b00217d2cbd6b2mr4912385wri.433.1655390687611; Thu, 16
 Jun 2022 07:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220613171738.111013-1-jose.exposito89@gmail.com>
In-Reply-To: <20220613171738.111013-1-jose.exposito89@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 16 Jun 2022 22:44:36 +0800
Message-ID: <CABVgOSn3zAGsphdEpuevhTo1xoYqHWNF4qty=gR22LcRiUkz0A@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] KUnit tests for drm_format_helper
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Latypov <dlatypov@google.com>, tzimmermann@suse.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        dri-devel@lists.freedesktop.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 1:17 AM Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gm=
ail.com> wrote:
>
> Hello everyone,
>
> Here is the v3 of the series, including the documentation, previously
> sent as a standalone patch [1], and changes suggested during review.
>
> Thanks a lot,
> Jos=C3=A9 Exp=C3=B3sito
>

[+Ma=C3=ADra, Isabella, Tales, Magali for other drm,amdgpu,KUnit work.]

These seem pretty good to me, but I'd echo Javier's comments about
consistency with other DRM tests.

In particular, we now have three concurrently developed DRM-related
test suites, each doing things slightly differently:
- This series is putting tests in drm/kunit, and providing a
.kunitconfig in that directory,
- The selftest ports here[1] are putting tests in drm/tests, and
provide a separate Kconfig file, as well as a .kunitconfig
- And the AMDGPU tests[2] are doing something totally different, with
their own tests in drm/amd/display/amdgpu_dm/tests, which get compiled
directly into the amdgpu module (and, at present, can't be run at all
via kunit_tool)

Certainly the general DRM tests should be in the same place, and use
the same Kconfig entries, etc. A mix of the separate Kconfig file from
[1] (if there's enough benefit to having the ability to turn on and
off suites individually, which seems plausible) and the documentation
from this series seems good to me.

There's some basic guidelines around test nomenclature in
Documentation/dev-tools/kunit/style.rst[3], though all of these
patches seem pretty consistent with that. Either 'kunit' or 'tests'
would work as a directory name: given the AMDGPU patches are using
'tests', maybe that's easier to stick with.

Cheers,
-- David

[1]: https://lore.kernel.org/linux-kselftest/20220615135824.15522-1-maira.c=
anal@usp.br/
[2]: https://lore.kernel.org/dri-devel/20220608010709.272962-1-maira.canal@=
usp.br/
[3]: https://www.kernel.org/doc/html/latest/dev-tools/kunit/style.html
