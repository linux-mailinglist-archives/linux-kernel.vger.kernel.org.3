Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4900C4AD79F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356839AbiBHLfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357000AbiBHLPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:15:48 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4B9C03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 03:15:47 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id qe15so6420958pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 03:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nts6pat0vQjRviFxoqz7LZiRn4EHIdbpX0j0LRxea20=;
        b=R60U7X5J2OlS8+v9MEix+EqNwaaFwzIOe5+O8urPw6QPT2uWnKgZGtL0fCrR8n36vR
         TdkXib3vUAEoNqROCOwtMlW8WNZLtp+lXHdW2/GSeA+Cnirv0Uo8j8XopwdAmp7xtl15
         tT4z+VRNXr7HhlQgNup+6KeIWWzoZNCz0q32LNkECxcXBPhIjwkygpRerTA8LPTfXamz
         cjkllkdIEFLXTQ+XLeRZW++XRMJDpYkRWEoqQEYeNyXDzf/XodvHe0zKN/ehFb2y71yI
         4I4HpnEzFdwW7fwjYIAfhYhFeEYAgxuWbqwx/oaIKHynA1+o3SAnGchuguOkoovn83yd
         Rcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nts6pat0vQjRviFxoqz7LZiRn4EHIdbpX0j0LRxea20=;
        b=kP77Uj9KR8y0iPLgVxKfeDZfboKWg7RW5tpZikPLGN0hQVHXup9f8Lv0orG75KKIAJ
         RLX7M8m5l7V1VLL0KWQFifwFggKbUAD/bW/P7Nc/Qm7P8d/XqTIf4x19TgB4IplGom0Y
         M7RWNconHFhCxyiQm9b76uugLRHQrQedVEg+3beEpFknnOSf8/KwdiaLWSl9sndzajzG
         lsmKb4usEOHyQwa33fKJVxh4oScbjZTw5pn5qltZ0zLsJPI+fQnUU/EtXbsyq4QIMDU+
         qE/FKkqLPMc1k8yZQEWK+wrHjWSrJJov5Pwng5r7Rhls1M5Ku9EMrNbEAqLblK42S8k/
         eHZQ==
X-Gm-Message-State: AOAM531fOIb0DsPIJlcFrt2VEWAWrRX2GEJ6eHkleshc9SQQhArowzzB
        qqlr4PaL0rjM4cdzLmBLISe9QA==
X-Google-Smtp-Source: ABdhPJxF1jz83ZwPBrZQMpvwS+VB0vF+H77JAun+Ge1PUomjjmkQnamWYMgx4zs8LdpeQiNAxF4gAw==
X-Received: by 2002:a17:902:e888:: with SMTP id w8mr854290plg.109.1644318946664;
        Tue, 08 Feb 2022 03:15:46 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:4b6f:f14d:be50:86a])
        by smtp.gmail.com with ESMTPSA id s139sm1101533pfc.152.2022.02.08.03.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 03:15:46 -0800 (PST)
Date:   Tue, 8 Feb 2022 19:15:43 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:CHROMEOS EC USB TYPE-C DRIVER" 
        <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH 3/4] platform/chrome: cros_ec_typec: Configure muxes at
 start of port update
Message-ID: <YgJQ30D8nc4LWvUy@google.com>
References: <20220207214026.1526151-1-pmalani@chromium.org>
 <20220207214026.1526151-4-pmalani@chromium.org>
 <YgIBv2SQdwXm7RLt@google.com>
 <CACeCKaezRNgsqrq3QJ1ViHjYScFrjpC-kCaYmE8kOXCcW9MRrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACeCKaezRNgsqrq3QJ1ViHjYScFrjpC-kCaYmE8kOXCcW9MRrw@mail.gmail.com>
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

On Mon, Feb 07, 2022 at 10:12:10PM -0800, Prashant Malani wrote:
> On Mon, Feb 7, 2022 at 9:38 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
> > On Mon, Feb 07, 2022 at 09:40:28PM +0000, Prashant Malani wrote:
> > > There are situations where the mux state reported by the Embedded
> > > Controller (EC), might lag the partner "connected" state. So, the mux
> > > state might still suggest that a partner is connected, while the PD
> > > "connected" state, being in Try.SNK (for example) suggests that the
> > > partner is disconnected.
> > >
> > > In such a scenario, we will end up sending a disconnect command to the
> > > mux driver, followed by a connect command, since the mux is configured
> > > later. Avoid this by configuring the mux before
> > > registering/disconnecting a partner.
> >
> > I failed to understand the description.  It looks like some protocol details.
> > Could you provide some brief explanation in the commit message?
> 
> I'm not sure how else I can better elaborate on this in the commit message than
> as currently stated.
> Since the EC is an independent controller, the mux state *can* lag the
> "connected" state.
> So, as described in the commit message, when a disconnect happens, we could have
> a disconnect (since PD_CTRL contains the "connected state") followed
> by a configure_mux
> with the mux state still suggesting a connected device (the drivers
> which implement the
> mux/switch controls can misconstrue the old mux state) which results
> in a connect. This
> patch eliminates that.

Pardon me if I ask, I am trying to understand why reorder the function calls
in cros_typec_port_update() can fix the issue.  And I am wondering if the
issue has fixed by the 4th patch in the series.

To make sure I understand the issue correctly, imaging a "disconnect" event
in cros_typec_port_update() originally:

a. Get pd_ctrl via EC_CMD_USB_PD_CONTROL[1].

b. Call cros_typec_remove_partner() in cros_typec_set_port_params_v1()[2].
Is it the "disconnect" you were referring in the example?

c. Get mux info via EC_CMD_USB_PD_MUX_INFO.
Did you mean the mux info might be stale which is "partner connected"?

d. Call cros_typec_enable_dp() in cros_typec_configure_mux()[3].
Does it result in another connect?

[1]: https://elixir.bootlin.com/linux/v5.17-rc3/source/drivers/platform/chrome/cros_ec_typec.c#L955
[2]: https://elixir.bootlin.com/linux/v5.17-rc3/source/drivers/platform/chrome/cros_ec_typec.c#L628
[3]: https://elixir.bootlin.com/linux/v5.17-rc3/source/drivers/platform/chrome/cros_ec_typec.c#L548

If the above understanding is correct, the patch fixes it by moving step b to
the last.  As a result, it won't have a "disconnect" -> "connect" transition.

Further questions:

- If mux info from step c would be stale, won't it exit earlier in [4]?

[4]: https://elixir.bootlin.com/linux/v5.17-rc3/source/drivers/platform/chrome/cros_ec_typec.c#L986

- The 4th patch[5] sets mux_flags to USB_PD_MUX_NONE.  If it won't exit earlier
  from previous question, won't it fall into [6]?

[5]: https://patchwork.kernel.org/project/chrome-platform/patch/20220207214026.1526151-5-pmalani@chromium.org/
[6]: https://elixir.bootlin.com/linux/v5.17-rc3/source/drivers/platform/chrome/cros_ec_typec.c#L523

> > > @@ -965,6 +965,11 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
> > >       if (ret < 0)
> > >               return ret;
> > >
> > > +     /* Update the switches if they exist, according to requested state */
> > > +     ret = cros_typec_configure_mux(typec, port_num, &resp);
> > > +     if (ret)
> > > +             dev_warn(typec->dev, "Configure muxes failed, err = %d\n", ret);
> >
> > It used the fact that the function returns `ret` at the end.  After the move,
> > the block is no longer the last thing before function returns.
> >
> > Does it make more sense to return earlier if cros_typec_configure_mux() fails?
> > Does the rest of code need to be executed even if cros_typec_configure_mux()
> > fails?
> 
> Yes, it should still be executed (we still need to update the port
> state). That is why the return is eliminated.

Got it, as long as it is intended.

> > > @@ -980,11 +985,6 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
> > >       if (typec->typec_cmd_supported)
> > >               cros_typec_handle_status(typec, port_num);
> > >
> > > -     /* Update the switches if they exist, according to requested state */
> > > -     ret = cros_typec_configure_mux(typec, port_num, &resp);
> > > -     if (ret)
> > > -             dev_warn(typec->dev, "Configure muxes failed, err = %d\n", ret);
> > > -
> > >       return ret;
> >
> > If the function decides to return earlier, it can be `return 0;`.
> Sure, I can change this in the next version

No, I guess you would like to leave it as is to propagate return value from
cros_typec_configure_mux().
