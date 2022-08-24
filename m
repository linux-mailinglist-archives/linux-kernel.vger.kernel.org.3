Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF355A001F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 19:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239920AbiHXRM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 13:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239907AbiHXRMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 13:12:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6CF74DD1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661361143; x=1692897143;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yVFJHZdE6+1EK/qE+Hrire2plRz2ksviX3nXtB9EMQI=;
  b=dw13loqkCys42oG5riTaJi4T+IwLrUsTfjtMRoki7A23KdDWu9Dj7tLG
   AgcUpe1GdaTCB0W+NL71RbecMRuIeR+VxMj/QOwpaICI9JyMqCRcNe74r
   frFGENdl5nOKHaVcgeglioZ5/1bTg/ZTZK+GpPqu7N5G0bozOrlRi6052
   L3mqCcr4oOYjpL1Xg+9VQz4MRO+EotlPraACp9MgnmaLUNbJjD+MNxk8W
   vhYcVJOtzCTonzVZzG1TZh4wCgsdsulAmtpjcoyngJWvyM9XXPwHp3Qlb
   j5DUEVsAxA74dG11XOA3sYC02+rpBA5vJ9mvd80kifNDjfNJ54lG2Vivk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="294807325"
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="294807325"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 10:12:23 -0700
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="937992497"
Received: from skeshri-mobl.ger.corp.intel.com (HELO [10.212.154.182]) ([10.212.154.182])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 10:12:21 -0700
Message-ID: <bb006b7a-525a-3f1b-0fc4-1620bb5bd3ba@intel.com>
Date:   Wed, 24 Aug 2022 10:12:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v9 0/6] Add TDX Guest Attestation support
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
References: <20220728034420.648314-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220728034420.648314-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/22 20:44, Kuppuswamy Sathyanarayanan wrote:
> An Intel SGX Quoting Enclave (QE), written specifically to support
> quoting Intel TDX TDs, uses EVERIFYREPORT2, to help check the integrity
> of the TDG.MR.REPORT. If it passes, the QE can use a certified quote
> signing key to sign a quote containing the guest TD’s measurements and
> the additional data being quoted.

(maintainer hat firmly in place, not speaking as an Intel person here...)

Let's say Intel tires of SGX and zaps it from server CPUs just like it
did clients.  Or, that Intel decides that TDX is really cool and wants
it on SGX-free clients in addition to servers.

Can the guest ABI which is introduced here work for a future attestation
architecture that does not involve SGX?
