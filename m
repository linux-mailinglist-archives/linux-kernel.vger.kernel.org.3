Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57ED5A2F0C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240138AbiHZSqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345335AbiHZSpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:45:39 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795A0F14D0;
        Fri, 26 Aug 2022 11:42:02 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QG5hrM023666;
        Fri, 26 Aug 2022 11:41:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=9XW3zo+Y8R9B/ToIG7upjfwklsRo1lUmgJHbyG3pBaY=;
 b=B1UOSLsu82hpAD7xPvFdp6lf7WefYF/2Kj2OE2kR4IkdO2FWmliZFwBab5h8Ki7HVQUS
 +BaNHcTS8fbJTT50+2bDzRqLZGf8hVOTAbfXJOZvATgHcnF2s6VKqAiaGSKp4y/7FVOB
 MnafQPIdiWdatV8Q5BrJCVgI5MgyqTNrtpFK9TOqu6JDf9JCFrXE+7D7g4hxBUOowkDp
 hGLPkkebnrNxCy8lrRN1KuJe61L+OOumy50e2fpIX6CrqgI90B7Bqe/ZWXQ8avlJNGxf
 3ma+wPS/gm+hxntUSkO57nBzYWG9knQ0p97TjZrJVzXdgCkYdBMkmuDmpz26kPVMCCzA dQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3j51x05vuy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 11:41:33 -0700
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D226C40083;
        Fri, 26 Aug 2022 18:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1661539292; bh=9XW3zo+Y8R9B/ToIG7upjfwklsRo1lUmgJHbyG3pBaY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=cWLdvzezAgMhAoR/NT/jGQ90UcBMqfUMGi8dBtqacr6YNPe3QXfWUlh9ouvWmAE2x
         /Lbf0EoVKhMgCIHq+XNdcTO9GKkyeNbXfHLZOD+KWjzu3ZsjPRLrz2SKEis2oXXsed
         oXfrPd5GlHwTWnm5gnZfN9xGnrw6z7/B4bVWhPDci2gTCJT+EHe9574xlWkq2yL6yL
         VaCWDUHuV3IhMMOs1AtfoAB1J7HicvTUjQ33KfhU4U5++Y20KF+YUsaDMYTS49s/nG
         CmbB7PTJZrkEDb3zo7gctf6iUVjXQj4rrBYIo3Qpc4bWkqd0A4K1ApJhFacNIeq/nL
         tfn2OMzABjaeg==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 8E372A009F;
        Fri, 26 Aug 2022 18:41:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id C82184006C;
        Fri, 26 Aug 2022 18:41:30 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="HxqtHlJK";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBAylPYwR/jO+VyI6ABZl8cocA1rSApwjc3Edy8ee6x5He1OdJMwN2lKXk9I69ywrRP34PocG1BM8XzCjDVhTVtpMz6384wP4eSOH0AcVFFt6kvcC7T0G7sNOyVDr5T+tychTAp0XQpjfQcNrurfSTQKiQ1RdeXluaBSr3MFmG8QLFdm1tgRYx3dTnZEN8ciBaLJgQvTzqSpKvrvitisoOGv1G18n7EmJOglQnwHHaJ+v5Qg4qMDt1n1EjDgNn8q5mfAkP3oYo7lLsNgDbXXs25zLxcXmowXuaIMn3sIMkdu+hCHMqFCDF6+ieO8zXPdyb8POcmqkG7nwjl1qPA7Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XW3zo+Y8R9B/ToIG7upjfwklsRo1lUmgJHbyG3pBaY=;
 b=CEPzy5N5Xz+apdoYHhj63dASu9FrarW73aVQmLd70Yj9djSILgewS0YkCVMqNrhnLvg1jhb0R0jP1+mTooZt3BkP6gXdimuz2C+ixvDqPAky8uziG4qsgLzqmyeNgdEKpUEHxjgXeGssChuqIYOMV8mS1ENl2ruHmQlHj2UQKMWSFRnX8zn4zUVWr26UYPcgrcHbVYlzPk2+bPWgG/J7HVHHExc+r52Cuin/n8fIA6zOaOSciowP88rvPOKSLqMPqRbiPsM+TJYdFuGFosNUZ9g3dy8q3CJAr/GsYaEE/0LMw3aU1gHjy9S6GI3HYcK0y2ELM8gHuxNYDh11VQ7ikg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XW3zo+Y8R9B/ToIG7upjfwklsRo1lUmgJHbyG3pBaY=;
 b=HxqtHlJK4RbE0QjuYB5Hp1vKJjDIvzbKv2ajNqBZVeEZnjoln6AEBBm4tRon6SBLlqK1myeRR2IHAv224Dq5vvsvxNa3/zbG0uzSA1qd9d/hHctW2auieXrYeHl6TT1ne1vChKxOEljusrpYeKaYQxbllBSO8QfA9qVuJWaRbcU=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by IA1PR12MB6578.namprd12.prod.outlook.com (2603:10b6:208:3a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 18:41:27 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::69ee:633:f068:3ca1]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::69ee:633:f068:3ca1%3]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 18:41:26 +0000
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
Subject: Re: [PATCH v2 15/25] usb: gadget: f_tcm: Cleanup unused variable
Thread-Topic: [PATCH v2 15/25] usb: gadget: f_tcm: Cleanup unused variable
Thread-Index: AQHYmw6+VKnOh/rEiUCj4Md+Xqr9x63BAdIAgAC+74A=
Date:   Fri, 26 Aug 2022 18:41:26 +0000
Message-ID: <20220826184121.zxq5immjoicvrqvq@synopsys.com>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
 <420c91967948fb8e7c758ed0857c708b3b070d72.1658192351.git.Thinh.Nguyen@synopsys.com>
 <YwhzppXwheosXCaL@linutronix.de>
In-Reply-To: <YwhzppXwheosXCaL@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d28a4f75-f657-4bb1-11f6-08da87929580
x-ms-traffictypediagnostic: IA1PR12MB6578:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MGBFtD5bgcULhqkT2csXu6sZrWBG1rb56A5ssC373QXXoEZ0gz94sE7VhVNJgomohDABQjeiupRkKFEtNVdQJQCrnpr6JcTfa0PQUMrUZTvsbkAHpm11jxjC1Dkvv15aimWr7r1MjisdSI9hSR8rsiHAJdrMxvPB6f62KdFTP4z3WY6DhIZEorqmnxET7ZJwvCgpoq00atEgqNYmnuggDYe04Bs6CYQjgLyMQV4CR7vvgwCJ0TclXhqKBsWk0smhjkylrvw2nparaw+szlmHOgkByHqkMKRXBb5mwWUnbAxKZ5qV0WovOecwVYJvpLTxbR816/wZitXLXNuXqiJEDe0jrkwmophXNiXy9mKh8Xn+vCvZ0U0+5/WzDhhBabT5/M422s3fxnmqWFXdRgDtX93iNvhrQmSJ+bKLf1nkmJH55EoxNTFXqAVXiFcCsvtS3oGXPShsP900iezu6ZnvYvOxd4y7YBAdG8vIEucWQ+3ZQCsbvzZzvbQYvbKoloob1lScID++V94qYDXVpod5kD+9h12epOMURPqs/41TrttnCweMdUlRq4FUjL2SjeA6VGlMNAX6CYuFgvypuJJr6fNr9KRBJmbOmxVxsmUB15qCkYhcLFl3vO7fyoqOq8zY5UKi6vNxWdG52tzlQjSkB6NPWD6hVVySUKvF5uIpF5C1yuerI+nHUjpmYfzBCx0fu3GmTWxRDFBpAc1JpXUVWwy1CJmov7B4auWZTJt8ruxIQuVE3Au+p+0aZVe1SLmzpe4J1Mp+Xim+OYQncLvO4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(376002)(366004)(346002)(396003)(6512007)(8936002)(2616005)(26005)(38100700002)(122000001)(316002)(66556008)(66476007)(6506007)(53546011)(1076003)(6916009)(64756008)(8676002)(4326008)(41300700001)(54906003)(186003)(5660300002)(38070700005)(6486002)(71200400001)(478600001)(76116006)(66946007)(36756003)(4744005)(66446008)(86362001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmEvenBCR29EeWRLTmJ3QUUyUndtTFo2alBFSCtyRjA5QnB4Q2hvVWhTWC8z?=
 =?utf-8?B?aEFDUmtNSFk0TmxSa0tQSW5raFRyVEJhMjhHR0gzNDUwT0pFcXRkWjJYbFQx?=
 =?utf-8?B?b1JXVEExS3BhZFBYYXpPU0ZNREVLc2RtZDhwRFNYQ1QwWWhrdUF1NE9wcThO?=
 =?utf-8?B?eEdqaFVLblF3Ni9SR3VvSWJ3TTdtcklCeHpZR3UyMUozaGtTY1pwazh6eXZE?=
 =?utf-8?B?RC9VSm9lYVNVa2p5Vms5UmZqS3NKRExodFA2SUdVN214WTRrUzFNTE1nYktV?=
 =?utf-8?B?WXZrOEFjZlpsd2tZSWVYQURSUGtCc1N5ZEwzNFcxSmFreWZMTTNYMk1rOTcr?=
 =?utf-8?B?WG1QTXB5YlRJejRnbHY3SzlOSWIwdEdMaWNzYmN3aE9jUmJLRUFGTUdpbVFo?=
 =?utf-8?B?RjNUNnUrWTVRZ0pEYTFWY2hMRXlmelh1V3V1ZC9SS3laVCtvSlJTMmpkM3Zl?=
 =?utf-8?B?cEtvSnMzd3VGa3FXSmdqUGZpNWpKc0g5cVBqTU5GVVdXTlNlSkVoSXV0Z0hD?=
 =?utf-8?B?ZUZpOEZyUnExV1BCUmt5TDZ1dnNheHIvc2hTWHM0UGtrczlWQWFtMWdBRFF3?=
 =?utf-8?B?dFBUV2FtRVFsZFp2OUw1bHhnVndFOTh1R0RGNllUcFJxYU13N1hYbkJrL29a?=
 =?utf-8?B?eHptZ3FZeXNuMFMwWkhFL293c2pKemFTQm1LZXZoam5oYWRjQ1lQNWh0elY0?=
 =?utf-8?B?V2tsWUo0dGpkS052ek1UUFFrV2ZTLzdFdXVPL2RSTDM1V2M4akh5K0NNbnhH?=
 =?utf-8?B?K0oyVkxYMUR5dzJ6Y09SQkNtTmhBSVNJYkNnek9ONHF5b1ZtK3MvRFhCWVAx?=
 =?utf-8?B?cHl6YnN4cit6QWMvZ3dOSnExZ2M4TVlVdStlejhiVWdrTDJQemx5TjB3RFB0?=
 =?utf-8?B?Y3J4RWNwUzBzc2V1U1VpVll3dFpTYkRLQVN3ZFF2aC9vS2k4RVYwVEk2WDZa?=
 =?utf-8?B?WE5UVm1kLzdqMzAzVDl6UHRyOFhmdWczOENFUkQ2a1ZvL1N5U2hHbkdEait5?=
 =?utf-8?B?TG9XckUzMnFCT2w2NDM5K2srczU2ZDU4Wk5MUFUwR1loS21URUZNVWtMZlB3?=
 =?utf-8?B?SUdEclplSklTMDRWWmNyNnV5dlRUWnBPU2ZaREFWQkg0NFhnVUZzRnExRW9t?=
 =?utf-8?B?Wk96SGQvT0lVaXR6RG1hVFdJMWlpV1Q1R1VyOU5oZjk1anU3NXNoL2RWREo5?=
 =?utf-8?B?bmZlZCtyMFF2bUIyaUVxdmtiUFJOd3Y0YzI4MFcwSWdWVnBzY1FlRW5rTnJK?=
 =?utf-8?B?YmVYN0l3bWl6RTRWTWxtaHlYQmZIZWIwKzVHbnBuSmpFTUJvb3dtdUUwcm54?=
 =?utf-8?B?SzJBeXhkdExIWHQvV0srbm51Z0ZvRHZpOWdBSzNhL1hsLzVtRjNPUm5pNVJm?=
 =?utf-8?B?MkcvUUgreEFkd28wYStzbWY5bkZsc3NTTUZlNkNGaWFmQjNnd0ZXYnRHVnhE?=
 =?utf-8?B?SGRGcStJWUpNb3QxVktRNmt6RmtjVlRiNkR5aktUU2Z1cHRSK3o5SCtxWDln?=
 =?utf-8?B?ZjBCckQwU01vNzE3cVhXT2VnOG44dWxzd3JhR09seVQzdDZmTkszQjJqRUxk?=
 =?utf-8?B?WVhrdi92QW1YUXJYUkdrd1FCd0NQcjdKbkhPTkpLV3luMzVuNXBaK3lrbG9a?=
 =?utf-8?B?RmlUbW5zUVJiTjd0M1hBb2VVNkh3QmhnUzBUR3BpOEROVnJqMmszS2JSRnZp?=
 =?utf-8?B?SUxOYStKRkFsVGZDTHVaZkNrTkZaNFZyVG1wSGw2ekdObTJsWVhzeUJKZFpv?=
 =?utf-8?B?bVRvVHVIT3o5aHNSMHRhcGxnb2VLbU43VjkvazFTRmU2blZsdTlMNk1BdFp4?=
 =?utf-8?B?c0t6aVhmVEJqT2Z3YldUaFdMTW1jdzRteEVXejZDWGFsQ2NSMytqTTY5SVBN?=
 =?utf-8?B?L1ozd09LMlZXTGpPWjBDSm55TTdjUXJZTm1YRFM1S2xKZWlnNUFoUWtpQ1Q0?=
 =?utf-8?B?bjJncUhUVnQ4NC92d3VNblM3VlVTWlh0ZVdtSFZpcWo2RER5N05MalgyTXRU?=
 =?utf-8?B?d1VyK1krRU1ZK2ZreWpoN2hvOGVNWVcvbHl0TytXYVBBVS85c3BxZDRkanRP?=
 =?utf-8?B?YnNOSWhXbjBGVDQzNXhiUHZXcG1RRUpvekZDOFN5SEJXd3hzdWluVE1yM08v?=
 =?utf-8?Q?k+EBC0qnNNtsOL4HqYKDf/Lvu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DCB0CE17FC0704EB316FDA8FA2A2313@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d28a4f75-f657-4bb1-11f6-08da87929580
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 18:41:26.8894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mqtq1JWMIH7kRbYKyJBlBUZXpx6sDkrlvG6KacrFs90SFUBUthmaCRrfoiQRKGkRQqtirhemdF0vz6HM5VFFVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6578
X-Proofpoint-ORIG-GUID: nGWD2XF4c7ettidoh_sYxQfVmkc_kj00
X-Proofpoint-GUID: nGWD2XF4c7ettidoh_sYxQfVmkc_kj00
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 phishscore=0 spamscore=0 mlxlogscore=499 adultscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208260075
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBBdWcgMjYsIDIwMjIsIFNlYmFzdGlhbiBBbmRyemVqIFNpZXdpb3Igd3JvdGU6DQo+
IE9uIDIwMjItMDctMTggMTg6Mjc6MzkgWy0wNzAwXSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+
IHNlX2NtZCBpcyBub3QgdXNlZCBhbnl3aGVyZS4gUmVtb3ZlIGl0Lg0KPiANCj4gVGhpcyBzaG91
bGQgZm9sZGVkIGludG8gdGhlIG9yaWdpbmFsIGNvbW1pdCB3aGVyZSBzZV9jbWQgaGFzIHN0b3Bw
ZWQNCj4gYmVlbiB1c2luZy4gSSBiZWxpZXZlIGl0IHdhcyB3aGVuIHRhcmdldF9leGVjdXRlX2Nt
ZCgpIGhhcyBiZWVuIG1vdmVkLg0KDQpSaWdodCwgSSBtaXNzZWQgdGhhdC4NCg0KVGhhbmtzLA0K
VGhpbmgNCg0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXll
bkBzeW5vcHN5cy5jb20+DQo+IA0KPiBTZWJhc3RpYW4=
