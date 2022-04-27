Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06BE5121DE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiD0TA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbiD0TAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:00:43 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F5F113CA3;
        Wed, 27 Apr 2022 11:46:23 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id j2so5109837ybu.0;
        Wed, 27 Apr 2022 11:46:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0cdA+JI48kZS+AxlzBx4Qt8iIGll7kLbRjF8CRRc1mE=;
        b=OaGyrRoSv87NfVAv27V/6TqlLXkvlnh9pdHNpxbZEfuw6UzLqHMGOs+Aa93jRSka42
         tbVHc8FgVwcE72i2vK8DpC3+PQD6tkL9r98PE/oFOFQQvbSjtKes/TuUxb/RmRv6Uq8B
         F6w2fyeV4QbFRbkUDz+tJOfQ2MrzseKQjBkQi+si732f8FNn7DQUKhMZJvFur+VfzGiM
         QpTSy8ZWIIQxU+CG8aTqgfOTJmM3ZWZF/FvOl1Y/IHi0YuTTafXgPfh2I3mVgNHCpxpD
         Q/6jcXhbLDWvVJ/doGOZP+ygHMQKRJwZ++t2UpWU3FFB7trTbXf9poGlS/8QUvPrRtaR
         hLsA==
X-Gm-Message-State: AOAM530xjjY9c8bxla3SMqW03parMTAdfLHzH6fL7KdLTbNBvVuxjbce
        av6lypbhPRsIGB+T4Ja5xWQzndGcH77X5VFpMe1g7w75
X-Google-Smtp-Source: ABdhPJwT3huBGS2K+bNnsZ8eZSYIdoXsCaigBa/fDfOditHuurhLrxP5JNE15oQnd6/c0CSljL/aM4n6to8/57goMo0=
X-Received: by 2002:a25:da84:0:b0:648:423e:57b0 with SMTP id
 n126-20020a25da84000000b00648423e57b0mr19076088ybf.137.1651085182297; Wed, 27
 Apr 2022 11:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220425114544.37595-1-heikki.krogerus@linux.intel.com> <Ymfa3F83zxgqD2pk@kroah.com>
In-Reply-To: <Ymfa3F83zxgqD2pk@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 Apr 2022 20:46:11 +0200
Message-ID: <CAJZ5v0hBjWomOxTw8Nfa83FEyDqGm+5B8W9WPEHfZR3uwUUdOw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] acpi: Remove acpi_release_memory()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 1:43 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Apr 25, 2022 at 02:45:42PM +0300, Heikki Krogerus wrote:
> > Hi,
> >
> > It seems there never were and there never will be actual devices that
> > expose the UCSI ACPI mailbox interface. There are now PD controllers
> > that support the UCSI interface, but they do not use the ACPI mailbox.
> >
> > So there is no point in mapping the mailbox with ioremap(), we can
> > just use memremap(). That should make it possible to also remove the
> > function acpi_release_memory(). That function was only there to make
> > it possible to use ioremap() in the UCSI ACPI driver.
> >
> > thanks,
> >
> > Heikki Krogerus (2):
> >   usb: typec: ucsi: acpi: Map the mailbox with memremap()
> >   acpi: Remove the helper for deactivating memory region
> >
> >  drivers/acpi/osl.c                 | 86 ------------------------------
> >  drivers/usb/typec/ucsi/ucsi_acpi.c | 19 ++-----
> >  include/linux/acpi.h               |  3 --
> >  3 files changed, 4 insertions(+), 104 deletions(-)
> >
> > --
> > 2.35.1
> >
>
> Look good to me, Rafael, want me to take this through the USB tree?  Or
> if you want to take it through the USB tree, here's my reviewed-by:
> either is fine with me.
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I've taken this into the ACPI tree (for 5.19) with your R-by, thanks!
