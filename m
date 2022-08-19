Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629AF599586
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239690AbiHSGsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346481AbiHSGsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:48:46 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2082.outbound.protection.outlook.com [40.107.114.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7244F65B
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:48:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAUzv2fc4ngY3/Ii/gF8+e1pTAJnPVZB6Gw9esaDl8DBGwbe7TzUTwrjoQHwVzHGbnRRl+rayhCyiBstRsRjxglKBpHa0BqySG/kh7ohslbtfcSy/JYyMpkDAH551EJjXJ98tqxrM4TzLdhva1NwqKcrhuGI8X/LsLNR3VffIMICJdz2LfNNreAL6micuxpY1LO7Qw+9+Hr5n5Qvy+6TvFwkukeKQr1J4GiCCbPR1FW2xUW08q3ag+DsvzaqPmHC9JtstPU8ApctMn/JivyupWOujcq4UOiMLGcBIb5EOUOAPBC0exHtFhywVL8F01rQlVrnax69tI24dq+MheR+Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seJnhdF28M40BeZkPPgAe32WFr27GBJ3hWYaf/WTTtg=;
 b=VtVu31m4TBTNC3ZJgouvJgwAPi06RuyNNI3FHklUwZUxboW+nnvm5h63xwOuOcURiZ87ZtgTeALliC6GI2pb7ZhqqWozuVqPIABI0J5ISrNCLrCtjGrnGeZba3pzd3PibL5Y/SiSeLbNWevWlK1GtukARDkd+4svZsEKSCPbCv1pgxc9cr96hUdu3uLjct7paMbZBlLhVrLGxieXhOkhPQ7lLe/fifn1ATRpRrVywEUf+NIOL/E5ANNgHSmt3NFjH+etCBGDiCETS7N++KRIweBS/Mt4aUD4YGYn517U8YgkP5HqRnP5hPWC/bbGjKpBHTms2PyLCaG4gV6gRExprw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seJnhdF28M40BeZkPPgAe32WFr27GBJ3hWYaf/WTTtg=;
 b=LgsA3DL54HJqPMD483Eu/J2uVsJOgpmRupzy5xwA4+dygtZyo44nyfvW8E0SkRLjBrfOtoFzEyyCODS+5ooI42w6TC0IfSfRfka3eYAAQ6Mpoho6aGZGaMS1XzHSFG1gms5Gy729xACiiIveppIhxAaMlpHFJI4ok0YqXHSVO90=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYYPR01MB6684.jpnprd01.prod.outlook.com (2603:1096:400:c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 19 Aug
 2022 06:48:41 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a%6]) with mapi id 15.20.5546.016; Fri, 19 Aug 2022
 06:48:41 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm: memory-failure: kill __soft_offline_page()
Thread-Topic: [PATCH 2/2] mm: memory-failure: kill __soft_offline_page()
Thread-Index: AQHYs3vHgShSCwxubk2vNqgBxyOLoq21yHeA
Date:   Fri, 19 Aug 2022 06:48:41 +0000
Message-ID: <20220819064841.GH613144@hori.linux.bs1.fc.nec.co.jp>
References: <20220819033402.156519-1-wangkefeng.wang@huawei.com>
 <20220819033402.156519-2-wangkefeng.wang@huawei.com>
In-Reply-To: <20220819033402.156519-2-wangkefeng.wang@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9cfaf39-218a-4bc7-6436-08da81aeda66
x-ms-traffictypediagnostic: TYYPR01MB6684:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MMCEcHgSjZqpMi1YpzMpJeJTrMmxkPJ9OIvtUn9e9MGWCEru8aJNjVwBYOrW9W1kBpMswuxpQVC6lra5DxTPZqQGP4Pw+rsCt4fVZ+1x7ZmbmAFHLMgBfRCWt9C5MDQOSdqGlMi/MkVeQmvCbqAohwkab6JDJHPWIIixXJIxDriOe79SiFwBtP5T32p+arwAtiHAKlhEo5ESgT9zGjptrRxjHpS/v9ZwEDbwfAqCLeO+DuPLqYJ83eTMqEJm2+hqPQlKiO5GHvZ+eT9Ck7XF6sUqd5kz1MSJM16aMsexGNOPmqmfIKAlsQuSc/ijZBs/FLgCC9l6g0l8uFlN+hlDdqww3nd/T5KjTln3C79Bi/yjOLTDZg92uAcIq6kFOvnTS52OxoCyxQCG0MKznyFapL+TAhTakIpQllz6AxF9wjOE4KcUgLtI5WL038EY5T78+6GGwsvDfwdA3xTXkb1yYnHGNHE7P18RY7m97/jrH3S3ndauD+5Exs3fFyNjvHH1L4+7JK5R27GNL6k5VoJCSqauvfp28OZ82Xw8lmQzpHoNj0f+3SOk2xi36nfOZmuNGXwcGmnsCR0sFmYDGY3UkzS1Dzx7feu8a398mAO1NsF5iZ+5VARh9+Oc+wDt2waxXPr/oJCsN1h0/1eAqHycBzG0yZ+g87GTiUAXQIQlOYNNNW7V5gcOLWrRg7kaEuDyzk54Ya89bdukT8QUSh8yyvNkteBrAy8Qmy+O7lWBcUqgYlDH6tMYCnNJgHJiOvXoXVKlMLrNxIrbLKThbCKyJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(558084003)(55236004)(9686003)(6512007)(2906002)(38070700005)(82960400001)(6506007)(8936002)(5660300002)(33656002)(41300700001)(478600001)(122000001)(26005)(54906003)(86362001)(1076003)(38100700002)(186003)(66946007)(71200400001)(6916009)(66556008)(66446008)(64756008)(66476007)(85182001)(316002)(4326008)(76116006)(6486002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTNYcCt2MktGd0dJMi9NRGJXaWVTZUNIYmpmckRVb0tQT3FMMWFCV2ErYnNk?=
 =?utf-8?B?OGZDdGRtbW5nc2F2VkFVb0xYNS96VE1zV2YzbE9WQTVUSWRxSlR4ZE5qdnZ4?=
 =?utf-8?B?ZzlYOUxlcXZKenZNaFhMdU9aUTU4M1ZESE9SaS9RRDFRUTRNM09NcTROVllV?=
 =?utf-8?B?Z2R6WTJTNEhsTHJWV2tlKy9XQkdNOEh0cVFaYSs4RjFFRXRHODJBTS8zblow?=
 =?utf-8?B?MXVnVklaN29WcVpHZFU0K21DR2E3ZFg4bjFlVmlOKzkvZ0lKQmlnYkQyRjFT?=
 =?utf-8?B?SnZnNm9EZmhIbHRiNkFGazU0ekJqeEU1UTJtK2NDMmlYTjRtQXlPc3YvY3pT?=
 =?utf-8?B?ZEplL0Y0MFI3SUw1bEtGN21pZVNNdjBibUFiRGUrdDZsb3ZtNHZWbjY0Mk92?=
 =?utf-8?B?OHB0eUVPaWV5VWM0QXZHK0dTemJWZS9SZmpmekROSUl1Mm5mVzFLWTRQbzlV?=
 =?utf-8?B?bk85OGR2Nmx4bm9zNWVFQ3FleWh0dUZTMFFvRTdBRkJ6RG4zK1VOZjkyckVD?=
 =?utf-8?B?UUZqT3lQUlFiSE96NzhRRExwdGR2MlRzVnFVNEo4cDUvZVgxS0pwWHhFdkpv?=
 =?utf-8?B?UDY3Rk9FUkltRG9qM2pnNTFCLzY4OFVuQ2RJUllmZlpuS0NLRXZGOGNLR0RV?=
 =?utf-8?B?UGFBYWVVUUFSWjdFM1NpZ2VhUytycitrYUFCNlhYWFhiRk1HQm02b1BGeXl2?=
 =?utf-8?B?Nm1tOTRvREQ4US9zb2VhdW52UnQzN0FXamthcjZZSW9va3dSNGhzWkM3TlFV?=
 =?utf-8?B?MCtvcytHM0s5WUl0NzlpZXVDekg5cnA3TkxzV1pCQyt5dVdENHV5YTJ5QU9l?=
 =?utf-8?B?cS9hZ2Q1dDBUZU9pSFdodDJIcmtTQWd4b3hweUxQZlhRN1J2TFM3cjA1YlRM?=
 =?utf-8?B?L0RTWGpYbEM1RnY5UUtteHZkcnV2b2FZcGdOVklkTVJTS09jVm1TdkcrT1Fj?=
 =?utf-8?B?T1F6bHBCZUl4OHJoKzJqWmwydmZNN3FqcS8zR1ByNnlXQTJ1YW5nQXYzeWM1?=
 =?utf-8?B?Yjc0STlqUmJFZ1pYZSthQ3BJTjNhS3RDaUg5WjJTaWVPTU9XVGF4b0JvTGpX?=
 =?utf-8?B?LzYrUktNSHZCZlpyUFdRKzFrZXNHNmJoTlRXUmtPcHExbTRoNjk1RWZ0VC8w?=
 =?utf-8?B?RTJ6YndRZ3JKa1pEY0dHdzNIUnFaaGh4bVg5T2JCTnBYVUFLKzhJTE9uNXRk?=
 =?utf-8?B?SlZCS1crMHZSNEZuSFRqekJDakxkR05RUStkZGpkL3ZVK3Z5REJvZkhqdmF4?=
 =?utf-8?B?N3VNWDdwNE0xQml0WTk0ZnhoQXNIbld1VDdmSnlNZVQvL1Budy93ZTRaRnYy?=
 =?utf-8?B?Y0lld0FRT2p6QnRybFVzaStkcld1L1YzUndRTXNMbXRTSElENE9RWVE3K3NY?=
 =?utf-8?B?OGJXZ1hSQStUakpJWGliMnVjZ1JTV3R2OVcrbnpvNzhveWNCUUNDZHV3bm1R?=
 =?utf-8?B?NFpkajdIeUlaVEllRGZ2OUg0YlJRcjVYWVo3NzYxbnVHTzVrT01nY1ZUS2xO?=
 =?utf-8?B?UWZHcURVRDJEa3JFRlBmYlNPUEMyeXJZZjVsRTl3ZHBURlFxMkgrd1hDTyti?=
 =?utf-8?B?UytZdWJoQXFZZHQya1Vaa2xCenU5ZGRudVhMMlRnSjg2ZXZrVzJaalNZckxP?=
 =?utf-8?B?eEswbHZVdlQ0NkJmVE9oZkkwQkdvektwZm0wbXRJMkZ2SnVTQlhjNkRnVXdM?=
 =?utf-8?B?Wm40ZXQ3eHNoR00xWVJKTEhGZmxHb1psd21haEhnL08xbEV4SlZ0ZFg0ZCtn?=
 =?utf-8?B?aFk5Wlp4REk3eENCNTRwZFl3dVNDcjFUSGNzenZVY0VFNWN4dE9WYkhuamZ0?=
 =?utf-8?B?dmNDSVFFbnh5T1MrVEUxbjRLK0ExQlV5YjBJYVY3OHJaVlA1eGV3dmtEdmYy?=
 =?utf-8?B?WG5zbW9DdHhlTTIyQUI0djlTV0ZwY2l5MUEyY2RzRVNvdTJHeGtBbWhRd1dR?=
 =?utf-8?B?bkRQS1ArWVBDYzVYL2I4cndBQ3NXYytibjlXUkJqdDNYdHFhbUROL292MzJD?=
 =?utf-8?B?ZXYvN0pUNWRUVkpnY1p5ck1RaWtLYk12b2xkcE1nYVNrYkkzYTZHMTJNSWpj?=
 =?utf-8?B?UCsyQ0Z1K1htRHFjMENKSVJCOURCOEI1M3ZUVmIwaEVlbVprK3hzb0tIWkQy?=
 =?utf-8?B?OHNSVi9uNzAvaWFPcTlwTktBUTk0a2U5eTVaSkRlM29MNThmR0JwWUl4NGNV?=
 =?utf-8?B?Vnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3053B4FCAF0D2948A527388EA18B6F0B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9cfaf39-218a-4bc7-6436-08da81aeda66
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 06:48:41.4313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mQ3ltbrWk8XNYW19npyHbQDbvW56+12rfeSiMTAOb6ujku9z9Xs6BUZ4cb6s+inroqotadcJtwWv5xOwg/EXgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6684
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBBdWcgMTksIDIwMjIgYXQgMTE6MzQ6MDJBTSArMDgwMCwgS2VmZW5nIFdhbmcgd3Jv
dGU6DQo+IFNxdWFzaCB0aGUgX19zb2Z0X29mZmxpbmVfcGFnZSgpIGludG8gc29mdF9vZmZsaW5l
X2luX3VzZV9wYWdlKCkgYW5kDQo+IGtpbGwgX19zb2Z0X29mZmxpbmVfcGFnZSgpLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogS2VmZW5nIFdhbmcgPHdhbmdrZWZlbmcud2FuZ0BodWF3ZWkuY29tPg0K
DQpBY2tlZC1ieTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4=
