Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1806B55FDC1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 12:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbiF2KuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 06:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiF2KuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:50:20 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD821F2D5;
        Wed, 29 Jun 2022 03:50:19 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-31c1d580e4bso11846197b3.3;
        Wed, 29 Jun 2022 03:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SS6WoEyQUxMUch6lopg7oCcr6LEi5hOu3L6HXJpv9gI=;
        b=sQAr4GiaAcGXcPY57Rofkobrl8ngNKUYhcNRG6xQc+r9Qguu7TiS9GPG3cDAPdgg/a
         nQ5VIBsCtJaFQNLPDld5PLimCioGMEnlsCO4um2TFo9yUz2uOJ+DtZs8pmYj2JavjcTz
         ddS7SIQIcwJf80zUIUppiozz5NwxDByqPPWrFiuMTxrGbaaqjUQhHYliyKFraxmni9tK
         Nf+r/7ieubtMV20aON0Sj6hrnz8mHhJA3bGzC0xHqXNo5dC9h9otHaDz77xcOTUwaFdP
         WL0dVeTYoe0QPT8KIsXWeSnoUC+1RX8CEKiwQpYSYpAHmCMB+zi8dYG3ftlGLxX23MEb
         Fqxw==
X-Gm-Message-State: AJIora+lFPiwEuB+tOxqsTZx7ZHkdhztuvTpjyU5C93Q8KM8ZehiinnO
        CEAbcx1qHtRJVHEfLyy8gDDGCif45RNIKCY5Fds=
X-Google-Smtp-Source: AGRyM1saj8RFsYw15qKlx/hCuC7MdY3FuPPzmVeSkUQYkgs0AH54AFOngXa/60gQoNr04F6tP4lPlbwyoKSs5Pq8VY8=
X-Received: by 2002:a0d:d811:0:b0:31b:ddc4:c0ac with SMTP id
 a17-20020a0dd811000000b0031bddc4c0acmr3164886ywe.149.1656499818049; Wed, 29
 Jun 2022 03:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <4e1d5db9dea68d82c94336a1d6aac404@walle.cc> <b8ec04dc-f803-ee2c-29b7-b0311eb8c5fb@linaro.org>
 <CAJZ5v0jz=ee5TrvYs0_ovWn9sT06bcKDucmmocD8L-d9ZZ5DzQ@mail.gmail.com> <0b8e357d-1d8b-843f-d8b6-72c760bcd6fb@linaro.org>
In-Reply-To: <0b8e357d-1d8b-843f-d8b6-72c760bcd6fb@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Jun 2022 12:50:05 +0200
Message-ID: <CAJZ5v0g1VqJ2_2MtKGv-sHmKVQ12Rmj9r3Lr6D9wjmUYJwtoCw@mail.gmail.com>
Subject: Re: fwnode_for_each_child_node() and OF backend discrepancy
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Saravana Kannan <saravanak@google.com>,
        Grant Likely <grant.likely@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 12:32 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 27/06/2022 15:33, Rafael J. Wysocki wrote:
> > On Mon, Jun 27, 2022 at 3:08 PM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 27/06/2022 14:49, Michael Walle wrote:
> >>> Hi,
> >>>
> >>> I tired to iterate over all child nodes, regardless if they are
> >>> available
> >>> or not. Now there is that handy fwnode_for_each_child_node() (and the
> >>> fwnode_for_each_available_child_node()). The only thing is the OF
> >>> backend
> >>> already skips disabled nodes [1], making fwnode_for_each_child_node()
> >>> and
> >>> fwnode_for_each_available_child_node() behave the same with the OF
> >>> backend.
> >>>
> >>> Doesn't seem to be noticed by anyone for now. I'm not sure how to fix
> >>> that
> >>> one. fwnode_for_each_child_node() and also fwnode_get_next_child_node()
> >>> are
> >>> used by a handful of drivers. I've looked at some, but couldn't decide
> >>> whether they really want to iterate over all child nodes or just the
> >>> enabled
> >>> ones.
> >>
> >> If I get it correctly, this was introduced  by 8a0662d9ed29 ("Driver
> >> core: Unified interface for firmware node properties")
> >> .
> >
> > Originally it was, but then it has been reworked a few times.
> >
> > The backend callbacks were introduced by Sakari, in particular.
>
> I see you as an author of 8a0662d9ed29 which adds
> device_get_next_child_node() and uses of_get_next_available_child()
> instead of of_get_next_child(). Although it was back in 2014, so maybe
> it will be tricky to get original intention. :)

The OF part of this was based on Grant's suggestions.  My
understanding at that time was that this was the right thing to do for
OF and nobody told me otherwise.

> Which commit do you mean when you refer to Sakari's work?

3708184afc77 device property: Move FW type specific functionality to
FW specific files

However, it didn't change the "available" vs "any" behavior for OF.

> >
> >> The question to Rafael - what was your intention when you added
> >> device_get_next_child_node() looking only for available nodes?
> >
> > That depends on the backend.
>
> We talk about OF backend. In your commit device_get_next_child_node for
> OF uses explicitly available node, not any node.

Yes, it does.

If that doesn't match the cases in which it is used, I guess it can be adjusted.

> > fwnode_for_each_available_child_node() is more specific and IIRC it
> > was introduced for fw_devlink (CC Saravana).
> >
> >> My understanding is that this implementation should be consistent with
> >> OF implementation, so fwnode_get_next_child_node=get any child.
> >
> > IIUC, the OF implementation is not consistent with the
> > fwnode_get_next_child_node=get any child thing.
> >
> >> However maybe ACPI treats it somehow differently?
> >
> > acpi_get_next_subnode() simply returns the next subnode it can find.

I guess that the confusion is related to what "available" means for ACPI and OF.

In the ACPI case it means "this a device object corresponding to a
device that is present".  In OF it is related to the "status" property
AFAICS.
