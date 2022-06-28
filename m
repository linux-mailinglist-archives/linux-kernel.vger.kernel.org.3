Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA15255E914
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345917AbiF1QOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 12:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346176AbiF1QNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 12:13:37 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8923238785;
        Tue, 28 Jun 2022 09:09:31 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id z191so13319364iof.6;
        Tue, 28 Jun 2022 09:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rFXFTk3zyTECjTww8beA+ZxYRzlU0MGcOVZE+7ZSiOQ=;
        b=NI0fezjkWcFZSWxJvDREQ+iEMZdJokt1czoQF9WJOCn/hzGeQMIYRoUEYu1iSfvqpn
         tz4BbOY6MWOiCO3pl/SHgjBVDfd5O0GpcOooZdHhCgcScZ0Muj3i2A5wu2vhoj4XSAGj
         a9Bkh8Av7LnKyG7dGx0RUf077z5mNhCXSXp3kIGxOR3PW1QVfMiDvtSnZGswfqRfYqx7
         sNeZZ7neqkVwWVP19HDFtedSpkyiQrFl1wY+ggZVmuk3f9tI2wqoWlJ6x9wUws2H7ukR
         gNQ0PNsZfz7AStNbtafO91HSbAO/N2ck5MxdK2CEmKxEEXMOeVfmdydbxo/Pgo/nr1vH
         RjUA==
X-Gm-Message-State: AJIora92PsQRR8qobp1YGldtUH59sv9g+3Kfn9d/5+PbRHgtgLIQbW/Q
        jYmd5IG+czi3Emgr3CraVA==
X-Google-Smtp-Source: AGRyM1tBc8crUdfJNgqGXpdzTPnUVWO/b1ksHuk1kAGanQCLTjvo8PiWpGgMndeJxLD+Y+MJvN3bFQ==
X-Received: by 2002:a5d:83c7:0:b0:66c:cc68:2f2d with SMTP id u7-20020a5d83c7000000b0066ccc682f2dmr9561292ior.74.1656432570645;
        Tue, 28 Jun 2022 09:09:30 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id u9-20020a056e021a4900b002d946b38ce2sm5885591ilv.46.2022.06.28.09.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 09:09:30 -0700 (PDT)
Received: (nullmailer pid 547896 invoked by uid 1000);
        Tue, 28 Jun 2022 16:09:27 -0000
Date:   Tue, 28 Jun 2022 10:09:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, kernel@axis.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: reserved-memory: Print allocation/reservation
 failures as error
Message-ID: <20220628160927.GA547820-robh@kernel.org>
References: <20220628113540.2790835-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628113540.2790835-1-vincent.whitchurch@axis.com>
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

On Tue, 28 Jun 2022 13:35:40 +0200, Vincent Whitchurch wrote:
> If the allocation/reservation of reserved-memory fails, it is normally
> an error, so print it as an error so that it doesn't get hidden from the
> console due to the loglevel.  Also make the allocation failure include
> the size just like the reservation failure.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  drivers/of/fdt.c             | 4 ++--
>  drivers/of/of_reserved_mem.c | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 

Applied, thanks!
