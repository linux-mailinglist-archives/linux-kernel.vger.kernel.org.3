Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6BF57A983
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 23:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbiGSVzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 17:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiGSVzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 17:55:19 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2768AE0A4;
        Tue, 19 Jul 2022 14:55:15 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id n7so12945996ioo.7;
        Tue, 19 Jul 2022 14:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HGECUZ+gwgXLJgCEPVND4t2Y0/BsOtMsWBLG9CvKJ2U=;
        b=Tzju7NXXZIJCrDQZsTNKw1qbDr+WZdkf7QOvd9dRrzusd76EMuXbXXzI0j1h7Ew/GS
         Yug9BBM0xfQ8Uw1EXzmR2xbaku1Q/VxCj8YOFS6Q0Dy25KTtEoIU9Wtlgx9APbDbK2vo
         BZpkDcdUNrZefP0HAu6sIM7vNRlKYKGEjodTHWt0Gsv5K9ZLIyKV9OXBRsoxQYyqg/uM
         8HXsHvHl2+xEpdVt+C2bdGWitjg+/lHV6U2IW6m5had3nCTR3V/1NWMRsBGqVbDE8utb
         dvd9rdP2Cqi37ko9yLWeQEwmZSOJ1GGuycbQpG/En/iEx6X4SJaVbOFWm6e7f0PZz0qb
         On/g==
X-Gm-Message-State: AJIora/IIzgH11oSMx1A5Ar3+j13/H1+btAhNmAnGhJjXZzQUepgEwqm
        lLHK7IWF9sPVlUrNyunSiQ==
X-Google-Smtp-Source: AGRyM1uykckcrz8I6WH/0lQKf6MbjisGg4w28sMCQxsuPtgFxzzlJX8tELA8UKcmkPVFbnEXLnpHPQ==
X-Received: by 2002:a05:6638:118c:b0:33f:3425:a798 with SMTP id f12-20020a056638118c00b0033f3425a798mr18251080jas.311.1658267714391;
        Tue, 19 Jul 2022 14:55:14 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id e25-20020a056602045900b0067bcc80ac23sm7896269iov.1.2022.07.19.14.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 14:55:14 -0700 (PDT)
Received: (nullmailer pid 1882877 invoked by uid 1000);
        Tue, 19 Jul 2022 21:55:12 -0000
Date:   Tue, 19 Jul 2022 15:55:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] of: overlay: Move devicetree_corrupt() check up
Message-ID: <20220719215512.GA1882804-robh@kernel.org>
References: <cover.1657893306.git.geert+renesas@glider.be>
 <c91ce7112eb5167ea46a43d8a980e76b920010ba.1657893306.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c91ce7112eb5167ea46a43d8a980e76b920010ba.1657893306.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 16:03:14 +0200, Geert Uytterhoeven wrote:
> There is no point in doing several preparatory steps in
> of_overlay_fdt_apply(), only to see of_overlay_apply() return early
> because of a corrupt device tree.
> 
> Move the check for a corrupt device tree from of_overlay_apply() to
> of_overlay_fdt_apply(), to check for this as early as possible.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/of/overlay.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 

Applied, thanks!
