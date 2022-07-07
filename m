Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD9E56AA02
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbiGGRvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 13:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbiGGRu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:50:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2B7FE7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 10:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657216258; x=1688752258;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HeNs/JD0xOimySiaifY9QxTIfFe/OVms8T1fLccvbBU=;
  b=CwZoYGPnmKupOEROtjVBgUQWjRx9mxiNVXz4mnu+25nbSGWhRnYRJy1P
   sUNIkeYI8pGIarVwV4obF0UlbRKLd+hjo0ehF763QHkEkjU1QqeVSNXgm
   k8lkKUyritpXRYRaypFL1XIwhLYcRMJ1CKgzv76Z3O3JhBKdECtlnX6Om
   wrVuI3In3AuXXoEYF7UOWpIVZvrUidKvvLdl57wn/Pi0Ujdobem0dhbMF
   75B9zO2B8X0hJ9L8oYB8xMiHRt26z13bCll8K+GtujIhzABjZMcvWqEYT
   mnjwLJw2shGhGTJNwc+BgMBqNodllyTzJZULaTjLKAARs6dYusneiUXL2
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="272881473"
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="272881473"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 10:50:57 -0700
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="620890790"
Received: from nmajidi-mobl.amr.corp.intel.com (HELO [10.251.17.238]) ([10.251.17.238])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 10:50:57 -0700
Message-ID: <ad552a6d-457c-8694-3d7d-ac670e805605@intel.com>
Date:   Thu, 7 Jul 2022 10:50:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [tip: x86/boot] x86/kexec: Carry forward IMA measurement log on
 kexec
Content-Language: en-US
To:     Jonathan McDowell <noodles@fb.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>, Baoquan He <bhe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
 <165721275237.15455.6157055713679490274.tip-bot2@tip-bot2>
 <YscZM+N77zUb1uam@noodles-fedora.dhcp.thefacebook.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <YscZM+N77zUb1uam@noodles-fedora.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/22 10:37, Jonathan McDowell wrote:
> On Thu, Jul 07, 2022 at 04:52:32PM -0000, tip-bot2 for Jonathan McDowell wrote:
>> The following commit has been merged into the x86/boot branch of tip:
> Just to clarify there's not some confusion going on; this is already in
> -next via tip/master via tip/x86/kdump.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/kdump&id=b69a2afd5afce9bf6d56e349d6ab592c916e20f2

Ahh, thanks for the heads up.  I'll zap it from x86/boot.

