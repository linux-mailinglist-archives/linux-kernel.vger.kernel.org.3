Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93549508D7F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380674AbiDTQmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380595AbiDTQm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:42:26 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96F64615A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:39:39 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id v15so3008235edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b5N2uBwvU/R1T3nBWRA2gGypa77nKQwkQAmB3bWEi9A=;
        b=jxB9R4cclEOKuzCKOWbdtfUR3unE2Ot3c7bJ7kNRuSpiqY8HhPJN2/rMtaxEwVJf1o
         YvbOH+sesfzSRsTO5dJCbSfBxTY4w6DeMDeZk3vcUZio/kKkjPQFZzMd+PZJzxTmBjze
         K5y32W6KxLokKJyf4NO+wnND1YVXlhVhWoZPK9+cnl02H53Egy/WAR0O1CG1El3xba6k
         0/Bl+ctMPlQqkq14K9xQ4u14s9+oqSK264HU5vyaKJdFskmemIwExELQRrsXMQuDOfzP
         kVeT6GTH6teoSww657WuBopnAHRtPKJTgFnnPyVXw6vN7Kfx69OLEqVfWnZLK84iK9o4
         c+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b5N2uBwvU/R1T3nBWRA2gGypa77nKQwkQAmB3bWEi9A=;
        b=GugoCMu1U66LugB86GZ73ykWwc53hO3Yvj3ZxRPIeJ4tDUUfmryFsMN7f+msYwTulN
         fKb1u8nZeiESbKq6qVwh7GmcvY6mCxkq3Zbg3Es9XoQd3giFR+qNXmUleS5JGKVmw9K8
         c+NOSIr26R6NDkNcKBSNcqtZXRZ/TG2i8jfhIs8mUNI/vRXu9gXxoVRLd6w1pWdxWF3V
         0izxODc6Vt/F6ldKfaGqrPygMCEXZVHKwU5iUtST3a5cnpgrBmt6LSJicOV3oPoNRot9
         Y5uV/4DCkIBbcGRDdad9Ps95VxIaKIjB3/+FhnI0+jbGJUbN/GiOLtKAl5V9BNMRy2RJ
         NhLA==
X-Gm-Message-State: AOAM5321ipcvFseXParufRcCzNJmxs6Ws2aeodx2aamRAnJRrCtzOvAi
        jXXCU0oMMYIkNjU4EP0DsLhDn0svPn89VKJ46axoIh2PNVHzmw==
X-Google-Smtp-Source: ABdhPJzEjDcNUsqnj/BsQTDpZO1AkHXHew4UR3HKk4uskAu0ispgivCheHHbNR8dunwRsDycqsBdWiO+52yjHOkmB44=
X-Received: by 2002:a05:6402:2689:b0:422:15c4:e17e with SMTP id
 w9-20020a056402268900b0042215c4e17emr24763350edd.33.1650472778279; Wed, 20
 Apr 2022 09:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220418175932.1809770-1-wonchung@google.com> <Yl/l7gjRXj41a93q@lahna>
In-Reply-To: <Yl/l7gjRXj41a93q@lahna>
From:   Won Chung <wonchung@google.com>
Date:   Wed, 20 Apr 2022 09:39:25 -0700
Message-ID: <CAOvb9yidpOZ4jCjme+u1a4fPTRnLmxUHSTO3yHPPuYtDbe1V0g@mail.gmail.com>
Subject: Re: [PATCH 0/2] thunderbolt: Link USB4 ports to their USB Type-C connectors
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        linux-kernel@vger.kernel.org
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

On Wed, Apr 20, 2022 at 3:54 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Mon, Apr 18, 2022 at 05:59:30PM +0000, Won Chung wrote:
> > Currently, USB port is linked to Type C connector, using the component
> > framework, if they share the same _PLD fields from ACPI table. Type C
> > port-mapper searches for devices with the same _PLD values, and
> > aggregate them as components.
> >
> > When there is another device that share the same _PLD but does not
> > registers a component, Type C connector (component master) would never
> > be bound due to a component match entry device without a component
> > registered. There exists some cases where USB4 port also shares the same
> > _PLD with USB port and Type C connector, so we need to register a
> > component for USB4 ports too, linking USB4 port with Type C connector.
> > Otherwise, link between USB port and Type C connector would not
> > work either.
> >
> > Due to the nature of the component framework, all registered components
> > are shared by all component match despite the relevance. MEI subsystems
> > also use the component framework to bind to i915 driver, which try to
> > match components registered by USB ports and USB4 ports. This can be
> > problematic since MEI assumes that there is a driver bound to the
> > component device, while USB4 port does not bind to any drivers. MEI's
> > component match callback functions should handle such case to avoid NULL
> > pointer dereference when USB4 port registers a component.
> >
> > In summary this patch series
> > 1. Fixes MEI subsystem's component match callbacks to handle a component
> > device without any driver bound
> > 2. Registers a component for USB4 ports to link them to Type C
> > connectors, similar to USB ports.
> >
> > Heikki Krogerus (1):
> >   thunderbolt: Link USB4 ports to their USB Type-C connectors
> >
> > Won Chung (1):
> >   misc/mei: Add NULL check to component match callback functions
>
> The Thunderbolt patch looks good to me. Do you want me to take the both
> patches through the Thunderbolt tree or they can go separately? I need
> an ack from the mei maintainer it goes through my tree.

Hi Mika,

I would prefer the two patches to go to the same tree since it can
cause a crash with only the second patch (tbt). Would that sound okay?

Hey Alexander, would you be the right person to ask for an ack on this?

Thanks,
Won
