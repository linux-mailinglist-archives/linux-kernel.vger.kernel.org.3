Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077255A2FEE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 21:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237904AbiHZT2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 15:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiHZT2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 15:28:04 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C20D2B15;
        Fri, 26 Aug 2022 12:28:03 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QG5mu0024962;
        Fri, 26 Aug 2022 12:27:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=LDu8wigSDQpM/HIKhoNtoa4h/gZjOUFexxYEeUgf+Lg=;
 b=ilM+EeVwDTCv0q4AuAaMga3Ce5JVQThwncObI030K3KAP+eT3CS6WQ+Kd67hE35V3ssq
 +RRZXBWhOWGzqR5cXjymPzM/7tC1clI10/Mb1MWLW+BCxHaBckxXp1hNFsU7g1SNfJdz
 0+Jyy9BalIvXiXuVFfXeY1aCnxQBK99Vq8dNmZbrx8qxxnep1orLgcVCsSHJQi2Fkb0J
 5IX9Xcr4RZIdh57/q+MSl69uscurVP2lIw3zsQhKrtGEiy4EkliOTVOPRBXjhJS/b+QX
 RZoLGbSjPewMluBcAB10F369hRJTz0hU4fa3i8n1bpBdQumH9aW0CveBiC92MPKWMExP XQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3j5a42v5v7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 12:27:55 -0700
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1EE834009A;
        Fri, 26 Aug 2022 19:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1661542075; bh=LDu8wigSDQpM/HIKhoNtoa4h/gZjOUFexxYEeUgf+Lg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=agXqpxI6/OccBJmyFb6ks/Qj2ukejaEUh9jnsf342P792BmrnsrQj29lGQMhskNg8
         Eyq3s4O8O0Io3akoIK88d2MUbURGuKA80MUvBNMpGr4m5L5uEhWLFLm3d/C9P2gBCM
         SNdryKwFnKzKcppWxHBv4u4LLEHjcZevWGuaiy/KXxJTJjSrt3NBR6syyKH5TVJVAc
         Zhgk6nZtmqZgL8T6lK0n0gz8FoJ5jjI9NkfHrtsLG5TEUvgYMRdW+g9HhplQ19XGHD
         /YwAalaeQZIh92B+qVVdoz6P+lQew2AKdNyJOGe3O6KFBtQ8yaPEbpLnX+xPHdE87M
         xZrOxpIkLFaRA==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 015C0A0099;
        Fri, 26 Aug 2022 19:27:54 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id E8F51801FD;
        Fri, 26 Aug 2022 19:27:53 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Piul98pH";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+8/eX+PjySZdGxgtEOX6ETYdE1eZmvayPPdG+Ctt2QiWGA6ANi/WE1AP5u0fhlS2cig36EKTJvPMzrBmn3CQ431oNEUq0RZAMw0xf8KdzwrnLDgkWcMSTAIaq37SJHMgO9E2titBpX6CcEJJlYS8Aucx5TWvP+3oDQGpRWD9XVcX8rer/LOXpx4cnXhdusRLnMjKc+shSY+e+7bUklG2dlusRNoX1XVwChWkiZRzwOu/kh5tzSFQKQ84vMUR4mVgp+x0GK2MynUrbA+gIRVY2XtV0KLP8AjcNsT1i2Q1DaECYZiLEa0sonlY62hqvydBHF8zBR7E2bajgovoRsuyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDu8wigSDQpM/HIKhoNtoa4h/gZjOUFexxYEeUgf+Lg=;
 b=DLe53uGfvE5qzuBR29W1Zq64+U8V1r668y3RGEJc1ARTBjLLaOF8WILIDgqEcj66kMZDyZTWTgeNL5LowBiRlmsVh8uiJHaFbZUNgRKNuj0utGuTkjf4Vp90c7LdhzeeLDNSMsVF3lbVXR6MCeXtU3VCMPwH7XrD9PL483LJFThmLBczIr95lDOvevvDGdY8DHrOzF7TnCGNyQYgY2hEz5T7sCfQiseit2ry+scZVZo1DZ/YBfBoJfYpPnmUT0ySOol2gzi0CR4WMcwYjV07jFgATJ+gsaSBo4C3vojWtccqHwpocOPHvl1f+9mZn5TcVgjp2hqdgMbIuHgl+t1ZlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDu8wigSDQpM/HIKhoNtoa4h/gZjOUFexxYEeUgf+Lg=;
 b=Piul98pHeSXmdl5T90AGKyef6mK9G7X8mKAQuEe+PiFdSXDnXC4W8qr2AaEUCKN0db1hr/5A/qX8wOPzdBTwq+7LV3rNW1zBVhSI/l7IsKmAAxOPOPhn6JK+SJS8Dj/3oAu89V6/oSmGvSLrgc7rixo+uBmjTKtn935QA7gUFEw=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CY4PR1201MB0023.namprd12.prod.outlook.com (2603:10b6:910:1f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Fri, 26 Aug
 2022 19:27:50 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::69ee:633:f068:3ca1]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::69ee:633:f068:3ca1%3]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 19:27:50 +0000
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
Subject: Re: [PATCH v2 24/25] usb: gadget: f_tcm: Check overlapped command
Thread-Topic: [PATCH v2 24/25] usb: gadget: f_tcm: Check overlapped command
Thread-Index: AQHYmw7fjQ/m1/Mw20GSVulAhejhx63BPDCAgACRhYA=
Date:   Fri, 26 Aug 2022 19:27:49 +0000
Message-ID: <20220826192743.slded6tawfswohhu@synopsys.com>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
 <0150d7b669ad80e94596b371cbce0460a327ce7c.1658192351.git.Thinh.Nguyen@synopsys.com>
 <YwikndRzQM+ToQV5@linutronix.de>
In-Reply-To: <YwikndRzQM+ToQV5@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c443fd2e-e6ba-4966-f7eb-08da8799104e
x-ms-traffictypediagnostic: CY4PR1201MB0023:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CFk6c6UfSoDxVScKVPRmW4uwnyn2vHV1x0K/Ah9EmmyUCQi6eflzWzuCwT0lxKxJ5zVMj8+i+RRPQrbmF3wWlR2mbsztT8mojcMExRD75v4VJ29qa/c4/1aSNtESpDI0eMJlhjzHE5YhVREDkVpwCir7yOURJAbKZbgGAUV+U1E0dW1wu6pyQi6W3J7B3pTOG51F+2q2oWgfIWCgxUm7zevCKjj11gotn3c7nAzf6aNxGvwNP1yz6Ta68OXHhaf4EZEB0djZX8UDs3CM2k9oZcHsaaqLvWnW8bSNSshmfE7DOpIFCtQ8gKiffms8oV9LDBt1l/P5RjPrXSYaBkyTBwiFG0/AtUE96B3o5t4kMhBm0U1dNX/POTQcwhVEexraPkx0OOsEnF5ybMDaAhiJ5dedAGtcJzqUfaQSVEs9CGNxCfQ/zTUDJyya147ZZKe1t48oKc0UntR5Ag0nMcTqx7ptlxsctAHH6pwmzeUZOCKbI2Ifw+laLnPVs9TtOkJVrDmgaDZxy7z5pBefqcqp8Vz8pUEburJKzkzZWypJRosfLee7SwsxZXwTKJqnnGsUBF/4ldgBzF+gY6k7h/kHS5gk4uJ3oi1GxzaMt4xFDA25a6MoQv3RAZSQe9UGqhC6JWxMxGsfXPjF+hgQ3jvL7ziAqgW5dNjR5oIZwhHpQVr7KM58i1bYoxNOeMsBiKAvRVrKrkuccV6dl8G2KjbyxMHH8mK5e0ZQdy4qLaAV3uezllGCcG0346bHVtnxE3V0MK069vrgGZX41qlV0kzNAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(376002)(366004)(396003)(346002)(186003)(4326008)(71200400001)(478600001)(53546011)(8936002)(2906002)(5660300002)(86362001)(41300700001)(36756003)(6506007)(6486002)(2616005)(54906003)(6512007)(122000001)(38100700002)(1076003)(83380400001)(66476007)(38070700005)(66556008)(66446008)(8676002)(64756008)(316002)(6916009)(66946007)(26005)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UThJai9RbGl5S1lWcTVVTUpWc2srcW5xWVIwTHhNSWprUWs0UzNtcWhOR1RB?=
 =?utf-8?B?bEx4YlVoai9NNjM2QVZwT25OTmtIWVlKSEpucldvSjZpeWdjVEZWSlFvZndt?=
 =?utf-8?B?eERuMGtuc1ZhcFNKS2tvQWlBTkJaZ0VFOE9CRkNwNWlVR25xMHdBeSswUnQv?=
 =?utf-8?B?US9CTTdXUHdwbG9naFU5bUJ2WmhJYlZuaCtQWksvL0QxSlJ3R0pQR2lDTGh1?=
 =?utf-8?B?eURXYnFxa1RqQlpEdE9keHVXSnYxM1RYTFI0djRlc2hrRWptWmlwdm5nZ2lv?=
 =?utf-8?B?ZVJIZHAvbGtxV1NIRW1FV0NhampGNUwvMEtmSXpvZCtqcnZWYzZIQ0hYdXYr?=
 =?utf-8?B?Uy9oNHE0YVc0QjdPaVI2NWw2cWRFQUNpVDBDdmR1VVUvenkvODBUajBvWTJV?=
 =?utf-8?B?dmVkdCtycy9VOUJ3RElDUC9YRlBFN0Zoc0pzV3IxcHpxaUNHWm5HaTBLSzJ2?=
 =?utf-8?B?b1d3UUhPU3V2dVJHVDhJcHhHWmptSlJDS3BrdlFRc2dqZU43RDEySk1QNjM0?=
 =?utf-8?B?SWpZZ3RodTdldzVVVEZsVW9Ya1hIMnpWQjkyZVprYWQ2WUtZRG04WWVYL2Iy?=
 =?utf-8?B?b3FlSXc3a3JVdHQ2eHBQOGgvZEpTaHB4VnF1YXBqa2FLVGRnc1BRZWxHaHlQ?=
 =?utf-8?B?UVV4YnpXTmQvSzZwTmZFa3NkcHYxTEV1MXZkUWloazRSd2lFeGVXU1BOd1Ir?=
 =?utf-8?B?YWQvakFoVzVjUTVoWENiZkhsdjhwSXFDQmx3b0loWEZaaWY4czZBNDZYN004?=
 =?utf-8?B?b0k3bFBydUIvaXkzTk1kZEkzVlI1cE1wTFhXR25HZjF0NkxUazVsTXZtTUU4?=
 =?utf-8?B?RW96SEpmUE9TTC9jeCs5OVhQQ3g5UmsrdjdUbThQT3J0VkF2bjFpamN2UDhH?=
 =?utf-8?B?VGdtOGd1aWNQajFIWFFPc2JDWjF2Nytkci9YelVaWGJnZ2hsUDQ0RGtrQ0k5?=
 =?utf-8?B?blRwR1VLQ1FnaTc2Wk5JWUpQNlZLSm55RUY4SThvVWxNeFNaMkE0OE9sZzZh?=
 =?utf-8?B?K0tPeXlIMlJhcGpETkl6dmw1WWRtVXhYSENOY0dZdmhiT051OGRJNkFXUmhC?=
 =?utf-8?B?eFpCb1JzV2lSM2d4NDdFV1I3Uy9nM2tFWGlCaGZaYW1wS3p6dEhsNG5IclZO?=
 =?utf-8?B?dHNXejY5T0I2WFpCZFprbU1wZk8yM3g3bWx5elJZUFZCc2dpUk1BaHhzczUx?=
 =?utf-8?B?RkhKbnlOTFh1d25nMU1VMTk2b2k3ZlU0R3ZHTnZSWDUvYzZSQTZRZVI1Z2NN?=
 =?utf-8?B?TC95TDlTaFFQLzZpMDlsTk1UN1dJNXllZVBNYlZGMDgvSFVNVDczQi8yS3Ev?=
 =?utf-8?B?c0ZoQ1NMa2pDQ0hVckI3TUN4UFdqMnJ2cWFuNFNBYi9EaktIbzFZMzVhTzRC?=
 =?utf-8?B?ZSs5QU5GYVUzKzllRndpMDhKdzVCcE5wMDRLemtqekVoR1NVN2VmNHlqM0th?=
 =?utf-8?B?QmR5aDhFaGg5dEJJUHAxQmlTTDIyZUYxZGpGcVhFaVN5c3NtMHJEdkF5b1NX?=
 =?utf-8?B?VTZBYktlU0hJZ0JFdzJWdGRyZHdUUmx0T3dJcFFvakZoczRIZktIY3JqaTF5?=
 =?utf-8?B?ZTcvRU5PYlZTVENib0dqUFpSTG5GNlZ3Tm5RVUoxSHRTaXFGa0syeFNTSTlC?=
 =?utf-8?B?S0xqN1BGdGsxQTFZaWVvWnhIcEFNUkUxUHVSdGROSXE2WWJkb2VKbElGOXEz?=
 =?utf-8?B?V2lQVjJvYkhaT003Zk5EUUxVejlwbG9VM1ZHbHdnangyQW9qK011dkpIancr?=
 =?utf-8?B?TlhnRUlrR2hBNUZ0bWN6MFVwZThGVWsyWWdwakJOMjlMa3dBWkN3SzVvWVlH?=
 =?utf-8?B?YmtkTkxxOGxKVE5yVFFjL3RPTVhZdU82VXdFTnYwbVdVT2RZVHhCbWdCcDFG?=
 =?utf-8?B?VkxCTHBrR1YwVUE3ekZaNE1tSldOOXNhaXF5TzkxcUp3d3UyTkRvVzFMSW5h?=
 =?utf-8?B?UmxHcFRNamg0L3hIaVJBbCtsZk5YeklyYnlxa3pJbkN6OEFHaXJKZENtQ2dw?=
 =?utf-8?B?TVVTUitBK1Jaa00ranJMc1VPdnZyU0ZDaUVJREh5WkhZOWVVcDFCZXZTeDcy?=
 =?utf-8?B?NnBFaWtYVk9YdUhSa0Z0ajloanAxcWxzQWZXSVJ4VHZ0MW1pQ1RYNXRTTUg3?=
 =?utf-8?Q?Yz5ueIMncJny9Xun4K4ZiD2Jh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <07D89F829AA0AC46AFE46665B00086B2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c443fd2e-e6ba-4966-f7eb-08da8799104e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 19:27:49.9390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IAkhvi0zs8hLc8kuWWZDA3wGw11HuHLNK6OMcj9taa2hYVijOqRqEydXUbDuUxfIZypdAXZf7wgJ3FEpGpLDGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0023
X-Proofpoint-GUID: DxEJHK78dVUiU8zNXyatSACVmV11Tr66
X-Proofpoint-ORIG-GUID: DxEJHK78dVUiU8zNXyatSACVmV11Tr66
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 mlxscore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501
 bulkscore=0 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208260078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBBdWcgMjYsIDIwMjIsIFNlYmFzdGlhbiBBbmRyemVqIFNpZXdpb3Igd3JvdGU6DQo+
IE9uIDIwMjItMDctMTggMTg6Mjg6MzQgWy0wNzAwXSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl90Y20uYyBiL2RyaXZl
cnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX3RjbS5jDQo+ID4gaW5kZXggOGI5OWVlMDdkZjg3Li5k
ZmEzZTdjMDQzYTMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9u
L2ZfdGNtLmMNCj4gPiArKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl90Y20uYw0K
PiA+IEBAIC0xMjE0LDYgKzEyMzMsNTEgQEAgc3RhdGljIHZvaWQgdXNiZ19jbWRfd29yayhzdHJ1
Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQo+ID4gIAlyZXR1cm47DQo+ID4gIA0KPiA+ICBza2lwOg0K
PiA+ICsJaWYgKGNtZC0+dG1yX3JzcCA9PSBSQ19PVkVSTEFQUEVEX1RBRykgew0KPiA+ICsJCXN0
cnVjdCBzZV9zZXNzaW9uICpzZV9zZXNzOw0KPiA+ICsJCXN0cnVjdCB1YXNfc3RyZWFtICpzdHJl
YW07DQo+ID4gKw0KPiA+ICsJCXNlX3Nlc3MgPSBjbWQtPmZ1LT50cGctPnRwZ19uZXh1cy0+dHZu
X3NlX3Nlc3M7DQo+ID4gKwkJc3RyZWFtID0gdWFzcF9nZXRfc3RyZWFtX2J5X3RhZyhjbWQtPmZ1
LCBjbWQtPnRhZyk7DQo+ID4gKw0KPiA+ICsJCS8qDQo+ID4gKwkJICogVGhlcmUncyBubyBndWFy
YW50ZWUgb2YgYSBtYXRjaGluZyBjb21wbGV0aW9uIG9yZGVyIGJldHdlZW4NCj4gPiArCQkgKiBk
aWZmZXJlbnQgZW5kcG9pbnRzLiBpLmUuIFRoZSBkZXZpY2UgbWF5IHJlY2VpdmUgYSBuZXcgKENE
QikNCj4gPiArCQkgKiBjb21tYW5kIHJlcXVlc3QgY29tcGxldGlvbiBvZiB0aGUgY29tbWFuZCBl
bmRwb2ludCBiZWZvcmUgaXQNCj4gPiArCQkgKiBnZXRzIG5vdGlmaWVkIG9mIHRoZSBwcmV2aW91
cyBjb21tYW5kIHN0YXR1cyBjb21wbGV0aW9uIGZyb20NCj4gPiArCQkgKiBhIHN0YXR1cyBlbmRw
b2ludC4gVGhlIGRyaXZlciBzdGlsbCBuZWVkcyB0byBkZXRlY3QNCj4gPiArCQkgKiBtaXNiZWhh
dmluZyBob3N0IGFuZCByZXNwb25kIHdpdGggYW4gb3ZlcmxhcCBjb21tYW5kIHRhZy4gVG8NCj4g
PiArCQkgKiBwcmV2ZW50IGZhbHNlIG92ZXJsYXBwZWQgdGFnIGZhaWx1cmUsIGdpdmUgdGhlIGFj
dGl2ZSBhbmQNCj4gPiArCQkgKiBtYXRjaGluZyBzdHJlYW0gaWQgYSBzaG9ydCB0aW1lICgxbXMp
IHRvIGNvbXBsZXRlIGJlZm9yZQ0KPiA+ICsJCSAqIHJlc3BvbmQgd2l0aCBvdmVybGFwcGVkIGNv
bW1hbmQgZmFpbHVyZS4NCj4gPiArCQkgKi8NCj4gPiArCQltc2xlZXAoMSk7DQo+IA0KPiBIb3cg
bGlrZWx5IGlzIGl0IGZvciB0aGlzIHRvIGhhcHBlbj8gSXMgdGhlcmUgbWF5YmUgc29tZSBzeW5j
aHJvbmlzYXRpb24NCj4gbWlzc2luZz8gSWYgSSBzZWUgdGhpcyByaWdodCwgaW4gb3JkZXIgdG8g
Z2V0IGhlcmUsIHlvdSB3aWxsIGFscmVhZHkNCj4gc3BpbGwgdGhlIG1lc3NhZ2UgIkNvbW1hbmQg
dGFnICVkIG92ZXJsYXBwZWQiIHdoaWNoIGRvZXMgbm90IGxvb2sgZ29vZC4NCj4gV2h5IHNob3Vs
ZCB0aGUgaG9zdCByZS11c2UgYSB0YWcgd2hpY2ggZGlkIG5vdCB5ZXQgY29tcGxldGU/DQo+IA0K
DQpOb3Qgb2Z0ZW4sIGJ1dCBpdCBjYW4gaGFwcGVuLiBGb3IgZXhhbXBsZSwgZXZlbiB0aG91Z2gg
dGhlIGRldmljZSBzZW50IGENCnN0YXR1cyBvbiB0aGUgd2lyZSBhbmQgdGhlIGhvc3QgcmVjZWl2
ZWQgaXQuIFRoZSBob3N0IG1heSBzZW5kIGEgbmV3DQpjb21tYW5kIHdpdGggdGhlIHNhbWUgdGFn
IGJlZm9yZSB0aGUgZGV2aWNlIGlzIG5vdGlmaWVkIG9mIHRoZSBwcmV2aW91cw0KY29tbWFuZCBj
b21wbGV0aW9uLiBTaW5jZSB0aGV5IG9wZXJhdGUgaW4gZGlmZmVyZW50IGVuZHBvaW50cywgdGhl
DQpkZXZpY2UgZHJpdmVyIG1heSBnZXQgbm90aWZpY2F0aW9uIG9mIHRoZSBuZXcgY29tbWFuZCBm
cm9tIHRoZSBjb21tYW5kDQplbmRwb2ludCBiZWZvcmUgdGhlIHN0YXR1cyBjb21wbGV0aW9uIG9m
IHRoZSBzdGF0dXMgZW5kcG9pbnQuDQoNClRoaXMgaXMgYW4gYXR0ZW1wdCB0byBtYWludGFpbiBz
eW5jaHJvbml6YXRpb24gYW5kIHByZXZlbnQgZmFsc2Ugb3ZlcmxhcA0KY2hlY2suIEl0J3MgYSBx
dWljayBmaXguIEkgZmVlbCB0aGF0IHdlIGNhbiBoYW5kbGUgdGhpcyBiZXR0ZXIuIElmIHlvdQ0K
Y2FuIHRoaW5rIG9mIGEgYmV0dGVyIHdheSB0byBoYW5kbGUgdGhpcywgbGV0IG1lIGtub3cuDQoN
CkJSLA0KVGhpbmg=
