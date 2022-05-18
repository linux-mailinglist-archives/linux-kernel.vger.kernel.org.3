Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A6052AFCC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 03:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbiERBSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 21:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbiERBSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 21:18:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5611943384;
        Tue, 17 May 2022 18:18:05 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HKZMu3008024;
        Wed, 18 May 2022 01:18:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=g1JMyclvjQ45tky9JJZZpBlb1tu/l7g0W6Y6MiUVlR0=;
 b=qslzp6zX5/8IqwCbqWAIg4aedNd3zmQgvHya07MPSnBS4PC2cFYkF5fgDId5M7tacUfY
 5tcHJBID/YlnfOSuNS09ca4v8hMpgEiFMr1IpeOluYb9Dg6n+ksPiJOAVNKBg5ydwQn0
 TZ6DIoM/BFGlMkgaq//pPTqSY/LRe76SNvmel1Ok8S9ENCpxvfHrttnLqEzRJMBxn4na
 wx/ewVioovsTVIgg4FrGYtlvlifkpkwTidXwzsZWNxHR5ZibA1abwwoxC65lLeRTTzgo
 AdeDwXmE/4U8m6LG0h1Uk0egZJDWrD0VjX0V/HCq80xNNaVJvJejaM+RPSrkwobSQVUN 7g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g22uc7pcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 01:18:02 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24I19mEa017250;
        Wed, 18 May 2022 01:18:01 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g22v3sh8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 01:18:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEXSi+vzjeiaN87EigYsQOj/tnsoYa+i7e9G9doffmMXufvstMk0e135OWQZjgFGJQReCcNPfkkB/tX+ZE4WQSkVQp2/H7ECqMEcMB/fDM0wkS8kZiuHCs3jDqxI3BiFUbiDloGYh7H59pbAsZrqGPHyPlwIPfT/93lDaXT23AZ8lzLQbwANOi1vaUKqfdwWjyB1nM9vJQ9ASXpO3eMivR8AZ2Wza0Cdb2OR9R1ps109kh0OuDdA326ZklF54Fh2dydyG+9G3uLL28R9gr0F0ve0l+WLw5zhUkQNT2XB8gAz+o3rIbvmZtns9DGHmaXo1T+IfQ1+9fifuTAP0yLzqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1JMyclvjQ45tky9JJZZpBlb1tu/l7g0W6Y6MiUVlR0=;
 b=E6JGd532swn2UGpZ+Yab5BQi0Q4BOHfIVjlBMfb4ZFnDhMweGx5RHy12b9y+RFZBuRqtiAIrapst8P+cGFETLvxTKLf4rUoCHk455xzVHKXj2b9jO6e2/gGCis0eAzpR521bAiK0tjYgPcfu6xuj8Pf2SxSVQQHJp8vHRWGUnZWqF5UH04I2cttzdd1pwXNW1wfiwwPcKBw7CeOiu/vlS87zNXxpAHKK7V8prPBEGLTQIfTgdV9oW+9eBXqDBM8d6w7siR2fus3iD9UxWtJE565LZrS7p03q+fIlqGWyXMPZQPsDnNOc+kCYgaQ++FdY0Rj0akNv5AZr1Lcg25jETg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1JMyclvjQ45tky9JJZZpBlb1tu/l7g0W6Y6MiUVlR0=;
 b=sxbjRC+b7BpK809tmflCe6rVpEm1O391QQ5JoJHQnHmKHVaTJatUN0oSoGakBya1ahYj1/0icfMcW7WqSx5kfJ31x9eKjB8XVv2MRTff/JddNnEjEvJEsMKflx1HEHnSZZZ2+vZQbQcaG/HwMcsFbnUzW8o6qpuo7hCM6vN6Gx0=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB6203.namprd10.prod.outlook.com (2603:10b6:510:1f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 01:17:59 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%9]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 01:17:59 +0000
To:     Karan Tilak Kumar <kartilak@cisco.com>
Cc:     sebaddel@cisco.com, arulponn@cisco.com, djhawar@cisco.com,
        gcboffa@cisco.com, satishkh@cisco.com, gvaradar@cisco.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: fnic: Replace DMA mask of 64 bits with 47 bits
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq18rqzoczo.fsf@ca-mkp.ca.oracle.com>
References: <20220513205605.81788-1-kartilak@cisco.com>
Date:   Tue, 17 May 2022 21:17:56 -0400
In-Reply-To: <20220513205605.81788-1-kartilak@cisco.com> (Karan Tilak Kumar's
        message of "Fri, 13 May 2022 13:56:05 -0700")
Content-Type: text/plain
X-ClientProxiedBy: DM5PR07CA0080.namprd07.prod.outlook.com
 (2603:10b6:4:ad::45) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9272f419-cf6e-455e-d750-08da386c3ef7
X-MS-TrafficTypeDiagnostic: PH7PR10MB6203:EE_
X-Microsoft-Antispam-PRVS: <PH7PR10MB6203A90F3BD86F5AE8D53D1F8ED19@PH7PR10MB6203.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /CbQ7bkAQIPaNOTVZ+NWB2VcONwR8+kDHZn89e/v+SdvH4FUIJElbJzqj7AUU3V4lYgXxXgxddPQ3gcQ+ZyYIwLpNUc8AxI8TRp0a/r4VGD+GkUOBJBqicvfqikTiLnMSUn4puDPFDPxK+9yyIaKCy+fTEk6TvBV0rmVGNXgAxKXFRu5N6kDaehjQUcx83GH39vDRmqXgUyEcQfN4ZLAllKG63uwSKRdN+2hS/C1S/TG2bmde7/bfvjwskjVfBuKdOGoPr6EO+ERDbkshDXTXP2zf0MiOKbXhR0Gh8FPiLuEivwADmrqVAL/4BdKi2GSYluRFb4E5/KMrAMeUUyQwyjJFoadyAmSeRaLeZGxagzAZON6JnXqxqQdMnQ3E1hCm0rDpVrScCeXX13wQgY2TfcVfnsexNrJ50NAt35PuvTtFExW5aDIHGlCKszpfAPtHPg8QrND2NKbdyF1CWRzkimw+8djQ2zLDQMMfRlzIhwiLTWhST9n48rHz6x7appvrizXPSn5dr/xpw1kPSsLWJFiJ9b94m4dH7XS/n+5v1MX0gWVl+PTZpDIW0YZrUqeS8Ee+oDd58VPziJWVE7l/oq39A3soL69YNpZ7FRSH6qiFee7N8KQwGhEwMbPju9h2D88tYUyABqVJJ5FM9X+6Ox8qpQ/FXlhZU+he7sg47SjWOKsk4TPtDzK7kuu6EXFHsIBfUMT63ncfCI4vK6LBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(36916002)(6486002)(52116002)(66476007)(6506007)(8936002)(5660300002)(38100700002)(26005)(2906002)(6512007)(6916009)(8676002)(316002)(558084003)(7416002)(66946007)(86362001)(66556008)(6666004)(186003)(4326008)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P3SLvxF3xH8xm3U4oC2pf2mURGc5Rwcvi5S91U/kxPuVINVjXA9xF7ITkT0h?=
 =?us-ascii?Q?3v0QiHzsTfZsOTAKEw6y5FBDHclAcoxpjou+wWegIf7mnw8SAdCU/rbAHTxr?=
 =?us-ascii?Q?qNlvtYKt91RUTmJ2Yc9Y3WKdcHTe9unFT6YeqTKVe5stca02Ivxio8M3RDMS?=
 =?us-ascii?Q?a+92S+JYc3FWEu8z64Ph13378sTUrSLZWaMUaktmk6Uof7mhviH3fuhKWw+n?=
 =?us-ascii?Q?0b4blHn2D4CGWSU1jARS2vO05CgNOhb6f582I3Oe16veR3SzaVp2jprC7CZZ?=
 =?us-ascii?Q?ykDlizRiax6ATwuqk2+GTbjK1rX9SScp7ZCsaipSnlEXukk89QLiFWp50/Aq?=
 =?us-ascii?Q?3hTfVlmLLDLxufgcr0EqVYHNRONz3QWZ31JpfQHb0YPITEIBx5DnutYaDmFL?=
 =?us-ascii?Q?yGl2IJrEvrhdA66jgJDy5ttQuCU/SIBirLOu/WPe9Okk3N1ueqJIhReMOTGE?=
 =?us-ascii?Q?izIRAssTgbPuN3vcgamvFr3EkmgzxPp8bPMZ3v4+rsnjioTNRoJ9oe3uZaPW?=
 =?us-ascii?Q?n/Xyk6CKjFA78E8INl7zta2ZYu5Nv3t4fV250SxSAlzWfwYCcn+AoUA7yO5i?=
 =?us-ascii?Q?MqdSNE47Ae3IhbE5JEE5OfcXyohCymNuKq2qA6pizqq9a7iN+kbIkiMR/Wlb?=
 =?us-ascii?Q?VX4IMC5FTNOKISbgicMFbOS55ofoDrEepSkjBcjUtfJrh/RTkHDIbFKWwbe2?=
 =?us-ascii?Q?x0RQgD9um9EQW0PjciLlQAzRKWduL1qsVucD4mhy5S/2rL689jg4QLEV62p5?=
 =?us-ascii?Q?Rh/r0XSO/E7PNlaadRj2oz8JRfa25114azLdcnU5rl3aAzMNa11Y/qwRH20z?=
 =?us-ascii?Q?ydX0GHRkDjWIy6VdIWsxTAHTd25mvqUCE1H1f6NlRXEaDCa+OecsXNs3xA6B?=
 =?us-ascii?Q?yIo9QXP5YBk+jNoQS3MEQRGIQtI24ScDEuIXIT/2JzrIgjuEc+CrqgUw+tR/?=
 =?us-ascii?Q?co7pgMw9j7bdkx1VTpYniEofjL3+rau1M5raXK4DmU585SsQCinvz2sdUkIw?=
 =?us-ascii?Q?kjcOqSm6fBbYg24JnZAAKpIIW9oLGr63sHmxOQq4I8rAdDsCqk5NUndRjOb2?=
 =?us-ascii?Q?IP4D1wwPNQG/7aPnvU2QOOF0RNcm7KmK90bkowDngq/ePX0l5C4B3zxKEvwg?=
 =?us-ascii?Q?EM3Q8L408h5DnPs5UNPrqCh8Q+laDk00zGobsKP9kTBhQyh7AVTEG+Ix7c0W?=
 =?us-ascii?Q?YGX2T2oJaMsRsjuf+u29BeQ3TviSlvpXIyKpOiDR/YiNjZ6/mZk3v07YaJLO?=
 =?us-ascii?Q?pGeTBi0Tp7wUvQgR9hY2QVXu+u0JrksYjTnzj+Q3RAJeNVfEgFTXQDtP/2hE?=
 =?us-ascii?Q?rqN6dumwfmynL/xojSpc5xP5kVWwBAEc4Hs4psBGgyoo2nPBybByf7f92JfD?=
 =?us-ascii?Q?dN0YxXb/mc9sS/8h5LWyxNfLE/dnqnYHjhkBrMR3dqOKKdbqvhJqWheiF8//?=
 =?us-ascii?Q?XrsNhTOPDihjKUR1FOVqxHajDFht85o7PZig+We4/LBlga4F8HXv9tQ/6Ve8?=
 =?us-ascii?Q?9pVBMUQRkejPUm9cGapuo86IF2Q9YwBEwVt8aE49o5i9Zyyrr9bCnPX0pRGm?=
 =?us-ascii?Q?rsNxKxTlKjeHFLaB2MoW8ENM52i61MqsvKuSNMAiU4CzASAtBcgwHlYmCm5V?=
 =?us-ascii?Q?jA6eDsVT94Xz9LoOeLrb+b8GG3aAmxuqxpzDKtU95A2jUCqju/AD2SkzYbSk?=
 =?us-ascii?Q?92Lmbxs+piTRvsKtuzbgrbGHLSFycoww7pCXJawfIdEZaS6ocGokR0EkverS?=
 =?us-ascii?Q?C9h3G7qwNqQwd/K+jkOPVQNCxWwGkbw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9272f419-cf6e-455e-d750-08da386c3ef7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 01:17:59.2118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HDjdfJ25TblT6vrQ9iv0bA4cAYMDbzYY1fHlJsaDQtCALKYN10C3xjPZZ17dwig0sb7oQDdDG4UpumIQOBxCQmWMQIqkY1zBuv4hR16pYdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6203
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-17_03:2022-05-17,2022-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=805 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205180006
X-Proofpoint-GUID: Xy26gKQTyDzXNvyYetvlL784DKvURhrT
X-Proofpoint-ORIG-GUID: Xy26gKQTyDzXNvyYetvlL784DKvURhrT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Karan,

> Cisco VIC supports only 47 bits.  If the host sends DMA addresses that
> are greater than 47 bits, it causes work queue (WQ) errors in the VIC.

Applied to 5.19/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
