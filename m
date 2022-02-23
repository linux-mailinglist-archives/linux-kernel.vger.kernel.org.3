Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD834C07A8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 03:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236746AbiBWCMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 21:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbiBWCMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 21:12:01 -0500
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779A855AB;
        Tue, 22 Feb 2022 18:11:33 -0800 (PST)
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E452C42684;
        Wed, 23 Feb 2022 02:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1645582293; bh=K3D5u4tx/9INWGLdhb3rIqzbAQ8mAxpFnOxqhsAzi48=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=C+1fCEpwnbew0xhtmUbEUGySHxiALwwN6UYAdntLW7elgE+JKku0LDFAb+K0mAmJ1
         TXrTGTJJL3Wr9hXe7ipWeoQo0tcgx+BN8m+1bl/hk3+/n7pfAq83vLmn7IY67g9jwq
         prkMW7kvgn/OktT8VP+u+WNNOwq4XGVM8yFHo0XFD/JbBaVDUUKv2R4xwRZ0LwtP1R
         yb7sGB9J18QA24Bu3vCIymvIR1wj8iUs/rfW8BsdCu6e2dn06jzY408eP2MQYaR+EF
         YtOikSH5KEL6Zh9RQ/Jc1a/3pso5w6H6JemcXibduBRAZNMUUR+fvj0ILEVD+lphrI
         rs8dIbIyENfBA==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 0438FA005F;
        Wed, 23 Feb 2022 02:11:31 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2049.outbound.protection.outlook.com [104.47.74.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 89CA2801EE;
        Wed, 23 Feb 2022 02:11:30 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="KP4tLOMi";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/YcyzT0+YYXlD8P99dfhxuEo/ojgyZ0mU7KBMazpkanf/6FYIQ0eW7R7CA95n7THfuxuBgb60FcSL0UjNmrRv49l9z+F9z47UMRMTgA3a/fZSaiBWG+CitaAYxzvER8aDB4GA6jGCEEmgBwm/Vd2mn4lNZ+nUjegaFYC6GrFc3EmXBo0pNHnZ7jiwLqnnlGfjp/G7AVDIhxeCNEmEGUunkox3DLH/mn7ZioUf/2TQeNc0yfNDuO3VAv5EhDFyofkC6byDhtMu6QjoeGu6C/foDZmZvD3kbilznFR8hNKi/cjqyDx1/w+RD99Ti8uZgoAShCz7bnmwOfpoTbzB6T5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3D5u4tx/9INWGLdhb3rIqzbAQ8mAxpFnOxqhsAzi48=;
 b=G4t7xXv5oJDoO7gQwV58QI5rgANmTABJD1mtDV4fxvNdrFJQoOijB45bkc1yuNKj4ZNhCqd1RueL/GAzFp3cL1BXkG163RzdfIwbxiF78EsEwyB3qZ1ZQc2eP/AliKq+jnNkwpy4rdzz7T89CHrm/z9pLJWCR3UI1cshRxK7VUTvb11qIm8yrQ7lWbil0SFbBoFMca9LcbANWkpp0fY+EWWOgQ8rHOU291eJx8+snCJvtCZeTvAte+StOpWVIzFDi5AknE7ioualWzrvIgV/68U04Z58P7SCwOE/QPeZXG0GrxvydzeUttteYnfesGPvZhuMZMmvZ+t+Y48qy6E7dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3D5u4tx/9INWGLdhb3rIqzbAQ8mAxpFnOxqhsAzi48=;
 b=KP4tLOMiGlHsBftjOUnZRik3LBzKIj+Xv0VxH21PHzqILXkv2bzCM1adjDykvXQO65tMHhbi7137OVLRWpUXsgYQHGnrIJYNZZvXqCOZTmAN10MzcZrsJMaWuZDZImP33J72oYrzqpFP75ZQkpVtQVDCqt+GZtl2vpeIaKltymY=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB3573.namprd12.prod.outlook.com (2603:10b6:a03:df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Wed, 23 Feb
 2022 02:11:26 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e%3]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 02:11:26 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Jung Daehwan <dh10.jung@samsung.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v2 1/2] usb: dwc3: Not set DWC3_EP_END_TRANSFER_PENDING in
 ep cmd fails
Thread-Topic: [PATCH v2 1/2] usb: dwc3: Not set DWC3_EP_END_TRANSFER_PENDING
 in ep cmd fails
Thread-Index: AQHYIZOvXlHACGixbUGMAnHCl5PyK6yTYqcAgADHvYCAALGHgIAD5WwAgAew04A=
Date:   Wed, 23 Feb 2022 02:11:26 +0000
Message-ID: <3b51ffb6-f959-d3a7-5bdc-1f208cd96198@synopsys.com>
References: <1644836933-141376-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220214111149epcas2p1a1faeda037991885fd6f2f026fa44ec5@epcas2p1.samsung.com>
 <1644836933-141376-2-git-send-email-dh10.jung@samsung.com>
 <ff604504-00df-0c1b-673e-892e42737f7a@synopsys.com>
 <20220215063925.GC144890@ubuntu>
 <63c8c9d1-9b07-a9f2-3639-a38641e19a7a@synopsys.com>
 <20220218044444.GA48532@ubuntu>
In-Reply-To: <20220218044444.GA48532@ubuntu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2da2370f-8ed0-491d-6788-08d9f671cc16
x-ms-traffictypediagnostic: BYAPR12MB3573:EE_
x-microsoft-antispam-prvs: <BYAPR12MB35736088750E54D17AE1FED4AA3C9@BYAPR12MB3573.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J1pBNY6aU0Y5M3pEV1rZbZv5+l22TxEQn6XKrcsb335waxEfTGKLROBaK132Ul+ipIZsry5hcelUvGChr9qUws0BI2GAEsFuXzYkFaEjdQ8lZXdxMnyR1DdZb+tw4WUJcrXE7AnNZa91q6ZaN1IIbc91Q/eUXZsA0fcTaBhNCR9n2QeK3fkoYajExUld0BfUvI7Bv9SVNNka570ELF/LBx8stOpGnIGbgPRR5JuBTUYuFNYVNS9Z9cWaUmFPIlwHY6VIJNL03BxFsfJI1jWtvJfj7z2Dfw8dFttELOno2UEFU4ACeyC9lpYmRRaSETJ8AxFu89LxiBtVIR0RNTOYBaOlSyHFg2os/xr8Sn/Vj300Z6UXBEQD95QT+UEIprc/mLoUyyPk6wDeosUONzTTOw5U5jnKgei6I0p60csnA2FsY/4ZuMovK9ENmkyTyVUqpB8Ce7/6rGMQQtvvxxwhv5HafG8XruGlfj+j5fSHgdOSOJIy9x6DW8U4vPH05qb2sV4/UL+xPs8z5R1U7Y+kmJktq+VikmDrIou/5HJfCOCzFnsAUWE5A4TkW1TC0FIrEPWZsLYDMUipxp0+FDsFWFpmsq+K5qbEYWEjn8A+0AGopN1p84DpsoVqnuERERUMtErFGF2TK/gXUmFiOLMpXpm56A/mjh+YV790yjicZiGcbOKHyHGZdiXYtAgbLcdzLJye0Tmpz7moZc5DMIOoQneregnyuMgbQCYFoiDNpcYd+/p/XXEaliHooVRVmAeI+gmy7CrH9WylZbjE2zB1VJAw8Rb4uTIk87cxxeatytyAOFQbzNcPbyKWI4358txgH/ZMaIs4H47Nwg5ITWLkOwwvXhZ/gScnQ3dFZ334AkfSiS1C//d3BpThHS4swz7xJyTHQR2q6bRvjZW9iq7w/lI0CX5orCDHN17RvuRrLsk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(2906002)(316002)(83380400001)(508600001)(110136005)(31696002)(5660300002)(86362001)(26005)(76116006)(122000001)(186003)(2616005)(38070700005)(8676002)(71200400001)(64756008)(8936002)(66946007)(31686004)(38100700002)(4326008)(36756003)(6512007)(6506007)(966005)(66556008)(66476007)(66446008)(6486002)(45980500001)(43740500002)(414714003)(473944003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RG5LN0dhYm9VKzVKZHpsUXBjVVE1T0JJK0tkVHpzRFd3NWdFaVdOeElEZ21y?=
 =?utf-8?B?dWV5RHJqN2tVbGJYQ09Yc0xaOWxNRXVvUGM5cHNwYWRqbVRkbWJGRVh5TkpC?=
 =?utf-8?B?VmcwaldRaFhlTVJzR1pPczlmMkJFQVNJQ0FtYUx4ajlQbVRmcnZ3eGd3Yytx?=
 =?utf-8?B?NE4vU0R4M2xNV29kOFJSSFNUNUdMYm9Xb3dVV2N4Z0tSeGU0NmpKclJjWEdY?=
 =?utf-8?B?QUpiaXFhWXNjT2xFbzFqbnBIU2FSSGQxWEFUOENEQmlnNDJPMXNtODEyQzlq?=
 =?utf-8?B?MnY3TTNRYTBzc3hxaFJ2K29FOG5Ybmd5aHlMSGtpZjFFa3U1OWRUeVp6VWpN?=
 =?utf-8?B?dVBNK0F3cDk3YndaY0RLdzBWQW1naWpCYzhqN00zK0cvekVPN1VtZzJtVXIx?=
 =?utf-8?B?ZEZ5ZHljM2Fja3o2ejhPNVl4bENFY2V3YmdlZDdYc2M5WVVQU1Q3SWNESVg0?=
 =?utf-8?B?aWlwTVY3RUNvNU5OeGxxNlk5Q3pOOFBRU0pXZk9ZSzdDWlVNVXAraVRNOW45?=
 =?utf-8?B?Ylg1WGMzK3poT281Tk02Z1pPYlc4VlRvVFRwYXZHUEZ4V1JmanJaTy9tMitX?=
 =?utf-8?B?QkZtQ21SK1I4RnZUeUROQUQ3Y1RFQnVpVmxxSjZBODZyV2EvUDdNUk5RNllK?=
 =?utf-8?B?d2lkamxDeGNtckxPZ3FtNUM1dDFTYTV5a0pZVDhBeGs0UDhpTU1SMHZEODhS?=
 =?utf-8?B?R1hXTW8xbEFiTHpuRWpkaVB0Wk5WRlFCcVJLOXNadlRta0FpRG5LcTA1WWhP?=
 =?utf-8?B?NktaYnM3cSs5TGhpR1k2TEFnUlFWVWkvUWltbVpOODFXQW1PUlBnc3pMWDRH?=
 =?utf-8?B?SmVoMUY2OStldXJsYzBUOVRBdk9oYTlrZzNKTVY2OXVNd1dxQ0RxMVk5S3B4?=
 =?utf-8?B?NXVydE4zK29NdDlCMytTUWZBNldEY3U0Ti9ZRG0zeEVCdDlvWFhpcU4wUEdE?=
 =?utf-8?B?dFBpTmpCbWtFVWxXSmdvNmdvMUJZZjlRM3p4QlNoRnpZMUt1QWQ4bFB3L2cw?=
 =?utf-8?B?eXNMUnNLZWdsNmhGQ3djSXFucGF0ZHBJMmtZU0ZmNDRuczhyWXBMSWFaZG03?=
 =?utf-8?B?NS9UenpEVkZaRWJyY1hSVHBvQTJIbU05WjViVnN6YXBsdVBnUis2Qng4cENk?=
 =?utf-8?B?MDFrWnlpTW1QVUJaa1c2RVdZbVh2YmNVMHZGWVhwblVpaXJkRmhHYkVQQ0VR?=
 =?utf-8?B?TU15b2FqQTZBeitYQzZQWGNPcE9PUW5SMXhNSGRqb1podUtTRzE4bGZsQ3Yy?=
 =?utf-8?B?elFrQXJ5cWE2UXBBSXRXaUJqWG9wa1dXRW5ZMkZBTHZzWUM0SzR6azFIOFpX?=
 =?utf-8?B?NURjcWl6QmI1NkR2QVJMNlJha1VMY3dpU2kxV094ZVcxbHdtS0FMNGhySGx1?=
 =?utf-8?B?bENLOFpQY2IrT1ZWc1U3cVRpV3cyZDVJYW83V0ZhUStCd1VrTTRJYlUrT0ZX?=
 =?utf-8?B?RzdHNmlpTjNCSG5lLzYxSE83SzV0OGVRRTVLYXJBUk52ZlprbU1CZUtUQVRk?=
 =?utf-8?B?OW8yNVlCeG9uWER1U3VVcXJrekFXcCtQaWJKWm44aEZTdjZSM3Q5Tld5V0U5?=
 =?utf-8?B?QmZkNVFyRWRReWE5RzlrT1J6R0JqZlp3KzZyMXpURzIxaWxMZ29XamJsWFc0?=
 =?utf-8?B?eHZWY0ozN3N2VXRzM1hCZTh0a2pPNnB3L2ttenJacFJtK0NDMURzZ1pSSUth?=
 =?utf-8?B?NEk2ZXZ3bEZra2RCQzRlWTNPVFdudFNwc2JFcWpzL2ZEcDYvYmJHZ1FXTWVz?=
 =?utf-8?B?S2FkNnR5ZVdWc24wMkU4VWhiVzRYNGI1bVA2THU4NmNTdGFaeUR4QVVzYW5m?=
 =?utf-8?B?WThxaDZvQWVJSDRSU295VVpLV2hEejFlRVEvRU9VTUFEMU5QaE43c05TSlFP?=
 =?utf-8?B?TlpoT2oyZDBmOWdQb0FhdHB5NGd0bjRGYlN3allPMGVIMW5tM1p5SlQ0aUxR?=
 =?utf-8?B?SnU5bUgzMVpscDNLSThYajFkdUhnN0VIbS8zY21JZVNmamkyZitqN2I3UEFu?=
 =?utf-8?B?TGhjcEpEMnM1K1hndXhLVWhOS2xwSmY1enFDdFA1NUdPZllGU2tSN1QwdkNi?=
 =?utf-8?B?NWZUTDlnOFQ5Q1QvK1ExdWUwNHg3L3gzcXZUamZEN2lPNWg0b1JSZ01JL1Nn?=
 =?utf-8?B?S3VjYTBUTzJVYm1KZFo4M3VEd2pJUksxS1ZUVVRtZTBsYmVPVVp2Q0N0T09M?=
 =?utf-8?Q?zQDdlN4gr51xJi2zxaukv+Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <64D76DFC5BB05D4991294D985A1A0E19@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da2370f-8ed0-491d-6788-08d9f671cc16
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 02:11:26.1018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Pj4mccXMFNx24ZFL54kqId3WwR5qbGBLs1pcVFnauo39rT2onMqnXqhfkLUMrvHalGV/YchLEJqoNMaDfr3dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3573
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSnVuZywNCg0KSnVuZyBEYWVod2FuIHdyb3RlOg0KPiBPbiBUdWUsIEZlYiAxNSwgMjAyMiBh
dCAwNToxNDo1MFBNICswMDAwLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+PiBKdW5nIERhZWh3YW4g
d3JvdGU6DQo+Pj4gSGkgVGhpbmgsDQo+Pj4NCj4+PiBPbiBNb24sIEZlYiAxNCwgMjAyMiBhdCAw
Njo0NDozM1BNICswMDAwLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+Pj4+IEhpLA0KPj4+Pg0KPj4+
PiBEYWVod2FuIEp1bmcgd3JvdGU6DQo+Pj4+PiBJdCBhbHdheXMgc2V0cyBEV0MzX0VQX0VORF9U
UkFOU0ZFUl9QRU5ESU5HIGluIGR3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXINCj4+Pj4+IGV2ZW4g
aWYgZHdjM19zZW5kX2dhZGdldF9lcF9jbWQgZmFpbHMuIEl0IGNhbiBjYXVzZSBzb21lIHByb2Js
ZW1zIGxpa2UNCj4+Pj4NCj4+Pj4gSG93IGRvZXMgaXQgZmFpbD8gVGltZWQgb3V0Pw0KPj4+DQo+
Pj4gWWVzLCB0aW1lZCBvdXQuDQo+Pj4+DQo+Pj4+PiBza2lwcGluZyBjbGVhciBzdGFsbCBjb21t
bWFuZCBvciBnaXZlYmFjayBmcm9tIGRlcXVldWUuIFdlIGZpeCB0byBzZXQgaXQNCj4+Pj4+IG9u
bHkgd2hlbiBlcCBjbWQgc3VjY2Vzcy4gQWRkaXRpb25hbGx5LCBXZSBjbGVhciBEV0MzX0VQX1RS
QU5TRkVSX1NUQVJURUQNCj4+Pj4+IGZvciBuZXh0IHRyYiB0byBzdGFydCB0cmFuc2ZlciBub3Qg
dXBkYXRlIHRyYW5zZmVyLg0KPj4+Pg0KPj4+PiBXZSBzaG91bGRuJ3QgZG8gdGhpcy4gVGhpbmdz
IHdpbGwgYmUgb3V0IG9mIHN5bmMuIEl0IG1heSB3b3JrIGZvciAxDQo+Pj4+IHNjZW5hcmlvLCBi
dXQgaXQgd29uJ3Qgd29yayBmb3Igb3RoZXJzLg0KPj4+Pg0KPj4+PiBQbGVhc2UgaGVscCBtZSB1
bmRlcnN0YW5kIGEgZmV3IHRoaW5nczoNCj4+Pj4NCj4+Pj4gMSkgV2hhdCBpcyB0aGUgc2NlbmFy
aW8gdGhhdCB0cmlnZ2VycyB0aGlzPyBJcyBpdCByYW5kb20/DQo+Pj4+DQo+Pj4gZXAgY21kIHRp
bWVvdXQgb2NjdXJzIG9uIGRlcXVldWUgcmVxdWVzdCBmcm9tIHVzZXIgc2lkZS4gRW5kIFRyYW5z
ZmVyIGNvbW1hbmQNCj4+PiB3b3VsZCBiZSBzZW50IGluIGR3YzNfc3RvcF9hY3RpdmUgdHJhbnNm
ZXIuDQo+Pg0KPj4gQXQgdGhlIGhpZ2ggbGV2ZWwsIHdoYXQncyB0cmlnZ2VyaW5nIHRoZSByZXF1
ZXN0IGRlcXVldWU/IElzIGl0IGZyb20gYQ0KPj4gZGlzY29ubmVjdCwgY2hhbmdlIG9mIGludGVy
ZmFjZSwgb3Igc2ltcGx5IGZ1bmN0aW9uIGRyaXZlciBwcm90b2NvbCB0aGF0DQo+PiBjaGFuZ2Vz
IGl0Lg0KPj4NCj4+IFdoYXQgYXBwbGljYXRpb24gd2FzIHVzZWQgdG8gdHJpZ2dlciB0aGlzPw0K
Pj4NCj4gUmVtb3ZpbmcgZnVuY3Rpb24gZHJpdmVyIHJlcXVlc3RzIGRlcXVldWUuDQoNClJlbW92
aW5nIGZ1bmN0aW9uIGRyaXZlcj8gRGlkIGl0IGdvIHRocm91Z2ggZnVuY3Rpb24gdW5iaW5kPw0K
DQo+Pj4NCj4+Pj4gMikgQXJlIHRoZXJlIG90aGVyIHRyYWZmaWNzIHBlbmRpbmcgd2hpbGUgaXNz
dWluZyB0aGUgRW5kIFRyYW5zZmVyDQo+Pj4+IGNvbW1hbmQ/IElmIHNvLCB3aGF0IHRyYW5zZmVy
IHR5cGUocyk/DQo+Pj4+DQo+Pj4gSSBoYXZlbid0IGNoZWNrZWQgaXQgeWV0LiANCj4+DQo+PiBD
YW4geW91IGNoZWNrPw0KPj4NCj4gSXQgc2VlbXMgdGhlcmUncyBubyBwZW5kaW5nIHRyYWZmaWMu
DQoNCklmIHRoaXMgaXMgdGhlIGNhc2UsIHRoZW4gaXQncyBkaWZmZXJlbnQgdGhhbiB0aGUgc2Nl
bmFyaW8gV2VzbGV5J3MNCmRlc2NyaWJlZC4NCg0KPj4+DQo+Pj4+IDMpIEhhdmUgeW91IHRyaWVk
IGluY3JlYXNpbmcgdGhlIHRpbWVvdXQ/DQo+Pj4+DQo+Pj4gTm8sIEkgaGF2ZW4ndC4NCj4+DQo+
PiBDYW4geW91IHRyeSB1cCB0byAxMCBzZWNvbmRzIChqdXN0IGZvciBleHBlcmltZW50KQ0KPj4N
Cj4gWWVzLCBpdCdzIHJlcHJvZHVjZWQgb24gMTAgc2Vjcy4NCj4+Pj4gQlIsDQo+Pj4+IFRoaW5o
DQo+Pj4+DQo+Pj4NCj4+PiBUaGlzIGlzc3VlIG9jY3VycyB2ZXJ5IHJhcmVseSBvbiBjdXN0b21l
ci4gSSBvbmx5IGhhdmUgcmVzdHJpY3RlZA0KPj4+IGluZm9ybWF0aW9uLiBUaGF0J3Mgd2h5IEkn
dmUgYmVlbiB0cnlpbmcgdG8gcmVwcm9kdWNlIGl0Lg0KPj4NCj4+IEhvdyBkaWQgeW91IHRlc3Qg
eW91ciBmaXggaWYgeW91IGNhbid0IHJlcHJvZHVjZSBpdD8NCj4+DQo+IA0KPiBJIHNlbnQgcGF0
Y2hlcyB0byBteSBjbGllbnQgYW5kIGhlIHNhaWQgdGhpcyBpc3N1ZSB3b3VsZCBub3Qgb2NjdXIg
YWZ0ZXINCj4gYXBwbHlpbmcgdGhlbS4gSW4gZmFjdCwgVGhleSBhcmUgbm90IHRvdGFsbHkgZXF1
YWwgd2l0aCB0aG9zZSB3ZSBhcmUNCj4gZGlzY3Vzc2luZy4gSSd2ZSByZWZhY3Rvci1lZCBhbmQg
cHVzaGVkIHRoZW0gaGVyZS4NCj4gDQo+Pj4NCj4+PiBXZXNsZXkgbWF5IGhhdmUgcnVuIGludG8g
c2FtZSBpc3N1ZSBhbmQgeW91IGNhbiBzZWUgdGhpcyBpc3N1ZSBpbiBkZXRhaWwuDQo+Pj4gaHR0
cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vcHJvdGVjdDIuZmlyZWV5ZS5jb20vdjEv
dXJsP2s9MzliZDNlNTAtNjYyNjA3MjUtMzliY2I1MWYtMGNjNDdhMzFjZTRlLWJmMDAwZDVhNjk3
ZWFkNjYmcT0xJmU9YjA0NTAwYWQtNDNkMC00ZWU3LWI1ZjAtYTcyODNkOGZjMGRhJnU9aHR0cHMq
M0EqMkYqMkZ1cmxkZWZlbnNlLmNvbSoyRnYzKjJGX19odHRwcyozQSoyRioyRnByb3RlY3QyLmZp
cmVleWUuY29tKjJGdjEqMkZ1cmwqM0ZrKjNEOWQ0MjNiNjktZmMzZmQzMmUtOWQ0M2IwMjYtNzRm
ZTQ4NWZmZjMwLTc3YTA5OWI1MjY1OTQxMGQqMjZxKjNEMSoyNmUqM0QyMGI0ZDlmNS0yNTk5LTRm
NTctOGI2YS03YzRlYzE2N2QyMjgqMjZ1KjNEaHR0cHMqMkEzQSoyQTJGKjJBMkZsb3JlLmtlcm5l
bC5vcmcqMkEyRmxpbnV4LXVzYioyQTJGMjAyMjAyMDMwODAwMTcuMjczMzktMS1xdWljX3djaGVu
ZyoyQTQwcXVpY2luYy5jb20qMkEyRl9fKjNCSlNVbEpTVWxKUSoyMSoyMUE0RjJSOUdfcGcqMjFK
V1B6TkxvTzNCRlhfSVpDVnptSFB0eHE2ZnJyX1ZGYlNOTmF4U1F5bHVudDFZNEVhdVRPZWZ0aDJM
Q0ljVkV1VHg4RSoyNF9fO0pTVWxKU1VsSlNVbEpTVWxKU1VsSlNVbEpTVWxKU1VsSlNVbEpTVWwh
IUE0RjJSOUdfcGchTFdtUTZDTEtiNWlJZnh5MzN1dlBESjhIRGhjWG92ZXlsMGJjQnhqX3R6WkpO
MWdlbTdKV0ZBY0Rfcjh2NnJpQllrSDEkICANCj4+Pg0KPj4NCj4+IEkgY2FuIHRha2UgYSBsb29r
LCBidXQgcGxlYXNlIHByb3ZpZGUgdGhlIHRyYWNlcG9pbnRzIG9mIHRoZSBmYWlsdXJlIGlmDQo+
PiB5b3UgY2FuIHJlcHJvZHVjZSBpdC4NCj4+DQo+IA0KPiBUaGFua3MgdG8gY2xpZW50J3MgaGVs
cCwgSSBjb3VsZCByZXByb2R1Y2UgaXQgaW4gbXkgZW52cmlvbm1lbnQuDQo+IA0KPiAxLiBUcmFj
ZQ0KPiANCj4gTXRwU2VydmVyLTI0ODQgICAgWzAwM10gZC4uMiAgIDExNC4zNzY4Mjk6IGR3YzNf
ZXBfcXVldWU6IGVwMW91dDogcmVxIDAwMDAwMDAwNTU1NjE4NjcgbGVuZ3RoIDAvNTEyIHpzSSA9
PT4gLTExNQ0KPiBNdHBTZXJ2ZXItMjQ4NCAgICBbMDAzXSBkLi4yICAgMTE0LjM3NjgzODogZHdj
M19wcmVwYXJlX3RyYjogZXAxb3V0OiB0cmIgMDAwMDAwMDA3NDA3OGE5NSAoRTIzOkQyMikgYnVm
IDAwMDAwMDA5NTQ4NDU2MDAgc2l6ZSA1MTIgY3RybCAwMDAwMDAxZCAoSGxDUzpzYzpub3JtYWwp
DQo+IE10cFNlcnZlci0yNDg0ICAgIFswMDNdIGQuLjIgICAxMTQuMzc2ODQ0OiBkd2MzX3ByZXBh
cmVfdHJiOiBlcDFvdXQ6IHRyYiAwMDAwMDAwMDk1ZjUwM2U3IChFMjQ6RDIyKSBidWYgMDAwMDAw
MDBlMTMwMzAwMCBzaXplIDUxMiBjdHJsIDAwMDAwODE5IChIbGNTOnNDOm5vcm1hbCkNCj4gTXRw
U2VydmVyLTI0ODQgICAgWzAwM10gZC4uMiAgIDExNC4zNzY4Njc6IGR3YzNfZ2FkZ2V0X2VwX2Nt
ZDogZXAxb3V0OiBjbWQgJ1VwZGF0ZSBUcmFuc2ZlcicgWzIwMDA3XSBwYXJhbXMgMDAwMDAwMDAg
MDAwMDAwMDAgMDAwMDAwMDAgLS0+IHN0YXR1czogU3VjY2Vzc2Z1bA0KDQpJcyB0aGVyZSBhbnkg
YWN0aXZpdHkgaGVyZT8gU2VlbXMgbGlrZSB0aGVyZSdzIDcwKyBzZWNvbmRzIG9mIGluYWN0aXZp
dHk/DQoNCj4ga3NvZnRpcnFkLzItMjMgICAgICBbMDAyXSBkLnMyICAgMTkwLjQyODc1MjogZHdj
M19lcF9kZXF1ZXVlOiBlcDJvdXQ6IHJlcSAwMDAwMDAwMDczMmMwZjY5IGxlbmd0aCAwLzE2Mzg0
IHpzSSA9PT4gLTExNQ0KPiBrc29mdGlycWQvMi0yMyAgICAgIFswMDJdIGRuczMgICAxOTAuNDQ3
NjI1OiBkd2MzX2dhZGdldF9lcF9jbWQ6IGVwMm91dDogY21kICdFbmQgVHJhbnNmZXInIFs0MGQw
OF0gcGFyYW1zIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIC0tPiBzdGF0dXM6IFRpbWVkIE91
dA0KPiBrc29mdGlycWQvMi0yMyAgICAgIFswMDJdIGRuczIgICAxOTAuNDUwNTk2OiBkd2MzX2Vw
X2RlcXVldWU6IGVwMm91dDogcmVxIDAwMDAwMDAwYmUzNDM0ZDQgbGVuZ3RoIDAvMTYzODQgenNJ
ID09PiAtMTE1DQo+IGtzb2Z0aXJxZC8yLTIzICAgICAgWzAwMl0gZG5zMiAgIDE5MC40NTA2MTg6
IGR3YzNfZXBfZGVxdWV1ZTogZXAyb3V0OiByZXEgMDAwMDAwMDAzMzY1NWYyZSBsZW5ndGggMC8x
NjM4NCB6c0kgPT0+IC0xMTUNCj4ga3NvZnRpcnFkLzItMjMgICAgICBbMDAyXSBkbnMyICAgMTkw
LjQ1MDYyNTogZHdjM19lcF9kZXF1ZXVlOiBlcDJvdXQ6IHJlcSAwMDAwMDAwMGRjMGZmNjM1IGxl
bmd0aCAwLzE2Mzg0IHpzSSA9PT4gLTExNQ0KPiBrc29mdGlycWQvMi0yMyAgICAgIFswMDJdIGRu
czIgICAxOTAuNDUwNjMzOiBkd2MzX2VwX2RlcXVldWU6IGVwMm91dDogcmVxIDAwMDAwMDAwMjNm
ZmI4ZTggbGVuZ3RoIDAvMTYzODQgenNJID09PiAtMTE1DQo+IGtzb2Z0aXJxZC8yLTIzICAgICAg
WzAwMl0gZG5zMiAgIDE5MC40NTA2NDE6IGR3YzNfZXBfZGVxdWV1ZTogZXAyb3V0OiByZXEgMDAw
MDAwMDA1ZmFiNjFhYSBsZW5ndGggMC8xNjM4NCB6c0kgPT0+IC0xMTUNCj4ga3NvZnRpcnFkLzIt
MjMgICAgICBbMDAyXSBkbnMyICAgMTkwLjQ1MDY0ODogZHdjM19lcF9kZXF1ZXVlOiBlcDJvdXQ6
IHJlcSAwMDAwMDAwMDFmNjE4Y2Q4IGxlbmd0aCAwLzE2Mzg0IHpzSSA9PT4gLTExNQ0KPiBrc29m
dGlycWQvMi0yMyAgICAgIFswMDJdIGRuczIgICAxOTAuNDUwNjU0OiBkd2MzX2VwX2RlcXVldWU6
IGVwMm91dDogcmVxIDAwMDAwMDAwZGEwZWExYjEgbGVuZ3RoIDAvMTYzODQgenNJID09PiAtMTE1
DQo+ICMjIyMjIENQVSA2IGJ1ZmZlciBzdGFydGVkICMjIyMNCg0KU29tZSB0cmFjZXMgd2VyZSBs
b3N0Pw0KDQo+IEh3QmluZGVyOjYzNl8xLTY1OCAgICAgWzAwNl0gZC4uMSAgIDE5MC43MzUzMjQ6
IGR3YzNfZ2FkZ2V0X2VwX2Rpc2FibGU6IGVwMG91dDogbXBzIDUxMi81MTIgc3RyZWFtcyAwIGJ1
cnN0IDEgcmluZyAwLzAgZmxhZ3MgZTpzd2JwOj4NCj4gSHdCaW5kZXI6NjM2XzEtNjU4ICAgICBb
MDA2XSBkLi4xICAgMTkwLjczNTMyNzogZHdjM19nYWRnZXRfZXBfZGlzYWJsZTogZXAwaW46IG1w
cyA1MTIvNTEyIHN0cmVhbXMgMCBidXJzdCAxIHJpbmcgMC8wIGZsYWdzIGU6c3dicDo8DQo+IEh3
QmluZGVyOjYzNl8xLTY1OCAgICAgWzAwM10gZG4uMSAgIDIxNC4yMDY2NTI6IGR3YzNfZ2FkZ2V0
X2VwX2Rpc2FibGU6IGVwMG91dDogbXBzIDUxMi81MTIgc3RyZWFtcyAwIGJ1cnN0IDEgcmluZyAw
LzAgZmxhZ3MgZTpzd2JwOj4NCj4gSHdCaW5kZXI6NjM2XzEtNjU4ICAgICBbMDAzXSBkbi4xICAg
MjE0LjIwNjY3NzogZHdjM19nYWRnZXRfZXBfZGlzYWJsZTogZXAwaW46IG1wcyA1MTIvNTEyIHN0
cmVhbXMgMCBidXJzdCAxIHJpbmcgMC8wIGZsYWdzIGU6c3dicDo8DQo+IA0KPiAyLiBLZXJuZWwg
bG9nDQo+IA0KPiBbICAxOTAuNDQ3NzExXUlbMjogICAga3NvZnRpcnFkLzI6ICAgMjNdIC0tLS0t
LS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KPiBbICAxOTAuNDQ3Nzc3XUlbMjogICAg
a3NvZnRpcnFkLzI6ICAgMjNdIFdBUk5JTkc6IENQVTogMiBQSUQ6IDIzIGF0IGRyaXZlcnMvdXNi
L2R3YzMvZ2FkZ2V0LmM6MzYzMiBkd2MzX2dhZGdldF9lcF9kZXF1ZXVlKzB4MjI4LzB4MjM0DQo+
IFsgIDE5MC40NDk1ODddSVsyOiAgICBrc29mdGlycWQvMjogICAyM10gcGMgOiBkd2MzX2dhZGdl
dF9lcF9kZXF1ZXVlKzB4MjI4LzB4MjM0DQo+IFsgIDE5MC40NDk2MTBdSVsyOiAgICBrc29mdGly
cWQvMjogICAyM10gbHIgOiBkd2MzX2dhZGdldF9lcF9kZXF1ZXVlKzB4MTI0LzB4MjM0DQo+IFsg
IDE5MC40NDk2MjldSVsyOiAgICBrc29mdGlycWQvMjogICAyM10gc3AgOiBmZmZmZmZjMDEyOTRi
YWQwDQo+IFsgIDE5MC40NDk2NDddSVsyOiAgICBrc29mdGlycWQvMjogICAyM10geDI5OiBmZmZm
ZmZjMDEyOTRiYWYwIHgyODogMDAwMDAwMDAwMDAwMDAwMCANCj4gWyAgMTkwLjQ0OTY3OV1JWzI6
ICAgIGtzb2Z0aXJxZC8yOiAgIDIzXSB4Mjc6IGZmZmZmZmMwMTIxZTQwMDAgeDI2OiBmZmZmZmY4
ODIwOGM5ZGMwIA0KPiBbICAxOTAuNDQ5NzExXUlbMjogICAga3NvZnRpcnFkLzI6ICAgMjNdIHgy
NTogZmZmZmZmODkzZGQ1YzU3MCB4MjQ6IGZmZmZmZjg5M2RkMjIwODAgDQo+IFsgIDE5MC40NDk3
NDJdSVsyOiAgICBrc29mdGlycWQvMjogICAyM10geDIzOiBmZmZmZmY4OGE0ZjhhMTY4IHgyMjog
ZmZmZmZmODhhNGY4YTEwMCANCj4gWyAgMTkwLjQ0OTc3M11JWzI6ICAgIGtzb2Z0aXJxZC8yOiAg
IDIzXSB4MjE6IGZmZmZmZjg5M2RkNWM1MDAgeDIwOiAwMDAwMDAwMDAwMDAwMDgwIA0KPiBbICAx
OTAuNDQ5ODAzXUlbMjogICAga3NvZnRpcnFkLzI6ICAgMjNdIHgxOTogZmZmZmZmODkzZGQyMjIz
OCB4MTg6IGZmZmZmZmMwMTI5MWQwNjggDQo+IFsgIDE5MC40NDk4MzRdSVsyOiAgICBrc29mdGly
cWQvMjogICAyM10geDE3OiAwMDAwMDAwMDAwMDA0MDAwIHgxNjogZmZmZmZmODhiYjBjYzAwMCAN
Cj4gWyAgMTkwLjQ0OTg2NF1JWzI6ICAgIGtzb2Z0aXJxZC8yOiAgIDIzXSB4MTU6IDAwMDAwMDAw
MDAwMDAyMDAgeDE0OiBmZmZmZmY4ODIwOGQ0ZDAwIA0KPiBbICAxOTAuNDQ5ODk1XUlbMjogICAg
a3NvZnRpcnFkLzI6ICAgMjNdIHgxMzogZmZmZmZmODgyMDhkNGQwMCB4MTI6IDAwMDAwMDAwMDAw
MDAxYjUgDQo+IFsgIDE5MC40NDk5MjZdSVsyOiAgICBrc29mdGlycWQvMjogICAyM10geDExOiBm
ZmZmZmY4ODIwOGM5ZGMwIHgxMDogMDAwMDAwMDEwMDAwMDEwMyANCj4gWyAgMTkwLjQ0OTk1OF1J
WzI6ICAgIGtzb2Z0aXJxZC8yOiAgIDIzXSB4OSA6IGZmZmZmZjg4MjA4YzlkYzAgeDggOiAwMDAw
MDAwMDAwMDAwMDA4IA0KPiBbICAxOTAuNDQ5OTg5XUlbMjogICAga3NvZnRpcnFkLzI6ICAgMjNd
IHg3IDogZmVmZWZlZmVmZWZlZmVmZSB4NiA6IDAwMDAwMDAwMDAwMDgwODAgDQo+IFsgIDE5MC40
NTAwMjBdSVsyOiAgICBrc29mdGlycWQvMjogICAyM10geDUgOiAwMDAwMDAwMDAwMDAwMDAwIHg0
IDogMDAwMDAwMDAwMDAwMDEwMyANCj4gWyAgMTkwLjQ1MDA1MF1JWzI6ICAgIGtzb2Z0aXJxZC8y
OiAgIDIzXSB4MyA6IDAwMDAwMDAwMDAwMDAwODAgeDIgOiBmZmZmZmY4ODIwOGFjOTAwIA0KPiBb
ICAxOTAuNDUwMDgxXUlbMjogICAga3NvZnRpcnFkLzI6ICAgMjNdIHgxIDogZmZmZmZmODgyMDhh
YzkwMCB4MCA6IDAwMDAwMDAwZmZmZmZmOTIgDQo+IFsgIDE5MC40NTAxMjBdSVsyOiAgICBrc29m
dGlycWQvMjogICAyM10gQ2FsbCB0cmFjZToNCj4gWyAgMTkwLjQ1MDE1M11JWzI6ICAgIGtzb2Z0
aXJxZC8yOiAgIDIzXSAgZHdjM19nYWRnZXRfZXBfZGVxdWV1ZSsweDIyOC8weDIzNA0KPiBbICAx
OTAuNDUwMTg3XUlbMjogICAga3NvZnRpcnFkLzI6ICAgMjNdICB1c2JfZXBfZGVxdWV1ZSsweDRj
LzB4YTANCj4gWyAgMTkwLjQ1MDIxOV1JWzI6ICAgIGtzb2Z0aXJxZC8yOiAgIDIzXSAgZmZzX2Fp
b19jYW5jZWwrMHg0Yy8weDg0DQo+IFsgIDE5MC40NTAyNDddSVsyOiAgICBrc29mdGlycWQvMjog
ICAyM10gIGZyZWVfaW9jdHhfdXNlcnMrMHg4MC8weDExMA0KPiBbICAxOTAuNDUwMjgxXUlbMjog
ICAga3NvZnRpcnFkLzI6ICAgMjNdICBwZXJjcHVfcmVmX3B1dF9tYW55KzB4ZjAvMHgxNjQNCj4g
WyAgMTkwLjQ1MDMxMF1JWzI6ICAgIGtzb2Z0aXJxZC8yOiAgIDIzXSAgcGVyY3B1X3JlZl9zd2l0
Y2hfdG9fYXRvbWljX3JjdSsweDEzYy8weDFkYw0KPiBbICAxOTAuNDUwMzM5XUlbMjogICAga3Nv
ZnRpcnFkLzI6ICAgMjNdICByY3VfZG9fYmF0Y2grMHgyMDgvMHg1YjQNCj4gWyAgMTkwLjQ1MDM2
MF1JWzI6ICAgIGtzb2Z0aXJxZC8yOiAgIDIzXSAgcmN1X2NvcmUrMHgyMmMvMHg0M2MNCj4gWyAg
MTkwLjQ1MDM4NF1JWzI6ICAgIGtzb2Z0aXJxZC8yOiAgIDIzXSAgcmN1X2NvcmVfc2krMHgxNC8w
eDI0DQo+IFsgIDE5MC40NTA0MDldSVsyOiAgICBrc29mdGlycWQvMjogICAyM10gIGVmaV9oZWFk
ZXJfZW5kKzB4MTM0LzB4MzUwDQo+IFsgIDE5MC40NTA0MzddSVsyOiAgICBrc29mdGlycWQvMjog
ICAyM10gIHJ1bl9rc29mdGlycWQrMHgzNC8weDc0DQo+IA0KPiBUaGUgcG9pbnQgaXMgdGhlcmUg
d291bGQgYmUgc29tZSByZXF1ZXN0cyBwZW5kaW5nIHdpdGhvdXQgZ2l2ZWJhY2stZWQuDQo+IFRo
ZXkncmUgZnJvbSByZW1vdmluZyBmdW5jdGlvbiBkcml2ZXIoZmZzX2Fpb19jYW5jZWwpLiBJdCBj
b3VsZCBjYXVzZQ0KPiB0aGUgZnVuY3Rpb24gZHJpdmVyIHdvdWxkIHdhaXQgZm9yIGRlcXVldWUg
cmVxdWVzdHMgY29tcGxldGVkLg0KPiANCg0KSSBtYXkgbWlzdW5kZXJzdGFuZCB0aGUgZGVzY3Jp
cHRpb24sIG9yIHNvbWV0aGluZyBkb2Vzbid0IG1hdGNoIHVwLiBJZg0KInJlbW92aW5nIGZ1bmN0
aW9uIGRyaXZlciIgbWVhbnMgZnVuY3Rpb24gdW5iaW5kLCB0aGVuIHRoaXMgd2lsbCB0cmlnZ2Vy
DQpkaXNhYmxpbmcgdGhlIGVuZHBvaW50cyBhbmQgZHdjM19yZW1vdmVfcmVxdWVzdHMoKS4gSWYN
CmR3YzNfcmVtb3ZlX3JlcXVlc3RzKCkgd2FzIGNhbGxlZCwgdGhlbiB0aGUgZHdjMyBkcml2ZXIg
d291bGQgZ2l2ZSBiYWNrDQp0aGUgcmVxdWVzdHMgcmVnYXJkbGVzcyB3aGV0aGVyIHRoZSBFbmQg
VHJhbnNmZXIgY29tbWFuZCB3YXMgY29tcGxldGVkLg0KDQpJZiB0aGlzIGlzIG5vdCB0aGUgZnVs
bCBsb2csIGNhbiB5b3Ugc2VuZCB0aGUgZnVsbCBkcml2ZXIgbG9nLiBUaGF0DQp3b3VsZCBnaXZl
IG1vcmUgY2x1ZXMuDQoNClRoYW5rcywNClRoaW5oDQo=
