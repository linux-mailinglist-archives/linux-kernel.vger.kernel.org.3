Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3FC567666
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiGES1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiGES1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:27:32 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BE319C11;
        Tue,  5 Jul 2022 11:27:31 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-31c8a1e9e33so65425277b3.5;
        Tue, 05 Jul 2022 11:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yDaZJQ1t7WZXHXc1sh5v+s4p6BMcgf4NLI5GY92Hi9Y=;
        b=YsLj+FjEE1wSWWBoTPNMdiuwSAUjEG2B/SFnSxUDY3eE2cXGua+WJo1hRfPvizR+Z+
         hE7QY+UA5krJBwM4vffjArMX6jOsQI7uZ0iZZPFQKr3tvyfOk1156Rft/RnTM9NZynHW
         GPNmCILG0L0rdE5N0NWs8Om7Pr+UkByWS9tdbxgBwq0QBsu3oGSNs46JTPXnLBAv3If6
         ozw4wR0fflfR1lADEh0++0d6le0Ayjmot/fzAIdpFdffTuIzrPPaGs8Pm2n+xaiiKOyU
         I+XvVwfOPrD0KibIzRYsRZL2dpJmZog6WuhQeWWdcHg12ZAmLRTLSNZ4OhnkixZLw6kk
         AyiA==
X-Gm-Message-State: AJIora8YulmCp9WZuQp84ruYVqewIxoT6dbjpFkS8OsvLtuYS2aSPtQ9
        UyQrhjXKkBaPHykD3n96KwQhg39Zw/4j9BfmQbE=
X-Google-Smtp-Source: AGRyM1s2QEn+mZPivlKtPrgixQUmIChTU4gw5ikon89zd7049nfH/7sTVF3gtghrOQrMUchoZ2CX/5thIM3o6KDInik=
X-Received: by 2002:a0d:d8c8:0:b0:31c:92b1:5dec with SMTP id
 a191-20020a0dd8c8000000b0031c92b15decmr14867269ywe.19.1657045650713; Tue, 05
 Jul 2022 11:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220630094059.1204283-1-eric.auger@redhat.com> <Yr1z2gC0+8zbzpFf@myrica>
In-Reply-To: <Yr1z2gC0+8zbzpFf@myrica>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Jul 2022 20:27:19 +0200
Message-ID: <CAJZ5v0hqcUUTVzkHxGr9pB5G-T5ye5g_=DQVO6L347DpXipwOg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: VIOT: Fix ACS setup
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Eric Auger <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, Joerg Roedel <jroedel@suse.de>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        iommu@lists.linux.dev, jinl@redhat.com
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

On Thu, Jun 30, 2022 at 11:59 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> On Thu, Jun 30, 2022 at 11:40:59AM +0200, Eric Auger wrote:
> > Currently acpi_viot_init() gets called after the pci
> > device has been scanned and pci_enable_acs() has been called.
> > So pci_request_acs() fails to be taken into account leading
> > to wrong single iommu group topologies when dealing with
> > multi-function root ports for instance.
> >
> > We cannot simply move the acpi_viot_init() earlier, similarly
> > as the IORT init because the VIOT parsing relies on the pci
> > scan. However we can detect VIOT is present earlier and in
> > such a case, request ACS. Introduce a new acpi_viot_early_init()
> > routine that allows to call pci_request_acs() before the scan.
> >
> > While at it, guard the call to pci_request_acs() with #ifdef
> > CONFIG_PCI.
> >
> > Fixes: 3cf485540e7b ("ACPI: Add driver for the VIOT table")
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > Reported-by: Jin Liu <jinl@redhat.com>
>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Tested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Applied as 5.20 material, thanks!
