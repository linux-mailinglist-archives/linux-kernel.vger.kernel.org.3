Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D814ED829
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 13:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbiCaLGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 07:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiCaLGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 07:06:52 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C1916D8ED;
        Thu, 31 Mar 2022 04:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qccesdkim1; t=1648724703; x=1649329503;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EWk3gmA36vZCvdZkjg85nWF1JEvlSYqL13ci7vEZIXQ=;
  b=ziuoumhZDl8niYsOMZkRa4PFZFtvQODIiSh1z+b229oi7mppCxyVxdgA
   SMq6a5iF3+OTtmhFfqB1WYWCoQZVu7tt1g/Sbi15nBmaNQt+6GtzN8gq+
   i/JXeYo4xKbzSrvUq8ULV/eKVHyypvDKZFMUcB5M18opJjs3avxl/3VzT
   c=;
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 11:05:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpODg5KkAP80e2CffUQe4VjoPApfqRrqoHo6HIrjwUh2SxVksgn+1xeSr2AvrTZsH1SfaEm946AgEDXZV2x6tbGjCvftzjMEpQ33iUIu3xd6bIjA0/JA0MutB0+5Pt+anUtljmRfcfTWR4nljCCyMhJtzvTNWFHTBIPziOgXAuXbI+gB7ANDfvNEcfvvvGyMo4vgYIb2mpneB57vSoOtjfCpaqT06r88odHzQ3hctqt9aIY90LRina9N3nLRekAgJAf7QDzvMSOmkX8KTHrOPiwdVQy20eIwufCvfPFM5vtyhe0w0bmQortCAIMm1M0xzYxCluMazycHmVy1V+W74A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWk3gmA36vZCvdZkjg85nWF1JEvlSYqL13ci7vEZIXQ=;
 b=bfk0Mc+X+Ma+UVFykl16MkZt/idD+NtSfhiZccnT67Ys19BYxltUbVq+3+32DPbhH00LRMT4TWp2iyiSGVjzHHGxBauFXXKrMK6fYxAaxlBcDrEpQGiUoDymsyOCAzdyLqY3C4dao9F4P7trn6Vv+QWlF1lT/7KzeSDn2/MOGluYlgPbIkA+GSFoP29aXTm43yNWxCmnp2hY3ZkBNibRjIA3y+/Y+8eZoMXRJART68TSj6rYwOvaUJvVKp4b6PTyZgRGL2UwKvXKcXLC8bf4pYUu5zeib6f18pGEWbzATkNHlC+PqfZ18agw10KBsBGfjP4AMtSMvW9zjsQKoxQWRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from MW4PR02MB7186.namprd02.prod.outlook.com (2603:10b6:303:73::6)
 by BY5PR02MB6488.namprd02.prod.outlook.com (2603:10b6:a03:1de::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Thu, 31 Mar
 2022 11:04:59 +0000
Received: from MW4PR02MB7186.namprd02.prod.outlook.com
 ([fe80::9485:c59c:6877:f492]) by MW4PR02MB7186.namprd02.prod.outlook.com
 ([fe80::9485:c59c:6877:f492%6]) with mapi id 15.20.5123.023; Thu, 31 Mar 2022
 11:04:59 +0000
From:   Sankeerth Billakanti <sbillaka@qti.qualcomm.com>
To:     "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "Sankeerth Billakanti (QUIC)" <quic_sbillaka@quicinc.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        quic_vproddut <quic_vproddut@quicinc.com>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>
Subject: RE: [PATCH v6 4/8] drm/msm/dp: avoid handling masked interrupts
Thread-Topic: [PATCH v6 4/8] drm/msm/dp: avoid handling masked interrupts
Thread-Index: AQHYRE/EvdWk4OgVD0y7uP1mIx6Fl6zYfvSAgAB/n3CAAEfjgIAAB3ug
Date:   Thu, 31 Mar 2022 11:04:59 +0000
Message-ID: <MW4PR02MB71864413E9E3624D2F48F046E1E19@MW4PR02MB7186.namprd02.prod.outlook.com>
References: <1648656179-10347-1-git-send-email-quic_sbillaka@quicinc.com>
 <1648656179-10347-5-git-send-email-quic_sbillaka@quicinc.com>
 <CAA8EJprMvik_6xmGt2oZGpDG9FoMtC_ojuw+oTjPLTck4Hu3WA@mail.gmail.com>
 <MW4PR02MB7186669BA1B19FA4F184B558E1E19@MW4PR02MB7186.namprd02.prod.outlook.com>
 <d9ac1cee-d4fc-09ae-b2df-82ae2ecd57fb@linaro.org>
In-Reply-To: <d9ac1cee-d4fc-09ae-b2df-82ae2ecd57fb@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qti.qualcomm.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d8aeca7-1676-41ae-c323-08da13064c3c
x-ms-traffictypediagnostic: BY5PR02MB6488:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <BY5PR02MB6488BCE060B67A5D649A66DDE1E19@BY5PR02MB6488.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bwAJt9qOYZNUy26T9ZFz9B1XjUnXNR08U2Spa1angTkxropgjlNUg42lI4bq0i7Ytte4+bTrf6OqekNA9ts7LdgGqgGW1fDR/saOlTYtP0Gq1GLkLMtmcru+ha6d2qc/0LmZMihNC7yjgxP2F/FyLu20YNhZfGNm72y4TYZHvrQEv6DGHpi3W54LvXuYow0mAQ0lw6OqOYpsHg/k9G6mROiWJqw+yOA9fjl6pUyCaSCRLsSp3sMlYOG3Ferfyqay/hHaILf8jpy0agALLWhCuKV7Ow9iUTs9Q/O8TqTE5qeAMj0kxev3/sH/nVi1pkqxBeh//U3u78AAaIJgZv0eJrLaQ+PaZF2R53FMw0AsPLhVuXEBMZRBPxrROxC0xSyzNKe164sQS0rKJ49JFcbmzmAe1rXIkdXEHVdskj3ogNkXEOKh/zQTY9ILlUTB3Sfb8jm1J0jRBrbRwiTYe6wfpiGTQbZY7qsw9i7JYLf61nswRBj8ogqBk2es4driwSMyqdRihXgfl3t/ZUI6XLEiCoPB0zlD23j4cbx4qHKR38EAvJOa3sgRfuJsEtxH85vw3yQUU/4AezVZho2+n5dadxpm6QcjJGK3xtFFyRb/Y3AVpSmvCgHlXce80z80LtrfOLaQgzs4XOWdf0U7q27ZSZps6C+qJ9VCVnIUHXY6fz953A2TcIEMdUWOXMkcWReQWQ883XULAqP9OVdoANsVpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR02MB7186.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(38100700002)(64756008)(54906003)(55016003)(83380400001)(66446008)(4326008)(5660300002)(86362001)(38070700005)(52536014)(316002)(66556008)(66476007)(76116006)(66946007)(71200400001)(122000001)(2906002)(7416002)(107886003)(53546011)(8936002)(186003)(508600001)(6506007)(9686003)(8676002)(7696005)(33656002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0FrMHowamtseU5aSVU5dUFscEVneHIzRmsyOTFCR1M5bk52bFprVExRUVVT?=
 =?utf-8?B?bE9qdjZ2VDNxbStqbjl1bEJ2V0tUTEF6QkR3TmFhV1V4YUtFbDhlMERtcVU5?=
 =?utf-8?B?ZzFOdTB3ekh2VnZyUndZU1cweXdaMVlZZi9VYkVLRzh6ZzMrMHZrWXc4Wi83?=
 =?utf-8?B?S1V0MEc2SytWVEFVUjFDMjI5a1RRZ3pSQ1hqQllZVHlCSk9VNGtPNXEvRGpU?=
 =?utf-8?B?Uk5zclJxUTg2Mi94dDl3b2tEanp0NVVvL29nbjk2SEVIbFZhbkNSSU12T01z?=
 =?utf-8?B?dE8wdEE3RmJlL1EwOHI2WjdadzQ0YkF0WUJXdWZKUTBpSWE1ZXNmTXYrZFd1?=
 =?utf-8?B?Z0xyblpKamRubDJiWU4vTGd1VUUvdXIxWVpSNnpvaEpVLzlDZDJGQ0FQNzBI?=
 =?utf-8?B?UzFYS1pFclZEd2tLdTBZSDBtZUVTdkpvV3F3QXFrT2ZFQ244VW41YXEvVVRJ?=
 =?utf-8?B?TnhWL3BXT3E3cjlRVmMrb09DZDVCTXRXUU1tYlJtSVI0Qi9xVit6d0JWVmF6?=
 =?utf-8?B?UnRnNE13T2RzdlZrZ0xBeTJiNy9QUkJCaVpuanJUMFQ5TjE0ZkdjcDVmTXlt?=
 =?utf-8?B?WHd1ZTdSZndFeEVlV1l5TFYza1Q2U21SSzNTU2FyVmJjQVJTWmFwQXMvVVRv?=
 =?utf-8?B?V2xmMDFiaE51cCt1SGl2aThUbXp6eWlsaDZ5bGNjRVZKclMrcms4RDJFQTFP?=
 =?utf-8?B?c2FHMFJOMFJlRWxzdTB6YWpjWWw5c2dwU2szdE1IN0RRZ3BrZGswN3RNMEZp?=
 =?utf-8?B?ejlvZnhzV2Z6a1NVcXBGQnZaZnJXT2RzVTMzNnB3Q25lVU5RVW9mS0Y2TzFR?=
 =?utf-8?B?Tmo0Z2NOdTVPdStzN0NvTEZOeUg2UlVRblFaK1JKaUI4c2NXWGg3RHNUM1pN?=
 =?utf-8?B?Y3dWNlkyN1V4amc5RDFzV3FHME1LZ3BaMUlFUmhJbUtoKzJkbWVia3ZLZmln?=
 =?utf-8?B?MXRLMHQ0cXp5S0RidVBBOWNlUFFBZXdmWXJqSWltRGczeFRGOExjQ0YwbGYy?=
 =?utf-8?B?aEdSd29uWVp6Q0MyRkZDNUp6a3VBOXNkVld4UTJybTZqdUdlVzUyckNta2li?=
 =?utf-8?B?cExGMEVDSFg0UjBTODRna2h3bVBQN3dxODg4ZEdSeUhxV0M1VVlzTWVsemN2?=
 =?utf-8?B?ajJPd0lLYTQ1TFVkZGFqbUtPaURZOXd5cGE3ZklZQ0dYMm5uY3lMVDVRNGt0?=
 =?utf-8?B?SXA4cWxVMGNEd1JrSFVadHBXRW5mQjNxeDhYVWI5Vy9YbkdZdEpUV1hhN3Nx?=
 =?utf-8?B?NHc2OElMR1ZoNXpmN1VBNGtFNXpWQ0pBL3RHNWlHN0hWTzVRUi96TDZiVERT?=
 =?utf-8?B?YUxUMmx1Nnhid0lRQVlrMEJ2UkdCdmpyeEl4WHdjYzcwRndlaWwzZHlrQWdL?=
 =?utf-8?B?V0prd3lYeU84bHZvL0Ezck1ybWhtb0JtOEdxRktNaUxUZ1RNUjhLZW4vN20r?=
 =?utf-8?B?TzcrU0J5VGFvZUprb2ZRT0Iwd0kyTkNpbzJKdEpyMHYraVF2a3VJd3N1YVNz?=
 =?utf-8?B?cC9JM3BweUxBLzc3MWNwbVBCendCN0hzbG9NMmJJS1RSZndFUFhPaDhuSHFh?=
 =?utf-8?B?M0M0N0E0dXZLOE9KWGhTaXhPQXFFTER4NWRydEZuc2MwNmh3dkQ1ekdoQVhQ?=
 =?utf-8?B?YmxNdHhwUTVMM3podWcwWmxXUC9qMnZqa2Y1ZmFYYllMVm9ZenBEYnJ6K0V0?=
 =?utf-8?B?STNwZjM1N1VuL3pJVHI5OFh3SjBuL082Sm9obmFEQXhuK05iTDVtMkRZVVNB?=
 =?utf-8?B?QjVKY1F5UFVGOEE5SWJNTDV4dW1NdHlBUlFJYjZLYnVET0ZrZ0ZHZEg4Qk5z?=
 =?utf-8?B?QjRNTmtBNGJPOUdmdlF1T0RoR2ZadTJSUmFCcnpnVUd6NnJOVXA5a2ZieXYv?=
 =?utf-8?B?MmJwNlVac0ZPbnFFQ2V0dyt4YkNzR0NkN1VkNlkxWk0yQmN4MVcwWFgxQVBD?=
 =?utf-8?B?b0FVQ0U1ZFl5UUZ1K01FMU1DeGJXQmUybkszTVk0TStPYW43ZjF2U3B1VXZu?=
 =?utf-8?B?R0lKR3czbXhIdzZ3c2s2T0F1bjBqNE9sM081MU5aendJeklBSFA3dVlYK0pi?=
 =?utf-8?B?S2c3Rm5GTTU5MkxEb3FwL3Y0dXJMVHowMGlsQW9BY2llRWtYVnJZWHlIOFVO?=
 =?utf-8?B?NnFQYWRhNkVNUUdpRlN2NVpCRW8vY2JybkR2ZDM2NVg2RnA2NEMvdHRKc3FE?=
 =?utf-8?B?cHV5SkVNZmdxVlpZN1MycTFrcmhvM0E0REpIYWZtRmF4RXdiMXNPYWgrWmo1?=
 =?utf-8?B?N0FYOVltTlEwcFVPQWhJUWhWQ3dpdTZLY3ppOTNWOVU0VjI2MnJRaWRURzE3?=
 =?utf-8?B?UnZXZXBqUzBaZml6cjZ1OTd4dEh0WWVMMTc2Z1lOQXRoaE1hdmxKRnJEU282?=
 =?utf-8?Q?+o3EvAb0/fkaoTGU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR02MB7186.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8aeca7-1676-41ae-c323-08da13064c3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2022 11:04:59.4253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Vk6mJXkww9dXdSn60TDsLSM9754gVoylMM4UuQ4PDN4T44OU/5as7dzFNfZxQQORabbqnKZUHqgi+ULVC+IcX4vAFK8Z602RxHZpKXJPUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6488
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRG1pdHJ5LA0KDQo+IE9uIDMxLzAzLzIwMjIgMDg6NTMsIFNhbmtlZXJ0aCBCaWxsYWthbnRp
IChRVUlDKSB3cm90ZToNCj4gPiBIaSBEbWl0cnksDQo+ID4NCj4gPj4gT24gV2VkLCAzMCBNYXIg
MjAyMiBhdCAxOTowMywgU2Fua2VlcnRoIEJpbGxha2FudGkNCj4gPj4gPHF1aWNfc2JpbGxha2FA
cXVpY2luYy5jb20+IHdyb3RlOg0KPiA+Pj4NCj4gPj4+IFRoZSBpbnRlcnJ1cHQgcmVnaXN0ZXIg
d2lsbCBzdGlsbCByZWZsZWN0IHRoZSBjb25uZWN0IGFuZCBkaXNjb25uZWN0DQo+ID4+PiBpbnRl
cnJ1cHQgc3RhdHVzIHdpdGhvdXQgZ2VuZXJhdGluZyBhbiBhY3R1YWwgSFcgaW50ZXJydXB0Lg0K
PiA+Pj4gVGhlIGNvbnRyb2xsZXIgZHJpdmVyIHNob3VsZCBub3QgaGFuZGxlIHRob3NlIG1hc2tl
ZCBpbnRlcnJ1cHRzLg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IFNhbmtlZXJ0aCBCaWxs
YWthbnRpIDxxdWljX3NiaWxsYWthQHF1aWNpbmMuY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiAgIGRy
aXZlcnMvZ3B1L2RybS9tc20vZHAvZHBfY2F0YWxvZy5jIHwgNSArKystLQ0KPiA+Pj4gICAxIGZp
bGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+Pj4NCj4gPj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbXNtL2RwL2RwX2NhdGFsb2cuYw0KPiA+Pj4g
Yi9kcml2ZXJzL2dwdS9kcm0vbXNtL2RwL2RwX2NhdGFsb2cuYw0KPiA+Pj4gaW5kZXggM2MxNmY5
NS4uMTgwOWNlMiAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tc20vZHAvZHBf
Y2F0YWxvZy5jDQo+ID4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbXNtL2RwL2RwX2NhdGFsb2cu
Yw0KPiA+Pj4gQEAgLTYwOCwxMyArNjA4LDE0IEBAIHUzMiBkcF9jYXRhbG9nX2hwZF9nZXRfaW50
cl9zdGF0dXMoc3RydWN0DQo+ID4+PiBkcF9jYXRhbG9nICpkcF9jYXRhbG9nKSAgew0KPiA+Pj4g
ICAgICAgICAgc3RydWN0IGRwX2NhdGFsb2dfcHJpdmF0ZSAqY2F0YWxvZyA9IGNvbnRhaW5lcl9v
ZihkcF9jYXRhbG9nLA0KPiA+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Ry
dWN0IGRwX2NhdGFsb2dfcHJpdmF0ZSwgZHBfY2F0YWxvZyk7DQo+ID4+PiAtICAgICAgIGludCBp
c3IgPSAwOw0KPiA+Pj4gKyAgICAgICBpbnQgaXNyLCBtYXNrOw0KPiA+Pj4NCj4gPj4+ICAgICAg
ICAgIGlzciA9IGRwX3JlYWRfYXV4KGNhdGFsb2csIFJFR19EUF9EUF9IUERfSU5UX1NUQVRVUyk7
DQo+ID4+PiAgICAgICAgICBkcF93cml0ZV9hdXgoY2F0YWxvZywgUkVHX0RQX0RQX0hQRF9JTlRf
QUNLLA0KPiA+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIChpc3IgJiBEUF9E
UF9IUERfSU5UX01BU0spKTsNCj4gPj4+ICsgICAgICAgbWFzayA9IGRwX3JlYWRfYXV4KGNhdGFs
b2csIFJFR19EUF9EUF9IUERfSU5UX01BU0spOw0KPiA+Pj4NCj4gPj4+IC0gICAgICAgcmV0dXJu
IGlzcjsNCj4gPj4+ICsgICAgICAgcmV0dXJuIGlzciAmIChEUF9EUF9IUERfU1RBVEVfU1RBVFVT
X01BU0sgfCBtYXNrKTsNCj4gPj4NCj4gPj4gSSBzdXNwZWN0IHRoYXQgdGhlIGxvZ2ljIGlzIGlu
dmVydGVkIGhlcmUuIFNob3VsZG4ndCBpdCBiZToNCj4gPj4NCj4gPj4gcmV0dXJuIGlzciAmIERQ
X0RQX0hQRF9TVEFURV9TVEFUVVNfTUFTSyAmIG1hc2s7DQo+ID4+DQo+ID4+ID8NCj4gPj4NCj4g
Pg0KPiA+IFRoZSB2YWx1ZSBvZiBEUF9EUF9IUERfU1RBVEVfU1RBVFVTX01BU0sgaXMgMHhFMDAw
MDAwMCBhbmQgdGhlDQo+IHZhbHVlDQo+ID4gb2YgdGhlIHJlYWQgaW50ZXJydXB0IG1hc2sgdmFy
aWFibGUgY291bGQgYmUgaXMgMHhGLg0KPiA+DQo+ID4gVGhlIG1hc2sgdmFsdWUgaXMgaW5kaWNh
dGVkIHZpYSB0aGUgcmVnaXN0ZXIsIFJFR19EUF9EUF9IUERfSU5UX01BU0ssDQo+IGJpdHMgMzow
Lg0KPiA+IFRoZSBIUEQgc3RhdHVzIGlzIGluZGljYXRlZCB2aWEgYSBkaWZmZXJlbnQgcmVhZC1v
bmx5IHJlZ2lzdGVyDQo+IFJFR19EUF9EUF9IUERfSU5UX1NUQVRVUywgYml0cyAzMToyOS4NCj4g
DQo+IEkgc2VlLiBNYXliZSB0aGUgZm9sbG93aW5nIGV4cHJlc3Npb24gd291bGQgYmUgYmV0dGVy
Pw0KPiANCj4gcmV0dXJuIGlzciAmIChtYXNrICYgfkRQX0RQX0hQRF9JTlRfTUFTSyk7DQo+IA0K
DQpJIGJlbGlldmUgdGhlIGNvbmZ1c2lvbiBvY2N1cnJlZCBiZWNhdXNlIHRoZSBEUF9EUF9IUERf
U1RBVEVfU1RBVFVTX0NPTk5FQ1RFRCBhbmQgb3RoZXJzIHdlcmUgZGVmaW5lZCB1bmRlciB0aGUg
c2FtZSByZWdpc3RlciBkZWZpbml0aW9uIGFzIFJFR19EUF9EUF9IUERfSU5UX01BU0sNCkkgd2ls
bCByZWFycmFuZ2UgdGhlIGRlZmluaXRpb25zIGJlbG93Lg0KDQojZGVmaW5lIFJFR19EUF9EUF9I
UERfSU5UX01BU0sJCSgweDAwMDAwMDBDKQ0KI2RlZmluZSBEUF9EUF9IUERfUExVR19JTlRfTUFT
SwkJKDB4MDAwMDAwMDEpDQojZGVmaW5lIERQX0RQX0lSUV9IUERfSU5UX01BU0sJCSgweDAwMDAw
MDAyKQ0KI2RlZmluZSBEUF9EUF9IUERfUkVQTFVHX0lOVF9NQVNLCSgweDAwMDAwMDA0KQ0KI2Rl
ZmluZSBEUF9EUF9IUERfVU5QTFVHX0lOVF9NQVNLCSgweDAwMDAwMDA4KQ0KI2RlZmluZSBEUF9E
UF9IUERfSU5UX01BU0sJCShEUF9EUF9IUERfUExVR19JTlRfTUFTSyB8IFwNCgkJCQkJCURQX0RQ
X0lSUV9IUERfSU5UX01BU0sgfCBcDQoJCQkJCQlEUF9EUF9IUERfUkVQTFVHX0lOVF9NQVNLIHwg
XA0KCQkJCQkJRFBfRFBfSFBEX1VOUExVR19JTlRfTUFTSykNCg0KQmVsb3cgYXJlIHN0YXR1cyBi
aXRzIGZyb20gcmVnaXN0ZXIgUkVHX0RQX0RQX0hQRF9JTlRfU1RBVFVTDQoNCiNkZWZpbmUgRFBf
RFBfSFBEX1NUQVRFX1NUQVRVU19DT05ORUNURUQJKDB4NDAwMDAwMDApDQojZGVmaW5lIERQX0RQ
X0hQRF9TVEFURV9TVEFUVVNfUEVORElORwkJKDB4MjAwMDAwMDApDQojZGVmaW5lIERQX0RQX0hQ
RF9TVEFURV9TVEFUVVNfRElTQ09OTkVDVEVECSgweDAwMDAwMDAwKQ0KI2RlZmluZSBEUF9EUF9I
UERfU1RBVEVfU1RBVFVTX01BU0sJCSgweEUwMDAwMDAwKQ0KDQpEUF9EUF9IUERfSU5UX01BU0sg
aXMgMHhGIGFuZCBzY29wZSBvZiBtYXNrIHZhcmlhYmxlIGlzIGFsc28gMHhGIChiaXRzIDM6MCks
IG1hc2sgJiB+RFBfRFBfSFBEX0lOVF9NQVNLIGlzIDAgYWx3YXlzLg0KDQpGb3IgRFAsIHdlIHdh
bnQgdG8gZW5hYmxlIGFsbCBpbnRlcnJ1cHRzLg0KU28gdGhlIHByb2dyYW1tZWQgbWFzayB2YWx1
ZSBpcyAweEYuIFdlIHdhbnQgdG8gcmV0dXJuIDB4NDAwMDAwMDEgZm9yIGNvbm5lY3QgYW5kIDgg
Zm9yIGRpc2Nvbm5lY3QNCg0KRm9yIGVEUCwgd2Ugd2FudCB0byBkaXNhYmxlIHRoZSBjb25uZWN0
IGFuZCBkaXNjb25uZWN0IGludGVycnVwdHMuIFNvLCB0aGUgbWFzayB3aWxsIGJlIDB4NiAoaS5l
LiBEUF9EUF9JUlFfSFBEX0lOVF9NQVNLIHwgRFBfRFBfSFBEX1JFUExVR19JTlRfTUFTSykNCldl
IHdhbnQgdG8gcmV0dXJuIDB4NDAwMDAwMDAgKG9yIDB4MjAwMDAwMDAgYmFzZWQgb24gaHBkIGxp
bmUgc3RhdHVzKSBhbmQgMCBmb3IgZURQIGNvbm5lY3QgYW5kIGRpc2Nvbm5lY3QgcmVzcGVjdGl2
ZWx5Lg0KDQo+ID4NCj4gPiBpc3IgJiBEUF9EUF9IUERfU1RBVEVfU1RBVFVTX01BU0sgJiBtYXNr
LCB3aWxsIHJldHVybiAwIGFsd2F5cy4NCj4gPg0KPiA+Pj4gICB9DQo+ID4+Pg0KPiA+Pj4gICBp
bnQgZHBfY2F0YWxvZ19jdHJsX2dldF9pbnRlcnJ1cHQoc3RydWN0IGRwX2NhdGFsb2cgKmRwX2Nh
dGFsb2cpDQo+ID4+PiAtLQ0KPiA+Pj4gMi43LjQNCj4gPj4+DQo+ID4+DQo+ID4+DQo+ID4+IC0t
DQo+ID4+IFdpdGggYmVzdCB3aXNoZXMNCj4gPj4gRG1pdHJ5DQo+ID4NCj4gPiBUaGFuayB5b3Us
DQo+ID4gU2Fua2VlcnRoDQo+IA0KPiANCj4gLS0NCj4gV2l0aCBiZXN0IHdpc2hlcw0KPiBEbWl0
cnkNCg0KVGhhbmsgeW91LA0KU2Fua2VlcnRoDQo=
