Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08BA57D6CB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 00:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbiGUWVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 18:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiGUWU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 18:20:57 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730E13B96E;
        Thu, 21 Jul 2022 15:20:53 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LLPSt2018774;
        Thu, 21 Jul 2022 15:20:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=8SAfPWT/rB6XLas6pneRnCZ0f7M/rtCnNjl5ZbMeEeo=;
 b=EGNUUWI6ZdMxR+CtmWmz07Fr4erllneEsoq8o/mt6KJII9LWU/vQUe1iFQnACIyC9NVR
 Oa0sRfR4dy/EOnbH2T+/87LxAa4bVjUMLS7/Oh+bhpgjl/BXKj5UvNffw6/PNiwSgCpI
 VzJJHPMao3/vp5pUAzzt8t7W+bv14dBGgrh/ve3e3H9Qgtt8m+DdoimC3KD6rx4X84Kk
 0mdDRsfJO8q8GWduyaXkaATldogPCSrDIaUtb7isxNyQg/OxKw+ium/+A7FDO0klSviK
 DZbNqnhi9fHbOTsuxMNzsl4lLsTylXr1r3kwdfLjwG8BXO74hAPvUneQRD/JNz/1VDnG 4w== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3hc6df2kkg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 15:20:46 -0700
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 96F364002B;
        Thu, 21 Jul 2022 22:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1658442045; bh=8SAfPWT/rB6XLas6pneRnCZ0f7M/rtCnNjl5ZbMeEeo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=RPRv46y0aHASjFfskxO5v/UcDObj8WVdbkXMylYnpsfTeZaTrha6qO2NdjeZoYe8p
         3+rj5v4I3gXPfQNJt9sMbVlI9JS7uJm3u20DAIWrgOdVT/z/Br5K3MyMWej42f+AQw
         KPbFz4s5938eBqP3XSC2He+N+DytnmlC1tVPJik9/FEFbMjWT2RiNOtiA0Mr7CkYVF
         95U1LwPtwFqItsakTiJh21+e25xNt6k1QvvHhvy/qRlPDiK6EJWfzDLhRwezjwi2FF
         HDSgYORMc5S4zMR//3oUKVT0GA3RE+K2U5+52XKhbatwr6yNuj4s39iWBV5Wdaorxg
         ij/MPaUHcw8zA==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id CE438A0081;
        Thu, 21 Jul 2022 22:20:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5D56080078;
        Thu, 21 Jul 2022 22:20:43 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="LsjjWvHZ";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkExcKHeoy6/L/yJQMdlI02GAF2SuemHAYH9DYQlw0CwbvseWYCx9pmYgIv2FlmJvSm/pU1VPE2d6CbImLJnMI95Z7QGk9Iy/bnsVFQZY3LYGBA6SJs0WT6PRLLgx+NPQHpi8tSamfLVvWgARuaDhsNmCSjvmRXZKNySLgLlFi/MS2Iek/zLqbxxHHT6uapAn56Zy7xOmuB67YJcvOrxd9AMk6Fk4Jp1xONI22VVEGRG67V99ojjCaUhalCsgoM+JI+v4xAVlPV8Wbkm8oi0QOTYNf/vOgSEsKe764mRUbuHRcbsEcewuDiUt6/Zb/OYeKG8qnlvoIKuJk9ff4rd2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SAfPWT/rB6XLas6pneRnCZ0f7M/rtCnNjl5ZbMeEeo=;
 b=gnEIEsTpd0no07e9gE88oBvHjnuXI4lqU4EGfYA+1WWoz31YU1wVCj6M9SLiFksP7WZ3nXdln82RQHpnv1dX5bfcJ1bYGwdtbOPSFoF1CYFfEncpznhD2uzwDklBSqMod2asTo+E9rk5vdjuaMN5oc+MBlSkLBFc4XYWJtDBAZvlwn0/ORHsWPcEG/E+yKySqcNkPZmDfOYSaADOs7LjzSVWLFCnsEzienNemnWMgR7TnVosfc1fVT1dfKWxSi/Tnxt7cZKZw5rVdgwxglXctZigoiHAIuE6FZvKTo/HMsq9vib/dHlnuVpYMwTIdYoeTr5I4zuX6jqi8uEBXNQ2Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SAfPWT/rB6XLas6pneRnCZ0f7M/rtCnNjl5ZbMeEeo=;
 b=LsjjWvHZgdFnvN9K+tdduhQmL2kQFBlBPuWfJSctzIKjhOXyQuNhoSprEe4GOoSTt6BevxOtOMvciTxOyzn13xTm61MoYl3IMB+2cz9Jq3HBFCCyhby31NZjOMvnyo8xAfONfbYTF+MuO92GHnhdbY3jaJL9zrgqKgJZLD17+4U=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MW2PR12MB4683.namprd12.prod.outlook.com (2603:10b6:302:5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 22:20:40 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c%7]) with mapi id 15.20.5438.023; Thu, 21 Jul 2022
 22:20:40 +0000
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
Thread-Index: AQHYllCHTDdRJ4wf3U6yBQnRzTv93K2JcEyAgAABOoCAAAIPgA==
Date:   Thu, 21 Jul 2022 22:20:40 +0000
Message-ID: <5d0cf380-e045-fcec-639f-ac2f6a187ca8@synopsys.com>
References: <20220713003523.29309-1-quic_wcheng@quicinc.com>
 <20220713003523.29309-5-quic_wcheng@quicinc.com>
 <d8d26ce3-6773-bd9c-e227-0924f239eae0@synopsys.com>
 <98623d02-cde4-b036-a85c-9325b58c7eab@quicinc.com>
In-Reply-To: <98623d02-cde4-b036-a85c-9325b58c7eab@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6cf90a45-1245-489d-7068-08da6b673ea6
x-ms-traffictypediagnostic: MW2PR12MB4683:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QYeE5AVjft1VECg+tejpbje/BDj+Zmv9O2QwYjkAmZbrM8lnImSsMSPVLYMHdY6SjgAjyulRzoUgIypgZqVLVS47QX4bFCF4SEM69R1waqZz5947VTQVN47RkVujvvnldGNHXNI5Y5WK9oQIVypR6edmcMw+CWhGYYPGm2p2vhLzKbZBE5zYYHms5sRi6Jx3qsUv6iHv5r2QuDfF4FFAxH6ezF21gXewupx03fDmDF6iA40f/mmrgCaPoun3UNkEJCkoRd4DuXRKpju90mXXUZqmxYa9wJMyt9BszqFD1suDuit8W7MAHQn111k4R/tcL5jBYi/f4lqgNQpHA/4IH7B+pkvt6tWgNLl5AN5ON2ZS+83KOEclVL5jZ8ct1qIwh4hPIIpH6zF+NSZksgGk6uhG6CZrhdTw8KHP0LVo5bo8cEqMKI1Qcflt8bVljEUe0Up+dK/e1BGWAsFFwMfYvX78VL43zCRnVpGO8Q9NxN0UpJppYePUjTWmmmEmmiT+Pa8/rMtgZnOrke/mftxDFhPM0rAY4tMoTuVNLUyfdu0fOVFQ1ZWya3+Km2MbSUH4cbtCqh/TrAnS8hXD+avS8zsZB2d9pFJTy54ZmJCD7bi5+x4JtE2HIc7dPzexuiwnmwqyqk9q9huukXCXnRIRp+T2ge/1o/mVKRwhrCofBwFRnDQWwxcWngMCHFx2ZtZ3eJkuPHkqETFnM4WFFTmL6oaQ+r/xjbQT2QD2rX+oXmJraTfF3sD1kQodMzVw3TnF4kVK93Te50tlGV8Ock3CaqkmNAXpNb2cMUrC3NS/Y6FR3OivLaZgz6ISt/XxEgmxThpPE8Szbum+TTvvWkEeA70zjVSgQ+dlveT/VO4C0yB4exNsu2JHWMs0v4AN2ydB8N6WC0HCL8+T0WxcwUasNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(39860400002)(396003)(136003)(366004)(38070700005)(53546011)(71200400001)(122000001)(36756003)(86362001)(6512007)(31696002)(110136005)(31686004)(2616005)(26005)(478600001)(38100700002)(41300700001)(966005)(6486002)(54906003)(316002)(6506007)(186003)(66946007)(8676002)(66476007)(4326008)(64756008)(8936002)(5660300002)(66556008)(66446008)(83380400001)(2906002)(76116006)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M01sV0J5NlZBdThJUUJ5ZGNNWVA5NDhVd05ncmtsdzlTTjNobUFSVTZMb1dx?=
 =?utf-8?B?MkppZFN0NzBwVlQ3TnJHL2FscG1hN0tXSWdOWE1mUzlOSE13WXNaWnRhcFhy?=
 =?utf-8?B?aTJkZ1IwamZIVStsK2xuRlRTR1BqVXJmNVJTV21SamlxR1g0NjhaK01BajRH?=
 =?utf-8?B?V014L21aMG5BREphcVZYR1FaeEU4WW8rbTZZWjhtcTdVdkErRzZIcjhFUVdG?=
 =?utf-8?B?Q3Fybk5NK3g3TXlEdXVyeHZQYmEzVnM2TDJQVXdxamZPRm9KUHRJWVJ2TTkr?=
 =?utf-8?B?MS80VzZVekJrQnJoQ215OWtBN2pIeFRYMzV2aVNqZlcvc1NuekdpZFVqV1ZB?=
 =?utf-8?B?UXJxeGJJUHRLOGNPVW9zd3p5V1ZKelNmck9yZzlXUzJYT1AvSUFFdzlpbVk4?=
 =?utf-8?B?ZDFDalZ5SElZUUZCdXhSYU1MQWxRcXZrQjRBeE1wNHhITmxrYzBiTk9JVnlM?=
 =?utf-8?B?eHpzTWxKUE5LdlRzYXpuNkMvTWxxdHRkQ2hZN09lRHdxUFZFelZkeVMxUHU5?=
 =?utf-8?B?YUJCSmhyWTFuVFpDWmxjZnoxYzF2cDhlTEdWN3F3Qm52L09iWXprVWlyUk9H?=
 =?utf-8?B?QmVaT25qWFl4b0xxeGpldTZBOVFpTUlhbXpiU2ZwOXQ0aGdpYnV4RFhpVWJn?=
 =?utf-8?B?OVpsdTdaMXF1NFovOXRXTjdsOW5JbGZRMFBiK1BSekdlVVBNWVVIamIza09E?=
 =?utf-8?B?V2hFbGNmNVBrNDRqTlppQXBldUhrSnlLYkVITjBxL1djcklwcHZXbXZPc1gw?=
 =?utf-8?B?L205ZWhpb09tOUt1ZVAyblVxUk5CWkVKU0JDcDFGUHZzcTkveXQ3cW5HRkFw?=
 =?utf-8?B?dEdGMWszeWVDdTNuSm14VlNKLy9BZktaRWIyNzh0OFh2MldOcUZCTVdLeEZh?=
 =?utf-8?B?Y2tTdnBhNWY0aGlpcFV1OEFWQkIvU0FzQUNyYnFZRFRzajVsSlJhRmtRbE9B?=
 =?utf-8?B?MVkzbTA5Q2tOc2lnSmJ3d2NwVGZRcnU1T1lhbm8zdEl4Q2QvQUpjVVE4YytL?=
 =?utf-8?B?NVpXWHlib0N0enVPRE9FT2dLbVVQa1EwY212ODhYMU5IQ0VCbDN6ckFjWjdk?=
 =?utf-8?B?SzBMeEs3S0FLT3dtWE9nTElHa0U3STJRRytiSElENEZEeVZlMExHVS9uSVla?=
 =?utf-8?B?UlJsQXlhb3VnbjFHdXc4RFo2U1llYnpjNEw0cjdoa04wVm5TdjdORXJkK3FJ?=
 =?utf-8?B?N0JoZHBQWVFIUUVPVFBTOXVVbnArSVdSckkzVmdEOTFNTVdyKzdNQVgyTjNY?=
 =?utf-8?B?RHBaL2FaZ0dmK2Nqc1dyVi8xZ0ZTNE1ZekVRekZsRlhCWmQ5WVJDZzBodmN1?=
 =?utf-8?B?cEhseFM1ZGhtOHJXSy84ZkJ6UDNyU2FPTEJ3clN1MjJpd2YvRUxOZ2VOaVU5?=
 =?utf-8?B?dENJcU5xQzlzU1htQmFnOWp1aWZuQUlnQm43VkRhUE96cDV5d0VENkNXVWpn?=
 =?utf-8?B?N1dXUk50a0xYVlMwTkV0alZmWHd3WnlTcjkzRzdLR1dSdnViT3hlQ1RvVUVy?=
 =?utf-8?B?aWxISEROVmR3bisxMk1CeGZaYVFZMmtsa0w1YUYyZDdzZUpXM1pMc2tQWmRR?=
 =?utf-8?B?L0V3TGdGZXFWSXhjMG0wdk43Tk1qTDJWRENGMzM4aDlKcy95SGtFS0RvTm1k?=
 =?utf-8?B?QW9Pb0NlUmFPa2pxN0ttaWQ1Vk9yVVgzbElYNHlsTU92WSs4ZnFYc0tSUjc5?=
 =?utf-8?B?SnlpT0cvMEtydFFUUTJHNi9raE5STWNwd05ZTGZGeTl5YytjSkJna2RJdEdE?=
 =?utf-8?B?VE50YmxxajI2TU01TTMyaTBhTjBXK2hlSW9aUmtBUjFGMWdRM045S0syMnMr?=
 =?utf-8?B?cG5TWVFGd2ZKMUVRSjQ5MGcrZWlpbDNoM0N6d0VzTllTb0JTeG5POVRTWHZv?=
 =?utf-8?B?eldrcnE3S2hZc282aVlVenkwclZEZ3piQ05UZFN6UUZ5UXpraVFUUFlLQ1Mr?=
 =?utf-8?B?KzRTQkszeFlTblBHcytDUzMyQjBNWkJYSCtIdnA0R3FYUjRQK3lsUFZra0ds?=
 =?utf-8?B?MlJyVFd0TjhTM0JHekloOWZXT2lMUXVWU1U5UUw1N1Rodi9FL3JPUVBmWW9V?=
 =?utf-8?B?a3YxSlJ5TjNCRHdmWCtBK3NVNy9INEtobnFOVmU2b295WnVYcENkbXlUYlJw?=
 =?utf-8?Q?AdkiRI9lA9fls5J3CxjsNOF3q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6202BAC50467D468856ECA1458FF41E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf90a45-1245-489d-7068-08da6b673ea6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 22:20:40.2620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8WPQfuD0c/QbKrIZYRJz7icfKNF38b/R7ul+OcmDKG95dv7syFXy87ooWQUdaww2qxkLj3MLX+mrjx9IB7dATg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB4683
X-Proofpoint-ORIG-GUID: YtWRFp5wp1FPZtMh1rj32E9gZu6rXC44
X-Proofpoint-GUID: YtWRFp5wp1FPZtMh1rj32E9gZu6rXC44
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_28,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 bulkscore=0 mlxscore=0
 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207210091
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8yMS8yMDIyLCBXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+IEhpIFRoaW5oLA0KPg0KPiBPbiA3
LzIxLzIwMjIgMzowOCBQTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPj4gSGkgV2VzbGV5LA0KPj4N
Cj4+IE9uIDcvMTIvMjAyMiwgV2VzbGV5IENoZW5nIHdyb3RlOg0KPj4+IElmIHNvZnQgZGlzY29u
bmVjdCBpcyBpbiBwcm9ncmVzcywgYWxsb3cgdGhlIGVuZHhmZXIgY29tbWFuZCB0byBiZSANCj4+
PiBzZW50LA0KPj4+IHdpdGhvdXQgdGhpcywgdGhlcmUgaXMgYW4gaXNzdWUgd2hlcmUgdGhlIHN0
b3AgYWN0aXZlIHRyYW5zZmVyIGNhbGwNCj4+PiAoZHVyaW5nIHB1bGx1cCBkaXNhYmxlKSB3b3Vs
ZG4ndCBhY3R1YWxseSBpc3N1ZSB0aGUgZW5keGZlciBjb21tYW5kLA0KPj4+IHdoaWxlIGNsZWFy
aW5nIHRoZSBERVAgZmxhZy4NCj4+Pg0KPj4+IEluIGFkZGl0aW9uLCBpZiB0aGUgRFdDM19FUF9E
RUxBWV9TVE9QIGZsYWcgd2FzIHNldCBiZWZvcmUgc29mdCANCj4+PiBkaXNjb25uZWN0DQo+Pj4g
c3RhcnRlZCAoaS5lLiBmcm9tIHRoZSBkZXF1ZXVlIHBhdGgpLCBlbnN1cmUgdGhhdCB3aGVuIHRo
ZSBFUDAgDQo+Pj4gdHJhbnNhY3Rpb24NCj4+PiBjb21wbGV0ZXMgZHVyaW5nIHNvZnQgZGlzY29u
bmVjdCwgdG8gaXNzdWUgdGhlIGVuZHhmZXIgd2l0aCB0aGUgZm9yY2UNCj4+PiBwYXJhbWV0ZXIg
c2V0LCBhcyBpdCBkb2VzIG5vdCBleHBlY3QgYSBjb21tYW5kIGNvbXBsZXRlIGV2ZW50Lg0KPj4+
DQo+Pj4gRml4ZXM6IGU0Y2Y2NTgwYWM3NDAgKCJ1c2I6IGR3YzM6IGdhZGdldDogV2FpdCBmb3Ig
ZXAwIHhmZXJzIHRvIA0KPj4+IGNvbXBsZXRlIGR1cmluZyBkZXF1ZXVlIikNCj4+PiBTdWdnZXN0
ZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBXZXNsZXkgQ2hlbmcgPHF1aWNfd2NoZW5nQHF1aWNpbmMuY29tPg0KPj4+IC0t
LQ0KPj4+IExpbms6DQo+Pj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xpbnV4LXVzYi8xYTFhNTQ4NS03OTBlLTc5Y2UtZjVhNi0xZTk2ZDliNDlh
NDdAc3lub3BzeXMuY29tL19fOyEhQTRGMlI5R19wZyFjWFcyVGxBTFlXblhOUGctTm9NRlVyUThL
MWVnRVppUWl6WjVDQTFET00xR2N3NHRmT1VMeS1fMmVNR3ZMOHBRUHRlNWRTY0ZPTi0wd3hIMmVY
dThpakVRVWJzJA0KPj4+DQo+Pj4gwqDCoCBkcml2ZXJzL3VzYi9kd2MzL2VwMC5jwqDCoMKgIHwg
MyArLS0NCj4+PiDCoMKgIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCA1ICsrKystDQo+Pj4g
wqDCoCAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+
Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2VwMC5jIGIvZHJpdmVycy91c2Iv
ZHdjMy9lcDAuYw0KPj4+IGluZGV4IDUwNmVmNzE3ZmRjMC4uNTg1MWIwZTlkYjBhIDEwMDY0NA0K
Pj4+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZXAwLmMNCj4+PiArKysgYi9kcml2ZXJzL3VzYi9k
d2MzL2VwMC5jDQo+Pj4gQEAgLTI5MCw4ICsyOTAsNyBAQCB2b2lkIGR3YzNfZXAwX291dF9zdGFy
dChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICghKGR3YzNf
ZXAtPmZsYWdzICYgRFdDM19FUF9ERUxBWV9TVE9QKSkNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGNvbnRpbnVlOw0KPj4+IMKgwqAgLcKgwqDCoMKgwqDCoMKgIGR3YzNfZXAtPmZs
YWdzICY9IH5EV0MzX0VQX0RFTEFZX1NUT1A7DQo+Pg0KPj4gSWYgd2UgZG9uJ3QgY2xlYXIgdGhp
cyBmbGFnIGhlcmUsDQo+Pg0KPg0KPiBUaGlzIGlzIHdoeSBJIGFkZGVkIHRoZSBkd2MtPmNvbm5l
Y3RlZCBhcmd1bWVudCB0byBjb250cm9sIHRoZSANCj4gImludGVycnVwdCIgYXJndW1lbnQuDQo+
DQo+Pj4gLSBkd2MzX3N0b3BfYWN0aXZlX3RyYW5zZmVyKGR3YzNfZXAsIHRydWUsIHRydWUpOw0K
Pj4+ICvCoMKgwqDCoMKgwqDCoCBkd2MzX3N0b3BfYWN0aXZlX3RyYW5zZmVyKGR3YzNfZXAsIHRy
dWUsIGR3Yy0+Y29ubmVjdGVkKTsNCj4+PiDCoMKgwqDCoMKgwqAgfQ0KPj4+IMKgwqAgfQ0KPj4+
IMKgwqAgZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3Vz
Yi9kd2MzL2dhZGdldC5jDQo+Pj4gaW5kZXggZWU4NWI3NzNlM2ZlLi40MWI3MDA3MzU4ZGUgMTAw
NjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPj4+ICsrKyBiL2RyaXZl
cnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4+PiBAQCAtMTY5Myw2ICsxNjkzLDcgQEAgc3RhdGljIGlu
dCBfX2R3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXIoc3RydWN0IA0KPj4+IGR3YzNfZXAgKmRlcCwg
Ym9vbCBmb3JjZSwgYm9vbCBpbnQNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXAtPmZsYWdz
ICY9IH5EV0MzX0VQX1RSQU5TRkVSX1NUQVJURUQ7DQo+Pj4gwqDCoMKgwqDCoMKgIGVsc2UgaWYg
KCFyZXQpDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVwLT5mbGFncyB8PSBEV0MzX0VQX0VO
RF9UUkFOU0ZFUl9QRU5ESU5HOw0KPj4+ICvCoMKgwqAgZGVwLT5mbGFncyAmPSB+RFdDM19FUF9E
RUxBWV9TVE9QOw0KPj4+IMKgwqAgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7DQo+Pj4gwqDCoCB9
DQo+Pj4gQEAgLTM2ODYsOCArMzY4NywxMCBAQCB2b2lkIGR3YzNfc3RvcF9hY3RpdmVfdHJhbnNm
ZXIoc3RydWN0IGR3YzNfZXAgDQo+Pj4gKmRlcCwgYm9vbCBmb3JjZSwNCj4+PiDCoMKgwqDCoMKg
wqAgaWYgKGRlcC0+bnVtYmVyIDw9IDEgJiYgZHdjLT5lcDBzdGF0ZSAhPSBFUDBfREFUQV9QSEFT
RSkNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47DQo+Pj4gwqDCoCArwqDCoMKgIGlm
IChpbnRlcnJ1cHQgJiYgKGRlcC0+ZmxhZ3MgJiBEV0MzX0VQX0RFTEFZX1NUT1ApKQ0KPj4+ICvC
oMKgwqDCoMKgwqDCoCByZXR1cm47DQo+Pj4gKw0KPj4NCj4+IHRoZW4gaXQgbWF5IG5vdCBnbyB0
aHJvdWdoIGhlcmUuIEkgdGhpbmsgSSBtYWRlIHRoaXMgc2FtZSBtaXN0YWtlIGluIG15DQo+PiBw
cmV2aW91cyBzdWdnZXN0aW9uLg0KPj4NCj4NCj4gU2luY2UgZHdjLT5jb25uZWN0ZWQgaXMgc2V0
IHRvIEZBTFNFIGJlZm9yZSB3ZSBjYWxsIHN0b3AgYWN0aXZlIA0KPiB0cmFuc2ZlcnMsIGlmIHdl
IGV2ZXIgcnVuIGludG8gYSBzaXR1YXRpb24gd2hlcmUgZGVsYXllZCBzdG9wIGlzIHNldCANCj4g
YWxyZWFkeSwgdGhlbiBpdCBzaG91bGQgZ28gdGhyb3VnaC4NCj4NCg0KVGhlbiB0aGUgY2hlY2sg
Zm9yIHJlcXVlc3QgZGVxdWV1ZSB0aGF0IHdlIGRpZCBwcmV2aW91c2x5IHdpbGwgbm90IHdvcmsg
DQphbnltb3JlLg0KDQpCUiwNClRoaW5oDQo=
