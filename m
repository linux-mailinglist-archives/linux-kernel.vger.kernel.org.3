Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3C74D9331
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 05:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238877AbiCOEDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 00:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiCOEDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 00:03:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7A247AE5;
        Mon, 14 Mar 2022 21:02:25 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22F3GoBb000826;
        Tue, 15 Mar 2022 04:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=BZxQBmDO2Xn6Nb3H4b2KyfjMb8krNVd/aUxFFyesY4E=;
 b=Ru+vBkSrCpkHDATJRlQOGeE+gNq+Jxq6XQ6kG1uUVHd1NopI9KzIKYzixjjBUvlzLES8
 fCmQF8sUB4tpnuXbNxdTK7/x6sbsrFr/I75PoLcPd0DwlPm+SIdc7VkMujscJ9sqdtpQ
 8N4s1PqetU96ufGcWKPKJaX5R/f8jPBJs5xF5ivsLtY+KKqBNmULS+SNmZwGlb/NYGz7
 z5UCECoih/+GOPmS9CePMDLSSvmualZqc9QDXYpBhT+zQsF714zEDA9QaDup4u6qrF4P
 DSADqicrfTs0Gpcp3Ylv8JZqzpyrN959yMmSmQm30Inum/D4ycsELFIHbFMVCGjwRMEv EQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et52pt2jt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 04:02:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22F423Qp015106;
        Tue, 15 Mar 2022 04:02:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by aserp3030.oracle.com with ESMTP id 3et64tc7p6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 04:02:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHne6VyyKD8EQLNArLCMSLocFlQIPYm3CGZruoEkw9u1RUp4+OUokfsIbB9Y8BcsU5YTyPSLaU5vOHMAO3aGlvXk7B5EXgZf3ANB8cR7bZQV5+wwNDWoNCzuzMC/uqIhecG9gXreInsvqEZMkOBYqzqJyYcLsZZywPN16oeAiTQMkG1Skgd/uaiaFi48F1hVQw96MgEBKWvAQ6p+xM3/MuynuVEiqyrxkN27nO5f8kaCU67FLYqRc5VJLbSpONS/ooMqZEWbpjwPaHpykVusYBHG5Ru05Jg5jA1yBifVQJ8aw4lm72Q+7IHzcat1q1Gt5nK/5a6JBY1z4RY8iHBQKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZxQBmDO2Xn6Nb3H4b2KyfjMb8krNVd/aUxFFyesY4E=;
 b=D63sXGvQTckRe+uIMjTI/3wZflCqIh0CnblZXEH8v3sBb6cYwRIYqb4vX8nHSYEkS6OA7Dvs0/a8nbOZHzlIm8WVwlps69MYGYZAsUyxgPUJK1ILt7ww0YallpN6IGG03Pn3pE2Zq6BRhE/JmWkn1Cammc0aAmZGljRnfkb6nFJQA/jkCts6EpFS7gAuiegGMMu82kWcZD/oGxs4/oLfAOPiOjcuWZNzPFTsbZ7dRzZqbsRAEiZOhylWAlKfo/bMzfFG62hcgxvkyAcO0DhAJm+PNAzAbXKCdWjxBUE43B3brUrMYOxm5WJQZeKF04y+0JDf6NxxaioTm6XG34MfhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZxQBmDO2Xn6Nb3H4b2KyfjMb8krNVd/aUxFFyesY4E=;
 b=BxFhd311S3JDJ0sYWigHRYZzQtQR3kMTPTWZI4xP13tNrHqTDSeyWZG80HiDP0wVHSrbMxAXME3MTO0sarz9asYRvIyY4mugbOhhDzL02ZommDjbkH4JR21Hm4k5PWOVdSeUixL/+SBmAh7L5Eylc1DTttgDbMLlwBy9+JeSSTA=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA2PR10MB4650.namprd10.prod.outlook.com (2603:10b6:806:f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Tue, 15 Mar
 2022 04:02:16 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed%4]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 04:02:16 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/8] scsi: aacraid: Replace one-element arrays with
 flexible-array members
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1h77zdg37.fsf@ca-mkp.ca.oracle.com>
References: <cover.1645513670.git.gustavoars@kernel.org>
        <20220310040347.GA2295236@embeddedor>
Date:   Tue, 15 Mar 2022 00:02:13 -0400
In-Reply-To: <20220310040347.GA2295236@embeddedor> (Gustavo A. R. Silva's
        message of "Wed, 9 Mar 2022 22:03:47 -0600")
Content-Type: text/plain
X-ClientProxiedBy: DS7PR06CA0033.namprd06.prod.outlook.com
 (2603:10b6:8:54::15) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a889afc-badc-446f-0b3d-08da063897e5
X-MS-TrafficTypeDiagnostic: SA2PR10MB4650:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB46505A9A7F790E9096ED05DB8E109@SA2PR10MB4650.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2hN3YrlnGkD3DXGFNqeWwCOJgOu5Hj7Tin9gqY0mlfEl8GOm4lai45JFijbIUrRI3ZZXp9qmUW3BUe1+3mjObr8mmrzA0mSRfW+EJCPdVN4lldV/pYMdRWys2t0riYfGUSlhJse8ckjaekBi2fCkyPK2dNR6r/DKSJhW1cZJa5PkutwmsyENKTU3lRND9YdVc6eialQZL9Y+xqH0juLuwwVsjUs3+EF7G6Ivv7MOczwBDCvlmzO5Zf1mo0JQfzlKi3kbue4GRKoiLdefV7iFIbNmowXI5YEfIS2vIspayHU8s1mAKP8BpU4MI6JBVBTOqxmfqbXwAsZ5BSKgXblCd7kJ35kapoIRbjILq8CGXbdPo95JDQfgQNbJItb27PC9YyMJ3hB4x8dW0zHD4BS67EX1Gu6XM4kCP9VsFAk0zmWI1XMD0zlLthOacffwzIuA9QIb2//XsJTaZ/HH0SOXZ5QSUMu6hKT0I8wnqXHP8bsjrGZSE683rf90PMqV4gaxc1mKgpfztZxzE9QYb0sB39c+u8vwVHLNqKNUqeeZrTQ3OkcBcjWfZeBlzt1IaDZpp9DyV4atOzytt3lJCnAiiKiEuP1Sv1muGY+iGWSM0urcam8q0LwDMTj+44RdBIZtlRjFa5VaSdur1CeNcEudYhxbGLaJfUPEkW7Hqx1WkWRmHePoZhoMW+N6WesDjlCIOtF4WjClMtMhMPOa05CmQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(316002)(6486002)(66946007)(66556008)(26005)(66476007)(558084003)(38350700002)(38100700002)(8676002)(186003)(8936002)(54906003)(508600001)(52116002)(36916002)(6506007)(2906002)(6512007)(86362001)(5660300002)(6916009)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yvl9M7FOsOrys0mq05UgO7owNo7Td46NbjMvGkfUoL6mMTXb/HMIlFv16gWz?=
 =?us-ascii?Q?ZSw/Mw74EVfFlvqVhozOV/4Rd0FariPUR8IdNSDkgToTT03vNaMDGQ4Nm6pY?=
 =?us-ascii?Q?ihP2dxizFlkwXX04EneKKsxeviJG7h3zG0FPGXl8eS7gNm/ynfstzDOHqpRN?=
 =?us-ascii?Q?GTWAb7W8co249ZOEB1gWffAF017dcThCVxLmTxyvkmSr7pUDv/JgkDcX/iVk?=
 =?us-ascii?Q?84yz4DiQfDOEHwTD8XYpd9rTHZEQuvBKJGL3FeLd0DkIZ2CYnbZ3wMihWMIh?=
 =?us-ascii?Q?oYx7TufSrpt4hj49BZkfdbkSWonqbQpWkpl3dEIVZCc3G0xboCjSLChJqJQP?=
 =?us-ascii?Q?JK7AbnO58MD579gZWuS40qISPerTe+hRAAffLxM50RCknT/i6uw0uIRjaFlq?=
 =?us-ascii?Q?HEEXhEFYgALSWmk3y2+qQl7Uv/IA86Y/KDq3TK+4b39DuMvRxasPVCNOoKxa?=
 =?us-ascii?Q?AeAzTg7maHqLeNnuibPv8lJsT+1Leg6z5NHVW4ITL/qOeZxukQKQAaJT+XUQ?=
 =?us-ascii?Q?N+QuqCMzSnTug9yCjGNg7VCqbHAgQqijdaDVknKgEc9XuWyKNE4gTGJ6CLkz?=
 =?us-ascii?Q?nKm82DZrkoB20gJdM3LHjeIhYcarD16o1HA5cV12ozo3wq63mpxzuypdayDd?=
 =?us-ascii?Q?yEpUCJ/hYs33mGlHkEfavnTbR7oiIv/1KNhV5O0pIgWicE1ZcXm/foC+EzcR?=
 =?us-ascii?Q?fz3VepMDoxrz/eqQscmq4WQf19V+pQHmq77IsOR/xYGPZC1ji8TokckA2rRE?=
 =?us-ascii?Q?dJ8NpR137hshbWGIGmJyi8OCo3yIVTzUYnMeKVsHEXg3yN/B8n4JxvVFT0M2?=
 =?us-ascii?Q?GXB7+/VTPi0Dztq2jDSCbru7I5ZHFPvXGAbeT0qJtxpLCgFBjPRTFXXOuas0?=
 =?us-ascii?Q?8AUiCRqapPMyNUK6nuqh5Q9ZOWXOV+CUQTAQXGT9H2ag7+W97w4iJyKKe/8j?=
 =?us-ascii?Q?CgzcTdQf1bOIjpOBDmTu2Q+qkAJ5iZZgsBvifxwwgaGpIYZglzmcsqDBBzD1?=
 =?us-ascii?Q?RgOeCnc98SWg+LbSz5GJ9QFaPR1Rx2EPbiFzOntbsPzoE9O6pGFilXyM3ZNE?=
 =?us-ascii?Q?/2IbAT/mU+/arC18kg/ZvGkWzIphqsDkvxHCG96L5lbe9AV+kYw+UvdmXpHi?=
 =?us-ascii?Q?oxmLoKIOVp61TXWGLelWEzMPPWAXoRYPNEPp50sB3uowFrhZ0qatNlbKsPgC?=
 =?us-ascii?Q?k8QCZUdgeS8rRYaR9kqyZc+OIPjJ4WHKmPlDhawtR1cfGSrxeMud8gI36zYD?=
 =?us-ascii?Q?zAg+TqgKIivbO7lSEpZoxGKU1/j5WGDixGc6FqfVJJbiZ3FkL5aBpnFml4Fm?=
 =?us-ascii?Q?jFyg2ozJbgHHw3HJZSxOTDeAHQ4JDtLxI3NfWqxt/YNzk+jICUj9ek0rU9HF?=
 =?us-ascii?Q?CotunbrDgZZcBb2anEVNrJMmJDifki4a72Tm/D+2yqk94avj1B51vCxDwZNR?=
 =?us-ascii?Q?OJF6IqthzhPb1oYlWVpWwRZjp4F5hJpbMZ+Ktv7+4fQFJKJaRisRXg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a889afc-badc-446f-0b3d-08da063897e5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 04:02:16.3745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PvJRVXsmpTVSNcKcnNajzFynXsAj4wHL1qJDYavmGU4FluHDnI5X5GKu64WUxGIUWV8reKvn+YiqgAYwm9o9zLLFNR8pUjYZp2888iJRVOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4650
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10286 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=660
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203150024
X-Proofpoint-GUID: IpIRUUK3lzyzf7nMIvFqjyB6-Z6-9_E8
X-Proofpoint-ORIG-GUID: IpIRUUK3lzyzf7nMIvFqjyB6-Z6-9_E8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Gustavo,

> Friendly ping: who can review or comment on this series, please?

I'm afraid I don't have any hardware to test it on and the generated
output differs substantially from the original code.

-- 
Martin K. Petersen	Oracle Linux Engineering
