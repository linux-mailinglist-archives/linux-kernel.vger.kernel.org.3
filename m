Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752854D0C50
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 00:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343967AbiCGXw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 18:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238578AbiCGXwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 18:52:24 -0500
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DDF2B2;
        Mon,  7 Mar 2022 15:51:28 -0800 (PST)
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id DF0E7C0A2A;
        Mon,  7 Mar 2022 23:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1646697088; bh=RFwDe0aD7AaUay9jr39+BaEWM5EYjEFaIcileb/swgc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Z/CXQxFhYn1T/IGj2a3I3HI5uXRkfl2+F4uZPLLhd0ulgNL3oSOi9ZmKhQAZh4nRy
         oNcsDMlwW4Bd9gjGvjQ7AqYk5l7NqYKqvtDvm9jOD1d9to0XW3IUdwmQSmvmel5bEk
         peRC8FAWlU7G7fMvcM+uRNedUo6bypgfRdBzjLs7bZ4GocMhTn92yUZXXifeiDJYAR
         K8Sv/sEUHPgWwO5+L5E2DdJo0p4giKW2RfQzcGBCsqBNhwKD71zHgE3bB+CHcBBNp8
         82PvPrcAsiJVt+g/aAMmTEgAgw93YLreX7mGANLzsKyjPSo+3UPYbNnRyQP2VOYB3s
         QyL1RBFyAa/Lg==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 44390A0071;
        Mon,  7 Mar 2022 23:51:24 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0B63E80091;
        Mon,  7 Mar 2022 23:51:22 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Vu0G4KIk";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=McPH2axyUVreIoogjGIgoAgwbQSgktZdkFl2FEtSxb+eCEBbSgiNM18VaWak6JobRh/6nBemJaOqdLmwJ4fGsi720jfFTmEI9OLrMTP7h2rJOekeCq+3SrqriWh9ZnvStnnZFlGMBSmq6dxw0N2xo1rDJkhKdqucMrc+cCshpWtphkibMegdF8M20xGkEeoHeAe3TaLKWXhdBwZch1TIzHwtvRXQOyFfgpkI0rBGrrIJ06YZEYRAzRgt2srz7+Nm2ibhjII2JyHMsrkEKUUEkndbDVd3S1jOUi6rqHYF/rUyE9taAjMYRxskIUQCzbu846zBcZ/voWRMRIehmbajtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFwDe0aD7AaUay9jr39+BaEWM5EYjEFaIcileb/swgc=;
 b=P3Ryo0EX16gf99zrx2c8g8lv6AtqHn/umnV82LwFnXTHelqNHLiVFRNxYI0iCwdDVSNl1b8cOLrn6YZEk1Vn/DHVmY8pEA+RQgJdsLqogVhaK4x6Y5kAKrs/gdF2MbDSAhpVCdLTeJXQvGdRnqatwZKQq/P73DR7LCSfYcYQkhbBll0DAJ/tbR8PVxIjWWeGpw4WFGBSZQdWbpsojYoSa6Oc6ROR2ajb0bEKdS1B6IOFOwPMIwtYxtn+N7VY4QLMkSaz1up0dcloxcBze8GsQ3YdLEr9QMllAh86H9DtLt5gWFvzHflRDWzqkSv1s3L5PftYg4eOS1UhHokKUes6Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFwDe0aD7AaUay9jr39+BaEWM5EYjEFaIcileb/swgc=;
 b=Vu0G4KIkJeB2KzrlvEKhwxZ90Y9wxJTmzL8AyRqyfpbUmj0j5u5dLVFNS025Z6o6fnUcLydWoGCJJ9/ZL0gEUWFZyPgi/MQXbb3pwc4vN2ZJF4p2AHzxqoEkd+QhQahAUUgDudautuSMofbgDt/a/KR3T+xK45xlqzU4cx31Yhw=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BY5PR12MB3761.namprd12.prod.outlook.com (2603:10b6:a03:1af::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Mon, 7 Mar
 2022 23:51:18 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::141:3edf:164a:857b]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::141:3edf:164a:857b%4]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 23:51:18 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Jung Daehwan <dh10.jung@samsung.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v2 1/2] usb: dwc3: Not set DWC3_EP_END_TRANSFER_PENDING in
 ep cmd fails
Thread-Topic: [PATCH v2 1/2] usb: dwc3: Not set DWC3_EP_END_TRANSFER_PENDING
 in ep cmd fails
Thread-Index: AQHYIZOvXlHACGixbUGMAnHCl5PyK6yTYqcAgADHvYCAALGHgIADVGEAgAA82ACAB34VgIAAlEuAgALM6QCAAD24AIAAAXqAgAADvQCABhmCgIAAJeOAgAAQ5ACAAA7AAIAF9GqAgAAw+ICABJabAIAADu+A
Date:   Mon, 7 Mar 2022 23:51:17 +0000
Message-ID: <818209ae-f3c5-3740-20a2-d5463b0b168b@synopsys.com>
References: <1644836933-141376-1-git-send-email-dh10.jung@samsung.com>
 <20220215063925.GC144890@ubuntu>
 <63c8c9d1-9b07-a9f2-3639-a38641e19a7a@synopsys.com>
 <6a1322c4-9589-f4de-d42c-d38af2e12e82@quicinc.com>
 <e3332511-82d3-2892-ad72-a0c167273174@synopsys.com>
 <01c4d42e-93cd-d293-f4e3-8c136049d87c@codeaurora.org>
 <894d54ad-b6f9-b942-be99-fe3ad102051b@synopsys.com>
 <dbd00cb1-b5d0-24e7-ef72-dff3765c26cf@codeaurora.org>
 <810de66c-7d73-fae0-9356-b06b48134ad6@synopsys.com>
 <1714910d-f923-d0c7-72a9-0c1d098f783f@codeaurora.org>
 <4371e407-7791-b0b5-dc8c-ad0be09acba4@synopsys.com>
 <e165c644-4ad0-b103-4f8b-2d3bc1b211f1@codeaurora.org>
 <b2eca3ba-5c36-c788-629c-016bd36be8a7@synopsys.com>
 <b0196760-0495-bd8d-7f41-e46f971b0beb@codeaurora.org>
 <d043eea8-b72e-f1ab-7f0d-93b3b0503de0@synopsys.com>
 <15aac89a-bf1d-9f30-6a9a-6d8fe97268ac@codeaurora.org>
 <594fbaf7-d9f0-a3a0-e660-880e12418282@synopsys.com>
 <1238af3f-3110-a1f2-808c-3c07282b4f14@codeaurora.org>
In-Reply-To: <1238af3f-3110-a1f2-808c-3c07282b4f14@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 973292f9-3439-4505-7a2a-08da00955fa4
x-ms-traffictypediagnostic: BY5PR12MB3761:EE_
x-microsoft-antispam-prvs: <BY5PR12MB3761F8DEFCD6E956E0D077C2AA089@BY5PR12MB3761.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BHBqpX4DAaG4p4etxEiMmHaOmDz8sDbc0UKuVr02/ChbxcOuJ2MaRLVcRtBn9tP2nZ/pt1qZcQZ+n34IW3OR9HNa1xHFZxbi9PC9CPPntUDs7Z0QTExUTTIrfZhEO+k5kzXe/yxGyRmi/t5H4rigXvIaEUElk7vb8Kyfuv57LJQ5uTT1hymVf4Ux8ajYSGeFwIXhJ/GjM4oBYaGUI3RUjfGWCuw4QiLyCa0MpnO63wlGY7+XewR6lrEj/aAIjS1MO6ufSvjaBbaMBpN/oT6OFHJkDDbLSJXyaR/wtjbnUQ6YJiA8pUYntDvk90EOAN7NJySka/sCsLTmUlgKiFa7O9hhXQwb+JpuCKPMF7nHDdsvNdi3eKlMPMrMj9wiuMs1xKyte2sPfMomSyCrRb51VLXOHnlzAoT1P7l/dgzpH14l7EFpc6tZq4JQVRsilBAqIZnYS2L2H9bg88ScdftGyzDPHH0O/QTrDG4TKBxSvPcoP24kSowUJ48qSPRY3SjhBhq+AofFPsljEzuyUjGHY20eYqJ0ZYN9EUXk9FIxQW7Jp880P5gRaRqYuttZPS7gkVNOqRkzPixI6sjiTnr5nUG0FBrFr8nYWPN4fz94Ws75imBpteUwZudUgrTwbXpkGOdApFFmSqQiaQ3uCqdx0SqV0P+eVXUD2OPLRR6feeUGAkOUGgL0+rmQMC3UWtMN+5Xcbl5YlXqNiSp2Dq7oH1BXl8wFJNAIMNTNaL2va93krx2DxHzy5LOgxeMJr4X3b0vUh0oB/vF9a8xK6yYztJEMwh5HRGDo5uoJ0BiN9saR+rQa82Cvx6wA+AaU+753OmfAJ7hXlByl2L9kZ3bG0jqr3PdEbbuarNGlKXDsqyk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(86362001)(5660300002)(8936002)(8676002)(64756008)(66556008)(66446008)(110136005)(66476007)(4326008)(83380400001)(54906003)(76116006)(66946007)(316002)(53546011)(31686004)(36756003)(6512007)(71200400001)(6506007)(38100700002)(2906002)(122000001)(26005)(186003)(2616005)(6486002)(966005)(508600001)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFk1Sk5TZGlaQ1A5akM2eFhRbVBTLzFDblZVRFV3ZEpuYjYyMGkxdHpRbFlk?=
 =?utf-8?B?RlVrejlWcFFUbGovMmJQZlpua1pPd29SU3d3YnZ6Zk1hVGRCcE9GNlFZVGxX?=
 =?utf-8?B?NE8zbXh1ZDVHT1ltL3NnY1ZFSENKalM3RFc2U1VmVC9XQ2JMMkovYTZnVGRt?=
 =?utf-8?B?ZTNwWVdqYkVLSmJoM3E5NWdVVWovOEVyOCsrWHJxTG92T25PTEIyelBXSUFk?=
 =?utf-8?B?STJ5MzNVRDJHY3VZTkZkbEhwL0Riaks0Z0o4Mk9RV2ozREhRdFBDTHNWS2Rw?=
 =?utf-8?B?SXNsTTRjSWgrcmora0NpRXFldmVXdUFZWktDMld2ZVJVekhZWUN0MmR0cFJB?=
 =?utf-8?B?MHFtU29oMzRGQlR6RFRTSGtmRDZ0SjZCNzQ2WjR1b1p0WkpuZG16WXAvMm1S?=
 =?utf-8?B?Mm1MQy8vaVdTaitXVERMZ0loZUtXd2RabGVNa2lxb1V0NTFXRHVzNEpTdHpv?=
 =?utf-8?B?eXdaWmV0N1hVVzd0cTBscXZQcG9tUW1JN0h6SDZRQzNqL0JyY002WEZLT2tD?=
 =?utf-8?B?V2wwWmdycVVMSGtPbmZDT1VYUkZNUVFFMWViVFRSeGVyY2grRnhJWEwyZTMz?=
 =?utf-8?B?R0NVZVdHSHlmakszaTJmT2tGbUZqYVhHR3Y4NHJsbEg2NzVXaGhSSjc0S3hv?=
 =?utf-8?B?dXFieEVJd21NdWlUZnZOU0JDM291UUlCbmpRYnpvTjhnUDU4OGxBYzVRRk1h?=
 =?utf-8?B?eHVCWTFYanYxSkRGdzA4bDc4OG1MMm82VUVxTUxvbGs5dytEdStBNXFQeStS?=
 =?utf-8?B?djc5QU9laDYzenM2TXM0MVdhWkVBUDhQZUlQSnZBK1ljbUtTQUwwcDlaTFBZ?=
 =?utf-8?B?MG5NbWZoN2FRWHAwREJLdXJRdEtaY0NTMys2bU41V2dkVUhDdHFEYmRlUnZ1?=
 =?utf-8?B?OU96Q3Jnbi9TVUIxcmF2Q21GTlZ5MldKcU0xdyt4VmtaazJ6Y0QwajJoYVB1?=
 =?utf-8?B?N3BZVW9jTkJGYlpwUmZsMHlIQi9sTitJOEk5ZkVBRWkyUnFDMmNJMS9ka0t5?=
 =?utf-8?B?ZHFQeGpxSmh2QkM1ZWVjdTVES0dzdFJGZ3d5NDkreVoyZTBiTWlDc3dxbitS?=
 =?utf-8?B?ZFpqSWpycWVsbFR0NkZxdjkwYTdnOTgrWllWZ2E0eTJtVWVUNXRwbjNQVEtT?=
 =?utf-8?B?ZWZsczdKUXlUYVRrT3FuNkdYb1BxQXpsd0NvNXYxT29tVEdUMnI2aXZsdUpx?=
 =?utf-8?B?emlZZENaU3MyRjZ3UzhmakFFeWkrc2FLOVhZTWJDNWNjVnkrTWNIaktrUXgw?=
 =?utf-8?B?NkFUQ1dxSjd0SmtUbEhQY1doV1o4alF4MFFZbG5OaVpBRXRtQThBR2s5Z3RJ?=
 =?utf-8?B?STRnZFJlNUNPUDBjWkE4c3FEOXg2Tk9TQlZJYXpnTThibUFHOUNRV0pVcm02?=
 =?utf-8?B?ZVdLVnMzbStRdUhtODluS0JuM1JORXFER2tRVUtaK0pIUkw5VW9JNFFnUUhP?=
 =?utf-8?B?L1llY0d0NWRlbnZTbytJT2kyVVRxaU80Smgwb2Z2WTNSUkVvUnhWK0ZFQWtM?=
 =?utf-8?B?UEIrbHpiSzBqa1VHVHlyZkNqbEZjZTdwc080NENGdXkvQ3lRS1Jod3RzaEZB?=
 =?utf-8?B?bWhrUlZjRmsvUXhkNHp1cWl2ZEdZaGI4cDFPa3p6TGM0UlltUnFhYmJCWWtO?=
 =?utf-8?B?aHVleHFTNVp2aUsrWUFMcU9WRVlkV21GWStBMTkrWGNzcmRaQjF6VEJoMmJE?=
 =?utf-8?B?Y0pyWkIzRmErcGErQ3kxeEJtRFFlaW1XMU0raE0vN3dBd0prQ1hSN3VheG1m?=
 =?utf-8?B?cVNnNGI4R1M2SkJENFV0V2V6SldCWEJuWW5FUjE0RFBWeS96dXlYQWhpb0pa?=
 =?utf-8?B?NDI4S3d0by9aZEV1K2xWdUtZSkg0YzJjUHhCY0RjZ1RwRTFjVGQ5S0RxeStJ?=
 =?utf-8?B?Ti9CS2s5a1JsbndjQ29ZcnRTelhzNUVKeEYyVGlFM1JnZHNqU1dCeTNSam1J?=
 =?utf-8?B?UEdXL3gwVmpSczJtWW9uZEl3Y0gxS1Jra2NLUTlTNXhnQ3FIeTZUUzV3YW11?=
 =?utf-8?B?Qmdvd1V4K0Q4K2krQXAzb1dyZ2UzNFl2YXdRVmZRcFowTWh0U2IwQzZsTkNX?=
 =?utf-8?B?WEZQdldJaDR0THMxZ0V2QWpnNW9aVVY4NU5GMkVMRWZTdk9QOU42UVowVHc2?=
 =?utf-8?B?K2dNY1RKbGM5NndaKzFDT3NFYUlJbHgwRXNyTysyZ0x6NStxbUZ4eDIyVDBv?=
 =?utf-8?B?Ymc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C630AE228AA0D4683BC205C9A7F6E93@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 973292f9-3439-4505-7a2a-08da00955fa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 23:51:18.0150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ugoq1CgAARTu9/dQ5ATX5ueXgoC7EAiiLM568o4mCi+FrIYP0PRgMNyaj357sj6CXKV3HnuFQG7AdehzYn830g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3761
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgV2VzbGV5LA0KDQpXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+IEhpIFRoaW5oLA0KPiANCj4gT24g
My80LzIwMjIgNDo1MyBQTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPj4gV2VzbGV5IENoZW5nIHdy
b3RlOg0KPj4+IEhpIFRoaW5oLA0KPj4+DQo+Pj4gT24gMi8yOC8yMDIyIDc6MDIgUE0sIFRoaW5o
IE5ndXllbiB3cm90ZToNCj4+Pj4gV2VzbGV5IENoZW5nIHdyb3RlOg0KPj4+Pj4gSGkgVGhpbmgs
DQo+Pj4+Pg0KPj4+Pj4gT24gMi8yOC8yMDIyIDU6MDkgUE0sIFRoaW5oIE5ndXllbiB3cm90ZToN
Cj4+Pj4+PiBIaSBXZXNsZXksDQo+Pj4+Pj4NCj4+Pj4NCj4+Pj4gPHNuaXA+DQo+Pj4+DQo+Pj4+
Pj4NCj4+Pj4+PiBbIDIxODEuNDgxOTU2ODY1ICAgICAgIDB4OWRjNjNmMjY1XSAgIGRiZ19jb21w
bGV0ZTogZXA2aW46IHRyYiBmZmZmZmZjMDFlN2Y1MmEwIChFNDM6RDQzKSBidWYgMDAwMDAwMDBl
YmFmMDAwMCBzaXplIDF4IDAgY3RybCAwMDAwMDgxMCAoaGxjczpzQzpub3JtYWwpDQo+Pj4+Pj4g
WyAyMTgxLjQ4MjA0NDczMCAgICAgICAweDlkYzYzZjhmY10gICBkYmdfZ2FkZ2V0X2dpdmViYWNr
OiBlcDZpbjogcmVxIGZmZmZmZjg4NjA2NTc1MDAgbGVuZ3RoIDgvOCB6c0kgPT0+IDANCj4+Pj4+
PiBbIDIxODEuNDgyMjIyNDkwICAgICAgIDB4OWRjNjQwNjUxXSAgIGV2ZW50ICgwMDAwYzA0MCk6
IGVwMG91dDogVHJhbnNmZXIgQ29tcGxldGUgKHNJTCkgW1NldHVwIFBoYXNlXQ0KPj4+Pj4+IFsg
MjE4MS40ODIyNzMyNzEgICAgICAgMHg5ZGM2NDBhMjBdICAgZGJnX3RyYWNlX2xvZ19jdHJsOiBH
ZXQgSW50ZXJmYWNlIFN0YXR1cyhJbnRmID0gNCwgTGVuZ3RoID0gMjApDQo+Pj4+Pj4gWyAyMTgx
LjQ4MjMzNDc4MiAgICAgICAweDlkYzY0MGViY10gICBkYmdfZXBfcXVldWU6IGVwNmluOiByZXEg
ZmZmZmZmODg2MDY1NzUwMCBsZW5ndGggMC84IHpzSSA9PT4gLTExNQ0KPj4+Pj4+IFsgMjE4MS40
ODIzNTczODYgICAgICAgMHg5ZGM2NDEwNmVdICAgZGJnX3ByZXBhcmU6IGVwNmluOiB0cmIgZmZm
ZmZmYzAxZTdmNTJiMCAoRTQ0OkQ0MykgYnVmIDAwMDAwMDAwZWE1NzgwMDAgc2l6ZSAxeCA4IGN0
cmwgMDAwMDA4MTEgKEhsY3M6c0M6bm9ybWFsKQ0KPj4+Pj4+IFsgMjE4MS40ODIzOTE4NjUgICAg
ICAgMHg5ZGM2NDEzMDRdICAgZGJnX3NlbmRfZXBfY21kOiBlcDZpbjogY21kICdVcGRhdGUgVHJh
bnNmZXInIFtkMDAwN10gcGFyYW1zIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIC0tPiBzdGF0
dXM6IFN1Y2Nlc3NmdWwNCj4+Pj4+PiBbIDIxODEuNDgyNDg1NjE1ICAgICAgIDB4OWRjNjQxYTBk
XSAgIGRiZ19zZW5kX2VwX2NtZDogZXAwb3V0OiBjbWQgJ1N0YXJ0IFRyYW5zZmVyJyBbNDA2XSBw
YXJhbXMgMDAwMDAwMDAgZWZmZmEwMDAgMDAwMDAwMDAgLS0+IHN0YXR1czogU3VjY2Vzc2Z1bA0K
Pj4+Pj4+IFsgMjE4MS40ODI1NjUzMDMgICAgICAgMHg5ZGM2NDIwMDZdICAgZXZlbnQgKDAwMDAx
MGMwKTogZXAwb3V0OiBUcmFuc2ZlciBOb3QgUmVhZHkgWzBdIChOb3QgQWN0aXZlKSBbRGF0YSBQ
aGFzZV0NCj4+Pj4+PiBbIDIxODEuNDgyNzE5NDE3ICAgICAgIDB4OWRjNjQyYjk2XSAgIGV2ZW50
ICgwMDAwMjA0MCk6IGVwMG91dDogVHJhbnNmZXIgQ29tcGxldGUgKFNpbCkgW0RhdGEgUGhhc2Vd
DQo+Pj4+Pj4gWyAyMTgxLjQ4MjgxNDkzOCAgICAgICAweDlkYzY0MzJjMF0gICBkYmdfZ2FkZ2V0
X2dpdmViYWNrOiBlcDBvdXQ6IHJlcSBmZmZmZmY4N2RmODRkOTAwIGxlbmd0aCAyMC8yMCB6c0kg
PT0+IDANCj4+Pj4+PiBbIDIxODEuNDgyOTI2MDg0ICAgICAgIDB4OWRjNjQzYjE2XSAgIGV2ZW50
ICgwMDAwMjBjMik6IGVwMGluOiBUcmFuc2ZlciBOb3QgUmVhZHkgWzBdIChOb3QgQWN0aXZlKSBb
U3RhdHVzIFBoYXNlXQ0KPj4+Pj4+IFsgMjE4MS40ODMwMjQyNjEgICAgICAgMHg5ZGM2NDQyNzJd
ICAgZGJnX3NlbmRfZXBfY21kOiBlcDBpbjogY21kICdTdGFydCBUcmFuc2ZlcicgWzQwNl0gcGFy
YW1zIDAwMDAwMDAwIGVmZmZhMDAwIDAwMDAwMDAwIC0tPiBzdGF0dXM6IFN1Y2Nlc3NmdWwNCj4+
Pj4+Pg0KPj4+Pj4+IFRoZSBjb250cm9sIHN0YXR1cyBpc24ndCBjb21wbGV0ZWQgaGVyZS4NCj4+
Pj4+Pg0KPj4+Pj4+IFsgMjE4MS40ODMwNjk1MjEgICAgICAgMHg5ZGM2NDQ1ZDddICAgZGJnX2Vw
X2RlcXVldWU6IGVwMmluOiByZXEgZmZmZmZmODc5ZjVhOGIwMCBsZW5ndGggMC82MzY4MCB6c0kg
PT0+IC0xMTUNCj4+Pj4+PiBbIDIxODEuNDk2MDY4NzkyICAgICAgIDB4OWRjNjgxNGM5XSAgIGRi
Z19zZW5kX2VwX2NtZDogZXAyaW46IGNtZCAnRW5kIFRyYW5zZmVyJyBbNTBkMDhdIHBhcmFtcyAw
MDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAtLT4gc3RhdHVzOiBUaW1lZCBPdXQNCj4+Pj4+Pg0K
Pj4+Pj4+IEJ1dCB0aGUgZGVxdWV1ZSBtYXkgY29tZSB3aGVuIGhvc3QgYWxyZWFkeSBzZW50IGEg
bmV3IFNldHVwIHBhY2tldC4NCj4+Pj4+PiBUaGUgZXAwb3V0IGhhc24ndCBzdGFydGVkIHlldCBh
dCB0aGUgcG9pbnQuDQo+Pj4+Pj4NCj4+Pj4+PiBEdWUgdG8gdmFyaW91cyBzeXN0ZW0gbGF0ZW5j
eSwgSSBjYW4gc2VlIHRoYXQgdGhpcyBjYW4gaGFwcGVuIHdoZW4NCj4+Pj4+PiB0aGUgZHdjMyBk
cml2ZXIgaGFzbid0IHJlY2VpdmVkIHRoZSBpbnRlcnJ1cHQgbm90aWZpZWQgdGhlIHN0YXR1cyBz
dGFnZQ0KPj4+Pj4+IGV2ZW50IHlldC4NCj4+Pj4+Pg0KPj4+Pj4+IElmIHRoYXQncyB0aGUgY2Fz
ZSwgdGhlIGhvc3QgbWF5IGhhdmUgYWxyZWFkeSBzZW50IHRoZSBTZXR1cCBwYWNrZXQNCj4+Pj4+
PiBhdCB0aGlzIHBvaW50LiBTbyB0aGUgRW5kIFRyYW5zZmVyIG1heSBnZXQgc3R1Y2sgaWYgdGhl
IFNldHVwIHBhY2tldA0KPj4+Pj4+IGlzbid0IERNQSBvdXQgeWV0Lg0KPj4+Pj4+DQo+Pj4+Pj4g
Q2FuIHlvdSB0cnkgdGhlIGNoYW5nZSBiZWxvdyB0byBzZWUgaWYgaXQgcmVzb2x2ZXMgdGhlIGlz
c3VlPw0KPj4+Pj4gVGhhbmtzLCBUaGluaC4gIFN1cmUgSSdsbCBnaXZlIGl0IGEgdHJ5IHdpdGgg
dGhpcyBjaGFuZ2UuICBUaGlzIGlzIHZlcnkNCj4+Pj4+IHNpbWlsYXIgdG8gdGhlIGNoYW5nZSBw
cm9wb3NlZCBoZXJlIGFzIHdlbGw6DQo+Pj4+Pg0KPj4+Pj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNv
bS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXVzYi8yMDIyMDIxNjAwMDgzNS4y
NTQwMC0zLXF1aWNfd2NoZW5nQHF1aWNpbmMuY29tL19fOyEhQTRGMlI5R19wZyFLbGdTcE5FTE9Y
UXlkSVF1YXJBM0E0TkpYSWN2SHNsWHF6T2RCd1lxVUlSOTdNcWRwOHpkeWV6aE9DOUVKNlVxeEx4
TSQgDQo+Pj4+Pg0KPj4+Pg0KPj4+PiBOb3Qgc3VyZSBpZiB0aGlzIGNvbXBsZXRlbHkgcmVzb2x2
ZXMgdGhlIGlzc3VlIGhlcmUuIFRoZSBjaGFuZ2Ugc2VlbXMgdG8NCj4+Pj4gaXNzdWUgdGhlIEVu
ZCBUcmFuc2ZlciBjb21tYW5kIGJlZm9yZSBTdGFydCBUcmFuc2ZlciBmb3IgdGhlIG5leHQgU2V0
dXANCj4+Pj4gc3RhZ2UgY29tcGxldGVzLiBBbHNvIGl0J3MgbWlzc2luZyBzb21lIGNoZWNrcyBm
b3IgYXN5bmMgY2FsbHMgdG8gdGhlDQo+Pj4+IGVuZHBvaW50IHRoYXQncyBwZW5kaW5nIGRlcXVl
dWUuIEFsc28sIHdlIG1heSBub3QgbmVlZCB0byB3YWl0IGZvciBFbmQNCj4+Pj4gVHJhbnNmZXIg
Y29tbWFuZCB0byB0aW1lIG91dCBpZiB3ZSBrbm93IHRoZSBjb25kaXRpb24gdG8gYXZvaWQuDQo+
Pj4+DQo+Pj4+PiBPbmUgdGhpbmcgdG8gbWVudGlvbiBpcyB0aGF0LCBJJ20gbm90IHN1cmUgaG93
IGRlcGVuZGFibGUgY2hlY2tpbmcgc29sZXkNCj4+Pj4+IHRoZSBlcDBzdGF0ZSB3b3VsZCBiZS4g
IEkndmUgc2VlbiBzb21lIHNjZW5hcmlvcyB3aGVyZSB3ZSdkIHJ1biBpbnRvIHRoZQ0KPj4+Pj4g
ZW5kIHRyYW5zZmVyIHRpbWVvdXQgZHVyaW5nIHRoZSB0aW1lIGJldHdlZW4gaW5zcGVjdGluZyB0
aGUgU0VUVVAgcGFja2V0DQo+Pj4+PiAoZHdjM19lcDBfaW5zcGVjdF9zZXR1cCgpKSBhbmQgd2hl
biB0aGUgZGF0YSBwaGFzZSBpcyBxdWV1ZWQuICBUaGUNCj4+Pj4+IHRpbWluZyBvZiB0aGUgZGF0
YSBwaGFzZSBjYW4gcG90ZW50aWFsbHkgZGlmZmVyIGlmIGl0IGlzIGEgdmVuZG9yDQo+Pj4+PiBz
cGVjaWZpYyBjb250cm9sIHJlcXVlc3QuDQo+Pj4+DQo+Pj4+IFRoaXMgdGltZW91dCBzaG91bGQg
b25seSBhcHBseSB0byBTZXR1cCBwYWNrZXQgYW5kIFNldHVwIHN0YWdlLiBFdmVuIGlmDQo+Pj4+
IGl0J3MgdmVuZG9yIHNwZWNpZmljIGNvbnRyb2wgcmVxdWVzdCwgaXQgc2hvdWxkIGJlIGZpbmUu
IEhvc3Qgc2hvdWxkIG5vdA0KPj4+PiBpc3N1ZSBhIFNldHVwIHBhY2tldCB1bnRpbCBpdCByZWNl
aXZlcyBhIHN0YXR1cyBzdGFnZSAodW5sZXNzIHRoZXJlJ3MgYQ0KPj4+PiBkaXNjb25uZWN0IGlu
IHRoZSBtaWRkbGUgb2YgYSBjb250cm9sIHRyYW5zZmVyLCBidXQgdGhhdCdzIGEgZGlmZmVyZW50
DQo+Pj4+IGlzc3VlKS4NCj4+Pj4NCj4+Pj4gSWYgeW91IGRvIHNlZSBhIHByb2JsZW0uIFdlIGNh
biB0YWtlIGEgbG9vayBmdXJ0aGVyLg0KPj4+Pg0KPj4+IFNvIGZhciBzbyBnb29kIHcvIHRoZSB0
ZXN0aW5nLiAgSGFkIHRvIG1ha2UgYSBzbWFsbCBjaGFuZ2UgaW4geW91ciBwYXRjaA0KPj4+IHRv
IGZpeCBhIHR5cG86DQo+Pj4gICAgICAgICAgICAgICAgIGlmICghKGR3YzNfZXAtPmZsYWdzICYg
RFdDM19FUF9ERUxBWV9TVE9QKSkNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICBjb250aW51
ZTsNCj4+Pg0KPj4+ICAgICAgICAgICAgICAgICBkd2MzX2VwLT5mbGFncyAmPSB+RFdDM19FUF9E
RUxBWV9TVE9QOw0KPj4+ICAgICAgICAgICAgICAgICByZXQgPSBkd2MzX3N0b3BfYWN0aXZlX3Ry
YW5zZmVyKGR3YzNfZXAsIHRydWUsIHRydWUpOw0KPj4+DQo+Pj4gV2FzIHVzaW5nIGRlcCBpbnN0
ZWFkIG9mIGR3YzNfZXAuICBXaWxsIGxldCB0aGlzIHJ1biBvdmVyIHRoZSB3ZWVrZW5kDQo+Pj4g
YW5kIGdldCBiYWNrIHRvIHlvdS4NCj4+Pg0KPj4NCj4+IE9rLiBUaGlzIHNlZW1zIHRvIGNvbmZp
cm0gbXkgc3VzcGljaW9uLiBDYW4geW91IHVwZGF0ZSB0aGUgcGF0Y2ggd2l0aA0KPj4gdGhlIGZv
bGxvd2luZyBhZGp1c3RtZW50Og0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2Mz
L2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPj4gaW5kZXggM2U3NWVhYTEz
YWJjLi5jM2Y3NTI5ZjY0ZmMgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdl
dC5jDQo+PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+PiBAQCAtMjMwOSw2ICsy
MzA5LDEwIEBAIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfZXBfZGVxdWV1ZShzdHJ1Y3QgdXNiX2Vw
ICplcCwNCj4+ICAgICAgICAgICAgICAgICBpZiAociA9PSByZXEpIHsNCj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgIHN0cnVjdCBkd2MzX3JlcXVlc3QgKnQ7DQo+Pg0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgaWYgKGR3Yy0+ZXAwc3RhdGUgIT0gRVAwX1NFVFVQX1BIQVNFICYmDQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIWR3Yy0+ZGVsYXllZF9zdGF0dXMpDQo+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRlcC0+ZmxhZ3MgfD0gRFdDM19FUF9ERUxBWV9T
VE9QOw0KPj4gKw0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgLyogd2FpdCB1bnRpbCBpdCBp
cyBwcm9jZXNzZWQgKi8NCj4+ICAgICAgICAgICAgICAgICAgICAgICAgIGR3YzNfc3RvcF9hY3Rp
dmVfdHJhbnNmZXIoZGVwLCB0cnVlLCB0cnVlKTsNCj4+DQo+PiBUaGlzIGlzIHRvIGF2b2lkIGEg
Y2FzZSBpZiB0aGUgZnVuY3Rpb24gZHJpdmVyIGhhcyBzb21lIGRlcGVuZGVuY3kgZm9yDQo+PiBy
ZXF1ZXN0cyB0byByZXR1cm4gYmVmb3JlIHNlbmRpbmcgdGhlIGNvbnRyb2wgc3RhdHVzIHVzaW5n
IGRlbGF5ZWQNCj4+IHN0YXR1cywgd2hpY2ggY2FuIGNhdXNlIGEgaGFuZy4NCj4+DQo+PiBXZSBv
bmx5IG5lZWQgdG8gbWFrZSBzdXJlIG5vdCB0byBpc3N1ZSBFbmQgVHJhbnNmZXIgYWZ0ZXIgdGhl
IHN0YXR1cw0KPj4gdHJhbnNmZXIgc3RhcnRlZCBhbmQgYmVmb3JlIGl0cyBjb21wbGV0aW9uIGlu
dGVycnVwdCwgd2hpY2ggbWF5IHByZXZlbnQNCj4+IHRoZSBkcml2ZXIgZnJvbSBzdGFydGluZyB0
aGUgU2V0dXAgc3RhZ2UuDQo+Pg0KPiANCj4gQWRkZWQgdGhlIGFib3ZlIGNoYW5nZSwgYW5kIHRl
c3RlZCBpdCBvdmVyIHRoZSB3ZWVrZW5kIGFuZCBpdCB3YXMNCj4gd29ya2luZyB3ZWxsIGZvciBt
ZS4gIEhvd2V2ZXIsIEkgd2Fzbid0IGFibGUgdG8gcmVhbGx5IHRlc3QgdGhlDQo+IGRlbGF5ZWRf
c3RhdHVzIGZsYWcgdG9vIG11Y2gsIHNpbmNlIHdlIGRvbid0IGhhdmUgYSBmdW5jdGlvbiBkcml2
ZXIgdGhhdA0KPiB1dGlsaXplcyB0aGUgVVNCX0dBREdFVF9ERUxBWUVEX1NUQVRVUyB0b28gbXVj
aC4gKHdlIG9ubHkgaGF2ZSBhIEZGUw0KPiBpbnRlcmZhY2UsIHdoaWNoIHdpbGwgZG8gaXQgZHVy
aW5nIGVudW0sIHdoaWNoIGlzIHBhcnQgb2YgdGhlIHRlc3QgY2FzZQ0KPiBJIHJhbikNCj4gDQoN
ClRoYW5rcyBmb3IgdGhlIHRlc3QuIFRoZSBkZWxheWVkIHN0YXR1cyBjaGVjayBpcyBvbmx5IG1l
YW50IGZvciBhDQpzcGVjaWFsIGNhc2UgaWYgdGhlIGZ1bmN0aW9uIGRyaXZlciB3YWl0cyBmb3Ig
ZGVxdWV1ZWQgcmVxdWVzdHMgdG8NCnJldHVybiBiZWZvcmUgc2VuZGluZyB0aGUgY29udHJvbCBz
dGF0dXMuIE5vIGZ1bmN0aW9uIGRyaXZlciBpcyBkb2luZw0KdGhpcyBhdCB0aGUgbW9tZW50LCBi
dXQgSSB3YW50IHRvIHB1dCB0aGUgY2hlY2sgaGVyZSBhbnl3YXkgZm9yIHJvYnVzdG5lc3MuDQoN
Cj4gV291bGQgaXQgYWxzbyBtYWtlIHNlbnNlIHRvIGNoZWNrIGZvciB0aGUgZHdjLT5zZXR1cF9w
YWNrZXRfcGVuZGluZyBmbGFnDQo+IGFzIHdlbGwgaW4gdGhlIHNhbWUgSUYgY29uZGl0aW9uPyAg
VGhhdCB3b3VsZCBtZWFuIHRoYXQgdGhlcmUgd2FzIGENCj4gU0VUVVAgcGFja2V0IGNhY2hlZCBp
biB0aGUgY29udHJvbGxlciwgd2hpY2ggd291bGQgbmVlZCB0byBiZSBoYW5kbGVkLg0KPiBJIGhl
YXJkIGZyb20gb3VyIENDIHcvIFN5bm9wc3lzIHRoYXQgd2UgbmVlZCB0byBlbnN1cmUgYW55IHBl
bmRpbmcgU0VUVVANCj4gcGFja2V0cyBzdG9yZWQgaW4gaW50ZXJuYWwgbWVtb3J5IG5lZWRlZCB0
byBiZSBjbGVhcmVkIGFzIHdlbGwgYmVmb3JlDQo+IGlzc3VpbmcgdGhlIGVuZHhmZXIuDQoNCkN1
cnJlbnRseSB0aGUgZHdjMyBkcml2ZXIgZG9lc24ndCBoYW5kbGUgc2V0dXBfcGFja2V0X3BlbmRp
bmcuIEl0IG9ubHkNCnVzZXMgdGhhdCBmbGFnIHRvIGhhbmRsZSBzb21lIHF1aXJrLiBJdCBzaG91
bGQgYmUgZmluZSB3aGVuIGl0IGlzDQppbXBsZW1lbnRlZCAoYXQgc29tZSBwb2ludCBldmVudHVh
bGx5IDopKS4NCg0KSWYgdGhlIEVQMF9TRVRVUF9QSEFTRSBmbGFnIGlzIHNldCwgdGhhdCBtZWFu
cyB0aGF0IHRoZSBkcml2ZXIgaGFkIHNldHVwDQp0aGUgVFJCIGZvciB0aGUgU2V0dXAgc3RhZ2Us
IHNvIHRoZSBTZXR1cCBwYWNrZXQgY2FuIGJlIERNQSdlZCBvdXQNCndpdGhpbiB0aGUgRW5kIFRy
YW5zZmVyIHRpbWVvdXQuIFdoZW4gdGhlIGhhbmRsaW5nIG9mDQpzZXR1cF9wYWNrZXRfcGVuZGlu
ZyBpcyBpbXBsZW1lbnRlZCwgaXQgc2hvdWxkIHByb3Blcmx5IHVwZGF0ZSB0aGUgZXAwc3RhdGUu
DQoNCk5vdGU6IGhpdHRpbmcgdGhlIHBlbmRpbmcgc2V0dXAgcGFja2V0IHNob3VsZCBiZSByYXJl
LiBJdCBjYW4gaGFwcGVuIHdoZW4NCjEpIEhvc3QgYWJvcnRzIHRoZSBjb250cm9sIHRyYW5zZmVy
IGZvciBzb21lIHJlYXNvbiBhbmQgc3RhcnQgYSBuZXcgb25lDQoyKSBUaGUgZGV2aWNlIGlzIGRp
c2Nvbm5lY3RlZCBpbiB0aGUgbWlkZGxlIG9mIHRoZSBjb250cm9sIHRyYW5zZmVyDQoNCklmIHlv
dSBwbGFuIHRvIGltcGxlbWVudC9oYW5kbGUgdGhpcyBzY2VuYXJpbywgSSdsbCBiZSBoYXBweSB0
byByZXZpZXcNCnlvdXIgY2hhbmdlcy4NCg0KDQo+IA0KPiBUaGlzIHNvdW5kcyBzaW1pbGFyIHRv
IHlvdXIgc3RhdGVtZW50IHByZXZpb3VzbHkgYWJvdXQgaWYgdGhlIFNFVFVQDQo+IHBhY2tldCB3
YXNuJ3QgRE1BJ2VkIG91dCB5ZXQuDQo+IA0KPiBUaGFua3MNCj4gV2VzbGV5IENoZW5nDQo+IA0K
DQpQbGVhc2Ugc3VibWl0IHRoaXMgZml4IHNlcGFyYXRlbHkgZnJvbSB5b3VyIG90aGVyIFJGQyBw
YXRjaGVzIHNvIGl0IGNhbg0KZ28gaW50byB0aGUgZHJpdmVyLg0KDQpUaGFua3MsDQpUaGluaA0K
