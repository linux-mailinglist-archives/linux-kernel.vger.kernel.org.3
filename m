Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF3A4CD9CE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240681AbiCDRLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiCDRLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:11:33 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DC27DA90;
        Fri,  4 Mar 2022 09:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646413846; x=1677949846;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=OhqliwMn1x7qp8itaCieEl3E+urUC3dE0PGBdn7lXQU=;
  b=EpgcfJSvXmKDRIwtQprI2zwnPK+H+E39986ncVQCI2EYuZG2zvmNRjuN
   vKsm5MZq4nUooYu32rHGjYkXcJlf1Kiu3DRGhONLbw+e9Tg+S/9qKtmJk
   nLOc7f+8KF6XOaZY3KJ4P1LEOEYEYA+GFqLWxwMFXymeaTYJ7cWm6jao+
   U1LNidqNZ/HHZuk9JBU0txC40uDWJwhe1aZX+t8+ZAIldkRgPW17ykoew
   A2wxpFYyGxfIs78B9c+n8ShfOWXwMsUHRTDhjR1wVON8f8nxRhYV+ISJt
   P4OBX/jvvejBQXcj1qG53c3xywKaAV2mtlPFYoG9bUzPTBa4khHLCzE36
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="253747548"
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="253747548"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 09:08:28 -0800
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="552288470"
Received: from eabada-mobl2.amr.corp.intel.com (HELO [10.209.6.252]) ([10.209.6.252])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 09:08:28 -0800
Message-ID: <94c4b8e2-1bf8-5a2a-7e76-6b8cad3c6b21@intel.com>
Date:   Fri, 4 Mar 2022 09:08:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, linux-sgx@vger.kernel.org
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20220304122852.563475-1-jarkko@kernel.org>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH RFC] x86: Add SGX_IOC_ENCLAVE_AUGMENT_PAGES
In-Reply-To: <20220304122852.563475-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/22 04:28, Jarkko Sakkinen wrote:
> Explicit EAUG ioctl is a better choice than an implicit EAUG from a page
> fault handler because it allows to have O(1) number of kernel-enclave round
> trips for EAUG-EACCEPT{COPY} process, instead of O(n), as it is in the case
> when a page fault handler EAUG single page at a time.

So this is basically an optimization?  It's MADV_WILLNEED or
MAP_POPULATE to the cost of avoid future faults?
