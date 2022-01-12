Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2268848BC3C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347576AbiALBNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbiALBNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:13:43 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680CEC061748
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 17:13:43 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id z22so3317257edd.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 17:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZaT2R5kaQaju0x+UlFgmD6QCY5CgbQuRRz1zHWPJHC4=;
        b=KwRQEipDQ1RRC11ovJQe096JtPP98rYiCW+xIiGzmIAL1tCH+EtzUwqttlOcM+XYAw
         ZvWANexjQd1shQQzpJlh0l8FfwFdImhKdrrAJCWGSedclApedKOPE7R970cLKZa5eMFE
         9gc2gkd7RCatTI5HoQ+jO+Dlxa0Z7IabAfEoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZaT2R5kaQaju0x+UlFgmD6QCY5CgbQuRRz1zHWPJHC4=;
        b=1j3LUoFp2peRE5oi7/G0avPRf9aHiK6FsqupnxeXd8nnVyACIWbUQ/BbjgG+aW81LJ
         4FOCGmL49ro6Yj7aU/lwjdyAnnWeGZaUFOcDFE/64LSG5G9XbeQWYiIVx+5hBr1s4W1E
         4BJ1wTQ4+Pk2Qezl/xFdZFZCD91mjZtEHonZYeX6IGkmLdDtwuOnre9Rawjq2HE6aAUz
         2ODI9xEWvOR1QYQgLZAlsQAjQKq1euEeKO6drW1Xpk3zDquUEiTHoGwISSyKPeN39Jem
         UD1Q5oM6gzIEHUFj8whx9NI4mn8a9W7oT6YkjyOZ1+ReFK7mu0HROBFxAUC8wivKkg6I
         swQA==
X-Gm-Message-State: AOAM532QRsesD1GALj+lHcNbZl7yjlKjae8zAErc1yPC9l/IwtvKP0T3
        YR3uI1HdFsMqHi0v/ewQJ35SusyATZ9jAcr3vm8=
X-Google-Smtp-Source: ABdhPJw+Bq8wlPLNBDQcbLMiM2qTsOFjfXwApB9c0SckAEksCvVktCagZmzj5cfzuU1rPPhtPs59Qw==
X-Received: by 2002:a17:907:d11:: with SMTP id gn17mr3512909ejc.252.1641950021828;
        Tue, 11 Jan 2022 17:13:41 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id 16sm4063748ejx.149.2022.01.11.17.13.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 17:13:40 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso616548wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 17:13:40 -0800 (PST)
X-Received: by 2002:a05:600c:4c94:: with SMTP id g20mr4584839wmp.26.1641950020220;
 Tue, 11 Jan 2022 17:13:40 -0800 (PST)
MIME-Version: 1.0
References: <20220111193855.GA13612@embeddedor>
In-Reply-To: <20220111193855.GA13612@embeddedor>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Jan 2022 17:13:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgTEj354w942PW88eP6BLu8=XREzUaeo1zx816OUFLe2A@mail.gmail.com>
Message-ID: <CAHk-=wgTEj354w942PW88eP6BLu8=XREzUaeo1zx816OUFLe2A@mail.gmail.com>
Subject: Re: [GIT PULL] Enable -Wcast-function-type for 5.17-rc1
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 11:32 AM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> Please, pull the following patch that globally enables
> -Wcast-function-type.

This seems to have been in linux-next, so hopefully that means that
all cases that used to warn are actually fixed and there are no ugly
surprises waiting..

              Linus
