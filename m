Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C5B4E2F2D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 18:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349600AbiCURjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 13:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349578AbiCURjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:39:13 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BBF18C0C5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:37:47 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id pv16so31414734ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n0Cyy6sE5ez/LBL91UzE7qo7B4HGwRn4htwPLu7D43w=;
        b=BDbvDD5rAsVlZQodi9IiKxV9I9qo942+X+0lVAzpxFmUB9W3HcGau4/NqeDwN0AnzY
         3QzjOfDjYNQXn59QGxEtrU4B94ADELaKYZ0kqm3u7WPw2hHas36P0XJSUSXtwIP4kB/J
         w+q1l/dGYFZ8+BzuswafySc2VMUyUS84XyEm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n0Cyy6sE5ez/LBL91UzE7qo7B4HGwRn4htwPLu7D43w=;
        b=Mv8bFfzg3KQUYrXzgpCYnc//tTrmr+6H0L+5zLeht1oX9vZiGwAREQBEOLAOeg/4U9
         GI/rmuBvcXuaJGsag8k8Y6dxisBsAV6LfTEgEm8zwZZZohc39XzH4l25SpgsorVZrBNp
         Gvvo/962yieDtAikOJ6016bogHzVZM8Un5Nepn6xybhl2/CidNTMAbxHy9fdriUJ1IAE
         NhcMxbAYZ+Z17YYp5QYXUiKmz6TxNEloXNOCBcVRUHAmiBxwj3WM09YnmHd3nWrQ5OX1
         THSM9XHcGlJJBFweP7YynKM3L03lEowgJ8nNh38jyfSZyXEL2dnLIIWINKSOTth1rKiJ
         UFEg==
X-Gm-Message-State: AOAM532KquEAoges0AGQTsMRSIC1mSeV+hApWn/jdh9RUr3jgN1ac2xD
        wR+E+bx7AYeJOwUB0ncKil9dIFzdsJq8eyMnR8JK/Q==
X-Google-Smtp-Source: ABdhPJwMV+aKnppISSLu5O+KrQJbuTxl6FDfrgq3AN2QcTU+OqBr39t1xc+513T3CjLB65wX67CO5qywru2NKUTU688=
X-Received: by 2002:a17:907:6d9e:b0:6df:bb09:10eb with SMTP id
 sb30-20020a1709076d9e00b006dfbb0910ebmr14743292ejc.409.1647884265650; Mon, 21
 Mar 2022 10:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220321115913.478505-1-mic@digikod.net>
In-Reply-To: <20220321115913.478505-1-mic@digikod.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Mar 2022 10:37:34 -0700
Message-ID: <CAADWXX_06uyx5KLE-6pv6pqQJ5qH4EqYiYK7rGK3zMyEZjW4dw@mail.gmail.com>
Subject: Re: [GIT PULL] Landlock fixes for v5.18
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Christian Brauner <brauner@kernel.org>, Tom Rix <trix@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 4:58 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
>
> Please pull these Landlock updates for v5.18-rc1 .

Micka=C3=ABl, both your pull requests (this and the 'trusted_for(2)' one)
were marked as spam for me.

The reason seems to be that you're using a SMTP host that doesn't
actually do modern anti-spam measures (no DKIM), and while it does do
SPF, gmail really dislikes it.

There doesn't seem anything in particular standing out in the email
itself, so I suspect your hosting provider (seems to be infomaniak.ch)
ends up either being in a block of IP addresses that is also being
used for spam, or it's just allowing a lot of spam itself.

Some people think that gmail is being way too restrictive about these
kinds of things, but since I hate spam with a passion, I end up siding
with rather strict spam measures.. Honestly, if an email provider
doesn't do DKIM in this day and age, it's not a very good email
provider imho.

               Linus
