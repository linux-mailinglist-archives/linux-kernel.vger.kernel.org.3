Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254D154947A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354106AbiFML2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 07:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353862AbiFMLUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 07:20:01 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88225DEB1;
        Mon, 13 Jun 2022 03:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655116912; x=1686652912;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7rsKUR+6MiJx8UgfRHWwQNo6ucuWpz2ctrmFovdOBQU=;
  b=n3Dw3EkjF2DMD4xxdypbleoBI7aKSWmyX+v1Ll3AssSECEK2lZQ1Mh4J
   ngNHuvr4sKfHx41UU5zItynRrfTdesmDYXECbWB5rEKqTn/xFPoBmAtFk
   AAjNN1chHw9taQjeROy3NSdfGzmBn78hUwL32vwnQNKOEKQeqd9jJpCKl
   NfVn0jIuPTWUyyOBmClnCZgoxH/uwc18tDqcglCKncQDr+snlyHqUECND
   +3+RaJFKCJ3Ep3Z0r53oRgLDZNE5PJ3wBukOsy6SKKfEduEh0vv5OzKDm
   OuoKzPAPpqDxFHvMMkBXL4SNTcPwfhUF/wzBw4EpEY1ACMPPL92Lm4htI
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="258074900"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="258074900"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 03:41:43 -0700
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="639666709"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314) ([10.237.222.76])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 03:41:41 -0700
Date:   Mon, 13 Jun 2022 11:41:34 +0100
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Rob Herring <robh@kernel.org>, Yoan Picchi <yoan.picchi@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>, qat-linux@intel.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 2/2] Removes the x86 dependency on the QAT drivers
Message-ID: <YqcUXrFGO+QVMKBd@silpixa00400314>
References: <20220607165840.66931-1-yoan.picchi@arm.com>
 <20220607165840.66931-3-yoan.picchi@arm.com>
 <20220609213652.GA115440-robh@kernel.org>
 <20220610114840.10db23ea@donnerap.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610114840.10db23ea@donnerap.cambridge.arm.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 11:48:40AM +0100, Andre Przywara wrote:
> On Thu, 9 Jun 2022 15:36:52 -0600
> Rob Herring <robh@kernel.org> wrote:
> 
> Hi,
> 
> > On Tue, Jun 07, 2022 at 04:58:40PM +0000, Yoan Picchi wrote:
> > > This dependency looks outdated. After the previous patch, we have been able
> > > to use this driver to encrypt some data and to create working VF on arm64.
> > > We have not tested it yet on any big endian machine, hence the new dependency  
> > 
> > For the subject, use prefixes matching the subsystem (like you did on 
> > patch 1).
Just to add on this, patches to the qat driver should have the following
headline:
    crypto: qat -
not
    crypto: qat:

> > 
> > The only testing obligation you have is compiling for BE.
> 
> So I just compiled for arm64 BE, powerpc BE & LE, and riscv again:
> $ file qat_c62xvf.ko
> qat_c62xvf.ko: ELF 64-bit MSB relocatable, ARM aarch64, version 1 (SYSV),
> BuildID[sha1]=630cc0ee5586c7aeb6e0ab5567ce2f2f7cc46adf, with debug_info,
> not stripped
> qat_c62xvf.ko: ELF 64-bit MSB relocatable, 64-bit PowerPC or cisco 7500,
> version 1 (SYSV), BuildID[sha1]=4090ba181cf95f27108bf3ecde0776f12ef2b636,
> not stripped
> qat_c62xvf.ko: ELF 64-bit LSB relocatable, 64-bit PowerPC or cisco 7500,
> version 1 (SYSV), BuildID[sha1]=2cb0fd09d5bc36c8918fcd061c9f3dac1546cf0d,
> not stripped
> qat_c62xvf.ko: ELF 64-bit LSB relocatable, UCB RISC-V, version 1 (SYSV),
> BuildID[sha1]=bfaa53df7e9aad79d3ab4c05e75ca9169227f6b8, not stripped
> 
> All built without errors or warnings, for every of the enabled drivers.
> 
> > If kconfig was
> > supposed to capture what endianness drivers have been tested or not
> > tested with, then lots of drivers are missing the dependency. Kconfig
> > depends/select entries should generally be either to prevent compile
> > failures (you checked PPC, RiscV, etc.?) or to hide drivers *really*
> > specific to a platform. IMO, we should only have !CPU_BIG_ENDIAN if it 
> > is known not to work and not easily fixed.
> 
> Fair enough, I leave that decision to Giovanni. I have plans to test this
> with BE, but getting a BE setup on a server is not trivial, both for
> userland and actual booting, so this will take some time. We just didn't
> want to block this on some BE concerns.
Just inspecting the code I can see we are not handling BE in the logic
that builds FW descriptors.
My preference would be to keep !CPU_BIG_ENDIAN until the driver is fixed
and tested.

> > Also, with the dependency, no one can test the driver without modifying 
> > the kernel and if it does work as-is, then one has to upstream a change 
> > and then wait for it to show up in distro kernels. You could mitigate 
> > the first part with COMPILE_TEST.
> 
> Yeah, that's a good point, we were already bitten by this, the initial
> testing was done on a stable distro kernel (v5.4), and it worked fine
> already there.
> 
> Cheers,
> Andre

-- 
Giovanni
