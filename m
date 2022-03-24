Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315474E662C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 16:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351316AbiCXPlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 11:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243459AbiCXPlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 11:41:02 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80058.outbound.protection.outlook.com [40.107.8.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBF39BB80;
        Thu, 24 Mar 2022 08:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTvXZVAt1SvNr7Ni7hKLSFAltwZgXS2eFh0TNCtE7RA=;
 b=9+7Q9ZrFP4l77Xvopgdks2+iGup3TU5+b73JchnWDVogHsghpQVMjqGVZBgfW8o2iI9AQyg4zFRuQSK3xj91XFNPvj5IQDg5zBOrmgzSN5/cEmHHho6Qp+yLqSxtwSkKXZztnW8kb/OFcWVde5hOVArTw0DQnIux9fORCxW3WJQ=
Received: from AS9PR0301CA0055.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::25) by AM9PR08MB6898.eurprd08.prod.outlook.com
 (2603:10a6:20b:301::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Thu, 24 Mar
 2022 15:39:24 +0000
Received: from AM5EUR03FT056.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:469:cafe::1f) by AS9PR0301CA0055.outlook.office365.com
 (2603:10a6:20b:469::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Thu, 24 Mar 2022 15:39:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT056.mail.protection.outlook.com (10.152.17.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.18 via Frontend Transport; Thu, 24 Mar 2022 15:39:23 +0000
Received: ("Tessian outbound 741ca6c82739:v113"); Thu, 24 Mar 2022 15:39:23 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6ebd503985f606d1
X-CR-MTA-TID: 64aa7808
Received: from e8e060811ec4.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id ABF84777-0879-4DED-B16C-5856886CC5BF.1;
        Thu, 24 Mar 2022 15:39:13 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e8e060811ec4.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 24 Mar 2022 15:39:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbRxjtQlWFH2XsFU49GJ/brzO+o9OAN7bLZ8j8arYmDdCtINU5xmJ0ZFqmad09rf9QV46f0Y05tlkZtH+bq3FEXwq3LOKOVw76JCf9ZzBUcDQ/vmXxkatzgntU4gR8yOUq45btMOZxUZ/FAxcCpk6GDdZaNgoPBqUDL6IqNrm9iWaHCLjzpKzqDVilxRLWJn/7G2hPXuxM+pVTXIC/H1eElWnLuB4j3sHmeL2At8m698DpimaMKEZu5ccTI72VKYSZJh5BWwMz0Ng+8X532xOhu4tIMRrzVYf9wsFqVL9bod4HSUwnTpMKf3ZqEfkgWErLh53DJqr4jePlIqGp9nSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTvXZVAt1SvNr7Ni7hKLSFAltwZgXS2eFh0TNCtE7RA=;
 b=gTlRD+2SJDWoFVRxkVXYWc3XA4JxE/M54jn2FMy19iMKWYC/AGc5URtcYzSx8zCHkY/jZVlg87fmfIv+55E06A6Ibzowl4eIm8ShZWpGqOInR/eeoZPjy6WEPSq/mwteZZpfnLkhbG5QnYGzhj34AQBHcPgUtw13D/8waH6NzkuX83FwkCwU5LxTh0pbdi8C/qEUWB0BSVYH2MGwrtv3PmERHa6lCqP/rqBEu2Ivo2ZYcoS373ZfzJhBltRH7WmeoRWq6Ru9HIsshotMZm9hWHTtYPGit6TDpL/MW7s3NdBQbnNlp/31ngiVUJZuRfm56tRYS1OLWL4R4ZqANp2HPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTvXZVAt1SvNr7Ni7hKLSFAltwZgXS2eFh0TNCtE7RA=;
 b=9+7Q9ZrFP4l77Xvopgdks2+iGup3TU5+b73JchnWDVogHsghpQVMjqGVZBgfW8o2iI9AQyg4zFRuQSK3xj91XFNPvj5IQDg5zBOrmgzSN5/cEmHHho6Qp+yLqSxtwSkKXZztnW8kb/OFcWVde5hOVArTw0DQnIux9fORCxW3WJQ=
Received: from DB9PR08MB6809.eurprd08.prod.outlook.com (2603:10a6:10:2ae::5)
 by AM9PR08MB7016.eurprd08.prod.outlook.com (2603:10a6:20b:41d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Thu, 24 Mar
 2022 15:39:09 +0000
Received: from DB9PR08MB6809.eurprd08.prod.outlook.com
 ([fe80::5171:1cf8:db0c:f85f]) by DB9PR08MB6809.eurprd08.prod.outlook.com
 ([fe80::5171:1cf8:db0c:f85f%7]) with mapi id 15.20.5102.016; Thu, 24 Mar 2022
 15:39:09 +0000
From:   Grant Likely <Grant.Likely@arm.com>
To:     Catalin Marinas <Catalin.Marinas@arm.com>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] Documentation/process: Update ARM contact for embargoed
 hardware issues
Thread-Topic: [PATCH] Documentation/process: Update ARM contact for embargoed
 hardware issues
Thread-Index: AQHYP5IiVjc98xBl/UmNGY7AEFMazazOq3aY
Date:   Thu, 24 Mar 2022 15:39:09 +0000
Message-ID: <F5B89578-5AEE-4C29-B146-B84265FD2B4E@arm.com>
References: <20220324151605.266645-1-catalin.marinas@arm.com>
In-Reply-To: <20220324151605.266645-1-catalin.marinas@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: c7ccf84f-42cc-44b2-e6c5-08da0dac78e7
x-ms-traffictypediagnostic: AM9PR08MB7016:EE_|AM5EUR03FT056:EE_|AM9PR08MB6898:EE_
X-Microsoft-Antispam-PRVS: <AM9PR08MB68980FF6B026B04BB1BEFF0895199@AM9PR08MB6898.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: TrN0TiLf1e6Y3ipIExZ0v619YGyz0oefCuzU0sYOAjLm6VoCjxpHlLNMo/A8wGpAA9cVgkA9rlfUIGd4+lps9NT/jNw5JoSzQdzurXhzoAdN1CKWVTXyDsXzWmIT4/A8iblpQ5M0ZWQfmTHjtcrS9L8bZGlXiprLj+FTec+ELASHDoAjSO8AALyZG4X9FLC4D7CGM/2Oui2oI2gS1bc6Uu882KjfM08489LDJfwK3+/bKqAFQfbRBlibLJdjfqNUjIHDoJZ48sHOUtx0V7y08hOA513j0CDcrm+Epg/sE61EIzNlDYgg4vqja3KZx7TQdouu+9SwZfSxO2lMsIDD92MxvDkKBjrPjG58GcAl2X6+aOozbTu1Qq9qbG4pTSmRKzZ6jg74NNlJGHfFIWmxVJkLatEZorj7AT84znSj2vaMRiwL2/N8V1qjUvMWLTa5k/3Kw3DVmC0gmtriegtPEz8Lxt9Y/9VCmrx8A4MteTerydG+2OtPMldLouACZxTLjHzgWX+VUTeAVbgtFAs7dh2MNRSGfxEA6H6bZOdm/YCAxYbKnp+tz2Re87BNNPHbq8Jn75lPN8+rKoypJBADCn+r3qeb2ttofrBskSYGvutXDYcweV1iTeBs+klV4KlWkdeR6mBppLvuGX62a1TkXv5WDbQeVDht4Xg0l4GlcSlhmfhIBkNzXnmcwKmiZmYRWJrmcngtDh2Pmt3pnXd0q5Xx4V33T/fkWROvoR6qCKAz2eekepcU4yUHtk1tCz8H
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6809.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(66946007)(91956017)(4326008)(8676002)(64756008)(36756003)(66446008)(83380400001)(66476007)(6862004)(38070700005)(8936002)(5660300002)(33656002)(66556008)(6636002)(6486002)(316002)(508600001)(71200400001)(37006003)(2906002)(15650500001)(54906003)(26005)(6512007)(2616005)(186003)(6506007)(53546011)(86362001)(38100700002)(122000001)(45980500001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB7016
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT056.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3b908f11-7382-4195-3f4b-08da0dac7018
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J7YtB6zw+z/OjkrMTSaw0bH2eYHMKGmteOyWbOH1I5780A1mPgakux/+FiOvsqjisNy8C5GzPgyxQd9uINToWHGL/9C9cuiO9DULR5QOYy+kYNK7z80in3oigMVKHAHhhhyNJF6zuo5Z40UKQ8hRHpcsvxhlSf60uDWmAH2b+kT3ND6YKcWq9aZ/jk7nwU0u+LE7MY0/ZJM0LwAGTJp7kW+/hx5eg1s43XYVCULw+1W39LVSuaxXfFcEFUVEldcEKHdl53QXjLI7m3OBIBhxNqdJzMIGsBobwlMXLC14swpLMQVDhPWOq/lLlf72uCQjTIe9ZjfEBQbgn/gFCjmDDjljC5F2K7ZYNrjfXOzMRlnSbCSMa/DArhHzdgu3W+vsYLpglHROu78n1Ij0FkayA2EtRAiOMuosrj+YNHmKIAVKwrrDEZE0Xq7O7c32zFslEKGHVcHT8HQgi80rDagH5gRO+aYjNIpz4jnlt9dOB80l7x/lWe5Pe26PK8YIGbq24kJk6xJH8r1LhN3dlwKGY1kzCQHWdqjDOvx6fVgKN3XUadFQBoLAzJFW/815Pala8WMaw99iKePAbOOF3f3NP+82XDIunDJo2sN2WNPf1TvoEnOOiOPpavm/AFiEKmbVrwUwsM4kd3AfKBPuR8LnLPVUvHVfGPWc+JtO1nmNZY5DNV8ifP7sg6RBlmUMJ3SL
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(450100002)(336012)(6862004)(2906002)(8676002)(6506007)(53546011)(70586007)(356005)(4326008)(40460700003)(82310400004)(15650500001)(26005)(70206006)(186003)(107886003)(2616005)(6512007)(8936002)(33656002)(5660300002)(81166007)(86362001)(83380400001)(36860700001)(37006003)(47076005)(54906003)(6486002)(36756003)(508600001)(316002)(6636002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 15:39:23.9252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ccf84f-42cc-44b2-e6c5-08da0dac78e7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT056.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6898
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIDI0IE1hciAyMDIyLCBhdCAxNToxNiwgQ2F0YWxpbiBNYXJpbmFzIDxDYXRhbGluLk1h
cmluYXNAYXJtLmNvbT4gd3JvdGU6DQo+DQo+IO+7v1dpdGggR3JhbnQgdGFraW5nIGEgcHJvbWlu
ZW50IHJvbGUgaW4gTGluYXJvLCBJIHdpbGwgdGFrZSBvdmVyIGFzIHRoZQ0KPiBwcm9jZXNzIGFt
YmFzc2Fkb3IgZm9yIEFSTSB3LnIudC4gZW1iYXJnb2VkIGhhcmR3YXJlIGlzc3Vlcy4NCj4NCj4g
U2lnbmVkLW9mZi1ieTogQ2F0YWxpbiBNYXJpbmFzIDxjYXRhbGluLm1hcmluYXNAYXJtLmNvbT4N
Cj4gQ2M6IEdyYW50IExpa2VseSA8Z3JhbnQubGlrZWx5QGFybS5jb20+DQo+IENjOiBKb25hdGhh
biBDb3JiZXQgPGNvcmJldEBsd24ubmV0Pg0KPiBDYzogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVn
a2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCg0KQWNrZWQtYnk6IEdyYW50IExpa2VseSA8Z3JhbnQu
bGlrZWx5QGFybS5jb20+DQoNCj4gLS0tDQo+IERvY3VtZW50YXRpb24vcHJvY2Vzcy9lbWJhcmdv
ZWQtaGFyZHdhcmUtaXNzdWVzLnJzdCB8IDIgKy0NCj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3By
b2Nlc3MvZW1iYXJnb2VkLWhhcmR3YXJlLWlzc3Vlcy5yc3QgYi9Eb2N1bWVudGF0aW9uL3Byb2Nl
c3MvZW1iYXJnb2VkLWhhcmR3YXJlLWlzc3Vlcy5yc3QNCj4gaW5kZXggNmY4ZjM2ZTEwZThiLi40
MWEyYWZhYWVhNzUgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vcHJvY2Vzcy9lbWJhcmdv
ZWQtaGFyZHdhcmUtaXNzdWVzLnJzdA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL3Byb2Nlc3MvZW1i
YXJnb2VkLWhhcmR3YXJlLWlzc3Vlcy5yc3QNCj4gQEAgLTI0NCw3ICsyNDQsNyBAQCBkaXNjbG9z
dXJlIG9mIGEgcGFydGljdWxhciBpc3N1ZSwgdW5sZXNzIHJlcXVlc3RlZCBieSBhIHJlc3BvbnNl
IHRlYW0gb3IgYnkNCj4gYW4gaW52b2x2ZWQgZGlzY2xvc2VkIHBhcnR5LiBUaGUgY3VycmVudCBh
bWJhc3NhZG9ycyBsaXN0Og0KPg0KPiAgID09PT09PT09PT09PT0gPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gLSAgQVJNICAgICAgICAg
ICBHcmFudCBMaWtlbHkgPGdyYW50Lmxpa2VseUBhcm0uY29tPg0KPiArICBBUk0gICAgICAgIENh
dGFsaW4gTWFyaW5hcyA8Y2F0YWxpbi5tYXJpbmFzQGFybS5jb20+DQo+ICAgQU1EICAgICAgICBU
b20gTGVuZGFja3kgPHRvbS5sZW5kYWNreUBhbWQuY29tPg0KPiAgIElCTSBaICAgICAgICAgQ2hy
aXN0aWFuIEJvcm50cmFlZ2VyIDxib3JudHJhZWdlckBkZS5pYm0uY29tPg0KPiAgIElCTSBQb3dl
ciAgICAgQW50b24gQmxhbmNoYXJkIDxhbnRvbkBsaW51eC5pYm0uY29tPg0KSU1QT1JUQU5UIE5P
VElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBhcmUg
Y29uZmlkZW50aWFsIGFuZCBtYXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJZiB5b3UgYXJlIG5vdCB0
aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRl
bHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGUgY29udGVudHMgdG8gYW55IG90aGVyIHBlcnNvbiwg
dXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUgb3IgY29weSB0aGUgaW5mb3JtYXRpb24g
aW4gYW55IG1lZGl1bS4gVGhhbmsgeW91Lg0K
