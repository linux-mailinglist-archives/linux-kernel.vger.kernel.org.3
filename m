Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E079852F1E7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 19:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352349AbiETRws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 13:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbiETRwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 13:52:44 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A4018540D
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 10:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653069163; x=1684605163;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OhJ4aYyvpAOhAHNeYggMnIXsQYyLa0kL292l2M4HFRg=;
  b=TAOyqs05VAlvBIuzG/G+OeegDPomVrDFo7eMDHErY6/keLGNVRkyIJ+3
   ouz5MoKs66cG4LfMVI46XjpRzEpZGJjO7aMcU8f30vJEAIQlN4bD/nOJZ
   DsrKhOH6iEouvOmzrtX+f8An8X/kWWQanhpVzkQXGmE3v1+TyP64OxPcK
   vzNYavX1Nisy2+Bhm3G96gew6pGftKncy8m7LEFdoG2zEdtHCvJeZK/3U
   5CP+jadLWz94tStpIyAFM1emj1Qbek3uUtOzXUKRDAcWWcLBSINsa5Z8L
   47MXXtaI77HXOfkZEQoVZ14PhFyJ4PiFfOVs3xLj4cdZ2FZczSwXdlwc/
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="297997166"
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="297997166"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 10:52:42 -0700
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="570927166"
Received: from luislore-desk2.amr.corp.intel.com (HELO [10.212.196.93]) ([10.212.196.93])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 10:52:41 -0700
Message-ID: <af726924-4eb1-aa2c-319f-0a67003ef37f@intel.com>
Date:   Fri, 20 May 2022 10:52:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHv2 2/3] x86/tdx: Clarify RIP adjustments in #VE handler
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org
Cc:     ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org
References: <20220520031316.47722-1-kirill.shutemov@linux.intel.com>
 <20220520031316.47722-3-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220520031316.47722-3-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/22 20:13, Kirill A. Shutemov wrote:
> +	/*
> +	 * If the #VE happened due to instruction execution, GET_VEINFO
> +	 * provides info on the instruction in out.r10.
> +	 *
> +	 * For #VE due to EPT violation, info in out.r10 is not usable and
> +	 * kernel has to decode instruction manually to find out its length.
> +	 */
> +	if (ve->exit_reason != EXIT_REASON_EPT_VIOLATION) {
> +		ve->instr_len   = lower_32_bits(out.r10);
> +		ve->instr_info  = upper_32_bits(out.r10);
> +	} else {
> +		ve->instr_len   = 0;
> +		ve->instr_info  = 0;
> +	}
>  }

This is _better_, but I still don't like it.  It still hides the magic
down in here and if someone screws it up, they'll silently get a loop of
#VE's.  If we stick the logic a helper like:

int ve_instr_len(struct ve_info *ve)
{
	if (WARN_ON_ONCE(ve->exit_reason != EXIT_REASON_EPT_VIOLATION))
		return 0;

	return ve->instr_len;
}

and then folks consume the instruction length with that, we get a splat
right where and when it goes wrong.

BTW, how do we know that all non-EPT_VIOLATION exits reasons are
instruction execution?
