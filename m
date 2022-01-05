Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C27485251
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 13:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239973AbiAEMSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 07:18:55 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:53838 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235171AbiAEMSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 07:18:53 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 205AxgUw008818;
        Wed, 5 Jan 2022 12:18:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=MgOV5DFh2ltKpntqXx5rU7BIdL80YclxAZA+kG3bYzs=;
 b=oXSaQZ2XzQSOh2/EkXlk+9D2lBvgLpYyET4PVZMc85JcvTen1D6dEEFfPgqPkYs8XpJH
 D+ZZfyAjwsbKsmJl2tBSUcBrbu0SbdaPe/qG7/Qpx1B8P5MLwJ4FaMM7kgaRkFdiHdRZ
 9OzAXC5kcCk6kZsnvL8ougEKWOqa/8rz8EsPU+bYM8r/sQX+YZeOKcegcIAVQyMY9g+j
 6/FBqwoXGaRF9122VjdDkPnmueOtsBeORT+b+1Wr4fPSF5yJIgYIU8OczCGcgCYRoRAE
 unupLLnLm9dsyEPxMo9mdDayTSRBjPhK7rKPwN4fPPwP2QAfbAKszL7MqYl3L7G1O05b HA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc3v4mps6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 12:18:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 205CCAW1038685;
        Wed, 5 Jan 2022 12:18:48 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by aserp3030.oracle.com with ESMTP id 3dad0ewtqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 12:18:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itB0LzuotpHpHb0hbNPJkofHZwPuvYMzzwL+MeE5AVhd135eZOZKpfxYek1wDjwlDPyZIugR0VOgyV5xMkovdlT5t7nS0KzR20bVqqgpu3NKLigJUe6d4v5ncJQ6+fY9tb5BOK5lfztfvry0YtCuGL76eSm36Km3QnUohqDE0nyY/t936DFJBdCNsCH2QRyLCf6p9VFLdsPuFDid/lPxFFirr7l9XWsNFz3Q8bBclW6ZPREhwNqvTQmGJEaepTKsJUjyg8ddHKMoyYdv0P9TOKs1gUI7r1Wcd6MAE1kpEVc/2sz522y6adb7LnfzDqj+drFmWXnCwN9Lb9fkVV/E8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgOV5DFh2ltKpntqXx5rU7BIdL80YclxAZA+kG3bYzs=;
 b=KLp4VAVI1sJ5NDBN16bEcnnzOdYqU/azoNcU/FOoDAicc3i6Pfh9mmfkzBgHmuRUUBBZvp7dQtZVlXh6ofnSD92LWe+V/82SaOavYSb/GQ1uh57WKBII6JaBB48xvnaswvRStXfNTVPjHY05N0yN0NhMQDBs/DZ5ops9ZtJkJwowl17gup2KyzofssVYK5odiI2A/nlgi8sZ0ARF4+3Phl51OEXA8rhv5CLJpimOzJDY5dmdjSv4LYZ4vVt1jEfgeuyWlU7wd3kfP1H43qSt0Yed+ZsgB2CHq1rAlQQ4v4Vkx5MmdMKWKWHCFsokIQdxNL+OqDOx4ju6Ixwo9W4kqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgOV5DFh2ltKpntqXx5rU7BIdL80YclxAZA+kG3bYzs=;
 b=MaRCK3YTYTX1tVWmKmVLbUzfpYNEsCHLbz4zJI53/5JDshPBa5eeD13/kk6foV28NY1i+w6UEVJweNpdWjGdyCWiryd48OrWlvA/Cv6Dawpt3sR/EbzOGhQW17XrnoD1v7x6PqHrmACfyJ9wZotTB2UtNufqTPt1VLmdOFpuzvE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1661.namprd10.prod.outlook.com
 (2603:10b6:301:8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 5 Jan
 2022 12:18:45 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 12:18:45 +0000
Date:   Wed, 5 Jan 2022 15:18:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: drivers/net/dsa/ocelot/felix.c:1329 felix_check_xtr_pkt() error:
 uninitialized symbol 'err'.
Message-ID: <202112110349.5CNAwmu6-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0002.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::14)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1b682a2-85f0-4f65-b937-08d9d0458529
X-MS-TrafficTypeDiagnostic: MWHPR10MB1661:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1661A3769A7EE861CD6CDF208E4B9@MWHPR10MB1661.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:541;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 00951SsCGoXJl5TYDNFtJt2WeLcOcATJwnnSxLaonHQr1ZpKRoFnlh5WHh+Cl2cWcW7SoCJKc6rekYmLVa8IPt/qf+rozIxiWtqCmhkoAVIavH8kYzVYWuwy2AmivIZ9eYF5/Ux+s+qT70GAdYK04QHppok7AgraayKSHGVG3kATqLavKr0PnEgtpnPsjDF468XiLlkaYsZTgGgIAlSR0gguSxD3kLxSxaSeB9nXvaR62I5fEEdz6FQlo7KpR9IotlVmKv/Ed9p4/XfH25mCa+TPKsml5gYxkVqxf14A1WU6F7vghyg5fSuumP2UdkwKaTWvRNsBUh+5UkyVItbjKwEpYKwtUlGSXJaivuvesdOJb70iROJUVXHSikBW7QrVZJ/YVxqftLNd90IfXcfF9XEcV1Q89m1zisWD2v8+ImbTmLJvT+iDl6fva4XjnTU7PA355gHIYXA5BLVTBQjjFJ8ozdpuG5XFz+/KEv6xl21WjBFFS4Ee07uMD0rKOfnuVBGtpYsphItNaLi3m5kqyv1NG6JAEpfxKnkXspMgV04kFzx1XgNwYQZLH6sDLIqHMTm7TNriepiCdsfMAYtDahdopprEEf8eR77TU3deM/jpDOWINnjPkV6VpAVvSugATJ1cI7tkwnTwZk2p+58u3MmS6kahIDLhD57t20dZXavyHvokXxP3xam2JtZyZ/DP4RUCC7nZfpjdPL2HQSXbTFy25GpILoAq8/eji7jjQQiH+MTG+C8kMlErqXtz53gQz9Gm/JIp6HQmM8xhmYTbavq48uJLkZHmQhTAS8kM+xMKXAyzo62VuVq/2FvstP22i0auBtYaIeAhdzzSJXZFCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(1076003)(52116002)(83380400001)(6916009)(316002)(6666004)(6506007)(38100700002)(38350700002)(6486002)(26005)(8676002)(36756003)(9686003)(66946007)(44832011)(6512007)(186003)(8936002)(66556008)(66476007)(508600001)(86362001)(2906002)(966005)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4TpdifBbw3ogaA72+szwi9olG0vdK2Hac6zZy6rzRJf4ZOlDD+RcOy/hlSFz?=
 =?us-ascii?Q?eKJdmjDD2CkHZ5OegkG+NvnXwhGoA+mLhRPgbBgBOtk2RhttWq3k/0s8exu/?=
 =?us-ascii?Q?wirIN5jH26nBjKOSkeQvQe6wOI84dn3oHVF2s9VqAs8w34NAkAHbJS8hfH+c?=
 =?us-ascii?Q?OXSnM2HUj/UXfEE89d5eA1DGwRhcSbpVy8h+UQgcJI6QT5vEXysNgePOl2Pe?=
 =?us-ascii?Q?rD5PwsF/dJcXP4Ay/ZlKQ2EwzqxQPqFGPMfX5mMtXxoX/RKTacAwVK9o9l5O?=
 =?us-ascii?Q?wfOlDlzP2pv0gJDdSk/J36zgBHbCY+vtGrG0JGIPrIfrjMSYSg007P8Phq3t?=
 =?us-ascii?Q?tQlvNy6sVrO4jP+pQ2jXk8XMOSBHJaB7cZzxaB/goSwF9pE8MO5MGY+Tzzmd?=
 =?us-ascii?Q?Ro2m945vbCiVdLQ0/Lun/7yUP1rGQUeTw+VtMCWlGDeWGpvAp0DncztaRvPo?=
 =?us-ascii?Q?CJ3EO3lCdQnEex5x9fwhBtvtrlYIJxMv0AXwVD23HvG4k5qeBECoLenZKg5b?=
 =?us-ascii?Q?mYS+qXjM+rX/KhrE8Qwws3z8LJ7xZvzIHAUP4Z/aMXz0P0glYqI1c0vVTXci?=
 =?us-ascii?Q?8jRfM5JybWc+4PLbouZcI3ij/HrSYNtybLntrhqkeZWGxmhQr3hlQxREtETL?=
 =?us-ascii?Q?HVceqa1vQrXFtWbd5bPdDMRSslCBj45ZvtvqO6TqbSyoWMwzgfjAZX/XWWKA?=
 =?us-ascii?Q?m+BcWce8aDGdgu/ip1T8OvtrqLUxvQmisIOI6YQxCvvE+ilnaoLh/ymesa9G?=
 =?us-ascii?Q?AzIsVWM7Cns2eb/+c2HK5sbeglYDZCjpBV7RCHDlglJchpgi+gGR8fO04SXG?=
 =?us-ascii?Q?NlaBVp6b1CIquIu1nduJb3o4HysTDyw/erQNz1mm9YxsTK+PnT0w5UdwGW/J?=
 =?us-ascii?Q?rOF19KLsd8pOTwgRH82FWOesKDd84CorEVYN8VhkIF2NEZMSqmaM5ubQSOQk?=
 =?us-ascii?Q?SXGM93uWh1Eupw9Te7uOwcy95Nz6bSLN+goRgIdW6zQ5znQnbg7slsdGVNbX?=
 =?us-ascii?Q?MlE4EPMio4i+Hp2gIGTv0GBhgPDI007W15zhZHansca40VgadqkeYkLrc6+P?=
 =?us-ascii?Q?3ajawAeqk8Ju1W++tIN61TDbxNi+LPH+uDfGWAIsgnIig/BA8Fih+Np8Bnx+?=
 =?us-ascii?Q?hmVR7USyHZzM/7oyjOge+Gkl4op14xyazC9ltxGEy+/AppsoJ//Iw40713Sh?=
 =?us-ascii?Q?nY8wfkg2iHBg94/ovJVRTbCEvriocgYPEuejnmGgWLtjYHWT1iYUT6VGQBdd?=
 =?us-ascii?Q?VSsxwbd4C5l/Xw17druQDubDf2uiuw+SS8+OyWKsD/FekEXFWbdGRQEg7RR+?=
 =?us-ascii?Q?YKdOcFPkqtLDHEUbabz3x6fnc9jEK7lxWRouAtqX0/WIkeCXU1zVMzts+RwM?=
 =?us-ascii?Q?FkiMOcIphz3w5THLhd8lgdASEtPUeAnNWitvErZEern1SPxV4U/Wt8xl5CLf?=
 =?us-ascii?Q?qxggnJr8U1seY6wkxqJ0EDC9hhMCtYElB7fNm/RYn0apFyZja5FdW0zwx5TP?=
 =?us-ascii?Q?pVDw9kNWbmZBue+lqn03ouaCQnSWByoffL2vj9CgF45znXB9EuYvha3UjvSF?=
 =?us-ascii?Q?E9lbYyZEgf2dUK/6cgzCYjmXGADFjkGfrCUdZ/+/wvuWpsJI9YGuaLGdHGly?=
 =?us-ascii?Q?NBnnKnwmW5IWeR+85EI321OWf9epR6y8ZaamQ0XENPGWBvzm2AlTwc1QuwPn?=
 =?us-ascii?Q?bdVzQj/FfQT939yEC2ldaY7gpcY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b682a2-85f0-4f65-b937-08d9d0458529
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 12:18:45.7248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pOHdkKtL+QYAGEvDEro2o4lN93J0ET7wJrsqoYvnQuOUhuOrChKSZ5mo6w09GHwt4k5UWWcmzYYRj0wSqh7IKt4ebUSeKkXD1ltJ7F/rWHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1661
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10217 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201050082
X-Proofpoint-GUID: O1o6eiem44lWfa2W2CSTTuoT_f31oZyn
X-Proofpoint-ORIG-GUID: O1o6eiem44lWfa2W2CSTTuoT_f31oZyn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c741e49150dbb0c0aebe234389f4aa8b47958fa8
commit: 0a6f17c6ae2116809a7b7eb6dd3eab59ef5460ef net: dsa: tag_ocelot_8021q: add support for PTP timestamping
config: x86_64-randconfig-m001-20211210 (https://download.01.org/0day-ci/archive/20211211/202112110349.5CNAwmu6-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/net/dsa/ocelot/felix.c:1329 felix_check_xtr_pkt() error: uninitialized symbol 'err'.

vim +/err +1329 drivers/net/dsa/ocelot/felix.c

0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1286  static bool felix_check_xtr_pkt(struct ocelot *ocelot, unsigned int ptp_type)
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1287  {
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1288  	struct felix *felix = ocelot_to_felix(ocelot);
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1289  	int err, grp = 0;
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1290  
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1291  	if (felix->tag_proto != DSA_TAG_PROTO_OCELOT_8021Q)
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1292  		return false;
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1293  
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1294  	if (!felix->info->quirk_no_xtr_irq)
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1295  		return false;
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1296  
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1297  	if (ptp_type == PTP_CLASS_NONE)
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1298  		return false;
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1299  
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1300  	while (ocelot_read(ocelot, QS_XTR_DATA_PRESENT) & BIT(grp)) {

Can this be false on the first iteration through the loop?

0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1301  		struct sk_buff *skb;
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1302  		unsigned int type;
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1303  
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1304  		err = ocelot_xtr_poll_frame(ocelot, grp, &skb);
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1305  		if (err)
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1306  			goto out;
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1307  
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1308  		/* We trap to the CPU port module all PTP frames, but
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1309  		 * felix_rxtstamp() only gets called for event frames.
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1310  		 * So we need to avoid sending duplicate general
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1311  		 * message frames by running a second BPF classifier
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1312  		 * here and dropping those.
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1313  		 */
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1314  		__skb_push(skb, ETH_HLEN);
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1315  
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1316  		type = ptp_classify_raw(skb);
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1317  
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1318  		__skb_pull(skb, ETH_HLEN);
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1319  
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1320  		if (type == PTP_CLASS_NONE) {
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1321  			kfree_skb(skb);
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1322  			continue;
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1323  		}
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1324  
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1325  		netif_rx(skb);
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1326  	}
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1327  
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1328  out:
0a6f17c6ae2116 Vladimir Oltean 2021-02-14 @1329  	if (err < 0)
                                                            ^^^
That's what triggers the warning.

0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1330  		ocelot_drain_cpu_queue(ocelot, 0);
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1331  
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1332  	return true;
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1333  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

