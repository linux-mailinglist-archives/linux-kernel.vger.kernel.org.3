Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265EB57C18E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 02:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiGUA1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 20:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiGUA1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 20:27:14 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5037B51437;
        Wed, 20 Jul 2022 17:27:12 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26KLkQ5d031900;
        Wed, 20 Jul 2022 17:26:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=N9wT+Ip4cFkjKD+x8UZOCL9sn8PkajkVbA0S1V6uapk=;
 b=eIYGCeDPnLs+f5isY2KYU8yCPviCtaSydpOt44cnTSbA3rvPcZDdJzzioaBEDZjhiWkl
 ADScdyBoYkD9EbRIg4d1gQbeybJTw85GdHjVKC9jAIHUcMIQmQ21T4hHn2CANV1zWwN+
 ci76lSqo1oyEqolD1/Eax2oVvK1vJoNIwKzzNdZUg5O6OXG5NNS1splzsYyAz82FJ/pb
 VJILTadUoPraOZt1dv+6ytqPmIXHNagJU1aH0Qkihw3r8s2Xc3sH4U9wRaLlaESWx+eM
 e809BnNC7Ep/imGklatlsrJpH8Dimt3Dke4SEldl2H9frNnzmaHBVDUF4YFhyvLItzN5 LA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3hc6dew29v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 17:26:58 -0700
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9A189C001A;
        Thu, 21 Jul 2022 00:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1658363218; bh=N9wT+Ip4cFkjKD+x8UZOCL9sn8PkajkVbA0S1V6uapk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=mQhaq71vICshc2IZepZOHXvW1pOndiZwsUa3H6HOCmhB3PMfsqJ8cd0Kmqljgs517
         pPGJehiS3Vok+51QBzY+PV1esL9kZsT7MrTwrQ8AZwQtM4QkfuXj26CvOtADzJerw+
         yikUORTFjb/PB40cixlheb4EH+s6VyDZQ8P//UuQ9NfkLHFJMTR8p/SQ1tWE6xUrCi
         vdJNuXIYnyFZi41HL3jQ8/lX38A+culTXrHdcFt2iAqJeXp2G4/ceN5lEEaB2hbi3l
         hBGsUmjfAH8Z0UlnMzb2VWlhtiZdc5h6bUpXDyMz1bt1yBF3UpQ9l0Jv6cmsCgJNjn
         Bqk2CbaLGWnJQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id BEAD3A0083;
        Thu, 21 Jul 2022 00:26:56 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id F230C40066;
        Thu, 21 Jul 2022 00:26:55 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="KrOVoD1s";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIwH2lgUL1VmyGvWYd1EkOPOaCD8rIzsSPTX96Mt47VDAJBNd5y5/Q4MXN/EjnmbZLeAeabTodb7VHBvW/L9CPwgbueAmMluMRnJbwiIdy94DaF+iu5d32p8Y97TGvvRoYjLiuzeHzVd7rRyB/Y6h6uviT0syKzKhWBq9Y3AVxlFjggiBsg3rhQE+EazmNsyUH5vWUEDUcB973HZKwsrvtolTqrD8nkpzBbJJcQixLWT7KNzcfDSIxo5HEoiHW6gdmv/rKwn9KcDh3MW6PMF+xQvRB41zKn8uKrBnXpaI4wAewSoiJzgNCxUalnv1C4se8eAtW4xgsr1GIWqzyGfdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9wT+Ip4cFkjKD+x8UZOCL9sn8PkajkVbA0S1V6uapk=;
 b=SssqxaNtNCacvTugNKtoYQMC0ZEobuD4WHEETvwYI2WBX6nCR9CFG32kc6GXeRZo1GHmV2D1InK5Uu1cC47lingVmRDMgB+zSswYjp39GRByfvNTVx0EYg/RYmXSL/8bU3LddIqkbbJGbk95KMP4BuQob29QYWWoKpSvAEX+GcMClywVtPt1p+aDp1lJ7ipo3BnuKNziQHyuvmVwoSArs6d0qVn+dTayh++yIkLhwIft2+lYY5jJDQifm6vEOoawBW/c5E3BZj6xnY+wUpQ2iaEj7r0DAzO1axciROP4Fx6HNGMFiYMEsWLCFXlLE7dOXDtDzChQb2eSMxz8KPNmOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9wT+Ip4cFkjKD+x8UZOCL9sn8PkajkVbA0S1V6uapk=;
 b=KrOVoD1sXvUlj9wJbxlsBtPxo2E4P2spNkd1FIxzh5FQNQTgVG2stbZcTUqwOMwSpFKNtJoF4AoSjbh0vFDfcWyQTy6MVByvbqu0qs42bBvt+NUauv5YszGVRj+YRcU7D++8TG2hq9OqFuIdVeSi8WewZi37/def+veHLZ/EBGs=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CH2PR12MB3912.namprd12.prod.outlook.com (2603:10b6:610:2c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Thu, 21 Jul
 2022 00:26:51 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c%7]) with mapi id 15.20.5438.023; Thu, 21 Jul 2022
 00:26:50 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v2 3/5] usb: dwc3: gadget: Adjust IRQ management during
 soft disconnect/connect
Thread-Topic: [PATCH v2 3/5] usb: dwc3: gadget: Adjust IRQ management during
 soft disconnect/connect
Thread-Index: AQHYllCHX2wxupDRtESpWCuKNObxnq1+JHYAgAmCNQCAAF3WgA==
Date:   Thu, 21 Jul 2022 00:26:50 +0000
Message-ID: <64dbd459-5e57-c938-f055-3b6c14350c99@synopsys.com>
References: <20220713003523.29309-1-quic_wcheng@quicinc.com>
 <20220713003523.29309-4-quic_wcheng@quicinc.com>
 <fbfc9328-418c-4c5e-4553-993331b20cb6@synopsys.com>
 <3e6867cc-489a-b626-ff9c-79615613b2dd@quicinc.com>
In-Reply-To: <3e6867cc-489a-b626-ff9c-79615613b2dd@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04e833d8-85bb-487c-7c2a-08da6aafb45e
x-ms-traffictypediagnostic: CH2PR12MB3912:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qpqFgEC6rL5jqjNcKaDiqo3T5J+bTzBPU3c72Mezbj2+cBNr/Maflal5s6H1U6IMTjduC5TBjIcwhizfxJMmd4BCdE6PixU+wrUHVk/JRA0fvt1bC/d6b6DzfKkLes+bxs+HBbR/uZ5hacRP21qJgCbbwnpR1Z2amZl//JZ9PGAMi7+Fz3yvSGMnZYEvZIk7qqPQVJLMeVJ9q0+PA8n7aJGI1A/mq7JRlGi2S5Wthk0ctMRxMpd+MoiyqpN647AB2ai4k+LfCNJD3Xx/5z1SSeD89kU1l2swyfLGRR+ISHrswdot0AQyRM30V/BTy7ZuREcMqGimwqvjJBI8umjhoGj7w174aygWNDGhxaSSmAZCtD42ZSb1GOVXtZgKw+1HTGCTUcsfWfo+JOyGkr1vEm6X9/KrzUuVNhIXc1xNxL8VJzOWAjs/AfXLaGr1CihbD2SRfto3sjoUqBZxWYy5XodUkmBt9Km0+9mc2g5gwjPVsHbNHVwBvS7ahFG/3XdpgjGF1DuDfnxN+mPL1bvasByt06uvK0+cDRClhRmgYlFY3TcvzjSGMWXo43tLKn3v5CgnswkSyspzQnUdyF0Fty4siMPDNCzLYh2267jaPPmGh2pafqYF+ZODIGDL7nLY8MhZmsrS9V5zND7mXsXfkccspw3dbKX4c2gJbe0GL6oxHZfIHGfOnAleSACrRg4UbvLLLlle5Zb817NTLxAskWEnC8vfj/XR193RRr6YWsED2jBQJZkcwgKMKgXg8X7UqeZeSnaHUaCRmuXRAGK9xrzNVb3u7VEMVLRnNEF7WHKNrrBKhWTDiD+VWXe3yo5MAk/s+Idz7Ysi8RNCchnRaOBj68i5MLIF7RGmQ3i9A4I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(396003)(136003)(376002)(346002)(122000001)(54906003)(110136005)(316002)(76116006)(71200400001)(66556008)(64756008)(66476007)(66446008)(38070700005)(36756003)(4326008)(31686004)(8676002)(66946007)(5660300002)(26005)(41300700001)(2906002)(6512007)(83380400001)(8936002)(86362001)(38100700002)(2616005)(6506007)(186003)(6486002)(53546011)(31696002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFp1RDl4ZEV2SU8xS0E1SWRCV09aSStObnV2SUdXMzgwZWI5WC9QNG9VRUZp?=
 =?utf-8?B?NXJuNHo5NGpLT2J3WmtacHFzTDlwZUhYWTg3SW15d0ptZEtreWpxYlVwOThO?=
 =?utf-8?B?aWpSdFJMS3dwcC9ZRU5Pb201UDAyRSt4em8rdzV2ZnV5aFBIbTJlczRtVStD?=
 =?utf-8?B?VjYrcDVmc1lnZVVJaURBOGFjT0dBdGRRQnVFMTNFSGs3T29wZnVRZ0RYendZ?=
 =?utf-8?B?Z0o3M040SERMYWdheGhDWmtXbDRoMW1Eamh1ZUNNQXNoOFpYd0VLbEtiR1Yz?=
 =?utf-8?B?dHMycDhnNFJTSkFUZHFteC90ZFVIQUxaOUl0VlMycjhxcnFmUk41bHVKUnpu?=
 =?utf-8?B?SURyanhvWHlPSEc2Y1R5UWJEZGVhNXN6SFgwb1pqQUlQekE4UUt1T2JwRDVr?=
 =?utf-8?B?eHo3d2FvS1psdG5pUXdESUlRSjZsekRrRWxyV3I0VmxOdHJFUDhJVzVGQnlY?=
 =?utf-8?B?SG8rb1RWK2N1cFhZZHVsOW1aSldGRnFrS0dESjM0cXRuUzV5THlMVlFGeXhG?=
 =?utf-8?B?RTZvSXlOVHdCZ2MyL0lmSHpjY2xvd3dMKytvVEZhQWJ1NDEwQmY0eDRBeitN?=
 =?utf-8?B?WnZTNEM3U3VpUFpQV1Z4b0w3MUpvT1huSTU1NG56NDloL3RJN09BNXZneVoz?=
 =?utf-8?B?aUkxdi9ValE5czZ0V2xwZkxpaTZXWnArQTg0KzVqT2hxV2xxR2xldjhEaVlL?=
 =?utf-8?B?WnJ5VHd5bzl5UVJqVXo2amduWThiSUp4dlhad2NJWWl6VytkWWZMcG5BbWtu?=
 =?utf-8?B?S05rK3RzOVNFL1NEemRkRHJUVTRRcVM2R0x2V1I2UzFLOGMxVDBFUEdBd1hs?=
 =?utf-8?B?Z1A2QkZtWGtCaGRwUlFUWFJXYzZoZSs2MWxadGc0cGlCdEc3NHg0NkQyK1pt?=
 =?utf-8?B?WVZVZlFDYk8zcmJjc1lzYnRObEtIK0JlaFRhb2ZZQzVPVjhtajk4c1RXa2hq?=
 =?utf-8?B?OVBvNDJpT1hGWHVzSnRJbnhqOWpJOVRWMjJVUll6YUxRTCtIdlNEcmlSSzZi?=
 =?utf-8?B?VWhMejNhSm9ybURadjdBTU1KbWwraThBN0Y5K29GTHdyRXdob0RjOGY0OW5q?=
 =?utf-8?B?cU41d2RtS1JMUG9oY1B6RzJudUY3K1RqTmFFUG1rNjJCaWY4MXFOV0hlTmxl?=
 =?utf-8?B?ZlU2eEc0OEF2b1hnS25tVFBDSndYVlZwMDdVWWZ0QTJUQ2RLQkVKaGFWS1JE?=
 =?utf-8?B?dGt5Uis3bWhwOEFyelZmRThOL0J6YUg0bXhiS1RUeUdPRzNJV1plYnozeXpU?=
 =?utf-8?B?N0REOG1RTGlMS2xFT0hHRmFhSEFCeDZvY2o3c3A5dDZBeDBLWnk2UHV5SEkw?=
 =?utf-8?B?RnlxTFVMcDEwVTZFK3p1RFdkN0N5Ly9ucW0zMzMwdlhJaU1JRmVmS2lzbnBM?=
 =?utf-8?B?RzZGVU5UaDA1bkZublpuMEhlTU9XdnJsQXJQQXNXSVRQd2s3WDZGaXloV3pP?=
 =?utf-8?B?eXgrQzJQRzZ4bEIyend6a1JLdjBLSFUxVXpkd0h0QjhWNnJtQXZDZDVlbUZC?=
 =?utf-8?B?VXBXWVRqdFc2eUUxMk1CSmMvc1VINURDa2thdUZjQ0x3NmltdW5QZ216S3RU?=
 =?utf-8?B?d3Q4blVWa21LblQyVXEycHZYTHFxZDkxalhHYVJPbVpyTnc2RlFUOVJFWlRZ?=
 =?utf-8?B?RGxTdnJZMVhKVmF4NVFBZC9rK2tNeUdieEZzN3FEZ1lpSi85eW1VcHlrbGlp?=
 =?utf-8?B?NTZSTXZBUzU0MWdIQURRQi9mS09pTkN4SlEzdnNqVWNvd1dUQ29ZK01YK2FX?=
 =?utf-8?B?S1ZSTmsxK2Zvb0RHbVJTZFlpTVFkaGU5SnlGeWRZL2cvRUlXVERjN1JVcGF1?=
 =?utf-8?B?SjBSL3NoMlRPd2I5N2NvTFM4bVlSV0RXdWhsK0pzMUIzUERBQjdXK3BiVFYz?=
 =?utf-8?B?bWhweTRGWHgycHJlTXEzOXFEcnJzdXkvYWlHQlhRTVpnUFhidkNFR0IxL2RK?=
 =?utf-8?B?RWMvOHprRUcvZ2cwV2hUdmptSkhwVUpTSENPcUVrRE15a1pqL0crdTY2c3A3?=
 =?utf-8?B?UGZrNzh5ZDJ0dWRNZjliMkRzeWk1UXJEM1h0YnlZK1JVZ3BvcVBpaitHOUpT?=
 =?utf-8?B?U2huRzFoMG5kS1hsWTE2bDM4Tk5zamIvK2hyNnAvVk1CQTJuSHlmTS9lKzhp?=
 =?utf-8?Q?BqsI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF9D2B392237534D9B4D7C9DD3E91BFF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e833d8-85bb-487c-7c2a-08da6aafb45e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 00:26:50.3789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FGcl5VyonLtsF6qXW7obPrC+lxrysqVPo9BfR17ttOOhgUSvOfA6bpkjgEDLNXRK3W8emZ/w98mkinYBvLjFcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3912
X-Proofpoint-ORIG-GUID: wawx7FmEOovlT9j1ICzpd6E_TCeU44Dl
X-Proofpoint-GUID: wawx7FmEOovlT9j1ICzpd6E_TCeU44Dl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_12,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 bulkscore=0 mlxscore=0
 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207210000
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgV2VzbGV5LA0KDQpPbiA3LzIwLzIwMjIsIFdlc2xleSBDaGVuZyB3cm90ZToNCj4gSGkgVGhp
bmgsDQo+DQo+IE9uIDcvMTQvMjAyMiAxMDozOCBBTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPj4g
T24gNy8xMi8yMDIyLCBXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+Pj4gTG9jYWwgaW50ZXJydXB0cyBh
cmUgY3VycmVudGx5IGJlaW5nIGRpc2FibGVkIGFzIHBhcnQgb2YgYXF1aXJpbmcgdGhlDQo+Pj4g
c3BpbiBsb2NrIGJlZm9yZSBpc3N1aW5nIHRoZSBlbmR4ZmVyIGNvbW1hbmQuwqAgTGVhdmUgaW50
ZXJydXB0cyANCj4+PiBlbmFibGVkLCBzbw0KPj4+IHRoYXQgRVAwIGV2ZW50cyBjYW4gY29udGlu
dWUgdG8gYmUgcHJvY2Vzc2VkLsKgIEFsc28sIGVuc3VyZSB0aGF0IA0KPj4+IHRoZXJlIGFyZQ0K
Pj4+IG5vIHBlbmRpbmcgaW50ZXJydXB0cyBiZWZvcmUgYXR0ZW1wdGluZyB0byBoYW5kbGUgYW55
IHNvZnQNCj4+PiBjb25uZWN0L2Rpc2Nvbm5lY3QuDQo+Pj4NCj4+PiBGaXhlczogODYxYzAxMGEy
ZWUxICgidXNiOiBkd2MzOiBnYWRnZXQ6IFJlZmFjdG9yIHB1bGx1cCgpIikNCj4+PiBTaWduZWQt
b2ZmLWJ5OiBXZXNsZXkgQ2hlbmcgPHF1aWNfd2NoZW5nQHF1aWNpbmMuY29tPg0KPj4+IC0tLQ0K
Pj4+IMKgwqAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDIxICsrKysrKysrKysrKy0tLS0t
LS0tLQ0KPj4+IMKgwqAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDkgZGVsZXRp
b25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBi
L2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4+PiBpbmRleCBhNDU1ZjhkNDYzMWQuLmVlODVi
NzczZTNmZSAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+Pj4g
KysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPj4+IEBAIC0xNjc0LDYgKzE2NzQsNyBA
QCBzdGF0aWMgaW50IF9fZHdjM19nYWRnZXRfZ2V0X2ZyYW1lKHN0cnVjdCBkd2MzIA0KPj4+ICpk
d2MpDQo+Pj4gwqDCoCBzdGF0aWMgaW50IF9fZHdjM19zdG9wX2FjdGl2ZV90cmFuc2ZlcihzdHJ1
Y3QgZHdjM19lcCAqZGVwLCBib29sIA0KPj4+IGZvcmNlLCBib29sIGludGVycnVwdCkNCj4+PiDC
oMKgIHsNCj4+PiDCoMKgwqDCoMKgwqAgc3RydWN0IGR3YzNfZ2FkZ2V0X2VwX2NtZF9wYXJhbXMg
cGFyYW1zOw0KPj4+ICvCoMKgwqAgc3RydWN0IGR3YzMgKmR3YyA9IGRlcC0+ZHdjOw0KPj4+IMKg
wqDCoMKgwqDCoCB1MzIgY21kOw0KPj4+IMKgwqDCoMKgwqDCoCBpbnQgcmV0Ow0KPj4+IMKgwqAg
QEAgLTE2ODIsNyArMTY4Myw5IEBAIHN0YXRpYyBpbnQgDQo+Pj4gX19kd2MzX3N0b3BfYWN0aXZl
X3RyYW5zZmVyKHN0cnVjdCBkd2MzX2VwICpkZXAsIGJvb2wgZm9yY2UsIGJvb2wgaW50DQo+Pj4g
wqDCoMKgwqDCoMKgIGNtZCB8PSBpbnRlcnJ1cHQgPyBEV0MzX0RFUENNRF9DTURJT0MgOiAwOw0K
Pj4+IMKgwqDCoMKgwqDCoCBjbWQgfD0gRFdDM19ERVBDTURfUEFSQU0oZGVwLT5yZXNvdXJjZV9p
bmRleCk7DQo+Pj4gwqDCoMKgwqDCoMKgIG1lbXNldCgmcGFyYW1zLCAwLCBzaXplb2YocGFyYW1z
KSk7DQo+Pj4gK8KgwqDCoCBzcGluX3VubG9jaygmZHdjLT5sb2NrKTsNCj4+PiDCoMKgwqDCoMKg
wqAgcmV0ID0gZHdjM19zZW5kX2dhZGdldF9lcF9jbWQoZGVwLCBjbWQsICZwYXJhbXMpOw0KPj4+
ICvCoMKgwqAgc3Bpbl9sb2NrKCZkd2MtPmxvY2spOw0KPj4+IMKgwqDCoMKgwqDCoCBXQVJOX09O
X09OQ0UocmV0KTsNCj4+PiDCoMKgwqDCoMKgwqAgZGVwLT5yZXNvdXJjZV9pbmRleCA9IDA7DQo+
Pj4gwqDCoCBAQCAtMjAyOSwxMiArMjAzMiwxMSBAQCBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X2Vw
X2RlcXVldWUoc3RydWN0IA0KPj4+IHVzYl9lcCAqZXAsDQo+Pj4gwqDCoMKgwqDCoMKgIHN0cnVj
dCBkd2MzX2VwwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqZGVwID0gdG9fZHdjM19lcChlcCk7DQo+
Pj4gwqDCoMKgwqDCoMKgIHN0cnVjdCBkd2MzwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqZHdjID0g
ZGVwLT5kd2M7DQo+Pj4gwqDCoCAtwqDCoMKgIHVuc2lnbmVkIGxvbmfCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGZsYWdzOw0KPj4+IMKgwqDCoMKgwqDCoCBpbnTCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0ID0gMDsNCj4+PiDCoMKgIMKgwqDCoMKgwqDCoCB0cmFjZV9kd2MzX2VwX2Rl
cXVldWUocmVxKTsNCj4+PiDCoMKgIC3CoMKgwqAgc3Bpbl9sb2NrX2lycXNhdmUoJmR3Yy0+bG9j
aywgZmxhZ3MpOw0KPj4+ICvCoMKgwqAgc3Bpbl9sb2NrKCZkd2MtPmxvY2spOw0KPj4+IMKgwqAg
wqDCoMKgwqDCoMKgIGxpc3RfZm9yX2VhY2hfZW50cnkociwgJmRlcC0+Y2FuY2VsbGVkX2xpc3Qs
IGxpc3QpIHsNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAociA9PSByZXEpDQo+Pj4gQEAg
LTIwNzMsNyArMjA3NSw3IEBAIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfZXBfZGVxdWV1ZShzdHJ1
Y3QgDQo+Pj4gdXNiX2VwICplcCwNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXF1ZXN0LCBl
cC0+bmFtZSk7DQo+Pj4gwqDCoMKgwqDCoMKgIHJldCA9IC1FSU5WQUw7DQo+Pj4gwqDCoCBvdXQ6
DQo+Pj4gLcKgwqDCoCBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkd2MtPmxvY2ssIGZsYWdzKTsN
Cj4+PiArwqDCoMKgIHNwaW5fdW5sb2NrKCZkd2MtPmxvY2spOw0KPj4+IMKgwqAgwqDCoMKgwqDC
oMKgIHJldHVybiByZXQ7DQo+Pj4gwqDCoCB9DQo+Pj4gQEAgLTI0ODksOSArMjQ5MSw3IEBAIHN0
YXRpYyBpbnQgX19kd2MzX2dhZGdldF9zdGFydChzdHJ1Y3QgZHdjMyAqZHdjKTsNCj4+PiDCoMKg
IMKgwqAgc3RhdGljIGludCBkd2MzX2dhZGdldF9zb2Z0X2Rpc2Nvbm5lY3Qoc3RydWN0IGR3YzMg
KmR3YykNCj4+PiDCoMKgIHsNCj4+PiAtwqDCoMKgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+Pj4g
LQ0KPj4+IC3CoMKgwqAgc3Bpbl9sb2NrX2lycXNhdmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPj4+
ICvCoMKgwqAgc3Bpbl9sb2NrKCZkd2MtPmxvY2spOw0KPj4+IMKgwqDCoMKgwqDCoCBkd2MtPmNv
bm5lY3RlZCA9IGZhbHNlOw0KPj4+IMKgwqAgwqDCoMKgwqDCoMKgIC8qDQo+Pj4gQEAgLTI1MDYs
MTAgKzI1MDYsMTAgQEAgc3RhdGljIGludCANCj4+PiBkd2MzX2dhZGdldF9zb2Z0X2Rpc2Nvbm5l
Y3Qoc3RydWN0IGR3YzMgKmR3YykNCj4+PiDCoMKgIMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlaW5p
dF9jb21wbGV0aW9uKCZkd2MtPmVwMF9pbl9zZXR1cCk7DQo+Pj4gwqDCoCAtwqDCoMKgwqDCoMKg
wqAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+Pj4gK8KgwqDC
oMKgwqDCoMKgIHNwaW5fdW5sb2NrKCZkd2MtPmxvY2spOw0KPj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJldCA9IHdhaXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCgmZHdjLT5lcDBfaW5fc2V0dXAs
DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1zZWNzX3RvX2ppZmZp
ZXMoRFdDM19QVUxMX1VQX1RJTUVPVVQpKTsNCj4+PiAtwqDCoMKgwqDCoMKgwqAgc3Bpbl9sb2Nr
X2lycXNhdmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPj4+ICvCoMKgwqDCoMKgwqDCoCBzcGluX2xv
Y2soJmR3Yy0+bG9jayk7DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJldCA9PSAwKQ0K
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2X3dhcm4oZHdjLT5kZXYsICJ0aW1l
ZCBvdXQgd2FpdGluZyBmb3IgU0VUVVAgDQo+Pj4gcGhhc2VcbiIpOw0KPj4+IMKgwqDCoMKgwqDC
oCB9DQo+Pj4gQEAgLTI1MjMsNyArMjUyMyw3IEBAIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfc29m
dF9kaXNjb25uZWN0KHN0cnVjdCANCj4+PiBkd2MzICpkd2MpDQo+Pj4gwqDCoMKgwqDCoMKgwqAg
Ki8NCj4+PiDCoMKgwqDCoMKgwqAgZHdjM19zdG9wX2FjdGl2ZV90cmFuc2ZlcnMoZHdjKTsNCj4+
PiDCoMKgwqDCoMKgwqAgX19kd2MzX2dhZGdldF9zdG9wKGR3Yyk7DQo+Pj4gLcKgwqDCoCBzcGlu
X3VubG9ja19pcnFyZXN0b3JlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4+PiArwqDCoMKgIHNwaW5f
dW5sb2NrKCZkd2MtPmxvY2spOw0KPj4+IMKgwqAgwqDCoMKgwqDCoMKgIC8qDQo+Pj4gwqDCoMKg
wqDCoMKgwqAgKiBOb3RlOiBpZiB0aGUgR0VWTlRDT1VOVCBpbmRpY2F0ZXMgZXZlbnRzIGluIHRo
ZSBldmVudCANCj4+PiBidWZmZXIsIHRoZQ0KPj4+IEBAIC0yNTY5LDYgKzI1NjksOCBAQCBzdGF0
aWMgaW50IGR3YzNfZ2FkZ2V0X3B1bGx1cChzdHJ1Y3QgDQo+Pj4gdXNiX2dhZGdldCAqZywgaW50
IGlzX29uKQ0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAwOw0KPj4+IMKgwqDCoMKg
wqDCoCB9DQo+Pj4gwqDCoCArwqDCoMKgIHN5bmNocm9uaXplX2lycShkd2MtPmlycV9nYWRnZXQp
Ow0KPj4+ICsNCj4+PiDCoMKgwqDCoMKgwqAgaWYgKCFpc19vbikgew0KPj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJldCA9IGR3YzNfZ2FkZ2V0X3NvZnRfZGlzY29ubmVjdChkd2MpOw0KPj4+IMKg
wqDCoMKgwqDCoCB9IGVsc2Ugew0KPj4+IEBAIC0zNzI5LDYgKzM3MzEsNyBAQCB2b2lkIGR3YzNf
c3RvcF9hY3RpdmVfdHJhbnNmZXIoc3RydWN0IGR3YzNfZXAgDQo+Pj4gKmRlcCwgYm9vbCBmb3Jj
ZSwNCj4+PiDCoMKgwqDCoMKgwqDCoCAqLw0KPj4+IMKgwqAgwqDCoMKgwqDCoMKgIF9fZHdjM19z
dG9wX2FjdGl2ZV90cmFuc2ZlcihkZXAsIGZvcmNlLCBpbnRlcnJ1cHQpOw0KPj4+ICsNCj4+PiDC
oMKgIH0NCj4+PiDCoMKgIMKgwqAgc3RhdGljIHZvaWQgZHdjM19jbGVhcl9zdGFsbF9hbGxfZXAo
c3RydWN0IGR3YzMgKmR3YykNCj4+DQo+PiBIaSBHcmVnLA0KPj4NCj4+IFBsZWFzZSBkb24ndCBw
aWNrIHVwIHRoaXMgcGF0Y2ggeWV0LiBXZSdyZSBzdGlsbCBpbiBkaXNjdXNzaW9uIHdpdGgNCj4+
IHRoaXMuIEkgaGF2ZSBzb21lIGNvbmNlcm4gd2l0aCB1bmxvY2tpbmcvbG9ja2luZyB3aGVuIHNl
bmRpbmcgRW5kDQo+PiBUcmFuc2ZlciBjb21tYW5kLiBGb3IgZXhhbXBsZSwgdGhpcyBwYXRjaCBt
YXkgY2F1c2UgaXNzdWVzIHdpdGgNCj4+IERXQzNfRVBfRU5EX1RSQU5TRkVSX1BFTkRJTkcgY2hl
Y2tzLg0KPj4NCj4+IEhpIFdlc2xleSwNCj4+DQo+PiBEaWQgeW91IHRyeSBvdXQgbXkgc3VnZ2Vz
dGlvbiB5ZXQ/DQo+Pg0KPg0KPiBKdXN0IHByb3ZpZGluZyBhIHF1aWNrIHVwZGF0ZS4NCj4NCj4g
U28gd2l0aCB5b3VyIHN1Z2dlc3Rpb24sIEkgd2FzIGFibGUgdG8gY29uc2lzdGVudGx5IHJlcHJv
ZHVjZSB0aGUgDQo+IGNvbnRyb2xsZXIgaGFsdCBpc3N1ZSBhZnRlciBhIGRheSBvciBzbyBvZiB0
ZXN0aW5nLsKgIEhvd2V2ZXIsIHdoZW4gSSANCj4gdG9vayBhIGZ1cnRoZXIgbG9vaywgSSBiZWxp
ZXZlIHRoZSBwcm9ibGVtIGlzIGR1ZSB0byB0aGUgRFdDMyBldmVudCANCj4gaGFuZGxlcjoNCj4N
Cj4gc3RhdGljIHZvaWQgZHdjM19lbmRwb2ludF9pbnRlcnJ1cHQoc3RydWN0IGR3YzMgKmR3YywN
Cj4gwqDCoMKgwqDCoMKgwqAgY29uc3Qgc3RydWN0IGR3YzNfZXZlbnRfZGVwZXZ0ICpldmVudCkN
Cj4gew0KPiAuLi4NCj4gwqDCoMKgwqBpZiAoIShkZXAtPmZsYWdzICYgRFdDM19FUF9FTkFCTEVE
KSkgew0KPiDCoMKgwqDCoMKgwqDCoCBpZiAoIShkZXAtPmZsYWdzICYgRFdDM19FUF9UUkFOU0ZF
Ul9TVEFSVEVEKSkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47DQo+DQo+IMKgwqDC
oMKgwqDCoMKgIC8qIEhhbmRsZSBvbmx5IEVQQ01EQ01QTFQgd2hlbiBFUCBkaXNhYmxlZCAqLw0K
PiDCoMKgwqDCoMKgwqDCoCBpZiAoZXZlbnQtPmVuZHBvaW50X2V2ZW50ICE9IERXQzNfREVQRVZU
X0VQQ01EQ01QTFQpDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0KPiDCoMKgwqDC
oH0NCj4NCj4gVGhlIHNvZnQgZGlzY29ubmVjdCByb3V0aW5lIHJlYWNoZWQgdG8gdGhlIHJ1bi9z
dG9wIHBvbGxpbmcgcG9pbnQsIGFuZCANCj4gSSBjb3VsZCBzZWUgdGhhdCBEV0MzX0VQX0RFTEFZ
RURfU1RPUCB3YXMgc2V0LCBhbmQgd2UgZ290IGEgDQo+IHhmZXJjb21wbGV0ZSBldmVudCBmb3Ig
dGhlIFNUQVRVUyBwaGFzZS7CoCBIb3dldmVyLCBzaW5jZSB3ZSBleGl0IGVhcmx5IA0KPiBpbiB0
aGUgZXZlbnQgaGFuZGxlciAoZHVlIHRvIF9fZHdjM19nYWRnZXRfc3RvcCgpIGJlaW5nIGNhbGxl
ZCBhbmQgDQo+IGRpc2FibGluZyBFUDApLCB0aGUgU1RBVFVTIGNvbXBsZXRlIGlzIG5ldmVyIGhh
bmRsZWQsIGFuZCB3ZSBkbyBub3QgDQo+IGlzc3VlIHRoZSBlbmR4ZmVyIGNvbW1hbmQuDQo+DQo+
IEkgZG9uJ3QgdGhpbmsgSSBzYXcgdGhpcyBpc3N1ZSB3aXRoIG15IGNoYW5nZSwgYXMgd2UgYWxs
b3dlZCB0aGUgDQo+IFNUQVRVUyBwaGFzZSBoYW5kbGluZyB0byBoYXBwZW4gQkVGT1JFIGdhZGdl
dCBzdG9wIHdhcyBjYWxsZWQgKHNpbmNlIEkgDQo+IHJlbGVhc2VkIHRoZSBsb2NrIGluIHRoZSBz
dG9wIGFjdGl2ZSB0cmFuc2ZlcnMgQVBJKS4NCj4NCj4gSG93ZXZlciwgSSB0aGluayBldmVuIHdp
dGggbXkgYXBwcm9hY2gsIHdlJ2QgZXZlbnR1YWxseSBydW4gaW50byBhIA0KPiBwb3NzaWJpbGl0
eSBvZiB0aGlzIGlzc3VlLCBhcyB3ZSBhcmVuJ3QgdHJ1bHkgaGFuZGxpbmcgRVAwIGV2ZW50cyAN
Cj4gd2hpbGUgcG9sbGluZyBmb3IgdGhlIGhhbHRlZCBzdGF0dXMgZHVlIHRvIHRoZSBhYm92ZS7C
oCBJdCB3YXMganVzdCANCj4gcmVkdWNpbmcgdGhlIGNoYW5jZXMuwqAgVGhlIHNjZW5hcmlvIG9m
IHRoaXMgaXNzdWUgaXMgY29taW5nIGJlY2F1c2UgDQo+IHRoZSBob3N0IHRvb2sgYSBsb25nIHRp
bWUgdG8gY29tcGxldGUgdGhlIFNUQVRVUyBwaGFzZSwgc28gd2UgcmFuIGludG8gDQo+IGEgInRp
bWVkIG91dCB3YWl0aW5nIGZvciBTRVRVUCBwaGFzZSwiIHdoaWNoIGFsbG93ZWQgdXMgdG8gY2Fs
bCB0aGUgDQo+IHJ1bi9zdG9wIHJvdXRpbmUgd2hpbGUgd2Ugd2VyZSBub3QgeWV0IGluIHRoZSBT
RVRVUCBwaGFzZS4NCj4NCj4gSSdtIGN1cnJlbnRseSBydW5uaW5nIGEgY2hhbmdlIHRvIGFkZCBh
IEVQIG51bSBjaGVjayB0byB0aGlzIElGIA0KPiBjb25kaXRpb246DQo+DQo+IMKgwqDCoMKgaWYg
KChlcG51bSA+IDEpICYmICEoZGVwLT5mbGFncyAmIERXQzNfRVBfRU5BQkxFRCkpIHsNCj4gwqDC
oMKgwqDCoMKgwqAgaWYgKCEoZGVwLT5mbGFncyAmIERXQzNfRVBfVFJBTlNGRVJfU1RBUlRFRCkp
DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0KPg0KPiDCoMKgwqDCoMKgwqDCoCAv
KiBIYW5kbGUgb25seSBFUENNRENNUExUIHdoZW4gRVAgZGlzYWJsZWQgKi8NCj4gwqDCoMKgwqDC
oMKgwqAgaWYgKGV2ZW50LT5lbmRwb2ludF9ldmVudCAhPSBEV0MzX0RFUEVWVF9FUENNRENNUExU
KQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsNCj4gwqDCoMKgwqB9DQo+DQoNCkFo
Li4uIGdvb2QgY2F0Y2ghIFRoYW5rcyBmb3IgYWxsIHRoZSB0ZXN0aW5ncy4NCg0KQlIsDQpUaGlu
aA0K
