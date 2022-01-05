Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0520485508
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 15:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241086AbiAEOuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 09:50:08 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:64108 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241071AbiAEOuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 09:50:03 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 205D4UB0016995;
        Wed, 5 Jan 2022 14:49:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=5ae8k6KtUEsAUo5He/4VgkC6/hLacT5KNvRGtY3kiwk=;
 b=QuF3F7S0mRxwD/TtCjJ1ea68TngU18abM4Fr+KsrutiggHd/FUdbnti1S5v6EIXpUGrt
 VgTEeuYT/XpiYpYHHFt4OJp2qZO3ZKzK1r+l2cJPXcCY5Jg4MHULg46u8g2SxdB8v/FT
 nZRIR1zkwZl2RMQU21LSDe//gaylVDrPQKgQCex6ynGka3gEAWcL+1yZMYR51plVNt5m
 BpWAHhJKN/vtcx2PRyuQIe7x5IMP0PNtEIXBo415PtnKbB7bSboh5I59usDxPNadrn8O
 kmbbSvV8NbEkFzyak7ktUlOITMMegUwOtze9zcwGRrBaLGiCQjHLOd16pLf8tH9QzEDH 2w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc8q7vbpn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 14:49:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 205EfHYb096515;
        Wed, 5 Jan 2022 14:49:55 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by userp3020.oracle.com with ESMTP id 3dagdqkdxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 14:49:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IA09J5w8SJtYjxmHa854nvrPD5De0dCxV7u5fGJVXr0o7PLoDa69SJ0AWj8YsGwLLVkBmMCUWnemZK92uzF9Qy2n+5YA5y8mgO1SVk/npWvQyjeoPQt3SicxV0p3Uf0vB7nZ3p1oz1PDrlS9Ua2O/Yv76FH6sCKpVnPctv+BQ3pyJ2ESBQeIHhY1GhV8rIuIgNWqisIVABdqRTonEKu/vhlEEFKJnNQfuzpNG9U+k0w/bOyeFLFsnWEt9mXILXgoo3ZTcKNEihi2rsqKHNwqOn/nxq7pVb5pRvIPXSNkZQjQlBBtuG2cJAaeO3NbkCeOLrn5zow/J5fqbbgWFk7vXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ae8k6KtUEsAUo5He/4VgkC6/hLacT5KNvRGtY3kiwk=;
 b=lHleGW7YZNECRjW4AapF3WY+m7uHcBBfY6v2gFa8Ipsn9HfBIpUO/3d/NXcPb9Q0Ea1uHRkIWirRffnIftc88WGTW/caBXvRilIi/1oYa4E1EFBNjimOdw0jBk2ISkbc61XZi8Dbdroklx2CEegVCvZCBXVwd8PWzgmTp2FeahaAkGIMD+vgpNNRclVR+U0636x8qya/m3wD6VV/cZKCuzg5b5BybA+PzSF0A1BFCzUDfW4rc5U8r7SIv1Qemx23nqlZJzMUNXNKnSwilhqKCFbtx0VNfef+FZHXCCiwUzafhtE8pV83hSTGj9MlMApMaNlgOTDN1pndEc68DTsQbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ae8k6KtUEsAUo5He/4VgkC6/hLacT5KNvRGtY3kiwk=;
 b=iZ7Vr9ogUPRouR+1CUa5ZH4r8xkhdKGluu+tKWZlt7FX6XfMLchrLblfCfQy6yDKMABpryrTtS/H5OwfBcoUuPYysOdK/WbDHHu5ruQP8PBjU+AgUvyPYrvuqPyTI96us3S83LM16tmOzlcrXtvH3YfzZkm42Yw9eewgaf30uIA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 5 Jan
 2022 14:49:53 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 14:49:53 +0000
Date:   Wed, 5 Jan 2022 17:49:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Wen Gong <quic_wgong@quicinc.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Kalle Valo <kvalo@codeaurora.org>, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kalle Valo <quic_kvalo@quicinc.com>
Subject: [kvalo-ath:pending 8/17] drivers/net/wireless/ath/ath11k/dp_tx.c:511
 ath11k_dp_tx_update_txcompl() error: uninitialized symbol 'rate_idx'.
Message-ID: <202112230637.BasxPV7i-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0009.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 451eb2b3-1e6d-4d51-ac84-08d9d05aa1af
X-MS-TrafficTypeDiagnostic: CO1PR10MB4705:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4705FDC16B3A08D43128E0698E4B9@CO1PR10MB4705.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:51;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BfAHqhVXAH2C1Ntm4EiYcMtP1MP2Y0KZEnO7SAOi7B/hhH0sVFnwNMnDSa7aF6TPmy3WFtMS1DOiFShdDwmtEFBvf53mnsyJaVQIbmE3Y/RzhcIfM7dvdGdyg06xtqTxw2+X7I1HvAOP/sa9jfwUknzvpYQTf4GKAl43u803tXt+lek/GSIMn8Ow9TOIlPZfPENk/EbuA8z9RR/E2hFlqWQaWf4kAPPCsfbbGwK8HG8H+xI6MloUcaemTx1DO/GDPpgiMG4jqeyBmlFOl0tURKqmNBBR9f+pZ5OhktPopq1Z7m59ZFmwUXUVvoFS7z9OynhgEUMvjqw4TeeiMjQoBYkTwJLWLkX6qgeSdqzvPGIywCut/iBIRB+NbDi9NZipd/kqFjLFYr1zB6SE6P3ispXlnEkx3ccW8yByCkS6E5KALjZ6nxL1rDsmPK82nEb/KJIH4F13uGRGQfzc2nt6/GLK78mdinzwq8Yd5FhIOOIZCkqE/4VG+19ydjaqwygNUX8sKpDxQONv53ERy7I4gElDVd4uP2kLrWjXaaVbZPvZIoGTwUCFFHjNWs2uzkRY78pr5emZ4400JCbCP9R2ikDC9DCUs5l3YOyDVoRcTlbg5DTLRwvdKqGSYqJfXaQNwR8/vOfk7RSo8jUiKW/McfotjKZTL7WrtIFubT35Y3BgZL0LlVjCJt0NVQWcEcyFbxKQfOVVh25jmfkv4nqBFFHSqbpvkwCofyImzlDiJcnMS5Tw8gXMIxfBvIINPRI5fhudCqlSJRqROre1a/M7tAUcrwDg9TDZd0MyNNim7lMar16+PisLiSKJVUj+59dGNMP/327UI6MNxYfYqoJulA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(508600001)(38100700002)(38350700002)(83380400001)(44832011)(966005)(6916009)(66946007)(52116002)(6506007)(186003)(1076003)(26005)(4326008)(66556008)(6666004)(54906003)(9686003)(6512007)(2906002)(6486002)(5660300002)(316002)(4001150100001)(66476007)(8936002)(8676002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C5tbkIaa3KpMl4J6WW8RazkBMt9moZSOFEpmXXqJpn0HHB8oFkfOqXafbnrK?=
 =?us-ascii?Q?tWRoiiIFAtkt+ChxQz7T83d3lRcD+e6wdKLq/PWorpWzae6YUSgDQeIvUa7b?=
 =?us-ascii?Q?+ENZEeQjKKe2mD2ubj2iQibHyr16R7ZeTxUkpiWM+S8AkNUnIJ7LYiEwuJkC?=
 =?us-ascii?Q?3S+SatMAFQViS5dimTkn3Km4grWavL/wJkNEePwTEzUvL7XtPEQYxcdC/DHQ?=
 =?us-ascii?Q?M9NdUmLVqmwlZemclLttkl5HNeSfogfAZ6RSprgm3+DJENQMDAGc6C/eOw2r?=
 =?us-ascii?Q?3/eoXNI4XtM9pPIfW+yZRI9ujHZegN8QpcHpiS4yN/gaJumZ1CggmyAIKAti?=
 =?us-ascii?Q?Vr5IhqiL/KVsffFA96NSXIXcMvej8yUzOBo2InoASztcEOEXH/Q1H0uE1ryZ?=
 =?us-ascii?Q?WXjSU6gjyS05canWgMBn6UVdTu57eo/sl+veHHIHe9t5d+DQVIYo617fXsVo?=
 =?us-ascii?Q?5gKBdtJJAGl5nHPzolGdkGVN/KpyS/nUrc90YKT2vG3X4SrvECDZxBHuv2jP?=
 =?us-ascii?Q?iyI3Qp0K2yXscQEoGjOxHlo22VqT0ANHn30OXTkbRnIBhISLDXNtTQAz7Rq6?=
 =?us-ascii?Q?u8iAj9s5kRNzFR6JLH3zZcJNJwdjA0mQ8PFwQxmWqDaRJpKgh8JD28gMzIpc?=
 =?us-ascii?Q?yP+NZFqLfs+aeeHMHHggeHMIW3yXThr9Lf7ydJ2tsB3X0RWN89cWZ3a6N/k8?=
 =?us-ascii?Q?CpDgSrQr7uRY1brRQC9fJdKNupuEE23GIqAR5/L0O23KNZXbeZnybnJv4czi?=
 =?us-ascii?Q?LZ2dA92JN8bQDr7EC+2sIjWVxj/4+mMCFCNDGmMdbZ2P+TTg2bzP4dxGQAoN?=
 =?us-ascii?Q?Uyr1uHfLh2mONUbNujMEWqSLwyjWuS9yLyRfWK+iCtdr5+QkrBi1z8M+NfT+?=
 =?us-ascii?Q?QvYlBzQg5g27mj92kYsVHA+6y9oOHAZg8EDWDj/oszurBHBLbrfyELhrgFJN?=
 =?us-ascii?Q?XcEXlxnOmXL+I8NpcIA1icVSZch4M0iSufwGQbthC6R8CATJS5tAx35oaUvd?=
 =?us-ascii?Q?TgjaOxcaFn2S4OmnRmzZgaqXr2AB5GhG/RnNR7fZ2Z8v2AmdE94nOY6tsAZp?=
 =?us-ascii?Q?EJt3OTuxoenm514YVdx3droTP+KC7ic4BX2xzyttaqpOVHyzzPIiUFElZr6R?=
 =?us-ascii?Q?6LDo6LmoEeFM2BHpqS3Gad9V49OXjwy35lrHmmpsgSrWkkHPy+Gm5yiC7ZhW?=
 =?us-ascii?Q?W689ue3H2Q0qBXUU17On2/XMzWDaM2XeDl4XNc/IhWLcdRId5ra3x29TDCo1?=
 =?us-ascii?Q?cqrqLt3GvqIRwE89qo6hYcUe/MkZ0LAPOhEubt7IKh+UaLtJ6hSbLu0WxA+6?=
 =?us-ascii?Q?SjMAUpSAOVLqWWx/8nLu06zlO2tbe2b5OEabvCJOgxBAPb+6IxszZfS7RWVo?=
 =?us-ascii?Q?9RtFJnfJuUxx/GkjrtTEA19aMa/158d/udjWpuMpYIrkLZu/ejzcghqrR/cC?=
 =?us-ascii?Q?K9GIryRWtl2rIi+X17t125vBqP6bpABB6Y3Ha/dZzIrFW0/rVGkXYUEeNcFq?=
 =?us-ascii?Q?cmI42bDL5/OwhVcD9sLMXpxAKBFYOvaPGvvE8vyGz8SR162QqnFUOqhswrUr?=
 =?us-ascii?Q?F2Das+A/Qne3vkB8wp6t21bNDi5/QpEDq0HhDIIYiIjaXNdOCQPe9meaza6o?=
 =?us-ascii?Q?WO1rIWoR7EIQ5GL5uEpA/PqFolppv3JI9zIs169lc4s3QBjRZWxZtZOtmyZr?=
 =?us-ascii?Q?gUsKPq33gF5l6vQVrINyTiws2OE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 451eb2b3-1e6d-4d51-ac84-08d9d05aa1af
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 14:49:53.1351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IuSQQEJLhfYoVk6VqNo+CNyUjMXN+j83faRGU2bHq1RukR8diNpRBm7mMOEVF8wc0LoSaUNuWPUgFcG5HqRvh+eF8+46VUoA4gNQPtw7kF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4705
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10217 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201050098
X-Proofpoint-GUID: TZ0KsZxzD4hew_P7vJn3dgTTdfnjTS1h
X-Proofpoint-ORIG-GUID: TZ0KsZxzD4hew_P7vJn3dgTTdfnjTS1h
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git pending
head:   c9a516b946c4b3ce25d422890ca78d0ca730b065
commit: 1b8bb94c0612cf32e418e90ae93cf37214d84669 [8/17] ath11k: report tx bitrate for iw wlan station dump
config: microblaze-randconfig-m031-20211222 (https://download.01.org/0day-ci/archive/20211223/202112230637.BasxPV7i-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/net/wireless/ath/ath11k/dp_tx.c:511 ath11k_dp_tx_update_txcompl() error: uninitialized symbol 'rate_idx'.

vim +/rate_idx +511 drivers/net/wireless/ath/ath11k/dp_tx.c

1b8bb94c0612cf Wen Gong   2021-12-20  418  void ath11k_dp_tx_update_txcompl(struct ath11k *ar, struct hal_tx_status *ts)
1b8bb94c0612cf Wen Gong   2021-12-20  419  {
1b8bb94c0612cf Wen Gong   2021-12-20  420  	struct ath11k_base *ab = ar->ab;
1b8bb94c0612cf Wen Gong   2021-12-20  421  	struct ath11k_per_peer_tx_stats *peer_stats = &ar->cached_stats;
1b8bb94c0612cf Wen Gong   2021-12-20  422  	enum hal_tx_rate_stats_pkt_type pkt_type;
1b8bb94c0612cf Wen Gong   2021-12-20  423  	enum hal_tx_rate_stats_sgi sgi;
1b8bb94c0612cf Wen Gong   2021-12-20  424  	enum hal_tx_rate_stats_bw bw;
1b8bb94c0612cf Wen Gong   2021-12-20  425  	struct ath11k_peer *peer;
1b8bb94c0612cf Wen Gong   2021-12-20  426  	struct ath11k_sta *arsta;
1b8bb94c0612cf Wen Gong   2021-12-20  427  	struct ieee80211_sta *sta;
1b8bb94c0612cf Wen Gong   2021-12-20  428  	u16 rate, ru_tones;
1b8bb94c0612cf Wen Gong   2021-12-20  429  	u8 mcs, rate_idx, ofdma;
1b8bb94c0612cf Wen Gong   2021-12-20  430  	int ret;
1b8bb94c0612cf Wen Gong   2021-12-20  431  
1b8bb94c0612cf Wen Gong   2021-12-20  432  	spin_lock_bh(&ab->base_lock);
1b8bb94c0612cf Wen Gong   2021-12-20  433  	peer = ath11k_peer_find_by_id(ab, ts->peer_id);
1b8bb94c0612cf Wen Gong   2021-12-20  434  	if (!peer || !peer->sta) {
1b8bb94c0612cf Wen Gong   2021-12-20  435  		ath11k_dbg(ab, ATH11K_DBG_DP_TX,
1b8bb94c0612cf Wen Gong   2021-12-20  436  			   "failed to find the peer by id %u\n", ts->peer_id);
1b8bb94c0612cf Wen Gong   2021-12-20  437  		goto err_out;
1b8bb94c0612cf Wen Gong   2021-12-20  438  	}
1b8bb94c0612cf Wen Gong   2021-12-20  439  
1b8bb94c0612cf Wen Gong   2021-12-20  440  	sta = peer->sta;
1b8bb94c0612cf Wen Gong   2021-12-20  441  	arsta = (struct ath11k_sta *)sta->drv_priv;
1b8bb94c0612cf Wen Gong   2021-12-20  442  
1b8bb94c0612cf Wen Gong   2021-12-20  443  	memset(&arsta->txrate, 0, sizeof(arsta->txrate));
1b8bb94c0612cf Wen Gong   2021-12-20  444  	pkt_type = FIELD_GET(HAL_TX_RATE_STATS_INFO0_PKT_TYPE,
1b8bb94c0612cf Wen Gong   2021-12-20  445  			     ts->rate_stats);
1b8bb94c0612cf Wen Gong   2021-12-20  446  	mcs = FIELD_GET(HAL_TX_RATE_STATS_INFO0_MCS,
1b8bb94c0612cf Wen Gong   2021-12-20  447  			ts->rate_stats);
1b8bb94c0612cf Wen Gong   2021-12-20  448  	sgi = FIELD_GET(HAL_TX_RATE_STATS_INFO0_SGI,
1b8bb94c0612cf Wen Gong   2021-12-20  449  			ts->rate_stats);
1b8bb94c0612cf Wen Gong   2021-12-20  450  	bw = FIELD_GET(HAL_TX_RATE_STATS_INFO0_BW, ts->rate_stats);
1b8bb94c0612cf Wen Gong   2021-12-20  451  	ru_tones = FIELD_GET(HAL_TX_RATE_STATS_INFO0_TONES_IN_RU, ts->rate_stats);
1b8bb94c0612cf Wen Gong   2021-12-20  452  	ofdma = FIELD_GET(HAL_TX_RATE_STATS_INFO0_OFDMA_TX, ts->rate_stats);
1b8bb94c0612cf Wen Gong   2021-12-20  453  
1b8bb94c0612cf Wen Gong   2021-12-20  454  	/* This is to prefer choose the real NSS value arsta->last_txrate.nss,
1b8bb94c0612cf Wen Gong   2021-12-20  455  	 * if it is invalid, then choose the NSS value while assoc.
1b8bb94c0612cf Wen Gong   2021-12-20  456  	 */
1b8bb94c0612cf Wen Gong   2021-12-20  457  	if (arsta->last_txrate.nss)
1b8bb94c0612cf Wen Gong   2021-12-20  458  		arsta->txrate.nss = arsta->last_txrate.nss;
1b8bb94c0612cf Wen Gong   2021-12-20  459  	else
1b8bb94c0612cf Wen Gong   2021-12-20  460  		arsta->txrate.nss = arsta->peer_nss;
1b8bb94c0612cf Wen Gong   2021-12-20  461  
1b8bb94c0612cf Wen Gong   2021-12-20  462  	if (pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11A ||
1b8bb94c0612cf Wen Gong   2021-12-20  463  	    pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11B) {
1b8bb94c0612cf Wen Gong   2021-12-20  464  		ret = ath11k_mac_hw_ratecode_to_legacy_rate(mcs,
1b8bb94c0612cf Wen Gong   2021-12-20  465  							    pkt_type,
1b8bb94c0612cf Wen Gong   2021-12-20  466  							    &rate_idx,
1b8bb94c0612cf Wen Gong   2021-12-20  467  							    &rate);
1b8bb94c0612cf Wen Gong   2021-12-20  468  		if (ret < 0)
1b8bb94c0612cf Wen Gong   2021-12-20  469  			goto err_out;

"rate_idx" not initialized on other paths.

1b8bb94c0612cf Wen Gong   2021-12-20  470  		arsta->txrate.legacy = rate;
1b8bb94c0612cf Wen Gong   2021-12-20  471  	} else if (pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11N) {
1b8bb94c0612cf Wen Gong   2021-12-20  472  		if (mcs > 7) {
1b8bb94c0612cf Wen Gong   2021-12-20  473  			ath11k_warn(ab, "Invalid HT mcs index %d\n", mcs);
1b8bb94c0612cf Wen Gong   2021-12-20  474  			goto err_out;
1b8bb94c0612cf Wen Gong   2021-12-20  475  		}
1b8bb94c0612cf Wen Gong   2021-12-20  476  
1b8bb94c0612cf Wen Gong   2021-12-20  477  		if (arsta->txrate.nss != 0)
1b8bb94c0612cf Wen Gong   2021-12-20  478  			arsta->txrate.mcs = mcs + 8 * (arsta->txrate.nss - 1);
1b8bb94c0612cf Wen Gong   2021-12-20  479  		arsta->txrate.flags = RATE_INFO_FLAGS_MCS;
1b8bb94c0612cf Wen Gong   2021-12-20  480  		if (sgi)
1b8bb94c0612cf Wen Gong   2021-12-20  481  			arsta->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
1b8bb94c0612cf Wen Gong   2021-12-20  482  	} else if (pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11AC) {
1b8bb94c0612cf Wen Gong   2021-12-20  483  		if (mcs > 9) {
1b8bb94c0612cf Wen Gong   2021-12-20  484  			ath11k_warn(ab, "Invalid VHT mcs index %d\n", mcs);
1b8bb94c0612cf Wen Gong   2021-12-20  485  			goto err_out;
1b8bb94c0612cf Wen Gong   2021-12-20  486  		}
1b8bb94c0612cf Wen Gong   2021-12-20  487  
1b8bb94c0612cf Wen Gong   2021-12-20  488  		arsta->txrate.mcs = mcs;
1b8bb94c0612cf Wen Gong   2021-12-20  489  		arsta->txrate.flags = RATE_INFO_FLAGS_VHT_MCS;
1b8bb94c0612cf Wen Gong   2021-12-20  490  		if (sgi)
1b8bb94c0612cf Wen Gong   2021-12-20  491  			arsta->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
1b8bb94c0612cf Wen Gong   2021-12-20  492  	} else if (pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11AX) {
1b8bb94c0612cf Wen Gong   2021-12-20  493  		if (mcs > 11) {
1b8bb94c0612cf Wen Gong   2021-12-20  494  			ath11k_warn(ab, "Invalid HE mcs index %d\n", mcs);
1b8bb94c0612cf Wen Gong   2021-12-20  495  			goto err_out;
1b8bb94c0612cf Wen Gong   2021-12-20  496  		}
1b8bb94c0612cf Wen Gong   2021-12-20  497  
1b8bb94c0612cf Wen Gong   2021-12-20  498  		arsta->txrate.mcs = mcs;
1b8bb94c0612cf Wen Gong   2021-12-20  499  		arsta->txrate.flags = RATE_INFO_FLAGS_HE_MCS;
1b8bb94c0612cf Wen Gong   2021-12-20  500  		arsta->txrate.he_gi = ath11k_mac_he_gi_to_nl80211_he_gi(sgi);
1b8bb94c0612cf Wen Gong   2021-12-20  501  	}
1b8bb94c0612cf Wen Gong   2021-12-20  502  
1b8bb94c0612cf Wen Gong   2021-12-20  503  	arsta->txrate.bw = ath11k_mac_bw_to_mac80211_bw(bw);
1b8bb94c0612cf Wen Gong   2021-12-20  504  	if (ofdma && pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11AX) {
1b8bb94c0612cf Wen Gong   2021-12-20  505  		arsta->txrate.bw = RATE_INFO_BW_HE_RU;
1b8bb94c0612cf Wen Gong   2021-12-20  506  		arsta->txrate.he_ru_alloc =
1b8bb94c0612cf Wen Gong   2021-12-20  507  			ath11k_mac_he_ru_tones_to_nl80211_he_ru_alloc(ru_tones);
1b8bb94c0612cf Wen Gong   2021-12-20  508  	}
1b8bb94c0612cf Wen Gong   2021-12-20  509  
1b8bb94c0612cf Wen Gong   2021-12-20  510  	if (ath11k_debugfs_is_extd_tx_stats_enabled(ar))
1b8bb94c0612cf Wen Gong   2021-12-20 @511  		ath11k_debugfs_sta_add_tx_stats(arsta, peer_stats, rate_idx);
                                                                                                           ^^^^^^^^



1b8bb94c0612cf Wen Gong   2021-12-20  512  
1b8bb94c0612cf Wen Gong   2021-12-20  513  err_out:
1b8bb94c0612cf Wen Gong   2021-12-20  514  	spin_unlock_bh(&ab->base_lock);
1b8bb94c0612cf Wen Gong   2021-12-20  515  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

