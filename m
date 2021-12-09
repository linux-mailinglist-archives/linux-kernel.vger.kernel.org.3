Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530B746E927
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 14:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237987AbhLINeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 08:34:20 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:21926 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233327AbhLINeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 08:34:19 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B9DDsYp028912;
        Thu, 9 Dec 2021 13:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=t/YeX/c0gvO9cwdKiipW4oEUyDOnsZ4gPMW/M/jr7Cw=;
 b=q565+A7x7MTgO2pkQ00q9MSTB+D18Tadvx/2wAZ3cPLlkWMVXAeytH3hiSKl1QY6pssh
 fkM1Wv33f/XoRqP8DK5CQN5Nqo66tPWAwdNWxAMH9wVS5b85no01PvFbRgHI5Zud3yhL
 k7wnLIPpuwI9AvJkPj2WFYkekIjmszHrGLook81f9KEQbo7WDNcC9ETKyeZFxYmuiy75
 +Qd43bN5Vhug2CyJ91Ds4d59YNXTM+PlkvX1xFaBNSwssNfoGMzC+DDbADyTYcs3ANv6
 kfj5lCEWLCGHrbAZ4tjgMdKi6gpY/9iJUMA4mPcDxSQ8VxkffvxWv1MM5XzA8oQsSkjT Uw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ctse1kb2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Dec 2021 13:30:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B9DGmsF112367;
        Thu, 9 Dec 2021 13:30:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by userp3020.oracle.com with ESMTP id 3cr1sshbwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Dec 2021 13:30:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kh8yJuSvi+7KuQVK4CO1QUf7oYzKCQutDpgUI7qVG3PWhDaW9NM4es/DIFNk1iMIF2Gtkjobq0eanySYs1rIEsUkJpn7Uc3Oib/g4PZnUFWRa9/8dwhN/3RbG65hp9GYH7Om6ZzyvsaddrGVI9r8KS5IyGtwxkDoqIm7jwBTQj6VD+qzu9vyTLJyZRWeh7D6jaQiEsDadKIo4Hkxd7Lo/YAlIfRKniPgw6w5n1WSZLVElAn57uPnqKoKtXG2uUodAKW421MmreIO2fDolEhPC89XdD4MBvXZVoIq6wW+fSDcGEEde4+/V1trR6XVTKxdoWkInI/qiqLAaGWGkTIyJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/YeX/c0gvO9cwdKiipW4oEUyDOnsZ4gPMW/M/jr7Cw=;
 b=chD4G4AxRUrWyC+rFL7GzSRQADIJRO3EU5tVmluKIo21yiuyBaYoXvUHIBxBxbPwKYBSmRsgHnMynypoVbGOkPBv4q7qJIE/ZudexGewMMYRauVk5Kt0S0TvliWgbYwmo/w6ZT/mTq7vY+GJSHKxm2HZLEzc/LPp7VgLc40GIKGmxdzBKkt5LvEKQopDKmoK8XSmC3mI8Ey5G5CHGgz+muR2Hyh1AUQgcqeOcgAAIkd38WaSpYeSzN5XA6+7+CCoYauUHtJOT1hV3st0kpOOkTBYwoTE3vy9FRaIrFx96T3HW3sVRhVirwZaNR7d0KltEeeyu4/RSxAmSkIYTiGccg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/YeX/c0gvO9cwdKiipW4oEUyDOnsZ4gPMW/M/jr7Cw=;
 b=z64N5QhxabS3OBRM3fyHQJQUsU2hfDZDPKN+ZIW013RhxjprF6BGr0YZeqk79zPRafhDaYbx8+QRvP1P9AlxDIHIHjQIGwwzbTgpZkGMUkUjjn/2ZPcQAa0cRjc6t9asrWXgrchJs59qXpqdv0QQiklzjyCkoYMRCiYE5cAj7jc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1565.namprd10.prod.outlook.com
 (2603:10b6:300:24::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 13:30:32 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4755.024; Thu, 9 Dec 2021
 13:30:32 +0000
Date:   Thu, 9 Dec 2021 16:30:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Sai Teja Aluvala <quic_saluvala@quicinc.com>,
        marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     lkp@intel.com, kbuild-all@lists.01.org, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        quic_hemantg@quicinc.com, linux-arm-msm@vger.kernel.org,
        quic_bgodavar@quicinc.com, rjliao@codeaurora.org,
        hbandi@codeaurora.org
Subject: [kbuild] Re: [PATCH] Bluetooth: btqca: sequential validation
Message-ID: <202112090340.ohuHwTLx-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638952007-32222-1-git-send-email-quic_saluvala@quicinc.com>
Message-ID-Hash: QE3P43AIAF2DSHCYIZOO4N7NCULSVGIY
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0001.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNXP275CA0001.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::13) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Thu, 9 Dec 2021 13:30:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ee910da-fed9-40f3-24a3-08d9bb1812d7
X-MS-TrafficTypeDiagnostic: MWHPR10MB1565:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1565005108DA3D2C94588AD48E709@MWHPR10MB1565.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hXXBNJvJdTaxpzrqX1SfZSgU4Y6RkfKcF+WhpcN3+PEQAurRscNm2TqlmaO1qPJD9IzFL0dv01ZiwP8qvpGGufonJpCss3jLOfIu1NNq/opH731QUM0f7rBbfFvW3pthlDvNeZEleHJjWDiRkndqHV4UzmWIaYaFzNqLSbs42r9koR9M38WNhxV/axbEgeRRH8Hs4UuZMwmIdbqutqj8vEhJ28q2jV65fywRq7f8gjQ1hnAj1By3ASkYU/wZ2jSBsFFLIDB8nhYfrpCZBZEwh46loY0H6qSaG4lipGoS7u550U3bz9So4mJK13lgpImUutvYQJPhnF7dHKJadh3oM81VV2Lv+rxJGw7p6DHzC+F8AZrDBmHqnvswGayo78la7e0OXkaKgieePmGXSz2mpSpl8I6kzKZhL7NjzF/YTpp4CN7DXjgejE87PfQT0Pnzh4N7uCl+5Ob8fFYmlkHI/o68vMvx2Jwaw42EW5wWwifTwN0FC7gs15WJZsoQiL4fPsN9dhNG7O4UPDH9WW8pBzOAt1tMLPOr8Bn5WnIZ54WRvHfvp5TpCZgP1wex/kDPro/MbzkrMD1ldt5AWa33g9VzAdAmxYNA0rxhhdCZZmgVopKtBFB6ZCaITaR+DHRlOHnKpUbcMjnzdlv+vpfz8eevv4Ntc6EbxnSW/6h3uPE8zk5YS+PLqLBqPYyTUbSn4dHXnLHNsthEuL96PemHHmjniPNOMOcBUBcLeqf1NPSJBNIaYa/YYF/lNGZ8UKJ994ISUC/5pgkHdZl/Bdjf5oqu4xWow7yzGNSbRhtTq8ZlcX+ZL3b2OwyTJoHeDxGSmiQBP10zChr/W9hKCkJghA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(66476007)(956004)(66946007)(26005)(86362001)(4326008)(6496006)(8936002)(5660300002)(7416002)(52116002)(8676002)(6666004)(9686003)(6486002)(83380400001)(36756003)(316002)(1076003)(2906002)(44832011)(38100700002)(38350700002)(508600001)(966005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a6iDx1pcMI0WmszEVr8xV+rdrbYEdE6NDyK5tyfsCSzabzyAEztslak16RpK?=
 =?us-ascii?Q?eJoyMBLsHkCQEI9GJWDnzWl+YDLmPp3nBaMOGaAnYbboqT/EG86D3KUPBJbH?=
 =?us-ascii?Q?OTLz8RxqTB9NZLDvcZeSI1WW52VeeOMC6rnqy6dzRfNF84ughEbK9ijQRnYy?=
 =?us-ascii?Q?axJdx9wk5RO1e3VbERuSowXXCS3q/gykrG79FBp44EhwZsEXfAzCVJgZju7s?=
 =?us-ascii?Q?QWxqLq0b1DnCXoylHyeefxKEUPXOthcTMGdko6v6mYpC8QG8rClA7M7kIIt+?=
 =?us-ascii?Q?h/VWpd3d7b2bIk5u3NAQlpQ51KWn/rAU+eMpS0OaP+GDT0S8TPCbf/6j8DSS?=
 =?us-ascii?Q?j8SHhWbidqp8auESZnmTJ+1v/KJ4RTWBgRGvACNo6pn7ldx2+SEERsW5dBrL?=
 =?us-ascii?Q?iofmRb5MM0cTjAtdC6W3HIxUMp95e/Zt+AFzw+KLCSonpa6m+zJ0m2h+tCLx?=
 =?us-ascii?Q?EVFsBjt+Z7Mjv97BljjK54m+y5zyx/7g2XEzVZMfoeCLSzs2Zbv39BS7b/9E?=
 =?us-ascii?Q?fl/7ndKJp4eTpEOYCudWc7lbxrK6aW7YClqNbfIX/g/VPzhtH00PvKjPwGFm?=
 =?us-ascii?Q?1EmqnRbTqUCdfr5wvZ10wywR0E8W8hiK43GjwpBXVRaL1zUjVpnbJ8RAq6yK?=
 =?us-ascii?Q?kjXNNtI6StE0kmupdVL8+XVVI2G0qwePkyDgYfNXEkmAGVP5P3Udq1GSvq/j?=
 =?us-ascii?Q?aQ7YvK1xXJUc+2jLuLvEMxqV6+m7NPCn8uxGCF5tru36s46cs/j+HY22lRgt?=
 =?us-ascii?Q?A60dq0bWHK4rt6VZR5puFpRnuX2pmS5CJnjETgLFFW3EeC7DEXyMkz0GyqR3?=
 =?us-ascii?Q?bsD63sVfsRvUPDCPfzBz1Cd5xggYAO3THz+vjqOHxq1Z8+rzOr2a8Fo7iuxX?=
 =?us-ascii?Q?YWXWpKivP3c8CiFPWaMLHZh8TzmISZ3ENRHGLXZr8uFLmSopyuP/nKDMg4mO?=
 =?us-ascii?Q?AUfDJgPk7tqC8FHcuvwDmzG7xaUlrZs3zqJmGGpS28G56+PJjfZe0aLHBH9O?=
 =?us-ascii?Q?bY0oPM1mTHHxooSqWUsRFWLRhugszXXEZvTYjTFdqRzXMhOjCtJElwdN5BWW?=
 =?us-ascii?Q?QFmjPzE2nZvaPMyLQyk2/dUaqMEUJhvkkik7v6vsoDXw0VY4JTR5URQfvt4n?=
 =?us-ascii?Q?tquoDqvKMkAgtjzkuFjWBCJwV9sg6/zJwRupHriWZXFu5zMi/hHt1B1LfSLe?=
 =?us-ascii?Q?eIZ3OQvRlr02eRGDqxisyxetTCyrPI+POnd1Rcv71Ws4FH+YqetSxtveCA2q?=
 =?us-ascii?Q?N2Um8ysYBtpm8MAHndco3NeymPtBw47RRCf8fu1JjPBxhW+UxwZ3r99vQIs5?=
 =?us-ascii?Q?cXtaCa4myIX3EhNeG+nb+BE4ftHoeaT9nA/uVz12dWI0QOmYkr47zIkCp0a7?=
 =?us-ascii?Q?rZUGCat/NyGenKe3MxbKJ6TlP5TtxemHrFO1v/AmR4kWz94BsLehav9rvwbv?=
 =?us-ascii?Q?adP7uk+rlS3sFIP0wN5ke6haqQIjLnxxAdsv83DIpi95z69g55WyxNsQNZot?=
 =?us-ascii?Q?JT2Ok5IG+D9J6r1FC8bJgrup/G+XPrQQIj+mKUnj0qYVyeeaxklJOwjnAub5?=
 =?us-ascii?Q?dPgjIeIZxtrP5n4Itlz5JxFCzbto+uFZw7GnVmYWhfGZZCTCG8+3bTeWQ0dY?=
 =?us-ascii?Q?LwHsc9lgtu8HSf5qbbDxB/HvA5i9EK6SLHrYXUfNtfjYftzyDW26393Ngy6O?=
 =?us-ascii?Q?I4EPrcHZJZTPBJDu+lqSaE14UGo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee910da-fed9-40f3-24a3-08d9bb1812d7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 13:30:32.1423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKL8AWcUNvJMawsIzh7NukNzf10HMvycuHnydS6ooiw+wwlI7sNJicyCfIFT0JwXCGrrc54KyfAQ72+AvmKiNIV+wb/K7Uynq9Stlpy82zE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1565
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10192 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112090074
X-Proofpoint-GUID: m9hK36aB0Cbk6Wn2HRExCHwFJikrosx_
X-Proofpoint-ORIG-GUID: m9hK36aB0Cbk6Wn2HRExCHwFJikrosx_
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sai,

url:    https://github.com/0day-ci/linux/commits/Sai-Teja-Aluvala/Bluetooth-btqca-sequential-validation/20211208-162834 
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git  master
config: arc-randconfig-m031-20211207 (https://download.01.org/0day-ci/archive/20211209/202112090340.ohuHwTLx-lkp@intel.com/config )
compiler: arceb-elf-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/bluetooth/btqca.c:180 qca_send_patch_config_cmd() error: use kfree_skb() here instead of kfree(skb)

vim +180 drivers/bluetooth/btqca.c

1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  144  int qca_send_patch_config_cmd(struct hci_dev *hdev, enum qca_btsoc_type soc_type)
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  145  {
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  146  	struct sk_buff *skb;
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  147  	int err = 0;
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  148  	u8 cmd[5] = {EDL_PATCH_CONFIG_CMD, 0x01, 0, 0, 0};
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  149  	u8 rlen = 0x02;
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  150  	struct edl_event_hdr *edl;
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  151  	u8 rtype = EDL_PATCH_CONFIG_CMD;
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  152  
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  153  	bt_dev_dbg(hdev, "QCA Patch config");
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  154  
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  155  	skb = __hci_cmd_sync_ev(hdev, EDL_PATCH_CMD_OPCODE, EDL_PATCH_CONFIG_CMD_LEN,
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  156  			cmd, HCI_EV_VENDOR, HCI_INIT_TIMEOUT);
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  157  	if (IS_ERR(skb)) {
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  158  		err = PTR_ERR(skb);
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  159  		bt_dev_err(hdev, "Sending QCA Patch config failed (%d)", err);
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  160  		return err;
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  161  	}
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  162  	if (skb->len != rlen) {
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  163  		bt_dev_err(hdev, "QCA Patch config cmd size mismatch len %d", skb->len);
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  164  		err = -EILSEQ;
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  165  		goto out;
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  166  	}
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  167  	edl = (struct edl_event_hdr *)(skb->data);
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  168  	if (!edl) {
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  169  		bt_dev_err(hdev, "QCA Patch config with no header");
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  170  		err = -EILSEQ;
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  171  		goto out;
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  172  	}
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  173  	if (edl->cresp != EDL_PATCH_CONFIG_RES_EVT || edl->rtype != rtype) {
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  174  		bt_dev_err(hdev, "QCA Wrong packet received %d %d", edl->cresp,
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  175  		 edl->rtype);
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  176  		err = -EIO;
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  177  		goto out;
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  178  	}
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  179  out:
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08 @180  	kfree(skb);
                                                                ^^^^^^^^^^
kfree_skb(skb);

1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  181  	if (err)
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  182  		bt_dev_err(hdev, "QCA Patch config cmd failed (%d)", err);
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  183  
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  184  	return err;
1d58d86c5374c4 Sai Teja Aluvala               2021-12-08  185  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 
_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

