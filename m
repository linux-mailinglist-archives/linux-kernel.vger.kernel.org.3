Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E062950E2D4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242406AbiDYOTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242378AbiDYOTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:19:48 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3CF1EEF6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650896204; x=1682432204;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AAEEDt7xXTl7wGJqN1W/OSkx+JBqKQDu+fVaYieXLSM=;
  b=gefvwP6r1mZw50UfZMrTXr7xr5Y6X5vxgQesFgriQ/N3p+d3XzveoMZv
   0Th/OJwNjY9nJZzcEoY6rD4K4rxRin2ZJ/cdbKd3K5EPrEca1vYu7k6mX
   BYTPLyPsfvAuX31V7T4vacrR2mxECno70k2blLl3nWA3UwwLXibmf24dB
   XsqnIp80cPTt3knafgtdAB6x8b8EL92UmrGUFBApy8d5wXsS4/9ioX1qH
   GiTxeHcclVC/As2KziAJN8ZxvtNl2SiBlPVjBvW2qHP6KDL1izHPJF1IE
   EYV8Ip+EMPTYEWcL+NFOWfhdG+iPdjXItfID9CyCbKNEAR3fr+pSv9Og2
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="265423517"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="265423517"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 07:16:44 -0700
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="595254808"
Received: from bjkrist-mobl.amr.corp.intel.com (HELO [10.212.88.70]) ([10.212.88.70])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 07:16:43 -0700
Message-ID: <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
Date:   Mon, 25 Apr 2022 07:18:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Content-Language: en-US
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Joerg Roedel <joro@8bytes.org>,
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
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        robin.murphy@arm.com, zhangfei.gao@linaro.org
References: <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
 <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
 <YllADL6uMoLllzQo@fyu1.sc.intel.com> <YmA4pbgevqln/jSO@myrica>
 <tencent_76E043C4D1B6A21A5253579A61034107EB06@qq.com>
 <tencent_7477100F8A445C6CAFA8F13601A55134480A@qq.com>
 <YmJ/WA6KAQU/xJjA@myrica>
 <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
 <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <Yman5hLomw9/c+bi@myrica>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Yman5hLomw9/c+bi@myrica>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/22 06:53, Jean-Philippe Brucker wrote:
> On Sat, Apr 23, 2022 at 07:13:39PM +0800, zhangfei.gao@foxmail.com wrote:
>>>> On 5.17
>>>> fops_release is called automatically, as well as iommu_sva_unbind_device.
>>>> On 5.18-rc1.
>>>> fops_release is not called, have to manually call close(fd)
>>> Right that's weird
>> Looks it is caused by the fix patch, via mmget, which may add refcount of
>> fd.
> Yes indirectly I think: when the process mmaps the queue, mmap_region()
> takes a reference to the uacce fd. That reference is released either by
> explicit close() or munmap(), or by exit_mmap() (which is triggered by
> mmput()). Since there is an mm->fd dependency, we cannot add a fd->mm
> dependency, so no mmget()/mmput() in bind()/unbind().
> 
> I guess we should go back to refcounted PASIDs instead, to avoid freeing
> them until unbind().

Yeah, this is a bit gnarly for -rc4.  Let's just make sure there's
nothing else simple we can do.

How does the IOMMU hardware know that all activity to a given PASID is
finished?  That activity should, today, be independent of an mm or a
fd's lifetime.
