Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8A755CBC0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237468AbiF0O2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237439AbiF0O15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:27:57 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3979B13F25;
        Mon, 27 Jun 2022 07:27:57 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-3177e60d980so86920387b3.12;
        Mon, 27 Jun 2022 07:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ausyBxe1EwSltgsOW+aLx9gGKbI9xmb58xvni35q/8=;
        b=E3F+qN3ybblO1Sdk2PcIXCCiVMZ9ThL/41UkX9xCJvW5Zqv4fQpwQwPmcxdv9c3mpp
         uuJkNlQaqn/XIpKUdYZqWGi7VEFguj7JWH8ggz6zgbGBLsyWPr62O7nPszyXRARwnDf5
         a35zTjdZzQDY7XJZ1PvXAsQskpMhlW8tkOvn/uB7Hsd5yDxkGBk2Eoc6QJwdo3WPLbPd
         OVgD/18qclQ3qE02EUEEPy/exy+LdLcrOnehTIm2x75GUBRM02/HhHzAhqPZMONM1II2
         N0eWhKIc0umy9xlGog+L0wf9jtskPgqVD+nxHoGIJExcwMwqwd1iR9dvNAP3F+ACPTCs
         XHog==
X-Gm-Message-State: AJIora9zdFXXRYj4dGDDMFq2ahL4utpsjo6WaZy68ELhaDHz2sqFOX5K
        O6DUBkC4UGknArSK08DD9AbRCoPWyQ5+P4nvghQ=
X-Google-Smtp-Source: AGRyM1vIcglL1E5IuPFyWS28U+Yjuq52Iosbfn31LhbYRsuDUhrfMrQfTgx6LXwcWn1lzMGswldF2MiwAQkGGvT1aJ8=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr14642063ywb.326.1656340076401; Mon, 27
 Jun 2022 07:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220613120755.14306-1-peter.wang@mediatek.com> <Yrm7QSRXKZg4/q7s@kroah.com>
In-Reply-To: <Yrm7QSRXKZg4/q7s@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Jun 2022 16:27:45 +0200
Message-ID: <CAJZ5v0iFyTXc8TfEq5vHZvRmi9YbW-OA_G3n4xULhsw7=gdZ5A@mail.gmail.com>
Subject: Re: [PATCH v1] PM-runtime: Check supplier_preactivated before release supplier
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     peter.wang@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Avri Altman <avri.altman@wdc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>, chun-hung.wu@mediatek.com,
        alice.chao@mediatek.com, cc.chou@mediatek.com,
        chaotian.jing@mediatek.com, jiajie.hao@mediatek.com,
        powen.kao@mediatek.com, qilin.tan@mediatek.com,
        lin.gui@mediatek.com, tun-yu.yu@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 4:14 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 13, 2022 at 08:07:55PM +0800, peter.wang@mediatek.com wrote:
> > From: Peter Wang <peter.wang@mediatek.com>
> >
> > With divice link of DL_FLAG_PM_RUNTIME, if consumer call pm_runtime_get_suppliers
> > to prevent supplier enter suspend, pm_runtime_release_supplier should
> > check supplier_preactivated before let supplier enter suspend.
> >
> > If the link is drop or release, bypass check supplier_preactivated.
> >
> > Signed-off-by: Peter Wang <peter.wang@mediatek.com>
> > ---
> >  drivers/base/core.c          |  2 +-
> >  drivers/base/power/runtime.c | 15 ++++++++++++---
> >  include/linux/pm_runtime.h   |  5 +++--
> >  3 files changed, 16 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 7cd789c4985d..3b9cc559928f 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -486,7 +486,7 @@ static void device_link_release_fn(struct work_struct *work)
> >       /* Ensure that all references to the link object have been dropped. */
> >       device_link_synchronize_removal();
> >
> > -     pm_runtime_release_supplier(link, true);
> > +     pm_runtime_release_supplier(link, true, true);
> >
> >       put_device(link->consumer);
> >       put_device(link->supplier);
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > index 676dc72d912d..3c4f425937a1 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -314,10 +314,19 @@ static int rpm_get_suppliers(struct device *dev)
> >   * and if @check_idle is set, check if that device is idle (and so it can be
> >   * suspended).
> >   */
> > -void pm_runtime_release_supplier(struct device_link *link, bool check_idle)
> > +void pm_runtime_release_supplier(struct device_link *link, bool check_idle,
> > +     bool drop)
>
> This is just making this horrible api even worse.  Now there are 2
> boolean flags required, 2 more than really should even be here at all.
> Every time you see this function being used, you will now have to look
> up the definition  to see what it really does.
>
> Please make a new function that calls the internal function with the
> flag set properly, so that it is obvious what is happening when the call
> is made.
>
> and really, the same thing should be done for the check_idle flag,
> that's not good either.

Agreed, and let me take care of this.
