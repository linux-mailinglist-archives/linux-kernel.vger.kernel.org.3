Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C19B4D0F28
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 06:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243550AbiCHF0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 00:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237923AbiCHF0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 00:26:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC7A3B56E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 21:25:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDEDF61578
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 05:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2072FC340EB;
        Tue,  8 Mar 2022 05:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646717122;
        bh=KXzmZyEZ7u0umWi8Wmg3jgarR7t2v/kSfkqx99RMKdI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FsfiOkbQenTIwm/kRsex+SaJWDpa0M8Feo4v2jegV82BN3EY1FYyXXx2bze8656cE
         OQwuR3fybLuA8nx5TfxF6ZNofhV9WSMMjHi7jBiBXSpSywjM/Nh7n+HPQOebm+olt9
         JEMCjfCYrgzPuDMVfpHG5GrzODzPCmDVeSLdOs/mCZPhnUC/heLZ6lNZh26Lz8TNjZ
         Q+GBJZ019Oqf9lzwidQ9N7H6NQZaKLe+rfWuWEB+ipEJy6NCDIBEVZXd73klH6g7qZ
         q1OSf0flPtR+yquptlzP+FO6roORBlokRkjUICkpgFYIVDt81S+6St9fxBxYTqaEn1
         GikOeoW+3uwLA==
Date:   Mon, 7 Mar 2022 21:25:20 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     "dust.li" <dust.li@linux.alibaba.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [saeed:net-next 154/185] net/smc/smc_sysctl.h:23:16: warning:
 no previous prototype for 'smc_sysctl_net_init'
Message-ID: <20220307212520.176fce24@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20220308051655.GF35207@linux.alibaba.com>
References: <202203081012.KgONXWsS-lkp@intel.com>
        <20220308051655.GF35207@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2022 13:16:55 +0800 dust.li wrote:
> >vim +/smc_sysctl_net_init +23 net/smc/smc_sysctl.h
> >
> >    22	  
> >  > 23	int __net_init smc_sysctl_net_init(struct net *net)  
> >    24	{
> >    25		net->smc.sysctl_autocorking_size = SMC_AUTOCORKING_DEFAULT_SIZE;
> >    26		return 0;
> >    27	}
> >    28	  
> >  > 29	void __net_exit smc_sysctl_net_exit(struct net *net) { }  
> >    30	  
> 
> Hi Jakub:
> 
> Sorry to bother again on this !
> Looks like we still need to add 'static inline' or add an extra
> declaration for these 2 functions if we want to get rid of these warnings.
> What do you think ?

Sorry my comment was pretty unclear an unnecessary.

I meant that you don't need the __net_init annotation, it still 
needs to be a static inline. So this is what I meant:

diff --git a/net/smc/smc_sysctl.h b/net/smc/smc_sysctl.h
index 1d554300604d..0becc11bd2f4 100644
--- a/net/smc/smc_sysctl.h
+++ b/net/smc/smc_sysctl.h
@@ -20,13 +20,13 @@ void __net_exit smc_sysctl_net_exit(struct net *net);
 
 #else
 
-int __net_init smc_sysctl_net_init(struct net *net)
+static inline int smc_sysctl_net_init(struct net *net)
 {
        net->smc.sysctl_autocorking_size = SMC_AUTOCORKING_DEFAULT_SIZE;
        return 0;
 }
 
-void __net_exit smc_sysctl_net_exit(struct net *net) { }
+static inline void smc_sysctl_net_exit(struct net *net) { }
 
 #endif /* CONFIG_SYSCTL */



But really it does not matter if the __net_init / exit is there, 
so this works too:

diff --git a/net/smc/smc_sysctl.h b/net/smc/smc_sysctl.h
index 1d554300604d..6979e7173669 100644
--- a/net/smc/smc_sysctl.h
+++ b/net/smc/smc_sysctl.h
@@ -20,13 +20,13 @@ void __net_exit smc_sysctl_net_exit(struct net *net);
 
 #else
 
-int __net_init smc_sysctl_net_init(struct net *net)
+static inline int __net_init smc_sysctl_net_init(struct net *net)
 {
        net->smc.sysctl_autocorking_size = SMC_AUTOCORKING_DEFAULT_SIZE;
        return 0;
 }
 
-void __net_exit smc_sysctl_net_exit(struct net *net) { }
+static inline void __net_exit smc_sysctl_net_exit(struct net *net) { }
 
 #endif /* CONFIG_SYSCTL */
 
