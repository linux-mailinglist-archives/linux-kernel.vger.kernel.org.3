Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8B654C847
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346772AbiFOMQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbiFOMQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:16:17 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9512412764;
        Wed, 15 Jun 2022 05:16:16 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25F8rme8010673;
        Wed, 15 Jun 2022 08:15:51 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3gmqp8htys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jun 2022 08:15:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WaZLwFUHb7ZtwxeqD2GYKuifrtjl7oqZa8Aerf93r67DAyoLSNUSLixKr2uRhT0jCTn70ZjDqe0Z6TkLSLTOwnLZvZ0DjbZybqySg01l5VOxBI+mz2qSGNmh/owo5Fhb7Q5rdop5SOlF17aEODlDm/1dcM1zoG5jvFzEwIalmYMYZkHZPczFXKS3bWPBhVLmZSSfYQs5XplfohqMoUASEgG1UCdnrlwn89/CKvjIS7n4buWTlD4ypeH4YiT09V26OSQTggFCLM3ZVtDjfliPmMryB2XUOPX0ZnQoIxShqu0rkfbylOB7C+x6SKok/YOjmLC7m5qqF7emRQQKAcaTDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvVabD2jSDjq7r12YKufnCU0ssnryfpgZmwWPVq08S8=;
 b=c8d6orGPniMoL8oMlAEnfFLMU1asrOvk9f80y5U/WgxdTbXFB7NsLQMxQSk1Y9AqtI3qjiTHExGzmQP7CVQaWcdWnbtm1kC5g/w48bsZBKJUaCwC5c4cIkJRwAe/0o5clUH+RSYg28UK2+u4TTqc/djlMBpNYrypb/CUeMTesdFroNTR2KvRhHNHYQgD3eSYwswSg9ZcLxX+vIKhDlQiAKEyrYHPkYnR0ogJrL7Uvx56I3BQFkxLFwPOUkEdP53IAym1rIYVmv3D93wBOGhbBXCrH77jnxuKnab1P72DnhA3Mew3M3GSaOHdBTg+dODrcRLIkEgLgAtYew/TqtHCYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvVabD2jSDjq7r12YKufnCU0ssnryfpgZmwWPVq08S8=;
 b=WYH1AGDmfv5AIJ0rTrbnNI68YkrasMctbmBnkliXAlM2+/xfa2/EAhiwioAwFF2lE/WAlY3oD6fwtMr6Y5UAWuznL8SEsCLhidLna+V1ChvpWHeVmmIS5y64ziNC7SdUXIKV46bdRvjvcIV8B6H5OQak0rFrWDgwlonYRZhu9RA=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by DM8PR03MB6261.namprd03.prod.outlook.com (2603:10b6:8:3d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.13; Wed, 15 Jun 2022 12:15:49 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::d4d8:c051:a366:8003]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::d4d8:c051:a366:8003%8]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 12:15:48 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH v1 1/1] iio: adc: intel_mrfld_adc: explicitly add proper
 header files
Thread-Topic: [PATCH v1 1/1] iio: adc: intel_mrfld_adc: explicitly add proper
 header files
Thread-Index: AQHYgLCX5FbabFkmA0KbjkZY9UaAq61QYNmQ
Date:   Wed, 15 Jun 2022 12:15:48 +0000
Message-ID: <PH0PR03MB6786A019FB9A1BA810DDE2BC99AD9@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220615120803.41350-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220615120803.41350-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctZTE5Yjk4YTgtZWNhNC0xMWVjLThiZWUtZTRiOT?=
 =?iso-8859-1?Q?dhN2NjNzEwXGFtZS10ZXN0XGUxOWI5OGFhLWVjYTQtMTFlYy04YmVlLWU0?=
 =?iso-8859-1?Q?Yjk3YTdjYzcxMGJvZHkudHh0IiBzej0iMTM1MCIgdD0iMTMyOTk3Njg5ND?=
 =?iso-8859-1?Q?U1NjYxNDA3IiBoPSJtZjQwZTVzSG1WMUhaRWt3Y1V3SzhqQS9uNDg9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUJmMGZPanNZRFlBV3ZGbjFwZEhMYnlhOFdmV2wwY3R2SURBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQUpyakpJUUFBQUFBQUFBQUFBQUFBQUo0?=
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
x-ms-office365-filtering-correlation-id: bcf0284c-7e78-4184-c4c5-08da4ec8c85d
x-ms-traffictypediagnostic: DM8PR03MB6261:EE_
x-microsoft-antispam-prvs: <DM8PR03MB62613987A964D2DE376DCB9A99AD9@DM8PR03MB6261.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7HoegM2pTG2zacF5egQ7fstFhbP5GATJXlBpBElnUZZ1uLiDD9R2Nt44AiHi1SjTKTx6MqPqhbQ3m6L1u3ZHjBndPOU+vVtxor72z1qz21NAKDfMZHYNUS/ZYeARYC1SlRfXbvGKhYdVkpImkthTue8ZHXIgOqT3TP0q4DdhldQQTocrDD2bFEqEfgUhEbklyPvz9/t/+cXt2dmkOWuu4i8llhuAZ/bp+R/Tys2hlceJ4CP9wLz9ZZrtt4daJ4nv5TJmYD1a08HkqTSM+Kr1V6bxesz10ng6X/y+MvLL7oihPSd9WsDBqWqcpJB3jB39df/LAImmdEYB4uFBPv/wJnNtbTiP5G3APn7FQs6NFnwyjo8sRyGjp0yn2StXGAotvi+zGXRU26xw2EbbFdSdcuDnm6SiGfxgpAlTWuhK0m1+hGDd+kncGyHR5CdfI+yhVWd6XiiolXvMgaMio29SHkI6C4kHP99jenZjynPQwg78/0qAg1YJDYctpRRo0nXyb7mbAn3JCLRoURZKG7EHyF8q8nOR+A7U/idh5FDOTemaNo9zGwsZ+EnChmKMiZSvilr6NNynL5HpAbAggPDu1azwhCfUDuQiCm8LVh9GANu8wO32oQXEpIx81TwxTVjHsAA6kFG2+GcWWKWgxMGqGf+NBTxpEsNH9UP71ooMPGwssApNKng+tMddrYvgJzSIo8MSMl+Eme7wUHc2HibJ9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(52536014)(7696005)(26005)(9686003)(53546011)(71200400001)(6506007)(66446008)(66946007)(8936002)(316002)(76116006)(110136005)(66556008)(66476007)(4326008)(38070700005)(8676002)(5660300002)(508600001)(54906003)(64756008)(86362001)(122000001)(83380400001)(186003)(33656002)(2906002)(55016003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1qfxP7a+w0YHQkuCSxePGoDlwg2KxxTk2Ttqa6uPZfYBFywHAugBzAq094?=
 =?iso-8859-1?Q?LtfkeeG7/uT+Rr16s/Vp28Gj59WhQgNGABt34JmUi4XQShZUmdxgmCaCjF?=
 =?iso-8859-1?Q?25hqc6Qr0hjxUlv/2VtPAFuFq1p3e0+niacRiMkEHgqc3OoBdEpq/qzfsn?=
 =?iso-8859-1?Q?mKa7RGULXrki1FkbqoqZl5jHECR5XLw+hgygfeeo2Pgm405uohnSV22xQg?=
 =?iso-8859-1?Q?a/PNfCoOxOfrsnRHrojCry4AKW04uWCPcYY4sL9rYXc6AzGrq4y4qWrxIe?=
 =?iso-8859-1?Q?LPG0QE+8WQU464BHSXcDdKQksfpo2phu+JqykGWvymLRqw4V+L5Fa2ec4P?=
 =?iso-8859-1?Q?5zjzPt0Ku1uA4xKxfci/6HT/ZgH0xW5VyqI3/y9CqvnhirBpgY4malbABF?=
 =?iso-8859-1?Q?fHAP0dI6IS1rRBoOIwYHXX9WUtPSVAdbHTSiidRhiePI4/xdjj6jfIW4n8?=
 =?iso-8859-1?Q?6sNFbx/7uMqSF7l9PUzkay95PzG6RbiKzdlf0v1DG8pUf/dXwlg7G4NM0T?=
 =?iso-8859-1?Q?0nkJx7ZxdXnhCr6+Qkj3o/J0tBUGWmv3N8WlRJviFKPoRW913/+YZ2FYfg?=
 =?iso-8859-1?Q?+L9BnYZxmRmEGJs7Xu/zT/l8sRVJWVHEZx5NNqybjJJ4sh1Z7co3TdwsLx?=
 =?iso-8859-1?Q?NJ6udyCiQ5jZ00SVms770Snr5cuFVoY4gufuJypaC20v72bF78wReSUFDP?=
 =?iso-8859-1?Q?ZyXD7Ts6EEiCec6oR4KfOSz3BpBcz3gZjnD6KeGnSw7OlBOJ0ldiAGztEp?=
 =?iso-8859-1?Q?RXE1fe41cMDP9z2Guhb3bqdv0zF2o+BO0DYyuFQY7EEVigUk7vixSa/0VK?=
 =?iso-8859-1?Q?qXVns9QtLtatDG45GSnvuWUeWJ1v7h8N04+6eV2+sj7wK/V0jn+YpCKleu?=
 =?iso-8859-1?Q?jvuB/QlKYjfmrr2ZgC5oSmvkePDFujMG6Ms/QLZ/j6c9B7BW/OfB9rmNMr?=
 =?iso-8859-1?Q?I1ujEEHZA8zn7Iq7iG21nxdJnS3iuCk1IYv7yhXn4MAwDciQtUMss/lDUy?=
 =?iso-8859-1?Q?Gwr7MDb7kFWQNd+htx3xFGkNXZ9/xvWac4UvqLwHX9OHMyXosdRIoncRdH?=
 =?iso-8859-1?Q?1brYrQhQ94XWEOTLCJFRlVNBND8LUjS8uXhra+m3U4oyGaAQcdzLn45Qwn?=
 =?iso-8859-1?Q?lQk6UUvdj1Qxoqt78thdWcKc/hu33+4bnVlRakHXP9MKoFgnxpCUkv9wc6?=
 =?iso-8859-1?Q?aTng4hGNpIoLyVK/AAJd85Ov6EBzE6lA02yE8+V35IgmLliRHga8O59jzT?=
 =?iso-8859-1?Q?P57zUHlUfDpXcceC1fJDWdJEkLJaWcyfeJ+3FvAnGCf23+vtWJbazXiyMH?=
 =?iso-8859-1?Q?rFFa5g7spczyjihdU17fI3B0HkFjAkOAg3SZPqDL/2an2GCMJDsvbYpl1z?=
 =?iso-8859-1?Q?CrWenakeS8D2Rfx6pUGDNKVuuRxNCPwBQVrATUejSboHcToxTJA99nUlif?=
 =?iso-8859-1?Q?UUclIiKjZ8Srdt4Eg6h9LfGMhgkI5wn9ffIoPfg4ALAaDsm1b0pT3eISNs?=
 =?iso-8859-1?Q?dSm1KsgaDk84fuU+l+qghzhEWOmJIbb00SOn+D8TMalv2Xb4v1nBXMAf5L?=
 =?iso-8859-1?Q?ouQEE/upbUs6Q93Fbo3nvLTYn2ACvuqtejZ5dwH9lVWeuUhbX4S1trd8Hj?=
 =?iso-8859-1?Q?E+cmi8hjoJLl0aGpsY1md8lBQSVlx1UAhBUE744Ub81spLzHFfxTcXSIqe?=
 =?iso-8859-1?Q?WwMIbZ9grvR/UFPKDPsggIvChNN1fCJ/qljmm5EKiIFOzxSpu8fryjeEki?=
 =?iso-8859-1?Q?i8Fde7Me3H8Y5PRBSeWyd1gpbvPtcsjssCBboKieESd4cKHtumNX3NvY/H?=
 =?iso-8859-1?Q?kR9UrDiC0A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf0284c-7e78-4184-c4c5-08da4ec8c85d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 12:15:48.7891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U8KxmBbEcSrVSkcBpfE4UE5d0o96goeZwFQKkGYxk7bO5y/t1WtcbfYi6z1ZD/c+vIkiBufh3H+s3kq6B1ZbhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR03MB6261
X-Proofpoint-GUID: 2UHMaLirvIpnBgig3fqoiuSqy5pf7IJ9
X-Proofpoint-ORIG-GUID: 2UHMaLirvIpnBgig3fqoiuSqy5pf7IJ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-15_13,2022-06-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 phishscore=0 mlxlogscore=862 malwarescore=0 adultscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2206150049
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Wednesday, June 15, 2022 2:08 PM
> To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>;
> Alexandru Ardelean <aardelean@deviqon.com>; linux-
> iio@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen
> <lars@metafoo.de>
> Subject: [PATCH v1 1/1] iio: adc: intel_mrfld_adc: explicitly add proper
> header files
>=20
> [External]
>=20
> Do not trust the fact that iio.h includes of.h which in turn includes
> all the headers we are relying on.
>=20
> The ultimate goal is to actually drop of.h from iio.h.
>=20
> Signed-off-by: Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>
> ---
>=20
> Jonathan, this should be squeezed before we remove of.h in iio.h
> I think Nuno somehow missed this

Yes, I did (compile) tested this on arm and arm64 as I said in the cover.
I guess this one won't be enabled on those archs :).

I was planning to send this on v2 (I did noticed the kernel test bot
emails) but yeah, this should actually be included with the other
patches before removing of.h from iio. Thanks!

Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>

