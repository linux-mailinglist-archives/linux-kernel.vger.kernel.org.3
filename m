Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55B14AD157
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 07:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345420AbiBHGEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 01:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236586AbiBHGEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 01:04:39 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5B0C0401DC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 22:04:39 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id y6so32134412ybc.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 22:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kvgkdpHYOT9hT97Eiz4ThApHg16vK+7+EjSGNAq5fVs=;
        b=Q/wFyU1ox5X6pXRZj19yAZ3gCpmA62oayq/7m6jnZMsVZ8/Gtg7ZwNdQf7cps7FYHn
         5nNHP3r1aOE4zFoyot/Bb6oDUREC4MtH+FabIl7eEARuEJl84eAfXgkY6cYms+Qr2MqZ
         a2xkD1VfJxVSRzcALlYe2LvQRElYvV9I2zUsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kvgkdpHYOT9hT97Eiz4ThApHg16vK+7+EjSGNAq5fVs=;
        b=Yb1eq3iBd0v3438wBSSLYDUtqBJbhVbUEmIMC7NsehC246pwSXAKUg5NZjGAipythw
         3RtumTrUp953K6T7XrnB6MROC262BbjtV5SK274aflUqIEJoipyYt7MsDN/XIYKHPTuS
         aubQeqFem6G9vCybECxmyyfaso1/7EpSoZarekKZmJhbzvWu/MYzuuQKM5lBjX2MpqkX
         BfOECj3gaVFb1E6ppL3okhB7fa9k0EZFq2vLiPQix4XLjwNMw29nGQCqyjkHWV26275B
         LFvOwOTBHEwGaZUVfNMU50cpPoSPgaFhdeCBXmqjzojrlz+we9OnYOiB/52L94V7tCQb
         QpMA==
X-Gm-Message-State: AOAM530Jhp6VtU/rno1Gu6mJmFHKFUC5OrvYi6gh64O1rry1TD2V4eiH
        mqSyMlSlQaL8y2BFZHn4xhjJ3rtvHyeNNQbZIcqyjg==
X-Google-Smtp-Source: ABdhPJww2NCzwl1KudiLx73FHY1lRHxrsD8AWldBfQt/fvDpFo5NFD+6Oy1JBsM/t/Bqsh9k1za57LaolMmDeiSNgg8=
X-Received: by 2002:a05:6902:124c:: with SMTP id t12mr3115810ybu.656.1644300278348;
 Mon, 07 Feb 2022 22:04:38 -0800 (PST)
MIME-Version: 1.0
References: <20220207214026.1526151-1-pmalani@chromium.org>
 <20220207214026.1526151-3-pmalani@chromium.org> <YgIBIlnLPiV+49HI@google.com>
In-Reply-To: <YgIBIlnLPiV+49HI@google.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 7 Feb 2022 22:04:27 -0800
Message-ID: <CACeCKacQP4OjfQ-x8VE66bnh1J28jsYjC3udjiHZN7hJrmDGsw@mail.gmail.com>
Subject: Re: [PATCH 2/4] platform/chrome: cros_ec_typec: Get mux state inside configure_mux
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        "open list:CHROMEOS EC USB TYPE-C DRIVER" 
        <chrome-platform@lists.linux.dev>,
        Guenter Roeck <groeck@chromium.org>
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

On Mon, Feb 7, 2022 at 9:35 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> On Mon, Feb 07, 2022 at 09:40:26PM +0000, Prashant Malani wrote:
> > Move the function which gets current mux state inside the
> > cros_typec_configure_mux() function. It is better to group those
> > bits of functionality together, and it makes it easier to move around
> > cros_typec_configure_mux() later.
>
> nit: s/Move/Moves/.

Move is fine. Please see:
https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#describe-your-changes

Quoting from the above: " Describe your changes in imperative mood,"

>
> >  static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
> > -                             uint8_t mux_flags,
> >                               struct ec_response_usb_pd_control_v2 *pd_ctrl)
> >  {
> >       struct cros_typec_port *port = typec->ports[port_num];
> > +     struct ec_response_usb_pd_mux_info mux_resp;
> > +     struct ec_params_usb_pd_mux_info req = {
> > +             .port = port_num,
> > +     };
> >       struct ec_params_usb_pd_mux_ack mux_ack;
> >       enum typec_orientation orientation;
> >       int ret = 0;
> >
> > +     ret = cros_ec_command(typec->ec, 0, EC_CMD_USB_PD_MUX_INFO,
> > +                           &req, sizeof(req), &mux_resp, sizeof(mux_resp));
>
> It was `req` and `resp` in cros_typec_get_mux_info().  However, `mux_resp` for
> separating from `struct ec_response_usb_pd_control_v2 resp` in
> cros_typec_port_update().
>
> It would be neat to be either {`req`, `resp`} or {`mux_req`, `mux_resp`} in
> cros_typec_configure_mux().

I'll change it to resp (instead of mux_resp)
