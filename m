Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7D448B74C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 20:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbiAKTWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 14:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiAKTWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:22:54 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993E6C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 11:22:54 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A24F61EC01B5;
        Tue, 11 Jan 2022 20:22:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1641928967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=W+1MqJDYCvC9MyBhfZw19OAYb1vL9THRUDtjVpG2xW0=;
        b=A4orzNlRl+LHvlVe4OujKQmwIWtSbik9V0AaxdF69OSInqmH7TxLKskuCVPt+A8/8OoUea
        hNBWad0DqhjsHMWZaB8dNzYdjmzz1g67svo522T8XYYGEF8Iwk6deSnp0Sg+/HQig4Qku9
        KdL1ZMyyG/m5wCUIBk6i9ZNt4XkrWz0=
Date:   Tue, 11 Jan 2022 20:22:52 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: remove old CONFIG_FW_LOADER_MODULE test
Message-ID: <Yd3ZDNpOP6fMlfsp@zn.tnic>
References: <20211230093932.2747587-1-gregkh@linuxfoundation.org>
 <YdcAOL6hCck2jqXq@kroah.com>
 <Yd3Twxj4FjYvBwuo@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yd3Twxj4FjYvBwuo@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 11:00:19AM -0800, Luis Chamberlain wrote:
> Yeah I think this comes from the fact that modules get a respective
> _MODULE define in the generated file
> include/generated/autoconf.h 
> 
> For example:
> 
> vagrant@kdevops-dev /data/linux-next (git::20211203-umh-fix-exitcodes)$
> grep CONFIG_CRC8 .config
> CONFIG_CRC8=m
> vagrant@kdevops-dev /data/linux-next (git::20211203-umh-fix-exitcodes)$
> grep CONFIG_CRC8 include/generated/autoconf.h
> #define CONFIG_CRC8_MODULE 1 
> 
> So I think the above was put in place to ask if its built-in or a
> module.

Talk about magic:

$ grep FW_LOADER .config
CONFIG_FW_LOADER=m
$ grep FW_LOADER include/generated/autoconf.h 
#define CONFIG_FW_LOADER_MODULE 1

It is probably even documented somewhere that the build generates
CONFIG_%s_MODULE defines for testing in code...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
