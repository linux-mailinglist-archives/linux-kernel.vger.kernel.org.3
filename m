Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2012952A9BC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 19:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351718AbiEQR4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 13:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351691AbiEQR4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 13:56:05 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70078.outbound.protection.outlook.com [40.107.7.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F4C40A2B
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 10:56:00 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=LW1feAqy4Np5yfICvM6P8Tf/edpoYsRCI3O9Xuncf+EzCeKdbUuD6OzTqhek9Nq4r5pUoMf7X1iWPG9fMcywIt4Q66ckXx3YmMCe4OeZP/DnAxp4Q9AwhEsAQQSqJTizY4oDKN10eKokwu8Bi+Ybh3xSAWdzugwPeniY6gOH3jEp/GPkxWe08TfscJUX0M19EK7efQMhIXeZTP00Fr19SPFgA+qH0GvSSXhVpU5hAmF6u+R4fPwwz3Ft6nWtpDi4rNFKs84KZLZyLtf+bJgh1OuDMf29hefu8IjHaLWpkpPUJ1OD8Y60I72Vfzz6w63u+uUVi6UjZaEW+Mq2ggVtdg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctcBnQUJsOJ51XRSgi0eHEtQvbvVJ7L65lH2SlZNidc=;
 b=ZrQnocdAG+qRxz3ImrVAaYpLTGRP+hiYNVrmcQhx9RoB7prB5wCtNsrGFeL+m3dmwRijsoSsEevYZsH1lx/m3wIIOjlf5DsBcFYaInHAq7dqMlQKWN93G83a0nlQmAtFGZTaiQFruCoZiXm801LGVAmniL2+dJON5mx4tMJopocruRs0dG3KYPXVjzP9yEj3vBOpJ9xwK0OkoKbdTfiXzndg9jRTeUMktr406GzJWYEpYlN+g+5837+B4Hk+nC2dK+X6vQ65PSzVTqan/qgG4zkvv77WZUJXeZumuWyalLufkQT9XQbpNINf5hT4UC7PTtDb7ejJwuOW+7n4DVjyqw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctcBnQUJsOJ51XRSgi0eHEtQvbvVJ7L65lH2SlZNidc=;
 b=AwXz2agetDxRMlqvZKkNe5RPd1e+/bWH8TSyc478FlDYjtKIHAutkxr3gaR1Q2nSpPmztN5xXpGF2LmgR3Xvtc3InhbbiYwzgdxzM8hH1nEGN7AjkzIdCxExSfs3weOJHvojplUwTCiWnSLI3u/pBl+f9rNDJhbA8fDV3pGn8X4=
Received: from DB6P18901CA0022.EURP189.PROD.OUTLOOK.COM (2603:10a6:4:16::32)
 by AM0PR08MB3745.eurprd08.prod.outlook.com (2603:10a6:208:ff::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 17:55:58 +0000
Received: from DBAEUR03FT055.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:16:cafe::3f) by DB6P18901CA0022.outlook.office365.com
 (2603:10a6:4:16::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13 via Frontend
 Transport; Tue, 17 May 2022 17:55:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT055.mail.protection.outlook.com (100.127.142.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13 via Frontend Transport; Tue, 17 May 2022 17:55:57 +0000
Received: ("Tessian outbound 42cead292588:v119"); Tue, 17 May 2022 17:55:57 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 755c394cfc2c7378
X-CR-MTA-TID: 64aa7808
Received: from 1740c1a87bcf.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B021A253-A22C-491A-8436-1EAE950A2565.1;
        Tue, 17 May 2022 17:55:51 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 1740c1a87bcf.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 17 May 2022 17:55:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgNbGL186/Z7+EfPG1M9Uj3VYyFEdeq8fksJ366IbbZsiUbu8GoTrQQAduX1dN51chq84LfMuMn/bOe/QPCTZRC3Bnwn72b2C12KutcSDF6jivAKiFCI4VaRljPkGmWmNaILfjcPkwWJ9HYxDLhtHpMGk9fmyu3COk9Iv6uW9IH6C7890i9iAr0p7VsGsUsaaj22mkxUtPOVkNRIpYGFgJStaEZukq4IJWR8KEiB8/XHUlwjLCtSdtp+7q0tWosidSHhuP4NaPN9hFwSLlpFyVs50qmxeGZkoUnRWVV7351g6OHtkEwlhOwYVV/b2USD//YycS1lpAYmvp9xckuFgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctcBnQUJsOJ51XRSgi0eHEtQvbvVJ7L65lH2SlZNidc=;
 b=bcfFqCvCyzEwlS50y76Dv6Tf65gkvywXCWIlkdGoH6Ytjz1ZDMOpO6S2vQuRjPsuOGduDKKKID92hWgrc+whVB1YnPE7In2gdMcwubRz7Y6abSBmapd6dzBsbCGQJstiihvLPCHGvIcAyannX0XUkP9pgpalPf07v7w/oqz5GAI6zkStSdXy8RsxAGTOdvhKfD+YRioXT6fXL2TC18qDVRWmn2mmYTkhOkUm7KNmlrggpFbAGfzMP4dqPxljXVG79cbfe4MWNof/YCpGTYBPb6rhUb7fgWCNN9/GPfsGM/kOC6oZd08D3rRfyYKkw+esjIR4TLqMYiqAc6OnMOHkvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctcBnQUJsOJ51XRSgi0eHEtQvbvVJ7L65lH2SlZNidc=;
 b=AwXz2agetDxRMlqvZKkNe5RPd1e+/bWH8TSyc478FlDYjtKIHAutkxr3gaR1Q2nSpPmztN5xXpGF2LmgR3Xvtc3InhbbiYwzgdxzM8hH1nEGN7AjkzIdCxExSfs3weOJHvojplUwTCiWnSLI3u/pBl+f9rNDJhbA8fDV3pGn8X4=
Received: from AS8PR08MB5895.eurprd08.prod.outlook.com (2603:10a6:20b:298::16)
 by VE1PR08MB4847.eurprd08.prod.outlook.com (2603:10a6:802:ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Tue, 17 May
 2022 17:55:47 +0000
Received: from AS8PR08MB5895.eurprd08.prod.outlook.com
 ([fe80::6166:55aa:8c7e:94ba]) by AS8PR08MB5895.eurprd08.prod.outlook.com
 ([fe80::6166:55aa:8c7e:94ba%9]) with mapi id 15.20.5273.013; Tue, 17 May 2022
 17:55:47 +0000
From:   Gyorgy Szing <Gyorgy.Szing@arm.com>
To:     Sumit Garg <sumit.garg@linaro.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        nd <nd@arm.com>
Subject: RE: [PATCH] tee: Add Arm FF-A TEE driver
Thread-Topic: [PATCH] tee: Add Arm FF-A TEE driver
Thread-Index: AQHYVhaAdhp9yXO1T0m59htUFkKMS60Dy1TegB+ryXA=
Date:   Tue, 17 May 2022 17:55:47 +0000
Message-ID: <AS8PR08MB5895E2E79F48D5CBF939C45391CE9@AS8PR08MB5895.eurprd08.prod.outlook.com>
References: <20220408134144.1532704-1-sudeep.holla@arm.com>
 <CAFA6WYNbwqNqK89ZCWWpAT5HCR59A+J873_5Odyjyb9qu00nsg@mail.gmail.com>
 <20220426144545.6qkn6iwayuwpvi7g@bogus>
 <CAFA6WYMCTn-YQrA-GixYu6OG8Qr_xsZ7xuk4LfFA-1PHgus3RQ@mail.gmail.com>
In-Reply-To: <CAFA6WYMCTn-YQrA-GixYu6OG8Qr_xsZ7xuk4LfFA-1PHgus3RQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: ff0d403b-bb92-4f43-8324-08da382e7f13
x-ms-traffictypediagnostic: VE1PR08MB4847:EE_|DBAEUR03FT055:EE_|AM0PR08MB3745:EE_
X-Microsoft-Antispam-PRVS: <AM0PR08MB374577F15191C0280EF4B23991CE9@AM0PR08MB3745.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: e5YzZs+S1f92GfO2i/S2ePmi08zJumeZ52MQ/4bIR+Fz4FNkQ7J2x+QfG3Ximv58xjfJt5i/kaEnf7+Nu5AKiHc2KzmLw/bZRgmXmhbjv8WpPb13kTgRweybAn5jKdjV+ejNDu1GmKfRDEn7uuLp+WYtvYqqN+0fX9ROQjtgOtcHtYXWCLLPLse6+z7QU5QKKvCB8xDRSZCOl3tpwjzFKeg5mR08ysF01tq5WoObhzxx3D+tA1f5VFlvRAMD+UP3ZLpRfiGjx7QgI69AmyTc2rZFrztWpSlcmG3UZmaKNWXkX8Wq2k8rpBhUHJWYlkM7MNKhrVsZ7OIsm8VxXd4yw1e8n/QIOsJBp6vEyOCLQsis2xX4KYihScoSAVMrLTlx2PVs0L4gcisMzPJw84AYA+OCe+VQ+6Bcta5LrmBLbnnoRCRMt1/4YKJmNL3wAJCKP1KMLJ6+WR3sgq1AMaDSIIvu+ZcB5KCVHvkJBkXzdOOfoAY7hrJIVd5pb6NW6AADVyPO8+VL+YFY5D4BvputQSwOsQXGpppb8hQtq0zumnbRPNZl0M7MpqA8q3xThsQKYX3PhaaGsTDMNwJxMXhojhfH7nXzu1coOQ/2wElUYLdn6jmHcugQcCY0esxG+yiNJPr1IVsrEa/kYu2Xkxj6/jnHhYMekkWd8GL0/jqbAqRxtDhLTo0xPY7+oiMvtEH/ImS/My7e5ztlNCIBJ3NWKb+dDqtJNLkH3szSNlP5A39kZa/okTBY/eKbNSr5f0JkcxYcnZPMMUXgjNRCpAAnsFrJp4A/E2i0ltVe8pcsFYXRC3wUSxxoUZH5aajZ4BySh4Eo8+2d0jND9wg0iMc/mw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB5895.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(66556008)(76116006)(66946007)(66446008)(8676002)(66476007)(6636002)(33656002)(6506007)(71200400001)(26005)(64756008)(53546011)(54906003)(110136005)(2906002)(316002)(9686003)(7696005)(966005)(186003)(83380400001)(8936002)(122000001)(55016003)(52536014)(5660300002)(38070700005)(86362001)(38100700002)(508600001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4847
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT055.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8a954f38-4595-486b-b424-08da382e78b0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lNjxpksU+m1SJw6QIrL19xIynuZasTcAbejnO+KL1NAm7WCilOb2SeucifDSlhDpiN/0qC8iYOwSE1i4hXVuuW1chrH9/DE/n3hchIE8LY6QTLt9w9KPGPDExRZcQHOJpQmCNXfntWDNw5LFWt1VXnxGaMC1PIXyeLT1CENiO2apobSoXZIp+McUm0mRwd6sXgbL4nHCaVQHeAHVfFMwRjUyDvt+jPbdEGH45bJg5GNdoJdMxYiIFFNNfSafW1x2fIlUwXmP/paNFpln+0c44r3u8qkDPJsG6mKyYGWqsMGUgP4tgYLWW1cZWPkHX258WY6AOjoVuMO0Fj+EdtOa7L18OVhvX8Cm4dK227y3Kz2EFpn94D3Gq2FPikWpn+PlbyxeINhhbwOfhGSaI8oukDnfdblOABf7QXgpeOpLvbLYqrvzkmaWRi+MbRJaY4tHqha6zHrrbBJW+5MDZIQnGbl9vAvyrLFCeh8SB8XROCeqjO0bm1E4FgfAg/FQCsAYtv0kJxBCB7oNuNJU+Tanoj7NonrrB7Ar35wvL7Z5IfSj+q5mcRD7g0xDAeVkNB50zq2YsbZVZIRMA1psBWyxcZNMcy3jNBs3UR5Be0RYEjtbgMzVmUUFboM81fFRvANkYIsUolsKnsirWp/AiMXPlHKFUVrCxiH7rFvWgpTzHJcjUQFtSZ96LmpRJSvgrdy3VnQpOzzIBz/NWlPRSqeXKvKVZRYsqt9sNhrGquA6GLtHlNPM5ld7R7UGfEg8GFImBr6fvzbxnxaRxSjaf4JR8rf31xm5An5ZWaSlTrmRlyCdPm8bC2W/u/tH6IAhL9SH
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(186003)(47076005)(336012)(86362001)(26005)(8936002)(6506007)(5660300002)(966005)(6636002)(316002)(83380400001)(110136005)(2906002)(70586007)(70206006)(54906003)(33656002)(55016003)(53546011)(356005)(8676002)(52536014)(7696005)(508600001)(82310400005)(9686003)(36860700001)(40460700003)(81166007)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 17:55:57.7982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0d403b-bb92-4f43-8324-08da382e7f13
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT055.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3745
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdW1pdCBHYXJnIDxzdW1pdC5n
YXJnQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDI3IEFwcmlsIDIwMjIgMTU6MzYNCj4gVG86IFN1ZGVl
cCBIb2xsYSA8U3VkZWVwLkhvbGxhQGFybS5jb20+DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBvcC10ZWVAbGlzdHMudHJ1c3RlZGZpcm13YXJlLm9yZw0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIXSB0ZWU6IEFkZCBBcm0gRkYtQSBURUUgZHJpdmVyDQo+IA0KPiBPbiBUdWUsIDI2
IEFwciAyMDIyIGF0IDIwOjE1LCBTdWRlZXAgSG9sbGEgPHN1ZGVlcC5ob2xsYUBhcm0uY29tPg0K
PiB3cm90ZToNCj4gPg0KPiA+IE9uIEZyaSwgQXByIDIyLCAyMDIyIGF0IDEyOjI5OjI2UE0gKzA1
MzAsIFN1bWl0IEdhcmcgd3JvdGU6DQo+ID4gPiBIaSBTdWRlZXAsDQo+ID4gPg0KPiA+ID4gT24g
RnJpLCA4IEFwciAyMDIyIGF0IDE5OjExLCBTdWRlZXAgSG9sbGEgPHN1ZGVlcC5ob2xsYUBhcm0u
Y29tPg0KPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gVGhlIEFybSBGRi1BIHByb3ZpZGVzIG1l
Y2hhbmlzbSBmb3IgTGludXgga2VybmVsIGFuZCBtb2R1bGVzIHRvDQo+ID4gPiA+IGNvbW11bmlj
YXRlIHdpdGggdGhlIHNlY3VyZSBwYXJ0aXRpb25zLiBUaGlzIGlzIHVzZWZ1bCBmb3Igc29tZQ0K
PiA+ID4gPiBUcnVzdGVkLU9TIGRyaXZlciB0aGF0IGFyZSBrZXJuZWwgcmVzaWRlbnQgb3IgbW9k
dWxlcy4NCj4gPiA+ID4NCj4gPiA+ID4gV2Ugd291bGQgYWxzbyBsaWtlIHRvIGF2b2lkIGFkZGlu
ZyBrZXJuZWwgZHJpdmVycyB0byBjb21tdW5pY2F0ZQ0KPiA+ID4gPiB3aXRoIGVhY2ggYW5kIGV2
ZXJ5IHNlcnZpY2UgcHJvdmlkZWQgYnkgdGhlc2Ugc2VjdXJlIHBhcnRpdGlvbnMuDQo+ID4gPiA+
IEluIG9yZGVyIHRvIGFjaGlldmUgdGhlIHNhbWUgd2l0aCBGRi1BLCBpdCB3b3VsZCBiZSBiZXR0
ZXIgdG8NCj4gPiA+ID4gcHJvdmlkZSB1c2VyLXNwYWNlIGludGVyZmFjZSB0byBhY2Nlc3MgdGhl
IEZGLUEgZnVuY3Rpb25hbGl0aWVzLg0KPiA+ID4gPiBURUUgc3Vic3lzdGVtIHNlZW1zIHRvIGJl
IHRoZSBiZXN0IHN1aXRlZCB0byBtZWV0IHRob3NlDQo+ID4gPiA+IHJlcXVpcmVtZW50cyB3aXRo
b3V0IGhhdmluZyB0byBjcmVhdGUgYSBuZXcgc29sdXRpb24gY3VzdG9tIHRvIEZGLUENCj4gYWxv
bmUuDQo+ID4gPg0KPiA+ID4gWWVhaCwgdGhpcyBpbnRlcmZhY2Ugc291bmRzIGludGVyZXN0aW5n
Lg0KPiA+ID4NCj4gPg0KPiA+IEdvb2QgdG8gaGVhciB0aGF0Lg0KPiA+DQo+ID4gPiA+DQo+ID4g
PiA+IEFsbCBGRi1BIHBhcnRpdGlvbnMgdGhhdCB1c2VyLXNwYWNlIGFjY2VzcyBjYW4gYmUgYXNz
b2NpYXRlZCB3aXRoDQo+ID4gPiA+IHRoaXMgbmV3IEZGLUEgVEVFIGRyaXZlciBhbmQgcmVwcmVz
ZW50ZWQgYnkgYSBzaW5nbGUgVEVFIGRldmljZS4NCj4gPiA+ID4gVGhvdWdoIHRoZSB2YXJpb3Vz
IHNlY3VyZSBzZXJ2aWNlcyBhcmUgZ2VuZXJhbGx5IGRpc3RyaWJ1dGVkDQo+ID4gPiA+IGFjcm9z
cyBtdWx0aXBsZSBzZWN1cmUgcGFydGl0aW9ucywgYWxsIG9mIHRoZXNlIGNhbiBiZSBtYWRlDQo+
ID4gPiA+IGFjY2Vzc2libGUgdGhyb3VnaCB0aGlzIHNpbmdsZSBGRi1BIFRFRSBkZXZpY2UuDQo+
ID4gPiA+DQo+ID4gPiA+IFRoZSBtaW5pbWFsIGZ1bmN0aW9uYWxpdHkgbmVlZGVkIGJ5IHRoZSB1
c2VyIHNwYWNlIGFwcGxpY2F0aW9uIGlzDQo+ID4gPiA+IGltcGxlbWVudGVkLCBuYW1lbHk6DQo+
ID4gPiA+ICAtIFF1ZXJ5IGFsbCBwYXJ0aXRpb24gSURzIGZvciBhIHNwZWNpZmljIEZGLUEgVVVJ
RA0KPiA+ID4gPiAgLSBTZW5kaW5nIHN5bmNocm9ub3VzIG1lc3NhZ2UgdG8gYSBwYXJ0aXRpb24N
Cj4gPiA+ID4gIC0gU2hhcmUvdW5zaGFyZSBidWZmZXIgd2l0aCB0aGUgcGFydGl0aW9uDQo+ID4g
PiA+DQo+ID4gPg0KPiA+ID4gQXJlIHRoZXJlIGFueSBjb3JyZXNwb25kaW5nIHVzZXItc3BhY2Ug
YXBwbGljYXRpb25zL2xpYnJhcmllcw0KPiA+ID4gYXZhaWxhYmxlIHRvIGdldCBoYW5kcy1vbiB3
aXRoIHRoaXMgaW50ZXJmYWNlPw0KPiA+ID4NCj4gPg0KPiA+IE5vdCBzdXJlIGlmIHRoZSBjaGFu
Z2VzIHRvIG1ha2UgdXNlIG9mIHRoaXMgbmV3IGludGVyZmFjZSBpcyBwdWJsaWNseQ0KPiA+IGF2
YWlsYWJsZSB5ZXQgYXMgdGhlc2UgQVBJcyBhcmUgc3ViamVjdCB0byBjaGFuZ2UuIEkgd2lsbCBz
ZWUgaWYNCj4gPiBzb21ldGhpbmcgY2FuIGJlIHNoYXJlZCwgYnV0IHRoaXMgaXMgdGhlIHByb2pl
Y3RbMl0gSSBhbSB1c2luZyB0byB0ZXN0DQo+ID4gd2l0aCByZWxldmFudCBjaGFuZ2VzIHRvIHVz
ZSB0aGVzZSBURUUgQVBJcy4NCj4gPg0KPiANCj4gQUZBSVIsIHRoZXJlIGlzIGEgY29uY2VwdCBv
ZiB0cnVzdGVkIHNlcnZpY2VzIGJlaW5nIGxhdW5jaGVkIGJ5IE9QLVRFRSBhcw0KPiB3ZWxsIFsx
XS4gSXMgaXQgdGhlIGVudmlyb25tZW50IHlvdSBhcmUgdGVzdGluZyB0aGlzIGludGVyZmFjZSB3
aXRoPw0KPiANCj4gWzFdIGh0dHBzOi8vZGV2ZWxvcGVyLnRydXN0ZWRmaXJtd2FyZS5vcmcvdy90
cnVzdGVkLXNlcnZpY2VzL29wLXRlZS1zcG1jLw0KDQpIaSBTdW1pdCwNCg0KVGhlIGJlc3Qgd2F5
IHRvIHRlc3QgdGhlIGRyaXZlciBpcyB0byB1c2UgdGhlIFBTQSBTUHMgZnJvbSBUcnVzdGVkIFNl
cnZpY2VzIHNpbWlsYXJseSBhcyBkZXNjcmliZWQgb24gdGhlIHdpa2kgcGFnZSBhYm92ZS4gV2Ug
aGF2ZSBtZXJnZWQgdGhlIFRFRSBkcml2ZXIgZW5hYmxlbWVudCBwYXRjaGVzIHRvIGludGVncmF0
aW9uIGJyYW5jaCBvZiBUUyByZWNlbnRseSwgYW5kIGFzIGEgcmVzdWx0IHRoZSBzZXQtdXAgYW5k
IGJ1aWxkIGluc3RydWN0aW9ucyBhYm92ZSB3aWxsIGJ1aWxkIGFuIGVuZC10by1lbmQgY29uZmln
IHVzaW5nIHRoZSBURUUgZHJpdmVyLg0KVGhlIFRFRSBkcml2ZXIgaW50ZWdyYXRpb24gbmVlZHMg
dG8gYmUgY2hhbmdlZCB0aG91Z2guIEluc3RlYWQgb2YgYnVpbGRpbmcgdGhlIFRFRSBkcml2ZXIg
YXMgYW4gb3V0IG9mIHRyZWUgbW9kdWxlIGZyb20gb3VyIGZvcmsgWzJdLCB5b3UgbWlnaHQgd2Fu
dCB0byBjaGFuZ2UgdGhlIGNvbmZpZyB0byB1c2UgdGhlIGRyaXZlciBwb3N0ZWQgYnkgU3VkZWVw
LiBJZiB5b3Ugd2lzaCB0byB1c2UgdGhlIG9wLXRlZSBidWlsZCBmbG93LCB0aGUgbWFrZWZpbGVz
IGluIE9QLVRFRS9idWlsZCByZXBvIHBhcnQgb2YgdGhlIGFib3ZlIHNldC11cCBuZWVkIG1vZGlm
aWNhdGlvbiB0b28uDQpUUyB3aWxsIGJ1aWxkIG11bHRpcGxlIHRlc3QgZXhlY3V0YWJsZXMgdGFy
Z2V0aW5nIHRoZSBMaW51eCB1c2VyLXNwYWNlLiBGb3IgVEVFIGRyaXZlciB0ZXN0aW5nIGFueSBv
ZiB0aGVzZSB0YXJnZXRpbmcgdGhlICJhcm0tbGludXgiIGVudmlyb25tZW50IHdpbGwgZG8sIGJ1
dCBJIHN1Z2dlc3QgdXNpbmcgdGhlICJ0cy1zZXJ2aWNlLXRlc3QiLg0KDQpBRkFJSyBTdWRlZXAg
aXMgdGVzdGluZyB3aXRoIFRTIHRvbyB1c2luZyBhIHNpbWlsYXIgc2V0LXVwLg0KDQpbMl0gaHR0
cHM6Ly9naXRsYWIuYXJtLmNvbS9saW51eC1hcm0vbGludXgtdHJ1c3RlZC1zZXJ2aWNlcw0KDQov
R2VvcmdlIA0KDQo+IA0KPiA+ID4gPiBDYzogSmVucyBXaWtsYW5kZXIgPGplbnMud2lrbGFuZGVy
QGxpbmFyby5vcmc+DQo+ID4gPiA+IENjOiBTdW1pdCBHYXJnIDxzdW1pdC5nYXJnQGxpbmFyby5v
cmc+DQo+ID4gPiA+IENvLWRldmVsb3BlZC1ieTogQmFsaW50IERvYnN6YXkgPGJhbGludC5kb2Jz
emF5QGFybS5jb20+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEJhbGludCBEb2JzemF5IDxiYWxp
bnQuZG9ic3pheUBhcm0uY29tPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTdWRlZXAgSG9sbGEg
PHN1ZGVlcC5ob2xsYUBhcm0uY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGRyaXZlcnMvdGVl
L0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gPiA+ID4gIGRyaXZlcnMv
dGVlL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gPiA+ID4gIGRyaXZl
cnMvdGVlL2FybV9mZmFfdGVlL0tjb25maWcgICAgICAgICAgIHwgIDE1ICsNCj4gPiA+ID4gIGRy
aXZlcnMvdGVlL2FybV9mZmFfdGVlL01ha2VmaWxlICAgICAgICAgIHwgICA2ICsNCj4gPiA+ID4g
IGRyaXZlcnMvdGVlL2FybV9mZmFfdGVlL2NvcmUuYyAgICAgICAgICAgIHwgNDYwICsrKysrKysr
KysrKysrKysrKysrKysNCj4gPiA+ID4gIGRyaXZlcnMvdGVlL2FybV9mZmFfdGVlL2ZmYV90ZWVf
cHJpdmF0ZS5oIHwgIDM5ICsrDQo+ID4gPiA+ICBkcml2ZXJzL3RlZS9hcm1fZmZhX3RlZS9zaG1f
cG9vbC5jICAgICAgICB8ICA5NCArKysrKw0KPiA+ID4gPiAgZHJpdmVycy90ZWUvYXJtX2ZmYV90
ZWUvdHNfbXNnLmMgICAgICAgICAgfCAxMzMgKysrKysrKw0KPiA+ID4gPiAgZHJpdmVycy90ZWUv
YXJtX2ZmYV90ZWUvdHNfbXNnLmggICAgICAgICAgfCAgNzUgKysrKw0KPiA+ID4gPiAgaW5jbHVk
ZS91YXBpL2xpbnV4L2FybV9mZmFfdGVlLmggICAgICAgICAgfCAxMTYgKysrKysrDQo+ID4gPiA+
ICBpbmNsdWRlL3VhcGkvbGludXgvdGVlLmggICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ID4g
PiA+ICAxMSBmaWxlcyBjaGFuZ2VkLCA5NDEgaW5zZXJ0aW9ucygrKSAgY3JlYXRlIG1vZGUgMTAw
NjQ0DQo+ID4gPiA+IGRyaXZlcnMvdGVlL2FybV9mZmFfdGVlL0tjb25maWcgIGNyZWF0ZSBtb2Rl
IDEwMDY0NA0KPiA+ID4gPiBkcml2ZXJzL3RlZS9hcm1fZmZhX3RlZS9NYWtlZmlsZSAgY3JlYXRl
IG1vZGUgMTAwNjQ0DQo+ID4gPiA+IGRyaXZlcnMvdGVlL2FybV9mZmFfdGVlL2NvcmUuYyAgY3Jl
YXRlIG1vZGUgMTAwNjQ0DQo+ID4gPiA+IGRyaXZlcnMvdGVlL2FybV9mZmFfdGVlL2ZmYV90ZWVf
cHJpdmF0ZS5oDQo+ID4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy90ZWUvYXJtX2Zm
YV90ZWUvc2htX3Bvb2wuYw0KPiA+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdGVl
L2FybV9mZmFfdGVlL3RzX21zZy5jICBjcmVhdGUgbW9kZQ0KPiA+ID4gPiAxMDA2NDQgZHJpdmVy
cy90ZWUvYXJtX2ZmYV90ZWUvdHNfbXNnLmggIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+ID4gPiBp
bmNsdWRlL3VhcGkvbGludXgvYXJtX2ZmYV90ZWUuaA0KPiA+ID4gPg0KPiA+ID4gPiBIaSBBbGws
DQo+ID4gPiA+DQo+ID4gPiA+IFRoaXMgaXMgdGhlIGluaXRpYWwgdmVyc2lvbiBvZiBGRi1BIFRF
RSBkcml2ZXIgdG8gZ2V0IHRoZSBmZWVkYmFjaw0KPiA+ID4gPiBvbiB0aGUgb3ZlcmFsbCBkZXNp
Z24vYXBwcm9hY2guDQo+ID4gPiA+DQo+ID4gPiA+IEZldyBUT0RPcyBJIHBsYW4gdG8gZG8gYmVm
b3JlIHdlIGZpbmFsaXNlOg0KPiA+ID4gPiAxLiBOZWVkIHRvIGRlY291cGxlIHRoZSBkcml2ZXIg
ZnJvbSBmZXcgVHJ1c3RlZCBTZXJ2aWNlIHByb3RvY29scw0KPiBjdXJyZW50bHkNCj4gPiA+ID4g
ICAgaW1wbGVtZW50ZWQuIEkgaGF2ZSBXSVAsIGJ1dCBjb3VsZG4ndCBnZXQgYWxsIHRoZSB0ZXN0
cyB3b3JraW5nKHlldCB0bw0KPiA+ID4gPiAgICBmaWd1cmUgb3V0IHdoZXRoZXIgdGhlIGlzc3Vl
IGlzIGluIGRyaXZlciBvciB0ZXN0cyB0aGVtc2VsdmVzKS4gSnVzdA0KPiA+ID4gPiAgICBwb3N0
aW5nIGl0IGFzIGlzIHRvIGdldCBpbml0aWFsIGZlZWRiYWNrIG9uIG90aGVyIGFyZWFzLg0KPiA+
ID4NCj4gPiA+IFllcyBJIHdvdWxkIGJlIGluIGZhdm9yIG9mIHRoaXMuDQo+ID4gPg0KPiA+DQo+
ID4gSSBhbSB0b28sIGJ1dCBCYWxpbnQgaGFkIHNvbWUgY29uY2VybnMgd2hpY2ggSSBuZWVkIHRv
IGRpc2N1c3Mgd2l0aCBoaW0NCj4geWV0Lg0KPiA+DQo+ID4gPiA+DQo+ID4gPiA+IDIuIEJhc2Vk
IG9uIHRoZSB3YXkgRkYtQSBzcGVjIGNoYW5nZXMvZGlzY3Vzc2lvbnMsIGRvZXMgaXQgbWFrZSBz
ZW5zZQ0KPiB0bw0KPiA+ID4gPiAgICBtYWtlIHNlYXJjaCBiYXNlZCBvbiBVVUlEICsgcGFydGl0
aW9uSUQgaW5zdGVhZCBvZiBqdXN0IHBhcnRpdGlvbklEIG9yDQo+ID4gPiA+ICAgIGxlYXZlIHRo
YXQgZm9yIHVzZXJzcGFjZS4NCj4gPiA+DQo+ID4gPiBJSVVDLCB0aGUgVVVJRCBpcyB0aGUgb25l
IGlkZW50aWZ5aW5nIHRoZSB0cnVzdGVkIHNlcnZpY2UuIFNvIHdoYXQNCj4gPiA+IHB1cnBvc2Ug
ZG9lcyBwYXJ0aW9uSUQgc29sdmVzIGZvciB1c2VyLXNwYWNlIHByb2dyYW0/DQo+ID4gPg0KPiA+
DQo+ID4gU29ycnkgZm9yIG5vdCBnaXZpbmcgY29tcGxldGUgcGljdHVyZSBoZXJlLiBJbiB0aGUg
Y29udGV4dCBvZiBGRi1BIGFuZA0KPiA+IHNlY3VyZSBwYXJ0aXRpb25zLCB0aGVyZSB3ZXJlIGRp
c2N1c3Npb25zIHRvIGFsbG93IHNpbmdsZSBwYXJ0aXRpb24NCj4gPiBpbXBsZW1lbnRpbmcgbXVs
dGlwbGUgc2VydmljZXMvcHJvdG9jb2xzKGVhY2ggYXNzb2NpYXRlZCB3aXRoIFVVSUQpDQo+ID4g
YW5kIG9uIGEgc3lzdGVtIHdpdGggbXVsdGlwbGUgU1BzLCAyIGRpZmZlcmVudCBTUHMgY2FuIGJl
IGltcGxlbWVudGluZw0KPiBzYW1lIHByb3RvY29sL3NlcnZpY2UuDQo+ID4gU29ycnkgaWYgSSBh
bSBtaXNzaW5nIHNvbWV0aGluZyBoZXJlIG9yIGlmIHRoYXQgaXMgaW1wb3NzaWJsZSwgdGhpcyBp
cw0KPiA+IGp1c3QgbXkgdW5kZXJzdGFuZGluZyBhbmQgaGVuY2UgSSB3YXMgY2hlY2sgaWYgVVVJ
RCArIHNvbWV0aGluZyh2bV9pZA0KPiA+IGFzIHBlciBGRi1BDQo+ID4gc3BlYykgbmVlZCB0byBi
ZSB1c2VkIHRvIGlkZW50aWZ5IHdoaWNoIHBhcnRpdGlvbiBhbmQgc2VydmljZSB3ZSB3b3VsZA0K
PiA+IHdhbnQgdG8gdGFsayB0by4NCj4gPg0KPiANCj4gT2theSwgSSBzZWUgdGhpcyBleHBsYW5h
dGlvbiBjb21pbmcgZnJvbSBGRi1BIHNwZWMgYnV0IGN1cnJlbnRseSBGRi1BIGJ1cyBpbg0KPiB0
aGUga2VybmVsIG9ubHkgZW51bWVyYXRlcyBzZWN1cmUgcGFydGl0aW9ucyB2aWEgVVVJRHMgb25s
eS4gSSBndWVzcyB0aGF0DQo+IG5lZWRzIHRvIGNoYW5nZSBmaXJzdC4NCj4gDQo+IC1TdW1pdA0K
PiANCj4gPiA+ID4NCj4gPiA+ID4gMy4gV2hpbGUgSSBkZWZpbml0ZWx5IHdhbnQgdG8gbW92ZSB0
aGUgcHJvdG9jb2wgc3BlY2lmaWNzIGZyb20gdGhlIGRyaXZlcg0KPiA+ID4gPiAgICAoYXMgbWVu
dGlvbmVkIGluICgxKSksIGRvIHdlIGV2ZW4gdHJ5IHRvIHJlbW92ZSBhZGRpbmcgVVVJRCBvZiBl
YWNoDQo+IHNlcnZpY2UNCj4gPiA+ID4gICAgd2Ugd291bGQgbGlrZSB0byB1c2UgdGhpcyBkcml2
ZXIuDQo+ID4gPg0KPiA+ID4gWWVzLCB3ZSBzaG91bGRuJ3QgaGFyZGNvZGUgYW55IFVVSURzIGZv
ciB0cnVzdGVkIHNlcnZpY2VzIHdpdGhpbiB0aGUNCj4gPiA+IGRyaXZlciAoaXQgaXNuJ3Qgc2Nh
bGFibGUpIGJ1dCByYXRoZXIgZHVyaW5nIG9wZW4gc2Vzc2lvbnMgd2Ugc2hvdWxkDQo+ID4gPiBz
ZWFyY2ggaWYgYSBwYXJ0aWN1bGFyIFVVSUQgaXMgYXZhaWxhYmxlIG9uIEZGLUEgYnVzIHRvIGNv
bW11bmljYXRlDQo+ID4gPiB3aXRoPw0KPiA+ID4NCj4gPg0KPiA+IFllcyBpdCBpcyBub3Qgc2Nh
bGFibGUgYW5kIEkgYW0gYXdhcmUgb2YgdGhhdC4gSSBoYXZlbid0IGV4cGxvcmVkIHRoZQ0KPiA+
IG9wdGlvbnMgdG8gZ2V0IHJpZCBvZiB0aGVtIHlldC4gVGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlv
bi4NCj4gPg0KPiA+ID4gPiAgICBJIGhhdmVuJ3QgdGhvdWdodCB0aHJvdWdoIHRoYXQgeWV0LA0K
PiA+ID4gPiAgICBidXQgdGhlIGlkZWEgSSBoYXZlIGlzIHRvIGp1c3QgaGF2ZSBhIGJsb2NrZWQg
VVVJRCBsaXN0IHdoaWNoIGNhbg0KPiA+ID4gPiAgICBjb250YWluIFVVSUQgZm9yIE9QVEVFIGFu
ZCBvdGhlciBpbi1rZXJuZWwgdXNlcnMuDQo+ID4gPiA+ICAgIFRoYXQgbWF5IG5lZWQgY2hhbmdl
cyBpbiBGRi1BIGJ1cyBtYXRjaCBidXQgc29tZXRoaW5nIHRvIGNvbnNpZGVyID8NCj4gPiA+ID4N
Cj4gPiA+DQo+ID4gPiBDdXJyZW50bHkgaW4gdGhlIGNhc2Ugb2YgT1AtVEVFIHdlIGRlcGVuZCBv
biBhbiBvcGVuIHNlc3Npb24gbG9naW4NCj4gPiA+IG1ldGhvZCB3aGVyZSB0aGUgcGFydGljdWxh
ciB0cnVzdGVkIGFwcGxpY2F0aW9uIGRlY2lkZXMgd2hldGhlciBhDQo+ID4gPiBwYXJ0aWN1bGFy
IGxvZ2luIG1ldGhvZCBpcyBhbGxvd2VkIG9yIG5vdCwgcmVmZXIgaGVyZSBbMV0gZm9yIG1vcmUN
Cj4gPiA+IGRldGFpbHMuIEkgZ3Vlc3Mgc2ltaWxhciBhY2Nlc3MgY29udHJvbCBjaGVja3MgY2Fu
IGJlIGltcGxlbWVudGVkIGJ5DQo+ID4gPiBhIHBhcnRpY3VsYXIgdHJ1c3RlZCBzZXJ2aWNlIGR1
cmluZyBhbiBvcGVuIHNlc3Npb24uIFRoaXMgd2lsbCBhbGxvdw0KPiA+ID4gdXMgdG8gbm90IG1h
aW50YWluIGFueSBhbGxvd2VkIG9yIGJsb2NrZWQgbGlzdC4NCj4gPiA+DQo+ID4NCj4gPiBUaGFu
a3MgZm9yIHRoZSBkZXRhaWxzLCBJIHdpbGwgZXhwbG9yZSBhbmQgc2VlIGhvdyB3ZSBjYW4gdXNl
DQo+ID4gc29tZXRoaW5nIHNpbWlsYXIuIEkgd2lsbCBwaW5nIHlvdSBpZiBJIGdldCBzdHVjayBv
ciBuZWVkIG1vcmUgaW5mbyBvcg0KPiA+IG5lZWQgbW9yZSBkaXNjdXNzaW9uIG9uIHRoYXQuDQo+
ID4NCj4gPiAtLQ0KPiA+IFJlZ2FyZHMsDQo+ID4gU3VkZWVwDQo+ID4NCj4gPiBbMl0gaHR0cHM6
Ly9naXQudHJ1c3RlZGZpcm13YXJlLm9yZy9UUy90cnVzdGVkLXNlcnZpY2VzLmdpdA0KPiA+DQo=
