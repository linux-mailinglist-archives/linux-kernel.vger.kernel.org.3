Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78DC5027CA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 11:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346189AbiDOKB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 06:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbiDOKBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 06:01:24 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E5DBAB84
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 02:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650016736; x=1681552736;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=CuY8lQWVqoDyp5M/6RY1Ni6Xf6rVDsquQgEJnRIkY8k=;
  b=VCizJMMSv3YSjZLSSE1pHQABelIsM/0Cn5hIj03X9TmU9FxVHB5Pqb1A
   s7+CDAcwn0DlxZ7uRm3Sy2uu4D0XYudmycr8+esTfnT6A3KW8rygtzFuv
   TZCOaDQSaPj9hUlp/Gb4+iYebvYb5cDXXgVR2JV72WUnpRdNIcbjMVzZQ
   CBSHLDBteqpCI8uh3O4xSzkBeBiWxYk7HrRTc9g9f01IwI7RoxXM96GjW
   sQc1iYPirZpKSrX4EZ3PmyOGsuxf893/8J8z/+Gje2jyQgxa0Azd/25YY
   XgeN8dtVrxv+czrJ8QQY/iJL8XCxV6uIHENMs+qWL+Qygj1SE2h6vuRTW
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="243062798"
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="243062798"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 02:58:56 -0700
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="527811351"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 02:58:56 -0700
Date:   Fri, 15 Apr 2022 02:59:32 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>,
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
Message-ID: <YllCBJ3nyHMrUW5v@fyu1.sc.intel.com>
References: <Ygt4h0PgYzKOiB38@8bytes.org>
 <tencent_F6830A1196DB4C6A904D7C691F0D961D1108@qq.com>
 <56ed509d-a7cf-1fde-676c-a28eb204989b@intel.com>
 <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
 <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
 <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
 <2cd3132b-2c24-610e-1a96-591f2803404c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2cd3132b-2c24-610e-1a96-591f2803404c@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dave,

On Tue, Apr 12, 2022 at 07:39:10AM -0700, Dave Hansen wrote:
> On 4/12/22 06:41, Fenghua Yu wrote:
> >> master process quit, mmput ->  mm_pasid_drop->ioasid_free
> >> But this ignore driver's iommu_sva_unbind_device function,
> >> iommu_sva_bind_device and iommu_sva_unbind_device are not pair,  So driver
> >> does not know ioasid is freed.
> >>
> >> Any suggestion?
> > ioasid is per process or per mm. A daemon process shouldn't share the same 
> > ioasid with any other process with even its parent process. Its parent gets
> > an ioasid and frees it on exit. The ioasid is gone and shouldn't be used
> > by its child process.
> > 
> > Each daemon process should call driver -> iommu_sva_bind_device -> ioasid_alloc
> > to get its own ioasid/PASID. On daemon quit, the ioasid is freed.
> > 
> > That means nqnix needs to be changed.
> 
> Fenghua, please step back for a second and look at what you are saying.
>  Your patch caused userspace to break.  Now, you're telling someone that
> they need to go change that userspace to work around something that your
> patch.  How, exactly, are you suggesting that nginx could change to fix
> this?  What, specifically, was it doing with *fork()* that was wrong?
> 
> It sounds to me like you're saying that it's OK to break userspace.

You are right. The patch should not break userspace. I follow your
suggestion to fix the issue by mmget() in binding and mmput() in unbinding.
The RFC patch was sent out in another thread. Please review it.

Thank you very much for your advice.

-Fenghua
