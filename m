Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4598D51AFAB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378335AbiEDUvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238964AbiEDUvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:51:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3214CD6B;
        Wed,  4 May 2022 13:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tk/LcmTUWVNG5nEkY4lVQG/gc3RdSayOBZ2TCUpRTL8=; b=ApD8MbjkZZSobqnBvKcHlUia9o
        64LTt/muWOs9fuZ8dgS6Zq87PKcSinTn9vAPJVFLCBUnV8r9D7Jnc+Ls9m1RPMN7MDb++qmzAskKl
        OjokttisTwYsdjkczTiHjekklL5GALJjszQ8QU/Z9T8M0CS00NnpHwn/auiCYPlXgWqV6feMY5x9g
        fuYyO8Gq12yxCW26katNTm+nfx18LX+vxbJXWEzzTpxQC+3mMi0sD/7hM8GPGS3pxA5JPKW3E6j34
        q9itG1vF8V0DCROTBs54WXCM6OHWLSvn+ORK+dtUV5zhZpg3jxxoNIs5Ab8LMMZZwsOpEYwjOzb+0
        hgqAPa/g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmLut-00CfkG-Q2; Wed, 04 May 2022 20:48:11 +0000
Date:   Wed, 4 May 2022 13:48:11 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-modules@vger.kernel.org, linux-mediatek@lists.infradead.org,
        yj.chiang@mediatek.com, atomlin@redhat.com
Subject: Re: [RESEND PATCH] module: show disallowed symbol name for
 inherit_taint()
Message-ID: <YnLmi26EBEFJM5aH@bombadil.infradead.org>
References: <20220427073606.29752-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427073606.29752-1-lecopzer.chen@mediatek.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 03:36:06PM +0800, Lecopzer Chen wrote:
> The error log for inherit_taint() doesn't really help to find the
> symbol which violates GPL rules.
> 
> For example,
> if a module has 300 symbol and includes 50 disallowed symbols,
> the log only shows the content below and we have no idea what symbol is.
>     AAA: module using GPL-only symbols uses symbols from proprietary module BBB.
> 
> It's hard for user who doesn't really know how the symbol was parsing.
> 
> This patch add symbol name to tell the offending symbols explicitly.
>     AAA: module using GPL-only symbols uses symbols SSS from proprietary module BBB.
> 
> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>

Thanks, pushed onto modules-testing. If there are no issues I'll
eventually push this onto modules-next.

  Luis
