Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0B34CCFE4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 09:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbiCDIZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 03:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbiCDIZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 03:25:01 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E95F199E05;
        Fri,  4 Mar 2022 00:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646382255; x=1677918255;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=T5BMQX5FcViP2eAusNnxzrS9klRqt7bejvpK8CfX5iM=;
  b=oarDVdyhDYV9i/oQHFfwMEZLqHeim98WaV0UgOiL4yxxG37sxxM9ZEd9
   9o9QmZFZxngeNh0lUd7OcTw0vZs19CzKu0hpSFwoK9256jcLc4QufvzeM
   U/uY1FPMop3AaiggTRcigEGqjgIrUxF4fQsH4NDFXvN/LRfz45DUVtSyY
   MuKwbeYK5cFVzRoS31Q9zzJwE6g9SBIWlvJn/oKre6zI+mmmwSX+x+Its
   Nu7HxlKFu+BY27qditt/rlRYkJiDNBAEJZTKotHDqP2KZ4xI07uTRKk31
   Kuj7l2PQTqYTgt1Ofa6wsRD3GbkGiLa0a+hvtZvcV+eaYl6H5EIhg/Vta
   w==;
X-IronPort-AV: E=Sophos;i="5.90,154,1643698800"; 
   d="scan'208";a="155244454"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 01:24:14 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 01:24:13 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Fri, 4 Mar 2022 01:24:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSnQq9bWp55/GQbHppHa8dgq/5Hb8POuIbg6b2kbA0mveCrNHle+/6I5b3/o4BrV/liksQgP+0/5xooe2ndtdMtNHp9IqxZ1+ggI330rxXmtLn/Gn9NbfBpzUD3tuT2FU6zvEZHSnVj91leluo0pjesby/DhNx+2B//TxY/Ttt/tzweudilr8FFZ1f6P22kNHVildgu+J/v14GqeNEa7m6enS0Ndi90Dya8pvghIChGe+X8wObjGFCVZHYGaCGVbksGvuy28OqQ9mn9qYFaurN0iVR99Knm6t+ylEyc286gHbdEEgF0ufjI20LsGLeTdTnKl5qTmwCe3gyyIip1H4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5BMQX5FcViP2eAusNnxzrS9klRqt7bejvpK8CfX5iM=;
 b=R2JTUlvSt4JHOJD6ufvXA84ZCp+7Hklaj/SJKOMYueNY+2qDVwu5PkAClqCnbKibR78zlizh6vvkboryqjbWommPGfflVywI5hedtaEr/b9pgeEJ/8+LjDuFBRjnJ/UQZQU4c6fjrrJ3q7d5vhCoG6wq9trxOICK2AY5oiYAYMCmUhzeRhsq3zf4o3JV8E5P7EavmrWG9wcIh2s2lLNtPQV+nwwoz1xzqCPVpabfBfjkOlGGvs2PhZGJkGdqyVYiD6kqS92Hik6IxBB5chDq3Ta48O1rvfJiDZey/o3hslDqFB8jKajIuELYRmRTtXGXytfcqPsN7ivnD3nFRxw5RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5BMQX5FcViP2eAusNnxzrS9klRqt7bejvpK8CfX5iM=;
 b=A/5Y4Vjd2nS7393mT+RvKoV42pdvBm5LKbUk1B++3uqmqvi2pi6FAVCdOVY7PJg3XSrN2Ry66vQhRgAMaGz4+ZCqvDPmQYLYm0vMqkTs9HKNW532O34SydMmllbu/yMsCwYU5r37x2gV+tE1Ui6r+U4hu0l2lbOLkUbtc+dTRNI=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by BL1PR11MB5430.namprd11.prod.outlook.com (2603:10b6:208:31e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 08:24:11 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b%5]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 08:24:11 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <michael@walle.cc>, <Kavyasree.Kotagiri@microchip.com>,
        <Nicolas.Ferre@microchip.com>
CC:     <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v1 2/6] ARM: dts: lan966x: add sgpio node
Thread-Topic: [PATCH v1 2/6] ARM: dts: lan966x: add sgpio node
Thread-Index: AQHYL6E59KtapGxM1UOiZbc3ZddkJQ==
Date:   Fri, 4 Mar 2022 08:24:11 +0000
Message-ID: <c1462fbe-1619-7a13-4b3d-bb4ffcf24f1b@microchip.com>
References: <20220303160323.3316317-1-michael@walle.cc>
 <20220303160323.3316317-3-michael@walle.cc>
In-Reply-To: <20220303160323.3316317-3-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0593acbb-222f-477c-cc8c-08d9fdb85c30
x-ms-traffictypediagnostic: BL1PR11MB5430:EE_
x-microsoft-antispam-prvs: <BL1PR11MB5430724ECD0AE7DE0DBC4F1187059@BL1PR11MB5430.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rQCBxGxMnETTO7bQQJ+rUrLbc9bPMwjxLA1OHH04r/V78qJAUZyF0XS0TMuEUO6xjVBdmbSA0iO2uUKbNZC3DG1GC0rFI1EemxB20SZtaM/zgzH3ekyIFMwVNmM0g/2N20RxMF0Q4yHG4nnKM1G6gBWguk0y9QDlsxwojO5udDJU3Py993f/SIPY5nbnbe1ZKrSDOSihoLVb89aMP+Tyg2KSPqlypE16KAPI5PcuAJ8tXr5CjQirHzc9dyj/0BDY8nRSWh3dLgqoSmvNGhhY7KRHSQMKS7/yDqQaMDEBgvCcbyUkqCdd8ajf0B4cPcC4U218++zeMp+hbUgc1EnxVXp+KFcZth2j1IPaXVWnOjtxfsbcqO1ymwI7CUw0c0b9acXC5SRKMCrCcDHgIsIamofZCMur9URUumxiRzy2rb+NydwToeBexeIapWtcK4TNq780NARA3M1B/2MTwTdUEUX+a/rNYPZd1eLS5LwCpt7ceAzN6cga0Oab2XIQpy053vqQpfgPDZ8xuP3Zyl+Z5X7j3nExa69Yv1Vo80SibmK8CrmRp2WZ67T9YXwohiEhPxXOglrRlPyilW23qi9NBH8cUR5hq6Gp8PVTyu6Zx5tZ/L7fmO9j69/O0o+APtbdY/QIh281r9UdV7d1/VrJdU0jvVtz8uQHheWwSoMEEwKGaN1k3IhaoTeyrzivICRt/qwARpPgStKJc+G6gQWJruG5us/3/LWAoB2f5FZLxwIXc9oSXGrigFQST51V5QMRH+ZzdMmtX0IfN9JVzY9aD+24K2ASiTbVg5LtsGSK9pA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(71200400001)(110136005)(6636002)(2616005)(83380400001)(8936002)(53546011)(38070700005)(2906002)(6512007)(508600001)(316002)(64756008)(38100700002)(122000001)(66476007)(36756003)(5660300002)(66556008)(66946007)(66446008)(6486002)(91956017)(26005)(76116006)(31686004)(86362001)(186003)(31696002)(8676002)(6506007)(4326008)(7416002)(87944003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjRIbzN5WG55OFhRZUpZTUl6OWs2U3FMdWVENGRLKythS0ZMN0Jjci9BaXow?=
 =?utf-8?B?OFl1bUQyUXZZL0JoTE1HUVVCYnFLQ3Y5MkFSVWFialBnMlVOM2tMSW43aFFC?=
 =?utf-8?B?T2xqZklOOG5BblorcC8rNmtlUDNoYTJsR1J4cWZMbURkSy9PUk96R1k5TVpk?=
 =?utf-8?B?Q2JSYlRNUGJmWFQwRUJqVDBzVmlwYnRwbnJESlhhVDhUN1hzVTQ2Mk14eE5B?=
 =?utf-8?B?dGhDVDVWS0tHSWQxelorUmR4aEhabVlLZlV5WXBqSkZRZGFEclV5L215dURZ?=
 =?utf-8?B?T3BqM2NSZ0N2M09lUk1xODE3Q09qVHBGZDJrUWN6Rm84MTJBTFYwa2NqbUdn?=
 =?utf-8?B?MVYrODZHdEZLa0JKcWdOTnkrcGFGVkdwMFVxSHZCWW51TzJvUk9FMUpEYjJp?=
 =?utf-8?B?d1Q4WERmT0F3SGRBN1g1Qk96dWxFSkxCTEVCUDh6dDhpWkZBSCsyYW5lRDRC?=
 =?utf-8?B?VGZ5ZGE4REZVcW9uTmZOTGRCd3hpd1M0MXdHVWptOHk0VUFvT1lGN1g2bmV2?=
 =?utf-8?B?TVNNTGsxWGlKL3IwZTBMekh0ZnRhdm5aQ1hjU3lhYnRzTlNEK0RSVElzRVg4?=
 =?utf-8?B?K20wczg0aDRqWlNlcGczaEY0cExRR2dPOXFQNkRLRTdDWU9jL1J3Q2RXOUxi?=
 =?utf-8?B?dHYrUGcrOUFqK0FmQVNpaDh3dE0xSGVsWWRDTU5nbHU2YW82c21YVzVTVW5u?=
 =?utf-8?B?MzNvcE9EMmtLM0hpdmdOOEVTOHlxQzVMdWdXUTVCQU96dkNOZ09scExidmEx?=
 =?utf-8?B?NmhpSG5QSktxM3prbUNzY28rSXhmSGhLSjBqRkQzNERDemI2K2NKVksxSGIz?=
 =?utf-8?B?MFk3OGEydFZjK0Y0TGhsL093VElVOGpEcnZSMDloNmlYUjlKRVBlUEFUTEpo?=
 =?utf-8?B?QTkxVW9aUEVNcHp4bnZSNndiNzBkTXhqTEUwNkZoZDUzMUhLaS83TTd5dGp3?=
 =?utf-8?B?MzBBTUdXYXhmbEI4WE9FQkZLTGlVS3FiME9tcjMwOWdCTEVxRU5VSHE1Mkdk?=
 =?utf-8?B?TnI0NURTSmxNQmxBdjhUWjJvaDZvNk1yUE8zeGRQNmhHcFRKTThTOFBxNzVx?=
 =?utf-8?B?ZXJmSmVEMHdKbVgrNllaQktDY0VIendkNnRNQU5TZytZS0RKYmp1Y1p5UjV6?=
 =?utf-8?B?OEtMRGRKYVZkd1BndU1qTEJMZ1VkNFNMOGthczMzRmVDWHIvTTZ0MnVJVnFw?=
 =?utf-8?B?SDVIajJHMW9iUWcwVFZ3L3MrNWczWFh0TXBZUWxsWjZaVW9oVDFHR2srSWMz?=
 =?utf-8?B?Y0dXc1lubUV1eEUwZitwZFNOTnJsN3ZUOUZzdThMaFNDMVJtbjBLdFJ4U2Ir?=
 =?utf-8?B?OGVwQ3BhcDREb3lsVXBkSzM0OC81TTlWN3RMRzhURXlWbEdBSEF2MHVIOW5r?=
 =?utf-8?B?WUN1YWEzdzFCMlRYSzBna2E3VyswMWhsalE5Qmpac0d5Q2ZiT2QvMllLbXNC?=
 =?utf-8?B?OGpVS3ZhUmZ4dFVCWmhqWHl4SFRMRkhhNW9Vd20rSHlDYXlSZ2ZtL29SdlJ2?=
 =?utf-8?B?aHk3c1FhdnhZb2tVN0kycWphaW9MZkxiSjRpZXhsVUE0cW9tc1J4UnlCemxY?=
 =?utf-8?B?RS83V2NxMUxvaHJudDl0TUpkQnRLTUZoWC81OEwrLzQyTGxuL0ZIUThwbFlF?=
 =?utf-8?B?YUlFTElrRUwzOUduMkRCQll1SEZBNkVHVjZRRGM0Wi9CckZrQnZ4NnNVaDBX?=
 =?utf-8?B?Z2xjYXV5eUpGYk1lWHVkRkhjV2o0NERJZUpxY1cxMUwvSU9SU1ZVRlpGYk5y?=
 =?utf-8?B?SGlya2dHcllZRklaZUNLYU5ZREVYd1hTYnpScDVoK0tHNE9ZR252Yk1lbnhZ?=
 =?utf-8?B?ZHdTUHZNVE5Qd1ZLRWJobW9vSUVwRHgzWlZSZXczWUt5MlVMMWJVL0tqY0hI?=
 =?utf-8?B?ZWVrQjZWMzJvWUhnVk1xQ2NRZ1h5endTTXFJSTY0NTVlalBYTTBxZWNCSEVq?=
 =?utf-8?B?SWdZa0hCMjNmQ2xGSEZubk9TeDJydFdiN3pzZVBXakR3b0xvV1VYZFppc0Fz?=
 =?utf-8?B?bWRNRHF1Rjg3ajNtRU1QY3p2NDJLaUFOQ0dWWTljWWZXSzlNb0NSbzdINmdp?=
 =?utf-8?B?L1QvRk1mb2hNbU4wV3NTU0VQcndRQVdqQVBmcmlyZkVQSTQzQUR4dU1Wc3c3?=
 =?utf-8?B?TnY3RXFtekc5ZGRmYUZiWW55WFlsZFVQREFFR3N3OGROcmlPYlFKSWdYbGlZ?=
 =?utf-8?B?ZDlacWxNS1dzSVNlY0FwMDdscHRkRG5NRWNxVmMwZ1hJM1p2YmFUczVlYmpT?=
 =?utf-8?B?dWtHYVQ0V3NadGtzS3FDMGJvQ2tBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B7CF6DCA25BF34AA32B8867E8AF95E5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0593acbb-222f-477c-cc8c-08d9fdb85c30
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 08:24:11.1210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rti/dnAP8TD2DCfy3VsPaHtSEhkuF5fPqOFFH8cayht5vXsxK0pm0vFL+DIkAht1ddqxpYVQA5e2rU8KfM6SPfkxB5e3m3mBzZYPNi+X0Vw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5430
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDMuMDMuMjAyMiAxODowMywgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBZGQgdGhlIGRldmljZSB0cmVlIG5vZGUgZm9y
IHRoZSBTR1BJTyBJUCBibG9jayByZXVzZWQgZnJvbSB0aGUNCj4gU3BhclgtNS4gS2VlcCB0aGUg
bm9kZSBkaXNhYmxlZCBieSBkZWZhdWx0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBX
YWxsZSA8bWljaGFlbEB3YWxsZS5jYz4NCj4gLS0tDQo+ICBhcmNoL2FybS9ib290L2R0cy9sYW45
NjZ4LmR0c2kgfCAyNiArKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDI2IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0
cy9sYW45NjZ4LmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LmR0c2kNCj4gaW5kZXgg
NWU5Y2JjOGNkY2JjLi5hN2Q0NmEyY2EwNTggMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3Qv
ZHRzL2xhbjk2NnguZHRzaQ0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LmR0c2kN
Cj4gQEAgLTIyMyw2ICsyMjMsMzIgQEAgZ3BpbzogcGluY3RybEBlMjAwNDA2NCB7DQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICNpbnRlcnJ1cHQtY2VsbHMgPSA8Mj47DQo+ICAgICAgICAgICAg
ICAgICB9Ow0KPiANCj4gKyAgICAgICAgICAgICAgIHNncGlvOiBncGlvQGUyMDA0MTkwIHsNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPiArICAgICAgICAgICAgICAgICAg
ICAgICBjb21wYXRpYmxlID0gIm1pY3JvY2hpcCxzcGFyeDUtc2dwaW8iOw0KPiArICAgICAgICAg
ICAgICAgICAgICAgICBjbG9ja3MgPSA8JnN5c19jbGs+Ow0KPiArICAgICAgICAgICAgICAgICAg
ICAgICByZWcgPSA8MHhlMjAwNDE5MCAweDExOD47DQo+ICsgICAgICAgICAgICAgICAgICAgICAg
IHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgc2dw
aW9faW46IGdwaW9AMCB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVnID0g
PDA+Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAibWlj
cm9jaGlwLHNwYXJ4NS1zZ3Bpby1iYW5rIjsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBncGlvLWNvbnRyb2xsZXI7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
I2dwaW8tY2VsbHMgPSA8Mz47DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50
ZXJydXB0cyA9IDxHSUNfU1BJIDE4IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGludGVycnVwdC1jb250cm9sbGVyOw0KPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICNpbnRlcnJ1cHQtY2VsbHMgPSA8Mz47DQoNCkNhbiB5b3Ug
cHJlc2VydmUgdGhlIG9yZGVyIG9yIHByb3BlcnRpZXMgZm9yIHRoaXMgbm9kZQ0KDQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgIH07DQo+ICsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgc2dw
aW9fb3V0OiBncGlvQDEgew0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbXBh
dGlibGUgPSAibWljcm9jaGlwLHNwYXJ4NS1zZ3Bpby1iYW5rIjsNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICByZWcgPSA8MT47DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgZ3Bpby1jb250cm9sbGVyOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICNncGlvLWNlbGxzID0gPDM+Ow0KDQphbmQgdGhpcyBub2RlLiBJdCB3b3VsZCBiZSBlYXNpZXIg
dG8gZm9sbG93IGl0Lg0KQXMgYSBub3RlIEkgc2VlIG1vc3Qgb2YgdGhlIG5vZGVzIGluIHRoaXMg
RFQgZm9sbG93cyB0aGUgb3JkZXI6DQotIGNvbXBhdGlibGUNCi0gcmVnDQoNCkZvciBjb25zaXN0
ZW5jeSB3aXRoIHRoZSByZXN0IG9mIHRoZSBub2RlcyBpdCB3b3VsZCBiZSBnb29kIHRvIGtlZXAg
dGhlDQpzYW1lIG9yZGVyIGhlcmUuDQoNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgfTsNCj4g
KyAgICAgICAgICAgICAgIH07DQo+ICsNCj4gICAgICAgICAgICAgICAgIGdpYzogaW50ZXJydXB0
LWNvbnRyb2xsZXJAZThjMTEwMDAgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRp
YmxlID0gImFybSxnaWMtNDAwIiwgImFybSxjb3J0ZXgtYTctZ2ljIjsNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgI2ludGVycnVwdC1jZWxscyA9IDwzPjsNCj4gLS0NCj4gMi4zMC4yDQo+IA0K
DQo=
