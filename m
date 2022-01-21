Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9AD44967ED
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 23:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbiAUWm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 17:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiAUWm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 17:42:26 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1228C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 14:42:25 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id u5so8831269ilq.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 14:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kSZGvQ/PhqOAa5UV8ZigO6yQNjGC7UfSjALFxNrTjuA=;
        b=YzO6G0ZVqVWf3w1A5HcCIlHDpYyK+WH6nCTbJCOQv9NU71+MiUx6wuo4wXdAep8b6Q
         EhO8NxIMn2z31HKpOqfDBW6NmyfJ8J+7OIYpy8lyAF9wsGREo/3NE40TuO2uhR17jvA4
         jtYSliwVEhP6HDzXz7YWq/CoI5MYMOzs8fqwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kSZGvQ/PhqOAa5UV8ZigO6yQNjGC7UfSjALFxNrTjuA=;
        b=mFhTsbfgdc0xOc1fmxFnklEraUm1Tpl25fBs9tIpDy3CDCS2F7lv5yw3qtGjnngho7
         yZjGyJwmsGqZPB/84RCRnKFzo7/m7RJNBpqLNQznlQsjOFiwVqGY1wwecTJWkRt4Nkll
         4Q5Fb3WhLxF0RKpQ2Z1fEVRIe20KwK6u7Px9+LwxaDQIblMJT9dGyjx6ycTgBFBmra/J
         ulT2nCAX0C3TZrUHv+brq1k4pnhSV5As8o7tBHcjmldHj30GTyT6YuSyopgqHWp/+2O5
         4yfNUCkh8Cq2hNI4qRMkTPMLqEbaM/qjlke4D0u37kTHkz7RspRqFJNfgEyphNXAnxYO
         MWKA==
X-Gm-Message-State: AOAM533GoJLW5hTbMDXXzsUwSG/gcgNpehQhPxESHKMNVmGo6g/Z7SyD
        1cfBePp99pVVBAtzwL6x0xrH/FXWU1LHyg==
X-Google-Smtp-Source: ABdhPJyVqoM1a/uLMBUSk/ogei//ahLU5Z1xXAVOSqUzdxVbAU+A1uX9ipxmmOBYykW3D0irPb9NbQ==
X-Received: by 2002:a05:6e02:1985:: with SMTP id g5mr3364452ilf.183.1642804945282;
        Fri, 21 Jan 2022 14:42:25 -0800 (PST)
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com. [209.85.166.178])
        by smtp.gmail.com with ESMTPSA id z6sm3723928ilu.42.2022.01.21.14.42.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 14:42:25 -0800 (PST)
Received: by mail-il1-f178.google.com with SMTP id u5so8831216ilq.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 14:42:23 -0800 (PST)
X-Received: by 2002:a05:6e02:180c:: with SMTP id a12mr3372919ilv.142.1642804943188;
 Fri, 21 Jan 2022 14:42:23 -0800 (PST)
MIME-Version: 1.0
References: <20220121064427.32059-1-quic_youghand@quicinc.com>
In-Reply-To: <20220121064427.32059-1-quic_youghand@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 21 Jan 2022 14:42:11 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X30mRSFcMeOav87g5qzco_J=-rag3rqyCAYOw0D_Ao0A@mail.gmail.com>
Message-ID: <CAD=FV=X30mRSFcMeOav87g5qzco_J=-rag3rqyCAYOw0D_Ao0A@mail.gmail.com>
Subject: Re: [RFC 0/2] ath10k:set tx credit to one and delay the unmaping
To:     Youghandhar Chintala <quic_youghand@quicinc.com>
Cc:     ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, quic_pillair@quicinc.com,
        Abhishek Kumar <kuabhs@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 20, 2022 at 10:44 PM Youghandhar Chintala
<quic_youghand@quicinc.com> wrote:
>
> Currently for WCN3990, the host driver can send two wmi commands at once,
> now it is limiting to one because if HOST wants to initiate 2 DMA transfe=
rs,
> it is possible when copy complete interrupt for first DMA reaches HOST,
> CE has already updated SRRI for both DMA transfers and is in the middle
> of 2nd DMA. HOST uses SRRI to interpret how many DMA=E2=80=99s have been =
completed
> and tries to unmap/free both the DMA entries, but CE is still in the midd=
le
> of 2nd DMA which can cause SMMU issues or corruption.
>
> We are seeing a corner case smmu fault issue where copy engine is still a=
ccessing
> the memory though host unmaps it hence as work around we are delaying the
> unmapping the memory and tx credit to one.
>
> Youghandhar Chintala (2):
>   ath10k: Set tx credit to one for wcn3990 snoc based devices
>   ath10k: Delay the unmapping of the buffer
>
>  drivers/net/wireless/ath/ath10k/core.c | 30 ++++++++++++++++++++++++++
>  drivers/net/wireless/ath/ath10k/htc.c  | 18 +++++++++++++---
>  drivers/net/wireless/ath/ath10k/htc.h  |  1 +
>  drivers/net/wireless/ath/ath10k/hw.h   |  6 ++++++
>  4 files changed, 52 insertions(+), 3 deletions(-)

I don't understand the root cause here myself. I also don't have
enough skin in the game to say whether this is the best/cleanest way
to work around the problem. Thus I'll refrain from a Reviewed-by tag.
That being said, I did a bunch of testing of this solution and I also
am aware of others that have tested it. Thus I'm convinced that it at
least works around the problem that has been observed. Hence:

Tested-by: Douglas Anderson <dianders@chromium.org>

In my case I was on the same (or nearly the same) hardware as
Youghandhar, though I had a slightly older build. FWIW:

Tested-on: WLAN.HL.3.2.2.c10-00754-QCAHLSWMTPL-1

-Doug
