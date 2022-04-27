Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18C6511F47
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243686AbiD0RDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbiD0RC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:02:57 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A692957145
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:59:39 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RDwhvK018018;
        Wed, 27 Apr 2022 16:59:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=PPS06212021;
 bh=urqEmO4R+yeFkX/yPYpwLvKjopRtzZkeVQq1BsPrjto=;
 b=FPKUfJ2GswnO5Y9tSqf/yYFIwgoAOQlC0PkMzpuf4rFuTGEnT27AXMeneg7gCT4bqHK+
 LpEJ1eiv/o9B1ciMNBXzz32dfG0nRvyO+n2jv2bpElabHt2VYw3sC+FLg2FqZlpv/bJn
 kUtOz5LTsgyASTFd076S84LD1oafuhYi4mtrjYbf8TmQvcair4x6L1Dy634hV6rEp8AH
 DmyC8u+GtIDc9Voj28mJI/I3bSwGfWUIGRSHI355Cn9gVI9mgaDoen5+DKXQz+ub0opE
 mTAvKXOqtfiwb/4vUF9ym1vv0EOZkHbVjl+vmTx5gi4I4gVAHoLDhHIsvoPafTpe2WPl lw== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3fprtcrpjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 16:59:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTgM6G/BZ7SmcYSQ2Tbq1DNaDNg8WJKiBGWJU9LaHkY8aAvB3tzJRSa1iFTgsoKY1L763A3LeRoGJysXMcQ7Rj675opB6l3bCJoybArtheqhhW79RgCYDp5HZkXl8qKVg4a6oDBcBznV/VUZU53DIlAC/z47Luhz88uhWrJkQB5j5zZxiTmCBp+tOGqGVVRcG1/gtkAyo2Wl8pUcbNbLA6IGguB81ix3yLYDB6C61Ngs/WQivOKuT+iDX1VI/zuBwSqkflZ318TW8EyPslckMS/NUhXc6apgIKenGZhwyRMcgB9X8TKQP4cqucrkepTnQC4uY5JVN6VNHPm+xhnrJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urqEmO4R+yeFkX/yPYpwLvKjopRtzZkeVQq1BsPrjto=;
 b=IhOqOeCRMaNnkJtvPnBRXBhsFHBdEAVQzthaXhHo7G5eusi9Vu2BSniZLlBZYneP6JbpxYzi9INjJ8ftmGX+5M9EEf8cdBKsP+lsH3iIOdqO8At1gm2AeXtiscJf57uCsDaRFn7uGnU5xW3N0qk82AVXqwg61KNhcEvKO01fVwBUem1rQDiWJtmb4gPBwYi9PlfiXcjRu24lgVZePaXymPE6urMl0C7EPiwAS18AcXiNM0TZYqm79FlhwjrkNuA/gTVY+bumSSnFr6rg9s8dGElQvmeIbzXAsJzRzAiAhjMYrfidwa1IoyP6cuZ0Ky+Z71A69T+MUsbKiseyWApEaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by MWHPR11MB1949.namprd11.prod.outlook.com (2603:10b6:300:110::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Wed, 27 Apr
 2022 16:59:21 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::89e0:ae63:8b71:4a0f]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::89e0:ae63:8b71:4a0f%5]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 16:59:21 +0000
Date:   Wed, 27 Apr 2022 12:59:17 -0400
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Phillip Potter <phil@philpotter.co.uk>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 3/3] block: remove last remaining traces of IDE
 documentation
Message-ID: <20220427165917.GE12977@windriver.com>
References: <20220427132436.12795-1-paul.gortmaker@windriver.com>
 <20220427132436.12795-4-paul.gortmaker@windriver.com>
 <87wnfaa8ce.fsf@meer.lwn.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wnfaa8ce.fsf@meer.lwn.net>
X-ClientProxiedBy: SJ0PR13CA0060.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::35) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 668fda9a-852c-4fb8-bb8a-08da286f464f
X-MS-TrafficTypeDiagnostic: MWHPR11MB1949:EE_
X-Microsoft-Antispam-PRVS: <MWHPR11MB19499A844808009DDE92848E83FA9@MWHPR11MB1949.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r88Hz8sgJxQDMG23YUtLnnN8M8zStmG/KWayJS6Kbikr5OI5ytT8F8+hONJerhJBxtHa/aYl4RMTJE0DUPQL4ykwZOg6SDV/U4uQJpXZTXBSHPDRTa4ru5W4/iekUsJdwLqPn7xEtREXgm6d42fxXuXDxpl7Y19EEelxA7gSiUtT4HlbVjrL8xpBcZrk0sZ79qFHYAWBmDOL2qbQp0ogRYHDDs3q3bU2y8itACr3eqHOCja9vtqFWY/k6JswXDM/Vv0g2Fieopdypb46Dsg7w1OfhlMPK7ZGZybjxNgilt6q2+QB5y8qkpl+DTfOiGAoBT5DK8S/iTczaL8ue6Nb3odxscCwmUtrVuuZqBuN2wcElA9NFXlwAv+oblfTxoZF2RCLl3iW5wxNoksPMaLX2a64yx49y6fD+tjqfh17VHBR0CCbmJrqZBnCtBoGe4BFTiqHqVO8cSMtzfDd+4KORAAdL9/NV+2tXzf8O0N0AS7mw3JRbJMOXA8g/2OtYcBHBIR3IaV18zsbT1oMtvJIe2CeDIFFpDU95vMCFH0pFjIX+cgELEMOaKw90/JF2cbBOH7ROxvvsDoi9iaHm4VRtyQuXqtrvO2mzrCwAuSwNVReOu80PZ2Bq4sKKhckUl9nNtZjnz9NFNxPx+24F323vqUcXJpHhupw3l5Soa1EnCTG0nib4tGjPXmJYuyTJ8W2Ks9CTUP7itBJuJrUcZOtKkSxWjC/S4Gyeyik4znaEd4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(508600001)(186003)(8936002)(44832011)(36756003)(1076003)(6486002)(316002)(83380400001)(2616005)(66946007)(66556008)(66476007)(30864003)(53546011)(6916009)(45080400002)(38100700002)(38350700002)(6666004)(33656002)(2906002)(52116002)(54906003)(26005)(86362001)(6512007)(6506007)(8676002)(4326008)(357404004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RWAdThKzKJFCT9pUetv8Alau6YGUKmnNUEs29Hts3+SobZA9WR1CvKeMQQux?=
 =?us-ascii?Q?vYh77AbHIe2Pv7Q+26zc8AN0mwofJTN0OBGZWQA2YxYe4RM9pccFHHgL/vml?=
 =?us-ascii?Q?ugrFPCbc1mptT38+nrRxASWpKw56S6+bHecsjjQkgPxpXNx8Xsa3G+15Ku/I?=
 =?us-ascii?Q?BiuveMT9xYYEq1zaDxfZeUxnkR2aE8f7+EslqhN2gtrPD5/c2mmEW1JpT8zR?=
 =?us-ascii?Q?VA4JhUsRxQrfcJgf+ecK1D2id2xNFVzf7NC/uPrJRxyamdkct39iugnz4xFV?=
 =?us-ascii?Q?/FOXZWUQbLCn3jubX5FP7t+Hsr/HuKTuTyvVqgIjC/oxzfqrPJjf2BGsxOru?=
 =?us-ascii?Q?98Fa5xZhRWtsK0DPyybQTzSj4XLIzKMaWoPCYqZnVDF9lcisM8s1vvSDEsjO?=
 =?us-ascii?Q?KecBaIYcrKyGbaLFC7SNKrooRMewxLAaEcEYuYt4YLTnREUmyle1NjJGS1Jb?=
 =?us-ascii?Q?2QJD/LLgGIYqiN/Sn129OuOSQVQbjBuXDYQR6okJdC94qFCUPF9xflo05lLv?=
 =?us-ascii?Q?MtSMrV5t7h21cNhuJQCSwKOwFBvJ5NoVp8JYCBCh/W5oiDrB8NmeyfiHmZWE?=
 =?us-ascii?Q?xjKS/abRZWjjYxIvoCbv5zT1EYXOzCHHd/lxxVpZwbzdYVQdmYsh8Z+BxmcI?=
 =?us-ascii?Q?Fo3k2EuD5stojztizoUpWxYSCb9+npXYFeqCD/HeUe8Q8U143WJi3ZQDTqUt?=
 =?us-ascii?Q?GUvaxwn9RLG8UvNX5PKjCe0tCIq66fchJO4HQLwMQMy1Sq1tPag2aELLPchi?=
 =?us-ascii?Q?mXT8yR0uidpWRpX/6xUQnxIcqQQP7iWTK10UzVKFyoTlgZGG2z+E+VtKQMDw?=
 =?us-ascii?Q?TzmK9zLjsowVOpOyF91Ygtgz49/JtkGAKgT2ISWes4sdDPE79SQrCkRcy4fB?=
 =?us-ascii?Q?cXeNeJRMAalPqL2N2m64vS+jJZmbUKNcVmcfCIme5oChB8XtjFSDFjfwj2aT?=
 =?us-ascii?Q?QfukVu52ygvPZVlwnu5Vd3b9hQcNY9Bi49ZZeRX7GMaeQrxaMqJM8zt8We2Q?=
 =?us-ascii?Q?TCMySHdFi+fW5kBIVB05AFXDt38DbtiHLhuI4D/ltCOOK7zanANmTeHJczOd?=
 =?us-ascii?Q?8xh2byl22YkiZJvSs51kVo6yDbL1u0Gia3SWB4jrYyDI3WfB8rv2SYFkE9Wj?=
 =?us-ascii?Q?VVIr1jS8vneb7uGvzueXUsIhufkhEJBEIcg49eo0DcRLH7YMq83rzO0tT3hP?=
 =?us-ascii?Q?kA68AKxwYOzbEB09afKMNrP81Mdn5nDjFVkza87rwega4KJzwEGy8VlIdGpg?=
 =?us-ascii?Q?fvY0xUq2orl//pvJZy1JG5EEDmbef5peROCdcjfMcIRpTFDMkzLLx1IaMd4h?=
 =?us-ascii?Q?Zmlu6sEPZXXAx/h3FkovQnOhdaEAQmcSYbxp1HM8aPLmOYHMlN6YZAaWqiAk?=
 =?us-ascii?Q?Eyc1BjhhrallASvC4iZXLt1awgjEpbPuuCVByUTTmP+iGmoTM2rJ/NCLIqFl?=
 =?us-ascii?Q?TT61C9QP90qG1Itnim2ThYN0sAkfTdUB+GFKRPjXvccs1Cpm4URYgSmJtYb6?=
 =?us-ascii?Q?KQ1brA9A5urm6nZ2n1ce5n9ZbQWIdW3RNI4foBU5xFE+KKjW0o+s3j8EcjZb?=
 =?us-ascii?Q?CXsHMRay+U5WWJ3WJ5qDNmvgtcGfbd6S5U2GQxdp3K+Rr6N3364MPQKtmJSX?=
 =?us-ascii?Q?90bVSpCEmbs32UapPD3yoGEYTZX69AFaaho3e7tqnucnNVEpBfYGBjSrfcKh?=
 =?us-ascii?Q?NLUSCvXdZGVtsD4NDV0buAD/MiAT/OQkobjGrLH9xilXj6CtHMKtYX/jv6u+?=
 =?us-ascii?Q?W2vutAO+hojc16RzZ+LGaxBm2nrazzM=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 668fda9a-852c-4fb8-bb8a-08da286f464f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 16:59:21.5426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aeoM9H2LCAOviFohcliatWpycwD/3OeuDGgYIo/wH2THkItkh0SIUFH1k6L8Wu6EL1tx4VLxpAv293pTi5T71qb8ZQHq+Mx5tq9P8dMcCMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1949
X-Proofpoint-GUID: y1PKlC3wmZIukZvrSWxYsY0uScPxkzTk
X-Proofpoint-ORIG-GUID: y1PKlC3wmZIukZvrSWxYsY0uScPxkzTk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_04,2022-04-27_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204270106
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH 3/3] block: remove last remaining traces of IDE documentation] On 27/04/2022 (Wed 08:50) Jonathan Corbet wrote:

> The Documentation/ide part of this is already dealt with in docs-next;
> obviously there was more to do, though :)

Ah, I'd checked mainline master of today but not sfr's next.

Here is a delta diff against today's linux-next

Thanks,
Paul.
--

From ecb86eb357e5151ba5f7e7d172c65d07d88c4c39 Mon Sep 17 00:00:00 2001
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Wed, 27 Apr 2022 12:45:50 -0400
Subject: [PATCH -next] Documentation: remove last remaining traces of IDE
 information

The last traces of the IDE driver went away in commit b7fb14d3ac63
("ide: remove the legacy ide driver") but it left behind some traces
of old documentation.

As luck would have it Randy and I would submit similar changes within
a week of each other to address this.  As Randy's commit is in the doc
tree already - this delta is just the stuff my removal contained that
was not in Randy's IDE doc removal.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Phillip Potter <phil@philpotter.co.uk>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 308da668bbb1..47a83deebb3d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1797,27 +1797,6 @@
 	icn=		[HW,ISDN]
 			Format: <io>[,<membase>[,<icn_id>[,<icn_id2>]]]
 
-	ide-core.nodma=	[HW] (E)IDE subsystem
-			Format: =0.0 to prevent dma on hda, =0.1 hdb =1.0 hdc
-			.vlb_clock .pci_clock .noflush .nohpa .noprobe .nowerr
-			.cdrom .chs .ignore_cable are additional options
-			See Documentation/ide/ide.rst.
-
-	ide-generic.probe-mask= [HW] (E)IDE subsystem
-			Format: <int>
-			Probe mask for legacy ISA IDE ports.  Depending on
-			platform up to 6 ports are supported, enabled by
-			setting corresponding bits in the mask to 1.  The
-			default value is 0x0, which has a special meaning.
-			On systems that have PCI, it triggers scanning the
-			PCI bus for the first and the second port, which
-			are then probed.  On systems without PCI the value
-			of 0x0 enables probing the two first ports as if it
-			was 0x3.
-
-	ide-pci-generic.all-generic-ide [HW] (E)IDE subsystem
-			Claim all unknown PCI IDE storage controllers.
-
 	idle=		[X86]
 			Format: idle=poll, idle=halt, idle=nomwait
 			Poll forces a polling idle loop that can slightly
diff --git a/Documentation/cdrom/ide-cd.rst b/Documentation/cdrom/ide-cd.rst
deleted file mode 100644
index bdccb74fc92d..000000000000
--- a/Documentation/cdrom/ide-cd.rst
+++ /dev/null
@@ -1,538 +0,0 @@
-IDE-CD driver documentation
-===========================
-
-:Originally by: scott snyder  <snyder@fnald0.fnal.gov> (19 May 1996)
-:Carrying on the torch is: Erik Andersen <andersee@debian.org>
-:New maintainers (19 Oct 1998): Jens Axboe <axboe@image.dk>
-
-1. Introduction
----------------
-
-The ide-cd driver should work with all ATAPI ver 1.2 to ATAPI 2.6 compliant
-CDROM drives which attach to an IDE interface.  Note that some CDROM vendors
-(including Mitsumi, Sony, Creative, Aztech, and Goldstar) have made
-both ATAPI-compliant drives and drives which use a proprietary
-interface.  If your drive uses one of those proprietary interfaces,
-this driver will not work with it (but one of the other CDROM drivers
-probably will).  This driver will not work with `ATAPI` drives which
-attach to the parallel port.  In addition, there is at least one drive
-(CyCDROM CR520ie) which attaches to the IDE port but is not ATAPI;
-this driver will not work with drives like that either (but see the
-aztcd driver).
-
-This driver provides the following features:
-
- - Reading from data tracks, and mounting ISO 9660 filesystems.
-
- - Playing audio tracks.  Most of the CDROM player programs floating
-   around should work; I usually use Workman.
-
- - Multisession support.
-
- - On drives which support it, reading digital audio data directly
-   from audio tracks.  The program cdda2wav can be used for this.
-   Note, however, that only some drives actually support this.
-
- - There is now support for CDROM changers which comply with the
-   ATAPI 2.6 draft standard (such as the NEC CDR-251).  This additional
-   functionality includes a function call to query which slot is the
-   currently selected slot, a function call to query which slots contain
-   CDs, etc. A sample program which demonstrates this functionality is
-   appended to the end of this file.  The Sanyo 3-disc changer
-   (which does not conform to the standard) is also now supported.
-   Please note the driver refers to the first CD as slot # 0.
-
-
-2. Installation
----------------
-
-0. The ide-cd relies on the ide disk driver.  See
-   Documentation/ide/ide.rst for up-to-date information on the ide
-   driver.
-
-1. Make sure that the ide and ide-cd drivers are compiled into the
-   kernel you're using.  When configuring the kernel, in the section
-   entitled "Floppy, IDE, and other block devices", say either `Y`
-   (which will compile the support directly into the kernel) or `M`
-   (to compile support as a module which can be loaded and unloaded)
-   to the options::
-
-      ATA/ATAPI/MFM/RLL support
-      Include IDE/ATAPI CDROM support
-
-   Depending on what type of IDE interface you have, you may need to
-   specify additional configuration options.  See
-   Documentation/ide/ide.rst.
-
-2. You should also ensure that the iso9660 filesystem is either
-   compiled into the kernel or available as a loadable module.  You
-   can see if a filesystem is known to the kernel by catting
-   /proc/filesystems.
-
-3. The CDROM drive should be connected to the host on an IDE
-   interface.  Each interface on a system is defined by an I/O port
-   address and an IRQ number, the standard assignments being
-   0x1f0 and 14 for the primary interface and 0x170 and 15 for the
-   secondary interface.  Each interface can control up to two devices,
-   where each device can be a hard drive, a CDROM drive, a floppy drive,
-   or a tape drive.  The two devices on an interface are called `master`
-   and `slave`; this is usually selectable via a jumper on the drive.
-
-   Linux names these devices as follows.  The master and slave devices
-   on the primary IDE interface are called `hda` and `hdb`,
-   respectively.  The drives on the secondary interface are called
-   `hdc` and `hdd`.  (Interfaces at other locations get other letters
-   in the third position; see Documentation/ide/ide.rst.)
-
-   If you want your CDROM drive to be found automatically by the
-   driver, you should make sure your IDE interface uses either the
-   primary or secondary addresses mentioned above.  In addition, if
-   the CDROM drive is the only device on the IDE interface, it should
-   be jumpered as `master`.  (If for some reason you cannot configure
-   your system in this manner, you can probably still use the driver.
-   You may have to pass extra configuration information to the kernel
-   when you boot, however.  See Documentation/ide/ide.rst for more
-   information.)
-
-4. Boot the system.  If the drive is recognized, you should see a
-   message which looks like::
-
-     hdb: NEC CD-ROM DRIVE:260, ATAPI CDROM drive
-
-   If you do not see this, see section 5 below.
-
-5. You may want to create a symbolic link /dev/cdrom pointing to the
-   actual device.  You can do this with the command::
-
-     ln -s  /dev/hdX  /dev/cdrom
-
-   where X should be replaced by the letter indicating where your
-   drive is installed.
-
-6. You should be able to see any error messages from the driver with
-   the `dmesg` command.
-
-
-3. Basic usage
---------------
-
-An ISO 9660 CDROM can be mounted by putting the disc in the drive and
-typing (as root)::
-
-  mount -t iso9660 /dev/cdrom /mnt/cdrom
-
-where it is assumed that /dev/cdrom is a link pointing to the actual
-device (as described in step 5 of the last section) and /mnt/cdrom is
-an empty directory.  You should now be able to see the contents of the
-CDROM under the /mnt/cdrom directory.  If you want to eject the CDROM,
-you must first dismount it with a command like::
-
-  umount /mnt/cdrom
-
-Note that audio CDs cannot be mounted.
-
-Some distributions set up /etc/fstab to always try to mount a CDROM
-filesystem on bootup.  It is not required to mount the CDROM in this
-manner, though, and it may be a nuisance if you change CDROMs often.
-You should feel free to remove the cdrom line from /etc/fstab and
-mount CDROMs manually if that suits you better.
-
-Multisession and photocd discs should work with no special handling.
-The hpcdtoppm package (ftp.gwdg.de:/pub/linux/hpcdtoppm/) may be
-useful for reading photocds.
-
-To play an audio CD, you should first unmount and remove any data
-CDROM.  Any of the CDROM player programs should then work (workman,
-workbone, cdplayer, etc.).
-
-On a few drives, you can read digital audio directly using a program
-such as cdda2wav.  The only types of drive which I've heard support
-this are Sony and Toshiba drives.  You will get errors if you try to
-use this function on a drive which does not support it.
-
-For supported changers, you can use the `cdchange` program (appended to
-the end of this file) to switch between changer slots.  Note that the
-drive should be unmounted before attempting this.  The program takes
-two arguments:  the CDROM device, and the slot number to which you wish
-to change.  If the slot number is -1, the drive is unloaded.
-
-
-4. Common problems
-------------------
-
-This section discusses some common problems encountered when trying to
-use the driver, and some possible solutions.  Note that if you are
-experiencing problems, you should probably also review
-Documentation/ide/ide.rst for current information about the underlying
-IDE support code.  Some of these items apply only to earlier versions
-of the driver, but are mentioned here for completeness.
-
-In most cases, you should probably check with `dmesg` for any errors
-from the driver.
-
-a. Drive is not detected during booting.
-
-   - Review the configuration instructions above and in
-     Documentation/ide/ide.rst, and check how your hardware is
-     configured.
-
-   - If your drive is the only device on an IDE interface, it should
-     be jumpered as master, if at all possible.
-
-   - If your IDE interface is not at the standard addresses of 0x170
-     or 0x1f0, you'll need to explicitly inform the driver using a
-     lilo option.  See Documentation/ide/ide.rst.  (This feature was
-     added around kernel version 1.3.30.)
-
-   - If the autoprobing is not finding your drive, you can tell the
-     driver to assume that one exists by using a lilo option of the
-     form `hdX=cdrom`, where X is the drive letter corresponding to
-     where your drive is installed.  Note that if you do this and you
-     see a boot message like::
-
-       hdX: ATAPI cdrom (?)
-
-     this does _not_ mean that the driver has successfully detected
-     the drive; rather, it means that the driver has not detected a
-     drive, but is assuming there's one there anyway because you told
-     it so.  If you actually try to do I/O to a drive defined at a
-     nonexistent or nonresponding I/O address, you'll probably get
-     errors with a status value of 0xff.
-
-   - Some IDE adapters require a nonstandard initialization sequence
-     before they'll function properly.  (If this is the case, there
-     will often be a separate MS-DOS driver just for the controller.)
-     IDE interfaces on sound cards often fall into this category.
-
-     Support for some interfaces needing extra initialization is
-     provided in later 1.3.x kernels.  You may need to turn on
-     additional kernel configuration options to get them to work;
-     see Documentation/ide/ide.rst.
-
-     Even if support is not available for your interface, you may be
-     able to get it to work with the following procedure.  First boot
-     MS-DOS and load the appropriate drivers.  Then warm-boot linux
-     (i.e., without powering off).  If this works, it can be automated
-     by running loadlin from the MS-DOS autoexec.
-
-
-b. Timeout/IRQ errors.
-
-  - If you always get timeout errors, interrupts from the drive are
-    probably not making it to the host.
-
-  - IRQ problems may also be indicated by the message
-    `IRQ probe failed (<n>)` while booting.  If <n> is zero, that
-    means that the system did not see an interrupt from the drive when
-    it was expecting one (on any feasible IRQ).  If <n> is negative,
-    that means the system saw interrupts on multiple IRQ lines, when
-    it was expecting to receive just one from the CDROM drive.
-
-  - Double-check your hardware configuration to make sure that the IRQ
-    number of your IDE interface matches what the driver expects.
-    (The usual assignments are 14 for the primary (0x1f0) interface
-    and 15 for the secondary (0x170) interface.)  Also be sure that
-    you don't have some other hardware which might be conflicting with
-    the IRQ you're using.  Also check the BIOS setup for your system;
-    some have the ability to disable individual IRQ levels, and I've
-    had one report of a system which was shipped with IRQ 15 disabled
-    by default.
-
-  - Note that many MS-DOS CDROM drivers will still function even if
-    there are hardware problems with the interrupt setup; they
-    apparently don't use interrupts.
-
-  - If you own a Pioneer DR-A24X, you _will_ get nasty error messages
-    on boot such as "irq timeout: status=0x50 { DriveReady SeekComplete }"
-    The Pioneer DR-A24X CDROM drives are fairly popular these days.
-    Unfortunately, these drives seem to become very confused when we perform
-    the standard Linux ATA disk drive probe. If you own one of these drives,
-    you can bypass the ATA probing which confuses these CDROM drives, by
-    adding `append="hdX=noprobe hdX=cdrom"` to your lilo.conf file and running
-    lilo (again where X is the drive letter corresponding to where your drive
-    is installed.)
-
-c. System hangups.
-
-  - If the system locks up when you try to access the CDROM, the most
-    likely cause is that you have a buggy IDE adapter which doesn't
-    properly handle simultaneous transactions on multiple interfaces.
-    The most notorious of these is the CMD640B chip.  This problem can
-    be worked around by specifying the `serialize` option when
-    booting.  Recent kernels should be able to detect the need for
-    this automatically in most cases, but the detection is not
-    foolproof.  See Documentation/ide/ide.rst for more information
-    about the `serialize` option and the CMD640B.
-
-  - Note that many MS-DOS CDROM drivers will work with such buggy
-    hardware, apparently because they never attempt to overlap CDROM
-    operations with other disk activity.
-
-
-d. Can't mount a CDROM.
-
-  - If you get errors from mount, it may help to check `dmesg` to see
-    if there are any more specific errors from the driver or from the
-    filesystem.
-
-  - Make sure there's a CDROM loaded in the drive, and that's it's an
-    ISO 9660 disc.  You can't mount an audio CD.
-
-  - With the CDROM in the drive and unmounted, try something like::
-
-      cat /dev/cdrom | od | more
-
-    If you see a dump, then the drive and driver are probably working
-    OK, and the problem is at the filesystem level (i.e., the CDROM is
-    not ISO 9660 or has errors in the filesystem structure).
-
-  - If you see `not a block device` errors, check that the definitions
-    of the device special files are correct.  They should be as
-    follows::
-
-      brw-rw----   1 root     disk       3,   0 Nov 11 18:48 /dev/hda
-      brw-rw----   1 root     disk       3,  64 Nov 11 18:48 /dev/hdb
-      brw-rw----   1 root     disk      22,   0 Nov 11 18:48 /dev/hdc
-      brw-rw----   1 root     disk      22,  64 Nov 11 18:48 /dev/hdd
-
-    Some early Slackware releases had these defined incorrectly.  If
-    these are wrong, you can remake them by running the script
-    scripts/MAKEDEV.ide.  (You may have to make it executable
-    with chmod first.)
-
-    If you have a /dev/cdrom symbolic link, check that it is pointing
-    to the correct device file.
-
-    If you hear people talking of the devices `hd1a` and `hd1b`, these
-    were old names for what are now called hdc and hdd.  Those names
-    should be considered obsolete.
-
-  - If mount is complaining that the iso9660 filesystem is not
-    available, but you know it is (check /proc/filesystems), you
-    probably need a newer version of mount.  Early versions would not
-    always give meaningful error messages.
-
-
-e. Directory listings are unpredictably truncated, and `dmesg` shows
-   `buffer botch` error messages from the driver.
-
-  - There was a bug in the version of the driver in 1.2.x kernels
-    which could cause this.  It was fixed in 1.3.0.  If you can't
-    upgrade, you can probably work around the problem by specifying a
-    blocksize of 2048 when mounting.  (Note that you won't be able to
-    directly execute binaries off the CDROM in that case.)
-
-    If you see this in kernels later than 1.3.0, please report it as a
-    bug.
-
-
-f. Data corruption.
-
-  - Random data corruption was occasionally observed with the Hitachi
-    CDR-7730 CDROM. If you experience data corruption, using "hdx=slow"
-    as a command line parameter may work around the problem, at the
-    expense of low system performance.
-
-
-5. cdchange.c
--------------
-
-::
-
-  /*
-   * cdchange.c  [-v]  <device>  [<slot>]
-   *
-   * This loads a CDROM from a specified slot in a changer, and displays
-   * information about the changer status.  The drive should be unmounted before
-   * using this program.
-   *
-   * Changer information is displayed if either the -v flag is specified
-   * or no slot was specified.
-   *
-   * Based on code originally from Gerhard Zuber <zuber@berlin.snafu.de>.
-   * Changer status information, and rewrite for the new Uniform CDROM driver
-   * interface by Erik Andersen <andersee@debian.org>.
-   */
-
-  #include <stdio.h>
-  #include <stdlib.h>
-  #include <errno.h>
-  #include <string.h>
-  #include <unistd.h>
-  #include <fcntl.h>
-  #include <sys/ioctl.h>
-  #include <linux/cdrom.h>
-
-
-  int
-  main (int argc, char **argv)
-  {
-	char *program;
-	char *device;
-	int fd;           /* file descriptor for CD-ROM device */
-	int status;       /* return status for system calls */
-	int verbose = 0;
-	int slot=-1, x_slot;
-	int total_slots_available;
-
-	program = argv[0];
-
-	++argv;
-	--argc;
-
-	if (argc < 1 || argc > 3) {
-		fprintf (stderr, "usage: %s [-v] <device> [<slot>]\n",
-			 program);
-		fprintf (stderr, "       Slots are numbered 1 -- n.\n");
-		exit (1);
-	}
-
-       if (strcmp (argv[0], "-v") == 0) {
-                verbose = 1;
-                ++argv;
-                --argc;
-        }
-
-	device = argv[0];
-
-	if (argc == 2)
-		slot = atoi (argv[1]) - 1;
-
-	/* open device */
-	fd = open(device, O_RDONLY | O_NONBLOCK);
-	if (fd < 0) {
-		fprintf (stderr, "%s: open failed for `%s`: %s\n",
-			 program, device, strerror (errno));
-		exit (1);
-	}
-
-	/* Check CD player status */
-	total_slots_available = ioctl (fd, CDROM_CHANGER_NSLOTS);
-	if (total_slots_available <= 1 ) {
-		fprintf (stderr, "%s: Device `%s` is not an ATAPI "
-			"compliant CD changer.\n", program, device);
-		exit (1);
-	}
-
-	if (slot >= 0) {
-		if (slot >= total_slots_available) {
-			fprintf (stderr, "Bad slot number.  "
-				 "Should be 1 -- %d.\n",
-				 total_slots_available);
-			exit (1);
-		}
-
-		/* load */
-		slot=ioctl (fd, CDROM_SELECT_DISC, slot);
-		if (slot<0) {
-			fflush(stdout);
-				perror ("CDROM_SELECT_DISC ");
-			exit(1);
-		}
-	}
-
-	if (slot < 0 || verbose) {
-
-		status=ioctl (fd, CDROM_SELECT_DISC, CDSL_CURRENT);
-		if (status<0) {
-			fflush(stdout);
-			perror (" CDROM_SELECT_DISC");
-			exit(1);
-		}
-		slot=status;
-
-		printf ("Current slot: %d\n", slot+1);
-		printf ("Total slots available: %d\n",
-			total_slots_available);
-
-		printf ("Drive status: ");
-                status = ioctl (fd, CDROM_DRIVE_STATUS, CDSL_CURRENT);
-                if (status<0) {
-                  perror(" CDROM_DRIVE_STATUS");
-                } else switch(status) {
-		case CDS_DISC_OK:
-			printf ("Ready.\n");
-			break;
-		case CDS_TRAY_OPEN:
-			printf ("Tray Open.\n");
-			break;
-		case CDS_DRIVE_NOT_READY:
-			printf ("Drive Not Ready.\n");
-			break;
-		default:
-			printf ("This Should not happen!\n");
-			break;
-		}
-
-		for (x_slot=0; x_slot<total_slots_available; x_slot++) {
-			printf ("Slot %2d: ", x_slot+1);
-			status = ioctl (fd, CDROM_DRIVE_STATUS, x_slot);
-			if (status<0) {
-			     perror(" CDROM_DRIVE_STATUS");
-			} else switch(status) {
-			case CDS_DISC_OK:
-				printf ("Disc present.");
-				break;
-			case CDS_NO_DISC:
-				printf ("Empty slot.");
-				break;
-			case CDS_TRAY_OPEN:
-				printf ("CD-ROM tray open.\n");
-				break;
-			case CDS_DRIVE_NOT_READY:
-				printf ("CD-ROM drive not ready.\n");
-				break;
-			case CDS_NO_INFO:
-				printf ("No Information available.");
-				break;
-			default:
-				printf ("This Should not happen!\n");
-				break;
-			}
-		  if (slot == x_slot) {
-                  status = ioctl (fd, CDROM_DISC_STATUS);
-                  if (status<0) {
-			perror(" CDROM_DISC_STATUS");
-                  }
-		  switch (status) {
-			case CDS_AUDIO:
-				printf ("\tAudio disc.\t");
-				break;
-			case CDS_DATA_1:
-			case CDS_DATA_2:
-				printf ("\tData disc type %d.\t", status-CDS_DATA_1+1);
-				break;
-			case CDS_XA_2_1:
-			case CDS_XA_2_2:
-				printf ("\tXA data disc type %d.\t", status-CDS_XA_2_1+1);
-				break;
-			default:
-				printf ("\tUnknown disc type 0x%x!\t", status);
-				break;
-			}
-			}
-			status = ioctl (fd, CDROM_MEDIA_CHANGED, x_slot);
-			if (status<0) {
-				perror(" CDROM_MEDIA_CHANGED");
-			}
-			switch (status) {
-			case 1:
-				printf ("Changed.\n");
-				break;
-			default:
-				printf ("\n");
-				break;
-			}
-		}
-	}
-
-	/* close device */
-	status = close (fd);
-	if (status != 0) {
-		fprintf (stderr, "%s: close failed for `%s`: %s\n",
-			 program, device, strerror (errno));
-		exit (1);
-	}
-
-	exit (0);
-  }
diff --git a/Documentation/cdrom/index.rst b/Documentation/cdrom/index.rst
index 338ad5f94e7c..e87a8785bc1a 100644
--- a/Documentation/cdrom/index.rst
+++ b/Documentation/cdrom/index.rst
@@ -8,7 +8,6 @@ cdrom
     :maxdepth: 1
 
     cdrom-standard
-    ide-cd
     packet-writing
 
 .. only::  subproject and html
diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 061744c436d9..6a0dd99786f9 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1183,85 +1183,7 @@ Provides counts of softirq handlers serviced since boot time, for each CPU.
     HRTIMER:         0          0          0          0
 	RCU:      1678       1769       2178       2250
 
-
-1.3 IDE devices in /proc/ide
-----------------------------
-
-The subdirectory /proc/ide contains information about all IDE devices of which
-the kernel  is  aware.  There is one subdirectory for each IDE controller, the
-file drivers  and a link for each IDE device, pointing to the device directory
-in the controller specific subtree.
-
-The file 'drivers' contains general information about the drivers used for the
-IDE devices::
-
-  > cat /proc/ide/drivers
-  ide-cdrom version 4.53
-  ide-disk version 1.08
-
-More detailed  information  can  be  found  in  the  controller  specific
-subdirectories. These  are  named  ide0,  ide1  and  so  on.  Each  of  these
-directories contains the files shown in table 1-6.
-
-
-.. table:: Table 1-6: IDE controller info in  /proc/ide/ide?
-
- ======= =======================================
- File    Content
- ======= =======================================
- channel IDE channel (0 or 1)
- config  Configuration (only for PCI/IDE bridge)
- mate    Mate name
- model   Type/Chipset of IDE controller
- ======= =======================================
-
-Each device  connected  to  a  controller  has  a separate subdirectory in the
-controllers directory.  The  files  listed in table 1-7 are contained in these
-directories.
-
-
-.. table:: Table 1-7: IDE device information
-
- ================ ==========================================
- File             Content
- ================ ==========================================
- cache            The cache
- capacity         Capacity of the medium (in 512Byte blocks)
- driver           driver and version
- geometry         physical and logical geometry
- identify         device identify block
- media            media type
- model            device identifier
- settings         device setup
- smart_thresholds IDE disk management thresholds
- smart_values     IDE disk management values
- ================ ==========================================
-
-The most  interesting  file is ``settings``. This file contains a nice
-overview of the drive parameters::
-
-  # cat /proc/ide/ide0/hda/settings
-  name                    value           min             max             mode
-  ----                    -----           ---             ---             ----
-  bios_cyl                526             0               65535           rw
-  bios_head               255             0               255             rw
-  bios_sect               63              0               63              rw
-  breada_readahead        4               0               127             rw
-  bswap                   0               0               1               r
-  file_readahead          72              0               2097151         rw
-  io_32bit                0               0               3               rw
-  keepsettings            0               0               1               rw
-  max_kb_per_request      122             1               127             rw
-  multcount               0               0               8               rw
-  nice1                   1               0               1               rw
-  nowerr                  0               0               1               rw
-  pio_mode                write-only      0               255             w
-  slow                    0               0               1               rw
-  unmaskirq               0               0               1               rw
-  using_dma               0               0               1               rw
-
-
-1.4 Networking info in /proc/net
+1.3 Networking info in /proc/net
 --------------------------------
 
 The subdirectory  /proc/net  follows  the  usual  pattern. Table 1-8 shows the
@@ -1340,7 +1262,7 @@ It will contain information that is specific to that bond, such as the
 current slaves of the bond, the link status of the slaves, and how
 many times the slaves link has failed.
 
-1.5 SCSI info
+1.4 SCSI info
 -------------
 
 If you  have  a  SCSI  host adapter in your system, you'll find a subdirectory
@@ -1403,7 +1325,7 @@ AHA-2940 SCSI adapter::
     Total transfers 0 (0 reads and 0 writes)
 
 
-1.6 Parallel port info in /proc/parport
+1.5 Parallel port info in /proc/parport
 ---------------------------------------
 
 The directory  /proc/parport  contains information about the parallel ports of
@@ -1428,7 +1350,7 @@ These directories contain the four files shown in Table 1-10.
            number or none).
  ========= ====================================================================
 
-1.7 TTY info in /proc/tty
+1.6 TTY info in /proc/tty
 -------------------------
 
 Information about  the  available  and actually used tty's can be found in the
@@ -1463,7 +1385,7 @@ To see  which  tty's  are  currently in use, you can simply look into the file
   unknown              /dev/tty        4    1-63 console
 
 
-1.8 Miscellaneous kernel statistics in /proc/stat
+1.7 Miscellaneous kernel statistics in /proc/stat
 -------------------------------------------------
 
 Various pieces   of  information about  kernel activity  are  available in the
@@ -1536,7 +1458,7 @@ softirqs serviced; each subsequent column is the total for that particular
 softirq.
 
 
-1.9 Ext4 file system parameters
+1.8 Ext4 file system parameters
 -------------------------------
 
 Information about mounted ext4 file systems can be found in
@@ -1552,7 +1474,7 @@ in Table 1-12, below.
  mb_groups       details of multiblock allocator buddy cache of free blocks
  ==============  ==========================================================
 
-1.10 /proc/consoles
+1.9 /proc/consoles
 -------------------
 Shows registered system console lines.
 
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 35d90903242a..018b3d921f63 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -104,6 +104,7 @@ needed).
    block/index
    cdrom/index
    cpu-freq/index
+   ide/index
    fb/index
    fpga/index
    hid/index
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index f270080f1478..789093375344 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -12,7 +12,7 @@
  * Theory of operation:
  *
  * At the lowest level, there is the standard driver for the CD/DVD device,
- * typically ide-cd.c or sr.c. This driver can handle read and write requests,
+ * such as drivers/scsi/sr.c. This driver can handle read and write requests,
  * but it doesn't know anything about the special restrictions that apply to
  * packet writing. One restriction is that write requests must be aligned to
  * packet boundaries on the physical media, and the size of a write request
-- 
2.33.0

