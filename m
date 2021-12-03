Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F58467864
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381099AbhLCNeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:34:23 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:4064 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1381157AbhLCNeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:34:15 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B3CW9Zj032625;
        Fri, 3 Dec 2021 13:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=TvoPsv1mQ3e9VKuBkvVcISpJTgbdacWxUg7L6CWCzCc=;
 b=bfB206ZRt/jK0O6lVGwgGKJbuSDaiS179fDgZOKE7lHNfo4pel6EERK8NR/va5k7bQhU
 KWwxUjuEkCIvSj4mSRQCrtyoK2ArROFGwoXXJA55lJRPQdFn/EZa1od7901PeQOtMF71
 MWjPXxKlvNjoW4O4/WSoMHv/HVTavy+O7vGzr2cdW02Usth5PpV9aRxRnLfL1VM0fPVS
 jNX7UjXOKtagx0n+uLl3EkyyadiHHrcstTmxNYMuUwsTrFWYs88msc5Ij9yViLuNiuOh
 VC01n1Ok62ukBdCcrz2OZv4G0Xl+QobSgVvgku/r6mkr6lWb6AQZd04qajJgmiOSJJUZ rQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp9r5fdkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Dec 2021 13:30:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B3DKvPM171790;
        Fri, 3 Dec 2021 13:30:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by userp3030.oracle.com with ESMTP id 3ck9t66aqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Dec 2021 13:30:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKXHLOE6EeLSmx1ABkkfQcR94eSqh3Wce5CvC0m9i4JlhlV4oELQRvGyzKL2AuARs9+kcpEltRT9vBASLVcRUX+ZCOpvdMKGFcZOTVIaSBr+fHNUYXrUwYM3sgPKCebbw7nFJ8nRatMcVqgNMhgRQpQ9KdG46p5xcMKl5jNaqB3IDOy02as2tZAeL2f6QufOKO66uDiFL6kR+GTuoQZGhoxhJJdaWAtFBdzcHkpMV8mHhROXyRkIHb0F4w9P0dXaWIQOvuFNSy/BHB++8oS3hab/ha0vLfBBPJ+rM9hVPSzlwG91y82Y54y/VdGmj4OhG2fs4ZEvIZi4Do8FRO3gyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvoPsv1mQ3e9VKuBkvVcISpJTgbdacWxUg7L6CWCzCc=;
 b=nVOrkvT8fQX1TJ8maQlV+Zf7TOQnbvhJBAku7IVvIZF1MAZi1NVcJc0m3c1m/odINRX5G9oD5i+yCrws8GCxLF6jHkeo9EnayJU8UaEtGzKS/hDUi3/GWCtnzfm+/Ye+UhriUXGsd22xSupsA7pa25mlUm7fFM7/WL/7FJ3CGbXtgzFKiWnFMqi0MykLbpCiqMiNPtNnu3OvSZzSSA1tSLl2N64aeSq1C0ubQuTSmnBg4JV9u5yeHKQ/Dbx6dTUlnrsUPDZKAHZKy6W83MjpQROVUaxhhDofG/T8AHkFx+I0d+VDyIefU0anWSF+19R2GvGLD1U/3s3IXmBTT+ulYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvoPsv1mQ3e9VKuBkvVcISpJTgbdacWxUg7L6CWCzCc=;
 b=CELUAIx9VyxC/XFFHEkaEJTG8BYff2wRwLa/4pYpRxU3qboqR5ZWGPywr8tsulNIbnBXbp+mukZPZp1E/9BejrjQZTuaB6ztiNc750K46gBnsUnjne3zMlrDM05vM523Peq8ADmGVOR/Q4Cap6XAse6tvRwiASof16GKm/1+LrM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1568.namprd10.prod.outlook.com
 (2603:10b6:300:26::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Fri, 3 Dec
 2021 13:30:38 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.027; Fri, 3 Dec 2021
 13:30:38 +0000
Date:   Fri, 3 Dec 2021 16:30:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, Neil Armstrong <narmstrong@baylibre.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: meson: vdec: Fix a NULL pointer dereference in
 amvdec_add_ts()
Message-ID: <20211203133013.GJ9522@kadam>
References: <20211201084108.GE9522@kadam>
 <20211202160357.75173-1-zhou1615@umn.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202160357.75173-1-zhou1615@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0013.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::18)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0013.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend Transport; Fri, 3 Dec 2021 13:30:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4835418-c2e0-4ba1-eca7-08d9b66117ee
X-MS-TrafficTypeDiagnostic: MWHPR10MB1568:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1568E062676F51298C1652C48E6A9@MWHPR10MB1568.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hgUCkrAV1IGtvQmEiDSYcKSvcuE35CQzhMw4wamMILXHjefSrLPQ6KQU1VfiYj3GloOS81Seb2OEOP9gXe8U5ImoxHUIgNV29i84zEqs0AiNaz0/aPS/q/LVeuFJs4JXnDpkI55IM+ZnXM5auMiYTw++VtyJD4JlLAJyUV1q4ebSmO8zIUR6BbSrqU46wkFPerAgNR28fD8Mqe10RliDapZhiV2U6SdFuwY+yOYS0wYXdzOLAJNue7TOegKIQaWEgbETA4JvozoNs3TRhHSkbLJZQjIEInShSjZGa3NtPnsfqeTGf8SsBB5n0PLAwTMVWAXhh7yqV1+FWMao/DcpK7KOs0puzhhHtBBtiR7t4cgmLANFMSWttMgLiBiG58Tb+LM0eU9YLi00A3Vzwrc4XgqscDXbXRi/X5oN5IxJ41UekqgzNCx3ojs1dMVkcIjdCxeJeP4P010bT4psYlvhl36mmzDmXCo4QuwUsRYHdwjoLJOJUniuIimv+7k1KDTW9Kb0ISGZ51rHjBKLQKbo7FfhoAIRsiOTo2AXrDbDexrW9L6rt72WqPlbWfHqB6NRClmetVK+XKFMuRVB0RZ9jg78lzezeMCGH7JvsJ7Z5GtlDVyrJfE7W9wG9g3NS5UWR3hSecoytW4b/+UXoXZ0tJUxVbGbhnOan9PH9QWdLmWlnGzYSaxnnIag1j9szizY6/cH8ZWHi3Dq42E4/LxsWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(33716001)(5660300002)(55016003)(52116002)(8936002)(26005)(86362001)(38350700002)(38100700002)(6496006)(9686003)(186003)(33656002)(54906003)(83380400001)(44832011)(956004)(1076003)(316002)(7416002)(8676002)(508600001)(4326008)(6666004)(6916009)(9576002)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?un/7HqyOvoQ+qzDs8AKZlablcFBNtBQETwB5E/exXcZb4r+8rJl9URrR2fBY?=
 =?us-ascii?Q?GpuL2RcuT/sdUd7yJNDBVk6Mxd4XQ+ICjbjjJ9LpGpmb2IqIvY0ssh4QsYc1?=
 =?us-ascii?Q?mjD3Y26zQOviq4c1j3NRUo0NGYKkP4Uf9CQD5yJkJAvoYuAhKnyUURWTuJIG?=
 =?us-ascii?Q?dOOJQQ36+diMkYuYNNFC2WtqMt3ld/iDXRQeGpCBC3SAs44QeZCJVr564qP2?=
 =?us-ascii?Q?nWb5nYHwU5XFV+jMYnK1zzur1nKDRxl0hf5lMbLDitSZYId3OFz/cNOL8D8v?=
 =?us-ascii?Q?JAiGe38T0O75h9YY6KCxiLVN393VK7Ku0LTUL3bL3gK/E/rctT9hLRrmzDRV?=
 =?us-ascii?Q?pz4RDkZSd5b6wa1xqNquEhM/BnNMYnx8j/90BdPeoIe73hvasP+aTmCQSp8b?=
 =?us-ascii?Q?/vmPD7qmRUVkuiGxA3OKwD/2wPALBveGh5y2wyczZxcICw9hPLRJjGHAizwi?=
 =?us-ascii?Q?Q9WtyuhvVnIiKtriAG41H0gC5vulLIb7qsv9/1I2vmmHjA+rK6vaHAFKfxAb?=
 =?us-ascii?Q?e4x1lS7FkHbINQNFbjJxQ+wZpYcypGnD+o2Z1jYzN93PquFNQsD2bsfb7fNj?=
 =?us-ascii?Q?egy/KYH1LmHncZjaMJJU8MYGqWYbvQbQIXb0CaJ8Fq/mTMJurBPWvlbqyxdF?=
 =?us-ascii?Q?q7iNDXd8D9RQCWYD8Y6H+/TYR53byAVDvBdkv6XNiDjcRZQVNLhgbdVMLbPm?=
 =?us-ascii?Q?l7RkA/R2ZxlhLcFFvja6q5t6wXtnebA85xN/dVLFDSpYIuv0/k1aMlK+CONY?=
 =?us-ascii?Q?4SmhUgrPluJXNEBs+TtlRBQzQ5M1jLpWFEVRpSAPHCN6WFkZe4tRPUeGwwUC?=
 =?us-ascii?Q?MAtubQRI3hqFuFUlus+E8BV6p32RW2I6vIGIwFXXyafCBxpnecheLkOvhR78?=
 =?us-ascii?Q?4AeoJG7Ooe4JFFLpW8OItFzwdmZ/UcytfrH+S+8xmDq3QY3xWSOIdfsVASp7?=
 =?us-ascii?Q?TIadEtYiOP6vA01cllmRja9/b+X1FIXJSQEL0O+lz3sFrGPFMPEvdbWwNPlE?=
 =?us-ascii?Q?uh8QoRtRotQ1lA8DzdvvRic5+pkMbb0yVJPgeoDlef/PukQg73bqQRdY2I7M?=
 =?us-ascii?Q?VEVwUJXtBX98B1Azuw/Uh63fyeTSrj+487zuI/xEneDrt3o2Bqmv88mKvvVz?=
 =?us-ascii?Q?Hbti7E4hDUQfA3lBEH/4N8zWIT+O84oEOyovRhxRrpKrlXp+zspxXw60jBHD?=
 =?us-ascii?Q?kXpebMOAVh+KS8nOdMYDDVyjtGtjBcIOC+4ZJ8c0czczk9zOU+7E4Ra5inP+?=
 =?us-ascii?Q?tzJtYFJF/9IiHV7g2qw6CpcU+yJ0fJEOU07qbsYBaFiVrJhBx8/GchNJg3UJ?=
 =?us-ascii?Q?PdAHf0ft5IfJ1qoIJEYmA5fXuhTN4p/A8OhkUOGhlxSRfPa/UqYkYrMZcl3m?=
 =?us-ascii?Q?kVsTvqp88ifZTQOz/gXUnulSMwKH3lQ3vfw21XYSV539FQIGKKOQL0LMzNWm?=
 =?us-ascii?Q?GUIesLGB0aap88Iv1THWxizorJr0oqPVsE12wtQQ+0jIk8X0V3PyQPMvtEcD?=
 =?us-ascii?Q?bCg2eFzluKViB4EwaTHTaGq39KYfF6hfR9Tci7OXMfWKx+amMdGh1oTdpACi?=
 =?us-ascii?Q?FMMwy3YO5rvke3OyjnwmvwSMK1reLYMGxzrf9BSL7L26ht6+fktj40JOHCKP?=
 =?us-ascii?Q?3jm4JvV16UFInKKryvoY4XwO9b/qhKOuTSjzFJLVwFajTL1PMv0q1+uprFbg?=
 =?us-ascii?Q?sBG8alVIbpfqFlnEoxYyv8CwNwE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4835418-c2e0-4ba1-eca7-08d9b66117ee
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 13:30:38.1691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4V2irXk6/t6/6NrNt8D5g4j6IhUka5TDTDjFPRyU9TlcVVmLUjAPC6RXU8O/1UWuhOv8oJzhbEfK9j2DH9pxKbm7mODl8N5Eic/n7Qcy9Mw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1568
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10186 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112030084
X-Proofpoint-ORIG-GUID: i2uN8798X2nZqurxkGIWG-UruV0kvl5M
X-Proofpoint-GUID: i2uN8798X2nZqurxkGIWG-UruV0kvl5M
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 12:03:57AM +0800, Zhou Qingyang wrote:
> In amvdec_add_ts(), there is a dereference of kzalloc(), which could lead
> to a NULL pointer dereference on failure of kzalloc().
> 
> I fix this bug by adding a NULL check of new_ts.
> 
> This bug was found by a static analyzer. The analysis employs
> differential checking to identify inconsistent security operations
> (e.g., checks or kfrees) between two code paths and confirms that the
> inconsistent operations are not recovered in the current function or
> the callers, so they constitute bugs.
> 
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger. Multiple researchers have cross-reviewed
> the bug.
> 
> Builds with CONFIG_VIDEO_MESON_VDEC=m show no new warnings,
> and our static analyzer no longer warns about this code.
> 
> Fixes: 876f123b8956 ("media: meson: vdec: bring up to compliance")
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> ---
  ^^^
Thanks.  Next time put the meta commentary about how the bug was found
and the QC process under the the --- cut off line.  We don't need to
have that drama stored in the permanent git log.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

