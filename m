Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21804BBAD9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 15:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbiBROol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 09:44:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiBROoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:44:37 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0AD36334
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 06:44:20 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IDbWLe009220;
        Fri, 18 Feb 2022 14:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=EVkiqbqnIwd5los3wNq/qnecFGtDTGNjEEPqBy//kvE=;
 b=Cflx40wnpQjFdltHSGs/OnTEi5IyQBfV5WesfDvDmglKavbcrq8+L/B4+szAtBM4Axac
 gD6b9fGp4iT49HRiVCgXH9BI8ddEbZVibzbQCToRJOvorqrY0UmcqFmNSBKCigZmsQZ4
 bCzQQc5HNUXvqW4b353lXjXkkRJCgGNXArdvYTNIqMYmNzuBOJ1d4D2nqU5q5w8fFT4v
 +61oqoBFW+i8mHeHlfWviYNHzSAmMzYu1CQJp7LQFM40KRaNaVpHAYVFFOC1AcwusIxG
 VKvL0P3yFDwFfo+N0ZrTrng+7FFxoxl+mY7Zn/Nx487dIXaz3Lwmtbx83XWOYQH7fIXA zw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8n3e1ryd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 14:44:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21IEaEg8143377;
        Fri, 18 Feb 2022 14:44:03 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by aserp3020.oracle.com with ESMTP id 3e8nvvdsvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 14:44:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YP2Xx8eQECaezONteNlaMmBy4QhHVZjsZjleZ7AkjeUI3a7UcrKF9lqi1LLaIfpjYrOpYzYHbU5Te+cIdsXAk47PvJe3XVa56Zwymgd/U9lHEEyFqBEEHXuEJ2ITE4m7phI7asWiUy9cjD9sg6e5qdKapytlLI8RGjAgZkkhlmXSiglk42u/+x+UDjCIBEUwuVuCHLv6Oeh7qrO77nmo/u1wBLJAn1hqST/H6+SZ1YOkSMlfAyosnSXGAgD1tvqIB9I57z+EQpk4hdjuuQtkEwotkI4vynga8lERrzer07jmb6E25yzlZOnKTZSE9uM8hiimjIjv1RkHnhmnLKtG6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVkiqbqnIwd5los3wNq/qnecFGtDTGNjEEPqBy//kvE=;
 b=gvwfhtx6fFfvfROVvjxNy4RzxN89s1ZTACgHMrJ2QCMvs4f1ngtmeHlD67mmayH4jyRgrAfiiLqhfcZGihQF4T8XguE1vpHYwVQc+/wuFL0mUGxBEnTGfr1cghmWkwi0uD0iXKfjI+TFhj+mlttSdI+igqNjOdoEQONFhtcBF5Hxow0X13XR2ET8GAnYezTN4A5NG0I2Ma4mDD+hRBBCkMyCWZoDrTvSsiRUJEMb3/ZYECJqvQsQ6zDHP9D8QX62PgaPqH1Bi240swPLYFXyiLjAeGJgFm3G5WrIyLJ3PYMmhM01huzttqAUkUyk3GCCWht1ecL45ivij3TAlpEQgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVkiqbqnIwd5los3wNq/qnecFGtDTGNjEEPqBy//kvE=;
 b=ByFIG+HMmDJnxmot+pKtIp7qZtCm1muLIH6GqKlxSvZMza9B+so+gf4e1hRlRNIYFBSdjFXVo9zwdQIvxyHA1lHNlooiAR0fHO50bsWkIpFzCTpgfDAhYd0b8okRO3zYhmDKaW4Oz4Q0T1Hdg8v0TL4b9kdnjKD/lF7aXW8u2a0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB4760.namprd10.prod.outlook.com
 (2603:10b6:510:3b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 14:44:01 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%3]) with mapi id 15.20.4975.019; Fri, 18 Feb 2022
 14:44:01 +0000
Date:   Fri, 18 Feb 2022 17:43:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     xkernel.wang@foxmail.com
Cc:     jerome.pouiller@silabs.com, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: wfx: fix an error handling in
 wfx_init_common()
Message-ID: <20220218144345.GF2467@kadam>
References: <tencent_24A24A3EFF61206ECCC4B94B1C5C1454E108@qq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_24A24A3EFF61206ECCC4B94B1C5C1454E108@qq.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0024.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::36)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93edcc4a-328f-4ecf-e873-08d9f2ed1a45
X-MS-TrafficTypeDiagnostic: PH0PR10MB4760:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB47606C8929CF7D8E7138F6738E379@PH0PR10MB4760.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kXavZ4WvS1bMBcolgLWBRi90aS7g8sDlysGKi4CBUfUVMa26+VyzeXJvTs7qlq2/8sroYzKpp1fCiU/XW8wgsExERLk+MWflvBC1JpwjH1bHKXfvDN3KYq1ckJ9ANMLd0FRB4VZiNbvBputZRHf0x1J70+aHrFkDOCZAawkUx/MZ/Kbhg73K6cPMe9vI8vsjCQd4B3Gg1D8ARWKjRDPXYevihGLoJvqChDAu8Gg41YDkh3+ltqFdG2TQ2jel1YaTIOC4fButWSDOTD717glybK7XCdgVUfRUpLSf0RkwdkG5Mx9pySANfy0HNu1uq++vLGDrsn5sNXwpVRe3vOa7o+ez3yy9C1PjLvl+2rIJ++4SQY3YnhGjz1ZQZM2UGtyg2/2udkgpWS24+AesrGa/6UY1Y2d3G+ZbNraLBWEiyTqTvgHK5V54AnSr56lEjC50br337gKQKE7IvuEzXBwQSvGQxTEHPNo4oMvzi5h2UKcy77fX9OKorcGcOc0f8ggiD64C1M5wY/I0Sq48OVlFE0vFMwifftgtIky6lG1ShHJ61osXyswRLRLWEV0VetyRBXvG7mrtnNJPYezE+B7YOKEkOFM4UyT4n0J8y5n3zIeXX4BxPnpAFDJYCHf0cpKVh0Er6bcApyEu68BfhIghjM3nwPYVvVNiUPQuEppPPSpLr0tZJMhp2nvAPhF6JmelIj+sAtVGjT+TAFmN89QCGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(508600001)(9686003)(6666004)(6512007)(8936002)(6486002)(6506007)(52116002)(4270600006)(44832011)(38350700002)(33716001)(558084003)(38100700002)(6916009)(316002)(26005)(33656002)(186003)(1076003)(86362001)(2906002)(66946007)(4326008)(66476007)(66556008)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?euf+P5xe/6uPArVcnQBQ/pWavR/DnPsIK8wAVfQn4YlVhfYrqyNIQXrJ16bo?=
 =?us-ascii?Q?LsLUGzbjGHr9qNM1ZB0KxMgVAMvT7+aAutPn5S3n/DtzLBcl3QdP5G7PbMKw?=
 =?us-ascii?Q?IusNaDR4fbGfrEkX1KFkjryklUgpAJFaae2RXTIIRqnP+/MNiwbwHFMiqSmW?=
 =?us-ascii?Q?oAzxlUlqgG7NuYFeF4JnlmCGs01wYGJ3O6E6pVHBI7I6zT21FTQod6D3T3eX?=
 =?us-ascii?Q?LUJDvSizHzn7BgbAYQXF7JNxhUzUVGjP2kl+RDMpcLhKyafZ+8/JeT1POmY6?=
 =?us-ascii?Q?ok4QIm3m3hlYdlvFy0BPgSv6XjHmpMtHZowJjIqi7eYGTNZixLrgSbYDKuPx?=
 =?us-ascii?Q?BHlypKUbJPgeFtk2UW0+wcRyS6rZzdn73o9xGOhuEfbyZAgS/zQU2nkeAmU6?=
 =?us-ascii?Q?Fk8YpZ5Afr15ymO5WUKQCoDrfpK/D13cUZ/NL+MBha1uYNruxojPch/XaBis?=
 =?us-ascii?Q?4jQl5xlwJkoe9ndc/OOw8BggRpnA6Ez1kvJsRKb2UgacjLYfCNZuqz+YuLz7?=
 =?us-ascii?Q?tXNcn3bY/vA+jJ8eJLNiDwmCJc8MiYoIOWXkG2z4aVcyPYcNs7uTOh5fAr4e?=
 =?us-ascii?Q?YKEN8RCr2+xhcf9a2n3CLVUY3xwufUqisnNalgif68iynC/b2xsQ1hpKYw5h?=
 =?us-ascii?Q?Ve0jfN0nOZFN17FhP/jmx9wC5An5luQDpKepe2fyPsaLWPPP8H4glqrd7G5T?=
 =?us-ascii?Q?23HRXPz8lTA6C2+WfUrf5YhR7UfqvKw9PR+HeK4hcKZZ80V/HVFDcoLGI+Qr?=
 =?us-ascii?Q?DS0k/HIe8TeAdw2JI19vKLSV9n23iUjoZmeJhWDffs4UzJyG9B3j5TPdN9zg?=
 =?us-ascii?Q?hJ/8cDeGLiyZzbnx46F8DtJTQZkI/dAdWv8KAkI8xDNCwUZqdl9iHCJlfkys?=
 =?us-ascii?Q?xEMNSLm7Nt6W0k6XWpRxZ8cuAgttl7erkY4qnsOwXQ6m+DBwrXTm84OIrug1?=
 =?us-ascii?Q?nfmAD30TNfYjLNQEmGsWBYqm1yOGHI90TNyHuVukWGJ3UhZ0JVYmadAsJfP5?=
 =?us-ascii?Q?zLQIe+sup+7Vr90WcOkVdNOwXXU5mKAk86PqVbpgxOitqsnFCpa45H2JH/b+?=
 =?us-ascii?Q?H+ZeDZzArOE/48zOHkXYedLc+Q6XWvAK3SBPManlkAQ+S2gLBqtCiLeviEaB?=
 =?us-ascii?Q?X+dbVRYkAhYI5rwLAcTt9aGbghrpfNBbDheKp0hCjWeXsYqiNFsIyHHTp161?=
 =?us-ascii?Q?V31NnUINYFePTJyPSlLwEZPXOSy6rTOdKq0z3sIHBfc3ZL/fxaJ0F73R27Mc?=
 =?us-ascii?Q?adp4OLzVI2zc086u0KYfuw3lzFFwREkWZk75V12zPXs/XfR4FLKHtYxDCFsM?=
 =?us-ascii?Q?UCod26mUit1ugpyFAR6KVviNSf6zilnb5wFyS6ovCYiqr49ykN6h0RHiTesl?=
 =?us-ascii?Q?fAAnK3PfkyNSAtmF9/ja7MlhwLiz++Ra44/JsXNHcCG5d8kVh1+5Xfrc1grM?=
 =?us-ascii?Q?BUILjPEYaf+jqCDHA5T63ujrtUUsUsa2UlIxRHCJ8kJV9qac0704gH686NFt?=
 =?us-ascii?Q?DkmT4RO2TzHNCSndbChGNRgKrFDnNGrk6lb51wXLS6QBq5zyqdBD93FAmQrf?=
 =?us-ascii?Q?fuTPh3AU8mXd9iQMzVGQFXeXqWkmuBRxVePbIoQcC1T7QPF6p4hg1f1BaNyw?=
 =?us-ascii?Q?ySM7DBQ2hX1P/6lSpU0mFnduodbzENlWXethQOPODu8lhVTaQYoF9AtNj/QV?=
 =?us-ascii?Q?RAa/Rg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93edcc4a-328f-4ecf-e873-08d9f2ed1a45
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 14:44:01.4408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6lN/FpXFullx2h6CbmVXXRf7zVKHBNA1YIXfCKAoVdgmWy36oiY3uvlxHtFWvH1ihL0H64keiFAQ+tDcK10w4TZFLhtwBh2vcgpv6k8Clx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4760
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10261 signatures=677564
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202180094
X-Proofpoint-ORIG-GUID: h6hliqbpOj1OjoBzr9uXdA8258fgLAIy
X-Proofpoint-GUID: h6hliqbpOj1OjoBzr9uXdA8258fgLAIy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good, thanks.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

