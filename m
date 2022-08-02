Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D3E5884DA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 01:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbiHBXoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 19:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiHBXol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 19:44:41 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FC954ADB;
        Tue,  2 Aug 2022 16:44:40 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 272LZvfN026464;
        Tue, 2 Aug 2022 16:44:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=oBH8Z9BWJaj9t+czscUfF39bMO15NZ78tYWgOQLBTHI=;
 b=OWdeV9eG/Idzi82yC4pDVzvRp/zoBAalAgD0MnizgmeAmn9GzpE1IwpHO0HrC1nsVaOU
 cpOX/j+PuFNf9dSqw2BUXiGblWEwvN7NPbj7o/YacZi13CJIux1fChybYkNQ42wdHEds
 Tbab5JnfhEngN7gpEVTQusIjhwNYvqIlaZlWTAWq93449n849Pv+gTKt8NRZ17Cj0dbW
 teZb1GyjvVkDGwPwA5KJW9wThpm4FqFDlwCoqw4mg1/al4cM4JDM7O1ezpyYA5eqlIGi
 c/PT7mKfXcNvi7K1jrL+vWzoJVi9BZaJGn7xb0MZh6LMAVykBX7EFb+SBlGZWRByk/yS Vg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3hn3nngwg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Aug 2022 16:44:26 -0700
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 05E28C00F7;
        Tue,  2 Aug 2022 23:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1659483866; bh=oBH8Z9BWJaj9t+czscUfF39bMO15NZ78tYWgOQLBTHI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ff5ORts8YsiI8XHQj4WPIacuhtFSr+rKyeQZZNLelMjCVqos/AJkSxh5fNpNQdr6c
         1afLAOdVT3DNBUl6+yIgiYiwnP7+PivTYZdkhMRbDo7H5xt03TJC2q/aZENvBDguO6
         K1a+diKz/NlPq3RRL+qlb7A4t10PrjToaXb4+uLaWYqqosHGQO/lqQRaxNdf9Feh27
         /5bDWTvk0rvMDYZea5c/yg6CjTaR0hWSSBLNVSJ/Kle2+Jx2FrbF6OA3y24p1sXL61
         gEoyDBdIBwzWk/irM5XN5ICzk1kQAZNRujBHEmUn5YsmzBFJiDLx7fc76xUNEBSAbT
         CXnxjgdMgwF0A==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id E1F4AA008F;
        Tue,  2 Aug 2022 23:44:24 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 8F4024006C;
        Tue,  2 Aug 2022 23:44:23 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="gk7f63h8";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGwIUG1Yi2m4my7lK7o5jlJjHynh0th0NoHwY6Ob1F02/2AgLXsUJMxc6soj+RSkMM6lXrmI9xsB2TwLxhqWq1cPtO/iwKhXmd4uGESawBKwCIdabT+/DFbsvC0vZ3wnrX3XxfyzF9oWdyEv6HLTvQ1o2OF2iWXbcfvboQ49Wip9bflRIXubZH1Qtkf35Zjz4D4ZQyRd+cH23Li4w5QI9wF0D55eSP3lLpSP0JX5ue06AmzLsygxayfVOL11CYwiNFNCv8ZjTtdBFmnMoPl1hhtEJo1tbTbutP5XJJAAio2QeXpn/VAlFKF9W4ylgX25YWUExKTavOVqK0/2Tap0wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBH8Z9BWJaj9t+czscUfF39bMO15NZ78tYWgOQLBTHI=;
 b=g45GCa52LXjqdWnAnPcKhQ8vOyNIRmL77XYyGQQZAWecsswIF02q1vU9gbaveezsPjJqNvcatGRkEyBWIUidTZS5jjbbRuIwdzjwWMVG36MMy5+VjMclto4NPI6wNUk8VBL91HNGkkyL1BpzJHu0eKfmHw36zRtHCRALWB7llGs2t8iEIx2gxNUnoPg+AIWEI/kLUfdIFeDEifmaaK7+Ok20pV8YQdG8p++4jY1euJJNYLP7Vns8l3RvZui7rGibL95UTBK0UFEOBkvPEPe2cI1K5q2SmB7dfeoN8//wPYOFBtJWQBgpQsxe/wc50nZVZY3RJMGVoRdGgISu0jrdmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBH8Z9BWJaj9t+czscUfF39bMO15NZ78tYWgOQLBTHI=;
 b=gk7f63h8HJuaxPf5oseb8Bx6wftE10hWJXQLcL2tKKulAfbWdk0gG5rqhFz8X8HhEGBFjGpXCI1psno74OGIAYvL9M+9b0ZI/p5WEuIwIeX/ycpawsdDsjHOVlDJ5nuQBmhL7IXUXs8Mv1d6PprQMF4+U2yhXYajPgJ9Qyuke0Q=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MW5PR12MB5598.namprd12.prod.outlook.com (2603:10b6:303:193::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 2 Aug
 2022 23:44:20 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c%7]) with mapi id 15.20.5482.014; Tue, 2 Aug 2022
 23:44:20 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Roy Serrao <quic_eserrao@quicinc.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_mrana@quicinc.com" <quic_mrana@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH 3/5] usb: dwc3: Add function suspend and function wakeup
 support
Thread-Topic: [PATCH 3/5] usb: dwc3: Add function suspend and function wakeup
 support
Thread-Index: AQHYpqSx9094LxeChUqmipa4dXYgQq2cRkeA
Date:   Tue, 2 Aug 2022 23:44:19 +0000
Message-ID: <635c72bc-01e7-3d5b-dc23-7b03bd36ce23@synopsys.com>
References: <1659467920-9095-1-git-send-email-quic_eserrao@quicinc.com>
 <1659467920-9095-4-git-send-email-quic_eserrao@quicinc.com>
In-Reply-To: <1659467920-9095-4-git-send-email-quic_eserrao@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 368309b3-30a6-4689-0c2c-08da74e0eb87
x-ms-traffictypediagnostic: MW5PR12MB5598:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I7juo1MHeuIa5I/ij+WuHQcebYMdFsFGI+jepNz86LgTSiImQx3liG0XqQnvLjMSKSPUDPFT1U9OqucRCk3oIeZfa0lPPw6JUHBQV778g8T4ie7mLaggH/x/RbcwxeLEuzPzdDu/1X32ZFA3ppRwmh/afJXTLHrGXqt/ofeg9bP5CdFcISlFywHWd46lFg4JlwArkFUDojW+tTKxKKXePA6Eixih4PJ2RdXydJktjO5sX/nNG3pvH9JiRQD7Bz75/Myf3U24z9n415cpR3by2CNn2KKsY6kZAIYRiYeKMFHjZ9gFu0rc2OBC1wOMv/FCYP0KlzbX9qEhMB6nv8FylrrH5pNwckv0pTrzUCYMsCohpdwE7wyjMh4JBxTsn5qPXNeA7kPB1ml4Nr9670TWZyW6LuGVV8fjes5Tze8URpEvsLX/3YBvKRhLiwI+3FAmc5xviGPfdZJyXCJ2DjYfHctzv7BPQkwGWagL9A4U0ld0uRGTkvBsBRw420r+wrOkxv2grCk3i8BrSXjkhTqx8xMM0iUIFvMpm9JnnBkYfoxmqpmQCN+RjXO7EMeJCTfrLphz217NA65yLeXXXBDC22dXrywmnPmZSYJ/8XnF8SRrlBQV6jE6ipduRUxgHkoi5FRi37C0ldz7+wG7/chVgPgDEqAQ9iWGDS1D3GLHnRSlATHBIkr/kcHMEldCxZLASX5wpX122iu/NzxfqyN6Tc6uzVtp+acA/AF3ij1hkTpdyW4fhpirhPK7zkpieDLL4ekZZPTICmCwh/PTPS+emxBUv2z3Utg2rOtEsHpitFgoHRxZr+617yVN7wlBT41CfGBuj0PcP5nnJBNhjp74WHPN6AgIUqdwXBO8cm6oec7wWa8+IW2PQNEWlXlN/QSA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(396003)(346002)(39860400002)(376002)(71200400001)(83380400001)(41300700001)(110136005)(316002)(54906003)(107886003)(186003)(36756003)(31686004)(76116006)(64756008)(66446008)(66946007)(66556008)(66476007)(4326008)(8676002)(26005)(6512007)(2616005)(2906002)(8936002)(15650500001)(5660300002)(38100700002)(6486002)(6506007)(478600001)(38070700005)(86362001)(31696002)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTAzRTZZYUhFb3JYZDBqY0dEdFJCRWdNVnBFU2FJM2JHc21NT1hzeW9UWGlm?=
 =?utf-8?B?VktwSlVqUThnaVZ2SC9na0V0L0NoMlZRbVU2T1FMOTRIOE9maDRITk1kWldp?=
 =?utf-8?B?cTVCdWtaOGJHMUNyLzJBaE03SDlUSEFZdEFMY1lRdGpGcUYwZzB4Vm9oYUNP?=
 =?utf-8?B?aStHdjZGdVZNUUVYRGR6T2FKdmJDL0ljZ2Fnd3IrWVZaT3krc1huZUlrKzdM?=
 =?utf-8?B?UDkxemVlVWZvcHpzdjRxZnJvc1piNk1CZHdCNkhOK0NVbXl5ZTNRYitEY250?=
 =?utf-8?B?OHBIeXpaRTV0Y0VkbnJTNFZPNmNIdVlFWUxKM3RTTUlJMkJaTW12bGZhdFNl?=
 =?utf-8?B?YTdkSHB1d1UrT1dVelFiVk9qTkV2NlNSaEVXVU05ZHBBYXhkenlPVzhIWHZp?=
 =?utf-8?B?bUNJZ1Yxb3pnR1JFejZTWThJaVA0NUtVeHo0elJnRStTcWp3QVVGdXViT1Ay?=
 =?utf-8?B?dmhXVjMrblUzQ1YrUmlnU3F4RmxRZzJSWGZOY2VTa1RvMGVFNENRVUxaR1Ux?=
 =?utf-8?B?bzNvRzV5djZqcG00cElGZ2xOY0N3L3ZPenY3eHhDNGtZd2RTNXBvUy9nc3gx?=
 =?utf-8?B?WW9XQ0syclZwM0RRaUk4YWM3YVZkeEtDcFp4eEhLbU5Vc2RLWTJvRzNzRGhH?=
 =?utf-8?B?RnFaQ0xsNk96QWp5dzRFdjlPWkxmU2hMZHh3cEQrOVZpNXZIRi9sSEpBS0pX?=
 =?utf-8?B?bEU2SG1sVThqU2REK2VSZjdsenVGMmlJbXVBTmZOZlpsVTV4eGQrckdJZWVo?=
 =?utf-8?B?K2VsVk9YMmZYZFhPWUIwbWpzWVNDQk9CYzl1R3BoZEZZNGdkUnV5NENxY21u?=
 =?utf-8?B?TlliZVdpdEhFNUJ3MmdWeXVtVVpDWEdiQTlIekV1QmY5ek14T2tGR0ZXeUJ5?=
 =?utf-8?B?WklyMXcrRWJSbVRyTER6MnZCM1FPdXhETHNic1VZTU1odXNUYkVzTGZjcmV0?=
 =?utf-8?B?akpySnRZMHo1MGZuY1JDWld1N2RtT0IyWWRWdkhIaEJic1ZIYkE5eW1pWUkr?=
 =?utf-8?B?RHhSN0w4bnNtQkxXQTRvTFNjNzA0d0pHNUZTWmpvcVBWeE1wcWhZZUF5V2hU?=
 =?utf-8?B?dENjNjZaY0Rudkpvcmx5dHhuZU9keW4wb3hvcGJSUFNiekc5Y0hwdGVzeDJE?=
 =?utf-8?B?d2NtOHVnbjBYWS9WMUQyQThIeGJZNVdiVVNKZmNHSTRFQkc4Y1gyNzAzcFRl?=
 =?utf-8?B?MkhaUnZQZVovb1RQczlEbFBmSDdVT292VEFYK01PMVpnR1VFNXlkV3lubTFP?=
 =?utf-8?B?bHF0NlpXS2pXeHd1ZlRKUDkwN0ZESTE2VVZBYmdSVVpJY0V2bllMZ3NodlBw?=
 =?utf-8?B?L2orbzdueHFpRjhwUkpMdkNZS1RMRTRoU1M2YkJxQ1FNbjBKYnVkTVRIWkNR?=
 =?utf-8?B?ZlFKbHV0eE1uRU9jejFxQStDTXpIRFVodUVGeGgrZFd1Nkp4WUl4NUlNd0No?=
 =?utf-8?B?U1Ivb2IzMDJPRXZta1dJbm5MUFhxcVBPTmhOS05lQTVGL2FuYURBdUc1a1VH?=
 =?utf-8?B?eXNzTXR5THlKSGljbFN6enQzZnl5UVkxZC9OeGw3VTd0RncrMFdzMHVrdFRt?=
 =?utf-8?B?bFJPTHRIR1VsQUJSU1Fyd0NXZzBMcjF2cVBFaURrS0hPM0owWHR5eVg4WlRL?=
 =?utf-8?B?RHB6QkpST3Vnd2E4S1FQQWlacFd4TTJ4OUtGRnkzVHIxc1hnVGp6U2plWlZG?=
 =?utf-8?B?SW1GamdPWUFXNHpYYmMzeEk3OHMzSmhYYnNxWXZoYnVaYXJGaXF1dWlNcmhU?=
 =?utf-8?B?Znh6NVhtQndDK0gzWXBZWUVWaWYzb25qT1krc1IrcTRVSU1WOTBaekd6ZmVG?=
 =?utf-8?B?QXB4SHN2Q25GKzdBN0lyU1Nua042UTNKT3NhdURDYkhDb1dQUDk3UFlEMTVI?=
 =?utf-8?B?SUZqeTlBUytTSlVmSlBFVERtcjN3dEhwUk5vMGZ2dDNXcERaeTVoWnBhVDJ4?=
 =?utf-8?B?LzlaVVBUR1NmYUJEc1NGT2o4M2YzWWM5WWY5WFVyUXUxTGxJM1hQWmxrNXFX?=
 =?utf-8?B?c1JDaERPZ3FTVG1NY1l0cVVHWWNoM3FSYjNXY0xoK0pKWGU5MmN2a3RGeVRT?=
 =?utf-8?B?TFB4TTJpd2tBN0FjdEJXVEtaMk82WGU2aWZrVTVCNng2bmozaWMxYjNtZWpU?=
 =?utf-8?Q?cMMTS5DHD0Yl3M7hwXfFjErOT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A367F93AB952E4BA81479EAEEB1C8D0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 368309b3-30a6-4689-0c2c-08da74e0eb87
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 23:44:19.8714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: THJgeLfGBaP0e32xtXRmB1sO8f2+g12fX7CVum3c4WisJY26h26g7DNRyUJeNdTInqOhnAV9QZYv3MkQ/TL1ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5598
X-Proofpoint-GUID: UZLKG2fqYCVQwPd7FbR-DhYUbI7bdT3I
X-Proofpoint-ORIG-GUID: UZLKG2fqYCVQwPd7FbR-DhYUbI7bdT3I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_15,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 clxscore=1011
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208020112
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8yLzIwMjIsIEVsc29uIFJveSBTZXJyYW8gd3JvdGU6DQo+IFVTQiBob3N0IHNlbmRzIGZ1
bmN0aW9uIHN1c3BlbmQgYW5kIHJlc3VtZSBub3RpZmljYXRpb25zIHRvDQo+IGRldmljZSB0aHJv
dWdoIFNFVF9GRUFUVVJFIHNldHVwIHBhY2tldC4gVGhpcyBwYWNrZXQgaXMgZGlyZWN0ZWQNCj4g
dG8gdGhlIGludGVyZmFjZSB0byB3aGljaCBmdW5jdGlvbiBzdXNwZW5kL3Jlc3VtZSBpcyBpbnRl
bmRlZCB0by4NCj4gQWRkIHN1cHBvcnQgdG8gaGFuZGxlIHRoaXMgcGFja2V0IGJ5IGRlbGVnYXRp
bmcgdGhlIHJlcXVlc3QgdG8gY29tcG9zaXRlDQo+IGxheWVyLiBUbyBleGl0IGZyb20gZnVuY3Rp
b24gc3VzcGVuZCB0aGUgaW50ZXJmYWNlIG5lZWRzIHRvIHRyaWdnZXIgYQ0KPiBmdW5jdGlvbiB3
YWtldXAgaW4gY2FzZSBpdCB3YW50cyB0byBpbml0YXRlIGEgZGF0YSB0cmFuc2Zlci4gRXhwb3Nl
IGENCj4gbmV3IGdhZGdldCBvcCBzbyB0aGF0IGFuIGludGVyZmFjZSBjYW4gc2VuZCBmdW5jdGlv
biB3YWtldXAgcmVxdWVzdCB0bw0KPiB0aGUgaG9zdC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogRWxz
b24gUm95IFNlcnJhbyA8cXVpY19lc2VycmFvQHF1aWNpbmMuY29tPg0KPiAtLS0NCj4gICBkcml2
ZXJzL3VzYi9kd2MzL2NvcmUuaCAgIHwgIDEgKw0KPiAgIGRyaXZlcnMvdXNiL2R3YzMvZXAwLmMg
ICAgfCAxMiArKysrLS0tLS0tLS0NCj4gICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIHwgMzAg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAzNSBp
bnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91
c2IvZHdjMy9jb3JlLmggYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBpbmRleCAzMzA2YjFj
Li5lMDhlNTIyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiArKysg
Yi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBAQCAtNTE5LDYgKzUxOSw3IEBADQo+ICAgI2Rl
ZmluZSBEV0MzX0RHQ01EX1NFVF9TQ1JBVENIUEFEX0FERFJfTE8JMHgwNA0KPiAgICNkZWZpbmUg
RFdDM19ER0NNRF9TRVRfU0NSQVRDSFBBRF9BRERSX0hJCTB4MDUNCj4gICANCj4gKyNkZWZpbmUg
RFdDM19ER0NNRF9YTUlUX0RFVgkJMHgwNw0KDQpUaGlzIGlzIGRldmljZSBub3RpZmljYXRpb24s
IHNvIGp1c3QgbmFtZSB0aGlzIHRvIA0KRFdDX0RHQ01EX0RFVl9OT1RJRklDQVRJT04uIEFsc28g
dXBkYXRlIGRlYnVnLmggdG8gcHJpbnQgdGhlIHByb3BlciANCnN0cmluZyBmb3IgdGhpcyBjb21t
YW5kLg0KDQo+ICAgI2RlZmluZSBEV0MzX0RHQ01EX1NFTEVDVEVEX0ZJRk9fRkxVU0gJMHgwOQ0K
PiAgICNkZWZpbmUgRFdDM19ER0NNRF9BTExfRklGT19GTFVTSAkweDBhDQo+ICAgI2RlZmluZSBE
V0MzX0RHQ01EX1NFVF9FTkRQT0lOVF9OUkRZCTB4MGMNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dXNiL2R3YzMvZXAwLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2VwMC5jDQo+IGluZGV4IDRjYzNkM2Eu
LmNlZGM4OTAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZXAwLmMNCj4gKysrIGIv
ZHJpdmVycy91c2IvZHdjMy9lcDAuYw0KPiBAQCAtMzAsNiArMzAsOCBAQA0KPiAgIHN0YXRpYyB2
b2lkIF9fZHdjM19lcDBfZG9fY29udHJvbF9zdGF0dXMoc3RydWN0IGR3YzMgKmR3Yywgc3RydWN0
IGR3YzNfZXAgKmRlcCk7DQo+ICAgc3RhdGljIHZvaWQgX19kd2MzX2VwMF9kb19jb250cm9sX2Rh
dGEoc3RydWN0IGR3YzMgKmR3YywNCj4gICAJCXN0cnVjdCBkd2MzX2VwICpkZXAsIHN0cnVjdCBk
d2MzX3JlcXVlc3QgKnJlcSk7DQo+ICtzdGF0aWMgaW50IGR3YzNfZXAwX2RlbGVnYXRlX3JlcShz
dHJ1Y3QgZHdjMyAqZHdjLA0KPiArCQkJCSBzdHJ1Y3QgdXNiX2N0cmxyZXF1ZXN0ICpjdHJsKTsN
Cj4gICANCj4gICBzdGF0aWMgdm9pZCBkd2MzX2VwMF9wcmVwYXJlX29uZV90cmIoc3RydWN0IGR3
YzNfZXAgKmRlcCwNCj4gICAJCWRtYV9hZGRyX3QgYnVmX2RtYSwgdTMyIGxlbiwgdTMyIHR5cGUs
IGJvb2wgY2hhaW4pDQo+IEBAIC0zNjUsNyArMzY3LDcgQEAgc3RhdGljIGludCBkd2MzX2VwMF9o
YW5kbGVfc3RhdHVzKHN0cnVjdCBkd2MzICpkd2MsDQo+ICAgCQkgKiBGdW5jdGlvbiBSZW1vdGUg
V2FrZSBDYXBhYmxlCUQwDQo+ICAgCQkgKiBGdW5jdGlvbiBSZW1vdGUgV2FrZXVwCUQxDQo+ICAg
CQkgKi8NCj4gLQkJYnJlYWs7DQo+ICsJCXJldHVybiBkd2MzX2VwMF9kZWxlZ2F0ZV9yZXEoZHdj
LCBjdHJsKTsNCg0KV2h5IGRvIHdlIG5lZWQgdG8gZGVsZWdhdGUgdG8gZ2FkZ2V0IGRyaXZlcj8N
Cg0KV2UgbmVlZCB0byBjaGVjayBpZiB0aGUgaG9zdCBhcm1zIHRoZSByZW1vdGUgd2FrZXVwLCBh
bmQgd2UgbmVlZCB0byANCmNoZWNrIGlmIHRoZSBnYWRnZXQgaXMgY2FwYWJsZSBvZiByZW1vdGUg
d2FrZXVwLiBGb3IgZXhhbXBsZSwgaXQncyBvZGQgDQpmb3IgbWFzc19zdG9yYWdlIGRldmljZSB0
byBiZSByZW1vdGUgY2FwYWJsZS4NCg0KU28gd2UgbmVlZCBhIGZsYWcgaW4gdXNiX2dhZGdldCBm
b3IgdGhhdC4gSGF2ZSBkd2MzIGNoZWNrIGFnYWluc3QgdGhhdCANCmZsYWcgYmVmb3JlIHNldHRp
bmcgaXQuDQoNClNvbWV0aGluZyBsaWtlIHRoaXM6DQoNCmlmIChkd2MtPmdhZGdldC0+cndfY2Fw
YWJsZSkgew0KIMKgwqDCoCB1c2Jfc3RhdHVzID0gVVNCX0lOVFJGX1NUQVRfRlVOQ19SV19DQVA7
DQogwqDCoMKgIGlmIChkd2MtPnJ3X2FybWVkKQ0KIMKgwqDCoMKgwqDCoMKgIHVzYl9zdGF0dXMg
fD0gVVNCX0lOVEVSRl9TVEFUX0ZVTkNfUlc7DQp9DQoNCg0KPiAgIA0KPiAgIAljYXNlIFVTQl9S
RUNJUF9FTkRQT0lOVDoNCj4gICAJCWRlcCA9IGR3YzNfd0luZGV4X3RvX2RlcChkd2MsIGN0cmwt
PndJbmRleCk7DQo+IEBAIC01MTEsMTMgKzUxMyw3IEBAIHN0YXRpYyBpbnQgZHdjM19lcDBfaGFu
ZGxlX2ludGYoc3RydWN0IGR3YzMgKmR3YywNCj4gICANCj4gICAJc3dpdGNoICh3VmFsdWUpIHsN
Cj4gICAJY2FzZSBVU0JfSU5UUkZfRlVOQ19TVVNQRU5EOg0KPiAtCQkvKg0KPiAtCQkgKiBSRVZJ
U0lUOiBJZGVhbGx5IHdlIHdvdWxkIGVuYWJsZSBzb21lIGxvdyBwb3dlciBtb2RlIGhlcmUsDQo+
IC0JCSAqIGhvd2V2ZXIgaXQncyB1bmNsZWFyIHdoYXQgd2Ugc2hvdWxkIGJlIGRvaW5nIGhlcmUu
DQo+IC0JCSAqDQo+IC0JCSAqIEZvciBub3csIHdlJ3JlIG5vdCBkb2luZyBhbnl0aGluZywganVz
dCBtYWtpbmcgc3VyZSB3ZSByZXR1cm4NCj4gLQkJICogMCBzbyBVU0IgQ29tbWFuZCBWZXJpZmll
ciB0ZXN0cyBwYXNzIHdpdGhvdXQgYW55IGVycm9ycy4NCj4gLQkJICovDQo+ICsJCXJldCA9IGR3
YzNfZXAwX2RlbGVnYXRlX3JlcShkd2MsIGN0cmwpOw0KDQpBZ2Fpbiwgd2h5IGFyZSB3ZSBkZWxl
Z2F0aW5nIHRoaXMgdG8gdGhlIGdhZGdldCBkcml2ZXI/IFRoaXMgY2FuIGJlIGRvbmUgDQpoZXJl
IGFzIHNvbWV0aGluZyBsaWtlIHRoaXM6DQoNCmlmIChkd2MtPmdhZGdldC0+cndfY2FwYWJsZSAm
JiBzZXQgJiYNCiDCoMKgwqDCoCAod0luZGV4ICYgVVNCX0lOVFJGX0ZVTkNfU1VTUEVORF9SVykp
DQogwqDCoMKgwqDCoMKgwqAgZHdjLT5yd19hcm1lZCA9IDE7DQplbHNlDQogwqDCoMKgwqDCoMKg
wqAgZHdjLT5yd19hcm1lZCA9IDA7DQoNCmR3Yy0+cndfc2VsZWN0ZWRfaW50ZXJmYWNlID0gd0lu
ZGV4ICYgMHhmZjsNCg0KPiAgIAkJYnJlYWs7DQo+ICAgCWRlZmF1bHQ6DQo+ICAgCQlyZXQgPSAt
RUlOVkFMOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZl
cnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gaW5kZXggZDY2OTdkYS4uMGIyOTQ3ZSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2Mz
L2dhZGdldC5jDQo+IEBAIC0yMzU3LDYgKzIzNTcsMzUgQEAgc3RhdGljIGludCBkd2MzX2dhZGdl
dF93YWtldXAoc3RydWN0IHVzYl9nYWRnZXQgKmcpDQo+ICAgCXJldHVybiByZXQ7DQo+ICAgfQ0K
PiAgIA0KPiArc3RhdGljIGludCBkd2MzX2dhZGdldF9mdW5jX3dha2V1cChzdHJ1Y3QgdXNiX2dh
ZGdldCAqZywgaW50IGludGVyZmFjZV9pZCkNCg0KRG9uJ3QgcGFzcyB0aGlzIHdvcmsgdG8gdGhl
IGdhZGdldCBkcml2ZXIuIFRoZSB1cHBlcmxheWVyIGRvZXNuJ3Qga25vdyANCndoZW4gdG8gc2Vu
ZCB0aGUgZnVuY3Rpb24gd2FrZXVwLiBUaGUgZHdjMyBkcml2ZXIgc2hvdWxkIHNlbmQgdGhlIA0K
ZnVuY3Rpb24gd2FrZXVwIHdoZW4gdGhlIGRldmljZSBpcyBpbiB0aGUgc3RhdGUgVTAsIGFuZCB0
aGUgZHdjMyBkcml2ZXIgDQpnZXRzIHRoYXQgaW5mbyBmaXJzdCBoYW5kLg0KDQo+ICt7DQo+ICsJ
aW50CXJldCA9IDA7DQo+ICsJdTMyCXJlZzsNCj4gKwlzdHJ1Y3QJZHdjMyAqZHdjID0gZ2FkZ2V0
X3RvX2R3YyhnKTsNCj4gKw0KPiArCXJlZyA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0RT
VFMpOw0KPiArDQo+ICsJLyoNCj4gKwkgKiBJZiB0aGUgbGluayBpcyBpbiBMUE0sIGZpcnN0IGJy
aW5nIHRoZSBsaW5rIHRvIFUwDQo+ICsJICogYmVmb3JlIHRyaWdnZXJpbmcgZnVuY3Rpb24gd2Fr
ZXVwLiBJZGVhbGx5IHRoaXMNCj4gKwkgKiBuZWVkcyB0byBiZSBleHBhbmRlZCB0byBvdGhlciBM
UE1zIGFzIHdlbGwgaW4NCj4gKwkgKiBhZGRpdGlvbiB0byBVMw0KPiArCSAqLw0KPiArCWlmIChE
V0MzX0RTVFNfVVNCTE5LU1QocmVnKSA9PSBEV0MzX0xJTktfU1RBVEVfVTMpIHsNCg0KWW91J3Jl
IG5vdCBkb2luZyBVMCBsaW5rIGNoZWNrIGhlcmUuDQoNCj4gKwkJZHdjM19nYWRnZXRfd2FrZXVw
KGcpOw0KPiArCQlyZXR1cm4gLUVBR0FJTjsNCj4gKwl9DQo+ICsNCj4gKwlyZXQgPSBkd2MzX3Nl
bmRfZ2FkZ2V0X2dlbmVyaWNfY29tbWFuZChkd2MsIERXQzNfREdDTURfWE1JVF9ERVYsDQo+ICsJ
CQkJCSAgICAgICAweDEgfCAoaW50ZXJmYWNlX2lkIDw8IDQpKTsNCg0KVGhlIGludGVyZmFjZV9p
ZCBoZXJlIGlzIHRoZSBkd2MtPnJ3X3NlbGVjdGVkX2ludGVyZmFjZSBhcyBub3RlZCBlYXJsaWVy
Lg0KDQo+ICsNCj4gKwlpZiAocmV0KQ0KPiArCQlkZXZfZXJyKGR3Yy0+ZGV2LCAiRnVuY3Rpb24g
d2FrZXVwIEhXIGNvbW1hbmQgZmFpbGVkLCByZXQgJWRcbiIsDQo+ICsJCQlyZXQpOw0KPiArDQo+
ICsJcmV0dXJuIHJldDsNCj4gK30NCj4gKw0KPiAgIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfc2V0
X3NlbGZwb3dlcmVkKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnLA0KPiAgIAkJaW50IGlzX3NlbGZwb3dl
cmVkKQ0KPiAgIHsNCj4gQEAgLTI5NzgsNiArMzAwNyw3IEBAIHN0YXRpYyB2b2lkIGR3YzNfZ2Fk
Z2V0X2FzeW5jX2NhbGxiYWNrcyhzdHJ1Y3QgdXNiX2dhZGdldCAqZywgYm9vbCBlbmFibGUpDQo+
ICAgc3RhdGljIGNvbnN0IHN0cnVjdCB1c2JfZ2FkZ2V0X29wcyBkd2MzX2dhZGdldF9vcHMgPSB7
DQo+ICAgCS5nZXRfZnJhbWUJCT0gZHdjM19nYWRnZXRfZ2V0X2ZyYW1lLA0KPiAgIAkud2FrZXVw
CQkJPSBkd2MzX2dhZGdldF93YWtldXAsDQo+ICsJLmZ1bmNfd2FrZXVwCQk9IGR3YzNfZ2FkZ2V0
X2Z1bmNfd2FrZXVwLA0KPiAgIAkuc2V0X3NlbGZwb3dlcmVkCT0gZHdjM19nYWRnZXRfc2V0X3Nl
bGZwb3dlcmVkLA0KPiAgIAkucHVsbHVwCQkJPSBkd2MzX2dhZGdldF9wdWxsdXAsDQo+ICAgCS51
ZGNfc3RhcnQJCT0gZHdjM19nYWRnZXRfc3RhcnQsDQoNCkJSLA0KVGhpbmgNCg==
