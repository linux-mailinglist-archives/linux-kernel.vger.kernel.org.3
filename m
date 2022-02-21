Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4D94BE9C7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358598AbiBUNKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:10:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244170AbiBUNKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:10:02 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4781EAFB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:09:38 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21LD2aHg003636;
        Mon, 21 Feb 2022 13:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=wfIp8ul6zoWGA0XTdQQ+y2W6v6oWYuA6K1Q6KVNshGI=;
 b=XzHtYAEqrwQ2A+k3A8Z0+cEgpVgucmSgC5VQhQxRkNTnx652Pb0ANjoIDEUbBWoGtSSV
 i0KkmzcgkD9Mx5v6BiXLuPsralxs85lMocc7ruJB7crpnRXTx9acf7+/X4leNCsnJLnv
 RloA2WvrpE4JRMFbC5ebBNVWJF6mCa4W4Nswjc7JQS5ILWZbXHpqwQK9UCLaRH3Fbu/v
 l/L83zDZxihUpQBhyApOLwj7AmJr3wivFIzpx6tv0/FYh5xrF9gj0eYaf+5l3bxfdttx
 uUgSH8FdnuBBE1yvIui33yoNM80GaBqvNElnymQvD3x2PzxyRKI4O+RYr/yR4Lrcg/1v jQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3earebkxvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Feb 2022 13:09:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21LD1VOw104658;
        Mon, 21 Feb 2022 13:09:35 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by userp3030.oracle.com with ESMTP id 3eannte2mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Feb 2022 13:09:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WiWd79GUR8BHlY96CJypgBCOQnM8sdmRljxgz6l8bRrGxOxQX/P3fljPm0LMBB8iHmrffO7er2ylRJEu/3DZ/QbIC8SUMu+UYRbXN5rehOFLfwFdcYb2Pp6DbGTSfuiAvXbwyWiPRiMkM94RPghPjGFXFe9f7JxlzR/wd49lKj6hRv8IoDu9VMZp6fKvSHKdESgaEOgv3rOgNBfVUVUNyBVsctcDqciCczYGEHhs/T25XFbv8WOOWhIeeGDp4Jk7T3X8rTyDZsEC53h1UeLwUj+oBgqblXyS1GTc/Tcehk9wUTrdbWoYZr0fgqXXjggWNBoFUzX91z3mgaVGYStcBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfIp8ul6zoWGA0XTdQQ+y2W6v6oWYuA6K1Q6KVNshGI=;
 b=GcXXYFj9WVK0o8fNWMZ13zA/8UYG8aM5SipDMMvKOdSvql0Kh8HCsQBP39n/dlrRrCKL9YrqyHQCaaUt7LRN07Evb9SHy5386GO3iaRNvrikhMTP0Ka5QedMnxzsT3LE6ikuPYdSUmMvCqsLawF7KlWQ0p0oFYsZTBG5fhTFsSGr8Tq0HVDcW3LxERO+VLA2mBb/Gt0R+1HWzwsdjhEg4lvq3IxLLwFAuH6loqHW7YuYiC7FYYYxEV5efkDrej9zR2ph10WmxjYsvEfP05w+Cq0G4wRvCsNs1qlDQLrEEez+aBpRTABCiwyzp7HKd1B4QXYEzyOxPYYnGeDqc0USgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfIp8ul6zoWGA0XTdQQ+y2W6v6oWYuA6K1Q6KVNshGI=;
 b=o/lBQFT1MqDD9Zs18sQcQONXTHLeHuqeJyG+mhLsPLI69d41NpKZNCgsO807TbUUggyCUv2piJyiJ+jnHtR8IY6cM0I2fYFZv5TXAIXgQAHlBKnHrJS1E9XXikkEEinrvBguHuGyaqib7efCGo8DrT+wHOnK8+aVN0Gb3P2fWNY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB2715.namprd10.prod.outlook.com
 (2603:10b6:5:ba::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Mon, 21 Feb
 2022 13:09:32 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 13:09:32 +0000
Date:   Mon, 21 Feb 2022 16:09:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: drivers/net/ethernet/intel/ice/ice_main.c:5677
 ice_update_vsi_tx_ring_stats() error: we previously assumed 'ring' could be
 null (see line 5673)
Message-ID: <202202211208.RSlRUGsa-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0049.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::12)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2703e0c-609c-4469-17c6-08d9f53b666d
X-MS-TrafficTypeDiagnostic: DM6PR10MB2715:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB2715B6F0C0D4678DE2F0BBB38E3A9@DM6PR10MB2715.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RGTjJlnj/N0jxb/1XVcyVt+mLoe/hMtliCTK3FAD4BOE9AUTVOu384214tlxrffpu58/rRtsTOSO+XmUdAflnFEQpse/vM6/P7muKn/KDBJP7fpyHvDuTxVX7SMqXpWfXhf2lnBE4mk9NnZZyFnURGpQU0SrywOsHDfQdBz5hUqH2PoFNAxMeWi1dEjhcJ7U+AmqyNN6kw99ZK88firPMlMUv6oy0LLCRgSFXoC+NYBRBzN3soS7qd0e4oxguAWfFWY5R2VS1T7n4PrgZ6t/o0ZyBcO/BBv4mziHGWd1p/VSMHo1x7XPK1XSfHtKj07Dhxd0hQ+SP9F8NWLXHBL5kAEt3jAgVlk7D/Gyp9MNiO05DXDedTlHtPWmhl4VIWQgFwt3i1Nmaf+dSd5MdVqR4us1SRUiqRsbUG0VHhDjf3CNCi4AfKxH7M4vA8rpo5xjLXBkfVf1enSa9gr8trdVVEhPuglBNvuXgyvK2ds/QNS4wM8j38DLxFtoyDv0wD325aawN3SE4tuFXPYEVUMpPdXVyNo/R5MU/9y32c1jVSXVa3V9M7IasrfHvzji0oIIaXL0XCjV5jJdoAlEVhSGIgw66pzrd+/jWGG7kpn5ylpwZSxQ2Q+055JfeZ+TwpK3EgI0EW4WXtzOQ24jOcTqNYKfdr/O8HH3+uzPAaSrG7R8CjHlbSNGmCd+OYo/ej/ounpdb8CttxTmVFYEUmpKDFQyEvwmy8ueyYL010jrSfF2Pu7WQCA7TnYC0j0Y1sPMB3A8HDWuofPIKuzybwboNxnWJA1pP2nCf+9oh1cyRHX5knyR/IX0gyZv5SDsPRcPcrVjD4DclG8XSkR5dto71g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(38100700002)(38350700002)(83380400001)(44832011)(36756003)(5660300002)(2906002)(8936002)(1076003)(37006003)(6916009)(966005)(6486002)(52116002)(186003)(6512007)(66946007)(9686003)(26005)(66556008)(6506007)(6666004)(508600001)(316002)(8676002)(66476007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QIbTjhfIZ24L4awOAtx/fkDQzZmAXPMUAnyHUZv+F+UKQ5MBX6VRjFmxN8rE?=
 =?us-ascii?Q?GxVnw7s8hyf3++T/kBfCCxJ8auszKFFSDXj7gia31j4TUzUl5aHPgq4Zpcts?=
 =?us-ascii?Q?Dw8z2XZdZLcexN9Q9dH6u6XjdvXRLiTB66GWOImKbl7ktAxJyHNJ7OAFePsg?=
 =?us-ascii?Q?i9v11VAK6SakDNaP62a62GDMUa6ue6TWN24N5kuCjoPnspsPqaYFqjyv11VB?=
 =?us-ascii?Q?v5+nU84hTGd/VTIOMkG4M37iB0UotW1LhqmOBjdYVTAnHDOgmPGtAA7/fKm9?=
 =?us-ascii?Q?YkKa1aeFdH/UJzJw++nQt7DfLmkTwpwc8I1XCR+d9lTM6WXbmp6sHvzZqtZ8?=
 =?us-ascii?Q?aHvoXWO9+NaKLUeqbXh4DT1N0RTwirjtNxqgTHAUq3idI60vPencHk9YPDgP?=
 =?us-ascii?Q?I89N0gOTj0SuK8ppxAWOt25Y76WO1JvbJDi4KB5gFH1Lcj58sL7F9c2Jt5iS?=
 =?us-ascii?Q?q0S2aTW7+mHVEqS3Qky7Jr7cJUDniKt6/QgM2xrjk96Z5x/eenfwZ7sy5ZYl?=
 =?us-ascii?Q?dDqbpqkoreWam87/RpUpp+Nx0bQQmA2ivcJx39KkRXqy0Lj3pTZS/qQ86P8j?=
 =?us-ascii?Q?v8Ta74qyfFi0V+o2n6wnzMJ46CCPAfh8mfZ7DoLh3voM6hRIp16b/6hXJmV6?=
 =?us-ascii?Q?SjKNJhIBUmw3ljsYVRFEwSrb1PNbcXykRRLnxR7VU6XDqnyH1v042xzVlMze?=
 =?us-ascii?Q?QSOr4WM/ppSO3mMGtzeKV1pYYY2CrKpGCIpMizQj/aUZwjeMxbzn0dFiAEmU?=
 =?us-ascii?Q?ogT3HiuHjtxwyKkWAMdyRkp8VLABYm39GMXtPK4yx+5X6/TYLgL2e2ZW+zjm?=
 =?us-ascii?Q?NcqQABA3/fw0mQDuiNGYOKlSyWOCE6gXtVD8G3Jbsd+dWh5bpVtsuoK0QSDy?=
 =?us-ascii?Q?3CRlZu3uKSMiHY0pM/s7M4VobIVL313KT25QZMXtQFgGC6STAkY9cqaK4H9l?=
 =?us-ascii?Q?/6abdnuZyjELx31aoH+7jCTMkNQ++cLkCKAK8QR/qxgQNOzSVXN0Hwauw2Yn?=
 =?us-ascii?Q?nANsn57o0EZIbvMESxVGulLZ+ldkmsW4Yj3ZxeBcnMEsjUeNPahwDYAFa0P7?=
 =?us-ascii?Q?l10iWVtYKdku29UgGiuIYuiJ0//GujT1jVtIyi/XtaI0086kGPlPV7/yyMR8?=
 =?us-ascii?Q?DO7Hyy/rywPDbzHd1UN8mSWa4K+4scD6nRhnVPv2slRv+ny60MkouwmcpWpK?=
 =?us-ascii?Q?wlrIIvl/kAPJp+o3YtgcjKNEGUq63Q+RIUScA4SyV2AgILE/iWo+LtnGeOCR?=
 =?us-ascii?Q?k76DrAJiRY11KbjmS0GvTuvHXkswBZiiLd0NFHxAjlWVCYFJgeJOTjFCd9RN?=
 =?us-ascii?Q?2fb6cLrXp0p6OEXMtbFCMMJ14+1sbFrwXE+NkAHPzLOO7Jv3usoyBtzeN/rQ?=
 =?us-ascii?Q?jV9j9AMnoy7XvQb5U7A5ICTlts68w3GvdKca4Cy3EjBOS3kH6UZHkr9CVADG?=
 =?us-ascii?Q?hmmTrtiwNxf8bG+AUHEWoABUOMiSztmI1fmZlST3u16yBqigGGzcHAWCVPoI?=
 =?us-ascii?Q?w5pWuztQti1cgCaTFsD0KZ5unXgV9BVkcvN2RGSXHCGUzG7AbANQ9+Gq8537?=
 =?us-ascii?Q?g+Ki3RCT7iU8HU7RNVkTmPc7RAb4CviybsjZJ/FLqhukPK1QjbLUBAnUCPva?=
 =?us-ascii?Q?mU4cy7ShZWKT3ztV5VQAZJ+UBcVnbIsKaPj8qJc8WZzcWfexqDF9mZpQa4qr?=
 =?us-ascii?Q?c8y2Rw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2703e0c-609c-4469-17c6-08d9f53b666d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 13:09:32.4467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Um6CF5KoVkkCl+cYKvhM2VpyuTTKiHFiMiUO07Plh1M3ErQo7OLF5umI46C3zdlkaa8W5etKjE8zRRhzZ5pcIpPAi/lpbljTgS3y3xOFxVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2715
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10264 signatures=677614
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202210078
X-Proofpoint-ORIG-GUID: cC1MlgJQXg3zbLkwt5DMrdviJWGpTfd2
X-Proofpoint-GUID: cC1MlgJQXg3zbLkwt5DMrdviJWGpTfd2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cfb92440ee71adcc2105b0890bb01ac3cddb8507
commit: e72bba21355dbb67512a0d666fec9f4b56dbfc2f ice: split ice_ring onto Tx/Rx separate structs
config: ia64-randconfig-m031-20220220 (https://download.01.org/0day-ci/archive/20220221/202202211208.RSlRUGsa-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/net/ethernet/intel/ice/ice_main.c:5677 ice_update_vsi_tx_ring_stats() error: we previously assumed 'ring' could be null (see line 5673)

vim +/ring +5677 drivers/net/ethernet/intel/ice/ice_main.c

49d358e0e746dc Marta Plantykow        2020-05-15  5661  static void
e72bba21355dbb Maciej Fijalkowski     2021-08-19  5662  ice_update_vsi_tx_ring_stats(struct ice_vsi *vsi, struct ice_tx_ring **rings,
49d358e0e746dc Marta Plantykow        2020-05-15  5663  			     u16 count)
49d358e0e746dc Marta Plantykow        2020-05-15  5664  {
49d358e0e746dc Marta Plantykow        2020-05-15  5665  	struct rtnl_link_stats64 *vsi_stats = &vsi->net_stats;
49d358e0e746dc Marta Plantykow        2020-05-15  5666  	u16 i;
49d358e0e746dc Marta Plantykow        2020-05-15  5667  
49d358e0e746dc Marta Plantykow        2020-05-15  5668  	for (i = 0; i < count; i++) {
e72bba21355dbb Maciej Fijalkowski     2021-08-19  5669  		struct ice_tx_ring *ring;
e72bba21355dbb Maciej Fijalkowski     2021-08-19  5670  		u64 pkts = 0, bytes = 0;
49d358e0e746dc Marta Plantykow        2020-05-15  5671  
49d358e0e746dc Marta Plantykow        2020-05-15  5672  		ring = READ_ONCE(rings[i]);
e72bba21355dbb Maciej Fijalkowski     2021-08-19 @5673  		if (ring)
                                                                            ^^^^
Check for NULL

e72bba21355dbb Maciej Fijalkowski     2021-08-19  5674  			ice_fetch_u64_stats_per_ring(&ring->syncp, ring->stats, &pkts, &bytes);
49d358e0e746dc Marta Plantykow        2020-05-15  5675  		vsi_stats->tx_packets += pkts;
49d358e0e746dc Marta Plantykow        2020-05-15  5676  		vsi_stats->tx_bytes += bytes;
49d358e0e746dc Marta Plantykow        2020-05-15 @5677  		vsi->tx_restart += ring->tx_stats.restart_q;

Unchecked dereferences on the following lines

49d358e0e746dc Marta Plantykow        2020-05-15  5678  		vsi->tx_busy += ring->tx_stats.tx_busy;
49d358e0e746dc Marta Plantykow        2020-05-15  5679  		vsi->tx_linearize += ring->tx_stats.tx_linearize;
49d358e0e746dc Marta Plantykow        2020-05-15  5680  	}
49d358e0e746dc Marta Plantykow        2020-05-15  5681  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

