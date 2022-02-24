Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3610E4C2F74
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236111AbiBXPV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235986AbiBXPUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:20:09 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DA31A1C5D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:19:38 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21OCYbti016953;
        Thu, 24 Feb 2022 15:19:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=tV0ptEwXFNrzFuBgbOfKYDm3SZrRiRg+2ezq82jsV5k=;
 b=UaoCi9kpd4F45f82tkvvDS1pb1uPvTlDtkpdwdYPnsAHeOQYvpBkDou/wRZserFPTmht
 /oIeqIpcu3mFjn4/VcqU7/mOtl7vw/7wGt9L71bL5swJqDhJ33oMKI3JpZpsgbwlIMC/
 Xyp0jEXRnIBCJXpjqia+ZTcbT3cnyAe9/ETcKnlNkc9nPBtYxDfsalsnzcTGmGmQOBdQ
 ahQy2h5SKSTkaMr3gJzELa0yZZzKpM7pDJV1HzGahusF+Mu9KP4Jd3XUox2gcsWwRkEZ
 J6ShRnEY15qJO6Wq1xVAid/5Guem807LWziEQSKUfNZpN4SMAjFr6TA1/Y67bXjyB3Ad jg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ect3cqgd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 15:19:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21OF5fui195858;
        Thu, 24 Feb 2022 15:19:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by userp3030.oracle.com with ESMTP id 3eannxks44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 15:19:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMouwkpuR2Vbp/IDxLL/k9cHLOhjcEM0+kkKL7OzcpuWF4t9v/i6zoUWkHIMruaclMrLGg7Alm+9vLcT099VreLeSGS9StLogWxekSw9l+Gpdwc8FwDhqYHSHpTPqbbzRctolNJKFvhIKASC7NDQANhO8W4/R13DGEX35TmMBIbsJrm96JuVgfp3Tg4/NS344ubX+FV9XQ0YOBcq3twdyZDeZPO+mo9c6s1J/bGSzT4DfLfW+J4X7poPGaRjVxVDuOxywqm8sKpCAlTc5zXiXB/8ueXw17MaTQiUeUroyyVgEk+7XzS8qwkerM5+Awvr/5IVhs7lBJL0oFRjYA61Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tV0ptEwXFNrzFuBgbOfKYDm3SZrRiRg+2ezq82jsV5k=;
 b=Oe4ee6lUksVZz0QM0zRCzNs1RZyHJutqM5xNY99oOmdqDT5K28d/whOOCIMq9zH57LuMZ9T/Kejiw/1RnAqOyRSRwVZlIEHTxB9gPYQ3PzVtf/6s9V3o8r17DAcz1V73Jap4pFVE6rmXjbQBSdJkpEeSxquRqIxgKPqarE5YNectZu8Jq0CDCsR6HjlxmQzd4kxB0gldNwD9kTng38MzjJbv45q1ICBi028Y04SBm+ooAhMssJxSL2MjUuBDi4dtq6nAIXmw8dZdTN4QOs+rzWR57nBh/Kag9I9/04bsGrAtOskPD5tpc29XB9f8IzGLC8N1P+pcWPzYSoXuV3ZBJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tV0ptEwXFNrzFuBgbOfKYDm3SZrRiRg+2ezq82jsV5k=;
 b=MSBT2YJtkPV1APzUCZp7STgqAsHZnGh9HaG327fbbx+uDuDFgBZAgUj+I6faiKyjeuts13QFL78K2CYypftczkeNVDjywKYdJvjZ7oowKKMHXZDjv/jtFLPD8APVFXMO1HdO2T2PC5hFjnNLxHadxNOTq+kfktHYmkWAt1p+TiY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH0PR10MB5147.namprd10.prod.outlook.com
 (2603:10b6:610:c2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Thu, 24 Feb
 2022 15:19:23 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.4995.027; Thu, 24 Feb 2022
 15:19:23 +0000
Date:   Thu, 24 Feb 2022 18:19:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, David Hildenbrand <david@redhat.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [davidhildenbrand:cow_fixes_part_2 21/27] mm/hugetlb.c:6051
 follow_hugetlb_page() error: uninitialized symbol 'unshare'.
Message-ID: <202202241452.QrPElUkk-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0069.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbfda02f-70ed-42c3-1ec1-08d9f7a90975
X-MS-TrafficTypeDiagnostic: CH0PR10MB5147:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB5147CF29E0EBA04CC55633328E3D9@CH0PR10MB5147.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GCUFkzpdKdTQLVwnAP0Hv/Gw5Ofu6MBrwaPryFkQF8aS7cW+R2fE+fkLWKKk9dIYnbWipW2Tv5S7psiJETrebiMIiBcxgEFcn0i3qQ4iZrwvcyVkgpSAE4L0gZ/mXDju2SFsIqQVviAundpj+uzddkqaZnBvXEtWGw4GsMemZIk07QCUFGSaMcJFKiocDWcYUG26BN66Xc+X8PFgRbLNhuiaIF0ChUNYURBQ31Zm/gkzHEZOYP9V1sC3654jSYSKdPSbpJJXt8n+C9CRUaZPWJjcr0xq6SvoI7y5i36Il7mwzCfQWmbMzDo/ZrNDMuqSekC7vTh+RmeKE7UvZKqb+hUSIO0ELTB3HmLkhALtbsjS6QXWr56iUHiT3jCBc2ksjtO0VNL3ZOyzUjxHSeeVP+UaqdINF6fCwsjg7Y44HQV+ZrDEIJGkMeNNq6bDLvQw0fYfPXtUFsfFGbriOSZzdPiHPybxFfaiNpw4O5gCu+dB3lWrg16WDg3Sex6s+uD4Q+3/9ae3Zgq2bytVIyen//psx3PImvD/LQR4pVXep7MICfw5ckj7djByDiDFgV/3muB00ZxRp9uo2BOJvny5EPnnR4dzA5sic/YZwQD1mhVR0HoiXe0iH4xddr+ERuIiqQNK9CVsga4Lkdkz1tohyR1xUx6hhRW7LJTPWpW/aZocQfY/OJzvVau7rFRlV0C7zymAoftSpT4ZC69RKfJ3IqT05/QaeeZgfUjEYE0NLrPRbGswHLEVPBY9dvG0RS92z1rT8Lu4At2N3XQavtMsvIPekDkRfu29In7bjpdBEd9KE9sWwYWX2YXAzukwljmvKA6XzAR8oAEsjgeINrUbVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(44832011)(6512007)(9686003)(36756003)(2906002)(38350700002)(52116002)(8936002)(86362001)(6506007)(316002)(966005)(6486002)(186003)(26005)(83380400001)(6916009)(38100700002)(6666004)(4001150100001)(508600001)(1076003)(4326008)(66946007)(8676002)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W84m1ziAGrGJWHXskTTGN1OCIFiWPHk1ScQZWjgbtVZMQS6Z5U4coAWKdXOy?=
 =?us-ascii?Q?7jvZNWBaqnSNXOt0d1Sb4REhSTtcczZodDN0H6JspVTKEx8+qPYkZsUu68dw?=
 =?us-ascii?Q?ZikWDShDlMv3TDFVL+OmgFOn2EQExdtSPa05BNwvnUNkiQhBCVih+zqwreJg?=
 =?us-ascii?Q?ZK6cSiiG6xLUBEYygELEqwQ6adK0EGBIta5lJBRShw6KAf6YLCoA13nGVzz3?=
 =?us-ascii?Q?TQ1toEZv5LTJZJOakDpqCK2z0yFzFCPnDBR+s5dUUwFUP0pMHhmC8r6ckZIN?=
 =?us-ascii?Q?rBka5EWKNLmtL/Ch9qo5OPYkNYL5r7katrAonW6ZA/F9mve7PQncerbBEmY6?=
 =?us-ascii?Q?E3oB1I7AIw4MItuntnpXXHtTdzDtsLFHmCF1qKr/jgo2Ww6d8ur5K1rPejvh?=
 =?us-ascii?Q?L4+kcOmpK0Jgpqfu2BR8tTh3xVb+db6H6NNzWUTd7rzcDcFSxqinH7Yt81ma?=
 =?us-ascii?Q?q1AGQ9anEYbIJrfG/gezXG5oYT1g11ubUr+jXMo+9QOBdSb5VkAaXYsIb8ve?=
 =?us-ascii?Q?GNQ+P1TsFR09PPnA+NFwSXr7k9BgWflglc7z17nrZrPKJeDfGlvKO19o0upB?=
 =?us-ascii?Q?YGURxIfJ2T1mE+yd+8BADt8If2FoaEoBCb2HsJ7KvJdpbg5disWjSgE7GuxS?=
 =?us-ascii?Q?+uC8La7rcvNlSOufzdH0yDzIk1FHqFb8xH8LtxComMtlPHvj3QmmdICL7ot2?=
 =?us-ascii?Q?HS/WLP8ci8ubN/vnIZQkJI4uIU0e41PfRFb4hOSKqCR2Ji6bp92sCYHK6ZCy?=
 =?us-ascii?Q?F5axQ+yXga6WvFLRnOQqT3mNvGAygmmXZFLt8nk/n/2AdDTzl97q21XPiEDm?=
 =?us-ascii?Q?IHJ/lVsmvwTP7liLUz3svyedSQnKmxaY+k/dSFeu1EkgGxYMRZ9AFEw0edY7?=
 =?us-ascii?Q?ECLmGHFMzopLwHpXsUKsoOU7FZZDnqxN2pEf2g/k3GdU/Y9Uc410qT3X5qEV?=
 =?us-ascii?Q?6bC7tyBJb7wSnq9BtQMrKbaiTt+o979S63UI0rr5xxn9EPlZDRifj0kTXWJ0?=
 =?us-ascii?Q?Z4UIcnS24pys9dnU55rw95sU5t3jDqeZnWmLhBEyVr+Dcq8DJ629oZbkLPZb?=
 =?us-ascii?Q?oUUGgeSKkNtVKMIi3/rv1wI63Z+VY+NIJzzTV+K7beXfcpVDfazGr5xxXQnN?=
 =?us-ascii?Q?jdpbIpRqhvS1KZ8CpGW77ZP1p1AGzX4j9c9gt3MxCDp2U/pxOi3N/hDxql2F?=
 =?us-ascii?Q?ieyOGlSXDRI0azGeOfnT4ebmnfT+xSbcpr5ZRgQBvDJDsqfKmJ6Zr+yddJqv?=
 =?us-ascii?Q?7J0G4QEq/5M1zxD8zlLGrvKmjlJ8ayO9Wq86H4Kgv5VpZ+t8AABkABK5ZJnd?=
 =?us-ascii?Q?eImAYq+T9dNMyJZmn+FfQZTzv58awEKO0lgD7O/wWSn3dvMsQFCfVVUV0yhe?=
 =?us-ascii?Q?EPZj6ns5cmmVUPH+alLA45qf5NON6OMN8drd2P/sajsjsTa8Ig1hP9QJZgrt?=
 =?us-ascii?Q?X1Ixwwc+yd4Q5rycwxigpg2c+k9nbS1tC7QrnxrTRmRPjzzwFPQs+5deVYzt?=
 =?us-ascii?Q?xJ9DCy2LFXXx0gBDd+mQcjYzcupWJGxK28vAUEdhduiDSi1VSWJbT649xKCd?=
 =?us-ascii?Q?Glb7Fa9qVPymtUOzuRkZqV2JeI+ZLZdaff7ZQsqDXJHnWSRQrXOx+VceGTn6?=
 =?us-ascii?Q?Vf6HE8G2XHTrdHJ/sfSQUvKmLcfePhsXMALC8dgZozaknPssXd1iZnK0eDV5?=
 =?us-ascii?Q?Sgl5vw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbfda02f-70ed-42c3-1ec1-08d9f7a90975
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 15:19:23.2808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5u82JOsIAZrcnyNE6DGWL+fk4iX24HJpF8w9IGi6NIf01zcxugXSVoCeBn0xE4/kpAC3Cy01cZ9cjRDVRQFHizaz32aPBFLeXBX1Msi472Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5147
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10267 signatures=681306
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202240091
X-Proofpoint-ORIG-GUID: i-Foz2etvNOp67W-8H50QRV3opJGMwm5
X-Proofpoint-GUID: i-Foz2etvNOp67W-8H50QRV3opJGMwm5
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://github.com/davidhildenbrand/linux cow_fixes_part_2
head:   6a519d5bcfc204824056f340a0cfc86207962151
commit: d41af2eea859d0123cf08a88eae48239d5bdae2b [21/27] mm/gup: trigger FAULT_FLAG_UNSHARE when R/O-pinning a possibly shared anonymous page
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220224/202202241452.QrPElUkk-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
mm/hugetlb.c:6051 follow_hugetlb_page() error: uninitialized symbol 'unshare'.

vim +/unshare +6051 mm/hugetlb.c

28a35716d31798 Michel Lespinasse  2013-02-22  5977  long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
63551ae0feaaa2 David Gibson       2005-06-21  5978  			 struct page **pages, struct vm_area_struct **vmas,
28a35716d31798 Michel Lespinasse  2013-02-22  5979  			 unsigned long *position, unsigned long *nr_pages,
4f6da93411806d Peter Xu           2020-04-01  5980  			 long i, unsigned int flags, int *locked)
63551ae0feaaa2 David Gibson       2005-06-21  5981  {
d5d4b0aa4e1430 Kenneth W Chen     2006-03-22  5982  	unsigned long pfn_offset;
d5d4b0aa4e1430 Kenneth W Chen     2006-03-22  5983  	unsigned long vaddr = *position;
28a35716d31798 Michel Lespinasse  2013-02-22  5984  	unsigned long remainder = *nr_pages;
a5516438959d90 Andi Kleen         2008-07-23  5985  	struct hstate *h = hstate_vma(vma);
0fa5bc4023c188 Joao Martins       2021-02-24  5986  	int err = -EFAULT, refs;
63551ae0feaaa2 David Gibson       2005-06-21  5987  
63551ae0feaaa2 David Gibson       2005-06-21  5988  	while (vaddr < vma->vm_end && remainder) {
63551ae0feaaa2 David Gibson       2005-06-21  5989  		pte_t *pte;
cb900f41215447 Kirill A. Shutemov 2013-11-14  5990  		spinlock_t *ptl = NULL;
d41af2eea859d0 David Hildenbrand  2021-12-16  5991  		bool unshare;
2a15efc953b26a Hugh Dickins       2009-09-21  5992  		int absent;
63551ae0feaaa2 David Gibson       2005-06-21  5993  		struct page *page;
63551ae0feaaa2 David Gibson       2005-06-21  5994  
02057967b5d3b7 David Rientjes     2015-04-14  5995  		/*
02057967b5d3b7 David Rientjes     2015-04-14  5996  		 * If we have a pending SIGKILL, don't keep faulting pages and
02057967b5d3b7 David Rientjes     2015-04-14  5997  		 * potentially allocating memory.
02057967b5d3b7 David Rientjes     2015-04-14  5998  		 */
fa45f1162f28cb Davidlohr Bueso    2019-01-03  5999  		if (fatal_signal_pending(current)) {
02057967b5d3b7 David Rientjes     2015-04-14  6000  			remainder = 0;
02057967b5d3b7 David Rientjes     2015-04-14  6001  			break;
02057967b5d3b7 David Rientjes     2015-04-14  6002  		}
02057967b5d3b7 David Rientjes     2015-04-14  6003  
4c887265977213 Adam Litke         2005-10-29  6004  		/*
4c887265977213 Adam Litke         2005-10-29  6005  		 * Some archs (sparc64, sh*) have multiple pte_ts to
2a15efc953b26a Hugh Dickins       2009-09-21  6006  		 * each hugepage.  We have to make sure we get the
4c887265977213 Adam Litke         2005-10-29  6007  		 * first, for the page indexing below to work.
cb900f41215447 Kirill A. Shutemov 2013-11-14  6008  		 *
cb900f41215447 Kirill A. Shutemov 2013-11-14  6009  		 * Note that page table lock is not held when pte is null.
4c887265977213 Adam Litke         2005-10-29  6010  		 */
7868a2087ec13e Punit Agrawal      2017-07-06  6011  		pte = huge_pte_offset(mm, vaddr & huge_page_mask(h),
7868a2087ec13e Punit Agrawal      2017-07-06  6012  				      huge_page_size(h));
cb900f41215447 Kirill A. Shutemov 2013-11-14  6013  		if (pte)
cb900f41215447 Kirill A. Shutemov 2013-11-14  6014  			ptl = huge_pte_lock(h, mm, pte);
2a15efc953b26a Hugh Dickins       2009-09-21  6015  		absent = !pte || huge_pte_none(huge_ptep_get(pte));
2a15efc953b26a Hugh Dickins       2009-09-21  6016  
2a15efc953b26a Hugh Dickins       2009-09-21  6017  		/*
2a15efc953b26a Hugh Dickins       2009-09-21  6018  		 * When coredumping, it suits get_dump_page if we just return
3ae77f43b1118a Hugh Dickins       2009-09-21  6019  		 * an error where there's an empty slot with no huge pagecache
3ae77f43b1118a Hugh Dickins       2009-09-21  6020  		 * to back it.  This way, we avoid allocating a hugepage, and
3ae77f43b1118a Hugh Dickins       2009-09-21  6021  		 * the sparse dumpfile avoids allocating disk blocks, but its
3ae77f43b1118a Hugh Dickins       2009-09-21  6022  		 * huge holes still show up with zeroes where they need to be.
2a15efc953b26a Hugh Dickins       2009-09-21  6023  		 */
3ae77f43b1118a Hugh Dickins       2009-09-21  6024  		if (absent && (flags & FOLL_DUMP) &&
3ae77f43b1118a Hugh Dickins       2009-09-21  6025  		    !hugetlbfs_pagecache_present(h, vma, vaddr)) {
cb900f41215447 Kirill A. Shutemov 2013-11-14  6026  			if (pte)
cb900f41215447 Kirill A. Shutemov 2013-11-14  6027  				spin_unlock(ptl);
2a15efc953b26a Hugh Dickins       2009-09-21  6028  			remainder = 0;
2a15efc953b26a Hugh Dickins       2009-09-21  6029  			break;
2a15efc953b26a Hugh Dickins       2009-09-21  6030  		}
63551ae0feaaa2 David Gibson       2005-06-21  6031  
9cc3a5bd40067b Naoya Horiguchi    2013-04-17  6032  		/*
9cc3a5bd40067b Naoya Horiguchi    2013-04-17  6033  		 * We need call hugetlb_fault for both hugepages under migration
9cc3a5bd40067b Naoya Horiguchi    2013-04-17  6034  		 * (in which case hugetlb_fault waits for the migration,) and
9cc3a5bd40067b Naoya Horiguchi    2013-04-17  6035  		 * hwpoisoned hugepages (in which case we need to prevent the
9cc3a5bd40067b Naoya Horiguchi    2013-04-17  6036  		 * caller from accessing to them.) In order to do this, we use
9cc3a5bd40067b Naoya Horiguchi    2013-04-17  6037  		 * here is_swap_pte instead of is_hugetlb_entry_migration and
9cc3a5bd40067b Naoya Horiguchi    2013-04-17  6038  		 * is_hugetlb_entry_hwpoisoned. This is because it simply covers
9cc3a5bd40067b Naoya Horiguchi    2013-04-17  6039  		 * both cases, and because we can't follow correct pages
9cc3a5bd40067b Naoya Horiguchi    2013-04-17  6040  		 * directly from any kind of swap entries.
9cc3a5bd40067b Naoya Horiguchi    2013-04-17  6041  		 */
d41af2eea859d0 David Hildenbrand  2021-12-16  6042  		if (absent ||
d41af2eea859d0 David Hildenbrand  2021-12-16  6043  		    __follow_hugetlb_must_fault(flags, pte, &unshare)) {

Can absent be true

2b7403035459c7 Souptick Joarder   2018-08-23  6044  			vm_fault_t ret;
87ffc118b54dcd Andrea Arcangeli   2017-02-22  6045  			unsigned int fault_flags = 0;
4c887265977213 Adam Litke         2005-10-29  6046  
cb900f41215447 Kirill A. Shutemov 2013-11-14  6047  			if (pte)
cb900f41215447 Kirill A. Shutemov 2013-11-14  6048  				spin_unlock(ptl);
87ffc118b54dcd Andrea Arcangeli   2017-02-22  6049  			if (flags & FOLL_WRITE)
87ffc118b54dcd Andrea Arcangeli   2017-02-22  6050  				fault_flags |= FAULT_FLAG_WRITE;

And FOLL_WRITE is not set?

d41af2eea859d0 David Hildenbrand  2021-12-16 @6051  			else if (unshare)
                                                                                 ^^^^^^^
Uninitialized warning...

d41af2eea859d0 David Hildenbrand  2021-12-16  6052  				fault_flags |= FAULT_FLAG_UNSHARE;
4f6da93411806d Peter Xu           2020-04-01  6053  			if (locked)
71335f37c5e8ec Peter Xu           2020-04-01  6054  				fault_flags |= FAULT_FLAG_ALLOW_RETRY |
71335f37c5e8ec Peter Xu           2020-04-01  6055  					FAULT_FLAG_KILLABLE;
87ffc118b54dcd Andrea Arcangeli   2017-02-22  6056  			if (flags & FOLL_NOWAIT)
87ffc118b54dcd Andrea Arcangeli   2017-02-22  6057  				fault_flags |= FAULT_FLAG_ALLOW_RETRY |
87ffc118b54dcd Andrea Arcangeli   2017-02-22  6058  					FAULT_FLAG_RETRY_NOWAIT;
87ffc118b54dcd Andrea Arcangeli   2017-02-22  6059  			if (flags & FOLL_TRIED) {
4426e945df588f Peter Xu           2020-04-01  6060  				/*
4426e945df588f Peter Xu           2020-04-01  6061  				 * Note: FAULT_FLAG_ALLOW_RETRY and

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

