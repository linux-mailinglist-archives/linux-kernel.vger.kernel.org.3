Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8BC4E65D1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 16:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351209AbiCXPKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 11:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242453AbiCXPKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 11:10:42 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E1D52E2C;
        Thu, 24 Mar 2022 08:09:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kdy/Xy9W2qui5O7I7+yqWeWdAaNESCdjD5Z2p2db7sjv2fzF8iBSj02UWRBO1GZG5PM0j8yWf5oDDT3XjOjACK1sR/A4WZzNGBkvw126yxxyGS1XD1YD+2Jdd2ZEMqKDPRsBPwC5Mqr2847tYgOOJtSubrXpS9m7G1SuItE+MyahjxHj/hZwRvDrzYtMO69f6vB8mr51b0jIdIsHErYlUyhvedXjAWiv+681p5Z2iX9t7YzEiIoFlHtuYQcjEPmC0yS07dbd8Gaojnaq+GC6EreTQ8gEq88ui1uPNiao4ZSouzR/3Igg3FP3wGe9mdJ9HZ10OfSxmgWY5WcwpyhsXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=worJqyeuKw9nNeratri3xf+V3jAYnp2XHu3SJT2OwS0=;
 b=jtDvkzEdiTB7hYsnQMAIJ1hSzk50ZUzjy9oObEozI2f/x7UOQ5vD1vHyPbNB42A9xXnttQrQtd7v1Yb1RttQnzABek+tpxMXJeWKG7vcxC22J3JfiaXQe306KonsHx79nPcQBU+0qNp5nzUDWwrHdRqlclZTRi+wHsKyd8K+qYb10UH8qOFTWJZYHaU0K5tJbcqxsjr7XzCgeHSvezp1yheOjAv6tkpLRIPfriP+UWTq5ayfIWpzjaNw1QdNF7LCfzXxY3/jGXyAbQhpMBTji6aF26DuPqjt0KyRVN2C6+X80enolCZ4rYVTt4d2fDQTSdktymHs4ZQVRsjjmzV4ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=worJqyeuKw9nNeratri3xf+V3jAYnp2XHu3SJT2OwS0=;
 b=pz3cBXEpr+a9LGaG/oalzWqTW508oyFUULhTFtAzPtHrDZhnF3+dnK4HVKnivSa4eJA7WInuBsCqRX3Vam2Cn4W8ZO+gMEQoox8SMILjuefue6POKQoqA+siFBVJvSFgi02SjYnzaRyqcwx66o1CW8ysN0/Wzg38Sjo3u/l+m0Y=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BL0PR12MB4851.namprd12.prod.outlook.com (2603:10b6:208:1c1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Thu, 24 Mar
 2022 15:09:04 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d%5]) with mapi id 15.20.5102.019; Thu, 24 Mar 2022
 15:09:04 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ata: Kconfig: Update SATA_LPM_POLICY default to "3"
Thread-Topic: [PATCH] ata: Kconfig: Update SATA_LPM_POLICY default to "3"
Thread-Index: AQHYP4+kVHeNoPKQeUyTG3wPHY3pVKzOofSAgAAAQuA=
Date:   Thu, 24 Mar 2022 15:09:04 +0000
Message-ID: <BL1PR12MB5157132871A3CBD381E7F072E2199@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220324145905.4176-1-mario.limonciello@amd.com>
 <YjyInz126lgomIvW@infradead.org>
In-Reply-To: <YjyInz126lgomIvW@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-24T15:06:05Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=8d9f9b12-6401-42e2-a056-b8a2b28c26ac;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-24T15:09:02Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: c6241310-7cb1-44af-88c2-27798c8642ec
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6aa92f6f-eb48-48c4-cd83-08da0da83c5e
x-ms-traffictypediagnostic: BL0PR12MB4851:EE_
x-microsoft-antispam-prvs: <BL0PR12MB4851AEDDE861D9BF6F462D7EE2199@BL0PR12MB4851.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S9FSl7fhAz6VODowZrdL3H98mMZ0fnTXAwNyTJ9vS+qpsikfvFw2ucwt6a2N+s4bo9+WycTlTWgQXW5mVwjH9amlUpobNnHi0CJWHQOVS8WlxotIZZvSg080Smfw1KdNx6qUgZv9IeNFIS2A9/qdrVzVyHovewq4cnZMQSc3rcqw6wbrH1OIPBtiaCJTibWmMbsVM/Aaexl+1FG2Jm3Chh8gFLQpZDQcPbiGHP0+47EhijrmfPdpgpkL8ymF8Fyi7wFghjnmGaOSkK9+E6xPu0eFHyZvL+76JEJqDSIkQ3gmboBppgfrl8Dt3+8HvzgIG/NHRZbVUa5PcSm+1bEkfzOicy+WQFb0oxgl0mENbTcsGGeV+dzQr9jb1wQyZXYere4q4O5m+ZUoHa193/+75hTuo+tueCmRFqslhHf8O74E08pXRwuNMPpHWIjYUY2Y0RWiqErHrz3/lxp0nMfTFwmESg3VA3cm4E06FJ84gDNmeO70K3iImu4MpOIsHUOdb5lvkl2JmehDEg1tATNqmmQ4fg4vinJdOcf4gDT/TEITO7FfuxfkuHmFqEKeI5pTSZ1Oqu2BxSY9hWRO9sjYdcIodWJZv6SP2iiweqa+nXmxzgkMMxkuxO6bLl60nTyIMFUjK0zIQsbJb8r9fZTOBEbMOntFYatyVgff4dnOHkrmL8pZm8QmlKxXdUhYJAs2GHmMkMdNw+C8OnLStBr/Xw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(15650500001)(71200400001)(508600001)(53546011)(2906002)(122000001)(52536014)(86362001)(66946007)(8936002)(4744005)(38070700005)(5660300002)(66476007)(64756008)(4326008)(66446008)(8676002)(66556008)(38100700002)(54906003)(76116006)(6916009)(55016003)(83380400001)(186003)(316002)(33656002)(9686003)(7696005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVVvcG9SY283WFU0TW9zSk5OckppWVE3bTQ0eS94SDJJN1h5T1ptcE9ubWhF?=
 =?utf-8?B?MDBjTkJDbklvOGc4SXcwdmRsdU96S2I0Y0t6ZE1rWUVqZ2JZMWhGSUkyRnhF?=
 =?utf-8?B?Y2dIOUJ0NWxFRUFSdjJHdjBBd0s0eUloVDhDVTZKbmZkUzZPdElmaU5Sbzl6?=
 =?utf-8?B?T1I5YWdha0ZPeGVGcEJNbFExYml6ejVXckw3YTc1Z2szZHU4YThQSTh5VlJI?=
 =?utf-8?B?K3piREpDOUFWdlVRYlIzemJiN2ZsNUViYTU0NVpxMEY1QVhmLzZWUEo5azBa?=
 =?utf-8?B?Rk1lZm9La05yOFJ3dWVzRnpQVjBqeGVGYXcvU242ZTlWZWtLQ2lZM0RRWWcx?=
 =?utf-8?B?eXpndlhBQXNUT0h6ZFdEK1RzaU5WdnU0c1RJR0FSTlVlUHBVSG9GZFdRSCts?=
 =?utf-8?B?VEl0RHpjL01ycmJFeUdMd1lTRFB3YnJIUDZxdHpEZWs1N01aaUllWGFRbHZq?=
 =?utf-8?B?bkhxVmY5c3A5UmVGeWRIWG9KUUNsTktSOXVYUDhObnBkSmh0a1ZNWFRrS0x1?=
 =?utf-8?B?L1YvTzBDZzlOalY2b0ZlUTI5YzU4c0d2MkgxYXhzYi85cHFZaFArbTVFcllM?=
 =?utf-8?B?Vm9keU9KWThCVEVPTUFwRjVaYUF5Z2IrOGpnS2NadWtnSzZrZFRuOUF6WlVi?=
 =?utf-8?B?dmZzRisyWTk0MWZYR0xBYWVES29ORStSdUkwNld2VTRaY2IvRkNBbXhDcW5K?=
 =?utf-8?B?Sk1iSVJ2MVhBVUtjeWQyMXV2Qis4WEF5WlJ1SDI3ZDcxWWtYZVc5c1N3ZkpU?=
 =?utf-8?B?UTNES2ZiUzduMjZyaGp3NWlCWVNnZDRPeEljRWM0WG51dkdBZFpyenVUR1pT?=
 =?utf-8?B?RlA1SG5EYXpJRnMzRkZsWWo2R3BUcy83ajRYQS8vVUpUUTlnR0dZZEFCZkFl?=
 =?utf-8?B?bHNpd3pRU3Y5N0VodTAza3hYN3UzNmdFeldIWmcvb0l4QkI1V201eWltMDJz?=
 =?utf-8?B?MjVRT1I4ZEFjNGJaZ3h2dEZrbVNDZlpDR1c1NGJIdXRMQUh4T3FYVnE5c3Fn?=
 =?utf-8?B?WVFDOWxhN0Q2UVlweTdFcVFUTnNleXZaeXhHeWhBdTk2Rmx3K1Z6V3RoMlJE?=
 =?utf-8?B?Q2kyUFRBQmxtNTh6UHJkdGF1OEJacEtGRlRMam1QTE5xeUhmaVhsYjJRZkxj?=
 =?utf-8?B?QTBwSG5oTmw1disyT1kyM3NMRzNiRVpVaHVId3VTdzlBaVpXK3N6TU9CRGJn?=
 =?utf-8?B?R2p6M2xiMUV1MHRlc29nVnUwazlqeEJCQmZReEJnVnY4UWFydjRMS01sNU1m?=
 =?utf-8?B?cHNwNHI4cWM5WTh2M2dBcmpTUFhPekNMb3NtT3QrajVLNzZ5SWNqSjFlTjFN?=
 =?utf-8?B?ek5JMXFJZUxYaUlXdmtYOTI4NWdDa1RrNUVuNGN3RS8yRkd5RDZDMitiaGlW?=
 =?utf-8?B?SWpOMkFrdlNIRTVLeTEwRENSZllxR0FUeFp1YnFuaGgrc20yWStNNXoyQ2xG?=
 =?utf-8?B?K3JlcDdMOS9rK2tXMFJzR2VRR2VKVlY4YXJ5Rjk3eDhXTVVZY3oyZmFlSG1S?=
 =?utf-8?B?SVNjY0o2N2RJd3RmK1pjdTlyUzhJSDRnM2MvcmQ3cW1qZDd1S2JMd2l0RzNy?=
 =?utf-8?B?NUtlQ1FPeDFDdi84TnlTeVNJc3NEejJxRHBQTGNLcjRIZFZZRkx4dlhSQWZD?=
 =?utf-8?B?cmgvTXZtN0VhN2JsbkxXRkhRRG1JYkVGc080Ym9EakRNbWphTHFPZ2dDSldh?=
 =?utf-8?B?TkxTcnlrMUR5cTRzcW1GVlBWbi9RWkl2Ny8xOFAwWTBQRUlDcFpJSmtUL09X?=
 =?utf-8?B?NzVrekF0bkpjVGhSMmtmVTI3eDRXR1ZlY1ZmR2hhbUtpYzRYLzNFTmZ0Q1hi?=
 =?utf-8?B?L0pmTkQ5MTRDNW8zUDZyZDdUOXo5VmRGMG8zZ0Q2KzJvaThCdGx3N0hPb0Ix?=
 =?utf-8?B?dGlPcTQrNi9UZE9TSG9yczlwM3BIUTdVNytHSE0zaW16NXROV3pYMkdiRmZ4?=
 =?utf-8?B?YXZGTTl5NW44T1R4QlYrZ1ZZTUxKUk9YUDN3eFR1dUpEZS8wRjdGYUlVZ3lo?=
 =?utf-8?B?ZEE2WHdNbjJoNFhnUUZjcXFuR3gwN3hJcnlWTkVuYkd6b2cyRXEvTEhJQzc3?=
 =?utf-8?B?bVFhcTVUeGdwWUxtSmZma0JCckl4Q2FLSjhUQnFZcThycExGS0w5NFFaY2pr?=
 =?utf-8?B?L2l1VEM3SldvbmJ0ZG1UQ3lGSlBUOS83UzhFYVNkSmh3VDN4NnFhQkg5NGx0?=
 =?utf-8?B?ZExQckg1dTgwNDhXdSsvS01MTzhabkdxcWE4SUx4dnIzeHFYSmh3Y3MrQWZ2?=
 =?utf-8?B?aEg0NXdvb2FzT0pNb3ptZmwwZ1ZpYmxnTEFXcTdVRCtiR1YyVy9DNmExRit1?=
 =?utf-8?B?MnhyN1FjcWlXdHQvelZZeDFneFdJUm1YaEkrOGJwK0Z3aHNBNkNNbHNzTmt4?=
 =?utf-8?Q?zMATDAYxInY5Tz9G5s7MAyznAIcytbvIs9SnD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa92f6f-eb48-48c4-cd83-08da0da83c5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 15:09:04.3297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3T/GreWSXYnOkJCEECohvSy8R8iI1G7267S8/8Zxq8iR9Ez57CguEiEl8eblyj7G4nfmazQE/eGFyb4tYbFkCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4851
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaHJpc3Rv
cGggSGVsbHdpZyA8aGNoQGluZnJhZGVhZC5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAy
NCwgMjAyMiAxMDowNQ0KPiBUbzogTGltb25jaWVsbG8sIE1hcmlvIDxNYXJpby5MaW1vbmNpZWxs
b0BhbWQuY29tPg0KPiBDYzogRGFtaWVuIExlIE1vYWwgPGRhbWllbi5sZW1vYWxAb3BlbnNvdXJj
ZS53ZGMuY29tPjsgb3Blbg0KPiBsaXN0OkxJQkFUQSBTVUJTWVNURU0gKFNlcmlhbCBhbmQgUGFy
YWxsZWwgQVRBIGRyaXZlcnMpIDxsaW51eC0NCj4gaWRlQHZnZXIua2VybmVsLm9yZz47IG9wZW4g
bGlzdCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SF0gYXRhOiBLY29uZmlnOiBVcGRhdGUgU0FUQV9MUE1fUE9MSUNZIGRlZmF1bHQgdG8gIjMiDQo+
IA0KPiBXaGF0IGFib3V0IGp1c3QgcmV2ZXJ0aW5nIHRoZSByZW5hbWUgb2YgdGhlIGNvbmZpZyBz
eW1ib2w/DQo+IEl0IGlzIGEgYml0IG1pc2xlYWRpbuG4kSwgYnV0IHNvIGFyZSBtYW55IG90aGVy
IG9wdGlvbiBuYW1zLiAgQW5kIHRoZXkNCj4gcmVhbGx5IGFyZW4ndCB0aGUgdXNlciBpbnRlcmZh
Y2UgYW55d2F5LCB0aGUgaGVscCB0ZXh0IGFuZCBkZXNjcmlwdGlvbg0KPiBhcmUgdGhlIG1haW4g
dXNlciBpbnRlcmZhY2UgYW5kIGNhbiBiZSBjaGFuZ2VkIGF0IHdpbGwuDQoNCkl0IHdhcyB0aGUg
cmVuYW1lIHRoYXQgcHJvbXB0ZWQgdXMgdG8gZ2l2ZSBpdCBhIGNsb3NlciBsb29rLg0KSSB0aGlu
ayB0aGlzIHBhdGNoIHNob3VsZCB0byBjaGFuZ2UgdGhlIGRlZmF1bHQgc2hvdWxkIGhhcHBlbiBl
aXRoZXIgd2F5Lg0KDQpJZiBEYW1pZW4gb3IgTGludXMgd2FudHMgdG8gcmV2ZXJ0IHRoZSByZW5h
bWUsIHRoYXQncyBmaW5lIHdpdGggbWUsIGJ1dCBpZg0Kd2UgbGFuZCB0aGlzIHBhdGNoIHRoZW4g
SSB0aGluayBpdCBzaG91bGQgc2VydmUgdGhlIGludGVudCBvZiBtb3N0IHBlb3BsZSBhbmQNCmRp
c3Ryb3MuDQo=
