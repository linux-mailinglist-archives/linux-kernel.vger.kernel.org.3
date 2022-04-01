Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD024EF163
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 16:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236392AbiDAOgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 10:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347514AbiDAOdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 10:33:02 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43001EFE1C;
        Fri,  1 Apr 2022 07:29:18 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 231EObkA027682;
        Fri, 1 Apr 2022 10:28:57 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3f5vb2tg00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 10:28:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkzKm4IE5fWzlSOEw9m/mz0cJU1PVIHcNtGb561GioVk74vgbyZps/YnanZe2e0c18g9/mu6MYcugApabdfMO9tdBC9lmqqmOakMtYZlNq1g3AVZ04YwLA3v8TdwRexcK/nriKGeddHAR4bv2wOqDQTjgH/XjL6mqU8Sm07LZIixnkvyz5jk7NSsV2BGYBdK2FH10D+6PGDeY5L7hOcXxu9i1Ak7rbFEFlZVuV2ImtQACIEPpF1ItBQ63zhUXntpjXSoRP4lOMH+sc9SZofEhNoDcKFQ7Cjn/bMMGKX1LA8YdmVkEcX0uO9IM1T79B1MBA2DXoqruTc/0i3TXWydLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwQmgs3idjcMcZTPmL46tuHcsYbL+aT5UMn2oYOW+dg=;
 b=RhMtw2Hgg5oUgRnGTsFw9VgAiOXyOuDlPD/rdocAPsjHOcGzMC9MiJO1C8q6fTV3+R9T1ww7ZFapMLdcRqnBdJ4jCy0zfKazJo2q/p/3rxveguX86rK6WjfINK6U0BeVu9ZpfeVogHq+zus7V/B3oSJVcltxns/VCf6D1i3yxB+8qHBWS1AhmEzGT8qjw87k4CvxkpH4x8ZS2LfxdKgd6yx0Luf9CW5GTvMwoHt4AmrTcnQjelGH0LOEY4yuExwF+98wm53JhsTcd/14DHbJ8hyvhoQhU1K2dch5FUijlpELprFCoO/UK9dtUy9mTFaoIwm0+zWaIhSJnk/0fyjYgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwQmgs3idjcMcZTPmL46tuHcsYbL+aT5UMn2oYOW+dg=;
 b=ZffqPgTlwc7TuFGJzLwjRtZRCOUWcaZRWYeILLWdiBg2gsGd19RhAWbYYxbATq+5tBtFbctRmZifMjE1f+99yF1qF9ptgx1cOFC+IowGAcC3zqVIxnLGZ8vskb3DiGpOcJ3k1rmTdiAM0zFvrlCDGsiB6K0qL2dSfE4x10Y3pnU=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by MWHPR03MB3118.namprd03.prod.outlook.com (2603:10b6:301:41::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.25; Fri, 1 Apr
 2022 14:28:55 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a97e:a520:c3a6:d2ae]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a97e:a520:c3a6:d2ae%7]) with mapi id 15.20.5123.026; Fri, 1 Apr 2022
 14:28:55 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jakob Koschel <jakobkoschel@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: RE: [PATCH 1/3] iio: buffer: remove usage of list iterator variable
 for list_for_each_entry_continue_reverse()
Thread-Topic: [PATCH 1/3] iio: buffer: remove usage of list iterator variable
 for list_for_each_entry_continue_reverse()
Thread-Index: AQHYRVQV9kI4j3Bv9UurRvFtBWTQEaza/lWwgAAXQgCAAAelgA==
Date:   Fri, 1 Apr 2022 14:28:55 +0000
Message-ID: <PH0PR03MB678669ED4B09B611DE39214F99E09@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220331230632.957634-1-jakobkoschel@gmail.com>
 <PH0PR03MB6786326401D38B60141CAC9799E09@PH0PR03MB6786.namprd03.prod.outlook.com>
 <80A5A418-FBBE-47BF-ACFF-0470027875F6@gmail.com>
In-Reply-To: <80A5A418-FBBE-47BF-ACFF-0470027875F6@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE1HUmlNVEV6WWpZdFlqRmpPQzB4TVdWakxUaGlaRFV0Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGbFhHRnRaUzEwWlhOMFhEQmtZakV4TTJJNExXSXhZemd0TVRGbFl5MDRZ?=
 =?utf-8?B?bVExTFdaak56YzNOREl4Wm1OaFpXSnZaSGt1ZEhoMElpQnplajBpTlRNd05p?=
 =?utf-8?B?SWdkRDBpTVRNeU9UTXlPVFk1TXpNek1UTXdNRE15SWlCb1BTSXdVMnR3Tmps?=
 =?utf-8?B?eE9ERlRUelpTZDBvelMxUTNhVTlxV0ZOYVdrRTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVRjNRWGR5VVRGRldGbEJXWGxPTUV0RVJGUjZNMDVxU1ROUmIw?=
 =?utf-8?B?MU9VRkJqTUVSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkVZVUZSUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRVlpKUlhadlVVRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
 =?utf-8?B?bWhCUjFGQllWRkNaa0ZJVFVGYVVVSnFRVWhWUVdOblFteEJSamhCWTBGQ2VV?=
 =?utf-8?B?RkhPRUZoWjBKc1FVZE5RV1JCUW5wQlJqaEJXbWRDYUVGSGQwRmpkMEpzUVVZ?=
 =?utf-8?B?NFFWcG5RblpCU0UxQllWRkNNRUZIYTBGa1owSnNRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkZRVUZCUVVGQlFVRkJRV2RCUVVG?=
 =?utf-8?B?QlFVRnVaMEZCUVVkRlFWcEJRbkJCUmpoQlkzZENiRUZIVFVGa1VVSjVRVWRW?=
 =?utf-8?B?UVZoM1FuZEJTRWxCWW5kQ2NVRkhWVUZaZDBJd1FVaE5RVmgzUWpCQlIydEJX?=
 =?utf-8?B?bEZDZVVGRVJVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCVVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVOQlFVRkJRVUZEWlVGQlFVRlpVVUpyUVVkclFWaDNRbnBCUjFWQldY?=
 =?utf-8?B?ZENNVUZJU1VGYVVVSm1RVWhCUVdOblFuWkJSMjlCV2xGQ2FrRklVVUZqZDBK?=
 =?utf-8?B?bVFVaFJRV0ZSUW14QlNFbEJUV2RCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFrRkJRVUZCUVVGQlFVRkpRVUZCUVVGQlFUMDlJaTgrUEM5dFpYUmhQZz09?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 633d242f-7032-415e-2bce-08da13ebf39e
x-ms-traffictypediagnostic: MWHPR03MB3118:EE_
x-microsoft-antispam-prvs: <MWHPR03MB31187127C39E5B1EA7DD4F1099E09@MWHPR03MB3118.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Tg7LAXnMGSk9RqDsVmdPcvIG9Iow0AY1yaNTmxdrni9eGStEoTgr7ljeaa+2bhu7i5Goo+FX4KIklZCsvnaSl2OxkoTjXeIjhk/VOglRpSwENy58x1lOIb07waJ4pcOorc1Zg7aF2bxTyOg9lD5wZpZ+c8yU1QDT12w1r/rUCAyP3ZYLSsT3Na4+XZPzum/yu0kozoOeG8R+0o0TaKoExmb12MTCX7uC6tqYY29OjaY6g0B1PiS25cIOy5uPCkAwKYf+5mbo5qDCMD89LQmBcCFiNtrrcSa5AYkdpk92pIZqbv+7hVBDgyQ0ftN0CmVukgqi26dYEKToMHeJ6IVV9vqWF5QdsBJt46Wnnb+iBvpfzVA4UvyMUMLVhsQZVAUFTaihsSVgjdna0z9drxLhWm5Pa1UxD9RdeiwwWptyRLAvRkqAHnuu44IusA6rhgTLv4s1PYtwRNIgCJWzg8vXZCqMyu+WNdCmimioE1G6Q3QTZ92TKqNEhnkOwjh2gAJjHzVdSakWrsTh0bQ414xABuBjuA5QUd5p84Wmx074D3NaQXQNOJ9w0zjm/8p5E/zRLG27vG3jTxwlD55YxGcCabe5fnztBTM0iqDJ2OYQqx85IJ14pYpnuWibhhEx0M5q8nzqybSLLknL83PaXdbhSYkHDhr2suX8YQxdKs5EDnXdVl3weGR3DaOv9/spwkGhiUv4rW5hEndBYueMWfGM5KoA2pXO97XQoCHFdssoYsOEEW9ul06/yLPeuDDH0dZWYHR+LsoPMUjz4wNnRxV/9eRezW5OwdjMvSpNx/ULSQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(83380400001)(38070700005)(186003)(2906002)(122000001)(966005)(8936002)(76116006)(52536014)(7416002)(508600001)(86362001)(5660300002)(71200400001)(4326008)(8676002)(54906003)(9686003)(38100700002)(6916009)(66446008)(66476007)(66556008)(55016003)(66946007)(53546011)(7696005)(6506007)(33656002)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnZ3VXRKV3JIV3VYVzEvYW0vZ3dlMTNDRldqZk9QcURrejZGU0xqRjJxUEJE?=
 =?utf-8?B?Z29VMWpqcCtWUjhJdURvSllwQUZtc3FMM1ZGRFpXT0pzL2sxYnNiMDhoeW1B?=
 =?utf-8?B?bi80MmFLbGpMNE5pQVVMN2gvMWR3N2pCaUwzSS9HWi8vY3Q3RXc3WnptdWE3?=
 =?utf-8?B?VEl0UlNpTVB0MXhuVDZicDJWVUEvZDBvMUVZUlRLRk82KzRtcWFGcHlhNDAr?=
 =?utf-8?B?UTVtZS92M3NCOG9pY003bHJmMXQ5Rk14cmJRVVl1ZDF2blRUYTBnN3RBY1R2?=
 =?utf-8?B?QVZ5aTdieEExNkFvOERSUjBhQU5lWW1xa3VmRUtjK20vdUljSnYvbUY4UWtp?=
 =?utf-8?B?TmRzdmU5WWVKRmc5S3ZIUUEweXZQTnlpVFl2RGFIdTJrelZUb0pHdW5ZOGFh?=
 =?utf-8?B?Z3hMZXZSK253RkI2Zkc0ZmFBa2x2ZjRyUGwzeG5sZ1NMTWU3VGwxZW9la0hk?=
 =?utf-8?B?ZUw4TGFveVFDNXhuZHcwU3dlN1p4VEYwdFREUTdoWjBxcEFNVElNRmM1YlAx?=
 =?utf-8?B?ZHVwUHBTM2krU0JIdmNYWVFZeWZRdU04dHo5SE1yVENydHplWFVGRXllYVVa?=
 =?utf-8?B?WkVLZXVUaWJ0eWJxU28vMzQyQWFwakZtU0k3bjQ2dUpEWiszdXQ4UE9Bdkcw?=
 =?utf-8?B?L2xhRlIzdXc0VlhDcDJGcGxiS1V5Z2Y4SUtPSHRhWUJScUtkU3g5TkROOXpQ?=
 =?utf-8?B?NGdCMGJSKzloN3J4czhIeFhxT3hTMXpMMEgyazl4WWpJRE5JdnhhMkszT21k?=
 =?utf-8?B?cXpHTmRKVk5hL25PM2MzY2tDWC9tZ2tESjNJSEpMRVdWdi9NeUkzMnZ3TUVs?=
 =?utf-8?B?RWo2eElicW1ZMEtza0ZSZFk2clpqVHBqVkxZOU91M05yMC9MZVJCZ1hXT1dC?=
 =?utf-8?B?ekNqaTJBOTFlOS9lTWMyR1dDZVQzVVBNK2NZaXhpSDJtT2NRajlpK3BCTWw1?=
 =?utf-8?B?bHJmWEVhOThTaEhMbERHVkpIR3JOU0JCU3VFY1dRcGxsNVQrTFk2T0VPWVlW?=
 =?utf-8?B?Z1dyc2o3L212cjdEdVJJSFNFT09ia2VRQzBEK0JzYXprNmFKb3EvY0RoLytx?=
 =?utf-8?B?UG5TcHRGYjNqWllMejZUVU1rdXJFQjdIK3RIQ3ZoVXUreUFMNCsvYnJHNFU4?=
 =?utf-8?B?Q1VkemhrTXFQY3Vmc3JLZWZ1dSt1dm1Ob0hTaTVXbzFxb3NzTnNtbjJaU2lI?=
 =?utf-8?B?SjRzVDZMaHF4Tm1vUzB3K3N6RytpSUJoeVYwNERDcDdHQTFtb0J0RDZFTTlT?=
 =?utf-8?B?L0djTkgyUjVSNXlIT0E1b3g1VGZuMW9XeXU2MFNZb05QcTdrT0h3eGJCN2hn?=
 =?utf-8?B?R0RKR1J0UkE2U2VyUmhFaW9VOGQwYnhHVDJKQUIySldLY0IwcHFMSXp6N1Ro?=
 =?utf-8?B?aHgyQjJtOVlyWllLLy91SkJtRXd2L0ZraGc1MUdXTVA1UUY2dHpsMk1qSllP?=
 =?utf-8?B?U2VFMlhIb0xxRnVZR2tIaGZnYmt0UG95Z21Pd29pZjFUYWZYOG40aHM1Kzhw?=
 =?utf-8?B?Wm9hTzVGd2FObmZnY3VleWh2eEdKZWlBMzZhNUg1M1pNdzN6aHFZN3dwY3Er?=
 =?utf-8?B?ZnBwak82dGtYa041OWl1Wi9CekRPYVM4OG45SDVMRDJYYmFsUWZaMVpZWHNM?=
 =?utf-8?B?UHZtT1pFYU8yVUE1cWlTNFJncmRQTm50NUw3YXRRQ0NaNlJaWDZwVHlScmt3?=
 =?utf-8?B?Mi9USmFoN2JSd0RLa3FaN3lUUHNkNmliMEZLWE5Sb0FWdFZkek04dENpUUVs?=
 =?utf-8?B?ck5UUUY2dzFRL0FrNVRmRGhtZ2lTblhGTXpzcC85a3dSdDJuMm5KOFA2cm5k?=
 =?utf-8?B?dFpYczFmSWZYNVBtdHBJcVA5VUtiMGJudHFCdWgwMFZxVTE5UGNPWlNBUHE1?=
 =?utf-8?B?dEdsY1F3eSt0U1ZJendsYjBZZ3c5Y3B2Z2ZadGJrYWdvQTRnWVZqN3V2ek9N?=
 =?utf-8?B?MG9BckRuZ1hMc1ZFbERVRi9MWmNtcW9jTHdxS1dyaW1BVld2aHhkZjV0T0s5?=
 =?utf-8?B?V0paeU0rRUNpdW1DV2MwZFJnK2RRaURiZG1PYU8wSnZUcWI2QzZnUWFmTnQy?=
 =?utf-8?B?Z3dKdm9qajg4UkYyYlozakdQekhmVVhSRGc2TTJGdzBkU28zWElHbzFvQ3Zq?=
 =?utf-8?B?N2lYNC8wbEMzR0x1Nm54ZEZCOTRiQTF6aFZUdDB1OGlEWUN4REhHWDcyT2Vu?=
 =?utf-8?B?OGZiMm9ZeDA2ZVliMjdNWlU5RTN6aFZmc2lWMzhjSG1pbm91UytOdEhRZE9u?=
 =?utf-8?B?cFdWb0txMU9OL2NTa3ljVXlCekVzT296MENJRFhRNG1xQm9scmd5dnp0Z0o4?=
 =?utf-8?B?SjczM0IwRkZ0Uks5NEJpZnliVHNxQ1k5a1lvSkNEdmg0Nld1L013WER0NnAy?=
 =?utf-8?Q?4Y5qKy+LPkTYD+yhOAG+ToDQOm0NHjfV6YeSn+ZuxJQ9D?=
x-ms-exchange-antispam-messagedata-1: F2zhGSM/PLzp6w==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 633d242f-7032-415e-2bce-08da13ebf39e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 14:28:55.1037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fpfpkuj+sk5Yz+UISOVfjK2J5801DXN1y02EktsNg6MikYlw+aSO86r1A0dcXAFUZ4B1LNykpWD0AGWelXSF9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3118
X-Proofpoint-GUID: OEnmpaoRDg5DXqIEerJyWcS2kr9hj-vj
X-Proofpoint-ORIG-GUID: OEnmpaoRDg5DXqIEerJyWcS2kr9hj-vj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-01_05,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204010068
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IEZyb206IEpha29iIEtvc2NoZWwgPGpha29ia29zY2hlbEBnbWFpbC5jb20+DQo+IFNlbnQ6
IEZyaWRheSwgQXByaWwgMSwgMjAyMiAzOjU1IFBNDQo+IFRvOiBTYSwgTnVubyA8TnVuby5TYUBh
bmFsb2cuY29tPg0KPiBDYzogSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz47IExh
cnMtUGV0ZXIgQ2xhdXNlbg0KPiA8bGFyc0BtZXRhZm9vLmRlPjsgRGFuIENhcnBlbnRlciA8ZGFu
LmNhcnBlbnRlckBvcmFjbGUuY29tPjsNCj4gbGludXgtaWlvQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgTWlrZQ0KPiBSYXBvcG9ydCA8cnBwdEBrZXJuZWwu
b3JnPjsgQnJpYW4gSm9oYW5uZXNtZXllcg0KPiA8YmpvaGFubmVzbWV5ZXJAZ21haWwuY29tPjsg
Q3Jpc3RpYW5vIEdpdWZmcmlkYQ0KPiA8Yy5naXVmZnJpZGFAdnUubmw+OyBCb3MsIEguSi4gPGgu
ai5ib3NAdnUubmw+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8zXSBpaW86IGJ1ZmZlcjogcmVt
b3ZlIHVzYWdlIG9mIGxpc3QgaXRlcmF0b3INCj4gdmFyaWFibGUgZm9yIGxpc3RfZm9yX2VhY2hf
ZW50cnlfY29udGludWVfcmV2ZXJzZSgpDQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiANCj4gDQo+
ID4gT24gMS4gQXByIDIwMjIsIGF0IDE0OjQwLCBTYSwgTnVubyA8TnVuby5TYUBhbmFsb2cuY29t
PiB3cm90ZToNCj4gPg0KPiA+IEhpIEpha29iLA0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+ID4+IEZyb206IEpha29iIEtvc2NoZWwgPGpha29ia29zY2hlbEBnbWFpbC5j
b20+DQo+ID4+IFNlbnQ6IEZyaWRheSwgQXByaWwgMSwgMjAyMiAxOjA3IEFNDQo+ID4+IFRvOiBK
b25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPg0KPiA+PiBDYzogTGFycy1QZXRlciBD
bGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+OyBEYW4gQ2FycGVudGVyDQo+ID4+IDxkYW4uY2FycGVu
dGVyQG9yYWNsZS5jb20+OyBKYWtvYiBLb3NjaGVsDQo+ID4+IDxqYWtvYmtvc2NoZWxAZ21haWwu
Y29tPjsgbGludXgtaWlvQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+ID4+IGtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IE1pa2UgUmFwb3BvcnQgPHJwcHRAa2VybmVsLm9yZz47IEJyaWFuDQo+ID4+
IEpvaGFubmVzbWV5ZXIgPGJqb2hhbm5lc21leWVyQGdtYWlsLmNvbT47IENyaXN0aWFubw0KPiBH
aXVmZnJpZGENCj4gPj4gPGMuZ2l1ZmZyaWRhQHZ1Lm5sPjsgQm9zLCBILkouIDxoLmouYm9zQHZ1
Lm5sPg0KPiA+PiBTdWJqZWN0OiBbUEFUQ0ggMS8zXSBpaW86IGJ1ZmZlcjogcmVtb3ZlIHVzYWdl
IG9mIGxpc3QgaXRlcmF0b3INCj4gdmFyaWFibGUNCj4gPj4gZm9yIGxpc3RfZm9yX2VhY2hfZW50
cnlfY29udGludWVfcmV2ZXJzZSgpDQo+ID4+DQo+ID4+IFtFeHRlcm5hbF0NCj4gPj4NCj4gPj4g
SW4gcHJlcGFyYXRpb24gdG8gbGltaXQgdGhlIHNjb3BlIG9mIHRoZSBsaXN0IGl0ZXJhdG9yIHZh
cmlhYmxlIHRvIHRoZQ0KPiA+PiBsaXN0IHRyYXZlcnNhbCBsb29wLCB1c2UgYSBkZWRpY2F0ZWQg
cG9pbnRlciB0byBpdGVyYXRlIHRocm91Z2ggdGhlDQo+ID4+IGxpc3QgWzFdLg0KPiA+Pg0KPiA+
PiBTaW5jZSB0aGF0IHZhcmlhYmxlIHNob3VsZCBub3QgYmUgdXNlZCBwYXN0IHRoZSBsb29wIGl0
ZXJhdGlvbiwgYQ0KPiA+PiBzZXBhcmF0ZSB2YXJpYWJsZSBpcyB1c2VkIHRvICdyZW1lbWJlciB0
aGUgY3VycmVudCBsb2NhdGlvbiB3aXRoaW4NCj4gdGhlDQo+ID4+IGxvb3AnLg0KPiA+Pg0KPiA+
PiBUbyBlaXRoZXIgY29udGludWUgaXRlcmF0aW5nIGZyb20gdGhhdCBwb3NpdGlvbiBvciBzdGFy
dCBhIG5ldw0KPiA+PiBpdGVyYXRpb24gKGlmIHRoZSBwcmV2aW91cyBpdGVyYXRpb24gd2FzIGNv
bXBsZXRlKQ0KPiBsaXN0X3ByZXBhcmVfZW50cnkoKQ0KPiA+PiBpcyB1c2VkLg0KPiA+Pg0KPiA+
PiBMaW5rOg0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsL0NBSGstDQo+ID4+ID13Z1JyX0Q4Q0ItRDlLZy0NCj4gPj4NCj4gYz1FSHJlQXNr
NVNxWFB3cjlZN2s5c0E2Y1dYSjZ3QG1haWwuZ21haWwuY29tL19fOyEhQTNOaThDUzB5DQo+ID4+
DQo+IDJZIXE4bGx3NVVDYU1Jc0FVN3RQdFBEaHdWb3Iwd3kwMzJJN0ZKSHYwVnhCWmtzTnVSSkYw
NEhqV2UNCj4gPj4gMFhZRzdPUSQgIFsxXQ0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBKYWtvYiBLb3Nj
aGVsIDxqYWtvYmtvc2NoZWxAZ21haWwuY29tPg0KPiA+PiAtLS0NCj4gPj4gZHJpdmVycy9paW8v
aW5kdXN0cmlhbGlvLWJ1ZmZlci5jIHwgNyArKysrKy0tDQo+ID4+IDEgZmlsZSBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tYnVmZmVyLmMgYi9kcml2ZXJzL2lpby9pbmR1c3RyaWFs
aW8tDQo+ID4+IGJ1ZmZlci5jDQo+ID4+IGluZGV4IDIwOGI1MTkzYzYyMS4uMTUxYTc3YzJhZmZk
IDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tYnVmZmVyLmMNCj4g
Pj4gKysrIGIvZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWJ1ZmZlci5jDQo+ID4+IEBAIC0xMDU5
LDcgKzEwNTksNyBAQCBzdGF0aWMgaW50IGlpb19lbmFibGVfYnVmZmVycyhzdHJ1Y3QNCj4gaWlv
X2Rldg0KPiA+PiAqaW5kaW9fZGV2LA0KPiA+PiAJc3RydWN0IGlpb19kZXZpY2VfY29uZmlnICpj
b25maWcpDQo+ID4+IHsNCj4gPj4gCXN0cnVjdCBpaW9fZGV2X29wYXF1ZSAqaWlvX2Rldl9vcGFx
dWUgPQ0KPiA+PiB0b19paW9fZGV2X29wYXF1ZShpbmRpb19kZXYpOw0KPiA+PiAtCXN0cnVjdCBp
aW9fYnVmZmVyICpidWZmZXI7DQo+ID4+ICsJc3RydWN0IGlpb19idWZmZXIgKmJ1ZmZlciwgKnRt
cCA9IE5VTEw7DQo+ID4+IAlpbnQgcmV0Ow0KPiA+Pg0KPiA+PiAJaW5kaW9fZGV2LT5hY3RpdmVf
c2Nhbl9tYXNrID0gY29uZmlnLT5zY2FuX21hc2s7DQo+ID4+IEBAIC0xMDk3LDggKzEwOTcsMTAg
QEAgc3RhdGljIGludCBpaW9fZW5hYmxlX2J1ZmZlcnMoc3RydWN0DQo+IGlpb19kZXYNCj4gPj4g
KmluZGlvX2RldiwNCj4gPj4NCj4gPj4gCWxpc3RfZm9yX2VhY2hfZW50cnkoYnVmZmVyLCAmaWlv
X2Rldl9vcGFxdWUtPmJ1ZmZlcl9saXN0LA0KPiA+PiBidWZmZXJfbGlzdCkgew0KPiA+PiAJCXJl
dCA9IGlpb19idWZmZXJfZW5hYmxlKGJ1ZmZlciwgaW5kaW9fZGV2KTsNCj4gPj4gLQkJaWYgKHJl
dCkNCj4gPj4gKwkJaWYgKHJldCkgew0KPiA+PiArCQkJdG1wID0gYnVmZmVyOw0KPiA+PiAJCQln
b3RvIGVycl9kaXNhYmxlX2J1ZmZlcnM7DQo+ID4+ICsJCX0NCj4gPj4gCX0NCj4gPj4NCj4gPj4g
CWlmIChpbmRpb19kZXYtPmN1cnJlbnRtb2RlID09IElORElPX0JVRkZFUl9UUklHR0VSRUQpIHsN
Cj4gPj4gQEAgLTExMjUsNiArMTEyNyw3IEBAIHN0YXRpYyBpbnQgaWlvX2VuYWJsZV9idWZmZXJz
KHN0cnVjdA0KPiBpaW9fZGV2DQo+ID4+ICppbmRpb19kZXYsDQo+ID4+IAkJCQkJICAgICBpbmRp
b19kZXYtPnBvbGxmdW5jKTsNCj4gPj4gCX0NCj4gPj4gZXJyX2Rpc2FibGVfYnVmZmVyczoNCj4g
Pj4gKwlidWZmZXIgPSBsaXN0X3ByZXBhcmVfZW50cnkodG1wLCAmaWlvX2Rldl9vcGFxdWUtDQo+
ID4+PiBidWZmZXJfbGlzdCwgYnVmZmVyX2xpc3QpOw0KPiA+DQo+ID4gT2ssIGl0J3MgRnJpZGF5
IHNvIEkgbWlnaHQgYmUgc2VlaW5nIGdob3N0cy4uLiBCdXQgbG9va2luZyBhdA0KPiAnbGlzdF9w
cmVwYXJlX2VudHJ5KCknLi4uDQo+ID4gSWYgdG1wICE9IE5VTEwsIHRoZW4gYWxsIGdvZXMgd2Vs
bCBidXQgaWYgdG1wID09IE5VTEwsIHRoZW4gd2UgZ2V0DQo+ID4NCj4gPiBsaXN0X2VudHJ5KCZp
aW9fZGV2X29wYXF1ZS0+YnVmZmVyX2xpc3QsIHN0cnVjdCBpaW9fYnVmZmVyLA0KPiBidWZmZXJf
bGlzdCkgd2hpY2gNCj4gPiB3b3VsZCByZXF1aXJlICdzdHJ1Y3QgaWlvX2Rldl9vcGFxdWUnLiBJ
dCBsb29rcyBsaWtlIGxpa2UNCj4gJ2xpc3RfcHJlcGFyZV9lbnRyeSgpJw0KPiA+IGFzc3VtZXMg
dGhhdCBwb3MgYW5kIGhlYWQgYXJlIG9mIHRoZSBzYW1lIHR5cGUuLi4NCj4gPg0KPiA+IEFtIEkg
bWlzc2luZyBzb21ldGhpbmc/DQo+IA0KPiBUaGUgbGlzdCBpdGVyYXRvcnMgYXJlIHdlaXJkIGlu
IHRoaXMgcGVyc3BlY3RpdmUuLi4NCj4gDQo+IElmIHlvdSBsb29rIGF0IHRoZSBvcmlnaW5hbCBj
b2RlLA0KPiBsaXN0X2Zvcl9lYWNoX2VudHJ5X2NvbnRpbnVlX3JldmVyc2UoKSBpcyBjYWxsZWQg
b24gJ2J1ZmZlcicuDQo+IA0KPiAnYnVmZmVyJyB3b3VsZCBiZSBhIHZhbGlkIHN0cnVjdCBlbGVt
ZW50IG9mICZpaW9fZGV2X29wYXF1ZS0NCj4gPmJ1ZmZlcl9saXN0IGlmIHRoZSBicmVhayBpcyBo
aXQsDQo+IGJ1dCBpZiBubyBicmVhayBpcyBoaXQgaW4gdGhlIGVhcmxpZXIgbGlzdF9mb3JfZWFj
aF9lbnRyeSgpIGJ1ZmZlciBpcyBub3QgYQ0KPiB2YWxpZCBlbnRyeS4NCj4gDQo+IEJlZm9yZSB0
aGUgdGVybWluYXRpbmcgY29uZGl0aW9uIG9mIGxpc3RfZm9yX2VhY2hfZW50cnkoKSBpcyBtZXQs
IGl0DQo+IGVzc2VudGlhbGx5IGRvZXM6DQo+IA0KPiAJYnVmZmVyID0gbGlzdF9lbnRyeSgmaWlv
X2Rldl9vcGFxdWUtPmJ1ZmZlcl9saXN0LA0KPiB0eXBlb2YoKmJ1ZmZlciksIGJ1ZmZlcl9saXN0
KTsNCj4gDQo+IHRoZSBidWZmZXIgcmV0dXJuZWQgaGVyZSBpcyBub3QgYSB2YWxpZCBwb2ludGVy
IHRvIHN0cnVjdCBob3dldmVyLg0KPiBCdXQgc2luY2UgbGlzdF9mb3JfZWFjaF9lbnRyeV9jb250
aW51ZV9yZXZlcnNlKCkgaW1tZWRpYXRlbHkgY2FsbHMNCj4gbGlzdF9wcmV2X2VudHJ5KGJ1ZmZl
ciwgYnVmZmVyX2xpc3QpDQo+IG9uIGl0IHlvdSBlbmQgdXAgd2l0aCB0aGUgbGFzdCBlbnRyeSBv
ZiB0aGUgbGlzdCBhZ2FpbiBhbmQgc3RhcnQgaXRlcmF0aW5nDQo+IHdpdGggdGhhdCBvbmUuDQoN
CkFoaCBJIHNlZSBpdCBub3cuLi4gSSByZWFsbHkgbmV2ZXIgaGFkIG5vdGljZWQgdGhpcyBkYW5j
ZSBidXQgaW4gZmFjdCB0aGUNCnNhbWUgZGFuY2UgaXMgYWxzbyB1c2VkIHRvIGRldGVjdCB0aGUg
ZW5kIG9mIGxpc3RfZm9yX2VhY2hfZW50cnkoKS4uLg0KDQpPaywgdGhlbjoNCg0KUmV2aWV3ZWQt
Ynk6IE51bm8gU8OhIDxudW5vLnNhQGFuYWxvZy5jb20+DQoNCg==
