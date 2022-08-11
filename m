Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770C8590781
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 22:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbiHKUmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 16:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiHKUmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 16:42:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE14373328;
        Thu, 11 Aug 2022 13:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660250565; x=1691786565;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3vLg0+mCLeA9SwStgXq4peShfVMTd4/tmJM/4oGMcLY=;
  b=MSE0nG5lEULxU64qgSFvXJip59UtUuDa2JYyfJyVPA2p/WPJl2xa29qf
   QOe7ce9RjpCKwH9Unj00dE1+DoldH+Ea6A7Dd78qtWhkUeiYFVnEtb/3s
   05bkY1HsCCMIK2xniSlA4uEL7+8oPY8QYRo01kjoY00q6qGrtiFwbnFFc
   +FymejyZmuLef3eATF/FzR+Msfyumi8T+eK36zIUZBJSBBSVr+aELsfnv
   /npAwXYULRdOO+SLC58oi2+ELqRI9LxNtC9owUi4MA+rnP5wCxaCHTkn1
   3aapPfuHmLy/IIp6UnV8sM2159eBSMLbi4q4TMM++pLwzbEe1YO6FTJxa
   A==;
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="175915797"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Aug 2022 13:42:45 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 11 Aug 2022 13:42:43 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 11 Aug 2022 13:42:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oChPk1YMSyQbF3p8izORiuBKfSZtaCVPJb/qqVzMu+D4sf0fDU2o1vOjR6bgHgMVpRxF0KqBcbWi+HPiVQO1tRIXkQSTyAi/Bi7fSkYcRahTfQ/QjT/21kipbxcWitYvNtrtsc5wcwwDvynMXWJ2Wtvk60TtKLWGnXDts/zwm69JGh2jed0ICc+mmUwKRQyfTwH6ba8uxGGCHUd+dAx1dO5Y2tIW4dp8nTYSLElO1FmhkwTm62dnQoKcnEzoko9ALqnfDTXGoj7eHcCEaSULu5gKWFApiuJTMn+mlE8PwaRc6kNEzqYs6zjnvjNVi50XLTGC/rK6c0SXSkBylVUNag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vLg0+mCLeA9SwStgXq4peShfVMTd4/tmJM/4oGMcLY=;
 b=GsRWGmqCyOeez5ilw0yfjpf/Og6rrhLhiJ0YoG2/2VAIAI2UE8dvvWoRmtP4hcWN/xE5O49+Woaht6mftzTCcZyF8xZwxO4TOvCLhmr1D26VH9SwwQ0/hNcqrM7aqlKupAFP6w6KDMhCJIe5OdYb/HIjUUqpe+32sG2YayY4j1dDjiKG1jVN6xiuzt74OPTqK0Aq75Tf6MKw90iHLNYuGOCUMLlGXkbaQku2bGG3ohbt1I8qxp3pzm9Byv223ykhuIPnElUzYTilPpho7UW25hMoU/go6Kfs/XVDgBENbUGt8sfs6xcsC7pLBoV4cDcSa/82cuikP59MVCespO7ytw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vLg0+mCLeA9SwStgXq4peShfVMTd4/tmJM/4oGMcLY=;
 b=rLwBJlYfEvPWD8zpcWhisFz+RglhhH74HhUdmntQpl8uftJoKmQAJU3EhtUSJ045FRBB9kYRV2DjTF8WFhOuxBzBN8zOlAkG7Wzsdw+4dtm0XWBoc39opFuOMGQk+qPqzni/cykN/xTAUuPOanGY5W9dOwXq/DcMJ/OizrkP+2g=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SN6PR11MB2829.namprd11.prod.outlook.com (2603:10b6:805:62::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.18; Thu, 11 Aug
 2022 20:42:36 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Thu, 11 Aug 2022
 20:42:35 +0000
From:   <Conor.Dooley@microchip.com>
To:     <mail@conchuod.ie>, <Daire.McNamara@microchip.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <palmer@dabbelt.com>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: dts: microchip: remove ti,fifo-depth property
Thread-Topic: [PATCH] riscv: dts: microchip: remove ti,fifo-depth property
Thread-Index: AQHYrcF/MxG6txRUrkKVM8A5bjQ2262qKkKA
Date:   Thu, 11 Aug 2022 20:42:35 +0000
Message-ID: <b51b78c7-6b75-908e-53de-6585cdd32deb@microchip.com>
References: <20220811203207.179470-1-mail@conchuod.ie>
In-Reply-To: <20220811203207.179470-1-mail@conchuod.ie>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 738be310-308e-4f7e-c3fa-08da7bda05f6
x-ms-traffictypediagnostic: SN6PR11MB2829:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o2NK8UmCgRoAJnpHdlsaPqcqKvLtuZH9NtWsUldaM7tsBhk9NRc+Ookk/eyNdDP1F/s2fcacTrWn7j6KH2hP8tulvMjGlW3lSMy+GAPrXOxxxC9V1ei6YtCI4ETkUq/R6w5PvwmvEcUQMQ4MoANXS0a+Sq4V/lEzjaUkU+3kM9xpyY1TMqUW2nMWA0QGXN6eGpPpqSWgvri7qTX19mxxOu6lRpMVXBjZQwKlDUwwTr2d8n1cpDn+UBJxqVnZyif1XOaupI0rN/0CwvJY4tFPrm2weGTGOwocE74fzm8urV2riJTrOMCczXt9C8c25F5o6ZLcNtY8EEWwR45f6fp5Aw4gVQFF5E5T9YyZItM7YZY2unH4IbWdVexxITIy8M2lIXLAe44HR5RHjG7UhWrFLTEPcTnzVehUgcIsCUL1waB3rEBfkKFPjbEACmoJqQ1/sQ1oIzeV9JIN+1+Mj2Gi5D6laU5lNJ9CpZqvX6IAmYfGgDmSICwFm8oAOHm5jkmhE/+GRD7hZPKIXZq/BwxG8Oe3310fuszK8U+m+TGtfAmUfo8JcNQf8VyYhxC8NKI1UJSjF6+1ZSmPE4r05VLe+Btqv4Bu1eoVn0BKRtJmVem2MzICuKEMzpVQsilkHDV1xPk64M7qkRES5l9s2gDTgMIGcfVDrPtRkp4hXylaOfSHHVpL87UsxXF7vBDQ+dfXb36Sg/nc1YQOMImsSGp/C5uk1eCd2JAk8wHiU80Dni/esxcbqRsaXW7ZEH0usWPzN59L9PimUD5Y+03sK1egvp8hlczKJlwkr7LCEPYfueRx2QiuBrsYVM8AOCub6UPmdIBCMY4NrtVvOXoZvFR0BwozkYaQ6qtBN7upTCzue6TkuUkXlrklnI7O6pU0KM83
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(376002)(136003)(396003)(346002)(66946007)(66446008)(316002)(8676002)(36756003)(4326008)(64756008)(5660300002)(76116006)(54906003)(31696002)(110136005)(66476007)(86362001)(66556008)(91956017)(122000001)(83380400001)(2906002)(186003)(8936002)(31686004)(38070700005)(38100700002)(6512007)(71200400001)(53546011)(26005)(41300700001)(478600001)(6486002)(6506007)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnJWQ0hlSkU5ajVZZzJLMUhsd2VEaHJCaWI5Y0htZ0loVUpSMWNlN3JXQVFp?=
 =?utf-8?B?RUVPS1hldWt5QkxSeUdEd05lM1N3K0VoNWp2Y3hKeGg2bndVcTg4NnRYRG53?=
 =?utf-8?B?WDVGeTFaQXh1bUNUOWJyWkQxRSt5UkNCTHRYcTdULzlsSFhMZTFTY3NrUGVT?=
 =?utf-8?B?SVJUWGlaQnM2cDk2ck5vSUg4bW9IZE5weEk0eDV2SnlTSXpVRzlMdUlkVHVh?=
 =?utf-8?B?eFB2clRiUHZIUUJSSEdxWm1ReEFCTlE1S01ySGV0N2lZRWNiMVdrRnFrS21T?=
 =?utf-8?B?RVlsekNRNXFBODdFQ0hFejRIOVNmNTAyUHdBWkpkSVRyVXdiNGNOdXZ5QVZv?=
 =?utf-8?B?S0lpUmQ3ZnlBWTJvTUZGTG45cUFHSkE2YTFheWgzdzUxSUg3akJqZEd2Tjdo?=
 =?utf-8?B?YjFDemdFVDVoYUNXWkgzMmNCaVlzMUJaVFFJWmxjenl2cFhlK3Q3cjduMDkv?=
 =?utf-8?B?bTdsckxFeGlUWTNvcUpmWDFlRjhiVldiWlAxajNkZi9JTWRCOTBiMVZmWU4z?=
 =?utf-8?B?V1l6UE5BbUJRc3dNK1JQNDN1T1RqaDNxa09qeGhZeis3aUNHZ0ZyUlorS3ZJ?=
 =?utf-8?B?M3Z3amNib3YwUk9CM0RiZFUrdGhZNGtuWWZsdjh0TDllOGdwUFovWExFYW1T?=
 =?utf-8?B?RmRIK3k2Wk9IQi93dDN2VVVEd1h3WjZlbFgxdUNqcGFEOGJMR1hwQXEvV3Nt?=
 =?utf-8?B?OCtsY2UzeG0vNHAvYXgyN1dMNGJxQVB3RVVQakFkSzdxNnBxOW1BVWNjaWha?=
 =?utf-8?B?MkY2UlJLOHZUOHhjQ0p2RXFOT0NIV25kM3JIN1ZrSFdWak1rRUFhdEpTNFls?=
 =?utf-8?B?QkdmVW40NXJXeEREVHFWSWcvWllGQ25kR2kvSTExYVpBMjJIQ1RRb3hnUEtE?=
 =?utf-8?B?L2NiRGZyYlY4SEZpeFRLdExSMmcwOHJ2TjNQbktmVFlyd0RuYll4My9YTGhr?=
 =?utf-8?B?OVgyWDR0K3o3V1JkQ2NzUkFHbEhUM2tHNmFISlFCZU1mcVl3RHR4bHdZYndD?=
 =?utf-8?B?SmlyeXo4Z053QU9HZWZmVzF2djdmRDdmWnNFR1JobzduWWVTT25kRHBiVkti?=
 =?utf-8?B?Y0JtUFhXQ01SbFcvSDVxNmZpRERCNGdWVjBxemJTSENTMUtlWmxPbGtBdFU4?=
 =?utf-8?B?eW10RUVSaG5WRzZoVisvWnpnSFgwbW4rbnoycGtCMktYODhrbmpxWlcyODhG?=
 =?utf-8?B?T2JPVExYcmpiQ3kxQnU1dnRQSFFuS1JQdjkxcTljRmd1QlRjeE5sOXhGK1NV?=
 =?utf-8?B?WHpOc3JHaTdPd3FRL3RETk05aTR1RXZmb0V5d1Vzck03WVNOQVNzai9qUG92?=
 =?utf-8?B?NktoNU9CcEx0V0lubEdJQU5mVmhiNWtiNHAwZ0ZEdy81TnJzaXM4SWNnTGo1?=
 =?utf-8?B?VklFdFMwdnptLzV2bXovcXRrREc4V2ZDNjVzRmhWeU5FY25sc2NtU0N5UUdB?=
 =?utf-8?B?MjVLL2FsZGhyZUhxNFhXWnY2ZXRqREozczBsZnVuRGhPODBoaFNEN2tncTZN?=
 =?utf-8?B?WEhjSEJ2RTFwelpMSS9pSUU2cWcrTnJqcFpCM1ptUkN6L2tRRUU0MlRZS0hH?=
 =?utf-8?B?RXFlck1BZG5KZjhEYXBlbmlzc0MwVU4yd3ZXRWIyK3lCejRuc3JWTzB0OFdL?=
 =?utf-8?B?SFpUMFY5Q2srTHBDOVhPM0ZhU1pxVzVYZm5QaUZCVkxLNUFGam9OTkxPdktR?=
 =?utf-8?B?U21qZEp5UWdkNHFoeGJyVmV2SVk0blU3cFZWNGtucVhBbk1FYm5YTTdTUFdW?=
 =?utf-8?B?UUM3QnZDNlA0VEtESTdLWFZaa1ZZTXJXN1VGQWh5eGZYeU5rU2RoaWJGR3Fr?=
 =?utf-8?B?UWlBOEtOcGVJbWZGd2p3cXJVRlJUcVVkdUlTdFYvbVI2SWV6RG5ONmRUaU5n?=
 =?utf-8?B?RXRUb2Q0Y0NuRFhJb2dXekYrWE5nWnY4YU02ajNZZUlab1ZENjQzVCtFRHVx?=
 =?utf-8?B?QlFvYTNDR2Z5S253OFVzRXlnNUpMU3FQeVFkeFRsTXIwOWhLNmtubXEzWVA2?=
 =?utf-8?B?VGNXVVlDZ2sxR2FocmtRQUlDMDM4Vk0vRVBBRCtGN3NNZlUrRVRhMCs5TFJC?=
 =?utf-8?B?QkRKSmxZMGZxUTlSMkRUbTVWbnVHM1JhOVpBam1MTkhpSXVXdkNwcG9ZdXNy?=
 =?utf-8?Q?OvhEJGCYkg6pnhcOnwoeHuSJa?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <631625596A41344E8BEFD68585582BA6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 738be310-308e-4f7e-c3fa-08da7bda05f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2022 20:42:35.8866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tfSYRC3VS71fUyBrWveb6JoVXb87X7rb1zYcTL2+n0DNCRKk7rvq2qN2gqkk+vLSAp16Fsiv2d9T/APmzn9zKxC5XLT5u+YzDshNpmR37Kw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2829
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMDgvMjAyMiAyMTozMiwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEZyb206IENvbm9yIERvb2xleSA8Y29ub3IuZG9v
bGV5QG1pY3JvY2hpcC5jb20+DQo+IA0KPiBVcGdyYWRpbmcgZHQtc2NoZW1hIHRvIHYyMDIyLjA4
IGJyaW5ncyB3aXRoIGl0IGJldHRlciBoYW5kbGluZyBvZg0KPiB1bmV2YWx1YXRlZFByb3BlcnRp
ZXMsIGV4cG9zaW5nIGEgcHJldmlvdXNseSB1bmRldGVjdGVkIG1pc3NpbmcNCj4gcHJvcGVydHkg
aW4gdGhlIGNhZGVuY2UgbWFjYiBkdC1iaW5kaW5nOg0KPiANCj4gYXJjaC9yaXNjdi9ib290L2R0
cy9taWNyb2NoaXAvbXBmcy1pY2ljbGUta2l0LmR0YjogZXRoZXJuZXRAMjAxMTIwMDA6IGV0aGVy
bmV0LXBoeUA4OiBVbmV2YWx1YXRlZCBwcm9wZXJ0aWVzIGFyZSBub3QgYWxsb3dlZCAoJ3RpLGZp
Zm8tZGVwdGgnIHdhcyB1bmV4cGVjdGVkKQ0KPiAgICAgICAgIEZyb20gc2NoZW1hOiBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2NkbnMsbWFjYi55YW1sDQo+IA0KPiBJIGtu
b3cgd2hhdCB5b3UncmUgdGhpbmtpbmcsIHRoZSBiaW5kaW5nIGRvZXNuJ3QgbG9vayB0byBiZSB0
aGUgcHJvYmxlbQ0KPiBhbmQgSSBhZ3JlZS4gSSBhbSBub3Qgc3VyZSB3aHkgYSBUSSB2ZW5kb3Ig
cHJvcGVydHkgd2FzIGV2ZXIgYWN0dWFsbHkNCj4gYWRkZWQgc2luY2UgaXQgaGFzIG5vIG1lYW5p
bmcuLi4ganVzdCBnZXQgcmlkIG9mIGl0Lg0KPiANCj4gRml4ZXM6IDBmYTYxMDdlY2E0MSAoIlJJ
U0MtVjogSW5pdGlhbCBEVFMgZm9yIE1pY3JvY2hpcCBJQ0lDTEUgYm9hcmQiKQ0KDQpGaXhlczog
YmM0N2IyMjE3ZjI0ICgicmlzY3Y6IGR0czogbWljcm9jaGlwOiBhZGQgdGhlIHN1bmRhbmNlIHBv
bGFyYmVycnkiKQ0KDQo+IFNpZ25lZC1vZmYtYnk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5
QG1pY3JvY2hpcC5jb20+DQo+IC0tLQ0KPiAgYXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAv
bXBmcy1pY2ljbGUta2l0LmR0cyB8IDIgLS0NCj4gIGFyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9j
aGlwL21wZnMtcG9sYXJiZXJyeS5kdHMgfCAyIC0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDQgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2No
aXAvbXBmcy1pY2ljbGUta2l0LmR0cyBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21w
ZnMtaWNpY2xlLWtpdC5kdHMNCj4gaW5kZXggMDQ0OTgyYTExZGY1Li5lZTU0OGFiNjFhMmEgMTAw
NjQ0DQo+IC0tLSBhL2FyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21wZnMtaWNpY2xlLWtp
dC5kdHMNCj4gKysrIGIvYXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAvbXBmcy1pY2ljbGUt
a2l0LmR0cw0KPiBAQCAtODQsMTIgKzg0LDEwIEBAICZtYWMxIHsNCj4gDQo+ICAgICAgICAgcGh5
MTogZXRoZXJuZXQtcGh5QDkgew0KPiAgICAgICAgICAgICAgICAgcmVnID0gPDk+Ow0KPiAtICAg
ICAgICAgICAgICAgdGksZmlmby1kZXB0aCA9IDwweDE+Ow0KPiAgICAgICAgIH07DQo+IA0KPiAg
ICAgICAgIHBoeTA6IGV0aGVybmV0LXBoeUA4IHsNCj4gICAgICAgICAgICAgICAgIHJlZyA9IDw4
PjsNCj4gLSAgICAgICAgICAgICAgIHRpLGZpZm8tZGVwdGggPSA8MHgxPjsNCj4gICAgICAgICB9
Ow0KPiAgfTsNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hp
cC9tcGZzLXBvbGFyYmVycnkuZHRzIGIvYXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAvbXBm
cy1wb2xhcmJlcnJ5LmR0cw0KPiBpbmRleCA4MmM5M2M4ZjVjMTcuLmRjMTFiYjhmYzgzMyAxMDA2
NDQNCj4gLS0tIGEvYXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAvbXBmcy1wb2xhcmJlcnJ5
LmR0cw0KPiArKysgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9tcGZzLXBvbGFyYmVy
cnkuZHRzDQo+IEBAIC01NCwxMiArNTQsMTAgQEAgJm1hYzEgew0KPiANCj4gICAgICAgICBwaHkx
OiBldGhlcm5ldC1waHlANSB7DQo+ICAgICAgICAgICAgICAgICByZWcgPSA8NT47DQo+IC0gICAg
ICAgICAgICAgICB0aSxmaWZvLWRlcHRoID0gPDB4MDE+Ow0KPiAgICAgICAgIH07DQo+IA0KPiAg
ICAgICAgIHBoeTA6IGV0aGVybmV0LXBoeUA0IHsNCj4gICAgICAgICAgICAgICAgIHJlZyA9IDw0
PjsNCj4gLSAgICAgICAgICAgICAgIHRpLGZpZm8tZGVwdGggPSA8MHgwMT47DQo+ICAgICAgICAg
fTsNCj4gIH07DQo+IA0KPiAtLQ0KPiAyLjM3LjENCj4gDQoNCg==
