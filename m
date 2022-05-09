Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6573F5206AC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 23:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiEIVeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 17:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiEIVeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 17:34:03 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029C52C13D2;
        Mon,  9 May 2022 14:30:08 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 249Insbt008669;
        Mon, 9 May 2022 14:29:46 -0700
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3fwp4q0qau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 May 2022 14:29:46 -0700
Received: from m0045849.ppops.net (m0045849.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 249LOHIt005646;
        Mon, 9 May 2022 14:29:46 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3fwp4q0qar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 May 2022 14:29:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7efee5w1/9ponj7yiTHkj39EEIx+XZx1pw/EpRcLYmH2OvrCDIAzzt2+ElALm33uhd+3+HZ9vxU2cnI+3aZ0yIGQmjLs+stGbKt6paPWKHcrMRMlewmGJzo1wgio8BVIj6iY3ERNntM+0pZpK3GVxOowxmTJufVpac45gVV98u6+JzYcNDlb4H6uT3Je/2g6J0pJ1V+/9wInrUFedaHJJ5duoaBW8/KmvsX6bxaPWtIM52IZSz8kvQ6N+d1CC2Qiygna20AbFDOuQWf0UEsZ1/LRcVPwQwR2mDjT4gWzGbCCpaM9UKRO0wvx2+FlTW5cUVynycFclPeiEW/P8ltwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0EyyF1Jm83SFM5n6Rf3AjoOgglr6Tk/ArC4FU6TRhfY=;
 b=ZENveuBfyW3IbwTJc4lhQGCr+z8DpCdG9GTjyHsyab+6hvuyX0neWoj7/4qLM1qEPpZg9uzsb5XEM6thZ4U+hDSHuvWhLGSpTugY8outvWFK80bRVE2ZMh+Z4b5H1W5IS4ufU2JKNXhV4x1Lu1GIgf3kGbOfmPFexHHAKOltZkglklMc5+nURIx3IbDqkhW5vqQ3c/nVnuOWdOqtt7ITMuvPye9BMzsvOcKz4Hrkv7n/PrU+uzUn+3yi+s3dJ2uRdXEs3m7wk4YU9BGCZA81SJDJt6C1UmA7Kc9F+537Gjy4HaTXyfN/D1hGove6TEyGPF2ueURDqZkmlXc+BzrrSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EyyF1Jm83SFM5n6Rf3AjoOgglr6Tk/ArC4FU6TRhfY=;
 b=TdUcTv8IfCf15CKsB39fAZbtrgPl7KP/ibWfinXEBRWJ0JW2JmBnldlTlERjVYG033XYlZKUITACL6tXz77+LVTX4heu7HLft70kzIsuwf4OHhMqZV6LZGm0y3/TiamRq9O5spPcUCI2AVXY9u7I0PspJhZcIYNBEyMsiGjK7W4=
Received: from BY3PR18MB4530.namprd18.prod.outlook.com (2603:10b6:a03:3b5::5)
 by CY4PR1801MB1893.namprd18.prod.outlook.com (2603:10b6:910:75::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 21:29:41 +0000
Received: from BY3PR18MB4530.namprd18.prod.outlook.com
 ([fe80::6d08:b515:317d:6ef7]) by BY3PR18MB4530.namprd18.prod.outlook.com
 ([fe80::6d08:b515:317d:6ef7%9]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 21:29:41 +0000
From:   Xiaoming Zhou <xzhou@marvell.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "colyli@suse.de" <colyli@suse.de>
Subject: RE: [EXT] Re: [PATCHv3 06/10]crypto: add rocksoft 64b crc framework
Thread-Topic: [EXT] Re: [PATCHv3 06/10]crypto: add rocksoft 64b crc framework
Thread-Index: AdhibcBRiq8Mz+RYTlqaQoqjC5ZFDgBds16AAAAd5eA=
Date:   Mon, 9 May 2022 21:29:40 +0000
Message-ID: <BY3PR18MB4530A713E7FB3CCD51F71A74A8C69@BY3PR18MB4530.namprd18.prod.outlook.com>
References: <CO1PR18MB4538FAB1C3EC9DC4EF036C8BA8C79@CO1PR18MB4538.namprd18.prod.outlook.com>
 <Ynl7dXm38FaX/2od@sol.localdomain>
In-Reply-To: <Ynl7dXm38FaX/2od@sol.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2a4987b-d706-44d7-3660-08da32030705
x-ms-traffictypediagnostic: CY4PR1801MB1893:EE_
x-microsoft-antispam-prvs: <CY4PR1801MB18938521EFFF6E77CF53A449A8C69@CY4PR1801MB1893.namprd18.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NO2tgFzA79Bcfd/1JE4+N2ahMVn+LAnmm0UEG1ySFXFEltNRH0Bi9DUd0h9z/milEXfMU1KH/uKpvUuka0QmU2MYyg0Lyyww6/yBHk/W4lYFgr7PovZI2U9+4yVsTO7F1xdNuzwtwt82SEqruy8J/+9eU3CzJUq5PuNGwP1TF8LRC8PxGBwZmG5dYSBEmySLgyiKaaGjhVuggiY6evU0YEioLM5Eeakd4tFh7YxvZfn9SyZGpGMCf6EDUx5fhWVQZYY0vMiAEN3efesTLmJPnyk8o9TT3IIpbj+V7PXzWyEiYmotkQiMymyjPT8nQucJI3yW+AL0tYC/C0e1dl3WRB1MTp49EZRNpADEXk0nroEGMdib4LEM93MxVzGHZFSR1rouGkrhYDv4fynpTk1PaTaPc7meg3VFE/1CHYOF3mkg6uG4Jkzqg3HDQACbvnkGgmeZSDmNSTiQuJ7LrgmMZbNms+6cGZhdA55qW4SDxfns75A1Au9pHCrcFbVgPfVDfLReAQy0azTuHYx0nFD6dansYH/FC7JffzervjdYYOIs5KtXbvMPyFo8qWSmXoMHlGbbT12llSUTgUQ1rwLCysYaGT9riIdhYM3Ng9GkwrJg7VR2EXbDqdeb4AWUdL4rrsSaat1gJbhF3FTB0iiHH1zIe5srRzqc4BNjCyg+BfwlIuFHsh2IX44jqUBnYI4Jf47Nez/VK7L8GLzXGDGRJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4530.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52536014)(2906002)(122000001)(7416002)(8936002)(38070700005)(38100700002)(5660300002)(4326008)(186003)(83380400001)(508600001)(33656002)(76116006)(66556008)(8676002)(66946007)(64756008)(66476007)(66446008)(316002)(54906003)(6916009)(53546011)(7696005)(6506007)(26005)(9686003)(71200400001)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9WJ1fWxBNbDrXpc7TgKn+NE1yuow3yOxQzpJR2F4lcmShR8EYNZazodkuoKM?=
 =?us-ascii?Q?oCwSu4T9yle+koHacY7+Ux14d3bw9FHJBxsVfeAXuRZeDTXRV4dW0tU5rXl+?=
 =?us-ascii?Q?eIv9JN44Ba1sw20to7jTm2TiK0E//N4AM84D7awzpeYgikm4e98aj9tum3uO?=
 =?us-ascii?Q?yWBQPbmQYC7wAclN/GpaaSY98zGuNPIRipE+lXTLnyLjpoG7erR9CCkU/rzG?=
 =?us-ascii?Q?uUuO5Pc3T045LjcaYxBV9A2v8AeU5n7DymOAdgYWSua4mlny1YJnS0bhSn9B?=
 =?us-ascii?Q?1OMdsww2UdvrNjHkZ6bPKkcZJ1AkOyh8jr4VuRFWJTUT281m/1DVkju+ODPO?=
 =?us-ascii?Q?FvGVeXkHp+wyj/C9eoVtSqbtd2t92x3q5rmuIgEEH0MN2R7A9R/SwJucQnch?=
 =?us-ascii?Q?WI2hwVkDAL7sc7aVms6tUruF27+3q67rMasuKNA9U6xWZn7NGMsIQ6e8nDEc?=
 =?us-ascii?Q?5qQWbk6tvR+n7GLGXSdPoc5EEHpmJkbbTh2OoAjdDCw6iOnnfrr/m6OMFIHH?=
 =?us-ascii?Q?RLG6rwV83BhET/mzNyHAZdUHeQ9IimcKkV+2e5paoS/nQEC4VCSDreFGZJ6/?=
 =?us-ascii?Q?7cap5am0QCGwghqD938ajZsPRVbct2A50F61E0BXfr2OU/8Ak1q5sgh8pBUu?=
 =?us-ascii?Q?CfLCKOP3JWOVaqs5jQ0+XcNLd8Vh7wCh51Ucv/a0cXw+9jL9NUgNa9xmsRcc?=
 =?us-ascii?Q?/C9a8h9gs8hyq4Iwy6Ecm8/cmjd9u20inAX0P0U/Se4mVjHn+9gYiJJ+Kqye?=
 =?us-ascii?Q?o2HJW4X0hl9kAydkJ1LpaQOKO0VWQbdxE0Jy1xJS4B+MjDbxsx6jNpq3ucnn?=
 =?us-ascii?Q?1JbmsAumh6TABu33LkJfAs1uKiomr9RDTfm66ncylOzHB0vpecFnpCnxv7bx?=
 =?us-ascii?Q?Cula4dTr7p9WTNI9qvEAdbT5KYlTFhmy59ogfnZva4GzmUtW4c/57MtTCnmv?=
 =?us-ascii?Q?RQ7VZfahHpDEiJGATb9TnbaJNVxJYu/benWtZ50VfnsbZW4zljZCE3Js3njV?=
 =?us-ascii?Q?f85Sti5Bd/GxNRrrKbLkbDADVIackQltA3npf0jEROPgbl4SOCg5uhLxWKI3?=
 =?us-ascii?Q?fYpinyaBsUTmvI1NIk1kAg/hAxN1f9r7IT+OQpu8ia0tjYi6pjjeIozjSZeW?=
 =?us-ascii?Q?ATN/wqvywPwe2pdZqamQb04gCSk1lJeXqXa1L6F/hXSsjUvvYAev5CdzfVDJ?=
 =?us-ascii?Q?BJ2YIOSmqb06SeMJPl3QKgLDMCu/W8jLyLT8fr39SOBDE0VztJlinm4KxH0B?=
 =?us-ascii?Q?ehuLHyNdEHE6Pqv5epHRKYPS0jT9sEYK4D/hjKHAq4lGkmnvTG0AgcDZCBPI?=
 =?us-ascii?Q?CV9aGXuFgvVvdU1Cl0KKk1jiKa0GRohtdypt//iORZKY4yv3ZPqhseLVfO04?=
 =?us-ascii?Q?edbe3ExbnXZiJlHmJ7upISVz195CICBhvL6DyF7lLfFipD8ebRcXCrHI+CF1?=
 =?us-ascii?Q?vpwILuUUjpuAl+sJ+vtw/R+4db1G75qo9M3TihwTzGH+g2YD8vzqeT4v1w4L?=
 =?us-ascii?Q?Ud9XLnclatbWa1HCwe8sMRsSLmZCq0kk64sdoM4rPJnxmW+kNMlEGa7uwHdq?=
 =?us-ascii?Q?aZPkwOl3qQLa7C2EJRGXIoNyMMSs8cI1aSQTc5HadTm7o/iBi2g7bTyvqcHX?=
 =?us-ascii?Q?/W56lMSgXsMs72si8lc87UrF9HOAA0ury8OdpsM4DBnyH3FCRlyaOGjybGaM?=
 =?us-ascii?Q?BRhClBkzi2HC4/baGwLUhwDjVWdCg8zuhVNa88/fJDEJRvtLFQHqaI15DzoH?=
 =?us-ascii?Q?XT4p4Sh9xg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4530.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a4987b-d706-44d7-3660-08da32030705
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 21:29:41.0263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3azeocFbJJrzUjpAv2w4E+y1IvCW/mO2uWJStbbBU7Y+u4hqFuq87reYg7BtQUlXKLlId6JqXUz/DwawFyRsqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1801MB1893
X-Proofpoint-ORIG-GUID: 0Fj7mbNa5aTahNzsZZ7GjUsEvDbOqxmt
X-Proofpoint-GUID: PQS4jgfCwLnIxJZ8ECwovUqYtfqgwJzC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-09_05,2022-05-09_02,2022-02-23_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Agree.  The "11199E50_6128D175h" of 64b CRC Check in the Spec also is the A=
E8B1486_0A799888h with bits reversed.

Regards,
Xiaoming

-----Original Message-----
From: Eric Biggers <ebiggers@kernel.org>=20
Sent: Monday, May 9, 2022 1:37 PM
To: Xiaoming Zhou <xzhou@marvell.com>
Cc: kbusch@kernel.org; linux-nvme@lists.infradead.org; linux-block@vger.ker=
nel.org; linux-crypto@vger.kernel.org; x86@kernel.org; linux-kernel@vger.ke=
rnel.org; axboe@kernel.dk; hch@lst.de; martin.petersen@oracle.com; colyli@s=
use.de
Subject: [EXT] Re: [PATCHv3 06/10]crypto: add rocksoft 64b crc framework

External Email

----------------------------------------------------------------------
On Sun, May 08, 2022 at 12:01:21AM +0000, Xiaoming Zhou wrote:
> Hi Keith,
> For the polynomial you used in this path is 0x9A6C9329AC4BC9B5ULL, =20
> why it is different than the 0xAD93D23594C93659ULL defined in NVMe=20
> command set spec
> 5.2.1.3.4 ? Though the crc66 implemented in this patch can pass with=20
> test cases defined in Figure 121: 64b CRC Test Cases for 4KiB Logical=20
> Block with no Metadata.  Could you explain the discrepancy between the sp=
ec and the patch?
>=20

0x9A6C9329AC4BC9B5 is 0xAD93D23594C93659 with its bits reversed.

0xAD93D23594C93659 maps the polynomial coefficients to bits in the natural =
way.
However, writing the polynomial in this way isn't useful for this CRC varia=
nt, as it is a bit-reversed CRC.

- Eric
