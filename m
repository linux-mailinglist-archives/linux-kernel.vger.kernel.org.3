Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0C44CC062
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 15:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbiCCOxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 09:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiCCOxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 09:53:06 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C69518FAC0;
        Thu,  3 Mar 2022 06:52:20 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2237dNYv016451;
        Thu, 3 Mar 2022 09:52:05 -0500
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ej3m97ndh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 09:52:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtF4Wl2yQigBEiOLvDCL3QcO/6skiGYZRn79zyq2ljC9wdmf1u9diwlF3I8TCT+Y3e8XQrWKcSaWYBQ2imvEXkRFhvlWDS8qSntllSpOREZWH2fWjefzFIw/Hca4if3Fe0U3JffoFj/K1b+n0JKDlTUddNo+zUrriDYZwKmT3Vgc92AfoF3U12P9g0TjMqpeSSjopi/lO7d4eqgXJko+hffO9P7t3CoAHTlA8qLziQUVt65JKzbH+UwB8oQqHBnYCFzqBCDZHMoPzXqr+EyMPILmdJTf0VG2A5gL/AlbSWWNws7ErK5FSvsKg1nhD8DWSQlmcWflsDxMfcFNTBKGPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIz2bPOrTsFxMSBnp44tCXnygmwG5TBY0tYXVwcJ/Ko=;
 b=MecBbDKSJ2cscKRF/1O98SmTqe6JDKfFyrf+Aky7YMd100dEIBRnatrpYyMn9anYjzh48tq2mwh4rZTOLYujZq4/sD7baSXBMpgk7OHvkXJ9g6cEj8AGLSCKcm8GsrXov1RtpzhRlwvkNq2C0yl8tYfW4N5EPY1NBRE5QMmjspi9hNYUxVbiGgyM5UORDFXrn+ubvnE/8FtSXVFmNd8Nf5i4RTjlgqHqU4tGY9bKv/BLL7Rw63KzKykauFui6VP0FAP3gA8VBh6YFoIBYbjMs3sJPHcoa/NVynr7tLXHNlzMZWmQNHWkSnsTX7/XBW0FXZMvE6GcgY1ymx067Ko/yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIz2bPOrTsFxMSBnp44tCXnygmwG5TBY0tYXVwcJ/Ko=;
 b=Aldd713VhLc+EdYuPaW2M/KLMHsV60YSmsUJ4eJbJagg1bpf4lsSpi94HiN1IFfwBkFl5Hk3/WJSpvEdoCoUgMDFdB2Z5X3CCCaKMgdV4Do2D+OIzSCPBMny/Bs+TexXVf/WJj1tCAW6xj5yf4p4cwDsLxd88X+vdgsKojzsZ44=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by DM8PR03MB6309.namprd03.prod.outlook.com (2603:10b6:8:3c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 14:52:02 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::dce:606f:6d26:c794]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::dce:606f:6d26:c794%5]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 14:52:02 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH v3 3/3] iio: temperature: ltc2983: Make use of device
 properties
Thread-Topic: [PATCH v3 3/3] iio: temperature: ltc2983: Make use of device
 properties
Thread-Index: AQHYHoXV68rIrkrTnkK2YIykAkr2haytxoqwgAAQ8ICAAAEDAIAABmPw
Date:   Thu, 3 Mar 2022 14:52:02 +0000
Message-ID: <PH0PR03MB6786BB15A610F54B595A681699049@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220210135522.26562-1-andriy.shevchenko@linux.intel.com>
 <20220210135522.26562-3-andriy.shevchenko@linux.intel.com>
 <PH0PR03MB6786304A458CD4B11AF5C42699049@PH0PR03MB6786.namprd03.prod.outlook.com>
 <YiDPZbHkwABl2GBE@smile.fi.intel.com> <YiDQPm5ggtjl1JmX@smile.fi.intel.com>
In-Reply-To: <YiDQPm5ggtjl1JmX@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctN2EzNjIyZTQtOWIwMS0xMWVjLThiYzctZTRiOT?=
 =?iso-8859-1?Q?dhN2NjNzEwXGFtZS10ZXN0XDdhMzYyMmU2LTliMDEtMTFlYy04YmM3LWU0?=
 =?iso-8859-1?Q?Yjk3YTdjYzcxMGJvZHkudHh0IiBzej0iMTQzOSIgdD0iMTMyOTA3OTI3MT?=
 =?iso-8859-1?Q?k5NDU1MzMyIiBoPSIwUXhEYjdGODMyOEhXSFFJOVRsdnNLTzZrK009IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUJrbUk0OERpL1lBYlNsdzVxS3NjcjJ0S1hEbW9xeHl2WURBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQVZJRXZvUUFBQUFBQUFBQUFBQUFBQUo0?=
 =?iso-8859-1?Q?QUFBQmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0?=
 =?iso-8859-1?Q?JsQUdNQWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFH?=
 =?iso-8859-1?Q?a0FkZ0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQV?=
 =?iso-8859-1?Q?pBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0Iw?=
 =?iso-8859-1?Q?QUhNQVh3QjBBR2tBWlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZUUJrQUdrQVh3?=
 =?iso-8859-1?Q?QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZBR29BWlFCakFIUUFjd0JmQU?=
 =?iso-8859-1?Q?hRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7204756f-a1bc-4d75-64de-08d9fd2560ad
x-ms-traffictypediagnostic: DM8PR03MB6309:EE_
x-microsoft-antispam-prvs: <DM8PR03MB630921BD17859A901980E37E99049@DM8PR03MB6309.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 95+Ovr79/w8un2VJy4qdjFbYv5co/lJpX/HCyDKIEdhMEWvTOQOLIOQgVFxALr6GwEA/O1ngHaK56jSWKkReZXsX3XlYBDHCbnDB6h7ySyyZUnfohcmbOHuUIJCCLQPumKbpStJDwVUSMGVFkjjL4syZxmjimHmw/UU99BONA4AOfBAA15LLx2SvyVpCrzaB9f7MWU0kmeIhM3UWkfbFcDPyhxng36HmS4+TFS7YGQQrmKIK5XaQ/MvqZloMsz5ZKPs2LzOrcxP+RpDzt+iQdKfSkuBzqhz+EFXw31uKM1TipFWOAgrbwKghI3r6HKcTxKDaziAx2ilTmB4RK+cAqSbZ0HO2N9BD8vSHilJfxCbd2IOw7vxoi3ErbNj0w3EuRNQ+cgc8oR+kaJDtSuQbtu8bsBC81QXwd2p8wL+52CW3HtC6c3FoEY2aJ9n5ThGA8c1lIAJf+bkI+ht5XymhahgVG53GAGInhb8X6A2NqaR9O6zwrhOpLsaaldP2AB4Vtj9RTOxRf1QaTqTZNiq2cOKERP0F+bIbKqP9XiORIVL568cKSrnB+YBjfAUmYgxxcPJ+VaEsRkDQn67Fqex6NiR2QCc8H/9dG4nJs3SU7tbSd0ookK92ne8nIbbtISCar4zK188fgVeWX/5Kum6bfw3+EvOeTBAfbtxniimzLAN3Hq0oE1iLdNUcLiR+uLPgCF0/t8cdl47Zb+JSpRAkvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(66446008)(52536014)(4326008)(8936002)(64756008)(66556008)(8676002)(66476007)(66946007)(71200400001)(76116006)(6506007)(2906002)(508600001)(5660300002)(6916009)(38070700005)(38100700002)(316002)(53546011)(7696005)(122000001)(83380400001)(9686003)(54906003)(26005)(33656002)(55016003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oCIkYyDrJidd73UAsnbaHdOFirHv8LsD8ZOxf1rfZ0Uy0YcdLT1MvmJ0G4?=
 =?iso-8859-1?Q?PsGvVQx/lYyzsEXfGPtL8J7GANeKMRbHI74RejfsDqrFmchtWFgZVR84Gb?=
 =?iso-8859-1?Q?Nubz8UzkDEqmmBcJXjd1Q8g32DAFtSQo20ZqOtFCH5RKHAA9AJi1fAPelN?=
 =?iso-8859-1?Q?QVNhreAllcUvx6T/+4A0GHXJW/1m7aGWKyuexUM8EZWZJIdGwo2j3i9WAH?=
 =?iso-8859-1?Q?lPnhWVOrV2NNQVa/wYeGmg2c8dYoXDp+U1wvkPjeroWyGtoOCet1Cm5TgN?=
 =?iso-8859-1?Q?UU+zrvCGnxLgRlMhjFswxJRWFnwD4QNQc7bSkUJ5c1tb9bK0iYFXNORe0G?=
 =?iso-8859-1?Q?1M/DhOOYzi65mDXkjo/xfqilPs6L7jAwMat4AY7+SK6rPMi33cG9Y1dtBp?=
 =?iso-8859-1?Q?1RwTy3y19Xrc/a2C/NdJCPez5wMmf+40pmkGRugb/6WmjuOCQAXEGGKD0N?=
 =?iso-8859-1?Q?fR7VGb6gGvxggEWTqRBpDq0Vn5BPrL2t/EV9Z/uCV/BYNf2t+rJSjkm+eM?=
 =?iso-8859-1?Q?M6wFx5i3bHHQO+vkgDaZhDdmx4KxiiygIA2xVjMGAOwlJqNGdTQ8Aqluc5?=
 =?iso-8859-1?Q?SP3IoM6qUJOzDDZzvlOS/KqsV2lapqx9pKQ3e6Ji0taDAUEsswoSE3Glb/?=
 =?iso-8859-1?Q?N3dFFPebSViToB8R2+X7dyRZKvr87mf4u5lGe9OhkHt+F0+7FNMGVnBF/f?=
 =?iso-8859-1?Q?e4WR8CJcxqTGcU/OXRt/wbm1y43tQ6AJTk3fZrnr2Jz9vrzC041wNt8NTw?=
 =?iso-8859-1?Q?UehpcfKSfVBq7X95BGlxhrw3e+hpM/ng4ajrx6cpeXTwXFA5euG0nZMWro?=
 =?iso-8859-1?Q?cJqHjoDQlS5CDMN9qBfyxWTAhndw0n+Cq+XnQtaTJXM4piylHfxnVS6lRF?=
 =?iso-8859-1?Q?ReqL6lM97iWPJ45Jle9cXiaq2rd+ObOORxD2Y3yOpDVQ+uU8sX5OIVAe4E?=
 =?iso-8859-1?Q?yBIBnvANmMPISV594pvdk5rzIa4auHXopoLBDmt7C6DuXfDkfXbhB6bYCa?=
 =?iso-8859-1?Q?/PSltCgX1BlD/6bMU7819bjpZYsSiGocvfDLMR8AKa+YZ7lJyyUM/NVarn?=
 =?iso-8859-1?Q?3CkrDKcb8sf/moo8NR227aS7COHa5AuK1nHoHXqZZ0pev+vsuzReXPwiTY?=
 =?iso-8859-1?Q?xwFq+Cu+YH1ArW4J0cHWwyFEUsaoRc1dYJdhfQdy/M6Cics8S3sNIASRpp?=
 =?iso-8859-1?Q?LbqUuwv6UL+lWAKclG6Btdktq3nxx8zn/5Dry6zkJP46/nbAGq7A/DsIqg?=
 =?iso-8859-1?Q?nk95t/5OALNIth9R+Txg6BOIy4IrCheUK1GHPUPr20Vk331P6N4E9wPyLR?=
 =?iso-8859-1?Q?N/x1Ej5ODX2GySppKVZhDG2mMy3yjBqsCESpytwzygsUG/CmZGcoP+4CXM?=
 =?iso-8859-1?Q?jhR4jsq/mrkpn5ZjEdo4YMNQeivmWoTKdLjO02i4hw71DCJ8VUB7tV7BO2?=
 =?iso-8859-1?Q?dd1Uej6LPJY+hrWWGfNeaTqeRRZWEyBm28GTgbzzKB2YOZo76hihJv3aOh?=
 =?iso-8859-1?Q?O7o0TxIGsyGaIDRUkYIxhzbikEd863N70P1ILrJzTXbgxKBetsu9Z25E9m?=
 =?iso-8859-1?Q?wxW6+b1bgO5YEdVONMpCnbSKfj+EfXyzaGojQj4y+z7fu5hutf8a9PINe8?=
 =?iso-8859-1?Q?qnnW9aNFqiaJ/qrexriB5dBcgXkdQDx5JY4akwlVIu6GuvAQeURFCS9A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7204756f-a1bc-4d75-64de-08d9fd2560ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 14:52:02.6604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RxVK9jI0eymzdnkyaeKYMJZm+s49caYPa8Q0qaAt0HDkdU9cU9Nu2Zp/XmdPx8+PmHOgxlj0IVtr+3X9qVPA4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR03MB6309
X-Proofpoint-GUID: awflogMtDMAYGTJgIXmqtP-FLx_DTiy5
X-Proofpoint-ORIG-GUID: awflogMtDMAYGTJgIXmqtP-FLx_DTiy5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-03_07,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203030071
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Thursday, March 3, 2022 3:27 PM
> To: Sa, Nuno <Nuno.Sa@analog.com>
> Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; Jonathan
> Cameron <jic23@kernel.org>; Lars-Peter Clausen <lars@metafoo.de>
> Subject: Re: [PATCH v3 3/3] iio: temperature: ltc2983: Make use of
> device properties
>=20
> [External]
>=20
> On Thu, Mar 03, 2022 at 04:23:34PM +0200, Andy Shevchenko wrote:
> > On Thu, Mar 03, 2022 at 01:31:56PM +0000, Sa, Nuno wrote:
> >
> > ...
> >
> > > > +	ref =3D fwnode_find_reference(child, "adi,cold-junction-
> > > > handle", 0);
> > > > +	if (ref) {
> > >
> > > This is nok. It needs to be 'if (IS_ERR(ref))'. We then should return
> > > ERR_CAST() in case of errors inside the if block.
> >
> > This is a good catch!
> >
> > > As this reference
> > > is also optional, we need to nullify ref in case we don't find the
> > > it. Otherwise fwnode_handle_put() breaks.
> >
> > No, this is not correct. fwnode_handle_put() is ERR_PTR aware.
>=20
> Oh, the ->put() handles that, but the fwnode_call_void_op() doesn't!
>=20
> This has to be fixed on fwnode level.

Yeah, it was crashing. Even better if you fix there...

- Nuno S=E1
=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

