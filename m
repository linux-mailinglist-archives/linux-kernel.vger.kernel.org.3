Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1316E5A0159
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 20:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239022AbiHXS2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 14:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbiHXS22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 14:28:28 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD73B5AC49;
        Wed, 24 Aug 2022 11:28:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igdxrXGRRxxeqh430KL6SkMyZOoJtmuNmaWa1+Ms6gjIzBj75FlLEcnwfs8OLvqodlX+P3DGqeZ7ZhaDjkHUSbCgEFv+10kIAmyu7p5bwRSLNAUoAaBnmUeUL/Th6WnxFVkjoqax1EVufgwkRWpbbe04pLptEVzbCW9Chn/FBB3DN1ecjDoC2aHiszezBw0/f3mtetf+ssDjwlh7/yI0laxkvS+fmmLqbO8qwznxrxnDgPTfSrgKNMPY0aXiLwwySf5EA/xNX69AtjW9OnfUbupkndgc5suxwyI2hstOw3njhZ6ErNIeG4Sh2BGDQvpePQxBZo+cZQ5c2aOOZKCzYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqxP5q2sl8cKl2k+ErNz2busewqZVf9C15OzVp+H3+8=;
 b=hpRH9/dmpMPW9nrVQPQu8s9gASAXcluaJil4+k8z55qkjHpV5lq9mweQicpB3ZWM2idY96pg21q8Sry0EnIJQSxRZfIK/uEjw5yUbnhfm3SEKKoIS3K1kujFSkA1CcyFWlFfbPV5wNA1GwgTvIOl5pMqCXAi3TtQ8Rn9OcBgcVhKYjycmqIg7FQTlXWB6HuVtsCsGJvWf5TB83HBUL+GW9JdKDzgHxs5HcSpKlVrp/YTEh2iNhZ2Sav8qjB+7UUhX0yhE+qeIwaJ8B414i7lrIvy3lVtXgi7lHdWV973WUAaBoCZR0+t7sdTiw+T36MZMNTQKOovtcfukeI7XpQBow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqxP5q2sl8cKl2k+ErNz2busewqZVf9C15OzVp+H3+8=;
 b=LtJ9rm4TFe5kXbJ155Xi0T4N9V/KtpjhPN/lV2KSbG+rrLNc8PIptqXcvPVgKbDLIf1zNNuurfD4CQsl23wOEpurOfcvHyg2KRKbVkkFVKdycQ9Z+ezgHPgtnxim13DHIyQiQEchKWil1cdiW4JIUEayWee9/gFLbg84d+ELBJo=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MWHPR12MB1934.namprd12.prod.outlook.com (2603:10b6:300:109::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Wed, 24 Aug
 2022 18:28:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3%5]) with mapi id 15.20.5546.022; Wed, 24 Aug 2022
 18:28:24 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "ddadap@nvidia.com" <ddadap@nvidia.com>,
        "Dell.Client.Kernel@dell.com" <Dell.Client.Kernel@dell.com>,
        "kherbst@redhat.com" <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/4] ACPI: OSI: Remove Linux-Dell-Video _OSI string
Thread-Topic: [PATCH 1/4] ACPI: OSI: Remove Linux-Dell-Video _OSI string
Thread-Index: AQHYtyFZfNzjOU9+kk2bcaYvhyYRi62+GfMAgABGL8A=
Date:   Wed, 24 Aug 2022 18:28:24 +0000
Message-ID: <MN0PR12MB6101DE7A18DC0343AEBE89C5E2739@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20220823185134.14464-1-mario.limonciello@amd.com>
 <20220823185134.14464-2-mario.limonciello@amd.com>
 <CAAd53p6MfBaRTTNJ5mAFU6XfDndLFJihLHKdrbq8Nq-27LArjg@mail.gmail.com>
In-Reply-To: <CAAd53p6MfBaRTTNJ5mAFU6XfDndLFJihLHKdrbq8Nq-27LArjg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-08-24T18:27:44Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=18d52fc4-9488-4118-ae8a-8d0307cca939;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-08-24T18:28:22Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 66855645-3d59-4542-ae57-cebaa595db46
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72f28990-38f2-4069-f802-08da85fe6e3c
x-ms-traffictypediagnostic: MWHPR12MB1934:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yJShZc46PmItsXJb0QWSAqRoXeRREU19IJdm9IMX38B4D91l2m/gRtn7Eb+AzGeSJfOa2vZ3HqYtape2Ye1sfiayOB0FGJ0s4bu02RNc5AgRfmjEiUD63F+2L3Mti7d446l6cBoD7vr4t2LbJSms7mYjhTR50U5aCr0EcEi2xE+qECiftl8XNKBgQPcQpRkFtXecfXxiSqVT7VoYZddMOfL+Gpnc6Xs1ZGvuIRKJms+nr/W+mv00ocyk23A5otxPQpNGKLGfZH2VoEvYzLH4WJaDw17wZSQ76pH/AVk/Gb8rQ1ALL5OJf4K54RJjF9YHxkh627wWa3NESzl+V7xrAEh9znWK6BcKn5MUAghies5uwy+JR83KFMumsdsA0oKURiwg6fQ6c3bZMlNNgiSF9MjuRRx9jh2evwAdU1Q5+7m7F5HwlIYnXDwUlECfcKwneO/fq9loZcLQKVjAxSWmb+eq/7aKXkT2dmqu/CS7Ynmk1iufx+MqeTw/HgTsfEJjr4shIJ3+ujGvC5J/JiHrFyy9z72KVMm0t38SXa9soeOmG4QVNh7+XcmsIxx8pP33vR8UL1k9t60cM0GMaEVMj75Actna/CJ36TRA7gqVyFaOzwnvyweM9OWa9tlMIqJxAiLhO370jIi08sazhKjce36a/b5Qjud7gEbeZHCva9gplIjWDD3TOEsJk6/hvLeijvCByjwHna5keetkB++zTih1msu9NQpwchQvTSi+WjmcIHB+x6CtOlbNsa1sWok4JJG1APPmIm7dq//Iyt0mmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(83380400001)(186003)(122000001)(38100700002)(76116006)(54906003)(64756008)(66476007)(66556008)(6916009)(66446008)(66946007)(4326008)(8676002)(316002)(8936002)(86362001)(2906002)(7696005)(26005)(9686003)(6506007)(52536014)(5660300002)(53546011)(33656002)(71200400001)(41300700001)(55016003)(478600001)(38070700005)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekkyN2JwZzVSRFVHY1RNM2RoYjZYdnZCa05PdWlXbFlFbmFDcmc0TnhCQVBU?=
 =?utf-8?B?UTBrM3QzTnRNc2JsQ2Ivd3VvVlhPMlZqR09QSG9mdlhnMkozek5USkFobkZP?=
 =?utf-8?B?TXVIMDQyZFlCc0Jyc0pMUzg2cVZRcFNLNzc2WmJmZXZWMUJVRzBwSVlNSHBy?=
 =?utf-8?B?d3VWWkJuVDlqZ3BZMFJFdG85SVpqV1BTbnVRcDZ0VWUwRkhYdzRaMnBSUFhQ?=
 =?utf-8?B?eHRiMk9aQkJZR2RERkRzK0Qzc1RJUVhrKzh0V2pvUnpVaFNidHN4cDRZRjEw?=
 =?utf-8?B?VUFoT0l3YmQwaTJpSjNIWW1PTzJwNXNPSG5wZkQ4RlBFZmowL29uNFNtQ2tk?=
 =?utf-8?B?OHhtM285NHJBVTAxLytIaFkyU0hmRzJSSWxYZjJHd0JpU0RQbU9GdkxWbDk1?=
 =?utf-8?B?dlZLWmd3Z1BtTkNHTGtSRDVjVzVJbjBOWjl2VHlkN012Q3lNVWkvMDBEdmps?=
 =?utf-8?B?ME9vNDExa25pQ090K2YyejZwUGJ5UWVmcDllQTlsR05rUEtPanlkbUhlT011?=
 =?utf-8?B?V3JJWmlkNjVpWDdqM3dNb09HSUpta092V1VrbW9mS1lCT2dsTHZ0dUxxd1VI?=
 =?utf-8?B?V0Noc3dyVmgwUkxTMGdwYVhIQ2ZSNDdrNlg0TzgyU1VERWlJZ01hdm9FaW5Z?=
 =?utf-8?B?Z1dQSFQ3bE1yNzRGNmdWNWgvSWs4WmpWakp6ckpJemt4U2ppMkhaR3FNUEtU?=
 =?utf-8?B?ZTNJQnBwVENVSWplL1Y3WVJQNExtL2g1TEFjTUxYUnRtcGVjb3dYRXZ4VWpH?=
 =?utf-8?B?U0RJUXQ3eExwZDZNYXdPVGZtRVJwOWFvckhZUHlWUHYwcUlUbWZ4WHVmTlpk?=
 =?utf-8?B?Y0NYeXNaSUpyUytRSTN3TE9YTzREaHdQKzVaalRGd2p0bk9UVjU3Q0w0ZWZr?=
 =?utf-8?B?VkpKejNaa1lySTBwTzBOUW5ZTVpVNzlpU2lLUzNDa0xrYythMTNIRGRTV2tq?=
 =?utf-8?B?R0pSeC9Tb3lLWkZHL0Z5RHlRekh0c3NHYTN0SFNyd0NHdmh6NXFYWmhXa090?=
 =?utf-8?B?dkpFdEk2VXNsZlYrZkJzUDJLTUhDSEZtZ2ErRWdnRVd2ZHljZVlUSUU4bEVi?=
 =?utf-8?B?YnFOVkpKaFJ1NHdGN0xZdlZtcDdKV3dQZHBMQitjY2lnZTllalpBQmQwVkdU?=
 =?utf-8?B?eVJlUWRyR3g0ZjkwVmdySlFlam4wUTh5WlY0a0lZbFlLbVcycm5RUEZEeW56?=
 =?utf-8?B?OWs4b0tHTjRHQ2c5TWNkRjRFdjkvKzdvM2dsWkpOZ2Q1VFZvQ3ZHMS9PbnVz?=
 =?utf-8?B?c01WaXdOY1J6b3oxTTZzOXZvRTcxWHdtbHdGZjN2RzhUT0lrV3Fnekg5K0sv?=
 =?utf-8?B?UVFJbXVMMGlQSXI0dGp2dlFNQUdtTHVxbFhNa0h0cjhmZ0N3c2Z0R1BaQmVz?=
 =?utf-8?B?NjlIR3c4eW4xQzl2clZTVC9Ka01MQ1A1QTE4MG9iaXlIQTY4T2cxbmhYMjZ1?=
 =?utf-8?B?QytQYlk4di85dzdUYVlEc2pFcEJ2clVpaWlEUlF2M1pKQjdMRXdIUS9ZZGo4?=
 =?utf-8?B?c0IxTVZKS1RPWjdNK2o5d1JkUVQ0THVGcFdmcnlsajZ1Wm1iWnNYdHBDMkM3?=
 =?utf-8?B?SUFXTU1GeVVYcDRzQ3FhQlZEZ3RlR1QvTXNGZWptRjgwb1F2VlJmQ1NNNjB0?=
 =?utf-8?B?SDFFaFRqZWFLaExudCtUeUFYcVFwcDBoU2NFM2l1R0lFSnRYeFFZeXQrUHJ1?=
 =?utf-8?B?YU9vZXF1U2UrQnZITngzNXBtUitaS3lMd3p6VTlseHYzelZFRVUwWlFCdjJV?=
 =?utf-8?B?ZjY3dTJETFBlc3JHWVMvNTYxVDRIUlR3NThvVFpzRllDakJEVVZzWVlra0lJ?=
 =?utf-8?B?S2ZscTZ0QjVLZUlCVFc3WFBnRmwxSFJ1RzE3N1BFV0dVSHBEZEYxZ3hZbGpp?=
 =?utf-8?B?b01aOHBncEZSOGxNMnhMUHFIVllhNHorN1dFVU5oYWdLbjJjVDJnR244NWtL?=
 =?utf-8?B?QXJRQnpjdU9aSVFwNy9sT0o1eWhqRVpkQU5zUU5LRDY2M1l3Y1pHTUNoK2oz?=
 =?utf-8?B?aVBabTNaZVRBYzlKUFV1cC9QQkZQRkhCTHF1akFKaHZmazA5NUgzREd5c0hM?=
 =?utf-8?B?Q1kyL25ybzdld0trSTV4cFNDUzgxUG53YnFaN0pLOHMxQUpPZzdGKzl5ZUJ1?=
 =?utf-8?Q?P3ws=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f28990-38f2-4069-f802-08da85fe6e3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 18:28:24.3398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Qkbyshn2IKxAN82AWauGwYD/kWTbF9yuxUvh7APms5mP6eL/q+ehIqMG9/tXHVO0DzXXNHKF+u7FkhBLBuwFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1934
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2Fp
LUhlbmcgRmVuZyA8a2FpLmhlbmcuZmVuZ0BjYW5vbmljYWwuY29tPg0KPiBTZW50OiBXZWRuZXNk
YXksIEF1Z3VzdCAyNCwgMjAyMiAwOToxNw0KPiBUbzogTGltb25jaWVsbG8sIE1hcmlvIDxNYXJp
by5MaW1vbmNpZWxsb0BhbWQuY29tPg0KPiBDYzogcmFmYWVsQGtlcm5lbC5vcmc7IExlbiBCcm93
biA8bGVuYkBrZXJuZWwub3JnPjsNCj4gbm91dmVhdUBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGhk
ZWdvZWRlQHJlZGhhdC5jb207DQo+IGRkYWRhcEBudmlkaWEuY29tOyBEZWxsLkNsaWVudC5LZXJu
ZWxAZGVsbC5jb207IGtoZXJic3RAcmVkaGF0LmNvbTsNCj4gTHl1ZGUgUGF1bCA8bHl1ZGVAcmVk
aGF0LmNvbT47IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvNF0gQUNQSTogT1NJOiBSZW1v
dmUgTGludXgtRGVsbC1WaWRlbyBfT1NJIHN0cmluZw0KPiANCj4gT24gV2VkLCBBdWcgMjQsIDIw
MjIgYXQgMjo1MSBBTSBNYXJpbyBMaW1vbmNpZWxsbw0KPiA8bWFyaW8ubGltb25jaWVsbG9AYW1k
LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBUaGlzIHN0cmluZyB3YXMgaW50cm9kdWNlZCBiZWNhdXNl
IGRyaXZlcnMgZm9yIE5WSURJQSBoYXJkd2FyZQ0KPiA+IGhhZCBidWdzIHN1cHBvcnRpbmcgUlRE
MyBpbiB0aGUgcGFzdC4gIFRob2VzIGJ1Z3MgaGF2ZSBiZWVuIGZpeGVkDQo+ID4gYnkgY29tbWl0
IDU3NzViODQzYTYxOSAoIlBDSTogUmVzdG9yZSBjb25maWcgc3BhY2Ugb24gcnVudGltZSByZXN1
bWUNCj4gPiBkZXNwaXRlIGJlaW5nIHVuYm91bmQiKS4gc28gdmVuZG9ycyBzaG91bGRuJ3QgYmUg
dXNpbmcgdGhpcyBzdHJpbmcNCj4gPiB0byBtb2RpZnkgQVNMIGFueW1vcmUuDQo+IA0KPiBBZGQg
c29tZSBiYWNrZ3JvdW5kcyBvbiB3aGF0IGhhcHBlbmVkLg0KPiANCj4gQmVmb3JlIHByb3ByaWV0
YXJ5IE5WSURJQSBkcml2ZXIgc3VwcG9ydHMgUlREMywgVWJ1bnR1IGhhcyBhIG1lY2hhbmlzbQ0K
PiB0aGF0IGNhbiBzd2l0Y2ggUFJJTUUgb24gYW5kIG9mZiwgdGhvdWdoIGl0IHJlcXVpcmVzIHRv
IGxvZ291dC9sb2dpbg0KPiB0byBtYWtlIHRoZSBsaWJyYXJ5IHN3aXRjaCBoYXBwZW4uDQo+IFdo
ZW4gdGhlIFBSSU1FIGlzIG9mZiwgdGhlIG1lY2hhbmlzbSB1bmxvYWQgTlZJRElBIGRyaXZlciBh
bmQgcHV0IHRoZQ0KPiBkZXZpY2UgdG8gRDNjb2xkLCBidXQgR1BVIG5ldmVyIGNhbWUgYmFjayB0
byBEMCBhZ2Fpbi4gU28gT0RNIHVzZSB0aGUNCj4gX09TSSB0byBleHBvc2UgYW4gb2xkIF9EU00g
bWV0aG9kIHRvIHN3aXRjaCB0aGUgcG93ZXIgb24vb2ZmLg0KPiANCj4gVGhlIGlzc3VlIGlzIGZp
eGVkIGJ5IHRoZSBzYWlkIGNvbW1pdCBzbyB3ZSBjYW4gZGlzY2FyZCB0aGUgd29ya2Fyb3VuZCBu
b3cuDQo+IA0KDQpUaGFua3MgZm9yIHRoYXQuICBJZiB0aGlzIHNlcmllcyBuZWVkcyB0byBzcGlu
IEknbGwgcm9sbCB0aGF0IGludG8gdGhlIGNvbW1pdCBtZXNzYWdlLg0KT3RoZXJ3aXNlIHBlcmhh
cHMgUmFmYWVsIGNhbiBwaWNrIHVwIHNvbWUgb2YgaXQgaWYgaGUgdGhpbmtzIGl0IG1ha2VzIHNl
bnNlIHRvIGluY2x1ZGUuDQoNCj4gS2FpLUhlbmcNCj4gDQo+ID4NCj4gPiBSZXZpZXdlZC1ieTog
THl1ZGUgUGF1bCA8bHl1ZGVAcmVkaGF0LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXJpbyBM
aW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJp
dmVycy9hY3BpL29zaS5jIHwgOSAtLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDkgZGVs
ZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL29zaS5jIGIvZHJp
dmVycy9hY3BpL29zaS5jDQo+ID4gaW5kZXggOWY2ODUzODA5MTM4Li5jMmY2YjJmNTUzZDkgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9hY3BpL29zaS5jDQo+ID4gKysrIGIvZHJpdmVycy9hY3Bp
L29zaS5jDQo+ID4gQEAgLTQ0LDE1ICs0NCw2IEBAIG9zaV9zZXR1cF9lbnRyaWVzW09TSV9TVFJJ
TkdfRU5UUklFU19NQVhdDQo+IF9faW5pdGRhdGEgPSB7DQo+ID4gICAgICAgICB7IlByb2Nlc3Nv
ciBEZXZpY2UiLCB0cnVlfSwNCj4gPiAgICAgICAgIHsiMy4wIF9TQ1AgRXh0ZW5zaW9ucyIsIHRy
dWV9LA0KPiA+ICAgICAgICAgeyJQcm9jZXNzb3IgQWdncmVnYXRvciBEZXZpY2UiLCB0cnVlfSwN
Cj4gPiAtICAgICAgIC8qDQo+ID4gLSAgICAgICAgKiBMaW51eC1EZWxsLVZpZGVvIGlzIHVzZWQg
YnkgQklPUyB0byBkaXNhYmxlIFJURDMgZm9yIE5WaWRpYSBncmFwaGljcw0KPiA+IC0gICAgICAg
ICogY2FyZHMgYXMgUlREMyBpcyBub3Qgc3VwcG9ydGVkIGJ5IGRyaXZlcnMgbm93LiAgU3lzdGVt
cyB3aXRoIE5WaWRpYQ0KPiA+IC0gICAgICAgICogY2FyZHMgd2lsbCBoYW5nIHdpdGhvdXQgUlRE
MyBkaXNhYmxlZC4NCj4gPiAtICAgICAgICAqDQo+ID4gLSAgICAgICAgKiBPbmNlIE5WaWRpYSBk
cml2ZXJzIG9mZmljaWFsbHkgc3VwcG9ydCBSVEQzLCB0aGlzIF9PU0kgc3RyaW5ncyBjYW4NCj4g
PiAtICAgICAgICAqIGJlIHJlbW92ZWQgaWYgYm90aCBuZXcgYW5kIG9sZCBncmFwaGljcyBjYXJk
cyBhcmUgc3VwcG9ydGVkLg0KPiA+IC0gICAgICAgICovDQo+ID4gLSAgICAgICB7IkxpbnV4LURl
bGwtVmlkZW8iLCB0cnVlfSwNCj4gPiAgICAgICAgIC8qDQo+ID4gICAgICAgICAgKiBMaW51eC1M
ZW5vdm8tTlYtSERNSS1BdWRpbyBpcyB1c2VkIGJ5IEJJT1MgdG8gcG93ZXIgb24gTlZpZGlhJ3MN
Cj4gSERNSQ0KPiA+ICAgICAgICAgICogYXVkaW8gZGV2aWNlIHdoaWNoIGlzIHR1cm5lZCBvZmYg
Zm9yIHBvd2VyLXNhdmluZyBpbiBXaW5kb3dzIE9TLg0KPiA+IC0tDQo+ID4gMi4zNC4xDQo+ID4N
Cg==
