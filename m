Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51094557F17
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 17:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbiFWP4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 11:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiFWP4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 11:56:10 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A705E443D7;
        Thu, 23 Jun 2022 08:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655999769; x=1687535769;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2sQkvPgRrN3KPlpmOwqAcm6EAu1OjxyKTvt647C45Gw=;
  b=Zfx/u8fUriZFilCefwheZHtrDW/bmFNAyo+aEef2lNneYVZMk1hrtAvw
   nzG+B6sFvtnQCvh9WU3XsZCYDgZTPEpX7doh4dfpelYSBKhV3+GX5nNkP
   nPtDx/pSSPQtOuogcJb5jcUNCBl9ioZfDBim/MC4a9Klmo0DniV0y9nbV
   Dtve7GjYT0N8IjUMaEEKwcUJnOFFt3T28h+RhSb1TkQrKA2zL7NeNsJf4
   VkFrlvvaRer0LF1o3g4zEC4D4wm9yHzHI9ohAHOepObAj8jfCJf75r3fI
   bOL2+HQySBd7Hraw99DOP/vu/1+OTQjSiVNbpomqDCVvH008iBn9lhsUr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="261190292"
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="261190292"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 08:56:09 -0700
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="563500760"
Received: from ckeane-mobl1.amr.corp.intel.com (HELO [10.209.81.98]) ([10.209.81.98])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 08:56:08 -0700
Message-ID: <ec121630-1ee5-1336-1ed4-04506f0c4129@intel.com>
Date:   Thu, 23 Jun 2022 08:55:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V1] x86/cstate: Add Zhaoxin/Centaur ACPI Cx FFH MWAIT
 support
Content-Language: en-US
To:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, LindaChai@zhaoxin.com,
        LeoLiu@zhaoxin.com,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <0b583b7e-dcd3-be51-f367-1c12ac841d3f@zhaoxin.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <0b583b7e-dcd3-be51-f367-1c12ac841d3f@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/22 18:26, Tony W Wang-oc wrote:
> Recent Zhaoxin/Centaur CPUs support X86_FEATURE_MWAIT that implies
> the MONITOR/MWAIT instructions can be used for ACPI Cx state.
> The BIOS declares Cx state in _CST object to use FFH on Zhaoxin/Centaur
> systems. So let function ffh_cstate_init() support These CPUs too.
> 
> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> ---
>  arch/x86/kernel/acpi/cstate.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
> index 7945eae..d4185e1 100644
> --- a/arch/x86/kernel/acpi/cstate.c
> +++ b/arch/x86/kernel/acpi/cstate.c
> @@ -213,7 +213,9 @@ static int __init ffh_cstate_init(void)
> 
>      if (c->x86_vendor != X86_VENDOR_INTEL &&
>          c->x86_vendor != X86_VENDOR_AMD &&
> -        c->x86_vendor != X86_VENDOR_HYGON)
> +        c->x86_vendor != X86_VENDOR_HYGON &&
> +        c->x86_vendor != X86_VENDOR_CENTAUR &&
> +        c->x86_vendor != X86_VENDOR_ZHAOXIN)
>          return -1;

Many of the changelogs that add new vendors here go on about particular
C states declared in the _CST object and contents of CPUID leaf 5.

Why do we even _have_ a vendor check here?  Shouldn't the code just be
going and doing the validation of the _CST object and CPUID that the
changelogs blather on about?

Intel certainly made the original sin on this one (see 991528d7348), but
I hope _something_ changed in the 16 years since that patch went in.
