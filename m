Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8454CD094
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 09:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbiCDJAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235377AbiCDJAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:00:14 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534E2B23AC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 00:59:25 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2246aBMA019468;
        Fri, 4 Mar 2022 08:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=xwu1WX+KF6nQc8/HKgH9Mbn5jUawW+gEcIqqiAus67M=;
 b=1BnPtwns+r7zYRIZdV/6Z8MkKFV5+Ligh1F/tZ+MxbKedSA0rw2RZ8epiK3c7HbwiZ/T
 xudttGcoiVyAClb1aZDXj57x+iTEMuq4kvS6HM3cGueeFs/AAd8TelmIzWE4/22ZaYmS
 +vk6p45DzLCdZUMup6MyXJlIU5WoRu0Ap8SnXxSD2A/7qTHpkq3HreQtAg4I63MatKaM
 g3JmXVLhW3unpcnPPweBFGftlPuj5CDIM9YVMhZO2QedniLDsD+p1DGSuutOYB/EydLF
 ZnwotyyuOrytodFsXrCHiu06jhhhCiBbE6L6h+Zm7fC4aDnn6MdYrSXtbH8vAok432/o fw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ek4hrs78s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Mar 2022 08:59:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2248sgKR072043;
        Fri, 4 Mar 2022 08:59:15 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by aserp3030.oracle.com with ESMTP id 3ek4jgmx98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Mar 2022 08:59:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5LdfpEviluwCvBhG5Z0Sn0W1sr1lSsCS8LcIHEFyZTRX1vBF46ImBQdsmIABb9cyI8NRKV3HyfrAVAjyXk7AW/4NZKwzaKivyGA8CyIzRtkvHbepSPX+XHU47ZxgizR5AkLnxqrXHNrDuTaiMZ5ZmG2KYI5uZsYIBtFQCzvo6Brtpoac0yMvXHwEenWSWMrXMgd4geTfRefN9+dWQ4aWiS8T0bVif42q5551xO+w254vKoTO6RfQvsHgxpaiuQC+F22ALydMxRxwGyZbvMusSjtHotomPh9IXJO+STMJFRxqPRQ6MclVeYL3oMvFFLUmtpazppRVCkoyideYnCgmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwu1WX+KF6nQc8/HKgH9Mbn5jUawW+gEcIqqiAus67M=;
 b=D/HTIL3HPxFE4F3TxR6Fm2cPkzi51t2tNBiebTGzLkLTdTwdyHKAHO7T7lfU+ZuIRlZOeBQztQNsp4bos6evVGt9DvNOERZ5Yeu0wsOpfGbXYaaEdXFsVSONcMB5O632z7qKSabfYTu+F64gK7W6UerEK/BNLiBMESgBl8U9LCiAzW4Od+ePuBcU7vxCx5IEdMVfeVG8KN1zEbFDCt7dBvuo0o72mBZjfhIgVZ/lBDNzHEA6mIXVLn+RSOmDSn+dkV6WSk55ue1rcT8udKYaXEs7qP9DBdDWvSh5sa7jgElMjfOOVY30z+a4qU5vnVPIUzIIKopFYrL3Zn4rx2OilQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwu1WX+KF6nQc8/HKgH9Mbn5jUawW+gEcIqqiAus67M=;
 b=LsbCiYK/wLUDCRkoVIZZiZcIMVKXBus0A6m164BJH+NAKwf9FK5hNgjrFSJv5tBmSUn96xZqsdPmBEF1LOIzv3tFW/EeVs+YVZnTgptPXLW7v1Khq41R8o0LDyGwbO0y+uhPyl2QHaeGYXQ/jR+5Gghwdd3HSHRU7l15z7F6Ddk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW4PR10MB5882.namprd10.prod.outlook.com
 (2603:10b6:303:18f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 08:59:13 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5017.027; Fri, 4 Mar 2022
 08:59:13 +0000
Date:   Fri, 4 Mar 2022 11:58:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
        linux-kernel@vger.kernel.org
Subject: [tnguy-next-queue:100GbE 179/215] net/dsa/dsa.c:486
 dsa_port_walk_fdbs() error: uninitialized symbol 'err'.
Message-ID: <202203041527.OdG5EuV4-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0026.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::13) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 554851f7-4fa9-4791-cc64-08d9fdbd4067
X-MS-TrafficTypeDiagnostic: MW4PR10MB5882:EE_
X-Microsoft-Antispam-PRVS: <MW4PR10MB5882D7BF0CE16AFED1D664678E059@MW4PR10MB5882.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wcG+BWLwylR7vi2gY4bL9+SMzoPkk0rGsKQgIH1xqtmZB09m7ddrtzL1A7hRXs8AEtYCQl3l03Ef4kBSIEp8p2MhIqT4PKcQERPFg9tEIJg9niI/I0NcPWsapS93EFCWuVTKDTSogGVSPnl8ZcKFShloIZIfaQuU9L5t2Q+7xp3z0LY9M8VgzZEg/l83fVTgVRAmTG4peihfhq6nSFB7BKBVjB81P0+HCo13+bZ+cNd3GR1dUUHx84KePgxA1xkw/BCHVt/kdeXDgRQVzHhgwuFRhBLpSoF33YBZ3DWzeeC5SbRVlWQHZQvZk/vQ/eCLUXjwENJ8ULeJ0jgAqR2M0Hugu+Xuthj5OfFfNdoJ02dAHxOc//hea+JYHLy5789ZaFb4TlWkxtrmfKaBqtlB15lp8iENXxcaQYXlmK+BnYa6qld2RCYGXyGB/MpFHKxo2a2bZMTIptl7erZv+r+CLRFy/r1QseNupiBRlxXXvHPaXqK6Me5yKb/6w/qvdqC9k2L7EBxGeDpzOBw1F7JY4evcOHsaDENaL9fjgDXAXAJOFN1WAfW+/EANnUI0soWggk7lNdpCSC7dbf1YLRR3IiKH0jMF5CIN1xGskuHnLBfzNt+Jgy8ZJ04JX4gHwm3Gz2O7NmsrPnSx6ekHdHQWfhqq5cXmZlCAUbEZFDoBIfchbfo0Blgls2bDhIDyJwlHTrJY5FY4pJZzo9qYcIq1BwvhvkXmj2Eu6eyAtjFHvFxPh84Q6Ams5b1fAJztscB998If+oXzky9qX6Nisi6Q3fwwx5QmpLy1chDpAfiOP3JbkaEbXsVcaDL79P3KnI+qzYVp28d3dUpMUEvC4AGgQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(86362001)(316002)(6916009)(6506007)(6486002)(966005)(83380400001)(6512007)(9686003)(508600001)(44832011)(52116002)(8936002)(5660300002)(2906002)(26005)(66946007)(66476007)(66556008)(186003)(38350700002)(36756003)(38100700002)(4326008)(8676002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VmkH0kKbedP1dr4Lsz35fn4r29+r5qXTiS4YmMVZ1YLwD4bl2NtmHiNfqzFh?=
 =?us-ascii?Q?QbJb0S84v5p3IUpKMh4Rq1Jd0B8LizySDvqj3mQ7huVKST9dUqBaymeGXFi1?=
 =?us-ascii?Q?Iao1nIRFyDHC66wgLgqBEf1LZpdHPWDxmnJtEt9HQkCSAB8HXpUvBLYle9qc?=
 =?us-ascii?Q?1TTd3vrVNzY8p9EY5OUKaB5VMevS2EAiH/x6xBHX7MZ+DtdcXlIkVUAQyARW?=
 =?us-ascii?Q?gwp83EWQCdVYBCW8riYUDvatzn7aPSZaSmfXVLU0ojlyamU9U4Kfd1Bhl+oT?=
 =?us-ascii?Q?TzJSBvs8n2odQez/Zkxu9WSCzPsOMpDzAu8Q83UGkGNvcacDvFM+s6oO0D3t?=
 =?us-ascii?Q?g0kVQ3aQ+zlJO3lzrAQf/YuUF45nQesUWuwav1gv5GmpQYWm+cg9i5tgWmYn?=
 =?us-ascii?Q?GkGxE2i3ysRJGUDyiAkYW2Xkuw0XeslNiw4QRcFmDzhC6g60uYH1sYQvPx7Z?=
 =?us-ascii?Q?uBAyOwsUxTbSXmyLmUr1raShHvqMWUAPrKbnm5MFXF6L8Jfws7DQcYJ9ZSVe?=
 =?us-ascii?Q?pcqY9mvIFO5sJlz72D8orCAj5GbgKZJRRNf2ZWVhMpP6MMF72JZXYfGFzW7p?=
 =?us-ascii?Q?ZmONe2wN1AJVIg17EI4ZnFQ0MSg88SsAo1FaXFVvpXj261xaKzdQxSVcqtAH?=
 =?us-ascii?Q?ri+SeZQIic++T0jCoT3mWoQDEu0vaIJXqg9gdDkFsqe3urvgDO5wmPE8Ry2S?=
 =?us-ascii?Q?hpQvwa3zxHIB+Ugy2ymz0tTxV51oi/kohi50gnvWImqi0P7Zq3vYkpelid0Y?=
 =?us-ascii?Q?pus1W+XU2pEYq200qsQRYGpiyOmDdishYNUR3PbI9TKEG6UvLraIvf2Ajiil?=
 =?us-ascii?Q?QIS3vuEYkO7pzx32wqQPcjOTA1mmSAyqxiDz2oYcRRp9H9Y+h0ZtNcLiuyQQ?=
 =?us-ascii?Q?5lj1r1fGOfMWhXGGBAI8jGHM7gZTH1j859E714HxKnmw/Ee8yz+AxpiDe0z5?=
 =?us-ascii?Q?7krDEVrSDbDvnMLUSg2q4ZQhjRWNwpcro62h3kfLVCcbpePT2yV2hhpBme5p?=
 =?us-ascii?Q?4f6jgYrBmcwUufWF8pyreg04/lu0HIftM8qBjA5aHg1qAEC576nbBMnw+2HA?=
 =?us-ascii?Q?NDU5Hu6NX+eG548c/6NduT/3mhXRzmVTtFQo5Qanl7yYK8pBS8tTpiwBzAe4?=
 =?us-ascii?Q?QVQt8vF2niwf4xA2ZZrMaXKiGDGLfa7jxhFj5zDuciQET8HcFSGDo15iJlI8?=
 =?us-ascii?Q?hVnSxDJLBgohEdW5G87VvV0yOrkzBJooTVo/vqB+xsEkU8NqLAFnegBDi0Ui?=
 =?us-ascii?Q?E8jPr+K+/+vuHcRHCeTDSD53szbiuqcBBMqYn4vv8K6sXfKRHjORwexQ6qrG?=
 =?us-ascii?Q?B91Kc4vsL4hC2UfF+3FiLFTgcZHz/IWM5GJqjz98U0Ia6hqzD8ORjJB50tnC?=
 =?us-ascii?Q?n68evHQ7VmFSUG4oyo9E9ifqZ1s+ijxzYr7qcYAsNCZ9XgaUSdpo9jBSBEyS?=
 =?us-ascii?Q?uVKVztyHk9CQHzSVQ+N0cRFJMqeTr8egvELPcd16UwAvlk12tRkgF+M4oBZR?=
 =?us-ascii?Q?M/AYHEmDcAZRdoVLirE28hLlWxOp13cmg42Hjms4cBhVal1XDufHnGiWvPAU?=
 =?us-ascii?Q?+70qzYpyPXReOh4y/egL63GmJfcBJgd9EpeXg+algc749d5WdJJn5sTYJXsU?=
 =?us-ascii?Q?E0G0FMgh/AewLpux5D1wnjvg/oUcA/jkzYSKXIZn3WnfhTA60aL9DHv3I2g/?=
 =?us-ascii?Q?4mmnBQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 554851f7-4fa9-4791-cc64-08d9fdbd4067
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 08:59:12.4732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IollHBkYBKeFgOmD2y6tMzt2EKK3d1bJYNWFo01RNS6neeyxkbBmuwp/ms+Ab+Pu+eBIuRtZOlmQFIqwVaUiuSnZsfL/W51NLULkOF8s14k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5882
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10275 signatures=686983
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203040046
X-Proofpoint-GUID: QGMxMixOgdcN9TES8WveBB6KDb6H7aEY
X-Proofpoint-ORIG-GUID: QGMxMixOgdcN9TES8WveBB6KDb6H7aEY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 100GbE
head:   3d5985a185e6abfc0b38ed187819016a79eca864
commit: f9cef64fa23f6c1ff177be5082113c5a94e34e5d [179/215] net: dsa: felix: migrate host FDB and MDB entries when changing tag proto
config: m68k-randconfig-m031-20220304 (https://download.01.org/0day-ci/archive/20220304/202203041527.OdG5EuV4-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
net/dsa/dsa.c:486 dsa_port_walk_fdbs() error: uninitialized symbol 'err'.
net/dsa/dsa.c:506 dsa_port_walk_mdbs() error: uninitialized symbol 'err'.

vim +/err +486 net/dsa/dsa.c

f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  470  int dsa_port_walk_fdbs(struct dsa_switch *ds, int port, dsa_fdb_walk_cb_t cb)
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  471  {
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  472  	struct dsa_port *dp = dsa_to_port(ds, port);
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  473  	struct dsa_mac_addr *a;
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  474  	int err;
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  475  
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  476  	mutex_lock(&dp->addr_lists_lock);
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  477  
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  478  	list_for_each_entry(a, &dp->fdbs, list) {

Can the list be empty?  Smatch might be able to figure this out with
cross function analysis but it's not feasible for the kbuild-bot.

f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  479  		err = cb(ds, port, a->addr, a->vid, a->db);
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  480  		if (err)
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  481  			break;
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  482  	}
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  483  
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  484  	mutex_unlock(&dp->addr_lists_lock);
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  485  
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02 @486  	return err;
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  487  }
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  488  EXPORT_SYMBOL_GPL(dsa_port_walk_fdbs);
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  489  
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  490  int dsa_port_walk_mdbs(struct dsa_switch *ds, int port, dsa_fdb_walk_cb_t cb)
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  491  {
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  492  	struct dsa_port *dp = dsa_to_port(ds, port);
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  493  	struct dsa_mac_addr *a;
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  494  	int err;
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  495  
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  496  	mutex_lock(&dp->addr_lists_lock);
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  497  
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  498  	list_for_each_entry(a, &dp->mdbs, list) {
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  499  		err = cb(ds, port, a->addr, a->vid, a->db);
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  500  		if (err)
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  501  			break;
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  502  	}
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  503  
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  504  	mutex_unlock(&dp->addr_lists_lock);
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  505  
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02 @506  	return err;
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  507  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

