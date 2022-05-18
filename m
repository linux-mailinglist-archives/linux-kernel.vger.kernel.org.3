Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9879552C1DD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 20:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241157AbiERRwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 13:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241140AbiERRwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 13:52:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25C257B34;
        Wed, 18 May 2022 10:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652896362; x=1684432362;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NMMk/+dVMd7BQp5TIAhweXI8TqsztGed7WgvJUNxYEg=;
  b=NCIVsXwpUlt9tR5MpowCsb7GXreJpsZF5CDa+DvG9mrihApwh9mZ5MP/
   pWfeMNvvS0op/SuYjEgyYOoZNTPfNoId/2cCxV3iD0guW8DUTwb7/I76H
   rxka8rJGsQbgNvVswcZOw+vbZY4IniMj6DPCX6nEMiY4xn4MFOanroc1F
   oPPVKA3G3JoQaGB7OxC3p+eWGlDiIINOKds/w/TU59r7JAR49I6YLorDe
   PnH+KAxLVBVJQwGIF8Sbf80aPU4YgYnJ5t01PjpXSnvJzWebUa1fO+aQR
   zKlm3mggLXw3as3GFXtDwkpX7pvAs3Q1pOB1iLXaPhrWuZBSI8rFHI+GK
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="358209546"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="358209546"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 10:27:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="817551215"
Received: from kackerma-mobl2.amr.corp.intel.com (HELO [10.209.69.102]) ([10.209.69.102])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 10:27:37 -0700
Message-ID: <ea52ad4f-0d26-455a-1257-7636f954b002@intel.com>
Date:   Wed, 18 May 2022 10:27:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 1/2] x86/fpu: Add a helper to prepare AMX state for
 low-power CPU idle
Content-Language: en-US
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org
Cc:     tglx@linutronix.de, dave.hansen@linux.intel.com,
        peterz@infradead.org, bp@alien8.de, rafael@kernel.org,
        ravi.v.shankar@intel.com
References: <20220517222430.24524-1-chang.seok.bae@intel.com>
 <20220517222430.24524-2-chang.seok.bae@intel.com>
 <25a2a82f-b5e5-0fce-86c8-03d7da5fcdd1@intel.com>
 <d081a3f8-4a66-f411-f1cd-e80d752d3851@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <d081a3f8-4a66-f411-f1cd-e80d752d3851@intel.com>
Content-Type: text/plain; charset=UTF-8
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

On 5/18/22 10:20, Chang S. Bae wrote:
>> That also has a nice side effect that non-AMX systems will get to use a
>> static branch and can also skip over the XGETBV1 entirely.
> 
> Yes, but FWIW, as it is non-architectural, the function should be
> consumed only by drivers for AMX systems.

Oh, that's a good point.  The new flag is set only on Sapphire Rapids
systems so the new code is only called there as well.  I guess it would
only matter if we end up having systems that need this where AMX isn't
universally available, like if it were fused on or off on certain SKUs
(I have no idea if anyone is actually doing this).
