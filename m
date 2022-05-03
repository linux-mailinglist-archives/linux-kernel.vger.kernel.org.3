Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9CA518F77
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241991AbiECU5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236953AbiECU5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:57:34 -0400
Received: from mailrelay4-1.pub.mailoutpod1-cph3.one.com (mailrelay4-1.pub.mailoutpod1-cph3.one.com [46.30.210.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D5533A3B
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 13:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=vWFF6VGjD4uKJEIXD4qhyxLIgBRXSjglad3oRA7XxNM=;
        b=e8xdyj4Pjc/xbIQ0jd1XLsTmI1SxBeFC6zysAQkQQyGwmQgRcYC1fGfgOhFS/cWZh5FSZbARm6iaW
         Rr4R6ZaMyZzhFTUmwhi5Ojte9JYY8DjtW2hwxnV/O3bQ9W5edKdz8k9asJtuctHijyfEetGB4MNJyA
         na7c8LnkIfcLi864fW7nkz7sLSPnAeBYl+xcJ1DOg67SOwWnP9S1efNq14k2E3678RLII6J/+DxEOd
         G9TxhzEu9xZKC2ck+epBZlKZnMKN15N5id5ghn++DnnTALcXJ+y03Z605WQ5bjaQDkJuZEF+epxNOz
         Ch69eiAtS+TSC3c0z4PI2aHq9whY1pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=vWFF6VGjD4uKJEIXD4qhyxLIgBRXSjglad3oRA7XxNM=;
        b=5KUFBF8tLRwJaNS5dUr0ofjHsCmMwJsIBey39OnQe/9UL1PeaZRy5U+WWa/zjEyhB8gsGFvPsO+VB
         m42kiymCw==
X-HalOne-Cookie: 3ad8b22d728e1f30d497971a1001bc6e70176112
X-HalOne-ID: 2655276f-cb23-11ec-8229-d0431ea8bb10
Received: from mailproxy4.cst.dirpod3-cph3.one.com (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 2655276f-cb23-11ec-8229-d0431ea8bb10;
        Tue, 03 May 2022 20:53:57 +0000 (UTC)
Date:   Tue, 3 May 2022 22:53:55 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Junxiao Chang <junxiao.chang@intel.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2] fbdev: Use helper to get fb_info in all file
 operations
Message-ID: <YnGWY/01XSMq3Jfk@ravnborg.org>
References: <20220503201934.681276-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503201934.681276-1-javierm@redhat.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 10:19:34PM +0200, Javier Martinez Canillas wrote:
> A reference to the framebuffer device struct fb_info is stored in the file
> private data, but this reference could no longer be valid and must not be
> accessed directly. Instead, the file_fb_info() accessor function must be
> used since it does sanity checking to make sure that the fb_info is valid.
> 
> This can happen for example if the registered framebuffer device is for a
> driver that just uses a framebuffer provided by the system firmware. In
> that case, the fbdev core would unregister the framebuffer device when a
> real video driver is probed and ask to remove conflicting framebuffers.
> 
> Most fbdev file operations already use the helper to get the fb_info but
> get_fb_unmapped_area() and fb_deferred_io_fsync() don't. Fix those two.
> 
> Since fb_deferred_io_fsync() is not in fbmem.o, the helper has to be
> exported. Rename it and add a fb_ prefix to denote that is public now.
> 
> Reported-by: Junxiao Chang <junxiao.chang@intel.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
