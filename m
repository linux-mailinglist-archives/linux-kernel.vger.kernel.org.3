Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6628949E12C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240498AbiA0Le3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:34:29 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55076 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235836AbiA0LeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:34:25 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20RBRhRr022494;
        Thu, 27 Jan 2022 11:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=mWewiBsFRLD8y8lGFBsxtzY9mrklvxWYNhU+hFum1QU=;
 b=dyLasUPdCwIk8HRDCGywEDu2Poa5nJjyhppswq+YjdxaI2SsK2vpBqcIOUibBsiutIiw
 uIKZLw2k3fWv+jWhReqDK215IYAgQPwBseOlxC1LYkBYOmR1tT2LOIBaZ9+Te2pZDByv
 N7KvLJfzjbP1rsLRe8429kqVsA71X1Mj4yG9b1vemRFcHpLvPRrt15In7pJnG125xSzy
 7XTfLl7q4isErLfpW5/TJZcHM/2BDyFBANW6ux4KZ7H17JFCBAGZopdFxQSEpbUda5gK
 Q//zsb07CYTaye1mQNx8jPxvwcuMtRG5HnJBgL03iwBk7vnpnbjgF0hh7vt9mgtPJQFv 3Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsxvfrpep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 11:34:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20RBVNal142444;
        Thu, 27 Jan 2022 11:34:17 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2044.outbound.protection.outlook.com [104.47.74.44])
        by aserp3030.oracle.com with ESMTP id 3dr7ykjvq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 11:34:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5/zhjIVXDrCkIl78H4F/07Udwhm88AjYa9+raqSRS4YtdS+dJXj+o4VR8KNCAmW2kWClUu/6PrDr6nRrya4gl+aQ1axFbDRgZ+27qL0GJNy3wskUWx9hX6kQ2/wU7Q7TXvHk4dizpvPAyPAqN3Szp607s/EWPa+mPDw5JTiWFKebzMNfmDkfB/xIadW2aHwVJyxZo3FjWERUkvqs3sxrYOetOMfkSPSfoLPRAu1vBlTH9vRER8r49+47IfmvasvDs9i6xJLCaCrgxA0fQpbxMpv6q63yfSe63oWL1J8DXsBXHTrE55R+E6DN+Nc6xiQQ1MDvrGjEY4IiEShBhenpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWewiBsFRLD8y8lGFBsxtzY9mrklvxWYNhU+hFum1QU=;
 b=YhhfIybdOUjiF6qM8G6hIH8dBkeJ4pvxKm3y7yO5LRYjq8zvqe2a+1Js4w0qKN0frzKHT3COzY3XZRiUzWKeJYFz+ywMKl0DiyA8qarbk01o8ZAt6HkORV0wrVhpNHnCG0ua8G7Bo4PpUXGUgf8fBepRM7Tye9JVGGimbeP1gqshYYwQle/zlljPD6eUBMNSuNc/Oy9UbJ5vZoqy71YA2B1fLV5j4QQUbsPC/DoU4aNMjCiuM3MDDB2hI/2I757/58Xje4hDXXGn8a9+E9fL35GeYcrE+80bE9+pFHeByn8n7h6rchzIcScdEIhVvZ+SLz9Nn43YliZjm7l2e4O4ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWewiBsFRLD8y8lGFBsxtzY9mrklvxWYNhU+hFum1QU=;
 b=Hs86rd9YBc6qCpNTlDwmA3QJrCSyScsEgo/o9jbeq+RlJVxkltqQcuQ1T7g3YJsstBKlFj9q8XmKc9HmpuJNKP9LhgK0/OwcNlvCQhsmNZmdZjnLb9TV5vGLYwv8C6mlx51IAUZUsmF2lSdXv3Zy8MF94oSclKS0miP5c7sSWNg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB4281.namprd10.prod.outlook.com
 (2603:10b6:5:216::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 11:34:15 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.019; Thu, 27 Jan 2022
 11:34:15 +0000
Date:   Thu, 27 Jan 2022 14:33:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        robh+dt@kernel.org, gregkh@linuxfoundation.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org, devicetree@vger.kernel.org,
        ekangupt@qti.qualcomm.com, bkumar@qti.qualcomm.com,
        linux-kernel@vger.kernel.org, srini@kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 01/12] misc: fastrpc: separate fastrpc device from
 channel context
Message-ID: <202201271857.MGiOkhFo-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126135304.16340-2-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0021.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::12)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 658d0cdc-18aa-45fb-863f-08d9e188f29a
X-MS-TrafficTypeDiagnostic: DM6PR10MB4281:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB428103B84AE462EE8D5218608E219@DM6PR10MB4281.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mhKVCQ2me9jQ/5ndl6khANVPgFO1FamyYQam5nNo5DZAhWuwauw65BDscPHAqJFdj8YZ5vXxz4L2Wjc6dt8LtIiFDDsfQI98m3aOvF9onu3+zUbaQJime11cm4E+SsIYYVrKPJhHlCXDa6JzHC2AMI0qf8MkZnpjCuO1fewJLGIhWzClBirGQY10GDfeeDksRjKtTCa+WxfOTc5F7VzbE6tOSKAlt/dumKhu2fs1dyI1nfjkTAJCni7mBQsGqCotP8ySIYEjUlCAQeJwpc0YbM5nLsgnyBQjPHkF01IaZZuRwRIlo8fXmCWaAHh3Q8VrFGzd3h5VBGINM255MisERGvn8aVHdZCXE9qZZRxKT3i4oYH6klhkHkpZuIDuHkPpdyk0h89TTd5cpeXZMkbjJXLh41rfe8htBLgKAB7kPp5ZAMyRzqnadZGq131eKSNRv6UmUtqIJRLY3sfHDxIHhLKYIqQ/PoEOGDm9xduv3VKXeP8MhaVgFSVLeaKakNhjV0NXjTDhxRLyRei4A6FFqWPL9owCL9C76pqh5y+JLSUof3+Wo4x96jRFqS/2jTS0jyHjUloEwEN9BhI+AlljorFsS7UGg05sBlmtqEPcsYMmbSaTHxAig5Ve6bnsg7uGLi7kU9tKkHSVdrEzAu1tWuWOnnv5Qi9f7JZZhjoahA3l4V0vlUmV1SZpWEtA8ANInEUuIGi76qoAorbb0L7+UDRL2RUBTnhVO5Qpht32BzHYvTxSAZm3AXoHFwwLL1SycDdBUS+Pu6as6yrJBCzTYMrgphsrQ+CI4WCxCCQ5QlIWlnFIGDrggaRFzXF0bq/eg6vCnXE2H52mX9sicyOB5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(966005)(508600001)(7416002)(66556008)(5660300002)(38100700002)(38350700002)(86362001)(66946007)(44832011)(66476007)(316002)(2906002)(8676002)(8936002)(4326008)(83380400001)(26005)(186003)(1076003)(6666004)(36756003)(52116002)(6512007)(9686003)(6506007)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sf+4P1ad/4PfKMPPK0B2B3gLTrIGOr1RuZWgAEYMzQ+zKRx1Ru0wd1bcY4Lz?=
 =?us-ascii?Q?k1jHv8A9Ub5KNFDp+hqrLHvKR5l6iwVJ6hTzgh1NEmFqBozvbFLCEHgo46+W?=
 =?us-ascii?Q?WYnNYHJ7FEL3Izi+gFrxy/ENPYjJO78wfa4mxpnUmGeMp/zpbI+E1xFfM3EJ?=
 =?us-ascii?Q?sYhpLbGliSMSXrg0ewC2JdlbxD95fzy5mOiRGXinGegn+Eezxa683BU7ycrk?=
 =?us-ascii?Q?N5R86BHMmy13c8CWJ/2HFu83oOjy41fYDJspu84agZUXNG6h0MUdgYH9qer6?=
 =?us-ascii?Q?Ckdg/q10eTzWwMdebO4xccCRo+UsLRv9KpIcEdFKucss5XRvts9Dic4xGd0x?=
 =?us-ascii?Q?nrUXtmV5JUfJwSwFVHYYy5ZgD2vwiySP1z8N/EtsnQSQ56hWiwOuAGm6OFY/?=
 =?us-ascii?Q?yEVTHenIMrfM+bI93fr5iwUX6t/N/X2WwBMx0rPIoqwm9fjHgiGI/2DMZ8VU?=
 =?us-ascii?Q?3QWWW9CAYCgYypoY6MDKLCaZGl27R2NPsojxdpCu4bMFynW8jRGu/b+7JMrS?=
 =?us-ascii?Q?8KECVNsCey1yDJuvw4rez39T3V9BzeVSSI6AYQi1RkGJuN/vekrPWGa6mle2?=
 =?us-ascii?Q?pXv0rYT3malasrzzeRiPZvviVaGfa0iikVyTnX8R9wx01k2zL2dAza/MrhS3?=
 =?us-ascii?Q?OgAzNj20cg40ojxcIo8ip8RSIzJ3T+XtQVvb+woHW1LbsCfEqo9YraHgHZC5?=
 =?us-ascii?Q?kcYHG2gQfe9D62YD1fPPrT8Huv3aqkLM0JLfFfLcHoJuJ25nGizCLqBErHSc?=
 =?us-ascii?Q?w2861LJ4AGTca1IMCQJY6VbfukKPpzhNaOCz8P8+vp2tYaeZ45EoPfYo9vXo?=
 =?us-ascii?Q?PUIDpXjSOEnTZB3NtKibGJe374ZPq6QBcdhcKAZ1C0k0yB9QlL5GSWn6OITf?=
 =?us-ascii?Q?D0a8yoc6f7VczHJl9LNc0U3y4vEmmaYlh6GLMH4bqeUCmnLSe7Mj6ycpLu+i?=
 =?us-ascii?Q?DuyaRIkSXQ0oe8Bhh+5FQcSRy/Pm+C6kXetEPxTsXOfko35rmFtakFvPaUgc?=
 =?us-ascii?Q?s1e99JH69B/CNNNPEZ/DDJMvmMJrrnuyOym+JjqNg2fgj4wtjZRsNoIdM/58?=
 =?us-ascii?Q?eABex9BMqiYwBOJBdAnKJQTDJnlrhMsy1M/HFLoZ7aqRHRghOu0rpGF8riGK?=
 =?us-ascii?Q?yTEpgrrW8LsVXMCkAfJcsi9MCenTE3+uv+jrkBDd+uX3cni4Qpdq6yiAYjc0?=
 =?us-ascii?Q?yzRDNYQBdkFNGaymndLDs/ootYzFgAtRfcxBBszdBZw03tNLUT8laiA8zElO?=
 =?us-ascii?Q?wmBAD8+Q9qMT1uFDlcxcnx7CvzqXCz5E23sDGz1ZN+g86Dqn4AB8vPNOQaoY?=
 =?us-ascii?Q?SWdSG/z6NgHRu6q9bQXdStysavi3Gb8ExMSvevfgwQKewKDHztPOZ37ZiyvA?=
 =?us-ascii?Q?vr9+EZHN3UnNwShOavdqI/7exfNKu2Yljja/EWCm7NezoCavnEi6OsOPHV91?=
 =?us-ascii?Q?JC1q4oXzIM74w05lBDoPF6lER9VjiHpMSkv2QPem8l3O5XUK3kpfTQ37yBOA?=
 =?us-ascii?Q?Humdgu6i9ldfdeAmhgr1YLVOlKb8Wq00OQ2AR5xEpi8yia0J1BLwGk9LoQbp?=
 =?us-ascii?Q?1twHAXGJpaZ0zHTYXiJYXxYC5nNyVEAxcwXSr3YWDVGDlWf3j+qIvKddjFPe?=
 =?us-ascii?Q?ZwgGD1Yq0Fm4xdtJhD4oU/ZjkxHImWGIdA+vMFcRHP2wpgeuV265YYudtkU6?=
 =?us-ascii?Q?3CTdJw7b/zj1L6M5iRbhn10LVRo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 658d0cdc-18aa-45fb-863f-08d9e188f29a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 11:34:15.4150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9Nar5Wievufr/xoeMENZd36hKs9Lf8gBFK8+G2KrimLez7yN2npkmy+5NY2/UxPAS2fe28lGZgMt7FKyuI1GyfNNQGGMPoM3i9xfmMogvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4281
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201270070
X-Proofpoint-GUID: 792luorSvMCfHdA5FXNAdWze0d36scVl
X-Proofpoint-ORIG-GUID: 792luorSvMCfHdA5FXNAdWze0d36scVl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

url:    https://github.com/0day-ci/linux/commits/Srinivas-Kandagatla/misc-fastrpc-Add-missing-DSP-FastRPC-features/20220126-215705
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 515a2f507491e7c3818e74ef4f4e088c1fecb190
config: openrisc-randconfig-m031-20220124 (https://download.01.org/0day-ci/archive/20220127/202201271857.MGiOkhFo-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/misc/fastrpc.c:1636 fastrpc_device_register() warn: passing devm_ allocated variable to kfree. 'fdev'

vim +/fdev +1636 drivers/misc/fastrpc.c

99d9d7a1c5f2dae Srinivas Kandagatla 2022-01-26  1620  static int fastrpc_device_register(struct device *dev, struct fastrpc_channel_ctx *cctx,
99d9d7a1c5f2dae Srinivas Kandagatla 2022-01-26  1621  				   const char *domain)
99d9d7a1c5f2dae Srinivas Kandagatla 2022-01-26  1622  {
99d9d7a1c5f2dae Srinivas Kandagatla 2022-01-26  1623  	struct fastrpc_device *fdev;
99d9d7a1c5f2dae Srinivas Kandagatla 2022-01-26  1624  	int err;
99d9d7a1c5f2dae Srinivas Kandagatla 2022-01-26  1625  
99d9d7a1c5f2dae Srinivas Kandagatla 2022-01-26  1626  	fdev = devm_kzalloc(dev, sizeof(*fdev), GFP_KERNEL);
                                                        ^^^^^^^^^^^^^^^^^^^

99d9d7a1c5f2dae Srinivas Kandagatla 2022-01-26  1627  	if (!fdev)
99d9d7a1c5f2dae Srinivas Kandagatla 2022-01-26  1628  		return -ENOMEM;
99d9d7a1c5f2dae Srinivas Kandagatla 2022-01-26  1629  
99d9d7a1c5f2dae Srinivas Kandagatla 2022-01-26  1630  	fdev->cctx = cctx;
99d9d7a1c5f2dae Srinivas Kandagatla 2022-01-26  1631  	fdev->miscdev.minor = MISC_DYNAMIC_MINOR;
99d9d7a1c5f2dae Srinivas Kandagatla 2022-01-26  1632  	fdev->miscdev.fops = &fastrpc_fops;
99d9d7a1c5f2dae Srinivas Kandagatla 2022-01-26  1633  	fdev->miscdev.name = devm_kasprintf(dev, GFP_KERNEL, "fastrpc-%s", domain);
99d9d7a1c5f2dae Srinivas Kandagatla 2022-01-26  1634  	err = misc_register(&fdev->miscdev);
99d9d7a1c5f2dae Srinivas Kandagatla 2022-01-26  1635  	if (err)
99d9d7a1c5f2dae Srinivas Kandagatla 2022-01-26 @1636  		kfree(fdev);
                                                                ^^^^^^^^^^^
Double free

99d9d7a1c5f2dae Srinivas Kandagatla 2022-01-26  1637  	else
99d9d7a1c5f2dae Srinivas Kandagatla 2022-01-26  1638  		cctx->fdevice = fdev;
99d9d7a1c5f2dae Srinivas Kandagatla 2022-01-26  1639  
99d9d7a1c5f2dae Srinivas Kandagatla 2022-01-26  1640  	return err;
99d9d7a1c5f2dae Srinivas Kandagatla 2022-01-26  1641  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

