Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E46548E96
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353667AbiFMMVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 08:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358701AbiFMMTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 08:19:35 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7226156C27
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 04:03:05 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25D9k9ng032588;
        Mon, 13 Jun 2022 04:02:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=date : from : to :
 cc : subject : message-id : content-type : mime-version; s=PPS06212021;
 bh=14QvFfWJ0L44TZwv7DxWWaJFR4OLePTj2nx/8CoLXXg=;
 b=U3YBVjeKehxAuq8eaUVCCVA+GGH0vTw2HJhrtMI2O1RXP5t1Elg7q+sDXhP1Uhs+yRMf
 oVmuQ3KSxiYRtBJeIEB/H14uphidw+e2PLYQIINZr5oQp/xXwvLB0NZzTx+ex203UbEV
 6+n3MBn0Ornkq1shzpTtqtEU0/fLcsjKbglaZdmG3lFqN+jvqehGDR0NQdVjGD8ckUOu
 /FCRG6WVJwVXn18RiDkgsb2bS9lwOLW9B1YkEDeJs8w9GN1gkOIpGsDEVP+8BSE2UDf/
 Rfcx7nXgYvsUdSk2O4IzLhKsV8bsXx63iDlnK2bMubcg6xxdpHSAcimavIqoN88RmwXV nQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3gmtjkh5sw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jun 2022 04:02:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PuGgLJqYeAmaeyJHeZ6RGrhz53ySWH3H2is1s5wP2MCWQ1W8VSlvkR+WouYu1HZYjHyh60EwYBXvHuWGRYZMSSw2nkWRvTdVoJL2Fmy5OtqOxmQD2iHrxPpPBDE+g2Sdb3Y8hsL9wVAuioa4whlOyXIHj39n7gAu2IcqSM3uQe9r6yXAY5YnX396NAh8VsHxnSMBNLTHu90zbblrSILc564RuWBrT0pA23ux1TAqYi+fgw28QFdPqjPF8mdhx3SjsEEEwTS7+0zCVeeNAMI/VrKWvGUH2dp1RJjud2w0xzyLQTcQM2jXKEy48z0e+zzQFEj3+UmvzKqjGy/3PvHGBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14QvFfWJ0L44TZwv7DxWWaJFR4OLePTj2nx/8CoLXXg=;
 b=YS6H61y39xD93a8CemMMNKxy0GGwTmL7xA5Y15l42KAu/UKwktL8Rlw3JC6ANOOKosS7aApLwLQbK0G+SWGZOK/hrAvCdp1Kc16Z+TJ4PrV4RuBbNHh1dDO1nd9RNzNjsnnZx2KNWYvmY9AmFYQ78SQFUoUxaXaTCFbdhdtryISI+IvXUR0a0YcsOqA3D/EI4NilLI89HiymBgspAE4tGKcnSXfg+wz9A6jRg77o8lm57iA4dx31h+e1yX3TxoIVsSQ/iLaAlwQ6s2/DrZaT48IQ+zHGGK/vo6ErRHmkmnFBv5VyuiJrrqrUlvbbKEtbDPlXtcX+ENgprsnSQFK0Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by BYAPR11MB2790.namprd11.prod.outlook.com (2603:10b6:a02:c4::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Mon, 13 Jun
 2022 11:02:44 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::89e0:ae63:8b71:4a0f]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::89e0:ae63:8b71:4a0f%6]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 11:02:43 +0000
Date:   Mon, 13 Jun 2022 07:02:39 -0400
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: RFC: repeated insmod/rmmod and DEBUG_KOBJECT_RELEASE - do we care?
Message-ID: <20220613110239.GA69975@windriver.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: YQBPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::26) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33308468-a40d-48ef-1440-08da4d2c3dc4
X-MS-TrafficTypeDiagnostic: BYAPR11MB2790:EE_
X-Microsoft-Antispam-PRVS: <BYAPR11MB2790C631BEA7FF8E785E162C83AB9@BYAPR11MB2790.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tPuETbUlEQSlXrlWT97/UxNYlJq0UO1s6iXZd5ztNH2DoQr90iFKUyLRDzc8mlR/6qAbG2GqsIquft8DnpPamy7sDr8IYJtuMsS2EsL/diB1dRouy/lJrYLmq4uPTf/PiLOMnr+e88YxHcZqJsbFcXT1SHOCqQr/J4c0aObo6N0hl7Q60bPSnC20+Z6sWZMp+XnXncVnhj/JLcfH3+ATK9Fyb5Cvbns6kdCOEeN4Wjveu29GCj4k3skMwJ2wRTKS44UvBo2S1arpdtB5l4wcNc/5poL6mhmlMkWpzbo/KMCqyBs1Oabhmc50dxBbmAYjD/qLD1JxtwNW5cmHwiwBq0Zl4zQh8WeKQB9vKEX6lUYlP08/i9aGRYX5rOd/DZEgeYJLD8ePVQXrcl8S5NtlmTQ2d60y27DD42IuhyxA3qHGN/L1YzxKKfj1GXyzuCjE5Itj1m+cosl9RUs3H0yp3/9facIPHCrqKBKZOzZx4r0zfTR3tWaHH9UBc4h490ILJaLVzNWcx131h2aMXrcPLMczaddkD2owiDHqCsv4nqqYBkqwuktCMLPRj4ujEIN7m8BfNK+4vj/7LJkCSM3rDaXCjyRkrWjZnD1t2E4N/i6UNPol6Jb/LAaNsg1VNJH2nxenEgBliRRLXSYAbltt/pR7sT9jUe1Abw3tyurpmc21CHUSKZ7oz4+tPhkTkiH+js8Hlu4HXeeVN41c8VKckQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(83380400001)(6512007)(26005)(66946007)(6486002)(52116002)(1076003)(186003)(38350700002)(2616005)(38100700002)(36756003)(6666004)(6506007)(508600001)(44832011)(86362001)(110136005)(316002)(66476007)(8936002)(66556008)(2906002)(33656002)(5660300002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uiIIp7WP6bolmYrgOgpAhR7phBz6jlwMVnEnfUz+fQUVmhkfXL9zwn+z8Scq?=
 =?us-ascii?Q?hVYnxeuDkDvWIXntLcCTzmoxGgOiRnpcUWxqr4RJKPQ974PwJLlqygpDhgG0?=
 =?us-ascii?Q?EpxHaYaZaDagR/U0P8ROYECAxioIBYVnqy5vJ2KOip57rXBV2hLZsJB0Xugq?=
 =?us-ascii?Q?0Q9E6ScrDkCoJ7uGwxTZZCf4Azmmk3pws4mz7dIiYCSpgkp6uqGIN3ztnk4d?=
 =?us-ascii?Q?BXW5ALBhQeAQ57WbwriNx3h1cWYocPVW2uK+9ogQRenbK5s8xDI90+u25Gl4?=
 =?us-ascii?Q?tfzUL1V/GcuaskNBbsjtwaN/hfTXq6XvhBDvYU0NIqv29VgVM6yjXKgfNxJi?=
 =?us-ascii?Q?eruQKTkr7xIRlQ2nT1+pc4yyMTb5n1YpPYb0Ck6dQqif6bWt86yw3L1AS8Ku?=
 =?us-ascii?Q?N/XVWv0WG/zH978/84nKlrxTskNCsMRKBJg6mICWJXkyf/r6pQnDbEQy2fk3?=
 =?us-ascii?Q?HsKyaE2j8aZ5XGrXQ06Z046xxYYi7VUHDkXhFJ2kqiWFn39kKGw8u4SX2TBa?=
 =?us-ascii?Q?xkDSbxOtWr88QzKLm5ljxWsL/Sk87YimPnp7lTWgk+IjNYks4BKUbf9zyFMc?=
 =?us-ascii?Q?ML+0rwJFpgdbe5pm291CzqxBU4jbI95IYensPMIwpTBy72JVzx2EgtLdAvH+?=
 =?us-ascii?Q?FAPF9vmcD3DP2F3OLJIKGIeBy7g47uId2Z3CeGR440U1ufeokkvU1KBo+5b3?=
 =?us-ascii?Q?6TBfNt/1quBbETc+Ql0JORy1Fq9mAXJQKgMwCTxvUr4HQ7QOTVVo2EO0Iq2N?=
 =?us-ascii?Q?dT8hgyVT0T4IW1BXsrex7sZhOLRfbPUWGOzrbt/X65UuAs+GKCdb/xWEamvV?=
 =?us-ascii?Q?VfPkyj8pnzujqXmtFf+UKH8tGZJGL3ZFQRfrlqLnHcmpi677JKAynj9xQ7E2?=
 =?us-ascii?Q?/3TzKVhRX00GYSwtzGKpLRMOKovfl6HMkZjc+IrsejENntC0u3c+XRJH+atr?=
 =?us-ascii?Q?m917ZrjROelukmWZ6G1CwCfs0touJtYS60t9MGqRwoX8VCnY159ElOWo/rGD?=
 =?us-ascii?Q?FxohnNrmRdiPKH04u67PXMJt7ljhc7DMSCpZM0hSWCDN2cRlTCHgbBxyYV0E?=
 =?us-ascii?Q?hXjwPYVpXOhGuByctt3xU8kzVXid+ROXgyK3NVk0Dz2qLQMk1bMCCReeQJD2?=
 =?us-ascii?Q?MHwPJzOyZGFKfLON2Dxm3Pvr7QLaRDPUokcO5H3A9Vcw8BcJD5rADajHmBoj?=
 =?us-ascii?Q?PHbX4XzrnTbUFzrYkfIi3D5Zy+7Ihur4bxp0xycwwnPt7UTY77szzMD0GfiF?=
 =?us-ascii?Q?wanYcMtcvWHPwcgJQb8T6+Y1BmpsWHVrieJXwgBTLPsPKmJB62d78fi5vyqb?=
 =?us-ascii?Q?FHNmM9wIZkAN6pTsqtEu4Fn3CIvEMIMwjIKwTYWQomhLz97V0BNsMUcKebPm?=
 =?us-ascii?Q?cTvXU08ozj69QNbA18TGi/ni/9KTo6Lnc6aedyZDuRZH1uQBYZWDpw8gLODJ?=
 =?us-ascii?Q?C1DA8l7TYxByoMamlDdfeaTNnlzNJM2mS83YecV58ixD3U9kWbNdwnK1d4QN?=
 =?us-ascii?Q?dsh33BUEwlwiOk/iABOU7S5UT/HIJyjS2qrqKGfXmimmdwjxvw8KS1FKvpve?=
 =?us-ascii?Q?gfLVPmCnY5/J+eyR4/HwDJOFn3+svdglPsYRgeYwwBpjxe+8UuElHYZJn6gt?=
 =?us-ascii?Q?xvwyt5OA8GbMxnGKOKQ60Nwrx23C6n4sAAdLCtthhE7cE0IxRVSLR4TBdGJy?=
 =?us-ascii?Q?sZ8rKUldRbWdpbs8j9r0UOJL+Ii1nav9mM8VlCraq1L9hm2K5uQd/O79XlhH?=
 =?us-ascii?Q?psyQJqooh7Sus8ZwqrrstnT0hHxrlXA=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33308468-a40d-48ef-1440-08da4d2c3dc4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 11:02:43.7912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WOC4vawOMxA6WHFGIM3yzNEsr9PGpTPc3ihuNlNuCKxaFC7pH8nQu36MQxrwSVyr1iYizmHlPI0biPY9qacIzka9pDAWC4JV29caNl/KSDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2790
X-Proofpoint-GUID: BtUl73gCBZIhKkx4ba6_d-5wCTXduYu2
X-Proofpoint-ORIG-GUID: BtUl73gCBZIhKkx4ba6_d-5wCTXduYu2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-13_03,2022-06-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxlogscore=776 spamscore=0 clxscore=1011 impostorscore=0 malwarescore=0
 adultscore=0 mlxscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206130050
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a person has CONFIG_DEBUG_KOBJECT_RELEASE enabled, and runs a rather
questionable test suite doing a repeated modprobe followed by modprobe -r
it will eventually trigger a duplicate sysfs name warning:

[ 1427.032646] kobject: 'usbserial_generic' (00000000c91a1c2c): kobject_release, parent 00000000890627c7 (delayed 4000)
[...]
[ 1430.110659] kobject: 'usbserial_generic' (00000000a633d9a5): kobject_add_internal: parent: 'drivers', set: 'drivers'
[ 1430.110667] sysfs: cannot create duplicate filename '/bus/usb/drivers/usbserial_generic'
[ 1430.110671] CPU: 2 PID: 1102 Comm: modprobe Not tainted 5.15.38 #7
[ 1430.110678] Call Trace:
[ 1430.110685]  dump_stack_lvl+0x33/0x42
[ 1430.110693]  sysfs_warn_dup+0x51/0x60         <----------
[ 1430.110699]  sysfs_create_dir_ns+0xb8/0xd0

For context to lkml readers, CONFIG_DEBUG_KOBJECT_RELEASE inserts a
random delay of between 2 and 5 seconds before freeing a kobject.

In the above case, the free was delayed 4s by the DEBUG option, but we tried
to reconstruct the same sysfs entry in just 3s elapsed and hence it triggered
the namespace collision warning. 

I'm not convinced this warrants fixing, given the contrived nature of the
root only test, but I did at least want to get it on record, so maybe it
saves someone else some research time, given a similar report.

We could I guess, within the CONFIG_DEBUG_KOBJECT_RELEASE ifdef'd code use
kobject_rename() to add a "-zombie" suffix or something like that, but then
it might mask name space collisions people *do* want to see?

As per above it was seen with usb-serial, but I suspect any driver with a
sysfs kobject could reproduce the issue.  I also didn't reproduce on the
latest kernel but I can't imagine anything has changed in this area.

Paul.
