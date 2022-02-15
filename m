Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1494B7317
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239205AbiBOPJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:09:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbiBOPJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:09:23 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4090E20F41;
        Tue, 15 Feb 2022 07:09:13 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEhk4m005618;
        Tue, 15 Feb 2022 15:09:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3k1dseykt8I30hF1XmfY1pqcwKenNsAAyOpCwv6oRhw=;
 b=kfSgyg/fZZ5vOE+ltQkWXwRmdeotmP6ccBDLLjp4WpDqLlduzwa1LRF16vYUlYu2IL5T
 F8BbdbxR3gemAm+ubsNuLJ3sT8as/EGp3hE/92mJk+D33JaQmOf48QgQhtQpsdK/vcNT
 t+tGf0gNQoo5mRY5bcKSQL7arNqm/911KhoJJJXofukbZhOFKuaeQvEjW1sdaGXUdEse
 nVOgGDKRyKT85YCEKfVaa30JKs2Rvxu0DRjo5HyFI/YbBGXKc9+IFghgaYg2K8egHYza
 0gXcQI5rp933r5dzWvmSqkR5VpgaIXanZJyxVvFNGDZnP59DCxXi+RQFGcKM94xd54lY nw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e88hgh6t1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 15:09:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FF0U56008594;
        Tue, 15 Feb 2022 15:08:56 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2047.outbound.protection.outlook.com [104.47.74.47])
        by aserp3030.oracle.com with ESMTP id 3e62xerp7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 15:08:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQSbCtaCEc8bEsQhiZe60zTYCJjipSGBcBlVTbfPqqxbfl1u3sDNUZCCkN/vCKYn/4RZDa9D5lXbzD+YNJY08I6CUI9Y9atLdf+ENAzDKblzyeQeHVk/BPTVLMrqprfiORFLs/WKvp47MTal1CqQRYxRU9pE6t6OMGlwVZaRlbMoc1Jm6fThAFSXN0C+zy/hGWUAW7NYeR5thv78WWo63CiK2vrvwYxU4rt8bVj9kBNopUwkpdNgdT2dJ7uKEMt46ixstHpupz6mwtvWTjnp1kW9x+Me3FcB07xsCpLsi71V1iEtfEOh7k0IpMh36J5a5DlH/dkpIcYwdGMrAmrb4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3k1dseykt8I30hF1XmfY1pqcwKenNsAAyOpCwv6oRhw=;
 b=TOEGTmuIbve+HjsejNoVqM9jEJ8ixiBWZCiq0Pju24DKp/FbGoX90iVGgZ7+PH4o10gI+9QrMI3GD9YAOJ7vAe7dM4KwszAkK8M65s0AtP6GmHHq8RsA96lrqfAt2bZjAvnrvPlxvy9HoFxBfjI65TKkytYxFBRP/ttLvmFpc3jS6yzWdWj0YeHu3OxBklpslOSQtOc+427gyaCOWsLEeb2RQX/n6VgMTJbsdvpWiJYvvfChfqhXueRwR9vXb0/Li/BPbI9T+sfHcCgr6Z/Uf9uZI8ed8Y7ySeJrILmnmc5Zxfc3E/lWzvbnpyMg9lxET1RZfw1dnAHs4K91Yx6U4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3k1dseykt8I30hF1XmfY1pqcwKenNsAAyOpCwv6oRhw=;
 b=jyr8+oh8E9sZpHrP4txotOyrCSq7qT1kFUVpCQ0Dx5WAO1C35pblpsaAp1WoG6ebhpGqo6wE2M8SaRaTvI+6EawfAPw3vmDqAGo96hawx26ajGMZ5d6LGPDPYadWKb0v01/BQ3dnHmc3B0rIYzwXQXYaz3gtIBCT6TNvmR5s+Fg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4570.namprd10.prod.outlook.com (2603:10b6:806:11e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 15:08:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5902:87da:2118:13dc]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5902:87da:2118:13dc%6]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 15:08:53 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the nfsd tree
Thread-Topic: linux-next: build warning after merge of the nfsd tree
Thread-Index: AQHYIk5QsmfMZg8T50+9F2EnCdpaW6yUt0UA
Date:   Tue, 15 Feb 2022 15:08:53 +0000
Message-ID: <A28A6DA2-5124-4C07-8112-0C5E8FF0C679@oracle.com>
References: <20220215202739.39a276f4@canb.auug.org.au>
In-Reply-To: <20220215202739.39a276f4@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a7d8ea5-042e-4e8d-e430-08d9f095148e
x-ms-traffictypediagnostic: SA2PR10MB4570:EE_
x-microsoft-antispam-prvs: <SA2PR10MB45707D71EEFBACB823F5DF4393349@SA2PR10MB4570.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:283;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fE7MEzI1OlQkRMzb6UQi8iNp65joFWK8vU8L/sMSnB76w4ZOnJhTJVeSPFhOs0+4TTCpdHT0d0uRlVbv2AefqSGGr8AHz4w1sYW66/hBXBwv33Z5E7T7vYlihgH2vpKc1dtLtNjMwdotGeKnvCn1PlgqgFmUkPIaOy6H2AjxTMYIF94I8widtiTag1WzmwI6XZZjec0rP9ovp12X+ihR4kcwC/0sxXb0A/U2DeA6co/dBZGViKcIWcynF4HKVUTL2ZJJl761L2b4KTVcTiHmaMeNy95ObVruTWFEABaqojLiII4L7Ogj9F3oY1mPaTEHxK5yPuVJDicZ3DI45VNXBZQWj1qBMCzngpZZkBqr0ULL0jnLfQk5sWcOVFsuByFI8jpZ7P7lK7cTR2Cd44L0SzinW4i6nqre0arTUI2M/SPFcIFD/nBz9Lx64K1U7IGefdXihpUHBcjc8rGq0h2T8Jli746U1nYnf1hd7Sb+tUJy6NWsf0goTQg1zsF0twYigbfxgR+EKbQF/llm3JWf4jYuNX4nczrWl0YF4cwna6rhjjTazJVFQxOKVEGQQOzTxuvsZrNWEk3mB3LIBh4P6Nrj7WOyrDJztQupygAbNsKOlniD0H7Rl81FhwKxLgnzwLEYNCeODw6H8PsMQOrX2S+NXd8ZilvKhSJiwNhcJwgjbzlE61XvTUsVTamXOyto0Y7T6IumMBFayMAHK//gM8tTeZINinyXYf3iXM4SRPo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(2906002)(6486002)(33656002)(83380400001)(38100700002)(6916009)(54906003)(91956017)(66946007)(64756008)(66446008)(66556008)(76116006)(5660300002)(66476007)(508600001)(71200400001)(8676002)(38070700005)(4326008)(2616005)(122000001)(6506007)(86362001)(36756003)(186003)(4744005)(26005)(53546011)(8936002)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yTy4w0fnMePso8X8x/1DhBW64f3AKptOkLZHFEkgCsTztTIltH3QJPqilobH?=
 =?us-ascii?Q?EqYlD/RetRT7Xb/Lgboi7zJwFh4CpCF1s7zLS/I6Vfpr70zEVTBs5YwaeUph?=
 =?us-ascii?Q?56KdyxEZWUJlLJ4Q0rgug3h/CeZMlaVQgasUGGRXPpkUI2FV7JKU974Z6482?=
 =?us-ascii?Q?ul/+GUuioeGo827vuLgmgEiqNUHDCB8rcTbuJJJBct9Ob0uVtvgZ2qVvF3/j?=
 =?us-ascii?Q?vYR30RRFzpSTgv4nt0aZerhDxCpUfwxD5UxcKWr2227ah8wzHRNW39M/qWwF?=
 =?us-ascii?Q?lhDJcT1qCsUMaTNFC1arIe/qsU4MpE33Z0C/JEtDnbLtT1mPoWkj2lwYHDgR?=
 =?us-ascii?Q?4FfPjhiPAEDnFCAYPgihIipP9OI3h+pd1TRt2dNFLAHd1U7XYM0hzTLUfocj?=
 =?us-ascii?Q?Er9CTmP83lPUfL4sLgVuQYLmUmLlMiw0L7x/4iGDZzzReHJZ3QlWpCiMb3iv?=
 =?us-ascii?Q?sUZ5U/PkSay+Wr/gbq2ipIyQ4LkobKEyW84v+fWQl8Q6T88jmpA8+4XVzWzD?=
 =?us-ascii?Q?7YCJi5d4TvqsKSKMNSQP3BNVDnCcW5M4Wi/6lpp51VnuLpEclEEalixQzAFR?=
 =?us-ascii?Q?HYJgb5EN9nDBgqq+v43h1yGuVXpjSGa1TzMb46NiHIcQld3oeYV32zhy+pRN?=
 =?us-ascii?Q?NZwcVR65g4BXaH4LmsgQQkTk2tz0YndTqIXVnH8y+ekHJAtA1G6xaWsN+Skx?=
 =?us-ascii?Q?4vQ1jau6oJwgmJohIOmN7xNyYbvr2dYGcB5QN8P7d6JSNcygtPTwiV79RRhK?=
 =?us-ascii?Q?zVLjYe9Sg+7gh5hwGCLPExoKiXj80I1fMGjEjO0bkj0OTOTuI83sg0VoV3ry?=
 =?us-ascii?Q?703E3CB5AdZgSgo1GliXfEPI4GNjWyQm7kmekMuaj66h2/gOOO3wxue8apoP?=
 =?us-ascii?Q?vC2zFWXyLrAqujotPxIyIfjmZvYVpsnTc9zo0K6LDz8fDQbEV2L4NM6bqBLn?=
 =?us-ascii?Q?9ZMA94boBjQgJlO66EtY//uy8+j6bmj/mQP2uxfsiOyZJpQ3deC25Eqm5rKv?=
 =?us-ascii?Q?SuOTWzwOqkZ7Ihdqt7YDrgLFoy4U5qA71c8xSqIvYB89f92hWCDESypnjRsH?=
 =?us-ascii?Q?aTbI9bXgV+Ppbvw1UvQs4iJozGCHPcOKrEwKPpCKadK9ZuGW7Swxa9zB+/8E?=
 =?us-ascii?Q?Sf3cE6C11oqTeN5wsS6QNspEFsHb4droO0SoAN0Z23DcsCh/DLGfw4bsFOTX?=
 =?us-ascii?Q?cWO4XzE32YXDNUjKD+rvVazU72yCoki9H/BAf1LmIj/8gI11x6Cso+NNp1T/?=
 =?us-ascii?Q?ABy3rvIjrJRWGoz+ODToJSl8s5u+45NlVhIRoVK9ZysvhMOeArf8Qxb7Y72C?=
 =?us-ascii?Q?hjTqoiIou0S3Zx+n4icMdxjwGUkQ40Xws22aH0LaAlJoAFxGgKgJ7aY1kwCS?=
 =?us-ascii?Q?LbvQPB4rBSRheeNFDMBmRbJvM3XC0G5bKRnOLwkgAz8H1YM+j2Q+1L5/8ugz?=
 =?us-ascii?Q?miPeZee8wCLnvfiDcnkdhBDB6xDwHW2QM1mswhAYEgQLy7xwhU3OPmMBzT+G?=
 =?us-ascii?Q?bylKwzErgYYmTemnJkaJJFZjQcu3n8ji9xX/8ZEdwh3x7jrX+dPieq5eRB3W?=
 =?us-ascii?Q?o9+XDoY4Z6crW6T3+BKKANY/wG/LuivGf7VgLKPgvGVnY8LAiJvxx2WLTtjy?=
 =?us-ascii?Q?2bfZ0pEIlM5+WTEUIvkhE8E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8723465F5F9A884995A8F01CC480CC57@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7d8ea5-042e-4e8d-e430-08d9f095148e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 15:08:53.3619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QiRWJ07ZYGD1RhN5ZkeKIB8CJQd/dBN+WxGULCid0W9a367xalPvBgPAM5P2PlmJQeVEEYtF/HOG3NsU5A8NlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4570
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150088
X-Proofpoint-GUID: GKnsKmCE1vOhnWRIQd8dfGhJjolm9lXb
X-Proofpoint-ORIG-GUID: GKnsKmCE1vOhnWRIQd8dfGhJjolm9lXb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 15, 2022, at 4:27 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrot=
e:
>=20
> Hi all,
>=20
> After merging the nfsd tree, today's linux-next build (htmldocs) produced
> this warning:
>=20
> Documentation/networking/kapi:62: net/sunrpc/svc_xprt.c:331: WARNING: Unk=
nown target name: "sock".
>=20
> Introduced by commit
>=20
>  26978084103a ("SUNRPC: Rename svc_create_xprt()")

Thank you, Stephen. I'll fix that up.


--
Chuck Lever



