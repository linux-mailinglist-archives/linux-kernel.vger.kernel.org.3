Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EA8545CE6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 09:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346455AbiFJHKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 03:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245205AbiFJHKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:10:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3BE32389B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 00:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95315B831EE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 07:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CB8C34114;
        Fri, 10 Jun 2022 07:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654845015;
        bh=1jF8gOkC5M5t8KtZ2Se+Cle7+3XpHMvrmN0dAG10DtM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kp1832CJeRB1cCRc9vhuUq7VMGWZNNoGoOnvd8/Ct5zebCAGy27nmtP2PSTuli1pD
         MSZUuGHPwwARQdvFal0UMwx2LZtyNI3K54RAsnQ4c9EMqEpTujvLRuPpx2m/UU6tye
         emtH+t1nftg8I2hJ4mpDgN6uEGNTd15OPn+8cfSM=
Date:   Fri, 10 Jun 2022 09:10:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jerry Lin <wahahab11@gmail.com>, Helge Deller <deller@gmx.de>,
        Jens Frederich <jfrederich@gmail.com>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: olpc_dcon: mark driver as broken
Message-ID: <YqLuVMVQc5qm5ld7@kroah.com>
References: <20220609223424.907174-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609223424.907174-1-javierm@redhat.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 12:34:24AM +0200, Javier Martinez Canillas wrote:
> The commit eecb3e4e5d9d ("staging: olpc_dcon: add OLPC display controller
> (DCON) support") added this driver in 2010, and has been in staging since
> then. It was marked as broken at some point because it didn't even build
> but that got removed once the build issues were addressed.
> 
> But it seems that the work to move this driver out of staging has stalled,
> the last non-trivial change to fix one of the items mentioned in its todo
> file was commit e40219d5e4b2 ("staging: olpc_dcon: allow simultaneous XO-1
> and XO-1.5 support") in 2019.
> 
> And even if work to destage the driver is resumed, the fbdev subsystem has
> been deprecated for a long time and instead it should be ported to DRM.
> 
> Now this driver is preventing to land a kernel wide change, that makes the
> num_registered_fb symbol to be private to the fbmem.c file.
> 
> So let's just mark the driver as broken. Someone can then work on making
> it not depend on the num_registered_fb symbol, allowing to drop the broken
> dependency again.

Thanks for doing this, will go queue it up now for 5.19-final.

greg k-h
