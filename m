Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F61E5884E6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 01:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbiHBXvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 19:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiHBXvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 19:51:37 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C6A53D06;
        Tue,  2 Aug 2022 16:51:36 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 272JXxaH015739;
        Tue, 2 Aug 2022 16:51:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=frguV+4QikVcX1ur4o0l6hvbSxUXcl+ebr1jOg+Oof8=;
 b=bj5g1hO+Wn4nFqFu5FLVtJLtGwmXetbN7+boqk2goAzcoTlSlGU/HzFyR28Li/7NOGU8
 ZMrdXddWqtga/geqc1rbvT06S2BvgBWSUUnL2ApkulqmNMxfvR/p1zJb97A1UaF+7Eei
 9mlN5JSi76gmRowtKed1k4L+TaIRaX0virOEvdDSmEcHRjOEhMHA0wqTKbBVI3CG0jEM
 voiS6rFAUwQnF+ryWiaa24JXeqDhgMsTSNECLeX2hHJFy0ko/Si0/47B7i5GWiwx1AqM
 LlDFibbqi6g1zj2iFeartZKLegAwLsQW+KdyydIhKEg+ZuHA94MvDb2QG1C8FrezaeFi BA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3hn3jurw1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Aug 2022 16:51:27 -0700
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8BBFC40094;
        Tue,  2 Aug 2022 23:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1659484286; bh=frguV+4QikVcX1ur4o0l6hvbSxUXcl+ebr1jOg+Oof8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=V8HyOi2bTYufOe0ekfkAphPhO8UbqJr9JyN+F4q4lKVmtQWP/WsrsU4n0h16gIvk5
         jAZQSVptZkN1X89mhL9TVSNqP4AWxDb5utosnOTxIPzqh7VUBPFpksn1ur8hLS7yMW
         poISzxGrkryR4ZwxeTPhZ1jwzeqDace+LgI0v78PD9NxuqW12B5pAeobvDn6N+Ht0S
         BSpQ3QNjVzB9pXcohraN3mM8QUoMOEKatvHpRlzZd6Kfkc9ekUNtUFSfS1dddAAXlz
         wv5Joc8AnOfWjaDDlxnSjKp0vybbE0W1e5chNCLPsh7xeJ8fBdMzbKTg8xfcOCKEj6
         8l11DxA3D+/Vg==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id D62E2A0071;
        Tue,  2 Aug 2022 23:51:24 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5C243800E7;
        Tue,  2 Aug 2022 23:51:15 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="wV2kCZG5";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHjWHlZt7Z1MSUEbmfeKkNd8fNDq76RJNPscTQ23aGO7XdvmSGfrnM4yAXwCA+6x7X8KFiwKH9uR6lH+DzS638y7ApoZUaag0vZ6R00aP4B29Qy6DitLI1aYDhj1OuStm3oObDB6ksy+t1p+osGEmRomp6OuW//NL9u90f3ifmqbNweauWxeM9if2hb+6xW4MeNQo+5xvY7tFBwaMnjfS2lPewC/PRBM5hW40er1PH/H0VFu52B6351M4aT5bTfemZkbfNtSlhWQ8fnHbNQEKzHH+GtJKq6qdkFNUWygou6PG/gpi/6mD4Ka7nEMBdbR7q8miANtrdDdm7hiuGLwMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frguV+4QikVcX1ur4o0l6hvbSxUXcl+ebr1jOg+Oof8=;
 b=PuUeTdg0l1PSI+xXrTAnFLMOzEy1yjIpo/j1TVFVqXguhd0NWhfKCTPpPwDeI4UZNe3e3AoCT2xA6XsJJNrT7vaN4ogZDpiQ4kwThX7bVKGiY82Qqi4pS57shU0jGf1ZPevBtbW2ETdqmgR7JBVZdnCIH/zGJdL+r5tcqeqXgF55AZoxrB7qMtP4I44y8W+Wtd61r6tPJ5SgZPvnHoUvmsEK9Te+TWktWvy5T3BLfjC99eDwI3s0U6RGqEgduFx/6KPdFN4OzLlVwDhL2dTqVs4D7YnT0FvRBgv7gDL6MEAFKU2jZTVC40uizbrdYvjaA9nydpTxxcf36k1CBKFt9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frguV+4QikVcX1ur4o0l6hvbSxUXcl+ebr1jOg+Oof8=;
 b=wV2kCZG5fjHMZoxDe83G+nbwIKSL47FqFo29YPYEIejgCHd14kaRdWwRrCso/eJwCGFM/uhdUK9H9RLOHBjaCuNUte83w88+2aBzK0OqsFsQ9as2/3Savt49tnaF8X1H7qsTIjPA9mcQy/Z1PegwkJPG2djJ1UBec3jN9S6yjp0=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Tue, 2 Aug
 2022 23:51:12 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c%7]) with mapi id 15.20.5482.014; Tue, 2 Aug 2022
 23:51:11 +0000
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
Subject: Re: [PATCH 2/5] usb: gadget: Add function wakeup support
Thread-Topic: [PATCH 2/5] usb: gadget: Add function wakeup support
Thread-Index: AQHYpqSxYg+mSBtinkWEjfftWY3s8a2cSDKA
Date:   Tue, 2 Aug 2022 23:51:11 +0000
Message-ID: <049219f1-8c68-e4cc-7bf9-1e8c214e80aa@synopsys.com>
References: <1659467920-9095-1-git-send-email-quic_eserrao@quicinc.com>
 <1659467920-9095-3-git-send-email-quic_eserrao@quicinc.com>
In-Reply-To: <1659467920-9095-3-git-send-email-quic_eserrao@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 094fbefd-1885-48fa-3cda-08da74e1e109
x-ms-traffictypediagnostic: MN2PR12MB4373:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K8+CLKShowD0BI+2Z03vV6niJOggnpPV5cPLbfeqOrLa+6oavIn4AfTn95k8QPHJBAsSKt3hmwjB+eMtTKQQDq6umzVDoxJl23jRXgCG7+UUsj9vO7klItq8kxcpG9y3LnsoiyKSAATPoKhWougzE8XBXs0NsDuogDrv0ATlnsLsa6iBfh07vpnYH49fV/btLDWNgTOzi6v6L323EG2ou4xrlBIWghe6Q5tWW2AVZWer/hK21HBB2kT2ckaIP+KucoqhqHiXvLbB2x/3Awt8QC8AyeQPknBsC1UXGom8WbnTBt1TAJf2EFu/tKsqbCGWhFl2m5ONJoymbXnnehHqXjAZeSJcotwiVAS/p2oYe8vMEJPh0fkLI/gq2A+WSRr2KYA6AO3L2tnx8iSW4ronzUcN2U8VJjmA0L+WjSkxV0cu9dcYCz+31X3Bd/K01Tef6bC43fE3f0fQkYNwnTrNCF/Nri6U/2hh4U1O9K0t21keG/yGI+kZk33Xs54eyFW4C08b2z3TYAqL+vj+s+yyA2yVG2lxjcT3jWhtq8qottV5YMorahZPCXp2/7xK5y2zpaZpVMXMmMLUyJrgti3tN4jDqgnq4BmeiDChbw8GWU38m6khmYUQGLfiCWRlbi8Wb6QXh6bjxlS4d2Pm2JJ3E0/F92T8o5mlnKgSfsFfK1tBRujv0fg6j5qNFC9INzGXYMR5/VWGnY/aiS6i7YO5SCxeYVrStojDXSAGwPScUK0TXDMiTqDtwKkuka7kJmCDJ2Gua4OvPRM3mKXZ6VAgzrsu8tDhr7mJkk9K9xKsQ2fULOPDw/LpQK+rXTj+IMHOxIPvf/AT7qqzhHPSHCu/pH8WJbQZWKOpD2L4cIWm24MVhxzNGsg+5vREj5DELDjm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(366004)(376002)(346002)(396003)(38100700002)(107886003)(122000001)(2616005)(6506007)(36756003)(31686004)(26005)(6512007)(38070700005)(110136005)(83380400001)(2906002)(41300700001)(5660300002)(54906003)(4326008)(66446008)(66556008)(8676002)(8936002)(66946007)(316002)(71200400001)(66476007)(76116006)(31696002)(86362001)(6486002)(64756008)(478600001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGFxb3ZhdlBLVGh2aHVWd2Y3cTFqYnBjQk95Y044WGgrVU5qNDZBMWR0cDNL?=
 =?utf-8?B?YkMrb3phMDdDeno5RXN3a1NrNTdmM2UyVWpCTlp1UVpGNmRWL1FTVHNoQkpM?=
 =?utf-8?B?Y252R0wyaFZDZmhIQ3pQZG1HSmNMall6NWdCeUVjVXJVT0JZTmhaeWJZWFMv?=
 =?utf-8?B?Nk1oZTA5dmRjc2hLSnJBdkE3YUltS1JuRENYL2hTY3A1ZENBSC9oL0lrM1Nh?=
 =?utf-8?B?bHhNVkxHVS8wZmNiWVZCSTJEQzlrSGY5YzAyUVJhcFpSaiszcWlTWlZMTXJr?=
 =?utf-8?B?M2EzRnRVZ3Z0TzBYVGVBYjBpSHZXM3k5SEh1SEVKejNRR1hsb29YNHVxc1hU?=
 =?utf-8?B?ZzVGTHpHeHp3d29KRGpvYlM0aFNya0o5OGEzdXhCV2RjYjZ1aU9GUW8ySjZI?=
 =?utf-8?B?VVR1azVMU2xJUHd1dkNUK243dGJNUzBtRDRBNkdBYU1BM1dZYUNRSjlCaDVS?=
 =?utf-8?B?YTVSVElKMlk1ZnJIMHpkQUJ1aXFpeko4eTgyaGx5SkN3bjM3OGxUdklhcjZi?=
 =?utf-8?B?WDhIQXNMd1NzRlpjVFRjbTVjTmJ2cC8reURLOE5UNWVOMHZuTHNuQ2ZlcmV1?=
 =?utf-8?B?SXVCaDJwT2NiZFhTZDArZytpMkc4TlRRM3pVTkc1Qmk5eGZyczJ2R3o3a0ZU?=
 =?utf-8?B?V0taMEhETkdPMXpCNWpZVjNCcmxnT0d4L3dHWEtSTmd6ay95ZEhWK1N2bEd0?=
 =?utf-8?B?SldRaktnazdFZmdPTE5lZUFyR3Q1d0hkbFFxbmRwZEpQbXZpeDJpWkYzSUpE?=
 =?utf-8?B?RWZGdGlCeWUwdWd2SW1kOHMvTW1oTjRLZ2JrMGx5Tm5HZ1lTLzF5bk92UlM4?=
 =?utf-8?B?a1F1S1RPd3NURjI4TExnRXF6MEx0QkhjeUtmdkp2VkJiT2NCWkdFRmVEU1Mw?=
 =?utf-8?B?NVFEVWgzd1gwQ3RZaTMxbXFOVm9OOHlOcmJOTy9Ta005ZUtmeUNzRmc4L2xX?=
 =?utf-8?B?SzlwYzFERTNNYkhhYllOenNVbURoT040N1l3Wnc3VHdkeDRPRllmc2pGT2Yy?=
 =?utf-8?B?bUxBNTNlNGtrOWptMVZpenNoNVN4YnVrUCt1WFV2YU5CMlMvdWEyaVZUbEVM?=
 =?utf-8?B?VkE3Q05TaWFKK0Nqa2NhZkljZjR2ZWtxR3UyT2RBVjdlRUp0Y1lXNG9Ub3dv?=
 =?utf-8?B?WGZqR1hrWWVxcDJYa0xZVlh0Z3JscVg5U0VvaFFEckd2SGcvKzNkbWI4KzFT?=
 =?utf-8?B?Tk1PQ2xXaklnZ1l4em11cVdhSVJJbVNhU2tuYUh0MUkzekc4cElWeUEvVERz?=
 =?utf-8?B?SjFITkNBSWpab2dSTjlCOXRxcUc0Wlc3ZnFBSnRRZEIwdXFqVjlkNjRTUE8r?=
 =?utf-8?B?RVpUalVZVjJuRFYwSkNmNmRrS1RTWFpDa1hjcWw1VWF6T2s5S1F3VUJaT0wv?=
 =?utf-8?B?ZVdNUi9sc0g4a0kxdmpOaFpFcXRmUkVFdUZ5K2JGN1J1OEZpenFFcUNVTllR?=
 =?utf-8?B?cDlGVjl0Y2JpUzNxdjhEMS9yUEhvZ3RKamdoLzVEYW0rSUo4MGc5SnJMS1JG?=
 =?utf-8?B?ZmhNYkJRNm5VN2tZNEJaRklreXdmeExzREdweGhpVHB0VGdGaWNWbzZ5SEJ3?=
 =?utf-8?B?QU5IT1pRNDgyL2YydWlEblExK0krRGxjQkJRQjZHVHVMb0tBT0ttbjBRT1Aw?=
 =?utf-8?B?T3kvYWhkajdwVnRpNEFCVWp2OTdobmlhVTZoYWp4cEVOMHlVRGUyRVVWMEhn?=
 =?utf-8?B?Wi9WTW1laFowZUpGVXNwWjBWUmROYlpsZWF2eW9ySXk2SWNyeGIvelQzNGNL?=
 =?utf-8?B?cEZVRUNJNjQwb2k5c29halhQdFJHQ0dZVmEvZ0RaQ3dDc0tjV1ZWNk9CRlcx?=
 =?utf-8?B?K3o5aXMwRmxaK3ptckJzZTVraTFMaEZhWk5Bd3p0Ykx2NGN3Q2V3c0c3MUs0?=
 =?utf-8?B?ZXFTZjM3bFBpendvcHpRU0lQRlk4b2crc0lqcHB4UmYxcDBtMUFxTDVoT3Bw?=
 =?utf-8?B?ZnY1cEZ3ZVYwN2xzNXZqS21KMTR3QjBreGVaK3ZFODUxa1d1dENtaTdiZDNl?=
 =?utf-8?B?RFIyTDQ3OU1lY2tVOXZpQzh2MnNPaytyamhMUTJpODByYUVFU3daYjloUG5o?=
 =?utf-8?B?YzZnK2ZiMEh3c01MYmY2TjBkK3NPRnc3N3pRTE9xb2hDNFNObkNjY25INVJ4?=
 =?utf-8?Q?8f0XzqH3AydubF7WeA7zPbDdL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <315A92262319A740B999C61A927826C5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 094fbefd-1885-48fa-3cda-08da74e1e109
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 23:51:11.7976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /rmTMoKw2WH2MDRM1sdDB/YCXxLWXFha+dtdQmOsoKBXZKFWfpiow7eefCwwAfPDRQtg5bybUKsqJZX4Ymw5FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373
X-Proofpoint-GUID: FawgAtRybynnKNCudtQDY2VXwntSIaFH
X-Proofpoint-ORIG-GUID: FawgAtRybynnKNCudtQDY2VXwntSIaFH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_15,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=663 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2208020113
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8yLzIwMjIsIEVsc29uIFJveSBTZXJyYW8gd3JvdGU6DQo+IEFuIGludGVyZmFjZSB3aGlj
aCBpcyBpbiBmdW5jdGlvbiBzdXNwZW5kIHN0YXRlIGhhcyB0byBzZW5kIGEgZnVuY3Rpb24NCj4g
d2FrZXVwIG5vdGlmaWNhdGlvbiB0byB0aGUgaG9zdCBpbiBjYXNlIGl0IG5lZWRzIHRvIGluaXRh
dGUgYW55IGRhdGENCj4gdHJhbnNmZXIuIE9uZSBub3RhYmxlIGRpZmZlcmVuY2UgYmV0d2VlbiB0
aGlzIGFuZCB0aGUgZXhpc3RpbmcgcmVtb3RlDQo+IHdha2V1cCBtZWNoYW5pc20gaXMgdGhhdCB0
aGlzIGNhbiBiZSBjYWxsZWQgcGVyLWludGVyZmFjZSwgYW5kIGEgVURDDQo+IHdvdWxkIG5lZWQg
dG8ga25vdyB0aGUgcGFydGljdWxhciBpbnRlcmZhY2UgbnVtYmVyIHRvIGNvbnZleSBpbiBpdHMN
Cj4gRGV2aWNlIE5vdGlmaWNhdGlvbiB0cmFuc2FjdGlvbiBwYWNrZXQuICBIZW5jZSwgd2UgbmVl
ZCB0byBpbnRyb2R1Y2UNCj4gYSBuZXcgY2FsbGJhY2sgaW4gdGhlIGdhZGdldF9vcHMgc3RydWN0
dXJlIHRoYXQgVURDIGRldmljZSBkcml2ZXJzDQo+IGNhbiBpbXBsZW1lbnQuICBTaW1pbGFybHkg
YWRkIGEgY29udmVuaWVuY2UgZnVuY3Rpb24gaW4gdGhlIGNvbXBvc2l0ZQ0KPiBkcml2ZXIgd2hp
Y2ggZnVuY3Rpb24gZHJpdmVycyBjYW4gY2FsbC4gQWRkIHN1cHBvcnQgdG8gaGFuZGxlIHN1Y2gN
Cj4gcmVxdWVzdHMgaW4gdGhlIGNvbXBvc2l0ZSBsYXllciBhbmQgaW52b2tlIHRoZSBnYWRnZXQg
b3AuDQoNClNlbmRpbmcgdGhlIGZ1bmN0aW9uIHdha2Ugbm90aWZpY2F0aW9uIHNob3VsZCBiZSBk
b25lIGluIHRoZSBjb250cm9sbGVyIA0KZHJpdmVyLiBUaGUgY29udHJvbGxlciBkcml2ZXIga25v
d3Mgd2hlbiBpcyB0aGUgcHJvcGVyIGxpbmsgc3RhdGUgDQooVTAvT04pIHRoZSBkZXZpY2UgaXMg
aW4gYW5kIHdvdWxkIG5vdGlmeSB0aGUgaG9zdCB0aGVuLg0KDQpXaGF0IHdlIG5lZWQgdG8gYWRk
IGluIHRoZSB1c2JfZ2FkZ2V0IGlzIHdoZXRoZXIgdGhlIGRldmljZSBpcyByZW1vdGUgDQp3YWtl
dXAgY2FwYWJsZS4gU29tZXRoaW5nIGxpa2UgYSBmbGFnIHVzYl9nYWRnZXQtPnJ3X2NhcGFibGUu
DQoNCldlIHdvdWxkIGFsc28gbmVlZCBzb21lIGZ1bmN0aW9ucyBsaWtlIHVzYl9nYWRnZXRfZW5h
YmxlX3JlbW90ZV93YWtldXAoKSANCmFuZCB1c2JfZ2FkZ2V0X2Rpc2FibGVfcmVtb3RlX3dha2V1
cCgpIGZvciB0aGUgZ2FkZ2V0IGRyaXZlciB0byBub3RpZnkgDQp0aGUgY29udHJvbGxlciBkcml2
ZXIgd2hlbiBpdCBjaGVja3MgYWdhaW5zdCBVU0JfQ09ORklHX0FUVF9XQUtFVVAgaW4gDQp0aGUg
Ym1BdHRyaWJ1dGVzIGNvbmZpZ3VyYXRpb24uDQoNCkJSLA0KVGhpbmgNCg0KPiBTaWduZWQtb2Zm
LWJ5OiBFbHNvbiBSb3kgU2VycmFvIDxxdWljX2VzZXJyYW9AcXVpY2luYy5jb20+DQo+IC0tLQ0K
PiAgIGRyaXZlcnMvdXNiL2dhZGdldC9jb21wb3NpdGUuYyB8IDMyICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrDQo+ICAgZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9jb3JlLmMgIHwgIDkg
KysrKysrKysrDQo+ICAgaW5jbHVkZS9saW51eC91c2IvY29tcG9zaXRlLmggIHwgIDEgKw0KPiAg
IGluY2x1ZGUvbGludXgvdXNiL2dhZGdldC5oICAgICB8ICAyICsrDQo+ICAgNCBmaWxlcyBjaGFu
Z2VkLCA0NCBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRn
ZXQvY29tcG9zaXRlLmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvY29tcG9zaXRlLmMNCj4gaW5kZXgg
NDAzNTYzYy4uNmJkY2UyMyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L2NvbXBv
c2l0ZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC9jb21wb3NpdGUuYw0KPiBAQCAtNDkw
LDYgKzQ5MCwzOCBAQCBpbnQgdXNiX2ludGVyZmFjZV9pZChzdHJ1Y3QgdXNiX2NvbmZpZ3VyYXRp
b24gKmNvbmZpZywNCj4gICB9DQo+ICAgRVhQT1JUX1NZTUJPTF9HUEwodXNiX2ludGVyZmFjZV9p
ZCk7DQo+ICAgDQo+ICtpbnQgdXNiX2Z1bmNfd2FrZXVwKHN0cnVjdCB1c2JfZnVuY3Rpb24gKmZ1
bmMpDQo+ICt7DQo+ICsJaW50IHJldCwgaWQ7DQo+ICsJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4g
Kw0KPiArCWlmICghZnVuYyB8fCAhZnVuYy0+Y29uZmlnIHx8ICFmdW5jLT5jb25maWctPmNkZXYg
fHwNCj4gKwkgICAgIWZ1bmMtPmNvbmZpZy0+Y2Rldi0+Z2FkZ2V0KQ0KPiArCQlyZXR1cm4gLUVJ
TlZBTDsNCj4gKw0KPiArCURCRyhmdW5jLT5jb25maWctPmNkZXYsICIlcyBmdW5jdGlvbiB3YWtl
dXBcbiIsIGZ1bmMtPm5hbWUpOw0KPiArDQo+ICsJc3Bpbl9sb2NrX2lycXNhdmUoJmZ1bmMtPmNv
bmZpZy0+Y2Rldi0+bG9jaywgZmxhZ3MpOw0KPiArDQo+ICsJZm9yIChpZCA9IDA7IGlkIDwgTUFY
X0NPTkZJR19JTlRFUkZBQ0VTOyBpZCsrKQ0KPiArCQlpZiAoZnVuYy0+Y29uZmlnLT5pbnRlcmZh
Y2VbaWRdID09IGZ1bmMpDQo+ICsJCQlicmVhazsNCj4gKw0KPiArCWlmIChpZCA9PSBNQVhfQ09O
RklHX0lOVEVSRkFDRVMpIHsNCj4gKwkJRVJST1IoZnVuYy0+Y29uZmlnLT5jZGV2LCAiSW52YWxp
ZCBmdW5jdGlvbiBpZDolZFxuIiwgaWQpOw0KPiArCQlyZXQgPSAtRUlOVkFMOw0KPiArCQlnb3Rv
IGVycjsNCj4gKwl9DQo+ICsNCj4gKwlyZXQgPSB1c2JfZ2FkZ2V0X2Z1bmNfd2FrZXVwKGZ1bmMt
PmNvbmZpZy0+Y2Rldi0+Z2FkZ2V0LCBpZCk7DQo+ICsNCj4gK2VycjoNCj4gKwlzcGluX3VubG9j
a19pcnFyZXN0b3JlKCZmdW5jLT5jb25maWctPmNkZXYtPmxvY2ssIGZsYWdzKTsNCj4gKw0KPiAr
CXJldHVybiByZXQ7DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9MKHVzYl9mdW5jX3dha2V1cCk7DQo+
ICsNCj4gICBzdGF0aWMgdTggZW5jb2RlX2JNYXhQb3dlcihlbnVtIHVzYl9kZXZpY2Vfc3BlZWQg
c3BlZWQsDQo+ICAgCQlzdHJ1Y3QgdXNiX2NvbmZpZ3VyYXRpb24gKmMpDQo+ICAgew0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9nYWRn
ZXQvdWRjL2NvcmUuYw0KPiBpbmRleCA3ODg2NDk3Li5mZTVjNTA0IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL3VzYi9nYWRnZXQvdWRjL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQv
dWRjL2NvcmUuYw0KPiBAQCAtODE2LDYgKzgxNiwxNSBAQCBpbnQgdXNiX2dhZGdldF9hY3RpdmF0
ZShzdHJ1Y3QgdXNiX2dhZGdldCAqZ2FkZ2V0KQ0KPiAgIH0NCj4gICBFWFBPUlRfU1lNQk9MX0dQ
TCh1c2JfZ2FkZ2V0X2FjdGl2YXRlKTsNCj4gICANCj4gK2ludCB1c2JfZ2FkZ2V0X2Z1bmNfd2Fr
ZXVwKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnYWRnZXQsIGludCBpbnRlcmZhY2VfaWQpDQo+ICt7DQo+
ICsJaWYgKGdhZGdldC0+c3BlZWQgPCBVU0JfU1BFRURfU1VQRVIgfHwgIWdhZGdldC0+b3BzLT5m
dW5jX3dha2V1cCkNCj4gKwkJcmV0dXJuIC1FT1BOT1RTVVBQOw0KPiArDQo+ICsJcmV0dXJuIGdh
ZGdldC0+b3BzLT5mdW5jX3dha2V1cChnYWRnZXQsIGludGVyZmFjZV9pZCk7DQo+ICt9DQo+ICtF
WFBPUlRfU1lNQk9MX0dQTCh1c2JfZ2FkZ2V0X2Z1bmNfd2FrZXVwKTsNCj4gKw0KPiAgIC8qIC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0gKi8NCj4gICANCj4gICAjaWZkZWYJQ09ORklHX0hBU19ETUENCj4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdXNiL2NvbXBvc2l0ZS5oIGIvaW5jbHVkZS9saW51eC91
c2IvY29tcG9zaXRlLmgNCj4gaW5kZXggOWQyNzYyMi4uMzFiMzVkNyAxMDA2NDQNCj4gLS0tIGEv
aW5jbHVkZS9saW51eC91c2IvY29tcG9zaXRlLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC91c2Iv
Y29tcG9zaXRlLmgNCj4gQEAgLTI1NCw2ICsyNTQsNyBAQCBpbnQgY29uZmlnX2VwX2J5X3NwZWVk
X2FuZF9hbHQoc3RydWN0IHVzYl9nYWRnZXQgKmcsIHN0cnVjdCB1c2JfZnVuY3Rpb24gKmYsDQo+
ICAgDQo+ICAgaW50IGNvbmZpZ19lcF9ieV9zcGVlZChzdHJ1Y3QgdXNiX2dhZGdldCAqZywgc3Ry
dWN0IHVzYl9mdW5jdGlvbiAqZiwNCj4gICAJCQlzdHJ1Y3QgdXNiX2VwICpfZXApOw0KPiAraW50
IHVzYl9mdW5jX3dha2V1cChzdHJ1Y3QgdXNiX2Z1bmN0aW9uICpmdW5jKTsNCj4gICANCj4gICAj
ZGVmaW5lCU1BWF9DT05GSUdfSU5URVJGQUNFUwkJMTYJLyogYXJiaXRyYXJ5OyBtYXggMjU1ICov
DQo+ICAgDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3VzYi9nYWRnZXQuaCBiL2luY2x1
ZGUvbGludXgvdXNiL2dhZGdldC5oDQo+IGluZGV4IDNhZDU4YjcuLjc2ZjlkZTQgMTAwNjQ0DQo+
IC0tLSBhL2luY2x1ZGUvbGludXgvdXNiL2dhZGdldC5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgv
dXNiL2dhZGdldC5oDQo+IEBAIC0zMTEsNiArMzExLDcgQEAgc3RydWN0IHVzYl91ZGM7DQo+ICAg
c3RydWN0IHVzYl9nYWRnZXRfb3BzIHsNCj4gICAJaW50CSgqZ2V0X2ZyYW1lKShzdHJ1Y3QgdXNi
X2dhZGdldCAqKTsNCj4gICAJaW50CSgqd2FrZXVwKShzdHJ1Y3QgdXNiX2dhZGdldCAqKTsNCj4g
KwlpbnQJKCpmdW5jX3dha2V1cCkoc3RydWN0IHVzYl9nYWRnZXQgKmdhZGdldCwgaW50IGludGVy
ZmFjZV9pZCk7DQo+ICAgCWludAkoKnNldF9zZWxmcG93ZXJlZCkgKHN0cnVjdCB1c2JfZ2FkZ2V0
ICosIGludCBpc19zZWxmcG93ZXJlZCk7DQo+ICAgCWludAkoKnZidXNfc2Vzc2lvbikgKHN0cnVj
dCB1c2JfZ2FkZ2V0ICosIGludCBpc19hY3RpdmUpOw0KPiAgIAlpbnQJKCp2YnVzX2RyYXcpIChz
dHJ1Y3QgdXNiX2dhZGdldCAqLCB1bnNpZ25lZCBtQSk7DQo+IEBAIC02MTIsNiArNjEzLDcgQEAg
aW50IHVzYl9nYWRnZXRfZGlzY29ubmVjdChzdHJ1Y3QgdXNiX2dhZGdldCAqZ2FkZ2V0KTsNCj4g
ICBpbnQgdXNiX2dhZGdldF9kZWFjdGl2YXRlKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnYWRnZXQpOw0K
PiAgIGludCB1c2JfZ2FkZ2V0X2FjdGl2YXRlKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnYWRnZXQpOw0K
PiAgIGludCB1c2JfZ2FkZ2V0X2NoZWNrX2NvbmZpZyhzdHJ1Y3QgdXNiX2dhZGdldCAqZ2FkZ2V0
KTsNCj4gK2ludCB1c2JfZ2FkZ2V0X2Z1bmNfd2FrZXVwKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnYWRn
ZXQsIGludCBpbnRlcmZhY2VfaWQpOw0KPiAgICNlbHNlDQo+ICAgc3RhdGljIGlubGluZSBpbnQg
dXNiX2dhZGdldF9mcmFtZV9udW1iZXIoc3RydWN0IHVzYl9nYWRnZXQgKmdhZGdldCkNCj4gICB7
IHJldHVybiAwOyB9DQoNCg==
