Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9C95740A1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 02:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiGNAl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 20:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGNAlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 20:41:55 -0400
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28F9B2A;
        Wed, 13 Jul 2022 17:41:54 -0700 (PDT)
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8617840DC2;
        Thu, 14 Jul 2022 00:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1657759314; bh=kwHaiMlWdK7V9mkjMlTlT6NBgZIucFIPUPPuOr5dcWI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ahekITKXtnQ3m5u3l0FT8DJgHbd9Ja2QLzpzGAJuwH7VtTcj4aRfadnOTVMP5zQjA
         GJIR9F/lHlIRZjV+/biy6BxTL0a0tXiiJJJ5+xKMwQSUhKVWdQoQRuKH22rQrHko2t
         cPpjMO8L1fyqT3XiedTpLH4D4dc0Dfjqd0cxaBiyT2JmHMot/JmZvfw2FVkJwxNcOr
         ZtHI3bRIUIFkzaq7WLc4Lu5qGKBjH8wOqoiiD850NsG/1nef/DIaibxgpcPx+piHyA
         oSmOeE/0qa5mDt/vaEuDbixG5nf1Qs+3OUeWimnRcgEAUQcNBCVZhAnJiaNoT7l9XJ
         Au1iHLGe4gJkw==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id EB0C1A007D;
        Thu, 14 Jul 2022 00:41:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 48F8780078;
        Thu, 14 Jul 2022 00:41:53 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="nxbXNsxf";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lj0ROqvGsX/8NdlXUuL40RzFm9jT6ZXhmKhB7Fotyb17g4ykDAuD80mLjVcLOkaZt5xWm2HZ2rlUCn873WKKYhtVA+RO121qUDBnO/vRWO71d0VZu0o1xViacgCkaIGh8VaZNjGhcyND+PZLUW0Hyf5O/tBEz8HbPyORCagzLLKCZWKS/sr9a0VSSHVdGb4zdXIW1CtdsJVeNyTLOXi7p0t8s7+ciBG+TRw4/hYec1CLKCZKxTUgtCCU4VAe207R2GFRIjqdFvVQ4nY6qWFcNfe+ADV6U0LiCp7GVKH5AjGuUmxx707THThjfeZqZ8H+bIvxUvqB7s69H7bpez0tug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwHaiMlWdK7V9mkjMlTlT6NBgZIucFIPUPPuOr5dcWI=;
 b=KOq/PYzD8woJOlM3qonv4mR+WYISq6ldCLUbcbv9RVZRtWWo3+9d8FBURhZpxOaGIwmDEj/kxbG+wnRC1fPt5aoVrQ1euRScYW3J37/4u8QAw6aS3txrBrn7KFJ8TMvxah2UK7gFxjEeBuPdq71c7Fd1Ffzbj5z9JL7m5xVm8xmH0fO6DpKQIb4XeNXO6Ng/Sc6tIICnH+xNReMROv49ofreOgNK8AVtkDX84mWh7ysMN3dqbzLMvrBWCCxv9bFZbb9X+aSfnpQLz7H7wAVFtTmEGEBnq7/Q7tbl4krfnl2KzBIHdl7arqd5sUIXPzrSTb2aENgZLcR8AGw/c36KIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwHaiMlWdK7V9mkjMlTlT6NBgZIucFIPUPPuOr5dcWI=;
 b=nxbXNsxfE2wZpOeGjOm/XkFoRyCxtzdrGWPKlOB3SAvPA+BV01xHFiBUAqHOE10T6mBC+K6KlmTbRtb32yF+VI1h44SMBahmNKzB28obOZCbwlVHOHRFsJQu1A5gmSp2k53e6tC44n+rQlt3DhTjdGRjMP89JdQL1kqrcNyOOIE=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM6PR12MB4025.namprd12.prod.outlook.com (2603:10b6:5:1c8::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Thu, 14 Jul
 2022 00:41:50 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c%7]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 00:41:50 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH 4/5] usb: dwc3: Allow end transfer commands to be sent
 during soft disconnect
Thread-Topic: [PATCH 4/5] usb: dwc3: Allow end transfer commands to be sent
 during soft disconnect
Thread-Index: AQHYkvuyG8yeBB+HgESO8az/W4EWca11SMkAgAYJLICAADuqAIABDQWAgABuCgCAAAQYgIAAAkOA
Date:   Thu, 14 Jul 2022 00:41:50 +0000
Message-ID: <70456848-a31d-8573-52b1-a09916722f4c@synopsys.com>
References: <20220708185007.21743-1-quic_wcheng@quicinc.com>
 <20220708185007.21743-5-quic_wcheng@quicinc.com>
 <06498069-db45-202b-eba6-47bfa6948143@synopsys.com>
 <8029f6bb-4704-0495-00d2-ee78ee684eb3@quicinc.com>
 <889ba0fc-4a8c-cb89-ba7c-90119a58b997@synopsys.com>
 <59631540-ee6a-41f3-d460-4808162d06c9@quicinc.com>
 <cf292b7f-3a16-3d2e-d01f-288902b44f1a@synopsys.com>
 <9d5230ac-c2fa-6ec8-0deb-f81d1b941222@quicinc.com>
In-Reply-To: <9d5230ac-c2fa-6ec8-0deb-f81d1b941222@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59c1bd93-96e5-4a91-1666-08da6531a3ba
x-ms-traffictypediagnostic: DM6PR12MB4025:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YhLZc3RGz1MmqOaweWs7yWs7+/9mclhqLde1QCLAN9EwyrE6Wqd5X9ibg0RD1QJjuYKJWMC7sEzHNww9bFm9VT5W2uefV8G3YRcT0bOlioegvACxSGT6oYpsEajDexdnSfScTu+yM8oc/++P9T5Nl9hyuhbvdh77O5Q/8nQCAibvKktM+jr1/dBJtrYevJTOJp3tk7NmIKdyKGq32KGqdQJm3flXPy1z5dEWyTQHt5y5xiFjxvSJGrSAVGz6FN+7sxhc/yhUiGdz4pDR3R2WT0N1BT4k3RMUnG+k95Dq9zugd3noOm+eM+cIxzWphVhzSZffa7oZ/Sd6/n5IlrQANLijpEJNE9PYX5/9w/02kh23spC/EMoSyJdfWLLP2bbiffeXyASSpbBJSzRKc0qjBXOvgM2JxTM6E9q+Plf6LCC4vIgflx0jczCNhCWquVvpbqMA0Sd5JcOHVtkNrpqcP3u4dqBq89LjHdCvRwexmsAlT/loW7raB0dNeGC5r6Alh9PyEFjR41naSmG3G1iQ0YDaEseCi5YWTsvUal529phjOR60jwpnxXi6cJ6eGXiK3wjt+AsZWdPTvvtwHpdWLs7FXf9HsnCxK/GqiKHc6VGFLl6T2TStCmbJnrdbsbkP07zJTxi/Ab+CdcGfB+0wRWoix4OiVDkgax37ng9LVJh1JRKfKZJV4qeO31uH76wmiFhtLRBHi9J9A8GhhnPYv3tFOcBhYAuDdTCxJi+7h1WZ9ZQWjD662OlDVO6FwzLdrZ8tPhrr91IbPnIfQOc2YeXvDVnvLzUeJaauS4IW0JXmYi5rL55GGipxrvk12czNh6AmtfLoy1r98H6Fa1yRZJX6P/BVNduw3MkZIWhigcKoRsnG1ilBSWX9oYHIZctD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(39860400002)(366004)(136003)(376002)(64756008)(66556008)(38070700005)(66946007)(66446008)(76116006)(2616005)(8676002)(83380400001)(66476007)(71200400001)(316002)(6486002)(478600001)(4326008)(53546011)(186003)(6506007)(41300700001)(110136005)(8936002)(122000001)(6512007)(31696002)(31686004)(26005)(5660300002)(2906002)(36756003)(86362001)(38100700002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0cwQ0VtQnpQMHV6RFNFVjVaby9iMFdlbm9BOXVrd3JYdEJkeFN3VVpzai9X?=
 =?utf-8?B?d1dJVkxlcmJwSGkzdWM4d0Q1SWx4dWlqdktQMC9wa1VyV1F2VUdSQ2VrUnJx?=
 =?utf-8?B?aEE0VG9RNnEwclBnL2Y4ZFRIQmhVNnB2b3JtV3FmbEJYUWptSW4vL0VmWjhE?=
 =?utf-8?B?c3FKTzIza2pMRVFaMGtqdTh3eDZqazREd29sd2hwWWF3aGVyRGprcGhGQkNo?=
 =?utf-8?B?bmI0Y2I3UzRWZGYyaDZqQllKd2NER3dZUlNET2ZzTzVEZFVsU1dzcVlxajBw?=
 =?utf-8?B?Y3QwRnZkWnZzbEZZY040WVFLTnVaTUNvQ2RURFB2RGV1bzEwbWhDUWhuQU5j?=
 =?utf-8?B?Vk9DRks0SjVZZzV6VzhsZzU2MldENExuWE01bnJwalFYU3NKcXJyVG92MlNn?=
 =?utf-8?B?YlVrM2hNeEFNaU9QYlQ0UDQ2NDdVTXRRS0JTWmZQUzlFdEZIaE84RDNSNzFv?=
 =?utf-8?B?c1AzZUtDTURZdzMvbHRTK1lJMUZmbGZXL0doUmYxS2toS3B3Y0FTTkN2WkZB?=
 =?utf-8?B?OXhSYmRaUW1XTFNXWitTeVdLVnptbmY4S1luM3V0eDFUSVNWVjFSMmlYbGNa?=
 =?utf-8?B?akZuV3dCVUxOL0dRYktrSXFMTjNRZXgrd21ybkw4Q2p2WGd6Ni9vb3ZXbFlv?=
 =?utf-8?B?WUwzQTB1cXJROXhBVlNxQjhKZG1yd0hkQTFDd1kzTGNwb0FYYlkvOXcxclQ2?=
 =?utf-8?B?dW5mQ1pXWjc2N1p1Wlp1b2toSGNQWjAwY2NwUWk2cm0rWkZVeXBlOG1rTWRU?=
 =?utf-8?B?cGN2VFdYT3NMRSt6d0YxcFZjM05ZdnU4WUVHTHZlNm02RnhLL2Z2VFVPSUhH?=
 =?utf-8?B?ZkhUV2VMVHhpekY3aWNUVDdHU2xsZ1E5a2ZjSndsSXBaa0x4OGRZWDNlc0wr?=
 =?utf-8?B?WCtqRFEzbmNVK2Jxc3N5OFBQYU53ODBrZjlwUU0xRzcxNnhSVlhXcy9Ea2Qr?=
 =?utf-8?B?Qlh6RlA3ZVpMY05adVhOTkpYNEZmK2xzUDg2TVdmbmxXYmlEQ1RCNGdNMW42?=
 =?utf-8?B?eG5peGQzbTc3NkRYYjdoTFhsVzFnZWgwaENWQ3hJaFVXb2JaVGRkWEtTZFVT?=
 =?utf-8?B?OHdTczUzSDZ1OUF4UndxSTRNbmtoZE9EU2hhYlJTMXpiZCtuRmhvc251UThQ?=
 =?utf-8?B?T2Y5SUxVVTcxOVcrWDdVSFBiNlRmYURqTURFZm1uKytEcUtKYjN5aTdDY3U0?=
 =?utf-8?B?UFlkOFhveWdsTkxUR0VuSmJ4d0xNVkNMeVQreXdSSk5nMHl2UWR1dVIrcFE1?=
 =?utf-8?B?SzFjaU1pNXNzODFHYnlLOXovTXJyZWpaTkUyMUg3Y0VyZU9RRWF4TEUrU0Fz?=
 =?utf-8?B?M1VHNHpzN2lmbXR0ZXZiZXlhY0FNdTBGb2VoY3UyOGw4OTZkTVRYUHF0V1BT?=
 =?utf-8?B?Z2E1Tm1KOWhIY1VRYWVvTHUxdEFqQ2R2L1pPZnNCbTJsR3R5L2ZHU01hRFhR?=
 =?utf-8?B?QmNmRUlSUUV3TGI5OFp3T24wbi9pakhvbkJKcUJnVlRlR3lOcFpkWnI2NEZV?=
 =?utf-8?B?aWFXWjJVUXdiSkNBL1B1dk56M2NTSENINHBRN281WERuVktza0gvc092Tm9G?=
 =?utf-8?B?VklEamgrU2YzeWFDbzVwUzI5V0k1Q3RxRG5ocnEvdTBDcmViNVFOdDVlWUVa?=
 =?utf-8?B?UlFMS0U1WXlhQTd5RmJ0MjNTSzhXaDRwYUtEMnI0UmZ4bXdoU3pnSTVmVnE3?=
 =?utf-8?B?MUFDQzNONjZFeHVMZm9JczBwQlpweDUwbk93clJYZUc5MUc0dTJuYk1rTHdu?=
 =?utf-8?B?dzl0M1locWExQjZ2RkRlcENNSnBLTzBuQ0FjYldRbnRBOW9pdzhGSTNUcXJh?=
 =?utf-8?B?eVJwTDFuT3ErRmIrdkdXMGxRaE15cDBNdWUyWnJEQm4zZEdGWFVpOGlqZDNh?=
 =?utf-8?B?S0pPekJGekoxbnhURzQ4VG40TmxzcTlYZlFJa1ppUERBQ1B3b055K2N5U0xz?=
 =?utf-8?B?Q3huTDMxTzRvS3p5SGhjOERENGl0R1R2dmRSRHdUdytBd3VJZU96eTh1aC8r?=
 =?utf-8?B?U2JDSDA4OGtaUDFkVE5Rd04rVmFUU3Jkb3VXSTBRZW81TFljOFhQVUJ0ek9s?=
 =?utf-8?B?TDEyRkN5ZzRsNDFxL3lETUJJTWVFZ3FNaVhVcFFlRVN1dks2dzRCU01HWjlP?=
 =?utf-8?Q?j3Fm8goRuLbuhG8UTyJD/xS75?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80B26E3657FEAF488DE3692797D1B347@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c1bd93-96e5-4a91-1666-08da6531a3ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 00:41:50.0718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8tCq45oeMTqMGRJPjYQV7+VIDF+S8rUJ3/Ziylis9jcpw6uv+Nq5OB6dp8Z8QZiIhFPHmES76umK85ozoRpR7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4025
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8xMy8yMDIyLCBXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+IEhpIFRoaW5oLA0KPg0KPiBPbiA3
LzEzLzIwMjIgNToxOSBQTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPj4gT24gNy8xMy8yMDIyLCBX
ZXNsZXkgQ2hlbmcgd3JvdGU6DQo+Pj4gSGkgVGhpbmgsDQo+Pj4NCj4+PiBPbiA3LzEyLzIwMjIg
Njo0MiBQTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPj4+PiBPbiA3LzEyLzIwMjIsIFdlc2xleSBD
aGVuZyB3cm90ZToNCj4+Pj4+IEhpIFRoaW5oLA0KPj4+Pj4NCj4+Pj4+IE9uIDcvOC8yMDIyIDY6
NTggUE0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4+Pj4+PiBPbiA3LzgvMjAyMiwgV2VzbGV5IENo
ZW5nIHdyb3RlOg0KPj4+Pj4+PiBJZiBzb2Z0IGRpc2Nvbm5lY3QgaXMgaW4gcHJvZ3Jlc3MsIGFs
bG93IHRoZSBlbmR4ZmVyIGNvbW1hbmQgdG8gYmUNCj4+Pj4+Pj4gc2VudCwNCj4+Pj4+Pj4gd2l0
aG91dCB0aGlzLCB0aGVyZSBpcyBhbiBpc3N1ZSB3aGVyZSB0aGUgc3RvcCBhY3RpdmUgdHJhbnNm
ZXIgY2FsbA0KPj4+Pj4+PiAoZHVyaW5nIHB1bGx1cCBkaXNhYmxlKSB3b3VsZG4ndCBhY3R1YWxs
eSBpc3N1ZSB0aGUgZW5keGZlciANCj4+Pj4+Pj4gY29tbWFuZCwNCj4+Pj4+Pj4gd2hpbGUgY2xl
YXJpbmcgdGhlIERFUCBmbGFnLg0KPj4+Pj4+Pg0KPj4+Pj4+PiBJbiBhZGRpdGlvbiwgaWYgdGhl
IERXQzNfRVBfREVMQVlfU1RPUCBmbGFnIHdhcyBzZXQgYmVmb3JlIHNvZnQNCj4+Pj4+Pj4gZGlz
Y29ubmVjdA0KPj4+Pj4+PiBzdGFydGVkIChpLmUuIGZyb20gdGhlIGRlcXVldWUgcGF0aCksIGVu
c3VyZSB0aGF0IHdoZW4gdGhlIEVQMA0KPj4+Pj4+PiB0cmFuc2FjdGlvbg0KPj4+Pj4+PiBjb21w
bGV0ZXMgZHVyaW5nIHNvZnQgZGlzY29ubmVjdCwgdG8gaXNzdWUgdGhlIGVuZHhmZXIgd2l0aCB0
aGUgDQo+Pj4+Pj4+IGZvcmNlDQo+Pj4+Pj4+IHBhcmFtZXRlciBzZXQsIGFzIGl0IGRvZXMgbm90
IGV4cGVjdCBhIGNvbW1hbmQgY29tcGxldGUgZXZlbnQuDQo+Pj4+Pj4+DQo+Pj4+Pj4+IFNpZ25l
ZC1vZmYtYnk6IFdlc2xleSBDaGVuZyA8cXVpY193Y2hlbmdAcXVpY2luYy5jb20+DQo+Pj4+Pj4+
IC0tLQ0KPj4+Pj4+PiDCoMKgwqDCoCBkcml2ZXJzL3VzYi9kd2MzL2VwMC5jwqDCoMKgIHwgMyAr
LS0NCj4+Pj4+Pj4gwqDCoMKgwqAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDUgKysrKy0N
Cj4+Pj4+Pj4gwqDCoMKgwqAgMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pDQo+Pj4+Pj4+DQo+Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2Mz
L2VwMC5jIGIvZHJpdmVycy91c2IvZHdjMy9lcDAuYw0KPj4+Pj4+PiBpbmRleCA1MDZlZjcxN2Zk
YzAuLjU4NTFiMGU5ZGIwYSAxMDA2NDQNCj4+Pj4+Pj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9l
cDAuYw0KPj4+Pj4+PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2VwMC5jDQo+Pj4+Pj4+IEBAIC0y
OTAsOCArMjkwLDcgQEAgdm9pZCBkd2MzX2VwMF9vdXRfc3RhcnQoc3RydWN0IGR3YzMgKmR3YykN
Cj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICghKGR3YzNfZXAtPmZsYWdzICYg
RFdDM19FUF9ERUxBWV9TVE9QKSkNCj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgY29udGludWU7DQo+Pj4+Pj4+IMKgwqDCoMKgIC3CoMKgwqDCoMKgwqDCoCBkd2MzX2Vw
LT5mbGFncyAmPSB+RFdDM19FUF9ERUxBWV9TVE9QOw0KPj4+Pj4+PiAtwqDCoMKgwqDCoMKgwqAg
ZHdjM19zdG9wX2FjdGl2ZV90cmFuc2Zlcihkd2MzX2VwLCB0cnVlLCB0cnVlKTsNCj4+Pj4+Pj4g
K8KgwqDCoMKgwqDCoMKgIGR3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXIoZHdjM19lcCwgdHJ1ZSwg
ZHdjLT5jb25uZWN0ZWQpOw0KPj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgIH0NCj4+Pj4+Pj4gwqDC
oMKgwqAgfQ0KPj4+Pj4+PiDCoMKgwqDCoCBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9n
YWRnZXQuYw0KPj4+Pj4+PiBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4+Pj4+Pj4gaW5k
ZXggYmQ0MDYwOGIxOWRmLi5mYmEyNzk3YWQ5YWUgMTAwNjQ0DQo+Pj4+Pj4+IC0tLSBhL2RyaXZl
cnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4+Pj4+Pj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRn
ZXQuYw0KPj4+Pj4+PiBAQCAtMzY5Niw4ICszNjk2LDEwIEBAIHZvaWQgZHdjM19zdG9wX2FjdGl2
ZV90cmFuc2ZlcihzdHJ1Y3QgDQo+Pj4+Pj4+IGR3YzNfZXANCj4+Pj4+Pj4gKmRlcCwgYm9vbCBm
b3JjZSwNCj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCBpZiAoZGVwLT5udW1iZXIgPD0gMSAmJiBk
d2MtPmVwMHN0YXRlICE9IEVQMF9EQVRBX1BIQVNFKQ0KPj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuOw0KPj4+Pj4+PiDCoMKgwqDCoCArwqDCoMKgIGlmIChpbnRlcnJ1cHQg
JiYgKGRlcC0+ZmxhZ3MgJiBEV0MzX0VQX0RFTEFZX1NUT1ApKQ0KPj4+Pj4+PiArwqDCoMKgwqDC
oMKgwqAgcmV0dXJuOw0KPj4+Pj4+PiArDQo+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqAgaWYgKCEo
ZGVwLT5mbGFncyAmIERXQzNfRVBfVFJBTlNGRVJfU1RBUlRFRCkgfHwNCj4+Pj4+Pj4gLcKgwqDC
oMKgwqDCoMKgIChkZXAtPmZsYWdzICYgRFdDM19FUF9ERUxBWV9TVE9QKSB8fA0KPj4+Pj4+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKGRlcC0+ZmxhZ3MgJiBEV0MzX0VQX0VORF9UUkFOU0ZF
Ul9QRU5ESU5HKSkNCj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsNCj4+
Pj4+Pj4gwqDCoMKgwqAgQEAgLTM3NDQsNiArMzc0Niw3IEBAIHZvaWQgZHdjM19zdG9wX2FjdGl2
ZV90cmFuc2ZlcihzdHJ1Y3QNCj4+Pj4+Pj4gZHdjM19lcCAqZGVwLCBib29sIGZvcmNlLA0KPj4+
Pj4+PiDCoMKgwqDCoMKgwqDCoMKgIF9fZHdjM19zdG9wX2FjdGl2ZV90cmFuc2ZlcihkZXAsIGZv
cmNlLCBpbnRlcnJ1cHQpOw0KPj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgIHNwaW5fbG9jaygmZHdj
LT5sb2NrKTsNCj4+Pj4+Pj4gwqDCoMKgwqAgK8KgwqDCoCBkZXAtPmZsYWdzICY9IH5EV0MzX0VQ
X0RFTEFZX1NUT1A7DQo+Pj4+Pj4NCj4+Pj4+PiBDYW4gd2UgY2xlYXIgdGhpcyBmbGFnIGluIF9f
ZHdjM19zdG9wX2FjdGl2ZV90cmFuc2ZlcigpLiBJdCBzaG91bGQNCj4+Pj4+PiBhcHBseQ0KPj4+
Pj4+IGlmIEVuZCBUcmFuc2ZlciBjb21tYW5kIHdhcyBzZW50Lg0KPj4+Pj4NCj4+Pj4+IEkgd2Fu
dGVkIHRvIG1ha2Ugc3VyZSB0aGF0IHdlIHdlcmVuJ3QgbW9kaWZ5aW5nIHRoZSBERVAgZmxhZ3Mg
b3V0c2lkZQ0KPj4+Pj4gb2YgYSBzcGluIGxvY2suwqAgUGF0Y2gjMyBtb2RpZmllcyBpdCB3aGVy
ZSB3ZSB1bmxvY2sgYmVmb3JlIGNhbGxpbmcNCj4+Pj4+IF9fZHdjM19zdG9wX2FjdGl2ZV90cmFu
c2ZlcigpLCBzbyB3ZSBjYW4gYWxsb3cgdGhlIGR3YzMgdGhyZWFkZWQgSVJRDQo+Pj4+PiBoYW5k
bGUgZXZlbnRzIHdoaWxlIHRoZSBjbWQgc3RhdHVzIHBvbGxpbmcgaGFwcGVucy4NCj4+Pj4+DQo+
Pj4+PiBNYXliZSB3ZSBjYW4gdW5sb2NrL2xvY2sgdGhlIGR3YzMtPmxvY2sgaW5zaWRlDQo+Pj4+
PiBfX2R3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXIoKSBhbmQgdGhhdCB3YXkgd2UgY2FuIGVuc3Vy
ZSBERVAgZmxhZ3MgDQo+Pj4+PiBhcmUNCj4+Pj4+IG1vZGlmaWVkIHByb3Blcmx5Pw0KPj4+Pg0K
Pj4+PiBJIGRpZG4ndCByZWFsaXplIHRoYXQgeW91IHVubG9jay9sb2NrIHdoZW4gY2FsbGluZw0K
Pj4+PiBfX2R3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXIoKS4gV2UnZCBuZWVkIHRvIGJlIGNhcmVm
dWwgaWYgd2Ugd2FudCB0bw0KPj4+PiB1bmxvY2svbG9jayBpdCwgYW5kIGF2b2lkIGl0IGFsbCB0
b2dldGhlciBpZiBwb3NzaWJsZS4gSXQgY2FuIGJlIA0KPj4+PiBlYXNpbHkNCj4+Pj4gb3Zlcmxv
b2tlZCBqdXN0IGxpa2UgZHdjM19nYWRnZXRfZ2l2ZWJhY2soKS4NCj4+Pj4NCj4+Pj4gV2hhdCBp
c3N1ZSBkaWQgeW91IHNlZSB3aXRob3V0IGRvaW5nIHRoaXM/DQo+Pj4NCj4+PiBJIHNhdyBlbmR4
ZmVyIHRpbWVvdXQgaXNzdWVzIGlmIEkgZGlkbid0IGRvIGl0LsKgIElmIHdlIGtlZXAgdGhlIGxv
Y2sNCj4+PiBoZWxkLCB0aGVuIHRoZSBEV0MzIGV2ZW50IHByb2Nlc3Npbmcgd291bGQgYmUgYmxv
Y2tlZCBhY3Jvc3MgdGhlDQo+Pj4gZW50aXJlIHRpbWUgd2UgYXJlIHdhaXRpbmcgZm9yIHRoZSBj
b21tYW5kIGFjdCB0byBjbGVhci7CoCBXaXRoDQo+Pj4gdW5sb2NraW5nIGJlZm9yZSBwb2xsaW5n
LCB0aGVuIGF0IGxlYXN0IHdlJ3JlIHN0aWxsIGFibGUgdG8gaGFuZGxlIHRoZQ0KPj4+IEVQMCBl
dmVudHMgdGhhdCBhcmUgcGVuZGluZy4NCj4+Pg0KPj4+IEl0IHdhcyBkZWZpbml0ZWx5IG9uZSBv
ZiB0aGUgaGFyZGVyIHNjZW5hcmlvcyB0byByZXByb2R1Y2UuIFRoZSBtYWluDQo+Pj4gcGF0Y2gg
c2VyaWVzIHdoaWNoIHJlc29sdmVkIGEgbG90IG9mIHRoZSBpc3N1ZXMgZWFybHkgb24gd2FzIHBh
dGNoIzEuDQo+Pj4gQWZ0ZXIgYWRkaW5nIHRoYXQgdGhlIG90aGVyIGlzc3VlcyBhcmUgc2VlbiBt
YXliZSBhZnRlciBhIGRheSBvciBzbyBvZg0KPj4+IHRlc3RpbmcuDQo+Pj4NCj4+DQo+PiBJIHNl
ZS4gVGhlIHNvZnQtZGlzY29ubmVjdCBzdGlsbCBnbyB0aHJvdWdoIHJpZ2h0Pw0KPj4gQ2FuIHlv
dSB0cnkgdGhpcyBhbmQgc2VlIGlmIHRoaXMgd29ya3MgZm9yIHlvdT8NCj4+DQo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0
LmMNCj4+IGluZGV4IDEzZTRmMWEwMzQxNy4uNGY2N2E0ODRjNDkwIDEwMDY0NA0KPj4gLS0tIGEv
ZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRn
ZXQuYw0KPj4gQEAgLTQ1MSw3ICs0NTEsOSBAQCBpbnQgZHdjM19zZW5kX2dhZGdldF9lcF9jbWQo
c3RydWN0IGR3YzNfZXAgKmRlcCwNCj4+IHVuc2lnbmVkIGludCBjbWQsDQo+Pg0KPj4gwqAgwqDC
oMKgwqDCoMKgwqAgZHdjM193cml0ZWwoZGVwLT5yZWdzLCBEV0MzX0RFUENNRCwgY21kKTsNCj4+
DQo+PiAtwqDCoMKgwqDCoMKgIGlmICghKGNtZCAmIERXQzNfREVQQ01EX0NNREFDVCkpIHsNCj4+
ICvCoMKgwqDCoMKgwqAgaWYgKCEoY21kICYgRFdDM19ERVBDTURfQ01EQUNUKSB8fA0KPj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgIChEV0MzX0RFUENNRF9DTUQoY21kKSA9PSBEV0MzX0RFUENNRF9F
TkRUUkFOU0ZFUiAmJg0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIShjbWQgJiBEV0MzX0RF
UENNRF9DTURJT0MpKSkgew0KPj4gwqAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dCA9IDA7DQo+PiDCoCDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBza2lwX3N0
YXR1czsNCj4+IMKgIMKgwqDCoMKgwqDCoMKgIH0NCj4+DQo+Pg0KPj4gV2UgY2FuIHNldCBpdCBh
bmQgZm9yZ2V0IGl0IHdoZW4gd2UncmUgYWJvdXQgdG8gZGUtaW5pdGlhbGl6ZSB0aGUNCj4+IGNv
bnRyb2xsZXIuIEp1c3QgbGlrZSB3aGF0IHdlJ3ZlIGFscmVhZHkgZG9uZSBieSBub3Qgd2FpdGlu
ZyBmb3IgdGhlIEVuZA0KPj4gVHJhbnNmZXIgZW5kcG9pbnQgY29tbWFuZCBjb21wbGV0aW9uIGlu
dGVycnVwdC4NCj4+DQo+DQo+IEkgY2FuIHNlZSB0aGlzIHdvcmtpbmcgZm9yIHRoZSBzb2Z0IGRp
c2Nvbm5lY3QgY2FzZSwgYnV0IHdlJ2xsIG5lZWQgdG8gDQo+IGFkZHJlc3MgaXQgZGlmZmVyZW50
bHkgZm9yIHRoZSBFUCBkZXF1ZXVlIHNjZW5hcmlvIHdoZXJlIElPQy9pbnRlcnJ1cHQgDQo+IGlz
IHJlcXVpcmVkIHRvIGNsZWFuIHVwIHRoZSBUUkJzLsKgIFRoaXMgaXMgb25lIG9mIHRoZSByZWFz
b25zIHdoeSBJIA0KPiB3ZW50IHdpdGggdGhlIHNwaW5sb2NrIGFwcHJvYWNoLCBzaW5jZSBpdCB3
b3VsZCBhcHBseSB0byBib3RoIHNpdHVhdGlvbnMuDQoNCkkgdGhvdWdodCB3ZSBhbHJlYWR5IGhh
bmRsZWQgdGhlIGNhc2UgZm9yIGVwIGRlcXVldWUgZnJvbSB0aGUgbGFzdCBmaXguIA0KV2FzIHRo
YXQgbm90IGFkZHJlc3NlZD8NCg0KVGhhbmtzLA0KVGhpbmgNCg==
