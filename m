Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02EE548A750
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 06:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245570AbiAKFZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 00:25:49 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:33718 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244570AbiAKFZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 00:25:48 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20B3TFKL006807;
        Tue, 11 Jan 2022 05:25:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=ZLoH6A4nsFKITy+A2Vn3agLV/d68WvyizNQl6jXrGTQ=;
 b=pvyseirNtX+216sODHhKph766dmQv1+7bDPix7UkK3d8zbgLMNsn5mi8Ab1gIcDG7KMz
 moyKe+XCBIJFCWiUUwgKefX8OfextoSR3DNC3f640U620n58hepZ8hP1+PuEBSelo9GW
 2iq4cL72RKFrT+4Vfs6Iyk9Gt7JZEchrexrGjt/eJRIlTVojOcpe8PVgY1Q0zMh5Soaw
 zIvML/mwtdkx0Maqo4M0bbfc66WIRyLLfPLz5EfQ2IghoTcQ5Mr7lHdqFpaszcpEEtYq
 pjGlp8aW/A1TP9TpdU9CX64iyLwIBn7J3flDLryko175zYUZrjJdTU/97YW03cSj7lrH aQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgjtgacxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 05:25:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20B5Pijg018358;
        Tue, 11 Jan 2022 05:25:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by userp3020.oracle.com with ESMTP id 3df42m4fuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 05:25:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/J+LAqKDAqtcsrm2fZcpCEl0hwY8FC0MhPcQaZd2DznJzit/R16ss6d4Iljlha8LzIMVVahbV2N7ZlJwbpqIm91MjDUy86QfH2WHSfq10qThHjqj1oaH2w+aa+E0OqEnSDC3yibFsI2tzyREGZQRovJWWS6iD/X2s12NorwLMtwXIBNxbUPEBovbqpxHRHPS26cdZ1Ea0OGNkHHs7dTSbpbxKGk4muEpx4anWfY0bTS+Kmv07A73MeRfmEDRBnCUTDJskp3c/zA8V8WrFJ6RAzFCO9kScF9ul33UB6XeNsNI4tGDYMupE33p+3lUWdRczbEEst6L2ROdBvJz9+aBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLoH6A4nsFKITy+A2Vn3agLV/d68WvyizNQl6jXrGTQ=;
 b=oWh7b8zDw3aRTXrplY8dwo/BwIvbPKzdNw3HoZK5SxhRza/HFUrUwZm+dS9reOuXW8llHwrk/fxjiA5sf3lGWscL+G3aVtGS2v0dqCClCSAlUtJh+rsbB5osB1sC0tcgIHgP7F4Uram3vv/1mLxt0CRaG41kLEcE36hJgfVJEuBCzqUc4AUpUfKWaopjiByOzAvosmsueAqbs2rhFEu264ji+EJDfvSxxrWni2L7tohgBdfDRsDejmpPodOw/M61iq/XfQvXgLQjLFwjFLbNI5n4WouO+H8YIokF5Jpb2TWpB6MWNWYs2tZ0GE1lHZWusQX8GaO/rMfstiSjdEjo9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLoH6A4nsFKITy+A2Vn3agLV/d68WvyizNQl6jXrGTQ=;
 b=bE7xuzIzWxmLK2sAaEBFBekt+KrYx2OIsSgXToOd+uU+a+KIWfgdFHww71XstKPn6MK7nGZS/j8I7FYK+gMVX2gClykbLRkfAgCBLNaR2Q6qs7mBg0RPg5nGDPxYhLzO1YhUU5zdG92xMY0glDwy+8rbhiQzfjKCnDSUKwPmV60=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW5PR10MB5808.namprd10.prod.outlook.com
 (2603:10b6:303:19b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.16; Tue, 11 Jan
 2022 05:25:41 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 05:25:41 +0000
Date:   Tue, 11 Jan 2022 08:25:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>
Subject: drivers/edac/i10nm_base.c:256 i10nm_get_hbm_munits() warn: 'mbase'
 not released on lines: 249.
Message-ID: <202201110445.U0kY9hEl-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0014.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 003bb8e2-526e-41bd-cf59-08d9d4c2cf4c
X-MS-TrafficTypeDiagnostic: MW5PR10MB5808:EE_
X-Microsoft-Antispam-PRVS: <MW5PR10MB580888CA3FFCB9BD8093A5288E519@MW5PR10MB5808.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:71;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8neIuHsxQPVFtoHLBabXY5a4wKme2YvvbHa34RJgGRaUkDlOvYIuS5Px8KFxxnjqDlvZx0MAYV8Te0w4sMRUqEdv05Ld1W/uBoVZM9TiZr9GrySC4jH9i/Y4Q0SNezkMHqm1gDi7Tt4QVDdYe0QuGd6FVuPhdAvK8cUQAqbW8N4d5CHysFgU+vpCwqnlFDSPyNg5rahTFeHbj1Z0b8BZkt1FNlFH1GHYznmkuC/7V3whsFoN8pWsU01A0XAgPBFbXXyr8klEoYFZdS/mSPVtxIZzylBi8TjZUUpFZ06OoKlJOHUWDQ//a6tZg+W0xuXAFVCgGvvgtDn/QqT9EZ3CVsBr91+hdIXq83vjRs8dTA1abm6BZS47IPZsp+j0cXwXqhCWwTJqkTpAYvTjRsevofY3MoJOf9wsIWgqug9bT9JQpivu+Dw4lAkOKAlTRDEWObw6olGmJ3/vuX0y6fOd4EcnLUd/SrfJnpAJRg4Wm+PiZ0lO9OfCA3QLD8ME7otqxKFDZyQHflCXEVPKqNPPz+zc0sjZ3mQUNpCX2m6uawPY/7fRuhWJmHLh095fV8KBgPQ9k9wVk0QKxI1mVIfTQNZNpgIszLYaO1k/w8UN01R6bFBccz2DIJS9TG7gQX9X94ePRSBwakpITXRRYFHpJRcTVXGvuEhZHLS/m4kYxr0XwvejZHkAUat0EUwx+s7ZlJvmnpuWS65UugUhRN9W2cszdZPP7sVnuncgEQbJoAkcF2UhwzjPKOQ9sbl4yGJHIBSHym7X1aTmp49a40y6sWABGRF265xzz4Oty0xgvDfXk5RK9Kkdd2ahsg44bQTtoG4k8SdQRVTf0E23jktd8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(4326008)(508600001)(6506007)(8936002)(52116002)(316002)(38350700002)(2906002)(186003)(5660300002)(44832011)(8676002)(6512007)(1076003)(66556008)(6666004)(9686003)(38100700002)(966005)(86362001)(66946007)(83380400001)(6916009)(66476007)(37006003)(6486002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tnMobt8GHWBjnVKl1U+CivD483D1i4noL+Q/0eR29OxzTl05QjgV+CM/9z0o?=
 =?us-ascii?Q?7HYCf3E0taQTCkVAJKyh+rVP6E57lgZAPPegXf76yVRJBAKEL8cFCYOZ9NKl?=
 =?us-ascii?Q?yEjlbF0eJj5Gh6x7n/yG53JvxFsTRrdE3y76kJqsuppwBeQxOwxYkrLXVU7K?=
 =?us-ascii?Q?f4uJBnoundCFx2DbPI5h97OHncL/cfxylrXv6RD8Phevx8nYD4QGUKNGHGkL?=
 =?us-ascii?Q?Dk7ztZ51V+U+w7HcgmrxTntpTNyc/jcend6EBX8NIM5nNsvZy16yWWjcccCO?=
 =?us-ascii?Q?M9pas76qebUiptNipA89mbIgO8Q6FsmyhLHQkP65QYnhhW8J3IaROhOTAHEu?=
 =?us-ascii?Q?gKgWW8wjTwNlHqI6NZRo2p2Cc/5f8nBT+K4/LE3uas3yAaxh4/AxtQWMpFl6?=
 =?us-ascii?Q?xEXeOYinAMsT6t+0bTGUoxdNaVpeepQ8RJ+WFyeW4kSvz+Hj4RR6xA6UiiNc?=
 =?us-ascii?Q?4Exrm69UWWBTKgz9ozjq3Yu9v+ZL+5CR6cUNTRTdx7Bt/plSO6MLsaFYjEoy?=
 =?us-ascii?Q?v1zFJinkVJQF7JKKEonjPo/3yI68Fs8jE1+xGkPjhHJbMd9vogRmUY4eFY1H?=
 =?us-ascii?Q?pyp87TQk8XroEDSCmHC/YLC8ZE2xwN5uwG7/xm1D7qP2I9/Rsi+Z8TW/6Gue?=
 =?us-ascii?Q?BIV4WOXUeenDruSRxz0gLuMY305fqlzxUYpQXPvR03h08/5aFij9Q9igh2eY?=
 =?us-ascii?Q?aDqKThh4kLzKfu9DV6V2q01KP49KZi50DM5IzdipMeVnBY9GCbBqNniaeBpb?=
 =?us-ascii?Q?jigZ5TpmdOFwQd9vJ329apB6aej5oO5hi4N3Ae5zcPsfq8ZXEYGsV06UZUmV?=
 =?us-ascii?Q?PXK5sYAUDG7zQB6bqlgbuVWzAwGzNWRupWN/25zqS8FgqJCd18mDOllo1eNs?=
 =?us-ascii?Q?6oLg75CveEtNIEmE23N0h9eEuRYBHwO4v2c4a7Urd+d8FoafcMxvjMAEhFWo?=
 =?us-ascii?Q?pbTJkrlwjB631dJTeTxUH4GvQzz/J4cCJ0Xk0xrdCtPB98l4Is3xfuSVNTQE?=
 =?us-ascii?Q?gWX219Dn6G8ib9a/96SDMmo+hd7Yd3jav9tj5rJyJAYo82U1wTXP24Hd7UIT?=
 =?us-ascii?Q?MpvK6C6rgVj/C8al3StcpQy5rDdJEc7HFkJJwmlzzOezKgRYgcFUGJ2urJfz?=
 =?us-ascii?Q?nA/Sq3apLjcC950GKGE8PeL76td65ZaS7xx9N++H8aIlENRCPEYEFnW3m2VM?=
 =?us-ascii?Q?e2UWjyJ2PEWEEnNimgQV8we7LlbZcDC6uL19RD57GJGsvLaCzVj0did5X4KP?=
 =?us-ascii?Q?7PymJujDrS4mk4yZBuYV8BPn9EfLOJr+jYJgvUTvvIMrv2iZJMHqucUcnVBd?=
 =?us-ascii?Q?J372txSo/bcS/2cEMzGd/EQEKA2VFKpHlvvafktMTMv5IPzGBJPBFZAZmG2h?=
 =?us-ascii?Q?v05o59MEJZOgluR7/sqbuJfdQQ+7ZYBdjtjU6t3RmcGr8JpcWnH9cdX08SpX?=
 =?us-ascii?Q?ln/ybsvBSP+aAnQpuQyqrPukgsqapSXBYaQ0PP58wKPrIgq1u4FIHaAV0Meh?=
 =?us-ascii?Q?VrUzPv8FiDZOw2/sISPyzvrt3aMyfhpo6hGnNGf/3V66Dd0TZbOntUzfJU4+?=
 =?us-ascii?Q?PIZ7J7Y7r4e5qixd6zyIX6HSgNV8oAO0PAGzYFrzd4xyFSmuL0OAV/Y5mp/z?=
 =?us-ascii?Q?Ly0WbMtsVtur8jCTd1uQNiygoYTDTA3d32SpeFIk9Et1VpjcNDqDh/4OThFq?=
 =?us-ascii?Q?3qdj6jai/UiUmsRFXDiqjQ1XonU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 003bb8e2-526e-41bd-cf59-08d9d4c2cf4c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 05:25:41.7390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TXgIeQwB3tsKlGUlkvX16HICjDkpHgMNGXro6XXeJOtGkzS20LootAhCk125d2mY+5JB2pNXvqerr/gm5ecN5fKXtLyypuL9uXbkuGmI9i0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5808
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110026
X-Proofpoint-GUID: B4TK4jVXwPb7caxjp6J7hETrppQuSqF7
X-Proofpoint-ORIG-GUID: B4TK4jVXwPb7caxjp6J7hETrppQuSqF7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   df0cc57e057f18e44dac8e6c18aba47ab53202f9
commit: c945088384d00e6eb61535cc4ba25bc062090909 EDAC/i10nm: Add support for high bandwidth memory
config: x86_64-randconfig-m001-20220108 (https://download.01.org/0day-ci/archive/20220111/202201110445.U0kY9hEl-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/edac/i10nm_base.c:256 i10nm_get_hbm_munits() warn: 'mbase' not released on lines: 249.

vim +/mbase +256 drivers/edac/i10nm_base.c

c945088384d00e Qiuxu Zhuo 2021-06-11  187  static int i10nm_get_hbm_munits(void)
c945088384d00e Qiuxu Zhuo 2021-06-11  188  {
c945088384d00e Qiuxu Zhuo 2021-06-11  189  	struct pci_dev *mdev;
c945088384d00e Qiuxu Zhuo 2021-06-11  190  	void __iomem *mbase;
c945088384d00e Qiuxu Zhuo 2021-06-11  191  	u32 reg, off, mcmtr;
c945088384d00e Qiuxu Zhuo 2021-06-11  192  	struct skx_dev *d;
c945088384d00e Qiuxu Zhuo 2021-06-11  193  	int i, lmc;
c945088384d00e Qiuxu Zhuo 2021-06-11  194  	u64 base;
c945088384d00e Qiuxu Zhuo 2021-06-11  195  
c945088384d00e Qiuxu Zhuo 2021-06-11  196  	list_for_each_entry(d, i10nm_edac_list, list) {
c945088384d00e Qiuxu Zhuo 2021-06-11  197  		d->pcu_cr3 = pci_get_dev_wrapper(d->seg, d->bus[1], 30, 3);
c945088384d00e Qiuxu Zhuo 2021-06-11  198  		if (!d->pcu_cr3)
c945088384d00e Qiuxu Zhuo 2021-06-11  199  			return -ENODEV;
c945088384d00e Qiuxu Zhuo 2021-06-11  200  
c945088384d00e Qiuxu Zhuo 2021-06-11  201  		if (!i10nm_check_hbm_imc(d)) {
c945088384d00e Qiuxu Zhuo 2021-06-11  202  			i10nm_printk(KERN_DEBUG, "No hbm memory\n");
c945088384d00e Qiuxu Zhuo 2021-06-11  203  			return -ENODEV;
c945088384d00e Qiuxu Zhuo 2021-06-11  204  		}
c945088384d00e Qiuxu Zhuo 2021-06-11  205  
c945088384d00e Qiuxu Zhuo 2021-06-11  206  		if (I10NM_GET_SCK_BAR(d, reg)) {
c945088384d00e Qiuxu Zhuo 2021-06-11  207  			i10nm_printk(KERN_ERR, "Failed to get socket bar\n");
c945088384d00e Qiuxu Zhuo 2021-06-11  208  			return -ENODEV;
c945088384d00e Qiuxu Zhuo 2021-06-11  209  		}
c945088384d00e Qiuxu Zhuo 2021-06-11  210  		base = I10NM_GET_SCK_MMIO_BASE(reg);
c945088384d00e Qiuxu Zhuo 2021-06-11  211  
c945088384d00e Qiuxu Zhuo 2021-06-11  212  		if (I10NM_GET_HBM_IMC_BAR(d, reg)) {
c945088384d00e Qiuxu Zhuo 2021-06-11  213  			i10nm_printk(KERN_ERR, "Failed to get hbm mc bar\n");
c945088384d00e Qiuxu Zhuo 2021-06-11  214  			return -ENODEV;
c945088384d00e Qiuxu Zhuo 2021-06-11  215  		}
c945088384d00e Qiuxu Zhuo 2021-06-11  216  		base += I10NM_GET_HBM_IMC_MMIO_OFFSET(reg);
c945088384d00e Qiuxu Zhuo 2021-06-11  217  
c945088384d00e Qiuxu Zhuo 2021-06-11  218  		lmc = I10NM_NUM_DDR_IMC;
c945088384d00e Qiuxu Zhuo 2021-06-11  219  
c945088384d00e Qiuxu Zhuo 2021-06-11  220  		for (i = 0; i < I10NM_NUM_HBM_IMC; i++) {
c945088384d00e Qiuxu Zhuo 2021-06-11  221  			mdev = pci_get_dev_wrapper(d->seg, d->bus[0],
c945088384d00e Qiuxu Zhuo 2021-06-11  222  						   12 + i / 4, 1 + i % 4);
c945088384d00e Qiuxu Zhuo 2021-06-11  223  			if (i == 0 && !mdev) {
c945088384d00e Qiuxu Zhuo 2021-06-11  224  				i10nm_printk(KERN_ERR, "No hbm mc found\n");
c945088384d00e Qiuxu Zhuo 2021-06-11  225  				return -ENODEV;
c945088384d00e Qiuxu Zhuo 2021-06-11  226  			}
c945088384d00e Qiuxu Zhuo 2021-06-11  227  			if (!mdev)
c945088384d00e Qiuxu Zhuo 2021-06-11  228  				continue;
c945088384d00e Qiuxu Zhuo 2021-06-11  229  
c945088384d00e Qiuxu Zhuo 2021-06-11  230  			d->imc[lmc].mdev = mdev;
c945088384d00e Qiuxu Zhuo 2021-06-11  231  			off = i * I10NM_HBM_IMC_MMIO_SIZE;
c945088384d00e Qiuxu Zhuo 2021-06-11  232  
c945088384d00e Qiuxu Zhuo 2021-06-11  233  			edac_dbg(2, "hbm mc%d mmio base 0x%llx size 0x%x\n",
c945088384d00e Qiuxu Zhuo 2021-06-11  234  				 lmc, base + off, I10NM_HBM_IMC_MMIO_SIZE);
c945088384d00e Qiuxu Zhuo 2021-06-11  235  
c945088384d00e Qiuxu Zhuo 2021-06-11  236  			mbase = ioremap(base + off, I10NM_HBM_IMC_MMIO_SIZE);
c945088384d00e Qiuxu Zhuo 2021-06-11  237  			if (!mbase) {
c945088384d00e Qiuxu Zhuo 2021-06-11  238  				i10nm_printk(KERN_ERR, "Failed to ioremap for hbm mc 0x%llx\n",
c945088384d00e Qiuxu Zhuo 2021-06-11  239  					     base + off);
c945088384d00e Qiuxu Zhuo 2021-06-11  240  				return -ENOMEM;
c945088384d00e Qiuxu Zhuo 2021-06-11  241  			}
c945088384d00e Qiuxu Zhuo 2021-06-11  242  
c945088384d00e Qiuxu Zhuo 2021-06-11  243  			d->imc[lmc].mbase = mbase;
c945088384d00e Qiuxu Zhuo 2021-06-11  244  			d->imc[lmc].hbm_mc = true;
c945088384d00e Qiuxu Zhuo 2021-06-11  245  
c945088384d00e Qiuxu Zhuo 2021-06-11  246  			mcmtr = I10NM_GET_MCMTR(&d->imc[lmc], 0);
c945088384d00e Qiuxu Zhuo 2021-06-11  247  			if (!I10NM_IS_HBM_IMC(mcmtr)) {
c945088384d00e Qiuxu Zhuo 2021-06-11  248  				i10nm_printk(KERN_ERR, "This isn't an hbm mc!\n");

iounmap(mbase)?

c945088384d00e Qiuxu Zhuo 2021-06-11  249  				return -ENODEV;
c945088384d00e Qiuxu Zhuo 2021-06-11  250  			}
c945088384d00e Qiuxu Zhuo 2021-06-11  251  
c945088384d00e Qiuxu Zhuo 2021-06-11  252  			lmc++;
c945088384d00e Qiuxu Zhuo 2021-06-11  253  		}
c945088384d00e Qiuxu Zhuo 2021-06-11  254  	}
c945088384d00e Qiuxu Zhuo 2021-06-11  255  
c945088384d00e Qiuxu Zhuo 2021-06-11 @256  	return 0;
c945088384d00e Qiuxu Zhuo 2021-06-11  257  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

