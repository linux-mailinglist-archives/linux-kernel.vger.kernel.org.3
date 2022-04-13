Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBC14FF106
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 09:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbiDMH5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 03:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbiDMH5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 03:57:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2494120BB;
        Wed, 13 Apr 2022 00:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649836486; x=1681372486;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Qcw1IQvjTe2U8qxjkCTAGFoIqDSOtZlAHQUZIfCuKvc=;
  b=aAuY6DxsgCQyLHUdt/rmnZ52sYzcu/wY5IkwHAL7se56LODEPOO1CYw+
   IvEO0VonoFB4mcTrMNn56/mgty4CYrYGQAeta59tG1WW2P/HCW+/JtVzJ
   aeJahTWo1mqaTaUzJCuALUqfDM6oXVhqfAC24fEE4wmVw0sU0lPCXpi73
   vIrdv8dzXZB1fkIoREnclQfh7YS70gVGC+PBTNVYh+bAHFNzFhRncputm
   MpybCCpkRZuwxglh+4XEY5UKiOLgt7m5TkHjk/x58GU/758svU/GlegwB
   e3HyAQAaAgaGzeSn/jC16HiBuu9i6TzZExycfIrbX1OIGIokXwkMDZ2W/
   w==;
X-IronPort-AV: E=Sophos;i="5.90,256,1643698800"; 
   d="scan'208";a="160363653"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Apr 2022 00:54:45 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 13 Apr 2022 00:54:44 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 13 Apr 2022 00:54:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jk73sIpvliGCVI5ZG6nUCab5/Yt5CjFlEf28wMCWnffBnbTP6fDzIBEpIvnmOMaHvpppOVf7jvChAb9SOKzdjzkUP4wFEcOGvCvc3+YKx96hxtKO88EcMWgbH81pCn5nALGdQfVWcIY616mYlzf1BJnFbrtpvfxaNhKo/pYeL4WTZ2axgBwImmmtqZBfgqIKD8oqfDx4dtWrhavuNoGdCBv3+HoDKEaSYUTJi6Yd2/p4xX0NzOUirYX51qHsksFBLyCSoPPYXJ5uJzVQgfx+7vWO1On/q2g0l7SgES46uDSh89YaHRtriIxUcUMJ+MvLosLxQC3yf2INbYqEpiCBGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qcw1IQvjTe2U8qxjkCTAGFoIqDSOtZlAHQUZIfCuKvc=;
 b=ezNBbRfcboJJbQij5tiQeHHLwR68r+shFS/HDLf/KsHRp6Mdnn/CqPob4u5w+YBBqKIdVKYSrB3XmqrHSYJdn1mip2SaxF0jJDLPZRHVzi4K1Ejxu/3gsTQsIACMuYiigT1dxZS/LExyNrH72bpd8utS0WxCc5nkmOAzDEnKB3VArmgO9NpYKYvz5Uq5TLfqFQIAF20g+gQZy1qAdK/3I+sQFlZvhIcXGuG1u/wKGTmX6iEXqMncohwnVGVKNcUe5xH41c5/OVxnolQesZRkMGUJg/yfyZFFfAFPuKUc9y3xSQ0uStmZoZH9KPBOVTAR4AplA4CJd0IB4/6Kf/d0uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qcw1IQvjTe2U8qxjkCTAGFoIqDSOtZlAHQUZIfCuKvc=;
 b=E4GUFylPXezLkIiMeZc6vIi+dpToaEd/19Y1se2k2SIhFMbkg1VG8Z3KTQjmq+eRwias68an2Ei7MPYM3WZu8NjgCVSgqXkwnk4UpJNfsawC2cQEOSryyxLp4lREjGejf3/ZR6jI3J3se3LJ7fNJV8zkisZORLKq8e+yoW46ebc=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by CH2PR11MB4309.namprd11.prod.outlook.com (2603:10b6:610:44::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 07:54:39 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b%7]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 07:54:39 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Codrin.Ciubotariu@microchip.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] clk: at91: generated: consider range when calculating
 best rate
Thread-Topic: [PATCH] clk: at91: generated: consider range when calculating
 best rate
Thread-Index: AQHYTwu5PSI0XDTmXkOG3+wR4bDgUg==
Date:   Wed, 13 Apr 2022 07:54:39 +0000
Message-ID: <9f33d64f-6a16-2964-c089-f028def8e3b8@microchip.com>
References: <20220413071318.244912-1-codrin.ciubotariu@microchip.com>
In-Reply-To: <20220413071318.244912-1-codrin.ciubotariu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8aae9324-26e5-44dc-738b-08da1d22dc8d
x-ms-traffictypediagnostic: CH2PR11MB4309:EE_
x-microsoft-antispam-prvs: <CH2PR11MB4309BA44F449C69A1E75817D87EC9@CH2PR11MB4309.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KgIBL96IMe/4ug4E46681uv5wlkDFt4J/q9Ex+StzWwnwUM11t+kgFVY3KAKa3ehSnJbzSd4v1E+hcFLTM4VAsgELqBpk3FsE9j/rI9Gy80xDnuNpCnCLbq4z/YBtz6Jn4vPe2HNwjZj8F6qunxH6ui+VGzC3255UgIVf+HT/ZgxhWulcmwRofkxB3TX9wqo9Kvk5lJHxsYz7e+WAYw3mbaGm0O0RGtkYY/+Ogxcj9DeWdI86OiA+SVh2QCMLP7P4yCOvd+6jPgkIdOzia3ZI88ipJUIEnIu5vHF4BSl6wyQYaGXY7vkBLrjK9fdwt330p3KB1fz6hzIJ8AD4t7xCDpVQrgddlszlsXgltx6dd7zMSPE5ztI4Yyuygm4xMbenILmLOD6HgwEPVYUSvRjhv96qtZ+Kwjx6oivfn3g03SpojSNrK3lqdJOQjVYYCGSAiCqF5/19I+PlKcMRa/tXRFVGxhK2QLUhedo0rYyVGfJSlVdZ42oXLhdy10Jt0DwgpBFCMuVbOi2gG+STkDXcsvVTJKm6ck3kYLVophEp+W8NaSdDuj0YK/lHvgLwGvymlB/7Dw/RvJQ5TmfEw8wEsLTNB29kR12UiSRFePrMZG0fzmvzpZQAfiikW/gZqQtKgx4fV4QIMoyj5EDxlMR9LSrAP5KvJNFRn9pahdl6/NFMMn5CAr67SBLQz6lls5p81z+80XYafmKg6M6RytNfw1vmo/NRemnHtDnRg1tJpH4N68murCP2AZChtfuz+v6jOoeap0kxgmAVP0QcjQtRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(91956017)(38100700002)(8676002)(71200400001)(6486002)(31686004)(83380400001)(53546011)(76116006)(508600001)(38070700005)(4326008)(66946007)(8936002)(6506007)(6512007)(316002)(66446008)(122000001)(66556008)(66476007)(64756008)(2906002)(86362001)(2616005)(54906003)(26005)(186003)(31696002)(5660300002)(110136005)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDk3OHM5c0tSN3FBRTBLYms4ckorcnpqWm16czdKeTBDTmVyOURqdHVMWS8x?=
 =?utf-8?B?b213bkYxc0MrdlN4dlhJZEdGMkxWMjkwbnlBZVh5VVhlTXVTb1NyaklVNEdS?=
 =?utf-8?B?Yk14bXZnbmtEendPbFRsK2dtNnNpb21NK0dOeHZGVzQ2MThjZVFzQjRrWnFl?=
 =?utf-8?B?Y21YVURDTDNKOUgrUHJlUGJrRUd3eXZHalRheGJLSzZNWGhWQUFBd3g1dmpW?=
 =?utf-8?B?SFhhRXAvRFUzVkR2NDVuWWJnMWdraXcrcUk2bitoNW1vT0EwVlVYRzRZUEFQ?=
 =?utf-8?B?Y3NrL3FiMU5XL1QzTm94N1hrN281MUpXVCs3bm9HQktYS3h6OGp2WFIwR3ZS?=
 =?utf-8?B?c3VVaEJSRUdGcGF0MDRkTm9pbWxtbVByK2lyRVdiVUdFOXBsNmV5enlZL01o?=
 =?utf-8?B?ZlpseEVnaXp0Q0QydzdLUG1jcTI5dmEyeXdZcUY3NmtiNC9mYkVETkpjRUlv?=
 =?utf-8?B?OU45aG5aSGZad3VtS25jTmxscWljTHR6bWlkdjlaa0M5VUlLVnZUMWxZaWhI?=
 =?utf-8?B?MU03aDNLWFR4Q3E5bjFHZ0dEWDVCa3Q0enpEM2xLdDJkQ0ZoVWxVM3l5Qlpl?=
 =?utf-8?B?ek1NUVJWSFc1NnNMb2IxZDYwU0o2aWMvYzUyK0FGM1hBcnhVdkpTc3RtNkxr?=
 =?utf-8?B?eUVjZmF2bzE0QTVBVng2THhGMVd5dmptaXNBWTVmNXo2Q2tvb0VIOFBaeG9T?=
 =?utf-8?B?Wm1GTEtITlo5TW5vaEtWQ0hieDNnNndOa05OcnVSbWRLRGd1VmlOM0Q3WGJF?=
 =?utf-8?B?WEovd1VoQmVwVE5KbjZrVTdDQlhIdzdXN3lCOW0xNi9LbXVkV0NldWMxc1dI?=
 =?utf-8?B?aHdQK0k3eDl3L1BOUkQwd3pvU0Q2a0pDWktEU3lURVd5ekF0T2xJTnJoeWpm?=
 =?utf-8?B?VG8weGhZTDB1NnRGN3pXL2lGdFg4ZWpqZ2Q4TXlZSGhkMU1iVzArMkhzZkFa?=
 =?utf-8?B?TzhrbUlqTHVCdVhRWjRNVFF6eVFaaEZGOVFFRmhlRzFZVHJIanU5cDlNUjNy?=
 =?utf-8?B?MHZHK2sxQXVpSEFldllUcWFPY1prUmJXZWtxby9ENVVodldSV3pvdW4vVXhj?=
 =?utf-8?B?SjBPeDc4RW1QSkI0YkNpM2V0TXVYV0s5TGMvUEUrNW56V0pEZHFIY1lkalFF?=
 =?utf-8?B?VG40TlBMZUZMU0V0bEhTV25Da1kwQWZWSE9QelJ6RDkvZWs0ZFdsRlpRR3Jj?=
 =?utf-8?B?UWtyTzhicVY0R3ZDK2VzZWdkSnVtaWNoZlVGYlQ4WkU3eDBTY3pyVHBWenJs?=
 =?utf-8?B?ZzFFem4yUEpSQk1ta0t3MFhSVDc0Rjlpc2xGMjU3cm1CRWxZeHY0WEFOL2xu?=
 =?utf-8?B?QVpIUzQwMjVHSkx5dlFHVTMwZ0xnbEpjZnB1NjdRRWRISXc3S2NnZjZTWmxF?=
 =?utf-8?B?WEZwcGpidkhCaFMzenlkWXkySS9rQm55TEx4TGlva3RydHpIS3VwZ1A5bnFK?=
 =?utf-8?B?NnQwLzh6UlQ2SzA3WndHblllVW1SQXhWTWI0SHBTdDc0d25VTStyVGMrNTlK?=
 =?utf-8?B?TE9ZMlNlcHZGaUdsTE1ZYnV0Zk95cG5DUXZtbUQxdTVLRFhHRGxwU1AyVXVN?=
 =?utf-8?B?TFdmTmF1ZkZ1Wk1neEVZazdHVVJwVVAwRFBpQ1JaTTBvZ1ZKcGNNdHNvcWVZ?=
 =?utf-8?B?S1BhNjdsbmcxY2xMU2pDdU1hV1htbzZPTHdpeThYb2ZxcXVsZlFPWjdnVTA5?=
 =?utf-8?B?OUY3R293R1lXRnJ3bDNXcHBBZzlUY3ZiOGg1SklwUUU2dXNLNS9HRXhhRGRW?=
 =?utf-8?B?bGw1ejN3eFh2ZXM4UFlkZUxEQi92UWFmeUFmNTdPMjFJVUdjT3Z0K1F6L294?=
 =?utf-8?B?eWVIaUlFMzdPRk1tTEl6QVRHd094bmorMGhqOC9ZRWNCTzhkNWRHazNXNkxN?=
 =?utf-8?B?U3RqWmFXWDRhb3pGbFkxWTJDVGJ0elVWVU9ETUlGWHZhVUVwSUFvZ1dVZnVN?=
 =?utf-8?B?SlhZVVZSVDhEM1lrUW50M3Znbzd1UG0zMHpsMkN0d3FJWENiT3ZISHBKTXEr?=
 =?utf-8?B?UllCZ3FSd1VIY0tQNTBWN2swa3hQanc1Z0plREl0cGN5UFBlaFZGbVg1V0JL?=
 =?utf-8?B?eUROeHdEN3lVSWtwVFRYb0wxbUtMaHhLM0pySmNLTG83OGdsbkJKQ0cxYnhE?=
 =?utf-8?B?T2REUXozNHdYMm8zVUJMZ25OYkU2QnIvaHhQY2QvNlNBRmhUbkpDUG5vQm10?=
 =?utf-8?B?dkJzUFVQNURCZVBvamwxZGJQNjQya2xCclluSmJsczh5UDZPSzhPQ3FTS0tU?=
 =?utf-8?B?dzhoSDh4Mk1EL09LL0s5SnlCZTdoSFA0ck5iWnJoQjViYXl4RGhhQ0VscVVB?=
 =?utf-8?B?d2djYzJ1UFFZVDdqQktSaWN4VTkvbmQyeXZBM3d5T3dJckJMRFZ2RnR3dWE0?=
 =?utf-8?Q?F/RUhvpo2n+yypDQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EAA03029B14AF342ACA239DF5981E4DF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aae9324-26e5-44dc-738b-08da1d22dc8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 07:54:39.1604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Ms+l/Vd7dpjczi9Lt8FlfwnGUfi9VyBF/srHio8XVVeu3NBPJUxaYwPp2BeH2T46qr0RKgT6SdtNKmhFsOHOD7PnUQqcvff+XNTiDKHoRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4309
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTMuMDQuMjAyMiAxMDoxMywgQ29kcmluIENpdWJvdGFyaXUgd3JvdGU6DQo+IGNsa19nZW5l
cmF0ZWRfYmVzdF9kaWZmKCkgaGVscHMgaW4gZmluZGluZyB0aGUgcGFyZW50IGFuZCB0aGUgZGl2
aXNvciB0bw0KPiBjb21wdXRlIGEgcmF0ZSBjbG9zZXN0IHRvIHRoZSByZXF1aXJlZCBvbmUuIEhv
d2V2ZXIsIGl0IGRvZXNuJ3QgdGFrZSBpbnRvDQo+IGFjY291bnQgdGhlIHJlcXVlc3QncyByYW5n
ZSBmb3IgdGhlIG5ldyByYXRlLiBNYWtlIHN1cmUgdGhlIG5ldyByYXRlDQo+IGlzIHdpdGhpbiB0
aGUgcmVxdWlyZWQgcmFuZ2UuDQo+IA0KPiBGaXhlczogOGE4ZjRiZjBjNDgwICgiY2xrOiBhdDkx
OiBjbGstZ2VuZXJhdGVkOiBjcmVhdGUgZnVuY3Rpb24gdG8gZmluZCBiZXN0X2RpZmYiKQ0KPiBT
aWduZWQtb2ZmLWJ5OiBDb2RyaW4gQ2l1Ym90YXJpdSA8Y29kcmluLmNpdWJvdGFyaXVAbWljcm9j
aGlwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBt
aWNyb2NoaXAuY29tPg0KDQoNCj4gLS0tDQo+ICBkcml2ZXJzL2Nsay9hdDkxL2Nsay1nZW5lcmF0
ZWQuYyB8IDQgKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2F0OTEvY2xrLWdlbmVyYXRlZC5jIGIvZHJpdmVycy9j
bGsvYXQ5MS9jbGstZ2VuZXJhdGVkLmMNCj4gaW5kZXggMjNjYzgyOTdlYzRjLi5kNDI5YmE1MmE3
MTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xrL2F0OTEvY2xrLWdlbmVyYXRlZC5jDQo+ICsr
KyBiL2RyaXZlcnMvY2xrL2F0OTEvY2xrLWdlbmVyYXRlZC5jDQo+IEBAIC0xMTcsNiArMTE3LDEw
IEBAIHN0YXRpYyB2b2lkIGNsa19nZW5lcmF0ZWRfYmVzdF9kaWZmKHN0cnVjdCBjbGtfcmF0ZV9y
ZXF1ZXN0ICpyZXEsDQo+ICAgICAgICAgICAgICAgICB0bXBfcmF0ZSA9IHBhcmVudF9yYXRlOw0K
PiAgICAgICAgIGVsc2UNCj4gICAgICAgICAgICAgICAgIHRtcF9yYXRlID0gcGFyZW50X3JhdGUg
LyBkaXY7DQo+ICsNCj4gKyAgICAgICBpZiAodG1wX3JhdGUgPCByZXEtPm1pbl9yYXRlIHx8IHRt
cF9yYXRlID4gcmVxLT5tYXhfcmF0ZSkNCj4gKyAgICAgICAgICAgICAgIHJldHVybjsNCj4gKw0K
PiAgICAgICAgIHRtcF9kaWZmID0gYWJzKHJlcS0+cmF0ZSAtIHRtcF9yYXRlKTsNCj4gDQo+ICAg
ICAgICAgaWYgKCpiZXN0X2RpZmYgPCAwIHx8ICpiZXN0X2RpZmYgPj0gdG1wX2RpZmYpIHsNCj4g
LS0NCj4gMi4zMi4wDQo+IA0KDQo=
