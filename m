Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2457487976
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 16:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348037AbiAGPCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 10:02:04 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:39540 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348009AbiAGPBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 10:01:52 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2076TtG6032285;
        Fri, 7 Jan 2022 10:01:33 -0500
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3de4uyau7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jan 2022 10:01:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjQNqCy4bzw0G9psextwcm18ZakGBvHVa0K7D+ifrLtp79P8YPoG4jRRIrhtNk8lNJtmYrUZvqNrUZ6refQmwMdLeIm/3A7xMHpu5Nn3PpGeVdmKT/9DsYNM+2UDZ2n+YR7As1G82P1Uej3V0+hRWqUpeDq+76LwibrhCR4G6mEKPOqAmxvtPX6Sm7Imf56A+IyFVd7qZEebFXHRoeNudxmo6JPi+m+E0tRlLf38SgeM8tqm1UB3zc2XNkq8JuoJFNp79DdgjK+9pPV3FOfplCegjFDAGkTavQm889kHzt7wDFUodswLToEVyIKmqzRvg/NCvffY8ZjH8dF9vIxRkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDPLjIYkxQCk+k8tvg/Dn17uaHzC4ymMnCzaG+ssZBs=;
 b=aJxXa2vSHBNg6z3jcH2oQszmhYwVsaagcc5twCp7nAPMT+F/MrmHXVGxmU/HnKp2bVLx0bOjRdCxbRbjxmGjILjWMfu3wsHG0/oYZsWfYa+dz4wIoedzgq1BRGjYsAe8Eu1b5JMv7i+GCraG0cOUQFOdtaACLHin5W4DJZf9fBXjxdf+eu/foiReHlQcLyvyWCJ6R+brAMCTMloCS4t+dJbPErCm8Zhg0lO0azYDJW+2KcBLkjCwqC0CdFjxCMNy3rZTV1VxtdX07iXNuA54QQwTlHIAc9LUiRtSUXuF1ItUEnPdibEvoTm36oQ2R+rHlZ54e+diRypxYPWRC0i63Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDPLjIYkxQCk+k8tvg/Dn17uaHzC4ymMnCzaG+ssZBs=;
 b=TUcvZ2jNfUSvc0IvNvJqEtqRVP2Jxv3ZLIVfCOkQKxyNVklm3icY023P0c/UMJ1tG2iTAKMzaqzoxgPtwvVizG8QUZJvYJZZ8QSAab+EiLAufeI3KxBx1quxF9SqpxA9XXyWakB/ynNPGXpKYz3fXWgImBEbDqRv/1e4XRQY4AQ=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by PH0PR03MB6494.namprd03.prod.outlook.com (2603:10b6:510:b5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 15:01:30 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::c5c3:7910:36e8:73a5]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::c5c3:7910:36e8:73a5%5]) with mapi id 15.20.4844.016; Fri, 7 Jan 2022
 15:01:29 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Rob Herring <robh@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: iio: adi,ltc2983: Fix 64-bit property sizes
Thread-Topic: [PATCH] dt-bindings: iio: adi,ltc2983: Fix 64-bit property sizes
Thread-Index: AQHYA3WLKA0PDpwuYkujdvnCjsZ+HqxXp8Gg
Date:   Fri, 7 Jan 2022 15:01:29 +0000
Message-ID: <PH0PR03MB67866DD9F266C44A8B4CA87D994D9@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220107032026.2408196-1-robh@kernel.org>
In-Reply-To: <20220107032026.2408196-1-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctYjA2MDRhZjYtNmZjYS0xMWVjLThiYjEtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XGIwNjA0YWY4LTZmY2EtMTFlYy04YmIxLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iOTg5IiB0PSIxMzI4NjA0MTI4OD?=
 =?iso-8859-1?Q?Q5Nzk2MjkiIGg9IkQyT2JoeHphQS9sUTJmcU54YzRZYmdoUEVVTT0iIGlk?=
 =?iso-8859-1?Q?PSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQU?=
 =?iso-8859-1?Q?VvQ0FBQ3RqN2h5MXdQWUFWU09rN1J2cFRwUlZJNlR0RytsT2xFREFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFFQUFRQUJBQUFBVklFdm9RQUFBQUFBQUFBQUFBQUFBSjRB?=
 =?iso-8859-1?Q?QUFCaEFHUUFhUUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQm?=
 =?iso-8859-1?Q?xBR01BZEFCekFGOEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdr?=
 =?iso-8859-1?Q?QWRnQmxBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWk?=
 =?iso-8859-1?Q?FCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBB?=
 =?iso-8859-1?Q?SE1BWHdCMEFHa0FaUUJ5QURFQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVlRQmtBR2tBWHdC?=
 =?iso-8859-1?Q?ekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dCdkFHb0FaUUJqQUhRQWN3QmZBSF?=
 =?iso-8859-1?Q?FBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21ldGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58781cc9-d002-4028-b53d-08d9d1ee960c
x-ms-traffictypediagnostic: PH0PR03MB6494:EE_
x-microsoft-antispam-prvs: <PH0PR03MB64940B9F9C4E596F0AD6DD73994D9@PH0PR03MB6494.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nCrHyho3UyvNROWeNAHtswpsvdY7ksgMfcumpDBbwm0nOZorLmcAOoDrtZHKv7SgOxNSg96JuHTCfNfiysRnEgxOABIcw6Zicra9Oh0+gybhheqrbXuG9DyUN57f/1Q2/I2QZh0uUnc4QLKkYJebtECoiTAcgsA9ErxkA1G3OzKELCeFezLjGtmhgjsymNyt8C2jo35vDaXmA7Z/CiQ5ig09fSu1cGNq5USTML93pHAH82lZg5FAHQHWB6n6LhqhX1aQYjRj5lJo9BdgzxVZWqIPR4NXQv8HitFAx1X17iNHOKOoH0+ax5wN18E8UrzV5DpMAy+PDnwd86fiBpN9y1C8nSBTSvdXD3Dar8wf6VRk0ZkMFy8OfF0j6VOzQsVRYA0v6XyBl2NyxuzlW6F/cuOR1/EEM+76i/4zFBEKjRpVNt/zYkA9xJ7BYk9EQM8d58ZgYqrTuH6c0k2YBtbVzCJDjY4aDznXIlU9a2VEYrm+q9H3Ev7d3sXZkWVR3PsBhjbF9MtlTPCQs6ecfEm0YCvagwoTqVDBFjjYDs69F53bVAcBTq8A4QC1FjhxYaBsSStWjg6TfJXIJjK2JbVwoBZ2fKiADioRw3li849d/poF7sttf4/UG/wug2NdrQhte/0UmwNkeOKWjVLZto7QQbH7AEZX9mfneL41Af5h+WXLWO8sjXLOjRKtZEBLqTaNb2BRfNSbWCbRKQSnPdXzLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(54906003)(110136005)(6506007)(53546011)(8676002)(186003)(122000001)(55016003)(2906002)(71200400001)(8936002)(33656002)(86362001)(316002)(38070700005)(4326008)(508600001)(66476007)(66556008)(66446008)(66946007)(64756008)(76116006)(4744005)(5660300002)(52536014)(38100700002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?n6T/MqBiIbLYoskSVRR32JzTtdHtiDrQmfFBcSvm9/c7TL7TueRrxUPyPY?=
 =?iso-8859-1?Q?dto84fespqkoFrcA8wq1RPw8hjYCFGHOvBqZkwbsGJoGhWdNFbKaiYADwL?=
 =?iso-8859-1?Q?xdpTLV5Fm8BxwotP23288RemUFh78vWn5u1CP/3bPuprWML5fHrHcM/Puc?=
 =?iso-8859-1?Q?ljIX4VWL63x2pyJ3eX96Mno+UQy50B8a+h+qZIG4MkAF/mjSRtDwq6U27A?=
 =?iso-8859-1?Q?evhrG/Y08S4hV69VMgubVHIPWsnxplrJibzk+2vC+RZawAWJxDdRONBFGo?=
 =?iso-8859-1?Q?WQZ9kdHZR1oZKDzlnGG5z4ZloihTE144ePJZo0vYGBRIe+IJACJHibkjBE?=
 =?iso-8859-1?Q?quwj9fc8f0iogw8tY7J5l+az4DplOhYKmj/A35bNPwWCHxBmTSAxvVWheG?=
 =?iso-8859-1?Q?vFINbS4qacmBYfouDChjkeCxAwl8S6x5JAyZNYf3GNQXA9dKtzvdZjuKkP?=
 =?iso-8859-1?Q?fFOpCayeN9J8KDKyfZPY2PzU3ijgd6eJ8qcDEFZ7ggnwMl3/QfWp/s2rJw?=
 =?iso-8859-1?Q?lkdRR/pYLG47GtVEnvrtQBn8ViNuzX5m3nIVZVteRYxBrpj/AjRyscMYSP?=
 =?iso-8859-1?Q?sgZo379S6z9paS1q1uOd98BUxwYQnkNYC7By5URZANAjsFFHLsvESVNeEl?=
 =?iso-8859-1?Q?B39j4GytDTrKPfDrDuR0IZeaomWT1OZYGvXC3LjjSoTnbjq1+FwHitvYvk?=
 =?iso-8859-1?Q?N7ocOkiA44AaEUIxx2A94tKFX2tFqdyGwFAZSzUevQjhSqyk9g9tTmoQxW?=
 =?iso-8859-1?Q?URkzN+Pjwiupwdm+mkBFYfecSWmgvZ6swp5ebMamaWhWV6EA9wngGjxVHe?=
 =?iso-8859-1?Q?ijU+Khrs+Qoxqk7NhxC1Lhj4GvajzLJoliQz1ycibhBS7MQoObduZAQLtG?=
 =?iso-8859-1?Q?0OMztWXPdxYlGAw/3dF+Ppy24jPzPRf5TdVqR5vR8imvGRLEwNWo20zgMf?=
 =?iso-8859-1?Q?pMyB8VjYr1XCPIUYWaKhyrTUYauNhyWundlGBBVF1Jdk2f+H2LuzbVGb0C?=
 =?iso-8859-1?Q?eWdxpmoxm4+ijexp6w+WcofEecygaQKo4ySoM2NY+k+13hfzssjt0Q93Kn?=
 =?iso-8859-1?Q?TlvQjQzSmumiLP3dAQjhJHp1AHR7/gR94ozYsDQUdW9LZGkg/53U6XKvQL?=
 =?iso-8859-1?Q?+u/Y19AAQnhNvS3aqqPguXPCeJdhBFIwvvgSKbUYxs7sufHc18/xEKgJ9w?=
 =?iso-8859-1?Q?0MSroeXxryVJDJVagFL1EUBr2fdX04YUMSi9+uMu2IQQqcWCsMvw5PkL+6?=
 =?iso-8859-1?Q?cmfphvo9GWU0p3HXPI+B3i1OkWI7fDQS+qn4PQreeeK9hdLBNxLOwx22t2?=
 =?iso-8859-1?Q?ZCx0nT0UY4+NZZAL/IMt4MwFAT6T6AS+xIJY4b+K7CQfznA8mMq7KfVgeb?=
 =?iso-8859-1?Q?683c+Yccf5TVFImkl4NMf+efuP53VaoYqaxP5a2d71i5COsuwqmoNJoWD+?=
 =?iso-8859-1?Q?qHW15DPUzkQ9mXPZdp0029IpAdDM0SBQAg9VAZGs4G9nqV76kylOLYUTRR?=
 =?iso-8859-1?Q?KgWDqKL41zTqEefE/TYf9rupVng8R/7/dt22Oa08oTKDBmqC/NY1svDL6w?=
 =?iso-8859-1?Q?+WylRiP0Xo0GIsgys13wUSlJPoJ34Z/kgLq2fY05oQ8vUyYmDJVnu9DGYg?=
 =?iso-8859-1?Q?Lm+IhYatGVMBw4rnKkDojt7DcFydoRQutWtaYJxBi/cr0poZ2eg3TKpqLS?=
 =?iso-8859-1?Q?VfI//NkeB6MBOferM1B51fdu2LNhAr8f/BYNxWJ/sLgGrDOx8MQTm5P4+s?=
 =?iso-8859-1?Q?TztzcaIoRvGCOfUWul3j/V8ok=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58781cc9-d002-4028-b53d-08d9d1ee960c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2022 15:01:29.8308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IJXmBobvNGIG6SVU0FtaKA3k0HjLUSfHQWbyUk1OjdhuOdNrzBYjgTDXAxIEDovnfpSXcQCeRPjMNoJTikNxww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6494
X-Proofpoint-GUID: TxfPqCXkqFJ3weVhN8Vjkwu7XJosCo6u
X-Proofpoint-ORIG-GUID: TxfPqCXkqFJ3weVhN8Vjkwu7XJosCo6u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-07_06,2022-01-07_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201070103
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Rob Herring <robh@kernel.org>
> Sent: Friday, January 7, 2022 4:20 AM
> To: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Sa, Nuno
> <Nuno.Sa@analog.com>; Jonathan Cameron <jic23@kernel.org>
> Cc: linux-iio@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH] dt-bindings: iio: adi,ltc2983: Fix 64-bit property sizes
>=20
> [External]
>=20
> The '/bits/ 64' notation applies the next <> list of values. Another <>
> list
> is encoded as 32-bits by default. IOW, each <> list needs to be
> preceeded
> with '/bits/ 64'.
>=20
> While the dts format allows this, as a rule we don't mix sizes for DT
> properties since all size information is lost in the dtb file.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>

Thanks!
- Nuno S=E1

