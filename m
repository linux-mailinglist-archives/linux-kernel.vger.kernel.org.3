Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478EF4E6948
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 20:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352944AbiCXT06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 15:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235832AbiCXT04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 15:26:56 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021016.outbound.protection.outlook.com [52.101.62.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7FFA8ECC;
        Thu, 24 Mar 2022 12:25:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cf28+LZz99RSr5WMpOwKKOGZhTeXu8lzBkmbc5Rd83wlnvFW783GztfRQmfnQ1rhkSmUbhrLf8zzwGUuN73dwcxRToGAp3R7y3ovth63MK325b1XfWd8+utaZtCStv42fsNFQPUwNP2I5dMaACEcDFad7HD2FMYQ/+ft2FCoSEiXyKf9n71vCX9XU7+SFXNm6DY5fSr1+QiGB8dO5kG50+xe3cePOUwkxHrgDrimn4Kp/ZSaaw2gBNx26bUI2SC5LE3alSWT4QnLFzbe6FiiizwGW0R3i6B4H14JxJkQrEHWdxxRcw5hgM+gV8oMQ22EKN2gyWiqiJkhVcRqWjNxJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIhxIK/ohuxd3j1/DQjDqZQxax7kVBDOu+KfGhkFksM=;
 b=IV/xh9tdsf0tibezvOcxfhzbIiBtlLUnm8AjJTQ1zFuHE9CHvy0ulmkVEQv+CLE+VnBQxm3tpRXnHINcCMSQuY+Mxf1+8Oq7FKMcVCa7msvzUrpjAVhnWs44Xmrq3v/bvm0Oz4Vh2695++oO1HE2rsOBXJgHQ2MS5acQVmEMnDtbwC9eI45tzif4yQyZzTTe0elqBuWt7Q+GDnNQcNAYZxaUWfvdOKSLeJ857QdVyw+nSC/xzhZwDejYaf9Ck0k3xqfARpW/VS3kZ+7Cn2fjow3ZVS8sYVeQa7YQwPL3Pa4aEMLcYN8MXS7rl1bcvqdSRA2YQaK7TyAydt2H7ndRBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIhxIK/ohuxd3j1/DQjDqZQxax7kVBDOu+KfGhkFksM=;
 b=SV4WHz6CCe/4iVyFMwkfbo8zikqQhwnTU/Zue5PxjcdLVGlJkpwGIXYd841Be7taQgYu6cnUHLafpqK2h14D2NjFthYebm+QJLWtuIX45Gq3uXKyNabsH1uT5mad1jXdK5L+jwp1fF/irZ5kHssi+52Ec+10XpqZPSyuAcqLMCk=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by DM6PR21MB1611.namprd21.prod.outlook.com (2603:10b6:5:ce::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.8; Thu, 24 Mar
 2022 19:25:19 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::71de:a6ad:facf:dfbe]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::71de:a6ad:facf:dfbe%5]) with mapi id 15.20.5123.010; Thu, 24 Mar 2022
 19:25:19 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     jason <jason@zx2c4.com>
CC:     Ard Biesheuvel <ardb@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 2/3 v6] ACPI: allow longer device IDs
Thread-Topic: [PATCH 2/3 v6] ACPI: allow longer device IDs
Thread-Index: AQHYLNK4fL59pmJF2Ea4CQMRQ5s3a6ypbsWAgAAEo4CAAAbTAIAAB7CAgAACs/CAAATqAIAAA+TAgAADDwCAImLl4IAABRQAgAMXfmA=
Date:   Thu, 24 Mar 2022 19:25:19 +0000
Message-ID: <PH0PR21MB3025900F80AE5FF005C38A79D7199@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <CAHmME9qHnvwrxEue4Pdm_E1qZQGXFuR9orJSKCWj8fH5TSh6fA@mail.gmail.com>
 <20220228183355.9090-1-Jason@zx2c4.com>
 <CAHp75VcjrD3kwN1BfWpjKXaVpG7MHfftMUscSGhcJfStm4b-Xg@mail.gmail.com>
 <CAMj1kXFmEAKJRHCiuXyGECCmOs0+xX9AVeBDxfuD0XuX2TQ2Uw@mail.gmail.com>
 <Yh0+LA8B1jw8tnl9@smile.fi.intel.com>
 <CAHmME9qW4EiYU6_kTffMdK5ijJY1DF6YRt=gDjj1vKqDxB0Raw@mail.gmail.com>
 <MN0PR21MB3098981B77F513976A62CA57D7019@MN0PR21MB3098.namprd21.prod.outlook.com>
 <CAMj1kXFZZoOeXnjxdU+gOJTN=Szn=eiXgRhSS9_nnHgwADNHjA@mail.gmail.com>
 <MN0PR21MB3098EC13B4E8488E692DB28AD7019@MN0PR21MB3098.namprd21.prod.outlook.com>
 <CAMj1kXFe-B=n1zp6M0yBuqJmmfOXTFbkzj29iK+QpPGK=LxRmA@mail.gmail.com>
 <PH0PR21MB30253A8BA8B189686B8E65EAD7179@PH0PR21MB3025.namprd21.prod.outlook.com>
 <CAHmME9pYObVqAPoGxTmvKhj31NFLO=_G7WECYDC0vb9nDTBhuw@mail.gmail.com>
In-Reply-To: <CAHmME9pYObVqAPoGxTmvKhj31NFLO=_G7WECYDC0vb9nDTBhuw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=509c3357-272a-40bf-bb0c-49b2110a8295;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-03-24T19:24:35Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9d6032a-e963-4b37-2dce-08da0dcc0891
x-ms-traffictypediagnostic: DM6PR21MB1611:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <DM6PR21MB1611588BB53A9184C472ED7CD7199@DM6PR21MB1611.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XZOdKQ4FNN2512p7lPjrc344gn7idwMg4yN2cT11m9HX58gRXQMK4VG/4xhWWVbSNrF9hEXquW4/zU0/aOSRBv6AHKyBhdOMgnZgDYWENW8cKaA7LEWJfw/uW6U3osLncwIYlJ+Hey4OoOTdyWbnziwC/w2lE7BRndmalbIt48ikMjNC6/SC4ypmG/cuqfuzBC21uwWdXyzkOe5ZxW1tFWt6pUxXzUBHeBUNdIEay36/davIV7iOvkN9kUBGVrCWOjsQvKBY/Nws8l2jDMa0vXYsHHAnmQJLzZh7LOYpO3VeQe9pQTctwyEJmp0uW8HIQug8kEG4oo3n8OHpRCGSr4vt0+vl9djovjOvuXdj+IwJM75pHt1pXzG4zWxq/4T0zndTpbBsktQ3bLid0LeJ42iMBeWRRtR7TVgNzz2+pL8PCAwi5bNswPZPUweYuTwKNaokLyl7cO8qcCWth+7/tWnOkbgSHvEU0xU+FepjXQwY91SIjpeFsiYluxbCBGw5VZzWY6FXfoQX32XeacujxL8jC/sD3kGzj+V+Dgjg8Cx8uidDrZfTHW8+nbcw8e8o/MTKuf1VY4WQJuHkNBpXIUzYjH9hbKhBwRTm3TtvjII86DHVQ5sA4XN21fLGb3XEl+aRzrFx4JDlesEuOtMqepkUVQ7MlbBkkAAc0cVxRCybToIxIXaIbbqFxmjOg4ddZhrerEJJxwqbUWkY2hZYBBYyDHesrXxHl7VlsbM3Wz/j+UMMIDCIi4Ytye5sDlZyg/e2n86DoGfjEB7jadlMoQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(71200400001)(186003)(83380400001)(26005)(7416002)(6506007)(38070700005)(4326008)(8676002)(66446008)(5660300002)(55016003)(7696005)(122000001)(8990500004)(64756008)(9686003)(82950400001)(33656002)(82960400001)(38100700002)(316002)(66946007)(508600001)(76116006)(4744005)(66476007)(52536014)(8936002)(6916009)(10290500003)(54906003)(66556008)(86362001)(2906002)(148743002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SllZanZsb0RoR0ZCUURSRW9HZ1lEYUVBR3hLL1lWcVdOWUxWbjlPSzhUeVdV?=
 =?utf-8?B?RnRkeGgxbWh6QTBrQ2p0ZmRrbEp2SFlnMElHRkhFY0NwVjdvcDR3bVBRSDY3?=
 =?utf-8?B?d1l2YW1jRCtsbnUzdmRqc2tmVjVzMkJGZjBKWS9QNWJGUnc0aXhLZXYxaG52?=
 =?utf-8?B?aU01Szh4RTdrUjdiSEJ6QTIwQVRDR2dENlhoSXhueE4vNXpSM25mc0ZYaU9K?=
 =?utf-8?B?ejF3S1U4akxmWVNFQ1JibWcwTW13MUkvb1RORzZGTHorQTdRbFZUZ1VCenQv?=
 =?utf-8?B?ZFdTNXpqN0diaE5ISXlENVRWQStieVRqeUlEUURUck50dGdIcmYrVm5UalRG?=
 =?utf-8?B?emNQSlRValUzcnQxMmZQZ3dlQVBEUVA4T1Y4bjdaN1hkNmlKUTdaZVRtQlgx?=
 =?utf-8?B?TXVNL0VHNVBJV1BpV2dIaUZacmJLQmlaV1Y2S1gzZjN5NU1hcS9aT1BXQ3ZR?=
 =?utf-8?B?WVh0OWVGK1JybmJ3bU0rYkIyU1lDdWFpQWd1Q2tpMThjejF1S1NHRjFPczdt?=
 =?utf-8?B?VHMvYjMwSEZaMzNFUXFWem1VVGg3ZnI3N0hDQm8yMnZtMkxSeEUydStDYndy?=
 =?utf-8?B?SllNNE5aNmJwSkhSejlZNXpRdjRYOTFtN3Z5Y24wU01HSlV6KzRwSW5naU5j?=
 =?utf-8?B?VU8zblVnSmluQm1VRkFDb0Y4L0R0UUhpeWZlQmUwckJGTGxpYTN1R1BpWk1h?=
 =?utf-8?B?SnR6dDRxeDk0em9PVFB5emE5UVJQTWxWKzJMK1FzYlNnTGV3dG9PbHdoeG1E?=
 =?utf-8?B?WWQxbW4yV0FhUzZpamt4cEt4aVpZTEJwZ3VwcDhicGZmejlscHU1bDJEbFND?=
 =?utf-8?B?cDFNV3I2MTkvMHZVVHV3MnZtMk04RklqZWE3ZXhKQ1NnNi9UNnZBNFZKMzZh?=
 =?utf-8?B?azZKcW8wekZaTlMxczVvME13V3c5NHN5MDdWTWoxaFJSZGJtQ0dVU1hHUnhj?=
 =?utf-8?B?a05KQ2pzVnByWEhWU09uZ25QUHhSYXRFSXdRSC92Q3RLenIzT2Z1UVRETXFR?=
 =?utf-8?B?MDFUQkYwMTBTQU5md0R5cndZbjhpMDJKNndFaFdsSDJzL2pIaXQ2L21ia2Fi?=
 =?utf-8?B?cTRvU01ncis5eGVwdnQrWEVYWnVWZS9lRHJTVExrYnZrdisyUkdVNXpSQSty?=
 =?utf-8?B?WktHRVFyYXhyOERzZkVycnJVSmREZUxtTGhOd0xSRzcyZGQ4eHprQ1FFTXEw?=
 =?utf-8?B?ZzhENWNOd0VjRStBbHJMakQxUUNab3dQdXpFa0xGNjlobk14VkNOMDJ6c2Rt?=
 =?utf-8?B?OHQ2dlZablNuTlNFQUZIclZMRTBleTRldldHL0ZUSVNVeFg5dGltNkFGa3NO?=
 =?utf-8?B?NGJMV0loTXBNTlB3eWVFTDc0ampwSTFZQTJ3YzgyRXlzUHJoSWxqSHkvSE5h?=
 =?utf-8?B?QUsyaXlXekZNcEkzZ0swdGplSWpoa1g0NjJNejRqdENwbm9CblJocFpuNDJy?=
 =?utf-8?B?K3M3M2dRRG9BVlF1OXFmK0F5MnIyTE5neUpGd3JQN3FNZFZEc1JmVG8zRmlz?=
 =?utf-8?B?TmhaV0pDRzRGYVk5dDJPa05qTEJwQllybkRlSXlhbkxiZDlOdStrSDZVelFX?=
 =?utf-8?B?WGN4VnNhN1Z0TzU0MVg5elFXQ0FacnBjalVGT0w1ejV2VmVSUlRONjJ0N0VI?=
 =?utf-8?B?T0VocmY3dDI5N3E0c2E0OVp2VFFvOXFVWXNqTlFQc3d1MnowbWcwdnRhc0FB?=
 =?utf-8?B?UnduOWIrVEVKRkVTZ05FYjNSb1YzVmpJVUg2WXVNVWtJd2JJYlFXR1NhNzQr?=
 =?utf-8?B?UFdzclp1ckl4UXk1UjJnQjlhUitZV2I2bXRZT1Q3c0pzMi85OWl6WjNWTjd0?=
 =?utf-8?B?d3k5QTRPUFpoYnZlSVdXMVpER1lTS2lPa1J0UHhtMjhkR01sOVBqQ3JpMGM4?=
 =?utf-8?B?Ty9tTmtWOUVFWjlzMjhLeWZyOTJXZExIUzMwL2NKVkF4NTNCeUFCVkZuVU8y?=
 =?utf-8?B?cDJIWmZxa0doRS83aEVWV3pRWWYrS2ZQRXMzVmhlWm1RNU1OMUJlVDdHOVQy?=
 =?utf-8?B?ZEk2VHArbWpJWHpxRUNoV1lLYXowcUhFL3lKeGRZYnFXb3BrTUVRYjUxaENO?=
 =?utf-8?B?UTUyWjNCNDR4dVBuQm1yMVVwS1JaZDljQXVCUWRFYkliaTVwTHk2RHVScmRO?=
 =?utf-8?B?SGJEYVJVR2x5emdHcXAvZTNEbDloLy9Sd0pMNHpKdVJnZHU3dHlkbEdIRjBp?=
 =?utf-8?B?SVZ6WklaWTdINDFSTnZqcVhZZG1QSFpVK1d4cU1JMklhNXE3YmNOSkR3RWx3?=
 =?utf-8?B?ODhYcXhCeUs0U2VvRlNYMkJUNUFXc3lyRytUSFlDTmlMeWZjbGsvQUhQeHJT?=
 =?utf-8?B?c2loa0ZjSmRWK00waFhOa2tZZjFncGVzWHJkaGdhZ0FkRkFHNEJ2ZzhXeUhv?=
 =?utf-8?Q?mrZpKpa4/Ha4cZk8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d6032a-e963-4b37-2dce-08da0dcc0891
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 19:25:19.2818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zds54l4Gq75fSnkyu0KXe1Y/a5qxayiNITjn8A3CdEFTmiWfhvEVZRiKn9KbakkgQNo7Ox0rjtHppNZnH+eH4gHnLFLlkokLJ17S1tW+UGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1611
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSmFzb24gQS4gRG9uZW5mZWxkIDxKYXNvbkB6eDJjNC5jb20+IFNlbnQ6IFR1ZXNkYXks
IE1hcmNoIDIyLCAyMDIyIDE6MTIgUE0NCj4gDQo+IEhpIE1pY2hhZWwsDQo+IA0KPiA+DQo+ID4g
VGhlIEh5cGVyLVYgZ3V5cyBwYXNzIGFsb25nIHRoZWlyIHRoYW5rcyBmb3IgeW91ciBzdWdnZXN0
aW9uLiAgVGhleSBoYXZlDQo+ID4gY3JlYXRlZCBhbiBpbnRlcm5hbCBidWlsZCB3aXRoIHRoZSBj
aGFuZ2UgYW5kIHZlcmlmaWVkIHRoYXQgaXQgcHJlc2VydmVzDQo+ID4gY29tcGF0aWJpbGl0eSB3
aXRoIFdpbmRvd3MgZ3Vlc3RzLiAgSSd2ZSB0ZXN0ZWQgd2l0aCBMaW51eCBndWVzdHMgYW5kDQo+
ID4gSmFzb24ncyBuZXcgZHJpdmVyIChtb2RpZmllZCB0byBsb29rIGZvciAiVk1HRU5DVFIiKSwg
YW5kIGl0IGFsbCBsb29rcw0KPiA+IGdvb2QuDQo+ID4gSXQgd2lsbCB0YWtlIGEgbGl0dGxlIHdo
aWxlIHRvIHdlbmQgaXRzIHdheSB0aHJvdWdoIHRoZSBXaW5kb3dzL0h5cGVyLVYNCj4gPiByZWxl
YXNlIHN5c3RlbSwgYnV0IHRoZXkgYXJlIHBsYW5uaW5nIHRvIHRha2UgdGhlIGNoYW5nZS4NCj4g
Pg0KPiA+IE1pY2hhZWwNCj4gPg0KPiANCj4gRG8geW91IHdhbnQgdG8gc2VuZCBhIHBhdGNoIGFn
YWluc3QgdGhlIGNybmcvcmFuZG9tLmdpdCB0cmVlIGFkZGluZyB0aGF0IG5ldyBpZD8NCg0KSSd2
ZSBzZW50IGEgcGF0Y2guDQoNCk1pY2hhZWwNCg==
