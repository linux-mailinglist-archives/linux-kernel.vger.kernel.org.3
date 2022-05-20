Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD3652E7FA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347322AbiETIrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240372AbiETIq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:46:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6859F5E154;
        Fri, 20 May 2022 01:46:56 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24K5mhho030040;
        Fri, 20 May 2022 08:46:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=y9mVKtccokxmVHzYzYmB7GoWZjwMwFt/swEe+h+kpg4=;
 b=rO8T+XZJycmA8pMLpJg8ylY8RZCYX1+RvRoRSeEGyWUzVCnyLS1XDm4jfsPJfuYsryPD
 OLPyT0YgplK9OYzfw1iAR7I3Q+SpRIntgaOAtiF/Fu7tae2bG92ah7rjFYvuVqyti3fP
 DO58BgMiK6sA8elZjXzZMqMxY/4cjMqWKExQZ0orOUyP+qGDMXlOdQLux+blWgu0uB3F
 DN6AA1ruE6BBpkFhfz5MMvwSWe/iuuQzFB5RVlFoNSQWVPdWIlGcgFPkwcYO+4lXVHEN
 jYZn7/xzKvN9YQkCOIDT2wDPBO1N2U4OCnw/v3lMKy6asnCqIik5wcoVI3XpFcTAraci nQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g655vu1jt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 08:46:50 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24K8c6Rf031841;
        Fri, 20 May 2022 08:46:50 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g655vu1jc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 08:46:49 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24K8b1Jn001605;
        Fri, 20 May 2022 08:46:47 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3g2428q9v8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 08:46:47 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24K8k4E326673500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 08:46:04 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2641D42041;
        Fri, 20 May 2022 08:46:44 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0EEAB4203F;
        Fri, 20 May 2022 08:46:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.163.31.125])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 20 May 2022 08:46:38 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org, mpe@ellerman.id.au
Cc:     linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, maddy@linux.vnet.ibm.com,
        rnsastry@linux.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com, irogers@google.com
Subject: [PATCH V3 2/2] docs: ABI: sysfs-bus-event_source-devices: Document sysfs caps entry for PMU
Date:   Fri, 20 May 2022 14:16:30 +0530
Message-Id: <20220520084630.15181-2-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220520084630.15181-1-atrajeev@linux.vnet.ibm.com>
References: <20220520084630.15181-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Cib__CD5jPSDwEZXgRac3-p_LNprtz_1
X-Proofpoint-GUID: Jl7j6Ne0drQ21XUYW4nEKhB6wmjGkWaQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_03,2022-05-19_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205200061
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Details is added about "caps" attribute group in the ABI documentation.
This is used to expose some of the PMU attributes in "caps"
directory under : /sys/bus/event_source/devices/<dev>/. The dev/caps
will contain information about features that platform specific PMU
supports.

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 .../sysfs-bus-event_source-devices-caps        | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-caps

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-caps b/Documentation/ABI/testing/sysfs-bus-event_source-devices-caps
new file mode 100644
index 000000000000..8757dcf41c08
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-caps
@@ -0,0 +1,18 @@
+What:		/sys/bus/event_source/devices/<dev>/caps
+Date:		May 2022
+KernelVersion:	5.19
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:
+		Attribute group to describe the capabilities exposed
+		for a particular pmu. Each attribute of this group can
+		expose information specific to a PMU, say pmu_name, so that
+		userspace can understand some of the feature which the
+		platform specific PMU supports.
+
+		One of the example available capability in supported platform
+		like Intel is pmu_name, which exposes underlying CPU name known
+		to the PMU driver.
+
+		Example output in powerpc:
+		grep . /sys/bus/event_source/devices/cpu/caps/*
+		/sys/bus/event_source/devices/cpu/caps/pmu_name:POWER9
-- 
2.35.1

