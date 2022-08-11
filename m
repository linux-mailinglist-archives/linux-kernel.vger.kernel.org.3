Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9B35906EA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 21:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbiHKTUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 15:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiHKTUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 15:20:17 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AA6639C
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 12:20:16 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27BGSwiE013479
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 12:20:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=SE6IJ1QFJUQGFxnz5DwaOYqUhPdVknC36EskuEt7trU=;
 b=PcY+fs45B+GXkxr9RPN+0NmfP3uTSEbgUVnfEiCNPFGrEl7+hbNOVYS3bT4wYcmzy/eC
 hKn3VDxWrYGMVqzKhmYoiYbMNF3aYfzGptkOk+QZZXDHlmiaQqLKdEhKjHvkHwk3bD34
 Z9+tUi4ntky9vxIOyF05MpBamKmxPmyKX9k= 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hvdbb4n56-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 12:20:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSEQ1Ki2htn8p3gNsVHb4nG64GMoZyylMYV5hT8Ja8D6eM3jdLlwiXYUYWoYVvJNvR9yJsOGaCheVMWzj3xHH9XwzQHI49BJZfcem/SI/MrdgwiWdnRZdaJg58nzYL2sZ3LGTXVWJ+gdVjylZ0CnWHGDFZRY8nNZaJOlvc1uhf7EPuYJBFMAa7Dq6WFJx1sFpvsbxOcHeh5GCSANuvVp24bX4dbqnHT+3K/cf0D6/2najV0JIxgKow/qH1i3jdNbruZEBXQ95fC1MXXUTddh5fINOnVA7oeZepyxGdaoqL72Qb6p6DO4nQhvXlKUnKfSJ5zXN+I76h/HZGzKTYE2NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SE6IJ1QFJUQGFxnz5DwaOYqUhPdVknC36EskuEt7trU=;
 b=D/Z2gZBFO8aasqeUO5cJWN+GJRJxwszsgfklooGa4G8iysm/MwCc93tt1FwSgNfAqj2S0AwdOeL9OQ+f1pwMhkzxk+XRrVscA8lFZQPXDF++jJyQ6dAQ9U1WGDFXpsItOqaIHPbfd168F8PqoGDLXpIaaLg1A9qpEcsI59ZObVYW7f+gr9eOy/agy6Sn6ydZTddsrGugvo6aZexLuVEV/O9hRSR5txCmaVSz5QnBTFgMonh0zq7bq2p5HBas4e7QHD0wbLgwENRjyuEvrEGQ4LBSywDDxZT57f5SIB1HQBe99oAxLyVxvYu9+zgCnGSe2APFnEU9ORJn2ulHYN4b5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from CY4PR15MB1781.namprd15.prod.outlook.com (2603:10b6:910:1f::13)
 by CY4PR15MB1223.namprd15.prod.outlook.com (2603:10b6:903:10a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 11 Aug
 2022 19:20:14 +0000
Received: from CY4PR15MB1781.namprd15.prod.outlook.com
 ([fe80::351d:e6bc:a9e4:4118]) by CY4PR15MB1781.namprd15.prod.outlook.com
 ([fe80::351d:e6bc:a9e4:4118%12]) with mapi id 15.20.5525.011; Thu, 11 Aug
 2022 19:20:13 +0000
From:   "Alex Zhu (Kernel)" <alexlzhu@fb.com>
To:     Yu Zhao <yuzhao@google.com>
CC:     Yang Shi <shy828301@gmail.com>, Rik van Riel <riel@fb.com>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Ning Zhang <ningzhang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH v3] mm: add thp_utilization metrics to
 /proc/thp_utilization
Thread-Topic: [PATCH v3] mm: add thp_utilization metrics to
 /proc/thp_utilization
Thread-Index: AQHYqPrSmG3WqzybNUurgyMbb9mveq2gpnsAgAAD8ACAAAWRgIAAB5EAgASWfICAAAsqAIABevqAgAABMACAAGoqAIABJd4AgAAB+gCAAAsNgIAAPuUAgAAEtACAACLbgIAAFL6AgAAOzQCAASBgAA==
Date:   Thu, 11 Aug 2022 19:20:13 +0000
Message-ID: <3195C304-2140-4E5D-890D-AC55653193E5@fb.com>
References: <20220805184016.2926168-1-alexlzhu@fb.com>
 <Yu1mcD6Jp4fCVEMi@casper.infradead.org>
 <0b16dbac6444bfcdfbeb4df4280354839bfe1a8f.camel@fb.com>
 <Yu1uabedm+NYnnAj@casper.infradead.org>
 <CA8C72B6-E509-4FB0-BEAA-C4368EB7A419@fb.com>
 <CAHbLzkp27aP4JYLPLzv2vtyzVe63bkhuZhw1jnxTF1Buvt4rew@mail.gmail.com>
 <fc108f58a4616d5d7d092a7c1f150069a92ee40c.camel@fb.com>
 <CAHbLzkqpn2ExBJuPD8sYJrEDCUU9=FE3GFh8kL3Bmax0KytKPw@mail.gmail.com>
 <1F8B9D85-A735-4832-AD58-CA4BD474248D@fb.com>
 <CAOUHufbGcuvJ8EfBkWrdCgeMCiceP0SxHZzcJnOt1Mw0P2w9kw@mail.gmail.com>
 <CAHbLzkqGq6LDDSCcFTJW9_O8dfAMje8_W6ddpDP9ESDQWUb07w@mail.gmail.com>
 <F28E23D0-C635-4A49-91EE-100AAA8C9EAD@fb.com>
 <CAOUHufYeuMN9As58BVwMKSN6viOZKReXNeCBgGeeL6ToWGsEKw@mail.gmail.com>
 <868F0874-70E8-4416-B39B-DA74C9D76A40@fb.com>
 <CAOUHufas1o1Ez9EDSjjxsO-w6Ph6Km8R8yOX+1_c=4LvG6DEWw@mail.gmail.com>
 <DD679B3A-BDF7-4EBD-AAC2-A663057AC8E3@fb.com>
 <CAOUHufbD-9PpQ+kuD=-8z-ptsrprjyThpkFe+4_NtFnzAjDG9g@mail.gmail.com>
 <DEB2F4F2-7F62-48F0-914D-5F71BFDBCBEE@fb.com>
In-Reply-To: <DEB2F4F2-7F62-48F0-914D-5F71BFDBCBEE@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ade0044-d59a-4ee7-335c-08da7bce8421
x-ms-traffictypediagnostic: CY4PR15MB1223:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uuvefhyfNQ/uobw+3luwU6ZzysrQLXSw4kNljt4KMda6GXHuOPDrQYjEGhmtZ8FAVdRDY5yQnO1akV5PdAvT5NSKn9gtr+zmHPk2EELTfXFTr53WP/xtcwi3klkbm9NitUDy/AK82p2KnWgIEOHfva6mECpvTDrMeaDpYdRFsalZ7xpzpgLOvUJ7JHW3mnEb2Po7qZrinIkLtgaigX/KB4z93zWhLCUoFfeUSGfv6QTOqzC5ThVjH9NIiLVIWfHE2RqUu6E3UQjUmzL+FmzoUfuodHehO/JjwV5+Vpz1vDfBCc5wX7fRUGWKsZDBH7SL65G6u8e17yCaDIvNBUcIZK+VaIKXiJan7bZekWz6d+OPSSrgNAeOD4FUYbdUjgWyQvS19BG224Eq++9brnfjcvUnKBUpp68JBmc7CCr2oqqvJbsVYk/AQHDP7aIW3+6Y4rr9LIclvoWKIK7zVABUczCoj6lAs7R+6p4mBU2xmmagCIHm7+f9w4fSpoCPQfIuF6kgbYtsh3cdfhzFSSZaXPedSSWvjA+IWOsBx0HnwUz8SJHocZNEzv7qAg++HXE63scDI2dLAaRe1QnC0FAmPqnnPZXZfOMlVJUPMTdzuzCh2md1RusicMWmTRwa9Jg0qm672LYs+OJ7C2jq96pT9Exp9sM4wFiITtULpE6wfDjRrLmXOvNAA5D6nwMHXgNZ6V4mOkeymC7q/sQBUSLtCknWY+A1sQJAq3cVIw2TTiXhLSSw1P/h/NcQpBO8mohwP1HhHFgMQ5ocfLras2Swy7ITlcZtWj9FJQV8Qv4egtWbm5Ah16ra4wJDSipGmA78eJ2s0i2fe61jPGR3hONfVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR15MB1781.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(66946007)(64756008)(66446008)(66556008)(8676002)(316002)(5660300002)(66476007)(76116006)(6916009)(54906003)(4326008)(91956017)(8936002)(2906002)(122000001)(38100700002)(86362001)(38070700005)(4744005)(33656002)(36756003)(6512007)(6506007)(41300700001)(478600001)(71200400001)(6486002)(83380400001)(2616005)(186003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alB5NWtZS21neXdicDlSd0pjdThkdXEzUFFFTTJBM1RCWGhrVFFvU0ZjRm5V?=
 =?utf-8?B?M3Y4eXlnWi8rdkNRL09jOGFaczlieEw0ai9DdWpqSEhHRFlCdllLdzFkWWp0?=
 =?utf-8?B?akx5VUpyMFpCeUFqWkVTL3h6WTN1elpjN0hPblExZWlyTS85NHpsSW51MGxD?=
 =?utf-8?B?Tm5hdFdFTVlBb1dDajBwODAwaVRpdzYveW9BVEorczZCY091S29DNmU4ZkRq?=
 =?utf-8?B?MFlTNWgrTjZlK3NlVjgwMTZZeS9RL0k4ZU1ZaFVhamc1K3NWSWlPSldWMWJu?=
 =?utf-8?B?NndtQ2dwKzNma0U1V2R5MXdhWEhCSC9qS3dabnN5NHdOQzJGdW5POThxVW1G?=
 =?utf-8?B?SWFoUjRuMjU1dE9xU0FtVVZsSWJ4M0ZFblZDQ2xuVW8ySTZUbHBPMlZEaEc3?=
 =?utf-8?B?eVl0OXp6T3BuMUcyZ2ZrNEdsOVE3ZjlJMDVWUVI5LzJwT2hOU2pGMEg1VEtQ?=
 =?utf-8?B?UndVbnJFM204bW51MVl1Z3I1UzJHRU0wWmh5SkxkWjkxc1Y1ejNzWEREZXlj?=
 =?utf-8?B?S0V5NmNVc21NZWc3a3NhaVpHMnVvNTY4a3ZnMEpNZDZoRVlkVCt0VDAveGZH?=
 =?utf-8?B?b2FiTENNYWExVnhvd2JOY0dnc1ZpWmtJR1ZoQkZ3Nml1OGp5S0xEUTJpUDNP?=
 =?utf-8?B?ZFd2RmlvazZqclo2L0p1YTlEZk5mUldhcFJDbEo3cGRIYXN4bG16cUo4RXhP?=
 =?utf-8?B?bXFJQisrbklSbDR2REo0cnUyVy9idDd0RWVOaG41Q2oyRDJaajdqdlJQMDM1?=
 =?utf-8?B?eXhScnFybWtBMHUxRVlDdXhQNDB2eHBXaGxTbzBHaVhVYTl3SEZnQnFkNmg3?=
 =?utf-8?B?T24yL1loeFZqQXluWVNJSkdHcUtoQlZsdXRZcVduTGthYVF3WG05czlCelZF?=
 =?utf-8?B?Vkh0cml2Q0xhMjRPNW13R05YcFBnaE5YTytFSHVaT0lKOVBBQ25sNmsvb0N3?=
 =?utf-8?B?T1lIbG5KOHNzR3JBSy8rVTZtaVkxdW1CL3hMajVHMUxpd3RHbHFoN09BaVVq?=
 =?utf-8?B?QlhEYnBDZGxzY0pCdytLTmVZbVZjcDVzUFhkdGhxcTB3NzYxRG1sc1pUUE92?=
 =?utf-8?B?dzZrbWNzOFVjVHNhWXJxK3l3V2hPZ3BXdURJMWJ1d0k1SndVZkpoNW8rdGRD?=
 =?utf-8?B?MVpUMUJadEhRR001UDROc3BmQUgrUE9rL1FNR05iK1VKVlZBb3VjblU3d3Jr?=
 =?utf-8?B?UkN0SkRYVGxUb0JWMFdqdk9tQm0yRjViYXlMYzBEM05hdHkwVDFRUDFjUnNi?=
 =?utf-8?B?SlVTRHVqWnYyK20yS0g0WkVPeG00WVdiLy9mc3YyazRBa29aV1oydHZMVHBy?=
 =?utf-8?B?VE01MXkzK2t4cW1aQzdwU0Fndk8zL3pCc0hUT083R2hRUDA0eUk0Wkx2VVpT?=
 =?utf-8?B?d2NYdkhKdzdFcHM0clg2c2NzYlJlLzlxcWR1OGIvbEdTUTJ5S1NYaHRwSFNh?=
 =?utf-8?B?UDhMRCtxVW5hOUpYMjBpYVpsd3NpWFdXWmN4TFZLOC9QOXY1VHVndmJzYWN3?=
 =?utf-8?B?dmc3NDB3ZldOOGU3UUhYdXlvM0tnQVFlWDVrbEZwSnAvZmhDMmVTYXpWM2Vz?=
 =?utf-8?B?ajF5RkRRSDVySC8vODlja0tTUmlrZWU5RWhRT2tEQW1JeUR1WUZ0QmlQRGR4?=
 =?utf-8?B?SUdHRlkreDNpQk9uMjdSY1R3MUNPT25QY1FDaGFXRlFFdGhMRkFycWc4cXUz?=
 =?utf-8?B?WlJ3S0ErRk43UXdGRERBNExhTXVlS1VuQ1p3cktud0NNQlBzSHI2U242dFVD?=
 =?utf-8?B?eGo0RE5GZW81aDlkODZqZVFNV0V2Q1dVTWJ1RGFsckYrZTVIUHNPMDFqSWRK?=
 =?utf-8?B?aXR6TC9lSVhteHR4UWVYVjRTdDJ1RERBUWQ2VWF6V0NBZTVQeThDSmR4NlF6?=
 =?utf-8?B?YzlnTmxmZ1ZZMlQvcFFmMHF5RFBPZDJHWHc2cnVneU8rUzFyL2tRZEkwSWhx?=
 =?utf-8?B?UDJjSFA2bmxmZzdjc0IyQVFBd01Ma28yemlqc2gyMzBFUkxjVDZGVDFGS2dX?=
 =?utf-8?B?SndvMC9VUnA5L0FYVDVMT0pqTWo3ejVOTUdQQWsxS25McFgvcW03NmFSRjVz?=
 =?utf-8?B?NWdVVGRTQkFlaVlObFBpMjYwUGZ0YVZiME9Sd3FaZzN3R0UrMTUyTnRRMTJ5?=
 =?utf-8?B?NWhwK2pxckpZR3RXOUYvVUNqNGpZdndLTHFCdjNSVTR2VFZwMS85a3FMblB5?=
 =?utf-8?Q?8Ts43q1swGIvMOFsFcIa+u4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E910FBB5E217DD43B1287744333DA859@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR15MB1781.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ade0044-d59a-4ee7-335c-08da7bce8421
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2022 19:20:13.6125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C4OK8A+r661zA/WTQZDq3bT77hjcRiv0o7J3SXQ0OKQGipPnL4p7l/WTy/jcB9Gw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1223
X-Proofpoint-ORIG-GUID: QI5oaPLrA8fngCEMRXatCC2KiJzfo7Kx
X-Proofpoint-GUID: QI5oaPLrA8fngCEMRXatCC2KiJzfo7Kx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-11_13,2022-08-11_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgWXUsDQoNCknigJl2ZSB1cGRhdGVkIHlvdXIgcGF0Y2ggc2V0IGZyb20gbGFzdCB5ZWFyIHRv
IHdvcmsgd2l0aCBmb2xpbyBhbmQgYW0gdGVzdGluZyBpdCBub3cuIFRoZSBmdW5jdGlvbmFsaXR5
IGluIHNwbGl0X2h1Z2VfcGFnZSgpIGlzIHRoZSBzYW1lIGFzIHdoYXQgSSBoYXZlLiBXYXMgdGhl
cmUgYW55IGZvbGxvdyB1cCB3b3JrIGRvbmUgbGF0ZXI/IA0KDQpJZiBub3QsIEkgd291bGQgbGlr
ZSB0byBpbmNvcnBvcmF0ZSB0aGlzIGludG8gd2hhdCBJIGhhdmUsIGFuZCB0aGVuIHJlc3VibWl0
LiBXaWxsIHJlZmVyZW5jZSB0aGUgb3JpZ2luYWwgcGF0Y2hzZXQuIFdlIG5lZWQgdGhpcyBmdW5j
dGlvbmFsaXR5IGZvciB0aGUgc2hyaW5rZXIsIGJ1dCBldmVuIHRoZSBjaGFuZ2VzIHRvIHNwbGl0
X2h1Z2VfcGFnZSgpIGJ5IGl0c2VsZiBpdCBzaG91bGQgc2hvdyBzb21lIHBlcmZvcm1hbmNlIGlt
cHJvdmVtZW50IHdoZW4gdXNlZCBieSB0aGUgZXhpc3RpbmcgZGVmZXJyZWRfc3BsaXRfaHVnZV9w
YWdlKCkuIA0KDQpUaGFua3MsDQpBbGV4
