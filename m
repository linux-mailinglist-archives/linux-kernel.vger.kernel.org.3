Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73857487F42
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 00:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbiAGXN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 18:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiAGXN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 18:13:58 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CEFC06173E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 15:13:58 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id k15-20020a4a850f000000b002dc3cdb0256so1471535ooh.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 15:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=F+nj6othnUl9TqkvFEAN8QCl9928qsii1lcVa7kLyO0=;
        b=S5SV+VQAkuTKHO5/FvAxca/8OBYi/ti1oNsqiSj5mMReOmQXTwpD+mb6ZbIa9bnUoM
         5Kw8fCPhmeh4cIwqZSe82B+V3viliBaHr6RnsFjK2pPD0aeyYN4xjXDLL/TEtN183wA5
         0AaPrE9uYu6HT+fcqIw+LDE/VaaGM3ik5K34o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=F+nj6othnUl9TqkvFEAN8QCl9928qsii1lcVa7kLyO0=;
        b=uS4YIG30/nQxhOfXtkY8J5TTR/en672qwANCajyyv0JgJsdpVXbq/tpB4snpBGu387
         zMbzLDA2wX/2GS4tHU7R7vr+c/FgmKh7p0iuv73cqgAfLem1Chvm9EDEbNMe4BFjawlO
         jk+n9qjLJnOoi8Ebmqq9eEMk+ZMvpu4rW+izZtDi9pB+YP7r3nFZUX/T/tZBzKL4Xrw0
         1LBB/kGOIoXf+eWk95k6tyQ+QId+Phm8ZfWfTF6NU2uaSSe5lqeu0CTMw+vlG6jYW5xf
         6dIxIgf+GCiakmegWduqsS/cFrJhzZ+YMqEHUOHXa8/2NnB/yf2ulGLWD6rPU39T0iNz
         DtHA==
X-Gm-Message-State: AOAM5323BM2dNHWNwMsul7/lnei7My4YIlXVY3gdB1aA+2BeEt1SOvYV
        PELllwXBiNtEdXNOXXDv+tWwK8DTmq19OfUhhUe0Jg==
X-Google-Smtp-Source: ABdhPJzO7C3fHocXirj1DvzWKV0S4KZ3cR6JfxhqaPd87TiYoV4N8oaQI2EINw2KgSOIzZIvRPVbNpXH5frEH5M8MWU=
X-Received: by 2002:a05:6820:411:: with SMTP id o17mr41624593oou.8.1641597237623;
 Fri, 07 Jan 2022 15:13:57 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 7 Jan 2022 15:13:57 -0800
MIME-Version: 1.0
In-Reply-To: <YdieAFj0ppmAtQxS@google.com>
References: <YdieAFj0ppmAtQxS@google.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Fri, 7 Jan 2022 15:13:57 -0800
Message-ID: <CAE-0n52HCrp+-7BxsEku0ifmC4P=Rw0SxE4BJ6j1iMd1b7_pNw@mail.gmail.com>
Subject: Re: [PATCH] HID: vivaldi: fix handling devices not using numbered reports
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     "Sean O'Brien" <seobrien@chromium.org>,
        Ting Shen <phoenixshen@google.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Torokhov (2022-01-07 12:09:36)
> Unfortunately details of USB HID transport bled into HID core and
> handling of numbered/unnumbered reports is quite a mess, with
> hid_report_len() calculating the length according to USB rules,
> and hid_hw_raw_request() adding report ID to the buffer for both
> numbered and unnumbered reports.
>
> Untangling it all requres a lot of changes in HID, so for now let's
> handle this in the driver.
>
> Fixes: 14c9c014babe ("HID: add vivaldi HID driver")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

This silences a warning I see printed from this driver

  hid-vivaldi 0003:18D1:504C.0002: failed to fetch feature 0

and then I see the 'function_row_physmap' attribute in sysfs is non-zero
now. Thanks!

Tested-by: Stephen Boyd <swboyd@chromium.org> # CoachZ
