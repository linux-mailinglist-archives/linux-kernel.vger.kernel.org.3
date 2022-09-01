Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070ED5A9C39
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbiIAPvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234624AbiIAPvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:51:11 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD515FAD3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 08:51:08 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-3376851fe13so341433937b3.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 08:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=9/85cTHq3emRQ3FYqSmuCNE4ONe2BFqYrwpiqVZJ/+I=;
        b=GLqdEt2U0HzwcNjRmjhPqqIu6x/w6F2LttPAZi7J0vfn/J2WsIDmFyWmI6WyeOdaxs
         JQLZcdRpfZI2EYzI+ydaUbWGOr7pR+CIUOzU/u7wNJd1oyIT1S+QUh41GimnENcOPBLC
         u95SYoLU4aivhXW/fsnYdRYo6fH1qCqKERjxTRywmjZML0N6nAOf766qae6zCGYIf04Z
         mel+yueezG/blln/Q7oQFiXbGkyyGPy6GjKXA8PBcjIan2bjAqvzNsFDpCJAwXPaLzJs
         j0Q/GC9DhAleZ1oc0PKXXx7BFwMCE4WuuFlj2ReeZNWrfmjv+EYHZlnMHTg2kNwxkPCV
         efBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=9/85cTHq3emRQ3FYqSmuCNE4ONe2BFqYrwpiqVZJ/+I=;
        b=Ue1/o2ba/7yiHNo76TEEZ2ZH2xlS02EcgmsyqF0Du488si8gXFcEiGm1eqYS00owme
         GIJHdQwb5fy7cjlQ5WFQgB5NbrKARafSMZqY3wOkbbjQEO+TvkM2i/ZD9XaC8gXCW1is
         iEhgs2hRSELOfvFeQL7GL9Nt8CFsl1CYQQvsRsd7w0rgWUDrt0sCWecR0Ed9+hc9lcxY
         fpD9cUpRUcc34DYkt3ZPNRzf2G2pgTJr0aZ9eCKDimyY1B2MrUHjAxUz1zLol+kHaGh0
         vsGO1loo2vabgWnfLDWlx9b0BMr6IUmxZCCQ61hEE9/j9JeLtifH4msR1jfZj7k4KUIY
         H4mw==
X-Gm-Message-State: ACgBeo2l/ypf1xpaVoNNTP6TmAkAQgW7VDb1d6p08lnixMRYzLTIP/qd
        nlnxe8EVv+xbneGm0QFWNrcOW5ha7rwzcRC56Dkc/g==
X-Google-Smtp-Source: AA6agR7eihsqKGGZ03rwk9JoEJ1V06h0gbOgwGz7mci0vwEegX0oe/aTUXPvZQI1j8Xh/RBPv2iEYvHYLlSYtoQ7htg=
X-Received: by 2002:a0d:eb4f:0:b0:341:8004:8ebd with SMTP id
 u76-20020a0deb4f000000b0034180048ebdmr11329175ywe.396.1662047467426; Thu, 01
 Sep 2022 08:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220823095915.v7.1.I55189adfdb8d025fc991a0fa820ec09078619b15@changeid>
 <CANkg5ezTvzSFLkRWbhMDUqezQXW6996DYVohWMUa+cYwSB+YBw@mail.gmail.com>
 <YxAQaxQXn2YTN1BJ@google.com> <CAHQZ30C4-B9ypnsdRqEZCJuZ7QVfaHXaK9f61vTtz_gcvC9EQQ@mail.gmail.com>
 <YxAchTWf/99oaqix@google.com>
In-Reply-To: <YxAchTWf/99oaqix@google.com>
From:   Tim Van Patten <timvp@google.com>
Date:   Thu, 1 Sep 2022 09:50:56 -0600
Message-ID: <CANkg5exCTrFVMidSnf1aB6mvwNSKXfFjE6P0NxZJHN0HC8qxGg@mail.gmail.com>
Subject: Re: [PATCH v7] platform/chrome: cros_ec_lpc: Move host command to prepare/complete
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Raul Rangel <rrangel@chromium.org>,
        Rob Barnes <robbarnes@google.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 8:44 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> On Wed, Aug 31, 2022 at 08:21:23PM -0600, Raul Rangel wrote:
> > On Wed, Aug 31, 2022 at 7:52 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> > > > On Tue, Aug 23, 2022 at 9:59 AM Tim Van Patten <timvp@google.com> wrote:
> > > > >
> > > > > Update cros_ec_lpc_pm_ops to call cros_ec_lpc_prepare() during PM
> > > > > .prepare() and cros_ec_lpc_complete() during .complete(). This moves the
> > > > > host command that the AP sends and allows the EC to log entry/exit of
> > > > > AP's suspend/resume more accurately.
> > > > >
> > > > > Signed-off-by: Tim Van Patten <timvp@google.com>
> > > > > ---
> > > > >
> > > > > Changes in v7:
> > > > > - Rename "host event" to "host command" in title/description.
> > > > >
> > > > > Changes in v6:
> > > > > - Fully restore fixes from v3.
> > > > >
> > > > > Changes in v5:
> > > > > - Restore fixes from v3.
> > > > >
> > > > > Changes in v4:
> > > > > - Update title and description.
> > > > >
> > > > > Changes in v3:
> > > > > - Update cros_ec_lpc_suspend() to cros_ec_lpc_prepare()
> > > > > - Update cros_ec_lpc_resume() to cros_ec_lpc_complete()
> > > > >
> > > > > Changes in v2:
> > > > > - Include cros_ec_resume() return value in dev_info() output.
> > > > > - Guard setting .prepare/.complete with #ifdef CONFIG_PM_SLEEP.
> > >
> >
> > > I don't buy-in the ideas from the discussion in v3[1].  Thus, I would defer
> > > to other reviewers/maintainers on the list to seek their suggestions.
> > >
> > > [1]: https://patchwork.kernel.org/project/chrome-platform/patch/20220802113957.v3.1.I2c8c550183162e7594309b66d19af696b8d84552@changeid/
> >
> > Just to clarify, you are opposed to printing the return code because
> > `cros_ec_resume` currently always returns 0? Or is there another
> > objection?
>
> Yes.  I'm not sure if always printing 0 is a good idea.

We want the print statements to know when the EC sees suspend/resume
start/complete.   Having two versions of the same print statement, but
picking the correct one based on whether the return value is non-zero
is a bad design, which is why it always prints the return value.
Ignoring the return value entirely is also a bad design, since it can
change in the future. For example if cros_ec_resume() is updated to
pass along a bad return value instead of swallowing it always
returning 0.

-- 

Tim Van Patten | ChromeOS | timvp@google.com | (720) 432-0997
