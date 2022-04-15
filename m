Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB1B502F0F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 21:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347102AbiDOTJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 15:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243989AbiDOTJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 15:09:43 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED7DDAFF8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 12:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650049634; x=1681585634;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N5QZMTpSuxuuC/JrRfv1HnnxupDIgOPC/dOq/bciEhQ=;
  b=bddlrUzqdecOgRVll85KwtE+/vUhqyM7/zdYckyPu/60lT18Fxmhv0Ve
   dw9uBtt7O6sQ0Og/uzs+FMHGh9Un5uiH35hjEkTs+faCAypD2A+Wyxg9D
   lA8ULOXcgb0G54wVdhy0dNO3k02doL5wTiqJwqrh/i2tj8MBS9GL0lye4
   0bSZ9OVM7NVISKWd+5zuYVvFaR8Eu5WKVAqC50Pvxk7H6Uh3kO21YK5wc
   jlSjNWn0xkFLv44C19F0+9ClP4TzRVNa/uQgMtYIdoknfCn2vdrR+ChaH
   6pPHYvmBWtXE0mWTcqN6zSYPJD85IC3+/fXO6+vGpKTd+JWrNERvpJN+U
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="262068616"
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="262068616"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 12:07:14 -0700
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="553275527"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 12:07:14 -0700
Date:   Fri, 15 Apr 2022 12:07:44 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        jean-philippe <jean-philippe@linaro.org>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YlnCgJ6Mc7TtQSFQ@fyu1.sc.intel.com>
References: <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
 <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
 <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
 <YllADL6uMoLllzQo@fyu1.sc.intel.com>
 <99bcb9f5-4776-9c40-a776-cdecfa9e1010@foxmail.com>
 <YllN/OmjpYdT1tO9@otcwcpicx3.sc.intel.com>
 <tencent_CD35B6A6FBB48186B38EF641F088BAED1407@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_CD35B6A6FBB48186B38EF641F088BAED1407@qq.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Zhangfei,

On Fri, Apr 15, 2022 at 07:52:03PM +0800, zhangfei.gao@foxmail.com wrote:
> > On my X86 machine, nginx doesn't trigger the kernel sva binding function
> > to allocate ioasid. I tried pre- nstalled nginx/openssl and also tried my built
> > a few versions of nginx/openssl. nginx does call OPENSSL_init_ssl() but
> > doesn't go to the binding function. Don't know if it's my configuration issue.
> > Maybe you can give me some advice?
> I am using openssl engine, which use crypto driver and using sva via uacce.
> nginx -> openssl -> openssl engine -> sva related.

uacce is not used on X86. That's why I cannot test IOASID/PASID by nginx
on X86.

I only can test the RFC patch by other test tools via IDXD driver which uses
PASID on X86.

Thanks.

-Fenghua
