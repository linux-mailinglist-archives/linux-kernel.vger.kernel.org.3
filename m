Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1C1588CBF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 15:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237910AbiHCNNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 09:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237665AbiHCNNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 09:13:08 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAC7165BC;
        Wed,  3 Aug 2022 06:13:04 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=QT1ERpR4w3J/SrKCVabNVU65xo79gsV4zJPhirQW4B0BFH+UFfzFZn0VDehA5QvFXZxGnAzPwkLDB1G5xVw0gBTVUHd5Xc5LZVJXVuonv3DAg5kY+/JyCGiqNKwHta3e9ofNukT9Js6PMDHc0ob39jCAs6ddnviDANajSbqJexoNPP8yKgZGY8cmb1sQ2L/XgiRGwFl6gxeVl36/UlCow5uXGBKK7GTdPBGVtvE3s6hUvg6lZ/DHc4W9sDdY+rlf8fL0gJ38rZJXzXWND9mcOd6jm2AIgApbQuhnPf8EMxpr9fpQ93CkTAiCxoXg3tSEf/ZprlL3leqKclIt6GNkqQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJua4CRkGkjb0WX90QJ/EgcST9dbKAsp5Nt7xVHFdag=;
 b=TVHnyRVAiOAdGz/yGpAtkc1I4EMEAiS6n7f5nsgbrPf4NgCIePpzTBA5pTiimoF/yTVQ8fdIoMZmbx08jWplYu2LUJ+FrTXeUnpXjU0p7aEanDnS0rpfJWWAxJq/BI/hK6DJNJ0BKSXSlouZWS05OOkS0DuwGPZb3Pov65QGJ+RVHBoBrbpX/ZQGuQ0p3V20YstaLW30FxvUWBrmOTB2ILmRmWpAXJQg0jhOBGMIABLk04y0d37CfnO6d6J8LHmBPDag1kXWWWutjprwUGzrb0SEZqNyxHykWsgq7jUhbJLcIRHCnAEvFbC+zzbqno/n6Fvm7BsxOj3ov76ag6rg1w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJua4CRkGkjb0WX90QJ/EgcST9dbKAsp5Nt7xVHFdag=;
 b=Ti7BM+qqchTNcOeTPhA9rscrxpk61LNWJcXSEeLHzGQqXN9chPfag63PkuFjfVcl3GoxKr2hHXUFzfWWFuK+ZaAo6Dl59RrFYMi80orE0ohHxEYxhTyWR4s1m2quih6fTsGEldaFX3om+U4ZuQ1kDyv22GRsJ6wGRSozqj7/r3g=
Received: from DU2PR04CA0248.eurprd04.prod.outlook.com (2603:10a6:10:28e::13)
 by AM5PR0801MB1876.eurprd08.prod.outlook.com (2603:10a6:203:42::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Wed, 3 Aug
 2022 13:12:50 +0000
Received: from DBAEUR03FT063.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:28e:cafe::b9) by DU2PR04CA0248.outlook.office365.com
 (2603:10a6:10:28e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Wed, 3 Aug 2022 13:12:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT063.mail.protection.outlook.com (100.127.142.255) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.12 via Frontend Transport; Wed, 3 Aug 2022 13:12:50 +0000
Received: ("Tessian outbound 73dd6a25223d:v123"); Wed, 03 Aug 2022 13:12:50 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 947e47f3a6a58daf
X-CR-MTA-TID: 64aa7808
Received: from ea7f46e12334.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id DF972CD9-4384-4E61-A4AB-20322E4ECD88.1;
        Wed, 03 Aug 2022 13:12:39 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ea7f46e12334.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 03 Aug 2022 13:12:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sq9Li2MwxildXWKlRdly9tuMYQDtLd/m2Is7Nxw/UMwFjOPpab+5y1zhOzbOEnK3acD9m1XNqdztft4G+n5cqJu9jYqKGAJ3f05lZBg1rNPVYoa9AqRr8AX8xTfkTiREdahB4VuFsziOVCuWqYRub+VMawgAavbFTDUWWStAflPORMVTbPCtl25RlV+6qHZmAJegbyFHnTTwUaYWHuc5KkiZfBVy+2uOeEpXSUIdVkomraqOcbkvKp0wuClA+3rYN87T3QRwR1WTidAPacjGe/MQ8eEr1Byjt9IrKI8hxXPCYgeQrb8ZJAjtt6MqzqjP+fP2W93msz6qKQq0+IvN6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJua4CRkGkjb0WX90QJ/EgcST9dbKAsp5Nt7xVHFdag=;
 b=P1+jBQOgFo9wM4YvyWF+9Ot6VLCinlSKrFiK3ANYkZQQyU9X17JMNoI8pTSLnG8S/xsKh6CRic753lFU3xc3X18W2Gy9ljb9I3AfIxMfeJTI3GWn603suO4VGlEhmbhbq8u9YYfIJm6vwVZkP6dhH8/iRH7Y0J7HfgYfjaoZh6aKBy/Mx/PvR2lSg05EXc6YmyAe8R85EeZaPWki/VEDEXJQAx3k8V44QRB8/K5h9+Fm+HRp2Z3aF9bNz4WPxV8V2VgMXuC1hqvA6XvLP+9Wy5U/wzu2X9Y2UEWERcHX8Eg6Eh9b6sEYSnowAPCU9/bcBZ5dEavltU2NUiQUk3Iadg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJua4CRkGkjb0WX90QJ/EgcST9dbKAsp5Nt7xVHFdag=;
 b=Ti7BM+qqchTNcOeTPhA9rscrxpk61LNWJcXSEeLHzGQqXN9chPfag63PkuFjfVcl3GoxKr2hHXUFzfWWFuK+ZaAo6Dl59RrFYMi80orE0ohHxEYxhTyWR4s1m2quih6fTsGEldaFX3om+U4ZuQ1kDyv22GRsJ6wGRSozqj7/r3g=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by VI1PR08MB4574.eurprd08.prod.outlook.com (2603:10a6:803:e3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 13:12:27 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::95c2:18d2:e878:d541]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::95c2:18d2:e878:d541%7]) with mapi id 15.20.5482.016; Wed, 3 Aug 2022
 13:12:26 +0000
Message-ID: <a18f9406-fdc5-130b-0460-eb5ad75d8876@arm.com>
Date:   Wed, 3 Aug 2022 14:12:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 4/4] hwrng: virtio - always add a pending request
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org,
        amit@kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
        Matt Mackall <mpm@selenic.com>,
        virtualization@lists.linux-foundation.org,
        Dmitriy Vyukov <dvyukov@google.com>, rusty@rustcorp.com.au,
        akong@redhat.com, Alexander Potapenko <glider@google.com>,
        linux-crypto@vger.kernel.org,
        Mauricio De Carvalho <Mauricio.DeCarvalho@arm.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>
References: <20211028101111.128049-1-lvivier@redhat.com>
 <20211028101111.128049-5-lvivier@redhat.com>
 <7e64ce61-89b1-40aa-8295-00ca42b9a959@arm.com>
 <2c1198c4-77aa-5cb8-6bb4-b974850651be@arm.com>
 <20220803073243-mutt-send-email-mst@kernel.org>
 <33f0f429-491c-49da-bd2e-bf9f62cb3efb@arm.com>
 <20220803083406-mutt-send-email-mst@kernel.org>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Organization: ARM Ltd.
In-Reply-To: <20220803083406-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P265CA0104.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::8) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 0ea10cac-1f88-4092-6de2-08da7551de0a
X-MS-TrafficTypeDiagnostic: VI1PR08MB4574:EE_|DBAEUR03FT063:EE_|AM5PR0801MB1876:EE_
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 8esSzHDl3H5bC+1ftrCIipa+VWT44V3inOTXws3txkQVXqMbGmgwrhoVsLO991TUZmGTNOAig7zxY27yfZTRLNI6PkNjt6gY9xqsLpz2fb7z2LiUrVONgVKlQUwW7j3mqqO8oDcALzIbOI2kxS/ImjpQdpiAs2t4g2+Pxp6dvAOvR1JBd8gQ5RSxbdz2QM6jrgvLA/T92pnVcdU6W0FnF8Y7Wb1dsn3c56+ccppH5GF6xXENKhNE+ibShNwO/Hlu/QN4wz5Agr/kLrfL/eTFIFf9xPWEFSJ+KV5MnHCOBy9DbdP3VoKxTmNW8XpF8ZnbFQvU4UkZQPdiGnhhVtyBOBBa6RQ4r0WNXr2s2scwbNi1wtKHdmZtst7VQUbD2+pghtlfFQv9aYCK5G8Go3GgnjGEO9CbSVDIcMIR+wYyxQIyJU7/ULKg/2nMKitbGIi6p408dg96lkhQo4215aw3VcphEGT9uEkBZnlalEFfuHqYeboWJkJ5A3v2WSGmg/HJtYL41t96hCgxEi026DSXqlDAeRYooA6dZwQX7Pma1K1enjGkr+lEL6gcsCOwKqV1YDtKHH+MwJOQc0CvS049gfk7UEIBlF4gh4Yo1ySNKOUas5xPSfHhgco22idT8AqSmtNpumsSHar3i4hn49AOvJQ6flewH4B8Jipb9pyRYk5G5UyKY0WiAzP3LYnnuqawDH2mPUXt1O3sJduwOtWL7kbbP0c9gjyuRm3RSy+k/nKKBcqJGTi/v/6CUhIWnC6ZQo0bDNgdEeotIOZuZUKikh9Ysp7Fzu4xr0DTPRJ5q8s0xQnRceUBd7RwPobgj1FSPaqS7tRbNjRLX4nZWDO0zA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4070.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(6916009)(54906003)(31696002)(478600001)(6486002)(4326008)(66556008)(66476007)(8676002)(66946007)(2616005)(316002)(19627235002)(83380400001)(26005)(6512007)(186003)(36916002)(41300700001)(38100700002)(53546011)(30864003)(6506007)(7416002)(31686004)(36756003)(5660300002)(2906002)(44832011)(86362001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4574
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT063.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 919ace43-ae9a-47ff-1d88-08da7551cfef
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5IodrvxgXXNqFzuyvqLwvNRGbvRqCl8LYLsDVUD9asgldTR/jNIzwzX3OzvlV0ZkDNWJz+6TyynJTssf+lmT4Y2L5Km1bBNh1vclMNr2uZSvihcG4UviwLRotGpxTVsuSjH3HNLIzaX3sOMadhItTYuaKZVL5tjwFMkHD95jopapf/sYB2HM7XWQ0NOcTvS6AuGHAxfneMsEnWvJI9I1t4CjRkaJTaP49FXeadXbliESEGAkd+GhZK+s28dcxJMVh7aKmkk+JzY88AQlCHRGwB7GTiJIUbPPvaLtjxA7Z8HC/NeWcv5MW9scC5mwaOQnFKq7XDmkUA21TM+JJiMtBkWTZSC+QzryS4L7c8p1Wd1wdBOuwX4UX2sbygNXFCp7d1K+57lTM/UE+MxNV9VhePjgjvJC7iNHMDkB+uau0Rf02nf0S9NmpLjUPnZwnkjRqIGMT/zLd3Kl+ajGE+SGBOpNw81gYLEB0STVm9cZeBMFDeUQtGccT5RUJPn9pHxxf9kisURPYeQq06YzsgOWww0NH2zTjIHSAj29TyHAal29PYEPqzLNIy9ygZ2BvglbRH1bqS/lSCoYzZSGJ6W2yhyWe0f9wdVCguifPV5Ujj9BAuBTNgIPozlu8EhVhG/PeTWb1qo47va9nrgCCvH/b0z2f5cCUUmTun2ZQp49D4LSNTfemXE1l++7uBfXsafTNhBdYQqdKOGNcXVBMIT9Y18Skwm8+riiYUBLg2fklJUybRic7/K1Ij3clfR44ooCrhuzp0JZwR/DKXBPXuYUSTCfd+kPOVtiQrAc+saB7pKWgb1pUUWqD9MnyFp5UTfAU83FK0fClsEjmoSKhkk5wA==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(376002)(396003)(36840700001)(40470700004)(46966006)(30864003)(82740400003)(31696002)(40460700003)(6862004)(5660300002)(19627235002)(86362001)(31686004)(6486002)(316002)(70206006)(4326008)(356005)(70586007)(8936002)(450100002)(81166007)(8676002)(54906003)(40480700001)(6512007)(26005)(36860700001)(47076005)(336012)(36756003)(53546011)(186003)(44832011)(83380400001)(478600001)(82310400005)(36916002)(6506007)(2906002)(41300700001)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 13:12:50.4372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea10cac-1f88-4092-6de2-08da7551de0a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT063.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1876
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/22 13:55, Michael S. Tsirkin wrote:
> On Wed, Aug 03, 2022 at 01:25:15PM +0100, Vladimir Murzin wrote:
>> On 8/3/22 12:39, Michael S. Tsirkin wrote:
>>> On Wed, Aug 03, 2022 at 09:57:35AM +0100, Vladimir Murzin wrote:
>>>> On 8/2/22 13:49, Vladimir Murzin wrote:
>>>>> Hi Laurent,
>>>>>
>>>>> On 10/28/21 11:11, Laurent Vivier wrote:
>>>>>> If we ensure we have already some data available by enqueuing
>>>>>> again the buffer once data are exhausted, we can return what we
>>>>>> have without waiting for the device answer.
>>>>>>
>>>>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>>>>> ---
>>>>>>  drivers/char/hw_random/virtio-rng.c | 26 ++++++++++++--------------
>>>>>>  1 file changed, 12 insertions(+), 14 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_r=
andom/virtio-rng.c
>>>>>> index 8ba97cf4ca8f..0a7dde135db1 100644
>>>>>> --- a/drivers/char/hw_random/virtio-rng.c
>>>>>> +++ b/drivers/char/hw_random/virtio-rng.c
>>>>>> @@ -20,7 +20,6 @@ struct virtrng_info {
>>>>>>          struct virtqueue *vq;
>>>>>>          char name[25];
>>>>>>          int index;
>>>>>> -        bool busy;
>>>>>>          bool hwrng_register_done;
>>>>>>          bool hwrng_removed;
>>>>>>          /* data transfer */
>>>>>> @@ -44,16 +43,18 @@ static void random_recv_done(struct virtqueue *v=
q)
>>>>>>                  return;
>>>>>>
>>>>>>          vi->data_idx =3D 0;
>>>>>> -        vi->busy =3D false;
>>>>>>
>>>>>>          complete(&vi->have_data);
>>>>>>  }
>>>>>>
>>>>>> -/* The host will fill any buffer we give it with sweet, sweet rando=
mness. */
>>>>>> -static void register_buffer(struct virtrng_info *vi)
>>>>>> +static void request_entropy(struct virtrng_info *vi)
>>>>>>  {
>>>>>>          struct scatterlist sg;
>>>>>>
>>>>>> +        reinit_completion(&vi->have_data);
>>>>>> +        vi->data_avail =3D 0;
>>>>>> +        vi->data_idx =3D 0;
>>>>>> +
>>>>>>          sg_init_one(&sg, vi->data, sizeof(vi->data));
>>>>>>
>>>>>>          /* There should always be room for one buffer. */
>>>>>> @@ -69,6 +70,8 @@ static unsigned int copy_data(struct virtrng_info =
*vi, void *buf,
>>>>>>          memcpy(buf, vi->data + vi->data_idx, size);
>>>>>>          vi->data_idx +=3D size;
>>>>>>          vi->data_avail -=3D size;
>>>>>> +        if (vi->data_avail =3D=3D 0)
>>>>>> +                request_entropy(vi);
>>>>>>          return size;
>>>>>>  }
>>>>>>
>>>>>> @@ -98,13 +101,7 @@ static int virtio_read(struct hwrng *rng, void *=
buf, size_t size, bool wait)
>>>>>>           * so either size is 0 or data_avail is 0
>>>>>>           */
>>>>>>          while (size !=3D 0) {
>>>>>> -                /* data_avail is 0 */
>>>>>> -                if (!vi->busy) {
>>>>>> -                        /* no pending request, ask for more */
>>>>>> -                        vi->busy =3D true;
>>>>>> -                        reinit_completion(&vi->have_data);
>>>>>> -                        register_buffer(vi);
>>>>>> -                }
>>>>>> +                /* data_avail is 0 but a request is pending */
>>>>>>                  ret =3D wait_for_completion_killable(&vi->have_data=
);
>>>>>>                  if (ret < 0)
>>>>>>                          return ret;
>>>>>> @@ -126,8 +123,7 @@ static void virtio_cleanup(struct hwrng *rng)
>>>>>>  {
>>>>>>          struct virtrng_info *vi =3D (struct virtrng_info *)rng->pri=
v;
>>>>>>
>>>>>> -        if (vi->busy)
>>>>>> -                complete(&vi->have_data);
>>>>>> +        complete(&vi->have_data);
>>>>>>  }
>>>>>>
>>>>>>  static int probe_common(struct virtio_device *vdev)
>>>>>> @@ -163,6 +159,9 @@ static int probe_common(struct virtio_device *vd=
ev)
>>>>>>                  goto err_find;
>>>>>>          }
>>>>>>
>>>>>> +        /* we always have a pending entropy request */
>>>>>> +        request_entropy(vi);
>>>>>> +
>>>>>>          return 0;
>>>>>>
>>>>>>  err_find:
>>>>>> @@ -181,7 +180,6 @@ static void remove_common(struct virtio_device *=
vdev)
>>>>>>          vi->data_idx =3D 0;
>>>>>>          complete(&vi->have_data);
>>>>>>          vdev->config->reset(vdev);
>>>>>> -        vi->busy =3D false;
>>>>>>          if (vi->hwrng_register_done)
>>>>>>                  hwrng_unregister(&vi->hwrng);
>>>>>>          vdev->config->del_vqs(vdev);
>>>>>
>>>>> We observed that after this commit virtio-rng implementation in FVP d=
oesn't
>>>>> work
>>>>>
>>>>> INFO: bp.virtio_rng: Selected Random Generator Device: XORSHIFT DEVIC=
E
>>>>> INFO: bp.virtio_rng: Using seed value: 0x5674bba8
>>>>> Error: FVP_Base_AEMvA: bp.virtio_rng: <vq0-requestq> Found invalid de=
scriptor index
>>>>> In file: (unknown):0
>>>>> In process: FVP_Base_AEMvA.thread_p_12 @ 935500020 ns
>>>>> Info: FVP_Base_AEMvA: bp.virtio_rng: Could not extract buffer
>>>>>
>>>>> while basic baremetal test works as expected
>>>>>
>>>>> INFO: bp.virtio_rng: Selected Random Generator Device: XORSHIFT DEVIC=
E
>>>>> INFO: bp.virtio_rng: Using seed value: 0x541c142e
>>>>> Info: FVP_Base_AEMv8A: bp.virtio_rng: Generated Number: 0x4b098991ceb=
377e6
>>>>> Info: FVP_Base_AEMv8A: bp.virtio_rng: Generated Number: 0xbdcbe3f765b=
a62f7
>>>>>
>>>>> We are trying to get an idea what is missing and where, yet none of u=
s familiar
>>>>> with the driver :(
>>>>>
>>>>> I'm looping Kevin who originally reported that and Mauricio who is lo=
oking form
>>>>> the FVP side.
>>>>
>>>> With the following diff FVP works agin
>>>>
>>>> diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_ran=
dom/virtio-rng.c
>>>> index a6f3a8a2ac..042503ad6c 100644
>>>> --- a/drivers/char/hw_random/virtio-rng.c
>>>> +++ b/drivers/char/hw_random/virtio-rng.c
>>>> @@ -54,6 +54,7 @@ static void request_entropy(struct virtrng_info *vi)
>>>>         reinit_completion(&vi->have_data);
>>>>         vi->data_avail =3D 0;
>>>>         vi->data_idx =3D 0;
>>>> +       smp_mb();
>>>>
>>>>         sg_init_one(&sg, vi->data, sizeof(vi->data));
>>>>
>>>>
>>>> What do you reckon?
>>>>
>>>> Cheers
>>>> Vladimir
>>>
>>> Thanks for debugging this!
>>>
>>> OK, interesting.
>>>
>>> data_idx and data_avail are accessed from virtio_read.
>>>
>>> Which as far as I can tell is invoked just with reading_mutex.
>>>
>>>
>>> But, request_entropy is called from probe when device is registered
>>> this time without locks
>>> so it can trigger while another thread is calling virtio_read.
>>>
>>> Second request_entropy is called from a callback random_recv_done
>>> also without locks.
>>>
>>> So it's great that smp_mb helped here but I suspect in fact we
>>> need locking. Laurent?
>>>
>>
>> I'm sorry for the noise, but it looks like I'm seeing issue for some dif=
ferent reasons.
>> I manage to reproduce issue even with smb_mb() in place. The reason I th=
ough it helped
>> is because I changed both environment and added smb_mb().
>>
>> Anyway, thank you for your time!
>>
>> Cheers
>> Vladimir
>
> Well we at least have a race condition found by code review here. Here's
> a quick hack attempting to fix it. I don't like it much since
> it adds buffers with GFP_ATOMIC and kicks under a spinlock, but
> for now we can at least test it. I did a quick build but that's
> all, a bit rushed now sorry. Would appreciate knowing whether
> this addresses the issue for you.
>
>
> diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random=
/virtio-rng.c
> index a6f3a8a2aca6..36121c8d0315 100644
> --- a/drivers/char/hw_random/virtio-rng.c
> +++ b/drivers/char/hw_random/virtio-rng.c
> @@ -23,6 +23,7 @@ struct virtrng_info {
>       bool hwrng_register_done;
>       bool hwrng_removed;
>       /* data transfer */
> +     spinlock_t lock;
>       struct completion have_data;
>       unsigned int data_avail;
>       unsigned int data_idx;
> @@ -37,6 +38,9 @@ struct virtrng_info {
>  static void random_recv_done(struct virtqueue *vq)
>  {
>       struct virtrng_info *vi =3D vq->vdev->priv;
> +     unsigned long flags;
> +
> +     spin_lock_irqsave(&vi->lock, flags);
>
>       /* We can get spurious callbacks, e.g. shared IRQs + virtio_pci. */
>       if (!virtqueue_get_buf(vi->vq, &vi->data_avail))
> @@ -45,20 +49,20 @@ static void random_recv_done(struct virtqueue *vq)
>       vi->data_idx =3D 0;
>
>       complete(&vi->have_data);
> +     spin_unlock_irqrestore(&vi->lock, flags);
>  }
>
>  static void request_entropy(struct virtrng_info *vi)
>  {
>       struct scatterlist sg;
>
> -     reinit_completion(&vi->have_data);
> -     vi->data_avail =3D 0;
> +     BUG_ON(vi->data_avail !=3D 0);
>       vi->data_idx =3D 0;
>
>       sg_init_one(&sg, vi->data, sizeof(vi->data));
>
>       /* There should always be room for one buffer. */
> -     virtqueue_add_inbuf(vi->vq, &sg, 1, vi->data, GFP_KERNEL);
> +     virtqueue_add_inbuf(vi->vq, &sg, 1, vi->data, GFP_ATOMIC);
>
>       virtqueue_kick(vi->vq);
>  }
> @@ -70,8 +74,10 @@ static unsigned int copy_data(struct virtrng_info *vi,=
 void *buf,
>       memcpy(buf, vi->data + vi->data_idx, size);
>       vi->data_idx +=3D size;
>       vi->data_avail -=3D size;
> -     if (vi->data_avail =3D=3D 0)
> +     if (vi->data_avail =3D=3D 0) {
> +             reinit_completion(&vi->have_data);
>               request_entropy(vi);
> +     }
>       return size;
>  }
>
> @@ -81,18 +87,21 @@ static int virtio_read(struct hwrng *rng, void *buf, =
size_t size, bool wait)
>       struct virtrng_info *vi =3D (struct virtrng_info *)rng->priv;
>       unsigned int chunk;
>       size_t read;
> +     unsigned long flags;
>
>       if (vi->hwrng_removed)
>               return -ENODEV;
>
>       read =3D 0;
>
> +     spin_lock_irqsave(&vi->lock, flags);
>       /* copy available data */
>       if (vi->data_avail) {
>               chunk =3D copy_data(vi, buf, size);
>               size -=3D chunk;
>               read +=3D chunk;
>       }
> +     spin_unlock_irqrestore(&vi->lock, flags);
>
>       if (!wait)
>               return read;
> @@ -108,12 +117,14 @@ static int virtio_read(struct hwrng *rng, void *buf=
, size_t size, bool wait)
>               /* if vi->data_avail is 0, we have been interrupted
>                * by a cleanup, but buffer stays in the queue
>                */
> +             spin_lock_irqsave(&vi->lock, flags);
>               if (vi->data_avail =3D=3D 0)
>                       return read;
>
>               chunk =3D copy_data(vi, buf + read, size);
>               size -=3D chunk;
>               read +=3D chunk;
> +             spin_unlock_irqrestore(&vi->lock, flags);
>       }
>
>       return read;
> @@ -122,19 +133,25 @@ static int virtio_read(struct hwrng *rng, void *buf=
, size_t size, bool wait)
>  static void virtio_cleanup(struct hwrng *rng)
>  {
>       struct virtrng_info *vi =3D (struct virtrng_info *)rng->priv;
> +     unsigned long flags;
>
> +     spin_lock_irqsave(&vi->lock, flags);
>       complete(&vi->have_data);
> +     spin_unlock_irqrestore(&vi->lock, flags);
>  }
>
>  static int probe_common(struct virtio_device *vdev)
>  {
>       int err, index;
>       struct virtrng_info *vi =3D NULL;
> +     unsigned long flags;
>
>       vi =3D kzalloc(sizeof(struct virtrng_info), GFP_KERNEL);
>       if (!vi)
>               return -ENOMEM;
>
> +     spin_lock_init(&vi->lock);
> +
>       vi->index =3D index =3D ida_simple_get(&rng_index_ida, 0, 0, GFP_KE=
RNEL);
>       if (index < 0) {
>               err =3D index;
> @@ -162,7 +179,10 @@ static int probe_common(struct virtio_device *vdev)
>       virtio_device_ready(vdev);
>
>       /* we always have a pending entropy request */
> -     request_entropy(vi);
> +     spin_lock_irqsave(&vi->lock, flags);
> +     if (vi->data_avail =3D=3D 0)
> +             request_entropy(vi);
> +     spin_unlock_irqrestore(&vi->lock, flags);
>
>       return 0;
>
>

Thanks a lot! I gave it a go and it did not help. I think I need to find ou=
t how exactly
my environment affected... it not necessary need to be kernel related.

Cheers
Vladimir
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
