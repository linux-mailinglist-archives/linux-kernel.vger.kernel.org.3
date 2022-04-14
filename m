Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8935B5018BF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbiDNQfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238780AbiDNQef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 12:34:35 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FC6ED90E;
        Thu, 14 Apr 2022 09:02:02 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-d39f741ba0so5657670fac.13;
        Thu, 14 Apr 2022 09:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7KsLQRipqF2R1uTMIte3i9/IDcR/0h8XgddwnNJ3ITE=;
        b=8QpoPIhGhAR6OCEs6CyltORZj5h9f+XNxatCot1BOe/si+aWRf48Pj8DPZ+J57bPrW
         F/0tbf95AI4bZVFs+lfqw7WYRtHBEKRf/mhOTeHJ8WmGgs2wvw4FD4MEFODXLzb4d9Pj
         fLwcfFFw5Gr2/pZqzqxNSL9cmj8HEHCJM3EcGM1x948k0XFzA80NXc8QCKStCPuOUv7U
         U0+u5pZTjWzC6k3WPxlIpd7UwXdCGgeVao/a8B8GCu8MvDmum4ll/xcFWLvlFcHC3Iu2
         RW8cFFdUxUfnEADVP78C1iBDs6e9RLjvWdDVW8sV5+eJlpS/MxUkay5NQmy+h3PUdOE5
         puYw==
X-Gm-Message-State: AOAM530jAq81cPFl4VWTuqZJb6C5bkZQzzS2RoSe1f7xcJSX6xnQ3yuy
        aw7+3Xi3EThQ7QWKWM7YoA==
X-Google-Smtp-Source: ABdhPJzuFrRAnqEOjn2Y036KhsZvM/oPgRNGTA4p69Jxmvf28J/M6tED0pEVCoQb189X/X79bsYoqQ==
X-Received: by 2002:a05:6871:1d0:b0:da:b3f:2b28 with SMTP id q16-20020a05687101d000b000da0b3f2b28mr1845203oad.199.1649952121431;
        Thu, 14 Apr 2022 09:02:01 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j16-20020a544810000000b002fa6ba4317esm138611oij.44.2022.04.14.09.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 09:02:00 -0700 (PDT)
Received: (nullmailer pid 2136331 invoked by uid 1000);
        Thu, 14 Apr 2022 16:02:00 -0000
Date:   Thu, 14 Apr 2022 11:02:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     vigneshr@ti.com, richard@nod.at, miquel.raynal@bootlin.com,
        joern@lazybastard.org, kernel@axis.com,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        krzk+dt@kernel.org, frowand.list@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] mtd: phram: Allow probing via reserved-memory
Message-ID: <YlhFeEvOPHHsMC34@robh.at.kernel.org>
References: <20220412135302.1682890-1-vincent.whitchurch@axis.com>
 <20220412135302.1682890-4-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412135302.1682890-4-vincent.whitchurch@axis.com>
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

On Tue, Apr 12, 2022 at 03:53:01PM +0200, Vincent Whitchurch wrote:
> Allow phram to be probed from the devicetree.  It expects to be in a
> reserved-memory node as documented by the bindings.  This allows things
> like partitioning to be specified via the devicetree.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
> 
> Notes:
>     v3:
>     - Add missing semicolon after MODULE_DEVICE_TABLE causing build errors on some
>       configs.
> 
>  drivers/mtd/devices/phram.c | 67 ++++++++++++++++++++++++++++++++++---
>  drivers/of/platform.c       |  1 +

For DT,

Acked-by: Rob Herring <robh@kernel.org>
