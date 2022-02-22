Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066AC4BF292
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 08:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbiBVHYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 02:24:19 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiBVHYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 02:24:17 -0500
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30095.outbound.protection.outlook.com [40.107.3.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39641162AA;
        Mon, 21 Feb 2022 23:23:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqhNNokGLSOU7i0ipbVoaAH1m+5HhNoSYAmDJO4QqYwo262wfquURE2xux/8xYa1TEqRMU8Sm7DAbInXPvctpySIGJcYwzKGTiuHHpzScP+7fvuRoVDvWVeOI+blj9N3/Z2ZTkO2gT0pEGwsAQYI8aiWKyG6lXONatgcEPT2fAx/qesauJIGNLStFmt9QGBYtKVEdlSczb8HY3291rI6I+q3VEirj4GMElg4UVL5CydeOkSkrW2ocR8MM9r/PScdcCFxnWjYOMTJK6/cOzijpEwxqdZ4+U3VFQLJjrUnM5ShKMBenBUNN+ZohTP48hpD8zvoj0Xybjp8Nu9FS0FmsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYR4q+wBxR7cXzzqd5wp50XtU5KrQ3ujjEXGMUubdaM=;
 b=GIlx7peEPMoQSzus0+xQi7u7aGSUFBApQXSnMJVQg7188dJncVqTkx/DUzzoVi84URZ3YedIGG81mG3hVmUPpLWo+shAEYwN8/JtmSSzUN0OfGb/uzi/BfDCT8YSJH1dFC1mzMo0w2IjKEKZBR57jRwU/zGEpWXfAEp2lpMHhrAMHwjKg1BzMRsOPx5thoy9VUgtIcTmgXjREv+xiAuRvaIQVrYnxY56z5f3W1Xbs7RLKOPerJmPYodXFEJnieRLOxd6V5KdX+Tq4HzwdmmqEhXEGNL9G/hNz0mecHM/3Kfn7KXs/6mbIH4qUsxe5mo2+HWcok5Q6ra3ft8dgRBKmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYR4q+wBxR7cXzzqd5wp50XtU5KrQ3ujjEXGMUubdaM=;
 b=QhxFrzRIXTgxBmQe4viKN9I64RhBt4jkhon7aCBLdSIghW4CuB5/XLcDzVJNez/H/6kGULdhviw96fWbmDauyi5dRy75ZC9WY0+v/Wek/5F+xOr5YRHEAM2k1gmX784z8oUl6la24P9v3KIzrS6Z9GRapjkoJMZKto32569+qug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from DU2PR07MB8110.eurprd07.prod.outlook.com (2603:10a6:10:239::15)
 by AM0PR07MB5217.eurprd07.prod.outlook.com (2603:10a6:208:ed::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Tue, 22 Feb
 2022 07:23:48 +0000
Received: from DU2PR07MB8110.eurprd07.prod.outlook.com
 ([fe80::99a2:6f44:700b:b796]) by DU2PR07MB8110.eurprd07.prod.outlook.com
 ([fe80::99a2:6f44:700b:b796%3]) with mapi id 15.20.5017.021; Tue, 22 Feb 2022
 07:23:48 +0000
Date:   Tue, 22 Feb 2022 08:23:35 +0100
From:   Krzysztof Adamski <krzysztof.adamski@nokia.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-hwmon@vger.kernel.org, Agathe Porte <agathe.porte@nokia.com>,
        Jean Delvare <jdelvare@suse.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: hwmon: add tmp464.yaml
Message-ID: <YhSPd79vHLO+73ln@localhost.localdomain>
References: <20220218150908.1947772-1-linux@roeck-us.net>
 <YhNWVLHYVtCvdGhi@localhost.localdomain>
 <66e6b131-274f-454b-44f6-17df879d71a9@roeck-us.net>
 <YhQDGHD3S0qwP2OB@localhost.localdomain>
 <238e6fb0-cd77-4772-3e92-23941dc74403@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <238e6fb0-cd77-4772-3e92-23941dc74403@roeck-us.net>
X-ClientProxiedBy: MA0PR01CA0008.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::15) To DU2PR07MB8110.eurprd07.prod.outlook.com
 (2603:10a6:10:239::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65f44832-257a-44fe-154a-08d9f5d444d2
X-MS-TrafficTypeDiagnostic: AM0PR07MB5217:EE_
X-Microsoft-Antispam-PRVS: <AM0PR07MB52177873A1B909D5940463E9EF3B9@AM0PR07MB5217.eurprd07.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NiIiKuls5VZZ9J/6KsOPFtCjbGgq+zXyFCAD2JlG9Xcqmv0a5DIlRKZuCjJrAnzK7Jd0UbvHzV1xKOfmytNiETIlRzS8nZn1bK2PCE2PhbfWPs8TRF5gUV1a1vjK1gDl9piDE5zuLpXp9gEDO4inLAYD3EKdgMt1kyBzQkMwsQFvxXAFaMUJCZSI9XtNauOUwlaFCtT2oQwnxEXr4XBGs0uz/qN2xctnL+DnGYbGm6B8DE0XHU/waxpK++M9ROwz5z6fAKapEpeuVtoJOQaHssnCU0XzOI5CTKKELxnT3n2RMvlElaYBhpeQ0uVyZvicJKC3A0YkU9Qx1vx3dBf8+yXHyFOGLJC2Rq7wknOxn91/NYzC3sSIVrOY7Fwp3PcCEln2GSwm2YR4C27xR8QGngVkux3p3Aj/we1Xt6yvTqco4Em+zba+qRFuxw4a7w2eNKDt4naafCCzKnc+pjRlj3VpZ+B99aJc8GjOLepLUGSzfI/Cw52eVJrAH6szra1LQE4lLNo0uRDvzKlBl7EXl43rV7ovYVPb2ISKStCCgs30lXeIkBjLSPxMROh6hPPlvNS2Q1H81AdZVE5UT2HQ+9vZpJxj0L1X6/OWyKkePr6pFzc1suVaLcoEONwd2YX64r0KQEItMOVBVNkrra0elfV4PEMbWq5uqCAJAeZSMtp7lCN8zL7e9aUzqgc1i18YMTrGYariQQUNIEm6HXrj0iT7fIk5uyDO6brcINPxfGISi7REjeu9ZC9HNvG/iRL2wgU4i4l7Gc1ys+5/GF0aoEQyHLilmypv7F9WWTCezJZAhHLmIQxxCGeXydc9kYoi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR07MB8110.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(508600001)(26005)(38100700002)(52116002)(38350700002)(186003)(6666004)(6486002)(5660300002)(86362001)(6506007)(66946007)(66556008)(66476007)(8676002)(4326008)(82960400001)(44832011)(2906002)(54906003)(83380400001)(9686003)(6512007)(316002)(110136005)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0l3UU5iYmdyMFd0YWUxK3E2dklOb2FJZjU5M1I3UnRDUmRBZy81VFBJb01k?=
 =?utf-8?B?QklUTGNRSWo5WVpXVXVKTXZMelRWY3dDR3FZVXZBRWo1em9rWXBzSEdXTWxF?=
 =?utf-8?B?aHRvVVBsM2UxNGd5TkV0UGttL2paWVlVZUFnRmYyUlFPSmM2aTAxNFdVd1Bh?=
 =?utf-8?B?blZLeDh2WG8vTVM1dk96Q0tPYzBCdmlYZE54MmNxS3RzUC9jeEExNHdBeUNs?=
 =?utf-8?B?UmN1c3liTFE2OHllUVVQRGI4dEFJaVR1VU9pZXFUeEg3U3RVTmRiR2xlMEpa?=
 =?utf-8?B?WVlSd3hyMVdPS1VXSTVLcmZ3R1czVGNlTHE3OWJsbEZuakNwSXQyYytUeW9R?=
 =?utf-8?B?bnJ0N2p3SnB5d3R1WFNXbFFkSS9EY3cwelZGaC9nYWJZRXBTdkFEbGNtdUlW?=
 =?utf-8?B?blQ5TGtHblByakJGZFVOV0pLc1hBZks1UTR6NXVBdEdtUnJNU2tyT0pXei9r?=
 =?utf-8?B?Nkc1bHErd21RSC85UmpPdXUzM1NodWNZTEg2M255ZUZUZnV3TGl1K2ljbVY0?=
 =?utf-8?B?UUhrY0NsZlBndlFyVDdLdUR2SU10MTZCbEgvVm1LVW5DNVJaQWFadDFzckl1?=
 =?utf-8?B?N2JIelBRUGM0anlMSlZmeHBqcDM1QVIwNE9DZlpjS3RVK044d2sxdkNaaW9X?=
 =?utf-8?B?REhEMXdRekF3R2tiV2t2QVdJbUMvUEhqNnZQMFlKN09lMUd5RllMd2pBTnRM?=
 =?utf-8?B?a0FaUExwaWJ0cEM4WFREZWpWVENUdXB1UFVVTVZwZmluUzZoT3R5bUtTWnhI?=
 =?utf-8?B?T3EyaENrWDMxZWIyZW1scHRMRE5iTzVjV0Fsam8xZkNVZHhlbUJGTytoWWxr?=
 =?utf-8?B?ZVNNZSt6TmFON0lhOXpSUXd5WHVxQktWVUpncE9YL2NEYkZnalRxMzd4YUs3?=
 =?utf-8?B?NHoxTDVMZkZLTnhSdENxdTZTWmxjaURCU3pPVG5ia2ZTTktsSjUxejRteUxX?=
 =?utf-8?B?bGlDeHRqaU0yVEtJTGFQeTV1eHBvM3JacWlzeTlGOHI1M1J0Mk5oTndWTy9K?=
 =?utf-8?B?MHViNnkzbUZWNUR2M1FrMmsyOGxoQ1ZzaFJWMFZPdTNHWjZSSUpTVnBQY2p1?=
 =?utf-8?B?T2hDaHVaeEgxclI4OWxFUm5rNDNCcStDaDFwM0w0Y2J1Uy9EWDZSbnY1ZFZy?=
 =?utf-8?B?eWt1RS82TEsrOFhhTFhOV2IvNW51WjhJazFZWVRyS0RQTFVtTkNONXk1UU1O?=
 =?utf-8?B?aVJDaDlqR0g0eW8yc1BHY3Bsd3Y4QlNSaXdIYVQyOW0xYTJ0SGRPRE5LUHEv?=
 =?utf-8?B?YWdQb05oYVd4akVzcllCMUw5bzZvdXZvbjdSK1pHY0xzR1AxVDVGc2RVYmhK?=
 =?utf-8?B?ZGpmazVCRHV0UlVxaktvdk9MODVrVG5aM0FsN3lUQWJBWnpveXpoelFzdExu?=
 =?utf-8?B?clVFa1cxaDh0MVNHUWRES3ZEeWF4OURTeno2SGR2dUJxR1pXQ3h4aC9YcWxr?=
 =?utf-8?B?RktFcmt2ck9IcUlJZElZbEZXamp3TUxoMTFRZ0Jmbkh0S29VbldqWGNrVEpS?=
 =?utf-8?B?S29SQjJlWGcvVjRaZ0pzdGJ0RjhnWC90dTdiMGRVVURmRmM0Y3ZySGp4MWtk?=
 =?utf-8?B?Yy9NOVE3djlnb3hVb1VTTGJ1L0RvUUxTYzArbzNkQ2VpU0EvVlhLZUc5R0dO?=
 =?utf-8?B?aGNRTjZ3ZHBrSFZ6Mi9aVytmWFE3MHdxUS9tK1l2QWQrT3hzblNZTkxrYUNN?=
 =?utf-8?B?VExHanQ5WU5DdUZ6Q0VnaEN1S0pxRTd5M2ROcm00aDkzZFlsMW9UTzBqeGFL?=
 =?utf-8?B?U0c0VEhnWHJ4WTJOM0lyb04xMElzTEVReXFPb0lGcHZxNE1YaklQYzQ5YjVM?=
 =?utf-8?B?YlJHOE0vQ3k1UlpERXErVG5meno2ZUZBZmh4TmdsWlVOQVl2V09wTDZzbEpv?=
 =?utf-8?B?aUswU2I4aTRYZVBqcS90T0NBN1lLSVVRT3dCdFkzSFcwTm02MTE1VHpKQ3Jq?=
 =?utf-8?B?c3FUSzh3dW0vQms4Z2NQbjJJanJsc09EeitGb2lDZENKU3R0a0ZhaGx5MzQx?=
 =?utf-8?B?aFFzQnpNaSthMDFsM1VrR1RnNjZSNVJ4NFZJU1FmUE9IOWQ4VDNpQllQZ1hP?=
 =?utf-8?B?c3NNQ216Lzh5cHN2Q3ZFeXdRM3JNWXlqWUVRekpBSTRMTXRUQUwrM2w2RHBW?=
 =?utf-8?B?Sks1cVF0MWJxcytHTzI4L1RjclYrcE1ZaXNXRlhrRmV3QVoyaUZvcjI1OFFE?=
 =?utf-8?B?bHA4Uk9jUndtc2cwdVhGYzkwOG5LWm1tTWNiUW1tSzRrL0l0QUhMOTNPeHZi?=
 =?utf-8?B?amZpNndycEdTdUdSMWpPTnZ1RjV3PT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f44832-257a-44fe-154a-08d9f5d444d2
X-MS-Exchange-CrossTenant-AuthSource: DU2PR07MB8110.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 07:23:48.8469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h1wiKmsCJnzW2Z6fKfGsKeiPciUJUBBqDrKw48JLztIQk2NrtSCpGkiaTZpKYrG1co0cv4MDrFyuu48ZPku+lO6Hgiowh7dQTmBtt7H9o9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB5217
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia Mon, Feb 21, 2022 at 02:11:17PM -0800, Guenter Roeck napisał(a):
>On 2/21/22 13:24, Krzysztof Adamski wrote:
>>Dnia Mon, Feb 21, 2022 at 08:16:15AM -0800, Guenter Roeck napisał(a):
>>>>I still thing we should have the same format here and in tmp421, for
>>>>consistency. If use the same property name, "ti,n-factor" but on tmp421
>>>>you have use 32bit value while here you have to use 8bit (which is weird
>>>>in DT, BTW), it might be confusing.
>>>>Back when we did this for TMP421, there was some discussion and we
>>>>settled on this approach, why do it differently now?
>>>>
>>>
>>>I seem to recall from that discussion that there was supposedly no way to
>>>express negative numbers in devicetree. Obviously that is incorrect.
>>
>>Well, I would still argue it *is* correct. DT only support unsigned
>>numbers and, really, only 32 or 64 bit. See the chapter 2.2.4 Properties
>>in:
>>https://github.com/devicetree-org/devicetree-specification/releases/download/v0.4-rc1/devicetree-specification-v0.4-rc1.pdf
>>
>>Devicetree also supports array of bytes, and this is how we get the
>>/bits/ magic but this is just a syntactic suggar. The same is true about
>>negative values. Just decompile your compiled DTB and you will see.
>>To put it in other words - DTS does support negative values, DTB don't.j
>>
>>>In addition to that, I strongly suspect that the tmp421 code as written
>>>does not work. Its value range is specified as 0..255, but it is read with
>>>    err = of_property_read_s32(child, "ti,n-factor", &val);
>>>and range checked with
>>>    if (val > 127 || val < -128) {
>>>               dev_err(dev, "n-factor for channel %d invalid (%d)\n",
>>>                      i, val);
>>>               return -EINVAL;
>>>       }
>>>
>>>That just looks wrong. Either the value range is 0..255 and checked
>>>as 0 .. 255, or it is -128 .. 127 and must be both checked and specified
>>>accordingly. This made me look into the code and I found how negative
>>>numbers are supposed to be handled.
>>
>>It worked for me when I tested that. I could redo the test, if you are
>>unsure. The code also looks good to me. I wasn't convinced for this
>>format in yaml but after the whole discussion we had, we settled on
>>that, with Robs blessing :)
>>
>
>It is hard for me to believe that you can enter, say, 255 into the dts file
>and of_property_read_s32() reads it as -1. If so, of_property_read_s32()
>could never support values of 128 and above, which seems unlikely.
>
>Now, I can imagine that one can enter 0xffffffff and of_property_read_s32()
>returns -1, but that isn't what is documented for tmp421.
>

Yes, you are correct, you have to enter either <(-1)> or <0xffffffff>
(which is the same thing). I was quite confused on how to specify that
in DT bindings and apparently maybe we did not understand each other
well enough back when the patch was submitted. The code and the
description is correct, though, so the question is how to properly set
"minimum" and "maximum" value.

I think I should at least update the example of tmp421 in the binding to
use <(-1)> notation to make it obvious that it works this way. But I
guess we need Rob to help us understand how this should be specified.

In any case, if you drop usage of /bits 8/ and keep the property naitive
32 bit, both tmp421 and tmp464 bindings will be compatible with each
other.

@Rob, if I want a property ti,n-factor be in in range from <(-128)> to
<127>, so that we can use of_property_read_s32() and then use just one
byte of that, how to specify that in yaml file? For TMP421, we currently
have:

  ti,n-factor:
    description: |
      The value (two's complement) to be programmed in the channel specific N correction register.
      For remote channels only.
    $ref: /schemas/types.yaml#/definitions/uint32
    items:
      minimum: 0
      maximum: 255

which is confusing.

Guenter is proposing to use
  $ref: /schemas/types.yaml#/definitions/int8
  items:
    minimum: -128
    maximum: 127

and of_property_read_u8() for the same property on another driver, so
usage of /bits/ 8 is required. Which approach is better in your opinion?

Krzysztof


Krzysztof
