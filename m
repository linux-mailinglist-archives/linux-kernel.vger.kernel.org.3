Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0419561F13
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbiF3PTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235661AbiF3PTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:19:40 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EC0377FE;
        Thu, 30 Jun 2022 08:19:39 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id h20so12589373ilj.13;
        Thu, 30 Jun 2022 08:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ADsvCR0mog9Wctcf3viijqLXbCb8A/ISSb9KkaYOBcQ=;
        b=cCs6Ygz0yf8Xf/i2rMrycvTOWJPctBTOHWroKkB4GKyDw0xnSrq7Su/sM/JyP5DKCr
         CBE8eedgnLBedmKOUXg/zyCqjzwcrPiel0HPvJCDJDXCUuPWVjq5iIx4RtZBOvTotxRc
         lO5K4yOkN8McDwRdYqx53j8k5Tt9bikH63Rhnv+pGbZKSLN3etsomFTqm08ON2MNIu1N
         KEnfdG8ERfIhJz0bWr9JiJMuV4Z1S22Djm/MCFNmcac476pY4AF/f7xOw3sNLjoluUDJ
         agEz9Na6xH1v2N1qNRPpLyf1+WamWhLThqWT3zp1vG1+vMtL3KAXTuorIj9OldSJfZPk
         yc2A==
X-Gm-Message-State: AJIora/ArW91ayKj5S21dJ7qJ5Nxy0Xa8na7sW/zjg+7fc5qBAJv6Ft/
        b3COPoXmvzZvbrVq6+O2Qw==
X-Google-Smtp-Source: AGRyM1syNumhIZ9i8WZw9tGrKUzdzJYR0RUCc8u+zCX5QaXsZAZPAG6uCSOCyYG4AF4BzG+LxuqWjA==
X-Received: by 2002:a05:6e02:b22:b0:2d9:2bda:34e9 with SMTP id e2-20020a056e020b2200b002d92bda34e9mr5615211ilu.273.1656602378655;
        Thu, 30 Jun 2022 08:19:38 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id r19-20020a02c853000000b00339dfb793aesm8731583jao.86.2022.06.30.08.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 08:19:38 -0700 (PDT)
Received: (nullmailer pid 2729118 invoked by uid 1000);
        Thu, 30 Jun 2022 15:19:36 -0000
Date:   Thu, 30 Jun 2022 09:19:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mikko Perttunen <cyndis@kapsi.fi>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7/v3 00/22] Host1x context isolation / Tegra234 support
Message-ID: <20220630151936.GA2722229-robh@kernel.org>
References: <20220627142008.2072474-1-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627142008.2072474-1-cyndis@kapsi.fi>
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

On Mon, Jun 27, 2022 at 05:19:46PM +0300, Mikko Perttunen wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
> 
> Integrated the Host1x context isolation series (patches 1 to 8) and
> Tegra234 support series (patches 9 to 22) in one email thread for
> the benefit of automatic testers.

And probably to the detriment of tools looking at the version number 
like b4 with the double version. Don't get creative like this.

Rob
