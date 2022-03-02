Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEF94CAAAA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239774AbiCBQmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbiCBQmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:42:44 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1BFCFB92
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:42:00 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 222EqFaW002562;
        Wed, 2 Mar 2022 16:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=JFdbPhdDPlCnQK0SS45U+jf4D54W/mP1h4d1i5XCiso=;
 b=l00W2czR5wnYc9ncNjUd9Pz1aWoXlXZr4kRBper4U7vCsZWzEttMguUob9UbftbbERfV
 ZQjT11RTnkpVIJpyD7SzR12YAuhDAyYWOQJmTCdpOWRsKSNfDbWiopF13k9PRDBF2NOV
 MgyVxiHVGpQ7qigbgHRVoBIljrDFtKgxu+EXG0ZPKcCK0kS0DAKJ1BHwDKwymPS6cRmP
 dkml3yl4nrCAUPizJlXhbaAvTpRL8IpR+Aff13fK/trPmxWDtn46icRXtwa8hLiLhGyE
 YGTyM8WN8ls6x7X8ONpPc40VTgvdYc2U5504XHbzSjOW2coRFzPx2msZOsiOJ1v9ZpVV EQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ehdayvpj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Mar 2022 16:41:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 222GM3eM163335;
        Wed, 2 Mar 2022 16:41:36 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2040.outbound.protection.outlook.com [104.47.56.40])
        by userp3030.oracle.com with ESMTP id 3ef9b18d4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Mar 2022 16:41:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsyudh48df6LQOGMRHAjNgml41B7eUX8m51hWVCv9q3K9L931Kh3QSyGwEZavglJe//2DbTZGUedc9KEqPJT0TOe9jnXv+2YDHD82vjHmlMzbA5N/9SqPOZE/upVaXGoJz4EVfRYbJWL29A8buJn5vLjx8u0G7wu7mb874GQgWsYkI6jf+lci6zdoNL76e2+4b+I43P5GbuTloNS3qygXDtdJ79/ag6o7yr8tcBpx6zBHs8EEuy5F6eEw6UT6C1NU+VEerTRB/qX5HtKU/p+mdytQW1q1x2Or3p2mOzT/lYM0a/T4uH+AB738qpe8PM6d/YVJ76mODU4IBbO2uOU7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFdbPhdDPlCnQK0SS45U+jf4D54W/mP1h4d1i5XCiso=;
 b=FOv5okjTRxrqLshJ5XLt3eMonAp6rQs7lXXXjyBlRbVdoWGIXhIAm/lHMHZCHq00dyOMKU75a4YE3yimksVxDsOacyFhDh+1wjzgtYeRuC8SyIcQhb7hRzpUrXbeju55pNe9cjxExVq97cQLRRwmLg9RABCy53aLUFz7DD10lc+BAWyId6Qb9ew6IdszR+tikU86JdR4Rw+6cIVFCknYg0XOZm3MAo9DW3l8kv31IdNbyTOOeR6+/sJSuH+Q7r5i6fQm4wubn1fhLnVVvNz7fnC4v+MinSZTshxlW+JWIdfx0A5gEsVUt5Ha/eSQQg7/YafhIi9Z/yb04v0xGJvwCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFdbPhdDPlCnQK0SS45U+jf4D54W/mP1h4d1i5XCiso=;
 b=JUABIpk19itXwjdpv+Fy6EtcFTtO7M8cW5k7VYefpo4jZDeDMwazEEGdSVPxizWOkEcb7tcb5VcBfA0I/BtTjE+pWIrsTX3LcNeQ0ObxZK5CO+TAyT61Y9wPfHO31Xqw/Z8KnahcsSfXYN7TCGjILOkRWdQaYd24QjglhhfcjZM=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by MWHPR1001MB2144.namprd10.prod.outlook.com (2603:10b6:301:2b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 2 Mar
 2022 16:41:33 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::a0d5:610d:bcf:9b47]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::a0d5:610d:bcf:9b47%4]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 16:41:32 +0000
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        joe.jin@oracle.com
Subject: [PATCH v4 0/2] xen: fix HVM kexec kernel panic
Date:   Wed,  2 Mar 2022 08:40:30 -0800
Message-Id: <20220302164032.14569-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0019.namprd21.prod.outlook.com
 (2603:10b6:a03:114::29) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f6f9cf3-e299-4c77-f530-08d9fc6b8245
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2144:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB21440856A215068C5903B66CF0039@MWHPR1001MB2144.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cMoE7EI0lVtJ+y+qcFexp1j63RV38JqdXLLcW5hFr/SZw/zPd0sMTBT7/erz1RbhgsapuG5CXDzC8oFlHe0giy95VcwuuSEGT4EItMOpYReENuu5G08OepCcIZ8df855H90AmxrhfjG1uPt3NUTQcHHy05C1taSx5Kc/sey0O5GWrVJprkbF2zBNjr6soSr/ZUQKfbMun1iVFiWcTcO7c7tcVUcVNPk7cpI28PFSsmF57v/nx58Tog16jTHSohcSaSO2d3VDnOBLJ8cKSRj++8EG8EKYRzKGRk2wcAq1aWguqjSq+qbSxWUj5jGgKru4BvRgQa46PAF27WiDctKAtaBnG8HyWjZnE9MVAEs2aHloX6oVCyVZmakmxDdBrFOXSc7QmaMlXsBcXFXSiuwrAOKuQsOUiwwko6F6dA1uxM8+9xbPkRlHOZNJ3dF0Jmpw4aW8hcqCEsSXI65Kk0veukGuLOkRbRuD2CVaD1uj7/BS4jXnzFsKG3/AozpAhdesLu5QDCN7evtyIW7PYH580P1FyPczuAJY7q5HJNR8jAcEBWLexWUFK8l6N5opD5uOSgdPShdJo7HrQuBGYJKDTSByS3B2OYr055sqqG7gSJ78qNP1c6IuYQYoS8BZxx7nfdHBAltY1C4r/EpCSIKEjfbhgVQhIsudSeE0SPgjoAxxZA7+NwiKSKqUgIBhbEpIoEPnm0C83pRbBmnx5ERemcfQHocjfRdfnvalDUC8UWHky8RPXbiZyZSIk9dD2hhu8qg8z9DBQ24EGpHzx5c1TYSULMUcjKLggymVpe6DCZo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(66556008)(36756003)(2906002)(44832011)(5660300002)(38100700002)(107886003)(6486002)(38350700002)(966005)(86362001)(508600001)(8936002)(1076003)(186003)(316002)(26005)(6512007)(6506007)(66946007)(8676002)(52116002)(66476007)(4326008)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lHfiFVwIpOfWVnOLp++aqrzKojSKhWU9PBhlaEpeMdpLQDmmMHgO7kpIyH09?=
 =?us-ascii?Q?bkcDcrTFZfecrxCzel9vJOtNDFgdflfflNDU+sz3hAH8WQuGkOzW2XfxXCDh?=
 =?us-ascii?Q?rXRlCRjOYtKvHxloEkubA7KK3xOx8KJjVCRHtdTtfDWJW82IQ/P7sPHBwp89?=
 =?us-ascii?Q?PGKUxJIlH8Zdaf6K9Bwenf5Rt4plizNpRr9J9+ZQervmbueVkOzLtZbNOf5u?=
 =?us-ascii?Q?JfSt3o2UMVwTvXQ77fUvj3oKO3A9htrGaFUwS+xwugWXyMHZpPfHi0hz1beE?=
 =?us-ascii?Q?AbipwOxx+4iYdoGx20PtOLwHqERwsZtgHdjP5oPcnmbLBbO4fNmEeMylZEEC?=
 =?us-ascii?Q?rxGTPXat9C/r4zJ9eA6EqEF09lK7Ae6lQsu8pKrMQW0ykDuVA3AbJimhFfyk?=
 =?us-ascii?Q?dqqdv8t8Kl8m4UI1AibZiZBU2Ikc76W+h6B1b56AeS9WqUooM8IzbzUwWvKs?=
 =?us-ascii?Q?FeZ7Ct1CXZpohOMJkINuWjftJTQdn/BQ3RusaisJL63uYW0QWRIzYrg21sLv?=
 =?us-ascii?Q?NlXYZA5vi+MvQ97aKpjadrJCPTJdoOwDP1feOmr5T+Kw2T2IWJZgbqX6rPgk?=
 =?us-ascii?Q?gysoT/YURmc2C9TrUmjQdhZVhEdhLXHMEDPqa+cLHJ3h1JRxIlTQiJBD2f/I?=
 =?us-ascii?Q?eqIOZhPUsumPlPHQxCCHZyJL5qQV2w10fDQo0McDVGFhOEMMAk8eAz/9m5bZ?=
 =?us-ascii?Q?tLIuWeKzVPRWXDspKR1e6xOFs31fXlreVSHTjTiP/tzr8OAnKp5mDcTytUAb?=
 =?us-ascii?Q?10EM9gwx5TSjiZNF3dgDejAJsFow6/tFTnWNaxMMCwAR+RquId+OeJt/1mNv?=
 =?us-ascii?Q?1x3nFxxwL6Q0oYDpPrXA8OlF4dQS+xd/VWpYHezbwYpat5qZuPHtdTCORRur?=
 =?us-ascii?Q?Of7dTofsV4W0edXt1L4kACdPkl6bjp6uV+GJDgZBwaVImPMRml9uqNGQxSX6?=
 =?us-ascii?Q?Kxf/6YWVn4X6whXcVhK0WqGz4WqtnBJaeKVoqzXIUqQpWqC9EP9UuZSZHhjP?=
 =?us-ascii?Q?vhYcU/foYRrT0TTO/bjRXgKvh7/1l6IN+ifb4BdhJMLqgbX5jnNp5y8AE51j?=
 =?us-ascii?Q?lJBpGFqYlo8nsQoCcTukcxMWfLO0Wx7b4yYQkvXZAiHxLUYuLCUlbzM1NSLH?=
 =?us-ascii?Q?mOOkWYKWWxLROV4P3O5xpWjJEUPFQTFOCSXMJhPSCsbRtWcXm/0p0bZQB1PL?=
 =?us-ascii?Q?tWEcr58uMgswcaJpmXGvj9Rc+rAEuSggLyHCPtp7s2cjLwSUPP8rG7EvxMl+?=
 =?us-ascii?Q?NRb2OHW72/jHAmLmjkLwdhgQs0Ojl+vHvhhi4B42hVoa/g/6APA21aQUNLhp?=
 =?us-ascii?Q?N5256UZMOluewH6COVtSIYSKy8mpuD6qCxcJVSoYkM7yEN6bU22+wkFBbti7?=
 =?us-ascii?Q?p3b0S3saiv+x2TLrzu/5arqDGoDHH5ln6s0qWJpzPH1NuG+3dWT1B8pvHreB?=
 =?us-ascii?Q?g4NGQKY5Jh+J65pZizMOX96JxGJopehZX+mJVsnSb2cJCaha0q2MkvKzNLiJ?=
 =?us-ascii?Q?yE2c5iHLHnB/LdUOYoD1dIV0cXjSNf99qzrT4C4nIZjz2TzCk+7Od8Edyr1O?=
 =?us-ascii?Q?X6Wjra+9CGn5tBLJpm3Ah/rWYVydNeXq7CK7caYfLetJ4PEHiGvJwGQeuOn+?=
 =?us-ascii?Q?kf8Ied06QBgQItJ7bThZg/g=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6f9cf3-e299-4c77-f530-08d9fc6b8245
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 16:41:32.8990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SKOZdcl3103R+IM5Y/Xtux7FgltL7Z+mXnoZtzIbYIBTpk+mD9OaM+5CNxx8glN6iUhyk7F/bdSsQ8Hq0WHGcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2144
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10274 signatures=686787
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=884
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203020073
X-Proofpoint-GUID: xXDSAq_1d6cwUWbM5pPTW0sa8aJxUnex
X-Proofpoint-ORIG-GUID: xXDSAq_1d6cwUWbM5pPTW0sa8aJxUnex
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the v4 of the patch to fix xen kexec kernel panic issue when the
kexec is triggered on VCPU >= 32.

PANIC: early exception 0x0e IP 10:ffffffffa96679b6 error 0 cr2 0x20
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.17.0-rc4xen-00054-gf71077a4d84b-dirty #1
... ...
[    0.000000] RIP: 0010:pvclock_clocksource_read+0x6/0xb0
... ...
[    0.000000] RSP: 0000:ffffffffaae03e10 EFLAGS: 00010082 ORIG_RAX: 0000000000000000
[    0.000000] RAX: 0000000000000000 RBX: 0000000000010000 RCX: 0000000000000002
[    0.000000] RDX: 0000000000000003 RSI: ffffffffaac37515 RDI: 0000000000000020
[    0.000000] RBP: 0000000000011000 R08: 0000000000000000 R09: 0000000000000001
[    0.000000] R10: ffffffffaae03df8 R11: ffffffffaae03c68 R12: 0000000040000004
[    0.000000] R13: ffffffffaae03e50 R14: 0000000000000000 R15: 0000000000000000
[    0.000000] FS:  0000000000000000(0000) GS:ffffffffab588000(0000) knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: 0000000000000020 CR3: 00000000ea410000 CR4: 00000000000406a0
[    0.000000] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.000000] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.000000] Call Trace:
[    0.000000]  <TASK>
[    0.000000]  ? xen_clocksource_read+0x24/0x40
[    0.000000]  ? xen_init_time_common+0x5/0x49
[    0.000000]  ? xen_hvm_init_time_ops+0x23/0x45
[    0.000000]  ? xen_hvm_guest_init+0x221/0x25c
[    0.000000]  ? 0xffffffffa9600000
[    0.000000]  ? setup_arch+0x440/0xbd6
[    0.000000]  ? start_kernel+0x6c/0x695
[    0.000000]  ? secondary_startup_64_no_verify+0xd5/0xdb
[    0.000000]  </TASK>


Changed since v1:
  - Add commit message to explain why xen_hvm_init_time_ops() is delayed
    for any vcpus. (Suggested by Boris Ostrovsky)
  - Add a comment in xen_hvm_smp_prepare_boot_cpu() referencing the related
    code in xen_hvm_guest_init(). (suggested by Juergen Gross)
Changed since v2:
  - Delay for all VCPUs. (Suggested by Boris Ostrovsky)
  - Add commit message that why PVM is not supported by this patch
  - Test if kexec/kdump works with mainline xen (HVM and PVM)
Changed since v3:
  - Re-use v2 but move the login into xen_hvm_init_time_ops() (Suggested
    by Boris Ostrovsky) 


I have tested with HVM VM on both old xen and mainline xen.

About the mainline xen, the 'soft_reset' works after I reset d->creation_reset
as suggested by Jan Beulich.

https://lore.kernel.org/all/d3814109-f4ba-9edb-1575-ab94faaeba08@suse.com/


Thank you very much!

Dongli Zhang


