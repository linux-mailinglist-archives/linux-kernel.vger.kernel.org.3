Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFD751CCCB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 01:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiEEXjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 19:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbiEEXjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 19:39:02 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CF262CC;
        Thu,  5 May 2022 16:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651793720; x=1683329720;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QdHqNWyGLHU7CNlXQvsoiMH9bQPQvhJL4LtZP/GKoVg=;
  b=TMY0b7uQhqKJtyWZKPVGmvDLlcrbwdgsCc7Fh1p9STEiougAk6bTGyBS
   GeOsbwhYfLzF/+H212EBAt4UU3lMfQb/Qyt/34sCrZ91M1SuvFqJGGdcc
   6RqczqmAqiE2608t7oz3vMQ+fRjdGyGFjqb3lHBG5ZgCG0/wo4u6bAB0I
   ems86GFt/TD7hrgt4UI6L/G0T0zCAFXtrSMc6JSGbkZXVhpD/iIjC09nH
   mgFXP0n/wnTVYRSxV/nnWY9voxwKD/Ka98zB1Y+1KZqX/YneROTOlgvrO
   hu2xz/uY2wx04grbADaSJpYDqR1y4cO7esiDg8HxQY4NhqWGHZc0abVoo
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="328831078"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="328831078"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 16:35:20 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="665203550"
Received: from jesicili-mobl1.amr.corp.intel.com (HELO [10.213.189.201]) ([10.213.189.201])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 16:35:19 -0700
Message-ID: <32803e0b-8ff6-ae8d-f9cb-ce2d3fd37229@intel.com>
Date:   Thu, 5 May 2022 16:35:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Issue With real-time patches on 5.15.y
Content-Language: en-US
To:     Joseph Salisbury <joseph.salisbury@canonical.com>,
        tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        linux-rt-users@vger.kernel.org
References: <bdb23fe5-51ae-8873-a3d7-85f377877c79@canonical.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <bdb23fe5-51ae-8873-a3d7-85f377877c79@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/22 16:18, Joseph Salisbury wrote:
> The real-time kernel build failure can be resolved by reverting commit
> b50854eca0e0.  The failure seems to be due to the removal of an include
> of xstate.h from pkru.h and caused spinlock_t to not be defined.  The
> commit would only be reverted for the real-time kernel and not any other
> kernels.  I wanted to see if reverting the commit is the proper
> approach, or if cherry-picking additional commits might be a better
> solution in preparation for additional changes that might be coming in
> the future?
> 
> Any suggestions would be greatly appreciated.

I thought you distro folks were the franenkernel experts. :)

But, seriously...  This isn't rocket science.  Just look at the pkru.h
in your tree and figure out what includes it needs.  If it needs FPU
gunk, include the FPU header.  If you get a compile error for spinlock_t
...  well ...  find the code using spinlock_t and make sure it includes
spinlock.h.

