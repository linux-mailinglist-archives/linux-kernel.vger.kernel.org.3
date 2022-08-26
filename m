Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C315A1EDD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 04:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244607AbiHZCff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 22:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244818AbiHZCfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 22:35:23 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C4913FBF;
        Thu, 25 Aug 2022 19:35:17 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PNVF22031767;
        Thu, 25 Aug 2022 19:34:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=tDgjqN4zbjgP8B0TglOuFd2MtN6dPXLizG7tRIJgoBI=;
 b=XXTRu1a6QHQlLoOAJ/TZiuKXF1pg0skW01ghFhqrACcnijNwQNKfnyX1jZiRKCX8jsF/
 iWk6SLNpgji6bMlIltm8EaOuFaJ7xJ2A5pEyzVO34ArJ6ZG3D0RhaJnugAs7fiL2mBDC
 0IoaFPs+iYxQ4nf4klNxS/Y8MxAVRfRAQtW8N4NdCYppHvc/tuI+6yVCQqGMHhDr4COa
 BWPABEBvjTub1lpB7oB8mxBAK8Klalz45YGMJISAT2zqI/CWWPFo1zyqlN1nY3+6Ji9l
 SLYm3D/4eIUn7lBsXbK6nvNUlDQKI4NpBQMlaIQVR5RXaO9FE1hnjoGIZnrZp52ev5am nQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3j5abrpyu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 19:34:34 -0700
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 497F7C00F3;
        Fri, 26 Aug 2022 02:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1661481273; bh=tDgjqN4zbjgP8B0TglOuFd2MtN6dPXLizG7tRIJgoBI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=bUzzaTYIT4cVZKtkDRNYQPy50KoHO6fPMq+DxjX2lPHXso2VKI+Ezo53u3pVkByr7
         ZbKCsFlwyw0WVA1s/WjLtv1/v8vN1QVMFhUMBzZH9nfTNNzeTdtR22i46AIEaT4+rX
         3jm/W8R15OqkfubbJNyTRrvPEW/mxKUVlN2xhVTaZEVA6KUYqDIXJ0etIreJRsXiN3
         jQQf5Bubh7iTtBJfUWXGVtTr8A2ZGS21DTupS9+qU+x7wgJHCnWSmjTDXrhZiMs2eE
         6k1UAhMib815RkcxmjumWYgB3gDv91fKo0Mr1wTGkFynyPfwWCHVUT32HybX+O9wif
         QnuUKspguhBvg==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id BD9F8A0076;
        Fri, 26 Aug 2022 02:34:28 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 9CF9480199;
        Fri, 26 Aug 2022 02:34:25 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="YE1EY7+u";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZ9IjhhHlZmBQYaphYW2g9ueSU/bIIy9UF0I9uaSEIVwCXnWh98keV45azBIDQFYOncvFjadRwbPW7Fj2keR0DBl1Ih1X6vdFWX6v0fwehGccbWcPECgewzJndOOHJtHRE8nd4/XQic/R0/0RdGOkJtrzYTXK3o09Tl93Qj04+6ZCckgSBkY5zWRtduRGr5GaoTgTzIYVzAD1i+WxFLIbZle/Uo57I4lFDK5zXH2M/rxl7TjVTLDSvDQvq46I+DPBJKEeXxG2KmeBHajGN4sqfCciR7wP76KULUOUCTKkoE2OA8SgSsKZ2KcL2BPyqs0ii1CgyKM2cTKXW84E+ZdXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDgjqN4zbjgP8B0TglOuFd2MtN6dPXLizG7tRIJgoBI=;
 b=X8ccExV5MMUvnN1b+rx5uZYzb7zIqthrNSQRPq1CLphQ5vehn7P6TrP+fnGEYkszhOyYlw/lDoQJLWUBGCBTO7GhzKemwGRuZg91b3zEzbjLjluseZxoBoztgrPObErDgafi7qHZmi11n/bXuQYUmA/vfYlhjPfoO5ePRGcTG+lUQQ0DfEOzyBcFX2hy/l2SAnbj38hgmKrfQ1rk3fE9zscLunxC+DqcucDpkSU8zpZ+w38SKS0yLZY7YXaY2JoBWOQRPocq7+lWx2S+YA652yzbcvQG23JHMG8yjQ4ya5orymDgv9RbdEsQcfx9i+nHwlgZXvV0tRS/veje1LjZRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDgjqN4zbjgP8B0TglOuFd2MtN6dPXLizG7tRIJgoBI=;
 b=YE1EY7+u2+z7cwMx1ZjY9016zPYRMGiYmLzsp3fJrdW3YfzPFeJPscmBaiBg3Q2/yGLOrp7UfrSMwTJDY7tOApVDCCzezZxmGRIfFg21Yia/AZ9rQFHZgFt6R2tgxleepFw/y3UjaqI/Q9L9FiIQotJ5iGrhVeUSlP668kdSxfQ=
Received: from BN8PR12MB4787.namprd12.prod.outlook.com (2603:10b6:408:a1::11)
 by BN6PR12MB1348.namprd12.prod.outlook.com (2603:10b6:404:1f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Fri, 26 Aug
 2022 02:34:22 +0000
Received: from BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::34d0:5282:1e1e:98d5]) by BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::34d0:5282:1e1e:98d5%7]) with mapi id 15.20.5566.015; Fri, 26 Aug 2022
 02:34:22 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Dmitry Bogdanov <d.bogdanov@yadro.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Youn <John.Youn@synopsys.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 00/25] usb: gadget: f_tcm: Enhance UASP driver
Thread-Topic: [PATCH v2 00/25] usb: gadget: f_tcm: Enhance UASP driver
Thread-Index: AQHYmw6F3vPaFvUH1UezRNMH+EVsTq22FgOAgACTPICACglBAA==
Date:   Fri, 26 Aug 2022 02:34:21 +0000
Message-ID: <20220826023404.un6jmymwjfortotu@synopsys.com>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
 <Yv9KWyevXLegwQcK@kroah.com> <20220819171821.estwvvfkkxo64bkq@synopsys.com>
In-Reply-To: <20220819171821.estwvvfkkxo64bkq@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 699505bc-25e8-4298-a64d-08da870b7bf8
x-ms-traffictypediagnostic: BN6PR12MB1348:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5AOJduuAJG/esqeSTryx2/ln79fuQAgFPs8ODpFDetp5eIgSHONpKSQcsk0/uEH3h5/eJBiJUPh6FTuHJeMz15gWhtbRuzfNsesgVYI1eyYBAwplQTHmXKjqDgJQtsYVg8r9nJMAZXFP5wmfxZkHvadxDD+pfonCg2eI5Q8Kur3PkXE3R/FW9DXVkxP7P4ZjHMP/VRGIxRApjGdA3hzUHcSbRLNOa13hQOg+Y7QTUvVGZxiXu45sLRhbZi9mgHT9FeOfVJLCXp9MglKVyd7ZGkQu4UfiNSFvAs3qgnI2BpWFhHiI2ZLMn/XtmGzAjunDOh+9+xEsvF7v+nmYyrccG8/9aTXktyGvX5NmwfPhEnq0wjvdOGq323o55OB3qF0iNgnerEEcux/D3lnUerKTahB4TkMgUYwnxP2nRx1qZDspf+delZDmq2i4TSfJrZaGRsoPmlwpfb7tJ62tV/to+UwX+jn602y90TAsQU0m48syou6nq8BAC4MQwWrnIemmdHVhiIE1Z5yqTg9abkf3VHT79W1H/32SKYzQTnGq86I0zBDvMYXTwfEsO96pT0TP2JJnKscQcjlYwDEgIFiY8p1p5rPmnmvoxOYGzrGuM6xCgTNj74Gmo35j99xv/2zxfsyfxRqGSg+3AGZK8MkusU4HLH42SJIUwq0ltdq2FyhU819X0tlCSBxs716uA7E1N3BQ0wyvBJ+4Tf7PSEuOHX5sN0YIJ8JP/kRX4tKZORQDj2CkGEMMnmiO5ZsVk9yipPNh9ZxyE9K21s4NEMFcyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB4787.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(396003)(39860400002)(136003)(376002)(86362001)(38070700005)(122000001)(38100700002)(91956017)(316002)(54906003)(110136005)(76116006)(2906002)(8936002)(5660300002)(7416002)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(2616005)(186003)(1076003)(83380400001)(478600001)(71200400001)(6486002)(6506007)(26005)(6512007)(41300700001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXI5RGVTSkVZQnA3OTFkV0ZjZ0RWMStrTEU0YzJYVEZOLzdDU3lYbVF2OEEy?=
 =?utf-8?B?OUtobGR1UFI1Y3dzdlJzbmYwWTh4b0dzZmFjRVpicXd3ZmtYMnJUNnpPdG1U?=
 =?utf-8?B?d2Uxemh6SDZtNXYxbVBlbDYxK0FiM2lzeERIWU5MMURaSmJ5cTd6aWNOdkQy?=
 =?utf-8?B?NHhrVkFrS1NGRmcwRlA2WlRwZjZ1TDdsMzVTMkRVNjF6b2gyUFJSeGRZbHJz?=
 =?utf-8?B?dG5ld1ljbEdmd2xMc0R2a0dWNURWQ0lUWDVHQUZXZjJXekVKWVg5NXJqYVEz?=
 =?utf-8?B?YllyL3dWbWx6a0NHRml4SG1mRkZuSXB3cjZMYjBpWGlYMHdGSFV3WDRUclF6?=
 =?utf-8?B?VE9IM09RUFMxZnByaElWd2hCSGhWSzEySXlrVzJrT05NU3dHZ0xhd2FyeDFB?=
 =?utf-8?B?VlplUlJpNExETEdjUUhjdHcwcmxCdzNPV2lrZmdFb2o0dXBpWmdUbEZpallm?=
 =?utf-8?B?VFdBenNSeVd6OWlOaHA3d1l6ZWZKY1ZGc1ZuWlBNeVdRaEw2UkYzaDB4ejhP?=
 =?utf-8?B?NE9OUXRVaWF5MWRqeXVUUjJuUlB2Q0NaYU5UR05mRFh0MzFsNWVsSzJnV09C?=
 =?utf-8?B?cHI1TDIvb3dTLzBwMUk3bzBHYzJkN2VqUktNaGp3V2FKNktQcWdsdnBkRkd6?=
 =?utf-8?B?Zzh1OEVETGpOYXBKV1pzUlA1SzMwLzB2ZWhsQ1RKNXdJOEx4UEtoeUttRkxw?=
 =?utf-8?B?MFB3UVBRWkZGcWo0NHBzb2trYTF2L2cwZjBMRDEyb2tOd1NENSs3MVRDbkdS?=
 =?utf-8?B?L3NBdTNOTXpqMG1zeDBXVVV4ZHFwUTQ5dlA5RnFPcnlQUVlDbHRscnVmTkdY?=
 =?utf-8?B?a1Y3Vk5BSmFHaVdsN1dYaHk2OEtwcUhNNnFNNWV6L2dOOVptS1VDTGFXKzFP?=
 =?utf-8?B?Z0JwNlpWc3JzbHlHRllaNGhXQlF2eDlkaEpiVXg0bFB0SjA2T2ZBZGRLRFVz?=
 =?utf-8?B?TmI5L1lFTjlHRGwreUlmVStWOEREWG4wODhPVXVFajZoenZkc2VFaWtscm5q?=
 =?utf-8?B?N1NGT0c5dThlNUM0SU9iK1hxVjJLdUJGR2E5NE9pbmxnU2ZCWEZZTFVFODVL?=
 =?utf-8?B?UWFKUjRHNmNWZC9ncWMvNk1pcHdPenBYS3k1U1JYeCt4YnFVeUxZMGFLQjdl?=
 =?utf-8?B?TjRxVytVUnhRQS9aRnRqV1RPTDFCbEcxSGJySUxVd0FxbzBpUW9GUmZnNER6?=
 =?utf-8?B?bVc3ZmN1NUMxK2JXaVRHblQyUjhWbmdvS3E2enN5T1lGb3JDZGJOckNsQkxq?=
 =?utf-8?B?NzhVWFd2RVFpWEF3amVtU2xLTVUvMFRUaWdiSVdLUk5uWXh3SDgrdUlOaFQ2?=
 =?utf-8?B?SjhnSUFBcHlyZ1A2YXZ0MCthWU1xMmp0Sk5HaHMzeDFiUllNeFRLKzFEYThN?=
 =?utf-8?B?VFVBcFVuOXF0d0prSGJNY0YwbzRKZmdWSHZTTm5iY0w2UXZWTk9ESHZvcXNU?=
 =?utf-8?B?USt2U2d5em9OOFZ4VmtGaUh6bkFnQWVWRzBWREVSd2I4ODI5NjRTbmplbGdW?=
 =?utf-8?B?ZEU1enZxZ2hXeEtBbkl4UWpFZ0xKcUR0a3gxS3Z0eXFQREV1OWhjbGUvK0hy?=
 =?utf-8?B?U1hmT2ZrODdIVU5TU0hVb1VzWkVjVnRKODJWVVdQTkFKcXVNQ2M0TjdQKys2?=
 =?utf-8?B?Ukxma0p4ME0ydTlHMlRMY3lEbmNPNEZUYllYc3poOU5uSWpxQ3JuSllsN3dC?=
 =?utf-8?B?eFM1THZZMFhESE5SQmVGVFhRcCtFY2RRTUc3RnQzQjlLR1VyNTB3ZnNwOFh4?=
 =?utf-8?B?eWw1VVI0MWRYQmdYSWNWS1o4UG5TVkZVUXZsWTk4NUJCSnNvOVc5N0lXTjZN?=
 =?utf-8?B?UzMwOWF6bTJrNjFlVVlaR09iSXJXRDhnNS9HREtKYVYxZVVmdkJuQktpOFFC?=
 =?utf-8?B?M1ZJRVNLS2duQ1ErRS9hS1ZRTnVwWHNabmxuUXRHenhYN0RWT1padFJVaXlY?=
 =?utf-8?B?NldkM2xSMml6RFhVTEVpVHkyVE94WmhaeGRIRFpWd0hRQkZhZHlsNzQrbGZX?=
 =?utf-8?B?UUNJVDE5dTZ4cmRDVFg3M3RudEkzNHNtb1NxaEZPN1k5ZHcwL0tqcWtUdTRo?=
 =?utf-8?B?SyszY2FVTnMwK3drcVZndTdwWUswZVNUUzV6dmhPbWY2YkJZcXpDcFY5b1JV?=
 =?utf-8?Q?JhF4gGzQkNXE5O+d/kiwnX5NH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <145DE1A491928B46A9A56B2A55336820@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB4787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 699505bc-25e8-4298-a64d-08da870b7bf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 02:34:22.0004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bdMq4WqcNsMGPqdeK0LitFVmY9MRedd5w5HdAFREn9d9ZIsBq2sYj7PKxdsSBpoGOQCNzuDQI0QeCU5aLrZqlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1348
X-Proofpoint-GUID: _T5P2zqEA-edt0MWWCG_gf_jRcT0BjuM
X-Proofpoint-ORIG-GUID: _T5P2zqEA-edt0MWWCG_gf_jRcT0BjuM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_11,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=16
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 mlxscore=16
 spamscore=16 impostorscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=73 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208260008
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBBdWcgMTksIDIwMjIsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gSGkgTWFydGluLCBE
bWl0cnksIGFuZCBvdGhlcnMsDQo+IA0KPiBPbiBGcmksIEF1ZyAxOSwgMjAyMiBhdCAxMDozMToy
M0FNICswMjAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3JvdGU6DQo+ID4gT24gTW9uLCBKdWwgMTgs
IDIwMjIgYXQgMDY6MjY6MDFQTSAtMDcwMCwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+ID4gVGhl
IExpbnV4IFVBU1AgZ2FkZ2V0IGRyaXZlciBpcyBpbmNvbXBsZXRlIGFuZCByZW1haW5lZCBicm9r
ZW4gZm9yIGEgbG9uZyB0aW1lLg0KPiA+ID4gSXQgd2FzIG5vdCBpbXBsZW1lbnRlZCBmb3IgcGVy
Zm9ybWFuY2UgZWl0aGVyLiBUaGlzIHNlcmllcyBhZGRzIHNvbWUgb2YgdGhlDQo+ID4gPiByZXF1
aXJlZCBmZWF0dXJlcyBmb3IgdGhlIFVBU1AgZHJpdmVyIHRvIHdvcmsuIEl0IGFsc28gbWFrZXMg
c29tZSBjaGFuZ2VzIHRvDQo+ID4gPiB0aGUgdGFyZ2V0IGNvcmUuDQo+ID4gPiANCj4gPiA+IFRo
aXMgaXMgdGVzdGVkIGFnYWluc3QgVUFTUCBDViBhbmQgRFdDX3VzYjN4IGNvbnRyb2xsZXIuIEl0
IHN0aWxsIG5lZWRzIHNvbWUNCj4gPiA+IGZpeGVzIGluIHRoZSB0YXJnZXQgY29yZSwgd2hpY2gg
d2lsbCBiZSBzZXBhcmF0ZWQgZnJvbSB0aGlzIHNlcmllcy4NCj4gPiA+IA0KPiA+ID4gVGhlcmUg
YXJlIHN0aWxsIG1vcmUgcm9vbSBmb3IgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQgYW5kIGZpeGVz
LiBIb3dldmVyLCB0aGlzDQo+ID4gPiBzZXJpZXMgc2hvdWxkIGJlIHN1ZmZpY2llbnQgdG8gYnJp
bmcgdXAgYSB3b3JraW5nIFVBU1AgZGV2aWNlLg0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IENoYW5n
ZXMgaW4gdjI6DQo+ID4gPiAgLSBSZW1vdmUgbW9zdCB0YXJnZXQgY29yZSBjaGFuZ2VzIGZyb20g
dGhpcyBzZXJpZXMgYW5kIG9ubHkga2VlcCB0aGUgbXVzdC1oYXZlDQo+ID4gPiAgICBvbmVzDQo+
ID4gPiAgLSBTcGxpdCB0aGUgdGFzay1tYW5hZ2VtZW50IHBhdGNoIHRvIHNtYWxsZXIgcGF0Y2hl
cw0KPiA+ID4gIC0gRG9uJ3Qgc2VuZCBmYWlsdXJlIFRhc2sgTWFuYWdlbWVudCByZXNwb25zZSB0
byB0YXJnZXQgY29yZSwgcmVkdWNpbmcNCj4gPiA+ICAgIGRlcGVuZGVuY3kNCj4gPiA+ICAtIEFk
ZCBVQVNQIGJyaW5ndXAgc2NyaXB0IGV4YW1wbGUgaW4gY292ZXIgcGFnZQ0KPiA+ID4gIC0gTWFr
ZSB2YXJpb3VzIHNtYWxsIHVwZGF0ZXMgYWNjb3JkaW5nIHRvIGZlZWRiYWNrcw0KPiA+IA0KPiA+
IEkgd291bGQgbmVlZCBhIHJldmlldyBieSB0aGUgdGFyZ2V0IG1haW50YWluZXJzIGJlZm9yZSBi
ZWluZyBhYmxlIHRvDQo+ID4gdGFrZSBhbnkgb2YgdGhlIFVTQiBnYWRnZXQgY2hhbmdlcyBpbnRv
IHRoZSBVU0IgdHJlZS4uLg0KPiA+IA0KPiANCj4gRG8geW91IGhhdmUgYW55IGNvbW1lbnQgb24g
dGhpcyBzZXJpZXM/DQo+IA0KDQpIaSB0YXJnZXQgbWFpbnRhaW5lcnMsDQoNCkdlbnRsZSBwaW5n
Li4uDQoNCkJSLA0KVGhpbmg=
