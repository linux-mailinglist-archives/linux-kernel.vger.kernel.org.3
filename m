Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141B5584CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 09:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbiG2HgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 03:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbiG2HgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:36:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A2326AD2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659080168; x=1690616168;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5dM2JmhNi/9EYWYf5QyLiy2WVObUH2+nWX5kp8nfhBQ=;
  b=W+AOjLquZKzEi/pILc2gdyCJqWGgCHczSrwcfDD8RK8bePanBcWd+g6K
   wDMws81nSWLYO3psybzd4L02HMOWuVOrkY3x/gvvguzx8Dr8e4UnciOM1
   1JtbO+k2XpKeTKMmpug7thK2q5tjVNArZx4XkOV7M6qxaeqo0l5zK8Mp/
   pPpXtEQcnEA+rJyisEmzR+bIpTbB5Kpxk1GvCq7yJX8W/wVknfcJM3myJ
   6UVJrNhbA2sTYbX82DUEZ+Eqjy5WL9MquTXHlPRKYu25EHcJ/hFhrxbTW
   7Bd4mx4iStZ2MV3Rik13U6vpX/STsKbpYA9jtf4Q3qBFntonbT26cPVmg
   w==;
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="106662204"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Jul 2022 00:36:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 29 Jul 2022 00:36:06 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Fri, 29 Jul 2022 00:36:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgsbjDk0GVeSXrCD/ZYiSB4xUu/aqI1mRX14x6CPefqXzxzwQYSgTXfn6VTdGzzMIUbn2aRePmyNCX+cYRUuB/F5Poud8rZwgcCl0m3/ejyEtW6mLhBezdeNczKX1RRRHu9EIURdNXscKlJmEf65YXYHoJd9e5JLNKX/dmdw91e+/ZznxrNHAl0Usug+r9cQ6uI7tauHMAxAlTSwnmbQeF5Ut5zDufJgQSwLmNx6M33CN6HVox+YQo7BgS+pY/HGIkAWNekmPZ3wuRrANJgEilJFfL0oX3szfyHPyGA/ObHv+EknFwlkApQ1g40iiAnQpdI/9iDaxv6L8m4iaPgeGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dM2JmhNi/9EYWYf5QyLiy2WVObUH2+nWX5kp8nfhBQ=;
 b=G0YSjKF+LyCs4fTlIAjUDiPF3A5UiQH8WNbIxi0dTZbwpVlzTuA3ZKjzsEfHy1biPjVuFEOVA90ZRGgR9gaJCH0Okgkecf9wPNNbm4xhq7bFvfMmonDScK2Bofm4AUXrbalr0hsP33Pmhjv5gB0wstN5450TAjqH+mCkWP4+a65L94bw1n9d1nplORBcvE3NLrJwyZpPSRre4HRgW1kIZ2Qoliy4ZFagpjFcyOdwxTuRIPvikefU0fDYbt8184yWJeeU/9ykEE7IxwgggEvvqj2Nrh9yNU1qboMqqN3lr2s/rJuap5Dm4mdtjYt0CKWB+G/bZocPeg2J28cccnwUwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dM2JmhNi/9EYWYf5QyLiy2WVObUH2+nWX5kp8nfhBQ=;
 b=GtwXhcVCYH6sdr4SyyotLuuN8gCu4OLzpb9Dnj+dBUZzbPQOb9MetxvRphAzr6ABft05W+YxpI0Ulj8YJvNCUC+zHj8XHZtgaZPL3ZWR8CWdn8n2v0zCga3QDFiu5bMxdOdOO1/se0x9moZKycf7NKVaRB86hiy56qNGVbgsXdA=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 BL3PR11MB6484.namprd11.prod.outlook.com (2603:10b6:208:3bf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Fri, 29 Jul
 2022 07:35:56 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::7549:c58c:5e93:7c35]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::7549:c58c:5e93:7c35%5]) with mapi id 15.20.5458.023; Fri, 29 Jul 2022
 07:35:55 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <sudip.mukherjee@sifive.com>
CC:     <p.yadav@ti.com>, <michael@walle.cc>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <greentime.hu@sifive.com>,
        <jude.onyenegecha@sifive.com>, <william.salmon@sifive.com>,
        <adnan.chowdhury@sifive.com>, <ben.dooks@sifive.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] mtd: spi-nor: add support for Quad Page Program to
 no_sfdp_flags
Thread-Topic: [PATCH 2/3] mtd: spi-nor: add support for Quad Page Program to
 no_sfdp_flags
Thread-Index: AQHYmsgjen1JGDoDVkiRJKdzpaguzQ==
Date:   Fri, 29 Jul 2022 07:35:55 +0000
Message-ID: <454aadfb-2c84-5950-3144-97d65e321575@microchip.com>
References: <20220712163823.428126-1-sudip.mukherjee@sifive.com>
 <20220712163823.428126-3-sudip.mukherjee@sifive.com>
 <3a9877d0-3cc5-6452-764b-d07b38c72b00@microchip.com>
 <CAHyZL-fK-d+dPWG63dcFUz17uP-sG4bnSFVW_gt16snnOVTzpQ@mail.gmail.com>
In-Reply-To: <CAHyZL-fK-d+dPWG63dcFUz17uP-sG4bnSFVW_gt16snnOVTzpQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae7b3edf-a9b2-43b8-37ba-08da7134f8e2
x-ms-traffictypediagnostic: BL3PR11MB6484:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /JoFWuQgNCnSClUuN6Tq500hZ+atIQa9w9ZNrV0ofFd7/1bfYvDBQNKscBrMV25QUU2sP+EjnoLBE3QLVVUa3dqk38QGYfx9y+QM7KGy4P9iTJhfXwE20QkoQs9/0g7FZLeYxZLaTC64lonLpuNw4SlWmZSNjJfGLZHvis4pWHDtZSDHjTNdBEWUnMy1EfL4+hJ0e5+9BpoY5Fqj7U2BH9b7oj+IUpsf3o6MwloMgJ92UdZKy8sEYoGOqpjYnU9qCyw8AYO4DdydkkFds23Gsw8NgA6e2ah0GMIu1mUlhWWDW9Z0QWYH4D1IqOOXZpOWzHWowEy73VxaA8jF35QIqWNHuAlpbpGGej1zwHzhfNLJ63vU6QjvjszspE1YHrGCjXc47yok8DG26WXUUNkfY9iRb3xlfvLwqgsGliF84q7/yCJg3KY0RXwhp5ayLYrn5SExCCZ83/T9clBOxhWVCwKvyqunOlFj5rtG8iW7oJsC6lEK4pV/1OSA1wO+hWUlwagxQU9xsXQnbpl1LrKmF9FRwuWkFFdYialqUjra9Mry7vFlDbQucyNlR6XPHQW4+CahA8mL0AhY/zq4n9sNhye4XLU6VSHz0am+yGK0PTb2QkX3qC8z7N4xJR0f2AzVmROmWDps0U07R9AfjLf2WoXbF/XA9jnuQicFeRo8T/FtvCD3bj7a7ifZyCzvkmhbCQ/Ho4mdqPvgdDh/cTwdrsWCB+3lmQE8NWewKz+rIcnF/QBrDpeKpV79wICWax/T1G9mBgWIUmyznxNVoZf0QELmByR5nak61h9rdSkKXpmBW1I4Tl2jBUgnKaIlWFQ1NvSB8zlLr+w4vAdDnAa08ROadvwNGNMxTLy4jXIiQs0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(396003)(39860400002)(366004)(346002)(36756003)(6512007)(6486002)(5660300002)(31686004)(26005)(7416002)(66946007)(966005)(478600001)(91956017)(41300700001)(2906002)(31696002)(8936002)(38100700002)(54906003)(316002)(66446008)(4326008)(71200400001)(6916009)(8676002)(64756008)(122000001)(86362001)(66556008)(53546011)(6506007)(38070700005)(76116006)(66476007)(2616005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHJqN1BmbFNSUkZHbldvbHBCTjhIRTFqNUV6VXlRQVZEcEM1WmRhckdIbFpY?=
 =?utf-8?B?bG5vVkxMUjk2bEJ6aEFZRGYraXM4L2pwM0xEM0tPanFOWFgyVlpEajZFcXdW?=
 =?utf-8?B?MC8wVVNTNHFseEhjWnh4V1M1L2VnWHZZemVlVkpITEZ0QlhYVjVCUDJQaVR0?=
 =?utf-8?B?UnEwVFM2VUVBc3o1UFZoWm91V0J3aUErNUtwVG9nWDc4V1h6amRqNzFVczJ2?=
 =?utf-8?B?QUptK1pWMld1WWNxRnJBVk53cS93RWNuRUFBblkzUnRkeHVaNk1UN05mQmFa?=
 =?utf-8?B?NS9zSWRNWjRJUEFwdWRGVUF3ZC9VcDVzMVVwUEM0dktZVUY0SUd3NTloZEpH?=
 =?utf-8?B?TlRDS3VJM0UyVmhIT0IzbnB3eHFVVksxYXlwRjl6R0p5U3AraC92anRNbHVz?=
 =?utf-8?B?QjJqZzBhSjVuYSsrQUZRT1VsOHFkYzg3RjJIZXNyR3ZJeTBVNldtS0Rkd1U4?=
 =?utf-8?B?L2F4UXlKeDMrTzVIeUQ2eUpYeXB3K2FndGFwNHEycUE2TjcxOWVXTFVyd2dj?=
 =?utf-8?B?L3VkaklMWGRhMXREazFteHFJdmVMaitMdHpQS2RXemlhSXRTbldQVVB3WU1h?=
 =?utf-8?B?UXVub3NGVENXYnN0aGhXU2U1bkxNbXNJUFJtazlQUlJrdE5NblkyTVBWR2xT?=
 =?utf-8?B?NGo4MW4xZC9uVEdzOUhkQ0k3aTZIU2srL0Q5Q09pRCtsYXlLMGp5ZFordm5R?=
 =?utf-8?B?RU56aXZHdllNRkdGSGdHOTJMVmVNUUVacnFpVWp2SUplV3B6Vkd3QWVHOFR5?=
 =?utf-8?B?MzB3N0NOQWEzL0E5UTdpd096OWJhVjYwOHdid3YvSVc5Qkl2NUFKTDhBTDB2?=
 =?utf-8?B?aFh1ZUdsSy9KbjhXTWV6MUIzRDJOa0xIMmNGOHF6V1hLVUUrQmU4b21BQmhm?=
 =?utf-8?B?S3RyVUg0eVpLV25SdWRXZjJXcmN1WnBSYzh0WDJrb0dGc2FmT0d3NHdFcko4?=
 =?utf-8?B?aXcxelRneG9yYWE4SktWNkNvWkY0b3JpZTRpak90cnkvKzRiSCtaajBZaDVn?=
 =?utf-8?B?ZjBQb2kzOFpiS1hPMDVNMm1MWVJScXhhclRIbCt3ZXQxdnhYOE9Fc2dtNDNC?=
 =?utf-8?B?MW9yRTdsc3BHQ3o0SENVLzJPd1NHZmFXM3htNTFKZHYrbWRIVXlMYnFCMGgy?=
 =?utf-8?B?L3lMcllRRW5hbnl1RjBGc3o0TXprTnlhZ3hFSmExR3V2S1NTVWFLb05EMjBB?=
 =?utf-8?B?ckZHN0pQY1htN2hsQmc4K3BQK2hpUXYvOVMxUERvZG8vMFdoMXphdXRCdExW?=
 =?utf-8?B?b1JKYzVETGk5S2JMOWtzQkZHTi8yZ3ZveTRTOU53WkQ0d2xlRkRVQkljeXdz?=
 =?utf-8?B?ai9yMnNuM0dHVHFaMXNVOEtDMXM4VUYzZnJmQWpWL2JJS3FQeEhOV0ZtQXds?=
 =?utf-8?B?ODN6QkVTa2E4Sm9ZWk5KTUVHNkdKOWp6dHBWckMvNFVuY0NmSGFiOUZhYkMx?=
 =?utf-8?B?WkxMZFVSZmM5OHcydkNNWW0wRzEyQ2RvNUxiUUhYRmVWVDJLYnZURVVuZXNK?=
 =?utf-8?B?clMzSDY3ZE1ockZtL1N6a1dFQm5iQS9wL2loWE8vWEVaK2w0RGZHLzJWb1l3?=
 =?utf-8?B?WjVmL28rbGpSYkt2ekhLTDBRZ2JvSHRKc2xlZ2p1UHRrSWtMbVRJTC8wc0xS?=
 =?utf-8?B?WENoY2NXcjBITkJ5UkdweGFid2FQSld5SlVZbDhhN0ZVZFd3RHZMd01jdytm?=
 =?utf-8?B?aXRRMVRxamRXUlRRVzNzSi92OUVFQ1lndG1EOEdBTHU4YkVpcnh2UHNURnIz?=
 =?utf-8?B?TkpWcFA2Q3poZXRNdG5rZU4ra2Vxc3VTN0ZQMHNTMnNORkhzTm1wUjQ1Sk9n?=
 =?utf-8?B?bEQ2VTRNdVl4KzByVnduK3NrUURDblpaRmdJR1ZUQ1NZdWUrUnRBNmoydUt1?=
 =?utf-8?B?Ni9CY29kSk5QbFhYTm5xeDFqUU1iQWYvUDl6YUJHMlFCNkdzMitRT0x1OUxF?=
 =?utf-8?B?RkhXd3Nmd0QzZ0U5K3hKRGUzcnR4OGV3aDZVamYydVRFa2VkV0VVdThNQ0pC?=
 =?utf-8?B?cnJ3eWliWlhRaC92bkY1ZHAxTXAxQ2xidUJWcTJLL3JCUHl4d1BjRGdJekZU?=
 =?utf-8?B?d2hScGhXbGZPQ3Z2bWM1NGlyY3RJSko1QVFnS1dra2FrUFo1Yk9pVjdZSFZ3?=
 =?utf-8?B?WEZ2aDVIUmFiRjB4b1ZHWUI4cTRPWnYrMUNhK1lVeWFFU0huT3VPL292b2V5?=
 =?utf-8?B?ZHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <566B7A777CDF814190551FC4950EB81C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7b3edf-a9b2-43b8-37ba-08da7134f8e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2022 07:35:55.3690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jwyWW55oQDB5LQoFvVDtA9mS+Nhk0OdlZu5+F7afLGsKzOUVNthzAHh9fnQBoaFZ7khCg7TjZQPNPAeC/6rZdncG8QCgMU+1If215J1cm6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6484
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8xOC8yMiAyMTo0OSwgU3VkaXAgTXVraGVyamVlIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIE1vbiwgSnVsIDE4LCAyMDIyIGF0IDY6MDIg
UE0gPFR1ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbT4gd3JvdGU6DQo+Pg0KPj4gT24gNy8xMi8y
MiAxOTozOCwgU3VkaXAgTXVraGVyamVlIHdyb3RlOg0KPj4+IFtZb3UgZG9uJ3Qgb2Z0ZW4gZ2V0
IGVtYWlsIGZyb20gc3VkaXAubXVraGVyamVlQHNpZml2ZS5jb20uIExlYXJuIHdoeSB0aGlzIGlz
IGltcG9ydGFudCBhdCBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRp
b24gXQ0KPj4+DQo+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+Pj4NCj4+
PiBTb21lIGZsYXNoIGNoaXBzIHdoaWNoIGRvZXMgbm90IGhhdmUgYSBTRkRQIHRhYmxlIGNhbiBz
dXBwb3J0IFF1YWQNCj4+PiBJbnB1dCBQYWdlIFByb2dyYW0uIEVuYWJsZSBpdCBpbiBod2NhcHMg
aWYgZGVmaW5lZC4NCj4+Pg0KPiANCj4gPHNuaXA+DQo+IA0KPj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL210ZC9zcGktbm9yL2NvcmUuaCBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oDQo+Pj4g
aW5kZXggNThmYmVkYzk0MDgwZi4uZGRlNjM2YmRiMWE3YyAxMDA2NDQNCj4+PiAtLS0gYS9kcml2
ZXJzL210ZC9zcGktbm9yL2NvcmUuaA0KPj4+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29y
ZS5oDQo+Pj4gQEAgLTQ2Miw2ICs0NjIsNyBAQCBzdHJ1Y3Qgc3BpX25vcl9maXh1cHMgew0KPj4+
ICAgKiAgIFNQSV9OT1JfT0NUQUxfUkVBRDogICAgICBmbGFzaCBzdXBwb3J0cyBPY3RhbCBSZWFk
Lg0KPj4+ICAgKiAgIFNQSV9OT1JfT0NUQUxfRFRSX1JFQUQ6ICBmbGFzaCBzdXBwb3J0cyBvY3Rh
bCBEVFIgUmVhZC4NCj4+PiAgICogICBTUElfTk9SX09DVEFMX0RUUl9QUDogICAgZmxhc2ggc3Vw
cG9ydHMgT2N0YWwgRFRSIFBhZ2UgUHJvZ3JhbS4NCj4+PiArICogICBTUElfTk9SX1FVQURfUFA6
ICAgICAgICAgZmxhc2ggc3VwcG9ydHMgUXVhZCBJbnB1dCBQYWdlIFByb2dyYW0uDQo+Pg0KPj4g
WW91IGRvbid0IG5lZWQgdGhpcyBmbGFnIGlmIHlvdXIgZmxhc2ggc3VwcG9ydHMgdGhlIDQtYnl0
ZSBBZGRyZXNzDQo+PiBJbnN0cnVjdGlvbiBUYWJsZS4gRG9lcyB5b3UgZmxhc2ggc3VwcG9ydCBp
dD8gQ2FuIHlvdSBkdW1wIGFsbCB0aGUNCj4+IFNGRFAgdGFibGVzLCBwbGVhc2U/DQo+IA0KPiBO
b3Qgc3VyZSB3aGF0IHRoZSBjb3JyZWN0IHdheSB0byBkdW1wIHNmZHAgaXMuIEkgZGlkIHRoaXMg
ZnJvbSBzeXNmcy4NCj4gDQo+ICMgY2F0IHNmZHAgfCB4eGQNCj4gMDAwMDAwMDA6IDUzNDYgNDQ1
MCAwNjAxIDAxZmYgMDAwNiAwMTEwIDMwMDAgMDBmZiAgU0ZEUC4uLi4uLi4uMC4uLg0KDQpXZSBy
ZWFsbHkgbmVlZCBhIGRlY29kZXIgZm9yIHRoaXMgOkQuDQo1MzQ2IDQ0NTAgLSBzZmRwIHNpZ25h
dHVyZQ0KMDYwMSAwMWZmIC0gMm5kIGR3b3JkLCAyIHBhcmFtZXRlciB0YWJsZXMNCjAwMDYgMDEx
MCAtIEJGUFQgb2YgMTYgZHdvcmRzDQozMDAwIDAwZmYgLSBwYXJhbWV0ZXIgaGVhZGVyLCAybmQg
ZHdvcmQNCg0KDQo+IDAwMDAwMDEwOiA5ZDA1IDAxMDMgODAwMCAwMDAyIGZmZmYgZmZmZiBmZmZm
IGZmZmYgIC4uLi4uLi4uLi4uLi4uLi4NCg0KOWQwNSAwMTAzIElEIExTQiA9IDB4OWQsIHRhYmxl
IHdpdGggMyBkd29yZHMNCjgwMDAgMDAwMiBJRCBNU0IgPSAweDAyIC0+IGxvb2tzIGxpa2UgYSBm
dW5jdGlvbiBzcGVjaWZpYyB2ZW5kb3IgdGFibGUNCg0KU28gdGhlIGZsYXNoIGRvZXMgbm90IHN1
cHBvcnQgdGhlIDQtYnl0ZSBBZGRyZXNzIEluc3RydWN0aW9uIHRhYmxlLCB3ZQ0KY2FuJ3QgcmV0
cmlldmUgdGhlIFF1YWQgUFAgZnJvbSBTRkRQLg0KDQo+IDAwMDAwMDIwOiBmZmZmIGZmZmYgZmZm
ZiBmZmZmIGZmZmYgZmZmZiBmZmZmIGZmZmYgIC4uLi4uLi4uLi4uLi4uLi4NCj4gMDAwMDAwMzA6
IGU1MjAgZjlmZiBmZmZmIGZmMGYgNDRlYiAwODZiIDA4M2IgODBiYiAgLiAuLi4uLi5ELi5rLjsu
Lg0KPiAwMDAwMDA0MDogZmVmZiBmZmZmIGZmZmYgMDBmZiBmZmZmIDQ0ZWIgMGMyMCAwZjUyICAu
Li4uLi4uLi4uRC4uIC5SDQo+IDAwMDAwMDUwOiAxMGQ4IDAwZmYgMjM0YSBjOTAwIDgyZDggMTFj
ZSBjY2NkIDY4NDYgIC4uLi4jSi4uLi4uLi4uaEYNCj4gMDAwMDAwNjA6IDdhNzUgN2E3NSBmN2Fl
IGQ1NWMgNGE0MiAyY2ZmIGYwMzAgZmFhOSAgenV6dS4uLlxKQiwuLjAuLg0KPiAwMDAwMDA3MDog
ZmZmZiBmZmZmIGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZmZiBmZmZmICAuLi4uLi4uLi4uLi4uLi4u
DQo+IDAwMDAwMDgwOiA1MDE5IDUwMTYgOWZmOSBjMDY0IDhmZWYgZmZmZiAgICAgICAgICAgIFAu
UC4uLi5kLi4uLg0KPiANCj4gDQo+IC0tDQo+IFJlZ2FyZHMNCj4gU3VkaXANCg0KDQotLSANCkNo
ZWVycywNCnRhDQo=
