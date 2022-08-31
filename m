Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8435A78E4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiHaIVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiHaIU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:20:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF6DB7EA;
        Wed, 31 Aug 2022 01:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661933995; x=1693469995;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LjOfUa+KQI0s6AcJORI3Lt/f7gykd+q1ahIcrLHY9Go=;
  b=UcBFESj88A59oRpSxFrupSbUQMEd5ENwVx9TycCIFbTyda1mzNjsP+Eu
   fMz6i+sXoKf0SKvOHtgwrbGRb+286fTd/D5NRDFyyxXUMF8cRyHTdQ+O9
   ElqY+W6BOQHZaqhRVE38/fkMie2TQBMtXjA5F74mBy09/6JnKJNdD3qo8
   NtUfrxVgxUeOtBqsMVsU/A7ylNkchva2yFEf17LYgm4e9Wc/S3104xM9N
   i7UJMyJL6q2LqzORN52KkZgPT62DQdV+UZ71tQ0FhJQfNZ7IRhUCQUopY
   gH728868/1Be0k547y3pfp/6G3Ue1RDEX5Rky0nkV/GvAcNefqAfi8LZL
   A==;
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="111529531"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Aug 2022 01:19:01 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 31 Aug 2022 01:19:01 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 31 Aug 2022 01:19:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkesG3NhkPui+2mGh8+7pWFSACKhkcbJtis9y6OHW9MGbdEzwGB07OYaHpIjRXLa86oEJXYJ81dhySH6biCkJc7LrGu11u6Vwknnk0q9uoZGcz4sVwgzW0P5xj+EH2sYrqP87zVxkVHdqyY22IXKLdtzUqt4hyucupyEF5d81ixcUYH1Zzn8xfmhSTIK+RaxG+i+O5lntFGYdxDulqbH+W2NTLxyP9lxK1S4dYd97Pu+VwT8rl0IZkPGU1keqqiTkFT4iV98wAiE3FO8OZolBMx/rAwf7JwDp9LnMRyiwPejldYlG6RdaSjJJkPCRmYTqD2nDD2olo8C1sPfRkIsag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjOfUa+KQI0s6AcJORI3Lt/f7gykd+q1ahIcrLHY9Go=;
 b=Q3N4VRs2EItlfW0Em2VHFNR6XdjGzDn7UeQB39uiDEfrHzjbuDayrdJRLpbCuKYsfs6CFyvoJKzgyeXEZ9utMVO4FhaAs8J1alpGbCv/B2qGq2IiMkXbEirq/Qq9XANE3ANjTPw4NIpXTtg3fTpm8kTtKPuReQBUfMKTmhyA1i5+A/5589FR4edaPcWUNlUgt5ZU6ma/YKSBrAtV7YpS4mwkdskx3MsbJiQ1LQ7627I2uX9luHANtGokeuy3wVrhoEoBaKRooD+6yUf+Fj3AjnV/FfibWMN6xiENkPAD/TGRiK6NZB7bPzcf4K/jPYrem5KlMME2FZ8QdAB/78FaqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjOfUa+KQI0s6AcJORI3Lt/f7gykd+q1ahIcrLHY9Go=;
 b=popmloN4jrnPBjnnT1o190QvXLcukJvjLl1HmVqZ9ymmOydN+/2+Cy5zdfVqRRwKjoesF8G7Xr7Y1Cx24vMz9Yi5Yqd21ElRVMAp+JH5fA0rIuPvcQZVt7SLCFITz3dR4MgHazLq270QDcsAra/JsllQ0pXXrEYpjsRCHR6qm4o=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BYAPR11MB2677.namprd11.prod.outlook.com (2603:10b6:a02:cd::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Wed, 31 Aug
 2022 08:18:50 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 08:18:50 +0000
From:   <Conor.Dooley@microchip.com>
To:     <yuanjilin@cdjrlc.com>
CC:     <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tsbogend@alpha.franken.de>
Subject: Re: [PATCH] mips: fix repeated words in comments
Thread-Topic: [PATCH] mips: fix repeated words in comments
Thread-Index: AQHYvQTU5ceJ09vsw0qOCNBPcuici63IqnuA
Date:   Wed, 31 Aug 2022 08:18:50 +0000
Message-ID: <2b32517b-fe5f-f480-664f-9896a901cda8@microchip.com>
References: <20220831064151.22233-1-yuanjilin@cdjrlc.com>
In-Reply-To: <20220831064151.22233-1-yuanjilin@cdjrlc.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 671be633-34af-4a6e-cd56-08da8b296f3b
x-ms-traffictypediagnostic: BYAPR11MB2677:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cOYoq8b+l+aASfpgKR0DqAEqzMHBe4jWPQsV4qRVdSufZNzcArm3WnYej5dTLN1EICT3bSu0PGwIGf4usbtGhAGykSizYT+JNBHlt+4JB2c11QKv7lDvWyoHtggxAQ93p89TUF2yc1qkQm2yZpz/0kRkkOuBsjYC6YOBMiXwVhvB8X6CMlDEdySU+RbHeEbBZOe0I0hPI77VLHqtmpQ4zzpLnQeymUzhYG4MlF7Cw1cpgV4YsLSqhQtfJdPBj8TqiifsWWW+OpbwkKNGe1IP+aRQZB518KjOpvkFrC6cHZSn6YH6VPwtMHATANKsM25pJL4D+GhljO3qslx+KzjpUhd7lUyZxh3gw63q5olTRZ23bH7UcxurXyc0kqYKCQXZLi2phbj+ruzVen7k6hGGKzL2xYgCFLJaCw3CI/RQPSDtEwNBlugJzCJTGeQku74zZw8s5f61ImIZUikV9wTlz511gpVFq6SdCvKfyd71dlGcu34LK+AYfz6BBXxu4I7hA0WPOknQm50+3I2/POzE6wACmngoacCHwONHIh97MFyTcwP/CsAQWQ8Z7fzUl1Qp2xUIkBhIa9abp3yDEmAZ4q91OXB0Z3p3HhqybYwp3/agt8X/t4nQgJKJ7ZgcWTGxkDbL4EUjQ7bPrnBXbXgsehG/bGKdL9x8Ca+tTT6kQpAqe9mIzeQD9TxU6no/kZ+81gbtFR5r9OQlNPpxWPrDPT05gXJtDTCZ6bChdIuZHeYNuZghZBXnwn0cNV/xbjzg/KQOj2VSl86C2TweSIKk6C54CGy+gorc2qRZVvqivDBX9oXs85jTn70HoZX50WWpVW9sAE3BifvDAUWC5XtVvkR8GKC1h4VczyePHNIO0Ps9rMWEXr9rsGTmU9F+ciH69OHJP2s9ImhGHmAWGevt0KKG8tsgudkLoT71IaV9S3g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(39860400002)(136003)(346002)(396003)(6506007)(53546011)(26005)(71200400001)(83380400001)(966005)(6486002)(478600001)(186003)(41300700001)(54906003)(6916009)(2616005)(2906002)(66476007)(8936002)(5660300002)(316002)(6512007)(64756008)(4326008)(66446008)(66946007)(66556008)(76116006)(8676002)(91956017)(38070700005)(86362001)(31696002)(36756003)(122000001)(31686004)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3NFT0VvL3dNMDNpekNhZnhWQlV1ZnAzSmZkMk1ieDE1TTRyaUh5Ri8wQUNJ?=
 =?utf-8?B?eEQ5NzhyWVppbDFwUlM4YkxMZVc5SlBXYTYzVzFNU3pqT3FEU3oxQnhwSDgx?=
 =?utf-8?B?QTcvNHhETnVPWERGUUNvU25vejA4Y1plRHZwcWx2RFZlVHFUWmpFSUJraDBp?=
 =?utf-8?B?QU5XVDFwUzhWSUFTQWxRSXNNZURzeE1hMTk2RUVTLzZiN0tEL216TnBvc3pQ?=
 =?utf-8?B?SnVtOGFENVErcUdpak01aFZMUFRXMFM2UWxZUDFjeXhqb2tBSFlUNkNBK1Qw?=
 =?utf-8?B?V0YwUFJmNGlSUUJvOEl2T1FpZ0dTQzhBZG9TandNbCs1NnRsbW9kcXFwdTFl?=
 =?utf-8?B?YTJDVHhYWEpxdWRkWmVrUGRldmhOTDNLUmRJT0lHQWd4ZXVSYUJyQVUvUmJK?=
 =?utf-8?B?MGVXT1k5aVdaVVRPVENzRCt1MUo3dW96YzJSa0oyMys1M1RFMlV4ZGVYWWh5?=
 =?utf-8?B?eDNTaXZRWVpjbjlVZU9KSVN5Z3UzdDdUc1VtTGxEdzYxakRlNXN3M2hveDNS?=
 =?utf-8?B?ZXg1bzZIakJrZ2NQcnFxNVBySkVJbnNKUlY1ZUJ2NFhJb1ZLRnJmSmRyUThp?=
 =?utf-8?B?MWlNWUlEVFl5YXptWjFEQ3c2bS9DN1E5OTU4ZHpIYytpSFJIOXVNWEdBbm1U?=
 =?utf-8?B?TldyYmxuUGtjcHVLRllkeXdpdDdVYUFvWTNHTHFMbWQxTG5XY0ErZk5LcXdp?=
 =?utf-8?B?Nm9BbUsyNWIyVk5DdnZoYlJxc2s0ZHhxTjdWWnhtSSt6NWltcHA2a2d6WjZZ?=
 =?utf-8?B?SGhoWGpjMXlsNXcyVE9MbEtueCtWVys2Y2NQQVVZODNCL2JVVk1iRzdSMVRu?=
 =?utf-8?B?WTFTcGhUYVdxaU4wVEtOcWNlcGlrQ1dseTNpeUM0NHF3cXJKSHNId3VBSUNt?=
 =?utf-8?B?ZWJPaEw2Wm1oRGt5bytTQUN6UHZvdDlkbHVaYlZmbThJZHZxSVVnWFEyWFVn?=
 =?utf-8?B?N2ovUUEzOTF5MHBIRWFTNTRaTlFOcGNxblJnekFBMnd0eDJlQVJlYkErNys4?=
 =?utf-8?B?UVpPZWpKRE96SlJ4MHNIU3IvaDQ1M2VVSm1MMmpkNGI5RHlLZkJXMjQ2Y1JF?=
 =?utf-8?B?b0J2Tkg1SE1JMmtadHFGTm1qWWRKUWpNQkZlY09Ub05GRFdlbjNFNngreVAz?=
 =?utf-8?B?MkQ5ajgxSWhrRHBROXFBa0JxSmhiMndjQ1V4eFVuY1FhbDhVSjdxdkZ5ZzVC?=
 =?utf-8?B?bTlHQ25nZFAzblMvUHR4RTd3eEl1cUFucmNLUCtIazdwT1psWkVyK2g1eUdL?=
 =?utf-8?B?VHV4RjlKWFdwWWZFZTBzNjBNOFhnR3dUaFlNNG9tc01kWW9DbmhldHMvQ0Rm?=
 =?utf-8?B?MjlZaGE0TUhXbnpmZEN2ZFhGZDBJNllpaXRtRGxlR0Jxam5nZ2VFK00zWUlG?=
 =?utf-8?B?Zkx6SDNvK3p0M0F3NlRab3FURUhVdjBIYkRSOHZFMEpGbjFvRGhiVUg3ckpK?=
 =?utf-8?B?dUk5ZXc2Z2UwdmdyVkZoRkJEbDk2ZkE3YldBNmVic1p5VTdNcm55OWpXWFpq?=
 =?utf-8?B?blhiR0JJNTAyYlZFU082NGRKbzdSRGl5OG96Wk1LbkxPcjBVREh3RTNmWWZB?=
 =?utf-8?B?NTVKZko2NTNUc2tsNXllUm9xWDR4b0xHZzl5SzFZSW83THpSSFFqb2JnMEVy?=
 =?utf-8?B?Y3ZDUm1MeDhyaUpTckVCakpHZWQ0MGt1NFJRZTVCVDJGQzFHK2d2bURabjMw?=
 =?utf-8?B?a3c2eGRCUHA1NVFKVHRtZ2U3bStBUTdYajVsbW5Hd3RDVlkra3JKU1EzNGN2?=
 =?utf-8?B?SGl3dDZYeWVnbmt5UkNNZkhlQzc3LzhCYzNISnB2ZW5Oa3FveSs4ak9peVpC?=
 =?utf-8?B?T0ZMM0VJOVQvak5SZTU2M3JlNzVGc3lMNEplVVUxbDBrSktEZGZnVWN1TXlO?=
 =?utf-8?B?R2pkZWV3WlRSbW8wd0JyanZ1Z2VjbVljV2RHTmNEYm5FWVQybm84ekJSeElG?=
 =?utf-8?B?VjVaRkI3TWptUHRGcnVDSkZBc0lJc1JXMW12dnh4UG1xMW5kWlRCSkFSS3Fw?=
 =?utf-8?B?SWt2V2lrbXNEVkN1UStvRFhtdkRRZzJYQzQxbW1nYU9Ub2QzZmhvTnZXZFNO?=
 =?utf-8?B?ai9BdkJsZ1V1WExLaUhGZmRmRGFMUEp5SG16NUhva053U2RnMmxsZ0JuNTc1?=
 =?utf-8?Q?/mghKpQgpTJmaq7minzSvwoCo?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A6A3DCDD00B7345BA9EC97430623639@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 671be633-34af-4a6e-cd56-08da8b296f3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 08:18:50.1832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o6RgOc3TY2hN0ZwvNfpQaEPDdNZkS8eRadYpRLkhgWU3jUZvCmBSrVt2KivZujHaLRAqrTqwQoNfaAiJvhhf6OyZZcHK87+ObiujUSAV4JI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2677
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzEvMDgvMjAyMiAwNzo0MSwgSmlsaW4gWXVhbiB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBEZWxldGUgdGhlIHJlZHVuZGFudCB3b3JkICdvZicu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKaWxpbiBZdWFuIDx5dWFuamlsaW5AY2RqcmxjLmNvbT4N
Cj4gLS0tDQo+ICAgYXJjaC9taXBzL3NnaS1pcDIyL2lwMjItZ2lvLmMgfCAyICstDQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvYXJjaC9taXBzL3NnaS1pcDIyL2lwMjItZ2lvLmMgYi9hcmNoL21pcHMvc2dpLWlwMjIv
aXAyMi1naW8uYw0KPiBpbmRleCA4Njg2ZThjMWM0ZTUuLmI4ZTk0NGI4MWE5MiAxMDA2NDQNCj4g
LS0tIGEvYXJjaC9taXBzL3NnaS1pcDIyL2lwMjItZ2lvLmMNCj4gKysrIGIvYXJjaC9taXBzL3Nn
aS1pcDIyL2lwMjItZ2lvLmMNCj4gQEAgLTQxLDcgKzQxLDcgQEAgc3RhdGljIHN0cnVjdCBkZXZp
Y2UgZ2lvX2J1cyA9IHsNCj4gICAvKioNCj4gICAgKiBnaW9fbWF0Y2hfZGV2aWNlIC0gVGVsbCBp
ZiBhbiBvZl9kZXZpY2Ugc3RydWN0dXJlIGhhcyBhIG1hdGNoaW5nDQo+ICAgICogZ2lvX21hdGNo
IHN0cnVjdHVyZQ0KPiAtICogQGlkczogYXJyYXkgb2Ygb2YgZGV2aWNlIG1hdGNoIHN0cnVjdHVy
ZXMgdG8gc2VhcmNoIGluDQo+ICsgKiBAaWRzOiBhcnJheSBvZiBkZXZpY2UgbWF0Y2ggc3RydWN0
dXJlcyB0byBzZWFyY2ggaW4NCg0KWW91J3ZlIHRyaWVkIHRvICJmaXgiIHRoaXMgc2V2ZXJhbCB0
aW1lcyAmIGVhY2ggdGltZSBSb2IgaGFzIGdpdmVuDQp5b3UgZmVlZGJhY2s6DQpodHRwczovL2xv
cmUua2VybmVsLm9yZy9hbGwvMjAyMjA2MjcxNzM4MjUuR0EyNjM3NTkwLXJvYmhAa2VybmVsLm9y
Zy8NCg0KPiAgICAqIEBkZXY6IHRoZSBvZiBkZXZpY2Ugc3RydWN0dXJlIHRvIG1hdGNoIGFnYWlu
c3QNCj4gICAgKg0KPiAgICAqIFVzZWQgYnkgYSBkcml2ZXIgdG8gY2hlY2sgd2hldGhlciBhbiBv
Zl9kZXZpY2UgcHJlc2VudCBpbiB0aGUNCj4gLS0NCj4gMi4zNi4xDQo+IA0KDQo=
