Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EDA5804EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 21:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbiGYT6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 15:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiGYT6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 15:58:10 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414DB20BED;
        Mon, 25 Jul 2022 12:58:09 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id w204so14760596oie.7;
        Mon, 25 Jul 2022 12:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AauG+O02vULNR+GUaDx02x6zcrn1xM/KqisLkSx9ops=;
        b=lDDdeDFKcqcCgMv7R/nXxCDON73K98AzA2TGFTFgyIqTQrnZnZ4FkNiQpbW3Sx6a57
         j/XlOXiItP05ENBJchi15agCaHb5TNkWuC3zqoQbMEgZwIl8QzU6Nanu+7TiG8ZG5Y5C
         X8tEwZdbOvvptPtzaqxI2coET8JKVGzh6hDQ7IHYI4T5RI0V5n7jyEorQWIOu/4DuB55
         Dq0NO48Kjy4ZiNHsHKt8uvvPpydAw36aojGYmcwM9V9iqJrrzK1CvbASpLxEe1rpk/H5
         9O0Dpuye2bT1DWOg7KOG5It1X1MitgACHX7SKIoxCG+u6oJwsK9zk4JIMLm/29xJyxoG
         dOUg==
X-Gm-Message-State: AJIora+GdoA3JW1Sc8U30agk01rJT/1E5F1zywR09mgiwI+meiSMlRoD
        fNS6eGRslRQL/PxlEwxqVg==
X-Google-Smtp-Source: AGRyM1s37hiLU/WC6M9+NBavCmHsTPQnflXWt9C+ToWKW/F8IqAGkOq7/yWw59pVIJdJh1jHSIavDg==
X-Received: by 2002:a05:6808:1484:b0:33a:7c5b:69b with SMTP id e4-20020a056808148400b0033a7c5b069bmr13542725oiw.45.1658779087158;
        Mon, 25 Jul 2022 12:58:07 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id l6-20020a056871068600b0010e20d0b2e3sm1045702oao.44.2022.07.25.12.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 12:58:06 -0700 (PDT)
Received: (nullmailer pid 2610506 invoked by uid 1000);
        Mon, 25 Jul 2022 19:58:05 -0000
Date:   Mon, 25 Jul 2022 13:58:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] of/fdt: Clean up early_init_dt_reserve_memory_arch()
Message-ID: <20220725195805.GA2610441-robh@kernel.org>
References: <20220723015331.1607029-1-pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220723015331.1607029-1-pcc@google.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2022 18:53:31 -0700, Peter Collingbourne wrote:
> As of commit 18250b43f7b6 ("of: fdt: Remove
> early_init_dt_reserve_memory_arch() override capability") this is
> no longer an arch hook, so rename it to remove the confusing _arch
> suffix. Also remove some unnecessary indirection from all but one of
> the callers by calling memblock_reserve() directly instead.
> 
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Link: https://linux-review.googlesource.com/id/I3362bdd92ae6e47e8f5bac01aa228d32f9d01aad
> ---
>  drivers/of/fdt.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 

Applied, thanks!
