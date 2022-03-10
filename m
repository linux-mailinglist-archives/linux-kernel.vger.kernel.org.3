Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B8D4D53F8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 22:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344181AbiCJVzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 16:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344171AbiCJVzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 16:55:19 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2104.outbound.protection.outlook.com [40.107.223.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8989F194A94
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 13:54:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wn30G5eGD39FC46/ep6aTBxnV4yT4WeEZ+FRe16SsIS5XsdYnSge12e+YCrNXl3vKD/6BMU8vDAW8x3VsylRlJ9xxHo83Mw0xemp40q347c+B+Zz0VlTKtUX80hK9JdswETmF+oXORvFcxkEQ5mI7//4dfR/BLA1tNJzJIQxPqCECHOIFMbFGYF2VY97UHV4Evt1u+RCcg+v9TfyBZi0XTBn4FziXSQUA1PVmuJXpeaGF3aEQ3kHSD5x9CcMY30nMhH8Cpjw34igy21SF3o0qvZYUikXWbaWcYFATM1LkOIlm7+c0mE05sf/ynDmEWrQc4PFm28hwqqXVGwA7GS2wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bRbqrDsoMvJvuZLki3XwBnpZjiZ/6RPISbPeLy8vMg=;
 b=XBa7WmlrDdpOlTokvw9ifKkCbMB1Fh3WXnrgS4og5wT1Dj9D64+9PAN/BlqMcIwmjf1MooUOW5jjBEjQmYEt+cImk4Euo1HOzzxtM22LN7Nu/Cq2CgPuJO8rHkDbqe8ozl+JHfpjmKNf/S0tb4p8w5SMEs4BkEw8uZrvqwrXRGUJSgNUyL3T2SKK12+5Q/CtF4b9Cnjgf9pIfYMLprb2uBJDS930T+6Tw7Bx8/7gPp+1a5s6cL1qdr4YjHy1nlxiiZJQCmYuCt2sO6vQZjzT2HEedWumyZk1ajutmiLaW+1j+73hS8oCjVSBH4JQ3tT/OcIE9eV+RyNTGsobJWAg6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bRbqrDsoMvJvuZLki3XwBnpZjiZ/6RPISbPeLy8vMg=;
 b=fgBYTjToOof4bZR+6pyn/DOUsgXlDZjPy8vpPYYGak6H4EoWwWktNtdiIj1XBlpeO0PcAdBA0QNW+JU9Ia/sgq2YETHtq3yK0K/6CvfoIJNlc7SRV/ak8ZmFE7tG6vs98R8Nb2MsiTtyDUOye9UHvc1CW87Ygl4xg3D+ISWWjqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by PH0PR10MB4805.namprd10.prod.outlook.com
 (2603:10b6:510:3b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 21:54:14 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::7c:dc80:7f24:67c5]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::7c:dc80:7f24:67c5%6]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 21:54:13 +0000
Date:   Thu, 10 Mar 2022 13:54:08 -0800
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Asymmetric regmap read/write reg
Message-ID: <20220310215408.GA3149079@euler>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MWHPR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:300:116::20) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78af5b52-3e52-4614-2eb1-08da02e083ea
X-MS-TrafficTypeDiagnostic: PH0PR10MB4805:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB4805698914C00C8B9024CA8EA40B9@PH0PR10MB4805.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xRwVbdRgGatiicXtieT1SrgS+cLKByUmecJ6od0I+0uxxq+eT6oMl4iqYjxe3WNCsPnFJ0sg3e5f40ZF3w7VcZg9EG74Wp5h/eIl4xU3p2bGWSze2AQvDKlFIW0YHGx9kR3a7cb/g7Gdth7GP0i30RoGCSuD2KpDtcNzLb7JKv1HoEaFNuczgCmSKdue8jDX6M8+OVs7u1hNKqHq6AK5S19JHTmv3TYIo/O+R52xr6SvayaIsJGPH681XUyYCUVmh+uwQRy3DztJLGPsNQUN5cY+fCC+2wSzq0ReaDMQO3lEk37vkMf62dqLgobzoKX3ysCPucxgsZgJKjA/vqNEi8CcmOhrvwJoUnopDqGQjWYuglTYJxLRsFrwQyAkksTcjDEftYl+HiPv7I6STkucYPIHpGeR5zwisvRyeuxPV8S3XNyhBn0h51tMy4emeamTfylqdTRQfaBtloPeRukC/gHIWgpMvs1KMtqWkLBzV+eZ4+6g+5FdJrq5P3XYeGz4pGECr/m+5/bAilfgDDO3UpOZZVBXsPeSrh3JynwHS8PY1bSorPKe9ejDEqUQLmIgc6jsPLHmkP54KfAM+d0QTtRp86/Mky7Th8GAEDkia4k/4OYBhy4oELJa2W644uHGgovOPz3ak3DtRkmLyRPmYD6fKoT+q6Xelz3bCmLeM2bfzzcFS1faZAYrA2ZasS8FcGtwHUqF0TvHgflK6s8sD05PY89chb5bh2Sb0fqtFb4VC+Y8/uQ44HxnU3/2mJk2Tt3Q+uKb9LAxkP79mm8OjrG9SEUfa1hKuzYDH99qsUc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(376002)(366004)(346002)(396003)(39830400003)(136003)(66476007)(316002)(508600001)(4326008)(966005)(6666004)(6486002)(66556008)(8676002)(33656002)(83380400001)(8936002)(5660300002)(66946007)(38350700002)(38100700002)(33716001)(186003)(6506007)(1076003)(52116002)(26005)(6916009)(9686003)(44832011)(3480700007)(6512007)(2906002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GFU0l5NrcR+SeDV0NWF0/yeOVLt5vAPnB9lCQOGIqAUGt96tZwwMBfYkBFOE?=
 =?us-ascii?Q?um0WszyaxGZT+kkkCiLHHU9gKU9UwRBmFyxHi595gD805eWwGbIouw0cPd4j?=
 =?us-ascii?Q?z/PhqXbASUjeACsrbOWO/ocr/d4cgJZZjoJvzWPhpqkF+b5GEldQkaqQUAFg?=
 =?us-ascii?Q?U6m8FZjns2ON/2kyWhBrco7g+7SWqwj1xsgqy/yHYCOxgY9ZOJzSF1fRK+Nw?=
 =?us-ascii?Q?YYoKDB4wZ2wQt8CotsKH6AR0Kn1C/GkysHVYi7TK0yDNIhmqsY/FX7XuaC1S?=
 =?us-ascii?Q?+mnyiYgDx5ALSFUyskyf/sMC33vBmtDSlHm2N4jU1bLCYEpUv46Pl9N3F1fI?=
 =?us-ascii?Q?YIRiYgiH2BCBflGVs2/y3yM7qO47xv0aAEh4SI8bkh/3Hvc5+O8/o1ajKCv+?=
 =?us-ascii?Q?nhlNrW3q3viPP1zoy7oQCW4J/P7NvKVTAPVIqKvFhQtyV+9spK9wNnswFyx+?=
 =?us-ascii?Q?eATlNcT5WWJsdh3CuUxZefwTB2+QxUQTf63/x4b0o3FpVTXNZ85LrdcqCG2t?=
 =?us-ascii?Q?Huu+hTBhsj1frw41qLD8tSXu2rlMQxkQkmYX386TAEiqr7gxAgIa4x4HGG+4?=
 =?us-ascii?Q?ZdBDf0KPlZGrvMuoNRS8FOY0ozxE9hvTtp2VzhUE6XODbvU6506HQki8lgTE?=
 =?us-ascii?Q?PVF2AAHKT4yqsUh/EVYP7R/0UXVwXT94L2XRES3T8VZptZ2tOAb5GP9iMy9U?=
 =?us-ascii?Q?R8tTO2TtyhBONJmFllivNS7XOPdDa6LIkOhsSnAg1l3uZ/iDJOA8nHN+k8fn?=
 =?us-ascii?Q?QXJg/tr1lPenwL3ADJpDruDMiOzymbwaVm/MhrbRIz1p55jkmU7mur8gcqNj?=
 =?us-ascii?Q?T7wveDEr5D5bkJHbbePjqc6fKKi5Hq1tJwm19NAqNPYvo1StwG1ZzIEqQ7bd?=
 =?us-ascii?Q?sixy23gAfQmA049XKo0wpUkATYrZzvVAlvUrUmzNLHXYET31BdVK85h4L6Rc?=
 =?us-ascii?Q?Rg96CH8UlMmK9XKBUsI/uBcpJ6fjr5pIKN6cDaYzHdUd4zKTzgyXArphXNO5?=
 =?us-ascii?Q?1hpg2gUQyZ+5x19xyLZp/S+4d59PDWXqtu1MHmeIQXyVXBxIls9iYN2toQu6?=
 =?us-ascii?Q?oSUqE8kDpBCd7QE0SeD16pazD9jfhxlH1hGOdZm2Qe8DHHdpUqoutCcl7GWH?=
 =?us-ascii?Q?EDuihRoWYgGpQ5Cc80k/JpTR/cdi7/wDWfEwV1TsorTSHIhSDbiAizDDlShf?=
 =?us-ascii?Q?YZywVAgX1juQjwtSVMVp0+Ab+ZwSDAkwu3DWLBj0f3LopqvdFPBNjCK2F2st?=
 =?us-ascii?Q?Acl7pwPtFPL3UNePw/YcflJ5KgR4NIui5cpeSscBO2c7BaFwCgWbTFY+c05X?=
 =?us-ascii?Q?AHhoY3hMzMhckTBCVd/gCH12umg9DnNy9QfxDuRWe3kBo0lbJoeyA6aT9rz5?=
 =?us-ascii?Q?X9+/90xKg5HbC4F2sk7KjOJtVtCQEYxzPC4awuNFK+DwWh2BQM+QLDSgLFL/?=
 =?us-ascii?Q?CgzsHU/L2KXU7ZyamnWfyVJit83iDjw2i/L1NYM/tXvjBTYMoVtR5QkiCw85?=
 =?us-ascii?Q?DjDdNIOtzS/Kyds=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78af5b52-3e52-4614-2eb1-08da02e083ea
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 21:54:13.8407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 89TgRJKJZTOqwjrEDGD6X7oQtFkXtPYk5nDMBeefbp2DRBHusHxsDmcqS081X2xkyD05luz2QE6zacDx6PfO/1G8eKyzPKXDZ0R31NlWq9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4805
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark, Regmap Abstraction realm,

I'm writing the driver for Ocelot chips over SPI. My latest RFC can be
found here, specifically the patch that utilzes regmap.

https://patchwork.kernel.org/project/netdevbpf/patch/20220307021208.2406741-11-colin.foster@in-advantage.com/

There's an interesting issue that comes about that isn't currently
supported by regmap - specifically in bus read / write operations.

The Ocelot chip has requires 100ns between address write and when the
address is ready to be clocked out. This can be dealt with in three
different ways:
1. Use a slow enough clock speed
2. Use a delay between address write and value read
3. Clock out N padding bytes to account for the 100ns access time

Forcing a slow clock speed is obviously not ideal, and forcing a delay
between "write_then_read" sounds too driver-specific, so option 3 seems
like the best option - especially if bulk reads are utilized.

Where regmap comes in is specifically the padding bytes. Reads require
the padding bytes, and writes don't. So this brings in new requirements
where a specific map->format.format_write would actually become
map->format_tx.format_write and map->format_rx.format_write. Several
other parameters (format_reg, work_buf) would also be affected.


In other words: 32-bit register writes could be
| A  | A  | A  | V1 | V2 | V3 | V4 |
while reads could be:
| A  | A  | A  | P  | P  | V1 | V2 | V3 | V4 |
and sequential R/W operations wouldn't require padding.

So my questions:
Is this a valid use-case (extension) of the regmap bus? And something
that might want to be supported?
Has this type of work been considered previously?

My other options are to fall back to a slower clock speed and try to
use regmap-spi bus as-is. The addresses get down-shifted by two, so
there's a smaller complication there. But this should allow for async
writes, which I came across when trying to apply a heartbeat trigger to
an attached GPIO LED.

Or I can continue with my current implementation of just using single
register reads / writes and forego the regmap_bus entirely. Though using
bulk reads alone would probably provide ~150% performance increase.


Do you have any suggestions / initial feedback? Maybe there's something
I'm missing.


Thank you very much,

Colin Foster
