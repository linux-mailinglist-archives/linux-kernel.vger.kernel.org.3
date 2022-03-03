Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C836E4CBA5B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 10:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbiCCJfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 04:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbiCCJfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 04:35:08 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290FB381B3;
        Thu,  3 Mar 2022 01:34:23 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2236VpW9006274;
        Thu, 3 Mar 2022 09:34:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=bMrs6h/yWRgvz9thvSel5Bw5+zRca968g7cgiKNaGXM=;
 b=mKAbowLbSf3VFNfvuU4lZwfnlFeTL/mTRSR4qWJJSeJegmb0ME86v1ffngtMordGlKNj
 NAR66XymGNlYTqfJw/mVECb54FzvJ2V6lj+C6QAZYenUjX/gIvtRAL/fJalmn1YARUoe
 N7oBpARJkeCKyZhmhOu0UUuud7AMByTweO5kSGRpSyigJew0CpkgupA4ya/vEEPH87RO
 bdZBddKKldNea4fLoVZMD1nm7dklzFuyw/LAfNBkwZxL4lYgG6QKRy+Uf2Len+QpvRo9
 Bec+GwbMGP+Hixu/dJxg2s0VWhCleBsIpqxcCzhKIdjgDBHDbInoxoAjABHdzKfbI9Ia zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ejj7e1qae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 09:34:00 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2239K4NZ017214;
        Thu, 3 Mar 2022 09:34:00 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ejj7e1q9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 09:33:59 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2239Iq5h022856;
        Thu, 3 Mar 2022 09:33:57 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3efbu9fjnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 09:33:57 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2239XtMC53608830
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Mar 2022 09:33:55 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E69652052;
        Thu,  3 Mar 2022 09:33:55 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.6.152])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 17A965204F;
        Thu,  3 Mar 2022 09:33:53 +0000 (GMT)
Date:   Thu, 3 Mar 2022 11:33:50 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>,
        Marco Elver <elver@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 6/6] slab, documentation: add description of debugfs
 files for SLUB caches
Message-ID: <YiCLftpiVgrLJ9Rh@linux.ibm.com>
References: <20220302173122.11939-1-vbabka@suse.cz>
 <20220302173122.11939-7-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302173122.11939-7-vbabka@suse.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1WM7IjlfwJV7Y_rlBx_RjZZIXDcDkBcT
X-Proofpoint-GUID: O71Pr85KlBDvYhXyJBkhQ8Eo_wrt_Eyq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-03_06,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=634 clxscore=1011 suspectscore=0 adultscore=0 impostorscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203030044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 06:31:22PM +0100, Vlastimil Babka wrote:
> From: Oliver Glitta <glittao@gmail.com>
> 
> Add description of debugfs files alloc_traces and free_traces
> to SLUB cache documentation.
> 
> [ vbabka@suse.cz: some rewording ]
> 
> Signed-off-by: Oliver Glitta <glittao@gmail.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: linux-doc@vger.kernel.org

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  Documentation/vm/slub.rst | 64 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/Documentation/vm/slub.rst b/Documentation/vm/slub.rst
> index d3028554b1e9..43063ade737a 100644
> --- a/Documentation/vm/slub.rst
> +++ b/Documentation/vm/slub.rst
> @@ -384,5 +384,69 @@ c) Execute ``slabinfo-gnuplot.sh`` in '-t' mode, passing all of the
>        40,60`` range will plot only samples collected between 40th and
>        60th seconds).
>  
> +
> +DebugFS files for SLUB
> +======================
> +
> +For more information about current state of SLUB caches with the user tracking
> +debug option enabled, debugfs files are available, typically under
> +/sys/kernel/debug/slab/<cache>/ (created only for caches with enabled user
> +tracking). There are 2 types of these files with the following debug
> +information:
> +
> +1. alloc_traces::
> +
> +    Prints information about unique allocation traces of the currently
> +    allocated objects. The output is sorted by frequency of each trace.
> +
> +    Information in the output:
> +    Number of objects, allocating function, minimal/average/maximal jiffies since alloc,
> +    pid range of the allocating processes, cpu mask of allocating cpus, and stack trace.
> +
> +    Example:::
> +
> +    1085 populate_error_injection_list+0x97/0x110 age=166678/166680/166682 pid=1 cpus=1::
> +	__slab_alloc+0x6d/0x90
> +	kmem_cache_alloc_trace+0x2eb/0x300
> +	populate_error_injection_list+0x97/0x110
> +	init_error_injection+0x1b/0x71
> +	do_one_initcall+0x5f/0x2d0
> +	kernel_init_freeable+0x26f/0x2d7
> +	kernel_init+0xe/0x118
> +	ret_from_fork+0x22/0x30
> +
> +
> +2. free_traces::
> +
> +    Prints information about unique freeing traces of the currently allocated
> +    objects. The freeing traces thus come from the previous life-cycle of the
> +    objects and are reported as not available for objects allocated for the first
> +    time. The output is sorted by frequency of each trace.
> +
> +    Information in the output:
> +    Number of objects, freeing function, minimal/average/maximal jiffies since free,
> +    pid range of the freeing processes, cpu mask of freeing cpus, and stack trace.
> +
> +    Example:::
> +
> +    1980 <not-available> age=4294912290 pid=0 cpus=0
> +    51 acpi_ut_update_ref_count+0x6a6/0x782 age=236886/237027/237772 pid=1 cpus=1
> +	kfree+0x2db/0x420
> +	acpi_ut_update_ref_count+0x6a6/0x782
> +	acpi_ut_update_object_reference+0x1ad/0x234
> +	acpi_ut_remove_reference+0x7d/0x84
> +	acpi_rs_get_prt_method_data+0x97/0xd6
> +	acpi_get_irq_routing_table+0x82/0xc4
> +	acpi_pci_irq_find_prt_entry+0x8e/0x2e0
> +	acpi_pci_irq_lookup+0x3a/0x1e0
> +	acpi_pci_irq_enable+0x77/0x240
> +	pcibios_enable_device+0x39/0x40
> +	do_pci_enable_device.part.0+0x5d/0xe0
> +	pci_enable_device_flags+0xfc/0x120
> +	pci_enable_device+0x13/0x20
> +	virtio_pci_probe+0x9e/0x170
> +	local_pci_probe+0x48/0x80
> +	pci_device_probe+0x105/0x1c0
> +
>  Christoph Lameter, May 30, 2007
>  Sergey Senozhatsky, October 23, 2015
> -- 
> 2.35.1
> 

-- 
Sincerely yours,
Mike.
