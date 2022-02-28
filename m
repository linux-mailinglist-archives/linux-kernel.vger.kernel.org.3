Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315804C6187
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 04:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbiB1DJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 22:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiB1DJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 22:09:17 -0500
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75763D1DC;
        Sun, 27 Feb 2022 19:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1646017719; x=1646622519;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1Bi+iJUkMkvkIKQwtbWG0W537Xyjf9so1xRU/8T4Wwg=;
  b=Wzy0cYsU/KokWILAEAFVVsQobkuh5Bf9dbUObPAcO416eXgLRPJlZtv0
   c/cck0/hZUIHcwgTnkSnR8TlZhacBroHoXl7femq1x52R2g+psdOpW9VZ
   1CllTSVCXBp6sP0fzQyuXtKju6VeEcbksmNr+o55/S0SAGsJO8UobuFKb
   A=;
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 03:08:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrIIniqUbDQzOd4TcD2GteA/QonN0kEhVcUpUL+3S9GFQI+028HECkEbtSgiZ3hihWdWui6VDad2pICJFzPZw7KB9DWQ70xwiB9X6occ7ysLjcoFrujQHvVjIgba36kNFUGIKVKdIdXdPHNr+g61KAzt6m62CVuIkKNvIgVEYtkMoZIhXi/mNezbB1L3uW93u6Xn1WowV3fID6l6Yo9eUMo55n0DrXpJmRB5esiJR800PfIXWKKvYLKd6zcDrhwqOUZq+E7Y1EvDGc/0TZT5aVWwpFLDei7+EhxmDCKQLVYcRxg0HDWFyl3iqtKbR01Ba9SFi9xsfMotdCg38oVlqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Bi+iJUkMkvkIKQwtbWG0W537Xyjf9so1xRU/8T4Wwg=;
 b=Vvn+Wg39UQwHAr93pnYLIkFlMKgU2XF0Iac35nlkDnfJfkdgZsdL+0L/BBYffdVGn9B7yeOu6/wfFIjiWhYvOAzn+fxzRyUQPuNDDWCGfN4vNYJ+4dUi83QhSIG0JV1ilsxTJl0g6+pEie2QJmLrRYs83kFCENlvAVIounoH9zarxAgFfsoFe/Q2WvzfaZtTwUpl6JjsD0WAmRX7MPgN6J6unh0riTBlTR+nMEI2HQCpHmQdefoz0hZ0GMSyL0i1CdZC52wtZBNDA7L7HGlgj287N+qCMfefCRRFWU4PGdtUy0KLgS6Yv0GuYRkpG9j+8RjO30JUdY+q+pfBCH9A3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DM8PR02MB8198.namprd02.prod.outlook.com (2603:10b6:8:4::7) by
 PH0PR02MB7767.namprd02.prod.outlook.com (2603:10b6:510:58::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.22; Mon, 28 Feb 2022 03:08:34 +0000
Received: from DM8PR02MB8198.namprd02.prod.outlook.com
 ([fe80::a02f:fdb9:de98:d75c]) by DM8PR02MB8198.namprd02.prod.outlook.com
 ([fe80::a02f:fdb9:de98:d75c%5]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 03:08:34 +0000
From:   "Linyu Yuan (QUIC)" <quic_linyyuan@quicinc.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Tao Wang (Consultant) (QUIC)" <quic_wat@quicinc.com>
CC:     "mka@chromium.org" <mka@chromium.org>,
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
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "Linyu Yuan (QUIC)" <quic_linyyuan@quicinc.com>
Subject: =?big5?B?UkU6IKZezmA6IKZezmA6IFJlOiBbUEFUQ0ggdjIwIDMvNV0gdXNiOiBtaXNjOiBB?=
 =?big5?B?ZGQgb25ib2FyZF91c2JfaHViIGRyaXZlcg==?=
Thread-Topic: =?big5?B?pl7OYDogpl7OYDogUmU6IFtQQVRDSCB2MjAgMy81XSB1c2I6IG1pc2M6IEFkZCBv?=
 =?big5?B?bmJvYXJkX3VzYl9odWIgZHJpdmVy?=
Thread-Index: Adgm6oYwULNX5ZnjSBCBUX6aFc31LAAADyHwAFiwVAAAH4sXgAAAiy2AAOBepDA=
Date:   Mon, 28 Feb 2022 03:08:34 +0000
Message-ID: <DM8PR02MB81988555CA6B66BB3FD5E488E3019@DM8PR02MB8198.namprd02.prod.outlook.com>
References: <SA1PR02MB86067ACF0C96F18B7306D208903A9@SA1PR02MB8606.namprd02.prod.outlook.com>
 <SA1PR02MB860660B6F33011E5A97F7930903A9@SA1PR02MB8606.namprd02.prod.outlook.com>
 <YhURQAksLKVuzU36@google.com>
 <SA1PR02MB860602E0AC4D9BD0BC4245B5903C9@SA1PR02MB8606.namprd02.prod.outlook.com>
 <YhXolQDwIMbTi/O2@kroah.com>
In-Reply-To: <YhXolQDwIMbTi/O2@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8cf85f5b-85c1-4276-c187-08d9fa679b36
x-ms-traffictypediagnostic: PH0PR02MB7767:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <PH0PR02MB7767CCEBEA84D24CC72D8F289F019@PH0PR02MB7767.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UHW9DiEHhkhrv9d0oY3w6YGX8wljzaSp2r2GHFnBfu640+YFAIYsUA+nxYfNKTPfAakD67ZARHW0nx+OyzODKh6MWhUi/SFAvUygDNe7QzdKG1wtZ6vXtF+oXJtDTooWXECYC7Wd6LsRJbTsTVXluyMVbCk35cguRL5pxKEbLVOkPd5tW2oxwL5K2TkPiB840o3LW5RB/ojnn4css+cjv3rP8PVkLxPGdT2XFrKk6FRixPJKHYLrPpCmx5xzbca/KL2H4pgPNk63TgwEq7wnoqMHnlBU5lLq4MpiNfguOsGRDoP1y/mh4cbbq3ofKsmjUaVsBTpjjyvxeceIndV2vfjQmUxIh9z5ZDJonMX1oDd6AOyY+T8OkDhecRK/LJukT2h6Vf5txm/ZiSRdD+AVvBJl7gjDBfJbfKdWuKcMUtReSpDpmsUKMB39D5yncNJ9qb8hsU3vagyBX3uP9OsIcH8y4PHDIDAlHDV5QvCbcbgFVw0IhNw4WlUXy1vMMb+ge5QK4YzYCrSZAegte6WoKVujM8550nZ3zlRqYm9rY9y79++Rd1gP1pNw+dSe7YWYTDg5OpM5/EpIvcmqFEuzxn8y3W3esm0oPwvU08A4TPjc77aHuhCyIIqWm631GC4SiBYG4HfadnvJAV+PoAEnEJCGoJ9Ia3reOKYsiFocj9dDfGQC5adV3JwlIjZdAYL6lfIi0r/9iVABzFDHpdEiOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB8198.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(508600001)(33656002)(316002)(6636002)(86362001)(122000001)(55016003)(83380400001)(224303003)(54906003)(110136005)(2906002)(71200400001)(26005)(53546011)(38070700005)(7696005)(9686003)(6506007)(186003)(8936002)(76116006)(7416002)(52536014)(66476007)(38100700002)(107886003)(66446008)(4326008)(66556008)(66946007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?big5?B?ck9jQVlmMFhqRXhMVStOUnljb25QaEVhNVo5TklaVmROSGFVWlRXaVdSRjU4WmNN?=
 =?big5?B?eWdCNmRTKyt5QnEvVng1ckRJNlVnNDhmM0JGV0piT1dUajE3WlJyMnozcDZQODdy?=
 =?big5?B?dThrUjl4OW5WZm05b1k1NzhDWXVONzZrTHQzL2JXdlc1WFZRZ2NibEhIWjBXNDZV?=
 =?big5?B?U1ZpMVR1UEtCaWhVRlozdnRPeTZHZDVoMFVqWmhoOVRMS250R2haeUFYc0dxWHNp?=
 =?big5?B?NE9mOS9UZWVYdmdjeDBobWIzRHg5VEUyWHlteHhKL1QrTUp4Mmd5WDVlZFBTeE9R?=
 =?big5?B?b2Jqc2l4WlhZL0lsNnNYY09zbFVPSStWaXNsVlljQ0FWZWFzeXZmK3BQekJ5UUdw?=
 =?big5?B?czB3cWRTL0JDYkJJRi8zMWZqUjFGVFhTSFJ6Z0lTdDFsYXJnZ2tZYTIyaERGRjdS?=
 =?big5?B?SmF1T2JVbzAzNFpJSVVXaFBiWVJ5S3dRRTUvWCtsTGc1S041Q2pyZlV1MWFvdFlP?=
 =?big5?B?cmdQcGdjaGhUNmtYMnk0ZUo5MHNWQXJXSHVWRG94K2FDbjVBMGVtWFlLb3NvMHU4?=
 =?big5?B?K0twUDFlcjJINGY2bEk4WTJQYXNOd25iRytIbVhnTllETUpkNmFqeUI3RGxBYUpy?=
 =?big5?B?S1dkUG5RS2d2bFFzWEZHczJyN3IvaEJ4Vm85dDhFcGd3ZVhHQ01ERlZDV3EreVVZ?=
 =?big5?B?K29SSS94eG1HQ1FYS0ZNNXJteE9ITzhBWVEzam5nUUx6VHAzQ0cwc3NQcXZQWGZO?=
 =?big5?B?bVVqRHBqdjFXbmNxSGwvZVNYOGpwaUxEMmRPayt1NFFqdjMvUitYN0NuaFVnWU1J?=
 =?big5?B?UmdNQkthZmZNQ3pLOGc1UElhZmVHRjNBeDBjVVJvQ2NvVjFaN1RFcmgwSk9Scjlr?=
 =?big5?B?Sjl3OXJzOFJFQ1gySStUT21za2xYSmVpbkN1ZVh4SW9hREJueUh2bFBKSzJtVnl6?=
 =?big5?B?clhUZWdyZ3RJN3ZOZ3BERm9GUThVS1ROTFFHVHpMRjJENFpEUmovVm1nb25IWFZV?=
 =?big5?B?eDBrTW80dnd2VHIveE9jM245NUpIcTVqb3c4Y09GTUc0SnVIUFB0aUQxbk9vSjM2?=
 =?big5?B?TWpDTTBlbXdFU1FaSk5VUUUvRXVxckU3Y3M0aHJZanVUKzdncUtPZ0c1THhtbzRu?=
 =?big5?B?enVwK1NPUFR4Um9zbXpBV21LQUFkWE5YRzRJTEpqaWdKSURUdHZtcC9mUFl5alJM?=
 =?big5?B?M0hwTzE1b3RydWFKVDd2bm1xSUxId1Jhc2diUUdaRS9MUzcxUXRJN0YvYjk4YWkw?=
 =?big5?B?Tjk0NTRlVFpvbXlReU9ibWh5NlJodTlJUVU0QVJrdmZYSTJUM1FINDZwVlkySnla?=
 =?big5?B?eHFaWmx5V3FWMlFhNHpYU3dnRGZHWU1hYW5VNFBYKy9QQXErdUZuN293cnpubTly?=
 =?big5?B?NVZtYk1reDljLzJwWFFSVzBUNXBxS2RjaTVscGphNnpub0FvOUc0VkxoZS91aVYz?=
 =?big5?B?TlhnYk14RzRQdG42QjlFUlZRR1NlRzFWbXFwYUlxelI3UnFiSUtid2MzRzlUeVpE?=
 =?big5?B?NnQ0cFFxek1yOEc1b2pNbmRzd3VBWGFkS3dkYTdUS2FxejVqQmF2Q0tOdUE0RlB2?=
 =?big5?B?VC9KeTlIVkwwdWZPYTZWWXN3aGY2eDdvZTJqbXc1R2IvZTd4VGNlVHdEZC9rTGEx?=
 =?big5?B?bUJ4TThYc1JzTFJmbkR4eDBxTjdNSUVxR1lkSDVzR0pmd1dKdVUzb2pvazRpbkNW?=
 =?big5?B?T1hmSTlYMkVBWWhMSjk2Y1U4ZURHdnFrcFQ4T3lxK2VPT1NkdjQyN1RncDRJK1Jm?=
 =?big5?B?akZYc2pTOVZZZytoR2pldmRmeWo3S2p6dmVRRmZhVUxBNHNGTitzTlVFRmJTYUxH?=
 =?big5?B?S094eUFVYjJhZkpyTVBudXBsbDVzMWxrcmU4MGNuWUp3dzIybHJXRTNySTVYK054?=
 =?big5?B?cWpxN3RKejZQS0RwMmFsZ3hqd2NiMW1pem41RXAydVZjZ0FLS2lpQUVSWUlnQUVT?=
 =?big5?B?b09rK0FYNXpwcWxBbzBzdURSOElSNXRaOURRZjl2WVZsc3hDMHFMcGpJTjZHakVa?=
 =?big5?B?dTlBTVBwelpBQXV2d3NYd3cxMWJxYm92NDR3OEtaempBczdGTklyQmVPMTErY05m?=
 =?big5?B?bFI2S2ZSY2dlcjlTSHd3RUZRTExreGV0T0NjSGJKTWcxUEhJbXh4UDBjZGhLa29Z?=
 =?big5?B?WVVlTFZkQitySjVXMVJkYlJyeDlBSUxueURjSjRyYk51OWdEY1NtQWo0dEdkVTJ2?=
 =?big5?B?ci9NNG1nPT0=?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8198.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf85f5b-85c1-4276-c187-08d9fa679b36
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 03:08:34.1174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bWKrEGR6so0MpgLw+exL2EAxJTQLIC/lV1e2rWgb4h6l5NAVTyP9sRepvMs4O85fsw72g1k8g1l5+nnO58Sl3R5+7o+Fxrcz4FRSllO5wnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7767
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZyA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgRmVicnVhcnkgMjMsIDIwMjIgMzo1NiBQTQ0KPiBU
bzogVGFvIFdhbmcgKENvbnN1bHRhbnQpIChRVUlDKSA8cXVpY193YXRAcXVpY2luYy5jb20+DQo+
IENjOiBta2FAY2hyb21pdW0ub3JnOyBiYWxiaUBrZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIu
a2VybmVsLm9yZzsNCj4gZGlhbmRlcnNAY2hyb21pdW0ub3JnOyBmcm93YW5kLmxpc3RAZ21haWwu
Y29tOyBoYWRlc3NAaGFkZXNzLm5ldDsNCj4ga3J6a0BrZXJuZWwub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnOw0KPiBtYXRoaWFzLm55
bWFuQGludGVsLmNvbTsgbWljaGFsLnNpbWVrQHhpbGlueC5jb207DQo+IHBldGVyLmNoZW5Aa2Vy
bmVsLm9yZzsgcmF2aXNhZGluZW5pQGNocm9taXVtLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOw0K
PiByb2dlcnFAa2VybmVsLm9yZzsgc3Rlcm5Acm93bGFuZC5oYXJ2YXJkLmVkdTsgc3dib3lkQGNo
cm9taXVtLm9yZzsNCj4gTGlueXUgWXVhbiAoUVVJQykgPHF1aWNfbGlueXl1YW5AcXVpY2luYy5j
b20+DQo+IFN1YmplY3Q6IFJlOiCmXs5gOiCmXs5gOiBSZTogW1BBVENIIHYyMCAzLzVdIHVzYjog
bWlzYzogQWRkDQo+IG9uYm9hcmRfdXNiX2h1YiBkcml2ZXINCj4gDQo+IE9uIFdlZCwgRmViIDIz
LCAyMDIyIGF0IDA3OjQwOjMxQU0gKzAwMDAsIFRhbyBXYW5nIChDb25zdWx0YW50KSAoUVVJQykN
Cj4gd3JvdGU6DQo+ID4gT2ssIHRoYW5rcyB5b3VyIHJlcGx5Lg0KPiA+DQo+ID4gSGVyZSBpcyBt
eSBxdWVzdGlvbiwgd2UgbXVzdCBtb2RpZnkgdGhlIGRyaXZlciAib25ib2FyZF91c2JfaHViLmMi
IGlmDQo+IHdlIHdhbnQgdG8gdXNlIGl0LiBCdXQgaXQncyBoYXJkIHRvIGNvbXBsZXRlIGJlY2F1
c2UgaXQncyBhbiBvcGVuc291cmNlIGNvZGUuDQo+IA0KPiBJIGRvIG5vdCB1bmRlcnN0YW5kLiAg
V2UgZG8gbm90IGRlYWwgd2l0aCBjb2RlIHRoYXQgaXMgbm90IGluIHRoZSBrZXJuZWwNCj4gc291
cmNlIHRyZWUsIGFzIHdlIGhhdmUgbm8gaWRlYSB3aGF0IGlzIG91dCB0aGVyZS4gIFBsZWFzZSBq
dXN0IHN1Ym1pdA0KPiB5b3VyIGNoYW5nZXMgdG8gYmUgbWVyZ2VkIGludG8gdGhlIHRyZWUgYW5k
IGFsbCB3aWxsIGJlIGZpbmUuDQoNCkhpIEdyZWcgYW5kIG1rYSwNCg0KTGV0J3MgbWFrZSBpdCBj
bGVhciB0aGF0IHdlIGFyZSB0YWxraW5nIGFib3V0IG9uY2UgdGhpcyBkcml2ZXIgaXMgYXBwcm92
ZWQgaW50byB1c2IgdHJlZSwNCklmIHdlIHVzZSBkaWZmZXJlbnQgVVNCIEhVQiB3aGljaCBoYXZl
IFZJRC9QSUQgbm90IGRlZmluZWQgaW4gdGhpcyBkcml2ZXIsDQpXZSBuZWVkIHRvIHVwZGF0ZSB0
aGlzIGRyaXZlci4NCg0KQnV0IGlmIHdlIGRlZmluZWQgVklEL1BJRCBpbiBkZXZpY2UgdHJlZShm
b3IgYSBzcGVjaWZpYyBib2FyZCwgbWFudWZhY3R1cmUgc2hvdWxkIGtub3cgVklEL1BJRCBmcm9t
IEhVQiBpdCB1c2VkKSwNCmR5bmFtaWMgcGFyc2VkIGJ5IHRoZSBkcml2ZXIsICB0aGVuIHdlIGRv
bid0IG5lZWQgdG8gY2hhbmdlIHRoaXMgZHJpdmVyIChpbmNyZWFzZSBWSUQvUElEIHRhYmxlKS4N
Cg0KPiANCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgNCg==
