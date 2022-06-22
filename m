Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D31554CFD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357068AbiFVO2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358396AbiFVO2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:28:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E6E2CC82;
        Wed, 22 Jun 2022 07:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655908116; x=1687444116;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nqgWdecj9IwIxFhYCib/Tu/YEhz2as3UtXCRUmowzWY=;
  b=AFbbdY5jHDztaWgj1ohxsVlfsv/0xr8EwCSCz54Z1wBB8S+bwSsls+BE
   ABF9XklOLXyvE6z4q7xxax0cr79e2d0YmKRKZUgoYtaO0rz+4ngKkxHSK
   oOG4trxOESfVgwoMsGEK0NT8Fl6DJvDhJnCHHHogCvOT3voNZnSfcn/XJ
   KU6KR64/Ok0L+b7KPQfntc2KQ2hRx8IP1FVEmm81LPvL0MJ7qK3CVq2fw
   nEH0aL5U+LuNeQS7MvS9OCY6PVQ1a1jUDdRWmou0PBEDFbmgiN0p7FYc/
   jYCS+Du4+MP22xF2cq0NzAGrma/q7CnNYZ6I4M4u7DewIgWejL1PZ0Ls8
   g==;
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="161552637"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jun 2022 07:28:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 22 Jun 2022 07:28:34 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 22 Jun 2022 07:28:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYQqH/s9Iht1nc/ZBQlgFaCQ8pbYOvr6brU/OVV6+yzX5vt/JuGE4Tytlm6VCEhR5kddvYvN8VcHXTieAjqXtyhYJM6Tc0UoBUuYkoyuuNxsLUjfBVeqceW01uuNCCvN1NNuAoHSJ0ujqT+/5DaqDn8SAOgM05Td30Sh3Udp8u+iFlcYMeVi9L2QTJ2adk9F4tNiwADjQvrqrqa+mYKvUFfU+lXTj32VjxjLbBVHPUCPOYDjFC/iHcEpECLwfuvVZndLUlJBz10C48YA7YVqV4PLQWom+m+EftlYg4AtInp9dehw/54sUdzuOIUQdhTNtpfTMlFBIFFiPI6EEfnc2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqgWdecj9IwIxFhYCib/Tu/YEhz2as3UtXCRUmowzWY=;
 b=CXZ6qYWUA25s6GRe/WgP/ri7YmXjFUftpRJJvyEG3/CnjPUCgylgl+h4S4Amv1q5aOgOwfbq71tvWPCNTqVM0ohQVi7Zuy06W2YHou0KOC+xWZtOaI9KwoEZE76fbgQs12qV9VcPOAZuB9qkkoCVlFT6Oaea+c44ZGy17vwvTvtvIq2SgbKPLaONtNOX3yOq33A8XeE1ImksGFOxLJK1boLRE3Cdy0dxUGXsAxxTyoE9gaNqN+HuY4IIDG1KvKFrriRONVouyiusJrrwURrLc6sd7Z50qzKZffYIYHPVd6ffxxeHRSpwz3JIcDLS9gwNSEuXSorgvEjM+Cd2ASKXXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqgWdecj9IwIxFhYCib/Tu/YEhz2as3UtXCRUmowzWY=;
 b=JbaSxvjtnwcYTTaNTWJay/QfrTwPTymUEThVHfAItNm/jD27DO8TgH2ew1RXR5UKwyaTrbikxpr0JncdR9wUsSs6mUOdf+yYVFeb23Z4fMKI4pY4k0tAi2OotjG9pPzpRb33iC4k9jjhjWi7oC8JVPUhokGfXmTwDRUXhmstK+Y=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM5PR11MB1644.namprd11.prod.outlook.com (2603:10b6:4:c::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.18; Wed, 22 Jun 2022 14:28:28 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 14:28:27 +0000
From:   <Conor.Dooley@microchip.com>
To:     <jiangjian@cdjrlc.com>, <rth@twiddle.net>,
        <ink@jurassic.park.msu.ru>, <mattst88@gmail.com>
CC:     <linux-alpha@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?UmU6IOWbnuWkje+8mltQQVRDSF0gYWxwaGE6IGlycV9pODI1OTogZHJvcCB1?=
 =?utf-8?Q?nexpected_word_'and'_in_the_comments?=
Thread-Topic: =?utf-8?B?5Zue5aSN77yaW1BBVENIXSBhbHBoYTogaXJxX2k4MjU5OiBkcm9wIHVuZXhw?=
 =?utf-8?Q?ected_word_'and'_in_the_comments?=
Thread-Index: AQHYhkGDRQeTk/Acs0eam/iQP1DkSq1bd+QAgAAENQA=
Date:   Wed, 22 Jun 2022 14:28:27 +0000
Message-ID: <c5b67cb1-05f9-365f-1ad4-8017a2a6d6e7@microchip.com>
References: <20220622140201.5458-1-jiangjian@cdjrlc.com>
 <7ae0e6b2-39e8-2453-b154-6c02734028b6@microchip.com>
 <tencent_6EA3802C352872BC44FBD555@qq.com>
In-Reply-To: <tencent_6EA3802C352872BC44FBD555@qq.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 815a9315-bb8d-4dda-17ba-08da545b792b
x-ms-traffictypediagnostic: DM5PR11MB1644:EE_
x-microsoft-antispam-prvs: <DM5PR11MB1644EA25CAF5F63908ED09A798B29@DM5PR11MB1644.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5I/Axd7yP8cgIAOIrQe7KB6V3HkrTflRFTcBfBxBmPdWr8MNZkYJo/TjrRAN8NJAaYU6bfh4Ti7Gd1yIO28UBFtB1oHYB8C1/rCbY1c9zxlFnQ79XXc1p8RI0defrEA9cbLKo73DqXM2LAEy2XDcQE/weIrq9U43MspelH/3ATlCSc6Fki8bxL+fswkjYkRG41uJLWMMqGj7Z8neyCejYpGJ0Z7UscslT8SipaoTdryiM50oE2qPCgC2hem3p+4f5S8i9daJiLHDRmTQsOwd4Ryajt0qr5UFfu1A6h5Qe+/yGHRra5o+0Z/IWMH37PGIp7MKgpUMDf7XQ4BJt6/8ZCOZX4niYzDXZ3zu5SzXzSCua0MkoSfTBqsoTe3Zd0kl7ANQa7LGDPndECWWB0jrmpG7vOYFU6idPzk7f1N9qIA0kWOOt52DVONqEu9noJ+w3F22aS64Gz6xa3XUMBcrQUlpMvDI0uXH+FgkfR6ya44hEE2ph+ht28DKGx9j6pomsaRBofNqBDdbpxTxU+ATQVhNe/k1DgIWuP3v8TqK77mpxRBK7EDqsSdmAHhJPNmoA8t7OBjQTe5UU9323aDh0o87EkmcpJ1qxd5V6dU1+hAVGHeQxhsMNKb0QQETRWZBCA3HojbwY+x87JeyVELye3vxtnMMVeilLKzbB7XJkch7c2vcOMLPrmPw1yTtVy7fxjXWxW2aV/S0KomfYV+XRxTu6BomDPr9B/2rRKSX9Fh2+txxGIM5OzpSX0F850DlRyi+QWqHnqsUd9BPZ9Tw5o/cOA6OP91Nzx/LTYZKz63ydIvtA5WqXjwkwNwyth6+VdXl/bpzCKYjM0vTh/fYjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(366004)(396003)(376002)(39860400002)(8936002)(38100700002)(86362001)(54906003)(6486002)(316002)(31696002)(31686004)(5660300002)(38070700005)(2906002)(122000001)(66946007)(2616005)(64756008)(6506007)(71200400001)(478600001)(76116006)(91956017)(4326008)(66556008)(186003)(53546011)(6512007)(83380400001)(66446008)(66476007)(110136005)(224303003)(41300700001)(36756003)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czlDZDNXSWRtbGU2VjhxdFdYL0JpaDZLYk5sSmYrRUl0cnB1Ulg4SmRYaXF3?=
 =?utf-8?B?OGZNY2pLNzg1NFNqdENNU2U2T3J1RzkwaEhxTi9XZ24xTk9PcktQOG1uOHlt?=
 =?utf-8?B?MUZnVUdiRHhIWTZkd2FGcXl3Y242SXAxZTFUdXBpR1VXV0FiUWlDRy9UeXR4?=
 =?utf-8?B?aFRKSzl3YkdmTzFpMmdxZ3lGb3RsSENXdThXV2M4UGZCMFVXeXlRMUVEODNa?=
 =?utf-8?B?ZlVubHJ5QXFlaU1NQkFRbGVOMmZwdi93MlpRenc5ZWxlWnpOdjREOVpCOXRN?=
 =?utf-8?B?ZnQzcUV4bnZFS2lOSnl2czBYdzFsM0paSytucUptSmFFbzRIUmxIa2paV2tH?=
 =?utf-8?B?dk9HVkVtdGRsRHk4UWphOWs4Nmd2N2JaSm1yRlBPMTNTNW1xTWlaN1R5NUU5?=
 =?utf-8?B?QklJbzBpdFp5emlUcG91SzlRV2VGK0hEOU5yRXpsME1yOEJ5R0pKQUw4RUxh?=
 =?utf-8?B?eXdtN3VZU2p3Vy90SExVaXJkampwV2tMTWJ1TTA5VHN2aDlNRkFkK1dERnN4?=
 =?utf-8?B?Z2tWenhqSmg0MVMzWWFmRlR6RE8vSTdJMWJvZUVIak5pK01VK0orZW5IVXFu?=
 =?utf-8?B?clZKNGZUd0U3bkVFNmJzQ1UvcURvTFIyYWJvSDUxbEZRRkRncHhoVFgvSENO?=
 =?utf-8?B?U3NkMncyNzZCeHBlZzVQcWZtZ0RReGYxY2k0eWdzOG85RXZUWlNkME1RcUg4?=
 =?utf-8?B?SzllNHhiazVFbmpWdGEyMUw5clpQWnNqak9BdGtTNHBlMGtlVy8xK0VlMXpK?=
 =?utf-8?B?NWV4TWw2SGlaQ05wQ1pwelRMMjFVOXlMZVJTMjB2MDZ3UUJoR0xsLzc0VlBm?=
 =?utf-8?B?TGVSRHhFYm9wdUdIWDNMZDQrSHI2TitRUVo0YVpROHB6cFMwT0xUaVlsVnhK?=
 =?utf-8?B?U1VvT0piZXFwempjUGp1b3BtbXRTb09zQko0TTdiSlBYTkl1M2ZZQzBxQ1pa?=
 =?utf-8?B?Rm9NMHgyREs4U1JwUHJJSHRTa2JZM1kvdWIrZ2VmVWcvc2lyMzdob09XdmJr?=
 =?utf-8?B?QTNXblR0M1ZweVd6NFVEQzJBbnZQazJ1N05rc1ljV25Vc2FJT1VVdEZ4UkFK?=
 =?utf-8?B?ZDBvaXlMRDFxTzMrUkVYaGh3ZUpIODN4U00yT3kvbEQ3TC9IaTU5U00zejVz?=
 =?utf-8?B?ekg2ZzhVZCtWd0I4WUVtV3oycVRDS3ZQVkxxRFFmNWppRHV5SElDYU5SeVRJ?=
 =?utf-8?B?WXdpWEJlTTlOakg1NWQ0N0EzcGFNYStTTERrZkV3QXN1QVBVV0VpTEZnOG53?=
 =?utf-8?B?Qnc0a0kvbXg2eGN0RFkzdGFTektzNVI3YWYvbjBSWStmRnhzRHBWUWR4OUVK?=
 =?utf-8?B?ZENMSGs4Y0hJcGIrNXdNN2dqVHRYTjl4Wk8zNnU4eVRzL3BoWWhvTzFxcmN2?=
 =?utf-8?B?Q1RJV040NEV6cVNzWHAzMHB3djR1dVMwamtESnJXQW01UnRhcUFYVnpJVU1T?=
 =?utf-8?B?ZDJNNlFWTmd2dkFPMlI3blE0UU4rSVBabHZ3Y3AvTUNiV3dIVUp4bzNGeGVE?=
 =?utf-8?B?ZUVkdm1OeUU5NzlqZTI4TmlVQXlPNjRBTm44Q01VNitPZ0JkbU9Xc0p5YVN2?=
 =?utf-8?B?YXVsNWV2d21yM0hmT2dwdlN0OGtMYkZzQnUvOWZJNDY5NU1md2xEUXdMQlNl?=
 =?utf-8?B?NkxFZ0VRVDkzaTl2ZWh0Qko5STdSSnZxbFNZRDVCQzUxN2FtS3cxWjFtUGxr?=
 =?utf-8?B?ZktDVG1xUjQ4WkhzeHhrUTU5ZU9vaGhQK3VTZFBQa0w5bFk0ZjNtMDZwdkxR?=
 =?utf-8?B?cis0bHByZUg2UFVvQm5ONFY4YkhvYXk0akd6UGk3eFZpRnd5Yk10a1pBSjVS?=
 =?utf-8?B?QmdQRXlFMzRyZHJpcFRMamtoeEhpUVY1amlORVVwUnRXL3N3T2dGWEhVc0pv?=
 =?utf-8?B?bU42a05NZ0pudmV1Sm1VamxjUUFUTW1IcS82UzN4QUEzNTM3dTZjUzNOM0Er?=
 =?utf-8?B?bnZONzZoRVJMb1hzR2UxL0x0TmV4Ump3K21RZXZRMXd2c0dDZDZWT2x5VEsz?=
 =?utf-8?B?TkFMYzMxYVVFZFptTnlmT2NkaFlIQ2svUFdrY1ZvK293Z3VmSXpLbVBTMThH?=
 =?utf-8?B?c1NDUnA0SW9nMkQ5SWVxdGNPRkJ4aFd5dlFybGtqOXlsejJsc3l1ZDM4akxN?=
 =?utf-8?Q?3fc4UGFSUsNLSoDgI1lwHPfe5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <618F0DF06312AE4A8D335867E2FFF2E4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 815a9315-bb8d-4dda-17ba-08da545b792b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2022 14:28:27.7658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lhUcnvaEx+qDsXnZ8KcPMW5eSmzePKdVkq6knOK01ZKsTSI7vIhJrcJARFp+G166vtooumB1AUkm72TO6rUjL5uDQCOctRTTE19I6Bakv4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1644
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjIvMDYvMjAyMiAxNToxMywg6JKL5YGlIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBj
b250ZW50IGlzIHNhZmUNCj4gSSBtaXN1bmRlcnN0b29kIGl0LCB0aGFuayB5b3UgZm9yIHlvdXIg
Z3VpZGFuY2UuDQoNClBsZWFzZSBkb24ndCBzZW5kIEhUTUwgbWFpbHMgdG8gdGhlIGxpc3QsIGlm
IHlvdSBkbyBvbmx5IChzb21lKSBkaXJlY3QNCnJlY2lwaWVudHMgd2lsbCBnZXQgdGhlIG1haWwu
DQpUaGFua3MsDQpDb25vci4NCg0KPiAtLS0tLS0tLS0tLS0tLS0tLS3CoOWOn+Wni+mCruS7tsKg
LS0tLS0tLS0tLS0tLS0tLS0tDQo+ICrlj5Hku7bkuro6KiAiQ29ub3IuRG9vbGV5IjsNCj4gKuWP
kemAgeaXtumXtDoqIDIwMjLlubQ25pyIMjLml6Uo5pif5pyf5LiJKSDmmZrkuIoxMDowOA0KPiAq
5pS25Lu25Lq6OiogImppYW5namlhbiI7ICJydGgiOyAiaW5rIjsgIm1hdHRzdDg4IjsNCj4gKuaK
hOmAgToqICJsaW51eC1hbHBoYSI7ICJsaW51eC1rZXJuZWwiOw0KPiAq5Li76aKYOiogUmU6IFtQ
QVRDSF0gYWxwaGE6IGlycV9pODI1OTogZHJvcCB1bmV4cGVjdGVkIHdvcmQgJ2FuZCcgaW4gdGhl
IGNvbW1lbnRzDQo+IA0KPiBPbsKgMjIvMDYvMjAyMsKgMTU6MDIswqBKaWFuZ8KgSmlhbsKgd3Jv
dGU6DQo+ICA+wqB0aGVyZcKgaXPCoGFuwqB1bmV4cGVjdGVkwqB3b3JkwqAnYW5kJ8KgaW7CoHRo
ZcKgY29tbWVudHPCoHRoYXTCoG5lZWTCoHRvwqBiZcKgZHJvcHBlZA0KPiAgPg0KPiAgPsKgZmls
ZTrCoGFyY2gvYWxwaGEva2VybmVsL2lycV9pODI1OS5jDQo+ICA+wqBsaW5lOsKgMTUwDQo+ICA+
DQo+ICA+wqAqwqDCoFRoZXJlZm9yZSzCoHJlYWTCoHRoZcKgbWFza8KgcmVnaXN0ZXLCoGFuZMKg
YW5kwqBvdXTCoHRob3NlwqBsaW5lcw0KPiAgPg0KPiAgPsKgY2hhbmdlZMKgdG86DQo+ICA+DQo+
ICA+wqAqwqDCoFRoZXJlZm9yZSzCoHJlYWTCoHRoZcKgbWFza8KgcmVnaXN0ZXLCoGFuZMKgYW5k
wqBvdXTCoHRob3NlwqBsaW5lcw0KPiAgPg0KPiAgPsKgU2lnbmVkLW9mZi1ieTrCoEppYW5nwqBK
aWFuwqA8amlhbmdqaWFuQGNkanJsYy5jb20+DQo+ICA+wqAtLS0NCj4gID7CoMKgwqBhcmNoL2Fs
cGhhL2tlcm5lbC9pcnFfaTgyNTkuY8KgfMKgMsKgKy0NCj4gID7CoMKgwqAxwqBmaWxlwqBjaGFu
Z2VkLMKgMcKgaW5zZXJ0aW9uKCspLMKgMcKgZGVsZXRpb24oLSkNCj4gID4NCj4gID7CoGRpZmbC
oC0tZ2l0wqBhL2FyY2gvYWxwaGEva2VybmVsL2lycV9pODI1OS5jwqBiL2FyY2gvYWxwaGEva2Vy
bmVsL2lycV9pODI1OS5jDQo+ICA+wqBpbmRleMKgMWRjZjBkOTAzOGZkLi5kYjU3NGRjZDY2NzXC
oDEwMDY0NA0KPiAgPsKgLS0twqBhL2FyY2gvYWxwaGEva2VybmVsL2lycV9pODI1OS5jDQo+ICA+
wqArKyvCoGIvYXJjaC9hbHBoYS9rZXJuZWwvaXJxX2k4MjU5LmMNCj4gID7CoEBAwqAtMTQ3LDfC
oCsxNDcsN8KgQEDCoGlzYV9ub19pYWNrX3NjX2RldmljZV9pbnRlcnJ1cHQodW5zaWduZWTCoGxv
bmfCoHZlY3RvcikNCj4gID7CoMKgwqAgwqAqLw0KPiAgPsKgwqDCoCAvKg0KPiAgPsKgwqDCoCDC
oCrCoMKgVGhlwqBmaXJzdMKgcmVhZMKgb2bCoGdpdmVzwqB5b3XCoCphbGwqwqBpbnRlcnJ1cHRp
bmfCoGxpbmVzLg0KPiAgPsKgLSDCoCrCoMKgVGhlcmVmb3JlLMKgcmVhZMKgdGhlwqBtYXNrwqBy
ZWdpc3RlcsKgYW5kwqBhbmTCoG91dMKgdGhvc2XCoGxpbmVzDQo+ICA+wqArIMKgKsKgwqBUaGVy
ZWZvcmUswqByZWFkwqB0aGXCoG1hc2vCoHJlZ2lzdGVywqBhbmTCoG91dMKgdGhvc2XCoGxpbmVz
DQo+IA0KPiBUaGlzwqBkb2VzwqBub3TCoGxvb2vCoGxpa2XCoGHCoHR5cG8/wqBTdXJlbHnCoHRo
ZcKgc2Vjb25kwqBhbmTCoG1lYW5zwqB0aGUNCj4gb3BlcmF0b3I/wqBNYXliZcKgaXTCoGNvdWxk
wqBiZcKgcmV3b3JkZWTCoGZvcsKgbW9yZcKgY2xhcml0ecKgdG/CoHNvbWV0aGluZw0KPiBsaWtl
wqAiYW5kwqBtYXNrwqBvdXQiLMKgYnV0wqB0aGXCoGluaXRpYWzCoG1lYW5pbmfCoGxvb2tzwqBz
YW5lDQo+IA0KPiBUaGFua3MsDQo+IENvbm9yLg0KPiANCj4gID7CoMKgwqAgwqAqwqDCoG5vdMKg
ZW5hYmxlZC7CoMKgTm90ZcKgdGhhdMKgc29tZcKgZG9jdW1lbnRhdGlvbsKgaGFzwqAyMcKgYW5k
wqBhMQ0KPiAgPsKgwqDCoCDCoCrCoMKgd3JpdGXCoG9ubHkuwqDCoFRoaXPCoGlzwqBub3TCoHRy
dWUuDQo+ICA+wqDCoMKgIMKgKi8NCg0K
