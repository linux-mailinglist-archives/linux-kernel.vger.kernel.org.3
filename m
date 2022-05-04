Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C925192F2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 02:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244767AbiEDAq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 20:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244476AbiEDAqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 20:46:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DB83F30B
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 17:43:18 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243Kx7cD030616;
        Wed, 4 May 2022 00:43:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ykj9QDBA0s1RA335UqcRBX23JxdnDBE54Y2lWumBx2Q=;
 b=TfIfq5qbqXgi0RwhL+tdtv0QZmavcrZeax+7N0/8biN+FSbaG3DDwPHsCqKjHMp/3Ypa
 FEo1HBcQXpJitL+qI60+jEjRXV532mF0wrMkAXy1DynBJeoamTiCItPgyvsR/5aZm4+l
 ANGTp8kf3v2xoi4MUkXdjIzLP94uqSNZVeqWfabIMKwTVUA1h2mpZOOl4BRbaIzC0T87
 6ZH21l2rI+zZd0pWQoB+jzOVVRFBXE3Xvj7jqS2YaRvAlDoEEhY6yh2YfliHDDcL2+TO
 wPyCizcW8SPjFml+7jub3CVbwBPhDEr4ycrVM8pfJlvr6vubQkziKrCV0LkStylX3GK3 Og== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruq0f548-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 00:43:04 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2440eX2k034050;
        Wed, 4 May 2022 00:43:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fruj2w1dw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 00:43:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJ3f57iqI/7l6u7d5Ykys/7u93GEQHL+7dD3J8HqaH5WDI8ULoYaa/m6htGzr1QcMlb/ZP8CzibdBW9Xl+67gdUy3NfWz725lvNtNrCSAst6vJ9cUVTRW5fT9+CZDNTrjh52e+D5bihcxAhpZSOEspA5iHqC89B2hQKKbJEUguY7oLay+2qbq1bVzlC5MVthIZ3OBKjSI8ta9avLq9gpLO49qEjMMT3YZShkfoJ+wnWeqtOezIBPJ0qdh4C2/M60RAryQO+fKgaIgplmyIkHm31CkPNfBQLXF8nqoupvLWJinEt0UBRJIEfsV/LC6rkX0MNGi/ME49eBoXbWNKSCOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykj9QDBA0s1RA335UqcRBX23JxdnDBE54Y2lWumBx2Q=;
 b=HbwpmgIWx4x9tssUd358DE9zntgMsa+6QAmhLGh4eA83AZsU1uG7TJuXl7EwQBDu1VcUp7Vx19Y2Ph2UP2Y2/dPLTuHNlngXApdC2HW/p1LvEU0r7UfRYbXN6khpuygqbYVxXfOmLEj5qLW72L56ls23e3AtHMw1EkoOUUzApSCXbECIm6QkfQkeJh+SSvifAToAClBrzcWSgh0Rnd69gNbV9s044tT/PsYKHA38mcAWuJK7Q1B7fpNipQ18vnxPyaoF5Cw540xl328LkrN+zMdRnlWh/TAMxQVafbvP2lwcs96n5mW0p4YqUxJxRyJln5UEAEfbFLEt3cmn0QuroQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykj9QDBA0s1RA335UqcRBX23JxdnDBE54Y2lWumBx2Q=;
 b=tP6wivOaiguy5oMayepd2b5s6L3H1+rKDkgC6E/ymEHWKelRtV9lSovXoEaNceyvH66DmjQj7shm9wzyvbXz3m6aJ/Qy2/rFa2FFdN0x/7xvKjmAxclbRs45Ru187kIl8Sn3XlxIEEeuyp3Qu34LpEGsUTTg5jlG2kgjT2P07To=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB3676.namprd10.prod.outlook.com (2603:10b6:5:17e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Wed, 4 May
 2022 00:43:01 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 00:43:00 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v8 00/70] Introducing the Maple Tree
Thread-Topic: [PATCH v8 00/70] Introducing the Maple Tree
Thread-Index: AQHYWX8vSnmCSFccn0+psIQVsVvpYa0Cn+2AgAEtogCAADlFgIAACwYAgAZupwCAADqrgIADMZyA
Date:   Wed, 4 May 2022 00:43:00 +0000
Message-ID: <20220504004253.3vimieelrinmwqww@revolver>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
 <20220426130857.09f40743b42b5f0bf4f19a59@linux-foundation.org>
 <20220427140832.mpvnnkkhrbupk46i@revolver>
 <20220427103331.9876ad87626af0f50e9ced0d@linux-foundation.org>
 <YmmHqlR6lV84KDrO@casper.infradead.org>
 <20220501202532.y6zmznzshbe33nwx@offworld>
 <20220501165633.056319565dce429e36d25a0a@linux-foundation.org>
In-Reply-To: <20220501165633.056319565dce429e36d25a0a@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7c246aa-5044-4b65-9e2e-08da2d670aa0
x-ms-traffictypediagnostic: DM6PR10MB3676:EE_
x-microsoft-antispam-prvs: <DM6PR10MB367647D6793C3E64F07E45B1FDC39@DM6PR10MB3676.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b5170YtlrkmJmJj5HE++qwCPSjn1PYTYxv9Fg9qPqfkgm2UaYzlkxbHVxxiR/gUfkRQ6UUcG4L3PZK9d0qAQtGs+zdJrAM0NHZ2cIsv94jx1pOMUYQLtHO+PC3DdVStGygK0RRcC8GC57VkXozMl6cpzJU7KnC1EtqBoQuqdUBc+bLSk6nnMYemxVgIdy15JOPqRhkxAj3PQfHS1kjNWugDfUVl5JstjCo7EqgZnRAMevQP1YKnIZlo1xVW2kzkfnKbI114HqgjtycB+omm+nI/f+9krZOCRO3HdvNPaApKmYNUleplyZxzSk9UVOjSPoXijvrGP4rtkywrSMBqf9lODurtrlAqUi40KDTKVScGoxRjJtKie4YHGuKNmhgF+Ro1Lo42Cwssvkq4KrV+Q64J+puZadGbgvGk+KGwShp6HLdAAAoucdLy6Lrnyr7HeXVJrdBQR5+ukpVoL8DNJE4RwENxJd1jNR8i5wTpYD2NyCSCSt5ip8GOo2ZLdgBw0IseeW27K9o/fSA+8iFBoRi+dx/OnW0Zz9CU/1M/2DHgw+h02eLENAtZ4REo58s4ysV0FNVIezF93J/dF6LMlxpdFRp0b+GIdaBVmCyH+tMLpjsL0tk3yBzS+e119rwVNAfvOiiCuchJum/GUnuhBXxU+tauS8g+uQ3LJo3pVBWgzgIMTAxCseEddG9XO6wORBXz+VBcn/5+Y/mIN5sRfPs0dYr+7MIMjQVh2fXbVUhAKaGvTLUeTKzRi5guou+6h63TAYKToKQsQAraQIdkbhlEJKuf5eJlqLH9ajA9XhIA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66476007)(4326008)(86362001)(8676002)(66556008)(508600001)(76116006)(66446008)(966005)(6486002)(66946007)(33716001)(316002)(71200400001)(54906003)(6916009)(38070700005)(38100700002)(83380400001)(2906002)(1076003)(186003)(8936002)(6506007)(6512007)(5660300002)(9686003)(26005)(122000001)(44832011)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tblQIsJxH/QbINH/jrO7Tw0PEFWX1IzfTXheTOjsse8xXM1zHyNkIlE/uS3M?=
 =?us-ascii?Q?ZS3+19/9CVLaa+9NqH6jhBV8Qj7CmVaeTTu9twlj0XOBR/CNz3FRDBGiBds/?=
 =?us-ascii?Q?gD0kf/pVCfu81Wvb0C6MZiR807jZMCXBgN2w8JO9xXQVTssWrwWMVVgV0nIt?=
 =?us-ascii?Q?7FJwyFHk6uAntykGrcaBYruhlEv9T/JoNWI3geExWpw1XAVFSYofm+2Ye110?=
 =?us-ascii?Q?9iUN3dXy9GgjDiZyYoUkFD+m5O1t8DgDFwqpO+lLpKHXIm64YUpubR0iuzAp?=
 =?us-ascii?Q?rxif3Iu2AlOYPg02yWcQ4865JVtwY467BYjekd2UqAHI7a+/5+I67QhVBx3H?=
 =?us-ascii?Q?SpjYu0Df7JE1PL9k27MK1xfhe5ce7e31mIZ6TCo2V7xbpMpIlkn1F5mFt12g?=
 =?us-ascii?Q?eOn6/1VYi6e1mIXKJ11GSlsK41X5saUpgVKXiwQ8R0nWe463WjKz01lu0bYg?=
 =?us-ascii?Q?KXqVbqnpr6ZFf+0rgs9BuB7DhwRvt6crcot0jfOnAgugM1adSldkXM/De0dh?=
 =?us-ascii?Q?Zr3bekKJ1eNPmCi+3nP5FCp52v+MEtOKYcMmdjjicULVv2kY7V3PjIZJWosJ?=
 =?us-ascii?Q?6j80xoLD/UrEPS7XNAin5XyUjV59D+EkkqrQa5yoaiqWVo7dNmmpMtVcua/2?=
 =?us-ascii?Q?DGjHmu/8ABbVwdv6bKnZkcYFgsmjD928V2BBpRNx9mILNv8/sc09wqbjb9wS?=
 =?us-ascii?Q?YbFnpTqESxyoS/+HQF+ngDZ95EAsEGJSduDnOhnVUW0yZ5dj0iYGJXrjUz24?=
 =?us-ascii?Q?T91vNBS+/daWjYgqlI6zxTkb0m/PdMD13g9nUEFqdMPhhXwoO7JLFriJHtBp?=
 =?us-ascii?Q?O6cUFmSPdHDrBnqnDikZegeJucU0e6D/g5VhiTD7JlUU3dEq/wpoqANDabTs?=
 =?us-ascii?Q?cdtGcyirLL+d8hZNj9JEsI1I6AvKLl20Pgc+Flhxn5ZiUxdyUYXG4e2FrMZn?=
 =?us-ascii?Q?4tcdIeKA+WKLMpPqnkinmlSghWPYhB30LPkbCEe4v6yAFVDYMYm3q3ZijNmo?=
 =?us-ascii?Q?6EsLf9Mx0mLv+wXFtXjVPK2Tz2syk9G76oZuxdSkyvB6bfcSUybsyUA4VAXY?=
 =?us-ascii?Q?+ayzm6j7+wAx9dGWK9wzk7GprgDp6jCP55N9peA/BmfDJMr9uj9715UGw6ln?=
 =?us-ascii?Q?9v0ImTUcpMgCEBlt/I+uQy6A89ZEOr37Rkv4pxgZh+R7/koLdPgFakvfzMgN?=
 =?us-ascii?Q?01BYNA/UjIpbYTKbFLD8rJjscooB6z6Toh1lvheXmX4Y+Tv5aoP1h6kzMt5z?=
 =?us-ascii?Q?TcOuNL7tkLf/YC4Np5KNVUQMJE1raVD5R6PPIAKtqh9S9hDI8RSgeMBSbQDP?=
 =?us-ascii?Q?8HOw8Dd0pihppak20EgIp/u+MQwMUhRYHKEGrUB4sjj0B6meafUXUN5nFUNB?=
 =?us-ascii?Q?lLWtejD4rGtSl5OaT+8FvzHQd0wNWo6MJ7ewj9BUQA1Gomg8eqTUNerC/Lwt?=
 =?us-ascii?Q?+2C1fXxoaQIDnudJvKC5Xb9HvEpowiFZj+s4Q92fowOVQntPMPnQ8g9o0q1l?=
 =?us-ascii?Q?ed9wU9NqYtlAPZdh1F8VQzRME+ZI0utKC3YzVWs08pey4iHRM3mbISVQdxnd?=
 =?us-ascii?Q?VaADpkjZ5s/dSzUFaZlPJEIoZYPwjnjNnUqH/sfmnX7x5geD4R5HH7OMpDJX?=
 =?us-ascii?Q?S30sm2zuUqX+P/GhtY8Q74mRqiBaaF+qMvXFtEO9cqpsJLUroubkXtZiblul?=
 =?us-ascii?Q?s1R9xmY9xempJmQmvGz+JwSwj2CKIi8o/jMaHznvFZca0BpPJKSdVN/Kshje?=
 =?us-ascii?Q?YwCJVSk1VAFi2vhm6hdfpviB3YF///w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8481BFBD62168345AB1D620C9A4F8870@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c246aa-5044-4b65-9e2e-08da2d670aa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 00:43:00.9370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0q3BWkBTjT7WsjsoFfQe3UGdsf1uVEPqs/HjTczrE8YoFqtmF8SC96wmnGhQ3f9ZJOdmyQld02VL15IqlBp/NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3676
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040002
X-Proofpoint-ORIG-GUID: HlH8srpKns5XZWQZvio8MTMVLEOyKZiB
X-Proofpoint-GUID: HlH8srpKns5XZWQZvio8MTMVLEOyKZiB
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URI_DOTEDU autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@linux-foundation.org> [220501 19:56]:
> On Sun, 1 May 2022 13:26:34 -0700 Davidlohr Bueso <dave@stgolabs.net> wro=
te:
>=20
> > On Wed, 27 Apr 2022, Matthew Wilcox wrote:
> >=20
> > >On Wed, Apr 27, 2022 at 10:33:31AM -0700, Andrew Morton wrote:
> > >> On Wed, 27 Apr 2022 14:08:39 +0000 Liam Howlett <liam.howlett@oracle=
.com> wrote:
> > >> > The benchmarks are around the same as they have always been.
> > >>
> > >> So it's presently a wash.
> > >>
> > >> That makes "the plan" (below) really critical, otherwise there seems
> > >> little point in merging this code at this time?
> > >>
> > >> Please send me many very soothing words about how confident we shoul=
d
> > >> be that the plan will be implemented and that it shall be good?
> > >
> > >Yes, performance-wise it's a wash.  However, Davidlohr was very
> > >impressed that it was a wash because we're actually getting rid of thr=
ee
> > >data structures here; the linked list, the rbtree and the vmacache.
> > >His opinion was that we should push the maple tree in now, in advance
> > >of the future RCU uses.
> >=20
> > Yes I like the maple tree, and at this stage I don't think we can ask
> > for more from this series wrt the MM - albeit there seems to still be
> > some folks reporting breakage. Fundamentally I see Liam's work to (re)m=
ove
> > complexity out of the MM (not to say that the actual maple tree is not
> > complex) by consolidating the three complimentary data structures very
> > much worth it considering performance does not take a hit. This was
> > very much a turn off with the range locking approach, which worst case
> > scenario incurred in prohibitive overhead. Also as Liam and Matthew
> > have mentioned, RCU opens up a lot of nice performance opportunities,
> > and in addition academia[1] has shown outstanding scalability of addres=
s
> > spaces with the foundation of replacing the locked rbtree with RCU
> > aware trees.
>=20
> Thanks.   That sounded like a wordy acked-by to me? :)
>=20
> Liam, I think the above is useful background for the [0/N].
>=20
> > [1] https://pdos.csail.mit.edu/papers/rcuvm:asplos12.pdf
>=20
> As is that.  The paper seems shockingly relevant.  Do we know the
> authors or is it a cosmic coincidence?
>=20

Cosmic coincidence.  We designed our tree with the intention of solving
the hardest problem first.  Upon settling on a b-tree variant and a
rough outline, we researched ranged based b-trees and RCU b-trees and
did find that article.  So it was nice to find reassurances that we were
on the right path, but our design choice of using ranges made that paper
unusable for us.

Thanks,
Liam


