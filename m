Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76ADA590A36
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 04:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbiHLCTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 22:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236151AbiHLCTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 22:19:14 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519E2A2614;
        Thu, 11 Aug 2022 19:19:13 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27BHgLDg007182;
        Thu, 11 Aug 2022 19:19:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=y8mBfw2aySgfQlURw3oUxFU+y07rXQ+GzabwUcGdJw0=;
 b=dPfrmKCEvCvWWkiY8vBoIGKWR7hjXglcex481LssV+5Kf83aYkOD2LueyT5di2pv9W3r
 4fPEx/ZiQygIeSj9Wi7zbRf2BI9oLosV/ok0Sz1OzYO7jTvmvYJHbYm2jXnQ1lHwxsv8
 nfTiXvUO6Ndly8zEuoQO1efPVcgkovDIYEK6ZX/VmYMdgYsbQjS7UnhWSuKDj8eeRUUX
 tQ90oXOA93vmNdsWXK5GqwB10a78GmekqBZ4KWAOjFXGOeOGqlZbqFpAHoCvEi2/tgwZ
 dWFRa/MNKynF53+EJ9YGllFwPKx2GNHVTf3ePhbbr6+nEBZK1i9Xv8nd7pTbkRIeqt5c vA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3huwptn5d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 19:19:06 -0700
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A2BC140086;
        Fri, 12 Aug 2022 02:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1660270745; bh=y8mBfw2aySgfQlURw3oUxFU+y07rXQ+GzabwUcGdJw0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=WaMEOAoGmeqTokUEEPHTdTkHdj/WTBC9j5bwdy3MjBsbM5iFTDh+e2YXKOI8FrjPz
         vMrcA0PGzXEFjf0hbf1Ak0QE8lg1dUxC0SIvwI+cd02r4zDVVICygJSQBm7M++CUkd
         Gw5IGb1Rj3G0bKVJdcixSUQPXJ6ytucVlVnslb0we9AawxIgZ26gVuDLFbB5EEl0Dt
         CVd46UsisF8ZoveINHMiW1+E2OJsWN9dQr84790seOQvJRh+pMCwX1MPYMX8NpMer/
         5qSvW72SkuIfzA9mq50S4zS0b1Xn3f0ccs+ItkI+S3ujBmJOYUJcCePqdYtgI7nvZl
         JAvAxaL1spTpQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 1DFA5A0071;
        Fri, 12 Aug 2022 02:19:04 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 86EA340087;
        Fri, 12 Aug 2022 02:19:04 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="YDQZocKk";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmLLgNP4ITkd7SG1yVMyH6S3ahrnfTAHzQjmRX0XspVaHXaxXtxXMOVe9LY3zmjtthGILk2fzIgi3pSEtxm2ohyS7yhia69yJu+bAWnA+n98vBl0SpOnqwvH3+/Rfsc/0FzodZRlO1iv/A9sLTdlHVISSkKFQcx9eb50rONXvlVUN8eY6ZM6bkj+BrzRUK8qT+AlWbqfLqgIL2uy+gAjAkciR0Prkk0QHEIB7G1ILt7lB3Nhb0Kj1KzBMu3bD2l0LUmlqor2S8VO42z+qU2fo7Y2+tlpPQzSODGKjVP777JT7A8zoyW/kkbfWKo2521UCm40rtaJa2ba6g5Pct1H+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8mBfw2aySgfQlURw3oUxFU+y07rXQ+GzabwUcGdJw0=;
 b=STWqjHhr4OZNugy/tNGo9FKG7dGJryfeJZhHvE/A2YV3R4NDKQHgii/2mlGZ0WBAAqG5eQypmJWXUnhmGRznwg6D7hhDhA1zxGG7SpYkCYETScZBV1s3CT3AuZwRTnjReBx5W2d8STt2UZKXojTjuUP0d+dRmiyL8sSoQQ3+eNKD90ImjteUsXYlrbzporSgQ6fvvBuHDhVlvZF6wEWldozaZeRj4N7G/znRtEI16HVaUjSVDq6tLOcoTviL+qU/0pw7uw31ic+vzl+WWDoOc/OjfDzsQPZ3aCrq3GGUiza0FSr8ddWn84bdgkGBSGPHPMMUcgOHCQTFxJP+vmxjFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8mBfw2aySgfQlURw3oUxFU+y07rXQ+GzabwUcGdJw0=;
 b=YDQZocKkY0TAVV7Vx8ezMORudgWli1MSN4udRHXnKSB9DtsZIDBsvn9Tv2RFm/QaIwsSlFWv7zXK/un1s9pGYwlQgd72zgJIZnKxQYEfmqm6sdFCAvJTAF3/qC9D0HywlsWyMZE9biw39riP4dja0UIg1SuuaV3B6Tce5QEM7OA=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Fri, 12 Aug
 2022 02:19:01 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c%7]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 02:19:01 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Serrao <quic_eserrao@quicinc.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_mrana@quicinc.com" <quic_mrana@quicinc.com>
Subject: Re: [PATCH 2/5] usb: gadget: Add function wakeup support
Thread-Topic: [PATCH 2/5] usb: gadget: Add function wakeup support
Thread-Index: AQHYpqSxYg+mSBtinkWEjfftWY3s8a2cSDKAgAMApwCAAD6nAIAHe4yAgABbB4CAAtc4AIAAXAqAgAAFJ4A=
Date:   Fri, 12 Aug 2022 02:19:01 +0000
Message-ID: <e3bcfd4c-efdb-c7b0-4e94-1afcd3b8eb73@synopsys.com>
References: <1659467920-9095-1-git-send-email-quic_eserrao@quicinc.com>
 <1659467920-9095-3-git-send-email-quic_eserrao@quicinc.com>
 <049219f1-8c68-e4cc-7bf9-1e8c214e80aa@synopsys.com>
 <32a0765e-00d9-1a67-bf36-4060c5fcb008@quicinc.com>
 <8705d52e-2181-aebd-43b8-2c8d021339c7@synopsys.com>
 <5ad70f41-622e-2d75-7c53-89aba1255a5f@quicinc.com>
 <ac8e012f-08f3-baed-ead0-231f0527864c@synopsys.com>
 <b123b543-6c82-2787-9730-addd3e6e70a3@quicinc.com>
 <98966b47-0bc5-6ec0-ec80-5eff1d71d9fd@synopsys.com>
In-Reply-To: <98966b47-0bc5-6ec0-ec80-5eff1d71d9fd@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 019af307-a94c-4026-81d7-08da7c090593
x-ms-traffictypediagnostic: BL0PR12MB4849:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eh6OzbdbtzI5d93tTKMHeizYBBhtssqyAoap5FOAWePt8sZ7UvDeNMKw2Ad6udDsOnYSriPKFF6wWR3xB1rteg2MVzCtvafeJDMRdGMTjjRvICWt7ngnO7GOpyzzQyd1QRomEFUk5GKRXweWDm2uj2wVhUE9jEamBPWhgSMPlxlssw4oNDYtJHPeo5TeUP/79fIc+ybqGFpGXa89kDCRsHq9zYTGRQ/BAkd3lewftWz1NGzjGNi718IRQ2GjHe1MuXBP9je+Ch7sxiEUT9FZpikJJ4eF2u/ANCGJ6H2qnXTwc0QSiLms6Gg8tLbE2QxAnL81CDdb/I9mGGHVjsgGcEleTc+kzM5FqSV5FWgA09mhXM7Inqxnr2nc7+EnAOnh5TgIZTO4o6fMkzJkoAt3ykNgWhq0elzWvmzpKIpdHh0/yNdynT525o7IoDAdB2JM1MXl3N7h2yjP2RkKlqFNOXeD30miBw/6SaaBq8HL60pa5JotVdntSwczrHhJljknk5EvPm/2kw/gPSMhrpKFbnsPZ8mB7B8ZJ7WpuOPHZMSI6tqojp5y0LeBbFtIld5qxmt+gEj+NYyskToXCyGiHQWKhrdqnAYxAjHiSPp+B0FdRNh24R4jGAoackrCC3wQCcNRp4oPCgD93aK4l2GCFROHfM5HdkV8aX7DEPuNxFicO2oUK9paOBBrChiKlm9s7UnSdvI3k7qSzIyl4Jwt1niUQ/u6c7u9ijdMSn89Or3tWnxM/qFwlJmtb0AfJ+fMYYt1nX2GLf+lUhnuSkfffHMrH5YGlazHIe42cqE9oDzw1hbKR5x23v4wFIjCF+QVJM0xcYlp0QsA6V41SSotogeNqo/KU213jmaj42J08ZvTfwHDG5S9pU/0If5sye2E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(136003)(366004)(376002)(396003)(316002)(38100700002)(64756008)(4326008)(8676002)(66556008)(83380400001)(478600001)(36756003)(31686004)(54906003)(76116006)(66446008)(66946007)(110136005)(6486002)(26005)(31696002)(86362001)(2906002)(5660300002)(8936002)(6512007)(6506007)(41300700001)(71200400001)(122000001)(38070700005)(2616005)(66476007)(53546011)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sy9jSENFbmxBQ1BkRUlwVFZPbXdqRE5uWHJrYXRMMEs3ZnI2ZVNqOGNmb2lR?=
 =?utf-8?B?S21mUkRFS3RCcDhhWWNBVjBOK0R4a0crbDZXZlRpL05xZUR0UnBoeWtlS3N4?=
 =?utf-8?B?bmJQTDVVOCtxa3VXb1YvdDd6Z1IyQ1RYUDcyMnhobTV6R2VoUEMzaHdyYUhj?=
 =?utf-8?B?S3BtYmFTQmZuZVJ5TWJ1TXpCZGF4dVByeko0RnVkVHExcWwyeW00OEZQOEVr?=
 =?utf-8?B?bi9NRzg5djd5dkFqS1RodldtK3BJQkxhZ09sbS9ZZWZFS3Rhb3pDc0VjMlVY?=
 =?utf-8?B?Q0NlVUViK3orV2t5d1hubldscG9OQ1lKem9iZG5XdmNNc3RGOGlLN3pBL1B2?=
 =?utf-8?B?M2dIUWFJekdLcytXRWhwM3grTEJTd3ZIeGEyZnAvSFJxa3l3R0lscjNyd2xZ?=
 =?utf-8?B?QU51NFJJV0ovMHJiOG84WDNyN1lGQk1CSFRRYXhEZzEwL21pTnA0NTFiakk3?=
 =?utf-8?B?TlVsajF1MGJDWFRCR2QzTklUNWJ6REg3TkZSUUlVWlhwRlN6VFB0aHRNQnhm?=
 =?utf-8?B?RE14OGlvcUM5Mk4xZTJqYlNhMEl2Nm5LaGVHQ2MyeTQzMmswSUlzKzRaUTkr?=
 =?utf-8?B?MktBc3FPMjJpUm1EYU1lQi9pelBEK2pITTRaZ25kQzNNMUtZS1JVcGpkdUxw?=
 =?utf-8?B?VDE0ZjdPSVB4aUVZWFlIa3pYOFBnYlBFWFkwV1ZTaWtkYXViSGlwTnBkNFFi?=
 =?utf-8?B?YWdLOFBJdEpPZGJLMEtud0tGcEhvY3YwWFh1cHg3Z0R3NTcyaVpIS25STEMz?=
 =?utf-8?B?aEtTOXFoRisyMFkvSjZPV0d5eTNqRFVlVHFnRjAzUHcvNHMwVDU0NlVDays0?=
 =?utf-8?B?RDRYeVdUbjQ5aFZxTnU4SGtWa0RiY0tJS3pBdHVmemYzOGlWeXJTdkZpQytG?=
 =?utf-8?B?ZHJqQ0VIS2dKUUhobUFrZko3SHljaGV4dE1YSWpTdzFkTXRRelQxUUhucWM0?=
 =?utf-8?B?aUtxdGtVVHBqYWxVQnlLU3lBNUVJbXM3STg5dVVhdmNZMGUvQ0pwSHRvVTlJ?=
 =?utf-8?B?c1lCMUEzOSs0STZ5KzJqYVRaVHhlbzlqSUl1cDVPZExJaHZXRThRNUpJWXJL?=
 =?utf-8?B?bDRxMWQ1cUpDczNiRmlWSjNhTU5DVkt3T1NORk03OHhxZXo5VGM1Q0lFZEUx?=
 =?utf-8?B?L21weFN5SEdoNllGUkYzZkd2d2ErazNiYUR0UEwycVE5dEIwOFY4SWNnajNo?=
 =?utf-8?B?dnowcWk4Z0xQUGRMakswVE5BeWpVTnpBVk5YdmdsU1F4YjVBY0NsRnhSNEI2?=
 =?utf-8?B?Q0J1bHc3M1ZXUWcxWVFSUTVoeWR4Z3pDVjRwOU9BMWhjK0l0SHFIU3hLeDFy?=
 =?utf-8?B?N0w3bDJheE9yeFAwcmJmQmo3NlFlbll5U1dxODRqTUpISEt3cGNTTUdhNXlx?=
 =?utf-8?B?VVlHYmNpUDRkNEJxREpBcFNZZm85QytCSFNIY0VJZFZjNG51ODNwZXlvL29j?=
 =?utf-8?B?VlBlNXN5RUZpL3JvOGpZWlMxTlNncDk1U282ZmVmK2FXcFltYnhuVUtHWDdQ?=
 =?utf-8?B?UmErMWI5RXpmd1ZETUVGMGFmcDlseUQ3UWxaRHFUU04wdHdBR2NrczlzUWVw?=
 =?utf-8?B?dzU0VlZyNW9VbkNDT1pDSzFUUnVoeHl3ZFgrMk9hN2VHSnRjZ0pSUGc1UmRS?=
 =?utf-8?B?MVhUeVdGTzgwSG1WZ2tCUVAzQUZ4TmRBV1BNcXFFRnZXazhTdGJnbTd6Umxm?=
 =?utf-8?B?YXFqRTIzVjFYQnBCL0o3K2pvU3BEdUQ0aWp5U04rRHdvRmxTclhQRmJMZ05y?=
 =?utf-8?B?S3lIZlZ1SzJZamE5SFF4bE9kYnpORjRwOUpBbjBXSVM2Rm9FK09hVVRpRHQ1?=
 =?utf-8?B?b2RGdEtVVmp0cTlZMU13cy9IbGN5RnpxUkNtWFNrK2NQbks3aGxqcGVVTVdH?=
 =?utf-8?B?S2tnVWhtYUxLSDFqRmZmeHRuZnRZdGoxYmVCYUtMUFVHblAraDY3VWRDc2Mv?=
 =?utf-8?B?UXgwdkg4UFE3N2djamtndWlkSWZOZlJkc01lSTcyU1o1Q0F4N0dMSTF1Y2pL?=
 =?utf-8?B?NWlWT1hzZWVUOTJQRzB4VWxvM1JhVFZqNktaY0tnOFNzSkp2WVg4Sk9pN2Jx?=
 =?utf-8?B?eFRJdjBCMnkyMmRvTEl0bWxBYW93czVuaEluamJYdXpzM3IxVzlQTDN0VVRn?=
 =?utf-8?Q?iWgM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A24323C6758C4641BFE2725BC7F6240E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?M203V3dKc3ZxbERIUVR3L29aeDZveHVndG9mSUNxdnZnYTFlNGNiWm5xNWV0?=
 =?utf-8?B?ZUU2Rlgvekx2R2lwa1BiN1Z5aHJWbkZ1Z2xLdzYvMWRLZG0wTG9GMjdrVjg4?=
 =?utf-8?B?ZGlyb2NFK0JoUGVXQUJialRZUk5rS1EycUVhRnUvdDBOaW5oVXRWRUxMTkhW?=
 =?utf-8?B?ZXNsaUREOElSbGRMZkk2NG1GM3RaQ3hNemZJMWFKblQzajhqSE9rZ0wzbEkw?=
 =?utf-8?B?MHV4bHhFbm8weHV6YUFScVQydlJhMGY2TXZ5Y2ZIQlZWR0xoTVZ2Mi9CZWJS?=
 =?utf-8?B?RVpBZ0FvTWRjWXFhcFhFUUV2YnlTV1dERVVrV0Q5SjdvRHlqSXlFQ0FVZEpn?=
 =?utf-8?B?RTZvbjlXKzZpbmRPdGJFZHVaeW5JcGVlbGZ4dk9Kdnk2MytQRDF6U29KWm9H?=
 =?utf-8?B?Yk1EekxNZll0MExMSFRia0t5SFU3N2lSNi9zWnNmaVVyajFuazdLbTMrczV3?=
 =?utf-8?B?Zk1lVE5aNnkwVzlLamRyc2grdlNZTmVneUU0QU96UFBtQTNhVDUrd2dEeFZk?=
 =?utf-8?B?emVncTFDc1A1TGlhWFh3Rkh4ODQ2L3lBeFNCUlpWamQ3aVk2NmV4Nnh4RG5J?=
 =?utf-8?B?V0hObDJGNFVDcTBINWgvODRaRmt1bXhhVWV1aERvdUUyNmI0eklYR2ZhdkRJ?=
 =?utf-8?B?Y0U4QjVsLzRWYXVUNGhYcy9DQTE0anZHQ1lqdTEwUElQZXdYbGp0aDZWdzNw?=
 =?utf-8?B?YklTNk8yYVRhTkhwMkZBWVk3czdJRytncXpJWGlCM1VrWXFaYUkrN1NKOXc5?=
 =?utf-8?B?YnVQWGtpcjZhZ1ZlNVgrTk50c25XUldxL2Q3UDBmaENVdkpaQTFRU0hPU2tY?=
 =?utf-8?B?U2crajRJQmJPOGtmWmx5aXdQYW9tQW5Pb08xTFJVcUlQOGxlaitXZHBQQ3Vy?=
 =?utf-8?B?TUI3Rm9mekdrdnVZRlltNWZZaXFNNlNJZVd2ZG9CRXBBNFZjVk1wWk9mU2E5?=
 =?utf-8?B?SHY2VVM0T0Q4SXVwSHhtMTY5MytyeUVBSnhzQjFXNi9ya3JwcVpiZHlrVFdX?=
 =?utf-8?B?ZHlaMVhvVjNkdEUvOG41am5nOHlaS05FQjNFd3FLMlFrRTFjaTZPeEV0djVv?=
 =?utf-8?B?TjcwY0tndi9EcjE4Zis0TytYd3RnLy9RRzkrZkhnSitNdkR6eWVqdzNsMnkz?=
 =?utf-8?B?MllzMW5BaEVicTRaVU9LVWFaTXNmNFJnQkFSQk4vZDFOSjF4Q2tKaHFzSDJE?=
 =?utf-8?B?aWJ4ajFrVVF1ejNwSEpoYjB2NDlURS83SmR2RXhRNzNHSHdIRmd2bHVjZEh3?=
 =?utf-8?B?YndlUEhOTnROblJjcHEwNXRDWW9vNG1lY0E5OWxGSnNZMFJJV3B2RFhURVFJ?=
 =?utf-8?B?SGFjTG9mN0s1WjBMWlBqWFRvOXVvY1Vxd1RsdzB1UnB6QXBLalMyUThIQVBR?=
 =?utf-8?B?NkVnajNZaXIwWXdBSTlxdjN4TDhlZ1dZWGVIOFk2YTZxdXFqUE52SUpCYU9k?=
 =?utf-8?B?UjArb29QK2gwdjY3WkwrK3g0U1U1QnoxOUs0ejh2YXdlVnUwMGFZZm9WT2dx?=
 =?utf-8?B?NGg5NmY2eEpyWnlEcU8yZHpUOWR5NVUyVkJxQ2trNGwxbmg2NTVldjN6emx1?=
 =?utf-8?B?aSt2d2VucWh6YmxBRU56SjFFazN5NE5lRGZjdHJlWURpaVRUakFEdnBrNmJk?=
 =?utf-8?B?NVdtN0tSRTZmdDEyUW1XR3ljZ1U2OXc9PQ==?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 019af307-a94c-4026-81d7-08da7c090593
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2022 02:19:01.6137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pAgx4HKX4lL40I4RzSIaXxa2+Q00dihOR48Al/en6DI5eiDcbrdzl9ODhOansux1g3OUPasr1yS6ZMvEomOQfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4849
X-Proofpoint-GUID: 4kwqntek0SlOF4u3f_z4eZsz-OAZIIFU
X-Proofpoint-ORIG-GUID: 4kwqntek0SlOF4u3f_z4eZsz-OAZIIFU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_02,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 phishscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=881 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208120005
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8xMS8yMDIyLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+IE9uIDgvMTEvMjAyMiwgRWxzb24g
U2VycmFvIHdyb3RlOg0KPj4NCj4+DQo+PiBPbiA4LzkvMjAyMiA2OjA4IFBNLCBUaGluaCBOZ3V5
ZW4gd3JvdGU6DQo+IA0KPiA8c25pcD4NCj4gDQo+IA0KPj4+IFRvIHN1bW1hcml6ZSB0aGUgcG9p
bnRzOg0KPj4+DQo+Pj4gMSkgVGhlIGhvc3Qgb25seSBhcm1zIGZ1bmN0aW9uIHJlbW90ZSB3YWtl
dXAgaWYgdGhlIGRldmljZSBpcyBjYXBhYmxlIG9mDQo+Pj4gcmVtb3RlIHdha2V1cCAoY2hlY2sg
VVNCX0NPTkZJR19BVFRfV0FLRVVQIGluIGJtQXR0cmlidXRlcyBhbmQgaGFyZHdhcmUNCj4+PiBj
YXBhYmlsaXR5KQ0KPj4+DQo+Pj4gMikgSWYgdGhlIGRldmljZSBpcyBpbiBzdXNwZW5kLCB0aGUg
ZGV2aWNlIGNhbiBkbyByZW1vdGUgd2FrZXVwICh0aHJvdWdoDQo+Pj4gTEZQUyBoYW5kc2hha2Up
IGlmIHRoZSBmdW5jdGlvbiBpcyBhcm1lZCBmb3IgcmVtb3RlIHdha2V1cCAodGhyb3VnaA0KPj4+
IFNFVF9GRUFUVVJFKEZVTkNfU1VTUEVORCkpLg0KPj4+DQo+Pj4gMykgSWYgdGhlIGxpbmsgdHJh
bnNpdGlvbnMgdG8gVTAgYWZ0ZXIgdGhlIGRldmljZSB0cmlnZ2VyaW5nIGEgcmVtb3RlDQo+Pj4g
d2FrZXVwLCB0aGUgZGV2aWNlIHdpbGwgYWxzbyBzZW5kIGRldmljZSBub3RpZmljYXRpb24gZnVu
Y3Rpb24gd2FrZSBmb3INCj4+PiBhbGwgdGhlIGludGVyZmFjZXMgYXJtZWQgd2l0aCByZW1vdGUg
d2FrZXVwLg0KPj4+DQo+Pj4gNCkgSWYgdGhlIGRldmljZSBpcyBub3QgaW4gc3VzcGVuZCwgdGhl
IGRldmljZSBjYW4gc2VuZCBkZXZpY2UNCj4+PiBub3RpZmljYXRpb24gZnVuY3Rpb24gd2FrZSBp
ZiBpdCdzIGluIFUwLg0KPj4+DQo+Pj4NCj4+PiBOb3csIHJlbW90ZSB3YWtldXAgYW5kIGZ1bmN0
aW9uIHdha2UgZGV2aWNlIG5vdGlmaWNhdGlvbiBhcmUgMiBzZXBhcmF0ZQ0KPj4+IG9wZXJhdGlv
bnMuIFdlIGhhdmUgdGhlIHVzYl9nYWRnZXRfb3BzLT53YWtldXAoKSBmb3IgcmVtb3RlIHdha2V1
cC4gSQ0KPj4+IHN1Z2dlc3RlZCB0byBtYXliZSBhZGQgdXNiX2dhZGdldF9vcHMtPnNlbmRfd2Fr
ZXVwX25vdGlmaWNhdGlvbihnYWRnZXQsDQo+Pj4gaW50Zl9pZCkgZm9yIHRoZSBkZXZpY2Ugbm90
aWZpY2F0aW9uLiBXaGF0IHlvdSBkaWQgd2FzIGNvbWJpbmluZyBib3RoDQo+Pj4gb3BlcmF0aW9u
cyBpbiB1c2JfZ2FkZ2V0X29wcy0+ZnVuY193YWtldXAoKS4gVGhhdCBtYXkgb25seSB3b3JrIGZv
cg0KPj4+IHBvaW50IDQpIChhc3N1bWluZyB5b3UgZml4IHRoZSBVMCBjaGVjayksIGJ1dCBub3Qg
cG9pbnQgMykuDQo+Pg0KPj4gVGhhbmsgeW91IGZvciB5b3VyIGZlZWRiYWNrIGFuZCBzdW1tYXJ5
LiBJIHdpbGwgcmVuYW1lIGZ1bmNfd2FrZXVwIHRvDQo+PiBzZW5kX3dha2V1cF9ub3RpZmljYXRp
b24gdG8gYmV0dGVyIGFsaWduIHdpdGggdGhlIGFwcHJvYWNoLiBUaGUgcmVhc29uIEkNCj4+IGhh
dmUgY29tYmluZWQgcmVtb3RlX3dha2V1cCBhbmQgZnVuY3Rpb24gd2FrZSBub3RpZmljYXRpb24g
aW4NCj4+IHVzYl9nYWRnZXRfb3BzLT5mdW5jX3dha2V1cCgpIGlzIGJlY2F1c2Ugc2luY2UgdGhl
IGltcGxlbWVudGF0aW9uIGlzIGF0DQo+PiBmdW5jdGlvbi9jb21wb3NpdGUgbGV2ZWwgaXQgaGFz
IG5vIGtub3dsZWRnZSBvbiB0aGUgbGluayBzdGF0ZS4gU28gSQ0KPj4gaGF2ZSBkZWxlZ2F0ZWQg
dGhhdCB0YXNrIHRvIGNvbnRyb2xsZXIgZHJpdmVyIHRvIGhhbmRsZSB0aGUgbm90aWZpY2F0aW9u
DQo+PiBhY2NvcmRpbmdseS4gVGhhdCBpcyBkbyBhIExGUFMgaGFuZHNoYWtlIGZpcnN0IGlmIHRo
ZSBkZXZpY2UgaXMNCj4+IHN1c3BlbmRlZCBhbmQgdGhlbiBzZW5kIG5vdGlmaWNhdGlvbiAoZXhw
bGFpbmVkIGJlbG93KS4gQnV0IHdlIGNhbg0KPj4gZGVmaW5pdGVseSBzZXBhcmF0ZSB0aGlzIGJ5
IGFkZGluZyBhbiBhZGRpdGlvbmFsIGZsYWcgaW4gdGhlIGNvbXBvc2l0ZQ0KPj4gbGF5ZXIgdG8g
c2V0IHRoZSBsaW5rIHN0YXRlIGJhc2VkIG9uIHRoZSBnYWRnZXQgc3VzcGVuZCBjYWxsYmFjayBj
YWxsZWQNCj4+IHdoZW4gVTMgU1VTUEVORCBpbnRlcnJ1cHQgaXMgcmVjZWl2ZWQuIExldCBtZSBr
bm93IGlmIHlvdSBmZWVsDQo+PiBzZXBhcmF0aW5nIHRoZSB0d28gaXMgYSBiZXR0ZXIgYXBwcm9h
Y2guDQo+Pg0KPiANCj4gVGhlIHJlYXNvbiBJIHRoaW5rIHdlIG5lZWQgdG8gc2VwYXJhdGUgaXQg
aXMgYmVjYXVzZSBvZiBwb2ludCAzLiBBcyBJDQo+IG5vdGUgZWFybGllciwgdGhlIHNwZWMgc3Rh
dGVzIHRoYXQgIklmIHJlbW90ZSB3YWtlIGV2ZW50IG9jY3VycyBpbg0KPiBtdWx0aXBsZSBmdW5j
dGlvbnMsIGVhY2ggZnVuY3Rpb24gc2hhbGwgc2VuZCBhIEZ1bmN0aW9uIFdha2UgTm90aWZpY2F0
aW9uLiINCj4gDQo+IEJ1dCBpZiB0aGVyZSdzIG5vIHJlbW90ZSB3YWtlIGV2ZW50LCBhbmQgdGhl
IGhvc3QgYnJvdWdodCB0aGUgZGV2aWNlIHVwDQo+IGluc3RlYWQsIHRoZW4gdGhlIGZ1bmN0aW9u
IHN1c3BlbmQgc3RhdGUgaXMgcmV0YWluZWQuDQo+IA0KPiBJZiB3ZSBzZXBhcmF0ZSB0aGVzZSAy
IG9wZXJhdGlvbnMsIHRoZSBjYWxsZXIgY2FuIGNoZWNrIHdoZXRoZXIgdGhlDQo+IG9wZXJhdGlv
biB3ZW50IHRocm91Z2ggcHJvcGVybHkuIEZvciBleGFtcGxlLCBpZiB0aGUgd2FrZXVwKCkgaXMN
Cj4gaW5pdGlhdGVkIHByb3Blcmx5LCBidXQgdGhlIGZ1bmN0aW9uIHdha2UgZGV2aWNlIG5vdGlm
aWNhdGlvbiBkaWRuJ3QgZ28NCj4gdGhyb3VnaC4gV2Ugd291bGQgb25seSBuZWVkIHRvIHJlc2Vu
ZCB0aGUgZGV2aWNlIG5vdGlmaWNhdGlvbiByYXRoZXINCj4gdGhhbiBpbml0aWF0ZSByZW1vdGUg
d2FrZXVwIGFnYWluLg0KDQpJZiB3ZSBkb24ndCBoYXZlIHRvIHNlbmQgZGV2aWNlIG5vdGlmaWNh
dGlvbiBmb3Igb3RoZXIgaW50ZXJmYWNlcywgd2UNCmNhbiBjb21iaW5lIHRoZSBvcGVyYXRpb25z
IGhlcmUgYXMgeW91IGRpZC4NCg0KQlIsDQpUaGluaA0K
