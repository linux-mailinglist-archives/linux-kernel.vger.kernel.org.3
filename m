Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E7E49D5DD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiAZXDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:03:07 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:5892 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230166AbiAZXDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:03:05 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QKZD7X002868;
        Wed, 26 Jan 2022 23:02:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=eoo9RMzZqOyrbQKXrnU7aThFs4HSD8bnRY+pSG0B7R4=;
 b=Qg4B89Gf2Pk5eRz7C6fl2QL+RurfGdAgHw1iLjHCy9B2dTICOsa6+wPamWkwP0bSf48A
 u5Sw34c+e1M5kynjt0XxSg5nWwlSumxd44TyKqgdT48dA8SmthtKe8vqEJQl+M9lKEfC
 Hqbv5B1Gza7URhwCer5N/3JUHIqfRPjm+XNLLT6Nxz+nq/LXI+bGlAaEL9X/9KzpXQbn
 TPtYJSaFNHQofHALGSt+yls5qBdZmBvFeS4liW9vgjK9Ufm0yNrza8erpQM0gntFc28g
 JReUrFz2oH75oYKWYHbxNra3Gj6O3SpBOAH8PddLkB8NcvM+akIRPSr86KHM1VTM5QKX OA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dswh9que0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 23:02:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QMopVn176320;
        Wed, 26 Jan 2022 23:02:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by aserp3020.oracle.com with ESMTP id 3dtax99a08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 23:02:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gthj8YxK+iAeTDzJ6WDONNcKwj80t4mQTTZvTICofRe1YM4CedlhWo6z3B/SHS+j4xT8QbBhzgTPmkmU3xZtdV6FqAoB+gu7u9012FlAZgI53/sHcwGmr0c0yVyGJri9FC3GojE6CUsc6VzB4xniTY0XGB7Ny1Zf8mphljBI+kaQPHaE6AoRHKPgrfwHvZNGFWKsPyHaUDuWYi7yKd5/8rr9TQIH2043CJvvdVnNzg/5FrIoTvUHBa3y39yKfuTOqoa4vfsbwn9c1DWwSeOnfUZs2OrQW5jJEkC6G0nCOnWp/GyR6UceOQs3jb1dxlUKYHew3w3tawne/aul6lrOZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoo9RMzZqOyrbQKXrnU7aThFs4HSD8bnRY+pSG0B7R4=;
 b=aAnqR+KyZuJj1pVhy1Tdpu81/91z9CF0ZZmtOoCKgpk9qTSe4DspXTbQM9/oxv2iV/17D6XBUUxLQxdlP5Ne/5xxxfnKIyR46NixWi87VZGpZkNdxz5XtmqavbtAq0kasU8Ek1R/kPF+UIzyHz0T2egYA4g0t/eyU54PO/AdziYGXnio2a8fh42PiLbvcpQKonrwf/rgkwTk5MW3tqc+wOtwaiXN7u40YHGrsjOKpKT7tc4WA71WF1U3YGoOu1bxKYejrtAnuDnkf0EZK6KbT78maCIbs7/BxVHhPFO8qXpIBQGWpWciY8ctTd0lMSUz2C1i08tEGY6x/53lak5dAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoo9RMzZqOyrbQKXrnU7aThFs4HSD8bnRY+pSG0B7R4=;
 b=DG82rPMkI2yfBXj4HGGakwYWRXtsPzGgpXa04y0fyKxAPXT0sQS+cniRwmUSoFPEjyy1/MCG0IlFROlk4wodo3typ/hk4qLWRozOb42l+xz3809Vt4nYRVtJRJKSSOjzg/McUMxlIxPNHpXxAa0SMiF8QaMZYeYStv9usQ8crD4=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by MWHPR10MB1615.namprd10.prod.outlook.com (2603:10b6:301:7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Wed, 26 Jan
 2022 23:02:36 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a%5]) with mapi id 15.20.4930.017; Wed, 26 Jan 2022
 23:02:36 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Sebastian Reichel <sre@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 1/4] panic: Add panic_in_progress helper
Date:   Wed, 26 Jan 2022 15:02:33 -0800
Message-Id: <20220126230236.750229-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126230236.750229-1-stephen.s.brennan@oracle.com>
References: <20220126230236.750229-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR14CA0005.namprd14.prod.outlook.com
 (2603:10b6:930:2::14) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fff71c8-6104-41e2-bf64-08d9e11ff1af
X-MS-TrafficTypeDiagnostic: MWHPR10MB1615:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1615977D3164232F4B1AF190DB209@MWHPR10MB1615.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F7Sw/NW/OoUdLbbMEVPaQPu1OvzlYPJPChuWYVXerbc02jIpVbfGPVvmCFCffSV70vhSfJb6pOl2baV8xpWed5OkRPAdqbOW0CA8pnpWf/wfAQKoZL1JzTg6NyCT4UdXvHb8aUmCKj5W0elRLBfRlmuKHrfZ9hpCMXBaMYCo+ggjRFgE/KDlLdnANYC6YLOk/HoYNAiSAYAZelo/5V3NK/7q1HRZfPWicqIWcEIcb7di7JwBEL7AUE9zC1qsImxR3DcyQzA8Objg8ggf0iaWTZc6ektRA5b6fUONwKvSxmmipBuBY/cbP/IXJtwQgeg5JOBTjQHgy47zQR5jb0TEM1G3ESZvh3XdV69KJieHy0KVsePl+/YepgYYWg2hfEnKVVfiRPz3ZMMnRp2srlcswAJ6oxRK6/b1WYZl6MFM5se7SPHMo5aB3D+AMC66iasoYJknPNgshVpkHJa2D8Q0eiY4Pn8UcrxhzjCNUPuSctHfvK1KEdtpuxt286nmt3cMcjUH2U60gLGexf8YM+AT+3zonvkXvwic3iub1ys0gWPfmDGgVo/ZVxM5IOetXC0wfiLLASmFnFLG3M0LyfT6Lu110Oplat6x0j160u7pI+xqoRkoZuL0EdNHTQ3hWdu/m9f87geT04qlrBpe0ZDMieE+qxZelfh+aAfdd+kiBiu4ShZnmcTr4p88X6xeBdKHYesaRd2NcZ/kQxaMfSddLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(36756003)(2906002)(86362001)(6666004)(54906003)(6916009)(6506007)(52116002)(5660300002)(38100700002)(38350700002)(508600001)(6486002)(8936002)(103116003)(186003)(4326008)(6512007)(8676002)(66476007)(66556008)(66946007)(316002)(26005)(1076003)(7416002)(4744005)(2616005)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sHW7c8XKUUjCj6fV4XcBRztaxgv0p05sjBiJGPZ/b7/at5tKdFudncwWEoKh?=
 =?us-ascii?Q?x6crgAyOxnIkWZqtCAEYgryLZt2g8Va5CRzqN4Lr2plDUKSzcrP8yPPPE/ru?=
 =?us-ascii?Q?CsYClR3lkMl+GmzN78X2DsQyF6IHodWWjteQsbsHFYbQL5s6+mQCo6qmvTMj?=
 =?us-ascii?Q?v1ng9MQCEi+8QSfSVUpGpK2lH41F46rgt907kTZMgDHS0G5GggS1SxGHygiA?=
 =?us-ascii?Q?gpFQSwEd9vzKbET8qjuW97aUNw47NhTfZnY4wz2J06BP0t7EUrUHlemcITjv?=
 =?us-ascii?Q?Of38rADIAy6MmyIkj0Z8iDW0mMHGDH5OXZQW40t4PPrn+pCY/qokneJ3GS0A?=
 =?us-ascii?Q?1kNZED/GlZRV7xdEStWBXeAd62iht6T6dRk7VSj7KE6AuTTlm0FaNA9uZtAM?=
 =?us-ascii?Q?lJnnj08ANCGqOA8T4rZpEWBSsHDauFEcIMaokWMKw0h0WkUx3FmFzHr6AWmw?=
 =?us-ascii?Q?K4h5Bma2s1RDbc/n7hvi8Qdzga0fLGLlWL9gUPFVb1Mdo5SwIr40ORSKYrmT?=
 =?us-ascii?Q?v4PhJw6k1zByALSki+eFdziocugBcs9QlMUzw2H1Twy7hoZ5NB1aHoZ/5qD3?=
 =?us-ascii?Q?Psf69pJmYFYpFbSgI6Q/x580H0PdCFYsmFwUJUXboUlr2taFUSgMP2hT/c/6?=
 =?us-ascii?Q?MqYfvjaB30periFYkMmzDIDij5KGFtTraNqJr3HJYFDvk4JOf+f5o8ZAP03I?=
 =?us-ascii?Q?zIwzN1Mvxc8KEi/3G8puCyB4hfT5jwBGZ5FEYcylC27ntHKRcWs24bc3V29E?=
 =?us-ascii?Q?WkW7Nn1DymnsBfs6Tg5NUR/4Gl/wR8jwhHbZsDknhM6ThbK+SyrAdUXiEEsF?=
 =?us-ascii?Q?Jr4xPM2sVMocJElqSWxbRjmM5l3pp4X2Ve/FUCppoZbSOF7Iq1A3kf/p4NTO?=
 =?us-ascii?Q?Qw4uDl+4yCwVGiJo+8zqA7rh1fS28w3xL45s6HSJkmhhpLq65VkTBFoShh9T?=
 =?us-ascii?Q?tDlLPqgqNtqibOpQlylnBMRVQ5aXIw7ggQyJdqdpvExVz+wxqHrdadJ/e6mM?=
 =?us-ascii?Q?t+sE5t7Mc/TGUEeJTRA9T7Fizh5zgZ1EcEhsVSsHS7fxAWMscD8kLmuDZpmB?=
 =?us-ascii?Q?+LJqT9tUYeB2TjbE8srV3HQw/3FDJJ5caY0F1mC9pVXMZaNUlBqttTNDwzbW?=
 =?us-ascii?Q?hx6E0GE9LEScwev12jJBbAXNYD2PSSeiaNmdAO+GiZWuxGKp48aubsck3JU2?=
 =?us-ascii?Q?BykHB5yVWC6xr8MSz0r2DWqizkj7n99TwWJSSfa+0uo4Nj+gV/bJQcc4XJ3R?=
 =?us-ascii?Q?HCIaIxnEM4qap5QQFMB9QSBHZ70JzyKeFuNcv0hf6HiVJ8aBRhBxB7jV/rf6?=
 =?us-ascii?Q?vOUl7Jhb9ODQO1sDtYNevTyI8HQy0xxXw9f+IvGIGv4box55apSalgE40sLg?=
 =?us-ascii?Q?NKfGIUmRGpCb8hrE+VYtUoH/NqgZucESEnLh4G7YnWXc8T16HmgJd5iAGfCB?=
 =?us-ascii?Q?E84i/A4tiGxUshXVnDQZ4cmQpJKCxnCM2JAvn/crOyUdKbM/6AWvIN8gC4GI?=
 =?us-ascii?Q?G4UXBUeGIaU5no8mKtSc8DATMjxriX+UrpSuJYh4Rfn324BHVd9dnHHWVItQ?=
 =?us-ascii?Q?9fozz0zcWgNamNBGjavkfUsrWvHdkmH4SbEZc0ZmLqWUnMKAiLVZ/DcVADDj?=
 =?us-ascii?Q?tcizdNo0oUTv8eDAsBml42Ua8reIpXruUeI4rBSYdeLMb+1EugkfLskbVSLh?=
 =?us-ascii?Q?hnkVDQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fff71c8-6104-41e2-bf64-08d9e11ff1af
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 23:02:36.5961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3euWCmZUopqKhp7yM34ymiE67cfcIfAYEjgcVvomjz/ZNPF4krIyJMlaVRv3DKNlKVCAREGWUt+/IHjzaCsYVvi3eS0QWT9vgZpxeuh1Js=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1615
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260131
X-Proofpoint-ORIG-GUID: xOKJm49uXy70OW3cC-JUbnQzBilalmYW
X-Proofpoint-GUID: xOKJm49uXy70OW3cC-JUbnQzBilalmYW
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helper will be used in printk code to avoid deadlocks during
panic().

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---

Notes:
    v2: Switch to static inline function

 include/linux/panic.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/panic.h b/include/linux/panic.h
index f5844908a089..1022ec930d34 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -4,6 +4,7 @@
 
 #include <linux/compiler_attributes.h>
 #include <linux/types.h>
+#include <linux/atomic.h>
 
 struct pt_regs;
 
@@ -45,6 +46,11 @@ extern bool crash_kexec_post_notifiers;
 extern atomic_t panic_cpu;
 #define PANIC_CPU_INVALID	-1
 
+static inline bool panic_in_progress(void)
+{
+	return unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID);
+}
+
 /*
  * Only to be used by arch init code. If the user over-wrote the default
  * CONFIG_PANIC_TIMEOUT, honor it.
-- 
2.30.2

