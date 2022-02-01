Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6FCA4A5928
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 10:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235943AbiBAJZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 04:25:53 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:33010 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235822AbiBAJZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 04:25:50 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2118WHY9031522;
        Tue, 1 Feb 2022 09:25:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=m1xuP07BnWPw0N/v9JMRDCzSu+4W+GHlx76X3XDT4nc=;
 b=EYkIi+OWGrwEYxu3Yi4L7nCa3CRkBu6OpWuX1Flk3NJJs+FvbIo+MRIG7lSihc8y/iKr
 16CjA9WoY+6Eo9NTcBqgBFPeblWRQV0Rq8kG1BxXdubTynSC8S0kflKPxFo/CgcuqvcT
 49fFCEJiuVm6YtIl/Po15N+Ato/Ga2XO5NuJPtLiEH8HfFAt6yEp0MwLtQa82adbAqvW
 wV4TGq5B/964y3E45ENQoCwIshbBtKOqDpI8S/PyP6AHG6Idv2ve5qyvT4suGv++2ZiT
 ApPxvoOwUlQ6mMB3Sh1jmYw6fQyyhwDS+3V/9dYLyhMCdK1cMqyZbPK/0Dd8Y09yM7Te Lw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjattbd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 09:25:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2119Benx009670;
        Tue, 1 Feb 2022 09:25:46 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2043.outbound.protection.outlook.com [104.47.56.43])
        by aserp3030.oracle.com with ESMTP id 3dvumf1bg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 09:25:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUQA18NABTgH0gOv7vgo3YTil2FwOXjxt1eFHTywIzTRv4cQb7eb167PNQg4wPOtWQarLlYPyamlPYQUzf2xm6zzm5Et8osaOjY12adsnpHkxu5MfqZfFcQHEkNGZg0ravG7DM+eQjocmgn52loWl91zfU3xKajQkZ6dJLkpPubFt7N8dujDPmzg9pxgK3PoPRd2eJsFRiALK1wgrxbmPXXCFuyobCUiClprKWlzNukMBoIUPiUYtchhXauNqm3TwQh3AN+lOjWay9qnzsFuBgcKPKvVfPVuWXwl3qZ52JeKdyZLkTZp1dG7fA5vPkkMmLQof/p+hGTLCeHxTEDi/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1xuP07BnWPw0N/v9JMRDCzSu+4W+GHlx76X3XDT4nc=;
 b=oFeBzEEM46Cuc0niotjiUicQNLTpQhNtV93j8j45TtNSnjaFn2jyW7wWnITemgfAGr22X5loxFawJnm3pRqLZydjOqWvF5+SS38bOxPqzqODiAx1ZfJuom3ilCcBUaH7RBATSlaex6zVkWrpvTCJqn5yhxeeKq1MesN7Vjy+1DEFeLVTZWeMAdzBBc7Nby3F+rsRM1RLqKQ3fJ16m5BhCzMecLR0sKr9FC9nvfbaAHJtY9U/QZf2IUeBRsYMAbLWqa8aaYt3Rtw+Hea03RppgXSFZ/wGtH6/e4r5MGrDWYlWzcBPFOL2Bd+GaE1DdkLOk7ZeOOuy3lf4sZRNE3nfNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1xuP07BnWPw0N/v9JMRDCzSu+4W+GHlx76X3XDT4nc=;
 b=hYIwwuzp7XDj+bOpva0fWnQDi2Vfr5KoZ6WqSApfNBIG4+fHgILAfUi1DMPQbuyMOxCSiHSiyeNz8b6L/pq5IKDF0t76DuAyswdU6RK+ICpq7SeU3JjjA9Z4zVAz09LZQHa/4CXyGGsS35a9/C7jIhWd7CCxLpoEfLf18+3+Z84=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1806.namprd10.prod.outlook.com
 (2603:10b6:300:113::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Tue, 1 Feb
 2022 09:25:44 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.021; Tue, 1 Feb 2022
 09:25:44 +0000
Date:   Tue, 1 Feb 2022 12:25:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Steen Hegelund <steen.hegelund@microchip.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Bjarni Jonasson <bjarni.jonasson@microchip.com>,
        Lars Povlsen <lars.povlsen@microchip.com>
Subject: drivers/net/ethernet/microchip/sparx5/sparx5_packet.c:147
 sparx5_xtr_grp() error: dereferencing freed memory 'skb'
Message-ID: <202202011757.Azj3HHCb-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0108.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::7) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6994e41-46e3-43e8-0571-08d9e564d291
X-MS-TrafficTypeDiagnostic: MWHPR10MB1806:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB180699D4F3564A2A9CDA2C8C8E269@MWHPR10MB1806.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:200;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jQoMtreMCX5mCaK2rkchZIyN5/pHzN4YF0T9oTWX8y3FvVD39BzgGBzZfkBNs9hValRIjTSwK+K7zEE+LMdZft0G5UiVSsfi/FGYCGMUlcKhEfKYU2r3BJlUGPIiZCT6SG1rGLQNWUGfRXoPCwPgipm1iOwxE80NTTa4sf1PUhzTFIIGVB03uyRczQIsJGJaO5w3ofjv8uGc1Wb+02kUTAmCuu50WzVk/YFkHDsc1C5VZUQ0b2vithskjb9LKebyUJAxoJM9vle13Ez8bNfsuyrKNAjEOryaCO4h7KYnQ9jHxiYgEFR/kTBsM6pTpv7gyUqV5HKOM/bvkUjiiys5pNW86AE+5tV5Sm9x/BFi27nkwySg8pv7rcmp75sjeLpzWw8pJwWco33ar04u3GpnRotJcvpifbXGLHQZA9qUG7ME/wLwsrnepgVLJk7ZlJSgPpHmgWM0xNx+4/14qWp9jleLAtFUdblmjXqvuVSapRwC2Ccm8yu0y0BbVSQJ+xFaXXVRfrfT2SwqmEFSrZB2Kxpa9JvPJCAP06basdwV0iAhfE2KBtRpNaquHqG3qv2JzgN6JpRGK3E8C4Sts2DilFHbL59HfFD6xO72N3el044oEJo/isqfDe+GzBMu/GQurVmn0g8+2Ueaej+aCEytB950pvESJk0q6sOxCmiaWXpRPoUxVm5JXOFb+oOEOEZfPKkOGJcma2auM98B4UEIya3fWtwshoDxChb6rkp1F/rkchdGvRP/ekDTOZ84D/X48BXOCC5Xb8eDYoQCuVTunCQjdOx9XqtoaqACr66N87+XsgNRV6AdJntRAxty4IBOSTVYYW6HWG5Q/gXBAMYWqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6506007)(6512007)(6666004)(9686003)(54906003)(316002)(6916009)(26005)(38100700002)(36756003)(6486002)(966005)(38350700002)(8676002)(1076003)(83380400001)(8936002)(66946007)(4326008)(2906002)(86362001)(5660300002)(52116002)(44832011)(66556008)(66476007)(186003)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bc0HNZYqnzZPRFeg1zntznUUBudknIL/+MMRu3tC7oxXA8IfrISJtiY6CLLx?=
 =?us-ascii?Q?L9iEKfXoj3hAleBPNqN9QUv5Kof1YOixgJKIGJUsvdJVHB2N/eSP0bNaSj3A?=
 =?us-ascii?Q?8fe5H0qq+Quolcznxbl2pdjDFm98rJoJPNCz4wPBAD8KWfz62JEJ2rttsF4q?=
 =?us-ascii?Q?gQyvxM7+UmmGvFntXyhBPX8FZTdlBEjw7mpLpPJER/Tkfe96WeDRS+BBLDBX?=
 =?us-ascii?Q?D1D3GC40mbGYx0FuJGtV4QpPnShWEOqwKSSBDyRPKitf5xPxvUDdWtGe7suV?=
 =?us-ascii?Q?GLBIRLQbfzVebVZdmglcLdau5ykYqQcwAkj5L5qlfIvLtfP8Q+9m5LWx5xZc?=
 =?us-ascii?Q?PwnBL+dKe9kJj22nDWwb8sqXrY8V4TC3vGZ65c8NfmSryw32tGcOfzT71Nzi?=
 =?us-ascii?Q?mwUAPzS2Fmywg2dxS5V0xMxMIUXWLUdAwlv4vKQtyJbvAjpJU3/Wj9SctcVE?=
 =?us-ascii?Q?J0eN9gN0TuoBZOcsVOyDw06ukmWHGSRNlzdHjMWKXKgRdbW2HN3hdm7TTfxl?=
 =?us-ascii?Q?VRfVUmnFPo0kVdwDNwLMgtsiRk9FjJcgWgIOR0bkSMozm1QAumX7b+v+eiOO?=
 =?us-ascii?Q?BK56uDNfWULzSfRbP5ZEm3E89RAi71/UE8qVMkQxI1OCfH6S0LkQwHAflXqd?=
 =?us-ascii?Q?Ir/hN6O0Iay5rFNDUYfCwn7ib1awYEMkHzNzVdtS9Titj5tKKtItlcNbvqyh?=
 =?us-ascii?Q?EVtZKDdZAjYV2JA8EuQBklsy5Me94w3y6E7s/wu863pfGpT89iy6IbUPjJBH?=
 =?us-ascii?Q?qfM5vmmhdmEw5xcz4gJF4GaFoEDkHNMCcm4Bj0nKQrtXJtpeyvbDnIHvY93x?=
 =?us-ascii?Q?uG+ivgmBzk/ZoyC3omWLjho0UO7JN9CCt3uP3+YCvYTTvSgHnAV+lgW++mst?=
 =?us-ascii?Q?1C43Ev9sPrCb6BjtJQQuo9lixMU5giaGBba6XdyPzLbaPHC6IaC59ChS3U8b?=
 =?us-ascii?Q?uzvvdugjqNG19EcNSqgjdDifoidQZclMcP1jlTv1PHSZo1tOU7gx2RO/lRja?=
 =?us-ascii?Q?kmkw3lvUta/9tgRHcJVseQMQHx9zs0Q2tRcKRjNnIp1wRzvYSTxCdiRvGGkA?=
 =?us-ascii?Q?/Yd2vTcakc7Bw6nudHxsjI6mYIkaW1lHc4rsMGdEuYb6rJpR2ysMr3FzFgGH?=
 =?us-ascii?Q?85gm1eiO5vIllnptMl5lwWE5oG0JYKc99+72gx2DFXKHS6baMEoc8lLVeHgc?=
 =?us-ascii?Q?t1WwxnFSmjXawzx/RpUc89CZi3wPlAaatRIAoUZhwGkDHzyygHNQtxWi4+iJ?=
 =?us-ascii?Q?zXTlw+Z91Au75m+QjOrE7VzPruBCvSXyf75H+WCPwqkVQ6ui9wX6xqjmytLZ?=
 =?us-ascii?Q?BTTw3Uug9qeqUvh3uTBlzFz9bswtF7d2ZUg7CeRM5v0Ap6Df+QjdoZxI4VDz?=
 =?us-ascii?Q?YzVuz3+qk7vE6330jdNfQIsmK3CsETeP8g5mvmvVzVzbu3WWKPF/ko7Vw7tU?=
 =?us-ascii?Q?EbCQ+FXeM4PmU8DDzJeQmghDGuudQ/oAqXpAXugMyHreQMjuw7oLfHC5s+WL?=
 =?us-ascii?Q?nkQ1jQipGbI1ViuW4yf6gxdDeUYpY20Zhiv77HKOqoSas5CvfjVLi3gFEoPN?=
 =?us-ascii?Q?oyPh4GCCwEVGKw4m87+R4Bxi/jxIwqGH5RzJZE2+WxuXvRMXp3lQmtWvWyDr?=
 =?us-ascii?Q?L71UJsPbnAgkMuRwDf7Lw7jTjb/cXQnRaYMnTfZw8YowrejsY+NRmz726Txe?=
 =?us-ascii?Q?p5WisbLvS18b9oQoVZ4rWQVI3U8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6994e41-46e3-43e8-0571-08d9e564d291
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 09:25:44.3720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bIsPP12qa65A1z38ah0AqcXUpndF3vgxjBJuyyI2ofg7w5UtzcgkPllTHqV/czxCqhFY6uwsQQBOT9IGqH8/Zpeq57zn0Q24TgSh6KyjuwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1806
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10244 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202010050
X-Proofpoint-GUID: 8hmeCGSDw8Y7XtztfOWRwZgk7WBYe9TE
X-Proofpoint-ORIG-GUID: 8hmeCGSDw8Y7XtztfOWRwZgk7WBYe9TE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   26291c54e111ff6ba87a164d85d4a4e134b7315c
commit: f3cad2611a77f0229dc16aa7bd2ef63e35ea9fb6 net: sparx5: add hostmode with phylink support
config: nios2-randconfig-m031-20220130 (https://download.01.org/0day-ci/archive/20220201/202202011757.Azj3HHCb-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/net/ethernet/microchip/sparx5/sparx5_packet.c:147 sparx5_xtr_grp() error: dereferencing freed memory 'skb'

vim +/skb +147 drivers/net/ethernet/microchip/sparx5/sparx5_packet.c

f3cad2611a77f0 Steen Hegelund 2021-06-24  134  	if (abort_flag || pruned_flag || !eof_flag) {
f3cad2611a77f0 Steen Hegelund 2021-06-24  135  		netdev_err(netdev, "Discarded frame: abort:%d pruned:%d eof:%d\n",
f3cad2611a77f0 Steen Hegelund 2021-06-24  136  			   abort_flag, pruned_flag, eof_flag);
f3cad2611a77f0 Steen Hegelund 2021-06-24  137  		kfree_skb(skb);
f3cad2611a77f0 Steen Hegelund 2021-06-24  138  		netdev->stats.rx_dropped++;
f3cad2611a77f0 Steen Hegelund 2021-06-24  139  		return;
f3cad2611a77f0 Steen Hegelund 2021-06-24  140  	}
f3cad2611a77f0 Steen Hegelund 2021-06-24  141  
f3cad2611a77f0 Steen Hegelund 2021-06-24  142  	/* Finish up skb */
f3cad2611a77f0 Steen Hegelund 2021-06-24  143  	skb_put(skb, byte_cnt - ETH_FCS_LEN);
f3cad2611a77f0 Steen Hegelund 2021-06-24  144  	eth_skb_pad(skb);
f3cad2611a77f0 Steen Hegelund 2021-06-24  145  	skb->protocol = eth_type_trans(skb, netdev);
f3cad2611a77f0 Steen Hegelund 2021-06-24  146  	netif_rx(skb);
f3cad2611a77f0 Steen Hegelund 2021-06-24 @147  	netdev->stats.rx_bytes += skb->len;
                                                                          ^^^^^^^^
The netif_rx() function will free the skb.

f3cad2611a77f0 Steen Hegelund 2021-06-24  148  	netdev->stats.rx_packets++;
f3cad2611a77f0 Steen Hegelund 2021-06-24  149  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

