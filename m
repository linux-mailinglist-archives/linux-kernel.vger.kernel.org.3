Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D61D551EE5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241461AbiFTOcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243578AbiFTOci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:32:38 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206102DD4C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655732814; x=1687268814;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tVd1abrCAVnuoDG/6O1kOukir1U0Iwq3YTDWJ+4jDh8=;
  b=RA3qEnRO4mbMvrfjkUXWV92JnZtThoJAq6QbehjQp3nbRbjzA0xNAGNi
   xxdqkrQSA3jpMEjju67ZonMZCpDDIpWC3sXRXkcVUxur/+HDI+VkR8kT1
   2PB03QgDqAdYJrTsHgIGvpKD72GF17x0xT2a5cGJHLu87kUeL3VSzBujT
   g=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Jun 2022 06:46:53 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 06:46:51 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 20 Jun 2022 06:46:51 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 20 Jun
 2022 06:46:49 -0700
Date:   Mon, 20 Jun 2022 09:46:47 -0400
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     Muchun Song <songmuchun@bytedance.com>,
        "Huang, Ying" <ying.huang@intel.com>, <akpm@linux-foundation.org>,
        <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] mm/swapfile: fix possible data races of
 inuse_pages
Message-ID: <YrB6R5uHQaz1adhK@qian>
References: <20220608144031.829-1-linmiaohe@huawei.com>
 <20220608144031.829-3-linmiaohe@huawei.com>
 <87edzjrcq8.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <13414d6a-9e72-fb6c-f0a8-8b83ba0455de@huawei.com>
 <YrA8kxavqsDfH5R7@FVFYT0MHHV2J.usts.net>
 <09ffac27-7fe9-0977-cb33-30433e78e662@huawei.com>
 <b61771ad-9daa-741e-27e4-fdb50a7c5e38@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b61771ad-9daa-741e-27e4-fdb50a7c5e38@huawei.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 08:32:27PM +0800, Miaohe Lin wrote:
> >>>>> --- a/mm/swapfile.c
> >>>>> +++ b/mm/swapfile.c
> >>>>> @@ -2646,7 +2646,7 @@ static int swap_show(struct seq_file *swap, void *v)
> >>>>>  	}
> >>>>>  
> >>>>>  	bytes = si->pages << (PAGE_SHIFT - 10);
> >>>>> -	inuse = si->inuse_pages << (PAGE_SHIFT - 10);
> >>>>> +	inuse = READ_ONCE(si->inuse_pages) << (PAGE_SHIFT - 10);
> >>>>>  
> >>>>>  	file = si->swap_file;
> >>>>>  	len = seq_file_path(swap, file, " \t\n\\");
> >>>>> @@ -3265,7 +3265,7 @@ void si_swapinfo(struct sysinfo *val)
> >>>>>  		struct swap_info_struct *si = swap_info[type];
> >>>>>  
> >>>>>  		if ((si->flags & SWP_USED) && !(si->flags & SWP_WRITEOK))
> >>>>> -			nr_to_be_unused += si->inuse_pages;
> >>>>> +			nr_to_be_unused += READ_ONCE(si->inuse_pages);
> >>>>>  	}
> >>>>>  	val->freeswap = atomic_long_read(&nr_swap_pages) + nr_to_be_unused;
> >>>>>  	val->totalswap = total_swap_pages + nr_to_be_unused;
> >>>>
> >>>> READ_ONCE() should be paired with WRITE_ONCE().  So, change the writer
> >>>> side too?
> >>>
> >>> READ_ONCE() is used to fix the complaint of concurrent accessing to si->inuse_pages from KCSAN here.
> >>> The similar commit is 218209487c3d ("mm/swapfile: fix data races in try_to_unuse()"). IMHO, it's fine
> >>
> >> I think the fix 218209487c3d is incomplete. The write side in swap_range_free() should
> >> also be fixed. Otherwise, IIUC, it cannot stop KCSAN complaining.
> > 
> > I tend to agree with you. READ_ONCE() should be paired with WRITE_ONCE() theoretically. But WRITTE_ONCE()
> > is ignored while the commit is introduced. Add Qian Cai for helping verify it. It's very kind of @Qian Cai
> > if he could tell us whether WRITTE_ONCE() is ignored deliberately.

The write side should be protected by the lock swap_info_struct::lock. Is
that not the case here?
