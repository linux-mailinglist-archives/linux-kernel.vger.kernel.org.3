Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAC55421DB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbiFHCH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 22:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391729AbiFHAmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 20:42:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B7B213E4C;
        Tue,  7 Jun 2022 15:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654640089; x=1686176089;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2fDtP3TWlTELvAwAxay1nRpYsKsat9ixpsvbmXDMbVQ=;
  b=yRMlRbBgM6FKB0Ml4y69Xr9H+/nytiOi6doAFyr7vfloWwly3L0tIUH7
   quVsHlp4Ck/JgxVLeGJ9WCfLxJmusMhsbDCNXvChLXSMG+RXh6UVQ/DUD
   7X46JqRSK8ijYvONExa4d8I3+A8UMYqGIbeQ39Z3JuPeW+k1IU1sinI7v
   xTWibgzsNyywgZSx5sWYKcUMGvGyWfPc8+DLS+rFjfuZUgBkB3+/O49b8
   yhzzkWPoLOBlCqwMzaqaVUpcABnbBW6LSO7G+EPHP9EgurGY0CvPCY+Hq
   GHke1JIf8e2J9SgM31PFr81t6fWwXv+1fyzUycqCDoZ6ysW45Xd1ldkgy
   w==;
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="167504034"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jun 2022 15:14:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 7 Jun 2022 15:14:36 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 7 Jun 2022 15:14:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMsZepGUuOn72eA6Zp8sC66h6R4g0VyEpp65M42AK/x5AlBVwa4IBE5bRgdzN1fh86YNj2iwEx0606oQtNb4Er+7ZrQP3sGKVzMSKWh0ZTEinj3ITo62mS9H/FfyGTrhhN5DGRbL4BSnCxc/b/ZWmLsLZG8iC2/g2Ct4qCP2kiB1+TJ6JaIOUxaBzdrqUrj3G222YrE6+M/0IsikKQy4+cMADHOFDyGelLFX1ALavogHdeBj60bWHqrzJK1em94OtNQPa3owPucrYDY/eMPbo2cqkhV2yTP44yhjbkQrVhxpntlpZ3ymGdtj9hlBiM2fVaaXy5LQpfHcQrPp+wqdBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fDtP3TWlTELvAwAxay1nRpYsKsat9ixpsvbmXDMbVQ=;
 b=XQ+5FpEsp3aVFawJjTw65S53cnoYVQCc9t07ZV+z4o6BCpqLtNXkHmgHvmfTVMwRbAg0s/TExNMwYHJ4UswZZ6UmzhfFnLJSewofZV/ZCQoUiafuhHsmhkQHggjr6YM4vuXTRhnFASzVw693F3GJFf2cY1x6Wk1o9eF4yUUJ5760VdHSCxx6OBcyl4wEi2B0nxNmIOO88jMTCd/FDKiwsxuwQ2cO3UNSxniHsdh67roGekdPEYjyWBE/45rp62DRJv+ekTasMU5yroUNtP71S0iYMknQIJKFxJfwcd3xvD7U6WkXBa6X1fkZVPUeBmFjZFTGwWRt7IqZtf7wCBgo3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fDtP3TWlTELvAwAxay1nRpYsKsat9ixpsvbmXDMbVQ=;
 b=dcD/bOfW+4q8fwkLVBvxqeRDxhm12Bn+u8W/UsOxrz59uS5CF1O3W5UjLVZ7th/i1lV8kibijVWCjRBsLdvJCaLQnatxHVE67wiDhKcglJSowB5JEwkwhlz/+zLjz4e6A7W2LniJLDOZQLOF4V2+2Z7l5R3/vHQadDLuo5liv3w=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM6PR11MB2556.namprd11.prod.outlook.com (2603:10b6:5:c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 22:14:34 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 22:14:34 +0000
From:   <Conor.Dooley@microchip.com>
To:     <u.kleine-koenig@pengutronix.de>
CC:     <thierry.reding@gmail.com>, <lee.jones@linaro.org>,
        <Daire.McNamara@microchip.com>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 1/2] pwm: add microchip soft ip corePWM driver
Thread-Topic: [PATCH 1/2] pwm: add microchip soft ip corePWM driver
Thread-Index: AQHYektGYgm47OSlDkC85GlCBXsO8q1EX/aAgAAjYAA=
Date:   Tue, 7 Jun 2022 22:14:33 +0000
Message-ID: <1c34d537-6067-ed64-d5e4-7c4e9d242edd@microchip.com>
References: <20220607084551.2735922-1-conor.dooley@microchip.com>
 <20220607084551.2735922-2-conor.dooley@microchip.com>
 <20220607200755.tgsrwe4ten5inw27@pengutronix.de>
In-Reply-To: <20220607200755.tgsrwe4ten5inw27@pengutronix.de>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c1cb6fa-8afd-46f5-0e1b-08da48d31a29
x-ms-traffictypediagnostic: DM6PR11MB2556:EE_
x-microsoft-antispam-prvs: <DM6PR11MB25561B3427D2564D6D0402DD98A59@DM6PR11MB2556.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rEW6tjJnozihGSfGbpf2ukuoF2+4UQX8FGiMQVPax2HaK+9HHc8l9xGc4eZ4gLX/Tq3fg2Vv8EGj1rY944wfyKFjOwaG+MuI0QcHlcsg+uODEKL+Iemj2/9oGuUS5s9F9OpHmqxWtyOLVNDgxZthziwLSI5kvz80G1o5bFQhrQ4fdBFgGWX2lgNadGZqQ67f36q1ydAZ1uYPadYeorjkD7qTe1WdP4hw03P6H/xclIHPseVVeLNSJEzGpohEbF50gH2lXvQnloYQK5F6IffCboRcWkWRhJIH1EJL+L327M9e47CGxpbsICKVylQEttfxYsmeDlKSgEGJ1b+ybI5TysDvtGdRRUyrr7x5EfYbHMf3stoPbWaAI2opqR5kHBz3Fyw6+u+y5eO3hBtfEM8YrrJm7VrGGRpkwV9brjTGjmw40etX5MRRNsKSWsDiFPJnJrBq1Dcgy3dNWIr1vQHbIPFff0TbDDnDsuLYa8UYYagx/SSY4NcjM+LOPh0XdDBW1wQIeNeDoKq23BxQCSO65HdTQNpvn3btNMT5spGrjM1ygv7P2xzvHOdGdfEGliM9MWzRf0d/2ahTLS26rFuOs66XpeJ0C8NlNJMRMZO8LCIVzps7bdFILXmgkUpkK2axUyta89LBerobqF3OlDqmFNro65E6G4SfNngXsrVZTOgpwrbqHbZud78t4kjRN47LShnkH1LRgt6aFHUQJ3lEQcWGtye/mhV7EsxTrslH8BDohKG98lsTg4MtBcZc7tOl5EpuPT1kPiq5n3mCU8hNFQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66556008)(5660300002)(6486002)(122000001)(26005)(36756003)(6512007)(6506007)(186003)(508600001)(38070700005)(558084003)(8936002)(53546011)(8676002)(2616005)(4326008)(2906002)(6916009)(38100700002)(71200400001)(76116006)(31686004)(91956017)(316002)(66476007)(66446008)(64756008)(54906003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWNZN29JU3I5NnhCYXdVdjlKT1VvS2xJWTFZT3phT2pJZ3BqamhXUkpXaTIy?=
 =?utf-8?B?UHB4SnJFK0Z1N29xclM4ZVdBZXd5V0dNck5XMldiQnk3YWkvWTU2SkhLNyt3?=
 =?utf-8?B?d1RZN3pCcGgrL2pEdHIrendyMVkvWml5L1hEci80VXFsWWxkNXR5aFhHR0dk?=
 =?utf-8?B?NFhyU2tKNC96VDFLcVpQclg4WEFmNjJBcmp3d3ZNZzdvenlTMmlZL0JNNWo2?=
 =?utf-8?B?c2NPR1NFR3IybG81bElPMGJPMTI0TFJTMCtmN2JaTnd5Q0VXUTdTZmswczMr?=
 =?utf-8?B?ZFNzU1FkdGRMb3BkY25uT0ttSVVDcU55Zk5hcHZ3Rm9NY2hPZkNYeU5USzNB?=
 =?utf-8?B?dnNrYmRvK1hwS1lCY1NNWm9JaDArQXpObWpGc1k0SUVlN2Z1ZXVpT2NTNGRW?=
 =?utf-8?B?czA0MjVldWE5L3AySDlwUmE3UGdjS1l5U0c0N01YWDZ3bTFwWGNPOFVFeGcv?=
 =?utf-8?B?V0JieEN2SWtlUWtsc2FaVlNzT1Q0ajVoM0NtcmxUQlNnVDJVemFJMHFiMHox?=
 =?utf-8?B?c3llYmd0T21RaGovSjBpSC8vemFHb3IxbnJwdWlMSVdWQ09UZHdueW1iOWVM?=
 =?utf-8?B?TXRUNHZZYUJxVUNNTUtpMCt6WTR4Wkx5WkNLWExjcnFkMXVzZXRmRERncGs1?=
 =?utf-8?B?ZjNkd3NQekdDSzJyTUlzU2lDMUFSYlNZaW1OUHlZNVpQdElBbXVGOUlqeWRX?=
 =?utf-8?B?UWNIRkx1bG9VRjVTZVQwRURKV3Z6U3R3T2FIcU00OWNQM1pGdTRONUJwY1pQ?=
 =?utf-8?B?MFExeEZlZjh0eGpBN3psSkhKSTZlRWxrNVFOTWErb3FDWVgvdlBDdUtjekRH?=
 =?utf-8?B?N2w0clJ2WDJLUmNjV2h4WUVVaC8ybWhRWHR5bVJQdzJ4Y1NwbXhVdFZlRGxX?=
 =?utf-8?B?amcwSFFsempScmpJdzl4MWJ3aEJJcTJWTlNBRGRCbkl3dU9uMW1lZGFUTklx?=
 =?utf-8?B?RUwwQm1sNWpOYnlNcDNyRWdwTkF3aUd5N2RVSSt2WEhBN004SkFRSEtzUFlx?=
 =?utf-8?B?citmbXN2V1JHdGt4R21sK2NtVHJnN3dCY0hYaUxlM0I0cWE5WUJmR0ozQk4r?=
 =?utf-8?B?OW4xbncvOUFqQ2U1a0dUcEIwRHZ1NFpuZjJiL3pNS1JNWUFOOVlka2RRU1B3?=
 =?utf-8?B?dWdSV3JBbUxlMVo0bW5ybE5NZzZzdXBmd25YNkh0d0tZdUpQeXF2czkySDRt?=
 =?utf-8?B?cU5qOTM0c2d0YWI1MkV5S3NHMklESXpHRGZyL0RnWGJlbGQxOHpwWVN1M2VV?=
 =?utf-8?B?QWsyUnIyeWRZYkF3aTNHcVRjT05ILzA5RzE3Yk5sY2xKd2t4QU11QnRhQ0JO?=
 =?utf-8?B?dlFDcC9VQnZlcjNRRDdaV3dzcC9qN2l4MWhSS1FNSWxuRGM1aVFQVEw3TCtx?=
 =?utf-8?B?QkFYSERITjBMMmZXekErUlR6MjlXUjB3Qnp0ZnMrSk1VNTNjVGpCOURVcVNS?=
 =?utf-8?B?WEZuNGovL2N1aVNMaHJETWJiUUJDUEJMeVQvUXY3cjN4Q0pNemF0Uk1xcEJi?=
 =?utf-8?B?R1puaGp3K3Bxb0s4amV3cHp4dld3U0J4SEF4T1dlS01aT0tSc3BjbDlVRS9M?=
 =?utf-8?B?Rms5aXFzZWI5aDdLVFB1ZnFzZHpyWm1oaDFLZS9PeXYvMkRQbW9EeUNDd3M5?=
 =?utf-8?B?Ty83R3IzSlpOOXpPa24zSCttSEJjU1dwTHlIQlY1RUZ2bXE5QVNzS2NvOWc4?=
 =?utf-8?B?MVZGUXU3Y0FGYlZWS1BpdytvcGk3eXhhOXY1QVhTd1VweVN0enlMZkxQTkVM?=
 =?utf-8?B?VVFOOEQzRlJDN0RFZ2paa3Nvc1Vod0tBQ0NtWmw3NnhaTzJvcEhzblJBdDla?=
 =?utf-8?B?aUJxMGZhVUlTMU9JTVdsZ2pHZDNVcVFBWktXeG5KNmNYdjg1QmRpWTdocVJW?=
 =?utf-8?B?RGdHb05EclV5VVdiYmxQY0NjNmdIQlJWdzhtNjNGZStva2lza2svYTRmcnFj?=
 =?utf-8?B?b2FmOHJjZ1FodWtvRmhrNVNTdi9OUk5TbDRFdVQwVkJQUlBhQWFxWkdvVXkw?=
 =?utf-8?B?R1cyN25Vb295aTBZT3NrUyt1ZjBXMXNZSmNXdWNaL2hjUlF0OG93UncrcDhy?=
 =?utf-8?B?L2JzdG5IWEFWVXVwTkRVYzlkcVQxOTFIU1lDYUNIQSt6K3BaaWU1ZjR1R1F0?=
 =?utf-8?B?Mm01a3NpK2ltdC85WGd6czNTSm94S3Y1ZWJiS3BWdXdNV250MUlEL0hDZXo0?=
 =?utf-8?B?Q3Y0SjNTN2J1b25NR1MwbzN3VTNtOEFKS1BieE5TeFVheU1NaFRleW5aazJF?=
 =?utf-8?B?UWJzcXBMQjVwenk2ZnNIUDA3d3RxOGEvQTJUa2FjNmZBYXZSV0VBT2lYYldj?=
 =?utf-8?B?dEdlUFVHOHgvczdycW8yWTlFNlBUb3VlVStvaEFtVjNnM1NDbG5jSkhhclV4?=
 =?utf-8?Q?EMnteXp+Fsr14CcU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF7211ABF4A6D142A410A26A0B5D6971@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1cb6fa-8afd-46f5-0e1b-08da48d31a29
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 22:14:34.0388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6iAfiG8ZY2MQmfcw0iUcngNTd0nMbxNy4okUnz523B+1Z4/7e7VROv3habXF7efEtkgCy/kQurP0MmMc0aWhhI6shrtTNjLB+TM3dcQUdWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2556
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcvMDYvMjAyMiAyMTowNywgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6DQoNCk1haWwgY2xp
ZW50IGlzIGFjdGluZyB3ZWlyZCB3aXRoIHF1b3RpbmcsIGJ1dCB0aGFua3MgZm9yDQphbGwgdGhl
IGZlZWRiYWNrIFV3ZS4NCkNvbm9yDQo=
