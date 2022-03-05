Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F132A4CE1FE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 03:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiCECBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 21:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiCECBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 21:01:36 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E08353B65
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 18:00:47 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2251VaKk010128;
        Sat, 5 Mar 2022 02:00:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=aKVfx2lM8Ay0JmedgskP0yiufw6RWJKpcRONevNA7KY=;
 b=ZwletwQXn1Yd9eZS9V3KLDCTt2QbS1x2hC/PwAHNboOrgl7Uh68XxN2ofW+1bfHsoXNu
 qZXPB6xYHPft+u1zGIZGEU/o1lLrmMbARHwGHuAS34obL9UCR/Ntw89nwP97whIUSlbL
 BUL7EzK+jqIEaADilBWX/RRsoCE5vJOmo+llOTRfcT9qQn88XmJ+MOuG7cLy+OpHzrzb
 +kJQzZm99vervBt3N5Gwt1HxurfC1CGfH49l0pr1daWPw853HZ+cCnA3C29F4Bk8NH7O
 ExfDpP1U87imT0M5t+AQS5PGu94J8KeHGXo14itcpKypKK5JaNUnktct34kGkE3BMfAd sA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekx9c80t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Mar 2022 02:00:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2251uAWk050833;
        Sat, 5 Mar 2022 02:00:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by userp3030.oracle.com with ESMTP id 3ekvyr3smw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Mar 2022 02:00:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ShV1blyYBRJhHILxb6PpN9oF2hsUxBtlEQdwkcStD+94dtv+TbqwRBvgOu2EfxIa5Wn0K9C3vYozGTBTILKt+2JMn4gps/6q4+bfwdGe8Xqff6VIuEd+Vx0nVLgfEkoqjvQLolB1pfNxS3w1XSUhLAjuWYWcToNP549gYPVY/pQUE8I7T6PTh+PqSq1MdECeqIjIH+TpPzJ0H8h36EygaJF/6wmTp/QTVKnf1SB+ZjTYoecKCFR0sRmfOVSr5djT7XsK/sdmrFzldabQSvinYdh2h5+u7sDwZ5if3McXbgYmNvcCcgNZG5zmjpQOIFxmcWu6Lo35iR622S2C2uNDQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKVfx2lM8Ay0JmedgskP0yiufw6RWJKpcRONevNA7KY=;
 b=dXxRx1zhQ2gQVwwRmbqkBbE7+fBX6BL4Za/yQ6HOkZJcFX1+pTASCG7qmgMFh0k6Jd0R+hTUMHX1xqsEaccBF1F6gIRTvuCer6OSN2JIoByeLRmXHyIJ0VmjYWWp5ofeFu3JJGQjRFCnbYwC9yBIqcpgUYPya/wKNhYEAttMuiOdiRSk2WY0xhDnwx46fIk4ku9MMHc7NLfTdzW+RSoTFhDO40QJ2lMnKLiTvyjh8hJ0u8SsnFEMrCC67EB/w1VncKdVeIyfzsHrGioPGFjV/PXn3q4ljB0n3G5Ua1CmdnU/ntlRP3uYj/5/XYUp7dRe9l5u439TRfsJnirzEEDyDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKVfx2lM8Ay0JmedgskP0yiufw6RWJKpcRONevNA7KY=;
 b=jQm+Vw67c/zWVPYDorJZZj9C89l4GCjaVZ9DCR3bmng1RNmhjaPJ3XoGSyUH+cALks9cDmTB6yBnj+zMVGBTMDVMsklXLX8J2AWawl5S4DdxYI1sdBTFxbZxyGCYX3n3ewPKaMftDS9GLKdlzvMoLT/W17kMgaWOxFSxyTm6MnQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BYAPR10MB3672.namprd10.prod.outlook.com (2603:10b6:a03:128::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Sat, 5 Mar
 2022 02:00:39 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a%3]) with mapi id 15.20.5038.016; Sat, 5 Mar 2022
 02:00:39 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH mmotm] mempolicy: mbind_range() set_policy() after
 vma_merge()
Thread-Topic: [PATCH mmotm] mempolicy: mbind_range() set_policy() after
 vma_merge()
Thread-Index: AQHYL4FzWFkyFnZUSku+xBH1UQyT+KyvkiKAgAAEfoCAAD4yAIAANciA
Date:   Sat, 5 Mar 2022 02:00:39 +0000
Message-ID: <20220305020021.qmwg5dkham4lyz6v@revolver>
References: <319e4db9-64ae-4bca-92f0-ade85d342ff@google.com>
 <20220304184927.vkq6ewn6uqtcesma@revolver>
 <20220304190531.6giqbnnaka4xhovx@revolver>
 <6038ebc2-bc88-497d-a3f3-5936726fb023@google.com>
In-Reply-To: <6038ebc2-bc88-497d-a3f3-5936726fb023@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a669264b-8261-4e02-eb48-08d9fe4bf28e
x-ms-traffictypediagnostic: BYAPR10MB3672:EE_
x-microsoft-antispam-prvs: <BYAPR10MB36727F3970A4A35DD7BE3154FD069@BYAPR10MB3672.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LQKBrhcE3RYBnFMELhSH6ophaxUb1KCVXrEATh2qFrqTyU9qwEjclwo6MKTxnaRTZnHjFL5OwqqNLsyy9QOb2RenpiC+cLjybDjsPmKwsfHJpONmaXkGK94OPNLdOFvU0jpJkIGu2P+JYAg4IPpcSzRG3U2cf0PzEscRPAEDMysuvJefd6tJSnf5AkzqlboArRorwHdrOUkAaJdRssgmxlL/lWvvtyFqblbGzfj4TNuFVkdvFLEgC6iGKy/Us5V9j6xWWXe/8hveA6W+RwBbjLfCc8a7qbJd3fn9olfKFVcl4x0FdROi5HGhSZTkYGVn+dQwFa2ZoHfncE5y9gJwJMpmMH5EkHIbQJo4LdEqcVNzs1VmJ/SGETqjOfPngCUnP9INUEeRk5Ofu4Jxj7lJySY2CATcWQWKLtCYmN3+ngSjarRCLb35N00cGj9UvqBT1SRkn0yooUTdQ5M1gSnVPSN6Mh1rM6L/BpmMkNHjiNcBtF4WEtarf4UBJzwvm1ERRnP7zPF2zYoDA2J9aQU8nwD8Y8ZPoWvoGiBO+gzRRTbXm+Bt6RkO9Zv2xGekudEXgjufFQ40r+Fx745q3nlVGtQhV2MUFPg3f4U18yD7el9n1YVOoQP9u6Qfuxc6hfPGVEdgxlQPXbADoAHXyGcT0cPzNTASVD1VXtivX0u0hJgBrQlv5PaWVyBRPavntrVsIDx/K1/ZeoenlRmQpR/hJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(86362001)(6486002)(508600001)(38070700005)(66946007)(66556008)(76116006)(66446008)(64756008)(8676002)(66476007)(91956017)(4326008)(316002)(83380400001)(54906003)(6916009)(186003)(26005)(6506007)(122000001)(71200400001)(9686003)(38100700002)(6512007)(33716001)(5660300002)(44832011)(2906002)(8936002)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bExTQ/WTkl6158u2AaUiuTcAJBGdWhh1COtjjaS3epmQQKpB5Vy3oc/leX4p?=
 =?us-ascii?Q?yl/e3dt4N5NzT+80k7Mh+nf2R7Hz4byCRlpdDE0q7rzrkJtTyPxiNcdJ3uw3?=
 =?us-ascii?Q?TvprGGwS+nt98XILyCmQh788G9WckHnfuEfdFJqwvuPbH8MWdG7t/vxcHVWY?=
 =?us-ascii?Q?uuqfdHlhGXfxseRhdlUH14WQ9X1WVXDfX0G092tP5g7xCknPXyw9x6fWkLx8?=
 =?us-ascii?Q?UDkLrhg9qCuPohH/6CQ/k6utkYA6kXvDQSgcqXHWyhcs16ToictSQ7C+/8Sr?=
 =?us-ascii?Q?MFXx4eGx9RqbksZ4P9D1ZswywR0rX7a5cxyX/ADFcWf82t69vIfZqG+RjdKc?=
 =?us-ascii?Q?8Jfl11BVgr3SnseBzdfAj+4C6Hqp6+QfShphlJeA9YRDLBK+9zs+0kdrT3Py?=
 =?us-ascii?Q?Sypa67YYVxLXamcVEt8qlHSLxZ9/ZzEFoCWYZshrp3vTKdPC5e3FRiGfQrqx?=
 =?us-ascii?Q?tvOkk7i7e4t8G1tRudmkLeZ+bL5X6sdiABplIt1OUT/ZaoWoTmFF9VpdUQ6T?=
 =?us-ascii?Q?Zst2C+IziT/ZGXdCKdaS2/ptR2XVfZ/Ne63l5a4jyFj4TXEcNfEnya5cpdTP?=
 =?us-ascii?Q?W1ENJvwbRoNg1pXD6NM+Vo/5QfkReg6jkOgv0kViwsVilSmuwEgtjmyUayin?=
 =?us-ascii?Q?VAGyMCce8mU2CLvKAPy7YHT/W8cHg8UJ1wjqJ6DJi+h65YHdsZbW79r2Q7/u?=
 =?us-ascii?Q?EaVAfoKj4owUiQdV2tBhLzLYzCM5JCzvptWERSPPR7onMXVb9V4K09vcHKbe?=
 =?us-ascii?Q?kOvDWfqYrIJEC1ikVV34VXvFnrMQuAO/6g7X3iBMTWmwt9Iqua2Cs0vdWkJV?=
 =?us-ascii?Q?qKd/UAVBV9W1mV4W9dCQoGUhctCUM7DMqH7suK5bo7HPq/yDqCQFea6lx0z8?=
 =?us-ascii?Q?Td+hdY/ho0iWArwcrdckb60DomiA6GmVUZ2iMqRu7vjrgS/x1PyXp7LlVGGr?=
 =?us-ascii?Q?SPWoRy2M6yCssTEFFmduODXQfkaGewIaym0o72BbcrLr3niMA3hpDy+yqOrI?=
 =?us-ascii?Q?0xwnLA6GNu0eijZ5gtyuH3Q+ZdLW25yhfV1K1nGPZkDuXRBq9KLn5aJz2Btx?=
 =?us-ascii?Q?ObYuGYafEiSMxPFQh5nruaifv++IeokHfA5cjU+AMqV3L36itRjqcFo00Nz6?=
 =?us-ascii?Q?IwDtoC+usNnRyawQtVwOFzD3qcpKqoAyIgiJE0GY5WW9DAqxVKBn0jCHwRNI?=
 =?us-ascii?Q?oRKPSWx9lC68UNq5dEHeUPav7lftmVVBNis5Zt7eHoV3SEJieQtSn+C2mBfT?=
 =?us-ascii?Q?QS35DIH6+1P/oZl46tXeGOURUmzGt/1lx3LFkWDsK5c7XnxL6A5EBq8N7SB6?=
 =?us-ascii?Q?aMez1kH7L4ER6aWGhYm36CM2qR4dn10lSei6y7UbUAWYVzSKJgyFJ2mjaH+V?=
 =?us-ascii?Q?AleabN8/P8BOpeggFod5Bco0oAQ2w7rLQPBCnW6lNUMmDdHhbdX/nn5Q0Xwn?=
 =?us-ascii?Q?iU6OIRYsoOBRgB/wF6R6s+oZbiUnn7Qe1gCkZ8gN+Q/uW/Btk01RhC5hGquy?=
 =?us-ascii?Q?PQHQF++WHIskLo18HlN1n/Phlx1YUtc/mAsvH7ZKPHT0Cr9QCTNQzBQBar0t?=
 =?us-ascii?Q?Gp8Pyisf7s40eziPlfuPZfjHxhaGXadqqFQXBOFRKoA2cP00jn++l61JJgmt?=
 =?us-ascii?Q?onS1qVsiYJs3AKn/cb7vmM8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9594EEC17D301243B07ECE08F890FB28@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a669264b-8261-4e02-eb48-08d9fe4bf28e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2022 02:00:39.4309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X/PxBut3mEOCqAyX/L8WxfAScYd7BplADawhUokBfchhGaXeD6q9gzWVr2/Tps3PwIdwN77yr5FXZ09v3r13aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3672
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10276 signatures=690470
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203050005
X-Proofpoint-ORIG-GUID: 2ypbhft9Es5zsMAGTDwoDw9x8_R_AJXK
X-Proofpoint-GUID: 2ypbhft9Es5zsMAGTDwoDw9x8_R_AJXK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Hugh Dickins <hughd@google.com> [220304 17:48]:
> On Fri, 4 Mar 2022, Liam Howlett wrote:
> > * Liam R. Howlett <Liam.Howlett@Oracle.com> [220304 13:49]:
> > > * Hugh Dickins <hughd@google.com> [220303 23:36]:
> >=20
> > I just thought of something after my initial email
> >=20
> > How does the ->set_policy() requirement on tmpfs play out for the
> > mpol_equal() check earlier in that for loop?
>=20
> It took me a while to page all this back in (and remind myself of
> what is case 8) to answer that question!
>=20
> The answer is that the mpol_equal() check at the top of the loop is on
> an existing, unmodified vma; so it's right to assume that any necessary
> set_policy() has already been done.
>=20
> Whereas the mpol_equal() check being removed in this patch, is being
> done on a vma which may have just been extended to cover a greater range:
> so although the relevant set_policy() may have already been done on a par=
t
> of its range, there is now another part which needs the policy applied.

Doesn't the policy get checked during vma_merge()?  Specifically the
mpol_equal(policy, vma_policy(next)) check?

>=20
> > > Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>=20
> Thank you, your review is very welcome (but mainly I Cc'ed to alert
> you to how I'm probably stepping on your toes a little here - sorry).

Yes, I figured as much and I really appreciate it.  I'm quite confident
I translated this bug to my patch set.

Thanks,
Liam=
