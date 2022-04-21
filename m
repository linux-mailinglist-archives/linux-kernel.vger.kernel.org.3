Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDB7509F7F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 14:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383640AbiDUMVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 08:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353152AbiDUMVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 08:21:45 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E592D1DC
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:18:55 -0700 (PDT)
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C793C3F19D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1650543533;
        bh=4bYptzY3YzLmhGBN6lm6r5JMn01LLupyoyy4UGqZLCs=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=XIOIqF06yaluz59cAFULwgdNvxlcIItrk/BhHvZUvGOImJT01A3H064/6Psi508cN
         XytKNUxESlkgJZss1IYxy2w7LlS5F0IjsQ929xBtMr1x6ESrJC4D9JAkRem8OPC8tM
         cF4L0mgJWcDtI112Cdfy3e6MBeRRi46jDGeQV28Jn8HWEIOT1S2r6S4xZPcEm9TAbz
         b8urdc7xUeqZfyQRoUbBTCQAW6RRRmFNgwskC14B2/xEjtG/w9/MrnRGWHKcZPstoL
         XjlLES2QuEiGG7/XdTMkauMUwKcdM8xsOcoQ+nskzWiIWE058WVRntYCsWsKf7w0PR
         DlfeL5rwVK1mg==
Received: by mail-oo1-f71.google.com with SMTP id v67-20020a4a5a46000000b0033331e32ee0so2388166ooa.20
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4bYptzY3YzLmhGBN6lm6r5JMn01LLupyoyy4UGqZLCs=;
        b=oE+GB9wRp+yKth3lmCnP1AG6WWhArT7jj4JgkG3xuvGtZc6xJsJF9IOtrsCHEbkFOJ
         gXfwAj7NENvcWmhbgGLr1/76G6R+Xe3dJH7H5UeIfb4nQ8GWmHOQYQnx9sTI0bPSG032
         ut5/Wihwsy+043h77BsjXdAKGdpPUCPSwOFw1za54irtMdGV/6VqgghgVST3WsRghNM9
         EEucH/dYtx9G3KgPnH/fqNqQhbmOztKlT5GkUNAl22sXoHCJgXwukl/KfB1CBcovZcYK
         KLJNdOuBuC186RHtZoYyb9ra17aZfHRhqFjyhFgyzS6/mKJ88FgJHbA3/+W6XRyQ3Jzu
         GZKw==
X-Gm-Message-State: AOAM532ZXw47cHWIvmIvMOA95IovxX1gHl4tmmgBN4vYsCY+mV0uxcy5
        1bXp07IZ47EukZ0DFludpHwu+Dv7BoZuKlLCS9w6qUpH6mSqA8gJ/zCmbG+l2Q69uPoq+XF7xGS
        U1ZYYjy6Qj5az8Ed2huUyhj8S2pmWxlNQEIJ4G50lcJTZJhVTfMrsHIT6WQ==
X-Received: by 2002:a05:6870:a98e:b0:dd:c79d:18a2 with SMTP id ep14-20020a056870a98e00b000ddc79d18a2mr3460013oab.198.1650543532715;
        Thu, 21 Apr 2022 05:18:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5OQzv+iidRy4CedEneehsPXtQOwhdGPI+31vMY5vFpqfcuR9Z9penNJAsByljzHp3wKGE/pNbIqbAbO2ZhmM=
X-Received: by 2002:a05:6870:a98e:b0:dd:c79d:18a2 with SMTP id
 ep14-20020a056870a98e00b000ddc79d18a2mr3460004oab.198.1650543532392; Thu, 21
 Apr 2022 05:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220420124053.853891-1-kai.heng.feng@canonical.com>
 <20220420124053.853891-2-kai.heng.feng@canonical.com> <YmAc+dzroa4D1ny2@lunn.ch>
 <CAAd53p5Wwn+HOMm1Z0VWcR_WrTzRvAGZOYg4X_txugSFd+EsDQ@mail.gmail.com> <YmFCxnYdRnnk41QQ@lunn.ch>
In-Reply-To: <YmFCxnYdRnnk41QQ@lunn.ch>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 21 Apr 2022 20:18:40 +0800
Message-ID: <CAAd53p5KjYD9O_HHNdQYYUY9POzUtCe8Zaj1NeweAmy8S9zK1Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] net: mdio: Mask PHY only when its ACPI node is present
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk,
        peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 7:40 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Apr 21, 2022 at 10:58:40AM +0800, Kai-Heng Feng wrote:
> > On Wed, Apr 20, 2022 at 10:47 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > >
> > > On Wed, Apr 20, 2022 at 08:40:48PM +0800, Kai-Heng Feng wrote:
> > > > Not all PHY has an ACPI node, for those nodes auto probing is still
> > > > needed.
> > >
> > > Why do you need this?
> > >
> > > Documentation/firmware-guide/acpi/dsd/phy.rst
> > >
> > > There is nothing here about there being PHYs which are not listed in
> > > ACPI. If you have decided to go the ACPI route, you need to list the
> > > PHYs.
> >
> > This is for backward-compatibility. MAC can have ACPI node but PHY may
> > not have one.
>
> And if the PHY does not have an ACPI node, fall back to
> mdiobus_register(). This is what of_mdiobus_register() does. If
> np=NULL, it calls mdiobus_register() and skips all the OF stuff.

The equivalent to this scenario is that when MAC doesn't have ACPI node.
But yes it can unmask the PHYs if no ACPI node is found, then call
mdiobus_register().

Kai-Heng

>
>          Andrew
