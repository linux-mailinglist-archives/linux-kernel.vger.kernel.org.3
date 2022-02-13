Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38A64B3CCE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 19:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237751AbiBMSRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 13:17:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiBMSRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 13:17:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B742237FD;
        Sun, 13 Feb 2022 10:17:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E7D26124F;
        Sun, 13 Feb 2022 18:17:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECFFC340EB;
        Sun, 13 Feb 2022 18:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644776247;
        bh=HYb+oxLvNsZDSyfXa0FPW5sdeAZrK4dAhcxoRuS1iwM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rAOkul+oL+AJQqfrkcXXobFGpWGhC/yZaXWDHAr6ELIjFRZ7+VvJZpL8WNd26OBwa
         aXKCjlw0MVroEC2kYgnval4KjxaICLA0UCMrMS7VV3uPPJpujrEcbqLs9tsA8r9Q2Z
         bk/VeOjIQq/qUaX1dZ53fvDRkkhtkXL5qo3tcVvPmJj0K6koJnSNb/aGM7IqEh1Vtg
         QUX4ZZUY9rBfgcdSTHXCblc8Ntk3z8vfArI5vHpBxkmLtkULUEEEoUbjLhO+B6qY0r
         bKglX1Xecdfg4G+5q1yvmwoc6ST/FgwZ3EO9ibfOXXrWr+74w+s7vLPHMWRjWLrQPK
         YHTY6bZ7amWlw==
Date:   Sun, 13 Feb 2022 18:24:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Denis Ciocca <denis.ciocca@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iio: Silan SC7A20 accelerometer support
Message-ID: <20220213182407.5b2fd893@jic23-huawei>
In-Reply-To: <20220202235049.8051-1-samuel@sholland.org>
References: <20220202235049.8051-1-samuel@sholland.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  2 Feb 2022 17:50:45 -0600
Samuel Holland <samuel@sholland.org> wrote:

> This chip is register-compatible with an ST part, so it works without
> any issues when added to the existing driver.
> 
> Previously I called it a clone, but it's not really a clone, because
> it's not a drop-in replacement for the other chips. The software
> interface matches the ST parts, but the pinout does not. Instead, the
> pinout matches the Kionix KX122 and KX132.
Series applied to the togreg branch of iio.git and pushed out as testing
to see if 0-day can find anything we missed.

Thanks,

Jonathan

> 
> Changes in v2:
>  - Move the new compatible to its own section
>  - Add a comment about the WAI value
>  - Update commit messages
> 
> Samuel Holland (3):
>   dt-bindings: vendor-prefixes: Add silan vendor prefix
>   dt-bindings: iio: st: Add Silan SC7A20 accelerometer
>   iio: accel: st_accel: Add support for Silan SC7A20
> 
>  .../bindings/iio/st,st-sensors.yaml           |  3 +
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  drivers/iio/accel/st_accel.h                  |  2 +
>  drivers/iio/accel/st_accel_core.c             | 83 +++++++++++++++++++
>  drivers/iio/accel/st_accel_i2c.c              |  5 ++
>  5 files changed, 95 insertions(+)
> 

