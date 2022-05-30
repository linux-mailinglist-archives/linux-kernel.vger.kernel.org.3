Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2701A5378FA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbiE3KLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 06:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbiE3KKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 06:10:45 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6003E7B9D3;
        Mon, 30 May 2022 03:10:44 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24U9lLVd029516;
        Mon, 30 May 2022 06:10:38 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3gc0xg0gm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 May 2022 06:10:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7a9qj1IKV5ppXcsw+HOCI3PgyKFrerIoxS0fphm+qnnudRm83aQhMg5lDa/tCygj2zJnGHGnq/2SW5O41DPyQlg7iocz1TnSYmZSLXkxV7hcU+tPpbIXMmfnfSst6YwvnaebQOQYxyrspoJ77I/wBqcAo8ZHo9xhPGslX5eqq86VqsDNn5ZBhw25mu/lqUmaGBWJQnIfFHuPc+9QYkajGogGQafIFnLLgdf7gsvUqKb4sFXVjcHbHXbyVymj5/NaP/SKEplzPrGOwxQZoMtIsjSq6xfh3B8WXLF9LRQuk+pYSLx01R4J7ggXUm0gRrZIAcFX+ifXvuOTnKQM9COtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r471pMEZ2pYdr6wN+F4I/fLnVnPYIM5oX5QcnRRV2Xo=;
 b=YADlIZLfYe0Wu7N25eX4vMf6oHJfB/CXqHHJKvtPUrs15SXlLSklsb9F7IsGUXUIyv0im3Md/JFhEkmjmwp3cgAW2neBEeog+RepDaSiEGnJjZGzoOwyvWKAG1R75ts5niDqjrSnXpM/Hgf9XI/xMKMW3XgIOeE/tSJf/GblII0qxfYfnshAh+zUWexMTwGbMcSMjlFsT4lqFnZRKwk3ss1Ga30KdVaO+qnCFH9ltwEJ5ritDN165IeLPlpwLJvIAQyNwrWE3nGE3YPRcyWPcJFYvpBXvo5C0hFy1d5gVTM2A+znFcsvcMwVKY4X9kc54XBwL4iuf4rKRebLQQc0lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r471pMEZ2pYdr6wN+F4I/fLnVnPYIM5oX5QcnRRV2Xo=;
 b=mPA77BeDHfUhYG04p9bG6kiopJkrNHWlGNUYtI/EDzG3OWDrmdA1N/I/ockTutLFt+IrrqHxfnlVLPNBwv0l59cxz5D7/zbzXLzsnKl9jVHulV310tUIeOC0Bt5s4HUn5k0YV0JMhhO971qsSq8D6s3k0iLN0mWefkYB72dTQTs=
Received: from SJ0PR03MB6253.namprd03.prod.outlook.com (2603:10b6:a03:3b8::19)
 by BN6PR03MB2738.namprd03.prod.outlook.com (2603:10b6:404:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 10:10:35 +0000
Received: from SJ0PR03MB6253.namprd03.prod.outlook.com
 ([fe80::b188:7eab:15fc:aa39]) by SJ0PR03MB6253.namprd03.prod.outlook.com
 ([fe80::b188:7eab:15fc:aa39%5]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 10:10:35 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/4] Input: adp5588-keys - switch to using threaded
 interrupt
Thread-Topic: [PATCH 2/4] Input: adp5588-keys - switch to using threaded
 interrupt
Thread-Index: AQHYck9SflYNu/xNw02lCU2KpHCRP603NbhQ
Date:   Mon, 30 May 2022 10:10:35 +0000
Message-ID: <SJ0PR03MB6253352AC71700940580DFA38EDD9@SJ0PR03MB6253.namprd03.prod.outlook.com>
References: <20220528045631.289821-1-dmitry.torokhov@gmail.com>
 <20220528045631.289821-2-dmitry.torokhov@gmail.com>
In-Reply-To: <20220528045631.289821-2-dmitry.torokhov@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWhlbm5lcm?=
 =?iso-8859-1?Q?lcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-1?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy1iY2UyOGFlMC1lMDAwLTExZWMtOTJhMS?=
 =?iso-8859-1?Q?00ODg5ZTc3Y2RkZWZcYW1lLXRlc3RcYmNlMjhhZTItZTAwMC0xMWVjLTky?=
 =?iso-8859-1?Q?YTEtNDg4OWU3N2NkZGVmYm9keS50eHQiIHN6PSI2OTM1IiB0PSIxMzI5OD?=
 =?iso-8859-1?Q?M3OTAzMjU2NDk3NTAiIGg9Ing0V2d0Zks3S1JnSVlLQ213MlVyUFJzWG5S?=
 =?iso-8859-1?Q?ND0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk?=
 =?iso-8859-1?Q?5DZ1VBQUVvQ0FBQlcwVDUvRFhUWUFRYXgySFYwWE5xT0JySFlkWFJjMm80?=
 =?iso-8859-1?Q?REFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFFQUFRQUJBQUFBSnJqSklRQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBSjRBQUFCaEFHUUFhUUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QU?=
 =?iso-8859-1?Q?c4QWFnQmxBR01BZEFCekFGOEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFh?=
 =?iso-8859-1?Q?UUIwQUdrQWRnQmxBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQU?=
 =?iso-8859-1?Q?FBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdV?=
 =?iso-8859-1?Q?QVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVlRQmtB?=
 =?iso-8859-1?Q?R2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dCdkFHb0FaUUJqQUhRQW?=
 =?iso-8859-1?Q?N3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21ldGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7814e45e-5bc9-41f2-d5a5-08da4224a354
x-ms-traffictypediagnostic: BN6PR03MB2738:EE_
x-microsoft-antispam-prvs: <BN6PR03MB27388EF5EB86CD23B63625A38EDD9@BN6PR03MB2738.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: et60BtZL6tIYqO50AH/iJZJ9tLQDi2CXScIyC1jfIOv8PIua9/GdsxjnMhlyaKQKDF8bN937a7Vunic8ZdNVGezMmEGV/cW2hHijubsyL60dEPt4kB7G3egy6PXSlgxyUeDsC6yPsMlf7c3mW3GyejQAI0vnnrOCYDo1wojlA7X6NbfX9kVlu6npKH0RtmbLQomlQtnNyJ8kDQDf5CVWsW32SEw2a7UU1G6dzUM7NRnXq2c6hS0aSkGsB778LxYvxYMyzFUC1cSyNEd97cIbTdtRDx14XMsdgdA6RqNdjQfB1kEZcHeITh3OVkbo1N81NEGG9Pj2uKl2i3pmdV59GA05Wk7N5wtPiO2yxgAv9OIaEasg1JAdpIk//OPcJ1Wdixd/EMMUkKDdqaHR8tjkI44z5xE3GtuQZFV2Oq2qyRBRBRf16RH4ziJO8hg0NzOsWRpnrezSCjTQiNSUGvXhef9s7lun/D+rXhGxNnSpW83Ydj2gKqj87ouyBfzr1YMb2djmMbfWHKZ1ystYUJFRHqidqrsxvzL/+X6NONt4VSrAMxPcTS36/pYKCrYA5itoJy/8ZaC6Jtts/W/rxXimXmtnGaSQBCLh/InGbSZ9UdQ9wHaHpfRLKc/7edvuyvnr2dWkSiHewTLEsn6V2rGtemIEPMKesajc5OPJpIXT7C2Qci4rMGWqRGJyXcu6IkvTceXZIAQ1ikiB58tlOBlvcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6253.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(186003)(55016003)(71200400001)(66574015)(8676002)(316002)(4326008)(54906003)(66476007)(66446008)(76116006)(6916009)(83380400001)(38070700005)(64756008)(8936002)(53546011)(52536014)(7696005)(6506007)(86362001)(508600001)(33656002)(5660300002)(122000001)(9686003)(26005)(2906002)(66556008)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bjnA2nXlYjdWjLWgw6vLZWHSIK7kpcc5SmfZ1HGC+t+rZLxdKmPJGAkBe7?=
 =?iso-8859-1?Q?pxnFWqT4SuTQL7BP54gfjcd73shOZx6kxUWBb4935muQesOCofCbCVkKcU?=
 =?iso-8859-1?Q?gHOUGbT6xP/bVHq6J79fOgQG3w+6qpCT4/KUYLc6A8WxOya32iIhAf6XJ+?=
 =?iso-8859-1?Q?caKC4owbaIQqG9D+56/RcEG1Qfh9X8p2APEH4l67jbQh0z6zzQtNcGzbUh?=
 =?iso-8859-1?Q?VMKn5wDAcGMsscK3Wd1u5WooCDWEqIRbFF2ZnB6WbFPmCl7PgKj3mptenq?=
 =?iso-8859-1?Q?gr8H0BHLGPzJlLCcBtncZo9RAZIpxu+9JDMVkFBNNgv75bt+rkrx4twoUo?=
 =?iso-8859-1?Q?mUpNS9JPGQk4Ooia0MxIA8iM/e9airzrXGHJLe+4so7T6yyZMYz4f9Dk5F?=
 =?iso-8859-1?Q?BB+i/6nM4kMbcVKlUC0SB+FuHBzEB7Q0bjnBtXOcaukQ3as/do/L8HWcbS?=
 =?iso-8859-1?Q?z0FUmUfgBSMk0YjJ5u1O6Nvmue/LDu5FqO19ar3JT9LB3OU/y2VCMwPQP/?=
 =?iso-8859-1?Q?TBvqxgPolfM5qRJTxFpLY6CqzZa70/pbWb6iK1ohEpZCVyXpcNcyRhR+Vf?=
 =?iso-8859-1?Q?uBnG1s7S7Fbgv4T/ITxo6bIQ+q0UwtMFWKqXO1Ex/P2AUUmMsD/dNwtF8V?=
 =?iso-8859-1?Q?dvzNes81WKIDhl3kBgY35Zd48qikW9sKImCTQLrH8REOXjty2c8Fj/J7yf?=
 =?iso-8859-1?Q?jO4ePn8SE7DeYAxEML7mB7E+5hvN98AbU6nKWgZI8IN/tSjL5xdFZ4bw4+?=
 =?iso-8859-1?Q?ztnkOW34pIFQWDNEM0BHb0DLsSsBRAG2U3x+NfiYHj3fYC6OReKQ26/ZS3?=
 =?iso-8859-1?Q?D9DbGGJnnk6xOrDFuuDruicgs1PDUCyN9Yg6WAHQ7yQHhpv7O1DlQh6HkD?=
 =?iso-8859-1?Q?KhJc06YuMqfHpOCYUSsAWp3/MuX+876+vQ+qfGxV5JsTW5cb/RjVN4CPIb?=
 =?iso-8859-1?Q?Jo9HKr87LZmntCt0BVVnpJeG8FoGJC6T681EVVOoms3VoMJmU/8gTUZtMD?=
 =?iso-8859-1?Q?MSO8Vj1wkwa4pxGVoZ3sluH8PdPEO1qN36JTd+ZWvwYGJv571K7wJ7pm3o?=
 =?iso-8859-1?Q?kUVgqWYeCPj1G0GqZ3ZYsqBWmniGECXaZWENVk90NDzaMZn/kMtMb/rPY2?=
 =?iso-8859-1?Q?QqTEZkdy+IJ0nFVk9HoENb6WHr8KlHo6RgkjVOhzXEdb60HZoT4N/fkFmR?=
 =?iso-8859-1?Q?BkOTWLU0WHyRkaRTAJax4YuiZ5eNwLIHqMVA2HSnRF5YfmqtMW8FqtTk2+?=
 =?iso-8859-1?Q?IDOcsUaoiMZxIqtjjUj9KUM+sGzVaMtFIO1Uh6EqXGmPLt7QS1Lg/NsFhE?=
 =?iso-8859-1?Q?za68hycDDtDNwQ2qB9efeOPwJkrUwMofHJDH2FADMwq7GUfn0gE+aaqpvj?=
 =?iso-8859-1?Q?TNNrj0n+swzRjZ3mUtYV8ZRxdCxeEoEtmEOaFBCqAayEnPkzaWP4/+NVQe?=
 =?iso-8859-1?Q?Da55zHPh5jCI/z3tTB4VtmEEspkGL1APAC3ILXY1fHL93dBV7cPVwKbkhR?=
 =?iso-8859-1?Q?Pm3l6afwZUk1Wj1ERO/4fO4fdFhBUNfvUJN1pm+VQ5AFsJ3gagQ7jrNE1A?=
 =?iso-8859-1?Q?3phoAI6XRDwhs5Yb/AQ30F3II2AxGvImm7BvKk7uNkepyfcP6D+J8QzZWX?=
 =?iso-8859-1?Q?A8KsmXh8JonIUbgyT1d31rvf17RIzUDveVc5d04wHREi1FDZW1sO5BVJI9?=
 =?iso-8859-1?Q?61Oi/UTa1bjkBCuo2z7+6y7xJeUlqM29RWqeic1f3HEeisfbNN4WMmF4DV?=
 =?iso-8859-1?Q?PKoAQoG25tiej3B+B2B0VVjT3D0to0yTdMf1nIcHjW9K0bIJOmryd95sOa?=
 =?iso-8859-1?Q?DFvHLQ0A6p15z52UBTHqNdYRqLd4F50=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6253.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7814e45e-5bc9-41f2-d5a5-08da4224a354
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2022 10:10:35.2692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HZOPRsTqlvyl76cP5BahUZq8y+GhtgheL+AfFy81b9BaV07jNDjzX5tgGC4vyc56cQ7DVyQDqXlhnF4rmNQvVfFo2JNd9RrdY7xDSkSJgfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2738
X-Proofpoint-ORIG-GUID: C3RLa5mJfyi9Fky71g8YKgw4gqL1jWqV
X-Proofpoint-GUID: C3RLa5mJfyi9Fky71g8YKgw4gqL1jWqV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-30_03,2022-05-30_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205300054
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Sent: Samstag, 28. Mai 2022 06:56
> To: Hennerich, Michael <Michael.Hennerich@analog.com>
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>; linux-
> input@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH 2/4] Input: adp5588-keys - switch to using threaded inter=
rupt
>=20
> [External]
>=20
> Instead of using hard interrupt handler and manually scheduling work item=
 to
> handle I2C communications, let's switch to threaded interrupt handling.
>=20
> While at that enforce the readout delay required on pre- revision 4 silic=
on.
>=20

Looks good to me. I'll test this altogether with the devicetree and matrix_=
keypad helper updates.

> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/input/keyboard/adp5588-keys.c | 81 +++++++++++++++------------
>  1 file changed, 45 insertions(+), 36 deletions(-)
>=20
> diff --git a/drivers/input/keyboard/adp5588-keys.c
> b/drivers/input/keyboard/adp5588-keys.c
> index ea67d0834be1..ac21873ba1d7 100644
> --- a/drivers/input/keyboard/adp5588-keys.c
> +++ b/drivers/input/keyboard/adp5588-keys.c
> @@ -8,17 +8,19 @@
>   * Copyright (C) 2008-2010 Analog Devices Inc.
>   */
>=20
> -#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/errno.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> -#include <linux/workqueue.h>
> -#include <linux/errno.h>
> -#include <linux/pm.h>
> +#include <linux/ktime.h>
> +#include <linux/module.h>
>  #include <linux/platform_device.h>
> -#include <linux/input.h>
> -#include <linux/i2c.h>
> -#include <linux/gpio/driver.h>
> +#include <linux/pm.h>
>  #include <linux/slab.h>
> +#include <linux/timekeeping.h>
>=20
>  #include <linux/platform_data/adp5588.h>
>=20
> @@ -36,11 +38,12 @@
>   * asserted.
>   */
>  #define WA_DELAYED_READOUT_REVID(rev)		((rev) < 4)
> +#define WA_DELAYED_READOUT_TIME			25
>=20
>  struct adp5588_kpad {
>  	struct i2c_client *client;
>  	struct input_dev *input;
> -	struct delayed_work work;
> +	ktime_t irq_time;
>  	unsigned long delay;
>  	unsigned short keycode[ADP5588_KEYMAPSIZE];
>  	const struct adp5588_gpi_map *gpimap;
> @@ -289,13 +292,36 @@ static void adp5588_report_events(struct
> adp5588_kpad *kpad, int ev_cnt)
>  	}
>  }
>=20
> -static void adp5588_work(struct work_struct *work)
> +static irqreturn_t adp5588_hard_irq(int irq, void *handle) {
> +	struct adp5588_kpad *kpad =3D handle;
> +
> +	kpad->irq_time =3D ktime_get();
> +
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +static irqreturn_t adp5588_thread_irq(int irq, void *handle)
>  {
> -	struct adp5588_kpad *kpad =3D container_of(work,
> -						struct adp5588_kpad,
> work.work);
> +	struct adp5588_kpad *kpad =3D handle;
>  	struct i2c_client *client =3D kpad->client;
> +	ktime_t target_time, now;
> +	unsigned long delay;
>  	int status, ev_cnt;
>=20
> +	/*
> +	 * Readout needs to wait for at least 25ms after the notification
> +	 * for REVID < 4.
> +	 */
> +	if (kpad->delay) {
> +		target_time =3D ktime_add_ms(kpad->irq_time, kpad->delay);
> +		now =3D ktime_get();
> +		if (ktime_before(now, target_time)) {
> +			delay =3D ktime_to_us(ktime_sub(target_time, now));
> +			usleep_range(delay, delay + 1000);
> +		}
> +	}
> +
>  	status =3D adp5588_read(client, INT_STAT);
>=20
>  	if (status & ADP5588_OVR_FLOW_INT)	/* Unlikely and should never
> happen */
> @@ -308,20 +334,8 @@ static void adp5588_work(struct work_struct *work)
>  			input_sync(kpad->input);
>  		}
>  	}
> -	adp5588_write(client, INT_STAT, status); /* Status is W1C */
> -}
>=20
> -static irqreturn_t adp5588_irq(int irq, void *handle) -{
> -	struct adp5588_kpad *kpad =3D handle;
> -
> -	/*
> -	 * use keventd context to read the event fifo registers
> -	 * Schedule readout at least 25ms after notification for
> -	 * REVID < 4
> -	 */
> -
> -	schedule_delayed_work(&kpad->work, kpad->delay);
> +	adp5588_write(client, INT_STAT, status); /* Status is W1C */
>=20
>  	return IRQ_HANDLED;
>  }
> @@ -505,7 +519,6 @@ static int adp5588_probe(struct i2c_client *client,
>=20
>  	kpad->client =3D client;
>  	kpad->input =3D input;
> -	INIT_DELAYED_WORK(&kpad->work, adp5588_work);
>=20
>  	ret =3D adp5588_read(client, DEV_ID);
>  	if (ret < 0) {
> @@ -515,7 +528,7 @@ static int adp5588_probe(struct i2c_client *client,
>=20
>  	revid =3D (u8) ret & ADP5588_DEVICE_ID_MASK;
>  	if (WA_DELAYED_READOUT_REVID(revid))
> -		kpad->delay =3D msecs_to_jiffies(30);
> +		kpad->delay =3D
> msecs_to_jiffies(WA_DELAYED_READOUT_TIME);
>=20
>  	input->name =3D client->name;
>  	input->phys =3D "adp5588-keys/input0";
> @@ -560,9 +573,10 @@ static int adp5588_probe(struct i2c_client *client,
>  		goto err_free_mem;
>  	}
>=20
> -	error =3D request_irq(client->irq, adp5588_irq,
> -			    IRQF_TRIGGER_FALLING,
> -			    client->dev.driver->name, kpad);
> +	error =3D request_threaded_irq(client->irq,
> +				     adp5588_hard_irq, adp5588_thread_irq,
> +				     IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +				     client->dev.driver->name, kpad);
>  	if (error) {
>  		dev_err(&client->dev, "irq %d busy?\n", client->irq);
>  		goto err_unreg_dev;
> @@ -587,7 +601,6 @@ static int adp5588_probe(struct i2c_client *client,
>=20
>   err_free_irq:
>  	free_irq(client->irq, kpad);
> -	cancel_delayed_work_sync(&kpad->work);
>   err_unreg_dev:
>  	input_unregister_device(input);
>  	input =3D NULL;
> @@ -604,7 +617,6 @@ static int adp5588_remove(struct i2c_client *client)
>=20
>  	adp5588_write(client, CFG, 0);
>  	free_irq(client->irq, kpad);
> -	cancel_delayed_work_sync(&kpad->work);
>  	input_unregister_device(kpad->input);
>  	adp5588_gpio_remove(kpad);
>  	kfree(kpad);
> @@ -614,11 +626,9 @@ static int adp5588_remove(struct i2c_client *client)
>=20
>  static int __maybe_unused adp5588_suspend(struct device *dev)  {
> -	struct adp5588_kpad *kpad =3D dev_get_drvdata(dev);
> -	struct i2c_client *client =3D kpad->client;
> +	struct i2c_client *client =3D to_i2c_client(dev);
>=20
>  	disable_irq(client->irq);
> -	cancel_delayed_work_sync(&kpad->work);
>=20
>  	if (device_may_wakeup(&client->dev))
>  		enable_irq_wake(client->irq);
> @@ -628,8 +638,7 @@ static int __maybe_unused adp5588_suspend(struct
> device *dev)
>=20
>  static int __maybe_unused adp5588_resume(struct device *dev)  {
> -	struct adp5588_kpad *kpad =3D dev_get_drvdata(dev);
> -	struct i2c_client *client =3D kpad->client;
> +	struct i2c_client *client =3D to_i2c_client(dev);
>=20
>  	if (device_may_wakeup(&client->dev))
>  		disable_irq_wake(client->irq);
> --
> 2.36.1.124.g0e6072fb45-goog

