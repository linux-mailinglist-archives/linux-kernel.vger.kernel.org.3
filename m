Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3805A4EB8F9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 05:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242363AbiC3DkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 23:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbiC3DkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 23:40:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36ADBC90;
        Tue, 29 Mar 2022 20:38:30 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22U3VvVM001224;
        Wed, 30 Mar 2022 03:38:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=95I/VNpLfLQRQ6xsJwpSpDDYxwN4Sj2lfwTdf3033hU=;
 b=Mm1y2/NQVDR35gZAxRKc4tQ/vgMNhFm9xljrdXszkjRn8zSyAQ//+tzfrbWYAJW0Q7E4
 R56H6xIg3XdtJ3EUh2zzAAZfwFS1LZvYsuVvhyC2d81FqptFDyU6IsYSpp7wMRBf+B/x
 gIZFjOjd1qsicZerQePNeXuG1MshmfXNzazx8tgfDb5TYZnvq6zNyMSmTk1XwUY+MhOu
 rLyeY+9m+3Vq10hidLz+NFddfKYzRVtVGfkskH0T9DQfyVzjVUvu7j+OfSa9DgVnRobi
 7AHCkOYk/CN3a+YAZdu2hBhYlrWoZMPR124Y3sBmdo6Kj7E7yy+8Os79UlZA+nCHGDe8 NQ== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1s8cr3xh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 03:38:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22U3ak0i141947;
        Wed, 30 Mar 2022 03:38:26 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by aserp3030.oracle.com with ESMTP id 3f1rv8e7wt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 03:38:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iohSwyUrXHVKilkKptomcppE9IHdaBsatuo+Rfp/W+rda+oC7xu75hOIPnX3pBA8acEz7COv5MnJ/J8oSqK3KNI9i75VGD+G2AWwLluRbbvwkxgMNxJQ7nbSumGC9cTFH3Rzk9sQGv06VNapbxD0m43lZlEf7eHQCUg8TU3FqiSrEAoCRPKTBVIYnc+/COjQpwYYaLMCG9TTGLvuHA+VGYpnEHPVIVpJnZHmqK0GB+FCEhha7tXlN47phv5uU7X3Mpngk4eFM0SQbOyKBzAoCNHvho5Y7lycUb510cIT4soyQWKxx0uh1g73Yvw06NS6+altBUJ5iCiQQBNHVGITbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95I/VNpLfLQRQ6xsJwpSpDDYxwN4Sj2lfwTdf3033hU=;
 b=RqIphb0lfa3iITnNI/TwcH89O0ocMQ6fybZGypWFezeoLRBCRBjvmIgsYjoDLBvjsNVxjkSKHItpSkR86NHVfXYUwapDLLsT+HYSMYKVfPlobraUdgWIyLqZCcngPM9BuVoFfqkK0O7x37J71rm2Xa2Wvgzh9QTm7/5Scj/U96r4Re4WJ2YtOiAusXJZ6QRUpsmsDIWLXb67dKisKTk+tvvwLmvJ7EyLA0jNgJmFPR1LX9Cc0OHtUF7YUvxI8YVPqMDwudcMmrudTditg+V9csMI4XKoQzVAqkPLq6VsKyfOEUQW453tAl4rovrEvynt3VJ+4GxQewmU3ldHON6/1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95I/VNpLfLQRQ6xsJwpSpDDYxwN4Sj2lfwTdf3033hU=;
 b=soBZJcqCQsuifaKR6A3juFToZWXtux+knNiE3qWa8BmmQ6hk+sdG2oJKsif8n2/y16/k5ukh0MJoiYV8TEsrROLjIdcTCZ1chDmCwjkjRTpXkXTy18NRxc6rdP38kzraODRnLzuP03h+IrL3H24xgdCt2JG74mEtOk75WDdY7Eg=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SN6PR10MB2767.namprd10.prod.outlook.com (2603:10b6:805:44::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.18; Wed, 30 Mar
 2022 03:38:23 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed%4]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 03:38:23 +0000
To:     Kevin Groeneveld <kgroeneveld@lenbrook.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: sr: fix typo in CDROM(CLOSETRAY|EJECT) handling
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1v8vwun30.fsf@ca-mkp.ca.oracle.com>
References: <20220323002242.21157-1-kgroeneveld@lenbrook.com>
Date:   Tue, 29 Mar 2022 23:38:21 -0400
In-Reply-To: <20220323002242.21157-1-kgroeneveld@lenbrook.com> (Kevin
        Groeneveld's message of "Tue, 22 Mar 2022 20:22:42 -0400")
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:208:329::6) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20c00d77-2ea3-4e40-07ab-08da11febe3c
X-MS-TrafficTypeDiagnostic: SN6PR10MB2767:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2767F9D42094B047791529058E1F9@SN6PR10MB2767.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xKTmrsYRRI5y9gi43rBApeyrlpAU34ZSKJdzPPtGivJlG0UcJ1FB6R83mghJLPe8qVPUtfAhwfwXvg9B9EqKOv6AsyNbLQlOP+EqSOnkiSTXVRQlbk+d4mdscpynfOthspOe3WelXYkJ2kNC5e18/bqnF80PJT9+Kzis6GWk7eN5wfOEKDv/Lc4g1+dM87bUUkbRamTk5Kt7Ckw6wVHRXs0ix2VMBvYoygwQ7JFJWMOh7J/8rXlOVJMySgnAGrBMUaRDPbFyWRxjg4NAoZVwFiQuOVQbpOT7nJDGSwc9InNCVaHZkgiAuQxxJk+DpCXGuE9wDgqhN0NfzDWhahfFwgUD2/6/xE7Z3nojhBlPcEaFDR2txCesy15e5zNClozjIDiNyxXz1Ttimdb9W6ZBPOWAmWQNFZMtzPN3WlsWeD+1KvKP3sBdHYe4Y/+n8GNrNbBB6KMw41CNdWooXdqSaiKNQMmHHzJ7is1PfO2H9hCaYWl5nYaJUPA4nyVYbXCO5Z7VXyNCB7EYsGdeb49GKcxYtmxvmTJkrjAmslS4ch+BFv/W6uCSnilU2BNJyjqs+wKIebHJXT845Ny2uDjWHvCapuL7CIwBNdI7V53ZrHQq5pteoUHLueHQyko5vG4MP4zzArd9Tw73lpH0++n3nDM+Te1OejZFpkXJsyS49rgoERgH42IrSK0GGlhq9EFkqRE5+ROB74IHiGncasvSz0litzqYgVpvB3JrFRgFXx4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(36916002)(8676002)(52116002)(4326008)(54906003)(83380400001)(6512007)(66946007)(66476007)(6916009)(6506007)(38100700002)(38350700002)(316002)(5660300002)(26005)(186003)(66556008)(6486002)(508600001)(2906002)(8936002)(4744005)(83133001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hrgp7Oeir9naFYz2UWNaPCd+tMuGIYF96O2TuMQyRZ+QKDi74EhhT/K090e7?=
 =?us-ascii?Q?ShPHYOcgUtjrlVoh9BzMxzH0IeJKcNY7b57GcLToWnAfH006b59hZ8nLW3gw?=
 =?us-ascii?Q?1VzQUV1gMKYwZRyiNbSbFC/G5UQhRPFC9lAiV6sUJUwWwmSdKcxNQqRRG9yr?=
 =?us-ascii?Q?fAPDzD9dhbKdwFzQDN71CeDV3PB4ycnA5gJarPfDVImqSJpl3icxNhWs6c2n?=
 =?us-ascii?Q?ltQThg8c2rHottkmtFzoflCNn2KuxWIOWHhUtJQWJDv6EJ6xHMSH8KkQCE1G?=
 =?us-ascii?Q?rI3NJWwJfOBU0RaFwpzjZstUk6H62pRVBOGYycC5KXo4SLDuM97ak8FTbUR/?=
 =?us-ascii?Q?9Ej1ZS5/eZPZR54l4OZrNwdCh1d0pVclYzSUPDJ+x1pfQW5Umx4qlKDun+vN?=
 =?us-ascii?Q?5VVkW5F1HVuUeXCmzEWLXrmcHx1nRj3YS1+IQvqXyTQk2Fgz7yax0BEA+FUR?=
 =?us-ascii?Q?F3mIYBaMyjRMFOGI9XEsxXuPVTrb6anXd/eRPBh1Z6jG2KPrLVUz2w1vidnb?=
 =?us-ascii?Q?x/9or2U1YaSwhfrdenv14upLS3l2jM7rQ9FH77ozWHfQ2eWZ3CVj1rBY7eL5?=
 =?us-ascii?Q?xCmvZjGJ9ALb9mmK6FgLKTEosx/i0IDZTxnZwmVfGH/dIfDjZbBshfJWgeEZ?=
 =?us-ascii?Q?LI2KjILhb5vthnTFlMJguPiwmQ4NkkYf3L7WU6y/Qjj9XKaibwN4D5W6DWhL?=
 =?us-ascii?Q?AZ4EJ7pipx78267oRG01oTQIsFF62cnyt3WxnfZI8kCPuYY+AASbU2w8cKMA?=
 =?us-ascii?Q?J7R6erwtSXO8X2dfQGVgjunRCBNDLM/DyiW11DNVtpWy+uoZPbKTheFBCSyA?=
 =?us-ascii?Q?/Zqzjxs4C487dlVFHskkMg7Taw9WpoeRRln4bOY9D5KWImVPQYcQ6XeB+LWS?=
 =?us-ascii?Q?ibzna92MOUmEB3nXKRFJmNqlVNCjSoX/eIQiqSz9nyIC5Hmz/LiAQL1K9RSM?=
 =?us-ascii?Q?oSsuPJhsGR/yQCS577NXXnCk95kV7JCp4MyJhKizAtIWlKcFIDjt7niDaIOd?=
 =?us-ascii?Q?XvEzkORbAHQIH+VAsvfNh/IbQzh6BZWndTaPDHJew9ZLYeajk+RvI+g9lu5U?=
 =?us-ascii?Q?MTSun7smB/TqVg6jOum2cPLh+c4ikO+ABez3kNPX1G+jCnra6YDtKuBjfPey?=
 =?us-ascii?Q?Sc3KB6w0Yvey2w9YvO8Gk4sfNk+t34khreuC4cnGMVC+d7ao1HPBrOyFvQc5?=
 =?us-ascii?Q?mlWoXdZSopNEC9a05fs3Noi3y+VhKJ6IJz5dO0z4AOo0TxWGcCRkLDMbeTYl?=
 =?us-ascii?Q?6Li4+vLKxXbxz44QLRsPjMkAHGmzb761xgPoh+Hu+8OTqGm0MB6vrOqclnuo?=
 =?us-ascii?Q?pLYrtauL336s/HghnTKG/Esogy1p0Squb5eV4xvufzb9swluLdYhI1kfe9HT?=
 =?us-ascii?Q?0yCHIrbc6taJxXHohhqTvLfA8wl3vGVmqtSmiy8VXWZyX8gjYSoiDOk7j6Z0?=
 =?us-ascii?Q?2P/fjGpAbvz3bAXuCBv+JX+gbItJz8ciYZ2rd7npiiaUS0h6rJqhR75vW3Ns?=
 =?us-ascii?Q?f2gjS9IvyYDKL0ggSB6tY7OxkcbOX1jh0YYf1Dt/+duDp1stxxRf7JSn3uHO?=
 =?us-ascii?Q?XIaKVB4zyC4uIPqJ2sfZrvBwho9hIitNtdrU02yRiB4iWCmsWTu+z8nWV1gR?=
 =?us-ascii?Q?uvV8MAbpE5EdTIUiGi5/5bMRLVUywhS6k/sF9i/S0PF+oeSVR4lmJ5iw+dEx?=
 =?us-ascii?Q?DEGzX0oM1OTqyU67FbqbqXfKTq/huiYQpgCh29SDOwMuyCIiNn3qHkM0GpHO?=
 =?us-ascii?Q?0vLE8jz1MYQs9zRNoO9duTNdn0shVis=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c00d77-2ea3-4e40-07ab-08da11febe3c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 03:38:23.8567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7PeiwchN7Hv+zSHOQRkxedzEGdQjZlpu5dy9EpdP/BINEMiFPTBiByzraKFe6uyAHx2Qd9l2LuGU73deNMrtE3ndW6LbQ+159necOLHWIvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2767
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10301 signatures=695566
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=823 spamscore=0
 adultscore=0 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203300015
X-Proofpoint-GUID: Nq-SDBY5X1SZDZp4Hj5_02lUatyzzVCy
X-Proofpoint-ORIG-GUID: Nq-SDBY5X1SZDZp4Hj5_02lUatyzzVCy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Kevin,

> Commit 2e27f576abc6 ("scsi: scsi_ioctl: Call scsi_cmd_ioctl() from
> scsi_ioctl()") seems to have a typo as it is checking ret instead of
> cmd in the if statement checking for CDROMCLOSETRAY and CDROMEJECT.
> This changes the behaviour of these ioctls as the cdrom_ioctl handling
> of these is more restrictive than the scsi_ioctl version.

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
