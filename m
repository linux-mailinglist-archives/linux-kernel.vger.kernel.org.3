Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E72854F700
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382025AbiFQLuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382005AbiFQLuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:50:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28BA6CF70;
        Fri, 17 Jun 2022 04:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655466616; x=1687002616;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=V1UCbZNQeGFuIWVeR2AQt4dW1+llsvy7w2i2Cebtmbc=;
  b=arXC+5W4cr6iOTRWoqHLtnHZvCGjGnKR7BSiDSddUDW1iZ7TkfQgXy1S
   +DxifuW8wb9cmXT2XhfsXph6ypfAmimNBslvAZfNiDT7sWD7lw3a+XIQC
   rGi2K64HTHtUGXGZhqTVn5S4hhoxkTQc1qCQnZl9ZD4A1sT6xKSdwszQl
   ez0pZkGjUlfpWgfrbwB4EXaFRPJUmnHeA5aCLez3ogY+Ipmk65rT/Y22e
   jQpz3KcpZC/tgBuvRyq6cEtipJnJTss1b/0KywxaBtYHAIjjfzw5tGCO8
   /2CvzFBMBnLW9CQKPuk+egLjwD1FZjPHPqncTSZNu/lSnnPEJ2VPSEv/r
   A==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="168530293"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jun 2022 04:50:16 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 17 Jun 2022 04:50:17 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Fri, 17 Jun 2022 04:50:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WU2S5R0xECH56yy7NYhgXf31tW9bneqiZj9j4MJsoZcpaqHImrBTbE+L+5u4KozEfF7AOnmF212PE+sBnGW1GWLAS2VseQK+GKwEmdfjUvtv0XtJnNOrHMwQkylv21ZQp7lGoGMi5iGhgg5CaApqJiHuTqaxQF8Kkae4E9OT72k2niHtTq3ZUpfeSWSN+cFqwEO8W3uEKMD9hR7SQLlN3ObNnuBTvkNRixdt6dbnuubMMo1dtDr1wD6m8CxYSLDH016EUu6+9HfdOf31LoU1qOUAvIhmuY8exred5mOkV1Br4FVKc4txq4GtpgkaYpzSrVIRCo3L/0nlfm2ARvqzhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1UCbZNQeGFuIWVeR2AQt4dW1+llsvy7w2i2Cebtmbc=;
 b=HIPiuHWXQztXwkiT3au3/psXvYgJ8bNqf6tR5nRtRSAQABUf0usTU/FZz4QYbTuLDaALp5T5xrkxpHxuHh5uco/Q+oqP+L/PJ0cujQ5+XGI55+Hxr/UYZpKnnOiWwXlNMa7s352+CHKUY85VWobFQzhruEwWM6OllQzqKN8pR0gtcc6IoQALRwtZQREm1uYHOWdBN9Pul0cJJ2B5HbmHma/Kx7+MZzfKTSPgsdIWUOdhW2QuxsVw1NBcohQnHy1n8gMz7B7eW4FYK+4UG63uJ1hP1s5gDW/+5mD4IBdM4hHQw9Kcr4kkc1Ea5mZADyanMGtUWEUpcoXxfdPDzPYGQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1UCbZNQeGFuIWVeR2AQt4dW1+llsvy7w2i2Cebtmbc=;
 b=lTYBMYqBY1AN0wJ58k7yuOVuNhvnhqvqg4OnVLV5Y4/pzNz9a6eju6C4eoovt2K18H/FvO5LhWnrDc/MOIi+6vaGTojO4VEYalK3kpo2MOmx43bkd3mbXaNcaDXWOifWsflPbFsKEYnIG09u4dZ4PUSqiZ4Os5NCVYOJd17X1ts=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SN6PR11MB3245.namprd11.prod.outlook.com (2603:10b6:805:be::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Fri, 17 Jun
 2022 11:50:14 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5332.022; Fri, 17 Jun 2022
 11:50:13 +0000
From:   <Conor.Dooley@microchip.com>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <lee.jones@linaro.org>
CC:     <Daire.McNamara@microchip.com>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 0/2] Add support for Microchip's pwm fpga core
Thread-Topic: [PATCH v3 0/2] Add support for Microchip's pwm fpga core
Thread-Index: AQHYgj/xR/Z8Ogp3NEW1l6/5WqQ9pq1Te+GA
Date:   Fri, 17 Jun 2022 11:50:13 +0000
Message-ID: <a2d97203-dd8a-69ea-fdb5-b25f3937163f@microchip.com>
References: <20220617114442.998357-1-conor.dooley@microchip.com>
In-Reply-To: <20220617114442.998357-1-conor.dooley@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86e9adf3-02d4-4b55-3f18-08da50578a49
x-ms-traffictypediagnostic: SN6PR11MB3245:EE_
x-microsoft-antispam-prvs: <SN6PR11MB324533790819D0CE45B6D6C498AF9@SN6PR11MB3245.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fa+CYmsQieCdhAb5Jg8yTFkp9mKTrdjjbZFdryftU/Oz/5AzoSXNvCaDKxG6yy7sU7SfO9dzSHDh/tvo9GCDowdUzNELI7QD2F3BYvEfteI4qW6x7fXAIHZfef834Qt4kNVwgmZBjmL4wjAhqFERbatb0p/w9+cnQ33tyJ6lr14nYzYE906+dKOTN69ETGEUt9lTVdUueX9//S8FWmev2pqzWYtOp4ky34u+mR90swDxveoUqj/uP0QHIQNnUvf0Btn6f34S8tCnmnd2RbRAUtn9CgJeelMittWs2T6yccV+j23O6WPyCh0SkhWMDYQF4cj3J+/P0KfKsBCq9pwgG76vxscSsb1BmgfCNYh+LaNIpovBAYWlTGYJ2e7Nseq5U9StQwZD0qrjO7LtXXDAuaE8L/fNTpmGQRQrBnZDK+pqKwjRgxYY+7Ci5NAJUoNgbvxQfgs6/6XKeRj+OQFKImgU7IhTlOgoh4/R832ZQxtusWF+N5i/g4pP35cGw9jYYuP74pCKrGHVr7PtCH4mf8AkIr8+GPL6HxRX9yPo5/U0mAeHDChdLY+bdG1C9/qZABZehExqw+TUE0WbhBKmXyL4DQTkiPCHhYysNOFBQSED0yZ5w6ODV27zPMpzpd89GPbY7ubzNPIZZT6Ijj5/RIt7ADt4IpQg46zfnCTRkAYT9K9bF9pwFoYmTpMZdQuaMicraYJU0LfM4gjEI2C7Q55vCyogVdvpk6z2OqoKFrpuUOmeEvEpwDMyF68t/wVeku4sH8JFZRlRz6FXZGtylw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(53546011)(5660300002)(6486002)(8936002)(6506007)(31686004)(64756008)(66556008)(8676002)(38070700005)(4326008)(66446008)(66946007)(76116006)(122000001)(54906003)(498600001)(31696002)(110136005)(86362001)(66476007)(91956017)(316002)(71200400001)(186003)(2616005)(83380400001)(36756003)(6512007)(2906002)(26005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dklxc1N1Z2dlUzlpRzVVUkdKS1lGcFNMaW8reHVnSStmTGNCeHhiWFNNcWpu?=
 =?utf-8?B?eHA4WVlVbEp1T0dxZEpDckcxdFVGTDBwSEtIai8vdjVkUnNhM2cvN0g1Zkpn?=
 =?utf-8?B?VWMxS2djRlNWam1rN0dZQWp3WDJHRGdnNk9NczF4TGppNjBZNXlYdWw1R0RN?=
 =?utf-8?B?TmhRWmc2eTRLSEZKc2U0cWFzZGw3T0Z5NU13OWVKd0JHNEcxaXhqQWI3T1Ri?=
 =?utf-8?B?L2dMRW5FRzU5bE4zOGJ3YnpOSzhremhnaEtzYlltcy9PaHNQakxkUnBzN1ll?=
 =?utf-8?B?OVBtWHpHS1U1b2tjQkdxWEErMTZLNmp3R3orM3U1SVN0cysvZU4yRDdIZFZu?=
 =?utf-8?B?b05qa3pOL0RQSDJRc2NLdWNDTzFpWEU3WWo3ckNEZXFHWk5EMkRzeXVsZGRQ?=
 =?utf-8?B?NDdIQW8zNW9RZDdpS2kydXBTb01VMC8xamVlM3ptQjRhb2JVbFg5aGdIVEtn?=
 =?utf-8?B?UHZsOVVKOWNrYWFXVkRQdk1pek5CdnlKOTRrWHZ2dm1HbEJxTVE5aU1rNzVm?=
 =?utf-8?B?UlE0Tks4b1dhM2ZicXl3UkY2NjROaHd6Unpyaml2YzNpNU5tcFJZK0RsbXp6?=
 =?utf-8?B?UjZETUpERXE0MVMxUk82bHpnMTZ6RG56RnhHc0loWi9lSVJPZUY3cjVmbmIx?=
 =?utf-8?B?em45QXFFL3lXSE1SL0NTMzh6U0Y1dUszZ0dUK3BZUHlQdnBmOTVCV1E3alpN?=
 =?utf-8?B?bjVmbEZONDQ5VE5rVXk2Q0xiWW5KOWY4Z3hjRldnVUZlVmowK3BMR0o1MW5t?=
 =?utf-8?B?QzhUU1RLR3R0SlB6ZC9RSjVHY285WGlGbnJIRFJkM3ZnRWljTzE0L3Q0WEU5?=
 =?utf-8?B?TTJwNkZwa2JFcUU4TFdXRU5sOUltblJpRjNXYVN3V01vSUQrRUxtYkIzWjVl?=
 =?utf-8?B?eWlsSFJsdmxYcUpCc0FwdzBVT3M4RHVBRUg2QS9JVlJMMFA3TjBUUDc5LzJj?=
 =?utf-8?B?RHhUV21FQjhiUXM4TGZMRzkrTXJrSVBVV0lCOHVPcGZWZlpSWEJieHpQa2Zk?=
 =?utf-8?B?KzhCMldlZ2trNUZmOUNRSVo3YlNOdm9BdmtCOE1xa00yV0duVjBmNmdnRkM4?=
 =?utf-8?B?ckpVZTNLbzJrNDZKdmJHQVkzeERWNnBVVlkzVnFwOTE3K3o3MXZ0ZHlReUxp?=
 =?utf-8?B?UVB1N0VvV2o1Q2FFR2FzTGNGRVVqQnRnb3dTVDA5cFBSZkhNOTM0aUNBb055?=
 =?utf-8?B?SWlRN0EzR0ZzY2FtYUFzZ3VTNldORlJleTF2d1lGcXVGZkhlRzV0VWhYSnY0?=
 =?utf-8?B?eGZyOCt3dDlRUU9BWVVoandnU3Q4WThYSVFOTEtyYkJ3aXh5Y0dXZW9vdGFG?=
 =?utf-8?B?Q1dhQTViQkN3SUhtV3dyNUxhaFFYYU9oU1o0R095Tjc5T2tQMVFJQzJiN2xU?=
 =?utf-8?B?K1Y5dm91VURMU1dGbUF0YU9KYWlpWUJYd21XQTB5Zjl3UE96V3ZQSWowSVVO?=
 =?utf-8?B?MUgvSklHN0lDWEFUbUtXOGFPSHgvWGhOeFJEMGhpczc3aWt3K3Nkc09rdnpr?=
 =?utf-8?B?Y1dwS1VnOEtjVUF6RkNJc1FuaDZHSUtseStoS2VRekdOcWxILzJEZ3B3WUUz?=
 =?utf-8?B?akwwR0tZaUhCb0NPekd4cVBkYjRlOWZ1MWJvS3paZ0k2RUNEZkNWS3d5L3RV?=
 =?utf-8?B?Z3plUmhQWmJoa0ViSjd1aVdxZWVrRmVlc0dkTEdiOGEyemhtTHVUaHBuSGtR?=
 =?utf-8?B?VEcxb3Ryb1BDcHRKSDZWdVBDaU5naWxXaFFEeVZOTW5wTHpsSCszeFZPLzN3?=
 =?utf-8?B?MUlJUHloTW01K3o3VHNYajF4NXpuZ1AvK0QzNXA4TEFxaTlnYkJYVTlZWFUv?=
 =?utf-8?B?aDdBeUcwVEdUTElWWHNQMlBKQUovZkVLSml1TTBETDJSd3NEa2VwSUt3UVVl?=
 =?utf-8?B?ejlkUjFnUHpMRWs2QXBQR09CSW1DSlVQRUJtK2dGbTRsU0dJWDlSTG42Z0tm?=
 =?utf-8?B?aktFU2hSUGtLcGg0RFVJdWlmT2d3NTN6cTRSbVFzc0FWMG9nR0h2dmZjU1FF?=
 =?utf-8?B?Q28rVThrdzZTblF5YVIwUHMvbkxYWEU3OFZpTU5xQWRQQnBnZkN4ZGpkNU85?=
 =?utf-8?B?QVhnMEszNTRHelZSVW9PaUlISEQ4WlpTYk9GSSt1OEc2MEg0Z1NsWVRiVUlz?=
 =?utf-8?B?U2pnSjFJRnFTNGhEVHJxUzFDZGVWVTZUS0VKc0RML2ZTSGtndDNKbFNwMXR1?=
 =?utf-8?B?eCtqaWUyZUEvWXE3SFVGTFV2NDRoOXgyN2NialdVelZQbDRQWm9URGxFRWxO?=
 =?utf-8?B?UmtGdERYVlo2UElQaVR6NUNvYkdiaFlGYndvN3VuMHIyM3hLRFlDMnpjeVB1?=
 =?utf-8?B?T1dGdG1CNm5wRnpvOUVXeGg2azZ0MW5QZFdyUm5UU2V1V1VpMzIwaXo4enVF?=
 =?utf-8?Q?DiHRaLLMMhfSOMHs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EDD57088E9254438F452D2B7D612A84@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e9adf3-02d4-4b55-3f18-08da50578a49
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2022 11:50:13.8309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bWDlWGwEhgQWOJlEot+mzh+geRzAZlNn1xNvE1LoXbgMG+KsEsWpwqR3AB2CzsBYQH72wfE6BWu38c1notIa5bnb2/u1mv7bQVxDIPsSJkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3245
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTcvMDYvMjAyMiAxMjo0NCwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBIZXkgVXdlLA0KPiBH
b3QgYSB+djJ+IHYzIGZvciB5b3UuLi4NCj4gSSBhZGRlZCBzb21lIGNvbW1lbnRzIGV4cGxhaW5p
bmcgdGhlIGNhbGN1bGF0aW9ucyBhbmQgYSBkb2N1bWVudGF0aW9uIGxpbmsNCj4gc28gaG9wZWZ1
bGx5IHRoaW5ncyBhcmUgYSBiaXQgZWFzaWVyIHRvIGZvbGxvdy4NCj4gDQo+IENvZGUgd2lzZSwg
SSB3ZW50IHRocm91Z2ggYW5kIHNvcnRlZCBvdXQgYSBidW5jaCBvZiBpc3N1ZXMgdGhhdCBjeWNs
aW5nDQo+IHRocm91Z2ggdGhlIGRpZmZlcmVudCBwZXJpb2RzL2R1dGllcyB0aHJldyB1cC4gQWxv
bmcgdGhlIHdheSBJIGZvdW5kDQo+IHNvbWUgb3RoZXIgcHJvYmxlbXMgLSBlc3BlY2lhbGx5IHdp
dGggdGhlIGxvbmdlciBwZXJpb2RzIHdoaWNoIEkgaGF2ZQ0KPiBmaXhlZC4gSSBhbHNvIGFkZGVk
IGEgd3JpdGUgdG8gdGhlIHN5bmMgcmVnaXN0ZXIgaW4gdGhlIGFwcGx5IGZ1bmN0aW9uLA0KPiB3
aGljaCB3aWxsIHJlc29sdmUgdG8gYSBOT1AgZm9yIGNoYW5uZWxzIHdpdGhvdXQgInNoYWRvdyBy
ZWdpc3RlcnMiLg0KPiANCj4gT3RoZXIgdGhhbiB0aGF0LCBJIG1hbmFnZWQgdG8gZGl0Y2ggdGhl
IG1jaHBfY29yZV9wd21fcmVnaXN0ZXJzIHN0cnVjdA0KPiBlbnRpcmVseSBidXQgaGFkIHRvIGFk
ZCBhIHNob3J0IGRlbGF5IGJlZm9yZSByZWFkaW5nIGJhY2sgdGhlIHJlZ2lzdGVycw0KPiBpbiBv
cmRlciB0byBjb21wdXRlIHRoZSBkdXR5Lg0KPiANCj4gVGhhbmtzLA0KPiBDb25vci4NCg0KKnNp
Z2gqIHlldCBhZ2FpbiBJIGZvcmdvdCB0byBtZW50aW9uIHRoZSBwb3RlbnRpYWwgbWFpbnRhaW5l
cnMgY29uZmxpY3QNCndpdGggc3BpLW5leHQuLg0KDQo+IA0KPiBDaGFuZ2VzIGZyb20gdjI6DQo+
IC0gZml4IHBlcmNpZXZlZCBpZGVtcG90ZW5jeSBhbmQgcm91bmRpbmcgaXNzdWVzIHdoZW4gc2hh
ZG93IHJlZ2lzdGVycyB3ZXJlDQo+ICAgIGVuYWJsZWQNCj4gLSB1c2UgZG9fZGl2KCkgZm9yIGRp
dmlkZSBvZiB1NjQgdG1wIGluIGFwcGx5X3BlcmlvZCgpDQo+IA0KPiBDaGFuZ2VzIGZyb20gdjE6
DQo+IC0gYWNjb3VudCBmb3IgZWRnZSAicXVpcmsiIHdoaWxlIGludmVydGVkDQo+IC0gYmxvY2sg
Y2hhbmdpbmcgZW5hYmxlZCBjaGFubmVscycgcGVyaW9kDQo+IC0gZG9jdW1lbnQgdGhlIGhhcmR3
YXJlL2RyaXZlciBsaW1pdGF0aW9ucw0KPiAtIHJlYXJyYW5nZSBnZXRfc3RhdGUoKSBtb3JlIGxv
Z2ljYWxseQ0KPiAtIGZpeCBjYXN0IHNpemVzIGluIGdldF9zdGF0ZSgpDQo+IC0gZml4IHJlbW92
ZSgpIGFuZCBwcm9iZSBlcnJvciBwYXRocw0KPiAtIGRlbGV0ZSBtY2hwX2NvcmVfcHdtX3JlZ2lz
dGVycw0KPiAtIHNpbXBsaWZ5IC5hcHBseSgpIGxvZ2ljDQo+IC0gZG9uJ3Qgd2FybiBpbiBjYWxj
dWxhdGVfYmFzZSgpDQo+IC0gZml4IHBlcmlvZCBjYWxjdWxhdGlvbg0KPiAtIGZpeCBkdXR5IGN5
Y2xlIGNhbGN1bGF0aW9uDQo+IC0gYWRkIENPUkVQV00gcHJlZml4IHRvIGRlZmluZXMNCj4gLSBh
ZGQgYSBkb2N1bWVudGF0aW9uIGxpbmsNCj4gDQo+IENvbm9yIERvb2xleSAoMik6DQo+ICAgIHB3
bTogYWRkIG1pY3JvY2hpcCBzb2Z0IGlwIGNvcmVQV00gZHJpdmVyDQo+ICAgIE1BSU5UQUlORVJT
OiBhZGQgcHdtIHRvIFBvbGFyRmlyZSBTb0MgZW50cnkNCj4gDQo+ICAgTUFJTlRBSU5FUlMgICAg
ICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiAgIGRyaXZlcnMvcHdtL0tjb25maWcgICAgICAg
ICAgICAgIHwgIDEwICsNCj4gICBkcml2ZXJzL3B3bS9NYWtlZmlsZSAgICAgICAgICAgICB8ICAg
MSArDQo+ICAgZHJpdmVycy9wd20vcHdtLW1pY3JvY2hpcC1jb3JlLmMgfCAzMjUgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KPiAgIDQgZmlsZXMgY2hhbmdlZCwgMzM3IGluc2VydGlv
bnMoKykNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wd20vcHdtLW1pY3JvY2hpcC1j
b3JlLmMNCj4gDQo+IA0KPiBiYXNlLWNvbW1pdDogNjExMTRlNzM0Y2NiODA0YmMxMjU2MWFiNDAy
MDc0NWUwMmM0NjhjMg0KDQo=
