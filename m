Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7CE4EE8A2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 08:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244516AbiDAGwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 02:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiDAGwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 02:52:03 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043401C406D
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 23:50:14 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id i16so3756314ejk.12
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 23:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YuBl/f3XfwHvQa93+ozqB8r1E47ocLC0Rqnq4xYkwnk=;
        b=dbN8gBG1DIw4qjBl6ffKKyiZ7V0DgQNxcTQaaAqGEjfw0Y9CIT9fi7Yxtkil2lBF4d
         lluQ2qS4B+ycFFK++rnpr8ovwDcCPqugcI1ivBF9S81SZszy7IAwY0Z+t3mJL9Ks03Q4
         Vd9bENcM5LH1zxOIi+WhsPx3iJLlM9GL14gr9cVZl0+El0PS+L1RpFYlKZB0zxZ8Fc7t
         bzSWeuiMTsirTmSq3nI38bxmdM8lFqR6C5kwCkJW3+FYyiW74VsGFpYdvES/ICY4THji
         GHC/j4/h+owfAUSYy+g1E2Xc39VT2PvDCcHrY3u5RfCsZ9tI+Cc/oVQE03IpYARaHWKt
         9LBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YuBl/f3XfwHvQa93+ozqB8r1E47ocLC0Rqnq4xYkwnk=;
        b=1lHxnUQ33CypKBtvNdDJVBrQAn/xlqz/M7TEZeLV/kNSKIIvxuPa+n8FzmF7YBKfqF
         1cC49Al/uZ+5KtrNdYi32uI2CSiOrCJ41KGd4IUkiOcXp8cUOSI72c/m5iHRXvFDw/bk
         Kpp8KPMjQbwJcGGbpoBKL7ajU92W/MQaQ2lF9V9voCxMimsdP3FxesOMTjt5nDJ0tx7h
         NZUcjfs8ayIUfrov0EUDjhIv47e1i4pyhdCeWO0buL5XkHoaiJ8IYI2gOoYfiftJsf8a
         FRIg6v9xTimFC0v57aCbtz5BJdLbm9+MX/yWldxrqFE6mLDO3UERR9fX7Nr0k4ysQRPM
         fsyA==
X-Gm-Message-State: AOAM530l0eLa8cdSySHhyHcBHYQHd0G92fu+5ynILFMyzFYbn6k8ej9Q
        d6+3azNso+gI0XkqVt/668Q=
X-Google-Smtp-Source: ABdhPJzMkxBXFe5gLY12+rQoXVgTb5dNkbuEXAGLuYMAH+KhEA+hGON971+OoAEx8VXnJWu+9qVn8Q==
X-Received: by 2002:a17:907:6e0d:b0:6e0:59ae:21f1 with SMTP id sd13-20020a1709076e0d00b006e059ae21f1mr8351917ejc.362.1648795812369;
        Thu, 31 Mar 2022 23:50:12 -0700 (PDT)
Received: from smtpclient.apple (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.gmail.com with ESMTPSA id m24-20020a170906161800b006d420027b63sm678937ejd.18.2022.03.31.23.50.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Mar 2022 23:50:11 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] staging: android: ashmem: remove usage of list iterator
 after the loop body
From:   Jakob Koschel <jakobkoschel@gmail.com>
In-Reply-To: <YkaP6UWmSZjxO/oA@kroah.com>
Date:   Fri, 1 Apr 2022 08:50:10 +0200
Cc:     =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev, Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7BBD57E4-287B-461B-BC5C-D2FF35865D39@gmail.com>
References: <20220331213934.866804-1-jakobkoschel@gmail.com>
 <YkaP6UWmSZjxO/oA@kroah.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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



> On 1. Apr 2022, at 07:38, Greg Kroah-Hartman =
<gregkh@linuxfoundation.org> wrote:
>=20
> On Thu, Mar 31, 2022 at 11:39:34PM +0200, Jakob Koschel wrote:
>> In preparation to limit the scope of a list iterator to the list
>> traversal loop, use a dedicated pointer to point to the found element
>> [1].
>>=20
>> Before, the code implicitly used the head when no element was found
>> when using &pos->list. Since the new variable is only set if an
>> element was found, the head needs to be used explicitly if the
>> variable is NULL.
>>=20
>> Link: =
https://lore.kernel.org/all/CAHk-=3DwgRr_D8CB-D9Kg-c=3DEHreAsk5SqXPwr9Y7k9=
sA6cWXJ6w@mail.gmail.com/ [1]
>> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
>> ---
>> drivers/staging/android/ashmem.c | 21 ++++++++++++---------
>> 1 file changed, 12 insertions(+), 9 deletions(-)
>=20
> What tree did you make this against? This file is no longer in Linus's
> tree.

Looks like the driver was removed just a few hours after I rebased.
Feel free to just ignore this patch.

>=20
> thanks,
>=20
> greg k-h

Thanks,
Jakob


