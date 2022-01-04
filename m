Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08AA484749
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 18:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236007AbiADR5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 12:57:46 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:27880 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235991AbiADR5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 12:57:43 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 204GJAXp032284;
        Tue, 4 Jan 2022 17:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=9vvSaZAb0M7cO7U3VR1OF/mxDJJL032g8LxNmln8g/g=;
 b=Zysz0q0yo9RpZqfM/8a55JWIEVOKIb5e/gxRSEDSncsJH5XsPPu6y83NFMsdTSLOIzXm
 dVde/+oSZtpv1h0I3fiO/82gL9iV+gE52z/xBNTwrmGySO3N5WH8PPnMDYt/U5UNJCUK
 8yuMTWEC6UsEFDZSTnuvG1PcbOTRvLu0mSNne/rYWVViixeU8WBMiTVGiTPs8IMqKN5G
 7U5MdZpJU1q2qGN0wSkp5vdQA5hSmg4ocgMmwS9flxGQAMIrsszn7f2ESjh+Rx5/7Tz9
 t/7NSv9iFIF5HKbs53qKxbRTCFm1imgwm/iLf0mAWygDrlaImFyvIM1cEukjrGjtT49F hA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc8q7t564-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jan 2022 17:57:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 204HuwYe051397;
        Tue, 4 Jan 2022 17:57:25 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2041.outbound.protection.outlook.com [104.47.74.41])
        by aserp3030.oracle.com with ESMTP id 3dad0duexn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jan 2022 17:57:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtAOzh2zo3y2CB7WZ3FAT8GxdnuoG1dVuamr6wdKSPod+RitYSLX0B55ZWtm+aEBvBzfxcNrQ8FGAtDWfMSERj59HPmEY54u6p4u4qrPskX0yhoijjQEoaV8MyKBgaoeQ7Hic62AuDn3URjWkeinK1Whf0tFQXIZu7hrrSI3nKqRxF6KEjstlK7hZxCn7eKuzymzU6BH/XiPjLKlcnrxkGfgIdPiaybDidUIlBsKJXXti//zzRQotz8GkSwojnzcN8omFNI1OoQoiLV8gAU4h1HhSLax+HbzNO/zodwx/ydGdvOGre0KWuB5+Jdj+cP2jEIHNE3znujh5MWaSbrgCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vvSaZAb0M7cO7U3VR1OF/mxDJJL032g8LxNmln8g/g=;
 b=RTWAmhKAUXJ0JW/CHN2ztcGy37JGcCRYsg3I31fURs0J/ilUiWgvowTR7qeihgJ7XjtQudpvfwowHz+ilAOoyfN8oOGixXNoBsRfUzE767tJMqJqfb98wF7yETmEUJxevEW/cj5bXMcf59x1yZU8BsCbIwqtq1Tl0MFr1Hji702nVwIuSwSyyGYQaGm8GE2ppsXGgi+5LZZWzD6o2kCw6369REtLQRqe9YdvEPQdArpmzPa6C/yMD1zC7oYR1+vAPJwtUeaprbwebTyY6I0ZIuE2Ty/KoIHPzhU8dChNDsO8qAYs1dpon5WBceBU0MjxaYmckSsl2LkNs7/kLjTcKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vvSaZAb0M7cO7U3VR1OF/mxDJJL032g8LxNmln8g/g=;
 b=pFi/hUPTCC/FRt7pNSHJc3IRiCC02buiew2jXCCZd9vpUdew1GWCpwKe00LpGlHr+ocfePeNaWicId4xPuNpBPomn1sDCNnj/36Ld3BV4lbJpEoNP3EBBQgbiZXNDKV+Fnuj4nHXxKukSWz1Mv7kNuFHKxPNpY1d93bsxUYu0cA=
Authentication-Results: orcam.me.uk; dkim=none (message not signed)
 header.d=none;orcam.me.uk; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB5724.namprd10.prod.outlook.com (2603:10b6:510:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Tue, 4 Jan
 2022 17:57:23 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166%5]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 17:57:23 +0000
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
Message-ID: <yq1tuej1j22.fsf@ca-mkp.ca.oracle.com>
References: <alpine.DEB.2.21.2201020010540.56863@angie.orcam.me.uk>
        <alpine.DEB.2.21.2201020030130.56863@angie.orcam.me.uk>
        <d9eaa1f8-7abb-645b-d624-5069205c6983@interlog.com>
        <alpine.DEB.2.21.2201032017290.56863@angie.orcam.me.uk>
        <yq1tuek347m.fsf@ca-mkp.ca.oracle.com>
        <alpine.DEB.2.21.2201032324230.56863@angie.orcam.me.uk>
Date:   Tue, 04 Jan 2022 12:57:22 -0500
In-Reply-To: <alpine.DEB.2.21.2201032324230.56863@angie.orcam.me.uk> (Maciej
        W. Rozycki's message of "Tue, 4 Jan 2022 13:52:47 +0000 (GMT)")
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0172.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::27) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff1c3be2-629a-4f09-6694-08d9cfaba94b
X-MS-TrafficTypeDiagnostic: PH7PR10MB5724:
X-Microsoft-Antispam-PRVS: <PH7PR10MB5724C37476AF44E9D18FC7CE8E4A9@PH7PR10MB5724.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JVng2szpC2S2oxY8ZU8qXLhMu+b0jLQgiTayuRQ0L+dtAGSBKjwy3/1mu1QSfOAXqSCctA/tSSGAcFZYhHN57Nvkd4rFSS0hGUNh3PXfceisQ6jZjcMM/kerKAI6MVd6h0SVamPqTpFo4vw83gpS1gKySMrL9u/FrETE+fw05/jYyhrsx5vBvnLmZ3+WTLW3ueTmWo6LD2wn6n5ayR8+e4gfnkEqrPL1KrcFpZII3OAmY9eRp9MwcRQ8NB3gZuTwR7T2Gj/Ya38jq7wObEULLCtKcYgcMK8rmWzbqS87F8YhfgfUSPkfR4gU3Q+uYRGKu4nPN720Svq8eljPFGy4ywRIoKJAvAIrnE7FBbSWjYlhKLUwPZbgOn2QSgim4a6F3K569terV6QRUprSqAFDS8rV9FCDHX57bU6n3Gu2EECpIfhcIujGQf5rN1sM/1IpsbwCeKDVgnnur6ujE440FlFtr3vTEZmkgv8foVFxMpt/dcxnYNFICfLG/QxgPNdEdRl1LoSgZZc070ynV9oZnSo3j84baym1Fa/QMn8OLyPsl+j2rwGPqIxDqpTnKT5FCkkt9a5t339KOKILQU6VmeU/Q+0kcNDj7oYCj5GSJ9tfvwgGDgKohsfQRpmoAPxkziu8foXtZPOg3vB0t71ZAxHws1mqpmckQ1w3G1b4LMh3JovZMnIFmB3h1NOL6wiLLYK5e/hdx43nW0fDnZZCbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(52116002)(316002)(508600001)(8936002)(38350700002)(38100700002)(2906002)(4744005)(36916002)(8676002)(6916009)(5660300002)(86362001)(6486002)(186003)(26005)(66476007)(4326008)(66556008)(66946007)(54906003)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mapa2Z+DAMuye/HMkDpowzceq8nMJkUitNvqtn8QFCOTCYtt3sm8Bg8s92b7?=
 =?us-ascii?Q?VUkR7+c4kolKI2z6V+dPAVQSTweUenbzBxI0SvYU2PXHer3GcF0PJnwz1SuT?=
 =?us-ascii?Q?MBeduoswSuxOiyfCbyqStRiNvFXg3cIs4rRFUzELkQFy7zQSIwvyW8FQrltq?=
 =?us-ascii?Q?wtVn6fhDRKMbwJZ03SQp7vb13il6gBOgew05uTQC1Y6GOOrux1Dqi5qhT2dW?=
 =?us-ascii?Q?XkPQJ6GEn/8hZIUjEbbZaUHfj3KvWl7ffGsMBJFCwWlYKa3dZhIBHOsnxUiH?=
 =?us-ascii?Q?9Funb5BX1SHjUDwMAvN99KavVKe5Mxhttu6LL/waAAs5pz7AelReKwTDe2W4?=
 =?us-ascii?Q?XJVSGFkrD+7HE3kXRZk1OIccKk0VKWK20lZw+sF5MDzdQ1YGyApX9H45P0Ad?=
 =?us-ascii?Q?+2B1XHEWe2mu2Os/8H1p04ZQzAWTMTF6RzuOouCDj0GWjbwgUDTm/srM2nM8?=
 =?us-ascii?Q?wNrlbzmV5uCufGO/nE3cKvbXICq3kmevmFsuoZBvyNY0uPMF3iJWRfvexTpZ?=
 =?us-ascii?Q?BHPC9e0+wZlyciYrA9915Nn3xBS9T3HtqJK4OIiTveIVTzYkwvHkU9SIWoBr?=
 =?us-ascii?Q?2DSrACFbM8jkQYh7xS4McQBpaHoCRewbad9Lsfd9a4uRbQ14kIpuAYOYr3nY?=
 =?us-ascii?Q?MVR6h8zvNeVW8Q8t+vNOv149d2xDB14XkTM0xvuZzxuhZbqdh6et6AkjDbIi?=
 =?us-ascii?Q?tOjqRBoiL9l+7Zgp5IOLV9NWO9md9u1+SX4fiFKA1HTOUBm/vQ18EqfVcGt7?=
 =?us-ascii?Q?NIoBokHnlDUmrHB/x/PzYXnzb8BnuilEQ1RPKsv4Yf+MXlft3TCMeGVJRAIv?=
 =?us-ascii?Q?cLNU91APiLocoEw5+iI9M8HfEmDE+Mpt9id47FPIMDOF3dS/FzEJoonkYS7V?=
 =?us-ascii?Q?j7l6nmrDr8eY7xT4kCAd7ib0x5mrmLTC5iZ0and3Vh2PF/WaJz8BEDFuY5UX?=
 =?us-ascii?Q?d87FycEt1cGQCoNPWYPLWO5upBw9MBY+aO3N0Md6yA4yQBozzeoVAyPBX1IZ?=
 =?us-ascii?Q?OSREGllQ6IjjbEv7zed0aXVh1OkP5CMOe15TT/vri3Q9Gj48yTbBEbd7xm11?=
 =?us-ascii?Q?0OpVb02qx3YrT5YxePUKuhBuTalGx20MID+kaJLXiK206QAHMDRH4vaIMXhp?=
 =?us-ascii?Q?oLDUsWQlctV2LNdXoc5PNhK7qR/Jiud62MZVhxMdpgKRejKAlGA+YfOipbaH?=
 =?us-ascii?Q?tJ6yqbomMGLtPVV2qGaA29YUCWzeGLjefK8mYT7v/vuA5NRjm6ZrNtNB/A4V?=
 =?us-ascii?Q?vw2kVLHRL4ycHqoA73R/mh4EK0oYSf7UOgW6lAfIsGiJ5L3BJ/2iTqTwKRm5?=
 =?us-ascii?Q?hM/V6DKj3asB54JDcMRaaAhaHPsG5xjXse4X9pMcvXVQKqCMTCNltooL1DlO?=
 =?us-ascii?Q?OaTVL0F1DpMrFdIDppC58pkpo6QBgdilyU9BKJmXx668VTXXssZAU743sY9z?=
 =?us-ascii?Q?CjUH7B977jbnPHsjzbwDnAjimXLnnuj4VUh6iluJR06/D8D9UqefO6tPJbcm?=
 =?us-ascii?Q?2uZvZWsCfFL4PMnEO6ybRtS5FGwV7QLpdYN2aM+A/KSNnuD30jefwDktK6RP?=
 =?us-ascii?Q?9rVgqM7jr0E9+t0Frr84DDcTz6DhFcVQTCFz90TtN1fXvrhzRjLMqYnG2n5j?=
 =?us-ascii?Q?1R9+MV8/BrgleQhQrtdgNHEdMCsAcRDBDjyH6mKT+A0/mNYtBQVgwOx+pxN7?=
 =?us-ascii?Q?0vit7A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1c3be2-629a-4f09-6694-08d9cfaba94b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 17:57:23.7846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUhjUFmPM1bewcip4rQ8fqkzqURKJ4y7c/PzY/zQt/EnZEWyzhPinsvzuB0fnBhEBp2lSq3RfvzcNl8pV6yf6EJfR8ZnIR6JENDQgh3DpHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5724
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10217 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=972
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201040120
X-Proofpoint-GUID: gZwwvqMKrVs4A4be7rsNgyqrgqHjZnGR
X-Proofpoint-ORIG-GUID: gZwwvqMKrVs4A4be7rsNgyqrgqHjZnGR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Maciej,

>  I have tried it and it's neutral, that is with 1/3 applied the HBA still 
> works and with 1/3 removed it still breaks (2/3 and 3/3 obviously don't 
> build anymore).  Unsurprisingly, as it's the call to `scsi_get_vpd_page' 
> rather than `scsi_get_vpd_buf' that causes an issue here.

Oh, you'll also need a follow-on patch that uses the cached ATA
Information VPD page. I'll try to get my full series out today.

>  NB you'll need to adjust drivers/scsi/mpt3sas/mpt3sas_scsih.c accordingly 
> if we are to move forward with this change, as it's another user of the 
> SCSI_VPD_PG_LEN macro.

That'll also use cached information in my series.

-- 
Martin K. Petersen	Oracle Linux Engineering
