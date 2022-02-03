Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE294A8FA0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 22:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354351AbiBCVNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 16:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352290AbiBCVNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 16:13:08 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF74DC061714;
        Thu,  3 Feb 2022 13:13:07 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id n17so4947010iod.4;
        Thu, 03 Feb 2022 13:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EAWfemoiqt84lCy0CQhK2iRzzP1lWnWiJOlRJH5DZgA=;
        b=WYszGr9/9vMCZjMAMMWpwyOI0b8ae4edwyKf7kW/L0XP2dJ17AwmdNEY5WZsqp46VE
         2auGlnnWLqq1tcFf8xB9PjXkBdzkR1DCVzo+FlH3RonUnQG37cKSpLHHhKLRAeQ9u82x
         KDvoj3P2RnEmL5cBB91xGGaZrxQGl26u8O5Z0FvAU0zZmNJ9f1lgxZyJZxPG70/M9R/b
         ZJB33zZByxUV7wFEaqLYgd+ex02n6v5Sin73zmgz1phF7SzYYXJbOCMs59DKN89l7R9o
         +chzwqlWS6j1F58bNrzGZ2ob7HrdIQfuBWHLmCaIFNOrRvUB+BOcGjoJeBolVVl6dluW
         Wyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EAWfemoiqt84lCy0CQhK2iRzzP1lWnWiJOlRJH5DZgA=;
        b=oOtAKKEZncSJLuUC1umObDh3UJ2OyMw19rNdXe1GiWTS2re0I3idn08XzGyxe/jW6c
         140xi5gpupoEQ/JBWxkl+yFxSULC1Qb3wHOvoEf07DZFH0QBqceTMRrP07/5vY1Nyg5d
         E8wmpfTxpJAiiH3SVNkkHenSROGi/W4uli7zvsvYCS3P1I2Cw7IQU/ofkh6Jpuvv3VFk
         aJCxzvw/olc5IWmyHUHplym/iOjZwqBBoOuBDDRFjd8rjV2PRMWzuqMvBElRdL1WG5k3
         l3hJSBeDGIWIay6Qw0AZXSVOoSKe9V7be1I+iwRmBwDkwhAM8F/Ml467Vho7/OtyC+W3
         xOUg==
X-Gm-Message-State: AOAM532t7AiWYyP8uRUZpDVHvckovKLiiiP3sWhb+AY1pVXSfvClxIm2
        ZDTPShnvCzcsTaHBOHDZdpcNrj5vbUBnNgwfKvCSSylj
X-Google-Smtp-Source: ABdhPJwjzT9x6XYF9AVrKVnK4BdNmajWV1Dh6FA+YNP9fOCDXz2KjrJZigMbMtsj+hSp1in1/oF741KFxCePyDUQSJk=
X-Received: by 2002:a05:6638:4105:: with SMTP id ay5mr19025118jab.186.1643922787187;
 Thu, 03 Feb 2022 13:13:07 -0800 (PST)
MIME-Version: 1.0
References: <20220203173307.1033257-1-keescook@chromium.org>
 <CANiq72mnF5qxfHGoDmvueMY7n2us9ZtA-u3igCJ+QjcbfKMP=g@mail.gmail.com> <202202031157.E18FA7BAC@keescook>
In-Reply-To: <202202031157.E18FA7BAC@keescook>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 3 Feb 2022 22:12:56 +0100
Message-ID: <CANiq72==yx_VnA_b2NMNMbw19V2bzuDTddgRHGO94Vj0hXfiVw@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] fortify: Add Clang support
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        George Burgess IV <gbiv@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 3, 2022 at 8:57 PM Kees Cook <keescook@chromium.org> wrote:
>
> Thanks! Does this tag apply to the fortify-string.h patch as well?

No, I would have to take a better look at the new attributes. If you
need it, I can try to find a bit of time.

Cheers,
Miguel
