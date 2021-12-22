Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C76947D659
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344547AbhLVSOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbhLVSOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:14:41 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A461C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 10:14:41 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id f5so11900040edq.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 10:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ScR+h8VxB37NfMoT2O7P+LO0E7Y+1klzOjqDJpdvCio=;
        b=GHajjSqYwzDUScknLHhC2cSvbd2WjJYXmG/OgyzSUwS4BwOkEGVLtK0RQ2+JghWIUB
         Hd0WgknEY0Bm52oilAhwU1h6KAbovXoc0XIAIytMGOU+HQI6D528g8f8mgzu6hJZODBF
         GK1MTi3tY3qi7v2soGoo1R7yPbIfqKXwv6FV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ScR+h8VxB37NfMoT2O7P+LO0E7Y+1klzOjqDJpdvCio=;
        b=ruVH3GHO/HzpoCVvE6055tdJlV/rV8HegJlBj0YjT0AbQa1sAGGnKompOQb1+0tRTZ
         eAgYFWmLGEfiQoG0WQSZy2rLeAjWD/CleBZG0uGUdrMwvwal4OdwBm6xf4bZOf/FsCPk
         IjfN4pWrKP59YAfLb1KUGoN0Ce80gjN9W8cYDy1yB70+VAqf7LSHplv8yXhnxNh+rzib
         J1CE/ysdU7J3tF+MGmCuJBe7oxqHzCJS6GwnZZFy1HxcF+kAy6zQbZ+J/2sqE3gtUjvv
         UQaSmXWbwvR/spXtTu0uWFpTSlgws2/ftIQDhCqDz8OwGHrDypkhL83ElMbDf9l990D5
         62HQ==
X-Gm-Message-State: AOAM533xOfjVOvm0ZLgqTduuLcFloj4eRGRVXZehyfccCvPOQ+X2i2zX
        2Gkr2QCj0FUgRqsR3sdQX+b7OFaGRCIYhkeLBx0=
X-Google-Smtp-Source: ABdhPJygfQ+IwX0gQV0b/QwG1Kx4em97pOsBJagGYIWISJs88Vlmnz6xKytmakYnWpRxwsdYrMBm3A==
X-Received: by 2002:aa7:c6c8:: with SMTP id b8mr4027871eds.164.1640196879692;
        Wed, 22 Dec 2021 10:14:39 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id 16sm966921ejx.149.2021.12.22.10.14.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 10:14:39 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id s1so6623736wrg.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 10:14:39 -0800 (PST)
X-Received: by 2002:a5d:6211:: with SMTP id y17mr2891851wru.97.1640196879077;
 Wed, 22 Dec 2021 10:14:39 -0800 (PST)
MIME-Version: 1.0
References: <20211222141155.GV14936@minyard.net>
In-Reply-To: <20211222141155.GV14936@minyard.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Dec 2021 10:14:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=whBq4Fo+K=2dpRLF03z4crDC6SKvYQ-5f3QTx_QW6grBg@mail.gmail.com>
Message-ID: <CAHk-=whBq4Fo+K=2dpRLF03z4crDC6SKvYQ-5f3QTx_QW6grBg@mail.gmail.com>
Subject: Re: [GIT PULL] IPMI bug fixes for 5.16 (3)
To:     minyard@acm.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 6:12 AM Corey Minyard <minyard@acm.org> wrote:
>
>   https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.16-3
>
> for you to fetch changes up to ffb76a86f8096a8206be03b14adda6092e18e275:
>
>   ipmi: Fix UAF when uninstall ipmi_si and ipmi_msghandler module (2021-12-21 08:04:42 -0600)

No diffstat, no shortlog?

I've pulled this, but you need to do better.

              Linus
