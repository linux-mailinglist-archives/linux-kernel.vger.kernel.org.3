Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0353A486863
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241753AbiAFRXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241729AbiAFRXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:23:51 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD5AC0611FF
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 09:23:50 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id o185so9313659ybo.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 09:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yi+iNCvwz+kpe6GsRBnjeTUzjVTeWQd1aYc7A1omaWk=;
        b=fx5ALr+uJFgKpXTeYgkhnEsCtOuelz7sC4rEHjEdH37yr8MqDZGGJjcdXhXzf5B0NW
         UCgFMksyQU9ctv3lOqnIIGcH76f6yPjaPJfa14FW5MeA9KLhHaOjC1sshe4wtYxkOzJE
         iU94+lmnXB5olrYFC0sWyPD/eRVpB8J+1s0hsYVk0ouXfX0F6T0kJmlJOsbBy38r7awm
         24t2jTOgW2XlYA7vebaXw8PLP3Ek/+3o56JNh8GDT/sM/npQFWnCfOZegeUqs9zTnbXV
         LdB4X/MA6Ou4NKnFJVriUKmhzPtB96QmuFTtOEEwpwEPYUqDf9KgYcetik11fBHM3EHK
         dxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yi+iNCvwz+kpe6GsRBnjeTUzjVTeWQd1aYc7A1omaWk=;
        b=k6hgn1Omr+BhnH4TI48cRm0LoqO+Qhw3Nzu0MZUZkTNMsDksPEf3vOFJWc+A0S17Je
         QPvxzmFKxU3LeuIqSofwHukta86Bkpj1hEavWJVm1Zm2J3nxosJUhvPfltrv9UFRfqYD
         zsT6/tA+JNrBV3kpjGi/ucp8gz9sbGKYZnUBRjDT0hLb/cT9ZBXnltU+jrByK3SJSRKO
         7du3YKHkj7Im6ncWBivfJI8L9dAQ9kRCgt7bbp3EIY//gC9oZJrwhrYEnmBBHGePhqdB
         Sk5N4deEQtOJ/UB2rsrSGZtZtc3H5rc7Lg366lrP1DESVspluFM2zIC+Tgh+A0gc8e9Y
         Bi+w==
X-Gm-Message-State: AOAM531O895+IrxPLuFlf+oYMSVn7CNKhwZRL+mkTapjbah2W3DjVFop
        5aNHZvhNLEuIriwU6t8jvU5ywj6wKOfFvOm+IfIxMg==
X-Google-Smtp-Source: ABdhPJwfZP1m9v3L/YZ2JpfPrIAxecC0DQ9roBguX/Tj/f3gJ1bU/ksEbLHQXGKCyXcdkAJ74bm/s7Lv7mxjOrSb7Wg=
X-Received: by 2002:a25:9d82:: with SMTP id v2mr74979615ybp.383.1641489829648;
 Thu, 06 Jan 2022 09:23:49 -0800 (PST)
MIME-Version: 1.0
References: <20220106003245.15339-1-yan2228598786@gmail.com>
In-Reply-To: <20220106003245.15339-1-yan2228598786@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 6 Jan 2022 09:23:38 -0800
Message-ID: <CANn89iKaekDBCzPMeoKsnyWSfQof5ZXMzR568XrgA2aC8Joexg@mail.gmail.com>
Subject: Re: [PATCH] tcp: tcp_send_challenge_ack delete useless param `skb`
To:     "Benjamin.Yim" <yan2228598786@gmail.com>
Cc:     kuba@kernel.org, davem@davemloft.net, yoshfuji@linux-ipv6.org,
        dsahern@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 5, 2022 at 4:33 PM Benjamin.Yim <yan2228598786@gmail.com> wrote:
>
> From: Benjamin <yan2228598786@gmail.com>
>
> After this parameter is passed in, there is no usage, and deleting it will
>  not bring any impact.
>
> Signed-off-by: Benjamin <yan2228598786@gmail.com>

SGTM, thanks !
Reviewed-by: Eric Dumazet <edumazet@google.com>
