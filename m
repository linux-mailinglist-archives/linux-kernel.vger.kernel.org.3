Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB3950308E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352317AbiDOU7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 16:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344975AbiDOU67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 16:58:59 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827B435A8C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 13:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650056190; x=1681592190;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TEr+410Cz7xxJFaUMGK2Bokxa0fZlL+QKprnPgzdbCg=;
  b=TP5+rRXbqsmuFna9FBPMBSUWEkZDCLH4JaoNAreabyRps7WQ2JWCZdjt
   AW4+P85FXK5ntY4v3bweuCAunw/W4vBlz/O+hitfiox5VTHyJokrcAGi5
   NzMEvp7uo9bQQGs429FCHt8pfa0nY//gZaQP6YA/4aqXp95UDPNJnn+bU
   SfjqnkIi6Lp6p4nHqfHaqxGWN9CDOQWv1uXLTOCi/8fPlmqm1Ol1JPjyW
   oy08ytkKz5B0dZxrDhy8UUPbhq+RbsWrcDlPNzwjLbzb/2IKz7fu4SklI
   z7LxyiZyOeL+toQrNtzoCu4p5CyBwODas9VaWbqs4rXrWmRIMi0n/NBfH
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="349677781"
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="349677781"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 13:56:30 -0700
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="528061240"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 13:56:29 -0700
Date:   Fri, 15 Apr 2022 14:00:02 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        jean-philippe <jean-philippe@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        iommu <iommu@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <20220415140002.7c12b0d2@jacob-builder>
In-Reply-To: <tencent_CD35B6A6FBB48186B38EF641F088BAED1407@qq.com>
References: <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
        <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
        <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
        <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
        <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
        <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
        <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
        <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
        <YllADL6uMoLllzQo@fyu1.sc.intel.com>
        <99bcb9f5-4776-9c40-a776-cdecfa9e1010@foxmail.com>
        <YllN/OmjpYdT1tO9@otcwcpicx3.sc.intel.com>
        <tencent_CD35B6A6FBB48186B38EF641F088BAED1407@qq.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi zhangfei.gao@foxmail.com,

On Fri, 15 Apr 2022 19:52:03 +0800, "zhangfei.gao@foxmail.com"
<zhangfei.gao@foxmail.com> wrote:

> >>> A PASID might be still used even though it is freed on mm exit.
> >>>
> >>> process A:
> >>> 	sva_bind();
> >>> 	ioasid_alloc() = N; // Get PASID N for the mm
> >>> 	fork(): // spawn process B
> >>> 	exit();
> >>> 	ioasid_free(N);
> >>>
> >>> process B:
> >>> 	device uses PASID N -> failure
> >>> 	sva_unbind();
> >>>
> >>> Dave Hansen suggests to take a refcount on the mm whenever binding the
> >>> PASID to a device and drop the refcount on unbinding. The mm won't be
> >>> dropped if the PASID is still bound to it.
> >>>
> >>> Fixes: 701fac40384f ("iommu/sva: Assign a PASID to mm on PASID
> >>> allocation and free it on mm exit")
> >>>
Is process A's mm intended to be used by process B? Or you really should
use PASID N on process B's mm? If the latter, it may work for a while until
B changes mapping.

It seems you are just extending the life of a defunct mm?

Thanks,

Jacob
