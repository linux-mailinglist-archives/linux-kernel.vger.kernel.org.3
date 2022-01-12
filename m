Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5235C48BD4D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 03:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348770AbiALCb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 21:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236532AbiALCbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 21:31:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83515C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 18:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MOYaQ1EuvvICdRpZWv8ls0GQ5uh2navu2zEsECgPbv8=; b=fUCJBNmb0ymNku+O1rqYJhQmNt
        vgWC+o7A+ISHBYKgD4zeshId/SowrqIKj9tDTCbRQdzvd8A2OQ/xQq9d3dHWnfMgPGg2cTs0uL3Vv
        V5kxBY/bCaWnV+S5R/mUNFVLrKIn9m2pIIAYr4j27k52UPEXNYRTWS3ojCYj8zZpA2CAcMjwrLIEI
        sdYeWXCa0jRf/Yzd9VfMvy2Kt3Y+uu1KvaMQXSEOLXRtn8MFybURYMb+0cd7ywX1No30eMf18YMPo
        MorSZDydK+TJHz36RSr/HHvX8ypQdoM1OuVeJLWUqCD4FOPbRrKwNLxZrk84bO/AmpyN1//wFWCzv
        zOYhtdMQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7TQW-000t0k-Vq; Wed, 12 Jan 2022 02:31:52 +0000
Date:   Tue, 11 Jan 2022 18:31:52 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: remove old CONFIG_FW_LOADER_MODULE test
Message-ID: <Yd49mAHPQ2crt4Wl@bombadil.infradead.org>
References: <20211230093932.2747587-1-gregkh@linuxfoundation.org>
 <YdcAOL6hCck2jqXq@kroah.com>
 <Yd3Twxj4FjYvBwuo@bombadil.infradead.org>
 <Yd3ZDNpOP6fMlfsp@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd3ZDNpOP6fMlfsp@zn.tnic>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 08:22:52PM +0100, Borislav Petkov wrote:
> On Tue, Jan 11, 2022 at 11:00:19AM -0800, Luis Chamberlain wrote:
> > Yeah I think this comes from the fact that modules get a respective
> > _MODULE define in the generated file
> > include/generated/autoconf.h 
> > 
> > For example:
> > 
> > vagrant@kdevops-dev /data/linux-next (git::20211203-umh-fix-exitcodes)$
> > grep CONFIG_CRC8 .config
> > CONFIG_CRC8=m
> > vagrant@kdevops-dev /data/linux-next (git::20211203-umh-fix-exitcodes)$
> > grep CONFIG_CRC8 include/generated/autoconf.h
> > #define CONFIG_CRC8_MODULE 1 
> > 
> > So I think the above was put in place to ask if its built-in or a
> > module.
> 
> Talk about magic:
> 
> $ grep FW_LOADER .config
> CONFIG_FW_LOADER=m
> $ grep FW_LOADER include/generated/autoconf.h 
> #define CONFIG_FW_LOADER_MODULE 1
> 
> It is probably even documented somewhere that the build generates
> CONFIG_%s_MODULE defines for testing in code...

Yeah, this is an opaque way to express this, I'll send a patch
replacement which I think which make this clearer.

  Luis
