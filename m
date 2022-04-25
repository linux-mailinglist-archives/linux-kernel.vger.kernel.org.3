Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A33850EBEF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235650AbiDYWZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 18:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343562AbiDYVdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 17:33:25 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369EE27153
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:30:20 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id m20so11435450ejj.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HHqpbgvhGzfWr0EyYRxzA6HfxhKAhFMAtOp9U0tnQsw=;
        b=WWZIB1XrA4aY5urSbazaVEZIdf9VBxbccf2WK0voRgvR+yD07WDMYB/1jukoVIx2RX
         H585UqT/CMzahEyJLmbRcPezjMaxqwAK5Nemldbkf3GwKcYSgGEojTcbLIogTmY5th+m
         3flocOyBRkyw8jkmcSKEauCW7738RYVZOxvA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HHqpbgvhGzfWr0EyYRxzA6HfxhKAhFMAtOp9U0tnQsw=;
        b=ECvzyRj1VEhq2KhrY37xmfd1TrMmwZsXGNIfA8XpWtNbkmew0qHARFPMmDXWLbviF3
         v2Ylu4x4KMtzJBPFq2RCWxJC8xenjDA3V2WAT6VuTP1FJgYqjhMPxbtntorg+8vSiY/D
         gxFnsh53epmFl+i6o98U7mYecTwDHeZZ83oOeNHUaFODUturvrvh2nl4iKxjN68/IUsc
         FiLN7Ob4PuU5eOp7cxhJwDBkTpX9GZei8HEqkWleIOhlehkgyooVfLQSVek+FDUTZDGN
         lX/27QeNb3CzfSIc2xvgoXpc/O/XdISAqoGnfvElAVFmueirTBk1HOSFJ2Ylx7/cJTNG
         s8qw==
X-Gm-Message-State: AOAM532CeCLeNosYNyghlzTMrBHwOnWGsVfz9lNg+GJoufoTh/PU4W2P
        R782EYq6FIEKZocnCtPNw9+tCoXEG1HJXowL
X-Google-Smtp-Source: ABdhPJzGM/mSyGm9dNfjPK4EFO2SRDG8o2AyfxbSE56NzP5Ke7EBPikuGxxk9TPClKrwY7A61IyDLg==
X-Received: by 2002:a17:907:62a9:b0:6da:7953:4df0 with SMTP id nd41-20020a17090762a900b006da79534df0mr18431236ejc.316.1650922218473;
        Mon, 25 Apr 2022 14:30:18 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id g21-20020a056402115500b00413c824e422sm5035875edw.72.2022.04.25.14.30.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 14:30:17 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id e24so2822607wrc.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:30:17 -0700 (PDT)
X-Received: by 2002:a05:6000:1acb:b0:20a:a4b0:dbc8 with SMTP id
 i11-20020a0560001acb00b0020aa4b0dbc8mr15378477wry.513.1650922217012; Mon, 25
 Apr 2022 14:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220425210726.3813477-1-swboyd@chromium.org>
In-Reply-To: <20220425210726.3813477-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 25 Apr 2022 14:30:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WT+=qMJxNiAniTrX+qonXDgESzUi00+QfN4NW=3rdp+Q@mail.gmail.com>
Message-ID: <CAD=FV=WT+=qMJxNiAniTrX+qonXDgESzUi00+QfN4NW=3rdp+Q@mail.gmail.com>
Subject: Re: [PATCH v2] Input: cros-ec-keyb: Only register keyboard if
 rows/columns exist
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 25, 2022 at 2:07 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> If the device is a detachable, we may still probe this device because
> there are some button switches, e.g. volume buttons and power buttons,
> registered by this driver. Let's allow the device node to be missing row
> and column device properties to indicate that the keyboard matrix
> shouldn't be registered. This removes an input device on Trogdor devices
> such as Wormdingler that don't have a matrix keyboard, but still have
> power and volume buttons. That helps userspace understand there isn't
> a keyboard present when the detachable keyboard is disconnected.
>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Changes from v1 (https://lore.kernel.org/r/20220413033334.1514008-1-swboyd@chromium.org):
>  * Use device_property_present
>
>  drivers/input/keyboard/cros_ec_keyb.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
