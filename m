Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD38535BB2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349847AbiE0Iio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349875AbiE0IiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:38:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582A1108AB1
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653640658; x=1685176658;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e8+pSY1x+l3uGIZDMc8m/MwYXF+f6ONLrv/OSYV1yzM=;
  b=joOc++CJ9PdHOtT75aGoFOIl2JZHVwh/1xsrCVA8m+iadCC5My9WfeRx
   PLPWVwxzfVPjTNEIV6EwvaUZ/5kqOtn9uuBsgLVN1oThsmpG41kEeLrbZ
   1PHwhHCVT6Qc35fYGCblOhK1hCwX84/aNlDIuD+ukMxbbZY371tgfDdeI
   EB3exAkodQlrsbbc4vwyvx4g/QNzVRRe/jvfif5Bx4VC5hkmSD/KJ7siF
   2qgF5dS4SyAJJP+LOKH5NCl8pi4YFG6D7s3pgmDo+rzDzYqkHsMeNhVx6
   Rg+5BsOfXt6XswbnRYsku/pDKSURNWb8KCcerIqD9eS5weyEItwmpIOxE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="337469172"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="337469172"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 01:37:37 -0700
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="746823906"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.249.33]) ([10.99.249.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 01:37:35 -0700
Message-ID: <04c05bd5-63c7-bbac-889c-6e9897f7b990@linux.intel.com>
Date:   Fri, 27 May 2022 10:37:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] ARC: bitops: Change __fls to return unsigned long
Content-Language: en-US
To:     Vineet Gupta <vgupta@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-snps-arc@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <20220525144844.1571705-1-amadeuszx.slawinski@linux.intel.com>
 <20220525144844.1571705-2-amadeuszx.slawinski@linux.intel.com>
 <17bdbca6-8352-50a8-0a3e-49ffe09422a2@kernel.org>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <17bdbca6-8352-50a8-0a3e-49ffe09422a2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/2022 5:42 AM, Vineet Gupta wrote:
> Hi,
> 
> On 5/25/22 07:48, Amadeusz Sławiński wrote:
>> As per asm-generic definition and other architectures __fls should
>> return unsigned long.
>>
>> No functional change is expected as return value should fit in unsigned
>> long.
>>
>> Signed-off-by: Amadeusz Sławiński<amadeuszx.slawinski@linux.intel.com>
> 
> Applied to for-curr.
> 
> Thx,
> -Vineet

And apparently __fls is defined in two places in ARC header and I only 
changed one, should I send incremental patch on top of already merged 
one or v2?
