Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB84485093
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239162AbiAEKDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:03:24 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:27028 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230306AbiAEKDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:03:18 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2056w0or025093;
        Wed, 5 Jan 2022 10:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=wQBQt5gUtcA6xusiNYzbpALxKOED3HrqK0tXfMjzUPE=;
 b=xzQbg9a0H5vR68B4+fQ0oSBumH78b33zD/FyaUodRuPOj6cpcEOpqaK+o//FKXJVD4CP
 XlpcHW+qB5ciHjU+LmpF+6eS6cCHDMDvCMbWyBEFUvocweQWliOvbNCQJ9/9EAfQs6Rg
 rf3z9K7p0/vqz1aiGCbBrx780C2EJQ1HieAJPJIH2JJBSsFVBpDkkUypFpmcXcAOA1bk
 IZnlwil8R4orskAAGsMT8cBokxntpyY4jAyudp1fEoktdizKdPyIFDhHyHDmi85eO6dB
 8Cl3ofDkKFtOkyecv0T3ZH4yrKUAroKp13iRQR9VMd0izBc46ZPDgJA7BdD2/e2X9Kye uw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc43gcen9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 10:03:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2059tHMK188827;
        Wed, 5 Jan 2022 10:03:13 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by userp3020.oracle.com with ESMTP id 3dagdq6rae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 10:03:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVrHKXHmIZ8dwFHYrtuK9tKy5Kdl5DuahqB+By96FkWNrMgschi7r2TpGR205h9NDDdgHuziKPJoupE0/v5/agv0shiouMHzN/OUnSSvgK2Qc010KZc4fHnXU3mK4KlxIgS29jL0bMg7VUTqG5C1p+VRpMn19Gmdijf0iCTyxLRW1DgxNqm4slcjS0JyRDwCI1ak6PcmSVs3FseszdXz35OKMm+L6TxYkoz0BNXjt5fz+aQFk2ZZ+PdEKHYQYMMKFVnoSqnFaG8uiEJdbSL+Be6Lv9/Dmv3wtN8+pb9DT0Wfl3SRfVG9GoD7AI+z0CvrOyLuBep29cHdcwjcY2YCgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQBQt5gUtcA6xusiNYzbpALxKOED3HrqK0tXfMjzUPE=;
 b=ATwRUMVB0ZW9n4xgNuQpCfTetLqdEdmTjOweXLuqVJjBwLNp2kXmmZMgv9BR0ISLtuDANJyDAi/WAjQqlioFVRlf1XOIyE6EgVOLDCpAk2I6/Vzui+vM3GDxmZXWxLrsqTxYq8Lp0eovUuDXgQ2snDn2c8f/nl8dZssXayenrdZCJEkNRvAsNW2MSG7g+oCJK9I8m1kBS9WnuC1DiVPDUIDceHixkl1C0rJZrpSCm4X+ucj5jTbGFadX1W5DaNgdZjmJ7k3jyWXviYESU+5YBO8VA1ZX8q1oXpaAMUDbo62y3tqWrD+qP30z2dzXuHv3h/CdMzhkB0CSluR6n/Y6Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQBQt5gUtcA6xusiNYzbpALxKOED3HrqK0tXfMjzUPE=;
 b=iF3/wGJzFUM96192Q/Irg/PCx6OiWCTzlMaCofInVTTRA6/pI/bCntLsGB7lFU/YyPHTBA8EUXRoNTcmemjzBFnX2w0zHdYVgX8QF2ameEfN8Y7aRjXfbhQquhf0AcYPmyW/SLcLiF/oVouBCcft5Rh/5VWdJ9HSFLB/f0NDkig=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1728.namprd10.prod.outlook.com
 (2603:10b6:301:9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 10:03:11 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 10:03:10 +0000
Date:   Wed, 5 Jan 2022 13:02:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Andrea Arcangeli <aarcange@redhat.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [andrea-aa:main 44/48] mm/ksm.c:2134 cmp_and_merge_page() error:
 uninitialized symbol 'checksum'.
Message-ID: <202112190517.NPcuhEOX-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0036.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::6)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0ac8ddb-573a-4286-b544-08d9d032946d
X-MS-TrafficTypeDiagnostic: MWHPR10MB1728:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1728B860815C7777050502448E4B9@MWHPR10MB1728.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kcc74YHcguMwW91qh28RPhDHafE7H3YXF1ue16ITOsPCDclJGpRCG03tK0+mf/veLAxSkbhjWlKbffg6QMcgBPQqGkKnLAk7VcatN5QOtajhLWA/CIi7XSwQz9X+KP+EnYbtStpI02ocu/IZtFG/OGJHCYyAi+VzYup3GlPBumLMyAyrq5BDn9IXIwrqEhr78F5w6Su5Fie7Jz/rdfa7SAYaNAw6XY6rWCD23rFajNrzsy7lbrspXRaOOopNyhar36SUzBi4J+zuaZiB55nFfHXu6LJvLGc2rGLwY4wzw58pBdNyszYbd/lcCLd2dRKtkPvfPzm+sKnGXE/yh1azwy6EG5moTbZGaVMGpVxtz13TZyXYK/vZSvQ0jmrYjakCVnVGphRtgzRZ648gjdiyaAbDZBYLE2XpCtRMXlg8vu+TYFpj7z9FxTodrwznCsUQDZYpKuHHFelF3mmpCh22mRgoneh65PEaA7Je9pS+yJr3LFV+O9AcdE5pMF24VRsDBybnjlZVTz9GsfIXLfMmPdAyRWUh1n4LsoKzLvynyTyQyUSZiwX8+7KVLGi42siumzQRuRuvoOs8P2uBRTRz9R/lAQM2ZrzTVIm9FtUVYQrbeMyPrj33+hDUxy6miz3f9MP0etl7IZdthiGG3FNVS8SAyLGtXSbDpd4RT63s2ilwKJD6c/LZ7AERJjHvBZbTOfaAiXDkI43rYUpsbvosFim3iHvqV/+h4A9z6MckC1wJepGwk48Mc1wvz1GlK0KAAw68Z8wDmSXrVQPSmArHv9VViVTL0nk3/GAFkPkUogqcm5l2/LujPEYCNe3+OLLT3aQaNV8Wa41VtYk0Inyz6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(86362001)(6916009)(44832011)(4326008)(52116002)(186003)(9686003)(508600001)(6506007)(6486002)(966005)(316002)(1076003)(4001150100001)(30864003)(66476007)(66556008)(83380400001)(2906002)(8676002)(6666004)(38100700002)(38350700002)(6512007)(5660300002)(66946007)(26005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d22ZacWaNZ7HQIg34FsBgkaTV2mg+GqWqWSpqFi9tZk44eZvgj4mmNU8A8Ud?=
 =?us-ascii?Q?kYGEniwYvNSYanB8qnYLbBMbPjJufIwQNxsV7qZO8EkBjTS65WeGXs207fp+?=
 =?us-ascii?Q?I7ppywMFAFp+MjsMOGOxvZf82syanCaBPEtF21vBvv8bZJgOewIBG4KOG4NA?=
 =?us-ascii?Q?YinJT4pzhn7lCA60Ta/tK5Ds2NwxPYq/G85zUwdgD8nSDwdu2XQV2pobLWHu?=
 =?us-ascii?Q?6jYu4niXamX+6gnEWwJ2Z9jR4ZjDuvEz3RkZm5/kSQJrIOhV0DIMAr8e4yVY?=
 =?us-ascii?Q?FjoBE46bI8yrN6Ayv4M341dN0MEkVx67mF882c0Hwrd8MKk0ChxYlEb3nCeZ?=
 =?us-ascii?Q?Ldsp1BrNwm7mdI7eRzf4+iY5j7sBVZM0s5Hc3GHuxi447vyjJ8I6+P1/8Sd5?=
 =?us-ascii?Q?klSeiu59ItJJcx88P1xcfK28uvQ/uo8rq3qMK8adIApim7PDCaqD4eOqj97u?=
 =?us-ascii?Q?GhX3ZSkehxS5Z7ArUfkUzb9SOWBpPZU0+MDoEwA+hCwpeVIaGRdMClNJQL0Z?=
 =?us-ascii?Q?z9CIjT09G1vdI2NocqvNFybL5AMpuYBGar9OLBvMIjodADpr0JbuZo3bXg1v?=
 =?us-ascii?Q?m3azaosKICL9EajsSrjonZIMWqj9oUbSgQbzki+JyR9xJXxOUifhXgIrFWv7?=
 =?us-ascii?Q?vFsAKn0hShaK96PAYSuhgkxM5yezMjRj3gOPxO8qYXwxFS+Nfzn1htoxRgJB?=
 =?us-ascii?Q?RzjvVNDVtCa3VnBUGNM246asY4YBTBepf6Ny5KdyWRMBWIL7wLyLRXgCYogc?=
 =?us-ascii?Q?Vd/gU7Q9pjCzHSkHz4qx76cZAZjnPSp0r8+o9+ZHJ4KCUMA1Of7+fL+8r7Dg?=
 =?us-ascii?Q?4IMwaYFUNB14yvlfx33wP8rMJ/5lPgPHKYrH7Wl+4Qagu8UzBkRKdNVvQuQb?=
 =?us-ascii?Q?GhS8GvtH4/V8Ji96mYndLpsBoMxkJtCG86B8HCULBnDkf0Bg2FGCsLi4Ab7p?=
 =?us-ascii?Q?pj7LDoHCbzCxX1zJkva5bdiNnxqwBg56Pl4hUNts9Ql0OwRNM5z0gwTdLzuu?=
 =?us-ascii?Q?Az+CiYNLyZF1Yx6SgSBnukL+IhN69M2t8h/mx9dGZtaqbg7sPTLJXEDnGIwt?=
 =?us-ascii?Q?ksg6Ri1/tXIIQvMnjYvotTNWvEkkRDBZN3ihWeUxjt/hLqFbPfWk0zvjO4KJ?=
 =?us-ascii?Q?n2nOxCCQptAgpHtY7IOG4Owdk3jULgO1xTn4PR4G7ASI0gyqqugq6xeSpCOC?=
 =?us-ascii?Q?gpzL5QZLOPYgjRmfZWw3REellswGmmwvaUCzf2dhvc4prx0AHMd9yE30zIYI?=
 =?us-ascii?Q?q3xHHENd5RgNVM9qaeTC19+xJzGdVUd+/odp5elqYt4LqoUoVAyQToDvPO2T?=
 =?us-ascii?Q?B5pTEmzKVNx+CLD9DF/1HX5eWgelhNRTt1PU5DOkl4IG5Sh4aQEcUf1tZu0x?=
 =?us-ascii?Q?GguZtP61DjCfP/lmP87/WFbMTB1uyLIakQFYEChAFbcGaR4Bdg1/Lzroo5v/?=
 =?us-ascii?Q?pv0XNLzfOFD2QobP7YNjNXaiKQr4pxz7yVwk1i4UZNYBYfur20zS0/wZxcc6?=
 =?us-ascii?Q?YZhA7D1WasYLcju/5/015SF6ezk7qyuh9YQkv+yYDb2jmIEp+2WEMfivnNbB?=
 =?us-ascii?Q?AFVZOMDpL42v23BLdG+a6CKmaezdSF2376lQhIRyj+l8eE7wF6J9IUbqmVgo?=
 =?us-ascii?Q?CHONTPGEOvlLMVbeMUNW4U+4O5LyzbCsKtg9wAyloQI4j6W7a3FRwCJGUdF6?=
 =?us-ascii?Q?y7A15CeRTUgbjuwcCNRTsCbUfA0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ac8ddb-573a-4286-b544-08d9d032946d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 10:03:10.8201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BWF2AoyCGznFzHm3op6kff13IvBBzduJWev+Ek6EAbFWNKjytLzQqFjKKIvtL6aesI6b1lhOvvbxoGafWV0MDk1+0gU2qoZYgoVHC+ohWp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1728
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10217 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201050066
X-Proofpoint-GUID: jtkaFftHerYXLhIRKlr0El_q9S0-ekI5
X-Proofpoint-ORIG-GUID: jtkaFftHerYXLhIRKlr0El_q9S0-ekI5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/andrea/aa.git main
head:   2f1336124b54750df7ae428da9352e4d8091f31e
commit: fec43fa50ccf8365ae2a8d9f150970ab6ca42b18 [44/48] KSM: only attempt to merge with KSM pages if the payload doesn't change
config: i386-randconfig-m021-20211218 (https://download.01.org/0day-ci/archive/20211219/202112190517.NPcuhEOX-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
mm/ksm.c:2134 cmp_and_merge_page() error: uninitialized symbol 'checksum'.

vim +/checksum +2134 mm/ksm.c

31dbd01f314364 Izik Eidus        2009-09-21  2059  static void cmp_and_merge_page(struct page *page, struct rmap_item *rmap_item)
31dbd01f314364 Izik Eidus        2009-09-21  2060  {
4b22927f0cbd58 Kirill Tkhai      2017-10-03  2061  	struct mm_struct *mm = rmap_item->mm;
31dbd01f314364 Izik Eidus        2009-09-21  2062  	struct rmap_item *tree_rmap_item;
8dd3557a52f0bc Hugh Dickins      2009-12-14  2063  	struct page *tree_page = NULL;
7b6ba2c7d3baf8 Hugh Dickins      2009-12-14  2064  	struct stable_node *stable_node;
8dd3557a52f0bc Hugh Dickins      2009-12-14  2065  	struct page *kpage;
31dbd01f314364 Izik Eidus        2009-09-21  2066  	unsigned int checksum;
31dbd01f314364 Izik Eidus        2009-09-21  2067  	int err;
2c653d0ee2ae78 Andrea Arcangeli  2017-07-06  2068  	bool max_page_sharing_bypass = false;
31dbd01f314364 Izik Eidus        2009-09-21  2069  
4146d2d673e8d6 Hugh Dickins      2013-02-22  2070  	stable_node = page_stable_node(page);
4146d2d673e8d6 Hugh Dickins      2013-02-22  2071  	if (stable_node) {
4146d2d673e8d6 Hugh Dickins      2013-02-22  2072  		if (stable_node->head != &migrate_nodes &&
2c653d0ee2ae78 Andrea Arcangeli  2017-07-06  2073  		    get_kpfn_nid(READ_ONCE(stable_node->kpfn)) !=
2c653d0ee2ae78 Andrea Arcangeli  2017-07-06  2074  		    NUMA(stable_node->nid)) {
2c653d0ee2ae78 Andrea Arcangeli  2017-07-06  2075  			stable_node_dup_del(stable_node);
4146d2d673e8d6 Hugh Dickins      2013-02-22  2076  			stable_node->head = &migrate_nodes;
4146d2d673e8d6 Hugh Dickins      2013-02-22  2077  			list_add(&stable_node->list, stable_node->head);
4146d2d673e8d6 Hugh Dickins      2013-02-22  2078  		}
4146d2d673e8d6 Hugh Dickins      2013-02-22  2079  		if (stable_node->head != &migrate_nodes &&
4146d2d673e8d6 Hugh Dickins      2013-02-22  2080  		    rmap_item->head == stable_node)
4146d2d673e8d6 Hugh Dickins      2013-02-22  2081  			return;
2c653d0ee2ae78 Andrea Arcangeli  2017-07-06  2082  		/*
2c653d0ee2ae78 Andrea Arcangeli  2017-07-06  2083  		 * If it's a KSM fork, allow it to go over the sharing limit
2c653d0ee2ae78 Andrea Arcangeli  2017-07-06  2084  		 * without warnings.
2c653d0ee2ae78 Andrea Arcangeli  2017-07-06  2085  		 */
2c653d0ee2ae78 Andrea Arcangeli  2017-07-06  2086  		if (!is_page_sharing_candidate(stable_node))
2c653d0ee2ae78 Andrea Arcangeli  2017-07-06  2087  			max_page_sharing_bypass = true;
fec43fa50ccf83 Andrea Arcangeli  2021-11-23  2088  	} else {
fec43fa50ccf83 Andrea Arcangeli  2021-11-23  2089  		/*
fec43fa50ccf83 Andrea Arcangeli  2021-11-23  2090  		 * If the hash value of the page has changed from the last
fec43fa50ccf83 Andrea Arcangeli  2021-11-23  2091  		 * time we calculated it, this page is changing frequently:
fec43fa50ccf83 Andrea Arcangeli  2021-11-23  2092  		 * therefore we don't want to write protect it.
fec43fa50ccf83 Andrea Arcangeli  2021-11-23  2093  		 */
fec43fa50ccf83 Andrea Arcangeli  2021-11-23  2094  		checksum = calc_checksum(page);

"checksum" initialized here.  Not intialized for stable_node.

fec43fa50ccf83 Andrea Arcangeli  2021-11-23  2095  		if (rmap_item->oldchecksum != checksum) {
fec43fa50ccf83 Andrea Arcangeli  2021-11-23  2096  			rmap_item->oldchecksum = checksum;
fec43fa50ccf83 Andrea Arcangeli  2021-11-23  2097  			remove_rmap_item_from_tree(rmap_item);
fec43fa50ccf83 Andrea Arcangeli  2021-11-23  2098  			return;
fec43fa50ccf83 Andrea Arcangeli  2021-11-23  2099  		}
4146d2d673e8d6 Hugh Dickins      2013-02-22  2100  	}
31dbd01f314364 Izik Eidus        2009-09-21  2101  
31dbd01f314364 Izik Eidus        2009-09-21  2102  	/* We first start with searching the page inside the stable tree */
62b61f611eb5e2 Hugh Dickins      2009-12-14  2103  	kpage = stable_tree_search(page);
4146d2d673e8d6 Hugh Dickins      2013-02-22  2104  	if (kpage == page && rmap_item->head == stable_node) {
4146d2d673e8d6 Hugh Dickins      2013-02-22  2105  		put_page(kpage);
4146d2d673e8d6 Hugh Dickins      2013-02-22  2106  		return;
4146d2d673e8d6 Hugh Dickins      2013-02-22  2107  	}
4146d2d673e8d6 Hugh Dickins      2013-02-22  2108  
4146d2d673e8d6 Hugh Dickins      2013-02-22  2109  	remove_rmap_item_from_tree(rmap_item);
4146d2d673e8d6 Hugh Dickins      2013-02-22  2110  
62b61f611eb5e2 Hugh Dickins      2009-12-14  2111  	if (kpage) {
2cee57d1b08877 Yang Shi          2019-03-05  2112  		if (PTR_ERR(kpage) == -EBUSY)
2cee57d1b08877 Yang Shi          2019-03-05  2113  			return;
2cee57d1b08877 Yang Shi          2019-03-05  2114  
08beca44dfb0ab Hugh Dickins      2009-12-14  2115  		err = try_to_merge_with_ksm_page(rmap_item, page, kpage);
31dbd01f314364 Izik Eidus        2009-09-21  2116  		if (!err) {
31dbd01f314364 Izik Eidus        2009-09-21  2117  			/*
31dbd01f314364 Izik Eidus        2009-09-21  2118  			 * The page was successfully merged:
31dbd01f314364 Izik Eidus        2009-09-21  2119  			 * add its rmap_item to the stable tree.
31dbd01f314364 Izik Eidus        2009-09-21  2120  			 */
5ad6468801d28c Hugh Dickins      2009-12-14  2121  			lock_page(kpage);
2c653d0ee2ae78 Andrea Arcangeli  2017-07-06  2122  			stable_tree_append(rmap_item, page_stable_node(kpage),
2c653d0ee2ae78 Andrea Arcangeli  2017-07-06  2123  					   max_page_sharing_bypass);
5ad6468801d28c Hugh Dickins      2009-12-14  2124  			unlock_page(kpage);
31dbd01f314364 Izik Eidus        2009-09-21  2125  		}
8dd3557a52f0bc Hugh Dickins      2009-12-14  2126  		put_page(kpage);
31dbd01f314364 Izik Eidus        2009-09-21  2127  		return;
31dbd01f314364 Izik Eidus        2009-09-21  2128  	}
31dbd01f314364 Izik Eidus        2009-09-21  2129  
e86c59b1b12d0d Claudio Imbrenda  2017-02-24  2130  	/*
e86c59b1b12d0d Claudio Imbrenda  2017-02-24  2131  	 * Same checksum as an empty page. We attempt to merge it with the
e86c59b1b12d0d Claudio Imbrenda  2017-02-24  2132  	 * appropriate zero page if the user enabled this via sysfs.
e86c59b1b12d0d Claudio Imbrenda  2017-02-24  2133  	 */
e86c59b1b12d0d Claudio Imbrenda  2017-02-24 @2134  	if (ksm_use_zero_pages && (checksum == zero_checksum)) {

uninitialized here.  Smatch cannot see how ksm_use_zero_pages and
stable_node are related.  (Neither can I but I have not looked at the
context).

e86c59b1b12d0d Claudio Imbrenda  2017-02-24  2135  		struct vm_area_struct *vma;
e86c59b1b12d0d Claudio Imbrenda  2017-02-24  2136  
d8ed45c5dcd455 Michel Lespinasse 2020-06-08  2137  		mmap_read_lock(mm);
4b22927f0cbd58 Kirill Tkhai      2017-10-03  2138  		vma = find_mergeable_vma(mm, rmap_item->address);
56df70a63ed5d9 Muchun Song       2020-04-20  2139  		if (vma) {
e86c59b1b12d0d Claudio Imbrenda  2017-02-24  2140  			err = try_to_merge_one_page(vma, page,
e86c59b1b12d0d Claudio Imbrenda  2017-02-24  2141  					ZERO_PAGE(rmap_item->address));
56df70a63ed5d9 Muchun Song       2020-04-20  2142  		} else {
56df70a63ed5d9 Muchun Song       2020-04-20  2143  			/*
56df70a63ed5d9 Muchun Song       2020-04-20  2144  			 * If the vma is out of date, we do not need to
56df70a63ed5d9 Muchun Song       2020-04-20  2145  			 * continue.
56df70a63ed5d9 Muchun Song       2020-04-20  2146  			 */
56df70a63ed5d9 Muchun Song       2020-04-20  2147  			err = 0;
56df70a63ed5d9 Muchun Song       2020-04-20  2148  		}
d8ed45c5dcd455 Michel Lespinasse 2020-06-08  2149  		mmap_read_unlock(mm);
e86c59b1b12d0d Claudio Imbrenda  2017-02-24  2150  		/*
e86c59b1b12d0d Claudio Imbrenda  2017-02-24  2151  		 * In case of failure, the page was not really empty, so we
e86c59b1b12d0d Claudio Imbrenda  2017-02-24  2152  		 * need to continue. Otherwise we're done.
e86c59b1b12d0d Claudio Imbrenda  2017-02-24  2153  		 */
e86c59b1b12d0d Claudio Imbrenda  2017-02-24  2154  		if (!err)
e86c59b1b12d0d Claudio Imbrenda  2017-02-24  2155  			return;
e86c59b1b12d0d Claudio Imbrenda  2017-02-24  2156  	}
8dd3557a52f0bc Hugh Dickins      2009-12-14  2157  	tree_rmap_item =
8dd3557a52f0bc Hugh Dickins      2009-12-14  2158  		unstable_tree_search_insert(rmap_item, page, &tree_page);
31dbd01f314364 Izik Eidus        2009-09-21  2159  	if (tree_rmap_item) {
77da2ba0648a4f Claudio Imbrenda  2018-04-05  2160  		bool split;
77da2ba0648a4f Claudio Imbrenda  2018-04-05  2161  
8dd3557a52f0bc Hugh Dickins      2009-12-14  2162  		kpage = try_to_merge_two_pages(rmap_item, page,
8dd3557a52f0bc Hugh Dickins      2009-12-14  2163  						tree_rmap_item, tree_page);
77da2ba0648a4f Claudio Imbrenda  2018-04-05  2164  		/*
77da2ba0648a4f Claudio Imbrenda  2018-04-05  2165  		 * If both pages we tried to merge belong to the same compound
77da2ba0648a4f Claudio Imbrenda  2018-04-05  2166  		 * page, then we actually ended up increasing the reference
77da2ba0648a4f Claudio Imbrenda  2018-04-05  2167  		 * count of the same compound page twice, and split_huge_page
77da2ba0648a4f Claudio Imbrenda  2018-04-05  2168  		 * failed.
77da2ba0648a4f Claudio Imbrenda  2018-04-05  2169  		 * Here we set a flag if that happened, and we use it later to
77da2ba0648a4f Claudio Imbrenda  2018-04-05  2170  		 * try split_huge_page again. Since we call put_page right
77da2ba0648a4f Claudio Imbrenda  2018-04-05  2171  		 * afterwards, the reference count will be correct and
77da2ba0648a4f Claudio Imbrenda  2018-04-05  2172  		 * split_huge_page should succeed.
77da2ba0648a4f Claudio Imbrenda  2018-04-05  2173  		 */
77da2ba0648a4f Claudio Imbrenda  2018-04-05  2174  		split = PageTransCompound(page)
77da2ba0648a4f Claudio Imbrenda  2018-04-05  2175  			&& compound_head(page) == compound_head(tree_page);
8dd3557a52f0bc Hugh Dickins      2009-12-14  2176  		put_page(tree_page);
bc56620b493496 Hugh Dickins      2013-02-22  2177  		if (kpage) {
31dbd01f314364 Izik Eidus        2009-09-21  2178  			/*
bc56620b493496 Hugh Dickins      2013-02-22  2179  			 * The pages were successfully merged: insert new
bc56620b493496 Hugh Dickins      2013-02-22  2180  			 * node in the stable tree and add both rmap_items.
31dbd01f314364 Izik Eidus        2009-09-21  2181  			 */
5ad6468801d28c Hugh Dickins      2009-12-14  2182  			lock_page(kpage);
7b6ba2c7d3baf8 Hugh Dickins      2009-12-14  2183  			stable_node = stable_tree_insert(kpage);
7b6ba2c7d3baf8 Hugh Dickins      2009-12-14  2184  			if (stable_node) {
2c653d0ee2ae78 Andrea Arcangeli  2017-07-06  2185  				stable_tree_append(tree_rmap_item, stable_node,
2c653d0ee2ae78 Andrea Arcangeli  2017-07-06  2186  						   false);
2c653d0ee2ae78 Andrea Arcangeli  2017-07-06  2187  				stable_tree_append(rmap_item, stable_node,
2c653d0ee2ae78 Andrea Arcangeli  2017-07-06  2188  						   false);
7b6ba2c7d3baf8 Hugh Dickins      2009-12-14  2189  			}
5ad6468801d28c Hugh Dickins      2009-12-14  2190  			unlock_page(kpage);
7b6ba2c7d3baf8 Hugh Dickins      2009-12-14  2191  
31dbd01f314364 Izik Eidus        2009-09-21  2192  			/*
31dbd01f314364 Izik Eidus        2009-09-21  2193  			 * If we fail to insert the page into the stable tree,
31dbd01f314364 Izik Eidus        2009-09-21  2194  			 * we will have 2 virtual addresses that are pointing
31dbd01f314364 Izik Eidus        2009-09-21  2195  			 * to a ksm page left outside the stable tree,
31dbd01f314364 Izik Eidus        2009-09-21  2196  			 * in which case we need to break_cow on both.
31dbd01f314364 Izik Eidus        2009-09-21  2197  			 */
7b6ba2c7d3baf8 Hugh Dickins      2009-12-14  2198  			if (!stable_node) {
8dd3557a52f0bc Hugh Dickins      2009-12-14  2199  				break_cow(tree_rmap_item);
8dd3557a52f0bc Hugh Dickins      2009-12-14  2200  				break_cow(rmap_item);
31dbd01f314364 Izik Eidus        2009-09-21  2201  			}
77da2ba0648a4f Claudio Imbrenda  2018-04-05  2202  		} else if (split) {
77da2ba0648a4f Claudio Imbrenda  2018-04-05  2203  			/*
77da2ba0648a4f Claudio Imbrenda  2018-04-05  2204  			 * We are here if we tried to merge two pages and
77da2ba0648a4f Claudio Imbrenda  2018-04-05  2205  			 * failed because they both belonged to the same
77da2ba0648a4f Claudio Imbrenda  2018-04-05  2206  			 * compound page. We will split the page now, but no
77da2ba0648a4f Claudio Imbrenda  2018-04-05  2207  			 * merging will take place.
77da2ba0648a4f Claudio Imbrenda  2018-04-05  2208  			 * We do not want to add the cost of a full lock; if
77da2ba0648a4f Claudio Imbrenda  2018-04-05  2209  			 * the page is locked, it is better to skip it and
77da2ba0648a4f Claudio Imbrenda  2018-04-05  2210  			 * perhaps try again later.
77da2ba0648a4f Claudio Imbrenda  2018-04-05  2211  			 */
77da2ba0648a4f Claudio Imbrenda  2018-04-05  2212  			if (!trylock_page(page))
77da2ba0648a4f Claudio Imbrenda  2018-04-05  2213  				return;
77da2ba0648a4f Claudio Imbrenda  2018-04-05  2214  			split_huge_page(page);
77da2ba0648a4f Claudio Imbrenda  2018-04-05  2215  			unlock_page(page);
31dbd01f314364 Izik Eidus        2009-09-21  2216  		}
31dbd01f314364 Izik Eidus        2009-09-21  2217  	}
31dbd01f314364 Izik Eidus        2009-09-21  2218  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

