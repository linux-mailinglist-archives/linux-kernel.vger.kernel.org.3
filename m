Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802FC54A94C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 08:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239853AbiFNGSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 02:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240149AbiFNGRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:17:55 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84352FFF9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 23:17:51 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id bf7so9233460oib.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 23:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=gOEl91mjcJeb3w5SzAgKFGPOqBzDaIuMhG5InT1ls1E=;
        b=THuDK5XPApSFGyrtaoCGy7gUt4PXTVEJSdeZJFL1xpqFgV1avMFFtdPiQC+2wRul08
         KheYxd3YdmF4qhojKX8MjxGYuo+y8+eSE+aavqVrtO+VlSCToLWqNs/J+nY7WhiRSR/W
         D/MFEvizYq4nBCWbd5uKKEG46Dhpsnfrzu9oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=gOEl91mjcJeb3w5SzAgKFGPOqBzDaIuMhG5InT1ls1E=;
        b=ZuBp21JQUJJrYjvz4zMgPNnZuAwgB7t0UFLkxEwXX2Ey+gwqy/YhI2jrG9Y7kS/zvW
         /OWnRF/NCEi63FDoEOU8LLAm9XQbbolpb0HzM063/Orn0bhAwLyZOn9vmKqHyGP/nzKR
         6ZmiMgXv8IXFFj3Dfgl8hz9CnU3t5UN8C01+uANg5He9ShtRhb12+4XTuAFau3sHV4vY
         2njg76SPjbUssfoEocp46Z+h6QqtLDkgDaEkhL6YaNipW7FLPd1+E0PRPcyp91X91pV5
         fqvBcAXXNJsdkvx5w5SxS+i90+lJca3QWMbyDGPuY/i1QpLBgo1BPLUIwbsEdZ2JCoN0
         7LAQ==
X-Gm-Message-State: AOAM531p93/3NWlbej+qd299uJYzkThHRzCcR8AUngIYzKK9uvaego/p
        z/tbmQsFhWcRQTuCfbGPOE+CFVcPDYjihrmev8LqqA==
X-Google-Smtp-Source: ABdhPJzJAd9THv709T3xWg4FPuEIorZIfFmHVI1lG7V+TxQeJUuHS/awP2qLLjLflIxpvFu2uABRmPX5vG9rirgFSNY=
X-Received: by 2002:a05:6808:e87:b0:32e:4789:d2c with SMTP id
 k7-20020a0568080e8700b0032e47890d2cmr1220154oil.193.1655187471061; Mon, 13
 Jun 2022 23:17:51 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Jun 2022 23:17:50 -0700
MIME-Version: 1.0
In-Reply-To: <Yqgc6sD7bEHLVYRg@google.com>
References: <20220611061825.4119270-1-swboyd@chromium.org> <Yqgc6sD7bEHLVYRg@google.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 13 Jun 2022 23:17:50 -0700
Message-ID: <CAE-0n53aiXq+eUC0gq=J0kO+_zFpZGnL42AgyEBVM-_wtccnJA@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: cros_ec: Always expose last resume result
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, Evan Green <evgreen@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tzung-Bi Shih (2022-06-13 22:30:18)
> On Fri, Jun 10, 2022 at 11:18:25PM -0700, Stephen Boyd wrote:
> > @@ -135,10 +135,10 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
> >       buf.msg.command = EC_CMD_HOST_SLEEP_EVENT;
> >
> >       ret = cros_ec_cmd_xfer_status(ec_dev, &buf.msg);
> > -
> > -     /* For now, report failure to transition to S0ix with a warning. */
> > +     /* Report failure to transition to system wide suspend with a warning. */
> >       if (ret >= 0 && ec_dev->host_sleep_v1 &&
> > -         (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME)) {
> > +         (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME ||
> > +          sleep_event == HOST_SLEEP_EVENT_S3_RESUME)) {
> >               ec_dev->last_resume_result =
> >                       buf.u.resp1.resume_response.sleep_transitions;
>
> The warning in the if-block:
> WARN_ONCE(buf.u.resp1.resume_response.sleep_transitions &
>           EC_HOST_RESUME_SLEEP_TIMEOUT,
>           "EC detected sleep transition timeout. Total slp_s0 transitions: %d",
>           buf.u.resp1.resume_response.sleep_transitions &
>           EC_HOST_RESUME_SLEEP_TRANSITIONS_MASK);
>
> Not sure and I wonder if the term "slp_s0" is still generic enough to the case.
> And also [1].
>
> [1]: https://crrev.com/a311a7657ca0a488f507fa78fd9c2d825cbf083e/power_manager/powerd/system/suspend_configurator.cc#98

I don't know what "slp_s0" means. I guess it's some intelism? It could
change to "sleep" and work for me.

>
> At least we should fix [2] once the patch landed.
>
> [2]: https://crrev.com/a311a7657ca0a488f507fa78fd9c2d825cbf083e/power_manager/tools/suspend_stress_test#369

And by fix you mean change "S0iX" to "suspend"?
