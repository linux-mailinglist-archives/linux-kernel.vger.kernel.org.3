Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9E24DCD1E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237160AbiCQSBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237144AbiCQSBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:01:45 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C919E21C06A;
        Thu, 17 Mar 2022 11:00:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEqzfSon6hYVwylLQjqo1rsUAjHv4weg5Jk1pvj6MP78jujqIdMqpcFJv+HYtJMYmwXC6C0KWzjejhgqHLVAhAF6Mk2dMjib3P6ZRLR2UJv7KEL/TZ9NHX9BqdYZtVpeFOrrD/zUojlo0LEJAdxUYFs/7I1SEFwfsGGuWXNSJ/5ovtC24dAFqu7Hfiak+O5IvA4WpCO326EtqfZlslnZRUHrmYwUpLu87h404uB34BJxFXvw4I67XX3BlU2dtJQYpTlP3cbuR5Sgq7Wkh2Ah4d0cY2Wt1h8J7GAlYA5r0+ht8UdcBr0ZTety4HGX49p7cS/U5kMr6/FQRUOkQSlQEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1i+9vOamBnXpw0usw/mleC/WBfmDN+fo4LF4pIAf8Y=;
 b=Lpx3dcrJknet4u+Lh+nTEWL1xRVrkEQ7m3Rqu9H7vQwD1Kss85QmMALGrvqlNIxuwlEog1GZAbpKMlxcHaojyYt6cN0Qq3GssOHk0Xuo7eZ8lHs7lPH1W351A5Xe7dvec8zF7VB4wAfThiRPfv2uSnZyAZByTSBuebHeKkQlFnL0x6cwFHV3Dj0qC/yxykZ3oEQONh24kiu2e7IrWkiFjApCDSEXlI9M3byEw3Y/TjaI4uja1GT87yuf74oXcm0hBuF4wLpHWVtkNTYeX51rN9ntkQv6oG0iXuw3fn+Q2sJke8DECY7QFXPDvTmCPDNMAN4oXB4VgM2dDinNdj4OTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1i+9vOamBnXpw0usw/mleC/WBfmDN+fo4LF4pIAf8Y=;
 b=p+MF10vNWEfr7U8YWqzbZc3e451FxUWOtbfkxTxA7pcRNo/KG+Cv3ZIZoc4j+ZLCkUC3EDVRCyGJ+SofytUYks2IymKsqJw5vOaLxj7cerVsxwFd7KRGzI0+yC7QuYwPdy3Ya+nsTlRUXE03xVvhgDwWG8WCcYYMJWIhGNA/U15qn8V1M10Rlgf7vGVW+3RKIl1swP6M5uRso101sAQ6kfxhacXa9VSKncVbtuoqx3r+S/2ULPOvTJ8u5jMaNS/SrqvzmdJdCOw8SQSjnndrie7dUhWMAVW/evmpoxLDsaMJ1Ag0OL5iAR1L+i5zUdeWceFUoJYi45R446kMapHh1g==
Received: from DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) by
 DM6PR12MB3802.namprd12.prod.outlook.com (2603:10b6:5:1c5::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.17; Thu, 17 Mar 2022 18:00:25 +0000
Received: from DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::801f:6a57:dcf6:6229]) by DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::801f:6a57:dcf6:6229%9]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 18:00:25 +0000
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     Jonathan Hunter <jonathanh@nvidia.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Ashish Singhal <ashishsingha@nvidia.com>
CC:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] spi: tegra210-quad: Add wait polling support
Thread-Topic: [PATCH 2/3] spi: tegra210-quad: Add wait polling support
Thread-Index: AQHYOZ0zTorLfdRhBU606fY3d7aIxazDRiKAgAABqDCAAAwzAIAAX4YAgAAomhA=
Date:   Thu, 17 Mar 2022 18:00:25 +0000
Message-ID: <DM4PR12MB57695F4DF462E705EC58D826C3129@DM4PR12MB5769.namprd12.prod.outlook.com>
References: <20220317012006.15080-1-kyarlagadda@nvidia.com>
 <20220317012006.15080-3-kyarlagadda@nvidia.com>
 <391736bc-84c2-ec8b-9f04-614365953da3@nvidia.com>
 <DM4PR12MB57692EB17ABCA36E0515412EC3129@DM4PR12MB5769.namprd12.prod.outlook.com>
 <edcae0c1-a576-1560-5ecb-9dcf08d8ead3@nvidia.com>
 <7032fbfb-8899-d00b-a7fa-811e19d38ce2@nvidia.com>
In-Reply-To: <7032fbfb-8899-d00b-a7fa-811e19d38ce2@nvidia.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0068dc2-00ee-482d-c6b4-08da08400368
x-ms-traffictypediagnostic: DM6PR12MB3802:EE_
x-microsoft-antispam-prvs: <DM6PR12MB38023D353FECF0029100A2D8C3129@DM6PR12MB3802.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2RSSPAmTT6EkZ/ixyJnMGk5anwgZdql2kq8rpFsY3UPeyQTmTt0PZX6Lksvl+IzrXqzHrobcJqgqk9Phv6MHi2TbIXCjn2EA/q0YJOi56MYTeFM8dfU4Eoi10Z/te8rODDKCT2bDdEpZwt3SmwevjdHw0Im/vm7hJBeicFjZNR3GgHpRNU2zB/vpoKv2DKE8h/eVkDOC5ABaq2gZXnn7z7xGDC1gwU3aTMGtV9a26ulmmkQwx1xiNa1E/7WhPpDpzIC2oitxxbqnLVXlh7J93iBy0rb0WIsYLzLL8KmnMB8Nog60vdPuzbjfCXSOzX6lAXQywtUdQLr+GWGv5Ee0OSzkp7WBLmJKSnV71T8OQmapFFzzkJWJikGf4aDv52Im9BpaEFWZi8KDo25+QD7IsHrbMuf4GYgw0bU7YCBeKrOkG6umcPFYM0uJh6/9pUmv7wQnCfYUW7/zkLTjdMHINcE9Kzm6zS+pzK8qrJ3HqYr3CKiEHNtWTxY8b7cKX6YdhLatXER/4Lw0tJ/d3qyVLMqFZvSr/kNb9TCssuWpdL6IxCR7rhwRRmNObyMrFgj5Ns8icFUJmDMWjcl0CrlgujjbXEsd22LK7/fvlKFyUHp0T3kIbkpqyf7XXFCTvHhbpKfE5p8UvvQELSmQ1Mg+pS5VFxBnenyrT58AkWyKw/9hlKguFHYXquNoD+nB9jcqMy+5D829ADWFzs++xmjcEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5769.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(6636002)(54906003)(110136005)(38100700002)(122000001)(33656002)(71200400001)(83380400001)(55016003)(55236004)(53546011)(6506007)(9686003)(7696005)(26005)(8676002)(186003)(508600001)(2906002)(66556008)(76116006)(66476007)(66446008)(64756008)(66946007)(4326008)(52536014)(8936002)(38070700005)(86362001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTBxcThpb09yMktZS0dCaDRTNHJOUzFsSXdZeVdQQWRJUnpoakpNTjlHYjVl?=
 =?utf-8?B?VXNMZ2I4Y2t6cW1sdjdpVllwMHRjRGRuc3p2MVdQZFJNV1JPS3BrZnoraVh6?=
 =?utf-8?B?YTFkZ2ZIWVkyUllkay9MMktrYStMTWg3dE9vNzczR0V6dHJNQkdMS3JsbStj?=
 =?utf-8?B?bzJaZU9ua3FQZm1ESktPeVpPWEh6dEwyT0VYUTJZWE5wMnY2NkxXNndkZlFm?=
 =?utf-8?B?NTlPOGEwRTJaQnRqTkVvTkk3VHdQTUJQRkdiNnhTU2pzNmNCV2UzRW9oNzFy?=
 =?utf-8?B?bjdCN2hwSXUzSGFqeVJWZjV2ZDdrRjlJREw4bVRaODVQRWQ1b3E0VGl1bUY4?=
 =?utf-8?B?VncwMXNZRmRpOUloSHkzdzhSVEFEMENoNHkzMjM0TmFIR0d6TkE1YzBrRklp?=
 =?utf-8?B?Q2c1Tk91UUY4UXVjWGJ0R0pJcE5Uc0xsUTlhNTFEejJHNHN3ZUJTbTg0cmVM?=
 =?utf-8?B?Ti82cWZNRHArUE1HK3pOYmlldXQwL2dpNXI2ZGZTRldqYy9NbGszZVhhUW1I?=
 =?utf-8?B?VFd6dWJTdHcxS054UENXdGhTeVNhMXJxYXJjOS9hek1EemRFV094M1hMMUx0?=
 =?utf-8?B?TEovd3FBaWNSazRvOGptQnBwb2lNVUVmYWNCa1pYSjdvVEM5aExTdDVLMVhS?=
 =?utf-8?B?NEk4ZXdJUnlyODlETnI2U0EzNlpILzREck5DVFJxc3cvSENvNTQrZ1ZidXZN?=
 =?utf-8?B?VHJFcFhENFZqZWFZTURxTXFYcUUzYzFJejA1TnZKRTI3RHpSeGE2b21hVU1Y?=
 =?utf-8?B?UElBR1NQWG1XVFJUMDYwc0ZZQlpkWFhwM01GYmNGLzRNZ2dlTFlGd2pBa0Ev?=
 =?utf-8?B?ZFcxcWFqc01FT3plS2JXbExqYnNWaW51aG5LLzVLdWRHRkNYekVnTVZzUDZU?=
 =?utf-8?B?dlBFaXZrZkRuZ1RMeVFlR3M2SU5VVWxNTzJ3QUlpcE9UV0tzRWVnWXJkZ0hi?=
 =?utf-8?B?MjFGV2xZQ3E2SEt5SnFhbmw0TlVTY2tzT1dyUkRVaHpyOWNMRG9DWGMyNHIr?=
 =?utf-8?B?K0x3Q0J5Z1NkZFpNdnBjSEdWN2Q2Z3FOdVJXWU50VnNnMlh1TGdaTUxMaWhk?=
 =?utf-8?B?L3VWd0l3OFBpVW9CejU0QXc5ZEk5Z2pLWThKeWExNDFrVis3eTYydDdlNzA4?=
 =?utf-8?B?ZmY0N2ROSmtORkMrLzBRLytoaXp6RUNJNVI4dERSOFBaaElubUtEYU9DOUEv?=
 =?utf-8?B?ZXZWa2dEdTFqL3F3YTRHNVhNaURoZitwSHRoTFZZb1BEWFNVaHNLOURLVW41?=
 =?utf-8?B?SFlnOUpsbnNhbVdxR0h6M0pWcng4dmlKZW02TDErcFlFNHNGYTJQdWs5OUpS?=
 =?utf-8?B?bFFNakswVS92QUtRYmdrSWpFSGpSSy9kay9iYngvVFMrUlFOczdSczFXZDVE?=
 =?utf-8?B?dmkxMFRwVjJPbFozSk9WUTM5eUhXQUlld254K25HNVV0SlAvTEN0SHA3WXVx?=
 =?utf-8?B?Myswc0d6c3JJTlVzRUltQ3E3NlJvRWpEME9KQUhGK2duMXVKL2VqdkdVS0tC?=
 =?utf-8?B?L2dBZkU5aWs1NlBSK3pIdTRjdktHRi9nNmlyblRPUjdjOUlkT0RaWk93aXJn?=
 =?utf-8?B?Q3pXQW1rNG5xTXpKVmFIS01TTTJtaFNEK0FJeGdWOXorU0I1OVRaZ3JVNlAv?=
 =?utf-8?B?WnZndjVteERnbkw4dXJzdXN3cUsrdVpnaW12RzR4Y3A5OEpSelJocFhMNVVn?=
 =?utf-8?B?TU5vNm03dkQ3ZFNuZ3h6Z0xLZG9wNzllMDhSZVU1S2gxWUJmS0xPYTFUZ0pp?=
 =?utf-8?B?YWdsYWlKZzNkQ1BudE0rc0dJYkUweVZJUVNUL3RQWCtGVmRpV3JBV2gyMkNV?=
 =?utf-8?B?SnJQeDZTYXFPOGtuS2NMMDdwclhaVUhmeXQrNzNpbWNXelVTRkQ4NTBKYSta?=
 =?utf-8?B?Q3VLQVc2ZFBRUmxlVUdmaldYTXdacjQyZlZVMmQxNUdnRzlQUVZzbWdSTmpp?=
 =?utf-8?B?UkdGa3N3MVh3dGxYd3hWWWxZdDNocFZMQmcvQU03WkMrVzFlRmZncFJTTHE5?=
 =?utf-8?B?VERXWVJ5MURRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5769.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0068dc2-00ee-482d-c6b4-08da08400368
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 18:00:25.2911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: on4hqqDDqQ7ph6cEf/wTybcYL1ObONn5/j0qLSJfXofdvlFwNRdLORqo3xmNQvg2oy8npuyBCMJpaRGQYXDxMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3802
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNClJlZ2FyZHMNCktZDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
Sm9uYXRoYW4gSHVudGVyIDxqb25hdGhhbmhAbnZpZGlhLmNvbT4NCj4gU2VudDogMTcgTWFyY2gg
MjAyMiAyMDo1Ng0KPiBUbzogS3Jpc2huYSBZYXJsYWdhZGRhIDxreWFybGFnYWRkYUBudmlkaWEu
Y29tPjsgYnJvb25pZUBrZXJuZWwub3JnOyB0aGllcnJ5LnJlZGluZ0BnbWFpbC5jb207IGxpbnV4
LXNwaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LXRlZ3JhQHZnZXIua2VybmVsLm9yZzsgQXNo
aXNoIFNpbmdoYWwgPGFzaGlzaHNpbmdoYUBudmlkaWEuY29tPg0KPiBDYzogU293amFueWEgS29t
YXRpbmVuaSA8c2tvbWF0aW5lbmlAbnZpZGlhLmNvbT47IExheG1hbiBEZXdhbmdhbiA8bGRld2Fu
Z2FuQG52aWRpYS5jb20+OyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggMi8zXSBzcGk6IHRlZ3JhMjEwLXF1YWQ6IEFkZCB3YWl0IHBvbGxpbmcgc3VwcG9ydA0K
PiANCj4gDQo+IE9uIDE3LzAzLzIwMjIgMDk6NDQsIEpvbiBIdW50ZXIgd3JvdGU6DQo+ID4NCj4g
PiBPbiAxNy8wMy8yMDIyIDA5OjAyLCBLcmlzaG5hIFlhcmxhZ2FkZGEgd3JvdGU6DQo+ID4+PiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+Pj4gRnJvbTogSm9uYXRoYW4gSHVudGVyIDxq
b25hdGhhbmhAbnZpZGlhLmNvbT4NCj4gPj4+IFNlbnQ6IDE3IE1hcmNoIDIwMjIgMTQ6MjUNCj4g
Pj4+IFRvOiBLcmlzaG5hIFlhcmxhZ2FkZGEgPGt5YXJsYWdhZGRhQG52aWRpYS5jb20+OyBicm9v
bmllQGtlcm5lbC5vcmc7DQo+ID4+PiB0aGllcnJ5LnJlZGluZ0BnbWFpbC5jb207IGxpbnV4LXNw
aUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiA+Pj4gdGVncmFAdmdlci5rZXJuZWwub3JnOyBB
c2hpc2ggU2luZ2hhbCA8YXNoaXNoc2luZ2hhQG52aWRpYS5jb20+DQo+ID4+PiBDYzogU293amFu
eWEgS29tYXRpbmVuaSA8c2tvbWF0aW5lbmlAbnZpZGlhLmNvbT47IExheG1hbiBEZXdhbmdhbg0K
PiA+Pj4gPGxkZXdhbmdhbkBudmlkaWEuY29tPjsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiA+Pj4g
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcN
Cj4gPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8zXSBzcGk6IHRlZ3JhMjEwLXF1YWQ6IEFkZCB3
YWl0IHBvbGxpbmcgc3VwcG9ydA0KPiA+Pj4NCj4gPj4+DQo+ID4+PiBPbiAxNy8wMy8yMDIyIDAx
OjIwLCBLcmlzaG5hIFlhcmxhZ2FkZGEgd3JvdGU6DQo+ID4+Pj4gQ29udHJvbGxlciBjYW4gcG9s
bCBmb3Igd2FpdCBzdGF0ZSBpbnNlcnRlZCBieSBUUE0gZGV2aWNlIGFuZA0KPiA+Pj4+IGhhbmRs
ZSBpdC4NCj4gPj4+Pg0KPiA+Pj4+IFNpZ25lZC1vZmYtYnk6IEtyaXNobmEgWWFybGFnYWRkYSA8
a3lhcmxhZ2FkZGFAbnZpZGlhLmNvbT4NCj4gPj4+PiAtLS0NCj4gPj4+PiDCoMKgIGRyaXZlcnMv
c3BpL3NwaS10ZWdyYTIxMC1xdWFkLmMgfCAzMSArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ID4+Pj4gwqDCoCAxIGZpbGUgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKQ0KPiA+Pj4+
DQo+ID4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3BpL3NwaS10ZWdyYTIxMC1xdWFkLmMNCj4g
Pj4+PiBiL2RyaXZlcnMvc3BpL3NwaS10ZWdyYTIxMC1xdWFkLmMNCj4gPj4+PiBpbmRleCBhMmUy
MjVlOGY3ZjAuLmVjZjE3MWJmY2RjZSAxMDA2NDQNCj4gPj4+PiAtLS0gYS9kcml2ZXJzL3NwaS9z
cGktdGVncmEyMTAtcXVhZC5jDQo+ID4+Pj4gKysrIGIvZHJpdmVycy9zcGkvc3BpLXRlZ3JhMjEw
LXF1YWQuYw0KPiA+Pj4+IEBAIC0xNDIsNiArMTQyLDcgQEANCj4gPj4+Pg0KPiA+Pj4+IMKgwqAg
I2RlZmluZSBRU1BJX0dMT0JBTF9DT05GSUfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDBYMWE0DQo+
ID4+Pj4gwqDCoCAjZGVmaW5lIFFTUElfQ01CX1NFUV9FTsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBCSVQoMCkNCj4gPj4+PiArI2RlZmluZSBRU1BJX1RQTV9XQUlUX1BPTExfRU7CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIEJJVCgxKQ0KPiA+Pj4+DQo+ID4+Pj4gwqDCoCAjZGVmaW5lIFFT
UElfQ01CX1NFUV9BRERSwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweDFhOA0KPiA+Pj4+IMKgwqAg
I2RlZmluZSBRU1BJX0FERFJFU1NfVkFMVUVfU0VUKFgpwqDCoMKgwqDCoMKgwqAgKCgoeCkgJiAw
eEZGRkYpIDw8IDApDQo+ID4+Pj4gQEAgLTE2NSwxMSArMTY2LDEzIEBAIHN0cnVjdCB0ZWdyYV9x
c3BpX3NvY19kYXRhIHsNCj4gPj4+PiDCoMKgwqDCoMKgwqAgYm9vbCBoYXNfZG1hOw0KPiA+Pj4+
IMKgwqDCoMKgwqDCoCBib29sIGNtYl94ZmVyX2NhcGFibGU7DQo+ID4+Pj4gwqDCoMKgwqDCoMKg
IGJvb2wgY3NfY291bnQ7DQo+ID4+Pj4gK8KgwqDCoCBib29sIGhhc193YWl0X3BvbGxpbmc7DQo+
ID4+Pj4gwqDCoCB9Ow0KPiA+Pj4+DQo+ID4+Pj4gwqDCoCBzdHJ1Y3QgdGVncmFfcXNwaV9jbGll
bnRfZGF0YSB7DQo+ID4+Pj4gwqDCoMKgwqDCoMKgIGludCB0eF9jbGtfdGFwX2RlbGF5Ow0KPiA+
Pj4+IMKgwqDCoMKgwqDCoCBpbnQgcnhfY2xrX3RhcF9kZWxheTsNCj4gPj4+PiArwqDCoMKgIGJv
b2wgd2FpdF9wb2xsaW5nOw0KPiA+Pj4+IMKgwqAgfTsNCj4gPj4+Pg0KPiA+Pj4+IMKgwqAgc3Ry
dWN0IHRlZ3JhX3FzcGkgew0KPiA+Pj4+IEBAIC04MzMsNiArODM2LDExIEBAIHN0YXRpYyB1MzIg
dGVncmFfcXNwaV9zZXR1cF90cmFuc2Zlcl9vbmUoc3RydWN0DQo+ID4+Pj4gc3BpX2RldmljZSAq
c3BpLCBzdHJ1Y3Qgc3BpX3RyYW4NCj4gPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbHNlDQo+
ID4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb21tYW5kMSB8PSBRU1BJX0NPTlRS
T0xfTU9ERV8wOw0KPiA+Pj4+DQo+ID4+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmICh0cXNwaS0+c29j
X2RhdGEtPmNtYl94ZmVyX2NhcGFibGUpDQo+ID4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Y29tbWFuZDEgJj0gflFTUElfQ1NfU1dfSFc7DQo+ID4+Pj4gK8KgwqDCoMKgwqDCoMKgIGVsc2UN
Cj4gPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb21tYW5kMSB8PSBRU1BJX0NTX1NXX0hX
Ow0KPiA+Pj4+ICsNCj4gPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoc3BpLT5tb2RlICYg
U1BJX0NTX0hJR0gpDQo+ID4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb21tYW5k
MSB8PSBRU1BJX0NTX1NXX1ZBTDsNCj4gPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbHNlDQo+
ID4+Pj4gQEAgLTkxNyw2ICs5MjUsNyBAQCBzdGF0aWMgaW50IHRlZ3JhX3FzcGlfc3RhcnRfdHJh
bnNmZXJfb25lKHN0cnVjdA0KPiA+Pj4+IHNwaV9kZXZpY2UgKnNwaSwNCj4gPj4+Pg0KPiA+Pj4+
IMKgwqAgc3RhdGljIHN0cnVjdCB0ZWdyYV9xc3BpX2NsaWVudF9kYXRhDQo+ID4+Pj4gKnRlZ3Jh
X3FzcGlfcGFyc2VfY2RhdGFfZHQoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSkNCj4gPj4+PiDCoMKg
IHsNCj4gPj4+PiArwqDCoMKgIHN0cnVjdCB0ZWdyYV9xc3BpICp0cXNwaSA9IHNwaV9tYXN0ZXJf
Z2V0X2RldmRhdGEoc3BpLT5tYXN0ZXIpOw0KPiA+Pj4+IMKgwqDCoMKgwqDCoCBzdHJ1Y3QgdGVn
cmFfcXNwaV9jbGllbnRfZGF0YSAqY2RhdGE7DQo+ID4+Pj4NCj4gPj4+PiDCoMKgwqDCoMKgwqAg
Y2RhdGEgPSBkZXZtX2t6YWxsb2MoJnNwaS0+ZGV2LCBzaXplb2YoKmNkYXRhKSwgR0ZQX0tFUk5F
TCk7DQo+ID4+Pj4gQEAgLTkyNyw2ICs5MzYsMTEgQEAgc3RhdGljIHN0cnVjdCB0ZWdyYV9xc3Bp
X2NsaWVudF9kYXRhDQo+ID4+Pj4gKnRlZ3JhX3FzcGlfcGFyc2VfY2RhdGFfZHQoc3RydWN0IHNw
aV9kZXZpYw0KPiA+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZj
ZGF0YS0+dHhfY2xrX3RhcF9kZWxheSk7DQo+ID4+Pj4gwqDCoMKgwqDCoMKgIGRldmljZV9wcm9w
ZXJ0eV9yZWFkX3UzMigmc3BpLT5kZXYsICJudmlkaWEscngtY2xrLXRhcC1kZWxheSIsDQo+ID4+
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJmNkYXRhLT5yeF9jbGtf
dGFwX2RlbGF5KTsNCj4gPj4+PiArwqDCoMKgIGlmICh0cXNwaS0+c29jX2RhdGEtPmhhc193YWl0
X3BvbGxpbmcpDQo+ID4+Pj4gK8KgwqDCoMKgwqDCoMKgIGNkYXRhLT53YWl0X3BvbGxpbmcgPSBk
ZXZpY2VfcHJvcGVydHlfcmVhZF9ib29sDQo+ID4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICgmc3BpLT5kZXYsDQo+ID4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgIm52aWRpYSx3YWl0LXBvbGxpbmciKTsNCj4gPj4+PiArDQo+
ID4+Pg0KPiA+Pj4NCj4gPj4+IFRoaXMgbG9va3Mgb2RkLiBXaHkgZG8gd2UgbmVlZCB0aGlzIGRl
dmljZS10cmVlIHByb3BlcnR5IGlmIGl0IGlzDQo+ID4+PiBhbHJlYWR5IHNwZWNpZmllZCBpbiB0
aGUgU29DIGRhdGE/DQo+ID4+IFNvYyBkYXRhIHNwZWNpZmllcyBjaGlwIGlzIGNhcGFibGUgb2Yg
d2FpdC1wb2xsaW5nLg0KPiA+PiBXYWl0IHBvbGxpbmcgc3RpbGwgaGFzIHRvIGJlIHNlbGVjdGVk
IG9uIHNsYXZlIGRldmljZXMgdGhhdCBjYW4NCj4gPj4gc3VwcG9ydCBpdC4NCj4gPj4gSSB3aWxs
IGFkZCBvbmUgbGluZSBkZXNjcmlwdGlvbiBmb3IgdGhlIHByb3BlcnRpZXMgaW4gbmV4dCB2ZXJz
aW9uLg0KPiA+DQo+ID4NCj4gPiBJIGNhbid0IHNheSBJIGFtIGZhbWlsaWFyIHdpdGggdGhpcywg
YnV0IGl0IHNlZW1zIHRoYXQgdGhlIGlkZWFsDQo+ID4gc29sdXRpb24gd291bGQgYmUgYWJsZSB0
byBkZXRlY3QgaWYgdGhpcyBuZWVkcyB0byBiZSBlbmFibGVkIGRlcGVuZGluZw0KPiA+IG9uIHRo
ZSBkZXZpY2UgY29ubmVjdGVkLiBJcyB0aGF0IG5vdCBwb3NzaWJsZT8NCldlIGNhbm5vdCBkZXRl
Y3QgYXQgcnVudGltZSB3aGljaCBzbGF2ZSBzdXBwb3J0cyB3YWl0IHBvbGxpbmcuDQo+IA0KPiBB
bHNvLCBnaXZlbiB0aGF0IEdyYWNlIHN1cHBvcnRzIDQgY2hpcC1zZWxlY3RzIHBlciBkZXZpY2Us
IGhvdyBkb2VzIHRoaXMNCj4gd29yayBpZiB0aGVyZSBpcyBUUE0gY29ubmVjdGVkIHRvIG9uZSBj
aGlwLXNlbGVjdCBhbmQgc29tZXRoaW5nIGVsc2UNCj4gY29ubmVjdGVkIHRvIGFub3RoZXI/DQpX
YWl0IHBvbGxpbmcgaXMgcGFydCBvZiBjbGllbnQgZGF0YSB3aGljaCBpcyB1bmlxdWUgZm9yIGVh
Y2ggY3Mgc2xhdmUuDQpUaGlzIGZsYWcgd2lsbCBiZSBlbmFibGVkIG9uIGNvbnRyb2xsZXIgcmVn
aXN0ZXIgd2hpbGUgaW5pdGlhdGluZyB0cmFuc2Zlcg0KZm9yIFRQTSBzbGF2ZSBhbmQgZGlzYWJs
ZWQgZm9yIGFsbCBvdGhlciB0cmFuc2ZlcnMuDQo+IA0KPiBKb24NCj4gDQo+IC0tDQo+IG52cHVi
bGljDQo=
