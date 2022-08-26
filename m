Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915645A2D5B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245617AbiHZRWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiHZRWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:22:05 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA46E1917;
        Fri, 26 Aug 2022 10:22:04 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q18so2190446ljg.12;
        Fri, 26 Aug 2022 10:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ffGSOF88X3uX2xbMrZKZt1dBqzZeMMBk6p+OyGT0PjQ=;
        b=nGazRBa11TFATnkRsBK/26sAKjlHVYjFCNfj702IE3sVVdyGzEQAGw7g1SPRSHb4br
         Q/myZC42xn6beqw7dIqMDscL4HcoM8YiGRW4T78zw9Ai6o+mFNoAU7wu5jJRSPnrPBhz
         4188eUpPQjNlpp9adYgbRcuA+FiPEZuhNR04b1Bi3PEXUlLYeHQrcV72DRSkDzrky4z1
         zECK5tx2h2yqiBCv0ppsQUK9uOI5ig7J2mJ+hYDnC5b3p29FS2fa5vB/QHMOJmEUPul5
         eUMw9gz95Ea5tvN0+J+zOqlZHt6hyagwksp4DdeTGBNT7Id0dV1zSC3KqKyS3mgQmABQ
         vwlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ffGSOF88X3uX2xbMrZKZt1dBqzZeMMBk6p+OyGT0PjQ=;
        b=Is+lfpl+RyBjNNUFmIZ8t4fWKUmFnNYMYcfreOopXQuMNHuL/Gk48yAr09sVnwv8f4
         W0OpUBzZ5dGc36OesxQt+YYz3eFBckuU/S2TN24NDDTaGHmN3rqfch5wmzAHrwKRRFAr
         2TY0U7hZniq1hrg39sDRLYCm9L2xf7iSjHrGLucL1ysx7n/EKxIrHsesRr6ktqj4YfgD
         7tumINyi1wEnxT+uqjdg2eM4npug3Sx+LBnhN842HQfaczg+M0we/Gs1hrynIKnZZuw0
         M+/avGgFMrWmVCevE5OVfPRsz5ljdrJ7Ag/+JVChn064nX0TCP8OW7OcEhTRrAJyGOe6
         Zikw==
X-Gm-Message-State: ACgBeo2DbzO/frmXbYw7RQfm8zqUCv9rI3lDAOs04WXg8aJ9Fupvxu/2
        RgpNRtAkp+PDyIDw2NhybnxaYwKv7L8VlAiKLeQ=
X-Google-Smtp-Source: AA6agR5y/N3p69sYfXuEB4tIK33dR8To4WCvyMPi3+slNwkuAmZ/bf84MuF3eY4XLxwKEPcjeJ1WPCtbX1W/G18287E=
X-Received: by 2002:a2e:a170:0:b0:261:e4e9:818e with SMTP id
 u16-20020a2ea170000000b00261e4e9818emr2868761ljl.168.1661534522170; Fri, 26
 Aug 2022 10:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <CABwm_eTnARC1GwMD-JF176k8WXU1Z0+H190mvXn61yr369qt6g@mail.gmail.com>
 <YwfYyLE3ajSFVHGQ@kernel.org>
In-Reply-To: <YwfYyLE3ajSFVHGQ@kernel.org>
From:   Zixuan Tan <tanzixuan.me@gmail.com>
Date:   Sat, 27 Aug 2022 01:21:50 +0800
Message-ID: <CABwm_eSvcnygceTU0sNXLkBFaNfEfrThFVmwH=TS4hN=HVGrGg@mail.gmail.com>
Subject: Re: [PATCH] perf/genelf: Switch deprecated openssl MD5_* functions to
 new EVP API
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 4:17 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Fri, Aug 26, 2022 at 01:00:58AM +0800, Zixuan Tan escreveu:
> > Switch to the flavored EVP API like in test-libcrypto.c, and remove the
> > bad gcc #pragma.
> >
> > Inspired-By: 5b245985a6de ("tools build: Switch to new openssl API for
> > test-libcrypto")
>
> How did you test the end result? Can you please describe step by step?
>
> Also please consider adding a 'perf test' entry to make sure this
> doesn't regress.

Sorry but I don't get what you mean, what results do I need to test?

These EVP_* APIs are just replacements for the deprecated MD5_* APIs in
openssl v3 [1][2]. With the same input, they produce the same MD5 digest.

And this patch just does the migration work for the upgrade and does not
change the logic of the code. so...what should I test?

Links:
[1] https://www.openssl.org/docs/man3.0/man3/MD5.html
[2] https://stackoverflow.com/questions/69806220/advice-needed-for-migration-of-low-level-openssl-api-to-high-level-openssl-apis

Thanks,
Zixuan

>
> Thanks,
>
> - Arnaldo
>
> > Signed-off-by: Zixuan Tan <tanzixuan.me@gmail.com>
> > ---
> >  tools/perf/util/genelf.c | 20 +++++++++++---------
> >  1 file changed, 11 insertions(+), 9 deletions(-)
> >
> > diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
> > index 953338b9e887..ed28a0dbcb7f 100644
> > --- a/tools/perf/util/genelf.c
> > +++ b/tools/perf/util/genelf.c
> > @@ -30,10 +30,6 @@
> >
> >  #define BUILD_ID_URANDOM /* different uuid for each run */
> >
> > -// FIXME, remove this and fix the deprecation warnings before its removed and
> > -// We'll break for good here...
> > -#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> > -
> >  #ifdef HAVE_LIBCRYPTO_SUPPORT
> >
> >  #define BUILD_ID_MD5
> > @@ -45,6 +41,7 @@
> >  #endif
> >
> >  #ifdef BUILD_ID_MD5
> > +#include <openssl/evp.h>
> >  #include <openssl/md5.h>
> >  #endif
> >  #endif
> > @@ -142,15 +139,20 @@ gen_build_id(struct buildid_note *note,
> >  static void
> >  gen_build_id(struct buildid_note *note, unsigned long load_addr,
> > const void *code, size_t csize)
> >  {
> > -       MD5_CTX context;
> > +       EVP_MD_CTX *mdctx;
> >
> >         if (sizeof(note->build_id) < 16)
> >                 errx(1, "build_id too small for MD5");
> >
> > -       MD5_Init(&context);
> > -       MD5_Update(&context, &load_addr, sizeof(load_addr));
> > -       MD5_Update(&context, code, csize);
> > -       MD5_Final((unsigned char *)note->build_id, &context);
> > +       mdctx = EVP_MD_CTX_new();
> > +       if (!mdctx)
> > +               errx(2, "failed to create EVP_MD_CTX");
> > +
> > +       EVP_DigestInit_ex(mdctx, EVP_md5(), NULL);
> > +       EVP_DigestUpdate(mdctx, &load_addr, sizeof(load_addr));
> > +       EVP_DigestUpdate(mdctx, code, csize);
> > +       EVP_DigestFinal_ex(mdctx, (unsigned char *)note->build_id, NULL);
> > +       EVP_MD_CTX_free(mdctx);
> >  }
> >  #endif
> >
> > --
> > 2.34.1
>
> --
>
> - Arnaldo
