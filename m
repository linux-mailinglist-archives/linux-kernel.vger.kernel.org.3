Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93EFD4B7745
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242358AbiBORPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 12:15:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbiBORPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:15:11 -0500
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD6B11AA20;
        Tue, 15 Feb 2022 09:15:00 -0800 (PST)
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EE9C542167;
        Tue, 15 Feb 2022 17:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1644945300; bh=31wcIYqI+wLvvEC6xqzhJJDY6sz0tSi8Bo3GO9rd/Gk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=QMYFx4FJA58eKTOGm+KBkScpwe/qvs0SFR1kUdHqfvgs7H4yhLqmj/yThXtYH5ro4
         jrQzTvyx3KVI78o4ObQX79MKaJs/jxzGBnDSKXp9QpWS+WFNx48oaNAyiqWXhlHEbn
         yD42GT8YKnI0BIPNzduFrqhsUCdu3aYbbpi5+lr0RiOQR8XVSvFmMZaRJTQxq0+vRp
         qVgREazTMM4LzoWX2uYSyv6H2jAPfJripX6t4tzPbQEqYbJ81s9U5Ltkorl31kcOGv
         e5RtBSL5wm5bublMNx2FfqVhPK3/An6BSIL82tdR1tBSVWJMyFymWY2igAusZG0VGZ
         9uJ9TAxvcx/+g==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 31BC7A005F;
        Tue, 15 Feb 2022 17:14:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id EEE3640067;
        Tue, 15 Feb 2022 17:14:57 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="iO+eIoWy";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlrhQrnW2g1vsT+q+XfNXwGcVWbLyLr9Ik27WEJ6DmHTxLoNI1RQgzmTRbMqzjnwusiNVZb/1gYJRaiW0nMm07+rIdz7906+f7XUh4x3rdP+tmReFo3Kd4UPIuxxfNvP6zC2pxbjou/QYY0qVhV8WK3pw3JcbVLhZID6y9Z/M2nZGatC12YtMP6nOCHkRMxvbdnLSSxyWKIHvy0gxAhophVl75K3GeMxniizxAu1AFAjyImzB39wwRlnNlrt4+nSpAtjKBexEmKQVgrZ93zy/+9eG+aiNpgJZNNNojf/w0TiP2yDGwWYt2mFlu70XBU9u0Lk69b5aGw1K7rOxJHuaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31wcIYqI+wLvvEC6xqzhJJDY6sz0tSi8Bo3GO9rd/Gk=;
 b=c2qtJdE5Id7nQQdyMOucxrJWqZp6Cuz7zDQX2GGcT2WeipkDqSNCEn8kEoJyuaTlVyTz7/BwFzR+jjgSiZjjACCWGJU6XiDJZOt7d+3PBA3YcU/19phloUJ2VD+8lMCDpFVE4CIqUrOggwT9X0WfYahdlmq5scp5vkQwxLZX1ioCrONb9lTWcrdlLNxgNDkOaM4+IGbDthQkSp4frCzZ4btbgO745LVvaYrymri0vv+TZyWYzEiYXLyRBPqfmzAQ5KRMlsUSo7FPu4uGWqgkGMs1BTHdS83SpPlZZQMO81TjiGVOe3tIY9DTsqEYg4Pd16YEC+1zaRgylZ79cgGNAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31wcIYqI+wLvvEC6xqzhJJDY6sz0tSi8Bo3GO9rd/Gk=;
 b=iO+eIoWydbUpcgqQ5PAepD8ijbJK3BU9FTleWsEF7aCttZlcDnydMYIxvROslRdPJBL4JgvGpEQp1Wk0jPNjkR3CtWWukKyb5xdEcJql4yHK6afFlkkuBFXM2/oCsENvIbdXtSjbYyijGzZNNgyry2s80o2Njtmg1SwCEdr4Wno=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BN8PR12MB3186.namprd12.prod.outlook.com (2603:10b6:408:9b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Tue, 15 Feb
 2022 17:14:51 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e%3]) with mapi id 15.20.4975.017; Tue, 15 Feb 2022
 17:14:51 +0000
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
Thread-Index: AQHYIZOvXlHACGixbUGMAnHCl5PyK6yTYqcAgADHvYCAALGHgA==
Date:   Tue, 15 Feb 2022 17:14:50 +0000
Message-ID: <63c8c9d1-9b07-a9f2-3639-a38641e19a7a@synopsys.com>
References: <1644836933-141376-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220214111149epcas2p1a1faeda037991885fd6f2f026fa44ec5@epcas2p1.samsung.com>
 <1644836933-141376-2-git-send-email-dh10.jung@samsung.com>
 <ff604504-00df-0c1b-673e-892e42737f7a@synopsys.com>
 <20220215063925.GC144890@ubuntu>
In-Reply-To: <20220215063925.GC144890@ubuntu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5cc0d33-717f-4a04-d163-08d9f0a6ad29
x-ms-traffictypediagnostic: BN8PR12MB3186:EE_
x-microsoft-antispam-prvs: <BN8PR12MB31868EC9D036BC9BC8E911DDAA349@BN8PR12MB3186.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x5s7fU5r8U8ne726gMK0Q4Pu6NdwfAAuwZEJfNNRzK7o6CdNPPv8rFcT+lkTDdL17x+3eC6vwUN8VIUAXgvClI/Oe3M4nM0gI8tRlzOMeInaj9uYFwCGrFVhEDDU5XzokUt2pIbsKPgayvfCUyIPJXVC4MyEf/OzN+xSRIntXbavurS/thfvuBJ/cLKTie7R5AlfM6RU6x8xFpU+knpbf++LNKx94oW5R0ildMu7c9Rx+M6H+eLRHDZVi9ZVBLeMZ7e4Bf6yCzX/1Ptllb4e4rVPl4RX86e3wkU4WNIC9PzctSA7YiHkpx7+TjPLnWR8K942db7KEOrUf3LD4OxNsK6bbAHl02voUzNcdPXYGoX8x6x/Xo5RuOoCmO8avypp45J/1HGma7WAUSV91sf+EXpMs72+zPjTTnW4VBL+WzZVdJJ8p+r0zuNOH2UB/zta+dO/MBmkAxFxhO/D6oXXw5JmG1sqwIuIy/nIIyc+X1bTJ8Cz+FbD2sCYLY16qvf9oK/z5xiewd9HBlxVVtHdhK8b8A+z2U6HXR0l41kWpnsBkpWkkPkVeZ6XkQ/IMRGpdjwN1UU+B2DH13xfEQzdPptwWGEn6mMuHL783NV+jjz4LzBNl1m0ba/wxbdw8PbAM2nesiVP9d7s0UWcb3j0IwJdZsYvRFJunkh5dyC6wOrE3xa22YubV5gJj3p0u9+2pxtn1SUsupGAJVzSPAMIjx17GYfW8kTDDCRvAuBKuwadbGCQZCqzYePr3m9g/mVB+0czxXv9k+sXwP/XhRpSHhW+ksvP6bsQULVIFFYPlNPAxzsbvSsohl0tUnkH6w6mPnVt1V6Tv4Hp5HzpeOjoGoxV5XLvtzlJujIJxIYmT7s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(2616005)(38070700005)(122000001)(966005)(6486002)(316002)(508600001)(86362001)(31696002)(110136005)(54906003)(66446008)(66556008)(66946007)(76116006)(66476007)(64756008)(6512007)(8676002)(4326008)(71200400001)(6506007)(2906002)(83380400001)(31686004)(36756003)(8936002)(5660300002)(26005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHFlc2N0SkhpRjM4aGQvM1hDdlBTRklPSEgzdllwa0FDMXp6NlpwZy9Halo1?=
 =?utf-8?B?Y0h5MjhFbElDdnhpLzFhbHJDbDhPWngreXI1L0NKNHZzcGFyMjN3UDZlcDYr?=
 =?utf-8?B?MXMzcWI4RnZ1eFlkVjc0V3NFRndsYmRjOFpUNGs5MHBMbEo5eHBjZy9VaHEx?=
 =?utf-8?B?V0dVeTVvMG9VZ3JGajllMVBsclBhN0lZSXVDS3RsR1o4RTQ3QW1uUUtKRDBo?=
 =?utf-8?B?dkhsSG45SVlaa21tVWxSZGptbUpURVhSRTFhK3RyOWt6Rm1oMkJpRUowZkw4?=
 =?utf-8?B?bWJhZk12Wjdmd2NPeVVlUkZMUFRNd1dQUXp2S0k1KzZ5ZlJVSEJ5VkNSOHN3?=
 =?utf-8?B?VS9IbDQ5SXJ2NVFNVmRxUXpJMkIzQkg5V3RoSUV5RldQbTk0Z3F6TGJhckVN?=
 =?utf-8?B?VnZSN2Z1V0x2a2k5KzVOcTBWVlllSU5KQUtDdURZa2NWMjVtMEx4aHE0RnFO?=
 =?utf-8?B?MjZRdXFJcjFyOEIrekkyWFRVbXliT1VNZm9CRWFGK1RmVjhFdWpKVzV3b3Vz?=
 =?utf-8?B?OXdIUTJmcVJIVU1NS1l3MW9qcENQK1hMQ28wQmJTaU1kZFVkV1QyQWljOFlw?=
 =?utf-8?B?Z0lyVzExSnRtVnRLdHFhT2JTYWVuYXBUTU4rWmhONUV1TElyZHprQm5ZYVN1?=
 =?utf-8?B?bEVrRGNVbTNENy85bDFYYXEzSkl0aXdYY1B4Ry9LZmgzVWUxTktSNEhhOW85?=
 =?utf-8?B?T3R3NDJ0SnBpS1NjY0twVURwVzRoYlU2TWlGOWdia2VOclZadTB2bmZwZytr?=
 =?utf-8?B?bnlkc0g5L2dIZDBEQ1gyQVJwR05BOHhwSWplQWpqVGxZRlJLVnI1OWd5ZUdN?=
 =?utf-8?B?V1ZVczhCNk0yczRMOStlMm9XR2RnalNNNklLem1iZ29RalBjVXY1TWdrR3l6?=
 =?utf-8?B?azlhOTJSbGt0cXFwWWpWM25yZWNnNEd5RUEzZWdBNURHYTBvOXM5R1U3Rkwx?=
 =?utf-8?B?dXdFMHBmbTBGcU41VFRyZWMzVDVTa3FObHowSTlYZ1U4bDZteW9OVnJiQjE0?=
 =?utf-8?B?K0VIaGZqQzYvdU85TG00OTNtWTF5V2YrRHNRcFI1ZkZVNUduTTU0MndGd0RH?=
 =?utf-8?B?NjY2c0VSdElzZlNiZVNyZTJ4cG1ZTmdTTk45S3FVQWJMakViUVlSUjUybUZr?=
 =?utf-8?B?V2QrTWEyaXdMNEtCdEx1YjR2ekp6QjZRaEIwRXF2UC94UUZHbmx6UW4vQnFw?=
 =?utf-8?B?anBxYlNyRUYvenNRblZWV2U0aE9aT2lsU3kvaGw4NWZiNUp5dEJGbE55SXR3?=
 =?utf-8?B?eXZGTW9GYVlyaU8ySWhLQzY5Skl2aDBPbGhrNmRIemVkcnFrcmcwWnhGZXJO?=
 =?utf-8?B?ZEl0ZU1pT1pwRlM4dzNXSnA2cFZRbktUaUx0eGMvZnA3dVFPYWo5U3IyYU5D?=
 =?utf-8?B?dkhmd3JJVDZsUWx0OHVsMVlyTTdiemZuWmlLMlF3SEY5R3E1WUQyemxEcjAy?=
 =?utf-8?B?VXkzN1Y2MlhZYzlvYW9sTTlmUUJjNktnbHdoQWxzdFdvQTkyRE1JazV4alYz?=
 =?utf-8?B?YU5UazRsR1JnekpBZFdIUS9TaWJuZUx1VVVIQnZhUTFtNkV3ZzNGVm84b1ZM?=
 =?utf-8?B?bEJWWWhIcDBUT2hvSGZXblVpUG9Da280K0dRbGh0VWlNVm0zTFZNd0ZySDZL?=
 =?utf-8?B?V0o0NUZkdXpuUFpPUVFDMHE2RS9tWlZua3luR3dNRFhrRXcxNXU3T254em9H?=
 =?utf-8?B?VTlpOUtqUjdlaWtXVTlTNjhEQmp2ZjdjWGpJUit3SDRYdUFvWDdHRTMzd2xi?=
 =?utf-8?B?RUJUQjQwQUpYUmZpcHh5MU51bDVXTHczeVJhN2VDQTA0RForVEpmRmdocVZl?=
 =?utf-8?B?dDZ1VlNZK0RKM0VHSzlId0xKdnVGbU15QU1VY1pwU1R6b1VoL09xcWRFUzRO?=
 =?utf-8?B?VTlmVVpQMDVMY1NaZmdSdnBjSHB0aXhXV29wOE9YL1ZxSlVmMzMrWU5HdTZu?=
 =?utf-8?B?Y3h2N0VvVzJ6MDhyNTkrMER5Z0o1cENzZlhNUTJYZzQxY1ZHdXZVL0kxM1kx?=
 =?utf-8?B?YWkwTXd6Q05NV3lvdmp6Z2Zhck1iOFVrWW1RUjlvdkZTQWlRZWEyN3hQWlFN?=
 =?utf-8?B?c3ZMQXpPUUszWE5XakdZWmNRMGZ5dWJLYXRMWnlTNWZaM1JwZmJUUFZCOVhk?=
 =?utf-8?B?SUVFcnAzeVNnL0dVeEhCZmd0ZkxneGhKR0crcHZxNWVhZWt5WXMyT1U1djVv?=
 =?utf-8?Q?neFu/UsMzKjkEq7nkV2f0qY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <984604F4A2E2054D9743BEA94223775F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5cc0d33-717f-4a04-d163-08d9f0a6ad29
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 17:14:50.8978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: asnfhjWQOtn4HwvAx4H6+2OzReIe6d44H2/lQOGD6sIF3w4qoAdiuciYj3+LiopUXw8uLIbTNsIzkS7xHnrzGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3186
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SnVuZyBEYWVod2FuIHdyb3RlOg0KPiBIaSBUaGluaCwNCj4gDQo+IE9uIE1vbiwgRmViIDE0LCAy
MDIyIGF0IDA2OjQ0OjMzUE0gKzAwMDAsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4+IEhpLA0KPj4N
Cj4+IERhZWh3YW4gSnVuZyB3cm90ZToNCj4+PiBJdCBhbHdheXMgc2V0cyBEV0MzX0VQX0VORF9U
UkFOU0ZFUl9QRU5ESU5HIGluIGR3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXINCj4+PiBldmVuIGlm
IGR3YzNfc2VuZF9nYWRnZXRfZXBfY21kIGZhaWxzLiBJdCBjYW4gY2F1c2Ugc29tZSBwcm9ibGVt
cyBsaWtlDQo+Pg0KPj4gSG93IGRvZXMgaXQgZmFpbD8gVGltZWQgb3V0Pw0KPiANCj4gWWVzLCB0
aW1lZCBvdXQuDQo+Pg0KPj4+IHNraXBwaW5nIGNsZWFyIHN0YWxsIGNvbW1tYW5kIG9yIGdpdmVi
YWNrIGZyb20gZGVxdWV1ZS4gV2UgZml4IHRvIHNldCBpdA0KPj4+IG9ubHkgd2hlbiBlcCBjbWQg
c3VjY2Vzcy4gQWRkaXRpb25hbGx5LCBXZSBjbGVhciBEV0MzX0VQX1RSQU5TRkVSX1NUQVJURUQN
Cj4+PiBmb3IgbmV4dCB0cmIgdG8gc3RhcnQgdHJhbnNmZXIgbm90IHVwZGF0ZSB0cmFuc2Zlci4N
Cj4+DQo+PiBXZSBzaG91bGRuJ3QgZG8gdGhpcy4gVGhpbmdzIHdpbGwgYmUgb3V0IG9mIHN5bmMu
IEl0IG1heSB3b3JrIGZvciAxDQo+PiBzY2VuYXJpbywgYnV0IGl0IHdvbid0IHdvcmsgZm9yIG90
aGVycy4NCj4+DQo+PiBQbGVhc2UgaGVscCBtZSB1bmRlcnN0YW5kIGEgZmV3IHRoaW5nczoNCj4+
DQo+PiAxKSBXaGF0IGlzIHRoZSBzY2VuYXJpbyB0aGF0IHRyaWdnZXJzIHRoaXM/IElzIGl0IHJh
bmRvbT8NCj4+DQo+IGVwIGNtZCB0aW1lb3V0IG9jY3VycyBvbiBkZXF1ZXVlIHJlcXVlc3QgZnJv
bSB1c2VyIHNpZGUuIEVuZCBUcmFuc2ZlciBjb21tYW5kDQo+IHdvdWxkIGJlIHNlbnQgaW4gZHdj
M19zdG9wX2FjdGl2ZSB0cmFuc2Zlci4NCg0KQXQgdGhlIGhpZ2ggbGV2ZWwsIHdoYXQncyB0cmln
Z2VyaW5nIHRoZSByZXF1ZXN0IGRlcXVldWU/IElzIGl0IGZyb20gYQ0KZGlzY29ubmVjdCwgY2hh
bmdlIG9mIGludGVyZmFjZSwgb3Igc2ltcGx5IGZ1bmN0aW9uIGRyaXZlciBwcm90b2NvbCB0aGF0
DQpjaGFuZ2VzIGl0Lg0KDQpXaGF0IGFwcGxpY2F0aW9uIHdhcyB1c2VkIHRvIHRyaWdnZXIgdGhp
cz8NCg0KPiANCj4+IDIpIEFyZSB0aGVyZSBvdGhlciB0cmFmZmljcyBwZW5kaW5nIHdoaWxlIGlz
c3VpbmcgdGhlIEVuZCBUcmFuc2Zlcg0KPj4gY29tbWFuZD8gSWYgc28sIHdoYXQgdHJhbnNmZXIg
dHlwZShzKT8NCj4+DQo+IEkgaGF2ZW4ndCBjaGVja2VkIGl0IHlldC4gDQoNCkNhbiB5b3UgY2hl
Y2s/DQoNCj4gDQo+PiAzKSBIYXZlIHlvdSB0cmllZCBpbmNyZWFzaW5nIHRoZSB0aW1lb3V0Pw0K
Pj4NCj4gTm8sIEkgaGF2ZW4ndC4NCg0KQ2FuIHlvdSB0cnkgdXAgdG8gMTAgc2Vjb25kcyAoanVz
dCBmb3IgZXhwZXJpbWVudCkNCg0KPj4gQlIsDQo+PiBUaGluaA0KPj4NCj4gDQo+IFRoaXMgaXNz
dWUgb2NjdXJzIHZlcnkgcmFyZWx5IG9uIGN1c3RvbWVyLiBJIG9ubHkgaGF2ZSByZXN0cmljdGVk
DQo+IGluZm9ybWF0aW9uLiBUaGF0J3Mgd2h5IEkndmUgYmVlbiB0cnlpbmcgdG8gcmVwcm9kdWNl
IGl0Lg0KDQpIb3cgZGlkIHlvdSB0ZXN0IHlvdXIgZml4IGlmIHlvdSBjYW4ndCByZXByb2R1Y2Ug
aXQ/DQoNCj4gDQo+IFdlc2xleSBtYXkgaGF2ZSBydW4gaW50byBzYW1lIGlzc3VlIGFuZCB5b3Ug
Y2FuIHNlZSB0aGlzIGlzc3VlIGluIGRldGFpbC4NCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92
My9fX2h0dHBzOi8vcHJvdGVjdDIuZmlyZWV5ZS5jb20vdjEvdXJsP2s9OWQ0MjNiNjktZmMzZmQz
MmUtOWQ0M2IwMjYtNzRmZTQ4NWZmZjMwLTc3YTA5OWI1MjY1OTQxMGQmcT0xJmU9MjBiNGQ5ZjUt
MjU5OS00ZjU3LThiNmEtN2M0ZWMxNjdkMjI4JnU9aHR0cHMqM0EqMkYqMkZsb3JlLmtlcm5lbC5v
cmcqMkZsaW51eC11c2IqMkYyMDIyMDIwMzA4MDAxNy4yNzMzOS0xLXF1aWNfd2NoZW5nKjQwcXVp
Y2luYy5jb20qMkZfXztKU1VsSlNVbEpRISFBNEYyUjlHX3BnIUpXUHpOTG9PM0JGWF9JWkNWem1I
UHR4cTZmcnJfVkZiU05OYXhTUXlsdW50MVk0RWF1VE9lZnRoMkxDSWNWRXVUeDhFJCANCj4gDQoN
CkkgY2FuIHRha2UgYSBsb29rLCBidXQgcGxlYXNlIHByb3ZpZGUgdGhlIHRyYWNlcG9pbnRzIG9m
IHRoZSBmYWlsdXJlIGlmDQp5b3UgY2FuIHJlcHJvZHVjZSBpdC4NCg0KVGhhbmtzLA0KVGhpbmgN
Cg==
