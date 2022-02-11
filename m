Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E684B2749
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 14:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350605AbiBKNh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 08:37:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238948AbiBKNh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 08:37:28 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3404E195
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 05:37:27 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21BD8Z6v019101;
        Fri, 11 Feb 2022 13:37:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=ZZrwY5CJcDPDQlFG9cu/nE3ioqrFsnfgXGM2IBVQcEw=;
 b=KwqTJRz9X4sFsccLW9tkVG32EelYdYSvcblws1etJYra1ZHnq7GuE5LSaZeLxXFSvXQ/
 7mPABb8xBLFuhznV9gklTMxgdJSTKZZrre+WpM+GGJz5UdWv/lGiy/kzAmsT488+fP4m
 gmR+92QkmEDN4rhMw1IkuP9yWxMxjegDDO4UMT0W6bbQ7s7IuLRZCRlW7Xq952/3M8BS
 okMeFEnek1M8Ui0tT10SsU4RJhj/ayPTQSwlbyjAuYnR+db80ppEO9P/Y3kbkHyMl24V
 CvKwy+ZnEVuS5dSfkWe3vj+8szVIYNY9low/rUAz4DZxJm80qN2N76YnfKwbU0g1u/ta Dw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e5gt490e4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 13:37:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21BDaXMo131861;
        Fri, 11 Feb 2022 13:37:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by aserp3030.oracle.com with ESMTP id 3e51rv78w2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 13:37:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0Qfzl8wWcM4whiNtMi/ObRho57lAG1inT1Z4QI7a2LxhQWcxKSUZc3iaW5Eni8vfr7DhI9nNDNC/d2Tpcq+QD4DBtOcG0EiN87m5IpNKs+CrAYezQq8MgmGHxaI2DYcFugnXhjGy804jUdvn8pGEFhOXyFWbD1uLOi/g89QNTqo9pohoBGdyHVBKhMmpNMfBPmOTvwk2/L43fcwEG5tBiv4P1EuSF/xt5vYAqvyoDZMZiNwsmjhYHc8B1ZRrp299WEsvZEPBmhwiDXGoAQyZv67A1zATk7Pf59gZB6MOuz8hSF37aOpcCfD+pQwlwfE9reuDzDX7iwjsO5UzTiOtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZrwY5CJcDPDQlFG9cu/nE3ioqrFsnfgXGM2IBVQcEw=;
 b=leTFWipENyjLKKUIUBhLf+a6cFMh44cZs1yjuiWZZ4vojmg6W/dfk+Fi6bf+FuAHI6tJvI7WXsCyO61umfap5hoP/LBeYrs6AlNArSDPKyB5dSd2hx99JrfjLRe5oNDWOGWICDYgbafqu0Oq0G2Rfsd8lEMB3l931+V2lcAQ4wfTJu6DrYBwKxLdkgTOTMpGamkHBdWCtMcFmZR5n35hPcOFNDzOZDuOTNOfocVMxcFt3YPfHwOcEP+RLyTAp6V85wN0GV3v4jHrExcJn8gZU2FRIwGimChTh44Dgtq2cY+6aGMlX+oXIdezWWeyekpGigLg83OOTWd7vDSLduVm1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZrwY5CJcDPDQlFG9cu/nE3ioqrFsnfgXGM2IBVQcEw=;
 b=BxSzXKUTj9Rjk6EDgTQiSRtD9muYsFnNvNjbRCunEgrykoxkhAVNogYTiZc1Lw6idEcisjdl6bhUrdHFGHzHcTm6/1oeG4fHNUq4mDIX2IDc+Rg5YJe1oSBfo7Q5dGaopQFggIJdLIgvj6BacptukDZfVhszbG8huwfJhaXgx08=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SA1PR10MB5841.namprd10.prod.outlook.com
 (2603:10b6:806:22b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 11 Feb
 2022 13:37:19 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4951.018; Fri, 11 Feb 2022
 13:37:18 +0000
Date:   Fri, 11 Feb 2022 16:37:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tudor.Ambarus@microchip.com
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [ambarus:spi-nor/next 1/15] drivers/spi/atmel-quadspi.c:1202
 atmel_qspi_dma_init() warn: passing zero to 'PTR_ERR'
Message-ID: <20220211133700.GB1978@kadam>
References: <202202110830.1OGwXRWt-lkp@intel.com>
 <5f2ddbf7-381a-870e-e533-5261bbc9337b@microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f2ddbf7-381a-870e-e533-5261bbc9337b@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0025.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4d661de-a740-43c1-1bcf-08d9ed639f6e
X-MS-TrafficTypeDiagnostic: SA1PR10MB5841:EE_
X-Microsoft-Antispam-PRVS: <SA1PR10MB5841EBC43012AB37EB3ABCEF8E309@SA1PR10MB5841.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 94q/0fFRzO+BjyllpZJkwHt2TA3C3v7EDlOyNj3BZ+BGUoBzI+HIFBsljEc8wXoYL6B7/lgTvZXqB4KnvqdmNt+EKmIB7C88B6B7H2e7kxjUQBN+9Gk1Za2YB3CS6qPKROFWHxTuYJZWN2WVWoTrg31sVCc19RUK7XqIBwxYRdmyJBwgEfeFj0azZmBmx65FGDTMrGhuTineGEt4Cp8r+WTUvIVqsQZHlhUEwgo8qbW56yvYE1Lmjyqia7z04oqFVBDvP2dtmzl5KDbfzWN7XT0qrCgxpi4fNLyQdQfzBgu3vSgByn3CjTC7p3Lod5IDm6WGG/a51So5uGP93LvLVMk00CKw69bXCoopICwdj3KA0ybf8IBudX/GlYZWkdTUJZU5EGlInI9GuhB5YAJzV7l2Cogln83RL6wxBfDA58wUzvLzZEaD0tkqcFqrP+R9l6O+oyItYnfP0AUrguYpA/PEKEeE9VLXryxtUQXLZgDWHFPIDc+M1IzfhMnwW0E7S8env4Pq71uEXPcdL6sAINpylRPBREm+n+q6PTzh8bt/rr+7whVa7EEkPY8foN6bRvIBrY59wc6aRtOcBI0ODTOkUqTurowCGU8kGrw3oit1BLIC1EwtK4hCO+mpiPILHfxfXalSpCAOOy7C54KiD5GacawWK3AAsh9pa+uKREw+sXn43a0jeDH9k/90YEyYE46Zt8hBQ46kijheyxhTrFOwQL5/f4eQ/50G2o6dUQS7J9svlcsv+iGuLlR/uJsGkkxCgMlL09DHfXsM7tD21P+LSNbLPMXLFkm9jhDkQOSm173NB/ro/QhiuU4u0OlgBeHWDnLdtc/PB4HrppCOZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(8936002)(33656002)(33716001)(6666004)(66946007)(38350700002)(316002)(86362001)(966005)(66556008)(4326008)(52116002)(9686003)(1076003)(6512007)(6506007)(66476007)(6486002)(8676002)(38100700002)(4001150100001)(2906002)(44832011)(5660300002)(186003)(508600001)(6916009)(26005)(53546011)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7lfATjoJufffhvIbUigk0PiZWng+6p7aSj0A4b4iEP72WnGhWCZekzbV/mZT?=
 =?us-ascii?Q?aNyw0DPQBYMZRbOSCgk1kkmhNm5B/xq/y1AcktxQk+MKgk8G8EBBcfBBN0a6?=
 =?us-ascii?Q?kjVauWZoSOklh0HOs3N6jPo3h0Bj7AFQNk0ej4IzgPewuANohz0zGUznLZXW?=
 =?us-ascii?Q?idQWOzSzzV9+aOqjEjF7mYBtbKxSrUJrCbfTPiQm9DednlqXTurCBVbZpYk3?=
 =?us-ascii?Q?F+TSWyh3VkVcphyTwP5NXufmI+Q3ntuY9aGMVF7g9VstLWoib9mRF6Miy+ty?=
 =?us-ascii?Q?0XCJpz6j8CitI4Tqoe6iVC+/Cy+4zTv+eV7CIxoD0ZBYTGN13aLU6BW+htpc?=
 =?us-ascii?Q?T88I5mklBzzl3LMsq9PgZ6JSVZo7XleAa9FKtwTWlD/x+UQ2VtTD+tHEvK6R?=
 =?us-ascii?Q?jRD2BfbqdhMazltBemHWFka7o31luuYXwZF6P4BDy3QqqmYsbK8BrRwmRdCW?=
 =?us-ascii?Q?6MySstZY+W9bI4vI1V7Bao96fByK2kJMtAaYeSuBBxT5md0bXCveLON3Dgt3?=
 =?us-ascii?Q?H4Su7prRwPvHb2IWcTpByE1YKIfy46jWDvYKz35ZJX4dIp2xXj3QFtANtn0k?=
 =?us-ascii?Q?pGxwGFfRZsBrQJ1fYUh0t/pQWkDgJEMVfrdeCxsRJBAlJbor/Ounn+NZzteQ?=
 =?us-ascii?Q?MtIjwVdXLnOrd8fSdGIFWf/bVNLQp1XZ/sTTszReKF6ESTnLvqmI11POQmus?=
 =?us-ascii?Q?smnsnZIcwsohBvXEbg2uOBDGQ2Yf1GcU8MlE+pRi76/8KBVi0dcSDNXyeVIR?=
 =?us-ascii?Q?9p8R/sxYZya0Hz26BeBBqrQZAm/RiVV5Fg56K56jdBc2slD42Q6hsgp7kOEy?=
 =?us-ascii?Q?11X56PNvJbWvdd+MI/feLhZosdi2kVZDwjmnH4CCkZFVvjR1SP/LlU757xiW?=
 =?us-ascii?Q?bpR45JbzPhfofUOin4oSZ79XMbUJmC7r+VVmwm0Tr7RYh9EHjJGylvmmJKBa?=
 =?us-ascii?Q?blyxCrs3YwbCq5awxs7h08aOYFTEV/POa5vXLWS5P6ivzX9iOmgow0t/tuX/?=
 =?us-ascii?Q?KZzOZTaW1f0RxDsFgAPuhR9nNdojj3XstlAauB266Ir6wS3aYkm/9VewAmZf?=
 =?us-ascii?Q?6Wj7OCd9jyke0cuql65dVjB2sfB+UhGnhdTNiAwoxp6+LEnvrFb1W6YLUOpd?=
 =?us-ascii?Q?CJqx9WgYb7xxnKzqbU80YbUL7cmHZbtlBbKh/LgrWr1R27yb0Ru2tD/X7bDm?=
 =?us-ascii?Q?2arrf9HlSOMMit7aFOZNW26F0Q0xpISAhz8g1mdzje1vucklkOPUK4hOyKOy?=
 =?us-ascii?Q?ua+vleXudLejsMC6yeb+/5xDo2b4l/O946M8I4rrboSf5+EzuBHNi1ea5CN9?=
 =?us-ascii?Q?4+Olr9ruyd+TscDvM9rp/HSFFnBHOKT93gaOvCSV7ooveZNbCbSEceCXYUOk?=
 =?us-ascii?Q?kBSK5p1T64zvc6ecJpTsNMwk3zQUaZFQmErbiAP3ceCRYtmdhYkEL1vzTnTj?=
 =?us-ascii?Q?B+3eCAAbcD4Db7DiGMADJPs4htIZvBRnj0Rep2Idv1i/xgb6iTWcUwo7aKpG?=
 =?us-ascii?Q?Bn7dP8vFzElRdmOBitiQZHHI3X0x1M2S+dU1fcW0v/9QYGeHq9JXJUN++Odc?=
 =?us-ascii?Q?xuxTZOhKacZVQHhLX3zRuMcOVYKHYf9TkCB6hqHSfImbDzYAGIeDDPXnQL4j?=
 =?us-ascii?Q?exPdRKGsxE+i3QmcNgb9PPLtnNQNJgsDpGx9M6SGBX082uiftEfo9gbUSN3A?=
 =?us-ascii?Q?WxL/FA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d661de-a740-43c1-1bcf-08d9ed639f6e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 13:37:18.4786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSfltxSK2kD/6MO48IYF3zCA9UTt9b/9eML2sSdfHGKK1kDnJ9tP3VfKfaHayIu50LxGBC+hCExcqt/IIoUyBoDBkhKHiYLAoA1UZQowyUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5841
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10254 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202110076
X-Proofpoint-GUID: 2kDAZZ1uZx2kXcQrchNxcECjXBgbC6yA
X-Proofpoint-ORIG-GUID: 2kDAZZ1uZx2kXcQrchNxcECjXBgbC6yA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 08:30:48AM +0000, Tudor.Ambarus@microchip.com wrote:
> On 2/11/22 10:04, Dan Carpenter wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > tree:   https://github.com/ambarus/linux-0day  spi-nor/next
> > head:   038b3fa2d89f1a00fdb8767704cdb799a0fe746b
> > commit: ff51c966a3c5144ae964797349747e680ee47c3a [1/15] spi: atmel-quadspi: Add support for sama7g5 QSPI
> > config: openrisc-randconfig-m031-20220210 (https://download.01.org/0day-ci/archive/20220211/202202110830.1OGwXRWt-lkp@intel.com/config )
> > compiler: or1k-linux-gcc (GCC) 11.2.0
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > smatch warnings:
> > drivers/spi/atmel-quadspi.c:1202 atmel_qspi_dma_init() warn: passing zero to 'PTR_ERR'
> > 
> > vim +/PTR_ERR +1202 drivers/spi/atmel-quadspi.c
> > 
> > ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1194  static int atmel_qspi_dma_init(struct spi_controller *ctrl)
> > ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1195  {
> > ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1196     struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
> > ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1197     int ret;
> > ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1198
> > ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1199     aq->rx_chan = dma_request_chan(&aq->pdev->dev, "rx");
> > ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1200     if (IS_ERR(aq->rx_chan)) {
> > ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1201             aq->rx_chan = NULL;
> > 
> > Need to preserve the error code before setting this to NULL
> > 
> > ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19 @1202             return dev_err_probe(&aq->pdev->dev, PTR_ERR(aq->rx_chan),
> > ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1203                                  "RX DMA channel is not available\n");
> > 
> > This will return success.
> > 
> 
> Indeed, thanks! This is a personal development branch, I'll fix it inline since
> the patch that adds support for this has not been integrated in mainline yet.
> I'm not sure if I have to add the Reported-by tags or how to give credit to
> a bug spotted on a patch that has not yet landed in mainline. Maybe by adding
> a comment in the comments section of the patch "---"?

This is an automated email from the kbuild-bot.  Feel free to ignore it
when you want to.  I just look it over and hit the forward button.

regards,
dan carpenter

