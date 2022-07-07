Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3438E569EFB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbiGGKAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbiGGJ76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:59:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3775F4D4F1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 02:59:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF15BB82105
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 09:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6224FC341C8;
        Thu,  7 Jul 2022 09:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657187995;
        bh=xj4b84J6iQwSb0YrcTztClFB4lqBd5Lm39wQMglEjZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Drp+338pI4tZIt3gH+Q4w+fuWeD58Prq9h42U+whl7snegoWq+C/vUm3vfFdEm64R
         DowQY01yejWTbAbBiiwGUN9erxkUdzbRmgctKRW3R0CghoBLRlBgXvmSbytw/+JvDU
         xyGWhD3CyG2D8H7rEszBlB4iloCLhL6chIASm7WJSfrk7TopRgyN3a8GVYiNBrOl1I
         hm4/aIJSaM8cZ0P3Tkmj/spBAiHhOBntLp7qIfPx/tSLMOkVlvXSqg23C5323L0v2G
         HYqI34VZ7unLL0Qgixda6rUiOxAkvshshixq6cFq5doGdcjkvYOm8tvU45ZI42tzUO
         cFvBjqlcb3VjQ==
Received: by pali.im (Postfix)
        id 6EF007B1; Thu,  7 Jul 2022 11:59:52 +0200 (CEST)
Date:   Thu, 7 Jul 2022 11:59:52 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ben Hutchings <ben@decadent.org.uk>,
        Michael Ellerman <michael@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc: e500: Fix compilation with gcc e500 compiler
Message-ID: <20220707095952.4yxdagjju3gk3sj5@pali>
References: <20220524093939.30927-1-pali@kernel.org>
 <20220702094405.tp7eo4df7fjvn2ng@pali>
 <8D562851-304F-4153-9194-426CC22B7FF2@ellerman.id.au>
 <20220704103951.nm4m4kpgnus3ucqo@pali>
 <CAK8P3a2tdny8SA7jcqhUZT13iq1mYqjFueC-gnTUZA1JKCtfgg@mail.gmail.com>
 <20220704131358.fy3z7tjcmk2m6pfh@pali>
 <CAK8P3a2hfnt+tHiqHrHAVyagSm73LJe4OV8ig=CKFcycfk4Zag@mail.gmail.com>
 <20220704132904.irvs4xefu4esgw6c@pali>
 <CAK8P3a30ecxG-A0_YDSBJAaGjcXXVwSnc7z4k-nreO+0UfJJ3w@mail.gmail.com>
 <80e09b08-81cc-39e2-0fc4-f90d6250259c@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <80e09b08-81cc-39e2-0fc4-f90d6250259c@csgroup.eu>
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

On Thursday 07 July 2022 09:56:04 Christophe Leroy wrote:
> Le 04/07/2022 à 15:43, Arnd Bergmann a écrit :
> > On Mon, Jul 4, 2022 at 3:29 PM Pali Rohár <pali@kernel.org> wrote:
> >>
> >> And still what to do with 4bf4f42a2feb ("powerpc/kbuild: Set default
> >> generic machine type for 32-bit compile")? I'm somehow lost there...
> > 
> > As far as I can tell, that is not needed, as long as every configuration
> > sets a specific -mcpu= option, the only reason it was required is that
> > there were some configs that relied on the compiler default, which
> > ended up being -mcpu=power8 or similar.
> > 
> 
> 
> Is there any link between this discussion and the following patch 
> submitted 3,5 years ago ?
> 
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20181226141511.3ag7uf6rvdgzlmxt@decadent.org.uk/
> 
> Thanks
> Christophe

Seems that above patch tried to fix same issue. I did not know about it.
