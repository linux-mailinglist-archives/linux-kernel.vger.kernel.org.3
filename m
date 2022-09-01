Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CEC5A8B8D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 04:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbiIACoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 22:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIACo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 22:44:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC4F155A58
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 19:44:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18EF4B823F1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 02:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C877C433D6;
        Thu,  1 Sep 2022 02:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662000264;
        bh=nj1wK38D7utpKkTJ1njEfrJQgpSUxReJtQYeELYi+tc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bvZ0IqkHc+zh3ptHJG3TUao8jb72hqSQiWpshgbqg7bJbRdyEae/xLcnFf6LfHmOd
         t8e7O95WmuBQXi9VE3j6R7/sr/BDi4emXfW8WKecD2NooCozauUxNTB7ujAC4fa3K0
         5G4APhjmbYveyghl2UfbZmU+CCAMTZdrqHNalKgy4AArcwvL9pt11SsXbg3YCu3CeG
         g9UySy7//2tvPmWu4kDlIB7AWLQzRMqBQZaW66h9tHaJnOyT59FNsUoqyXe/qUxnGi
         wJ+3dumhw+V8SkmPoeUwiOhV65uNBUQvyp/gAAJf8+zN98HYlawEdeB2uQMWHElu/o
         5tLgSn14p5oQA==
Date:   Thu, 1 Sep 2022 10:44:21 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Raul Rangel <rrangel@chromium.org>
Cc:     Tim Van Patten <timvp@google.com>,
        Rob Barnes <robbarnes@google.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7] platform/chrome: cros_ec_lpc: Move host command to
 prepare/complete
Message-ID: <YxAchTWf/99oaqix@google.com>
References: <20220823095915.v7.1.I55189adfdb8d025fc991a0fa820ec09078619b15@changeid>
 <CANkg5ezTvzSFLkRWbhMDUqezQXW6996DYVohWMUa+cYwSB+YBw@mail.gmail.com>
 <YxAQaxQXn2YTN1BJ@google.com>
 <CAHQZ30C4-B9ypnsdRqEZCJuZ7QVfaHXaK9f61vTtz_gcvC9EQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHQZ30C4-B9ypnsdRqEZCJuZ7QVfaHXaK9f61vTtz_gcvC9EQQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 08:21:23PM -0600, Raul Rangel wrote:
> On Wed, Aug 31, 2022 at 7:52 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> > > On Tue, Aug 23, 2022 at 9:59 AM Tim Van Patten <timvp@google.com> wrote:
> > > >
> > > > Update cros_ec_lpc_pm_ops to call cros_ec_lpc_prepare() during PM
> > > > .prepare() and cros_ec_lpc_complete() during .complete(). This moves the
> > > > host command that the AP sends and allows the EC to log entry/exit of
> > > > AP's suspend/resume more accurately.
> > > >
> > > > Signed-off-by: Tim Van Patten <timvp@google.com>
> > > > ---
> > > >
> > > > Changes in v7:
> > > > - Rename "host event" to "host command" in title/description.
> > > >
> > > > Changes in v6:
> > > > - Fully restore fixes from v3.
> > > >
> > > > Changes in v5:
> > > > - Restore fixes from v3.
> > > >
> > > > Changes in v4:
> > > > - Update title and description.
> > > >
> > > > Changes in v3:
> > > > - Update cros_ec_lpc_suspend() to cros_ec_lpc_prepare()
> > > > - Update cros_ec_lpc_resume() to cros_ec_lpc_complete()
> > > >
> > > > Changes in v2:
> > > > - Include cros_ec_resume() return value in dev_info() output.
> > > > - Guard setting .prepare/.complete with #ifdef CONFIG_PM_SLEEP.
> >
> 
> > I don't buy-in the ideas from the discussion in v3[1].  Thus, I would defer
> > to other reviewers/maintainers on the list to seek their suggestions.
> >
> > [1]: https://patchwork.kernel.org/project/chrome-platform/patch/20220802113957.v3.1.I2c8c550183162e7594309b66d19af696b8d84552@changeid/
> 
> Just to clarify, you are opposed to printing the return code because
> `cros_ec_resume` currently always returns 0? Or is there another
> objection?

Yes.  I'm not sure if always printing 0 is a good idea.
