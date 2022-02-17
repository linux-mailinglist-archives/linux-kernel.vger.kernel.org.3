Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8F64BA614
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243261AbiBQQfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:35:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241264AbiBQQfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:35:19 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DAA2B2C6A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:35:03 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21HG8J2T023534;
        Thu, 17 Feb 2022 16:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=cDgPKq0rF08mHbTrnamH9zPTGXEqsI89NrXedHEVJcE=;
 b=jfclaZOTGMylAaiPcXJ3hYUgPVVpyg2LiM97G/cz6JSh7CBSr0tpIlCKmUifz4+lNGDY
 ruLnTCnQvuF79WdhdjJcnfgNvJcDSGTp/m8jcq/lLYnm0lHkEWDfKN8L9hDpOnYBZ21l
 YeYaLHI04gozshwYVF29GKtsJKvaIVnxgtdH46uGg+lQinLR3BYDdbdX2PX3WRBiDsO1
 7nwh8aALNP+Gq6+aj/tgk+OQt21Op6hjfNa0Qf9LZJq9WmeqPw8wviidVv3mqELJp2Qr
 2HPhWpB4T6Qr52BdnyLwPhfSYc5eZQ8dRlmAYLsXKei7sz8EA9B/VWUxt1jnZr/iyeon SQ== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e9r00kqyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 16:34:52 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21HGHwQf007286;
        Thu, 17 Feb 2022 16:34:50 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3e64ha22t5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 16:34:50 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21HGYluZ44237082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 16:34:47 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06D2152063;
        Thu, 17 Feb 2022 16:34:47 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.com (unknown [9.43.54.12])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E32E552054;
        Thu, 17 Feb 2022 16:34:41 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        peterz@infradead.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com
Cc:     santosh@fossix.org, maddy@linux.ibm.com, rnsastry@linux.ibm.com,
        aneesh.kumar@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        vaibhav@linux.ibm.com, tglx@linutronix.de, kjain@linux.ibm.com
Subject: [PATCH v6 4/4] docs: ABI: sysfs-bus-nvdimm: Document sysfs event format entries for nvdimm pmu
Date:   Thu, 17 Feb 2022 22:03:57 +0530
Message-Id: <20220217163357.276036-5-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220217163357.276036-1-kjain@linux.ibm.com>
References: <20220217163357.276036-1-kjain@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dQGoFh_EawfI0Ivhh17qY8uiFzdXHGM5
X-Proofpoint-ORIG-GUID: dQGoFh_EawfI0Ivhh17qY8uiFzdXHGM5
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-17_06,2022-02-17_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202170075
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Details are added for the event, cpumask and format attributes
in the ABI documentation.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
Changelog:
Resend v5 -> v6
- No logic change, just a rebase to latest upstream.

- Link to the patchset Resend v5: https://lkml.org/lkml/2021/11/15/3979

 Documentation/ABI/testing/sysfs-bus-nvdimm | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-nvdimm b/Documentation/ABI/testing/sysfs-bus-nvdimm
index bff84a16812a..64004d5e4840 100644
--- a/Documentation/ABI/testing/sysfs-bus-nvdimm
+++ b/Documentation/ABI/testing/sysfs-bus-nvdimm
@@ -6,3 +6,38 @@ Description:
 
 The libnvdimm sub-system implements a common sysfs interface for
 platform nvdimm resources. See Documentation/driver-api/nvdimm/.
+
+What:           /sys/bus/event_source/devices/nmemX/format
+Date:           February 2022
+KernelVersion:  5.18
+Contact:        Kajol Jain <kjain@linux.ibm.com>
+Description:	(RO) Attribute group to describe the magic bits
+		that go into perf_event_attr.config for a particular pmu.
+		(See ABI/testing/sysfs-bus-event_source-devices-format).
+
+		Each attribute under this group defines a bit range of the
+		perf_event_attr.config. Supported attribute is listed
+		below::
+		  event  = "config:0-4"  - event ID
+
+		For example::
+			ctl_res_cnt = "event=0x1"
+
+What:           /sys/bus/event_source/devices/nmemX/events
+Date:           February 2022
+KernelVersion:  5.18
+Contact:        Kajol Jain <kjain@linux.ibm.com>
+Description:	(RO) Attribute group to describe performance monitoring events
+                for the nvdimm memory device. Each attribute in this group
+                describes a single performance monitoring event supported by
+                this nvdimm pmu.  The name of the file is the name of the event.
+                (See ABI/testing/sysfs-bus-event_source-devices-events). A
+                listing of the events supported by a given nvdimm provider type
+                can be found in Documentation/driver-api/nvdimm/$provider.
+
+What:          /sys/bus/event_source/devices/nmemX/cpumask
+Date:          February 2022
+KernelVersion:  5.18
+Contact:        Kajol Jain <kjain@linux.ibm.com>
+Description:	(RO) This sysfs file exposes the cpumask which is designated to
+		to retrieve nvdimm pmu event counter data.
-- 
2.31.1

