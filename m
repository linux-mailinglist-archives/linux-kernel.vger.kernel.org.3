Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2250B58F360
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 21:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbiHJT7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 15:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbiHJT7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 15:59:18 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A38C832DA
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 12:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660161557; x=1691697557;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XiJ89ys/W9hMwZlNOA7CICiK2nm7aXu4Rn0ibzObLio=;
  b=Jc9iM4t8+WTUNeYvsMDvg/vVV7tQmMP6GdBbCrYOB1bAWPBXvrswv/nk
   92b4vGRvniZU9DP7KyOXX/6oBMauylqAUJ24CTJB555Ad8gt+pXwdq59y
   fQx840Hb1dP7JJNaNU5vcceW9DZDAuMQM/aXHwkMZkaLjJ1PvyYhRmCoD
   sHSOA9FeL17flOAWNawmzVZoUnfn+Whl677ewm1RgmHSgcr2sVNRtz/3M
   mO0YPJr7wDeTR3dTkozpsJoP2eAWkc04IlDcGUDf8zo/dMwmjPwRyp+J9
   AMOacp4tBq/sBGAGVGbhDQnhXp51eLHG5uR5XTAKm23XV8Do8hgRW/B0a
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="377468245"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="377468245"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 12:59:17 -0700
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="781351240"
Received: from snedunga-mobl2.amr.corp.intel.com (HELO [10.212.234.47]) ([10.212.234.47])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 12:59:16 -0700
Message-ID: <d315aac4-8cda-bc2d-d052-09fb0649b1ad@intel.com>
Date:   Wed, 10 Aug 2022 12:59:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/apic: Don't disable x2APIC if locked
Content-Language: en-US
To:     Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "Gomez Iglesias, Antonio" <antonio.gomez.iglesias@intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
References: <20220809234000.783284-1-daniel.sneddon@linux.intel.com>
 <d6ffb489-7024-ff74-bd2f-d1e06573bb82@intel.com>
 <238ea612-5a25-9323-b31f-0a14493db2f7@linux.intel.com>
 <d4bcb22e-224c-d256-cb93-3ff6ed89a7d0@intel.com>
 <341ea6e9-d8f3-ee7a-6794-67408abbf047@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <341ea6e9-d8f3-ee7a-6794-67408abbf047@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/22 12:40, Daniel Sneddon wrote:
>> It it going to be *forced* on those SPR system?  In other words, is it a
>> little BIOS switch that users can flip?  Is there any non-kernel
>> workaround if a user hits this, or is the entire burden of this going to
>> be foisted on the kernel?
> It won't be forced, BUT, certain features won't be available if the APIC isn't
> locked.  According to the documentation SGX and TDX won't be available if you
> don't lock the APIC.  So, yes, you don't have to fix it in the kernel, but you
> may lose access to features if you don't.

Let's get some of this in the changelog and _possibly_ Documentation/ so
that users know we're depending on the BIOS to play nice.  Let's put
ourselves in the place of our users for a moment at least and try to
figure out how we play our part to help get them from seeing "can't
disable x2apic mode" or whatever to them flipping knobs in the BIOS.

I also dearly hope that Intel has told BIOS writers that the onus is on
them *and* those nice BIOS folks listen to Intel. :)

In any case, I don't think backports are warranted here at the moment.
We can always do it in the future if the need arises.
