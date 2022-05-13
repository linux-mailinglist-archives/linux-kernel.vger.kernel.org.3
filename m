Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D23525CAE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377956AbiEMHzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 03:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377973AbiEMHzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 03:55:23 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A831829B03F;
        Fri, 13 May 2022 00:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652428520; x=1683964520;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+D3icICTSBlMhVNYhhJZPwlx86T5JS5fFAtXs7Sluy8=;
  b=Yt3Oacv2pDL79Hxm6mizBbC0D5fHP2Ek4pd5UYTgvd2wLnU8JZHZObws
   myw7nK1aFBtjKXnExWFYPuy6y6RPF84S84cZykeqeaQL29k3vpqZzvhaz
   CGYR88gHyPvfIxT7byhXMXOlta+MZ+y71x64ovs3Nwfb4LRYnTL10RUPN
   kNs6R0iiRmGqXnHdrTx5Wry79YKr7iuZec0NQtA2YHhNdaqv73ifdKz6w
   TYWs8YN0TWpIIs5vdHHh3Pgd/lxQiEQEon0wQsDLw37pQVcqt9gm3uN7/
   b0sSYdNEEfwPXVATQDsc9zt/7N5AtI4SJqIMs/tmtFrmMhDNKT4G7GRed
   g==;
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="95654319"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2022 00:55:19 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 13 May 2022 00:55:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Fri, 13 May 2022 00:55:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBXFHyYnZdNke6EpeU8HfB31Ch5HLRMogNx7lo9v/TzAxgpY1cD7d+vTsdp6AfptnKu8GPdr4e69kVn2QY7muumyH9Piw2mbWWr9vCCsQ8kSPbyyhDQFqeVj9OeOeAMoj6Mluvozx5g9yKwCQQuTfteFAevdEISMVPaV0ibZhfGJWgKm6RCPJPQBmOcPUYP9bStmy4ta/yfqLTNy6sU3Gwkn11CtvVd2JAQTCvX6yNgjHwU1JjTqOo54zA6UxsMn9+52luUUPMMfk/8vQjML454BZKG2pjHalMpIr74FUaoxwQzQnZiUnvp0oWO5Z5aIKd4uY2XriUO5W0QPw6iiRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+D3icICTSBlMhVNYhhJZPwlx86T5JS5fFAtXs7Sluy8=;
 b=RsSbh1BizO4hNPeb1cGPlwoIDiAE8dVRV9u56LUl20IIJjZPWVeDYDKRJCeJA3OfrJcchEkwX5diSQMEXiuelG7xaiYGewsEnKfjOVPcpZxJW+IeC1W6WRy1fvQ0Z1VBTiG9AEOTnRl80sq4IwmCVOVQke/0Xfv6hZuBXMr0J9qcuBdqjYy3iL5zQjkHWD0g5NBdh1HbcvHWTmmyzp0ezKXxdk4f7507ZKB2wdXhwuumopYYv9sN4w5dTtqssBfNzw/wqtodC+d7dhp0/QVyCF/bNdMNYeW2ufisFMLrAD9E25BGj2SlypSbJ3YPF9KbALZV1xfe4e6CZw8ArtKarQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+D3icICTSBlMhVNYhhJZPwlx86T5JS5fFAtXs7Sluy8=;
 b=cK0yFM9df//YC26iJ+8cWhLPQkrqz9HleQca+7my87e+2XeeXK2q8AHLP59fy29hG2ZEoK0OgBKIn/cX8QZzz3R6mVCI+gjc9yxs7aLfs7S6Dm2dIq2hIzhFIRMYHujbeXMkABtcQ/NW1g/nNB9lGdUAMcFHofYDLmVblBj3aUc=
Received: from PH0PR11MB5160.namprd11.prod.outlook.com (2603:10b6:510:3e::8)
 by DM6PR11MB3899.namprd11.prod.outlook.com (2603:10b6:5:19c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Fri, 13 May
 2022 07:55:14 +0000
Received: from PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::d10f:cc33:cfd8:365e]) by PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::d10f:cc33:cfd8:365e%8]) with mapi id 15.20.5250.014; Fri, 13 May 2022
 07:55:14 +0000
From:   <Conor.Dooley@microchip.com>
To:     <hch@lst.de>
CC:     <sfr@canb.auug.org.au>, <linux-next@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <rppt@kernel.org>
Subject: Re: linux-next: Tree for May 3
Thread-Topic: linux-next: Tree for May 3
Thread-Index: AQHYX5FrH/BqiZa6/06OwkWdFdBwha0Wk2YAgAAKyQCAAAevAIABXEcAgAE9tgCAAAeAgP///8QAgAA4D4CAAClqAIAC1WmA
Date:   Fri, 13 May 2022 07:55:14 +0000
Message-ID: <09a503cb-db09-db2b-ce7f-9797497028c5@microchip.com>
References: <20220503172926.08215c77@canb.auug.org.au>
 <3f94c9a8-c927-5cc0-7d67-4b21c3d9dbaf@microchip.com>
 <9a424be9-380f-f99c-4126-25a00eba0271@microchip.com>
 <20220509141122.GA14555@lst.de>
 <dd946220-eaf6-773a-06b4-307cda466c9c@microchip.com>
 <505d41d1-1bc8-c8bc-5ebb-8a2b7934f3de@microchip.com>
 <20220511062232.GA32524@lst.de>
 <102578f2-5c10-e9c2-c1ef-e76ba90d011e@microchip.com>
 <20220511064832.GA761@lst.de>
 <2c0e2fbe-4e45-4acc-c2a7-4f4dcf9161a3@microchip.com>
 <20220511123724.GA25121@lst.de>
In-Reply-To: <20220511123724.GA25121@lst.de>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e55b3a9c-5029-44a2-3f05-08da34b5ea16
x-ms-traffictypediagnostic: DM6PR11MB3899:EE_
x-microsoft-antispam-prvs: <DM6PR11MB38995754D5FD0148A760235098CA9@DM6PR11MB3899.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PfI0nd/dy2v/e3/6rdKZX5W7ctX70lZEFxhPIKj3jcpzvqNoskoPPynEZ1dDM+ds0NxEKDmd6goUMtuJZHYz2a2xO8a/Z2XZzpOo1X9Mcj3ezGCrzN/jnfBjJv/CSG07Q4KiL5e0pD4Gt5y2IQgrVuqcKWZ3FBi1Yw18XSjrti2n/Ev1xAyKsYSQH+nkSae13GOwdhwAIorZf7E/2gx1UCBwz1oBTxCydr2Fh7IgaLqYKFWeEKP6Eyh9PE0GfLj6h6qx34amCwDNmycrJQGlu7+5nZ/vcTyrstxHNMwVE9wPVRf+btPEM2Wmp3io/LbOaww/IrVIwuDeoo4FQRZzjZvieb1AITzEWn+YPkzi+EKlh1YRwiMyYxRkKpnUvdKd9afJWDgrEQ+XjWerzlU0vg+cMTFFRy/9fqj2UJZG3UXgVgabavJQVwyZbyrZL8dKtYspO0LLOSc4zMD9C8MjVx/9VgjrQaMyizs1mdUNpC11MDbi+RpPSIRgyNTnAVmKHyfJ9M02JXR0NCxNxx9xUme0dq2bQax5Vt4bg8ByEi+QEvmjyjbHi4JtXjnSet2s1DWPiKcPP7tJZ9k4V2jZunpHXhGEq4OppvKC3VbyxoDpsJaNHAWjwuvhvv0qxB3AjGB0qQ7b1YKGNz2pcLbRprlwrYyDcd4etsoc4Co5IGT+BEgjAGMpIUQ+XZIf6ACUaf3pxVi8ivkaMjDS4H2K8xD8VOuuusrK/YWYWjgJSGmnJjYJMEHadefsGzk3ES9U6SGSvL58FpTLE1qXzVJxlA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5160.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(5660300002)(26005)(83380400001)(508600001)(6486002)(38100700002)(6512007)(186003)(31686004)(54906003)(6916009)(36756003)(6506007)(53546011)(71200400001)(2906002)(66476007)(31696002)(64756008)(76116006)(66946007)(66556008)(91956017)(316002)(66446008)(4326008)(86362001)(8676002)(122000001)(2616005)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXZXN0J3Z3VBWDdmSmNGeU5MR2ZMRFhlcURhSG5NSCtwUEsyK0pNREhIVENr?=
 =?utf-8?B?ZXhVcnZodldkalRCMy8ySzVyT1pTQ2dSQjViNDI2V08vMXdTZE1mVEkva2tQ?=
 =?utf-8?B?S093cGpyS2hKQUJFanhoTVo5TTF1Y3lFS0E5SFZJZ25iYU9zRzJCVEN2eEh5?=
 =?utf-8?B?RCtwT2RpYmxJaXkzWUxGY1NHclNGZGZrejl2OFZGUGtTUVlQMkdpN3hsb0N3?=
 =?utf-8?B?UUVtU1dWeUJWaVVlWXZ2bTc4V3E4L0hCSEsydUJEUnE4SG5ySXV2c05oRTFL?=
 =?utf-8?B?SXRKQS95c0Yxd2JkaEtmNGJLRFJEZVUxLzFHSmR0VFZUckZuQkVXZlZib0g3?=
 =?utf-8?B?R0tQeEpRNmczckJxa2w3cWFsMHRyM2tRYkNVeGZjMjcxZkg1Y1JVZWs5MUll?=
 =?utf-8?B?WForenBnMkttZ0tINzMzT1dwQ0w5VFQwZjhXLzNCOHl1M2hBK09EbmhiYkY4?=
 =?utf-8?B?eE1WMmNiMkNLTFByM1hTdU5uUUJvZnN0bGk0NUFZcTJJM3ZRN2syVm5mYW0y?=
 =?utf-8?B?c2g2My8rU2k2dEU0WCt0cVBOZktYY1ZrbXJIclNoM1RIemJlNFYwRWE2Vkky?=
 =?utf-8?B?QWRIdEtHNTVZQmNRUkZod2NJQXU2M3RzTHQzR3ExUzRMN3NJSTcvU3JlWUIx?=
 =?utf-8?B?UnllTWcyM3JhMzlXc0U2QWR0RThlVmFOWVlYTzRkckhPbUF6OXJkdVBRS1da?=
 =?utf-8?B?N05qVUJxMkZDVmMxTkxaNFg3T3IwTEhKSG9GTWxSaExZWjd6NDgrNWljRTdh?=
 =?utf-8?B?S2NwRTNGUVgvdGExOVM3Rm04SUtwZEQyMW5zcHFLYkFJamFpSjZSL2tDNVNI?=
 =?utf-8?B?VUptdVBNa3RYMmhaQThuUEFYRFNYRzEyMlFrbGZOQ3dOUXhWdXVNNkNtaFRU?=
 =?utf-8?B?SVdSMzB4bXBSYVlvZVF3WlJIN2ozYjhVQUJkc1VyaEY0V045ZnAwdkRUaDM2?=
 =?utf-8?B?S1JZV1hWNFJTMWhYRDZzUEM1bjQzb3ArVktpYjRkY1o3MmxhTHNsZ29oWkJT?=
 =?utf-8?B?Y2xqMnkzUmloZ2ZZOXk0K29ZckZmWWtib1ljTEN0Y2RPZW1jL3lmTStXaUNL?=
 =?utf-8?B?TkRjenBzQnhjS1lkODA2RzU2cFlEekdPU1FiT0hpK3VrYzRDRityUG5wUTJn?=
 =?utf-8?B?MmNpZWxhQUtQZktURHZoL0Z3NHRGMjF4ZXVVVGM2MzBYeGh0VFhMOTQrMkJE?=
 =?utf-8?B?ZW1EOUJ3cWFScWpxd2tUa2x1RDhuUEdxeXFVT2dnNWJJYmgydWQrRDNHVFlD?=
 =?utf-8?B?V3ZFV05ZUSsxYXBsVXQ5OEtDZndqSDJSQzh5QkdBMU1vaU5MWkNZT2V3U04y?=
 =?utf-8?B?VnJUd1QwWE96S1pPNFJwcldlMlNoSXhIU01YSzFpUFpLd3VsY3d5eCtOdDlz?=
 =?utf-8?B?WGg0c3pKTzF2RUJsdEhtRVdmTWMxMFpyNGFYOGZlN0kzMXBNK05WUURURndR?=
 =?utf-8?B?a2dmcndnd1NUQlBpcXd2SEhoS09aSE15MnFhU29QNk1oYlVYa1lBL1R5MEZh?=
 =?utf-8?B?ZDhEZ3FLZ0pkV2FhZ0x0L3F0bnRiTFJ4N0JHUERuWFk5V0l5bmovVXRPbWE3?=
 =?utf-8?B?akk3UWxKOUVmRnBBbDBYb0tFaXh4ZUZ3YVc1ZS9Va1JMVk55eDFYdGlUMitq?=
 =?utf-8?B?V2dNbzcrL1IvZ2ZqbEI5MCs2REI4NEhITjJ1T2xOV2dOdXF1d2d1M0w2Z1Vs?=
 =?utf-8?B?d0MrNDdLRS96MzlZa2VEaVNaUDFOVGhUVnlEUG1xMTZMSmhsK3dHSnNWeFYx?=
 =?utf-8?B?RGNielFDQVM4UE5JNFBzenFCVUJPUEVZQndEYzdKZENQc0ZkeGxwQ0NMK0t3?=
 =?utf-8?B?SHdldERYK3dRbGxZOVlCZnhiTlRxN05wSzZmSmFjemgzNGxvUDNCTHpIaHJo?=
 =?utf-8?B?aUJ6RVUzWTFIMXljclZUSmxuY3QzR2loUlcwclBlZFVidnh2YU9aOG44cmtt?=
 =?utf-8?B?clBOTkpkY1dOZG82NDZNNkdTWW9HZkdjdENCL1orWWxoamM2Yk92UWY2WDc1?=
 =?utf-8?B?dXJyL3l3Q3lOUjM0ZGU1NTl2eEZQR3U2Znl4RW1jRXdPNlZoQm9HMTJPV0FO?=
 =?utf-8?B?OThzU2tBTzIzQ3YzSnBlZWxqRS9yY2ZRazJnMitXZlc1alE1aVM3Y3BCK3Qx?=
 =?utf-8?B?SHNvcE44SloxZ1JyUDVXeGp6ZVR6TnZZaWVxUWNyM2pWSzRyZGhzRDl6c2cz?=
 =?utf-8?B?ZmdhcDVqQmd5TFdjM0JTdDVPSWVnMHZ5eEk4dnNmWEU4aW9iSzR3TE8vWG5l?=
 =?utf-8?B?ZjZWVGVsS3BkMWJYSjN3RnBUZEdWLzlnUHpZZERNVGh3c2xDUnJXY0U2N05W?=
 =?utf-8?B?akpodEM4ZHpTTEVWeVRySEk0ZGFwcVRTQ0VBMFY0eXZ6SUtSdGswZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F375911A33D5B147A11A1F997094CCAB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5160.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e55b3a9c-5029-44a2-3f05-08da34b5ea16
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 07:55:14.7241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VMJKWwPwRrDxV3GIJj6pWJVjiBGx7T1RBM9jrqwNV4zg3jdl2V5mdMdhTPlynPi5VgT1FJrwBgVrMvsekyX54YBhEiQc1LzWKysdxnJcs2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3899
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMDUvMjAyMiAxMzozNywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gV2VkLCBNYXkgMTEsIDIwMjIgYXQg
MTA6MTA6NDBBTSArMDAwMCwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+PiBX
aXRob3V0IGV2ZW4gdHJ5aW5nIHRoZSBwYXRjaCwgSSBkb3VibGUgY2hlY2tlZCB0aGUgYm9vdCBs
b2cgZnJvbQ0KPj4gM2Y3MDM1NmVkZjU2IGFuZCBJIGdldCBhICJzb2Z0d2FyZSBJTyBUTEI6IENh
bm5vdCBhbGxvY2F0ZSBidWZmZXIiDQo+PiBXaXRoIHRoZSBwYXRjaCBpdHMgYSAic29mdHdhcmUg
SU8gVExCOiBzd2lvdGxiX2luaXRfcmVtYXA6IGZhaWxlZA0KPj4gdG8gYWxsb2NhdGUgdGxiIHN0
cnVjdHVyZSIuIFNvIHNwb3Qgb24gJiBJIGZlZWwgbGlrZSBhbiBpZGlvdCBmb3INCj4+IG5vdCBz
cG90dGluZyB0aGF0IGJlZm9yZSENCj4+DQo+PiBJcyBmYWlsaW5nIGJlaW5nIGZhdGFsIHZhbGlk
LCBvciBzaG91bGQgaXQgZmFpbCBncmFjZWZ1bGx5IGxpa2UgaXQNCj4+IHVzZWQgdG8gZG8/IFRv
IG1lLCBibGlzc2Z1bGx5IHVuYXdhcmUgYWJvdXQgc3dpb3RsYiwgdGhlICJjdXJyZW50Ig0KPj4g
YmVoYXZpb3VyIG9mIGZhaWxpbmcgZ3JhY2VmdWxseSBtYWtlcyBtb3JlIHNlbnNlLg0KPiANCj4g
R2l2ZW4gdGhhdCB3ZSdyZSBhdCAtcmM2IEkgdGhpbmsgdGhlIG1vc3QgaW1wb3J0YW50IHRoaW5n
IGZvciBub3cgaXMgdG8NCj4gYXZvaWQgYSByZWdyZXNzaW9uIGFuZCByZXN0b3JlIHRoZSBvbGQg
YmVoYXZpb3IuICBJJ2xsIHNlbmQgb3V0IGENCj4gc2VyaWVzIHdpdGggdGhpcyBhbmQgdGhlIG5z
bGFiIHJlbGF0ZWQgZml4ZXMgZm9yIFhlbiB0b2RheS4NCj4gDQo+IEJ1dCB3ZSBzaG91bGQgbG9v
ayBpbnRvIHdoeSBhbGxvY2F0aW5nIHRoZSBtZW1vcnkgZmFpbHMgZm9yIHlvdXINCj4gcGxhZm9y
bXMuICBEb2VzIGl0IGhhdmUgdmVyeSBsaXR0bGUgbWVtb3J5PyAgSSBjYW4ndCByZWFsbHkgdGhp
bmsNCj4gb2Ygd2h5IGVsc2UgdGhlIG1lbWJsb2NrIGFsbG9jYXRpb24gZm9yIHN3aW90bGIgd291
bGQgZmFpbC4NCg0KTXkgYXNzdW1wdGlvbiB3b3VsZCBiZSB0aGF0IGl0IGlzIHRoZSBjb21wbGV0
ZSBsYWNrIG9mIHVzYWJsZSBtZW1vcnkNCmF0IDMyIGJpdCBiaXQgYWRkcmVzc2VzPyBFdmVuIHRo
b3VnaCB0aGVyZSBpcyBtZW1vcnkgcGh5c2ljYWxseSB0aGVyZQ0KaXQgaXMganVzdCBiZWluZyBp
Z25vcmVkIGFzIHlvdSBjYW4gc2VlIGluIHRoZSBib290IGxvZyAoYmVjYXVzZSBpdCdzDQpiZWxv
dyB0aGUgZW50cnkgcG9pbnQ/KS4NCg0KTXkgcXVlc3Rpb24gaXMsIGRvZXMgZmFpbGluZyB0byBl
dmVuIGJvb3QgbWFrZSBzZW5zZSBpZiB0aGF0IGJ1ZmZlcg0KY2FuJ3QgYmUgYWxsb2NhdGVkPyBD
YW4gYXJndWUgdGhhdCBTV0lPVExCIHNob3VsZCdudCBiZSBlbmFibGVkIGluIHRoZQ0KZmlyc3Qg
cGxhY2UgaWYgdGhlcmUgaXMgbm8gRE1BMzIsIGJ1dCBpZiBpdCBpcyBlbmFibGVkIGluIGVycm9y
IHdvdWxkDQppdCBub3QgYmUgYmV0dGVyIHRvIGF0IGxlYXN0IGxldCB0aGUgc3lzdGVtIGJvb3Qg
JiBzcGl0IG91dCBhbiB1Z2xpZXINCndhcm5pbmc/DQooT2J2aW91c2x5IEkgbWlzc2VkIHRoZSBj
dXJyZW50IHdhcm5pbmcsIGhlbmNlIHRoZSAidWdsaWVyIiBiaXQuKQ0KDQpUaGFua3MsDQpDb25v
ci4NCg0KKHJlYWRkaW5nIGxvZyBmb3IgY29udGV4dCkNClsgICAgMC4wMDAwMDBdIE9GOiBmZHQ6
IElnbm9yaW5nIG1lbW9yeSBibG9jayAweDgwMDAwMDAwIC0gMHhhZTAwMDAwMA0KWyAgICAwLjAw
MDAwMF0gT0Y6IGZkdDogSWdub3JpbmcgbWVtb3J5IHJhbmdlIDB4MTAwMDAwMDAwMCAtIDB4MTAw
MDIwMDAwMA0KWyAgICAwLjAwMDAwMF0gTWFjaGluZSBtb2RlbDogTWljcm9jaGlwIFBvbGFyRmly
ZS1Tb0MgSWNpY2xlIEtpdA0KWyAgICAwLjAwMDAwMF0gZWZpOiBVRUZJIG5vdCBmb3VuZC4NClsg
ICAgMC4wMDAwMDBdIFpvbmUgcmFuZ2VzOg0KWyAgICAwLjAwMDAwMF0gICBETUEzMiAgICBlbXB0
eQ0KWyAgICAwLjAwMDAwMF0gICBOb3JtYWwgICBbbWVtIDB4MDAwMDAwMTAwMDIwMDAwMC0weDAw
MDAwMDEwM2ZmZmZmZmZdDQpbICAgIDAuMDAwMDAwXSBNb3ZhYmxlIHpvbmUgc3RhcnQgZm9yIGVh
Y2ggbm9kZQ0KWyAgICAwLjAwMDAwMF0gRWFybHkgbWVtb3J5IG5vZGUgcmFuZ2VzDQpbICAgIDAu
MDAwMDAwXSAgIG5vZGUgICAwOiBbbWVtIDB4MDAwMDAwMTAwMDIwMDAwMC0weDAwMDAwMDEwM2Zm
ZmZmZmZdDQpbICAgIDAuMDAwMDAwXSBJbml0bWVtIHNldHVwIG5vZGUgMCBbbWVtIDB4MDAwMDAw
MTAwMDIwMDAwMC0weDAwMDAwMDEwM2ZmZmZmZmZdDQo=
