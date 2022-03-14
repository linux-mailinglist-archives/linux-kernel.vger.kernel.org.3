Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EADA4D909D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 00:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343756AbiCNXug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 19:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242832AbiCNXub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 19:50:31 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1612A704
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 16:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647301761; x=1678837761;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=7M5knxoOmfrCuDGDv6Hrs47RoFG1XAbST+A6t24ICJ8=;
  b=QPHlDHFBWZUSG3rlf3zIv8iIDh6rlIm3HCFknMeGqpkvK+sx/o3zK+41
   s0lSwrXiM54riwcUhEgicOamZ6N2xipu4uV5hQ4FsJm5UzsHHUPmwDWtF
   4ysCzmM0NGD+2f542TeZjSfWQC0pnf5YWSqfNnIvI5LjogAhBzIkBjFna
   o2WdfAz9O8OunILc8iIOnAgoRm1UbjVH7zF3TvkeTYytJQ/3rcsPhS/OB
   bfiOPz/6TbzZnltaQV9xHWoOWa8VHIPlEB6NI6CWyK0dVNNTIZMLz5+hx
   wbWB1TauLdUEUpw/Fif7oOBPvYIn/Qnldi1CAi1MFNTvmadMDrI7sE301
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="243622550"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="243622550"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 16:49:20 -0700
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="613071356"
Received: from ssraox-mobl2.amr.corp.intel.com (HELO [10.209.55.169]) ([10.209.55.169])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 16:49:19 -0700
Message-ID: <42e0aa73-04c8-a4c2-2d64-80812634b627@intel.com>
Date:   Mon, 14 Mar 2022 16:49:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     ira.weiny@intel.com, Dave Hansen <dave.hansen@linux.intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20220311005742.1060992-1-ira.weiny@intel.com>
 <20220311005742.1060992-6-ira.weiny@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 5/5] x86/pkeys: Standardize on u8 for pkey type
In-Reply-To: <20220311005742.1060992-6-ira.weiny@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/22 16:57, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> The number of pkeys supported on x86 and powerpc are much smaller than a
> u16 value can hold.  It is desirable to standardize on the type for
> pkeys.  powerpc currently supports the most pkeys at 32.  u8 is plenty
> large for that.
> 
> Standardize on the pkey types by changing u16 to u8.

How widely was this intended to "standardize" things?  Looks like it may
have missed a few spots.

Also if we're worried about the type needing to change or with the wrong
type being used, I guess we could just to a pkey_t typedef.
