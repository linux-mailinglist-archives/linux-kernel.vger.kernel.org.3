Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AD15964DE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 23:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237671AbiHPVpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 17:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237303AbiHPVpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 17:45:19 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7D265652
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:45:19 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-334dc616f86so12447677b3.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=pSOrOVI25VgV/6R9W1wYpCotHFnCNKL0lI+znEZmad4=;
        b=aDEMqQlVNtBx4WNCOODhmJMNlGdxPFbMynhD9rQXWJIEXTF1UflpIbWlGGDOYQfmRa
         me4OeJEzi22O9nWvlt3Qvf/xnVEZnjBqRKg9MYRK8flxg6gt20bwRhmu1HC5rAv2hN6y
         biqmNlvuJFxFIKsJSSMYAYz+YH6ZR390SIDU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=pSOrOVI25VgV/6R9W1wYpCotHFnCNKL0lI+znEZmad4=;
        b=NRyQ8iBelkuz39FXb70Anm712C/EosvehmmCDwaTVRUxgIZjHgWo11cVuTrOo9Tatd
         Eb1GS6jyXSfN2UbqcQ60TrEvPp5E/i72i0G1mkn9st8XzFtd1L/m1HlaDNG4FBI/t3cT
         Z0tIPk9NerzKbO4PPp2ugS8Bcy7OODbW8zuSrWCiXXIPsssNkOAS3QFwyFsX6wHKu0g6
         adI3he3WLA2mzVc/UhWM6039X9REwxHDhFGQt4iiaSH+9d+s5h+/Uw28vK3POLcwhhT+
         ymTA7nk8XCW1CxHAjbqpLd9GcEXlIbXHgEHc8OHhAVW7Zt0QH7lDvWh7zqDWQ90+4mQB
         XyBQ==
X-Gm-Message-State: ACgBeo1wk7+fAGCRO28KsLZQHKy2kGJCc8u+ixqYM9kE57edU/wPX38Y
        xcwEnQcLcR7IMn9y3MU4rMuIy3xUWnmmNEpEZ1vdTw==
X-Google-Smtp-Source: AA6agR49sGoqbPcnlL8zomIof6WHUAIpLbgSN3IgimaBLZHyxy8Xji/076KvwuOs454glGdPV7lJw/lP3uTdyfKOIH0=
X-Received: by 2002:a25:2d5d:0:b0:685:1c21:3ee8 with SMTP id
 s29-20020a252d5d000000b006851c213ee8mr13931951ybe.197.1660686318255; Tue, 16
 Aug 2022 14:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220815063555.1384505-1-pmalani@chromium.org>
 <20220815063555.1384505-4-pmalani@chromium.org> <YvsnBWZlH8ouSlLk@google.com>
In-Reply-To: <YvsnBWZlH8ouSlLk@google.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 16 Aug 2022 14:45:08 -0700
Message-ID: <CACeCKaeeKjk37=KUx0qx9tCw6F02sZ947YGS5mm08cKJHzo3Bw@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] platform/chrome: cros_typec_switch: Set EC retimer
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        bleung@chromium.org, Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Xiang wangx <wangxiang@cdjrlc.com>
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

On Mon, Aug 15, 2022 at 10:11 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> On Mon, Aug 15, 2022 at 06:34:21AM +0000, Prashant Malani wrote:
> > +static int cros_typec_cmd_mux_set(struct cros_typec_switch_data *sdata, int port_num, u8 index,
> > +                               u8 state)
> > +{
> > +     struct typec_usb_mux_set params = {
> > +             .mux_index = index,
> > +             .mux_flags = state,
> > +     };
> > +
> > +     struct ec_params_typec_control req = {
> > +             .port = port_num,
> > +             .command = TYPEC_CONTROL_COMMAND_USB_MUX_SET,
> > +             .mux_params = params,
> > +     };
>
> Would it be better to avoid the memory copy by making `params` inline?
>
> E.g.:
> struct ec_params_typec_control req = {
>     ...
>     .mux_params = {
>         ...
>     },
>     ...

Done.

>
> > +/*
> > + * The Chrome EC treats both mode-switches and retimers as "muxes" for the purposes of the
>
> To be consistent to the series, I guess you would like to use ChromeOS
> instead of Chrome?
Fixed in v6.

>
