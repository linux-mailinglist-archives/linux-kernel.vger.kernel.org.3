Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1405740AA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 02:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiGNA4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 20:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGNA4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 20:56:35 -0400
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEBD1A831;
        Wed, 13 Jul 2022 17:56:33 -0700 (PDT)
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A80B1C00C6;
        Thu, 14 Jul 2022 00:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1657760193; bh=1fVjYXXn+LOob/tTzhApmx7LjBSZZeLqCUjxN++CdCA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=XsmdJqPnBf36+/w9w/p7Qt9NgaPdtm1Djp8KPLrz64cbfAvZOE69XJ7Us1xl6HrcQ
         Mf43Nam/eOIXN0tV6zxMZHP6oEbDfZ3gSsKv/X+LJe97Y1ubpmubTLBUWQWZNaaVVy
         QK+f+tvhS3a8+K+IoWLnKGyxdyGiBdcYMzkD19ZyE+RJS2aZY7nR8qpdW3GmlVxYxE
         ugbeGZgT0mLEazs87yx99Z80MUp4j6Nlmk5BYqnIrXxUcatTl2e2Itju5ZkndFXxzE
         aTMoSxdGhuyMS8zfNETlfyekDfUqT890tteX2yuo1rXST+TM3v8w6kk00s8XQaMlH/
         f51FKnUAfHwWg==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3A543A007D;
        Thu, 14 Jul 2022 00:56:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 3DD10800AC;
        Thu, 14 Jul 2022 00:56:27 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="RdO22i2T";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0JWiAwPZJBT0Iraj1INKwwhHSM0jo+pNyTyod2JrYKG3IAIluMzg6Kvd7FU65hIbi5nME9xexA1i2HiAE2C+hSv4GtGJetdwTCr2VwvBaeNgDwJ0EbxG3M5ZNabt2kEpwKMdOV7J2/1jZqhqW9swRIPjS+8sK+sm1TD71KOUdogmnfGVWrmflagkKbtDQi6wN6bpYuNh8V4teHIsZGb2upeY7Oe9FU0NU5zNb6LUY5dj8M9Po9FcEx/U7N6+lYX9SS4EsYEchKy+UXDFooeC9HGh0W2bY3TOy5eSuuhiQ5Y4Luj5nBSkmpdSeoBuJxvQfejYvnaWAzwgTnL9Z8NiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fVjYXXn+LOob/tTzhApmx7LjBSZZeLqCUjxN++CdCA=;
 b=f/M9J64eyRzKnw7WD0azeAni9ejbGILePuzzBuyH42dBm0Js6y/mIGkgw+Xkln64237nmKiC4oS4npJwRAzROT8xNuOBO6FcOcgdcbS6kmogJJmEQq/iJ8UGm3LYizFutwFvbsvfeR5n0swIrD2p9zxkKkUKItRWjeItY8k7b6YY//gnFqydMN4XLRC1WCUWYNmbQdFWpsVbEv6w5JSXWO+I5pDykQ3iNCL8kLxj79mnnmSO2FMWndF7tMp8LHCGp2CMyn3+BGgBxZ07MxzZuSLngt0rhXCb8o2jYAa8XVtPzPABK246VKro+KxMbHhLBgk9ZCWPtrkERsnXe5+xRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fVjYXXn+LOob/tTzhApmx7LjBSZZeLqCUjxN++CdCA=;
 b=RdO22i2TZ/fylYiO/9dgrtg9RI62PKKZRfXirAMYU+X56loTMQmE80tassdJdcILcVaelMUyIobUUaxVHMt9XBxIN4AMd12avqFEP/fccjoJbkfC3jbilydGwJExv+z4BTAXEksnbCmEYgRRZFUuY1D+x6aJ6fJo5aJd8Tyzxho=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BN6PR12MB1716.namprd12.prod.outlook.com (2603:10b6:404:104::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Thu, 14 Jul
 2022 00:56:24 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c%7]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 00:56:24 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Jack Pham <quic_jackp@quicinc.com>,
        John Keeping <john@metanate.com>
CC:     Wesley Cheng <quic_wcheng@quicinc.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Li Jun <jun.li@nxp.com>
Subject: Re: [PATCH v2 5/5] usb: dwc3: gadget: Increase DWC3 controller halt
 timeout
Thread-Topic: [PATCH v2 5/5] usb: dwc3: gadget: Increase DWC3 controller halt
 timeout
Thread-Index: AQHYllCHGInvQJA1C0e0j2COxofgtK17m7yAgACSc4CAAKs5gIAAMwqA
Date:   Thu, 14 Jul 2022 00:56:24 +0000
Message-ID: <c3be8cb2-06d0-dd57-078d-7a40be937734@synopsys.com>
References: <20220713003523.29309-1-quic_wcheng@quicinc.com>
 <20220713003523.29309-6-quic_wcheng@quicinc.com>
 <20220713025643.GC8200@jackp-linux.qualcomm.com> <Ys6vReAwrYbEavob@donbot>
 <20220713215342.GD8200@jackp-linux.qualcomm.com>
In-Reply-To: <20220713215342.GD8200@jackp-linux.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e2487af-8f69-4530-4d7f-08da6533acc9
x-ms-traffictypediagnostic: BN6PR12MB1716:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?dThRYzcwTGcxTDZWeEs3WFlra3Y5akdlTjJCNHdObGlmYU41eXhCd1FDbnZ2?=
 =?utf-8?B?Q1B2RzZFQ0w2NEFzNTkzc3d0WGIveCsxeERuVGhRYXNJdWJoUXlCRTFBN1cz?=
 =?utf-8?B?TGl5bnJ0TUR0WkJMUnAyTkZGZktiQmwvVnZNOUtPWHcyVlRYZSt4R2R5cnFn?=
 =?utf-8?B?STl0dkNvNWR2Q1RYSWdaWThabThjSjN0aDhWKzJZTnU4OHc0S0VJdzdTT3dJ?=
 =?utf-8?B?SU9vWWtIL0V5eXdDQUR1Rm51R3pBNXhRQndyaHBuSm4xQTI4aUdaNCtPRnJ4?=
 =?utf-8?B?LzhCQkM0U1YvNG9yVFdpcEZhWkJWREMzd05lS3VBRWlDQm1kbFZBL0Q4Q1FW?=
 =?utf-8?B?SEYvbkN1S2NsNjI3aXYwTWJ3aU9NRU0vUmsxbU1HVWM4WlZBdS9ZWGVzZ2N6?=
 =?utf-8?B?Wk5INjJ0dUxyWEhHZHlCVTRQc2ltcVJDSlhDdU0yNUxpcGVNeEdpa0ZjUWtw?=
 =?utf-8?B?bDF6eERodFFYdWZRNEptTVo1SVczSXBERTRramJtMW40d0NNWjFObUNhbTBj?=
 =?utf-8?B?RkhrZ2h1NEQ0YzNhM2Y3N0ZBRENXRXhGU3hLRk1nUFB0YUR3OGlqMTM5aU5s?=
 =?utf-8?B?UWhPLzZQUE9hR1g0OTRldGsydDlUbXBESHZOeHVFTUw1ZCt0b1R0ZDg4UVI1?=
 =?utf-8?B?V3E3RW1aZlZUUFlKa0xlNExZSlF2U2tpQS8yL1VyUVVLenZPd1luR0JyOHE5?=
 =?utf-8?B?WktuWkliNk1wakRLUjV1OTJLcTN0ZHA5ZkRTUm5Ld1ZvWkdaMisveU81OTZl?=
 =?utf-8?B?TWlZcXJZdGwyNnFMVHhhL1VtODBQM0Evckwrc0FDS0NVb2htVVkzOWN3YmNG?=
 =?utf-8?B?QWRlYUlKQm9KWE0zNE44QTgzR1lQRThKM0NWbWxaaHFaM2FkRWl3RGYzMVBS?=
 =?utf-8?B?WjF2MkVtcU94S1hEQ0ZGRU5GVnBxeHh3eitXei9CK1RiVTJjOUo4UmlxcHNI?=
 =?utf-8?B?Zkkxb0RGcmtuYWxMR0ZGYVhrbnk0WXdmWitRbFN0ZEZyc1B2SndOcjlzWEhs?=
 =?utf-8?B?bTdrdUJYZWlnRlpHUS83Tm9qUXlHMWdBNHVsS2JpL3pVQTdCOXJzWE9Tb1hT?=
 =?utf-8?B?S3NxejV3OW9xZ04rYzNTV3ZFMktiZmtrRVJUZlNmY0hla1F6MnBtS3N5MnFo?=
 =?utf-8?B?OWpNMlBNbGRzVHhiY2JJOGF2Qkh4RVErVWJ1QTc0NENkd2lRMXRZajdGQ3Jl?=
 =?utf-8?B?UWlZZGJqY2dCUTF1VzlqaHVhSC9ra2Vxb2Y5ck5yS3ZvTnpFTnZsRmk0Mkc0?=
 =?utf-8?B?dDVnK2RNWEovdUpNMmZzYWppa2NrK0xtUk5JT21uYzZsa0wvZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(366004)(376002)(396003)(136003)(64756008)(66476007)(66946007)(6506007)(6512007)(86362001)(41300700001)(76116006)(66446008)(5660300002)(26005)(110136005)(6486002)(478600001)(66556008)(54906003)(316002)(966005)(71200400001)(122000001)(38100700002)(36756003)(38070700005)(31696002)(83380400001)(2616005)(8676002)(31686004)(8936002)(2906002)(186003)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K21kanFFOTZ1ZFJZeHNVdEJpVXpiZGsvYmdQeTFEZmNYRW1WN25WQjhHZFBG?=
 =?utf-8?B?OXFMVkVjd3crSm1qWlp6MWNjaFRqbDF2WUNXbzBvWDlBUnlOa1B6eXk2dndh?=
 =?utf-8?B?TDQ1QjJCMFFNMENFa29WMW5TRGJ3THZvWWtXTmoyMzVjRytaQnE2NDVaWFVi?=
 =?utf-8?B?WU9vQTl6NEtDd2xZaFpiZzlkTnB1eFVTT24wbm1lWjVtWDhFNGJJck5rRUV0?=
 =?utf-8?B?Q3Fiakx6cnRaM0xRcWtXWG9GSGFxM25xS2NiQ2NYMk9BZGlkUlZ2MU94SWtj?=
 =?utf-8?B?UlJ1RW1zNm0zWWVFUVJwckV4R0tHbUFxNFhVa1hweEhKVnIzS0hQRW00Uksv?=
 =?utf-8?B?QTdONkY2VDVaVDBGVGIzclVBTHdIUjQyOFFhMmo5bXlHK2ExaDl1TXFKN3lD?=
 =?utf-8?B?RlE1VHErRzJOVUVtUitHbFZUVjE4QWVQUktXd3NvWHhwWW92RUIvUzdYdU5n?=
 =?utf-8?B?cnhWdTFabk1uRmpsUDl1bHN0OGNkQ3dGazlkeVVDWWdxMlVXdWcwWDlZVSs3?=
 =?utf-8?B?Zm94Q2NiSW0rWUcxU0UvdE5DQTNNQ3l2c2xUODBwdEs4S3U5TnQrUmN0U1Vj?=
 =?utf-8?B?S0pDM3YxbmpRS2xtSy9wNmhGQUY4YlkvZzBJNU9XTjAwdzcrRlFWN25KdC9C?=
 =?utf-8?B?ZnJpZlZQQ3Nxd0pqNmhQaC9FL2R3Q1NKc0tJdkdIR205dWNVL29wUm51d1h2?=
 =?utf-8?B?MlFUTXVQVGtpeStYdzNwVXBMQm9aTHlKWk11dHYyU2M4MlNlZTN6bTZEdmNj?=
 =?utf-8?B?eU5zY0NaZ05TRGk2NUg5d3ppaUttbjBBUDVQanpxK0tpYzNpdzArYS9LQW4y?=
 =?utf-8?B?dFg0YjRmMWEvYXhGZWFTZG9vT2pMSnpNMlMzRkxTNUhyVk1BSUlPT2Yza2Vm?=
 =?utf-8?B?bXQ5blZVQnpCWWlrbFJlU0hHbFM2bWNXMC9tcFZOVmdURnBTQjd6NFAwUVg2?=
 =?utf-8?B?K0pjRE9vRXkvZEZqVkxFRmFVVEZNdjRCNDNWYmViUkxnUDJKbXVYQVF5M0R1?=
 =?utf-8?B?Q3N6ZXpjREZ0R3dPejZMUVdnVTM1YTdUUE9LYm11aEVHMWkzeTlYZ1Jva3Q5?=
 =?utf-8?B?dVY2dkNtOVNTWFRRQ1N2UGhkS0ZUdGxsRXNaNW8vbEd2L1ArQi9nVjMwMVZR?=
 =?utf-8?B?aXhmb2dEb3Fqbzd6RzU0Tm41eC9IbysxQmZxRU1IWEkrZ05CVlZ0RU5UVUQx?=
 =?utf-8?B?eUpobVVMaGYxMmlxWWVTSExPbitTTVEyYmVlRDNWUkRzRkhTbWoyTmh2ZzY1?=
 =?utf-8?B?QXQrQUYwc2cvWTYrbWN1bG5ad1NTVlZ2Q3ZXcDBuU1hwYmFBNW9jaHl3S3Va?=
 =?utf-8?B?SXZQQ0tqd2VGZEZpQXJIdzkrSEZLMFgwOW9qazYwdUswNDJTTzFqZjNLRjN1?=
 =?utf-8?B?UjE0VkZ0NjNWWDdpQnJmM2pRU2J4b3FpMUFObjBhb0FzR0JiaXlMaVdYV1pR?=
 =?utf-8?B?SGNHRnNEYTNRNmdlTE4ya2ZRNDlpUEJXN0ZkNlh4azR5V2RhUVpFTnJsZ2ow?=
 =?utf-8?B?YzZVM3VSaHRXcFZRSTloLzlxNmI5V0tvRTdiMmQzTWFFQnRVa25KYWJWcHE2?=
 =?utf-8?B?VnhqY2hLQTVuVlpDNU9mRGovalVic1dsSFJDcTFPdzNxSTRqdDcyK1d6clAw?=
 =?utf-8?B?VmQrVVM4UXY2MTdyaEZYaHFBdHdZbHMxa0VEdlRCNzQ3YWJ3aFc0NEZFMHVC?=
 =?utf-8?B?SXlURndjOVNYNGl1M01YZjd4Ynk3QWlqV0YwemFZK09UTmdCYTVnTUU0QkxK?=
 =?utf-8?B?UStDTmpQZ0krY1V3U0VudEVMQXBQQWg3aVRSRndMUmo4TEhSelNsK0h3Qkhq?=
 =?utf-8?B?MnRndHdxZ1JHRDhhRkNtUWk1OSsxK3ZKNzVzTE1xeFZMUloxUXNOQms4OVho?=
 =?utf-8?B?WVFlQXJRTmdPaHN4OHBVc2dvRXFCdlpnMHNwYTZsTk9MNndoSTRWQ0plbmpj?=
 =?utf-8?B?R3cydm1xSWZ5NTExdi9vU2gwYnc3UHJxeGZqNnkzekNlQ2IzQ0JnU1hXc3NT?=
 =?utf-8?B?Uml3UUNWZUJQS2NhcEpiNVJITUlmSlBPVFpvdExwRDgwNXdUalVRVFA3YzV0?=
 =?utf-8?B?SHQwMEJNaGhxME16ZTE3aDhDc1RmU0ptK0trYmgveE04bTBtREpKaGN6OUpH?=
 =?utf-8?Q?yqknofnLQ2SV+I47cEAMSEUmB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2EE7BA769A9CC640AE3C6AB91EAFB60A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2487af-8f69-4530-4d7f-08da6533acc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 00:56:24.2488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cXCTesbyjz0pv6saP+ntrIlOATNBoN71/XysLMxJjtVosBrCcpp401E59SfvSboW766YiycAvPy4bQYIqNc49Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1716
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8xMy8yMDIyLCBKYWNrIFBoYW0gd3JvdGU6DQo+IE9uIFdlZCwgSnVsIDEzLCAyMDIyIGF0
IDEyOjQwOjUzUE0gKzAxMDAsIEpvaG4gS2VlcGluZyB3cm90ZToNCj4+IE9uIFR1ZSwgSnVsIDEy
LCAyMDIyIGF0IDA3OjU2OjQzUE0gLTA3MDAsIEphY2sgUGhhbSB3cm90ZToNCj4+PiBIaSBXZXNs
ZXksDQo+Pj4NCj4+PiBPbiBUdWUsIEp1bCAxMiwgMjAyMiBhdCAwNTozNToyM1BNIC0wNzAwLCBX
ZXNsZXkgQ2hlbmcgd3JvdGU6DQo+Pj4+IFNpbmNlIEVQMCB0cmFuc2FjdGlvbnMgbmVlZCB0byBi
ZSBjb21wbGV0ZWQgYmVmb3JlIHRoZSBjb250cm9sbGVyIGhhbHQNCj4+Pj4gc2VxdWVuY2UgaXMg
ZmluaXNoZWQsIHRoaXMgbWF5IHRha2Ugc29tZSB0aW1lIGRlcGVuZGluZyBvbiB0aGUgaG9zdCBh
bmQgdGhlDQo+Pj4+IGVuYWJsZWQgZnVuY3Rpb25zLiAgSW5jcmVhc2UgdGhlIGNvbnRyb2xsZXIg
aGFsdCB0aW1lb3V0LCBzbyB0aGF0IHdlIGdpdmUNCj4+Pj4gdGhlIGNvbnRyb2xsZXIgc3VmZmlj
aWVudCB0aW1lIHRvIGhhbmRsZSBFUDAgdHJhbnNmZXJzLg0KPj4+Pg0KPj4+PiBGaXhlczogODYx
YzAxMGEyZWUxICgidXNiOiBkd2MzOiBnYWRnZXQ6IFJlZmFjdG9yIHB1bGx1cCgpIikNCj4+Pj4g
U3VnZ2VzdGVkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQo+
Pj4+IFNpZ25lZC1vZmYtYnk6IFdlc2xleSBDaGVuZyA8cXVpY193Y2hlbmdAcXVpY2luYy5jb20+
DQo+Pj4+IC0tLQ0KPj4+PiBMaW5rOg0KPj4+PiAgICBodHRwczovL3VybGRlZmVuc2UuY29tL3Yz
L19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtdXNiLzQ5ODhlZDM0LTA0YTQtMDYwYS1j
Y2VmLWY1Nzc5MGY3NmEyYkBzeW5vcHN5cy5jb20vX187ISFBNEYyUjlHX3BnIWVpZGdCWUtyVENP
bTlYU0xocFJEc2NHY001cGttUklHLVhEd0JiT1ltZGNFV1VNMk1oV0pMZWVKSGhUbThUUE5Oczlo
T2dhSzF5VDhXLTB6ZVo1MVBpcC1WQSQNCj4+Pj4NCj4+Pj4gICBkcml2ZXJzL3VzYi9kd2MzL2dh
ZGdldC5jIHwgMSArDQo+Pj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+Pj4+
DQo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91
c2IvZHdjMy9nYWRnZXQuYw0KPj4+PiBpbmRleCA0MWI3MDA3MzU4ZGUuLmUzMmQ3MjkzYzQ0NyAx
MDA2NDQNCj4+Pj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPj4+PiArKysgYi9k
cml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+Pj4+IEBAIC0yNDc2LDYgKzI0NzYsNyBAQCBzdGF0
aWMgaW50IGR3YzNfZ2FkZ2V0X3J1bl9zdG9wKHN0cnVjdCBkd2MzICpkd2MsIGludCBpc19vbiwg
aW50IHN1c3BlbmQpDQo+Pj4+ICAgCWR3YzNfZ2FkZ2V0X2RjdGxfd3JpdGVfc2FmZShkd2MsIHJl
Zyk7DQo+Pj4+ICAgDQo+Pj4+ICAgCWRvIHsNCj4+Pj4gKwkJbXNsZWVwKDEpOw0KPj4+IEJlIGF3
YXJlIHRoYXQgdGhpcyBwcm9iYWJseSB3b24ndCBzbGVlcCBmb3IgKmp1c3QqIDFtcy4gIEZyb20N
Cj4+PiBEb2N1bWVudGF0aW9uL3RpbWVycy90aW1lcnMtaG93dG8ucnN0Og0KPj4+DQo+Pj4gCW1z
bGVlcCgxfjIwKSBtYXkgbm90IGRvIHdoYXQgdGhlIGNhbGxlciBpbnRlbmRzLCBhbmQNCj4+PiAJ
d2lsbCBvZnRlbiBzbGVlcCBsb25nZXIgKH4yMCBtcyBhY3R1YWwgc2xlZXAgZm9yIGFueQ0KPj4+
IAl2YWx1ZSBnaXZlbiBpbiB0aGUgMX4yMG1zIHJhbmdlKS4gSW4gbWFueSBjYXNlcyB0aGlzDQo+
Pj4gCWlzIG5vdCB0aGUgZGVzaXJlZCBiZWhhdmlvci4NCj4+Pg0KPj4+IFNvIHdpdGggdGltZW91
dD09NTAwIHRoaXMgbG9vcCBjb3VsZCB2ZXJ5IHdlbGwgZW5kIHVwIGl0ZXJhdGluZyBmb3IgdXAN
Cj4+PiB0byAxMCBzZWNvbmRzLiAgR3JhbnRlZCB0aGlzIHNob3VsZG4ndCBiZSBjYWxsZWQgZnJv
bSBhbnkgYXRvbWljIGNvbnRleHQNCj4+PiBidXQganVzdCB3YW50ZWQgdG8gbWFrZSBzdXJlIHRo
YXQgdGhlIGVmZmVjdGl2ZSBpbmNyZWFzZSBpbiB0aW1lb3V0IGFzDQo+Pj4gJFNVQkpFQ1QgaW50
ZW5kcyBpcyBtYWRlIGNsZWFyIGhlcmUgYW5kIHRoYXQgaXQncyBub3Qgb3Zlcmx5IGdlbmVyb3Vz
Lg0KPj4+DQo+Pj4+ICAgCQlyZWcgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywgRFdDM19EU1RTKTsN
Cj4+Pj4gICAJCXJlZyAmPSBEV0MzX0RTVFNfREVWQ1RSTEhMVDsNCj4+Pj4gICAJfSB3aGlsZSAo
LS10aW1lb3V0ICYmICEoIWlzX29uIF4gIXJlZykpOw0KPj4gRG9lcyBpdCBtYWtlIHNlbnNlIHRv
IGNvbnZlcnQgdGhpcyBsb29wIHRvIHVzZSByZWFkX3BvbGxfdGltZW91dCgpIGFuZA0KPj4gbWFr
ZSB0aGUgdGltZW91dCBleHBsaWNpdCwgc29tZXRoaW5nIGxpa2U6DQo+Pg0KPj4gCXJldCA9IHJl
YWRfcG9sbF90aW1lb3V0KGR3YzNfcmVhZGwsIHJlZywgISghaXNfb24gXiAhKHJlZyAmIERXQzNf
RFNUU19ERVZDVFJMSExUKSksDQo+PiAJCQkJMTAwLCB0aW1lb3V0ICogVVNFQ19QRVJfTVNFQywg
dHJ1ZSwgZHdjLT5yZWdzLCBEV0MzX0RTVFMpOw0KPj4NCj4+ID8NCj4gWWVhaCBJIHRoaW5rIGl0
IHdvdWxkIG1ha2Ugc2Vuc2UuICBNaWdodCBldmVuIGJlIHdvcnRod2hpbGUgdG8gcmV2aXNpdA0K
PiBzaW1pbGFyIGxvb3BzIGJlaW5nIHBlcmZvcm1lZCBpbiBkd2MzX3NlbmRfZ2FkZ2V0X2dlbmVy
aWNfY29tbWFuZCgpIGFuZA0KPiBkd2MzX3NlbmRfZ2FkZ2V0X2VwX2NtZCgpIHdoaWNoIGFyZSBj
dXJyZW50bHkgc3Bpbm5pbmcgZGVsYXktbGVzc2x5IGZvciBhDQo+IGZpeGVkIG51bWJlciBvZiBp
dGVyYXRpb25zLg0KPg0KDQorKyBKdW4NCg0KQlRXLCBKdW4gc3RhcnRlZCBvbiB0aGlzIGF3aGls
ZSBhZ28uIFlvdSBjYW4gcmV2aWV3IGhpcyBwYXRjaCBmb3IgDQpyZWZlcmVuY2UgaWYgYW55b25l
IHdhbnRzIHRvIHRha2Ugb24gdGhpczoNCg0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9w
cm9qZWN0L2xpbnV4LXVzYi9wYXRjaC8xNTg4OTI4OTg1LTE1ODUtMS1naXQtc2VuZC1lbWFpbC1q
dW4ubGlAbnhwLmNvbS8NCg0KVGhhbmtzLA0KVGhpbmgNCg==
