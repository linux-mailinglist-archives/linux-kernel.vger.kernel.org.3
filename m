Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6105D5A1945
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 21:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243597AbiHYTAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 15:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240803AbiHYTAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 15:00:16 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222DC79ED8;
        Thu, 25 Aug 2022 12:00:09 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id u14so24423299oie.2;
        Thu, 25 Aug 2022 12:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=PUbVSKlmkU082xttfGm1YPfbzKzE5aThWI2APYl/3wI=;
        b=Ev2SCxqksE4j/79fwbXKGoF8k00qgV5YpLtUv7bOa1jHUYh3NrkZiKaAk4jrRNtsyL
         6h5+lOR4uQoA39iOXD/IJAajusu3LDixGVWu5UkfknbBjyKtgdAFCY6EALnFeENXzrm7
         1yxyd2yqNdHUU0xatGj8T1UflVf9VjA0aj+1InNpBpRCJANwgqkk2VxO/Wl4nxre4qDR
         IwKmJEBDRLAnvjaj9sk3hbqMX2pRcht2HqDsfwr5GoqTsk7VX6Lh17+shmWqNNBSeYJa
         H/UmaaJrBCnpkpQpdLPBJ/NvZGMMJ4gwUUvM2IzGnzCBcw9kmlcbw1g2qwpCBLtlPDcf
         WDVw==
X-Gm-Message-State: ACgBeo2XPaFX9QDkD9pSupqXGtEzTR/Cu//uXhdX3x8ELqTjJr6xObPt
        SSAXTOmFsSmJfebiYdmf3w==
X-Google-Smtp-Source: AA6agR5jYSGCujwUIr1fD1MmfZC5CU99tY223caR+z2MYIA4xBGDQouUrbynRLdXnhAsi87jNUv9eA==
X-Received: by 2002:a54:4004:0:b0:345:3cbf:be4a with SMTP id x4-20020a544004000000b003453cbfbe4amr160964oie.55.1661454008357;
        Thu, 25 Aug 2022 12:00:08 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e2-20020a4ab142000000b0044893e6a2a4sm50260ooo.11.2022.08.25.12.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 12:00:07 -0700 (PDT)
Received: (nullmailer pid 1499762 invoked by uid 1000);
        Thu, 25 Aug 2022 19:00:06 -0000
Date:   Thu, 25 Aug 2022 14:00:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH] of/device: Fix up of_dma_configure_id() stub
Message-ID: <20220825190006.GA1499466-robh@kernel.org>
References: <20220824153256.1437483-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824153256.1437483-1-thierry.reding@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Aug 2022 17:32:56 +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Since the stub version of of_dma_configure_id() was added in commit
> a081bd4af4ce ("of/device: Add input id to of_dma_configure()"), it has
> not matched the signature of the full function, leading to build failure
> reports when code using this function is built on !OF configurations.
> 
> Fixes: a081bd4af4ce ("of/device: Add input id to of_dma_configure()")
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  include/linux/of_device.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Applied, thanks!
