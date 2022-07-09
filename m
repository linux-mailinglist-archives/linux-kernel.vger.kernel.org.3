Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671E056C5C7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 03:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiGIBsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 21:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiGIBr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 21:47:59 -0400
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26BC7CB4C;
        Fri,  8 Jul 2022 18:47:56 -0700 (PDT)
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0533EC0D6D;
        Sat,  9 Jul 2022 01:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1657331276; bh=B7KxSb7y+8QEjcLoe5OfBNCi20qLvwQOB3GsdKuVfsQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=EMQcwFEyVZENzrHxN6LgwVWmirq6Iv0RZ08HRehPUDx6skWSvjQnZ4aqmn3POxLth
         gFaxd0kyL0IDr4xoWxj/v6D55VxsKrufAZib5hDz1c4S/UvDLalEYpDicQz7iXfETY
         TKHbeMuPASg0MXA2w8JukfXVf30khsLAmtmHVWLcrizAXMn+EOmg3xSX4pHewfKS2t
         p5ktVSIL5uY42uRuE3UWztc4j6lmM8ueQWtl1rFoAfeGhyw594JV1diGaGc9guSUfU
         SBg7P1gOwu2HfY3w2ZW28XWXT9+FwkNeXyUxAiHohe0gjCglRwbjSTYpIp3dqQkuRB
         3fNKTfIqVi1gw==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 44FABA0087;
        Sat,  9 Jul 2022 01:47:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 3305880078;
        Sat,  9 Jul 2022 01:47:54 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="VtfQGv/B";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U971myH2MzECopD2IIF1F+p90Vbr+QjfVMglqq5caOqiNKPWaqQPFa/Ex7xiFTYLh4VpDZJAC0oH1juNNINxgoT3OcUhrBa3K2RM3+jMLOPkIzKRU6p/sEw5XZOrnOLyzyVvUsfpwWUKbfnkZNM7wOB2fpqdk94dq8OKyjKtLOPJvIo+OT0XaFRJtc7/KJTmhA803tqfXVrysDfkCf4hQ8B0Ga5jSnLiL+oS2sDL9rib5AEKccAkGDHnXG1Pg3PfZFq6a8ujsy6nB24g6y+19HFG+6j2Byjp9/jxuTDxRys9qa3VRmSDvQ9/3xcniRZr/Lcjl0lfUTdhgXAslcSV/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7KxSb7y+8QEjcLoe5OfBNCi20qLvwQOB3GsdKuVfsQ=;
 b=Zwl+SmGwjZj04ADahLcEHUl6xdpfxfehBCpwY97NEDPE5PM9i/jXqI/DhpHQyfzafHwlE6OdauL+azaVhWkg2nSlS8+2H0v1UG2vnoIzRk1/2ZxjJ8T+txRWNanLnHmD/JJwiRxpBl/SLxTgH5P9X73qUVCD4Pp1n4glMlROJSwWb1T8Ee7y2jVAF+rglhmsZ3dvgUGxUqoUwbtoMP4fZZGzbNlpKTzUdmO4EtJFTQMf2EPLVq2PWKMlUsPICc8mXqhViK95ayIsbHuvVewY9JbZx9nNX21P12gpxGIoDnAsJybmvlClk7A6Iuty6CtTPOflNxD3QNIkuXSbNcDlnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7KxSb7y+8QEjcLoe5OfBNCi20qLvwQOB3GsdKuVfsQ=;
 b=VtfQGv/BGAszC3VtJJgIHu1WSWbxszkNM0VOIt4Ppinl+pEuESX1SFzFblMGcnuxVNKM9TMg14iNp3pCmzppfM4ptghp2OzGacTnDvj/Hnlu+7/Y90/Sw41gNnDk5thkrmRD8LfFLsyxAozODbnIKcjw+UE0mmFfSjhaTLA2qFw=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by LV2PR12MB5965.namprd12.prod.outlook.com (2603:10b6:408:172::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Sat, 9 Jul
 2022 01:47:51 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c%7]) with mapi id 15.20.5417.016; Sat, 9 Jul 2022
 01:47:51 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH 5/5] usb: dwc3: gadget: Increase DWC3 controller halt
 timeout
Thread-Topic: [PATCH 5/5] usb: dwc3: gadget: Increase DWC3 controller halt
 timeout
Thread-Index: AQHYkvuzEvircNK7eUiyLmOBJXjtfK11RdMA
Date:   Sat, 9 Jul 2022 01:47:50 +0000
Message-ID: <d61b21f6-5518-9064-57bd-a3141656448b@synopsys.com>
References: <20220708185007.21743-1-quic_wcheng@quicinc.com>
 <20220708185007.21743-6-quic_wcheng@quicinc.com>
In-Reply-To: <20220708185007.21743-6-quic_wcheng@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59f53284-48f0-4076-b923-08da614d0863
x-ms-traffictypediagnostic: LV2PR12MB5965:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gQpjai2H2k5X7NequQhJDPbO+aU57rMU7GrEJXzSeHOKW3ziN3P0rX6G9GvhVgYznzUZq3rOL+wK5OfVj9dYbW4Hkg2vj39JvAKdbePuHDOXkc6OBHnjWhExrSTqLS4xm3sbPG2Te9KUVlLv8dy7gRA0MNM6d7g+LtuNS1qpHhbInBuvdrt8M+/uegNlrbV9dwIm9U36kj3Wk0fn8e633MqKa3kVoBGzu7cf+c0v/oXpkXHH6ec48CRavcAAHIn8x54MEI7/XZTwZXoS5uccuxfn5L82bSnLKDuH6n7I+yYuU78oIbGiG7nxKMBsS6ny6MtqI+alKUQGzA54hTbHV024RYU7LCZYX884cqlkP6eimtLoLwlh5j4hfHE2Er+E+C7rXUk+2qTQgE1sB7kNUmdW/a8LvaBqQyScoU2r3by9BlEOsdPjysrIGhECLtxaOxmkb9eOjs9GnnU7+u7IYMOyryipdkblHUVsS2LAnm1ZS43aJzslFugoh+x1+5N9DbGtZSmrqmrZi88PcZAYACC+SGlOt4qQXyqBp9hA1pZ9Pd4snSZxfA0ZX0G1oeehYPC5u3GfZepy0Y0hWbcgUEGKSPpNpPf/pybiE0LxePGDCv89KEhFmSv/VZWkpKHiQp4evTptUm14YiVd1liax3dklbAg1dxSvl3CLkWnEH/vV56n9ZUg/836jp/kMkLBS4vBRbTJXhTVbJnEI+pUwLSaAQyZLXd2n6PgW/Uwa1NG5TIXaJNvhxrJ2M3Vv4WQAs8IF/G51H4VpkYSBPfnai3Y0wgIW/CUke9FS1MkjvrQqz4nkweA7D4e2zpqVY653r5EKCigrTBcJ5gWJ5TUP3fOk4Y/O2ogBVLA4FMPctfwJaQSH0PWSItIk0+JNBjx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(396003)(346002)(136003)(366004)(6512007)(478600001)(36756003)(2616005)(86362001)(122000001)(4744005)(31686004)(54906003)(2906002)(110136005)(8936002)(38070700005)(71200400001)(83380400001)(26005)(31696002)(76116006)(6506007)(41300700001)(8676002)(38100700002)(66556008)(5660300002)(66476007)(66446008)(64756008)(6486002)(316002)(4326008)(66946007)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXR2VFVUbDRUZEFoMWxranpmb3h6V2NFd29SdFhQNFhIMm1MdGVpZmJPckMw?=
 =?utf-8?B?eDFrS1ZUN1VCMkh4OTVueVJiRTFCdWhqcmhRc01jVnZXeUNOQkFrM2VCS3Jz?=
 =?utf-8?B?dXl4QXByMFFEOVk4MWgzejBEeDh2dmp0UFZsenN4eXVJNC9LbU1QK09XcTVu?=
 =?utf-8?B?ckxDWEUrWGhLUFpWMWw2SWJsTUVQbTB3NlpOeVB1NjdwS3BLbXl3NVpKd3Zs?=
 =?utf-8?B?bnhBMDN1SVVVSURMUjZicGE2dzQ1QjdrQWNjbkMwaHhpeUhKUHZWMWxzaER1?=
 =?utf-8?B?OXRzTW1VRWFUTDZoUUI1ZmxKY0N4YmNiYjNjdzh4ak11UmV2RVNkWFlWNWVF?=
 =?utf-8?B?dHg4VFVZSjR6a2o4TElqcXRNMzlYVFFMWVErRXZ0WCt1YTRGNFRvWlhDbmpZ?=
 =?utf-8?B?dzRERFlZenlMUVd0YUN0bFVYN1RkWWNoVEZmUmtSN1M5MHVuT0wrMVhpMjFo?=
 =?utf-8?B?R0gvbURrcElRN1pSWTRxOUppZVRBUzdhYUl2dXltYWNWemNsRWI0VUR6Kzgw?=
 =?utf-8?B?TFVNOSt5UTA3elFCaElNQ1p4ZlpRaDRZcjBOb2NzRi9zYVBiNlYxUmQ1ZzFs?=
 =?utf-8?B?VEsyd1FXN2Z0d2hNMVZBclhyVjNpaEY0ZGFSdDZTSDhxOWNqUFNLV3ZvUlZJ?=
 =?utf-8?B?cGRKMkoxajN2dTNsd3dZYXBCdGJOT3YrajdUbmV5N1hFdFhkWVYzL0QrZFlw?=
 =?utf-8?B?YmhQcktBcEpvWVBCbldwSmM4KzBGTUZkRHJja2Fod1pNQW0zZmR4VnhzNzUv?=
 =?utf-8?B?R3paWndsdkRUd2lyOXp0eEdQdi9lbndGZTN0bmgxMmxjWDJXTmFHNEhvdVo4?=
 =?utf-8?B?MWl0WXFJcC9HZUtPZmFRbUpVMGtha0dxSFlDZ3R6TmV5cWFLQTFXMmZkSWpL?=
 =?utf-8?B?SmxESnRaNVNnMlZNRkVUdVBxRWVFYmZwMllzZkRFRmRjRys0NndwMHF2TllQ?=
 =?utf-8?B?eE9pY2wvOXdQL2hxd0ZzQ1RDQ1ZxSDJhcnNBbFpQZGNpOGtCV1ZUU1N1dGFV?=
 =?utf-8?B?YnBtQW5tRzhjb2QvVUlTTVR2VHpRSnVxTmg4ZUM4T2d3K1BaRlQzZWRYZnJ6?=
 =?utf-8?B?djhJeXdHaVZiMTZMS0hhYmQ0cTJ0R0gvSFBpUzRydTEvWVhEUGtNcWZyNEpR?=
 =?utf-8?B?Z2lYNEtQK3o4NXJ5THdDWll6ZHpFaTFycDNEcW9jRWI0NGh6dWUyRzhraGxN?=
 =?utf-8?B?MklFbGNBWTN4WHdFWXBWVTNudjNuaFB4Q1FibFU3RWFERW1FYnExbXBQSys1?=
 =?utf-8?B?SmEzTVY5SUIvaW5kZllwL043QjZheXRVYVBRU1NwRFVzREZQS0UveE0zMjhO?=
 =?utf-8?B?TzlRN0g4VStIVENReG1lNlBpVk43ZWRCa0ZicUxkd3JtVzduU09DOGw1emFi?=
 =?utf-8?B?V3lOOWRXNkltVWlvd2N0SmEzSWk4cmZ1SDhWUkJkODBQL3k4NGxRNzVuemIx?=
 =?utf-8?B?dGhPcXFoYTZMS3N6R3E2bFU5RXpDeEUrWFQzSFlrZlVDbnZnbWVHMVR1R2Qx?=
 =?utf-8?B?cEZ5ZkI3SVlkRXZhNTd5WnFhZEpJOTRkTWx5eGdaQjJlUTRta1FxTFEzZ1FZ?=
 =?utf-8?B?SzlaTS9VQ0ZKQ3B3QjdxZkZsb2NiU2UveS9PcGo3SXA2MkhnbHhGcUN6ZSta?=
 =?utf-8?B?OWVrbVlrVmY5bkZWUmZhOWxkZmFYQXJBNFVsaFp2OEpNYkJ5dDN2bXBmUDds?=
 =?utf-8?B?ZWV6KzREdC82a1FhWmhkNFZkbFkyWCtmcUl0bXJ0TFh2bHNma01NVDR2OHR6?=
 =?utf-8?B?cTJwdC9yVFVMNC9HMjJTZ2s2alJ0YjhKU3M0a3RLbUVsR3phWHFNeW1qYnFt?=
 =?utf-8?B?by9wUFN3M0pTYVM4MmJjZExhL050MkFEUTI4ZVZ2T3NPdy9QcGRzR1NjZWUr?=
 =?utf-8?B?SllBUTREWDZFbzluSnJhU2w1ZkFuR1k5L3VLK3dOR1pQbFdNcmgvTGxFN3Vl?=
 =?utf-8?B?WGlFM1g2NUVLQUNmSkhlNGl2UW1XZVQwODNxRkY0d2dhajZEUk4zRTJNMTBM?=
 =?utf-8?B?eHgzcUhtZ3Q4a08ybzVzMHFmK2lDdEI4NU11ODBxYXE4WUNZREIybGtuVjZO?=
 =?utf-8?B?bjdSN0FUWjJxZmtXNlZuTTNXSmJ2N3p0b09aMytwL2lZQWxrVzZWMk15cWZn?=
 =?utf-8?Q?ciiwvh6WSPr2QHAPKqrZZo1V5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CC8581D29D1124E979DD0E41C113130@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f53284-48f0-4076-b923-08da614d0863
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2022 01:47:50.7007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pWeaOn15kHdrZDd0e/saTMRm+iaxUDv0xmwc67VHamttqn47PaghImJp8sZy/2oiOzyUSpITahRh+G1YbCvqfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5965
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy84LzIwMjIsIFdlc2xleSBDaGVuZyB3cm90ZToNCj4gU2luY2UgRVAwIHRyYW5zYWN0aW9u
cyBuZWVkIHRvIGJlIGNvbXBsZXRlZCBiZWZvcmUgdGhlIGNvbnRyb2xsZXIgaGFsdA0KPiBzZXF1
ZW5jZSBpcyBmaW5pc2hlZCwgdGhpcyBtYXkgdGFrZSBzb21lIHRpbWUgZGVwZW5kaW5nIG9uIHRo
ZSBob3N0IGFuZCB0aGUNCj4gZW5hYmxlZCBmdW5jdGlvbnMuICBJbmNyZWFzZSB0aGUgY29udHJv
bGxlciBoYWx0IHRpbWVvdXQsIHNvIHRoYXQgd2UgZ2l2ZQ0KPiB0aGUgY29udHJvbGxlciBzdWZm
aWNpZW50IHRpbWUgdG8gaGFuZGxlIEVQMCB0cmFuc2ZlcnMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6
IFdlc2xleSBDaGVuZyA8cXVpY193Y2hlbmdAcXVpY2luYy5jb20+DQo+IC0tLQ0KPiAgIGRyaXZl
cnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCAxICsNCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2
ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IGluZGV4IGZiYTI3OTdhZDlhZS4uYTVjMGUzOWJkMDAy
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZl
cnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gQEAgLTI0ODcsNiArMjQ4Nyw3IEBAIHN0YXRpYyBpbnQg
ZHdjM19nYWRnZXRfcnVuX3N0b3Aoc3RydWN0IGR3YzMgKmR3YywgaW50IGlzX29uLCBpbnQgc3Vz
cGVuZCkNCj4gICAJZG8gew0KPiAgIAkJcmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNf
RFNUUyk7DQo+ICAgCQlyZWcgJj0gRFdDM19EU1RTX0RFVkNUUkxITFQ7DQo+ICsJCW1zbGVlcCgx
KTsNCg0KSSB0aGluayBpdCBtYWtlcyBtb3JlIHNlbnNlIHRvIG1zbGVlcCgpIGZpcnN0IGJlZm9y
ZSByZWFkaW5nIHRoZSByZWdpc3Rlci4NCg0KVGhhbmtzLA0KVGhpbmgNCg0KPiAgIAl9IHdoaWxl
ICgtLXRpbWVvdXQgJiYgISghaXNfb24gXiAhcmVnKSk7DQo+ICAgDQo+ICAgCWlmICghdGltZW91
dCkNCg0K
