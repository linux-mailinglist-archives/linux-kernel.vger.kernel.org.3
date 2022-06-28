Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B2255CCAA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241924AbiF1CrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 22:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245486AbiF1Cqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 22:46:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77245248D8;
        Mon, 27 Jun 2022 19:42:10 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25S1p8nA020672;
        Tue, 28 Jun 2022 02:42:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=0X3KKAu1pnKIO/O3lEeSeg+0Nr6I1hreDFNHACmhC24=;
 b=iOD2cDMW6w7VXHmfya9wwUYUpcLLi7lvMEFRalbYicTke6xB9v2630zKJwECMwq5c4Qb
 gwhbLPuEnWQUEZBPb/6ZnXffdiquYOYhza47ntOqw+2BKF2FAmDXIKh7fOYvYLnfMMwc
 SBuJlo7QPTfY9w3IJ6/h2KANOn0fLUl7w64k3J+XPMpxmSaUhSpV3Ztvtxzz9szd06/5
 jTamm8KPicLo77RDwKrgFDebMmoINljtowKJUHYSV/N4NgTObp/sE4azSywE2nmIjxFL
 9lV1P2Ex6lIHgP4pJ2Y4YB58r8tz3KUobhyKO7hwqmKLKEaYozbzgjqt0xX7rbJqwecZ eg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwt89vqs8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 02:42:05 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25S2Kxwr036996;
        Tue, 28 Jun 2022 02:42:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt24w8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 02:42:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuvRRjWcx1guWQFK+FN/cQCKLkA9axqIHhfki9xPN9Mno7x9gDwF6oUOq3fh7wgolrONjUKK7HcKQkehCAg10Q+wS5xhPviDHZE3CqvdS7s1+fMXNXaoWRmyj8kh8AYvo4Df2/XakI7KP6WVu9S0H1pkkyI39xyrfSvFSJtDvqj7QQGvqh/o7P2S7MrPUk65UE+3d8wNJJz6LbfBRfnUpfMQGTE7ReZENA1cwuRfWCFAMkZTm01tGpEls5xEg/BukNaFqVZeWoUPN54Csusmp6kpbVOT3a3dI5Zd6vmLkHsI/0YTr+l6ryTO8gP+xeYQFSHYYKUlSu7GYwJKonrJLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0X3KKAu1pnKIO/O3lEeSeg+0Nr6I1hreDFNHACmhC24=;
 b=Lxgolll7T3xplJ5HsWrBoEm9lm87P8PmRoS0cnEQi7PiPV2E7UXec5kfGuhebI+a67hAV8ok9CgQgyplkHLqjAuFtDpDoFn8h7AO7dzjZ6RjTvS6zeujHPpY+yPmSlR4OP6ul3sQpZTN+60S4B4BHI1wxEkD0VXxPoV2qwVAiLao3fzbGzaA2PFcdHR32JSdeegr4IUto0w455Y92BIZ8I+Lut0gsLBP5oxYqak43OGtY//v9c4zQsMX63yB1J4UMoltU2XER9r84TRwtOBDwN5+gqLt7oo4qrEGUgCFzMtmFAa9Ni4UQ75y5DFiNvtJ/nmhyI6IKeTuKe5566e7TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0X3KKAu1pnKIO/O3lEeSeg+0Nr6I1hreDFNHACmhC24=;
 b=OdVGldItxSsJU4rIDieLxxnMw7+Vk2WJrTZqPG5on9irHQdXbLOS4loYXVX51c4j3imfQ/ihR7aGMSh2y7tNbN4mzFsdpPq4/jd1oRsb09K3tvQpnvNU2QIPiKQWV2kG95aJD5gZ6OgEXZECdTyWTgKHJMSOibJknyC0eLSnPdM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MN2PR10MB3981.namprd10.prod.outlook.com (2603:10b6:208:183::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 02:42:02 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45%5]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 02:42:02 +0000
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH v4 0/3] scsi: ufs: minor cleanups
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1r139h69e.fsf@ca-mkp.ca.oracle.com>
References: <20220623102432.108059-1-krzysztof.kozlowski@linaro.org>
Date:   Mon, 27 Jun 2022 22:41:59 -0400
In-Reply-To: <20220623102432.108059-1-krzysztof.kozlowski@linaro.org>
        (Krzysztof Kozlowski's message of "Thu, 23 Jun 2022 12:24:29 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0060.namprd11.prod.outlook.com
 (2603:10b6:806:d0::35) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2161c61-84cc-482b-550c-08da58afc7f2
X-MS-TrafficTypeDiagnostic: MN2PR10MB3981:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dXOuelyd88J57IKVArjU7ujLJVe1d/CeQyocqPUWj3gQJG/UTZZmOts8aHzFehdpUmWh64b59Us/dFylbgGhGn8oeuWsBWVFAmQBRQ0V1L7HL225Q5eTLs70Vg1bb4/oIJeYNaR8mrRlxJdgteWLmZDz7NSrHpBNieMF+te1fahRPPLx+ky/z26ZrTq8iugIffmqZsKho06agHq98Wa7But9QfuzjPurRedPwHIUp/pcHH8JBPx7tLc1gQ6YQXlD4KPGZZNaBApGEI49IhqUgEePasDXRkVmkm1Oabd9q90T1oyT4TxrklbOGxSxXik04h1aN4rqfD7A7JuJEbhKbnBXK7vmyV59QL00xbHc/GcJmfspP/rTuZyvZZn+QnaLnwp7lEBnoLCFqZ5JNvP1yTnmNU6l20Hqo4D1ihj5i02Avumin0mwSq/ZN1qEAoD2BwG5Dcc9H2TWvhHC1OEkgK3N7I4AOmpAHWcKXqZh+H9551kf8dobmwh/WlFbLTjQg1BFz756Q/lRc+gQ7Y2/Zw5Lmx2qDFVfJZ4X0mDBRp0w0kiMC7zL1YyLKhr8qBhYxvTZVRDsFjW/63nWYx5qwLARIZtvRDRM4TlsE2c6OfskRw8NYPmsXlUv9dqIfpEDKTUNvRrgyseQPkfeERbeTtNNnq9YPtjN8w+1TwkMCz2r8L0T8BC0pIjgzrLHGZzYoCO/ksdxX0fGu6slrzBiRcSO3WfbRUBmwwXii+b3qRiTnJUss9zi9f1E1QjCxUVlUD038xEEJ5KneJRsNMPG3bVzXPQtQY8OBm6Ar+scojM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(366004)(376002)(396003)(39860400002)(86362001)(4744005)(66476007)(316002)(4326008)(8936002)(6486002)(5660300002)(38100700002)(2906002)(36916002)(52116002)(478600001)(66556008)(66946007)(8676002)(54906003)(6666004)(41300700001)(6916009)(6506007)(186003)(26005)(38350700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YZqy+MdJUJ4dN+e6PyT7EZT5Lxqfqa2Y5wUHHQkVDruoMVYRVFx6kpfzRPBP?=
 =?us-ascii?Q?boe+KJIYCWcEb08eO5xs4ZZMys62+q6CKLMcU02wCNS0z9zRpLbLmFUtdc1L?=
 =?us-ascii?Q?m728/idcL3D1Yr2Hi6m5oawU8UsxY2CimRlNS4xNl3EhCcaeUP/rYeJrpW/8?=
 =?us-ascii?Q?Fe458S0HDXv5eZCzjiABWpY+dVhc7nHY8r4QyqlNDoC6iKwzjshQ+idICEq4?=
 =?us-ascii?Q?b6eA3cnlh00lVcVcT01ycj+xfh6vpwWxp6tGNifMpXEVxsA0F8iHq0pbkDi9?=
 =?us-ascii?Q?lVye3a7MKfCHOs6fNwQtkT1vS0ygs8QhSVPau98YZ7rClCm7qk3pKS5liHYq?=
 =?us-ascii?Q?t4ihMK5BARJism3O0Nx2Znh8tEOlH+mSIW+/HTfqwg8L7hU7+1a9l6IR8dXr?=
 =?us-ascii?Q?+VVMa93jszYJyIA0hhdSrM11m5I1DCIwSmJcOYHdrZmbyrJBAhfvOQo6bVzc?=
 =?us-ascii?Q?XTiUJPTIxJeknWPU7Hol2Nhu61jAXYXfivYmKv7ZlFb9NyYMP36UH978R17t?=
 =?us-ascii?Q?IBswmcVnrSQoyQ1pmaDtQwk+DOOu3allzfxaQMwI2NSmZ9ly2dfJOI8NG2+H?=
 =?us-ascii?Q?TthRGH0sGtwRF4SFjDcpKPogJSyqr3TiHkv0h0WmnvUT+wM2hjzsLi48XNuy?=
 =?us-ascii?Q?WEtClH8QvjggUIHdNyceilK6P4F+WxZuHaWxLmzpoIvoUsjqqawIEYIp7TVq?=
 =?us-ascii?Q?C9CQZ+6yQWptXk3Rr0DQthfau3elp872L2IJKph1vmde2vQJLpW7iI23KBek?=
 =?us-ascii?Q?aH/V+lP23H+8Xj2AGYyNneybRYmGt4pCkTq7cP5CyuqjgwJdHxfeOFcHg3Gp?=
 =?us-ascii?Q?cOK9xedNOcMC5doaPnGaIcMP4B8cgK7jzf6TuhXSGrGCwsr3eg9MvyGKFdmd?=
 =?us-ascii?Q?113p8DfaL1HKyB7oGMFKQAGAFgDfa9L+tjsnBroW0CiGiA5BjLx/aXSQaWvF?=
 =?us-ascii?Q?A4N8BaUL92fsoKXGsJD1vDJgYnju0NYe5TfMVJ1ruwhU1oM47gb3Dl0xRv+O?=
 =?us-ascii?Q?lrZmUdjQhCh0cVGdMV8D3ZLrXRZyckeW5VjEvo8DHcoc1H6+kiQUI0zZnnL0?=
 =?us-ascii?Q?l+g1Iyvk/542OtdYLHdzpPXZ0Qax1X/SoByMKw4o0vOwmWlnv+1dPLBiXdE7?=
 =?us-ascii?Q?JmPeR6+bjCv17zQzlHoh5a1MRc0fTwDuIfsFdOZqx2KBUQfNtPvRQL1M2VYN?=
 =?us-ascii?Q?WDN2jdAQKxItllswhVIn3its4OpdCh92agBq8nO4mGoEY6qjW15NAbrPLmcY?=
 =?us-ascii?Q?CTQFeuWPHSoOGRkf6tGt/dVF/CWYKugsyr4pj3v44qFaGIcDwk056nqqW5tr?=
 =?us-ascii?Q?UWObYfA1jzVl3VNvAyZpQCvPiGiInqGZTE+kM9HbWfTtAqtiXMsvI7WxVYcg?=
 =?us-ascii?Q?CNzSwmnWgWa1FcDGD6FqCtYpNYWQiEMBjd23wMnMJVa1i6fNg22SBit0258q?=
 =?us-ascii?Q?K48FDIQvcbbQDO5eW7rQtPps2Y5cQri8Zzd7hg7nOgIVH0TOuLMkQohGkt4V?=
 =?us-ascii?Q?i2KUnuRgnBAZ7p2tj7kyiTFAp0UifGjE//8KLU6AFJ8w2YhE90z/LwpjJiDs?=
 =?us-ascii?Q?lhxYQFvuDr+q7SjIeXUG6qq3dnP+ReEXKbnCdkuHJRF/p0/Ep2ANLe4PvGsU?=
 =?us-ascii?Q?/A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2161c61-84cc-482b-550c-08da58afc7f2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 02:42:02.5133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rvFRmnb+V6oHDTRrbklFMWZlKI2I2HEnY1HhbpDrUSDmEPGSP44W6aLj56wBR/j2LW1HZMMDyYWN8BSWoI5ukxOFtuL2rcKSZ9hP1IN8ZGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3981
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-27_06:2022-06-24,2022-06-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=607 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206280009
X-Proofpoint-ORIG-GUID: f53ZKSwKQfhHeUvZWVpbIF8StDbUf8_H
X-Proofpoint-GUID: f53ZKSwKQfhHeUvZWVpbIF8StDbUf8_H
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Krzysztof,

Applied patches 2 and 3 to 5.20/scsi-staging, thanks!

Wrt. patch 1: SCSI contains a substantial amount of very old code and
thus style and whitespace cleanup opportunities are almost endless.
While it would be nice for everything to look "fresh", fixing everything
would generate a lot of churn.

-- 
Martin K. Petersen	Oracle Linux Engineering
