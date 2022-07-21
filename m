Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3AB57D68F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 00:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiGUWJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 18:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiGUWJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 18:09:09 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9511B951CE;
        Thu, 21 Jul 2022 15:09:08 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LLPSbW019663;
        Thu, 21 Jul 2022 15:09:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=2RfGcmMD2obHPtNAfGL1er5zkumuS7fZuhBRMb+yAVc=;
 b=sIGtdiz/5kkbiJ9xI97Ex+Q3kJfNiEaIPWXoGkbkcO5TsDD5kK47MRxuAy0pi88ksqaL
 3x1euxZhlmsp14KVpFWNGeBkOjwi54z1zej/JJfxf5FVtlvDMmUFI/sgaTsx0mxe6CUi
 NW4VCeECeXgTIJ0LtchbCGLWObCUugGx5GNYEKjl54vFCNwE3sXc1sMa85ANzFF15fje
 NRsQFCfvIPLkdZ0xNaTQCmX1KGJpeb5Qj5YskTvj47GYj1wvxSPfTVTnh6NNnzNAlMcY
 EEztE8GT8sYUW6vCNhZrkMgetcjhifcb1aFSaYnAh0x1Wakqy61VPdPAqYmNplKKWIXm tA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3hc6c3subr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 15:09:02 -0700
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 974BC4009A;
        Thu, 21 Jul 2022 22:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1658441341; bh=2RfGcmMD2obHPtNAfGL1er5zkumuS7fZuhBRMb+yAVc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Uk7hzvm5CoRZskJzzYY/2LRvFzUePUybi+hdPA3c8eqc9e955pVwBuA0so1LGMoYe
         mFItNy4gLaX8rE0HeAlBDugkNvkeuRzhQxAoFHeMOFaw7FYuM9grwKP8zumR/YgXl2
         Uc/MkvM4QWmKkGUsF0yGMVvyP6E4Ygjj9sj7iVXQrHdwT7SSmtEvpKqfjdZaSl5o1m
         P2zcTXhX0S0nQRhVjyPg1TJkzlly4XTmPMu7/d5s76etQMu/Pv4yXQZRoNDeFRvLZ1
         tj3ZTxX76XyDglK4vHRXJ7C6aVCQYTJXJlPIE0IRDydpx2R6Pw4ihBnnV/s4+wqm9e
         aGyEohzsQJjqg==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id BAD61A00A2;
        Thu, 21 Jul 2022 22:08:59 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 799D7400C5;
        Thu, 21 Jul 2022 22:08:58 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="F2w+JZLa";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/bgd+V3Mkqmw2vkk2kzVShZRNhWYoK3Isxy3ZL5ZEMAGQ6ltwfYI3DorlIjrLTIfwRNh8924L2mmazkbo4sqMh596o8pxnW9GWx9oW7r/sMTyj1/cGr+tK34qKUzcfEyr4ll4nXkyiCcQJGAmhtHtUGRVz3NtAYV26dM0VBwRQHYoA5v4nHZZ96Twr2Qk/mEccORfXSvrxGZp+Drz9Cz2nB0Mno4bhwVrnxWzUzDZyMvjA1jhJjl3ZLV1fx+wPSL3hpArOiMG3leuyVGvoVTpuTVltiYlza7fJ8i+MaJ3M1MhUEB/01XQGRGZkBzFtET7YBd8Ui8dn58n5R70fLGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RfGcmMD2obHPtNAfGL1er5zkumuS7fZuhBRMb+yAVc=;
 b=XfGfD/yAM6lr8KspmCJx8sIV+4dpQNSMWGN/EdUIw65on4uKY4hDMU3WtMbg79s7dUc0RImBRw0KEGej9zverHHSdFoygSgqZa6u3pxIqR2jSx/3e4dc6B60a0VUV58cPdzAH3oWVhipoC7+rnVJ58hRZVTELumNTceBEA9qnAE5//ZEaF9h8XpgeWzi2hkXR3fgEmEElJiliNH8Y/cWnvuhEQmgbATPTlxdki+cE4FgVx3g3ylqGzKgiJyPfgqotWRhyCcM5JaFpqpi759W0unUGzhSeKt3krqJ3viEO2tEDWBL4/ahacXfFXoZ9Jt/PrhrIR7nWZGcwZBl1Takiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RfGcmMD2obHPtNAfGL1er5zkumuS7fZuhBRMb+yAVc=;
 b=F2w+JZLaV5+/2L3xsPR162gsJxspcPPKJ7sacka4AXWWzVX5oYAyxs3gxsMnN607hX9C55yxHTNvGD4jnhoAqshVtaw0+8zK/6yj7h38/acG0lE4K6w3018Dnh+/X0VtVxcBFxqPyi5+7FSkxmwzxKnp5288IE/L/VAtkF2FYEc=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MWHPR1201MB2527.namprd12.prod.outlook.com (2603:10b6:300:df::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 21 Jul
 2022 22:08:55 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c%7]) with mapi id 15.20.5438.023; Thu, 21 Jul 2022
 22:08:55 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH v2 4/5] usb: dwc3: Allow end transfer commands to be sent
 during soft disconnect
Thread-Topic: [PATCH v2 4/5] usb: dwc3: Allow end transfer commands to be sent
 during soft disconnect
Thread-Index: AQHYllCHTDdRJ4wf3U6yBQnRzTv93K2JcEyA
Date:   Thu, 21 Jul 2022 22:08:55 +0000
Message-ID: <d8d26ce3-6773-bd9c-e227-0924f239eae0@synopsys.com>
References: <20220713003523.29309-1-quic_wcheng@quicinc.com>
 <20220713003523.29309-5-quic_wcheng@quicinc.com>
In-Reply-To: <20220713003523.29309-5-quic_wcheng@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ebfba81-3f5b-422a-acb5-08da6b659a50
x-ms-traffictypediagnostic: MWHPR1201MB2527:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZHrPXezwnWjMiPA4/pzv5RAXd2HHI6QKmmMJ37bXxh70zXgUST7rUWLvM9ObtYM/hCxmdWxzS0ku4Uz6zvmjy+zEmgiibhXwuG6rapxWAdtxiweGBKBq5IkVOBxCOIij6b936yRsm3+NrVK+iGf3hyH48BuaFOyazQ1nmheurN6qHDjUY01W68oUFqlKYZ9JiOLG8OljlZfz6tslKm7wIJfEWHEN1QebrK31nuv88A0pRWp6V/s9UPsLhqZt1ibgX6mqN75EoLRKKGeOLaw7z1iUesQtYB+EuFk0Y865Q1VXmYO97Khq/IRPeV7rdfQNVpPZvVMkAuYQRHPy+HQP2Tx9noR8/tNMHYMyIiAowUWYvX83owGwbETJyWAJV2swyopYJSrQX794fjAWlyBNc1A+dd+/RqNBUHvyHL0CqwC9KdbC8BbgnoBoenwLELWg4QBfvDOZpCZ0d2EWESrg/T5TAL9LAt8YTk04wuiF8knhjHTppD6CWpcXOODLT5kQhiF0X6pE9g1NRxWgt8gxvi042IZTd4xcwFbwW5MGtQZg/VSsgqo/Rem0WeyNYWnuPy1P5xgIMM88xDKoczjsG7JuWSHbKegyEmBVteKTp+PcKboI/cL6w+egIrkvStzTty+ACHYe/yUJJYF9uhahzzIFhfv7YJerh+u4m5NA+4LSVB/KXuYDAh09lgLlnD+foIsXcYtS/t+ih9DRXRegwJOBMj5Mq5B5uly//hW/DKX5FKYwmIe7KUaAGMjjlw37l78ArB4dBVmflvPE45/R5ULN5tfKMvdXqBhGRHuFx3Mk97nMSboojeFRPYCUadmQfuxyqrRVavPqlPNlloVb0mx31luYwkK3jLy+FfBdHWsQ3N16d62tc2MYdv9W7x3ePCstDuhgc2cON28nTuvfBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(396003)(39860400002)(346002)(376002)(36756003)(316002)(6486002)(76116006)(110136005)(54906003)(66556008)(4326008)(71200400001)(8676002)(66446008)(66946007)(64756008)(66476007)(91956017)(2616005)(107886003)(186003)(83380400001)(41300700001)(966005)(6512007)(478600001)(26005)(31696002)(86362001)(6506007)(8936002)(31686004)(5660300002)(2906002)(38070700005)(38100700002)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXJzTXEwNWY1dFQwaHlCQmtLeUdMbjY5NytKc1hrMHo2VjZWQXlBWllmMXBv?=
 =?utf-8?B?aE5sWUY4QUgrR3h6eVZNNi9sSlZVekx6U3kwSVJlNFY5WU5pMldrNzR5bWlH?=
 =?utf-8?B?ZmNoVysvUHorV3JOSWFNVHhDOE5DeXR1dFVPMGE5MjJ3OXFkR0FYeENqakM4?=
 =?utf-8?B?UGd5NzRZY3V5MDZ5NUdGK29Ub3NtNWEzUlZKeVJHQXdQcVEyakY3TVdvVk96?=
 =?utf-8?B?TkdGQUo2WkhSRUlpQXB4dWJ0NGU5WUF5TGtFVlZyMU9sdmFsblFqTnU5V3Nr?=
 =?utf-8?B?Q1FUaTcxN2crSHNrTDFQRk1DUEh0S1RSYzh3WGgybE9ia2hoNFJiTG9aeHcw?=
 =?utf-8?B?TXVDb2FsMkNpamRFWDYyc21STFRQS2NkRU54YXNsNVFtczFmZmRLb0FJTlRl?=
 =?utf-8?B?Y1czU2xFNVNNYmZOU0p1bVNDNWQ0U0taRE1HRllnY1hDaHhCTVgzdjVNVkVC?=
 =?utf-8?B?NGJSakRQYVppOG56cnZPN2Q2K1pDUElrbFRwMzVQek5Qcy9UdFBTdFIwMy9r?=
 =?utf-8?B?a2xLWFZQNXQ3ZG9QTFY3ZG9GN043L3NGbHpQWjV6MlRBV1l3VDVPV2RrTE9Q?=
 =?utf-8?B?eVhNVk9uRFZ0cEhUMEhNMWlCYUlpNldkcng4aXBiWkJpc0ZGWUpZQVpzMTJC?=
 =?utf-8?B?MFZZeDFma0Y1VjQwY1pYVDdMTXlVK1ZZa3NtSjlNVUw2ZWJmNklnczI2MUZ4?=
 =?utf-8?B?Nks1cEp3NEkyc2dCajRkVE1XekVUU0VxbytORkFvRnFDZTdRTGRmOENuU2N2?=
 =?utf-8?B?SDA3Q3UxbGI1UDdTekVEM29HenUwd2d0ZG8rbEh2Nm5KZWFJYkhNb0prVCtr?=
 =?utf-8?B?aktRaDBMQ2lVQXJwQ1pKdEFrWUJlai9KaG1NZTRqQ21sV2Y0UUtTZSt2ZG5j?=
 =?utf-8?B?aG5mNVdGaEttS0ovU0doRXg5QkJVWHNadlcvSEdXZnAzZDFlMFBDajU3Y2ZU?=
 =?utf-8?B?S1NhNHJLNVBxL2x4TWxnMGhicEFyQlU5VHJoeGFZUDZpMHV2ZkxvVzlRM1dU?=
 =?utf-8?B?UEVXMTNKMlV4TFRuMnlBK3JoMkRyUzY4Z1NJQS9tdDR3eHhRRWQwcmJqUFZT?=
 =?utf-8?B?Kzc3NkJJaDF0dUNVa3BhbWZZMTJ4dXZ0ZWF5ZU8renhVWFBnckwyZHNYMUFq?=
 =?utf-8?B?RGlIQksvYVJmOVpXcmFwV1NKK216cDE4dStSdDY2ZXRMKzU0RFNYY1lOemIw?=
 =?utf-8?B?RmNoT1RpVWdtdkJ6UU9OWmVhNEVYNXdHandCeURVbS9CQThGR25DMTJtL000?=
 =?utf-8?B?T1loelArRkdqNE9uNVpMSVNkSkZicFhtR1BTaWplckIyUVRGUkR2THprRGtM?=
 =?utf-8?B?NFUyZUU3RzdiUGpSWGpkYUc5YmdCdFlPQXh0UUxqMDI3VG1CdzRDVGN3aVNn?=
 =?utf-8?B?KzlNRnJzUm0vdERNRUVrSHNSTWduNnB3Y0dJSlFrRkxtdUIvakd4L09meVJI?=
 =?utf-8?B?dFlvYWExa3N5Y0tYejhSNjNnVHhoaHJDSjhQdFdyWmxzclZoNU0zcTZVSTRx?=
 =?utf-8?B?dDNHK3VZcnkyQ3hqUWx2aGVSRUVJTTA1bnVBUjF3b005dXJ0d0ZxWkpXUDJE?=
 =?utf-8?B?ZDBoZXUvVVVJN1VVV3hPcGR2bEFmNVlaT21LLytERnZya1JIREJ3TGQvMWhy?=
 =?utf-8?B?MDJFa2cvb3hwejhlWlRlN2gvOURQNktxU1hRVGxWa2lXcGppQkU4VkxJZE9x?=
 =?utf-8?B?NmwzTERUTHhVRUtFTVRIRTdFSTVxem5qYmhNMXVCd2ZlQTRiWVVtQWxua1Vs?=
 =?utf-8?B?Y1hxdXkzRklOTVFCQ2JRejM2OTVTUmlROHZMLytZR1VoSzdOa1dEZWJxTXRu?=
 =?utf-8?B?dk1BTWNwTjdDamVON0Z2cDRiSWttZXJkQTcxQTZTemlWbFh2eUNlWlRabjI3?=
 =?utf-8?B?Z3hsL0JCVDZoZWhyWnZwcDBVWVd2NDhCVTMycmRDKzA4bjJpQTdNeDlEUDdR?=
 =?utf-8?B?Smp5YmpqT1NKY2N1dEl6MFZxalNSSzg1aWhpRHVJQmdOTnNSdWx4UnZ4OFlq?=
 =?utf-8?B?alZCeFd2ZUh0OFk1SVVGTUovRXp2d0wzTXBRVy9BZGZVdmI2TEFCTHpzcUhV?=
 =?utf-8?B?L25IWGxJS3lCVXpma0cyb0xOS2w3TE94c2g2R0IrUmlGT3RSRWRQS05KK3Rt?=
 =?utf-8?Q?4gV+VgR0e//izi7xyDgsMP5I6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1BC535FDD9F3A447ACBBAC401BDA2B99@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebfba81-3f5b-422a-acb5-08da6b659a50
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 22:08:55.0725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rzre0jbhphi0YUNA0I70S1pbw7cZG/b1mi7gNSzFRkh2dBjoVK+UM+1bxXaOc8+CDa5OXuYSv8PKG9EUA5w9Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2527
X-Proofpoint-ORIG-GUID: oaLG9tG_sASmjyPqFjtbpESeVCfSK0aD
X-Proofpoint-GUID: oaLG9tG_sASmjyPqFjtbpESeVCfSK0aD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_28,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 priorityscore=1501 mlxscore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207210091
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgV2VzbGV5LA0KDQpPbiA3LzEyLzIwMjIsIFdlc2xleSBDaGVuZyB3cm90ZToNCj4gSWYgc29m
dCBkaXNjb25uZWN0IGlzIGluIHByb2dyZXNzLCBhbGxvdyB0aGUgZW5keGZlciBjb21tYW5kIHRv
IGJlIHNlbnQsDQo+IHdpdGhvdXQgdGhpcywgdGhlcmUgaXMgYW4gaXNzdWUgd2hlcmUgdGhlIHN0
b3AgYWN0aXZlIHRyYW5zZmVyIGNhbGwNCj4gKGR1cmluZyBwdWxsdXAgZGlzYWJsZSkgd291bGRu
J3QgYWN0dWFsbHkgaXNzdWUgdGhlIGVuZHhmZXIgY29tbWFuZCwNCj4gd2hpbGUgY2xlYXJpbmcg
dGhlIERFUCBmbGFnLg0KPg0KPiBJbiBhZGRpdGlvbiwgaWYgdGhlIERXQzNfRVBfREVMQVlfU1RP
UCBmbGFnIHdhcyBzZXQgYmVmb3JlIHNvZnQgZGlzY29ubmVjdA0KPiBzdGFydGVkIChpLmUuIGZy
b20gdGhlIGRlcXVldWUgcGF0aCksIGVuc3VyZSB0aGF0IHdoZW4gdGhlIEVQMCB0cmFuc2FjdGlv
bg0KPiBjb21wbGV0ZXMgZHVyaW5nIHNvZnQgZGlzY29ubmVjdCwgdG8gaXNzdWUgdGhlIGVuZHhm
ZXIgd2l0aCB0aGUgZm9yY2UNCj4gcGFyYW1ldGVyIHNldCwgYXMgaXQgZG9lcyBub3QgZXhwZWN0
IGEgY29tbWFuZCBjb21wbGV0ZSBldmVudC4NCj4NCj4gRml4ZXM6IGU0Y2Y2NTgwYWM3NDAgKCJ1
c2I6IGR3YzM6IGdhZGdldDogV2FpdCBmb3IgZXAwIHhmZXJzIHRvIGNvbXBsZXRlIGR1cmluZyBk
ZXF1ZXVlIikNCj4gU3VnZ2VzdGVkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5v
cHN5cy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFdlc2xleSBDaGVuZyA8cXVpY193Y2hlbmdAcXVp
Y2luYy5jb20+DQo+IC0tLQ0KPiBMaW5rOg0KPiAgICBodHRwczovL3VybGRlZmVuc2UuY29tL3Yz
L19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtdXNiLzFhMWE1NDg1LTc5MGUtNzljZS1m
NWE2LTFlOTZkOWI0OWE0N0BzeW5vcHN5cy5jb20vX187ISFBNEYyUjlHX3BnIWNYVzJUbEFMWVdu
WE5QZy1Ob01GVXJROEsxZWdFWmlRaXpaNUNBMURPTTFHY3c0dGZPVUx5LV8yZU1Hdkw4cFFQdGU1
ZFNjRk9OLTB3eEgyZVh1OGlqRVFVYnMkDQo+DQo+ICAgZHJpdmVycy91c2IvZHdjMy9lcDAuYyAg
ICB8IDMgKy0tDQo+ICAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDUgKysrKy0NCj4gICAy
IGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4NCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZXAwLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2VwMC5j
DQo+IGluZGV4IDUwNmVmNzE3ZmRjMC4uNTg1MWIwZTlkYjBhIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL3VzYi9kd2MzL2VwMC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZXAwLmMNCj4gQEAg
LTI5MCw4ICsyOTAsNyBAQCB2b2lkIGR3YzNfZXAwX291dF9zdGFydChzdHJ1Y3QgZHdjMyAqZHdj
KQ0KPiAgIAkJaWYgKCEoZHdjM19lcC0+ZmxhZ3MgJiBEV0MzX0VQX0RFTEFZX1NUT1ApKQ0KPiAg
IAkJCWNvbnRpbnVlOw0KPiAgIA0KPiAtCQlkd2MzX2VwLT5mbGFncyAmPSB+RFdDM19FUF9ERUxB
WV9TVE9QOw0KDQpJZiB3ZSBkb24ndCBjbGVhciB0aGlzIGZsYWcgaGVyZSwNCg0KPiAtCQlkd2Mz
X3N0b3BfYWN0aXZlX3RyYW5zZmVyKGR3YzNfZXAsIHRydWUsIHRydWUpOw0KPiArCQlkd2MzX3N0
b3BfYWN0aXZlX3RyYW5zZmVyKGR3YzNfZXAsIHRydWUsIGR3Yy0+Y29ubmVjdGVkKTsNCj4gICAJ
fQ0KPiAgIH0NCj4gICANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMg
Yi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IGluZGV4IGVlODViNzczZTNmZS4uNDFiNzAw
NzM1OGRlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBi
L2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gQEAgLTE2OTMsNiArMTY5Myw3IEBAIHN0YXRp
YyBpbnQgX19kd2MzX3N0b3BfYWN0aXZlX3RyYW5zZmVyKHN0cnVjdCBkd2MzX2VwICpkZXAsIGJv
b2wgZm9yY2UsIGJvb2wgaW50DQo+ICAgCQlkZXAtPmZsYWdzICY9IH5EV0MzX0VQX1RSQU5TRkVS
X1NUQVJURUQ7DQo+ICAgCWVsc2UgaWYgKCFyZXQpDQo+ICAgCQlkZXAtPmZsYWdzIHw9IERXQzNf
RVBfRU5EX1RSQU5TRkVSX1BFTkRJTkc7DQo+ICsJZGVwLT5mbGFncyAmPSB+RFdDM19FUF9ERUxB
WV9TVE9QOw0KPiAgIA0KPiAgIAlyZXR1cm4gcmV0Ow0KPiAgIH0NCj4gQEAgLTM2ODYsOCArMzY4
NywxMCBAQCB2b2lkIGR3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXIoc3RydWN0IGR3YzNfZXAgKmRl
cCwgYm9vbCBmb3JjZSwNCj4gICAJaWYgKGRlcC0+bnVtYmVyIDw9IDEgJiYgZHdjLT5lcDBzdGF0
ZSAhPSBFUDBfREFUQV9QSEFTRSkNCj4gICAJCXJldHVybjsNCj4gICANCj4gKwlpZiAoaW50ZXJy
dXB0ICYmIChkZXAtPmZsYWdzICYgRFdDM19FUF9ERUxBWV9TVE9QKSkNCj4gKwkJcmV0dXJuOw0K
PiArDQoNCnRoZW4gaXQgbWF5IG5vdCBnbyB0aHJvdWdoIGhlcmUuIEkgdGhpbmsgSSBtYWRlIHRo
aXMgc2FtZSBtaXN0YWtlIGluIG15IA0KcHJldmlvdXMgc3VnZ2VzdGlvbi4NCg0KPiAgIAlpZiAo
IShkZXAtPmZsYWdzICYgRFdDM19FUF9UUkFOU0ZFUl9TVEFSVEVEKSB8fA0KPiAtCSAgICAoZGVw
LT5mbGFncyAmIERXQzNfRVBfREVMQVlfU1RPUCkgfHwNCj4gICAJICAgIChkZXAtPmZsYWdzICYg
RFdDM19FUF9FTkRfVFJBTlNGRVJfUEVORElORykpDQo+ICAgCQlyZXR1cm47DQo+ICAgDQoNClRo
YW5rcywNClRoaW5oDQo=
