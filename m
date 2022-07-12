Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA6F571FCE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbiGLPo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbiGLPoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:44:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D857AC08D3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:44:23 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CEtPT9014894;
        Tue, 12 Jul 2022 15:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fiVc9UGrULTzWmkuzUQ3vX6hdG5KlSlyRFtfS+fEoUI=;
 b=hQWSKzF8i8VvEVhCx15N6c3z69I05sjljdS5CtMkX2Q+SjACj9bvBHcqwpSFRr2uMz0e
 Orbt7Vq2KHqnot9Es7piWsJllWTZJKx0x/1MabpBd3PDcisvIL3A06GqtLUbZufQE2it
 FlyiVfbnLfxwaIqRoOTi4RLvxg1kk20PRUCoxQrNC1QZ0b7tkBVLbtQ/dQpoRf+d9LHe
 1nZPGhvdCr7IlYP4bs9wzkMUMq8lQSfWfnfsbKasMCmMX1AUhLpN5R39KL7+p/VSQBMI
 y47cQKkcmbcHyB7MFwzu2A3xHA+kipqEH7edsOCCM2nT2/IOWIzCdd4TCrxgD4NCpDlQ Fg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71rfy9c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 15:44:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26CFaA4E005101;
        Tue, 12 Jul 2022 15:44:12 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7043vgwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 15:44:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWqqEAbof4p3lVQO3cVeKU495s/HN85POoofbAIRNbdFn4EVETxHxWdr3SeBGf/lDWnCpQKGl8Fg4PBwzCA3ckvADrACfCeiTvMX003vhY+N6IQj+VrBU06ck1H+6WbUFinusra3ROrzsR88JRTYIRsPj2OxPsFd6uo0LC3NjUby1VlOzCU8vp0VgJ7tJlGcPQj3kYs/AgMAU/kijZnEmnDEKtQMfEaLevzkCoiuJ8+CeYkSuuUkfJ6D2tIVVxz6zKM42YlIXLAehe9/QqGQZHaVC2idTBGKBotdV7O78vrAfoza//mbghEzmKLvw7JIT3RQ6DeaxWi9LVcXk9THhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiVc9UGrULTzWmkuzUQ3vX6hdG5KlSlyRFtfS+fEoUI=;
 b=EqFvfhZ6XyBalq8euc+2uBYMbDPP2bicNFawpbFzL5QL3SMJzqI8N5XhuMtDwitl59ABuOIUyqnby5R4mqwsJdPMSiiZY/bxVyP5EEea2H00f1oYhka17d9pOAiHUzcgULozZF254GbelPX8vylqI1slY4ZXmdyRFiiJSVziVHCmK/fYCbktXGbZQgUB5AJYOsaXLJH9wnspMNz67O9Vq65hKt3dvuXihRpMdH6ovyWUz5UtVcm8va6ja6nljhPxTaj9fht3TfKiuKzPl+6wjagwJKWqZZZVKyAR4aKPtSB9hVxS2E2x43oY/yIpKhI0iuXio7GI1waKebyljZdMtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiVc9UGrULTzWmkuzUQ3vX6hdG5KlSlyRFtfS+fEoUI=;
 b=GHLq99vcoRVSQiirFj2XveYbI9RG3CK8OjHbqZm1bOOF1s9Jgd8m2on+Aq+Ml4sxLDMMunKzCKxjlpjKBrV56L0oyruXilyrsGlyW9iCBFEOIb+I439RvCCs0Hk3S9Wtl85Y2X6rNniPCAsCKOzq2sECkStDON1dSHZ+AfY73kQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4369.namprd10.prod.outlook.com (2603:10b6:a03:204::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Tue, 12 Jul
 2022 15:44:09 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 15:44:09 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] maple_tree: Fix sparse reported issues
Thread-Topic: [PATCH] maple_tree: Fix sparse reported issues
Thread-Index: AQHYlfsoLhkzbf9CQkS2b2OLBBRjJa160n2AgAAN9oA=
Date:   Tue, 12 Jul 2022 15:44:09 +0000
Message-ID: <20220712154401.hh5ibuw7d3qlrd4r@revolver>
References: <20220712142441.4184969-1-Liam.Howlett@oracle.com>
 <Ys2LCwQZUuOwiiX6@casper.infradead.org>
In-Reply-To: <Ys2LCwQZUuOwiiX6@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2786892-7aac-4d7c-0958-08da641d5cbd
x-ms-traffictypediagnostic: BY5PR10MB4369:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +ywJNZKkOPpWdMXjBEmgmGzvg/8OR2YGMOVcGqUydUL7EWFWAxkCbblyVp3LavuvR4rLhf034wdoQsumyTY3E82vPNd7lU1208UHbkx5IEw7he7onCydwgovX1AqLLUHxtN66AdSOUtFMh2G6IwKhVfS53Dmyh0msPRg3yEMOZ9DW7f9zgOPvgqg2gQZLpvp+pRuZiRE6qL9x2L30HxNVcKSJN2Z4J7O2tuRUN/LA4u22l3D0kKKDA7mbJx+JXldWw+1bdzMlLPVZi7Npr1clF3EBe380qzhJpRrkLtmYfCCzh66ufplh0oJ8zWpnwD3aUkPtVm2yCNRkGLSiFis2adwsEQgG37Kgrv7DaZWbWTjYLTSh+TvBazaV+A0UdGPi070CNQnNvQnZgllmWlLnjZXAy6TdqJ8SWag2WKgehhxRR7jUCw2H/R8EBGIUfR9LfE1sJvFcdIOIbJl+0HtyGzjM/lF09f2TrhzlO2oRAhsTtXUBaXPZoPK7Axx0r7ybBgHjTjpzVVgIy0SjTRw5w/UBGWksgEj1dEZBb+9rhBRwmTZbSRkwPUxLghvvG08UGcExBaNUxjoI/0+OXflUX0cwiqqu6nsX2htcCNsYQflUEf7OEW4Cq82dpmc2nYhlB/RrXqBKSCWorC+k4ZACfDWMIatcIq2pvaM5GFXnIcjIJ2RSVfhh9Vn1qSgABA+EhnVEuNNU57DQUsm8qCToNdV7DrYEdC4pdMqZLm1HqAUhEMbQ2AwO7Exh6OVKqd/uzK9WaRvo1fDdqbLVERyJ856xYpqyt0kp0htEZaICvxrM+y147aYGr9Jy3z5d/rnjVmVsuevQ7/appP8tLQYvkHiHNHOSFVkq9kh1JSiNDM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(396003)(346002)(376002)(39860400002)(26005)(6512007)(6506007)(9686003)(186003)(91956017)(66946007)(66476007)(66556008)(1076003)(38100700002)(122000001)(86362001)(38070700005)(54906003)(41300700001)(6486002)(64756008)(6916009)(478600001)(2906002)(966005)(4326008)(44832011)(83380400001)(76116006)(5660300002)(66446008)(8936002)(316002)(8676002)(33716001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XYGCe1ol3FEzg7xzw2+NErJdTusN5Ji+QtsIFbMGhS1YFtzeCg9IKnefkT1o?=
 =?us-ascii?Q?M0leRBH9qXWws2p8eG7KTgI/BNjGeRHNJgLyhG7OK/e5JfdkVuX33mtRd/Y3?=
 =?us-ascii?Q?etwS7T+n/q2dfy66RFaYZqnFQarR/pSmdnnO2naMwMJtsY+JsrmIyQg1KFPN?=
 =?us-ascii?Q?guHDqbgVfZhkTvdrpw2tMRUcys+v2eGMX3KJtHFRTTQxqhrBgj1GAisJNhdu?=
 =?us-ascii?Q?S1kVeUh6JJcxQQd1nrs8eDQz3u4rPxDCnV4h0ugNcNRKWbZor9hBWlBljWsA?=
 =?us-ascii?Q?ab/dP5CsVBkl2ruraK1arQCo4LpyXZCsXZCw8Uyw1Qjt3J3T3HXUxzj5eT6g?=
 =?us-ascii?Q?avsW88nuJEGL5WLRLk4UScNIf4NckcvL3qvurTK5onWrBKFs4q5viEFjVzP5?=
 =?us-ascii?Q?6OEDzEUSF6Z5duXJxgCVj2YIXlyTMpW2ronizZ0e6CkBrQnH+BPMoY1WS4fc?=
 =?us-ascii?Q?fO4AEJ9LHRgX0J8GM1VrALhUPxJpOgwa48DrKEEBj7JCzR4NLZVOdBawemhj?=
 =?us-ascii?Q?qwyt4JBe4+MagtdM85odChJyWHvJWswhSsBVU37cR6ZkQ8vWjc5O+8H1/RSv?=
 =?us-ascii?Q?bDS42qdmixrFpGNSxzyWN/mkZXhc+hCOGTGkpICgr+gzdQX4fICf9VKz+Qg5?=
 =?us-ascii?Q?u3YDBYsiVcOPBL14CyMqWflo9kMnayXB86VDzlqafBfhyfmd+wXV4cqrvDyq?=
 =?us-ascii?Q?EF6FqNH9bn/jKK6NwvTHeYqNzkQh5ErhNJ+yQ1PAPhIoqOSBnqjcUf6e7kX5?=
 =?us-ascii?Q?huPWnIe8pQhWaJ+t+KxPRnPLUspKqXb/Rky5TEHwjuObpeEG/2xWxUooChap?=
 =?us-ascii?Q?gq732Gz5Y9tftwSNMNiMM2ZipPm7cyygg1TUBtpGuang4zmhBJxOPkHABNjV?=
 =?us-ascii?Q?bjDjAtInSKe/fjmoGrNVX6vBdcd1KMsdhRSBsZuTg4lEyfx7QE/yQeh4/KSC?=
 =?us-ascii?Q?jgdDzbozMjlnUd3YD4D3zcjA38FSomz+Llrkw2fBwR+R4wPvJkkyaSrgzhB/?=
 =?us-ascii?Q?eZfbWGrk7gRQraTQ8Hx2g1RRwQWnZL3s3n1TwNHdGOL3gcl/uCwQDBmU3f1Y?=
 =?us-ascii?Q?cuwiugrLdFWsgYLmYSV5Oh26DW2e8FMz1/33OoXS7EBfBwwYvSlCUCO8amRN?=
 =?us-ascii?Q?QP9f0sfzFDh7a+qOdoOHSzO92UFUeNAzqsf1ksAFV28dZ0WQbJOymMWKLCJc?=
 =?us-ascii?Q?+tXMmwssJm+ous/KB3uRGkdYQLzMMROl0PWIvZHJUcqPSwBi/t9VnZKfakkd?=
 =?us-ascii?Q?RJJKkidNX+a9QPnWQykcT5awVk/BGEOnrha4S2dMirZOd526PnSwcv4FZVKh?=
 =?us-ascii?Q?js4KnjsJ3hZWeXle7Gge6/GYD5SKM/mJ/hyAXygQA0iLmyfWUX0gNrUMtnr1?=
 =?us-ascii?Q?x5gNmBIvf93EMfNYbQIQYOIbx2ve8PK00tNuR5FKVGlgmSi4eQ4LRoYAFALT?=
 =?us-ascii?Q?gayQOYb19Lvxg8btFOlE5vcsIDNnVe5kJ+Xjplwrrwp+a56zNh9RcAwAPS99?=
 =?us-ascii?Q?68wp2m9gRHUAC/x6D0actMvD9u/+aYfKmAQmgSvkrPl8TC5ZsiwswGIKpQQz?=
 =?us-ascii?Q?GdTo/IXvQ3K6sMMRmupTfggZzVU48eFY0oytypkY1+uWjQMqn7WTbF4rL9kj?=
 =?us-ascii?Q?9A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8EAC4325DEEE0F4AB257DD3A5B835693@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2786892-7aac-4d7c-0958-08da641d5cbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 15:44:09.8912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6AdMBYS2BlH94LCAhAVSBjwobowzIVFfe4VBxiSylt2RFMIotqtV7mShBMHO6ULL/cmpDwWq5YUWHkrQ6ogtQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4369
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_10:2022-07-12,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120061
X-Proofpoint-GUID: 12EVrAwsyCUOmBIzaDfoaqtSfNKQajs6
X-Proofpoint-ORIG-GUID: 12EVrAwsyCUOmBIzaDfoaqtSfNKQajs6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Matthew Wilcox <willy@infradead.org> [220712 10:54]:
> On Tue, Jul 12, 2022 at 02:24:55PM +0000, Liam Howlett wrote:
> > When building with C=3D1, the maple tree had some rcu type mismatch &
> > locking mismatches in the destroy functions.  There were cosmetic only
> > since this happens after the nodes are removed from the tree.
>=20
> ... in the current use-case.  It's a legitimate use of the API to do:
>=20
> 	ma_init();
> 	ma_store();
> 	ma_destroy();
> 	ma_store();
>=20
> Can you add a new test that does that?

I can add this, but a few notes on it.

The function names are mt_init(), mtree_store(), and mtree_destroy().
There is an internal/advanced __mt_destroy().  Both destroy functions
clear the flags - which I think is desirable.

>=20
> > @@ -5524,13 +5526,17 @@ static void mt_destroy_walk(struct maple_enode =
*enode, unsigned char ma_flags,
> > =20
> >  		type =3D mte_node_type(mas.node);
> >  		slots =3D ma_slots(mte_to_node(mas.node), type);
> > -		if ((offset < mt_slots[type]) && mte_node_type(slots[offset]) &&
> > -		    mte_to_node(slots[offset])) {
> > -			struct maple_enode *parent =3D mas.node;
> > +		if (offset >=3D mt_slots[type])
> > +			goto next;
> > =20
> > -			mas.node =3D mas_slot_locked(&mas, slots, offset);
> > +		tmp =3D mas_slot_locked(&mas, slots, offset);
> > +		if (mte_node_type(tmp) && mte_to_node(tmp)) {
> > +
>=20
> Unnecessary blank line?

ack, I'll remove that.


>=20
> > +			parent =3D mas.node;
> > +			mas.node =3D tmp;
> >  			slots =3D mas_destroy_descend(&mas, parent, offset);
> >  		}
> > +next:
> >  		node =3D mas_mn(&mas);
> >  	} while (start !=3D mas.node);
> > =20
> > --=20
> > 2.35.1
> >=20
>=20
> --=20
> maple-tree mailing list
> maple-tree@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/maple-tree=
