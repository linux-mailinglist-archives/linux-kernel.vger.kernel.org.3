Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4986592018
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 16:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239739AbiHNOQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 10:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiHNOQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 10:16:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CADEDEB0;
        Sun, 14 Aug 2022 07:16:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2556A60010;
        Sun, 14 Aug 2022 14:16:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C820FC433C1;
        Sun, 14 Aug 2022 14:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660486611;
        bh=uWoAq0ATnsOAbG/v53oGm0JhCatO2L0aeQdPfeB4Xq4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iSkd0AHEsGvTF3NAwh5S7pfgNAE0lLcMvw6t0e2OsTxnEJ+izG/hfM9whbO4dOxvZ
         tXRvMOQBCwFiUUIh6fNxUpl6VA4F9//fEuWOzW8k/bKb3RpgC1wft1QHsVaC+acxUg
         KJgP8evn/SXnJsWo0uDsvVjkzMe5MeoWayLRIY8JQFvtWn06dm+APxYLo8u7nHVXuE
         3c1YRsHcOwRHP1ajdDLpigYcJ5aqVnhCnkWJhdG2aOvV5FItYGRe7r6J2ALDfEaUlh
         ta+gDC9PbF0NNoRzvapJ5Ox7YTdx0T262PsUzBbG4KntrBzMaejBcvsb2SAE+F6Oz2
         OvVEKZ1XLRFEA==
Date:   Sun, 14 Aug 2022 15:27:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/9] iio: adc: mcp3911: use resource-managed version
 of iio_device_register
Message-ID: <20220814152719.17597442@jic23-huawei>
In-Reply-To: <CAHp75VdhdpKasyYrb1tkhL6yjfZwMcbWJYNc9bw8LDr7KLT6jw@mail.gmail.com>
References: <20220809073648.167821-1-marcus.folkesson@gmail.com>
        <20220809073648.167821-5-marcus.folkesson@gmail.com>
        <CAHp75Vc-cd_-+qyd62tcJGdXh917AgZY5VB0ztXR3zwrGoMCRQ@mail.gmail.com>
        <CAHp75VdhdpKasyYrb1tkhL6yjfZwMcbWJYNc9bw8LDr7KLT6jw@mail.gmail.com>
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

On Tue, 9 Aug 2022 11:40:55 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Aug 9, 2022 at 11:39 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> 
> ...
> 
> > You may rather switch to devm_clk_get_enabled() and drop this.  
> 
> While doing this I would recommend to split the regulator case and clock case.
> 
Hi Andy,

I read this and wasn't quite sure what you meant.  Do you mean splitting
it into multiple patches?  

If so I think that is probably taking "one thing one patch" a step too far.
I wouldn't object it if were presented as separate patches, but I'm not
sure I'd bother splitting them.

Definitely good to switch to devm_clk_get_enabled() now that's available.
There is another go at adding devm_regulator_enable() under review at the
moment, but we can tidy that up as a follow on patch (along with the 100s of
other cases in IIO!)

Jonathan
