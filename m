Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6444A596654
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 02:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237982AbiHQAjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 20:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbiHQAjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 20:39:52 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29AE85AA1;
        Tue, 16 Aug 2022 17:39:50 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27GINMU4024649;
        Tue, 16 Aug 2022 17:39:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=Wze5JVMjG06kLtaWjfA5N4SbiyMV13F8GHFXT8YP2X8=;
 b=n6EWtTKkdulI50GO1nT4VUoLJvuddTX9Dtb+GiklyAvGq59SfCryLOhtrirjnGVTocUb
 Q8fYmPpI2Z/9vVA0OoKxeFgIBLaYBgiphTRC9/lV1F2qGuCDgddyg7l+scPZZGXumtvb
 5UdVJ7gCvFSkKs2dqM0VnwlQj5z0XVNJ7qj091wlYqsZ939YsfGNdx2Fg8jq8i1VrTSL
 U2phigQcKF+pAV0QQcCAwbD0HDKv4Dqceg0W+wZBfNqZZmFN01QNZp3Y4WM4gro0LWXU
 Ixnji2OxyftVEyXJg5ZzVKaykemFvjjcG3Id+Y8rUWECn31/5mkvWbCfCBwLQGxxrUkl DA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3hxb75fm7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 17:39:38 -0700
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1A9C1C00F4;
        Wed, 17 Aug 2022 00:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1660696778; bh=Wze5JVMjG06kLtaWjfA5N4SbiyMV13F8GHFXT8YP2X8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=eGMnwr0MUzWzsf+g6+rdaTUb4vzJ32QRjT8OCATkWVFDnNwkCoXmM+Smb53KCy3KK
         AQwSKWTVlRRVlXe6B18SCxw+72K4vSSQ5aMjQ70jeXmt9mVzoAtGyJn9yipsbilK9a
         oeQgENSxujWPLBofcuYC6x6J5UQS3wXkdwmpLlKXsYO92K9IcKKgA70R8h+IXnRB0S
         IOEOqC8B/t3NjZuAUzJFffAB+vQGWXqX62O7j1bIyaM0CYCS0QkvdGhQL6BmBrPPgK
         7Fsccv1T2BTxtr3lKTthJBSIABLx1xhlchQvrQCyr1x5JFQl2GebiwcSSfWFd3XbD6
         /nSZamQDISoOg==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id D372DA05BB;
        Wed, 17 Aug 2022 00:39:37 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id A69A88010C;
        Wed, 17 Aug 2022 00:39:36 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="dIQ/5STY";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OffK4LhetnMBTLO4vPiG7a9o5zCRFk1nuWQick/xmVxYPdntkBQ/vFTJiTU1MpKA0ZoExt32Yn7FfShjltAU1nfStm2TBvC3gcBny+rIJ/x2Z0DsXdHuAEsjVDjzGR6qLk20Dy3cPaFrKQp5RnHsYY/ToPZciA19LUomiqwbKlZrN3Q3pvvoMB2YrSQTUej1u3q6TkA94vQYKNgPwilPrGGbt2WhoabfsPX8nanvz5/rYJr+fhO7l+Px4olw4Fkz3wJrNuLHrkcNx+bao4+/YrrDjDIyRzFDuZHUj613B6Pj9bGaThQHpIyYLcKMKm0ZGeUnuaKdG3faVvOk21Sauw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wze5JVMjG06kLtaWjfA5N4SbiyMV13F8GHFXT8YP2X8=;
 b=Khrl0SkkNzWRqB/2XS0M4+YH0UcQOby9kvH21XrJfLPWFOD/LFadKNJ40MDf+Ggk84tSENUluBsiMpj1xHZwTX6yIdz2WVJlSUNVYb0Tsn6hLHCQXjMANfWpoFIZZoQ4ElgFiAPQv7XLXdMSXW86OFlxj5tTNWx82OmS5BInWrLSzKbFb+z4VmI/f/sRaghkwz9RTjh6KSlqtQuGv6BLSi+eOzPD+Mchu3gRKquby8dm9RtuRIHFa70rtoTb/RnTCr3sYRHD1Ue2vswQ6M3AOHoN4WUaeByVJn6ZnIVjN2YQiiWWcCkq0G3VEdd9c65Zkz7F675S4+tF77s42lp8EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wze5JVMjG06kLtaWjfA5N4SbiyMV13F8GHFXT8YP2X8=;
 b=dIQ/5STYJA5WWt1zw0aG0tfs6z93d4tmzirgHhTNWrXMShnFQuUH3kL7OykQ2jGls1/vXY0ehh7qWxPdPLSvKFH674o2wdOlgFuytlPjPoOlbwf1sKCJ4IjBv2hkDacW5ZmzQtTjfoIccsZvpJDzhnA2U8C2S+0n5PfDFGnqSDk=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM6PR12MB3098.namprd12.prod.outlook.com (2603:10b6:5:11c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Wed, 17 Aug
 2022 00:39:31 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c%7]) with mapi id 15.20.5525.011; Wed, 17 Aug 2022
 00:39:31 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH v3 0/8] Fix controller halt and endxfer timeout issues
Thread-Topic: [PATCH v3 0/8] Fix controller halt and endxfer timeout issues
Thread-Index: AQHYsO51Qu7iFMAkBE63wJDBucPqCq2yQcIA
Date:   Wed, 17 Aug 2022 00:39:31 +0000
Message-ID: <9b1bf7fd-07d9-035d-bf40-12808bf7464c@synopsys.com>
References: <20220815213134.23783-1-quic_wcheng@quicinc.com>
In-Reply-To: <20220815213134.23783-1-quic_wcheng@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59d3c0fa-d004-4345-9e93-08da7fe8f2ee
x-ms-traffictypediagnostic: DM6PR12MB3098:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O28FF5QSRzDptWpV+siugQFvx6ZZ7mW0Fxsm4QvZVZyXai8SiT8V7CP4m2jHxDiSbkjURKE/RPF5djzkrn+xyP0sf6bexZkH+1XBeRZw/Dhz6yWsjjGPSMDb9CZ3CDOvrGOe61e8zRv7HqsectR/hBBLcBQc1kjJg7D+Nxyr7VLMh7kcKjQBHXgEaTlwMr12zcfo79CEM5ForhgYYe6PkSXm7b6ZJZDIHnm8jUdhEY5hlazyn+29qqIEDYWq55TyQfgjFJmeOfoItipPEtOogQLDISINOn8Z3lobaPYgJjbqxAB0vpSCx0hX14huq6b2jZyKmumy15oyQyz+CJSheRvM7KDx5WVnmJQiSFTIjLoYS7Nfri0/1Vl5Eh8WjMByDv2cldbx2FkYaus+D43MvESDT3tWyGMKLMZiEyTyMIot/gStfBz4yUeW47uJs8f6W3hKblqjfRgIUUrqb7oxJjHHBTvmP88GQ94JA8HtFua1nSKzr7NtT52k5IvzV9xJQyLqEOJeybGQfV1L7oNYU4VnWzkvFYZXt32jI4CZ+1ZB+UhJ1c+nb7PnKqBlo6XnXZ+WyPz/4Y8MMx9hxNknJXjf4yFIR64RUXbRcqj3+NV58Pb/VSooexIYeh8FeVBYdAZx6Ksz02L4C0p8TQ5o7n2G6R7qUWtyCLnjz116cFWSIT5mKPcKQEyWWyOlg1YM1SzTIecvmXfrMjl5XkHdVLSrLe21B6/BtaEI0vzjqOKUsZGGP75Mx616CzS0ncjwRuPH5lNjTrdAW2jqpY3PPm75elfqFcgHnAQZc9lN5kbOAcnmPhdHIn+LGLEXXi+WqzN2oV3l15mVzaDopqVLpdy36SQ3bPeEjflhtrRO//R3UNZxbJmGFmGm5ppMqQ1u
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(136003)(39860400002)(376002)(396003)(31686004)(122000001)(38070700005)(2906002)(86362001)(6506007)(31696002)(38100700002)(71200400001)(316002)(54906003)(110136005)(36756003)(5660300002)(478600001)(8676002)(4326008)(8936002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(2616005)(41300700001)(6486002)(186003)(107886003)(83380400001)(6512007)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2xxb3hyQ0xIbEt3TjRNUzFXdHhabCtNMy96aTlYcU5XR3FjalhLSEUydmR2?=
 =?utf-8?B?MUMrMjhjdUpBRGVvc1lwTEtnS0hSbTFweVlwTGpXdWE0TThZalBZSHU2UTVm?=
 =?utf-8?B?WlA0Vjk0Wmg1WlNucU8vb2NUSk04WEt1NzJZdWFWZitlQ2tVb1hHVm54c0d0?=
 =?utf-8?B?cmdwcUF6ckpTOTRqUUZ2eHMrUFNRMTJJYU9oQVRZZ0hjTG5mdkIwRG9GczN2?=
 =?utf-8?B?YTliamk1V0haNzZTaTRLSEQ3cmVlcmtpcUF1OWdqOTZPaHliU1ZXaTNESVN6?=
 =?utf-8?B?WHptZDJ1c0F0SzNURktBVU1rVmsrVjBqOStpOG5JSkVOUWw1SnZLTkNNSkRi?=
 =?utf-8?B?emtUTHlRV0lOU3UxcGRDbDU4SzNsL2NlV0RSQk9kQlhvN2F1elBaWHgwV2Jh?=
 =?utf-8?B?Z2M5VlZxQ25zd3R1MVl3dWlldVBDVGdQN1RlOVBqd1FxRkRLUkFoZDcrd2RP?=
 =?utf-8?B?MGhMeDhQNXp2TFF4NU4wS1pqdlphd3Z4NXNqVGhLNnIvSzQzMU9jZUpibzBi?=
 =?utf-8?B?cExMcHV5MUNvTHBOeUo4elkrUW1HYkowZmVBVGRBM09oZ3pMS1N5clZyYVhx?=
 =?utf-8?B?TEJqQ1RFcmU5bmE4TUJWdUkwSkxqVHJBcG1pT2xpbVNhS0dlSUdIVTFYa00z?=
 =?utf-8?B?N2c0NG9nSHRxVVFnNW1Zajg3bmZBclpoMmI0b2tYZkhWM2xidUE2Q2JWYTZn?=
 =?utf-8?B?RGdjT2NDWTBzWTc5dFVHdE1HRU52SnFqeGlEMENVaWNDbHVyRHVudklSRHg1?=
 =?utf-8?B?T3JqQnVKVDVSRWRRTTBacXE1eE45MXZnaFRYTzhpbXdGaW9qWnlwampQZGhD?=
 =?utf-8?B?ZGVtdHp3Tkt1dnBaNlR1M012SDl3SlAraXNmU3ltSVBaZWlBa1dadG4vNzhV?=
 =?utf-8?B?TXRvRlMxdG9VcERaazFHQUp1T0g4L0toT2dGM0ZYa20zb1o5NVhIVkFwN1J5?=
 =?utf-8?B?ajZ2Q1IxbExBTE5OQ1NyaG5FcHltZVd3R0orVWd1R28vTmpWVmdmdTFqKzNp?=
 =?utf-8?B?eUVRaWVFWG9icndpWGVkQzNuSDcxU0dxZC9tb1YvNDRsWmJEQjc4dWRMVmJ3?=
 =?utf-8?B?ekpMKzdabUhseXBZZlluc09tSjRVS1pIK3lGcGZqcVA1UDE1N3V4UC82U3Zr?=
 =?utf-8?B?bDNBbzhjSFVtWVAxMnBqUzJLeEN5OG5SUENLM0F1UFBtZUx4UGFKZnhuQmxs?=
 =?utf-8?B?cCtZL2pwVGkzeVlod3FjaHZXTGV1YkNXbkNDaVhDWVhSWWdwYkZPSjgwTTBj?=
 =?utf-8?B?OGdyQ0l4UWZ6eFZsSERVWTI3UWVMdk9TV1BFbm42alVFbkQvWENEbkNHWHly?=
 =?utf-8?B?TWZHRmpjdjBwTm03NmZ4bUtlTll0bHJXS1JaTjJCc2VHVHhkdFY2endvdS9G?=
 =?utf-8?B?endPUGRJTGU2TnhzNDBrdUN5Q3hFemdBT2FhaHhCRnJ5SGdrNTJia2lERk1W?=
 =?utf-8?B?V0Y3ZVFaWG94NTl3RHJkeFlOTkZnZGFzdVNZekxmWDM3Z24zc2t6NEFjOVRV?=
 =?utf-8?B?UUVpVFJPckNpd0lMTXh3YTZUa2pOckNDNDJlVVFCaDFVWEhHbHZTektsNVht?=
 =?utf-8?B?M1FocjczM1VIQytEcFlUUkJ0RE5pU25mRlBxWEhPVG1PYmd3Y1psTWdHb2gx?=
 =?utf-8?B?MnF2L2JEUlJTcjFvaDRNTEp2OFNkeU5YTm5CNTJsVndWbHIwSUV4YXljdVJB?=
 =?utf-8?B?c3VyUEsrL1NESFBGV2NJUmgvTEtmWmR4eThjR09XVGl5Y2owT1dGUFRlY1Mw?=
 =?utf-8?B?TEYxdzM3eG5heml4U2VIdlhBNnlOdlRHb3dmc0RzS1RkUWh6R3NUbThtak5h?=
 =?utf-8?B?T2ZtbkR1VE5lY0RkOERKZ2hUQWhRTk85Zjk2czNocEF4SXFmQ2s1Qk8wRi9W?=
 =?utf-8?B?cnlXSmQvanVWR1VkaU82aHF1Mkp6OVlPNDFKdG1ySThkK3J5YjZtZk5MSmVJ?=
 =?utf-8?B?RTNnZlBJMVh2K0FpMkluUzh0NXpjREZGNFNJRWxDUjBZeS9iTUM2QlRXWjJJ?=
 =?utf-8?B?OVM2a1gzSlJmOWJ5bEVjWVFHUHhHdlF3OEJPckVhMmVOekFCbHNkWThWRks2?=
 =?utf-8?B?alJYWmpGYUlBb3VUZDBqZ2NWNUt2RG9xcXdhWk4wQjlmd2daN2ZoaUVBZ1pw?=
 =?utf-8?Q?5LDAKO/YoGo4hS0DDv62yi1GD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFDF3C382410EC4E91B36F31E10B09BE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d3c0fa-d004-4345-9e93-08da7fe8f2ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2022 00:39:31.0742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 94hB03wjuCrVix8cV6VE/1ml4apKNQXsfw39g11Ogg3IOyJ+/AesJGoidWfqjOOpHopsKVVeP10rS8ulQBvARQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3098
X-Proofpoint-GUID: yA73I1lYUQt3RmIogzWS3LnoewzyicvU
X-Proofpoint-ORIG-GUID: yA73I1lYUQt3RmIogzWS3LnoewzyicvU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_08,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 spamscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 suspectscore=0 phishscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208170001
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgV2VzbGV5LA0KDQpPbiA4LzE1LzIwMjIsIFdlc2xleSBDaGVuZyB3cm90ZToNCj4gQ2hhbmdl
cyBpbiB2MzoNCj4gLSBNb2RpZmllZCB0aGUgbXNsZWVwKCkgZHVyYXRpb24gdG8gfjJzIHZlcnN1
cyB+MTBzIGR1ZSB0byB0aGUgbWluaW11bQ0KPiBtZGVsYXkoKSB2YWx1ZS4NCj4gLSBSZW1vdmVk
IHBhdGNoIHRvIG1vZGlmeSBERVAgZmxhZ3MgZHVyaW5nIGR3YzNfc3RvcF9hY3RpdmVfdHJhbnNm
ZXIoKS4NCj4gVGhpcyB3YXMgbm90IHJlcXVpcmVkIGFmdGVyIGZpeGluZyB0aGUgbG9naWMgdG8g
YWxsb3cgRVAgeGZlcmNvbXBsZXRlDQo+IGV2ZW50cyB0byBiZSBoYW5kbGVkIG9uIEVQMC4NCj4g
LSBBZGRlZCBzb21lIGNoYW5nZXMgdG8gYWNjb3VudCBmb3IgYSBjYWJsZSBkaXNjb25uZWN0IHNj
ZW5hcmlvLCB3aGVyZQ0KPiBkd2MzX2dhZGdldF9wdWxsdXAoKSB3b3VsZCBub3QgYmUgZXhlY3V0
ZWQgdG8gc3RvcCBhY3RpdmUgdHJhbnNmZXJzLg0KPiBOZWVkZWQgdG8gYWRkIHNvbWUgbG9naWMg
dG8gdGhlIGRpc2Nvbm5lY3QgaW50ZXJydXB0IHRvIGVuc3VyZSB0aGF0IHdlDQo+IGNsZWFudXAv
cmVzdGFydCBhbnkgcGVuZGluZyBTRVRVUCB0cmFuc2FjdGlvbiwgc28gdGhhdCB3ZSBjYW4gY2xl
YXIgdGhlDQo+IEVQMCBkZWxheWVkIHN0b3Agc3RhdHVzLiAoaWYgcGVuZGluZykNCj4gLSBBZGRl
ZCBwYXRjaCB0byBlbnN1cmUgdGhhdCB3ZSBkb24ndCBwcm9jZWVkIHdpdGggdW1hcHBpbmcgYnVm
ZmVycw0KPiB1bnRpbCB0aGUgZW5keGZlciB3YXMgYWN0dWFsbHkgc2VudC4NCj4gDQo+IENoYW5n
ZXMgaW4gdjI6DQo+IC0gTW92ZWQgbXNsZWVwKCkgdG8gYmVmb3JlIHJlYWRpbmcgc3RhdHVzIHJl
Z2lzdGVyIGZvciBoYWx0ZWQgc3RhdGUNCj4gLSBGaXhlZCBrZXJuZWwgYm90IGVycm9ycw0KPiAt
IENsZWFyaW5nIERFUCBmbGFncyBpbiBfX2R3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXJzKCkNCj4g
LSBBZGRlZCBTdWdnZXN0ZWQtYnkgdGFncyBhbmQgbGluayByZWZlcmVuY2VzIHRvIHByZXZpb3Vz
IGRpc2N1c3Npb25zDQo+IA0KPiBUaGlzIHBhdGNoIHNlcmllcyBhZGRyZXNzZXMgc29tZSBpc3N1
ZXMgc2VlbiB3aGlsZSB0ZXN0aW5nIHdpdGggdGhlIGxhdGVzdA0KPiBzb2Z0IGRpc2Nvbm5lY3Qg
aW1wbGVtZW50YXRpb24gd2hlcmUgRVAgZXZlbnRzIGFyZSBhbGxvd2VkIHRvIHByb2Nlc3Mgd2hp
bGUNCj4gdGhlIGNvbnRyb2xsZXIgaGFsdCBpcyBvY2N1cnJpbmcuDQo+IA0KPiAjMQ0KPiBTaW5j
ZSByb3V0aW5lcyBjYW4gbm93IGludGVyd2VhdmUsIHdlIGNhbiBzZWUgdGhhdCB0aGUgc29mdCBk
aXNjb25uZWN0IGNhbg0KPiBvY2N1ciB3aGlsZSBjb25uZG9uZSBpcyBiZWluZyBzZXJ2aWNlZC4g
IFRoaXMgbGVhZHMgdG8gYSBjb250cm9sbGVyIGhhbHQNCj4gdGltZW91dCwgYXMgdGhlIHNvZnQg
ZGlzY29ubmVjdCBjbGVhcnMgdGhlIERFUCBmbGFncywgZm9yIHdoaWNoIGNvbm5kb25lDQo+IGlu
dGVycnVwdCBoYW5kbGVyIHdpbGwgaXNzdWUgYSBfX2R3YzNfZXBfZW5hYmxlKGVwMCksIHRoYXQg
bGVhZHMgdG8NCj4gcmUtaXNzdWluZyB0aGUgc2V0IGVwIGNvbmZpZyBjb21tYW5kIGZvciBldmVy
eSBlbmRwb2ludC4NCj4gDQo+ICMyDQo+IEZ1bmN0aW9uIGRyaXZlcnMgY2FuIGFzayBmb3IgYSBk
ZWxheWVkX3N0YXR1cyBwaGFzZSwgd2hpbGUgaXQgcHJvY2Vzc2VzIHRoZQ0KPiByZWNlaXZlZCBT
RVRVUCBwYWNrZXQuICBUaGlzIGNhbiBsZWFkIHRvIGxhcmdlIGRlbGF5cyB3aGVuIGhhbmRsaW5n
IHRoZQ0KPiBzb2Z0IGRpc2Nvbm5lY3Qgcm91dGluZS4gIFRvIGltcHJvdmUgdGhlIHRpbWluZywg
Zm9yY2VmdWxseSBzZW5kIHRoZSBzdGF0dXMNCj4gcGhhc2UsIGFzIHdlIGFyZSBnb2luZyB0byBk
aXNjb25uZWN0IGZyb20gdGhlIGhvc3QuDQo+IA0KPiAjMw0KPiBFbnN1cmUgdGhhdCBsb2NhbCBp
bnRlcnJ1cHRzIGFyZSBsZWZ0IGVuYWJsZWQsIHNvIHRoYXQgRVAwIGV2ZW50cyBjYW4gYmUNCj4g
cHJvY2Vzc2VkIHdoaWxlIHRoZSBzb2Z0IGRpc2Nvbm5lY3QvZGVxdWV1ZSBpcyBoYXBwZW5pbmcu
DQo+IA0KPiAjNA0KPiBTaW5jZSBFUDAgZXZlbnRzIGNhbiBvY2N1ciBkdXJpbmcgY29udHJvbGxl
ciBoYWx0LCBpdCBtYXkgaW5jcmVhc2UgdGhlIHRpbWUNCj4gbmVlZGVkIGZvciB0aGUgY29udHJv
bGxlciB0byBmdWxseSBzdG9wLg0KPiANCj4gIzUNCj4gQWNjb3VudCBmb3IgY2FibGUgZGlzY29u
bmVjdCBzY2VuYXJpb3Mgd2hlcmUgbm90aGluZyBtYXkgY2F1c2UgdGhlIGVuZHhmZXINCj4gcmV0
cnkgaWYgRFdDM19FUF9ERUxBWV9TVE9QIGlzIHNldC4NCj4gDQo+ICM2DQo+IEF2b2lkIHVubWFw
cGluZyBwZW5kaW5nIFVTQiByZXF1ZXN0cyB0aGF0IHdlcmUgbmV2ZXIgc3RvcHBlZC4gIFRoaXMg
d291bGQNCj4gbGVhZCB0byBhIHBvdGVudGlhbCBTTU1VIGZhdWx0Lg0KPiANCj4gV2VzbGV5IENo
ZW5nICg4KToNCj4gICB1c2I6IGR3YzM6IERvIG5vdCBzZXJ2aWNlIEVQMCBhbmQgY29ubmRvbmUg
ZXZlbnRzIGlmIHNvZnQgZGlzY29ubmVjdGVkDQo+ICAgdXNiOiBkd2MzOiBnYWRnZXQ6IEZvcmNl
IHNlbmRpbmcgZGVsYXllZCBzdGF0dXMgZHVyaW5nIHNvZnQgZGlzY29ubmVjdA0KPiAgIHVzYjog
ZHdjMzogZ2FkZ2V0OiBTeW5jaHJvbml6ZSBJUlEgYmV0d2VlbiBzb2Z0IGNvbm5lY3QvZGlzY29u
bmVjdA0KPiAgIHVzYjogZHdjMzogZ2FkZ2V0OiBDb250aW51ZSBoYW5kbGluZyBFUDAgeGZlcmNv
bXBsZXRlIGV2ZW50cw0KPiAgIHVzYjogZHdjMzogQXZvaWQgdW5tYXBwaW5nIFVTQiByZXF1ZXN0
cyBpZiBlbmR4ZmVyIGlzIG5vdCBjb21wbGV0ZQ0KPiAgIHVzYjogZHdjMzogSW5jcmVhc2UgRFdD
MyBjb250cm9sbGVyIGhhbHQgdGltZW91dA0KPiAgIHVzYjogZHdjMzogZ2FkZ2V0OiBTa2lwIHdh
aXRpbmcgZm9yIENNREFDVCBjbGVhcmVkIGR1cmluZyBlbmR4ZmVyDQo+ICAgdXNiOiBkd2MzOiBn
YWRnZXQ6IFN1Ym1pdCBlbmR4ZmVyIGNvbW1hbmQgaWYgZGVsYXllZCBkdXJpbmcgZGlzY29ubmVj
dA0KPiANCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jICAgfCAgNCAtLS0tDQo+ICBkcml2ZXJz
L3VzYi9kd2MzL2NvcmUuaCAgIHwgIDMgKysrDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2VwMC5jICAg
IHwgMTEgKysrKysrLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIHwgNDggKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDUy
IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQ0KPiANCg0KQmVzaWRlIHRoZSBjb21tZW50
IG9uIFtwYXRjaCA2LzhdIGluY3JlYXNpbmcgaGFsdCB0aW1lb3V0LCB0aGUgcmVzdA0KbG9va3Mg
ZmluZSB0byBtZS4NCg0KUmV2aWV3ZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5
bm9wc3lzLmNvbT4NCg0KVGhhbmtzIGZvciB0aGUgcGF0Y2hlcyENClRoaW5oDQo=
