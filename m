Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8334652E523
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 08:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345911AbiETGkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 02:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237530AbiETGki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 02:40:38 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59FA14CA1A
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 23:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1653028838; x=1684564838;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RAqvjOP1BKQUYXPx/eEYSbPbQqaRadDUV5wPPR6myiM=;
  b=vcqVeZ2m6D+zYXl7PrBirQPZ8ToDP4ZovUan3IoK0r6doRC863YCEDqc
   iufFQ9+R1XHYv50ILTfag/pQR3auMUJaqRCyfK57akkQr1dis0TymxIyl
   bwnnedyrm7qIPD2M8wtWN8ZK+h4ql2IgM12Shms76IoTioSpoPdSCTHLD
   wg7SMj387lzy+xRMWg76l82Qg3FkM7vjFF+ZhZq9v1n3nUbEl2125CRtg
   kEysJLYbYVpY0C3G0l1zfW5yqeGpp+ZoP7VCmxlJBwpGHOZfE4QAaKqe9
   RBR5oUXBtx3MSjpiBk2qupBvFf0QoKiI47lfZGhBuwAOoV5nFcCvKSuPh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="55933146"
X-IronPort-AV: E=Sophos;i="5.91,238,1647270000"; 
   d="scan'208";a="55933146"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 15:40:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xds8LOa/uQqvuvawvbMWqmPqv1p1Y0C9f+6QkyMhtf8OhWifgLjImOK7uD16b+Jik17/2uYhwFEyuecKApDoYGkHSxuDyYpUCiBcGAjlOs2PHKrTf9bBoWaVDtWB9xbNxR1ijbq1J2YqfoDVt6GEfwoZieIxKQgoP+egvmy6K+A/MisSJXgBVnEeav/mjPp72VC93+TapBe5uTt4SVJVhkosJBgh0QL7jbl4s6icVaEO93hQpD2o8HIyBE9KmpQU6W1OCnJaxQHTdG6mU+P7GEFZcXuFL3y1LMVo0U7B7MvF5cC/6K5McYlypf8ySAW/JZTuXlQa9UL+zwq1XDMFUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAqvjOP1BKQUYXPx/eEYSbPbQqaRadDUV5wPPR6myiM=;
 b=bvkadJtVIr7eZo0I8CvHHcsfMP7g5UY8b5abH7itxkIL13QadF6RSB7waIZBmhr/kB9y39qiN0ROa51zQcmbMkE4Yt0a64i+qHJRD+RmdSOzrGgLxy7IPcwHHHPHHFP8IjcswHaQHcLqFCY73S1up0EXqzkHubzlVxrfCnuJ7FPMqunm8gCE2Dn5sA1D79gyDpawqz5kIDQ0E060f3h/V4bCL5cuF8gpU/6XLIjs/TPMalA15xKmk6q2/bmc1WphibjSUTpsxYdWm1joMMIlN3gdx4RBlHVo4cFRuadUI/gG8XjIKqrn6YDWpvueMBV8oAVQlvot3uMQyWi1gsM04Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAqvjOP1BKQUYXPx/eEYSbPbQqaRadDUV5wPPR6myiM=;
 b=Lk0hupA7sCHksawWEXYo1C50N/aywPp9U5Uf9fsA0H+NgLmmn5QteP9+MyDLJ7DxbuoOfIcif1qjCdWFnuUUHjrbweRfGu4iPveqIqEBVROpokusK9AwSz46LVGDs6ASzScS7iBzvYU4d3RHkHDjw7V89XwzN2FsSZRZw7N2N7c=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by TYAPR01MB3949.jpnprd01.prod.outlook.com (2603:1096:404:c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Fri, 20 May
 2022 06:40:26 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::a041:7644:4eca:ec8]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::a041:7644:4eca:ec8%7]) with mapi id 15.20.5273.015; Fri, 20 May 2022
 06:40:26 +0000
From:   "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
To:     'Greg KH' <gregkh@linuxfoundation.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "eugenis@google.com" <eugenis@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "pcc@google.com" <pcc@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "marcos@orca.pet" <marcos@orca.pet>,
        "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "marcan@marcan.st" <marcan@marcan.st>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 6/8] x86: Add hardware prefetch control support for x86
Thread-Topic: [PATCH v4 6/8] x86: Add hardware prefetch control support for
 x86
Thread-Index: AQHYaoDq7xJ4aiU+QEW7cdrhasBWQq0kMIYAgAMjJ6A=
Date:   Fri, 20 May 2022 06:40:26 +0000
Message-ID: <OSBPR01MB20373E8426E692474E39A16F80D39@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <20220518063032.2377351-1-tarumizu.kohei@fujitsu.com>
 <20220518063032.2377351-7-tarumizu.kohei@fujitsu.com>
 <YoSV4CPBXbNlj0Cq@kroah.com>
In-Reply-To: <YoSV4CPBXbNlj0Cq@kroah.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1eb94565-3447-48e5-9d29-08da3a2b9fe2
x-ms-traffictypediagnostic: TYAPR01MB3949:EE_
x-microsoft-antispam-prvs: <TYAPR01MB39496C0FC7716D2A841167FF80D39@TYAPR01MB3949.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PHqL24Xgry4qe7B1zg8pBuUuJFU2qUwaYyFyP0B4oO6Oey2WEqfeYoMgQLHDDFq/h1j7vxDODMNN8tHb5hXtkgsuD8oB/XeFqa/FcKeueUANtELD9uJp2y5UUaOmpDN6zNucPfS/aVbaR5kjoQBniUcJQs72SJ+zHuQGYJUkzmo/IdFqxBtl3o5H0eSVUtUEGcopTZdKjnUohvi7VL6mK5TFTkTmEE73Gsdydz3zzoDXGCPQKKWS0EhaU8RvfMpgS3JPCJbUGCdnOIJzhaKBpI8AaP+K47eSFUnRW/w96h80hbk/Afc9DLMC16uVG0GqnO6APISt5C2GYcVf5yUGAELCg+enTcECf/P8W7NACwUXi3/VMPgzMH5dj5yoYRIWMzzmoj5CGw6wgKUo6memnkYS9rZu5TbLchoalhnnghYxj2rNKVWAxGd+YEL1dmG7PPYkrZEPjoUFgA32mLsge4c3s+ornqo9dR9PsriaSX4dVwGufXj1YGMYZKKseQmSvADChqt1D5d6ArRw0+afiodQ48jm3u+rDH0Ls/hYx2GkYDe1KTPMUP2OaN0Xh5onebSQjO71437QmLk2i5/x50hAuHmLq350LuU8xusQfk6G5qJ0nmSxKeo4JIR0hE7IG/LMcNwEVSn0DfTHjsXGyaP2Mg3fTW1y7nhI4G4TPJCGpUK/MgE7MXZptl6kygKuc/pRUjvhszA3ZA3G4WxEPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(76116006)(4326008)(8676002)(71200400001)(33656002)(316002)(7696005)(508600001)(558084003)(6916009)(54906003)(86362001)(38100700002)(66476007)(64756008)(7416002)(55016003)(82960400001)(9686003)(6506007)(5660300002)(52536014)(8936002)(66556008)(66946007)(38070700005)(186003)(85182001)(122000001)(66446008)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?Mkc0aTI0RTRiWlZNem1sUHVTVTRLMmF0dVNpK1A3bER0Q0xsZ09Nck9Y?=
 =?iso-2022-jp?B?dU1YRGNCRzQ1QUIxcHpnd0ZZVWdoSitBc1dnSXo1Q2Fwa0Y2aEQxc0Zo?=
 =?iso-2022-jp?B?Rlo4WlVqNk9qLzBLcStwTWZjRTU4c3F2TVBVbE5odXVqN01Ddld1MEZm?=
 =?iso-2022-jp?B?aVV2NWNIOWtvMmVkVWhFTlAzZHZkcUpDUU1qTDlvQjRjYmlhOExsVmpZ?=
 =?iso-2022-jp?B?VlQ4cjBaOE0vRzJ0ZEljandpMjdzVmpxdTZGNCsyQjRGcXZHclhWazZh?=
 =?iso-2022-jp?B?b2ovU0tGNDhzTzJUemgvYjdoV3o0OW02WmNLMEp2Y0RWeFZYQUoxLytB?=
 =?iso-2022-jp?B?R3lrOTFsckRxa1BVT0RZZE5zd1BpeVdYdU5ULzNUQXdQeW5PVWxRMDk2?=
 =?iso-2022-jp?B?UEtXLzdXdndzVjJkS1MzQXRIYVpNT2tWcUVzZTFOd0VMaE4yRStZanpZ?=
 =?iso-2022-jp?B?dzZjYjY5M2Qxd1JRVUVJTnFQNTVOUkN5MW1idzhoY3MxMUQ0bUx1clda?=
 =?iso-2022-jp?B?OHBXcjNGR3BtelZ6S3M4UUFGNW0xSzJUaVgzRXUyOTNPQ2wxZm1QR210?=
 =?iso-2022-jp?B?aXlKYTFDa0RtM3o3cVBGSURUWGk1TXlJTk1tTmhob1FQaHpjNTNFNGdQ?=
 =?iso-2022-jp?B?MWlxZzUyZ0lGOFF6M0VZWEJMd25DZ21idFRCUHRvMjhDODJoNzZwazJ6?=
 =?iso-2022-jp?B?ajNabmVCYVNabWxzcVdHd3dhOUMwZDZyUy8veUFPdG9sRVN3VlkrQVNX?=
 =?iso-2022-jp?B?WUlZUkt3RUpFUG9CUjdEanJ5UmRWU1RsL1AycTJUSHBLcVM5RXplUG1D?=
 =?iso-2022-jp?B?V3hqNVdJajk2azdrKzZFTkduOXZZWHdnajV4RDlud3p3Z1JFUjI5SDlB?=
 =?iso-2022-jp?B?SHFDVTdtVmFQYnFwSjQ1Z1lObmYzT1NrRWUvd0hyMGRqZjN2OGthZWIz?=
 =?iso-2022-jp?B?M2w0ZnhVc2VDOUMwRnFVcEhOeGpxKzUrTFk5bWdJamJhalZjWlEvVG1y?=
 =?iso-2022-jp?B?Wmo4Q1FyZlR1VmpEaEZud0ZpNlRYTGlRamhKRVlJSVd0WTc1ZTZpMkhY?=
 =?iso-2022-jp?B?TTZQS0lwaGFmNVptR1N2Y0J0KzNmR3R6d0lSRnNsSHVIRFBPQy9KeTFD?=
 =?iso-2022-jp?B?S0ZZWEhLcXFuYXFua1JNVGszaUIwNk52VFpoM1ozY3NJU0FzWW9JSW04?=
 =?iso-2022-jp?B?SVpwZ21uMzcwWTBJbGpvb2dUNnZCeG1YWUREYjJuREgybnU1aHR6dmxx?=
 =?iso-2022-jp?B?d1FoT2NrS2RVK3cwZGpPSUp1aVc3QUYyQmZxdHZRTXZHYjEyZnFZcWx1?=
 =?iso-2022-jp?B?cExaMHdQWUdnZ256dVFuTTM4eTE0R3B6WmlPNWtyWis3a01NcWN3RXVk?=
 =?iso-2022-jp?B?NzBCRzBRSUNrQ3pENXFpenZkS2lHY1BQL1dXOGRKUTQ5b0ttTTdqUG0r?=
 =?iso-2022-jp?B?TVB0bS9JRnErd3pIa3J3ZlJOUTNhYmR3OEIvdkdiUGQ3djRORnVzSDNH?=
 =?iso-2022-jp?B?dHFOcTN1ck5GSS9BUmRZVlhwT1lDZ2Y5NVAxN29RdFdaViswa0JpYnVm?=
 =?iso-2022-jp?B?SE16Yk95U01hWGhmWU8wYndtR2ZUaWFaS1JmMi9TU0YrVHB3SDBUeUw5?=
 =?iso-2022-jp?B?b0V4UkI1Nk5paFVhUFZ6U3FmNi9kWEd3V0NGMElwVUE4ckVMaW56c1Yv?=
 =?iso-2022-jp?B?NlEyN2ZYbTY3VTFFOUtZRzJoN1JLMnNQOXBMM0N3VFFXajlMWW85RzFq?=
 =?iso-2022-jp?B?OHNkdVFVdDV0U0pMQ3UxZUV4Z2Q2TTJUTGh2RnBKcjJGalZHM0oxdnZD?=
 =?iso-2022-jp?B?V09acjhmL3M2ZlY0QktYSWthQmF0OEVjTXN1K2tQSm5WbXdFSUkyQkVv?=
 =?iso-2022-jp?B?RmFzM0N0elFkOHVkS1phcDBGZmc1VG9TcDEyMmZkcU82aFpqTzZqbGZ1?=
 =?iso-2022-jp?B?QVJkRzFYT1NNOTNpK1JIb2NVNytPc2NHK0VzOCsvRlNhbHZvREdUbGtm?=
 =?iso-2022-jp?B?Y3JpNFVyMHF1QmtDZnM2VEVFU2E5MHpjL1dwZkxvWlVReHJ5Rk9ieEU5?=
 =?iso-2022-jp?B?diszSkZFN0hzZGZOVWwxeVh3U3lzVUdJVDdtK0F0NUcybjBuc3NyNVB5?=
 =?iso-2022-jp?B?UURBdVVBRVNFZzIvUVlXNGdQanZaNk1Yejg1TGRvYkZnZEM4SU4vWFEr?=
 =?iso-2022-jp?B?Rm15SlpMeUZPcGd4M1RNWE1TWlFvTTNKdGNIZzZOUUZKbHNZVlppYml2?=
 =?iso-2022-jp?B?NThZUHBjak9hdUwxYXBQY0FpYTBDLzQ3MU1UK2J3bTJQbVJHeEpQbDJm?=
 =?iso-2022-jp?B?eENtdTFVeHBTakljNnpyN3dLS1NGUkFXWnJpREtzSjh4d1JKclMxU045?=
 =?iso-2022-jp?B?KzhBM0NRSy9NK0NQV1RVSUxwUUtpbEM3UGpPWEtuTi8wTC8rT3BTMVZE?=
 =?iso-2022-jp?B?UXBna2VZUERnTSt5WFFnODNGbFd4NkIxWkFoQS9QTFA0U29BdytaZCtM?=
 =?iso-2022-jp?B?NmxmaHp5VlMweGlSaituWU5XdndEZDZNeU1meTJ0bHhpQ0Z3MUJjRWtS?=
 =?iso-2022-jp?B?Nm1sclhVTT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb94565-3447-48e5-9d29-08da3a2b9fe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2022 06:40:26.6154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P2rXG9Piqibce/c28CTnDIAkzISDihj1sv9cMyshUOWnreuoIjya6v4xZ8iZilGwp9T/6Q1uCCqLyL0XmHkCnyRHA/Tp8YX3g/Vdq+R2Xfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3949
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> How will the driver be automatically loaded if this is the case or not?
> You can not rely on userspace knowing to load a driver on its own, please=
 tie into
> the proper device discovery.

I got it. I will consider how the driver loads properly.
