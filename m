Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26894B1FDF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 09:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347936AbiBKIFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 03:05:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347945AbiBKIFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 03:05:14 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0C1CFE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 00:05:13 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21B3q4ne015522;
        Fri, 11 Feb 2022 08:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=Zj3LxkLLS848ZZnNz2psgJMAaLpIOqH+KKBwV8g057w=;
 b=RHPaubAISKBj79r2SRk+KYKbDUNtb5+E9fd/Bn5bJqLa7pZM+Dp/ScxeUVTsnse7GV0e
 66CGhUrA1lUSJrZRZMtgaCqAewqEDOamAQJmqXOYsN+nziBkLbw0pWaNyIwwWTPOl1Y7
 UTzPIDcYbhVXnS/JhxyodOvEi0V9tlU5IVij+PQP3putqT3sr9MXPzBwajR36c1J2TiK
 qXmjTPouhtxSB3JlxhsKPraldX77G97ctcwKknpYg9S9WjLGI7RGJAj2Fcs4j/HXBFOv
 XSX/goJtdnArb6nCPfr2Z3RYuokn4EXToT448ln85bT0BmuKG21IGuWKxH4yEp3I44xS hA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e5g988ctq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 08:05:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21B81gBm101607;
        Fri, 11 Feb 2022 08:05:09 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by aserp3020.oracle.com with ESMTP id 3e1h2brxv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 08:05:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/JJJHhIGzje6SyJHxeCsJgjHGM5xe9wCR/lNq0ayxI0qK91/Sr8WBThLRGDGhe5EPzUmmbbNbEgZrte2G+hGHdr0zf1c9F/mbf0S0Kb1SGUdQD5NMD9wg6WlfAUvdujgjW8sDVeIALmpP99tnezVxXygOAjGj2fKoxZDO0zdGZQseGjssLq9KuflfE8G+fgN/VQjxkCmH2lVl50o3tRWpViaMsg7w07SRmtm95axgDJEm78vbWRPOG3V1nTO7Ju1LMqBb/SI/wLSbrPnw/BbZGdZ7M6oSsPMBnszbpVdMAAoaZVMtG6mKwnKAqqxP/ZdsIKv5Jb5Gh9IeSLzL11Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zj3LxkLLS848ZZnNz2psgJMAaLpIOqH+KKBwV8g057w=;
 b=cLbvV7CYHojX8nkeL+IGpi09m41xHgrR+G+CrKzPIoDy/UNGAzds8+wp+6htJje4NOiSJvgIRCzcJ9FgKSDyvxLB5Wj9Wrni3IEWEf92CuGGWmWesm6TdPX9+ZEpe9PKnB424wXAEtO4/pHexdMyaTi7+NIJULTm0XDeeiR6727HIKxAOOHefO3kAIkpGvt5m8Xtpx+kHsa9C4RAfxFm5FLGeJJFJL0ezRyEhgKbQQSLnv1Dg4qqxl/7uOcJZw2g+tf0BCa3pUU5cTfNijCP7hoxSZfXR2FnJDbHa3/j0xGERDMhRlOaXV3FcaO3NmVZHLM8B48Tm6hLXlTiAPUZRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zj3LxkLLS848ZZnNz2psgJMAaLpIOqH+KKBwV8g057w=;
 b=UOqmQ3rtHd7W8/u7zfhZyLU4unoaPljN0VrnliRs1xCeQzm5H3lX8/ENspP149aPkRGB3ouaQoeYipDG7xafxB+GtWnnDmULOx8NGIVsTGb4SCvuMk52+nspGtsDKn6HPt3bNfa0nirZ35vV0Q6+ANi0nUGeoyczxGy2Cb1A14E=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB2044.namprd10.prod.outlook.com
 (2603:10b6:3:110::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 11 Feb
 2022 08:05:07 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4951.018; Fri, 11 Feb 2022
 08:05:07 +0000
Date:   Fri, 11 Feb 2022 11:04:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [ambarus:spi-nor/next 1/15] drivers/spi/atmel-quadspi.c:1202
 atmel_qspi_dma_init() warn: passing zero to 'PTR_ERR'
Message-ID: <202202110830.1OGwXRWt-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0038.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::26)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f27b89df-32b8-477e-3122-08d9ed3537cc
X-MS-TrafficTypeDiagnostic: DM5PR10MB2044:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB20442629C03EB76BEE67C3368E309@DM5PR10MB2044.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:51;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s0gcme0JAr/KJSsWkLIWh5K/g5KeyPw+7FpYGOpq5jo7Lmuzkcdl+5+eYZRSxvUgLpGzoUGWTJgi2eGlfQf50fkYK8jOiTUrH6JazXFqAYJK3dZaAkQ7uWfKFCa7QL4x9VwDBpLNFNcxCrTReFG+Qx+z+xmBsf8BMxg3kJdJlE174chgk4oYFFUUgl5GAaKD8QrHi2ueJNnKdYvVU8ZtCL0d+veo7qqfGatQ+ali9sDgai+hM87Zuxkg6YZeWVtwp/3LlwAq5+pAWKfACXiLpxLybmbEukvHifBjQq2LMuDk5aQ3FWWZ37sIesGjH4I/JND5YcyATyvrSR1Nh2yEel3pVBaAkcymxUBzAOZ5zU89ngeB2REE99srEeG1PkQk5XmS1mDIbA1aLXSDE3VF/XVg5siXho07rwo9LvPwfx9X803oOuU8U1B5LhkzNMzuLLwcNvrLfN84TKfV4Bivm4YFAmgxUXfrALh6GSE708RZ0oY/UKYeQxLJHq90xySG9uKsw8CVHRAyv+LcE0I8SKJbUCb2n66lfZ/b6HVtuzEixJdwd51rGl8xjFQ1qqfavSNC950MDNl0kzv6mqy5EBcfH8GlX4UwbGYUJ0apHnGahyo8V1h8eAIRRELBgNIcD4/8pwF1Y6USWMbkkn+Lz27S6hbsFPMcMMNCNsw9SPiOT865XDuOppag4AlCeoDl9aGG1Z9Y2GQaABq0Ag4cGpraW5KURqK+8LTmujTx45HpDpE+uw8/ZHAdB6M35xZ7CrBMUfo2Em8bB60JvrivaUg00HxdikMpvaIsr/myRj8UcthFytYby4wqR8yv1rO/KzUC3VbSqga6drVTnTg1lA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(2906002)(6916009)(316002)(66476007)(8676002)(66946007)(66556008)(4326008)(38100700002)(38350700002)(44832011)(6512007)(9686003)(508600001)(966005)(6486002)(4001150100001)(8936002)(5660300002)(36756003)(26005)(6506007)(52116002)(186003)(83380400001)(1076003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VQedxHlLosCe3hJEMcKjBj7tbOLFHsfdQarvwGP2UXi5i5SlMBt8WXNePbAP?=
 =?us-ascii?Q?IqeSKBVOiQlU8uSch6qhq7QVZZZo9OJRiLB3bj1tEpJVukNRORyigR/nxdp5?=
 =?us-ascii?Q?FR1Wi3DZv7Cav/aUIVYs7RnAeHCoOGLWFOrZw/hygW04pzCodU+A+Z25T9bD?=
 =?us-ascii?Q?yJfVfggO1C9KUGZHsrwDVWc5jKSTKNYL9276Y+Xpx1Jxp5GVwGZHK2EDLdH5?=
 =?us-ascii?Q?B5M9qizBzBiCKGuaCGGsvu7NPwCFLUEBTmxW1ct8smP83bg+l29jDGe2oWIZ?=
 =?us-ascii?Q?N7YF76QPanCmLKfgfy1t8P9mPGa0dh70sJmvll7UldSuZ2D4LIHVvsunQdIE?=
 =?us-ascii?Q?zYD58n5eOYZiqR4m7tAFWlRsgHR/yUJbAwKAGHnPMTltur7lmd0FNLHN3Gvv?=
 =?us-ascii?Q?j9ySOzfm0o2NzzZfPjikjpBfBfdChmuiMo3b3rrEBV/SHgN4v+l40T+Ljc3P?=
 =?us-ascii?Q?hiVMp38yFkznBc6rYI64skZCyapKalAWvLWNf0nhbkcn8G2h3mWdo5d6qqeI?=
 =?us-ascii?Q?OXTTacYb60jKmVxKlPeX6JZedPvzk/DsVD2vph+KzQR1d06vuoHrmcXRbwDd?=
 =?us-ascii?Q?Dlpqtr53M3udJ00B2nd9blje0MB7JNSIJJqD8MtaGWlW5RgekTwMkeYysefV?=
 =?us-ascii?Q?JgX850JRTQ656S0dDvfi4qoIiNeXLquQFk4mNIO7lMBsrAZ61Wg0HO3iB8LM?=
 =?us-ascii?Q?T31QR2+12uauMkuHOqKViLIp211495JKtgtY0cgfVtY9TFuedOpNrNaq4QOL?=
 =?us-ascii?Q?ilPF50T20uWwuq01znY9w2Ru8gjouIMmxO7dmsljXEFm4jUBcYxTfW0p+DzH?=
 =?us-ascii?Q?x4A4Ii4k3LsWIwPPnJd0h9q0wAkuShUKsukFxD5fNUya15WyeTYlgplN5q22?=
 =?us-ascii?Q?lGnhArjLvIndEJWgduTFJWCUj7gDpNx9NkXHHirB5mLxRxJP/SSUVCEGypwB?=
 =?us-ascii?Q?wgqfEFDo9MaoeGLUpUXBk3znVvobcq9DuRNlJTkMqzb2YJhdy3NHxhSD1MY6?=
 =?us-ascii?Q?LVIStK+MsmxZ8XzfDiOsFfmfNMBXQz8s1eCA3rZ4FhVr4SuO2UYj/Crjjqb5?=
 =?us-ascii?Q?bLwdxsZMRIR+Ox4c0b/MN8JYyBK/xRkM9LR5EKlXN/aXak+EhWVYh5cdhEEF?=
 =?us-ascii?Q?/KjjF9gBQX6LA9C7EjcM33nkThF2D9plbY5ZWAAF5HG1uDQOnx8Jn71vMPFQ?=
 =?us-ascii?Q?bDRkI17ZEaOFRBYppYvqsItukBGVXEj9Adf6NZv6P6J7ORac/YLDAJRNsZl7?=
 =?us-ascii?Q?MMoIghHvxoDhBVm4dWdW19D7DWPXCRp77EcFDDR94VegK10aUjPKCNxiHYvi?=
 =?us-ascii?Q?AmRVtXlntynK5pUWDtO5i+J+KqS0gUGsK2MqMTTRqrr6mLZC8qCmVSCvRgQS?=
 =?us-ascii?Q?himXJgzkp3gkbYAuoRQ6jl/MVpT1zqHsD0BubpWGMEr6UtL5gLCB8Ai/Ta6X?=
 =?us-ascii?Q?XOFew5At6IJkQDNXN+Imh5KBd/31YL+BYM6FZBhbprQon4Fy1EtjlVVbVG+c?=
 =?us-ascii?Q?d3ShOtCYZFk04JwrE3/BHNdrvA6+Jr5H2yhdCt3I3HVirO24qB0ZM4MoGwbB?=
 =?us-ascii?Q?py2YEtOtNe4m9JDaP2nezxXpPZDls/iSyfSTfvxEiP+kVFgtghUsajM1hX8V?=
 =?us-ascii?Q?dt355cwXKEmrI9PdM6QnHw9ICVFl3bRHz2MkZupF5ctvjGKjf+xYyzY/+ljg?=
 =?us-ascii?Q?YS39IQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f27b89df-32b8-477e-3122-08d9ed3537cc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 08:05:07.6220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cl/EJi5p1RHvh95lnC0tQjOKZlXs4KFoFFFVTKqxaxRVDv30ZeRprIzA6+k+cYb7sam1spU1dSpdIBnRAKpBNLHgrmiF2y0qM7uiCF+qKKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB2044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10254 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202110044
X-Proofpoint-GUID: D_f6YaFb9rkmCXLe_K4yzByLpRq8sC3J
X-Proofpoint-ORIG-GUID: D_f6YaFb9rkmCXLe_K4yzByLpRq8sC3J
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ambarus/linux-0day spi-nor/next
head:   038b3fa2d89f1a00fdb8767704cdb799a0fe746b
commit: ff51c966a3c5144ae964797349747e680ee47c3a [1/15] spi: atmel-quadspi: Add support for sama7g5 QSPI
config: openrisc-randconfig-m031-20220210 (https://download.01.org/0day-ci/archive/20220211/202202110830.1OGwXRWt-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/spi/atmel-quadspi.c:1202 atmel_qspi_dma_init() warn: passing zero to 'PTR_ERR'

vim +/PTR_ERR +1202 drivers/spi/atmel-quadspi.c

ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1194  static int atmel_qspi_dma_init(struct spi_controller *ctrl)
ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1195  {
ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1196  	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1197  	int ret;
ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1198  
ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1199  	aq->rx_chan = dma_request_chan(&aq->pdev->dev, "rx");
ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1200  	if (IS_ERR(aq->rx_chan)) {
ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1201  		aq->rx_chan = NULL;

Need to preserve the error code before setting this to NULL

ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19 @1202  		return dev_err_probe(&aq->pdev->dev, PTR_ERR(aq->rx_chan),
ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1203  				     "RX DMA channel is not available\n");

This will return success.

ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1204  	}
ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1205  
ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1206  	aq->tx_chan = dma_request_chan(&aq->pdev->dev, "tx");
ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1207  	if (IS_ERR(aq->tx_chan)) {
ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1208  		ret = dev_err_probe(&aq->pdev->dev, PTR_ERR(aq->tx_chan),
ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1209  				    "TX DMA channel is not available\n");
ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1210  		goto release_rx_chan;
ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1211  	}
ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1212  
ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1213  	ctrl->dma_rx = aq->rx_chan;
ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1214  	ctrl->dma_tx = aq->tx_chan;
ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1215  	init_completion(&aq->dma_completion);
ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1216  
ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1217  	dev_info(&aq->pdev->dev, "Using %s (tx) and %s (rx) for DMA transfers\n",
ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1218  		 dma_chan_name(aq->tx_chan), dma_chan_name(aq->rx_chan));
ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1219  
ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1220  	return 0;
ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1221  
ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1222  release_rx_chan:
ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1223  	dma_release_channel(aq->rx_chan);
ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1224  	aq->rx_chan = NULL;
ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1225  	aq->tx_chan = NULL;
ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1226  	return ret;
ff51c966a3c514 drivers/spi/atmel-quadspi.c         Tudor Ambarus   2020-10-19  1227  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

