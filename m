Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BC34C3B31
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 02:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbiBYBpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 20:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbiBYBpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:45:22 -0500
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA6522321F;
        Thu, 24 Feb 2022 17:44:51 -0800 (PST)
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 24E7345E8A;
        Fri, 25 Feb 2022 01:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1645753491; bh=s/fqScUpHokopw9VgbhCf9an5/jf6hULStRj/69dLOY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=PdgCR7eaDzDIs8dpMWnZNB4RT5gX9usGdbJoWm4kSqaT1Wi44rLyn8WFFSY5l2HK0
         Jmf/UIWRuHCAqP5E3S+F0kHaYm5Ru4DMN/rEKDloejmMvQDD82QbYfBhOm2tsB7WLq
         Bc2ix8RK3zy4ZHLuK0tUrEmm0uaQ9LHn1SbhKIgGZiVffQRtVWe9Ym3/inGktN1oPH
         6XtMajmXa5NIRb9qmhhjxVwZ/2Mmvpx4/mg+xUurMfPW4wxpwNW3++7spj+bFMGiZH
         ftCIO9WRg8eDT/tXVGdo56I1OUQ/biveQMDyMezMmOupxT2qiBUU9wZGqIna3NdxVD
         Np9OO313+v5WQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 69308A0080;
        Fri, 25 Feb 2022 01:44:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id A6CEF40031;
        Fri, 25 Feb 2022 01:44:46 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="TC3XCJAI";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+NTfjbQoM62wkbkVosxsk6sNANSzoFSFxp6SFCNSZOiiodauVzww+GpB0KP5w85HCz4b/aRCS1O38J8wWwzmav9sJNvxnMTFNY2REIdHn0g7ECXyrBa5eRMvAwUs8dArORQTbuotfwufM4gLzOA00TnO3eLPih5CDogtb/nBwYKjw8OgvqWtPFwQR8OqKuDFX+kYT81nrcWK950zfuXf5Ouwvloqb2+UrUPI+eyLXgXqFJNNjYnT3nh9QpcNHxo2SJtZcYmQtY9PSne1OYVgIdCCsDE6bIHWLmPw0OUByN6n6NowSGIne7vzyJf1oGZ9HLqLHKZkyhymQAQVgdzsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/fqScUpHokopw9VgbhCf9an5/jf6hULStRj/69dLOY=;
 b=FoaOCxIZPAeSeW2X8Xq96ldYzBgWMm6X/tREPlPXWqWdLiF248CuJwbFxz8q6s574kYe3VTWHv+Kgi95ln6Pfkk8TPospS+JJy3H5v5lMi1yqYH1Bh1pjzamgaMk7INtqoVBtYkGtPprHNS9qa1VZNyq2db/Wz8s7cKn+Y9/dVsVtob5U+uuoTuG0XEqFUyTBQxwppQKoT8VbgLzJ7Qf1h4IgFHzTkain+VeUeexVWpgId2BPscLJNDYwP0NaRdmWi6BxVx82MFgSYlR3tcnaTsTpqiSifZPVETdQe5wQovA0KIISq2rXUHpbPfOHPhGggOcyswUO3DGgXW1MFNV0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/fqScUpHokopw9VgbhCf9an5/jf6hULStRj/69dLOY=;
 b=TC3XCJAIXoTgKO758+jG83q36BpSNjKuCWKS1t3Goehj2lJuKqGklN+wuEITaONykLxN/5dl8raAUZ72ADl1APkj/KVxn+w/RwkZ+cHv5TYiehfRQycKSLA1zYJp1oQII+7NoDaL4PW1mIVKIVfnGD4/E1Kv5NRtO1sxf9ACM7Y=
Received: from BN8PR12MB4787.namprd12.prod.outlook.com (2603:10b6:408:a1::11)
 by MN2PR12MB3248.namprd12.prod.outlook.com (2603:10b6:208:a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Fri, 25 Feb
 2022 01:44:43 +0000
Received: from BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::19df:84b5:e723:ac84]) by BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::19df:84b5:e723:ac84%7]) with mapi id 15.20.5017.022; Fri, 25 Feb 2022
 01:44:43 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Jung Daehwan <dh10.jung@samsung.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v2 1/2] usb: dwc3: Not set DWC3_EP_END_TRANSFER_PENDING in
 ep cmd fails
Thread-Topic: [PATCH v2 1/2] usb: dwc3: Not set DWC3_EP_END_TRANSFER_PENDING
 in ep cmd fails
Thread-Index: AQHYIZOvXlHACGixbUGMAnHCl5PyK6yTYqcAgADHvYCAALGHgIADVGEAgAA82ACAB34VgIAAlEuAgALM6QCAAD24AIAAAXqAgAADvQA=
Date:   Fri, 25 Feb 2022 01:44:43 +0000
Message-ID: <4371e407-7791-b0b5-dc8c-ad0be09acba4@synopsys.com>
References: <1644836933-141376-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220214111149epcas2p1a1faeda037991885fd6f2f026fa44ec5@epcas2p1.samsung.com>
 <1644836933-141376-2-git-send-email-dh10.jung@samsung.com>
 <ff604504-00df-0c1b-673e-892e42737f7a@synopsys.com>
 <20220215063925.GC144890@ubuntu>
 <63c8c9d1-9b07-a9f2-3639-a38641e19a7a@synopsys.com>
 <6a1322c4-9589-f4de-d42c-d38af2e12e82@quicinc.com>
 <e3332511-82d3-2892-ad72-a0c167273174@synopsys.com>
 <01c4d42e-93cd-d293-f4e3-8c136049d87c@codeaurora.org>
 <894d54ad-b6f9-b942-be99-fe3ad102051b@synopsys.com>
 <dbd00cb1-b5d0-24e7-ef72-dff3765c26cf@codeaurora.org>
 <810de66c-7d73-fae0-9356-b06b48134ad6@synopsys.com>
 <1714910d-f923-d0c7-72a9-0c1d098f783f@codeaurora.org>
In-Reply-To: <1714910d-f923-d0c7-72a9-0c1d098f783f@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79f29490-dc22-4ffa-dc8c-08d9f800654d
x-ms-traffictypediagnostic: MN2PR12MB3248:EE_
x-microsoft-antispam-prvs: <MN2PR12MB32488C946C521DD391D0F66DAA3E9@MN2PR12MB3248.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jvDHMANhC5U7cqczu0gDytruboMQ5gVi4mYpntiL6ax2l0FnAh5fBCCDKBEP1jVZ8Ylo071y7uQfD+Cu2Bp80ZTjIHmn8x4mDyWnPWTeiGYe9HAy4Z/SbLE79qRd3TmKDPt9OkNn18QaKE3k/T++q08ZSwbEwvRCgoAkvqAj0C3o/5hLbXiwdhE0k6o9dm3ROS9VNYcLQ4+yahtb02vduoU4144Rye/+hkm/7cdsmpRAq3mBcgEUimX/l/B/ctAVtStoCnOKHFebVUNIxiGJKXIGrFwFLxtm8PcXXXIuaBDiA8+GlJJz81Vj0Paz5BCWx36d2aCOVlKSt1IezAfZWTalEATW5lKhF0Ot5WBF46OJBRXEtQ0f1fLORAnsHqZ5RRgXBSTZGG/86cugEcNT1UoNbt/28SowaU1zmklpLLFitIbKHBEUO+fCKQsXqsHaQt7HNAbu0pWv95D5Sj8IRMgA70GaFGdx5C3QUq/dUR8Kz30a7l60RAmlkHl4GWjR1FBxcsy6L9tNm6G5vwiqaBVqjIlSQt1vy/Uf+nwX1euPgvffO0/v0WWw3LdkOOFmrRi3t6uGotausXLLgO5wcOcA44hkENoBGgYmKRookQq9JteQFofyY1hdgU8Z+tEUTmJ3dDZWmqz38BAhAZ1FshJItxYOxUgXINvQWbS1b+WhO5tpkoRxGic9HE0tFKvwZGAHIPHDjy9BOdMjDewKT1cKD6RehQt+JLD7lrkFf3IBMhjfkv0f6GuZ6ZeqiCQsiJCs/CYCD8DorpWeRLZpiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB4787.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(76116006)(316002)(6486002)(66476007)(122000001)(66446008)(26005)(66946007)(66556008)(186003)(71200400001)(4326008)(64756008)(110136005)(54906003)(91956017)(2906002)(38070700005)(8676002)(2616005)(38100700002)(86362001)(53546011)(6506007)(6512007)(31686004)(5660300002)(31696002)(36756003)(83380400001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3FwQ3VyZHpoTGIxYTVjV2pUcTEzK2JRMEdqczNnWWRYWW9ybXd1SEpaMmE3?=
 =?utf-8?B?ZWJPWTRKcGYwVkRPVldUU3NTYWxoWXpRRTgxNE51QUc0Qi83ZUxXV0VPQWR6?=
 =?utf-8?B?eWg4MzhBQk8wSGt1UldGZ2pFVlFHTUVOMXJoZzZKclRReEJtbXlPNW9SNXdr?=
 =?utf-8?B?UFkvVzc3MURlSFdhRitTSmd5M0tGSk5oRnc4ZllmY2FLRjRIMWZMeUR6YVpO?=
 =?utf-8?B?ZEhZQTRaNkxJSkxKVlE1TVdTcytFR2tvY25OVDJlcHQxZUNOZmc5NGJudW82?=
 =?utf-8?B?TGxJbzlYUGt2UkY2eXMydDJWOWhsZEtwZUhWc1JqTDRVdVpWSXZCMERzbVFP?=
 =?utf-8?B?QzhuejJWajFqcm1OenU2RFdOTWtrL3gxV0JJUmpwSFlqaWpYN09HdC9jWWVK?=
 =?utf-8?B?OHgvbm1hMStSZXlTY1RQNENaVE1WdlFvZEJkS1NCTUhiRFNnNHZwUHNoa0hC?=
 =?utf-8?B?Y1k1Nk9RdDl2Rmc3MEErREZweU5iMDdDZi9pSWttT0N4Y2hKeXRVenkydVox?=
 =?utf-8?B?Z2Q4eXhCbWNrNSs1WkQzTnZuUDlOS0MvejQ5UkxiejlHU2pFRW41QnNGUkw2?=
 =?utf-8?B?SHF4QTZSYVdxWHp5WWhnYThqL1NuQ1p3QTNickR0L3p6U3lYVXc3Z205Z1FZ?=
 =?utf-8?B?Mytlb05iMWd1c0I1MEZDRC9JSWxpTmZVT3hRL3UwaHpjb090Q1lqNGhJa3BS?=
 =?utf-8?B?N1FHU3hzNmRuUkNZVFM3RHNWTDMwbTBzQ1hKTEI2dzk3amRka09tS2lqZ3hv?=
 =?utf-8?B?cHBxRkcxME5GVm5qTlEyMi9BNVZ0Q216cm5jcDB1NGFBREh2VkVYU05kK0R3?=
 =?utf-8?B?QVhmRFdGZ21iaVVGNU5GTmFzbDRPeUhKaG0vMmx2Y0ZMTTgwNmtYVVNzV1Y4?=
 =?utf-8?B?b3N5Y1lHS1BwUGJFMkltMzhFakdNdUNnampYL05TQklzU0VWVUlSTW8yWmlO?=
 =?utf-8?B?MUFEeVYrbXJvSWdjVVVteGNtMVpNSHdvelJXSXlUektpaUNlalhUUVRIOFpM?=
 =?utf-8?B?NmtMVjREcldjUUlQR3hRTVdBVUx3OEhYNTRFUDREZTRoUHBHVUhlN01TTkxP?=
 =?utf-8?B?S25HTVRnRGVyY0lnUWJVYnFMbnFzMEFqOGlmcDZYOHZOelF5dnhkQklLK08x?=
 =?utf-8?B?VGRvMDloZ3YxQ1RSZDlYOHNJZTY5RlZvVzlsWkJMb0QwTmVPUHllcmJlUlgx?=
 =?utf-8?B?bVlvVEh2RlZBblRTMnZSUFpEUnhLVytDTG5iLzh1cW9uV1RVaDBkTzhmdXBK?=
 =?utf-8?B?QXBzZWVKaDNWWlUybytFSWwxS1ljb2g5MkU5RHBUWmlOclF0V3M5MlBxc3Nr?=
 =?utf-8?B?K0lnS2xUUkM3cm1SNVFJd3RkdGZOTDJUUnBnQzk5V3FIWGJHWnBWSmo5YW9r?=
 =?utf-8?B?WGVHMXlhUTlleFhaTGxVV1l5UFMwMlpTT1JRMFpEU3I1c0pYOGVZZmtXaHBO?=
 =?utf-8?B?WkwvR0hUUlVyaGI1MGQveWxzalNxcFdvTzBCZ1BzcTNCRS9MU2FiZWw4clIv?=
 =?utf-8?B?bzFYZS8xVUlNNWV4UjlaMElwMExKMitJbHEyMWxyMUxyNHpPTzRjY0V6Q2Zr?=
 =?utf-8?B?VHhZbVZZTU51ZWp5VkdVSSs4bU0vU3V0bmd5ZFNrVHAzZzl5SDZZTTQ1VjBp?=
 =?utf-8?B?Uk1scERJWGlOc1BSYWg1a1pGTmdkWVd5bmhOeEFqalRxMFlvV2lZcHgrQzdF?=
 =?utf-8?B?c1BvREQ1YTJMREppV3p2Slk5NXlhZXhmWVFRN2U4NXRtZUJIQ3gvOTFjejkv?=
 =?utf-8?B?bzQyTUZ3ZXdWK0YrdXBhbHVnaFhsbGthVlpZSEhHL3g1QlVocW9uOXhUVzU1?=
 =?utf-8?B?enladWN5OTJhWkMrNzRobEZGakVuWXNXN1hIY0lXdzUvemJCc1FDNldGRmlW?=
 =?utf-8?B?UnVyY2pScHlLdjdUTGtwRHc1RldSck5wOEd5VVdWd0MyWWlWY1Q1bE12aG5p?=
 =?utf-8?B?NUtwMXMzemFITHBTbXhKWDE4R1pVN2d2N2Z2eVNSb1lHUVVoblN3aXY4ek9w?=
 =?utf-8?B?VnpiVksxWFF1VFFPYmdqaXg0QXRYSnM1bUx6N3lwL2ovM3RaT3JKeG5zTGc4?=
 =?utf-8?B?YXJ4Q2ViZjZmQVNJQXMrdEtpa0kzS2NxRjdRYkxmV1o5SHoxM3dTVjVzaC9j?=
 =?utf-8?B?Q1FDZmpsRUNkUkJybjZHVTl1UUlqdElDSUhzY0NmQTNGWGxITlJMUEF6VHdM?=
 =?utf-8?B?Qnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE44F114CA7EE6448FC42C5ACCC86749@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB4787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f29490-dc22-4ffa-dc8c-08d9f800654d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 01:44:43.1519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D5EUsV/MZvso97KYg7/IBQNToZGo5phURFc5VmS66iSE0IL9wTVOSjT8o2nXB085kEbkQzPBdaV3jpVFwpGzMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3248
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2VzbGV5IENoZW5nIHdyb3RlOg0KPiBIaSBUaGluaCwNCj4gDQo+IE9uIDIvMjQvMjAyMiA1OjI2
IFBNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+PiBIaSBXZXNsZXksDQo+Pg0KPj4gV2VzbGV5IENo
ZW5nIHdyb3RlOg0KPj4+IEhpIFRoaW5oLA0KPj4+DQo+Pj4gT24gMi8yMi8yMDIyIDY6NTkgUE0s
IFRoaW5oIE5ndXllbiB3cm90ZToNCj4+Pj4gSGkgV2VzbGV5LA0KPj4+Pg0KPj4NCj4+IDxzbmlw
Pg0KPj4NCj4+Pj4NCj4+Pj4gQ2FuIHlvdSBwcm92aWRlIGEgZnVsbCB0cmFjZT8NCj4+Pj4NCj4+
PiBTb3JyeSBmb3IgZG9pbmcgdGhpcywgYnV0IHdlIGRpZG4ndCBoYXZlIGEgd2F5IHRvIHNoYXJl
IHRoZSBmaWxlDQo+Pj4gZGlyZWN0bHksIHNvIEkgaGF2ZSB0byBwYXN0ZSB0aGUgdHJhY2UgYmVs
b3cuIDovDQo+Pj4NCj4+Pj4gQnR3LCB3aGVuIHlvdSBleHBlcmltZW50IHdpdGggaW5jcmVhc2lu
ZyB0aGUgdGltZW91dCB0byAxMCBzZWNvbmRzLCBkaWQNCj4+Pj4geW91IHVzZSB0aGUgbWRlbGF5
KCkgaW4gZWFjaCBsb29wPyBUaGUgZGVsdGEgdGltZSBmb3IgRW5kIFRyYW5zZmVyDQo+Pj4+IHRp
bWVvdXQgaGVyZSBzZWVtcyB2ZXJ5IHNtYWxsLg0KPj4+Pg0KPj4+IFRoaXMgcGFydGljdWxhciBy
dW4gZGlkIG5vdCBtb2RpZnkgdGhlIHRpbWVvdXQgZm9yIHRoZSBjbWQgc3RhdHVzIHBvbGxpbmcu
DQo+Pj4NCj4+PiBJcyB0aGF0IHNvbWV0aGluZyB0aGF0IHlvdSB3YW50IHRvIHRyeT8gIE5vdCBw
ZXJ0YWluaW5nIHRvIHRoaXMgZGVxdWV1ZQ0KPj4+IHNpdHVhdGlvbiwgZHVyaW5nIHRoZSBwdWxs
dXAgZGlzYWJsZSBwYXRoIGRlYnVnLCBJIG5vdGljZWQgdGhhdCBhcyBsb25nDQo+Pj4gYXMgdGhl
cmUgd2FzIGEgcGVuZGluZyBFUDAgU0VUVVAgcGFja2V0IChub3QgZGF0YS9zdGF0dXMpIGNhY2hl
ZCBpbiB0aGUNCj4+PiBjb250cm9sbGVyLCBpdCB3b3VsZCBhbHNvIGhhdmUgZW5keGZlciB0aW1l
b3V0cyBvbiBub24tY29udHJvbCBFUHMuICBXZQ0KPj4+IHdlcmUgYWJsZSB0byBjYXB0dXJlIGEg
YnVzIHNuaWZmZXIgbG9nICsgZnRyYWNlLCBhbmQgaXQgc2hvd2VkIHRoYXQgYXQNCj4+PiB0aGUg
cG9pbnQgb2YgdGhlIGVycm9yLCB0aGUgbGVjcm95L2J1cyBsb2cgc2F3IGEgU0VUVVAgdG9rZW4g
QUNLJ2VkLA0KPj4+IHdoaWxlIG9uIHRoZSBmdHJhY2UsIHRoZXJlIHdlcmUgZW5keGZlciB0aW1l
b3V0cyBmb3IgYWxsIG5vbi1jb250cm9sIEVQcw0KPj4+IChkdWUgdG8gdGhlIGR3YzNfZ2FkZ2V0
X3N0b3BfYWN0aXZlX3RyYW5zZmVycygpIGNhbGwpDQo+Pj4NCj4+PiBUaGFua3MNCj4+PiBXZXNs
ZXkNCj4+Pg0KPj4+IFRSQUNFDQo+Pj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+Pj4NCj4+DQo+PiA8c25pcD4N
Cj4+DQo+Pj4gWyAxMDIzLjkxMjU1MDA1MCAgICAgICAweDRhZjY2NmZkMl0gICBkYmdfdHJhY2Vf
bG9nX2N0cmw6IENsZWFyIEVuZHBvaW50DQo+Pj4gRmVhdHVyZShIYWx0IGVwNGluKQ0KPj4+IFsg
MTAyMy45MTI5MzQ3MzggICAgICAgMHg0YWY2NjhjYWJdICAgZGJnX3NlbmRfZXBfY21kOiBlcDBv
dXQ6IGNtZCAnU2V0DQo+Pj4gU3RhbGwnIFs0MDRdIHBhcmFtcyAwMDAwMDAwMCAwMDAwMDAwMCAw
MDAwMDAwMCAtLT4gc3RhdHVzOiBTdWNjZXNzZnVsDQo+Pj4gWyAxMDIzLjkxMzM2MTU2MSAgICAg
ICAweDRhZjY2YWNhZV0gICBkYmdfc2VuZF9lcF9jbWQ6IGVwMG91dDogY21kDQo+Pj4gJ1N0YXJ0
IFRyYW5zZmVyJyBbNDA2XSBwYXJhbXMgMDAwMDAwMDAgZWZmZmEwMDAgMDAwMDAwMDAgLS0+IHN0
YXR1czoNCj4+PiBTdWNjZXNzZnVsDQo+Pj4gWyAxMDI0LjMzNjQ4MDU3MyAgICAgICAweDRhZmUy
YTI5Yl0gICBkYmdfdHJhY2VfbG9nX2N0cmw6IENsZWFyIEVuZHBvaW50DQo+Pj4gRmVhdHVyZShI
YWx0IGVwNWluKQ0KPj4+IFsgMTAyNC4zMzY4NTU1NzMgICAgICAgMHg0YWZlMmJlYmNdICAgZGJn
X3NlbmRfZXBfY21kOiBlcDVpbjogY21kICdDbGVhcg0KPj4+IFN0YWxsJyBbNDA1XSBwYXJhbXMg
MDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgLS0+IHN0YXR1czogU3VjY2Vzc2Z1bA0KPj4+IFsg
MTAyNC4zMzcyNjQ1MzEgICAgICAgMHg0YWZlMmRkNjhdICAgZGJnX3NlbmRfZXBfY21kOiBlcDBp
bjogY21kICdTdGFydA0KPj4+IFRyYW5zZmVyJyBbNDA2XSBwYXJhbXMgMDAwMDAwMDAgZWZmZmEw
MDAgMDAwMDAwMDAgLS0+IHN0YXR1czogU3VjY2Vzc2Z1bA0KPj4+IFsgMTAyNC4zNTE5MTAxNTYg
ICAgICAgMHg0YWZlNzI3ZDRdICAgZGJnX3NlbmRfZXBfY21kOiBlcDBvdXQ6IGNtZA0KPj4+ICdT
dGFydCBUcmFuc2ZlcicgWzQwNl0gcGFyYW1zIDAwMDAwMDAwIGVmZmZhMDAwIDAwMDAwMDAwIC0t
PiBzdGF0dXM6DQo+Pj4gU3VjY2Vzc2Z1bA0KPj4+IFsgMTAyNC4zNjMxMzk4OTYgICAgICAgMHg0
YWZlYTcyMGZdICAgZGJnX3RyYWNlX2xvZ19jdHJsOiBDbGVhciBFbmRwb2ludA0KPj4+IEZlYXR1
cmUoSGFsdCBlcDRpbikNCj4+PiBbIDEwMjQuMzYzODk4MjgxICAgICAgIDB4NGFmZWFhYWYwXSAg
IGRiZ19zZW5kX2VwX2NtZDogZXAwb3V0OiBjbWQgJ1NldA0KPj4+IFN0YWxsJyBbNDA0XSBwYXJh
bXMgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgLS0+IHN0YXR1czogU3VjY2Vzc2Z1bA0KPj4+
IFsgMTAyNC4zNjQ3MzQwMTAgICAgICAgMHg0YWZlYWU5OWVdICAgZGJnX3NlbmRfZXBfY21kOiBl
cDBvdXQ6IGNtZA0KPj4+ICdTdGFydCBUcmFuc2ZlcicgWzQwNl0gcGFyYW1zIDAwMDAwMDAwIGVm
ZmZhMDAwIDAwMDAwMDAwIC0tPiBzdGF0dXM6DQo+Pj4gU3VjY2Vzc2Z1bA0KPj4+IFsgMTAyNC43
NzYxNzM4MDMgICAgICAgMHg0YjA2MzczOWFdICAgZGJnX3RyYWNlX2xvZ19jdHJsOiBDbGVhciBF
bmRwb2ludA0KPj4+IEZlYXR1cmUoSGFsdCBlcDVpbikNCj4+PiBbIDEwMjQuNzc2OTA3MTg4ICAg
ICAgIDB4NGIwNjNhYTliXSAgIGRiZ19zZW5kX2VwX2NtZDogZXA1aW46IGNtZCAnQ2xlYXINCj4+
PiBTdGFsbCcgWzQwNV0gcGFyYW1zIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIC0tPiBzdGF0
dXM6IFN1Y2Nlc3NmdWwNCj4+PiBbIDEwMjQuNzc3NjQ2MTQ3ICAgICAgIDB4NGIwNjNlMjA4XSAg
IGRiZ19zZW5kX2VwX2NtZDogZXAwaW46IGNtZCAnU3RhcnQNCj4+PiBUcmFuc2ZlcicgWzQwNl0g
cGFyYW1zIDAwMDAwMDAwIGVmZmZhMDAwIDAwMDAwMDAwIC0tPiBzdGF0dXM6IFN1Y2Nlc3NmdWwN
Cj4+PiBbIDEwMjQuNzg4NjQxOTgwICAgICAgIDB4NGIwNjcxYWI4XSAgIGRiZ19zZW5kX2VwX2Nt
ZDogZXAwb3V0OiBjbWQNCj4+PiAnU3RhcnQgVHJhbnNmZXInIFs0MDZdIHBhcmFtcyAwMDAwMDAw
MCBlZmZmYTAwMCAwMDAwMDAwMCAtLT4gc3RhdHVzOg0KPj4+IFN1Y2Nlc3NmdWwNCj4+PiBbIDEw
MjQuNzk5NjgyMzk3ICAgICAgIDB4NGIwNmE1NmJmXSAgIGRiZ190cmFjZV9sb2dfY3RybDogQ2xl
YXIgRW5kcG9pbnQNCj4+PiBGZWF0dXJlKEhhbHQgZXA0aW4pDQo+Pj4gWyAxMDI0LjgwMDQ0MjYw
NSAgICAgICAweDRiMDZhOGZjM10gICBkYmdfc2VuZF9lcF9jbWQ6IGVwMG91dDogY21kICdTZXQN
Cj4+PiBTdGFsbCcgWzQwNF0gcGFyYW1zIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIC0tPiBz
dGF0dXM6IFN1Y2Nlc3NmdWwNCj4+PiBbIDEwMjQuODAxMTg0NTg0ICAgICAgIDB4NGIwNmFjNzY5
XSAgIGRiZ19zZW5kX2VwX2NtZDogZXAwb3V0OiBjbWQNCj4+PiAnU3RhcnQgVHJhbnNmZXInIFs0
MDZdIHBhcmFtcyAwMDAwMDAwMCBlZmZmYTAwMCAwMDAwMDAwMCAtLT4gc3RhdHVzOg0KPj4+IFN1
Y2Nlc3NmdWwNCj4+PiBbIDEwMjUuMjIyMTczNzUyICAgICAgIDB4NGIwZTYxZDk5XSAgIGRiZ190
cmFjZV9sb2dfY3RybDogQ2xlYXIgRW5kcG9pbnQNCj4+PiBGZWF0dXJlKEhhbHQgZXA1aW4pDQo+
Pj4gWyAxMDI1LjIyMjk5MTY2OSAgICAgICAweDRiMGU2NWFmMV0gICBkYmdfc2VuZF9lcF9jbWQ6
IGVwNWluOiBjbWQgJ0NsZWFyDQo+Pj4gU3RhbGwnIFs0MDVdIHBhcmFtcyAwMDAwMDAwMCAwMDAw
MDAwMCAwMDAwMDAwMCAtLT4gc3RhdHVzOiBTdWNjZXNzZnVsDQo+Pj4gWyAxMDI1LjIyMzg1MDcz
MSAgICAgICAweDRiMGU2OWI1Zl0gICBkYmdfc2VuZF9lcF9jbWQ6IGVwMGluOiBjbWQgJ1N0YXJ0
DQo+Pj4gVHJhbnNmZXInIFs0MDZdIHBhcmFtcyAwMDAwMDAwMCBlZmZmYTAwMCAwMDAwMDAwMCAt
LT4gc3RhdHVzOiBTdWNjZXNzZnVsDQo+Pj4gWyAxMDI1LjIzOTAyMzQ5MiAgICAgICAweDRiMGVi
MGQ1NF0gICBkYmdfc2VuZF9lcF9jbWQ6IGVwMG91dDogY21kDQo+Pj4gJ1N0YXJ0IFRyYW5zZmVy
JyBbNDA2XSBwYXJhbXMgMDAwMDAwMDAgZWZmZmEwMDAgMDAwMDAwMDAgLS0+IHN0YXR1czoNCj4+
PiBTdWNjZXNzZnVsDQo+Pj4gWyAxMDI1LjI0ODk2MzE3OSAgICAgICAweDRiMGVkZjZjZV0gICBk
YmdfdHJhY2VfbG9nX2N0cmw6IENsZWFyIEVuZHBvaW50DQo+Pj4gRmVhdHVyZShIYWx0IGVwNGlu
KQ0KPj4+IFsgMTAyNS4yNDk3MDk4NDYgICAgICAgMHg0YjBlZTJlY2RdICAgZGJnX3NlbmRfZXBf
Y21kOiBlcDBvdXQ6IGNtZCAnU2V0DQo+Pj4gU3RhbGwnIFs0MDRdIHBhcmFtcyAwMDAwMDAwMCAw
MDAwMDAwMCAwMDAwMDAwMCAtLT4gc3RhdHVzOiBTdWNjZXNzZnVsDQo+Pj4gWyAxMDI1LjI1MDUz
MzQ0MCAgICAgICAweDRiMGVlNmM5M10gICBkYmdfc2VuZF9lcF9jbWQ6IGVwMG91dDogY21kDQo+
Pj4gJ1N0YXJ0IFRyYW5zZmVyJyBbNDA2XSBwYXJhbXMgMDAwMDAwMDAgZWZmZmEwMDAgMDAwMDAw
MDAgLS0+IHN0YXR1czoNCj4+PiBTdWNjZXNzZnVsDQo+Pj4gWyAxMDI1LjY2NzA4NDUzNSAgICAg
ICAweDRiMTY4NzVlN10gICBkYmdfdHJhY2VfbG9nX2N0cmw6IENsZWFyIEVuZHBvaW50DQo+Pj4g
RmVhdHVyZShIYWx0IGVwNWluKQ0KPj4+IFsgMTAyNS42Njc4Mjc3NjQgICAgICAgMHg0YjE2OGFk
YTZdICAgZGJnX3NlbmRfZXBfY21kOiBlcDVpbjogY21kICdDbGVhcg0KPj4+IFN0YWxsJyBbNDA1
XSBwYXJhbXMgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgLS0+IHN0YXR1czogU3VjY2Vzc2Z1
bA0KPj4+IFsgMTAyNS42Njg2MzU5OTMgICAgICAgMHg0YjE2OGVhNDRdICAgZGJnX3NlbmRfZXBf
Y21kOiBlcDBpbjogY21kICdTdGFydA0KPj4+IFRyYW5zZmVyJyBbNDA2XSBwYXJhbXMgMDAwMDAw
MDAgZWZmZmEwMDAgMDAwMDAwMDAgLS0+IHN0YXR1czogU3VjY2Vzc2Z1bA0KPj4+IFsgMTAyNS42
NzQ3Nzc3NjQgICAgICAgMHg0YjE2YWI2ZTddICAgZGJnX3NlbmRfZXBfY21kOiBlcDBvdXQ6IGNt
ZA0KPj4+ICdTdGFydCBUcmFuc2ZlcicgWzQwNl0gcGFyYW1zIDAwMDAwMDAwIGVmZmZhMDAwIDAw
MDAwMDAwIC0tPiBzdGF0dXM6DQo+Pj4gU3VjY2Vzc2Z1bA0KPj4+IFsgMTAyNS42ODQ3MzM1OTcg
ICAgICAgMHg0YjE2ZGExOTddICAgZGJnX3RyYWNlX2xvZ19jdHJsOiBDbGVhciBFbmRwb2ludA0K
Pj4+IEZlYXR1cmUoSGFsdCBlcDRpbikNCj4+PiBbIDEwMjUuNjg1MzM2MTUwICAgICAgIDB4NGIx
NmRjZWM3XSAgIGRiZ19zZW5kX2VwX2NtZDogZXAwb3V0OiBjbWQgJ1NldA0KPj4+IFN0YWxsJyBb
NDA0XSBwYXJhbXMgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgLS0+IHN0YXR1czogU3VjY2Vz
c2Z1bA0KPj4+IFsgMTAyNS42ODYxMTI2MDggICAgICAgMHg0YjE2ZTA5MDRdICAgZGJnX3NlbmRf
ZXBfY21kOiBlcDBvdXQ6IGNtZA0KPj4+ICdTdGFydCBUcmFuc2ZlcicgWzQwNl0gcGFyYW1zIDAw
MDAwMDAwIGVmZmZhMDAwIDAwMDAwMDAwIC0tPiBzdGF0dXM6DQo+Pj4gU3VjY2Vzc2Z1bA0KPj4+
IFsgMTAyNS42OTg4NDIzNDcgICAgICAgMHg0YjE3MWMzYmZdICAgZGJnX3NlbmRfZXBfY21kOiBl
cDBvdXQ6IGNtZCAnU2V0DQo+Pj4gU3RhbGwnIFs0MDRdIHBhcmFtcyAwMDAwMDAwMCAwMDAwMDAw
MCAwMDAwMDAwMCAtLT4gc3RhdHVzOiBTdWNjZXNzZnVsDQo+Pj4gWyAxMDI2LjQ0NDA1MTU2OSAg
ICAgICAweDRiMjRjMTY3MF0gICBkYmdfc2VuZF9lcF9jbWQ6IGVwMG91dDogY21kDQo+Pj4gJ1N0
YXJ0IFRyYW5zZmVyJyBbNDA2XSBwYXJhbXMgMDAwMDAwMDAgZWZmZmEwMDAgMDAwMDAwMDAgLS0+
IHN0YXR1czogTm8NCj4+PiBSZXNvdXJjZQ0KPj4NCj4+IFdoeSBkaWQgdGhpcyBmYWlsIHdpdGgg
Tm8gUmVzb3VyY2U/IFdhcyBpdCBzZW50IGJlZm9yZSB0aGUgY29udHJvbCBUUkINCj4+IGNvbXBs
ZXRpb24/DQo+Pg0KPj4+IFsgMTAyNy4yMjU3MDU0MjUgICAgICAgMHg0YjMzMTE2NzhdICAgZGJn
X3RyYWNlX2xvZ19jdHJsOiBDbGVhciBFbmRwb2ludA0KPj4+IEZlYXR1cmUoSGFsdCBlcDVpbikN
Cj4+PiBbIDEwMjcuMjI1ODIwMTY1ICAgICAgIDB4NGIzMzExZjE0XSAgIGRiZ19zZW5kX2VwX2Nt
ZDogZXA1aW46IGNtZCAnQ2xlYXINCj4+PiBTdGFsbCcgWzQwNV0gcGFyYW1zIDAwMDAwMDAwIDAw
MDAwMDAwIDAwMDAwMDAwIC0tPiBzdGF0dXM6IFN1Y2Nlc3NmdWwNCj4+PiBbIDEwMjcuMjI1OTMx
NDY3ICAgICAgIDB4NGIzMzEyNzZjXSAgIGRiZ19zZW5kX2VwX2NtZDogZXAwaW46IGNtZCAnU3Rh
cnQNCj4+PiBUcmFuc2ZlcicgWzQwNl0gcGFyYW1zIDAwMDAwMDAwIGVmZmZhMDAwIDAwMDAwMDAw
IC0tPiBzdGF0dXM6IFN1Y2Nlc3NmdWwNCj4+PiBbIDEwMjcuMjM0MzExNDY3ICAgICAgIDB4NGIz
MzM5YmVkXSAgIGRiZ19lcF9kZXF1ZXVlOiBlcDdpbjogcmVxDQo+Pj4gZmZmZmZmODdmOTliOGYw
MCBsZW5ndGggMC82MTY5NiB6c0kgPT0+IC0xMTUNCj4+PiBbIDEwMjcuMjQ3NDA5MTIzICAgICAg
IDB4NGIzMzc3MjNmXSAgIGRiZ19zZW5kX2VwX2NtZDogZXA3aW46IGNtZCAnRW5kDQo+Pj4gVHJh
bnNmZXInIFtmMGQwOF0gcGFyYW1zIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIC0tPiBzdGF0
dXM6IFRpbWVkIE91dA0KPj4+DQo+Pg0KPj4gSWYgdGhlIFN0YXJ0IFRyYW5zZmVyIGZvciBlcDAg
ZmFpbGVkIGFuZCB0aGUgU2V0dXAgcGFja2V0IGNhbid0IGJlDQo+PiBETUEnZWQgb3V0LCB0aGUg
RW5kIFRyYW5zZmVyIG1heSBub3QgZ28gdGhyb3VnaC4NCj4+DQo+PiBDYW4geW91IGxlYXZlIHRo
ZSBsb2cgdW5maWx0ZXJlZCBhbmQgaXMgaXQgcG9zc2libGUgdG8gc2VuZCBhcw0KPj4gYXR0YWNo
bWVudD8gSXQncyBtaXNzaW5nIHNvbWUgaW1wb3J0YW50IGluZm8gaW4gdGhpcyBsb2cuDQo+Pg0K
PiBBcmUgdGhlcmUgYW55IHNwZWNpZmljIGxvZ3MgeW91IHdlcmUgbG9va2luZyBmb3I/DQo+IHRy
YWNlX2R3YzNfZXZlbnQNCj4gdHJhY2VfZHdjM19wcmVwYXJlX3RyYg0KPiANCj4gUGFydCBvZiBy
ZXByb2R1Y2luZyB0aGlzIGlzc3VlIHdpbGwgbm90IGFsbG93IG1lIHRvIGVuYWJsZSB0cmFjaW5n
LCBzbyBJDQo+IGhhdmUgdG8gbWFrZSBjaGFuZ2VzIGluIG91ciBkcml2ZXIgdG8gcmVyb3V0ZSB0
aGUgbG9ncyBlbHNld2hlcmUuICBTbw0KPiBmYXIgSSd2ZSBhZGRlZCBjaGFuZ2VzIHRvIGRvOg0K
PiAJdHJhY2VfZHdjM19jdHJsX3JlcQ0KPiAJdHJhY2VfZHdjM19lcF9xdWV1ZQ0KPiAJdHJhY2Vf
ZHdjM19lcF9kZXF1ZXVlDQo+IAl0cmFjZV9kd2MzX2dhZGdldF9naXZlYmFjaw0KPiAJdHJhY2Vf
ZHdjM19nYWRnZXRfZXBfY21kDQo+IA0KPiBJIGNhbiBhZGQgdGhlIGFib3ZlIDIgdHJhY2Vwb2lu
dHMgYXMgd2VsbCwgYnV0IHdvbmRlcmluZyBpZiB5b3UgbmVlZGVkDQo+IGFueXRoaW5nIGVsc2Uu
DQo+IA0KDQpJZiBwb3NzaWJsZSwgcGxlYXNlIGhhdmUgdGhlc2UgaW4gYWRkaXRpb24gdG8gdGhl
IGFib3ZlLg0KDQp0cmFjZV9kd2MzX2V2ZW50DQp0cmFjZV9kd2MzX2NvbXBsZXRlX3RyYg0KDQpU
aGFua3MsDQpUaGluaA0K
