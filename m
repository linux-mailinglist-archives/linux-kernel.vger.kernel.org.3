Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105A44B9BF2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 10:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238617AbiBQJY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 04:24:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiBQJYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 04:24:25 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75862189AAC;
        Thu, 17 Feb 2022 01:24:11 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21H7Y8Xm027716;
        Thu, 17 Feb 2022 09:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=QQnqCZTpxitocfNgYx8jXgdBrJukyY5G25DQlNnLPZE=;
 b=XMd9CvC+8jJx52D+vLTB6h173XEC0D98mZBRlIwiNSPYeOwMB/saVm3agwLagVmiJ46Y
 AXQ110HtK3rVOl+Uc/wgk1fezjMM2ACQTxJlfkBcY2sFHBKSfk/cMYhyIviTjEAQk7Tp
 lAVvSfBzhYGDzguooPDcVUJcyQQq6VUnG/y6S8Sn9/JNeBWAUAsGttyyz4sguIWJ41+/
 btvuVZNbAlRQ0+V8fTbabURgZrpNVbG7Lk80CtTeJ9wUV3Gj0cQaeusX/az8Xf9EnO8+
 9Bpsg54yI7xMk+VSn10lHXBRFz7fxXhhZClZhYLDgpZEYfxfeNnucHCMMKP4Rh15Gz6v 6Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8nr9576x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 09:24:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21H9CEw0072964;
        Thu, 17 Feb 2022 09:23:59 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by aserp3020.oracle.com with ESMTP id 3e8nvthh36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 09:23:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJ3HviStUME9aTtT9mL/rvFrE7nInHtgvLAm5Gnz35Xa/Ig09uc4Sy42OCeDBSnZsO131Mj8P673eITrzpB2vu8EDLwIHzrva9tiV8jIL4N7ofp1EflluThLmI2VZG1uJ/gq7+ma5bzU2VXikar7iG1GGf477SBkHJ+fGx30+JxqPsD8yWTh3noOB881cZz7v5aJ8f9gGfLr0OXjzVE6VpVOCWz5Y80jIrlQLjZ/LamSlTqaNvx7+aCOUyyBUcwV9p3CdKhSvKyVqSwVNVrVH2+jYavHFS8UuKlVdsifxezxBli2/O3JGdwKoorzOW0s68QRA3rhayVEnYpmqGZa9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQnqCZTpxitocfNgYx8jXgdBrJukyY5G25DQlNnLPZE=;
 b=c5SecrsCc84u35H6mzjmna4ct/tNCq+2xptIP3qeKcDOwb9O2JrOlfsC6J7qK6RLt1aHyA0tjJyfXF6EbqQMXkE38bEfNuCCVut9Ou8fK+UttzavdHL6gZn8Hig36nuPa2XeRa5iqSCZL5sAUE8pssTu9VCg1WIYVUcsoY0aOf8TEFgmK8eNzBbx86LR2mdBmNFEqdujoqA9146dhXj2S7PwiLgPugIYYfuADUEBQvQPjSFMMbHkZynsx4Xx9kiZ3299w17TKnodB935og20MC5TZatut3dnZDUqek89xsrElexzRn5V3Hu0IgF/3ioRfq7eME2UDAc48TB+t2/zpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQnqCZTpxitocfNgYx8jXgdBrJukyY5G25DQlNnLPZE=;
 b=E8AYPA2Di+t/rkUKHkbHBmqVBlA4WNLFbgGYYPkL1FR47Ruzy0/v7AnncDhMgpt5RwL6EAMtbZwJ2CR6ILGlJE/Ko4laj6yr3ZORpOURpXPPuYmK6BlnRkNYzX96sQtmR5JoYvcmYbo6H0C5XxOfULs2pe42/fTDaatP04naujA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB5451.namprd10.prod.outlook.com
 (2603:10b6:510:e5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Thu, 17 Feb
 2022 09:23:57 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%3]) with mapi id 15.20.4975.019; Thu, 17 Feb 2022
 09:23:57 +0000
Date:   Thu, 17 Feb 2022 12:23:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mike Skoog <mskoog@endruntechnologies.com>,
        Mike Korreng <mkorreng@endruntechnologies.com>,
        info@endruntechnologies.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] serial: 8250: Add proper clock handling for
 OxSemi PCIe devices
Message-ID: <202202130027.ZKBCgtm5-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2202111127200.34636@angie.orcam.me.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0008.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::20)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f92dde3-e0e0-4a84-674a-08d9f1f73928
X-MS-TrafficTypeDiagnostic: PH0PR10MB5451:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB5451128FF9C99C4D878438708E369@PH0PR10MB5451.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JNmw2IyATedo2ipzS2zJiu3C4gcdkdOlJP67YjWPzlrHrxEOLQ7DsIotOMh1ZSb609wmJlHyCcoqa0RVKoOCK0eWNbb1Yw2XckcWJeJeNAT4eiXbvM46XOWSVlU6276o1o3+Y4OmRr7K2ZL9yH+pbpMLcfS9KqSXzuw61YiPFzqre0TqUhWsP0GhE37HqAxByeEu9ex+pCZyR/j2whdPWACPLtjJNAOduRugKMk/wp1rUdQOhJPINyMfulURg3/AiSMDLPlxGvhh4Pv7qcyTrwuQV3HHSFluV/5QW1nR2T8naRYJaS2ABdMlSBGV9PWlbeLXSyzeFwFEEsNYDRD8kcyc3AZkenzagSMCYUVHEwwwLLwM4ftcQV2drE6mYTDmFP3S4TS7hO8Rnn12fbcrjktbKAZh2v2F0WQaDu11Afk1IeK0AIrl2a45iV7xYqPmMWX0eLa5oDvN+AFYAgoVXX+/sIn0pW2o6glk8EL/76CfUFR6vmNE4MX82fZTPeBSMzFz94cNY34kM/z6odAwZMfo7cTublMFFFGBbyuTXLqByrB4JfHJHH5ioko850PKO2pxf089+6RL145N9iMOpoWwmYbb2iAgs34WYDEKKsK/NhfsxWChTka0r2nyk7gxEbcE5BCtw2M9JaZjgs7kIS0iS7SUfnBAmMJCMq/fdsscfgjfmdfF0hOhkP8/YBEbv+Otg/y5Fh5i/lImluoB49v90CaBGss3eDt/pZaUuWPgnsqx3WtsqDJ9MsFl4LGH1IePEAu2PfXBsQuFMfK0yjIXM95dws8To9JfykwIO6h6Ek3JKT9k87vt1R784TFX0ZbAhIQyqHmCEjc0iUdb7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(6029001)(366004)(83380400001)(1076003)(186003)(26005)(38350700002)(38100700002)(86362001)(66476007)(6486002)(508600001)(6666004)(52116002)(6512007)(9686003)(966005)(6506007)(66556008)(316002)(8676002)(66946007)(4326008)(110136005)(54906003)(5660300002)(7416002)(44832011)(8936002)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b8ecA3A+0WRGLsqKjnMKNil5iSdV6inDYM/VTZK09AdaW9wP0kRqB3ZKWkUM?=
 =?us-ascii?Q?hjxXv+eRZJ2w4nEkbCLtFDl5EcGJ5Vm3/q/wNVh0EknH32R+PLp4pY1Y/+Iw?=
 =?us-ascii?Q?V4i0187ctu2QpUoLAAE2mxtG+pdb5YhLXfUeBd5CbFFC3l1YJTyMBgK4B6ij?=
 =?us-ascii?Q?rNjZ4wTeW0jvtF3MJqkZ6VVybYMg8gWTps0RYlqkN1yh0BlkRE23DPr53uzB?=
 =?us-ascii?Q?0PP0SkHqM208CyRVd/wEXUfSSENUIWdnQ6+ec3hQinVJ9DFOFfc1ct1ii2iM?=
 =?us-ascii?Q?WuuJon8Nrnu3ivExx+UYIRI0HjjbdOM9bLmnYCdYlNO6ciuE5crRRvfu6YH7?=
 =?us-ascii?Q?6ViYvUjGcPRSTt9MLtlbzI5twhHGBbRHBglC3OSBbBOGA7KoyzeW18di43HQ?=
 =?us-ascii?Q?zUuOAaGalfz/1M5HfTQrApOGBmuQopDvm8X6EgGunYJUO+NPHIRnpIUq67Cr?=
 =?us-ascii?Q?nobmVYCgj2J6uKVnrOI+k0eTy+PCoHRZE9wFmJsxXdZPxkaOUHdUMZ36yy/x?=
 =?us-ascii?Q?binmKB+1uVONQIzIJQi9NQS+R5ST5ZwJSFmNoA7Y6wivqumE7OGlUtGXwW1/?=
 =?us-ascii?Q?OwWP1gKkEBUoGnWOa2F9RptlyFByZbUT/5U0oKBz04mJ7TBjHjSDpgO3ylZ2?=
 =?us-ascii?Q?OIxDb3urKm0mZLsBwPexUD5nOt9fu68NhgD2aPi609upzIAkNkWoGKNAlD1Q?=
 =?us-ascii?Q?rRXZFU/YIL/f9c71u6y5I/hPAQMbk/wpdywaNYokTbozj4t3h8eajIEmL7bx?=
 =?us-ascii?Q?AR17o1JFlkXnTK5bKsOor0f2EZSh7/LRxcluny2PpR4kpM81JcemY/ZZ66v6?=
 =?us-ascii?Q?NFKYtvvDfdaS7tANiRZxsyHXSRVkG/4lOHxjp/bDfwR5uAfvlvACXULX7wL7?=
 =?us-ascii?Q?LsnpL9Un96Zhp6iNn+IxDsMqcz2lkATNEeybq+lidocuocQJtU4RtYfD8HoP?=
 =?us-ascii?Q?bCTw4KA5aa7CYkG2dLigHjDbcZ/TahloybWRERSe37E4fKOoRltmrwLDV5nj?=
 =?us-ascii?Q?QY4ZLj5CopbKrpkTGbRW+O6rvYc/2g24o0tkJJqo1Hj1D51brlim8y4JgBEo?=
 =?us-ascii?Q?+DrP5JdRAm125nL3kyyjWSdSPatBAH40ZYYwiiak8v5iYTar/UElC+BRlumB?=
 =?us-ascii?Q?zLesU8/eF/7BxNbb+bQO79Aa93X9em3jvcLBr4gABzQR2n7fGVJrCufHak0H?=
 =?us-ascii?Q?msgRjKmBpV5vwcbSpBm6vHaPA/cm3CN+RvZr6SXAP3/gmJWlekMkk8OnAwoP?=
 =?us-ascii?Q?t5+DxLIJgl86c83Y0NNRbOtfhJSIfw/StG6OKJsEhn7W67nvCdAch3ylze3z?=
 =?us-ascii?Q?oZjgYqBP668db0Pwig9bbXkXKeLFHDG0+qUdBTW5OHoFcoFEiBW/u9iJr3/n?=
 =?us-ascii?Q?ZIzbM1HRFB0igkjovXoX7HrYm1QaBIqwRc/XDpwgVnWJk1dCy4Qz37dTUgdw?=
 =?us-ascii?Q?MeYMlQBMNSURIwgynsuf6GT5rYTwFZz76Kwea8CYYM0r0Dna8c24AMgogskJ?=
 =?us-ascii?Q?QM73vRf3rBLrKdAXziG1Dzf0ls//H2s62waR+JEEUjoGq1Zny0GiwiEOHHdv?=
 =?us-ascii?Q?2JdWsifxfnz1Q8o+OQd3Hc9WIGasKNd18KNLETbAGle3tRH332DQRk8PSkEc?=
 =?us-ascii?Q?spy0yakfNanEbdjxaxou656re1/Sv4vNykMGueNumdMn8qvIm6POEGmUXjFi?=
 =?us-ascii?Q?CU4ocA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f92dde3-e0e0-4a84-674a-08d9f1f73928
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 09:23:57.2332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +d8O+4HBv94smGCjIxxcZLO7AViVCzah31dCWYEPvWH0khbwP12LDWxIr25V61tljkyyEYAK8pTORYsdNfXu83E1GMX3NymHa2uv4HN8fOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5451
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10260 signatures=675971
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202170041
X-Proofpoint-GUID: _qLkrn8IOuOwnUXYJCD2fKGNjExyhavk
X-Proofpoint-ORIG-GUID: _qLkrn8IOuOwnUXYJCD2fKGNjExyhavk
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Maciej,

url:    https://github.com/0day-ci/linux/commits/Maciej-W-Rozycki/serial-8250-Fixes-for-Oxford-Semiconductor-950-UARTs/20220212-164255
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220213/202202130027.ZKBCgtm5-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/tty/serial/8250/8250_pci.c:1171 pci_oxsemi_tornado_get_divisor() error: uninitialized symbol 'tcr'.
drivers/tty/serial/8250/8250_pci.c:1172 pci_oxsemi_tornado_get_divisor() error: uninitialized symbol 'quot'.
drivers/tty/serial/8250/8250_pci.c:1180 pci_oxsemi_tornado_get_divisor() error: uninitialized symbol 'cpr'.

vim +/tcr +1171 drivers/tty/serial/8250/8250_pci.c

5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1122  	/* Scale the quotient for comparison to get the fractional part.  */
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1123  	const unsigned int quot_scale = 65536;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1124  	unsigned int sclk = port->uartclk * 2;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1125  	unsigned int sdiv = (sclk + (baud / 2)) / baud;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1126  	unsigned int best_squot;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1127  	unsigned int squot;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1128  	unsigned int quot;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1129  	u16 cpr;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1130  	u8 tcr;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1131  	int i;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1132  
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1133  	/* Old custom speed handling.  */
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1134  	if (baud == 38400 && (port->flags & UPF_SPD_MASK) == UPF_SPD_CUST) {
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1135  		unsigned int cust_div = port->custom_divisor;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1136  
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1137  		quot = cust_div & UART_DIV_MAX;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1138  		tcr = (cust_div >> 16) & OXSEMI_TORNADO_TCR_MASK;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1139  		cpr = (cust_div >> 20) & OXSEMI_TORNADO_CPR_MASK;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1140  		if (cpr < OXSEMI_TORNADO_CPR_MIN)
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1141  			cpr = OXSEMI_TORNADO_CPR_DEF;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1142  	} else {
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1143  		best_squot = quot_scale;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1144  		for (i = 0; i < ARRAY_SIZE(p); i++) {
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1145  			unsigned int spre;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1146  			unsigned int srem;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1147  			u8 cp;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1148  			u8 tc;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1149  
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1150  			tc = p[i][0];
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1151  			cp = p[i][1];
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1152  			spre = tc * cp;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1153  
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1154  			srem = sdiv % spre;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1155  			if (srem > spre / 2)
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1156  				srem = spre - srem;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1157  			squot = (srem * quot_scale + spre / 2) / spre;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1158  
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1159  			if (srem == 0) {
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1160  				tcr = tc;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1161  				cpr = cp;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1162  				quot = sdiv / spre;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1163  				break;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1164  			} else if (squot < best_squot) {
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1165  				best_squot = squot;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1166  				tcr = tc;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1167  				cpr = cp;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1168  				quot = (sdiv + spre / 2) / spre;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1169  			}

No else path.

5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1170  		}
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12 @1171  		while (tcr <= (OXSEMI_TORNADO_TCR_MASK + 1) >> 1 &&
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12 @1172  		       quot % 2 == 0) {
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1173  			quot >>= 1;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1174  			tcr <<= 1;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1175  		}
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1176  		while (quot > UART_DIV_MAX) {
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1177  			if (tcr <= (OXSEMI_TORNADO_TCR_MASK + 1) >> 1) {
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1178  				quot >>= 1;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1179  				tcr <<= 1;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12 @1180  			} else if (cpr <= OXSEMI_TORNADO_CPR_MASK >> 1) {
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1181  				quot >>= 1;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1182  				cpr <<= 1;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1183  			} else {
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1184  				quot = quot * cpr / OXSEMI_TORNADO_CPR_MASK;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1185  				cpr = OXSEMI_TORNADO_CPR_MASK;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1186  			}
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1187  		}
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1188  	}
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1189  
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1190  	*frac = (cpr << 8) | (tcr & OXSEMI_TORNADO_TCR_MASK);
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1191  	return quot;
5a389fe2b5e750 Maciej W. Rozycki 2022-02-12  1192  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

