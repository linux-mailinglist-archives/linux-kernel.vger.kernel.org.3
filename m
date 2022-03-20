Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BB84E1D87
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 20:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343578AbiCTTJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 15:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbiCTTJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 15:09:38 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA4731221;
        Sun, 20 Mar 2022 12:08:14 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id s16so10404916qks.4;
        Sun, 20 Mar 2022 12:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j9jB6hCoAeek2so+uIbbjJIZdsM49+J+dmzdAcWuE6U=;
        b=hAaOVe0S/Wp8xdSsggeKtrbcoxGpvSP36S5g77qomweEH+mybh2PwtYDwYSecq0Ha3
         G3NbWWVxViMc2caj6YPNsgEMjIo6eGFD0V5fb4v5FhGUBVTSlrCToEyxMqCt6/ERkZCe
         dNTnNOEthHkZroFX9wSMfoK82l6cmtiTfH7WGZECBoavXKTiZqWrBie9KG9BgjtN0Gal
         q68M1+2s0VXaW6CiSxnX1U3gDkZ1u9J0krLBUIPEUEet0LnAq56ssCOMz7t/iTrRhRut
         YkReoAJ8EXN28w5EKeE86rcgruVhRhPfx95xNJVqNrwsrzPg+qB1GxV3rUIa20XI2NKN
         AvGQ==
X-Gm-Message-State: AOAM532Y0IQiEPE0QkAi9vu9+iZJoq1brXGs6HfNB85alopqi3385Otu
        gg1Nivauq42hl9f8hmtg9A==
X-Google-Smtp-Source: ABdhPJwnjk5ENlSemC+yJtR3JNmQohdlidXxuypc1ZAitRfT9b5WukCjAwdyT7jKx+Dv6jF301Xvng==
X-Received: by 2002:a37:65c5:0:b0:67b:3232:8cc8 with SMTP id z188-20020a3765c5000000b0067b32328cc8mr10773814qkb.170.1647803293628;
        Sun, 20 Mar 2022 12:08:13 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:c6d:21ec:c4f5:bb3:5269:3b0e])
        by smtp.gmail.com with ESMTPSA id v3-20020a05622a188300b002e1cbca8ea4sm10706141qtc.59.2022.03.20.12.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 12:08:12 -0700 (PDT)
Received: (nullmailer pid 3230186 invoked by uid 1000);
        Sun, 20 Mar 2022 19:08:10 -0000
Date:   Sun, 20 Mar 2022 15:08:10 -0400
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: virtio,mmio: Allow setting devices
 'dma-coherent'
Message-ID: <Yjd7mhLw/aKVSsS7@robh.at.kernel.org>
References: <20220310013528.549030-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310013528.549030-1-robh@kernel.org>
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

On Wed, 09 Mar 2022 19:35:27 -0600, Rob Herring wrote:
> 'virtio,mmio' devices are always coherent within a guest. As Arm DTs
> are default non-coherent, the 'dma-coherent' property needs to be set on
> the virtio device to mark them as such. This aligns with the QEMU 'virt'
> machine DTB.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/virtio/mmio.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
