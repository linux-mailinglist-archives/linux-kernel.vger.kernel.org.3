Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11F64B6346
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 07:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbiBOGKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 01:10:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbiBOGKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 01:10:17 -0500
X-Greylist: delayed 306 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 22:10:08 PST
Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.85.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45EFDEFFA6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 22:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1644905406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SbqvTQzFngHF2cL/9y9WTnTOjingLO/iT3UZxMQ0QbI=;
        b=PUakHXTTGEjsCFJ/BuvfKbqzryZTSUT97wk0sPY2mUMjrhO1aTHfPUAq7/7+TSZ9J239ve
        IOs3YxDkdZzmhJYbSHo9Rl2g+zmEer65TiIy8HadUglb5uFR8G18Gki68K2AlB74T7AUX3
        4taVEMDy9k89UVT3w92XJfZgSr8jI8g=
Received: from GBR01-LO2-obe.outbound.protection.outlook.com
 (mail-lo2gbr01lp2051.outbound.protection.outlook.com [104.47.21.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-281-mB1gSnJuNk2jmeB6cOOhLA-1; Tue, 15 Feb 2022 06:03:22 +0000
X-MC-Unique: mB1gSnJuNk2jmeB6cOOhLA-1
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:16b::6)
 by LO2P123MB3774.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:124::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 06:03:21 +0000
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6dad:8602:45c5:6747]) by CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6dad:8602:45c5:6747%8]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 06:03:21 +0000
Message-ID: <9d5cff18-5493-f6dd-4bd6-9bafa2a503a7@camlingroup.com>
Date:   Tue, 15 Feb 2022 07:03:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] serial: imx: leave IRTS disabled if using modem-control
 CTS
To:     Tim Harvey <tharvey@gateworks.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Richard Genoud <richard.genoud@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
References: <20220214213020.685-1-tharvey@gateworks.com>
From:   =?UTF-8?Q?Tomasz_Mo=c5=84?= <tomasz.mon@camlingroup.com>
In-Reply-To: <20220214213020.685-1-tharvey@gateworks.com>
X-ClientProxiedBy: DB6PR0501CA0001.eurprd05.prod.outlook.com
 (2603:10a6:4:8f::11) To CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:16b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e9d4781-2ac2-43fb-39cc-08d9f048de74
X-MS-TrafficTypeDiagnostic: LO2P123MB3774:EE_
X-Microsoft-Antispam-PRVS: <LO2P123MB377490FC9FF574D05255F43692349@LO2P123MB3774.GBRP123.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: jjWdEcCQKryBC75jzNZ28UnbqcBIskGXRhgLM7p+hfkM9Ldr6z+OvuEJqB661R+zI5OhdIUeohn1PsEdObS85ADbWqmgxpMYO75IGMCyit/5ig2fgonMeFb8O/ABGFHsKTqvm4ZidxTluVnc5QMAxYyTBrxHu/BOlCj14DYSZXb+VTmOdH57kCev60gjl4k0/VkAzFN+OHrq9Ec2kevzzeXs13kj9j+pg6Cyyhw5/PXHnkrFcYRlM264R/T+rn7QbTzS5i5+TDmBmUzRoB3ngj3SblRbanMIcZKz8nYMjzgB1JnNvS0oC3pwLdlswYZ7X8GbA9YHLA/YDjrsnr3BaEt2uHBBx9FK4u98LoDu2IlchRebEsBQTN1sNBx/7GJh8UTMmfOiukd+U6oL0MwPhcSlHioAeTivnIqqrjchv9wUcOW8861g2C0IeVuMM770rFHnfVkl1vWmhX461SMpIS5ek0tNywzuUhPAtCnBacHFPlAs1k5EZMw1vtLt2CltOjBTQbAMrnDXOrhnaysXx+zOYun2Yi86P3x6hIRqortu6ixNMVRGhFKbRJ7t2ICZmFd6SN1HWbib0UNgMY4UyJUXRVCB8BQHMM7IPR7RsEeu00y9p0ZB2OJh8X2Obq+MiitMGXYf5Pzew/bSFqk7LLHRn2Kd9zmuDkHyfnxHYWZA5oLkCSNfhpCQH7pa0uEExXwBqpjVBLnsRlNBcFeVAHA720nmDp2i2WYrMgfb4Ykrg2ogNt2E2tW2IxND9ovWttQ3+ySD8JAudnWYqf/5+dKNIJKiCGI353UQRs8Qqyo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6486002)(7416002)(921005)(83380400001)(36756003)(31686004)(2906002)(4744005)(31696002)(6666004)(2616005)(54906003)(52116002)(6506007)(5660300002)(316002)(38100700002)(38350700002)(86362001)(26005)(186003)(66476007)(53546011)(8936002)(8676002)(4326008)(66946007)(110136005)(6512007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVBXcjJVYm1mYWtHR1dtNDZseCtSeUFCNlBYelp2dlVYazdISHJ2SENrK2tm?=
 =?utf-8?B?Yy9LZC9DUTZiSy9aYnppc3RubTF2M3VHYzV5S1FJSlpTT2g1aG1aczR5Tk5H?=
 =?utf-8?B?YWc0R3Jqa3kwRkM4TzZUSk9zVC9lTUIyeUhrZmZqeEx3ak5qV2cvUGpZeVR1?=
 =?utf-8?B?VnFabEN1aWxEVEx0R2RmK1p6d3hiOGhlQVpDQ3F3RjRiRFFkUmMrQzc2K0U1?=
 =?utf-8?B?UWFXNDlETVU2WW9LQ2R5cWJhUGZGVUsybGdUdHIrd000QWV2OXlyaGt1Z25n?=
 =?utf-8?B?Vk5kQ2lYb3NiaU9DM0pORXI3MDJmVUhTbTFlS1BpdkFZWTdHYU5zVXE4d2Na?=
 =?utf-8?B?cy8xM0dwYUd2NUQwd1Y5VHl6VGpCWERxcGk5eml2ckxTR3Z0dHJPUXNOZlk2?=
 =?utf-8?B?cVJNMXpBVDRITy9UMytGZWQwbzRxSVM3cnVzMTZRdmFCdTBOcmxJY0lOb0xh?=
 =?utf-8?B?eVpoOGo1SW5rT2xRMmdRYlRwSXNHYmlKYm5PN0FiOHRJQmRtR3hhU2JsWXht?=
 =?utf-8?B?cHpMd2c0Q21CTEwwTDdtQTRYRDJ2eG52YmVtb2cvam9IaVpna3pLSmFmSlNN?=
 =?utf-8?B?UmpyN3F5ZFRuTWNmU3p6UGhsNmJDUGtFUXpUM2pKaDBXS2Z4emc4M0t3VWpM?=
 =?utf-8?B?RGdobk9rS3NnNm8wSjBrTFlvZnFpOEVMUWxkdTlwOFJYQlRNY0JZUlRXQzVZ?=
 =?utf-8?B?ZUNHaWJueXlIcmpkWitQNXE5bXdUWTB2cFk4cW9iVXBaT3Vmck5VYXNjaDVq?=
 =?utf-8?B?R3VMb3UrM2pIM3o4R1UvWjZXNFdNZjJ1V0hCQjlYN3IycmY5cVZ2V29DTTMy?=
 =?utf-8?B?RUYvaURuSE5xMncyakU0Q05uVUpNcUUwb25WWlpsc296RHNLeWY5OHhWaWZ0?=
 =?utf-8?B?ZHNjUk9XMXpsSFQxZk8xRVVLUHpvQnV6QXNCcCtFeit6SkU3WGNnUGNPWXJU?=
 =?utf-8?B?LzlYV3AzYlVJaXc5eEwvQ3VhWGVXQUMrS21WekQvdXhTNmU3RzYwYnlXSkpv?=
 =?utf-8?B?b215U0o0YnlhZ2ttdmFlVm5DbFpaZ2M1SkwzZVZLUE1XVlNiUldKWm93cHNN?=
 =?utf-8?B?ZGJUZVcwempIb09lWTdsTFVOMFZtVlVBVWgrNXloR0pYQXpoRTZhN3NzL084?=
 =?utf-8?B?L1dFbGJFeXkyQmlhNkdEenpZS28zcHJVRTJOMTMzZHI0dWRFL2d5UU5wSXZ3?=
 =?utf-8?B?TG9vdTFSdWI2WVNuYW1YQTBEVUc4WGQyUXd2ait0dWZ1SmZWR0N3cjZRaHQw?=
 =?utf-8?B?NEM0bEpZY2hZaWkzQ0FpaE5TZmkwRGpWS1FnMkM1NVpYZTVDZVBLbmIvUVhE?=
 =?utf-8?B?d1FWSnFaeEtWZmFCLysxeDN3b3Npc3BQeVJ0WUYrU01FVk5EZ0xNZ1ErbzIy?=
 =?utf-8?B?MDRreWRQeitUNmRoSFE5Z0ErcU5YeGhSTkNJWnFlanNZd3BBV2g2WnpEWGEz?=
 =?utf-8?B?bnk1cGlrRk5ZaHhqd25reFNnaGg3M2ZSNWZXTFU3MTJGOFVPeDhGY0JNZzhz?=
 =?utf-8?B?cFYraEpDdG0wVUpyeWpFaURPQkliOW14enhqSUdDQnYwVUJReE9NRWxYbVZt?=
 =?utf-8?B?ZGtVMFA5dUpKSnc1b0RBN3RUYmwrKzVRSldRdWZEMFY4MDYrNjBmbzFZN1gy?=
 =?utf-8?B?OHFWTmhuK2lmT2hZL0JRRElHQnJ2Qmdidm5QWDV3WUdYNklJdXJCNWFSUUZ3?=
 =?utf-8?B?UCs1alVsWjR1b2E5b05Pd2ZCUytKWmFMemNxajFveUVFcFVTdlNFUndSV1lv?=
 =?utf-8?B?aXNZbEtmOHEvWi9uUThKSVNXdnkxS1lrbHlodjNEUFZQVnNXZ3dES2lSNmtV?=
 =?utf-8?B?VTRvTHh5VXNGMWlLU3duT1p1S2R3elc3M1JZSTVmeTVDOEtiUnFSUE43SE5h?=
 =?utf-8?B?Y3J3dXFwdGNCQ3dxb3pldEluRHBqVDQ2N3RLSm5jNDdybXk4dFNzR3RoekJl?=
 =?utf-8?B?TmxkUlpTWkxFaFNKekVSSzdJejU1M0xJaWoyc0ttN09sbXEwSXBFNFJ4dTFR?=
 =?utf-8?B?VjBpRStuZlZlQndUWnd4eis4MHg5aG5mSjJibk9EeE5IUzBqUmNDekU0NTFs?=
 =?utf-8?B?ZmxDRkJ6QnQ2YUdyVm5pcDFxcTlZQk5uQmhmeWw2YUsyM0J0UHEzcGxHSjVJ?=
 =?utf-8?B?bDZ0VFFFVkJqNWhlRVVwbzZIL29BdGhQK0EyL2R4NUxhSjladWUxWUNVang3?=
 =?utf-8?B?cXl2NE16K0lPaFpYNDIxSHZGWHRaT0NqT2JxMzNQZiswK2VBN0l4dEl1OW1V?=
 =?utf-8?Q?q4YfRTxIHXkg2OCbJfm4gqybhnEjQj1P5dgxXFh8Xk=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9d4781-2ac2-43fb-39cc-08d9f048de74
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 06:03:21.1502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EBWdemYB3qtU+78GG6Ela4BpYLCBR5SQahhSeFgdH9nIybDCHSCA5jcwuef90nwKiASaU3Hsv0g9if4cwbR0On3ENN/TUzwWSw7g1EYbM/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB3774
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUK97A341 smtp.mailfrom=tomasz.mon@camlingroup.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.02.2022 22:30, Tim Harvey wrote:
> If using modem-control gpios for CTS we must leave IRTS disabled
> as otherwise the hardware will only transmit based on the internal RTS
> pin routed to it.
>=20
> This allows hardware flow control to be used with cts-gpios.

This hardware flow control sounds quite limited. Once CTS becomes
inactive, the transmitter will still output all characters from TxFIFO.
Transmitting whole TxFIFO already sounds quite bad, but that's the best
case scenario where gpio interrupt is handled right away without any
delay (so more than TxFIFO characters can actually be transmitted).

Does the internal RTS default to inactive when it's not pinmuxed to the
actual pin? If so, then controlling UCR2_IRTS based on CTS gpio could
halt the transmission when the TxFIFO is not empty.

Best Regards,
Tomasz Mon

