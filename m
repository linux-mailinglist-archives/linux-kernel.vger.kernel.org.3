Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DA752C679
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 00:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiERWnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiERWnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:43:09 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E16F1F63AE;
        Wed, 18 May 2022 15:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652913789; x=1684449789;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bApYtvt/TSAUqep0W2MdhIPoVxtJbVVYS29imwsu5XA=;
  b=YCLap5/wYpa7Kea6sXxEo48yPC+7gFMK+MCghU7h9PAwcs1cpOn2KGX3
   mbkZwTgffTkYQ6fKp2sK0f30z2a3qD9Q8YQMvro3WbMVZR6uuBk98SVwt
   cvIy8kBSyMfZaxHvFuJMiZxZNPa7wka+JlEJ0PeZkPyp4z+3G2z29/JIF
   xqxkr0gFWLJAMI3HdQthWF+X5y69tghXeDsJDGCFeQiui+ACJkdCxqX9s
   cu6mSMAtDyOccXGARC/rrdw1JJxN4n0sXy0EWkZijqZLMr+5y5WIaTmOS
   ilVUj7PDaYxxWcRMU/OE8+H/gu1PuAO9lYEjRRTYxpf/RrldRAtgxM4gQ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="334968674"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="334968674"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 15:43:08 -0700
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="700830716"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.11.158]) ([10.212.11.158])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 15:43:08 -0700
Message-ID: <a05caaa9-244b-a84f-88b2-2d6bfec61fdd@intel.com>
Date:   Wed, 18 May 2022 15:43:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.0
Subject: Re: linux-next: manual merge of the dmaengine tree with Linus' tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220517153435.645a9313@canb.auug.org.au>
 <YoTcmqygoMm/gmsZ@matsya> <a6df0b8a-dc42-51e4-4b7b-62d1d11c7800@intel.com>
 <20220519084049.3e5b58a8@canb.auug.org.au>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220519084049.3e5b58a8@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/18/2022 3:40 PM, Stephen Rothwell wrote:
> Hi Dave,
>
> On Wed, 18 May 2022 10:20:59 -0700 Dave Jiang <dave.jiang@intel.com> wrote:
>> The lock needs to go around both functions, we can move it outside the if().
>>
>>    + 		mutex_lock(&wq->wq_lock);
>>     		if (wq->state == IDXD_WQ_ENABLED) {
>>     			idxd_wq_disable_cleanup(wq);
>>    -			idxd_wq_device_reset_cleanup(wq);
>>     			wq->state = IDXD_WQ_DISABLED;
>>     		}
>>    +		idxd_wq_device_reset_cleanup(wq);
>>    + 		mutex_unlock(&wq->wq_lock);
> Thanks for checking.  I have made that change to my merge resolution.
Thank you!
