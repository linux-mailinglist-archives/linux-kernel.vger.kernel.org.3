Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6BC58F38E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 22:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbiHJU3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 16:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbiHJU3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 16:29:37 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6BF27CEC
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 13:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660163376; x=1691699376;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=zEpmcia5lv0GpytXIShYDBMVXcPp+EX7efdqCEFom8k=;
  b=Pj7Dv30DnFY1+zqpXddESbSKWscURGxgV/i2mIRw0UdO24laIu0q56d4
   PjV3Z/QpX97KbFqRNtqJs+O4EpDrz0HhJHMiNKDYheHqG0gWFVXwkI0UF
   KmA/xEhzdQxNzJpwOLKm1z2sAXtjDlDoNWOaN0k2C6MeumKGhQnKz8CMb
   9GhulSR5l/qpjE18+eWfvCkn1u1FWKFJpT+iRpjMDoXc0SsFhe3ecdBwG
   x8CcbPA2mKYuMbYzkbV54ax+lYNVKxLEfwwzGHiBVrk7anoLJBoo3S5YR
   bv22pYXuH3ey9LXctPd1BUeEWGMCGj0crTg7vk2XEn8OE1qPyd/cZTekb
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="271569789"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="271569789"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 13:29:14 -0700
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="605288070"
Received: from sarava2x-mobl1.gar.corp.intel.com (HELO [10.254.67.234]) ([10.254.67.234])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 13:29:14 -0700
Message-ID: <ef3055a8-9cfd-cbd1-d76c-a2242836d16d@linux.intel.com>
Date:   Wed, 10 Aug 2022 13:29:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] x86/apic: Don't disable x2APIC if locked
Content-Language: en-US
From:   Daniel Sneddon <daniel.sneddon@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
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
 <d315aac4-8cda-bc2d-d052-09fb0649b1ad@intel.com>
 <2446fb33-9c5c-642a-797e-4e93345adb82@linux.intel.com>
In-Reply-To: <2446fb33-9c5c-642a-797e-4e93345adb82@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/22 13:06, Daniel Sneddon wrote:
> I could add a blurb to the
> documentation where nox2apic is defined as a parameter as well.  
While I'm at it, I'm thinking of adding something where CONFIG_X86_X2APIC is
defined in kconfig.  I'll put in a blurb about selecting N on SPR systems could
prevent you from booting due to the lock.
