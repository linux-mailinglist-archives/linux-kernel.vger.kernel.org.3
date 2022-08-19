Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3969B59A4CC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352037AbiHSRt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353017AbiHSRtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:49:17 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208A5248F7;
        Fri, 19 Aug 2022 10:19:17 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JGjC0f014997;
        Fri, 19 Aug 2022 10:18:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=HzgSvSVdaXRbttaJ9KZMwJTwwOc37mq4zZt6k2+bNHc=;
 b=ut0LW8jC1Hq1OVJ4nTZx0IpS1M73d5GXvK7Zpi9mTQDA/TQ7gdaDb2LmhUAoUBPfDac7
 9hnDfwR0TEEGQ4PUQ9AyDJ3eNV/P5LqmRr//ULRfB79NI2Pf7uWlG5RgLJoQETXbruui
 shn7LquDiKmXJAqLw3uHuV9aaPrYimHkkG2lace4gK2aXVQOD/Mc8wDcaIxsFyFbEQUm
 Z2b1Po+Eyf0Zyey9yyloQ5TGQXQqb147Flnu9v8MZDFaOxazME7DmD+kXyuluf5W2zt3
 JOv2FNKRqz/16zp2ffIvmMS4gD7hP+qQr/NLWYbekVG6+gXdxuIo9e1RgTJVQ235hkGO /w== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3hxayn0241-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 10:18:34 -0700
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3E0A14005A;
        Fri, 19 Aug 2022 17:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1660929514; bh=HzgSvSVdaXRbttaJ9KZMwJTwwOc37mq4zZt6k2+bNHc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=bMfoooOGuy8ugMqTJdIaS4rHJ7tVHonkzrRwVDGLLZTtxWbxgSbycj5JI9kniVOgw
         m8Dcl/oiuNSIrjMUb7R31MoE8FcDeA60koeMGTR6hFgtJE8YaEPJ2wiMufBo9uOw2o
         ThSZoED3jaBta9hGv1aZJ1VzpXq4J/DSOz5XwH1naaHmhwReGKJt6tnkiM0/kZ1CZm
         cj2OjsLNJXxRrZa1wO0n4CIxleOSbybh4bN3Emm8qpAAFZpqKgWf7SIwvOR9t/jP27
         OYZdyAghXySxefPFts/a/+4PDffAvqjf+m3pv08Onnnifzes4tDyFEPRpHps56AinN
         iva9vyLF0/ySw==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 171DEA0084;
        Fri, 19 Aug 2022 17:18:28 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 483B0400C5;
        Fri, 19 Aug 2022 17:18:25 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Fikwv7HZ";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4DSrKcUKPdgdVfHYhTY3JgB+mmaRwzVa/xirGoqr9LyOLqK8s0e8PzDSlKoupvmahYh4aHNjVaoqFNMaD1ppgK2D/Yg+/JoLXiY+NmZHJdsuuDOs4MxSFwMq6tflCoITGHIlg6XY4TW67U/6cumeXZVQCc9Zk0Hvj2MPdxZlqx7M+Bc7GAkEqaDwhOkyfVVDxRFIF7N7RX0y3lDTkZfktRum5Agn78+1qwgSV9XrUD6wX2s/xQi45Fga54amB1h9j6cU5vFaCRI1r7/pQ8nHLKQ1aTlyhaNJzvV5m2FUCgzL91/PuiMqaVu40fa1NDV7iszS8F2AXkSW/0x9vrgrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzgSvSVdaXRbttaJ9KZMwJTwwOc37mq4zZt6k2+bNHc=;
 b=Li88SL4ICFFAgJsnKvv28UEhOe0JlXJLQf44QTruieS1STzJ30rPIOZntZYlo0gjV2DqSstULDSLedx6A9R3PeRWTk0/4I8fT0H3C+KNtq+/rZuyhPplyXV9rCUNKxWelQOfQ+b9ihafiO3ixIgVm6yril/fozMtYNeQ0EZE76kRP8aPRq1eB14Indsa1P4FfHw5o+/Tbw6vh0Jm8GJT4jJnYGirfQTOqp3PrkFqEFWNg/qFNqDuU5ukQNfPJhj7Pr0mIxXOKfK8I39jvMtWrt2Vou8XpFOuPUSi6hc2WG/K+vXfZI1Ttr4OfXwUZpfFIjRRsVApWFTbokJEqcCmKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzgSvSVdaXRbttaJ9KZMwJTwwOc37mq4zZt6k2+bNHc=;
 b=Fikwv7HZ9QlOAnAvLjUYqIP2mCwykfQVMvdz7/+aXYG/pZUvMeGyff4INuMwPBrPfOrqekK3PB800cOp/+3sMvFUTffkesBARkKNI8Kvg98pYVCjIw6NxnEovHDqSs/nJxZ0+xl62H6Pw6wruS0XMUArByZwhRpBPSFaltRG6L4=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SA0PR12MB4367.namprd12.prod.outlook.com (2603:10b6:806:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Fri, 19 Aug
 2022 17:18:22 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c%7]) with mapi id 15.20.5525.011; Fri, 19 Aug 2022
 17:18:22 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Dmitry Bogdanov <d.bogdanov@yadro.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
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
Thread-Index: AQHYmw6F3vPaFvUH1UezRNMH+EVsTq22FgOAgACTPIA=
Date:   Fri, 19 Aug 2022 17:18:22 +0000
Message-ID: <20220819171821.estwvvfkkxo64bkq@synopsys.com>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
 <Yv9KWyevXLegwQcK@kroah.com>
In-Reply-To: <Yv9KWyevXLegwQcK@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eac981f7-23bb-4dd2-82e2-08da8206d189
x-ms-traffictypediagnostic: SA0PR12MB4367:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qJM/q5JPGmtQ/VjEMU0U/+xqQ7tWNmhdP82TkLeP8DMBCTHuXUp8RD+fCrEEhhMEYn5KpokllteA8x8sWOkiakAlsH6+goqWyDzIomA/3yFOqXHo4URNOrTuP6RBmQDxWltVwb+aeXjEo2CcWPuuV9guM8kx1G4/1yvou3rXXp94afr6HBC1jpdcunhmUAUswTwurpgj31Dp7jVdFOMWeQBvOwNXZrnYShAEjaYhmOpGgXtpIykstf9/ap1GDwQWMkDWg+UOkNpsC/0aHeARQmKTlX/DH39actglUNXtkAVzzesqb6mpCnkVUiPocG6qvaVT9JEYRkfl8cd6vBAprRTlaw8rTktJdGewKOqufr0dw5bG23oZDSt+l8HyV3Y15zTXRuWzme1SNICKXXjzleWz3sUEMJJfVA2SskSLyrWtIhmdLjln4QWH5a0gl7euzg9ZMVpMyPMnzh0eIHXzjM+jwv2wsO6IPlB9AKdVUZEIcKqdtGVto1/Dv2aPEMqZzoDwlwzk3/BMW8zYd2qj1cQVxe9xX21s9sGHLffv851wFMz/a5XYWRycvXffCW3M+JVrlvIV5cSTYgGfcw8hmw5eG4bo4luIfhk9cxwUOcuHzPPphmUmAvzrsnD6TYeMzuba0mNaLt14mUNgXeICrxQv++qaol/hLevxXQYDJqFAN7vwpg6BbqSBAQyycODnNcXFa5zhRHPiDT0KxnDZgfWejKfjFYBHVhy17+HYLmWFyDpvQRfTslSpQaEIOTXD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(376002)(136003)(366004)(396003)(2906002)(8676002)(76116006)(38070700005)(6506007)(66446008)(64756008)(66556008)(4326008)(66946007)(66476007)(8936002)(7416002)(5660300002)(6512007)(6486002)(41300700001)(478600001)(26005)(86362001)(316002)(110136005)(186003)(1076003)(54906003)(2616005)(38100700002)(122000001)(36756003)(83380400001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkwrUDBzelB3cmZDVU9iWUFMbituL1dXb2ZpL2czelJ5Z0tFUjhtbG5iTVJZ?=
 =?utf-8?B?Q0dIVGgycmRBQ1dBd05HU2hrVTBuNWFLM1BlcSt5VnZZNWdGdlpLQ1h5UXFN?=
 =?utf-8?B?OGF5Q2F6MWRRWVhkUityeEFJQ3lMbjQyNko0Z002ZGxTeUNJZkRXREJ2N0Rm?=
 =?utf-8?B?U3BVMnVoNlYrTytTRGxma2ZpL2xoczJkYWZDTUcxTkZUdWFtRktxTDZvdDFj?=
 =?utf-8?B?RFNkYnRha3JUYTI2MS9qV3RraUo0emJ4b0hFKzdITlZrR1lrcnozSURyeU5T?=
 =?utf-8?B?c1RsNTFxTEVscnZIRDRqcnVrRld0enhNZ0hxQWgrMXJkeStscnhNL3pFTU1N?=
 =?utf-8?B?eUNwMDhpV0NaM0llZ2IrcFB0UWo4d3I3WnRvTnBxWVYrdWUyTDFPTXY3dlZ5?=
 =?utf-8?B?SnlYSlRkRU9kU21vRm1ONk5kNU1aZ25HVlNUMGhsVWNFNjgzWmk1eXArS2M1?=
 =?utf-8?B?Smh4anM4TEVzczBaWktCZDh3emtnSkg1UmhMTkYrUXB4MGsrVU53WVRPWk00?=
 =?utf-8?B?UHQvU2NPcWpIMjJFNWJ5OE9EMHllTHQrZlQvcDRRcGNNaXpIS1Y5M3hhSTF1?=
 =?utf-8?B?WFkzZFpyUjl5REdEdVZFZHZ1bzREaklvcGdnV2Q4TjZYSGhVcmZScWxpVERN?=
 =?utf-8?B?S2lRUlptcE5mbVBVMDJ1M1RzSE5QUHVkZGE0aXVqOXE5Mml5TllEa3owSWYw?=
 =?utf-8?B?eHkxZXZDODF3dGV2bzZjNUZlNXZId0ZaWExrWkowekhKbktnR3dOVWNEZUpF?=
 =?utf-8?B?dVl5N2NFaHdnNUxvVGxFOTZsL09EcnZ0eFJmeXJpcXEyVkkwMmJUclBwWVRz?=
 =?utf-8?B?Z1NEb2g1RXhOYm9zMWdKUVhKUDhQRUh2bUJxL2IwKzFqMmdHbE5BRmo4YnRC?=
 =?utf-8?B?UmFUTmR0ZW9wdG5ubDRxN3Q3RmplUDVKdC9TZDR4K0c2bGVBYmcrLzFBNFUx?=
 =?utf-8?B?Vi8vbnZ3aHRxYjRkdmg4QUpPM3hLM2s0bUU1WkliYzNoUmtZWFROMCtFL21v?=
 =?utf-8?B?QW9rNXN3K21nYnFVTzFkSVpFTnhMUCtCb2Zaa2toQ2N5NkY5SHZBYnhJZ0Jj?=
 =?utf-8?B?TjBFbFNJQ2VDTHFOSFZhcDRGL0lGZE56S0huT1V2QS9DWE5DMHI2Y01PZ0pK?=
 =?utf-8?B?eFB6R0pXZmw4M0dkT0thbkVKQmtkN1VKM0JiSlFiSEdFZmpBMWxIcU9Wa2JU?=
 =?utf-8?B?OW1IYnAyaVF3a1lvTWFSa3hsdUxZQndTcXE1YUoySTBKUDh6OHhOWlRtUGVE?=
 =?utf-8?B?bHQxSnBHdWR3YTNXd2hTWkQwQkVWQ0RKcnMvQ1VIN1ZYbEJxaWdNTWRiNytz?=
 =?utf-8?B?SnltcTdzTVJiS1pnTEZVdVhETXl4YnRQQm53VG5tQ1FDWnZwZDFPejIxalov?=
 =?utf-8?B?bjVBZkl1Y0Mzdi9MVHJuM1hlT1Y5ZGFrT3kwTTNjNEduRDdTRE5KVHVJaW9M?=
 =?utf-8?B?MlkvSVh5ZjREWHVXa1QvNkRDZHptOVlRZGExUWhXOWovNUExUGZ6L1FBMEhO?=
 =?utf-8?B?WlJ1ZGFxeWZ3VHZJQ05JK21JR2lMa09KWER1Qk0wR28yKzhOSUx3M1ptdzZB?=
 =?utf-8?B?L2RrUkMwRG1ETHp4SHhFck1yRklWdVB3bExaYlBETHB0OXB6aFV4cTk4eEZt?=
 =?utf-8?B?OUZ1aXlwME5wa0lQOGhpZS83TDhGeldrUFFpZ0xQL3p3N0hxM2FSNDZxVnlp?=
 =?utf-8?B?MXM0V1E2N1kyUEpqZFFPWTJQZnJzcytvM1Npek16QUFsMEh3QnBVYi9qZzJq?=
 =?utf-8?B?Uyt1Y2o4Ty84ZVBReXpNaGpRbEtOc29kMnB4V280c1ZFMGxlaUNBL1lhVjRG?=
 =?utf-8?B?Q0VkSjNEMEdEUDZ0ZHVUQzJiWCtHbTcvdWRJeHhoRW1NRG4yMGIvdFhSb1JN?=
 =?utf-8?B?UnFBWGxESElGYlpnRGdOdWxwTForb2hKbnJMcXNjZytWTDlraDZEYnBxNmtN?=
 =?utf-8?B?T3VacXozQ3llQWVUcFlZeFc5V0hLMjNqaExQdTN5bmNENGJoL3lSRHlsdnk1?=
 =?utf-8?B?RFhoSHhTNVRSYWJxOEIyd0xpeDBZYmttd0k2dHZjandVdVZwM0lHeEx5QnRG?=
 =?utf-8?B?TDVnNVVFRHhRQ1JuTjQ4ZlVlb2toSUltOTlTK1kzcEtMc1JBc2J3SWIxY0F5?=
 =?utf-8?Q?hjrf1yExftfuKsjmpZSk0oMTU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0EC6CF073913C945985F75255BA30C0A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac981f7-23bb-4dd2-82e2-08da8206d189
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 17:18:22.2742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FljvrTtE+2S5vys/YJMWFu0A+gtqGioJubyLPhB7G7uHLK20StNHBrcuxWALGT3v5TcfopuzsOSZLI6EJllXmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4367
X-Proofpoint-ORIG-GUID: 7eNnKYFgYia_qCxzQAv9W3Q3P9YP8n9f
X-Proofpoint-GUID: 7eNnKYFgYia_qCxzQAv9W3Q3P9YP8n9f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_09,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=7
 clxscore=1011 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=7 phishscore=0 spamscore=7
 priorityscore=1501 mlxlogscore=111 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208190064
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFydGluLCBEbWl0cnksIGFuZCBvdGhlcnMsDQoNCk9uIEZyaSwgQXVnIDE5LCAyMDIyIGF0
IDEwOjMxOjIzQU0gKzAyMDAsIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToNCj4gT24gTW9uLCBK
dWwgMTgsIDIwMjIgYXQgMDY6MjY6MDFQTSAtMDcwMCwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+
IFRoZSBMaW51eCBVQVNQIGdhZGdldCBkcml2ZXIgaXMgaW5jb21wbGV0ZSBhbmQgcmVtYWluZWQg
YnJva2VuIGZvciBhIGxvbmcgdGltZS4NCj4gPiBJdCB3YXMgbm90IGltcGxlbWVudGVkIGZvciBw
ZXJmb3JtYW5jZSBlaXRoZXIuIFRoaXMgc2VyaWVzIGFkZHMgc29tZSBvZiB0aGUNCj4gPiByZXF1
aXJlZCBmZWF0dXJlcyBmb3IgdGhlIFVBU1AgZHJpdmVyIHRvIHdvcmsuIEl0IGFsc28gbWFrZXMg
c29tZSBjaGFuZ2VzIHRvDQo+ID4gdGhlIHRhcmdldCBjb3JlLg0KPiA+IA0KPiA+IFRoaXMgaXMg
dGVzdGVkIGFnYWluc3QgVUFTUCBDViBhbmQgRFdDX3VzYjN4IGNvbnRyb2xsZXIuIEl0IHN0aWxs
IG5lZWRzIHNvbWUNCj4gPiBmaXhlcyBpbiB0aGUgdGFyZ2V0IGNvcmUsIHdoaWNoIHdpbGwgYmUg
c2VwYXJhdGVkIGZyb20gdGhpcyBzZXJpZXMuDQo+ID4gDQo+ID4gVGhlcmUgYXJlIHN0aWxsIG1v
cmUgcm9vbSBmb3IgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQgYW5kIGZpeGVzLiBIb3dldmVyLCB0
aGlzDQo+ID4gc2VyaWVzIHNob3VsZCBiZSBzdWZmaWNpZW50IHRvIGJyaW5nIHVwIGEgd29ya2lu
ZyBVQVNQIGRldmljZS4NCj4gPiANCj4gPiANCj4gPiBDaGFuZ2VzIGluIHYyOg0KPiA+ICAtIFJl
bW92ZSBtb3N0IHRhcmdldCBjb3JlIGNoYW5nZXMgZnJvbSB0aGlzIHNlcmllcyBhbmQgb25seSBr
ZWVwIHRoZSBtdXN0LWhhdmUNCj4gPiAgICBvbmVzDQo+ID4gIC0gU3BsaXQgdGhlIHRhc2stbWFu
YWdlbWVudCBwYXRjaCB0byBzbWFsbGVyIHBhdGNoZXMNCj4gPiAgLSBEb24ndCBzZW5kIGZhaWx1
cmUgVGFzayBNYW5hZ2VtZW50IHJlc3BvbnNlIHRvIHRhcmdldCBjb3JlLCByZWR1Y2luZw0KPiA+
ICAgIGRlcGVuZGVuY3kNCj4gPiAgLSBBZGQgVUFTUCBicmluZ3VwIHNjcmlwdCBleGFtcGxlIGlu
IGNvdmVyIHBhZ2UNCj4gPiAgLSBNYWtlIHZhcmlvdXMgc21hbGwgdXBkYXRlcyBhY2NvcmRpbmcg
dG8gZmVlZGJhY2tzDQo+IA0KPiBJIHdvdWxkIG5lZWQgYSByZXZpZXcgYnkgdGhlIHRhcmdldCBt
YWludGFpbmVycyBiZWZvcmUgYmVpbmcgYWJsZSB0bw0KPiB0YWtlIGFueSBvZiB0aGUgVVNCIGdh
ZGdldCBjaGFuZ2VzIGludG8gdGhlIFVTQiB0cmVlLi4uDQo+IA0KDQpEbyB5b3UgaGF2ZSBhbnkg
Y29tbWVudCBvbiB0aGlzIHNlcmllcz8NCg0KVGhhbmtzLA0KVGhpbmg=
