Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824B656210A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 19:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbiF3RQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 13:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235518AbiF3RQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 13:16:13 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F583E5CB
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 10:16:12 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id r3so34939818ybr.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 10:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o8689H0UAxz4K3OeSIRtr+YJ/Xi+oP67C+537YTthgw=;
        b=j9La2LdEFflVgzA2Rowu6dp2UY6aqc8v3FgtGD451eUdnEGBi8rD/KNhAXxKLJrRpc
         /GnohVyDXhKFZlxjAyiN07Ulvf4ZV21iDtYe2inkkIohq4Z/yKlaUyW9jep0T7UdwBe3
         /0GmkgbHF5cpsJgpAVcNHmWeAGYebStTf2AB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o8689H0UAxz4K3OeSIRtr+YJ/Xi+oP67C+537YTthgw=;
        b=3awzHPWR69gZRhS1ic2ahAddfDcEg2WLdC+PII1ElRMbCOpkceQHcBEjNihisJYgBK
         4mjzH3Yf2xy6wXYFNofCMrEXGyQ4mjtC6gRdWQE5uCoE40ja0mDMjdY24JbkTTwIEyOJ
         1cF7gstDyXpNl8ZR9HW2mx8eCz1fezKcEKwcH5EtdeRiCoqF3bKxD490RWAd2Bh8xYt+
         lwtFS0biDcQzCsJQGj3mW0xCS/EgOPiAIjl/hDeEI6X9UIJ1D/4A5Jm3f94xRgE0WM6Q
         2kM+OeX12l2h++DfVlDGN9aqA27sgO7+ODx9LxeGD0p/N15sOpFiY0Jq9DFB8BNnycIO
         0CUg==
X-Gm-Message-State: AJIora98PPUgMxEnpzBR4juV5jmph2AHnvIEgVw1SbLV9BpIPcviehxK
        AWtbJ+Q4IIxjqAJPSr9PA8iuPXxENqWRrUSgMQ8rdg==
X-Google-Smtp-Source: AGRyM1vzAQkoR46IuHMPKY/cJIhI/I67AUHel/vX9VgQIYI8WXB81cA8Ur31ZAjWpMDR7uLSh0OqyBpGAkc91RCMG6g=
X-Received: by 2002:a25:b9c7:0:b0:66c:e02d:9749 with SMTP id
 y7-20020a25b9c7000000b0066ce02d9749mr10919746ybj.494.1656609371601; Thu, 30
 Jun 2022 10:16:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220629233314.3540377-1-pmalani@chromium.org>
 <20220629233314.3540377-3-pmalani@chromium.org> <Yr1eW1gHR7LGP70Y@kuha.fi.intel.com>
In-Reply-To: <Yr1eW1gHR7LGP70Y@kuha.fi.intel.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 30 Jun 2022 10:16:00 -0700
Message-ID: <CACeCKadQr4m_OK92GmVefJDS4d-3+E2WkW=YzVnoYkbmXzwESw@mail.gmail.com>
Subject: Re: [PATCH 2/9] usb: typec: Add retimer handle to port
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        chrome-platform@lists.linux.dev, bleung@chromium.org,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Heikki,

On Thu, Jun 30, 2022 at 1:27 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi,
>
> On Wed, Jun 29, 2022 at 11:32:20PM +0000, Prashant Malani wrote:
> > Similar to mux and orientation switch, add a handle for registered
> > retimer to the port, so that it has handles to the various switches
> > connected to it.
> >
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > ---
> >  drivers/usb/typec/class.c | 8 ++++++++
> >  drivers/usb/typec/class.h | 1 +
> >  2 files changed, 9 insertions(+)
> >
> > diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> > index 2fa0b3718d23..2bc5fbdb25dd 100644
> > --- a/drivers/usb/typec/class.c
> > +++ b/drivers/usb/typec/class.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/usb/pd_vdo.h>
> >  #include <linux/usb/typec_mux.h>
> > +#include <linux/usb/typec_retimer.h>
> >
> >  #include "bus.h"
> >  #include "class.h"
> > @@ -2249,6 +2250,13 @@ struct typec_port *typec_register_port(struct device *parent,
> >               return ERR_PTR(ret);
> >       }
> >
> > +     port->retimer = typec_retimer_get(&port->dev);
> > +     if (IS_ERR(port->retimer)) {
> > +             ret = PTR_ERR(port->retimer);
> > +             put_device(&port->dev);
> > +             return ERR_PTR(ret);
> > +     }
> > +
> >       ret = device_add(&port->dev);
> >       if (ret) {
> >               dev_err(parent, "failed to register port (%d)\n", ret);
>
> I think you need to release the reference with typec_retimer_put() in
> typec_release().

I knew I was forgetting something...
I'll fix this in v2.

>
> I guess we can look handle this later, but there can actually be two
> onboard retimers for each connector.

You're referring to the cascaded case right? OK, I'll bear this in mind for
later series (right now the EC exposes just 1 interface for retimer).

Thanks,

-Prashant
