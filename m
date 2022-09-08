Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76595B22BF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbiIHPqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiIHPqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:46:49 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D05F9F84;
        Thu,  8 Sep 2022 08:46:47 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288EnC3n010185;
        Thu, 8 Sep 2022 11:46:32 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jc0s7erx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 11:46:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tk249p1ctmRa5Mo6R3QZdRssPI30Uo+E1tGlUJcGOgN4D23cp6hdtwhiisxikC2ZVwkApp6GwFNCpYLQ62mWiAYlUlioJSDGxAn10p/fQQqTk1U+yach61jT/NKKPxlrv2HOge3z77MVs7wND6W+cSTaFk69hC+1ER02t1hEsAWSRVTFIJIbFdSLsploTTeb9T4myxyYnvWUIHM+YT/POZfZzcNKGH5K8WB3uMqNKoJFL0ivdxKIu45bhI/HuUiqYFNwWjA4ny/t0n2ib5MKSnIBI2iVAAu+KH4txR6u68WP0pi+TAlPRvNeLQbBaWto/nHt3k3F0tqnIHKDt51ofg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jATbgJrk9SguV3pEMH79oZonwpUvk+XNlTGrRZ+accU=;
 b=iuL7BvHt1+5UQI4OczB1tT64BGouAxy6WQfQjGOUPNLhfzWlkrnxBsk5K0nJvywQqIw6JhWgU94q/Fe7jjM15uSPtufYR9lV9xtaHjfYYLtM2ZdOKAFy6MqvFk1OeBw+Jm+gQqu8TY5g00RXxS0q0zaadPDq62ycIx9QiWjpZjfck0Lst+6EhvQmJ3tPkqw9DcVEBkbfmt/eDTMLK1S7YuBS1RFG5YIpFYnJvrHgbcsrZyGaj2oegR9rxKBsuyTn+sgyIy+WIrQV01A/GxJZ0gU1hEA88WRA529X2OcjVN7KomDrI8FyFIinFZhuLNu7aOUO0rP2AJZdjy6kA9/47A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jATbgJrk9SguV3pEMH79oZonwpUvk+XNlTGrRZ+accU=;
 b=Jvjkv0uAMv3AaYCMpoWOhIZbd4U/IeFdmyjPdVIzMpWtsc+5x9ml1hJhWauhJ9O+3dHPbh6CEaWL+y49CGe/1C4o3y1PaGzcfVe7i4YelF4/wTg5+n0LbGbAUs/TbLeBdB5+AIL3Jc1zPVQ9lJ7AkwA41tcn4oq1wBVL+yJU4pk=
Received: from DM8PR03MB6247.namprd03.prod.outlook.com (2603:10b6:8:3b::6) by
 SJ0PR03MB6533.namprd03.prod.outlook.com (2603:10b6:a03:386::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Thu, 8 Sep
 2022 15:46:30 +0000
Received: from DM8PR03MB6247.namprd03.prod.outlook.com
 ([fe80::781c:6cba:d36:2971]) by DM8PR03MB6247.namprd03.prod.outlook.com
 ([fe80::781c:6cba:d36:2971%5]) with mapi id 15.20.5612.019; Thu, 8 Sep 2022
 15:46:29 +0000
From:   "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "jdelvare@suse.com" <jdelvare@suse.com>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RESEND v6 3/4] dt-bindings: hwmon: Add bindings for
 max31760
Thread-Topic: [PATCH RESEND v6 3/4] dt-bindings: hwmon: Add bindings for
 max31760
Thread-Index: AQHYw1xz8IETmAhuAEKUmm2GnBHkEK3Vp6WAgAADWqA=
Date:   Thu, 8 Sep 2022 15:46:29 +0000
Message-ID: <DM8PR03MB6247E3770CF8C2A20A47E45E96409@DM8PR03MB6247.namprd03.prod.outlook.com>
References: <20220908082358.186268-1-Ibrahim.Tilki@analog.com>
 <20220908082358.186268-4-Ibrahim.Tilki@analog.com>
 <5d36f4f2-f67b-32c3-ff6a-937b2e4723fe@roeck-us.net>
In-Reply-To: <5d36f4f2-f67b-32c3-ff6a-937b2e4723fe@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYVdKeVlXaHBiUzUwYVd4cmFWeGhjSEJrWVhSaFhISnZZVzFwYm1kY01E?=
 =?utf-8?B?bGtPRFE1WWpZdE16SmtNeTAwWVRRd0xUZzFaV1V0Tm1JNE5HSmhNamxsTXpW?=
 =?utf-8?B?aVhHMXpaM05jYlhObkxUWTFNMlF6T1RnMkxUSm1PR1F0TVRGbFpDMDRaVFU0?=
 =?utf-8?B?TFRkallqSTNaRGN5TXpGaFlseGhiV1V0ZEdWemRGdzJOVE5rTXprNE55MHla?=
 =?utf-8?B?amhrTFRFeFpXUXRPR1UxT0MwM1kySXlOMlEzTWpNeFlXSmliMlI1TG5SNGRD?=
 =?utf-8?B?SWdjM285SWpJMU1qa2lJSFE5SWpFek16QTNNVEkxTlRnMk9EWTVNREkwTkNJ?=
 =?utf-8?B?Z2FEMGlVMXBvU0RWUFVHOHdSbUV3TWs5TkszQldNbUZSTTJwcU56SlZQU0ln?=
 =?utf-8?B?YVdROUlpSWdZbXc5SWpBaUlHSnZQU0l4SWlCamFUMGlZMEZCUVVGRlVraFZN?=
 =?utf-8?B?VkpUVWxWR1RrTm5WVUZCUlc5RFFVRkNSVlE1Tkc1dGMxQlpRVlJ3YWtwTE1u?=
 =?utf-8?B?ZEdWR2MwVDIxTmEzSmlRVlpQUkdkRVFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVoQlFVRkJSR0ZCVVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVVZCUVZGQlFrRkJRVUZZTld3eVMzZEJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGS05FRkJRVUpvUVVkUlFXRlJRbVpCU0UxQldsRkNha0ZJVlVGalow?=
 =?utf-8?B?SnNRVVk0UVdOQlFubEJSemhCWVdkQ2JFRkhUVUZrUVVKNlFVWTRRVnBuUW1o?=
 =?utf-8?B?QlIzZEJZM2RDYkVGR09FRmFaMEoyUVVoTlFXRlJRakJCUjJ0QlpHZENiRUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZuUVVGQlFVRkJibWRCUVVGSFJVRmFRVUp3UVVZNFFXTjNRbXhC?=
 =?utf-8?B?UjAxQlpGRkNlVUZIVlVGWWQwSjNRVWhKUVdKM1FuRkJSMVZCV1hkQ01FRklU?=
 =?utf-8?B?VUZZZDBJd1FVZHJRVnBSUW5sQlJFVkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVZGQlFVRkJRVUZCUVVGRFFVRkJRVUZCUTJWQlFVRkJXVkZDYTBGSGEw?=
 =?utf-8?B?RllkMEo2UVVkVlFWbDNRakZCU0VsQldsRkNaa0ZJUVVGalowSjJRVWR2UVZw?=
 =?utf-8?B?UlFtcEJTRkZCWTNkQ1prRklVVUZoVVVKc1FVaEpRVTFuUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVSkJRVUZCUVVGQlFVRkJTVUZCUVVGQlFVRTlQU0l2?=
 =?utf-8?Q?PjwvbWV0YT4=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR03MB6247:EE_|SJ0PR03MB6533:EE_
x-ms-office365-filtering-correlation-id: 885e0543-6b3a-4079-1457-08da91b14c0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9fBfwy7b9vjRHY8c5aRZ59gyL8kcRNSrMwCaqn2G9Ohsm92aUHZ9/k3A7TYB6Xav0emnRrStXvS6cB0IZDgQNeeb3UiWw3MWGP1OsgZ2j8ZVijEJZ2KeuEFsCzZtVgXTjB0V8yBtNr7Zn/SuCc0htzgMfG3iv70PFuMXzVPCfk9zpW7TBZuvWxim104SBx2Rgtuot+m/n0OUaezf0DlokABDhhykuk8k0peKrWbZuAIV838CVhbBOZ4JOi3bS1UFGK258VWWzG9CTv/ZHRCXmwt1DseEfWqNhcqo0yn5oBzqPXNgS5sgEHsTe6TcmewJepMO7S5pT3bZUSEDsz0O01NeazInFBRqBdXctgIW4s4J/R2zXofIjsFPKCrJ7TSr/q8jBTVvximHXA7K/ITGODzS9WTw2seJW3Wnc2IGUjXTfNpnj9cbvJKDiwuGrDS7yIGYIBWl0BVrCZD2J1QHVL6nRcL7o4R0teohGyUHcPuSqxbYx7dsIHsBHmFdN+g45rziD1CPxavBxIfPIggMFc2wRQQQJuk8+OrYN0tyPWq+df3eBggYjpsvNmz5O5SwbLrLqXl0AHbic75L9QSyAaRgadgxQF6rACqSrOyZSo31KjcOTFS5kH39s9nVoDmbWJgkd/tzXvKcWrsm1yF66ZGFmu9Yd1+ayjdbl7jQemfuxwHKiCV2OsiV1aA9Rhw/+yf/oEtqjKypNl0MfYnaiRjSBP7U5QqtNiOsC0ePKzH/Umz1USVVy05LQLpQ+V8YG9MEE6iZmZxJyFJh8Q1ncplqrxgUV8Ij9UCbYv/usYZ6NJuM0faM3rpApj8F2Lj5tco/joHgWx0RqNpzp2DjUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6247.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(86362001)(55016003)(38100700002)(122000001)(33656002)(186003)(4326008)(52536014)(5660300002)(316002)(54906003)(110136005)(66556008)(66946007)(8676002)(66476007)(66446008)(8936002)(64756008)(2906002)(76116006)(38070700005)(71200400001)(53546011)(6506007)(26005)(9686003)(7696005)(478600001)(41300700001)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OW9BTFZaNENPR0dTVjcxUjgxaHd3V1B6eE9tc3F4cWlDZWZEUGlCdE1iaW0w?=
 =?utf-8?B?ZExNMnZMRFJ4QTFRQmtMRFlEVENIcWc3dFBlZXZZcDc2a0x5ZG9xNUtKZm9C?=
 =?utf-8?B?OUVFaitNdWxMZUVYcTViS09WeDJkbkpkYmhxSlpMb3ZKSHNYQ2VpQlY2UVNs?=
 =?utf-8?B?TW9NU3dQaFhDQzBYNnFBVElub0MydTEvVVdPSWtxbExBOVlUa0pQQzYrMTN1?=
 =?utf-8?B?V3pMczd3T00xU2s2RkNoZXV5bW50Q01UWFhGNlBBWlJpaUJvUWhRM0FnM3JJ?=
 =?utf-8?B?NHlYa0RCK0lHc3hldW1BM0J3N2wrOUt5Tjdtem5UY041WVhqeGRDdUEybUZY?=
 =?utf-8?B?Z1UrSTYyckRXSGJDcTFwc0lyY2tEWDVIdTE1UVY4b08xc2JBRWV5WkdMQU9x?=
 =?utf-8?B?NjVKQnM4NUtJNnVPNy80ZVk5c3Nva29rdkgzNUhJZTJGR0pBWmYyR2hLUkdD?=
 =?utf-8?B?YUFBL0JWVnJXWmhoMGdBTjBZU0tLT2FNM2dDNVpVRVFnNHE5aFd2dHFlZGlI?=
 =?utf-8?B?Z3F3cG41N21ubmdTVTNQekRjMktobHRlQ1hnd2ZNS0Q0Sy9QOW5HUnhvRDBw?=
 =?utf-8?B?NWptUldvYzBMSG1HWU9tWDBkT2JsbDJKQ2JzZjVEdFJNUTZmbUlaSGh2Wlky?=
 =?utf-8?B?R0ZKSjcxaEZIUW5jd1p4UTd0aE9Zd0h3a3V6a3NvclcxZVBQam5qVDVFdXlv?=
 =?utf-8?B?NlNsZGplRDhiNngwK0xRV2kyMXR3YmcraUNYMkE2MkdZb3ZDcmEyN3dNY2Rl?=
 =?utf-8?B?a1BWaGRKTWVBNzRCdzdkRy9PSkJqYytOU2RyaG0wL3V1ZmdldkF5dDk4MDJH?=
 =?utf-8?B?Q1d3UzRDRi9VWVFUOHQrNVZlTzZ6SjhWbWlDSHozQ3VkTkw0TkVkbEl0UFFW?=
 =?utf-8?B?U3E5dk5wU3NHcmtkMmhEbUJpVHhwcjRuNko2T2UvNW9LbWYzcVkraFFOZ3V3?=
 =?utf-8?B?SHFHVTRRQTJaODZXNzBJK2hsbk1KYlFEcWxXeDl6d2duTURYUGtXTzNYQzJJ?=
 =?utf-8?B?UVMxRURNaGhWbDl2Vis5MmN0YzUrd3FQajR3Y1hSSW9BSSt5NmxwQk1DOEov?=
 =?utf-8?B?NUo0NEdpcy9hdFhuWU5lb3UwaXBLS0xQc2lraExvVEExNGxIWFRncmNIUUhC?=
 =?utf-8?B?aU9panFyZjNSYmtZT0ZFL216aHZ1YUt6TE0yU0VORGlGS3dsb0UrUmFMbCtY?=
 =?utf-8?B?cVJ5em1BN3dlNTlyR0dPVVpsQjBQVkp3dWZEMXlUSXYrS0dwbXQrNmVsZTcz?=
 =?utf-8?B?TVBwUnBkRkpnOG1IZ2lnbGhqeHBRc0c2SlBQZ0prUVBRN29GUFRCNnVzS0Nz?=
 =?utf-8?B?cVcvRDFFSEJHQmZwS2EyVDZPb3FJS3BOTzEzc2Z6dVBiUjZ0R3BjNEFPMG1o?=
 =?utf-8?B?b0hYTEw3dVJhTVRYaTBySld1d1ExRUZCWnpQK3VjU3BjWXAzOUN0bnh5Tzhw?=
 =?utf-8?B?SUp2Y0dsQlVheHpGSkNPd0g4d25ZQkloK3BNRkFQamtUbDY0Sy9YSHpKMUU2?=
 =?utf-8?B?cis2d2xpRjZ2aURTVGZGUnUzRnk2QmRpVFozbkJRNnRTZU9kZUorMGU4eFRW?=
 =?utf-8?B?V1ZrbDZXc0dhdXNiT1FNOUZFSDR5OFBQVDdFU2oxSTVOYjlrSEtkd21JY1JR?=
 =?utf-8?B?dzdwWW1WRXNDMERWYTd6eXFEZVlqU2g4YkIwanFRY1l5NzZhRXBQa05ySFZm?=
 =?utf-8?B?elVjMUVJQVkvYjQrS2p0S1MzUUkvY0Q3cGlwcGNlR0g4elNKRU8zNTJxeUl2?=
 =?utf-8?B?UHJEN3AzdGk4Y0FYZGU3VXpCelJiWkRvc01wN1FoT1A1dlJRdHd4ZVFla1A3?=
 =?utf-8?B?azFuMUhOQUVhRk9lbnJSUU1NNWoycU1MbGt0a0pXY0E1MUpNRGRYUFlYZTZn?=
 =?utf-8?B?NENrYnllK2dWZXBjdWtGZUJjVzBMQTZaeXZPT1BNakd1TlVxdXd5NFNMQzdS?=
 =?utf-8?B?UEk2bUxjQ0VvR1F3ZldsVzdVOEdScDh0LzQ5d0FXa3c1UHdYOFhQVjZDZTVE?=
 =?utf-8?B?SmpjVmFFZVpjaFJkeWNaTDdpZElpcytiaHgxSm9YQnZDQ0ZYTmxXbWxkVG5u?=
 =?utf-8?B?T2VlVTc2SkduUis0YWxVd1BLakZyZHowc3ZCc0JGa1dveElXQ0xwd1NraWJF?=
 =?utf-8?Q?QvBlL/V3kiH6ce9EbMPNyOFFW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6247.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 885e0543-6b3a-4079-1457-08da91b14c0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 15:46:29.7264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TqPS3Us6tGXqTWQLCX1CiQ/PMKAv+XRh+Ih7gAl8SdYTTqLCFjgH/eUtcTvMP1oEUBdNM3qta7hYwrc/PLwxU0MvZUVTuF9DVQT3dfsHoNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6533
X-Proofpoint-GUID: u9qkvBCSXIoXLebnN3acaX5Y36YFhM8-
X-Proofpoint-ORIG-GUID: u9qkvBCSXIoXLebnN3acaX5Y36YFhM8-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_10,2022-09-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209080057
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIDkvOC8yMiAwMToyMywgSWJyYWhpbSBUaWxraSB3cm90ZToNCj4gPiBBZGRpbmcgYmlu
ZGluZ3MgZm9yIEFuYWxvZyBEZXZpY2VzIE1BWDMxNzYwIEZhbi1TcGVlZCBDb250cm9sbGVyDQo+
ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSWJyYWhpbSBUaWxraSA8SWJyYWhpbS5UaWxraUBhbmFs
b2cuY29tPg0KPiANCj4gVGhpcyB0aW1lIHlvdSBkcm9wcGVkIHRoZSBtYWludGFpbmVycyBmcm9t
IENjOi4gV2h5ID8NCj4gDQo+IEd1ZW50ZXINCj4gDQoNCkkgdGhvdWdodCBJIG5lZWQgdG8gc2Vu
ZCB0aGUgcGF0Y2ggdG8gZGV2aWNldHJlZSBsaXN0IDxkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
Zz4NCmluc3RlYWQgb2Ygc2VuZGluZyBkaXJlY3RseSB0byBtYWludGFpbmVycyBhcyBwZXIgUm9i
J3MgcmVwbHkuDQpTaG91bGQgSSBhZGQgdGhlbSB0byBDYyBhcyB3ZWxsIGFuZCByZXNlbmQgYWdh
aW4/DQoNCklicmFoaW0NCg0KDQo+ID4gLS0tDQo+ID4gICAuLi4vYmluZGluZ3MvaHdtb24vYWRp
LG1heDMxNzYwLnlhbWwgICAgICAgICAgfCA0NCArKysrKysrKysrKysrKysrKysrDQo+ID4gICAx
IGZpbGUgY2hhbmdlZCwgNDQgaW5zZXJ0aW9ucygrKQ0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0
IA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9od21vbi9hZGksbWF4MzE3
NjAueWFtbA0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvaHdtb24vYWRpLG1heDMxNzYwLnlhbWwgDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvaHdtb24vYWRpLG1heDMxNzYwLnlhbWwNCj4gPiBuZXcgZmlsZSBt
b2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMC4uMDAzZWMxMzE3DQo+ID4gLS0tIC9kZXYv
bnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9od21vbi9h
ZGksbWF4MzE3NjAueWFtbA0KPiA+IEBAIC0wLDAgKzEsNDQgQEANCj4gPiArIyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpICVZQU1MIDEuMg0K
PiA+ICstLS0NCj4gPiArJGlkOiANCj4gPiAraHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0
dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2h3bW9uL2FkaSxtDQo+ID4gK2F4MzE3NjAueWFt
bCpfXztJdyEhQTNOaThDUzB5MlkhNGp4WE9xZ1NMMkpEQV96aFZ4YTFnRGctWDNHdnR4bklTdXlJ
Sg0KPiA+ICswZnpfMEJsZmt4M3R6cXdJQ2dJVkh6SXhydjctN25Eb0NacVpnWUowT3RGUDhBJA0K
PiA+ICskc2NoZW1hOiANCj4gPiAraHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6Ly9k
ZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55DQo+ID4gK2FtbCpfXztJdyEhQTNOaThD
UzB5MlkhNGp4WE9xZ1NMMkpEQV96aFZ4YTFnRGctWDNHdnR4bklTdXlJSjBmel8wQmxmaw0KPiA+
ICt4M3R6cXdJQ2dJVkh6SXhydjctN25Eb0NacVpnWUo1R2VEZDVnJA0KPiA+ICsNCj4gPiArdGl0
bGU6IEFuYWxvZyBEZXZpY2VzIE1BWDMxNzYwIEZhbi1TcGVlZCBDb250cm9sbGVyDQo+ID4gKw0K
PiA+ICttYWludGFpbmVyczoNCj4gPiArICAtIElicmFoaW0gVGlsa2kgPElicmFoaW0uVGlsa2lA
YW5hbG9nLmNvbT4NCj4gPiArDQo+ID4gK2Rlc2NyaXB0aW9uOiB8DQo+ID4gKyAgQW5hbG9nIERl
dmljZXMgTUFYMzE3NjAgRmFuLVNwZWVkIENvbnRyb2xsZXINCj4gPiArICBodHRwczovL2RhdGFz
aGVldHMubWF4aW1pbnRlZ3JhdGVkLmNvbS9lbi9kcy9NQVgzMTc2MC5wZGYNCj4gPiArDQo+ID4g
K3Byb3BlcnRpZXM6DQo+ID4gKyAgY29tcGF0aWJsZToNCj4gPiArICAgIGVudW06DQo+ID4gKyAg
ICAgIC0gYWRpLG1heDMxNzYwDQo+ID4gKw0KPiA+ICsgIHJlZzoNCj4gPiArICAgIGRlc2NyaXB0
aW9uOiB8DQo+ID4gKyAgICAgIEkyQyBhZGRyZXNzIG9mIHNsYXZlIGRldmljZS4NCj4gPiArICAg
IGl0ZW1zOg0KPiA+ICsgICAgICBtaW5pbXVtOiAweDUwDQo+ID4gKyAgICAgIG1heGltdW06IDB4
NTcNCj4gPiArDQo+ID4gK3JlcXVpcmVkOg0KPiA+ICsgIC0gY29tcGF0aWJsZQ0KPiA+ICsgIC0g
cmVnDQo+ID4gKw0KPiA+ICthZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCj4gPiArDQo+ID4g
K2V4YW1wbGVzOg0KPiA+ICsgIC0gfA0KPiA+ICsgICAgaTJjMCB7DQo+ID4gKyAgICAgICAgI2Fk
ZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gKyAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQo+ID4g
Kw0KPiA+ICsgICAgICAgIG1heDMxNzYwQDUwIHsNCj4gPiArICAgICAgICAgICAgICAgIHJlZyA9
IDwweDUwPjsNCj4gPiArICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYWRpLG1heDMxNzYw
IjsNCj4gPiArICAgICAgICB9Ow0KPiA+ICsgICAgfTsNCg==
