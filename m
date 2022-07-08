Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6937D56C0AD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238271AbiGHRMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 13:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238493AbiGHRMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 13:12:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12DC2CCB7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 10:12:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59FBD6237B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 17:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C652C341C0;
        Fri,  8 Jul 2022 17:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657300350;
        bh=v8cAq7/Gzi8ptaUAj35finBpJ4sd0O5IcACMWgZqGEw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ThWQzWOPM3uHWo0maxJeaD2y/kfNNAPVJMfEeQ/6+K+oAOIp6ojjrL7zX1HTXWAv9
         mWcrcxpwhBKw0CZa5Br7ILK2RqMhRdn6w/o6NDXFemTI1sj9E3wQFuawE+hdCl8Uzf
         UASo2gu7jj9G654QCamb31v5pXoI40ic2DWPMbWR1iFJ9tBWTZz+OWp9/WUeQZ6vTT
         rBz2rqWMMnMT/4Mh8qpppuzMW77d7Axyff1EBTIrgOMvwLssu1WDEkCGQcGyUIlDLs
         cuWBm4M3Jp7XwLvFVhTPR+yE+l93VtWXFNP/QlKO0wIyCBSFqIH24xNPVZhShBVUO3
         gwXqL2QRGLUGg==
Received: by pali.im (Postfix)
        id 62F297D1; Fri,  8 Jul 2022 19:12:27 +0200 (CEST)
Date:   Fri, 8 Jul 2022 19:12:27 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Michael Ellerman <michael@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc: e500: Fix compilation with gcc e500 compiler
Message-ID: <20220708171227.74nbcgsk63y4bdna@pali>
References: <20220524093939.30927-1-pali@kernel.org>
 <20220702094405.tp7eo4df7fjvn2ng@pali>
 <8D562851-304F-4153-9194-426CC22B7FF2@ellerman.id.au>
 <20220704103951.nm4m4kpgnus3ucqo@pali>
 <CAK8P3a2tdny8SA7jcqhUZT13iq1mYqjFueC-gnTUZA1JKCtfgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2tdny8SA7jcqhUZT13iq1mYqjFueC-gnTUZA1JKCtfgg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 July 2022 14:07:10 Arnd Bergmann wrote:
> Another problem I see is that a kernel that is built for both E500 and E500MC
> uses -mcpu=e500mc and may not actually work on the older ones either
> (even with your patch).

Such configuration is not supported, see arch/powerpc/platforms/Kconfig.cputype:

config PPC_E500MC
	bool "e500mc Support"
	select PPC_FPU
	select COMMON_CLK
	depends on E500
	help
	  This must be enabled for running on e500mc (and derivatives
	  such as e5500/e6500), and must be disabled for running on
	  e500v1 or e500v2.

Based on this option you can enable either support for e500v1/e500v2 or
for e500mc. But not both.
