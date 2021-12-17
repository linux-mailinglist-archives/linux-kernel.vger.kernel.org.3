Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4ED74793E6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 19:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240302AbhLQSTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 13:19:13 -0500
Received: from mail-bn8nam11on2050.outbound.protection.outlook.com ([40.107.236.50]:1793
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240293AbhLQSTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 13:19:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YgKHRzefBTo/c1eNWySEjGwn+c6645c6NvnYhUzUbz0TUWJfOtm13dhcMb1CrBm5dRyDiRQbvl4PAoimOi651Wpow8fXyfmRhSh+LSYeXBculwI92HNEoF4ACd1OYlF9eu1FKs3iLUr1d5jkA0ZTbQRgiMyoSi2uZxQ2md3jM+0IlLgKpwszlsAO3mYiKdGfdMmjJ6N+ElAyFfMEoDrcympxwUMOchSNVvzZYlvFKpdHKw3ulKikXdzUbNjRFDyzjFs4iNywCCqba5gg91CAITK0Y7N2x0fDuW85y4llgcwvZbCsYhkmcLea8iPw/gG0/tII0s7bWwwC2IUdNETy7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aN0JC3+QBlVM2OpFjCMq8xr7AhIA+zCeinEbBQGYTEQ=;
 b=eS17Wnj+x57FwewI/E/YPBEFA6Ze4DUTBIszg3ZaVbeUJJPUTxX55wiR8+LndpZyj+rbZnvCLLiEWuC1kB+WYdn/PozwBWZP2GkIEfjvmBM99NrNTeEapgxDA5kkOwlrrunft+BXZlToHNi4OKCsJNdpWLiwgsX7H5M3UbpqTtxNHJ4nQFal4UcUeQhTPnkmgnikjc6p+D0Nw+TEA0IFubjHgHw1/03T/Ms8CJ2jRTJI+FDp5NS2tq14z3SsIVqkBmLlz24EbhrYw02NtcdLusaWtMnodwMZRCDKfUrazBsr8YDklrMEhYzeR9CvdBgZ0yZfW21qHcBRFTO6bjouxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aN0JC3+QBlVM2OpFjCMq8xr7AhIA+zCeinEbBQGYTEQ=;
 b=ZahNI0OCw0K9sZMYi7gmYoEjo63gB7jyLVLmvCDUvXaq8hksKAyTxInxNVJVM8/Ot2npoAwEqg5HkCaM3IZMvOCr7DKpTLBfQz9xU2SSS3LC8r4JZjjynhUUay8BATTHC3Pkkf/wJ/6lTYaMOrLmQrMt7VnGzBTX3z3qZ8f9dFg=
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN6PR12MB2830.namprd12.prod.outlook.com (2603:10b6:805:e0::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Fri, 17 Dec
 2021 18:19:05 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::9481:9017:a6a:3028]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::9481:9017:a6a:3028%8]) with mapi id 15.20.4801.017; Fri, 17 Dec 2021
 18:19:05 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Pandey, Ajit Kumar" <AjitKumar.Pandey@amd.com>
CC:     Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Hiregoudar, Basavaraj" <Basavaraj.Hiregoudar@amd.com>,
        "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 2/5] drivers: acpi: acpi_apd: Remove unused device
 property "is-rv"
Thread-Topic: [PATCH v5 2/5] drivers: acpi: acpi_apd: Remove unused device
 property "is-rv"
Thread-Index: AQHX74MM9UZMP9BzJ0qEranaOZs72Kw3ArWAgAAC9gA=
Date:   Fri, 17 Dec 2021 18:19:04 +0000
Message-ID: <SA0PR12MB45101C5839BC373C083B19FEE2789@SA0PR12MB4510.namprd12.prod.outlook.com>
References: <20211212180527.1641362-1-AjitKumar.Pandey@amd.com>
 <20211212180527.1641362-3-AjitKumar.Pandey@amd.com>
 <CAJZ5v0i=LVsz2ZRBB5HzLpw8eR-zLAKtJyc3PFWu_kKCzjzZWw@mail.gmail.com>
In-Reply-To: <CAJZ5v0i=LVsz2ZRBB5HzLpw8eR-zLAKtJyc3PFWu_kKCzjzZWw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-17T18:18:03Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=e0666c2b-1fc9-44d6-8591-7b875c450456;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-17T18:19:03Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: cc59f7c1-cb89-4956-bd68-a37ad6e0e595
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23c3d58e-2ed1-467f-b4b3-08d9c189b59a
x-ms-traffictypediagnostic: SN6PR12MB2830:EE_
x-microsoft-antispam-prvs: <SN6PR12MB28307B1B188B73666CD022B8E2789@SN6PR12MB2830.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4A0q6VaP996BYgJYILiFhgV+zunyAUOlXvOWQJjlnjMRpQOGLTAfoTFodvV4QoicK1XiIPtrWw3DZ6fBo/kuLtxWmuVJoGkdZMXiSRPCe3FxsbxvZ1hHXmD4wxaCKb+aTEkCotYwbc2YioWQnVkLqgl0h8m79c7ykVTlEX9ed8dLe8yq/qtnMNaAgXGByBp7ImeDUGGR+zubiefUy7BE5O+Tg2J5LwMa0UXKkvDHiBYPzztwZuiPL9K2VR0fTqMkAfhOzl7TbxQ0uRRJscv6w3v5yHXdpjgw4d8SfUXXTg4indEIh0/95eqiRcikPYR7cG4KHYF0srUAFQSzDb1P2GqkZIkwVIE/FFmOUal+a/T6QxwCgbkmh/L4W7A5bZhGzFqEGp8ZA6vxysq147esLNP+UxeWKxgj5x66IC3WlTEI2B0/oOYct/Eq93kWvdsWsO16t3Vt6Pvq1GYt9NevDd6rIvWfQ0g3n7KMl26xOtsHZOvm3Ocbewsum1qNkm2HKvbxbbn4TG2Ck4h2esO5fzddo088B4w/ur8hwMBaGPmx/lsYIVT5B4u103+zXSQz0PgMNgZiJO+nD0tNSS6x0oTQK/61i162f+4LhYHztFPenY7OGyteYwjERnihzDG3IfkNoM+BG431zd2uF6gpjUI6ci0mkeqUlinWKGm6XtWyT45LApV7Dse5t3qlLHqrjzqy5mjoAXx2WZoE8k9S1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(52536014)(86362001)(316002)(110136005)(38070700005)(38100700002)(55016003)(83380400001)(122000001)(2906002)(186003)(33656002)(8936002)(9686003)(7696005)(508600001)(8676002)(66446008)(64756008)(76116006)(4326008)(5660300002)(66556008)(6636002)(66476007)(66946007)(71200400001)(53546011)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajQ5NEpGY25DRnFxajBxMHJ4TE1weDQyZ0hhdGw1SVh2ZktaNVE3czlaVnVn?=
 =?utf-8?B?Y3ZKTG5mdFJuTXh6Rm0wUlp5blJKNk9NbGM1SzBvS2c0Z3hWMFNpc295ZXdW?=
 =?utf-8?B?RU5FcVdpTlBjOS8rSHpmZlZWRnNJVld4bWlmb0haeC9VT0JZUFFnTlJMYXBK?=
 =?utf-8?B?OWJtemVZL3lRemdWbHRVY05ZNUhaVW1vaU42R0pHdEtNZlNkTHZmYkNBM0sz?=
 =?utf-8?B?V0F1QTdXZkpPOUFyZ05RSmxpc1Z6UC82SzNONWUyaUNKZngxT2JjQWZmWVpl?=
 =?utf-8?B?RHNXZG81Mmg5ZVNUaEwwQkQzZFg3ZllUTUxXS2FoQTBHR0JCK3pUSzdPdTBE?=
 =?utf-8?B?RjFESEtKZ25JNHQ0bS9xTjUxTVlldUEvamZva2M0ZlhaN2krb2JUamhqRDdC?=
 =?utf-8?B?RWJCbmNDZ2l1RlJ1WUpyYktaTzFUdlVacnhLY3IxaGRoQzFmdm5lUTAxdzIw?=
 =?utf-8?B?WmUyQ082WUJPQkFPNUpzYTQrTDRDUHFIWk9aU1BuWWhGVG85Q3BwQWpFTUQ2?=
 =?utf-8?B?RHZqZG5WNy9YdVZUTmh4d2l5Y1BrNjAvRjBRM05RRnN4RW9kd2ZrVGRJRW9Y?=
 =?utf-8?B?VExzaTZTM1czdnJLQUpBdlVGV1Bta0srbjhUSEFidE0yWll3aHJqZ29lMXNl?=
 =?utf-8?B?NnpIYWVqTzd1ZU9EWnFRSy9yY3BFZWt1OUJLdDdUSTBLYURLKzQyMFVvWTA0?=
 =?utf-8?B?NW9GbXJhU2pjdTRGNVJnMmcrTEhCdkcyWWNjc3dFL0o2ODY3REZ0a0ZlTGtt?=
 =?utf-8?B?ckhBOWx1TjF5am9Zb2xmVHdCOTFSRDljZWJxT21GZlRHOFpTS21HR2dMUDk0?=
 =?utf-8?B?VkVzNGNYY0NjcnRXd1NDNWViWWF4S0ZPSmlVZExNSHZ1RzlNTlNEOFppMHQ0?=
 =?utf-8?B?eUxPbGk2c04vYUZCYXBrQ3BkeGNNRjNlWmRyOFRxVzNZOWkzUnJMcGlIVDl4?=
 =?utf-8?B?SXJUOEFCQWhwR09Vd0xPdDN5dFNQQ1RBV1UwYnZnb3N3ZCtOb3E0SzROa0N2?=
 =?utf-8?B?Z0NsTUtTTnE2dS9HZHJXa2NaZERFZ1VzOHlrdVZuaHQvWjBjOGZTM09mN01u?=
 =?utf-8?B?VldFekJOMitSMktMRmxiZHlReEwya09tdU10UVpNV2gyMUZscVF1bk5RRzhP?=
 =?utf-8?B?RXJaR29OTVJhaFlOc2lod3MzY1JWTHlOUkg3SXpsMmxjWUhPcVBqTzEzZzU1?=
 =?utf-8?B?QzcwaHRFUHE3eGs0UjZyQVBTZlZQSmJobEtwcmVlemRpTzhwUHNlbEZhVXg4?=
 =?utf-8?B?emRqeEVMS1FLUzVrN0tmd0JNN202TFpQV0JaeGgvMkhlTmtJTjB3bTN3Q09P?=
 =?utf-8?B?akd2bkJQbWRTQ3BIcmF0VEJQTVVRREJJWXdOeWt6SkRSVzVQTnNseUcyblRv?=
 =?utf-8?B?NStEMDdBRE5hSnhHZDVIS0xDWUx1T3pycGc4UFBLMGxWbTd5b2syWERXTlBy?=
 =?utf-8?B?Z3h3NC9JZlh1cjFQZXR2cnRCVTZHTmRwQzRrM1gzUFVTVmtuV3FCbEM1RTYx?=
 =?utf-8?B?UVl5WnVUSnBETHRJdktSMWYxQjczQVRodnljTEFvSFVxLzR0R2g1MDdzclJj?=
 =?utf-8?B?UGJxWHRLV2dxMzlDUTBuN1NsK1FYTmNzaFIydmVvb24vSDV5OUFGVEI4N1hG?=
 =?utf-8?B?UmdrUWlSRmpHOHlCRmFJZmNWN3FsOUZ2QkFtZkNCS2p6TlYyZjV2UkRVekxD?=
 =?utf-8?B?K2NxNnlWeHY1RFJmb3VJODUwVXBxUkFHUGcvWjBpMEdSWE1ReUVpSUlBUVdQ?=
 =?utf-8?B?MHUzSk40QzgrTmt0aFVzNVdtSTIwa1N2KzZCOXVLWDZ3YVNacW9HSkZhUHZV?=
 =?utf-8?B?RmpDd25EZHFhUmg5bGdwSGZTL0ZnTkVBVG1ZVTVER1VibFlnbFcrSTJxakVL?=
 =?utf-8?B?cGtTWnpjU2FPK2IvY2dFekRvWncxczQvOFAyQ3NnYVl3RnM1VUdzMmpuZy93?=
 =?utf-8?B?S3I4SnkxS21ORVhFSXFPQmVtWFR5SE9xUE0zTzNaTUJ4UHhjMHlyU09Zd1Qr?=
 =?utf-8?B?bDJYcUUra1pRbUIzd1dJWVlkWkF4b2cwc2pkWTd1SGFHQzhxMmJEcVVQMVl3?=
 =?utf-8?B?b1Nyb1lvS3d0SnFRbFVLRjI3UWxzZnlUbHhvY01IUWRNV2FadmZ4eHBhSHJW?=
 =?utf-8?B?dzJXR29wS1Y5YncvWUhHZDNkUGVtWUh4QUNYNnpaWk9pM2duN0hHMzZWQWxD?=
 =?utf-8?B?WUxzNm5vTFo5MzJ4QUY2bU1UNkVWdGlIZStxdHVKN1lVMlBrbkxOZG9OdXBR?=
 =?utf-8?B?c1VMc2V6aEphY05JbzVMU2p1TWNRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c3d58e-2ed1-467f-b4b3-08d9c189b59a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 18:19:04.9388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dooxoXTwKwL8gCkkiokzZXeJBOEa8m/QjRh58hK/ALUn+HOnvaI2d06kI8RwPHxrUB55P1RbWdXYZSNKO0RlFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2830
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYWZhZWwg
Si4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgRGVjZW1iZXIg
MTcsIDIwMjEgMTI6MDcNCj4gVG86IFBhbmRleSwgQWppdCBLdW1hciA8QWppdEt1bWFyLlBhbmRl
eUBhbWQuY29tPg0KPiBDYzogU3RlcGhlbiBCb3lkIDxzYm95ZEBrZXJuZWwub3JnPjsgbGludXgt
Y2xrIDxsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnPjsNCj4gTXVrdW5kYSwgVmlqZW5kYXIgPFZp
amVuZGFyLk11a3VuZGFAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVy
LkRldWNoZXJAYW1kLmNvbT47IEhpcmVnb3VkYXIsIEJhc2F2YXJhag0KPiA8QmFzYXZhcmFqLkhp
cmVnb3VkYXJAYW1kLmNvbT47IERvbW1hdGksIFN1bmlsLWt1bWFyIDxTdW5pbC0NCj4ga3VtYXIu
RG9tbWF0aUBhbWQuY29tPjsgTGltb25jaWVsbG8sIE1hcmlvDQo+IDxNYXJpby5MaW1vbmNpZWxs
b0BhbWQuY29tPjsgUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPjsgTGVuDQo+
IEJyb3duIDxsZW5iQGtlcm5lbC5vcmc+OyBvcGVuIGxpc3Q6QUNQSSA8bGludXgtYWNwaUB2Z2Vy
Lmtlcm5lbC5vcmc+OyBvcGVuDQo+IGxpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMi81XSBkcml2ZXJzOiBhY3BpOiBhY3BpX2FwZDog
UmVtb3ZlIHVudXNlZCBkZXZpY2UNCj4gcHJvcGVydHkgImlzLXJ2Ig0KPiANCj4gT24gU3VuLCBE
ZWMgMTIsIDIwMjEgYXQgNzowNiBQTSBBaml0IEt1bWFyIFBhbmRleQ0KPiA8QWppdEt1bWFyLlBh
bmRleUBhbWQuY29tPiB3cm90ZToNCj4gPg0KPiA+IEluaXRpYWxseSAiaXMtcnYiIGRldmljZSBw
cm9wZXJ0eSBpcyBhZGRlZCBmb3IgNDhNSHogZml4ZWQgY2xvY2sNCj4gPiBzdXBwb3J0IG9uIFJh
dmVuIG9yIFJWIGFyY2hpdGVjdHVyZS4gSXQncyB1bnVzZWQgbm93IGFzIHdlIG1vdmVkDQo+ID4g
dG8gcGNpIGRldmljZV9pZCBiYXNlZCBzZWxlY3Rpb24gdG8gZXh0ZW5kIHN1Y2ggc3VwcG9ydCBv
biBvdGhlcg0KPiA+IGFyY2hpdGVjdHVyZXMuIFRoaXMgY2hhbmdlIHJlbW92ZWQgdW51c2VkIGNv
ZGUgZnJvbSBhY3BpIGRyaXZlci4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFqaXQgS3VtYXIg
UGFuZGV5IDxBaml0S3VtYXIuUGFuZGV5QGFtZC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IE1hcmlv
IExpbW9uY2llbGxvIDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPg0KPiANCj4gRG9lcyB0aGlz
IG9yIHRoZSBuZXh0IHBhdGNoIGRlcGVuZCBvbiB0aGUgcmVzdCBvZiB0aGUgc2VyaWVzLCBvciBj
YW4gSQ0KPiBzaW1wbHkgYXBwbHkgdGhlbSBib3RoPw0KDQpUaGVyZSBhcmUgKGludGVudGlvbmFs
KSBkZXBlbmRlbmNpZXMgd2l0aGluIHRoaXMgc2VyaWVzIG9uIHRoZSBvcmRlci4gIEl0DQp3b3Vs
ZCBiZSBiZXR0ZXIgZm9yIHRoZSB3aG9sZSBzZXJpZXMgdG8gY29tZSB0aHJvdWdoIG9uZSB0cmVl
Lg0KDQo+IA0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2FjcGkvYWNwaV9hcGQuYyAgICAgICAgICAg
ICAgIHwgMyAtLS0NCj4gPiAgaW5jbHVkZS9saW51eC9wbGF0Zm9ybV9kYXRhL2Nsay1mY2guaCB8
IDEgLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9hY3BpL2FjcGlfYXBkLmMgYi9kcml2ZXJzL2FjcGkvYWNwaV9hcGQu
Yw0KPiA+IGluZGV4IDZlMDI0NDhkMTVkOS4uNjkxM2U5NzEyODUyIDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvYWNwaS9hY3BpX2FwZC5jDQo+ID4gKysrIGIvZHJpdmVycy9hY3BpL2FjcGlfYXBk
LmMNCj4gPiBAQCAtODcsOSArODcsNiBAQCBzdGF0aWMgaW50IGZjaF9taXNjX3NldHVwKHN0cnVj
dCBhcGRfcHJpdmF0ZV9kYXRhDQo+ICpwZGF0YSkNCj4gPiAgICAgICAgIGlmIChyZXQgPCAwKQ0K
PiA+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT0VOVDsNCj4gPg0KPiA+IC0gICAgICAgaWYg
KCFhY3BpX2Rldl9nZXRfcHJvcGVydHkoYWRldiwgImlzLXJ2IiwgQUNQSV9UWVBFX0lOVEVHRVIs
ICZvYmopKQ0KPiA+IC0gICAgICAgICAgICAgICBjbGtfZGF0YS0+aXNfcnYgPSBvYmotPmludGVn
ZXIudmFsdWU7DQo+ID4gLQ0KPiA+ICAgICAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeShyZW50cnks
ICZyZXNvdXJjZV9saXN0LCBub2RlKSB7DQo+ID4gICAgICAgICAgICAgICAgIGNsa19kYXRhLT5i
YXNlID0gZGV2bV9pb3JlbWFwKCZhZGV2LT5kZXYsIHJlbnRyeS0+cmVzLT5zdGFydCwNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVzb3VyY2Vfc2l6
ZShyZW50cnktPnJlcykpOw0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3BsYXRmb3Jt
X2RhdGEvY2xrLWZjaC5oDQo+IGIvaW5jbHVkZS9saW51eC9wbGF0Zm9ybV9kYXRhL2Nsay1mY2gu
aA0KPiA+IGluZGV4IGI5ZjY4MjQ1OWYwOC4uODUwY2E3NzYxNTZkIDEwMDY0NA0KPiA+IC0tLSBh
L2luY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9jbGstZmNoLmgNCj4gPiArKysgYi9pbmNsdWRl
L2xpbnV4L3BsYXRmb3JtX2RhdGEvY2xrLWZjaC5oDQo+ID4gQEAgLTEyLDcgKzEyLDYgQEANCj4g
Pg0KPiA+ICBzdHJ1Y3QgZmNoX2Nsa19kYXRhIHsNCj4gPiAgICAgICAgIHZvaWQgX19pb21lbSAq
YmFzZTsNCj4gPiAtICAgICAgIHUzMiBpc19ydjsNCj4gPiAgfTsNCj4gPg0KPiA+ICAjZW5kaWYg
LyogX19DTEtfRkNIX0ggKi8NCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiA+DQo=
