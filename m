Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16798492FBE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 21:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349183AbiARUyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 15:54:16 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:54318 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232844AbiARUyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 15:54:15 -0500
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8668F406E9;
        Tue, 18 Jan 2022 20:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1642539255; bh=PcqrgOq+GudbN8Fd+nWDwwC5UzR6hmHIegLExa7EAH0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=JIrt9NkIVMZIhMSa1htvRuSrixnVaAeaQp0jgZEA5mEm5kg3M4xX24Wxl7Abgwh6E
         +d5sa7xoXF2gcitN4XWZBoPYCnLYqLyrw/EO+0ec7wVd4LCUchRkxHiW5xcdqN7Yy4
         U0uC3gFRABS2L5QL+BXMlgZ0EPEryhMO1r4yrMWVaFXMoDmSIqCQXtkOrNK5pzZMLM
         2VC3LmQMIw+jz6b1s9CR9jLYQQpodYDQ8ivV6L+iM8R7AZP5+goP5Eix+1pgoFab2c
         eBiXAratsopRXpTHqLi3PrirvihW+6LfeQu95SIzHNjtB3wj17SoKH+55X1dNmbHdu
         XitTbyXT721SA==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 424FDA005F;
        Tue, 18 Jan 2022 20:54:14 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2043.outbound.protection.outlook.com [104.47.51.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 59C494009D;
        Tue, 18 Jan 2022 20:54:13 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="SExtQDWx";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4U6GHHqMO9/xyJpckg6fuZ8Ve2HXGM8A1nLiX4ajkJb8clPp6I2eVSCKUokycVezRuLKBVUNBe/zq8Y+/WJKsO2mlQgjt+OvP+KPrfmU6+h4sdff4kQzd/1CVSY8haK8FEceLRExLHVThSBdWIKR0bTkn0zFbCmDNIHqZFInu5xCqen8W+wlTxKPUAMQPPTiRT663wMCSmz3YL/yeCxkmRupBi9Om41pw/5jM84UtOGg6pCvMDRtX2l+Xwkv2VMYqza4XZvAV+1Af5vxb+N93Bzche6xcctF94gN9Rj1Ci5cEdEuOvmdMdg06SqMmnWZhYneizA/DkNZF4rZz0y4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcqrgOq+GudbN8Fd+nWDwwC5UzR6hmHIegLExa7EAH0=;
 b=cI1i29a86NomtNU0+v17sPVYIIoDd6xU/xLsJbts8/Qfw+idMH688knT7yAvwXBOufgjRFgsIn+y8c07//PZPLZrKI5zhPHBlM6YY8pVi44IYw3rFrP8lOBP6MzWdBxpqr43FhSQ6GIAfA+qiPDEEnq9DsOdJF5HlGGGWYK0U2C9qq35KZda2PFrjZnTWfEYJfoAQfwT7JMLTKWJme7pJoo2vq1+52OXCpZx468D8Y402D5hLiKtm+mRF11msdu9zPm7+xFy0FMXZ1Xl8vbtsBAVoqGbm16jVy11PB8cnAgzRzyyTMOnwXd9/VLl7+aMYZcIIOuT+1DmdhVkrZaoyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcqrgOq+GudbN8Fd+nWDwwC5UzR6hmHIegLExa7EAH0=;
 b=SExtQDWxDoUaBZBVt3nOk2kY1vCciKmkOKxMmGiPtzk1jfXC5v68Lw0beQ6cqjWgrJtNDxEEsuhNoOhn2/FldUS0PwOvlWvtu/l25JyMvppvVbojGomayiphHgW8UqVbOe1gJCUNGUJ8To3sXGmsbRKH2Ld8tydc0Wqle/YldU8=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MN2PR12MB2960.namprd12.prod.outlook.com (2603:10b6:208:101::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 18 Jan
 2022 20:54:09 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8983:6493:8c38:d34a]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8983:6493:8c38:d34a%3]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 20:54:09 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Robert Hancock <robert.hancock@calian.com>,
        "sean.anderson@seco.com" <sean.anderson@seco.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "bjagadee@codeaurora.org" <bjagadee@codeaurora.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "agross@kernel.org" <agross@kernel.org>
Subject: Re: [PATCH 0/6] usb: dwc3: Calculate REFCLKPER et. al. from reference
 clock
Thread-Topic: [PATCH 0/6] usb: dwc3: Calculate REFCLKPER et. al. from
 reference clock
Thread-Index: AQHYCaAEN5xMDjPNv0iLO+Qwz2hVyaxnCOeAgAIr9wCAAAIIAIAAAf+AgAAKzwCAAAQeAA==
Date:   Tue, 18 Jan 2022 20:54:08 +0000
Message-ID: <076fae75-d6e7-41bf-d9e6-c77d08aa51c4@synopsys.com>
References: <20220114233904.907918-1-sean.anderson@seco.com>
 <87iluifxy1.fsf@tarshish> <7831a4f7-7c3f-4a2a-be73-38f2c40a123c@synopsys.com>
 <f28052d9-5dea-a05b-8745-09e4d237b539@seco.com>
 <f53ba815-f2ee-a558-73f3-06c5a43f5c5e@synopsys.com>
 <eb3ba4b54d09dbe413907adb86669096110bbd0d.camel@calian.com>
In-Reply-To: <eb3ba4b54d09dbe413907adb86669096110bbd0d.camel@calian.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34740568-70d6-41c8-0157-08d9dac4ac7e
x-ms-traffictypediagnostic: MN2PR12MB2960:EE_
x-microsoft-antispam-prvs: <MN2PR12MB296086D5D4B5ED2FAEF2792BAA589@MN2PR12MB2960.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aGbbYVsxbU3ZIIx22290dJJj1i2dM3CS8YRWwiAu+otEImz78BP/2Sq6xNeknTgRE3E3CewH/YnP2ms+w96Z269qUe8DeTwOHjahSYxFcRIbrnyFQEviGcETHPksHFZgx5F+/qZtD1MkRAj+y4jEs9Kl/utnRqTjJBb8zB3gbHIdr/6buIbywHaaiL0qIiLdUKZshDC9oqqtdj3NA9EAGupYeSs2UweXipiH+gXQeV3/UKsOomI31jNRUm1MsSOVCsxgW4HOOXGhs9kIfh+x2LjW3DX9geITkJ29YzyWJgoouAItqkXmlx37JgaD0M+G1z9rBDGuttsUX9FYTDKjVoJNO0A6TL2g73o8VMI8y/26o3rpKYVy/UGQR+fG1phcIVEZJfypW+x8mbGaAVpLGnrOBJCRbWCkczKQe/7cbVoCRRn2yMn0r3Y+WogUwY2thYM38WuN7aSVMJdydjBy4kPeD/PReTl9CY+pjPwXuxc3HLCJszdnfOSm+LNgszf85BQWVqZF/w8DCo2he3h9FUlN7lZUfa1K5HPDfmToluV2/pBkdmU/eShRKTfrVIY2VC5yGz2HZYtjiL31fVr1qYJwzqCnztByQn18Mat0244WBoyXzP2kaPeRu5vZHV2c1IruAIXpwFDL17KSU0ZQIefF9plXEVPZRU6IrxcEkyGBeBnNXLYdQPq8HF7jmmhk752jflVqBEjlPczdCT7lpI9g7aKIfdsIv4vWsHwMRdnrqeRKrTnDKIi/H/tDyFDz7bk9+tp/KQunlZ4TBPxpJPhfv+HlGY/KurYfUB7A4EJJMSjhQE0MQND/Sm+BxpJTi3Y8ohYSbf05X16tazrxpwZg1VXZ4404q1JOcyAJnK4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66446008)(83380400001)(64756008)(186003)(8936002)(110136005)(26005)(66556008)(66476007)(508600001)(2616005)(38070700005)(2906002)(54906003)(8676002)(316002)(31686004)(6486002)(966005)(7416002)(5660300002)(53546011)(6506007)(71200400001)(6512007)(86362001)(66946007)(36756003)(4326008)(38100700002)(31696002)(76116006)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjJ6dC9xWUYvVllRbDA1NkUxMkVELzE1Uk1QL3BPMVAyeUtRR3ROaUljeFla?=
 =?utf-8?B?V01rZklTT0ZXWHRzMmp0UlpiVUIvTjRtdFNraWcxMmZZb0dNdjhTVXMxcWly?=
 =?utf-8?B?OTVJZ0lnZ3ZCVUhrTDBZRi9JdHM5dENDMnlxZEF3Y1lZZVQ5N25UcGxWQjJs?=
 =?utf-8?B?VnNnc2pRZ2hnY2Z3SUp1ZnB1NEJhQkdSdTBiUWJpd1JzL0RZcUc1YVIxYU1R?=
 =?utf-8?B?cm9oOFdyMEtTMEhMTWU1ZUVLSzROejRMb3V4NGYwdFE3RllxcG03NWY3QVM5?=
 =?utf-8?B?d0NrMm4zd0RLMC9DdEFCbi82UVhlRjI3TFJGWVJ6NTVKNXNDSm52eGkva0JC?=
 =?utf-8?B?bkRrSkowYXVCampVRUhQZnZpeUtJSzVLUWdyaXdvUUxkeW9aczZzZ2EzdXBD?=
 =?utf-8?B?a043S2E5TnVUeGh6cFpOd2NMdUVHSG9vbW9SOU51Y25RSXVZeEMxdnZrQmZT?=
 =?utf-8?B?a1B1dDFrWis4UGJRNmRUK0F4WVYxM1M3NU16eFhVeVQvRkJvTlluWlR2OVpr?=
 =?utf-8?B?ZEtia3VmQ2trSkJmbVR6SEYyelJlTHBQUWlNeGhxY0M2RVBqRFJDZ3ZJZkhm?=
 =?utf-8?B?ekhndXZTOVlBTFZJQ245RVRJTnpSYnpURy81akFNMEdmTzlSb0IvbXFnU1Mv?=
 =?utf-8?B?djMvMmUyMlpwd3JYcGpDL1pSZnNRV2xEMGJCSE5peUhzUGNoWmd1eWFhNENl?=
 =?utf-8?B?QnJQNms0YmQ3NVlRWlZXeVNEWFZXakNEMzFxQ2VsWjhUNnhUS0hpZkdkbFlN?=
 =?utf-8?B?S3I3eUNmVkJxbko5TmppUTY2QmU1S3dSRE1hb0ordU5SMml1Wm43REEyL2JH?=
 =?utf-8?B?M2VSNTd4R2JYMVFNeDZxUzFKYzlNenR6SmswTDZRQVpOQU9vM05FZEF0dGhU?=
 =?utf-8?B?MU8xNFgxaVNaYWxtakllNGtMc21HT0dXclBiS3pMc3RtWXR4bWNTRnFCWWcr?=
 =?utf-8?B?M2Jqd2J1aUE3aUJsblk5b0tsaDhEeE9TM2tSVGxqbDVjb2FkdkswYmNCYW5H?=
 =?utf-8?B?VVYyTmdiSW1TeE5WT2pPWWNtMHJBNThkMktxaXpOUTJGaEpoZGFYcjlkbG81?=
 =?utf-8?B?eFJONnF6QmhCK2hHV2dJcWJPSzRCUXpSeFhXWEI0S3FKQmZYVEZwZy90akRn?=
 =?utf-8?B?VzVxSUNoZU9yT1VZYklwZE42ajJqMjcyblpqTkNWV201Mm9abG54Mk5sVkU1?=
 =?utf-8?B?a1UzcHJzRE5UdUpoRkw0b1NsdDlmenpnWjRhbzRKSkJabHFyZTBxVHBtVk5E?=
 =?utf-8?B?Mm5ZSzhhbkU1dDVxZFNRaWh2ekRBKzVFeTUwRkt5MmlCWjkra0xuc0FXNEhZ?=
 =?utf-8?B?amY2eE1JN21aVElDNWFOVWVSUjNNTExHUFNEVTRYTUFEV2FzeUV6T1g0N2c4?=
 =?utf-8?B?NXZ2b1ZqVTU0Sjk0bkZOZW9qL1RYczJiMnlQZ005R2ozWFEyMEtjamJDdXRD?=
 =?utf-8?B?NDFNRWUxWFVqVE9VdXlQRU16RlMwTEc3WEM2YWZjd09tTklpT0trNHJteVFx?=
 =?utf-8?B?YndXcXBBMVd5cXdpWnZLem0reUJHSjZhU1g3VDI5ZzU5czdLaWJvMnJLSUUw?=
 =?utf-8?B?OFVwNzhNelhhbG5XV1NvME80Q3hnRk1kNmZoeE5zcWo3ZDMvSzBIK1pFc1dt?=
 =?utf-8?B?SDdSTEEyVHkwNnVzcXVJS2JXK2UxaXE0aDNrSjBZRTlNS3dBdFJMcHcxMGRD?=
 =?utf-8?B?SWhzR29MMXAzaEVuUUZyNXZmWXBVLzhrZmR4SkVSRE5xWjltZHZpZld0NFFK?=
 =?utf-8?B?K2VhQTc1RUxQSy9rM2h3U05zdnU0SERDWGplUkJsNWRpbFdWQ2V6TnhlTmo2?=
 =?utf-8?B?N0thTm9EOFA4M1IybXpZTGNPVnpKcWxQMlhCY1BaMkVnTnlSOVk1L25neFhn?=
 =?utf-8?B?L0cxd3Z3KzZQTmx0K05QWjBpbXRqZ3dmM3I0MDlWN0xCOVp6Yk1Ia3lHVFgx?=
 =?utf-8?B?TWRuNjUrdmJ1STdpYWlYRUU2RjBFRVFHWVF1T0RVbmtuRnVsYS82Y2FyemJq?=
 =?utf-8?B?TDJyb3F0TEVxalNtUWVDdmxZZDdhaTNvWHc5eWJMZm9nSzNQV2E1RWQ4VlBr?=
 =?utf-8?B?R1ppSXh6U1Fjc2huQWVoQUNqZFk0ODRHOXlMNmp3dzBsbExvMjlxV05NNHNm?=
 =?utf-8?B?K2FiRVhzSDBOK1VneXo3NUNCQ1VMSEtsdjFMNllxVmFWSUZ4ZGw5VlhZWWgy?=
 =?utf-8?B?L1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0C70F98567A354DAF72A67994E06FB9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34740568-70d6-41c8-0157-08d9dac4ac7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 20:54:08.8426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iRUGCkM7Jp2ercWANrOH3qKPmZm4L1mHtPG8cNHzFlscG84aCWp3bVSjDHZ+mIz+HdmvUf2kVk50V3wLd1ibTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2960
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Um9iZXJ0IEhhbmNvY2sgd3JvdGU6DQo+IE9uIFR1ZSwgMjAyMi0wMS0xOCBhdCAyMDowMCArMDAw
MCwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPj4gU2VhbiBBbmRlcnNvbiB3cm90ZToNCj4+PiBIaSBU
aGluaCwNCj4+Pg0KPj4+IE9uIDEvMTgvMjIgMjo0NiBQTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0K
Pj4+PiBIaSBTZWFuLA0KPj4+Pg0KPj4+PiBCYXJ1Y2ggU2lhY2ggd3JvdGU6DQo+Pj4+PiBIaSBT
ZWFuLCBUaGluaCwNCj4+Pj4+DQo+Pj4+PiBPbiBGcmksIEphbiAxNCAyMDIyLCBTZWFuIEFuZGVy
c29uIHdyb3RlOg0KPj4+Pj4+IFRoaXMgaXMgYSByZXdvcmsgb2YgcGF0Y2hlcyAzLTUgb2YgWzFd
LiBJdCBhdHRlbXB0cyB0byBjb3JyZWN0bHkNCj4+Pj4+PiBwcm9ncmFtDQo+Pj4+Pj4gUkVGQ0xL
UEVSIGFuZCBSRUZDTEtfRkxBREogYmFzZWQgb24gdGhlIHJlZmVyZW5jZSBjbG9jayBmcmVxdWVu
Y3kuDQo+Pj4+Pj4gU2luY2UNCj4+Pj4+PiB3ZSBubyBsb25nZXIgbmVlZCBhIHNwZWNpYWwgcHJv
cGVydHkgZHVwbGljYXRpbmcgdGhpcyBjb25maWd1cmF0aW9uLA0KPj4+Pj4+IHNucHMscmVmLWNs
b2NrLXBlcmlvZC1ucyBpcyBkZXByZWNhdGVkLg0KPj4+Pj4+DQo+Pj4+Pj4gUGxlYXNlIHRlc3Qg
dGhpcyEgUGF0Y2hlcyAzLzQgaW4gdGhpcyBzZXJpZXMgaGF2ZSB0aGUgZWZmZWN0IG9mDQo+Pj4+
Pj4gcHJvZ3JhbW1pbmcgUkVGQ0xLUEVSIGFuZCBSRUZDTEtfRkxBREogb24gYm9hcmRzIHdoaWNo
IGFscmVhZHkNCj4+Pj4+PiBjb25maWd1cmUNCj4+Pj4+PiB0aGUgInJlZiIgY2xvY2suIEkgaGF2
ZSBidWlsZCB0ZXN0ZWQsIGJ1dCBub3QgbXVjaCBlbHNlLg0KPj4+Pj4+DQo+Pj4+Pj4gWzFdDQo+
Pj4+Pj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xpbnV4LXVzYi8yMDIyMDExNDA0NDIzMC4yNjc3MjgzLTEtcm9iZXJ0LmhhbmNvY2tAY2FsaWFu
LmNvbS9fXzshIUE0RjJSOUdfcGchTTN6S3hEWkM5YV9ldHF6WG83R1NFTVRIUldmYzF3Ul84NHd3
TTQtZlNoaUEzNUNzR2N4Y1RFZmZIUGJwcmJkQzRkMlIkDQo+Pj4+Pj4NCj4+Pj4+DQo+Pj4+PiBU
aGluaCwgeW91IHN1Z2dlc3RlZCB0aGUgZGVkaWNhdGVkIERUIHByb3BlcnR5IGZvciB0aGUgcmVm
ZXJlbmNlIGNsb2NrOg0KPj4+Pj4NCj4+Pj4+ICANCj4+Pj4+IGh0dHBzOi8vdXJsZGVmZW5zZS5j
b20vdjMvX19odHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvZDVhY2IxOTItODBiOS0zNmY3LTQz
ZjUtODFmMjFjNGU2YmEwQHN5bm9wc3lzLmNvbS9fXzshIUE0RjJSOUdfcGchTTN6S3hEWkM5YV9l
dHF6WG83R1NFTVRIUldmYzF3Ul84NHd3TTQtZlNoaUEzNUNzR2N4Y1RFZmZIUGJwcmJwT0Ztdlgk
DQo+Pj4+Pg0KPj4+Pj4NCj4+Pj4+IENhbiB5b3UgY29tbWVudCBvbiB0aGlzIHNlcmllcz8NCj4+
Pj4+DQo+Pj4+DQo+Pj4+IFVubGVzcyB0aGVyZSdzIGEgZ29vZCB3YXkgdG8gcGFzcyB0aGlzIGlu
Zm9ybWF0aW9uIGZvciBQQ0kgZGV2aWNlcywgbXkNCj4+Pj4gb3BpbmlvbiBoYXNuJ3QgY2hhbmdl
ZC4gKEJ0dywgSSBkb24ndCB0aGluayBjcmVhdGluZyBhIGR1bW15IGNsb2NrDQo+Pj4+IHByb3Zp
ZGVyIGFuZCBpdHMgZHVtbXkgb3BzIGlzIGEgZ29vZCBzb2x1dGlvbiBhcyBzZWVtcyB0byBjb21w
bGljYXRlIGFuZA0KPj4+PiBibG9hdCB0aGUgUENJIGdsdWUgZHJpdmVycykuDQo+Pj4NCj4+PiBD
YW4geW91IGV4cGxhaW4geW91ciBzaXR1YXRpb24gYSBiaXQgbW9yZT8gSSdtIG5vdCBzdXJlIGhv
dyB5b3UgY2FuDQo+Pj4gYWNjZXNzIGEgZGV2aWNlIHRyZWUgcHJvcGVydHkgYnV0IG5vdCBhZGQg
YSBmaXhlZC1yYXRlIGNsb2NrLg0KPj4+DQo+Pj4gLS1TZWFuDQo+Pg0KPj4gQ3VycmVudGx5IGZv
ciBkd2MzIHBjaSBkZXZpY2VzLCB3ZSBoYXZlIGdsdWUgZHJpdmVycyB0aGF0IGNyZWF0ZSBhDQo+
PiBwbGF0Zm9ybV9kZXZpY2Ugd2l0aCBzcGVjaWZpYyBwcm9wZXJ0aWVzIHRvIHBhc3MgdG8gdGhl
IGR3YzMgY29yZQ0KPj4gZHJpdmVyLiBXaXRob3V0IGEgcmVmIGNsb2NrIHByb3BlcnR5LCB3ZSB3
b3VsZCBuZWVkIGFub3RoZXIgd2F5IHRvIHBhc3MNCj4+IHRoaXMgaW5mb3JtYXRpb24gdG8gdGhl
IGNvcmUgZHJpdmVyIG9yIGFub3RoZXIgd2F5IGZvciB0aGUgZHdjMyBjb3JlDQo+PiBkcml2ZXIg
dG8gY2hlY2sgZm9yIHNwZWNpZmljIHBjaSBkZXZpY2UncyBwcm9wZXJ0aWVzIGFuZCBxdWlya3Mu
DQo+IA0KPiBXZSd2ZSB1c2VkIHRoZSBkZXZpY2UgdHJlZSB0byBpbnN0YW50aWF0ZS9jb25maWd1
cmUgZGV2aWNlcyBpbnNpZGUgb2YgYSBQQ0kNCj4gZGV2aWNlLCB0aG91Z2ggb2J2aW91c2x5IHRo
YXQgb25seSB3b3JrcyBvbiBEVC1iYXNlZCBwbGF0Zm9ybXMsIGFuZCBmb3INCj4gaGFyZHdhcmUg
dGhhdCdzIHBhcnQgb2YgdGhlIGJvYXJkIGl0c2VsZiwgbm90IGFuIGFkZC1pbiBjYXJkLg0KPiAN
Cj4gV2UndmUgYWxzbyB1c2VkIHRoZSBNRkQgaW5mcmFzdHJ1Y3R1cmUgdG8gaW5zdGFudGlhdGUg
ZGV2aWNlcyBhbmQgZGV2aWNlDQo+IHByb3BlcnRpZXMgaW5zaWRlIGEgUENJIGRldmljZSBvbiB4
ODYsIHdoaWNoIGNhbiBiZSB1c2VkIGlmIHRoZSBkcml2ZXIgeW91IGFyZQ0KPiBpbnN0YW50aWF0
aW5nIHVzZXMgdGhlIGdlbmVyaWMgZGV2aWNlIHByb3BlcnR5IGFjY2Vzc29ycyBhbmQgbm90IHRo
ZSBEVC0NCj4gc3BlY2lmaWMgb25lcy4gVGhhdCBnZXRzIGEgYml0IGRpcnR5IGhvd2V2ZXIgLSBJ
IGRvbid0IHRoaW5rIHRoZXJlJ3MgYW4gZWFzeQ0KPiB3YXkgdG8gY3JlYXRlIHByb3BlcnRpZXMg
dGhhdCBhcmUgcmVmZXJlbmNlcyB0byBvdGhlciBub2Rlcywgb3IgbW9yZSB0aGFuIGENCj4gc2lu
Z2xlIGxldmVsIGRlZXAgaGVpcmFyY2h5IG9mIG5vZGVzLg0KPiANCj4gRm9yIGEgdXNlIGNhc2Ug
bGlrZSB5b3UncmUgZGVzY3JpYmluZywgaXQgc291bmRzIGxpa2UgaXQgd291bGQgYmUgYmV0dGVy
IHRvDQo+IGFic3RyYWN0IGF3YXkgc29tZSBvZiB0aGUgY29yZSBEV0MzIGNvZGUgZnJvbSByZWFk
aW5nIHRoZSBzZXR0aW5ncyBmcm9tIERUDQo+IGRpcmVjdGx5LCBzbyB0aGF0IHRoZSBQQ0kgZGV2
aWNlcyBjYW4gaW5zdGFudGlhdGUgaXQgYW5kIHNldCB0aGUgY29uZmlndXJhdGlvbg0KPiBob3dl
dmVyIHRoZXkgd2FudCwgd2l0aG91dCBoYXZpbmcgdG8gd29ycnkgYWJvdXQgY3JlYXRpbmcgZmFr
ZSBwcm9wZXJ0aWVzIGZvcg0KPiB0aGUgY29yZSB0byByZWFkLiBJIHRoaW5rIHRoYXQgcGF0dGVy
biBoYXMgYmVlbiB1c2VkIHdpdGggc29tZSBvdGhlciBkcml2ZXJzDQo+IHN1Y2ggYXMgQUhDST8N
Cj4gDQoNClllcy4gSXQgd291bGQgYmUgZ3JlYXQgaWYgd2UgY2FuIHJld29yayBhbmQgYWJzdHJh
Y3QgdGhpcy4gSSdkIG5lZWQgdG8NCnJldmlldyBob3cgQUhDSSBoYW5kbGVzIGl0LiBJdCBkb2Vz
bid0IHNlZW0gbGlrZSBhIHNtYWxsIHRhc2sgYXMgaXQNCnRvdWNoZXMgb24gbXVsdGlwbGUgZHJp
dmVycy4gQnV0IGlmIGFueW9uZSBjYW4gc3RhcnQgdGhpcyBvZmYsIEkgY2FuDQpoZWxwIGZ1cnRo
ZXIgY29udHJpYnV0ZS9yZXZpZXcuDQoNClRoYW5rcywNClRoaW5oDQoNCg==
