Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5291554AF8A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 13:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243517AbiFNLvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 07:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236054AbiFNLvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 07:51:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F8134652;
        Tue, 14 Jun 2022 04:51:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 958FD61323;
        Tue, 14 Jun 2022 11:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09FDC3411E;
        Tue, 14 Jun 2022 11:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655207469;
        bh=UxMFgBxh+tLcHM5HY/sBLNk+B5l+uHI+DjprsoQaKfQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C+DlCtMINgCiNNF9rNUlecR2G32rSU4NLuvtySoVFh/6oAgnIWe3ZYXBRTrOPeZWJ
         0Ltef+a3Kq4u2ku9YRwnyGpmNuhUD50TEUw/NyY33zdeUqgDZTlrH6+Ow6YEm+XpDK
         b0F/19JHx+p1eE9isQGl+y3KO3LQkx2vx06EY5HagcW9lRJEkxvV+KQThvIhdTeeLT
         e8z1Z7ih0Uq1ljJJsp9nfpk2KisfhzU3HJyRKW19tEsnj52/pTJ3KIyXjE0oLqUqEr
         EeiFJ/rapseiDbAJgTXGKt5NKQXWQxow+IXjSlsN+TIgVs9CxahEBnE65ff/DA6D5x
         fEqWQZ0nCadOQ==
Date:   Tue, 14 Jun 2022 13:00:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     <Claudiu.Beznea@microchip.com>
Cc:     <Eugen.Hristev@microchip.com>, <lars@metafoo.de>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <ludovic.desroches@atmel.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/16] iio: adc: at91-sama5d2_adc: simplify the code in
 at91_adc_read_info_raw()
Message-ID: <20220614130018.4b29345d@jic23-huawei>
In-Reply-To: <14fc4d7c-4ce7-e4ed-3e2e-400cbd16c071@microchip.com>
References: <20220609083213.1795019-1-claudiu.beznea@microchip.com>
        <20220609083213.1795019-8-claudiu.beznea@microchip.com>
        <20220611185403.3eaf9b65@jic23-huawei>
        <14fc4d7c-4ce7-e4ed-3e2e-400cbd16c071@microchip.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jun 2022 08:49:03 +0000
<Claudiu.Beznea@microchip.com> wrote:

> On 11.06.2022 20:54, Jonathan Cameron wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Thu, 9 Jun 2022 11:32:04 +0300
> > Claudiu Beznea <claudiu.beznea@microchip.com> wrote:
> >   
> >> Simplify a bit the code in at91_adc_read_info_raw() by reducing the
> >> number of lines of code.
> >>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>  
> > 
> > I'm not convinced this is worth while, but there are some lesser
> > steps visible in this patch that probably are.
> > 
> > Given your earlier reorg to move at01_adc_adjust_val_osr() under the locks,
> > you can now move the locks to the caller, thus not needing to handle them
> > separately in all the exit paths.  
> 
> OK, I'll give it a try. With this, would you prefer to still keep this patch?
> 
No. I don't think it will bring enough benefit for the loss of readability.
Having moved the locking, there will only be a few repeated lines.

Jonathan
