Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0A65009FC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241845AbiDNJhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241295AbiDNJhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:37:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4C01A809;
        Thu, 14 Apr 2022 02:34:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12E2561B95;
        Thu, 14 Apr 2022 09:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B06C385A1;
        Thu, 14 Apr 2022 09:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649928891;
        bh=V0Du7oRyUyAoNsyD73VGs8c8uXavo0mgfxNJb0Ar+HQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g/BgrtHbJLQ4/pNzKYsvUe/UEZjUk04bl9vUd9zMgYHSfrw9yaSnDeEusmSIUkoPK
         6L2ANTrQUrByTUgOTRgSaFJfUJWWyQwoMunt05vx60Ud+8KjMh9QASr3zG/YNgr3Bt
         wtpKE3Qj43dAKUXUJxZ+NtU66H+6S+M3T5lw4HI+hgdPdFhFcIfL8u7HBYkKJ4G4iH
         q3kVeAgAZlcRuS7qsv7iI9eBp88cTSXb1gA7+Az5bfxMK8nYPOODF3a6Ih+rL818HW
         rbFF72ribsA2OIDOTTZmLR2teKzdYiNNE24KIyzzzE09lJTMyDKrY9K9BGQAb4t+O5
         ax36KmEmQPFag==
Date:   Thu, 14 Apr 2022 10:34:45 +0100
From:   Will Deacon <will@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: arm64/sm4 - Fix wrong dependency of NEON/CE
 implementation
Message-ID: <20220414093445.GA2006@willie-the-truck>
References: <20220411031313.35449-1-tianjia.zhang@linux.alibaba.com>
 <20220413102209.GB1229@willie-the-truck>
 <Yla4pSKW+6I5jIfS@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yla4pSKW+6I5jIfS@zx2c4.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 01:48:53PM +0200, Jason A. Donenfeld wrote:
> On Wed, Apr 13, 2022 at 11:22:09AM +0100, Will Deacon wrote:
> > On Mon, Apr 11, 2022 at 11:13:13AM +0800, Tianjia Zhang wrote:
> > > Commit d2825fa9365d ("crypto: sm3,sm4 - move into crypto directory")
> > > moved the sm4 library implementation from the lib/crypto directory to
> > > the crypto directory and configured the name as CRYPTO_SM4. The arm64
> > > SM4 NEON/CE implementation depends on this and needs to be modified
> > > uniformly.
> > 
> > d2825fa9365d doesn't appear in my tree -- is this something in linux-next?
> 
> This is in Herbert's tree for next:
> https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git/commit/?id=d2825fa9365d

Cheers, then I'll leave this fix for Herbert to pick up.

Will
