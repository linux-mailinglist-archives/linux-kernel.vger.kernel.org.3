Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B6848D24B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 07:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbiAMGUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 01:20:32 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:58558 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231205AbiAMGUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 01:20:31 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20D0g3wt011338;
        Thu, 13 Jan 2022 06:20:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=BEwW4yqu3OI0VUqzaf0+pywZxDcpJ68FG1d4FTJ62js=;
 b=M0noURs7EGTIcbKUyGCJajOJ7pfeedQS3LRSzMeB8bA+rtsgAYKeUZ/EsXBKhh4vwJnH
 5n1WvBlt9ScYlMMjECNftsxIkslIVPIxwHAlElhCU7ZQNpSjw0Hhl0HYqgI5AkypIvdL
 URVWj23807hSaxfO1BINCbyogHYfLDlvWXdH5fN1sHj/dNsfkYORxKmfgvdA+XPHWiF4
 4bG4M8k6bgEUGuFWfpabocnOomRRXfe3Jisib93nTwDHxW7EjJepOzhr05trwr0SODj1
 ySzKln2fa+XRD9vGeJQZFDrUOIgD1AnPIy+fRIoGv9XwxwsC5fbK51CGHZ7+EuFCfhw0 Gg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgn74g4cd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 06:20:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20D6C5QI054291;
        Thu, 13 Jan 2022 06:20:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by aserp3020.oracle.com with ESMTP id 3df2e7d8p5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 06:20:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOJwBkTSDSN43SqI3joeAXTJisVmeumiC7EIH/nORMk9/j2B0Mk/mATmWpSuqfj/lI+37rRoTOzZfhKFvLrhZ1MNXydYs4CRiNhD7XRkb92MG83RNwdnxCBOZFR2p/VWNPLVUeg+qIMkVdDAWeCnb1iI/JYfXxDh7SqBLAMyZ+LZ54csUfa3NcWvS6Yrccnexurng2g8h1RBlpO3DMhwZ4puZD6p7lrKGpvT3Fr2DTKQzYCL+7sYx3MQ58WnPknw9nrLtdZjmyEivFZRXLpHPWcV6CwyD6H4Y3aeJyyhbTcx52FbC6KG+4oOjb8M8d4rQxWvZs8almRzwRGsBwJT1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEwW4yqu3OI0VUqzaf0+pywZxDcpJ68FG1d4FTJ62js=;
 b=Rtn4JMLStQn/+89eCNbpdx4wSROTxu5hWN6JAuJJ/UCiDFqEOvUO+HAdNcsVBcuROJ1u4p4tF+zqqPISphQ1x8yVtXBAqOLGXoPEaFf/nqqQcOC16zd34TeiFhGcYxgEcKjY4ZUobkK0/WUU4Um6S/LZFJAwBVzMoDCHzygsjfAj/hg4OWVZrOzDRVzioniwE90WCgJmfSxYmmUtiD4lpxbWaUuWpDJ8SNteyokK6hfQD/4J5gNnVnuK0F5EMO3aH6zlPqt+vlaVysAu4nblzwqlYWtnK1/fruOjmyfMdjk9l3ZqGMmvjll4e07V93ADvNeIB6/sCMwtnnNlV9Jghg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEwW4yqu3OI0VUqzaf0+pywZxDcpJ68FG1d4FTJ62js=;
 b=d4p93NV3hIlLb53uJcS2AZMj4v+Q9BeWzfCp04/qc6uM2TVWVmKhcIimMqMD8JuT94nnEmWWkkDU0BL4XFEt6Vccby3CjERpdBdFlkyC82FlxRgq+dBFs615sWh2GyimNH1dxciL1nqLcuhLZlTEhK/zrC1LPsMqG5CTpBL4t8M=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5790.namprd10.prod.outlook.com
 (2603:10b6:303:145::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Thu, 13 Jan
 2022 06:20:15 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%5]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 06:20:15 +0000
Date:   Thu, 13 Jan 2022 09:19:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [pinchartl-media:rpi/next/bcm2835-isp 5/49]
 drivers/staging/vc04_services/vc-sm-cma/vc_sm.c:130 get_kernel_id() warn:
 sleeping in atomic context
Message-ID: <202201130306.YgzUxxgI-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0027.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cefad65-ef58-4e74-4f1f-08d9d65cc339
X-MS-TrafficTypeDiagnostic: CO6PR10MB5790:EE_
X-Microsoft-Antispam-PRVS: <CO6PR10MB5790C81361915A21FDF36F8D8E539@CO6PR10MB5790.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:234;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: coK+CIk/MO+8oTxeeQNO4j9szcDcrcHnGEVUL8PD0L3ehZ3Yatsh7bMZpnTYqm8T16SnjYJRLkratIWfHPpql6OIlblrUoGCTf5YRvEit1q/BREhKmIj0uYvQC3A2Kt4tUKxZaDxB/1zGOw6zRc8ZLzzxLljCcRzN57wpOd30MMKI6+jhZEwWftl5qMNA9imxf+ju3TeiZHct/qRUUFfFREs3nwpIft+sQGkHsJPV2MhrUtUHEyQdUs/Ny4Z/a8LpOKnk53awsgm4digZSq3gFyCSJfSje155tvr+3M5/sMHPS+0Zu+JpnVEDhaaBNWdofRCCEscYBsmBaF2JvKyF3M6juNhkllvGWu1cEMtmYXlN6v1lf5+9mF0eWIgJmrsLriIERxbn3BbmXgD4EoKu807CYG5ee4slpS885tMIrdaw+ehEOPuE/HR1+Rlj2BQYI/NqQ/MlD1Ou6DEwkHVjgXjQeabDAdewDWMfyVO6EXmollfx03Z+Rl3v8WScV2ti46zVYSPplQ53UnOa0+Rsapdi0nglvn2dBFAhpFn8DARlzVVUiJTCHd+xDAcVgyJMa7+d/QEk51kkJb1xG5M9xR7dM3TY8hBDzYRWRecmG6YFcfR4XKlUSLEedIfzDD7wBBF7dAqqBn9hs4b5hvbsfn38TEbd9d/DLjVPvzWB5Ubs+s3DXEJfVje27pMPf+ou911rJVbYBoEU9JVRv49LsrEMsM0qV7E+rD3LyD2Zxs9V2u+QZfYvW+JJyPowSHI7vH3PXGn27bPD1vEhtIAnYrplrr94pAwA+j44vavDCrrsFRUwXMtGz94F/5EJHrPOGXHeTrlhxSwGPmP5zvdrw7jCgZmYUtvL995BXKEJ6g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(9686003)(8676002)(6512007)(6916009)(6486002)(83380400001)(6506007)(4326008)(44832011)(66476007)(66946007)(66556008)(5660300002)(38350700002)(36756003)(8936002)(1076003)(6666004)(38100700002)(966005)(508600001)(86362001)(52116002)(2906002)(26005)(316002)(186003)(127773001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5fWjexSlhzYp1VG821nKQDXMYqJWf/U1dLEmDRZtwPk39bciUlCa5utU4HSH?=
 =?us-ascii?Q?zVIFyvKEvQWAxOQp80uyCNIn3YFGM2/OKfGm355ApgmsXfQTIdxVOf/5YR/V?=
 =?us-ascii?Q?3vhbWpoeIY91eEHcLt0RFXb0jh9OmVqfzNA6HI6PAL0D9yHAmY62zCKlMXod?=
 =?us-ascii?Q?tJI2jt0ApikfbVzqQlLgExLoKYfcj+Hdh2A1Sy+U1hMAsgjojokXsW5jRr50?=
 =?us-ascii?Q?yG9SISU8KRvJhk+Mg8TqNTcYFexkivF5v/4T7KLJy4LRd3w+NXuE9gP8jRbI?=
 =?us-ascii?Q?kDBzMl93htH3x5VLomKOcvBKvdLYuL37S7Pec9Xd1lDJXSSFVURscAIB9Ts+?=
 =?us-ascii?Q?6kwyKd/bk1A7tnL5oXtg7Hp79SA0DQpSQVmlIBsYVddDGHTNPTpxosCexd0G?=
 =?us-ascii?Q?5cU0qvyv66J5sETIQKEBu6gDI7qFJp6JsyJ5eEgUbF9Y3S4yQdzjcSyGX7U9?=
 =?us-ascii?Q?qp+IJQ2BY5R1MwvSg/0+Sn2cK0BQTz3n5BDDBgd1AnF44mhUfl8+7GVJhEFp?=
 =?us-ascii?Q?sK0xBaNVV2L3hoT/Oi58xUTrJqoB1rs+I8Lj8uKS9uxd9jEuHtzKJu1ViJGn?=
 =?us-ascii?Q?6ULyTS2ISq/6LiCDXGxX5B09N++c4TuMiOh0Cq285Kf9V8C5DABarzm6fsxq?=
 =?us-ascii?Q?s5f583XLmqsI0Ievmp8c7elwWwGw2MNubTqIONxxJZ+zl0/N+tmjdDwpipib?=
 =?us-ascii?Q?zBcbKMZXn5iGY/gQ87YD+ZLSjEobEslQiMiseXslzUuDNxWhdp0gi3dAeOYG?=
 =?us-ascii?Q?9qJz2IMQDaGd22ycrx6yrnS8EinowJCR8bpIjzfKDND4s0vSAYRv/1xJqEDe?=
 =?us-ascii?Q?j/l+yUn/Db0qowldqVYr9YqNQ4EJgVXJub8raCqUwxuOKsBaCB6FLMttMbWO?=
 =?us-ascii?Q?QDU1xZKh1RZIla36QopP09N5K1S0AmufmKstl1ZLG2PqLO/yAiC/pyyO1XDh?=
 =?us-ascii?Q?KPuYbdZsl88OD9jZuT3MGEFtP2mCAyyjVatf9hr4kZY4OCS6E+4a2FQyl57i?=
 =?us-ascii?Q?MGntlGLPFxslx6KM/EvqWusZHWWnkl0A4gyAZAGatfIc01203VWHgDXTPXFV?=
 =?us-ascii?Q?ni0ifiIHOu91/74c10Y1e4NA4fPCvzlI+Mw26CDAdxTIBDUh5wPZF4rnz+MF?=
 =?us-ascii?Q?go6k0DlDqfqCmbMe6gq5ZEJ5pwcT2xe6W0r7LKmMNgrAHS9Pw9v+FHXlXMld?=
 =?us-ascii?Q?+HNysAqJl8k3I/7CYVa5645hE1oWaKmYWY0dAE/oZNJuO+Cmf2Ntc/6rIsc1?=
 =?us-ascii?Q?E1VMHAFxsYOMO6t6k3uk9+uaEQM6a+0Br6LKhwkeQArJE+MaGj50DM/RDWMT?=
 =?us-ascii?Q?AoPiZfJ7rKw4AIhk29KQKy5SC62s7rZ5KNZtHaQHmp6sBZ+Y2B2T8dzTQUJa?=
 =?us-ascii?Q?EqqxMKIyVtTj1v0T8nO0y2+76Y4lRaQFdwrj9+m/kKF1zfNX4xUfwPTqx6HU?=
 =?us-ascii?Q?aWCICU0UFCloJ7TaWUHpcmOFGor+OXS1NJAlgkwmpN0L99MY0p2RXdzutt4u?=
 =?us-ascii?Q?Ez18lR/4CZJnocFBFgCQirPfRTJBSrNV46u9f/Yk1pEXNyHxVMS3jliiWmLx?=
 =?us-ascii?Q?U502LLIJMJ3ZWkWFrmYYYfum2z3Q6EN9ujO+N4RHUPkS0oEuQ/tP3Q1xbyaq?=
 =?us-ascii?Q?wrMU4YrUxCqoxPICX31TRjNF/QrdInsvFbscBBeY3AWtz5VtttBdtpBQkvBl?=
 =?us-ascii?Q?Yoj3SQxQcQvzBu1KqgbaiAKuwxk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cefad65-ef58-4e74-4f1f-08d9d65cc339
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 06:20:15.1377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AnN90iRkPRp4gH33UyGagR/l2nvADRYnkT3bsFKrtHzPZ2QEKetRkPIgcrJyIS9IizI/lRxUVm3V7x1E5duyQFMN+qdHgyJ0stkhO1odgYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5790
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10225 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201130033
X-Proofpoint-ORIG-GUID: pQk6WtIVjAuk4gBfo0LWbMauR4Nn6k9L
X-Proofpoint-GUID: pQk6WtIVjAuk4gBfo0LWbMauR4Nn6k9L
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/pinchartl/media.git rpi/next/bcm2835-isp
head:   97975aa0732da0e2084ed69d140656c2162bec05
commit: 0cfa42bcc0795e569f1312e6ef5843c97bd36642 [5/49] staging: vc04_services: Add new vc-sm-cma driver
config: arm-randconfig-m031-20220112 (https://download.01.org/0day-ci/archive/20220113/202201130306.YgzUxxgI-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/staging/vc04_services/vc-sm-cma/vc_sm.c:130 get_kernel_id() warn: sleeping in atomic context
drivers/staging/vc04_services/vc-sm-cma/vc_sm.c:1245 vc_sm_cma_ioctl_alloc() error: we previously assumed 'buffer' could be null (see line 1133)

vim +130 drivers/staging/vc04_services/vc-sm-cma/vc_sm.c

0cfa42bcc0795e Dave Stevenson 2020-10-08  125  static int get_kernel_id(struct vc_sm_buffer *buffer)
0cfa42bcc0795e Dave Stevenson 2020-10-08  126  {
0cfa42bcc0795e Dave Stevenson 2020-10-08  127  	int handle;
0cfa42bcc0795e Dave Stevenson 2020-10-08  128  
0cfa42bcc0795e Dave Stevenson 2020-10-08  129  	spin_lock(&sm_state->kernelid_map_lock);

Takes lock

0cfa42bcc0795e Dave Stevenson 2020-10-08 @130  	handle = idr_alloc(&sm_state->kernelid_map, buffer, 0, 0, GFP_KERNEL);

Presumably GFP_KERNEL can sleep.  Use GFP_ATOMIC?

0cfa42bcc0795e Dave Stevenson 2020-10-08  131  	spin_unlock(&sm_state->kernelid_map_lock);
0cfa42bcc0795e Dave Stevenson 2020-10-08  132  
0cfa42bcc0795e Dave Stevenson 2020-10-08  133  	return handle;
0cfa42bcc0795e Dave Stevenson 2020-10-08  134  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

