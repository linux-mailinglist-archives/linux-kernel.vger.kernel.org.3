Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B2D5442C1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 06:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbiFIEsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 00:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiFIEsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 00:48:12 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2098.outbound.protection.outlook.com [40.107.212.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C09CCFB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 21:48:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpQ1VNY0Z8L7Iv/+8a0yVEbP8MQytBWzM75dUf8F5QZOrP8OC+lV+rNVErd44qbUIFvuRTReg1K3ua+9WuF7m/v/sjh0kvjDm7BlFRq/Wh9iuCEuu503QVBU5IWepcWtoBKwxDzcEyR/oD3wbkBY5EJqhwam4ZRMrTV4oTBY9DL2MJ5A22HDrsnxinmn5xoPTleO//x+gl61zDf1dgVqFUOQbPdn92jb4LMqWTx5qp8WiY+4f3JZ7xUK4gWLxYzzFhaVColTcjO9vMujQL5svkDUT9hlXYhxY5q0UH988RTBjdgdWKCDz86kWTUGROEpFzIUrxhlgKBcqHipkeRt5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KrhYr8W+nGITJDRNbH8p5hSjvEXsSz9hxm02VgvDa+Y=;
 b=c2bZ2Zg3deOy9+qDbkNuRg3lGrrMK7/jRhrkX2o/HmwEcs7rxxtrQOV0apASWXKGDAfpIqHFacO1KLp+D5dCXoSGpT85tOcWsfnnkJ3XHP7+PDalCaNAh9LaeXDOeksDNU1Q7EYO5z4oMDfW9yTMN/Xt0wAtVGs0YylYR3/P0b9y6iwls3h/vnhkAkDRP9iVuXZqp2zGwofR82z1UHjZTF0iIpRykLqVXXMASlAgt6f+yu6Wg0MxNo62M+wIlkqc89lreBqAaIXB9MzfU3FHsStwuGbnUCsuM+QpOaGFgojvK6WuxVf7/aNtRxZ3TG6cQjan3PEx8RBuRBM7ug1LWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrhYr8W+nGITJDRNbH8p5hSjvEXsSz9hxm02VgvDa+Y=;
 b=b1g492UNPj7wgyATLlP8dLZtcVIBhrglCmqL7ZwnCwt4czzvz5HUrPoeoiLQlL9D0nGQEYOd50kwm+ZktU3wT6u6IEUkcjHAqo9R64UU1CfZYrgzS9vHZ4P4AS+lrfybPjpi2uUTsuTUFyhPtbws7DPetCtX1FquzZRNM6jk+mY=
Received: from DM6PR21MB1466.namprd21.prod.outlook.com (2603:10b6:5:258::11)
 by BY5PR21MB1473.namprd21.prod.outlook.com (2603:10b6:a03:239::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.6; Thu, 9 Jun
 2022 04:48:07 +0000
Received: from DM6PR21MB1466.namprd21.prod.outlook.com
 ([fe80::9c4b:411:577a:81de]) by DM6PR21MB1466.namprd21.prod.outlook.com
 ([fe80::9c4b:411:577a:81de%8]) with mapi id 15.20.5353.005; Thu, 9 Jun 2022
 04:48:06 +0000
From:   Steven French <Steven.French@microsoft.com>
To:     kernel test robot <lkp@intel.com>,
        "Enzo Matsumiya (SUSE)" <ematsumiya@suse.de>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>, pc <pc@cjr.nz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [EXTERNAL] [ammarfaizi2-block:stable/linux-stable-rc/queue/5.18
 29/879] fs/cifs/connect.c:3435:14: warning: unused variable 'nodfs'
Thread-Topic: [EXTERNAL] [ammarfaizi2-block:stable/linux-stable-rc/queue/5.18
 29/879] fs/cifs/connect.c:3435:14: warning: unused variable 'nodfs'
Thread-Index: AQHYe413hlCPlGnlckeDto8mCFAPWa1GgLYw
Date:   Thu, 9 Jun 2022 04:48:06 +0000
Message-ID: <DM6PR21MB14661DE56E90EA3F4B053130E4A79@DM6PR21MB1466.namprd21.prod.outlook.com>
References: <202206090711.ZJTiUk4L-lkp@intel.com>
In-Reply-To: <202206090711.ZJTiUk4L-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0a302ff6-e872-4633-b150-e669cd0e18c3;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-06-09T04:46:40Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f74c2e5-42a3-44f3-ba8c-08da49d33ece
x-ms-traffictypediagnostic: BY5PR21MB1473:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BY5PR21MB1473E5510DA805798F47FEEDE4A79@BY5PR21MB1473.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GBgcN7sXu0BT3ZKNqYO+A5+EBPJnmS4UL3ftGluhwEP2CwtCMdPCDtTrBVxqG+Nab+NdKajECUMSNhe2/qCR+yenA+iuH77YhLNLpURz/w64mhbHMxrMKNMCObuo4AMNs/qd0iLSGEa6JMVh6PcmEt/CW3VP2WUkvLqruhTmq5oIlPmo1NMOwH5f1hcdFRf81rArXgD8kySkbSioUVn9VuVS8xHQxFHxbv5sVFhs8Nko5+qNZuUI/V/7wAVYnunngodi46VV258NqjWPycyRB66y2GOVrd5J/xLu2CHN5eK88jr2U3VBQ9oOfx03HuGVygnADrAjyfUlcKixgI6Nv45t7hwcV7+qLO5HklqIrav2JM1fctjED/1WK3aXHnJxNgRRgJZx4yPYk6gWYV2J/nDsPaZGba+34ZOqk5O0DcQRYcYi6NthxehpNgX2gTUQo5kW9e2MBDOoybwgRuiSNuuNxd25gdA2k1x8gi5Mf/ixfOFiJcSG21t/BXN2nyzvfl452Z9KVrqF7dzDZctR1jvfiHZ/F2AS6shoQAJy6axQFVjbnT3v2vh8HByn9NkbfY+MFIm6mJYHGpNAzo3XXK/LnezFaYKe7O5fDCCUYFaOWKQYs0tPVLThEaU/2ARVS/4gDQKVK2ZWlP81r4CSI04RZXsydZGAVhDZZWcuXsj+N3TzAvkE0f4fABrfi/ducG9xvaTwT268STPYgGHeg0Ygr7H7OUOnSvagqfzx5vxCM+as+pCpgK0CqmWmBMbti8g6Rcz2jBm3dKdxQUrxX8K4Us08MldkXrAHzc7N8dqpg8NJ8D0xE79150jT1Hct+q1zfPs1wr/DU1Km1ALdE26/1kyx0CnoRLyhkqORFP6sMnOSvOkOzFiySEHgwG9l
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1466.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(186003)(86362001)(71200400001)(10290500003)(38070700005)(8936002)(966005)(52536014)(5660300002)(6506007)(53546011)(7696005)(508600001)(316002)(76116006)(66476007)(66446008)(64756008)(66946007)(66556008)(9686003)(55016003)(8676002)(4326008)(26005)(2906002)(8990500004)(110136005)(33656002)(54906003)(122000001)(82950400001)(82960400001)(38100700002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HuApKs5rcUnjmipxcOqX4Ggyaop+54E8V4QIMNpUor0+he8Vfg7ySKFs7aQk?=
 =?us-ascii?Q?GVhN36QpdPoyCWAoYLiIeDIgVLWnqDXmG2nn+nBp9RhWoBVipdUexK64x+kk?=
 =?us-ascii?Q?a4qx4Wc6z5a4ojXyQXua0vOqMfeyLKJAPaisftAGbb37BSyPFd+a4U5qU5D0?=
 =?us-ascii?Q?c+vzrv4K5jUoqg76nmK678rjCbuVVwFI6zIgJtQrK8R1Qjlk+CA2CgB/LKmy?=
 =?us-ascii?Q?8H3LHTgr6DEr57Rla0zAOC4OFKgShY89VRsFp0ipCijSIUasKtKZ0yyLcQfW?=
 =?us-ascii?Q?ObiAcF8yVy1I/98UFjOymXB/GRQywJoxgNuXjBSi02/INAfgh1zdblYbC8z7?=
 =?us-ascii?Q?cC5WR43aXEDe8F+nleLShyCONoVMnbIldQ0ZfrZAWuI6saCcpYc3fT2Gk+u9?=
 =?us-ascii?Q?KdDN+uWE+OAxoVuapeY+R0AwGdmHEu2t5ZTvEMG5rQPMKwOWL2KSrsecfrzX?=
 =?us-ascii?Q?Iraj/CuM4tn5uLirb+U2fOGjPK8zXA34shC6As3MMwahsVCuaBT4oL2LeUE4?=
 =?us-ascii?Q?VOpvzCtfljvdxAdhb41SDFyIabi8OUxiMDzQnTyQ9wH1lRRnvO6w010z5ZLm?=
 =?us-ascii?Q?QtqIp41OdO/vG3nRbiyrxYH700Ov9aAISbmDRiLwOCT/9xeZymKqg48VLoGC?=
 =?us-ascii?Q?SiZ1iZerEFV63YeEpRIx80RlNFnh2d55lmJK/l4cTT4YZwp6zM2TcnVMJ7XX?=
 =?us-ascii?Q?MjRWVWS5mrCJP2Sjo62ZLLIZjKZZU4HW8CSxWxLldFROPLnFykepN0wJFPSQ?=
 =?us-ascii?Q?WUbvMBmKGhaUsfQX8W4kwMpTV3wXRzr/aLgaIHuk4teoyKILAPfo7Yw4Xda5?=
 =?us-ascii?Q?VSYIRhM+rQ9m8ed2wTKqSEnfC2PQAABO+iYgdZZc6CwEgAqQCTrXjPARc8m3?=
 =?us-ascii?Q?PqiMGIRKDYDsTEsOYEBjkuTukomRA3s344y1oZdCWxS9hhvjl75TsFTYheSf?=
 =?us-ascii?Q?/0L/vYKMBVbH2StJURNuGkU68SrTqdOmBAcqzJrF0elFk4j4M6rPkdZWv+Yg?=
 =?us-ascii?Q?bCRC0ODPj2jQGJnjtCKIjQ8bU4uvNZLEJP6B2PwrE0DuxPupP1lkCj4d+z0j?=
 =?us-ascii?Q?7xfwILAsAxnr3xsi3zU6WJTolzG83uDSIW6qO4jtlLrXftmFFAqaPIDuiSzR?=
 =?us-ascii?Q?pzzh1/9oOdnf/7ECU5TcUL2mlAkQqD5ZSDXav000+eGE5uxM4qzqp2wq509Z?=
 =?us-ascii?Q?gIo8Bdicox4V0UtW9BM/WhtwUKxEIKm+NXFZh59+Z8RRjN01uxiDqGuZnzzj?=
 =?us-ascii?Q?Plv3YisMbxOw2Efsexlk94cGYADLn8KKpk4fzxdvlIHpzznKCoIqXkSuYAQp?=
 =?us-ascii?Q?aLwBMyDIocwUoOiOUgi+wantbNVd9/qw08XdhQe7zgFSGgeRaKhR3stCltBm?=
 =?us-ascii?Q?RLiJhdj/QsfQ6jfo/vUoSSvWT7wa/h5Cn+9xq035Y06LWg68LKrwkLCwo9gC?=
 =?us-ascii?Q?k7ptlseSD/SVgUzegWP7v1Z4itz2ObceVG/wodjWmQfU+prxp5llDhV1AmSC?=
 =?us-ascii?Q?UFIU//m98Srm1nivSy67/BKWyNKXbJjNS9mOvvwp0jx42wGhwnkqemzLw3Sy?=
 =?us-ascii?Q?QMCo3lHMGt44NtwI0I+oRtZcX2/hv5R6ZDmbk0leK1zxE5wRZ3qVkeTo6e52?=
 =?us-ascii?Q?1EcI2/0MkE/3wPtNu3Y0ihS67rxhPNB8QpT7ndns2AASCRWQ1KJivp9Psqjx?=
 =?us-ascii?Q?qZZwdJ5lh8BRWW2i8ORiNR+3wKBq1u29VHZRfKk4ZrbR1NifMsjqSQ7VgXc7?=
 =?us-ascii?Q?R7CvKvL8NQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1466.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f74c2e5-42a3-44f3-ba8c-08da49d33ece
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 04:48:06.6852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 56jpsKs7++EbU8nVN1K33bTVnL0Y3wXFeXddSCFHJUUuYassX7C5UfeEFFTJE1Z/dSeVExU+xoVZ5BTm7kH9kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1473
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is harmless but the warning could be fixed by putting an ifdef around =
it as it has in mainline
	#ifdef CONFIG_CIFS_DFS_UPCALL
	bool nodfs =3D cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_DFS;
	#endif /* CIFS_DFS_UPCALL */
=09

-----Original Message-----
From: kernel test robot <lkp@intel.com>=20
Sent: Wednesday, June 8, 2022 6:14 PM
To: Enzo Matsumiya (SUSE) <ematsumiya@suse.de>
Cc: kbuild-all@lists.01.org; GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>;=
 linux-kernel@vger.kernel.org; Sasha Levin <sashal@kernel.org>; pc <pc@cjr.=
nz>; Steven French <Steven.French@microsoft.com>; Greg Kroah-Hartman <gregk=
h@linuxfoundation.org>
Subject: [EXTERNAL] [ammarfaizi2-block:stable/linux-stable-rc/queue/5.18 29=
/879] fs/cifs/connect.c:3435:14: warning: unused variable 'nodfs'

tree:   https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fgithub.com%2Fammarfaizi2%2Flinux-block&amp;data=3D05%7C01%7CSteven.French%=
40microsoft.com%7Cf194a361b31d41ce3c2408da49a4982e%7C72f988bf86f141af91ab2d=
7cd011db47%7C1%7C0%7C637903268538948079%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4=
wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp=
;sdata=3DOZnPTVUJtqix0vvgtESHsrQ75l%2FmSmVVxyoEeiJXyg0%3D&amp;reserved=3D0 =
stable/linux-stable-rc/queue/5.18
head:   7383156f95c8c7f7bda72abd7fa4d1bc06e2a8cf
commit: 98dd3927170845f16f5120686a0b5c5f181a3b87 [29/879] cifs: don't call =
cifs_dfs_query_info_nonascii_quirk() if nodfs was set
config: i386-randconfig-a001 (https://nam06.safelinks.protection.outlook.co=
m/?url=3Dhttps%3A%2F%2Fdownload.01.org%2F0day-ci%2Farchive%2F20220609%2F202=
206090711.ZJTiUk4L-lkp%40intel.com%2Fconfig&amp;data=3D05%7C01%7CSteven.Fre=
nch%40microsoft.com%7Cf194a361b31d41ce3c2408da49a4982e%7C72f988bf86f141af91=
ab2d7cd011db47%7C1%7C0%7C637903268538948079%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C=
&amp;sdata=3D%2B4snjNrlzx1nZsvHiLuu2o46PXM1iqWjxqkZiML5whk%3D&amp;reserved=
=3D0)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0 reproduce (this is a W=3D1 build)=
:
        # https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%2Fgithub.com%2Fammarfaizi2%2Flinux-block%2Fcommit%2F98dd3927170845f16f5120=
686a0b5c5f181a3b87&amp;data=3D05%7C01%7CSteven.French%40microsoft.com%7Cf19=
4a361b31d41ce3c2408da49a4982e%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C=
637903268538948079%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu=
MzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DSsbQABrP7cEk=
QBU82%2BcC9NZDTs%2BxTrPbKkNRFRUgOLQ%3D&amp;reserved=3D0
        git remote add ammarfaizi2-block https://nam06.safelinks.protection=
.outlook.com/?url=3Dhttps%3A%2F%2Fgithub.com%2Fammarfaizi2%2Flinux-block&am=
p;data=3D05%7C01%7CSteven.French%40microsoft.com%7Cf194a361b31d41ce3c2408da=
49a4982e%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637903268538948079%7C=
Unknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL=
CJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DOZnPTVUJtqix0vvgtESHsrQ75l%2FmSmV=
VxyoEeiJXyg0%3D&amp;reserved=3D0
        git fetch --no-tags ammarfaizi2-block stable/linux-stable-rc/queue/=
5.18
        git checkout 98dd3927170845f16f5120686a0b5c5f181a3b87
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=3D1 O=3Dbuild_dir ARCH=3Di386 SHELL=3D/bin/bash fs/cifs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/cifs/connect.c: In function 'is_path_remote':
>> fs/cifs/connect.c:3435:14: warning: unused variable 'nodfs'=20
>> [-Wunused-variable]
    3435 |         bool nodfs =3D cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_D=
FS;
         |              ^~~~~


vim +/nodfs +3435 fs/cifs/connect.c

  3421=09
  3422	/*
  3423	 * Check if path is remote (e.g. a DFS share). Return -EREMOTE if it=
 is,
  3424	 * otherwise 0.
  3425	 */
  3426	static int is_path_remote(struct mount_ctx *mnt_ctx)
  3427	{
  3428		int rc;
  3429		struct cifs_sb_info *cifs_sb =3D mnt_ctx->cifs_sb;
  3430		struct TCP_Server_Info *server =3D mnt_ctx->server;
  3431		unsigned int xid =3D mnt_ctx->xid;
  3432		struct cifs_tcon *tcon =3D mnt_ctx->tcon;
  3433		struct smb3_fs_context *ctx =3D mnt_ctx->fs_ctx;
  3434		char *full_path;
> 3435		bool nodfs =3D cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_DFS;
  3436=09
  3437		if (!server->ops->is_path_accessible)
  3438			return -EOPNOTSUPP;
  3439=09
  3440		/*
  3441		 * cifs_build_path_to_root works only when we have a valid tcon
  3442		 */
  3443		full_path =3D cifs_build_path_to_root(ctx, cifs_sb, tcon,
  3444						    tcon->Flags & SMB_SHARE_IS_IN_DFS);
  3445		if (full_path =3D=3D NULL)
  3446			return -ENOMEM;
  3447=09
  3448		cifs_dbg(FYI, "%s: full_path: %s\n", __func__, full_path);
  3449=09
  3450		rc =3D server->ops->is_path_accessible(xid, tcon, cifs_sb,
  3451						     full_path);
  3452	#ifdef CONFIG_CIFS_DFS_UPCALL
  3453		if (nodfs) {
  3454			if (rc =3D=3D -EREMOTE)
  3455				rc =3D -EOPNOTSUPP;
  3456			goto out;
  3457		}
  3458=09
  3459		/* path *might* exist with non-ASCII characters in DFS root
  3460		 * try again with full path (only if nodfs is not set) */
  3461		if (rc =3D=3D -ENOENT && is_tcon_dfs(tcon))
  3462			rc =3D cifs_dfs_query_info_nonascii_quirk(xid, tcon, cifs_sb,
  3463								full_path);
  3464	#endif
  3465		if (rc !=3D 0 && rc !=3D -EREMOTE)
  3466			goto out;
  3467=09
  3468		if (rc !=3D -EREMOTE) {
  3469			rc =3D cifs_are_all_path_components_accessible(server, xid, tcon,
  3470				cifs_sb, full_path, tcon->Flags & SMB_SHARE_IS_IN_DFS);
  3471			if (rc !=3D 0) {
  3472				cifs_server_dbg(VFS, "cannot query dirs between root and final pa=
th, enabling CIFS_MOUNT_USE_PREFIX_PATH\n");
  3473				cifs_sb->mnt_cifs_flags |=3D CIFS_MOUNT_USE_PREFIX_PATH;
  3474				rc =3D 0;
  3475			}
  3476		}
  3477=09
  3478	out:
  3479		kfree(full_path);
  3480		return rc;
  3481	}
  3482=09

--
0-DAY CI Kernel Test Service
https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F01.org%=
2Flkp&amp;data=3D05%7C01%7CSteven.French%40microsoft.com%7Cf194a361b31d41ce=
3c2408da49a4982e%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6379032685389=
48079%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6I=
k1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DWQc%2B%2FV2lybHc4YtQ936Z9=
nKU1W6piwYGjW8d%2FJgRc58%3D&amp;reserved=3D0
