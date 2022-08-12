Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BA6590A15
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 04:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236604AbiHLCBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 22:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236576AbiHLCA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 22:00:58 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922647E817;
        Thu, 11 Aug 2022 19:00:56 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27BHNhW4010610;
        Thu, 11 Aug 2022 19:00:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=fEXwEfhcW3K/Ln5GsUT2OwXN6OSGbUjCVBlldhlMToY=;
 b=gqbg1OgpYdnvYOFS0QxuKrng8TkVI46qLis4GFCoraRi2Mya9qClBfBciFXlFK6WYXWZ
 /VxoV4YGKT2Y/Xl66zuU+U3uLplOCGptFUKCFcYOj9KUsdBIdEuLZ3TT0Oske54FSq3l
 LfweP2tqU8MFANIwW48FXR6uXO4dFcIpZy7B5assAocz5R/F6I+Uyk35y0GmTEGDLrFn
 PNXVss2g0p+jCEHLxjrHKjAB+nUlc7T25ZfSFx0rh42lpXimnAhG4/fclS8ZC6+8XF3T
 RWgrEbmsfiA6TDhEIPtX/ERjLwyNmIlDpEMokjv2o/fYP+DbQ3RXJWidBud3vRFFIdrt iQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3huwpvd2bc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 19:00:43 -0700
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D5348C00FF;
        Fri, 12 Aug 2022 02:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1660269642; bh=fEXwEfhcW3K/Ln5GsUT2OwXN6OSGbUjCVBlldhlMToY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Gyoafyr3OR2bpXtjVRBKC9Lvh/adv6NEB0Om6M+uhSfnHiX/fWskeKbkBWpZtmA2y
         0MWoWkEsscFzhlothv5WzVS/yG5SC9L4I/bCdXq00JaZ8jcSZZS39GT3yJQ3Z+bQct
         CnhOBAbmArYWvKIciAYWeqsZtizizAU67+SZIpdZNtlDHrhTAZGgJUrVjW9mBMJUzc
         6+QhYa/s6sHp2u3IMv74iznl+xKQpquAruS8tldtBi5dBvsZmiqQqx2pnt5Hh9kQK4
         1h9p6jJ4LqMcnw5SOISYltNfO0ucqS6pUChwxs9urqX0cLlM563QZy3P2vLnr341IO
         aOUgRH765NdnQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id D72CCA0080;
        Fri, 12 Aug 2022 02:00:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6E1AA40087;
        Fri, 12 Aug 2022 02:00:39 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="IquQgwge";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhR5ovH+ifNW6+GZfekxC0RPpoLvAwwUozboIslc221/ZoDlBEwSIpag/4PNqSJlTHrRgLZuSDCQfGniV3x9IqLW1sXNLKi6RV+vIaxrPGgdklMqLdEVVGzR4EIoXl4GlFxdROW+aOURlUp6OCGmw31WXY8ylLbnAdeAkxTXX2T1sSZjKh2e2nwQndtAVkhUD7Z2w8+j7JL9BcplAHbEizbfyUtdZGBbAWyGa2ldCo2sT0DwaZ2UEVNJrkQXGXOfjoTRgk0rFLEQyXIot7h+HnCQtzt82rCccFk/WFpEXzaBdV8VMFXRcf/rnH6Em9RZ9idS7bFmnSFWpKiZriDxsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEXwEfhcW3K/Ln5GsUT2OwXN6OSGbUjCVBlldhlMToY=;
 b=DSkk6SF3aISHEYFWDcd/657CMa9horHLKeRfeOEGmSWH4SHj1T0DGD2f0EcO/hsaPK1bMk0z8PAdwhRgvKZ5AhHUFvYROvVid2LVikv5fb2QBsdAg/ymwh6SZ0CQ9KtP/Mgx1WZxUzMi4DZEFddEKbXumjDSgvJnVTF01AGn+qD01+PMzuPaq++xT4ZKgbdsZYn8eXsRsfJ0H+D8KYuvXXc5h+hSLjYtHJpqvyfsTxY0A2/UqN21WObb3dqrWcafO6PljfYeOlcunKvV+A4g8pXQvqUgBqhKd+nX9GI8QtOA0/wx+A9LVR7JMtx8wtiLNeyKEZ2Sdo3k3TokhaN4Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEXwEfhcW3K/Ln5GsUT2OwXN6OSGbUjCVBlldhlMToY=;
 b=IquQgwgelsDNOj8pAQ1baOIOp4/GpPgiYoJWISc04c7wKtuXWTnLQFg19cFQH0AtuQLVX7qOKMZQoVyJupB90lkY2uTcJQXjP1mKufTfGFlFS+VRjzDo0FMB9odxPVEHDFKw80rKQPaU1vaoDhIVp69aZ2GXTcHwm3Igz3ixsIY=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SA0PR12MB4399.namprd12.prod.outlook.com (2603:10b6:806:98::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 12 Aug
 2022 02:00:37 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c%7]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 02:00:36 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Serrao <quic_eserrao@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_mrana@quicinc.com" <quic_mrana@quicinc.com>
Subject: Re: [PATCH 2/5] usb: gadget: Add function wakeup support
Thread-Topic: [PATCH 2/5] usb: gadget: Add function wakeup support
Thread-Index: AQHYpqSxYg+mSBtinkWEjfftWY3s8a2cSDKAgAMApwCAAD6nAIAHe4yAgABbB4CAAtc4AIAAXAqA
Date:   Fri, 12 Aug 2022 02:00:36 +0000
Message-ID: <98966b47-0bc5-6ec0-ec80-5eff1d71d9fd@synopsys.com>
References: <1659467920-9095-1-git-send-email-quic_eserrao@quicinc.com>
 <1659467920-9095-3-git-send-email-quic_eserrao@quicinc.com>
 <049219f1-8c68-e4cc-7bf9-1e8c214e80aa@synopsys.com>
 <32a0765e-00d9-1a67-bf36-4060c5fcb008@quicinc.com>
 <8705d52e-2181-aebd-43b8-2c8d021339c7@synopsys.com>
 <5ad70f41-622e-2d75-7c53-89aba1255a5f@quicinc.com>
 <ac8e012f-08f3-baed-ead0-231f0527864c@synopsys.com>
 <b123b543-6c82-2787-9730-addd3e6e70a3@quicinc.com>
In-Reply-To: <b123b543-6c82-2787-9730-addd3e6e70a3@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1027d89f-ef66-4f8d-c57a-08da7c0672c8
x-ms-traffictypediagnostic: SA0PR12MB4399:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ViPf1kBrjnlnme1PQF4W7/NUz3h3UCp/eifmEAI6XUq+FGJ/IkXvO3I6UeEieFeMEna5t7bof54aOp2YtqtRIrbjXDEESp/CXv1vhyEGdHxqpC6jLM7T0y8rb37Scp3gE6qy/mOriNoIimhYuztWDnT+IKUqqrEWGLzqI6IJa0fFU//dCdviXS+g/fKjkYHhPatT5bZFRJKIXbBvLyStrKZGBhcrO9aRFsJxV4ETQs7GdHQ5KF6qZuGSiWeXag6KQjcuzvW+yb6hF02nwaYAuNayg4FbJr8gxlG0/ourOljAHAdndMMgxoXgehEEYSN6I+NmBFL8woQ9nv+ASnjC1WbNpmbxQJq/kzMtQJswDkvUPVcYxA1SH1G2xFxggt+3otQIlwB6VyoQ/gmRK/nxplRef7IndSGbEOBOqKQlQd8lUXAbfiad3ZzqkWHzsuqHJhnWxoc6QhB+w6lhhGtreFlFHu2XSYwO2NdCJUEBtD2iRxBNdVRwuV1VfwYEZaf9H4z6B0e2GuwZuZxyLprUrG1ivTx0gm6I15aJyEsTqr4LVmYWYktPk1Xq//l+byO0IlEnlUFP7r64WuoYhZJBbLmKJAgWiyUNVq319LLJRlOpi3CbwD5ORMRXePfSTijRaA4qG6C6zXFX6D+o0gIRLKl/4fhUay1tkrfVCyzHoPW9hJzSBKwjN5v/WtpcwiobvUAgWzG2EcIU5bDrfiiPRpAndTrEkU0lH/5jl7z7JVbwJzieEWlq1dQqvI7IibUMjoUTIVTd930m8GFdKnvx2VBaOlNSpuDlQB35vO91vErdTjQqR/eNRSpuY1HD3BMnoSMIMPVxKL8fZCZpD/4A/f9E+MAKUYkvkVKFimlJ9qE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(366004)(376002)(396003)(136003)(54906003)(66476007)(316002)(66446008)(4326008)(76116006)(66556008)(64756008)(8676002)(66946007)(5660300002)(8936002)(2906002)(110136005)(38100700002)(122000001)(186003)(86362001)(31696002)(38070700005)(41300700001)(6486002)(36756003)(478600001)(6506007)(71200400001)(26005)(83380400001)(6512007)(53546011)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVBob1dXdUFTNkplSHdLbGJIQWhLTWFlR2ZvK0NYOVhrWEZmUlV1emVEM3Fx?=
 =?utf-8?B?bGxjL3c3T29UTnlGTEJhNEJmbW9UTVAzeW4wSXY0RkdscWVNcXVsYXF4WjdR?=
 =?utf-8?B?eFlnTXpKeEw0ZE1lbG1sSTRHZVJ4L0wvWmkvbGZ4bnhNckhSY05zbGRnN2lE?=
 =?utf-8?B?N0lHU2MvSFh4L0dEeEZrQ3RvOTY0VmQvU1R6K2J3UXVURDFIc3I0eTUyMUJE?=
 =?utf-8?B?MDlUaTBGUVVvQzBDalNMOHU0dEdsMVVZcUdiRERIS3diSXZ6c1RMNlNvZE5N?=
 =?utf-8?B?SVM5R0h1WDlyYTh1MEU4NEtEdktXMkxuY3lab1BEZy9KWkZmbnZuSjBlaGxQ?=
 =?utf-8?B?Mjc4c2UwSW9aWkVaK0c5WlpTa20vTmxvdVlTSDZ2RE9DdHdxUDBxLy9wSXdn?=
 =?utf-8?B?UEVNU1d2aHFPMjhLM3hKcWk3Umg1YTZId0d1Y0NTMkROWW1aaUpBd2FuS0Ni?=
 =?utf-8?B?N1NGcG5uL1BhSmI5WU03ajNlTU1jZnllcUk5U2xCREFUZ2tsUXNCZWtXMjln?=
 =?utf-8?B?Z25BOE52YSt2Q044UUVvYjU2aGFUeVdDS0hpRE94SjNPaDBjM3RRYmxPTVlh?=
 =?utf-8?B?WlRvVnVFSDB0S0hIajAzcEhhR0IxWW1jaDMvQXQvcys5SmJtNnd1bTcrRTRC?=
 =?utf-8?B?ZUdsQVVNSmpZYzdvTUViRHZQd2wyYTBPMnBWUjhXdVhaVXF3Wk1ac2Q5a041?=
 =?utf-8?B?Z1Exc2JMZFNuNVZkTVFVVG9ONjdwZGNsdGpHaWJRR2xQUFRSK3FiUlpUV2RI?=
 =?utf-8?B?Rm5YcjVlbk1MSzZRck4zeUZMQzdRQXZrcVMxVkR0S3B0S3IxU0lveWo3R1pK?=
 =?utf-8?B?dG1zMmJ3TEpYK3k0MFQwN2ljMDlCZnRUelJMUmQ1c2NGaEtKZ3dzU2xub2dW?=
 =?utf-8?B?RmZWaU1BNEUrdjYvVGVTbFBtZVBBN3dlRi9nei81Um1QbW81d21aQktZa2pR?=
 =?utf-8?B?elJNUndZSGNSNFBXS0hhaTNrMWdzREI0WkpuNjNiMGh4eDk0SUpCUG1Bei9x?=
 =?utf-8?B?ejFWWkhkZ2w3UVg3d1VSbng5V2FnN0doN2wzcGg5Sk1NU000a2x5VkcvVkY5?=
 =?utf-8?B?Vm5zaGtZbHptK0xnQWh6VnU5VHFmRjR6azZ5dm1rYmhMSlBabEtWV1lKNXo0?=
 =?utf-8?B?aUFPanR0eERGeHpQRjljaUoyR21pQWk3emd5QkdaSU9LTXphV2k2Vm04VXh3?=
 =?utf-8?B?TVQvUnR0V0pqMWpxbUVYMkhERWl6aGo4bVdrWnVUeFpkdVJiZjB6Vmg2OWRm?=
 =?utf-8?B?UVNiUzlHc0ZBNWlQYTJIcGtCSVBXNjdIQXRrVE5FeEFTUW5oTlZBQXNZMXZV?=
 =?utf-8?B?bmxiZGxIQ2JSWDlUSHdSN3UrNDY1T3BCZEpIRVBsRVFJbzJicEx6RzA1ZFdo?=
 =?utf-8?B?b05yWk9DZ3pzNmRRWTRDb1M5emdtTGlXMUZWYW01NytMUGJxYmdEendmTmNE?=
 =?utf-8?B?WUFWRDl4aGs0L25qbGhKWmR0ZGZjdU5VczRKUVozQlJoeEFFNzk3QW5SL0tw?=
 =?utf-8?B?QllmS2FDYUJBTER5eGdEcDZGWHlNc1k5UmpVNnhXTUxkV1lNR3RoMXhyWEta?=
 =?utf-8?B?MzBOZG1BU3B5YnpoWU9ESGRPOU5EWGtLYlpHd01wNGdzTElZSW1QT3Vxcm1K?=
 =?utf-8?B?SkhrWmdoN21Pdnd0VGJIQ3Zvbkc1cDJ5K29hckM3akZodmlrOGRkNEdUNWJx?=
 =?utf-8?B?c2RMUlNaUTFkS2lpTEQwOWJCK2w3RVFvUVFuOFZ1RXN1aURXU2VISnBOT0xR?=
 =?utf-8?B?Vk51K3NuNi9VQmttL3VYcXlFcEhjTkZ1S0l6ZFZkRTZmek9kdFdWMjEvZzcr?=
 =?utf-8?B?ZWs3UHZsTHRNdnRBT0EwUlFSeTB4cnRQVU00V2RwdVh3aTBqY2JLNTRmNTlz?=
 =?utf-8?B?VDVyZ2ZzNkYxVkNsOHN5Y1F1M3Z1SGRLZHkxVXpLOVRUMFhxT1l2L1FqQmR6?=
 =?utf-8?B?eHRSUVpZTW1OUUhPOXlBaGwzUC9OT2lXMVY2TzU2bEhhZER2dE9palpzME9G?=
 =?utf-8?B?VE1CZGkxMElUM1BOeCtaSUE0eUk3Ujl3TWRMeGprZ3VuY0F5V3lrRnpuY1o5?=
 =?utf-8?B?RHEzN0NMR3ZocDZyMlBDdWZ6bWRqMlRFdnNxL2Z4c2tIQXdaNnJubnhZZVYw?=
 =?utf-8?Q?gm/A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <361960BD7F69F744A18DC5D58EF95DD8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cUV4Q1NnalcrZy9tdVJ0NUVZb2pFV3JNOXhnNDNpUlBqQVVpb1FIZ1lsVDcw?=
 =?utf-8?B?UkVwZzhnSHN6UmE0dTZEZDRCWHVPcks0SEZtQ29KK0xrc0JNT1A1Smg0dzdi?=
 =?utf-8?B?ZXhRbWxFRW1SR1lJTzU2UWFWY09kOGJ4eEFUSE0vNTN4a0ZROTFKUVhNbVFV?=
 =?utf-8?B?dW10MngyNENCOVUvVnRiZFJVb0IzSlJ6Tk1sREJiYmpya0dRUGFGU1hFMHgz?=
 =?utf-8?B?bW5OWktwb3JYaW5SbVN4OE1hNVUreUwxT1Vjc01yNEtBa3Jra3VQNmFjQWVp?=
 =?utf-8?B?a3duNGtDelZaZ3hKNVQ1ajdML2tjVGZKRHdZNExscWIxS0U4aVllMGpMcjNO?=
 =?utf-8?B?MnBuSEJOeU9EMk9tUjVtb21hN2xCbkpTTm5aRWdySlJmL2szeWUxYmYvY1M0?=
 =?utf-8?B?N1drdVRqc0h1SjViT3ZZMnBpZ0Y4VWxWWXprSGZwdUViN0toNWVibGFMRGFQ?=
 =?utf-8?B?RkUxS3k2NXBJTHhWR2VESi9CVDBya0MvaVBWNVBEMzNkNjNVaDhxMmYrek5P?=
 =?utf-8?B?cWJaSTBWckpiMyt0aWEyZy9EalRSTUhpdG5rcHdPSlpmV3VkZWI3dlFqRkR1?=
 =?utf-8?B?aHBvTS9JeWlqd29rblNjK2JCdEMyRDNtTW9hNmxoVEZrYlkvMGh3WWtRSTNB?=
 =?utf-8?B?bW8vQlJLS25GTVlGTlFOZWZDeUhHRjJUaE1RNXN0MUFReEVRYXNtdGh5RnNp?=
 =?utf-8?B?WmxGUHNWelFCakNyWGczUlZBZDRCN1FFTm4vMDcrUFJUUVROUG5tTFFDaW9t?=
 =?utf-8?B?SmVtbWZDNkFxdEc4a2o0Um9VaFF0aHFzYy8xQ2o0MDVKZUVXUWRweFRKQzVG?=
 =?utf-8?B?bGlMNERoMnBHWXk1Z01EWDBTTmtRRmswRkg1RUhpZHZUWW10NVFkcHBtb0ZC?=
 =?utf-8?B?K00ycUlFVXRaOU1RalNTbHArYnJpMkpySGFvdTEvZjh6RXYrQXFXVXMvQysr?=
 =?utf-8?B?SG92YUZ0VFEzbzJHT25IZmdvNGhlNU92em9PZ3NJL3c0T3RGMUZwajZ6WEd3?=
 =?utf-8?B?RkdWcm5tTlNMQUhqYjFaRytNVmpCNEd2NGJHM0hpWTF4N2o4SzR1RzBodnlO?=
 =?utf-8?B?TVR4TkhXMWREamZWcm54dHB5UjFIckJzRHVINFhIUHZSL1l4LzRXOFJ0bTg1?=
 =?utf-8?B?Q0kvaXErcC94by8zaW8wazAwU3VDeW40a0Frc0F1eGtWcmZSTlNnclNlaVlH?=
 =?utf-8?B?TTRVa3BRRUFjTzRhQm1UeS9WWmJKWkxDcWtTeUtGd01DV29KNWdIV29Fd2JL?=
 =?utf-8?B?TWhWUENaN0lGakFzeTJuVS9MTVJqVkIwL0lpU2NDK3Qwa2ZLU2s2N25qY1Jz?=
 =?utf-8?B?NkRYMm1ZY3NCSVNva29DTmF5WG5VTHB5Ny94ekZ5NjIyRnVLZzdzYWEzUFEx?=
 =?utf-8?B?QVVHOENjd2ZoOGpzRHVxb0RDUXVRS1NobUFONk0xTnRFZHBkNWF2KzljRkVs?=
 =?utf-8?B?Y09wa0k4d01nUXMvOHVRTU8yT21OeHgrM1pWd2JZRDR5M2NVSldKVU9QcU9Z?=
 =?utf-8?B?Um13Y3ljd1gxRExJT1pvRkE2S0VpRkl3enpxdVl2WEpqNldidzREbk1TVTcr?=
 =?utf-8?B?QXJ2bGh6R3MrQytGVkYvKzdCV25LaDJOSW15RzJzdE9KNEtUZmtmNlkxTlVm?=
 =?utf-8?B?QlFXRHU3dlNBY0treDhndUdMNUQ3dnc9PQ==?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1027d89f-ef66-4f8d-c57a-08da7c0672c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2022 02:00:36.3129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YdxbX54w7CDSmR60bc9i3muNmKzODepV5bnAzB0B3KQksvI9KBzG7Y/gXluFCAFDdU05qPzV1rY350PUnGkPyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4399
X-Proofpoint-ORIG-GUID: 3frLM2XHPp3cyAmTjet-1_6WcAWY3IGD
X-Proofpoint-GUID: 3frLM2XHPp3cyAmTjet-1_6WcAWY3IGD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_01,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208120003
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8xMS8yMDIyLCBFbHNvbiBTZXJyYW8gd3JvdGU6DQo+IA0KPiANCj4gT24gOC85LzIwMjIg
NjowOCBQTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KDQo8c25pcD4NCg0KDQo+PiBUbyBzdW1tYXJp
emUgdGhlIHBvaW50czoNCj4+DQo+PiAxKSBUaGUgaG9zdCBvbmx5IGFybXMgZnVuY3Rpb24gcmVt
b3RlIHdha2V1cCBpZiB0aGUgZGV2aWNlIGlzIGNhcGFibGUgb2YNCj4+IHJlbW90ZSB3YWtldXAg
KGNoZWNrIFVTQl9DT05GSUdfQVRUX1dBS0VVUCBpbiBibUF0dHJpYnV0ZXMgYW5kIGhhcmR3YXJl
DQo+PiBjYXBhYmlsaXR5KQ0KPj4NCj4+IDIpIElmIHRoZSBkZXZpY2UgaXMgaW4gc3VzcGVuZCwg
dGhlIGRldmljZSBjYW4gZG8gcmVtb3RlIHdha2V1cCAodGhyb3VnaA0KPj4gTEZQUyBoYW5kc2hh
a2UpIGlmIHRoZSBmdW5jdGlvbiBpcyBhcm1lZCBmb3IgcmVtb3RlIHdha2V1cCAodGhyb3VnaA0K
Pj4gU0VUX0ZFQVRVUkUoRlVOQ19TVVNQRU5EKSkuDQo+Pg0KPj4gMykgSWYgdGhlIGxpbmsgdHJh
bnNpdGlvbnMgdG8gVTAgYWZ0ZXIgdGhlIGRldmljZSB0cmlnZ2VyaW5nIGEgcmVtb3RlDQo+PiB3
YWtldXAsIHRoZSBkZXZpY2Ugd2lsbCBhbHNvIHNlbmQgZGV2aWNlIG5vdGlmaWNhdGlvbiBmdW5j
dGlvbiB3YWtlIGZvcg0KPj4gYWxsIHRoZSBpbnRlcmZhY2VzIGFybWVkIHdpdGggcmVtb3RlIHdh
a2V1cC4NCj4+DQo+PiA0KSBJZiB0aGUgZGV2aWNlIGlzIG5vdCBpbiBzdXNwZW5kLCB0aGUgZGV2
aWNlIGNhbiBzZW5kIGRldmljZQ0KPj4gbm90aWZpY2F0aW9uIGZ1bmN0aW9uIHdha2UgaWYgaXQn
cyBpbiBVMC4NCj4+DQo+Pg0KPj4gTm93LCByZW1vdGUgd2FrZXVwIGFuZCBmdW5jdGlvbiB3YWtl
IGRldmljZSBub3RpZmljYXRpb24gYXJlIDIgc2VwYXJhdGUNCj4+IG9wZXJhdGlvbnMuIFdlIGhh
dmUgdGhlIHVzYl9nYWRnZXRfb3BzLT53YWtldXAoKSBmb3IgcmVtb3RlIHdha2V1cC4gSQ0KPj4g
c3VnZ2VzdGVkIHRvIG1heWJlIGFkZCB1c2JfZ2FkZ2V0X29wcy0+c2VuZF93YWtldXBfbm90aWZp
Y2F0aW9uKGdhZGdldCwNCj4+IGludGZfaWQpIGZvciB0aGUgZGV2aWNlIG5vdGlmaWNhdGlvbi4g
V2hhdCB5b3UgZGlkIHdhcyBjb21iaW5pbmcgYm90aA0KPj4gb3BlcmF0aW9ucyBpbiB1c2JfZ2Fk
Z2V0X29wcy0+ZnVuY193YWtldXAoKS4gVGhhdCBtYXkgb25seSB3b3JrIGZvcg0KPj4gcG9pbnQg
NCkgKGFzc3VtaW5nIHlvdSBmaXggdGhlIFUwIGNoZWNrKSwgYnV0IG5vdCBwb2ludCAzKS4NCj4g
DQo+IFRoYW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjayBhbmQgc3VtbWFyeS4gSSB3aWxsIHJlbmFt
ZSBmdW5jX3dha2V1cCB0bw0KPiBzZW5kX3dha2V1cF9ub3RpZmljYXRpb24gdG8gYmV0dGVyIGFs
aWduIHdpdGggdGhlIGFwcHJvYWNoLiBUaGUgcmVhc29uIEkNCj4gaGF2ZSBjb21iaW5lZCByZW1v
dGVfd2FrZXVwIGFuZCBmdW5jdGlvbiB3YWtlIG5vdGlmaWNhdGlvbiBpbg0KPiB1c2JfZ2FkZ2V0
X29wcy0+ZnVuY193YWtldXAoKSBpcyBiZWNhdXNlIHNpbmNlIHRoZSBpbXBsZW1lbnRhdGlvbiBp
cyBhdA0KPiBmdW5jdGlvbi9jb21wb3NpdGUgbGV2ZWwgaXQgaGFzIG5vIGtub3dsZWRnZSBvbiB0
aGUgbGluayBzdGF0ZS4gU28gSQ0KPiBoYXZlIGRlbGVnYXRlZCB0aGF0IHRhc2sgdG8gY29udHJv
bGxlciBkcml2ZXIgdG8gaGFuZGxlIHRoZSBub3RpZmljYXRpb24NCj4gYWNjb3JkaW5nbHkuIFRo
YXQgaXMgZG8gYSBMRlBTIGhhbmRzaGFrZSBmaXJzdCBpZiB0aGUgZGV2aWNlIGlzDQo+IHN1c3Bl
bmRlZCBhbmQgdGhlbiBzZW5kIG5vdGlmaWNhdGlvbiAoZXhwbGFpbmVkIGJlbG93KS4gQnV0IHdl
IGNhbg0KPiBkZWZpbml0ZWx5IHNlcGFyYXRlIHRoaXMgYnkgYWRkaW5nIGFuIGFkZGl0aW9uYWwg
ZmxhZyBpbiB0aGUgY29tcG9zaXRlDQo+IGxheWVyIHRvIHNldCB0aGUgbGluayBzdGF0ZSBiYXNl
ZCBvbiB0aGUgZ2FkZ2V0IHN1c3BlbmQgY2FsbGJhY2sgY2FsbGVkDQo+IHdoZW4gVTMgU1VTUEVO
RCBpbnRlcnJ1cHQgaXMgcmVjZWl2ZWQuIExldCBtZSBrbm93IGlmIHlvdSBmZWVsDQo+IHNlcGFy
YXRpbmcgdGhlIHR3byBpcyBhIGJldHRlciBhcHByb2FjaC4NCj4gDQoNClRoZSByZWFzb24gSSB0
aGluayB3ZSBuZWVkIHRvIHNlcGFyYXRlIGl0IGlzIGJlY2F1c2Ugb2YgcG9pbnQgMy4gQXMgSQ0K
bm90ZSBlYXJsaWVyLCB0aGUgc3BlYyBzdGF0ZXMgdGhhdCAiSWYgcmVtb3RlIHdha2UgZXZlbnQg
b2NjdXJzIGluDQptdWx0aXBsZSBmdW5jdGlvbnMsIGVhY2ggZnVuY3Rpb24gc2hhbGwgc2VuZCBh
IEZ1bmN0aW9uIFdha2UgTm90aWZpY2F0aW9uLiINCg0KQnV0IGlmIHRoZXJlJ3Mgbm8gcmVtb3Rl
IHdha2UgZXZlbnQsIGFuZCB0aGUgaG9zdCBicm91Z2h0IHRoZSBkZXZpY2UgdXANCmluc3RlYWQs
IHRoZW4gdGhlIGZ1bmN0aW9uIHN1c3BlbmQgc3RhdGUgaXMgcmV0YWluZWQuDQoNCklmIHdlIHNl
cGFyYXRlIHRoZXNlIDIgb3BlcmF0aW9ucywgdGhlIGNhbGxlciBjYW4gY2hlY2sgd2hldGhlciB0
aGUNCm9wZXJhdGlvbiB3ZW50IHRocm91Z2ggcHJvcGVybHkuIEZvciBleGFtcGxlLCBpZiB0aGUg
d2FrZXVwKCkgaXMNCmluaXRpYXRlZCBwcm9wZXJseSwgYnV0IHRoZSBmdW5jdGlvbiB3YWtlIGRl
dmljZSBub3RpZmljYXRpb24gZGlkbid0IGdvDQp0aHJvdWdoLiBXZSB3b3VsZCBvbmx5IG5lZWQg
dG8gcmVzZW5kIHRoZSBkZXZpY2Ugbm90aWZpY2F0aW9uIHJhdGhlcg0KdGhhbiBpbml0aWF0ZSBy
ZW1vdGUgd2FrZXVwIGFnYWluLg0KDQoNCj4gSSBoYXZlIGV4cGxhaW5lZCBiZWxvdywgaG93IHRo
ZSA0IHBvaW50cyB5b3UgbWVudGlvbmVkIGFyZSBoYW5kbGVkIGluIG15DQo+IGN1cnJlbnQgaW1w
bGVtZW50YXRpb24uDQo+IA0KPiBUaGUgZnVuY3Rpb24gZHJpdmVyIHdpbGwgc2VuZCBhIHdha2V1
cCBub3RpZmljYXRpb24gb25seSBpZiBpdCBpcyBhcm1lZA0KPiBmb3IgcmVtb3RlIHdha2V1cC4N
Cj4gDQo+IHBhdGNoIzUNCj4gK8KgwqDCoMKgwqDCoMKgIGlmICghcG9ydC0+ZnVuY193YWtldXBf
YWxsb3dlZCkgew0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBEQkcocG9ydC0+aW9wb3J0LCAi
RnVuY3Rpb24gd2FrZXVwIG5vdCBhbGxvd2VkXG4iKTsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIC1FT1BOT1RTVVBQOw0KPiArwqDCoMKgwqDCoMKgwqAgfQ0KPiArwqDCoMKgwqDC
oMKgwqAgcmV0ID0gdXNiX2Z1bmNfd2FrZXVwKGZ1bmMpOw0KPiArwqDCoMKgwqDCoMKgwqAgaWYg
KHJldCkNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcG9ydC0+aXNfd2FrZXVwX3BlbmRpbmcg
PSB0cnVlOw0KPiANCj4gSWYgdGhlIGRldmljZSBpcyBpbiBzdXNwZW5kLCB3ZSBkbyBhIExGUFMg
aGFuZHNoYWtlIGZpcnN0IGFuZCByZXR1cm4NCj4gLUVBR0FJTiB0byBjb21wb3NpdGUgbGF5ZXIg
d2hpY2ggd2lsbCBzZXQgdGhlIGlzX3dha2V1cF9wZW5kaW5nIGZsYWcuDQo+IA0KDQpJIGRvbid0
IHNlZSB5b3UncmUgY2hlY2tpbmcgZm9yIC1FQUdBSU4uIEFsc28gd2hhdCBoYXBwZW5zIHdoZW4g
d2FrZXVwKCkNCmZhaWxzLCBzaG91bGQgd2UgcmV0cnk/DQoNCj4gUGF0Y2gjMw0KPiArc3RhdGlj
IGludCBkd2MzX2dhZGdldF9mdW5jX3dha2V1cChzdHJ1Y3QgdXNiX2dhZGdldCAqZywgaW50IGlu
dGVyZmFjZV9pZCkNCj4gK3sNCj4gK8KgwqDCoCBpbnTCoMKgwqAgcmV0ID0gMDsNCj4gK8KgwqDC
oCB1MzLCoMKgwqAgcmVnOw0KPiArwqDCoMKgIHN0cnVjdMKgwqDCoCBkd2MzICpkd2MgPSBnYWRn
ZXRfdG9fZHdjKGcpOw0KPiArDQo+ICvCoMKgwqAgcmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3Ms
IERXQzNfRFNUUyk7DQo+ICsNCj4gK8KgwqDCoCAvKg0KPiArwqDCoMKgwqAgKiBJZiB0aGUgbGlu
ayBpcyBpbiBMUE0sIGZpcnN0IGJyaW5nIHRoZSBsaW5rIHRvIFUwDQo+ICvCoMKgwqDCoCAqIGJl
Zm9yZSB0cmlnZ2VyaW5nIGZ1bmN0aW9uIHdha2V1cC4gSWRlYWxseSB0aGlzDQo+ICvCoMKgwqDC
oCAqIG5lZWRzIHRvIGJlIGV4cGFuZGVkIHRvIG90aGVyIExQTXMgYXMgd2VsbCBpbg0KPiArwqDC
oMKgwqAgKiBhZGRpdGlvbiB0byBVMw0KPiArwqDCoMKgwqAgKi8NCj4gK8KgwqDCoCBpZiAoRFdD
M19EU1RTX1VTQkxOS1NUKHJlZykgPT0gRFdDM19MSU5LX1NUQVRFX1UzKSB7DQo+ICvCoMKgwqDC
oMKgwqDCoCBkd2MzX2dhZGdldF93YWtldXAoZyk7DQo+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4g
LUVBR0FJTjsNCj4gK8KgwqDCoCB9DQo+IA0KPiBUaGUgYWJvdmUgc2hvdWxkIHRha2UgY2FyZSBv
ZiBQb2ludCAyLg0KPiANCj4gQWZ0ZXIgdHJpZ2dlcmluZyBhIHJlbW90ZSB3YWtldXAgaW4gUG9p
bnQgMiwgaWYgdGhlIGxpbmsgdHJhbnNpdGlvbnMgdG8NCj4gVTAgdGhlbiB3ZSB3aWxsIHJlY2Vp
dmUgYSBVMCBsaW5rIHN0YXRlIGV2ZW50IGZvciB0aGUgc2FtZSBhbmQgdGhhdA0KPiB3b3VsZCB0
cmlnZ2VyIGEgZ2FkZ2V0X3Jlc3VtZSBjYWxsYmFjayB0byBpbmZvcm0gdGhlIGNvbXBvc2l0ZSBs
YXllcg0KPiB0aGF0IGRldmljZSBoYXMgcmVzdW1lZC4gQXMgc29vbiBhcyB0aGUgZnVuY3Rpb24v
Y29tcG9zaXRlIGxheWVyIGdldHMNCj4gdGhpcyBpbmZvIGl0IHdpbGwgcmUtc2VuZCB0aGUgd2Fr
ZXVwIG5vdGlmaWNhdGlvbiB0byB0aGUgY29udHJvbGxlcg0KPiBkcml2ZXIgYmFzZWQgb24gdGhl
IGlzX3dha2V1cF9wZW5kaW5nIGZsYWcNCg0KU2VlIGNvbW1lbnQgYWJvdmUuDQoNCj4gDQo+IGxp
bmtzdHNfY2hhbmdlX2ludGVycnVwdCgpIGluIFBhdGNoIzENCj4gK8KgwqDCoCBjYXNlIERXQzNf
TElOS19TVEFURV9VMDoNCj4gK8KgwqDCoMKgwqDCoMKgIGlmIChkd2MtPmlzX2dhZGdldF93YWtl
dXApIHsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbGlua3N0c19jaGFuZ2VfZXZlbnRzX3Nl
dChkd2MsIGZhbHNlKTsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZHdjM19yZXN1bWVfZ2Fk
Z2V0KGR3Yyk7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGR3Yy0+aXNfZ2FkZ2V0X3dha2V1
cCA9IGZhbHNlOw0KPiArwqDCoMKgwqDCoMKgwqAgfQ0KPiArwqDCoMKgwqDCoMKgwqAgYnJlYWs7
DQo+IA0KPiANCj4gdV9ldGhlciByZXN1bWUgY2FsbGJhY2sgaW4gUGF0Y2gjNQ0KPiArwqDCoMKg
IGlmIChmdW5jX3N1c3BlbmQpIHsNCj4gK8KgwqDCoMKgwqDCoMKgIGlmIChsaW5rLT5pc193YWtl
dXBfcGVuZGluZykgew0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1c2JfZnVuY193YWtldXAo
ZnVuYyk7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxpbmstPmlzX3dha2V1cF9wZW5kaW5n
ID0gZmFsc2U7DQo+ICvCoMKgwqDCoMKgwqDCoCB9DQo+IA0KPiBUaGUgYWJvdmUgc2hvdWxkIHRh
a2UgY2FyZSBvZiBQb2ludCAzLg0KDQpXZSBzaG91bGQgYWxzbyBjaGVjayBmb3Igb3RoZXIgZnVu
Y3Rpb25zIHRvIHNlbmQgZGV2aWNlIG5vdGlmaWNhdGlvbi4NCg0KPiANCj4gRm9yIFBvaW50IDQg
bGlrZSB5b3UgbWVudGlvbmVkIEkgd2lsbCBhZGQgVTAgY2hlY2sgaW5zdGVhZCBvZiBVMyBjaGVj
ay4NCj4gDQo+IFBvaW50IDEgd291bGQgaGF2ZSByZXNvbHZlZCBpbiBlbnVtZXJhdGlvbiBzdGFn
ZSBpdHNlbGYgKGJtQXR0cmlidXRlcyBpbg0KPiBjb25maWcgZGVzY3JpcHRvcikgYmFzZWQgb24g
d2hpY2ggdGhlIGhvc3Qgc2V0cyB0aGUNCj4gVVNCX0lOVFJGX0ZVTkNfU1VTUEVORF9SVyBvcHRp
b24gaW4gdGhlIFNFVF9GRUFUVVJFKEZVTkNUSU9OX1NVU1BFTkQpDQo+IHBhY2tldC4gQmFzZWQg
b24gdGhpcyBvcHRpb24gdGhlIGZ1bmN0aW9uL2NvbXBvc2l0ZSBkcml2ZXIgd2lsbCBzZXQNCj4g
ZnVuY193YWtldXBfYWxsb3dlZCBmbGFnIGFybWluZyBpdCBmb3IgcmVtb3RlX3dha2V1cA0KPiAN
Cj4gK3N0YXRpYyBpbnQgZWNtX2Z1bmNfc3VzcGVuZChzdHJ1Y3QgdXNiX2Z1bmN0aW9uICpmLCB1
OCBvcHRpb25zKQ0KPiArew0KPiArwqDCoMKgIGJvb2wgZnVuY193YWtldXBfYWxsb3dlZDsNCj4g
K8KgwqDCoCBzdHJ1Y3QgZl9lY20gKmVjbSA9IGZ1bmNfdG9fZWNtKGYpOw0KPiArwqDCoMKgIHN0
cnVjdCB1c2JfY29tcG9zaXRlX2RldiAqY2RldiA9IGVjbS0+cG9ydC5mdW5jLmNvbmZpZy0+Y2Rl
djsNCj4gKw0KPiArwqDCoMKgIERCRyhjZGV2LCAiZnVuYyBzdXNwICV1IGNtZFxuIiwgb3B0aW9u
cyk7DQo+ICsNCj4gK8KgwqDCoCBmdW5jX3dha2V1cF9hbGxvd2VkID0gISEob3B0aW9ucyAmIChV
U0JfSU5UUkZfRlVOQ19TVVNQRU5EX1JXID4+IDgpKTsNCj4gDQo+IERvIHdlIG5lZWQgYW55IGFk
ZGl0aW9uYWwgY2hlY2tzIGZvciBQb2ludCAxID8gUGxlYXNlIGxldCBtZSBrbm93IGlmIG15DQo+
IHVuZGVyc3RhbmRpbmcgaXMgaW5jb3JyZWN0IGhlcmUuDQo+IA0KPiANCg0KSWYgdGhlIGRldmlj
ZSBpcyBub3QgcmVtb3RlIHdha2UgY2FwYWJsZSwgZXZlbiBpZiB0aGUgaG9zdCB0cmllcyB0byBh
cm0NCnRoZSBkZXZpY2UsIHRoZSBkZXZpY2Ugc2hvdWxkbid0IGFsbG93IGl0LiBXZSdyZSBtaXNz
aW5nIHRoYXQgY2hlY2suDQoNClNlZSAzLjIgc3BlYyA5LjEuMS42OiAiSWYgYSBkZXZpY2UgaXMg
Y2FwYWJsZSBvZiByZW1vdGUgd2FrZXVwLCB0aGUNCmRldmljZSBzaGFsbCBzdXBwb3J0IHRoZSBh
YmlsaXR5IG9mIHRoZSBob3N0IHRvIGVuYWJsZSBhbmQgZGlzYWJsZSB0aGlzDQpjYXBhYmlsaXR5
LiINCg0KPiANCj4gDQo+Pg0KPj4gVG8gYmUgYWJsZSB0byBkbyAzKSwgeW91IGNhbiB0ZWFjaCB0
aGUgY29tcG9zaXRlIGxheWVyIF93aGVuXyB0byBzZW5kDQo+PiBkZXZpY2Ugbm90aWZpY2F0aW9u
IGZ1bmN0aW9uIHdha2UgYW5kIGZvciB3aGF0IGZ1bmN0aW9ucy4gVGhpcyBjYW4gYmUNCj4+IHJl
dHJ5IHNlbmRpbmcgdGhlIG5vdGlmaWNhdGlvbiB1bnRpbCBzZW5kX3dha2V1cF9ub3RpZmljYXRp
b24oKSBzdWNjZWVkPw0KPj4NCj4+IEkgc3VnZ2VzdGVkIHRvIGRvIHRoYXQgaW4gZHdjMyBkcml2
ZXIgdG8gYXZvaWQgaGF2aW5nIHRvIGFkZCB0aGUgbG9naWMNCj4+IGluIGNvbXBvc2l0ZSBsYXll
ciBhcyBJIHRoaW5rIGl0IGlzIHNpbXBsZXIgaW4gZHdjMy4gSG93ZXZlciwgdGhlDQo+PiBkb3du
c2lkZSBpcyB0aGF0IG90aGVyIFVEQ3MgaGF2ZSB0byBoYW5kbGUgaXQgbGlrZSBkd2MzIGFsc28u
DQo+Pg0KPj4gTm93IHRoYXQgSSB0aGluayBhYm91dCBpdCBhZ2FpbiwgaXQgbWF5YmUgYmV0dGVy
IHRvIGRvIGl0IGluIHRoZQ0KPj4gY29tcG9zaXRlIGRyaXZlciBmb3IgdGhlIGxvbmcgcnVuLiBJ
ZiB5b3Ugd2FudCB0byBoYW5kbGUgdGhpcyBpbiB0aGUNCj4+IGNvbXBvc2l0ZSBsYXllciwgcGxl
YXNlIGRvY3VtZW50IGFuZCBkZXNpZ24gdGhlIG1lY2hhbmlzbSB0byBoYW5kbGUgYWxsDQo+PiB0
aGUgcG9pbnRzIGFib3ZlLiA+DQo+PiBUaGFua3MsDQo+PiBUaGluaA0KPj4NCj4gDQo+IFBsZWFz
ZSBsZXQgbWUga25vdyBpZiB0aGlzIGltcGxlbWVudGF0aW9uIGZhaWxzIHRvIGNvdmVyIHRoZSA0
IHBvaW50cw0KPiB5b3UgbWVudGlvbmVkIG9yIGFueSBvdGhlciByZWN0aWZpY2F0aW9uIG5lZWRl
ZCB0byBoYW5kbGUgdGhlc2UgcG9pbnRzLg0KPiANCg0KQlIsDQpUaGluaA0K
