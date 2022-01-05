Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D0A48525A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 13:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239979AbiAEMWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 07:22:21 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:61572 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229997AbiAEMWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 07:22:19 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 205BOpeJ009000;
        Wed, 5 Jan 2022 12:22:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=rY1HDgFqxKMXgDOdP41+c5+UGsIhRkK3nF0DW9z0OKE=;
 b=OQGxT8FWAtodGDfuBb2Vox73Phb69ae1G4XKWwhSe8BH31hbjQiwH9Fd++roCdp538jm
 wypl2ngrGolsHutWtjkTK1z6q3V1LLC2sLcIis7Mvg9LmAwIPjOi3+fB20pYmOaO7jUk
 n2zEKZitcBSNz3N47ONMFxGsWQ+c/bXmDXtCUZzNWdN6knU8ASAzxSJt7wEpKOYUZbET
 9mR4ZicNWwYSzOe0tdge9vMT3a64I7hWmsT4yrHBOSbWXJASP/ehJHiIP9bihHIBJ9bJ
 cGQh+2wrPNSIdDsDSqETePFVfj/FwXmADw8vZmd9WUn5Aobe5UROYmFIWtObzVHOuVhK HA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc9d93ubc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 12:22:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 205CBHiK013821;
        Wed, 5 Jan 2022 12:22:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by userp3020.oracle.com with ESMTP id 3dagdqdg65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 12:22:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jX/JfHuhd9NgZXaDb1rwYg+imH5kpFIVMthsVGnIAx1SxxjL2NYjxl/ib0z9lLqyC5IU8al6nxWv6DfkJpy3jMI0F6DDSp8eaQv0YkU5buf4AeOwGKv3r4aAPSzmBxi4WEn7TXhmbYu0BrPK8nUNOO4MnvZE68+4Qn5kQYcjhbeZlgPM9OPZrZey4hMZvac+tNCXfHLPDq8Ju/twNHSjp8cmvDDl4cOKjztMeI/FSpyfnlUOhQ7PQYdE1ZW1KHlewqe3GYAuodEx7t+I2MUwG3tH8X3C3KQzZrf1vZzOMWRuz/Dtrm/zwL7n//36k7rE7AUipBM2YOKrS9ditxRVxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rY1HDgFqxKMXgDOdP41+c5+UGsIhRkK3nF0DW9z0OKE=;
 b=hxVUCCRcxJxhZRfD6EqVuq+BPJ1voS2bWRjc7A0FevPw1Y/YE8rLe8S0FHzuE6Gppc5eGdSjVEwpesr5o+mnDcFdZLQ2d9jNIz7hiCcOtuNTUsbLVxzq3KpKOrMshI8wT5s8i44Lb5ZHrxv+ipmNV4HmCh8yL5Ja6bggfwpF7Yczl0cBSeAZ4HQYSAHkRNC4shkkQOiKCTfS10HXFtNwid+nJ44Okn/rEJDY+/lFMvnLQfwK9fKPZG7bdiTtnMq10dJeL4tKMBobOIkTLCquiWPVQd2O4YeMIvW/BCdmfY07d7xbUXY+GQtlnEae3JqN/iuJP8v5GV4gHrFBYLfuJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rY1HDgFqxKMXgDOdP41+c5+UGsIhRkK3nF0DW9z0OKE=;
 b=bl29Bd325ihGeGpb93RIHzSGdTLqmw4h16wW+cOX3KdluyvQ9o8DSCsZpMaZP1IHs+UMXKToHdCHIEy/uoMZxK6vSg0nMO9Sl5TkIuHIj+uy8MyTrElf6BtjxxwJlSZ3DgX49Ov6Pjmj/dMHDno0vlWai9XBLLDosv4+T37B2SU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4499.namprd10.prod.outlook.com
 (2603:10b6:303:6d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 5 Jan
 2022 12:22:03 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 12:22:03 +0000
Date:   Wed, 5 Jan 2022 15:21:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Wen Gong <quic_wgong@quicinc.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Kalle Valo <kvalo@codeaurora.org>, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kalle Valo <quic_kvalo@quicinc.com>
Subject: [kvalo-ath:pending 52/56] drivers/net/wireless/ath/ath11k/wmi.c:5651
 ath11k_wmi_tlv_fw_stats_data_parse() error: uninitialized symbol 'len'.
Message-ID: <202112110427.o6xDAKfE-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::20)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73fb420e-6346-40f9-3573-08d9d045fab2
X-MS-TrafficTypeDiagnostic: CO1PR10MB4499:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB44993C9C0B5F52B0C001B8748E4B9@CO1PR10MB4499.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:181;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ZiLiSD9NYTdFoowRpJj3Pb0c3QIZYOoIGDtD/k3VBbWH2VP/xyaEFzGUBAxUBYrIP4UcyHo++MkvLRqYxlw9sYii2e/oSzjwMALwpjAvt5OmvSaQhCyCajYNh//kNPbWQfhyXWmCSmROkofTQUp0K6mUJLhKsfQF3KWTFP4QkS2Ow0E4uVFajPjjIMqner/NWHe/ztdST7GeBuGInpkZ6LVOHh5yH+3RAfIFXjnQvekCAbMC6GgckJmUuZ3+cX5UCduNK1hgrYBrWOIDsbIVv/fzKZyv7vtmc9uz6nX5xessfik/o/NBU5WR5akDKrEPMlWoaabYwBds9lzSUxNimkW8KSg9Ca0TY9XQiypKxrdpCHc4TfDd+JxqXgr9Uj4DG7d+rp8gdrN+q1CE6cdEw3xZrFDDW2r3OkCXlAawCIdcNLBHbjYcKC7YYRD0lNnH0kvTj8c0hmqlj7vhFcov2g+4SZ9LUqXYPcohqXRZIpOz2V0aUn4NL4LsRgazaIKPeZdoZW/cogVKr8bPSeVzczgpPq9Bd13ThgZXFVWTxM4x0R2zmHVQDNUXA6F7QA/JAOxeoVxm1Thc0RsE2QyDVC3oj5txBqWkrO0ZesUVTVAvRwY/fn/aY8XiMxH5U6rM0bY9BgWavi9CjCVp+nTBoAdHjVufvixF5mMlR+NtCPJQXYYgvMBb6yYIIhkZFnJLeQ/YM0iEVbOsAmIz78pCCALBXHvXOVqDnkwNqtSZGhZyKun0AiU3ekq3UlkJVAJDQg87UKZWWlNsJ0pqyrhWujAk05JnREowN3jsoQ/AcBnW5YPAWO1r8PK1K9c1mRUfTCb00UHZzCoq0jiIdtf3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4001150100001)(83380400001)(54906003)(86362001)(316002)(38350700002)(38100700002)(36756003)(52116002)(6666004)(26005)(6512007)(8676002)(9686003)(2906002)(1076003)(4326008)(6506007)(66556008)(66476007)(44832011)(66946007)(186003)(508600001)(5660300002)(6486002)(6916009)(8936002)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r+endUKS2tH4qy8mbAy+FOZSm86MzaNNRsqgywnIPaAiR6oACV53kiMrma3o?=
 =?us-ascii?Q?T9NecI4CZ07G7TdH25X9E4kIeqidhXbGLzVsuHcMAjeJ8um08zX6XOxDh4ZB?=
 =?us-ascii?Q?0cRs19BQePDYPFqtXJqsLhFziRfZMUQ8qa2f+bMXix3PQ4NL8wnTvzaTiAyZ?=
 =?us-ascii?Q?MMk72jjtSuVHZ76w4L2D53IxFw/7VQYmYCFLQI7dbufE0Ea/0ids09Ze+Rkh?=
 =?us-ascii?Q?4cNr+OVoalYMMJI1xptDXkXWY3UTtIdRjINAg8JO453hPl9SkHA4s7L8Iks8?=
 =?us-ascii?Q?OrMScSL4ztOHyPGoXgj3OcAbo70i/bnTd3m9cyMvmS5UnYYVPWUmtIqA/fj1?=
 =?us-ascii?Q?HExzYgUCvasOfPOySoEPy1D0ZY/MXuJSAmBfvEhvopvi3tyOp3AmxFeGMTIb?=
 =?us-ascii?Q?huhBy3Z4HUFIBVNwtzf/CmIx+w1PkAm9zILOzYvBjcr1VJt3UVnIP5fMKPCt?=
 =?us-ascii?Q?h1s6pfkZh9ZOKFAaGywRl44KStoR+yAcYgdMPD4YfrrG8Xa/QZkIcZXcyH5u?=
 =?us-ascii?Q?Ezrt5ZCL7+Y1NVc5yR7f7z2LV8B1w+n/a1hpZi+D+p1X2z7nrnhccPxs2z8D?=
 =?us-ascii?Q?DjaTD4Ek4oT9sJj6CTWjMob864z3ifaueWjw8GZgHpoAY1dxEWmdAIJkv80L?=
 =?us-ascii?Q?cZbgmOR54/cokSXgSd29Nc2QJDJDrBzey08oRjIEqftjQGCSWXVNUJ2knAdQ?=
 =?us-ascii?Q?5ZJfxUAcne7wYc2bHWkdeUqA+QD+PNu09TjZAcpNml5HqtgeAjqZzEM1p5xs?=
 =?us-ascii?Q?qQfIld2v9qQe63gaHxh0iFeLXiTeN4tQ6KHqyejSA4wB1QFZBARVS658m3XJ?=
 =?us-ascii?Q?HZ8TDE4nJOmEVYhlVi0MNUNeOdKtpBWHhrk2IZXtZpp6AJbygGUhrCPb8328?=
 =?us-ascii?Q?Ss55RsfkcVhRb4RzR/W+PcdrbAsT5uER3vay6zmEfVpIUpLNBzdD7CI/nBhC?=
 =?us-ascii?Q?ugiAU1xZZPEHrFhpxVXjHoMp47Qkdv0eqOO6kpxsUCUm/qcwR43Ji2vijsr8?=
 =?us-ascii?Q?vf9pMLbK4+LauVZYMhmJo/iQEZFoJ+kPsS195ezhTowtdvtOJe+KrI7YJJza?=
 =?us-ascii?Q?4+nWdcCEyxFRhIWOy5mfDCelbkMP9iCqfIsjrE3ZdUt/Hah84MxfXZgZxyiB?=
 =?us-ascii?Q?nxzTyJ/qkwpnXbZFnU9IJzsHfT2FaUvJ/S9+Hc1Rliq7hinvTjH4LicOCGm0?=
 =?us-ascii?Q?xsNuWrvN6EC6g5t+mUrVCz3lUhJon48CSUEOdCioy5XLCQehs2llU9L4hilf?=
 =?us-ascii?Q?V+dJ5vak0mImaDHUvCzjZ4JJxPioH4kyGR4W/quhr/GtIgX2mcmg9rI3lJfo?=
 =?us-ascii?Q?wn/aNlHWx/9O1WYq+idh0yVUjOSC07NsKmR74NLrhG2j3lMlJNodsiix9umi?=
 =?us-ascii?Q?3NkuuRXYnKyvoWd3NeA2iWFw0KtAxa6iCh9PyYRz5DaoTbwYDsN33Ja91dxK?=
 =?us-ascii?Q?H8xUkP0KClpzak4o6jbh7c8eaz0PvEu3KRO7m8QwuCuA1wNsfu9PD6w9E0fT?=
 =?us-ascii?Q?QPq8b6F7lTZwh3emAtmIvZC6neJZQxJSozqJnofFqwDW3TEciUyG/BItwXKu?=
 =?us-ascii?Q?6j4VJCvE9l0SRSvZMrWopKK2nDuvTStvYF3Y+jRFOEb6HziGI0bQsVoQCqob?=
 =?us-ascii?Q?am09Ye9BtFjB3YwKoJ/s4aorsT+Kqzlew42mczlW5qd2MTi/ERxWlNXse0ZH?=
 =?us-ascii?Q?zFzBSC4oCCb89BGxvGE5D20e/Rw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73fb420e-6346-40f9-3573-08d9d045fab2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 12:22:03.1470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WmicAlBL7Df/6ojv6x/OAA8HGf9vs3UyM/Gu8ys5Q8FBO2OoPC6+DgLYuj0A6WkA9h4coZtx6N/0ns0TaWvvxyqX+ZS+yTvO8CcVIeLZV24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4499
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10217 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201050082
X-Proofpoint-ORIG-GUID: ARKE3fKLTUsCO3kNaas1KmiLooSmujle
X-Proofpoint-GUID: ARKE3fKLTUsCO3kNaas1KmiLooSmujle
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git pending
head:   34cbb4043dca455fca888e1ced323e588912b6a2
commit: bc5c448b70ff141f8a2b5cbbab79fba08d7a1be0 [52/56] ath11k: report rssi of each chain to mac80211 for QCA6390/WCN6855
config: riscv-randconfig-m031-20211210 (https://download.01.org/0day-ci/archive/20211211/202112110427.o6xDAKfE-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/net/wireless/ath/ath11k/wmi.c:5651 ath11k_wmi_tlv_fw_stats_data_parse() error: uninitialized symbol 'len'.

Old smatch warnings:
arch/riscv/include/asm/atomic.h:317 arch_atomic_sub_if_positive() warn: inconsistent indenting
drivers/net/wireless/ath/ath11k/wmi.c:5674 ath11k_wmi_tlv_fw_stats_data_parse() error: uninitialized symbol 'len'.
drivers/net/wireless/ath/ath11k/wmi.c:5695 ath11k_wmi_tlv_fw_stats_data_parse() error: uninitialized symbol 'len'.

vim +/len +5651 drivers/net/wireless/ath/ath11k/wmi.c

bc5c448b70ff14 Wen Gong   2021-12-08  5629  static int ath11k_wmi_tlv_fw_stats_data_parse(struct ath11k_base *ab,
bc5c448b70ff14 Wen Gong   2021-12-08  5630  					      struct wmi_tlv_fw_stats_parse *parse,
bc5c448b70ff14 Wen Gong   2021-12-08  5631  					      const void *ptr)
bc5c448b70ff14 Wen Gong   2021-12-08  5632  {
bc5c448b70ff14 Wen Gong   2021-12-08  5633  	struct ath11k_fw_stats *stats = parse->stats;
bc5c448b70ff14 Wen Gong   2021-12-08  5634  	const struct wmi_stats_event *ev = parse->ev;
bc5c448b70ff14 Wen Gong   2021-12-08  5635  	int i;
bc5c448b70ff14 Wen Gong   2021-12-08  5636  	const void *data = ptr;
bc5c448b70ff14 Wen Gong   2021-12-08  5637  	u32 len;
bc5c448b70ff14 Wen Gong   2021-12-08  5638  
bc5c448b70ff14 Wen Gong   2021-12-08  5639  	if (!ev) {
bc5c448b70ff14 Wen Gong   2021-12-08  5640  		ath11k_warn(ab, "failed to fetch update stats ev");
bc5c448b70ff14 Wen Gong   2021-12-08  5641  		return -EPROTO;
bc5c448b70ff14 Wen Gong   2021-12-08  5642  	}
d5c65159f28953 Kalle Valo 2019-11-23  5643  
d5c65159f28953 Kalle Valo 2019-11-23  5644  	stats->stats_id = 0;
d5c65159f28953 Kalle Valo 2019-11-23  5645  
d5c65159f28953 Kalle Valo 2019-11-23  5646  	for (i = 0; i < ev->num_pdev_stats; i++) {
d5c65159f28953 Kalle Valo 2019-11-23  5647  		const struct wmi_pdev_stats *src;
d5c65159f28953 Kalle Valo 2019-11-23  5648  		struct ath11k_fw_stats_pdev *dst;
d5c65159f28953 Kalle Valo 2019-11-23  5649  
d5c65159f28953 Kalle Valo 2019-11-23  5650  		src = data;
bc5c448b70ff14 Wen Gong   2021-12-08 @5651  		if (len < sizeof(*src))

"len" is never initialized.

d5c65159f28953 Kalle Valo 2019-11-23  5652  			return -EPROTO;
d5c65159f28953 Kalle Valo 2019-11-23  5653  
d5c65159f28953 Kalle Valo 2019-11-23  5654  		stats->stats_id = WMI_REQUEST_PDEV_STAT;
d5c65159f28953 Kalle Valo 2019-11-23  5655  
d5c65159f28953 Kalle Valo 2019-11-23  5656  		data += sizeof(*src);
d5c65159f28953 Kalle Valo 2019-11-23  5657  		len -= sizeof(*src);
d5c65159f28953 Kalle Valo 2019-11-23  5658  
d5c65159f28953 Kalle Valo 2019-11-23  5659  		dst = kzalloc(sizeof(*dst), GFP_ATOMIC);
d5c65159f28953 Kalle Valo 2019-11-23  5660  		if (!dst)
d5c65159f28953 Kalle Valo 2019-11-23  5661  			continue;
d5c65159f28953 Kalle Valo 2019-11-23  5662  
d5c65159f28953 Kalle Valo 2019-11-23  5663  		ath11k_wmi_pull_pdev_stats_base(&src->base, dst);
d5c65159f28953 Kalle Valo 2019-11-23  5664  		ath11k_wmi_pull_pdev_stats_tx(&src->tx, dst);
d5c65159f28953 Kalle Valo 2019-11-23  5665  		ath11k_wmi_pull_pdev_stats_rx(&src->rx, dst);
d5c65159f28953 Kalle Valo 2019-11-23  5666  		list_add_tail(&dst->list, &stats->pdevs);
d5c65159f28953 Kalle Valo 2019-11-23  5667  	}
d5c65159f28953 Kalle Valo 2019-11-23  5668  
d5c65159f28953 Kalle Valo 2019-11-23  5669  	for (i = 0; i < ev->num_vdev_stats; i++) {
d5c65159f28953 Kalle Valo 2019-11-23  5670  		const struct wmi_vdev_stats *src;
d5c65159f28953 Kalle Valo 2019-11-23  5671  		struct ath11k_fw_stats_vdev *dst;
d5c65159f28953 Kalle Valo 2019-11-23  5672  
d5c65159f28953 Kalle Valo 2019-11-23  5673  		src = data;
bc5c448b70ff14 Wen Gong   2021-12-08  5674  		if (len < sizeof(*src))
d5c65159f28953 Kalle Valo 2019-11-23  5675  			return -EPROTO;
d5c65159f28953 Kalle Valo 2019-11-23  5676  
d5c65159f28953 Kalle Valo 2019-11-23  5677  		stats->stats_id = WMI_REQUEST_VDEV_STAT;
d5c65159f28953 Kalle Valo 2019-11-23  5678  
d5c65159f28953 Kalle Valo 2019-11-23  5679  		data += sizeof(*src);
d5c65159f28953 Kalle Valo 2019-11-23  5680  		len -= sizeof(*src);
d5c65159f28953 Kalle Valo 2019-11-23  5681  
d5c65159f28953 Kalle Valo 2019-11-23  5682  		dst = kzalloc(sizeof(*dst), GFP_ATOMIC);
d5c65159f28953 Kalle Valo 2019-11-23  5683  		if (!dst)
d5c65159f28953 Kalle Valo 2019-11-23  5684  			continue;
d5c65159f28953 Kalle Valo 2019-11-23  5685  
d5c65159f28953 Kalle Valo 2019-11-23  5686  		ath11k_wmi_pull_vdev_stats(src, dst);
d5c65159f28953 Kalle Valo 2019-11-23  5687  		list_add_tail(&dst->list, &stats->vdevs);
d5c65159f28953 Kalle Valo 2019-11-23  5688  	}
d5c65159f28953 Kalle Valo 2019-11-23  5689  
d5c65159f28953 Kalle Valo 2019-11-23  5690  	for (i = 0; i < ev->num_bcn_stats; i++) {
d5c65159f28953 Kalle Valo 2019-11-23  5691  		const struct wmi_bcn_stats *src;
d5c65159f28953 Kalle Valo 2019-11-23  5692  		struct ath11k_fw_stats_bcn *dst;
d5c65159f28953 Kalle Valo 2019-11-23  5693  
d5c65159f28953 Kalle Valo 2019-11-23  5694  		src = data;
bc5c448b70ff14 Wen Gong   2021-12-08  5695  		if (len < sizeof(*src))
d5c65159f28953 Kalle Valo 2019-11-23  5696  			return -EPROTO;
d5c65159f28953 Kalle Valo 2019-11-23  5697  
d5c65159f28953 Kalle Valo 2019-11-23  5698  		stats->stats_id = WMI_REQUEST_BCN_STAT;
d5c65159f28953 Kalle Valo 2019-11-23  5699  
d5c65159f28953 Kalle Valo 2019-11-23  5700  		data += sizeof(*src);
d5c65159f28953 Kalle Valo 2019-11-23  5701  		len -= sizeof(*src);
d5c65159f28953 Kalle Valo 2019-11-23  5702  
d5c65159f28953 Kalle Valo 2019-11-23  5703  		dst = kzalloc(sizeof(*dst), GFP_ATOMIC);
d5c65159f28953 Kalle Valo 2019-11-23  5704  		if (!dst)
d5c65159f28953 Kalle Valo 2019-11-23  5705  			continue;
d5c65159f28953 Kalle Valo 2019-11-23  5706  
d5c65159f28953 Kalle Valo 2019-11-23  5707  		ath11k_wmi_pull_bcn_stats(src, dst);
d5c65159f28953 Kalle Valo 2019-11-23  5708  		list_add_tail(&dst->list, &stats->bcn);
d5c65159f28953 Kalle Valo 2019-11-23  5709  	}
d5c65159f28953 Kalle Valo 2019-11-23  5710  
d5c65159f28953 Kalle Valo 2019-11-23  5711  	return 0;
d5c65159f28953 Kalle Valo 2019-11-23  5712  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

