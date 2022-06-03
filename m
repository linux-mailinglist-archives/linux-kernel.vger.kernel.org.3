Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5531053CE05
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 19:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344421AbiFCRYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 13:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344415AbiFCRYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:24:04 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2094.outbound.protection.outlook.com [40.107.244.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D10527F7;
        Fri,  3 Jun 2022 10:24:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOgD1b4OpRvHyupBlUighYln7U/QF0zOKcmn9RKTdJS73125YCvZz/KL+/F6Eo+sO6GnjKg1IDV/O+eOWcDt1VeXeOUPKCDEUIWx0drHJxs1gFfvIcQkaGwXLp9CFIp2ljABlANsozuKudxX06rHB3hBPSt6IaIscWSF9c76MkHlU5Y8SDzUYliNmTfIE0M9MA9n2vdKBKZDLXUiwwJvifwFI4sXWDhtGr8/5jQkk9JvQ0kRQUHW/U1SHgLYMqw++mkLyecu/Ue3emdJnYz4xuSpJq6OXUlesqLmsghtnfzZL0DWgAROYwNMkxQ1Z61rZA2mrhHmgbeb5t6gSXD/HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyF9AEl8kSL+04//UdsJ2+/R4/3/+nPXuhApJyB+hro=;
 b=Qet6QBcgLK0ClLlOBkOh/TbRDwBJi5BC5ur8yXM2EIya8JRfx3iiVdVpuoqXHJspVN+ccVymiXdtqPEYl88YqCEooILk+lOXH6llefXM/r+hJ7/h0zN2Nbi+GRctiNlR0FsDbcRSs8NCrB4NWS2mVwB4SGCBPFRZO0ljkFFDOlcVz7EfvVdZ2szyW6ulVmgwXSqzLU1DvSUfZsiQAxSWHPcKPPDyhguI6ws8pL414F7707VfmG0uKBiqRxEhwtL6KSielXeXhbFCdiv86oUGOi1y11vwwPvRD/QYCfHJ1HwIAbvXPs/EjUOBBBYTio4VE84i4J1RV1Ts6oZU7yFUDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyF9AEl8kSL+04//UdsJ2+/R4/3/+nPXuhApJyB+hro=;
 b=kgc3jq6hnkozJUmgTTjWYumHfzMbGKhhO/khFttz+xi0DJT7+Im19bC6qe1z0hj9FVH3wk3AKxKpL3sK56UKxI7gFj36YXQqJFBu5jcm2nIdjHbZHXiZz2EJBWaTzXYie4zsZaaV/6IPlg/uNfTAMEUi6ww7YZgSqbwJBpLrt7g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MWHPR0101MB2893.prod.exchangelabs.com (2603:10b6:301:33::25) by
 SJ0PR01MB6335.prod.exchangelabs.com (2603:10b6:a03:29f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Fri, 3 Jun 2022 17:24:01 +0000
Received: from MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::b8d8:b445:2b14:bed3]) by MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::b8d8:b445:2b14:bed3%3]) with mapi id 15.20.5293.019; Fri, 3 Jun 2022
 17:24:01 +0000
From:   D Scott Phillips <scott@os.amperecomputing.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        Darren Hart <darren@os.amperecomputing.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: Re: [PATCH] hwmon: Remove xgene driver
In-Reply-To: <20220603165349.3348390-1-scott@os.amperecomputing.com>
References: <20220603165349.3348390-1-scott@os.amperecomputing.com>
Date:   Fri, 03 Jun 2022 10:23:58 -0700
Message-ID: <86ilph8xu9.fsf@scott-ph-mail.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0333.namprd03.prod.outlook.com
 (2603:10b6:610:11a::7) To MWHPR0101MB2893.prod.exchangelabs.com
 (2603:10b6:301:33::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 101fe19c-b9c4-4b6b-6112-08da4585d981
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6335:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR01MB6335A4523D587FABD058200B86A19@SJ0PR01MB6335.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4a+Ogia+D1WPv7Nu3RANFFlAwKT4hTkEUqfqo9kDLdu0vKH+rkSVMNzLPQT1iNuvNQF7EEDtdkcK+O9g5os78+LNpkxQcvh8meCfRW40dbervIvSUs7/TXzZMBfVJy9EITr/mtrOAQhH+R+9GzbbYYitxdb1i/Thb9wlCy8iV/cQI1zNxi7S1t5Dm8YCmpX738rYyTEJFClB+0KiUNw9hE1cv5Pm0lcQPWkQZzxZKcx2v2WAqyeko1ihDy4nRaRaT0I/GeDTzkyJnQ/5j943JV/5VMTn/pZwtdXVQuHLyrarWGM5VloIqSRx1WIzntX3S+X8vkR0W7nYygt8wWSguDjViH91zy6p0emfb/NgMdSqTlj23OgwbVsc5yYuKG6c/N3cNKZcLQN3ktj4OjR7eYX+OixHnOMehneeyYOCmua8VXVFcpvk4/5zMPQ4HrzR7AbP4/ZTz3Am4kEUtWJrg95H5AhFVTLDTlOXhq2HXwfKHmbsrXsU0nG06mwPMbV2JXTMpf8mcLHBLDIRv5HwE0tjRN5RP1digFKqOHyj5H5I9WOHidT6Ee+/qFnv3I9x+Kxk73yYpyxlzP3H9pvWxFQuSHOwB5b56FVf2k2y6S2M/hM1rdyXUju//+Z89KNGfH1Rq+wXCyaXU6djMNjxZPHcij4J4twfh0G9vu/kTZCmlLD3CtyUCRWOlur3Gf0Zu+ZpgcApLDCArDEbbGdKxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB2893.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(4744005)(6666004)(4326008)(107886003)(186003)(5660300002)(66476007)(38100700002)(6512007)(38350700002)(9686003)(6506007)(26005)(52116002)(83380400001)(8936002)(6486002)(8676002)(6916009)(86362001)(54906003)(316002)(2906002)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ztC7k3u3AIz+qYFRcKj6Hv4cq9zDSYFgHixA+EFya2X0M90UZRkOkgo1aiwe?=
 =?us-ascii?Q?wmW3AlDgF1oaXNqgb/+HpS2cPfWgpwLvJjNGlj5Ryqeh1i6waO2NlWgMY+gf?=
 =?us-ascii?Q?KlWXUTZBjjnJKnW4B15B/gqsmyRL1C0P6VJ/PqsdtKM/ogyX8i7cRgg7lO+o?=
 =?us-ascii?Q?XlIVw0kBIx5jX76m2ILQAvfonupGxH2ozkW8AM5dPXjnZdAjsw/21M8iIRfw?=
 =?us-ascii?Q?LlxZe2Lb3/b76nlX6ixWM36vUUqh0Lv0ApsB0blH8aDabljyU/BJSLA1e8B+?=
 =?us-ascii?Q?TWrkZE0ppzZoRyjdyYLVUpHyfggpJ/xLWIdIu6z9h9njCv6z/txCpGNqc1a7?=
 =?us-ascii?Q?txmTn0qm1oHEXYmPUJK1lzlGbBAGvpTBFaSZdctuD16vHwy6rVeIpPZ5smSi?=
 =?us-ascii?Q?ILqxIPRNKR5ao72/QRjU4tDex5327HAVwDJ+kSjcecw/j1l48n3TJq01jTAv?=
 =?us-ascii?Q?lsiPXKH+OioG5i1P+xZsMNeoo1u2rxP9fZhKH8XWMRe70kdfxBo53SyoJ7+9?=
 =?us-ascii?Q?BhVmSS0+FcPTZnBsV+loiR2rH/HI8v+GXqlzCI/nLMXAC8zN6mSBNNqaN9iy?=
 =?us-ascii?Q?6WuxirrWtikEq8zi6bLzUyFtgK03egwKYaGoUzg7sffaY6iFif+jm6vJQAik?=
 =?us-ascii?Q?nCcb9uqHslEYDuyr1OdubBJ6ds8paQgcTt11om/zKf7baTuxTlKMDtFEKAHA?=
 =?us-ascii?Q?qisTj1P01tj6Qa5Qm5YDJe56VdPrzmTl4a4k+t+qyfQy+d9hd0CAln9uAXzG?=
 =?us-ascii?Q?SkjIJPpXyfX4aiM++cRDkf8X3M6LWNFwi8N50TYg2x9xvDefuWTy4uMOl2wP?=
 =?us-ascii?Q?lzf2Y5w43hhPvB2zf0oeZjYvsA/Dn1Uso8djlUd10B/Kv2+W8AFT3Px9rprE?=
 =?us-ascii?Q?lB/qdJ4uDV0zhB0/A3QybdozE23YR0RXB6Uxj5xLFmRV5Pylt0eG9pQicAhD?=
 =?us-ascii?Q?EhdJ0NafgdgZWmOxTF02lVWpC1ws5tI3mu2ntkTJdZshj6CvZSD4vaoiYfCv?=
 =?us-ascii?Q?t7fSN1hU8FzcmksWukKsi7tQLBCSn4FcwGCn4Ey9QrFhjag+XuJrt3WOOwy8?=
 =?us-ascii?Q?aKKTAwAxJhxykVyElF0tERphkObwcZlPfTS7Mrt5SK1n5yN1q7rsouEogOEw?=
 =?us-ascii?Q?9Z1L/tUwgNtMNnTITUU5BUUwvDFtnabXG5TlTQBnY3vIX+6OSl34WK86uz8P?=
 =?us-ascii?Q?uiCB8+77AcWxKkdYvAxbm3dTHu/HxtX6r1LYgALKE3N5lNf9gUPqhYT0yGq8?=
 =?us-ascii?Q?iBYXBhrIA6f8yZJfhB3D+Wsnvp6ILZcSZiYJTmMUdlWSHXtsgGpuNjEM1ntt?=
 =?us-ascii?Q?YvmipzC2DvOdPb5S3BXCx6Jo7Huf2OgS39osLv5S50yTEtkeW0VN4JyfbaRl?=
 =?us-ascii?Q?QGvdRxNWw2SYpewHzVIrhF9a8AL7K3sa5pLj67c+ZSWD3zg13GwqjwqKoMH7?=
 =?us-ascii?Q?r2Js0Z2uDwHQ5TKQvvaNjY82kpPLej0nYPxQFXvro+in/Ynk/aVu2Uqu9Xy+?=
 =?us-ascii?Q?kbKBElz3iW59FwjHXkCAwH752oaIL6RZgPvbSaEIVuZeWkUhYhwEbFLRAzan?=
 =?us-ascii?Q?MkKBNobYdTmofLSXjCRoIFR1Ssfwj0Le18FybZEr75W+7Bx7F1VEeMM+ufDd?=
 =?us-ascii?Q?rXzyJsQbEojCPdbaPzidYTCC949B8XFqq4UJAna1bSoP+C6vdJMmp/xBSSBY?=
 =?us-ascii?Q?0Y+lc51GF/RmSJp5AP2cjRScpJbeLvCYAiTC0j3fwAFAQanaddcRYgRhNbIT?=
 =?us-ascii?Q?EaCSVKkQINeim+WvVXHDfLuspl0UtKX4hPEygwGkn+1zvWEGGoi3?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 101fe19c-b9c4-4b6b-6112-08da4585d981
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB2893.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 17:24:01.2041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zNTRkNcnctuRilFd42lPUwKNRBGzOjh3GnKlCL7DGR+POVXanOMepWOPc7AX/12filyaceixBbug9YVhdiD4M4Y5ghIh+PhnIx5AwUVvRNcDQ+1MR/Oc6rAmt1BsjYmf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6335
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

D Scott Phillips <scott@os.amperecomputing.com> writes:

> Similar to the situation in commit 9049572fb145 ("hwmon: Remove amd_energy
> driver"), access to power information can be used as the basis for a side-
> channel attack. Removing unprivileged access to monitoring information
> would effectively make the driver useless, so simply remove the driver.

Well not really useless, there's still baby in this bath water.
Specifically, there's no reason to remove the temperature monitor
capabilities here. Sorry for the noise, I'll come back with something
better thought out.
