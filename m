Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66414760BD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 19:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343795AbhLOS2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 13:28:54 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:65150 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231138AbhLOS2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 13:28:52 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BFIGSQd018864;
        Wed, 15 Dec 2021 18:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=MccUUsseTiFGyzF7/ymVHSdaNK/7BlNDt+1PcQFe9zs=;
 b=IOMAfws7SyQTStlSrQlYkZlV4RecxYQZ7S1O9IotVx+o3seephgJSTVpYJF+aUa8zREA
 XvSsTwKxra8dkmSTBgL3LL2hB/RgMRlcwglg8FaI3Lwzq3YYvDp4gxt8f0B7+pRJrBc2
 UT1V+P8g3Kq9XuwCfcpoO63twHeQhH2LWeAvGiwKz34saOyAqqUqgC24UrVJm9IXo91G
 rR74oWwZL7kq49vQXUXPiwr4JvM1Ksme58FJbHA+QX/1yylj8ctvGcXvFAf0jY1U3wfi
 zE8bag54GZhPW81F0fr/aAkhiydwLIIaFE+bucEvu6r7JE0zMC7FK1yJGPaN42Kx7Uuk WQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cyknrgeby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 18:28:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BFIGXeC022382;
        Wed, 15 Dec 2021 18:28:29 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by userp3030.oracle.com with ESMTP id 3cvh40k068-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 18:28:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gs6eIWrbT9UgUyjoD2tA13X8uUYQPlNULa3bsvmD6mDugGvsGCZSChTLXfFqy2VrWmucTJezOxL4qeaLU8ZFoPkvKYBFnuzJHBsloZpc3LkdUDfCxEDKgqsB2cOqMunjCFkoGWFW12nDBcDG3Hcau1ZzSmWXUGKTSzJkV/+wK1LZWFhjV+ac+eCaMLvf4aZXfsvxWqkKBQefUQC22A98ClVOcADHZzhaqIlMrj3CL2xkk/ZjBUEuTOBeGJsIu9Gm5oQhShrxme1zilfWNgGJe95hpna9Dy9z1fFjXDuxovUjnbhdAKO2nDGXvkT7G6ae5pqxSiuQQXqTmXwHrGX6Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MccUUsseTiFGyzF7/ymVHSdaNK/7BlNDt+1PcQFe9zs=;
 b=gA3zOODSfc1hyuvkHDOpN8trA7z15mFxwNXuNPDIDwfJbdoiwTII07KkcPMszpKK0DiFc8olx21aW9dssl9vUlNTq44MyXeospwU1teQ2hM0/fdKgnqjisTyRnziIfl3QYENcbN7hFGNP9RJAGjk3+eSFUHPv/w2B9jiSoz/YtsO4spITGR6QrbRd0YbOkRDcLZVr/JB5R1Q4Y2v18o8CJROHQNYLYT01CVps2Kq42Zw5Gc1Z2dbiaPa4PtOiNuYXDNUMbqmmV5PuFqaen3zb/cCdIQiBP3KGUjPGbxFswpOgbdbSjBSHuH2NL1WVkX96NPduF9NkNBkLdhss0oVgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MccUUsseTiFGyzF7/ymVHSdaNK/7BlNDt+1PcQFe9zs=;
 b=zBM04ofP/WrGRzKFcGMkieB5YDJIr1lQkzCras/GUD8oi2YbEnMqkEDcwBlxvQMjalKs2kuLc0n1PbrL3AOSE8GuLhk4uIfodQZGDvb0wStswkmTQ1wzA18TS6q0FdVa9A6hoMPQaITOvzMn+1cDVWh2VzDubQIt5BdNA6mxv9A=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4794.namprd10.prod.outlook.com (2603:10b6:806:113::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Wed, 15 Dec
 2021 18:28:26 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 18:28:26 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>
Subject: Re: [PATCH v4 11/66] mm/mmap: Use maple tree for
 unmapped_area{_topdown}
Thread-Topic: [PATCH v4 11/66] mm/mmap: Use maple tree for
 unmapped_area{_topdown}
Thread-Index: AQHX5r/na1ztpYesMECiyTp7r8thMKwz2EMAgAAdTAA=
Date:   Wed, 15 Dec 2021 18:28:26 +0000
Message-ID: <20211215182818.ibsmvehcozznvgg5@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-12-Liam.Howlett@oracle.com>
 <97b96d36-434e-fb4e-3e0f-7c96faa9cef9@suse.cz>
In-Reply-To: <97b96d36-434e-fb4e-3e0f-7c96faa9cef9@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6354e3d9-6cd0-4cf5-d180-08d9bff8af3e
x-ms-traffictypediagnostic: SA2PR10MB4794:EE_
x-microsoft-antispam-prvs: <SA2PR10MB4794E5376C1082929754F54BFD769@SA2PR10MB4794.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yoyXSPrREwkY7Fy6nFQPem+GhsOejuaUQDfRMKMihxg/GCzWnNqWos+QNE6lkbPjS+31YhBDU83F6FgpnnQ/wJ0u3i1BW/iHiCUane4S0wRWB0HGUIHSSFTYRI9gqO8svhbG/1+eou+iq5wMB22Dm6343vVUl2yO9Oo3iYtLT2UFg+rABg0ynJNKmp5/R5TOfI6Xt4oz2ZBkr9v7nqMYnlVgEJZ6EuMETMumZpJkfckywcTNzfaIlMe9a+/H/tAfC2Ohi1Va1R1cTMxKm8ckpYxtRcsvLUtC0wNzOym1mZxMsQuulZn6VYmjUzcrXH+3D8yE1ac4Y5HQFxl7JkqD9xzDyhH6khic+yk9O80NT7YUNuOTCsdsMfI7peZR8N3iansT4EG4nqxMJVf4w5DcIas3AF8ZRKdJKHejJrKFjTDtRlvkJjy3doJiRuZy4wAuusXm3beN8CUqJeWQD+fl+qFYk+mE7ANJET/PoVYaoA87mX0itWocIgxw13Cv0m+sNFepme5jadv/C5zmHhpudmofB1kXNLkIcd6HYycgXCtuuGYUyiYNazemwxVdDnrZf6AEsshh4yny/XsAorlG16CBeWVY0kvqIPUjGxE8Y2wuiPxfbXaEjWp6DD1eefqUjvvekrcFmcyR/uR53mkLyXIrgVRy18yj8Bn1HhVqeM0NVruxx1nPMHzLfboXstRaqVbSnMga5ui6OHMVdnIdyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(33716001)(86362001)(66446008)(5660300002)(64756008)(66476007)(66946007)(91956017)(6916009)(76116006)(66556008)(6512007)(508600001)(1076003)(83380400001)(38070700005)(38100700002)(53546011)(6486002)(44832011)(71200400001)(122000001)(26005)(9686003)(7416002)(6506007)(4326008)(316002)(54906003)(186003)(2906002)(8936002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P5YGFzGJ+M4YmBmbnkYT6Q6btateEcuKDZthmaeJLh9V/9JXNjs3yhFXqVzh?=
 =?us-ascii?Q?VUSG01GLGM9yF2Mufwn9HWLaT6/sOI5uvNhJ5wck3s8mnVGPXoqeNd9xNUo8?=
 =?us-ascii?Q?wuJXSy3p6Tswj0Xi2aRwVpxqdaPABYjHtfL5o9vtG3JgpWQQNICWMjv9pRrB?=
 =?us-ascii?Q?mtyBrkU5ZkTGxRXrhfQQ45i7qAorKuoYGqTtJmNbiqKO2xw0fEC45vedgKfC?=
 =?us-ascii?Q?QPTPo0XTO7EpTypupsTeoNrL6DVdTvVpx03+CTKDcuJHszhlvJs65aoYkmw4?=
 =?us-ascii?Q?0zfRDbM99bz2dEx5OdB19kLQWXNHpxcJPgbuShCelqzrsjQzo0B9q9nzB3w7?=
 =?us-ascii?Q?moIm1NHQ9hpK/J+tTI6bwxHkUlCPqKN+JMt4u4AfaLsP34eNriYdD/Z1ddj+?=
 =?us-ascii?Q?K47rsSEPvu3jCw8X7JQXeOU2wDWgio0BhelS0+35rvfiWf4VXhlzJH46aur9?=
 =?us-ascii?Q?yc74DTPnEmlQFNmyNPFDw3+QnXTogpmrPvk46BQzJ5fm/MdBWQDgUG8YMQIO?=
 =?us-ascii?Q?QG0CTH1q4qpD7xf9dmFeZ6bL8ZgfeZt8GwRTYkKnDmyL4jrPgXVOlyp8LuB0?=
 =?us-ascii?Q?Z1D7YEKWJuPr5lhgBv1TueGOWdF3ciWOduoOVbkubNhFocGkQ56jMpdJSWLH?=
 =?us-ascii?Q?QAufvJH1ES6naGCC43BT4qZGjXmmI7ewS7ctEl7yG9r8uzMo5zTzTs2RIUZc?=
 =?us-ascii?Q?QlGiwAvCza4HRV/VXpZyCoZYDQ7Y+LwqIT/Mgq5Ql5uoVaind+unf0OkrusV?=
 =?us-ascii?Q?ZAdQHo1etSgVnLWBqi3jaQZgCLJpAZUBRnOHka6NnoHT0ipiwQ1Z5f+1aMHl?=
 =?us-ascii?Q?fuR4hnQyFOJ3wKEPDTcb4aHvVSyPZD5qTTSc/mGzfXp1h8b+p7Svil3EoAVk?=
 =?us-ascii?Q?mgzkbMVuooKUwKVvskdwBUupBzNK+yqk5V+hkz+kEYRgH56f1NeO6Fx7IccV?=
 =?us-ascii?Q?9+SYwthI+89M/+yDQXfa1ldQbN2gckFZ4skFy0Z/83jT1Mkbw3/fHLiDr05e?=
 =?us-ascii?Q?gJ24wG06XnsACnXCY71NK+HskGa3/jKo8QQn9oLwuRnQCR88hG3pQlm2OvHt?=
 =?us-ascii?Q?gOGnzAuC6h1i+hChEjFAWMu5aQJ3kVTESgxdaviaTfLVsFazXQcqVnSVD2ob?=
 =?us-ascii?Q?RB9qUIlEfFRPUuSdRFdOrthTdHn0z3ZjPNWGooGHqZvGiB2ebfPPolxd6Mce?=
 =?us-ascii?Q?OzG5EW+HL/aS8Fhkp/htVynZFcWC5XoqiZCaMgodRIaZj4vmgQxhWRSbP8u2?=
 =?us-ascii?Q?Ie/R9T5asIolYLiURBmtV3iosKG3YwmSHFCXYC7pF5gtphPTLnBquu3yuBRR?=
 =?us-ascii?Q?CO/9YeeM7RsqszY7gvZKhKGfNgtT6TLljpsqWxKGp5NIypSkk84coshM5+zt?=
 =?us-ascii?Q?k2Vhalm3Xva34tKiDR/wDflYbFZuZRg10fRx8dr5zIBjpD8aN9o9dLGsr1fy?=
 =?us-ascii?Q?Ycd0w5gpsNWZETql5ne9/2OXURg5R04kc57v4MdBDCl2rpCs5SsqCyZfzU71?=
 =?us-ascii?Q?wq6dhruW1tEKjrmQds2xanu7r4EW89P/x0arIFxe4GJaz8BBOP+OPBw4nCjD?=
 =?us-ascii?Q?LhZpC9mx9CHRi30tEVruLwQnysHfSj62s7HNd+xs20AwUWPBZdlS7kvmfIag?=
 =?us-ascii?Q?iynnFf36uk9gXErpgDQGEvE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DBAEB545C83D7C4691F93B2142BF22CE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6354e3d9-6cd0-4cf5-d180-08d9bff8af3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2021 18:28:26.1935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NpCQWlzmy/h8oVwH0F4yvECzQn5jF4GZ7I3660w3E9EV0U8ko+KCdZU43t5QKc72i6NdJDAGTh2izBSKFjejuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4794
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10199 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=763 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112150102
X-Proofpoint-ORIG-GUID: DX_CmYJKVdKU4wk6kpnUfdlFm0r1lfux
X-Proofpoint-GUID: DX_CmYJKVdKU4wk6kpnUfdlFm0r1lfux
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [211215 11:43]:
> On 12/1/21 15:29, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > The maple tree code was added to find the unmapped area in a previous
> > commit and was checked against what the rbtree returned, but the actual
> > result was never used.  Start using the maple tree implementation and
> > remove the rbtree code.
>=20
> Nice cleanup. But...
>=20
> > Add kernel documentation comment for these functions.
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>=20
> > =20
> >  	/* Adjust search length to account for worst case alignment overhead =
*/
> >  	length =3D info->length + info->align_mask;
> >  	if (length < info->length)
> >  		return -ENOMEM;
> > =20
> > -	rcu_read_lock();
> > -	mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
> > -			   length);
> > -	rcu_read_unlock();
>=20
> Why is RCU locking being removed as part of this? Ditton in
> unmapped_area_topdown()

It is not needed with the mmap_lock() being used in the maple tree.  But
I should either be consistent and keep it everywhere or not have it in
the earlier patch.  I will fix this, maybe I should have left them in
everywhere.=
