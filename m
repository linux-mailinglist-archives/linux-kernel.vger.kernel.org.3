Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23044AE51C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiBHW7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiBHW7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 17:59:04 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7011C061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 14:59:02 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id y203so868092yby.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 14:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AGzDON1aKbzLetDZlMCnjknqeLyLCCcPTzjSkYj9G4k=;
        b=EL8KgSe79vCVLCE0MOWC+XDo3o6kAvlEKG5flT4MS6v2TshmBUjTnsiz7lsf+w6LR+
         BVbIexnKbvz6HGfDFI/ySGjQX645e2A+7ff+eQInNh2aFatNQ6n5x4XE6Iyiy9FV06hL
         CQpCK2nOsHK4XLa9Jy/dcqjMCqc+SM8ET1mL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AGzDON1aKbzLetDZlMCnjknqeLyLCCcPTzjSkYj9G4k=;
        b=rOMaMRi9dpwTE11mYam7dz3nSNdEt9odnJKdNf2c5GokQWl4QOlJMoE+uUH8jJKNZV
         REJXNco4KA2D2PLiKLvscst675MGWRcs8ovIR8pbECXmq1vUsAmCUHAjm7naBNbuz4LA
         AMsqOVL5vBXVfU9Rs0G4T3jHwkVRWhAoGTgDpZEhj0SLnIWzeYUavhAjYxf6PB9kIT0T
         pbh8JxefeLafqA9PTc0QsDnNxL+0kKb3s1ijN1/mqGcYe0CsBPBo6eyymRVW5ooxOXwl
         uscN7YT96FOhIn4UGKz5H8lPy/EHkr+19GF33WoFZ2InYy1jIAWXk/Rq7NSScuDjjU1d
         9mnQ==
X-Gm-Message-State: AOAM532oRdLgGYa2T+W2LY7Wxo2X6OrIHbfPziqC1uzHV7ZQ66SRHflO
        9qDYTq56IWXcLDD2e3DKwkKaeb8ZpYTb0m2Hj9gvfw==
X-Google-Smtp-Source: ABdhPJyuo4KAjwHo+/b2WIN+jbHKYnvxgSAQfKnQHJwR5IJS+W11eXsw/S7k+33zQLL1cyN7i+3PnNLExQUgkeKKXDk=
X-Received: by 2002:a81:b54a:: with SMTP id c10mr6995520ywk.283.1644361141958;
 Tue, 08 Feb 2022 14:59:01 -0800 (PST)
MIME-Version: 1.0
References: <20220207214026.1526151-1-pmalani@chromium.org>
 <20220207214026.1526151-4-pmalani@chromium.org> <YgIBv2SQdwXm7RLt@google.com>
 <CACeCKaezRNgsqrq3QJ1ViHjYScFrjpC-kCaYmE8kOXCcW9MRrw@mail.gmail.com>
 <YgJQ30D8nc4LWvUy@google.com> <CACeCKaf4+jxSkKFqx9g3YSPWj-FkbL=jrmHE3YEu7oU0ySPJ4Q@mail.gmail.com>
In-Reply-To: <CACeCKaf4+jxSkKFqx9g3YSPWj-FkbL=jrmHE3YEu7oU0ySPJ4Q@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 8 Feb 2022 14:58:51 -0800
Message-ID: <CACeCKadujMj4pJqf_jNNmO4UkQinw9QNu_MXe5zkTySUn6R=dw@mail.gmail.com>
Subject: Re: [PATCH 3/4] platform/chrome: cros_ec_typec: Configure muxes at
 start of port update
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:CHROMEOS EC USB TYPE-C DRIVER" 
        <chrome-platform@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 8, 2022 at 10:35 AM Prashant Malani <pmalani@chromium.org> wrote:
>
> On Tue, Feb 8, 2022 at 3:15 AM Tzung-Bi Shih <tzungbi@google.com> wrote:
> >
> > On Mon, Feb 07, 2022 at 10:12:10PM -0800, Prashant Malani wrote:
> > > On Mon, Feb 7, 2022 at 9:38 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
> > > > On Mon, Feb 07, 2022 at 09:40:28PM +0000, Prashant Malani wrote:
> > > > > There are situations where the mux state reported by the Embedded
> > > > > Controller (EC), might lag the partner "connected" state. So, the mux
> > > > > state might still suggest that a partner is connected, while the PD
> > > > > "connected" state, being in Try.SNK (for example) suggests that the
> > > > > partner is disconnected.
> > > > >
> > > > > In such a scenario, we will end up sending a disconnect command to the
> > > > > mux driver, followed by a connect command, since the mux is configured
> > > > > later. Avoid this by configuring the mux before
> > > > > registering/disconnecting a partner.
> > > >
> > > > I failed to understand the description.  It looks like some protocol details.
> > > > Could you provide some brief explanation in the commit message?
> > >
> > > I'm not sure how else I can better elaborate on this in the commit message than
> > > as currently stated.
> > > Since the EC is an independent controller, the mux state *can* lag the
> > > "connected" state.
> > > So, as described in the commit message, when a disconnect happens, we could have
> > > a disconnect (since PD_CTRL contains the "connected state") followed
> > > by a configure_mux
> > > with the mux state still suggesting a connected device (the drivers
> > > which implement the
> > > mux/switch controls can misconstrue the old mux state) which results
> > > in a connect. This
> > > patch eliminates that.
> >
> > Pardon me if I ask, I am trying to understand why reorder the function calls
> > in cros_typec_port_update() can fix the issue.  And I am wondering if the
> > issue has fixed by the 4th patch in the series.
>
> It's not completely fixed by that; that is just an outstanding missing
> state update.
> If we just use just that patch, configure_mux() will still be executed
> before the code in patch 4 runs.
>
> >
> > To make sure I understand the issue correctly, imaging a "disconnect" event
> > in cros_typec_port_update() originally:
> >
> > a. Get pd_ctrl via EC_CMD_USB_PD_CONTROL[1].
> >
> > b. Call cros_typec_remove_partner() in cros_typec_set_port_params_v1()[2].
> > Is it the "disconnect" you were referring in the example?
> >
> > c. Get mux info via EC_CMD_USB_PD_MUX_INFO.
> > Did you mean the mux info might be stale which is "partner connected"?
>
> Yes, it can.
>
> >
> > d. Call cros_typec_enable_dp() in cros_typec_configure_mux()[3].
> > Does it result in another connect?
>
> It can occur much earlier, depending on what the mux state is (example: [1])
>
> >
> > [1]: https://elixir.bootlin.com/linux/v5.17-rc3/source/drivers/platform/chrome/cros_ec_typec.c#L955
> > [2]: https://elixir.bootlin.com/linux/v5.17-rc3/source/drivers/platform/chrome/cros_ec_typec.c#L628
> > [3]: https://elixir.bootlin.com/linux/v5.17-rc3/source/drivers/platform/chrome/cros_ec_typec.c#L548
> >
> > If the above understanding is correct, the patch fixes it by moving step b to
> > the last.  As a result, it won't have a "disconnect" -> "connect" transition.
>
> Yes
> >
> > Further questions:
> >
> > - If mux info from step c would be stale, won't it exit earlier in [4]?
> >
> > [4]: https://elixir.bootlin.com/linux/v5.17-rc3/source/drivers/platform/chrome/cros_ec_typec.c#L986
> >
> > - The 4th patch[5] sets mux_flags to USB_PD_MUX_NONE.  If it won't exit earlier
> >   from previous question, won't it fall into [6]?
>
> No. it depends on the mux flags and the pd_ctrl response.
>
> >
> > [5]: https://patchwork.kernel.org/project/chrome-platform/patch/20220207214026.1526151-5-pmalani@chromium.org/
> > [6]: https://elixir.bootlin.com/linux/v5.17-rc3/source/drivers/platform/chrome/cros_ec_typec.c#L523
>
> This link [6] points to cros_typec_enable_usb4(); it's doesn't relate
> to your statement above.

Sorry, I misread where the link was pointing to. That said, it still
won't fall into the condition you quoted.
The configure_mux() is called first, then the
cros_typec_set_port_params_v1() is called.


>
> >
> > > > > @@ -965,6 +965,11 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
> > > > >       if (ret < 0)
> > > > >               return ret;
> > > > >
> > > > > +     /* Update the switches if they exist, according to requested state */
> > > > > +     ret = cros_typec_configure_mux(typec, port_num, &resp);
> > > > > +     if (ret)
> > > > > +             dev_warn(typec->dev, "Configure muxes failed, err = %d\n", ret);
> > > >
> > > > It used the fact that the function returns `ret` at the end.  After the move,
> > > > the block is no longer the last thing before function returns.
> > > >
> > > > Does it make more sense to return earlier if cros_typec_configure_mux() fails?
> > > > Does the rest of code need to be executed even if cros_typec_configure_mux()
> > > > fails?
> > >
> > > Yes, it should still be executed (we still need to update the port
> > > state). That is why the return is eliminated.
> >
> > Got it, as long as it is intended.
> >
> > > > > @@ -980,11 +985,6 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
> > > > >       if (typec->typec_cmd_supported)
> > > > >               cros_typec_handle_status(typec, port_num);
> > > > >
> > > > > -     /* Update the switches if they exist, according to requested state */
> > > > > -     ret = cros_typec_configure_mux(typec, port_num, &resp);
> > > > > -     if (ret)
> > > > > -             dev_warn(typec->dev, "Configure muxes failed, err = %d\n", ret);
> > > > > -
> > > > >       return ret;
> > > >
> > > > If the function decides to return earlier, it can be `return 0;`.
> > > Sure, I can change this in the next version
> >
> > No, I guess you would like to leave it as is to propagate return value from
> > cros_typec_configure_mux().
>
> No, it is better to not propogate that return value (we're doing it
> earlier, but there isn't
> anything the caller can do about it). We should just print a warn and
> still update the port
> state (userspace still reads the port state).
>
> In general, I think you may benefit from reading:
> - The entire cros_ec_typec driver
> - The EC Type C state machine [2] and interfaces [3][4]
>
> The above 2 will help understand how this entire stack works. Without
> it, it is challenging
> to process the flow (just from code review).
>
> If you have further questions our would like to better understand the
> drivers, feel free to reach
> out to me over IM/email. I don't think public list code review is the
> best option for this
> sort of explanation.
>
> [1] https://elixir.bootlin.com/linux/latest/source/drivers/platform/chrome/cros_ec_typec.c#L549
> [2] https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/common/usbc/
> [3] https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/driver/usb_mux/usb_mux.c
> [4] https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/common/usb_pd_host_cmd.c
