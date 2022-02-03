Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE524A8A93
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352958AbiBCRrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbiBCRrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:47:12 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBA7C061714;
        Thu,  3 Feb 2022 09:47:12 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id 9so4251976iou.2;
        Thu, 03 Feb 2022 09:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OdOUOSrNjs8WGrwM3cNkf3QDO2RSIWw0of1a994x9is=;
        b=qUet28M/qXwcV735iKonPeQ+jqwhVlbPrZ5v9ERd6dwm84VFOR8zYyWA97AbVMMPpk
         mdNSsJygXfKzrKCP78dj12yoxV745szFny0DHcntoUkwt943/a7cO5dorUahC/6IJ00/
         ozJYiM3vgpSfxlYM/OlXUbNnO+TbLiwEhq9atmoz8mPx/dFEuC7imBFdF93rzQ2iavnc
         Zb8ehMoGhPEzYOD10JM9BHrsRaoX0IBGcMMlLaUBs6P50tFW8STe4WeFavBqkIoahEYh
         rNUldx7DrdAwacU7fFK/lB/bGzTvCGaywBPCTkO4Uiu5e0hOd+XFUoZxrZsTLX3igbPw
         8hHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OdOUOSrNjs8WGrwM3cNkf3QDO2RSIWw0of1a994x9is=;
        b=kx2t0gv3+SVPXUoIkYm8DJAliV7PDlIr+yt2yBcnXcISxbYYrOem524h/xFEoLXs4P
         3jT04p/ktEAYp9SVEpMZKfoi8jAmXo+dGmLk+P6QQViyeXyFUx45o9TLJtj8Dc+57ks1
         n29nQtY1XROqniVa5mTYtL8jtDOl14qmbzVk+wIRsbnB8IV/Lop1z0cr7AtfBYaoBS1a
         sgSWY0kgDvbEFKS7/Ip08u1vb5PpgJuK7XLeKJ8y6/RAQfcT4f/rPodiWjPbdGJM467R
         Uq/hyodjMHE/WQou7ryMcio+PWWL2r2L0bmYW6BVHavYKybSoO4IwU+OW+Pp9or2/aCx
         gP8A==
X-Gm-Message-State: AOAM532hqXW00q1c0JI+eZDtiU98L2VPosYFa8IkwxCGDR8w+49EHZkX
        SIIqlY4mGaQBb0eXXm0AkWampNLXkiKBLU7tj6YlA4ff
X-Google-Smtp-Source: ABdhPJx52ZDGvyoTS5OSrCU01ffJy15/Go+Qu53BiKESGtTam0tj+EOKusrFAbEcqE/fXnAA6wgsovfQDjukEOXBLsk=
X-Received: by 2002:a5d:941a:: with SMTP id v26mr18767908ion.64.1643910432327;
 Thu, 03 Feb 2022 09:47:12 -0800 (PST)
MIME-Version: 1.0
References: <20220203173307.1033257-1-keescook@chromium.org>
In-Reply-To: <20220203173307.1033257-1-keescook@chromium.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 3 Feb 2022 18:47:01 +0100
Message-ID: <CANiq72mnF5qxfHGoDmvueMY7n2us9ZtA-u3igCJ+QjcbfKMP=g@mail.gmail.com>
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

On Thu, Feb 3, 2022 at 6:33 PM Kees Cook <keescook@chromium.org> wrote:
>
> This has been updated from feedback on the v5 series. Builds correctly with Clang 12.0.1
> too now. :)

Looks fine to me! Thanks for the changes. I assume you are taking these, so:

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
