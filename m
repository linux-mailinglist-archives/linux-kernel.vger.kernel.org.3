Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368C659CDA9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 03:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238668AbiHWBOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 21:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237907AbiHWBOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 21:14:45 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5529354656;
        Mon, 22 Aug 2022 18:14:44 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27N0QgKc001557;
        Mon, 22 Aug 2022 18:14:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=4nviezopvvuD7KF89/tgzEsZoWzgXjvDHglKe06EXEA=;
 b=YnVelL2ZOtjor0u+3AzO8bl4pBYLqFEjtpdrJrWpVHdML1IIVugONJYq0X7IbvGoxM9S
 W59jFkcPLsfPdGRILDPmu4eFpaso3F8c92IqRDwOGSEa3t5K3f5TFgDtvkZFWlbpwfPw
 uVtOT3/9tLUU+Q8IFTPD/bjZyQACyMFctULmYMrJT5rW7jEW3EAS1b4HZSXmMbAqhH7i
 GyuFz1xJ3O8gWFamdK99CC5KwHgP8yFm6dSgPxk/Z1/uHtruwFPH+gTZdQbLS6fQmKl1
 60EsnjY3LWI2Kkurr8GosI46SURhVOCaC5YlYybviWvF3+iE1GSA8mmcmlv5eaG1zKtR Hw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3j2x8e29ek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 18:14:37 -0700
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6E50340089;
        Tue, 23 Aug 2022 01:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1661217276; bh=4nviezopvvuD7KF89/tgzEsZoWzgXjvDHglKe06EXEA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=H0TQZ6uGFSleCRV+AcI57sv3YkWpwVdWVkI3uIpb6Mum3O2lwJJa+E5XT8sPH/Ts5
         kClM/bejBwReHfaZ5LvoGXfNAfJqBWftfKg+6hA0fJAS/v1XFLKmWTm7uLHzYi8ITy
         soIv9OLz+aNeRFPn+etuVgxf9SY7+g6INUWU8RfAcAExMM3xRog2C8FlVzp8getQlA
         F27QRpbC22eI4phA2N8avisvFYKekjLUfBqcZbjgHhyGNbrxSdxWBDUFQJt84ZAiB5
         bEB1+XEONOCZqbo1p8Bek4b4XqtwIrDMrs0l+k9DmoaZjxbd2HBOpRGhmrfzu968iB
         GQm6CrsZhrbUw==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id E667CA03C1;
        Tue, 23 Aug 2022 01:14:35 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 62163400C1;
        Tue, 23 Aug 2022 01:14:35 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="qWJ7MZLw";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLNUxTYvjDBNRKIL4yLdjB45bSAEGfK4wGhOPKl8Gczqgnil7xed4eY3Wzv/pk4M8mWotFRu8q63Qg4vNZOo3i3FUvs3CHr9Eb3JmjO4mhQTpzgrHsSr5FDXxObRMgwx1RkOWQ7ZQcfM2+ciWN94FBOLb/C0xNg/AvmcgVbb6h1AOCIW9o27Hgwi3teNCmAaakVHRKPWDWxOzwsZiQAd4EG7wgMYGASUMnqFd4lzMfJ8oUG8oQTRCW/c8ijIzkDm81bjmPYAmSo7m5L/UBKbzq/fo54xQlPAKmgGBMWiXRkgf/HUiARR46dDyZYV+NxXPWE4Ms3C4xQ4vE77AWWaQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nviezopvvuD7KF89/tgzEsZoWzgXjvDHglKe06EXEA=;
 b=EJiRT9tIBhTvyzMe0R2+NJXvjua3RFIGnTE78WzeHCMkyfCrZVLdE6eAvua8sNdX+gTsywtHIie7LwfhsHW5BBDAmjtn8DvvTZloQ/jeKxIm7DCVNU4PdFVgZ5eCoTRBHqzAUL3eVJGSVmBbtKFV8SGP173DQouoH42mhwA/hLKZZcUxDeoSfPdZDU8CPRAbIBnX5pUkF3kxBGuvfBuyYl+k1I2UyNfdgXY/37/1NZzEFv1/M4SXywBdYLMTYjYXUEupUNOt8GimBsWtEuE2rUz/vLFK8ad2KHh6l9PYD5DYGHQ4xX70834I4bkWuzHUx84RjNeRIwvu3i25H+XtZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nviezopvvuD7KF89/tgzEsZoWzgXjvDHglKe06EXEA=;
 b=qWJ7MZLwoPKSPOjmboSHJy/96oC3ww3jzqcm9ukqC0qHY1g/E3lIDDAuSv6cI/+5xoBhbvg8iihlM7UDuCax/hQzTsWnWwON3EswisAkmw5PWZZb6kN9qzCcmqRXdrz0FAWflwGYO2R8eTgtugJVDNugAi/oC3yMhTbTfObUovg=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BN8PR12MB3298.namprd12.prod.outlook.com (2603:10b6:408:69::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Tue, 23 Aug
 2022 01:14:29 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::69ee:633:f068:3ca1]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::69ee:633:f068:3ca1%3]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 01:14:29 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v4 6/9] usb: dwc3: Remove DWC3 locking during gadget
 suspend/resume
Thread-Topic: [PATCH v4 6/9] usb: dwc3: Remove DWC3 locking during gadget
 suspend/resume
Thread-Index: AQHYsrli8a/BnnP54k+oMTpzTOi/JK27td+A
Date:   Tue, 23 Aug 2022 01:14:29 +0000
Message-ID: <20220823011415.6df3tbdcaoof3rbz@synopsys.com>
References: <20220817182359.13550-1-quic_wcheng@quicinc.com>
 <20220817182359.13550-7-quic_wcheng@quicinc.com>
In-Reply-To: <20220817182359.13550-7-quic_wcheng@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6916776b-99a2-4217-c448-08da84a4d3fa
x-ms-traffictypediagnostic: BN8PR12MB3298:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: baR2zZ6QBdQSurD3uWrbUeE9mgbCOhTqPus7c8yOUxs5MfW2LihmDJv9cKfA5/L5AETLst7vJYoZCtGPz4nbZ60ThpOfFqksivZsUqm0jAFpP1n5rpygb+meRtJ9H3m+e54FKZvWEslXFtDbYNtbCppXIQ5orKDGQR6yOPdnPor0++YdTUdD9+VDzhCR8T+8aArOfMZI6RAxHJ81mS+lAIVipRPlqY+JiTo5hvhA0NbijSFW19EDXpyY7Wt05Z5eQ1M0ZHGDNhoMfje1a4ZrpU4AJzXi2ryG1kxKNupPaB8RE11HJagBf2eGdu8izhvqN81X/Z/Jybppu09vfG8XP+IsgsE4xa9KZjSdGwANoO/e0WdDDfi6easpOXko3eZ85L/G1tkXHFKLeRc1DsFKHns4VanAS8hPlRLAMj0A4h5Qh6kiSBR4CRPy2HQBg6KQPGMLUD+FRfWDrOUcI+VNRrzRa8oli9uepWYJs+a6q4ygwPBwi75TIch7PjKozHROPSwYLUoRo2pMF2/h4qtK9OdbRHIuM87sZt5v1Q8zDAZAo4rbJt3Py0NydVP/WWmeqx+MfTmTrsI0dUji0/LlyYq9T+VwX0CtpGr5mcFP/z8S83+X740dLdwL53YWgiOu/bOYz+/2f+n/XsSKgHseFm+HsRiriSOsPM198+JZtXBYdS/wCH+skAgjNnFnnGGyaw8t/PrTeUU3qwhJzkSX1xXDIw8PSQ7ea4jGtFqdAjcsv9oNHvRGZD8kAUNYm05izQeyoKeKrc1ewlkqT2ReEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(366004)(396003)(346002)(376002)(66446008)(71200400001)(64756008)(8676002)(6506007)(6512007)(76116006)(66946007)(66556008)(83380400001)(26005)(66476007)(1076003)(478600001)(2616005)(6486002)(86362001)(38100700002)(38070700005)(36756003)(4326008)(122000001)(8936002)(5660300002)(2906002)(54906003)(6916009)(41300700001)(316002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGROV0hkQ2NZdDJGb3BuVnUzWmEweXo3YzZNaFBXeGtiRXlZNzZtVnpiRExi?=
 =?utf-8?B?ZVVKakdiL29XT0JnMzNaUDgwM1dkL0hUcHg5T045bUcvV2hicC80Y3Q3NUc3?=
 =?utf-8?B?WGhPVkdTRDdDNDVtaUVMTDN4ZU9raVN4NzJpN0s1LzkrUE0va0toQmh4Q3B4?=
 =?utf-8?B?TW91OFhzNmEzZy9LUzFjN0pEcENnMkp5T2U2cHpFZXFPOER0S3VxaWptN3Rt?=
 =?utf-8?B?am80eXVkcGE0U1R2QXFTZ3ZwYTJNL1FzRTZ1ZWJuVnlYb3RHQUNqcXhUYjVY?=
 =?utf-8?B?NkZFQ0s2NlhpRUZDL0RjZnVCTHVMUTFMaFZXNnAxa3gyWDZ1SXVRb1dMVGgw?=
 =?utf-8?B?SnVuTS9BQVFFcSt4TUFveEUwbEpnU09TRzdwbEI4NzBnR20wZEpzc2dOck95?=
 =?utf-8?B?VEZpZTNYSWxWS21FZWNGV2NvK1RxS3FWU21IRWZxdlEzSDJuNC9TalFOTzV6?=
 =?utf-8?B?Q1kvTjlsYmc2dW9qaHIxSGx5VUw4eVF6OUI0bzJ6VnhhcGNxQnpydVIyaUI3?=
 =?utf-8?B?UnVYNTVqMTh6NGZKTmhPVXd1SXJrSVc1US9pVDhGSzZFNkdRSEFSVUpaUkFn?=
 =?utf-8?B?bnQ3dVdKN0NYOHh1TWxkbjVGV1ByRXJuVy92Wnp6WEtWUmZ1N1lORkRkZTFX?=
 =?utf-8?B?b21BN3p3NktSSGIyL3VURVlZS1NhdWdSL0sxVTdtYzA1NEd6UXZRQ2Rhei85?=
 =?utf-8?B?WUNJR1ZFZUxMZWpCR0EwSldxd1d2ajZHQkpRYnhpRWh4bDdURnJOL2FXditj?=
 =?utf-8?B?STBPMmdpQlVHMXhtUTVVSjVOczJNNUtXQkNGYTcwRVN0RXhuMXhubHBMQU5G?=
 =?utf-8?B?WVVZaHVXZ0ZCY1lDbDFFa2xsTWR1VFZ0emNqVWF0bWtpQUQxeGtuaVdhd3U1?=
 =?utf-8?B?MEovYkE5QTZTQnFwZkxnZnE3dkJtOEVYTHRweTBwd3A2WUQ0ZWRmcFhLN29E?=
 =?utf-8?B?aFJMWGFMVEVmR0dtMFpoWkJQdGpmNXRxdk1DaDNPdnV2MWs1TDlTY3krR0NY?=
 =?utf-8?B?VDJxSjZTTVZaUmd0NW12Y0QzNGlHTjArTE5BSHJmTUtEbVU0blh5MnFwNElP?=
 =?utf-8?B?V2ZPUDRsQUI0Yyt3ZE4wbFVkRGtES0hRbUN0algxMmJ2UzczbWNnOUhLY21Y?=
 =?utf-8?B?OVRmNWFaVmFFenczYWpQRzRMRGtTWFlKUlBIN214bDQ0OFh2MlZOby8vTVF4?=
 =?utf-8?B?TmpFQ2pOMGpNeERKSWFwWFh0a0VKbEJhZm93Yjg5UWpKUTFuK3ZUNURkQzRr?=
 =?utf-8?B?QmR6NXdqSXJzSjNOOVg5NkJSOG1rSUJFaTFJekdTU2Nsa25FbmMrd0ErV0F6?=
 =?utf-8?B?MFdhRGlNaFJqbHhsRHFwOVh4ZW1KSDdZayt6RXRERnRMUTVtVXgzT1RoWlht?=
 =?utf-8?B?bEp4d3JUYk5jZ2JBLzJpV0NVaHlUT0hNS3M0eXFmOGcxRzdWbHc3SUNIbHpH?=
 =?utf-8?B?K3pLRlZlUFNoZXZLZDR0ZHJzUnpxdmluUld0UVVwM29nOThOUVpjSHlNSVRr?=
 =?utf-8?B?RTlEeTBmT0ZnWEZkL01XMTM5WGsya2dNcHhPTmhVeGFPa3kxR1dtUTBXSUgx?=
 =?utf-8?B?cFkvQVlpcC85aXdsRzBXUTNTVU9BdE53L3BiTXZiZzYzNUF3aUpjRDM3bnp6?=
 =?utf-8?B?Z0VtbTdRYVhPTFY4MkVpbFArT3VDdzFTUm5BTEhYdnE2NzJvVmVwajQxd0wy?=
 =?utf-8?B?RjVKeElBdmdEVWRzZVFzQm8xRUJnNnF6R0c4Z3JvQ0g2RE8vWXN6NU9MZTFU?=
 =?utf-8?B?cVFkc0F0RHdCOThOUGwyUXhqZXAzNkpJNzB6bllSUytzcHdLYnBIN2JKWHJ2?=
 =?utf-8?B?S01zcTl5NURMcTF1enlXaHUzaW5aenAwZWlJVnp1NHFPRkJsZkFyMzNvTmVC?=
 =?utf-8?B?SEluNW1mdnNpb09lZENaWG5JdHJONHMwdUp2Q1VSZ3lsNHVtSVUrOXYvMjBz?=
 =?utf-8?B?RS9JNjQ4MlByYWJ5MHpLdThpTC9LWkUydFJvRjh3bWhRMmVweXhwZUJlQ0hB?=
 =?utf-8?B?VXVKREZoazVwNENuVHVnR0grU2lMa01yQkFUQ2lhVms3ZXpqQmZPNHVWNXZp?=
 =?utf-8?B?U3kwSytyUHRaV3I1R0pEYzhMdFRxYkkxSDZnL0dzOU1Mbk9vRmpzN2xLaW10?=
 =?utf-8?B?Sy9oK1RXdmpQSnNsNXI1V1FBV0M1SFFSTy9nU3YxbnVhMzVXbWlBVnhKWFF2?=
 =?utf-8?B?VGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D666D9B01B507B48AF3B26E392CB015E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6916776b-99a2-4217-c448-08da84a4d3fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 01:14:29.1807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XBKkyD7JKEX9R5LlOgPd4AoyMKd+ZlxNy+t69uohyOvLSv9BfUAPaM20jk+zQJyUGNc+Eeethd+9qt3nryUEug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3298
X-Proofpoint-GUID: 8ClpNd59aTmQmrRcs7BCVi_W3vXOjpn6
X-Proofpoint-ORIG-GUID: 8ClpNd59aTmQmrRcs7BCVi_W3vXOjpn6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_16,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 spamscore=0 mlxlogscore=853 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208230003
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBBdWcgMTcsIDIwMjIgYXQgMTE6MjM6NTZBTSAtMDcwMCwgV2VzbGV5IENoZW5nIHdy
b3RlOg0KPiBSZW1vdmUgdGhlIG5lZWQgZm9yIG1ha2luZyBkd2MzX2dhZGdldF9zdXNwZW5kKCkg
YW5kIGR3YzNfZ2FkZ2V0X3Jlc3VtZSgpDQo+IHRvIGJlIGNhbGxlZCBpbiBhIHNwaW5sb2NrLCBh
cyBkd2MzX2dhZGdldF9ydW5fc3RvcCgpIGNvdWxkIHBvdGVudGlhbGx5DQo+IHRha2Ugc29tZSB0
aW1lIHRvIGNvbXBsZXRlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogV2VzbGV5IENoZW5nIDxxdWlj
X3djaGVuZ0BxdWljaW5jLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyAg
IHwgNCAtLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIHwgNSArKysrKw0KPiAgMiBm
aWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUu
Yw0KPiBpbmRleCBjNWMyMzhhYjMwODMuLjIzZTEyM2ExYWI1ZiAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy91c2IvZHdjMy9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4g
QEAgLTE5NzYsOSArMTk3Niw3IEBAIHN0YXRpYyBpbnQgZHdjM19zdXNwZW5kX2NvbW1vbihzdHJ1
Y3QgZHdjMyAqZHdjLCBwbV9tZXNzYWdlX3QgbXNnKQ0KPiAgCWNhc2UgRFdDM19HQ1RMX1BSVENB
UF9ERVZJQ0U6DQo+ICAJCWlmIChwbV9ydW50aW1lX3N1c3BlbmRlZChkd2MtPmRldikpDQo+ICAJ
CQlicmVhazsNCj4gLQkJc3Bpbl9sb2NrX2lycXNhdmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiAg
CQlkd2MzX2dhZGdldF9zdXNwZW5kKGR3Yyk7DQo+IC0JCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUo
JmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiAgCQlzeW5jaHJvbml6ZV9pcnEoZHdjLT5pcnFfZ2FkZ2V0
KTsNCj4gIAkJZHdjM19jb3JlX2V4aXQoZHdjKTsNCj4gIAkJYnJlYWs7DQo+IEBAIC0yMDM5LDkg
KzIwMzcsNyBAQCBzdGF0aWMgaW50IGR3YzNfcmVzdW1lX2NvbW1vbihzdHJ1Y3QgZHdjMyAqZHdj
LCBwbV9tZXNzYWdlX3QgbXNnKQ0KPiAgCQkJcmV0dXJuIHJldDsNCj4gIA0KPiAgCQlkd2MzX3Nl
dF9wcnRjYXAoZHdjLCBEV0MzX0dDVExfUFJUQ0FQX0RFVklDRSk7DQo+IC0JCXNwaW5fbG9ja19p
cnFzYXZlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gIAkJZHdjM19nYWRnZXRfcmVzdW1lKGR3Yyk7
DQo+IC0JCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiAgCQli
cmVhazsNCj4gIAljYXNlIERXQzNfR0NUTF9QUlRDQVBfSE9TVDoNCj4gIAkJaWYgKCFQTVNHX0lT
X0FVVE8obXNnKSAmJiAhZGV2aWNlX2Nhbl93YWtldXAoZHdjLT5kZXYpKSB7DQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQu
Yw0KPiBpbmRleCA3YjY2YTU0MjUwYTAuLjU3ZDgzYjNiNDk2NyAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5j
DQo+IEBAIC00NTIwLDEyICs0NTIwLDE3IEBAIHZvaWQgZHdjM19nYWRnZXRfZXhpdChzdHJ1Y3Qg
ZHdjMyAqZHdjKQ0KPiAgDQo+ICBpbnQgZHdjM19nYWRnZXRfc3VzcGVuZChzdHJ1Y3QgZHdjMyAq
ZHdjKQ0KPiAgew0KPiArCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ICsNCj4gIAlpZiAoIWR3Yy0+
Z2FkZ2V0X2RyaXZlcikNCj4gIAkJcmV0dXJuIDA7DQo+ICANCj4gIAlkd2MzX2dhZGdldF9ydW5f
c3RvcChkd2MsIGZhbHNlLCBmYWxzZSk7DQo+ICsNCj4gKwlzcGluX2xvY2tfaXJxc2F2ZSgmZHdj
LT5sb2NrLCBmbGFncyk7DQo+ICAJZHdjM19kaXNjb25uZWN0X2dhZGdldChkd2MpOw0KPiAgCV9f
ZHdjM19nYWRnZXRfc3RvcChkd2MpOw0KPiArCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmR3Yy0+
bG9jaywgZmxhZ3MpOw0KPiAgDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQoNClJldmlld2VkLWJ5OiBU
aGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQoNClRoYW5rcywNClRoaW5o
