Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A73489C90
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbiAJPtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:49:15 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:1690 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231592AbiAJPtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:49:08 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20ACrflf001305;
        Mon, 10 Jan 2022 15:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=aD2+R802pVChTdo4S2EM1+E/A946IzSicQJQGyGpGkI=;
 b=DMGGMGf24K9RgBnZPPKr0AVBWobWjnbP2XmrFgtgXXHjLBkDUir9ItvG7JGu45Xs+CYg
 qoYXj7kj8Rfw0GT4hd1qLftmnvPN/HW5rQvF+Mk2M5YiJEcKeq8pDNrd+CXmCKYZgDvW
 dAAOMirYTbOSRmpYBQB4dyV7q3ue724YtdNHiG0V/KG2auITQKafLc4/FU2g19k65SXS
 b+Xgp0jskBSrZ4y/ZrsgGDfH7xJouKGz/TnXwHJesLqLMSeTD9cW47COrIeWOlWpukOH
 u9MzNCoB86Ffy+zSCRMVs4A6P2OIvvLusd5jETt+fL+yFHrG/tz4RRX0Osui6kd92ihZ mg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgn748f0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 15:48:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20AFkOoC173611;
        Mon, 10 Jan 2022 15:48:51 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by aserp3030.oracle.com with ESMTP id 3df0ncr63u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 15:48:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFB1pZeefdGxa7R8X7WPaKyV0WzRDUZ7Vrjl5wGSW5Ckp/Gjs9JqO/PDcNaQ/5t9ArQ79N7VrsVHN15nKZTrnLvi9/MKaRv6AE/Elwe2t9JDJKIx3HCZhtKO4UstMcUSOJzc3UVorcN/DSug1aN20HPCgj4MRtzCvoBwJjE2L6VRSLAwFqz0RoVaoWwpocH/2nY3steFqmIaaFOaYxOLlH79pNfH1JUf69iRcTSRPfdZVSZ2bc3y8BIdbEcCYSdqKTbPMkystg/RvMfvZyKh4m1klrHCFTJ9vS9SQcMqeuIKNDVMe5UV7wYaCGiejUXT8BgMPBCnWB3r+t6KEaLPlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aD2+R802pVChTdo4S2EM1+E/A946IzSicQJQGyGpGkI=;
 b=nTOXYvV/ii87MkVgaZe/aiBWujN06AZk74tjNJKnHamRGWMeoujz/91BfK5DKUhmhrX03PcfJm6H8O6XjkPYMp6JvcVR3S0bNCu5tOOZXrWLzMBremCiKUkOJmlAEmf8UYn4u2GX3BJqAJPEpXP7aeZVKWIaBAjA/pn8KBPJ4BPc7SEjQYmhZ1U1WVBnC/8b4A4wTEGta8960xXtDnKzGFiDwvK3jIl7drBzEfzDx6IV0eaEZ76HDBr9q9MHlE3zLoprWfoRUOTVQO5ZCwX3TL52K7lhT6Yqsd4O1qxYImQ5IxZKiDaau8DE09d/SHLKnUdtr0oYanmGc0iFLo6AXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aD2+R802pVChTdo4S2EM1+E/A946IzSicQJQGyGpGkI=;
 b=y0uaCnoL3e5NuiTAQf0qYngZB0MsHiXM+CUeYxyFIQRX/A88styNokSBidbsJ+sUImz+RGzolWXZV/YDa/GYcyW7R1Db8GYvfOkOKYS8RaKPSnwESCX13TDWdNPG35mwSf6pM1lRK3OFSaY5E99a/yDtJ5rRWyeDWqyMj5eTJt8=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4631.namprd10.prod.outlook.com (2603:10b6:510:41::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Mon, 10 Jan
 2022 15:48:49 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166%7]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 15:48:49 +0000
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
Message-ID: <yq1wnj7sicu.fsf@ca-mkp.ca.oracle.com>
References: <alpine.DEB.2.21.2201020010540.56863@angie.orcam.me.uk>
        <alpine.DEB.2.21.2201020030130.56863@angie.orcam.me.uk>
        <d9eaa1f8-7abb-645b-d624-5069205c6983@interlog.com>
        <alpine.DEB.2.21.2201032017290.56863@angie.orcam.me.uk>
        <yq1tuek347m.fsf@ca-mkp.ca.oracle.com>
        <alpine.DEB.2.21.2201032324230.56863@angie.orcam.me.uk>
        <yq1tuej1j22.fsf@ca-mkp.ca.oracle.com>
        <yq1lezty169.fsf@ca-mkp.ca.oracle.com>
        <alpine.DEB.2.21.2201070039040.56863@angie.orcam.me.uk>
        <yq1sftzwstk.fsf@ca-mkp.ca.oracle.com>
        <alpine.DEB.2.21.2201090342130.56863@angie.orcam.me.uk>
Date:   Mon, 10 Jan 2022 10:48:47 -0500
In-Reply-To: <alpine.DEB.2.21.2201090342130.56863@angie.orcam.me.uk> (Maciej
        W. Rozycki's message of "Mon, 10 Jan 2022 12:00:03 +0000 (GMT)")
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0021.namprd15.prod.outlook.com
 (2603:10b6:207:17::34) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32b1b8fa-edd8-4b3b-0541-08d9d450b1c7
X-MS-TrafficTypeDiagnostic: PH0PR10MB4631:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB4631AFC677AB9E4839450A6E8E509@PH0PR10MB4631.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K+AJ8oOCy6c+6bYu35gdLxkPg1SAMj+C+SfB6gMDse7IitgXGNh02VcR9wMqlynB8BM9v3GTUZ2/z2rRE62hqpFCHIgAPfE18zHFKVgbuOpxe5+SvfjC7FiXh3WYHha7xovFgG/RuIN7VgFcYQ5B3Ox4DYclgCyzAoqShvxbaiQa152zLE6ujsrkr+km26dwfXzApyTRVxqWPzg/hJ9WL1q/RxTT9BFe84RpyMercyAuPsl9dn5D1RSo7yqICKjELzuqwrR5exrGKcVXVe36W59XXRYXT8fgcNHnjZClM4Bbn5DGWeHHj72Wu3y/pIDI61OnME7mOODKjGSoFN8qb5rpmHwpGR3ikHhPoJnJbdgLN13mAiq+fAP9pT7b7m4D12N/GX39R5VaYGXahInrd9Rvm+QhdNQiErmKeRMLXDoYBeRTcjEcGbFyzvYj7ayXAVlkePpGQOVpBloY18hbkF4eH+9S3gJ9lukHZiDewF6tZ8JPqRv091ydiLry/Xx0KRkZkmb7zzwVns+GfGtd9UOozqq6YH6Az7xTHcgYVvcW4h1ThwnATUCMep8+O2DU+VK7WBOvX7q9BcnxT3rNjF4tyh8I96L9gvEQFUofmi8TGq4fWO3wpHYEZWE0QoZcbtxWqwgP1vFFJ+XyEWHhR+JmkWrtMjqRDUQ+fsO0g3dZM4viKDXS9EhtXF8hJLeJVP/F3iGgnM9Xtarn2WolxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(4744005)(66476007)(66556008)(6916009)(5660300002)(36916002)(6506007)(52116002)(26005)(186003)(508600001)(4326008)(38100700002)(38350700002)(316002)(2906002)(6486002)(6512007)(66946007)(8936002)(8676002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HVU0+l34qcnLenWmC6PkC09Rz0yjDpNZlPnSWz4jQKzMwVmELrp/KL7HeJE2?=
 =?us-ascii?Q?zyC7NewQmAa/DBe9tPvsYiEdhpKUL0e6J9pURLDYVMrI7+2qVDDa/6Q4E9Ew?=
 =?us-ascii?Q?C29B8N64ogDqTPVwDB70/tVf97kHVRR7Nb4UEATysD9B8arYTrJVRxmhzVju?=
 =?us-ascii?Q?WogHuqbslWjBTuFruCQ8yohDAeuiX+UgZCdqFk1NPjrInaB62dAMcnMGC5b+?=
 =?us-ascii?Q?GDLMvdsUw5OMB/ZLmPskFLSx3odaLb8aQO3aFviqirhfvOtg/R/tKyatHJpg?=
 =?us-ascii?Q?02On1bOQ1H5n4gVA38eQhuBDNb8sLRh+bbkcgEnYFpbIHworwVZL0rdkJ1Rz?=
 =?us-ascii?Q?g263tp4mo6HyeKoMa9kkGQ3MWOaAOC+5WcjxsxSxhYhCl+b2PJ+CWRFHq4I4?=
 =?us-ascii?Q?+2C04jz7lyXdY1op8k9DJNnlw/dHy5CYonYklFRpEIRjjXxwQBKGHGctQYzI?=
 =?us-ascii?Q?KXpzgq5ESYyQTWWkQ5BzVLmvX26NNmVg4QyvCNEIslIbMG7muH6YLT6AvGhD?=
 =?us-ascii?Q?EOSaD4IjRg36+uOGr6ZPmrXX+jDe0HyEinVdib6VoYYfranySrNQ6hJQ16Na?=
 =?us-ascii?Q?U+oSeJinCD25qg5Qn7Yujy21ulwUXn3RpLcyCBmdS4MHUOvQSHKAJoY0xF/B?=
 =?us-ascii?Q?ytp7Y0LR+GWTqv0wRRx8HpNF3Wdo+jDyp0F675+sqgXsk1/2jwvQ7YkGD/v1?=
 =?us-ascii?Q?wO6mAm/Ul9Q3Cbv2wvgugTC/fezpNi22WlZNpFX8Z7rt4VBaXOrly8dzv7b5?=
 =?us-ascii?Q?ZAwg8+Osrtggpl+H01DudLNUYaovWSIYLstPZTDSq44BQ6Dqh3tdGqlNMQ7U?=
 =?us-ascii?Q?SKAB4b1q1N3R613TjlG0YEtRr7SPYsI3osfwXboQWos3WdowpQTxT28igeW9?=
 =?us-ascii?Q?K7ov1IVd+FvFDrBay/9zhc9Uc6Mw2kqlULV0WQ7+L7dHX5PtE7Zg1rcWG4ik?=
 =?us-ascii?Q?0cKPnnCfoEhlEvmBTV+czva0+oXd+i2gy532oALd3fBc21C+BDfCaMBdFhf6?=
 =?us-ascii?Q?mToW4Rl2V9swQli66SJI197DUA758Ur67IRXFAjpYmh2FXtNdNc/k88jIjqN?=
 =?us-ascii?Q?OkkUzK0GG/KaaEJmPrxaEndef4pkAI3Ld/z/BGYcbTuL6VzCmQkAwwWsFa2T?=
 =?us-ascii?Q?0jmSSHI8MKb8sXuqEDjOt5TKNrYrPt5TZdb9EWd89EfveZDqTV/aIlv1mqsl?=
 =?us-ascii?Q?r/zAHdOeuEeLcVzbAgq6/lljbb8j+LDMuVySLsGrsYZa33Zlq3IWEnAHb+r5?=
 =?us-ascii?Q?jfiXDjcP9zC14KIWkK/lecl53kgpzK2bBI1ZLTNQdS5GiYpAKLSxVjB2Dv6D?=
 =?us-ascii?Q?lbxNeK28batS/ClRPpJLtYtFLziTOYo/WlAlYYOGo9FyCGYHQV7kAea6KwwY?=
 =?us-ascii?Q?VzYd6eJc+U3RvjXqz+UIcunfUq8QMLQZUGGz8WqCECVJkmna2rfZ+qisb6Pu?=
 =?us-ascii?Q?vowxMpt0a2YOcQzE+lhbA5wGvafY2ASWtoEWiH1B2dplc60KNccoepaI2R3t?=
 =?us-ascii?Q?6LWxVfS3MXP4G6Mz9hv4M72Aj4ufdg8LzKG5qdbONgCd0phi0FA17hNkESyA?=
 =?us-ascii?Q?I7LF+ba2LJnGKdMY8q5FSuUYqeuPqgVba+SVQa9GW4eB6DZ6g6cQ79mFn1xV?=
 =?us-ascii?Q?mbESAm//Z8ZnGiaGj5hP8UXvqMoM/qR5nZgHWhYZQM6WgForV/tAuubIZkl/?=
 =?us-ascii?Q?hd6nyw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b1b8fa-edd8-4b3b-0541-08d9d450b1c7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 15:48:49.5811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwUwYMbd/kdZEwKsszEs0XgWdk8dBXwESPn2U+m3ThI/kQfka83KtmXmlJvDI52BVcG/EN4X0gVyj7lfZHUoZtYMXW5boBybVoE1eh6trGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4631
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=964 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100110
X-Proofpoint-ORIG-GUID: h5RPj-70YsevrbGSVQ6kLXIPoaoEFxbX
X-Proofpoint-GUID: h5RPj-70YsevrbGSVQ6kLXIPoaoEFxbX
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Maciej,

>> For your Mylex issue I believe the first patch in the series is all
>> that's needed:
>> 
>> 06a471da0937 ("scsi: core: Query VPD size before getting full page")
>
>  It is.  Thanks for sorting out this issue!

Excellent, thanks for all the testing and for your work identifying this
issue!

-- 
Martin K. Petersen	Oracle Linux Engineering
