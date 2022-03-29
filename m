Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE6C4EAA2D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 11:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbiC2JLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 05:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234472AbiC2JKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 05:10:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9574D31372;
        Tue, 29 Mar 2022 02:09:12 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22T8oYe9020158;
        Tue, 29 Mar 2022 09:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=UNpWjTgs+dMnqn0JhALzph5ZyYw+xGwvQFJn0C2LjGw=;
 b=Q21fv5/fFQ2HTEu8ocniz+38gLEaTp7aMFhD07iV/9WrijhFQeBDJ9+KikzRhLKVLCl7
 E1B/focPnzORH9UYHCEWiqqdA8yF9ZQ0x87+EJz7oF6RtW5l8/eGsG/s8mE2pP03asl4
 fXkWWACq0wMt6wNg2pd6IGaI3i0mPZUNheQ3bOUXEutuH+8DCbZX6udUvnOCR9Y1SFUw
 GlGq7GIBC5+aATWr1JBO+PQeacfd7Mdl21T4cM1drAnLdAJMGYXhwc4DgoewMPwLnI4N
 fcLJRvfVBCLMboOb/fusZ53JKlBcNH/WBBGXc2kzRfSFDfJ0rJRU+whfwVX0nHs03cme 8Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1uctp3p5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 09:09:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22T8uZJt006455;
        Tue, 29 Mar 2022 09:09:04 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2040.outbound.protection.outlook.com [104.47.56.40])
        by userp3020.oracle.com with ESMTP id 3f1v9ffhdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 09:09:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3dxKLtYod1r5uUbwmd57SmJzHXcCp3/H78FPhuO6YDMofugSf16VCUmFdf0JV9PFsKpWHhJIzkmFu5Zr+t+7dym6b3/tBi9pXU5lMPxfHKg35Ar9c0acOA7iO0nfAkFFoZaUncOogF3/cgIAakJwJ9VGEfrxZwU2jft8pQBP9QOk8V1tn227Q9DlMlruQhRP/KpfV6C8UoaivhSVo504xgrywjmyxwqavHJhOGYY2tmDydkVz16iqorAsdDx1Vx9CQeN37ywlfpHZrpAdC1EUmPX3RcAX2P3c8Sk0cahOw261yPyjSGRVad0kFZ54e8snfKeg/JYXH+q+PMLY5Edw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNpWjTgs+dMnqn0JhALzph5ZyYw+xGwvQFJn0C2LjGw=;
 b=akpYl+8qF23v1cMAiBtnqfgGt0dDdwVVAf97EKveSgRsYhVdE8exAv2lEcT9bXk4ySl+SnK2uNfLccnF6Fkxkh2QRdgC3XqSzz1eTrz1LoMDIfWrMrkm0Ff4Q8f/cg6f7GNp5Gdxjj1DZyW3ABmXOGP5Miu4OzN1nVjLhSPi0rD0NeRh1C3L0zL2gjZldJmfB0AYPstEBfdc70UAzSjX59eK0sY9Bbum5DSqGGKB7vUDIiJSrppsGxSsWrzEHllwlDkbJbm8p4qrtWp1uLY00Z021ehzc/d24g8ZdWl3BHGuWbMqbFVkr2+U0vMFjuiIft6m8lDYqdX0hP4k3q1T9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNpWjTgs+dMnqn0JhALzph5ZyYw+xGwvQFJn0C2LjGw=;
 b=LdC/j/9c/YNZPiQctOOUlM6DLYE3wBq8sXBJA2YDhQ2M7w0B+6cK8Q56GdwOG/W0hsaT2nr+ugFeSynoZBWSlUKSWRvswMBbuGcjjP9DT8csY8vDO4RorRSNbNZNad9GouBoHx9fxf5l5NXfStgQxlmyEV6+JBVW+krdOPhIeEk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB2523.namprd10.prod.outlook.com
 (2603:10b6:5:b2::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Tue, 29 Mar
 2022 09:09:03 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Tue, 29 Mar 2022
 09:09:03 +0000
Date:   Tue, 29 Mar 2022 12:08:36 +0300
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
Message-ID: <20220329090836.GT12805@kadam>
References: <20220328084452.11479-1-fmdefrancesco@gmail.com>
 <20220329074744.GR12805@kadam>
 <20220329075752.GS12805@kadam>
 <824276213.0ifERbkFSE@leap>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <824276213.0ifERbkFSE@leap>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0023.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::35)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52bcbbab-f39f-4be8-1d2c-08da1163c4d9
X-MS-TrafficTypeDiagnostic: DM6PR10MB2523:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB2523D9826119F7BF049B43728E1E9@DM6PR10MB2523.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XUDW/N8SNK1fZmBg7GLo4hRzwZaPrCdyRN/uGuMf6dF1V7pRUQ8ynW6c2fde/8DJHiC58zfjYKPcA/mddVWYYXYDHvePATjxPnUZQDT1wPWU222SoBWrczyd5EkTKffilebSHqa3Nu/21pTxutPuS/ezXqoGxoE5SKWtFrIS+eqTfGCHzZ+3lOphyAJFlhNCfCvMoNkA0ntwUrjcBjW0tdM+bbLf//+dR4h0srnuQQxQvufGeIRDBlcnTen9mGcCVT2CgvP1HAsae9tStuDML+CUWWpU37HIw5tjbKzHs1yRpGqxPdtr0KRytzrK7go3HsUGu4NL4eQFd4/9A+qlFMv3S5q5AoHVOBPNgYuQXDSlzI5QGHb0f/pv82yJJngYDj8PaEVIeRTQ4sPqjA9zRobqUIkrQVlhj55vp/xDzCBn6gExHdHWU0zqq9/Lq9En094uEWfNQNUG5QrMH+9RJkPVBkG7BtLX5t+E/Z9SImS9hlg3YyZyh6fWlUW0OKTpPN1upP57UNPgVBIS7UE+WFBvtRbg9f05DhUMbJm9VPPR2sHmGV32sjumaquWGD4c12F8CmXKRNx9lyPA+xQpbVzfArkHRLRGyW/+FwJ54gTznnJZ7XsQCEUU/FUX8rTy+jWyeKK48vgAaBH02uOLoV29ORmYtNuUOAtsTmxq9C0tMAHBPMx3XrAAhCS4O4yosGwTw9B0vAZcqNvms8IxAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38350700002)(38100700002)(5660300002)(2906002)(8936002)(44832011)(4744005)(186003)(6512007)(9686003)(33716001)(66556008)(6506007)(6666004)(33656002)(86362001)(66476007)(4326008)(8676002)(52116002)(316002)(66946007)(6916009)(54906003)(508600001)(1076003)(26005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JG+ZU43WMDY/NyBnTwOAH1zmjN4cSZpePhgJKcqNP73PUs9gzWIHfLHoZUK5?=
 =?us-ascii?Q?+b9FFJ4HtZaTm71nH7UEEzFzUb3fDD1AGW6oi3gbc2NBftEg+w3K4c193jVI?=
 =?us-ascii?Q?4ld7Hu1OYExdeP0+VdGLQlfoInzkBquJW6gGlq+YM/eduW2TWkFYUYj+iKOJ?=
 =?us-ascii?Q?YTSMgxrqGA6je7OGI6O5ro9gNVVMc2pdpV+9Bzw1aqDRMmMtY4pQwTiILrm2?=
 =?us-ascii?Q?ZAfWGQmYTweyKymLk/65Sd1DGMxQ4sfKBO+E6Aht60LtPOm+xTpJAPOojyw4?=
 =?us-ascii?Q?intBqIzrFNKNRr5cR7YGF9gz2ebvgvEY4IzaQCrBKyXeotpQAKB172YXA6pX?=
 =?us-ascii?Q?W/tBEZ2fgEPVpCROI66pfhw3/HtLuID56vJRpX8FGsaSD3ivtt0XeeV7U5RA?=
 =?us-ascii?Q?pgIBp/v846qL2HZXi6pP2BKXVDMUGGSWnx/qdmdIr7gJgGGJSl1hE2GoShXf?=
 =?us-ascii?Q?TgV6qRH45EPRV+PTX3QVCI0OZKJArAF+uPhCOwQdVZGKyhMysBhJJaYdY857?=
 =?us-ascii?Q?FX9ug4jo8tccRxWwQPETiQ9s8hGINAWFGLpj+jNFjluTWsG0m30w5fEhbzXh?=
 =?us-ascii?Q?LQRi0433ActDhajGO618kctUB565YojNU6nE0MLOGzy6K3eiP+/DAChymG59?=
 =?us-ascii?Q?/7KFDPpw0AhDdIivR13cP8S7DNLcP6UKKpCuVdby0W0q3d8bPiIuXhpECWeN?=
 =?us-ascii?Q?BJKdWzllatkqleHcP2dq9Pi6eY+AmhOaqgyyyYknwvPomqxtwVS3jMUK5ioL?=
 =?us-ascii?Q?Dq7LBL34TMZ7fc6jozmK/Ve3oxzfdQ3KDcIlH5b2LcfX0UO2/cLrVq8cZhUg?=
 =?us-ascii?Q?CQZvwMtyF0XWVJMz5x727a65Eu9R5NYmp86MZ2RRTs+fG9ExTDsNOxW+9ECm?=
 =?us-ascii?Q?iEmk24nikjnvTsOE7w3jPGHxi/Gwh7qUSF3B45EyObgBvhs46QltK6/HEFS6?=
 =?us-ascii?Q?B+B0o2pqbEE3uQfuT8EbRymzzS5DRnD5QOPr9IU5GA9xBApBkBvisnZyb9to?=
 =?us-ascii?Q?IqZwQMiS8wjlBnknVmNKvuyNRvZnzJWuLQBmgq7/IZV1gLTlnhfQBySrvsNQ?=
 =?us-ascii?Q?EiVFGtCSW5DwacfbftUXvdukWacxRzmGJ4nQoitNMDLFAMFs+520wt9lfKNR?=
 =?us-ascii?Q?2dhw5GuwzZUtXNc9sxumdTsyyygga97XnTb0mSFy2ibmC9wYm3MV9de6aiDI?=
 =?us-ascii?Q?k3EgiFKplZICiecg/bXoZRIDt+TsT80zr+4aUfttQs0kKCW6yVTMjSb/lEyv?=
 =?us-ascii?Q?NYm2itd1JXX4RtizB0iuuOIAvaoRJOFRZuvSj7MBwLGmShq8cr0agvmxf6nC?=
 =?us-ascii?Q?7XChWOlyg6OQOObpzkMkWiXKIcrlMQnvpGmvsbVxcDqEUntDTktZ9yU3H+/M?=
 =?us-ascii?Q?yPIJsCU8zJncqoSdu84WgzJbcUfzC5G0OcstU/4kxL5HWabNvxiNmsH1aozC?=
 =?us-ascii?Q?t23HC2ciLTxy7D5MjXbeqWudrk9jfR3/BTrkvBlMhJPuWwthLnJyFz1aGnNL?=
 =?us-ascii?Q?Y97tyKd5iGvKz0MR9iU86hfOblNRJ994Glz6pIcilalmExoi73LnPJdj7Zk/?=
 =?us-ascii?Q?SK92R6IdBxR84o5Vu+f/NevQfpxFCO++MLQxWxTq1bM1jFaUBigGXlNK8GY6?=
 =?us-ascii?Q?Xp9Qz5x9LnmSErOu2CcqxkJs6FDUbEK7waZzb39ZJ0/aR9gB5nHgPqtowhFh?=
 =?us-ascii?Q?2SUkGdK7qKPs2lDKAosiF9bJ3FtUC/QcM5eQN8HGukn25htE+UTjUfFj3zsx?=
 =?us-ascii?Q?o/GGD3gTwQRQDyiX0yp0dCIG+HTrgVk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52bcbbab-f39f-4be8-1d2c-08da1163c4d9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 09:09:02.9437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 98VErxu1q4P29pqugdf5w+PFPdKNNCCbR2GNc+pf7lgcnhv79squC/y4B+BEAFfMSFOoCv/vHtkn9lbIlIvce1Iz/bQdJ4uDL2wBfiScuTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2523
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10300 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=836 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203290053
X-Proofpoint-ORIG-GUID: rgLEjZ0PpTBRDmnDnItEvXZZRRFUlFLh
X-Proofpoint-GUID: rgLEjZ0PpTBRDmnDnItEvXZZRRFUlFLh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 10:28:24AM +0200, Fabio M. De Francesco wrote:
> Therefore, I suppose that you are suggesting the following simple change:
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index a390679cf458..13d96d0f9dde 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -3474,6 +3474,7 @@ static int sd_probe(struct device *dev)
>  
>         error = device_add_disk(dev, gd, NULL);
>         if (error) {
> +               device_del(&sdkp->disk_dev);
>                 put_device(&sdkp->disk_dev);
>                 goto out;
>         }
> 
> Did I get it?

Yep.

regards,
dan carpenter

