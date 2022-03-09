Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F874D3AD6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 21:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238102AbiCIUMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 15:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiCIUMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 15:12:14 -0500
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E70A253A;
        Wed,  9 Mar 2022 12:11:13 -0800 (PST)
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 01682C195E;
        Wed,  9 Mar 2022 20:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1646856673; bh=1l2yKFEpU63Qi1KD8EfmUqj9WGnQcxHkn25ETvyW3qE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=PGkfLfkD0/1E7AKY7O3FT0cZzmZOoIT4rDkwH5tTpX2Z5ao+q0LpBAjHj9Zz2rE8b
         vMSf+clxK4jV/ucrJvH4Fq8AAqrEDtfBPsf4kHlzYmUkWjASw7f+Kwato+zRLdgTfh
         +J6w1tbteG8aM8qhLUeG1J3dY9p0Imd/Awi5guIJ0M+asDzq/dZEeIGugsgeXKGzrH
         8zhx8SvwvdM3y5XH5Dg54l12KAZa3a8ebgscVaoaztA7IgfTBk32v917Z9zFtEzp5C
         gDeSlcov54KQuH6fPCdeOzK2H3DcHsI3y52HfZQQHfcEWO6cCCMWhn/nuUgcEdYvLg
         h1xk5AlIjI2Jw==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id CF044A007D;
        Wed,  9 Mar 2022 20:11:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1F1F8801EE;
        Wed,  9 Mar 2022 20:11:10 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="uFRfyeDU";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlWlbafhkUctWQWU0N7Bl0b6OfiLu7hsYYbzl+LK/4yq5fY2SSqrhdCjOCT4O7T/w+EvydrlllwOAEMTP08KVEFBzMu1+2HT+cooOQVFfeSPSKAVdZz/K5/CrM5u6R4T2xZD3lL3zwU3UgKIBHFHAIlbSy9R6acouFKNAH4uWlUDc6C8ftor44XRc+Bn+PD+IUU5jsF0PFSYKJEGVsidgjx3/MoWhEOhw8YgcuWdxmAQiBa7eGyRJ/FVATsZ+HXEyhpVpXJMEzVE8Qwg6cmoSF8PdAAQvTEivYxQCa6nva1PuhIA/gr1TRau//2ec/RZfX+kkIAk6nG/cReXY1bwwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1l2yKFEpU63Qi1KD8EfmUqj9WGnQcxHkn25ETvyW3qE=;
 b=c7WTXRjQq4rB27YiQCHaFXd7YuGFy/5kUSKUJE44VFaz1eUZ6z9b6Rx7JcIojAXvebJHsQg2bkxuJYlPPEY3NOZDfSU3f9iCT05QmOk7rV51z58y98uWfxz1as2qWcnqrXvkHJP/Sc3ryUsXDI1MxBCzy1+mAU0xe94uqAqbQtTv/aae/IbFtjknqtLDhSIUAWXuQ8THsd4rOTVCbxlzhupzqWzpbnF5yk5OxH4/cbW+GERmFTvwcZoxT7jMtwBatABCuM37kIiAhsy6JtPusZvCCWEIKIBmmEQAUfWRV8aRDvii4lkemzZ+nOxKO8eBOBeonWyHHdxRVl3zzkjrdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1l2yKFEpU63Qi1KD8EfmUqj9WGnQcxHkn25ETvyW3qE=;
 b=uFRfyeDUvzBlUvnGUxTC9YYH2bH03c4hYUply3NBih7m8kfbpmp1QGgNT2tGrqibB6LtYK808PHSleN2B4OBvxqCnHmr/xMHuCvraOu8ep0GIapYUAwBMtHz3+tFRmHTSgMaBIOSMzev9zHYzQgxg7rfxJXk0q97Vt5B9zrICcg=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 20:11:05 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::141:3edf:164a:857b]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::141:3edf:164a:857b%4]) with mapi id 15.20.5038.026; Wed, 9 Mar 2022
 20:11:05 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH] usb: dwc3: gadget: Wait for ep0 xfers to complete during
 dequeue
Thread-Topic: [PATCH] usb: dwc3: gadget: Wait for ep0 xfers to complete during
 dequeue
Thread-Index: AQHYM06Le2pevUk3FkG15YdkVpv3+ay3etoAgAACI4A=
Date:   Wed, 9 Mar 2022 20:11:04 +0000
Message-ID: <c89bb8a7-e239-66d2-d94e-e0a2120469af@synopsys.com>
References: <20220309004148.12061-1-quic_wcheng@quicinc.com>
 <319353ca-fe5d-81c8-029b-c4eebbee1959@synopsys.com>
In-Reply-To: <319353ca-fe5d-81c8-029b-c4eebbee1959@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b2027b5-fce5-4523-d2f6-08da0208f0f7
x-ms-traffictypediagnostic: BL0PR12MB4948:EE_
x-microsoft-antispam-prvs: <BL0PR12MB4948824E1CCF0F3F9397C7DFAA0A9@BL0PR12MB4948.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IXhsceafQdLOg7XgNCgn70J0k+uVToKbgq/hjbrT3VuzoD2Mz/PwLOxkLlDeOj0rGVxEXiENGJMmVN5BGUUZ0kBrYtSP6BrRmaoT/QrFWvhg+gjay+8oJWk1otubB26MrKE2SVoS5oMtwUAGLE6ccPTRk0RUYQ+xEgnd1y2E+z7hy+X7jYBez4+QLk700cUA8halBEkwlddH0Mfzq+oWjvVuWN0u+ZiE1bgGHkzUk2rQiHl0CG9akmX1WcoNMTrbVAzhLFbo61/5p42yWMPiKAhcQ3/1KOg+XDylyxmUAK+Pptycq0+XxGhAgzQ2o0uB8ShX1T7dTHd+2b1gJ5CBf8xlohT+xXcnqp2drUf8YmX8IQLO+TLBuZ7QFPcwA8qnn1LWuGfC9tHfohB7EZhzsYfsV+R2AWQjQZ9a9hkmujvLZlQXf2ROXcibot/DRpRgEJnJqP6cx8r/QZB18qWIX6pmwvG46QHtfGxDfL5V9Hc6/WT5L5vEDFgCuG61kJoUjKJaJMCcTvy/TBHQfesA8BUX9/ZY0pPagTsHIoNtxocVdYK+1SjXgIDZl0GyRnroGRYSwxRJkvfWaLLM7cdt1T+NW0DRPX+eMri+n+S8TImYWQjVOb4IljBlRXV/ZQlU+Uaet8mLetgz0kc/LWCbmihjpOj4G3V2obie7AdfuGcGBohQ1E45742sPqcVtI3sStXOAx06O7clvgQtDqLKzYlv4Vgu+tRiimdd+rlKP0Pi5Jh4q2YKdjxytIv59b8q02fYs57RH1dm/O9oC0kS+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(8676002)(76116006)(38100700002)(2906002)(66556008)(66946007)(66476007)(64756008)(4326008)(86362001)(54906003)(122000001)(71200400001)(110136005)(8936002)(38070700005)(5660300002)(6486002)(508600001)(316002)(31696002)(6506007)(26005)(186003)(36756003)(31686004)(83380400001)(6512007)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnhHRmYyYnBOTDBPNURtZks4MjFOVGtZRHFIQzNMWk1rV2FvTW5URjB2OVh2?=
 =?utf-8?B?NjZCNExBeW5Db0hDUStwSXVZeTYxUmdxdExlTGoyOUZnemlCempkVWpaWXEy?=
 =?utf-8?B?UlNFaGY4QnVmVUtnWXJ5S3lpdDlPOEErUkhYbXNiVml3dE9JM25PUWVhQ28z?=
 =?utf-8?B?cE9GRFF4ZlZGb0ZCaFhvSlVFbDFsMnFwemZmTjBEa1l0ZER5bDRseDBjalFq?=
 =?utf-8?B?Y3ZOY3B4OGFlclZ4MklwQ2Z3ZGN5MVA4Q3VLazNrWGVUNXQvVHluL2RTSi9p?=
 =?utf-8?B?aUxjQTl5NEF0YlF5Q0RtbXBNYkNSK0RGeWtPcUZ0eTZicGFPUXFEZXltQjRV?=
 =?utf-8?B?OUVzSmtRby9qcDVLNDdLRS8wVENFU0ZXODJPL2ppVDQ1bjJVc0NVOUJHaXYr?=
 =?utf-8?B?c0NOMHNaL1orVWpvcXhTdE10ckxQYjNnR215bmY1QVhCdTZPc1VzdGpUTk5M?=
 =?utf-8?B?T0JlelNyQ0VIME9uak5sQXIxZG04MlR6ZVRIN2RONVJ4SERMbTRvaHZlY0d0?=
 =?utf-8?B?TDZOVnVTQWtmV0h0MmdPa3NNSit6ZHViTWY0M3YrWExrdjRSU0lrbmFObDVl?=
 =?utf-8?B?MkkxaTJTYllkTCs1VW5MV1E2OUpMWWtjWFkxWlVHeWRjUUYxRnJqZml0OU96?=
 =?utf-8?B?bk4yK2tJU01rUFdwNXZReHE0U0RFYk9nTUk5OTRiSm1qOHNsM0NjdVBWdUdH?=
 =?utf-8?B?Unk4M1ZFcVExQndiUUUwaTEycWV3by9GKytiQ0xxMDFHYU9qTmJjcjNCMUsz?=
 =?utf-8?B?ckRTMXRDRjdwY1d5Vm0zZHV1Z1RzRzZvOThzMEdQbVhRRldZVUx3c0Fvb2ZZ?=
 =?utf-8?B?bVJLdHZQa2ZLcE1mcnpCSFpobVBsNFU0cFVOcFJ3SEphRG8yU29Rbkdlc2pw?=
 =?utf-8?B?Sk4wSDY0TXRSSGxRRHpjNWVOYStNWFBtS0ZYN05YWC9iNmhqRjN5b2ZaZGto?=
 =?utf-8?B?cTlnSVk2S3gxM210VW1iUkpZejNsSGFObDFkblMrVUpia01Galg0bkFPcmlI?=
 =?utf-8?B?cEJ6bXg1NXRnV0FKSkZCcCtaWlBwV2lKYUQ1MGcxUDg4amxnTncwS0NOL2Ux?=
 =?utf-8?B?S2hzY1VES0t4cGJaMTlWaVVvdFd2VkY5NWs2TTlZenlLWWpFZjUvOHlIU0xP?=
 =?utf-8?B?aXR2R0txQ3VqT1JrY1ZPeUhsRytka2xnQjhXUTU3T3pacDhoc25GQ1hOOW5x?=
 =?utf-8?B?QitYMVJSYUVHejN4NGtrUXJaQmNzQ0ViZllESDZhK2dsQXR1c05FOUdSbytN?=
 =?utf-8?B?dGt4U0ovYTJqbWEvd3A3VXM1MGhBYUh3TVV6VjZKdlRRS25ja0tweDZXbG41?=
 =?utf-8?B?R0krM1VFQlQ3TWhieDNpcGt2Z282S0s3MEFieWk5UHRDcEtkenZTa3hERG04?=
 =?utf-8?B?QUEwN1pEdm5VQmtndm40MTlCUi8yaWZRUWMyOXRBL2JickxFWFdoYmh2WlFy?=
 =?utf-8?B?SW0ydEYrQUVadzFMbjYxalR5WlMySGFSNDQvcWNHNE40M1Y2Y0pFMm8zMXJl?=
 =?utf-8?B?ZWhHaHlkK2ZiWFprQmNMd29VT0NqVVJSdytYNENZRkQ0Nk1OWXFNdG5KVEZl?=
 =?utf-8?B?bnB1VGR5cVRDOVdxK0tBU3FIczZnSWxnVWJ3SHI3aHF2RGVDcUtOcGVWd2la?=
 =?utf-8?B?bEFZWDAwaUpnbjlCcjlMZmZ6UEpiSHdvWEwwbEdXajhRcFhBS2hZeFIvRDBS?=
 =?utf-8?B?Yk12NmhkZEtxdTViLzFyaC8wN3V4ZlBmclBvUk1QemExWGpOZVgxUkdDZU5S?=
 =?utf-8?B?ck4ySGZlSVl6T21mL01QUXVVTEluVXp0YTcwclVaNkQyOHRxcnFqdkh0WTdu?=
 =?utf-8?B?OHM1K0tqM2swSkhqVmxXVTJ5UkNoUlo4a1BoVm5DNWdVd3p6ZHEzUkR2L0Rx?=
 =?utf-8?B?ZjdNQVNJTG0rTTc1dzEwUTU2c3JMaFMzMGtjeHQyQzd0Tk1ZeEJobXJsNVlr?=
 =?utf-8?B?MDBhZUl3WU9ZeUJCQmx5MC90d2paYy9sSFRrbHR5RkZ5MGpmYjdMdjRYemI2?=
 =?utf-8?B?NllKWnhZTkx5VC9kL1hWZ2lmald5TXFvN0xyNGFJN0FCTmJpREkyQVBkZEpa?=
 =?utf-8?B?ZW1BdFh0QTBhUm9IWCsvQTFWR0dHcWRUWkZyYVUwcWxSMUlBM3NjTmFndk9m?=
 =?utf-8?B?anN4UkZ0ekxWWTVIRitOSEQxZUIweFp3SlorUFAyc0t2NXBneHh6dWxndmQv?=
 =?utf-8?B?Z0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB4AA205EB13EE4799A9B84C0E5A6413@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2027b5-fce5-4523-d2f6-08da0208f0f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 20:11:04.8051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P+ZBves2jSmz4b57gCvmB/spks3FnZ5gKJIMH2ztHIWwuVHL4jQdhLQLoLayeDObUjNizYBVQP2K//NQojqHXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4948
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpbmggTmd1eWVuIHdyb3RlOg0KPiBIaSwNCj4gDQo+IFdlc2xleSBDaGVuZyB3cm90ZToNCj4+
IEZyb206IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCj4+DQo+PiBJ
ZiB0aGUgcmVxdWVzdCBiZWluZyBkZXF1ZXVlZCBpcyBjdXJyZW50bHkgYWN0aXZlLCB0aGVuIHRo
ZSBjdXJyZW50DQo+PiBsb2dpYyBpcyB0byBpc3N1ZSBhIHN0b3AgdHJhbnNmZXIgY29tbWFuZCwg
YW5kIGFsbG93IHRoZSBjb21tYW5kDQo+PiBjb21wbGV0aW9uIHRvIGNsZWFudXAgdGhlIGNhbmNl
bGxlZCBsaXN0LiAgVGhlIERXQzMgY29udHJvbGxlciB3aWxsDQo+PiBydW4gaW50byBhbiBlbmQg
dHJhbnNmZXIgY29tbWFuZCB0aW1lb3V0IGlmIHRoZXJlIGlzIGFuIG9uZ29pbmcgRVAwDQo+PiB0
cmFuc2FjdGlvbi4gIElmIHRoaXMgaXMgdGhlIGNhc2UsIHdhaXQgZm9yIHRoZSBFUDAgY29tcGxl
dGlvbiBldmVudA0KPj4gYmVmb3JlIHByb2NlZWRpbmcgdG8gcmV0cnkgdGhlIGVuZHhmZXIgY29t
bWFuZCBhZ2Fpbi4NCj4gDQo+IENhbiB5b3UgZml4IHRoZSBjb21taXQgbWVzc2FnZSBhcyBmb2xs
b3c6DQo+IA0KPiBJZiBhIFNldHVwIHBhY2tldCBpcyByZWNlaXZlZCBidXQgeWV0IHRvIERNQSBv
dXQsIHRoZSBjb250cm9sbGVyIHdpbGwNCj4gbm90IHByb2Nlc3MgdGhlIEVuZCBUcmFuc2ZlciBj
b21tYW5kIG9mIGFueSBlbmRwb2ludC4gUG9sbGluZyBvZiBpdHMNCj4gREVQQ01ELkNtZEFjdCBt
YXkgYmxvY2sgc2V0dGluZyB1cCBUUkIgZm9yIFNldHVwIHBhY2tldCwgY2F1c2luZyBhDQo+IGNv
bW1hbmQgdGltZW91dC4NCj4gDQo+IFRoaXMgbWF5IG9jY3VyIGlmIHRoZSBkcml2ZXIgZG9lc27i
gJl0IHNlcnZpY2UgdGhlIGNvbXBsZXRpb24gaW50ZXJydXB0IG9mDQo+IHRoZSBjb250cm9sIHN0
YXR1cyBzdGFnZSB5ZXQgZHVlIHRvIHN5c3RlbSBsYXRlbmN5LCB0aGVuIGl0IHdvbuKAmXQNCj4g
cHJlcGFyZSBUUkIgYW5kIHN0YXJ0IHRoZSB0cmFuc2ZlciBmb3IgdGhlIG5leHQgU2V0dXAgU3Rh
Z2UuIFRvIHRoZSBob3N0DQo+IHNpZGUsIHRoZSBjb250cm9sIHRyYW5zZmVyIGhhZCBjb21wbGV0
ZWQsIGFuZCB0aGUgaG9zdCBjYW4gc2VuZCBhIG5ldw0KPiBTZXR1cCBwYWNrZXQgYXQgdGhpcyBw
b2ludC4NCj4gDQo+IEluIHRoZSBtZWFud2hpbGUsIGlmIHRoZSBkcml2ZXIgcmVjZWl2ZXMgYW4g
YXN5bmMgY2FsbCB0byBkZXF1ZXVlIGENCj4gcmVxdWVzdCAodHJpZ2dlcmluZyBFbmQgVHJhbnNm
ZXIpIHRvIGFueSBlbmRwb2ludCwgdGhlbiB0aGUgZHJpdmVyIHdpbGwNCj4gc2VydmljZSB0aGF0
IEVuZCB0cmFuc2ZlciBmaXJzdCwgYmxvY2tpbmcgdGhlIGNvbnRyb2wgc3RhdHVzIHN0YWdlDQo+
IGNvbXBsZXRpb24gaGFuZGxlci4gU2luY2Ugbm8gVFJCIGlzIGF2YWlsYWJsZSBmb3IgdGhlIFNl
dHVwIHN0YWdlLCB0aGUNCj4gU2V0dXAgcGFja2V0IGNhbuKAmXQgYmUgRE1B4oCZZWQgb3V0IGFu
ZCB0aGUgRW5kIFRyYW5zZmVyIGdldHMgaHVuZy4NCj4gDQo+IFRoZSBkcml2ZXIgbXVzdCBub3Qg
YmxvY2sgc2V0dGluZyB1cCBvZiB0aGUgU2V0dXAgc3RhZ2UuIFNvIHRyYWNrIGFuZA0KPiBvbmx5
IGlzc3VlIHRoZSBFbmQgVHJhbnNmZXIgY29tbWFuZCBvbmx5IHdoZW4gdGhlcmXigJlzIFNldHVw
IFRSQiBwcmVwYXJlZA0KPiBzbyB0aGF0IHRoZSBjb250cm9sbGVyIGNhbiBETUEgb3V0IHRoZSBT
ZXR1cCBwYWNrZXQuIERlbGF5IHRoZSBFbmQNCj4gdHJhbnNmZXIgY29tbWFuZCB1bnRpbCB0aGVy
ZSdzIG5vIFNldHVwIFRSQiBhdmFpbGFibGUuIFRoaXMgaXMNCg0KdHlwbzoNCkRlbGF5IHRoZSBF
bmQgdHJhbnNmZXIgY29tbWFuZCAqaWYqIHRoZXJlJ3Mgbm8gU2V0dXAgVFJCIGF2YWlsYWJsZS4N
Cg0KDQo+IGFwcGxpY2FibGUgdG8gYWxsIERXQ191c2IzeCBJUHMuDQo+IA0KDQo=
