Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54AC0554CDB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356462AbiFVOYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358408AbiFVOXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:23:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AD9286EB;
        Wed, 22 Jun 2022 07:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655907810; x=1687443810;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JGoV9PtGenFyWE1jK5M9D9yzE4NebR/HunQdPTnJJck=;
  b=Cb/Qn+xIdV3dbZg3fjRU/y5m3OFdjM4scUqBk0dQO9vr+FYUKAtCdxgI
   MXeOlOQYlf6ioNtw/gSWmfS2UJSsRQsrqk9cfF1A0MKecGQi6OKGOFFRk
   IpUEobCUYW2dkYAnu1R1GwYC3FkCKcWwp8tFAgZmJUkYR2968xok5gf4T
   czKj1GlcQhrcpYyx8vgjvMhMCRvTV6ZYgdcmEiwO3dIEDbKuiDaJvnIv7
   ///q0iKF91S70JBs0+a2CyBfSlV3HHLf9CNFjczNy2tcqYI1ggRHYolv6
   xhQDdzlQLNK2rmJPSaELPTSJG8mgqj4B65AjHQsOBmy1OVbXcTDeY5hPF
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="101236856"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jun 2022 07:23:29 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 22 Jun 2022 07:23:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 22 Jun 2022 07:23:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEG8sVGe1ws3984H4QyWX/KWFFlRtUciC/Fgve3qQPXgFkk+kecf+k5VMhXrarijwo3l1KJJLgrOZmoULG7BfVD+oeecmChp1C9PvmWbjiSMQp6VeC2Z9x94ycMoxOp1fyNLnMA5z9XzvMCieA7li2AVeIfyznC6mNLhbRvbbNwejHUzJxPUyEoFeoC+x6kPyXc46HTf3y6h05nQ2iJR5m7rt4+ZOZifd5eJO8x+MlKJQO/DdMnGV9D69gzgQ/CfIJ8DcKsuKcKgCeZoJZAwTrMKFsOHrA9CmtxrUY60TAoFF5hGFamdGfKkxj3K3C1TG9orI2J3ErdQRljZZDk3nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGoV9PtGenFyWE1jK5M9D9yzE4NebR/HunQdPTnJJck=;
 b=MzNmh6AwPB/iiPQAVBTLhGdVks9nL1VUbfJ1fZmcCuB6OX2SI0BRkaWClyA992SWtB6asccI9OMH8nCM0Uxje7oQefz6UpPWjpymBnVclYo/gYzX+4X1mJLX6pILzY9JWCcuz8bQqEVCe9PcpCbEiJu5arKFBs+i1DnqDHHh5IH9gBRm0FyXoxesHJ9GM15OvFhK3bWRHwtbMXqQHjlwgyl3x7bhd3ipUUk0+qsskdhEHONxVZI17LltT+tqTYehnvi/6SpLxnG8pPJprYfCVtTL2sdGWnz5oNAhXAwOHixtZOtMlDgwcNoXZ73v4QNfkUXOIqIAm3qLLvQNRjrFgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGoV9PtGenFyWE1jK5M9D9yzE4NebR/HunQdPTnJJck=;
 b=rXnADeTZLjcGTp505AmG/d4uEMmoBVwo7f66qt855uOU/MOM/SpHwBmhpIUJksDNV5tq++zVziCHOPp6668hLh7TYAitLf8n8laKOmFxXcTlFRFc1hzGSjubkEur8+1kAKVD8b5M3cuhnYP75VaknFSUlFoYdQG1rW/t6YZIcA8=
Received: from BL1PR11MB5384.namprd11.prod.outlook.com (2603:10b6:208:311::14)
 by CO6PR11MB5604.namprd11.prod.outlook.com (2603:10b6:303:138::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Wed, 22 Jun
 2022 14:23:16 +0000
Received: from BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::c9c8:3bab:6b8f:5376]) by BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::c9c8:3bab:6b8f:5376%6]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 14:23:16 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <jacopo@jmondi.org>, <hverkuil@xs4all.nl>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>,
        <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH v10 0/5] media: atmel: atmel-isc: implement media
 controller
Thread-Topic: [PATCH v10 0/5] media: atmel: atmel-isc: implement media
 controller
Thread-Index: AQHYXtNy0DBb1d5tjEaFV5GKOhbPdK1bn80AgAAIywCAAATJAIAAEjeAgAAHkoCAAAJtAA==
Date:   Wed, 22 Jun 2022 14:23:16 +0000
Message-ID: <b6931bcb-3477-5070-8d61-a2220d29dceb@microchip.com>
References: <20220503095127.48710-1-eugen.hristev@microchip.com>
 <1da61f9c-0605-dc9d-63a3-21c18fcb74c7@xs4all.nl>
 <a19d9e72-7609-1daa-93eb-fdedcaa672c4@microchip.com>
 <bc22469c-d1ab-72e2-8e9e-6bd42d66f3d9@microchip.com>
 <c1b8820d-5ff5-b6dd-bc22-35f8daf756db@xs4all.nl>
 <20220622141439.v2ozrctikjxd67ue@uno.localdomain>
In-Reply-To: <20220622141439.v2ozrctikjxd67ue@uno.localdomain>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02c9a1cc-2790-4f9e-a78b-08da545abfce
x-ms-traffictypediagnostic: CO6PR11MB5604:EE_
x-microsoft-antispam-prvs: <CO6PR11MB56045653DA10994692ABAD43E8B29@CO6PR11MB5604.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bz4yqYTVYCtW4dJTO5Ka+AKfPz70KREsp+fHibBYUgPuT1Hf+KXdea70t2yvm9u2NXL4zhprWo7MlUUREcB2a5ZOxgPpHiY33OYSCPdSkt1bdlLXazPg1arIAa2/LA+S1SBjpoh0wUqmLuWyXD8VbxV+JxPoRBOnUoXoIzj0imv1ZdDuTddsvosu1C1RnbTe4EVbNCjQOcqu2RDdtssj90VUalV41N8VeBNblBI9CSy9ruN40OtTYD9dnORzM1Z46sgYckfYRJ2zb62/j0pL+8dXRSSL8tYhOE7Fu4Fi4sZdYYcTrrpkDpoVGZT7APnsCzg08QGZKCOobfu2tQxcCnaiNoPD/Qf+XXE7J2FYgW6d0N6/IlFXJda4sjtcKBNBvzzHEfGHSekPlt8Y9p4gK7BGyoPbOVMPn6dq3s2qkTMWKzj5qgaRkGurkB2jLgX/BNMzJ3g34DXh+zc60xFJnCuYhfjqRzTTw8i7hALvCn7KZ0qLJsw039GFV+Ixskw1VjXaODNcMCbhLJuMrL25ZJC5O8Xm+MM90Ptg7U6t2ED1yXT5FbzV3SI+lveO5fS1QfXjgoYLh89ENcdYoXQSZ6rlrIsiZGiKUgKxvGzDpXMKtZj3eVtt00qFO8gFJxihe/2Ax9Z+Zo7NV72kR/lfmHLX3+EDaDfKqhEWC6u32j4CnUiQ2Gq0pbS8Vmows/4ma5jq8t0rANUjOVN9dQ5EwJAsbBw+QcoOVODB4C3Y+gxFIpkVxTuXWUwnCZ76rhItdT+WNBEgFcTZIgL8LMJLw5UVYi17DUspyhgZNcXT0+XVbhcbTWJ6qEteFj2/LqMQKfk9wBXUxHDWaQcZGn7gPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5384.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(376002)(366004)(136003)(39860400002)(6486002)(5660300002)(478600001)(8936002)(186003)(53546011)(6506007)(2616005)(86362001)(6512007)(26005)(107886003)(31696002)(41300700001)(83380400001)(2906002)(91956017)(316002)(76116006)(64756008)(66556008)(66946007)(4326008)(8676002)(66476007)(66446008)(38070700005)(38100700002)(31686004)(36756003)(71200400001)(54906003)(110136005)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cG9ZY01zQ00vNCtTZGd3a0g2enBMdE1mVHMwb2dpc3NoVzF4a0ZtRjdFZE9D?=
 =?utf-8?B?ZWdPamtYMEM1RlNDY0c2bzJvSlZIY1VicCtWWnVFRHhiUjhkZDVqc2IyTlpw?=
 =?utf-8?B?Uk9NNmdSZGMrOEZCMWhUdEFpNlZGdTFRaFp4VVVkbVhacGRmNzRxTkFnQ2FT?=
 =?utf-8?B?UGVqRFZmdHlNWjErai9SbzUrTEFUM3FCL3IrMGNkdFd4M0JlZ0dZMnkxNXdO?=
 =?utf-8?B?b3dBRXlzQ1VRU05yTlRQTWhsNFA2ZmkzMVlKWkFWL3lMU2VlWnREbVp5Um43?=
 =?utf-8?B?bjlGVGdnRnFwdTIzV2RRSmR3cGNFUVlFdXJEMWZqSkNwZkUzWGpFNmJLejRo?=
 =?utf-8?B?cjc0Ujl2MEtyWVEwQ1Y4TkZCQmtOYXJQVWJXbnlUd2crdVhMbVc4RlRNMUMr?=
 =?utf-8?B?ZlRNRVRHcHN1Y1pXZXNmZzZKUTR6Q2tmS3dBM0tRTlg2Tml0VksyZjF1YUJv?=
 =?utf-8?B?cTRsR1Y0clFRTGI4S0ZUdEtPaXNLVW5XVDFrRGJRY003SmxJaU1VVnZKOTFB?=
 =?utf-8?B?NTZ4WVlpRnh3TTg2UDRVRXQvcG5veUZURHMvTnVIRXRCcXNkeWtMTzgvdW5y?=
 =?utf-8?B?UGlmdTI3RjF3ZVRSanlsdVEzQjJGaDgwQUNYNytscS93QWlZTHU5aUpCaHVI?=
 =?utf-8?B?b0FjblRiN2RyODVTNFJUQ3BhR1FzMVVlQnR0bU9zU2lZWlFIdTRGcGFRQURT?=
 =?utf-8?B?cmd4Q1U0ME1FQlVIN2t6dXVwRW5sakgrYXdIMEFHZDY3U2RtajdCV1BFOHhK?=
 =?utf-8?B?ZWN2SDU4R09qM1Zaelowc1JBWFJOUmV4K1hrM3hSTXczeUVDdnI0VTlFUk5L?=
 =?utf-8?B?MUErK1ZXTlBhTFVQVjZpL3RXNHh2SVNmTklCUVJhNlpqNlE2SThaVXBzYkRP?=
 =?utf-8?B?aytudUpLR2VxRmltVGNmRzFaQitTd0Izc0JHSWpVWkZvODZ6WDA0Nmg5VlM2?=
 =?utf-8?B?TzVTeG1xcnBwR21UMGxoWitmRkpnZnhHNmI2dTFLU1FHa3Z3bHhFTzNHOFVk?=
 =?utf-8?B?MkdCZWRhako4cy9NdnJLT1kzSzgzOGNLV0VXdjAxUkdaUnNNdmxZRHdkUmgy?=
 =?utf-8?B?QnN0TjhHMWsySXJJSGtkNzh2anB3cHQxanRqeVBPMS9aczAydjVQRlFBNksy?=
 =?utf-8?B?THl2T1lXbHFHQmYxQVhwMi96T2JFRStBeEI5dkZuRjdxY3hIa1JDRmNkTlg1?=
 =?utf-8?B?VnpCdkdCeUhXRW9FaUNyL2lxbjA2eHYrNXF0ak5UTjdxL1NQOG9OV0g1eURE?=
 =?utf-8?B?YnNhalI4SW1KNGhTOEtpOEZKdk5FQ0pqYzlPaU9GajdtbUtVN3NGa3ZpcUZs?=
 =?utf-8?B?UG9iTG5VemEvZlpSOWlEUldPTjJvY0sycG12YWFJM0hYSEErZjRhYUR4aEFX?=
 =?utf-8?B?REJocjk4TzJwM0Z1SWw5OVZVSFJkdllYdVEydDJRUDFKNEQ3M2s4S0RPa0ZJ?=
 =?utf-8?B?anZ6dUF5RFZtZXN3eElxM09GTERDdUErUVlVeUpIUGFNMWVQcFhpUkY1NE5N?=
 =?utf-8?B?ZWZ0MWFUZ2JHcTAvMzRqeTFhYmVlMW1zaW4vdngrNmNzSUtQQVFkVDhacWRW?=
 =?utf-8?B?VStZYXpMUlF0ek5QK09KTTVvc3dlaEJiaGQ4bjF5OGsvc1hjVC8zOXp6dXkv?=
 =?utf-8?B?ZFNUUHdpY3BhRkhqZndQUExyZk0ycnlsUkM2RGZjcDNmWU1QaE5OaWpJNTY1?=
 =?utf-8?B?R3VuY1VaZUR5RUh5WG1Wam9uOXh4YVhPWFhBck02cXZvL05GdWlRRW5FY3Ar?=
 =?utf-8?B?T2NPM0o4OWhPTm1Pb0MwRW01Mkt2ZElySEQ0RngvVTlnQVNYUkducUpMeUlr?=
 =?utf-8?B?TVZiU0paL3djUkYzUUY0RWlIUURjZlFqRG9waXVxVFpYc3ZSaFk2dzJQelRl?=
 =?utf-8?B?SHVON1JqTFlZRlBXY0Fic1hDTnlXUHdrbFZKTlV0RFR2bXoxNmk5VVE3c29O?=
 =?utf-8?B?a3ZTRi9zZUpCc1hqOEFWeXE5TmhyeTA4Um1KclJFZ0FpZ1pYek0vU3orNWVo?=
 =?utf-8?B?aWtIVktlRnVQM1BRR3dqdHVaNEt3VHZ3cG9TM0Q5cXJNNFB0bWpQWE9PUnBN?=
 =?utf-8?B?bnR2RG1oWnRQVEh2YzkwZjFpR1hVSmwzWFVnQUlYM1M1dGt4U2l3L05TR1Rk?=
 =?utf-8?B?Q1BqQW9QNDZTcjk0UFliTlZtZEJHYzJ3WUlKbkFsU1BEOFp6WmtoMmZybEgz?=
 =?utf-8?B?QmZPL083ZFM0S21NQW1NVFcyQXVxVXlJT1pVTEd4TGxhcHVrdmh3U1M0L0t5?=
 =?utf-8?B?cldtYmt6dXBHVm5ucTZ1N1pibkc0elQzNHZkRllkSHVOd01hMWV4WjRSa1hy?=
 =?utf-8?B?NG9CL1k0UjhBL1JwdGcxSzcwQVpZaE1EVWxOVFBab1VzTU5YMHZzVVVTbDJ0?=
 =?utf-8?Q?v3W97DgOFRrs3Bhg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A47855659E0DE34FA37C1771CD237088@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5384.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c9a1cc-2790-4f9e-a78b-08da545abfce
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2022 14:23:16.7503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j1io9g/zYupxSvZyuidyewYaOyd0tS6WvManuLuWa/gPoWVPWymMd2uLhacDD0Uo+A41EKdeAZHamaaUIs1sETqfGGGYPR3jX7hMdAetSOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5604
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8yMi8yMiA1OjE0IFBNLCBKYWNvcG8gTW9uZGkgd3JvdGU6DQo+IEhpIEhhbnMsIEV1Z2Vu
DQo+IA0KPiBPbiBXZWQsIEp1biAyMiwgMjAyMiBhdCAwMzo0NzozM1BNICswMjAwLCBIYW5zIFZl
cmt1aWwgd3JvdGU6DQo+PiBPbiAyMi8wNi8yMDIyIDE0OjQyLCBFdWdlbi5IcmlzdGV2QG1pY3Jv
Y2hpcC5jb20gd3JvdGU6DQo+Pj4gT24gNi8yMi8yMiAzOjI1IFBNLCBFdWdlbiBIcmlzdGV2IC0g
TTE4MjgyIHdyb3RlOg0KPj4+PiBPbiA2LzIyLzIyIDI6NTMgUE0sIEhhbnMgVmVya3VpbCB3cm90
ZToNCj4+Pj4+IEhpIEV1Z2VuLA0KPj4+Pj4NCj4+Pj4+IE9uIDAzLzA1LzIwMjIgMTE6NTEsIEV1
Z2VuIEhyaXN0ZXYgd3JvdGU6DQo+Pj4+Pj4gVGhpcyBzZXJpZXMgaXMgYSBzcGxpdCBmcm9tIHRo
ZSBzZXJpZXMgOg0KPj4+Pj4+IFtQQVRDSCB2OSAwMC8xM10gbWVkaWE6IGF0bWVsOiBhdG1lbC1p
c2M6IGltcGxlbWVudCBtZWRpYSBjb250cm9sbGVyDQo+Pj4+Pj4gYW5kIGl0IGluY2x1ZGVzIHRo
ZSBtZWRpYSBjb250cm9sbGVyIHBhcnQuDQo+Pj4+Pj4gcHJldmlvdXMgZml4ZXMgd2VyZSBzZW50
IG9uIGEgZGlmZmVyZW50IHBhdGNoIHNlcmllcy4NCj4+Pj4+Pg0KPj4+Pj4+IEFzIGRpc2N1c3Nl
ZCBvbiB0aGUgTUwsIG1vdmluZyBmb3J3YXJkIHdpdGggaGF2aW5nIHRoZSBtZWRpYSBsaW5rIHZh
bGlkYXRlIGF0DQo+Pj4+Pj4gc3RhcnQvc3RvcCBzdHJlYW1pbmcgY2FsbC4NCj4+Pj4+PiBJIHdp
bGwgdGVzdCB0aGUgcGF0Y2ggOg0KPj4+Pj4+IFtSRkMgUEFUQ0h2Ml0gdmIyOiBhZGQgc3VwcG9y
dCBmb3IgKHVuKXByZXBhcmVfc3RyZWFtaW5nIHF1ZXVlIG9wcw0KPj4+Pj4+IGFmdGVyd2FyZHMs
IGJ1dCB0aGF0IHBhdGNoIHJlcXVpcmVzIG1vdmluZyBteSBsb2dpYyB0byB0aGUgbmV3IHZiMiBj
YWxsYmFja3MuDQo+Pj4+Pg0KPj4+Pj4gSSdtIGxvb2tpbmcgYXQgbWVyZ2luZyB0aGlzIHNlcmll
cywgYnV0IEkgd291bGQgbGlrZSB0byBoYXZlIHRoZSBvdXRwdXQgb2YNCj4+Pj4+ICd2NGwyLWNv
bXBsaWFuY2UgLW0gL2Rldi9tZWRpYVgnIHRvIHZlcmlmeSB0aGF0IHRoZSBNQyBsaW5rcyBldGMu
IGlzIGFsbA0KPj4+Pj4gY29ycmVjdC4NCj4+Pj4NCj4+Pj4gSGVsbG8gSGFucywNCj4+Pj4NCj4+
Pj4gUGxlYXNlIGhhdmUgYSBsb29rIGF0IGF0dGFjaGVkIGZpbGUgLiBVbmxlc3MgeW91IHdhbnQg
bWUgdG8gYWRkIHRoZQ0KPj4+PiB3aG9sZSBvdXRwdXQgdG8gdGhlIGUtbWFpbCA/DQo+Pj4+DQo+
Pj4+IEkgYWxzbyBhZGRlZCBvdXRwdXQgb2YgbWVkaWEtY3RsIC1wIGZvciB5b3VyIGNvbnZlbmll
bmNlLg0KPj4+PiB0aGUgc3ViZGV2MiBpcyBhIGRldmljZSBhbmQgZHJpdmVyIHRoYXQgaXMgbm90
IHVwc3RyZWFtIGFuZCBoYXMgc29tZQ0KPj4+PiBjb21wbGlhbmNlIGlzc3VlcywgdGhleSBhcmUg
cmVwb3J0ZWQgYnkgdGhlIHY0bDItY29tcGxpYW5jZSB0b29sLCBidXQNCj4+Pj4gdGhleSBzaG91
bGQgbm90IGFmZmVjdCB0aGlzIHNlcmllcywgaXQncyBhIHN5bm9wc3lzIGRyaXZlciB0aGF0IHdh
cw0KPj4+PiByZWplY3RlZCBvbiBtYWlubGluZSBhIGZldyB5ZWFycyBhZ28sIEkgdG9vayBpdCBm
b3IgaW50ZXJuYWwgdXNhZ2UsIGJ1dA0KPj4+PiBpdCdzIG5vdCBjbGVhbmVkIHVwIG5vciB3b3Jr
ZWQgYSBsb3QgdXBvbi4NCj4+Pj4NCj4+Pj4+DQo+Pj4+PiBBbmQgb25lIG1vcmUgcXVlc3Rpb24g
d2hpY2ggbWF5IGhhdmUgYmVlbiBhbnN3ZXJlZCBhbHJlYWR5IGluIHRoZSBwYXN0Og0KPj4+Pj4N
Cj4+Pj4+IENoYW5naW5nIHRvIHRoZSBNQyB3aWxsIGJyZWFrIGV4aXN0aW5nIGFwcGxpY2F0aW9u
cywgZG9lc24ndCBpdD8gT3IgZGlkIEkNCj4+Pj4+IG1pc3Mgc29tZXRoaW5nPw0KPj4+Pj4NCj4+
Pj4NCj4+Pj4gVGhlIGV4aXN0aW5nIGFwcGxpY2F0aW9ucyB3aWxsIGhhdmUgdG8gY29uZmlndXJl
IHRoZSBwaXBlbGluZSBub3cuIEl0DQo+Pj4+IHdpbGwgbm8gbG9uZ2VyIHdvcmsgYnkgY29uZmln
dXJpbmcganVzdCB0aGUgdG9wIHZpZGVvIG5vZGUgL2Rldi92aWRlbzAgLg0KPj4+PiBUaGV5IHdv
dWxkIGhhdmUgdG8gdXNlIG1lZGlhLWN0bCBmb3IgaXQsIHNvbWV0aGluZyBzaW1pbGFyIHdpdGgg
dGhpcyBzZXQNCj4+Pj4gb2YgY29tbWFuZHM6DQo+Pj4NCj4+PiBUbyBhZGQgb24gdG9wIG9mIHRo
YXQsIGFjdHVhbGx5LCB0aGUgcmVhbGl0eSBpcyB0aGF0IHdpdGhvdXQgdGhlIE1DDQo+Pj4gc3Vw
cG9ydCBpbiBhdG1lbC1pc2MgLCBzb21lIG9mIG91ciBwbGF0Zm9ybXMgZG8gbm90IHdvcmsgYXQg
YWxsLCBiZWNhdXNlDQo+Pj4gdGhlIGNzaTJkYyBkcml2ZXIgd2hpY2ggaXMgaW4gdGhlIG1pZGRs
ZSBvZiB0aGUgcGlwZWxpbmUsIGlzIGEgTUMNCj4+PiBkcml2ZXIuIFNvIGl0IHdpbGwgbm90IHdv
cmsgd2l0aG91dCBjb25maWd1cmluZyBpdCB3aXRoIE1DIGFueXdheS4gSXQNCj4+PiB1c2VkIHRv
IHdvcmsgaW4gYSB2ZXJ5IHByZWxpbWluYXJ5IHZlcnNpb24gb2YgdGhlIGNzaTJkYyBkcml2ZXIg
d2hpY2ggSQ0KPj4+IHNlbnQgYSBmZXcgeWVhcnMgYWdvLCBidXQgdGhhdCB3YXkgb2YgaGFuZGxp
bmcgdGhpbmdzIHdhcyByZWplY3RlZC4NCj4+PiBIZW5jZSBJIGNoYW5nZWQgdGhlIGNzaTJkYyB0
byBiZWluZyBmdWxsLU1DIGRyaXZlciAocmVxdWVzdGVkIGZvciBuZXcNCj4+PiBkcml2ZXJzKSBh
bmQgbm93IEkgYW0gY29tcGxldGluZyB0aGUgY29udmVyc2lvbiBmb3IgdGhlIHdob2xlIHBpcGVs
aW5lLg0KPj4+IFdlIGFyZSB1c2luZyB0aGlzIE1DLWNlbnRyaWMgYXBwcm9hY2ggaW4gcHJvZHVj
dGlvbiBmb3Igb3VyIHByb2R1Y3RzIHRvDQo+Pj4gYmUgYXMgY2xvc2UgYXMgcG9zc2libGUgdG8g
bWFpbmxpbmUsIGFuZCBiYWNrcG9ydGVkIGl0IHRvIG91ciA1LjE1DQo+Pj4gaW50ZXJuYWwgcmVs
ZWFzZXMsIHdoaWNoIHBlb3BsZSBhcmUgdXNpbmcgcmlnaHQgbm93Lg0KPj4NCj4+IEknbSBub3Qg
YWxsIHRoYXQga2VlbiBvbiBicmVha2luZyB1c2Vyc3BhY2UgZm9yIHRob3NlIHdobyBkbyBOT1Qg
dXNlIHRoZQ0KPj4gQXRtZWwgQlNQLiBCYXNpY2FsbHkgc29tZSBwbGF0Zm9ybXMgYXJlIGN1cnJl
bnRseSBicm9rZW4sIGFuZCB3aXRoIHRoaXMgcGF0Y2gNCj4+IHNlcmllcyBzb21lIG90aGVyIHBs
YXRmb3JtcyBhcmUgYnJva2VuLCBidXQgYXQgbGVhc3QgY2FuIGJlIGZpeGVkIGJ5IGNoYW5naW5n
DQo+PiB1c2Vyc3BhY2UuDQo+Pg0KPj4gSG93IGZlYXNpYmxlIGlzIGl0IHRvIGRvIHNvbWV0aGlu
ZyBzaW1pbGFyIHRoYXQgVEkgZGlkIGZvciB0aGUgY2FsIGRyaXZlcj8NCj4+IChkcml2ZXJzL21l
ZGlhL3BsYXRmb3JtL3RpL2NhbCkNCj4+DQo+PiBJLmUuLCBiYXNlZCBvbiBhIG1vZHVsZSBvcHRp
b24gdGhlIE1DIGlzIGVuYWJsZWQgb3IgZGlzYWJsZWQuIEFuZCBpZiBhDQo+PiBjc2kyZGMgaXMg
cHJlc2VudCwgdGhlbiB0aGUgTUMgQVBJIGlzIGFsd2F5cyBlbmFibGVkLg0KPj4NCj4gDQo+IEkg
dGhpbmsgSSBoYXZlIHN1Z2dlc3RlZCBFdWdlbiB0byBtb3ZlIHRvIE1DIHdoZW4gaGUNCj4gc3Rh
cnRlZCBsb29raW5nIGluIGxpYmNhbWVyYSwgc28gc29ycnkgZm9yIHRoZSBpbnRydXNpb24gYnV0
IEkgZmVlbA0KPiBhIGJpdCBiYWQgZm9yIG5vdCByaXNpbmcgdGhlIHBvaW50IGVhcmxpZXIgYW5k
IGdldCBoaW0gdG8gdjEwDQoNCkRvbid0IGdldCBtZSB3cm9uZywgSSBsaWtlIHRoZSBNQyBhcHBy
b2FjaCwgYWZ0ZXIgaW1wbGVtZW50aW5nIGl0LCBJIGFtIA0KaGFwcHkgaG93IHRoZSBkcml2ZXIg
dHVybmVkIG91dC4gSXQncyBtdWNoIHNpbXBsZXIgYW5kIGNvdmVyaW5nIGEgDQpwbGV0aG9yYSBv
ZiBuZXcgdXNlIGNhc2VzIHdoaWNoIHdlcmUgcHJldmlvdXNseSBub3QgYXZhaWxhYmxlLCBhcyBp
dCB3YXMgDQptdWNoIG1vcmUgcmlnaWQuIFNvIEkgYWdyZWUgd2l0aCB3aGF0IHlvdSBzdWdnZXN0
ZWQsIGFuZCBJIHN1cHBvcnQgdGhlIA0KaWRlYSBhcyB3ZWxsLg0KDQo+IA0KPiBJIHVuZGVyc3Rh
bmQgeW91ciBwb2ludCBIYW5zLCBhbmQgd2hlbiBhIHZlbmRvciB1cHN0cmVhbWluZyBjb2RlIG9y
IGENCj4gdXNlciByZXF1aXJlcyB0byBtYWludGFpbiBjb21wYXRpYmlsaXR5LCB0aGUgYnVyZGVu
IG9mIGtlZXBpbmcgbW9yZQ0KPiBjb2RlIGluIHRvIGhhbmRsZSB0aGUgTUMgYW5kIG5vbi1NQyBj
YXNlcyBpcyB3b3J0aCB0aGUgY29tcGxpY2F0aW9ucy4NCg0KV2UgYXJlIHByZXR0eSBtdWNoIGNv
bnZpbmNlZCB0byB1c2UgdGhlIE1DLW9ubHkgYXBwcm9hY2ggYW5kIGFyZSBtb3ZpbmcgDQppbiB0
aGF0IGRpcmVjdGlvbi4gQnV0LCBpZiB3ZSBoYXZlIHRvIGtlZXAgdGhlIG9sZCBjb2RlIHRvIG1h
aW50YWluIA0KYmFja3dhcmRzIGNvbXBhdGliaWxpdHkgLCB3ZSBoYXZlIG5vIGNob2ljZS4NCkhv
d2V2ZXIsIHdlIHdpbGwgbW92ZSBmb3J3YXJkLCBhbmQgb25seSB1c2UgdGhlIE1DIGFwcHJvYWNo
IGZyb20gbm93IG9uLCANCmFuZCB3aWxsIG5vIGxvbmdlciB1c2UgdGhpcyBkcml2ZXIgd2l0aG91
dCBNQy4gVGhhdCB1c2UgY2FzZSB3aWxsIGJlIG91dCANCm9mIG91ciBzY29wZS4gSWYgdGhlcmUg
YXJlIHBlb3BsZSB1c2luZyBpdCBhbmQgaXQgd29ya3MsIGFsbCB0aGUgYmV0dGVyIA0KdGhlbi4N
Cg0KDQoNCj4gDQo+IEJ1dCBpZiBldmVuIHRoZSB2ZW5kb3Igd2FudHMgdG8gbW92ZSB0byBNQyB0
byBhbGxvdyBtb3JlIHVzZS1jYXNlcyBJDQo+IHRoaW5rIHdlIGhhdmUgdG8gYWNrbm9sZWdlIHRo
YXQgaWYgeW91J3JlIHJ1bm5pbmcgbWFpbmxpbmUgb24gYW4NCj4gZW1iZWRkZWQgc3lzdGVtIHlv
dSBjb3VsZCBleHBlY3QgdG8gYWRqdXN0IHlvdXIgc2V0dXAgYmV0d2VlbiBrZXJuZWwNCj4gdXBk
YXRlcy4gVGhlIGlkZWEgdG8gZG9jdW1lbnQgdGhlIG1lZGlhLWN0bCBjb21tYW5kcyByZXF1aXJl
ZCB0byBzZXR1cA0KPiB0aGUgcGlwZWxpbmUgaXQncyBoZWxwZnVsLCBhbmQgbWlnaHQgaGVscCBp
biB0aGUgaW50ZXJpbSBwZXJpb2QgdW50aWwNCj4gdGhlIHBsYXRmb3JtIGlzIG5vdCBzdXBwb3J0
ZWQgYnkgbGliY2FtZXJhLg0KPiANCj4gVGhhdCBzYWlkLCBpZiBFdWdlbiB3YW50cyB0byBnaXZl
IHRoZSBmbGFnIGEgdHJ5IEkgd29uJ3QNCj4gb3Bwb3NlIDopDQo+IA0KPiANCj4+IFJlZ2FyZHMs
DQo+Pg0KPj4gICAgICAgIEhhbnMNCj4+DQo+Pj4NCj4+Pj4NCj4+Pj4gbWVkaWEtY3RsIC1kIC9k
ZXYvbWVkaWEwIC0tc2V0LXY0bDIgJyJpbXgyMTkNCj4+Pj4gMS0wMDEwIjowW2ZtdDpTUkdHQjEw
XzFYMTAvMTkyMHgxMDgwXScNCj4+Pj4gbWVkaWEtY3RsIC1kIC9kZXYvbWVkaWEwIC0tc2V0LXY0
bDINCj4+Pj4gJyJkdy1jc2kuMCI6MFtmbXQ6U1JHR0IxMF8xWDEwLzE5MjB4MTA4MF0nDQo+Pj4+
IG1lZGlhLWN0bCAtZCAvZGV2L21lZGlhMCAtLXNldC12NGwyICciY3NpMmRjIjowW2ZtdDpTUkdH
QjEwXzFYMTAvMTkyMHgxMDgwXScNCj4+Pj4gbWVkaWEtY3RsIC1kIC9kZXYvbWVkaWEwIC0tc2V0
LXY0bDINCj4+Pj4gJyJhdG1lbF9pc2Nfc2NhbGVyIjowW2ZtdDpTUkdHQjEwXzFYMTAvMTkyMHgx
MDgwXScNCj4+Pj4NCj4+Pj4gVGhhbmsgeW91IGZvciB0YWtpbmcgY2FyZSBvZiB0aGlzICENCj4+
Pj4NCj4+Pj4gRXVnZW4NCj4+Pj4NCj4+Pj4+IFJlZ2FyZHMsDQo+Pj4+Pg0KPj4+Pj4gICAgICAg
ICAgICBIYW5zDQo+Pj4+Pg0KPj4+Pj4+DQo+Pj4+Pj4gRnVsbCBzZXJpZXMgaGlzdG9yeToNCj4+
Pj4+Pg0KPj4+Pj4+IENoYW5nZXMgaW4gdjEwOg0KPj4+Pj4+IC0+IHNwbGl0IHRoZSBzZXJpZXMg
aW50byB0aGlzIGZpcnN0IGZpeGVzIHBhcnQuDQo+Pj4+Pj4gLT4gbW92ZWQgSU9fTUMgYWRkaXRp
b24gZnJvbSBmaXJzdCBwYXRjaCB0byB0aGUgc2Vjb25kIHBhdGNoIG9uIHRoZSBkcml2ZXIgY2hh
bmdlcw0KPj4+Pj4+IC0+IGVkaXRlZCBjb21taXQgbWVzc2FnZXMNCj4+Pj4+PiAtPiBEVCBub2Rl
cyBub3cgZGlzYWJsZWQgYnkgZGVmYXVsdC4NCj4+Pj4+Pg0KPj4+Pj4+IENoYW5nZXMgaW4gdjk6
DQo+Pj4+Pj4gLT4ga2VybmVsIHJvYm90IHJlcG9ydGVkIGlzY19saW5rX3ZhbGlkYXRlIGlzIG5v
dCBzdGF0aWMsIGNoYW5nZWQgdG8gc3RhdGljLg0KPj4+Pj4+DQo+Pj4+Pj4gQ2hhbmdlcyBpbiB2
ODoNCj4+Pj4+PiAtPiBzY2FsZXI6IG1vZGlmaWVkIGNyb3AgYm91bmRzIHRvIGhhdmUgdGhlIGV4
YWN0IHNvdXJjZSBzaXplDQo+Pj4+Pj4NCj4+Pj4+PiBDaGFuZ2VzIGluIHY3Og0KPj4+Pj4+IC0+
IHNjYWxlcjogbW9kaWZpZWQgY3JvcCBib3VuZHMgdG8gaGF2ZSBtYXhpbXVtIGlzYyBzaXplDQo+
Pj4+Pj4gLT4gZm9ybWF0IHByb3BhZ2F0aW9uOiBkaWQgc21hbGwgY2hhbmdlcyBhcyBwZXIgSmFj
b3BvIHJldmlldw0KPj4+Pj4+DQo+Pj4+Pj4NCj4+Pj4+PiBDaGFuZ2VzIGluIHY2Og0KPj4+Pj4+
IC0+IHdvcmtlZCBhIGJpdCBvbiBzY2FsZXIsIGFkZGVkIHRyeSBjcm9wIGFuZCBvdGhlciBjaGFu
Z2VzIGFzIHBlciBKYWNvcG8gcmV2aWV3DQo+Pj4+Pj4gLT4gd29ya2VkIG9uIGlzYy1iYXNlIGVu
dW1fZm10ICwgcmV3b3JrZWQgYXMgcGVyIEphY29wbyByZXZpZXcNCj4+Pj4+Pg0KPj4+Pj4+IENo
YW5nZXMgaW4gdjU6DQo+Pj4+Pj4gLT4gcmVtb3ZlZCBwYXRjaCB0aGF0IHJlbW92ZWQgdGhlICdz
dG9wJyB2YXJpYWJsZSBhcyBpdCB3YXMgc3RpbGwgcmVxdWlyZWQNCj4+Pj4+PiAtPiBhZGRlZCB0
d28gbmV3IHRyaXZpYWwgcGF0Y2hlcw0KPj4+Pj4+IC0+IHJld29ya2VkIHNvbWUgcGFydHMgb2Yg
dGhlIHNjYWxlciBhbmQgZm9ybWF0IHByb3BhZ2F0aW9uIGFmdGVyIGRpc2N1c3Npb25zIHdpdGgg
SmFjb3BvDQo+Pj4+Pj4NCj4+Pj4+Pg0KPj4+Pj4+IENoYW5nZXMgaW4gdjQ6DQo+Pj4+Pj4gLT4g
YXMgcmV2aWV3ZWQgYnkgSGFucywgYWRkZWQgbmV3IHBhdGNoIHRvIHJlbW92ZSB0aGUgJ3N0b3An
IHZhcmlhYmxlIGFuZCByZXdvcmtlZA0KPj4+Pj4+IG9uZSBwYXRjaCB0aGF0IHdhcyB1c2luZyBp
dA0KPj4+Pj4+IC0+IGFzIHJldmlld2VkIGJ5IEphY29wbywgcmV3b3JrZWQgc29tZSBwYXJ0cyBv
ZiB0aGUgbWVkaWEgY29udHJvbGxlciBpbXBsZW1lbnRhdGlvbg0KPj4+Pj4+DQo+Pj4+Pj4NCj4+
Pj4+PiBDaGFuZ2VzIGluIHYzOg0KPj4+Pj4+IC0gY2hhbmdlIGluIGJpbmRpbmdzLCBzbWFsbCBm
aXhlcyBpbiBjc2kyZGMgZHJpdmVyIGFuZCBjb252ZXJzaW9uIHRvIG1jDQo+Pj4+Pj4gZm9yIHRo
ZSBpc2MtYmFzZS4NCj4+Pj4+PiAtIHJlbW92ZWQgc29tZSBNQUlOVEFJTkVSUyBwYXRjaGVzIGFu
ZCB1c2VkIHBhdHRlcm5zIGluIE1BSU5UQUlORVJTDQo+Pj4+Pj4NCj4+Pj4+PiBDaGFuZ2VzIGlu
IHYyOg0KPj4+Pj4+IC0gaW50ZWdyYXRlZCBtYW55IGNoYW5nZXMgc3VnZ2VzdGVkIGJ5IEphY29w
byBpbiB0aGUgcmV2aWV3IG9mIHRoZSB2MSBzZXJpZXMuDQo+Pj4+Pj4gLSBhZGQgYSBmZXcgbmV3
IHBhdGNoZXMNCj4+Pj4+Pg0KPj4+Pj4+IEV1Z2VuIEhyaXN0ZXYgKDUpOg0KPj4+Pj4+ICAgICAg
bWVkaWE6IGF0bWVsOiBhdG1lbC1pc2M6IHByZXBhcmUgZm9yIG1lZGlhIGNvbnRyb2xsZXIgc3Vw
cG9ydA0KPj4+Pj4+ICAgICAgbWVkaWE6IGF0bWVsOiBhdG1lbC1pc2M6IGltcGxlbWVudCBtZWRp
YSBjb250cm9sbGVyDQo+Pj4+Pj4gICAgICBBUk06IGR0czogYXQ5MTogc2FtYTdnNTogYWRkIG5v
ZGVzIGZvciB2aWRlbyBjYXB0dXJlDQo+Pj4+Pj4gICAgICBBUk06IGNvbmZpZ3M6IGF0OTE6IHNh
bWE3OiBhZGQgeGlzYyBhbmQgY3NpMmRjDQo+Pj4+Pj4gICAgICBBUk06IG11bHRpX3Y3X2RlZmNv
bmZpZzogYWRkIGF0bWVsIHZpZGVvIHBpcGVsaW5lIG1vZHVsZXMNCj4+Pj4+Pg0KPj4+Pj4+ICAg
ICBhcmNoL2FybS9ib290L2R0cy9zYW1hN2c1LmR0c2kgICAgICAgICAgICAgICAgfCAgNTEgKysN
Cj4+Pj4+PiAgICAgYXJjaC9hcm0vY29uZmlncy9tdWx0aV92N19kZWZjb25maWcgICAgICAgICAg
IHwgICAzICsNCj4+Pj4+PiAgICAgYXJjaC9hcm0vY29uZmlncy9zYW1hN19kZWZjb25maWcgICAg
ICAgICAgICAgIHwgICAyICsNCj4+Pj4+PiAgICAgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1l
bC9NYWtlZmlsZSAgICAgICAgIHwgICAyICstDQo+Pj4+Pj4gICAgIGRyaXZlcnMvbWVkaWEvcGxh
dGZvcm0vYXRtZWwvYXRtZWwtaXNjLWJhc2UuYyB8IDQ4NSArKysrKysrKystLS0tLS0tLS0NCj4+
Pj4+PiAgICAgLi4uL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy1zY2FsZXIuYyAgIHwg
MjY3ICsrKysrKysrKysNCj4+Pj4+PiAgICAgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9h
dG1lbC1pc2MuaCAgICAgIHwgIDUwICstDQo+Pj4+Pj4gICAgIC4uLi9tZWRpYS9wbGF0Zm9ybS9h
dG1lbC9hdG1lbC1zYW1hNWQyLWlzYy5jICB8ICAzNCArLQ0KPj4+Pj4+ICAgICAuLi4vbWVkaWEv
cGxhdGZvcm0vYXRtZWwvYXRtZWwtc2FtYTdnNS1pc2MuYyAgfCAgMzIgKy0NCj4+Pj4+PiAgICAg
OSBmaWxlcyBjaGFuZ2VkLCA2ODUgaW5zZXJ0aW9ucygrKSwgMjQxIGRlbGV0aW9ucygtKQ0KPj4+
Pj4+ICAgICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9h
dG1lbC1pc2Mtc2NhbGVyLmMNCj4+Pj4+Pg0KPj4+Pj4NCj4+Pj4NCj4+Pg0KPj4NCg0K
