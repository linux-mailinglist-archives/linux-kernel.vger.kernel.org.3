Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA674C4B6F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240662AbiBYQzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbiBYQzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:55:19 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2106.outbound.protection.outlook.com [40.107.244.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28041592BC;
        Fri, 25 Feb 2022 08:54:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5RIRotwAh+8Rh4Ey4EmiV4dWy2tT0esEPub77UDakIR9gDxC2cKO0ukEPGPUqHN/IPSLVjFxWxRUob2qOBofSJGE6KBV4k6sdnxT9YzrZaECMvPWPC9XOiUoKGVZohnurTujOvebG3bJELJUg0jCYXwh4yOW+107kERlbMjwc0oPm35TtFwYAywRl9+x60DAW82703OwCsnp6WSZkAR+L0NCoDS8Q+F9rHq+8mtkuk840iQekKaCO//5bSZllN70lZE4jjNnD+oAqO0SJVPLJDck/AKnURk5pclkiCwamadWq7jRI51Q8mM3lmZWS5Vq23GY2EJ9SPeT0C5RwkW6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drZRWbTN2epBq0hBJkWkZ58NrTkYevQQ/wyoSkuvyOk=;
 b=NjmHOTDUjMekJ21d4GET6cPbSbMW35LgPdUT+LcnKZKw/jeMhuKzl8cJz4voXdAgTsoUTFWjtFkHUogVAukYBzyfQXRF8vTz+Yf/1DsYNtO/Vg+2rXefXzNpHHejrXTWdyeQmZSD6uwCFPHTTbiG1pXod/fCagOuvl/REGUMbi4n0gOkC4zG5HMtduG/lmyDprRTs9ndGWkfxFqjvywD7udbA1DQuenOMxQSVZAHwkDH1nTjEC/AX3qavDihjX7E1/8BHkA3uEC4gCDUiE5slGrN+FxoWZAbjYW9vRiYdokUU/hdIm9+aj1QQL1gjX4R+MdOVgBRSRQsXOiG12GPew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drZRWbTN2epBq0hBJkWkZ58NrTkYevQQ/wyoSkuvyOk=;
 b=pKB+yq35aZeUJ/K8s3oTgT2Ay/CdO3IVX1zruDRQyNkqGMmRPuADbNKvYzYO2NxgGjXqgEMgdGrr65zaiEguqtubf9AFj++Yo9eFh/xwRa0dtZGtxRiiBYd9rHtQ09D2BXO+Q4ucGgOk7FFxhmK/7NkdXgRpbNvP/TCGJ0bKr0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by CY4PR1001MB2182.namprd10.prod.outlook.com
 (2603:10b6:910:48::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Fri, 25 Feb
 2022 16:54:44 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::7c:dc80:7f24:67c5]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::7c:dc80:7f24:67c5%6]) with mapi id 15.20.4995.027; Fri, 25 Feb 2022
 16:54:43 +0000
Date:   Fri, 25 Feb 2022 08:54:46 -0800
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Michael Walle <michael@walle.cc>
Cc:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        UNGLinuxDriver@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/5] pinctrl: microchip-sgpio: wait until output is
 actually set
Message-ID: <20220225165446.GA4704@COLIN-DESKTOP1.localdomain>
References: <20220224161021.2197263-1-michael@walle.cc>
 <20220224161021.2197263-6-michael@walle.cc>
 <20220225092427.jjilv3qo52crsmuw@soft-dev3-1.localhost>
 <2f8a215c67269d639290515931d10b78@walle.cc>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f8a215c67269d639290515931d10b78@walle.cc>
X-ClientProxiedBy: CO1PR15CA0072.namprd15.prod.outlook.com
 (2603:10b6:101:20::16) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba4054b1-c097-4d23-0f06-08d9f87f8561
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2182:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1001MB218264087739E75917A3F8BFA43E9@CY4PR1001MB2182.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qRppEVw8OyUm7TTJ3MffOdiHMlu3M88CgZT+NtoqyFnWpxsxv1LfDC5rlwR0PuI9SlbqDJC32bkEzunvZ2FE1EEb80Ow7a7/C9qQjaRFxRBy6P2yfrj185tEhEQJP90tABBs9izFEuMpRcwG+T7ZFH/QD8ufOfHBRVEBjPvSoSjCM1+/4MYjLEzSBNUMixW19ro8EXpBKLBpx/EscIiSzUYXRRRMGKXw2OAqMHa9Sz7d678Y++sScTkTtaZ27XV6wf7JzlMZ84Co38z2fP1bnXnTQ/m7nJYd40WMoHIFOB+HQ+TwNLoEkRAfs6Q1S9PQJJQfd/K2qcspTzTxOnordNFXK/AMQWRBT05PCaw2K3LKXIercwe7SED4ds8leu+TDxRWUrayXINU9AT0loWZtq3ScG4pfdjBcR8YJ7TK/VzzLZstw+EPmvXBwYRNtHw9DRpMT2iPMxkxPXKLeQhWeGzgkjoxUwMb60btszNSGG4NxUFhHk2c9a9fFu6ZQVZMn15PNxD59JYu+oKBDcv/KHAzgLEoLWAC/yWsP5Vz14mefkMCkYO6NhW5XevsRC6Uf3JNt9xA/G+EmVuyB/kCQQ+ZElvwZdopNK+0xVauYJGIuf+6Jc5OM0f49Vp8RsTYTU8MlqypwRAnsXNQGroz0YduZCmAmaaR30xN/8YwlxAgq60qIM+hheR0Ff2UACMMu1H4iyMWyeDJvWBrDPThxR9bMm+LivImbIeNfZIzPZPnjXdfJO97MWnQ/GDYB0IjC52BDisRWIjovXN6JrYX4SjoDYOSZ206M4KM92+YKdI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(136003)(346002)(396003)(39830400003)(376002)(42606007)(52116002)(6506007)(1076003)(83380400001)(26005)(186003)(6486002)(966005)(6512007)(9686003)(508600001)(6916009)(33656002)(54906003)(316002)(66476007)(66556008)(4326008)(38100700002)(8676002)(2906002)(38350700002)(86362001)(5660300002)(44832011)(4744005)(8936002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jTcYbLfL1VbN46kSxnjbj3cpXZCgZBJsNOu8nmSvmretMw9nbQbPfN7HOFNu?=
 =?us-ascii?Q?67BKFOeH66t/nilZb12vWSTHjotHsjuEVGVjDuHjJc9TfoYFBNNFQjT467Q/?=
 =?us-ascii?Q?1K8x2vi9DiRvqHgsoCDV0+OL6AbfqT0KfMHdAyJGHBMsagW26mB1HbElzSne?=
 =?us-ascii?Q?I3vSFfDFdjPj9Igkx73wmqBkGd429/XHihRQ+f9GeLb25UkWECdcjBvhiS9r?=
 =?us-ascii?Q?9A0a3CdmjgloRA9zFl3O1pxB5dhMtkY/ooUROMi6JBSlIw1rNxVJHsoQTzfj?=
 =?us-ascii?Q?R0urRdVqNn3YYpGscvjx0dm0jwVHGlifZKs2Qm5DKJEmzwkMXlJMA2rJfYzU?=
 =?us-ascii?Q?tTHHTGvUrI4aaT1zKINIr6td4lmax985Yq4bzXyP4Yf2BGrnCV65XG/Cmgd8?=
 =?us-ascii?Q?0I2FjKa0GZUe1CkyIM+2Vek0k681mpAHsVd8lvxh5ryvdtNEjp1xySwOBdiC?=
 =?us-ascii?Q?6fvQBP8CDXlFPrZDq0nedgKocIh5ku3aYGYKKMdzCYjWPkj64fa9GN0+9UHl?=
 =?us-ascii?Q?udAG8epCevnr8uaVLr072AoKKGNPN45kHG/AOjwW5a5R2PcJcIYnJFc85Y06?=
 =?us-ascii?Q?aplXo5Z5jE5X9cO9Us1CxvSanRFEH/SmZ2I23U5r+eeg5MNRd7QKUg1S1JpP?=
 =?us-ascii?Q?ae78rd2Gh0HqLyxRcBrqql1A1aMInnSkCb9mYQSuoQ7iqv1bjQ9NBtPid5+p?=
 =?us-ascii?Q?tOBQdn8nwA8wzCsRC62nOmtRlo9V+NhCnhJoD3FEE4aQyhZCPJv+v7LoaoUl?=
 =?us-ascii?Q?4iiUyCjvBfFhkg6ddFzRHI74OYfkH3v/WuIN/M5JArAf6VZ6jfTTWiDoJXBb?=
 =?us-ascii?Q?o7QPT+hA4qtyUhqeH9TiKETFN7wIw3Ncrw5177cdRn2AyDG3538r6euhA6q8?=
 =?us-ascii?Q?6Y2z6ZY7pohBUYvY0sHsqiwsKioiwfDAyzBkFFhHAwzg/CxFh5Jdm2qEbs3F?=
 =?us-ascii?Q?iFPV3WaDC7+PxAPWoZZWd9yAO6Rh9T21vCHmMU9wWMPM2De7VVWOHHgj77n+?=
 =?us-ascii?Q?K32I0zxmYV1Yd0uUydtyMkwmfcB32DvXn3B1VVPYsPInlUmtflQi4jj1EQsI?=
 =?us-ascii?Q?gqJ2bZy8aEPgCwYtWqTbiUsYCO3CvdTdsATtfhm4BljKhHq7mR+j4nx4KEbr?=
 =?us-ascii?Q?Uqej3BcGwa52SoDnSAhg7YEbi2K5IJ2FKCcSDlPlrZBu5KRo17lJTM8TbD1E?=
 =?us-ascii?Q?An8hmCuwoyYW5MxcNm1eqoOJc49z1wzKeS7+79B6Z7DWEVX0gNr+1FGyIGes?=
 =?us-ascii?Q?zXcU1V4MKm5/68FtQR4FMCf28lMcpI8TCMfS1/IlkNV5nLZe/6TBAn8Oyc+M?=
 =?us-ascii?Q?VEWlGA06Ac9/Zb/BS0qZnRGZrr6OobfwOGm4X8UkoEkUU1p6+aHV1YCCof+4?=
 =?us-ascii?Q?68X/8gv8ZjRvLJujFn4ruPMDSuRXi4N2ZDGyN0JzgMEJR4Po1TWGDaoWiZfx?=
 =?us-ascii?Q?PdYMH+7233pwczCRD708xkMuzykoCak09KDj5YFrI6ayMp9G9IpJRzdt3nUg?=
 =?us-ascii?Q?Gfb7PJdsLsB9VPUq7LeAiXZ9+EM4UwUzRckIVm5FLrWFoNjsXprZzDVn1tDd?=
 =?us-ascii?Q?h3ERVCxI1M3WKwwzdb13+bsXshit9OPmWJ6If7eUCBSIkcAQ7U8eQeVWUKN3?=
 =?us-ascii?Q?Aq7RL9IVRjval1Ug3Y/6kuIjykBjlKaQc1CkPfPkouxYNv7tO26xVFJcwVkq?=
 =?us-ascii?Q?vsq7Rw=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4054b1-c097-4d23-0f06-08d9f87f8561
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 16:54:43.5026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7J3AMxOdbVwTXF/5r2iy32ms7ROMFTnE4GXSDeXOwGtfcmMuMBvLyxugwgrS/w27CwVTzACgU+zj/d1tO8fqQIKHNR7rlwWAGlMMeoN4O54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2182
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Fri, Feb 25, 2022 at 12:29:50PM +0100, Michael Walle wrote:
> 
> Could you also have a look at the other supported sgpio block,
> the ocelot and the luton? I don't have any register description
> of these.

The current supported Ocelot chips are the VSC7514 (link below) and the
VSC7513. Chapter 6 of this PDF links a second PDF, and you should be
able to find the Serial GPIO definitions in DEVCPU_GCB:SIO_CTRL on page
79 of that PDF.
https://ww1.microchip.com/downloads/en/DeviceDoc/VMDS-10491.pdf

I'm working on support for the VSC7511/7512, so I can run a "does it
work" test, but I likely won't have a setup to test the corner
conditions this patch set is addressing with any confidence.


Colin Foster

