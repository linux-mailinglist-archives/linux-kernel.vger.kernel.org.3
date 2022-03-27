Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCCE4E8A7D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 00:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236926AbiC0WZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 18:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiC0WZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 18:25:24 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C995E4EF55
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 15:23:44 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t25so21789170lfg.7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 15:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qdphx0B9HnveSZQ4eZgylUI7GQmjcDDsYT6PZjX3jZk=;
        b=QNN1i2WIBH6Hu63QF8GMULZ+aSMQa/oLj2pbk2VgTMnx1yqkwNXGLDJmqXjZxs2Hz0
         ZmkqXhrpXmFDBHDx4HraU1BJNogt311CP4JUKQrr5J/e2bEEJ7ZY8MIlpuwZvBDHN1mM
         zlwtVtd3jxs/gxCz/r2kOEc3G9s5FcpJNIcJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qdphx0B9HnveSZQ4eZgylUI7GQmjcDDsYT6PZjX3jZk=;
        b=E7Cyk17sPewrI4GZUepGfprK65MIa3k4IppUdossHAMj+xiulcZf55IyCDybuRG3QZ
         Sm0vPCSWf7TFHo1TNoLjggF+zpSWTgl38BNN8LtTgN6SVQTLmMfC445cVMMmgYndBgFW
         HZhqH3Scv4d3D9u92fz5rkPQcN7nb7gKTzyLrF4XnqKCKLelRTv6D1NNDzeoRei9RJg0
         SrUkZrJL9X2Q7+NVr5+VgPayw4NN3D/bWNScHx4+2YSuWnpHrl8BF9KwY6zzbv1ypX6S
         S4QTJP30yGcsVCltnfx+pGL0L1AuG4lbi0vSfkxrmOAl2nXtVz6SysNYN40MTedCmUTz
         pT0g==
X-Gm-Message-State: AOAM531n3Lw7eF27hriW5ljHqCAjIFzZNs5E3webeXv0zG8PlZ+b75y5
        5y1N/s/Npb7bFSU8KWgLW5VU5/7Pg5+RnrYqlSU=
X-Google-Smtp-Source: ABdhPJy1Ee+y/K8h2ZMbPJAcbFiejTiyaiymreWlOH1YW/ZwQpNjSXrp7EJQuizaF0U9Eu4HwhZapQ==
X-Received: by 2002:a05:6512:12d5:b0:44a:9c24:9254 with SMTP id p21-20020a05651212d500b0044a9c249254mr882237lfg.39.1648419822758;
        Sun, 27 Mar 2022 15:23:42 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id z23-20020a2e8857000000b00249a15d93b8sm1526762ljj.125.2022.03.27.15.23.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 15:23:41 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id bn33so16894417ljb.6
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 15:23:41 -0700 (PDT)
X-Received: by 2002:a2e:9b10:0:b0:247:f28c:ffd3 with SMTP id
 u16-20020a2e9b10000000b00247f28cffd3mr17214178lji.152.1648419820604; Sun, 27
 Mar 2022 15:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220328090111.26f8980f@canb.auug.org.au>
In-Reply-To: <20220328090111.26f8980f@canb.auug.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Mar 2022 15:23:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=whGmZrYZ=YdcjeJbpviUTShj0NOiG2q-3d1-RJtz6vBPQ@mail.gmail.com>
Message-ID: <CAHk-=whGmZrYZ=YdcjeJbpviUTShj0NOiG2q-3d1-RJtz6vBPQ@mail.gmail.com>
Subject: Re: linux-next: build failure in Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2022 at 3:01 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Building LInus' tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:

Gaah.

I even *looked* at that code when merging, and convinced myself I had
gotten the #ifdef/#endif chain right. Apparently I can't count.

What a maroon I am.

Will apply that patch asap.

Thanks,
                Linus
