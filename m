Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE0D4631CB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 12:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbhK3LIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 06:08:16 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:52716 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236591AbhK3LIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 06:08:15 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AUB4fnm009060;
        Tue, 30 Nov 2021 11:04:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=tSEJ8frxIpXbnHDXRlcGVab2Ab33tEEPXEeqbgOySYg=;
 b=07FQuhQyoopSv2D1GdjMB1zbi67K4UyeAVKhGoJQItA4cOw/XeKBsl+nv1IDPMWEKXjt
 qKlRa1qM9oFb6u48GRtKm74ev+nQAwfKlFsA1eeuAiAL+CPjJTiLv74eBFvpfD9JCLAH
 x/FbJNGUmjR6vnvJUmxKKchoIajZooZJPp0f6naGx/K1fXotibSmANNtgVoUzqjOh/rE
 ENjX8J5N/2s1Um1to1Jnbj1LykT+nSuvGR0uYMX0xZc0QlPUZtQ9eChu1M010WcEpx8s
 uhwIZqSaC18KQyfqbwkgVcf/StoNbGdUZOir7no/IB8lLTE7ENtSalC2CXErOKggnjnl Yg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmuc9r858-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 11:04:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AUB1dOw013101;
        Tue, 30 Nov 2021 11:04:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by aserp3030.oracle.com with ESMTP id 3ckaqefd10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 11:04:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgNoYg+bCeJaYYRJ/EK3PxrEzA+XCRpBSYyPCt+w/FsKs7DVs3l3CK1IM9hmN5lc6I8uVPjr49wrxoWNXZbE6Ls1DMMbX9c4SK8R77FDlEnHQSiA7KpDTXnaJfV3bgE3fXa/vmRF+8INziaR1O7X/N2Q+NA+0lr3nIsUXCJ/IB+yq8Z7KjW52f1gHeby/SVhqsx/+xdisSzXJwbnnVXsL+oPLQGgtmmKWl5ILvD0SJQuecgroOjZSiPLv4dYmoN0driDBr241z9/eufyH/iwiyYncx/KJWZmWP66HiVCJ0yUWbYuJFNeR2SpF41FOGAot9MYefHjCNJsPWH/ADjNtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSEJ8frxIpXbnHDXRlcGVab2Ab33tEEPXEeqbgOySYg=;
 b=dHDzvUvXuAF08QrUz8Yp+UIugWFPWxbZtDOULPS8SY0xpwMduvBgvlOaWWf2ByLOm0JbngixrEqIME31TfsfxwL9epbFdZdxiXBhe4NFb2w3L8IcxQynJTdwLQ0CoPYC2zZzaj291yJbRCIWg1LKcqkb6qK+1C1vD0PLbkdfOsWg3ZGMnKoXtzOkfCtcK7tzVMJuQUGYPm3c9O67/o/kN6PGhV7mq/pbGyNs2DbbZ6o8adgYIlGL+LzIJ+XEl2FeXSqZLmPcoLF016fIcAioLqAbqAHS/VO3v+D2PkoCUsFZQXLSlUtBcRScqWweGcIyWV8T5colwtWtECUE1HVx3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSEJ8frxIpXbnHDXRlcGVab2Ab33tEEPXEeqbgOySYg=;
 b=xEKkIB3y0zxMm+6oD3FNBC8IeEqhuGZWdaptahqJeZOpxDOcB0VNQ/EUQnS3LQNWFDwEmuxBoO1fNFfwpwjshJQihvyrZAtuSaikvr4l/dvnX0HVCEI3vECLexNEzzHGyRcRHIa7esL2RMfqFIgLrt67huruOXbpqrS+/X/WE6I=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW5PR10MB5666.namprd10.prod.outlook.com
 (2603:10b6:303:19b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Tue, 30 Nov
 2021 11:04:39 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 11:04:39 +0000
Date:   Tue, 30 Nov 2021 14:04:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Luca Ceresoli <luca@lucaceresoli.net>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: drivers/pci/controller/dwc/pci-dra7xx.c:864 dra7xx_pcie_probe()
 warn: 'dra7xx->clk' not released on lines: 759.
Message-ID: <202111301803.NOwoj4Jd-lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0038.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::26)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNXP275CA0038.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Tue, 30 Nov 2021 11:04:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37cf5cfe-3e0a-4ea0-a048-08d9b3f133d2
X-MS-TrafficTypeDiagnostic: MW5PR10MB5666:
X-Microsoft-Antispam-PRVS: <MW5PR10MB5666751BEDCF0ABA57F0B1EA8E679@MW5PR10MB5666.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:94;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uv1/LbskFE+47ZJoLCeGmthdCDFDCKljU1NNhv7DKa+safxgffoM8B58YQWjlTyOFI2fAuqFbsGIvi72+haCM8ouWCWeqb8rpISUVC1ih7LtU88wwQxIQWRvnnuugFEcTptVReHi8VmZaz0n40762S3riafV1qgTHhTmHN5y/xLY0DJgBe3z4gm4NxlTQhm/oJcqTTrcn/b8MdJCnUmCOrqN7PoiXJkYelvHP2rdjDQjVljMD74OnWUvDAmSY11qDIEv3spjkha7WRHaqXS4rMCUhUbogseVVT3gReXj4Z96aF61spNnA+3agYy6XHwx4SkqOAAOraKiCGYP9fbEi9WF1U92Gfaca7fN7W5l2Mkhs5qH7VotsXOUh4kCuxBBcKVx5SmLjSJwK7di1zZB9PWCUsSKtFAA5aqq6y9SoBO13Zuzujb/dHVrDlZWPjx7O5h4FQH30QMx+PUB2yJZ9pP2iYgwu6EhQ2fGuCnvTgRlvFXAJpCMqHd8xJpU5zNyiOf/Sal0GQcmOwSrn8zkWDBtpA4TKZCq9Oqh+6BEfOPyx04U/9aYFscmvIs4LO7ksZ9V2/ucT0vtmMSBdj4AGuTKVPPkkbzztxjvlmKU7ISK4A5ddIclymvNwPb5wfv8+ErhL1jtmK8pYf0ZgNZBVzZW2CcAe6VWMJzGM7JdmrJao6XGQWTL7Uyd4FoVEaBqB+1yEMiLBLYqlY3yfrCFY/IdIQxc5siU2Vo+wKsvn4H8RLBlKL6eJzdN1v9csB4TE6SC7hqkMphbDqA2X/lPpnJRM8O1Ag9oJ4/nMXEIBVYbAa2I/BBoFzs5xB2342/N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(966005)(2906002)(9686003)(6496006)(1076003)(38100700002)(186003)(52116002)(6666004)(44832011)(38350700002)(26005)(66556008)(66476007)(8676002)(5660300002)(316002)(66946007)(6916009)(66574015)(4326008)(4001150100001)(83380400001)(956004)(6486002)(36756003)(86362001)(30864003)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QktqdDJtcElQOTlxQW1xYTBwRTBxOFEvbnNFRVFKSjlNWlk1S1RLZUZ3cm9N?=
 =?utf-8?B?RHhqSVZMM3dyUWFzYStkMVU2bGNScnk1NlFyNjJJL0crUHhobllFRXBaMTVL?=
 =?utf-8?B?MEhCZFQrdFJwYUQxdys5WkRjb252akpuYkNycStoRGtCZXhsUGZIaFFONVhl?=
 =?utf-8?B?c0hzS0RnVi9LRlBEb3UxTXY0RVhiOVZ4MDNqL3Y4Zm82Yjg0bHNjWjE0aGVD?=
 =?utf-8?B?MEc4YUl3V21JcW5PVEdITzlsMXdaV3loMm9DaWpIa1UyUng0Sjl6MU9aNC9n?=
 =?utf-8?B?cGg2WnVCVkVXVThuTVIxYWNYVkNOOFBXdEh4M3cxNWRnak9ORXdLeUJHTE1T?=
 =?utf-8?B?Z29LUGlwK3M5ZWZQeTNFdEQ5L3cvdDJJbnl3VnFZRnF0VkhtY2I0VjRhZjFK?=
 =?utf-8?B?dkhoSktnUWwyV05Gang4bWpOdURlUlZVL2FLRld6ajczdGRabHAzSlZGOTQx?=
 =?utf-8?B?ZmJPZXRTeS9ycWIxRDhCeEhFSlBMSUFvYXAxc3dZdWFSVEJxTDd4Y010d2hY?=
 =?utf-8?B?cWN6QWlxSVF2OXZDbU0vWXVoUm96NmxCUjVzbWhsbDJmUFo0b0hGa3dYeHQx?=
 =?utf-8?B?SlRZNTE2WVJlZnNhclNCa0hsemhweXYza1RtMTc2WHRhbURiVnJEakJLQUtm?=
 =?utf-8?B?MzRoV0txeGZlZ3BmRUprc3Mrdk9rc1pDcytJeG9ySVpSSm5BdkxKaHhIL05B?=
 =?utf-8?B?OUIxQ3REQTVqSEs3VVlUQnAwL1NWWHZoWU90M015UEdvQjRKU2RpeDlyay9C?=
 =?utf-8?B?NTRPZVpNbStMY2dDUEhVQ0ZYbWJVaHYvRk1zc0h0SGlYU1lXWXJBK1cwWHU0?=
 =?utf-8?B?SW1iVDBKZExnOFlGb293ZFUvcFU4WUYwWDdEbnVjM2xqWE92NSt3dFVXOGtr?=
 =?utf-8?B?TU5SZHpnaHNoZmRNVmk0VXFJRTZ1VnBMV2FqN01ZTkw0U3FGSG9Dazh0R2ha?=
 =?utf-8?B?bFZQNTFodVlhNk1xUFNlTWhKMjFUMlNtUmpmUDRCZDJPa0hsZExCUnZwK2Jt?=
 =?utf-8?B?Z1g0Vmp2ZS9ZWjluSFQwTTVmNDJiKzhTQ3BuWTl3dmdld2NxTHBoZG81TGxi?=
 =?utf-8?B?cklvUDN3V2tib0lyd0FWNjJXOXhnODRKSXlXZlVTbFJIV01RTHl5eDV0K3dZ?=
 =?utf-8?B?N200VVgyY2dXcFMvN243cXB0Zm95RmdLalR2ME8rU1NtMTZmc3JBQ2EzTjhK?=
 =?utf-8?B?YS93d1Rqa0QzbHFNam9KRktnSWU1TUVweFhwYnJkUHUwUTA1Nm9GZXNCVlQx?=
 =?utf-8?B?Y00zbEV0c1Jyc25JM294N1V4S1l4L1ZWR3NTbllyc2lCZlJEZmcxOUNIYlVV?=
 =?utf-8?B?Z0ROUG53aUtQWHlHVlc5aUJEenlvbTR5ZE9VbWxtb05aNkVxK2RXMURWeG0v?=
 =?utf-8?B?UlVjelhtRDZkSyt6aWpMMkhlZDB2NWh5Y1dUZWFpWG1hV3RVYTNJWGlKRmRv?=
 =?utf-8?B?WlVxcWEvSGVvWlp6b0tlcWFhSC9QcFRqZzBvejdVVlpZTTdkUVhQck9BOHRT?=
 =?utf-8?B?RkpCcHpIUzNaSWJsNFhjRTMwM2Q1WitaNGdCZjF5c2YzaDkyR0tnWVhrcllY?=
 =?utf-8?B?YTM2YlBJbjc2MTNpYVlBaHFONk9MQUV6bmhkZ1I0am5sNnNIQmJONXl1RlZw?=
 =?utf-8?B?SnI4NEZuM0FyS1E0aXRsMVBrZHdGZkxRUjRNak9IZDVIMVRMY0d6Q0oyNnJo?=
 =?utf-8?B?Zk5NcTVadFkvbURHeW1tOVNiZVN1MjcvempPNFlBQUlBOWhSRUgzN21EUHBD?=
 =?utf-8?B?dW9oS1NFSTVnL2thMnQwbTJZd3ByTFNsUEFCT2JwWkJQOWRTK080bmFqbEVr?=
 =?utf-8?B?cWZJNFErNHpBeHRuRzA2dDlWN1Y1eklkNXQzME1VYk13cCs1TXN0anZETlZx?=
 =?utf-8?B?V1d3MnZKdjFTeW9xYUw5SEFjdFFXZGQxaHplQVl2NGpKZkFXdjRXQ0Nyb2ts?=
 =?utf-8?B?OXRFZmF3K0lmQkppWFRhSUVlaXl5M1ZyOXJxNER4Ymdjc1lVeVVoNXE5KzI0?=
 =?utf-8?B?MVV2NEVKRVNmZTNheWczTWxMQ0c2dUNqVmJOenNBb1NWSkpsVkM1cXBhWWdk?=
 =?utf-8?B?QlhUb2VOSkRWbER4aHovYk94YWQ2d01BSEJERDBkaUU0Ni82aFF4MVo2T01H?=
 =?utf-8?B?NWNNRWZWVVhBZEI4a1pDc3lmMU5FU0xmTzZ1ZlcyN1U3ZlhxejY2RXpMcFgx?=
 =?utf-8?B?dmxIVWY1UVkrcUJQU3pLK0JSMGltbGVvYVB2dXcxWUJobzNwMkxKbnhvSVF1?=
 =?utf-8?Q?81wfJUPwzsanhZ//rhDtbtdFWBaKro5aIIF514qDRc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37cf5cfe-3e0a-4ea0-a048-08d9b3f133d2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 11:04:39.2015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3KUvMg33Wwddewaxqu5qdRq9s7axfmiMP9piUnQbFXCrVOgUQMhNMlkA8qXJhDdC0FbSnf2zNmKbf4sA95y5oYNtr4+uLihy2cOrh67vk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5666
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111300063
X-Proofpoint-GUID: aEIJ5Migaf-MebU74g0mvcewFgo1nBlI
X-Proofpoint-ORIG-GUID: aEIJ5Migaf-MebU74g0mvcewFgo1nBlI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d58071a8a76d779eedab38033ae4c821c30295a5
commit: 5af9405397bfb90d6adab61d58f4d94c78166698 PCI: dra7xx: Get an optional clock
config: powerpc64-randconfig-m031-20211128 (https://download.01.org/0day-ci/archive/20211130/202111301803.NOwoj4Jd-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/pci/controller/dwc/pci-dra7xx.c:864 dra7xx_pcie_probe() warn: 'dra7xx->clk' not released on lines: 759.

vim +864 drivers/pci/controller/dwc/pci-dra7xx.c

e259c2926c016d drivers/pci/controller/dwc/pci-dra7xx.c Tony Lindgren          2021-03-10  684  static int dra7xx_pcie_probe(struct platform_device *pdev)
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  685  {
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  686  	u32 reg;
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  687  	int ret;
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  688  	int irq;
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  689  	int i;
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  690  	int phy_count;
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  691  	struct phy **phy;
7a4db656a6350f drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-10-09  692  	struct device_link **link;
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  693  	void __iomem *base;
442ec4c04d1235 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-02-15  694  	struct dw_pcie *pci;
442ec4c04d1235 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-02-15  695  	struct dra7xx_pcie *dra7xx;
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  696  	struct device *dev = &pdev->dev;
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  697  	struct device_node *np = dev->of_node;
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  698  	char name[10];
602d38bc65aa29 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-01-11  699  	struct gpio_desc *reset;
608793e27b3313 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  700  	const struct of_device_id *match;
608793e27b3313 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  701  	const struct dra7xx_pcie_of_data *data;
608793e27b3313 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  702  	enum dw_pcie_device_mode mode;
c232c0df9610bf drivers/pci/controller/dwc/pci-dra7xx.c Kishon Vijay Abraham I 2019-01-24  703  	u32 b1co_mode_sel_mask;
608793e27b3313 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  704  
608793e27b3313 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  705  	match = of_match_device(of_match_ptr(of_dra7xx_pcie_match), dev);
608793e27b3313 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  706  	if (!match)
608793e27b3313 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  707  		return -EINVAL;
608793e27b3313 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  708  
608793e27b3313 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  709  	data = (struct dra7xx_pcie_of_data *)match->data;
608793e27b3313 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  710  	mode = (enum dw_pcie_device_mode)data->mode;
c232c0df9610bf drivers/pci/controller/dwc/pci-dra7xx.c Kishon Vijay Abraham I 2019-01-24  711  	b1co_mode_sel_mask = data->b1co_mode_sel_mask;
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  712  
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  713  	dra7xx = devm_kzalloc(dev, sizeof(*dra7xx), GFP_KERNEL);
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  714  	if (!dra7xx)
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  715  		return -ENOMEM;
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  716  
442ec4c04d1235 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-02-15  717  	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
442ec4c04d1235 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-02-15  718  	if (!pci)
442ec4c04d1235 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-02-15  719  		return -ENOMEM;
442ec4c04d1235 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-02-15  720  
442ec4c04d1235 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-02-15  721  	pci->dev = dev;
442ec4c04d1235 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-02-15  722  	pci->ops = &dw_pcie_ops;
442ec4c04d1235 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-02-15  723  
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  724  	irq = platform_get_irq(pdev, 0);
caecb05c800081 drivers/pci/controller/dwc/pci-dra7xx.c Krzysztof Wilczyński   2020-08-02  725  	if (irq < 0)
a0d21ba120d2c7 drivers/pci/dwc/pci-dra7xx.c            Gustavo A. R. Silva    2017-08-09  726  		return irq;
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  727  
c8a119779f5609 drivers/pci/controller/dwc/pci-dra7xx.c Wei Yongjun            2020-04-29  728  	base = devm_platform_ioremap_resource_byname(pdev, "ti_conf");
c8a119779f5609 drivers/pci/controller/dwc/pci-dra7xx.c Wei Yongjun            2020-04-29  729  	if (IS_ERR(base))
c8a119779f5609 drivers/pci/controller/dwc/pci-dra7xx.c Wei Yongjun            2020-04-29  730  		return PTR_ERR(base);
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  731  
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  732  	phy_count = of_property_count_strings(np, "phy-names");
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  733  	if (phy_count < 0) {
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  734  		dev_err(dev, "unable to find the strings\n");
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  735  		return phy_count;
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  736  	}
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  737  
a86854d0c599b3 drivers/pci/dwc/pci-dra7xx.c            Kees Cook              2018-06-12  738  	phy = devm_kcalloc(dev, phy_count, sizeof(*phy), GFP_KERNEL);
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  739  	if (!phy)
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  740  		return -ENOMEM;
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  741  
a86854d0c599b3 drivers/pci/dwc/pci-dra7xx.c            Kees Cook              2018-06-12  742  	link = devm_kcalloc(dev, phy_count, sizeof(*link), GFP_KERNEL);
7a4db656a6350f drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-10-09  743  	if (!link)
7a4db656a6350f drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-10-09  744  		return -ENOMEM;
7a4db656a6350f drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-10-09  745  
5af9405397bfb9 drivers/pci/controller/dwc/pci-dra7xx.c Luca Ceresoli          2021-05-31  746  	dra7xx->clk = devm_clk_get_optional(dev, NULL);
5af9405397bfb9 drivers/pci/controller/dwc/pci-dra7xx.c Luca Ceresoli          2021-05-31  747  	if (IS_ERR(dra7xx->clk))
5af9405397bfb9 drivers/pci/controller/dwc/pci-dra7xx.c Luca Ceresoli          2021-05-31  748  		return dev_err_probe(dev, PTR_ERR(dra7xx->clk),
5af9405397bfb9 drivers/pci/controller/dwc/pci-dra7xx.c Luca Ceresoli          2021-05-31  749  				     "clock request failed");
5af9405397bfb9 drivers/pci/controller/dwc/pci-dra7xx.c Luca Ceresoli          2021-05-31  750  
5af9405397bfb9 drivers/pci/controller/dwc/pci-dra7xx.c Luca Ceresoli          2021-05-31  751  	ret = clk_prepare_enable(dra7xx->clk);
5af9405397bfb9 drivers/pci/controller/dwc/pci-dra7xx.c Luca Ceresoli          2021-05-31  752  	if (ret)
5af9405397bfb9 drivers/pci/controller/dwc/pci-dra7xx.c Luca Ceresoli          2021-05-31  753  		return ret;
5af9405397bfb9 drivers/pci/controller/dwc/pci-dra7xx.c Luca Ceresoli          2021-05-31  754  
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  755  	for (i = 0; i < phy_count; i++) {
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  756  		snprintf(name, sizeof(name), "pcie-phy%d", i);
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  757  		phy[i] = devm_phy_get(dev, name);
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  758  		if (IS_ERR(phy[i]))
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  759  			return PTR_ERR(phy[i]);

Smatch wants an clk_unprepare_disable(dra7xx->clk) on failure paths.

7a4db656a6350f drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-10-09  760  
7a4db656a6350f drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-10-09  761  		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
7a4db656a6350f drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-10-09  762  		if (!link[i]) {
7a4db656a6350f drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-10-09  763  			ret = -EINVAL;
7a4db656a6350f drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-10-09  764  			goto err_link;
7a4db656a6350f drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-10-09  765  		}
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  766  	}
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  767  
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  768  	dra7xx->base = base;
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  769  	dra7xx->phy = phy;
442ec4c04d1235 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-02-15  770  	dra7xx->pci = pci;
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  771  	dra7xx->phy_count = phy_count;
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  772  
c232c0df9610bf drivers/pci/controller/dwc/pci-dra7xx.c Kishon Vijay Abraham I 2019-01-24  773  	if (phy_count == 2) {
c232c0df9610bf drivers/pci/controller/dwc/pci-dra7xx.c Kishon Vijay Abraham I 2019-01-24  774  		ret = dra7xx_pcie_configure_two_lane(dev, b1co_mode_sel_mask);
c232c0df9610bf drivers/pci/controller/dwc/pci-dra7xx.c Kishon Vijay Abraham I 2019-01-24  775  		if (ret < 0)
c232c0df9610bf drivers/pci/controller/dwc/pci-dra7xx.c Kishon Vijay Abraham I 2019-01-24  776  			dra7xx->phy_count = 1; /* Fallback to x1 lane mode */
c232c0df9610bf drivers/pci/controller/dwc/pci-dra7xx.c Kishon Vijay Abraham I 2019-01-24  777  	}
c232c0df9610bf drivers/pci/controller/dwc/pci-dra7xx.c Kishon Vijay Abraham I 2019-01-24  778  
1f6c4501c667a6 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-01-11  779  	ret = dra7xx_pcie_enable_phy(dra7xx);
1f6c4501c667a6 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-01-11  780  	if (ret) {
1f6c4501c667a6 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-01-11  781  		dev_err(dev, "failed to enable phy\n");
1f6c4501c667a6 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-01-11  782  		return ret;

No clean up on this error path.

1f6c4501c667a6 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-01-11  783  	}
1f6c4501c667a6 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-01-11  784  
9bcf0a6fdc5062 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-02-15  785  	platform_set_drvdata(pdev, dra7xx);
9bcf0a6fdc5062 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-02-15  786  
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  787  	pm_runtime_enable(dev);
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  788  	ret = pm_runtime_get_sync(dev);
d3f4caa355c1c9 drivers/pci/host/pci-dra7xx.c           Fabio Estevam          2015-08-20  789  	if (ret < 0) {
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  790  		dev_err(dev, "pm_runtime_get_sync failed\n");
0e2bdb0e7abf4b drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2015-07-31  791  		goto err_get_sync;
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  792  	}
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  793  
602d38bc65aa29 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-01-11  794  	reset = devm_gpiod_get_optional(dev, NULL, GPIOD_OUT_HIGH);
602d38bc65aa29 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-01-11  795  	if (IS_ERR(reset)) {
602d38bc65aa29 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-01-11  796  		ret = PTR_ERR(reset);
602d38bc65aa29 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-01-11  797  		dev_err(&pdev->dev, "gpio request failed, ret %d\n", ret);
78bdcad05ea17f drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2015-07-28  798  		goto err_gpio;
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  799  	}
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  800  
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  801  	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD);
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  802  	reg &= ~LTSSM_EN;
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  803  	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD, reg);
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  804  
608793e27b3313 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  805  	switch (mode) {
608793e27b3313 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  806  	case DW_PCIE_RC_TYPE:
f1aba0a0de55c7 drivers/pci/dwc/pci-dra7xx.c            Niklas Cassel          2017-12-20  807  		if (!IS_ENABLED(CONFIG_PCI_DRA7XX_HOST)) {
f1aba0a0de55c7 drivers/pci/dwc/pci-dra7xx.c            Niklas Cassel          2017-12-20  808  			ret = -ENODEV;
f1aba0a0de55c7 drivers/pci/dwc/pci-dra7xx.c            Niklas Cassel          2017-12-20  809  			goto err_gpio;
f1aba0a0de55c7 drivers/pci/dwc/pci-dra7xx.c            Niklas Cassel          2017-12-20  810  		}
f1aba0a0de55c7 drivers/pci/dwc/pci-dra7xx.c            Niklas Cassel          2017-12-20  811  
608793e27b3313 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  812  		dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_DEVICE_TYPE,
608793e27b3313 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  813  				   DEVICE_TYPE_RC);
726d75a6d243bf drivers/pci/controller/dwc/pci-dra7xx.c Vignesh R              2018-09-25  814  
726d75a6d243bf drivers/pci/controller/dwc/pci-dra7xx.c Vignesh R              2018-09-25  815  		ret = dra7xx_pcie_unaligned_memaccess(dev);
726d75a6d243bf drivers/pci/controller/dwc/pci-dra7xx.c Vignesh R              2018-09-25  816  		if (ret)
726d75a6d243bf drivers/pci/controller/dwc/pci-dra7xx.c Vignesh R              2018-09-25  817  			dev_err(dev, "WA for Errata i870 not applied\n");
726d75a6d243bf drivers/pci/controller/dwc/pci-dra7xx.c Vignesh R              2018-09-25  818  
23926c8dbd6fdc drivers/pci/host/pci-dra7xx.c           Jingoo Han             2014-11-06  819  		ret = dra7xx_add_pcie_port(dra7xx, pdev);
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  820  		if (ret < 0)
78bdcad05ea17f drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2015-07-28  821  			goto err_gpio;
608793e27b3313 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  822  		break;
608793e27b3313 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  823  	case DW_PCIE_EP_TYPE:
f1aba0a0de55c7 drivers/pci/dwc/pci-dra7xx.c            Niklas Cassel          2017-12-20  824  		if (!IS_ENABLED(CONFIG_PCI_DRA7XX_EP)) {
f1aba0a0de55c7 drivers/pci/dwc/pci-dra7xx.c            Niklas Cassel          2017-12-20  825  			ret = -ENODEV;
f1aba0a0de55c7 drivers/pci/dwc/pci-dra7xx.c            Niklas Cassel          2017-12-20  826  			goto err_gpio;
f1aba0a0de55c7 drivers/pci/dwc/pci-dra7xx.c            Niklas Cassel          2017-12-20  827  		}
f1aba0a0de55c7 drivers/pci/dwc/pci-dra7xx.c            Niklas Cassel          2017-12-20  828  
608793e27b3313 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  829  		dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_DEVICE_TYPE,
608793e27b3313 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  830  				   DEVICE_TYPE_EP);
f7a2757f6cd0aa drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  831  
726d75a6d243bf drivers/pci/controller/dwc/pci-dra7xx.c Vignesh R              2018-09-25  832  		ret = dra7xx_pcie_unaligned_memaccess(dev);
f7a2757f6cd0aa drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  833  		if (ret)
f7a2757f6cd0aa drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  834  			goto err_gpio;
f7a2757f6cd0aa drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  835  
608793e27b3313 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  836  		ret = dra7xx_add_pcie_ep(dra7xx, pdev);
608793e27b3313 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  837  		if (ret < 0)
608793e27b3313 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  838  			goto err_gpio;
608793e27b3313 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  839  		break;
608793e27b3313 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  840  	default:
608793e27b3313 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  841  		dev_err(dev, "INVALID device type %d\n", mode);
608793e27b3313 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  842  	}
608793e27b3313 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  843  	dra7xx->mode = mode;
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  844  
d4c7d1a089d6fd drivers/pci/dwc/pci-dra7xx.c            Keerthy                2017-03-13  845  	ret = devm_request_irq(dev, irq, dra7xx_pcie_irq_handler,
d4c7d1a089d6fd drivers/pci/dwc/pci-dra7xx.c            Keerthy                2017-03-13  846  			       IRQF_SHARED, "dra7xx-pcie-main", dra7xx);
d4c7d1a089d6fd drivers/pci/dwc/pci-dra7xx.c            Keerthy                2017-03-13  847  	if (ret) {
d4c7d1a089d6fd drivers/pci/dwc/pci-dra7xx.c            Keerthy                2017-03-13  848  		dev_err(dev, "failed to request irq\n");
d4c7d1a089d6fd drivers/pci/dwc/pci-dra7xx.c            Keerthy                2017-03-13  849  		goto err_gpio;
d4c7d1a089d6fd drivers/pci/dwc/pci-dra7xx.c            Keerthy                2017-03-13  850  	}
d4c7d1a089d6fd drivers/pci/dwc/pci-dra7xx.c            Keerthy                2017-03-13  851  
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  852  	return 0;
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  853  
78bdcad05ea17f drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2015-07-28  854  err_gpio:
0e2bdb0e7abf4b drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2015-07-31  855  err_get_sync:
c2615d620a852a drivers/pci/controller/dwc/pci-dra7xx.c Dinghao Liu            2020-05-20  856  	pm_runtime_put(dev);
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  857  	pm_runtime_disable(dev);
1f6c4501c667a6 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-01-11  858  	dra7xx_pcie_disable_phy(dra7xx);
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  859  
7a4db656a6350f drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-10-09  860  err_link:
7a4db656a6350f drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-10-09  861  	while (--i >= 0)
7a4db656a6350f drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-10-09  862  		device_link_del(link[i]);
7a4db656a6350f drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-10-09  863  
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22 @864  	return ret;
47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  865  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

