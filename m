Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0874A5FEB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 16:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240189AbiBAPXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 10:23:02 -0500
Received: from mga11.intel.com ([192.55.52.93]:49744 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231308AbiBAPXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 10:23:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643728981; x=1675264981;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=nnvMf1Uwhyx5N3Z7IQ73CHGKH93ytUmyyUjp9Bh+6So=;
  b=FYOYsMN7NcTW4hchK5YEvdK7mwQdesyU9WcvCtVZeMQ5xXO+VpN2c9SI
   OYJ8OSPihAX+QtQ7qBKfEmSUX1TVPIH/FajZqVWvTODze6MDIQ663689k
   j5alkJlv3ZWKJNNxvM80hcwg0J1kzUAIS5D/l4IM5VJ5rTv9aNDrSQoL2
   Ta64X9g1qrlq92iD9Sq+dCt+IiDRq3AkzEIhEP3k0/K7sa/L4Ay95oHSl
   byyqUFmOEkQjqcTgOszXdBtEJEKJbacRMhaf72xykEhVYzj6QIdIDkTNc
   WcTrAC66m9OCLK+qIV39vWqpBJ6O6GaCj1Iy+solLN3fSyz4Hux2IsPmO
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="245306612"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="245306612"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 07:23:01 -0800
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="497377097"
Received: from kssimha-mobl1.amr.corp.intel.com (HELO [10.212.228.15]) ([10.212.228.15])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 07:23:00 -0800
Message-ID: <4d19936f-fc8a-8e86-95b2-67a4ab2e2b7f@intel.com>
Date:   Tue, 1 Feb 2022 07:22:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Douglas Miller <dougmill@linux.vnet.ibm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        George Wilson <gcwilson@linux.ibm.com>, gjoyce@ibm.com,
        Daniel Axtens <dja@axtens.net>,
        "Weiny, Ira" <ira.weiny@intel.com>, Ram Pai <linuxram@us.ibm.com>
References: <20220122005637.28199-1-nayna@linux.ibm.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH 0/2] powerpc/pseries: add support for local secure
 storage called Platform Keystore(PKS)
In-Reply-To: <20220122005637.28199-1-nayna@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/22 16:56, Nayna Jain wrote:
> Nayna Jain (2):
>   pseries: define driver for Platform Keystore
>   pseries: define sysfs interface to expose PKS variables

Hi Folks,

There another feature that we might want to consider in the naming here:

> https://lore.kernel.org/all/20220127175505.851391-1-ira.weiny@intel.com/

Protection Keys for Supervisor pages is also called PKS.  It's also not
entirely impossible that powerpc might want to start using this code at
some point, just like what happened with the userspace protection keys[1].

I don't think it's the end of the world either way, but it might save a
hapless user or kernel developer some confusion if we can avoid
including two "PKS" features in the kernel.  I just wanted to make sure
we were aware of the other's existence. :)

1.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/include/asm/pkeys.h
