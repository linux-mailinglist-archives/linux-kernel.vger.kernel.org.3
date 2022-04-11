Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3E64FB6EF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344155AbiDKJJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344136AbiDKJJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:09:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1CA3EABA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649668059; x=1681204059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WSrbsnvdb9Q1ldyMCizYfWtdMa8raFmqP5cc0NVtLuI=;
  b=TEEm6JNFy1b63PaA35Y6TC34ISgP8Fd+6edAbmpoeHTaJ0xvo2/K/IgJ
   B4uEQ+dQNCGT0+OOfGNJehndCa9aLZAGegwlBXN57Y1g8fpjPipviQDHJ
   Hn8Ekowj9lnFXT7em3bblDhsUMRel/4KIWuloCXFwUMOCbv1gV3fcBZRx
   wW5Yf7Tko6uHlmSdELwhYIUn0vhIukYh76iX4Yrg6X1VQggUh866qzT4+
   VNxKT6pyuU3JHthFBLDaY1J2GmVTmBkIWRgkXkD9EbaWZSWag7CWC4zRa
   Faj+Jrujjv4Ma0ODTHU6r1QwTfCNZi3GZRWciyzKr07cMMLPS/sBJ5gtx
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="260919009"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="260919009"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 02:07:39 -0700
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="572040413"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 02:07:34 -0700
Date:   Mon, 11 Apr 2022 17:07:19 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>, lkp@lists.01.org,
        lkp@intel.com, guobing.chen@intel.com, ming.a.chen@intel.com,
        frank.du@intel.com, Shuhua.Fan@intel.com, wangyang.guo@intel.com,
        Wenhuan.Huang@intel.com, jessica.ji@intel.com, shan.kang@intel.com,
        guangli.li@intel.com, tiejun.li@intel.com, yu.ma@intel.com,
        dapeng1.mi@intel.com, jiebin.sun@intel.com, gengxin.xie@intel.com,
        fan.zhao@intel.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [ovl]  30f9ef9479: BUG:kernel_NULL_pointer_dereference,address
Message-ID: <20220411090719.GA21954@xsang-OptiPlex-9020>
References: <20220407094023.GA13500@xsang-OptiPlex-9020>
 <20220407102605.ipstobkadq34gmzg@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407102605.ipstobkadq34gmzg@wittgenstein>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi, Christian,

On Thu, Apr 07, 2022 at 12:26:05PM +0200, Christian Brauner wrote:
> On Thu, Apr 07, 2022 at 05:40:23PM +0800, kernel test robot wrote:
> > 
> > 
> > Greeting,
> > 
> > FYI, we noticed the following commit (built with gcc-11):
> > 
> > commit: 30f9ef94795008e5146f69d2eb043922a512bf85 ("ovl: support idmapped layers")
> > https://github.com/ammarfaizi2/linux-block brauner/linux/fs.idmapped.overlayfs.v3
> 
> That's an old branch. :)
> Anything that has a *.v<idx> appended is basically an old version in my
> tree. The base branch is always the branch name without the *.v<idx>
> suffix.

got it. so there is no need to test these *.v<idx> branches, whatever build,
boot or function, right? If so, we will disable it.

> 
> Thanks!
> Christian
