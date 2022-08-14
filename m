Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0874E592021
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 16:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239622AbiHNOY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 10:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239569AbiHNOYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 10:24:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910D21054E;
        Sun, 14 Aug 2022 07:24:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F1AA60B3D;
        Sun, 14 Aug 2022 14:24:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2405C433D6;
        Sun, 14 Aug 2022 14:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660487059;
        bh=Oo73bKMI+TAP6jxlC5fKRQHZbZFrgO3piXgBXIu7pq0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZICwZ0OLcKCRJCa0PZVrQ4GAhAjvJ92npRzs90CeIHAyXWmGFullFgevtHBK1QAhU
         POFiwO9l6BOvzgQ1SDAxgn30v/4xb6D6/CrM0PVy7C+T3tZhymcqXu211bbvD6Or/F
         6QWyJCfpZsQnZNayuh8BmTyYEpS1a5tSCQ1O4XQFwrBApSHkFBWATqtp/Op7TYB7o9
         6hGmr61KJIolkZ0R1caDLUfATNB6xwigk9HWJREqzcK4I0UUg5crTt2TkrWMAg3BS2
         eJ7DHoVKqV3M6XwhuRjCi5maUiiXDW55P2857oOI8bIcdhrvc8Q24w1BU84ya42Jci
         81vxj0rpUBosw==
Date:   Sun, 14 Aug 2022 15:34:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/9] Improve MCP3911 driver
Message-ID: <20220814153447.2e9b512a@jic23-huawei>
In-Reply-To: <20220809073648.167821-1-marcus.folkesson@gmail.com>
References: <20220809073648.167821-1-marcus.folkesson@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Tue,  9 Aug 2022 09:36:39 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> Hi,
> 
> This patch series intend to fix bugs and improve functionality of the MCP3911 driver.
> The main features added are
> - Support for buffers
> - Interrupt driven readings
> - Support for oversampling ratio
> - Support for set scale values (Gain)
> 
> Among the bug fixes, there are changes in the formula for calculate raw value and a fix for mismatch in the devicetree property.
> 
> Another general improvement for the driver is to use managed resources for all allocated resources.
> 
Given requested changes from Andy and I were all small, I would normally
have just made them whilst applying.  However, patches 1-3 still need
to work their way through as fixes to be upstream so we can't merge the
rest yet anyway.

Looks good to me in general, just those little things to tidy up in a v6.

Thanks,

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
> 	select IIO_BUFFER
> 	select IIO_TRIGGERED_BUFFER
>     To Kconfig
> - Add .endianness = IIO_BE
> 
> v5:
> - Drop remove function
> - Split tx&rx transfers in mcp3911_trigger_handler()
> - Moved Kconfig changes to right patch
> 
> 
> Best regards,
> Marcus Folkesson
> 
> 

