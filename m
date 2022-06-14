Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D99A54A976
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 08:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352123AbiFNGbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 02:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352185AbiFNGaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:30:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA1D37A17
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 23:30:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38F30B8169F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 06:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6ECC3411B;
        Tue, 14 Jun 2022 06:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655188247;
        bh=jjLucxVfYponZZbTy9aAXqu9kv3d9EqWhXxAmri77yk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jDtlif+OOvJpKdA8CtAXUlFZEcek3+IzpLAW59f0C+maa77x2kY9RWblSlvKF3eNG
         X5OaczZNlBxu+5paKOXWG6wCdoafksB8DEJR4piKi5ZLpGMW8NRi/mPlGlbs/n6iNl
         BPA121LoYnfJq/ZaHLfLz5gEl3Un/O/1a/VhBQW8vHVBD2+lQaeOrePRF1E6P47PQF
         EG7ix6IPAWP7hPVHHVFWkdi680312IUmjzR7+apH3Dv5LL223FlaFabuUcbPYTwW9R
         xIE+isTWg9j07CrMXZnWr/6itBLdoL7hkjsV8lJpdRJXXju17OrriIB4J7l6KtB71L
         KvgB7IGi+lNxg==
Date:   Tue, 14 Jun 2022 06:30:44 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, Evan Green <evgreen@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v2] platform/chrome: cros_ec: Always expose last resume
 result
Message-ID: <YqgrFORv5rMggcLs@google.com>
References: <20220611061825.4119270-1-swboyd@chromium.org>
 <Yqgc6sD7bEHLVYRg@google.com>
 <CAE-0n53aiXq+eUC0gq=J0kO+_zFpZGnL42AgyEBVM-_wtccnJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n53aiXq+eUC0gq=J0kO+_zFpZGnL42AgyEBVM-_wtccnJA@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 11:17:50PM -0700, Stephen Boyd wrote:
> Quoting Tzung-Bi Shih (2022-06-13 22:30:18)
> > On Fri, Jun 10, 2022 at 11:18:25PM -0700, Stephen Boyd wrote:
> > > @@ -135,10 +135,10 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
> > >       buf.msg.command = EC_CMD_HOST_SLEEP_EVENT;
> > >
> > >       ret = cros_ec_cmd_xfer_status(ec_dev, &buf.msg);
> > > -
> > > -     /* For now, report failure to transition to S0ix with a warning. */
> > > +     /* Report failure to transition to system wide suspend with a warning. */
> > >       if (ret >= 0 && ec_dev->host_sleep_v1 &&
> > > -         (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME)) {
> > > +         (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME ||
> > > +          sleep_event == HOST_SLEEP_EVENT_S3_RESUME)) {
> > >               ec_dev->last_resume_result =
> > >                       buf.u.resp1.resume_response.sleep_transitions;
> >
> > The warning in the if-block:
> > WARN_ONCE(buf.u.resp1.resume_response.sleep_transitions &
> >           EC_HOST_RESUME_SLEEP_TIMEOUT,
> >           "EC detected sleep transition timeout. Total slp_s0 transitions: %d",
> >           buf.u.resp1.resume_response.sleep_transitions &
> >           EC_HOST_RESUME_SLEEP_TRANSITIONS_MASK);
> >
> > Not sure and I wonder if the term "slp_s0" is still generic enough to the case.
> > And also [1].
> >
> > [1]: https://crrev.com/a311a7657ca0a488f507fa78fd9c2d825cbf083e/power_manager/powerd/system/suspend_configurator.cc#98
> 
> I don't know what "slp_s0" means. I guess it's some intelism? It could
> change to "sleep" and work for me.
> 
> >
> > At least we should fix [2] once the patch landed.
> >
> > [2]: https://crrev.com/a311a7657ca0a488f507fa78fd9c2d825cbf083e/power_manager/tools/suspend_stress_test#369
> 
> And by fix you mean change "S0iX" to "suspend"?

Yes.
