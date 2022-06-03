Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A65A53CE13
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 19:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344498AbiFCR3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 13:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344486AbiFCR3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:29:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0173E38DBD;
        Fri,  3 Jun 2022 10:29:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B1A2B823C9;
        Fri,  3 Jun 2022 17:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C01C385A9;
        Fri,  3 Jun 2022 17:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654277343;
        bh=9I/JzgnnhecK1A0NSKc0eP0dYZJolAgiz4yQ8AYt4Sg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YNMP77UouuYCdoLbBJHk3zL7lY6HHaor8vsQ0iFWPeUYfxrW94vjVIyI64vhYZPhm
         8hI7N4GtPaXEYYEod1cZn8aO7o7JnX4nJe2iK2TMBdpFGP/dWg/07KuY553CaggLwo
         jD0ijLF9RMa/aFkWIuY0OVoM56wsAzOae/A23UE92AvYWr+B/Tgb3bIg3pgcf/hsEt
         6y7JWgB5acZkWdKJfdV8Bo8ylnAsD7ukpqp+4CBDHedQUBljjTHPcFN0NfSmpPN2BL
         MgTqTAhC4PkJUri0oIw04lIa0+Dnq2C0GjOMw+H+WAfJSO6BmwViG4VtP7o09E2tvE
         6xPYMxe3QNedQ==
Date:   Fri, 3 Jun 2022 18:38:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomas Melin <tomas.melin@vaisala.com>
Cc:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>, lars@metafoo.de,
        robh+dt@kernel.org, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.haemmerle@leica-geosystems.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH V9 0/5] iio: accel: sca3300: add compatible for scl3300
Message-ID: <20220603183803.2d7b0c4f@jic23-huawei>
In-Reply-To: <ffdd68af-a6ec-5a10-f4b8-56678285861f@vaisala.com>
References: <20220529061853.3044893-1-Qing-wu.Li@leica-geosystems.com.cn>
        <ffdd68af-a6ec-5a10-f4b8-56678285861f@vaisala.com>
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

On Mon, 30 May 2022 12:58:59 +0300
Tomas Melin <tomas.melin@vaisala.com> wrote:

> On 29/05/2022 09:18, LI Qingwu wrote:
> > The current driver support sca3300 only, modified to support SCL3300.
> > Verified with SCL3300 on IMX8MM.
> > 
> > SCL3300 is a three-axis accelerometer sensor with angle output, 
> > the change adds the support of scl3300 and inclination data output.
> > 
> > 
> > Changes in v9: 
> >  - Rename angle to angle_supported.
> >  - Delete reg_val &= GENMASK(1, 0), it's redundant.
> >  - Fix typo of comments.
> > 
> > 
> > LI Qingwu (5):
> >   dt-bindings: iio: accel: sca3300: Document murata,scl3300
> >   iio: accel: sca3300: add define for temp channel for reuse.
> >   iio: accel: sca3300: modified to support multi chips
> >   iio: accel: sca3300: Add support for SCL3300
> >   iio: accel: sca3300: Add inclination channels
> > 
> >  .../bindings/iio/accel/murata,sca3300.yaml    |   1 +
> >  drivers/iio/accel/sca3300.c                   | 323 +++++++++++++++---
> >  2 files changed, 269 insertions(+), 55 deletions(-)
> >   
> 
> Reviewed-by: Tomas Melin <tomas.melin@vaisala.com>

Series applied to the togreg branch of iio.git and pushed out for now as
testing to let 0-day see if it can find anything we missed.

Thanks,

Jonathan
