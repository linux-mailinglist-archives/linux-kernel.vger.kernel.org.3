Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CB359CD81
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 03:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238720AbiHWBCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 21:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238951AbiHWBBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 21:01:48 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B604DB1F;
        Mon, 22 Aug 2022 18:01:32 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27N0wS7V001547;
        Mon, 22 Aug 2022 18:01:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=HcxJtTRNMyvflTBWDLAtcUJLftw3cs2AdFUkH0TgqzU=;
 b=fbXshOnq3rQbt5ujhDZwGafybNtMiT60PbW0VV/SUEW7v7ZkAxHe888A8xSjp+Z32UqZ
 SaLteuaOecTX1qZBmvuIWBk+A/6x/k4Wcxv1aUv98qO0FGMZNcKIObj4TosbRvQ1uQv2
 je0cuSt5vcZt5TJla0+p8XkrxJsDzIOoi5K16dbPZC/9wNoOvv6UpTFyZkNQTcI1NxU8
 U0UgABJu1ZfS19xuAqSuaOfimKU7Vf4dkxd7TKvRfgKMYyP9pHSXEJnnjVLFRsEesI7j
 V6E2n3VQOhSGEha7rJimYDeReqnJmzRr71fMXqjmOiSdEbTLrCvDpxqR/Auwx+jEVFPi 7w== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3j2x8e27y9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 18:01:18 -0700
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6C4B140052;
        Tue, 23 Aug 2022 01:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1661216477; bh=HcxJtTRNMyvflTBWDLAtcUJLftw3cs2AdFUkH0TgqzU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=LPgs8m3SJlXNzMiItTnXvOf25i/8YK8KsQGwwvvVRQRuzOxGUmway5QBnsbBcVWjp
         jFy7DQpvSEbXUKF7CP2PdKdTZZHBQJX+dveBrvo9yctFRaYqaYyjdr+YCsgup8a4Z+
         n5xaFEziIUO5WJiZRo4ePUr1Cein57xn45cWBMBpGh1SXWrsZDhTqH38KJimsfpP7e
         eG19iL+QkeB21/CnRS/XftGIrdf1jmxF3KKrLPXWplIKGuzuY2hN0K1QOsTQUgA2S8
         7WEJZxI1brTUOnGmMUM9CLtNP/fh+fZsC29eiBz/kkD22v8AXPt6Z5nmiN9R1FCfJs
         z5SMYCpVfh5ZQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 6B52FA008A;
        Tue, 23 Aug 2022 01:01:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 09A7E400C1;
        Tue, 23 Aug 2022 01:01:15 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="c4wQS2LJ";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfzcWu79SwYeuGeyaA7VdiWrqzD5YcPEspTCfB3zOra3h4D+ko1rQxIOE90UqP36vOw9W6hYqTjmGFNgF+PLlxzpm2/IsQoEoYrBuQFcnNzgc7S9F2HVo+4btv3pLaxmoOirGpFPiXYA/zZRGAzEyWLmv6zQR89wp7sVxQrvk+YAo5RHe6rzMFYlFQtpY3tDutWx2XKSe7vuZOmWCisGgZrI0D4jYeW+Oj0izhMx6b2LJbwWI8jcOg5FVR1fxdIhStMjS2rHOwddL8a3Nd/ZZFGTWE+h6m0ylIQE+zSyKuaBarXTep7O0ovwhdOcuD8E/1xJLiD++C+JOMCgWe8J+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcxJtTRNMyvflTBWDLAtcUJLftw3cs2AdFUkH0TgqzU=;
 b=IQoLnukvv6XU8qRelf+tr6ibkQFsujgD9jO3XdWw0V9A46LzG4fSd48SgomkMPVTByrcqdMxFnadLRs1GniLyJ9gRR4tNao7RiaEluHvl0SJx6P1mub+fEENFm4rflHgMzCjfTUcXO1cJNd8MfFPUWYOIKysi259KqLcKrXTnayGt4+oac9UUbBEjddvZ416psqEwJTvOJeWkruJtGcPiXthM3B62X0glta56RjjdhQ/oBGQ6frGYCQnC45iZkWXvPq1nnPb+xuEfUrzfSLQscVhKmj/Y8H6W5x2KwgATCjrIwPkWlVAjWoC382N8Z+9xCRbNakcldcsAJ5D0EETJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcxJtTRNMyvflTBWDLAtcUJLftw3cs2AdFUkH0TgqzU=;
 b=c4wQS2LJ2pavepzYJDQVuBmIBJKJ5U3zinSH1s1sDbxX5F6wHpFghZKY3e2JU3VPq+7v5ntsjwdd/lq5QCLT37ftPNEpJRzy0GHibtXVkFCrSqYe86tvDSykktruewL0zLLcg8/QPcIKblPm1pqZXfq1FiTdhMxezHqDyK4yGSM=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM6PR12MB2874.namprd12.prod.outlook.com (2603:10b6:5:15e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Tue, 23 Aug
 2022 01:01:11 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::69ee:633:f068:3ca1]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::69ee:633:f068:3ca1%3]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 01:01:11 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Serrao <quic_eserrao@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_mrana@quicinc.com" <quic_mrana@quicinc.com>
Subject: Re: [PATCH 2/5] usb: gadget: Add function wakeup support
Thread-Topic: [PATCH 2/5] usb: gadget: Add function wakeup support
Thread-Index: AQHYpqSxYg+mSBtinkWEjfftWY3s8a2cSDKAgAMApwCAAD6nAIAHe4yAgABbB4CAAtc4AIAAXAqAgAAFJ4CAAXhZgIAF+LQAgABBaYCAAsdLAIAGuhMA
Date:   Tue, 23 Aug 2022 01:01:11 +0000
Message-ID: <20220823010056.5yvd6223awab47vl@synopsys.com>
References: <8705d52e-2181-aebd-43b8-2c8d021339c7@synopsys.com>
 <5ad70f41-622e-2d75-7c53-89aba1255a5f@quicinc.com>
 <ac8e012f-08f3-baed-ead0-231f0527864c@synopsys.com>
 <b123b543-6c82-2787-9730-addd3e6e70a3@quicinc.com>
 <98966b47-0bc5-6ec0-ec80-5eff1d71d9fd@synopsys.com>
 <e3bcfd4c-efdb-c7b0-4e94-1afcd3b8eb73@synopsys.com>
 <1fac4c0f-4e8b-f333-7208-c50353a806f4@synopsys.com>
 <dc5cdba3-fcbc-79a2-797e-2553c727cba5@quicinc.com>
 <6e8de558-7183-d3f1-9ba7-83a612675e17@synopsys.com>
 <e22d4f8e-0ca7-056e-e5ec-4fc97cbaf08b@quicinc.com>
In-Reply-To: <e22d4f8e-0ca7-056e-e5ec-4fc97cbaf08b@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa433783-ad02-4ee5-efad-08da84a2f89d
x-ms-traffictypediagnostic: DM6PR12MB2874:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LrUAGNF0lqg+iF0kcmD8aiWS89wk5osrtWemQ/XShqCBs+fqTk5gs9uqAvZxZFm1yyK0J4gbN6iZiY/I8wA1QDfmr9eii3eN6w3KRidbOx3PZ7qea3M5debZs4AFzNH6VYM1rldgq3hgSP6GyGlBze/bNQCEP45s/QPYH1p05R8oU+AtCGEOFaP2DWC7gJhe3S1E2LUh7gab6Te9z5F1xqpN++8CJg7uuB1Ncp5mj0qv4V+sSvPlzFGkWJYaRWyxEWjKyXPUmtayGiHyr7xCITacejxRlfSvGFk6I6mAQj6lFHa8LDwWVxdEjcgBDPPjwrxhs3drdnsggs6/vAPGaI2b5zyEBBl9aAhWbfjnAMtZOm8wUxfltIPSrFKSREiAjo3BH93w7Zk45KPuQiG9zG48+NbeqeIAWWdxbDEGVh80peyfubN+RjX/WaklLJK49EKQLKV3eDGoHNOilGY4HkgWlTFeQzcsCQiFYPu1ZRUDZ64YivweRSyzgs33HoP2gN43zjPvgChUBCXWXOEqdK9V5aCDzz7zp2ePywcr5tKhUsezYXX4op3eM6NfSJrKL/pjxpWPCvoS87ZQhluFVUmWoem7qtEgQOiPQkDZHw8yUbVmZRHgq0CE5WDQiNgf34RcaroW8RPWkIM0j8msx+VIIv1hoDgDYJoCKEFfI+2225sMvo48zpASyBZF9MLa0zRhVx6RETE7XQK/bzizmxzCc2vqqftw+6IQM1gCrrlA/yskkOewsU/JGjnmUYiC43a1QGaLXi4v32wR1qtXxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(366004)(346002)(396003)(376002)(478600001)(86362001)(6916009)(2906002)(38070700005)(36756003)(316002)(54906003)(6486002)(71200400001)(41300700001)(53546011)(26005)(186003)(1076003)(6512007)(2616005)(83380400001)(64756008)(8936002)(5660300002)(66476007)(6506007)(76116006)(66556008)(66946007)(8676002)(4326008)(122000001)(66446008)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dko2dGtNYVZMQndudXJtVitDcDREdXpEYVZsSUdlcGZidFJVd0hoOWRqSC9W?=
 =?utf-8?B?cytEYkVBOWMrWHhESXIwOHhyWlV5RGhiS2VvUVl4MUVjU3AwWThGQXQrZ2Vl?=
 =?utf-8?B?WlBLNVlUbzhMY3FBWXJqaXorMWkzdnp6eUpEOVdkSjFmTmRYZVFVZDFrMmFz?=
 =?utf-8?B?TzA0YnVpbTIvQzlqQnJnY2hlbGZMcUtsZFFwS0pTZitwelJBZXFWaG9xbGJF?=
 =?utf-8?B?SWhTZnBRc2dlU1IvNmg1dllDbVNSSG9vbklkOUJsTkJvNHRoZ005NHRUZjFD?=
 =?utf-8?B?bnVscS9VQmRNeWpFOHY5bUpIbFY5RkEwWU9OSkx5eVM2K2RsakhsNjAyS2N6?=
 =?utf-8?B?OFVBT2VvMFhjL09CWGN5VThDNkdrWmV0ckdKSGxDT3JrQlQ2Z29SdzB2UTFp?=
 =?utf-8?B?cjZDNENGN1h6Z3lqTUEwS3NQUkYvRnNCZUpabEpBaFVYcUIyY3pGOWd2TVdB?=
 =?utf-8?B?UW1Sa3RaMUZrVTRlYWw1bnI1cGhpQ2c2UWFRaVBKQUtZZDZWMDRtMGw5UzRS?=
 =?utf-8?B?NnRhc3dwVlB6NW1lYWpBRVZxd01ERzNmMXNVLzJzUUV5N1N1SzNCd2NzUm9J?=
 =?utf-8?B?MWJOTjRvWlVLR0xhUW5QTndEY01BdzlqcXUvODg5SnQ5YUZ3L3FGT09HbjNO?=
 =?utf-8?B?VWVPMFYvQXpXdGVaNU8yTlNZUzA3RGxzS0JBcm1sNWpnRlg1UDc4djlNZ01Y?=
 =?utf-8?B?blpDVXZTM1hQazRJc2tJS2xyajJuZk85MGNMLzJWQTY5dFZvNitJTVlYQXVv?=
 =?utf-8?B?eEJuYkY5bzVmTHNkekdzSVlRQmxiYUtVTmZiQmc5TStaRnFVZmFhZnFkNUd2?=
 =?utf-8?B?SVZjMTVSN2tRbERNMU91cUxZbW50TDBLRG4yZ3BGTEJFSkpqYmN0U0REa1FR?=
 =?utf-8?B?NVEzVUVYeGsvNzkxVUhoZVo1TkRiczZsMFdWR1EyN0FSRVBiamVTaERMeThK?=
 =?utf-8?B?Vk92dm5OTURBTE93eXMyU25IeGlzY1gycy9qdmFBWjI3M0RhZTBMRE4zVHpn?=
 =?utf-8?B?UVNHUW9IZVA5S2xlTU5UcVcwdFYzTmJqNTNhVWVCakdZU2RNM0p4Q3FlZ3o2?=
 =?utf-8?B?V3U0YTBHN3dQNVJnRE10cWhSeU5MRDFZWEVVV3FtNCtFeENwS1VidnJIZVln?=
 =?utf-8?B?blAzaWY4U3FJYzBKeG5JTWNFVEdpR04zU05MN0tVYjdmNDNYSkFFL1Zad0Ux?=
 =?utf-8?B?Q2pyRkxqeWt4SnQxdU1FOStUa0dQT2FaRmp0bllCdVYwUyt4U05RbXZWWnd2?=
 =?utf-8?B?N042eDNBSSthWHZXOUNZRHRHQnNFMzYvSUY2RDNzc1F5YUJEaHBNRUlCK1dL?=
 =?utf-8?B?QUVFUmIwcE1lS1M1Mk5EV1BKU3l3MXJ3Q1VFaXZjWUNTRFM4ZjdmS3JkNzVL?=
 =?utf-8?B?cFdZa082VVFBZlJaUU5BUzlJZXRYQk9jTUszQkoreG9TaU5GQjJZR3hwMEc2?=
 =?utf-8?B?SGF2YU1CVUdmVWRnNFNWSGhSUGtQRndJOG9pd3NFWjJxTXdVWmJ3Y2Erd281?=
 =?utf-8?B?RTdHVnlYZnRJZG5VV2NWbENUQjYrdE42SEhBTDdmZUZJYTJTS2hYTzI5aEdI?=
 =?utf-8?B?dDM0TWQzeEdoZ1hUTktJSmh5VzFhL3BnNFp6WHUrOXJValFEdVV3czcwM1ov?=
 =?utf-8?B?SmpncVM1MDd2aGVBd3BxNWlwdmVTSHZYWkdOR0pha3lBTXRidFU5dkFaaXky?=
 =?utf-8?B?UjdoR211TE51alRYTVNwejRYbnhtQlZwS1FZSjFNQ2tKNlRHQWJWdjdHQnR3?=
 =?utf-8?B?VjZjZlhPdEFpbWFjdTBnUTVobStseWtvT3JHMXVHSWFpUERzT0JVUWdTeWtT?=
 =?utf-8?B?a2xUQ1pDVWVOdDBQbEowV2RNTzF2eEg2akpONXZCbW5TbXJHVm40bllxdXN6?=
 =?utf-8?B?ZkdSek51OTJCNklneTV6SDJqa0hUMktZbVRDdTVuYUU3S3lDS2toQ3dxS0tu?=
 =?utf-8?B?bzFZLzFGQTI3L2N3YkxNT3QvZG5DSzUwYmRQVmxyeHVtSndkbXdOUUlOdmg2?=
 =?utf-8?B?QUNHSG1zOFdDS1FJeFFoc2l2QjZ1YWorZXlXbWNxNHRkTHRIM3FqU2p6NW5y?=
 =?utf-8?B?Ym9GMDlBY1UweEdUVDVsQ3ZLZG1xdGV6MHdzMWtVTGF4eGYwQnc4WEJhendK?=
 =?utf-8?Q?kvPEY3EgF77fvwP1TDWdacqgj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E36CAB6AD130442A96617B064178DA9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa433783-ad02-4ee5-efad-08da84a2f89d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 01:01:11.6390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GB2jY9hPAEI2EZeFkuX/7rmE2PRu5sOPxFQZH7AHU2XLdwK8UGRdHYSdTV/RBkoMWM9+hkp0Ie66VqReAN7fSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2874
X-Proofpoint-GUID: cEjqF_I2O9nziBr1UXfF3JDgN7xN0N0E
X-Proofpoint-ORIG-GUID: cEjqF_I2O9nziBr1UXfF3JDgN7xN0N0E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_16,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208230002
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBBdWcgMTgsIDIwMjIgYXQgMTE6MTc6MjRBTSAtMDcwMCwgRWxzb24gU2VycmFvIHdy
b3RlOg0KPiANCj4gDQo+IE9uIDgvMTYvMjAyMiA0OjUxIFBNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6
DQo+ID4gT24gOC8xNi8yMDIyLCBFbHNvbiBTZXJyYW8gd3JvdGU6DQo+ID4gPiANCj4gPiA+IA0K
PiA+ID4gT24gOC8xMi8yMDIyIDU6NDYgUE0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiA+ID4g
T24gOC8xMS8yMDIyLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gPiA+ID4gT24gOC8xMS8yMDIy
LCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gPiA+ID4gPiBPbiA4LzExLzIwMjIsIEVsc29uIFNl
cnJhbyB3cm90ZToNCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
PiBPbiA4LzkvMjAyMiA2OjA4IFBNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiA+IDxzbmlwPg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+ID4gPiBUbyBzdW1tYXJpemUgdGhlIHBvaW50czoNCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+ID4gPiAxKSBUaGUgaG9zdCBvbmx5IGFybXMgZnVuY3Rpb24gcmVtb3RlIHdha2V1cCBp
ZiB0aGUgZGV2aWNlIGlzDQo+ID4gPiA+ID4gPiA+ID4gY2FwYWJsZSBvZg0KPiA+ID4gPiA+ID4g
PiA+IHJlbW90ZSB3YWtldXAgKGNoZWNrIFVTQl9DT05GSUdfQVRUX1dBS0VVUCBpbiBibUF0dHJp
YnV0ZXMgYW5kDQo+ID4gPiA+ID4gPiA+ID4gaGFyZHdhcmUNCj4gPiA+ID4gPiA+ID4gPiBjYXBh
YmlsaXR5KQ0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IDIpIElmIHRoZSBkZXZp
Y2UgaXMgaW4gc3VzcGVuZCwgdGhlIGRldmljZSBjYW4gZG8gcmVtb3RlIHdha2V1cA0KPiA+ID4g
PiA+ID4gPiA+ICh0aHJvdWdoDQo+ID4gPiA+ID4gPiA+ID4gTEZQUyBoYW5kc2hha2UpIGlmIHRo
ZSBmdW5jdGlvbiBpcyBhcm1lZCBmb3IgcmVtb3RlIHdha2V1cCAodGhyb3VnaA0KPiA+ID4gPiA+
ID4gPiA+IFNFVF9GRUFUVVJFKEZVTkNfU1VTUEVORCkpLg0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+
ID4gPiA+ID4gPiA+IDMpIElmIHRoZSBsaW5rIHRyYW5zaXRpb25zIHRvIFUwIGFmdGVyIHRoZSBk
ZXZpY2UgdHJpZ2dlcmluZyBhIHJlbW90ZQ0KPiA+ID4gPiA+ID4gPiA+IHdha2V1cCwgdGhlIGRl
dmljZSB3aWxsIGFsc28gc2VuZCBkZXZpY2Ugbm90aWZpY2F0aW9uIGZ1bmN0aW9uDQo+ID4gPiA+
ID4gPiA+ID4gd2FrZSBmb3INCj4gPiA+ID4gPiA+ID4gPiBhbGwgdGhlIGludGVyZmFjZXMgYXJt
ZWQgd2l0aCByZW1vdGUgd2FrZXVwLg0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+
IDQpIElmIHRoZSBkZXZpY2UgaXMgbm90IGluIHN1c3BlbmQsIHRoZSBkZXZpY2UgY2FuIHNlbmQg
ZGV2aWNlDQo+ID4gPiA+ID4gPiA+ID4gbm90aWZpY2F0aW9uIGZ1bmN0aW9uIHdha2UgaWYgaXQn
cyBpbiBVMC4NCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+
ID4gPiBOb3csIHJlbW90ZSB3YWtldXAgYW5kIGZ1bmN0aW9uIHdha2UgZGV2aWNlIG5vdGlmaWNh
dGlvbiBhcmUgMg0KPiA+ID4gPiA+ID4gPiA+IHNlcGFyYXRlDQo+ID4gPiA+ID4gPiA+ID4gb3Bl
cmF0aW9ucy4gV2UgaGF2ZSB0aGUgdXNiX2dhZGdldF9vcHMtPndha2V1cCgpIGZvciByZW1vdGUg
d2FrZXVwLiBJDQo+ID4gPiA+ID4gPiA+ID4gc3VnZ2VzdGVkIHRvIG1heWJlIGFkZA0KPiA+ID4g
PiA+ID4gPiA+IHVzYl9nYWRnZXRfb3BzLT5zZW5kX3dha2V1cF9ub3RpZmljYXRpb24oZ2FkZ2V0
LA0KPiA+ID4gPiA+ID4gPiA+IGludGZfaWQpIGZvciB0aGUgZGV2aWNlIG5vdGlmaWNhdGlvbi4g
V2hhdCB5b3UgZGlkIHdhcyBjb21iaW5pbmcgYm90aA0KPiA+ID4gPiA+ID4gPiA+IG9wZXJhdGlv
bnMgaW4gdXNiX2dhZGdldF9vcHMtPmZ1bmNfd2FrZXVwKCkuIFRoYXQgbWF5IG9ubHkgd29yayBm
b3INCj4gPiA+ID4gPiA+ID4gPiBwb2ludCA0KSAoYXNzdW1pbmcgeW91IGZpeCB0aGUgVTAgY2hl
Y2spLCBidXQgbm90IHBvaW50IDMpLg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gVGhh
bmsgeW91IGZvciB5b3VyIGZlZWRiYWNrIGFuZCBzdW1tYXJ5LiBJIHdpbGwgcmVuYW1lIGZ1bmNf
d2FrZXVwIHRvDQo+ID4gPiA+ID4gPiA+IHNlbmRfd2FrZXVwX25vdGlmaWNhdGlvbiB0byBiZXR0
ZXIgYWxpZ24gd2l0aCB0aGUgYXBwcm9hY2guIFRoZQ0KPiA+ID4gPiA+ID4gPiByZWFzb24gSQ0K
PiA+ID4gPiA+ID4gPiBoYXZlIGNvbWJpbmVkIHJlbW90ZV93YWtldXAgYW5kIGZ1bmN0aW9uIHdh
a2Ugbm90aWZpY2F0aW9uIGluDQo+ID4gPiA+ID4gPiA+IHVzYl9nYWRnZXRfb3BzLT5mdW5jX3dh
a2V1cCgpIGlzIGJlY2F1c2Ugc2luY2UgdGhlIGltcGxlbWVudGF0aW9uDQo+ID4gPiA+ID4gPiA+
IGlzIGF0DQo+ID4gPiA+ID4gPiA+IGZ1bmN0aW9uL2NvbXBvc2l0ZSBsZXZlbCBpdCBoYXMgbm8g
a25vd2xlZGdlIG9uIHRoZSBsaW5rIHN0YXRlLiBTbyBJDQo+ID4gPiA+ID4gPiA+IGhhdmUgZGVs
ZWdhdGVkIHRoYXQgdGFzayB0byBjb250cm9sbGVyIGRyaXZlciB0byBoYW5kbGUgdGhlDQo+ID4g
PiA+ID4gPiA+IG5vdGlmaWNhdGlvbg0KPiA+ID4gPiA+ID4gPiBhY2NvcmRpbmdseS4gVGhhdCBp
cyBkbyBhIExGUFMgaGFuZHNoYWtlIGZpcnN0IGlmIHRoZSBkZXZpY2UgaXMNCj4gPiA+ID4gPiA+
ID4gc3VzcGVuZGVkIGFuZCB0aGVuIHNlbmQgbm90aWZpY2F0aW9uIChleHBsYWluZWQgYmVsb3cp
LiBCdXQgd2UgY2FuDQo+ID4gPiA+ID4gPiA+IGRlZmluaXRlbHkgc2VwYXJhdGUgdGhpcyBieSBh
ZGRpbmcgYW4gYWRkaXRpb25hbCBmbGFnIGluIHRoZSBjb21wb3NpdGUNCj4gPiA+ID4gPiA+ID4g
bGF5ZXIgdG8gc2V0IHRoZSBsaW5rIHN0YXRlIGJhc2VkIG9uIHRoZSBnYWRnZXQgc3VzcGVuZCBj
YWxsYmFjaw0KPiA+ID4gPiA+ID4gPiBjYWxsZWQNCj4gPiA+ID4gPiA+ID4gd2hlbiBVMyBTVVNQ
RU5EIGludGVycnVwdCBpcyByZWNlaXZlZC4gTGV0IG1lIGtub3cgaWYgeW91IGZlZWwNCj4gPiA+
ID4gPiA+ID4gc2VwYXJhdGluZyB0aGUgdHdvIGlzIGEgYmV0dGVyIGFwcHJvYWNoLg0KPiA+ID4g
PiA+ID4gPiANCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gVGhlIHJlYXNvbiBJIHRoaW5rIHdl
IG5lZWQgdG8gc2VwYXJhdGUgaXQgaXMgYmVjYXVzZSBvZiBwb2ludCAzLiBBcyBJDQo+ID4gPiA+
ID4gPiBub3RlIGVhcmxpZXIsIHRoZSBzcGVjIHN0YXRlcyB0aGF0ICJJZiByZW1vdGUgd2FrZSBl
dmVudCBvY2N1cnMgaW4NCj4gPiA+ID4gPiA+IG11bHRpcGxlIGZ1bmN0aW9ucywgZWFjaCBmdW5j
dGlvbiBzaGFsbCBzZW5kIGEgRnVuY3Rpb24gV2FrZQ0KPiA+ID4gPiA+ID4gTm90aWZpY2F0aW9u
LiINCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gQnV0IGlmIHRoZXJlJ3Mgbm8gcmVtb3RlIHdh
a2UgZXZlbnQsIGFuZCB0aGUgaG9zdCBicm91Z2h0IHRoZSBkZXZpY2UgdXANCj4gPiA+ID4gPiA+
IGluc3RlYWQsIHRoZW4gdGhlIGZ1bmN0aW9uIHN1c3BlbmQgc3RhdGUgaXMgcmV0YWluZWQuDQo+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IElmIHdlIHNlcGFyYXRlIHRoZXNlIDIgb3BlcmF0aW9u
cywgdGhlIGNhbGxlciBjYW4gY2hlY2sgd2hldGhlciB0aGUNCj4gPiA+ID4gPiA+IG9wZXJhdGlv
biB3ZW50IHRocm91Z2ggcHJvcGVybHkuIEZvciBleGFtcGxlLCBpZiB0aGUgd2FrZXVwKCkgaXMN
Cj4gPiA+ID4gPiA+IGluaXRpYXRlZCBwcm9wZXJseSwgYnV0IHRoZSBmdW5jdGlvbiB3YWtlIGRl
dmljZSBub3RpZmljYXRpb24gZGlkbid0IGdvDQo+ID4gPiA+ID4gPiB0aHJvdWdoLiBXZSB3b3Vs
ZCBvbmx5IG5lZWQgdG8gcmVzZW5kIHRoZSBkZXZpY2Ugbm90aWZpY2F0aW9uIHJhdGhlcg0KPiA+
ID4gPiA+ID4gdGhhbiBpbml0aWF0ZSByZW1vdGUgd2FrZXVwIGFnYWluLg0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IElmIHdlIGRvbid0IGhhdmUgdG8gc2VuZCBkZXZpY2Ugbm90aWZpY2F0aW9uIGZv
ciBvdGhlciBpbnRlcmZhY2VzLCB3ZQ0KPiA+ID4gPiA+IGNhbiBjb21iaW5lIHRoZSBvcGVyYXRp
b25zIGhlcmUgYXMgeW91IGRpZC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IEkgc3Rp
bGwgdGhpbmsgaXQncyBiZXR0ZXIgdG8gc3BsaXQgdXAgdGhlIG9wZXJhdGlvbnMuIFRoZSB3YXkg
eW91J3JlDQo+ID4gPiA+IGhhbmRsaW5nIGl0IG5vdyBpcyBub3QgY2xlYXIuDQo+ID4gPiA+IA0K
PiA+ID4gPiBJZiB0aGUgZnVuY19hd2FrZSgpIHJldHVybnMgLUVBR0FJTiwgSSdkIGV4cGVjdCB0
aGF0IHRoZSByZW1vdGUgd2FrZSBkaWQNCj4gPiA+ID4gbm90IGdvIHRocm91Z2ggYW5kIGV4cGVj
dCB1c2VyIHRvIHJldHJ5IGFnYWluLiBCdXQgaGVyZSBpdCBkb2VzIGluaXRpYXRlDQo+ID4gPiA+
IHJlbW90ZSB3YWtlLCBidXQgaXQganVzdCBkb2VzIG5vdCBzZW5kIGRldmljZSBub3RpZmljYXRp
b24geWV0LiBUaGlzIGlzDQo+ID4gPiA+IGNvbmZ1c2luZy4NCj4gPiA+ID4gDQo+ID4gPiA+IEFs
c28sIGluc3RlYWQgb2YgYWxsIHRoZSBmdW5jdGlvbiB3YWtlIGhhbmRsaW5nIGNvbWluZyBmcm9t
IHRoZSBmdW5jdGlvbg0KPiA+ID4gPiBkcml2ZXIsIG5vdyB3ZSBkZXBlbmQgb24gdGhlIGNvbnRy
b2xsZXIgZHJpdmVyIHRvIGNhbGwgZnVuY3Rpb24gcmVzdW1lKCkNCj4gPiA+ID4gb24gc3RhdGUg
Y2hhbmdlIHRvIFUwLCB3aGljaCB3aWxsIHRyaWdnZXIgZGV2aWNlIG5vdGlmaWNhdGlvbi4gV2hh
dA0KPiA+ID4gPiBoYXBwZW4gaWYgaXQgZG9lc24ndCBjYWxsIHJlc3VtZSgpLiBUaGVyZSdzIHRv
byBtYW55IGRlcGVuZGVuY2llcyBhbmQgaXQNCj4gPiA+ID4gc2VlbXMgZnJhZ2lsZS4NCj4gPiA+
ID4gDQo+ID4gPiA+IEkgdGhpbmsgYWxsIHRoaXMgY2FuIGJlIGhhbmRsZWQgaW4gdGhlIGZ1bmN0
aW9uIGRyaXZlci4gWW91IGNhbiBmaXggdGhlDQo+ID4gPiA+IGR3YzMgd2FrZXVwKCkgYW5kIHBv
bGwgZm9yIFUwL09OIHN0YXRlIHJhdGhlciB0aGFuIFJFQ09WRVJZIHN0YXRlLCB3aGljaA0KPiA+
ID4gPiBpcyB3aGF0IGl0J3Mgc3VwcG9zZWQgdG8gcG9sbC4NCj4gPiA+IA0KPiA+ID4gRm9yIHRy
YW5zaXRpb25pbmcgZnJvbSBVMyB0byBVMCwgdGhlIGN1cnJlbnQgdXBzdHJlYW0gaW1wbGVtZW50
YXRpb24gaXMNCj4gPiA+IHRvIHBvbGwgZm9yIFUwIHN0YXRlIHdoZW4gZHdjM19nYWRnZXRfd2Fr
ZXVwKCkgaXMgY2FsbGVkIGFuZCBpdCBpcyBhDQo+ID4gPiBibG9ja2luZyBjYWxsLiAodGhpcyBp
cyBhIGNvbW1vbiBBUEkgZm9yIGJvdGggSFMgYW5kIFNTKQ0KPiA+ID4gDQo+ID4gPiAgwqDCoMKg
wqAvKiBwb2xsIHVudGlsIExpbmsgU3RhdGUgY2hhbmdlcyB0byBPTiAqLw0KPiA+ID4gIMKgwqDC
oMKgcmV0cmllcyA9IDIwMDAwOw0KPiA+ID4gDQo+ID4gPiAgwqDCoMKgwqB3aGlsZSAocmV0cmll
cy0tKSB7DQo+ID4gPiAgwqDCoMKgwqDCoMKgwqAgcmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3Ms
IERXQzNfRFNUUyk7DQo+ID4gPiANCj4gPiA+ICDCoMKgwqDCoMKgwqDCoCAvKiBpbiBIUywgbWVh
bnMgT04gKi8NCj4gPiA+ICDCoMKgwqDCoMKgwqDCoCBpZiAoRFdDM19EU1RTX1VTQkxOS1NUKHJl
ZykgPT0gRFdDM19MSU5LX1NUQVRFX1UwKQ0KPiA+ID4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
YnJlYWs7DQo+ID4gPiAgwqDCoMKgwqB9DQo+ID4gPiANCj4gPiA+IEluIG15IGV4cGVyaW1lbnRz
IEkgZm91bmQgdGhhdCBjZXJ0YWluIGhvc3RzIHRha2UgbG9uZ2VyIHRpbWUgdG8gZHJpdmUNCj4g
PiA+IEhTIHJlc3VtZSBzaWduYWxsaW5nIGJldHdlZW4gdGhlIHJlbW90ZSB3YWtldXAgYW5kIHRo
ZSByZXN1bWUgSyBhbmQgdGhpcw0KPiA+ID4gdGltZSB2YXJpZXMgYWNyb3NzIGhvc3RzLiBIZW5j
ZSB0aGUgYWJvdmUgcG9sbGluZyB0aW1lciBpcyBub3QgZ2VuZXJpYw0KPiA+ID4gYWNyb3NzIGhv
c3RzLiBTbyBob3cgZG8gd2UgY29udmVyZ2Ugb24gYSBwb2xsaW5nIHRpbWVyIHZhbHVlIHRvIHdv
cmsNCj4gPiA+IGFjcm9zcyBIUy9TUyBhbmQgd2l0aG91dCBibG9ja2luZyB0aGUgc3lzdGVtIGZv
ciBhIGxvbmcgdGltZT8NCj4gPiANCj4gPiBDYW4ndCB3ZSB0YWtlIHRoZSB1cHBlciBsaW1pdCBv
ZiBib3RoIGJhc2Ugb24gZXhwZXJpbWVudD8gQW5kIGl0DQo+ID4gc2hvdWxkbid0IGJlIGJsb2Nr
aW5nIHRoZSB3aG9sZSBzeXN0ZW0uDQo+IA0KPiBPbiB0aGUgaG9zdCBJIHdhcyBleHBlcmltZW50
aW5nIHdpdGgsIHRoZSB0aW1lIGl0IHRvb2sgd2FzIGFyb3VuZCAxMTBtcyBpbg0KPiBIUyBjYXNl
LiBUaGF0IHdvdWxkIHRyYW5zbGF0ZSB0byBhIHJldHJ5IGNvdW50IG9mIGFib3V0IH4xODEsMDAw
IGluIHRoZQ0KPiBhYm92ZSBwb2xsaW5nIGxvb3AuIFdvdWxkbid0IHRoYXQgYmUgYSB2ZXJ5IGxh
cmdlIHZhbHVlIGZvciBwb2xsaW5nPw0KPiBBbmQgbm90IHN1cmUgaWYgdGhlcmUgYXJlIG90aGVy
IGhvc3RzIHRoYXQgdGFrZSBldmVuIGxvbmdlciB0aW1lDQoNCldlIGRvbid0IHdhbnQgdG8gcG9s
bCB0aGF0IG1hbnkgdGltZXMuIFdlIHNob3VsZG4ndCBkZXBlbmQgb24gdGhlIGRlbGF5DQpvZiBh
IHJlZ2lzdGVyIHJlYWQgZm9yIHBvbGxpbmcgaW50ZXJ2YWwuIENhbid0IHdlIGp1c3Qgc2xlZXAg
aW4gYmV0d2Vlbg0KaW50ZXJ2YWwgYXQgYSByZWFzb25hYmxlIGludGVydmFsLg0KDQo+ID4gDQo+
ID4gPiANCj4gPiA+IFNvbWUgZGF0YSBsYXllcnMgbGlrZSBUQ1AvSVAgaG9sZCBhIFRYIGxvY2sg
d2hpbGUgc2VuZGluZyBkYXRhICh0aGF0DQo+ID4gPiBjYXVzZXMgYSByZW1vdGUgd2FrZXVwIGV2
ZW50KSBhbmQgaGVuY2UgdGhpcyB3YWtldXAoKSBtYXkgcnVuIGluIGF0b21pYw0KPiA+ID4gY29u
dGV4dC4NCj4gPiANCj4gPiBXaHkgaG9sZCB0aGUgbG9jayB3aGlsZSB3YWl0aW5nIGZvciB0aGUg
aG9zdCB0byB3YWtldXA/IFRoZSBob3N0IGlzDQo+ID4gc3RpbGwgaW5hY3RpdmUuIEFsc28sIHRo
ZSB1c2JfZ2FkZ2V0X3dha2V1cCgpIEFQSSBkb2Vzbid0IHNwZWNpZnkgdGhhdA0KPiA+IGl0IG1h
eSBydW4gaW4gYXRvbWljIGNvbnRleHQuDQo+ID4gDQo+IA0KPiBUaGUgbG9jayBtaWdodCBiZSBo
ZWxkIGJ5IHVwcGVyIGxheWVycyB3aG8gYXJlIHVuYXdhcmUvaW5kZXBlbmRlbnQgb2YNCj4gdW5k
ZXJseWluZyB0cmFuc3BvcnQgbWVkaXVtLiBUaGUgYWJvdmUgVFggbG9jayBJIHdhcyByZWZlcnJp
bmcgdG8gd2FzDQo+IHRoYXQgaGVsZCBieSBMaW51eCBuZXR3b3JraW5nIHN0YWNrLiBJdCBqdXN0
IHB1c2hlcyBvdXQgZGF0YSB0aGUgc2FtZSB3YXkgaXQNCj4gd291bGQgd2hlbiBVU0IgaXMgYWN0
aXZlLiBJdCBpcyB0aGUgZnVuY3Rpb24vY29tcG9zaXRlIGxheWVyIGJlaW5nIGF3YXJlIG9mDQo+
IHRoZSBmdW5jdGlvbiBzdXNwZW5kIHdvdWxkIG5vdyBzZW5zZSB0aGlzIGFzIGEgcmVtb3RlIHdh
a2UgZXZlbnQgYW5kIHBlcmZvcm0NCj4gdGhpcyBhZGRpdGlvbmFsIHN0ZXAgb2YgYnJpbmdpbmcg
b3V0IHRoZSBsaW5rIGZyb20gdTMgYW5kIHRoZW4gc2VuZGluZw0KPiBkZXZpY2Ugd2FrZXVwIG5v
dGlmaWNhdGlvbi4NCj4gDQo+IEluIG91ciBjdXJyZW50IHVwc3RyZWFtIGltcGxlbWVudGF0aW9u
IG9mIGR3YzNfZ2FkZ2V0X3dha2V1cCgpIEFQSSB3ZSBob2xkIGENCj4gc3BpbmxvY2sgYXMgd2Vs
bC4gQnV0IHllYWggdGhhdCBjYW4gYmUgcmVjdGlmaWVkDQoNCkhvbGRpbmcgYSBzcGluX2xvY2sg
Zm9yIHRoaXMgbG9uZyBpcyBub3QgcmVhc29uYWJsZS4gV2Ugb25seSBuZWVkIHRvDQpsb2NrIHdo
ZW4gc2V0dGluZyBsaW5rIHJlY292ZXJ5IHJlcXVlc3QgYnV0IG5vdCB3aGlsZSBwb2xsaW5nIGZv
ciBEU1RTDQphbmQgd2FpdGluZyBmb3IgdGhlIGxpbmsgdG8gZ28gdXAuDQoNCkJSLA0KVGhpbmgN
Cg0KPiANCj4gc3RhdGljIGludCBkd2MzX2dhZGdldF93YWtldXAoc3RydWN0IHVzYl9nYWRnZXQg
KmcpDQo+IHsNCj4gCXN0cnVjdCBkd2MzCQkqZHdjID0gZ2FkZ2V0X3RvX2R3YyhnKTsNCj4gCXVu
c2lnbmVkIGxvbmcJCWZsYWdzOw0KPiAJaW50CQkJcmV0Ow0KPiANCj4gCXNwaW5fbG9ja19pcnFz
YXZlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gCXJldCA9IF9fZHdjM19nYWRnZXRfd2FrZXVwKGR3
Yyk7DQo+IAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gDQo+
IAlyZXR1cm4gcmV0Ow0KPiB9DQo+IA0KPiANCj4gPiA+IA0KPiA+ID4gVG8gbWFrZSB0aGlzIGdl
bmVyaWMgYWNyb3NzIGhvc3RzLCBJIGhhZCBzd2l0Y2hlZCB0byBpbnRlcnJ1cHQgYmFzZWQNCj4g
PiA+IGFwcHJvYWNoLCBlbmFibGluZyBsaW5rIHN0YXRlIGV2ZW50cyBhbmQgcmV0dXJuIGVycm9y
IHZhbHVlIGltbWVkaWF0ZWx5DQo+ID4gPiBmcm9tIHRoZSBkd2MzX2dhZGdldF93YWtldXAoKSBB
UEkgYWZ0ZXIgZG9pbmcgYSBMRlBTIGhhbmRzaGFrZS4gQnV0DQo+ID4gPiB5ZWFoLCB0aGVuIHdl
IGhhdmUgdG8gcmVseSBvbiB0aGUgcmVzdW1lIGNhbGxiYWNrIGFzIGFuIGluZGljYXRpb24gdGhh
dA0KPiA+ID4gbGluayBpcyB0cmFuc2l0aW9uZWQgdG8gT04gc3RhdGUuDQo+ID4gPiANCj4gPiAN
Cj4gPiBCUiwNCj4gPiBUaGluaA0KPiA+IA==
