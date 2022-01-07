Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E00487450
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 09:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346209AbiAGIyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 03:54:24 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:18866 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236255AbiAGIyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 03:54:23 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2072tDou029123;
        Fri, 7 Jan 2022 08:54:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=SieT1+ZKJe8RnHcNwtylObWkPh0STK326UVYq4jFFEU=;
 b=M+DUiDzAvyilH85O352jyDZCuvVEo537Uqsf/Et3CufvU8WYaogtFGHJfb4OfuvVJuBt
 73DvHJT951Pr827xxG20zRS8NemqrQzGQdbpZUA62ZtMw+GS7zEPbN8sFI0+Rkt5iC9S
 uVO3n8GEVHwQ++/o72qHE6+x1lOig2eXEJ4B67tJwboDFKHbwfPkajgihXMQ0/7EoUtO
 FH0QiNJ0wSwlkot7BTOv+1q7nJ5zHxvw94ijvw5qxI2eI/HzREeMb1YlQPYFshOt06ef
 mq4fub4spr20XG7zB0x5QE+BNG3YLrXgpetUSu5p8VsGegX1eH7mhzAIxPVB3CWVWpRs 9Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3de4va1dtb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 08:54:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2078psKt027543;
        Fri, 7 Jan 2022 08:54:06 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
        by userp3030.oracle.com with ESMTP id 3de4vxftap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 08:54:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOD0l84YHv8z+6nnVklQ8AsEvw2NX3B19WEk715bCFf2PKf5N+wlOQOVC+tliUQOssrNp89X9zEoQxv2D7zZPdtBaYFDVUsU1IGfFu+cqus4ZNQsZUUhhbmbgadZwjZOhEj8ASGpsjKCqkI0RAZPuzchPH/KX1wEPooSR4YNOt9HGZYPObcv7INAsdYSQOqYnD1iOtWFI4mNRE2LiRX3twY8LONZJZmGGUYssgh2R2J6S9T5Z4rgQNaWD3o5nMe30vy65ATPLFOiUx/E9CDWLQq5xJxBUz8EhDxsX3l2oJwKw73XVSbGtR2EPWzamJvDrN6SbNV7dH0XLNkD3IhlGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SieT1+ZKJe8RnHcNwtylObWkPh0STK326UVYq4jFFEU=;
 b=aYILyjL8DNq7ySax5T4J3aBs5g+kG27gpw2ecbcgKSph2pUG1tWtPMk6Ozdeq6sX6cie7ovzCoZWQb/DTcJ9MHxGSivJF5NFT/Riwdqs8t8S3wIt1+THDicC3TRacNm56VYYp6SplPYS7Yuh6tjsS79SAXgwVmpKgR0vgprIJD0uQ+3UuTESprsaqVVPlUQcXvRC/G+Ol9pRaorMJbIJPYN59MNvUYrPDLRGGfmjBaqsiRM9hUI7UB7H5EFdtkSFuqTcr587BB+on9SXvvIERKTDQ78QAYV8U5vFJvI2LFyldYhn6M8sAqDM4mgVY3HSjvJzmobi5soNhDJo83qBrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SieT1+ZKJe8RnHcNwtylObWkPh0STK326UVYq4jFFEU=;
 b=iBmmfdo5agLdvvjEIlypbbguLI7iGILVDkEEQZO5u32LMKo+HY9cqh76avyLt1iGVF+bVwMJuJjnvdy2EfD2JFPwAZGQRRGX/u3xqy9TUJI1ys79pEwIJT3FsI4uMJgAaLijHdBh20bvD5LZoBnWTTGVQakTMKege1gw67bJj9g=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2254.namprd10.prod.outlook.com
 (2603:10b6:301:2d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 08:54:04 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 08:54:04 +0000
Date:   Fri, 7 Jan 2022 11:53:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     gregkh@linuxfoundation.org, realwakka@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: pi433: move get version func to where all
 other functions are
Message-ID: <20220107085343.GP7674@kadam>
References: <20220106201430.GA3416@mail.google.com>
 <20220106213325.GA10767@mail.google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106213325.GA10767@mail.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0032.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::20)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b58c80f-740f-4b4c-ab2f-08d9d1bb417c
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2254:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB225469BC446BD175BA5650F08E4D9@MWHPR1001MB2254.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gyEZofcZMJ48M5hQjfTtZCfC0XACm9mhWRVcX+3g1fHCADCBXeRwnZ1LdZXZ9RHfEmIV+Bma9845grnI3vRMjN86P1/kcoeKB6cb7KQCQcJuhWEIgjzY7S/OhEaBV55iOzD1pMnnohiVYu2IbVKh0sZpzvbTS/nsPRq6S25XHWIVNpFYy9cDG4FpOKjixzJsfc+ejR4r+OYf0GAvVPyNkD5wva3XDkfzOTbzy7Q9qWUJLKmm13806Xh52DHbAQitjcXoBea6/7gqv9Klo8DBwzykGAFTJqCFERvyHupqWwN1PgSzC30vX2bnBYlZGg8DNOj/eyBI2Yoe+izbBSb3/J69zVYrs0fBb5r7CuzVnZ0WlW92Rzc+nL22V/TIorMdjOnaBJv/fmR3nhnueE7uNF4dxqikrGyELvLRAl4Wjf1njve9fLXc7JfmvccDbmMtdckfDtqLB3JjGcGXOJNDB99b36lJX/gITAuEcXJw1S13Y3EwB4oysDWqO9y7enUy9GZRm4eRRXI6HZJ02mxvnW2YMOk2PBlaXnvKQrjkMR0Ov7q9XVUlUMD8nJJAtL+W0kS5+x6oML5gm4+W6s4Bg50V5JflD43kW8i9f66l1MRgsycqPyoFDLtoavMYF9coTgv+XLH2FZHvjFsuMaSLgBIZTgVHnc0nLUXAaVqQI0Gh3ztl0bywGODoyDm9RT7LGP8IxcljS4iT9nU2DZU8cQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(508600001)(52116002)(33716001)(6512007)(6666004)(1076003)(44832011)(9686003)(316002)(66556008)(4326008)(6506007)(66946007)(86362001)(26005)(33656002)(186003)(66476007)(8676002)(6486002)(5660300002)(6916009)(2906002)(8936002)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vcbyyxjtZSqY17KFnrfEdc5rJkCLb3UuiDpHp+Tc82A75Li7BAsScSlVxm3Q?=
 =?us-ascii?Q?rs7/BzwVatlofQlWS1pZxUQZwWNNPwWROf4HZrLlyzfacjNiGc+XsxNxfxKO?=
 =?us-ascii?Q?Pm0bVWMdyjvjS4XcbQGyXnRA9EBCyTz3dyNOwdCBCeRq+6QdBMX65e8VlP57?=
 =?us-ascii?Q?F8fTqdou6vRe5GHo1TdArAxEjW/nA0PbXLdEy/upMTx6ZbUOZumfzP8T0Bfa?=
 =?us-ascii?Q?0T9GCJLGQe+py/fezZ8CrUrFTNaigOG/jOwfMRrSmKt+03KIPbUAcKYmq0Dc?=
 =?us-ascii?Q?o4xioncx1TNQucDQy+x6+S7t93HRRlAV+cxPyFHB2ObJtZFY49h5Fu/kveQZ?=
 =?us-ascii?Q?drHQK3Fmhu4huYM5SFM2A2TiCSqk+6SfU4JOJbTZbBySJ7q15J4Zx/AM1Ow8?=
 =?us-ascii?Q?bvpNEjW8h1odNcRRfxhUi7rH/duOSqVF0dO5zMjsD8WSfAcZ7gk9Ck43zdoB?=
 =?us-ascii?Q?dmlhy0UkgmQ4WzXfWx/jOJ9OjpWL/CQh9ecso8TC+rTCzzy9233aUs2R3iXX?=
 =?us-ascii?Q?bjmsJD8ZkwFhV2tAFlwV+MqPoVzc4E+OSVD4ClptSpezf6IMcPyNyNNh//Q+?=
 =?us-ascii?Q?543XK+Dx1MZ+YCIp4a9EQNFNfmgOjBwk8Pmfs5HqCSOTPq3wr4OUcbdhbHkr?=
 =?us-ascii?Q?EVpb0lL//NlK1XHKFtLBDJLBAr570lo1NmU/CkLRerr9JuBM5PFZ4Xi7hv7o?=
 =?us-ascii?Q?f6nEILK9t2KROKbe8NbTCLcfynBUdb3Z4qy6RW69wIa+4L7ahunFOBTIENgZ?=
 =?us-ascii?Q?ZeNQ9pwYUS93taYgmwTXESx1KhYC85Q0N4/fW8kDL+S7wIiYYrRyatMgZTGY?=
 =?us-ascii?Q?j5b+BrMbtpfgxLC+BEeulY1alhl4obflIglw7V3I65XvnRZEDDFCYGCfQY+O?=
 =?us-ascii?Q?fanikSxqyu8VyT1hyX41bUs+vfyciD+ya8gjn8TwEx52RURPvqlfJoUAOl6J?=
 =?us-ascii?Q?tZ1Rsp4hX/0I5cyg9JVRrbLRO3clVj0aa+7OaoRllXjiQkQqxywiOhdNa/m8?=
 =?us-ascii?Q?qydMKAMrH3T6V907eMqBQz70lOQxHcRQAN/2sLqW3qKlJaL/f92vQeDmRq1y?=
 =?us-ascii?Q?962pwGSN1EsTPknztYpTmRqCiWHNK+UFJwEfLZC+siqJ1Pk01AcNh5z8QcgN?=
 =?us-ascii?Q?SgXVmSHzzMdofktuXEZUm+X0MdmjFDb7B8vCnxxx1m1IXI7zf+UIFTSgI2o9?=
 =?us-ascii?Q?Whbb8ldSQvSGSsLTR+VToibZzPM+aW2X7jc+Bhqxm9rB+1EBP6T+exnYEExx?=
 =?us-ascii?Q?gdP5It+P8CL8/VOgHGwv43m6jHlc+CUKR0UgIui8lLUp1zW5GzJC82gl4WiY?=
 =?us-ascii?Q?aLw51cshTEbUDxfamYtv7JER1J3TfNZdE3o/KDmYtMQEngKPeCB8x5GT6eQ9?=
 =?us-ascii?Q?pUejvl2cAzigQ4FnrnQpj3VrMODl9aN37Vxx4MFVkrsCmrI8C18n1zrQhccG?=
 =?us-ascii?Q?PPjJ0GcfjoqJWpaXy6b8A6jthpGrx6Qv/wIx6hVIuPMt1804hlnDB12/U18L?=
 =?us-ascii?Q?M+PZl+z00e8zxnfupy98b6q6UeSwqp3GTWb8O1wzrQAG9CMPKbaX/QNr4FIZ?=
 =?us-ascii?Q?skotp3gg8/fEVNzS7wKUKcinigVuJPtEJfmceJsTsmJfA7mF20A7Uho5IiJz?=
 =?us-ascii?Q?xHTVqrLIAoth2vjRLmtESj+yFbYOfbIGB9UiESHRfkPxzZq2LxA6C2ZJQ7dq?=
 =?us-ascii?Q?lzyq843V3syUBSpVzqIceIA2mzw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b58c80f-740f-4b4c-ab2f-08d9d1bb417c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 08:54:03.9289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gwn288VmWTtkMt8ThseSrhP7mVir1RJi3fNzrBDMWswV+553e4ic81Oj01u67gICVg2vpUSwYuwhYvcL6lhiMD8qS5YVG5B5VtkGO/hCtZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2254
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201070063
X-Proofpoint-ORIG-GUID: 1QfxEGi4VCkpT0YVaggBa7Bx-H0VsdxY
X-Proofpoint-GUID: 1QfxEGi4VCkpT0YVaggBa7Bx-H0VsdxY
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 10:33:25AM +1300, Paulo Miguel Almeida wrote:
> As a convention for the pi433 driver, all routines that deals with the
> rf69 chip are defined in the rf69.c file.

That's some EnterpriseQuality[tm] style guidelines.  It's an over fussy
rule that just makes the code harder to read for no reason.

> While at it, the Version Register hardcoded value was replaced with a
> pre-existing constant in the driver.

This is good, though.

> diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
> index 68c09fa016ed..1372361d56e1 100644
> --- a/drivers/staging/pi433/pi433_if.c
> +++ b/drivers/staging/pi433/pi433_if.c
> @@ -1116,9 +1116,7 @@ static int pi433_probe(struct spi_device *spi)
>  		spi->mode, spi->bits_per_word, spi->max_speed_hz);
>  
>  	/* Ping the chip by reading the version register */

This comment doesn't make sense now.

> -	retval = spi_w8r8(spi, 0x10);
> -	if (retval < 0)
> -		return retval;
> +	retval = rf69_get_version(spi);

Just say:

	retval = rf69_read_reg(spi, REG_VERSION);
	if (retval < 0)
		return retval;

Deleting the error handling was a bad style choice.  Also preserve the
error code.

regards,
dan carpenter

