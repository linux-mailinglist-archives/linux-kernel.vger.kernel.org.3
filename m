Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8239E47D316
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 14:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245434AbhLVNie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 08:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245362AbhLVNic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 08:38:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D11C061574;
        Wed, 22 Dec 2021 05:38:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A06261A7B;
        Wed, 22 Dec 2021 13:38:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B98C36AEA;
        Wed, 22 Dec 2021 13:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640180311;
        bh=5DRhYUbBXiJ7M7p8JdRlsqvrCcTJ6dGdQO5vT+3KwiE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A1QSrelHfst2XLGXRImhOffXCTvv+hZ0jsbAZYZHh2ztxieBPL4PLuGmYk1w9quIX
         ZqYqRLy5HPZ/MajHE37ogY169zDJZhgoN36hdpXps+ckqk7FzW6igy0YizgsaozzDq
         Mnm4XlOgwo2k6vkdLZBdxtqaYrrW3QwmDe3qH+YL5IK1HR6z7vuUpeciYES20v+VN5
         9JHoXdDspwXDUV8J0LrqzE4ppFKl16ceKQXG5+u2Ljm/SerMdmNLmoZOvjt+ps6RGI
         xVP6mOXD1MioXtSj7OoXDzp7ul40EMSY23bVaDf4p5Uxr8+mv7/EXvFxoUop7umBQ0
         OLZD/lDFCdGqQ==
Received: by mail-ed1-f53.google.com with SMTP id o20so8735519eds.10;
        Wed, 22 Dec 2021 05:38:31 -0800 (PST)
X-Gm-Message-State: AOAM530AUf73sHmmkR4tCSlnfGVaEC2yVFnKkUfSIwtHQSjyHnJ7sZ+q
        9VKznyqUFOr/L6p7pd9KIruNHycMyDCDKcAoBg==
X-Google-Smtp-Source: ABdhPJx5GMhyXgG4DfxVbs9VtEOzLbnLOldQWIWCEc2JgQ8YaX/GDXDTB5A3Ig5tKW7CD8Ze5gLa8nBWgao4tqjmK1E=
X-Received: by 2002:a17:906:7945:: with SMTP id l5mr2464870ejo.82.1640180310127;
 Wed, 22 Dec 2021 05:38:30 -0800 (PST)
MIME-Version: 1.0
References: <YcIf7+oSWWn34ND6@debian-BULLSEYE-live-builder-AMD64>
In-Reply-To: <YcIf7+oSWWn34ND6@debian-BULLSEYE-live-builder-AMD64>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 22 Dec 2021 09:38:18 -0400
X-Gmail-Original-Message-ID: <CAL_JsqKMmufq64R+xO+dae1ffAc4zZBoD5Y0XxbHWjH0qOBwRw@mail.gmail.com>
Message-ID: <CAL_JsqKMmufq64R+xO+dae1ffAc4zZBoD5Y0XxbHWjH0qOBwRw@mail.gmail.com>
Subject: Re: [PATCH] serial: lantiq: store and compare return status correctly
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 2:42 PM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> platform_get_irq() returns signed status. It should be stored and
> compared as signed value before storing to unsigned variable. Implicit
> conversion from signed to unsigned and then comparison with less than
> zero is wrong as unsigned value can never be less than zero.
>
> Fixes: f087f01ca2 ("serial: lantiq: Use platform_get_irq() to get the interrupt")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  drivers/tty/serial/lantiq.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)

Thanks for fixing this.

Acked-by: Rob Herring <robh@kernel.org>
