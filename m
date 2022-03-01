Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C726B4C9721
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 21:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238023AbiCAUkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 15:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238125AbiCAUkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:40:43 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB0650B1C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 12:40:01 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 221IsEMa030556;
        Tue, 1 Mar 2022 20:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fms38Fl1lqVsLX8fHyMDOobMcZQPEhKFWWxin+fPYWQ=;
 b=Ki/5jfxhZieAxcWXEHov8TvqweF9U1G1AzW+x6fY42byzL+dGx1VxryVfdzpMTxCuGGQ
 VwcNinXz6y4NnhLAg+hyuFJrblIUP66wqnSFsJOUJFpP1bvlHZkr7MVXhLnM2z0vIlHc
 d+uTxydJf+4CHMYXnHUJ4SEK1KVQjRTzIBaoA4R9Bhv94khZ427ljrhUj2ZTWxkrRF0t
 FOcc1Kv85z6nWOnWfwxtWaJklvC9jzm7qZAY37X+Pgv/LIZN+HLG8hAC0nmmft/n+LUQ
 /6ZLfR6c6yqYDIGN8VbZLGGDw3zZnLPIkE0a5QbCizCy1ZmhFtTzS/c9SgvN+ybdE3+V MQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh1k43y65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 20:39:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 221KZL5T044431;
        Tue, 1 Mar 2022 20:39:47 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by userp3020.oracle.com with ESMTP id 3efdnnhv6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 20:39:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3oNqoGg4gtY/wnOCzATM7DxHIly59+jyeI+TNc55EIciSEEhr+vIdpNTctoWef419dhyL+qrWoQuBAZsxCY7ToxKE9yeh2kxhcBMa8XeAHkD1g/ibFJsRyzx5bzLfR4ygkE7va7dCF96nPMHctWHAMtuVj8+h5W7Q8FiT8fTkfodI2858buWf6e8X5X7OPWJU6jukq+/6IaZ7IMo2g32iKY0SC943cmdJ0sCU3qAN3o7A3ELS0Yu4AEf5AZ3WbY6k3VbmNMPs2OzYHv2UDKaFUvBzh4080qJX94rA+XkWwQfB5zeDYyHFp/YkLYiEu3F8YTmvAFGSZiSg9EBqNZTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fms38Fl1lqVsLX8fHyMDOobMcZQPEhKFWWxin+fPYWQ=;
 b=fU9QBnWZkkxtYe5UQF1Ah/CP6qLUY9N4MqIWziy7XrzG14VjzAYpfC84PRJJKYjQ1B/AXa38tPGCuEZ2lhJw0g2OfsgkxheelXseezh5RGigWXYZrJ6HT65Ws97WVeGFhQq8yV5UpQjBGoRmtbXw6jmXgECPGSNAMVtUmwCktW9TgiQlxhwPZ4H9/a1921LByNEXhUAw0LZgNqyvq+JlC/O3/ycVXPxprkfO4YgXEzABE97+ERDHYlPwTuHhlkKRE77y5/lCiazNg5JuTUAALTLAgZx1gh0Pn1i9ibjxttRd0J9vp9tyJe1Iv7JsGdIrxr2o2UE89kk9xdeSOG0xzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fms38Fl1lqVsLX8fHyMDOobMcZQPEhKFWWxin+fPYWQ=;
 b=h+IYbJL3qDhjXMFpytbQEuEpwYJKbjaB+56CCMoAsCEwn2cIrUoLunENGjiAWRjIPUvKpqObr0S4WP944U0MpilZNbNGKdIDFMKtgVTJ7O0OpkAc3OKJgyqPd01O8fkM4iDh1s35ay6syAk4igRihWNPo1pY5YkGuwk1et0t1Ac=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN0PR10MB5383.namprd10.prod.outlook.com (2603:10b6:408:124::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Tue, 1 Mar
 2022 20:39:44 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a%3]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 20:39:44 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Vasily Gorbik <gor@linux.ibm.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v6 08/71] Maple Tree: Add new data structure
Thread-Topic: [PATCH v6 08/71] Maple Tree: Add new data structure
Thread-Index: AQHYInpU/hKtaWQ3X0yDuzeh55NMz6ymqQwAgAJzKICAAL9NAIABOHaA
Date:   Tue, 1 Mar 2022 20:39:44 +0000
Message-ID: <20220301203935.r74qjc7p6qbno4xw@revolver>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-8-Liam.Howlett@oracle.com>
 <your-ad-here.call-01645924312-ext-0398@work.hours>
 <20220228143633.r4zoemgtmrq4uzvb@revolver>
 <your-ad-here.call-01646100074-ext-8278@work.hours>
In-Reply-To: <your-ad-here.call-01646100074-ext-8278@work.hours>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dddfafc9-a046-48c4-c3d1-08d9fbc39e64
x-ms-traffictypediagnostic: BN0PR10MB5383:EE_
x-microsoft-antispam-prvs: <BN0PR10MB538382AED6ACC589F5BE09F4FD029@BN0PR10MB5383.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SOwWA1ycClUS0X4Qmm7bf+vLBjhcxik7SeEBOSu3yHpNtS3/1gyLp6k243ChnNXfzxO7D3XCURQU9WX40qV2wmvbiGqMF4b/WqKoG7Kwhz6j9WnQM0a9UDmCtk6NQ5mpJjRQkCyFkA0IZOCDsl4PCT3qk+CYn0RFbLlnRzpSOeeH+/zAAdEiB07/EskGFn77FyoVQS/5ZMnZ9gqLBPmrVks9xF7y1U4/1nDXYA0cBMVjcChYuzPHN2X+1fE76gfd+dib/nA+WAL/AT7GLEKtuhRh+0J4Vg6HAmsMfnEvpbDNnpvDRfVhFqxwOZb1H5u/gsyKB6emViCWIahVjI+Ze2hsi2v7omS+MvVSRyMHk7tN69j8FztDluz6ovCaTXVdJX9ke3tY788NjXwYoqX7stsjgqxjFUpLtMKwmDXXeqNkPEcMU0TIOs6eiwzSdrvZmrGXN49sX0Bt5kBTuuE75NZBFRqfaiv3qBPHZ4dBwte2VtX0PLMzIzlgndwkz6GHTvtneHHHvU5/u48TVfijIUa2Bk5N3w413KoX5kSuzfOL7BAz9Mx+lNXbQUuvowZN0qJ9GKrxIkyqOPiaEBpu8IXSLwFbhv1O6WiJ14fcOZgGZT+Vyp+P84NS70oc5f+zkN96gCOIiEYkI2tO3i7XUItZvfXZ2Yyks60sEUdWEUV976I+HvoJd5LU+oVMeb0fNt8+/aHlCjLFCLo1nj9EC1ILTg3CAHWq8nFifnx45O2SpvyQx8RdsMw2ObgnOe/lRKH3FcOE3B0JKcID2TXzl2Xc/YGJ8QgsSEGzle5rFqkxSNYyosPMBnk8L5q5lnoFqvsSaxRGZVN0NnehkABIdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(9686003)(38070700005)(6512007)(2906002)(8936002)(66946007)(76116006)(8676002)(66476007)(66446008)(64756008)(91956017)(5660300002)(1076003)(44832011)(4326008)(26005)(186003)(86362001)(38100700002)(6506007)(316002)(122000001)(66556008)(6486002)(966005)(71200400001)(508600001)(83380400001)(54906003)(6916009)(33716001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7voi3Qm6PLU6M4IE47g3zV3+v4uDkYJBnMbUyKBMhO8TXE9Yj5e/DUN2e5Cw?=
 =?us-ascii?Q?6hF327kMvcX5vE2n4eumwNic5h+QEamhj6psH3aakivOgJmiiJXZZ2JG/PTM?=
 =?us-ascii?Q?MyvFqHQS3dp8cSweW6pcJXDxOmKJ0t9XlhX55m2CA9B/RlzRIrAWectK2DWN?=
 =?us-ascii?Q?Xlt/EdkfU/uqwzui8wqu362Ix+eqPXivtvt6ejF/e82AapXbW13sb83vOKwu?=
 =?us-ascii?Q?KvGr53QaDJNl5Ytk1ZlZ2NJzY6Q8h5rVRDcxbPoVSt57LDwG8FQGu8egsFMx?=
 =?us-ascii?Q?HyOYGOO7BNOZfJlrKYizcwNnWkvqwjSSUNRy2nVSOsy3ocvFcTTC1Rizsm2G?=
 =?us-ascii?Q?MCBa+6wVIQdrU3wLW2qteFU0gtLTkBhhCXD5aZBX1cwG6TEOpoqgbD6kQYdB?=
 =?us-ascii?Q?3+cIAoZdIMalql5RL5IMEqBQto541g7ABql94KqvF6BG/Gb8W6N2JNWl5yJo?=
 =?us-ascii?Q?lpJrMpXWNxaq/ccUR15ELU+k2PbcwMQhfKIlAU3/sHTSNWAyC9DoIYEtpG9A?=
 =?us-ascii?Q?ZW8OieeR0lO1N01Wd8WLcKqSa/dc0awSRNaOLe9uU8/nDP2QwQnM8xCcKQIo?=
 =?us-ascii?Q?LsK9wl2iOUrImwaCb2gKrZ0hha1ZCxY7Ddu8jAVt7Y4g3hkyFFBi1zYJjTiA?=
 =?us-ascii?Q?KbxJ/HYWmyy2Dhkr3OUK8X/HjKK+2Px46bFBBCBPDshlZ7sK5+ylhvaGw497?=
 =?us-ascii?Q?spy0yBCUxakwQz6oBoThKWxMFCLEhE6HnwGIqSe4FDcrkKsuodGt3b1KdbQn?=
 =?us-ascii?Q?ggoGtvvD8+usU57m/nJ0O28/ZQv0EYoeuJh5xabDlJ2ZwXy+a6dFTfRqahnW?=
 =?us-ascii?Q?W9HPVU5BK1e5xCqW5bMO0Ml/SWBynSIqeCyvqfN9k0A9JwRqypUUwirpAUoR?=
 =?us-ascii?Q?AW67+7AcNOsqjhh7Yj016Y57kS/L53T5krs1kaYLAubU5qNGKrMEAtQRmPuy?=
 =?us-ascii?Q?2B43mJoiqdtmMtVxGeNH7tmawR3lI00zkoNH2syh4hN1pDwXitKSIbmqqQKn?=
 =?us-ascii?Q?xslv1wyyPMXZAq/QD97kDb4xB1p+uUDn+pSfbdTHMULTYVql2rByQJ82YIlm?=
 =?us-ascii?Q?WH3du46bxJ7tgkpbviBWazeO3YVeU7GoiJgj8hCDUherZHLPJHxWdO7ZLz2W?=
 =?us-ascii?Q?Jwr4CqHRLHiclxGh/UAX28uZxcBBLlt7X6thSyztAqplPu+pyIrph4zZOW0e?=
 =?us-ascii?Q?YyJbSKBoRtyuWu6ECR7bKEotExMZIS0huDcLkgzwYXB1L2OZ/v8tUaUyWvnZ?=
 =?us-ascii?Q?M2ReITUUmUdeEUhqnQK2vD1O4VmOstru9cVJ+pr8d+GjBLnsorvkhxmBosrF?=
 =?us-ascii?Q?K363PQG/D9CwtdZkNLYnA/u4nvpmbdB9pCS5DpuXIphkvUuNTFHOXCPTcA8n?=
 =?us-ascii?Q?43Y+5/OxxqqqnM4D5nlu/SuLTt5cJ4H/+yjebwftiKMsjKyAtfm07xiMOeru?=
 =?us-ascii?Q?spa7ACjVFg73s8DvH8R9wm68dhH8IPuBRaIEQWv6WTdOPLKQFK3Pge+Eygva?=
 =?us-ascii?Q?sF5TbzmfCDAJujxMd4WvI3MGoBzRTbtOqUDylAMWACoeUYvA8aevLLzEm2Ow?=
 =?us-ascii?Q?QKYHV8HNP9cf4VaUnTMLZiFvsUT59HD7CkKYEPFiu0cZWtY5OOsG2jx9+cyI?=
 =?us-ascii?Q?wvHhLV9ezykjEThWNNjACK0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F99AD19F1EECF34CA569471EA2478256@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dddfafc9-a046-48c4-c3d1-08d9fbc39e64
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 20:39:44.3765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f6fII4Gqq4mXQ7S3qsOt7eBDwU9GDWEKeP8u41eVzLlvhvWRIC1h3LxGBWTSsFh3iJkWedGnw9iYCUTV0uek9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5383
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10273 signatures=685966
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203010103
X-Proofpoint-ORIG-GUID: LK1KI3zMpq93pqbpLg8dlZF_kuA3UWBY
X-Proofpoint-GUID: LK1KI3zMpq93pqbpLg8dlZF_kuA3UWBY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vasily Gorbik <gor@linux.ibm.com> [220228 21:01]:
> On Mon, Feb 28, 2022 at 02:36:40PM +0000, Liam Howlett wrote:
> > * Vasily Gorbik <gor@linux.ibm.com> [220226 20:12]:
> > > there is an endianness issue with maple_metadata. This is broken on
> > > all big endian architectures. Tests are crashing. See potential fixup
> > > below. Feel free to apply it or fix the issue in your own way. This d=
oes
> > > not resolve all the issues with the patch series though.
> >=20
> > The endianness isn't what's causing the issues.  The slots hold a
> > pointer.  Either we can use the entire slot or none of the slot
> > space.  You are just moving the metatdata around in the last slot.
>=20
> Fair, it is either or, but shouldn't maple_metadata->end be aligned with
> MAPLE_NODE_MASK?

The MAPLE_NODE_MASK is used for the node information stored in the
unused bits by the alignment of the pointer, the metadata is a
repurposed unused (or at least supposed to be) space in the node itself.
It would be nice to keep them separate as they are technically stored in
a different location.  It just so happens these overlapped in LE arch
and thus worked in avoiding the detection of metadata as a node.  The
metadata for leaves was added late in the development cycle and was
avoided in verification due to this unfortunate alignment.

In normal operations the pivot can be checked to ensure we can use the
metadata.  If we cannot use the metadata, then we already know the
answer for the end; the node is full.

>=20
> > You may have been confused about my comment, which I believe is
> > outdated, that talks about maple_arange_64, not maple_range_64.  I adde=
d
> > maple_range_64 metadata and use the previous pivot to see if the slot
> > contains data or not. If piv[14] =3D=3D 0 or mas->max means we can use =
the
> > slot for metadata.
>=20
> This condition is not present in mas_dead_leaves() where we potentially
> iterate over all 16 slots, simply checking that we have a "valid" node po=
inter
> with:
>=20
> entry & ~MAPLE_NODE_MASK !=3D 0
>=20
> This doesn't work on big endian without the fix.


You are correct, thanks.  Since pivots are repurposed in this scenario,
we cannot be sure that the pivot before the last slot is the maximum.
This is true even though only the first pivot is reused since
the maple state max is implied from the parent.  The bug you found
requires an almost full node to trigger, but obviously needs to be
fixed.  I assume the parisc port works as it is even less likely to see
an almost-full node since the nodes are 32bit and thus have a much
larger number of slots.

I have a fix that works by checking the node and node type.  Both must
be non-zero.  In the case of just metadata, the node type would not be
set for BE.  In LE arch, the node type and metadata overlap but the node
would be zero.

I have fixed this and another issue that Hugh pointed out [1].  I have
been working on an s390 VM since you reported your issue and have been
getting strange behaviour and have been able to detect the bug reported
by Hugh with the config KASAN option.  With the fix I described above
and fixing the do_mas_align_munmap() splitting order I broken in my
linked list removal, I am now able to boot my s390 VM and log in with
KASAN, VM debug, maple tree debug, rbtree debug, debug page flags, and
Poison pages after freeing all set in the config I use.  I've pushed the
fix to a tag on my branch [2] and I'd appreciate it if you could test it
on your side.

Thanks,
Liam

[1] https://lore.kernel.org/all/5f8f4f-ad63-eb-fd73-d48748af8a76@google.com=
/
[2] https://github.com/oracle/linux-uek/tree/howlett/maple/20220131

>=20
> maple_tree(0x121eaa0) flags 8, height 2 root 0x61a00004c316
> 0-18446744073709551615: node 0x61a00004c300 depth 0 type 2 parent 0x121ea=
a1 contents: 0x61a00002710c 14 0x61a00002a10c 29 0x61a00002d10c 44 0x61a000=
03070c
> 59 0x61a00003370c 74 0x61a00003670c 89 0x61a00003970c 104 0x61a00003c70c =
119 0x61a00003f70c 134 0x61a00004270c 149 0x61a00004570c 164 0x61a00004870c
> 179 0x61a00004b70c 194 0x61a00004cf0c 203 0x61a00004c90c 1844674407370955=
1615 0xe00000000000000
> 										^^^^^^^^^^^^^^^
>=20
> =3D=3D564249=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0xe000=
00000000000 (pc 0x00000100ce72 bp 0x61a00004c300 sp 0x03fffe87de00 T0)
> =3D=3D564249=3D=3DThe signal is caused by a UNKNOWN memory access.
>     #0 0x100ce72 in mte_set_node_dead ../../../lib/maple_tree.c:294
>     #1 0x100ce72 in mas_dead_leaves ../../../lib/maple_tree.c:5381
>     #2 0x100ce72 in mt_destroy_walk ../../../lib/maple_tree.c:5496
>     #3 0x1069af3 in mte_destroy_walk ../../../lib/maple_tree.c:5543
>     #4 0x1069af3 in __mt_destroy ../../../lib/maple_tree.c:6279
>     #5 0x1069b77 in mtree_destroy ../../../lib/maple_tree.c:6294
>     #6 0x106cf19 in check_dfs_preorder ../../../lib/test_maple_tree.c:357=
32
>     #7 0x106d011 in maple_tree_seed ../../../lib/test_maple_tree.c:37188
>     #8 0x1073ef9 in maple_tree_tests /devel/src/kernel/tools/testing/radi=
x-tree/maple.c:47
>     #9 0x1073f1f in main /devel/src/kernel/tools/testing/radix-tree/maple=
.c:54
>     #10 0x3ffa1833731 in __libc_start_call_main (/lib64/libc.so.6+0x33731=
)
>     #11 0x3ffa183380d in __libc_start_main@@GLIBC_2.34 (/lib64/libc.so.6+=
0x3380d)
>     #12 0x1001d99  (/devel/src/kernel/tools/testing/radix-tree/maple+0x10=
01d99)
> =
