Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2D94A90AF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 23:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353237AbiBCW2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 17:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiBCW2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 17:28:46 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A95C061714;
        Thu,  3 Feb 2022 14:28:46 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id w7so5184692ioj.5;
        Thu, 03 Feb 2022 14:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S/15KBLqn1+gI3LiLP1R73ftno+g+PTM/BnKtRnTzes=;
        b=XeoOMW8rz2plGCJkP1Hq+gvOdXCxElLRsfLFbRPK1MKqE/qKO1Gg1LfogwnVY39AIL
         Hp0Z/TuETiLGIi4Cyztdknx8aZnxSYpQP20zyiQ/nMRWYFZlali2sFcLeXMgG9UcB6Nx
         W5NNbNmj73WLAQ801WQDpaAIZWIJV/0w9piukfFSo7dkwJOiTv51SKaQs205OjPBkznF
         g6tXIeZby0omLzXyv7o5py0JuQdMYRx6WZFx25G326xHGWOiWqnO2q81rdrelaAYwyUj
         RsXH9qVMJEHV0ldMd0W4YRasZ3/3VVC9ALUfrOqITkoT2Ip9qdxfhCHfYMTAeGkoj9WR
         ANWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S/15KBLqn1+gI3LiLP1R73ftno+g+PTM/BnKtRnTzes=;
        b=AgzftuPm7eoz5mVtRMpoOZrL6UwcjgCiNksp442ggIsZa+7rk3o9ws5ZDjVF+jOM/K
         4kueroiP9Gefam1rCkFhw6AN3TbI5OtgPSFnQlWZ4uKF+ewUd0uEdb0j8PeT22ZovDEy
         uRkDsdwSlvtfifVI0o8i4eOYSKlL1k3Ku/yquBEgexYqOm0HOj8OR5iKrHPOLq8iCuWf
         zB6eBgJF07v840E359hVDywXuRnQQGbv21g3/Lh+os/PWmmPkYaaPZQyd7ExS4z/R1hs
         I9sckrDvRBiCz95qJEqMTpKgpCLfhfPMbKv59vJLalRH/WDgKTm4xeVKEVafM7CO6i7/
         694w==
X-Gm-Message-State: AOAM533uK/rGGEk1hjkP2I5J0cbFdGYDQA+6SPxNRm60/hS2d0pcRya5
        E7uBK/O7gpyNxTqhjtFVpSX5diZsQtQEBesWBb7hmsi2
X-Google-Smtp-Source: ABdhPJzZsdNJOjt+GX0Uuga8TdJsl6rG51vnNyjJrvbrD8awrY/QTkKIEqJcSIPuFjmMEXqn2jQ0mRXAlR2waIbxok4=
X-Received: by 2002:a05:6602:2b10:: with SMTP id p16mr63882iov.44.1643927325471;
 Thu, 03 Feb 2022 14:28:45 -0800 (PST)
MIME-Version: 1.0
References: <20220202003033.704951-1-keescook@chromium.org>
 <20220202003033.704951-5-keescook@chromium.org> <CAKwvOdkvd=2DcwEpQWBtS3p-hKB6Rvp4YXB4k+81Me6E5H+mqQ@mail.gmail.com>
In-Reply-To: <CAKwvOdkvd=2DcwEpQWBtS3p-hKB6Rvp4YXB4k+81Me6E5H+mqQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 3 Feb 2022 23:28:34 +0100
Message-ID: <CANiq72m1QtGK6_UC0Bkcuu2UK1wKgsrg7wOrSj10bLM+sLceMQ@mail.gmail.com>
Subject: Re: [PATCH 4/4 v5] fortify: Add Clang support
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>, Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        George Burgess IV <gbiv@google.com>, llvm@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 3, 2022 at 11:13 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Sorry, I just noticed this line (already) uses a mix of open coding
> __attribute__ and not. Would you mind also please changing the open
> coded gnu_inline to simply __gnu_inline to make the entire line
> consistent?

+1

Cheers,
Miguel
