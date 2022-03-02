Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177D74CB28C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 23:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiCBWt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 17:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiCBWtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:49:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDE1344F7;
        Wed,  2 Mar 2022 14:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WmAYDWU2c7b1bNLfUQavgmavW2UFLBIs8qRVaxDLL5k=; b=R3xAAgzI45bzOaF2ufeO6r05dx
        R1jMniigPsk2BfgTZM+4Jvsv4X8ujErg/V1p4MlJ+l1ZIvFOGdr8WXfHGQ1C4x+R/cghOmQZL5Qx0
        evXYzP8maZmK1Eu/R8V/1T2YEK73a+MxrXnh4tnHqBRuuOQfrDBi86KAN5ebmEIluNKTvBz/5wfEh
        6SPP+HcPEG2dBL59hPft9aNkImgHDIMihOseH0Jcus6AjT6o6H6e1V672ZESCEszRPyZyzAgc6nO7
        tOrNphs98XBh83kM4/lbN7S2uhXBfiemfWSKAFjvTVs/Wd39xmfJpin3wEAdj1956p+bSgd2W1Qgl
        t5A2Gltw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPXlg-004cgp-7e; Wed, 02 Mar 2022 22:48:24 +0000
Date:   Wed, 2 Mar 2022 14:48:24 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Miroslav Benes <mbenes@suse.cz>, Aaron Tomlin <atomlin@redhat.com>
Cc:     cgel.zte@gmail.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] module: avoid calling synchronize_rcu()
Message-ID: <Yh/0OMRkwuQu7dTr@bombadil.infradead.org>
References: <20220302011306.2054550-1-lv.ruyi@zte.com.cn>
 <alpine.LSU.2.21.2203021012250.5895@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2203021012250.5895@pobox.suse.cz>
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

On Wed, Mar 02, 2022 at 10:14:00AM +0100, Miroslav Benes wrote:
> Hi,
> 
> On Wed, 2 Mar 2022, cgel.zte@gmail.com wrote:
> 
> > From: Lv Ruyi (CGEL ZTE) <lv.ruyi@zte.com.cn>
> > 
> > Kfree_rcu() usually results in even simpler code than does 
> > synchronize_rcu() without synchronize_rcu()'s multi-millisecond
> > latency, so replace synchronize_rcu() with kfree_rcu().
> > 
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Signed-off-by: Lv Ruyi (CGEL ZTE) <lv.ruyi@zte.com.cn>
> > ---
> >  kernel/module.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/kernel/module.c b/kernel/module.c
> > index 6cea788fd965..767b5f9e5819 100644
> > --- a/kernel/module.c
> > +++ b/kernel/module.c
> > @@ -4138,8 +4138,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
> >   ddebug_cleanup:
> >  	ftrace_release_mod(mod);
> >  	dynamic_debug_remove(mod, info->debug);
> > -	synchronize_rcu();
> > -	kfree(mod->args);
> > +	kfree_rcu(mod->args);
> 
> this has been proposed already. synchronize_rcu() and kfree() here are not 
> really tied together. See the discussion at 
> https://lore.kernel.org/all/alpine.LSU.2.21.2111301132220.3922@pobox.suse.cz/T/#u

Aaron, can you add a nice comment here to explain this while at it?
Otherwise this will be lost tribal knowledge.

Lv Ruyi, please open source your Zeal Robot. Thanks!

  Luis
