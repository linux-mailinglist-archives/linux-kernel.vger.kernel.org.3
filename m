Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44B55B08E5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiIGPng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 11:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiIGPnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:43:33 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4C49E2D5
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 08:43:30 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-127ba06d03fso13422838fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 08:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ts8sD/IHVRi9k1jlgev4IpnFvduczDySAkqNIh9sCNA=;
        b=ZFzHmP4gyBWljJarZlRpu44+Pdi+JKXqO/0pufgx2cv1qQeVP7usq2OgS/NkxEm1ll
         glxywrekpB3t22xSgkeC2+74lMc0DvIjfsghlhRqrUpKFjNZ/WvnPdUt5W4f6kUFOxqG
         O3CRZ5x0hNwfl4ZNqQsRURuOEUDrHZ4CGeFQYUCVUYUgYI+c58K5Vi4+4xLWdGg/h2On
         JgKQ6nlp4x5DIq/rMfAnjKLJvUZkQSSKUaLg27XJc2cW0RJQzj6n6IA3Da4N6aZM1lVL
         PMX4EmHIseF9Z7eC8jiD6w3FTljr0Xfmk5IK8emS2Wmt8WSrIJkS+dRM0vWvs8W3G65o
         8gKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ts8sD/IHVRi9k1jlgev4IpnFvduczDySAkqNIh9sCNA=;
        b=J9eM1Ykx17ZTKSIliMJrCL48Y3PlnU4zwXMUSu+V96nw8jR1hjYEy6N4FMdb+BuuJn
         vUvnNbDEPS/35jJDpILAn2U53F2LiKhrFr4fQEbFVMWeq7USoCeuHqDqIa3szJAeoZzG
         B9OlyUnkQDu5XUPl/v6FUMB0JEk6sVyURyTtVl2OqCUC8ZE1/7GXobLgbDbGRT3vgvw2
         OxsyUE0nVdNdlLP2NueO4Pgx8xc1Rv6yeS4K/AvMMCZmcm5RX1OCckWKaHePzpmBuGmL
         qSskgllpWrCZecgPoDm4vgCxMfGsn8NBHq8ZVfE+4bhyZXJPkF9QrO5GuDI2sgcZ3QE/
         RxAA==
X-Gm-Message-State: ACgBeo34EVzd7mIkaNHrQeGSuqUS65TFrRQamR7Xj7ZNxuANkFtHHr7F
        cQv63OLZj8UIfZnCMpIaMQonFqisQAsKodwSAH40+XD7ZA==
X-Google-Smtp-Source: AA6agR6CsNX5pCAqd4MaFpekC59h+BsiSmuZ8ycl+hLYfqJYWrzqBDDG02upFEfnosFFzJPjemisB1neBKzVTee58aY=
X-Received: by 2002:a05:6808:3a9:b0:343:4b14:ccce with SMTP id
 n9-20020a05680803a900b003434b14cccemr12565813oie.41.1662565407848; Wed, 07
 Sep 2022 08:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220907121230.21252-1-vincenzo.frascino@arm.com> <f1cefdb9-363a-c938-f02a-851173431610@infradead.org>
In-Reply-To: <f1cefdb9-363a-c938-f02a-851173431610@infradead.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 7 Sep 2022 11:43:17 -0400
Message-ID: <CAHC9VhQytyFMvq-M0YrqzKxJDyj58KKG0XDjBfTV02sYCzeALQ@mail.gmail.com>
Subject: Re: [PATCH] security/keys: Remove inconsistent __user annotation
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 7, 2022 at 10:06 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 9/7/22 05:12, Vincenzo Frascino wrote:
> > The declaration of keyring_read does not match the definition
> > (security/keys/keyring.c). In this case the definition is correct
> > because it matches what defined in "struct key_type::read"
> > (linux/key-type.h).
> >
> > Fix the declaration removing the inconsistent __user annotation.
> >
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: James Morris <jmorris@namei.org>
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > ---
> > Note: This issue was discovered during the porting of the linux kernel
> > on Morello [1].
> >
> > [1] https://git.morello-project.org/morello/kernel/linux
>
> FTR, I have sent this same patch 3 times.
> Good luck.

David or Jarkko, this patch is both trivial and obviously correct,
please merge this into the keys tree for the next merge window else
I'll take it via the LSM tree.

Reviewed-by: Paul Moore <paul@paul-moore.com>

> >  security/keys/keyring.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/security/keys/keyring.c b/security/keys/keyring.c
> > index 5e6a90760753..4448758f643a 100644
> > --- a/security/keys/keyring.c
> > +++ b/security/keys/keyring.c
> > @@ -79,7 +79,7 @@ static void keyring_revoke(struct key *keyring);
> >  static void keyring_destroy(struct key *keyring);
> >  static void keyring_describe(const struct key *keyring, struct seq_file *m);
> >  static long keyring_read(const struct key *keyring,
> > -                      char __user *buffer, size_t buflen);
> > +                      char *buffer, size_t buflen);
> >
> >  struct key_type key_type_keyring = {
> >       .name           = "keyring",

-- 
paul-moore.com
