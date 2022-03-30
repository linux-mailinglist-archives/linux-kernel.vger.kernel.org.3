Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D304EB92F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 06:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242449AbiC3EHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 00:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiC3EHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 00:07:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256D9169B01;
        Tue, 29 Mar 2022 21:06:04 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22U3L5qN013073;
        Wed, 30 Mar 2022 04:06:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Z9088qqYB+OJVaUSouEsFwN7NIe1aI5Vv+w6UXmwAYc=;
 b=XzVaXcrJUQKjPBfue3W+moHkfUkTX1lT5+QIbsfPLGcwiAnqviThHdJKEe5bggE0ysUI
 tCzbroMLiGmKZzAEYps9RuWjSiOhrGiyue1D7n4mmZS8RouWr3vDY64AfoMFnyWt9ACt
 zuMjzzEcJgO6EJdhFZT3Yb3eFbZMDqep6+gnEvYSKkuF7GHgK6AcEjPArdexbnGiQIbM
 xtNaIHc57gihF6yI2FYLUoRfz2WxrSFPmZ1LEcdC84FRXHzgjMBdG0Lca59JGrrolJlm
 6oE/Qy7p+Q2iYh31jwlJ/pS42fnNHbaPPFTn5W5k4UUGSJAHWJTjSo3N5AsCOlcd0NTK aA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1tqb86mc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 04:06:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22U42ZpX078403;
        Wed, 30 Mar 2022 04:05:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by userp3020.oracle.com with ESMTP id 3f1v9fjw2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 04:05:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJv7zxH7lNRziSTONWCc+EcNtqxvXMMY28Gwuu5H7NYf+iSP3Y/SF7tnGLuM5Auk6PE7o7BXbhCB4yeftXcIdMsMsnXP0lmTx0hQNM4NyoDIgyyKHz0Csd6C1E9zX4foClsiZglansE9uNdSqirbB/a+xf8ZLCH+I3yDAtP9YsCQCDUCUIof3fk61MxxnT8T1s/X4HLX5/Pz568eP51z2Ce/vDmdTykCCCSUlPE3ItM1n8niLcib7RwotEcXSqGJDhtWpLrire8v1fzN2IouKlKaCgEQma15ricDoRBQ1M7Lv3e+5Og00L9i9+kYreLeuXBOC291lL9Hka5wKr6dsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9088qqYB+OJVaUSouEsFwN7NIe1aI5Vv+w6UXmwAYc=;
 b=jXm0P81Fc2zsiULAGLE3y7imVQ4/JjyK0wEt/BvzdBJOJz+PVX0UveRv8vvOqXNqvAOzc3CHshVpx8phM4+TyRyc62m1tbSCz53fxoY0oyXSR15Jb2WmbvksT2NMmNHdIG8y4WjSzghM7ky42vffaJ3x97W2MMABsEZUik7DnJio2uwq1PnS0GYxiOHPwhK64VapMn6lNa9IuUYLG5X6f7fe4Ggfp4ZVYDzDarQr+gSBTtT0zyP45098v7gEKlEIuQ+8vU1Nmprg7q7XIZFMTYkeyzTeT0sLZrVt6HTrZ4Iy5l9mAemALtJ1v/rA4/inopng6czHLQSmF37GtT5NNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9088qqYB+OJVaUSouEsFwN7NIe1aI5Vv+w6UXmwAYc=;
 b=CMlebsi7TmaaOGnEFwqi4M3L9gKqmfOiQ2PDPk8lTxXe6GDGCMuc5nXw2oSvO5q2Sndj6rmfPNvT1E3eJdVei6uoTIuYp3/H+Y4qhpsZXA6wjp4NEJ+QB/BS4OsifpVVb0P166g3/XLg/wFaRndW4k7WleN9ZBaxt5MTiWo6nCs=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MWHPR10MB1773.namprd10.prod.outlook.com (2603:10b6:301:8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16; Wed, 30 Mar
 2022 04:05:56 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed%4]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 04:05:56 +0000
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] zorro: Fix a resource leak in zorro7xx_remove_one()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq15ynwt78l.fsf@ca-mkp.ca.oracle.com>
References: <247066a3104d25f9a05de8b3270fc3c848763bcc.1647673264.git.christophe.jaillet@wanadoo.fr>
Date:   Wed, 30 Mar 2022 00:05:54 -0400
In-Reply-To: <247066a3104d25f9a05de8b3270fc3c848763bcc.1647673264.git.christophe.jaillet@wanadoo.fr>
        (Christophe JAILLET's message of "Sat, 19 Mar 2022 08:01:24 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0027.namprd11.prod.outlook.com
 (2603:10b6:806:d3::32) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2a36886-88a4-46dd-33b3-08da12029701
X-MS-TrafficTypeDiagnostic: MWHPR10MB1773:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB17734BFFE5F966791E5302B48E1F9@MWHPR10MB1773.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C8vg8A2+cjt5pFJx/lT/6s5QvBe0dqO8vhISJZO2qbw0FRlTRAK3HrMmMn3qJ9FD80Y+JMYt+983t/fa4F91PKQW/NbeLHg+zGm1vqSIk3gXpRVU/Fa2hPNti8dbfkIpQfRhMppdE6C/FI+VmuzxEpeSc8/sLL2yCrrJk8MgUG19Twn9MFyHYTphT0bMyFgHnUvhrMT3t5HTRZQznf3bcvOktXdWSXdZBFFnLuBSB9DKsEF54R/qNWOq9v9B527eCjaICDXVpjXv5O+h+RVi4t6wE6QSPTQCEIF0A1pmtWC+qMdhRr+PBcROZxUf2s56qcKVw1s1SbS3GiScU4HFpyuxiZKvhGtNnr/w8ma5Abw27097Wm2jIWAA2VfxdNn+8nauQshW2EpXohIpAE1/Th1J3a4ZtWzoGft5sXPsUim/Xky+wuRGKYj3oK5tMIeU+h6y+qkKEfkhHYb60KJoatUHg9Jf9QZfmUlhn3geUaR74JfwyguTUqePEG4PZUzCbnN0I75x511tMWk4aNg7uox1r+dQ94aBjNZGT4Tt8XwgxBB46fYBSv9eQre5cDMcsh5o4yy8WyfijbDiVib9EJ49s3Iangitonz2Ph+FXLaz7E3QGMiXPpw+76lVipwE0e2XrIzEPVEGEr7LqfSc3sh5IZKvBpZtWC7TNvoqoPiWGbHHKzTkCTCiD0ZgMMgFnMuC4Fm6agj3UBuZJSyU1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(316002)(6506007)(52116002)(66476007)(66556008)(36916002)(6916009)(508600001)(5660300002)(8936002)(8676002)(4326008)(558084003)(54906003)(6512007)(86362001)(38350700002)(38100700002)(26005)(186003)(6486002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0kDQZ7eD1TWKprbhfYi51o4AvEX+8SGzhFjM4Bt09h67hyxZsZ8LMEGokUgn?=
 =?us-ascii?Q?/ckJjVskAeaCRVc3iWxGuCVn8J8tcj3o064r+CbNur2bzfYchb0UIeQZfXEP?=
 =?us-ascii?Q?cImWAY455pGnv7dFGRCZz8Wg7Pq3co3J57A3eLA/yx3bboPVzY0qOUrDDDfn?=
 =?us-ascii?Q?hOmd/NQNYZFnvd9q4i6mnA6xmfPVQ/H8bDi0GY+3uXBrRaxdru6HadYozoU9?=
 =?us-ascii?Q?0jh8yz2SlxnpAYQX4Y8yDK/jSOZeslrcP/QrczL5BL6CCY4o5XADswhMeJ85?=
 =?us-ascii?Q?RQQmhM++hOvjK7rNJvKw7zqtR1VlxYaTmVbhzL7SBkL/zDg32ZHWTqMGDLNU?=
 =?us-ascii?Q?jLJPoMUYcaX+xj0uBvpkLuELV16ARl9AJNJRd5EEAWtkIzK2eh6Fhdu/DCxk?=
 =?us-ascii?Q?qndDwrrRaDFgVQaG+TlPGmztl6W/rq1R1iPMuH2aBCRpY7+oiqOfN6uizQDa?=
 =?us-ascii?Q?A9gz0i/U2x7tCdPYh9TrRJd7rXA+UHP8pzfXddddoWJGZ4GLSXIYAa4Fna0B?=
 =?us-ascii?Q?avv5CSLQ4hcT0ous+JuLJBUyCaA0e/jlHUZhpi+yznRxy2PaPsSHVezvXIQe?=
 =?us-ascii?Q?JEipNyMrQDWWDjfQz4+95Y8YSKND2M+31s22iT5jXmINu/dRTgMZwewupW6A?=
 =?us-ascii?Q?7o8BLHQADdQ0t/a5K7AfBIlMAf7WLiHsXPAJEQEnBeG7qcwZhmMj9bb+PmNT?=
 =?us-ascii?Q?FfbGkmi3kEkaW9jnN13/QouYiNP/GqDXpuHa/Kq8HYann+7hcXdbvW1vIdZw?=
 =?us-ascii?Q?1DcKgkT+SgIbP3XcurH7uCIu5iY4DoWIandSpB1u6olDORA7ZB+m7nEUOsO2?=
 =?us-ascii?Q?yLWgdTIFmK4yzRzX8EQsoGYbhMyntWr0sIC+mQv1FsvLDZsKVN+NZOv/cvL0?=
 =?us-ascii?Q?zaoV7GeOkC0u+SwAB/z//SrV/YQjPhaqOkF4GH3Ys0F7Eo0d3eDydC1vXV0j?=
 =?us-ascii?Q?Qb8M05AAVQXf7a/0Q65dKU/oZYTf7gSandDjW5B5b8i99WWsjO4CCC0V9Spk?=
 =?us-ascii?Q?gHzgM2fVEoZCSwCJKIhVjsNDiwFvtbnMnIptRhDTxBG0NJUhTLFP5k6BbaV1?=
 =?us-ascii?Q?ymBbyj7wUhE/EftWams92nOoZEXja0K3CO+3EBBIegmW9ajLh9jNpJVhLwUZ?=
 =?us-ascii?Q?kZwi7C1c8rbCcuOZRNIM9Wj/oNbeNgy/7jBlS3u/Wm5C0rtptWOMna7zFyiM?=
 =?us-ascii?Q?IpdvNFff6jRTsHDpn7MfLrsYUPpEL6nMTC9vxcUm++daPCJRVbUOKKvm8B6S?=
 =?us-ascii?Q?8d2niQhXlXlkxnv8ryHtSVHKQ9JAEf3uperruzlNLhPGoLHoQZ8u4neJsz4p?=
 =?us-ascii?Q?PoyMtH6Sz9X4S1rXo9CR8ynngX3cerBVJ0q020KMcVsPqa4tYnrIQq9KLkXK?=
 =?us-ascii?Q?EUGgj4I0sZXOyFnNzt96eQzNin84GMfQyx4B5EhPjel3DcAZ5ytK/a1pgYh+?=
 =?us-ascii?Q?ae1umx8dcGxR3yTAI/kV3vmkaOdLkQJVEesmizF2nJ1FXT2OVqLqWMLQo76M?=
 =?us-ascii?Q?dg3zHBTDkV7uQOLWnau/KsTaPrJ+YarhcqSrBL30GYLO20fR65qcd3bZIJjg?=
 =?us-ascii?Q?wFhac0bQ84ZlEd089H4UFFXon8/+sM8chAAYCbugqTA4rQn6x4Suxd1vU5x/?=
 =?us-ascii?Q?RwGmL7bKw6tsZ+KTHtdx1N9CQ2sfEfLYeovyrslWcAR8th+kQ/pg94nERjr2?=
 =?us-ascii?Q?WAU/wda2Dw1fldJpxYR1Jx8tjBAWR2yipy3JqloD9rcaPKq6IHyXqjtSWioo?=
 =?us-ascii?Q?MixPvNgNQFz2QY5KohJoF+TEEomkd1Y=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a36886-88a4-46dd-33b3-08da12029701
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 04:05:56.0269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3ZwpFEX8ZbX5P5VXeSE6daNABKHopZnZfKshSHXnlvO8hD6qkttTFRXfjsnzCl4XwsKgslN/CHsUaxmXQn33g8QurURc/iYOI//ZHsfgKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1773
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10301 signatures=695566
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=677 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203300018
X-Proofpoint-GUID: wsHTF358FpmslDyn6uJAI-gtJCq9nDDl
X-Proofpoint-ORIG-GUID: wsHTF358FpmslDyn6uJAI-gtJCq9nDDl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christophe,

> The error handling path of the probe releases a resource that is not freed
> in the remove function.

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
