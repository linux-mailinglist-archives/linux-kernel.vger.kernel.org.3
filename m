Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5661E462E39
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 09:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239455AbhK3IJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 03:09:39 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:22336 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239450AbhK3IJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 03:09:38 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AU6h75p009072;
        Tue, 30 Nov 2021 08:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=ySk8VI5umvW/pkOsk8jOixBL8kSiFNqv1h5QcG4GzHM=;
 b=sfLWZchJvWHiuhfR5t11aITZhsU0F+6PFaG5zhR3on8gdv+63kOGk1d1k3xB46dEu6vs
 kJ1vqMNBMso7iWlxU1t8QJ2ftdyyDc3GL2rGnopfcmqsGBPNnQZlNM2Roy3qLme9LTm5
 4CEDWwqB6cW5bNAjECpw8nug/OF26O+o+PqSKk2qaAgEYs+wJHqPW0mkOghDcv0tKPEo
 sCs9gCF8bm86EG2aydiAr9yECW06NR2UsXdnpTkk7LZDTz17IO0YhCNiPWJHREmfJKKg
 +aQEeEEa9eehKA/F9lqunxSo+GRZ1jT0/iyO5AV9CDZ5Q1/Zc1esExvHVA+Eh42ofJUt BQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmuc9q8vn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 08:06:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AU85klu190877;
        Tue, 30 Nov 2021 08:06:13 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2048.outbound.protection.outlook.com [104.47.51.48])
        by userp3030.oracle.com with ESMTP id 3ck9sy1cuu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 08:06:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LD7jlprDcQdHBJGC4ERf0nGsv+7DCvN9lEyyX8yOeculo0szbdBgNOfkNzqE8BDS5O6Ef1152rJI5ydrgwrYlQXxuEWxwvP2kP9cIM3tpCs3pnohsc48z+nrWHW7ELpa+IWaFZjPz6p5TSFrC4mLWJrvgSQX9ljyFXiuqfX4G8obzp6EOzVHd9yetVUfidmoMKYVlOoxv7Fg8JhHYpx++zs82KtHsMPjmiBJaZV8pyo3aFSN/w6rqJEX3ZAdi2hZ6C13TGXaIijxUQTvV0W6Prqt8LCB1eFyd9Z4Eima4QluDRCCQzqPRnY67G1bxjpaV4Zj73eFcSFMc78hL3Qcdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySk8VI5umvW/pkOsk8jOixBL8kSiFNqv1h5QcG4GzHM=;
 b=K6FLLEWxewi/oNmMalAJC0/f7Bbvbs1iVc9TVgnjZABTCY1InXDZLdYnDK94eiQO0UPob5lihn3Fkrg26jZ6NLRNtTL4Ga9SpfOr1yU7AQumvAm7ecc9a2uq/eUKgVSfL27+o9QkG3/Tl84/6bUkY0M4on9+DQW/4cVwb/Pu2Sj0jR/IqduJZdVe1+g3ajX4gE3xnldRV4TfusjLvKFXAooVkZf5AWdTqDMLFkkNn8w0TS5/qWqoa6pkaks5V53hlfb3K1fXax9OB6fLDATX8gPjOj1RK/Bi1Ivecj/Uxl7dwfHmh3GovhS7r5aWpp1URSm/udQfUlNNi+GIMhmGVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySk8VI5umvW/pkOsk8jOixBL8kSiFNqv1h5QcG4GzHM=;
 b=rGYPzIXD5/Erhy69WRDEEu/5NDPAd+wx+UmjGFMmv7q5Mjlvql0iY3kEto8TLRHbntciPo4NNq6Q7SB609t8i9A7ZxzGJlvAvGd9G2/QZSA+pEXV9RobLMJ11rU9PHCzLpjhiH52ivt1OX2kgx59RFa8m0MSEKG64bDmvZZpdG4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1294.namprd10.prod.outlook.com
 (2603:10b6:300:20::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 08:06:11 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 08:06:11 +0000
Date:   Tue, 30 Nov 2021 11:05:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Hans de Goede <hdegoede@redhat.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [pdx86-platform-drivers-x86:for-next 31/36]
 drivers/platform/x86/thinkpad_acpi.c:11154 thinkpad_acpi_module_exit()
 error: don't call input_free_device() after input_unregister_device()
Message-ID: <202111292341.pt8nIc7T-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0010.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0010.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Tue, 30 Nov 2021 08:06:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76e4b0e1-d49b-4c8d-dbf5-08d9b3d8454d
X-MS-TrafficTypeDiagnostic: MWHPR10MB1294:
X-Microsoft-Antispam-PRVS: <MWHPR10MB129477DC25FC3DF3D25C8F5C8E679@MWHPR10MB1294.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:146;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zjSecIn7LBOX8lRGJL6hSjSGN5kEZ1jCnLtUrcA5FdGhtXTGknZIPU6LvPc0ydHXMcdU0znBk1ZScwdObPuJ1TlpkRNlASH8YOYqEPZTKrgIjEh2G82pEgYqqB66baYBicUUgZF/wf2qaz+rDbsGhAsWmJ5lF01+n5UriqFnivQ2nIRJRKUb7pCDcyBlk3Xsdkpe621asxgFe1Iy82rHsPIwtNGBwYvKBuEd3Czw/rtFnnzx+A68PrL/+cxab8FyB2TdjkQH4s9SmPLMEmikFQyq+ONIwMDgpwdcORrd9fcfI8D13v7Fc4YrHVsJpHmj1w+N3vglH/iYtxFzUII4QQGkEaH/DmvRja7jn0+ELKd4Iu2xLI3RxTpH8ZFUsjjWwrskDKQz9VglwT6EPJg/mIWZ+r/DlhpBYWDdVHZ+RNBJLFL3QVVe6kr/BusX1+XvF1DN8DjT5BHvmwuV3KyrK+5Nkk5kD0y6ExdEZCV1x1NayW7Ft1Zt5tXuYae/Br7gNzJPvPL+Ow2PNIfxKmKiJE1+z3XAKv1VxPeTn53V+d57LmRPVpobFWLyC8fmhskOmPa9cD8/V3yaejB4oVD6tSAQqnr+6+MyF7m1fTs9jzuWpGQdd1FYDGZf8jUqtIvyyzkh2ErT3OQzypriCfj35E0mSB0MvoJYYygB919STFxsPDmKoZAn4satJyOaBujEI1ABSZ5PpAtsuu+P66CWRygAwI7gnw/P2alBAwzZND8HNewVNIjJnk1wzuhfeygd2ShgRorFPijubrrwuxBVramcbv1wvs2yQD4uzDmYHV2fO6DSulp2ref+y//AnWvvKqbJi08ZqSUbea2sEbuAlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(966005)(44832011)(4326008)(36756003)(508600001)(66476007)(66946007)(54906003)(26005)(52116002)(38350700002)(6666004)(1076003)(86362001)(5660300002)(6496006)(6916009)(186003)(66556008)(8936002)(8676002)(4001150100001)(2906002)(316002)(83380400001)(6486002)(9686003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7LewBKArK7nKDTLAUbDalruWP0dWlYfCLU6F20AX9edCi6yCsSLBTomS2/hG?=
 =?us-ascii?Q?QQSMCEOIgDMD3XGulgA7LCnBHp8usmQ5BAGvx2HkAX+irmy1yGrikDIUPJCk?=
 =?us-ascii?Q?WYhiiT4MIKKoFwNqfMlDh1VVS3fc0pjz4ktzMWXRFzbMNZ9RcptdoG+ISDAR?=
 =?us-ascii?Q?AcY7MCiN260GnIZLvZfRZjZZUPoRWe7LtBb0locPG0POt1jHWfKFDG1qvWKQ?=
 =?us-ascii?Q?OaYq/+4Y+2JLRsgxvmkJ7l+c0byRZZJodWNWBl0DU68cxz+WuCEl7BL3pxOO?=
 =?us-ascii?Q?Fo0LFPN81lefKGXvEIpwEzPPsgXMtoZxMcWLlmitJOGN4+Zu7TMNj+m4OpVf?=
 =?us-ascii?Q?qk/QjOK571CZG1LS6faKYsUYBHioNG+8kP5hhGKVWs/QpFHoqklK8szl0Jt4?=
 =?us-ascii?Q?vOQ21fzEo9KayJvP4SeVONp2y6ODfultJSI8nPzgXvEcuzaiQzC5ePZB5n9d?=
 =?us-ascii?Q?THhWcQubGlk3UVy6FKUYP8RSMaMnGURdiUQvfw4XLUqvFWD76Q1XVdJ/nwY8?=
 =?us-ascii?Q?QhJ4k+Yy6J/1Qyk2AZcPZR9lOL36VeU8IqGMOMqghi6Xsz70sL4tB9X5RAVw?=
 =?us-ascii?Q?4l2EVCla7SC8yJlss2RdlJcm0sMva2qp2klRdLvZvHl3ptNvbsnL2DhTT79P?=
 =?us-ascii?Q?3hRlIKOYYlySviBsXvaCt5PUQKMov4nNWedDNKiBSqLMwrRLjTzAQX7GWiAy?=
 =?us-ascii?Q?SSc+4/WirYZ++lKVZyvrpGjvu+OETHZPJYVhptrhbpwD76T083312apX+dV0?=
 =?us-ascii?Q?5zBVUH9q/Awq/8vq4PVIS5cHruq8Flma4koyoG0m9JBtEfsDBYr7WuqgjXDX?=
 =?us-ascii?Q?U0Pg84VmkScfSD8mTupePswwCJOaWa4CEJxJVd08g1pghskk8BT9sCqW6MFr?=
 =?us-ascii?Q?xctfqYZnYIvoI7gnGILBZy61udm3f5dvg0Bef+CXbDRJqy3YKMN97bfbkSqZ?=
 =?us-ascii?Q?YSO4euVpIafYB0Jqe2l99T+f5Y77FR82A0gtyukQlhxMWf/PEbGVC9v4eJmU?=
 =?us-ascii?Q?G8MDaKSvHt1aKJuFCamb4Kah2WFoVmTBpa1b3oooEU2Hjwk0K7MipM2LxXuX?=
 =?us-ascii?Q?c6XY1WiCzuclOwWOsC8D4oOOC3KEH8/M+7vt3UCzczSOIX2JhWkNKttkf8cG?=
 =?us-ascii?Q?vEGJC3MccdxYC3lxohKbsnGfPwbmEbqFu8f077DJBIRKSkU89Z7VLwfAiJXT?=
 =?us-ascii?Q?RsW4LqzTZbzWn9D1dmlH2g7YJzqoq4k0+lFNgdssyqBuHmk4PdLzjtqgXiA0?=
 =?us-ascii?Q?D9WwNJrGPMT6C1umKGrGJpucxz0Zde+07hcB/h407aSJxPE+U0YhQEHNJDbJ?=
 =?us-ascii?Q?pg7GiTQezs9xvV+OSoo0gBDTdOoVCv+DtVGhhahJ9R+3v4cedBDiXrsUCqfh?=
 =?us-ascii?Q?hpGqOp+DxJ19/4+SMM71tMHxy27XPDp/Zh7lM2tQlEgfdmNtKuXRmKfiVxrz?=
 =?us-ascii?Q?s+a7b9A667jto4XVoR3CNk7OA5tyfC7Tn54193zLoG16snOJWpDIa64zi+TL?=
 =?us-ascii?Q?aDdu1qUuIL9zGzW/mQ/5O82uTpWydlu01Ou3qb4PjY3YEhGueR+SVwzW3J9W?=
 =?us-ascii?Q?GQq3wKjlH3vH2Ef/zFvm6szXWlHJFxDCw4HrMpyppgNFxq3boNPuicq1s1LT?=
 =?us-ascii?Q?8N7y3RNPhNRwTeOz+IuHjt2uHrJE59d/4MalzGltLF9H7NFfeE71aFHsKhuD?=
 =?us-ascii?Q?gssOxgy4ibuRv/mwcCKx3v58db4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e4b0e1-d49b-4c8d-dbf5-08d9b3d8454d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 08:06:10.9922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tp2qSSoNXUI0fs+T6Vqz9Q4rritvedE+l5Paf8Z8AEt0UDf9ql8MWpooI8hB/gBqeyFkFwbis3P7MJzfxpdslXQGHwpJVVEQ+G9U/F4c9fk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1294
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111300046
X-Proofpoint-GUID: Rmb3DzdJljnMxwG9ml6UmgME7ak-GwFs
X-Proofpoint-ORIG-GUID: Rmb3DzdJljnMxwG9ml6UmgME7ak-GwFs
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git for-next
head:   e9ff190973df2c417c2a97a8b70e709e0bdc2716
commit: 67e7d50d13e94abeaf82e9945dce929352771b94 [31/36] platform/x86: thinkpad_acpi: Move input_unregister_device() to the top of thinkpad_acpi_module_exit()
config: i386-randconfig-m021-20211129 (https://download.01.org/0day-ci/archive/20211129/202111292341.pt8nIc7T-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/platform/x86/thinkpad_acpi.c:11154 thinkpad_acpi_module_exit() error: don't call input_free_device() after input_unregister_device()

vim +11154 drivers/platform/x86/thinkpad_acpi.c

b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11130  static void thinkpad_acpi_module_exit(void)
b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11131  {
b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11132  	struct ibm_struct *ibm, *itmp;
b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11133  
b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11134  	tpacpi_lifecycle = TPACPI_LIFE_EXITING;
b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11135  
67e7d50d13e94ab drivers/platform/x86/thinkpad_acpi.c Hans de Goede               2021-11-23  11136  	if (tp_features.input_device_registered)
67e7d50d13e94ab drivers/platform/x86/thinkpad_acpi.c Hans de Goede               2021-11-23  11137  		input_unregister_device(tpacpi_inputdev);
                                                                                                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

526ac103dbc6729 drivers/platform/x86/thinkpad_acpi.c Hans de Goede               2021-11-23  11138  	if (tpacpi_hwmon)
526ac103dbc6729 drivers/platform/x86/thinkpad_acpi.c Hans de Goede               2021-11-23  11139  		hwmon_device_unregister(tpacpi_hwmon);
2f5ad08f3eec8d4 drivers/platform/x86/thinkpad_acpi.c Hans de Goede               2021-11-23  11140  	if (tp_features.sensors_pdrv_registered)
2f5ad08f3eec8d4 drivers/platform/x86/thinkpad_acpi.c Hans de Goede               2021-11-23  11141  		platform_driver_unregister(&tpacpi_hwmon_pdriver);
2f5ad08f3eec8d4 drivers/platform/x86/thinkpad_acpi.c Hans de Goede               2021-11-23  11142  	if (tp_features.platform_drv_registered)
2f5ad08f3eec8d4 drivers/platform/x86/thinkpad_acpi.c Hans de Goede               2021-11-23  11143  		platform_driver_unregister(&tpacpi_pdriver);
2f5ad08f3eec8d4 drivers/platform/x86/thinkpad_acpi.c Hans de Goede               2021-11-23  11144  
b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11145  	list_for_each_entry_safe_reverse(ibm, itmp,
b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11146  					 &tpacpi_all_drivers,
b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11147  					 all_drivers) {
b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11148  		ibm_exit(ibm);
b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11149  	}
b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11150  
b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11151  	dbg_printk(TPACPI_DBG_INIT, "finished subdriver exit path...\n");
b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11152  
67e7d50d13e94ab drivers/platform/x86/thinkpad_acpi.c Hans de Goede               2021-11-23  11153  	if (tpacpi_inputdev)
b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08 @11154  		input_free_device(tpacpi_inputdev);
                                                                                                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
I haven't seen this warning in a long time, so I forget why it exists.
But apparently it's against the rules.  :P

b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11155  	if (tpacpi_sensors_pdev)
b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11156  		platform_device_unregister(tpacpi_sensors_pdev);
b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11157  	if (tpacpi_pdev)
b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11158  		platform_device_unregister(tpacpi_pdev);
b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11159  	if (proc_dir)
e0c7dfe70170cce drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11160  		remove_proc_entry(TPACPI_PROC_DIR, acpi_root_dir);
e0e3c0615abdb1c drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-04-26  11161  	if (tpacpi_wq)
e0e3c0615abdb1c drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-04-26  11162  		destroy_workqueue(tpacpi_wq);
e0e3c0615abdb1c drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-04-26  11163  
b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11164  	kfree(thinkpad_id.bios_version_str);
b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11165  	kfree(thinkpad_id.ec_version_str);
b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11166  	kfree(thinkpad_id.model_str);
d2be15bdda45b18 drivers/platform/x86/thinkpad_acpi.c Li Dongyang                 2012-07-25  11167  	kfree(thinkpad_id.nummodel_str);
b21a15f6d065e83 drivers/misc/thinkpad_acpi.c         Henrique de Moraes Holschuh 2008-01-08  11168  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

