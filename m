Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A981B4EE4D8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 01:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243103AbiCaXlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 19:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240168AbiCaXlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 19:41:40 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D36F19D63D
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 16:39:51 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id i16so2369226ejk.12
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 16:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1rFOz+whygw87QqNdKIUe0mawCMOnyiKe/ajAaJwqQ0=;
        b=BkT+hohgrsNHQmrOE7TF1hF2tfSk+JERhkzFEr09TnJI5Gk2SBU0QAJ7LX13mijAWS
         1jLMD+chhQYsg5P7Js5lh/1Xy/JcZXcSA+c2T1adk2G8fs2h1bTPITvhwTM+A/WZMT56
         EtOSn2TjfZp2N8UuWYfx6SVkfPTVEHq4a4El+WHBC2gLTiSSmxO1jS4HyBGF9eRX1xQI
         U1Y8U2gUT7VCWjG8TduYRExOTf77V8mtuAc13xdq3eUc4MD9vPWtbx3xHHWYFwipvA9n
         oxfGikm+C+VW/lVLAyWkhuhQOUUz2ohvqD/RPozk8hrgvwlE/PZfz2EnRU2RgBMuwcBZ
         cezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1rFOz+whygw87QqNdKIUe0mawCMOnyiKe/ajAaJwqQ0=;
        b=NoJbmbAfPrIimbgHcX37MrA60gnEVOUYJPZCla8FARVJhN0/dY2S8ob5m19NS6Ej2z
         Kvya925DJbyJ/+kssGn+SbTCsg9+n2Z3rZS4YNgijJsSKRsSAhwc3ANt2gPjxKUzcb3d
         xAI4W0eGANJMr9assYY7mPaEvEwY+KW2hgKJhJ6wDsoQRkExpYeeNMVlRvgiPvrEdRwQ
         sFgA29KQWXnWeqJKlpv32RUTdPjgssIvexDUv7+y1OeZI9IPgM9hMMB3kcEivst1QnIj
         XxuvoZbRmt7lkl9S8CmB7eVRCl+8wckCoku0wFN49/Yu1+Zu8KhaxHXnK8mV5NLyag7Z
         0vJA==
X-Gm-Message-State: AOAM532nCqVXuLINMbny2dmYvLeYTS9o//SKZEtL65e68I+RWrUczDyH
        CqqSjJNUS2PTuIUvzeYPzyI=
X-Google-Smtp-Source: ABdhPJw46n6EBCY1vbUzIUp630vPq50Ss2N3LleSasvwBFxElrLwL5bZZ5Ygqj6R/IqM7+jkT1LS/w==
X-Received: by 2002:a17:906:3a55:b0:6ce:c2ee:3e10 with SMTP id a21-20020a1709063a5500b006cec2ee3e10mr6563660ejf.210.1648769989961;
        Thu, 31 Mar 2022 16:39:49 -0700 (PDT)
Received: from smtpclient.apple (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.gmail.com with ESMTPSA id n13-20020a170906724d00b006cedd6d7e24sm326157ejk.119.2022.03.31.16.39.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Mar 2022 16:39:49 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] ftrace: remove check of list iterator against head past
 the loop body
From:   Jakob Koschel <jakobkoschel@gmail.com>
In-Reply-To: <20220331193411.2fdbeb88@gandalf.local.home>
Date:   Fri, 1 Apr 2022 01:39:48 +0200
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F0AC0EC6-35F9-4A2F-836F-513C03A622EC@gmail.com>
References: <20220331223752.902726-1-jakobkoschel@gmail.com>
 <20220331191005.2954969f@gandalf.local.home>
 <212AE797-912E-47D1-9DC4-03B5351AFC57@gmail.com>
 <20220331193411.2fdbeb88@gandalf.local.home>
To:     Steven Rostedt <rostedt@goodmis.org>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 1. Apr 2022, at 01:34, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Fri, 1 Apr 2022 01:22:58 +0200
> Jakob Koschel <jakobkoschel@gmail.com> wrote:
>=20
>>> Can you move this to the first declaration to keep the nice =
"upside-down
>>> x-mas tree" look. =20
>>=20
>> Thanks, I'll fix that up. It seems like this is not applied on the =
entire kernel
>> making treewide changes a bit more difficult. Is it documented =
somewhere, which
>> parts of the kernel enforce this? Just looking two lines down from =
here it
>> seems to be 'broken' already so just from looking at existing code =
it's often
>> hard to judge.
>=20
> It's one of those things that some maintainers prefer (I'm one of them =
;-)
> because it makes it easier to read IMHO.
>=20
> But as you noticed, it's broken even in the same file. That's because =
I
> don't strictly enforce it. If there's a lot of code that looks good to =
go
> in, I don't ask to fix it. But as this was a small trivial patch, I =
figured
> I'd mention it.

I'm happy to fix it, I was just checking coding-style.rst and =
checkpatch.pl
and was hoping to find this documented somewhere.

>=20
> Thus, it's something that you do when asked, but don't worry about =
doing it
> across the board, you are not going to upset anybody by forgetting to =
do it.

I guess then I'll stick with the strategy to incorporate when it's =
obvious
or to my knowledge (net/*) and otherwise fix when pointed out :)

Thanks for the additional info.

>=20
> -- Steve

	Jakob

