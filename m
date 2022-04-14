Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1C4500E13
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243600AbiDNMwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243577AbiDNMwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:52:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDD91EEE8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 05:49:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0BB8B82938
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:49:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DC4C385A5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649940586;
        bh=C2Kk6JG6xL+z4XI22pXh4XkU/JyALopXrnZXdcSiBcM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Xa3C4nEoqfvQL8zuDvgpCLQj0Qk/QJEXWk+3W1puxrfxKl7iWROEdmTsWgFJiAtZP
         iYjH2NEKwA6beHxy+6CB5Ywbj6NUeKCzVIJkEdmGpifjMBZtzmv9ceNfnbpv66Ss02
         JOvre9x1D3VpOgEZKeutvcVjO7W2VZ2yoP5Kqxr0gZzxIYyQgaP2HsEyUZewQXBiib
         PHUMnQjLQ3tarSu/SJPPs7PjvAtf/ikEWTC9uT/6QhF4xo9rNTE4mIb1HyMzag2fF4
         x9oqU2+69EiT6904G+8XTJ3q1gmUb3MXkpTf3MCRowyt5phT8F6LStrp2hxw0KTCLY
         ZOZ7AZJwE+54A==
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2ebf4b91212so53852547b3.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 05:49:46 -0700 (PDT)
X-Gm-Message-State: AOAM5305aiR4/MxcDhuRY2O2MV6vrFqcK5ySPQORWMYIGRF7E5Jmei6W
        fp0fFKjDW9s2sJ52Usy18fim4ojFakuOjl8AAgE=
X-Google-Smtp-Source: ABdhPJwNoPoFyfzZdliodNDCsFHXTluyQSmLzZQoxfspDcuXCQmbBNngdY7NkJvPwUXIL347E5RiBgkrECUaEOYobFE=
X-Received: by 2002:a81:6188:0:b0:2eb:4bd3:9b86 with SMTP id
 v130-20020a816188000000b002eb4bd39b86mr1702227ywb.46.1649940585554; Thu, 14
 Apr 2022 05:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <bec0fe9659f832715295f9895025ee8fd91847f3.1649680490.git.robin.murphy@arm.com>
In-Reply-To: <bec0fe9659f832715295f9895025ee8fd91847f3.1649680490.git.robin.murphy@arm.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Thu, 14 Apr 2022 15:49:18 +0300
X-Gmail-Original-Message-ID: <CAFCwf12J8FMen1-nRMnp=fjNEFJdKsGB8qnV_NLYbG9COX3BAQ@mail.gmail.com>
Message-ID: <CAFCwf12J8FMen1-nRMnp=fjNEFJdKsGB8qnV_NLYbG9COX3BAQ@mail.gmail.com>
Subject: Re: [PATCH v2] habanalabs: Stop using iommu_present()
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 3:36 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Even if an IOMMU might be present for some PCI segment in the system,
> that doesn't necessarily mean it provides translation for the device
> we care about. Replace iommu_present() with a more appropriate check.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>
> v2: Rebase on habanalabs-next
>
>  drivers/misc/habanalabs/common/debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
> index 7c4a4d504e4c..a94f01713efd 100644
> --- a/drivers/misc/habanalabs/common/debugfs.c
> +++ b/drivers/misc/habanalabs/common/debugfs.c
> @@ -722,7 +722,7 @@ static int hl_access_mem(struct hl_device *hdev, u64 addr, u64 *val,
>         if (found)
>                 return 0;
>
> -       if (!user_address || iommu_present(&pci_bus_type)) {
> +       if (!user_address || device_iommu_mapped(&hdev->pdev->dev)) {
>                 rc = -EINVAL;
>                 goto err;
>         }
> --
> 2.28.0.dirty
>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Applied to -next.
Thanks,
Oded
