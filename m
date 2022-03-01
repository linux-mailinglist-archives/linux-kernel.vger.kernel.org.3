Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FBD4C8167
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 04:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbiCADDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 22:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiCADDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 22:03:13 -0500
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FBBBCBA;
        Mon, 28 Feb 2022 19:02:30 -0800 (PST)
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id AAF5540397;
        Tue,  1 Mar 2022 03:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1646103750; bh=M/ykRhpYILcm7ImtZD9p2lKLxH0fAxhVXDg5XJRX0YE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=LFdMYlieTEPbyIc0E8CaDy6XA5eATgI91k/zgtw+rlNO7o47Z0Tb7kqPGt6a7REG7
         X8TIcsuYbAWdbutreOtVgJ9BTlzIUAzzU5AaQK/WA/Mm+HaeNGOLvQyvH5ir8hXlbZ
         LJne2IkRaW7N3E45YUFq2xTsfIJWnhRm0d/gzRLqaFINrZl3OTNEMzX7kpCK5PS7kR
         KtjFmP86qth0iGAvaJWgCbFvw1Uh3zibIk234iqHmF/Oa+BToE88jXvr9qDxGYi+eZ
         OlOSf1I6LGeF5Ys2tmLZkLhUnwHJmvVAgU62Q3gOCgfigsEfD0c8JMA3/Qe9OCKd1O
         hmzjVRsPFfp0A==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 5A9C3A007F;
        Tue,  1 Mar 2022 03:02:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 253FC8014D;
        Tue,  1 Mar 2022 03:02:26 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="tsOdo3nY";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IeQXtySLVZJpG27wRlxGKheOXTXIP3rhRYzQHAd2FoZ9UN94u24K+vVKRXfw+ZWfziU3yibVujjXgrMXcSv+3YLofpipRtSvrRNPvIMdn2it0oK3E4SE+IV3fDnqnRZqsMFzqqocJjkIwb2e8nAfq8thtPDo2mkdmGi2nP4f1rQMDuboo2bph2szYSY/5XRQHiYUPoHeJbmgeW7sXpkHno6u+HD8dEDxyGQzXC8Zzj1KZQ/OKe8dgpvfVlb0LNX1NsqZKI6iBDIeEyHIm00VIlO/fv2UU5u24WbdAxupu9Pto2fWObG4M+/zn0m4wRS27hS6RaW01TNCqAU7jh0elQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/ykRhpYILcm7ImtZD9p2lKLxH0fAxhVXDg5XJRX0YE=;
 b=ZvzbZnx+w3UEsLTKE5Pj7i/Zh/MYszZQYonGIn8WgCtH1EBO5n5a5bisUSFA6ZFohvXNh9cavyC9j4uVqFqacy0TJl52ePBaep7fLHEUu8yosupzxjhOQC0IXr0Q4TGIqL10jg3cPGQtqw3GsJ756GQlDUANv4DbyFvEsP5kas0rUjlhM9UZ3FBbavXTN8oJkGvzWgN3b7d6uxGHEsVj/jpkJLihNsJFh+Yk0OiCO6YzdJN9KYuzp9s3DVz/y7zhpl4BdNKGGG93BQ3r2zZzt4teOBCYd6mmxWqUPXleUZpQSjs37TA5uJi84Z8Ua+Wxp9ce0oPAaJoqVmnwHnkGfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/ykRhpYILcm7ImtZD9p2lKLxH0fAxhVXDg5XJRX0YE=;
 b=tsOdo3nYiBt/oGtHC2V68xuV8qD6jDn5pV+v7MhG0rPONizXCl8M7lnnJ7JpKSdN29a9Za6PUXTvgrIsqg7BzyiEBkpYPGqCOUdUsQ1bHR5pvwasOvMd/ugXsRBqIShL3ouRWD8KGq4RZwcHwOoURmGMxteQyIpu8mh8blmHT3w=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM4PR12MB5986.namprd12.prod.outlook.com (2603:10b6:8:69::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Tue, 1 Mar
 2022 03:02:25 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::141:3edf:164a:857b]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::141:3edf:164a:857b%4]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 03:02:25 +0000
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
Thread-Index: AQHYIZOvXlHACGixbUGMAnHCl5PyK6yTYqcAgADHvYCAALGHgIADVGEAgAA82ACAB34VgIAAlEuAgALM6QCAAD24AIAAAXqAgAADvQCABhmCgIAAJeOAgAAQ5ACAAA7AAA==
Date:   Tue, 1 Mar 2022 03:02:25 +0000
Message-ID: <d043eea8-b72e-f1ab-7f0d-93b3b0503de0@synopsys.com>
References: <1644836933-141376-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220214111149epcas2p1a1faeda037991885fd6f2f026fa44ec5@epcas2p1.samsung.com>
 <1644836933-141376-2-git-send-email-dh10.jung@samsung.com>
 <ff604504-00df-0c1b-673e-892e42737f7a@synopsys.com>
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
In-Reply-To: <b0196760-0495-bd8d-7f41-e46f971b0beb@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3b716ed-c693-48e3-9dd0-08d9fb2fe9a0
x-ms-traffictypediagnostic: DM4PR12MB5986:EE_
x-microsoft-antispam-prvs: <DM4PR12MB5986E03C7338E63AE89342F3AA029@DM4PR12MB5986.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rDJMlwsCb/J6T+NdKzpBegy/fK3NYLgfm0ZZ7xaoOboBr9aOi2intezy1CjKwkcMv0XE1Cbez7W7MwdLfUS5QKSM/buuoegntW/059P4kVvz3GH0DLf/Rbzci0ic5CAeRWnSbpjEf4/g1cbrBtffCudJD8OabgoFBHx+dOTE18WB/XsPv4EYIimBnMYInuIGhU3VdHsg3GyhrG1VoesZIGPbbKDZZ8hH45N/fgTxkip5EPSJhhjmN/6+G1lyfQ4lf8RWN0PnSb89J37QY3otrrIpza2ygThYSkxAwIG9GRbv0p6xrOHXlkqa7wuHVEOLhVTKBxkuhzjZ0W7Gs/YUaAISdsuQMbMvGCPL17CbjTkLvJlY/CKp7UxlW3ViW29HdM3pxI/t9aEQbCCIlc8qnjUf8ZOM54+JWKWCcxyUGiD+9zEp7xk7+819/zpD8F3WmDsMLRXiU7VIkIKBagODKVHL1tdrh0FUoViHk6KljgyObk81G4mTtCPZQgOswLrGwG4XuOvVK0UzHm3wtPKVWHYepb2URCZghzUhYYAR1bwV5Wgs+IrPwZ1gNe6yo8BEEYrvNDF5Nk7bQLFDbEUhkcD8gkC4QiLBxzCyPYX95PBbjoQatOxEC5doOMt2X6mJ3QBQATZ3dCnHFJrP2ZwDVfjIpIlgA5FXZHEY5y+L4CAVG8O0FFBf/bz6iUWvlRY3iiqvWBRh4/vY4F2ELerr1cKOelLbZ3hO5xlwr5SzRLGWAKMl7iZcOo7rsIQ4M4f42k9LyFO4BLr64hIzeRKCGgqflp6rHO6feqTXiU+mW11bM0iO991X3Axiape6H9qqzGcjJTc8r53Jjlj+6SywMVoY7jBQs15n4dZkFhnjYGU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(6506007)(6512007)(36756003)(38070700005)(31686004)(64756008)(71200400001)(76116006)(5660300002)(4326008)(53546011)(83380400001)(26005)(186003)(2616005)(66446008)(122000001)(8936002)(66476007)(6486002)(38100700002)(966005)(86362001)(54906003)(316002)(110136005)(2906002)(66946007)(66556008)(508600001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTQ1UDNUSWh3VlptR0ZmR0ZOWjF3dWs1TkFNbzhkNlZyRGFJNDNxTzMvaXBw?=
 =?utf-8?B?bmhLNTFveE1HS2puelBRTThHRlJvcXpKMkxFZUJyZlFnQ0Y2K2daY3JzbG82?=
 =?utf-8?B?Q1cySEtQRE9ZeFhNSVEzekR6R3pPMks5MzBLVVVWTGxUKzZTWE1kT0lqbVEz?=
 =?utf-8?B?MDl0eERkY1FNZVl0MDB5SGVGMUFFVk9pQncycHYrRUVOMUYvQmhrblU1QXhQ?=
 =?utf-8?B?MTRxcXJ1VUorZHZscjJJb2JpYzdSQkJEYnFlSEpVTDlRa2tZRTJ3R3FabzQ5?=
 =?utf-8?B?RURjc3g3VndrYVZnRXJubXNsU3ovL2llalZRcS9HMUNrQXR3RmlIMXpJU2l3?=
 =?utf-8?B?b2gzU2JDZ3lQbDExcHJlV3Vrdk5BOXVoZW9FbGk5MXJsNVErY0daUDR3OHRv?=
 =?utf-8?B?VElLbzdhUTVaR0k2V2RRVUhSbW50bE9jU0hyRmpib1VHbzhPcmhmLzgwcFdS?=
 =?utf-8?B?ZVlGTmw5N3Jza0VHNFJaUTBKanZHWW9TVnJtUWFMYXVzTGw5KzRTWTVRTEdj?=
 =?utf-8?B?VUVPdlgrbFF3K3FqNnhURUF2WTFLNGEvSjNzWnVRQUZDR1RGcTlhak5jaHpI?=
 =?utf-8?B?S3l6OXZBYVc0SFB6ZUlTUUtwNXVCSFUyekJ1RjEySC9ySVJMTkZSTlBVU1FN?=
 =?utf-8?B?RjQ4UGlha0RxbWJyZUo5dFFWVXhRNUNZaHpYOXlqZ2I5ejNDTlFqWm9LUVpt?=
 =?utf-8?B?STVySnppVGg2dllCdFVQSkxBUHNmaWQveXdrcGl4WDBtK0o3SVNQcTZlRFA2?=
 =?utf-8?B?Q1g5WndYbU9wZUR6dllTOE9uK0VndisxNVF1UkZmNTFVVEpoYitHQnZtOGdG?=
 =?utf-8?B?ekV0OGw0a0FkdHZ5Q2ZMR0lPbDJicXdsdFA1TG1rVmNKYXB3OFQyQnFVZXNO?=
 =?utf-8?B?UWVCemN1dmJuNGtWalFPRTErTXhsd2ZoQ2hkYTVDTHpFMG1nREdMdEJtSVV4?=
 =?utf-8?B?bHloU1VEVXQvK0kwckF1bXVCeTlnVGF5THhFWkZMRTFJblR3ZVVxUy8zMDdy?=
 =?utf-8?B?WlFYbG9rWi91ZUtuSzVwTVN4MVhOT0xVazl2T1p4a1FLeG9rcFY2aTJXV3c0?=
 =?utf-8?B?RDlDWGpMdGh6M2VzWGFaUmNoNUVPQ2tZZjA2cUVBb2hGNFFSSklqWXdjK09w?=
 =?utf-8?B?RE4xS0prVmk4clM1Q3JINnJycjFhekVsVEdNcFJLaTBQd01xT21vZlQrZFZ6?=
 =?utf-8?B?cDhXYTlzcU1RMWZOZFNDSUV4Tkt1YkdHdFBSamJudjRZcEVDY1UvQXZWZUJm?=
 =?utf-8?B?eERwTzdMQTZCTjZ5UkRwdW5BUVhYdlZjSjczSW55U01rT0VMbGx0RkF0WDJF?=
 =?utf-8?B?Q3lmRU5FV3B1bUlZRDdVRlFaR0ZpVzJVWEk5YWd2VCtSOEZLZHhiTXU1Tjdh?=
 =?utf-8?B?T3JEMjlTTFJqNXN0M1ZFV1lsTEhXVWwvMjFQZ1ZnMDBkemk3UEVMZWVEZ1Uy?=
 =?utf-8?B?YWdtTHU4eHRXSVZ1dlNhUjY5STRoc2R6c1kzRGNpSXZHZ0lwdmdDaGxYV2sw?=
 =?utf-8?B?M25zaUxVNTREL2lvaTZ0aHQvOUxWZkp4MGdCTWE3aGsyWk9MMmZCYXNzSS9S?=
 =?utf-8?B?bHRxdXdDSHRveGtScUgvWWJPeUlyeGxGMzZVWjhwZG1SVmhwSGxIdGU3azVU?=
 =?utf-8?B?cFhRTCtVQThFc1hTNFVndU9FTDgzN2JEeExBcmVDbDlrZVFsUVg2TllIOU1s?=
 =?utf-8?B?ZzFpeVRkOEpIOG0rcElzWmxxRTJ4OEE0clE5T2dLSnRqQWMwbk1qbUttT2hU?=
 =?utf-8?B?WlljS3dHR3U0NUNPMUxwUXVBUHhiTEJsOUw3WE9TaVQwUGhRM0RtUUtWVHhl?=
 =?utf-8?B?QVlCV2o5MUw0ZFZQc1E5T09Vb1ZUNk0yRXNZZjRvNytRaEdwUkJpSy8rb1A4?=
 =?utf-8?B?QlE4RjhCRHEwTFdNYy9SVnlseDhWc3lVYTlNUlFqbVQxbFBpU1RLRTRYQVN5?=
 =?utf-8?B?T2lQaEJJRG45QU1CclNzVE5RR3VkdGxlcVRnMHpZSDArNU9PUmNESEgyZ1Yx?=
 =?utf-8?B?b1d1ZmUwOE5kVlZsaGMxeHlTOHIyWlRmM1BpUnFqNUZVMUNQdktHWXl2R1Q1?=
 =?utf-8?B?ZXo1OUt5NHpQMW4vWnhJUG80bXg5SExFNVBTR0tVQWV6MEl1U3BnU2pZVmxQ?=
 =?utf-8?B?TjdLc2VEcDFuZ3ZQbDNKa1U2RWFXZEsyeTZHcGk5SjQzNmIrM1hOMkJFZ0NM?=
 =?utf-8?B?aEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0BE8B64FE92EE54781703A5FBFA7F262@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b716ed-c693-48e3-9dd0-08d9fb2fe9a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 03:02:25.0819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TLdr+jRnRhZfQQUZ6RlHj9S8fvxKqzQDpK6IfLwkdS6Q7jblmAu++bzwYIz0/X9XqJz8cjpILnHIsHoQ0CG/ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5986
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2VzbGV5IENoZW5nIHdyb3RlOg0KPiBIaSBUaGluaCwNCj4gDQo+IE9uIDIvMjgvMjAyMiA1OjA5
IFBNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+PiBIaSBXZXNsZXksDQo+Pg0KDQo8c25pcD4NCg0K
Pj4NCj4+IFsgMjE4MS40ODE5NTY4NjUgICAgICAgMHg5ZGM2M2YyNjVdICAgZGJnX2NvbXBsZXRl
OiBlcDZpbjogdHJiIGZmZmZmZmMwMWU3ZjUyYTAgKEU0MzpENDMpIGJ1ZiAwMDAwMDAwMGViYWYw
MDAwIHNpemUgMXggMCBjdHJsIDAwMDAwODEwIChobGNzOnNDOm5vcm1hbCkNCj4+IFsgMjE4MS40
ODIwNDQ3MzAgICAgICAgMHg5ZGM2M2Y4ZmNdICAgZGJnX2dhZGdldF9naXZlYmFjazogZXA2aW46
IHJlcSBmZmZmZmY4ODYwNjU3NTAwIGxlbmd0aCA4LzggenNJID09PiAwDQo+PiBbIDIxODEuNDgy
MjIyNDkwICAgICAgIDB4OWRjNjQwNjUxXSAgIGV2ZW50ICgwMDAwYzA0MCk6IGVwMG91dDogVHJh
bnNmZXIgQ29tcGxldGUgKHNJTCkgW1NldHVwIFBoYXNlXQ0KPj4gWyAyMTgxLjQ4MjI3MzI3MSAg
ICAgICAweDlkYzY0MGEyMF0gICBkYmdfdHJhY2VfbG9nX2N0cmw6IEdldCBJbnRlcmZhY2UgU3Rh
dHVzKEludGYgPSA0LCBMZW5ndGggPSAyMCkNCj4+IFsgMjE4MS40ODIzMzQ3ODIgICAgICAgMHg5
ZGM2NDBlYmNdICAgZGJnX2VwX3F1ZXVlOiBlcDZpbjogcmVxIGZmZmZmZjg4NjA2NTc1MDAgbGVu
Z3RoIDAvOCB6c0kgPT0+IC0xMTUNCj4+IFsgMjE4MS40ODIzNTczODYgICAgICAgMHg5ZGM2NDEw
NmVdICAgZGJnX3ByZXBhcmU6IGVwNmluOiB0cmIgZmZmZmZmYzAxZTdmNTJiMCAoRTQ0OkQ0Mykg
YnVmIDAwMDAwMDAwZWE1NzgwMDAgc2l6ZSAxeCA4IGN0cmwgMDAwMDA4MTEgKEhsY3M6c0M6bm9y
bWFsKQ0KPj4gWyAyMTgxLjQ4MjM5MTg2NSAgICAgICAweDlkYzY0MTMwNF0gICBkYmdfc2VuZF9l
cF9jbWQ6IGVwNmluOiBjbWQgJ1VwZGF0ZSBUcmFuc2ZlcicgW2QwMDA3XSBwYXJhbXMgMDAwMDAw
MDAgMDAwMDAwMDAgMDAwMDAwMDAgLS0+IHN0YXR1czogU3VjY2Vzc2Z1bA0KPj4gWyAyMTgxLjQ4
MjQ4NTYxNSAgICAgICAweDlkYzY0MWEwZF0gICBkYmdfc2VuZF9lcF9jbWQ6IGVwMG91dDogY21k
ICdTdGFydCBUcmFuc2ZlcicgWzQwNl0gcGFyYW1zIDAwMDAwMDAwIGVmZmZhMDAwIDAwMDAwMDAw
IC0tPiBzdGF0dXM6IFN1Y2Nlc3NmdWwNCj4+IFsgMjE4MS40ODI1NjUzMDMgICAgICAgMHg5ZGM2
NDIwMDZdICAgZXZlbnQgKDAwMDAxMGMwKTogZXAwb3V0OiBUcmFuc2ZlciBOb3QgUmVhZHkgWzBd
IChOb3QgQWN0aXZlKSBbRGF0YSBQaGFzZV0NCj4+IFsgMjE4MS40ODI3MTk0MTcgICAgICAgMHg5
ZGM2NDJiOTZdICAgZXZlbnQgKDAwMDAyMDQwKTogZXAwb3V0OiBUcmFuc2ZlciBDb21wbGV0ZSAo
U2lsKSBbRGF0YSBQaGFzZV0NCj4+IFsgMjE4MS40ODI4MTQ5MzggICAgICAgMHg5ZGM2NDMyYzBd
ICAgZGJnX2dhZGdldF9naXZlYmFjazogZXAwb3V0OiByZXEgZmZmZmZmODdkZjg0ZDkwMCBsZW5n
dGggMjAvMjAgenNJID09PiAwDQo+PiBbIDIxODEuNDgyOTI2MDg0ICAgICAgIDB4OWRjNjQzYjE2
XSAgIGV2ZW50ICgwMDAwMjBjMik6IGVwMGluOiBUcmFuc2ZlciBOb3QgUmVhZHkgWzBdIChOb3Qg
QWN0aXZlKSBbU3RhdHVzIFBoYXNlXQ0KPj4gWyAyMTgxLjQ4MzAyNDI2MSAgICAgICAweDlkYzY0
NDI3Ml0gICBkYmdfc2VuZF9lcF9jbWQ6IGVwMGluOiBjbWQgJ1N0YXJ0IFRyYW5zZmVyJyBbNDA2
XSBwYXJhbXMgMDAwMDAwMDAgZWZmZmEwMDAgMDAwMDAwMDAgLS0+IHN0YXR1czogU3VjY2Vzc2Z1
bA0KPj4NCj4+IFRoZSBjb250cm9sIHN0YXR1cyBpc24ndCBjb21wbGV0ZWQgaGVyZS4NCj4+DQo+
PiBbIDIxODEuNDgzMDY5NTIxICAgICAgIDB4OWRjNjQ0NWQ3XSAgIGRiZ19lcF9kZXF1ZXVlOiBl
cDJpbjogcmVxIGZmZmZmZjg3OWY1YThiMDAgbGVuZ3RoIDAvNjM2ODAgenNJID09PiAtMTE1DQo+
PiBbIDIxODEuNDk2MDY4NzkyICAgICAgIDB4OWRjNjgxNGM5XSAgIGRiZ19zZW5kX2VwX2NtZDog
ZXAyaW46IGNtZCAnRW5kIFRyYW5zZmVyJyBbNTBkMDhdIHBhcmFtcyAwMDAwMDAwMCAwMDAwMDAw
MCAwMDAwMDAwMCAtLT4gc3RhdHVzOiBUaW1lZCBPdXQNCj4+DQo+PiBCdXQgdGhlIGRlcXVldWUg
bWF5IGNvbWUgd2hlbiBob3N0IGFscmVhZHkgc2VudCBhIG5ldyBTZXR1cCBwYWNrZXQuDQo+PiBU
aGUgZXAwb3V0IGhhc24ndCBzdGFydGVkIHlldCBhdCB0aGUgcG9pbnQuDQo+Pg0KPj4gRHVlIHRv
IHZhcmlvdXMgc3lzdGVtIGxhdGVuY3ksIEkgY2FuIHNlZSB0aGF0IHRoaXMgY2FuIGhhcHBlbiB3
aGVuDQo+PiB0aGUgZHdjMyBkcml2ZXIgaGFzbid0IHJlY2VpdmVkIHRoZSBpbnRlcnJ1cHQgbm90
aWZpZWQgdGhlIHN0YXR1cyBzdGFnZQ0KPj4gZXZlbnQgeWV0Lg0KPj4NCj4+IElmIHRoYXQncyB0
aGUgY2FzZSwgdGhlIGhvc3QgbWF5IGhhdmUgYWxyZWFkeSBzZW50IHRoZSBTZXR1cCBwYWNrZXQN
Cj4+IGF0IHRoaXMgcG9pbnQuIFNvIHRoZSBFbmQgVHJhbnNmZXIgbWF5IGdldCBzdHVjayBpZiB0
aGUgU2V0dXAgcGFja2V0DQo+PiBpc24ndCBETUEgb3V0IHlldC4NCj4+DQo+PiBDYW4geW91IHRy
eSB0aGUgY2hhbmdlIGJlbG93IHRvIHNlZSBpZiBpdCByZXNvbHZlcyB0aGUgaXNzdWU/DQo+IFRo
YW5rcywgVGhpbmguICBTdXJlIEknbGwgZ2l2ZSBpdCBhIHRyeSB3aXRoIHRoaXMgY2hhbmdlLiAg
VGhpcyBpcyB2ZXJ5DQo+IHNpbWlsYXIgdG8gdGhlIGNoYW5nZSBwcm9wb3NlZCBoZXJlIGFzIHdl
bGw6DQo+IA0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGludXgtdXNiLzIwMjIwMjE2MDAwODM1LjI1NDAwLTMtcXVpY193Y2hlbmdAcXVpY2lu
Yy5jb20vX187ISFBNEYyUjlHX3BnIUtsZ1NwTkVMT1hReWRJUXVhckEzQTROSlhJY3ZIc2xYcXpP
ZEJ3WXFVSVI5N01xZHA4emR5ZXpoT0M5RUo2VXF4THhNJCANCj4gDQoNCk5vdCBzdXJlIGlmIHRo
aXMgY29tcGxldGVseSByZXNvbHZlcyB0aGUgaXNzdWUgaGVyZS4gVGhlIGNoYW5nZSBzZWVtcyB0
bw0KaXNzdWUgdGhlIEVuZCBUcmFuc2ZlciBjb21tYW5kIGJlZm9yZSBTdGFydCBUcmFuc2ZlciBm
b3IgdGhlIG5leHQgU2V0dXANCnN0YWdlIGNvbXBsZXRlcy4gQWxzbyBpdCdzIG1pc3Npbmcgc29t
ZSBjaGVja3MgZm9yIGFzeW5jIGNhbGxzIHRvIHRoZQ0KZW5kcG9pbnQgdGhhdCdzIHBlbmRpbmcg
ZGVxdWV1ZS4gQWxzbywgd2UgbWF5IG5vdCBuZWVkIHRvIHdhaXQgZm9yIEVuZA0KVHJhbnNmZXIg
Y29tbWFuZCB0byB0aW1lIG91dCBpZiB3ZSBrbm93IHRoZSBjb25kaXRpb24gdG8gYXZvaWQuDQoN
Cj4gT25lIHRoaW5nIHRvIG1lbnRpb24gaXMgdGhhdCwgSSdtIG5vdCBzdXJlIGhvdyBkZXBlbmRh
YmxlIGNoZWNraW5nIHNvbGV5DQo+IHRoZSBlcDBzdGF0ZSB3b3VsZCBiZS4gIEkndmUgc2VlbiBz
b21lIHNjZW5hcmlvcyB3aGVyZSB3ZSdkIHJ1biBpbnRvIHRoZQ0KPiBlbmQgdHJhbnNmZXIgdGlt
ZW91dCBkdXJpbmcgdGhlIHRpbWUgYmV0d2VlbiBpbnNwZWN0aW5nIHRoZSBTRVRVUCBwYWNrZXQN
Cj4gKGR3YzNfZXAwX2luc3BlY3Rfc2V0dXAoKSkgYW5kIHdoZW4gdGhlIGRhdGEgcGhhc2UgaXMg
cXVldWVkLiAgVGhlDQo+IHRpbWluZyBvZiB0aGUgZGF0YSBwaGFzZSBjYW4gcG90ZW50aWFsbHkg
ZGlmZmVyIGlmIGl0IGlzIGEgdmVuZG9yDQo+IHNwZWNpZmljIGNvbnRyb2wgcmVxdWVzdC4NCg0K
VGhpcyB0aW1lb3V0IHNob3VsZCBvbmx5IGFwcGx5IHRvIFNldHVwIHBhY2tldCBhbmQgU2V0dXAg
c3RhZ2UuIEV2ZW4gaWYNCml0J3MgdmVuZG9yIHNwZWNpZmljIGNvbnRyb2wgcmVxdWVzdCwgaXQg
c2hvdWxkIGJlIGZpbmUuIEhvc3Qgc2hvdWxkIG5vdA0KaXNzdWUgYSBTZXR1cCBwYWNrZXQgdW50
aWwgaXQgcmVjZWl2ZXMgYSBzdGF0dXMgc3RhZ2UgKHVubGVzcyB0aGVyZSdzIGENCmRpc2Nvbm5l
Y3QgaW4gdGhlIG1pZGRsZSBvZiBhIGNvbnRyb2wgdHJhbnNmZXIsIGJ1dCB0aGF0J3MgYSBkaWZm
ZXJlbnQNCmlzc3VlKS4NCg0KSWYgeW91IGRvIHNlZSBhIHByb2JsZW0uIFdlIGNhbiB0YWtlIGEg
bG9vayBmdXJ0aGVyLg0KDQo+IA0KPiBUaGlzIGlzIHdoYXQgbGVkIG1lIHRvIHRyeSB3LyBtYXJr
aW5nIHRoZSBlbmR4ZmVyIGRlbGF5IGFmdGVyIGdldHRpbmcgYQ0KPiB0aW1lZCBvdXQgc2NlbmFy
aW8uICBKdXN0IHNvbWV0aGluZyB0byBjb25zaWRlciA6KS4gIEknbGwgbGV0IHlvdSBrbm93DQo+
IGhvdyBpdCBnb2VzISAgVGhhbmtzIGFnYWluLg0KPiANCj4gVGhhbmtzDQo+IFdlc2xleSBDaGVu
Zw0KPiANCj4+IENvZGUgaXMgbm90IHRlc3RlZC4gTGV0IG1lIGtub3cgaWYgdGhlIGxvZ2ljIG1h
a2VzIHNlbnNlLiBUaGUgY2hhbmdlIGlzDQo+PiB0byBkZWxheSBFbmQgVHJhbnNmZXIgd2hlbiB0
aGUgU3RhcnQgVHJhbnNmZXIgZm9yIGVwMG91dCBpcyBjb21wbGV0ZWQuDQo+Pg0KDQpUaGFua3Ms
DQpUaGluaA0K
