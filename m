Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E275A2F98
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 21:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiHZTEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 15:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbiHZTEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 15:04:42 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17BD93508;
        Fri, 26 Aug 2022 12:04:41 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QG5nDE024996;
        Fri, 26 Aug 2022 12:04:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=I19DjtQ0qIBpMfZW/1MFon05uws61qtRHHRxpUVJAbg=;
 b=TyI89UacO4f85yOaOy9MquEzhNC9oW3NcKN0z0+inmfdlXoJ3XEHfthZf34nqXt+n7Rc
 7u4fsrjr7GzsRkBIREOuFZiCQ1ZU6b1DOAPH3KqQ7Q3EoVu6KkuFefT0DQhop7pMYQqb
 yjUJ7/V8wKW2LFTwSLa2hUlNqpi2VHc+gObNjTuxZMJdPzUY1TD/El5zIeRQhYRtEaOm
 M+XlG473emmi6BGXjwdjNp+wr3GAolyFZsL08xKnNVPUfE3HfhX/9h6fTZ0gVl9kNMt9
 pLg7093A7nW6jA32gA6zVD7KtOP80bq2iM6OsSd4jsAnhjRK57kcrjAWjRtil8x8OWZE FQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3j5a42v2sg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 12:04:33 -0700
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8A9794009A;
        Fri, 26 Aug 2022 19:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1661540673; bh=I19DjtQ0qIBpMfZW/1MFon05uws61qtRHHRxpUVJAbg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=X1RtADz2dc3RTxtQ1fqJCNAyI9OIi/HKjcL68+59APrg9jNtneUOMIFGYDfUQezA/
         N8hag6M3jCc7xS7HZe9mah6y22l0Lo56qgdKKwzsDwpb9bqZXGYys0kcW+8rRbzPDm
         PaG8bkWBXvDdB3onsJ/iacXTGLQdy90+Lz+H/SDKI26XrLKIQ7Vv6vElHNcV2w7IyS
         ixP3+2RbzNCgypJARCcljsTn+DKSQAXFefv2nZ4zZdC5buLqFI+74b2w2KyWSo4oQv
         dzZakMww6chidJb3cz+BMpzmn1JKmazw3wxInYd+ontZCKOeARugM0RiezYtqZtx4X
         NBEM2aIVlE99w==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id AD85FA0063;
        Fri, 26 Aug 2022 19:04:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2830F4006C;
        Fri, 26 Aug 2022 19:04:32 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="exxVu7YS";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YnF5+OWD6Y5DNECARgm2kgOLpEy2NsWeKStHDt5lJgYNAFWLVh+P6VWeSWHTvQICurLxUDaoFIUfGzN4J1/FLcLOtyOniwjM0L1NHvp/GCKv+i+7Ju3gq2ntsNex7pbEtYi/FfQEV5nI4L4y9ui9/5rb8ixX+W2reT9QG/PI/31OTuqFWg6katq09PdN0j6Ue6dNQQGTUDRMtV6fPoCidJsjcFDf46McsdKnhdb3YR2ONPc1B/on9rRz8Wayx1Bu252iJ7lv0t77iDYPQyia5egpk3cJ7QjGDC5VchdoB5drZtydg4E1TDMb8cjpwRxCt5/FpjrbESu1Vzm7vvkmyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I19DjtQ0qIBpMfZW/1MFon05uws61qtRHHRxpUVJAbg=;
 b=Emz5uR9KxtNrn0gX1YL4POZKD9S2tY1yd5cxgr3xPhjz1vcp3x+rGGEy6wroN3p+R8pt37yrpLIBiULZ8/H/bO11xSq9QVrkpItnP33e2841zEPty/nJromsNB/693kKtADb4y3QvCv/ls8bKol8KNSkfIrQzcjbYBLXndJt++LsUMyzLGvyUik33McWQ/ma+qDjYvuys8Aos766BZNiRnD7dWirkQ65T1rqE676I62oRZbiUlph0/EzDngPD0zs6EkkEQv8mUrll/IwXwK8Z91+QoedxUu/viFSaCNtBRGU1zzAbXUs4j5EbCHEGaHCCe+5Dtl3VHlPS9YYHDQZyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I19DjtQ0qIBpMfZW/1MFon05uws61qtRHHRxpUVJAbg=;
 b=exxVu7YSppVTUwGK3i1zMZZJvv4/j3Wf4b8IRyeb3ll5F80xpOOzsXDO0U+MH+yUpMFDHMjEjfaY3Co+OrtOF60RlekzxejV7zK6SjhqAUWt1WAD0CVkCKMq9/X4+ap/TlPf64GM/ToJ5N1R49ISfY7+a55dRuYxy9qPoc70Dic=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BN9PR12MB5100.namprd12.prod.outlook.com (2603:10b6:408:119::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 19:04:26 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::69ee:633:f068:3ca1]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::69ee:633:f068:3ca1%3]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 19:04:26 +0000
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
Subject: Re: [PATCH v2 17/25] usb: gadget: f_tcm: Handle abort command
Thread-Topic: [PATCH v2 17/25] usb: gadget: f_tcm: Handle abort command
Thread-Index: AQHYmw7Fd6XG0sr51k+FARcbAS/Jxa3BCjeAgAC89gA=
Date:   Fri, 26 Aug 2022 19:04:25 +0000
Message-ID: <20220826190420.msfmhv2kxsv4qsdu@synopsys.com>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
 <099a4bd5ed02f4c48f4640347379b5127075e453.1658192351.git.Thinh.Nguyen@synopsys.com>
 <Ywh6sUom7d9HqAx6@linutronix.de>
In-Reply-To: <Ywh6sUom7d9HqAx6@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b7d2201-0870-4fcd-b341-08da8795cb7c
x-ms-traffictypediagnostic: BN9PR12MB5100:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2zGmzbzPCnus/oQdHk4jkRtXhdxh8ZImepMKLrkklz4ftKrPuqCx0MJgVsc6+cLr0qcncFRZFHyc/k2ptrxhR6QJZM5AJH+iZW9IPc4PH4p5ZvA6jJCX/PI7EBlAb8qN9ESFdn4ddK7GpjFDCSb8ZLouG6XiCoLBHW4Ang2s5jb0iDkrAVKSkXp+MDuVYCJ2rGi7K/9u18760jh/ss6FbdSFhJdj/dOJY/y3YEdtcnLnhTE2AC+SLpVmCt/PiElKq56GIG4GyqzELSOZdcUekzJna1Lj7yU48RuR2knPtuHC+sYxZwgHurGMXKCtsHz60m4O9DSdnEOBvhLlsNAvCLuh8TZNuy60A/VQsECJO+pdGw5saeqzAuXSBvV9KDoLPqcokddh2zE0IgnSHburswbC4M+T7vnJjiTtUNVGCeA4EEmBOrLvQ+vlv+8bXHXf+lzQquS8TC3OhoPE3UW2BdQsesbRV+iTi1dx/wv4i9D/4zKALJm2MP0aZx9hIEeDIQjDiFOUKUZ5LXmH3XiOtFxrRhj0CKulrwHD4DDyR6JJJxg1ZQKuFO9Iirj6x0bDvcP2i4PbcJQ0Ys2gmQkjkHBEtyW4ls6Nkj6RYoMGi2xG4TDNzSYYRffBRV7CkHynzQLAsjF6/AqgZiZGeWW+rIT2tt2bNJzJxxroIBwKAphN98kPqhPhoKOFo6Znp52zSXLoNrW4xPSd8pw5/b+1MIpnCZukLi021gf0tHTJhqVgaIq0YZfzVdmssC3weiUEhT2pagBLUQUsaMYT0qxaOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(346002)(376002)(39860400002)(366004)(83380400001)(1076003)(186003)(2616005)(66446008)(38070700005)(66556008)(66946007)(54906003)(64756008)(316002)(36756003)(71200400001)(76116006)(6486002)(4326008)(6916009)(8676002)(66476007)(53546011)(5660300002)(26005)(41300700001)(2906002)(478600001)(6506007)(8936002)(122000001)(6512007)(86362001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2Q3Z2lUR2ZPTzllc0Z4dGU2YSszUWhsM2ZXWFNMaHFpSVJlRHdyNVd0N0d0?=
 =?utf-8?B?MXFsUkRMSHVUa0xXd2NLMFBkM3JEbldnNlQvZjFIeWVaY1lNZGNVY3MrL1Iy?=
 =?utf-8?B?Tms1S25FVXF1aU13WCt6eDlVTnZMVXFaN1RGN3p5bi9XVFVINjNVVmZWdUY3?=
 =?utf-8?B?QTVTaDM2VUM3QVM4UFVlcDgwRW14d0tLMURsKzNNTUl5Tjh6Tm8rWWx2RFQ4?=
 =?utf-8?B?cVhVTVNKTVhmQjYwM1hhankxNS85OXhxdjY4STNNdmFTQTVCeUtkcVJaTzVU?=
 =?utf-8?B?T2t1d1FEb09OaTZTVWNFR2FMWWkvaEE0VVRCUHpJRTk4U09QTGdkTXd1Z2Vr?=
 =?utf-8?B?QUppbElGM1ZTZCtoczJ2anN0YThFWmdtN292TkE1eGdPUG1QekFjY1JCNWFY?=
 =?utf-8?B?amozZHY4QUR5WWN1QUF0QzlkNCtmMm1STzVRVllBZUt6N1RJeC81WElGNGxy?=
 =?utf-8?B?WGZQUE5mNDVJSkFkQ3JoeUV3MUdOMTAxQ0ZFMko0anZqaFlENjBiRmpSbU1h?=
 =?utf-8?B?emFtMDJvZ3FzSEhEZ0VtckZXZTBZTkZTYU9oTStlL3hmc2ZuWW5rTHJvSXdm?=
 =?utf-8?B?bmNqbEIraWhjdkVVSFZWeGNBNG8wZ0E0WmxOTlFJbFhFOUYxMWlIb2FLMjFZ?=
 =?utf-8?B?NGVWNkxVYjZ1OWc4TitWRFlMZ2JBRTR0N0hEZzNwTWtyTS9wTENZeE1UVGVK?=
 =?utf-8?B?R1hIYnppZGowdjJiVmVGdTFIQ0k0cTRzU1lNSzhNWnFXSjlmalJwVUl1SUhn?=
 =?utf-8?B?MzQ1N0gzSTNIODNhQk8vbkxhOUJGcEgwaE1wQTRRL2xsN0NVaXlaSElxTGdU?=
 =?utf-8?B?a3NwNy9KNjNuNTBVNi9QYVRqSU5GWEl5Y0pKZHdXVkJTQ1dKelNtNFkwdWh0?=
 =?utf-8?B?WVFtejR3WGpHVjZWdno4a2U5NFdGZE9EZWZpcldLNkNPdjU1UGtoUE1Uc2ZS?=
 =?utf-8?B?UU43bTRvWmdGcVZZYmNGMzJKUTZ0Q0p4TTk2VjVBdkx1WlpETmpVVkJZMGdP?=
 =?utf-8?B?amVHWHVBU0xLSWdtNTg4RjlDaWZnMkpveUovcjdPZElURXJsdHRrY3lRcSs2?=
 =?utf-8?B?R0REclZCQ2ZzbnlFNGxjK2p6OWZVYnpGcTRRR1FScEsvdGdNMi8yZmE0dUg5?=
 =?utf-8?B?V0RCTXNQK1l6b3orOTJWZFcrV0F4ajkvWmw3UEZEMVFwWkNZMU0zbDdvdTBP?=
 =?utf-8?B?akJsNmFGcllBZHJsU2tEdDhveSswV2QyQmVVNS9DVHdTNXlHMFRxL3lUNE9q?=
 =?utf-8?B?T25wZ2tHYWVDWGxHRnFMUG44REdNY0ZodU1WMmFhYkdvay9uSHd0bmZkTjRt?=
 =?utf-8?B?NFMxT1IyNDUzRzlPd3EyQmd6dU45SnA3SFROeFFzeDRxZURmVVhSUHlzVXF0?=
 =?utf-8?B?WkhhMjhVVTgwTmxxWSttbnJ4Y0pXeCs2NmphbHB6ckNSVXpvUHBUaFkyODVa?=
 =?utf-8?B?MTNFaUhKclhZNWlrU0NocTdPK0EyUzRDY3l4ckVBMm15OFM0TW5tRDByRHVj?=
 =?utf-8?B?UGhOcUovR0lVZUhmOVBISkRyNWRjVE1uTS9yWDRXREFoWlVTU1VicTNId01I?=
 =?utf-8?B?b1oxdVg4Tjh0SitVTzhQK3h3WXZFS2loKzZwNWVnRUNxd0drZmt3TjdGNUJR?=
 =?utf-8?B?MDMyWUxEQU1uRkMyeVdhR1JpaTZCVGwzanU5NlBkaTJ0MDB2bkNDMVJqMy9Y?=
 =?utf-8?B?Q0U5NVh3aS9mblJGZEh6ZWZTS2RyenZYT2ZIeTZJUTE2TnBSVFZkNzFpcWhj?=
 =?utf-8?B?bi9kd2pObUk0V1I1dDY5ckFxMTJyWDA4MG9yNmNucmJUaTViVy91TzRLbnFi?=
 =?utf-8?B?Z2UyUFI0Mk1xcDVRMkIxYWlkcGJXQWQrYmxRUDR1bFg2dmwybFlkSlFqQUpH?=
 =?utf-8?B?aDhOMCtZUzRhcnYyb2NpTjBYR2JyTWJBV1Rpa3JnRkFtR09JSUFlZjVUKzJU?=
 =?utf-8?B?V1dCRWp1UTJoMXVOcE55SG5XaGxvTEtscjRkSk5tSWhzakdZa3dzemIvdmto?=
 =?utf-8?B?d2N3U1U2WVF5OFhpTHJweGJVSUNTSkE4VGNFUjg3a0hxbUMwRGxYam1FMnBj?=
 =?utf-8?B?RlJSTnBOREhSeGVjOHUwVEh2amtTOTY1TEc2SktRMmswS3kyaXEycHBDRXli?=
 =?utf-8?Q?EFeelW035X65Sunlo3M1GOZaq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <254AAC7B5BF6FE42B8A7F329D73FB77A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7d2201-0870-4fcd-b341-08da8795cb7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 19:04:25.9701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8dkt7pUmx4C+925FsZTEQ9k3AnKTG9xmp7DM1KPB5yHpOcf+dQQjuu45Dmwv6nReF7R24xfEtvltTm8Or7TsfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5100
X-Proofpoint-GUID: _XEhSoh3c6ae4PgLa_WxofTV0x7ggYhD
X-Proofpoint-ORIG-GUID: _XEhSoh3c6ae4PgLa_WxofTV0x7ggYhD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 mlxscore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 mlxlogscore=979 priorityscore=1501
 bulkscore=0 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208260077
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBBdWcgMjYsIDIwMjIsIFNlYmFzdGlhbiBBbmRyemVqIFNpZXdpb3Igd3JvdGU6DQo+
IE9uIDIwMjItMDctMTggMTg6Mjc6NTEgWy0wNzAwXSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl90Y20uYyBiL2RyaXZl
cnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX3RjbS5jDQo+ID4gLS0tIGEvZHJpdmVycy91c2IvZ2Fk
Z2V0L2Z1bmN0aW9uL2ZfdGNtLmMNCj4gPiArKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rp
b24vZl90Y20uYw0KPiA+IEBAIC0xMjc4LDYgKzEyNzgsMjIgQEAgc3RhdGljIHZvaWQgdXNiZ19x
dWV1ZV90bV9yc3Aoc3RydWN0IHNlX2NtZCAqc2VfY21kKQ0KPiA+ICANCj4gPiAgc3RhdGljIHZv
aWQgdXNiZ19hYm9ydGVkX3Rhc2soc3RydWN0IHNlX2NtZCAqc2VfY21kKQ0KPiA+ICB7DQo+ID4g
KwlzdHJ1Y3QgdXNiZ19jbWQgKmNtZCA9IGNvbnRhaW5lcl9vZihzZV9jbWQsIHN0cnVjdCB1c2Jn
X2NtZCwgc2VfY21kKTsNCj4gPiArCXN0cnVjdCBmX3VhcyAqZnUgPSBjbWQtPmZ1Ow0KPiA+ICsJ
c3RydWN0IHVhc19zdHJlYW0gKnN0cmVhbSA9IGNtZC0+c3RyZWFtOw0KPiA+ICsJaW50IHJldCA9
IDA7DQo+ID4gKw0KPiA+ICsJaWYgKHN0cmVhbS0+cmVxX291dC0+c3RhdHVzID09IC1FSU5QUk9H
UkVTUykNCj4gPiArCQlyZXQgPSB1c2JfZXBfZGVxdWV1ZShmdS0+ZXBfb3V0LCBzdHJlYW0tPnJl
cV9vdXQpOw0KPiA+ICsJZWxzZSBpZiAoc3RyZWFtLT5yZXFfaW4tPnN0YXR1cyA9PSAtRUlOUFJP
R1JFU1MpDQo+ID4gKwkJcmV0ID0gdXNiX2VwX2RlcXVldWUoZnUtPmVwX2luLCBzdHJlYW0tPnJl
cV9pbik7DQo+ID4gKwllbHNlIGlmIChzdHJlYW0tPnJlcV9zdGF0dXMtPnN0YXR1cyA9PSAtRUlO
UFJPR1JFU1MpDQo+ID4gKwkJcmV0ID0gdXNiX2VwX2RlcXVldWUoZnUtPmVwX3N0YXR1cywgc3Ry
ZWFtLT5yZXFfc3RhdHVzKTsNCj4gPiArDQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXByX2Vycigi
VW5hYmxlIHRvIGRlcXVldWUgc2VfY21kIG91dCAlcFxuIiwgc2VfY21kKTsNCj4gDQo+IEkga25v
dyBJIHdhc24ndCB0aGUgYmVzdCBleGFtcGxlIGhlcmUuIEJ1dCBpZiB5b3UgY29udGludWUgdG8g
d29yayBvbg0KPiB0aGF0IG9uZSwgaWYgd291bGQgYmUgbmljZSBpZiB5b3UgY291bGQgcmVwbGFj
ZSBhbGwgdGhlIHByX2VycigpIGhlcmUNCj4gd2l0aCBhIGRldl9lcnIoKSAob3Igc28pIHNvIGl0
IGlzIGJvdW5kIHRvIGFuIGFjdHVhbCBkZXZpY2UgYW5kIHRoZQ0KPiByZWFkZXIgY2FuIGFjdHVh
bGx5IHBpbiBwb2ludCB0aGUgbWVzc2FnZSB0byB0aGUgYWN0dWFsbHkgZGV2aWNlLw0KPiBzdWJz
eXN0ZW0uIEknbSBub3Qgc3VyZSBpZiB3ZSBsYWNrIGEgZGV2aWNlIG9yIEkgd2FzIGV4dHJlbWVs
eSBsYXp5Lg0KPiBBZ2Fpbiwgbm90IHNvbWV0aGluZyB5b3UgbmVlZCBjaGFuZ2Ugbm93Lg0KDQpZ
ZXMuIEkgbm90aWNlZCB0aGF0IHRvby4gSG93ZXZlciwgSSB0aGluayB0aGF0IGNhbiBiZSBkb25l
IGxhdGVyIGFzIGl0DQpkb2Vzbid0IHNlZW0gY3JpdGljYWwuIEkgdHJpZWQgdG8ga2VlcCB0aGUg
Y29kZSBjb25zaXN0ZW50IGZvciBub3cuDQoNClRoYW5rcywNClRoaW5oDQoNCj4gDQo+ID4gKwlj
bWQtPnN0YXRlID0gVUFTUF9RVUVVRV9DT01NQU5EOw0KPiA+ICB9DQo+ID4gIA0KPiA+ICBzdGF0
aWMgY29uc3QgY2hhciAqdXNiZ19jaGVja193d24oY29uc3QgY2hhciAqbmFtZSkNCj4gDQo+IFNl
YmFzdGlhbg==
