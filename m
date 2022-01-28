Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE0449F406
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242652AbiA1HHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:07:34 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:48840 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232944AbiA1HHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:07:32 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20S1wswE015087;
        Fri, 28 Jan 2022 07:07:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=eV85bnzXiRgoVRKL5TcLrkJIvklpk0I+24vZYdh+r08=;
 b=Oima0oos9Er8NvIgBbptUDvw5J2qGbMO41zqhfBEDs0dRww0Ado7WNRXQNfD9Wnxdn4z
 PhBtJDH1NOkZAAQw3XQPRIu3LRsIFpx7J4DJzzJcRm3/wJlzhTl2G4P8XzO51mM6UDc2
 +xG+XuEgfNa3hCKKM92+0VDwi2+vIq5oncSq2NKp+oXv+FqmokDzrXgJICap0i7If4zD
 xal5FFuxgmgxk5tExk9NLmh6HUIO3L4ApwAUDfsGx5yoMbxyJOtevaF9FeMUcE0hiJPV
 miSGCM1zsDjVEmdakNjb/B3SUtB7sikLPyyap6J8M7p/puegQATUpufspDnhXUhRJke6 ZQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duvsj2a2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 07:07:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20S71QXL109729;
        Fri, 28 Jan 2022 07:07:25 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by aserp3030.oracle.com with ESMTP id 3dr7yn83xv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 07:07:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFZgC0awI/eJBPV1ucUKiihkld/H9T5uH7mgP8FU4qtdF4Lt/oGilIFUoeUMz/BP22zuYadSjVVIOUFLhphMFbtUzeLpnw9xDWY1FkzW58WK/iN7EiKQ5ED7avLrKuEbctax6h0rt5plylZu6h4z9aJRqrqkq3e6UN3p7nvKQN9nxVXGaYBK6eILQCr238fV9VhhyY72ZHaxTXJZW2KwYZ0ii6KI4WJtOzpmJrM0eU01bQSsPtWc3jwnLpE0ZP7EIOFNWUuyUXhhM4Z91ktMQ9xHQKlizJcklMfl4PPhdfWAwEPMSUDDAts4baztJ99MoLw0yBNbt2G09ei0W7YQtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eV85bnzXiRgoVRKL5TcLrkJIvklpk0I+24vZYdh+r08=;
 b=bE+Hml6oHm0Z3tpi/fOkVE1+0UX1PeqvmBy2JZmYBdKyagqHb1y7qNoN7flK0xZ9nQsF12umzeghCNgDdVAiKyiIrMyBHbvqZ2QyLQPEhbPe7vCUCzgZR4yJXTorYTC0y6YXEOyPdi1N1e2QZjJi+9HBZUrZrEUYx0KnVdRsWbWBL5tV6J2GDm0YEpwB/yJrpVb2TH4+lz8k2mg+7mU437czz5k6/BVueWuDCCT15OlLecIjosNmCKLqi+F7eEQ5KVvrPY26pGmK4xkDK1nVhkvn3196sC67P0hHfcTtCXyXWXn8CGsGqIDUs5Zx9QCl9gk55AdScjrAfIN/md4PoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eV85bnzXiRgoVRKL5TcLrkJIvklpk0I+24vZYdh+r08=;
 b=gHcxQq/eO+bFBOi0tG21HiDERa3gE1+0KE8Nm8dm2l42pvsugXEIVcO2o6FpraFgEDmElyLbKmVO87Y003mcF34QpRpgbs9urX0/dCLi7zVf7TDKc7J7M/2y3dyueyUhQbc77LMT0aWnQRIF6jOqNm4GFZuNbJAJoRaxCnoRPeQ=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by CH0PR10MB4955.namprd10.prod.outlook.com
 (2603:10b6:610:c2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Fri, 28 Jan
 2022 07:07:22 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::cdcc:584:3514:f052]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::cdcc:584:3514:f052%5]) with mapi id 15.20.4909.017; Fri, 28 Jan 2022
 07:07:22 +0000
Date:   Fri, 28 Jan 2022 10:07:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Anilkumar Kolli <akolli@codeaurora.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Kalle Valo <quic_kvalo@quicinc.com>
Subject: drivers/net/wireless/ath/ath11k/qmi.c:1891
 ath11k_qmi_assign_target_mem_chunk() error: uninitialized symbol 'ret'.
Message-ID: <202201272025.7AWXB5T7-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0006.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::18)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 459fc19c-f8a1-4a12-f017-08d9e22cd4bc
X-MS-TrafficTypeDiagnostic: CH0PR10MB4955:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB49552EE3D6A65548E31823998E229@CH0PR10MB4955.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4AWp9NzTV/D4d+9ObqZjPeu5Im5yMqvNuZFbUnlBPSlf4FdNZPmXJkHFYmtt7i6JLvJxTPBwK/Izprc2hGe6hOdHvpSMFMj7zZUtczzkskhIQndfoiNN/NeIIWQ5ewMpD/KKpLXBQqxbjG8/JzfF8ICEPFZO4D8hxXQ7FURht7JOGigoaeoEQbShjPTLTQxQC/ftZP8ZHcHHqQnCs+hFL24506s8ixl29VIYlsi6jNYSavdTYmZPaiR4Mbqc+GSWvZtiO3j0Tj613FXRSkXQ1NguGCcdGkPowKxrf7WC0NQe8aauOra+vrN5nogcUV7N/3K5+xw2wL0uV3QkMVmKOV3oKjwzMVXQqF/X0aBnmrJ/3xbN44SNCR7uPA9v2qcxDb1LB4b8AKxBgic/SeQohFtV0AcVUn6nzYVWLPhvwjOSH/BcGET3XxuecNIlJRxMkbfnmWaogE27KI0Q8iVgGvdp8DLcvH12fVvJrV8McrFkEf+7eAwT32VPPwN1r3U83OMI2jhGuQzGS7eyOcGhsiqX5IVzhRTKkrmZko1NMaUKB9cswsnwcYCS/Pr5RC3AW4U7t8KEueAwPA4QVPEWCwVTeuEFPTKSlCWh0EjVWdD7CUF0+bZxOmx5qxykSPnwtbPfdTL5/f1SNZIjkM0rXlxI587un30ub5q2tKx2rNR0atyfNGpUdzdoL/ytVOQStH9vkzcoZ6CtDxRH4qNzHYVAV5vivbyTzooGgExgPlL7tE7jErxGQE4vJu9qRDckFOUiRGUZ/vm/on5mwpzcI+TplqIzelqMasgCgeqscJLDmRSqP+/JB2RRz7LoOORftSRSPd3JbvPmUxbAhLxJ9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4001150100001)(1076003)(38100700002)(6506007)(38350700002)(44832011)(5660300002)(52116002)(36756003)(26005)(508600001)(2906002)(6666004)(186003)(6486002)(966005)(316002)(86362001)(8936002)(4326008)(8676002)(6916009)(9686003)(6512007)(83380400001)(66556008)(66476007)(66946007)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PgPsb3AwynSn110VtrffaXkxlaL2SL7mVACRQa7wiGZSkTAXv43rhNUWPFZR?=
 =?us-ascii?Q?c5QyM8d3FoYPD5GGURpmA+2yR/w636xoZLs7kYE6k9PJiV2XxbU7NyHjRkOM?=
 =?us-ascii?Q?InRBLw+zM+bcW2SCHK56ZvLXXUicd7d9qzNsHyL0XlfkJucK5Yc9NcVqoQcX?=
 =?us-ascii?Q?hofLD7/PJiHiYS/Wjt8yHRbhxGbKJZ7IEv2K0kkhRWywFZVev/bhaDTy751M?=
 =?us-ascii?Q?HamFdeQwJXFB0tDkRk9/kYuvxC8CL/MSyjUHvVfY8Q0v2zqPvQFR9Y5vXvLn?=
 =?us-ascii?Q?bhXHhRllCAqLy60vSZ0q34mgXc8m5iDY5JPR589wZAf6kCJGIJ5EoFeukIA6?=
 =?us-ascii?Q?Li9VWAP83Ha3TDS592ueJAIAINXV2bzFITX1YdL8Qa1d1grONyYz+sc+aiMA?=
 =?us-ascii?Q?itbfZQWuQL04EI7FWUV2r6/pHs9h6IkFsrJk/A729I5pZozDdl0HifUZ0zAK?=
 =?us-ascii?Q?UdLbTeAnlhsBTXYoOYDN3HJsHK+Msz0OAN0MRcv+VKb7RrYS3qY/kwTgxCCW?=
 =?us-ascii?Q?OGqTAriIU77/MnX/7ghnSMWzfsvmtLcjZZKoU3CqHT1ot565PUS7XJ2DcCnt?=
 =?us-ascii?Q?T/zc9JX+MlrIbOBU9x9nXJPYYaCohRErZCMVTYnizjR8hlbfG5weAoaHVMWV?=
 =?us-ascii?Q?B+bGGgJoWhMz4fPLdnRk4eI2GXOHRJadGqINAw7D8CFalqxLKe6cAyuP2Vg/?=
 =?us-ascii?Q?QgX7F0dto3UxHwkV/O8om8ZNypKxpgkHapV7jDIheXNcZCN5BLPkPnqwEs5D?=
 =?us-ascii?Q?zlLrrBCvcKnO0KqY0cwT6lkaxqu8KXYCYZSBjHt5W/hvzMmxqvvkCvBoi0Af?=
 =?us-ascii?Q?OwgTO0a1GeIH4TbGDS5SzjfdZ0HenJRKYpCMYynxSEgM3FWe6AHgpXbfdGbw?=
 =?us-ascii?Q?xT33IpM54aSuEqj1YvL+LdaZKpybC2G0B7zot6P8bO7GGEe6QlczVYY4yU0c?=
 =?us-ascii?Q?hpW5a4xH3EO402hWircS+6iqgXXp7vhktc3pimNA7tJ0SDxpSFFhHgJ5BDVy?=
 =?us-ascii?Q?sx9eyn3Bea/7/nBvn3g2hpsQU6CZ2aKgApHxvOwUeLcfYHl3evbGSiighpDz?=
 =?us-ascii?Q?bbSDz8QqgsyyQ+Qxx1yiQUoBgFOfYJxNWIPqN/BUrnMiKfdl3U/80qVw40Jy?=
 =?us-ascii?Q?C3M0+9nsGQ3V6Vregrb2GsK/Nm/jkOh6s5jImDRia4gGxYbxb2TvRgT4Ttlm?=
 =?us-ascii?Q?AbYSWiizlXtWF4vP+ZPtSztBgyqgPvC1Uzyg0sgU9U0UGKB12oBM8jdV0nMd?=
 =?us-ascii?Q?gR8Rl1ebXQNNz0nBB/AliwFJHFy4vowU2Mk3F5SoCyLmmI6rFigJUzyr4Pxg?=
 =?us-ascii?Q?cPe63o1Ya8KPo+L/g4hMmwdLfdWWD0ujw4sD/rf54fCuH/TjqTUBYCl2hKuc?=
 =?us-ascii?Q?cpiRuwLawMt7eg/FQw0JSaTdmZ5yu/5ibMOpUxxvM26RERjRtIIeG3Z3+Adb?=
 =?us-ascii?Q?FXveoEspfV4rxXndvlNOv21WsRJ/17DkekIAltRKSZKOnMZP+sG8Uu+Z3gVY?=
 =?us-ascii?Q?LEwWhfMM+byoqBPr6Dcn9U6TLD49iRA4NUiwY+IFznYMmF12k1Wy2DIvWTGJ?=
 =?us-ascii?Q?N9jyAGVSdcFuKMI3VzzQ/UTTGmnIb+r9x157pR9qR9xsiqCsOaMiF3ctr/ih?=
 =?us-ascii?Q?lwonqLnYovDHEN6nvx1yZsjpYcxJizPPIsmBLxkhvomF9dlRaSpm7AU+idAQ?=
 =?us-ascii?Q?x6xlPE5DyjjGf7ky6nW/Ildn6vE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 459fc19c-f8a1-4a12-f017-08d9e22cd4bc
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 07:07:22.6319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U9HD7MrgbpjzVqMdQLeTLrIC76lJcvCZfD4gAVy/715s9WSFK+wuapEzoQWzSnC8r6pHUEim2/KV10Dr8GG5d+RnOVFmPBSMp96kkw6vYXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4955
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10240 signatures=669575
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201280043
X-Proofpoint-ORIG-GUID: UcyFrdfBh_doUMmlfxkVfPwi2I1lRB1B
X-Proofpoint-GUID: UcyFrdfBh_doUMmlfxkVfPwi2I1lRB1B
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0280e3c58f92b2fe0e8fbbdf8d386449168de4a8
commit: 6ac04bdc5edb418787ab2040b1f922c23464c750 ath11k: Use reserved host DDR addresses from DT for PCI devices
config: microblaze-randconfig-m031-20220127 (https://download.01.org/0day-ci/archive/20220127/202201272025.7AWXB5T7-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/net/wireless/ath/ath11k/qmi.c:1891 ath11k_qmi_assign_target_mem_chunk() error: uninitialized symbol 'ret'.

Old smatch warnings:
drivers/net/wireless/ath/ath11k/qmi.c:2161 ath11k_qmi_load_file_target_mem() error: uninitialized symbol 'ret'.

vim +/ret +1891 drivers/net/wireless/ath/ath11k/qmi.c

6eb6ea51382873 Govind Singh          2020-08-14  1876  static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
d5c65159f28953 Kalle Valo            2019-11-23  1877  {
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1878  	struct device *dev = ab->dev;
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1879  	struct device_node *hremote_node = NULL;
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1880  	struct resource res;
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1881  	u32 host_ddr_sz;
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1882  	int i, idx, ret;
d5c65159f28953 Kalle Valo            2019-11-23  1883  
d5c65159f28953 Kalle Valo            2019-11-23  1884  	for (i = 0, idx = 0; i < ab->qmi.mem_seg_count; i++) {
d5c65159f28953 Kalle Valo            2019-11-23  1885  		switch (ab->qmi.target_mem[i].type) {
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1886  		case HOST_DDR_REGION_TYPE:
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1887  			hremote_node = of_parse_phandle(dev->of_node, "memory-region", 0);
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1888  			if (!hremote_node) {
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1889  				ath11k_dbg(ab, ATH11K_DBG_QMI,
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1890  					   "qmi fail to get hremote_node\n");
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14 @1891  				return ret;

"ret" not set.

6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1892  			}
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1893  
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1894  			ret = of_address_to_resource(hremote_node, 0, &res);
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1895  			if (ret) {
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1896  				ath11k_dbg(ab, ATH11K_DBG_QMI,
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1897  					   "qmi fail to get reg from hremote\n");
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1898  				return ret;
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1899  			}
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1900  
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1901  			if (res.end - res.start + 1 < ab->qmi.target_mem[i].size) {
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1902  				ath11k_dbg(ab, ATH11K_DBG_QMI,
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1903  					   "qmi fail to assign memory of sz\n");
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1904  				return -EINVAL;
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1905  			}
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1906  
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1907  			ab->qmi.target_mem[idx].paddr = res.start;
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1908  			ab->qmi.target_mem[idx].iaddr =
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1909  				ioremap(ab->qmi.target_mem[idx].paddr,
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1910  					ab->qmi.target_mem[i].size);
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1911  			ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1912  			host_ddr_sz = ab->qmi.target_mem[i].size;
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1913  			ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1914  			idx++;
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1915  			break;
d5c65159f28953 Kalle Valo            2019-11-23  1916  		case BDF_MEM_REGION_TYPE:
3b94ae4c62db0b Anilkumar Kolli       2020-06-16  1917  			ab->qmi.target_mem[idx].paddr = ab->hw_params.bdf_addr;
6eb6ea51382873 Govind Singh          2020-08-14  1918  			ab->qmi.target_mem[idx].vaddr = NULL;
d5c65159f28953 Kalle Valo            2019-11-23  1919  			ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
d5c65159f28953 Kalle Valo            2019-11-23  1920  			ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
d5c65159f28953 Kalle Valo            2019-11-23  1921  			idx++;
d5c65159f28953 Kalle Valo            2019-11-23  1922  			break;
d5c65159f28953 Kalle Valo            2019-11-23  1923  		case CALDB_MEM_REGION_TYPE:
d5c65159f28953 Kalle Valo            2019-11-23  1924  			if (ab->qmi.target_mem[i].size > ATH11K_QMI_CALDB_SIZE) {
d5c65159f28953 Kalle Valo            2019-11-23  1925  				ath11k_warn(ab, "qmi mem size is low to load caldata\n");
d5c65159f28953 Kalle Valo            2019-11-23  1926  				return -EINVAL;
d5c65159f28953 Kalle Valo            2019-11-23  1927  			}
02f9d3c1b918a6 Govindaraj Saminathan 2020-10-16  1928  
02f9d3c1b918a6 Govindaraj Saminathan 2020-10-16  1929  			if (ath11k_cold_boot_cal && ab->hw_params.cold_boot_calib) {
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1930  				if (hremote_node) {
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1931  					ab->qmi.target_mem[idx].paddr =
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1932  							res.start + host_ddr_sz;
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1933  					ab->qmi.target_mem[idx].iaddr =
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1934  						ioremap(ab->qmi.target_mem[idx].paddr,
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1935  							ab->qmi.target_mem[i].size);
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1936  				} else {
02f9d3c1b918a6 Govindaraj Saminathan 2020-10-16  1937  					ab->qmi.target_mem[idx].paddr =
02f9d3c1b918a6 Govindaraj Saminathan 2020-10-16  1938  						ATH11K_QMI_CALDB_ADDRESS;
6ac04bdc5edb41 Anilkumar Kolli       2021-12-14  1939  				}
02f9d3c1b918a6 Govindaraj Saminathan 2020-10-16  1940  			} else {
d5c65159f28953 Kalle Valo            2019-11-23  1941  				ab->qmi.target_mem[idx].paddr = 0;
6eb6ea51382873 Govind Singh          2020-08-14  1942  				ab->qmi.target_mem[idx].vaddr = NULL;
02f9d3c1b918a6 Govindaraj Saminathan 2020-10-16  1943  			}
d5c65159f28953 Kalle Valo            2019-11-23  1944  			ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
d5c65159f28953 Kalle Valo            2019-11-23  1945  			ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
d5c65159f28953 Kalle Valo            2019-11-23  1946  			idx++;
d5c65159f28953 Kalle Valo            2019-11-23  1947  			break;
d5c65159f28953 Kalle Valo            2019-11-23  1948  		default:
d5c65159f28953 Kalle Valo            2019-11-23  1949  			ath11k_warn(ab, "qmi ignore invalid mem req type %d\n",
d5c65159f28953 Kalle Valo            2019-11-23  1950  				    ab->qmi.target_mem[i].type);
d5c65159f28953 Kalle Valo            2019-11-23  1951  			break;
d5c65159f28953 Kalle Valo            2019-11-23  1952  		}
d5c65159f28953 Kalle Valo            2019-11-23  1953  	}
d5c65159f28953 Kalle Valo            2019-11-23  1954  	ab->qmi.mem_seg_count = idx;
d5c65159f28953 Kalle Valo            2019-11-23  1955  
d5c65159f28953 Kalle Valo            2019-11-23  1956  	return 0;
d5c65159f28953 Kalle Valo            2019-11-23  1957  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

