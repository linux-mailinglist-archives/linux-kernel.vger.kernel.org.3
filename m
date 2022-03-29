Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4FB4EA8B1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 09:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbiC2Htx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 03:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbiC2Htr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:49:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2A41C9443;
        Tue, 29 Mar 2022 00:48:03 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22T63TYF016044;
        Tue, 29 Mar 2022 07:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=R/F/bz0MPADLQ28Sh9C2tlNmF8oFNF+qGc3Coo0WjkI=;
 b=0uWGBS5phIjwGrOQ+o7c5VH+NQ3LYpQlnW1gQ92I2xvTiYr7qMQZl7kXYfhDV6z/6UXZ
 VqI5fXWN0ZO9Ve25Zv1qfxq9dRC0lQF3/G1qfgkIGZQR7MqD7ygCQnZkeVJdCJbb8mbw
 zP1RCJHgSkq/OLQDzZGRoK4MGSWywEBDiaU+xgwldjZ7mIwjR9TyeT+AySMlww7RqVlI
 ysk6guPLXFEanuV9hL66xb169cMbLR7B58Ou2XIB21pwJ/blX8BKiPpnqS9JxeoLK0Q/
 0aZz9Cg7Q8txpOTAGibwSBTqEIYy+taZ7nlVlo6PSmX608wSiP8oc0g1XjyOu1X8H106 Rg== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1terwrta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 07:48:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22T7frWA089883;
        Tue, 29 Mar 2022 07:48:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by aserp3030.oracle.com with ESMTP id 3f1rv8c3ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 07:48:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0ZOKH4sV+9kP3qDH4pbJQ9kfnaFseTH1Nne7GFUE9iw4MGCWhdcDxr8bsoCNfbWakucqvNqPbhFMQlEc5T36HkUDxWn3xCNl8LwxQNwYLhUAHL43F8gEATGa3IXWTQ9hWIQb3i60eIHTnnZbomHeZZjalSTdpA5g8eczgNl+fbY6QZyLaLnE9+j4WjArPyDPHs9fd76sQiQiFmUYZmzhdVpYmQkXPaUU4WWJyUfwhKmawW1xpGXAsACruOq5w+jn4ASyLBAsoO/2fivBMNDGEvOcDUxCrNN10T2EkzRIm81sV0Vki4lKcjOXn3yHV3U40hAigTzcUr7OS5ckyjNdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/F/bz0MPADLQ28Sh9C2tlNmF8oFNF+qGc3Coo0WjkI=;
 b=fcYTl4VEBEdxwW+E9kJuaemS4kxu+UbEvup7GYoifWVOVxeb+BzwO5lHek15uBFLDmorBQffe4AoVum0j5dQamd5ebhcZ3hqkFjCNPzLt/rCV+QhKJqksGMcs2Mk6cvCO1o41A+RLbQuJmts1FQ82Ae87iKjNtjrRHShAQ25uRQ7Rb//DrxUxDL+T8s1KFoZbQah3TbMcQ0ODmRyjmWnKc/SsHHgSbLBZBLktDIRY5sX1Fq9ACH2EPaDp4M743gSMp1Z+2C38Lo9v2zIZcVbYan31X1kWH00NKXat2h/kuzlCi7o5vSXfMO3GTgew3E8ZZsddv0LwLaheSzR4aF9iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/F/bz0MPADLQ28Sh9C2tlNmF8oFNF+qGc3Coo0WjkI=;
 b=ULyxHv1kYfsmK6uSqIGUgRyMLT+DRz2DThWkKTmnM/4EiiTYFIf3RABc5Cfdoght8ozMUKjWUGy+hz+kdxCuqUb52LTBtHn0KOXXQlDsNIwfmUm9UewD4pzn6tsVSzXzb++kpWBRBejj3yShXGLnZL+xcA04FpLAQ98NfMyUI6g=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB4176.namprd10.prod.outlook.com
 (2603:10b6:208:1da::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Tue, 29 Mar
 2022 07:47:58 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Tue, 29 Mar 2022
 07:47:57 +0000
Date:   Tue, 29 Mar 2022 10:47:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com
Subject: Re: [PATCH] scsi: sd: Jump to out_free_index if device_add{,_disk}()
 fail
Message-ID: <20220329074744.GR12805@kadam>
References: <20220328084452.11479-1-fmdefrancesco@gmail.com>
 <20220328143853.GU3293@kadam>
 <2179817.iZASKD2KPV@leap>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2179817.iZASKD2KPV@leap>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0043.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::31)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 194fbd48-0d42-4042-ba5c-08da115870f7
X-MS-TrafficTypeDiagnostic: MN2PR10MB4176:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB4176100EF4B0BE02AAF793E18E1E9@MN2PR10MB4176.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m7oagmOBSDHKIyo+FekwlfMKQfhYGwa4KmjQpF3K1OEMpE+nWtfj23Vnl1UPJzyXIwx8KY7R6Ln8UC+TpGfurrzwZ0uTe0sUqqkc82pBtGI5gw0sV5e2Gaq5LA4ERhrFXouzPeVs1cyD8RFSSKbIdeLnL7zNb9clNXb0JVknDiqXJIz606HgNj4urzW2X6MZjug9104z6C87pbe8Tkdm3gJB8IQsbMZPSBXzoyttMBZjM1bh8xM5l3i0ncf0JoPxPQa/JM6k2InB5CKRfwE72SwNnB8Ti/b9BV/JHnkf9Que0Rmlv/YsJN8mTdhE4Fp/5uaiabtFmpFoeQBxg1CKDanx8o81RpWWbpFSc3Jsa3OPX+6woKRY3vSCBv5JrUg72iteusek1feFyPxw86ddDMF6npD8Fz19sAKyur616rFC/BZZwmx9ckEPndqvgLFgbePvpED3lMhPXzSizZJ/EtwsyNt46F7E4Y3CYh5dr0A9x5Ok9dcYW8+mo3ICO+dF6083uy/17otNdCsb1gGOmFJ6Ax8pdviPbfBNGPvIcEhH3paPby2ehxcymchhRfExVmeaIQlpx733rlxnzMJ8Ps/S33aihHd0r7MvkbQRECHn/hKUqEqB+gF1+RE9oKHoPOrjSv6kve2DjIDXCLE0n/C74RjBjx2+gea4zr9tX+dBMpxEtWXQB+zreIiurtZi4dc1APveWyHQWGYEjrQoow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(508600001)(4744005)(6486002)(66556008)(54906003)(26005)(186003)(44832011)(316002)(33716001)(38100700002)(33656002)(38350700002)(6916009)(1076003)(86362001)(4326008)(8676002)(66476007)(66946007)(5660300002)(8936002)(83380400001)(6666004)(9686003)(52116002)(6512007)(2906002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ea4LHvAkGP1JUXS+sYF5wR8YvqEQIRFkxsMg38vSTcXT0v5mwiqJLwuAUOXl?=
 =?us-ascii?Q?LkBckC6RiRdJriharblEYIQIIt0+zNKcHCPDSow3cR48BOenqK9GTx7DQsOG?=
 =?us-ascii?Q?qGSZO9etNqo6wJbW55c0MtSGAuJRuNCSrDFWvMye5O7yYR59A3FQr0aG98Kj?=
 =?us-ascii?Q?tXyqt+oeK/+czCK3E25kKB2PiNmgxyI5dOKkI/ZP9/xcZypTEWfLkB/7a39n?=
 =?us-ascii?Q?ggfGYyrS7DKhRmOv4aTlGqS0WdsG6O6tlnF1DL3bqhphO/+KqeFD4+LRaaeX?=
 =?us-ascii?Q?pel/MKn0bczRR2shgydnLdVnh2J6IXVSuvImjN9UyVbzrXc7V2Kr05MOeBkE?=
 =?us-ascii?Q?glWxIF1X5VoVH8ghSNAVc5Pqo6Mm32zJGTtVnCBS41LumlWZ94UkorEc8jnl?=
 =?us-ascii?Q?H4DGX1JSeVKXW7FrU5shzoqiTZQGPAlONyXXRIRkwJika6WPrppCX0nQROis?=
 =?us-ascii?Q?loIxN3/V7n9H6iafPbTrkUsNsU3MBIZVZS9pp9EPUQASG6Oaex1QBJ4tvV6l?=
 =?us-ascii?Q?TCW/YsesR3GHLJlSpBX64LPXiCP/CMxETEm3qbO+KRABLRjGlzeHP4gfOCeU?=
 =?us-ascii?Q?hhqSX8XoM4RMfVumMdmZY9h10ESa/4YwAEbhM1aVNXL0JWWZe/W1akK5OLnY?=
 =?us-ascii?Q?51xJpjzfrjA7UsfFCo6RvdFxlscv3+0KPWkUZQ8VW30o4FphBGfJpESZ1r++?=
 =?us-ascii?Q?HHjJJZMBI1H9F8hWTERzZK3gVJGyoW+/Cod+AT2eVEBX2szoc5SLIBi5rvRi?=
 =?us-ascii?Q?tbDP6LsamSgmo7UAkDqahRRA9lnc2QTV3TSMd+i2fXpuwoVe8hGd+PYit7wR?=
 =?us-ascii?Q?ticE2NZEQPXdoWQOuNgDKGo2vcwBrGG9sluiVx2ec/NNBZArqZMgCuilhApG?=
 =?us-ascii?Q?qSJWwYARoywBpuzuUs4aYfAFdT6ec/VWJmI8O+krS9aMg3D+f0BmEXFSb1Ht?=
 =?us-ascii?Q?wXtY9maOitC5Wp68xJjWlEGrtvToIQEDLESbPjSRYPbLmeE4gw2BrOx9rOlX?=
 =?us-ascii?Q?7voFGNctzkMr1Xl+8mf/tkALHkqDCnC1k6wp8ZydiTLj3Lr5X3TLwh8zxjdW?=
 =?us-ascii?Q?rhgoycE17eENuMtp6bd7cGjmZy93w+gt3FC/zFwye3aATOQrRjLwDOOHwLDO?=
 =?us-ascii?Q?DIRyqqbkh1HiZ6VkoKNC8/17f86jAn7tDYGn/7p12kcEiv5oK3sZ/yG/2dBj?=
 =?us-ascii?Q?q4P7M5yA+lZ0KxrW7ZExqn88Q8I3EiTsu9Zl0dQN7Fto6Nhfnmg42ubEyfUW?=
 =?us-ascii?Q?rWFHEt8FIdMrqhexzM7x3kaCeuRvFJqwx9Fs4vfObe/eAYRDK5RiB74YNErQ?=
 =?us-ascii?Q?tw/VUQNm5XabWiRVZ4/aFUtC9kNOdH+NTCO16I+0A/5G3gG4htRgw9IO2Jah?=
 =?us-ascii?Q?grN0D3TZ9BiddYeCqjDXJvcrm/7nPzr+YKTlVpR4/Ylp3G+xcFWRUyVBaB0w?=
 =?us-ascii?Q?kAO2QoVvvXxbZ/sjiA3vvAqmOxo/uUUV2hEP+dtRiBNR8GVMKbjhVkltiVMK?=
 =?us-ascii?Q?jhNuGw4RrXn+Q0KoiwaOFUIPxLieKd553PQxhKpDvo0fq36ijaNAoTK/RPN7?=
 =?us-ascii?Q?JBh7fHRxR0rtAurtHzcLPjO0Q8ng8jNz610pA2+upNPyDcMfBNCSKGGrRZlq?=
 =?us-ascii?Q?/Vef4fL2UNmJB82m44+Ou0V6b03pkhsbOvBQCNwMUoSAHfTC8hZ7snyL5zUL?=
 =?us-ascii?Q?1LR54PNd1XNhDVa86VTv1gyGraP3SKaf47QKmPpPv4TUfeTipjQOg94yhs/P?=
 =?us-ascii?Q?6IkePb2s1lZvw+JJOM4Y8/JxmY24ArU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 194fbd48-0d42-4042-ba5c-08da115870f7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 07:47:57.7986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nW+jS+0aW/ecCNhWOhXEOP3ru/ecQqRSwTds4F7J5hpFjReI/p74V3keQL3K3zSdI0BN/JLKRWF5fwLHlrxmnmjLmCG/rB7F1AEWhthLccE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4176
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10300 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=768 spamscore=0
 adultscore=0 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203290045
X-Proofpoint-GUID: E94WwdABvnPRbPgdTHQSNgUwg7qSErW0
X-Proofpoint-ORIG-GUID: E94WwdABvnPRbPgdTHQSNgUwg7qSErW0
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No, this patch is wrong.  That is supposed to be freed in scsi_disk_release()
but apparently that's not getting called.  Is the ref counting off?

On Tue, Mar 29, 2022 at 08:18:16AM +0200, Fabio M. De Francesco wrote:
> > There is a larger process issue here.  We need to figure out why syzbot
> > did not detect that this patch introduces bugs.
> 
> This is something that the people who run Syzbot/Syzkaller should help to
> figure out.

Yeah.  Right now syzbot just says "TEST PASSED" but it doesn't give a
complete dmesg.  There were other leaks on this path.  Were they not
detected?  We can't know without looking at the dmesg.

regards,
dan carpenter

