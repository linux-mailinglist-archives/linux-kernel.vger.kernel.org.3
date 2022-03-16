Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37504DB8DA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 20:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240637AbiCPT0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 15:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235316AbiCPT02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 15:26:28 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2056.outbound.protection.outlook.com [40.107.95.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C712633E93;
        Wed, 16 Mar 2022 12:25:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjKNl7n/inhDYgujjnebzFrIshXq17MRXQ8KzH8wCILcbvHSf1gLq2dZ6EexlirP5c8jrS3yrykya/+PA4ntbXxYuigt8hk3wiakOpXR4cN6oKBYa7UD+R7bKOvt7bww9kSMu/gwqennejK+w/jGwqVpWXwMOBzcIx15ejDajjNCH5ItWwNs7jxB5jedhro7HwzBkzCLhGOZ/c0o3Lme7jph5GHg+UcVYAgV8lIIccJ3yoAh/W6Q8iGvFRrJfGLI8yURwfKgCtNGAtfBZotXmUOlg3lpcnR2mG6cJPftSHXWO0cVrGok1WP9zajDLksNOp3MrvGNinYzbefjilIicA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVO+1mLqbsQXtfL4j3c3V0QqUTw5KjW4VhpH8IfAG7Y=;
 b=Dp/CveDIjzA4cqszpvc237hjZRUZwGcoIMxYDnbJ4OBAN4iTyotYXDAHUnv+V65fQAz5ouuYVzHVgOHuu8Ld4844XcYu6F7Qn4XvZZzxR4o9v77o59e0pua0gay/U3xnMVqrbEsMzAj70b9kBMN0+g6cSusVEH3wDT5SBy7ioEMhWFhhBCf7l+j8AvGSwIF6zbRK9zH9NJNrx9aVQaQqDjdXBUXjX27m1eTXsruqeDT/gEn5zINXeFpdNXsoUAlpFqkYU6geR/CiMFJChMsmATTWdyUMyWw6YC8gNMmHXA+hbyz3xDd5VbeiI6vCucOxZvWRPwIeMl1PyivgfQke0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVO+1mLqbsQXtfL4j3c3V0QqUTw5KjW4VhpH8IfAG7Y=;
 b=qsBSVy4KWRA0ScmFpAmKRGYjtNDk1EXGvtLJGGBdU4UlYsdjBp8xReAG0P1XsVgnwfuheoHdRIxqa24XGDyTH7jVmQpsjGf8SFdjHIa17DrYZ+WztDXmzdKRnPFE/DXJehGQ/PsP5kA2VglEXVwQfnCASwR5kFt0U3l1ZljhHN4=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 19:25:09 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 19:25:09 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     "michael.jamet@intel.com" <michael.jamet@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
        "hch@lst.de" <hch@lst.de>
Subject: RE: [PATCH] thunderbolt: Stop using iommu_present()
Thread-Topic: [PATCH] thunderbolt: Stop using iommu_present()
Thread-Index: AQHYOSidJZwMFUwbGEibeELZIyT74azB9QiAgAAiooCAACnRgIAAAPcAgAAEJICAAANtgIAAAECwgAAI+YCAAALbUIAADK2AgAABHGA=
Date:   Wed, 16 Mar 2022 19:25:09 +0000
Message-ID: <BL1PR12MB5157244DC83C6A776D0CDB87E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <b4356b228db9cb88d12db6559e28714ce26e022e.1647429348.git.robin.murphy@arm.com>
 <YjHb1xCx4UAmUjrR@lahna> <16852eb2-98bb-6337-741f-8c2f06418b08@arm.com>
 <YjIb+XOGZbWKpQDa@lahna>
 <BL1PR12MB515762E68F3A48A97EB2DC89E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <YjIgQfmcw6fydkXd@lahna> <3bb6a2f8-005b-587a-7d7a-7a9a5391ec05@arm.com>
 <BL1PR12MB5157DA58C3BDAFB5736676F6E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <5ef1c30a-1740-00cc-ad16-4b1c1b02fca4@arm.com>
 <BL1PR12MB5157380CD6FD9EB83E76CBB0E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <0709e994-1c8b-56fe-7743-8fdbf3ba748b@arm.com>
In-Reply-To: <0709e994-1c8b-56fe-7743-8fdbf3ba748b@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-16T19:24:38Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=db2a2392-134f-4c1c-8906-6880a47ac160;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-16T19:25:07Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 56c220f8-3691-4a4a-bd59-cf8d2f8f0cbc
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e8905d2-de59-43bb-f164-08da0782af32
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_
x-microsoft-antispam-prvs: <MW3PR12MB455318D8344D07C399618CA3E2119@MW3PR12MB4553.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GNoVoLYW1nv2FlJyqAXVk0fulx/otVXyZunLIhKuC2yJknkXoK8ABnG9598BTN1MsUf6aKXqxQ3g8xdwg55ACgm2C9HULIiQUARpEGVLaGKg/EawaIfXgSZ97JcR/OPSAiFi9kVvbQzauOXJ77I0ouMN4aJgYnhVd4ikExCd/VOrw1H6qBGZO4x5SzOlzL7WZfgoCDBeNvyqmmPX4yvvLGxxyrxQv4Pg7Vw3PWJ1E3u5MFOMkcjAWRTCyWLzoc3gAjzgih+/djoCOXURi2jVPiuklEN6TOVY5TL0PtOgEY615Usgo6KjZJHGjUGvDNLticrkYCCy10qM4J3vm+K5ckWF3zHh8TL4qHDWqL3XDdSTS07LucMOxPQ74iLKDUrXzZxe0rIr5Pv/Hujp0GlXu0+X6RWuy1eVH3V/B/TU9iG7Z9AbuZ1vBVzbunWLyZ3v9XOA+E5VCSXCiVMR+UMNpwCAuZ/e7HHcr/z1AKvv4RhvhcmY2KTeHgpC5Sxsev5y6tZAcVSr204uCFWUfisC+vZLIbZjfZMptF2POPzW0VJ4dlzuQPa4ACsqRGijn2QRz8feuLXVePIQY0dpHQQzWaC9q2HP+LAqmfqUw+/1aNWR1VpRmTZNQbV3RTsiwgzfyUSfJcXMPYPkKpDrFpoTTJO1DE2qcI34B1AWuZBFNGg5mY42/TMNLm2xHNBDBXssBjtVf6jL8wAzL9JbtSrMCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(45080400002)(508600001)(38070700005)(55016003)(8936002)(33656002)(83380400001)(5660300002)(2906002)(64756008)(122000001)(66446008)(66476007)(8676002)(66556008)(86362001)(110136005)(186003)(4326008)(66946007)(54906003)(316002)(76116006)(52536014)(9686003)(71200400001)(53546011)(38100700002)(6506007)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkVQTlhoM294VDBPeUs2a2I0NmNMRFkxR3YzT0EvNER5Mnp6VURkVWZQejBm?=
 =?utf-8?B?dmUxb25NMkFMWnJSUGNUcUdsWDE4Nmg3NGRBM1hiblZrUFFXcnZnSFFuZGFj?=
 =?utf-8?B?S0g3L1IvSVRaYzJWU2pXdmNJSEZ4azZudVl2Sit1L3FhbkZDR0JwUVk4b1Z0?=
 =?utf-8?B?dm01R09hNjFjNE03SnNQUHFTMmY5WHFnNWdBc2lZUFBHNVpnbDd6S0tNVDND?=
 =?utf-8?B?d3QybXRvMWxIdXZhckljaVB5aUdMekdXaWlOVHR0cXppK1ZwZU9Gb1h2L01G?=
 =?utf-8?B?SmpXcE9nSFNsZXhaNWFGQTdiT3FUMnR0MCtZU2JianFWanBDaEJUeVpmeFNE?=
 =?utf-8?B?MjZHV09NS2VnOUl4WWlSTEtLZ1pxT3puZWtYSVNKSHlEMzBFb2VadlBjcjJP?=
 =?utf-8?B?cXZoeTlkeXk0b3NQeFRZVExZbk56dVVKN3VNeDhaazRsR1hwRDZ4ZXhvWkFY?=
 =?utf-8?B?eUM3a1ExcTJmSWppejk4dTZUSVVMVS9MZFNEbENoQ3UyNUVYTmlsMXI0blFr?=
 =?utf-8?B?QU5pdXcrNjVuemszNHJGWUdQcit5ZEh0UmpORmhoVFUydUZmMEpTYUYzMUY1?=
 =?utf-8?B?SVNBelQrQ0VhRnhCdTNkT3dhRE56aUNGQlAxeUlKRjJDWUNHdDY1ZFNzVUgy?=
 =?utf-8?B?WnBIakFxb01vTWVxWEp1cTZUQUJhdDFGWEVnOTQzeElPaGFxSmJHWVYxZ01u?=
 =?utf-8?B?dURnU1FHcXFEcXl6VzNrcE5CQnFsaDlPMldRT1Y1MUlDK1hpMUtwc2ZmbThy?=
 =?utf-8?B?QzBVRTlGVjh3eCs5ZmxOOHdVeUJzVVEyYTNnUWlUc2FrTUMyNFhQZXpqdnAw?=
 =?utf-8?B?U2NtQjVlUWVBdTU2K1NPbkRLdVdUWVQ2elo5YU5oMGQ0Y3lFVVVWMmtIejZr?=
 =?utf-8?B?UGcvWjNOc2laV0E5aEVPekRPVEJ2TkdNQUc1ZVZmdTRPdmlPQ28xTlVrUlNY?=
 =?utf-8?B?QldpQ2hYTW9mKzFWUEpVbS9LUnVVYlNmbngrSGNXM1N5dFZsQ2lQWndtWDFC?=
 =?utf-8?B?M1FOWEdacjhBT1A4cS9SdU12UXl2cVBVYzZjTUloVWNyc0E2R2o4dlRiZGpN?=
 =?utf-8?B?UGV4M1RtdXRSRjVJRHlNd1U4UlIxUjRmLzVoKzBOZitGKzFQL3ZjM0dyTVUy?=
 =?utf-8?B?YzVIOUtDbVVweEx1a0Zycm9VaWs3cTJqN0hzT29hS21vdWp2UWxZMEdseGw5?=
 =?utf-8?B?RUdiTWUxVWpWNld6WmkwUmJMZW9aYzQxb0dSZWY1c253d0x0cDRhQSt5cm1J?=
 =?utf-8?B?eUk2RUpCU1dYR2IzcGpWWXNESmlWdU5ZMDRRYThHd0tCNmV0Sm9aeXBnTnI4?=
 =?utf-8?B?ZjFabnhXTWk4Y0V1dXI1TkxHYURKOHVmQ0JoVURUZjF5YlErUGxlNnpXN2Vi?=
 =?utf-8?B?clluU3dPeWpnQ3c1M1NyYkt5WW5Pb0I2T045S3EzdWs2MElBTnNLeGtqZkRr?=
 =?utf-8?B?WkgwVUZHTnpvTmNSTHM3bzFSeCtRNllCcnJRSDZUbU4zT1hES1NoKzFoQW1L?=
 =?utf-8?B?bGRpamxlcVFCNnk0aUNXMzZMRmlCYVNhUk1pZWVMQnNTT2NyUWhiMXNNMlZ4?=
 =?utf-8?B?RDBWVEFoK3JKMTlmaGM0RnZVYkdIT1BSYTVCSG4wWHZxTTZKQlE4N3BUUGJo?=
 =?utf-8?B?Zi95M3FCWitRNEoxN0dQUFNqSkJsdm5JOVZjRldYTDZjNllJSUlRbVBPcGJE?=
 =?utf-8?B?eXd6bHk0bEFIajhWMTU4a3NaNjZST2F6TnV5ZkxuRjMrZHl5clZUT0xiVTYy?=
 =?utf-8?B?MnYyUFVuZnJiTytYZGNobUIwa2FmRHduRVd6S0FmZEJHaGZzUUhKY0tMK1hn?=
 =?utf-8?B?YU05ZjlIVzRqNnVlOWVoVzdBNHAxa2JOdEZPaUhpUmV2U2pTQXNqYTRLS1RJ?=
 =?utf-8?B?L3VlNm9WUXhXMHhCZEZwNlZXdUJCZlZrZ0NLRDFZVVIrN2plVWpaZ2t0RHZw?=
 =?utf-8?B?aFVXSm54Rk1xZWhhSitjOGZKaU9VWkplSmsvWDNCQUxlSThTcHJhVnVZS051?=
 =?utf-8?B?c1JQTThVSFlxcjY3QlJaRVVkeDZ5TklYMTVpNE51OFYxeGhXdm53VzBvNmtW?=
 =?utf-8?Q?mqJu9w?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8905d2-de59-43bb-f164-08da0782af32
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 19:25:09.1861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kSsSJqdsHtBqnMmzuJrIrfO7Hv1DCFG3C5EOZ0w3H2TaveH8ITTEXxLG92ocRhxO9oiF9RzgALgnfMbvi/AK0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4553
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9i
aW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXJj
aCAxNiwgMjAyMiAxNDoxOA0KPiBUbzogTGltb25jaWVsbG8sIE1hcmlvIDxNYXJpby5MaW1vbmNp
ZWxsb0BhbWQuY29tPjsgTWlrYSBXZXN0ZXJiZXJnDQo+IDxtaWthLndlc3RlcmJlcmdAbGludXgu
aW50ZWwuY29tPg0KPiBDYzogbWljaGFlbC5qYW1ldEBpbnRlbC5jb207IGxpbnV4LXVzYkB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBZZWhlemtlbFNo
QkBnbWFpbC5jb207IGlvbW11QGxpc3RzLmxpbnV4LQ0KPiBmb3VuZGF0aW9uLm9yZzsgYW5kcmVh
cy5ub2V2ZXJAZ21haWwuY29tOyBoY2hAbHN0LmRlDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHRo
dW5kZXJib2x0OiBTdG9wIHVzaW5nIGlvbW11X3ByZXNlbnQoKQ0KPiANCj4gT24gMjAyMi0wMy0x
NiAxODozNCwgTGltb25jaWVsbG8sIE1hcmlvIHdyb3RlOg0KPiA+IFtQdWJsaWNdDQo+ID4NCj4g
Pj4+IENhbiB0aGUgVVNCNCBDTSBtYWtlIHRoZSBkZXZpY2UgbGlua3MgaW4gdGhlIERWU0VDIGNh
c2UgcGVyaGFwcyB0b28/DQo+IEkNCj4gPj4gd291bGQNCj4gPj4+IHRoaW5rIHdlIHdhbnQgdGhh
dCBhbnl3YXkgdG8gY29udHJvbCBkZXZpY2Ugc3VzcGVuZCBvcmRlcmluZy4NCj4gPj4+DQo+ID4+
PiBJZiBJIGhhZCBzb21ldGhpbmcgZGlzY3JldGUgdG8gdHJ5IEknZCBkdXN0IG9mZiB0aGUgRFZT
RUMgcGF0Y2ggSSB3cm90ZQ0KPiA+PiBiZWZvcmUgdG8NCj4gPj4+IHRyeSBpdCwgYnV0IGFsYXMg
YWxsIEkgaGF2ZSBpcyBpbnRlZ3JhdGVkIHN0dWZmIG9uIG15IGhhbmQuDQo+ID4+Pg0KPiA+Pj4+
Pj4gTWlrYSwgeW91IG1pZ2h0IG5vdCBoYXZlIHNlZW4gaXQgeWV0LCBidXQgSSBzZW50IGEgZm9s
bG93IHVwIGRpZmYgaW4NCj4gdGhpcw0KPiA+Pj4+IHRocmVhZA0KPiA+Pj4+Pj4gdG8gUm9iaW4n
cyBwYXRjaC4gIElmIHRoYXQgbG9va3MgZ29vZCBSb2JpbiBjYW4gc3VibWl0IGEgdjIgKG9yIEkn
bQ0KPiBoYXBweQ0KPiA+PiB0bw0KPiA+Pj4+IGRvDQo+ID4+Pj4+PiBzbyBhcyB3ZWxsIGFzIEkg
Y29uZmlybWVkIGl0IGhlbHBzIG15IG9yaWdpbmFsIGludGVudCB0b28pLg0KPiA+Pj4+Pg0KPiA+
Pj4+PiBJIHNhdyBpdCBub3cgYW5kIEknbSB0aGlua2luZyBhcmUgd2UgbWFraW5nIHRoaXMgdW5u
ZWNlc3NhcnkNCj4gY29tcGxleD8gSQ0KPiA+Pj4+PiBtZWFuIE1pY3Jvc29mdCBzb2xlbHkgZGVw
ZW5kcyBvbiB0aGUgRE1BUiBwbGF0Zm9ybSBvcHQtaW4gZmxhZzoNCj4gPj4+Pj4NCj4gPj4+Pj4N
Cj4gPj4+Pg0KPiA+Pj4NCj4gPj4+IEkgdGhpbmsgTWljcm9zb2Z0IGRvZXNuJ3QgYWxsb3cgeW91
IHRvIHR1cm4gb2ZmIHRoZSBJT01NVSB0aG91Z2ggb3IgcHV0DQo+IGl0DQo+ID4+IGluDQo+ID4+
PiBwYXNzdGhyb3VnaCB0aHJvdWdoIG9uIHRoZSBrZXJuZWwgY29tbWFuZCBsaW5lLg0KPiA+Pj4N
Cj4gPj4+Pj4gV2UgYWxzbyBkbyB0dXJuIG9uIGZ1bGwgSU9NTVUgbWFwcGluZ3MgaW4gdGhhdCBj
YXNlIGZvciBkZXZpY2VzIHRoYXQNCj4gPj4gYXJlDQo+ID4+Pj4+IG1hcmtlZCBhcyBleHRlcm5h
bCBmYWNpbmcgYnkgdGhlIHNhbWUgZmlybXdhcmUgdGhhdCBwcm92aWRlZCB0aGUNCj4gPj4gRE1B
Ug0KPiA+Pj4+PiBiaXQuIElmIHRoZSB1c2VyIGRlY2lkZXMgdG8gZGlzYWJsZSBJT01NVSBmcm9t
IGNvbW1hbmQgbGluZSBmb3INCj4gPj4gaW5zdGFuY2UNCj4gPj4+Pj4gdGhlbiB3ZSBleHBlY3Qg
c2hlIGtub3dzIHdoYXQgc2hlIGlzIGRvaW5nLg0KPiA+Pj4+DQo+ID4+Pj4gWWVhaCwgaWYgZXh0
ZXJuYWxfZmFjaW5nIGlzIHNldCBjb3JyZWN0bHkgdGhlbiB3ZSBjYW4gc2FmZWx5IGV4cGVjdCB0
aGUNCj4gPj4+PiB0aGUgSU9NTVUgbGF5ZXIgdG8gZG8gdGhlIHJpZ2h0IHRoaW5nLCBzbyBpbiB0
aGF0IGNhc2UgaXQgcHJvYmFibHkgaXMgT0sNCj4gPj4+PiB0byBpbmZlciB0aGF0IGlmIGFuIElP
TU1VIGlzIHByZXNlbnQgZm9yIHRoZSBOSEkgdGhlbiBpdCdsbCBiZSBtYW5hZ2luZw0KPiA+Pj4+
IHRoYXQgd2hvbGUgYnVzIGhpZXJhcmNoeS4gV2hhdCBJJ20gcmVhbGx5IHRoaW5raW5nIGFib3V0
IGhlcmUgaXMNCj4gd2hldGhlcg0KPiA+Pj4+IHdlIGNhbiBkZWZlbmQgYWdhaW5zdCBhIGNhc2Ug
d2hlbiBleHRlcm5hbF9mYWNpbmcgKmlzbid0KiBzZXQsIHNvIHdlDQo+ID4+Pj4gdHJlYXQgdGhl
IHR1bm5lbGxlZCBwb3J0cyBhcyBub3JtYWwgUENJIGJ1c2VzLCBhc3N1bWUgaXQncyBPSyBzaW5j
ZQ0KPiA+Pj4+IHdlJ3ZlIGdvdCBhbiBJT01NVSBhbmQgZXZlcnl0aGluZyBlbHNlIGlzIGdldHRp
bmcgdHJhbnNsYXRpb24gZG9tYWlucw0KPiA+PiBieQ0KPiA+Pj4+IGRlZmF1bHQsIGJ1dCB0aGVu
IGEgVGh1bmRlcmJvbHQgZGV2aWNlIHNob3dzIHVwIG1hc3F1ZXJhZGluZyB0aGUNCj4gPj4gVklE
OkRJRA0KPiA+Pj4+IG9mIHNvbWV0aGluZyB0aGF0IGdldHMgYSBwYXNzdGhyb3VnaCBxdWlyaywg
YW5kIHRodXMgdHJpY2tzIGl0cyB3YXkNCj4gPj4+PiB0aHJvdWdoIHRoZSBwZXJjZWl2ZWQgcHJv
dGVjdGlvbi4NCj4gPj4+Pg0KPiA+Pj4+IFJvYmluLg0KPiA+Pj4NCj4gPj4+IFVubGVzcyBpdCBo
YXBwZW5lZCBhZnRlciA1LjE3LXJjOCBsb29raW5nIGF0IHRoZSBjb2RlIEkgdGhpbmsgdGhhdCdz
IEludGVsDQo+ID4+PiBzcGVjaWZpYyBiZWhhdmlvciB0aG91Z2ggYXQgdGhlIG1vbWVudCAoaGFz
X2V4dGVybmFsX3BjaSkuICBJIGRvbid0IHNlZQ0KPiBpdA0KPiA+Pj4gaW4gYSBnZW5lcmljIGxh
eWVyLg0KPiA+Pg0KPiA+PiBBaCwgaXQncyBub3QgbmVjZXNzYXJpbHkgdGhlIG1vc3Qgb2J2aW91
cyB0aGluZyAtDQo+ID4+IHBjaV9kZXYtPmV4dGVybmFsX2ZhY2luZyBnZXRzIHByb3BhZ2F0ZWQg
dGhyb3VnaCB0byBwY2lfZGV2LQ0KPiA+dW50cnVzdGVkDQo+ID4+IGJ5IHNldF9wY2llX3VudHJ1
c3RlZCgpLCBhbmQgaXQncyB0aGF0IHRoYXQncyB0aGVuIGNoZWNrZWQgYnkNCj4gPj4gaW9tbXVf
Z2V0X2RlZl9kb21haW5fdHlwZSgpIHRvIGVuZm9yY2UgYSB0cmFuc2xhdGlvbiBkb21haW4NCj4g
cmVnYXJkbGVzcw0KPiA+PiBvZiBkZWZhdWx0IHBhc3N0aHJvdWdoIG9yIHF1aXJrcy4gSXQncyB0
aGVuIGZ1cnRoZXIgY2hlY2tlZCBieQ0KPiA+PiBpb21tdS1kbWEncyBkZXZfaXNfdW50cnVzdGVk
KCkgdG8gZW5mb3JjZSBib3VuY2UtYnVmZmVyaW5nIHRvIGF2b2lkDQo+IGRhdGENCj4gPj4gbGVh
a2FnZSBpbiBzdWItcGFnZSBtYXBwaW5ncyB0b28uDQo+ID4+DQo+ID4NCj4gPiBBaCB0aGFua3Mg
Zm9yIGV4cGxhaW5pbmcgaXQsIHRoYXQgd2FzIGltbWVkaWF0ZWx5IG9idmlvdXMgdG8gbWUuDQo+
ID4NCj4gPj4+IEluIGFkZGl0aW9uIHRvIHRoZSBwb2ludCBSb2JpbiBzYWlkIGFib3V0IGZpcm13
YXJlIG5vdCBzZXR0aW5nIGV4dGVybmFsDQo+ID4+IGZhY2luZw0KPiA+Pj4gaWYgdGhlIElPTU1V
IHdhcyBkaXNhYmxlZCBvbiBjb21tYW5kIGxpbmUgdGhlbg0KPiBpb21tdV9kbWFfcHJvdGVjdGlv
bg0KPiA+Pj4gd291bGQgYmUgc2hvd2luZyB0aGUgd3JvbmcgdmFsdWVzIG1lYW5pbmcgdXNlcnNw
YWNlIG1heSBjaG9vc2UgdG8NCj4gPj4+IGF1dGhvcml6ZSB0aGUgZGV2aWNlIGF1dG9tYXRpY2Fs
bHkgaW4gYSBwb3RlbnRpYWxseSB1bnNhZmUgc2NlbmFyaW8uDQo+ID4+Pg0KPiA+Pj4gRXZlbiBp
ZiB0aGUgdXNlciAia25ldyB3aGF0IHRoZXkgd2VyZSBkb2luZyIsIEkgd291bGQgZXhwZWN0IHRo
YXQgd2UNCj4gc3RpbGwNCj4gPj4+IGRvIG91ciBiZXN0IHRvIHByb3RlY3QgdGhlbSBmcm9tIHRo
ZW1zZWx2ZXMgYW5kIG5vdCBhZHZlcnRpc2UNCj4gc29tZXRoaW5nDQo+ID4+PiB0aGF0IHdpbGwg
Y2F1c2UgYXV0b21hdGljIGF1dGhvcml6YXRpb24uDQo+ID4+DQo+ID4+IE1pZ2h0IGl0IGJlIHJl
YXNvbmFibGUgZm9yIHRoZSBUaHVuZGVyYm9sdCBjb3JlIHRvIGNoZWNrIGVhcmx5IG9uIGlmIGFu
eQ0KPiA+PiB0dW5uZWxsZWQgcG9ydHMgYXJlIG5vdCBtYXJrZWQgYXMgZXh0ZXJuYWwgZmFjaW5n
LCBhbmQgaWYgc28ganVzdCB0ZWxsDQo+ID4+IHRoZSB1c2VyIHRoYXQgaW9tbXVfZG1hX3Byb3Rl
Y3Rpb24gaXMgb2ZmIHRoZSB0YWJsZSBhbmQgYW55dGhpbmcgdGhleQ0KPiA+PiBhdXRob3Jpc2Ug
aXMgYXQgdGhlaXIgb3duIHJpc2s/DQo+ID4+DQo+ID4+IFJvYmluLg0KPiA+DQo+ID4gSG93IGFi
b3V0IGluIGlvbW11X2RtYV9wcm90ZWN0aW9uX3Nob3cgdG8ganVzdCBjaGVjayB0aGF0IGFsbCB0
aGUNCj4gZGV2aWNlDQo+ID4gbGlua3MgdG8gdGhlIE5ISSBhcmUgbWFya2VkIGFzIHVudHJ1c3Rl
ZD8NCj4gPg0KPiA+IFRoZW4gaWYgdGhlcmUgYXJlIGRldmljZSBsaW5rcyBtaXNzaW5nIHdlIHNv
bHZlIHRoYXQgc2VwYXJhdGVseSAoZGlzY3JldGUNCj4gVVNCNA0KPiA+IERWU0VDIGNhc2Ugd2Ug
anVzdCBuZWVkIHRvIG1ha2UgdGhvc2UgZGV2aWNlIGxpbmtzKS4NCj4gDQo+IFRoZSBmZWVsaW5n
IEknbSBnZXR0aW5nIGZyb20gYWxsIHRoaXMgaXMgdGhhdCBpZiB3ZSd2ZSBnb3QgYXMgZmFyIGFz
DQo+IGlvbW11X2RtYV9wcm90ZWN0aW9uX3Nob3coKSB0aGVuIGl0J3MgcmVhbGx5IHRvbyBsYXRl
IHRvIG1lYW5pbmdmdWxseQ0KPiBtaXRpZ2F0ZSBiYWQgZmlybXdhcmUuIFdlIHNob3VsZCBiZSBh
YmxlIHRvIGRldGVjdCBtaXNzaW5nDQo+IHVudHJ1c3RlZC9leHRlcm5hbC1mYWNpbmcgcHJvcGVy
dGllcyBhcyBlYXJseSBhcyBuaGlfcHJvYmUoKSwgYW5kIGlmIHdlDQo+IGNvdWxkIGdvIGludG8g
ImNvbnRpbnVlIGF0IHlvdXIgb3duIHJpc2siIG1vZGUgcmlnaHQgdGhlbiAqYmVmb3JlKg0KPiBh
bnl0aGluZyBlbHNlIGhhcHBlbnMsIGl0IGFsbCBiZWNvbWVzIGEgbG90IGVhc2llciB0byByZWFz
b24gYWJvdXQuIElmDQo+IHRoZXJlJ3MgYSBzdHJvbmcgZW5vdWdoIGltcGV0dXMgZnJvbSBNaWNy
b3NvZnQgZm9yIHN5c3RlbSB2ZW5kb3JzIHRvIGdldA0KPiB0aGVpciBmaXJtd2FyZSByaWdodCwg
aG9wZWZ1bGx5IHdlIGNhbiBnZXQgYXdheSB3aXRoIG5vdCB0cnlpbmcgdG9vIGhhcmQNCj4gdG8g
Y29wZSB3aXRoIHN5c3RlbXMgdGhhdCBoYXZlbid0Lg0KPiANCj4gSSdtIGluY2xpbmVkIHRvIHNl
bmQgdjIgb2YgdGhpcyBwYXRjaCBlZmZlY3RpdmVseSBnb2luZyBiYWNrIHRvIG15DQo+IG9yaWdp
bmFsIChldmVuIHNpbXBsZXIpIGNsZWFudXAsIGp1c3Qgbm93IHdpdGggbXVjaCBtb3JlIHJlYXNv
bmluZyBhYm91dA0KPiB3aHkgaXQgaXNuJ3QgZG9pbmcgbW9yZSA6KQ0KPiANCg0KWWVhaCBJJ20g
ZmluZSB3aXRoIHlvdXIgcGF0Y2ggY29kZSBhcyBpdCBzdGFuZHMgcmlnaHQgbm93Lg0KSW4gdGhh
dCBjYXNlIGhvdyBhYm91dCBhIHNlY29uZCBwYXRjaCBpbiB0aGUgc2VyaWVzIHRvIGRldl93YXJu
IGluIGRyaXZlcnMvdGh1bmRlcmJvbHQvYWNwaS5jDQpyaWdodCB3aGVuIHRoZSBsaW5rIGlzIG1h
ZGUgaWYgaXQncyBub3Qgc2V0IGFzIHRydXN0ZWQ/ICBUaGF0IHNob3VsZCBoYXBwZW4gcmlnaHQg
ZHVyaW5nDQp0Yl9wcm9iZSBhcyB5b3Ugc3VnZ2VzdCB0aGVuLg0K
