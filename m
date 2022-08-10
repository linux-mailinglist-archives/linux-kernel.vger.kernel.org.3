Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD60A58F3E7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 23:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiHJVje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 17:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiHJVjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 17:39:32 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CBD60692
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 14:39:31 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27AGuVJ7024465
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 14:39:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-id : content-type
 : content-transfer-encoding : mime-version; s=facebook;
 bh=26x6A+WfuWhxZ0vHA+0BY1NPsk3gEK+xTEADBkLXmsw=;
 b=ifZPggSZPhAyIyQqikAAGd8bHb8/0fQmTemqo30DRKP2yLl55KUduNP0DpBIWFR4oBow
 xOLrADc3B1aZNkgmltZO522rvYmDJz3kqA+NsizmkWMjJZubH/NWmNqPOYQh/5rXRLpw
 rbVsL9ylnqalVfszpcB2OldeuI19WZ4jpls= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by m0089730.ppops.net (PPS) with ESMTPS id 3hvdb5vcs7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 14:39:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHSk1nJEP5UQPGY7bf09WgBBROQlxByCRQbMqQjpIyYz0t+sv/DDSsLQVR9nCVw1WA1CB/KMh2tZbeiMJZuC4oCYI2a2f3SbVMxj3wd8/Whp21UqaActy3gNRMBF5Zrmn6dPtvFdcX4qIopwzle9dUZ9v2GkzMYDv9oQP0wD9934xHSYLFZgBQzWqO8KJ+uJ7rMnEd+KpotQ2BCSvcG3dHk+uQgldZtlKB9gE7G+EyR8rW6IfvBXpFCwB6UulktQgoEVDggktt8WmrbsjItFT1srBkfs3RPRQxzw0kh4wx5bTjbcTHPQowsbhWhjpVyjEV04yJmVtdIwJ1hmCIUBvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26x6A+WfuWhxZ0vHA+0BY1NPsk3gEK+xTEADBkLXmsw=;
 b=Vq1Hy7/QBaCC5fYoxmXUFkQQfmoBZ57baRN2sD1TzOfejBtlWHcEEFN+2Ng60gO5epsIjctT/9sjb+YgypU7rH+t38D1FC1//Bh9VaoHigdlRFoKXfGPdg0Fsl7Qk9tVJr76szrBA/CvnrkEE/y0AXdQ/Vk2kYtHpJKz5mAZ1zdvwWvxU48P1T0IXyvIHlhuhg2KQW7ak2axZSvGMHUAGbTX+MC+JazNo/NMdyjZrnKL11hgGN9gxr7iyr1217Mf9PQTwHJiNr1HYB1RAr7nb5I/qnS9xxY4DgsbbNoT98/hqyjY15vxJglQGjS+6Idbirp4pGHJpC4NmbRyljaTog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from CY4PR15MB1781.namprd15.prod.outlook.com (2603:10b6:910:1f::13)
 by DM6PR15MB3274.namprd15.prod.outlook.com (2603:10b6:5:16a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Wed, 10 Aug
 2022 21:39:18 +0000
Received: from CY4PR15MB1781.namprd15.prod.outlook.com
 ([fe80::351d:e6bc:a9e4:4118]) by CY4PR15MB1781.namprd15.prod.outlook.com
 ([fe80::351d:e6bc:a9e4:4118%12]) with mapi id 15.20.5525.011; Wed, 10 Aug
 2022 21:39:17 +0000
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
Thread-Index: AQHYqPrSmG3WqzybNUurgyMbb9mveq2gpnsAgAAD8ACAAAWRgIAAB5EAgASWfICAAAsqAIABevqAgAABMACAAGoqAIABJd4AgAAB+gCAAAsNgIAAPuUA
Date:   Wed, 10 Aug 2022 21:39:17 +0000
Message-ID: <868F0874-70E8-4416-B39B-DA74C9D76A40@fb.com>
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
In-Reply-To: <CAOUHufYeuMN9As58BVwMKSN6viOZKReXNeCBgGeeL6ToWGsEKw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e65d50b-af81-4cb5-8bb2-08da7b18c748
x-ms-traffictypediagnostic: DM6PR15MB3274:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fmk1mcMTmJvcm4IEhcuCAdDpm8DdUIqWUsVPytq88d8jz6HOqYDrCe1gwiSID2WTLTTRMLTaZ5e7+zRmhugpT2zZJOBGTUxr+GPEQ/BepkLgWAcYz18F+90ccywfqoeRsdlOn3vE9wVhZqJ0kMSxTGH9b0ohXU9qxTxITK6Aep2i297ni5mM1rtH9NhwFmJZlhtkAZ8gz46j1xYn0qgN20CLIRtb9UHVue3rugwJwtaBaiSmPZr8hCif0BcBwk8s6gPEYAiWyqQNLxIaxXVHcL2wf9ldk0ttAu7cZSMmcBu634knrlEty2Z4mo3YFj+Zaz5NbF+Y+961JCVRBu14SCPIWnMfwLlqwFepH58Tu52FYCnmW2+9HMuUf/K2RIF6kyzR6ATLMqi84wpJW7wg0a+8Hq2vjEtklNHgOjo85OJU3TyluIF4vRJj8suJkSyPRtfpqulyvw+D5ZkSXMKm6jlEV27m0JSnitdYQbJn2AE4GIPRpmOAAQicwbvyxIxlvJWtf9yq4MIrbwgZuAm1F7wSKMNXfHOhlaXysLtVODGxmvYK4AzLXtGKN1NrHAmw7TGWFThTe+uDxwX/o0LnfB7rdj4n28rVU+VS0OMfkvf+9kMgv2C9vm80nDb/93R0bBq+46klVYp441KUbXa9ZWX25+dJoHD7fUlK28nP5jV9R4+Xteh1Cj2Apb+81UW/XgYb3IA2Rlw3kAdGZNH/FDXOEYKhBFwNwhEg7hl4y6TVPC9RKeWanjckFEA73L9CeRl2BhTCGlCoN7++BY+saHETTId+SYIhQvw0ndlYMZHWXukzlE/g10hB3K/h+YhkAoUF3z9UlD40aHAC8/jIPTMcAA1fs+jVxNyLa9zwSjJmUY6AiQD+2EXnXNBBJxGj1lvgpidUkHNvDfVunWhsLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR15MB1781.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(86362001)(53546011)(33656002)(6512007)(6506007)(36756003)(38070700005)(38100700002)(2906002)(122000001)(83380400001)(8936002)(5660300002)(2616005)(966005)(66946007)(316002)(186003)(478600001)(4326008)(41300700001)(91956017)(6486002)(8676002)(64756008)(66446008)(66476007)(66556008)(76116006)(54906003)(6916009)(71200400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N25LdFdNQmkrOGF3SE5mS3dJeDlqWlA1aHpFV0RtckxlSWNJRVIxYm5Xb3hF?=
 =?utf-8?B?US83M0ZJdFBkaG9LMXlBTjNBY0IrSnMyZmphY1EwVEREalVlMkZVaGNjWlAr?=
 =?utf-8?B?Qjg0aXBHOXl4dzZTTFBUbXY5THhvSFdvS1ZmeWwveDI1VkZhOTcwL3VqZFF1?=
 =?utf-8?B?NHlpNEZuY2k1cE1yMFJibXY0eU5DL0p1cjlJYWRiV3RNRDkxZUZXYVAyTDlr?=
 =?utf-8?B?b1U4dFBFMnhoSUZLUzNSUUx2QjJvR092Y2hSb0VKbGNUbDIyVkhSVzhxR3R4?=
 =?utf-8?B?RFJkMmZGZ1FZNW9sUnQzbDBhekxEM0xHQlNVT2c4VzR1NnF0VTFsMFRjaWYx?=
 =?utf-8?B?WGpabHpBdWtLOUxCNTBNY20veEZqQk1TYTVJeVdQVUl1SXRqY3d6VUx2Vlpr?=
 =?utf-8?B?elNNcXJzMzI1SENIQUtMNTVyZDVVU3RCMXVuVEhhbkdramgweFRLOWx4ZkEz?=
 =?utf-8?B?dGd6aWcrbS93S01CWVRBbkw3ZUVqOXNobFh2Q2NISGNRQ0dFWWpXYzJEU1Uw?=
 =?utf-8?B?azMwM20yMVYxVkFjNlB1U2duKzFtWFJPMzZEWEVKRUp5LzB1enJmbGR1OWRQ?=
 =?utf-8?B?ZzJtY2U2dHcya1QyWitCcGg3N2NaM2F4NWtNTFlzcGNhd0MyUDRnT0w1YzZk?=
 =?utf-8?B?cHB2Q2RoRDZSUXdacWFyeDFCSmFuU2RBMzJEaUlnbER2YnFZNmRoVGJUL0dz?=
 =?utf-8?B?b2Frb2liSmhlNUp4RnM2SFZJOGFqNjFCZVVrYzhhYXRYb1VHOGVJbE44cHlP?=
 =?utf-8?B?QUtuKzlORnFaNVJNcHJiM1VVRm84K0JzYVU1MEZPMHRYMk1WWTM5N1hmTGFj?=
 =?utf-8?B?M2RBdDR6MXNKMVZYNjY4TysvNWdEblQxeGVVUUw4Zml5RUtvbDU4ZTcycFpp?=
 =?utf-8?B?N3lPUjQydmNvbmFmL3k5ZUhaa3dab0I0QjBTNzQ2T3ErS2ZJVHZ5ZkU5bTRB?=
 =?utf-8?B?anM3NG1SemUyQzE4Tm93aDhRTGdMancvZHZxZDQ4ZVJXTTVCRkN3T2FyaTMv?=
 =?utf-8?B?RlBCRUJpb3dNMjNZRzVJNnB6Z2tidEpYWkVnTXh6M2l6YVdoV1Fvem5KMVdB?=
 =?utf-8?B?cmorUXErcEdQYzZVbDRlTVJEcWZDcFJVSWVIL29xMXJQcng2V3BRamNDekF0?=
 =?utf-8?B?RXZIZ0tDSUs0MU92bHVmVGxxaHBJVXdnWDRSMVZSVWFQVHVqbmJEVVNwWUxt?=
 =?utf-8?B?OFlMcVIyQlVVTkZyRzZiSEhQTWxiUm9BTWIvVWtKZlA2Z2hlRlUyaXRmZXdw?=
 =?utf-8?B?dVZwTUpnWVNVVWtTZFJLMTdhOG1pRmE4bE5TYzdRWUIrOGttcS8zaGtUajIw?=
 =?utf-8?B?TmZRMlN5RnhSazlWeHhpd1NWckVmVWxxNkJtZU0wMkFIcjJDcXBCYjVKZENE?=
 =?utf-8?B?NDExMEM2MVlGclRSSVZBNnI0dy91a2ZkeEorTDgxRzlRRVhRQ1VVbzAwRTh2?=
 =?utf-8?B?U3R2NWs5ejhiVGFBSjh6VE04dWtrb1YvTnFBK3NGN3NKWEtJZ1pJS3VrVDBk?=
 =?utf-8?B?SmUxbDYyVjNhVU8vM1VTWktLOUIxRnlROXdCN2ttaFNMU0hwT0pjaTFIN1Jv?=
 =?utf-8?B?ek56Nnl2L0JmOUNyUHI5dHdNUGF6d3VLZGoyT3VCd2RrY3FzaTM1UWtNeWlR?=
 =?utf-8?B?WkllaUYxU0pEN284VC9OZ1lBaGNOd25PNDd5dW9pcEx0UXhzc2RibGNZbzN2?=
 =?utf-8?B?bEh0a2tyMStWZ3lIWWhWKzdwK0ZSL0pwNEh3OVhFUjhLY2l4aEJqRzA1a2o0?=
 =?utf-8?B?Um9FNWMzRUJJblE2eTF1TUdTZklqQmI3ZXE3TkVIdjBBbjNFb004WTArQiti?=
 =?utf-8?B?L2I5M0wwQzZPbnVyYm85UThCNnk2VG05cEV3dUtNRnpjODNSREk0dWxhdFp1?=
 =?utf-8?B?M0NpNjA1Wlp4dVpjanlvMlRZSlQzc2laOVhtSlZGdThZbEhIeUpUaEdENVdG?=
 =?utf-8?B?MFU5K2lUclpPVjduWlF6QkFnbnJ2Mjl6K0haZlUwTkdyWU1kNm81Z213L094?=
 =?utf-8?B?b2JxYkgvdzQ0ZlBDL1cwWGFFdWxGVkZxUzFkL1JQMXZmWUtLRUF3eExVa1hi?=
 =?utf-8?B?WTZXT0Y5dkVvL3ZxM1BZbFFKb0JIcElodTZDOTVib3lsaEZaMitnUzlRRjA2?=
 =?utf-8?B?cHNXU25FVTNtMXh1TG1ROFhyb2x6S0RORWNGYmgralZ2UjRldjdWMlZodWJt?=
 =?utf-8?B?alE9PQ==?=
Content-ID: <8722E4BF2B1B434796A450FBA65A286E@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR15MB1781.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e65d50b-af81-4cb5-8bb2-08da7b18c748
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2022 21:39:17.8573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lUWVMEGbiEVTe6yepzIJyrXEF7mExY9aGUjG/BO/6PwqNXBglVF53a2F2GywQykM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3274
X-Proofpoint-GUID: sVWA5oJuBBaR-W4Um00G1bb6D-Lw9LCZ
X-Proofpoint-ORIG-GUID: sVWA5oJuBBaR-W4Um00G1bb6D-Lw9LCZ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_14,2022-08-10_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gQXVnIDEwLCAyMDIyLCBhdCAxMDo1NCBBTSwgWXUgWmhhbyA8eXV6aGFvQGdvb2ds
ZS5jb20+IHdyb3RlOg0KPiANCj4gIS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18DQo+ICBUaGlzIE1lc3NhZ2UgSXMgRnJv
bSBhbiBFeHRlcm5hbCBTZW5kZXINCj4gDQo+IHwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIQ0KPiANCj4gT24gV2VkLCBB
dWcgMTAsIDIwMjIgYXQgMTE6MTUgQU0gQWxleCBaaHUgKEtlcm5lbCkgPGFsZXhsemh1QGZiLmNv
bT4gd3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIEF1ZyAxMCwgMjAyMiwgYXQgMTA6MDcgQU0sIFlh
bmcgU2hpIDxzaHk4MjgzMDFAZ21haWwuY29tPiB3cm90ZToNCj4+PiANCj4+PiBPbiBUdWUsIEF1
ZyA5LCAyMDIyIGF0IDQ6MzYgUE0gWXUgWmhhbyA8eXV6aGFvQGdvb2dsZS5jb20+IHdyb3RlOg0K
Pj4+PiANCj4+Pj4gT24gVHVlLCBBdWcgOSwgMjAyMiBhdCAxMToxNiBBTSBBbGV4IFpodSAoS2Vy
bmVsKSA8YWxleGx6aHVAZmIuY29tPiB3cm90ZToNCj4+Pj4+IA0KPj4+Pj4gDQo+Pj4+Pj4gT0ss
IGl0IGlzIGhhcmQgdG8gdGVsbCB3aGF0IGl0IGxvb2tzIGxpa2Ugbm93LiBCdXQgdGhlIFRIUHMg
b24gdGhlDQo+Pj4+Pj4gZGVmZXJyZWQgc3BsaXQgbGlzdCBtYXkgYmUgb24gdGhlICJsb3cgdXRp
bGl6YXRpb24gc3BsaXQiIGxpc3QgdG9vPw0KPj4+Pj4+IElJVUMgdGhlIG1ham9yIGRpZmZlcmVu
Y2UgaXMgdG8gcmVwbGFjZSB6ZXJvLWZpbGxlZCBzdWJwYWdlIHRvIHNwZWNpYWwNCj4+Pj4+PiB6
ZXJvIHBhZ2UsIHNvIHlvdSBpbXBsZW1lbnRlZCBhbm90aGVyIFRIUCBzcGxpdCBmdW5jdGlvbiB0
byBoYW5kbGUgaXQ/DQo+Pj4+Pj4gDQo+Pj4+Pj4gQW55d2F5IHRoZSBjb2RlIHNob3VsZCBhbnN3
ZXIgdGhlIG1vc3QgcXVlc3Rpb25zLg0KPj4+Pj4gDQo+Pj4+PiBUaGV5IGNhbiBpbmRlZWQgZW5k
IHVwIG9uIGJvdGggbGlzdHMuIFRoaXMgZGlkIGhhdmUgdG8gYmUgaGFuZGxlZCB3aGVuDQo+Pj4+
PiBpbXBsZW1lbnRpbmcgdGhlIHNocmlua2VyLg0KPj4+Pj4gDQo+Pj4+PiBXZSBmcmVlIHRoZSB6
ZXJvIGZpbGxlZCBzdWJwYWdlcywgd2hpbGUgbW9kaWZ5aW5nIHRoZSBleGlzdGluZyBzcGxpdF9o
dWdlX3BhZ2UoKQ0KPj4+Pj4gZnVuY3Rpb24uIFdpbGwgZm9sbG93IHVwIHRoYXQgY2hhbmdlIGlu
IGFub3RoZXIgcGF0Y2guDQo+Pj4+IA0KPj4+PiBGWUkuIFRoaXMgc2VyaWVzIGRvZXMgaXQ6DQo+
Pj4+IA0KPj4+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjEwNzMxMDYzOTM4LjEzOTE2
MDItMS15dXpoYW9AZ29vZ2xlLmNvbS8NCj4+Pj4gDQo+Pj4+IEFuZCB0aGlzIG9uZToNCj4+Pj4g
DQo+Pj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMTYzNTQyMjIxNS05OTM5NC0xLWdpdC1z
ZW5kLWVtYWlsLW5pbmd6aGFuZ0BsaW51eC5hbGliYWJhLmNvbS8NCj4+PiANCj4+PiBUaGFua3Ms
IFl1LiBJIHRvdGFsbHkgZm9yZ290IGFib3V0IHRoZXNlIHNlcmllcy4gSXQgaXMgdGltZSB0byBy
ZWZyZXNoDQo+Pj4gbXkgbWVtb3J5Lg0KPj4gDQo+PiBJIGxvb2tlZCB0aHJvdWdoIHRoZXNlIHBh
dGNoZXMgeWVzdGVyZGF5LiBUaGVyZSBhcmUgaW5kZWVkIHBhcnRzIHRoYXQgYXJlIHZlcnkgc2lt
aWxhciwgYnV0IHRoZSBhcHByb2FjaA0KPj4gdGFrZW4gc2VlbXMgb3Zlcmx5IGNvbXBsaWNhdGVk
IGNvbXBhcmVkIHRvIHdoYXQgSSBoYXZlIHdyaXR0ZW4uIFdoYXTigJlzIHRoZSBzdGF0dXMgb2Yg
d29yayBvbiB0aGlzIHNpbmNlIGxhc3QgeWVhcj8NCj4gDQo+IE92ZXJseSBjb21wbGljYXRlZC4u
LiB3aGljaCBwYXRjaGVzIGFuZCBob3c/DQo+IA0KPiBBdCBhIG1pbmltdW0sIHlvdSdkIG5lZWQg
MSAmIDMgZnJvbSB0aGUgZmlyc3Qgc2VyaWVzIGFuZCB0aGlzIHBhdGNoOg0KPiANCj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIyMDYwODE0MTQzMi4yMzI1OC0xLWxpbm1pYW9oZUBodWF3
ZWkuY29tLw0KDQpUaGUgY2hhbmdlcyBmcm9tIHRoZSBwcmV2aW91cyBwYXRjaGVzIGltcGxlbWVu
dCBmcmVlaW5nIG9mIFRIUHMgYXMgcGFydCBvZiBtZW1jZ3JvdXAgYW5kIHJlY2xhaW0uIFplcm8g
dGFpbCBwYWdlcyBhcmUgZGlzcG9zZWQgb2YgdmlhDQpscnV2ZWMgYXMgcGFydCBvZiByZWNsYWlt
LiANCg0KT3VyIGFwcHJvYWNoIGlzIGEgdGhwIHV0aWxpemF0aW9uIHdvcmtlciB0aHJlYWQgc2Nh
bm5pbmcgdGhyb3VnaCBwaHlzaWNhbCBtZW1vcnkgYWRkaW5nIHVuZGVyIHV0aWxpemVkIFRIUHMg
dG8gYSBzaHJpbmtlciB0aGF0IGNhbGxzIHNwbGl0X2h1Z2VfcGFnZSgpLiBXZSBmcmVlIHplcm8g
dGFpbCBwYWdlcyB3aXRoaW4gc3BsaXRfaHVnZV9wYWdlKCkuIFJlY2xhaW0gd2lsbCB0cmlnZ2Vy
IHRoZSBzaHJpbmtlci4gDQoNClRoZXJlIGlzIHNvbWUgb3ZlcmxhcCBiZXR3ZWVuIHRoZSBpbXBs
ZW1lbnRhdGlvbnMsIGluIHBhcnRpY3VsYXIgY3JlYXRpbmcgYSBsaW5rZWQgbGlzdCBpbiB0aGUg
dGhpcmQgdGFpbCBwYWdlIGFuZCBtZXRob2RzIHRvIGNoZWNrIGZvciB6ZXJvIHBhZ2VzLiANCihJ
IGJlbGlldmUgdGhlIHByZXZpb3VzIHBhdGNoZXMgaGF2ZSBhIGNsZWFuZXIgbWV0aG9kIGZvciBp
ZGVudGlmeWluZyB6ZXJvIHBhZ2VzKS4gSG93ZXZlciwgbG9va2luZyB0aHJvdWdoIHRoZSBjb2Rl
IEkgZG8gYmVsaWV2ZSBvdXIgYXBwcm9hY2ggaXMgc2ltcGxlci4gDQoNCldlIGNob3NlIHRvIGZy
ZWUgd2l0aGluIHNwbGl0X2h1Z2VfcGFnZSgpLCBidXQgaXTigJlzIHdvcnRoIGRpc2N1c3Npbmcg
d2hldGhlciB0byBmcmVlIHplcm8gcGFnZXMgaW1tZWRpYXRlbHkgb3IgdG8gYWRkIHRvIGxydXZl
YyB0byBmcmVlIGV2ZW50dWFsbHkuIA0KDQpJIGJlbGlldmUgdGhlIHNwbGl0X2h1Z2VfcGFnZSgp
IGNoYW5nZXMgY291bGQgYmUgdmFsdWFibGUgYnkgYXMgYSBwYXRjaCBieSBpdHNlbGYgdGhvdWdo
LiBXaWxsIHNlbmQgdGhhdCBvdXQgc2hvcnRseS4gDQoNCg==
