Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E87957406B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 02:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiGNATQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 20:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiGNATK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 20:19:10 -0400
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4470212AE2;
        Wed, 13 Jul 2022 17:19:09 -0700 (PDT)
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 942E1C00C6;
        Thu, 14 Jul 2022 00:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1657757948; bh=3WTRjPK+ty5hnyl3rc9MgUPvXPisMWNRyhiZRv7h9Tg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=O2zlB7rcuOz2XM64g/B3pnL8yv0/EXQLIfJ/Fb/QmHGzneGbjAlgNXS46anIw3DtB
         2J3Q+RDcAIC2HkEGQ/plnP+GipxCllVLF5UN95QbSxQQXVX3tccYMGbdWnSllAZZzI
         eGV1Q0eG6CJqppg9QQqBf874rbExWI4AiCeu2gvasJ3YngwFn6VtGVWgT7R8tvXpr/
         L5S9sYLuqNSyW1WxMTzaMIgRkyg88XejpyP8uYUro/Zg4qMMjdOdSSiqq9H7H27slD
         x3wBcx1yBg8JSdZAKrp2yrbaH8IO/saVbf5w8PNQm8Ioo9RlSyenNVuM8WOFIOQirc
         z4R1l3aV744wg==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3382CA0060;
        Thu, 14 Jul 2022 00:19:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 588AC800AC;
        Thu, 14 Jul 2022 00:19:07 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="EVlmrWb1";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kp7Teou9yIeUxOKaT8vil1Yx5fJCuRN3lob6c8yVNAeuCJJFKjlFtcSCZnqJGfyhjNReZek54Y8bf3Lq6aVswomRdqSFlV7Z6ac+OAhAYCmYn13nYCJFR0UaV79c6w4Y+Bmvu6POYo6/Huq93ys3th4teGh8ET4j170yyP1MGIXQ6qfxKB87SFKk361hauGafVlxaU44AX8porW5+lp73uOoUKMApJsP8rwXWLsgLuz8WkjgStvWIDhPv9Xj4KWhmHyR/tnx2kiRgZjc4aIuts5LRZMemSdgflCO1W2t6mua0sV9V403ODfaIjd7YdtkVjArDzVfuPWR4gxgo59WKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WTRjPK+ty5hnyl3rc9MgUPvXPisMWNRyhiZRv7h9Tg=;
 b=BrrETtOWno6tMTuEj6/lI2RMh3fY4qJkuCn/8YvHX1wt1XVY47ATzgF7AXxDsliUSgt2epAk1N7e3tfHXlcFyun9gqaMWyV539kNCODLyh4W/NV8T1rVQhtEpxk++CC87Q6HMlyM57TTtPsKL+SHtS4FBGX57jWyr2A40X9nvbB3unVJ4FLYac5cOjX9eTGEmB4ZPgtIfyqauejGJyJljAFnhbdveunx7OPPsaiFAIMRzJ82x/bOru77xwXVk5S/6vXbdCoDk9d1SrHPJogzmlcVQrz1KKd/zITEWVbwCxRhNKAufHk9722FQPICC7fsr+e6kY3OuqMwxOkndDg36w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WTRjPK+ty5hnyl3rc9MgUPvXPisMWNRyhiZRv7h9Tg=;
 b=EVlmrWb1icbBW29cwzDCIO/kSXLGJX79d8BxmXw18SEJKbdem9oZFxNbJ8pYRyIb3QPdliXtLQNmzE2Nos5v2rOFukXEVACqPBo2G6tpkFgU2u4eclaKJG2/Xm7XFSuTX8r7dDNIRU54u4rRwJb3uETI9J06mBmXdO5fAV/08Hs=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM4PR12MB6662.namprd12.prod.outlook.com (2603:10b6:8:bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Thu, 14 Jul
 2022 00:19:05 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c%7]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 00:19:04 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH 4/5] usb: dwc3: Allow end transfer commands to be sent
 during soft disconnect
Thread-Topic: [PATCH 4/5] usb: dwc3: Allow end transfer commands to be sent
 during soft disconnect
Thread-Index: AQHYkvuyG8yeBB+HgESO8az/W4EWca11SMkAgAYJLICAADuqAIABDQWAgABuCgA=
Date:   Thu, 14 Jul 2022 00:19:04 +0000
Message-ID: <cf292b7f-3a16-3d2e-d01f-288902b44f1a@synopsys.com>
References: <20220708185007.21743-1-quic_wcheng@quicinc.com>
 <20220708185007.21743-5-quic_wcheng@quicinc.com>
 <06498069-db45-202b-eba6-47bfa6948143@synopsys.com>
 <8029f6bb-4704-0495-00d2-ee78ee684eb3@quicinc.com>
 <889ba0fc-4a8c-cb89-ba7c-90119a58b997@synopsys.com>
 <59631540-ee6a-41f3-d460-4808162d06c9@quicinc.com>
In-Reply-To: <59631540-ee6a-41f3-d460-4808162d06c9@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd702843-4117-45db-f5dd-08da652e75ff
x-ms-traffictypediagnostic: DM4PR12MB6662:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oRLrCGS6fJc7VnHTAyjIoc5dPAc0lzphX867Hk2iOJAQEeL4gR3pKDc5PyjQ2GyaRwfuPbSOaQ24eI1H+/h8KjQhT7RpRyfEjcc2ako/fi8Rim4FsDAgri9NcC0Y6tS1jw9WsVjOLlOLBeUv8YCkrvmarHdHk/M2ziOaSAA6MyLvrQsQI/KOm1GKwSIbmHI/3XRlp7H9qFSxn71G+itWLIr/QZV/fjuYwpaliVdjRO0t0XHpW80LKRrWWfHo3yiTSaXvznmXsUUKZK+Rfu4osn5tdpjf3/gQkoix6MjvBzGflSjv3C2DxS/42m/OKuq5ZC8ItQ+PnxiSZjTfMXtfDCoNrddDDwYLSbv/g0/5yfYW16wWhgxeksTFYcA6AEv+rfYpsrYXDjQF3TqTLRnBI6S+dBrm/0i9lVtwU17Q99CQucL4UrA++QXq+v7rgoQB5FZalxOrs9BZx5O+Zz3Ao2YmKjxyXmO9LydzK6vZ8iUZja9LFFnTRV6+Wk7qJoNBQnOwyEzT1qrfGV/1fOffkG/eRaqVmR0iUrCSnNTi2GgSUEOrwnizHoHITtdvjYxTSr2P8bMrIpKhtFqylns2VcXDBiYkf9kNxvVfKzHlNPXYgZCDIGT+lRd40ncTMr7eYCagfJGMsELm55GLBJJhwhDOhDq6j+r81iPdEdqZ3vnk/gNpl5vFGt5xZx4aYRPsY/mINCvPS+eC55h8dRsbNI0psaV8N21jnJGJqcTn1fZtwKYrdI71hhNM2oWSZDPumBkNQ09xO4YqbAhuwZjf0ew6GY5t2mYVcsAXgDqIneQiPM3kJfU9Qs9eTWoHDTGX+E4nHk9dIa+iOpEyw6l1Avpr6rQa0QH4z0YKTwrNyYw3r6TksvTETQU5XL3mIuXr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(136003)(39860400002)(376002)(396003)(71200400001)(31686004)(41300700001)(36756003)(54906003)(76116006)(110136005)(66946007)(2616005)(83380400001)(316002)(186003)(2906002)(122000001)(6512007)(478600001)(38100700002)(53546011)(38070700005)(26005)(66446008)(8936002)(31696002)(86362001)(6506007)(8676002)(64756008)(66556008)(6486002)(5660300002)(66476007)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTMvR0ExY2UvbXRqMEFESjdEUllyR0JkSjlIWHhIY3ppb2l0ZDJ2YjF1eEJk?=
 =?utf-8?B?U0J3UU5Ya2NXaW1iUnpSN0o0OFF3RVYzb2FrUkpiSjlHL3RzRlpqS01ZTXRx?=
 =?utf-8?B?SWV3T0tOdEdTekdRS3dmSnFlNUEraGxtMFhwRjF2WmVtT0k3K0Z4VVJXeDBn?=
 =?utf-8?B?K0hnMWExckY1VFRIUDlSYzFOcWs5ZDEvTjNCaU1WekxMTnNZcExpUHA5VGtH?=
 =?utf-8?B?c1N3Tk9ycHRDcmVLTDU2U3NKZ01vUHl5bWRDbk9BNmZqRTNKNi9vNExuQTll?=
 =?utf-8?B?WWxkcWdzVVZHRlFyN3p6V0FkbVhCbkxxSTVFWTlMdEc1OHA2VHFrcTJvS01r?=
 =?utf-8?B?T3BWY2lncHhwZlJSVnpudlJsZk1pMmN6UEFJeHZuTmxSUkJxRXRwTnE3blVP?=
 =?utf-8?B?VWFIUDVDWHZ3RmZDb2IwbHpycjFaS0czNks3enNydzNvNm9jMUViYWdFZVUz?=
 =?utf-8?B?QlY0T2lNWjMwaWF1VWdOZzBYU01KakFBWmZnZzRjeDk3U0tWVGhJS2JxTVJ4?=
 =?utf-8?B?ME03QVNlQmVSR3p2dXFNUHZsWWdwc2d6ZHRFSEdUOFBjWk9NMGloeHNRZUt0?=
 =?utf-8?B?bm0rV0E2eW0wTUE0NW1nVzRqdjVpNVR6dUdYTGxCV0l5QXZaS25YQU1vVkxS?=
 =?utf-8?B?Z0xpMy9FNzQvWWZURVNqS3BFdjlJekExVkE4TGpXWU0rV1p6K21qS3dNcW8z?=
 =?utf-8?B?VVBjRHhyTjVNelMyQUd2a2lXeld3ajIzaDd1UlFpSXBxMVVabmNiOTNhZU1V?=
 =?utf-8?B?OUNaSGtIeTdzN1ZLblgyK3ZjTnc5MDkxRnNFeFJBSlE5WUUvcEZBenR3V0p2?=
 =?utf-8?B?cGEyNFFIZ2QvM3NxaS9PZjFMZW01M0dIWjVkbUtRVzRnQUhibDR1L0RiNVJT?=
 =?utf-8?B?SWFxMFlnQlEvalprOTNNdjhodDFLd3o1ZWFUY0cwYTNmMnFHTXZLSVhVajhQ?=
 =?utf-8?B?bHZXRUVseUw0bnhnb3FqTnd6REpwbEpXeVNqVi83RU5ocGNLa3RScDROMWwx?=
 =?utf-8?B?VTFvT3NraFVGcXk3cjFRcnB0eVVSdkt1RVdvZTlOc2lpVG9oVXk5MzIrTnEx?=
 =?utf-8?B?WHNIS0JkZEI5cTg3dUZCbTFkY011M3pLcmhud2psOVdDNklSTmk4NjYzMVdS?=
 =?utf-8?B?b0pZL0dHRmNHTFNWRGhNeDAvVnJkaXc0WlVOVTRoOWh1MGtsdzVrZ0t5TUNH?=
 =?utf-8?B?bGF1Wi9iSFkwTHNETElsVmJoekJSZUd5S1RyT3B6cGNkUEVTblFWWUplbndk?=
 =?utf-8?B?NUJhVGgzQzZsYys2RGRibGZ6cEtxNzhRdnZlR0o1dit0cm1IalFXM3RzU2Fo?=
 =?utf-8?B?WC9MbTR2RDRtVGtpUVNyOFMwbm0wdFI4NkF0R0g0MnBkdWVUQll5OERGVzVr?=
 =?utf-8?B?T3dGL2hicldqeEFQLy9kV1Zuc0pzaWpTQmhJUDFZcENJMXBZZUtqTTErZkZR?=
 =?utf-8?B?MHJYWFh2eGJLQkY5UW1SdlhuSXBmc3ZWOXJuV2pocm5EWGlhVkJSYUkwR0k3?=
 =?utf-8?B?YUp1UVExOENsYUpSMlpXY0JEQlI5NEZFSW9qOTRqN2VhZ1gwdXhjcXFZVitN?=
 =?utf-8?B?WER4ZlgxdWRpeXRsckU2WTV4TXJPcEFFMllQRjdhUmF4RmlsaEhsTEJUcW44?=
 =?utf-8?B?aDY4UE5yK2RqZ3krWlpSYWFPTGxUNnVCaExOZUFIL2wzQWh6eDUySmtkbEJr?=
 =?utf-8?B?aldjeFZCVEZTdjh6THRZUXR3d1ZnUEp4WGQrVmMrN2ptaDFyQk9ldXZZdnpS?=
 =?utf-8?B?TE90N0ZOWDJZRTV1cVZ6czdaUTJLc3M3NHNHK1BadlZNZzNReXlQcDF1RE5i?=
 =?utf-8?B?NXFYbWxGSk5uRklLeS9UbkZRSVRCSU1vcUQ0ejl1TUtFUXN2Wjdla0UxQU5l?=
 =?utf-8?B?Y1BHT3hVYVB3aDFTbFhuemJ3NFNqODE5L2FOVTB5S3BWOG5zZTFOOHdsOGRm?=
 =?utf-8?B?NXlwZkRuMy8wRGdlZXNtdEo2RjFONTF0NUtkbFprckZLbmNGR0t3U21kSmFw?=
 =?utf-8?B?YU9IVGlLQm50TTJxUlhVTkg2QTEwV202Tk9YUmJxSlc4ZjZSMSt3ME1uREc1?=
 =?utf-8?B?NjhOMVUzaDNJNWRXQkFvM0txZ25tTk5FcDhjM0hrOElvRHNMTlVtcldFNTZJ?=
 =?utf-8?Q?LiruBci8U8+4CG3JUf8MGHM8K?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2D3921BFFE33045865DA692FDCAA92A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd702843-4117-45db-f5dd-08da652e75ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 00:19:04.8800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bhlcu36C3OLIn4UF+xUUMMDmSBLsETjjd1lfu7aJXyjlXsKILHCI6NNgsQoA8YAQG2x+8YU87nfnTUN7SK7tBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6662
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8xMy8yMDIyLCBXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+IEhpIFRoaW5oLA0KPg0KPiBPbiA3
LzEyLzIwMjIgNjo0MiBQTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPj4gT24gNy8xMi8yMDIyLCBX
ZXNsZXkgQ2hlbmcgd3JvdGU6DQo+Pj4gSGkgVGhpbmgsDQo+Pj4NCj4+PiBPbiA3LzgvMjAyMiA2
OjU4IFBNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+Pj4+IE9uIDcvOC8yMDIyLCBXZXNsZXkgQ2hl
bmcgd3JvdGU6DQo+Pj4+PiBJZiBzb2Z0IGRpc2Nvbm5lY3QgaXMgaW4gcHJvZ3Jlc3MsIGFsbG93
IHRoZSBlbmR4ZmVyIGNvbW1hbmQgdG8gYmUNCj4+Pj4+IHNlbnQsDQo+Pj4+PiB3aXRob3V0IHRo
aXMsIHRoZXJlIGlzIGFuIGlzc3VlIHdoZXJlIHRoZSBzdG9wIGFjdGl2ZSB0cmFuc2ZlciBjYWxs
DQo+Pj4+PiAoZHVyaW5nIHB1bGx1cCBkaXNhYmxlKSB3b3VsZG4ndCBhY3R1YWxseSBpc3N1ZSB0
aGUgZW5keGZlciBjb21tYW5kLA0KPj4+Pj4gd2hpbGUgY2xlYXJpbmcgdGhlIERFUCBmbGFnLg0K
Pj4+Pj4NCj4+Pj4+IEluIGFkZGl0aW9uLCBpZiB0aGUgRFdDM19FUF9ERUxBWV9TVE9QIGZsYWcg
d2FzIHNldCBiZWZvcmUgc29mdA0KPj4+Pj4gZGlzY29ubmVjdA0KPj4+Pj4gc3RhcnRlZCAoaS5l
LiBmcm9tIHRoZSBkZXF1ZXVlIHBhdGgpLCBlbnN1cmUgdGhhdCB3aGVuIHRoZSBFUDANCj4+Pj4+
IHRyYW5zYWN0aW9uDQo+Pj4+PiBjb21wbGV0ZXMgZHVyaW5nIHNvZnQgZGlzY29ubmVjdCwgdG8g
aXNzdWUgdGhlIGVuZHhmZXIgd2l0aCB0aGUgZm9yY2UNCj4+Pj4+IHBhcmFtZXRlciBzZXQsIGFz
IGl0IGRvZXMgbm90IGV4cGVjdCBhIGNvbW1hbmQgY29tcGxldGUgZXZlbnQuDQo+Pj4+Pg0KPj4+
Pj4gU2lnbmVkLW9mZi1ieTogV2VzbGV5IENoZW5nIDxxdWljX3djaGVuZ0BxdWljaW5jLmNvbT4N
Cj4+Pj4+IC0tLQ0KPj4+Pj4gwqDCoMKgIGRyaXZlcnMvdXNiL2R3YzMvZXAwLmPCoMKgwqAgfCAz
ICstLQ0KPj4+Pj4gwqDCoMKgIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCA1ICsrKystDQo+
Pj4+PiDCoMKgwqAgMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pDQo+Pj4+Pg0KPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZXAwLmMgYi9k
cml2ZXJzL3VzYi9kd2MzL2VwMC5jDQo+Pj4+PiBpbmRleCA1MDZlZjcxN2ZkYzAuLjU4NTFiMGU5
ZGIwYSAxMDA2NDQNCj4+Pj4+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZXAwLmMNCj4+Pj4+ICsr
KyBiL2RyaXZlcnMvdXNiL2R3YzMvZXAwLmMNCj4+Pj4+IEBAIC0yOTAsOCArMjkwLDcgQEAgdm9p
ZCBkd2MzX2VwMF9vdXRfc3RhcnQoc3RydWN0IGR3YzMgKmR3YykNCj4+Pj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaWYgKCEoZHdjM19lcC0+ZmxhZ3MgJiBEV0MzX0VQX0RFTEFZX1NUT1ApKQ0K
Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOw0KPj4+Pj4gwqDC
oMKgIC3CoMKgwqDCoMKgwqDCoCBkd2MzX2VwLT5mbGFncyAmPSB+RFdDM19FUF9ERUxBWV9TVE9Q
Ow0KPj4+Pj4gLcKgwqDCoMKgwqDCoMKgIGR3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXIoZHdjM19l
cCwgdHJ1ZSwgdHJ1ZSk7DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgZHdjM19zdG9wX2FjdGl2ZV90
cmFuc2Zlcihkd2MzX2VwLCB0cnVlLCBkd2MtPmNvbm5lY3RlZCk7DQo+Pj4+PiDCoMKgwqDCoMKg
wqDCoCB9DQo+Pj4+PiDCoMKgwqAgfQ0KPj4+Pj4gwqDCoMKgIGRpZmYgLS1naXQgYS9kcml2ZXJz
L3VzYi9kd2MzL2dhZGdldC5jIA0KPj4+Pj4gYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+
Pj4+PiBpbmRleCBiZDQwNjA4YjE5ZGYuLmZiYTI3OTdhZDlhZSAxMDA2NDQNCj4+Pj4+IC0tLSBh
L2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4+Pj4+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMv
Z2FkZ2V0LmMNCj4+Pj4+IEBAIC0zNjk2LDggKzM2OTYsMTAgQEAgdm9pZCBkd2MzX3N0b3BfYWN0
aXZlX3RyYW5zZmVyKHN0cnVjdCBkd2MzX2VwDQo+Pj4+PiAqZGVwLCBib29sIGZvcmNlLA0KPj4+
Pj4gwqDCoMKgwqDCoMKgwqAgaWYgKGRlcC0+bnVtYmVyIDw9IDEgJiYgZHdjLT5lcDBzdGF0ZSAh
PSBFUDBfREFUQV9QSEFTRSkNCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0K
Pj4+Pj4gwqDCoMKgICvCoMKgwqAgaWYgKGludGVycnVwdCAmJiAoZGVwLT5mbGFncyAmIERXQzNf
RVBfREVMQVlfU1RPUCkpDQo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0KPj4+Pj4gKw0K
Pj4+Pj4gwqDCoMKgwqDCoMKgwqAgaWYgKCEoZGVwLT5mbGFncyAmIERXQzNfRVBfVFJBTlNGRVJf
U1RBUlRFRCkgfHwNCj4+Pj4+IC3CoMKgwqDCoMKgwqDCoCAoZGVwLT5mbGFncyAmIERXQzNfRVBf
REVMQVlfU1RPUCkgfHwNCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKGRlcC0+ZmxhZ3Mg
JiBEV0MzX0VQX0VORF9UUkFOU0ZFUl9QRU5ESU5HKSkNCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcmV0dXJuOw0KPj4+Pj4gwqDCoMKgIEBAIC0zNzQ0LDYgKzM3NDYsNyBAQCB2b2lkIGR3
YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXIoc3RydWN0DQo+Pj4+PiBkd2MzX2VwICpkZXAsIGJvb2wg
Zm9yY2UsDQo+Pj4+PiDCoMKgwqDCoMKgwqDCoCBfX2R3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXIo
ZGVwLCBmb3JjZSwgaW50ZXJydXB0KTsNCj4+Pj4+IMKgwqDCoMKgwqDCoMKgIHNwaW5fbG9jaygm
ZHdjLT5sb2NrKTsNCj4+Pj4+IMKgwqDCoCArwqDCoMKgIGRlcC0+ZmxhZ3MgJj0gfkRXQzNfRVBf
REVMQVlfU1RPUDsNCj4+Pj4NCj4+Pj4gQ2FuIHdlIGNsZWFyIHRoaXMgZmxhZyBpbiBfX2R3YzNf
c3RvcF9hY3RpdmVfdHJhbnNmZXIoKS4gSXQgc2hvdWxkIA0KPj4+PiBhcHBseQ0KPj4+PiBpZiBF
bmQgVHJhbnNmZXIgY29tbWFuZCB3YXMgc2VudC4NCj4+Pg0KPj4+IEkgd2FudGVkIHRvIG1ha2Ug
c3VyZSB0aGF0IHdlIHdlcmVuJ3QgbW9kaWZ5aW5nIHRoZSBERVAgZmxhZ3Mgb3V0c2lkZQ0KPj4+
IG9mIGEgc3BpbiBsb2NrLsKgIFBhdGNoIzMgbW9kaWZpZXMgaXQgd2hlcmUgd2UgdW5sb2NrIGJl
Zm9yZSBjYWxsaW5nDQo+Pj4gX19kd2MzX3N0b3BfYWN0aXZlX3RyYW5zZmVyKCksIHNvIHdlIGNh
biBhbGxvdyB0aGUgZHdjMyB0aHJlYWRlZCBJUlENCj4+PiBoYW5kbGUgZXZlbnRzIHdoaWxlIHRo
ZSBjbWQgc3RhdHVzIHBvbGxpbmcgaGFwcGVucy4NCj4+Pg0KPj4+IE1heWJlIHdlIGNhbiB1bmxv
Y2svbG9jayB0aGUgZHdjMy0+bG9jayBpbnNpZGUNCj4+PiBfX2R3YzNfc3RvcF9hY3RpdmVfdHJh
bnNmZXIoKSBhbmQgdGhhdCB3YXkgd2UgY2FuIGVuc3VyZSBERVAgZmxhZ3MgYXJlDQo+Pj4gbW9k
aWZpZWQgcHJvcGVybHk/DQo+Pg0KPj4gSSBkaWRuJ3QgcmVhbGl6ZSB0aGF0IHlvdSB1bmxvY2sv
bG9jayB3aGVuIGNhbGxpbmcNCj4+IF9fZHdjM19zdG9wX2FjdGl2ZV90cmFuc2ZlcigpLiBXZSdk
IG5lZWQgdG8gYmUgY2FyZWZ1bCBpZiB3ZSB3YW50IHRvDQo+PiB1bmxvY2svbG9jayBpdCwgYW5k
IGF2b2lkIGl0IGFsbCB0b2dldGhlciBpZiBwb3NzaWJsZS4gSXQgY2FuIGJlIGVhc2lseQ0KPj4g
b3Zlcmxvb2tlZCBqdXN0IGxpa2UgZHdjM19nYWRnZXRfZ2l2ZWJhY2soKS4NCj4+DQo+PiBXaGF0
IGlzc3VlIGRpZCB5b3Ugc2VlIHdpdGhvdXQgZG9pbmcgdGhpcz8NCj4NCj4gSSBzYXcgZW5keGZl
ciB0aW1lb3V0IGlzc3VlcyBpZiBJIGRpZG4ndCBkbyBpdC7CoCBJZiB3ZSBrZWVwIHRoZSBsb2Nr
IA0KPiBoZWxkLCB0aGVuIHRoZSBEV0MzIGV2ZW50IHByb2Nlc3Npbmcgd291bGQgYmUgYmxvY2tl
ZCBhY3Jvc3MgdGhlIA0KPiBlbnRpcmUgdGltZSB3ZSBhcmUgd2FpdGluZyBmb3IgdGhlIGNvbW1h
bmQgYWN0IHRvIGNsZWFyLsKgIFdpdGggDQo+IHVubG9ja2luZyBiZWZvcmUgcG9sbGluZywgdGhl
biBhdCBsZWFzdCB3ZSdyZSBzdGlsbCBhYmxlIHRvIGhhbmRsZSB0aGUgDQo+IEVQMCBldmVudHMg
dGhhdCBhcmUgcGVuZGluZy4NCj4NCj4gSXQgd2FzIGRlZmluaXRlbHkgb25lIG9mIHRoZSBoYXJk
ZXIgc2NlbmFyaW9zIHRvIHJlcHJvZHVjZS7CoCBUaGUgbWFpbiANCj4gcGF0Y2ggc2VyaWVzIHdo
aWNoIHJlc29sdmVkIGEgbG90IG9mIHRoZSBpc3N1ZXMgZWFybHkgb24gd2FzIHBhdGNoIzEuIA0K
PiBBZnRlciBhZGRpbmcgdGhhdCB0aGUgb3RoZXIgaXNzdWVzIGFyZSBzZWVuIG1heWJlIGFmdGVy
IGEgZGF5IG9yIHNvIG9mIA0KPiB0ZXN0aW5nLg0KPg0KDQpJIHNlZS4gVGhlIHNvZnQtZGlzY29u
bmVjdCBzdGlsbCBnbyB0aHJvdWdoIHJpZ2h0Pw0KQ2FuIHlvdSB0cnkgdGhpcyBhbmQgc2VlIGlm
IHRoaXMgd29ya3MgZm9yIHlvdT8NCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2Fk
Z2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQppbmRleCAxM2U0ZjFhMDM0MTcuLjRm
NjdhNDg0YzQ5MCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCisrKyBi
L2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCkBAIC00NTEsNyArNDUxLDkgQEAgaW50IGR3YzNf
c2VuZF9nYWRnZXRfZXBfY21kKHN0cnVjdCBkd2MzX2VwICpkZXAsIA0KdW5zaWduZWQgaW50IGNt
ZCwNCg0KIMKgwqDCoMKgwqDCoMKgIGR3YzNfd3JpdGVsKGRlcC0+cmVncywgRFdDM19ERVBDTUQs
IGNtZCk7DQoNCi3CoMKgwqDCoMKgwqAgaWYgKCEoY21kICYgRFdDM19ERVBDTURfQ01EQUNUKSkg
ew0KK8KgwqDCoMKgwqDCoCBpZiAoIShjbWQgJiBEV0MzX0RFUENNRF9DTURBQ1QpIHx8DQorwqDC
oMKgwqDCoMKgwqDCoMKgwqAgKERXQzNfREVQQ01EX0NNRChjbWQpID09IERXQzNfREVQQ01EX0VO
RFRSQU5TRkVSICYmDQorwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAhKGNtZCAmIERXQzNfREVQQ01E
X0NNRElPQykpKSB7DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IDA7DQog
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gc2tpcF9zdGF0dXM7DQogwqDCoMKg
wqDCoMKgwqAgfQ0KDQoNCldlIGNhbiBzZXQgaXQgYW5kIGZvcmdldCBpdCB3aGVuIHdlJ3JlIGFi
b3V0IHRvIGRlLWluaXRpYWxpemUgdGhlIA0KY29udHJvbGxlci4gSnVzdCBsaWtlIHdoYXQgd2Un
dmUgYWxyZWFkeSBkb25lIGJ5IG5vdCB3YWl0aW5nIGZvciB0aGUgRW5kIA0KVHJhbnNmZXIgZW5k
cG9pbnQgY29tbWFuZCBjb21wbGV0aW9uIGludGVycnVwdC4NCg0KVGhhbmtzLA0KVGhpbmgNCg==
