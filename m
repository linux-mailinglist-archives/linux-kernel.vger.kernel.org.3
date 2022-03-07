Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C9E4D02F7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 16:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243783AbiCGPdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 10:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242190AbiCGPdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:33:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55B4435DE5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 07:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646667162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XJ5wyum5+lKErwJ18QL2wfl4q0lDTXpz1S2MtX22oUg=;
        b=hIeka1jFAuBh0olatSJZxnUmIP1UTNh30DnNi9oX2zlmTHQ0Xg/nJtt6ddXT+ASJ1XCm7L
        /ofXdF1KagBRaAamGnolANtMbvAO2Tlbv590hTsGvecMUirUDH2KefpFNGGsyagQSsSGQB
        93+Ao3MfeI0gD2/OkrZYiM0zqXLUDqo=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-67-ekOemi_sPMG6mI9rKSGKDQ-1; Mon, 07 Mar 2022 10:32:40 -0500
X-MC-Unique: ekOemi_sPMG6mI9rKSGKDQ-1
Received: by mail-oi1-f199.google.com with SMTP id ay31-20020a056808301f00b002d06e828c00so9801572oib.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 07:32:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XJ5wyum5+lKErwJ18QL2wfl4q0lDTXpz1S2MtX22oUg=;
        b=WJLIpUjvJEvVQSixxnBTA1lBNIsoNWLqhryV8bsS/DB3Oq/UiW6zM0SJ6Qg5jPicZk
         27LYvZlmXOZEV9oQBzjersPasuhihOdDMh2rEm6o2NLsCpmfbitqOthuIOxlug1erzl7
         plfsOMr0XwKsYLq/yrh9LLbtqhvl/3B6uDNJuj3F+p1R9FJ1ep9fetGChNmGrIP5/Apj
         mfQ6GYAT/Y94KEhKzVM6k1V2xHe+DdM6eykJh79MeT8oRluUVoO9bVk/sSqn1nSNgw9R
         XLCwGHkpz471o8biFs3Y5hF324OzzH1Uosh821J+TtW0YctSyH0HGa0AhwIml73eODif
         6ZuA==
X-Gm-Message-State: AOAM531PGQjv5l96KFXGjYEQH0KcSu5X+i1rjcp+bbcXYcVwV6dLJClC
        gy76Q71ntRNfv2Z4GIWhS7OqB3rnFWCCRUdNOSqed2TwZmSVej1qm95j3KZr8hI3O+FjJ0gXJ8D
        1LN8uDxnv31bt4ceHGm/3Q7M7
X-Received: by 2002:a05:6808:198e:b0:2d9:c933:eeff with SMTP id bj14-20020a056808198e00b002d9c933eeffmr4160584oib.90.1646667160014;
        Mon, 07 Mar 2022 07:32:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzArEYDtw0XYNdk8IKmtWZ4y68YHoSd9vQW/X+GiP8avk+j7IwlPa2BYMK31IGS99RNZUqh1w==
X-Received: by 2002:a05:6808:198e:b0:2d9:c933:eeff with SMTP id bj14-20020a056808198e00b002d9c933eeffmr4160562oib.90.1646667159747;
        Mon, 07 Mar 2022 07:32:39 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id q9-20020a4ae649000000b00320d35fc91dsm2451714oot.24.2022.03.07.07.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 07:32:39 -0800 (PST)
Date:   Mon, 7 Mar 2022 08:32:38 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-pci@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH vfio-next] PCI/IOV: Fix wrong kernel-doc identifier
Message-ID: <20220307083238.5a52b478.alex.williamson@redhat.com>
In-Reply-To: <8cecf7df45948a256dc56148cf9e87b2f2bb4198.1646652504.git.leonro@nvidia.com>
References: <8cecf7df45948a256dc56148cf9e87b2f2bb4198.1646652504.git.leonro@nvidia.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  7 Mar 2022 13:33:25 +0200
Leon Romanovsky <leon@kernel.org> wrote:

> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Replace "-" to be ":" in comment section to be aligned with
> kernel-doc format.
> 
> drivers/pci/iov.c:67: warning: Function parameter or member 'dev' not described in 'pci_iov_get_pf_drvdata'
> drivers/pci/iov.c:67: warning: Function parameter or member 'pf_driver' not described in 'pci_iov_get_pf_drvdata'
> 
> Fixes: a7e9f240c0da ("PCI/IOV: Add pci_iov_get_pf_drvdata() to allow VF reaching the drvdata of a PF")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/pci/iov.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 28ec952e1221..952217572113 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -49,8 +49,8 @@ EXPORT_SYMBOL_GPL(pci_iov_vf_id);
>  
>  /**
>   * pci_iov_get_pf_drvdata - Return the drvdata of a PF
> - * @dev - VF pci_dev
> - * @pf_driver - Device driver required to own the PF
> + * @dev: VF pci_dev
> + * @pf_driver: Device driver required to own the PF
>   *
>   * This must be called from a context that ensures that a VF driver is attached.
>   * The value returned is invalid once the VF driver completes its remove()

Bjorn,

I'll be happy to grab this with your ack since the referenced commit is
coming from my branch.  Thanks,

Alex

