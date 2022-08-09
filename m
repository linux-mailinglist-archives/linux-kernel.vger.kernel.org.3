Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9714D58D68B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 11:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbiHIJaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 05:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiHIJaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 05:30:06 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C8921833;
        Tue,  9 Aug 2022 02:30:04 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id z7so2898407qki.11;
        Tue, 09 Aug 2022 02:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=IMEsEkeIzl5mc4s3WZOfxqvZFzh93UZrDn7d1Z2Bbs8=;
        b=Fwjaob85D5IYbgbrIzYXkkLcotbyL/YY63Ji6UUke4YS1yFVsWbwRuEPt5/tySiWaA
         7tt0nhT7KNSOZ/VYv2TRZp4Qv2qn+votkBXMd9lccdCjibBPOSzcCKuSxGOGsG1jgntF
         iqBoC4cWs2p1ElOt3fdPW07mb/TmAkgT5mN76bW4WgZRYw0BSmkfOlMLITsj9uHJG6CK
         ZhDxkO7MOTdvIWzJEePhKPNHz9rMkrIXoeAkqZjzva817Btvo3ymZBTaeOo3k77do+5o
         FsIu//kScAdvyTh7fXpwcgyHmVwKe7zimkBAh6O9paUqrwglDT7Uf9h/wnsqP7wto673
         dKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=IMEsEkeIzl5mc4s3WZOfxqvZFzh93UZrDn7d1Z2Bbs8=;
        b=mssj7qRH61akZecCnXWrkKofLq4lcWtknvfC5JBOKKLqjvXHu5e76i9mqpFHYg52+E
         j2/QyAyGkP5OCUwTnSevQgU3/IQ/VzCBkLrRS2xpzOWnhCMbZiCcoOUtKcW+nUoUVpEB
         3TJL9WL/Ww5mDDZomac0VScPjBa0YzIfhKWftZ4LmppxZo2o1YTZWtGE6Tdnb8hk1HmS
         M4AyOxoKod1h9R0RPVrh9UZiZpgKFvhTq9WYqEmMcIb5e0Kq9e8mPK7e+rGGaiZaXw+b
         F/azbcoK9Tvi23e4NN/4C+qnsutVUoZbDZOMA8vtDl2AERJ5Kso8WfMbcvLg336Goos3
         JE9w==
X-Gm-Message-State: ACgBeo17aBDcnEDU9R6mYYG60blYcKE+YAlNBycgUoWJRFt7FQPS5yZ0
        mQlqZSF+QrnJUY4Ze9jpW7oxf9lMMpk9ueqaZx8=
X-Google-Smtp-Source: AA6agR5YOdAsoC+TZUyB2eCamLnnjl85X7jlTpQKCPkrqjim6L/00bZxZRUQtNP9DtrVOGqMN4EV6bidyDDA5PwUpAs=
X-Received: by 2002:a05:620a:2809:b0:6b6:5908:316e with SMTP id
 f9-20020a05620a280900b006b65908316emr17288256qkp.734.1660037404020; Tue, 09
 Aug 2022 02:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220809025054.1626339-1-luke@ljones.dev> <20220809025054.1626339-2-luke@ljones.dev>
 <CAHp75VfZeuuQjfM+CY4nxrFJQcfpdHVVzyj6GLjeweT3ycSn5A@mail.gmail.com> <AHBCGR.7I4U7CDRZ3J83@ljones.dev>
In-Reply-To: <AHBCGR.7I4U7CDRZ3J83@ljones.dev>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Aug 2022 11:29:27 +0200
Message-ID: <CAHp75VepmbLv1cx2cS6gbe_prs+cHZ0DYjJNkcuOXxeJaCqDGw@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] asus-wmi: Implement TUF laptop keyboard RGB control
To:     Luke Jones <luke@ljones.dev>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URI_DOTEDU autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 9, 2022 at 10:56 AM Luke Jones <luke@ljones.dev> wrote:
> On Tue, Aug 9 2022 at 10:46:33 +0200, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, Aug 9, 2022 at 4:51 AM Luke D. Jones <luke@ljones.dev> wrote:

...

> >>  +       err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS,
> >> ASUS_WMI_DEVID_TUF_RGB_MODE,
> >>  +                               rgb->save | (rgb->mode << 8) | (r
> >> << 16) | (g << 24),
> >>  +                               (b) | (rgb->speed << 8),
> >
> > Too many parentheses.
>
> Uh, yeah. I was unable to find concrete info on this. I at one point
> experienced an issue where the order of operations *without*
> parentheses ended up as "x | y << (8 | z) << 16". But now I'm not even
> sure if I remember that correctly. I see the order here
> https://www.cs.uic.edu/~i109/Notes/COperatorPrecedenceTable.pdf
>
> I'll do as said and test it to be certain.

I'm talking about the '(b)' part. The rest is okay to me.

-- 
With Best Regards,
Andy Shevchenko
