Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C0351FF31
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 16:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236746AbiEIOOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 10:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236692AbiEIOOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:14:04 -0400
X-Greylist: delayed 460 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 May 2022 07:10:08 PDT
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0145D2B165A;
        Mon,  9 May 2022 07:10:08 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4KxjXd4Q4kz9sSm;
        Mon,  9 May 2022 16:02:09 +0200 (CEST)
From:   public@timruffing.de
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, public@timruffing.de
Subject: Re: [PATCH v2] Revert "fbdev: Make fb_release() return -ENODEV if fbdev was unregistered"
Date:   Mon,  9 May 2022 16:01:49 +0200
Message-Id: <20220509140149.34734-1-public@timruffing.de>
In-Reply-To: <642f515e-aa71-7c90-a715-e49dcf12baee@redhat.com>
References: <642f515e-aa71-7c90-a715-e49dcf12baee@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for this patch. Do you think this can be backported to LTS 5.17.y and
5.15.y, which are still buggy? It's not a big deal for me but others might
profit.

Background:
The patch solves a regression from 5.17.1 to 5.17.2 or 5.15.32 and
5.15.33 I was about to report. On my Thinkpad T570, I got random "BUG", "Oops"
or even panics when during booting with efifb and plymouthd (and then sometimes
also problems when shutting down because). I had bisected the issue to commit
27599aacbaef. I could provide more info but I don't think it's necessary given
that either aafa025c76dcc7d1a8c8f0bdefcbe4eb480b2f6a or your better patch now
fixes the issue (I tested both, both work for me).

Best,
Tim Ruffing

