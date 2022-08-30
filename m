Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D6F5A63D5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiH3Msr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiH3Msk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:48:40 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD9DFE05E;
        Tue, 30 Aug 2022 05:48:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAcH1J5qD9UZmFH1cNPCJJT/Fo6ClW7T18LBdrW2ewj8CoX8uSWTvx8az5WI4AoBC5NxIpLZAQCgvgs/xN/LEdhKeCYvtOegtiQyzSW6sAGK2wFw8suwedUkQkOGKrg3QO5kszv5AGnQRkDiFImNJq2ggDffyBWpiWbOfToss+R2GFzVwU9exZZV3f+El2l7bYbZEYFhMKlb4pdH0NGMmX9ElyL+w8RZroi8cDsEicRLmCfO9xQuBCo2hep5fHExg76WZZwVLwaiEiVdlHxajxjE1zNehMnW1YLJ3setg2IJ9LCAtV9VXaxVgA11MX3yoPGkYHWgi9lX1RiHD+YYmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRHYl3FCiGZ/nJ3B5m5IHs6RmqSKba+o+T0W5CXS05M=;
 b=MeyOijiFTwX8UjupBceEbL/ARCN3SXyB0+5EIJDExPwEHEDj3jkkOAwjdPMQajzLVbTlwSRarjVs0EbvrP41ECD1ddtMdExVi9d5A7/j9q+ZjU7KhTFPiplYVcR92De852zmEE4Vl6oBUjFTFkKWjrwGj64PYMgYWWjcXWA1JHZWLUvqUITr4s+8ozl+ZB2K7xtCJZytA/Q8niTsR1Ff6DB6/HqFNP+Eti1Drp0yU2BeXi3max/Ci9XTJyTBedgPzc7pP6LftqdILj4yb/OaTxmd6ykvC+UlWdVTCAuLoNivbFzq3Ds/gcE7RC4Z0zyYftPqGSRC2+EnZ2v+Du+Syg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRHYl3FCiGZ/nJ3B5m5IHs6RmqSKba+o+T0W5CXS05M=;
 b=Ljz7HEqiBgeakYdb2GUsy9Egw5NAYTKKBeCnSr5/pcJbtUZb8zhgHEC053YpSqdZVdet0i6EWtGDj2wxJl2nRnwYPWrlE+j7Jg0Wj4kpJziW0ExJQKklEn6AKK5UvIdwT8tXe2Z9j2kUI4R0ke1AeeNnaV8Jl4oLF8Y4AmoXe0HrvnFDleY30izf4m7IAnO0S7YsYKOWOoQJU7F5Z8MQ5c/Mt0R9DbzaJoBmsj22kM8QR2Ax4lDn71cs13+ooIAxTl1M+ftDckKeqm7SVVj5Urz02a8LHZGN5JOWNAUeA1d1NjzhkWoTs8VYlMEbo3fiIuENwQfxYgQxfyOyutzV9Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB3484.namprd12.prod.outlook.com (2603:10b6:5:3c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Tue, 30 Aug
 2022 12:48:37 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c04:1bde:6484:efd2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c04:1bde:6484:efd2%4]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 12:48:37 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Liu Song <liusong@linux.alibaba.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] blk-mq: change bio_set_ioprio to inline
Thread-Topic: [RFC PATCH] blk-mq: change bio_set_ioprio to inline
Thread-Index: AQHYvFVmbV5C9Yy0F0eJcTiVWsB5Wq3HZPgA
Date:   Tue, 30 Aug 2022 12:48:37 +0000
Message-ID: <0001ab1d-b4c0-2ac1-f902-c61216204aef@nvidia.com>
References: <1661852746-117244-1-git-send-email-liusong@linux.alibaba.com>
In-Reply-To: <1661852746-117244-1-git-send-email-liusong@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47d7cf6d-efbb-4861-946c-08da8a85f51a
x-ms-traffictypediagnostic: DM6PR12MB3484:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yc2R/mCx7kUIswlSkqbxDAz7yVy+b7oC9QZ6Sm7mLpZOFztHdQgb+ciBKo6tpyFYalZ9IihSkYnZ4eXsl1csuuc0i8tTcpExoe6+zJyMSUjLkqH47y3t0LTaX0n9Z7/hgqa3hQz2qp6RbzLUs6rFH9hE+0OMECLjNJNkrPLx8C/qwEEdgt9esIUnlIfwaByEC6+W+vxEHbwRpFeejYOUkTbYOOB1+zBS2t2WPnLzkKTXLRvxmT+FSnzLHBckMrRkMus2KKynFHujih22k9kExin6yb8nPcaJxGRiUNInT1c04hewsDtE0G91Cjw5YePnblGk7zbicxAawdws2AibkQwlDIPQazu91ltD+qhqdAXHw/aF9kLvNk50GZPXyqm/HVaPLYjHCpEIZPxjBhjfvdMnLZstkxvM2yhMdnEns8XMDCtB7z2kxAbZJGoraQfGSRSZkijelEsDE96sWd8VhgyVEvIwHevTgMJCP6uW+QB1olsW3voSd4ZJuMYdpF3jlR9UnFtrWjvDSM5irSU5BlnwT/nizu6QLRYIYsEZbxWPg9qe2ETwFHV0t2GEV9xHscCpqv7QkXbk8I5hAfVitMQ/cOS/s+xNaGgz1IsXUenEFOL56JgZpA9eP87k+sIR1eQum46NQuoUlnb8LSbmMuEk2sCDZmq1tUlat7wMjE3zFEldjMvnXOEcPwh1NetFP9/ynDCOULcFKHYAIyze+YzNJCheDygZ4JMy2LDMSNSEirx/CYwjTtAwmG8xtSAHbz/aBxMR/JMbP+Yl1KebqTnRZjjwuGwzxjWyRSfGp73fJhtECiK8fIjTswUdrJ1Qq3kMnTBO4SaEp95UmTdXew89YZuscheXFwxDIsxK4m2AG5gpQJGJCU6fntnvmdac
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(91956017)(66446008)(64756008)(8676002)(5660300002)(558084003)(4326008)(66476007)(76116006)(66556008)(2906002)(36756003)(53546011)(31686004)(8936002)(2616005)(71200400001)(186003)(66946007)(41300700001)(6486002)(478600001)(6512007)(6506007)(86362001)(38070700005)(31696002)(54906003)(316002)(122000001)(6916009)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlRVNlU5MlpZTjBhakdPYS9aM1hTWEJYdUsyNHBYSFY0QkpKVlBHcDZBL21p?=
 =?utf-8?B?NFc4UXQybGxGUWxzc2RjdVZ6T0ZxQUZXMVpBejJGbXg5VjNrRnZPSTBiRWNr?=
 =?utf-8?B?azFia1hrWmNiT3BJQlZIYUN6V1J1QTQ0QnRydnpEWDBwMnhGY09PQlpIdVBs?=
 =?utf-8?B?aVNOSm16RVEzb25acnpMbXZYS21zb2RlVTFwaE83YTRjNFgyTmxBWHZYaGNQ?=
 =?utf-8?B?S3J2OUp4QkU1UWR0UmlkeGdtTXJwdDlYWTIzNFZGM2RPc2FlamNDZThhWkZo?=
 =?utf-8?B?dE1BTThuaDFrYW52d3ZnemNEWmJZc3ZKRFBteHE1V1NGbVhLS3NYdmNUSnE2?=
 =?utf-8?B?a0lwSGdGdVpmMGNTN2ZhQkhOMXBHMEdITGh4L29DMEUvNFZGOEtnQmluSHBZ?=
 =?utf-8?B?aGNDaDJKV3Uxa0RjSHJiNUdlK3lvNHpiUXFGbkFHRVBudHpqVHJTNDRDRnZt?=
 =?utf-8?B?bklJeHVhN3M0RmRISlZ0TlpGZEVDVGdhVHh0a2EwdVpWcG9RR2R4dUlJaHFZ?=
 =?utf-8?B?MUd3M2V3MGY5WDJrbEVuNDd3WHFjaElsWGo0M2VTME15OWRVODUvdUZBa0Vh?=
 =?utf-8?B?TWRWMU91eWlTaWJ3aUNaT1ZSQkVVZmJSQVdmUGFOWGplVG9LMlFibmVMTkdU?=
 =?utf-8?B?aHRFOXAxK0lCQTlQblZESDdwQ3Y1RnZHdUNlbkhVaHQyMk4weTRyb1I1YVg3?=
 =?utf-8?B?Q2tyZy9GTHF3eVlDTmt4ZlVscXFVd0ZhdE0rejJxQmFyNkdPb3V1d2h4U2Ew?=
 =?utf-8?B?VFRwL1FFU2l4UmNlTVV2ZkIxS05JT2pTd0h4SXc1MnRGOG1xeVpvZTUwck1K?=
 =?utf-8?B?SkZOVVpldnhrWWRDUnRLQlMzaWdic1VuUzVhY09VcTdsNE5MSllHTjMxTnFH?=
 =?utf-8?B?RWptU0FnUk9QSis2NjljbVU0d1BDSGVEK25EVHZlQ0pEM0tKTlVyczhFUXVo?=
 =?utf-8?B?eTNTWTc3YVd5K1VMRGVZZWhxVEVpOHhrQUJtb2l6R2kxa3Jpa0QwbUtCZWpR?=
 =?utf-8?B?NENCdEt1cGpROWFtOFhHd2FYdXZUNnZLRzVDOEQ2MG4vUWk1aktXNXZHVk5s?=
 =?utf-8?B?cDlBN0liaU5NekNMc012TW1GSDRvNWdjN2I1Z0FtY3IrRmcwTXQwbXIzc2ZB?=
 =?utf-8?B?VlVIM0VtTE4zclFNSlA2SWFxVWhxZ1Z6WEtXbVoybTRmSEJJQjdHSUUwNWVu?=
 =?utf-8?B?cXBicEI1Smt4bExaT2gvZmNQSlpVS1VpSjFZVGZjQSswbUlyNGpKQ3hJdE90?=
 =?utf-8?B?cHpRZ29rWUFVVFFOZWY4cll6MWhiMzVBcUVMemc0NkRMUGsrdHJoYjFLZHZs?=
 =?utf-8?B?OEdXWTdZNStZQnFOTUZITjJQSFlpZWpwU28yaEZBSHB4bVYzblIwZkVDNWx6?=
 =?utf-8?B?T3RDRDFwSmlxbHA4Y2hXMDRNdjhqZXlGWWpjbkUwSmZzbUVSQklnMzFjZTZP?=
 =?utf-8?B?d01qZnlubnVzbHkzdXBQVEROYk8zUzNOQjRuenU4VldJY0FBNDFGUFVEamwv?=
 =?utf-8?B?TGtiVXF0TFhDWDFPd1M5ZHR1cnRlaVVZcFBXT3lwT2NPNWwxNUlqTlRLcmV3?=
 =?utf-8?B?MlhQbXU1aDVOLzgxUXlNQ0VKempybVp0NmkxVE9Id1E1MThzd3Z5d3M4Q2VH?=
 =?utf-8?B?U0FNb1l5aVF0Vkl5eXMvMnZ2OTJtOXh0ak1xWklpT1F0TXNtRHVpa0xhN2Uy?=
 =?utf-8?B?dHllR3pDWnFNN0UzZnNBSDJEcEV0bllMWFhPRU5RNWQrVHRhaTdvMHIySjZo?=
 =?utf-8?B?cERFS2krN0JmTzhLcythMUhCbnN4MndIQ0tYYUIwRFZSTXFYdkxkYks2b3hE?=
 =?utf-8?B?amE2b3RGNVE5N3h2WGYzWjl5SXFDMGZaTEZFZCtGUlEwZS9PYjFLdENKMlRV?=
 =?utf-8?B?UUVLR00xOWkrZHpNdzlvMUh5Y3VqbklLbHR1NFdTZ0w4TUJRUEV2c2RSS0ZG?=
 =?utf-8?B?SWpwVnUwWnRSQXBnUFN1ZFhVZyswYXQ4MDNtYklLM1JMc2E0N2hYZ1l1NUxK?=
 =?utf-8?B?VG1vZmJZbjhsZ2JqcHo2dWZXYUVFTTdUYmNtS01aY2lxZi9jbjNycHJMd291?=
 =?utf-8?B?eTR5VUYzb2F1c3VjNUx4bG1PR3c3dkVnZ1I4a0JuT0kxYmpyc3J3SUpZUlAv?=
 =?utf-8?B?MmFDUTE3UWRMcU5HQkk4NzlkWXFid2hlcXdoL0hNcTJpcWJzbytJQXFvWHla?=
 =?utf-8?B?dmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F3A1394719E0345A26FDB937A7192B0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d7cf6d-efbb-4861-946c-08da8a85f51a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 12:48:37.3321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a0E9kwCLWddTnj4n+VdRok07w3OHvUxXtMRg8Lih5m0UfhCDU6VS1yQbnxQSncQHf3kXGKRLQfMlHfoup9gtnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3484
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8zMC8yMiAwMjo0NSwgTGl1IFNvbmcgd3JvdGU6DQo+IEZyb206IExpdSBTb25nIDxsaXVz
b25nQGxpbnV4LmFsaWJhYmEuY29tPg0KPiANCj4gQ2hhbmdlICJiaW9fc2V0X2lvcHJpbyIgdG8g
aW5saW5lIHRvIGF2b2lkIGNhbGxpbmcgb3ZlcmhlYWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBM
aXUgU29uZyA8bGl1c29uZ0BsaW51eC5hbGliYWJhLmNvbT4NCg0KZm9yIHBlcmZvcm1hbmNlIG92
ZXJoZWFkIHBsZWFzZSBwcm92aWRlIHF1YW50aXRhdGl2ZSBkYXRhDQoNCi1jaw0KDQoNCg0K
