Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D934C152C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 15:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241436AbiBWOMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 09:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbiBWOMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 09:12:45 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0F54832D;
        Wed, 23 Feb 2022 06:12:17 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21NCZudl006181;
        Wed, 23 Feb 2022 14:11:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=M0y+TDzCof2UdpQp9tfumBtV52cNxYjR2oo/tLIw6do=;
 b=Fs6ODZt2HPs9XdfxG0pSkPnIbK1hUMG1WQocoZrauQiAXbHGSyg+wqrmoto1K8g3ygcF
 XTKYe8eJazqq06Rc3I6cxzKpPKnJY3sHavUC8B+7iL7Ge5Kq6XZ/KHhOOW3811EpyWU9
 8+6rYwsh/H1jUKnx0olC8uCXYoYoTQZ+pRBtiv2gWRmiHORqkfN9PT6ANKITFdMguzg4
 gH8/hZBb7ptsgNIPvmUXOhSoO6T36ro8n4I6Klrw2L5cvPTVXLWlYlnOdGGHRsh+vfRg
 kIjZIBwZHNjPMioyX+zypmm0yK1yJhgpmH4w1cOuxZQxPwz/yPJsou/YTNqXKVh6aNbe eQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ect7amarh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 14:11:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21NEBg4O022913;
        Wed, 23 Feb 2022 14:11:46 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2040.outbound.protection.outlook.com [104.47.51.40])
        by userp3030.oracle.com with ESMTP id 3eannvusmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 14:11:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSqgI75yhgUlgj4svjIITjg7poyuUusb8ZXaD573zz4TXehPQ93yMaYPobsnfzTbFAqwY0zAZqc+2X/Mqe9BueURwJZAlDgyUAxAmB7ZPIsQL9S1ceYHDIOVOFSB++X+zDl9bbpDsI4gMMzFMtu52zBRmQ3v+p00RJie3h4/3d0DIwKqO1ZQCHfWCJxjYGv3gBOcsZ54B5zk5JLKk6d+Gy40VI2BnLVVz0QT40KFWQ8WRP3Kl8t1OhByDcGdDQT6JSGc8xK4lGvO1dbupBHYs62Aj/64srAj6QLYXus0FUu026saK3P2L/6U2sHRElofMayb7sYPYlxaxTn7Pip2BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0y+TDzCof2UdpQp9tfumBtV52cNxYjR2oo/tLIw6do=;
 b=jIEp052Ows/8nMe0cieCKZ9dl7UtK5Ps5SEwyrH814FD1VdhYH03AWJA0M3FiOgc+YJW2A1JaB8YcPZE8rfmp4g+wEcbekrZ5asR8n4IH+wugVknc1lUePUDqBpbuOosWHVHaQwPJsHGxP7OEomZgM/zV60bmP1J6sPbCH1LwIIeD2e8WapNKI9UNbEZJDVLhWAgZ4T9V9A33lECKkxkkJ+Ey8VgPa64GJzxBbZCF5/JwdZ+8wACNFRUTAux8PwnTtBp/ziHipVh5AXDeQwywgBE/zqVZSieHXm5HTixBag9R3DI848+mIEqDkR9STaHD7HtRnks80jn3Y9Ism/Dwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0y+TDzCof2UdpQp9tfumBtV52cNxYjR2oo/tLIw6do=;
 b=VtimUHea+Vv6olU7ALSjTV3Sw2ZXqGcCUW3vHf1IkPfbwdWGn8sgNZvZ/x8NUiqCj6T09kpxPH7S9VeUXEswlayFsZ3Zmmt+RqP6Og7Cji5tnCCmL7D7o7b0HeKn2C9R8hd7kT5WyZ11VWqud5bwwK1jMAfQSSsmGepIKUkSbXI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB3769.namprd10.prod.outlook.com (2603:10b6:5:1d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.22; Wed, 23 Feb
 2022 14:11:43 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 14:11:43 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     Will Deacon <will@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] arm64: Change elfcore for_each_mte_vma() to use VMA
 iterator
Thread-Topic: [PATCH] arm64: Change elfcore for_each_mte_vma() to use VMA
 iterator
Thread-Index: AQHYJHBq9S9Lf3gga0WdWNWpZs6RLKyeUrcAgAFUnoCAAB/xAIAAEoeAgAAYlQCAARgvgIAAKx2A
Date:   Wed, 23 Feb 2022 14:11:43 +0000
Message-ID: <20220223140851.m6bmaozqb5xfydqt@revolver>
References: <20220218014642.lop2ohx4ov6fekyl@revolver>
 <20220218023650.672072-1-Liam.Howlett@oracle.com> <YhPUuu+6TPMKjhwk@arm.com>
 <20220222142557.6oykxjz3j7fq4mrn@revolver>
 <20220222162016.GA16436@willie-the-truck> <YhUcywqIhmHvX6dG@arm.com>
 <20220222185401.jntcd4g62pamfxvr@revolver> <YhYcc+CGWuO0tUG+@arm.com>
In-Reply-To: <YhYcc+CGWuO0tUG+@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85ad4063-2368-4509-d34d-08d9f6d66b45
x-ms-traffictypediagnostic: DM6PR10MB3769:EE_
x-microsoft-antispam-prvs: <DM6PR10MB37699273433324C1DD4E5A33FD3C9@DM6PR10MB3769.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5D4a6s98y+hNTd5AlDGDiXUpptTQAlwAHZKWDyMEdlxYa+PHjoeF0U7PZkn4pfknhPG1FCVipk+7qxob9u6jVa6DB6lcbMsaO19jwWpVakynPXYSGVGyN94htOzofeS2Q/hvTgUNvWXt1lRFdJlLz6eEypkkSPLNcdkLjqP1gyt1sxlaiCi+qPykTEwFi3yDXjEcDa1MdsAx2k8C/OO1vlUmeMxpiMLMdfSj1r/sL8ue3aH56v3k2rS2D2HEoSDTxW6IgHQZAfrsTANJWelOvBqF49slwF+UilV1cc5W/g1K0/sBFH1OrdCSAyQB/TwdCHJPh8VcnP/c3+oQs8noiiSIadG4HcpXCFyv6lCQ/grXdb7Hm4LGK+N+hicWmdC3HF2Q2I/LjZtAjmOJtYWYxb4IcsGXDm2Tr+dOKSvft+c0gr8i0VX6fYs/pZXDOQlG6ILH0yrDCF71ctVedBVu4jOCOYfIHIsRsly0KQOs7RpNN5hLWYuUQjU5DdwzZRdU9zYT7bZvTOrrWGhvwi7gwquVKkNXdgIMYLYbU+tlocHpRLjhkLLxxJiqnbG56vZ83iP1VTMbKRLB4qIZanQEVUpdN8cPlGvA8XbjdRRCvAvTFLh9e1oERSNUapUIAy2oFVLhde6ORNSuuT7Ypi75N1Gk5QShSWwltxvU1Nj6oi2IgSAtfhkRmsEx/sf7heBLLW8FNuBmA2VkjU9fCagry7kIkir/pcA706jvp/dOwA7W0Hqr+AjdXXYY3trhk0bROoKm1UM01l2yJAZo0ok7LEXVkg8qewDv6tBDtbxKixI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(186003)(26005)(508600001)(45080400002)(66446008)(66946007)(6512007)(9686003)(66556008)(8676002)(6916009)(76116006)(6486002)(33716001)(86362001)(6506007)(54906003)(71200400001)(64756008)(316002)(1076003)(91956017)(122000001)(66476007)(44832011)(38070700005)(83380400001)(4326008)(38100700002)(5660300002)(8936002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Fa0sB9eyw8uvRO/LJ2U36faZfvIgYey3yylvVQab6b6w7PyakdR17So5ZVJX?=
 =?us-ascii?Q?hufrnBtT4lGycbRLiZ0gwRS7W7zBVj8ztpd73DEGwghPjhav5hHZc7cm6OsV?=
 =?us-ascii?Q?CnhT3EuJUUw16SocH8xgZorlzhPNtASs6L+9XqqBdnGWvuwwRQEOvqEArgd3?=
 =?us-ascii?Q?Mf8rXLX5mXH+qTdm7jgHJNz8R62uiBGKiaQ8gm8Nc5V8Hmo2tpPlE5+ps+Dh?=
 =?us-ascii?Q?HHz9VZJTs7+WUPPxQCzCETriV+a10cGduxVlcun6iS+06Mbf32KhY7BB20OW?=
 =?us-ascii?Q?jE8d1PjE+7G0CrLMtxpVPtqr3dglPE7kRgJUqOY/0QIDsCunWvA5cuD1S0Ph?=
 =?us-ascii?Q?8vZEHIFmXgGZfz1GHdy+5hrnWK7XgvVZsIKXOKfsn5Nwb1cKA2tNr7w5cgdY?=
 =?us-ascii?Q?eyHjeIrjse0IX44rIyGhR+V0wx5Ryiiddiv7lVTyJ5hW9u4gOVeXeWbpo04x?=
 =?us-ascii?Q?wgZ5sn90hVPk7up3v8cRMlK+ERfIQJxyFPAKqMYylpcGFCeJLSGIVYyFiVGl?=
 =?us-ascii?Q?wkCDpbBkBhd1//iy6P3d1AjdLEZo4ke2RkDTGu90a20O7NUHkTaC6ILx6Jdt?=
 =?us-ascii?Q?/DZKleqUIQ0TFaqT2i0aOlscxgKJ1gUKducpPW+McZODgzxlYbMTuEJAttKK?=
 =?us-ascii?Q?eKiAPVPDQo2m0kFWDPevu3jmeQqX+Lr4KYQAf6IytmbNTOVQxCxieiSFphmm?=
 =?us-ascii?Q?qsH8ITYbrJBed6xW1zQL2i9Wxs2oHlzcXa5wBgargM6KdE00K1iMVqMGbDk4?=
 =?us-ascii?Q?t25chGE8zdClDGZD2hAS44M5z4YFAAxTp+2hBswrMD91k+qcG904UiCEZlNQ?=
 =?us-ascii?Q?pq/B2COk/31ui8cMsFAlxueolCTMWNPcbYXZ6D01pD7u1aTwewXVGm6FVVnO?=
 =?us-ascii?Q?0fEIk8naJMMG1+wq+SD5r1vdsm4NbJGhPbq+HG69gk8XWSHksCEVmqcZYduQ?=
 =?us-ascii?Q?BMIyJnCyNq7mfOoY94Hc686QswLSWVm7t215p04JcpNBZpa8EGAoALJS/0qN?=
 =?us-ascii?Q?T/EFSRhDkZKRMmjHcTIfFsNAyu3QumVNoiP5GxaluWV39Z4P7BEel/Eyg6Od?=
 =?us-ascii?Q?RBiT9Kh3/eXsuCSh0ST3zNP1rCRv4CTIjZ5RKA9+D5J5yfBD1sLYmBpNN37n?=
 =?us-ascii?Q?ZjuPrb7KuzVfpv/3vbsMZUHPIjgYCzyzDcdB11mDWT1KcQAppbbfQD2opGbY?=
 =?us-ascii?Q?XWiQiDG2EbyWOIfq1GnaHOHX11CXPva5AiYmPpJZC6LUGFzg4SEA7ZxJBcuZ?=
 =?us-ascii?Q?/cX3NcM+oEQTE/A4tyZSzP8ei956rs/1QKtXynjKzuxvoDaFgcpwg7G9UsZD?=
 =?us-ascii?Q?dTEw7IkA7Oor0xmjbhw+f5mSvr2BBwYbENmHFcIitGAf63CN8a9uvBr2BmUo?=
 =?us-ascii?Q?zZKy1otHuGUUnwUdKJsIzLntDSUxuzoJv4uizk6kyXiOcuqBacYzOhjn5olR?=
 =?us-ascii?Q?SOC3UvPQhmcFL44y5xpN6t3U5/bPggsYyUmkH3wx9p99ncM1821okBFSIrF1?=
 =?us-ascii?Q?FVTt+YXJmgA06S2vc+ZvVYWu2jnCbGZL9/HJK3ifPYnsn/rjoCIH0hmRspEl?=
 =?us-ascii?Q?nVQ+uV+PtiQP5NljfL6hlPXMftK44n8XPKbdL9JQPN1oxzsTUOPhBIDzPy3q?=
 =?us-ascii?Q?VYnfBx1Rw5hdAE99RedVNO8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3ACE214160221141AA3F0E8D848F6443@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ad4063-2368-4509-d34d-08d9f6d66b45
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 14:11:43.1714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FlqezG5UdYdFgbC64790CKcgTPHiLtN8jHu4HrOU7FO77Hpgzfet+zrYhpa2pCw1oPWCSZv1nF6+BxP79F5QZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3769
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10266 signatures=677939
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=596 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202230082
X-Proofpoint-GUID: 1FwjH9Z9Iu6tUtInudqOiS0BmFc1qmK1
X-Proofpoint-ORIG-GUID: 1FwjH9Z9Iu6tUtInudqOiS0BmFc1qmK1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Catalin Marinas <catalin.marinas@arm.com> [220223 06:37]:
> On Tue, Feb 22, 2022 at 06:54:38PM +0000, Liam Howlett wrote:
> > Once the maple tree is upstream, then you can take the patch I posted.
>=20
> BTW, on the maple tree branch alone
> (https://github.com/oracle/linux-uek.git maple/mainline), I get the
> warning below and no core file generated. It's not MTE related as it
> doesn't have my patches.
>=20
> [   67.887638] WARNING: CPU: 1 PID: 528 at fs/coredump.c:1116 dump_vma_sn=
apshot+0x98/0x18c
> [   67.888594] Modules linked in: crct10dif_ce sm3_ce sm3_generic sha3_ce=
 sha3_generic sha512_ce sha512_arm64 drm fuse ip_tables x_tables ipv6
> [   67.890017] CPU: 1 PID: 528 Comm: mte-coredump Not tainted 5.17.0-rc4-=
00071-gc8cf067d6a99 #1
> [   67.890494] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06=
/2015
> [   67.891054] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [   67.891469] pc : dump_vma_snapshot+0x98/0x18c
> [   67.891787] lr : dump_vma_snapshot+0x74/0x18c
> [   67.892071] sp : ffff80000839b8f0
> [   67.892278] x29: ffff80000839b8f0 x28: ffffd4a81d76255c x27: 000000000=
0000000
> [   67.892894] x26: ffffd4a81da308e0 x25: 0000000000000000 x24: ffff80000=
839bc78
> [   67.893436] x23: ffff00000557cf00 x22: ffff00000557cf60 x21: ffff80000=
839b9e0
> [   67.893922] x20: ffff80000839b9e8 x19: ffff80000839b9dc x18: 000000000=
0000000
> [   67.894497] x17: 0000000000000000 x16: 0000ffff9e8effff x15: 000000000=
0000000
> [   67.895061] x14: 0000000000000000 x13: ffff0000025f9000 x12: ffff00000=
1a2eb94
> [   67.895590] x11: ffff80000839b100 x10: ffff80000839b108 x9 : 000000000=
0000000
> [   67.896057] x8 : ffff80000839bb68 x7 : 0000000000000000 x6 : 000000000=
0896101
> [   67.896537] x5 : ffff0000016bf000 x4 : ffff80000839b8b0 x3 : 000000000=
0000001
> [   67.896961] x2 : 0000000000000000 x1 : 0000000000000001 x0 : 000000000=
0000011
> [   67.897493] Call trace:
> [   67.897679]  dump_vma_snapshot+0x98/0x18c
> [   67.898034]  elf_core_dump+0x50/0xcf0
> [   67.898274]  do_coredump+0xbdc/0xfc4
> [   67.898553]  get_signal+0x524/0x7f0
> [   67.898775]  do_notify_resume+0x224/0x1330
> [   67.899046]  el0_da+0x50/0x60
> [   67.899431]  el0t_64_sync_handler+0xec/0x130
> [   67.899726]  el0t_64_sync+0x1a0/0x1a4
>=20

Thank you.  I will look into this immediately.  Was this with default
config for arm64?  Was it with a vm or real hardware?


Cheers,
Liam=
