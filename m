Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E3A51DF30
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 20:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349563AbiEFSkw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 May 2022 14:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiEFSkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 14:40:46 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8B642EDA;
        Fri,  6 May 2022 11:37:03 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-2ef5380669cso90552687b3.9;
        Fri, 06 May 2022 11:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UdrIyXyLxRtPh/1P7CtUuWGYYGnc99vSj2tkYEMNJKA=;
        b=8GdxsFD+Gs+r8Jag/nZep7PR0XEcXGMIlwRkM+Ag5Cz19F+DKjZ4i05YfesBQEBUWJ
         7hIYJRCHHHvH2P5aMcJsoobE4cosdEBJyBd69hzgurrk5/6/+udMOQACzpxxx/VgkaHt
         WEGBd/8RmTl+sClUy3Asc2NAQLOZoPqY3aVCqXXnsjow9Aixcg5N0/yP8OuMtMJkpyw1
         HKey+Ja4U+ByveXWvz+0pevVJowhk3aFn5kQbSEgcgmB6N5Z4dYfCNGiPGmWRondWoU2
         hT9BLuHYoZK7aq8dPVAJA4zyQXqfSs8sCZCjx3WO1rkRydnba/Nw4HQKS4aEQqBzdOZP
         ulqQ==
X-Gm-Message-State: AOAM5325cdPd911WTaMTq7ND1bAeari4FHRjzUlG49wbhsAeBMQIBNMZ
        T85Du8PvD/LcpgVpWG8Xf0E3YqmicJPu8TPK0TY=
X-Google-Smtp-Source: ABdhPJz0zX+i6/o5qpEXuBrNZYFgGG0kgzOrG9BZ4N6Say4IgoDIeoX9gH6L4iAtjq6u87CfKPEdZW1wuCn/31MFsrE=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr3751243ywb.326.1651862222537; Fri, 06
 May 2022 11:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220425221802.68498-1-ilkka@os.amperecomputing.com>
In-Reply-To: <20220425221802.68498-1-ilkka@os.amperecomputing.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 6 May 2022 20:36:51 +0200
Message-ID: <CAJZ5v0gqr97AFuk855UZkcVpDnmj1Q6B2PE32zWmx4eKxbNvCw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: AGDI: Fix missing prototype warning for acpi_agdi_init()
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, Apr 26, 2022 at 12:18 AM Ilkka Koskinen
<ilkka@os.amperecomputing.com> wrote:
>
> When building with W=1, we get the following warning:
>
> drivers/acpi/arm64/agdi.c:88:13: warning: no previous prototype for ‘acpi_agdi_init’ [-Wmissing-prototypes]
>  void __init acpi_agdi_init(void)
>
> Include AGDI driver's header file to pull in the prototype definition
> for acpi_agdi_init() to get rid of the compiler warning
>
> Fixes: a2a591fb76e6 ("ACPI: AGDI: Add driver for Arm Generic Diagnostic Dump and Reset device")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>  drivers/acpi/arm64/agdi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/arm64/agdi.c b/drivers/acpi/arm64/agdi.c
> index 4df337d545b7..cf31abd0ed1b 100644
> --- a/drivers/acpi/arm64/agdi.c
> +++ b/drivers/acpi/arm64/agdi.c
> @@ -9,6 +9,7 @@
>  #define pr_fmt(fmt) "ACPI: AGDI: " fmt
>
>  #include <linux/acpi.h>
> +#include <linux/acpi_agdi.h>
>  #include <linux/arm_sdei.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> --

Applied as 5.19 material, thanks!
