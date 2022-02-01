Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5094A62BF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241622AbiBARm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241616AbiBARm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:42:26 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAD3C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 09:42:26 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id s18so22133529ioa.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 09:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4xoABbCLAqy/4kreknPMVLPWf+5QXy7Icd8rKXEaL4M=;
        b=hvNpGaMdHLShbno3NJ1JqnKRgSHU1Q5U/DIbbWxCdii7VvT5St5h4sayNtOtlyDHJd
         Am7J82HYYdLAzZAtMwgAYWXmd3oIj4xLbcmgRDc9Qa9WyATfj5qJGj3QicyEAer27hnP
         wqTWwj8Eugi/98m5OPPM7ioR/woxVmsa4Rxtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4xoABbCLAqy/4kreknPMVLPWf+5QXy7Icd8rKXEaL4M=;
        b=cGrh0L2ql9borJwb8VP7YVQWmOrri7ENV4OBZFs0lV0XmgxcGJeNaPb/tmakYDrxeI
         hhPPFeKXG5V8DcWyCLjObz84MS7nKKPn9wGbnAj8slvBq3up+2fsX0DuNQ3ZXqlIsPxp
         VSJFxXwMBd7+bf7Yuqlp3tXKNDG8HCic+/XClqKIzkpSA+ca3yku9D/PWkGYm0KGTGe9
         fWbhViwZQM/0mBgxiAvYRmZUtInGIWEqRwYRANqP0zUnaUAUpOr08UktDtGoU9N9jbk1
         itJaCkVfU0H/BBEyTBbXoubmmdGACDNF8Jle1FqnhzOE9/OE47Aq8o2xAIGOUlRrQNEK
         MGGw==
X-Gm-Message-State: AOAM532SDZxdteRUf8GOoyMO7RKAmafk1ocShYh61jdN8EEpKMiOKlO7
        iKciyZ/f7hOeRUFocfOrf0VL1OeE8ilnEQ==
X-Google-Smtp-Source: ABdhPJzyB9OPNcwrNxesk+uT1SEMo3iBsWU6/jrD628c/a1HUSRCfLAHagSYVL4vM8Y71zl6207ouw==
X-Received: by 2002:a05:6638:40a1:: with SMTP id m33mr5288216jam.38.1643737345539;
        Tue, 01 Feb 2022 09:42:25 -0800 (PST)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com. [209.85.166.45])
        by smtp.gmail.com with ESMTPSA id s16sm10801734iow.10.2022.02.01.09.42.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 09:42:25 -0800 (PST)
Received: by mail-io1-f45.google.com with SMTP id w7so22194402ioj.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 09:42:24 -0800 (PST)
X-Received: by 2002:a05:6602:3411:: with SMTP id n17mr14210351ioz.128.1643737344585;
 Tue, 01 Feb 2022 09:42:24 -0800 (PST)
MIME-Version: 1.0
References: <20220201092152.1.Ibc65ec6fa05017e9856ba9ef557310268429c3ce@changeid>
In-Reply-To: <20220201092152.1.Ibc65ec6fa05017e9856ba9ef557310268429c3ce@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 1 Feb 2022 09:42:13 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U6=2jPiOZ5=hnD+9tur=p7_u7ikbikEjB3jH=Jg8bNnQ@mail.gmail.com>
Message-ID: <CAD=FV=U6=2jPiOZ5=hnD+9tur=p7_u7ikbikEjB3jH=Jg8bNnQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/panel-edp: Allow querying the detected panel
 via sysfs"
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 1, 2022 at 9:22 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> This reverts commit 363c4c3811db330dee9ce27dd3cee6f590d44e4c.
>
> Since the point of this attribute is for a test, this should be done
> in debugfs, not sysfs. Let's revert and a new patch can be added later
> doing it in debugfs.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/gpu/drm/panel/panel-edp.c | 39 ++++---------------------------
>  1 file changed, 5 insertions(+), 34 deletions(-)

Pushed the revert with Javier's R-B, provided on #dri-devel IRC.

2bf68bbdb6f5 Revert "drm/panel-edp: Allow querying the detected panel via sysfs"

-Doug
