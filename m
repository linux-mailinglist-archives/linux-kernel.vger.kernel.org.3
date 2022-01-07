Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26AA487B93
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 18:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348614AbiAGRmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 12:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240245AbiAGRmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 12:42:16 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE30C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 09:42:16 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id u25so24980032edf.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 09:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qlTeTJ7EDTm7c9BXsTdwqcJ1U93LI0ovtC5oLv7HJ/8=;
        b=EzDtmhckdMcxUG26G41m9/0kVjTMfBYbN416j3lPs9mAd5lJ4W+Nk53u+bcN8Nof4h
         6RuLaXCBf9fWX78BJbfmYuj5gh/YjzAfy3o7qlM/BlWCqaJs0c6/2nWx+SGMA2/6rME+
         RkUGyAPUccxm6eDTAVNFU0couQa8OdlCouNYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qlTeTJ7EDTm7c9BXsTdwqcJ1U93LI0ovtC5oLv7HJ/8=;
        b=rduxE1tAHxOg9IWy2NKeuW9rBLW3tynBXWwvlFoZuEYZ+6nHwz4yOpD8AY5Q2wDNPV
         glC7niNYoJ8Eh1BQ40e2RkK8lDAhNofpF+RKGoA1mWfjx0oyskS5wTzieoC0+OkxMmsF
         Xc06PRsMmZcT/xZKX1kefLl31AVQhvXhjxCrNWciZFEfW93LFyvZo4temuyGa9lvtvFy
         sO+4K9gd33LadMK9axATcIgLLuMphSuIv0dVCv9IjuAWgz/c38+T9FS+b/69UZyL4Sze
         DA64z907STI6xRUcf3qtZE6rDfSt0ctICyCUxyDe5F+W6VjZcAqgu4XhB2qQAdKyCk7Y
         P86w==
X-Gm-Message-State: AOAM532/pfJLMAkadFedrOvRCLdd1xRQl0v0Ik1r0w4WULf9yVGcRtNv
        haN5pCZ/PDej+7b7paV22wExVtYcdrXCok6PiY0=
X-Google-Smtp-Source: ABdhPJwhubHyUP0qjX/9SIBSqx0zzYcT4sco1JBvEpASADeuH8sosZAuy7dIWFV0OvsGnPHvdmriTQ==
X-Received: by 2002:a05:6402:177b:: with SMTP id da27mr63459067edb.82.1641577335008;
        Fri, 07 Jan 2022 09:42:15 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id dn10sm1577626ejc.139.2022.01.07.09.42.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 09:42:14 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id l25so1599595wrb.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 09:42:14 -0800 (PST)
X-Received: by 2002:adf:f54e:: with SMTP id j14mr54539331wrp.442.1641577334232;
 Fri, 07 Jan 2022 09:42:14 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9twnYJ8SrVzJEEH+Vksibomvk5CE+Nn6BXKYwLG_8r=GJQ@mail.gmail.com>
In-Reply-To: <CAPM=9twnYJ8SrVzJEEH+Vksibomvk5CE+Nn6BXKYwLG_8r=GJQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Jan 2022 09:41:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiyfiVoci-LHaY=e70zOpAoUqwoaFF4iD3xm847PkK1CQ@mail.gmail.com>
Message-ID: <CAHk-=wiyfiVoci-LHaY=e70zOpAoUqwoaFF4iD3xm847PkK1CQ@mail.gmail.com>
Subject: Re: [git pull] drm final fixes for 5.16
To:     Dave Airlie <airlied@gmail.com>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 7:23 PM Dave Airlie <airlied@gmail.com> wrote:
>
> There is only the amdgpu runtime pm regression fix in here.

Thanks, from a quick test it works for me - the backlight actually
does eventually go away.

It does so only on the second time the monitors say "no signal, going
to power save", but that has been true before too.

So I think there's still some confusion in this area, but it might be
elsewhere - who knows what Wayland and friends do. At least it doesn't
look like a regression to me any more.

Thanks,
                Linus
