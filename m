Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863DA59B9B0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbiHVGkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbiHVGkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:40:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2019D167E7
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 23:40:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0F0560F9E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 06:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D1BC433D6;
        Mon, 22 Aug 2022 06:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661150444;
        bh=1vA4LOeYUtlGGv+ga5N0aMSRXGkgcXHijyOH7UzS+EI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YeePvfB3hQF+BEjvSqNFt8uuiEp1yZSkVCUzuheGS0ktGURaQ+muWXN8eeN2nTy9W
         9Umnv/VKvIuAq0vSuA2+4TLq9JMXH218ksj1Td8FFDv/IIt0KWvPkr+BDA5Y+NTt0Z
         gLYwRfvv1C0b8enugCOO8ORsbodhdsPX16Gd7o1Sz7rK4a4224dJg05nicP7nR64GW
         Wbx+i9YsnuDmrFU+GTFuKWvzwrEM+LURz61i3sXGDr210YQtzDc25dNfCLJWr8+HUi
         z4bulQU/K0z4E3aEDgrlJBVYPItuuPn0KZ0ZwfzIvJQ6YnnZ5cvpJ013luYWfpGWku
         wCvRazRwql/1Q==
Date:   Mon, 22 Aug 2022 06:40:40 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Rustam Subkhankulov <subkhankulov@ispras.ru>
Cc:     Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] platform/chrome: fix double-free in
 chromeos_laptop_prepare()
Message-ID: <YwMk6ESKt7fTEZuK@google.com>
References: <20220813220843.2373004-1-subkhankulov@ispras.ru>
 <YvnS7IKr/9VhffHX@google.com>
 <7d4dd8009a777a7d32f4872dc0285878dbbb91b8.camel@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d4dd8009a777a7d32f4872dc0285878dbbb91b8.camel@ispras.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 20, 2022 at 08:05:13PM +0300, Rustam Subkhankulov wrote:
> On Mon, 2022-08-15 at 05:00 +0000, Tzung-Bi Shih wrote:
> > Alternatively, I would prefer to fix the double-free by setting
> > `i2c_peripherals` to NULL after [1].
> 
> Since 'cros_laptop->num_i2c_peripherals' is assigned with nonzero value
> (otherwise the code on 'err_out' is not executed), setting 
> 'i2c_peripherals' to NULL after [1] will cause dereferencing of 
> NULL pointer in chromeos_laptop_destroy() at [2]. 
> 
> [1]:
> https://elixir.bootlin.com/linux/v5.19/source/drivers/platform/chrome/chromeos_laptop.c#L787
> [2]:
> https://elixir.bootlin.com/linux/v5.19/source/drivers/platform/chrome/chromeos_laptop.c#L860
> 
> > After a quick glance, I found an invalid memory access at [2] if
> > `i2c_peripherals` is NULL (see [3]). 
> 
> After applying the patch, there will be no invalid memory access at [2]
> if 'i2c_peripherals' is NULL, because in this situation 
> 'cros_laptop->num_i2c_peripherals' is zero and there is no single 
> iteration of the loop.

Thanks, I see.  I overlooked the `num_i2c_peripherals`.
