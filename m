Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DBC4CEF1A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 02:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbiCGBZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 20:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbiCGBZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 20:25:34 -0500
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1825D5E7;
        Sun,  6 Mar 2022 17:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1646616280; x=1647221080;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tkhpqxA0yHYam/fsrSlDr3bidvZkWaoJxaLtqG5EzWk=;
  b=aA9YjD+PIjD5h1rBmCgQLJdCdm872fe2E/i1Rx41slJhOSTnS/1O/tc5
   jET+GVJ/xs1ysYr6L/7BDOla9A82dJXi/pSbcit2dk21fXL8pLomrrSox
   VkaZhH5tvlOAiy9vbij7D1FdEzpgf9S65gZK6D2aviArMdmTFbEeUawh2
   U=;
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 01:24:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7Ke+ZHO1JD4Rv8Rw53UG0yjf95weHGlX6E4EbxolrqZHtjg36kIwpK9Sfao+yDUQyYkI6KEB8n9/oIJDcNP5tX5qTTiATLZlsc3C9jwJ+I2rc665BqKHQAS3m0u63+8k36aJu1+ZgI6YPYtmb8RXCyiYfdBbg/AbNEf6kcUnfL0SXvl50phfarXs6ga6C9OdYYYzFKGccHR/gSgiYpoXZsXqZdNJNdcVLB6yj+oY4Vhck+4P9tcgoHYIX1Btp7TzvtkaGwGjb+YkRF0p1c8haXsy+EgfrZG/NyIza3+G9UuiEavd7vOJj6pzNozI3LdqRHGxsH5rAK1EiEXqHSzhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkhpqxA0yHYam/fsrSlDr3bidvZkWaoJxaLtqG5EzWk=;
 b=IzbkE22O2TX+mJvb9Ai6mcCRbToVhHfpQqRUitGmYRUo2ZIRsECQRseaX6oV2nCH9mN9TPt9lF+IehA5VJaWW4K+T9UUSC8lqL8kTDG7pKFIAmmWbChEVF2lXZhIUh+zu3HYZB4NJeSGq04hUl84/E2q0BGcRlwJgqmSwFINNIF6ToeTufRlKoyI4K0dv3SIGaedX0dsiEvJ8jbd9rik1zbHesDqzMm0dGWYzWdxyfnx3q3q9UlyeO5DH7jh/xLscvzhFEztaRRiSw+RvEhs4WYCRjTn8CeMIQzE5qmwSahjX2clLSb473Lk17tlNJ0E/cFbXjWAVsQ/mkJt9EYZUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DM8PR02MB8198.namprd02.prod.outlook.com (2603:10b6:8:4::7) by
 DM5PR02MB2203.namprd02.prod.outlook.com (2603:10b6:3:5b::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Mon, 7 Mar 2022 01:24:36 +0000
Received: from DM8PR02MB8198.namprd02.prod.outlook.com
 ([fe80::a02f:fdb9:de98:d75c]) by DM8PR02MB8198.namprd02.prod.outlook.com
 ([fe80::a02f:fdb9:de98:d75c%6]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 01:24:35 +0000
From:   "Linyu Yuan (QUIC)" <quic_linyyuan@quicinc.com>
To:     "mka@chromium.org" <mka@chromium.org>,
        "Linyu Yuan (QUIC)" <quic_linyyuan@quicinc.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Tao Wang (Consultant) (QUIC)" <quic_wat@quicinc.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "hadess@hadess.net" <hadess@hadess.net>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "ravisadineni@chromium.org" <ravisadineni@chromium.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "rogerq@kernel.org" <rogerq@kernel.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "swboyd@chromium.org" <swboyd@chromium.org>
Subject: =?utf-8?B?UkU6IOWbnuWkjTog5Zue5aSNOiBSZTogW1BBVENIIHYyMCAzLzVdIHVzYjog?=
 =?utf-8?B?bWlzYzogQWRkIG9uYm9hcmRfdXNiX2h1YiBkcml2ZXI=?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFJlOiBbUEFUQ0ggdjIwIDMvNV0gdXNiOiBtaXNj?=
 =?utf-8?B?OiBBZGQgb25ib2FyZF91c2JfaHViIGRyaXZlcg==?=
Thread-Index: Adgm6oYwULNX5ZnjSBCBUX6aFc31LAAADyHwAFiwVAAAH4sXgAAAiy2AAOBepDAAMTAMgAAAYDMQAC3hmwAACcEx4ACNnZQAAGW/EcA=
Date:   Mon, 7 Mar 2022 01:24:35 +0000
Message-ID: <DM8PR02MB81986250F1FC52F950ACD923E3089@DM8PR02MB8198.namprd02.prod.outlook.com>
References: <SA1PR02MB86067ACF0C96F18B7306D208903A9@SA1PR02MB8606.namprd02.prod.outlook.com>
 <SA1PR02MB860660B6F33011E5A97F7930903A9@SA1PR02MB8606.namprd02.prod.outlook.com>
 <YhURQAksLKVuzU36@google.com>
 <SA1PR02MB860602E0AC4D9BD0BC4245B5903C9@SA1PR02MB8606.namprd02.prod.outlook.com>
 <YhXolQDwIMbTi/O2@kroah.com>
 <DM8PR02MB81988555CA6B66BB3FD5E488E3019@DM8PR02MB8198.namprd02.prod.outlook.com>
 <Yh0UZUU9/9Hd6Pc1@google.com>
 <DM8PR02MB8198F2BFE9E933CC8F2C148BE3029@DM8PR02MB8198.namprd02.prod.outlook.com>
 <Yh5K0u3jp4jTXCPi@google.com>
 <DM8PR02MB819876BA541F3C62D971EF09E3039@DM8PR02MB8198.namprd02.prod.outlook.com>
 <YiJCpt46S1ngV+y7@google.com>
In-Reply-To: <YiJCpt46S1ngV+y7@google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5c481f6-9051-4ebc-892b-08d9ffd93d99
x-ms-traffictypediagnostic: DM5PR02MB2203:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <DM5PR02MB220324C2A52F896A4B9AC06E9F089@DM5PR02MB2203.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: brbz2FWQpzczorVg1UW32fAeT5z1yzIJcw2ui0dgKJ5NBvKE8Kzyyz0wAQMdN36jEqIjufsOB1QDT7FdI7VlU/H449q2Dwx21+LqxVw1SPn5jqod5Q0bpjBVkuA7bFCcTrj36amKWlBdWtDQFeTjKnt3b6O9BRLmmyjpIHUn2ZzP6h2d7mP/jCjiaZt+k7xu+jyDHIllIdcbXG3KkyE8ZAyEhxVSRHKie1M+b0FNwfgkjpV48KMmHiDURgrZ/+YrNBV69GfckMn+7EhTcSvr6iFxBNbX7A6HOim3gXhLrI57T4KtDA7tP9TdkUKuvFe/bq7J4AOHHN+fAa9IO8Ae5KaBolYcxLZlVz/CVTPkNF0hQAFPAxzLbPZ2x+HG1d+KqD5sZCIU+otoKZWVtGQxiSFt4J0gDizooQuLwhPnrniyxO/3bADPjHtCiuzAEGdUtXt1xMFWn5F7rMz8qIxXssJqC3tSu2oi2k1lxQ1Nls1oQD/NXoKXCbdYIXL2XtBDiX2qWiJgDLNEvyW+V95amqFA83dPthCod+3xUOZzUnnDa8Ha4W3Uq23XRxnHqnqyE7ccJ6jVC1B79f4fEHrEZEgwzZFsAPd7fTOoA6k4SvknARjpKbC2pLnbryPGvPn8ZciWNFj/6k75e4BBuQwtZiRrykG+zDROqi0Vb+Qbxi7HpBVShQyh0UtVNUzEvBz66R7L9Ca3Quq966uO/h6sZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB8198.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(66556008)(76116006)(86362001)(66446008)(66476007)(4326008)(64756008)(186003)(26005)(66946007)(71200400001)(9686003)(7696005)(8936002)(6506007)(52536014)(53546011)(5660300002)(33656002)(83380400001)(508600001)(38100700002)(55016003)(316002)(122000001)(110136005)(54906003)(2906002)(224303003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEUxVUhld0JudjVFaXFFY0dpYXZvNkhoTFVlc1dCY2FRV3p6WUNrNmtzbThW?=
 =?utf-8?B?L0dKYnRvQ0FTR1hOcitqd3c2Y1YrMWU2YUN6SEJib0d6SGYvZXpDcnJ6TUFF?=
 =?utf-8?B?UjFyT0FWU2oreW94U3R5WlRqclY4TXkxSWZmeU1RQlAyZUtBLzUyK0R6alZw?=
 =?utf-8?B?aXI3Mmxqc1NLL290eTdrYjdTMlI2V2I3U1pmOFZoSWg2bnJ3L2R1WmIvSU1O?=
 =?utf-8?B?cHJzYkJVUXVGZHA5dnZDNmNSbmN1SXI5U01keTUxOEczTWxsK0VGQ1Azb1JC?=
 =?utf-8?B?ZVdpTnBLb1dvV3lwOHpzcVRUcjlsdThiUFgvVmZLZzYzZTVFSVlENFA2ZHAr?=
 =?utf-8?B?cjl0b2s3SVVPVGl0WmkzUmEzeVg5bXBHTW9JdWpZOHF6WjlsTWZ3dU5nQTUx?=
 =?utf-8?B?T3g4cDB2d2hRbkp6MWpCR3JtaHlieWtwakltcU1hZVVHcHMxdlZoRlRtSlB3?=
 =?utf-8?B?T2NnbnZ6OHlhL2p0cFJrSmxJVFBXNUFYTkJoQWNKdWF0dUV5MXdIM1hiOHRD?=
 =?utf-8?B?MjZ3TmNrUXpWZ1JLNmp3c0dtRXU3dzNEK3B5Ly9udmtRNU1FbXFsYWVsOCt6?=
 =?utf-8?B?OUZXU0owNVA2K0IrRUg5S29aMkNGMzZaZ2N5dnpidDA1U3BxOG1KRFkyRjEw?=
 =?utf-8?B?NnU2Ui8zOEY2bldTdGdZVG42eithaG0rL0pEVnd5YitmNzFvSzFWQnRVMGdF?=
 =?utf-8?B?MWtGMlljeUNtY1ZKRGVKWVNBUzd1OTc1VERxeXphcThMd0xwQmRuaGZmcnky?=
 =?utf-8?B?ZW0vZ1RpRzgvbGh3WE02NUxLOXRMRlQyU2lwZVFpbXNDV0l6WC9SRktxQS9y?=
 =?utf-8?B?ckc5OWpBOWpEMlB1NUZ5V0d5Q3BiNUhVR3ZMVDREQmtabWN4NnMydGkyTGtm?=
 =?utf-8?B?WXNjV2tKZGFvcnQwMU9IREFDenQ5WnJvSi92eU14TGwzMG5QMlA3T0h3VUpV?=
 =?utf-8?B?SDJRaEY1YUxzekNRN2VVeU9oTVVzdmJQWkNyekhnY2E5T2NoUFY3ODQwalNv?=
 =?utf-8?B?NXlOU3NYT1JqVXluMGErRVU2dEdWbUVMdDU1WEZ2eFlFc2JTOU9vSmpkc2dB?=
 =?utf-8?B?OEFhbzV2Mkc1cFNiWEdWalZkQncyWGpmcHFXUU5zQ3BvVnN1R0tsT2xzYjhK?=
 =?utf-8?B?ZmZKVTdBaHdVamV1WFMyakVjUWRSVWU1UldMK1ZZRE1FVWdFNjJQdUhnTVVk?=
 =?utf-8?B?OWxUYmUwZ0ZUeklUVFJKZEVsY0FIYzNNZkxrOGJSMGNzTU1FTkVMY3ZONVlK?=
 =?utf-8?B?dXZMdnpmZ0I0bmVtOTBseEhUOXMzQUJRdzVabVRwRzJ2emlnY0ZuZjI4V044?=
 =?utf-8?B?QlJOcTlHeTJwRlNQaWNtL2xlbkM1YVNUdW15dE5ra3lvcElaL3AwWm42R2ZU?=
 =?utf-8?B?ZS9uV1NpZzdnemFhenhrWHY4WTRucW9IZFljQnh1RzBDcHFsa0hpOVFRZVcy?=
 =?utf-8?B?OGRBVlpQTlpnc3J0S0N4L1JROHVlcGR0b0xDeUk4KzNoKytkTndRWFptcmVF?=
 =?utf-8?B?dmtzK281RHdWcU1zMkpPemp0ZlVCZVlmUEVYTktsS2tzTTJvdGNNSnpKSFEv?=
 =?utf-8?B?Q1hWQVZXYTRRZmtsR2k4V2QxNXJJa2Nkcm5zdWV6eXdxc3g1VERZM1JWUjA4?=
 =?utf-8?B?VVJkdVArWDFhWFBmYXRYRlkydDIycEc0aXdNeFBTNTQ2RzRoSXNHa0NOd1J3?=
 =?utf-8?B?bDZDeXgxRGZOVVE4ejRYRkJhc2hJS3N6MDZCUEtNWUVzK3dFWUhvVjhsNmwx?=
 =?utf-8?B?Z1Q1R2lUemZrNFF0VnE1SVRXcTBlN1lYeCtSZ1pRS0xHeGxjWDJIemZCV2FN?=
 =?utf-8?B?Sk5yVFArL2NDSjVXSk5qeXh4ZFZlRlV4NTNnWm9kWmJ0bjQxQWNPV3RzanFX?=
 =?utf-8?B?d3ZLTFI4QXNFN3hVOTVxb01oVVdFb3pUZEZjNkU1Z0tkZWZpbGpwWWJmSXI5?=
 =?utf-8?B?SDRMRkVqbzkwK0p5ejZOQkpWTG4vQjZHS1VRdHhGeE54THdnR29tZXByL1VB?=
 =?utf-8?B?ZUpUekVFblp3V1pTVmlUNXBmVFNDVUxzckJNWFEwL29zejNGTjloVXlJT1Fx?=
 =?utf-8?B?cVF4NUN2dkczaUI0TVdwR2JXOS92ZmxsK21ya0xGZTAxWjJFWVhyN09McGw3?=
 =?utf-8?B?dGRNeVMzdlRxWlEzb2VMMUFoemEyWk9tNm9FQTlaYzBDT3pkMTd4TGF0Vm5O?=
 =?utf-8?B?TmNqY2tISGlxeHJMVVJNRDdReGtkTmdISzNOVStUazRqRlBKcEo5UzFuYURL?=
 =?utf-8?B?dmxWNFhHem9JZ2NNakYreWhWTGtRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8198.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c481f6-9051-4ebc-892b-08d9ffd93d99
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 01:24:35.3750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ypEbdsJJeASN2QYsEtUY8BwUlJVR7ECdA/DqOvOKYchQxLDUslWKDah0SLM6czO+lpe8k8gHBI3Q+vDkmLFmxnydc5hSo69c89wPBv44NM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2203
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBta2FAY2hyb21pdW0ub3JnIDxta2FAY2hyb21pdW0ub3JnPg0KPiBTZW50OiBTYXR1
cmRheSwgTWFyY2ggNSwgMjAyMiAxMjo0OCBBTQ0KPiBUbzogTGlueXUgWXVhbiAoUVVJQykgPHF1
aWNfbGlueXl1YW5AcXVpY2luYy5jb20+DQo+IENjOiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9y
ZzsgVGFvIFdhbmcgKENvbnN1bHRhbnQpIChRVUlDKQ0KPiA8cXVpY193YXRAcXVpY2luYy5jb20+
OyBiYWxiaUBrZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gZGlhbmRl
cnNAY2hyb21pdW0ub3JnOyBmcm93YW5kLmxpc3RAZ21haWwuY29tOyBoYWRlc3NAaGFkZXNzLm5l
dDsNCj4ga3J6a0BrZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51
eC11c2JAdmdlci5rZXJuZWwub3JnOw0KPiBtYXRoaWFzLm55bWFuQGludGVsLmNvbTsgbWljaGFs
LnNpbWVrQHhpbGlueC5jb207DQo+IHBldGVyLmNoZW5Aa2VybmVsLm9yZzsgcmF2aXNhZGluZW5p
QGNocm9taXVtLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiByb2dlcnFAa2VybmVsLm9yZzsg
c3Rlcm5Acm93bGFuZC5oYXJ2YXJkLmVkdTsgc3dib3lkQGNocm9taXVtLm9yZw0KPiBTdWJqZWN0
OiBSZTog5Zue5aSNOiDlm57lpI06IFJlOiBbUEFUQ0ggdjIwIDMvNV0gdXNiOiBtaXNjOiBBZGQN
Cj4gb25ib2FyZF91c2JfaHViIGRyaXZlcg0KPiANCj4gT24gV2VkLCBNYXIgMDIsIDIwMjIgYXQg
MDU6MTQ6MzBBTSArMDAwMCwgTGlueXUgWXVhbiAoUVVJQykgd3JvdGU6DQo+ID4gPiBGcm9tOiBt
a2FAY2hyb21pdW0ub3JnIDxta2FAY2hyb21pdW0ub3JnPg0KPiA+ID4gU2VudDogV2VkbmVzZGF5
LCBNYXJjaCAyLCAyMDIyIDEyOjMzIEFNDQo+ID4gPiBUbzogTGlueXUgWXVhbiAoUVVJQykgPHF1
aWNfbGlueXl1YW5AcXVpY2luYy5jb20+DQo+ID4gPiBDYzogZ3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmc7IFRhbyBXYW5nIChDb25zdWx0YW50KSAoUVVJQykNCj4gPiA+IDxxdWljX3dhdEBxdWlj
aW5jLmNvbT47IGJhbGJpQGtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
Ow0KPiA+ID4gZGlhbmRlcnNAY2hyb21pdW0ub3JnOyBmcm93YW5kLmxpc3RAZ21haWwuY29tOyBo
YWRlc3NAaGFkZXNzLm5ldDsNCj4gPiA+IGtyemtAa2VybmVsLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtDQo+IHVzYkB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiBtYXRo
aWFzLm55bWFuQGludGVsLmNvbTsgbWljaGFsLnNpbWVrQHhpbGlueC5jb207DQo+ID4gPiBwZXRl
ci5jaGVuQGtlcm5lbC5vcmc7IHJhdmlzYWRpbmVuaUBjaHJvbWl1bS5vcmc7DQo+IHJvYmgrZHRA
a2VybmVsLm9yZzsNCj4gPiA+IHJvZ2VycUBrZXJuZWwub3JnOyBzdGVybkByb3dsYW5kLmhhcnZh
cmQuZWR1Ow0KPiBzd2JveWRAY2hyb21pdW0ub3JnDQo+ID4gPiBTdWJqZWN0OiBSZTog5Zue5aSN
OiDlm57lpI06IFJlOiBbUEFUQ0ggdjIwIDMvNV0gdXNiOiBtaXNjOiBBZGQNCj4gPiA+IG9uYm9h
cmRfdXNiX2h1YiBkcml2ZXINCj4gPiA+DQo+ID4gPiA+IEluIG15IG9waW5pb24sIGlmIGl0IG5l
ZWQgdXBkYXRlIFZJRC9QSUQgdGFibGUgaW4gdGhpcyBkcml2ZXIgdG8gc3VwcG9ydCBhDQo+ID4g
PiBuZXcgSFVCLA0KPiA+ID4gPiB3ZSBjYW4gcGFyc2UgVklEL1BJRCBmcm9tIGRldmljZSB0cmVl
IGFuZCBjcmVhdGUgZHluYW1pYyBWSUQvUElEDQo+IGVudHJ5DQo+ID4gPiB0byBpZF90YWJsZSBv
ZiBvbmJvYXJkX2h1Yl91c2JkZXZfZHJpdmVyLg0KPiA+ID4gPg0KPiA+ID4gPiBIb3BlIHlvdSBj
YW4gdW5kZXJzdGFuZCB3aGF0IEkgc2FpZC4NCj4gPiA+DQo+ID4gPiBOb3QgcmVhbGx5Lg0KPiA+
ID4NCj4gPiA+IEkgZG91YnQgdGhhdCB3aGF0IHlvdSBhcmUgc3VnZ2VzdGluZyB3b3VsZCB3b3Jr
LiBUaGUgZWFzaWVzdCB0aGluZw0KPiA+ID4gdG8gY29udmluY2UgcGVvcGxlIHdvdWxkIHByb2Jh
Ymx5IGJlIHRvIHNlbmQgYSBwYXRjaCAoYmFzZWQgb24gdGhpcw0KPiA+ID4gb25lKSB3aXRoIGEg
d29ya2luZyBpbXBsZW1lbnRhdGlvbiBvZiB5b3VyIGlkZWEuDQo+ID4NCj4gPiBJIHNob3cgbXkg
aWRlYSwgYnV0IG5vdCB0ZXN0LA0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL21p
c2Mvb25ib2FyZF91c2JfaHViLmMNCj4gYi9kcml2ZXJzL3VzYi9taXNjL29uYm9hcmRfdXNiX2h1
Yi5jDQo+ID4gaW5kZXggZTI4MDQwOS4uMTgxMTMxNyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L3VzYi9taXNjL29uYm9hcmRfdXNiX2h1Yi5jDQo+ID4gKysrIGIvZHJpdmVycy91c2IvbWlzYy9v
bmJvYXJkX3VzYl9odWIuYw0KPiA+IEBAIC0xMCw2ICsxMCw3IEBADQo+ID4gICNpbmNsdWRlIDxs
aW51eC9pbml0Lmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCj4gPiAgI2luY2x1
ZGUgPGxpbnV4L2xpc3QuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCj4gPiAgI2lu
Y2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvbXV0ZXguaD4NCj4g
PiAgI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+ID4gQEAgLTE3Myw2ICsxNzQsNTggQEAgc3RhdGlj
IHZvaWQgb25ib2FyZF9odWJfcmVtb3ZlX3VzYmRldihzdHJ1Y3QNCj4gb25ib2FyZF9odWIgKmh1
YiwgY29uc3Qgc3RydWN0IHVzYl8NCj4gPiAgCW11dGV4X3VubG9jaygmaHViLT5sb2NrKTsNCj4g
PiAgfQ0KPiA+DQo+ID4gKyNkZWZpbmUgTUFYX0hVQl9OVU0JCTQNCj4gPiArI2RlZmluZSBNQVhf
VEFCTEVfU0laRQkJKE1BWF9IVUJfTlVNICogMikNCj4gPiArc3RhdGljIHN0cnVjdCB1c2JfZGV2
aWNlX2lkIG9uYm9hcmRfaHViX2lkX3RhYmxlW01BWF9UQUJMRV9TSVpFICsgMV07DQo+ID4gK01P
RFVMRV9ERVZJQ0VfVEFCTEUodXNiLCBvbmJvYXJkX2h1Yl9pZF90YWJsZSk7DQo+ID4gKw0KPiA+
ICtzdGF0aWMgdm9pZCBvbmJvYXJkX2h1Yl9hZGRfaWR0YWJsZShfX3UxNiB2aWQsIF9fdTE2IHBp
ZCkNCj4gPiArew0KPiA+ICsJaW50IGk7DQo+ID4gKw0KPiA+ICsJZm9yIChpID0gMDsgaSA8IE1B
WF9UQUJMRV9TSVpFOyBpKyspIHsNCj4gPiArCQlpZiAoIW9uYm9hcmRfaHViX2lkX3RhYmxlW2ld
LmlkVmVuZG9yKQ0KPiA+ICsJCQlicmVhazsNCj4gPiArDQo+ID4gKwkJaWYgKG9uYm9hcmRfaHVi
X2lkX3RhYmxlW2ldLmlkVmVuZG9yID09IHZpZCAmJg0KPiA+ICsJCSAgICBvbmJvYXJkX2h1Yl9p
ZF90YWJsZVtpXS5pZFByb2R1Y3QgPT0gcGlkKQ0KPiA+ICsJCQlyZXR1cm47DQo+ID4gKwl9DQo+
ID4gKwlpZiAoaSA9PSBNQVhfVEFCTEVfU0laRSkNCj4gPiArCQlyZXR1cm47DQo+ID4gKw0KPiA+
ICsJb25ib2FyZF9odWJfaWRfdGFibGVbaV0uaWRWZW5kb3IgPSB2aWQ7DQo+ID4gKwlvbmJvYXJk
X2h1Yl9pZF90YWJsZVtpXS5pZFByb2R1Y3QgPSBwaWQ7DQo+ID4gKwlvbmJvYXJkX2h1Yl9pZF90
YWJsZVtpXS5tYXRjaF9mbGFncyA9DQo+IFVTQl9ERVZJQ0VfSURfTUFUQ0hfREVWSUNFOw0KPiA+
ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IG9uYm9hcmRfaHViX3BhcnNlX2lkdGFibGUoc3Ry
dWN0IGRldmljZV9ub2RlICpucCkNCj4gPiArew0KPiA+ICsJaW50IHNpemUgPSBvZl9wcm9wZXJ0
eV9jb3VudF9lbGVtc19vZl9zaXplKG5wLCAidmlkcGlkIiwgc2l6ZW9mKGludCkpOw0KPiA+ICsJ
aW50IHJldCwgaTsNCj4gPiArCXUxNiAqaWRzOw0KPiA+ICsNCj4gPiArCWlmICghc2l6ZSB8fCBz
aXplICUgMikNCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArDQo+ID4gKwlpZHMgPSBremFs
bG9jKHNpemVvZih1MTYpICogc2l6ZSwgR0ZQX0tFUk5FTCk7DQo+ID4gKwlpZiAoIWlkcykNCj4g
PiArCQlyZXR1cm4gLUVOT01FTTsNCj4gPiArDQo+ID4gKwlyZXQgPSBvZl9wcm9wZXJ0eV9yZWFk
X3UxNl9hcnJheShucCwgInZpZHBpZCIsIGlkcywgc2l6ZSk7DQo+ID4gKwlpZiAocmV0KSB7DQo+
ID4gKwkJa2ZyZWUoaWRzKTsNCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArCX0NCj4gPiAr
DQo+ID4gKwlmb3IgKGkgPSAwOyBpIDwgc2l6ZTsgaSs9MikNCj4gPiArCQlvbmJvYXJkX2h1Yl9h
ZGRfaWR0YWJsZShpZHNbaV0sIGlkc1tpKzFdKTsNCj4gPiArDQo+ID4gKwlrZnJlZShpZHMpOw0K
PiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICBzdGF0aWMgc3NpemVf
dCBhbHdheXNfcG93ZXJlZF9pbl9zdXNwZW5kX3Nob3coc3RydWN0IGRldmljZSAqZGV2LA0KPiBz
dHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwNCj4gPiAgCQkJICAgY2hhciAqYnVmKQ0KPiA+
ICB7DQo+ID4gQEAgLTIxMCw2ICsyNjMsMTAgQEAgc3RhdGljIGludCBvbmJvYXJkX2h1Yl9wcm9i
ZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAJc3RydWN0IG9uYm9hcmRf
aHViICpodWI7DQo+ID4gIAlpbnQgZXJyOw0KPiA+DQo+ID4gKwllcnIgPSBvbmJvYXJkX2h1Yl9w
YXJzZV9pZHRhYmxlKGRldi0+b2Zfbm9kZSk7DQo+ID4gKwlpZiAoZXJyKQ0KPiA+ICsJCXJldHVy
biBlcnI7DQo+ID4gKw0KPiA+ICAJaHViID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpodWIp
LCBHRlBfS0VSTkVMKTsNCj4gPiAgCWlmICghaHViKQ0KPiA+ICAJCXJldHVybiAtRU5PTUVNOw0K
PiA+IEBAIC0zNzgsMTUgKzQzNSw2IEBAIHN0YXRpYyB2b2lkDQo+IG9uYm9hcmRfaHViX3VzYmRl
dl9kaXNjb25uZWN0KHN0cnVjdCB1c2JfZGV2aWNlICp1ZGV2KQ0KPiA+ICAJb25ib2FyZF9odWJf
cmVtb3ZlX3VzYmRldihodWIsIHVkZXYpOw0KPiA+ICB9DQo+ID4NCj4gPiAtc3RhdGljIGNvbnN0
IHN0cnVjdCB1c2JfZGV2aWNlX2lkIG9uYm9hcmRfaHViX2lkX3RhYmxlW10gPSB7DQo+ID4gLQl7
IFVTQl9ERVZJQ0UoVkVORE9SX0lEX1JFQUxURUssIDB4MDQxMSkgfSwgLyogUlRTNTQxMSBVU0Ig
My4xDQo+ICovDQo+ID4gLQl7IFVTQl9ERVZJQ0UoVkVORE9SX0lEX1JFQUxURUssIDB4NTQxMSkg
fSwgLyogUlRTNTQxMSBVU0IgMi4xDQo+ICovDQo+ID4gLQl7IFVTQl9ERVZJQ0UoVkVORE9SX0lE
X1JFQUxURUssIDB4MDQxNCkgfSwgLyogUlRTNTQxNCBVU0IgMy4yDQo+ICovDQo+ID4gLQl7IFVT
Ql9ERVZJQ0UoVkVORE9SX0lEX1JFQUxURUssIDB4NTQxNCkgfSwgLyogUlRTNTQxNCBVU0IgMi4x
DQo+ICovDQo+ID4gLQl7fQ0KPiA+IC19Ow0KPiA+IC1NT0RVTEVfREVWSUNFX1RBQkxFKHVzYiwg
b25ib2FyZF9odWJfaWRfdGFibGUpOw0KPiA+IC0NCj4gPiAgc3RhdGljIHN0cnVjdCB1c2JfZGV2
aWNlX2RyaXZlciBvbmJvYXJkX2h1Yl91c2JkZXZfZHJpdmVyID0gew0KPiA+ICAJLm5hbWUgPSAi
b25ib2FyZC11c2ItaHViIiwNCj4gPiAgCS5wcm9iZSA9IG9uYm9hcmRfaHViX3VzYmRldl9wcm9i
ZSwNCj4gDQo+IEkgc2VlIG11bHRpcGxlIGlzc3VlcyB3aXRoIHRoaXMgYXBwcm9hY2g6DQo+IA0K
PiAxLiBUaGUgbmV3IGRldmljZSB0cmVlIHByb3BlcnR5ICd2aWRwaWQnLiBJdCBpcyAob3Igc2hv
dWxkIGJlKSByZWR1bmRhbnQNCj4gICAgd2l0aCB0aGUgY29tcGF0aWJsZSBzdHJpbmcsIEkgdmVy
eSBtdWNoIGRvdWJ0IHlvdSBjb3VsZCBjb252aW5jZSBEVA0KPiAgICBtYWludGFpbmVycyB0byBh
ZGQgaXQuDQo+IDIuIFlvdSBkb24ndCB3YW50IHRvIG1vZGlmeSB0aGUgZHJpdmVyIHRvIGVuYWJs
ZWQgc3VwcG9ydCBmb3IgbmV3IFVTQiBodWJzLg0KPiAgICBUaGF0IG1lYW5zIHlvdSB3b3VsZCBo
YXZlIHRvIHVzZSBhIGNvbXBhdGlibGUgc3RyaW5nIHRoYXQgaXMgYWxyZWFkeSBpbg0KPiAgICB0
aGUgZHJpdmVyLCBidXQgd2hpY2ggZG9lc24ndCBtYXRjaCB0aGUgVklEOlBJRCBvZiB0aGUgaHVi
LiBXaGlsZSB0aGlzDQo+ICAgIG1pZ2h0IHdvcmsgaXQncyBhIGhhY2suDQo+IDMuIElmIHRoZSBV
U0IgaHViIGlzIHByb2JlZCBiZWZvcmUgdGhlIHBsYXRmb3JtIGRldmljZSBpdCB3b24ndCB1c2Ug
dGhpcw0KPiAgICBkcml2ZXIgYmVjYXVzZSB0aGUgVklEOlBJRCBpc24ndCBpbiB0aGUgZGV2aWNl
IGlkIHRhYmxlLg0KVGhpcyBpcyBhbm90aGVyIHRvcGljIHdoaWNoIEkgZG9uJ3Qga25vdyBpZiBk
aXNjdXNzIG9yIG5vdCwNCg0KV2hhdCBpcyBwb3dlciBzdGF0ZSByZXF1aXJlbWVudCBvZiBodWIg
Zm9yIHRoaXMgZHJpdmVyID8NCkRvIGl0IGV4cGVjdCBodWIgcG93ZXIgb2ZmIHdoZW4gc3lzdGVt
IGVudGVyIGxpbnV4IGtlcm5lbCBzdGFnZSA/DQpJZiBzbywgYWxsIHRoaXMgZHJpdmVyIG1heSBu
b3Qgd29yayBhcyBodWIgbWF5IGVudW1lcmF0ZWQgYmVmb3JlIHRoaXMgZHJpdmVyIGxvYWQuDQoN
Cj4gNC4gUG9zc2libGUgcmFjZSBjb25kaXRpb25zIHdoZW4gY2hhbmdpbmcgdGhlIGRldmljZSBp
ZCB0YWJsZSBvbiB0aGUgZmx5DQpJZiBodWIgaXMgZGVmYXVsdCBwb3dlciBvZmYsIHRoZXJlIGlz
IG5vIHJhY2UuDQo=
