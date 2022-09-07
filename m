Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D125B0946
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiIGPzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 11:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiIGPy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:54:59 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60123719E;
        Wed,  7 Sep 2022 08:54:58 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id z22-20020a056830129600b0063711f456ceso10556578otp.7;
        Wed, 07 Sep 2022 08:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=5uXOqlrvWR3uWVEk6l0c6i/fUf4Y4MZ48Bj0I0ZIKfs=;
        b=5ztyaGaZifhslWh45Ku7dJ8YOxwtAxp5MR1meDTGjNZF5HazaXBK3s0/jFctlmD1o4
         tZtpK7MSsOlA16rAiLNtAAt6hJ8NTlY4JOtXS8fOoQp39fYfTXmHYibpqs6aKk4jXtAw
         TnaZoVfqVtW8o8mtuPTj5C5dg8yNJaFdSujNDZpu+K9qfffAg3ODvHMbbot3kv5asuhH
         mI/Z5atxZ7cH+3SvSRa8MYZATUA9iYuLI6nlAIw4wnlS6NqM36goy9p1tiPR5xDaWTW1
         WagI3FkDrXI1d/V+N+XJHqTYmO+aqZpGsPyk3walBOJ62aqULrJZbQDSxKVpN5ifnuFB
         7BmQ==
X-Gm-Message-State: ACgBeo2KOmDMv4D1aMnO+pmY4iuGNjEfZ52Yon1JpgwRw4i4p62TCI62
        YwIlz41aVj0Jr21EvBpDnA==
X-Google-Smtp-Source: AA6agR5t1B+zeDUDi09CJ4MBQnV5xcJDtwI/URcfEgna1NEYiMNE3zavl1QGMiT+oOCPcEIi3Jsdpw==
X-Received: by 2002:a9d:4e11:0:b0:638:de23:2e16 with SMTP id p17-20020a9d4e11000000b00638de232e16mr1675910otf.147.1662566097981;
        Wed, 07 Sep 2022 08:54:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id en4-20020a056870078400b00127dc5bb89esm1801633oab.37.2022.09.07.08.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 08:54:57 -0700 (PDT)
Received: (nullmailer pid 3526865 invoked by uid 1000);
        Wed, 07 Sep 2022 15:54:56 -0000
Date:   Wed, 7 Sep 2022 10:54:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexander A Sverdlin <alexander.sverdlin@nokia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] of: irq: Report individual failures in of_irq_init()
Message-ID: <20220907155456.GA3526808-robh@kernel.org>
References: <20220907121629.54330-1-alexander.sverdlin@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907121629.54330-1-alexander.sverdlin@nokia.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Sep 2022 14:16:29 +0200, Alexander A Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> 
> New pr_err(), a copy of preceeding pr_debug(), faciliates debugging.
> 
> This change was inspired by a long lasting debugging of the
> octeon_irq_init_ciu() which fails completely silently and leaves the
> interrupt controller half-way configured which in turn had very non-obvious
> effects.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> ---
> 
> Changelog:
> v2:
> * Kept existing pr_debug() on Rob's request
> 
>  drivers/of/irq.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Applied, thanks!
