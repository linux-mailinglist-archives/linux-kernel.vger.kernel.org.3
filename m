Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D744C842D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 07:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbiCAGeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 01:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbiCAGeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 01:34:15 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E219C6246
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 22:33:33 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2213PXuk018824;
        Tue, 1 Mar 2022 06:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=foE+IV910ysMqGpN1PjK3dFmlt0VyTSeUS0tiew3aO8=;
 b=Ol1xo+95N2qFO/Tpk/DRjK5ROGw8wnVZuSSPvShntgfXuUBSKBVIAcNKqWD+P5dL76jD
 9yi3fDBZX8XSeMoIqn8UKQF0GRQUYZm5qpOaMWgErIZwBElYQQMtuRxIOQ5ra6t6WVZ7
 mv9QuavmzulK7FitFxi0Cr0QwoGoTss72jNJfWWYOXQxO5dNq3gfd9TRgCCxlS2juh3s
 jFHzfoyIyqu70aemC7irWtU9rv9Ln00MssTzIfEjfz4zKJvf8+EakRJ0sOoA/7XuFdiy
 hZja6dxwfNfq9nTI4hGVvaUlLbmqendUIjxKk6eA453OiSCOom2nRsHhyzDB142/8U1p mA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh15ahrf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 06:33:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2216Qmg2099671;
        Tue, 1 Mar 2022 06:33:19 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2176.outbound.protection.outlook.com [104.47.73.176])
        by aserp3020.oracle.com with ESMTP id 3efc13tupa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 06:33:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLPvoRrI4VUToGwa/oSSKoV0+EyKl9yZfBW7ibX68ZQGbVMxkK3kPHS6UsuBiTm2swIoZGV3WSTSC5x0GjVV60uVHS51utTaeREdFSB0MOZ6eBrCwntzNP9zuHjhj9zwfo8L2wMWfjW35ghyJS6kkIyRmQRUD8WDusbsA/7Tm1ijjwa+O8dSmps8Ye3hatYlqSakkPFMYFKxTgA9LRPm6wy62fOguFvqfyrU6QUaN3kC+WPD/HchmsNIMjESnJZoY+ZoPaTRhSWcVBgJRgU7mlw5g5EJhgeUpbYgNI5vR807pGTWV3yhIiOyn+tuFFrO/69X2u/WyTsbPXgd37Pzbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=foE+IV910ysMqGpN1PjK3dFmlt0VyTSeUS0tiew3aO8=;
 b=kqjiVIGpH8NsPB+1w83XMNli7e0ojSBVh19yAHWFD06xmKRDlo2s0xBTbleX6aGS5ZY1x6itwVStM0+RksoKX1Utu1uH+vb9l18G/9gZOAV6EcEa+qpiJ4u0+BgVa5h4RK62LDK+yJ5BApWAQYIP56f/fNtFGCZVeQFPcOwXIqzBNzHs7tzIOWFsjHU+Xq48Ohls8BAP/8PHyFEkg1bgl2dGTSa4E0rMm+4QN6AfP9zqaQgEC5wIOxcKoZdyPlaZ5k7p9xlBL1E/UFZCcxxJHPBFoxZaZz2IGgWoJ0eaKxa/y3vU9Us6IbcioyShJfcKVtLyTP4Tvhe7rHyZ+NIy/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foE+IV910ysMqGpN1PjK3dFmlt0VyTSeUS0tiew3aO8=;
 b=KRbuvAg39STPg1hokzTbBM5M+7r8zQtbG1vA2iwZ/j6VaVNS/vd5YEFPo3RkRsCqtDW9kr5+Z+jK7gGmAZvcCpcZey9XF8s/14/ij1iuGMab9qCsRiCVZBimrflGIBIG/I1SwZaz/oijLe0PZvATymjeUvVrpmzPQ4aY0awnSS4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR1001MB2099.namprd10.prod.outlook.com
 (2603:10b6:405:2c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Tue, 1 Mar
 2022 06:33:16 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 06:33:16 +0000
Date:   Tue, 1 Mar 2022 09:32:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: drivers/rtc/rtc-gamecube.c:247 gamecube_rtc_read_offset_from_sram()
 warn: 'hw_srnprot' not released on lines: 239.
Message-ID: <202202282221.JUZzSSi9-lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0026.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::10)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63f14681-ea24-4848-e42a-08d9fb4d5e46
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2099:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1001MB20992ECD1180FBCF4C73BB708E029@BN6PR1001MB2099.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ze2arTe/eZj7oPvnazVzG+EzAHLUQWE7LNorlzDJbetN3mjcERHKlfYQ8rGrdMcaGy0DjmBvPgs6smzQ7lx7YCnkrUtCbmIcR9+JPZ9eIdzWIOKq8xPuUBuW+cxsDgQy9T3ydp9ogLgrZTm8gtfvsaEj0RL8C/zJrJmJO8gehyXX3TR7DO52hcAA7dTBbN69SlL1DgkI/EsO1BNh9DFSmMWBikmIt9fUaz3ZV0vH9fdn+Gu9eNdlXOI+Qzje9XXzmBOTXStL5hmnYTnIs5wiJ4m9tWiQVBkdQogVe+cgopPfUSkfF9gzVUrkXkxfY6+KdCRJWCl6qJuJSEiFjb272BemF5Hzoa5sVcoY5xRktvr1o98PKN8Ptri3Lyb55O1gu8FpUXSuRCsZ7p+2VeuGZ/qckUMoAq2//6sQGoPVjIelflUMuLJ1S7Rx3G+L/e71i1kes7skaU7niI3vXyRkRdDHx4YyCFZwckiIt2Boq55ggHvZEcoPvrswWAQcteKHmZlpZCj6VHUWHPR13HijJUT8iaxhvXNYLh5Wb/SxEEMs6mCyG+gkJcppt5KNIx2q2A7BsQPvOM9a+EgzzzWu6ZnsAS7UML/yE1WuTTTetPHSz4ypYzoMivI6fzp4sdtdfgWdZuE1LkBlZJNw0htk+YvF1it1CUySgFontwJJvfdpQ44XS+pSW4CvdfkEDRC3yth5aNbgRHNA0h6OqQeSzMasZLd8wnLVeDpzidiVjgMmp6o3eAS8H+dx/N5OwH8mNzsXOIBr8yMIfICzOR834czChlZhHlQnDlond7mkCyph0xZA94elBchyxBFqBZqnrNI1ArzxH6WsfEmM5I+ozw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(6486002)(508600001)(966005)(36756003)(8936002)(66946007)(66556008)(66476007)(52116002)(8676002)(6506007)(4326008)(186003)(5660300002)(38350700002)(26005)(6512007)(38100700002)(9686003)(86362001)(4001150100001)(44832011)(83380400001)(2906002)(1076003)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rk12VkZsMDhqMVE3QW1TeGkycUpGOVhqVVV4RlZ2dDBOTU9tczdIT09qMHpS?=
 =?utf-8?B?RS9GMzJpVFNrdW8xSkJoWENQQ0FmT2N1dFEvZ2tzVkNXQUdEaTNyczFlL1Z4?=
 =?utf-8?B?ZzZybkdLWmw0c0tmRDlsTCtCQ2NsRFh6Vzg2M0ticTRIdHpMalVuUFZzMlBR?=
 =?utf-8?B?QW1oNHZ0dTBtbFJsREoyZitvZStrWUV5WERvamN3dEZlT0t3M0pybW9ZeTBS?=
 =?utf-8?B?YWR6aUNUejUvditWa0x6cUJQNUJtbHhVbkxmV3Z3SG83VHIvY0dTbldaemRh?=
 =?utf-8?B?MFJvM0F6ZTV5UHc4NGppUGxZNDh3d0VJSFMwZG1HVjkwM0ZGdXI3cW9pamt3?=
 =?utf-8?B?RTA3YjdkeE0rR085SzhrOGJvN0grbmMzdkIvbWtpZU5zWGdOaVo1RnN3bURE?=
 =?utf-8?B?eUlJbzhEeS9oZ1hZQUZVM1BHbzJiS3Z4VWdKcFVKQlN3dTA2NVFOWHQvbkJR?=
 =?utf-8?B?R2hNQklsY3pBSzJRRFo0MC9aVWN3YUorRUFuRnpKZkxGcHMzcHVtZkE2Uk1G?=
 =?utf-8?B?bnFPNy9FUFZya0dPMk1WdDRYd3VBeTM4dlBlNy90NURtMytTd3ZLdGloNThK?=
 =?utf-8?B?bW9KMnNXcnl4SWVXY3htMW81OUFiY1h5dVllMGdTMndZVEhoT01sVXl4Nks2?=
 =?utf-8?B?a3JaQS9EN3NOV3dFN3JNcjNzNGZ4bGZGN1dPcy8vM09kM3N5RXQyY3NqQnNP?=
 =?utf-8?B?NjR2QU1LY2xOcWRjTC9PVk43SGtGVE4xb2Yrem8xdnpHMmIxdnhZTWhKVmVE?=
 =?utf-8?B?eWdyR1A3VzBjenNqVE1PcENSTjlkbC92NlMyWmViT2NpSzJ6OUhpSzlhdUZw?=
 =?utf-8?B?RHF4aUxHREpxdWFlSnByKytTUEpnQWxvUi9CbU56cXVTZDdBRHRvZ1lsb1lJ?=
 =?utf-8?B?OXhoTVFkS090MHA5cE1NTlhJS1dPdFQxTzBSWkx4Q20wME5ab0wwSUs2aUZS?=
 =?utf-8?B?VVN1UDVRRndDVWNNeWN1dUxhYzhxWDJEKy9lSkh5Vytla0pUMFk1UlIwV2Z3?=
 =?utf-8?B?Z29Sc2cyUnR2UUR3RkRESHh4TnhFa2Fqa0pBMXVHS0xLaG5JczNlaEUvUTRx?=
 =?utf-8?B?V2t2SSt5SVdqTGNqY3d1VWI1SU40d1NwbllmTERMdzBPcFprU012Z0s2TThk?=
 =?utf-8?B?NU9EK0JxRjhDQ0pXZWs0bFFiRnMralp3bjZVd3UxWVFuL01TVWRkN29wM3Vz?=
 =?utf-8?B?eDNvNmRwWUlqNFNPOXVWdmN0ZFgvdWNtZUtPOVhaNXAyVVJOQUd3UDRPcVBp?=
 =?utf-8?B?TkgvZEJwSFhlcmEwOGJNUks0cGpiQ2FRYzdPNzdHK0o3M0huRC9hZThYNTRa?=
 =?utf-8?B?MTVkbG5JRllKaU5wWWRZMGZKOVFGTU5RNTFJd0w3dXNaZnlSUENhMUhYazlh?=
 =?utf-8?B?dExFdnZGQ3AwQkVuMDhUSHJWb1BDb0JSWkQ1K1FwNlZoN0tGRjFrZkoxalBL?=
 =?utf-8?B?MWdaTlRob1p3d2VZM1VkcHFBdDRQTG9JV214Mk9FUUVjVUF1eENIL3FyVkYy?=
 =?utf-8?B?N3UveXcxUHV0dEZiU2pib09oSHNQTzhQQktMN0NQYzFqM1NnTHdpNysvTTJM?=
 =?utf-8?B?SG9kUXVBbG9Ld2dYcVlMbUMwZDZNeWxYekdFS0xoai84V2pLS25wSTh2d1RS?=
 =?utf-8?B?RUJ5N0lReGI1S1R3VXpQb1hCdC9uUmpmdmlpVEFXQkNzc2NLQzRVaGZnWGNH?=
 =?utf-8?B?VmwvYVhidTZ5Z0laMjRDcXNUek9qQzJFMTlTalZmd2RLcHZxMXh1UTI0UndR?=
 =?utf-8?B?R1dWdngzMXRqQlZyVDE1eEJNRnRlcmpEdDVmRkI0cG9SQnN4VkE4YXpaT1VF?=
 =?utf-8?B?S2hnM01zendPdk8vRnZEcG5wUWtQb29MZjM0RjArU2FPNmFDME5kZVdXTStS?=
 =?utf-8?B?UkgvR3JXM1FaMGtWaitCbk5sSmlHa2RRUkpyTzZWVVRlbVVwSGlKM3pkSlVM?=
 =?utf-8?B?S0FFaHJWNGVTdUVlSmJuRUlFZit2S1dDdCtodHluZnNPMmp6NERiMjRnMmJs?=
 =?utf-8?B?SGRlR2o1ck1mdHNqREZJMW5JU0crWmVDSFcwTXVWMGFKWVRra21PZUVRdFh0?=
 =?utf-8?B?YS9SN2FFTnE2ZDlVU1pWanBrWHVhV1JKcDhQdHRpeDVHZTR1cmxjYi9pYzMy?=
 =?utf-8?B?Yk5OQ1FCTFlvTGZucEpIMytSU1JlclNwQ2VLU1RzQzJNa2hVb2paaUVSbXcx?=
 =?utf-8?B?RTVlQkN0NHI0eDRUVVhEM3A1RU5SRzJ1WHNUWlM3MENndzhHUW54QXZOK0VQ?=
 =?utf-8?B?NW9jSncrVXN3elo4b2lJZUs3eWpBPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f14681-ea24-4848-e42a-08d9fb4d5e46
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 06:33:16.5049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2sSiVPzmAeY5+sVSs337In2kD08hSbPkv6xnpkNEWdb2OgjJd4nB9w73ibPuaSFgmKimwRY/b7nqsRQYCrthjOCtcuY6XDev+eLCZy7BUG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2099
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10272 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203010028
X-Proofpoint-ORIG-GUID: 7_ZDXt4jGiC1b-GFkjIi8L1Yh00xoyjF
X-Proofpoint-GUID: 7_ZDXt4jGiC1b-GFkjIi8L1Yh00xoyjF
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3
commit: 86559400b3ef9de93ba50523cffe767c35cd531a rtc: gamecube: Add a RTC driver for the GameCube, Wii and Wii U
config: openrisc-randconfig-m031-20220227 (https://download.01.org/0day-ci/archive/20220228/202202282221.JUZzSSi9-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/rtc/rtc-gamecube.c:247 gamecube_rtc_read_offset_from_sram() warn: 'hw_srnprot' not released on lines: 239.

vim +/hw_srnprot +247 drivers/rtc/rtc-gamecube.c

86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  190  static int gamecube_rtc_read_offset_from_sram(struct priv *d)
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  191  {
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  192  	struct device_node *np;
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  193  	int ret;
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  194  	struct resource res;
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  195  	void __iomem *hw_srnprot;
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  196  	u32 old;
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  197  
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  198  	np = of_find_compatible_node(NULL, NULL, "nintendo,latte-srnprot");
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  199  	if (!np)
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  200  		np = of_find_compatible_node(NULL, NULL,
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  201  					     "nintendo,hollywood-srnprot");
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  202  	if (!np) {
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  203  		pr_info("HW_SRNPROT not found, assuming a GameCube\n");
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  204  		return regmap_read(d->regmap, RTC_SRAM_BIAS, &d->rtc_bias);
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  205  	}
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  206  
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  207  	ret = of_address_to_resource(np, 0, &res);
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  208  	if (ret) {
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  209  		pr_err("no io memory range found\n");
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  210  		return -1;
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  211  	}
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  212  
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  213  	hw_srnprot = ioremap(res.start, resource_size(&res));
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  214  	old = ioread32be(hw_srnprot);
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  215  
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  216  	/* TODO: figure out why we use this magic constant.  I obtained it by
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  217  	 * reading the leftover value after boot, after IOSU already ran.
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  218  	 *
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  219  	 * On my Wii U, setting this register to 1 prevents the console from
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  220  	 * rebooting properly, so wiiubrew.org must be missing something.
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  221  	 *
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  222  	 * See https://wiiubrew.org/wiki/Hardware/Latte_registers
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  223  	 */
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  224  	if (old != 0x7bf)
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  225  		iowrite32be(0x7bf, hw_srnprot);
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  226  
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  227  	/* Get the offset from RTC SRAM.
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  228  	 *
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  229  	 * Its default location on the GameCube and on the Wii is in the SRAM,
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  230  	 * while on the Wii U the bootloader needs to fill it with the contents
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  231  	 * of /config/rtc.xml on the SLC (the eMMC).  We don’t do that from
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  232  	 * Linux since it requires implementing a proprietary filesystem and do
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  233  	 * file decryption, instead we require the bootloader to fill the same
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  234  	 * SRAM address as on previous consoles.
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  235  	 */
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  236  	ret = regmap_read(d->regmap, RTC_SRAM_BIAS, &d->rtc_bias);
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  237  	if (ret) {
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  238  		pr_err("failed to get the RTC bias\n");

iounmap(hw_srnprot); before returning?

86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  239  		return -1;
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  240  	}
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  241  
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  242  	/* Reset SRAM access to how it was before, our job here is done. */
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  243  	if (old != 0x7bf)
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  244  		iowrite32be(old, hw_srnprot);
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  245  	iounmap(hw_srnprot);
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  246  
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15 @247  	return 0;
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  248  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

