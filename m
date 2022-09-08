Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4FF5B226B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiIHPfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiIHPfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:35:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AF9804B2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 08:35:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97C5F61BFE
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 15:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F05C433C1;
        Thu,  8 Sep 2022 15:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662651315;
        bh=1HH8dtHniEemIyqgAOVQ7bA85JJUJ7y9/44WJRBwSCQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jtuXUldpXq4AZ4gbzvBqJ+hUY8LnvKeFDn3wTlDvP0la8BqO1YRLKBeORZnIZrrEn
         FE/FbCvMREQD+mWPp2gf9mlDIkJKt+hB3Y8wdqZqUseL42cje7fqAcvZFxADT7z0om
         b+PY3woI5hLvo32l218UiRAa5U9Gr5sCJ4LAWQUzM1EveQX8YOhxkmWpoht+fnsfgc
         SlhVW/dONbhlgA5EPEg1laTajQe/ctgQNlW6yjrcufj73gj9S+BXnW2UDv8jCgNIrM
         M216TK7W3S5ZsU98BNrYM1m5hq6qH5vqIihxVQA7Pq+J7YQLLn3hW/eBN/zOtyVNi0
         Qq8zT2+i7ewmA==
Received: by pali.im (Postfix)
        id 104B47EF; Thu,  8 Sep 2022 17:35:12 +0200 (CEST)
Date:   Thu, 8 Sep 2022 17:35:11 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Ash Logan <ash@heyquark.com>,
        "paulus@samba.org" <paulus@samba.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "j.ne@posteo.net" <j.ne@posteo.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 11/12] powerpc: wiiu: don't enforce flat memory
Message-ID: <20220908153511.57ceunyusziqfcav@pali>
References: <20220302044406.63401-1-ash@heyquark.com>
 <20220302044406.63401-12-ash@heyquark.com>
 <20220513224353.n56qg5fhstbaqhfz@pali>
 <d84e4d24-f350-80fc-6c31-b7e7f8d429f4@heyquark.com>
 <20220520080454.c3cqodsdbfbkmg56@pali>
 <935b426a-6c64-beb0-907f-8c3f0a089ab7@heyquark.com>
 <20220520123002.rd46p5ty6wumi7cc@pali>
 <20220609222420.ponpoodiqmaqtwht@pali>
 <20220808184034.lskqrk6z3gb5q76r@pali>
 <219cda7b-da4b-7a5a-9809-0878e0fc02ba@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <219cda7b-da4b-7a5a-9809-0878e0fc02ba@csgroup.eu>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 September 2022 15:25:14 Christophe Leroy wrote:
> Le 08/08/2022 à 20:40, Pali Rohár a écrit :
> > On Friday 10 June 2022 00:24:20 Pali Rohár wrote:
> >> On Friday 20 May 2022 14:30:02 Pali Rohár wrote:
> >>> + linux-mm
> >>>
> >>> Do you know what are requirements for kernel to support non-contiguous
> >>> memory support and what is needed to enable it for 32-bit powerpc?
> >>
> >> Any hints?
> > 
> > PING?
> > 
> 
> The tree following patches landed in powerpc/next branch, so they should 
> soon be visible in linux-next too:
> 
> fc06755e2562 ("powerpc/32: Drop a stale comment about reservation of 
> gigantic pages")
> b0e0d68b1c52 ("powerpc/32: Allow fragmented physical memory")
> 0115953dcebe ("powerpc/32: Remove wii_memory_fixups()")

Ou, nice! I will try to test it if it allows me to access more than 2GB
of RAM from 4GB DDR3 module with 32-bit addressing mode on P2020 CPU.
