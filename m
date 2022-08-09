Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CE358E3D9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 01:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiHIXrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 19:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiHIXrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 19:47:03 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2091A7E83C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 16:47:02 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a7so24911916ejp.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 16:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=3C0nL9povX4hQb5HK7IIK66f7+cBcvjDa1h6azqprzg=;
        b=RaBuDZpu6zzBIxvgMXoxN51Vk+ZxAdblsbYK9vaYmdwZRXvHp6paWHsWzp/Xkt+nUD
         VuDn2VWLSueA7FAOECxIm1zF74oHzMCwP+7bkKBP+9pKZgXCHpZYLQIp9PqhQXDs54vQ
         OjIMhXKpqlAuvVo52Ixl5NrhLGXt/o51CaBcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3C0nL9povX4hQb5HK7IIK66f7+cBcvjDa1h6azqprzg=;
        b=PdmGSmLyT1+sKrV2ss9H/6YToG6fhpCn9tE4z2Qkh+2Fr3jCQe23ZjOwLL7twPDPRC
         tujly4h5GSRT+Wmctlhx31S2UYMK6LqYkU+4sccR+csizJAjkiZO01MK/ut9uqbv250k
         /hGvoVeg0DpIBpaahpZNN4zndQhpHljnzrmyXYerfyAWj5gcup8mQOrhzhZVbc5MxZok
         jDpfKSNeGr1zPP2TkkmBJ6/Gf4crlBJoUoXBU9AWwK9MD13hgV3sQz2zk9tgBGz2+ZVR
         VMRmhAkiT+MzE+lG3BEpevN2/NMlTSIkU8WPKXWk1u1NnlJFOq/OgLULSuFnvnunBXt4
         odWw==
X-Gm-Message-State: ACgBeo0WoVGa0RmKFFBgvkrMtrlbXRLCZgITUA/NI0bfM/4NMPD/0Rsc
        37vNp0r9wqUidurLcAdbVADbA1TFPfzRnQdt
X-Google-Smtp-Source: AA6agR6zDQszXOHH8xQFSEHUq0353VPpdAdqxKuNnb/OaTJNVyYcbQThFZldeRJ1J3Kk542YCJNrZA==
X-Received: by 2002:a17:906:8a57:b0:730:8b50:610a with SMTP id gx23-20020a1709068a5700b007308b50610amr18418156ejc.557.1660088820471;
        Tue, 09 Aug 2022 16:47:00 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906201100b0073100dfa7b0sm1659745ejo.8.2022.08.09.16.46.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 16:46:59 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id p10so15934739wru.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 16:46:58 -0700 (PDT)
X-Received: by 2002:a5d:6da8:0:b0:221:7db8:de0a with SMTP id
 u8-20020a5d6da8000000b002217db8de0amr11266715wrs.405.1660088818467; Tue, 09
 Aug 2022 16:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220727185012.3255200-1-saravanak@google.com> <YuI6shUi6iJdMSfB@kroah.com>
In-Reply-To: <YuI6shUi6iJdMSfB@kroah.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 9 Aug 2022 16:46:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W1P=4vzyTYQ+yVC=fH-7i=hjCAk7FV8jcGcGY+xa62pA@mail.gmail.com>
Message-ID: <CAD=FV=W1P=4vzyTYQ+yVC=fH-7i=hjCAk7FV8jcGcGY+xa62pA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Bring back driver_deferred_probe_check_state() for now
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        kernel-team@android.com, LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 28, 2022 at 12:29 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jul 27, 2022 at 11:50:08AM -0700, Saravana Kannan wrote:
> > More fixes/changes are needed before driver_deferred_probe_check_state()
> > can be deleted. So, bring it back for now.
> >
> > Greg,
> >
> > Can we get this into 5.19? If not, it might not be worth picking up this
> > series. I could just do the other/more fixes in time for 5.20.
>
> Wow, no, it is _WAY_ too late for 5.19 to make a change like this,
> sorry.
>
> What is so broken that we need to revert these now?  I could do so for
> 5.20-rc1, and then backport to 5.19.y if that release is really broken,
> but this feels odd so late in the cycle.

I spent a bunch of time bisecting mainline today on my
sc7180-trogdor-lazor board. When building the top of Linus's tree
today the display doesn't come up. I can make it come up by turning
fw_devlink off (after fixing a regulator bug that I just posted a fix
for).

I found that the first bad commit was commit 5a46079a9645 ("PM:
domains: Delete usage of driver_deferred_probe_check_state()")

...but only when applied to mainline. When I cherry-pick that back to
v5.19-rc1 (and pick another bugfix needed to boot my board against
v5.19-rc1) then it works OK. After yet more bisecting, I found that on
trogdor there's a bad interaction with the commit e511a760 ("arm64:
dts: qcom: sm7180: remove assigned-clock-rate property for mdp clk").
That commit is perfectly legit but I guess it somehow changed how
fw_devlink was interpreting things?

Sure enough, picking this revert series fixes things on Linus's tree.
Any chance we can still get the revert in for v5.20-rc1? ;-)


-Doug
