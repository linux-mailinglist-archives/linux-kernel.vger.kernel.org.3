Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83EB94878F8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347786AbiAGOcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:32:35 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:43538 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233190AbiAGOce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:32:34 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 207Dx1Yx014505;
        Fri, 7 Jan 2022 14:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Ho8LqvSZG4P+8/+1Olq4tXXKRvcHF8tOAD1HSwf9w+A=;
 b=WopqwdAmpAUua/LYxSc3CQFaO5e2/mPz6edW7jmGqV0RMlaCuLyDwD9lDpC4TmChRzug
 1MoOepJTLvlcdzB1mRSp8l9rE266k/5wLrOpghf2oFHzX2AYuCSrEyLL8sagjepXoHwW
 HaXRbDCO/C6faeyoG1aHll5vXzzGo+2kUN2xJCf9Se7w5UWY+1HT93CDJEafjUWQNZfl
 sIe46B/CmCiPr7aWxzKXkf1fDpisj6Flq0i/ZeoDmiR/0fwMOs7s83TQPSDktxWevnAC
 t6i/FJnrBrzEoS8pFLmojBlAaj5dFCZIVUmH2bfh6dExXzekybOHAFeQ5Oti8bYE0q+f eA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3de4v8j6c5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 14:32:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 207EFmZt104458;
        Fri, 7 Jan 2022 14:32:28 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by aserp3020.oracle.com with ESMTP id 3dej4suy5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 14:32:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ausq7Dmy540fAb7BaJLoP90K9gJ7XferaHCZ3Vl8q62PtnLRpS+sk0QIa2qCzA6nb8zc9zO/3+g/a1LuFeDTlgWqxbn3HHPAJbg0qKNBGAFMWK1/ADvNmp/PlBHDRKwcFZSBlacQK4xFtwMczgUtu1/sJOldTXoVBgSm4KAp5z/I1wJmP/1NcSk9+xvEC/CXqxK5xI0Q56JuPTE03imD5RAIAAmCvmBMS6GQ/FdlRvaW4gYOTPJXoSyKtfxpTyZrmHCUKzeMI8kZg8q78gl0AQAOQLibhTcLlTiPTfKIA1CGX2iGYJWPsLT1bHCbZj37W4F/Aqaj/wxqj0EFi8dZfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ho8LqvSZG4P+8/+1Olq4tXXKRvcHF8tOAD1HSwf9w+A=;
 b=CVdR3I/4UHmQyUg83VcQnKVwbh4OSXbHxc3euUZuioNuH192nDQJzwWKUPp3O1B+AVpw/gHn/H5BZ9Wnt28NKfxUSZnsml9kVaYqlnG0xT+z2Zj+n6aS4NAHiskDJVfK6KhpzSORJgVoTeYaRecOqQ0IzPNzwoIoaUogSHYdq/+RD+KSBXHyFNEXAWAp9LC3YI8NWm6x6VwEy7QklCh+UXtaePlQuXbUQOpJ/CTwFKjEJvktOfQhbyMsks+wA8IfXAPcnqqHC52qAaxNw0DOr9foxiFPgbChuGWyAcC5jNKv2vMuHwvASORf/P6xXtdAUZRUxNgC3QfnmnQv7M88fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ho8LqvSZG4P+8/+1Olq4tXXKRvcHF8tOAD1HSwf9w+A=;
 b=qx2RnHg8cYUdecscAYDFZC1LOYu6oCOjFC7H+8Xg2DOCNdwFyLcH3gDDVMlu0Wj5D4mP1jcm0U01LKqMOwQW0AI1meF5Oam6EBbhDFActzhlOzkhYU4Us6Y3oHdipLKmwGQ00ggj+viz4XTWhF7nrB2IvhLIBg3olEcnhhYuK44=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB5515.namprd10.prod.outlook.com (2603:10b6:510:109::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Fri, 7 Jan
 2022 14:32:26 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166%7]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 14:32:26 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][RESEND] scsi: megaraid: Avoid mismatched storage type
 sizes
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1bl0nwr9s.fsf@ca-mkp.ca.oracle.com>
References: <20220105173633.2421129-1-keescook@chromium.org>
Date:   Fri, 07 Jan 2022 09:32:24 -0500
In-Reply-To: <20220105173633.2421129-1-keescook@chromium.org> (Kees Cook's
        message of "Wed, 5 Jan 2022 09:36:33 -0800")
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0024.namprd05.prod.outlook.com
 (2603:10b6:803:40::37) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba7e174e-8e12-4dc9-cc11-08d9d1ea86b1
X-MS-TrafficTypeDiagnostic: PH0PR10MB5515:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB551535781580743D9F0B80248E4D9@PH0PR10MB5515.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PDIKQtqjAFVsxgt5ZrNlO9jA/vMqhDDqI6CjQ7A0dBPbW/V2hBCwzt1sOZV3Ys1WFQiWOAjCjFzLg1oZlo6nK4oHQAyF8vtj7t5M6JTCc5ExnA3OXyfRWz36pbcH8yDUKBGBR6zeEIYPK3ixC1ZUPJZ7Q7E9zScAi7QKqBJ9cFE5Kwzp9C7OG/Bng9DMsFW7qhrarDx0myJEGKG/mEJB1QxN9HGrdWEQwG9I9iA2smq8YSGSFW7Xh9At6Fz/ftL+bvLon/jqD5Fg1ShFuwVU+IBG7LmYt9B7VHc2lwsFUJpjqfTJgIY+FpNS0/LxDB/x+Ey3l+e83W7LAQFPP0Wxpkge4CcEgNyhPMLHWink09HmZs60WbCAa2iMByfdZD03WfE2kVPuACnPrG58J2rzPrXxvtKwX33MhP3dped7Vhs/6wwfVUfpO/sRJMhzxEMxp5+BGNu0okIr537PeR8RfSLW4Wnnnc/46kddDADKI3B0g4E3FQCFdk1O24Q3lmDWwuPP0+XvP+boL/bKv4bS3IDxohWSPFZIq0HAhGSC7oqbRJRHs0+mdyJZsCjgGxfcopPMlyFTTvqzABtROMK4V3glzPWaVNF0AIE0k5HhHKHi44pC0ki79N5B7UwiVXCLOY+Io5X1nYO6Qau2k7/Cq4Rj3lIzmJfnc9PY2355TCQfM/GCNPjVHql/UcBDYAzf3oqE4mflu3ICnvu5E6RsLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36916002)(5660300002)(6512007)(558084003)(8676002)(8936002)(86362001)(38350700002)(83380400001)(6506007)(508600001)(54906003)(316002)(52116002)(38100700002)(6916009)(66476007)(6486002)(66556008)(66946007)(2906002)(26005)(186003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ToB51ruvFnhE4MT43UAALlSWTWoFrK6yBRxjjYpVDif0roKoCapJ4cGtoqWI?=
 =?us-ascii?Q?QitCJk8WjrO1FaC4cU/1yoMLUNOXEADfVqHz+qkSTsYtjYSl0GN/3e76RkAS?=
 =?us-ascii?Q?ZdccOzA2rspNAbUscxbdaSfN/iS7lekZiMh4rWdpHYOS3nwXj2bGDCLcYysG?=
 =?us-ascii?Q?CXn5RcsrK4WbRmlharANndxuT8AZ1QHryUBDYTesC25yH8FRFhKwOM7+gY99?=
 =?us-ascii?Q?t4fytCWxfaIM+c/SwcXGJ3Gh8dsQe2nULflfbBeEH5fTyVoIv3bwbY660NYY?=
 =?us-ascii?Q?9YibAnBRv3JcWjm2trOu7VfSaJ45oyZyy7tLZ+39+SICuPF0l20AMTDVhREl?=
 =?us-ascii?Q?l5FA6GSw3a01TG6UIi8+gRLoHh0l4WXGa7jyo+Pye8bHVhCs23WAf8EGjLIT?=
 =?us-ascii?Q?8N7krii3S34TZ0QknmDQJ2FDkjsJqy8Fxt7czmNlybp5TFLyjXi3Te7tN7MH?=
 =?us-ascii?Q?FRL9Wi9HPo4HUhe772mO6L7Q7B5sivW6ReQkrGUYmfABme/dXyvxxvB9AbgX?=
 =?us-ascii?Q?fgeeXwqpozgClW6TNiP8nHMuqVM1BhbdWfIqu4KU6DtHtUkxKjqJm8nwwwvh?=
 =?us-ascii?Q?gpU76f1yRNic9C4EtOcWBG3iwPFWo/ig/gdHStBppaUkLNas37Rgd/3fIVMQ?=
 =?us-ascii?Q?jWho0/VGu7T1qX+a/PjFsoMYfFaBJMsna5GwSc3OHnKTBUAv0VMx8pYPYCqt?=
 =?us-ascii?Q?6ZwYppeH5jLX6I2vjkDT+ThvtGzoo1wbVMCTn6P5nk8+fYT0WRUc0/TpjoQ/?=
 =?us-ascii?Q?3liw5vG40g9K2Zs4fEkVXo/9d1zPuNuMpDnz9ZzEZ3GUJlcYg0pGyeSeqlhW?=
 =?us-ascii?Q?OLEFxxRLuyj+Om2KeKGtCfy42+fMUNvZArz5M5DSE9ZkqQRvtl8HrH0CnFmD?=
 =?us-ascii?Q?ET2gttXrfIWGdxcTn2UmmaT0qoZQ86l8Hg7bmtpZRf45afJ/5Qi0wZY1EIX8?=
 =?us-ascii?Q?UtVyANkXr8+Ai2fv9Ho5UeOOjBBc2VSWWJCBtlluO4PlbOis7GYIkaker2eN?=
 =?us-ascii?Q?DvXVZ436pRty2Kmd8v1aquZYFejRLx+35zi2AfDOVzo8c0yJ8i9aHsqQka2s?=
 =?us-ascii?Q?uiJ6G8UNKWe8/1nyWW2yKkOoh1VAMCF5hNLrDnTuGJnQebp9sz/GkJGOJzPO?=
 =?us-ascii?Q?eWktllOe9CqxZ4f2sJ2oI3UwivJrnJOGGqOo2Vuoxm/e7V7FMUWkftCEUoQY?=
 =?us-ascii?Q?Nk6x3Jrgho2cL7qG7FCwcAJ5Pxe2vBqX7MWYKzrH1pWokNi3jmPO+tglUCjf?=
 =?us-ascii?Q?Gw0kVWHsdlfba6Y09frdHG9TqNFliiXbPZbOBl46hsyXAvdBIrgPltacd8W7?=
 =?us-ascii?Q?u/V9LoMZNF6LC2tvQcyJOCJrML7C/Qp4KBZBVvJ1CkKdlMx/fufWZ/L3AGS+?=
 =?us-ascii?Q?QCUyl4EpBExaeXXgBoCnlz52wns5SYQZxgej48gNfPcKMhXpjLlr6MN3aAXH?=
 =?us-ascii?Q?Eu+V8tknXWnIrDnznhDa9hU3hVWpkqSaMJqeop4tQkzA+mSwAKfokELgKec/?=
 =?us-ascii?Q?IfLcreKzPOtOqwLsmDchDCcwkrvBjSEBib3Ptx2vLcLf4gqP3bHiPT4h92Zr?=
 =?us-ascii?Q?qgJQEVU9kpNd/NFzPta/1dWJ7xCAZrehyc1sPNOGnDxU+W2VvtnVnHuYD3Ah?=
 =?us-ascii?Q?+CqJuh8ZAgja+Vlrvdtsc7tykut8nm8l/877dU41OFeb3pmUBMRVg/R0n5uw?=
 =?us-ascii?Q?Mq6n+g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba7e174e-8e12-4dc9-cc11-08d9d1ea86b1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 14:32:26.2924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4/tIvK69W+DxGJOsLDQHQzQ2WFFATQI1QrD4W1dQ2gyt/9oaoerYpQaycGE5I74O40XFLveyH0SnS5/fKV2SrViL3G58vHwKdCLaqWUrAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5515
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=775 bulkscore=0 mlxscore=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201070099
X-Proofpoint-ORIG-GUID: XkUYyM1vrYxlONC9wXfDiDCv_TgMezxK
X-Proofpoint-GUID: XkUYyM1vrYxlONC9wXfDiDCv_TgMezxK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Kees,

> Remove needless use of mbox_t, replacing with just struct
> mbox_out. Silences compiler warnings under a -Warray-bounds build:

Applied to 5.17/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
