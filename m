Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F8D50E651
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239822AbiDYRAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbiDYRAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:00:18 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC8638DB1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:57:13 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id k27so4011320edk.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=aAkJXYrlfstpqmrrJgH+30w2YtxrX55QY3VYrtfhrzI=;
        b=Nqnr0FJzrtqJAbawcoUNHXs2DlCkhVqT7MoGYI5i7h8MPrttQfbLlTUpCBco1ELBXH
         InVZOoNwqXhvFl2xfV+aLZysUN23GpJft7FoRKJ4coxoWap/LaPNWx7BIm8S4E9miWkl
         HNc4jZ8Qr1ta7ym7e4OfGpYD8rtL294FvzoDuVDOR+QzXZYIktzcxmnnLZGKHH26AhbH
         5SfegHoM+SlH2afIyHmphCK0QfWbqAi+hHuBDRu9l1A1WEPmkRnYwAtuyEiDLgRUJop2
         10B2smFbAE5mDlQ4qYP7UTCthMdIo5d9NipBH1i/g8dEn5VZvi4RjqYElO7KAyOrKjLt
         pJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=aAkJXYrlfstpqmrrJgH+30w2YtxrX55QY3VYrtfhrzI=;
        b=QalPIWO03/yFaclHMvFg8RVm0o1Ialtd5eRI8n/BH12FqkvKkPgIuW5pxMCyKZFjbq
         tLBWCEbBZOPoCFU5LbSEmWt3hcu9N7te8/IPMXvZxWz3B1VhWHx+Lrx6yanoXXG9pWjF
         pt7nK80gxyBcfb7CfbBDFATP8B2CuCGJdtt7QFIZQmeFV0IUz7/nmEux4C8cF6v2F0yL
         oSp5Rn/dc4Rt5A4pHyLsUFUYV8VIZ1tqq/okacxGwlrf1oolNtqNJGvGp/0uwbJDmQsz
         DHAOmQzkZTttGLPmf//LzDjxnZhHqyiXYysL0WS2+dsP6S4uqdeei/GR8oT8648HISuU
         oPiQ==
X-Gm-Message-State: AOAM533yczb2avc6egxqc95omznAyOXYIeEmURBoex6Z3TlAmfzS3jzA
        OZtwz1PzwSK4eviue2guNGY++URdSECHcXMfV/5OQQ==
X-Google-Smtp-Source: ABdhPJwISdniygAlT12qczJLBdPaFBZHgZ45pu0gxTyNhBtzW0vdDsEn0RlwEvZkEO6eKoSs9jpKYE41NLxgul91g88=
X-Received: by 2002:a05:6402:2689:b0:422:15c4:e17e with SMTP id
 w9-20020a056402268900b0042215c4e17emr20400576edd.33.1650905832063; Mon, 25
 Apr 2022 09:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220418175932.1809770-1-wonchung@google.com> <20220418175932.1809770-2-wonchung@google.com>
In-Reply-To: <20220418175932.1809770-2-wonchung@google.com>
From:   Won Chung <wonchung@google.com>
Date:   Tue, 26 Apr 2022 01:56:55 +0900
Message-ID: <CAOvb9yjCnw=-5wO5_X6ond3GFdpRaNUPyyzojE49zTGfaWNNsg@mail.gmail.com>
Subject: Re: [PATCH 1/2] misc/mei: Add NULL check to component match callback functions
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        linux-kernel@vger.kernel.org,
        "Winkler, Tomas" <tomas.winkler@intel.com>
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

On Tue, Apr 19, 2022 at 2:59 AM Won Chung <wonchung@google.com> wrote:
>
> Currently, component_match callback functions used in mei refers to the
> driver name, assuming that the component device being matched has a
> driver bound. It can cause a NULL pointer dereference when a device
> without a driver bound registers a component. This is due to the nature
> of the component framework where all registered components are matched
> in any component_match callback functions. So even if a component is
> registered by a totally irrelevant device, that component is also
> shared to these callbacks for i915 driver.
>
> To prevent totally irrelevant device being matched for i915 and causing
> a NULL pointer dereference for checking driver name, add a NULL check on
> dev->driver to check if there is a driver bound before checking the
> driver name.
>
> In the future, the string compare on the driver name, "i915" may need to
> be refactored too.
>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Reviewed-by: Prashant Malani <pmalani@chromium.org>
> Signed-off-by: Won Chung <wonchung@google.com>
> ---
>  drivers/misc/mei/hdcp/mei_hdcp.c | 2 +-
>  drivers/misc/mei/pxp/mei_pxp.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/misc/mei/hdcp/mei_hdcp.c b/drivers/misc/mei/hdcp/mei_hdcp.c
> index ec2a4fce8581..e889a8bd7ac8 100644
> --- a/drivers/misc/mei/hdcp/mei_hdcp.c
> +++ b/drivers/misc/mei/hdcp/mei_hdcp.c
> @@ -784,7 +784,7 @@ static int mei_hdcp_component_match(struct device *dev, int subcomponent,
>  {
>         struct device *base = data;
>
> -       if (strcmp(dev->driver->name, "i915") ||
> +       if (!dev->driver || strcmp(dev->driver->name, "i915") ||
>             subcomponent != I915_COMPONENT_HDCP)
>                 return 0;
>
> diff --git a/drivers/misc/mei/pxp/mei_pxp.c b/drivers/misc/mei/pxp/mei_pxp.c
> index f7380d387bab..5c39457e3f53 100644
> --- a/drivers/misc/mei/pxp/mei_pxp.c
> +++ b/drivers/misc/mei/pxp/mei_pxp.c
> @@ -131,7 +131,7 @@ static int mei_pxp_component_match(struct device *dev, int subcomponent,
>  {
>         struct device *base = data;
>
> -       if (strcmp(dev->driver->name, "i915") ||
> +       if (!dev->driver || strcmp(dev->driver->name, "i915") ||
>             subcomponent != I915_COMPONENT_PXP)
>                 return 0;
>
> --
> 2.36.0.rc0.470.gd361397f0d-goog
>

Hi Tomas,

I am adding you to this patch since you are the maintainer of MEI.
If this looks okay to you, could you also take a look at the comment
thread on the cover letter and give an ack if it is okay to be merged
into thunderbolt tree?
https://lore.kernel.org/all/20220418175932.1809770-1-wonchung@google.com/

Thank you,
Won
