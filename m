Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9404B4EE302
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241594AbiCaVD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237750AbiCaVD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:03:56 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C56648E51;
        Thu, 31 Mar 2022 14:02:08 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id e4so840267oif.2;
        Thu, 31 Mar 2022 14:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FFZzJZD1ilHMc+C5rzS/whkRiTwQWx48aH2loZDo7hY=;
        b=RQHN0G5aL3rRvgHYznu50a2ACmxw4REZpH5c8KtMf1RQp0IqnAiryAMZtTaOIU57dw
         LyJlYUHQ3Xd2bgsgIPCasu1Cdv7Q3C1xjD4jeSOQKdnPVKFGhvu6Kk8XByAE+II3rSKP
         Ri0KpQdtSpvcqMaQ59zfqYA2npzK07bdGUvtI6jIzPXnXikrRpODA6pT43WlintotsEh
         QQKlLq9scbwOYGW57r6zN/mSW0fdO1g+n2nX7iuz5w+l+joLL6OHXnfiaITckPQUqxI5
         IRpCCqt8rYHYHQa1dnUfGJFYPLuonWEYpfzj0/B4wotIGRg3wbnxm3nxyTbV+lvBd+mB
         NyBw==
X-Gm-Message-State: AOAM533IIDWGTfzVLOO0qU063SgGYRu/Ow0LhJ5V1Q/z0T1egsVxs7DY
        /PHxKtCdTwM97Cii/mcNDi9FI1yCiQ==
X-Google-Smtp-Source: ABdhPJzml3JKRyTuh5X18bZ5CcpMxbVMlhp/lW79dCwdHHDTlmlHY5CzJuyfa8ZNs8/qhtsWlxcVtA==
X-Received: by 2002:aca:1e16:0:b0:2ef:4b94:2cda with SMTP id m22-20020aca1e16000000b002ef4b942cdamr3313577oic.149.1648760527326;
        Thu, 31 Mar 2022 14:02:07 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w4-20020a4adec4000000b0032109de628esm258313oou.6.2022.03.31.14.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 14:02:06 -0700 (PDT)
Received: (nullmailer pid 1493640 invoked by uid 1000);
        Thu, 31 Mar 2022 21:02:05 -0000
Date:   Thu, 31 Mar 2022 16:02:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [RFC PATCH] of/platform: Drop static setup of IRQ resource from
 DT core
Message-ID: <YkYWzf7J17AfXgLl@robh.at.kernel.org>
References: <20220316200633.28974-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316200633.28974-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On Wed, Mar 16, 2022 at 08:06:33PM +0000, Lad Prabhakar wrote:
> Now that all the DT drivers have switched to platform_get_irq() we can now
> safely drop the static setup of IRQ resource from DT core code.
> 
> With the above change hierarchical setup of irq domains is no longer
> bypassed and thus allowing hierarchical interrupt domains to describe
> interrupts using "interrupts" DT property.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Hi All,
> 
> Sending this as RFC as couple of more drivers need to hit -rc yet with
> the platform_get_irq() change while that is in progress I wanted to get
> some feedback on this patch.

I just applied this on top of current master and pushed to my 
for-kernelci branch. It should show up in kernelCI in a bit. I did this 
before all the fixes too and there were definitely a couple of test 
regressions.

Rob
