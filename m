Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F235987C7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245600AbiHRPsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244976AbiHRPsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:48:07 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF71BD0A0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 08:48:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nz8ZTnDJuqbJTB1HJnTTZ6ZMzfQmA4ct4z4GUo5B0c/aj3oE/EYIW3poB5phQ4dZNSse8VgJ7yuoxN4ybvKy8uN+GrIf4MVr9dLA8FjifkPe8bq1Jty6FuU/85iuUZC5UAmkqIxfyarcpT3ovYhD7fIamYV12504Me0Ejo4UlelcACuL+YICPxvhumBjhFUEiwqBVSwvNJSoHpQXfZy95zXdNpqBvuGJa/Yma/+8nRDNIo3lvTwmJZMAXxlelRJs9p3iPg081qup1CoiTFT071ndzMuZ51xPsMbkb6jNsIK8CDy2uip+wdRoIAcKT4yAgBiEBPjNjQemnoN7o1qOQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXaGk+ZovnWYF93nYuwsqOu+38HT8a3iYDsS+E93OJk=;
 b=ALEbVyB7wLwXRhDnw75eEuq2EfIFv/EmKOeOivSsdj0tqg9DzStqntGFN4FbGvp8C0qXoRT2XciXl3cBt3IqWqrAhFGY3ZJQxSgeK7OihzFtEA9AXfT8ydqWPnK6sspCbtivgQAx+JsCiLcR5jjEWJ6QNOUdLpHAQENtzd0pe8BHXz88srwNnjCF3GLUlr+i9p0nF5H1/BH0lsm9WXbZuFzVrwmP6J7Qanl7WdHsz/7Op0pFM2sKExKB6qxGtmpIeMetus+FnhnALhWhU39SLmFCKpaxPH7hPyPUMKIq61evNruvCnN+ObGxxUKR2+ugyZjteiy7iUHRflBeTV4OSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXaGk+ZovnWYF93nYuwsqOu+38HT8a3iYDsS+E93OJk=;
 b=ohqVxeRCL40In3dPxnSKKHECa87SsxPzgrQjUERwt7ZMh/uai9dynTYTqkUvAO9+dzhy7Tv5SJEapUNQYjHL7aHFyXM9YpTD9v6cn3X9Ur2QlD1M1TlkeyEEfCoEUnjZQqXtDN6BkK69rD22wImjoVW7NU7LvOOgu7UUSrEMQ1vTBrn4rA9TejnVOG8eL80dKPqD4NZzcm1szvZ6Qg5+XwVb+jWf5y3fwW4zOzQzwKqeo2ZuiJK39P3YXAb8yfqx0sLCCFDVUWH7l4jCVD027LrxdU1+Eyo+nkjr73FJfDU6/sUpjXq4xCwMT9+GCcpZbsFvbsxfcnIf2o48/reQdw==
Received: from DM5PR12MB4663.namprd12.prod.outlook.com (2603:10b6:4:a9::26) by
 PH0PR12MB5679.namprd12.prod.outlook.com (2603:10b6:510:14f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.16; Thu, 18 Aug 2022 15:48:05 +0000
Received: from DM5PR12MB4663.namprd12.prod.outlook.com
 ([fe80::b4ab:4d63:1cdd:b051]) by DM5PR12MB4663.namprd12.prod.outlook.com
 ([fe80::b4ab:4d63:1cdd:b051%4]) with mapi id 15.20.5504.025; Thu, 18 Aug 2022
 15:48:05 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2] nvmet-tcp: Don't kmap() pages which can't come from
 HIGHMEM
Thread-Topic: [PATCH v2] nvmet-tcp: Don't kmap() pages which can't come from
 HIGHMEM
Thread-Index: AQHYsmmGLgCwiZ0al0ia1vuDnnXkpa20zvsA
Date:   Thu, 18 Aug 2022 15:48:04 +0000
Message-ID: <8f3e0127-91d4-af1f-ba41-951e2c5050f9@nvidia.com>
References: <20220817184519.25141-1-fmdefrancesco@gmail.com>
In-Reply-To: <20220817184519.25141-1-fmdefrancesco@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74c27702-19de-4413-f6f5-08da81310a23
x-ms-traffictypediagnostic: PH0PR12MB5679:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hpObil1vdSV69TYUiYkzM4Z0htSxA8mXZuYf6bhYFJNgx+DUhfalD1oH1Sk7Y4hImiXzJl0sdrC9KZhcT3ocTAjYrPsJU1G8ugLE6whOBTGnIxKhyWcji1HzSJpyXZaD+wmOXqv8aFa+iTuFdUBVs3e0IDrkV2X2Uub0BnvswfNe8NIYMxa6bjzpFw2uAEbReP30YHKMgcO1TzmRII9JzfF+4DfrCXGMtC6yUqs8A0DZDjd+VIm3hbVbiaeCeGxQcazz360j7Wb+6XVCb0Mq3+MWHMZ/uqD3gjy5VwD7h3DSu+O2silF1RP9SbBFtM7++2zIon6Mb8sgos936N4Hmoq+zVCiiCYacx+sAexqN4yy6s2XtGWdWVbUK59efqL11Jt+Kz3tev8KRTziZ6UIh4Ar/VcOdi/Y08yfUIFMpxnR9R0baqauUra8Su5VWNuIpAMQIt1ojH2P4NfgJJO638xR3IKvL1CrEcrPJolxvKTLCXk/vVP1XNeSZRVLLhK9jmx0+NKm1keG98Yn/GgtV+wLf1mYCY50X3qhboNVoFz5d85rR8FbnQeK93GS7KXZjdkPT0ZigWR36SclgEe5RkctxwLRHVOJzpMPx9W02PSzn33GqfL5TIivdNlkpaCVcgYH57wFswrC64F/OGOvfzSi+uJWOzrgwfAPrH6bC+wqGgIIopoN1/ORux3nset2tQ/a4OuV9g90GQKAwDZ5JinrUY870sX6s8J/wPPWd/y3RuQfH5E84ZpVs2lphueXCqZYNYGTA26Ha8uAiwyuMzqHRrEIHOuRSSxb9XvrQmEc1QV/XUEX5kUDzCNcLRvSeh4ABseWrL9w0h3KVk/j0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB4663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(6486002)(478600001)(71200400001)(2906002)(86362001)(54906003)(558084003)(38070700005)(31696002)(31686004)(91956017)(41300700001)(6916009)(316002)(36756003)(2616005)(38100700002)(6512007)(6506007)(186003)(8936002)(66476007)(66556008)(66446008)(8676002)(66946007)(64756008)(4326008)(76116006)(5660300002)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2pzSWFBTmFsS25tWXUyRE93eUdiVC9sZm13MkpxTUNXUTNxdVBmbmFKZVhz?=
 =?utf-8?B?OHMzeWFxTEN2cHQvM09MdUEvQTZxZnN2bVl4Y2k1OEI2RzVnTXlJUUJseUZE?=
 =?utf-8?B?aFNZNTIrYUdqMTliRHpnVFZ6T1JlaC9hcUdjazlmZHkzQllTK1hRL2hzakMr?=
 =?utf-8?B?bE1tZEkyQ2ZkWldrMjlRS2JTcGltTUs2bklUb1dUamlzcUpUdnlkRS9CMnlW?=
 =?utf-8?B?REtyWUEwMktpTU9rYVM4ZDRZRlA5WnJoOEpvdU8xYWJlOG92UEordXRpOU1r?=
 =?utf-8?B?NThHYzdkbmdma1pMOVdEeGxocWQrRDZraGVjVWIrQmFTMGRrTlIvVS82WGlR?=
 =?utf-8?B?bktDK0hsYitjQ25IVUNHOS9MekNPclZiMWJWV3hrNXBjU1pGbnlOZkNiRS9j?=
 =?utf-8?B?QXJ2WUsrQ3RDTnFhMVgyQU9ZVStMNlFkdFcxZnpCN2hFWjdNaUt2YjhYb3RG?=
 =?utf-8?B?L3VpakI3QmxjakRtMCszSFZUZHBUczdRbkE3NE4vTGJVNVRUYnhjejJBTjZw?=
 =?utf-8?B?RG0vN09LYWFZVSt6N2hHQml4V2RkcE9ua0F4ZjF1SHc3VTBWd0pxZUFrWWJC?=
 =?utf-8?B?bzZJUEhia1pQdllkUDRkUVBTUkdnTFpSRmF2TVUxckxIUStQcUxjQmlCN0pn?=
 =?utf-8?B?emtqM0RrbmNISFk0RXNTWHJMQTNyOTZIMzdjZ3hvVXJpV0hYQy9KYTJjWHRk?=
 =?utf-8?B?ZmpMRi8zb0xXQ1h3NXkxcGZ0M0I5d3FFWTZmcVQxVFU5SERvYjIvVEtVRk0y?=
 =?utf-8?B?OFVGQXBHVmM5dVk0b3dveG4xMm56UVF5cFMwUjlOeUFCVU1PTDhHTm13cTRu?=
 =?utf-8?B?b3dVaFVlU0xuMGdFT1k3Sk8vMzFCYjM1alRaMXlJUG9DRVg5SlNkallqZzlD?=
 =?utf-8?B?clhhWDRmKzV2RFkwT0p3TEFiVWhHYnMydEt1bFp2OWY3RjQvdEFscnJxOWd5?=
 =?utf-8?B?d1FObUpzZExYWmZVRm90L2NuMkJLalRRS2toVEh0RjJZZi9iNXcxKzFxdDUv?=
 =?utf-8?B?STEyQUdURWFsbEs4ZnZyb0V4eG9DZjRQZVpuNlJHOGQ0ZWU0S1lvTkwwTFV1?=
 =?utf-8?B?TUlUMmxrR3NSNEJ3UXlFSGd5TnNZSmRka01QZ21JMEYzTzF0WHhVUHlLbW9Y?=
 =?utf-8?B?aDgrb205Z1hZYTgvT09qVTJkZHRKMDhzUnJDbElKc0dVN1NxSU0yR1VzRmRv?=
 =?utf-8?B?WnRPYUNBUzgrZXNUZ0hiTy9LZmszK0l4VWJiclFQR2RpL3U2cU5ncFZCc3hM?=
 =?utf-8?B?R2ZVN2I0bGhwM2c4YzJWZlpkZGVCSkpEMmc3TzdPNlJQcXFXUzdDNHNGczlO?=
 =?utf-8?B?T2MvL0hCbklKZU4wNGIvc01La0JZWE9EZjgvNXkvN3MydldiM1ZoL29BeHcr?=
 =?utf-8?B?cVczWVhYSGlqQnBTMFZwTVBZQzFkd3phK3NvZ3RLUTEycDVKRTQrK29UNXVP?=
 =?utf-8?B?S21PUmsxaUlxS1VSM0tRTGIyQ2k4NGl1Mk5ETGZYSUdWWUY2cHdzcVhJbmhi?=
 =?utf-8?B?VFYyM3F4TFJUOXhTQXZzYVB2N3pXYXovQ0lYOUJqbGsranQ2akZncTJrUDdu?=
 =?utf-8?B?d29CU01UNk1aZHFySzV0elhLL3Z0QldacGZMbk1NeGZtK3h3TFBxUjJuNWF3?=
 =?utf-8?B?TlJjL1V1OEFhQkpxVkZIWmRWdzA0MVF3LzdBOTUvdGFCek5UU0hWWnprbUo5?=
 =?utf-8?B?T3FHOTdrTkRRcUFjaXU1MlQ4QlE1cURQaThRWFcvRnltYjJpZ0txZzNLcWdn?=
 =?utf-8?B?WDZFR21vWTAxMC90ZWI4UWtkNjJsZ0pEM3A1N25ldnFTL3hia1ZHWCtrWUh2?=
 =?utf-8?B?WVZsektoS0hsaEFEbUFsOUNvVVRMeUFkWUFzSng2am03YmRQUGVydTFJVFh1?=
 =?utf-8?B?MkUrRW5QMU0ydDFBOUJlT3ZCNXV3MjJUeDBra3BvbVdrMzMyb0ZjcEpnYTR2?=
 =?utf-8?B?UnNiNldqYkdWWmhjYU5HK3Jna2xpcFh1ejhuRGxZR09uYitwSjJCVjNTUmhh?=
 =?utf-8?B?WWpObHlEUGVmSXl4NkxQNnRFbHNHWm5JdlQ4NHFPTWIyMnpxMEFkRmMyZnll?=
 =?utf-8?B?VlIrcHJTZjdtOFd4WExNUndWN1RWcFhLS1FhYnFIUmdSS0dWNEJtalplMzhw?=
 =?utf-8?B?YUlrWTcyelQzOGE1ZEo3UVUwRWgvaXo1ODluY1ViVzhxWGdKQWkvYThNVlNU?=
 =?utf-8?B?Q1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6182518E7D468141B4CB111214FF2ED1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c27702-19de-4413-f6f5-08da81310a23
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 15:48:04.9543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h/8d8M751b3gTVxRcoWkD74mn/lnysp7zemScpiewbdRqytgqAF34Xzndxyi/CFA6TVombclmcWGO8zVnKOqvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5679
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0JaW92X2l0ZXJfa3ZlYygmY21kLT5yZWN2X21zZy5tc2dfaXRlciwgUkVBRCwgY21kLT5p
b3YsDQo+IC0JCWNtZC0+bnJfbWFwcGVkLCBjbWQtPnBkdV9sZW4pOw0KPiArCWlvdl9pdGVyX2t2
ZWMoJmNtZC0+cmVjdl9tc2cubXNnX2l0ZXIsIFJFQUQsIGNtZC0+aW92LCBucl9tYXBwZWQsIGNt
ZC0+cGR1X2xlbik7DQo+ICAgfQ0KPiAgIA0KDQpvdmVybHkgbG9uZyBsaW5lcyBhYm92ZSA/IHdl
IGFyZSBrZWVwaW5nIGxpbmVzIDwgODAgZm9yIGNvbnNpc3RlbmN5LCBjYW4NCmJlIGRvbmUgYXQg
dGhlIHRpbWUgb2YgYXBwbHlpbmcgcGF0Y2guDQoNCi1jaw0KDQo=
