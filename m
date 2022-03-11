Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AFD4D56BB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 01:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244487AbiCKA3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 19:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345279AbiCKA3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 19:29:25 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2621A363D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 16:28:13 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id kt27so15878389ejb.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 16:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KJotzhJGvWm+YufqU6PpQz3ArjHus4r0EIp+aEcC2NQ=;
        b=oU2DYJ9ubZ08kyUFNEx64k2K9ZSCSnvY0QqZ0Ba5UuSoVuPchLbVNNS2cdlTIFV6Q9
         7DYZEpM/tvSuXQlWZw3A7X9peM2zKTIBtbvLMzymLGZoBym4VM9RwpYhC11Ameeb7HAK
         YApwdT56YOWvIUz5M040GJaZ0RzQa2zxjqWzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KJotzhJGvWm+YufqU6PpQz3ArjHus4r0EIp+aEcC2NQ=;
        b=gKJPJsDDuy47FGFn3zl36ILqzNLPSSOlxTk7wXZQE3rsevd6YoJYV6ueWc7vSXblg9
         GvQXA5DeqRGEId6nGyF2iBGZzFzYcxJ3muKrNIJeuLFhvbLdsyErcvZ4ta2HkV/YSwXO
         bCr9Aj5EIQ1WDOQrcxqIf850gX8cBi9GbxUapnat8RuORA6b9uLjvBL845WQQgGOriFs
         o4i0pVBKO6pM82gtbw3aApo2bIka+RHHkX6xOgWe3smPzGashmXQC4uB1zRaw8r7qUZO
         kGHqsjrhJId+zUX7nPF2yIkcbpN+5CgqC5UCWE7t2pRBBONc4ecNTwSptkf/rNE0Ezrx
         09rw==
X-Gm-Message-State: AOAM530OxdQhCnuL65Fu7hRDzWJ4GYAk7+esDPkIzSBrJR6AO/9CRfUW
        jRCiHk7kbkX98bhyWgo9OPVqUn5FYYu54h8cPrw=
X-Google-Smtp-Source: ABdhPJxzxV/Rs2l1e7zAW5QpLKxejblz0Q+LQ/PUe1sPENtPPUh24DxV/ovC3xecmPCyWrZ9TtbKhA==
X-Received: by 2002:a17:906:7f02:b0:6cf:86d8:c31c with SMTP id d2-20020a1709067f0200b006cf86d8c31cmr6689338ejr.518.1646958491612;
        Thu, 10 Mar 2022 16:28:11 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id u4-20020a170906780400b006ce69ff6050sm2328617ejm.69.2022.03.10.16.28.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 16:28:10 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id h15so10597915wrc.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 16:28:10 -0800 (PST)
X-Received: by 2002:a5d:490f:0:b0:1f0:6791:a215 with SMTP id
 x15-20020a5d490f000000b001f06791a215mr5446099wrq.422.1646958490250; Thu, 10
 Mar 2022 16:28:10 -0800 (PST)
MIME-Version: 1.0
References: <20220107200417.1.Ie4dcc45b0bf365077303c596891d460d716bb4c5@changeid>
 <CAD=FV=W5fHP8K-PcoYWxYHiDWnPUVQQzOzw=REbuJSSqGeVVfg@mail.gmail.com> <87sfrqqfzy.fsf@kernel.org>
In-Reply-To: <87sfrqqfzy.fsf@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 10 Mar 2022 16:27:56 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U0Qw-OnKJg8SWk9=e=B0qgqnaTHpuR0cRA0WCmSHSJYQ@mail.gmail.com>
Message-ID: <CAD=FV=U0Qw-OnKJg8SWk9=e=B0qgqnaTHpuR0cRA0WCmSHSJYQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ath10k: search for default BDF name provided in DT
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Abhishek Kumar <kuabhs@chromium.org>,
        Rakesh Pillai <pillair@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        ath10k <ath10k@lists.infradead.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 10, 2022 at 2:06 AM Kalle Valo <kvalo@kernel.org> wrote:
>
> Doug Anderson <dianders@chromium.org> writes:
>
> > Hi,
> >
> > On Fri, Jan 7, 2022 at 12:05 PM Abhishek Kumar <kuabhs@chromium.org> wrote:
> >>
> >> There can be cases where the board-2.bin does not contain
> >> any BDF matching the chip-id+board-id+variant combination.
> >> This causes the wlan probe to fail and renders wifi unusable.
> >> For e.g. if the board-2.bin has default BDF as:
> >> bus=snoc,qmi-board-id=67 but for some reason the board-id
> >> on the wlan chip is not programmed and read 0xff as the
> >> default value. In such cases there won't be any matching BDF
> >> because the board-2.bin will be searched with following:
> >> bus=snoc,qmi-board-id=ff
>
> I just checked, in ath10k-firmware WCN3990/hw1.0/board-2.bin we have
> that entry:
>
> BoardNames[1]: 'bus=snoc,qmi-board-id=ff'
>
> >> To address these scenarios, there can be an option to provide
> >> fallback default BDF name in the device tree. If none of the
> >> BDF names match then the board-2.bin file can be searched with
> >> default BDF names assigned in the device tree.
> >>
> >> The default BDF name can be set as:
> >> wifi@a000000 {
> >>         status = "okay";
> >>         qcom,ath10k-default-bdf = "bus=snoc,qmi-board-id=67";
> >
> > Rather than add a new device tree property, wouldn't it be good enough
> > to leverage the existing variant?
>
> I'm not thrilled either adding this to Device Tree, we should keep the
> bindings as simple as possible.
>
> > Right now I think that the board file contains:
> >
> > 'bus=snoc,qmi-board-id=67.bin'
> > 'bus=snoc,qmi-board-id=67,qmi-chip-id=320,variant=GO_LAZOR.bin'
> > 'bus=snoc,qmi-board-id=67,qmi-chip-id=320,variant=GO_POMPOM.bin'
> > 'bus=snoc,qmi-board-id=67,qmi-chip-id=4320,variant=GO_LAZOR.bin'
> > 'bus=snoc,qmi-board-id=67,qmi-chip-id=4320,variant=GO_POMPOM.bin'
> >
> > ...and, on lazor for instance, we have:
> >
> > qcom,ath10k-calibration-variant = "GO_LAZOR";
> >
> > The problem you're trying to solve is that on some early lazor
> > prototype hardware we didn't have the "board-id" programmed we could
> > get back 0xff from the hardware. As I understand it 0xff always means
> > "unprogrammed".
> >
> > It feels like you could just have a special case such that if the
> > hardware reports board ID of 0xff and you don't get a "match" that you
> > could just treat 0xff as a wildcard. That means that you'd see the
> > "variant" in the device tree and pick one of the "GO_LAZOR" entries.
> >
> > Anyway, I guess it's up to the people who spend more time in this file
> > which they'd prefer, but that seems like it'd be simple and wouldn't
> > require a bindings addition...
>
> In ath11k we need something similar for that I have been thinking like
> this:
>
> 'bus=snoc,qmi-board-id=67,qmi-chip-id=320,variant=GO_LAZOR'
>
> 'bus=snoc,qmi-board-id=67,qmi-chip-id=320'
>
> 'bus=snoc,qmi-board-id=67'
>
> 'bus=snoc'
>
> Ie. we drop one attribute at a time and try to find a suitable board
> file. Though I'm not sure if it's possible to find a board file which
> works with many different hardware, but the principle would be at least
> that. Would something like that work in your case?

I'll leave it for Abhishek to comment for sure since he's been the one
actively involved in keeping track of our board-2.bin file. As far as
I know:

* Mostly we need this for pre-production hardware that developers
inside Google and Qualcomm still have sitting around on their desks. I
guess some people are even still using this pre-production hardware to
surf the web?

* In the ideal world, we think that the best calibration would be to
use the board-specific one in these cases. AKA if board_id is 0xff
(unprogrammed) and variant is "GO_LAZOR" then the best solution would
be to use the settings for board id 0x67 and variant "GO_LAZOR". This
_ought_ to be better settings than the default 0xff settings without
the "GO_LAZOR".

* In reality, we're probably OK as long as _some_ reasonable settings
get picked. WiFi might not be super range optimized but at least it
will still come up and work.

-Doug
