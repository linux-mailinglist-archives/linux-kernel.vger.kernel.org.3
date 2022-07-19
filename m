Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AAA57965D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbiGSJdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236818AbiGSJdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:33:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3A71838D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658223187; x=1689759187;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=bfV4Qqor4pfYuxZbC7ssa433hG5Gl8fj8M1EAOKyi6Q=;
  b=I5CaN7UhrXrQZqYIeKV9wady6AwUPtfd5frLJ6EkblPJCrpVGciebcP+
   hUChCkL0n0dXc0vlzyu+GwL781DYjiMj0pSciqVmnAQ9OWPAzzX08TJma
   hh7680HymcKNK4QsLQ1HZmyP4sPPp84rQJ1R1FUaVx/XUTQnchwtsy1Ts
   cSw2UmXgBDN0FJa75vDJw7ni70OOS1B96zFTO/njw/jTRxqAMt88aO/D5
   H131TZWsKmElyRLt5qqBQhOjG7QKGPv2HPNWoWvdZAG5+AZhPcfNADX7e
   QQkgi/ChtNoRV0r23FBWcn5hDtb0By/oSRJ/Uopj/SgDFDhm8GPNHhWim
   w==;
X-IronPort-AV: E=Sophos;i="5.92,283,1650956400"; 
   d="scan'208";a="105101529"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jul 2022 02:33:05 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 19 Jul 2022 02:33:05 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 19 Jul 2022 02:33:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpiWr7yu++2C4MgQh3+/av4koIE6zdDaeGnBQ/LAcNKN61RFCRsEZmzcNYhL6GyMBZ0N0SdfJOz8Q0hUeWmM+vEFVAnnRkhVYdhHhUgK7C2eV8xUKGJ7WMkPt/EKb5oF49pE6TMhWV1OJu0BXOtPpJbRayKrlg4ScmluPeTbZxjDz0bCh6XkCMlfXyX+M5WM7auCXewwo+/B2o3IxXRGIs2ttgU6QPybWMpzV1rLdLSnlmYHjcBvVMeuBpJFYPOw2NP0ItBQHHTlAyVf0LanzzaoodfE5GS3WHDFxKQsSntFhPvxe0WOW7lQqe6Dgosl0UJ8qJqf9Revv4C4ar66HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfV4Qqor4pfYuxZbC7ssa433hG5Gl8fj8M1EAOKyi6Q=;
 b=C4CUdMaW9J/npTc5bn/iPk6N51Lb4BEx2Y57n/4iOBKAHiCAnf4IdnxKrjCNR6n7g5lXEjwADIFermFWr0Y2sIRVP5z73UnZlQXV6f8j5WWJAYvlG+gGhdGTAxxdyfFRbA0253RJE95y+wUKciwGODv3O4JlDcuKIQ+ILy/HCbQCmzqybHul8DW+poMMDQQiwXXr0k751DI3ZUKvQBlMqlSeXk9F9V+OWusA1tIoY9IDPxpESMS/Uj+icS/V0cQTeJfSYFX4ym2CLFtPaXD/EZAz09sGvYRwLTb7E3hwI1lTs/S+9aLfyDHSq+IUt8g48MSJ8yYZ5gAcPTe8mUlGSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfV4Qqor4pfYuxZbC7ssa433hG5Gl8fj8M1EAOKyi6Q=;
 b=JL/cipTXYPpzCFvO45aG5S8D2xxFTNlNKvOdIhdMPlrmUdmRfdaW2PoT4/uroZmPEbZpfhQdE38Gj6Ov6WaBW753wXfMcFJ6UeJrxVgRCb3eL9IcHOewZH4Pgq+ps7ewDv0hs+0aihd1kAj0JTOrFjTxIiGledqGLsozed6CRAE=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Tue, 19 Jul
 2022 09:33:01 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b%7]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 09:33:00 +0000
From:   <Conor.Dooley@microchip.com>
To:     <limanyi@uniontech.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] This is a send email test.
Thread-Topic: [PATCH] This is a send email test.
Thread-Index: AQHYm1KJ93rrG9TnPUepcWcrQ3hJiw==
Date:   Tue, 19 Jul 2022 09:33:00 +0000
Message-ID: <4aed27ee-1d47-9b0b-3f4a-3eedcabd4ec3@microchip.com>
References: <20220719092958.20966-1-limanyi@uniontech.com>
In-Reply-To: <20220719092958.20966-1-limanyi@uniontech.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 368254d3-e2e2-4c8e-745c-08da6969ac43
x-ms-traffictypediagnostic: SJ0PR11MB5645:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JtYBodKOn3K1W7qUrG3OJ9jz678krcdChBnACtHCKr6FOCFTRoied857LX5tZCpB04aDCet0U4gy2D0YA0n/IWCkzoufV/VNbOUUlJpX96JdJuTxSWNh4pAZmfLy8Eu/0UFhNfslAf8peWXVKWbkciSiqx5PnRdLPBLCOxM7iJKT1PUPgaJwqw2Pt+f7tPblFgzMFhXHGNNO7fqeG4yBwjj0+BibX4NwWrmXMFU0B80eHAc6TLsHgHy7Vavv27oG2nMcuHVaxeWQ0HOrs3Sbq9sqds4StJe0cIsFiiSQ5WmduOd8GsaBno0Rf/dFZjRWjkHcoRzLGFGBHkWOOWx+mOOREfSEqkx7oGLP832sdOH7LIwBPOhQdIGviSmpsvsKqEqLwMFX2zhszstsu9fRNfDVN9p5lHpQBb5WEv5JnLhEOU8qygeRy2q4jsfMZJ/xi8V0Z5c/XfE4ZYz23vkRR8Hu2/xDC0uvYB1BqzJfpphhFWSw8mVu0xs6XYNmMTV0tPuhQ8zh2k4e3N/1NqpA7HiqCa0OTcUG+kFp7VLfYtziNp0zHY+4uQwemDx8Tmm6p9LqJGaJwq83SlvHXZIGLHjpWtqT0mA2AaTGCn9+aWsQUaDJ46b5HX4HveSpWRVKZXV9Tll/f64/wrXiUptTPBmFRudIJD6dUVlNf4dsCLsxaowAOEEnojUK/fgiTRcwQu8WLkOpzY+Z/fDcPTm05d0QyZNifduJKPJzKz8GWqAzmmGT637XzwbV//9MjOTpH91nt6C3Ekdcus8Ju1hg4H9CCs2S+UqimKjXnoHZ57R/xLn1mgwIkp2nnBJZl4WQSMGNxI3dIOTZMivHkSUKq7Ko6+c7lss3qeCSF/yVWR5UXoXoHmcVHRNcxWk7ckRq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(346002)(136003)(376002)(39860400002)(66476007)(66946007)(38100700002)(186003)(71200400001)(76116006)(110136005)(316002)(8676002)(31686004)(66556008)(36756003)(91956017)(41300700001)(31696002)(8936002)(66446008)(2906002)(2616005)(6486002)(6506007)(19618925003)(86362001)(122000001)(26005)(5660300002)(38070700005)(478600001)(558084003)(4270600006)(64756008)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3JybFFPU2hRMnM2TEFqRGlZa1NONmZiTXVKRllOS2ovZnlPWEN3Mk92WGtz?=
 =?utf-8?B?TFJYM1N4MytnR0k1M0FBWFpya1lKOHZFaWdOWXdkRndrQ201WDJidmYrbDZK?=
 =?utf-8?B?eWJLTkorY3AyamhJelFldVVXaEYzY0srZUhnaXRTVGlDeERKeXlveGhEWXgy?=
 =?utf-8?B?eGdFQ0xHbi9PREQzemtPWlJyYUVKeVQzclRWVHFMUnFLa0xraUpLOW9HV0JJ?=
 =?utf-8?B?SlVST1J2ZytBWGk2KzJzMThPMFNwRTYvZWlMdnR5R2hkb00rYURDOHJPa1Fs?=
 =?utf-8?B?YWNhOVFWcVJoOWJRU0NYUDJEaTloTFJKMEFxWldXck9nd2p0anRYQ0hPcGgr?=
 =?utf-8?B?TWFHcmJtMVFOOEhQR1hEaW82dTRRWFQ0T2hwQTNvQ3FFeHRkTDhxYjJLejZn?=
 =?utf-8?B?MWk4ZGZ1a0pDc2FkcXdKSkQyUEpuQURnNWh5VFJsUWt4RTJGOGxVM2pyd1BS?=
 =?utf-8?B?N215NWlkYU1tT01iUFFlZTdYWkFzK1M0SFhRb05hMzZTK3U0OFEzcTBxUnlh?=
 =?utf-8?B?cnY0QW9Ma0U5aXl0TUdmWW9YYVkzUzNvRGpDa0Y2NzR3Nks3eG9ST0xiR1Rh?=
 =?utf-8?B?R3dLOFBEdklOdDduRERHbGE2Q2JPNzlnWmJlRVJYczdOdlc5UVZFVEFJbEJG?=
 =?utf-8?B?R0RrSEIwNnM0cWxySnhXdFBXOXhOalA5VzZoUkQzZ1pQUDdsM1lFWjc0QW5W?=
 =?utf-8?B?Q0NGZ2xwazVYa0dPZGpkN200d1NoNk1OV3ZpNGU2cCtoOGtWOWs3bDZJa0lt?=
 =?utf-8?B?TDl3L2pyN0FhaUNWSVdsOHhJNEFiVnlFMUJkTkppalZCL2NCaldrN25HSmNr?=
 =?utf-8?B?MzJqamppTU8rRXFxRFBJTENxQitYSEFGa3FRM0ZBSGhIOFVqdWQraVFPSjRZ?=
 =?utf-8?B?SVFsSWthR3RSSWtiS3B1a1JtN0hLWEhCUGxuM05sdVpvbDhKcjN0cHB6MGNv?=
 =?utf-8?B?MWRWcGhFdHpNYjdNdUo5UDhoOHJwVWh6dXlDemVOLzBvT3pVZmJEQzE0akEv?=
 =?utf-8?B?dzFWYis3M3llbHpCVStQM3ZQSEM0SGNCRmNKbVNoS0Y1Ky9VRFowQjA5SzZK?=
 =?utf-8?B?blJINW1kVkZrbkI1blhlSjJUdEoxYk5xS3dOdzJhWTNWZWtZMVYvSjNFZVUz?=
 =?utf-8?B?Q3V3NE14Y3ZlSTY1V1Z1WGNobzJBQi9COXIwdFFXbnljemk0WGJudGljdGN0?=
 =?utf-8?B?QlZ0Qm5RV3VEb3B3ZSt0Qjg3QVdmYXQvZHUySWxBNUhLaEY0TTRaZThFNEFJ?=
 =?utf-8?B?bDFubk80OTY3Z0JNQm9qRWxHRWxtQkxweXRCeDF0K0VHcEtqc0piM3pJREFK?=
 =?utf-8?B?Uy9ldFJkb2lheHNjVjhCT3hxQktFd3BzdzFQWVpiYis4NGc1LzNBMUxHdnp0?=
 =?utf-8?B?TkhNaUdLQXgxUTc1dTlpS3ovaWl2ZXpKRytnRGU4dzBFaTFNLzRlNWN2OG1J?=
 =?utf-8?B?YmhqdThWTzBoMm1hQVJFUGd2dGViZWFaQ1FtdzB6OFkrQVRJZ205UGpPNEFz?=
 =?utf-8?B?UEVHVWt5YjZmKytQLytDa3N3NS9tZ2RkcXc1VEhPdXlDSENIZWtaRWFLVWQw?=
 =?utf-8?B?bDZKQjRoMXJhZjdtV3NvWWlvbEx4bjV0RWlrQjFKTUtMbEhmbTBIZnFEMEk5?=
 =?utf-8?B?Y0E4dGcxNjRBd09vclhHNjNaQ0wvK3F6QUZyZkZpblVPamE1ZTNNU2hIVlF0?=
 =?utf-8?B?Q3Z1YWcyZVF0b2puN0owN01kTnBNTHhvbXZSZUxBSDYzc1JnUUV2MEt5MUk0?=
 =?utf-8?B?NFJMK1d5N3cxY05KdkVpS0daZU5ubGVCYWJLY09NUkd1ZGkza3ZWMkdUa1JP?=
 =?utf-8?B?aHNzS1U2dTJSZi9vcXhTTE1rckdaRWd6MkdpSEZSRU5kL3AxOXdxeERXNnlP?=
 =?utf-8?B?alB4SWlSM2FnUVpLT3VOc3hiMnNtWEczOGxHdUltdjdoRVZ3aEVPcmt0V2w2?=
 =?utf-8?B?UWJaZENXYUduYmpuZVVyYmRheWhtRGtVMnRrTDZReEk2K0JuaE5FUmFkOHdl?=
 =?utf-8?B?RFpZK0tYN2ZTdCt2L3ZEU2JQQnp6UCtUeVR4YktnT3JNdUFLb0pSdjN1MWpm?=
 =?utf-8?B?WGlsREh1OTF6cFROSDB0K1hUOHF6dG04aTFiQm1oWVBuOFlkQ3dHcWFpZDRG?=
 =?utf-8?Q?C+paV8I/TXjNfkdsfvVhjYuKv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AA1C9A717DC0743B9542198243482CC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 368254d3-e2e2-4c8e-745c-08da6969ac43
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 09:33:00.8462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bRKxLOfgT6QWUjIqT9waWPh7EY5GOEPR6D1yA/8gmXQBo7oxAT5RY+A6yXPmHqOkg7YJARrAQwzRkGKp5SJ1L1YQMV1pJd/94GGMH14mP44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5645
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WW91ciB0ZXN0cyBhcmUgd29ya2luZy4NCg0K
