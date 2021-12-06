Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371EE4696B1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244249AbhLFNW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:22:26 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:54938 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244226AbhLFNWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:22:13 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6DDmFA030765;
        Mon, 6 Dec 2021 13:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=C9ZlUJuuZgcHwp7RtnIjHY0bxAcdxg+kIu+v5B4uzmE=;
 b=Wm5vwRpBeQMsAv5uHWhytozBFNgJfiWD7vBbJRMqeLyZJHHGzs4HvDlbab11j0djtXHQ
 UcDZtK+wx4/Vcg7KfLwmlwswJqEykMMcq57KxtHQsKF1VCKsYIUqRNx00PhwH9BVKg7O
 zx25NqMYpjgoPhH7T452FsSBABMHVKpxn5m0l/hjYx/FlhpYeh/njJIL3SPBdiIEcX3C
 sqGoUiueD09Eo8Zh6smS+7/iSyO0LdgxkB59hhvA7XgRfgmvA/uLB3Jvvi2u6LnGpoH5
 iBYWl8x/uwiHTrnE9ouBCafAjLqD9tgiCElbn8/WQK9fbCXLZvnzT6hz3JFcSQaYaNQ9 Hw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cscwc9wf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 13:18:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B6DGcxk009200;
        Mon, 6 Dec 2021 13:18:31 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2040.outbound.protection.outlook.com [104.47.73.40])
        by userp3020.oracle.com with ESMTP id 3cr1sm166u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 13:18:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpaiZhpu0KYFvgkdy7zpkL+f3ayK73egA9uvYbY8xLadmpnbbn0AA7UIAGviYvjtqkW+mkoe/Zi8lnSm7k+9M74dy/WeRBSPEFCahAJAfHShA6qma448JrCO/DJBOl7mQOryBq7oZKtG2b8BZKkTBmSSiQm44sx4XrVuqRDOe7rzObeqyeZ1F0i3QdAeGqcjpeqSLkuYhlGtE3GdeHzQMZZUlAC7yHcCN06Js+H5RCWVs8oZCvdISIpjBjK6Vi7db/9KF9HZmaXVQI8aUszMO0Looc7qwh0uzryZQqXGU+1m37GLKkogsbwJdzzunePQiwjFIbZwoE76DVj1pplPqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9ZlUJuuZgcHwp7RtnIjHY0bxAcdxg+kIu+v5B4uzmE=;
 b=lZDfOUuYFL/636mbEdeQYRA0uVCMBFxH4e7Vxjvkv3SVzXVq+iniXA46Gl3PiYLQbUWEu8VCKz1tVEmLZ9VWaZf2xWHlQpj84BY2VgFOOhRaet58xJBpD0QCX0AK3lpc4DQiOWuBNof+RyEKHHU2HKFmEN29R4o+j9GxkH4Q9WCAMB3GFH5w12hDUmKIYm7PYZ8B/0n0wQ3Z/L4TPfGmCksV95288TJdsjfhlsYpV4wU2HA8MRkNeg+Ygq0CpV6vhJiBV8Xr2XpwLoyu0griOq+RnWYDJbfkX9LkOfEp3edFG+L4YdJGd098qbpVEO6K2lS5251J0eQ7XS/6juViRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9ZlUJuuZgcHwp7RtnIjHY0bxAcdxg+kIu+v5B4uzmE=;
 b=pGwtL2WJ80kqEwgI0CI33zjN4QUy/g+ZRmOZdFv1uJCayLYicVobAdtuGIzjc2Qr+FrDDbkO3V0gfFCmMDpI8JA4+fF3Ntgw3qSsBeXcJxj38d5v5MVPJ9bHtk2pzWk23IQn4730ez9PCjST6aFWZRIcKhWZiylAVKZiSdQBMpE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2159.namprd10.prod.outlook.com
 (2603:10b6:301:2c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 13:18:29 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 13:18:29 +0000
Date:   Mon, 6 Dec 2021 16:18:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: drivers/mtd/parsers/ofpart_bcm4908.c:41
 bcm4908_partitions_fw_offset() warn: should 'offset << 10' be a 64 bit type?
Message-ID: <202112040342.AvFc4SDJ-lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0033.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::14)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0033.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Mon, 6 Dec 2021 13:18:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2da991f6-1d62-440e-becf-08d9b8bae507
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2159:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2159AA9CF22CA9368B08A3F18E6D9@MWHPR1001MB2159.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:37;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H/qq7BAI5BAPzV09Keu1H9fjgFXV7jQVIKy6icLJ6rt0ORNTVv05LwWFFJhNoOP4KOOLdoIypoXVQQglcJh44h9F4cBQUpbshCTXw4ifLHy8zHOfG52Bt3irIwVpiZPkOdE1LxAai9SManAy485i6yjO0KHokDp+/ywqEQvFYmwiI2zLDBGfEq8PIe8lfcb3Caww7G5FXqugMXVWs0sC/C5Iz6crwuov/mBuoirUzPIc2Zmjk2qVJyvqUoneEWTcawGkH6fmJQzc1GsACxMBW5Peq9mIAk0KbPuU860UvSCsw6rPkiWVPddgKxVW2SfnJRaM4XQLWcuOMmjM7G2Vv+ph/0d1qKpVSfolRL1+Sd0CL8wrlUZQM+mMsd/PLOGTDpxB6MLJVmuyxJdgF3oPaq7q/xr+4FQRk4+yFq4K+pI5m9Sgy7dB9yGGBd/VTRKaAnup6M+qNoZ1eGdkegJH7Ow4lVGE1UmLnTSZYgYi2bDHTayE5Wc2V12j+dlPzImOZavv5gPEYt5DxIUj6lDV3j5YigrKP5DO8zeOmgzRvXtq4L5k8WkEL9OWXPEs0jrUUOvSoxr83ESE9onLlUaCFCya4kuh1TOtipmGwYrMMvNnAZqEVcZ8uA1hsCdB1BGiBoNRxh4C1/eccrgHuvVZ8pyZwjgc2hmTcvLRKfeTXOitrCG9N3HBdXeszRewDxPARDcJR+Az9LR+hrPMZnCijftVcBt08L2rEuKFRrwucQoguG9jDHLsuoeh/6gyXivDj0VMTL8I05xAeV2XChxfPzrq+UGFvMfDiVWmW0fpx5UaywgcJCwhPmsUKYpRKvIp2Ehymxma8YtamZGXSIYkaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(6486002)(83380400001)(966005)(508600001)(66574015)(316002)(6916009)(956004)(4326008)(6496006)(66556008)(9686003)(36756003)(2906002)(186003)(8936002)(86362001)(26005)(8676002)(44832011)(38350700002)(52116002)(6666004)(66476007)(1076003)(66946007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUVmd2lzak96alNZeHI4Wm8yM3ZpclF3WWxFLzlZeU1TRjIxcER2R1VFNVpF?=
 =?utf-8?B?dVhDazJWeENKRytLVElQUXBHTEhyc2VwaTNDNXRVRERzcjhDZWFJNGZGbmU3?=
 =?utf-8?B?Y2lMN1hPQmFITWo3ZlBPTWY1bFJIZzgyV1RnQlp2Zk51NUhOMVdTNlBzRFlO?=
 =?utf-8?B?d1N0dlhHbzR5RGpqT1FVUElnQ1k4cmdvVG95N3p0RElDVFVHOHpzdTFwcUlD?=
 =?utf-8?B?OHVCb1doVUdaRWtycmluU2ovMng2ZndFcUhRc0hUVms4SWpTMkJVdXNFVlhQ?=
 =?utf-8?B?TnF6STZuSmx4ejRzRzJuVm9KUm9vRmN3NDlpRkFsYVhuSnlqbGl2d1M5aFM0?=
 =?utf-8?B?WHZyODVPam56UnM4MFQ4VWNVYTZIVVlGOVhRakU1RVR4RHd5QjdXZ1NxbWds?=
 =?utf-8?B?VEFWdnRBZFEwcG4rZExCRzFKdis3YVB2RS96eUNUU2txLzZWekhxRnRjZ3Qw?=
 =?utf-8?B?M3FPdDZicng0QlIzb3FiVzJrZHlCRm5oZ2NhSmRGZkZjSlRxRkUyYTBIOVRm?=
 =?utf-8?B?eVBPVUZVZGRwcFZaclFVbkVpZGNpdWExWTZTNWMxbUZHMENnNHFnc055dXZZ?=
 =?utf-8?B?T20wRHErNmVWUUV4VjlKMHFhZkwvRXRUQmhrNjR6RjZoRkdFRWwydklyZEJS?=
 =?utf-8?B?bHVxemcwM3BCRzR6b0pZNjJCek82UVdhRGZUSm5kR2JWeDBLWmZmNzhzdlZr?=
 =?utf-8?B?dmV4cy9qYmlDZ1lHZHFZVnl3N2l3c3F3cHMvcE54U01nTEM5M2NoUU9UWEd0?=
 =?utf-8?B?WTdZMUw0cHdCSFlKUHR2dWYrTzZ3M0NFRlJCMmQwaUNWM28rMHgya1RpOTk5?=
 =?utf-8?B?cUdRUGlOeHAzV3NBMWZOWUdvblZiYkM3UTFVQ0FIdTYrWmR5bjNwakpVTnBY?=
 =?utf-8?B?SXhWRWQwVlo0Z3JpQ3RoZUUxdDhxbWIxNC9CNTFJNjBHb0dpUGVjdWdWZDFV?=
 =?utf-8?B?amZ1WHhNeWJ6VGlBVCswenA4andTNG00U0t3M0dNR09LaVZJNXVTTm5vM0tx?=
 =?utf-8?B?SjdXT2poVVdjQlFxTUZoSjBoZ3lMNHhmcEVtZE1ZZ2dlZHAzMWh2djVteEMx?=
 =?utf-8?B?N2ZUcnNUamdIUkU3ZWp0bi8xbFlINkQ4cnQvZVFmcjdrNGJaN05aTXUzMW9O?=
 =?utf-8?B?UXRrU1RHejdZbFh6QjdoSEllTi80V2VCYW8vNmRiS3U0eWdDQmF3TVIzdEdO?=
 =?utf-8?B?ZUZxaVI3Nm9UN1ZMaWN1NGVzbmMzM2pvSzdnYXE3QzNCdk9pTmtBNXJWZlNC?=
 =?utf-8?B?UE1YSnU2MWdhLzR1N2VYR1h3cmowUktucDluT0VmNzRUMmlhUUJVZ0k3RThO?=
 =?utf-8?B?ei9BNFBmUEtoVTJtOFp3bHZaNHkvUm5XVFJUcFZDWFpxRnpDdEUrczR6OUZ0?=
 =?utf-8?B?MmJ3VnNheHNwZFhWcU5LZTYzaFhVcjlReksrc1RYUW41SXM1NTdzdmlKSDVs?=
 =?utf-8?B?WFgrL2JxRG1iZkMxUFVKQWE2ZlprNDllcWY0TXhEaFYwL2dyRE02K3VzNitu?=
 =?utf-8?B?M09wa3hLNGxBa3ViUXl3UzVZdC8rOWloNjhZb1lvN2ZTb1ZjYkZ2TVRWcDhm?=
 =?utf-8?B?aVYvdkpVbUJMZXJlZTFOYlNkK2xLK1pmYk0vN3FqU3drcHZYa0FyZVRmWGJl?=
 =?utf-8?B?ck94d0xWMWI1TkNHeDkrRTA3azMvU2cyaVZWMURjVUI5R1FGdjRRd2dwVzFX?=
 =?utf-8?B?VG8vRVlhck81SG0yNTM0b3BEckdvWkNWdC81bEo3b3QzeVo4bGliU0Z6bkFi?=
 =?utf-8?B?QUttM2hVd0F2QjVnOUtZMTBidk1XTWttK2VuZi85Nm13ZTZzNlUzcGR1OHRP?=
 =?utf-8?B?cXM0OUdkT0dJVlVTYmNoOUI2Zmx1bTJvOXJIcndZNldjVVlvKy9LdWhNK1JI?=
 =?utf-8?B?UGFUQjhMMmJKM3Nla3owaDhsQ01LS3dtempxendkR2JEYk1OSlNLaGNLdG14?=
 =?utf-8?B?aUR4Zm5HQmJUZGNvYWx0QTc5WDQwbzRBU0ZBNk1kMjl5MVQ1S1hqaFRoV2hE?=
 =?utf-8?B?Qmc5MXBrNzA1ZFlmYzRKcm1Obm04OTRIa2k2eTRIbkl3ZzFPNWxmT3FFZGxI?=
 =?utf-8?B?TUFJZ0ExazdiakwyRTdRUUkyQS8xK2d6dldhTHdkSlBrYmhkYnR2Q0dzenRD?=
 =?utf-8?B?M1laMjYyZVpYZHI3TDg3NjcyenVHSUpVQ1JlTUlzQVBrT0IwVzFlbWVsVGFJ?=
 =?utf-8?B?YVU3UjIzbUkvMmVka3BRQndLVitGZm9CNExXQlVPREVsMDZaTEFHRDNiaUl0?=
 =?utf-8?B?bEQ3L0ZGQTIxcjBaK1VYN0RXdFZBPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da991f6-1d62-440e-becf-08d9b8bae507
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 13:18:29.7032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qEw3b7mm77Bu51FX6aTv+NXZ/MNM/ypn0bTlWm++U5fxAFpj4VUjVTpsLnIhz0aiwXdvZ8nVpz05cTyGGwuBMwOBlEwXQbGTZX55Ym8ht7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2159
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10189 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112060082
X-Proofpoint-ORIG-GUID: IGSDf8gVWHLWXR1ZgXhFy2Qb7BxNzYc1
X-Proofpoint-GUID: IGSDf8gVWHLWXR1ZgXhFy2Qb7BxNzYc1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5f58da2befa58edf3a70b91ed87ed9bf77f1e70e
commit: bb17230c61a6424b622e92006ec52ba23aa5a967 mtd: parsers: ofpart: support BCM4908 fixed partitions
date:   9 months ago
config: nios2-randconfig-m031-20211202 (https://download.01.org/0day-ci/archive/20211204/202112040342.AvFc4SDJ-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/mtd/parsers/ofpart_bcm4908.c:41 bcm4908_partitions_fw_offset() warn: should 'offset << 10' be a 64 bit type?

vim +41 drivers/mtd/parsers/ofpart_bcm4908.c

bb17230c61a642 Rafał Miłecki 2021-03-01  17  static long long bcm4908_partitions_fw_offset(void)
                                                    ^^^^^^^^^
This is long long.

bb17230c61a642 Rafał Miłecki 2021-03-01  18  {
bb17230c61a642 Rafał Miłecki 2021-03-01  19  	struct device_node *root;
bb17230c61a642 Rafał Miłecki 2021-03-01  20  	struct property *prop;
bb17230c61a642 Rafał Miłecki 2021-03-01  21  	const char *s;
bb17230c61a642 Rafał Miłecki 2021-03-01  22  
bb17230c61a642 Rafał Miłecki 2021-03-01  23  	root = of_find_node_by_path("/");
bb17230c61a642 Rafał Miłecki 2021-03-01  24  	if (!root)
bb17230c61a642 Rafał Miłecki 2021-03-01  25  		return -ENOENT;
bb17230c61a642 Rafał Miłecki 2021-03-01  26  
bb17230c61a642 Rafał Miłecki 2021-03-01  27  	of_property_for_each_string(root, "brcm_blparms", prop, s) {
bb17230c61a642 Rafał Miłecki 2021-03-01  28  		size_t len = strlen(BLPARAMS_FW_OFFSET);
bb17230c61a642 Rafał Miłecki 2021-03-01  29  		unsigned long offset;
bb17230c61a642 Rafał Miłecki 2021-03-01  30  		int err;
bb17230c61a642 Rafał Miłecki 2021-03-01  31  
bb17230c61a642 Rafał Miłecki 2021-03-01  32  		if (strncmp(s, BLPARAMS_FW_OFFSET, len) || s[len] != '=')
bb17230c61a642 Rafał Miłecki 2021-03-01  33  			continue;
bb17230c61a642 Rafał Miłecki 2021-03-01  34  
bb17230c61a642 Rafał Miłecki 2021-03-01  35  		err = kstrtoul(s + len + 1, 0, &offset);
bb17230c61a642 Rafał Miłecki 2021-03-01  36  		if (err) {
bb17230c61a642 Rafał Miłecki 2021-03-01  37  			pr_err("failed to parse %s\n", s + len + 1);
bb17230c61a642 Rafał Miłecki 2021-03-01  38  			return err;
bb17230c61a642 Rafał Miłecki 2021-03-01  39  		}
bb17230c61a642 Rafał Miłecki 2021-03-01  40  
bb17230c61a642 Rafał Miłecki 2021-03-01 @41  		return offset << 10;
                                                               ^^^^^^^^^^^^
So this should be long long.  Although 32bit systems are not really
common in real life any more...

bb17230c61a642 Rafał Miłecki 2021-03-01  42  	}
bb17230c61a642 Rafał Miłecki 2021-03-01  43  
bb17230c61a642 Rafał Miłecki 2021-03-01  44  	return -ENOENT;
bb17230c61a642 Rafał Miłecki 2021-03-01  45  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

