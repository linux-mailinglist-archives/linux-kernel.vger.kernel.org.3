Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F7E4D26A1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbiCIDbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 22:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiCIDbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 22:31:10 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0EB6579C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 19:30:11 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V6h7SCV_1646796608;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0V6h7SCV_1646796608)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 09 Mar 2022 11:30:08 +0800
Date:   Wed, 9 Mar 2022 11:30:08 +0800
From:   "dust.li" <dust.li@linux.alibaba.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [saeed:net-next 154/185] net/smc/smc_sysctl.h:23:16: warning: no
 previous prototype for 'smc_sysctl_net_init'
Message-ID: <20220309033008.GH35207@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <202203081012.KgONXWsS-lkp@intel.com>
 <20220308051655.GF35207@linux.alibaba.com>
 <20220307212520.176fce24@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220307212520.176fce24@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 09:25:20PM -0800, Jakub Kicinski wrote:
>On Tue, 8 Mar 2022 13:16:55 +0800 dust.li wrote:
>> >vim +/smc_sysctl_net_init +23 net/smc/smc_sysctl.h
>> >
>> >    22	  
>> >  > 23	int __net_init smc_sysctl_net_init(struct net *net)  
>> >    24	{
>> >    25		net->smc.sysctl_autocorking_size = SMC_AUTOCORKING_DEFAULT_SIZE;
>> >    26		return 0;
>> >    27	}
>> >    28	  
>> >  > 29	void __net_exit smc_sysctl_net_exit(struct net *net) { }  
>> >    30	  
>> 
>> Hi Jakub:
>> 
>> Sorry to bother again on this !
>> Looks like we still need to add 'static inline' or add an extra
>> declaration for these 2 functions if we want to get rid of these warnings.
>> What do you think ?
>
>Sorry my comment was pretty unclear an unnecessary.
>
>I meant that you don't need the __net_init annotation, it still 
>needs to be a static inline. So this is what I meant:
>
>diff --git a/net/smc/smc_sysctl.h b/net/smc/smc_sysctl.h
>index 1d554300604d..0becc11bd2f4 100644
>--- a/net/smc/smc_sysctl.h
>+++ b/net/smc/smc_sysctl.h
>@@ -20,13 +20,13 @@ void __net_exit smc_sysctl_net_exit(struct net *net);
> 
> #else
> 
>-int __net_init smc_sysctl_net_init(struct net *net)
>+static inline int smc_sysctl_net_init(struct net *net)
> {
>        net->smc.sysctl_autocorking_size = SMC_AUTOCORKING_DEFAULT_SIZE;
>        return 0;
> }
> 
>-void __net_exit smc_sysctl_net_exit(struct net *net) { }
>+static inline void smc_sysctl_net_exit(struct net *net) { }
> 
> #endif /* CONFIG_SYSCTL */
>
>
>
>But really it does not matter if the __net_init / exit is there, 
>so this works too:

Another small comment:

When re-compile with the W=1, I found '__net_exit' has noinline
annotation when CONFIG_NET_NS not set:

 #define __net_exit      __ref
 #define __ref           __section(".ref.text") noinline

If '__net_exit' is used together with 'static inline', the compiler
would give another warning:
 net/smc/smc_sysctl.h:29:58: warning: ignoring attribute ‘gnu_inline’
 because it conflicts with attribute ‘noinline’ [-Wattributes]
    29 | static inline void __net_exit smc_sysctl_net_exit(struct net
    *net) { }

So I think your first version would be good.

Thanks.

>
>diff --git a/net/smc/smc_sysctl.h b/net/smc/smc_sysctl.h
>index 1d554300604d..6979e7173669 100644
>--- a/net/smc/smc_sysctl.h
>+++ b/net/smc/smc_sysctl.h
>@@ -20,13 +20,13 @@ void __net_exit smc_sysctl_net_exit(struct net *net);
> 
> #else
> 
>-int __net_init smc_sysctl_net_init(struct net *net)
>+static inline int __net_init smc_sysctl_net_init(struct net *net)
> {
>        net->smc.sysctl_autocorking_size = SMC_AUTOCORKING_DEFAULT_SIZE;
>        return 0;
> }
> 
>-void __net_exit smc_sysctl_net_exit(struct net *net) { }
>+static inline void __net_exit smc_sysctl_net_exit(struct net *net) { }
> 
> #endif /* CONFIG_SYSCTL */
> 
