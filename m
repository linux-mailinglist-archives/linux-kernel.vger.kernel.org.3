Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE9558B5CB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 15:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiHFN6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 09:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiHFN6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 09:58:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FB410FC3;
        Sat,  6 Aug 2022 06:58:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 838F6B8068F;
        Sat,  6 Aug 2022 13:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99664C433D6;
        Sat,  6 Aug 2022 13:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659794289;
        bh=CLAku9OxZB+wAiKP6hS1ulXo84boQr4PJwDDM0jjDZ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bTkxT/hRoxSSXIMfNZP0dO4FMnWfvPegCIB0yD0g+iuYTl9WgGUPYM4y/1rq73nal
         xKmiL5YrvnjgzEcZl0u4OIIOLXvGQ9wPqlAmL/ajj/WeSAEtTp23NWUDtavAkyVOMZ
         BQAYqNh+Oe3RIbe7AEqEbU0XYJ4rUU2TNX3brcPhs0aILXVlgDWmburvX47HcqIhI7
         7h2FCkJAx+QZaFOSAJZHZUTUQUQ38mYbWPYYUvqC/0V7RJ+wgb1h7ItLQSCuSLDc2Q
         xjNv/fIAIGlLFbJs8iLUiOMVhCOVwcfZE/BkshEQDDcUv17i2gcT3r2F86QfUL4uKb
         3VDk+hCloYKpw==
Date:   Sat, 6 Aug 2022 15:08:27 +0100
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
Message-ID: <20220806150827.1b28db62@jic23-huawei>
In-Reply-To: <YueEg0tmKpc4kdLO@gmail.com>
References: <20220722130726.7627-1-marcus.folkesson@gmail.com>
        <20220731174112.072345e3@jic23-huawei>
        <YueEg0tmKpc4kdLO@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Aug 2022 09:45:07 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> On Sun, Jul 31, 2022 at 05:41:12PM +0100, Jonathan Cameron wrote:
> > On Fri, 22 Jul 2022 15:07:17 +0200
> > Marcus Folkesson <marcus.folkesson@gmail.com> wrote:
> >   
> > > Hi,
> > > 
> > > This patch series intend to fix bugs and improve functionality of the
> > > MCP3911 driver.
> > > The main features added are
> > > - Support for buffers
> > > - Interrupt driven readings
> > > - Support for oversampling ratio
> > > - Support for set scale values (Gain)
> > > 
> > > Among the bug fixes, there are changes in the formula for calculate raw
> > > value and a fix for mismatch in the devicetree property.
> > > 
> > > Another general improvement for the driver is to use managed resources
> > > for all allocated resources.
> > >   
> > Hi Marcus,
> > 
> > The first 3 fixes look good to me.  Do you want me to pick those up to
> > go in after rc1 via my togreg-fixes branch?  The side effect of doing
> > that is it'll be a little while before they are upstream in the branch
> > I'll want to pick the rest of the series on top of.
> > 
> > So it's a trade off between getting fixes in as soon as possible and
> > slowing down other improvements a little.  
> 
> Both ways works for me.
> I guess it is preferable to get the fixes in as soon as possible?
> 
> If so, do you want me to rebase the series on your togreg-fixes branch
> or wait to send v5 until the patches are upstream?
> 
> Or simply keep sending the whole series?

For now resend the whole series. I don't want to pick anything up onto the fixes-togreg
branch until rc1 (as good time to get it to a more recent base).  So I'll sit on these
for another week anyway.

Thanks,


Jonathan

> 
> Thanks,
> Marcus Folkesson
> 
> > 
> > Jonathan
> >   

