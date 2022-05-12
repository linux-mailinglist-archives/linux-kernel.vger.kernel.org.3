Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6127D525823
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 01:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359380AbiELXMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 19:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238447AbiELXMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 19:12:50 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5959113B8D8
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 16:12:49 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CGAvuE005052;
        Thu, 12 May 2022 23:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=LZVNUAIDSEu9/DVKOuoRKSe4j+omN8ZwfLvyP3Uyqtk=;
 b=Qb+tNSdQT7hymKCR9HlYUSIkuDzcjrIbWaz3Q6NpRIhiioIA9m7caMHIdR85nqJVQwA7
 dNuWVTGB/WF+BUO9SicLTOY8oQLmSpqiHKnDe1YdrU2mmFn7MtKwCRyWjQ56JFJ19/Pq
 6E10TGFND7eNEqmoac9Vr/tdArfn1wYxJzyU71zlqBqm+wnEKuQX7vX7mHXgwtX3bQx4
 ljjdKQyamhLTwT9m5wbr1HsbqdF69/Tvt/aK8TEoNNaXxyAMPu0CEPbWAZ1SgSvz4Z51
 8D58dgXkphcLs/uDlEKFhcPu4sm0xj0aPWbgqoBgN5Xbo7tjX2hJ3o9dJvE1z/S8hKKO 7Q== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3g0h2s4dr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 23:12:37 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id 6BD3257;
        Thu, 12 May 2022 23:12:36 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [10.207.206.199])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id EC24445;
        Thu, 12 May 2022 23:12:34 +0000 (UTC)
Date:   Thu, 12 May 2022 18:12:34 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Joerg Roedel <jroedel@suse.de>,
        Kyung Min Park <kyung.min.park@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org
Cc:     Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
Message-ID: <Yn2UYst0ETp42uzq@swahl-home.5wahls.com>
References: <20220505194658.246121-1-steve.wahl@hpe.com>
 <20220512151309.330068-1-steve.wahl@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512151309.330068-1-steve.wahl@hpe.com>
X-Proofpoint-GUID: Bn27EBR5OzO3pAHxn15TKeA1h62Kv1Uq
X-Proofpoint-ORIG-GUID: Bn27EBR5OzO3pAHxn15TKeA1h62Kv1Uq
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_19,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=755 spamscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120098
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 10:13:09AM -0500, Steve Wahl wrote:
> To support up to 64 sockets with 10 DMAR units each (640), make the
> value of DMAR_UNITS_SUPPORTED adjustable by a config variable,
> CONFIG_DMAR_UNITS_SUPPORTED, and make it's default 1024 when MAXSMP is
> set.
> 
> If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
> to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
> allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
> remapping doesn't support X2APIC mode x2apic disabled"; and the system
> fails to boot properly.
> 
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>

I've received a report from the kernel test robot <lkp@intel.com>,
that this patch causes an error (shown below) when
CONFIG_IOMMU_SUPPORT is not set.

In my opinion, this is because include/linux/dmar.h and
include/linux/intel-iommu are being #included when they are not really
being used.

I've tried placing the contents of intel-iommu.h within an #ifdef
CONFIG_INTEL_IOMMU, and that fixes the problem.

Two questions:

A) Is this the desired approach to to the fix?

B) Should it be a separate patch, or added onto this patch as a v3?

Error message:  ------------------------------

   In file included from include/linux/intel-iommu.h:21,
                    from arch/x86/kvm/x86.c:44:
>> include/linux/dmar.h:21:33: error: 'CONFIG_DMAR_UNITS_SUPPORTED' undeclared here (not in a function); did you mean 'DMAR_UNITS_SUPPORTED'?
      21 | #define DMAR_UNITS_SUPPORTED    CONFIG_DMAR_UNITS_SUPPORTED
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/intel-iommu.h:531:35: note: in expansion of macro 'DMAR_UNITS_SUPPORTED'
     531 |         unsigned int iommu_refcnt[DMAR_UNITS_SUPPORTED];
         |                                   ^~~~~~~~~~~~~~~~~~~~


vim +21 include/linux/dmar.h

    20
  > 21  #define DMAR_UNITS_SUPPORTED    CONFIG_DMAR_UNITS_SUPPORTED
    22

Initial stab at fixing it: ------------------------------

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 2f9891cb3d00..916fd7b5bcb5 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -10,6 +10,8 @@
 #ifndef _INTEL_IOMMU_H_
 #define _INTEL_IOMMU_H_
 
+#ifdef CONFIG_INTEL_IOMMU
+
 #include <linux/types.h>
 #include <linux/iova.h>
 #include <linux/io.h>
@@ -831,4 +833,6 @@ static inline const char *decode_prq_descriptor(char *str, size_t size,
 	return str;
 }
 
+#endif /* CONFIG_IOMMU_SUPPORT */
+
 #endif


Thanks.

--> Steve Wahl


-- 
Steve Wahl, Hewlett Packard Enterprise
