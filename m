Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2451257A985
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 23:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240072AbiGSVza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 17:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiGSVzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 17:55:24 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8BC2B1A3;
        Tue, 19 Jul 2022 14:55:23 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id i5so1032971ila.6;
        Tue, 19 Jul 2022 14:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FZRSUDS8uTKKOTvNDdOgMcfB+NZAynssEK1o4xPqcoo=;
        b=PUwJQWV8qW/fEaAi5uAr3qjr/zw3vzoubEchHTHkoyYe4WHQJA3qFrDQpIChEWqulB
         wcBd4O0XfPWT4l2k8rlLGfNyQ2Uj2e+roY9aQKumY8GJbK/xrS3lbvmQJx9orTfZItWY
         6eIYGbsJjwXrczcYdVL84hKfg5iPo3WPyMaoMBdUPJWkbq5RhbDSAAkmVDynRvL3yGnr
         64By0SdqCeIL3WuTsZmh/dcZ5XcnOycvp1O4sKqddzfQTCiBGsYH2cXkZhtYB2QuOd42
         qbILvBUpHINRaud7O2jfC/gDyaqZLxyGa32GOYru4Jjtf1f52zoo4mJ801Atk7zYcT8U
         FgeA==
X-Gm-Message-State: AJIora8BQIwssdag5YJ2q8AJHg3YJLxX4q3vav1jcoPwhuVQnAlOO84s
        YCbbvyN5l+GR7dQATuaOtQ==
X-Google-Smtp-Source: AGRyM1uNzVh5TcQkrTVZ0DWXNnan9Jgk91fkoxJ1gZoyp0Yr6P89KZxwo2qGjLCJf3jgZxhKRliDDw==
X-Received: by 2002:a05:6e02:15c5:b0:2d7:a1cf:6f87 with SMTP id q5-20020a056e0215c500b002d7a1cf6f87mr17272420ilu.30.1658267723132;
        Tue, 19 Jul 2022 14:55:23 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id j15-20020a0566022ccf00b0067beb49f801sm5787777iow.2.2022.07.19.14.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 14:55:22 -0700 (PDT)
Received: (nullmailer pid 1883200 invoked by uid 1000);
        Tue, 19 Jul 2022 21:55:20 -0000
Date:   Tue, 19 Jul 2022 15:55:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] of: overlay: Simplify of_overlay_fdt_apply() tail
Message-ID: <20220719215520.GA1883155-robh@kernel.org>
References: <cover.1657893306.git.geert+renesas@glider.be>
 <6a3357a8f7f29704350e3ffae768ee8a462b54d3.1657893306.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a3357a8f7f29704350e3ffae768ee8a462b54d3.1657893306.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 16:03:15 +0200, Geert Uytterhoeven wrote:
> It does not hurt to fill in the changeset id while the mutex is still
> held.  After doing so, the function tails for the success and failure
> cases become identical, so they can be unified.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/of/overlay.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 

Applied, thanks!
