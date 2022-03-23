Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C0C4E5AAA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 22:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344938AbiCWV34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 17:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344918AbiCWV3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 17:29:52 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C93D62EC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 14:28:20 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id d10so5416066eje.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 14:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oST6RpSoSVkvtf09PepVtLeECItCPWxr8nDjd3/DpMQ=;
        b=Ics1u5XDqi0UJDJDmeIlKXLuZB5F7gW26qthpxbaCCSbhKXGlzIM0zxVxc/smjNJ5Y
         Zg6TWAnxLvBx8cmqIephr3r1iv2PaP7esq0t9tU3DxKqdm65W/DwNgfIHDbKhdkMd+SN
         y0t8GiglvJz5MJ6A+mLPLDHIHpN8PQda9zy0ks/VluG8P17yySn5cSQhQ0SUwzTZ5+av
         W2qIWTmuoDqSscgC+ZaIISVcL7UJ8kot0yuDiok3msT/xmSJvLbM5i813rDDmTNio2hQ
         f1Uv4rpr5RMvj11stzib9aVheRjw/ZSXthx1GnUIFW8VR+ouvXcM6u9mT2YV+fRQwDcV
         lZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oST6RpSoSVkvtf09PepVtLeECItCPWxr8nDjd3/DpMQ=;
        b=o9S6k6hwRMqj3Es7FeOzbzIBXwv/xA7GcCiB5w2IBjppYdQeuVAMRzAxRz2TiIorcm
         8tSJm9z+fMlzTg8Y0WEzDJ9qeYv7uQCxwJYRSEbMiwDbNsb3tAj9aZLsHmZaxd0jZOo4
         5xE0VT7R+bo87+j5YQz2FLCWF5q4ZfWHRXMrEjqMWwVMcGjXsXCHQk3GzDQY7JRp8e5b
         xBz6hHyB81FdH9JFTuRw4rhcaglP464woIV6PNVbBZXf+WbrGg9gU+8zhL3pJtAVEmWh
         EiKt0GIFXllwd51upbmCCVYZcIQMUNgDTCkcHaebR2/QJZv7Gq0f/aO41soaxta4KyLK
         Zeqw==
X-Gm-Message-State: AOAM530BrFnudPRQXkIxdZVZtRwrEwBDm7p0aHFzKqViLODxEaWzRmKP
        P3jSHRNKFTl0Ry6G5DakRI8LjRGBlOSNvFm4hKTx2g==
X-Google-Smtp-Source: ABdhPJyyPp0iySvftA7MoPNQr7PzbQCh8uZXCcXySNRUtVnrBQ9b2nhikXkX/HGgaFdzOS63L7AEDmE0+eOEgD1eJEg=
X-Received: by 2002:a17:906:d54d:b0:6e0:1f9b:5064 with SMTP id
 cr13-20020a170906d54d00b006e01f9b5064mr2261273ejc.59.1648070898651; Wed, 23
 Mar 2022 14:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220224192036.2388302-1-dlatypov@google.com> <20220224192036.2388302-3-dlatypov@google.com>
In-Reply-To: <20220224192036.2388302-3-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 23 Mar 2022 17:28:07 -0400
Message-ID: <CAFd5g45axw5WS5+koAA75xV2BjWDzQ5G0793Yj6Jp0cMc4Wntg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] kunit: tool: properly report the used arch for
 --json, or '' if not known
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Feb 24, 2022 at 2:21 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Before, kunit.py always printed "arch": "UM" in its json output, but...
> 1. With `kunit.py parse`, we could be parsing output from anywhere, so
>     we can't say that.
> 2. Capitalizing it is probably wrong, as it's `ARCH=um`
> 3. Commit 87c9c1631788 ("kunit: tool: add support for QEMU") made it so
>    kunit.py could knowingly run a different arch, yet we'd still always
>    claim "UM".
>
> This patch addresses all of those. E.g.
>
> 1.
> $ ./tools/testing/kunit/kunit.py parse .kunit/test.log --json | grep -o '"arch.*' | sort -u
> "arch": "",
>
> 2.
> $ ./tools/testing/kunit/kunit.py run --json | ...
> "arch": "um",
>
> 3.
> $ ./tools/testing/kunit/kunit.py run --json --arch=x86_64 | ...
> "arch": "x86_64",
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
