Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8414721BD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 08:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhLMH2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 02:28:09 -0500
Received: from mail-eopbgr30050.outbound.protection.outlook.com ([40.107.3.50]:3815
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230208AbhLMH2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 02:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8W7DFIHRCSgqNUUT5AKIs21NWmWLDtE//uSxbX/Opj0=;
 b=IsxKyLV3Diy1uaNjs4/I71ujZCxx8Gbz9agwL3UJ9bVjVfRRSybX5dIGl5PtrhMjiVUB8KxDbAj3ZcIy8DNECaluLjH+8anxfwLF+n0uORgJJfBNUCtHZMTxIdystFUZntqzqffdgSh5DNsmnWho/t4gCK+rN94UMnSFXp62kW8=
Received: from AM3PR05CA0152.eurprd05.prod.outlook.com (2603:10a6:207:3::30)
 by AM9PR08MB6770.eurprd08.prod.outlook.com (2603:10a6:20b:300::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Mon, 13 Dec
 2021 07:28:04 +0000
Received: from VE1EUR03FT050.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:207:3:cafe::16) by AM3PR05CA0152.outlook.office365.com
 (2603:10a6:207:3::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14 via Frontend
 Transport; Mon, 13 Dec 2021 07:28:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT050.mail.protection.outlook.com (10.152.19.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.12 via Frontend Transport; Mon, 13 Dec 2021 07:28:04 +0000
Received: ("Tessian outbound 1cd1a01725a6:v110"); Mon, 13 Dec 2021 07:28:03 +0000
X-CR-MTA-TID: 64aa7808
Received: from b71c15f21a75.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A0958129-CF11-4A09-AF7C-0B84364CB266.1;
        Mon, 13 Dec 2021 07:27:52 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b71c15f21a75.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 13 Dec 2021 07:27:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqmkmzbhbsWI+pUChA+4qHc8MwRMLdFRLv/CRyTWFa5aDIP3fv2P+MLZ0cXoyVwwDvk60P0CtrF2gyGah5tf03GJQcvASLfvr6Nx+D9NLoqmPtLMNdPvRp0t9qJiihP8NrpSZsi5Y9V2EIXCnizDxW2Lr0UI//BauTrjGugxKxxUOY3wvHcEgAleYnQRkZbXz3yduetpligSY+s9lbrlHrBg68Z0HYjRuV8JTXeGBkReI7htYYwRu/gz3xlcpwim2UzvMeD1qqMc+g+rjpyFYJIzDYTfvWIrFr0Al3bLWofUbzkTPDkOC1K5d33wbe38wKV8/8MTC/D9grNDOFoCAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8W7DFIHRCSgqNUUT5AKIs21NWmWLDtE//uSxbX/Opj0=;
 b=bg7YamKwfCNYZZ2txc+4gF7K+PG0D1pzJJ+Rljap70ZG4rXW6h3eNDApSGL8rCfM33os0rgzJcd9aYrfwVNLcz5gcMTdizuN5SoZYbChyR9Oy6In0XiuzLesKhQsHn2kSyfPLO4Lfx4/W8ySOTSyk6rklfUTo45uJNWmx4Vp5f+IPRWPKawPbCmISG59K6zZAjaCZe52tN2+g2DAhz1iTzeDijCCtkM+udzo/RAbtDQGmU/MvA+GdJWWiZfTPDfwxYUORI3KWXQR6qr0n68/ET2+k/h5p+wRMB8A0fG3KnFTRYn9SI/z2HTmWBvOYFdDmuc5rQuSUbLyZUQvmtU3Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8W7DFIHRCSgqNUUT5AKIs21NWmWLDtE//uSxbX/Opj0=;
 b=IsxKyLV3Diy1uaNjs4/I71ujZCxx8Gbz9agwL3UJ9bVjVfRRSybX5dIGl5PtrhMjiVUB8KxDbAj3ZcIy8DNECaluLjH+8anxfwLF+n0uORgJJfBNUCtHZMTxIdystFUZntqzqffdgSh5DNsmnWho/t4gCK+rN94UMnSFXp62kW8=
Received: from AM9PR08MB7276.eurprd08.prod.outlook.com (2603:10a6:20b:437::11)
 by AS4PR08MB7480.eurprd08.prod.outlook.com (2603:10a6:20b:4e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 07:27:49 +0000
Received: from AM9PR08MB7276.eurprd08.prod.outlook.com
 ([fe80::89be:706d:4ae6:fd14]) by AM9PR08MB7276.eurprd08.prod.outlook.com
 ([fe80::89be:706d:4ae6:fd14%3]) with mapi id 15.20.4755.024; Mon, 13 Dec 2021
 07:27:49 +0000
From:   Jianyong Wu <Jianyong.Wu@arm.com>
To:     Anshuman Khandual <Anshuman.Khandual@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "ardb@kernel.org" <ardb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "david@redhat.com" <david@redhat.com>,
        "gshan@redhat.com" <gshan@redhat.com>,
        Justin He <Justin.He@arm.com>, nd <nd@arm.com>
Subject: RE: [PATCH v2] arm64/mm: avoid fixmap race condition when create pud
 mapping
Thread-Topic: [PATCH v2] arm64/mm: avoid fixmap race condition when create pud
 mapping
Thread-Index: AQHX7awGuMgrKU0nsEmmvzNEMV7iBKwwAbCAgAAIG5A=
Date:   Mon, 13 Dec 2021 07:27:49 +0000
Message-ID: <AM9PR08MB7276135C8586C80BD51A5A68F4749@AM9PR08MB7276.eurprd08.prod.outlook.com>
References: <20211210095432.51798-1-jianyong.wu@arm.com>
 <f9b090b9-d730-c3d0-ef6f-5170d9809026@arm.com>
In-Reply-To: <f9b090b9-d730-c3d0-ef6f-5170d9809026@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: F44C12A4B3391C4CBF08E8F3C6D4E5EC.0
x-checkrecipientchecked: true
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: 5c20cefb-0e78-45b5-61ae-08d9be0a19e8
x-ms-traffictypediagnostic: AS4PR08MB7480:EE_|VE1EUR03FT050:EE_|AM9PR08MB6770:EE_
X-Microsoft-Antispam-PRVS: <AM9PR08MB67704A95FEA0FBE3911DB9D4F4749@AM9PR08MB6770.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: bpjNIIBmB8Wln6pY0rhv1U1504E22zW26lnVUMtmAbyhDqyt6ef8W2Evn5/oLchbo5UNqUJibJGCh9s0RXucozw1ePFt5CmMxrDQ6jlQzvFWFlR9Ae4kCkh7VYWIxZr2407ABJWX1Eimp+73/wnvQS0/+SxyrkCoM1fWZZiD7tDD9vLPQ+UV2AZyBRPCaGOh7rU/klJRYHL1C9Pb5+8Sxo/KxaiMOpwx4XLBbtbyhT1v/G2tvMOLe3J+2YeQwra98uaqHNTpgpF7mUCp+UCvC8De5r9urctHUOxG6JcvIOck7Br6li/jHkRIPPl2CRPwsiA2A59mrdUBex61AuoGPn+Iy9IgZYotpOXXWSHT7KrLdb1bJ3ehcr2BCQ4WiOWLlhhDhM+F/GK7Wo/dTe88nyxoO/z9io6uUSOiR81fiXLZaWM2GVjqS/CelSYo1j0mrKUnnWQKEbMQsAu7PixF7DOGMUnBpkGrO7tH543W1Of8O/yYAOBsffWictkHf71xmPKt3LBq76LssF3BjCcZqUwwFibA1NIXO+2xxO94mwga90hqcGqtifu8pHAsmtMOuhhzeqKsezn7a/PlxrLbshStMR70G59Xe8lVH+w5SO0qj9WonDG5T6vPtS4Fe3WkDPPuRdP+ucG4DUueVKLn+zh+Z2DbL3NuUHQNcmJbIcUiHgdG4oA2gelbMCt2Q3zSUzcj9mqMx9VxPPrMOXJIyg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7276.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(110136005)(8676002)(4326008)(71200400001)(76116006)(66946007)(64756008)(54906003)(508600001)(52536014)(66476007)(8936002)(86362001)(66556008)(83380400001)(316002)(6506007)(66446008)(33656002)(53546011)(2906002)(122000001)(186003)(38100700002)(26005)(7696005)(9686003)(55016003)(38070700005)(5660300002);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7480
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT050.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 826fe2c3-35c6-4133-8cce-08d9be0a114a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SeXcojt24IVlxMERf1GkEnimLDIUwlz9yorjNXikI3MFiZQkacvwzjWo/F/pGtrxYIA+Tk3tI4R9T2n7opOVzbUd1Ro7/jLJ2+w4U4vGb4mTTGeuioDjGltEPJEq7CfUfEtmDjSRXsWk8t+s+TdlpHMKkGhVspqlHLxg3yYuOU9kuSJ8CM4ixtoDZKNeWWnC8EIW6RQpErH6mX3tTaByfBXfbtrUTujvGpvIMYRVAy4athlqdGidmjd/VPwbXpLB0mDDdiQ7+LY/M+p/ejW9HmFD1tObcgxTAFPeSbJOh6zSWXDsSdAAiO9loJhUw1kX1mU2cOixv99JSRUDzJW1FSTJpuR3gj3U7km3/KZCGD5b/8LDiw5EkDhIJpKG/CGBqqWtMyTlvg2uq6oDdCZogLYDosayQrKZLyNnB3Bzy9cD82ggs5mAkbEfcGwV3fiZ1O8TINhuZwfgPRUfOmp5L+xI6lgwxW78hEmY9gqTqunLzXIvwRh1MPf6vXq6lpgOVqUpE2Zo+AjCubGK90yYRTgbobZb+316Pkagcw/4VcJcnWqoJV5PgStgxTUe6vfSDEwk1TTDDbqipySde4EEABSZJvmbuEZFHqKAMfnjsxC/uhLFxZOis+JCuMP1YASMy1HBQSgx9AgQtNXCUmzLNs4sYdmS2+5lS+tymTG2NfxzKmBy15ioEU/OcHEiOZRfz6WSiONJ2dfM2Xdhq6V+Lg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(6506007)(53546011)(33656002)(7696005)(2906002)(110136005)(508600001)(4326008)(316002)(36860700001)(54906003)(26005)(47076005)(8936002)(336012)(5660300002)(186003)(86362001)(52536014)(55016003)(83380400001)(82310400004)(8676002)(81166007)(356005)(70586007)(9686003)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 07:28:04.2152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c20cefb-0e78-45b5-61ae-08d9be0a19e8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT050.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6770
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5zaHVtYW4gS2hhbmR1
YWwgPGFuc2h1bWFuLmtoYW5kdWFsQGFybS5jb20+DQo+IFNlbnQ6IE1vbmRheSwgRGVjZW1iZXIg
MTMsIDIwMjEgMjo1NiBQTQ0KPiBUbzogSmlhbnlvbmcgV3UgPEppYW55b25nLld1QGFybS5jb20+
OyBDYXRhbGluIE1hcmluYXMNCj4gPENhdGFsaW4uTWFyaW5hc0Bhcm0uY29tPjsgd2lsbEBrZXJu
ZWwub3JnOyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnDQo+IENjOiBhcmRiQGtlcm5lbC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc7IGRhdmlkQHJlZGhhdC5jb207IGdzaGFuQHJlZGhhdC5jb207IEp1c3Rp
bg0KPiBIZSA8SnVzdGluLkhlQGFybS5jb20+OyBuZCA8bmRAYXJtLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2Ml0gYXJtNjQvbW06IGF2b2lkIGZpeG1hcCByYWNlIGNvbmRpdGlvbiB3aGVu
IGNyZWF0ZQ0KPiBwdWQgbWFwcGluZw0KPiANCj4gDQo+IA0KPiBPbiAxMi8xMC8yMSAzOjI0IFBN
LCBKaWFueW9uZyBXdSB3cm90ZToNCj4gPiBmaXhtYXAgaXMgYSBnbG9iYWwgcmVzb3VyY2UgYW5k
IGlzIHVzZWQgcmVjdXJzaXZlbHkgaW4gY3JlYXRlIHB1ZCBtYXBwaW5nLg0KPiA+IEl0IG1heSBs
ZWFkIHRvIHJhY2UgY29uZGl0aW9uIHdoZW4gYWxsb2NfaW5pdF9wdWQgaXMgY2FsbGVkIGNvbmN1
cnJlbnRseS4NCj4gPg0KPiA+IEZveCBleGFtcGxlOg0KPiA+IGFsbG9jX2luaXRfcHVkIGlzIGNh
bGxlZCB3aGVuIGtlcm5lbF9pbml0LiBJZiBtZW1vcnkgaG90cGx1ZyB0aHJlYWQsDQo+ID4gd2hp
Y2ggd2lsbCBhbHNvIGNhbGwgYWxsb2NfaW5pdF9wdWQsIGhhcHBlbnMgZHVyaW5nIGtlcm5lbF9p
bml0LCB0aGUNCj4gPiByYWNlIGZvciBmaXhtYXAgb2NjdXJzLg0KPiA+DQo+ID4gVGhlIHJhY2Ug
Y29uZGl0aW9uIGZsb3cgY2FuIGJlOg0KPiA+DQo+ID4gKioqKioqKioqKioqKioqIGJlZ2luICoq
KioqKioqKioqKioqDQo+ID4NCj4gPiBrZXJlbmxfaW5pdCB0aHJlYWQgICAgICAgICAgICAgICAg
ICAgICAgICAgIHZpcnRpby1tZW0gd29ya3F1ZXVlIHRocmVhZA0KPiA+ID09PT09PT09PT09PT09
PT09PSAgICAgICAgICAgICAgICAgICAgICAgICAgPT09PT09PT0gPT09PT09PT09PT09PT09PT09
DQo+ID4gYWxsb2NfaW5pdF9wdWQoLi4uKQ0KPiA+ICAgcHVkcCA9IHB1ZF9zZXRfZml4bWFwX29m
ZnNldCguLikgICAgICAgICAgYWxsb2NfaW5pdF9wdWQoLi4uKQ0KPiA+IC4uLiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLi4uDQo+ID4gICAgIFJFQURfT05DRSgqcHVk
cCkgLy9PSyEgICAgICAgICAgICAgICAgICAgIHB1ZHAgPSBwdWRfc2V0X2ZpeG1hcF9vZmZzZXQo
DQo+ID4gLi4uICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAuLi4NCj4g
PiAgIHB1ZF9jbGVhcl9maXhtYXAoKSAvL2ZpeG1hcCBicmVhaw0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSRUFEX09OQ0UoKnB1ZHApIC8vQ1JBU0gh
DQo+ID4NCj4gPiAqKioqKioqKioqKioqKioqIGVuZCAqKioqKioqKioqKioqKioNCj4gPg0KPiA+
IEhlbmNlLCBhIHNwaW4gbG9jayBpcyBpbnRyb2R1Y2VkIHRvIHByb3RlY3QgdGhlIGZpeG1hcCBk
dXJpbmcgY3JlYXRlDQo+ID4gcGRnIG1hcHBpbmcuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBK
aWFueW9uZyBXdSA8amlhbnlvbmcud3VAYXJtLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm02
NC9tbS9tbXUuYyB8IDcgKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25z
KCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9tbS9tbXUuYyBiL2FyY2gvYXJt
NjQvbW0vbW11LmMgaW5kZXgNCj4gPiBhY2ZhZTliNDFjYzguLjk4YWMwOWFlOTU4OCAxMDA2NDQN
Cj4gPiAtLS0gYS9hcmNoL2FybTY0L21tL21tdS5jDQo+ID4gKysrIGIvYXJjaC9hcm02NC9tbS9t
bXUuYw0KPiA+IEBAIC02Myw2ICs2Myw3IEBAIHN0YXRpYyBwbWRfdCBibV9wbWRbUFRSU19QRVJf
UE1EXQ0KPiBfX3BhZ2VfYWxpZ25lZF9ic3MNCj4gPiBfX21heWJlX3VudXNlZDsgIHN0YXRpYyBw
dWRfdCBibV9wdWRbUFRSU19QRVJfUFVEXQ0KPiBfX3BhZ2VfYWxpZ25lZF9ic3MNCj4gPiBfX21h
eWJlX3VudXNlZDsNCj4gPg0KPiA+ICBzdGF0aWMgREVGSU5FX1NQSU5MT0NLKHN3YXBwZXJfcGdk
aXJfbG9jayk7DQo+ID4gK3N0YXRpYyBERUZJTkVfU1BJTkxPQ0soZml4bWFwX2xvY2spOw0KPiA+
DQo+ID4gIHZvaWQgc2V0X3N3YXBwZXJfcGdkKHBnZF90ICpwZ2RwLCBwZ2RfdCBwZ2QpICB7IEBA
IC0zMjksNiArMzMwLDExIEBADQo+ID4gc3RhdGljIHZvaWQgYWxsb2NfaW5pdF9wdWQocGdkX3Qg
KnBnZHAsIHVuc2lnbmVkIGxvbmcgYWRkciwgdW5zaWduZWQgbG9uZw0KPiBlbmQsDQo+ID4gIAl9
DQo+ID4gIAlCVUdfT04ocDRkX2JhZChwNGQpKTsNCj4gPg0KPiA+ICsJLyoNCj4gPiArCSAqIGZp
eG1hcCBpcyBnbG9iYWwgcmVzb3VyY2UsIHRodXMgaXQgbmVlZHMgdG8gYmUgcHJvdGVjdGVkIGJ5
IGEgbG9jaw0KPiA+ICsJICogaW4gY2FzZSBvZiByYWNlIGNvbmRpdGlvbi4NCj4gPiArCSAqLw0K
PiA+ICsJc3Bpbl9sb2NrKCZmaXhtYXBfbG9jayk7DQo+ID4gIAlwdWRwID0gcHVkX3NldF9maXht
YXBfb2Zmc2V0KHA0ZHAsIGFkZHIpOw0KPiA+ICAJZG8gew0KPiA+ICAJCXB1ZF90IG9sZF9wdWQg
PSBSRUFEX09OQ0UoKnB1ZHApOw0KPiA+IEBAIC0zNTksNiArMzY1LDcgQEAgc3RhdGljIHZvaWQg
YWxsb2NfaW5pdF9wdWQocGdkX3QgKnBnZHAsIHVuc2lnbmVkDQo+IGxvbmcgYWRkciwgdW5zaWdu
ZWQgbG9uZyBlbmQsDQo+ID4gIAl9IHdoaWxlIChwdWRwKyssIGFkZHIgPSBuZXh0LCBhZGRyICE9
IGVuZCk7DQo+ID4NCj4gPiAgCXB1ZF9jbGVhcl9maXhtYXAoKTsNCj4gPiArCXNwaW5fdW5sb2Nr
KCZmaXhtYXBfbG9jayk7DQo+ID4gIH0NCj4gPg0KPiA+ICBzdGF0aWMgdm9pZCBfX2NyZWF0ZV9w
Z2RfbWFwcGluZyhwZ2RfdCAqcGdkaXIsIHBoeXNfYWRkcl90IHBoeXMsDQo+ID4NCj4gDQo+IEFz
IHRoZSByYWNlIGNvdWxkIG9ubHkgaGFwcGVuIHdpdGggbWVtb3J5IGhvdHBsdWcgYmVpbmcgZW5h
YmxlZCwgY291bGQNCj4gbm90IHdlIHdyYXAgdGhpcyBhcm91bmQgd2l0aCBDT05GSUdfTUVNT1JZ
X0hPVFBMVUcsIGp1c3QgdG8gbmFycm93DQo+IGl0cyBzY29wZSBwb3NzaWJseSBzcGVlZCB1cCBv
dGhlciBub24taG90cGx1ZyBjYXNlcyA/DQoNCkkgdGhpbmsgaXQncyBiZXR0ZXIuDQoNClRoYW5r
cw0KSmlhbnlvbmcNCg==
