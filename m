Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7984878A5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239085AbiAGODX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:03:23 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:48738 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238405AbiAGODW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:03:22 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 207AEhBF031900;
        Fri, 7 Jan 2022 14:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=5Li+eGjMEgA/AGjVOjM5a0TBVCyfTxKDmIQbJlJqySI=;
 b=FHov0KmAdVrXFsYf/WIg6CAHw6LcXfdCfVlM5L1A97bUNrWJ0uBZmeHEKO/IvDyawOt8
 85KzPEMrRzFv1V+nEVtw07tJOhHzjdeMS725XWxIZMCA74zluWpzqpU2zdyv9rJQAPQh
 uo6tVEVGwZFzXhZ2fQYGeVL0R0c2mTK7UOWozUt0WKN2yFGtLI+iuSf13+epkUroNmlI
 HvijycVEvAur/MrGkbkmdsqM9AyhWdpjq4miZ2GdXH2uyNfriJkfxqtG9a6o1rHwdtnf
 bgVKr8N5tyM/xmuHJ4ZEkydkgTbi2wToR/qrT3GyabJ3hNy8W3jjt07Tr2cVMmcueMwz ew== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3de4v922cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 14:03:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 207DuFG9062133;
        Fri, 7 Jan 2022 14:03:08 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by aserp3030.oracle.com with ESMTP id 3de4w33nsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 14:03:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZaQ/6n+u0ybBfd06SwYSBzw/QXJ7VBUuto9epLO1ObPBQyDlwYSdV/oAqfwPF8+Uc/3mqXeAIjm6DI8BppN8uViyqE1MW4ylGDZHv5rKRgtrFxCKoSmloYWAKgz8oL8N6qQYQl7yPTU/yEfXs6Ts0ARLLtyF/PcWgLknrwTEncBuIr+G84saq+vWPnj9ouHJYonqAS4lD+z3xOFXUxHxiMqhRF+v6dPMuDQEi7N8KvtryEmvfmZqoKR3R91K8pZ/Fctfy7+aSKUruvodWd0nXXdAT2x9nkLlV3qD7omaSFliZRU8UVc4Mrfvl6l9NK1bNTRcbWcLFbuN1k9iYqYnfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Li+eGjMEgA/AGjVOjM5a0TBVCyfTxKDmIQbJlJqySI=;
 b=TQiQHts/MwfTpHmxHInFgaqQS4woh/aDffuISv9vFEg7MdvpSPJu0b0WXzyA0/MPHJ/w/BYHDAKKRZaq+C4z04sfpu3ja+BVK2DItK1Z/kWyMtY7kQ65+/X52hR+xYeQP3v3X60CyPV4RX8Ev1tS8jB2aqb7JaJphsPT8mes206JP60qbDmO3pQtYT/F/fX2YWl/W5xJuIfWwzrNtpM672NITx5X1Yex1sQ4IKoa9RFuz6Lo9bV/kMszKswlcOtXR2MxE5dg2zDLtPmuxo2z6ntFfgssq3HW94ZTPoTBAdJHSVyKapV94SKm7qNwLeyhbwt/J5X4UTFGIly7XOaDMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Li+eGjMEgA/AGjVOjM5a0TBVCyfTxKDmIQbJlJqySI=;
 b=XZTndXhBL2UqhVjbETbAPS0/m+i6sIp1RsWKZN6wWaOnvqB7QnEHVxcfqnx9HvdF9JbFyCpFDQ3xcBxnE3pISzxSDI47CUqfSS2PNvtRxV4MWyhSJnJvYavbRXCEexnNv0YRQ5r3zQFbT2NHIOBSez8R/Q+WH2JJkBVp7KKziYM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4439.namprd10.prod.outlook.com (2603:10b6:510:41::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 14:03:06 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166%7]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 14:03:06 +0000
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        Khalid Aziz <khalid@gonehiking.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>, Nix <nix@esperi.org.uk>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] scsi: Set allocation length to 255 for ATA
 Information VPD page
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1sftzwstk.fsf@ca-mkp.ca.oracle.com>
References: <alpine.DEB.2.21.2201020010540.56863@angie.orcam.me.uk>
        <alpine.DEB.2.21.2201020030130.56863@angie.orcam.me.uk>
        <d9eaa1f8-7abb-645b-d624-5069205c6983@interlog.com>
        <alpine.DEB.2.21.2201032017290.56863@angie.orcam.me.uk>
        <yq1tuek347m.fsf@ca-mkp.ca.oracle.com>
        <alpine.DEB.2.21.2201032324230.56863@angie.orcam.me.uk>
        <yq1tuej1j22.fsf@ca-mkp.ca.oracle.com>
        <yq1lezty169.fsf@ca-mkp.ca.oracle.com>
        <alpine.DEB.2.21.2201070039040.56863@angie.orcam.me.uk>
Date:   Fri, 07 Jan 2022 09:03:03 -0500
In-Reply-To: <alpine.DEB.2.21.2201070039040.56863@angie.orcam.me.uk> (Maciej
        W. Rozycki's message of "Fri, 7 Jan 2022 10:36:46 +0000 (GMT)")
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0064.namprd05.prod.outlook.com
 (2603:10b6:803:41::41) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84717c5d-37d5-47a4-8420-08d9d1e66da7
X-MS-TrafficTypeDiagnostic: PH0PR10MB4439:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB4439EA42FD76FF2DD1AEF2C68E4D9@PH0PR10MB4439.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yEeFFybxau9Gdfl9hX3Ba7fzwNRNTe69p2AajI4qsyJxGsEGRJJCyN9OUZtLGp8UljvlbUv7zCbhSD23l+C2VFc4mO64RrMKoHgumaxkRCPnIGtlW40eTrStLf040TjNKQU/4999t119AAp19kqQLP9nqpYvQNmZA1SJJVFAY5DTSTqmB5vlfQLzuXWhm1NNHit72355ADOuFNLi9xP96ENnrmkthPsLhezzKVJhrEC1at2pvJQiqQA3Tulubaf+FVsnfMTln48ylsMXWmWpqsIZa4lLZxhLrYpZrhfPIHd9nPkMpJUg6+b3NEXfFMyRD6mklBa1Th4YzJwIASAAD9gPfClk07AC/rUilGqPrb5/hmzxJzJomN/7OC6qPvybygW6gemDHQTroQBdO7eXRUNuxQr51m+uBmrhH7msIwdgTnRe/C7l8t7RbVVwRiRJKlXeComCvf+tpZbazfXaFZ102sHwMPtcYXK27QwueKOhsX2uvAVXOJ7FDASXdfCsKaJ56tKf44QP84hXaxv0CNk5KgSgqQvH1bF+tElpHz1BJlSQbYCN5Fbf+WhzSiS9hC3rpDBPq7SyM96C0La010ECH8HVlEfCy1af12nWyjadMBgjHuum89gTMxwM34Mr7m3FCCf2i04fYd7G8wDd7yoBUDS+dNiyQ9wk5AAAVsB5zL1wkxpkuWFBQeEh7t1iMuKzkCqoK/J6ozXIluwFUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(186003)(508600001)(36916002)(5660300002)(66476007)(66556008)(6506007)(52116002)(6666004)(4326008)(54906003)(38100700002)(38350700002)(316002)(6486002)(66946007)(4744005)(8936002)(6916009)(83380400001)(86362001)(8676002)(2906002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZU5xLwglp1K173zDhbzgn4+34ONm3qPBYmH/i/Cf36SCOAjVF2d7bMCLKBht?=
 =?us-ascii?Q?wkl8fDnNHVy+QYodW9s4wWkmuDzXiiwa8Y0/O0DwBu069jiyd7wWRYT4/Eeh?=
 =?us-ascii?Q?YP5wOXrAEoRBSvQlNF+2XyNQGkyEMqIMF/8ek5jjJSiecxuaNLQaKUW4Vtpf?=
 =?us-ascii?Q?HJy5+W4i76IA8dkH266iYMSj+U32ftAXNfPJKpb2TRtIUfe7QrHzazg6nXU3?=
 =?us-ascii?Q?VsGFLcdpGcSe/Qi8hvr3g3zMyiOJOdIUQF4wJb0LBm2fcSaO/yWe/6uAFqC7?=
 =?us-ascii?Q?5BnSLebNEuAtVvF4N4jY3FPOVKTLlFBJlPyWzXAtrGXO2/IvsTdcNOE32tdH?=
 =?us-ascii?Q?bJV07NQOmOn9BQobf4vzZDW1nP7vBMUdrsJ/u8iLeBgoRLLxKAf6ui9Juypt?=
 =?us-ascii?Q?hAsFk6pjzsbaV2W6ShJbb9GbBmrp0FstRKeLOo/oTFgAD7O4B98fpQ+BvF/Z?=
 =?us-ascii?Q?06H0CKsN5mjRtim3WtrG3aEZOA73XDywM2wbYp9XOPzHOT2UK8esJbbk671q?=
 =?us-ascii?Q?wZ+VIjS57sQKFLt0ukYkd9bM0tcRske6nsN6lwpyYqZA5ssKxCuFveIcg9ri?=
 =?us-ascii?Q?8bYSUmbnz2dBuRvr+QGBuEJ+pliSdxweXHxX6RDe/tvJaf3OQgPxSUZmTp6F?=
 =?us-ascii?Q?IAJvD1mLliShX6En8umTk4/1POvCOfuBBCJCtnp1VXeQN+raoINVROelRm5T?=
 =?us-ascii?Q?CyesE19dQUu/1phq3s/WyrJJvBUOWNkVUvMBrPY62xiPjyIZso83fHlDCX3H?=
 =?us-ascii?Q?LnWy9An4hrQKBmnV+JBLmKphCczZGJnsqcWvURsgQyIdRZ2iyyZDatebg/MA?=
 =?us-ascii?Q?xVrSjDbEeWs4SgZ5GvzaWEzZtnR4seNkbBCsRX9YBJzC3QJT0UuhEqisDKFN?=
 =?us-ascii?Q?KoNAEmGaXtiBn4Mx7t5JBN7PYU6OnL6PO928Ugnou6xx+WMuRf2sc/szjEa2?=
 =?us-ascii?Q?vfsuOpmUe4YLy16+iJe3rtWirq9CRplxLS59IYPntzjfj7bjwib7Csha8gfc?=
 =?us-ascii?Q?I9ljSYnyw1wOveJUlEmyXxxyUgMV5hyt5rzlkb/gTZ6xT8rXaAW9NxbG3B4j?=
 =?us-ascii?Q?3Lggkbb+zydOXbX0afJ1RvoW+fxxk/rx0AbZr+lWRiwFlEZ79W7PVd69NoRC?=
 =?us-ascii?Q?sQ57e8bRgX6wgLavk36WW9XSSHCEjhf5u7jf4gTQxV1QzlCZrrQMfS4peku5?=
 =?us-ascii?Q?YKmRDlcOSt4qaqokIFeBErHDIwMcNuoChd3PyKh72LeAQLpkoCE+s6YQ7hLy?=
 =?us-ascii?Q?0Gn8i4g5Z5HpRHgRNJP1pSfDt//t6OPddy30XJfhgcR19GJo0XSxMkpyyEv6?=
 =?us-ascii?Q?KOdpXX/kJD9kM8Fz/C1hiO65iB3P8RaEE8VX6+mHRlxeRNcash2FZlSTBPO/?=
 =?us-ascii?Q?zEzpgIdo5OCsTftPqZ3VqewkAupXlJOH7zIz2wReAD4CWBbZ43Agsqp2yyoC?=
 =?us-ascii?Q?+WJkr4JxUMp7btxLPgouxN7O7OFAeMUYocLvGyEctHRyXl6cDPCjgbAz122b?=
 =?us-ascii?Q?bddQrc7WeQ0kEkPyXoGG0bUjxy379gX4BU+HyJ0Y1IJ+5yU4fyf039MKrjqM?=
 =?us-ascii?Q?2nzFZBczun8W7uJIKwNCw8K9S0NREKIfCcgT3q4Aj+peIQQPYI7arwt+RnQr?=
 =?us-ascii?Q?zFiCdSzyLSU5QfIxEbMTJPpn3mcexHz1BoPww8Tq26L9N2tGajIAl5lJqyDU?=
 =?us-ascii?Q?o8s/WA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84717c5d-37d5-47a4-8420-08d9d1e66da7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 14:03:06.3576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RbmD4xsrE1VLSi1IPP75Y2LRUSN+EHgPenjaQkttDJOjv+Eq03Uli6VJ5FbtKrWwvmI+QtYFLjULBx+NG+K8mq44qGEBOj/+G0+elvSe68Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4439
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=944
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201070096
X-Proofpoint-GUID: AM1AmGYUWkbhJaZ_GzqSaiNVW6bFtS-z
X-Proofpoint-ORIG-GUID: AM1AmGYUWkbhJaZ_GzqSaiNVW6bFtS-z
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Maciej,

> I have tried your tree and it does not clobber the HBA anymore,

Excellent!

> however partitions (of the MS-DOS type) are not recognised with any of
> the disks including one holding the root device, so the system fails
> to mount the root filesystem and therefore does not complete booting:

My mistake. An unrelated change to the revalidate logic in the last
patch. Fixed and pushed.

For your Mylex issue I believe the first patch in the series is all
that's needed:

06a471da0937 ("scsi: core: Query VPD size before getting full page")

Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
