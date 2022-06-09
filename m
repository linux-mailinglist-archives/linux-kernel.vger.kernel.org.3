Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874B154410D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 03:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbiFIBad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 21:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiFIBa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 21:30:28 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020019.outbound.protection.outlook.com [52.101.61.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAC0227352
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 18:30:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+RhRX7KMjaXEI3S2oazH9DFOy8DOElWUGLSvZCDvNSMoz5WpJmX+iahLT0pSmujL4UaIgMblasi6B3aMmRa4ftbRm0PJ7Motcf3QdzrkeScc+h5p0OBZTsQC6sYBhNtSL/OMWZFMC0hHFozoR86HrCMi+0RjJM+rbNv//+KdZZ47LxHBfFZEz2WA3tmO+PFBmVyV3W2e28iIhr+3KxeiNrpyNiW2jKOT716eHtvQigPT6wEZ10/WkZohBawVXviTpAb1Z7b48XnNogAiqzK92UX6jG6x5fJV0wMGo5x73PyymAF+ESorG8nY2JcPNFiRVTnqqONThPfbVAZQ0xpgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MNqvPBIILaWzbaXHEDfazuARXL4e55jHkOvKdWqjbg=;
 b=T1niasWsakp04OoZfaGiBByv38kpQiBRiBtVaGFEeyzkIzAEyjkyW6zwT13B+lhElObgQo2ZYElxc+u8wRbKthg1DTSlmV4QvNdxQew8x0WyfZOMEVVVphD3pP+c9UQGQLdTd+LIr0HMO7+lUzPL7Us0cxojEXED3t+QfBc8liuERgfzBlA0D2Ob4leAXo6QdLzQaQ9IVBbSXTnLI5j01YAdK0kM5JYXxYuj+YOMg04a/th9DqtEAGdEkXEUh1Qjzw/2odE1brEdlUVwf+NOKQuhKZF5Y1PyL2bgTIXjbe1lU9SEQHwKWwIO3XEy2QhIYEgZQ1OjqqSgCTNhOP9T7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MNqvPBIILaWzbaXHEDfazuARXL4e55jHkOvKdWqjbg=;
 b=g7BZXAHkt2UfFjHCa1vsQYJSInMPCkrKsYbbrUkfc/6XmP1NcRVmIvd0km1w8aKhDDgk4jUXQqZO7JE+8LtYyl4yEIZKfpeoY7Ny4hY5ousmL3kAxV3I4MXKe3srKMuyGAugoUsxQG7DtmgCObVohRB/VCrzlRJgN7IK0OFSDkg=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by DS7PR21MB3244.namprd21.prod.outlook.com (2603:10b6:8:7c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.5; Thu, 9 Jun
 2022 01:30:24 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::8061:e9da:aa0f:a013]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::8061:e9da:aa0f:a013%9]) with mapi id 15.20.5332.007; Thu, 9 Jun 2022
 01:30:24 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     Caroline Subramoney <Caroline.Subramoney@microsoft.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        Richard Wurdack <riwurd@microsoft.com>,
        Nathan Obr <Nathan.Obr@microsoft.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Subject: RE: [PATCH v4 1/1] nvme: handle persistent internal error AER from
 NVMe controller
Thread-Topic: [PATCH v4 1/1] nvme: handle persistent internal error AER from
 NVMe controller
Thread-Index: AQHYe2j7BWRzM8vuNkKkhrqC0qHJpa1GN0KAgAABhACAABD/0A==
Date:   Thu, 9 Jun 2022 01:30:24 +0000
Message-ID: <PH0PR21MB30254824A4CC8CF6FD5EAD96D7A79@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <1654714341-41189-1-git-send-email-mikelley@microsoft.com>
 <0e57d8c2-9a30-f15e-dc38-da397ac81c34@nvidia.com>
 <5a27e5a5-74eb-6c65-eb68-c655c3b5ae6e@nvidia.com>
In-Reply-To: <5a27e5a5-74eb-6c65-eb68-c655c3b5ae6e@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=71681537-a373-4072-8a42-0c6357b0b378;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-06-09T01:28:59Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 920d1b05-e997-4142-517a-08da49b7a05e
x-ms-traffictypediagnostic: DS7PR21MB3244:EE_
x-microsoft-antispam-prvs: <DS7PR21MB32440EDEB9B5A7F4566FA3E7D7A79@DS7PR21MB3244.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zC2FW76GVsEu1YWM+FNm7L+ouTN7C6nPuB6zGYSWLolDFModgqiVBtqA/XP+ZVecHJoV6RK9MNQjwo6V8bBoad57mX2JLJIbHylCMcvVNA1fYYuNheZRiPRAVC8eoL7TjfUw/p0fhOo+O1omGs7dUMiJM1gbTkkwJ88CGrtKI4tMr1WxuoU+p0PCiduI1xiijGOk4hocu96ACbVyfLKN8H8TKaar2+P/cg1iRI/fIWEFCTsQYoMN0oOav7PVARcvwTKMDPOKcv2hQIrunUS3P2wfEOKuQnJqRKvRLZ9sUbUeA6G+LERERCY396dg2ORso+0OtnyJq4oD3Z9YZn4tUqcgvhISarCghpr2ZlUxj4GNuWIID/4JSt9/ke2LHqidUFqbYFElNEuK8MzplXK2aT4idtcw5TrRgcNjBWbb8i6L3koVY/k61w7TNyNQa3in1hlC389h9OWu+PJzM9SBxwdG1lyQUI2rukB7oCvFsL0Om6bFsnKQsFJVDqUZwnatqM8bWrLAm7k/k6fqYjbjuYjm1N3miV2an0Jy19m4DjPGZvpxPQGy0MU5eWBcmrgHiM6hMnQ20oysLQA2EunfkuTC8pZP0cJzBvVxg6tKRO909o3k4Ac4BCD14v3srQ4u7t6ZwbfUyJZdcSoJ4s8Z2JhbexvCZoqF+xvINpzpk98XR36YIrJWszxdo1bIOZ5d14ipSS7J/GLzgFYFotAv8ANQA1zAKiOTGawinxj1LRsNu0YrdEZrIsZ52wdOdpaz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(508600001)(33656002)(5660300002)(83380400001)(8936002)(55016003)(8676002)(4326008)(52536014)(38070700005)(71200400001)(26005)(9686003)(186003)(6506007)(53546011)(122000001)(2906002)(66476007)(66946007)(86362001)(10290500003)(316002)(66556008)(76116006)(66446008)(64756008)(6916009)(8990500004)(38100700002)(54906003)(82960400001)(82950400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEZCdnB0c1ZieWM3ZHVmM1VuQlMwbzVWUTNiOWVhSkZ2YW9zVTZoZjErdUZY?=
 =?utf-8?B?emhWRUhSeUJ6SnRzT1F0aWkxeHErWlBQd3BINVhPMXQwNURWSG5mV0UwTzdN?=
 =?utf-8?B?eklPUkwwK2wxQXhIYkZ3RS9CUEN5WmgyaElXV2NwL0lwallwbDRQSkxwRldC?=
 =?utf-8?B?NGUrOFB0cWZBK0dzbFlZbngvdWlnVW82QTIrU1Y2M2JxV3MwZEdEVEh2ck9p?=
 =?utf-8?B?QlIzdHdoREw2VDlWU29OOWNsVlJHVVpaeVNoeEZzditCcUNyV0VJUTNLbVVI?=
 =?utf-8?B?N1JJWWVtWmpVWjFsK3UrM0E2SW9vVzJDSERhYmJxNTFkVUtobDVvZk9LcGZ6?=
 =?utf-8?B?TURpVXVodUtMU1RUbC82MUVYdi9keVUwWm43U2xYTGUxMjdnSkpIUHZWaEZh?=
 =?utf-8?B?THJTaCtsK25FMGVvWk15RVVqek9YdFptYkczSXJMNmZSWFFVODBmYXc3Vk5r?=
 =?utf-8?B?bGtKRGxuZHk5ZzZ0VTdhQ2xHK3p0T0dKcGZ6WU5hVURxZEJPbUpJZ25RVEpD?=
 =?utf-8?B?cngxK1B6bEoySDREZ2xnUVRQWDVVTGd6ZDFlUkVvZ1pPSUFLMWlsaHNyRXRB?=
 =?utf-8?B?NWtSRXFZU25HMmh4REpkTTNHNnZIVEFBeEo3UHl6RStJcFRYaytpcHNVNnhZ?=
 =?utf-8?B?TFViTnczcGd6c0ZWNXRIM2VHV1dTYWdxNEZJWG9yV3hJZUlhbjdMY05uY0Ey?=
 =?utf-8?B?VGpqcTAwVjJaMTArdk93WFpCd1ZHaTUreFJtYmlVUHpnZVdweGRBcGRoM2wr?=
 =?utf-8?B?ME00NDVwUFFwY2xadWlIYUJVZmRCc1c2R3pIUjY0akQ5RlMvQWpwNEpMQWQw?=
 =?utf-8?B?N1ozbWRWdnQ5dHhCSjVRR1paNFVYOFhxNC9BWjdjS2hQRTQ3cXY0MXN3Tzd4?=
 =?utf-8?B?RTJKMkpsVFRLTVphSXpxYWFzcWRaZTRnV2dwWFpLMEIxTkloaWZibnByc0ha?=
 =?utf-8?B?MnltUU9SUHd2SEN5dHY2ZjBDekw4Zko5Z25PTWxxb2phdXd4dFl1SU5SNVR6?=
 =?utf-8?B?ZWwzNU83Y0hQNGc2S2gwR2ZQbjBJa2pSblNPKzNpK2Z5S1BXT2dDOVlXZVY1?=
 =?utf-8?B?VEhvV0dSME9Xakt0ZHYzQ3R4MTkxQ3QwemxlVENyRW90aVg2NkdRMGxJVlRk?=
 =?utf-8?B?bEVYVHBpL1lZcWhuRC9VcmRCMnZWVEY5bGx5TmpSa2c4OTRUN0plRDduTDVT?=
 =?utf-8?B?bmYyMCtrOWh3dmNsNDFrZGNNeTdrbmtyU2g0TXhoZzBFeFlrdU5LcjlmeVRn?=
 =?utf-8?B?aFlIK2Y4bnZBZnVGTGlnVXBCVE0yUVc4WFZiRENvNzlONC9JeTdoOGJ0SUZh?=
 =?utf-8?B?ODZlVFI3SlVWaGN4RkhueWp5NWxWRUlmUVJ1TEdtZ0RSNXdEMXQ1U2U5UVRh?=
 =?utf-8?B?YmVVZmJGU0dWUTdmYjE0Nmk3MVRzS21iUTV4OVFSZTF0NER5VDR2OVhZMkdW?=
 =?utf-8?B?RG5wS1B4eHUyTVJYV1NJNUpxMkx2YldGZmtSYi9jc1RhNStJN1I1N3JjOWl4?=
 =?utf-8?B?djhJWTBDbTZ6bmtRWDB5d3BhRGR2M0s1dXBDZUNPTVpRVm5BcG1DVzQ4ems3?=
 =?utf-8?B?UTJSOXlHUzJHU3VBM0VyeFVkVFFLSGRZQ3lMZG9YcFZsYWpNQy83M0F6L1FE?=
 =?utf-8?B?SWpvSURvRzIvQzY5Q0lDQUhUaGVIenVKNGMzcitrcCtadUZySFQzSHY5cXRz?=
 =?utf-8?B?ekF0WkQ2TmY2WUhyd0h1RW0yVENwWmtiZm5zT1J1QlRoWTRuTC80SFVSWHFo?=
 =?utf-8?B?eFBHRzlnWjBueXhVT1cwWDY0K3lPOGVGcUE4Yi9HSUpBdkRQdFhpOU9yWTY4?=
 =?utf-8?B?S2NmUmtlZk9FM0VOVyt2ODVQY0NUYU5STFg5Tm0wNFU2bzJNdGUzVTEvWFpw?=
 =?utf-8?B?bTkxQ1QwRDluT2FXTFBWOUlhMjRndGxibnFuZGwybWRwK3paRy84WFoxM2NP?=
 =?utf-8?B?M1FPWnRXODhQdXMwZVAwVjZ5SmhhbjVpb1U0YkdBSFU2L2tENkhkN2dOS0lF?=
 =?utf-8?B?NnFkV053U2JVcERUQVRmZFB2cWQwL1hsVHpaem9IcWlTR3JFYVlNVC9jUlgy?=
 =?utf-8?B?VEx3N3RXeS9iV0lMMmhWcWtFUXd0NU54bUQzNjIyK2ZJL2F3bEN0ZnRoRVNP?=
 =?utf-8?B?d04xQnV0Ukx4bWtSQ3RFZW5zT2JMSUJOSXpncXgwS3pBUU05WDdZS21kbWJQ?=
 =?utf-8?B?bDlNZlBvbDRKWTd2anFGSHZkVUhjWkZMY0hvbWJ0YUZQeitkN0VubzFqeDZL?=
 =?utf-8?B?Ym5kN0R6ZDZLS1VsVnZEb1djU2JXS1ZzVElyNGV3bEtKWFkxL1hTenhhcHNR?=
 =?utf-8?B?VTRZVEJhWm91SlpRbW1yelZFNVNEK01pUVZLK2hWc1NEc1I3aTBqNmp6a3dj?=
 =?utf-8?Q?rcDQaQVc9D+lbc68=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 920d1b05-e997-4142-517a-08da49b7a05e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 01:30:24.4100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kqmGEXw+yGBqFitU0w+zmsQGkvEiURae2kLYgF9eCwrEOYsA6dNQPWyuET0rAF6OKvqjp54gBFHDDH0GaI8nfZtP1agTN6k0++rOu+139Z8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3244
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2hhaXRhbnlhIEt1bGthcm5pIDxjaGFpdGFueWFrQG52aWRpYS5jb20+DQo+IA0KPiBP
biA2LzgvMjIgMTc6MjIsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4gPiBPbiA2LzgvMjIg
MTE6NTIsIE1pY2hhZWwgS2VsbGV5IHdyb3RlOg0KPiA+PiBJbiB0aGUgTlZNIEV4cHJlc3MgUmV2
aXNpb24gMS40IHNwZWMsIEZpZ3VyZSAxNDUgZGVzY3JpYmVzIHBvc3NpYmxlDQo+ID4+IHZhbHVl
cyBmb3IgYW4gQUVSIHdpdGggZXZlbnQgdHlwZSAiRXJyb3IiICh2YWx1ZSAwMDBiKS4gRm9yIGEN
Cj4gPj4gUGVyc2lzdGVudCBJbnRlcm5hbCBFcnJvciAodmFsdWUgMDNoKSwgdGhlIGhvc3Qgc2hv
dWxkIHBlcmZvcm0gYQ0KPiA+PiBjb250cm9sbGVyIHJlc2V0Lg0KPiA+Pg0KPiA+PiBBZGQgc3Vw
cG9ydCBmb3IgdGhpcyBlcnJvciB1c2luZyBjb2RlIHRoYXQgYWxyZWFkeSBleGlzdHMgZm9yDQo+
ID4+IGRvaW5nIGEgY29udHJvbGxlciByZXNldC4gQXMgcGFydCBvZiB0aGlzIHN1cHBvcnQsIGlu
dHJvZHVjZQ0KPiA+PiB0d28gdXRpbGl0eSBmdW5jdGlvbnMgZm9yIHBhcnNpbmcgdGhlIEFFUiB0
eXBlIGFuZCBzdWJ0eXBlLg0KPiA+Pg0KPiA+PiBUaGlzIG5ldyBzdXBwb3J0IHdhcyB0ZXN0ZWQg
aW4gYSBsYWIgZW52aXJvbm1lbnQgd2hlcmUgd2UgY2FuDQo+ID4+IGdlbmVyYXRlIHRoZSBwZXJz
aXN0ZW50IGludGVybmFsIGVycm9yIG9uIGRlbWFuZCwgYW5kIG9ic2VydmUNCj4gPj4gYm90aCB0
aGUgTGludXggc2lkZSBhbmQgTlZNZSBjb250cm9sbGVyIHNpZGUgdG8gc2VlIHRoYXQgdGhlDQo+
ID4+IGNvbnRyb2xsZXIgcmVzZXQgaGFzIGJlZW4gZG9uZS4NCj4gPj4NCj4gPj4NCj4gDQo+IENh
biB5b3UgcGxlYXNlIGNsYXJpZnkgdGhhdCB3aGljaCB0cmFuc3BvcnRzIHlvdSBoYXZlIHRlc3Rl
ZA0KPiBzdWNoIGFzIFJETUEsIFRDUCwgYW5kIFBDSWUgPw0KPiANCg0KSSd2ZSB0ZXN0ZWQgUENJ
ZSBvbmx5IC0tIHRoYXQncyBhbGwgSSBoYXZlIGFjY2VzcyB0by4gIEkgY2FuIHR3ZWFrDQp0aGUg
Y29tbWl0IG1lc3NhZ2UgdG8gYmUgbW9yZSBzcGVjaWZpYy4NCg0KTWljaGFlbA0K
