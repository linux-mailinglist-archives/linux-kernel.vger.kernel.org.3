Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5984F1BD1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381683AbiDDVXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380352AbiDDTly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 15:41:54 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFBC22B37;
        Mon,  4 Apr 2022 12:39:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGhLU4Pu5M/PEdtTyvyhegjH/lQ4rJKP5ddiSURtsqs0uOmbHsFRY+szID2fL5fvUBsq3ZPS3Q65J/2CMz0COhR4D2nL235MeqLRWZgb5Lny3brz1jo06ZelfeQbdv7apAlORnn5CTRgL6n4e6hBCo4Z02iecfWQCPoeyyWupAGLxaG9W63A4HNSenxsKtDe58nENjaky2GvWutY2xsYzqyqS2B7+fAMIP4Pe0zPBuLCvBUQGEcTdBUyO1ZHWyxELKsRL9AZV78vhY4L/A5anPJMZnkoc6qtFsT7PoBGL7e60/fGyhbuxCppKBJKSyhwnEm1FHk1YOwzdUk+eMkfCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=at07lX3FxytbILMDH5EKqAxRMij9E92qt+TB6Wku2P0=;
 b=LvhtcjkPxrBJvfBcpnx4rya80+FzGIQP5V9nsDOQ4tHsPg3OYRmhMNvMQhRVccaoQKnZHaRKq/rHxYN358MTLRD4198mPG2rAvy/6K28m64S94mWx3NJ1w6kOmQdQlwwZOlKGxmhz1ZSDLukmqtLWGDqlkuNOMt2nNHzX4/WZJK9tvuHZGQi5Ilk8TJN4UzpCHPPuMc0bipV3qllC4o8vOXrZucEovt0dQQ0+andGAaT/rGF7poSga73mb4skOaHB2FvUuJz+NAvxWtXiuerShJUjvBukuaEnFajQJc66wvojU+35bDPjapzqSCG9cAPdPyT4f1rcfksJ/D5z1BtJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=at07lX3FxytbILMDH5EKqAxRMij9E92qt+TB6Wku2P0=;
 b=wmCQALL75esRdr+r9QzjFxchtY2fe1WH1GxbJE4XpdjfHcSKizuT6GECZS0DhWgKDoqBqpDkGUjFzvih5SRPgZjtFJmNY1Q4XXfep7g6+QW0IzW9CsTfcIEuC76meVY4LGt6h/tNqvPWCYwJ5VcKVRE67z0f0ez4lcvLj+rHe/w=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by CY4PR1201MB0023.namprd12.prod.outlook.com (2603:10b6:910:1f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 19:39:54 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d%5]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 19:39:54 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>
Subject: RE: [PATCH v2 2/2] ata: ahci: Protect users from setting policies
 their drives don't support
Thread-Topic: [PATCH v2 2/2] ata: ahci: Protect users from setting policies
 their drives don't support
Thread-Index: AQHYLrH7kpm3AkPxAE2eIMYLz1fgLqzfJECAgAE1rIA=
Date:   Mon, 4 Apr 2022 19:39:54 +0000
Message-ID: <BL1PR12MB51570E1C17A122179CCB0625E2E59@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220303034912.3615390-1-mario.limonciello@amd.com>
 <20220303034912.3615390-2-mario.limonciello@amd.com>
 <a6a17a22-0cde-9c46-0cd7-127be2cd2792@opensource.wdc.com>
In-Reply-To: <a6a17a22-0cde-9c46-0cd7-127be2cd2792@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-04T19:39:52Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=fb553fde-5c4a-4d58-acb2-0dc3d52926f3;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-04-04T19:39:52Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 991f7053-713f-44f7-9392-2d20fee1c0f1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e76f68e3-a366-4a9f-c751-08da1672e49d
x-ms-traffictypediagnostic: CY4PR1201MB0023:EE_
x-microsoft-antispam-prvs: <CY4PR1201MB00233AA0F1B6C814877C33B4E2E59@CY4PR1201MB0023.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 46Rv12HIdZNppGNP8KawzH8RtqVRCtmptLLQl7d7zHP1A3oWopoTYTUpRdoc9OBAZ71l31tHSQS+O/o4e0A3BmUdk2uBXcHaN24786qKY9OP0lS9rnXZwAMRJIzgeiE3BireWfLik1+0oLqRPJPxC3vCBz2lwMkqLh4UcWdU9Rv9emSwi08QdxVEAabqoNP9PGAjhOqEH/DQuORkjBWFlLJI6A0McKdudDG2oQ+1wP74+b2sxra+43KYUgJAoYIDewUj3QCIoAIBinRfSzDvSnRgANPOSzqP7YUx4cCmUQlh0Horw2UWXaMC0IDGfX2akufn7XfmQe1gaQP/YITczgmlXzgA76XzodPuOQDNWfn/LR4nfoZQ24/J13SZyHO5aeExu2hecXcu6ua7d/ktzOKyIybUxOxbaYakmgYjWCHiJwAbxAjLIyl2IoMUhyecWAGLW3lX1zwyEMgXq46T3XaetHcS8AoV4rVLjnBO/tFQS+VJR1Y/YTsergeW8tfHGPls0JIaghCrO6coNYerGtuXHpHiD/lhM5aiMIktPV0AEXh2u/Taqq6g1BjLUR7z6/BZQBtsFM7OyNYp42XciLeQOO2ZXLBFbFp8dV9AXemj8Nu3RQrL8FJ0aix+zMs75iF6fA+fJ0DllH/mhoRULuOXxhXmPzzjOiAqQnz6CfhFh6K00urNSKdAawLLGy16dlZTF4NLp+hv61+SxZU8xA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(76116006)(5660300002)(71200400001)(54906003)(6916009)(316002)(86362001)(66946007)(66446008)(4326008)(66556008)(64756008)(8676002)(66476007)(52536014)(8936002)(6506007)(2906002)(7696005)(53546011)(38070700005)(55016003)(83380400001)(186003)(9686003)(122000001)(38100700002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVIzWlJjWk4wOEZlcEpmSFFzSnJJWUJZbVIrVVdjRjlpcXBwWk1mdHpHQWRL?=
 =?utf-8?B?cWk4ZE55UExoNWdzL292KzhNRWRNakpqcFJTSmVScFVZVndJNGt0cHRSdEt4?=
 =?utf-8?B?Z2R3SzgzVkZrZlphSGpOeTM5alJRM3BGUER5MjZndHFUTFpLL0Q0T3U0cHZU?=
 =?utf-8?B?RWNaNEVZKzdUMXBaZEZ5eGU0Q1JPTU5CSVA5WkcxMllDRVFOTnFveldYbDRa?=
 =?utf-8?B?anorSHlkWm9XK05NZDVPMnM0WnNCWGRpOVRTbUVrUVZoZTdsM01BYm9pa1BZ?=
 =?utf-8?B?MXdIanYxM0Z5UnY1V2RGbHEyblVJeGhWWGRRREFwaWpNWDZUdkc0d1lDUXgw?=
 =?utf-8?B?S3Nxa3FUYno4NFJveFYvU0FKRXBwYTJsUjlqalpZQmFOSVNYWVgyYVhlc1Na?=
 =?utf-8?B?UFNlQlRTVGJsdUpPUXUwbU0rSTZ1dzRDWUpxNDcvaFNMZldDWGYxUjZ2ZlJk?=
 =?utf-8?B?NGFrRm1KK1E2N0c3UlZUd0lmeEpjQnJNMi9GL0NPZFJoU0VlUy96TVplQWpi?=
 =?utf-8?B?cEt6RVMzTkgwQks4TUZBVmlkaFUvVDNITWVNb2VBMk4yTnF3ZlRQbWpCS0ls?=
 =?utf-8?B?ODZtTnM4RmJkSjZQUFdtR0RVQnRUdEhmcjZpdit2cERjQWxWRUxlWThmV2RI?=
 =?utf-8?B?ZithcEgwWFh4OEJieFZNOUdyVURuUVo4NFF6UzFndzQ0QldJVkFmRlRsemtH?=
 =?utf-8?B?Ny9kdFhTcjFKcGJwWFp1WjBESmE3STZQZzF5VHZ0SkdJcDBWbU1TQjFDUjQ3?=
 =?utf-8?B?dFZBNUJwMGxrT1N5SW8yMXlRTW9TQ2hOMWwzaUJmTXdTQVNzdHg3TkF2WmNz?=
 =?utf-8?B?K2ljK3dlNFJsUHQyL0tKL2NZdXNtLzFNRlEwdlZabFdjd2tNb1N2T0VQaDlm?=
 =?utf-8?B?NGlkS1pOeDd4M1ZDRW9mWkVmVzJOYUV2VjN5VXV5NjlRUnRXOVlnUU9CSXN5?=
 =?utf-8?B?ZFk2QVRkbXF5ZlFLbFcrdWRhdENrdXV5aFJWNStSNGVqSytEc2V0UDQ4NUNS?=
 =?utf-8?B?RytiTzc5aTg1bjdOTGtjVGhabDRpcjdzRTFPZlE0a3M2YllNbExmZ24xR2RY?=
 =?utf-8?B?TUtFZVlTQUpqa0lZclBVb1ZmakRzcExtOHZvWlRnamtIZ3Q3NUFnQ1o0YkVy?=
 =?utf-8?B?RnZYU3FwRlZLeDNyR29Bb1JoTHkvbXFoVTVjci9KN2lmQ0Fxdnpmdi9tUHZM?=
 =?utf-8?B?MTloVWd0SlR3QkhJazJxdURoQjcvRUZVVU1vaTl4VG1vcnlhQ0hwcEF2OHI3?=
 =?utf-8?B?VlRyY3NNSWUrSWZwZUl3VDRoUEdmUEFjMW5VanNucVQvQzlZRjY0QnBiWFZN?=
 =?utf-8?B?SERZYmljbGR4d0tlNGpxNVhPRmxvU24rbUl5ekt5QWVjaWlIb2s0R1BnTGFH?=
 =?utf-8?B?YjNkYi90SmV4YmZoUUNmUm9QSjdBdkFWWDQzcmlsRURhK3hCZ2lDRXlpNFZV?=
 =?utf-8?B?TlhJTk5tYTF5dHEvMC96dFRyeFNmVnpzUUtqWDk3TUtlbzZHbUxzejRQaVhq?=
 =?utf-8?B?aEk4OHA0NnBPYmZhM01sU29nakMyeGFtWUxFOHk3T2phZG4wKzQ0MG5rQlRh?=
 =?utf-8?B?amNiTjFnSlFFeE9JUHdnRGhGOHNSUzNqQm9PbFBncWM2VFh6RndvVlNmNXR5?=
 =?utf-8?B?QlFRWFFkWEl3ZXJ3eGdSMSs5T1IzWDMrSTFkQk9WSlYzTEcrZWVCRXRCS2lL?=
 =?utf-8?B?WlR0Q0Y0MW5IOCt5Um4vR3pqOWtkTVpLTFZiZFlvOEYrVkNsczdDRjhXdFhE?=
 =?utf-8?B?amk2NVYvQWI4ejROU0hqWHE2bDdRVDlpanZhQTNGbWczaVFtU2FPcHZEdzYy?=
 =?utf-8?B?b2pYSWR5UXdUdGRyMTFCR1RCZ3I2NXlFYkQrWXF3ZWUwSkRrNk1qazV5QTcr?=
 =?utf-8?B?WUEwUEJIclp2UHhRWkJpZnFLcjRLeEZsbXdia2hnVC9RN3Z1aDNvc0RBTDFG?=
 =?utf-8?B?aGkrMmlGTUpzZE9uc2UyWk5zdXkxVmZieHRCSyttMldjNThQRU0vbER3aVVW?=
 =?utf-8?B?WUN1bGJod1dQL2lWbXp2eXh5R0QwMkhBdjhSQUZYUEY3cGZMdE9zcDQ5SFFW?=
 =?utf-8?B?R1h0aldRMmxkcjVEdjYrY0dwUDdTeUo0WFRLQjdkK2dvSlo2S2dVU1hlMVlu?=
 =?utf-8?B?aEpWYWhlL1dhTWFBbE5PQ1RkQkFjb1REclFlWEdxamZnSHI2a3RqeFpLWHQ0?=
 =?utf-8?B?bkN0VlovMWhSN1FkanlHVEpndGxIK1ZrNjlRR1lxbVYyMHc5OHc5ekRaUjdL?=
 =?utf-8?B?OGlMNFRUeFlQTTZLRmliTVpVNDNZTXFKTnA1SWw1emhreU5BNlV5SVJiaDRi?=
 =?utf-8?B?bWxmN1UyZXF6c0taYmppMW1oaVRabXltSGphdlBQYk55dTNKOTY2ZDNmK212?=
 =?utf-8?Q?fhlDdC9QPttM3xfl7ADMBTa9heB53L5bhwLSobgYi9Vgj?=
x-ms-exchange-antispam-messagedata-1: nnUnfLuAbDRSFA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e76f68e3-a366-4a9f-c751-08da1672e49d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 19:39:54.2412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y5zV0T1vBI/lXngPfM1eUisbGaxo3Q+fd1BV0DbLWBZu+ly7ePeFVGAR/mbrPG7U/q2kitW3hX1Yt9hDF00pcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0023
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogRGFtaWVuIExlIE1vYWwgPGRhbWllbi5sZW1vYWxAb3BlbnNvdXJjZS53ZGMu
Y29tPg0KPiBTZW50OiBTdW5kYXksIEFwcmlsIDMsIDIwMjIgMjA6MTENCj4gVG86IExpbW9uY2ll
bGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT4NCj4gQ2M6IG9wZW4gbGlzdDpM
SUJBVEEgU1VCU1lTVEVNIChTZXJpYWwgYW5kIFBhcmFsbGVsIEFUQSBkcml2ZXJzKSA8bGludXgt
DQo+IGlkZUB2Z2VyLmtlcm5lbC5vcmc+OyBvcGVuIGxpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc+Ow0KPiBoZGVnb2VkZUByZWRoYXQuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djIgMi8yXSBhdGE6IGFoY2k6IFByb3RlY3QgdXNlcnMgZnJvbSBzZXR0aW5nIHBvbGljaWVzIHRo
ZWlyDQo+IGRyaXZlcyBkb24ndCBzdXBwb3J0DQo+IA0KPiBPbiAzLzMvMjIgMTI6NDksIE1hcmlv
IExpbW9uY2llbGxvIHdyb3RlOg0KPiA+IEFzIHRoZSBkZWZhdWx0IGxvdyBwb3dlciBwb2xpY3kg
YXBwbGllcyB0byBtb3JlIGNoaXBzZXRzIGFuZCBkcml2ZXMsIGl0J3MNCj4gPiBpbXBvcnRhbnQg
dG8gbWFrZSBzdXJlIHRoYXQgZHJpdmVzIGFjdHVhbGx5IHN1cHBvcnQgdGhlIHBvbGljeSB0aGF0
IGEgdXNlcg0KPiA+IHNlbGVjdGVkIGluIHRoZWlyIGtlcm5lbCBjb25maWd1cmF0aW9uLg0KPiA+
DQo+ID4gSWYgdGhlIGRyaXZlIGRvZXNuJ3Qgc3VwcG9ydCBzbHVtYmVyLCBkb24ndCBsZXQgdGhl
IGRlZmF1bHQgcG9saWNpZXMNCj4gPiBkZXBlbmRlbnQgdXBvbiBzbHVtYmVyIChgbWluX3Bvd2Vy
YCBvciBgbWluX3Bvd2VyX3dpdGhfcGFydGlhbGApIGFmZmVjdA0KPiB0aGUNCj4gPiBkaXNrLg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWFyaW8gTGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2ll
bGxvQGFtZC5jb20+DQo+IA0KPiBNYXJpbywNCj4gDQo+IENhbiB5b3UgcmVzZW5kIGEgcmViYXNl
ZCB2ZXJzaW9uIG9mIHRoaXMsIG9uIHRvcCBvZiBsaWJhdGEgZm9yLTUuMTkgYnJhbmNoID8NCg0K
DQpPSy4NCg0KPiANCj4gPiAtLS0NCj4gPiBDaGFuZ2VzIGZyb20gdjEtPnYyOg0KPiA+ICogTW92
ZSBkZWVwZXIgaW50byBjb2RlcGF0aHMNCj4gPiAqIFJlc2V0IHRvIE1FRF9QT1dFUiByYXRoZXIg
dGhhbiBpZ25vcmUNCj4gPiAgIGRyaXZlcnMvYXRhL2xpYmF0YS1zYXRhLmMgfCAxMSArKysrKysr
KysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2F0YS9saWJhdGEtc2F0YS5jIGIvZHJpdmVycy9hdGEvbGliYXRh
LXNhdGEuYw0KPiA+IGluZGV4IDA3MTE1OGMwYzQ0Yy4uMGRjMDM4ODhjNjJiIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvYXRhL2xpYmF0YS1zYXRhLmMNCj4gPiArKysgYi9kcml2ZXJzL2F0YS9s
aWJhdGEtc2F0YS5jDQo+ID4gQEAgLTEzLDYgKzEzLDcgQEANCj4gPiAgICNpbmNsdWRlIDxzY3Np
L3Njc2lfZGV2aWNlLmg+DQo+ID4gICAjaW5jbHVkZSA8bGludXgvbGliYXRhLmg+DQo+ID4NCj4g
PiArI2luY2x1ZGUgImFoY2kuaCINCj4gPiAgICNpbmNsdWRlICJsaWJhdGEuaCINCj4gPiAgICNp
bmNsdWRlICJsaWJhdGEtdHJhbnNwb3J0LmgiDQo+ID4NCj4gPiBAQCAtMzY4LDEwICszNjksMjAg
QEAgaW50IHNhdGFfbGlua19zY3JfbHBtKHN0cnVjdCBhdGFfbGluayAqbGluaywgZW51bQ0KPiBh
dGFfbHBtX3BvbGljeSBwb2xpY3ksDQo+ID4gICAJCSAgICAgIGJvb2wgc3BtX3dha2V1cCkNCj4g
PiAgIHsNCj4gPiAgIAlzdHJ1Y3QgYXRhX2VoX2NvbnRleHQgKmVoYyA9ICZsaW5rLT5laF9jb250
ZXh0Ow0KPiA+ICsJc3RydWN0IGF0YV9wb3J0ICphcCA9IGxpbmstPmFwOw0KPiA+ICsJc3RydWN0
IGFoY2lfaG9zdF9wcml2ICpocHJpdjsNCj4gPiAgIAlib29sIHdva2VuX3VwID0gZmFsc2U7DQo+
ID4gICAJdTMyIHNjb250cm9sOw0KPiA+ICAgCWludCByYzsNCj4gPg0KPiA+ICsJaHByaXYgPSBh
cC0+aG9zdC0+cHJpdmF0ZV9kYXRhOw0KPiA+ICsJaWYgKHBvbGljeSA+PSBBVEFfTFBNX01JTl9Q
T1dFUl9XSVRIX1BBUlRJQUwgJiYNCj4gPiArCSAgIShocHJpdi0+Y2FwICYgSE9TVF9DQVBfU1ND
KSkgew0KPiA+ICsJCWRldl93YXJuKGFwLT5ob3N0LT5kZXYsDQo+ID4gKwkJCSJUaGlzIGRyaXZl
IGRvZXNuJ3Qgc3VwcG9ydCBzbHVtYmVyOyByZXN0dGluZyBwb2xpY3kgdG8NCj4gTUVEX1BPV0VS
XG4iKTsNCj4gDQo+IFR5cG8gaGVyZTogcy9yZXN0dGluZy9yZXNldHRpbmcuIEFsc28sIHMvZG9l
c24ndC9kb2VzIG5vdC4NCj4gDQo+ID4gKwkJcG9saWN5ID0gQVRBX0xQTV9NRURfUE9XRVI7DQo+
IA0KPiBIZXJlLCBzaG91bGRuJ3Qgd2UgdXNlIHRoZSBkZWZhdWx0IHBvbGljeSBkZWZpbmVkIGJ5
DQo+IENPTkZJR19TQVRBX0xQTV9QT0xJQ1kgPw0KDQpJZiB0aGV5IHNldCBpdCB0b28gYWdncmVz
c2l2ZWx5IHdlIHN0aWxsIGRvbid0IHdhbnQgdG8gaG9ub3IgaXQgaWYgdGhlIGRyaXZlDQpjYW4n
dCBkbyBzbHVtYmVyIEkgd291bGQgZXhwZWN0Lg0KDQo+IA0KPiA+ICsJfQ0KPiA+ICsNCj4gPiAg
IAlyYyA9IHNhdGFfc2NyX3JlYWQobGluaywgU0NSX0NPTlRST0wsICZzY29udHJvbCk7DQo+ID4g
ICAJaWYgKHJjKQ0KPiA+ICAgCQlyZXR1cm4gcmM7DQo+IA0KPiANCj4gLS0NCj4gRGFtaWVuIExl
IE1vYWwNCj4gV2VzdGVybiBEaWdpdGFsIFJlc2VhcmNoDQo=
