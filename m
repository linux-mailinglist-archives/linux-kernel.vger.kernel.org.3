Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C3F4E670F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 17:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351709AbiCXQdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 12:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243623AbiCXQdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 12:33:52 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E67AD115;
        Thu, 24 Mar 2022 09:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1648139539; x=1679675539;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Cyd9fFVUUBsxJvwbgVLrMwvYGnPE7S4uodXF0xlDfYI=;
  b=qmQosxScdRpf748cPYXwFycgDQ4W58hSS/telGtkKVroi4w4QfpKwuhR
   mODbB5w1RS2zAUSVwaZcu6u8TZElbnUjC4/mm8P4LJe3OmZdh29GOEZPh
   Cui0Fme2kHLgVbKo1xrh5hhAb8Ex3fDBJB3e95iDjLdH8mctDy6v93cXE
   qOTJYAGIYiMIdc8M50eTAnL3HjZI+z/KDCqb/efUUBWMiwziWH3K4fN7s
   2lnNuxKciWqM5JsUfaz0Vwyd6Vl54AncLnD/HoxPagkhWLt2mRhn18x1r
   X7Hlequmku7DJ56fyTXdYoh14a4RBcBT3VJveOWjpxSBdh7yJ1WSCbPZq
   g==;
X-IronPort-AV: E=Sophos;i="5.90,207,1643698800"; 
   d="scan'208";a="153157172"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Mar 2022 09:32:18 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 24 Mar 2022 09:32:18 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 24 Mar 2022 09:32:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JA8ptNP0qCciMSTm3ygU0x1GGO07lYARV9KaXVOmerQRPZwzBjwJH8sMF+fJck5tGvKCKFaqFk/rMS3OZLWH0Kud1pUT07lChu12eMa+DL0+Sy7eN4zqrGNHtr/WvhQL92Z9UzuUUBzRUwbmIQXZX7KyAfrcAs/xMvLkjAmKmkO4Cd7f43kxWLZH6oZfuSpEWaqDvduPp8NqCmlFSN1YhmPFWX4WRoqiFHeHHQy6yGdyLgumFRg1ic64rHrnlntu4lMHkcGBYO4Ip/KM80L4XYotF7Rt2oeqWXvzKHYbgTPR7y8kc+e/7vSk3mHrwSWCyAruNSEeSTksgf4DdcwDXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cyd9fFVUUBsxJvwbgVLrMwvYGnPE7S4uodXF0xlDfYI=;
 b=dPWqxU12UubHjolG/tqXPDkrmE5mVwxFsfHuwoqVfFYfA1fDkiuaHVHcgGd6HYkdiXrxKYYG90NHI8eVOT5ISOeiHilVL6C+U337Um7rsUOeWMcT98pmdG+M092U4lhuxvJ8ZgsHlZrIFNf98LDyYIvn2K6Q5Z3W4uUDgzxzLv/WEeoGuOHoPdcoEz6Mko+GCuW8MdK7r5vN9kJKFGqaSXGyJaFo+3b4Cj3LgRfxLlF78tWBh+7aZP7I0CmppUrUsWYYIOEnC3KXkuQWufafEZ+HAkoXLb9vdCRJ6axdz1NzhKLIt2uPWUA2knECUmZ2DLMZzTMEJiBq7sawQnezZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cyd9fFVUUBsxJvwbgVLrMwvYGnPE7S4uodXF0xlDfYI=;
 b=j7D8jIhbdZ57dKA65Ky/1pjxH8wMTkfuavv0NFDUMkhPWgB8EV1aY/hBkUrA6HTg9XFIxY5UCeNnakA/ITp+A1bGuUW66quX6Am//t5UHKir/yH9Xs6ulyMm9Np+U78+uu/19rRZNbqnx1p1xXNnOpotO4ppd9d/vEwAhTzOTHU=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by SJ0PR11MB5135.namprd11.prod.outlook.com (2603:10b6:a03:2db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Thu, 24 Mar
 2022 16:32:13 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b%6]) with mapi id 15.20.5102.019; Thu, 24 Mar 2022
 16:32:13 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <michael@walle.cc>
CC:     <Kavyasree.Kotagiri@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v1 3/6] ARM: dts: lan966x: add all flexcom usart nodes
Thread-Topic: [PATCH v1 3/6] ARM: dts: lan966x: add all flexcom usart nodes
Thread-Index: AQHYL6IUHEQBuBvGLkmRM0laLRQs8g==
Date:   Thu, 24 Mar 2022 16:32:13 +0000
Message-ID: <0dbed9b9-e45d-f7c6-05ce-ad7b210d31be@microchip.com>
References: <20220303160323.3316317-1-michael@walle.cc>
 <20220303160323.3316317-4-michael@walle.cc>
 <a33f0c73-df49-5a22-14b3-0059f7d6b827@microchip.com>
 <2e0aefc90a80bdf13df0e59857c52ca7@walle.cc>
 <bf005cd2-4c83-1552-8282-d229eacc51f3@microchip.com>
 <219ffd086373c453d5d0aad897cd2d41@walle.cc>
 <3e17aa8b-f6e5-e2c1-bd1d-8950d23c3e49@microchip.com>
 <d7d17a2156a9591ad4c19ef912189a98@walle.cc>
In-Reply-To: <d7d17a2156a9591ad4c19ef912189a98@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53b1bfc1-24a7-439f-f1e0-08da0db3d9ec
x-ms-traffictypediagnostic: SJ0PR11MB5135:EE_
x-microsoft-antispam-prvs: <SJ0PR11MB5135A832692719819898A01887199@SJ0PR11MB5135.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4rxLSMRJ2WH/xMJiqrpnoVkdIHCh5I/d+dTFpzo1nTmRe6cdzvER2USgBZKzFeRrkJVDdZ3hUB8kTfjq3v/hCH6HzsybJLiExWx7eBRVgbXcmbHzjaY2p351E3WmPFSOa07H8iOSXpiXPeA5bYNSW+ADxCVIJRdLVCz6qps5zb9QmXlmR+s3rcb5CyngGl8G8bO2LoCg2sWz3QbNAZP1QARc8Mz3ZY6CCtG0xMqaiTxi0lIbYp+2wSghbsg/DcFFgooyf8O4VFen3bB0SmShW0cimSYlMxWZzmf1gYqLxA4qD4bCowvdBTY/eD2P7FCzXLXIF789abwPdaLvLRjWquBC5Up2JiylRwRfF0BJ2H29sqdxABwoQpcIpUEQceFWTkRVo3va92w+BIiyDBBYadIomJFHDz+PsOA+DaKJQWIyhigZucje1ajFvmjEA2k9fPkfwZhBiR2KAv/FJaZvk+gJbi5EHJHkaqABZz1xwX5VqYjEYIKFrPfXJgv2hyHvG4AB+pfgK96HrRAsXsYetWh2ZfpqI+oQuQouf7XtGevmaP1w5UH1lKWMv3l/eoiRTVTLnLZDlKgpmSyAvCAlhfp6uj36dvajeH7q95lzR8ILOTTnm6OCxg8VhIDTITB0mjTnc1C2kP4kl3AO2L4bENuOzyAULwNUCMqY8Zg+nqjhbVdyS0gi5slbmKoogZ1rzNwgS7MNwgi/W+n5RPvrRAwcM+fXxoh0imrLYEfTE243MKGzJtLRkLVcjl6zah6RNYNP2pgr+3JKNxN+Gcbv8hVz3SCCT8f0gOY/NFX3bXn6uBMG5ol+Pz7SO3OYlitxiajVDiBajjSJL6bINX3sJFt5PoKnM3FVhlj0O8V30jHFRfoJhjs00sRG7FHt2xro8vVw+ZjgmlY2Ml36kEbUUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(83380400001)(31696002)(5660300002)(186003)(26005)(4326008)(8676002)(64756008)(91956017)(2616005)(53546011)(66476007)(66446008)(6506007)(36756003)(76116006)(31686004)(2906002)(6512007)(66946007)(38100700002)(38070700005)(54906003)(6916009)(66556008)(71200400001)(122000001)(7416002)(966005)(6486002)(8936002)(508600001)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1ZraXVUTjVvRlRlazY2UVhYWjJvS1FNQTFFQ2xubXRJQzJ3d3V5Q0Z0ZFcx?=
 =?utf-8?B?N3pWclRBeVNqQi9Ma0pLRVV6bXVWMW8wYysyaFErSlJQSjhNTks4c1pVSGxu?=
 =?utf-8?B?Z0M1Sk16TXQ5WmNrdzBJeGVnMXpxVDdCejFhWlQyMzJSdHRLNTBHclAzT1FO?=
 =?utf-8?B?M2FjcTRqdEZWUjNHNDA1WnV5d0FLTklDaTVuZXNudHRWa0pPbzJHYTdFTFJz?=
 =?utf-8?B?NFd3d2R2R3hBblNaSWV6ZGRldXFRaG4wcUNBeEQ4ZHc1S0R4dXVva0tyQkYx?=
 =?utf-8?B?b2RURGtJTXozelZiNG9HZ3NGREcyUDdPc3l0U1Z3dTZibkdRZmI4ZVR4UnhF?=
 =?utf-8?B?NHdaNlpPQ1N3YUs1N0FlL0RtRXRDUzNJSXBwWE9rbGZySzdidkl1Rm5jZTdP?=
 =?utf-8?B?bVlaSE9UWXNYTjBINUpaVzFFZlc3S25GK2NSYUFhMUVmUjJrSHg0cHB0akI5?=
 =?utf-8?B?VDdFRFFqSFlreXc3N2FUbHp3clBhbG1Wd3lWaWxBKzdET29jSjhnYkdDanFC?=
 =?utf-8?B?Smo1bXVNSlhqcEd0NXdScVJrV0J3dUpUNXRva2g4Q09YOTNoM3hNVUlybzRh?=
 =?utf-8?B?ZGY4Mkptek5GQWYwYnN5L0RGNVV1bDdPTHI3eEgvZVpZam9lMFRQTUcyZEtH?=
 =?utf-8?B?cXhKdkJJTVRjOXcvZktZVWdrQjlMc2dlanVrci9Zdm11enRNWTBvQzRrZEhl?=
 =?utf-8?B?Y2tnOWZHWG12NWxEY1VUVUxyb08rYUsvVUNMUGg0b1lsWTZ5a2ZOSzVrczZY?=
 =?utf-8?B?ZDh1dnRFMW9FNkx6MlpjZVNOL3lVZ1JzVHZacDJzU1FqQ1djNHI1ZGRZREpm?=
 =?utf-8?B?ZWxhUndrWHhqWS8rK2t1NkhsUHgwNVRrSDB2N25uR2p1Q3lYY0gzcUFpQUc5?=
 =?utf-8?B?K3FnWFhsY2RiREVjd3JNUGozSi95aXpMODV3VU1qVWxESGxPa2JuSmpOR3d5?=
 =?utf-8?B?VHZsRmxmNGY5ZEZSMHhadlZvcHRTVWdQcTJES2szVnFtN1ZiQzFVWVMrYVpz?=
 =?utf-8?B?c1N6YkZCbm1vSi9rbnY3R3MxUVNrd3hZUndqK0RUcFJWUlMxaHR3TUxsaGV1?=
 =?utf-8?B?VlVOTzRUU2g2UlJqREpLVU9aUkl6ZmdBckk0b09xMHpZWUg4bTlBcGc5d2xE?=
 =?utf-8?B?ZnEwT3B3ODlEMnQ0dFZ2M3Jna3BKL0x0b21vUmxwaDMyblBZa2k5OUJiM3ZS?=
 =?utf-8?B?ZU55U0gvdFR5dW5aa09OeEt2RGorOGZXK2ExdmZhSEM2MTIwTG13QXdyRTgz?=
 =?utf-8?B?eGpGWFk3UDdxdTF5MERnWXJMTHNGUE8vQnY0c09PRDZwNGVVeW1uL0tMdjFx?=
 =?utf-8?B?NURGWCtCZUlITG54K0Y5OXpLZXhKMUNIUFl0TXcvVld5MXNaSFdTYlFCNWh4?=
 =?utf-8?B?bEsvUnpGVkNBb0JiMXQ5V1M3dEI3VHZJOTlJdEdObzdiVTliKy95RkdtbVd2?=
 =?utf-8?B?c0k1N1pXZDI4OXNxZE1FUWtlMHJLOFRqUWRkaCtVdHZOQXdwak1xOHZ0ZXZy?=
 =?utf-8?B?cHd2alAyeUI5b3hJdnIvdFp0KzVDU04xWENMYmhmL3RKWmtMem5RQW1XZk4y?=
 =?utf-8?B?dFo1QVZCTnU5S2dNbkVCWEFGNENXcXIzTTRCZDAyZk1IaFNoSVlheVU4bzRJ?=
 =?utf-8?B?bUFYc1RwM3RjcWJWLy9EcDdlY1hXdE9RQnBqSDNZMnpPRStxeGt3TzM5NWZD?=
 =?utf-8?B?MTR4V2FJQjJENUJNZGxEdnpVVm5JNVZQUEFHQXp4WlN1ak9nSHpqUmprUWwz?=
 =?utf-8?B?Z1lhTjM0Nm50d2JIQkxNU1liZVBiZ3lIbzczSklyOW5OcmV1N1NXc01DQWRm?=
 =?utf-8?B?WHVqN3F0aThqaUZnZGwzVjVxMlFJdzVRWlFBc1pvcWlVeklGZ2xrR2Vjc0tI?=
 =?utf-8?B?OUx6SUpEaFcxY0JSWElxZVNPbFRDWHg0QkllUzVZKzVjUjBnTlJMVzRLRDJq?=
 =?utf-8?B?TkM5T3hmbllZRmp0d2RLQ2ZwdHhOb0F6MW1GNFlZdmE1cWlKaStmNDVmeG9q?=
 =?utf-8?B?MmZuZGFaUXFRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82177E27E4B913479F5E1E66757714D2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b1bfc1-24a7-439f-f1e0-08da0db3d9ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 16:32:13.1744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 63bNMKNs6XBVQwK7cCi8NVIagC+otoQHihs7fYSZqSH2CjS7Xzq0071VcdCavFRSys0ZJwURc4/eus/CunWXWcK/f35+jmXcAYpTlxXaSOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5135
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjIuMDMuMjAyMiAyMzozOSwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUNCj4gY29udGVudCBpcyBzYWZlDQo+IA0KPiBBbSAyMDIyLTAzLTE4IDEzOjE3LCBzY2hy
aWViIENsYXVkaXUuQmV6bmVhQG1pY3JvY2hpcC5jb206DQo+PiBPbiAwNy4wMy4yMDIyIDE0OjA0
LCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0KPj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sg
bGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cNCj4+PiB0aGUNCj4+PiBj
b250ZW50IGlzIHNhZmUNCj4+Pg0KPj4+IEFtIDIwMjItMDMtMDcgMTI6NTMsIHNjaHJpZWIgQ2xh
dWRpdS5CZXpuZWFAbWljcm9jaGlwLmNvbToNCj4+Pj4gT24gMDQuMDMuMjAyMiAxMzowMSwgTWlj
aGFlbCBXYWxsZSB3cm90ZToNCj4+Pj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91DQo+Pj4+PiBrbm93DQo+Pj4+PiB0aGUN
Cj4+Pj4+IGNvbnRlbnQgaXMgc2FmZQ0KPj4+Pj4NCj4+Pj4+IEhpLA0KPj4+Pj4NCj4+Pj4+IHRo
YW5rcyBmb3IgdGhlIHF1aWNrIHJldmlldy4NCj4+Pj4+DQo+Pj4+PiBBbSAyMDIyLTAzLTA0IDA5
OjMwLCBzY2hyaWViIENsYXVkaXUuQmV6bmVhQG1pY3JvY2hpcC5jb206DQo+Pj4+Pj4gT24gMDMu
MDMuMjAyMiAxODowMywgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4+Pj4+Pj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4+
Pj4+Pj4ga25vdw0KPj4+Pj4+PiB0aGUgY29udGVudCBpcyBzYWZlDQo+Pj4+Pj4+DQo+Pj4+Pj4+
IEFkZCBhbGwgdGhlIHVzYXJ0IG5vZGVzIGZvciB0aGUgZmxleGNvbSBibG9jay4gVGhlcmUgd2Fz
IGFscmVhZHkNCj4+Pj4+Pj4gYW4gdXNhcnQgbm9kZSBmb3IgdGhlIGZsZXhjb20zIGJsb2NrLiBC
dXQgaXQgbWlzc2VkIHRoZSBETUENCj4+Pj4+Pj4gY2hhbm5lbHMuDQo+Pj4+Pj4NCj4+Pj4+PiBB
bmQgaXQgd291bGQgYmUgZ29vZCB0byBnbyB0aG91Z2ggYSBkaWZmZXJlbnQgcGF0Y2guDQo+Pj4+
Pg0KPj4+Pj4gc3VyZQ0KPj4+Pj4NCj4+Pj4+Pj4gQWx0aG91Z2ggdGhlIERNQSBjaGFubmVscyBh
cmUgc3BlY2lmaWVkLCBETUEgaXMgbm90DQo+Pj4+Pj4+IGVuYWJsZWQgYnkgZGVmYXVsdCBiZWNh
dXNlIGJyZWFrIGRldGVjdGlvbiBkb2Vzbid0IHdvcmsgd2l0aCBETUEuDQo+Pj4+Pj4+DQo+Pj4+
Pj4+IEtlZXAgdGhlIG5vZGVzIGRpc2FibGVkIGJ5IGRlZmF1bHQuDQo+Pj4+Pj4+DQo+Pj4+Pj4+
IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+DQo+Pj4+Pj4+
IC0tLQ0KPj4+Pj4+PiDCoGFyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NnguZHRzaSB8IDU1DQo+Pj4+
Pj4+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+Pj4+Pj4gwqAxIGZpbGUg
Y2hhbmdlZCwgNTUgaW5zZXJ0aW9ucygrKQ0KPj4+Pj4+Pg0KPj4+Pj4+PiBkaWZmIC0tZ2l0IGEv
YXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpDQo+Pj4+Pj4+IGIvYXJjaC9hcm0vYm9vdC9k
dHMvbGFuOTY2eC5kdHNpDQo+Pj4+Pj4+IGluZGV4IGE3ZDQ2YTJjYTA1OC4uYmVhNjliNmQyNzQ5
IDEwMDY0NA0KPj4+Pj4+PiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LmR0c2kNCj4+
Pj4+Pj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpDQo+Pj4+Pj4+IEBAIC05
Miw2ICs5MiwxOSBAQCBmbHgwOiBmbGV4Y29tQGUwMDQwMDAwIHsNCj4+Pj4+Pj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAjc2l6ZS1jZWxscyA9IDwxPjsN
Cj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBy
YW5nZXMgPSA8MHgwIDB4ZTAwNDAwMDAgMHg4MDA+Ow0KPj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+Pj4+
Pj4+ICsNCj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHVzYXJ0MDogc2VyaWFsQDIwMCB7DQo+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29tcGF0aWJsZSA9DQo+Pj4+
Pj4+ICJhdG1lbCxhdDkxc2FtOTI2MC11c2FydCI7DQo+Pj4+Pj4NCj4+Pj4+PiBBcmUgdGhlIHVz
YXJ0IGJsb2NrcyBpbiBsYW45NjZ4IDE6MSBjb21wYXRpYmxlIHdpdGggd2hhdCBpcyBpcw0KPj4+
Pj4+IHNhbTkyNjA/DQo+Pj4+Pj4gSW4NCj4+Pj4+PiBjYXNlIG5vdCBpdCBtYXkgd29ydGggdG8g
aGF2ZSBhIG5ldyBjb21wYXRpYmxlIGhlcmUsIGZvciBsYW45NjZ4LA0KPj4+Pj4+IHN1Y2gNCj4+
Pj4+PiB0aGF0DQo+Pj4+Pj4gd2hlbiBuZXcgZmVhdHVyZXMgd2lsbCBiZSBpbXBsZW1lbnRlZCBp
biB1c2FydCBkcml2ZXIgZm9yIGxhbjk2NngNCj4+Pj4+PiB0aGUNCj4+Pj4+PiBvbGQNCj4+Pj4+
PiBEVCAodGhpcyBvbmUpIHdpbGwgd29yayB3aXRoIHRoZSBuZXcga2VybmVsIGltcGxlbWVudGF0
aW9uLg0KPj4+Pj4NCj4+Pj4+IER1cmluZyBteSByZXZpZXcgb2YgdGhlIGluaXRhbCBkdHNpIHBh
dGNoLCBJJ3ZlIGFza2VkIHRoZSBzYW1lDQo+Pj4+PiBxdWVzdGlvbg0KPj4+Pj4gWzFdDQo+Pj4+
PiBhbmQgSSB3YXMgdG9sZCB0aGV5IGFyZSB0aGUgc2FtZS4NCj4+Pj4+DQo+Pj4+PiBBdCBsZWFz
dCB0aGlzIGV4YWN0IHVzYXJ0IGNvbXBhdGlibGUgaXMgYWxyZWFkeSBpbiB0aGlzIGZpbGUuIEkg
d2FzDQo+Pj4+PiB1bmRlcg0KPj4+Pj4gdGhlIGltcHJlc3Npb24sIHRoYXQgd2FzIHRoZSBsZWFz
dCBjb250cm92ZXJzaWFsIGNvbXBhdGlibGUgOikNCj4+Pj4NCj4+Pj4gT0suDQo+Pj4+DQo+Pj4+
Pg0KPj4+Pj4gQnV0IHlvdSdsbCBuZWVkIHRvIHRlbGwgbWUgaWYgdGhleSBhcmUgdGhlIHNhbWUg
b3Igbm90LCBJIGRvbid0IGhhdmUNCj4+Pj4+IGFueSBjbHVlIHdoYXQgbWljcm9jaGlwIGhhcyBy
ZXVzZWQuDQo+Pj4+DQo+Pj4+IEZyb20gc29mdHdhcmUgcG9pbnQgb2YgdmlldyBjb21wYXJpbmcg
cmVnaXN0ZXJzIHNob3VsZCBiZSBnb29kLCBhcw0KPj4+PiBmYXINCj4+Pj4gYXMgSQ0KPj4+PiBj
YW4gdGVsbC4gQWxsIEFUOTEgZGF0YXNoZWV0IHNob3VsZCBiZSBhdmFpbGFibGUuIEkgdGhvdWdo
IHlvdSBoYXZlDQo+Pj4+IGNoZWNrZWQNCj4+Pj4gb25lIGFnYWluc3QgTEFOOTY2LiBBdCB0aGUg
bW9tZW50IEkgZG9uJ3QgaGF2ZSBhIERTIGZvciBMQU45NjYuIEknbGwNCj4+Pj4gZmluZA0KPj4+
PiBvbmUgYW5kIGhhdmUgYSBsb29rLg0KPj4+DQo+Pj4gU28gbXkgdHJhaW4gb2YgdGhvdWdodCB3
YXMgbGlrZTogZXZlbiBpZiB0aGUgcmVnaXN0ZXJzIGFyZSB0aGUgc2FtZSBJDQo+Pj4gY2Fubm90
IGJlIHN1cmUgdGhhdCBpdCBpcyB0aGUgZXhhY3Qgc2FtZSBJUCBhbmQgd2lsbCBiZWhhdmUgdGhl
IHNhbWUuDQo+Pj4gVGhlcmVmb3JlLCBpdCBpcyBzb21ldGhpbmcgb25seSBtaWNyb2NoaXAgY2Fu
IGFuc3dlci4NCj4+Pg0KPj4+IFlvdSBjYW4gZmluZCB0aGUgcmVnaXN0ZXJzIGF0DQo+Pj4gaHR0
cHM6Ly9taWNyb2NoaXAtdW5nLmdpdGh1Yi5pby9sYW45NjY4X3JlZ2luZm8vcmVnaW5mb19MQU45
NjY4Lmh0bWwNCj4+Pg0KPj4+IEknbSBub3QgYXdhcmUgb2YgYW55ICJjbGFzc2ljIiBkYXRhc2hl
ZXQuDQo+Pg0KPj4gWW91IGNhbiBmaW5kIGFsbCBBVDkxIGRhdGFzaGVldCBvbiBNaWNyb2NoaXAg
d2ViIHNpdGUgWzFdLg0KPj4NCj4+IFNpbXBsZSByZWdpc3RlciBjb21wYXJpc29uIGIvdyByZWdp
c3RlciBtYXBwaW5nIGF0IFsyXSBhbmQgU0FNQTVEMg0KPj4gZGF0YXNoZWV0IFszXSAod2hpY2gg
dXNlcyB0aGUgc2FtZSBjb21wYXRpYmxlKSzCoCBTQU05WDYwIGRhdGFzaGVldCBbM10NCj4+IGFu
ZA0KPj4gU0FNQTdHNSBkYXRhc2hlZXQgKG5vdCBwdWJsaWMgYXQgdGhlIG1vbWVudCkgYnJpbmdz
IHVwIGEgZGlmZmVyZW5jZSBhdA0KPj4gcmVnaXN0ZXIgRkxFWF9VU19DUiAoYml0cyAxNiwgMTcp
IHdoaWNoIGFyZSBub3QgYXZhaWxhYmxlIG9uIFNBTUE1RDIsDQo+PiBTQU05WDYwIG9yIFNBTUE3
RzUuIFVubGVzcyB0aGlzIGlzIGEgbWlzdGFrZSBvbiBkb2N1bWVudGF0aW9uIGF0IFsyXSBJDQo+
PiBzYXkNCj4+IGl0IG5lZWRzIGEgbmV3IGNvbXBhdGlibGUuDQo+IA0KPiBJIGNhbid0IGZvbGxv
dyB5b3UgaGVyZS4gVGhlc2UgYml0cyBhcmUgYWxyZWFkeSB1c2VkIGluIHRoZSBjdXJyZW50IFVB
UlQNCj4gZHJpdmVyDQoNCllvdSdyZSByaWdodCwgSSBoYXZlbid0IGNoZWNrZWQgdGhlIGRyaXZl
ci4NCg0KPiBhbmQgYXJlIHN1cHBvcnRlZCBvbiB0aGUgTEFOOTY2WC4gU28gaWYgYW55dGhpbmcs
IFNBTUE1RDIsDQo+IFNBTTlYNjANCj4gYW5kIFNBTUE3RzUgbmVlZCBhIG5ldyBjb21wYXRpYmxl
LCBubz8NCg0KSXQgc2VlbXMgdGhhdCdzIHRydWUgdW5sZXNzIHNvbWUgZXJyb3JzIGluIGRhdGFz
aGVldC4gSSdsbCBkb3VibGUgY2hlY2sgb24NCm15IHNpZGUuDQoNClRoYW5rIHlvdSwNCkNsYXVk
aXUgQmV6bmVhDQoNCj4gDQo+IC1taWNoYWVsDQo+IA0KPj4gS2F2eWEsIGNvdWxkIHlvdSBjb25m
aXJtIHRoaXM/DQo+Pg0KPj4gVGhhbmsgeW91LA0KPj4gQ2xhdWRpdSBCZXpuZWENCj4+DQo+PiBb
MV0gaHR0cHM6Ly93d3cubWljcm9jaGlwLmNvbS8NCj4+IFsyXQ0KPj4gaHR0cHM6Ly9taWNyb2No
aXAtdW5nLmdpdGh1Yi5pby9sYW45NjY4X3JlZ2luZm8vcmVnaW5mb19MQU45NjY4Lmh0bWwNCj4+
IFszXQ0KPj4gaHR0cDovL3d3MS5taWNyb2NoaXAuY29tL2Rvd25sb2Fkcy9lbi9kZXZpY2Vkb2Mv
ZHM2MDAwMTQ3NmIucGRmI0cyMi4yMTkzMjc3DQo+PiBbNF0NCj4+IGh0dHBzOi8vd3cxLm1pY3Jv
Y2hpcC5jb20vZG93bmxvYWRzL2FlbURvY3VtZW50cy9kb2N1bWVudHMvTVBVMzIvUHJvZHVjdERv
Y3VtZW50cy9EYXRhU2hlZXRzL1NBTTlYNjAtRGF0YS1TaGVldC1EUzYwMDAxNTc5RS5wZGYNCj4+
DQo+Pg0KPj4+DQo+Pj4gLW1pY2hhZWwNCg0K
