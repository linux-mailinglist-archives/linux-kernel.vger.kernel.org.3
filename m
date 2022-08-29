Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59385A5400
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 20:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiH2SgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 14:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiH2SgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 14:36:15 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9617A772
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 11:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661798174; x=1693334174;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k2BmfC0sAJmubL13Fvo3U2D/VByPkcsTxGwgRVu4+mo=;
  b=kbQoO9WsL4BCpBjZYmYkwYVERgHNIaN9qfkeVhVEl2UM0sKii7r2eJJm
   qyddQ8omlm5Dq98qRAbxDuY4CvHotHEsVUxiaSRcFl2b5fuilfrXKfDRK
   AJjuy0YjlCow3z8HEdzkL+eKOxA+lVVizRVDCIq/BTCV82Gj3nA+dgk32
   kA/jPFVPeWwZBtT+vR+cXnMuDD1rcCgr2fIRzaAxJS7BxQdZ87wRL8G0B
   YTfx4OQCQZOaiHHavkT5DKtFbWtJWo6yIpq+UTSzSSqUcCecLdHaiwQFq
   wUT4dL/ZBAOCzp78LEMu4JsIX6wuxRN3uuwWBFChQMN9ha/APL9+gnM3I
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="293711355"
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="293711355"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 11:36:13 -0700
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="611399748"
Received: from rlacadex-mobl.amr.corp.intel.com (HELO [10.209.116.122]) ([10.209.116.122])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 11:36:13 -0700
Message-ID: <e46c20a5-9f43-6ec4-6c2e-ea6891a8ce0d@intel.com>
Date:   Mon, 29 Aug 2022 11:36:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/microcode/intel: Allow late loading only if a min rev
 is specified
Content-Language: en-US
To:     Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>
References: <20220829180436.716672-1-ashok.raj@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220829180436.716672-1-ashok.raj@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/22 11:04, Ashok Raj wrote:
> Any microcode that modifies the interface to an OS-visible feature
> will set the min_version to itself. This will enforce this microcode is
> not suitable for late loading unless the currently loaded revision is greater
> or equal to the new microcode affecting the change.

I know this hasn't quite made it into the normal Intel documentation
channels.  But, it would be nice to make sure that we have a _really_
solid description here of the architecture of min_rev which is *very*
close to what the Intel folks building microcode images agreed to.

This whole thing is useless if the architecture contract isn't ironclad
and agreed to by both sides.

One other thing on that note...  The CPU itself authenticates the
microcode.  The OS trusts that the CPU will verify the integrity of the
image.

But, this min_rev is not part of the image that the CPU verifies, right?
 If you get your microcode images out of the back of a van in the shady
part of town, nobody can promise that min_rev in the header follows the
rules.

I don't think we need to defend against that.  I'm not sure we really
even *can* defend against it.  It's probably good to note, though.
