Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9A2585FDC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 18:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbiGaQbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 12:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiGaQbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 12:31:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F1662C8;
        Sun, 31 Jul 2022 09:31:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30158B80DA7;
        Sun, 31 Jul 2022 16:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68224C433C1;
        Sun, 31 Jul 2022 16:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659285060;
        bh=iEhFJD0Uh7t+0kHyZggEl1bybolK+40g8fFl/KgN6ko=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z/Slht9nbTV3N6bk/OTKKa1e3XhwnQtIb7y5JrdR5qFA0anjPUxC7qEYtd//OO6fV
         dvZTzt0JoAT50wWGQWQc0plX2TVymmEQAwGolhIMC8YMJvhqUR6XSSRO11Pt86iLvT
         TfrdVZZ7uEVsRg025mqMSEbtMeHoz6RIwhACCeFjLbBrmWVLkAhzETMDKTh+3F1NAt
         OGCI6A8RJSc59iTT+a6yc5+NJXfRx++O+37ZRVvU/kmOU4I0lgDz1t/HTGq0psx3sp
         LdUveetYwsUzGrF+LbTDNJZVAA1gmrTsx+89Z02ZAmCSNojdFhIF+Or9PDxojXkxb0
         xxCF1DsulLIJQ==
Date:   Sun, 31 Jul 2022 17:41:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/9] Improve MCP3911 driver
Message-ID: <20220731174112.072345e3@jic23-huawei>
In-Reply-To: <20220722130726.7627-1-marcus.folkesson@gmail.com>
References: <20220722130726.7627-1-marcus.folkesson@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2022 15:07:17 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> Hi,
> 
> This patch series intend to fix bugs and improve functionality of the
> MCP3911 driver.
> The main features added are
> - Support for buffers
> - Interrupt driven readings
> - Support for oversampling ratio
> - Support for set scale values (Gain)
> 
> Among the bug fixes, there are changes in the formula for calculate raw
> value and a fix for mismatch in the devicetree property.
> 
> Another general improvement for the driver is to use managed resources
> for all allocated resources.
> 
Hi Marcus,

The first 3 fixes look good to me.  Do you want me to pick those up to
go in after rc1 via my togreg-fixes branch?  The side effect of doing
that is it'll be a little while before they are upstream in the branch
I'll want to pick the rest of the series on top of.

So it's a trade off between getting fixes in as soon as possible and
slowing down other improvements a little.

Jonathan

> General changes for the series:
> 
> v3:
> - Drop Phase patch
> - Add Fixes tags for those patches that are fixes
> - Move Fixes patches to the beginning of the patchset
> 
> v4:
> - Split up devm-cleanup functions 
> - Cosmetic cleanups
> - Add
>     select IIO_BUFFER
>     select IIO_TRIGGERED_BUFFER
>     To Kconfig
> - Add .endianness = IIO_BE
> 
> 
> Best regards,
> Marcus Folkesson
> 
> 
> 

