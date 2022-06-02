Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093D353B428
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 09:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbiFBHKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 03:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbiFBHKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 03:10:44 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2823BBDA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 00:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654153843; x=1685689843;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XZsW2B7H+o5XWTJCx/TePFDSwcBCR7MzL4ujujBD1h8=;
  b=l7RJqkzuLvttmnSuO1fakcMz4cQyCkiSqJfMEpvn7hCRW/zVU1tZ1+wT
   4mdcn/D7pl2lg78HBiERaQl/YtXP0F3/tdGpmnNydhNzaHTgeItyG3tct
   ig5U0rwLKEQoH6ppe30lP2EwPxu7y5nNe+a+N30LcAaOdWjwx3zxoA3l3
   +iXpV7lx9Hhv50PlQC9GGpETL7IUQOC/YMD+C/iBESX8NBD65yrqzSx5m
   JVmEv567xLXfjac3SaJzCEBByRK2ld6wMgXZS7OVvFMkkVY6rncn+CiST
   +piBuDkBSkUcvA6FSJGzfcbqW2a05hMVYfSHdH2jSXFSMZF13o/UT2kUT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="263487320"
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="263487320"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 00:10:42 -0700
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="530440407"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 00:10:40 -0700
Date:   Thu, 2 Jun 2022 15:10:33 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [printk]  8e27473211: hwsim.ap_ft_pmf_bip_cmac_128.fail
Message-ID: <20220602071033.GA27190@xsang-OptiPlex-9020>
References: <20220531033052.GD17663@xsang-OptiPlex-9020>
 <874k15n2jt.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874k15n2jt.fsf@jogness.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John Ogness,

On Tue, May 31, 2022 at 05:35:26PM +0206, John Ogness wrote:
> Hi Oliver,
> 
> I am having great difficulties trying to reproduce this test. It seems I
> need to setup real hardware with multiple access points. Can you point
> me to some detailed documentation about preparing this test? Thanks.

we got this test suite from https://github.com/bcopeland/wmediumd. there is
a detail README there, hope it would be helpful to you.

_but_, since you mentioned it's difficult to reproduce, we did more tests,
and found this could be platform specific.

first, we queued more jobs to platform from which the original report was made,

model: Skylake
nr_cpu: 4
memory: 32G
brand: Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz

and confirmed the parent is still clean, and tests still failed on 8e27473211

========================================================================================
compiler/kconfig/rootfs/tbox_group/test/testcase/ucode:
  gcc-11/x86_64-rhel-8.3-func/debian-10.4-x86_64-20200603.cgz/lkp-skl-d03/group-18/hwsim/0xec

09c5ba0aa2fcfdad 8e274732115f63c1d0913628443
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :10         190%          19:20    hwsim.ap_ft_eap_cui.fail
         10:10         -90%           1:20    hwsim.ap_ft_eap_cui.pass  <-- just saw one pass for 8e27473211  which seems random
           :10         200%          20:20    hwsim.ap_ft_many.fail
         10:10        -100%            :20    hwsim.ap_ft_many.pass
           :10         200%          20:20    hwsim.ap_ft_pmf_bip_cmac_128.fail
         10:10        -100%            :20    hwsim.ap_ft_pmf_bip_cmac_128.pass


secondly, we tested on another very similar Skylake desktop platform, confirmed
similar results:

=========================================================================================
compiler/kconfig/rootfs/tbox_group/test/testcase/ucode:
  gcc-11/x86_64-rhel-8.3-func/debian-10.4-x86_64-20200603.cgz/lkp-skl-d05/group-18/hwsim/0xec

09c5ba0aa2fcfdad 8e274732115f63c1d0913628443
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :3          100%           3:3     hwsim.ap_ft_eap_cui.fail
          3:3         -100%            :3     hwsim.ap_ft_eap_cui.pass
           :3          100%           3:3     hwsim.ap_ft_many.fail
          3:3         -100%            :3     hwsim.ap_ft_many.pass
           :3          100%           3:3     hwsim.ap_ft_pmf_bip_cmac_128.fail
          3:3         -100%            :3     hwsim.ap_ft_pmf_bip_cmac_128.pass


_but_, when we tested on one Ivy Bridge desktop platform:

model: Ivy Bridge
nr_node: 1
nr_cpu: 4
memory: 8G
brand: Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz

we found ap_ft_eap_cui/ap_ft_many/ap_ft_pmf_bip_cmac_128 can pass on both
8e27473211 and its parent:

=========================================================================================
compiler/kconfig/rootfs/tbox_group/test/testcase/ucode:
  gcc-11/x86_64-rhel-8.3-func/debian-10.4-x86_64-20200603.cgz/lkp-ivb-d02/group-18/hwsim/0x21

09c5ba0aa2fcfdad 8e274732115f63c1d0913628443
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
          3:3            0%           3:3     hwsim.ap_ft_eap_cui.pass
           :3           33%           1:3     hwsim.ap_ft_many.fail  <-- here is a fail, but maybe random
          3:3          -33%           2:3     hwsim.ap_ft_many.pass
          3:3            0%           3:3     hwsim.ap_ft_pmf_bip_cmac_128.pass


from above, the issue could be reproduced persistently on Skylake desktop
platform, but not surely for others.

hope these information could give you some hints and please request us for
further tests if you have some ideas or doubts. Thanks a lot!

> 
> John Ogness
> 
> On 2022-05-31, kernel test robot <oliver.sang@intel.com> wrote:
> > (please be noted we reported
> > "[printk]  8e27473211: hwsim.ap_ft_pmf_bip_gmac_256.fail"
> > on
> > https://lore.kernel.org/all/20220430143056.GA27004@xsang-OptiPlex-9020/
> > when this commit is on linux-next/master
> > now we noticed there are other hwsim tests failures while
> > ap_ft_pmf_bip_gmac_256 problem is still existing, after this commit is on
> > mainline now.
> > FYI)
