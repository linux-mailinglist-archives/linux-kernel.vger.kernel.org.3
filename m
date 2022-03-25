Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D5A4E6DDF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 06:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346498AbiCYFtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 01:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiCYFtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 01:49:22 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2350945AE1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 22:47:48 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id d10so13258723eje.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 22:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IIPeA1tJ94PqcWykm/GxEY5BfbD3GfcvNIJHv095RpQ=;
        b=j0bY711FKZqCakCCSWGLGkVheKqIiAX6WINZPGcs+KRdcIxp5dWWmJO4ffmYF8TGOr
         zd9BUxGqBVzCyb8b8XGvV9OH6ft/yoJBtCcm9/hNV5w1MCfwrC9mnx3Gi6cqC/02PvSQ
         M8DQIkAHvNzVZh1W5d91/S+jdW/1AxBGdtQiOthv8Q4WH7z7Tr9S+jbCR0khFZ2mUdJa
         bgtrUCX95g+RTe3Gq7rfcEoyapmcrGNOK3I36RkvPZ7XMygbXNeII8xf+s3BpL2o/8R2
         KFXbfOcrPHgHt9ZxBNopEifvdzCQLk8QJIjiI3yWyhKXWjsLNAUxzi0FYdMz7krvxYbO
         nFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IIPeA1tJ94PqcWykm/GxEY5BfbD3GfcvNIJHv095RpQ=;
        b=aUgYR6rLZAEswfaVD+M0svK6jUR+RIksb1pH11m1FXfcqnXFDLwm0rQ375dKuQSAuh
         F5TyCo5nAVSGkdswMCyPUQkOXoNwalEJlx77LMgpTkgzo6w0TH3DK+zqR2dl6MddHNfy
         a53/dfi3VOp/EIbqbJIRjbkpUmBJsJXMIuWD8p83iJJnnMk0OZ5+N3eZn8JEPdH+bY3E
         PFLcBjotpNytyY7O2J1mRLF3AicSlP6DrfVJOnEm+eP3Zr7VUS1A2+jvuL1Ynpe2BYwe
         pKVw6h8Hw4S71XcIgIV+/lbMc5/PqnbN2NtTmulJ7IQ7e5REcYuv6QQbeI7GVisvLekf
         r2ug==
X-Gm-Message-State: AOAM533Bbcl4wdKeF+j8rLHXLcgWP38PJDlqbW837nPdy7YfUWGS0Hqx
        uoQxvpoErMWn7b3ov6cDz+4=
X-Google-Smtp-Source: ABdhPJx4Ba2xIS7ulrMXW6sy92xpxbFeL5dV3cRPBoXWezFmRRz284NFzWoFbBd93nf5ZHg6EQCiUg==
X-Received: by 2002:a17:906:5006:b0:6ce:3762:c72e with SMTP id s6-20020a170906500600b006ce3762c72emr9593631ejj.30.1648187266483;
        Thu, 24 Mar 2022 22:47:46 -0700 (PDT)
Received: from leap.localnet (host-95-249-145-232.retail.telecomitalia.it. [95.249.145.232])
        by smtp.gmail.com with ESMTPSA id h12-20020a1709060f4c00b006b4ec988cc3sm1886020ejj.4.2022.03.24.22.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 22:47:45 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     syzbot <syzbot+f8c45ccc7d5d45fc5965@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        Muchun Song <songmuchun@bytedance.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] general protection fault in list_lru_add
Date:   Fri, 25 Mar 2022 06:47:36 +0100
Message-ID: <12984828.uLZWGnKmhe@leap>
In-Reply-To: <CAHk-=whxaFX4nqnE-SLHTGKyqejvbrhYx5sagcxWd+UWCMf8dg@mail.gmail.com>
References: <CAMZfGtUr6V5pTrPhZukD2_KbB7BLPoKvF6H63HP4pykY36Ou9A@mail.gmail.com> <0000000000009901d505dafc07b3@google.com> <CAHk-=whxaFX4nqnE-SLHTGKyqejvbrhYx5sagcxWd+UWCMf8dg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On gioved=C3=AC 24 marzo 2022 20:45:00 CET Linus Torvalds wrote:
> On Thu, Mar 24, 2022 at 12:41 PM syzbot
> <syzbot+f8c45ccc7d5d45fc5965@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has tested the proposed patch and the reproducer did not trigger=
 any issue:
>=20
> Heh, well that's unfortunate.
>=20
> I think the issue is that it triggered a new BUG() that didn't match
> the previous NULL pointer dereference, so it thinks things are
> "fixed".
>=20
>              Linus
>=20
> --=20
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/CAHk-%3DwhxaFX4nqnE-SLHTGKyqejvbrhYx5sagcxWd%2BUWCMf8dg%40=
mail.gmail.com.
>=20

No, not at all, Linus!

Unless I'm still sleeping with wide open eyes (it's 6.30 AM here), you are =
misunderstanding=20
this message from Syzbot :)

This message means that Syzbot has applied and tested the patch and now is =
not=20
anymore able to trigger any bug. In summation it means that the patch works=
 properly.

Now Muchun should simply submit his patch (the usual way) with a "Fixes:" t=
ag=20
and with "Reported-and-tested-by: syzbot+f8c45ccc7d5d45fc5965@syzkaller.app=
spotmail.com".

Thanks,

=46abio M. De Francesco


