Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52F2513BAE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351123AbiD1Si3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351108AbiD1Si0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:38:26 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649F21C10D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 11:35:10 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y21so6527474edo.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 11:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AK0opkaQ33+z/69oRWBiqlwlTBqFBYezZDCc2NUQjJU=;
        b=FsJjSFghCOFVlM+in5VediqEFhRGeoGmwi2peza2ZaLm+9pD4jTYGuix/b/dpuZ7NA
         YgiULt0vntSK/uG4A7sFE4PqXJVeQNeYcNnzVbNvV/F/LQia8LWc8IvKQNQLqsCJyxya
         aU8l6o3INW0tkpuM5rGPva/IbjdDNLllG0dsPar/R6FwPSoyzVmGAXS7qJjOu61Kz2cs
         gs6GVGiuWhgodWYELBHXVjJhUrDXlXCfdqB/a2FwQxqYQtbGYLUzdhG4EzmCqbntmj8f
         VYAhGiTVuUJn8HNgfNaFg9N7E9/Lw/y0YeIQC/UC2bjyiv10KUj23v9cNMsPaZXtc1He
         9BKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AK0opkaQ33+z/69oRWBiqlwlTBqFBYezZDCc2NUQjJU=;
        b=xNMWIj2Fu1ehYhZDAi5XjdIWHPKOhZkCQSy432W16PfBXuoagTEVySBZ1rac/OiSRD
         nBRWElQYezdYFKatL3VeiXosFnONF/Tms2n49888Cj51InNA5vTG/QQSqLGi+SmlhICa
         15UqFdJ1pOMkPt4Hr5MKGeyCtH6yys5dhWUtjQ/tEVtY51qhLZOybRZthqzl3LJoSHDc
         b6uXyJDlIt/lSzQz9aCJ7YkF9uTiVOuvCwZ/nmzPvcYVDkr/pz1tSggB45HYqkxIaNYd
         tOmmP/LGPaH4CIT27m0+bpKioNXlbaQghItWyqUEiW/dzvcgN7qXV6AaQOtcBRky1Zai
         IUGQ==
X-Gm-Message-State: AOAM532R98As3PCX7zrvver2h2oslZPHOS9jpNjE8cCZ5vSrS1VRGu4D
        2lbTX46/zugAvceExOLCWnOlhvm0ypN1q1GJ2UC55Q==
X-Google-Smtp-Source: ABdhPJzUgLwJOKqwihS2A/xSr0KyC8jdRUvBxTu1BVT7j/K2p1uzV1t6MuiygLZcW+CNvCsO6YSnf37jHD/0VEWXhWs=
X-Received: by 2002:a05:6402:26d3:b0:425:d67e:9880 with SMTP id
 x19-20020a05640226d300b00425d67e9880mr29352477edd.210.1651170908674; Thu, 28
 Apr 2022 11:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220418175932.1809770-1-wonchung@google.com> <Yl/l7gjRXj41a93q@lahna>
 <CAOvb9yidpOZ4jCjme+u1a4fPTRnLmxUHSTO3yHPPuYtDbe1V0g@mail.gmail.com>
 <YmDy/xEsyktRS6D+@lahna> <MW3PR11MB46517BE51D4DCBC02B463C0EEDF99@MW3PR11MB4651.namprd11.prod.outlook.com>
 <CAOvb9yhToxfT7cVzDX9cQhbRj0r2DXyuLJer64J8XSRJuUPcEg@mail.gmail.com>
In-Reply-To: <CAOvb9yhToxfT7cVzDX9cQhbRj0r2DXyuLJer64J8XSRJuUPcEg@mail.gmail.com>
From:   Won Chung <wonchung@google.com>
Date:   Fri, 29 Apr 2022 03:34:56 +0900
Message-ID: <CAOvb9yhPuNOM-HEb+fCfJPZ9kyxYZ9orT6u7BH_iiTU4XPWChg@mail.gmail.com>
Subject: Re: [PATCH 0/2] thunderbolt: Link USB4 ports to their USB Type-C connectors
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 1:51 AM Won Chung <wonchung@google.com> wrote:
>
> On Sun, Apr 24, 2022 at 2:12 PM Usyskin, Alexander
> <alexander.usyskin@intel.com> wrote:
> >
> > > > > > Currently, USB port is linked to Type C connector, using the component
> > > > > > framework, if they share the same _PLD fields from ACPI table. Type C
> > > > > > port-mapper searches for devices with the same _PLD values, and
> > > > > > aggregate them as components.
> > > > > >
> > > > > > When there is another device that share the same _PLD but does not
> > > > > > registers a component, Type C connector (component master) would never
> > > > > > be bound due to a component match entry device without a component
> > > > > > registered. There exists some cases where USB4 port also shares the same
> > > > > > _PLD with USB port and Type C connector, so we need to register a
> > > > > > component for USB4 ports too, linking USB4 port with Type C connector.
> > > > > > Otherwise, link between USB port and Type C connector would not
> > > > > > work either.
> > > > > >
> > > > > > Due to the nature of the component framework, all registered components
> > > > > > are shared by all component match despite the relevance. MEI subsystems
> > > > > > also use the component framework to bind to i915 driver, which try to
> > > > > > match components registered by USB ports and USB4 ports. This can be
> > > > > > problematic since MEI assumes that there is a driver bound to the
> > > > > > component device, while USB4 port does not bind to any drivers. MEI's
> > > > > > component match callback functions should handle such case to avoid
> > > NULL
> > > > > > pointer dereference when USB4 port registers a component.
> > > > > >
> > > > > > In summary this patch series
> > > > > > 1. Fixes MEI subsystem's component match callbacks to handle a
> > > component
> > > > > > device without any driver bound
> > > > > > 2. Registers a component for USB4 ports to link them to Type C
> > > > > > connectors, similar to USB ports.
> > > > > >
> > > > > > Heikki Krogerus (1):
> > > > > >   thunderbolt: Link USB4 ports to their USB Type-C connectors
> > > > > >
> > > > > > Won Chung (1):
> > > > > >   misc/mei: Add NULL check to component match callback functions
> > > > >
> > > > > The Thunderbolt patch looks good to me. Do you want me to take the both
> > > > > patches through the Thunderbolt tree or they can go separately? I need
> > > > > an ack from the mei maintainer it goes through my tree.
> > > >
> > > > Hi Mika,
> > > >
> > > > I would prefer the two patches to go to the same tree since it can
> > > > cause a crash with only the second patch (tbt). Would that sound okay?
> > >
> > > Sounds good to me.
> >
> > Tomas is MEI maintainer and should ack MEI patch
> >
> > --
> > Thanks,
> > Sasha
> >
> >
>
> Hi Tomas,
>
> Can you take a look at this patch series and give an ack if it looks
> okay to be merged into Mika's tree?
> One of the patches adds NULL checks in MEI:
> https://lore.kernel.org/all/20220418175932.1809770-2-wonchung@google.com/
>
> Thank you,
> Won

Hi Mika,

Tomas has given an ack on the first patch on MEI:
https://lore.kernel.org/all/0136fcb26ca8433899593208af4351c9@intel.com/

Should I resend the patch with an additional "Acked-by" tag?
Or could that be added as the patch is merged into the thunderbolt tree?

Thank you,
Won
