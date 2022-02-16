Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F255D4B87DE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 13:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbiBPMmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 07:42:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiBPMmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 07:42:23 -0500
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50104.outbound.protection.outlook.com [40.107.5.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5A02AE09;
        Wed, 16 Feb 2022 04:42:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kp9dVVYIDPx2l+goqEBU6Vnq2BwX5lHfoL0LXCuj86TGw2fdapDsJiymWlnQ4QkUtWMqfuKNDhS9WP9OILmUjmLkCLzHM6SSltx3d0ruZNiL6z7MSX9Cfd+a6hDHdKQBNBPjweKHrs2a2oitJLAQ3boxfLzDKaTDjZkwzZ2Tgo2ballGcq0jTPuolnlSTvgIUbWTKyhYV6gbtGhpMwb1qSsCT0uvp6Pr0Hks6Bl2HXmWGok2YUZnOse4lI3Wv5JUkczZlT/5dFRTzAfiSwxUD6bUNkmXIVunq5y3mPxqMmjQvmQOO+em9QAuwFkCfmM3hS0Dh0GPEERxYZ9H8Iecsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSvCFLXM3JpkHs7m4eY9cx44P0AkRnPz0T3uWDY8kVQ=;
 b=PPlaxvofAubNUQIFjCGnb0jcewmsbryayPyOoOIUrAkneoG7CHonOIe7dZoObjV1V4dbNWXsDnmV4LFbRAPY/x70ezMQ1DxVILMMWCVj5Q1NdqjKKCaTK5o2ypSI3ddlTCH9a4TxGAu+vxx+dXIg4rekG2l4e6Qv/D6/nfIV1DcXKmU0fFq7A/KPP1JHrn2wCwRuJfHAym7GwlO5OJErbFJ3C8YSxQRP+iqEtDpE5MzWiPCrDSiUBfEa/FlWQZORbyePoimfsUb7EWxb5CLqqpwIHGYiLmOiK4+YlaNBFVoHSi0pIXZa/eyqkBCec726Wx8Bk2stQ7mFOQUPkctUpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSvCFLXM3JpkHs7m4eY9cx44P0AkRnPz0T3uWDY8kVQ=;
 b=VSIx3/vOmndsgLyiG/m/J6qPX8mOfxBXQc8raQItJs7xoulmYrAT8M8UyO4ibkm4GJpcVHbiSePnl+phCD5gkOzbbigfmDOi3H8OYe+N0CYMXxz44KhJe+O09dQbyUaFDe92ce1KWb/f067sQReYMVHEzlIIXgL/zNlwGmPxkGA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AM7PR07MB6916.eurprd07.prod.outlook.com (2603:10a6:20b:1b4::19)
 by AM4PR07MB3490.eurprd07.prod.outlook.com (2603:10a6:205:11::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.5; Wed, 16 Feb
 2022 12:42:08 +0000
Received: from AM7PR07MB6916.eurprd07.prod.outlook.com
 ([fe80::594:fa1f:92c5:e546]) by AM7PR07MB6916.eurprd07.prod.outlook.com
 ([fe80::594:fa1f:92c5:e546%5]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 12:42:08 +0000
Message-ID: <2f7780b8-ce67-6cd6-4097-d8113f557444@nokia.com>
Date:   Wed, 16 Feb 2022 13:42:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v3 2/2] hwmon: Add driver for Texas Instruments TMP464 and
 TMP468
Content-Language: fr
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>
References: <20220216070720.2131761-1-linux@roeck-us.net>
 <20220216070720.2131761-2-linux@roeck-us.net>
From:   Agathe Porte <agathe.porte@nokia.com>
In-Reply-To: <20220216070720.2131761-2-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR0101CA0010.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::20) To AM7PR07MB6916.eurprd07.prod.outlook.com
 (2603:10a6:20b:1b4::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3936672b-0d4b-4669-6343-08d9f149bec4
X-MS-TrafficTypeDiagnostic: AM4PR07MB3490:EE_
X-Microsoft-Antispam-PRVS: <AM4PR07MB34905C90100238C9B031B44E9B359@AM4PR07MB3490.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mOxPSQckbO4Fs1rUb+wo33jLxM5Q3tt4J8ADf/bk4VOzqyuU5POZ79T7x5WcTOcUJ7ecH+wHeQb6SqAhyL+P+FPl3vNrWw5o/Gthekr9P1Q3H9txXrDyffpXqjWYS8cLda9pGX8/rEs1pnD4HWZzxTuUjRokrBMTZHqF3ACuxyNZM06sMPchFBROP/mHGSZpcJfYCcYGebLeuLekVZ72DQb8LthmtMZn+/Al6jsVzVBU5j3b+Q2utQapJNVklmOGJQbHXti4OK/vOJSCVZSUI68UjROJrTXiDa9DujkyyCtZQnTCA8GNNfOcfRA0w/YPU7XdPeeYfhCTKGW+KVCP1rjZMRtJuQ4lRueJJ2FE90MxLSjizmZV5sPQiMqU0AJZkvjxVYnIhktipLJjhzvpEKXLV0FPEc0EDVzIkGXziapVChClgy0RHNZRibv2/H5BBBpOMTH2Suir9F53YonMQSM1Bz02OynbUp5K9OqklrNXPSzVxZTkL11AIobkn+kjuTiouQHvCVUGSI3u5+AgWM1Pdh2SIp5PDgnWGcZpPnKNEbSRLElu9GSxqL5Opljs3Zx+btxtiLe2w09GFN6YnYkUpafkvy3X9JPB8Nkw1FlqbtZpR9AR+VE/QXPinsZiY10nsQfl81lLr4gXWory+4b6T8BmqjtJahi65+fAyMauRDacTaNgh5MxAKwlhezdB4Ae5wd8PCCh/4DlfuoYSd8cfg+DkD2Oo9fxJOhlofo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR07MB6916.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(508600001)(2906002)(6512007)(6486002)(6666004)(6506007)(82960400001)(107886003)(316002)(44832011)(2616005)(38100700002)(8676002)(66946007)(4326008)(66476007)(66556008)(8936002)(31686004)(66574015)(31696002)(5660300002)(83380400001)(186003)(54906003)(26005)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEJPWWhpeWhScXRCd0hyQjlYS1pFQVVVUjlnc1NLeEhYbElDTGhReVdweHdR?=
 =?utf-8?B?aWRvM04rYyt0VWJ5ZFc2UzFyejBkRkIxV05ycFd0Vnpjb21CNXl5TTFBNjVD?=
 =?utf-8?B?VlBEOHhYK2FmTG81eSsxdVZjS1lyUkg2UXdwSmxLN1J2OFZ5RThCQnRBY3lS?=
 =?utf-8?B?ZEpNRjJFQ1djYzh0aCt5ZE9XR0N5SGZwRlU2VDFnMWFIblY5TkhpSGxNZ1BE?=
 =?utf-8?B?YlJySU45L3hhNU13OFYwTlJWaTNBblB2dUFWa0hGVVVka3ZReDRqc3hZdXp0?=
 =?utf-8?B?U1ZWNXRDZFRmamUzOUlqN3luNDNWMEtkQU50TGJnd3NNU0UrK0JhL3dGVWVv?=
 =?utf-8?B?MVUraUtmOGl0RFdhTGhvL1hkcVRuREF3NElSS0tnc2VueWFWdFg1WXRIbFZP?=
 =?utf-8?B?YzhWaTRZVTdEY1BDd1ZzMnBMS1ZBSForS1ljaGR2M0YyK0luUSthbHp1VlYw?=
 =?utf-8?B?T1ZYWWc5dzJ1dldyeGtnMXNkMzJqNTdpMjVGWGpCMHRRSEx5cG5hYnVxK0Jh?=
 =?utf-8?B?UnR4TGFlMkdmWlJnZ3BqZG50WVU2R0o0RFlKSEF4ZHZBUGptMFBldCtlY0R1?=
 =?utf-8?B?ZzhWSjkyNFpmRkN5Vk1IYmlOMVJPN0FxUWlwWUFsZXhqZW5DSlpkdDFuWjhX?=
 =?utf-8?B?QXlOUDE4TG13bVdaSytDVU83UW1yY0wxd2Z5bnFBNHYxUFdVaHJZYWpUT0g3?=
 =?utf-8?B?aVMrL0FCRGIzMlo5clI1cWtiVC9pZ3ZuZitNWXlBNFlRV21iYXpSbVYzc2Fj?=
 =?utf-8?B?MlVjazM4YTFXZWRVdWhQcGNUWEJPRWwwb3BvZXhacUExQVZ6ZmoxU1kwNThk?=
 =?utf-8?B?NlVFN2o0dW9mbUcxOWZwbkNOYkkrdnVFZlB3dm9HRUppRS8veXFaMkt1eHVU?=
 =?utf-8?B?R25qNkpRejM2bkhwRHRPTG9zTmw5ZHRnVU1tSGdUZTJNdjdlMmplWVdpWmtQ?=
 =?utf-8?B?SUgwNTdZVndPZnc1cStiSjZnNmVvVW55dkJRTUpHYTcwVXJpVFFaYUE5OEI0?=
 =?utf-8?B?bExEQ3hsMEZlYkZVOWlDdWJwS1Rpcys1cS9qdzdXSFZlV201WFVDOEhkQWla?=
 =?utf-8?B?QkR6a1ViVXlPN1VwSGV6MWxXNmpuamJ3akhTLzNrbkRLWDdCV201c0RGT3Nx?=
 =?utf-8?B?UzBYTm9SSHpxRG9INnFhMTYxNkZzSVRzL3FqOE9VYmVaRHJDM0p1UmNRa0Vu?=
 =?utf-8?B?ZjFPVnRFd0ZmN08vYVRJbTBSYkhLUWhkMi9XVUVmQWpzaVhvYnNIdWh1U3lz?=
 =?utf-8?B?bDJNWDh6eEJHa2M4YVdTK0R1aFl6NzdFZktwVnhJQzNtWDM1TDdXR3p6a2hH?=
 =?utf-8?B?OUltRzZTTGFtV0dibm5DcVl4dVFFVmk4WFlVVXdCVUVlRHcraHNvNGNpYm5r?=
 =?utf-8?B?ZFRzd3E1VjhIc1JyTlp0a2VYL3g4MHQyN0NSRkpSK3pCdmJ4ckhIbTNWakYr?=
 =?utf-8?B?TDc2TVp5VEtLV09zeGxKOHI0NTA2Vk96R1FCYk9DNm5EUWJlWnFMbHBLN1Ey?=
 =?utf-8?B?K0kvQTF1QW5NTGdNRTkvRGJJSnh3NjJPYW43aFNIVHN3Z2pZQXNvQ1lRaWFM?=
 =?utf-8?B?K1EwOTNNcFAwbVBiNVlXcWp2T0FWa0R3cGRHTnh6T1ZxN0p4ZUJRcWtteTRo?=
 =?utf-8?B?RnR4TTIyc0R5eFduT0xPREg3WFFlQk4wOG42bmh2V2dRbWVSeURraGwvMHRy?=
 =?utf-8?B?UVlXRHQ3MHNDZkhHOGo5dTF1Z1dSekJubGp3dDloT2gwMVE3K1FKeUM0TjFj?=
 =?utf-8?B?UFExMVNBSTRoSFAyWFF0SEEzZUMrUy93ZXlPM0Qza1I3ZGtGd2NsTi9NQUVC?=
 =?utf-8?B?TG16R3BuMmVEaFVaMFFMYzlwT3dud1FtTzRvTlpyaHl0VlVSWGdnQlg2cWFS?=
 =?utf-8?B?Skt0RlRDS0JlRzV6dWU2cy9MUDAyUFFBQXNUQ3lrRUZJWWVXZEtQMmI3MkRR?=
 =?utf-8?B?WG1vMXNwYmVwOWxiaUY5bDIyNEVuR1lrVWZWTG9mN09FcmYyN0VTLzRZcGF0?=
 =?utf-8?B?NE5aQnFDQXVYaGRyVUJ3dnhIaXRpQllLZ1h3NE01cklWSjBxdlZXM1pkZmtz?=
 =?utf-8?B?dUl0M09EcnRSQ2pRZ1FjZXpFNEtpT1hhdDlHc2lMQ3IwcytWRExMeVlpQ1N4?=
 =?utf-8?B?YVMwbERiM3NjamtMb3NCWlJ3Ymx0RWxhQldzcEdhVzc2SDQ0WkZqdVNYcWcx?=
 =?utf-8?Q?0/QnBmvhJN2FHpKX9JMSaFQ=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3936672b-0d4b-4669-6343-08d9f149bec4
X-MS-Exchange-CrossTenant-AuthSource: AM7PR07MB6916.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 12:42:08.8052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7nTbEQFLZOiyW/jUWBnhzBA4Ff45DsxTEPxf/mNU0PagOpImvVE0bbPZy1dqWZl/fyfVKk54n1FcLyAsOWUTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR07MB3490
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Le 16/02/2022 à 08:07, Guenter Roeck a écrit :
> Add support for Texas Instruments TMP464 and TMP468 temperature sensor
> ICs.
>
> TI's TMP464 is an I2C temperature sensor chip. This chip is
> similar to TI's TMP421 chip, but with 16bit-wide registers (instead
> of 8bit-wide registers). The chip has one local sensor and four
> remote sensors. TMP468 is similar to TMP464 but has one local and
> eight remote sensors.
>
> Originally-from: Agathe Porte <agathe.porte@nokia.com>
> Cc: Agathe Porte <agathe.porte@nokia.com>
> Cc: Krzysztof Adamski <krzysztof.adamski@nokia.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v3:
> - Added support for TMP468
> - Added support for various limits, temperature hysteresis, alarm attributes,
>    and update interval
> - Use regmap instead of local caching
> - Use static chip configuration
> - Unlock check if needed when loading driver, and lock it when unloading it
>    - Call tmp464_init_client() before calling tmp464_probe_from_dt()
>      since the latter changes registers, which requires the chip to be
>      unlocked.
> - Restore configuration register when unloading driver
> - ti,n-factor is optional, so don't fail if the property is not present
>
> Notes:
> - Tested with real TMP468. Module tested for TMP464.
> - I was not able to test with a system supporting devicetree;
>    especially negative values for "ti,n-factor" need testing
>    (and I wonder if of_property_read_s8() would be needed to
>     support this properly).

I just did the test on our system and both positive and negative value 
n-factor fails.

With the following overlay:

/dts-v1/;
/plugin/;
/ {
         fragment@0 {
                 target-path = "/soc/.../i2c@4/tmp464@49";
                 __overlay__ {
                         #address-cells = <1>;
                         #size-cells = <0>;

                         channel@0 {
                                 reg = <0x0>;
                                 label = "local";
                                 ti,n-factor = /bits/ 8 <(-10)>;
                         };

                         channel@1 {
                                 reg = <0x1>;
                                 label = "ch1";
                         };

                         channel@2 {
                                 reg = <0x2>;
                                 label = "ch2";
                         };

                         channel@3 {
                                 reg = <0x3>;
                                 label = "ch3";
                         };

                         channel@4 {
                                 reg = <0x4>;
                                 label = "ch4";
                         };
                 };
         };

};

I get the following probing error:

[ 3580.557425] tmp464: probe of 16-0049 failed with error -75

With a positive n-factor in the overlay (<(10)> instead of <(-10)>), the 
driver *does not load either*, with the same error message.

Without any n-factor set, the v3 driver you proposed loads just fine 
with the DT.

Any idea of where this could come from? This was probably not working in 
my own implementation either.

PS: check your spam folder eventually for my mail asking delivery 
details of the TMP464 samples.

Bests,

Agathe.

