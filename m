Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCC449DA95
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 07:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbiA0GZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 01:25:09 -0500
Received: from mail-vi1eur05on2058.outbound.protection.outlook.com ([40.107.21.58]:46557
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233691AbiA0GZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 01:25:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8mQ5rZLYhQVZydxnhhyuQHj89tR66I25jutSO2Uizs=;
 b=rTZ8OpQWLn+7tMVrYB+RgmYM3P4HshqNfhYSuj7ztq7EA4adtO6Tuo1rbb7ZQajqLZRqCYBybR9EzV3y0keMQkMhgwveicb55gzbIXyQKfTpfdUniICBFkJtHtfawrT34P9hMbV5UJn0PhhJU/ddC25dsOdwUDnjFSV3XedWbN4=
Received: from DB6PR0202CA0006.eurprd02.prod.outlook.com (2603:10a6:4:29::16)
 by VI1PR0802MB2560.eurprd08.prod.outlook.com (2603:10a6:800:ad::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 06:25:03 +0000
Received: from DB5EUR03FT006.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:29:cafe::e2) by DB6PR0202CA0006.outlook.office365.com
 (2603:10a6:4:29::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Thu, 27 Jan 2022 06:25:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT006.mail.protection.outlook.com (10.152.20.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 06:25:03 +0000
Received: ("Tessian outbound 741ca6c82739:v113"); Thu, 27 Jan 2022 06:25:03 +0000
X-CR-MTA-TID: 64aa7808
Received: from 823f1cda41b5.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 93863D82-36EE-43D0-B0F8-F67150443D88.1;
        Thu, 27 Jan 2022 06:24:52 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 823f1cda41b5.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 27 Jan 2022 06:24:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6ddTKSLDsFdmfeIrAPPVGXlju3Iynsiv45HqIxxSoA0SZemzwTzu86Yn2DglRtwHSteS2koiWu/Yq/hQzAVBr7yCPvq5JxjK6FSBqbL7khyl1k2d+H+6BdSjaJJ+EWXbyD7sEHY45Cnn6ZrS4Wo0yP5BEueJjazVKkB8zG2A7jc8JhUL1xiFLDPNMdOYWTjznrQx1Teewd3TLd7q6jdnZ3Thjh5JQP+cn6446nVXqihnodmV3gYXcyWjY2mejYz95r/aFRU72c76CokXdCrc2FDrlCMfZKDRTIFHfSr4jxTsLZDyz9xARKvfF17zhiaqukn6Gwl55n88+RkE7c1/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8mQ5rZLYhQVZydxnhhyuQHj89tR66I25jutSO2Uizs=;
 b=RYInjcdqpVF5iwzA99y0eUNs7S9ClylcEnUVYW5SK7NuzuIUDFhwX/Qv9F0oUVDB0xUV5+FJGBKzmn/6WvDUGMy+M9PGQMiqOWEpu4n+8QOKDScK7Vkh0y6d+eZ0PXAwPbPg7Np64vfb/+X3pO1SkTzPjyC7olUB8vm4ILH0JkuhiDjODqu9OHjj8iUVTvwy+n3WgLwPSRoHFEvxJVG0aN/X2l/67DaOyOmGnc8ocfbnKmG+FL/0ZEgwIk5V+jJ4K/oNOd19IfTJ0EzwjOvR5QcdvHtc+JKnmiIccj43QQyIh7kNrEXujjgVC9UEWxBWrJRPb3/k3eBg4qZA6Y2BVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8mQ5rZLYhQVZydxnhhyuQHj89tR66I25jutSO2Uizs=;
 b=rTZ8OpQWLn+7tMVrYB+RgmYM3P4HshqNfhYSuj7ztq7EA4adtO6Tuo1rbb7ZQajqLZRqCYBybR9EzV3y0keMQkMhgwveicb55gzbIXyQKfTpfdUniICBFkJtHtfawrT34P9hMbV5UJn0PhhJU/ddC25dsOdwUDnjFSV3XedWbN4=
Received: from AM9PR08MB7276.eurprd08.prod.outlook.com (2603:10a6:20b:437::11)
 by PAXPR08MB6541.eurprd08.prod.outlook.com (2603:10a6:102:15a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 06:24:50 +0000
Received: from AM9PR08MB7276.eurprd08.prod.outlook.com
 ([fe80::8019:e2fd:66c7:aa4e]) by AM9PR08MB7276.eurprd08.prod.outlook.com
 ([fe80::8019:e2fd:66c7:aa4e%7]) with mapi id 15.20.4930.015; Thu, 27 Jan 2022
 06:24:50 +0000
From:   Jianyong Wu <Jianyong.Wu@arm.com>
To:     David Hildenbrand <david@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>
CC:     Justin He <Justin.He@arm.com>, "will@kernel.org" <will@kernel.org>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_qiancai@quicinc.com" <quic_qiancai@quicinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gshan@redhat.com" <gshan@redhat.com>, nd <nd@arm.com>
Subject: RE: [PATCH v3] arm64/mm: avoid fixmap race condition when create pud
 mapping
Thread-Topic: [PATCH v3] arm64/mm: avoid fixmap race condition when create pud
 mapping
Thread-Index: AQHX8lbt013/nzm8RUa6mdFr92d9v6xU2ImAgAELwWCAAGL4AIABFwGwgAAjrYCAHXF+gIAAR6QAgAAGaOCAABRIgIAAAXgAgAABfiCAAAIvAIAAAEEAgAFJh/A=
Date:   Thu, 27 Jan 2022 06:24:50 +0000
Message-ID: <AM9PR08MB7276062BC7B474174FFFA11BF4219@AM9PR08MB7276.eurprd08.prod.outlook.com>
References: <20211216082812.165387-1-jianyong.wu@arm.com>
 <YdXdjcJ7jbnkFsqp@arm.com>
 <AM9PR08MB7276E0DE6B4224C22B20A89CF44C9@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <YdcRLohx777jzWah@arm.com>
 <AM9PR08MB7276B412F02CA0431E30E06CF44D9@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <YdgZJ/mBG+BCxmEv@arm.com>
 <DB7PR08MB3737631DEE8D6625D3A9E393F7209@DB7PR08MB3737.eurprd08.prod.outlook.com>
 <CAMj1kXF7DJ5UeMn=9gw_Hs3Fa525OFEPsriO=ZprT3rN83=qtQ@mail.gmail.com>
 <AM9PR08MB72763D5DA0C5F22D2126ABF4F4209@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <CAMj1kXGjAxd2xb0u1PLSLGAe8jJdhJm3wR+y=7qB4C1J6Ebgcw@mail.gmail.com>
 <3e6513f9-77ca-79e5-d185-7e9a11ec7689@redhat.com>
 <AM9PR08MB72764111B775352448D75CD9F4209@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <65fdd873-1f93-56e3-c7a5-98d621c5dbd8@redhat.com>
 <7eb4bc77-c1db-99c4-4c77-ae9ddd159abb@redhat.com>
In-Reply-To: <7eb4bc77-c1db-99c4-4c77-ae9ddd159abb@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: ardb@kernel.org,Catalin.Marinas@arm.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: DD59A1CB5AFC0F49A52052DDA9918C83.0
x-checkrecipientchecked: true
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: 9830eca5-65df-4626-2463-08d9e15dc0b3
x-ms-traffictypediagnostic: PAXPR08MB6541:EE_|DB5EUR03FT006:EE_|VI1PR0802MB2560:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0802MB2560A7D5F1BFA643380BE6A4F4219@VI1PR0802MB2560.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 4u2RFJSY0mC9COy/Z3Ws0wlFVelYTL81KKqEszEZqG2JMvfAWFLoS3qvx5niIvCaRmIWoRU/aC4WAyzucmN51Rzn4JuoQbjnf9Hl/4FAoXnn+vAm3RcwyYHPJDbkbeM91fitxR3sSMQc/bUq6FjOjRHAtVeiCxKPvIn+YmLqbH/Op0ytynfdH7Y1XqYPCxtrUCp/fC/5pgjqvsyA5thgG6cRIwo3DrhpZ2y0XIzKtpHciINrTVuLezRI0rfTFWleTY8Lm0jnVugt+/Qnk2OeXAJEq05efcpYk3wWDilUG6+sc6Y8igxVBrlZqExEOJ2kaH3JjNEc4l4vy4fXurXCtDtUBP6BEx+YH3nUx6T4YDIqKzHfBV/Lj1pngz+hE+x1M0Pv9kkPy3MspMTdrYtPoILQ2LERoDMlGjcCL0lAXTozBnIkRrBkzqbZfdHkD0tBOnr5U17OYZTd71LWndvhwtjdGROjdzynTONyzHsHmFZ5az7TiDDRQ75d+NXUMnHR3MoKPPs+YjyzdLxh1m+gClnYE8QEmVKU8r2XjVtN+B7QJnfac5wWYHuJ3806ihpjUj4Kmq1HUjDKNcIqbKds+9yRwPq2XJ3m9NU/N3TPYO3N/t9MCfz4V/K/n3DjnhmRGXGNiSHMyPgGqigsuyRksXlsRPUVtnU9lze6T5s31pia1hQhtBQVmz/7kwuuFvhkf7UBoFqjtUTLBaBkg7q1YA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7276.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(54906003)(38070700005)(316002)(9686003)(66946007)(122000001)(6636002)(38100700002)(5660300002)(76116006)(66476007)(508600001)(6506007)(7696005)(71200400001)(186003)(52536014)(2906002)(66446008)(64756008)(26005)(66556008)(8676002)(4326008)(8936002)(55016003)(33656002)(86362001)(83380400001)(20210929001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6541
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT006.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 261df72c-2296-48ed-f6c5-08d9e15db928
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fXaT0Xut7h6gemhpRWtN7PMZYuumTqhZdxduytMVc6KJRVcbjVVisQaOKa6hklsl+Ba28aX0/ZxzrCHg1NCZRQlBdbGiHLJaceHqEtRd2X+AKjQDZSZo+ODr9tMa0dhQRAi1HXMBKM8vcsWQQxn6A/Xcq8Oy3aVLooXzTMz4U+PyvhVJuSjaHyCAqMjqrR7ve9sgyMrzGNKQTAVXqoZbK/t78ysoFtTVnqHJO+Sck8KPwHOPBy8eykqaZR9sD+1zkxp+0urC7J9L7cv/MmSK/Bx9h5W0ilXNMpbLA1bMzXRmCF819xzyi/dem3WzSvz7S3ZfRAjK71XCI/uEI1UHvrQVmcDmR+wZmbGzrEHbMr2UbgrKSRWv9TuQmyPJ1UUDsK84ewZnyFsDz9AfZGCv+FJXLTEGaQ2AB6BTKaQRsKMjVyas+syibme46sma7KWuZxDXHuYHr0u/2cbzAE/aRDfAYDWWxp7X8yx3uQL2eToV8B8lKg+SK39+BPXRiC/8u7vckqmgM17I3qoKyk7+h9tLDZTiXzt00DX5IG+dtfNpjCEqIu2K/t9mdSVXGvrjQIhwGqnieeaViUo9T3aQltw6CqHXskeSZ55bF0rxSTssosxaNlBU6YtANtd+llbQlDkgC1LWpLq3Y0MZKyg1gILnyTxgfeL6EuH36C6zp2qO90NEXiOI8mZERF7sAFxe
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(54906003)(86362001)(6506007)(110136005)(7696005)(336012)(508600001)(5660300002)(6636002)(2906002)(316002)(52536014)(26005)(186003)(83380400001)(9686003)(40460700003)(33656002)(70206006)(70586007)(4326008)(8676002)(8936002)(47076005)(36860700001)(81166007)(356005)(55016003)(82310400004)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 06:25:03.0653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9830eca5-65df-4626-2463-08d9e15dc0b3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT006.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2560
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGF2aWQsDQoNCj4gPj4+Pj4+IFRoYW5rcyBmb3IgdHJhY2tpbmcgdGhhdCBkb3duLg0KPiA+
Pj4+Pj4NCj4gPj4+Pj4+IE5vdGUgdGhhdCBjbGVhcmluZyB0aGUgQlNTIHR3aWNlIGlzIG5vdCB0
aGUgcm9vdCBwcm9ibGVtIGhlcmUuDQo+ID4+Pj4+PiBUaGUgcm9vdCBwcm9ibGVtIGlzIHRoYXQg
d2Ugc2V0IGdsb2JhbCBzdGF0ZSB3aGlsZSB0aGUga2VybmVsDQo+ID4+Pj4+PiBydW5zIGF0IHRo
ZSBkZWZhdWx0IGxpbmsgdGltZSBhZGRyZXNzLCBhbmQgdGhlbiByZWZlciB0byBpdCBhZ2Fpbg0K
PiA+Pj4+Pj4gYWZ0ZXIgdGhlIGVudGlyZSBrZXJuZWwgaGFzIGJlZW4gc2hpZnRlZCBpbiB0aGUg
a2VybmVsIFZBIHNwYWNlLg0KPiA+Pj4+Pj4gU3VjaCBnbG9iYWwgc3RhdGUgY291bGQgY29uc2lz
dCBvZiBtdXRhYmxlIHBvaW50ZXJzIHRvIHN0YXRpY2FsbHkNCj4gPj4+Pj4+IGFsbG9jYXRlZCBk
YXRhICh3aGljaCB3b3VsZCBiZSByZXNldCB0byB0aGVpciBkZWZhdWx0IHZhbHVlcw0KPiA+Pj4+
Pj4gYWZ0ZXIgdGhlIHJlbG9jYXRpb24gY29kZQ0KPiA+Pj4gcnVucyBhZ2FpbiksIG9yIGdsb2Jh
bCBwb2ludGVyIHZhcmlhYmxlcyBpbiBCU1MuDQo+ID4+Pj4+PiBJbiBlaXRoZXIgY2FzZSwgcmVs
eWluZyBvbiBzdWNoIGEgZ2xvYmFsIHZhcmlhYmxlIGFmdGVyIHRoZQ0KPiA+Pj4+Pj4gc2Vjb25k
IHJlbG9jYXRpb24gcGVyZm9ybWVkIGJ5IEtBU0xSIHdvdWxkIGJlIHJpc2t5LCBhbmQgc28gd2UN
Cj4gPj4+Pj4+IHNob3VsZCBhdm9pZCBtYW5pcHVsYXRpbmcgZ2xvYmFsIHN0YXRlIGF0IGFsbCBp
ZiBpdCBtaWdodCBpbnZvbHZlDQo+ID4+Pj4+PiBwb2ludGVyIHRvIHN0YXRpY2FsbHkgYWxsb2Nh
dGVkIGRhdGEgc3RydWN0dXJlcy4NCj4gPj4+Pj4+DQo+ID4+Pj4+Pj4gSW4gb3RoZXIgd2F5cywg
aWYgd2UgaW52b2tlIG11dGV4X2xvY2svdW5sb2NrIGluIHN1Y2ggYSBlYXJseQ0KPiA+Pj4+Pj4+
IGJvb3RpbmcNCj4gPj4+IHN0YWdlLg0KPiA+Pj4+Pj4+IEl0IG1pZ2h0IGJlIHVuc2FmZSBiZWNh
dXNlIGxvY2tkZXAgaW5zZXJ0cyBsb2NrX2FjcXVpcmUvcmVsZWFzZQ0KPiA+Pj4+Pj4+IGFzIHRo
ZSBjb21wbGV4IGhvb2tzLg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4gSW4gc3VtbWFyeSwgd291bGQg
aXQgYmV0dGVyIGlmIEppYW55b25nIHNwbGl0cyB0aGVzZSBlYXJseSBib290DQo+ID4+Pj4+Pj4g
YW5kIGxhdGUgYm9vdCBjYXNlPyBlLmcuIGludHJvZHVjZSBhIG5vbG9jayB2ZXJzaW9uIGZvcg0K
PiA+Pj4+Pj4gY3JlYXRlX21hcHBpbmdfbm9hbGxvYygpLg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4g
V2hhdCBkbyB5b3UgdGhpbmsgb2YgaXQ/DQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+DQo+ID4+Pj4+PiBU
aGUgcHJlLUtBU0xSIGNhc2UgZGVmaW5pdGVseSBkb2Vzbid0IG5lZWQgYSBsb2NrLiBCdXQgZ2l2
ZW4gdGhhdA0KPiA+Pj4+Pj4gY3JlYXRlX21hcHBpbmdfbm9hbGxvYygpIGlzIG9ubHkgdXNlZCB0
byBtYXAgdGhlIEZEVCwgd2hpY2gNCj4gPj4+Pj4+IGhhcHBlbnMgdmVyeSBlYXJseSBvbmUgd2F5
IG9yIHRoZSBvdGhlciwgd291bGRuJ3QgaXQgYmUgYmV0dGVyIHRvDQo+ID4+Pj4+PiBtb3ZlIHRo
ZSBsb2NrL3VubG9jayBpbnRvIG90aGVyIGNhbGxlcnMgb2YNCj4gPj4+Pj4+IF9fY3JlYXRlX3Bn
ZF9tYXBwaW5nKCk/IChhbmQgbWFrZSBzdXJlIG5vIG90aGVyIHVzZXJzIG9mIHRoZQ0KPiA+Pj4+
Pj4gZml4bWFwIHNsb3RzIGV4aXN0KQ0KPiA+Pj4+Pg0KPiA+Pj4+PiBUaGVyZSBhcmUgc2VydmVy
IGNhbGxlcnMgb2YgX19jcmVhdGVfcGdkX21hcHBpbmcuIEkgdGhpbmsgc29tZSBvZg0KPiA+Pj4+
PiB0aGVtDQo+ID4+PiBuZWVkIG5vIGZpeG1hcCBsb2NrIGFzIHRoZXkgYXJlIGNhbGxlZCBzbyBl
YXJseS4gSSBmaWd1cmUgb3V0IGFsbCBvZiB0aGVtDQo+IGhlcmU6DQo+ID4+Pj4+IGNyZWF0ZV9t
YXBwaW5nX25vYWxsb2M6ICAgbm8gbG9jaw0KPiA+Pj4+PiBjcmVhdGVfcGdkX21hcHBpbmc6ICAg
bm8gbG9jaw0KPiA+Pj4+PiBfX21hcF9tZW1ibG9jazogICAgbm8gbG9jaw0KPiA+Pj4+PiBtYXBf
a2VybmVsX3NlZ21lbnQ6ICBubyBsb2NrDQo+ID4+Pj4+IG1hcF9lbnRyeV90cmFtcG9saW5lOiBu
byBsb2NrDQo+ID4+Pj4+IHVwZGF0ZV9tYXBwaW5nX3Byb3Q6ICAgIG5lZWQgbG9jaw0KPiA+Pj4+
PiBhcmNoX2FkZF9tZW1vcnk6ICBuZWVkIGxvY2sNCj4gPj4+Pj4NCj4gPj4+Pj4gV0RZVD8NCj4g
Pj4+Pj4NCj4gPj4+Pg0KPiA+Pj4+IFRoYXQgc2VlbXMgcmVhc29uYWJsZSwgYnV0IGl0IG5lZWRz
IHRvIGJlIGRvY3VtZW50ZWQgY2xlYXJseSBpbiB0aGUNCj4gY29kZS4NCj4gPj4+Pg0KPiA+Pj4N
Cj4gPj4+IEp1c3QgYSByYW5kb20gdGhvdWdodCwgY291bGQgd2UgcmVseSBvbiBzeXN0ZW1fc3Rh
dGUgdG8gZG8gdGhlDQo+ID4+PiBsb2NraW5nIGNvbmRpdGlvbmFsbHk/DQo+ID4+DQo+ID4+IEkg
Y2FuJ3Qgc2VlIHRoZSBwb2ludC4gQXQgdGhlIGVhcmx5IHN0YWdlcyBvZiBrZXJuZWwgYm9vdCwg
d2UgZGVmaW5pdGVseQ0KPiBuZWVkIG5vIGxvY2suIEFsc28sIEkgdGhpbmsgd2Ugc2hvdWxkIGtl
ZXAgaXQgc2ltcGxlLg0KPiA+Pg0KPiA+DQo+ID4gSXMgZS5nLiwNCj4gPg0KPiA+IGlmIChzeXN0
ZW1fc3RhdGUgPCBTWVNURU1fUlVOTklORykNCj4gPiAJLyogbG9jayAqLw0KPiA+DQo+ID4gaWYg
KHN5c3RlbV9zdGF0ZSA8IFNZU1RFTV9SVU5OSU5HKQ0KPiA+IAkvKiB1bmxvY2sgKi8NCj4gDQo+
IG9mIGNvdXJzZSwgaW52ZXJ0aW5nIHRoZSBjb25kaXRpb25zIDspDQoNClllcywgc3lzdGVtX3N0
YXRlIGNhbiByb3VnaGx5IHNlcGFyYXRlIHRoZXNlIGNhbGxlcnMgb2YgX19jcmVhdGVfcGdkX21h
cHBpbmcuIFdoZW4gc3lzdGVtX3N0YXRlID4gU1lTVEVNX0JPT1RJTkcgd2UgY2FuIGFkZCB0aGUg
bG9jay4NClRodXMsIEkgaGF2ZSB0aGUgZm9sbG93aW5nIGNoYW5nZToNCg0Kc3RhdGljIERFRklO
RV9TUElOTE9DSyhzd2FwcGVyX3BnZGlyX2xvY2spOw0KK3N0YXRpYyBERUZJTkVfTVVURVgoZml4
bWFwX2xvY2spOw0KDQogdm9pZCBzZXRfc3dhcHBlcl9wZ2QocGdkX3QgKnBnZHAsIHBnZF90IHBn
ZCkNCiB7DQpAQCAtMzI5LDYgKzMzMCw4IEBAIHN0YXRpYyB2b2lkIGFsbG9jX2luaXRfcHVkKHBn
ZF90ICpwZ2RwLCB1bnNpZ25lZCBsb25nIGFkZHIsIHVuc2lnbmVkIGxvbmcgZW5kLA0KICAgICAg
ICB9DQogICAgICAgIEJVR19PTihwNGRfYmFkKHA0ZCkpOw0KDQorICAgICAgIGlmIChzeXN0ZW1f
c3RhdGUgPiBTWVNURU1fQk9PVElORykNCisgICAgICAgICAgICAgICBtdXRleF9sb2NrKCZmaXht
YXBfbG9jayk7DQogICAgICAgIHB1ZHAgPSBwdWRfc2V0X2ZpeG1hcF9vZmZzZXQocDRkcCwgYWRk
cik7DQogICAgICAgIGRvIHsNCiAgICAgICAgICAgICAgICBwdWRfdCBvbGRfcHVkID0gUkVBRF9P
TkNFKCpwdWRwKTsNCkBAIC0zNTksNiArMzYyLDggQEAgc3RhdGljIHZvaWQgYWxsb2NfaW5pdF9w
dWQocGdkX3QgKnBnZHAsIHVuc2lnbmVkIGxvbmcgYWRkciwgdW5zaWduZWQgbG9uZyBlbmQsDQog
ICAgICAgIH0gd2hpbGUgKHB1ZHArKywgYWRkciA9IG5leHQsIGFkZHIgIT0gZW5kKTsNCg0KICAg
ICAgICBwdWRfY2xlYXJfZml4bWFwKCk7DQorICAgICAgIGlmIChzeXN0ZW1fc3RhdGUgPiBTWVNU
RU1fQk9PVElORykNCisgICAgICAgICAgICAgICBtdXRleF91bmxvY2soJmZpeG1hcF9sb2NrKTsN
CiB9DQoNCkl0IHNlZW1zIHdvcmsgYW5kIHNvbWVob3cgc2ltcGVyLiBCdXQgSSBkb24ndCBrbm93
IGlmIGl0IGlzIHJlYXNvbmFibGUgdG8gZG8gdGhpcy4gU28sIGFueSBpZGVhPyBAQXJkIEJpZXNo
ZXV2ZWwgIEBDYXRhbGluIE1hcmluYXMgDQoNClRoYW5rcw0KSmlhbnlvbmcNCg0KPiANCj4gDQo+
IC0tDQo+IFRoYW5rcywNCj4gDQo+IERhdmlkIC8gZGhpbGRlbmINCg0K
