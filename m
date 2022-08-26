Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B635A2F7A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344905AbiHZS7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345300AbiHZS6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:58:34 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CFA3D583;
        Fri, 26 Aug 2022 11:58:04 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QG5mJT011669;
        Fri, 26 Aug 2022 11:37:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=wZCAUkmgoeBPSjB9rakFcVRO3f/6QkBKXbO6FglvZrQ=;
 b=rRx7WmxJN4rr7oWO3bfHXu2ZcBb2B8wMIRRZg9V3vlzCTufqJbnwS6UqfRQQF7Vtk087
 IDkoBAeFvh5C/uMTEjSmjgRBQ8DqD6a2tpQQ8D4rlArIYUWwxxXgSFLIxo/KIJq26X7A
 b/zsM8VTCUE6d8RPIJwdHYhywfTz6zIQGyPT89xYUXPSBL+ULXw37FuEsNl+oESwDsfa
 4cs6K7ESyhlLPISXCrSfeLAxx1l3nkQR37NOS0kmnA2WWxfBkizXr+clC+fpJu2fZIin
 46Oh0cRi3kuOi7cLLuLrF6TnadqNmedTDjyCse8NugaCUJQDz+3j9m4V1F6pu1GmyjTC lw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3j5abruf85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 11:37:44 -0700
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 33194C00F3;
        Fri, 26 Aug 2022 18:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1661539063; bh=wZCAUkmgoeBPSjB9rakFcVRO3f/6QkBKXbO6FglvZrQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Hl/FEDqUqwfwA+KGsARJO7XkXOdVGKbHwCK3GbuP890fUIEM/mF6e32WwZsfn62/5
         y8D4r61zV2OR3NtQGNQiLahpiL2qsTiEiuZ+MDMazQv71xJM8PN43xdRyyGyFHgXlr
         FosS7huHG89OXoC0nVqIz0qFjuDdX6kXEsITVJMjjaRVTaJJZ+xlLCfgrkEZCEl3Ch
         v3CD87vlm1ZzObcAl/k4C1UWlYIZrqCcS8wkukzdJarMRnjN12EIKmm7yh3PONRPJJ
         Y7B80l/+XIWFtQcF/Jb4Tm2BaxKd7FNJ3rWZiK0IWIcvraVlwtl8FMOG0WAKoUpd7V
         MePfII3tSlPNQ==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id E11D9A009F;
        Fri, 26 Aug 2022 18:37:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0E0EA800BD;
        Fri, 26 Aug 2022 18:37:39 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="mtl34NqK";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mk6jflZ6NRapUB2jCrq62nqMJslIZYefRFZDMQKjjOtYAaFc5V0O/B4zNQ2EacMbvnfGZ6FZPQ7HfdsMhC9grDsEt8wE7RwAuriMwlg6mUZMOLbxU5Z0AOWXGEqBqoWsyEmlmw9Z59U/gUm9537SdmFJC6ZCKd6svMBLCQYmUl9h26KUV9zUwZLEtBlD15gAViB3yVjevyIT4GcNeyGYoZwZkTC6s3V5q8nd+EquBpB56NGwTzBIlT/pIbNpiXRwPHzm1IsZ5rc2cHGvcLsGfeUfE98P78ZJTjPnYO44e4wYiB2fZq7dqsbZWtH6qM39/RSGL5ImOFaGxQIpFFL28Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZCAUkmgoeBPSjB9rakFcVRO3f/6QkBKXbO6FglvZrQ=;
 b=PEDRt6r7U++Kzjz26eAo6Y6fG+TiFuyH5+ZJc0rcNTx2gF07Pwf4t+bsYmFjNgdiVV4fVurKfTneI5AK6i4Pl30zsy0PJ6IUiv1WerUOS+a96SCkViE/No9CSpOSu0xGjZuGcSjQ2496efBetXzpE63v+21fqZZxSGfVB8bhzRcW8GcB414mhobN4rGlUZ/AuRF+4FagXPGmlutmHQtaMQO7YufKXEWZmaINm05Ubpp6qJopIFqHI0pyDWIdLFs3haHoOX+g6ARKKT6psYTP48/Rp+K165Eu5ki2WAttvjlygskrAIcZwz+RrcKoVO/1X9RjZ7KsR/LaLbUOuZ5t4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZCAUkmgoeBPSjB9rakFcVRO3f/6QkBKXbO6FglvZrQ=;
 b=mtl34NqK/5LhkB1rQqN0CcKLvYRgl2FOxwh6iCAVMtdcN5JlYnGRshnDZIvkMK9AG7VNnUB8eaRqLEja31zE9sE4LhHhIu+fYGFchFluXQHugvCF/cV1UjxKbj3sBQDCuiYo+uDxpfHcsLDThAKq3i2W/uJaJnhRoMKm7pN+pl8=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BY5PR12MB3860.namprd12.prod.outlook.com (2603:10b6:a03:1ac::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Fri, 26 Aug
 2022 18:37:37 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::69ee:633:f068:3ca1]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::69ee:633:f068:3ca1%3]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 18:37:37 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Bogdanov <d.bogdanov@yadro.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
Subject: Re: [PATCH v2 11/25] usb: gadget: f_tcm: Execute command on write
 completion
Thread-Topic: [PATCH v2 11/25] usb: gadget: f_tcm: Execute command on write
 completion
Thread-Index: AQHYmw6u7mupoIR4k0KWMCBmFxWkbK3A/P8AgADCsQA=
Date:   Fri, 26 Aug 2022 18:37:36 +0000
Message-ID: <20220826183732.vxogtdlwqiqbcg2t@synopsys.com>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
 <b030d10834c13aa09bbbba7b33b1957d5ba3664c.1658192351.git.Thinh.Nguyen@synopsys.com>
 <YwhvmpdbG8WXhhZ0@linutronix.de>
In-Reply-To: <YwhvmpdbG8WXhhZ0@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20a6f681-1dd1-40a4-e412-08da87920c82
x-ms-traffictypediagnostic: BY5PR12MB3860:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SOeHWs0R5+Rf8/VDZ6vu0z0ajOOsMgPj4KP23lAC4MWdVhVv/7u3EcwmoU/OVni6UBeBaWB7EjwhXfWZR4WC3VWaAWbEIQjR5DRS+PK1BGrrNenOzVdxiKzUUpZvmLZAwT+FxlqQt3nYZJstNIvprOEPJTIN6hbMxT8bAobWs/RVveLdVfAwLqO2ie5kMnS16UjjbB/OngdM1YAc8abHROyAuezP8qFmymmgikR7KDp0/o9TrtR0s35bBlDanuhVUI8mf9bILvpp6MOYvuvsSwBw+SkuW6pKxpWU3BeUn5zMxXOBGVhBZ9O7imaFKQkWYFhmeYoC3HKnllD/0/ZrTqdGPPAm0MuWbtvT0EscQDREYUn0JMwTTo8WfM0zkWAIktI6dXTC4MOmHUhIKSDiHqcJmdR2ukT7OJ+bTJUlJXBhIpISNkdnr2g1BPkEXhlG3zmgzS4E0anVtLoXze5NWZkQh6TQHqSvj74DB4G3c3uUT7KeqaSz4xdMhQvHcplXT90B+dCfnlrgKYZvAv+xkMobB9sIURsQqQbCarkI7PZQctQ51T+A8DYpnX2iv6hKZ4vmJuaHfd/JIDbwNUpUF4RbyA8dP6LVcPQQMjhQjDmMG+6yQ9r0csumF3eEWjRUUtFlxVx+8H4XSQ2iz6WlbPlD2UsRP2jSwgYRm1TbPZFs0UflLAC/av8vpKwRE8JTSQR37E1KHY4zaJCHIMRth1Ny2n+/ZBr744CUhhM8NbsnotzOPvB6BvLpY038bfBnREU5uu9mb4hLyzDlXSgwQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(396003)(136003)(366004)(346002)(8676002)(5660300002)(66946007)(66556008)(316002)(64756008)(66476007)(66446008)(76116006)(6916009)(122000001)(4326008)(2906002)(6512007)(8936002)(38070700005)(86362001)(36756003)(2616005)(6486002)(53546011)(38100700002)(26005)(41300700001)(186003)(71200400001)(54906003)(83380400001)(1076003)(6506007)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2h1amI2MnVsSGRRSjVLNzk0dkFtSzlGcDQ2b0ZMOHAzWUVaaTJOcS8yTVpF?=
 =?utf-8?B?eUk4Q2lEL21ub29BV3R1R1NSS2hUR3h4U1p6cndxSlBhVXZyZ2dCUUQ3Wm05?=
 =?utf-8?B?dXB1YkVienZPSWtSSTdyQWZLN04veGNqSnpUcHE5aU5tU095aE5OcXFpTy9v?=
 =?utf-8?B?RVphcGFKNnBPeUdjTDdZL01JOFVoRWdLaHV4Q2gycTNOcXorODEzSUJEd3pM?=
 =?utf-8?B?ZDYxeDNDTVhpZ05EcGNkd2lpUzZZRDZJTjNlbENodlhoY1RuTlpDN1VaZmkz?=
 =?utf-8?B?QnVtcGNYRmQyRElQRkpoby9WdXhacDVURHlQZGRKNVd6M3hRNTFOeDZpUElX?=
 =?utf-8?B?a0JSZytuU1dPNEtGZTA4VFVCa29kb3Q5VkFnREp3eGtkYnpKak90Z0QrRlhL?=
 =?utf-8?B?WEc1blhSenEzSlROTDVBYTBkYU1FT3dLYWc1S2N4OTU3WnFCSFdMeFpML2pP?=
 =?utf-8?B?QUNNNktCeC8rTzhLZ3hRWG9xTmJlVjhyY1Q5SWU0RFpNMHlxV0RYN1c3Z3FF?=
 =?utf-8?B?OE5HUFppdWRKYXF4cEd2RHlxNktaUEdxQk1wWlRlR1I3YmRuYXNDZmpDMzJD?=
 =?utf-8?B?eHU5Yld0M0dwUFVMb0grU09iT0xwWjBoMXRxRUVKazNPanNlNHZpVm5pdFI5?=
 =?utf-8?B?WHk2NVk4L2toRG9uYzVxRlRYR1ZwYktvSkg5SzFnU2dkb0pjNU9YeFJvMEdB?=
 =?utf-8?B?WmhXVHpCY0FnSkh1RjMzbkhsd1lvbUE2WXVHUUl5dTdSSjJRUFFZZG9mekpj?=
 =?utf-8?B?U2xVVFVUWk8zYXdUOWJINjBsTzhvbWxvWlZnNGM1VG9NRlkvSzd0OW1peUZx?=
 =?utf-8?B?V01BQ2JFYy9hTjZqZVVVQmd2b0dLYlh2TmdFWjdrWEQxVGN1UmZ1NzdqNitJ?=
 =?utf-8?B?T00zd0duNVdwaWw0cVkzMGdUeWZZWkhMWFVONGRZZHdxVHgvbGc1RXMzTkNR?=
 =?utf-8?B?MFJZd2g5Ti82Mm9QQnYrY0syemh2Zm85RjEwMVVXWTR2amIvNXFkVjFnRDlV?=
 =?utf-8?B?YXFXYSt6ZmRIanF2RTJXdTJpcHdFaWxMWk9MSWtURjQ4K21TcVJ1UHR1VU9R?=
 =?utf-8?B?VjZwdFFIZWs1ek9oWTMxZGVacDJmWEVyZDgwUStUTnJZaDIzbHlycWVvQkgx?=
 =?utf-8?B?eitXWHhBZXpSVnhyYTdiTWhjYUZMZ2svS3NlUGxScSs5N1lSNUI1UE5ScUdt?=
 =?utf-8?B?M3J6SzVncVNuTlB5bzRtdTVReVhMM3dJVGgvamIrTTdzazk1ZjBZNFRWdW0z?=
 =?utf-8?B?MGdHcFp0dysyUitnUlhxbGRXbE54YWowbTdZUitqSmcxNW5Gc0ovd0pjNGd4?=
 =?utf-8?B?eDJwaUlka3o2UXRFZGZSaGlIT3d6ZGxDemcybWNTUFVWajE4SXRYZ0t3VGMr?=
 =?utf-8?B?S2ZCc3VCdEtTcS9RbkZoOUFKT2xZUE9BYkJpdmRJMkhObFlaa3ZDbDJWUGY5?=
 =?utf-8?B?V2t4ZmlndHczWG5JYUpyZFJwNTNUQ1h2MUh1eHlLVlF6RHVjMS9FTmZCbjVs?=
 =?utf-8?B?SXg0Yk1MK1BtcWFNdUxUcGRMbEt4NjlBekc4Ty9qOTJuYnRJVlJQVTl5cExl?=
 =?utf-8?B?UGhFNDY2ZzJFVXhyZ1IwZjUzSEN4ZXJia1FhemlEdWkxSTNsL1NkZm56aGZa?=
 =?utf-8?B?NGtKNEpkWktMdVpBQmVlZCtMdGNQeFpVQTZ6OStWMWZIRG5YNGhKTzZGdDN2?=
 =?utf-8?B?aTN3L2NicTdXR2RkZmNlK3E5Q0dHOGFDWVYyNktCVWpyK0dGRUdJbmxzYitR?=
 =?utf-8?B?M1Z5RDdUT2daVWV0d1I3ZTkxUXllangvUko5TUlsemhCbHFIbDFhNTk2NGEw?=
 =?utf-8?B?Rm5Sa3VMdm9BMHMxOUpNQXlUcVlVZDFuWGlYZ3g5MHN2TFJIVUkrTnByOFVr?=
 =?utf-8?B?Zkp3VjBZRmN3QUFFcTRzNWVRYkpwNmpkQW1wNlYzTU44Qmd5VEEzWkRUdXl2?=
 =?utf-8?B?WG80Z25XK1JWWmJXSkdNYm5uZCsvbHhBb3BROE84K1VJS1lza1ZxYSs5VmZq?=
 =?utf-8?B?NmdkcG0vakE3NFBQME45TmxPRmRiRkJRL0IyM0krVXI4dzloSGtyYjFkeDJp?=
 =?utf-8?B?MnZNNG10VkNGU2FITTg2RDlrZHczdWhLNUFkc0cweC9ORUF4cTlnYXZRYW9I?=
 =?utf-8?Q?OT+yaSb65W/b11CpyU75uW1I4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4213C7288E3D94197B9EC29C2931049@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a6f681-1dd1-40a4-e412-08da87920c82
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 18:37:37.0757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eg2EAXOfQiPxdCKtPCSkcC4QBHb3mr6nAgOATe9Yw3Y2Fo1mHfr1N/nTASV9hBI5uKp9LtzlG/l9Yzy/nT+yqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3860
X-Proofpoint-GUID: MdRQWYYTtPhd8drPI4r8Y2J-Q_-e9t0y
X-Proofpoint-ORIG-GUID: MdRQWYYTtPhd8drPI4r8Y2J-Q_-e9t0y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=963 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208260074
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBBdWcgMjYsIDIwMjIsIFNlYmFzdGlhbiBBbmRyemVqIFNpZXdpb3Igd3JvdGU6DQo+
IE9uIDIwMjItMDctMTggMTg6Mjc6MTIgWy0wNzAwXSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+
IGluZGV4IDZmZWE4MGFmZTJkNy4uZWM4M2YyZjlhODU4IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX3RjbS5jDQo+ID4gKysrIGIvZHJpdmVycy91c2IvZ2Fk
Z2V0L2Z1bmN0aW9uL2ZfdGNtLmMNCj4gPiBAQCAtOTU1LDcgKzk0OSw3IEBAIHN0YXRpYyB2b2lk
IHVzYmdfZGF0YV93cml0ZV9jbXBsKHN0cnVjdCB1c2JfZXAgKmVwLCBzdHJ1Y3QgdXNiX3JlcXVl
c3QgKnJlcSkNCj4gPiAgCQkJCXNlX2NtZC0+ZGF0YV9sZW5ndGgpOw0KPiA+ICAJfQ0KPiA+ICAN
Cj4gPiAtCWNvbXBsZXRlKCZjbWQtPndyaXRlX2NvbXBsZXRlKTsNCj4gPiArCXRhcmdldF9leGVj
dXRlX2NtZChzZV9jbWQpOw0KPiANCj4gdXNiZ19kYXRhX3dyaXRlX2NtcGwoKSBpcyBpbnZva2Vk
IGZyb20gaW50ZXJydXB0IHNlcnZpY2Ugcm91dGluZyB3aGljaA0KPiBtYXkgcnVuIHdpdGggZGlz
YWJsZWQgaW50ZXJydXB0cy4gRnJvbSBsb29raW5nIGF0IHRhcmdldF9leGVjdXRlX2NtZCgpOg0K
DQpJdCB3aWxsIGFsd2F5cyBiZSBjYWxsZWQgd2l0aCBpbnRlcnJ1cHRzIGRpc2FibGVkIGFzIGRv
Y3VtZW50ZWQgaW4NCnVzYl9yZXF1ZXN0IEFQSS4NCg0KPiB8IHZvaWQgdGFyZ2V0X2V4ZWN1dGVf
Y21kKHN0cnVjdCBzZV9jbWQgKmNtZCkNCj4gfCB7DQo+IOKApg0KPiB8ICAgICAgICAgc3Bpbl9s
b2NrX2lycSgmY21kLT50X3N0YXRlX2xvY2spOw0KPiDigKYNCj4gfCAgICAgICAgIHNwaW5fdW5s
b2NrX2lycSgmY21kLT50X3N0YXRlX2xvY2spOw0KPiDigKYNCj4gfCB9DQo+IA0KPiB3aGljaCBt
ZWFucyBpbnRlcnJ1cHRzIHdpbGwgcmVtYWluIG9wZW4gYWZ0ZXIgbGVhdmluZw0KPiB0YXJnZXRf
ZXhlY3V0ZV9jbWQoKS4gTm93LCB3aHkgZGlkbid0IHRoZSBXQVJOX09OQ0UoKSBpbg0KPiBfX2hh
bmRsZV9pcnFfZXZlbnRfcGVyY3B1KCkgdHJpZ2dlcj8gQW0gSSBtaXNzaW5nIHNvbWV0aGluZz8N
Cj4gDQo+ID4gIAlyZXR1cm47DQo+IA0KDQpTaW5jZSB0YXJnZXRfZXhlY3V0ZV9jbWQoKSBpcyBj
YWxsZWQgaW4gdXNiZ19kYXRhX3dyaXRlX2NtcGwoKSwNCmludGVycnVwdHMgYXJlIHN0aWxsIGRp
c2FibGVkLg0KDQpUaGFua3MsDQpUaGluaA==
