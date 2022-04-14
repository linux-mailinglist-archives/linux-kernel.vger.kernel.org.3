Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6210B501796
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358733AbiDNPmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344936AbiDNOzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 10:55:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296CEDFDC3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649947426; x=1681483426;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=EgYXqZthIeGRLrVv4lip6igBsa9Qs9QhKnf2tuThQvs=;
  b=h0OFNnbMwwnN9F0g6qnvmt6Q/PmfMWo31yEnTrbUpHNpBT/rFzR+NnlE
   4RvuBLuButsRi3JDs7Dwu9ABOTC/PckjZPvBqYhGhkWaTPaON208pAV8g
   +Kvp9UuNo1sIg7AK5ogK4NZTjmPm3UELt9UBujlRuAk9gwilIrdGJpyjH
   sjtDQO43W3KAxhAvzKvuaXSyPYaCkwOZhxuUd7eAiLlItHWb3+5RmqntE
   4KDp6Lbqwt9CQPgSXXaxkzbHQVKH53O4u0ITwU7jsiyu+ZgAoCb59qPdV
   cCEcvF9Ub3J+yJ/C8w5zp+2OSNLR0HoRybFq00tFMzO4yBE/kGjsObrSv
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="262696556"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="262696556"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 07:43:45 -0700
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="612354417"
Received: from msahoo-mobl1.amr.corp.intel.com (HELO [10.212.62.78]) ([10.212.62.78])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 07:43:44 -0700
Message-ID: <05d59fea-f6f6-6d1a-cc0e-c032202ecc18@intel.com>
Date:   Thu, 14 Apr 2022 07:43:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
References: <20220404103741.809025935@linutronix.de>
 <20220404104820.598704095@linutronix.de>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [patch 1/3] x86/fpu/xsave: Support XSAVEC in the kernel
In-Reply-To: <20220404104820.598704095@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/22 05:11, Thomas Gleixner wrote:
>  - Create a software defined X86_FEATURE_XCOMPACTED to select the compacted
>    XSTATE buffer format for both XSAVEC and XSAVES.

We probably should have logically separated the compacted format bits
from the supervisor bits long ago.  I'm glad this is doing it now.
