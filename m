Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687184E4A7D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 02:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237500AbiCWBcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 21:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiCWBcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 21:32:39 -0400
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE7F33E1C;
        Tue, 22 Mar 2022 18:31:09 -0700 (PDT)
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B937040C91;
        Wed, 23 Mar 2022 01:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1647999069; bh=EQzhXh2BzAhDXfSYATvvewI0mJ/vIZpuVph8tWX82+E=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=F4EXqbuqARVtf4K05nT5vDnkRyJR8ZbJgUl/KDRQTpIAW2jSqAdMlT8DfpSObFwXS
         6oYQ2iFgdih4mOOo9xxp/VCm3F4ezT8hdOYdezpKSlEZjGCd1JOC2rqke2oXhSCp78
         tTPnUM2VNQx+mJ1qkjOu2gEJ6VRMREul6EIVYkFKodinWthe1anftw3Vc9hC/HbuYz
         cP3xqGDfVcDM/Ushyw7fPfd/Uol3AIM96QvSaxCFgxhUb+xicVZXLY/E4Ce8gdYTug
         7w3i7xZydf0+T49UhnxBHA3XJtr/Zo5A+qSKmk3xSXQq9ztQ9mBrYKsXzGfVnNX7l2
         BXML99qx+IVKA==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 0880BA0080;
        Wed, 23 Mar 2022 01:31:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6425D40075;
        Wed, 23 Mar 2022 01:31:04 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="cWCf4Qdq";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3tksEGSaK2EAIK4gzlEzMbgjsFekrlNvGWMHKc4bMZ5RV83BNQ7hzHCPmcGlhCEr+dzCJGLBTEilxg4x9vaYokr6z3JvwAXAGxGcA5LydyPF8Nu6wZ96NoISHkPheDHEGKh2SvbyASNn/n9nehhNyjskkpW8kCnGFjAoqRC4gySrE0HKUoLUlAYQxtoIn8zzerFzg//FlvrsbeA6yaz8CP1Dz1mtGHI9Wi9j10KBUj2/oJ/n+p7Tgu49BTc+n+M5YG1pnd8JNGp3gyGPAuUraJDd8zaf2OzU/wi4Droqtk8cnNRsEaRqGCOa8zHSJmcv/2ZLnOh2cATQzAFkEXqfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQzhXh2BzAhDXfSYATvvewI0mJ/vIZpuVph8tWX82+E=;
 b=k2pRpaZrCOKiAdZlzYpo3HPAd2wQq4IGb68ARepqFPGTP+SJF0WbhAbwep0bM2b/einOI9CbXZ8plg5AGEEalpRlTwS3lVyYDGVGXNS1X9gsz6KlnI4grMUWgdVfzzW2cYg8DOd8inPHGrFHy2bliD6ndt3v8cN99mLtne9nXgh4QIHx0xUylkx+O4Ug4w8/5DQhvHA7NpJiLRSaTmA8Op3ByfzG9S2mCq8F0b22qPjKLY5nrGOPfUoIa8TOdD9Mvd+JCpEIvUjAYSZY6qqLei4eBzB2Ml6qrzyYq+vdYJLmmEG40rbrp5ZRUA3ID6CLiByd5gXY2RIVyICQ+qd1og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQzhXh2BzAhDXfSYATvvewI0mJ/vIZpuVph8tWX82+E=;
 b=cWCf4QdqJrSUT8LbEQKxh+uiN5S05upcAYadPGpUeOxc8PJcPWKkpoCCSukpYIfXrp1Mjw7Qs48QXFThfPWcfE9g00csRKthkZp05bck/evCgZhayG04sCQYRW00mv83wuSR3v1M+03KQoItXQg9CdGWlpj2mzLn7fvIJz98s5E=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.19; Wed, 23 Mar
 2022 01:31:01 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::141:3edf:164a:857b]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::141:3edf:164a:857b%4]) with mapi id 15.20.5081.023; Wed, 23 Mar 2022
 01:31:01 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [RFC PATCH v2 1/3] usb: dwc3: Flush pending SETUP data during
 stop active xfers
Thread-Topic: [RFC PATCH v2 1/3] usb: dwc3: Flush pending SETUP data during
 stop active xfers
Thread-Index: AQHYIsliuiq4as3hWE6r+TfikYnp1KzL7aoAgAB4EAA=
Date:   Wed, 23 Mar 2022 01:31:00 +0000
Message-ID: <26c82c13-d047-853e-12af-e916596c5c52@synopsys.com>
References: <20220216000835.25400-1-quic_wcheng@quicinc.com>
 <20220216000835.25400-2-quic_wcheng@quicinc.com>
 <eeee97bf-2987-3cfb-217e-42615d8d864b@codeaurora.org>
In-Reply-To: <eeee97bf-2987-3cfb-217e-42615d8d864b@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c44256cb-1566-453f-cc05-08da0c6cca29
x-ms-traffictypediagnostic: MN0PR12MB5977:EE_
x-microsoft-antispam-prvs: <MN0PR12MB5977B4256CAF271EE412245FAA189@MN0PR12MB5977.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EIhRAg9DsBMR1KkTEFgsxVxA8TETDrqf7Yzk0gXYp7tHjDUZcVEMtI1yjANg4vAbHwhd7AabLU67cJkrg1ftdRTE70G918SUX1ua5TjiIMqTXRcL3MGsOvsBKhiy3bjsx2gbJCnXB0QT4mL46yHln1ikE7i+Y8w0RSS+PmDDmaVL+achVob4Xn4fgUvrPV0JDUcXnQXO9HzT2za93UQGQ67ITkDicui3vlELBDovQ1BbsRD+VP7j6eWKI53alhBCc6ytU8T7mRsCgtbrksvA1qx1hEQdlBCeJuV+54no9wNOo9ee+0j05NbB4sz5U8/FbOro4Nm0S0DA+H4KGr0vM2Ki4NslhAIS/mxr4BPcLOJdmsfTLhJKqTr/wKBTUMMqLgkDQ39ZVos/4EDs5tx12QHdP3i0muelzPMu1viaQNWNbDkzyRFQyRkz86IL4wSDP5MkbRaHwv54Kcj34ckC5WK6WeMtNOoZd/shaAnJwbmWeHKt//ns9FO4bV2llcKvEBbZ0SplBUJBCDjsvhSnx9vDa5HLPXuhfflvyEQpjB4vkMd0Fb5MpVgUv6uVZUKo6ml6o+Au4oyZDIp2snIJJqsMUyyRJqNL4v+NGZDe+ayD4sKbEe2Jlxm0eFpOBjyiQGB8fnYyAb9XeSCZYzPp0+7wEKBKavXrJs2/dZIDI207b6+gQFvOihOk6TtmGR3tkmekAzh3nNiodkb1Kvi+AibzePUwfHHU3Z1+S87rH/ucLkGCasKNJCs7q9i8JlD5wHRaoct0SDi51Pvqhk46xw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(2906002)(110136005)(5660300002)(6486002)(6506007)(508600001)(71200400001)(86362001)(6512007)(316002)(31696002)(4326008)(83380400001)(53546011)(2616005)(76116006)(31686004)(8676002)(66946007)(66556008)(66476007)(66446008)(64756008)(38100700002)(36756003)(107886003)(38070700005)(122000001)(8936002)(186003)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXBiVnhRVnJhYTkvZlVBdEl4WjNBcG4vMmYvV3psdEdWbklxRVVzUTBpWFlh?=
 =?utf-8?B?WGtQb1Z0ckRpaS9mZ0RMaEc5WnoxRlF5TFdZRGpWbzdRd1NPUC9LcjdRUDd4?=
 =?utf-8?B?bVdwZzdMUVVIZUl4V0dnaW1pc2lCMGlXRXR2UDIxeDlpN1JtbjZDNE5mM2Mz?=
 =?utf-8?B?U01EVEVzSEpaOVZMZFJTYitHQXJyS0ljOW05SUVkVWpjZ210SktuRnBlNHJR?=
 =?utf-8?B?cUZ2YzBpcTF6WCtFT21ENnhhQ3VXNkZEcUNZYnp4WEc1ODk5ejBRUldiVFZI?=
 =?utf-8?B?SWdFMThnd0NNVTVHZUVaMGc3aHpaZVVJNmV5SkU3VGg5TzVEK014S1luUzB1?=
 =?utf-8?B?NHVvZzZUd0JGZldxWlUrQmpNS3MxdzY3VGV4K2ZUOUxKQ1hnODNlKzhZMEl3?=
 =?utf-8?B?cy8yV2RaN1U2cjY3dUMwVE0zdWhTVjVza2dtU1ViU2V1b2hqb3dSaTVrWDF1?=
 =?utf-8?B?SE16RHZWNHlrOTN0OHN0YmQ2b0NVWFdVVkZwNTVFT1laOTN2VXNtTEwyRkFr?=
 =?utf-8?B?ME1qWUJTbEJzVzJSN3NwbDRMTUpmcFhuOFJRMTJlNkhFZTE3bEsvZEZwQjN1?=
 =?utf-8?B?U0Y0Z2d3NDg1cWIzcDQrTU1IYkwwcktRRld3TjZybXB4NXU2amludHA1OU1k?=
 =?utf-8?B?V0g5dTZIeW44cEgrZWs1NjB6SUxHQjFOVTBYdmxST3lWSHpJNm8wdFd0UlpH?=
 =?utf-8?B?MWMzVWpqclYxTG81anNKZEs3blE4MzNJUzRtdWJyaGZ2b003cWQwS3d3MTMx?=
 =?utf-8?B?NmVXMFFVcU03N1Q4eER0dUxZeU9ja3orQXNIZnJ0MkJwTnlxSlFBZzlxeVRR?=
 =?utf-8?B?dFZvTUl4VjJqVEVSNjE1Mmt1MEMzUWRJWUpqSzAvRlNwWC9obmJlODA0Kzd3?=
 =?utf-8?B?cTY2eWUrcjRoajlxdkFjVkdDUEtQOUcvNHFoRFN3am9JKzQyeXRKQlR5ZVMy?=
 =?utf-8?B?OFdybStwOU1OS0JJQWRsUDB0MjNZSFU1aTMzUHB3cWtnNGZ4UmVRSHNnSFNN?=
 =?utf-8?B?blZuK29IbEpOek5zUnRHbS9UeGtZclBTUzc1UkEvak90RTYzU3hldVBHYnF4?=
 =?utf-8?B?M0xqL1RNUHhaREowYU1Qd2YxczJkL1BNY3lsc2ttT3ExM0x4M3VDQVBOdlJr?=
 =?utf-8?B?RGdOanE3b2haNXZrWmR2T2hoNjg5RHpvZ0I3NFd1YWk2dWRDcFpHcDNBVEVS?=
 =?utf-8?B?THV3VEFyYU5WVmRFVEVlZ0pUdTBMUmZtRktZbEQ1Q0Z1clFhMlF1SFEvdy9W?=
 =?utf-8?B?NjhZQURzdlJ5ZHpLK2lnSjRQZ0IwUHBwVUI2NkxRYXNhVVQ4TkdBTEpOckxX?=
 =?utf-8?B?eGJBZ09ObGQ5SlJPYk5NbW16dGprU2VGZ3I5dXROSWNGc0pYdG95YzBRd3Jx?=
 =?utf-8?B?YmlWeGNlU2ZZRHAzMGlEaUdZMlc2NVVZTGNnVnFrd2NjT1B5OXloSXZ2T3l0?=
 =?utf-8?B?TGJzaVI0OUtwdnN5WCtUWkk1c2FWOW1LNGNKK2o1anZ2RlhMTzN3UityczNx?=
 =?utf-8?B?ODN6MllxM3ZIZWpqUXBVRWQraHZ3U0xzT2tCNkJFd2V1aWNTUFhxbURVUGxB?=
 =?utf-8?B?cUNGeWNQbXR6K3NhSmQ3T2VZeWxFRnZtcm5IbTdOSGt6MUw5L2V1WFIyNXcv?=
 =?utf-8?B?M0RvUnJtcThQMjlwU0lWTVhzQ293eXVOT0dRN0VZYi8rYWR4SlNkK0NzZ0JT?=
 =?utf-8?B?STBOeGFRQjA2eFJNNGpLb2s5dGJzRlluOUgzLytDcVNLWmlaV1duVTJtbDd2?=
 =?utf-8?B?UGtvcVdpb0I4QXoxOEFrUTk2akRiSkJTcndMdnE5VXZTajNaUHYxZHlzaWRO?=
 =?utf-8?B?UnVyc0hWeEt4QnpJaXpueFlOYWJmSE5IVDBnRWMzNHJDMFp5VEFrVy9RTXJG?=
 =?utf-8?B?MXAwR2FCZ1lLemlweExHVUY2T2NDemtTWndhTUlFdkFXbTVZMjFxZ3B3b2Q1?=
 =?utf-8?Q?9klwSwmqYDyUUXk7lxV0Ojndj2/IpaZg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <08C6C7B111D7364BA5295137F6BD2F8F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c44256cb-1566-453f-cc05-08da0c6cca29
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2022 01:31:00.5491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uSnpLsMo8hLssSdEmM9Fzi+qvni1ZzYOG28+BLx0fpGrY+Njkve1mMcRzEWDnjXj5HHJOhXPuyyLUC4k4t+udA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5977
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgV2VzbGV5LA0KDQpXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+IEhpIFRoaW5oLA0KPiANCj4gT24g
Mi8xNS8yMDIyIDQ6MDggUE0sIFdlc2xleSBDaGVuZyB3cm90ZToNCj4+IFdoaWxlIHJ1bm5pbmcg
dGhlIHB1bGx1cCBkaXNhYmxlIHNlcXVlbmNlLCBpZiB0aGVyZSBhcmUgcGVuZGluZyBTRVRVUA0K
Pj4gdHJhbnNmZXJzIHN0b3JlZCBpbiB0aGUgY29udHJvbGxlciwgdGhlbiB0aGUgRU5EVFJBTlNG
RVIgY29tbWFuZHMgb24gbm9uDQo+PiBjb250cm9sIGVwcyB3aWxsIGZhaWwgdy8gRVRJTUVET1VU
LiAgQXMgYSBzdWdnZXN0aW9uIGZyb20gU05QUywgaW4gb3JkZXINCj4+IHRvIGRyYWluIHBvdGVu
dGlhbGx5IGNhY2hlZCBTRVRVUCBwYWNrZXRzLCBTVyBuZWVkcyB0byBpc3N1ZSBhDQo+PiBTVEFS
VFRSQU5TRkVSIGNvbW1hbmQuICBBZnRlciBpc3N1aW5nIHRoZSBTVEFSVFRSQU5TRkVSLCBhbmQg
cmV0cnlpbmcgdGhlDQo+PiBFTkRUUkFOU0ZFUiwgdGhlIGNvbW1hbmQgc2hvdWxkIHN1Y2NlZWQu
ICBFbHNlLCBpZiB0aGUgZW5kcG9pbnRzIGFyZSBub3QNCj4+IHByb3Blcmx5IHN0b3BwZWQsIHRo
ZSBjb250cm9sbGVyIGhhbHQgc2VxdWVuY2Ugd2lsbCBmYWlsIGFzIHdlbGwuDQo+Pg0KPj4gT25l
IGxpbWl0YXRpb24gaXMgdGhhdCB0aGUgY3VycmVudCBsb2dpYyB3aWxsIGRyb3AgdGhlIFNFVFVQ
IGRhdGENCj4+IGJlaW5nIHJlY2VpdmVkIChpZSBkcm9wcGluZyB0aGUgU0VUVVAgcGFja2V0KSwg
aG93ZXZlciwgaXQgc2hvdWxkIGJlDQo+PiBhY2NlcHRhYmxlIGluIHRoZSBwdWxsdXAgZGlzYWJs
ZSBjYXNlLCBhcyB0aGUgZGV2aWNlIGlzIGV2ZW50dWFsbHkNCj4+IGdvaW5nIHRvIGRpc2Nvbm5l
Y3QgZnJvbSB0aGUgaG9zdC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBXZXNsZXkgQ2hlbmcgPHF1
aWNfd2NoZW5nQHF1aWNpbmMuY29tPg0KPj4gLS0tDQo+IEp1c3Qgd29uZGVyaW5nIGlmIHlvdSBo
YWQgYW55IGlucHV0cyBmb3IgdGhpcyBwYXJ0aWN1bGFyIGNoYW5nZT8gIEkNCj4gdGhpbmsgb24g
dGhlIGRlcXVldWUgcGF0aCBkaXNjdXNzaW9uIHlvdSBoYWQgc29tZSBjb25jZXJucyB3aXRoIHBh
cnRzIG9mDQo+IHRoaXMgY2hhbmdlPyAgSSB0aGluayB0aGUgZGlmZmljdWx0IHBhcnQgZm9yIHRo
ZSBwdWxsdXAgZGlzYWJsZSBwYXRoIGlzDQo+IHRoYXQgd2UgaGF2ZSB0aGlzIEFQSSBydW5uaW5n
IHcvIGludGVycnVwdHMgZGlzYWJsZWQsIHNvIHRoZSBFUDAgc3RhdGUNCj4gd29uJ3QgYmUgYWJs
ZSB0byBhZHZhbmNlIGNvbXBhcmVkIHRvIHRoZSBkZXF1ZXVlIGNhc2UuDQoNClRoaXMgZG9lc24n
dCBzb3VuZCByaWdodC4gVGhlIHB1bGx1cCBkaXNhYmxlIChvciBkZXZpY2UgaW5pdGlhdGVkDQpk
aXNjb25uZWN0KSBzaG91bGQgd2FpdCBmb3IgdGhlIEVQMCBzdGF0ZSB0byBiZSBFUDBfU0VUVVBf
UEhBU0UgYmVmb3JlDQpwcm9jZWVkaW5nLCB3aGljaCBpdCBkb2VzLg0KDQo+IA0KPiBJZGVhbGx5
LCBpZiB0aGVyZSBpcyBhIHdheSB0byBlbnN1cmUgdGhhdCB3ZSBhdm9pZCByZWFkaW5nIGZ1cnRo
ZXIgc2V0dXANCj4gcGFja2V0cywgdGhhdCB3b3VsZCBiZSBuaWNlLCBidXQgZnJvbSBvdXIgZGlz
Y3Vzc2lvbnMgd2l0aCBTeW5vcHN5cywNCj4gdGhpcyB3YXMgbm90IHBvc3NpYmxlLiAoY29udHJv
bGxlciBpcyBhbHdheXMgYXJtZWQgYW5kIHJlYWR5IHRvIEFDSw0KPiBzZXR1cCB0b2tlbnMpDQo+
IA0KPiBJIGRpZCBldmFsdWF0ZSBrZWVwaW5nIElSUXMgZW5hYmxlZCBhbmQgcGVyaW9kaWNhbGx5
IHJlbGVhc2luZy9hdHRhaW5pbmcNCj4gdGhlIGxvY2sgYmV0d2VlbiB0aGUgc3RvcCBhY3RpdmUg
eGZlciBjYWxscywgYnV0IHRoYXQgb3BlbmVkIGFub3RoZXIgY2FuDQo+IG9mIHdvcm1zLiAgSWYg
eW91IHRoaW5rIHRoaXMgaXMgdGhlIGFwcHJvYWNoIHdlIHNob3VsZCB0YWtlLCBJIGNhbiB0YWtl
DQo+IGEgbG9vayBhdCB0aGlzIGltcGxlbWVudGF0aW9uIGZ1cnRoZXIuDQo+IA0KDQpUaGlzIHBh
dGNoIGRvZXNuJ3QgbG9vayByaWdodCB0byBtZS4gVGhlIGNoYW5nZSBJIHN1Z2dlc3RlZCBiZWZv
cmUNCnNob3VsZCBhZGRyZXNzIHRoaXMgKEkgYmVsaWV2ZSBHcmVnIGFscmVhZHkgcGlja2VkIGl0
IHVwKS4gV2hhdCBvdGhlcg0KcHJvYmxlbSBkbyB5b3Ugc2VlLCBJJ20gbm90IGNsZWFyIHdoYXQn
cyB0aGUgcHJvYmxlbSBoZXJlLiBPbmUgcG90ZW50aWFsDQpwcm9ibGVtIHRoYXQgSSBjYW4gc2Vl
IGlzIHRoYXQgY3VycmVudGx5IGR3YzMgZHJpdmVyIGRvZXNuJ3Qgd2FpdCBmb3INCmFjdGl2ZSBl
bmRwb2ludHMgdG8gY29tcGxldGUvZW5kIGJlZm9yZSBjbGVhcmluZyB0aGUgcnVuX3N0b3AgYml0
IG9uDQpkZXZpY2UgaW5pdGlhdGVkIGRpc2Nvbm5lY3QsIGJ1dCBJJ20gbm90IHN1cmUgaWYgdGhh
dCdzIHdoYXQgeW91J3JlIHNlZWluZy4NCg0KUGxlYXNlIGhlbHAgY2xhcmlmeSBmdXJ0aGVyLiBJ
ZiB0aGVyZSdzIHRyYWNlIHBvaW50cyBsb2csIHRoYXQnZCBoZWxwLg0KDQpUaGFua3MsDQpUaGlu
aA0K
