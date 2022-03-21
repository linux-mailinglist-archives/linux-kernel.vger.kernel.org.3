Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27914E318F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 21:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353294AbiCUUPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 16:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353658AbiCUUNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 16:13:30 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E28853A4C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:11:15 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id p15so15701758lfk.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HxSmzv7mQZ7JUvz7ojdvZAF+4FKtifambs8UajreWKQ=;
        b=YRsq7D0j0R9Z60aR3WWEyswK/kSVnQuXRpE+1RTRLz1AhAbhu7YFRRwTglXvtv/QU0
         ylS8SXopbd6FP7DtmIfh3yQ8twQb5m3x5qzHE+b9NjsBMHn+HSch8X6PD3z5tioZUVso
         zf5P2i6MlykbE6mxxm1EQ0quGo1jH305Yu9uA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HxSmzv7mQZ7JUvz7ojdvZAF+4FKtifambs8UajreWKQ=;
        b=fumGxDhCh3wMdwIdO01OJb4e2kSYvUWx+Y8FtU2JeVjsovfHQQztXh78kHynJJQwco
         f2QpSUeflgudJnuYUBUcVMzZ+yjGhsLwqhvtJhhpJJVG7WDOB/OWzkKom2PLvRzR5RwW
         zE4C0v45aqkVT6L7dsvtq1/u9IThBvj+e5DCAOoMhwWm9EXIcAWUPnsxRT663NC1EFir
         737qnSZDCUsFy6EDtphaNblw5Rpr7x/S4BjQRxR8xxTCbk01+yuCoJ0Gt/nWLlsawvcG
         rvR9g38PbmnVDIe95Jd7Kuvl0Bs1LPjb8sChzukJH35Iha0uhCwjN6vxlNhgXNOJKhIp
         u9PQ==
X-Gm-Message-State: AOAM532Kxwrw8teutd9v0uSz/GTpzZDrUERqNd1ZIqVyiEMoFHsJxJOa
        NPWBA/iRQJHkyOG9Ac+o6gpAFpEN+GzgS3CHC84=
X-Google-Smtp-Source: ABdhPJx6vOVJ5V2DTM8UP92pJ9oF4A1vgm2YmaXsn8DbYCCPlVOgw8nobGSDMWjOvOZ5BRyy7TRrtw==
X-Received: by 2002:a05:6512:10c1:b0:448:3070:7071 with SMTP id k1-20020a05651210c100b0044830707071mr16031245lfg.264.1647893471936;
        Mon, 21 Mar 2022 13:11:11 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id z1-20020a195e41000000b00448ac0a351csm1897435lfi.211.2022.03.21.13.11.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 13:11:10 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id p15so15701615lfk.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:11:10 -0700 (PDT)
X-Received: by 2002:a19:e048:0:b0:448:2caa:7ed2 with SMTP id
 g8-20020a19e048000000b004482caa7ed2mr16082525lfj.449.1647893469870; Mon, 21
 Mar 2022 13:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <YjiyOIc71r53GME+@p100>
In-Reply-To: <YjiyOIc71r53GME+@p100>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Mar 2022 13:10:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=whnG8uJqNz83Fh=6je2u71syaenWEpDQCeHoPoxZyM5Dw@mail.gmail.com>
Message-ID: <CAHk-=whnG8uJqNz83Fh=6je2u71syaenWEpDQCeHoPoxZyM5Dw@mail.gmail.com>
Subject: Re: [GIT PULL] parisc architecture updates for v5.18-rc1
To:     Helge Deller <deller@gmx.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-parisc <linux-parisc@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Sven Schnelle <svens@stackframe.org>
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

On Mon, Mar 21, 2022 at 10:13 AM Helge Deller <deller@gmx.de> wrote:
>
> parisc architecture updates for kernel v5.18-rc1
>
> - add vDSO support (allows us to use read-only stacks)
[...]

I was all "WTF?".

Then I checked the code.

You mean non-executable, not read-only.

Fixed up in the merge message.

                   Linus
