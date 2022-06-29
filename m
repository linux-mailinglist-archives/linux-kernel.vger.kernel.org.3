Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78717560A73
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 21:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiF2TjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 15:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiF2TjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 15:39:01 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AD517E3C;
        Wed, 29 Jun 2022 12:39:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7wU+66HOourRcXANK/+sKf16jQYCVU6m6BMbOEVOVfINwyneHNLcoa99RC3qe69r9jyXPBuZKJWr87xUhVvc4DnVmykPRLlNjqXR6VHqhD8Kwe9XyUgO8DAgd4ZV8d9xUGFHBTx7KM1lIYQ4SOSuB0rp5jZuHccwi8MzKEgLt3byCO20ejPJvRNE3rKxVPBO7Xa/n/qiedfN+vjA3Q3Kg5vK6l3cnAQcijNMsrtQygYtqHfpDbgZvpCibHiVgA9FpBLUDiIBKh0FMwf14FQbejKfmi7ySX/p5yMWi2G1e4uMH7WJMLJ8lcsfUT7w3ek47UUohN3ZnqPtuumBhfQrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2PfWY4ro1Xj6htlllKTl80Ig8FTNBy2FMjudhwQ4Ng=;
 b=NkUkoTVIIZY1vCdfvN8QBzJeLiVHmFw3zY2OKULGnPV7hylYwc0ZTw0kQranPacJls0h/qp+O+HwjBoIK8Hs/Gx9gOuzKbOLWlRD3qoxT/IMwvnS9fOhtpSDua96pmxwo6xs/Zgf6KHyqYhdYdYLdtdGa6NH+AczzZXbaC7zoAtx1jWYWoVYyPoS2xG9RtNaYPImufMMxaX8xy96fPCeUXbVaTJq3/q0sILoljvunP3inAjcjBGODX8jiQrX9fAwIqKALigeKmB71cu8qVoDBduBjysUbvkLj531NVpYc6ILTg3jbGbSNkAnzNafBfPpdwF9R5YqutlTdVPpkmKHxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2PfWY4ro1Xj6htlllKTl80Ig8FTNBy2FMjudhwQ4Ng=;
 b=HfCVpbl+gOVdnXR1W3GHKZ/91ZdIKFaGLxgvFSoe02nBFE9W2+zbr9XMaZB97SQwCkWdDExAOs0xrgGOG2laJ3CY5BdrdslO7oGwziIIaNvzyiRFEHKpHRS60Boqe1Uwy/e6RvQtONIe3jUQ+3dBNQQBiTLEMJfIsnRT8BZti3k=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MWHPR12MB1806.namprd12.prod.outlook.com (2603:10b6:300:10d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Wed, 29 Jun
 2022 19:38:54 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%5]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 19:38:54 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Len Brown <lenb@kernel.org>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ACPI: CPPC: Don't require _OSC if X86_FEATURE_CPPC is
 supported
Thread-Topic: [PATCH] ACPI: CPPC: Don't require _OSC if X86_FEATURE_CPPC is
 supported
Thread-Index: AQHYikckkfPFKMg6CkqPB4GLDcaQGq1muz6AgAAAOuCAAAdaAIAABAig
Date:   Wed, 29 Jun 2022 19:38:54 +0000
Message-ID: <MN0PR12MB61016ADE571E1C1A72024056E2BB9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20220627165832.10246-1-mario.limonciello@amd.com>
 <CAJZ5v0g2qfA00=ukatTxSXPnoOaquwvn8tk0oNHaY-0F7ODZQw@mail.gmail.com>
 <MN0PR12MB6101BFCBAA33B98D438B25E8E2BB9@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CAJZ5v0g8e4pJoPSaCqPmgfvi8KYNLJyAHsXAcU_z-kU5bMJy=w@mail.gmail.com>
In-Reply-To: <CAJZ5v0g8e4pJoPSaCqPmgfvi8KYNLJyAHsXAcU_z-kU5bMJy=w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-29T19:38:51Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e8e97800-072b-4024-8f4c-c216a462d8f2;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-06-29T19:38:51Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 8aa28915-b8e4-496d-8e06-cc79c26fd5f9
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a75f1a8-738a-4824-44c2-08da5a07005e
x-ms-traffictypediagnostic: MWHPR12MB1806:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vT8X0mFiuAGtNy8g/QBu//D0PeMipVUSzAOlLR4HLFHIkbAXTn80l/5qKFLab7xw8I/vR0BNNnPOv3Gw1DlT+OSyLg8trd7aEocMP9Y50/dXbVQF381vyCUVhT9KOphB2PN5i9Uroxs9yOL6sqh5NQutTaJy7wwbHhV52cAfBkv2L0g0saJ9LLlFi0MiH8G3dU6QAh0eiVyl2Vtez3/2hD0bUy4h6JJhVPozA1Zu97bJhhPbvInk14ZiUa1JqzQRDEx9TdUShZbs0CdWqLt3SsZccbddWueIjWqU3zfmxb6q1uzLU41Lb5sZhaAs5HEnEzeqDaKXeGQ/oR0RGXvwy0r7Kof71sWl27tfSi3XOXrwEdc8VDzy2qdXeX4I4muPosm58aQkynGI3KjRGvdNm1AU54IX3QpIUvtsRcPH+eQLT0aPcGYKb+p9DNgCCw6Er22mnA4+mqqoZ43+lFMM1i16DmVK/E5m6yKJQlpfVRRgYuaog0n8x4VVSF4NrAqq03+wWnE6Xkw+7M1dKaadyKuOmv7IY0TC5FK5YpeeokCloblp4MqkoM/csg1r9qL7sTeIHeReXH6GJT5XNd+fFsvXPW6ohOn3CwsHqrjMq9X0eU2Vv8ddcfj/z6xjD3C8bR59mK0mmPKVXx5abII+FfiIVavcj8aRN3CD15/ZiJft2Yemv6Nhajnq3BmQ+nPPOWQFOzKWF0dtXj//FdUqqfkRxGGl7120f7C9UEsNe1dyLLps5AbgsSmC73D7z6GW05eDMqjFdZp89htAmXisV6s5YiOw8vQkfCysVT/bbUM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(4326008)(5660300002)(66476007)(66556008)(8676002)(186003)(66946007)(55016003)(7696005)(66446008)(8936002)(86362001)(76116006)(38100700002)(64756008)(83380400001)(52536014)(9686003)(71200400001)(6916009)(6506007)(122000001)(38070700005)(2906002)(41300700001)(33656002)(54906003)(478600001)(53546011)(26005)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0c0bkVJT3JFMVpmdEV0S2d4Uzg2L0ZXbnBwNUxsYi9HenpmQ1NZbXBQK1lL?=
 =?utf-8?B?MDczRzJLMUdmTEV2UUNOK29pODVvN1p2M1g4OHJQa1g0a2lLelBpMnVjT2VZ?=
 =?utf-8?B?WTNKRVlkZkJUaVFzZzlsMWR4T2JnNXJuWVVFdm5nUUlxd3N1S2RrR0JlMmla?=
 =?utf-8?B?am5xTmtaK0VBYkVUYitwblBSM0p2ZTAvN0VPellVelFiTFVUWDF4Y1RpVGJs?=
 =?utf-8?B?V2pOREtQa3hIZElxS1I2N2ZBaHRyNTlqN05hRnphRURUUWJRT0lrQ3BPYVVz?=
 =?utf-8?B?R1ZhUXFGR1dVNnhNRW0zNFdWRnNkY05TODhHeFltNVQ5UWNVNWhlT01iNDl6?=
 =?utf-8?B?U3lyT0VXWmtjdFNlMjAvLzloZlNaNkJ4Y2N0cHhWWnpFRVBXajNyUXR0MUFM?=
 =?utf-8?B?K2lsUkZXaEQwYVBOUHNtWDVvZGFuNERtV2pYb1B0eVVDUjM1UGIwTFM0U2VN?=
 =?utf-8?B?bHBiWkR6ZkV1MU0yVnUxdHJ4U3kxRXRWeXJTMU92SDc3VEFCWVVtM2RxYnRB?=
 =?utf-8?B?cW41TE9OSnRQdVFzVWRvM0EvT2dNTzUvaGpOb0doZGlUVnJoejZHV2tEbWtq?=
 =?utf-8?B?dTFJNGZ0NXgzaE1vVW1ERlJ4U1JSZSs2NHRualFmVzdxK0tpc0d6WHMzeERY?=
 =?utf-8?B?SE40SHVRcXZQVGp3M0x0UElOMnVucmgwanhFVE1XVnZ5Z2FVc2VzS21hMTYr?=
 =?utf-8?B?TlBLT3NyaXl5YTBYcTF3eXlQeUdZSmJWNEVtNzBkdFBuWXVmUi82Y1JmdFFZ?=
 =?utf-8?B?RkVvSm9VVnhKbkZEbTlJMzQySmZlQlpOeGFJZFRoTkVtWWsvcWNKYTZuajJT?=
 =?utf-8?B?ajZLUVE3VEVwNjVucG1WOWFjMnFUUWVVK0dRM2haaFJtTU5tS3ZoaEFKZ3ZU?=
 =?utf-8?B?bWt1VUJFMjRrTnVLbjZoYWJlOTJRWnoyVDUzTjNIbU5XYS9wbWJKcGpyaWkz?=
 =?utf-8?B?SjJya1N1TWIrcXNDdXJ4VGFZTVFVc1d1NWV2ejMzUlh2bDkxK2pEWFFncHQ1?=
 =?utf-8?B?b0h2TEhDQnYrb2laZk02YWhTOGxDdE5hMEZQOGdyYkQ3WndQc2pyWVc2Um5s?=
 =?utf-8?B?b2JmQVBFdEp3Q3U1RC9uekxoTk00RFpITy9zVUtiRkpmSDhvOEh0OEdXdlQ5?=
 =?utf-8?B?OElPc1lGZElvc21qenloRkxUbkF3cTliRG9Oem5TUHhhZ0l5K091eHNnSldv?=
 =?utf-8?B?bFJ3VkRnSmVndkhqVEJwb1ZCV2R2K21ZdVlVT3ZBeEMrMFAzUzBkUmF0c0VC?=
 =?utf-8?B?OG40N0tycU1LR1NIVzRTYkNQa0VMdFdPYVh4S0JRMnVLT2RvN21PR2ZyUTdw?=
 =?utf-8?B?cmlQYzBLT2psS0srRUlZWDN1cW44S3o3cjFVSC9PT09zQlpEd09PQTNISkE5?=
 =?utf-8?B?UXYrUFBvL1VGZEJERGdEY1VVdGZ1SWlGTEloeDBYSDU4Zks5Mk52MHMyNllX?=
 =?utf-8?B?NVdPNWg1YzJLL1JmazlzTlBmSFI3SVNzWDlVOWhDYWhSaUJsaGhjRFFNS1cv?=
 =?utf-8?B?Zk9rdmEzWkdRb0JPUTVlYUhBWkhHdVRMMmljYUtYN0JzakdDcGpuRnQzSm43?=
 =?utf-8?B?WEZReEZybHlQTXdtSTRRNFl6MXdtUXRxeU1nWGI5bUZhTEIxT09CdnBRdWNN?=
 =?utf-8?B?dFpkWCs2dXM4YjR3OTVaZlBXQWVreFhzUE5xZStORDFDeE5tU1hzUnBTOGtk?=
 =?utf-8?B?b05DRTdLNVpmQlBzSDl2UDhKYlRpbmRXS3lGWERRSWo4bTJoalE2cGhoYkMw?=
 =?utf-8?B?SmxuelZja01RVFpGNSt3Mjh4UHhrTVRXOUNXRG4yWUNvb1QycFZCZEVFTHVq?=
 =?utf-8?B?VWRGdUZLWjNTSTdQeW12SU9wY21pWGtOVTROeitWMHE4NVh0bzBuNXNBcjJB?=
 =?utf-8?B?cjIyZGtmZjM1ZGk1MGxEaC9MMUU4enZUMFlhdm13VWoxVlAvV2dJYzVJbHBx?=
 =?utf-8?B?cHlxSEF0cVc5MnRvd01aSnlSUUtpengvc2hxRkFHTmY3N2xlRzQ4c0V1MUZ4?=
 =?utf-8?B?eXFXRGpnVVR6SWc1OWp1LzREWm80S0NYeG5rbVRZZkNlTVY0MkVGZlhsYUNY?=
 =?utf-8?B?WXBaNDJlMW5tMXdMY2M4RVBJUytycXdFTDBVdU5ISkdoRU5PMExWL1pMV0tD?=
 =?utf-8?Q?jmMg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a75f1a8-738a-4824-44c2-08da5a07005e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 19:38:54.3170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q9vBT5HO7+N1nlb3ZEr4k8rJ0RbPJrNnD1lKv1mZngkZG3ND7QE6jesYDtN3VCBg7ItlUpK05R3c0tReRMNhjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1806
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9y
Zz4NCj4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDI5LCAyMDIyIDE0OjA5DQo+IFRvOiBMaW1vbmNp
ZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+DQo+IENjOiBSYWZhZWwgSi4g
V3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+OyBMZW4gQnJvd24gPGxlbmJAa2VybmVsLm9yZz47
DQo+IFBpZXJyZSBHb25kb2lzIDxwaWVycmUuZ29uZG9pc0Bhcm0uY29tPjsgU3VkZWVwIEhvbGxh
DQo+IDxzdWRlZXAuaG9sbGFAYXJtLmNvbT47IFl1YW4sIFBlcnJ5IDxQZXJyeS5ZdWFuQGFtZC5j
b20+OyBBQ1BJIERldmVsDQo+IE1hbGluZyBMaXN0IDxsaW51eC1hY3BpQHZnZXIua2VybmVsLm9y
Zz47IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QgPGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJu
ZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBBQ1BJOiBDUFBDOiBEb24ndCByZXF1aXJl
IF9PU0MgaWYgWDg2X0ZFQVRVUkVfQ1BQQyBpcw0KPiBzdXBwb3J0ZWQNCj4gDQo+IE9uIFdlZCwg
SnVuIDI5LCAyMDIyIGF0IDg6NDkgUE0gTGltb25jaWVsbG8sIE1hcmlvDQo+IDxNYXJpby5MaW1v
bmNpZWxsb0BhbWQuY29tPiB3cm90ZToNCj4gPg0KPiA+IFtQdWJsaWNdDQo+ID4NCj4gPg0KPiA+
DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogUmFmYWVsIEou
IFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiA+ID4gU2VudDogV2VkbmVzZGF5LCBKdW5l
IDI5LCAyMDIyIDEzOjQyDQo+ID4gPiBUbzogTGltb25jaWVsbG8sIE1hcmlvIDxNYXJpby5MaW1v
bmNpZWxsb0BhbWQuY29tPg0KPiA+ID4gQ2M6IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2Vy
bmVsLm9yZz47IExlbiBCcm93biA8bGVuYkBrZXJuZWwub3JnPjsNCj4gPiA+IFBpZXJyZSBHb25k
b2lzIDxwaWVycmUuZ29uZG9pc0Bhcm0uY29tPjsgU3VkZWVwIEhvbGxhDQo+ID4gPiA8c3VkZWVw
LmhvbGxhQGFybS5jb20+OyBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29tPjsgQUNQSSBE
ZXZlbA0KPiA+ID4gTWFsaW5nIExpc3QgPGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnPjsgTGlu
dXggS2VybmVsIE1haWxpbmcgTGlzdCA8bGludXgtDQo+ID4gPiBrZXJuZWxAdmdlci5rZXJuZWwu
b3JnPg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gQUNQSTogQ1BQQzogRG9uJ3QgcmVxdWly
ZSBfT1NDIGlmIFg4Nl9GRUFUVVJFX0NQUEMNCj4gaXMNCj4gPiA+IHN1cHBvcnRlZA0KPiA+ID4N
Cj4gPiA+IE9uIE1vbiwgSnVuIDI3LCAyMDIyIGF0IDY6NTggUE0gTWFyaW8gTGltb25jaWVsbG8N
Cj4gPiA+IDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+
ID4gY29tbWl0IDcyZjJlY2I3ZWNlNyAoIkFDUEk6IGJ1czogU2V0IENQUEMgX09TQyBiaXRzIGZv
ciBhbGwgYW5kDQo+ID4gPiA+IHdoZW4gQ1BQQ19MSUIgaXMgc3VwcG9ydGVkIikgYWRkZWQgc3Vw
cG9ydCBmb3IgY2xhaW1pbmcgdG8NCj4gPiA+ID4gc3VwcG9ydCBDUFBDIGluIF9PU0Mgb24gbm9u
LUludGVsIHBsYXRmb3Jtcy4NCj4gPiA+ID4NCj4gPiA+ID4gVGhpcyB1bmZvcnR1bmF0ZWx5IGNh
dXNlZCBhIHJlZ3Jlc3Npb24gb24gYSB2YXJ0aWV0eSBvZiBBTUQNCj4gPiA+ID4gcGxhdGZvcm1z
IGluIHRoZSBmaWVsZCBiZWNhdXNlIGEgbnVtYmVyIG9mIEFNRCBwbGF0Zm9ybXMgZG9uJ3Qgc2V0
DQo+ID4gPiA+IHRoZSBgX09TQ2AgYml0IDUgb3IgNiB0byBpbmRpY2F0ZSBDUFBDIG9yIENQUEMg
djIgc3VwcG9ydC4NCj4gPiA+ID4NCj4gPiA+ID4gQXMgdGhlc2UgQU1EIHBsYXRmb3JtcyBhbHJl
YWR5IGNsYWltIENQUEMgc3VwcG9ydCB2aWENCj4gYFg4Nl9GRUFUVVJFX0NQUENgLA0KPiA+ID4g
PiB1c2UgdGhpcyBlbmFibGUgdGhpcyBmZWF0dXJlIHJhdGhlciB0aGFuIHJlcXVpcmluZyB0aGUg
YF9PU0NgLg0KPiA+ID4gPg0KPiA+ID4gPiBGaXhlczogNzJmMmVjYjdlY2U3ICgiU2V0IENQUEMg
X09TQyBiaXRzIGZvciBhbGwgYW5kIHdoZW4gQ1BQQ19MSUIgaXMNCj4gPiA+IHN1cHBvcnRlZCIp
DQo+ID4gPiA+IFJlcG9ydGVkLWJ5OiBQZXJyeSBZdWFuIDxwZXJyeS55dWFuQGFtZC5jb20+DQo+
ID4gPiA+IFNpZ25lZC1vZmYtYnk6IE1hcmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1vbmNpZWxs
b0BhbWQuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGRyaXZlcnMvYWNwaS9jcHBjX2FjcGku
YyB8IDEyICsrKysrKysrKy0tLQ0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvYWNwaS9jcHBjX2FjcGkuYyBiL2RyaXZlcnMvYWNwaS9jcHBjX2FjcGkuYw0KPiA+ID4gPiBp
bmRleCA5MDM1MjhmN2UxODcuLjU0NjNlNjMwOWI5YSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJp
dmVycy9hY3BpL2NwcGNfYWNwaS5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvYWNwaS9jcHBjX2Fj
cGkuYw0KPiA+ID4gPiBAQCAtNjI5LDYgKzYyOSwxNSBAQCBzdGF0aWMgYm9vbCBpc19jcHBjX3N1
cHBvcnRlZChpbnQgcmV2aXNpb24sIGludA0KPiA+ID4gbnVtX2VudCkNCj4gPiA+ID4gICAgICAg
ICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gPiA+ID4gICAgICAgICB9DQo+ID4gPiA+DQo+ID4g
PiA+ICsgICAgICAgaWYgKG9zY19zYl9jcHBjX25vdF9zdXBwb3J0ZWQpIHsNCj4gPiA+ID4gKyAg
ICAgICAgICAgICAgIHByX2RlYnVnKCJGaXJtd2FyZSBtaXNzaW5nIF9PU0Mgc3VwcG9ydFxuIik7
DQo+ID4gPiA+ICsjaWZkZWYgQ09ORklHX1g4Ng0KPiA+ID4gPiArICAgICAgICAgICAgICAgcmV0
dXJuIGJvb3RfY3B1X2hhcyhYODZfRkVBVFVSRV9DUFBDKTsNCj4gPiA+ID4gKyNlbHNlDQo+ID4g
PiA+ICsgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4gPiA+ICsjZW5kaWYNCj4gPiA+
DQo+ID4gPiBXaGF0IGFib3V0IGRvaW5nDQo+ID4gPg0KPiA+ID4gaWYgKG9zY19zYl9jcHBjX25v
dF9zdXBwb3J0ZWQpIHsNCj4gPiA+ICAgICAgICAgcHJfZGVidWcoIkZpcm13YXJlIG1pc3Npbmcg
X09TQyBzdXBwb3J0XG4iKTsNCj4gPiA+ICAgICAgICAgcmV0dXJuIElTX0VOQUJMRUQoQ09ORklH
X1g4NikgJiYNCj4gYm9vdF9jcHVfaGFzKFg4Nl9GRUFUVVJFX0NQUEMpOw0KPiA+ID4gfQ0KPiA+
ID4NCj4gPiA+IGluc3RlYWQgZm9yIHRoZSBzYWtlIG9mIHJlZHVjaW5nICNpZmRlZmZlcnk/DQo+
ID4NCj4gPiBJIGRvbid0IHRoaW5rIHRoYXQgd291bGQgY29tcGlsZSBvbiBub24tWDg2LiAgWDg2
X0ZFQVRVUkVfQ1BQQyBjb21lcyBhcw0KPiBwYXJ0IG9mDQo+ID4gYXJjaC94ODYvaW5jbHVkZS9h
c20vY3B1ZmVhdHVyZXMuaCwgd2hpY2ggSSB3b3VsZG4ndCBleHBlY3QgaXMgaW5jbHVkZWQgb24N
Cj4gIXg4Ni4NCj4gDQo+IEdvb2QgcG9pbnQuDQo+IA0KPiBTb21ldGhpbmcgbGlrZSB0aGlzIHdv
dWxkIHN0aWxsIGxvb2sgYmV0dGVyIHRob3VnaCBJTU86DQo+IA0KPiBpZiAoIW9zY19zYl9jcHBj
X25vdF9zdXBwb3J0ZWQpDQo+ICAgICAgICAgcmV0dXJuIHRydWU7DQo+IA0KPiAjaWZkZWYgQ09O
RklHX1g4Ng0KPiAgICAgICAgIHJldHVybiBib290X2NwdV9oYXMoWDg2X0ZFQVRVUkVfQ1BQQyk7
DQo+ICNlbHNlDQo+ICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiAjZW5kaWYNCj4gfQ0KPiANCg0K
VGhhbmtzLCBJJ2xsIHJlc3BpbiBpdCB3aXRoIHNvbWV0aGluZyBzaW1pbGFyIHRvIHRoYXQuDQoN
Cj4gDQo+ID4NCj4gPiA+DQo+ID4gPiBBbHNvLCB0aGlzIGlzIHNvbWV3aGF0IHJpc2t5LCBiZWNh
dXNlIGV2ZW4gaWYgdGhlIGdpdmVuIHByb2Nlc3NvciBoYXMNCj4gPiA+IFg4Nl9GRUFUVVJFX0NQ
UEMgc2V0LCB0aGUgcGxhdGZvcm0gbWF5IHN0aWxsIG5vdCB3YW50IHRvIGV4cG9zZSBDUFBDDQo+
ID4gPiB0aHJvdWdoIEFDUEkuICBIb3cncyB0aGF0IGdvaW5nIHRvIHdvcmsgYWZ0ZXIgdGhpcyBj
aGFuZ2U/DQo+ID4gPg0KPiA+DQo+ID4gV2VsbCBhY3R1YWxseSBkb2luZyB0aGF0IHRocm91Z2gg
X09TQyB3b3VsZG4ndCBoYXZlIHdvcmtlZCBiZWZvcmUNCj4gNzJmMmVjYjdlY2U3IGVpdGhlci4N
Cj4gPiBJZiBkZXNpcmFibGUgLSBhIHBsYXRmb3JtIGNvdWxkIGF2b2lkIHBvcHVsYXRpbmcgX0NQ
QyBvYmplY3RzIGluIEFDUEkgdGFibGVzIGluDQo+IHRoaXMgY2FzZS4NCj4gPg0KPiA+IEkgZG8g
a25vdyBvZiBPRU0gcGxhdGZvcm1zIHRoYXQgdGhlIHVuZGVybHlpbmcgQVBVIHN1cHBvcnRzIENQ
UEMgYnV0IHRoZQ0KPiBPRU0gZG9lc24ndA0KPiA+IHBvcHVsYXRlIF9DUEMuICBQcmVzdW1hYmx5
IGZvciB0aGlzIGV4YWN0IHJlYXNvbi4NCj4gDQo+IFRoYXQgaXMgYW4gb3B0aW9uLCBidXQgdGhl
cmUgaXMgbm8gcmVxdWlyZW1lbnQgdGhhdCBfQ1BDIG11c3Qgbm90IGJlDQo+IHBvcHVsYXRlZCB3
aGVuIENQUEMgaXMgbm90IHN1cHBvcnRlZC4NCj4gDQo+IF9PU0MgaXMgdGhlIHByb3BlciBtZWNo
YW5pc20gZm9yIG5lZ290aWF0aW5nIENQUEMgc3VwcG9ydC4NCj4gDQoNClJpZ2h0OyBJIGFncmVl
IHRoaXMgc2hvdWxkIGhhdmUgYmVlbiB0aGUgcHJvcGVyIG1lY2hhbmlzbS4gIEknbGwgdGFsayB0
bw0Kb3VyIGludGVybmFsIEJJT1MgdGVhbSB0byBkb3VibGUgY2hlY2sgcmVmZXJlbmNlIEJJT1Mg
aXMgcG9wdWxhdGVkDQp3aXRoIHRoaXMgY29ycmVjdGx5IGZvciBwcm9ncmFtcyBnb2luZyBmb3J3
YXJkIHRvby4NCg0KPiBTdGlsbCwgaWYgeW91IGtub3cgZm9yIGEgZmFjdCB0aGF0IG9uIEFNRCBz
eXN0ZW1zIFg4Nl9GRUFUVVJFX0NQUEMNCj4gYWx3YXlzIG1lYW5zIHRoYXQgQ1BQQyBpcyBzdXBw
b3J0ZWQsIEkgY2FuIGxpdmUgd2l0aCBhbiBleHRyYSB2ZW5kb3INCj4gY2hlY2sgaW4gdGhlIGNv
ZGUgYWJvdmUuDQoNClRoYW5rcy4gIFRoZSBkZWZpbml0aW9uIG9mIHRoYXQgQ1BVSUQgODAwMF8w
MDA4IEVCWCBiaXQgMjcgdXNlZA0KdG8gcG9wdWxhdGUgWDg2X0ZFQVRVUkVfQ1BQQyBpbmRpY2F0
ZXMgd2hldGhlciB0aGUgQ1BVL0FQVQ0Kc3VwcG9ydHMgdGhlIGRlZGljYXRlZCBNU1IuICBUaGVy
ZSBhcmUgYWxzbyB0ZWNobmljYWxseSBkZXNpZ25zIHRoYXQgY2FuDQp3b3JrIGluIHNoYXJlZCBt
ZW1vcnkgbW9kZSB0aGF0IEkgdGhpbmsgdGhlIG9ubHkgd2F5IHRvICJzYWZlbHkiIGRpc2NvdmVy
DQp3aWxsIGJlIHZpYSB0aGUgX09TQy4gIElmIHRoaXMgc2FtZSByZWdyZXNzaW9uIGZyb20gNzJm
MmVjYjdlY2U3IGNyb3BzIHVwDQpvbiB0aG9zZSB3ZSBtaWdodCBuZWVkIHRvIGxvb2sgYXQgY2hh
bmdpbmcgdGhlIGFtZC1wc3RhdGUgbW9kdWxlIHBhcmFtZXRlcg0Kb3ZlcnJpZGUgdGhhdCBlbmFi
bGVzIGl0IGZvciBzaGFyZWQgbWVtb3J5IGludG8gYSBnZW5lcmFsIGtlcm5lbCBjb21tYW5kIGxp
bmUNCm92ZXJyaWRlIGZvciB1c2VycyB0byB1c2UuDQo=
