Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD2A4BA2FE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241706AbiBQOa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:30:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239248AbiBQOaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:30:24 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24D12B167A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 06:30:09 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21HD05Wv005355;
        Thu, 17 Feb 2022 14:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=i+v10Z2mU/qrA4UdqoH/g4IN2KxO63DfcYMi3kPUnyA=;
 b=0EcBEA9rsHiom6O1Bg/pHgJ0B82ULPjdpDbQ/1lvtMnOVfz2/iYCR0m/PAsSmDieIrUf
 WpADXcr14fZKC/9ukINP8pIjWvi/BstGvNxzFeF1RUk9tmLHKB11My8cMzS50AnnulhZ
 6x/XVgPTBZAKsEFsPwYzF6SHtjvu1vbVeoE0Syr5asVbdzSwitDSihoj0gxIZLI1xGwC
 712NTPauRJXWFeEmKlj/hz/8v00ujX4E0tlRyaQFLzGXwU2GpklsOsgRx05Q9it35nex
 mt6ZNJZE+EXPS1/sfHXlJj8TGYIbvGFGg6pRhReEZW03xlzNKbI39HL2MBBd0LqDD7AQ pA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8ncax1u1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 14:29:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21HEBLKl099856;
        Thu, 17 Feb 2022 14:29:54 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2046.outbound.protection.outlook.com [104.47.73.46])
        by userp3030.oracle.com with ESMTP id 3e8nm03hy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 14:29:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apL8/R/vZj1eWXrT44c9aGjGXTba+qmxZMbuPx972ZCG/5VtbP6xpET04nI3KBMFGW27YyWKXGgw/0hEi9zV+URJGozxZXXEZSvN5+7rl4xvToDcwk8exNa1VeqDvTUFmQXb83tOTCvbTR2SZ+hVIUcJ/yCVZcFYjhqmk+FTEC03r7XZ0JGj1jSlkns7LEivDv7YEVWD7JG1b0Neu3ipINd2Qvj5qHEx9cLQnSqAjdUIHSQ7wmF9Oynj1yJYTwzZWgtbbBq2+/FM/eotiGnOn9soSRbXdg5zpvDL4F57QKuqfkMFTqHGdRxh/XzOQzFxYe+KbRpPDdayk34lVpmmvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+v10Z2mU/qrA4UdqoH/g4IN2KxO63DfcYMi3kPUnyA=;
 b=QnJEKDCnkHyVDblGuW4g7zpMdjNH5Sk00xIgjXw3tIL7Ah9D6TUVSMvON4n+1xXAGHM9J2dHOXol1MIDLxQ0fpxue0kyY9MIkmyl8nWwtUsUQlmJBSKQEkm6nEUqgvzD13SL7magADaVuZgl0VlYEK+iSM1vOr41JbihNl1Glm73+QmsFbLllrwFi3E+KB7OwanzbZpxPObLEEKwACjUppBYG4OFHXHt5/HjM/mdgaW4No93ND0ei5rLdPArQkI3p1CUycEM8ro1jfgRXn5T3VsP20FXnga9s5ZTZA5+nv9onYXJd4kxxRYCMi/owVnCnr2DJRXc2x0yf0K+XrIfMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+v10Z2mU/qrA4UdqoH/g4IN2KxO63DfcYMi3kPUnyA=;
 b=iBB551QvcA0bJPCAmfzAdEVjG6dzAqT5z2ncghS3eI1TcyVoIEzFnMt0EDLu5bA++BPmy8Q90bExNgx0lvCIkE7KhWfuQSxmvG+1BOk/9u/FFTny3L9gpQ1lfGXdjVCBTpxz2jncLiqINOlcAxO1JKRUdaLNA2jf1SencSISiDs=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH0PR10MB4938.namprd10.prod.outlook.com
 (2603:10b6:610:c4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Thu, 17 Feb
 2022 14:29:52 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%3]) with mapi id 15.20.4975.019; Thu, 17 Feb 2022
 14:29:52 +0000
Date:   Thu, 17 Feb 2022 17:29:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org,
        Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/15] staging: r8188eu: remove smaller sets of
 converted DBG_88E calls
Message-ID: <20220217142929.GC2407@kadam>
References: <20220216010709.791-1-phil@philpotter.co.uk>
 <20220216010709.791-3-phil@philpotter.co.uk>
 <e187df14-403c-2908-e4f5-8d38d7f63810@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e187df14-403c-2908-e4f5-8d38d7f63810@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0012.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed90d1de-991a-4048-bf46-08d9f221f5dc
X-MS-TrafficTypeDiagnostic: CH0PR10MB4938:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB49388ED9664FA603346E28018E369@CH0PR10MB4938.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PJ0T3l6eoFCEjFUV0hfqly+EC1kcYumDNfzoDwGy+ID5sgoClt7rVKxesKVEF1T4qU9bcsouOVlyN7KAqE3qQyMw7Y5k8eUC26GOtIBUXfoIjfkkpVz1F46VoJK+vJfDuCr23sfmqBRrmRdBJlH6lJtCmI+t3tTHciUiBt3oo77A3MYJxoiVKDA10i9Q7sAn7aX28CCE4aviF/tiu2AUuzKr+6s9dAnMlGgGiDew6DAyc3ejxNBijT+sp7nUXkrzqFDz0oQesIvwt9GWYLoiORLf9676yg17FXF8c4jJVna7wJS6lXAi2Z/EFkCGr5UX09Ccg8pLUvQocT3YszIoFS4xkkS9OLTYEqOGZJJIxUBD3iZ/MB3QHqKq/SQAC864ifYbLtSIBn5YlEFJUHi6+crZ++LkKyUbj0OK7aXflLMiHSPUNN8UDvTnK6ZqAo9rrk6KBbo0Q6jYjN2I0YhubwvL+L1osCaPp8oy6I6FRTqsbGF8t86u8BdhRL7Kkasm2IcMo9RvpyiYyXP5pl1Wmyd0QW5UfNabeRSrZcYXNdEipk6a7vH42jPCUmfkkcIq2uEeTe09d6vNXNV9PgoiMcKtKEflgbQGnCp6ZbKlC6RB8vhGhBLXAJ7lDCrHS53PHSpOwNTRWaRZKBVQAcNNVnvO6bOpAC/wsFHD2Xf63bLxhfHUzKzdj2/h6/7cwSOw7y06bis82fIH6wK1QO/+/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(38350700002)(38100700002)(44832011)(5660300002)(8936002)(4326008)(33656002)(6512007)(8676002)(52116002)(86362001)(6506007)(186003)(53546011)(66476007)(66946007)(508600001)(66556008)(6666004)(33716001)(83380400001)(26005)(6916009)(1076003)(9686003)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TkypX0OVJuOuHlEhgb7g/MrIZ8UNLO0Ikl8I6BdMU4YCPoHFske9mTTrAdt0?=
 =?us-ascii?Q?q6eJvnBtiBwIysjgCdPG1FCTy0ArpY7AKvomDW4Wtro3UDP+8Xemywwv1OAI?=
 =?us-ascii?Q?yaxuk7O27mLAcI3UT5fpYpI+Gpa9txW8ijsdabTB5exzMJeLe2GQjqCZbv9L?=
 =?us-ascii?Q?w/q6SNZpALnF9MfMI3QimHbSpUy0QUj18ILRn9BRH72P9bQ/y4eRzvU1Gmn4?=
 =?us-ascii?Q?wN8nmPcc5UAtwe5G5DMlGlQdqumh8rwTlrof5GSjAcrWgLt08fFKe4kxWTVR?=
 =?us-ascii?Q?tzjTqaLWExWTYj+9dgqJ4PWfJYHEWq/l3NSLluNSt2phV82lB5ZL32Cz/wN6?=
 =?us-ascii?Q?EPqHDo2zepBvrHqcItzPU0n9I5IhkQOBo019asy99Bw+Zt7YkvvSIVc3/xUH?=
 =?us-ascii?Q?LCWpGrjSVUvpAD7yxYnTTBWBFs3SPiLjHD/QGuLAaCTPotJGPPOaKWGILoIW?=
 =?us-ascii?Q?nnoyCx3fa3FnFAxoHPuIGFWiH6HVUL4kSyHubDCa+WaioXrBQSBts++ceJmW?=
 =?us-ascii?Q?pZKL2fMLt0J/j74TFMXFhcd8h24Rkq+0yFsmb5+DruW2kK3Hp6sAfCpntPCT?=
 =?us-ascii?Q?dlex+caiIPSk0cLaTthWL793936gTiReIvxkp8wtW5eYOPNRva7o3Pf9C22V?=
 =?us-ascii?Q?a3X49OnydniOnd/5fIO+7DGYOBv6psc+0zk/K+1tHO/ZI3e4mpWK4xKC416a?=
 =?us-ascii?Q?1xGyC6H4rbDR5qiDFiCrN/5vC59R2RzzOuAqghUQEt/pmngLRJUH5mYAtIFZ?=
 =?us-ascii?Q?kJfKce/e9aWtmLAM+Kp8ebd35p7SwJBqoNJqN2c6vGzd7Q7hUuF9IX7n5E/g?=
 =?us-ascii?Q?CUB+Ztuk6s+g638Ci01dsduZJgKgHL+WfpUoQ7sy4YmKbQw29Wu5dbz4oMu7?=
 =?us-ascii?Q?5FOtv8DnNyHyE5DLXX7PWGo8kbM7MwypXAUKCuH7aB9trkwMesWXWydkcNTZ?=
 =?us-ascii?Q?fTh+cZ2NyS9gPNKY0zbhqVXmrxtsnCImv+qa0uAbh7F7AGwKmTbgXVSWPrph?=
 =?us-ascii?Q?LEYt//2l5r9KKkJ4GqtIlWQ6oMxWoI8iorSCkzBIQxDkHCIgkUClYYnuKKDI?=
 =?us-ascii?Q?KD23ia+LFLtj8Te0ygeyy5DGejmx6gS40wB6p1pdteVFl6ZI/pMKAphEtBjm?=
 =?us-ascii?Q?fSf/aoyArvX/mYATVPg6bCq3mBWvQ/BxJdDBv//nmFH1l+Bq+ZSF9oPkLia4?=
 =?us-ascii?Q?pjlVsO71I1siM59f2HLGUloZr8p/7NPtiy08FkZ65nnFG0QDIj8o98OWH3UN?=
 =?us-ascii?Q?rtTyjRNSHwYGhj2v6vN6MDUk8dLvX4lfpvogOd2LpHnxlC461fO0iQ/U9HhK?=
 =?us-ascii?Q?chkp0ojpJNCt3N5fE2fTLK+IvdesVmjprwti4xMHIwU+Yyz/UkS8s/L08GUY?=
 =?us-ascii?Q?Tei2Nq0jZW13OlWzVipqHljdTgX3XrRepzY7Zg3VCXneHM6ogbz4Q2AKQiQz?=
 =?us-ascii?Q?EUYJOM/WXZPK6x5XT5l59lfzfr+9B2cn5prTZAAdEBaW4NsqGV7coPv4/y0x?=
 =?us-ascii?Q?3uAmneWRQAdycVqkQLvlw+RMxoA0D0A7QeIbUlGaoLPnfFNZzt7SPrarFdEJ?=
 =?us-ascii?Q?cLs08D4PFxhGC6+bU81VNZpCV25OYglNBnAuACNsen/B2KFKafm625FqKae6?=
 =?us-ascii?Q?Rgr4rRbd+I9WQd/nXcNFQUH8ZJdzi9M7G++l3IAz//hFGUwKps+1dsMjnxlT?=
 =?us-ascii?Q?SjLmiw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed90d1de-991a-4048-bf46-08d9f221f5dc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 14:29:52.4394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e80xfcU7BoXMTyKrUf8OBKa9Mgvp/3uAxXTkOChVXjKo2OK+hvFcNfKbV5qJ09u4T8xwZ43ndkr90A1FN+fxyf9iDBJuDfkShQhsRs2d+ww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4938
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10260 signatures=675971
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202170065
X-Proofpoint-ORIG-GUID: ogIjmWA0RGDln8CDD_FcJp5GT0HipxUS
X-Proofpoint-GUID: ogIjmWA0RGDln8CDD_FcJp5GT0HipxUS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 12:42:57PM +0300, Pavel Skripkin wrote:
> Hi Phillip,
> 
> On 2/16/22 04:06, Phillip Potter wrote:
> > Remove all the smaller sets of dev_dbg/netdev_dbg/pr_debug calls that
> > were previously converted from DBG_88E. After some thought, it makes
> > more sense to just entirely strip all of these calls, so that debugging
> > code in the driver can be more consistent and useful going forwards.
> > 
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> 
> [code snip]
> 
> > @@ -468,9 +440,6 @@ void update_bmc_sta(struct adapter *padapter)
> >   			arg = psta->mac_id & 0x1f;
> >   			arg |= BIT(7);
> >   			tx_ra_bitmap |= ((raid << 28) & 0xf0000000);
> > -			netdev_dbg(padapter->pnetdev,
> > -				   "mask = 0x%x, arg = 0x%x\n",
> > -				   tx_ra_bitmap, arg);
> >   			/* bitmap[0:27] = tx_rate_bitmap */
> >   			/* bitmap[28:31]= Rate Adaptive id */
> > @@ -489,7 +458,6 @@ void update_bmc_sta(struct adapter *padapter)
> >   		spin_unlock_bh(&psta->lock);
> >   	} else {
> > -		netdev_dbg(padapter->pnetdev, "add_RATid_bmc_sta error!\n");
> >   	}
> 
> else branch can be dropped completelly

These are fixed in patch 12.  I asked Phillip to do it this way because
it makes it easier to review if we don't have to look at formatting
changes.  Normally we'd do it the way that you're suggesting but this
patch is pretty hard to review if we have to look at formating changes
as well.  It's harder just because it's so large.

When I'm reviewing these patches I'm trying to think is there anything
we are deleting by mistake?  It's pretty common delete extra lines.  The
other thing I'm reviewing for is if there are malicious people adding
stuff we don't want.  I've never seen that, but I always look for it.

So this patchset is much easier to review this way.

regards,
dan carpenter
