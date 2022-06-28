Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F9F55E7DB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348069AbiF1QB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 12:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348246AbiF1QBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 12:01:40 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A724C37A25;
        Tue, 28 Jun 2022 09:01:10 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id h187so20775304ybg.0;
        Tue, 28 Jun 2022 09:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uMaNSGappz9cVeuRcW4qtSkksstkuegRFciPogPxfeA=;
        b=eNcr80joiHxSsl/WU6Ybw6Cx00dOPVYcXTPn9RTDLCLVBnpioDFDNg0/Wb8NqrDP5k
         gdmKB8lI1joM7RPA0D6ifDQHMffltGcvDR1dnSDrJP7ocvqBm1+fUazS5dVOlaVYl2z3
         E7dxg70yKj+U45h/kRdS2oq1ba/lWlXv2ORqZTuP92+pNaKghgeMT/lurGvvEsmJ1sFk
         IDQhkyd4FU5qcoJsxy8Y4TRwj6h0dc+SgPd29nhbI0Bszp/wRbD7NNh0K8MmrKbz76UN
         3wt0yQuOdRNffaDhOSErEt+37hvGz5YcEtx5hYHmKHKREBKkIgtusw3InpM6eF1QCUQ9
         Ydzg==
X-Gm-Message-State: AJIora+sMu2K3nS8VrwKEe1W95OpDVMEAubWArXgaT+LCCtNTwTc46t4
        vy20ynQ+X5u1d5DGvG72jyIUYPLsfPMg7J8ticUJOI5G
X-Google-Smtp-Source: AGRyM1sOcSK9b/Nj+VspQSDrsUymMTlRPLzI4yS3poWbUnMORZXDxAHCqwzEs2ctY23x80/nitc/60D3nv4ifrctIIs=
X-Received: by 2002:a05:6902:1141:b0:669:3f2a:c6bb with SMTP id
 p1-20020a056902114100b006693f2ac6bbmr19131037ybu.365.1656432069677; Tue, 28
 Jun 2022 09:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <2653259.mvXUDI8C0e@kreacher> <YrqY+c1NPQ+wEiUk@kroah.com>
In-Reply-To: <YrqY+c1NPQ+wEiUk@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 28 Jun 2022 18:00:58 +0200
Message-ID: <CAJZ5v0i=stVf+igcmQmeiFSndOrBhegG1mJjku5OmojPzw5VhA@mail.gmail.com>
Subject: Re: [PATCH] PK: runtime: Redefine pm_runtime_release_supplier()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
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

On Tue, Jun 28, 2022 at 8:00 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 27, 2022 at 08:42:18PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Instead of passing an extra bool argument to pm_runtime_release_supplier(),
> > make its callers take care of triggering a runtime-suspend of the
> > supplier device as needed.
> >
> > No expected functional impact.
> >
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Nice, thanks for cleaning this up.
>
> If you want to take this through your tree:
>         Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> But if you want me to take it, please just let me know and I will.

I'll take care of it myself.

Thank you!
