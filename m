Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD30B5A65BF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 15:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiH3N5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 09:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiH3N4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:56:21 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62491760D0;
        Tue, 30 Aug 2022 06:56:01 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UD3ajF031827;
        Tue, 30 Aug 2022 09:55:41 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3j7d1bhmjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 09:55:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAh6aJSI7qC+uH1OpcateicadAhL1u1bmyKr1NhMeEo35kYl1HENTt0AhIG912AnEjEKrXH+uKuG9zcRebgJBVKWFsWz7TYl3sPJlPVPxqbTn2nWQrRGf5v2INk9J0MFUguUuADIGbCIqjjvW5L6GmcFNcnsBOskhRxg0XE7tOA3zsTE6Rod6YiNqUh95oSTZ9YbIwCYlJcuIbClnVHYS4/JUROZTLVKMotj4zs5eAUelIK4T7ZPrj5YIinGvJiy8lv7oCbJ2UM5Hwq9VNsEV78F2ERSBVTIaGAQvvjk1cXhJGuxucNiLr1Dts5QFOqfkxOhfagVCBcaA3TG6BRdEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3v6H6odXeEncI6RsrwPAnfZa2qkUZA9PlyhmT6VUyg=;
 b=a1K78+g4kCWOd0D9o9BZ7kvxjJ44DmdLtwRiNCUzmDFpoLvgCrmyi7g2eMwb33l8LrmAXS6EdwxYCClz1ygCod/94ofyXJkW6IdLptBLYQCxxIJgG1ejGWVrAnAWKk8EecAdi0irSwfQi9K/A3/ij9Y1IjNLMlt/OTemaeBNxScqI8ONW3r9i8tHPtvKPXRwZ7ffJRZ9MulyKr/5WOhGO6oZC+ay5HiA4eCJsQRsPhIsR5XIY331qsF4dAJsA3cZIkzD7uUKIVsPOaR0BnKiNipcthk9KZIPSNUOKOYyf9IObv03k8hQzodNatnYoodLkTM63f4bXPZRCOhrV5y/SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3v6H6odXeEncI6RsrwPAnfZa2qkUZA9PlyhmT6VUyg=;
 b=2KrpOF70My7owZ2+ocj7O1nE/Xu9qDfvaVSuW7U6t5T50VCNLMhQ1Y4TBrnct0Q8M2cMoVjX1qWYFVlcIrICNnPURCRDGW++lPCVXY7NtqUfRZusJkhlrpuyNTLl1vz2HEoXfs4GSx9TuJzf1vKj4xbKqoQWNOMAuoJ+ZE80hiE=
Received: from SN4PR03MB6784.namprd03.prod.outlook.com (2603:10b6:806:217::17)
 by SJ0PR03MB5775.namprd03.prod.outlook.com (2603:10b6:a03:2d4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 13:55:39 +0000
Received: from SN4PR03MB6784.namprd03.prod.outlook.com
 ([fe80::6c7f:65b9:118c:7cbe]) by SN4PR03MB6784.namprd03.prod.outlook.com
 ([fe80::6c7f:65b9:118c:7cbe%3]) with mapi id 15.20.5566.016; Tue, 30 Aug 2022
 13:55:39 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 14/14] iio: hmc425a: simplify using
 devm_regulator_get_enable()
Thread-Topic: [PATCH v3 14/14] iio: hmc425a: simplify using
 devm_regulator_get_enable()
Thread-Index: AQHYtAEA9W3+BCv32EieMGPzk+WDc63HZFsQgAAUdgCAAA8LYA==
Date:   Tue, 30 Aug 2022 13:55:38 +0000
Message-ID: <SN4PR03MB678490A2B25A8B2E38EA99B399799@SN4PR03MB6784.namprd03.prod.outlook.com>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
 <8b1193fdefb231a6d721e2bded52c48e56039c20.1660934107.git.mazziesaccount@gmail.com>
 <SN4PR03MB678420C67AA8988CF706198399799@SN4PR03MB6784.namprd03.prod.outlook.com>
 <44f05a0b-01a7-775d-606c-d2f0ab94ae6e@gmail.com>
In-Reply-To: <44f05a0b-01a7-775d-606c-d2f0ab94ae6e@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE5tTTFNakJrTnpJdE1qZzJZaTB4TVdWa0xUaGlabUl0Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGbFhHRnRaUzEwWlhOMFhEWmpOVEl3WkRjMExUSTRObUl0TVRGbFpDMDRZ?=
 =?utf-8?B?bVppTFdaak56YzNOREl4Wm1OaFpXSnZaSGt1ZEhoMElpQnplajBpTWpJMk5p?=
 =?utf-8?B?SWdkRDBpTVRNek1EWXpOREV6TXpjeU5ETTNNalEwSWlCb1BTSnJZMlZKZVVa?=
 =?utf-8?B?U2VqaHRNMmd2Vm5nNFpWYzBLMkpZVFRCVldsVTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVUTRVWEZ2ZFdWTWVsbEJVWGcyVWtad1oxazBORFZFU0hCRlYy?=
 =?utf-8?B?MUNhbXBxYTBSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkVZVUZSUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRVXB5YWtwSlVVRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
 =?utf-8?B?bWhCUjFGQllWRkNaa0ZJVFVGYVVVSnFRVWhWUVdOblFteEJSamhCWTBGQ2VV?=
 =?utf-8?B?RkhPRUZoWjBKc1FVZE5RV1JCUW5wQlJqaEJXbWRDYUVGSGQwRmpkMEpzUVVZ?=
 =?utf-8?B?NFFWcG5RblpCU0UxQllWRkNNRUZIYTBGa1owSnNRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkZRVUZCUVVGQlFVRkJRV2RCUVVG?=
 =?utf-8?B?QlFVRnVaMEZCUVVkRlFWcEJRbkJCUmpoQlkzZENiRUZIVFVGa1VVSjVRVWRW?=
 =?utf-8?B?UVZoM1FuZEJTRWxCWW5kQ2NVRkhWVUZaZDBJd1FVaE5RVmgzUWpCQlIydEJX?=
 =?utf-8?B?bEZDZVVGRVJVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCVVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVOQlFVRkJRVUZEWlVGQlFVRlpVVUpyUVVkclFWaDNRbnBCUjFWQldY?=
 =?utf-8?B?ZENNVUZJU1VGYVVVSm1RVWhCUVdOblFuWkJSMjlCV2xGQ2FrRklVVUZqZDBK?=
 =?utf-8?B?bVFVaFJRV0ZSUW14QlNFbEJUV2RCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFrRkJRVUZCUVVGQlFVRkpRVUZCUVVGQlFUMDlJaTgrUEM5dFpYUmhQZz09?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9025342-5f38-4dcb-e693-08da8a8f522f
x-ms-traffictypediagnostic: SJ0PR03MB5775:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MLdowWPETtqhHVyWuiRKcWUBdU6hFhkN7bxDZeherUfd8E4cpKwgrFDeJaDxBYKSq2LEHED6rgxFBtuf13ZFkPpWxpLJrUA3H8IJzrGAgvZJBSKIrG3o5rPx33Clar9K06iYdjLiwKm4eJM09MMZglYMO4KPMLFg41aoArgAr9WC5f1FvohU4eh7oHYWKwMpx0D5Gxy4I1lSwCy5xGEU3se5t4g7ziNcIUh+aNI96HHzF2hYJ3WtA5CIiHyvNXySd1xwX6wjXEuciPo2aE5zsCm59HdzFiI3Im0Ea6xn/wL5Srp8nqCu2S3k1t7sF/mCemy4MbKt83Slsx640a3Vsju+N35DqVyi8IiBRGuK+FhKzBvpXmIl6sE+WJGwXg4XJhKnCFPto1pYpIhm6cp8SySzTUYcIkuXGxd0a+qCFsVs0pZ+kD+TOcD7bTF6rEr+Y/tJIgl95wV6esDhUdBg+s0uVFfCdJyQU/lWCTkK3b+QCAs9cn4GLnIo9pAOtPSAsSvh7MdxrDbHCijWHZfP2duOlNDLz8CaJI5C1lV8LRPKGvz5yqDSc9pwJ65dAnYUNLQ/z6+FqI9H7oo95k3nLR/HTYsBu4jHioptehJHNukut1okomndCnTCODhrmZZkmy0+YTd0lNGTtPOChjbCjpdR/b216dbswGOhbgBixNlIXPxFE2AK6QgzHy7+D9xEAhQJbRoStwsxd9yuHONPS0xteeej9V5Ghbbm+NJt3u+Qw0uT4SQm/QMX1phNSo1HM2jNZpKL5+/JLEhj6P1mKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR03MB6784.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(5660300002)(54906003)(110136005)(33656002)(186003)(2906002)(52536014)(316002)(4326008)(66476007)(66446008)(64756008)(66556008)(8936002)(66946007)(8676002)(76116006)(6506007)(71200400001)(478600001)(7696005)(53546011)(86362001)(9686003)(38070700005)(55016003)(38100700002)(41300700001)(83380400001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDE4ZDBDc1JVdXNuTmZMeE45Mk5aTmFZSU1JL0JMaFExWWVxaEFXRDlNeWh6?=
 =?utf-8?B?TWdtMXU0WjFNRFV4VDdQQWhOVHRMaGFYWTlGMS91QXNzSjVnWU5GYlMvQ2xs?=
 =?utf-8?B?RUhpblNDSUpLVVBqRHZoLzRkMmJnNnZ6Q0E1bTlUd21UVVFXdUVIV1NFbmNK?=
 =?utf-8?B?V1gzUTVLVEpWQzJSRW1PZjZweWVVMHJ3Mlplb0VuSDA5YWtBcUJjZE5KNzJn?=
 =?utf-8?B?MnpLQ0RvTExIREN2blE3aXhpcVdSS2Z4SDg2eGV5WWtWN1JRYStSQ3lkZi83?=
 =?utf-8?B?QlQ2R3ZNd0tPNFhMY3hIK0xINzduZ2NBYlEwaWwrdjljYUs2WVg4ak9aWEEw?=
 =?utf-8?B?WGEvQkthdUNhSXJRTEZBZUZ6WHFZMm5PVUhsZUZnZ2s3Z1MwOXVLVHNtS21J?=
 =?utf-8?B?Sm1wQTFyUEVLMjhGbmx5TmFTek81QUJxZkVtaUZMZVhDYXBsVSs1ZFh2ZzZS?=
 =?utf-8?B?Y1hvRmhTNHhqNXNXUTh3M0dlSUNpTUVPMkZ4anZGU1BiN0lKYXlRdStabkFC?=
 =?utf-8?B?WFRQOVE5NHJWTEx0bHVuTzRxV29aVFZDNUZEUVdlTnZacmNQSzNlbTNtVE1U?=
 =?utf-8?B?MFhidlUzQVNDNy9WTUpOdUhtZXNSeGJkMzhSNnBJaUpxeVBDWUFOSkpxSm9k?=
 =?utf-8?B?THhaS3ZTZ3F3WnJSczNaemhNdlhWcFFsSVFDOTZiZXNXTnZzNThRN1grS2RH?=
 =?utf-8?B?Z1kwd3Y3R09PeG9OeDl2ZXZCMWFlbGd3S3V2dGFFVnI0QzYzV0lKUnpTWG9u?=
 =?utf-8?B?bXpnV0ZtWnM1K3IrbXFDODZpeHF6VFJFdTEvN29QTkZlNXNITjlEU3YzbEtQ?=
 =?utf-8?B?QUd1eVhSVzdDNXYzN3prSHRnMFBnM2hTb2FEK0hJWFZLM2VRQVlRVkgxUkNy?=
 =?utf-8?B?eTJvbWRMZVk5VzdneU5mMm1KYSticHhZL3hXSlhUckxsdGxlcUowMUl1VEla?=
 =?utf-8?B?WFRsdHQ0cEtLZmZmSlVvYkpFdnFaSkdmRnN1b0ZrZ2ZacmVJMVVveEx4MjNX?=
 =?utf-8?B?aC9wY1BHa1c5OFNINHIzcGJIWG5PUjJ0ZHFmSFRnVGlmNWVIS0pIaW5IL1NT?=
 =?utf-8?B?a3FaU3VpQ0JWME5yMmFjYndBUlRTQVVLUXVaQlJuNXZiZEt5SjI1Qk1Ic21J?=
 =?utf-8?B?eGUzTHdDaHVBcGs3bmdrZ0F1QmhrYkorYWZwaXhlRGtvUGJ1T2tkVkxqaXRQ?=
 =?utf-8?B?WHY1RHdaQXJhNE0zZU5rYXh4a0NWZlBRbUZBRzdkRDI0ZlMrNGRvMUZ1dGow?=
 =?utf-8?B?R2hmMGtqYkFnU2ljOTJHaTZ0YktjekNqZ3hhaitDMGZoenFMNkVJN1hMdlpD?=
 =?utf-8?B?RGZyYWxiTExWQ0ptQ3hoNjE0RVphTTRQeExIS3RabjBJSGkvdUZsUUxqanFR?=
 =?utf-8?B?MmN2dlp4SExudjlBd0NGVFdYdEtEdE9HQzNYc0owblBrNVRkL2lGVjE5WDJ1?=
 =?utf-8?B?S3NvTmp3Z3VwNlVOWCtqTm1TWHJSeFY0cjJSNS9ZQ2FybDMweWh3bVE5ZTdD?=
 =?utf-8?B?Rk1xc3BzVlUzb25IN2pxblRZU1lMalhQNGZESUZ2ZU80eDBENlNnK0xVUVdL?=
 =?utf-8?B?dHY1bnhsYVpoRDM3dlZ5L040RkRtbzRHMit1cUZtKzRoM1NFSkxPL0I3Z0Vh?=
 =?utf-8?B?d3JhdlNlRkJRM2FFUEkrTExOeWVCMHU0blVsOUZBbkdDdnFOQUkxcERPNE9p?=
 =?utf-8?B?ckdiYVhKdEM1TGFUeEo2S1NIZ05ENnR1VVplWFR3S3ZpOE5RZm9nYVJvZXhB?=
 =?utf-8?B?dUpLVmt2ZHY2Vk5YVzZQV3NLSUFaL0FtQVNORUZIc0M0TU1NS1U3ekFINVBh?=
 =?utf-8?B?WUcvQ255Y3dobnFmaUkwZVJzZkxsS0JmSllueVdkTmx1YmYyRXl5U1kxWWdM?=
 =?utf-8?B?VlBIbUlxaDlFV0llUmFiUG5rWThmNk9GZ1FuRzkxQy9kZXBjWWt0bEZkMVJp?=
 =?utf-8?B?OUlsRW1qb2pyV1JIQzhEN1VzaGlLSGl2Z0ozZGZkTjFyS2pGVGhzTmFYNEpM?=
 =?utf-8?B?OWtRaVdmZ3VYclVLVWpLWGozb0FVbFJwT256aVluYi9Ud000dm9BMWFqbVND?=
 =?utf-8?B?dHpDQ2x2ajVrMHVKV1BHZkcxQUk4ZnVvcGI2cW8zSnhUaW1IVnRlazMwSkZP?=
 =?utf-8?B?ZjR1TEw2aFN5UHlRckxpbWR2em5NL0pwUTIwWXZRTVpmVVBiSWhYbUJTcG5y?=
 =?utf-8?Q?rnnCK+KOwmsC8Efec4/zndY6vHgZ16VX/eKIyr/datJO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR03MB6784.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9025342-5f38-4dcb-e693-08da8a8f522f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 13:55:38.9705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G/EI9SnCa3eymPj1X8qBZpxZBIZOk/dn5gpzk+eSbdhedIr7hrhOhpOkYoF861FDGRe5yijzHuHmjKAw8FDzfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5775
X-Proofpoint-GUID: s_Txyall5-2-gUjp8wM_GVjp7NI9xfA6
X-Proofpoint-ORIG-GUID: s_Txyall5-2-gUjp8wM_GVjp7NI9xfA6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_08,2022-08-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208300069
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWF0dGkgVmFpdHRpbmVu
IDxtYXp6aWVzYWNjb3VudEBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCAzMCwg
MjAyMiAzOjAwIFBNDQo+IFRvOiBTYSwgTnVubyA8TnVuby5TYUBhbmFsb2cuY29tPjsgTWF0dGkg
VmFpdHRpbmVuDQo+IDxtYXR0aS52YWl0dGluZW5AZmkucm9obWV1cm9wZS5jb20+DQo+IENjOiBM
YXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT47IEhlbm5lcmljaCwgTWljaGFlbA0K
PiA8TWljaGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNvbT47IEpvbmF0aGFuIENhbWVyb24NCj4gPGpp
YzIzQGtlcm5lbC5vcmc+OyBsaW51eC1paW9Admdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2Vy
bmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDE0LzE0XSBpaW86
IGhtYzQyNWE6IHNpbXBsaWZ5IHVzaW5nDQo+IGRldm1fcmVndWxhdG9yX2dldF9lbmFibGUoKQ0K
PiANCj4gW0V4dGVybmFsXQ0KPiANCj4gT24gOC8zMC8yMiAxNDo0OSwgU2EsIE51bm8gd3JvdGU6
DQo+ID4NCj4gPj4gRnJvbTogTWF0dGkgVmFpdHRpbmVuIDxtYXp6aWVzYWNjb3VudEBnbWFpbC5j
b20+DQo+ID4+IFNlbnQ6IEZyaWRheSwgQXVndXN0IDE5LCAyMDIyIDk6MjEgUE0NCj4gPj4gVG86
IE1hdHRpIFZhaXR0aW5lbiA8bWF6emllc2FjY291bnRAZ21haWwuY29tPjsgTWF0dGkgVmFpdHRp
bmVuDQo+ID4+IDxtYXR0aS52YWl0dGluZW5AZmkucm9obWV1cm9wZS5jb20+DQo+ID4+IENjOiBM
YXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT47IEhlbm5lcmljaCwgTWljaGFlbA0K
PiA+PiA8TWljaGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNvbT47IEpvbmF0aGFuIENhbWVyb24NCj4g
Pj4gPGppYzIzQGtlcm5lbC5vcmc+OyBsaW51eC1paW9Admdlci5rZXJuZWwub3JnOyBsaW51eC0N
Cj4gPj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+PiBTdWJqZWN0OiBbUEFUQ0ggdjMgMTQv
MTRdIGlpbzogaG1jNDI1YTogc2ltcGxpZnkgdXNpbmcNCj4gPj4gZGV2bV9yZWd1bGF0b3JfZ2V0
X2VuYWJsZSgpDQo+ID4+DQo+ID4+IFtFeHRlcm5hbF0NCj4gPj4NCj4gPj4gRHJvcCBvcGVuLWNv
ZGVkIHBhdHRlcm46ICdkZXZtX3JlZ3VsYXRvcl9nZXQoKSwNCj4gcmVndWxhdG9yX2VuYWJsZSgp
LA0KPiA+PiBhZGRfYWN0aW9uX29yX3Jlc2V0KHJlZ3VsYXRvcl9kaXNhYmxlKScgYW5kIHVzZSB0
aGUNCj4gPj4gZGV2bV9yZWd1bGF0b3JfZ2V0X2VuYWJsZSgpIGFuZCBkcm9wIHRoZSBwb2ludGVy
IHRvIHRoZQ0KPiByZWd1bGF0b3IuDQo+ID4+IFRoaXMgc2ltcGxpZmllcyBjb2RlIGFuZCBtYWtl
cyBpdCBsZXNzIHRlbXB0aW5nIHRvIGFkZCBtYW51YWwNCj4gY29udHJvbA0KPiA+PiBmb3IgdGhl
IHJlZ3VsYXRvciB3aGljaCBpcyBhbHNvIGNvbnRyb2xsZWQgYnkgZGV2bS4NCj4gPj4NCj4gPj4g
U2lnbmVkLW9mZi1ieTogTWF0dGkgVmFpdHRpbmVuIDxtYXp6aWVzYWNjb3VudEBnbWFpbC5jb20+
DQo+ID4+DQo+ID4+IC0tLQ0KPiA+DQo+ID4gQWNrZWQtYnk6IE51bm8gU8OhIDxudW5vLnNhQGFu
YWxvZy5jb20+DQo+ID4NCj4gPiAoSSBzZWUgdGhhdCBpbiB0aGlzIHBhdGNoIHlvdSBhcmUgbm90
IHVzaW5nIGRldl9lcnJfcHJvYmUoKS4gTWF5YmUNCj4gc29tZQ0KPiA+IGNvbnNpc3RlbmN5IGlu
IHRoZSBzZXJpZXMgYW5kIHdoZXJlIGFwcGxpY2FibGUgd291bGQgYmUgYXBwcm9wcmlhdGUNCj4g
OikpDQo+IA0KPiBJIGRvbid0IHRoaW5rIHRoZSBkcml2ZXIgZGlkIG9yaWdpbmFsbHkgcHJpbnQg
YW4gZXJyb3IgaWYgcmVndWxhdG9yIGdldA0KPiBvciBlbmFibGUgZmFpbGVkLiBJIGRpZG4ndCB3
YW50IHRvIGFkZCBhbnkgbmV3IHByaW50cyAtIGp1c3QgY29udmVydGVkDQo+IHRoZSBleGlzdGlu
ZyBvbmVzIHRvIHVzZSBkZXZfZXJyX3Byb2JlKCkuIEkgYmVsaWV2ZSBhZGRpbmcgbmV3IHByaW50
cw0KPiB3b3VsZCd2ZSBiZWVuIHNvbWV3aGF0IHVucmVsYXRlZCBjaGFuZ2UgOikNCj4gDQoNCkFo
aCB0aGF0IG1ha2VzIHNlbnNlLiBJIGZhaWxlZCB0byBzZWUgdGhlIHByaW50IHRoYXQgeW91IHdl
cmUgcmVwbGFjaW5nDQppbiB0aGUgYWQ3NjA2IHBhdGNoLi4uDQoNCi0gTnVubyBTw6ENCg==
