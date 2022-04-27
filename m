Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AEF5123D1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 22:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbiD0U0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 16:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiD0U0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 16:26:02 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CF6A6217
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 13:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651090970; x=1682626970;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o7mdpqidEbyBiGY8I8MMBjTXIWBYfhuHwykDXnN9r5w=;
  b=ZROvpN8T0MrZG1MQOhstmtlk95gECvYOoBN4hKmfI8RqPXQWh2w/JK0F
   /2r2pRtzxeBLXI8oILtB7APjQaoEAlBNkQeBxGhoBt3K5/vJGIrVu6JDS
   JZmU67Xeb0C4A/6B//DUhuPK5nD/JL6OPrIWxl85PdMAIXmsB66zzp6c+
   g=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 27 Apr 2022 13:22:49 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 13:22:49 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Apr 2022 13:21:48 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 27 Apr
 2022 13:21:47 -0700
Date:   Wed, 27 Apr 2022 16:21:45 -0400
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Liam Howlett <liam.howlett@oracle.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Yu Zhao" <yuzhao@google.com>
Subject: Re: [PATCH v8 00/70] Introducing the Maple Tree
Message-ID: <20220427202145.GA2047@qian>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
 <20220427161033.GA1935@qian>
 <20220427165139.5s3qcj2u5vqrvwlc@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220427165139.5s3qcj2u5vqrvwlc@revolver>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 04:51:50PM +0000, Liam Howlett wrote:
> Thanks.  This is indeed an issue with 0d43186b36c1 (mm/mlock: use vma
> iterator and instead of vma linked list)                                                 
> 
> Andrew, Please include this patch as a fix.

Even with the patch applied, there are still thousands of memory leaks
reports from kmemleak after booting.

unreferenced object 0xffff400259bd6d00 (size 256):
  comm "multipathd", pid 2577, jiffies 4294915929 (age 2370.384s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
     slab_post_alloc_hook
     kmem_cache_alloc_bulk
     mas_alloc_nodes
     mt_alloc_bulk at lib/maple_tree.c:151
     (inlined by) mas_alloc_nodes at lib/maple_tree.c:1244
     mas_preallocate
     __vma_adjust
     shift_arg_pages
     setup_arg_pages
     load_elf_binary
     search_binary_handler
     exec_binprm
     bprm_execve
     do_execveat_common.isra.0
     __arm64_sys_execve
     invoke_syscall
     el0_svc_common.constprop.0
     do_el0_svc
