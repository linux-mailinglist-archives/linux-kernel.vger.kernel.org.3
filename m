Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FFC58F2DC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 21:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbiHJTOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 15:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbiHJTOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 15:14:15 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A016825CB
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 12:14:14 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27AGuQ7k003054
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 12:14:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-id : mime-version
 : content-type : content-transfer-encoding; s=facebook;
 bh=uh18fWDEu4A9k8cQC2N7qC6+Rb+FBVgeK2GuOZpeoJc=;
 b=chHnMjxWwInBQ9gWW1YHCqUaLSd/1YiSBvc21wEK6Ae5q1ZIUyVx9E9yqDBbqI6tJoIP
 j4uoCIQzVM8uL3BE3XR5bUIxrqwEOLtzGb0nHOuQ9Q6LEtfosH6DN8cVHbkkkogekeIP
 3Dtbnc0hJTSGSkXsUCUfuJ7Eo33v9k0EmeE= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hvdb6b41q-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 12:14:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JsrYJNsgmNzNeCytd1eUDP+9EjF8CWVVoBX8HtedlDYoSbpdXcGex9Hi6zQFsVL3rzg0y1ikHV9au8gIzvdRQFSXOmDgK7SsA941J7jKBVQSuvHjoJzAkFYRMEHxrzq6ZFSaj76eh1AjRJgeoLP1m8t8jJpYzJyuH02ACpo3XOLwAm+K8FEfGDc3+Mm2aOvAWXzTmcGdgurWNNzE35C+uRTq1GpYzWSOf1yXQ8fDJAfrjZ0u1teDJwZ2oXrbnppCm7E6nozowlx9+Y8P46brgH6LI7miwrGSpTs1fcDLyW0HArQemGF/43XH0ruz1no+zLAGHQ0Pnzuma7V5kTgmBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7oCiZCvb9tOT6jCUnjzOr1y5/Gyu4FV3RUAkbO2gbg=;
 b=DZd6f6CJkcUGYe3qly4DZsxZ7KcwrFfXvntV85avLbBM4R//EhYDoxUpb1US6/Z0RyAEw9ja+sr/a3hjMyoThEMWJUPslQCROxvng0DcDEl/LpRtwkuGMuMYHEI3E4pAzC6yGWWQIDYpELlMVGFOI5pjKAWlhBdRrgfFNqx1N4c4kAHIWgJjjWxrdHgbyToVVJcuRraVgYjzWU3bOzYyqr4wPbGYDNrJiHY46k2bR4r3Bgz/iyDspETYUPu8yO3VFwhj6Qaj6fOuyOeCunqFJz3NpBd/u9b5o2YTZCVv/tR631410sWVkQ7/ctzLwPGiX9RjFjRwaj3vbrwuLialqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from CY4PR15MB1781.namprd15.prod.outlook.com (2603:10b6:910:1f::13)
 by SJ0PR15MB4504.namprd15.prod.outlook.com (2603:10b6:a03:379::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 10 Aug
 2022 19:14:12 +0000
Received: from CY4PR15MB1781.namprd15.prod.outlook.com
 ([fe80::351d:e6bc:a9e4:4118]) by CY4PR15MB1781.namprd15.prod.outlook.com
 ([fe80::351d:e6bc:a9e4:4118%12]) with mapi id 15.20.5525.011; Wed, 10 Aug
 2022 19:14:11 +0000
From:   "Alex Zhu (Kernel)" <alexlzhu@fb.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] mm: add thp_utilization metrics to debugfs
Thread-Topic: [PATCH v2] mm: add thp_utilization metrics to debugfs
Thread-Index: AQHYq5JZQULDgRwK/0mEQvc8hL0ijK2mkgOAgAHxloA=
Date:   Wed, 10 Aug 2022 19:14:11 +0000
Message-ID: <9215F2F7-8354-4A86-B5DF-A82ED75B3BCD@fb.com>
References: <20220809014950.3616464-1-alexlzhu@fb.com>
 <YvJiG3oviaRgPSVC@casper.infradead.org>
In-Reply-To: <YvJiG3oviaRgPSVC@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fc5e1e7-de94-4751-f818-08da7b048213
x-ms-traffictypediagnostic: SJ0PR15MB4504:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EoW8TjvNVX+rDl105SHVkoXMdP/UloeKFIoTKwZLOlA7hdcsU+re+wcYPvwQnXXK2AXiipkoKnEV/1rPMQ+psXEMpEMZ2hs3YD3JGqq7WD5iYi29hYAc4jdCQjEGJQdfIiOjgZyOI82BS+lp72sNSX7JZgGRD09Ov3KjnymfSnUbuqeRZ2M2S9k0+ehcDnvkQpgLJCkbJk5jdllXo6Rmsnx2e/ofLZrlUJz3bu7sT+WxqSCCNQC0JWwx9NKF3fSuleTpn44y4sRYYSV28Xwzb02cvv3DVgtZaj9zhRKIWcGPJhQNKYgxcfvkE/qPvncakso34I0q1QwHZve+JzZ42U4SabIUpuQZsnfqwG8V8umbGzno5q38uw1Ch7cf3emBRUw6aql5u9/NVs7Fz9qQdm0erK6KKOOCVbQu3/SuwN2ytnbsx0AjvDqJwQh0f6Na01Xxb2ZtMVneJX4Ic5N7g6Efx6h1xoCdW3BcMGFljYzwz8hiaOaviHHM+A0SArg4btHPARbkBzPVU++j23sg3ieJQMvRD5/lxf18QURPom/n7teMPXs646jatA0vTzeQ/tCZfkORCWGsyuApiSk7XVjFeS7DQQeDYf4ew45hJk6NngzHERtRvNytb+UJk3+CWmmd7EVryBA/P6CFYGu66fKJzRFDEXahKw878jOhKV6mJGglt0hTJiTvvlp8jsLORiiRZH6FY9t9HPmNkfNZ/pYEHByOrTHKYowAJcG0q7E/UMZVbfUf3RWlm1iF19ZJYNMz+F/+zPl6VB2G/vIPbAhqFhmlEd7WbKip2nf0rAdRrsZ9e4W8+SlWrNJCb8Vq89VTPL9EXPNMxNdt8POA8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR15MB1781.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(38070700005)(41300700001)(6512007)(54906003)(36756003)(316002)(2616005)(6916009)(2906002)(122000001)(38100700002)(66446008)(64756008)(66556008)(86362001)(4326008)(8676002)(5660300002)(66476007)(6486002)(8936002)(6506007)(186003)(66946007)(76116006)(71200400001)(478600001)(33656002)(91956017)(83380400001)(53546011)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QLMiarrE6R9t1WyyBYtX+nLqrPc3+6ZS2iyWptAPeu3QWxYaGvRndm019oXx?=
 =?us-ascii?Q?HkXEDm4HimXD4bNr8Ktu0BKZHzTPestzikM8Njj2GI9IPuAN4pW6ggFYh3jS?=
 =?us-ascii?Q?YW2yvYFlTFpiqa+RtaE9z1oc2VVIFokW8RQ39knmqtB/Byy91AP8dFFBIc4Z?=
 =?us-ascii?Q?yW9rUw7v+rxwKk0XVCpiHz4y1BUUex9ljq+1L70suIX7W+ZTCeb/SO75Qhb7?=
 =?us-ascii?Q?tRyXt2KtiH9/tCQvlK50YEvfcDgQ8oEsPDhgFIB6Qe1qxtWG10jLBMI2b869?=
 =?us-ascii?Q?eFnoF2u3Ipo/tFGjjrj1KlhDUTot+wSYS1foxZJXD3qireAcgadmF7Ji6tnp?=
 =?us-ascii?Q?QEPi0FPWcYvEgSZ8XEhF6GMsUUfGWaqTnPSomaPfv7eLoS/IGUTnPw3eEKK5?=
 =?us-ascii?Q?OvSrK2qfv5XviDMaZGBjdY8QChPCEN7Apm8Z51eUPeY4O/s8dOoQDtRly8Fq?=
 =?us-ascii?Q?PTQ6vCBe8Mv6PUEKxLdqa+VtCi6joLtbLEPynL5VADnCRhMaAgrZSrCGY30/?=
 =?us-ascii?Q?2rSEWwaaYILjAQ6PA5PEdGhuKwAVTyRsArJ/htwsTPFXLTKfS56afwSMDh7n?=
 =?us-ascii?Q?W163yF8FvwwYoJlJGTJOO247uult38MrFR1h+GWkLE0INh9KzDzShZ8c+Q9M?=
 =?us-ascii?Q?lavw6a+LmS+Vtu1J3NmMW9ATej1l4Qj5D41CZQXDH59XvV7SZYoB+joLClkE?=
 =?us-ascii?Q?yiYrOpHv7jOyUoZcM+1vKNndmTAMxzLMjmpNIiTtgMvF544VEvBOJByunk+G?=
 =?us-ascii?Q?7DFdGltFVHkK79sOJUX6MCkLo0QezZwO2IzdTJry0KTJuwUEHTSkNNCo6NzN?=
 =?us-ascii?Q?uSUOuV+G7EyKHMqhqzv/Bb7edvMX0mVTFzU6d8VyaaPjVLNz4Nc47eb4Zb7h?=
 =?us-ascii?Q?/0R6Xaa/cOJvl+VuX/UG4T33rWLR7l4tPenlfZ8WNCPBFwzI+yN4mNN2xSny?=
 =?us-ascii?Q?5QX9op/B8B8nhokGKSa08XPVEwL76L6+4p0ZUl1DlQ+rsfbL2fltIuh5e0TI?=
 =?us-ascii?Q?StzTAIb2VKHa2ZLVj/qQBVKC7VRJvPrKTGBmYGFpYja8l/JuAUQYM0dbugIP?=
 =?us-ascii?Q?o2djljUJWZGsnc9DbiVHNL3Dzw05sa+V5VxS0gcjUfCjUgQb45eOWaV0JdGf?=
 =?us-ascii?Q?WjlTTOxmOEYZvdyaBqYQvrDNFyDxh/a/M4DEHkofegmfQi6z6wz7uazlp6HB?=
 =?us-ascii?Q?rYvRq46y9hO3/A+MRRJbMQD77mlNxfyPpgtLi/X0E1OIaN+x/cPgpRmfEXMU?=
 =?us-ascii?Q?5mlGKwCPb5/8P8N+iqUeJfu+MIsQm3lsoOm/OSk8BHE+eQHhBrTsGHEY4tRd?=
 =?us-ascii?Q?o6tMVJzT1J8j+eUdUHNnS77AxjRDdQRkRnRcMJmC4R0j3HHPgSfmUGyCX43o?=
 =?us-ascii?Q?ODAgOlb+HTBYtd2uArk9tPz6AvSeyaZkFUCS1dklLdF/x0NcXdzcEHzEba8O?=
 =?us-ascii?Q?v/qxi9BpC+5en8SXkqwMwAIHwZI7T4cmo2SVwOkuKiRRysVkcEP20phmC0Ka?=
 =?us-ascii?Q?c/TpNImySP84wNeSKdkBXn9nZvL8N/j7CJZHO+ekFd1VVJ8AHRVQ4ZAmzY58?=
 =?us-ascii?Q?NC9C4zQ5otZGk776kDMGavbJJXc5LEkL3/jYey8j2PPyGKmueQDTvRQntYUN?=
 =?us-ascii?Q?Kw=3D=3D?=
Content-ID: <7349863D39B3EB43BC6F3D66BA631031@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR15MB1781.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc5e1e7-de94-4751-f818-08da7b048213
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2022 19:14:11.8622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XXhHu88GKVBlWh8aDVTfj+fCSdC0Mn6IUST6FvbgCR7ltmcwRrWNCcxmfii1s4Dv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4504
X-Proofpoint-ORIG-GUID: Pkj89g0bAbKe7q-CjUzysNMKaFW9C04A
X-Proofpoint-GUID: Pkj89g0bAbKe7q-CjUzysNMKaFW9C04A
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_12,2022-08-10_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 9, 2022, at 6:33 AM, Matthew Wilcox <willy@infradead.org> wrote:
>=20
> >=20
> On Mon, Aug 08, 2022 at 06:49:50PM -0700, alexlzhu@fb.com wrote:
>> +int thp_number_utilized_pages(struct page *page)
>> +{
>> +	unsigned long page_index, page_offset, value;
>> +	int thp_nr_utilized_pages =3D HPAGE_PMD_NR;
>> +	int step_size =3D sizeof(unsigned long);
>> +	bool is_all_zeroes;
>> +	void *kaddr;
>> +
>> +	if (!page || !is_anon_transparent_hugepage(page))
>> +		return -1;
>> +
>> +	kaddr =3D kmap_local_page(compound_head(page));
>> +	for (page_index =3D 0; page_index < HPAGE_PMD_NR; page_index++) {
>> +		is_all_zeroes =3D true;
>> +		for (page_offset =3D 0; page_offset < PAGE_SIZE; page_offset +=3D ste=
p_size) {
>> +			value =3D *(unsigned long *)(kaddr + page_index * PAGE_SIZE + page_o=
ffset);
>> +			if (value !=3D 0) {
>> +				is_all_zeroes =3D false;
>> +				break;
>> +			}
>> +		}
>> +		if (is_all_zeroes)
>> +			thp_nr_utilized_pages--;
>> +	}
>> +	kunmap_local(kaddr);
>=20
> You haven't tested this on 32-bit maachines with HIGHMEM, have you?
> kmap_local_page() only maps PAGE_SIZE bytes, so you need to map it and
> unmap each page.  Also, why are you calling compound_head()?  Surely
> you're already assuming that page is a head page here?
>=20
> (this is why I introduced the struct folio type, so you know whether
> a pointer is already to a head page and you don't need to call
> compound_head() again).
>=20

I see. Thanks for catching this! I have reimplemented with folio in a way t=
hat will work on 32 bit
architectures with HIGHMEM. Will send out v3.=20

