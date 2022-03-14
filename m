Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB03E4D9042
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 00:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343667AbiCNXUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 19:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242316AbiCNXUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 19:20:11 -0400
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F57CB2E;
        Mon, 14 Mar 2022 16:18:59 -0700 (PDT)
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BA87440912;
        Mon, 14 Mar 2022 23:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1647299939; bh=EyUOEEkBIDKbFWAryPZG4rBkVdKNf8P9oPe70RqtpJ8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=PxQLVtjACED536AemH87ihUVVMWL9vcCJUuTsNUbuKK+55BCuGYX30r7nJ2ZQ43Oe
         2vu5+80dk9y+eo2bNNM0Qtju1SnWd7fJlFgxR5WpR/eLf89mS+lgXFTBNzsDDzEqi1
         cl6BNJ7NA6S5gbwqao5WdgLakiI2Hk4IRdYNuVyiPSsldZ8QPLcdQuOSmFbWtrQ3Cy
         d0pT3Q/1TniY+FTinTurzQT3ngvds1NTmfq3zK+pntcS3HuAo3M51NakbYX6/lvRhU
         goM1IZYizjQtCIs7THjHxOuVrFJy2m6H1IMRIy5hv+NkemD2cXPKmN3qxfBZKc3yWc
         wQZNqYOv5iY+g==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id CE422A0060;
        Mon, 14 Mar 2022 23:18:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 346EC800B3;
        Mon, 14 Mar 2022 23:18:56 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="uzRTvFH8";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kc9cio01MjwNwxyHBDrC8FAh9UwDOZtBWbTPkVttACUji0b3TcGyl2K8AYQo7DMJJEUoRbcEu6Sg66BrJ2qq1pmavmV4k5kDokhUDYf9Xk5e47khtkA68BZvWrcVYH57NZ20cZdpdpIgzQCU96lw0G4ai1j+sVrfsUyqzKWZPcoIXadz8TrA84AyNzwo9XhR4RdehGKeXXLP8I739gDqlD/ulLPAy1+k7TzBH04HaoAzPcfwsYcGzhC4UP/74+wGBJEsyocyg2xdCzrqsy8yPTiXDy/zQ/a3nTihWA2lZCJTg39fKg5J1T5ZS4fw5p+cXpTw7Mj7wwCrx8Fh6mRWxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyUOEEkBIDKbFWAryPZG4rBkVdKNf8P9oPe70RqtpJ8=;
 b=UKxbIiWLb1gOGVBlRmDEL8dTSHtg97V0GdQdxZ/6WvjrHQdO8AjACvADwogyWZ/IZuJEFYXLKcqIgmE23AYK9RB8CYVgGsdXH3fUbJt5ZFxfBkvEP4WixpLRmravADCHLhxNXUJ0TZfYPS2U3jmXPu1MWEqNMsICYbRYnOZ0GnmR1ij63uN+rAqPZrYQIwL78r+3jnXoLYABxkETZCpam9madXD1Z4TTsFFsixT6/UphJZ08z4+shoitj9IKCvAMXDGvO/boBiBw65PwwMtX5lWXzdzLnmO2Tfe2/6RicVf6nkvpK4aTrPlFPcRpEorNV9bh/GI8KAVHpSQnvCJ+Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyUOEEkBIDKbFWAryPZG4rBkVdKNf8P9oPe70RqtpJ8=;
 b=uzRTvFH8jwhAV+A5oZmm7IT0XHO74TuwZceHpsCLQFyqzufJWFoBto8aodyPXs7g2d5wMvPhZ+o8M3JHw+KjrSkrls2nv55HRXmHiuFf29GpomOaq7EIVguE19/G+qfFu9gR3SqYWaXWQ8i4xzfIvY0Y4uozdSlVlkh+wEKx2ws=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BL1PR12MB5363.namprd12.prod.outlook.com (2603:10b6:208:317::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Mon, 14 Mar
 2022 23:18:53 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::141:3edf:164a:857b]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::141:3edf:164a:857b%4]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 23:18:53 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     =?utf-8?B?7KCV7J6s7ZuI?= <jh0801.jung@samsung.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        'Felipe Balbi' <balbi@kernel.org>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
CC:     "'open list:USB XHCI DRIVER'" <linux-usb@vger.kernel.org>,
        'open list' <linux-kernel@vger.kernel.org>,
        'Seungchull Suh' <sc.suh@samsung.com>,
        'Daehwan Jung' <dh10.jung@samsung.com>,
        "cpgs@samsung.com" <cpgs@samsung.com>,
        "cpgsproxy5@samsung.com" <cpgsproxy5@samsung.com>
Subject: Re: [PATCH] usb: dwc3: Add dwc3 lock for blocking interrupt storming
Thread-Topic: [PATCH] usb: dwc3: Add dwc3 lock for blocking interrupt storming
Thread-Index: AQHYMePmBfflf4nAkkGdLNAaNOlrkay35TEAgAGF7ICAAAeXgIAADPuAgAAS/oCAAAEkAIAAEpWAgAXpjgA=
Date:   Mon, 14 Mar 2022 23:18:52 +0000
Message-ID: <775482f2-6532-13db-fd2f-7d8a2eb14155@synopsys.com>
References: <CGME20220307052605epcas2p2b84f6db2642863ed61373070f508e200@epcas2p2.samsung.com>
 <1646630679-121585-1-git-send-email-jh0801.jung@samsung.com>
 <99eabe6c-8782-1bc6-e1d7-09b019cee65b@synopsys.com>
 <016a01d834e7$72b11fd0$58135f70$@samsung.com>
 <559b00b6-8b3d-9422-6a25-674f719ad237@synopsys.com>
 <017f01d834f1$bc3a9c30$34afd490$@samsung.com>
 <0ae388d8-0809-f09a-55a8-b682c9dc42c5@synopsys.com>
 <a1b9752f-96e6-7abb-d6d3-ce4742742a0c@synopsys.com>
 <01cc01d83505$177fcdf0$467f69d0$@samsung.com>
In-Reply-To: <01cc01d83505$177fcdf0$467f69d0$@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a0e810c-0782-4193-ab02-08da061101b0
x-ms-traffictypediagnostic: BL1PR12MB5363:EE_
x-microsoft-antispam-prvs: <BL1PR12MB536307D4F491B37725825D75AA0F9@BL1PR12MB5363.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uuTLPa7CQblVudliPBjhAy2dNi1we2hhLFSTtka1Q4En8G+UV6gYY86vi2Qx1XU/dXzwzl+WBVnhjZnTdYU2KwQYaziJqCOxllz8hJpKUMD9rv38xEoFI6G8dairmn58PCHVswM1pWujnIeYKkApesMwBcT0N4Klicfg5AAjg0FZsUjvV3od8C4Z68riWlmPOxGIvl3fYMbuEAf+snDbqQdEcx7wcL65uB57nfKsAGhbrHdqIZoS2943SU6n2KjrU5/1jrGFTUCGL+FSz38Bh4SOvJkVi+3XOkVqnWtEbxHysFYfYNVdo02uvUvLnKJFOOUwOat5ndNwKYwHUW7igpz8lqIQuwd9ZPg/B2bVJqIL6km17kHQgoNWMrHkpsZGr+aGln8GGxxYLXaK7HxVZTMnZgAfdND9zYwB+1r6eyw3P6eErRDPU5OvqlSo1hEQBC3QTB+Ky3OfQq/XdbzxXAGgpdFobsmc/1VkglKVYa1KPSEaU15Xb+b9NlbF0HSAlriKhH9V8kIt9nPHWdnrkLn8Q2OZSTFvQQgEhnMyVUuKxltO1/hYjPsSFmMB7cS25odIT/n6PAy0vY4OJySyR3QQWpQHHAWy7d217Ry1n4Rf914CNZXJ6g+ImhzeC8uawaRspMlKn6COHqweABznvzbdoaa8svZEF3twbDfzN2bXCcRg1uiAVL+iF21sh7WgEf8q1rx28RqMTX9aGhpyzmJ2oNCU1XR+vyQ0qeQfMbXyQFt6ky5zsIVPuVycthD6tcIhVp2J0o44ZwBugTbg2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(5660300002)(31696002)(6512007)(31686004)(2906002)(83380400001)(122000001)(36756003)(71200400001)(66446008)(38070700005)(26005)(66476007)(76116006)(8936002)(4326008)(64756008)(186003)(8676002)(38100700002)(53546011)(66946007)(66556008)(6506007)(316002)(86362001)(110136005)(54906003)(6486002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWZ0VmNwVUhXa2d0OElpdGFkVWdRN1k5Ykp0RUozR29uQkxiTTNVdThBMWZX?=
 =?utf-8?B?SlpvU0lpTWtmYkpoUEIrbTZzRWN3UnpIVjBVWTZGM0lTdTlPUkY4cms2S3VT?=
 =?utf-8?B?akFQbjRGVWNxbEx4cVVEdEJzd1cwK0ZBNWFlL2F2Qld4aTFUYVhNMFVrdU1F?=
 =?utf-8?B?cnE3MCtJM1VST3F5bUJ1OUpQazJFV1NJeVE4cmpDaDN2TVMwUForT0tUNHZ4?=
 =?utf-8?B?YzBxWUpFUWVrTFRjcU9FL3BrWDh3YUlrblFNSldIQjBVQmF3NUFNcytjMWRz?=
 =?utf-8?B?WUtTUklYUkZPOUtnRlFxSHpXNUpURmRCZGdYMXVPZEIvZ1hrdFlqRkE0R0w5?=
 =?utf-8?B?TWx5eVBBODgxa05FTEJZMGZpS2p0ZGZVM1EwaUxuVUxDQXlDc1NCT2ZTTURz?=
 =?utf-8?B?c0k4clora0JXOG1pT2kzcXY2NDhTd0FDeVc4bFVRNkNVWjV2RHZEakJlR3cr?=
 =?utf-8?B?N2tlbGdkWWc3Y2syMU0wbkdZNnlCQU8wTy9wRGF6N25wdkNBdXhYZWN0bVNM?=
 =?utf-8?B?cGJSc1lMcFh4dEF4eExqemMvbjFCUnduSjh0QjdadUhXZ2lGcllxTTJBUlR3?=
 =?utf-8?B?ZjVKZmU4NmFFQzYvL1pwTWo0TG9YZ0NPWlBwdjQ4dklPQTVFRlVYRVNyVStt?=
 =?utf-8?B?em9jMkRxM3BGZitaZUlUN3MydjM4SktOLzg3OGUxWXAzUDJmbkE2ZWZsSVZY?=
 =?utf-8?B?Z0JrREE0VFdaRFlRSGlENi9kQjZseDRtMXFHOHdnbW8xY2diT3FUQ094c1hY?=
 =?utf-8?B?U1BtUU5vM0p1K2h0VENPbkhGT0hiMmtUeUY3ekpiaVpObk5YejhlWkNqblhy?=
 =?utf-8?B?ckJ2aUwrZjU5WVNFMFpLQzVVUWZjM0NSTGZ0aHRBbzNQSmFyeS94ako0WXVM?=
 =?utf-8?B?UTZXYzlpSVV1cU4rTGo2aUNZdnVFZDliVm5QWThydERzQzl5YS9kS3lSQUVa?=
 =?utf-8?B?c0Jud1ljWkxoSW9WaURuc2VSd1JWT1ArblZ1YXliU1QrcmdPN2pyUi9WenR2?=
 =?utf-8?B?M3oyRFdKdjJzS2hZeVhOdmZzVEd5aFoyS3hNN1BPOTZWV1d5YjhVL0JuZmZO?=
 =?utf-8?B?N0l0VHZYWlBtMnVuZHdQNTVvZWlmeHJFZ2VVNzBMV2hRamdidG1yWlBUdk1o?=
 =?utf-8?B?R1M2T3Q4aTk0VTFKemk5Q2ZqNllLUzYvbnRaK21yNUMySnJFN0E3RVQyclRK?=
 =?utf-8?B?cHkrQzZuR1JiMGpwR2FLdzVrUGJkRzNzQlAzY2llTEVJRy8yMnZocDk4WEFB?=
 =?utf-8?B?MXJ1UGx3dUF4ZnBFT25iWGhyRTdwZUJYZE54bjdxcWVQa3VWTW5DdThRQWt1?=
 =?utf-8?B?ditIUEJXMjdVMUVoVGF4cDZ1TFlkeTVGOEx5Q0ZqZEJFSjFNTjBCR3lzUnJG?=
 =?utf-8?B?L2diUE9pb2RWRGl5ZWl1UmdERFhISXcydTBnaXZVc2NtSUhQQmhtN09CSzJR?=
 =?utf-8?B?azBQMEViaTlBZ1ZYY2xlMGVFMkhBbUxucUlCT1F6emtRODY4bjVHZjdaSTl5?=
 =?utf-8?B?TW5STFVHalpDQzBtYVhnL2ZCekQvamxHM0FCRFUrVXMzYk5ZUVh2VG1YdVdi?=
 =?utf-8?B?bVVCd3NaQzRZaTV4UWhTcndhRS8zeEh2eUhSV3NCUXA4aVdubG1QZ0l4cHNa?=
 =?utf-8?B?aHIzclJmYjg5aWl0ZHRUbnMzT2dkaTl1c2E1bFJ3WXFnT0RvREQybSs3dTVO?=
 =?utf-8?B?KzdJNEVXWGRMdWtEdGlEeWw3dk01dm9DNTFGbkNTQmdFeGhxZ21tVC9uQlZw?=
 =?utf-8?B?aUhiNXB0ZWZBZDBIK1liUlhVKzNueTZWU1lJSmZqSk9zM01SdmVyVUJ6RHFk?=
 =?utf-8?B?YzMzc2dDMU4vMXVxcE5ZK242clJrMGpvUGN0NGt3SFdwZUlST0NqMEpQNWNr?=
 =?utf-8?B?WkRiYVQ3MXM0REs1L0VxZWtVb0ZWM214QWhxcGtMMy9MdHJDaXg0R093bDY2?=
 =?utf-8?Q?QyE0xnTCrGqJDcNfsOtquIawG36LTKl9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0E73AAEAADA46489610A967F67B623F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0e810c-0782-4193-ab02-08da061101b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 23:18:52.8444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2YppfPFVcXx/g9nxAgGrcYGQNbai8KZOKnSzi7L2cKAxGhz2Mujx+dOKpYjOlZ3CreBeWGiH4rjc+jsd9tWNIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5363
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

7KCV7J6s7ZuIIHdyb3RlOg0KPiANCj4gDQo+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
Pj4gRnJvbTogVGhpbmggTmd1eWVuIFttYWlsdG86VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbV0N
Cj4+IFNlbnQ6IEZyaWRheSwgTWFyY2ggMTEsIDIwMjIgMTI6NTUgUE0NCj4+IFRvOiDsoJXsnqzt
m4g7ICdGZWxpcGUgQmFsYmknOyAnR3JlZyBLcm9haC1IYXJ0bWFuJw0KPj4gQ2M6ICdvcGVuIGxp
c3Q6VVNCIFhIQ0kgRFJJVkVSJzsgJ29wZW4gbGlzdCc7ICdTZXVuZ2NodWxsIFN1aCc7ICdEYWVo
d2FuDQo+PiBKdW5nJzsgY3Bnc0BzYW1zdW5nLmNvbTsgY3Bnc3Byb3h5NUBzYW1zdW5nLmNvbQ0K
Pj4gU3ViamVjdDogUmU6IFtQQVRDSF0gdXNiOiBkd2MzOiBBZGQgZHdjMyBsb2NrIGZvciBibG9j
a2luZyBpbnRlcnJ1cHQNCj4+IHN0b3JtaW5nDQo+Pg0KPj4gVGhpbmggTmd1eWVuIHdyb3RlOg0K
Pj4+IOygleyerO2biCB3cm90ZToNCj4+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
Pj4+PiBGcm9tOiBUaGluaCBOZ3V5ZW4gW21haWx0bzpUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29t
XQ0KPj4+Pj4gU2VudDogRnJpZGF5LCBNYXJjaCAxMSwgMjAyMiAxMDo1NyBBTQ0KPj4+Pj4gVG86
IOygleyerO2biDsgVGhpbmggTmd1eWVuOyAnRmVsaXBlIEJhbGJpJzsgJ0dyZWcgS3JvYWgtSGFy
dG1hbicNCj4+Pj4+IENjOiAnb3BlbiBsaXN0OlVTQiBYSENJIERSSVZFUic7ICdvcGVuIGxpc3Qn
OyAnU2V1bmdjaHVsbCBTdWgnOw0KPj4+Pj4gJ0RhZWh3YW4gSnVuZyc7IGNwZ3NAc2Ftc3VuZy5j
b207IGNwZ3Nwcm94eTVAc2Ftc3VuZy5jb20NCj4+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHVz
YjogZHdjMzogQWRkIGR3YzMgbG9jayBmb3IgYmxvY2tpbmcgaW50ZXJydXB0DQo+Pj4+PiBzdG9y
bWluZw0KPj4+Pj4NCj4+Pj4+IOygleyerO2biCB3cm90ZToNCj4+Pj4+PiBIaS4NCj4+Pj4+Pg0K
Pj4+Pj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+Pj4+PiBGcm9tOiBUaGluaCBO
Z3V5ZW4gW21haWx0bzpUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tXQ0KPj4+Pj4+PiBTZW50OiBU
aHVyc2RheSwgTWFyY2ggMTAsIDIwMjIgMTE6MTQgQU0NCj4+Pj4+Pj4gVG86IEphZUh1biBKdW5n
OyBGZWxpcGUgQmFsYmk7IEdyZWcgS3JvYWgtSGFydG1hbg0KPj4+Pj4+PiBDYzogb3BlbiBsaXN0
OlVTQiBYSENJIERSSVZFUjsgb3BlbiBsaXN0OyBTZXVuZ2NodWxsIFN1aDsgRGFlaHdhbg0KPj4+
Pj4+PiBKdW5nDQo+Pj4+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHVzYjogZHdjMzogQWRkIGR3
YzMgbG9jayBmb3IgYmxvY2tpbmcNCj4+Pj4+Pj4gaW50ZXJydXB0IHN0b3JtaW5nDQo+Pj4+Pj4+
DQo+Pj4+Pj4+IEhpLA0KPj4+Pj4+Pg0KPj4+Pj4+PiBKYWVIdW4gSnVuZyB3cm90ZToNCj4+Pj4+
Pj4+IEludGVycnVwdCBTdG9ybWluZyBvY2N1cnJlZCB3aXRoIGEgdmVyeSBsb3cgcHJvYmFiaWxp
dHkgb2YNCj4+IG9jY3VycmVuY2UuDQo+Pj4+Pj4+PiBUaGUgb2NjdXJyZW5jZSBvZiB0aGUgcHJv
YmxlbSBpcyBlc3RpbWF0ZWQgdG8gYmUgY2F1c2VkIGJ5IGEgcmFjZQ0KPj4+Pj4+Pj4gY29uZGl0
aW9uIGJldHdlZW4gdGhlIHRvcCBoYWxmIGFuZCBib3R0b20gaGFsZiBvZiB0aGUgaW50ZXJydXB0
DQo+Pj4+Pj4+PiBzZXJ2aWNlDQo+Pj4+Pj4+IHJvdXRpbmUuDQo+Pj4+Pj4+PiBJdCB3YXMgY29u
ZmlybWVkIHRoYXQgdmFyaWFibGVzIGhhdmUgdmFsdWVzIHRoYXQgY2Fubm90IGJlIGhlbGQNCj4+
Pj4+Pj4+IHdoZW4gSVNSIG9jY3VycyB0aHJvdWdoIG5vcm1hbCBIIC8gVyBpcnEuDQo+Pj4+Pj4+
PiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQ0KPj4+Pj4+Pj4gPT09ID0gKHN0cnVjdCBkd2MzX2V2ZW50X2J1ZmZlciAqKSBl
dl9idWYgPSAweEZGRkZGRjg4REU2QTAzODAgKA0KPj4+Pj4+Pj4gCSh2b2lkICopIGJ1ZiA9IDB4
RkZGRkZGQzAxNTk0RTAwMCwNCj4+Pj4+Pj4+IAkodm9pZCAqKSBjYWNoZSA9IDB4RkZGRkZGODhE
REMxNDA4MCwNCj4+Pj4+Pj4+IAkodW5zaWduZWQgaW50KSBsZW5ndGggPSA0MDk2LA0KPj4+Pj4+
Pj4gCSh1bnNpZ25lZCBpbnQpIGxwb3MgPSAwLA0KPj4+Pj4+Pj4gCSh1bnNpZ25lZCBpbnQpIGNv
dW50ID0gMCwgPDwNCj4+Pj4+Pj4+IAkodW5zaWduZWQgaW50KSBmbGFncyA9IDEsIDw8DQo+Pj4+
Pj4+PiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PQ0KPj4+Pj4+Pj4gPT09ID0gImV2dC0+Y291bnQ9MCIgYW5kICJldnQtPmZs
YWdzPURXQzNfRVZFTlRfUEVORElORyIgY2Fubm90DQo+Pj4+Pj4+PiBiZSBzZXQgYXQgdGhlIHNh
bWUgdGltZS4NCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBXZSBlc3RpbWF0ZSB0aGF0IGEgcmFjZSBjb25k
aXRpb24gb2NjdXJyZWQgYmV0d2Vlbg0KPj4+Pj4+Pj4gZHdjM19pbnRlcnJ1cHQoKSBhbmQgZHdj
M19wcm9jZXNzX2V2ZW50X2J1ZigpIGNhbGxlZCBieQ0KPj4+Pj4+Pj4gZHdjM19nYWRnZXRfcHJv
Y2Vzc19wZW5kaW5nX2V2ZW50cygpLg0KPj4+Pj4+Pj4gU28gSSB0cnkgdG8gYmxvY2sgdGhlIHJh
Y2UgY29uZGl0aW9uIHRocm91Z2ggc3Bpbl9sb2NrLg0KPj4+Pj4+Pg0KPj4+Pj4+PiBUaGlzIGxv
b2tzIGxpa2UgaXQgbmVlZHMgYSBtZW1vcnkgYmFycmllci4gV291bGQgdGhpcyB3b3JrIGZvciB5
b3U/DQo+Pj4+Pj4gTWF5YmUgaXQgY291bGQgYmUuIEJ1dCAiZXZ0LT5jb3VudCA9IDA7IiBpcyB1
cGRhdGVkIG9uDQo+Pj4+PiBkd2MzX3Byb2Nlc3NfZXZlbnRfYnVmKCkuDQo+Pj4+Pj4gU28sIEkg
dGhpbmsgc3Bpbl9sb2NrIGlzIG1vcmUgY2xlYXIgcm91dGluZSBmb3IgdGhpcyBpc3N1ZS4NCj4+
Pj4+Pg0KPj4+Pj4NCj4+Pj4+IE5vdCByZWFsbHkuIElmIHByb2JsZW0gaXMgZHVlIHRvIHRoZSBl
dnQtPmZsYWdzIG5vdCB1cGRhdGVkIGluIHRpbWUsDQo+Pj4+PiB0aGVuIHRoZSBzb2x1dGlvbiBz
aG91bGQgYmUgdXNpbmcgdGhlIG1lbW9yeSBiYXJyaWVyLiBUaGUgc3Bpbl9sb2NrDQo+Pj4+PiB3
b3VsZCBvYmZ1c2NhdGUgdGhlIGlzc3VlLiBBbmQgd2Ugc2hvdWxkIGF2b2lkIHVzaW5nIHNwaW5f
bG9jayBpbiB0aGUNCj4+IHRvcC1oYWxmLg0KPj4+Pg0KPj4+PiBUaGlzIGlzc3VlIHdhcyBvY2N1
cnJlZCBieSB3YXRjaGRvZy4gVGhlIGludGVycnVwdCBvY2N1cnJlZCBpbiB1bml0cyBvZg0KPj4g
NCB0byA1dXMgYW5kIGNhbm5vdCBiZSByZWxlYXNlZCB1bnRpbCB0aGUgYm90dG9tIGlzIGV4ZWN1
dGVkLg0KPj4+PiBJZiBpdCBpcyBhIHByb2JsZW0gd2l0aCB0aGUgbWVtb3J5IGJhcnJpZXIsIHRo
ZSB2YWx1ZSBzaG91bGQgYmUgdXBkYXRlZA0KPj4gYWZ0ZXIgYSBmZXcgY2xvY2tzIGFuZCB0aGUg
VE9QIHNob3VsZCBydW4gbm9ybWFsbHkuIElzbid0IGl0Pw0KPj4+DQo+Pj4gQ2FuIHlvdSBndWFy
YW50ZWUgdGhhdCBhIHZhbHVlIGlzIHN0b3JlZCBhZnRlciBYIGFtb3VudCBvZiB0aW1lLCBldmVy
eQ0KPj4gdGltZT8NCj4gWWVzLCBJIHRoaW5rIGl0J3MgZ3VhcmFudGVlZC4gVGhlIHN5c3RlbSB3
YXMgd29ya2luZyB3aXRoIG90aGVyIGNvcmVzIGZvciAyMCBzZWNvbmRzLg0KPiANCj4+Pg0KPj4+
PiBBbmQgQ291bGQgeW91IGV4cGxhaW4gbWUgd2h5IHdlIHNob3VsZCBhdm9pZCB1c2luZyBzcGlu
X2xvY2sgaW4gdGhlDQo+PiB0b3AtaGFsZi4NCj4+Pj4NCj4+Pg0KPj4+IFRoZSB0b3AtaGFsZiBh
bmQgYm90dG9tLWhhbGYgYXJlIHNlcmlhbGl6ZWQuIFdoaWxlIHRoZSBib3R0b20taGFsZg0KPj4+
IGhhbmRsZXIgaXMgcnVubmluZywgdGhlIGludGVycnVwdCBzaG91bGQgYmUgbWFza2VkLiBJZiB0
aGUgdG9wLWhhbGYNCj4+PiBnb3QgY2FsbGVkIGluIHRoZSBtaWRkbGUgb2YgdGhlIGJvdHRvbS1o
YWxmIGhhbmRsZXIsIHNvbWV0aGluZyBlbHNlIGlzDQo+Pj4gd3JvbmcuIFRoZXJlIHNob3VsZCBu
b3QgYmUgYSByYWNlIHRoYXQgcmVxdWlyZXMgYSBzcGluX2xvY2sgZm9yIHRoaXMNCj4+PiBwYXJ0
aWN1bGFyIGNyaXRpY2FsIHNlY3Rpb24uDQo+IA0KPj4+DQo+Pj4gVGhlIHByb2JsZW0geW91J3Jl
IHNlZWluZyBpcyBwb2ludGluZyB0b3dhcmQgYSBtZW1vcnkgYmFycmllciBpc3N1ZS4NCj4+Pg0K
Pj4+IEFsc28geW91IG5vdGVkIHRoYXQgdGhlcmUncyBhbiAiaW50ZXJydXB0IHN0b3JtIiwgd2hp
Y2ggZG9lc24ndA0KPj4+IGluZGljYXRlIHRvIG1lIHRoYXQgaXQncyBkdWUgdG8gUENJZSBsZWdh
Y3kgaW50ZXJydXB0IGRlLWFzc2VydGlvbg0KPj4+IGRlbGF5IHJlc3BvbnNlIGVpdGhlci4NCj4+
Pg0KPj4+IENhbiB5b3UgdGVzdCBpdCBvdXQgYW5kIHdlIGNhbiB0YWtlIGEgbG9vayBmdXJ0aGVy
Pw0KPj4+DQo+PiBXZSB3YW50IHRvIGF2b2lkIHNwaW5fbG9jayBiZWNhdXNlIHRoZSB0b3AtaGFs
ZiBzaG91bGRuJ3Qgc3RhbGwgZm9yIHRvbw0KPj4gbG9uZywgYWZmZWN0aW5nIHBlcmZvcm1hbmNl
LiBUaGlzIGNhbiBoYXBwZW4gaWYgc29tZSBhc3luYyBjYWxsIGZyb20gdGhlDQo+PiB1cHBlcmxh
eWVyIGRyaXZlcidzIGhvbGRpbmcgdGhlIGxvY2suDQo+IEkgYWxzbyBkbyBub3QgdGhpbmsgdGhh
dCB0aGUgc2VyaWFsaXphdGlvbiBvZiB0aGUgdG9wIGFuZCBib3R0b20gb2YgdGhlIElTUiBoYXMg
YmVlbiBicm9rZW4uDQo+IA0KPiBJIHRoaW5rIHRoYXQgZHdjM19pbnRlcnJ1cHQoKSBjYWxsZWQg
YnkgZHdjM19nYWRnZXRfcHJvY2Vzc19wZW5kaW5nX2V2ZW50cygpIGluZmx1ZW5jZWQgdGhlIHNl
cmlhbGl6YXRpb24gd2l0aCB0aGUgYm90dG9tLiBBdCB0aGUgdGltZSBvZiB0aGUgcHJvYmxlbSwg
MjAgc2Vjb25kcyBhZ28sIGR3YzNfcnVudGltZV9yZXN1bWUoKS0+ZHdjM19nYWRnZXRfcHJvY2Vz
c19wZW5kaW5nX2V2ZW50cygpIHdhcyBjYWxsZWQsIGFuZCB0aGUgcHJvYmxlbSBiZWdhbiBhdCB0
aGF0IHRpbWUuDQoNCk9rLiBUaGlzIGRvZXNuJ3Qgc291bmQgcmlnaHQuDQoNCk9uIHN1c3BlbmQs
IHdlIGNhbiBqdXN0IG1hc2sgdGhlIGludGVycnVwdCwgYW5kIHVubWFzayBhZnRlciByZXN1bWUu
DQpUaGVyZSdzIG5vIG5lZWQgdG8gZXZlbiB0cmFjayBkd2MtPnBlbmRpbmdfZXZlbnRzIGZsYWcg
ZWl0aGVyLiBXaGlsZSB0aGUNCmV2ZW50IGNvdW50IGZyb20gR0VWTlRDT1VOVCBpcyBub24temVy
bywgdGhlIGNvbnRyb2xsZXIgd2lsbCBnZW5lcmF0ZQ0KaW50ZXJydXB0cyBpZiB1bm1hc2tlZC4N
Cg0KZHdjMyBpcyBjdXJyZW50bHkgbm90IGhhbmRsaW5nIGhpYmVybmF0aW9uLCBhbmQgd2UncmUg
bm90IHJlc3RvcmluZw0KYW55dGhpbmcgb24gcmVzdW1lLg0KDQo+IA0KPiBJIHRoaW5rIHNvIHRo
YXQgaXQgY2FuIG1ha2UgZGVhZGxvY2sgd2hlbiB1c2luZyBzcGluX2xvY2sgaW4gdG9wLCB0b28u
DQo+IFRoYW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjay4gSSdsbCBjb25zaWRlciBhbm90aGVyIHdh
eS4NCj4gDQoNClRoYW5rcywNClRoaW5oDQo=
