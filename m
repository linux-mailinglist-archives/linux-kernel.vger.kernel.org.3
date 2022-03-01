Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561E44C8E47
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 15:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbiCAOxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 09:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235348AbiCAOxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:53:05 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE60749CAD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 06:52:24 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id d3so16804548qvb.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 06:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E4qIR0gbcynkMM7ipUNgXxHtJnS+/1BP2qbABctPj58=;
        b=T3YPMIJe1af7lUTVV3bFe73oGWTJnD/WaKm7NT6U3TLybc38VVyUhFY/ZZk0vAUhv3
         NWZ3Fi28dMn7x3xi0UIXfGe9GXBY9OMv/TJ/itZNQSgmkVHk1a2b1hT/mU/SVXNcvrw4
         gY4FhSkdV9LQYeQjCjr+gZncH7wNtx1zQFNSjJcVZeiakOfpHAdqwKYivbHa9iavDZ7g
         EaYSyuli2AlRgvzr1kWd6PqOx5J4djFmV+JWk35M5myDqLV8IdWPIZrvE5hTIClcoFw1
         V0fr2p2ycUkvrZ4SKlaQBQzFCtiGK87NOfUjN5zZGhUqwi25A0dNMjz5AAMbqj6Dr7T7
         RS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E4qIR0gbcynkMM7ipUNgXxHtJnS+/1BP2qbABctPj58=;
        b=VfUfaPNPRWz8OP7bQl9E2A8De1NqCk6BDbHzVoENfFDwS/vap2ilPKa1Fc9HrDpqUp
         T5lerxjfJWGlTb0FbdcN/8SV5RjZlnWCAXS9uqlQtIy/4JGZ8es2mqWTny0U65zxfQMo
         tyGw11ozI/pMDXprSK0HVlRUThaIuXSlBPctYatxafjjEHyMaeKuX8IvsMM2K+kFgHiL
         C+vCVt83DIDsGrnun12ogA2RBysGHBIZlpX0ypf/mJNOqFV6TBVZSvdFpqBtfRZzl0u8
         UQ4jiHoTUgF0tvF4q8bMZkK9VwqkqijgdjzEIk4WgTFc/CEbixhEZRm8J9hoTaa10rul
         8ZRA==
X-Gm-Message-State: AOAM531vkDqnbU2MViABUZfn3QqIoNECDlZHnF6nVR4ej6Bo88yDhWpS
        MGg60xiaxX7hG20YL6mYu1TYerffKGg=
X-Google-Smtp-Source: ABdhPJxM8d3rf4+61QuWR4y1+Co47trb4aiIeRigZ9VTRLnb9N5mr5m7XYkkQjXfDHD+hqlcrFbasg==
X-Received: by 2002:a05:6214:21aa:b0:42d:f4ff:fc9 with SMTP id t10-20020a05621421aa00b0042df4ff0fc9mr17364804qvc.49.1646146343827;
        Tue, 01 Mar 2022 06:52:23 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id c6-20020ac87d86000000b002ddd9f33ed1sm8833024qtd.44.2022.03.01.06.52.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 06:52:23 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2db569555d6so90811267b3.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 06:52:23 -0800 (PST)
X-Received: by 2002:a81:6603:0:b0:2d6:d166:8c31 with SMTP id
 a3-20020a816603000000b002d6d1668c31mr24731960ywc.351.1646146342611; Tue, 01
 Mar 2022 06:52:22 -0800 (PST)
MIME-Version: 1.0
References: <20220301144453.snstwdjy3kmpi4zf@begin>
In-Reply-To: <20220301144453.snstwdjy3kmpi4zf@begin>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 1 Mar 2022 09:51:45 -0500
X-Gmail-Original-Message-ID: <CA+FuTSfi1aXiBr-fOQ+8XJPjCCTnqTicW2A3OUVfNHurfDL3jA@mail.gmail.com>
Message-ID: <CA+FuTSfi1aXiBr-fOQ+8XJPjCCTnqTicW2A3OUVfNHurfDL3jA@mail.gmail.com>
Subject: Re: [PATCH] SO_ZEROCOPY should rather return -ENOPROTOOPT
To:     Samuel Thibault <samuel.thibault@labri.fr>, willemb@google.com,
        davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org
Cc:     Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 1, 2022 at 9:44 AM Samuel Thibault <samuel.thibault@labri.fr> wrote:
>
> ENOTSUPP is documented as "should never be seen by user programs", and
> is not exposed in <errno.h>, so applications cannot safely check against
> it. We should rather return the well-known -ENOPROTOOPT.
>
> Signed-off-by: Samuel Thibault <samuel.thibault@labri.fr>
>
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 4ff806d71921..6e5b84194d56 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1377,9 +1377,9 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
>                         if (!(sk_is_tcp(sk) ||
>                               (sk->sk_type == SOCK_DGRAM &&
>                                sk->sk_protocol == IPPROTO_UDP)))
> -                               ret = -ENOTSUPP;
> +                               ret = -ENOPROTOOPT;
>                 } else if (sk->sk_family != PF_RDS) {
> -                       ret = -ENOTSUPP;
> +                       ret = -ENOPROTOOPT;
>                 }
>                 if (!ret) {
>                         if (val < 0 || val > 1)

That should have been a public error code. Perhaps rather EOPNOTSUPP.

The problem with a change now is that it will confuse existing
applications that check for -524 (ENOTSUPP).
