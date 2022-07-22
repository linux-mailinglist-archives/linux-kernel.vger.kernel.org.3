Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42B757E7B9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 21:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbiGVT7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 15:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiGVT7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 15:59:34 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70C99C266;
        Fri, 22 Jul 2022 12:59:32 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26MIRkTf006050;
        Fri, 22 Jul 2022 12:59:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=b+aAN3JlAz8HEmAc7LMO5hZmq8MF27bsA5+T1MCKWc0=;
 b=XNNouxjPl3pIaxng3IhAd1PRaGaScWITd04jWwo+0T5RMHK+ABGaav4ZH0MLIOJdv07m
 6blsM0ONNDWZDN5b65EKP5WdsOTK7QMeBGMruMAqHsb4yIta7h8lTaFKKtHwtGY9oBK8
 yqyKEx5czirl5bC4/N1Nu4+ccSPBFIEY1NkJKMcSCH/yyPUzbtg5fbGHKCpv4VlJyWYw
 C6ipIYST2Gt9t4Hp0q/05xRF/z299JrLNBueTWo/JdwVN9I0a6efclCnkfrWgfFujc9S
 h1ffYShst+aBqw82ypYzjwEd/EkICCoRVgXSN7wR8zimUZN1DMAnPeNMMVgNZwZrn4ph 9w== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3hc6c3xnmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 12:59:19 -0700
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7170A4008A;
        Fri, 22 Jul 2022 19:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1658519958; bh=b+aAN3JlAz8HEmAc7LMO5hZmq8MF27bsA5+T1MCKWc0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Qwh6Wx3Zf1Uus7axtKECEExJXM9wESYpBGloboD4aXkpN5+Ls0GqEr7+VS+tdspFZ
         Ylqb/uW8R506GTE/6mECdhBD3SCpwIt5DpocQ4TbDu29pCpFFe/jdcfOgCFVdvkd2e
         MRibbQUkx3crOWvGUuWzmJxH4tgGjIg2/bySNvmSvn6LRJ8s81u9BpLRIFmZusRqI6
         XvFGbZX5ZnMu+YtQnvxFIF0xYB7Q78NvI8LTLo0mxZfKdvERxWj70q98NgntC1r9Tj
         QGw9xVZVrAcxCBCO1+u6HOnAPc2Zwu+Bnxm3YA4XEPyK1wHhHwzsaBVm+pRfP8sgbp
         p7khyNkFVMhRQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id B4F50A005A;
        Fri, 22 Jul 2022 19:59:17 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5DF784006C;
        Fri, 22 Jul 2022 19:59:16 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="NyThEnIH";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ig/uDSRQZiQyz5igRei+wVdgHcuIol3zOXlJyG4uLAe10G+BWUOYJD8PfChW9SeUl/VLHMMi/pioCl5gn8MEVarvRsbZzl7dMwhT74CY5ndm6uPgOTL3KaZeCzDUmtt1oBEtevy49yeLI5x+rYfGWoqRgjVUTyJ5knhX5sAlaMavLf6qKTlK9O25S3+551Pi5Tg3xOZlCq5P/WbggY3SxaZTCHy0fD36mzKAg/n90TKY0xQTsZaAtLDeMWCcDlMfznpQ30g/N6XwOPmwBD0/hiw/aHRaD+JUB77HDHTmmp/R1BLZEGsbKt6nvDEvmfIomKcyVfG8pKiGP/R+8TkYuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+aAN3JlAz8HEmAc7LMO5hZmq8MF27bsA5+T1MCKWc0=;
 b=kYYwvxsXVsELOJr5KvNLkcQrAdVv3DvoM+7dTwslGHP0fLUrvIeD701CmS2iShd+DTR7Z9su67r+PdrKff8n7+lGt3foiGOclN025U/BHtC+hr3f3Wd2TQ1HWY/ho/L1JDwMrXZjtSHHamQQqeBSDNAmdd3q9BDwROI9w736du+UDJjm1HZ0ypPe+HvWKIU2yFtPi/tCRrINZBX51x9lefWYAconLNG7jEZaGWmxI2cN1GP8mxRMiRvrG5T04TLjN/NnBxsQfLTiCLiekeUIz0JMAEaEXxpKFgXQvOm2AjjXAD1ebTGD/lqRHHve757UgmAoLtHMHT/OPOgCebo3nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+aAN3JlAz8HEmAc7LMO5hZmq8MF27bsA5+T1MCKWc0=;
 b=NyThEnIHFk8wxFewHVoTtkRs2VaXeoMrUMlVVznKszg0DP8lDAfyz+NlgEXZOtSMdvextR6ucMZwWVjmXy/YJpbujK4YpgIbHWa7Gei9rNnpixxB3j/ArLuM6OUwQaScJbRPAg7bySFj16fBrVhTSYNOEP2oZEJuDqqlGISTScY=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MWHPR12MB1695.namprd12.prod.outlook.com (2603:10b6:301:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Fri, 22 Jul
 2022 19:59:13 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c%7]) with mapi id 15.20.5438.023; Fri, 22 Jul 2022
 19:59:13 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v2 4/5] usb: dwc3: Allow end transfer commands to be sent
 during soft disconnect
Thread-Topic: [PATCH v2 4/5] usb: dwc3: Allow end transfer commands to be sent
 during soft disconnect
Thread-Index: AQHYllCHTDdRJ4wf3U6yBQnRzTv93K2JcEyAgAABOoCAAAIPgIAABW8AgAAWigCAAAEVAIAAJ+CAgAEl44A=
Date:   Fri, 22 Jul 2022 19:59:13 +0000
Message-ID: <47d32d4e-4686-9d27-57b1-a2b9ac2e8f39@synopsys.com>
References: <20220713003523.29309-1-quic_wcheng@quicinc.com>
 <20220713003523.29309-5-quic_wcheng@quicinc.com>
 <d8d26ce3-6773-bd9c-e227-0924f239eae0@synopsys.com>
 <98623d02-cde4-b036-a85c-9325b58c7eab@quicinc.com>
 <5d0cf380-e045-fcec-639f-ac2f6a187ca8@synopsys.com>
 <5a57d5b9-b81e-bb09-998b-2915d9ab6b2f@quicinc.com>
 <fa172e2c-eff6-002e-3687-d87a2986fd42@synopsys.com>
 <b431cfd5-65b8-aa31-ca13-a813a1ad2e10@quicinc.com>
 <53c24bea-10d9-5533-1384-8b34136059c4@quicinc.com>
In-Reply-To: <53c24bea-10d9-5533-1384-8b34136059c4@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8de2eeb0-897e-43f9-0fdc-08da6c1ca655
x-ms-traffictypediagnostic: MWHPR12MB1695:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 52rhRq5dlOagA9nBujhmxGGDd4dgndrEss441+KbzfCzl5Uhsvze5KiowwVVjjaZRY1RGQD74MQCYQYnue9I4plyT+yRazdhkyqGhxUHCAVORzOghOalX4K8e1oAYDfkyuoYey5I316UdxQXYvEeTqtvgDlzBt6GOpOnhSbhaJaKLwS1s8/byDq2e2+2vHxy+jnigDucN5/Jpkb2gvBdIX6+NHXxK21qHTWjrBmpbQ/trIuvTFJIThcrNFlWvBqmioG/SfTImat2cS1Pq276dUwvn9A9FSLIKOfWR3scaWylro20fHlu+2sMKhERHG3LOw9MYu+aihfpSeQLPdWvyb0wqMaKrp32LV9pJHqedHt3HbYli9x0FtMU6iXj4rP2cHBJD4oct/kZgWztq0qUws10Qm0ZOHxYgE4zcWGmVDjSraYlzd3CG3BPzCT39IxuqGUR1dhGs6Bkv1gkPamuy42pPs5wF08RxWoK0JbavvgzMJz/xZORN8HlUBmQkJb809bqviudnKwYQb37qQb+apRBzX2jUPO8z84bjtXeK1Aq5Qu1wlqRkfcGBb0MLp39Wglm6Pqs1Cpkc4XPUjfb1QMjc7q7T8J+AEBZwuX6FynQjUBHEEMq9M2TsxC6n153KbinyTojU9/rIz2zjVXw+njhBIRcmxTPtKy7xxXr9ZZp3Eh8a3PP+6xhlbbpmIYTNnWXWDHUv/6D++wyV2zpmGQtMiqADek7y6DWB3TwwfmtUi6FymhDu1jyyt+WdEeSPngpZ8PrZ6GeuhEuPBKuyypAib962mtCILRNWtqhcwcJ+Xod9cVLajWpEh8fqF7BUMItlwotYTRZd57VdsSrhv/bU2lQEBOCA/cqdrrgheS9qXnP7Z8wMXGD5QcB0oEW1jOox0WmJzPpg40eBFR83Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(366004)(346002)(396003)(136003)(6512007)(38100700002)(66446008)(64756008)(4326008)(66476007)(8676002)(66556008)(8936002)(66946007)(110136005)(76116006)(38070700005)(31696002)(71200400001)(36756003)(54906003)(2906002)(478600001)(26005)(6506007)(186003)(53546011)(316002)(2616005)(122000001)(6486002)(966005)(86362001)(83380400001)(41300700001)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0JQTHZ5aUtLcmt5clMzWjd6dXUydFduUW9jVHk3enl4M0p1ekE4cGZDQmNK?=
 =?utf-8?B?UGRPZkhwWEtrMHhaZ3pWSXF6ZXB0S3cwaFZLdVlScFdqaDJHZEFsQk11bk12?=
 =?utf-8?B?QjQ3dk9ncHBlcllFUW5QdHI1MlhnMkZTMDI3UnhNTUdEQy80Vzg2aFRsL1Fm?=
 =?utf-8?B?Mi9iM2h5Y2xxMGpyY3B4S2U5a0ZGZzcxRGZOa29uN3E5M3pPN2hwdktkWG1X?=
 =?utf-8?B?RWlSUUdwY2NwZ2E2TWNhMkRnYk5ZWEFVRm1FRDZiVVQ1MG1sWktjRjVIL3pD?=
 =?utf-8?B?akIwbGVMcVlUUytpWTJkMGVlZzlYNHh1c2t5OTFac2VvOXZIMGd6TjZUTExu?=
 =?utf-8?B?S2lYdzB4N2NlbXJ1WGFwNWFWb01rVUtmazdITm5RemwvMW1Pa3BVVGE5VWVE?=
 =?utf-8?B?RVRoemZCS0prUyt1YjRxclJMVUNQR0ZqQThOWERaUExWL3Yrc0k4bVNkR29p?=
 =?utf-8?B?M0JmUFZQbSsvUDl5T0NvRW53T1NZZHk3TTN1cEJ3Tkp0elRFSk5GMStYd1V0?=
 =?utf-8?B?UXhCdGt5dDZsalJhV1ZDL1JMck1ONTVjOWt0SXI2RDFLY2FxeHpVV3p5Ukhr?=
 =?utf-8?B?cFpxdkVENWMvYmFjcTBGWDlLa3lQRUN5cXFxZVNpT3lhTlJRSXVyRENpSTh6?=
 =?utf-8?B?dVV3QnkwaFlHRklyaVg5dHpEaXNydm5FcUcxL2NmaGM4U3RwajVYb3VXamxX?=
 =?utf-8?B?NVJNS25LWkJWRHRsQkVpMVA4NzVkV0cxZ2hnNlRjd0ZCMlVaTkxReGtKcVVH?=
 =?utf-8?B?d0h0S0pSUEFrM3VEZG5kNXJSRFBBZ0dxWUtPZ0RwRENpM1BGZDdqVjNRWTVV?=
 =?utf-8?B?V3hhY3FwUzZuS2ZCWlRUamxjRzl5UVJ5ZjI2MWtFMTcxZEtXZjJrNWdEb2RW?=
 =?utf-8?B?cUFaQSsvdS95WGdQeXhyL2c0b0hxaGU1T2p0Q0FmZDJnekhVemthQzAvWkVG?=
 =?utf-8?B?eC80RlRtV2dGUCtJTm13Qkk0WEU2a285VUNFL2lSaHVlT2ptajhwWFNSMWx6?=
 =?utf-8?B?YW9wWk9ST1pQVTZjaUU5c2NjdVFuQ0lraDRRVXpnTVh6NjdYVWN4WUJoaSsr?=
 =?utf-8?B?ZlNTb0N0cUhsekY3Z3hNV2g1VGFKYUFwNVdMOUVKNlRHb3BQTnh4blQ1OGJM?=
 =?utf-8?B?ZlZ2cFV5dXl1SFpBdGQvYWxPcnhHQUFzRXBRUDhjWXQ4V2pwcjQ3Ty9DYXo0?=
 =?utf-8?B?aXBwaWk1K2FuL1A1WldYR1Z1aEFSOW1HdEZzV09VczBidWVLOER4bmQvS3Bw?=
 =?utf-8?B?dXV2RWFKOEFwV3AwbVlpVWRFTkFyRk44Z3ZEcXo1NnRnN1VpaXRPVFBXL0g4?=
 =?utf-8?B?NHRLZHFubkN6QVI2YkhhamI4bUI0U3NpVFErVHRtbTd4MGJMZEhBeFJGRzJL?=
 =?utf-8?B?T0NJdGJld0VrbjF4clNCUThsNWVxQTFhRkJyOS9nUWxZbzVLNW1XSmVnTERn?=
 =?utf-8?B?UnV0UzdCbXA3a2diZFgxcG92cVdzdlRlQU1JV1ZYNTZUQTVpRjlJVlBYMlYv?=
 =?utf-8?B?STNIcGwvajBsem11K0x5UExoWG1tWm9pbk1JNXlsVkNKSTZNUFpiMDlLSHM2?=
 =?utf-8?B?dERrRWhMNWRKTVJWWlFmcTg4SnNEZ2d4UE9JSkkrZEJVd3JkbjZLOGJSWmZX?=
 =?utf-8?B?RExzQW9OM2FmZXlwQTRwVFZZUG5yZ2lYRmIrTXNCTE1KbWk3Z1dLbGs5WUxX?=
 =?utf-8?B?S0JWcW9TRllscS9EQ0lBT2tqN1dJU3hQRiszL01IZmJLRFdSeFhHM2NPWms4?=
 =?utf-8?B?ZFRHUXBGUkMvYkRXSUNlb3VIeWdsTEY4N3AwYjJkVTd5NVowY29wUW5aYmRv?=
 =?utf-8?B?WTJIWHZGSW9MdlZ2dFRUTVpxc2o2cGUzN1dTNExHbGJiV0s2YkVvWDhmU1Jw?=
 =?utf-8?B?dEdCNW91Y3E4VEI3RS93ckFZeHNGakp1VTRVeXR2dlBhSkVRdFlLNXZtV0ZE?=
 =?utf-8?B?bnpsWTFCRThCNnd1cno2dGVWbm40b3ZBaitYemdSd2MwcHdHK1VsYmxtN3ZO?=
 =?utf-8?B?blRjUUVYNElFQXZuMHRpL0JKRUhLdXR4bDNBMjJ4MTBYUDIyeElVanlJODhs?=
 =?utf-8?B?ODBQT2ZteWMrYWVaSElZUmxvNXdkYk0xQnRRaXJFb2VZb2t2cnkwSHNnQ1JC?=
 =?utf-8?Q?gGfKXM+6hrKSbJcCymZOlwlgz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <81C5CCC7AF826F43B39B954A9E4808E8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de2eeb0-897e-43f9-0fdc-08da6c1ca655
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 19:59:13.1510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hUHlTaSJDXTLbhLVJTtoRD//QNGPDZ3+uoiKmGDafpC/4i4f3tE7i80s0z7SXnApy4hrbuq5TxCkCynbx8ZDXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1695
X-Proofpoint-ORIG-GUID: BlyuVIRqk8660zWyjXV3kwjuIUE-sm6P
X-Proofpoint-GUID: BlyuVIRqk8660zWyjXV3kwjuIUE-sm6P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_06,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 priorityscore=1501 mlxscore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207220081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8yMS8yMDIyLCBXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+IEhpIFRoaW5oLA0KPg0KPiBPbiA3
LzIxLzIwMjIgNTowNCBQTSwgV2VzbGV5IENoZW5nIHdyb3RlOg0KPj4gSGkgVGhpbmgsDQo+Pg0K
Pj4gT24gNy8yMS8yMDIyIDU6MDAgUE0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4+PiBPbiA3LzIx
LzIwMjIsIFdlc2xleSBDaGVuZyB3cm90ZToNCj4+Pj4gSGkgVGhpbmgsDQo+Pj4+DQo+Pj4+IE9u
IDcvMjEvMjAyMiAzOjIwIFBNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+Pj4+PiBPbiA3LzIxLzIw
MjIsIFdlc2xleSBDaGVuZyB3cm90ZToNCj4+Pj4+PiBIaSBUaGluaCwNCj4+Pj4+Pg0KPj4+Pj4+
IE9uIDcvMjEvMjAyMiAzOjA4IFBNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+Pj4+Pj4+IEhpIFdl
c2xleSwNCj4+Pj4+Pj4NCj4+Pj4+Pj4gT24gNy8xMi8yMDIyLCBXZXNsZXkgQ2hlbmcgd3JvdGU6
DQo+Pj4+Pj4+PiBJZiBzb2Z0IGRpc2Nvbm5lY3QgaXMgaW4gcHJvZ3Jlc3MsIGFsbG93IHRoZSBl
bmR4ZmVyIGNvbW1hbmQgdG8gYmUNCj4+Pj4+Pj4+IHNlbnQsDQo+Pj4+Pj4+PiB3aXRob3V0IHRo
aXMsIHRoZXJlIGlzIGFuIGlzc3VlIHdoZXJlIHRoZSBzdG9wIGFjdGl2ZSB0cmFuc2ZlciANCj4+
Pj4+Pj4+IGNhbGwNCj4+Pj4+Pj4+IChkdXJpbmcgcHVsbHVwIGRpc2FibGUpIHdvdWxkbid0IGFj
dHVhbGx5IGlzc3VlIHRoZSBlbmR4ZmVyIA0KPj4+Pj4+Pj4gY29tbWFuZCwNCj4+Pj4+Pj4+IHdo
aWxlIGNsZWFyaW5nIHRoZSBERVAgZmxhZy4NCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBJbiBhZGRpdGlv
biwgaWYgdGhlIERXQzNfRVBfREVMQVlfU1RPUCBmbGFnIHdhcyBzZXQgYmVmb3JlIHNvZnQNCj4+
Pj4+Pj4+IGRpc2Nvbm5lY3QNCj4+Pj4+Pj4+IHN0YXJ0ZWQgKGkuZS4gZnJvbSB0aGUgZGVxdWV1
ZSBwYXRoKSwgZW5zdXJlIHRoYXQgd2hlbiB0aGUgRVAwDQo+Pj4+Pj4+PiB0cmFuc2FjdGlvbg0K
Pj4+Pj4+Pj4gY29tcGxldGVzIGR1cmluZyBzb2Z0IGRpc2Nvbm5lY3QsIHRvIGlzc3VlIHRoZSBl
bmR4ZmVyIHdpdGggdGhlIA0KPj4+Pj4+Pj4gZm9yY2UNCj4+Pj4+Pj4+IHBhcmFtZXRlciBzZXQs
IGFzIGl0IGRvZXMgbm90IGV4cGVjdCBhIGNvbW1hbmQgY29tcGxldGUgZXZlbnQuDQo+Pj4+Pj4+
Pg0KPj4+Pj4+Pj4gRml4ZXM6IGU0Y2Y2NTgwYWM3NDAgKCJ1c2I6IGR3YzM6IGdhZGdldDogV2Fp
dCBmb3IgZXAwIHhmZXJzIHRvDQo+Pj4+Pj4+PiBjb21wbGV0ZSBkdXJpbmcgZGVxdWV1ZSIpDQo+
Pj4+Pj4+PiBTdWdnZXN0ZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lz
LmNvbT4NCj4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFdlc2xleSBDaGVuZyA8cXVpY193Y2hlbmdA
cXVpY2luYy5jb20+DQo+Pj4+Pj4+PiAtLS0NCj4+Pj4+Pj4+IExpbms6DQo+Pj4+Pj4+PiBodHRw
czovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtdXNi
LzFhMWE1NDg1LTc5MGUtNzljZS1mNWE2LTFlOTZkOWI0OWE0N0BzeW5vcHN5cy5jb20vX187ISFB
NEYyUjlHX3BnIWNYVzJUbEFMWVduWE5QZy1Ob01GVXJROEsxZWdFWmlRaXpaNUNBMURPTTFHY3c0
dGZPVUx5LV8yZU1Hdkw4cFFQdGU1ZFNjRk9OLTB3eEgyZVh1OGlqRVFVYnMkIA0KPj4+Pj4+Pj4N
Cj4+Pj4+Pj4+DQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gwqDCoMKgwqAgZHJpdmVycy91c2IvZHdjMy9l
cDAuY8KgwqDCoCB8IDMgKy0tDQo+Pj4+Pj4+PiDCoMKgwqDCoCBkcml2ZXJzL3VzYi9kd2MzL2dh
ZGdldC5jIHwgNSArKysrLQ0KPj4+Pj4+Pj4gwqDCoMKgwqAgMiBmaWxlcyBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdXNiL2R3YzMvZXAwLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2VwMC5jDQo+Pj4+
Pj4+PiBpbmRleCA1MDZlZjcxN2ZkYzAuLjU4NTFiMGU5ZGIwYSAxMDA2NDQNCj4+Pj4+Pj4+IC0t
LSBhL2RyaXZlcnMvdXNiL2R3YzMvZXAwLmMNCj4+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvdXNiL2R3
YzMvZXAwLmMNCj4+Pj4+Pj4+IEBAIC0yOTAsOCArMjkwLDcgQEAgdm9pZCBkd2MzX2VwMF9vdXRf
c3RhcnQoc3RydWN0IGR3YzMgKmR3YykNCj4+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpZiAoIShkd2MzX2VwLT5mbGFncyAmIERXQzNfRVBfREVMQVlfU1RPUCkpDQo+Pj4+Pj4+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsNCj4+Pj4+Pj4+IMKgwqDC
oMKgIC3CoMKgwqDCoMKgwqDCoCBkd2MzX2VwLT5mbGFncyAmPSB+RFdDM19FUF9ERUxBWV9TVE9Q
Ow0KPj4+Pj4+Pg0KPj4+Pj4+PiBJZiB3ZSBkb24ndCBjbGVhciB0aGlzIGZsYWcgaGVyZSwNCj4+
Pj4+Pj4NCj4+Pj4+Pg0KPj4+Pj4+IFRoaXMgaXMgd2h5IEkgYWRkZWQgdGhlIGR3Yy0+Y29ubmVj
dGVkIGFyZ3VtZW50IHRvIGNvbnRyb2wgdGhlDQo+Pj4+Pj4gImludGVycnVwdCIgYXJndW1lbnQu
DQo+Pj4+Pj4NCj4+Pj4+Pj4+IC0gZHdjM19zdG9wX2FjdGl2ZV90cmFuc2Zlcihkd2MzX2VwLCB0
cnVlLCB0cnVlKTsNCj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBkd2MzX3N0b3BfYWN0aXZlX3Ry
YW5zZmVyKGR3YzNfZXAsIHRydWUsIGR3Yy0+Y29ubmVjdGVkKTsNCj4+Pj4+Pj4+IMKgwqDCoMKg
wqDCoMKgwqAgfQ0KPj4+Pj4+Pj4gwqDCoMKgwqAgfQ0KPj4+Pj4+Pj4gwqDCoMKgwqAgZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4+Pj4+Pj4+IGIvZHJpdmVycy91c2Iv
ZHdjMy9nYWRnZXQuYw0KPj4+Pj4+Pj4gaW5kZXggZWU4NWI3NzNlM2ZlLi40MWI3MDA3MzU4ZGUg
MTAwNjQ0DQo+Pj4+Pj4+PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+Pj4+Pj4+
PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+Pj4+Pj4+PiBAQCAtMTY5Myw2ICsx
NjkzLDcgQEAgc3RhdGljIGludCANCj4+Pj4+Pj4+IF9fZHdjM19zdG9wX2FjdGl2ZV90cmFuc2Zl
cihzdHJ1Y3QNCj4+Pj4+Pj4+IGR3YzNfZXAgKmRlcCwgYm9vbCBmb3JjZSwgYm9vbCBpbnQNCj4+
Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXAtPmZsYWdzICY9IH5EV0MzX0VQX1RS
QU5TRkVSX1NUQVJURUQ7DQo+Pj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgIGVsc2UgaWYgKCFyZXQp
DQo+Pj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVwLT5mbGFncyB8PSBEV0MzX0VQ
X0VORF9UUkFOU0ZFUl9QRU5ESU5HOw0KPj4+Pj4+Pj4gK8KgwqDCoCBkZXAtPmZsYWdzICY9IH5E
V0MzX0VQX0RFTEFZX1NUT1A7DQo+Pj4+Pj4+PiDCoMKgwqDCoCDCoMKgwqDCoMKgwqAgcmV0dXJu
IHJldDsNCj4+Pj4+Pj4+IMKgwqDCoMKgIH0NCj4+Pj4+Pj4+IEBAIC0zNjg2LDggKzM2ODcsMTAg
QEAgdm9pZCBkd2MzX3N0b3BfYWN0aXZlX3RyYW5zZmVyKHN0cnVjdCANCj4+Pj4+Pj4+IGR3YzNf
ZXANCj4+Pj4+Pj4+ICpkZXAsIGJvb2wgZm9yY2UsDQo+Pj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKg
IGlmIChkZXAtPm51bWJlciA8PSAxICYmIGR3Yy0+ZXAwc3RhdGUgIT0gRVAwX0RBVEFfUEhBU0Up
DQo+Pj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0KPj4+Pj4+Pj4gwqDC
oMKgwqAgK8KgwqDCoCBpZiAoaW50ZXJydXB0ICYmIChkZXAtPmZsYWdzICYgRFdDM19FUF9ERUxB
WV9TVE9QKSkNCj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm47DQo+Pj4+Pj4+PiArDQo+
Pj4+Pj4+DQo+Pj4+Pj4+IHRoZW4gaXQgbWF5IG5vdCBnbyB0aHJvdWdoIGhlcmUuIEkgdGhpbmsg
SSBtYWRlIHRoaXMgc2FtZSBtaXN0YWtlDQo+Pj4+Pj4+IGluIG15DQo+Pj4+Pj4+IHByZXZpb3Vz
IHN1Z2dlc3Rpb24uDQo+Pj4+Pj4+DQo+Pj4+Pj4NCj4+Pj4+PiBTaW5jZSBkd2MtPmNvbm5lY3Rl
ZCBpcyBzZXQgdG8gRkFMU0UgYmVmb3JlIHdlIGNhbGwgc3RvcCBhY3RpdmUNCj4+Pj4+PiB0cmFu
c2ZlcnMsIGlmIHdlIGV2ZXIgcnVuIGludG8gYSBzaXR1YXRpb24gd2hlcmUgZGVsYXllZCBzdG9w
IGlzIHNldA0KPj4+Pj4+IGFscmVhZHksIHRoZW4gaXQgc2hvdWxkIGdvIHRocm91Z2guDQo+Pj4+
Pj4NCj4+Pj4+DQo+Pj4+PiBUaGVuIHRoZSBjaGVjayBmb3IgcmVxdWVzdCBkZXF1ZXVlIHRoYXQg
d2UgZGlkIHByZXZpb3VzbHkgd2lsbCBub3QgDQo+Pj4+PiB3b3JrDQo+Pj4+PiBhbnltb3JlLg0K
Pj4+Pj4NCj4+Pj4NCj4+Pj4gQ291bGQgeW91IGhlbHAgY2xhcmlmeT/CoCBUaGUgcHVsbHVwIHJl
ZmFjdG9yIGtpbmQgb2Ygc2hpZnRlZCBzb21lIG9mDQo+Pj4+IHRoZSBwcmV2aW91cyBjaGVja3Mg
d2UgaGFkIGluIHRoZSBkZXF1ZXVlIHBhdGgsIGFuZCBjb21iaW5lZCB3aXRoIHdpdGgNCj4+Pj4g
dGhlIHN0b3AgYWN0aXZlIHRyYW5zZmVyIGNoZWNrcy4NCj4+Pj4NCj4+Pj4gSSB0aGluayB0aGVy
ZSB3YXMgYW4gaXNzdWUgdy8gdGhlIHBhdGNoIEkgc3VibWl0dGVkIHRob3VnaC4gdGhlIGFib3Zl
DQo+Pj4+IHNuaXBwZXQgc2hvdWxkIGJlIHJlcGxhY2luZyB3aGF0IGlzIHRoZXJlOg0KPj4+Pg0K
Pj4+PiB2b2lkIGR3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXIoc3RydWN0IGR3YzNfZXAgKmRlcCwg
Ym9vbCBmb3JjZSwNCj4+Pj4gwqDCoMKgwqDCoGJvb2wgaW50ZXJydXB0KQ0KPj4+PiB7DQo+Pj4+
IC4uLg0KPj4+PiDCoMKgwqDCoMKgaWYgKCEoZGVwLT5mbGFncyAmIERXQzNfRVBfVFJBTlNGRVJf
U1RBUlRFRCkgfHwNCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCAvKiBGb2xsb3dpbmcgc2hvdWxkIGJl
IHJlbW92ZWQgLS0tIChkZXAtPmZsYWdzICYNCj4+Pj4gRFdDM19FUF9ERUxBWV9TVE9QKSB8fCAq
Lw0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgIChkZXAtPmZsYWdzICYgRFdDM19FUF9FTkRfVFJBTlNG
RVJfUEVORElORykpDQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0KPj4+Pg0KPj4+DQo+
Pj4gUmVxdWVzdCBkZXF1ZXVlIGNhbiBvY2N1ciB3aGlsZSB0aGUgZGV2aWNlIGlzIGNvbm5lY3Rl
ZC4gVGhlDQo+Pj4gRFdDM19FUF9ERUxBWV9TVE9QIGludGVudGlvbiBpcyB0byBkZWxheSBzZW5k
aW5nIHRoZSBFbmQgVHJhbnNmZXINCj4+PiBjb21tYW5kIHVudGlsIHRoZSBTRVRVUCBzdGFnZSBp
cyBwcmVwYXJlZC4gSWYgd2UgZG9uJ3QgY2xlYXIgdGhlIGZsYWcNCj4+PiBiZWZvcmUgdGhlIGZs
YWcgY2hlY2ssIHRoZW4gdGhlIEVuZCBUcmFuc2ZlciBjb21tYW5kIHdpbGwgbm90IGdvIA0KPj4+
IHRocm91Z2guDQo+Pj4NCj4+DQo+PiBUaGFua3MsIGdvdCBpdC7CoCBVbmRlcnN0YW5kIHdoYXQg
eW91IG1lYW4gbm93LsKgIExldCBtZSB0aGluayBhYm91dCANCj4+IGhvdyB0byBnbyBhYm91dCBp
dC7CoCBJIHByb2JhYmx5IGRvbid0IHNlZSBhbnkgaXNzdWVzIGFzIG9mIG5vdywgDQo+PiBiZWNh
dXNlIG15IHRlc3QgZG9lcyB0aGUgc29mdCBkaXNjb25uZWN0LCB3aGljaCB3aWxsIGRvIHRoZSBz
dG9wIA0KPj4gYWN0aXZlIHRyYW5zZmVycyBmb3JjZWZ1bGx5Lg0KPj4NCj4gV2hhdCBkbyB5b3Ug
dGhpbmsgYWJvdXQganVzdCByZW1vdmluZyB0aGUNCj4NCj4gKGRlcC0+ZmxhZ3MgJiBEV0MzX0VQ
X0RFTEFZX1NUT1ApDQo+DQo+IGNoZWNrP8KgIEluIHRoZSBlbmQsIGFzIGxvbmcgYXMgdGhlIGNv
bmRpdGlvbnMgYXJlIHNhdGlzZmllZCAoaWUgd2UgDQo+IGFyZW4ndCBpbiB0aGUgbWlkZGxlIG9m
IGEgU0VUVVAgdHJhbnNhY3Rpb24pIHRoZW4gd2UgZG9uJ3QgY2FyZSB0b28gDQo+IG11Y2ggYWJv
dXQgd2hvIGNhbGxlZCBkd2MzX3N0b3BfYWN0aXZlX3RyYW5zZmVyKCkuwqAgV2Ugd291bGQgc3Rp
bGwgYmUgDQo+IGFibGUgdG8gYXZvaWQgaXNzdWluZyB0aGUgZW5keGZlciBoZXJlOg0KPg0KPiDC
oMKgwqDCoGlmIChkd2MtPmVwMHN0YXRlICE9IEVQMF9TRVRVUF9QSEFTRSAmJiAhZHdjLT5kZWxh
eWVkX3N0YXR1cykgew0KPiDCoMKgwqDCoMKgwqDCoCBkZXAtPmZsYWdzIHw9IERXQzNfRVBfREVM
QVlfU1RPUDsNCj4gwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7DQo+IMKgwqDCoMKgfQ0KDQpUaGF0
J3MgZ29vZC4gVGhlbiBjaGVjayBmb3IgaW50ZXJydXB0LW9uLWNvbXBsZXRpb24gdGhlcmUgaW5z
dGVhZC4NCg0KVGhhbmtzLA0KVGhpbmgNCg==
