Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4022A514DB5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 16:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377670AbiD2Ooj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 10:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377828AbiD2OoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 10:44:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E92D17CF;
        Fri, 29 Apr 2022 07:39:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0E7360EA4;
        Fri, 29 Apr 2022 14:39:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2501C385A4;
        Fri, 29 Apr 2022 14:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651243143;
        bh=WzdLqQWKXHDCAMZ0mTym8io9uxbMsfKZRJCJBhCUrlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1ywYonBW2Cbj3xbSCIi0AswGOSPc6jF+cA/afLEbiu5MbVTpkE/elnsnvu9s6Rhi5
         7uM48VftdpM71XQmxytwx/IEtmgJ0M5HLnx/fq/SyCHjDOIPPFzE8X/qS8xGfrvZLx
         bd7c6J6ZF7/jUwpQaXahIP54a1IOaSnB/fyX/ai0=
Date:   Fri, 29 Apr 2022 16:39:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>, Rich Felker <dalias@libc.org>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH v3] sh: avoid using IRQ0 on SH3/4
Message-ID: <Ymv4hO9ls7XZGlki@kroah.com>
References: <2584ba18-9653-9310-efc1-8b3b3e221eea@omp.ru>
 <11021433-66c0-3c56-42bd-207a5ae8d267@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11021433-66c0-3c56-42bd-207a5ae8d267@physik.fu-berlin.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 04:24:04PM +0200, John Paul Adrian Glaubitz wrote:
> Hi Sergey!
> 
> On 4/27/22 20:46, Sergey Shtylyov wrote:
> > Using IRQ0 by the platform devices is going to be disallowed soon (see [1])
> > and even now, when IRQ0 is about to be returned by platfrom_get_irq(), you
> > see a big warning.  The code supporting SH3/4 SoCs maps the IRQ #s starting
> > at 0 -- modify that code to start the IRQ #s from 16 instead.
> > 
> > The patch should mostly affect the AP-SH4A-3A/AP-SH4AD-0A boards as they
> > indeed use IRQ0 for the SMSC911x compatible Ethernet chip...
> 
> Maybe try getting it landed through Andrew Morton's tree?

I can take it if needed, why does sh patches go through Andrew's tree?
Is there no sh maintainer tree anymore?

thanks,

greg k-h
