Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C7C489018
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 07:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238959AbiAJGRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 01:17:41 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:18756 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233169AbiAJGRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 01:17:40 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20A1tfxA018491;
        Mon, 10 Jan 2022 06:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=hKIk21JazI9NSxdXukPjCSQlHx383yWo0/odejWOa4s=;
 b=jrwv/zJ5Pa1tFND8bIcNvWYwz2mM8Ld/bULDYQooPyCOwJVNORwSd5RCT3HbPKveU5V+
 fNy/YvCKaWEZpBqZOTAce1JgYtPhD79sLrGuiCVWHBfJCtGuIxWCmBaoN3xDtZtanwOM
 b2SDsXn43cBxQTnbP5aRhFqvY6A008YEMINcJss0dRhpt72MPQzboLCI2bQgtbzW+I4E
 swG0VtseZFL/pm9JQwVBFKd/NMYPLEI1BJykxfjG03SKSr42wYYCDJTL81wrpR12sJC5
 OT3+X86CvIWJDEAHnhxfVYrSei2GTuo4mGqF3rHGLn2V5tZKMG1O4doQg9pzgmRBoEZg 9w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3df2gat79k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 06:17:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20A6G3QM060010;
        Mon, 10 Jan 2022 06:17:35 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2170.outbound.protection.outlook.com [104.47.73.170])
        by userp3030.oracle.com with ESMTP id 3deyqutb0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 06:17:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHrIPqcUWM2LvDYkEZb8sJTRoQt+WlPTDqSC65yAqokPMtQh3aiCaql9W6hCeacaJ8P9nS1sym4Gy58a6DeCmjuPhB7FwtUOKwktGMC5SYtKLw9T4DCp3okAViK9R1GqVC8uvfECnkCSbJLRVd120qJLM3lGsBFFMqk1DsA4zE3t7ODBaSfvN7IMgDecfBYay2vK7CErwvwGwjel6rin3Hoz2cOHLV27jqYf3IBbPZnvY85Wj+Al1EjOHWzVCY9vz25WMqEO1g+CHmg56eCmTGa7bNH/fqLYuUMDB9xIDKZ3AfQDWj6RTyZWSX2I3y5ptDqd2HTHGWpVxVS7x+p34w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKIk21JazI9NSxdXukPjCSQlHx383yWo0/odejWOa4s=;
 b=AS3c39hlB6sAbZsNggyjhF9fBhFNt9SqJA0mNYU9hr4psNX4Wh2dEFKXsGS2LpEu/Hy0qXrrqhBCLPqnx2sXwcLAB/MjL+h1dBDCxknyYM5tIr2sU6g2zotbgv+BuHxd1lugnqkk9qVn9cRTX9+kZdRivrUzV6CnJpBSqyDbHYLZNpq2t5Kl28Tx308nBDQy1ty78sw+dhEVUuhuG2SqJzPOba6V6O8KZhmFhtpbxsYMvHjfMJmMoeKL1robCrLVUhIQgrfaAf/7ZW8ATZhGaD3/K+MT74lrnVDsaUZtR6LBlKyVFPamVlFTEJ49O0pDIOK04HGhQhBDCsbqzy+1Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKIk21JazI9NSxdXukPjCSQlHx383yWo0/odejWOa4s=;
 b=fZvt4ZPN1zM8qcV6+sM8UIxTvf+5tM4/j1doFlZpWjRm8pP4PmcYMvvrOHkIgtA6oPqpD3LvmvLkvCy+2f7FkyjRHaQBK/SgR5RYMrpXzrPMlUoAgbHUNVYITlSfTZJwC/E5+e+nQ5XwERnzPT4U+ezXIKoVLlOp3ZnX6EguCG0=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by CY4PR10MB1286.namprd10.prod.outlook.com
 (2603:10b6:903:28::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Mon, 10 Jan
 2022 06:17:33 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::38cc:f6b:de96:1e0e]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::38cc:f6b:de96:1e0e%4]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 06:17:33 +0000
Date:   Mon, 10 Jan 2022 09:17:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ACPI: pfr_telemetry: Fix info leak in pfrt_log_ioctl()
Message-ID: <20220110061713.GA1951@kadam>
References: <20220107073407.GG22086@kili>
 <20220107134617.GA895400@chenyu-desktop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107134617.GA895400@chenyu-desktop>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0026.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::10)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e712ed3d-15ac-4244-04c9-08d9d400e35d
X-MS-TrafficTypeDiagnostic: CY4PR10MB1286:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1286ADA6E244131D9E5BB4BA8E509@CY4PR10MB1286.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n7cYb06+3NOldhjiOlNh96Ryxc/nH/i0RfjNeHvbZjVAAccg2LEmNywD3rpd/9N9yLPYJMfC+GBUdRFHjmTY3TDw3S+WKCDsOuY7u1YD0orH21/Ck5d1qi4VT20DWVATAtfvfiuEmj4IHjq+8Ig179AKl/kJuDDlnDquC+hb4ohp7PNPc+fVax2NzVYSsCivVV3PbTcZffmYNc7PRdbcVXNIvmEDRgerMJbK5/Q3/VSZwc0e25ZeRLWG+nH7g3LhdOJ7D6lTjsda0L8upVJ/zmj2FGlKgsBv2Ltcx0r38f29l+2xjBojgfDOqyVVXJsAUBnnlIdTNTTHOfh4n5PMi8kMdKRRmNOlq/E4CsS2aCHqJNiHV/Y7fDXJudDVkmjzLD4nWd67ryfQ2ViJY24N81QbSHOLKncg45489zWF/avnjOQMZQtnGGqRUqxqqduK9CYWy2GGy8SXRxP6fq0sgonUWWo595pzFsMlAMzePNCDaNvHM45+BSUGoqspXnkFQZswa+fibJc0/w/d2yZcSprjKktth6rZhwIYekYKIuDx84EAmQUXMgyKwG4fqIKnvdqERfVYskinvDlF9+lg7wgyULXFfOISo5iMAWTAulNPgVuP53DPkjePaMfiNk2Edasl9FyDTmtc2icmtLfdvcSNKEMoOuzOe/N1IsVb0qA6FHnAAadR2JZT2djVVqxt02AR6bFJ+t9xG1x1olWjgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(44832011)(6666004)(508600001)(6506007)(8676002)(33716001)(26005)(52116002)(6512007)(9686003)(86362001)(4326008)(5660300002)(186003)(1076003)(38350700002)(8936002)(6486002)(38100700002)(316002)(54906003)(2906002)(6916009)(66946007)(33656002)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yr7LUWDRQmSf0BePcnymKu1EEt7rflabrMc/60i3EOrsdAUT15unCMdh9KfO?=
 =?us-ascii?Q?oF5Dk2KN2jF+3T4iEk4rIS9ja7H1dKaTYpwzonKA1k9VXOkT2uW6mi0UVVDC?=
 =?us-ascii?Q?ny7vZTGL/ne6UaypHeei1US/4VdIJB+RDZNuZC/P1fwPpOrno3PyxsDH3r1U?=
 =?us-ascii?Q?eLukU4+oewSBrk2V2Xmwq0LJ8YXZRIfP0JF5KPfSoLjPQlLqIi7511pr/8eO?=
 =?us-ascii?Q?0QKdBXhZeMQqiR5tiwuNRv2RKZQKKaXDxa7yIJwVqQCQzSpbW3i5x4O78Mpr?=
 =?us-ascii?Q?cOoW8XcnHnuPLqhm6iNZCAtvQa7UQuNBSGOrfhxGAqZsEQHQXPi2xHMOYGTe?=
 =?us-ascii?Q?dNxCw4nc7fDU3IntSbJK+5zQhzf/bEEdIyHgNK9K0KIiVLioUeTpsv3rUCvu?=
 =?us-ascii?Q?q7bOPy1gMV9WCJCwqYpRevxdlbxxaOnRkcY2Ky30upwsyTKRH06Lrc/4RMm0?=
 =?us-ascii?Q?vkXUGYyOC3fq3owd9Kd8/Ssg/LVx/RCaBLPzXSzStJzbwDcbPsxC/epzV1FR?=
 =?us-ascii?Q?m3V399UxZxb9TFztGV8ruStWJD2VQbN9zrVCrfaDQr4fu+DlRs8+75CL6OdO?=
 =?us-ascii?Q?FyvlCAmJiYwqZZwMllVEYLG/XlsjW9jsLNxbt6gOyal2crCcuz7UsDqsggDq?=
 =?us-ascii?Q?m9hnKCkaFyxGIzdD5/xInfVkgD+FOX6XhPSUNywEAeWxVZM1c2kf3fl0Pwle?=
 =?us-ascii?Q?gznOgeFFoJ5OmpaKkfZ6spXABrsWvWxvoQHHZrJHMM7T4MuAGkwAAn4sWPcx?=
 =?us-ascii?Q?c+nDX5qQapuIE9V/FWbQlKZwyHrcgIBKnSoA+FSp/krzqVWq8XSjvDswFAn2?=
 =?us-ascii?Q?7kg9gZsQHYtRE5hAGodQHdy+5U/Ggo+urTU8Yx7f2odLsUVJUm4LfyvMZIQq?=
 =?us-ascii?Q?P/Cj97lgmeZxDSnPr53TsmWJN5QFRdMAIn2VNwcKQQuCAQer1khhWzFwCJVJ?=
 =?us-ascii?Q?iM+zfIwHpeNtbmOE3wXCoR4xHsdElHygPwuDHD30Efytytl1/z6TyEumD3Wc?=
 =?us-ascii?Q?eBQT2AtpIPMzI1SCmuAwxpfMdURyArTQyXXRwOVNJRW68oDT9RiTLb2f9Ujg?=
 =?us-ascii?Q?N7RkDWr/d2Ti3cyfObd5Jh6otP8hSnhvjtYfMM+miBV/OfJSbfvwTvTKoLVT?=
 =?us-ascii?Q?1KG+j2SkmILvmka1PvMm4t9Xne5k3NJCmKRWkwe5H0sBvBaW6LSiZm/TWo5G?=
 =?us-ascii?Q?ACuIPM4B8wJKSw8yzN4CyeReTmimI3QFrP6mVVA14EdAAJ6cgkv+V4B9SimX?=
 =?us-ascii?Q?Sd0YYf7HOlyOMGymCNWUYfHn6W76S1ZapQW3ozx5dod9ToUcAoFQy/67pvuC?=
 =?us-ascii?Q?JV80XIQKWFCsPXucqlnbm8HQZSnk7hebCg6osEz4Z1xa1rn6FuBVOFrxx0B+?=
 =?us-ascii?Q?CD1/F2jDXagVhAnnL/bkY+dNENymB0MZN6DwbXw57B7Hbr1u4yGCVS63McA2?=
 =?us-ascii?Q?TC5TQQVHgwwXqBoh2XIvOAlxt40+oJvv4sj5OClciCmXhTch8zj59aRkaSTw?=
 =?us-ascii?Q?9PWWq0RxcbynHBKAIp9z9L1SI+Y/InkhR5WZif3jrxs8A9ZDQasBTvFXRG6G?=
 =?us-ascii?Q?cTQ8XG3CjcJPg1V/kK9c+uXznvJZttes3kndRIhXFl4HoNwme51bbQygh9F3?=
 =?us-ascii?Q?8tA2mSI+M1Ljyx/5hz1VNED9MbhkIQpBiIRXrp8l2W3OuYCxiG5X98cIehbm?=
 =?us-ascii?Q?IEnokQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e712ed3d-15ac-4244-04c9-08d9d400e35d
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 06:17:33.1748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZrqYWCAu5HTnPNHSIBwFbKQ/nOXMYDdxxAtVCki8yjB64mrEKwUH904tomskrHlawhSMQ1zFgvSNenUq1wlRXYp+SI5cu4Oqo/q8bDktyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1286
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10222 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100043
X-Proofpoint-ORIG-GUID: g4U1g8gjB42-2tTWqSE4meyE6dh2orZ2
X-Proofpoint-GUID: g4U1g8gjB42-2tTWqSE4meyE6dh2orZ2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 09:46:17PM +0800, Chen Yu wrote:
> On Fri, Jan 07, 2022 at 10:34:07AM +0300, Dan Carpenter wrote:
> > The "data_info" struct is copied to the user.  It has a 4 byte struct
> > hole after the last struct member so we need to memset that to avoid
> > copying uninitialized stack data to the user.
> > 
> > Fixes: b0013e037a8b ("ACPI: Introduce Platform Firmware Runtime Telemetry driver")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > When you're adding a new driver to the kernel then please use the new
> > driver's prefix instead of just the subsystem prefix.
> > 
> >  Bad: ACPI: Introduce Platform Firmware Runtime Telemetry driver
> > Good: ACPI / pfr_telemetry: Introduce Platform Firmware Runtime Telemetry driver
> > 
> Thanks for pointing this out.
> > Otherwise it's just up to me to guess what prefix you wanted.
> > 
> >  drivers/acpi/pfr_telemetry.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/acpi/pfr_telemetry.c b/drivers/acpi/pfr_telemetry.c
> > index da50dd80192c..9abf350bd7a5 100644
> > --- a/drivers/acpi/pfr_telemetry.c
> > +++ b/drivers/acpi/pfr_telemetry.c
> > @@ -83,6 +83,7 @@ static int get_pfrt_log_data_info(struct pfrt_log_data_info *data_info,
> >  	union acpi_object *out_obj, in_obj, in_buf;
> >  	int ret = -EBUSY;
> >  
> > +	memset(data_info, 0, sizeof(*data_info));
> Just one minor question, how about moving above before:
> data_info->status = out_obj->package.elements[LOG_STATUS_IDX].integer.value;
> after the sanity check of the _DSM result?

I guess I wanted to keep all the memsets together.  I feel like if the
data is invalid, then it's going to be a slow path and it's not worth
optimizing that case.  If the data is invalid then a little slow down is
the least of our concerns.

regards,
dan carpenter

