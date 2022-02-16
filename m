Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980364B9025
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 19:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237617AbiBPS0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 13:26:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbiBPS0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 13:26:02 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C451F5CA3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 10:25:49 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21GHiLuO005266;
        Wed, 16 Feb 2022 18:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=urrvaJYou53s1KW9kRGp7yzn2RLc091LubFa6QatOrQ=;
 b=x1ZEkOEDA6KaAa/m22uVqkganHqyrKGMeKvpYmxLjgf7X0p7bOkEGEPgxg6gyaPRjHRG
 zvOELq3hSiWdFDgmooSn4s4HZXB49n10eccE7atyfI/g2kCEota/2Ws3xPQ1N0DMDNa2
 H58HTkAHaXno5Xly56p0omD4KguGbFIXQW5VB9KW7oTwiYJJBuGEAUcx5AFk3wxYGqH+
 HxohISdErmAVOx9sAyd7Ia+DJtGnme+ohRq41lq3HJF2P+JFK3s+2YirrvPVSY1kFkg7
 atsWO8RBp/Z4JfW/E7fONZ5UYPwsSwPCxU2Ib7YgNlIynzQ6E40NistDzQQe0fxpkJzn TA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8ncau1wa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Feb 2022 18:25:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21GIGAan063725;
        Wed, 16 Feb 2022 18:25:39 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by aserp3020.oracle.com with ESMTP id 3e8nvswf7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Feb 2022 18:25:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHUEVIgDyUJ9AMTr1YEp8qZ8lUclH/ifrN8shDVrNrUY+PseN2jDh5oq+kExV2NMnFnJSGoKXwK3fPm0aIMYWNz+S6Tgzc7VMgMb9nYrrhEbEf2F2gIQD0tF29urLcRvN4Oqj6xxzv6W7scFSPYIAI6yLqWCqzw4pzrgwzwz6PuQ0s/6EWKxAlIdfBxWIBmzmFEe/1HsExJxhX7CVlFDw2wqbgfm8NcXb3hDxHBdv0MSh7Aw6EBNw7O/tQjZxzuorD5bnlSbP9RkGeQyNBsvxofnQZ2f1mYMb4Rjz7i68TCDMq3noMnFDXmq4yA7975KKzs0TrOvUXhDBBFrm3Vhxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urrvaJYou53s1KW9kRGp7yzn2RLc091LubFa6QatOrQ=;
 b=ag4+c8nQYOycf9NrW3bDgPpi9DxWhB99Hfngg1vdsZZj7j08vMy1iVMwYpJzuIHH6e1ed6D1GPaayo8wr9T9g1rK7+XsZHf4vyJhhUHug2IPhCzHlv9XiAapf3+uZs92kQV+plkQlwcfDx9JZ+kyj9iM/v+YU7FdTF42T8McnmUsdgaPYdGiFRS2QEWgPNCQ/bqWtMVDgiVRK3C9eY9iDTKK40QdHXoW4LjhLrHuBHWkhyn34ps5g2giQBGP7uojbJz1WnTDHXRY+3tTxEUR2RDIosKiWQr3sE9JsLq5z9Ds8z5MfUqRvKsHcNllhUB6053UkX4k9vz4YkT9gTEDfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urrvaJYou53s1KW9kRGp7yzn2RLc091LubFa6QatOrQ=;
 b=ONmeHP61mbBSkSNhUfg4yMAHvZ7OQOg43TdI6rWaO4khupyYCX2eFG1kSv30Zt/ssaw0hHI+g9TUNc8xOy2A+VUd2eTRpLTSDetRB0CDu3RO5UVjJA127ewo7zRHSA4ulhAz82rmmor2cfCXuQov2uZXSt/57PCfOVQc9n5LiqY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4410.namprd10.prod.outlook.com (2603:10b6:806:fb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 16 Feb
 2022 18:25:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Wed, 16 Feb 2022
 18:25:38 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Mark Hemment <markhemm@googlemail.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v6 08/71] Maple Tree: Add new data structure
Thread-Topic: [PATCH v6 08/71] Maple Tree: Add new data structure
Thread-Index: AQHYInpU/hKtaWQ3X0yDuzeh55NMz6yV9kkAgACJ8AA=
Date:   Wed, 16 Feb 2022 18:25:38 +0000
Message-ID: <20220216182520.asorgmesrr34lesm@revolver>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-8-Liam.Howlett@oracle.com>
 <CANe_+Uh9orFkNzohmbx_jziipU9_p_ckSPEGzygPt2VknV_99Q@mail.gmail.com>
In-Reply-To: <CANe_+Uh9orFkNzohmbx_jziipU9_p_ckSPEGzygPt2VknV_99Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 046f82e5-9bb9-4b7b-e4bd-08d9f179bb2c
x-ms-traffictypediagnostic: SA2PR10MB4410:EE_
x-microsoft-antispam-prvs: <SA2PR10MB441042F1B685C72740FED35DFD359@SA2PR10MB4410.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:313;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gaj5BJv6VL7bU6TQKiR6h9WE6ckxcw4ZSHodL4mX7gRKIy/WPrZozYXm2ZOykE6M+J7sYMiM8K+i6av4/mXUTgLB+GEMgnB5N08OU90eiIVpDfiEfXs7UiX9AmGGCxaOIgBR+86N/tQkuO6VbEhO08VHcu7g5jD/VA3/92c45E6L+k/iPUZQEqGHEcKiChrkOZu78D7A0tf8/I/0pFoMlUPaQz7OvTQ6jTp6jd/lKwNNPvBUNW8fdZlh0qefmSOM4GfoDlRk1TzKiV4lkdE1Iy1cVL/Iqjo0h8s3obT6V0fyjjqAL2Yg3PA0Vk6tap9IrqyK4UfaKdeY47MWK4jSZkqdeNT3wkjLT4cQqwrjGvrEV3cot+tFMsJEPvSw2lYC7mRAJJxwjdRm2rctSzeXTBRaTkEIGn9fbs004yxEewn4eEjVPXZSd80QBoPMMi+eyYEyoVC8YqXJniQZRJmVB/8OS9GeEzIXi9FaXWVLcYK3kEAHcVxskDWYJC0YyWteIS9Jj7fln2cwvQ6SE7twHxLZvmc3VN/vKFilMDoI1g48s/mvFtvHhnXtbHS+xLIMK0jSpf9YbIVd5dfZH12StiUQE5y/ueJ7DZpVToID69HDhlvSmWSOAda5J23Aw4CMEyutbTbVUSdUBglXyyKGxUBzuHD/6opbeF3H6gtsnChpQzPk66xF9mVpiFT0+PvGsQ7MiT/CuLgJ+k8qPiTCIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(122000001)(1076003)(5660300002)(186003)(6916009)(38100700002)(9686003)(71200400001)(316002)(26005)(38070700005)(6512007)(8936002)(44832011)(2906002)(6506007)(76116006)(91956017)(83380400001)(54906003)(66476007)(4326008)(64756008)(66946007)(66556008)(33716001)(66446008)(6486002)(8676002)(508600001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r2tv8kkYV07znwLZLzqso6hlL2siYU4QZDTrrUHNo5mj9dExeIRPSnpL0WAS?=
 =?us-ascii?Q?YlbiMRdAq5bukFjAnSKVRHnZ+5IvQyq+OzzER4vJo04r0gvYOiV81Dty5c9t?=
 =?us-ascii?Q?LArmsF49nkUZI2rE8peR5gHT0LoDCXrHaFXMUgyjylCWaoaxrZ1UuOf4W35Z?=
 =?us-ascii?Q?nn3tN+sbVIkR8ZO2bEd6kZgp5e/JwFtHpPshG+UCEz6Af8lDklNazknDH+48?=
 =?us-ascii?Q?5GPyXyPQY3UXMF59zJt4ilyY/rM7FiQjy9fbXnZkWlmlAIjYhSb1jlEXf7cq?=
 =?us-ascii?Q?B6f0tCi8/usRmGub/cu9sca+u4ReIf5ieX0YV8wK188s0hkkuoy3y+dxwmMQ?=
 =?us-ascii?Q?B1Cjtb7yBFaO2AOkKRAXvB5VV3Ep/DN6iK57LGXubJtt41oBs/oPvuTSy39v?=
 =?us-ascii?Q?WTxTGIroXxUFdZ53vkrpbld6j35iaHlJ7vlA6wutkRRjH80L6vwJaFl6zDjS?=
 =?us-ascii?Q?eWcTIDjSAgOb0Emn5u7Zk0qm8e0BX0C5BxrecwyEAK4NcZSkt9ydyd4MB1iP?=
 =?us-ascii?Q?nPoCHzsCaamVQORRY9acfhPyZiS8X9Vjwcun1XtXxwQ0jVUJLXw1OfQ2YcTn?=
 =?us-ascii?Q?zHhBJyZyRCODAwzBgX0vs+SQF+gP/YPiCJ6R++RKTpJ+Q5Wu4xLck40ggdb6?=
 =?us-ascii?Q?Ec9RgnTt/VUI/aFlovsYApta2ODmTvI1ZZ6r+PWGkJEQIoxKUGCJPGmauXQV?=
 =?us-ascii?Q?Tick5x9PZnhMzi45cpf4gsMvZMCZpSfoRyrr3L55AmUjC5utSXTRokLjVoWB?=
 =?us-ascii?Q?+XfutaerXbLGVXdGXIkEX3jrnRjBvUFyC7JaYXW7mBGNWAU1Mbp0yCyOIFcD?=
 =?us-ascii?Q?RljF0Aces+pVbXGfg6wpNLEejAdEufz4w4bZMaREpYEK7R63wRL1j0e/XHbR?=
 =?us-ascii?Q?33vwriuHF9E1XXXatPzYb4lm1f1nvYG1GbaE1conCHpBlsSz53I9jjtB7N0Z?=
 =?us-ascii?Q?W42aHgfT2pnkAz0cJER8UAGGUiFHI1hYqbPPj8LnZxrDEvQLhNKnO1aXEi6p?=
 =?us-ascii?Q?6QVY4nW2TmCu9BZSoanD1dB6dF4JTsxt7L4UuAFx/B+U/7iu8cCqYFWJ8xgJ?=
 =?us-ascii?Q?CRV5kK7cJn8rk+O0ryGFuhoIY9srFfwTDSa0g5EhH3WO312AELBt35AlNRV9?=
 =?us-ascii?Q?CzC3ewvI0INrSJJpELBZQcjj+VcvmD7xZ7hvvwI+FB9OVc5RbHnG8M6/guRJ?=
 =?us-ascii?Q?ARkVrvpYY+LhRZlal9gC9tYSXOdzGoZhOqOn8b8hCpx7NuTJybVp+k9Mq1Py?=
 =?us-ascii?Q?TsIc2zdRxWREwluFrhY/q7Vvo8HsIkMP93N53HZr+9Z+rX5/eI9drEGVpkW3?=
 =?us-ascii?Q?HPTHTCRkdaHjooKVMrJp9thcKPXxjDu3BaX4xNMm3Nwt+nrI7efEBM5Uymqt?=
 =?us-ascii?Q?sjMWtBEUCuFTivqomzFpWDXTj1UHpKywGSQO5ExHfYyOuFmGBrTZOnyawrC+?=
 =?us-ascii?Q?qH15cKJaeZ4G/iDild53I33ob2srJNhWtOnBU13Zrlnby9S7jJeS4eEx1Le1?=
 =?us-ascii?Q?aMRpjeeOFS6EuvkKd5P0pZ/R0jK14FXCB9LGqC8cSslhg4Vvvmfk1Z+AWNmh?=
 =?us-ascii?Q?ZTfAqO0NYLuhUUL9zku1pi868r/UuCjs3tjx2DlszthvHhnAEjfw07hWMCyP?=
 =?us-ascii?Q?kmsSmX5azKntghit8qG6B80=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0C132A1B1854E24DA39209CF28B50AB6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 046f82e5-9bb9-4b7b-e4bd-08d9f179bb2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 18:25:38.2629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0zcQ592vuqLZyh4w4CBQexnIWKqQ5ZpAthv52bxv8OVCdAMvF9QfGfbbBNVedaHk166zbf9MknAzDAa/fqcD5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4410
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10260 signatures=675971
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202160102
X-Proofpoint-ORIG-GUID: YUumfUOR36Vh1nenOBPD2iivorjgzn8W
X-Proofpoint-GUID: YUumfUOR36Vh1nenOBPD2iivorjgzn8W
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mark Hemment <markhemm@googlemail.com> [220216 05:12]:
> Only a few v minor comments.
>=20
> On Tue, 15 Feb 2022 at 14:43, Liam Howlett <liam.howlett@oracle.com> wrot=
e:
> >
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >
> > The maple tree is an RCU-safe range based B-tree designed to use modern
> > processor cache efficiently.  There are a number of places in the kerne=
l
> > that a non-overlapping range-based tree would be beneficial, especially
> > one with a simple interface.  The first user that is covered in this
> > patch set is the vm_area_struct, where three data structures are
> > replaced by the maple tree: the augmented rbtree, the vma cache, and th=
e
> > linked list of VMAs in the mm_struct.  The long term goal is to reduce
> > or remove the mmap_sem contention.
> >
> > The tree has a branching factor of 10 for non-leaf nodes and 16 for lea=
f
> > nodes.  With the increased branching factor, it is significantly shorte=
r than
> > the rbtree so it has fewer cache misses.  The removal of the linked lis=
t
> > between subsequent entries also reduces the cache misses and the need t=
o pull
> > in the previous and next VMA during many tree alterations.
> >
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > Tested-by: David Howells <dhowells@redhat.com>
> > ---
> >  Documentation/core-api/index.rst              |    1 +
> >  Documentation/core-api/maple_tree.rst         |  218 +
> >  MAINTAINERS                                   |   12 +
> >  include/linux/maple_tree.h                    |  683 ++
> >  include/trace/events/maple_tree.h             |  123 +
> >  init/main.c                                   |    2 +
> >  lib/Kconfig.debug                             |   16 +
> >  lib/Makefile                                  |    3 +-
> >  lib/maple_tree.c                              | 6967 +++++++++++++++++
> >  tools/testing/radix-tree/.gitignore           |    2 +
> >  tools/testing/radix-tree/Makefile             |   13 +-
> >  tools/testing/radix-tree/generated/autoconf.h |    1 +
> >  tools/testing/radix-tree/linux/maple_tree.h   |    7 +
> >  tools/testing/radix-tree/maple.c              |   59 +
> >  .../radix-tree/trace/events/maple_tree.h      |    3 +
> >  15 files changed, 8107 insertions(+), 3 deletions(-)
> >  create mode 100644 Documentation/core-api/maple_tree.rst
> >  create mode 100644 include/linux/maple_tree.h
> >  create mode 100644 include/trace/events/maple_tree.h
> >  create mode 100644 lib/maple_tree.c
> >  create mode 100644 tools/testing/radix-tree/linux/maple_tree.h
> >  create mode 100644 tools/testing/radix-tree/maple.c
> >  create mode 100644 tools/testing/radix-tree/trace/events/maple_tree.h
>=20
> ...
> > +++ b/include/linux/maple_tree.h
> ...
> > +/*
> > + * The Maple Tree squeezes various bits in at various points which are=
n't
> > + * necessarily obvious.  Usually, this is done by observing that point=
ers are
> > + * N-byte aligned and thus the bottom log_2(N) bits are available for =
use.  We
> > + * don't use the high bits of pointers to store additional information=
 because
> > + * we don't know what bits are unused on any given architecture.
> > + *
> > + * Nodes are 256 bytes in size and are also aligned to 256 bytes, givi=
ng us 8
> > + * low bits for our own purposes.  Nodes are currently of 4 types:
>=20
> Is it worth adding the compile-time check;
>     static_assert(sizeof(struct maple_tree) =3D=3D 256);
> ?

sizeof(struct maple_node), but yes.  That sounds reasonable.

> ...
>=20
> > +struct ma_wr_state {
> > +       struct ma_state *mas;
> > +       struct maple_node *node;
> > +       enum maple_type type;
> > +       unsigned long r_min;
> > +       unsigned long r_max;
> > +       unsigned char offset_end;
> > +       unsigned char node_end;
> > +       unsigned long *pivots;
> > +       unsigned long end_piv;
> > +       void __rcu **slots;
> > +       void *entry;
> > +       void *content;
> > +};
>=20
> Minor: Moving the member 'type' to below 'r_max', means it will remove
> the need for padding (reducing size from 88 to 80 byes).  Does this
> matter?  I doubt it.  Better/worse for h/w cache?  Suspect no
> difference.

It wouldn't hurt.  I'll make this change.

> ...
>=20
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > @@ -827,6 +834,7 @@ config DEBUG_VM_RB
> >
> >           If unsure, say N.
> >
> > +
> >  config DEBUG_VM_PGFLAGS
> >         bool "Debug page-flags operations"
> >         depends on DEBUG_VM
>=20
> Stray blank line.
> ...

Thanks

>=20
> > +++ b/lib/maple_tree.c
>=20
> > + * Note types:
> > + *  0x??1 =3D Root
> > + *  0x?00 =3D 16 bit nodes
> > + *  0x010 =3D 32 bit nodes
> > + *  0x110 =3D 64 bit nodes
> > + *
> > + * Slot size and alignment
> > + *  0x??1 : Root
> > + *  0x?00 : 16 bit values, type in 0-1, slot in 2-6
> > + *  0x010 : 32 bit values, type in 0-2, slot in 3-6
> > + *  0x110 : 64 bit values, type in 0-2, slit in 3-6
> > + */
>=20
> s/slit/slot/

Thanks

>=20
> > +
> > +#define MAPLE_PARENT_ROOT              0x01
> ...
>=20
> > +/*
> > + * ma_meta_gap() - Get the largest gap location of a node from the met=
adat
>=20
> s/metadat/metadata/

Thanks

> ...
>=20
> > +/*
> > + * mast_rebalace_prev() - Rebalance against the previous node
>=20
> s/mast_rebalace_prev/mast_rebalance_prev/

Thanks.

>=20
>=20
> > + * @mast: The maple subtree state
> > + * @old_l: The encoded maple node to the left (previous node)
> > + */
> > +static inline void mast_rebalance_prev(struct maple_subtree_state *mas=
t,
> > +                                      struct maple_enode *old_l)
> ...
>=20
> > +static inline void *mas_state_walk(struct ma_state *mas)
> > +{
> > +       void *entry;
> > +
> > +       entry =3D mas_start(mas);
> > +       if (mas_is_none(mas))
> > +               return NULL;
> > +
> > +       if (mas_is_ptr(mas))
> > +               return entry;
> > +
> > +       return mtree_range_walk(mas);
> > +}
>=20
> A blank line after this mas_state_walk() function would help the formatti=
ng.

Thanks

>=20
> > +/*
> > + * mtree_lookup_walk() - Internal quick lookup that does not keep mapl=
e state up
> > + * to date.
> > + *
> > + * @mas: The maple state.
> > + *
> > + * Note: Leaves mas in undesirable state.
> > + * Return: The entry for @mas->index or %NULL on dead node.
> > + */
> > +static inline void *mtree_lookup_walk(struct ma_state *mas)
> ...
>=20
> > +/**
> > + * mt_prev() - get the previous value in the maple tree
> > + * @mt: The maple tree
> > + * @index: The start index
> > + * @min: The minumum index to check
>=20
> s/minumum/minimum/

Thanks

> ...
>=20
> > +/**
> > + * mas_nomem() - Check if there was an error allocating and do the all=
ocation
> > + * if necessary If there are allocations, then free them.
> > + * @mas: The maple state
> > + * @gfp: The GFP_FALGS to use for allocations
>=20
> s/GFP_FALGS/GFP_FLAGS/

Thanks

> ...
>=20
> > +/**
> > + * mtree_insert_range() - Insert an entry at a give range if there is =
no value.
> > + * @mt: The maple tree
> > + * @first: The start of the range
> > + * @last: The end of the range
> > + * @entry: The entry to store
> > + * @gfp: The FGP_FLAGS to use for allocations.
>=20
> s/FGP_FLAGS/GFP_FLAGS/

One day I will type this correctly the first time.  Not today it seems.

> ...=
