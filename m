Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17012570027
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbiGKLVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiGKLV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:21:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B20357DD;
        Mon, 11 Jul 2022 03:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657536370; x=1689072370;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lcfLCl3VNDkumrnTQWJk8C/iVwOXh+schq6rF+gYOmI=;
  b=NhazMX0/T6b4FhofLYK0UoWF+4qlyu5PXgKiZgFQV0SZkZhrbjxnkdbI
   qeIe6PVGgOqovwFNTpLRsnhUiy83xQzPmRAAypCxO1XzeARne3flOfHLe
   McvDkWJBpA6gNDiDQTbBWVxXmolxheUgISBdsTigzzDTZB2AFgkgx26SP
   0nzzqkfTHA1CX1LlBFu2Uek6shnWojZVCfq/zMNesEiyb8mirCaGOfuD6
   W5saRrONvpjOg1HrSCdExNcfDZG/gA9aC2MtTL0WppUuY1CNueHJapB5D
   ttblHBOS6U/pxjzdHdkbDngCmy2DeDcRAK8nLyBc14Jk6m4DMtP9GJgcu
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="171854227"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2022 03:46:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 11 Jul 2022 03:46:05 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 11 Jul 2022 03:46:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8TJ3KHoxa/hvM4RiNNUi5F8ChTqtotYHRm6ST0XTl/P32Q0hA4zH7Hvoeonb78mx3fA2xMgTgri1lp8huRVpu0LoRiYDHUw614XzT7jhMLvlnxEftzDTL46ueIOH5iiL8miWWItyJnNikuCCS0Nd156zX68DwkNXkJqj2K/Dylt+xUmkDzZ6SIlmRRQyYarYupRhbWOfGm7hTOxxGqvhHu+/W/hM4Ak3EWfRGfl7fjwK4g2mjbGSgVFsPK9gnidNanu3GP2wb/r51Xl/+Ow0u2h34Uews3aOMWGrtbEKGkqImT/Ob7W9qd3+3ftMj9czff/y3TssmxH3/epE1v7Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcfLCl3VNDkumrnTQWJk8C/iVwOXh+schq6rF+gYOmI=;
 b=VoadjDydxOL+QjxvEvTT7TRi9OnPVBlqDirEhIx7PmOFZB09V47es4aO2GgtwMcpLebrEzWl1HSuAy5rL0+gRZhJBkjC1znnoNUVCNM5FuRLPbyS/oUfBvVWcqnacIHMgoNeEWJtolYq4x3NP4sVuiwyRINNl+ZretQfEYq5C9+RQuvxPu3aA7Ez4dEJRu2VrUPtWRr8x8iB8u+WvumsOwqRqMHhspPX7iVghYCbc5VYMkHnOzOIRYm3PJo/9mGwigRcKMjdWN5fHhmsmLUYlrJJamUDqk4udWQ5/GqFOVHZr1OzJerK3T3N/wKWnWh/5rQ/BOne3zNTlW1cTGXBpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcfLCl3VNDkumrnTQWJk8C/iVwOXh+schq6rF+gYOmI=;
 b=E558kd6713gdkV3bDq/RD12gNnw/ROBmBVhLQuQw5po0sVQpzae5XCaN3HST4eVaAg+lC2c7kZW0MJtC6U2yINoe/Tdeyc5evJ+HjZzYaSnY6KqLtRSLdQ9mFMveDlJ+OBcOJNiD50OGTc6hREJoUb0nHP31e3iZF32Hf370rIA=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MN2PR11MB4368.namprd11.prod.outlook.com (2603:10b6:208:17b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Mon, 11 Jul
 2022 10:46:00 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714%5]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 10:46:00 +0000
From:   <Conor.Dooley@microchip.com>
To:     <geert+renesas@glider.be>, <broonie@kernel.org>,
        <Daire.McNamara@microchip.com>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: SPI_MICROCHIP_CORE should depend on
 SOC_MICROCHIP_POLARFIRE
Thread-Topic: [PATCH] spi: SPI_MICROCHIP_CORE should depend on
 SOC_MICROCHIP_POLARFIRE
Thread-Index: AQHYlRDscDs8Hw01AUS3IkiKDybfsa14+TKAgAADiIA=
Date:   Mon, 11 Jul 2022 10:46:00 +0000
Message-ID: <f297d979-4e30-e882-f9da-2e6401123617@microchip.com>
References: <4e78693a87d6b83847056d22468c370e7232f390.1657529125.git.geert+renesas@glider.be>
 <373b74b4-657c-b6b7-9532-f6602d6b2a8e@microchip.com>
In-Reply-To: <373b74b4-657c-b6b7-9532-f6602d6b2a8e@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c845865-7b16-404b-2288-08da632a8b22
x-ms-traffictypediagnostic: MN2PR11MB4368:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uW64XOwRlkbJpluoltMJwJVoSxMdC313eglhDET6bs/eKPjZD7MyaorJlKolfi4il+LoZC9DmSORHvoNT9kA+M7YYRVKC9q+5nWVg9ePCN4rg9AUlrHsBFbpsU8k3tfJ7wQ0fy6MTWQe+sPNtvVBH36hS8szgL9tSyiJd+pDp6YH4JykELn7isUzMDNw9rWDE94WWn3wbJzKzfMRD3KM33bJqttKYnhIw48nIYOazmuN044biOF61rDkGhWpWJNcgicxmLxs9iyZoOlZbgmkrfP5n3gZBKAuiGRy3sZcA5Tn6BSDGGP6Rv1/xlKQFTAoe81P/Qg8MtVyG1nOqOVJQC2uejLO8nUQD73b44CUEaVLmHPbKBSWgsOry6qGaMdCv6P6hsA3xLspd1kVC31MmFij3QBL7qNOVnOwpx433kWnQg2E12OOcNPlbc5qE35malBQuOM3pD7HRS+6fiYpxQGhiJFraTbsNZj+kcz3PIhrsrUnPdTao1tJo3p2IPXQ2PHOkeiXijOa1UCAvKlJns3tJrQx/TX1WhF3CqNiX9GU6S/ASPXfZYK5FJueTAJEIV7mrtvWP9Dxn55Rq/eMEC6sHnNIDiC4JF1dBTp2g2yNFwA2ikEE82McqDlppilX4AgSLVdwGMZBOjx3RBiEOvw4LQ8BPihP4oI7NFxBKtinQdjpYSPx3mmjbUDD5iC9bFsQuwS/8bGSAgSrRHjBaopyugWGhOWDSGjdFysI/NWJU+c2x6I3TKqsblnLFxnci7k3N+TtsYIYJ4VvShmSz9JzyK4hdeMbEcZrcLgEIgERJdjSN69AmrU13IccTb64ntFQpWaG/VvXfdO37nncgJIZ6FB/K7ZHF48XVWz/YArh7aXznWc4uBYlpv+Q6huxtIdxFqVH+HJFkVwt1aJ9qA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(366004)(39860400002)(136003)(396003)(8936002)(5660300002)(53546011)(6512007)(2906002)(41300700001)(122000001)(83380400001)(86362001)(478600001)(38100700002)(36756003)(71200400001)(110136005)(6486002)(966005)(91956017)(66476007)(66946007)(8676002)(6636002)(54906003)(4326008)(2616005)(186003)(66556008)(316002)(76116006)(66446008)(64756008)(6506007)(31686004)(26005)(38070700005)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVkwMEY2UC81azJZald1N0phNFJMWkJvMlB4eG9vaUdoSE5qVE9YUUFMallk?=
 =?utf-8?B?YlBCZ2JzenZ2aWo2aXhxbXB4YnhMNitYNTlwNnloSjZUbEV5SFhqdkZTTk1B?=
 =?utf-8?B?bGl2eUsxSGk4ZjZiWTRBUng5SDZ1SnQ4aXcrajRUU0IyQTBjOFN3UGUyN2R6?=
 =?utf-8?B?RjY0Wm5CVEhNWXFMaUsyUjFldHY0dlJCT05LTGxzeU5YV3E1MkxRc2ZHSWNq?=
 =?utf-8?B?NVE0bFdxczBOaWMyTGkwbVlPbFBkN3pVN3kra3Y4Vlk1cjNIZWlLTDk2ZFQ4?=
 =?utf-8?B?V0Rhei8vZ0d3Y2hvOXg5emlWOHBpRzFhY2RoR3Iwb3VaOXU4UFAzcE9mbFhq?=
 =?utf-8?B?ZFpFSFZkQlI3ZjU5aS92eDBCR2I3emJ0WFZIdzkzSWxRNTlhcS9ZYjNtTXRL?=
 =?utf-8?B?UGd4amR6TFJnWnovL3BKTWlFSFBnd3NWMm5MWVBta2I5NzFGOUoyelczSVl2?=
 =?utf-8?B?S0tlWUZPTXR6RXZIU1NTWFdUSkZuZ1hqODhmZXZnemwwSmI3QlZkRVNDZUlY?=
 =?utf-8?B?eG4xSDBuNDFDMnRxYzNQcXdNSnI0OHJlaUphMmFFZDdpazcyQmtXZEdtdzFo?=
 =?utf-8?B?TVRmdXhLT09ZUmQzc2pseEFtd0loNFBZek5EYmhqZElNeWtNM24ydkg5bDJm?=
 =?utf-8?B?cisyaWo4SEpzUUZodXEvVUhJbkFseTBhaldBalNnZlBUWlZxdFJINzRpTHBG?=
 =?utf-8?B?OHJValBzUXNiby9BUjJ1emg3Z0IwWmw2R3Z5K3JxeGRHeXZNcDllU1hxS28w?=
 =?utf-8?B?MGlMVGlpVTNsaHZaN25tSXMwSk4wRWxCZUxMaU5KVXdwb1RyUnFDdnFEd2o0?=
 =?utf-8?B?WVJ2MlNGbXRMYWNyL01SZkt4K2RZNG9jYXdNUExSWFVFK1NTTUlsd2gvZnBu?=
 =?utf-8?B?aC9SSlFCWnNySEs3RWc4V3ZQTXFTa3U4TGFiaWVYbzVjelU4VmNGUjVJV1Zv?=
 =?utf-8?B?QVY0K0hyMXB2blZLNUNXRE42ajZHUDJCdmpHVUJzWDl5LzI5NXVwenZ6NkZt?=
 =?utf-8?B?L3pUZUozRlZGaS9nbS95MWNERVZOcklVV1F3ME53Y28wNVFUclRkQXJCOHZX?=
 =?utf-8?B?eVdrOGJrVi9DM2s4M28xZFp0dXJLa2FWMGxnVXJkRFVmZ3hkSFNjUG52Zjg5?=
 =?utf-8?B?VkNabFROR1ZUbHdFdzJ6ZzJPZEY3cU91Tm9WK3BaVTI4ZDNBdWdYMDBHOUJq?=
 =?utf-8?B?WHN4cFVYWk8vb2hEMmFtSEpNTHlIT3V0ZlgydzN5TURyTEdNd2RBMCtMSllo?=
 =?utf-8?B?OTYvUitlcEw2N3Y4ZlR1aHpqT3lTWlJLM2J4MTZIUzBLYjM1Wm9CUWNxZVZF?=
 =?utf-8?B?Y014QlhhYzZiVzU4ZG1pRGdidllXNkF1Y09uUHozOUFWSGFIblRPNlR1cWM1?=
 =?utf-8?B?UDM1NU8zbDZ4amlaZ1I1c29WWXNKcVUwWHFxdEc0YWwyZVpOc3VleXJpbkdv?=
 =?utf-8?B?SmkyWkVtWGtwSnhGU2gxeG9ZVTNaanNEMGFOMklpai96cVN3NzJwS1ltMEh4?=
 =?utf-8?B?YmVodjZWRmNOcDF0RzB3UFI5SjBBOEpxUW5NcUdJdjJuVDhQODJYaDRQalU0?=
 =?utf-8?B?N0lMOFhYdFcwcHdhS25tNEpOMEhYTDE1bEFhQStlOEgrZEZ1ZUlseXpwaFg3?=
 =?utf-8?B?UTBpdW1FbmRha2tIbms1eS90MWRvMmJ2cnRrUmYwY1BvKzZpRGF5VEt2SHk2?=
 =?utf-8?B?Z1BadnVZeFVvdTV3K0RrdUcrRFEvckZPU29rcGVZRlU5ZDdqOSt3NWVuKzhK?=
 =?utf-8?B?NGNTVzhIdFdIVW8vY2o4OFk0MnU2ZHdVeTQ5eDNKRUdmdXRpTFErQ0l4UEVr?=
 =?utf-8?B?T3Y2TWFlTlN2TDllblRxUUxSRDVtUC96QW13WldKK0hZVmtJZm04amtGVmUy?=
 =?utf-8?B?VnJrTTNwbXc0T1JqcW9Lb3lnckFyNDFLTkdqUXZKVnhsRG5hRWk1L1FBdjJI?=
 =?utf-8?B?c1d2dE5lYjdicURpK3lwYlc0cHgzb2tIYjZUU21XQk9hYVRWbGcwZWRhemZC?=
 =?utf-8?B?MFhIaFZkOHN1bU9XSnFZSzNhUVV3RmdFNURFaVZoNmQ5TTNPNUJBSmxqUDAz?=
 =?utf-8?B?Y2p5SERRNTlWSWxhanZtQ245K1NaUEdURWZmMW8rVTEyM2ZqbEhSanNJdG8w?=
 =?utf-8?Q?K3eRH4HOQbsXeMmFeSJA0oAp7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2401489B0C692D48B1AEE4EAD888B778@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c845865-7b16-404b-2288-08da632a8b22
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 10:46:00.0236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jdXIEsTZCteAyEEGBgfHmz0jTskWqWS1/WfFyRA27+2R5wjFmTmJAE3eXkK1EpYbt5m83cWQCBNyb3p5SzigQmwEhPvJmLUylpgwt2l2Zws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4368
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMDcvMjAyMiAxMTozMywgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBPbiAxMS8wNy8yMDIy
IDA5OjQ1LCBHZWVydCBVeXR0ZXJob2V2ZW4gd3JvdGU6DQo+PiBFWFRFUk5BTCBFTUFJTDogRG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBj
b250ZW50IGlzIHNhZmUNCj4+DQo+PiBUaGUgTWljcm9jaGlwICJoYXJkIiBGUEdBIFNQSSBjb250
cm9sbGVyIGlzIG9ubHkgcHJlc2VudCBvbiBNaWNyb2NoaXANCj4+IFBvbGFyRmlyZSBTb0NzLsKg
IEhlbmNlIGFkZCBhIGRlcGVuZGVuY3kgb24gU09DX01JQ1JPQ0hJUF9QT0xBUkZJUkUsIHRvDQo+
PiBwcmV2ZW50IGFza2luZyB0aGUgdXNlciBhYm91dCB0aGlzIGRyaXZlciB3aGVuIGNvbmZpZ3Vy
aW5nIGEga2VybmVsDQo+PiB3aXRob3V0IE1pY3JvY2hpcCBQb2xhckZpcmUgU29DIHN1cHBvcnQu
DQo+Pg0KPj4gRml4ZXM6IDlhYzhkMTc2OTRiNjZkNTQgKCJzcGk6IGFkZCBzdXBwb3J0IGZvciBt
aWNyb2NoaXAgZnBnYSBzcGkgY29udHJvbGxlcnMiKQ0KPj4gU2lnbmVkLW9mZi1ieTogR2VlcnQg
VXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4NCj4gDQo+IFVudGlsIEkgZ2V0
IHRoZSAic29mdCIgdmVyc2lvbiBzb3J0ZWQsIG1ha2VzIHNlbnNlIHRvIG1lLg0KPiBSZXZpZXdl
ZC1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCg0KQWN0dWFs
bHksIEkgd2FzIHRoaW5raW5nIGFib3V0IHdoeSB0aGUgInNvZnQiIHZlcnNpb24gd291bGQgY2hh
bmdlDQphbnl0aGluZyBhbmQgSSByZWFsaXNlZCB0aGF0IHRoaXMgaXMgbm90IGNvcnJlY3QuDQoN
CkkgcmVzY2luZCBteSBSLWIuDQoNCllvdSBjYW4gYWxzbyB1c2UgdGhpcyBvbiB0aGUgSGlGaXZl
IFVubGVhc2hlZCBFeHBhbnNpb24gYm9hcmQgdmlhDQpjaGlwbGluazoNCmh0dHBzOi8vcmF3Lmdp
dGh1YnVzZXJjb250ZW50LmNvbS9wb2xhcmZpcmUtc29jL3BvbGFyZmlyZS1zb2MtZG9jdW1lbnRh
dGlvbi9tYXN0ZXIvYm9hcmRzL2xjLW1wZnMtZGV2LWtpdC9pbWFnZXMvdXBkYXRlZC1sYy1saWJl
cm8tZGVzaWduLnBuZw0KDQpJIGhhdmUgbmV2ZXIgdHJpZWQgdGhpcyBzbyBJIGZvcmdvdCBhYm91
dCBpdCwgYnV0IGp1c3QgYXMgdGhlIFBDSQ0Kcm9vdCBwb3J0IGlzIGFjY2Vzc2libGUsIHNvIGlz
IHRoZSBTUEkuDQoNClNvcnJ5IQ0KDQoNCg==
