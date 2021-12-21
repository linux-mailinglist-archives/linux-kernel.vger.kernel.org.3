Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6434147BF18
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 12:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237242AbhLULrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 06:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbhLULrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 06:47:23 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D94C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 03:47:22 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id bu9so7166982lfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 03:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5iHMu2RceiYZBlM7VQJrpbt7pv1hPIsprESHZDmwuTY=;
        b=SlMtEqXNa+jqXV5oiXirDiiBXnO7KyZtnJXamN8ehWQqFiIXZmDb8rw/p/J4AMpQ76
         8Y+bMR0/4sYPYk7Tv2e+ympFkAGUdXgWbUPNO0jU79aRV0/HF/K1XFznhJ+IaIMRQxiZ
         CatQl76QNhO4jtpNLXQo98+uPSloV0zA44ItlE4WKMGVcjtxVNstRQ3LdpjrmJC7bFLl
         U0uKoQZw1oKD/M0agtCq6G2MZlWhMcXhwpqp+BQ7aJfrZIUA5p0i7BCPRk74lcbbm3Cf
         2e25EO8OwWB+eIMtIpePRINnIYCmpCjsMuLuI2ksXr750wX/HIoUxZJytJCxUY7BJKI+
         xqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5iHMu2RceiYZBlM7VQJrpbt7pv1hPIsprESHZDmwuTY=;
        b=WBQBSKs+LYZZYfVERr8nxeo4DOwF1sH+zSJ9xYJPfhdI0SHOh8vzPnAt19eieAiUqX
         Bi9detJcQROlCLLqbxl/DcVDTkqIOMoNza6zoBhapo5+60tCI8+QKsTTPJKHT8d1jWO0
         0FutWBAWhLoslSidSsx4dhUeQK7+l04LE4Lu9ydcHx8vXs0AhW5gKvbpdmnd4MxtejWM
         sgbcn0C3qPp4Z3QwzLxPMu/0meoPW+dztCbJgrBZfDFqw1zEeBpa5iasy0Hsk1Yy4ajq
         6yAouFAW3TwMpC1Qy/cxWi2poB1bpcreB4atxdTdNjndfwwNV+7x1FR50U2qb+pM/5Kb
         7WbA==
X-Gm-Message-State: AOAM531BAN/Fvd+4aWIXILOTpkC+8z0eSz2ad54wF8tzmr9/w9Rl0guO
        z2zOxbQ0LpNRvg+jqw8qOnRCft7XgfDFsWGWDVGisQ==
X-Google-Smtp-Source: ABdhPJz5e1F2UioOi7x20744XGEveL1bhBJE+6hcEi+URVa1/5tCLuhCcxduegYHFw/t0tJUUmwS8b2xFV54ZZY88MA=
X-Received: by 2002:a05:6512:4015:: with SMTP id br21mr2819857lfb.233.1640087241138;
 Tue, 21 Dec 2021 03:47:21 -0800 (PST)
MIME-Version: 1.0
References: <5542600.DvuYhMxLoT@kreacher>
In-Reply-To: <5542600.DvuYhMxLoT@kreacher>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 21 Dec 2021 12:46:44 +0100
Message-ID: <CAPDyKFq+UFT0bbPSj01Tvzj0Ty50Tcq+zV_eCPt2h_Xmz00QfQ@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Simplify locking in pm_runtime_put_suppliers()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2021 at 20:16, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Notice that pm_runtime_put_suppliers() cannot be called with
> disabled interrupts, because it may sleep (due to the device
> links read locking in the non-SRCU case), and so it can use
> spin_lock_irq() and spin_unlock_irq() for the locking.
>
> Update the function accordingly and while at it move the "put"
> local variable in it into the inner block where it is used.
>
> This change is not expected to have any visible functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/runtime.c |   12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> Index: linux-pm/drivers/base/power/runtime.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/runtime.c
> +++ linux-pm/drivers/base/power/runtime.c
> @@ -1748,8 +1748,6 @@ void pm_runtime_get_suppliers(struct dev
>  void pm_runtime_put_suppliers(struct device *dev)
>  {
>         struct device_link *link;
> -       unsigned long flags;
> -       bool put;
>         int idx;
>
>         idx = device_links_read_lock();
> @@ -1757,11 +1755,17 @@ void pm_runtime_put_suppliers(struct dev
>         list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
>                                 device_links_read_lock_held())
>                 if (link->supplier_preactivated) {
> +                       bool put;
> +
>                         link->supplier_preactivated = false;
> -                       spin_lock_irqsave(&dev->power.lock, flags);
> +
> +                       spin_lock_irq(&dev->power.lock);
> +
>                         put = pm_runtime_status_suspended(dev) &&
>                               refcount_dec_not_one(&link->rpm_active);
> -                       spin_unlock_irqrestore(&dev->power.lock, flags);
> +
> +                       spin_unlock_irq(&dev->power.lock);
> +
>                         if (put)
>                                 pm_runtime_put(link->supplier);
>                 }
>
>
>
