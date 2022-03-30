Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316344EB8A6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 05:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242214AbiC3DEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 23:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238660AbiC3DEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 23:04:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5010F18178C;
        Tue, 29 Mar 2022 20:03:09 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22TKn3cg019606;
        Wed, 30 Mar 2022 03:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=kw3m5wc+1nbBaH7OMSl0JIOi4Hr/Kt66Vv3kcGRhjro=;
 b=wQ48K86hoaz4vA0/oifafvPIcR7RIpNhCJrRDeodus4YyFVHyl/PDDxPZxAWIX4kRm7f
 UshtPqYyyPNzc+H6yqu6Ndz8WQdAhhaGJQf67fSyIuaaRu6KR8AWN2+QSaAdaWDVv1ia
 AV5t7ySTiN4cfxfeczjcU+3vFxscH3b/sa1MZsYpPfT2nF6Emz+rZNeN4ILIjvsaYW57
 IWE/NNlPL0JAsMe7VuDJcnaoWU/A/Pe+mBmGn8p5dY+DAIfDQOTTObu7YD254O/RDzFI
 vRLATyPAiRJ+xUHAY57moeYOiYn2IrV6bASNN+xVr+LKsmc9tz8fwAOe8H/HVwOi83Zp tA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1se0g8ra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 03:02:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22U2rjB4015831;
        Wed, 30 Mar 2022 03:02:50 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by userp3020.oracle.com with ESMTP id 3f1v9fjsta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 03:02:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ku6v8fs27kFMYR6O29tFLxXS0MSquR8w0NT2IPw44XvuLHqSoaV1XzLX+vRHU/SgxPMgan9OmYeQORGnveVGoXTQuo7g+UycQO+77Svwasu1A/6DEkeRa0XM527CdulUz/JozK/VVO0Sdh4kkoJyw7gw1p6V/SdSTRoWInFB9iBNjGw37N11uI1ItxwInWY1UPtFjvo5PItUoeXV/+JOfhE7eBt+mAWWrWGToR0iIy09VX//PfPZBnVsPzVOb+X3cL9eztJFwAxbYr/9r/5pWKdmtxAivPmQf3ZioQK5rbtNMBFMPY5kufa0v0Rds7Zx83SvftdAroxqoT5hcSsIuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kw3m5wc+1nbBaH7OMSl0JIOi4Hr/Kt66Vv3kcGRhjro=;
 b=YwyiYW6TJ1fkOgJNoUpNUX2kX9Hw9PvgO/0LsCcEw58DPuqXt42UZeBYk0t1aI/x+SS/hH4h1iCh5tqvZ2SLMTS8LsZRHSMSO2RvArMAylnqvRH3Z/fgHLr/BlAfGZnCSGSYmd7xXNjs6gegKJybglUvtQZhgvlxDSEeIXsG6XMxLbz19RcQZBNhtgiixFZYUuZu8KHVVAjV/uLrppwpv8jsvUTbk0j+5h2WzRef7XnvZ0Qs62Uv/QiyemWnywlIyQufeAwU8irsR+rxFugfIs4YYHKL5KYFeEo9rC4TYitjPTkWxh0xQ698q9xZXjTaQZ5S1outswfePsyl8TA1yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kw3m5wc+1nbBaH7OMSl0JIOi4Hr/Kt66Vv3kcGRhjro=;
 b=C44Mh17snwY7KVb9x/FWvIOpCBsWZFXRV+VaDzfReEkzjmsf4nOTp4431FYH6TygCgNVoPm6jptFRCbz0HfjwLd169H8hkprvVb+O4w4WTW6gWNc02iwGePjPIch+1o69MuejVlkgm7aorSrz6nSmgtn19bT7ZQA4pnqtcxzkik=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MWHPR10MB1309.namprd10.prod.outlook.com (2603:10b6:300:1e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16; Wed, 30 Mar
 2022 03:02:47 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed%4]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 03:02:47 +0000
To:     Wenchao Hao <haowenchao@huawei.com>
Cc:     Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Mike Christie <michael.christie@oracle.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        Wu Bo <wubo40@huawei.com>, <linfeilong@huawei.com>
Subject: Re: [PATCH] scsi:libiscsi: remove unnecessary memset in
 iscsi_conn_setup
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq14k3gxhv7.fsf@ca-mkp.ca.oracle.com>
References: <20220317150116.194140-1-haowenchao@huawei.com>
Date:   Tue, 29 Mar 2022 23:02:45 -0400
In-Reply-To: <20220317150116.194140-1-haowenchao@huawei.com> (Wenchao Hao's
        message of "Thu, 17 Mar 2022 11:01:16 -0400")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0042.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::19) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13339cf1-d162-4589-f507-08da11f9c4d0
X-MS-TrafficTypeDiagnostic: MWHPR10MB1309:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1309A416CB679D02AC1E49BC8E1F9@MWHPR10MB1309.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EgERZ1T39+djG4AySszvojgYAuleOT3Gk1FE+1uBPadFNIeAFufoIwrgTC1BbZz/M44eGOu3uWTnedy4JMoa/mL0J4i3QU6mUDIkbJR4efc6cPJSNZ1Mn+xxUtdGy/wdEGgu+vCCVhPoDHrarzPuCneHVUCbn36+C3O88jhp+Y1Zfm0SxqptU1wqtkn1N9Trsa1eSahmu+icTvaQ7bhkyZyWWQEomFraUNKtJGTiLa7c6qrFkupn2ys65BrBW4KnqhD4J5Im+pO5Nmbbe2JNwWxaulFZGBwnwcBZ9O46b8+pl1VlWfuftuROCiHXzPZD3ssI8iajSxOJZToTr63Rb6bpAS+XO2B29opOnNowhWDFgFsAo9XogZ0Uimt/gVwPJqMWIH1G8r6e+hW2cuN0j9/ZczvGlrNKenYoAYMBs7k2TGQkwvx5Md4PIJodNCpnAC2FkqOPY7nefrnzZu5u+BFgnXVflT5DbOEXD7Jgce+cMvce5RagVGQnSx5eZTO6K7450ixAV1G5694J3C00pEMkhttamrJz3+ISfJWeP9dLezKlwza1PDYPFUSZjGurrCXTCdXAG55nrvNZ3mkogcmrZvXiXwtGxAfz13g/n7QjRfN7xqdS4342JBC/O2FMiZOZskUour3mvYeJOU31IBZYmOX64mT0vrqJhEqdSh70sOnXwWllpL8oy73EZ+gtrIWfSoA09+DufM9PYZ2Fhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(86362001)(54906003)(316002)(6486002)(508600001)(66556008)(52116002)(66946007)(66476007)(558084003)(2906002)(4326008)(8676002)(7416002)(6506007)(6512007)(38100700002)(38350700002)(36916002)(8936002)(186003)(26005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PvFQAxolNQk66WkBbRvSoG+yDmaA4zvybJSgfWOvrrEK0/lDGJ48FrzVtOJp?=
 =?us-ascii?Q?92Dy8rV/cwTgcKksgqiEqP5XmNhCyRUjRolyvJaiDvL3c22NCUAYpprIonyn?=
 =?us-ascii?Q?Zik750fiIW+jA1pkNOW9xLY+8Y4AAFWrmyOb2OGDLb68bXNikkuCwqPook2f?=
 =?us-ascii?Q?xxSW9fpyH4IrzAOM1/vISuiP0m1ZCQnFl1uf2fojDLuaHeoJKBrNP162OLX5?=
 =?us-ascii?Q?Dld9G8QCS1yhwTD+e9aRK1UVgGXQxUG2WEgSelTT1vs0TTvAuIfeSWtwG+4w?=
 =?us-ascii?Q?+EgtiX0K5xJoyHfhYl12m/w24pVyjImwVeuPVAKe3gK+YZ9TeeTVNCfzrf9K?=
 =?us-ascii?Q?uGKLK5LZzMKLZcT2vsao535JoMqqqZsgnT7eywlghDZv47XKXjJwB6oxl9Yz?=
 =?us-ascii?Q?dLvPJP+4uDWZz0Eh/zDt/t6aDrWgOEG/RYs+ngLCqlXeOvR2+ARidSxln+Rn?=
 =?us-ascii?Q?/u2P3WfsBfEo1GT5eog5ZIGPHKUef8Xv+XUnoJc7N57o/MS4wKrGaU8gidan?=
 =?us-ascii?Q?4Qr23iX2wjYDimCHcdOkIO/e5qcyDEi1a/T6faiUQTzDxlEnOZWhaIPfI4Fq?=
 =?us-ascii?Q?aPO7l8P5mho3KCz0cNUxj7gUKe8IxMwlY98UFhajmyFJBqRuGwYNkOA3JG48?=
 =?us-ascii?Q?6QnzmCqsFtXOQtQ0cd6UESpC0/zJaRS8YK714qeBYLDcvdIw9GBQkC8f/F8B?=
 =?us-ascii?Q?IFD2TWaoNtHl6dFRs68swCGerQ4RcA0b9815PHPvrBr1ov43bOfoJvjNTXKk?=
 =?us-ascii?Q?iSuaNVApIbcJBCmxSZ8srshgonodU+jalFhbplDx7xWGj8Wz4FEtcmTzQM9b?=
 =?us-ascii?Q?s0KHKetQAn3bnJdnppXgcHWqwa9AQt/o6rWL9G0tTL4Spo2DZt1U+DdTTa0J?=
 =?us-ascii?Q?mNI0ob1lwmNW9+6rz3UMaNIqXR29zOXr4SNytNmXp81R83mipKb4V3D5UJQB?=
 =?us-ascii?Q?ddf4xjDAiZErq998gmK7yeepP0c3qacwP6lIdfpXjTIZDOaPTk0l05B41NKl?=
 =?us-ascii?Q?igDbxz79AK0yJwxKTt6FDtc0JOyejQzb5XB2Oy5xDU1ONCe99YYfce2UnUYG?=
 =?us-ascii?Q?f/NyirOzylKVA4yD6gAabF03xKdnurWd9j+wGf0wvEIQlqgcrf7yNVSgQw8y?=
 =?us-ascii?Q?RqEVcU5o48RIE+cAAL/xCA4FFwQbKz4H36sUtpGzbfKRtD9I6yShhF76Qc2b?=
 =?us-ascii?Q?eg+hk6DCrG1rQvz6ZQCLO/bPXAxYCqT0clvjUowp9wAynT2rRpiwZr6zYeA2?=
 =?us-ascii?Q?W+R/GtRLmgvXZYE9XP2/N8CjzB82OBokMmEAZ7Mq5gHR+Ksxfz24k2PNhd0W?=
 =?us-ascii?Q?5q4NArehUgH9o2jk7VSfJPDAjifKRKRYIMnaUaOEBbxMThGoWhKxFkUdKVMW?=
 =?us-ascii?Q?NFlcGFYX9BxXceBvD6bcK3LeoA3xkjUKq5FskaiE9AuYPykTvd+x5QASfUdk?=
 =?us-ascii?Q?3Y3EplIHTZQIF10AaJsgFhmeeowgIC/E/Uds++2T5vfa8C+hnQ0QJ8Ub4IOq?=
 =?us-ascii?Q?E7gxNeCA73ZLVji0yjySAB5OCBwsSc8LB/pkYrSVrzaCEzTV5m2lMWPux/Eb?=
 =?us-ascii?Q?H108yG18kwuGlw6EwL6Yn6KRkx+7tmLghtaAf6D3FTuQ7IRnA7zbNY3Hya1W?=
 =?us-ascii?Q?K8NH4u+7j2H6PU8L128sUaSHQKATKKy6aF2DHLi8gCGcXNwrwHGNp6Y3cZmn?=
 =?us-ascii?Q?HWT+7knJ8bBM1GCAOEnk7TWXijEXQEyQAhSuqNXJ8CieMVV7naJHjCCtbrJU?=
 =?us-ascii?Q?fGbNsDpqMMCIxpQ3ZNxQB1Cz2VdN8/c=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13339cf1-d162-4589-f507-08da11f9c4d0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 03:02:47.5715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9hfSZTWYGn341IxHfwiG2jRHc6r9VYnjY95aP2RfE9ZTcw0//Wwv5fiAOI0mbvNb4l17xF/9I3wbHiNsJMh2KZ3RrAcYaJ4OV8OLXatCgYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1309
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10301 signatures=695566
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=770 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203300013
X-Proofpoint-ORIG-GUID: yf0Ip1-AYXewesPT_mDpH6MiEEH6zdRE
X-Proofpoint-GUID: yf0Ip1-AYXewesPT_mDpH6MiEEH6zdRE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Wenchao,

> iscsi_cls_conn is alloced by kzalloc(), the whole iscsi_cls_conn is
> zero filled already including the dd_data. So it is unnecessary to
> call memset again.

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
