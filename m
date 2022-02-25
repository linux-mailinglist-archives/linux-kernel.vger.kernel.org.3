Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8136F4C4BDF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243538AbiBYRR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243541AbiBYRRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:17:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EAB21D0AB;
        Fri, 25 Feb 2022 09:16:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5580161D7B;
        Fri, 25 Feb 2022 17:16:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0EA1C340E7;
        Fri, 25 Feb 2022 17:16:48 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="nFNHm3DJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645809407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q2wISHZch5FoXIRGg0Ido8HLXZIaFmbc/fNZyR/oiGo=;
        b=nFNHm3DJAZM9La/4dSDrNEFAbgBR8TRA3LgCTyy02tO3G4D6UQgdGPopzGYCrFZ5YyNgQv
        VytZ2GuXm7KXddwtPYc4LKfJN3k4RhzaC4wDYCTJI+tzujMEkTVwjU0JkU+VlTAwktfVls
        9ApNjGuyTePw2TWQz2LOkxloJX+UFOY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5be5d1f6 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 25 Feb 2022 17:16:46 +0000 (UTC)
Date:   Fri, 25 Feb 2022 18:16:43 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Alexander Graf <graf@amazon.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, ardb@kernel.org,
        dwmw@amazon.co.uk
Subject: Re: [PATCH] ACPI: bus: Match first 9 bytes of device IDs
Message-ID: <YhkO+wXED5IXlCMv@zx2c4.com>
References: <20220225155552.30636-1-graf@amazon.com>
 <YhkKc2fa8dSTA9pc@zx2c4.com>
 <7a98e9c5-e0e5-9bf9-71b5-f75b9ddcdc4b@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7a98e9c5-e0e5-9bf9-71b5-f75b9ddcdc4b@amazon.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Fri, Feb 25, 2022 at 06:09:59PM +0100, Alexander Graf wrote:
> You have to make this "VM_GEN_CO". I now match the full 9 bytes - unlike 
> the previous patch I sent :)

Ahh, so no NULL byte, but presumably no need because strncmp is used.
Great, seems to work.

There's the other aspect of udev matching, by the way. Have you tested
what happens in userspace? Need be, we could make the vmgenid driver a
bool instead of a tristate, but maybe there's a way to do that right?

Jason
