Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B64559378D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 21:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343998AbiHOTOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 15:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343782AbiHOTK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 15:10:59 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEC13AE73;
        Mon, 15 Aug 2022 11:36:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3P36QUw8g9j+o0YLa6kinPTNnMnInyppRkWsGKTrOSsta+5uV6RGENBd8L9yCS4FMKHgmYdSsW1Qs6F1ryxOfNXs9wVdFZg9s1DlVQSSau9A6PLFoAWRFWfp17ZZn5NBUdFjd2JwzDPOCRK2jJAKM6a2pyEUjAgk99zjodiyezh1BgyrqnUe0yPKI/BaOLjmgq3CbKDQE8TDlCWvOT78A7lHeyn2Md9jPE6Y3NFILsrsMmV8FRazZuSuh3xXs6782O0eLH2SMZalGOZJn0cfcnEq4mUgCPPup96X6ua/AQ/yQHMPTN1Qo3UZxu33KjZPi2W0qSTMKw1sypcow7f1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+klT85JV0ufdI+TDZDDQj5J5oeRM4796AWJb8oWhRM=;
 b=T9TzywD/0PJW+Z0OY9suZfFZkbfeq1uDvCpAkt1cnQCKU6oduZR2yRZ68MIO1uKHp8tMCmpkEbneAj/yh1t2Lm5fXPk3jkf6YiK8WF97CfLsqZCUHIOWj2YtpNDB8uYQ6Ndduf1eI/YE7jhhypNUUWBLOONSk+NO1yvSzgoPjgY4Ewqob0CKgUXXVmLtz+dMGdRYKv5onste88/Wh5aayqh4+uPB3QZPsbjdoqZ1MyOnotMO+tfSTTKaQ/ORmqnM4fFha8hArFrZbXDMSIv5VmUIHuWDA4fcvT6Dz/V1JpIH4s2VMARiHmq7/qKASyF+SMqky5ZRFywyXTcJvk19Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+klT85JV0ufdI+TDZDDQj5J5oeRM4796AWJb8oWhRM=;
 b=rxkwUUp5VA7UTUBkkLt0LT3pnQZkIs9TZra1zaAVsH46a/+HdQ+cXaCTmGe2/Yz1Fyw1ZfDuReoDJig0ffYT22I//RzKT5aPJa9VxGZrVCssC3aBxPGyCvlShUQQ/l/Bg1RDbS9333PepkfpG8rMFF/WK124sKw/u+t0Qne+PeU=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV2PR12MB5989.namprd12.prod.outlook.com (2603:10b6:408:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.27; Mon, 15 Aug
 2022 18:36:39 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::4489:9a98:ef82:6c67]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::4489:9a98:ef82:6c67%3]) with mapi id 15.20.5504.027; Mon, 15 Aug 2022
 18:36:39 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Akihiko Odaki <akihiko.odaki@gmail.com>,
        "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>
CC:     "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] AMD_SFH: Add a DMI quirk entry for Chromebooks
Thread-Topic: [PATCH v2] AMD_SFH: Add a DMI quirk entry for Chromebooks
Thread-Index: AQHYl0PsuD/YzkpEuEOrNeNjLt/lv61+26eAgAABToCAMZ+r4A==
Date:   Mon, 15 Aug 2022 18:36:39 +0000
Message-ID: <MN0PR12MB6101E98363A22A66662B3D69E2689@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20220714053752.5124-1-akihiko.odaki@gmail.com>
 <87d96692-7dbf-f846-f644-5a81f92efcb9@amd.com>
 <2b73e71c-a927-076d-bf44-6dc4431eb3be@gmail.com>
In-Reply-To: <2b73e71c-a927-076d-bf44-6dc4431eb3be@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-08-15T18:33:59Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=6fb88f3d-1fc4-4dba-9274-56190f429c12;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-08-15T18:36:37Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 28c4c5e0-0182-4dbb-9707-5728f35c4ce8
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed0be86a-5764-4d28-12fa-08da7eed17c2
x-ms-traffictypediagnostic: LV2PR12MB5989:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: coum0JxRITtbkM0fx8JH6SXXhgm/Gbh41Sj+EExW5g2dVlwb08oXtDX4MDeLWIHL0NRskJO0LI/3EKeV3eWBG2ohV9mOFFYYwxeWX3x+ZzJ03pvG/Qy5nEC8turuVk/2J4qqUBW4qdtm+LUgxNU5bD7Zvck/el8VsBSlj9uA2DwVC5xgVjHU8KGWgXyZNKu8hiuk6DoV+BjCN/T9fLOBmrIyfJsQ7HUfPERN6KciEdZsb10WgTO17SmNKVlvJFQHbrdpaDw7ty7Ps2A1hY/4/7IVJlh/M40dXaHcgwc8gy8VZ2nyIYG3jegqQPcbQ+op3EmVTajAUpCUHSmQrnoBoXOMQWs5809sU2S5qPr9dWQZJQvVnaNTWN60ybxqA6MxglTARehmXDZbAk6EzE0hrBUpKfpL5P1R2ezxBmeRcbOaxZ5ZhWzgwBq12xTxlRlU4cnHDu60FJQvZWrN8pIRm0pzBaw1t8Xqw0rpZETyGU1K1OfQot1AVnWWPPMs36GbFmjzqsfxOIZMHo0lMLI8gZPOKB3xNcsK4by6hLwrS008VfEhOAKw/ujytdx6zWtggkOB+D820oT57YTVmbZfdY3waBBrR/b+79RgTaVy/GnT3BNmyjzuNNGyRv5YCbhY7YQqDVdxIuBccFpZcpsWZv2WbG0JvnE1f3JSt1aa6Fu3wnn7tjOQbtWmxWuPoKDgAtmWy914OnlNG2Uj/GZ5wl0HQPhkYFzF2hpMQJOsY7niwgAryYp/D/UkgnLRPrmnRwplJquRJfuf0cIC90noYu510fxB1LWogFrA52OQgr45lvVprNmSIiypes1IKhdw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(76116006)(8676002)(52536014)(8936002)(66946007)(5660300002)(4326008)(64756008)(66446008)(2906002)(66556008)(66476007)(33656002)(55016003)(6636002)(54906003)(71200400001)(110136005)(316002)(41300700001)(6506007)(186003)(26005)(9686003)(38070700005)(83380400001)(53546011)(478600001)(7696005)(122000001)(86362001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UU5lY0xVdFFla0RmUWZMOElDODlnczBkK0JueEdpZGxFZGdCdFpYSjVCWkRs?=
 =?utf-8?B?UXFhOTYwZlZIOVVHalNVT3VqMUwzNVEzV1lodXZzRFEzY0dLSFBHRklYcTlM?=
 =?utf-8?B?R0VjaHBPTGlBVGgwZ0QvazQ3MDZqTkdud243YzhFMEwrR0tPa1QzRmY5K0h1?=
 =?utf-8?B?LytLNStRVGNrVmxQVFdBOWxYOEJKMHppL1AvUWcrU1ZLNC9WOHhXSDV2aDlD?=
 =?utf-8?B?WEk5L0dyWEpKelZZRk5yb1hrYUprQ0VHNHUwdk5pcEFoU09KQ2NrMDE5RDlI?=
 =?utf-8?B?Wmh3MFMzLzdVT1k2OE1PRzN5bGNRTXRIU1lTSVd3MElreEkxbUkydEw4UEsw?=
 =?utf-8?B?VFFBN29CQ3JTM1QrNmVkTVpiaml6eWRTMWtsYjgrOXdCaTUwY2dxZm9aUzhH?=
 =?utf-8?B?MWkwaHFRdmpKUDZKd2Y1cEZVdE80T1orZCtoM2JFN1VMY0lCQUdqU3pGTTVi?=
 =?utf-8?B?RkFYUjlRNm4zREtVRDU2V1JtMk9uM3N0YmQ5TTJNOGU3dmFhaU5KQ1Rsb2di?=
 =?utf-8?B?cTJNSkRJcTNpSVFzRlhrMmJuQTRpL2ZmcTlHMWdhbHY3YzFOd3NIWWRkMTJl?=
 =?utf-8?B?aGkrTWpKSkxSS21jSjZuck5uNzB3ZCtCTy9OMUgrSHZIaUo2RlBmandoS09U?=
 =?utf-8?B?amRrZ2RydXBYSUhNUkZCeDVUeXVCcmVrcmdKcFRpNDJxMlVZcHpsMnhFV05E?=
 =?utf-8?B?ZmJoN3BaZ1pvUmRKb0h2NVNDWHdGdklnSEdoeE1KbTF4STNDblp5Y1Jod0tu?=
 =?utf-8?B?ajJjNTdtVkdvV1pNRmJZbW5sNlNxU2lQNVVsdG9HckV5QTZTUXBveUxXckhI?=
 =?utf-8?B?NHBmWjRqQXdVQ3hsQVEwMFAxNkFVdHg4ZDV4MGw2RmhzTThNZTd1L0NWQ0hG?=
 =?utf-8?B?aHg3MmgvZlFsMkdna1lhRzdhK2EwY1FIcnpVNHhUOHRQNlExdDQ1UEhhM3B3?=
 =?utf-8?B?Z0o4M2diWVpZYUZqNm5xcnI0MDg3R3UzSEhuSDdzd1dVZzZYUkR1UEZtTG5O?=
 =?utf-8?B?cm1uQ1dCbnUyYzJ2STRTTmJTNHVMQS9CYW9PdS9zRlhvdVU2ZitCVW1xUEtG?=
 =?utf-8?B?Y3pmTVhwWnpBSTZueUs2Z3h4czFMNk9IaXliOUdVUjhHcDcybHVNR0tSZzVI?=
 =?utf-8?B?NVFGenhHcDBLV1B0RUZ6SkZrT2l6SDhBU2cycVQyQWNySVFSQ3hBMys5Nk9Q?=
 =?utf-8?B?OWxFOFdLc2RSVDBhekR3aW93NDJYRUdsNVltaHgybExRSXFnQVZXNVRSdFhF?=
 =?utf-8?B?eUd2Y0hhckhUVS9HOFJXSXM0VXQyb3dLTzhKSDR1cU9DT0x2STBpcVNOaFZw?=
 =?utf-8?B?c25RVElIUVBWSGdDMjhISVdxNnJvSkJOaVBsTjU5VmthQjRiVTlSRmtTeHRs?=
 =?utf-8?B?Vnhnak5ZMWd2MmVjdDc2YTl3OHBTTVdoRk41bHdJOU5tTVpZZDJaVmQ5eTMz?=
 =?utf-8?B?REhJc0orQzRQaVZWdzM5ck5QeFBZV2xXaU55Wll0SnBhOHN0UWdkK1ZpZUNK?=
 =?utf-8?B?UDFrWlliNVlLdHVOcitSUHdsVlZUZHNTRmJtR2ZjaktwWXlUUE5NSEY2c0Vj?=
 =?utf-8?B?NWliOE51VVI2aXVMOTBNZzRKSmp4bmZpT2xKckxuQm9WV0JVeklKaytmTlYw?=
 =?utf-8?B?L3JiQzFabm1vNmw4dyt2VUU0Y3BkVDJhYUNiUnpCMU9Ia1ZGazh4MW5oQVk3?=
 =?utf-8?B?S3dxZDJsRDlsTmtYbjdkeEljM3JiVVVJM2p3djcyUW1Kb0ROU2lUczRIT2tr?=
 =?utf-8?B?bmg2YU9BTTNVek55K2FJNDhXR3FobytGMXZYMjJFSGU5SVNZNGtpR2I0aURU?=
 =?utf-8?B?ZFdLMS9RdzVaam0rcFYvZWhOb2ZNTlN5UDVxNnVCNS8zUXZHeTlNWE02aEl2?=
 =?utf-8?B?bmcrdkE5T0hUeU9qMkk3Njc0cTU4ZDNLVTdNTHB6RWRXZjdQR2FPb09LQnZh?=
 =?utf-8?B?RVZ6dm1hLzFhMUtwNEZkOUNnRzE2QnZUL09xaXIzcnNRNUtLR1cyMU1IYVZI?=
 =?utf-8?B?TlZFQnBQK1d1TWJ6N0M1QnhvTTdUakQ5aXVqSEQ0RnJUV3hGZ1R1blJiYXRo?=
 =?utf-8?B?MldzZ050N0pnS1NCeld6RzdLdDdUTml3TmozMVNTY1g1SE5IUUIrbHg3SHBI?=
 =?utf-8?Q?Gjxg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0be86a-5764-4d28-12fa-08da7eed17c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 18:36:39.7134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bKB9Jjcjc7gp3FwGOh6+KTL4ZDb5unTbmtyIQ2ASytfK4OvKX6FoOeesm8Jq7xAQSXCDzfoy4QBMaa6TPo1dBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5989
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBa2loaWtv
IE9kYWtpIDxha2loaWtvLm9kYWtpQGdtYWlsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEp1bHkg
MTQsIDIwMjIgMjM6NDYNCj4gVG86IE5hdGlrYXIsIEJhc2F2YXJhaiA8QmFzYXZhcmFqLk5hdGlr
YXJAYW1kLmNvbT4NCj4gQ2M6IE5hdGlrYXIsIEJhc2F2YXJhaiA8QmFzYXZhcmFqLk5hdGlrYXJA
YW1kLmNvbT47IEppcmkgS29zaW5hDQo+IDxqaWtvc0BrZXJuZWwub3JnPjsgQmVuamFtaW4gVGlz
c29pcmVzIDxiZW5qYW1pbi50aXNzb2lyZXNAcmVkaGF0LmNvbT47DQo+IGxpbnV4LWlucHV0QHZn
ZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgTGltb25jaWVsbG8s
DQo+IE1hcmlvIDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHYyXSBBTURfU0ZIOiBBZGQgYSBETUkgcXVpcmsgZW50cnkgZm9yIENocm9tZWJvb2tzDQo+
IA0KPiBPbiAyMDIyLzA3LzE1IDEzOjQxLCBCYXNhdmFyYWogTmF0aWthciB3cm90ZToNCj4gPg0K
PiA+DQo+ID4gT24gNy8xNC8yMDIyIDExOjA3IEFNLCBBa2loaWtvIE9kYWtpIHdyb3RlOg0KPiA+
PiBHb29nbGUgQ2hyb21lYm9va3MgdXNlIENocm9tZSBPUyBFbWJlZGRlZCBDb250cm9sbGVyIFNl
bnNvciBIdWINCj4gaW5zdGVhZA0KPiA+PiBvZiBTZW5zb3IgSHViIEZ1c2lvbiBhbmQgbGVhdmVz
IE1QMiB1bmluaXRpYWxpemVkLCB3aGljaCBkaXNhYmxlcyBhbGwNCj4gPj4gZnVuY3Rpb25hbGl0
aWVzLCBldmVuIGluY2x1ZGluZyB0aGUgcmVnaXN0ZXJzIG5lY2Vzc2FyeSBmb3IgZmVhdHVyZQ0K
PiA+PiBkZXRlY3Rpb25zLg0KPiA+Pg0KPiA+PiBUaGUgYmVoYXZpb3Igd2FzIG9ic2VydmVkIHdp
dGggTGVub3ZvIFRoaW5rUGFkIEMxMyBZb2dhLg0KPiA+Pg0KPiA+Pg0KPiA+IFRoaXMgZHJpdmVy
IHNob3VsZCBub3QgZ2V0IGxvYWRlZCBpbiBjaHJvbWUgT1MgYnkgZGVmYXVsdC4NCj4gPiBDb3Vs
ZCB5b3UgcGxlYXNlIHByb3ZpZGUgZGV0YWlscyBvZiBDaHJvbWUgT1MgVmVyc2lvbiBhbmQgS2Vy
bmVsIHZlcnNpb24NCj4gdG8gY29uZmlybSB0aGUgYmVoYXZpb3IuDQo+ID4NCj4gPiBBcmUgeW91
IGVuYWJsaW5nIG1hbnVhbGx5IENPTkZJR19BTURfU0ZIX0hJRCBjb25maWc/DQo+ID4NCj4gPiBU
aGFua3MsDQo+ID4gQmFzYXZhcmFqDQo+ID4NCj4gDQo+IEkgdXNlIEZlZG9yYSAzNiwgbm90IENo
cm9tZSBPUy4gVGhlIGNvbmZpZyBpcyBlbmFibGVkIG9uIEZlZG9yYSdzDQo+IGdlbmVyaWMga2Vy
bmVsLiBUaGUga2VybmVsIGlzIGJ1aWx0IGZyb20gY29tbWl0DQo+IDc4Y2E1NTg4OWE1NDlhOWEx
OTRjNmVjNjY2ODM2MzI5Yjc3NGFiNmQgZnJvbSB0aGUgdXBzdHJlYW0uDQo+IA0KPiBSZWdhcmRz
LA0KPiBBa2loaWtvIE9kYWtpDQoNCkFraWhpa28sDQoNCkZXSVcgLSBJIHRoaW5rIHlvdXIgcGF0
Y2ggaXMgdGhlIGNvcnJlY3QgZGlyZWN0aW9uIGZvciB5b3VyIHNpdHVhdGlvbiAodHJ5aW5nIHRv
IGxvYWQNCkZlZG9yYSBvbnRvIGEgc3lzdGVtIHRoYXQgcHJldmlvdXNseSBzaGlwcGVkIHdpdGgg
Q2hyb21lT1MpLg0KDQpJIHRoaW5rIHlvdSBqdXN0IG5lZWQgdG8gY2hlY2sgdGhlIHF1ZXN0aW9u
IHRoYXQgSSBoYWQgYWJvdXQgZGlzY292ZXJ5IHJlZ2lzdGVycyBhbmQNCmlmIHRoYXQgcHJvYmlu
ZyBpcyBzdGlsbCBhIHByb2JsZW0gb3Igbm90Lg0KDQpUaGFua3MsDQo=
