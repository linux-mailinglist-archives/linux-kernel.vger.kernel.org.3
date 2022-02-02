Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356034A6AFD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 05:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244546AbiBBElv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 23:41:51 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:44568 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232288AbiBBElt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 23:41:49 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120PI7x004733;
        Wed, 2 Feb 2022 04:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=DfKtaeoGJxKB+p/6iMYPu9Wi8VVKptVJLLaGRsP9mdE=;
 b=MrDmzgJLKrOT2r+KeUWqKW1WFXZVpKv7JZ01KYSsFpmvp5HfVdb8yP4wDeHQUSTv+I3Y
 k4jnPTHe12BiKwHBDOLxwLHh4Q28lm64YLYlvb9J4QYuFTA0XEN39sYPhgpMQavPsf8C
 HI9CwDSyDYkkc+VEECHhytTXvA9tXwkemqusC78sdck5QCJf0TgWFsoaWSGcsTiN+/K7
 fHIgDwvouADW8TLSBNuzZQqSy3b2FGz2T0S0mr3wVQR/HgV48PkVg+qPzBdDOaD8/sSK
 d+6WTWcb+Iz8Sqns21HeywGUEIfjE3fZXVkO+jxrFLfOo2CuLzKugR/uuMv7D7IWRQcf Hg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjac4u87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 04:41:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2124fQpX067016;
        Wed, 2 Feb 2022 04:41:37 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2047.outbound.protection.outlook.com [104.47.73.47])
        by userp3030.oracle.com with ESMTP id 3dvtq1rdw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 04:41:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVebla0vLACc68aWaoX+MPrtWzECAmK9HX9AZv3wb3GYAhZHHnQgQwuwjW5YvLv9UScmFSVEWbwC13XGI13qUbyJCUTrbVXf+lzMbgR3LXBajW9LDu6AXwVaT1frQYDZQ3fKfneZd2RiQgi/ORkFhzjh7R3zT5UKgHxDQ6nUSKU+z6hYxF1GptUp52AECug+ePb5Hz7vnlRi6wpc9PT6MldfK485rqxAeWyoPNiz1DhjhjF1/38VkrGQ9aAjEXAkaJU4BsI2OMuGGOnF/pXe66NfshWBoNlkcoUq+/47WF2FIp/zVJAhbmSvxYYJW+kSxlKmLg6mEuo9YmIyGk5bcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DfKtaeoGJxKB+p/6iMYPu9Wi8VVKptVJLLaGRsP9mdE=;
 b=OAn5YHwNoxhg7XaB7yPy8f0fSVxlKfXbU8kfw8eOO6iw+vh4LsDZtQwFvt8HrEk/dv2DpdRmx8/aVyK7ytKuxBU7NvOY4yrMjiUgz1qIEfe4H6F9qEh8xvU9TDtxY2CiNZfLktSFfkquXpqnxRRSae9Rqq6SbVRdpJUVWhUMoWuinWdeKr09fqIsSCFOEefOA3oShWZ6ImqZ5BtINid97q5IICo48UXNDcfbjJmFAmcIvr1t9ZOA2G2QL7UjxAcyd1B4jfyZr9Qf+SOQVSMyU2TbrloZMWKBdDy9dLvdKuE+vUz5Uq29lHfP5CuYY+/og+3rXUm3y4873D+E/hLsWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfKtaeoGJxKB+p/6iMYPu9Wi8VVKptVJLLaGRsP9mdE=;
 b=I+gBfEg0AR6G4gpToJvA3Eoypc1Ix+bhKmT3ZuBVd5w6geZRq1wJglD1uyEYWdyVy7g8+IcqlFsklZ+tAQ5OPSHDTZryaGVN8KhSLYL/+Jr3GTp248H+/8KU471y6YHMNgXROYUeQ1cQbbU9rFM0jG1lv1oYHeBkLpAMfklCPhU=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH0PR10MB4844.namprd10.prod.outlook.com (2603:10b6:610:c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Wed, 2 Feb
 2022 04:41:35 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1caa:b242:d255:65f3]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1caa:b242:d255:65f3%9]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 04:41:35 +0000
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        martin.petersen@oracle.com, colyli@suse.de,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv2 5/7] asm-generic: introduce be48 unaligned accessors
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1czk55195.fsf@ca-mkp.ca.oracle.com>
References: <20220201190128.3075065-1-kbusch@kernel.org>
        <20220201190128.3075065-6-kbusch@kernel.org>
Date:   Tue, 01 Feb 2022 23:41:33 -0500
In-Reply-To: <20220201190128.3075065-6-kbusch@kernel.org> (Keith Busch's
        message of "Tue, 1 Feb 2022 11:01:26 -0800")
Content-Type: text/plain
X-ClientProxiedBy: SN7PR18CA0017.namprd18.prod.outlook.com
 (2603:10b6:806:f3::34) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26736384-c675-4ee8-3544-08d9e6064ae0
X-MS-TrafficTypeDiagnostic: CH0PR10MB4844:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB48441CFACF940ACFEC48AF478E279@CH0PR10MB4844.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X0nGmdhrMEVxay7FUMIpd1gbb46JQeIi0xNj09+mvZ4nG05EPIsb0Tk4d37MxIGCKy8m/U+xqhS+lZo45JyMo/zLR4nngrO2OG42kujfkXjJdhfVJ7DOK22gf0P8hv5KlobqkNyFx+/4ipb2/nSlqXnySLaFBz+ecyv8nPzRqK0JvDX3EOSFwwI+mGoDPMpklYNX7zvNj4Mhb3YE1VMuo7lKOikWTY5OiV4EY8F1Lcu8gS2Ntr/tSSHb3yXjUt7SBDlLV38hRzgqLc1W2QSI3dYEPQvmx2rRXOVf0OGfTnUq4EGnGxvX9qapzb5TqD7r83rYaNsrp+Ta46dzX1jXy8aXukSuJsNjkN2gWQkcrKCY5XN0xxhbNwi36J3qA2YYdKK4gcOUej/nJRN7L0pGR/8uFlk/5Tg4ZZgMyJ077so08exMnANRqu9ldHRE5QWXwH2WAZzTe+C7RoYJ8NAKQ7NPVDydTVbONHu9+Mk8xbzwQGwQYJKVB1VeYNaTp4MYO/5SysThssqdXc7GA60MB/tQKMTZxNZPLKMGCkQPjA8L7Bothwzwn2TbJL0NJTMW1FKi/HVBE7KmNUltMPBTHTMTtOMwaY5v3JAytBx/aDlQ/FtkaZIliHv8R8F/Qd5/6+FjwqxOxaZ9HEQI46ZiKAj8ezeCHbL6iG38avOYaUsgQZvaMSddjm7xY41efhWguO2s1fErYi3vorDox+JAcGMP2P5qxppwCeSd0Y8+Xk0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(6486002)(6916009)(316002)(26005)(186003)(2906002)(4744005)(66946007)(38100700002)(38350700002)(66476007)(6512007)(36916002)(5660300002)(4326008)(508600001)(6506007)(52116002)(8936002)(66556008)(8676002)(86362001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3b7qF+/p6BmrTTaNhXp+nEBCwnqCWxfIueRZnoneDvSHyTPo+654iqxoXqhB?=
 =?us-ascii?Q?rhnr91zAYAEUG4AkJqQAF67970SPTeCitdQlB+OR0NGLPsA+o+j1dvNaI9hK?=
 =?us-ascii?Q?sWX474wJYgvrfv5EbLCa9GDnFD3YRPgoN2PnPX6Q3asj9QWYxJcYdu/w8UYk?=
 =?us-ascii?Q?q9cM0BU+JV0oUlCuof4pcHT7nqQ26fs2JV3q+X2Vbsei3hb1MU+z97Gq0/m1?=
 =?us-ascii?Q?JAaHAPAAEaNV3JtfsBdQxHlTdWWTG7rCXyaRGBUx6Cv4v87nutwQSI20p3+E?=
 =?us-ascii?Q?mCgBcEQKigKnCOdxWHBPSt9U8Fsc4vlMUpOmM7BtkghIT31TFmlRULBtcsYv?=
 =?us-ascii?Q?1Y/SM5AwfV7ClH3qoMQKMGJ8tYtunYFrK1KUjd/Gq9RJrLEt2WqU1deg2+OB?=
 =?us-ascii?Q?Rg5oWSZV7XuWcSFLxJ5jnZqO5LKbGtBAjA6pyDg61WrUkg+VL327bLWNatT8?=
 =?us-ascii?Q?jie3j0gC+Tx/Zt72U1H/4EDLVWJvzQNU+Tetn6gmTHUHiJkhtk+7baAx+kgI?=
 =?us-ascii?Q?47Plwra56ygFy1dfxKVlbGogwE9z9MTxvW0VSd4SbtQXzfboHLSelVmSfxKa?=
 =?us-ascii?Q?JTZvuBv6EUQDiLmKj1KtgH6B0yArxq96WgvNtM9uH47DA5od1M8VgqFgeOO8?=
 =?us-ascii?Q?oitPpmEWYKGve0+oTIq81ixNoW0zGhKWQu0ZMf/DukKxbjZDdMrKW+NIbLjL?=
 =?us-ascii?Q?rWaKc8wTD3fLfc3Qztt59irbjKxdMjCErcXmlCf2YurUCB4Qre8XH5+QNrXB?=
 =?us-ascii?Q?fgpPmx7ZeUmiZl+ZBTRXRQ1c8BJgEAgcXVc7hSIogguvKD9W4ZTMp6thwNZ8?=
 =?us-ascii?Q?NcbNaKXKb0u9SxaC0t7bYkEMgKKYm44aVIai9yIXIorg+Di1rhc2ysjVDyvR?=
 =?us-ascii?Q?+4zk9bvHv4Vn+n5B90jjfk0ARR1+s5M0deDvzMnfvamAw/++Br3ftWlCmCqh?=
 =?us-ascii?Q?UtRSr+2eWQp3dJ1g2T8Oly2bywOx1BkRVeeYtZi7eruYhw/9qnAgw7m/W3u/?=
 =?us-ascii?Q?T+S9ccLwyvUxcf1CJMPODUTcviaD4zt41opSNYQWP/qqwePmWBFUJf9QDh94?=
 =?us-ascii?Q?1NSjpUKMXllo0Pb+TB/LLRz4L8EeZ1pbW5ynxkZNjSyX5tgnAVrsmLI+KrCV?=
 =?us-ascii?Q?fy6kfXLcKH4aVmzy3xmvTTt2RaoZO4GK5v7xZPw6Dgw7dYPHyjD+2VNn99P8?=
 =?us-ascii?Q?Eov3qzxsNgVGxtUP2vLLflzxofNp7Qowb0BgRYNnXSNuIlNqD7+IRxSbrTMz?=
 =?us-ascii?Q?ly4H1X44lFFT2LfaMZ4srxjnrTDHayibo3C8DmT7qWbU8XoPXxWya9IDTelG?=
 =?us-ascii?Q?idavXOK/NA+PYt+zxlIlZpA6puopVMUv9FK82cOdLWssbLgWJQH9ZeV8V2z3?=
 =?us-ascii?Q?Eevd6PAmjEygzDqFXuw31Q6IFali1CHisfR+KW0WxQEw/H3e9roO5r96rDmn?=
 =?us-ascii?Q?lO20zlYp6AOimbpSFMtlOujL77CJ2mCV6iI03wUNy1JpWK47XQQt5V6B+jui?=
 =?us-ascii?Q?KUhn/wkRuQdSS/1BfeEd412F/XLIBoa6m8A/qNTTReSGq1TArxasWLnjrFwM?=
 =?us-ascii?Q?cq+vg7A2+IeSxQJ+G1o8rqEObmKm3svN+Ur8R+0jw6aq3EVlw/J/sI8LstcZ?=
 =?us-ascii?Q?v+Jh4myJGIa1OUidQe9KQ14bjS2acnjtsCFOlYJpHbHy1GiFZz6VU6ydxSK5?=
 =?us-ascii?Q?EaBfPdYGTThwXZJ2CwhS+RfIm9w=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26736384-c675-4ee8-3544-08d9e6064ae0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 04:41:35.1285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YGSIb/A1NGWRTI4ZT6mrXH/wdLlsWskQrHgMBbdWo8bHS3Aqzh/9xdSEZL3FRs/4heN42xdCsFaSOB1B0unQR5rqNdBBzWYnxf9Bc1qanTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4844
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=712
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020021
X-Proofpoint-GUID: PYeNO5h4116lcnxHpgJRadsUCR1tz2Dp
X-Proofpoint-ORIG-GUID: PYeNO5h4116lcnxHpgJRadsUCR1tz2Dp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Keith,

> The NVMe protocol extended the data integrity fields with unaligned
> 48-bit reference tags. Provide some helper accessors in
> preparation for these.

Looks good. Needed this a few times in the past.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
