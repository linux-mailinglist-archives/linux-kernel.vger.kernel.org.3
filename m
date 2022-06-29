Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862535608F3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 20:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiF2SUk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Jun 2022 14:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiF2SUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 14:20:37 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8D0167ED;
        Wed, 29 Jun 2022 11:20:36 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id p7so28009776ybm.7;
        Wed, 29 Jun 2022 11:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Crk8yfaClehfBEoMwUZukif4aHshjHYVzAHB+xwP0FE=;
        b=HZZG/PtdhoucGRkNyBoYieT+4UYmKgU1bwe86GlHv47yzpSU0PO3JDg6DkkF0ENetV
         Ablde+BXHcTzoKzbTiUj7J0sv6E6hsn6w+01XCGwlDKzm32l7CrK/szKqaLG3FEO4bXw
         1aBhqEOt2fWYeuicC7ShhPVnrtxA6yP2G5JbX2wmGyOCoq54dUO6Z/ogvCMBFeq3E+11
         QsgLlXAgc/gVpz/SA6qYZLgAlkvFX2u6k5f0EXjU40rW3u1xSwXCyXshiUiEkga6HJM3
         4uIcW5ROKHr5GlAASEpiGxkUBIdrH+9ppLWShSYelzxlIhFGuf7idMqxQhBeJH4gRTzL
         uVdw==
X-Gm-Message-State: AJIora+1bCrPAVm61jVs84jLgufPpFszgmpVh0+tMt4ajrYFP3V61JrN
        sBYJuNrz4wX38YG+IPlxRulZrX7sQ+75lwShnSSV58Xh
X-Google-Smtp-Source: AGRyM1vJlSLb2ZdnpN+6b/Ix2dG/vssdGSDOEXooJ2PCtG+knL7GwxDyyMXQeTN0E0u2b+2K2imFc6bUuNvUfaHEjbU=
X-Received: by 2002:a25:664f:0:b0:66c:d0f4:36cc with SMTP id
 z15-20020a25664f000000b0066cd0f436ccmr4697176ybm.482.1656526835822; Wed, 29
 Jun 2022 11:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220623132127.1248462-1-15815827059@163.com> <CAJZ5v0jC+B7K0uuE=wLi1hk+WATn5B8sSu6abSO00rYJ4ofRFw@mail.gmail.com>
 <18367cc4.16aa.1819382c273.Coremail.15815827059@163.com>
In-Reply-To: <18367cc4.16aa.1819382c273.Coremail.15815827059@163.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Jun 2022 20:20:24 +0200
Message-ID: <CAJZ5v0hVmB4KH-RQdO25kuBes2iC3Md+DX2xjoLODL0LFJvV4Q@mail.gmail.com>
Subject: Re: Re: [PATCH] ACPI: LPSS: Fix missing check in register_device_clock
To:     huhai <15815827059@163.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        huhai <huhai@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 4:35 AM huhai <15815827059@163.com> wrote:
>
>
> At 2022-06-23 21:25:55, "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> >On Thu, Jun 23, 2022 at 3:21 PM huhai <15815827059@163.com> wrote:
> >>
> >> From: huhai <huhai@kylinos.cn>
> >>
> >> register_device_clock() misses a check for platform_device_register_simple().
> >> Add a check to fix it.
> >>
> >> Signed-off-by: huhai <huhai@kylinos.cn>
> >> ---
> >>  drivers/acpi/acpi_lpss.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> >> index fbe0756259c5..c4d4d21391d7 100644
> >> --- a/drivers/acpi/acpi_lpss.c
> >> +++ b/drivers/acpi/acpi_lpss.c
> >> @@ -422,6 +422,9 @@ static int register_device_clock(struct acpi_device *adev,
> >>         if (!lpss_clk_dev)
> >>                 lpt_register_clock_device();
> >>
> >> +       if (IS_ERR(lpss_clk_dev))
> >> +               return PTR_ERR(lpss_clk_dev);
> >> +
> >
> >Why not use IS_ERR_OR_NULL() instead?
>
> platform_device_register_simple() never returns NULL as it declared bellowing，
> so use IS_ERR() to validate the return value should be enough.
>
> /**
>  * platform_device_register_simple - add a platform-level device and its resources
>  * ...
>  * Returns &struct platform_device pointer on success, or ERR_PTR() on error.
>  */

Fair enough.

Applied as 5.20 material, thanks!
