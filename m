Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E0455C56B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238934AbiF0QJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 12:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238282AbiF0QJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:09:53 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6183914006
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656346192; x=1687882192;
  h=message-id:date:mime-version:from:subject:to:cc:
   content-transfer-encoding;
  bh=arpBUc08W6JN7v2EclQD7sfV+U15Bjx2FHnJF1KXgwc=;
  b=hsO+PqdmHcMHmsXGPcelygX+8FMTcC8nXsDc4cNnJZ3D7zObWiMMPIjB
   v09xZA72sbddu35AOe/pgNgE2cKuVxjjYCX4SvRC4GRM1bIns3Ge3c/7P
   Dcw0XYyTc4O/GLE92KSmnH+pZ96Sdpmg1DPaAforae0+p9KLViXKXH36j
   0=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Jun 2022 09:09:52 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 09:09:51 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 27 Jun 2022 09:09:39 -0700
Received: from [10.216.8.122] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 27 Jun
 2022 09:09:36 -0700
Message-ID: <59edde13-4167-8550-86f0-11fc67882107@quicinc.com>
Date:   Mon, 27 Jun 2022 21:39:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
From:   Charan Teja Kalla <quic_charante@quicinc.com>
Subject: Discussion on race between freed page_ext access and memory offline
 operation
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Minchan Kim <minchan@kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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

The below race between page_ext and online/offline of the respective
memory blocks will cause use-after-free on the access of page_ext structure.

process1			    process2
---------			    ---------
a)doing /proc/page_owner            doing memory offline	
			            through offline_pages

b)PageBuddy check is failed
thus proceed to get the
page_owner information
through page_ext access.
page_ext = lookup_page_ext(page);
				
				  migrate_pages();
				 ................
				Since all pages are successfully
				migrated as part of the offline
				operation,send MEM_OFFLINE notification
				where for page_ext it calls:
				offline_page_ext()-->
				  __free_page_ext()-->
				    free_page_ext()-->
				      vfree(ms->page_ext)
				mem_section->page_ext = NULL

c) Check for the PAGE_EXT flags
in the page_ext->flags access
results into the use-after-free(leading
to the translation faults).

As mentioned above, there is really no synchronization between page_ext
access and its freeing in the memory_offline.  The above is just one
example but the problem persists in the other paths too involving
page_ext->flags access(eg: page_is_idle()).

The memory offline steps(roughly) on a memory block is as below:
1) Isolate all the pages
2) while(1)
  try free the pages to buddy.(->free_list[MIGRATE_ISOLATE])
3) delete the pages from this buddy list.
4) Then free page_ext.(Note: The struct page is still alive as it is
freed only during hot remove of the memory which frees the memmap, which
steps the user might not perform).

This design leads to the state where struct page is alive but the struct
page_ext is freed, where the later is ideally part of the former which
just representing the page_flags. This seems to be a wrong design where
'struct page' as a whole is not accessible(Thanks to Minchan for
pointing this out).

Some solutions we think are:
----------------------------
1) Take the mem_hotplug_lock read_lock every time page_ext access.

2) Take the extra refcount on the page every time page_ext access is
made, so that parallel offline operation can't free the page to buddy.

3) Change the design where the page_ext is valid as long as the struct
page is alive.

Any other inputs here?

PS: This bug is uncovered while fixing the same page_ext access issue
with the page
pinner(https://lore.kernel.org/linux-mm/20211206184730.858850-1-minchan@kernel.org/)
on Andorid.


Thanks,
Charan
