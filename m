Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D4D485E83
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 03:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344663AbiAFCSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 21:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344590AbiAFCRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 21:17:54 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A6FC061201
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 18:17:54 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id be32so1703677oib.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 18:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=3AqXmqq/fvbOxqwSsHR7wVrpv5IIhXUtH49b4LPOTWI=;
        b=iS7/hV/IXv3fGbOyIo3DxFq5LwX+yNVjDMVRBSweVFwpCyyZTPKA24PenSTX69xA/i
         OuDCHNlFBOa4gVHOPRVu34iAgxyQp+F7IAqYNajp4XaNH8p+ohYFmq9bM3aYpSXZKQDU
         oaJROehE/SR2d9RGiS+dRzOOJ2oOSF4snbOh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=3AqXmqq/fvbOxqwSsHR7wVrpv5IIhXUtH49b4LPOTWI=;
        b=1sFwNk7DlEGzNNJlATc/YsZSk9xBRTvuMcNc7g+kerWgdkFa9BtK6RquvyceoCIHPu
         dhe7lzP1NIMjhAk7JqHaclspyZNznWdBpz8fZMqOz2TlK8qHivcEo1xBdDZBVbs3UBVp
         mnWMTscCBdSyjXr6wdDwnRhWuGpzpS3hH8BgjFYAvasKppjD1oolgDDEHBPNzzo8HE8n
         mms5zSqjqbnJ3/hgrYtt1lvN4fj/vKaH6KpcByNIp/A3WShWSyukFHmfw+o0502uhPWv
         /3veB57aVAhtq/hG6dm3DgkTWrNuxtUxbdmUijdu/+aiysZMxWW4pguGnIzAIhId5DW2
         K7sQ==
X-Gm-Message-State: AOAM530lPBzwT6nqXpmBEi1P5HL12ro4y0KE2N9gm/VX8FOtrzFUDQiG
        Cfm4bHqu17w6DplucBwWovKBRJJR8WGdnvzu1GZ+ig==
X-Google-Smtp-Source: ABdhPJxVckkTPHg9kSdLRZHjaIGQnCN/oUiOy+mbGbuwVgV7+6FQORY/VTnh4Y+bCHsmoHzUw0n87Qpp99riuTZQHtQ=
X-Received: by 2002:aca:4382:: with SMTP id q124mr4659737oia.64.1641435473794;
 Wed, 05 Jan 2022 18:17:53 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Jan 2022 18:17:53 -0800
MIME-Version: 1.0
In-Reply-To: <YcGel9PtOgqWH6l3@kroah.com>
References: <20211202222732.2453851-1-swboyd@chromium.org> <20211202222732.2453851-2-swboyd@chromium.org>
 <YcGel9PtOgqWH6l3@kroah.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 5 Jan 2022 18:17:53 -0800
Message-ID: <CAE-0n53WuAZZQzEsidz-N9Nat=qAJ10Mn4O4syurW11rTuEEMw@mail.gmail.com>
Subject: Re: [PATCH v4 01/34] component: Introduce struct aggregate_device
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Greg Kroah-Hartman (2021-12-21 01:29:59)
> > @@ -471,9 +477,17 @@ int component_master_add_with_match(struct device *parent,
> >       if (!master)
> >               return -ENOMEM;
> >
> > +     id = ida_alloc(&aggregate_ida, GFP_KERNEL);
> > +     if (id < 0) {
> > +             kfree(master);
> > +             return id;
> > +     }
> > +
> > +     master->id = id;
> >       master->parent = parent;
> >       master->ops = ops;
> >       master->match = match;
> > +     dev_set_name(&master->dev, "aggregate%d", id);
>
> You set the name yet the device is not "real"?
>
> I don't understand this patch at all, sorry.

The device is registered in the third patch. I'll squash this patch with
that one and move the rename patch to be the first patch in the series.
Then it should be clear why a struct device is introduced along with the
bus type it's associated with.
