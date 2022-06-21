Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B7A552B04
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 08:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245662AbiFUGfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 02:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345379AbiFUGfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 02:35:51 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A03514016;
        Mon, 20 Jun 2022 23:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1655793349; x=1656398149;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Olgr2CImIPeQDsMuNDy8nGManjqcUHqUzWaTUOyNLSA=;
  b=j9LcM087rC+fk8N1yU/IuBlxbT7ANnBiR/XlSiukiQGubGHv56R67W6W
   fzOAa1N+YEM4o9hVowsxgxHTS9pC+//Jk2osUKv1RWDZCgtW2PavePvvJ
   32VKqGUMstUqK2JM09zJabmNYO+oaQZ1XcScCWJ00eUV1By4fWfL2hr/c
   o=;
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 06:35:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFlfR0dWOcnoXsGvu0G5kH5ZnZIm6szDnDPr4mJKgmBNWBqPxNdOHvZyk3guq9h1Yb+71bPbviRQuRxzv3PK0aPWDtPoR73SUz0UVl8LU1l0ukIFPvsQHH071+gXJ8xPBF3jZz/eqxfaZcNop5HPhnr6QyvFSNT6/26NUIi2p8MmOJG87S27v3xV65q/hB7NOFkz50t8pmrTyMfx4pqz9p0LBzce+eoG5lgB199g55Hb1s6GcxqGaL+jE9lvpugP5g3L+7G8VLMh/9rH7QFHdgNvnO7t9/EJRhsKnx3k6vBxuEWBhp2ST/T3BTF2SrMVToKFCKVm3tgGfS1ve5Kolg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Olgr2CImIPeQDsMuNDy8nGManjqcUHqUzWaTUOyNLSA=;
 b=jTvjzWCliimb3O9Afq5u3K96eI27qFrBzU8r0DFQtmIGgFNQYPUK5Ws6+zKdlSx9T7F/OebE3J5u6zlOWr8XhjKan94274sZsYfKr1GxHMUsAYGxSkI+2ro2mo7Oz2EKSRN8dqMh2yvtHKtRgA1FJ0UErsWv/eU0Ous/reuX2ZQeBD/cbojjx1KHDxtsIMV9ToupbGNwgYpOywgUqrov4M6uyGrKgEL7VYY+6J23RRJR6EhuwMLTIEu0hCqDwnMJk4kxbOJBIB5lfT1QDbyGu8q1JpFWQ7R4ChhVq6jr36F1d1xTzz72402P+iqQmh6OmJjsyvO0tjd4kji65oHBaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from BN0PR02MB7950.namprd02.prod.outlook.com (2603:10b6:408:168::20)
 by SJ0PR02MB8767.namprd02.prod.outlook.com (2603:10b6:a03:3d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Tue, 21 Jun
 2022 06:35:41 +0000
Received: from BN0PR02MB7950.namprd02.prod.outlook.com
 ([fe80::a13d:7d3e:ad78:6656]) by BN0PR02MB7950.namprd02.prod.outlook.com
 ([fe80::a13d:7d3e:ad78:6656%6]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 06:35:41 +0000
From:   "SURAJ ASHOK MAGAR (Temp) (QUIC)" <quic_smagar@quicinc.com>
To:     Josh Boyer <jwboyer@kernel.org>,
        "SURAJ ASHOK MAGAR (Temp) (QUIC)" <quic_smagar@quicinc.com>
CC:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "mka@chromium.org" <mka@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-bluethooth@vger.kernel.org" <linux-bluethooth@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "Sai Teja Aluvala (Temp) (QUIC)" <quic_saluvala@quicinc.com>,
        "Balakrishna Godavarthi (QUIC)" <quic_bgodavar@quicinc.com>,
        "Atul Dhudase (QUIC)" <quic_adhudase@quicinc.com>
Subject: RE: qca: Add firmware files for BT chip WCN6750
Thread-Topic: qca: Add firmware files for BT chip WCN6750
Thread-Index: AdhpIB6MU+5/g0nCTJqnkH+FPhjNswL7rQCABAqS+nA=
Date:   Tue, 21 Jun 2022 06:35:40 +0000
Message-ID: <BN0PR02MB79503A0F37DC142E914EB94CF9B39@BN0PR02MB7950.namprd02.prod.outlook.com>
References: <BN0PR02MB7950BE0DF597C420F4FAC5ECF9D79@BN0PR02MB7950.namprd02.prod.outlook.com>
 <CA+5PVA7hdmFGEtOa672QVYgaX-Pmv3w+2vexo7-CXqmUabT40Q@mail.gmail.com>
In-Reply-To: <CA+5PVA7hdmFGEtOa672QVYgaX-Pmv3w+2vexo7-CXqmUabT40Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32c3f2c2-d24a-4962-e124-08da535042cf
x-ms-traffictypediagnostic: SJ0PR02MB8767:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR02MB876705626A5852ED523B05B885B39@SJ0PR02MB8767.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TxboHX9WW8wFNVpz+gLPOXJLUjcqh6c3TRl2XZTqKbVdzMK8gmIzjF7WqfpqMMBrCZPFNTe3dzivHAQ7g9/y9xZdbvyFWgPlkbyhsjpGw0mY7vKs0jleN8N10cafJ7QSKaX3fnP+LdZq83MmrdbMzW0ChHY/x8JinknWYSCcZ2m6U5YsJVjNAJVKxZ+ItlknXS6FKL3TTlP4xyJ0EMZXgI75/hyvqgFh9oycIDnI/CqvGRjIHLNJJZH9ia78jXS9u6vKit3f0sz/XNOEX/YK4ltjpBzQ/VJ79XvlyFjTR2AnvJsh17NCFU07DTmj7liEH9Rs+iEXcnpJF40WKz/wzYr/Ok06CA7JRKZMmj8LJcKGbcpbM2d6pYjoVX6G4E9BjVjj0dj4QCPboRuI29z15PsqbZeHk8urWPUmfdLWsHr7Yjcbvznp8kz/7MlcVou9HRyV1Rl9ELNN7QV9TTwUaIZEW1yIiRJo0T3G6xlB7xhHaEPjsyE+uLmloVOXybdzFYwh8CilpUEdyTbEfGJuLO9RaBJYzn9hhEoGDheewdoW5sAJW7iwUPE/wfOrXGYr09sb6BDSsycZ2bqu3Qsn65eKQ8rtsIhQM096DWeGwitTiYnmGqNaZekmGja0TOFTo8Y3SjzlrdeDgNTdi+nrlcfhyvTxgffkLDtaxqGVpTSCUYD/UExQ+iraGR4jwPuOlZtYs2W3MGJiR26Uge6bDHr+iiZzVisT2sy5IgKeP/gYHBvUbAGHwxO3gOD4mWFwne66Ci+/D6fdwAQl77uvUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR02MB7950.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(2906002)(186003)(6506007)(55016003)(76116006)(54906003)(316002)(478600001)(4326008)(110136005)(53546011)(26005)(71200400001)(966005)(9686003)(86362001)(122000001)(8936002)(52536014)(66946007)(66556008)(38070700005)(66446008)(107886003)(7696005)(8676002)(5660300002)(83380400001)(38100700002)(66476007)(41300700001)(33656002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHViLzYyTkpQdU14M2N6V1ZTNHY2eE9tTkpqWlkrSjNNenJyYVF6N0xPczdq?=
 =?utf-8?B?eEdidkExOCtDaEQ4dXFmZ1BsWVY5Uk4vK0d0L3hPMHJvUG9kdE9COW00NVJ0?=
 =?utf-8?B?VERETDZzVE9sTm55NlVQVTVJaTVLTXNUbXdHdVhRYzRHckdXYUdRVFpudWhs?=
 =?utf-8?B?cStYSGR4bGRFdmk4VEJUTEo4M2tQWTl0a3E5Q1grRTFITkZkaFg1Uy9yYjlH?=
 =?utf-8?B?TUg2dU9tNU5VV0ZWMEtjWm1SOHQwQU5xTlJjampEbG1MSFkxQnZ4UkhoNUV0?=
 =?utf-8?B?SXFGMTRLWW80S0N4eWFodGZDUGRnOHgybVU3SGh5U2R1WWtBYkJqQm9KNlZH?=
 =?utf-8?B?WEppVDJaOEozWXJuRkRrUmxQYU50VW1zcDZmeVZwaFZNOUlqMmU0ZHAycmZX?=
 =?utf-8?B?YkdUNmxFRHh2ekZ3MFdNNkhtUlFERUNzZU9KMHBsbmZ5dnFrL0RoQVM3MUtI?=
 =?utf-8?B?LzdHdkozS2htM1IxK2JKTlFMc2E3UmI3Q2pCRmd2d011WlR4MDgvL2lkMitN?=
 =?utf-8?B?SXhUQVB0RGdycTV1Zm1ZYlBDZ202dW81MzNocHBDTVgzNHB2ays3TDB0cmds?=
 =?utf-8?B?Sm1QWjhQWUNYWGU5RjU3VUd0eEIzOU1OUDVVdTA3bml4OE56SXY3Nk9Cd2RL?=
 =?utf-8?B?VE1MVGVhQXIzdDJuZU9VZmxhdXhzb3dFcndhdlYwSnZtdnBVdVJBSW5DMStR?=
 =?utf-8?B?Z011NHZuYkIyaWpoRjNwQW94RGpLa2xNald0U2FzUHdRTENlRVFPT2ZQR0t3?=
 =?utf-8?B?MkpLeklKS0FoSlhqajhpbVlMNmVFc2txMTZ4N0tmMzJkQnVwV3RBZzhnb01L?=
 =?utf-8?B?bWk5SnFVUWcwbW4vQXltUGd0amM3aVFOaDA4VEthZG8zUWZ6OGEraEY2Y3kz?=
 =?utf-8?B?U3BpaXBXZnRBSnVsd2VKUys1MWRiWVYyRzN3UWFnNWxKSS9NNVluT3dpS1Zl?=
 =?utf-8?B?bTQyMnZFMnlMbDJ5OFJ5aEZiZXhoV0hjbVI2aEtSWVBzMVFvNDJsS2dWampv?=
 =?utf-8?B?Y1lMRENGMjFmZVZwYnhTOFZQcFhtT29ZeEdFK3ZIdE0vTFgzbm1BOGY5aEE4?=
 =?utf-8?B?VjZVaTNmUE5lMVB1YklZUzlXamlNQTdMZDVLUjlaaXEwUmR6TGV4OHNuSjVy?=
 =?utf-8?B?ZWdaRU5EL09Cek84RExNQXNjWWhCZzN5VDd5NC9rNEViRDRLeGEzMXp5aWJq?=
 =?utf-8?B?MWpldExPam44STQ3YTBXdFZyejRCdGdaZGVGK0x3Y0YxK3JsTCtERUhnZnhh?=
 =?utf-8?B?T21GUFdiQ01SOTBJNysrNXJoUzh6aGNtT2ErSUl6bVdDREcvL0NGYk02clcw?=
 =?utf-8?B?am55eWgxSkovbHEyZnI0RHJjYWdlZ0FvTmdxMkdqYS9rblJUVVU5UC9Jelo4?=
 =?utf-8?B?bHNPMzVNSUhnUENIazkxNXByQTVOclB2N1I1ZWFYN0lTL2NJMktUbzdXL3hN?=
 =?utf-8?B?UHVUSCtqY0c1dUJmS09XL2tKRHVQUm9tTitqUUI2WWhhdjU0NVZndk55Mnh1?=
 =?utf-8?B?SVVpNzZUaDFybVlCd0xvSWQxUVdWU2c4M2JtNU54SXNjWUVwTFFFVDVWOU5K?=
 =?utf-8?B?dEs0VWR3RGJSZXUvWlZmN2EyNHB4NG1uVFFURGtGZGJBV3ZBN3JMdHBURTRR?=
 =?utf-8?B?dkYwR3FQUzhQREFJZHV5aE1VM2RvM2V2N2V0b2tUR2M4MzdVK2ZsYTRBNzBY?=
 =?utf-8?B?b1BNMFFqdk1mbk5wTnE4bk5mQjJoaEs1NmhCaUx6UWNmOExMZUdTNGYzWks3?=
 =?utf-8?B?R1haMjRkdVdMcG9kTjBHTi9Xek9ZZ2VZaElzVmZGNGY4cFZaV0xsYmd3S1VN?=
 =?utf-8?B?LzFMcHZRVUc5VXdKTWpBd2tpRURTQ2RZd3FZcVBvWCt2L1phaTlteGMxVVhx?=
 =?utf-8?B?MmFsUXAxKytFRDFMRDVjQnQrYU9hQkI3aE9pRnFBVW03cEFVVmE3TXJGNzZm?=
 =?utf-8?B?dFI2QmNUU0p2L0dFc3RkdTBJd0xsNHBYcW5VMmVUS1RGb3c1RFV6TVZ2VFhG?=
 =?utf-8?B?SjYwUnNRWjd4Vms4VlV5SVR2MXdtb2FIT0c4T29CZ1ArOTVsR0lTamhQemhy?=
 =?utf-8?B?bFZsem5XZ2lWM0lmcUhHeWd4VVJUTUs3bzN4MDc3NWlaSEUwMlU2OE93M0JG?=
 =?utf-8?B?SEJlbkZPVXBQdThyRkprN2hNaDZ5bHRZRGlKSGp5dW0vcEVsT2w3dEpORFJL?=
 =?utf-8?B?YWNGVkZQaVV5cVRqb2h0ZnpOOHFTM1RDQ1lWVjdOK2U4STNLVWc1L2R0eVA0?=
 =?utf-8?B?dmRjNXl6SmNLaEVxWW5IdzBwU2RoWlRaa29PV3NRYktiZXh6cC9kaUVEU2VO?=
 =?utf-8?B?MUQzaktUN1dZaTl1TncxTE1EKzhSVDdoZ2JVMDNUWGs4TEFLQTUwUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR02MB7950.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c3f2c2-d24a-4962-e124-08da535042cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 06:35:40.9599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z9/EFDNvhQabGvf4yoe2wQEqSKipjl1KXubVorhphHN0x4gvaaWDvB5BB6mISyaCWC2iRF+ERecJZb9mobU71g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8767
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9zaCwNCg0KWWVzLCBpdCBpcyB1cGRhdGVkLg0KDQpVcGRhdGVkIGZpcm13YXJlIGZpbGVz
IHdpdGg6DQogICAgQkxFIGF1ZGlvDQogICAgQVNEIGFsZ29yaXRobSBpbXByb3ZlbWVudHMNCiAg
ICBMUEFQQyByZWxhdGVkIG9wdGltaXphdGlvbnMNCiAgICBMRSBwb3dlciBjb250cm9sIGNoYW5n
ZXMNCiAgICBBMkRQK0xFIGNvbmN1cnJlbmN5IGltcHJvdmVtZW50cw0KICAgIEVUU0kgcmVsYXRl
ZCBjaGFuZ2VzIGZvciBRSFMuDQoNClBsZWFzZSBmaW5kIHB1bGwgcmVxdWVzdCBzbmFwc2hvdCBh
bmQgdXBkYXRlZCBjb21taXQgbWVzc2FnZSBhdmFpbGFibGUgaW4gdGhlIGdpdCByZXBvc2l0b3J5
Lg0KDQoNCg0KDQpUaGUgZm9sbG93aW5nIGNoYW5nZXMgc2luY2UgY29tbWl0IDI1MWQyOTAwNGZm
Y2UzNDYyNzc5ZGJkMDgwNzNhMmNkOGRmZDIwODc6DQoNCiAgYW1kZ3B1OiB1cGRhdGUgYmVpZ2Ug
Z29ieSBmaXJtd2FyZSBmb3IgMjIuMTAgKDIwMjItMDUtMTYgMTU6MjU6MzggLTA0MDApDQoNCmFy
ZSBhdmFpbGFibGUgaW4gdGhlIGdpdCByZXBvc2l0b3J5IGF0Og0KDQogIGh0dHBzOi8vZ2l0aHVi
LmNvbS9zdXJhajcxNC9CVC1maXJtd2FyZS5naXQgbWFpbg0KDQpmb3IgeW91IHRvIGZldGNoIGNo
YW5nZXMgdXAgdG8gOTJmMTA4ODQ1NGY0MDhmYTI5ZjFlY2E5ZjhmOTJjMjA4ODgxYzA5OToNCg0K
ICAgICAgcWNhOiBVcGRhdGUgZmlybXdhcmUgZmlsZXMgZm9yIEJUIGNoaXAgV0NONjc1MC4gKDIw
MjItMDYtMjEgMTE6NTY6NDAgKzA1MzApDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NClN1cmFqIE1hZ2FyICgxKToNCiAg
ICAgIHFjYTogVXBkYXRlIGZpcm13YXJlIGZpbGVzIGZvciBCVCBjaGlwIFdDTjY3NTAuDQoNCiBx
Y2EvbXNidGZ3MTEubWJuIHwgQmluIDEyOTM0OCAtPiAxNTU1NjggYnl0ZXMNCiBxY2EvbXNidGZ3
MTEudGx2IHwgQmluIDExNzEzNiAtPiAxNDMzNTYgYnl0ZXMNCiBxY2EvbXNudjExLmJpbiAgIHwg
QmluIDU2MzMgLT4gNTgyNyBieXRlcw0KIDMgZmlsZXMgY2hhbmdlZCwgMCBpbnNlcnRpb25zKCsp
LCAwIGRlbGV0aW9ucygtKQ0KDQoNCg0KDQpSZWdhcmRzLA0KU3VyYWogTWFnYXINCg0KLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEpvc2ggQm95ZXIgPGp3Ym95ZXJAa2VybmVsLm9y
Zz4gDQpTZW50OiBUdWVzZGF5LCBNYXkgMzEsIDIwMjIgMTA6MjMgUE0NClRvOiBTVVJBSiBBU0hP
SyBNQUdBUiAoVGVtcCkgKFFVSUMpIDxxdWljX3NtYWdhckBxdWljaW5jLmNvbT4NCkNjOiBsaW51
eC1maXJtd2FyZUBrZXJuZWwub3JnOyBta2FAY2hyb21pdW0ub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1ibHVldGhvb3RoQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJt
LW1zbUB2Z2VyLmtlcm5lbC5vcmc7IFNhaSBUZWphIEFsdXZhbGEgKFRlbXApIChRVUlDKSA8cXVp
Y19zYWx1dmFsYUBxdWljaW5jLmNvbT47IEJhbGFrcmlzaG5hIEdvZGF2YXJ0aGkgKFFVSUMpIDxx
dWljX2Jnb2RhdmFyQHF1aWNpbmMuY29tPjsgQXR1bCBEaHVkYXNlIChRVUlDKSA8cXVpY19hZGh1
ZGFzZUBxdWljaW5jLmNvbT4NClN1YmplY3Q6IFJlOiBxY2E6IEFkZCBmaXJtd2FyZSBmaWxlcyBm
b3IgQlQgY2hpcCBXQ042NzUwDQoNCk9uIFR1ZSwgTWF5IDI0LCAyMDIyIGF0IDU6MTIgQU0gU1VS
QUogQVNIT0sgTUFHQVIgKFRlbXApIChRVUlDKSA8cXVpY19zbWFnYXJAcXVpY2luYy5jb20+IHdy
b3RlOg0KPg0KPiBIZWxsbyBUZWFtLA0KPg0KPg0KPg0KPiBQbGVhc2UgaW5jbHVkZSBmaXJtd2Fy
ZSBiaW5zIGZvciBXQ042NzUwLiBDaGFuZ2UgaW5jbHVkZXMgdXBkYXRlZCBUTFYgZmlsZXMgdG8g
Zml4IEJUIFNTUi4NCj4NCj4gU25hcHNob3Qgb2YgcHVsbCByZXF1ZXN0IGlzIGFzIGJlbG93LCBs
ZXQgbWUga25vdyBpZiBhbnl0aGluZyBpcyBtaXNzaW5nLg0KPg0KPg0KPiBUaGUgZm9sbG93aW5n
IGNoYW5nZXMgc2luY2UgY29tbWl0IDI1MWQyOTAwNGZmY2UzNDYyNzc5ZGJkMDgwNzNhMmNkOGRm
ZDIwODc6DQo+DQo+ICAgYW1kZ3B1OiB1cGRhdGUgYmVpZ2UgZ29ieSBmaXJtd2FyZSBmb3IgMjIu
MTAgKDIwMjItMDUtMTYgMTU6MjU6MzggDQo+IC0wNDAwKQ0KPg0KPiBhcmUgYXZhaWxhYmxlIGlu
IHRoZSBnaXQgcmVwb3NpdG9yeSBhdDoNCj4NCj4gICBodHRwczovL2dpdGh1Yi5jb20vc3VyYWo3
MTQvQlQtZmlybXdhcmUuZ2l0IG1haW4NCj4NCj4gZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVw
IHRvIGRjMTMyMTNlMzdjZjQ5YmM4OGUwMjRiMzdhMjNlMzlkMjJiM2Q1ZmE6DQo+DQo+ICAgICAg
IHFjYTogQWRkIGZpcm13YXJlIGZpbGVzIGZvciBCVCBjaGlwIFdDTjY3NTAuICAgICBUaGlzIGNv
bW1pdCB3aWxsIGFkZCByZXF1aXJlZCBmaXJtd2FyZSBmaWxlcyBmb3IgV0NONjc1MC4gKDIwMjIt
MDUtMTcgMTU6NDY6MDAgKzA1MzApDQoNClRoZXNlIGFscmVhZHkgZXhpc3QuICBTbyB0aGV5IGFy
ZW4ndCBiZWluZyBhZGRlZCwgdGhleSdyZSBiZWluZyB1cGRhdGVkLiAgSXMgdGhhdCBjb3JyZWN0
Pw0KDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NCj4NCj4gU3VyYWogTWFnYXIgKDEpOg0KPg0KPiAgICAgICBxY2E6IEFk
ZCBmaXJtd2FyZSBmaWxlcyBmb3IgQlQgY2hpcCBXQ042NzUwLg0KPg0KPiAgICAgICBUaGlzIGNv
bW1pdCB3aWxsIGFkZCByZXF1aXJlZCBmaXJtd2FyZSBmaWxlcyBmb3IgV0NONjc1MC4NCg0KQ2Fu
IHlvdSBhZGQgc29tZSBpbmZvcm1hdGlvbiBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgYWJvdXQgd2hh
dCBpcyBiZWluZyB1cGRhdGVkPw0KDQpqb3NoDQo=
