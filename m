Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A5E57AA39
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 01:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240521AbiGSXGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 19:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239048AbiGSXFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 19:05:53 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DF761D57;
        Tue, 19 Jul 2022 16:05:52 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JLkLof020341;
        Tue, 19 Jul 2022 16:05:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=qnjvYqssLNMqLGdGeugr2ffhUtSArIrBtroteoqgcc0=;
 b=V1QxP+bZ2UeVgnAgsMXanezTDySSI3zcrmxfqnoG1a6XMvodEmnK6qC4glQpP10z0au8
 p3X0Sdm21PElEH2YMOi9m/ltmaZK35pXzzxQ+vllosGyAdaqqRQ60RhIHl6ETvQ99hV+
 gutnITRBWrVbTeqNktVB8rjcEkgymGnmQ65JXNLGG5zgmsefmlQJwlhaF67aOuYTz5O0
 mgpSaUJkILvCVlp1z4d1+SEsQ/f3heSWDOF5KeNDlpy1dLD+k3HERHLpFxyI6GzIUJOC
 ilBpt9FBJ3uG1OdYOhGHaBRJni1QWnwmLMz0aHJa/3pgWjYwwxQ70b4DOjjT76MTnYyP MA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3hbvk67205-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 16:05:49 -0700
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 49F6DC0649;
        Tue, 19 Jul 2022 23:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1658271949; bh=qnjvYqssLNMqLGdGeugr2ffhUtSArIrBtroteoqgcc0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=BYW+83Boxox9sxmCL0hG1NiJy7ESKuSkM+y1vlQFjsjBZp9qaKTNl22Z3swT3gDrB
         o7wRmTJBZ0NdEJS5ZegCpPlDCrqBbBV0BApq0LyVw8qTA5NOPoSEapBp/u5b6ZxvG0
         /952CWsnEBJeLn6NEYbcnRxAv+mdkgbXnogUEcAPHkNcKQPK6pLKRx15XE4h0vH3eA
         WQeJDP8DSgKFd5ydqGporTPdoSIGnzML2lxMCx40Qu2U62dcg5xtNkihLVRGVcLvFs
         MjzRPzHxxU3iyaW2iz9bLhAGSb4DsxanS0JCGxyn+083/HefQiQONOdOCVfaO9IKzT
         Z7MfmxqqXUxbA==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id D9FF7A0099;
        Tue, 19 Jul 2022 23:05:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5AD5240030;
        Tue, 19 Jul 2022 23:05:48 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="kEa2PK8f";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbjIDmjqenZbnmzwcodSl/GLCmTJUkQE20cZydV+w3TL7XRQMAcU0NgLnU0PQEv4ao9fMx9XYlnugte6plZ5OpvVV/1cOsiN/4ch1EceRNm5vqWu9/OPRXDe7IiQtw/rNP2lZwqlc4df+aMcl7oy2i0MCcZknrfbmQKZ0Q75QMMK4anuc11vkPYiVvBZmFr5PtvgGOX7fjO56XniC7CaaRWYliCqSafjbaqAsJGyoK/EbVEwsJR/h5cr6gm/p0vWESDmarsx6b4ud4AGQ5gN3GV92scMOb3JfPtOYB/soUCf8deWnN5hdjVDPHybHRcGIb69m0m6zeuOWDQm0yFi7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnjvYqssLNMqLGdGeugr2ffhUtSArIrBtroteoqgcc0=;
 b=fCtfeQsjSTvI+xfDr+vVj6bHGGdZM2y5GYnqQTIF0l+WDMOiT8gikGoMAjL4+ukz/GeNYquDecIPZO7fy43h93FZGv55L7ZPK2bKIvnsltL/OXN8YrHYOV4tjC2kxd/zu4NhHE1TbcBh4D7BrDQSNBtfHvY5lG5WFA7/iq5ohBnfOfTEFGh66c0N5i2scdSKHnM9F0U35Dj625gD5Zr+SD9AuWp5BC3X7xiBSK8fx8neuwu4plSrf6PJuhBw6E+gTU3kXLEmOiE7fM4jnCMPaS6Rx5c4Ygz3/D5QaYZ8s0bvonHJnQ1+lfGjV6JGABzuqPTLN8oAl3sTtH11AE9BJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnjvYqssLNMqLGdGeugr2ffhUtSArIrBtroteoqgcc0=;
 b=kEa2PK8fIT/qAEpLe84nRqrCRD5S5A6QBnngdnmJ4+QLvoQG5GmZskEku+fXCz+kIdhCM4i/V776bmwnjnkR5yprS5rbY55zzT6n97YpyZveSOd75oyaJKYJG49onv3wBtkd/oUjig7IFFMva5dDo0cV1iadfwOUPpWjV2jK7f4=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CY4PR12MB1239.namprd12.prod.outlook.com (2603:10b6:903:3d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Tue, 19 Jul
 2022 23:05:45 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c%7]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 23:05:45 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Mike Christie <michael.christie@oracle.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     John Youn <John.Youn@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] target: Implement TMR_ABORT_TASK_SET
Thread-Topic: [PATCH v2 2/4] target: Implement TMR_ABORT_TASK_SET
Thread-Index: AQHYmxRBn/5V7lHe8UGHy91biTzdSa2F2fSAgAB4CoA=
Date:   Tue, 19 Jul 2022 23:05:45 +0000
Message-ID: <d0bfb66f-1934-c9a2-524e-0f0665cb7d2f@synopsys.com>
References: <cover.1658195608.git.Thinh.Nguyen@synopsys.com>
 <7d31722a7e07bc24ea37b5841a17545003eeddb4.1658195608.git.Thinh.Nguyen@synopsys.com>
 <74bf1df3-a466-9d78-1a25-7425c89b9fa3@oracle.com>
In-Reply-To: <74bf1df3-a466-9d78-1a25-7425c89b9fa3@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1dd6f903-7746-48ed-eec8-08da69db3657
x-ms-traffictypediagnostic: CY4PR12MB1239:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1LIp6qA6a2G24GRaD7HY7ytp+W7hDAWteXmhymhm2MXtPp+y1O6U5KCXUZDfUTJUnDjB6KwXAyq9+SV0GQtpH5FypKbADcS9bERM/pNwKCLNsc12rn1CY/lNCFOi28rNn00F46u0aVlzCWBX2Rs+bLnR4LjykiQLceYwstPG+vHdGkIXYQzyRPHlQYsSgYBh7xEVejB94+kaX9YfaDyjXE/xrz199MPD8eiNkjQ9lr+xDmrBEJskwoO6hWQhhaTv0yu+UT0EfsNqt9RufEpFyzK6rMykQYJFe+2F7pDWrDa4L5BG2inV4WP4RKNPTzLe1ZHESXCi2Y89brHlZ9av21/z32ZvcjAw6I6L+CqzEzAS3GTDXbERyuDaT3c4YZgssw8Ya+W3ISqGdlguyGzGm6pc4kkSHnikfc+Xtz9G8/CPvCLUH9I3CnXN+I6kX+vSgrzq+9/TbH6e2FoEFZmoYgVunr81QynWq+sNGAdosvEieoUSf71XUVunSCjl+6OwN0Tc9uysnGWOP1iVkQerg5BzolaeGoWgaTIPIYFL1NnY9EHuUalZS/JJj2zkbmd0mJYvu2ryqfdgy87oMOjjRrnlOBJMshlVwY0fgu++dsVXeUNqqFFm9E3kjITCmTnqg8crwfg/fvNykDUiFbphC5ZgqgewPMNZjIYl/AGdsq8oAsthVOeSrtsLNxDJHUMEwZDCqY5luKm+x81ee40WUBqYRXDZP9CKEEafb8e0w1/zu8vEjGsFJpNGHA7+c8eqc3lVG4qb06dUdVTHJSINVDMCGaVYTVRwi8VVM9XpGafs6tXEIjSboecMotSY4lgR+CZ4oAak9a4kSKMf5R3MBzMeZ0ARjrt6oBZoB8v9q7Bhc9bOaecXJhZLdfo2hAtI653kP6YNDHNGjEcfNHofQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(396003)(346002)(39860400002)(136003)(86362001)(8936002)(8676002)(4326008)(31696002)(66446008)(5660300002)(64756008)(66556008)(66476007)(38100700002)(38070700005)(6506007)(66946007)(36756003)(76116006)(54906003)(53546011)(316002)(41300700001)(110136005)(31686004)(26005)(2616005)(186003)(478600001)(83380400001)(2906002)(122000001)(6512007)(71200400001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUZKd3J5eFdmcEhGck9tMkVvbUZPRTNPNTVjNTBPY3p1Z3NCSkc2OThVUy9s?=
 =?utf-8?B?YzZwbUpSaUE0UWFTSEc1M3FMVU1MMjlxa1RROXQrZjdPdHNMbnFlOTFnc1lj?=
 =?utf-8?B?T1FvTXUyajExaUtpSjFveXJRTDQvY2o0WEVjcWFYcVY0M0lScW9zamNvVzky?=
 =?utf-8?B?SkJDbURibHRaSXdsVHFaRUtkRlRRb0FQc0dzcWp5Mzh3SGJWNE1DaVpPOWVh?=
 =?utf-8?B?bmVXT3htcXVxQS95ZjlxSi9QUlZYUjNrOXI2RmdZRGQ4K1luT3haQXR2WFE2?=
 =?utf-8?B?bVppR05tdm9HeWg2YzRhQmVNQmp1N3BYbXJNN0hGcXZXOVdSM2VibjkrWkJ5?=
 =?utf-8?B?cVgwNmJlWVVwdUdhWCtJaTl2aGgwVXhUOVVvWFNDb2Nhc0tYSEhtS2hsYnVG?=
 =?utf-8?B?N0Jydkd6RnpBcXREcmR0RUtGT1E4d3NiY1FFcXhYM3duYm9STVkwSnZFdURI?=
 =?utf-8?B?VTJjN2tGK20yUXk0TllTZjEvRE1Xc2trWi8rek1yRUZVcldwNEZ2NEU2S0lS?=
 =?utf-8?B?Z2U2MDZTQ2xmSUpTT29pMVR6djJEMlBsaTJGZmwxajFyaWtVdnNsOEJjUHJY?=
 =?utf-8?B?dVdYMU13M1ZISUQxZE43ZzZxbDZVb3NBQktpTk9oUXNXSzhuRlZ6ZHNidG1C?=
 =?utf-8?B?UVhqS25rWE1KNlMxR042RWRuY3BpZFdXTzgzK2tBVWJGdUlpMWwvSnY4R2Yy?=
 =?utf-8?B?Rkd2dTl4WDJOTThzSkJ4NFRHdUR4NkVKMlpiaVVVU2dDQXhobkdNMnlOWXJk?=
 =?utf-8?B?Y3ZoWVZnMXozdTFORkxHNm4vSERCZ2o0Z1J0dXIyblBJc0c3VXBudzBCMXdQ?=
 =?utf-8?B?Sms0SXpac3R1eG1PYnM1T1A3Z2dDaUJPL3M5S0VMbS9tRjNCbFdNcTZKUWEx?=
 =?utf-8?B?QWIxTWNBbnVvWDN6Vk1xQ292UWNnWU1NTU1pMGdBWFFodTNPK1dOZVI1TW00?=
 =?utf-8?B?K2hUVUkxRDlXdUJvd0V6ODBIeDJ6cngrM1pNSmlzKzlHSU1xbW1oTkxuUXow?=
 =?utf-8?B?Ti83YU0xZUNWUGNOMkdzbDVTTHhGS3hycmJDVE9DUi94ZWdkWjFLRW5KWnJq?=
 =?utf-8?B?QXd2VnRPWlJDMTFpTjQwN29WMXphemhJNGoyenU1YmpLVmhJL0pHVVRudW5t?=
 =?utf-8?B?LzRZeVpKZmtNNFBDTWpXZjBvMFp6Q2VRcmpZRUNQdStkMDVzcFFZMVAza1py?=
 =?utf-8?B?ZzBxL2ljc3BsVjNRMStBbVhnWGFCUHRFV1B2bnFMazJVVkxHQUdpZzZvbWN1?=
 =?utf-8?B?VThOdmxJclhOV1dUcG5aZVRCS2Z0aDZoZXhKWlA2R0ZrVkJwN0pMUjNjRC9T?=
 =?utf-8?B?dzFpcVZ0Q0pTS3poTHNhS2lsbDQ2M1RwTXVGczRVT0oyaWVoWHdmdVlMeTJy?=
 =?utf-8?B?aWIxQVZTNkpGdGVCTFlqMjZjdnR3TTR0bnVMcFZvZHh4MkV4dlJIZm9yTmYw?=
 =?utf-8?B?TzQ0dy8ydW42S0E5ZlhtRVdjNDEzWmtlcXBlMXdNbTArcmJubzV6azgrL0I5?=
 =?utf-8?B?ajZmMm1SWmVyM0JnQW5WdldwZU1SRzczTDE0bFA1M1FBcnUxS042Y0dvZTlY?=
 =?utf-8?B?SXRqNE43a3phWFhPdjVkL1VDdFA2dmhhRGpONEhDYzhRK1EweFdkVWdNL2ZX?=
 =?utf-8?B?b3QwYmhDU2NnYXU1ZCtLNlVhcStoUnpPdzAyaUtVcHozd0FacXdhUzZoTk9r?=
 =?utf-8?B?ZFFIREhvRklmRitwTlBQTXpndUlQWnlobjhPMDY5a0JMK3N6MFB5VnhucXh4?=
 =?utf-8?B?eHhiTUhCUEpkTFpuNHJsaTc5QldmUjg0UzZyYVMzV21TckxKTDBxK1FySmhB?=
 =?utf-8?B?VjB5QTVScTYveFc3WWJQdVI0T0ZuVUNNTGtITnJnZzRadWtqeEF6NFVUSWpq?=
 =?utf-8?B?WU43VVE0T3BDSTNTRTREeXdtb2ZQaHlSVnlDWE5rMVRMQ29xWEN3YXJyZXhY?=
 =?utf-8?B?UHlKdmtFQitmZnJXUzZRckRkTkVaNHZEQVBieWVJNDBGWmlnWkg0Zk9HLzY1?=
 =?utf-8?B?RHhuODRnc3BqUDhrUUw1OXl0bE95ay9VN3h5OW0vdW1vWWxWOGtNNkxqYWI5?=
 =?utf-8?B?dlhNWVdUTHJ4bS9aZnRYMWcwZGk0dWJkM2JkazlhT3pRMjVkOTRjQ0VkSEN0?=
 =?utf-8?Q?dYwuPbutC+7ymVOIAc60GE2uo?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <784FA7B981AEDE48A324E8C5BD01EE95@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd6f903-7746-48ed-eec8-08da69db3657
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 23:05:45.6208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BcDQaEERRKH3B+vAugQC4q3zOoxg/oiofqD873Gt7CXybQDpVrN7d9vdAtdmnntoj4oe3RoRySNCufoIOIlcKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1239
X-Proofpoint-GUID: yeeb_2oy_0zDYvgZTtBUC4VA_MqgPSxx
X-Proofpoint-ORIG-GUID: yeeb_2oy_0zDYvgZTtBUC4VA_MqgPSxx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 bulkscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207190094
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8xOS8yMDIyLCBNaWtlIENocmlzdGllIHdyb3RlOg0KPiBPbiA3LzE4LzIyIDk6MDcgUE0s
IFRoaW5oIE5ndXllbiB3cm90ZToNCj4+IFRhc2sgQUJPUlQgVEFTSyBTRVQgZnVuY3Rpb24gaXMg
cmVxdWlyZWQgYnkgU0NTSSB0cmFuc3BvcnQgcHJvdG9jb2wNCj4gV2hhdCBPUyBpcyB1c2luZyB0
aGlzIGFuZCBob3cgZG8gdGhleSB1c2UgaXQ/IEZvciB0aGUgbGF0dGVyLCBkb2VzIHRoZQ0KPiBP
UyB0cnkgYW4gYWJvcnQgZm9yIGVhY2ggY21kIGZpcnN0LCB0aGVuIHRyeSBhbiBhYm9ydCB0YXNr
IHNldCBpZiB0aGUNCj4gYWJvcnRzIGZhaWwgKGRvZXMgZmFpbCBtZWFuIGdldCBhIHJlc3BvbnNl
IHRoYXQgaW5kaWNhdGVzIGZhaWx1cmUgYW5kDQo+IGFsc28gZG9lcyBhIHRpbWVvdXQgY291bnQp
PyBPciBkb2VzIGl0IHN0YXJ0IHdpdGggdGhlIGFib3J0IHRhc2sgc2V0Pw0KDQpJdCdzIG5vdCBm
cm9tIGFueSByZWFsIGRyaXZlci4gSXQncyBmcm9tIHRoZSBVU0IgQ29tcGxpYW50IFZlcmlmaWNh
dGlvbiANCihodHRwczovL3d3dy51c2Iub3JnL2RvY3VtZW50LWxpYnJhcnkvdXNiM2N2KS4gSXQg
dXNlcyB0aGUgY29tbWFuZCBmb3IgDQpVQVNQIGNvbXBsaWFudCB0ZXN0Lg0KDQpUaGUgdGVzdCBv
bmx5IGV2ZXIgYWJvcnRzIGEgc2luZ2xlIGNvbW1hbmQgYXQgYSB0aW1lLCBzbyBJIGNhbid0IGNv
bmZpcm0gDQp5b3VyIGZvbGxvd2luZyBxdWVzdGlvbnMuIFRoZSBTQU00LXIxNCB3YXNuJ3QgY2xl
YXIgb24gdGhvc2UgcXVlc3Rpb25zIA0KZWl0aGVyLg0KDQo+IEknbSBhc2tpbmcgYmVjYXVzZSBp
dCBsb29rcyBsaWtlIGlmIGl0IGRvZXMgYW4gYWJvcnQgZmlyc3QsIHRoZW4gdGhlDQo+IGFib3J0
IHRhc2sgc2V0IHdpbGwgYWx3YXlzIHJldHVybiBUTVJfVEFTS19ET0VTX05PVF9FWElTVC4gRm9y
IHRoZSBhYm9ydA0KPiB3ZSB3aWxsIHJlbW92ZSB0aGUgY21kcyBmcm9tIHRoZSBzdGF0ZV9saXN0
IHNvIGlmIHRoZSBhYm9ydCB0YXNrIHNldCBydW5zDQo+IGFmdGVyIHRoZSBpbml0aWF0b3IgaGFz
IHRyaWVkIHRvIGFib3J0IGFsbCB0aGUgY29tbWFuZHMgaXQgd2lsbCBuZXZlcg0KPiBmaW5kIGFu
eS4NCg0KSSBkaWRuJ3Qgbm90aWNlIHNpbmNlIEkgZHJvcHBlZCBhIHBhdGNoIHdoZXJlIEkgcmVt
b3ZlZCB0aGUgDQpUTVJfVEFTS19ET0VTX05PVF9FWElTVCBhbmQgVUFTUCBjb252ZXJ0cyB0aGlz
IHRvIFJDX1RNRl9DT01QTEVURS4gVUFTUCANCnJlc3BvbmQgdG8gRlVOQ1RJT04gQ09NUExFVEUg
d2l0aCBSQ19UTUZfQ09NUExFVEUuIEknbGwgY2FuIG1ha2UgYSBmaXggDQp0byB0aGF0Lg0KDQpJ
ZiB0aGVyZSdzIGFueSBzdWdnZXN0aW9uIHRvIGltcGxlbWVudCB0aGlzLCBwbGVhc2UgYWR2aXNl
Lg0KDQpUaGFua3MsDQpUaGluaA0KDQo+PiBzdGFuZGFyZHMgKFNBTS00IHIxNCBzZWN0aW9uIDcu
MykuIEl0IGlzIHNpbWlsYXIgdG8gQUJPUlQgVEFTSw0KPj4gZnVuY3Rpb24sIGJ1dCBpdCBhcHBs
aWVzIHRvIGFsbCBjb21tYW5kcyByZWNlaXZlZCBvbiBhIHNwZWNpZmllZCBJX1QNCj4+IG5leHVz
IHJhdGhlciB0aGFuIGEgc3BlY2lmaWMgcmVmZXJlbmNlZCBjb21tYW5kLiBNb2RpZnkNCj4+IGNv
cmVfdG1yX2Fib3J0X3Rhc2soKSB0byBzdXBwb3J0IFRNUl9BQk9SVF9UQVNLX1NFVC4NCj4+DQoN
Cg==
