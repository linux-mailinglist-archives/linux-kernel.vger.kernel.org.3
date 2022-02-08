Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94A74AD15C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 07:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346611AbiBHGM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 01:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346513AbiBHGMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 01:12:23 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7D8C0401EF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 22:12:23 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id bt13so22934187ybb.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 22:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OLS1qG2/31/qv95jBrunYz8W6LmWRIuON498ceRNCdU=;
        b=Q/LnvOvx7/obZ/wdiMqJNB/3sgZQ9TkVmhG8RJcQVbM/RAJKOyeUZsThaytxw5LwRG
         F0V7L/LF99sYMeIGsXtarFL53NlT+j40Yr4IR7/XK32DqxUEfzvupmSYQI5knbiAtdiE
         hbR1SIKE7mb3cRGGQMy4PnupF1nHo56/yPtzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OLS1qG2/31/qv95jBrunYz8W6LmWRIuON498ceRNCdU=;
        b=EhDtJyKM2cp8ZgtiXNbLwnyayTNLk7MFRitVie/wECYXi0O3NGs261P35fO+53rIXd
         u6tbYm//jT0kXZnsEToIlwntc3CP9zU2l0U/6sbpaqCf60uwp9nkDqczZeGL6RKCokNE
         e7km6CV2ZQkBrSdrBM8Z+QK9BpbkZt+QqX6RVlXxoIqXjMnjZ0mSBHu+k+DABNneh48P
         6RrAdw9LsOyov9VeLYk98rudZkaN6W6ETdjdhzbBjBT5JJJDYe6aZWL7FNXhJAPAPw7r
         BSX3xsMVZiImH54bW5LMHc1nNwDkV7vIGzGZRD0O6OGwj4Bk0r7RFKFbpQ2+hqDq9jRm
         Rvlw==
X-Gm-Message-State: AOAM530INPhzSz15TxQml/lUdKcrWBidXh0oYHhqLj3L9YN38UI5WSOD
        fPNUc58rWf0CyVrW5wz7GDRJKlxX8iNuwqiL+h98yA==
X-Google-Smtp-Source: ABdhPJxOPkZl//mWeFNC4iG9V3hjqFnSJwuUjnu2Vdy5KQg2ABwkunMvuTuvMx6CptgF3dGHlnD19raQKa+8V7xy478=
X-Received: by 2002:a25:be43:: with SMTP id d3mr3156548ybm.454.1644300742373;
 Mon, 07 Feb 2022 22:12:22 -0800 (PST)
MIME-Version: 1.0
References: <20220207214026.1526151-1-pmalani@chromium.org>
 <20220207214026.1526151-4-pmalani@chromium.org> <YgIBv2SQdwXm7RLt@google.com>
In-Reply-To: <YgIBv2SQdwXm7RLt@google.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 7 Feb 2022 22:12:10 -0800
Message-ID: <CACeCKaezRNgsqrq3QJ1ViHjYScFrjpC-kCaYmE8kOXCcW9MRrw@mail.gmail.com>
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

Hi Tzung-Bi,

On Mon, Feb 7, 2022 at 9:38 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> On Mon, Feb 07, 2022 at 09:40:28PM +0000, Prashant Malani wrote:
> > There are situations where the mux state reported by the Embedded
> > Controller (EC), might lag the partner "connected" state. So, the mux
> > state might still suggest that a partner is connected, while the PD
> > "connected" state, being in Try.SNK (for example) suggests that the
> > partner is disconnected.
> >
> > In such a scenario, we will end up sending a disconnect command to the
> > mux driver, followed by a connect command, since the mux is configured
> > later. Avoid this by configuring the mux before
> > registering/disconnecting a partner.
>
> I failed to understand the description.  It looks like some protocol details.
> Could you provide some brief explanation in the commit message?

I'm not sure how else I can better elaborate on this in the commit message than
as currently stated.
Since the EC is an independent controller, the mux state *can* lag the
"connected" state.
So, as described in the commit message, when a disconnect happens, we could have
a disconnect (since PD_CTRL contains the "connected state") followed
by a configure_mux
with the mux state still suggesting a connected device (the drivers
which implement the
mux/switch controls can misconstrue the old mux state) which results
in a connect. This
patch eliminates that.

>
> On a related note, followed up the example scenario, which one of the
> understanding is the most applicable:
> 1) The disconnect followed by a connect is suboptimal.  The patch cleans it.
> 2) The disconnect followed by a connect is a bug.  The patch fixes it.
This one (number 2)

>
> > @@ -965,6 +965,11 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
> >       if (ret < 0)
> >               return ret;
> >
> > +     /* Update the switches if they exist, according to requested state */
> > +     ret = cros_typec_configure_mux(typec, port_num, &resp);
> > +     if (ret)
> > +             dev_warn(typec->dev, "Configure muxes failed, err = %d\n", ret);
>
> It used the fact that the function returns `ret` at the end.  After the move,
> the block is no longer the last thing before function returns.
>
> Does it make more sense to return earlier if cros_typec_configure_mux() fails?
> Does the rest of code need to be executed even if cros_typec_configure_mux()
> fails?

Yes, it should still be executed (we still need to update the port
state). That is why the return is eliminated.

>
> > @@ -980,11 +985,6 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
> >       if (typec->typec_cmd_supported)
> >               cros_typec_handle_status(typec, port_num);
> >
> > -     /* Update the switches if they exist, according to requested state */
> > -     ret = cros_typec_configure_mux(typec, port_num, &resp);
> > -     if (ret)
> > -             dev_warn(typec->dev, "Configure muxes failed, err = %d\n", ret);
> > -
> >       return ret;
>
> If the function decides to return earlier, it can be `return 0;`.
Sure, I can change this in the next version
