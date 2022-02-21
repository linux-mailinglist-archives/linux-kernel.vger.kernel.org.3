Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EB24BE5C9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357831AbiBUMZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:25:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349677AbiBUMZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:25:30 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DE613E18
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 04:25:07 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21L9b9oq002311;
        Mon, 21 Feb 2022 12:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Q/+8j+ESTbkRf10pCApC5/vISemmh2DszQxPtTPEqlM=;
 b=PHymrHjqeGHsoCGgKjrrdVSWiKijekPksj0PL50dR8q35AivtY7Z0jS/VSr3L8zQVDfW
 edxRPpk7KyokCOtqEZCT/kcFr6Zoes8oaJ+Rt/rjz7EXTTt2Kz8wVSoikjU2/JSEdeRo
 veoHdWKzYDfbS9/MwQvkWTnJUES52y1FY23hmMeAJkBoQlobYa8e81g+UvKFnTZoJYAa
 MzKCM67TAylOTj14/6NlDXUi8ehQBq9167H9lOXOxL1dL6mR0aXuedFv7uEf/Douv6MP
 BprHnhLc3vbJMcQO3n9K1kc0/ZaUj3OUfxs+8o/dsmIFHeS3oeat9nJOist0+y5k4lND mg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ear5t4010-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Feb 2022 12:25:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21LCGmDO031959;
        Mon, 21 Feb 2022 12:25:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by aserp3030.oracle.com with ESMTP id 3eapken5jy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Feb 2022 12:25:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehljVvYLETe87zwD/KCDabBs4W9122rzWfA4HDJ6Ig7o+Z+Ohr2M/FKoVx0rlOWupTajJpDpNmgepWKXCmmv7w8dY0JsL6NeBF5kzbVdRTJWpQvcG8XKYJ+1vs9E+gf8OZnvh9kZCeOOozGR1mEEs0cj6dh8ZI0pnPg2PDD2Vu4NadcWp+4TRoRV1q7ePsceTZSeK9eV37JX6eRbo0gReLELYmLvBSl5OwhIpCR6RPkYZOwvTvJ1cf4btOX1s6p+N3ZbdyJXuhdNm55PmMASKsrzPc1Ki4gh0onaNPBUVHF4zCD7XYpUNKjiYHbBwzF1ckcHPOQZ7lEqSQXbYl/gcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/+8j+ESTbkRf10pCApC5/vISemmh2DszQxPtTPEqlM=;
 b=TINLz66NFQ3LqUTCuVUnnvXgfDiww7yb5jlfW2vculIG4lmC4Pt6l6k2SlvYdpPi5f8KMHnXcuA4geJgD2YCGRxOaVpSIperKwmpFXWP+N/XKBK8Dy2nhz/Ztp7Kr3ofACRAmSsWusGAw/O+9sKQ1mxDQ4Cvqqs2I1rucdFGPVu6DujPVMZcAw22vk7pPEj/auteOrtB1dKobPMfOtiKULGghwS6CLRBqL8rd4x3ifdmiEiEMbad14PiR1KsRqIRYmmFUhTa8pFKChreYtg6vagjsFNFQVIwGmDvWLzT+OrjJdszmJsR/3i6kjxOKMwU7qOa3/fua82f8uTBZ6zjkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/+8j+ESTbkRf10pCApC5/vISemmh2DszQxPtTPEqlM=;
 b=B6HRPUbl7aE3rXxWmpjcTqMoIbWL2NkZjYcGKZQ28XcKhnqAZx+CNiPwaENgEmG39Yfh57V6RjIqGpodcZKVuvQ2Wqt54nfD20O8OrJ0ofKRi40+csUckO5MuY1XOeZuK5hRiGziMqPGeQDYxV7DPv0wMBZXGCA9Y7UDGhQmVRM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB4727.namprd10.prod.outlook.com
 (2603:10b6:510:3f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Mon, 21 Feb
 2022 12:24:58 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 12:24:58 +0000
Date:   Mon, 21 Feb 2022 15:24:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marcelo Aloisio da Silva <marcelo.as@aol.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: remove unnecessary braces in if
 statements
Message-ID: <20220221122440.GF3965@kadam>
References: <20220220174150.GA11496.ref@snoopy>
 <20220220174150.GA11496@snoopy>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220220174150.GA11496@snoopy>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0006.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::18)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c91aa04-12df-462b-9444-08d9f5352c72
X-MS-TrafficTypeDiagnostic: PH0PR10MB4727:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB4727DE79D74BE805A45BB20F8E3A9@PH0PR10MB4727.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iwACxdwH5N6OJ3r1xFGpXfyPjZU6Nd3hmmF0VHN+S4+3Jp1jaeySzoaaSvZfV1L9YRsQAg/tLQ8JzmXr4JvMWK90fUwa5aLRbGb0p2XYKXiUWA+wPsK20niLj0zXYM1dEuP0/1o8k5uZlt5fL0JV2tHfvrYZcRL4ayjfvejGKYdaxrLHvtxCAGjin3AuZJLZkx5VN6xhk+EREFeYwognRKyjanYxtK9dgHSzu+XlIY6a+FRs61jzcyBXllBLCljB06LGWbAtbC9j2E1BBcxy1m7qLOjRQuzkSnU0Fbk6zyCpG/hT7x7dHlKRvTDKvgHR0a7c7ap1FPM6QiWWynajnCvyHjdPuTonY+g9SuQnXn3G3cRQ+ui+sqvQzUQy7nQaIi3+AcQ3RFkT8bxEZv7LtfVAdur9Kw8IGpvqy1lRjjOUhm+q3BAnOPwq0BDUnsOMnbN+A2YU1H6SZWaZwNfJj4oFXRUCZmX05od0n2rwMNytHhRmme4XdtVUB8nfeuXhblOSckYyp7Be3l4QE0OtcJVKDyhhV6uMITRTUu6Sy7/NNaZGL8D9JbU28RoXGTs+RJAfhd2lLb1ssbVOuiaYukU94n8k9I+VSi8HY95AYOIEwj8kqzl0Ma2wmJvJh1M1y77R5Qk0OtVzA2cJJIrAFIPcnLOcw8Sj3zJpABw9PfUY9GusD7XUjxXBJeya8+0uW6tQLd82hAnbmoYlhG8i7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6506007)(6666004)(508600001)(33716001)(66946007)(8676002)(6486002)(33656002)(66476007)(316002)(4326008)(6916009)(54906003)(66556008)(86362001)(38100700002)(38350700002)(6512007)(9686003)(1076003)(52116002)(26005)(186003)(5660300002)(2906002)(44832011)(8936002)(83380400001)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fEIZcKmiWnbOVqGXZqfPakpnypEO2MgaYyOStTHBX6aB8eypCbgkDziVIPJJ?=
 =?us-ascii?Q?qjo9df698N9ED64UQh4vGaHKJ18dU8yzkYSKQv3ZNjDIfOcxKH8LG8NpkE3a?=
 =?us-ascii?Q?DVJhFj3XJ5H4Q7yEr8mgRZh5jby2Nl45G2Lx3DpoZA72ZROLQjvSu7TA0X+y?=
 =?us-ascii?Q?Irw72OZQ/68QZ6huliYt4e2B+XJlPcmH9JsdFZS9P7e3HsGKXx9+Q60jg40f?=
 =?us-ascii?Q?CjCkA1PxgRlFG1y8HmX4Hq0POFQ/2X6yQBq/JJETwZ4TDobRErlhbhGN0QSA?=
 =?us-ascii?Q?0i7pdKqsyVKVarCRd9xTou7i6LCSY1xMcpRkQNLIeIzITrsNCsydFnDqnQeS?=
 =?us-ascii?Q?hCV2HveWsaJvhL6Q1uoKyzCTxV+SImqkCV7/bgtoD3+lr7ikWoz1yJS2qODP?=
 =?us-ascii?Q?t/COzPt1aDZVsSapj/D7Wa8Vq7ceuSkniAotQuAS4tqWPpONIAnmCOeQLjSW?=
 =?us-ascii?Q?QB/kU8F9D8vW4oRHNwN01G7QNOin+Q1/cRBZI1vYLjs7WJIvSike9GOawbb1?=
 =?us-ascii?Q?6MoOuIjIG7FSaVsNcW7ApE1dRheyuf73m5hXb7P/dt4HeN+Und7mgUGeTYkD?=
 =?us-ascii?Q?OIbO3wPFtRKu041DQ/ugI8V5V1eNrNoWU0xNPwuIHH/JnE+aofzYTZiLPhVr?=
 =?us-ascii?Q?evKXYygD4GOmXbUFFdAb0q+p/Py7KwEetwD39jMLFhh5u4osdenlRNtfZN5X?=
 =?us-ascii?Q?i2rWbBZZwWrDrAL90sDAKwMjv4kQcVAuKWHKNT4AJgNvVs03fyFDCUGB8bGk?=
 =?us-ascii?Q?1yvK6UkHDMdd9mH4g/mM8U6f7c7DrT2mAje8APN+YWEa14fOQVTpVp8b7mHf?=
 =?us-ascii?Q?U/5gA2t4JPe49U0uq/aZzQDKMY5L6B7T5N9YOmlJc/Y2QaPE6VoC2B5klxpA?=
 =?us-ascii?Q?Gb3yh1RC18kib6zBfLlt+kPBNLXL4U/sMwc+LqyTXb5X3L0Fao+SxDdMJUVq?=
 =?us-ascii?Q?7qk3QUP4qKC6Crde7fAaRxsz/3aiydLixqaB/Fw9mkvSRUQ+Vf6ASin2QzsX?=
 =?us-ascii?Q?V8aTL8hraT6Qmg0VY4KdvIkvzms9r90unLiQoYGNlzyuxsSaUXZXlRbGHkyC?=
 =?us-ascii?Q?uPwQ53ISfMM0/5oa+7uq7A3SScpmHVcH/PUl3aV/PLI1O0vzzagpU0QLH0gj?=
 =?us-ascii?Q?F8DLj8KsI1qD9u6nhLhPm93b2sNJfapP0e7d1wTeW5Mo6eGDmRLiAOBm2oIR?=
 =?us-ascii?Q?xutMVRkMnxMVbbUqZE45ZJhSUdoJJ9Unb/sN31zvlQuteFTkzl7jGBAB+d+s?=
 =?us-ascii?Q?FAGD5PNfAoCwwYGmimljlKswOUWvaG1C/NXhBmpptIZ7i7GocbFwKJKp9wds?=
 =?us-ascii?Q?IvX38RkVIzfRHdDvm2SQ9oZR6JjqViHrfVUcoq4ePxKoPuoVMMAi8i/Ebo46?=
 =?us-ascii?Q?FKkZ1T1ocrvAuW/lg3/i7qTn3Xy0/ma765Rw0GCYc7Sc38yoIcmdaHC3Qbzy?=
 =?us-ascii?Q?AScKuPvQ9uvEggqLBiGrTVTVqG7CprejNVjvzeS2lrFHd4yNisjJLfl/Hled?=
 =?us-ascii?Q?ihZAtyTsoDPLiMRGcm7QQ0rF9WfVHr9x7ruM68Uj+3vqy8+giZaPWCyQDXLV?=
 =?us-ascii?Q?6Xb6buYtVoZcXcs15fn+qUkYP9q4f7ME3CBSoZFZy0jhu0rcDDuF+fTpHmBb?=
 =?us-ascii?Q?isxXY4zkCjGA8fUAKIMXEy3QFssInJh5puDAcFNxz5eCt16GmxMwsfFBHc72?=
 =?us-ascii?Q?Z0DTuw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c91aa04-12df-462b-9444-08d9f5352c72
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 12:24:57.9445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q9WMwi8Oii6cxD/B6nlkLqmrT2wXPg1MhtNfemMWUMNUTwaiDZwPHlN7jM9+2E3PTQtu5rrHC4GXFQnGwfvq5o9wvu5WS5o7MXVLfU0JH5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4727
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10264 signatures=677614
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202210074
X-Proofpoint-GUID: xTGh5-BaTI3eKkn83OLudOjcEenwnB3w
X-Proofpoint-ORIG-GUID: xTGh5-BaTI3eKkn83OLudOjcEenwnB3w
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2022 at 02:41:50PM -0300, Marcelo Aloisio da Silva wrote:
> Braces are not necessary for single statement blocks.
> 
> Signed-off-by: Marcelo Aloisio da Silva <marcelo.as@aol.com>
> ---
> Changes in v2:
>  - Only remove braces for the if statements below.

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

