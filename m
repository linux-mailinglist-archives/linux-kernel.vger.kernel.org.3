Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF470590A21
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 04:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbiHLCH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 22:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236546AbiHLCHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 22:07:24 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DD1A0247;
        Thu, 11 Aug 2022 19:07:23 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27BIRu9C017754;
        Thu, 11 Aug 2022 19:07:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=Z7xwg9d+VrAK5NLNMkNVHhQhSu+fn5hhSgFglL5JCgc=;
 b=Sq9WoyPaeVloaQpeTUXOoqB3tCCqeqLNIk8ot4/VDSUC4ohhjBd+55/+mPOnhRQerG/9
 UQANteK0kWOseP7V4HNLFtSADopiyL4sK6OuLWs/VuEn9gIyhNXJTHVrIRis+6pO+xLW
 j61w43j81LqTDFkSIp3D3TzFf/dP5oRfs/s38WmgPA4eC9WoUrO9ETlh26uNuP+X2nSJ
 hCQ3oHgYDylXIQ5b5XRMfUD1LJjmtGLrC7ZbRNgxOLTqOlSc4RWNZhKEOc3zztQDktoS
 ys2CzIo70RQJVRXXuGm0wmIFfnbRDUujgeVHdrsGbPbwFsel9N/WsN3iteB/jqpVIqUF ZA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3huwprn4b4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 19:07:11 -0700
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C3423400A0;
        Fri, 12 Aug 2022 02:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1660270031; bh=Z7xwg9d+VrAK5NLNMkNVHhQhSu+fn5hhSgFglL5JCgc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=lCTKIOurAN5Cx73bKvTCTxE/CgAOZtOE2VOHlIo3MTnku/E4ShEmEUtCX2T/9neA0
         LVTh+WThyzynyGQH4n4AsUNid3QjfE7/iZMnOtYHGFVs0RNpF8b/aqNi22F61K1b6H
         RjeKrMALhqrW4biQ4ymAQlgYSdQyS6TWT64SH9IatoeXJu2U58qhM1VztHAsxxy25q
         SO+8pZnLAsOFZRSqCy3V6BZAvWUPjxotHbLaSjncz+57hJzAnwFvbPnm4JFPQCqu5N
         8aLzQgm9DqwIWSL9IHbja4rLT9aH+ppqTXteKAwfUz7v8BymWmmyqYTDUpKSuVZG9z
         baA9UX7HJ6pnQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 23929A0080;
        Fri, 12 Aug 2022 02:07:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0E5DE40060;
        Fri, 12 Aug 2022 02:07:09 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Mszalrew";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGhYZfKy7Jr0gXcRE+Yluv9+oODM3UwGtH/0fg0Wu7ImuM4iLQJYwGeWdQGKvqRsk+Pq76b+eliSqcmeJljI1D3TMw4UUnjEW+0BJFpKcUBo8xG0HljT+DOV4F/ZIQkalO9NGt3SJDw6501GkOo4j6eG2BwWjXLcN6S8qRU5OYg/5uGpRcLsXoEQ6u+k0r5rPUq7j+x5eeqEoCQg0qdAz0be7nNca2ilPiAWsgxaD/PZq1tZ7cdeVlBsHqexBDa1TWB3KptfsVHDVtWJviTaH12QF8CcS92P3xGljtWTFE+2WEcByQqNQFSoOdwqSrOtyUhe1zqVf3QkBtYuRkObjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7xwg9d+VrAK5NLNMkNVHhQhSu+fn5hhSgFglL5JCgc=;
 b=Bj63/HKs+g276nBdWBbkr6w3mxCDd7qbEoQJ3MgiI47H8w/AqguQWGLk3+nttgRd4KVnDO/Cg5wiJhDO0Kc+FvdWRd9PqwG4nE7ZZqZ5Pr7Q72TVt+03YHL+HepfVv/3cZhv8UrHk3OJ0k4ih/7xzpHNmy6shyru4R+OAssQSAqIp+eXaacjQgMDlzEH6ipA6vgsHZlmCcPL/8wOBWKdFWX1mTVXc9o9QSl30rJ9sFL19vWhgyVBE/ucHi/zMhNT5I/hJkv5zNjymO0onFaicGedHmMCCqIku9fvKlviaYtnN9QbHdG1m6M4bdPMDA7NRibrkf92a2OXqFpQKrKWNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7xwg9d+VrAK5NLNMkNVHhQhSu+fn5hhSgFglL5JCgc=;
 b=MszalrewFdOZRtzTUCC3qQoi/nU1uahzk93Onmk3k3osd4txvr8T7wQQlrkpzT1GhhoL459WfF9Uotkj1vcP6/8VecymWIB9WINNHGmFHZ/QmaRcgE/kVnFONY33d+Tlkv1J9/i3vL25iggsIPHPtdvszYds9JnoFFxXBkMwHuk=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CH2PR12MB3685.namprd12.prod.outlook.com (2603:10b6:610:2d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Fri, 12 Aug
 2022 02:07:06 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c%7]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 02:07:06 +0000
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
Thread-Index: AQHYpqSxYg+mSBtinkWEjfftWY3s8a2cSDKAgAMApwCAAD6nAIAHe4yAgABbB4CAAuA9gIAAVNaA
Date:   Fri, 12 Aug 2022 02:07:06 +0000
Message-ID: <5a7d8e4c-2ef3-6cc2-133e-ff38e148648d@synopsys.com>
References: <1659467920-9095-1-git-send-email-quic_eserrao@quicinc.com>
 <1659467920-9095-3-git-send-email-quic_eserrao@quicinc.com>
 <049219f1-8c68-e4cc-7bf9-1e8c214e80aa@synopsys.com>
 <32a0765e-00d9-1a67-bf36-4060c5fcb008@quicinc.com>
 <8705d52e-2181-aebd-43b8-2c8d021339c7@synopsys.com>
 <5ad70f41-622e-2d75-7c53-89aba1255a5f@quicinc.com>
 <ac8e012f-08f3-baed-ead0-231f0527864c@synopsys.com>
 <19a7f8da-b655-b21d-8bcb-a60e30a8d5f8@quicinc.com>
In-Reply-To: <19a7f8da-b655-b21d-8bcb-a60e30a8d5f8@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10c65974-7b16-4137-b908-08da7c075b18
x-ms-traffictypediagnostic: CH2PR12MB3685:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F2/UbB8klp6A4cE6xSbWb8tiW0QpLGpVEd3u6BlRXtqALtIgRlCYKfnYA/AevlLqvnf09thk1NFp1i2pViYOqZQP0uq7QBSX2txYGbd6whzrupnV7lccuyhiLu7sTaygB9g3jhaQ0drddcZnCWt1witCutdslOEo6terH5bsCQycbeybHwOPwc1nOa/++eyR3CoWCiwwZF888dTO62WaHQ1TjSkhLZ4Sxt2XIBTB9KPoqKw03SfFv/yXo6Ti43HPVrilHUlROXRi00ZkpQ9Yb35JYuxm6xzx9uRHYd90gBpLjgZE424bAxDcZPsJsyZ69v5I6y/73kY90wPNltvQazObO2pSeJgoSwM6TSHAXRQoxvZZ6V5sIG60puPXbwRZP/xm0QlGmPmDL4kyuzR2lE8uLr2OV67TnzHATI3TKMAcRTLfu6bls88m8R9FyL/C5zElc6eyox3v8K2pYC0saT2alt3xKV1giHsfPN7fxHPxGSfUySWqOkyaPwh6FsUNahTUK8CmEGPNU7TioinYZp6pVH/Yy1ebMqMcQBBCIEYsx0qJfoKvq/M93VMfZc+P4RXFocOX1++a+explTO95qpEgUNyuY/t5KrFZojhVupasqrpNQA7JJBH08i4+TFE7UBrwNR62k/i6HuO3kKLvaitRinYwhVWT2PZbYoQ/tDcKkYpLIEoTtIviyHBFffqR6nnLv5us8kEjVPZ42p2s0nPtZjb95FmUOJuFar6+x5Sd1wSRDHzy1tKMnuVV7VWn/w+gCINTE8wwghv/1KeQ87q+bvqXMEsEsNMvsEeC0JO9npysBqL/CmxvE/0i/92ZnUYf+Sx8PqosCmW2vYZEuistCgDuBbtrOrWOTeP371cEjy1C2z6AC9TF4dgMAnP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(366004)(376002)(39860400002)(136003)(186003)(4744005)(2906002)(478600001)(2616005)(5660300002)(31696002)(41300700001)(86362001)(122000001)(6506007)(26005)(6512007)(38100700002)(38070700005)(4326008)(83380400001)(110136005)(31686004)(36756003)(8676002)(8936002)(54906003)(66556008)(66946007)(66446008)(316002)(64756008)(66476007)(71200400001)(76116006)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVAxYWNXUWQ0ZlovazIrUjFtRUZBK0lDYjFLd0g5b2hDeWx5dElWVEkwRmVj?=
 =?utf-8?B?ak1UdkZYbzFnN2xhUHZIalRrbVZwbW1pWjU2eUcyNVhDM0J1dVh2Uld2WU1Q?=
 =?utf-8?B?bWVKUTUxYVJvZ0ZvYkw3NnBFUHo1ODBscU4zcHVQZmNGeU82b0k2UEc5UFgv?=
 =?utf-8?B?UVlzRmVnQWZkenFHWVRuY2ttV3d2MkFHWUIxMGROSVRUd1E1QWJNWURsN0hS?=
 =?utf-8?B?YjUrTTRwMHBsRVArTXZiVDA5UGRBS2ZuUUs5Rzd1R0VpQnlTT0FzaXdOR3Ny?=
 =?utf-8?B?UUtyUDFCMXdEQXF3UUdGZ3NkbnJSRFcyQlVUY0hRZkhOdmdqUnc0ZmZWMGp0?=
 =?utf-8?B?Vm0rdWdEUTd3aWJPM2c3ZW4rSlBPenoxcGpCZjBYWE1aT1hsK05YZk9JbVVY?=
 =?utf-8?B?U3d3UlJmVi9aTGdOY0NtSVArM29abWdYczZyV1dydVp2Tmg3RnQ3UDR5ZlMx?=
 =?utf-8?B?dTEwUSt3Rnh1RzJra0lOUWMvK1pHSEdhS0JOc2QyZnBjTjQ1a3dtKzNQWm5a?=
 =?utf-8?B?R1p2N3dHOEZLR0p0ZFBCajhjZU54N0tPL1hXemRocHdUZ3lnVHR4b0JOOGlJ?=
 =?utf-8?B?aFZ1QUhObk5rdUJJcFIybkd4enEwaEtLa2o3RUNNRG5UUnhCN2RJL3dnWGN4?=
 =?utf-8?B?UXVkZy9VWWFxUGcvNEowM2xrRWFaZUp0YklEZVlPbmxUL3JXei9PK2pzMCtT?=
 =?utf-8?B?OHBwajhHcTRWZ3BFcTRqb2NNQkswVjNERTZEMnUwODdGM0RTTGE2NVhmNlVU?=
 =?utf-8?B?bUoxdGtWcG93YVVpTWZQWVJZaktLZEIxWW1kdGFzQlRxOVlNc1hwWWtmcGdq?=
 =?utf-8?B?WVkwbVFwSEhTU2h6SitZMkRHME93MFhmQ3FaaVVFMk5JSEJQc3lOV3cwWDRM?=
 =?utf-8?B?S29GbmxJYzJjdHY1UDdqdnRQeTlNdXpFMVEwZFBKRktEN2dzeWovTTUrOEd1?=
 =?utf-8?B?WElzRU1FTS9rUTZtaFdteGk5cXFpd3A3QllPcEVlRDNGV2ZkbEV6WlBURWhs?=
 =?utf-8?B?Z3ZzcjlXczdHd29pYmVxelBubW5kbzYyamlNanhxVXJxWGN5SGFOU3J2aTRs?=
 =?utf-8?B?a2poWG95cDNheUo5SFVud094RWNac1V5bFV6ZUdXeW1WVDU2N0MzeXhobUF0?=
 =?utf-8?B?RkhDTGxJRmQyT0FkQjhPcC9RMmdwK1M0dmROUThlNmVBbUVFMzJMMWVTTXZE?=
 =?utf-8?B?NHVFSkM2UlJ1K3JKbno5czhsQzVwQmFXQ1N5cTdkK1ZSM2dySTVKVUpQeWdz?=
 =?utf-8?B?YXVXaVptWTRPd2gxc0NvWVV1QkdCQmN2Z3VjRFl5ZFB2TE4vNFM3S3pNUWtW?=
 =?utf-8?B?eHJLcU5SbEdoWnR6bHRMdzRRUXlYRWxCS3VDdk9iRWt6VEZrKytuUnVTclgy?=
 =?utf-8?B?UzczUUhaUlJpOVRKVDdEUyszUnRCUGlrT01aeDBCemVyUnA4eWZLQVdsM2I4?=
 =?utf-8?B?Q0FqUTJlbkx6SmFPVnN0T0I3TU5kMFVTQmlOb2xoeGZqR0hJZmJmRURJUkUr?=
 =?utf-8?B?M3Q0SXQ4em94ejdLSm9vc2NXVmhqTHF3aFQ3UTN4SmJLdUxPUEZ0ZFlRU0ZT?=
 =?utf-8?B?MmV0L0dIS21jK1R6emJuaHU0RzBhY3V5NUpUTlZNNnRQWDAxcDdHbjk4dGdC?=
 =?utf-8?B?ajlsWmFxa2tJb09FTWk4R1JiSDBHZEp0VG1YNmdXWSs1c1R1VVJ5ZGFadWdz?=
 =?utf-8?B?TGVRVW5XMWJvWCtGR2UzWHNSNDZpN1JIaW9JNHRvaVdkQ3cyS3pWaXQySjIv?=
 =?utf-8?B?MDhxTFNhaUIwblU3bE15cjBIek0wdlFWZFhKaG53TVYrVUFXVVZJM09zcHRZ?=
 =?utf-8?B?a2pGMlhYbTBBaEV2YXUvemdRUkFDL1ZYTkdsSVRZVjk0b0hjRUJEc0lWMlVE?=
 =?utf-8?B?WjkzR1hQUTNYZFdCbDlVUEV0Zk40ZVQyUmUxdEttVTczVzg2YzZ4Q3p3cEQz?=
 =?utf-8?B?VWd3SWN6QUZUQXcwYkhxakU2RmpmV0psTXZQWmdnWWtqaXUzMjkreWxvNTVo?=
 =?utf-8?B?RkJQS205bUE1bE15RE5ILzhzSUI5RmFBVW1jTGMzdnNwS0VLMlRUampPb0hs?=
 =?utf-8?B?N1RyTTJ4VFQvWnBUb1JtcnA0QkdsYWt5NGxxZEREMkIzUHVYWlk1bjdPdEVa?=
 =?utf-8?Q?kgSc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <741C6EBBB0F89741BC2AFA661D9D7910@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YTJlUTg3R2QzQWxEZVlocDFycFlxbnk1Q1pOc0NqMHdIb3h5ZitDNDhQWE1Q?=
 =?utf-8?B?bThvU1FhUEl6Y0M0ZTc0VEYxSTNWYis1STM5V2hkRkd5NGptNERTMjUwZXRG?=
 =?utf-8?B?bEVQTkhxWitYRTVVWEFoRGxZZnUwbk9uOGlpU0R4akRVWGtmMThmYTJudkdW?=
 =?utf-8?B?MWRRQW12L2EvL2pXWmFFMUZSelR3a0s0Yk9lTlpVMW9xY28wbEdqS2tDS0x4?=
 =?utf-8?B?eHVrSFpGc2RGUFU0ckVtSGx0cHlSMjBaWU1pZDlBRWk2cnQreGJTWHJBV0NK?=
 =?utf-8?B?Q2JaMW0wdnoyM0IxZjNvWFlqNDlmSkd1clJHMFNXaGJiVTFqSS9GM1FiY3lZ?=
 =?utf-8?B?UlBGWUZuL0hYQ0czb3YrY0psQXRaV1htVjBLVk9CY1NyQTN0M2NhZXBpTE00?=
 =?utf-8?B?UWZXZERPdXhYRHZjN0N3bUNHOG9Wcy9vb1NwekNacjNKNkltK3dZK0p4dCtl?=
 =?utf-8?B?a25sZlQzNUVkcnNRdmVqSW5tR0JCcGtvNTBPRWloS1NRU2dhUWtldlYvYXF4?=
 =?utf-8?B?cHNLN294ODZZbGt3dDB2WFJMdXFDZVgveU5wem1XSDZubURpWnZ5NVJDU0lQ?=
 =?utf-8?B?NW16MmdQZDZQV09VMXpZVk1CN25Db2cyQUdJak5KWVhnU09yVTV4R3lSNUU3?=
 =?utf-8?B?ZGtUUUh3endCcy9pQ3RCQnZuQ2hJaVltQXVreENENUxNZDcrOUxlRlBLODI4?=
 =?utf-8?B?QnZ5MjV0RXdKa0xHZGFVSUhFVUtqcnVFaCtlQUcrRzA3akkrbkRTRVNXVHlj?=
 =?utf-8?B?L2VaeitQSTlCWDFTTWtUU2t3UXpOYVVpbGhXb1RtMnhyNlE0Z3dvZnc0Q2pq?=
 =?utf-8?B?RWovS3Y2MjUyNEtrOUlOWE9VMjJqRWU0amhTUTdmc2wwM1pWNVh2bUFxSmxC?=
 =?utf-8?B?a3pZK2wzZzNxK1pRODVTTnM3ejZZd0pRQlpKbUV3K2Nhd0Y2QSt0SDBjc1Mx?=
 =?utf-8?B?NUF1UmtQRGYxUHgxcUorMlc2dUNUVXhzZ0RqM0p6VDczMXZQbWdpOGgzOTRR?=
 =?utf-8?B?aDlNSlF1RHJ5SXVZTmRLUkdFbUc0TS9jRGoxcW1EUGQ4UVVzSWNtYlhmcEV6?=
 =?utf-8?B?cGpmY2lja0g3K0UrWFlSdkRvK21Yb3hRb2tXUVlCZXZ3aDlzSFRJZnlCbEV6?=
 =?utf-8?B?Uytrczc5Qk5MdjNKRzlUY3ZwOElIWHNCUjVycVlXYTVLbG5BT003Z0NUZXdR?=
 =?utf-8?B?YmhIV3JBZE5uTkVNV0psRWY0TFRycm0zQmY2VlFtZFJtNWZaQnNiM28xYzRX?=
 =?utf-8?B?TDh4N0V1a1grb1NsNkt0dVp6eHgxWjFQNTRHSjljdXBTVXQrUngrV2tjaW4w?=
 =?utf-8?B?Ylg4TWkyR1Vyc2FxTHdmbWhZZjJqcVNlcGlmdFZCNHpDL3BCUU9SR1psUk5y?=
 =?utf-8?B?LzFCWnE0Z3RMWThJeHg5ZkZaenhvLzlwcEUveU9pdXhxcmpyN2srVGdqb1pV?=
 =?utf-8?B?cklnd0hmeG9IN3VRZmY0bDA1OEVjeTcycVR6T2VMeHFMVG83aXRPVnVsbU1E?=
 =?utf-8?B?YURhZndzb3JaeEhzTVRQTzlJZ0s3WC9reERmSlRhUDFmdmlFS1J5R1lqa0wr?=
 =?utf-8?B?cldHZ0h6bHBlY1VHWG9pN1R5WS9mMnEvc29Ld2pZcU14b1VoeXdBSTNCMmE5?=
 =?utf-8?B?SnJkdHB6T2FPLyt4dWVGOWZ2ckU2Wmc9PQ==?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c65974-7b16-4137-b908-08da7c075b18
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2022 02:07:06.0839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RSUwb7y0lAdxWNxkmvybQSLO2lyz7f4oTg7G2If4MwEEMGs0iLc+GvjAby58KW+2ECNDhCsrH/T/bbtOVfjT9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3685
X-Proofpoint-ORIG-GUID: QWssltBFzPj8TPjc-azdO0T0wG18_CDd
X-Proofpoint-GUID: QWssltBFzPj8TPjc-azdO0T0wG18_CDd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-11_14,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 clxscore=1015 mlxscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=674
 impostorscore=0 phishscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208120004
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8xMS8yMDIyLCBFbHNvbiBTZXJyYW8gd3JvdGU6DQo+IA0KPj4NCj4+IDMpIElmIHRoZSBs
aW5rIHRyYW5zaXRpb25zIHRvIFUwIGFmdGVyIHRoZSBkZXZpY2UgdHJpZ2dlcmluZyBhIHJlbW90
ZQ0KPj4gd2FrZXVwLCB0aGUgZGV2aWNlIHdpbGwgYWxzbyBzZW5kIGRldmljZSBub3RpZmljYXRp
b24gZnVuY3Rpb24gd2FrZSBmb3INCj4+IGFsbCB0aGUgaW50ZXJmYWNlcyBhcm1lZCB3aXRoIHJl
bW90ZSB3YWtldXAuDQo+Pg0KPiANCj4gSSBhbSBub3QgY2xlYXIgb24gd2h5IGRldmljZSBub3Rp
ZmljYXRpb24gZnVuY3Rpb24gd2FrZSBzaG91bGQgYmUgc2VudA0KPiBmb3IgQUxMIGludGVyZmFj
ZXMgYXJtZWQgd2l0aCByZW1vdGUgd2FrZXVwLiBTaW5jZSBmdW5jdGlvbg0KPiBzdXNwZW5kL3dh
a2V1cCBvZiBhbiBpbnRlcmZhY2UgaXMgaW5kZXBlbmRlbnQgb2Ygb3RoZXIgZnVuY3Rpb25zIGlu
IGENCj4gY29tcG9zaXRlIGRldmljZSBvbmx5IHRoZSBpbnRlcmZhY2UgaW4gd2hpY2ggYSByZW1v
dGUgd2FrZXVwIGV2ZW50DQo+IG9jY3VycmVkIHNob3VsZCBzZW5kIHRoZSB3YWtlIG5vdGlmaWNh
dGlvbiByaWdodD8gVGhlIG90aGVyIGZ1bmN0aW9ucw0KPiB3aWxsIGNvbnRpbnVlIHRvIHJlbWFp
bg0KPiBpbiBmdW5jdGlvbiBzdXNwZW5kIHN0YXRlLg0KPiANCg0KaG0uLi4gSSB0aGluayB5b3Un
cmUgcmlnaHQgaGVyZS4gSSB0aGluayBJIG1pc3JlYWQgdGhlIHNwZWMuDQpXZSBvbmx5IG5lZWQg
dG8gc2VuZCBkZXZpY2Ugbm90aWZpY2F0aW9uIG9mIHRoZSBmdW5jdGlvbiB0aGF0IHRyaWdnZXJz
DQpyZW1vdGUgd2FrZS4NCg0KWW91IGNhbiBpZ25vcmUgdGhlIGNvbW1lbnRzIHJlbGF0ZWQgdG8g
dGhpcy4gU29ycnkgZm9yIHRoZSBjb25mdXNpb24uDQpIb3dldmVyLCB0aGUgb3RoZXIgcG9pbnRz
IHN0aWxsIHN0YW5kLg0KDQpUaGFua3MsDQpUaGluaA0K
