Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B9B55A0B4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiFXSY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiFXSYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:24:54 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA6462BE9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656095093; x=1687631093;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=p4FMspBiyClwzRVZNWQo9Ri5b+AvMd+d8Xon5lCHgv0=;
  b=MDieuRB+mPLqQy3V4+bZOIReG/TeIaEYND/1zxvRZK906S9j4T93qEn5
   eFO7XkoggsZa3eLS9BC72OZz/9OEHipyyh6DQo1orHHNeegSVN0dNiy8A
   L/CUZMfG1/+68UyMh9CBiHSkLO7cvuvxihn1kCWRD7MicGwPjjNFSbn71
   rTqaJ57T1mgWl9KUULBMDkv0ZISoLTTV3GBNBEz0Ijv6Czt7gEsuvM1tE
   WiPP48I56jAx4dbZMYLMU7t5Gy2F6pTjcfHES1rix3LY5wapVwSiIZMyR
   Fk5PPBshNRZbBffIo95/ajL0qSPDZ1DG+7UI+Aj04xoQVB4OKOXsskVhj
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="281107520"
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; 
   d="scan'208";a="281107520"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 11:24:53 -0700
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; 
   d="scan'208";a="731421908"
Received: from mdedeogl-mobl.amr.corp.intel.com (HELO [10.209.126.186]) ([10.209.126.186])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 11:24:52 -0700
Message-ID: <9abde78c-d2c5-c762-24fe-f26669b7cc6c@intel.com>
Date:   Fri, 24 Jun 2022 11:24:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v8 0/5] Add TDX Guest Attestation support
Content-Language: en-US
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/22 19:52, Kuppuswamy Sathyanarayanan wrote:
> Following patches add the attestation support to TDX guest which
> includes attestation user interface driver and related hypercall support.

This is also the place where you lay out the roadmap:

	1. Get a report
	2. Get a quote
	 2a. Interrupt support because quotes take a long time
	 2b. Actual quote module calls and ABI

Right?  That seems worth a few sentences in the cover letter.
