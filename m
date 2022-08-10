Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C1558F092
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbiHJQlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiHJQlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:41:47 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDAD5FF1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:41:45 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id e15so22089937lfs.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=IboOlRmkttx834Bl91hUxolhlCg7lfoSCMSCS2p/U0k=;
        b=IHIfCGGqkNbEP24ylvFw7WsvsOXR9bN3DKWRU/gGHfevmOOUx7Wmgl3UZ5XBLAmAAc
         8l30WDp+ajTAJ3AXbT1BYhjgIop+o6VtXEqFeLy3zjMrtj+cF4wBv9A4fh9Ul1KeHXrI
         c6nnrm9Ys+9Z0Cz9/jbBxzrE93uCAnvVeD15H2oV19A66UH1MmBGRAsE6piRmmvF+FH3
         8L6ARDFbnfjMU1UOQV5d+8PUcOqJvZFTF/AMQez8MhJr3uySjEh4wJUhWDcXN+u+/nAj
         dZDk6swzcgt89/iIVoddm+yLaLZgDlFOA6OzicnmlkeYOoeJGbdSikVH6M7kErVKpcQv
         /dYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=IboOlRmkttx834Bl91hUxolhlCg7lfoSCMSCS2p/U0k=;
        b=2u3E1Fs6CWm85cZk1mwKj460YRxHL/gn2zeNoKjOY5nONVC9tI0ixULzCw5TMttfbU
         klWoddgPhF17RA+vHpQQNhwxgJiek7qW9UAOQJ/Ro+86QLtj3gchGxrx8IexAcEymd7S
         2XpKKMv3KGoZuizvk3wImOoCT5C8zTz+TG3MGmhL2Vhh7XxgtSE670nqsvdk9EB22sNv
         viKKO6pjcrukw5JnzzorO+4QI7hGwiCfsg1fehbAeyN045LHSnMgxze4WkgyqeOOMI+X
         sNOO08KVNDH5kW2OpoDyoXnqi+yhWruGoQxILYJ0vyVu9dMJBU5NT0tzo9AqAEm/+vuV
         Fqhg==
X-Gm-Message-State: ACgBeo0UB6nX0RH3rduYOP3J3ArSao5ggATSU4sDu1JX6iJQ1Rwh2AJZ
        NPf+pA6u6SkaSB1l/SjLdxB+wibK3eCTBQAwJqxOHqgtbJbsPw==
X-Google-Smtp-Source: AA6agR7WOzfuKIJOAsH+/Ea7ziF0uJfqoTF8MsUll/UBw5AXR9ENEiQu36r7CNYitAm+4Jj6oSj6WL6ZDT1kyS+uuh0=
X-Received: by 2002:a17:907:3e21:b0:730:92bb:7fcd with SMTP id
 hp33-20020a1709073e2100b0073092bb7fcdmr20734969ejc.170.1660149689636; Wed, 10
 Aug 2022 09:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220709115837.560877-1-jose.exposito89@gmail.com>
 <20220709115837.560877-5-jose.exposito89@gmail.com> <CABVgOSmhOBdXPH_=B_WRcUjMGC-wVPTLBwCdbgZLb0o3-O8pKw@mail.gmail.com>
 <20220717170054.GA1028249@elementary>
In-Reply-To: <20220717170054.GA1028249@elementary>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 10 Aug 2022 09:41:18 -0700
Message-ID: <CAGS_qxqqsLQ-aCfZHTJbYqb3e21hNSzobAmsZNN_QETXExwQ+A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_rgb565()
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     David Gow <davidgow@google.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        maarten.lankhorst@linux.intel.com,
        Jani Nikula <jani.nikula@linux.intel.com>,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, dri-devel@lists.freedesktop.org,
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

On Sun, Jul 17, 2022 at 10:01 AM Jos=C3=A9 Exp=C3=B3sito
<jose.exposito89@gmail.com> wrote:
>
> Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com> wrote:
> > I already fixed the warning and added the reviewed by tags, however, I
> > noticed that rebasing the series on the latest drm-misc-next show this
> > error:
> > [...]
>
> Sorry for the extra email. I forgot to mention that the error is only
> present in UML. Running in other architectures works as expected.
> Tested on x86_64 and PowerPC.

Can you take a look at the raw output?

It would be .kunit/test.log (or replace .kunit with w/e --build_dir
you're using).
You could also run the test with --raw_output to have kunit.py print
that out instead.
We might want to compare the output on UML vs x86 and see what looks suspic=
ious.

These errors
  [ERROR] Test: xrgb8888_to_rgb332_test: missing subtest result line!
means that kunit.py can't parse the KTAP output.

It could be that the output is mangled for some reason.
I recall running into a UML-specific issue with output mangling on an
old kernel fork. I doubt it's related to this one, but it shows that
it's possible there could be something going on.

-Daniel
