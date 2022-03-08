Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672D84D14D8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345880AbiCHKdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345883AbiCHKde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:33:34 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119E61022;
        Tue,  8 Mar 2022 02:32:33 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22893jA0030453;
        Tue, 8 Mar 2022 05:32:28 -0500
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3em2k9xe7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 05:32:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=muWs0I9C6jPbN/uPp/nrj1+NMnJMobhm5RpHafKmoGgJJ7g5kghuEEUWncVytztGiDoaCOAdeaOe9/MtP6DIeNwDj9tfGtSGZi3p/ehqRxmDF9PcvX0mHwh6HqwmmMjpvR3lKhiU74qqxXoDbAmcIhWGPco5x4yy+WkIIcYL+hkPnupwlH9OanSKATfp0XZgYUytILCk9hsm9gwFiqa/LTl+FxIqPrZl+8qs5+TasilLUebZSrpX1r+lmASvIZxpxuj0U+6v2JPCIe/cdKCUnz3PVQMwfmPlQKcDbKWoxM2sFIZESWNKagBba9cxlzHtvySEkf13qKjm3mW3FwGQ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=840zVMwkyGcflEgcPOSfVn5Ap+6q0q21ysllUTqiZ6I=;
 b=SvKzx3A1DkcqzU8MrSB7HE1NZsk7ezDiU18et+/3G6pmfguq3ycQcLL12sl4ZRK3YQQ9/+C0PMg5JlbjSb54OKyOFd88w4GH/l/5rvxQXKG3Y+VH2sVxrcCNmT2PZV+EPVvdjushCcqd2i2pd2tYrP8WtoFmmVMCe/aRXMiG90ykF+XxEHFsXAqf66mRQRTq2t/B5cryVWFUnUNEGNEZqCpErK4pT3RlJ3KuKc/pT1Nep8Wqu4a8caCNutzWtia00D0YiXJnCJa1ySbuS0zRWZ7Jus6yohO+cPa66DIXA3890BnyFyDfPi24o6WFNfYjFgi8WO4moPovKk5/GqbBEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=840zVMwkyGcflEgcPOSfVn5Ap+6q0q21ysllUTqiZ6I=;
 b=YaSEvzhkF830F2lA/ugAbNeDl/bymbKGWt6CE/xMduwiP/Wu5HQMBEL4mkH6OTqPDbjavkYyFv1fgzqukcVM0z0ZadhlEJgqTLi+6deV3Ysc8THEQh8dlmQoUK3X0TDoDTyHHfu3Dh4hla4P3so9NDm3owboR3EvTIvkj98srPc=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by BN9PR03MB6201.namprd03.prod.outlook.com (2603:10b6:408:11e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Tue, 8 Mar
 2022 10:32:26 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::dce:606f:6d26:c794]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::dce:606f:6d26:c794%5]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 10:32:26 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: RE: [PATCH v3 1/1] device property: Allow error pointer to be passed
 to fwnode APIs
Thread-Topic: [PATCH v3 1/1] device property: Allow error pointer to be passed
 to fwnode APIs
Thread-Index: AQHYMmIeiO1ypglm0UKwY/7o4sN2wqy1NheggAAOc4CAAAYRoA==
Date:   Tue, 8 Mar 2022 10:32:26 +0000
Message-ID: <PH0PR03MB67866622F82D3F363BF12B5199099@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220307202949.75300-1-andriy.shevchenko@linux.intel.com>
 <PH0PR03MB67867223806C29FF1DF90E6499099@PH0PR03MB6786.namprd03.prod.outlook.com>
 <YicrcRUXVKzETq+l@smile.fi.intel.com>
In-Reply-To: <YicrcRUXVKzETq+l@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctMGFhYTI1ZWEtOWVjYi0xMWVjLThiYzgtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FiXGFtZS10ZXN0XDBhYWEyNWVjLTllY2ItMTFlYy04YmM4LWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhYmJvZHkudHh0IiBzej0iMjM4MSIgdD0iMTMyOTEyMDkxND?=
 =?iso-8859-1?Q?Q2MjkzNDI5IiBoPSJwUUUvRW5EUWRuQjl2V21qa0VneVVObktyWjg9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUMxc3dMTjF6TFlBWnd2aUhyWk1scjluQytJZXRreVd2MERBQUFB?=
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
x-ms-office365-filtering-correlation-id: cfa35ea7-f143-4696-24e2-08da00eef09f
x-ms-traffictypediagnostic: BN9PR03MB6201:EE_
x-microsoft-antispam-prvs: <BN9PR03MB620100499FBB6BCB019B636F99099@BN9PR03MB6201.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vVyrALvrFq1eNwKhAuijkZaTEO/DOq63T1MOjOnOOTUEjLcd2iV/GVaKc6OBi6cMEvUbqnQOD+7K1hl4Td6VlZ0z/beFIja94HrLmKv5wg9+HBRptVWExOH1sBrs87//36gTVF4rO6wlnQsysa0zJe+NIluap6Tf6ziewMHgpi/GWCzsi4H2upN3NnouVGV+206pGxoz628Bo/PQkEkwXn/So6TySy0zgBZ6Aq/T3Rgemo1lowSR32iqiu4lu+7OfwjaUpYDIGAnypLCzrqImNeeV1lK1boUBO2k22t8pgCQ/Z36Ff73zLG92cM6707NnwqoIJglvtUXJbdPCA1RDHGJST2j5F5gS6ujVrpkhjB3Yy7wGtuOJImIdiXYHxdX5bHNkpwpA440iAI0Jy63/EcdRGMTin3aQHk9F01Sh2nMRHBOQ18DPtiEJ6yYlfVqQnQnj33lnpdwzrPCHaSx0J+DJAzlvYgCtN7e9haFU45V/EoMiv9T8HM7W3Vu6QjIAhTFNCphGkjrNf2vi+NVtBbnvpSSim06Wy6rqiQgo1rnDPGLyxShCa8nFzyx1/jSPS0tSECaQiaymFX8gKfLRSPAqtgavXOhcL8+Pn9I7ShsdmlqQFxHSnDqgkgwS5dwJGn35ZsSbIANhpaFzBSIJD+D23uGy0DTir8awbQWzKTTkoEX2R2IkR8E6RP84XeBuQXhp/YY5OFUbQ/Lsgh+2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(52536014)(55016003)(38070700005)(6506007)(33656002)(316002)(9686003)(53546011)(54906003)(7696005)(6916009)(76116006)(71200400001)(508600001)(186003)(5660300002)(83380400001)(86362001)(66476007)(66446008)(64756008)(26005)(8676002)(66556008)(4326008)(66946007)(7416002)(38100700002)(2906002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?enaRqmBcKdk7p6JMmi8k43M6C/7/GBaJ1pdM1rkrRxti4ZaO5ytJxIEbSC?=
 =?iso-8859-1?Q?04ZxYnAFpJ65hNiBFNG7Ufh7AZJoU8is1jJPSNrPYb/sd3Hne/t3z93rc1?=
 =?iso-8859-1?Q?yzWiQi5YViDN2t92YjJbLm2U5o19SYny5nkJljeR7SxHluyxhrSKqXVr4f?=
 =?iso-8859-1?Q?pFdLp13tKZzPaEeprt4iGUG8z6PPY37DZFPFGQPqLa8uVW98r1ar6H1uTC?=
 =?iso-8859-1?Q?P4+RVnKVawdQMBQ7nQMcWdlxohRc+p/fuTt6PwjeLleqTEjXC1/Nm9OOJl?=
 =?iso-8859-1?Q?Txq7DGj7cT6vX2dsTUEUsVrZEVsTLR3fcSzOo31UhZ7p3o/w1CKoB3Na+q?=
 =?iso-8859-1?Q?wLwbIQv9ruRVQr16+QZPcMmLn/0yvVlvpDyeVky0Sx2uiPxEtROov9rLNr?=
 =?iso-8859-1?Q?C0hq8m783Ta6EXuKHSNMk3+qZ8okYgdMsrfC3X8rP8LsAKvTC4ea+28EW4?=
 =?iso-8859-1?Q?LqFPOJF3v1243MO9OC7hTY0v34pLDwoL4eA51aBROn7cRSf7axJzQnSD3p?=
 =?iso-8859-1?Q?Klm7tUfq1Kb+1/ezJ8HJCYhSu9EESdcd+aLHPs0Rxxy4BQrbjizioW/Kd7?=
 =?iso-8859-1?Q?6gA50v992fJgERSpzYXDIR9Xguy9JPwZKphgbuM10wFGhEZM5wi3gYu5Qh?=
 =?iso-8859-1?Q?SUfXXUzvl7BOX9zAF4oHyctd9JMb5v0fXAFUAXlB5IFsA3M15UFFAD0Y7k?=
 =?iso-8859-1?Q?jcNID/OQZFKZ36A85q6HSpdfDC2/BHYdXsbdGkuKAyQHCfkRxo0lXBImHS?=
 =?iso-8859-1?Q?cdQAtqb5fZzG4D3r1IjGR1D3szMdfYaZV2xHHgCK/WnrCpNANizjocOKne?=
 =?iso-8859-1?Q?RlEjzqNiOSfnC0UOskhhuT5PZS4iqzNWyeq7vmIKVzAIwuYHDW+hIHC8qZ?=
 =?iso-8859-1?Q?sOXzk4X1Z/3bMzkqTx/VV330HycNm4RRUWYLFrhfjgT/Qir/0TcxEeV8KU?=
 =?iso-8859-1?Q?Itz8vqURtykO5D7uBqANJil3ASqeLlQNnVeOht1GuEL7aQO/z0Nx4VMGaB?=
 =?iso-8859-1?Q?BcUUtxG7usQF2trsDr2tMXJJXPMtNr/0oN2QCRvIDnh0u51hxmawBxeW/K?=
 =?iso-8859-1?Q?sshJJYxAsdZh6hI3Wf7Tlsy3mh2B4NaCVXBLfXg59BLA2MKXK1t6HosWaj?=
 =?iso-8859-1?Q?lYV1ducX7DcVnwE0sbptmIFZ+Uwo11LSyud7kLUxT32urIeUXHM7Zlw6qW?=
 =?iso-8859-1?Q?Emx70xrkng4W0UkwNlo3Ow76U1m+FeBQy0n7rhHGenyLz/BAhtW+GS05hI?=
 =?iso-8859-1?Q?pc+obtCPLH8BGnKhP8T8gjOawN4VqllF4wcOHuPxd4bdk0br99mRS79RJj?=
 =?iso-8859-1?Q?QX1tBsU41O9jJiBErsh9Xm3N+dDnLu6o8DCNNrp3s/F8xB0C7KJdDhWh3W?=
 =?iso-8859-1?Q?yzjB02CNs5Vfl/+2SQAv4X3MhQVSvVSDUGWakUCvUvQe8+NipcKGNHLI2R?=
 =?iso-8859-1?Q?O2CM8gL0PVoUIARSzXg7qB1Fe82F7HdA6uNY/l9ze3mZMtzB93/dJK8Xvm?=
 =?iso-8859-1?Q?u8g2cCIq8IOUJspJE47QsINEk/5G43Ca2q0JznmRKNAUIcHQRiE5PNc/VE?=
 =?iso-8859-1?Q?eX677XAGi3ljbGZS03JRMyywbDOWanfFP6PclTyqIMiYllCRXxxFQG1BRP?=
 =?iso-8859-1?Q?IxpkhMz0zXgdwzXGtHYzwgCteVGZcBC6otlUZzjUgfE0iyq51Hu7CH7g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa35ea7-f143-4696-24e2-08da00eef09f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 10:32:26.4117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VgILBdfCtVbACkLET0ovaW2L6Uga3tQ1sDADZ+9f0emXwxA/Z+opba7H8KBY4NjD9jKj1tm9XY2hI4/S8WmSJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6201
X-Proofpoint-GUID: oQwvpFRvOdLk0rWYlbYHtcf69laSrJjy
X-Proofpoint-ORIG-GUID: oQwvpFRvOdLk0rWYlbYHtcf69laSrJjy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-08_03,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2203080055
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Tuesday, March 8, 2022 11:10 AM
> To: Sa, Nuno <Nuno.Sa@analog.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>; linux-
> acpi@vger.kernel.org; linux-kernel@vger.kernel.org; Daniel Scally
> <djrscally@gmail.com>; Heikki Krogerus
> <heikki.krogerus@linux.intel.com>; Sakari Ailus
> <sakari.ailus@linux.intel.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Rafael J. Wysocki
> <rafael@kernel.org>; Len Brown <lenb@kernel.org>
> Subject: Re: [PATCH v3 1/1] device property: Allow error pointer to be
> passed to fwnode APIs
>=20
> [External]
>=20
> On Tue, Mar 08, 2022 at 09:25:07AM +0000, Sa, Nuno wrote:
> > > -----Original Message-----
> > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Sent: Monday, March 7, 2022 9:30 PM
>=20
> ...
>=20
> > > v3: dropped test of secondary fwnode (Nuno), added tag (Nuno),
> > > amended commit message
> > > v2: adjusted the entire fwnode API (Sakari)
> > >
> > > Nuno, can you re-test this with the ltc2983 series to be sure it is s=
till
> > > okay?
> >
> > Still works!
>=20
> Thanks for confirming!
>=20
> ...
>=20
> > > @@ -988,14 +998,14 @@
> fwnode_graph_get_next_endpoint(const
> > > struct fwnode_handle *fwnode,
> > >  		parent =3D fwnode_graph_get_port_parent(prev);
> > >  	else
> > >  		parent =3D fwnode;
> > > +	if (IS_ERR_OR_NULL(parent))
> > > +		return NULL;
>=20
> (1)
>=20
> > >  	ep =3D fwnode_call_ptr_op(parent, graph_get_next_endpoint,
> > > prev);
> > > +	if (ep)
> > > +		return ep;
> >
> > I might be missing something but before the check being done was
> > 'if (IS_ERR_OR_NULL(ep)'. Is there anyway for ep to be an error
> > pointer? Looking at OF, It seems that only NULL or a valid pointer
> > is being returned. Did not looked at others implementations of
> > though...
>=20
> Yes, the IS_ERR() part is redundant there. I was quite confused with
> that code while working on this change. So, now it looks much clearer
> what's going on and what kind of values are being expected. This also
> justifies the choice of returned value in (1).
>=20

Makes sense to me.

Acked-by: Nuno S=E1 <nuno.sa@analog.com>

> --
> With Best Regards,
> Andy Shevchenko
>=20

