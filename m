Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F2F5754DC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240629AbiGNSXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240611AbiGNSWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:22:40 -0400
X-Greylist: delayed 2619 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Jul 2022 11:22:38 PDT
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2142691FB;
        Thu, 14 Jul 2022 11:22:38 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26EEEKV7016125;
        Thu, 14 Jul 2022 10:38:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=H3cvR5f688qvhB+jw4hKxCUsNzpXe+Fi82Yp5/bEY00=;
 b=trv8G6v1ikO29i92c1Fueben3bbPOCe0ElGS3qXZevxK31pQegHmHcVBJ/1/YlUKubtA
 eV8AA7VjUizgbYo6PA3IHOmsLY8OvXyechPczNXD0HnJMAZ7PpuG2ZmTO1j/MDElpKqo
 QN6PEsPQxUe9tm1Z2mJFSz5ToAEghc/a9owlTyGEWZUU5K+Tmgux3MZpIZIX0zPT+425
 lOohJFx8ASrI1TzTtigA487J0CcH7xSYxr0rAoJfmfPNMj3eV18B0vG3DdSosd1LAPfC
 k7IfrNIFtiXHJAiyVr2Lzhv6qgaxWGGjbPYJrMbHK9Jchw9clGsQ63U2s/lbkG9l8/hd 5w== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3h78kvug8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 10:38:42 -0700
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8287940052;
        Thu, 14 Jul 2022 17:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1657820322; bh=H3cvR5f688qvhB+jw4hKxCUsNzpXe+Fi82Yp5/bEY00=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=I2QP70g6HhQLOKV7IvnnnP4ks2fi8KOqrXDk3gq1Q35PBFpB1Ngr1noHXxRxyaQbZ
         3QOCDMoQsTR/SLmG8wtD/BcSnQ2gmOrIjgmi+1spJz7HznMZCSXcxgjGkvfO09jh38
         +lyzBzTiDiHTLz1n4QTNX2ot8FVzMVjN5he53YGtAanrUbIYdKBNVZr3ScqjNITNsA
         G3TKReAxs9gMSqfv7RFUXtxicFEanzDcBaeP6iLa5I1wS7KHFVI7BphexBbJgijUEl
         WKh84pYzQpVuwSjLF4vIhVzWn3G29JZiTlpUxOEuhWor6sTZAWR7lxH12aqfyyjbbS
         AbAAWOmd3Xwug==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id C8B6EA0077;
        Thu, 14 Jul 2022 17:38:40 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2040.outbound.protection.outlook.com [104.47.51.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id A7A7040030;
        Thu, 14 Jul 2022 17:38:39 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="pZgPB0iS";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6+eYSv3PxIIrA934Eltm++wr66j1B/OFMv4RA0VEaYkevuYAYDShVXNK1ZnZps8rExiOZUfQZq7nL4/e8gp/gkHRhFOAJ+Jhi6P9iFTdy1FgLspEZDRmqVkljrKTOiuO3RE46WeXTH6CBheMiWd5mOxO7w/mHPnlZGSQYfxPATK+IM4crHc3GI5x05olrGe+jKFzkc6jZQkKa3OPbSONvTq84MAzSA8zc5SqIbP1WoaMwn/aAUkqsZBxOz2WiNXTqhK+/8cTN6fi3e2LQZhpTnLZzI4Jm6ZwWuHAL2tsOWJ1D91lbdrjjRLD4ttBGDP7j6GR02oqLxNcjrf+bYgug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3cvR5f688qvhB+jw4hKxCUsNzpXe+Fi82Yp5/bEY00=;
 b=bPNHzlOsa14A9D0nt8rihmp7pRXi0mmSykBbxp2kTXqLKHtTn920qbCpm9MAyGV3n4KLBT9cAZ0iIevy8k3W6ouRzZNbT7lZ1hDAOpofeRYSgyKMW0Q7LNY6/W85WCRQdNqcoOjZu74NeS2fM28ksleKtn9xFg5C50sgAWrWhWsTHr42gpfM4pfSPBMlGNxw3wByyx4pi6ys/FO5BIO6dMaeYnFge5MsgJkDdLK32bH1otCV7IHgpHY0JzJXbrDMNxLgzw0/fwIZK4geCgt2GclK6WNEplC+EzP9qw5ejsgIk+SItSO5Z32fuQerrVCXjPOz/oJem8fGoiPKupOH5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3cvR5f688qvhB+jw4hKxCUsNzpXe+Fi82Yp5/bEY00=;
 b=pZgPB0iSqoWzgYgxHlCoKZh8s9rRUKWINbLtLhlcmcmpwlU/b4TQlgmD0CqPZjPKbf0xZbdlUE2lrUeOUb+cRrRC8spBfkYK+HLn0wX52Ibb/a2qI0n3lQQt5QvSlqw15+Q3EVEaIqacXDPyGw/nj2TdIR2v5d/+gZdPmclXxlE=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BN9PR12MB5382.namprd12.prod.outlook.com (2603:10b6:408:103::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Thu, 14 Jul
 2022 17:38:36 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c%7]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 17:38:36 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH v2 3/5] usb: dwc3: gadget: Adjust IRQ management during
 soft disconnect/connect
Thread-Topic: [PATCH v2 3/5] usb: dwc3: gadget: Adjust IRQ management during
 soft disconnect/connect
Thread-Index: AQHYllCHX2wxupDRtESpWCuKNObxnq1+JHYA
Date:   Thu, 14 Jul 2022 17:38:36 +0000
Message-ID: <fbfc9328-418c-4c5e-4553-993331b20cb6@synopsys.com>
References: <20220713003523.29309-1-quic_wcheng@quicinc.com>
 <20220713003523.29309-4-quic_wcheng@quicinc.com>
In-Reply-To: <20220713003523.29309-4-quic_wcheng@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3c9b593-8d9f-42ed-ec3c-08da65bfae8a
x-ms-traffictypediagnostic: BN9PR12MB5382:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M9A5xcKC18T/cQgRsjb6h9BYv1zHUjteKD6cmw2CzqyswceqsKmqwusUOl1g/ajn8llRtVp8NldJI0uZ5Kpv0p6iE9vPKdz3L+e4holszbKdNtNWtIO4OTP79709qVUfBlMc1z+yv4h4RcEB0JnyE7Ry9uXhwLpqyZ8vdXMyiuNIGWu+ddAGZZO5KNLTrQUwQK4G2P+5xhJ3t01xsandkJz5bG5/MdPHp+PVcFrc/cB49i3Mi9MrMGRssvUprnFp1MThLzkGxojsTgZ3/SeSiAXQxA9WCelxjJXvDWq9msexKNNuyatBiscRS6QKG4NflI+oZpWaMrqvriTZ0ExGEoGBPQeAV2VOCVK+DDogus3cW/mTq+YZz0MrNJtIHI36dAQfVdtJQmcsPnSawjWIP92xmthQS4QbRaVmKKja2PE7/2nJzC2sLjObrlalyCMHm0Rf+9AHgzDGs6Hh+vEMqONkMSSNXiCEHx6uXGO6nqfz+Om454cCnNvUDzO2gYSQ9WyZCFxzhNkJEIQR9m9upf7/vc6TKROOERUulCsssvwuahq2nuYESbo7QcIxMp2bdePB+ArkTlpSWS/0INzwARZfL7GdQGo/S6wzNb8LFUQVLSv+MNy+vcxGa8GnwepMELgcHb/3HNMcXQs87srVpGvfZ1FE6WZg4IZ/I/Rzq4QOkrl4gryJsiOCQnlnUKzTFALRtI7WxhX/ZDkqZhs5NLsnbFlVCnefiANBJOwyj5ytgih1pNrEVZB+kBmPPP8TQ2xqisOpU+bWr19OZQSjwBtDkriS41KANPr5Y1fxi0ROHtttTx4p48GS71g00urowK3PWQuIcafJZLP7l/zdGUAe+byKrMXWZV6yQPuxkMsQ7eeL6a3VKzO0nDXro8r1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(39860400002)(396003)(136003)(346002)(36756003)(38070700005)(71200400001)(6512007)(2906002)(107886003)(41300700001)(31686004)(26005)(2616005)(4326008)(8676002)(38100700002)(66446008)(66556008)(66946007)(64756008)(76116006)(122000001)(66476007)(186003)(8936002)(6486002)(54906003)(5660300002)(86362001)(31696002)(316002)(478600001)(6506007)(110136005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0FFMXpvTXhjcnRlK0hSb21vVndLaDljRk1LTU1JMDBmVTNJVDZoNkt0dmFV?=
 =?utf-8?B?V1FIdjNRdXQrYkw3RGVkT3VzaTF3SlFSWHFyL2tDK0wvc2FwNFlJdk42OS9W?=
 =?utf-8?B?RjRNOUlNU0lJUXMvZnZsd3RPSSsycnJySktNaUk2UU9lSWxuU0ZKQlpvTnp4?=
 =?utf-8?B?WkhJUWl3SW9Ubk41dEtJd2U3RFhUSzFIMC9vTjhYQ2pPUitWTnNEME1tVkhm?=
 =?utf-8?B?NktZcUJCOWg1VHFTdGNrVkdJSnBzRzdnOGU0ZjlWSEkzY0RpaG5ZS3BDZXFG?=
 =?utf-8?B?TDh4ZGtES2xTVHM3RnpEQmZOcXZFK3dPd2l5S1F3RzYveENZMlpLakpYNVVt?=
 =?utf-8?B?blp5MGJrcTZjY3VIKzBUMzh0N0k3L1JRcUpFdXhlU2tWL2NDT0hJcXVxNXNR?=
 =?utf-8?B?VTJTRE52dktNT1VNOG93SnREZEZ2dmhGck9hdU42RVZxUUhWNEUzUWNhbms3?=
 =?utf-8?B?L2ZNRXZDRk5GZVBIQ214OWVydUhOTGNvTDdEWEJMMzJnTmkxNHlmdnRTMlJU?=
 =?utf-8?B?dnpNOFlaaWZzeWtzbGRLU1F2SU5oTEF3RVdjTFhyUEx5VDFuK1RRZWdqR0tM?=
 =?utf-8?B?Q3AzTDdmVG14WDd4ODJNSTdVaEU3b0xyYnhReDRKWHovVGZYZjJBUHcvaGJa?=
 =?utf-8?B?RUROanBzTkh6VzBER1l0VGw1ZlRjQ3hVdDNjcE51V1g3Sm1Bai9YS3d1bUh5?=
 =?utf-8?B?K1FleUF1dldqelNVZ1BXSlp6c09Kc3BnRGQ3TFlXRGo2bmtsdWN5UkJweVNB?=
 =?utf-8?B?RTQ1Y1o2aDhYUXphZTJCalpLVTdyaEZpR0xMelhkSmoyanBFRDlRMGNBUUp1?=
 =?utf-8?B?UUY1aW9kdEtiWGJqRzNDSTJ2dkhyV2Q1dC94RVYyYm1WZDRFdWFqZTRQRlBp?=
 =?utf-8?B?MjJxNmsrY01laG9pNlkwUGpuTWFXK0ZlUGdsdnFnN2QvU2hsUG1KR0ZaNjBh?=
 =?utf-8?B?bUsyRi9QaFpTNUFMbUxPdEZYc2dLWlhFREhIKzBsbyt5OEZua0VmaHluT1Nj?=
 =?utf-8?B?WDBmZ20xVXNpR25obEk3SlZ5ZkE5bENKVFFZSHlyYk1BVFByR3IzeXhNRVRW?=
 =?utf-8?B?WUdldkdleENkZ1ZtZUFOckdNbmN4Y0J0NDlpUThkNy9ZdDZ2RjhtRWFWajEr?=
 =?utf-8?B?RDB0U1RHMGEzQjBBNENEbnJETHpPWWxhN2NrYnFHQXNnS2dPaHpwNG5tcGd0?=
 =?utf-8?B?cC91YSsreXgrYmF3MXk3ZEtncnl3L0FoZ3hEdkVySUhmdHMxbHN2SGg2bmhp?=
 =?utf-8?B?aGRHY1Bqc1lQbnZTNVVHYWhBVkZ1QmJ3OXBCcGRuejQrVGtRN1hoallQYkNW?=
 =?utf-8?B?dGNmN1pORzY1TnZPUjBLbjNGUmRFUzA1QU1MS0VqTTRkT3F4ZjlPZFV0ZjV3?=
 =?utf-8?B?bzBDTnpxWUpqdVUzMVo3QnQ1ZCt0SUdjbnJwOFJ4U1dJUUh2MFM4SjNZZmF4?=
 =?utf-8?B?ZDRUTHErcndjYk5UVkZCbkdmMm5YOXE4RVdNSWlaVWRMZUdoamFtZnRWNy9r?=
 =?utf-8?B?VnZCQnFQMHQxUVlkMFIveDZCYXEzK1RubFBZTFE2ZzAyOUZvYkRFWEgzaG9r?=
 =?utf-8?B?Y09ydE43V1BuZm10L3ExMUtrb0pqSGpQSVdveEpjblVjd2pqZ0xwVnRmdTdI?=
 =?utf-8?B?Vm5yem1rWGZJbUlFdkRVa01PcWF5Q2pNYUFaSjRjeUlScU1pamtTeVpvaW1n?=
 =?utf-8?B?MEphMlplWXZvVkFOZXQxOVVuWUcwd014R3k2RHFhbmlNZmdrWVpXY2M1QmNN?=
 =?utf-8?B?SFl3K0d1RU5RRWNvSW1CeG1DYmpvWlF1bEs3SXZJOFVvclFTN2VkanZnY1dH?=
 =?utf-8?B?U3BtQ1liREVuT2g2UUhoWFkzekgydVZzYkt1Zm9HZGIrOHppT2dIQU5oMFFU?=
 =?utf-8?B?SzczeENlVkpsemdPL3M3ek1heXdGU3FkbGd1U29WZXFmSUdEdXhUYkN5eU4r?=
 =?utf-8?B?Y1VtM0srRzVJZy9nMFNucm5YVTdLWVdqQXhmd3RQNTNnVURPdWFKK2IrTGhP?=
 =?utf-8?B?aWJORVJ5OEkzNElhdXZaUGpQT0JNSTE4SE94WmtpcHpyWlhxOTFHSkU3QWlt?=
 =?utf-8?B?UXpQUURnck0zbjgvQU1SOTFHMGhrYU5YZzNyQ0I4V2oxVi96NHl1QllCbTVm?=
 =?utf-8?Q?bB/DLN02fmv6TKJOgAxQfBc1l?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33114330DD20CD4988052EBF356DF076@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c9b593-8d9f-42ed-ec3c-08da65bfae8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 17:38:36.7376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: okRcVGGzTPifaW7l0NqjvXBa6NV1TisdFcmusPX2usFdpXklwrRIPg8NuXNFeHWWb8CHVMhgOrT35usFOsjxNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5382
X-Proofpoint-GUID: 9jSdkRVRkZ1J8HK1DXqMPyvDtRBYg9DP
X-Proofpoint-ORIG-GUID: 9jSdkRVRkZ1J8HK1DXqMPyvDtRBYg9DP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-14_15,2022-07-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 clxscore=1011 priorityscore=1501 suspectscore=0 mlxscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207140076
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8xMi8yMDIyLCBXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+IExvY2FsIGludGVycnVwdHMgYXJl
IGN1cnJlbnRseSBiZWluZyBkaXNhYmxlZCBhcyBwYXJ0IG9mIGFxdWlyaW5nIHRoZQ0KPiBzcGlu
IGxvY2sgYmVmb3JlIGlzc3VpbmcgdGhlIGVuZHhmZXIgY29tbWFuZC4gIExlYXZlIGludGVycnVw
dHMgZW5hYmxlZCwgc28NCj4gdGhhdCBFUDAgZXZlbnRzIGNhbiBjb250aW51ZSB0byBiZSBwcm9j
ZXNzZWQuICBBbHNvLCBlbnN1cmUgdGhhdCB0aGVyZSBhcmUNCj4gbm8gcGVuZGluZyBpbnRlcnJ1
cHRzIGJlZm9yZSBhdHRlbXB0aW5nIHRvIGhhbmRsZSBhbnkgc29mdA0KPiBjb25uZWN0L2Rpc2Nv
bm5lY3QuDQo+DQo+IEZpeGVzOiA4NjFjMDEwYTJlZTEgKCJ1c2I6IGR3YzM6IGdhZGdldDogUmVm
YWN0b3IgcHVsbHVwKCkiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBXZXNsZXkgQ2hlbmcgPHF1aWNfd2No
ZW5nQHF1aWNpbmMuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIHwg
MjEgKysrKysrKysrKysrLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlv
bnMoKyksIDkgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2Mz
L2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBpbmRleCBhNDU1ZjhkNDYz
MWQuLmVlODViNzczZTNmZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQu
Yw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IEBAIC0xNjc0LDYgKzE2NzQs
NyBAQCBzdGF0aWMgaW50IF9fZHdjM19nYWRnZXRfZ2V0X2ZyYW1lKHN0cnVjdCBkd2MzICpkd2Mp
DQo+ICAgc3RhdGljIGludCBfX2R3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXIoc3RydWN0IGR3YzNf
ZXAgKmRlcCwgYm9vbCBmb3JjZSwgYm9vbCBpbnRlcnJ1cHQpDQo+ICAgew0KPiAgIAlzdHJ1Y3Qg
ZHdjM19nYWRnZXRfZXBfY21kX3BhcmFtcyBwYXJhbXM7DQo+ICsJc3RydWN0IGR3YzMgKmR3YyA9
IGRlcC0+ZHdjOw0KPiAgIAl1MzIgY21kOw0KPiAgIAlpbnQgcmV0Ow0KPiAgIA0KPiBAQCAtMTY4
Miw3ICsxNjgzLDkgQEAgc3RhdGljIGludCBfX2R3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXIoc3Ry
dWN0IGR3YzNfZXAgKmRlcCwgYm9vbCBmb3JjZSwgYm9vbCBpbnQNCj4gICAJY21kIHw9IGludGVy
cnVwdCA/IERXQzNfREVQQ01EX0NNRElPQyA6IDA7DQo+ICAgCWNtZCB8PSBEV0MzX0RFUENNRF9Q
QVJBTShkZXAtPnJlc291cmNlX2luZGV4KTsNCj4gICAJbWVtc2V0KCZwYXJhbXMsIDAsIHNpemVv
ZihwYXJhbXMpKTsNCj4gKwlzcGluX3VubG9jaygmZHdjLT5sb2NrKTsNCj4gICAJcmV0ID0gZHdj
M19zZW5kX2dhZGdldF9lcF9jbWQoZGVwLCBjbWQsICZwYXJhbXMpOw0KPiArCXNwaW5fbG9jaygm
ZHdjLT5sb2NrKTsNCj4gICAJV0FSTl9PTl9PTkNFKHJldCk7DQo+ICAgCWRlcC0+cmVzb3VyY2Vf
aW5kZXggPSAwOw0KPiAgIA0KPiBAQCAtMjAyOSwxMiArMjAzMiwxMSBAQCBzdGF0aWMgaW50IGR3
YzNfZ2FkZ2V0X2VwX2RlcXVldWUoc3RydWN0IHVzYl9lcCAqZXAsDQo+ICAgCXN0cnVjdCBkd2Mz
X2VwCQkJKmRlcCA9IHRvX2R3YzNfZXAoZXApOw0KPiAgIAlzdHJ1Y3QgZHdjMwkJCSpkd2MgPSBk
ZXAtPmR3YzsNCj4gICANCj4gLQl1bnNpZ25lZCBsb25nCQkJZmxhZ3M7DQo+ICAgCWludAkJCQly
ZXQgPSAwOw0KPiAgIA0KPiAgIAl0cmFjZV9kd2MzX2VwX2RlcXVldWUocmVxKTsNCj4gICANCj4g
LQlzcGluX2xvY2tfaXJxc2F2ZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+ICsJc3Bpbl9sb2NrKCZk
d2MtPmxvY2spOw0KPiAgIA0KPiAgIAlsaXN0X2Zvcl9lYWNoX2VudHJ5KHIsICZkZXAtPmNhbmNl
bGxlZF9saXN0LCBsaXN0KSB7DQo+ICAgCQlpZiAociA9PSByZXEpDQo+IEBAIC0yMDczLDcgKzIw
NzUsNyBAQCBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X2VwX2RlcXVldWUoc3RydWN0IHVzYl9lcCAq
ZXAsDQo+ICAgCQlyZXF1ZXN0LCBlcC0+bmFtZSk7DQo+ICAgCXJldCA9IC1FSU5WQUw7DQo+ICAg
b3V0Og0KPiAtCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiAr
CXNwaW5fdW5sb2NrKCZkd2MtPmxvY2spOw0KPiAgIA0KPiAgIAlyZXR1cm4gcmV0Ow0KPiAgIH0N
Cj4gQEAgLTI0ODksOSArMjQ5MSw3IEBAIHN0YXRpYyBpbnQgX19kd2MzX2dhZGdldF9zdGFydChz
dHJ1Y3QgZHdjMyAqZHdjKTsNCj4gICANCj4gICBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X3NvZnRf
ZGlzY29ubmVjdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgIHsNCj4gLQl1bnNpZ25lZCBsb25nIGZs
YWdzOw0KPiAtDQo+IC0Jc3Bpbl9sb2NrX2lycXNhdmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiAr
CXNwaW5fbG9jaygmZHdjLT5sb2NrKTsNCj4gICAJZHdjLT5jb25uZWN0ZWQgPSBmYWxzZTsNCj4g
ICANCj4gICAJLyoNCj4gQEAgLTI1MDYsMTAgKzI1MDYsMTAgQEAgc3RhdGljIGludCBkd2MzX2dh
ZGdldF9zb2Z0X2Rpc2Nvbm5lY3Qoc3RydWN0IGR3YzMgKmR3YykNCj4gICANCj4gICAJCXJlaW5p
dF9jb21wbGV0aW9uKCZkd2MtPmVwMF9pbl9zZXR1cCk7DQo+ICAgDQo+IC0JCXNwaW5fdW5sb2Nr
X2lycXJlc3RvcmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiArCQlzcGluX3VubG9jaygmZHdjLT5s
b2NrKTsNCj4gICAJCXJldCA9IHdhaXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCgmZHdjLT5lcDBf
aW5fc2V0dXAsDQo+ICAgCQkJCW1zZWNzX3RvX2ppZmZpZXMoRFdDM19QVUxMX1VQX1RJTUVPVVQp
KTsNCj4gLQkJc3Bpbl9sb2NrX2lycXNhdmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiArCQlzcGlu
X2xvY2soJmR3Yy0+bG9jayk7DQo+ICAgCQlpZiAocmV0ID09IDApDQo+ICAgCQkJZGV2X3dhcm4o
ZHdjLT5kZXYsICJ0aW1lZCBvdXQgd2FpdGluZyBmb3IgU0VUVVAgcGhhc2VcbiIpOw0KPiAgIAl9
DQo+IEBAIC0yNTIzLDcgKzI1MjMsNyBAQCBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X3NvZnRfZGlz
Y29ubmVjdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgIAkgKi8NCj4gICAJZHdjM19zdG9wX2FjdGl2
ZV90cmFuc2ZlcnMoZHdjKTsNCj4gICAJX19kd2MzX2dhZGdldF9zdG9wKGR3Yyk7DQo+IC0Jc3Bp
bl91bmxvY2tfaXJxcmVzdG9yZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+ICsJc3Bpbl91bmxvY2so
JmR3Yy0+bG9jayk7DQo+ICAgDQo+ICAgCS8qDQo+ICAgCSAqIE5vdGU6IGlmIHRoZSBHRVZOVENP
VU5UIGluZGljYXRlcyBldmVudHMgaW4gdGhlIGV2ZW50IGJ1ZmZlciwgdGhlDQo+IEBAIC0yNTY5
LDYgKzI1NjksOCBAQCBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X3B1bGx1cChzdHJ1Y3QgdXNiX2dh
ZGdldCAqZywgaW50IGlzX29uKQ0KPiAgIAkJcmV0dXJuIDA7DQo+ICAgCX0NCj4gICANCj4gKwlz
eW5jaHJvbml6ZV9pcnEoZHdjLT5pcnFfZ2FkZ2V0KTsNCj4gKw0KPiAgIAlpZiAoIWlzX29uKSB7
DQo+ICAgCQlyZXQgPSBkd2MzX2dhZGdldF9zb2Z0X2Rpc2Nvbm5lY3QoZHdjKTsNCj4gICAJfSBl
bHNlIHsNCj4gQEAgLTM3MjksNiArMzczMSw3IEBAIHZvaWQgZHdjM19zdG9wX2FjdGl2ZV90cmFu
c2ZlcihzdHJ1Y3QgZHdjM19lcCAqZGVwLCBib29sIGZvcmNlLA0KPiAgIAkgKi8NCj4gICANCj4g
ICAJX19kd2MzX3N0b3BfYWN0aXZlX3RyYW5zZmVyKGRlcCwgZm9yY2UsIGludGVycnVwdCk7DQo+
ICsNCj4gICB9DQo+ICAgDQo+ICAgc3RhdGljIHZvaWQgZHdjM19jbGVhcl9zdGFsbF9hbGxfZXAo
c3RydWN0IGR3YzMgKmR3YykNCg0KSGkgR3JlZywNCg0KUGxlYXNlIGRvbid0IHBpY2sgdXAgdGhp
cyBwYXRjaCB5ZXQuIFdlJ3JlIHN0aWxsIGluIGRpc2N1c3Npb24gd2l0aCANCnRoaXMuIEkgaGF2
ZSBzb21lIGNvbmNlcm4gd2l0aCB1bmxvY2tpbmcvbG9ja2luZyB3aGVuIHNlbmRpbmcgRW5kIA0K
VHJhbnNmZXIgY29tbWFuZC4gRm9yIGV4YW1wbGUsIHRoaXMgcGF0Y2ggbWF5IGNhdXNlIGlzc3Vl
cyB3aXRoIA0KRFdDM19FUF9FTkRfVFJBTlNGRVJfUEVORElORyBjaGVja3MuDQoNCkhpIFdlc2xl
eSwNCg0KRGlkIHlvdSB0cnkgb3V0IG15IHN1Z2dlc3Rpb24geWV0Pw0KDQpUaGFua3MsDQpUaGlu
aA0K
