Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5ECE4FE2EC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356027AbiDLNnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355968AbiDLNnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:43:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261694ECCE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 06:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649770879; x=1681306879;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4mr0BKGyGNmXW0x7QfGTYNSu+BqJgjoRew/Y6ezcFe4=;
  b=A/ua4LQDANDzC+m/5NIauxLgHT7WjK0qbnbWzyQMaamx99Hd75Ohhmz4
   gJHPo2RXmk5bDqXCXeVtMpFQhxoiTtFEs+rEkdYk2NVYE1LkeZigvC+mQ
   GL7pkKYSr6/0SgbaZUIiY9vKIStGxP9x/bVpHJeZadGaWfPTE2LKze3RN
   82QAUiyErk53p86GDhL3bGorxb3DRwCa35o9sZ6lf0P95maVlBUUR5uqD
   0b5xfKGHW1Zq/7g3/WvWPZgVRb3upQ++11KRV0NSn1+iudHgBVVaujza7
   ShsxgyE7zqWgGmXyRlVItD/wgipGplYUysbh1MqkkU7oPG/q4U3Q76TE7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="325286273"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="325286273"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 06:41:18 -0700
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="660494090"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 06:41:18 -0700
Date:   Tue, 12 Apr 2022 06:41:39 -0700
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
Message-ID: <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-6-fenghua.yu@intel.com>
 <Ygt4h0PgYzKOiB38@8bytes.org>
 <tencent_F6830A1196DB4C6A904D7C691F0D961D1108@qq.com>
 <56ed509d-a7cf-1fde-676c-a28eb204989b@intel.com>
 <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
 <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
 <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Zhangfei,

On Tue, Apr 12, 2022 at 03:04:09PM +0800, zhangfei.gao@foxmail.com wrote:
> 
> 
> On 2022/4/11 下午10:52, Dave Hansen wrote:
> > On 4/11/22 07:44, zhangfei.gao@foxmail.com wrote:
> > > On 2022/4/11 下午10:36, Dave Hansen wrote:
> > > > On 4/11/22 07:20, zhangfei.gao@foxmail.com wrote:
> > > > > > Is there nothing before this call trace?  Usually there will be at least
> > > > > > some warning text.
> > > > > I added dump_stack() in ioasid_free.
> > > > Hold on a sec, though...
> > > > 
> > > > What's the *problem* here?  Did something break or are you just saying
> > > > that something looks weird to _you_?
> > > After this, nginx is not working at all, and hardware reports error.
> > > Suppose the the master use the ioasid for init, but got freed.
> > > 
> > > hardware reports:
> > > [  152.731869] hisi_sec2 0000:76:00.0: qm_acc_do_task_timeout [error status=0x20] found
> > > [  152.739657] hisi_sec2 0000:76:00.0: qm_acc_wb_not_ready_timeout [error status=0x40] found
> > > [  152.747877] hisi_sec2 0000:76:00.0: sec_fsm_hbeat_rint [error status=0x20] found
> > > [  152.755340] hisi_sec2 0000:76:00.0: Controller resetting...
> > > [  152.762044] hisi_sec2 0000:76:00.0: QM mailbox operation timeout!
> > > [  152.768198] hisi_sec2 0000:76:00.0: Failed to dump sqc!
> > > [  152.773490] hisi_sec2 0000:76:00.0: Failed to drain out data for stopping!
> > > [  152.781426] hisi_sec2 0000:76:00.0: QM mailbox is busy to start!
> > > [  152.787468] hisi_sec2 0000:76:00.0: Failed to dump sqc!
> > > [  152.792753] hisi_sec2 0000:76:00.0: Failed to drain out data for stopping!
> > > [  152.800685] hisi_sec2 0000:76:00.0: QM mailbox is busy to start!
> > > [  152.806730] hisi_sec2 0000:76:00.0: Failed to dump sqc!
> > > [  152.812017] hisi_sec2 0000:76:00.0: Failed to drain out data for stopping!
> > > [  152.819946] hisi_sec2 0000:76:00.0: QM mailbox is busy to start!
> > > [  152.825992] hisi_sec2 0000:76:00.0: Failed to dump sqc!
> > That would have been awfully handy information to have in an initial bug report. :)
> > Is there a chance you could dump out that ioasid alloc *and* free information in ioasid_alloc/free()?  This could be some kind of problem with the allocator, or with copying the ioasid at fork.
> The issue is nginx master process init resource, start daemon process, then
> master process quit and free ioasid.
> The daemon nginx process is not the original master process.
> 
> master process:  init resource
> driver -> iommu_sva_bind_device -> ioasid_alloc

Which code in the master process/daemon calls driver->iommu_sva_unbind_device?

> 
> nginx : ngx_daemon
> fork daemon, without add mm's refcount.
> 
> src/os/unix/ngx_daemon.c
> ngx_daemon(ngx_log_t *log)
> {
>     int  fd;
> 
>     switch (fork()) {
>     case -1:
>         ngx_log_error(NGX_LOG_EMERG, log, ngx_errno, "fork() failed");
>         return NGX_ERROR;
> 
>     case 0:        // here master process is quit directly and will be
> released.
>         break;
> 
>     default:
>         exit(0);
>     }
> // here daemon process take control.
>     ngx_parent = ngx_pid;
>     ngx_pid = ngx_getpid();
> 
> 
> fork.c
> copy_mm
>         if (clone_flags & CLONE_VM) {
>                 mmget(oldmm);
>                 mm = oldmm;
>         } else {
>                 mm = dup_mm(tsk, current->mm);    // here daemon process
> handling without mmget.
> 
> master process quit, mmput ->  mm_pasid_drop->ioasid_free
> But this ignore driver's iommu_sva_unbind_device function,
> iommu_sva_bind_device and iommu_sva_unbind_device are not pair,  So driver
> does not know ioasid is freed.
> 
> Any suggestion?

ioasid is per process or per mm. A daemon process shouldn't share the same 
ioasid with any other process with even its parent process. Its parent gets
an ioasid and frees it on exit. The ioasid is gone and shouldn't be used
by its child process.

Each daemon process should call driver -> iommu_sva_bind_device -> ioasid_alloc
to get its own ioasid/PASID. On daemon quit, the ioasid is freed.

That means nqnix needs to be changed.

> Or can we still use the original ioasid refcount mechanism?
> 

Thanks.

-Fenghua
