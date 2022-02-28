Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709F64C6165
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 03:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbiB1CsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 21:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiB1CsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 21:48:21 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976BD658D;
        Sun, 27 Feb 2022 18:47:44 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21RN94gn021511;
        Mon, 28 Feb 2022 02:47:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=HOs1VrMIPQxwB9ncgQ6s65WREbKinRFXT4xkN51E3vE=;
 b=AREqqjn7rqXRwmxZpi5ZkGHqo6hg2sYNdZ7MbNdRZZODDNRIXvSfMBp5uad8r/XvaJ7C
 VFVAlmOOmMFg3+OqyUCFNfXrX3zxPdshXwdOEIKjSijGpPbIlW4WO94VskCUDsFVKI/n
 Df6IQzXh2I/W1eHBc5RbFhwowoNSepZvyajfDvUhpUCCUiq5ID0ZDhBRPw67ZP+QcpbH
 rPZHZ2qeHficu2Tw9mHFLZoJiMWttYyu25ORGsu0qpvehMQZovcJS53OLtmG8hXeVzzi
 ULLlvJE+1+H7n/6CAB1EIpXgt4CDWU9tQgn1xe7KXqwSLExNyw43Y7hJK4fT5Un0gFDj Ig== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efat1tyae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 02:47:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21S2j9bC064157;
        Mon, 28 Feb 2022 02:47:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by aserp3030.oracle.com with ESMTP id 3efa8bwkyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 02:47:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqBfG7GZyEnVvorx+aT/1CcSQp31MEj0aSAvowPFadmsNMrEizsUxFoE6dKvOkV8l5JuvFcFWcanu52OqaEYMZJ+3lUCpVYSX8wpoVOYhrMPpmn8FIwf3wa4213FH8SC8yInHcqzZL6T+Rto8pLTBlwMFLTP2K43H3HOf16Mkg66+l/w6WTpxRPaJnLhuKfuomWGfTmzIq5XfiKwV5PIHW9qZMjr3hiwpnaX1CmVBmtkscuWzSjkOU0H16j8u9W9orI+lL0YF6U5U7ojd3S+odDDPfzN2BNS8nDHOVSy5Hn0FoHC+hpr/maXHXB00JHtKz1rtCBHPMGE+liOel6r/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOs1VrMIPQxwB9ncgQ6s65WREbKinRFXT4xkN51E3vE=;
 b=CW94bMaGtRSyH/CsdvMvfdorSOE9iz2s1nyQwVKQp5WWNopLfGGMvhkBel8l4u+59nCEp4fbxEOoLLBU1FvTeKVFAm9FBliHpEt+LBTJkteG/OyKCGoJmtnT0IumB3OLTjjWd123ObG7gOAUttbmqoDeRwmoW2kcghYHn3iWfOMKuDSTRNLEJ7g1u1zuZj8xONshED1GaAYeO1/3pMBCjP2k0clmSDbXTguaznweGeogRXWediNzh96XMb8VnaFleAIQ4Zn7WVQxYwOYhAQ7iwOgrr0nsE/YLNI/qtonMBQxELQsQvLEH32dKsANbgHv6jdf8pS0PIyk1kul7MhZzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOs1VrMIPQxwB9ncgQ6s65WREbKinRFXT4xkN51E3vE=;
 b=v/BMoL5TFzX0LilivxmmGHo7mBQOElcgSN8u6pvNUYWEjp0HfTMPjKvB5aPKk9mbCxxW+t9O71mD1HQ3nkjOENufdvFUoJ9FZJq1O3dhtsSPN3JcNkzVPskgJYIn2oegSnDTqOPMM+Ug12+V+RFQmr/c3i030TmpQ58uZ+AOUJw=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4695.namprd10.prod.outlook.com (2603:10b6:510:3f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Mon, 28 Feb
 2022 02:47:29 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::180:b394:7d46:e1c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::180:b394:7d46:e1c0%6]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 02:47:28 +0000
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH 0/6] hisi_sas: Some misc updates
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1bkyr7ln3.fsf@ca-mkp.ca.oracle.com>
References: <1645703489-87194-1-git-send-email-john.garry@huawei.com>
Date:   Sun, 27 Feb 2022 21:47:26 -0500
In-Reply-To: <1645703489-87194-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Thu, 24 Feb 2022 19:51:23 +0800")
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0042.namprd17.prod.outlook.com
 (2603:10b6:a03:167::19) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c824690b-55c4-4ba1-3df8-08d9fa64a8e7
X-MS-TrafficTypeDiagnostic: PH0PR10MB4695:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB4695D0570A7C02C4C1835CBD8E019@PH0PR10MB4695.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QnBpAD3RdWU/Eb+KeOgcqGrim9xhS9CF0lSjcncgFNHdVpLnRYqwUjfJhFu7RcR95rqTzi/WYOFJ8+MhNbsxxZTDtSwu1WpUYrLo7Y5SvLO2p/weOWOo6SVQfqNX/n41eZyZ8P3fElfNFL3q+D75+2RWvy7NHhbKDDEIrG3AoNIIw3yJYIWFmDAa2/Q20Cf40zcsb4vgsfO5wybAEn492mgUtLM6j5niF3UiIVsiGo4wKSNV4rPauu5ewdq0WxxouKICSJ8uADiprO13xBz2YpLL3zVHaPFkASghFrQ9MegmqEskBttrXY1KFOrNwIrIpr03H4dUmH/BktVQrgH6K9R8hDrgj+iQkNGmIKPkZArtgwvo5+aYlpROdvke3gIWsgu0kiyO56wqqNFYTJVBd4FOUWFgX8riOk4OyHOuv7ZcY539GxsKE5A55o9FhHaxtZ+sSwebxhAQchMJEJnvqAfJCaS8eXNtlVw+BW2qSOvuYdlpmnu/b9NxN+CyC95Yr7IaOgR3hvySq/fZUT9+6lzEf9KwddubZky9+PYEXaE9dYQMAtrXI+A3vvJcmaq6gEiMclBIFSFNDdiws+is3mE1IrF05LSzKevHZPtAN665rI2iS/on1iGEiYKc00EFxKTBLZWkzrgTn/CGAyBzINYNpk8pYlDOv2ZBZKNBcDjoyt0jufqTjomZpY6IAr46sLvQQKUyKCreYZE0ZtVaCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(83380400001)(86362001)(6486002)(6916009)(558084003)(54906003)(36916002)(6512007)(6506007)(52116002)(508600001)(26005)(186003)(8936002)(8676002)(4326008)(66556008)(66946007)(5660300002)(66476007)(15650500001)(38100700002)(38350700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ro6k//uj758VAa3ZY49C98BV1mn/+jHS1dSkNyAWvH7Qx7vufa2mLrGthGQr?=
 =?us-ascii?Q?PupOBHnuvjkJ+NVULigZkgn42Tq/exH3ql0kWWfOkh1OvygFN0STeFD3++6P?=
 =?us-ascii?Q?7yByoNQphdUnSBjMz5WruzJWWR9uOSt0Seyf+nNWoO48Q7WqIZ0a1rD31Xeg?=
 =?us-ascii?Q?NLMylQfH/xgvgImMoVZRvYlFRrvh+dtwgc7KLoKUqMK0jOHbM+neWRhcpz8W?=
 =?us-ascii?Q?lsv6tpvxAGwRbbxcKEebA0wgl7iQP0jifhWNHmhTseh1rlXO2ubv8R8CC72D?=
 =?us-ascii?Q?+tP+e96eLHyqBo5phphVDP8zDBpZVQfomOO9fdkHnvTN9xfhxIRDeGtAK8Z0?=
 =?us-ascii?Q?1zO+aM1CS9bP4cR5xQJ4nljs92hY023NKD4vlBFHpYF/8HJQDnLXh+OOqJzk?=
 =?us-ascii?Q?p3Un42mSuf9BwkYgI7UXtmH+KdJp3KS74U5Cae7fq7DVh+NPg2RqOD2wWkMW?=
 =?us-ascii?Q?4g5ZXLtpW56IP16IZAfGSEMyqwLiPNRSnwvrqeT4FTmExOCk+lpqz45qmEL1?=
 =?us-ascii?Q?6fJ2kN7ZwifYIwccUN+mIb3xgYoTdXXgvKyZqEfn6Lvbr6j8RLKOR/D/yKIP?=
 =?us-ascii?Q?q7YImaM/6V2JrOHAnK/J9yCuLVYe9qqjQimKlRfBPvBvnbpXwlsrJoFXcqj1?=
 =?us-ascii?Q?vji4lGpRZqyk/UWaX3volAD4ykhCbDueBhMuTXimc/fX5Ty3xwHDbewarMZ4?=
 =?us-ascii?Q?Ff2v8I6x0QY+vo7TYJSGtnw5pQY0R7EsTHeLMf/jnQ89FrgkI392AVtXMYgF?=
 =?us-ascii?Q?X8P5ys8RZbKUzX77xiVcdCyAh4Ud7X+5EVO6SQfKjq3aCdecYGLUYKkj1Eny?=
 =?us-ascii?Q?h/kDLh+ZVWfv+bcAJMc44rGGzny0+aOvtSlqTZlCFTT999UkOuKq3hrNRb6T?=
 =?us-ascii?Q?vejV4+w6TdO2wsnQsn/bPu00hYkMt0AeZiM91RvOC6UBM6zGdeg94IyFyhMO?=
 =?us-ascii?Q?APQQjRVZoVu9Z9nYmmFXFuJkNUyT3gKlzK3XPtLN7U75IOMIbO9R96R0o8zg?=
 =?us-ascii?Q?+xt6BcNZLhT2usIdr7wztHYASo/7lgnP8QDwBo/Ax0FapEvcZszdbeGiFcQk?=
 =?us-ascii?Q?980Wb+ehHK9Nnoey+cpnSeH1155d45G6kNeJjU/ske90zSQVkzJGzvXCbk7+?=
 =?us-ascii?Q?x6LXavqdf6jxfBgFQ9UZkzdlTGy1LU9DCdprKBJ5+2Gt4rnxtzHa/6KBbryp?=
 =?us-ascii?Q?I97Nl9imXGcnypo7Ffxzznvk6bb8Tm+SHvBK6T3UzQ4MFgpXLgux34YNR4OU?=
 =?us-ascii?Q?tlLUQfHgREq0aGQ6Nv0jqloV4KrYXZjgHLKs0kdPlIPP1RFvzepEiZ4heT6G?=
 =?us-ascii?Q?GsdLUQbp7qimo2NQVz2dTiJFvtfVrlNRw0OrraY3K5j3O3DLhcGj8LUGwSte?=
 =?us-ascii?Q?OVUYdYPUv0feFKzWprJJ71YlGa3v6XurEGU1dKbKu+Fi4+SRU/AmBTYt0pQ0?=
 =?us-ascii?Q?PLbB6hJJL3yPvCrdDED9XtbNU8/D2xJ6y3qgYk5/iUJ3FYAOLIveUcmzXCL8?=
 =?us-ascii?Q?Rt9HX0wDj7146L0N08/+1VwNBHLUU03h0yN3u1VoFG3pkqoW4UwuZ0Zc+TO8?=
 =?us-ascii?Q?VXj0eMyk3VXp+FX8+mMMZ42ccjKX0Ap/dVsKL7p2MvHZIi1ih5Sl3D5X7pkX?=
 =?us-ascii?Q?11JM6gxYdL32PkmAeSI0Xan7tdg07o2bk2NkyrJKvXC2AqOGMA7wEf82JjRr?=
 =?us-ascii?Q?1Za4Vg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c824690b-55c4-4ba1-3df8-08d9fa64a8e7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 02:47:28.8442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LNnG7PHR//jq7wjXlJSoAZh5dSX2Ad8ffADtga4urtYNPeid/e6ptQlaSBKllEX7vyv38sIXOD60FUtixu6lDSN7eRdLF3S84PcWLCLAXYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4695
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10271 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=848
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202280015
X-Proofpoint-GUID: 9P8inrDEUrqlR7huMkilBcNYvxUYLaSX
X-Proofpoint-ORIG-GUID: 9P8inrDEUrqlR7huMkilBcNYvxUYLaSX
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> This series includes some updates as following:

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
