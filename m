Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E58589DE8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 16:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240081AbiHDOwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 10:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240062AbiHDOwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 10:52:10 -0400
X-Greylist: delayed 497 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 04 Aug 2022 07:52:07 PDT
Received: from mail.crfreenet.org (varda.crfreenet.org [185.133.240.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F329F2A25D;
        Thu,  4 Aug 2022 07:52:07 -0700 (PDT)
Received: from finarfin (slizka.chapadla.cz [93.99.228.74])
        by mail.crfreenet.org (Postfix) with ESMTP id 9C74B2C230E;
        Thu,  4 Aug 2022 16:43:47 +0200 (CEST)
Date:   Thu, 4 Aug 2022 16:43:47 +0200
From:   Ondrej Zajicek <santiago@crfreenet.org>
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     deller@gmx.de, adaplas@gmail.com, akpm@linux-foundation.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix bugs in *_set_par() caused by user input
Message-ID: <YuvbI8NEpzciTgfc@finarfin>
References: <20220804124125.3506755-1-zheyuma97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804124125.3506755-1-zheyuma97@gmail.com>
X-Operating-System: Debian GNU/Linux
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 08:41:22PM +0800, Zheyu Ma wrote:
> In the function *_set_par(), the value of 'screen_size' is
> calculated by the user input. If the user provides the improper value,
> the value of 'screen_size' may larger than 'info->screen_size', which
> may cause a bug in the memset_io().

Hi

I did not saw fbdev code in years, but should not this be already checked
by *_check_var() ?

arkfb_check_var():

	...
	/* Check whether have enough memory */
	mem = ((var->bits_per_pixel * var->xres_virtual) >> 3) * var->yres_virtual;
	if (mem > info->screen_size)
	...

-- 
Elen sila lumenn' omentielvo

Ondrej 'Santiago' Zajicek (email: santiago@crfreenet.org)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."
