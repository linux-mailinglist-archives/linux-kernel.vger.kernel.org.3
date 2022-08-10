Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BA958E456
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 03:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiHJBIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 21:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiHJBIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 21:08:44 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939D17FE71;
        Tue,  9 Aug 2022 18:08:42 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279JNWKk025674;
        Tue, 9 Aug 2022 18:08:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=pkjXoIJ+OOd4LFnXrwI7/7jIirzoteZR2yk6ujtKZvg=;
 b=hbdOfdDPWlZQAL0Ff9sOR1NDczO2VO0r+E50FBJuifrCQaR3l4nii+72tdaBL6/rMUQ9
 SFTgXqkRa6fGUkWDIy0Pt1hUXihYSke9BBC1pHhK+ruFAiDPXsmdUYn/Z9MGvkbZEEBl
 tsngpuk4aME8rp7LDr+0TpsU1jpYhbFGXuy8a68fik+DTp8KiiFUM3IOZiGejNuLTWxw
 rWXV4qg0oQ3/tdh7cvm7VdGho0nc0lX2Bm43qz9krjYFCF+jOvwvoNmEHxxhi/apPuI9
 8zNY+tqmrhaBDgc0B2KwmyyTHD7KNXw4wOe9E6Fvs8qG7DemCE4bq4ygauHla8bsmr06 ag== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3huwpt984r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 18:08:29 -0700
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id AE31AC00F9;
        Wed, 10 Aug 2022 01:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1660093709; bh=pkjXoIJ+OOd4LFnXrwI7/7jIirzoteZR2yk6ujtKZvg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=CyeSRJlUyozxqFdkp57i+0hvUhGwwi/Wie3pVhDbnQrj6d2at0ai5QeA8remtdWOV
         pB6u15vSew+o2w3bS2QzwhIarS9HZbsovqHso8utdKPIMOmxdTMXRctuLLVgI+eel+
         CgtGy5fMc9+lW2vk2ZfH8CH066gmepy9fblYew7dEkuUT+sErY94hfLCOB9/ZdTVAq
         c77QzX5wCTEfv+dyXt4ibpI14hz6pKD/2A0MVBpyuxbyO/xZxA2b4SA/ZpWzg11eX2
         kYdSKDlhb7Njh9fD3BUDFcxrqG9aEGzVSXOSLlOHJ0EWejcnRNM5nLUOgKMP40qsZv
         x6rrxpM2Bu/gg==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 8AEFFA0087;
        Wed, 10 Aug 2022 01:08:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 013EA400BA;
        Wed, 10 Aug 2022 01:08:25 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="bIm/7rJf";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfKTCJ1HMbmfU9JWNEO2PsKx0WxkeEKPVo6c/rCoUPiEzd1bRuqmXAqFdVtLnyQlZxT8XK0V04sci9/6H2YjtEOTYZK6aSjJULorZaiq013c9XmOxEQGSQyQjdsbpR96ldrQ5rRUkdT3xBBgtYPv2vv5GTwaNB2xLXif20n6muRu3wPZBHzmtXIKsLNDHhpXvJKJJNJbFfroHcSMNNekH5sTIGpYWEzYb/5dh9DxoXnjNbBbr39/D2DIFzMlY8cRSpaqNN/ZZ++f+KSBkQH9mfoXBc7QkK9W4kTMfq2+SWYyEZ9GvgyMGTjJKbcWJ94jago1eqdqwN/tidw/gdPdlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkjXoIJ+OOd4LFnXrwI7/7jIirzoteZR2yk6ujtKZvg=;
 b=XhMGq06s1YTezgGFZoYWO5fW/QYY4M6Z9CX4iaWQPF4iHM6vDUplZ/DhxSZP7rH6zOl2B2J2q8yFC05X1RbMPL3PpyMAtpRO8zjzazCDAu0nv9kopB8hw9raBdhSdmaK2Vjj+13cX+k0pYl0NhC5sbpFi0Dd1cpn/BTMDvMei6ZTkG7/k0QvHgW0RQaPaTrIBSdrHZDx3PMMfmhhqvtdEXzD81WU3ACpEFXtMA3/8UIJJoUMwDjRKUM6sXaWKJnZ0LBm1XhZ2qVblFRAyQC+6cJ3bf8ROY5sWZoa+1LRWLWLI2d/dEcum8Ajn60KajKiwVI1zRt/Mu7KJEomWNtr6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkjXoIJ+OOd4LFnXrwI7/7jIirzoteZR2yk6ujtKZvg=;
 b=bIm/7rJfTmcVcZmYmFExWLUpah9MF5/CA/fKppWHHShpoHxCSPARbhAYbZ+BLS2VqQiTxnwXeCXTPkLhc+0oV4ITpXJEggr5sPy1RHRKATeC9XPQj80PmHH1dMICz7iSzUcPm7Sdu/efoaGQLg+rwqE1fCVb336cMeytNMnwgsU=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM4PR12MB5069.namprd12.prod.outlook.com (2603:10b6:5:388::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 10 Aug
 2022 01:08:22 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c%7]) with mapi id 15.20.5504.020; Wed, 10 Aug 2022
 01:08:21 +0000
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
Thread-Index: AQHYpqSxYg+mSBtinkWEjfftWY3s8a2cSDKAgAMApwCAAD6nAIAHe4yAgABbB4A=
Date:   Wed, 10 Aug 2022 01:08:21 +0000
Message-ID: <ac8e012f-08f3-baed-ead0-231f0527864c@synopsys.com>
References: <1659467920-9095-1-git-send-email-quic_eserrao@quicinc.com>
 <1659467920-9095-3-git-send-email-quic_eserrao@quicinc.com>
 <049219f1-8c68-e4cc-7bf9-1e8c214e80aa@synopsys.com>
 <32a0765e-00d9-1a67-bf36-4060c5fcb008@quicinc.com>
 <8705d52e-2181-aebd-43b8-2c8d021339c7@synopsys.com>
 <5ad70f41-622e-2d75-7c53-89aba1255a5f@quicinc.com>
In-Reply-To: <5ad70f41-622e-2d75-7c53-89aba1255a5f@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e7c3486-0263-472b-bc26-08da7a6cd160
x-ms-traffictypediagnostic: DM4PR12MB5069:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pxBQyEdsXIf/2mDAXv0lNrJAMvCyTUeUoSQddI6Y2icaOEzuL1xaWvdDRtqHB1znZD1bABZ1mImMExp6p6MfJqqziuAHWITukD0IupOeL0DdoYKYgbTn9EL3EUDhlcQRfsXK2932ldEk3EFZy1Whbz/3ueOqgh2szl6apapVOt2AyPxUQq82F8LVI4GqR/GcXa7XR3y08oBESaT65yXgLEzIEsDWelV6KkHtxAuIcm3rdxriF4MG8DR3cglzfovr4z//Y+/wRe9vQ/SuauMJoV9qSyrGLI+4b7j5ruuLGn6xqhQa+uqBNGKU14V1v28k8pYeLrVtsmIU/3I4YOkJjTVEsMnnV8f0V88pqGznBq4zqEGpsgIgM/jB62GuGuwBleOYvPnVF40WnCuUjVwLzw9RFz0nV3l0A8IAsxoY9FsngbItLd1K1BFiTXQ+FKGH+kR94gHgCnMKHQfAnyl/2Qz7TlWJEvr3gCcDA7rQg38x2Gg9Xzy1w8Pgg58tcEmLdc6jbHwC1L2tMMvN9pTnhCIZOuLQb58KYEx/Kmq79OMk2oJAS9wwNxl/FjyUtRphp2TtLtEYnrv3WrhM0/WcJM+FOvGMawnj8TRoCqg1RPtT9SUgzHLa9aSqr5wp/iVqrA8TY3inh61B452IB8lfEYystvrdzEv4xnlPFKohJerexVmMCouQMRdVExTgg0/U/PtZDudNKvWsnpRVk/T7vANNyVKijnoFYTKmzkXJgVmeJZhe1515bbyyWHWFyd0tcMzKzR9kmXishjOFM8CIvg6rdtghzEKHF46GDpOXj94WHMW1S4WO40JN+y7PMcDPvTdls1XBdyaU6Ua8bdKCkQbkVM2ekWUK0sQCInuYdJMsMBfXhIRbhqHhcKrWqO7j
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(39860400002)(396003)(366004)(136003)(478600001)(110136005)(316002)(6486002)(54906003)(71200400001)(41300700001)(4326008)(66446008)(2906002)(66946007)(8676002)(64756008)(5660300002)(8936002)(66476007)(38100700002)(76116006)(66556008)(186003)(30864003)(122000001)(31686004)(38070700005)(31696002)(2616005)(36756003)(86362001)(6512007)(6506007)(53546011)(83380400001)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bk9sVG5wMnlhOTY0SWJ4Q0Z0QlJaaHRnL2oyU3pNWUJ3aldiQ3pDc3Z3RUht?=
 =?utf-8?B?c1ZrYVlDTkNnakRhY0tDZ1lLNWxoNzdrU044Z2YyblJNd001Z1dwcG1vUG9r?=
 =?utf-8?B?dEwvUmVyS1JYdVhyMGQrYUcvQWpnUE1MOGpBcDRjWFlrNG5ySGxZTlFtNVNV?=
 =?utf-8?B?bFI4bEtGU0o5RFFnMUFIS2piZGUzWUI1OXg1R2w5cVFVWVJ1WHJzdEZQV1pQ?=
 =?utf-8?B?clRnZVY0ekdVODl2ZlV1Ym93ZXBsMVBRcHpaa3dsd0NDbHZKdXdhcVBNTVk3?=
 =?utf-8?B?bktwZUdKbVAwNjdFSEJwTy9qMEFUZEtzWmJoaUVJdmJiRHJYazJvUW8wcGI4?=
 =?utf-8?B?SW9JSTFnaDdWRWJibEJxK3dmTzhrVTVzZW1pQkwxRC9hTHpnMkMvRzMyZE9N?=
 =?utf-8?B?bktiZnZDbnpsclBTcnAySDVneVkrUWxaUnU5TVR0N3dZcDNhZ1V4YVVjNzRs?=
 =?utf-8?B?NWgrUjN5OXg1UmUvcUZiNlRBeEhmRjhIWGx0V1IxMU9iNld0RjdTc1NFR053?=
 =?utf-8?B?T2Z4RXl5cnBZWEoxVnFFbFlwbElwWnFYYWN5TmdZdHlqT1FURG5vTHJWcUph?=
 =?utf-8?B?SjhUcVZUM1Zhd1hXY3lYZUd0US92WGdXSFdvVGhYOUVvQm9QM1R2am52TWVs?=
 =?utf-8?B?TUhJQk4rTGZDOW0vaStEdGg5WmZpVEhxNzBMTWNFQUpOSmRuQUtGVEs3WU9T?=
 =?utf-8?B?Y1E5K05aZ1o4eDVJYmI5Zm1lalNFS0oyam0wZHY0dVg0QTlQTmJlREhsNk1W?=
 =?utf-8?B?RnByTFlRVHFTSEZvMU9MbnU0WFlCdmFZRDhqSENrWDZKRlZJNHlPN0lXMzhj?=
 =?utf-8?B?ejBqTTNKMDBPTU0wbThhcXpWcVJSdnJPMFJ0akVTa0szdDAya2xSUmNsYlRs?=
 =?utf-8?B?WmRvT1l0cnZDV0UzRDBCZnpsRm5VZXdiV0JXMFdjOU4rVWdEUko5bkhRUTVp?=
 =?utf-8?B?dGpJQVg1bGFQYzliaGN1OE0rcEluZVllZENCS2Y2TExQMVFSb0ltcTArY3g0?=
 =?utf-8?B?bEJKM1BQWFlWbW12WFpOKy9Ha0RkSzdCbVpQcHJRc3dub3AzUjg1RWgzUUMy?=
 =?utf-8?B?YUpLek4vRDdZbTgxNjNjakthbWVONFVMOHV2eXNsRnEzZ1R4cXNaQUVPS1pU?=
 =?utf-8?B?c1FBSlJVaENhYjhWdDdLVHVDNDBaNXQ2V1Z2SjU1SHZYODBLaitNcVBWaVZp?=
 =?utf-8?B?dlJDTUdYTW9mc2UwS1Vrd3l0YjV4eWJsN29XZ1lhUm9EckVVWnlLVU5YUEor?=
 =?utf-8?B?K0I1NG1TWG1CS2lOMHNpYmt2U2RTalVlY1ZOcUNBS1lyak14UkFpaHplZE5F?=
 =?utf-8?B?U2Jtd0UvRXZuc2grbjFjbUp5dEdmcnYzdDBDZ1MyWFB5dm9VVkJkZVJVUENK?=
 =?utf-8?B?T2pianlsSnd1M2w0Y2N0TXo1WlBNN3JyK09jTTMxUXlmM0dPdEF0T1ZmVVh4?=
 =?utf-8?B?Sm5NMnVNOTRRNm0xbVpJOVJNL2lqc2pJaUNydWI0SWl5SERkR1lSMm92djBZ?=
 =?utf-8?B?YlpKOU9HUzh5dnRwR3F2L3VPYSsrczZQdW5zai8zWnpaYjFQc29BWGFWdFp0?=
 =?utf-8?B?VzlxWE96cjBDQ2lUN0s1S2xzTHZTb3JLVXBmR0l6UFhxdzhYbTJjS3UyMjgr?=
 =?utf-8?B?YnhORTJuZitZZUtLd0FvK3RZdzBKOFFWandLNHIyazlrK0hxZUpIK0IvMkxN?=
 =?utf-8?B?T0MvM2NGRzNYemNVWEFFTHRzUUpYVUFZSTVVRk13WHBMK3RtQWpyS2dlVjhQ?=
 =?utf-8?B?a3VidWFUWlRXaWI2QnhqWGoyK3lnQ0c3NEN0TVNJV1VMTWlLdkQxMGNWYktt?=
 =?utf-8?B?SjhRaCtsMnpINlNJR0JYSEkxck5YbnROdGxMSTRZcEpreGszdGVGVXAvMDI5?=
 =?utf-8?B?L1lzSWR1anZhT0VOSWRoL0hDZEVKKy9xakdWS2NyOWNiY09yQjNIdTlmZTl0?=
 =?utf-8?B?TUNJeDg0RWQ1dmltRm96UDBsSTdaL1R0R0hVZ0dxaExkNit5NC9KOC96RERj?=
 =?utf-8?B?NC9yem9TWHJaNTQ1NlVZUG9XUVdSOVYzM1ZaNk02MGtlZkZra0lBWFllbWhq?=
 =?utf-8?B?S1loZzRlUHJiMXg5Z25CcHFkSW9CclRUN1lkYUlkYjBGNXRRajFWVFVQbG5C?=
 =?utf-8?Q?tF4dMowrzrTNCYBR9YH+yBcuB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73D23B9C4402F64184A52277E1836175@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7c3486-0263-472b-bc26-08da7a6cd160
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2022 01:08:21.3555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vi3mZyiomUPyf4r/C5Ads55S0keesnxWwKRlb5tB1c4x7rp/GJX8Zq5M/zrnbsJA1K8BaofvHHpgBUKO1h0Dow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5069
X-Proofpoint-GUID: CqjyVgLoUB6zMBhPMQWEp1AVs6fzGLxi
X-Proofpoint-ORIG-GUID: CqjyVgLoUB6zMBhPMQWEp1AVs6fzGLxi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_01,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 phishscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208100002
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC85LzIwMjIsIEVsc29uIFNlcnJhbyB3cm90ZToNCj4gDQo+IA0KPiBPbiA4LzQvMjAyMiA2
OjI2IFBNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+PiBPbiA4LzQvMjAyMiwgRWxzb24gU2VycmFv
IHdyb3RlOg0KPj4+DQo+Pj4NCj4+PiBPbiA4LzIvMjAyMiA0OjUxIFBNLCBUaGluaCBOZ3V5ZW4g
d3JvdGU6DQo+Pj4+IE9uIDgvMi8yMDIyLCBFbHNvbiBSb3kgU2VycmFvIHdyb3RlOg0KPj4+Pj4g
QW4gaW50ZXJmYWNlIHdoaWNoIGlzIGluIGZ1bmN0aW9uIHN1c3BlbmQgc3RhdGUgaGFzIHRvIHNl
bmQgYSBmdW5jdGlvbg0KPj4+Pj4gd2FrZXVwIG5vdGlmaWNhdGlvbiB0byB0aGUgaG9zdCBpbiBj
YXNlIGl0IG5lZWRzIHRvIGluaXRhdGUgYW55IGRhdGENCj4+Pj4+IHRyYW5zZmVyLiBPbmUgbm90
YWJsZSBkaWZmZXJlbmNlIGJldHdlZW4gdGhpcyBhbmQgdGhlIGV4aXN0aW5nIHJlbW90ZQ0KPj4+
Pj4gd2FrZXVwIG1lY2hhbmlzbSBpcyB0aGF0IHRoaXMgY2FuIGJlIGNhbGxlZCBwZXItaW50ZXJm
YWNlLCBhbmQgYSBVREMNCj4+Pj4+IHdvdWxkIG5lZWQgdG8ga25vdyB0aGUgcGFydGljdWxhciBp
bnRlcmZhY2UgbnVtYmVyIHRvIGNvbnZleSBpbiBpdHMNCj4+Pj4+IERldmljZSBOb3RpZmljYXRp
b24gdHJhbnNhY3Rpb24gcGFja2V0LsKgIEhlbmNlLCB3ZSBuZWVkIHRvIGludHJvZHVjZQ0KPj4+
Pj4gYSBuZXcgY2FsbGJhY2sgaW4gdGhlIGdhZGdldF9vcHMgc3RydWN0dXJlIHRoYXQgVURDIGRl
dmljZSBkcml2ZXJzDQo+Pj4+PiBjYW4gaW1wbGVtZW50LsKgIFNpbWlsYXJseSBhZGQgYSBjb252
ZW5pZW5jZSBmdW5jdGlvbiBpbiB0aGUgY29tcG9zaXRlDQo+Pj4+PiBkcml2ZXIgd2hpY2ggZnVu
Y3Rpb24gZHJpdmVycyBjYW4gY2FsbC4gQWRkIHN1cHBvcnQgdG8gaGFuZGxlIHN1Y2gNCj4+Pj4+
IHJlcXVlc3RzIGluIHRoZSBjb21wb3NpdGUgbGF5ZXIgYW5kIGludm9rZSB0aGUgZ2FkZ2V0IG9w
Lg0KPj4+Pg0KPj4+PiBTZW5kaW5nIHRoZSBmdW5jdGlvbiB3YWtlIG5vdGlmaWNhdGlvbiBzaG91
bGQgYmUgZG9uZSBpbiB0aGUgY29udHJvbGxlcg0KPj4+PiBkcml2ZXIuIFRoZSBjb250cm9sbGVy
IGRyaXZlciBrbm93cyB3aGVuIGlzIHRoZSBwcm9wZXIgbGluayBzdGF0ZQ0KPj4+PiAoVTAvT04p
IHRoZSBkZXZpY2UgaXMgaW4gYW5kIHdvdWxkIG5vdGlmeSB0aGUgaG9zdCB0aGVuLg0KPj4+Pg0K
Pj4+PiBXaGF0IHdlIG5lZWQgdG8gYWRkIGluIHRoZSB1c2JfZ2FkZ2V0IGlzIHdoZXRoZXIgdGhl
IGRldmljZSBpcyByZW1vdGUNCj4+Pj4gd2FrZXVwIGNhcGFibGUuIFNvbWV0aGluZyBsaWtlIGEg
ZmxhZyB1c2JfZ2FkZ2V0LT5yd19jYXBhYmxlLg0KPj4+Pg0KPj4+PiBXZSB3b3VsZCBhbHNvIG5l
ZWQgc29tZSBmdW5jdGlvbnMgbGlrZQ0KPj4+PiB1c2JfZ2FkZ2V0X2VuYWJsZV9yZW1vdGVfd2Fr
ZXVwKCkNCj4+Pj4gYW5kIHVzYl9nYWRnZXRfZGlzYWJsZV9yZW1vdGVfd2FrZXVwKCkgZm9yIHRo
ZSBnYWRnZXQgZHJpdmVyIHRvIG5vdGlmeQ0KPj4+PiB0aGUgY29udHJvbGxlciBkcml2ZXIgd2hl
biBpdCBjaGVja3MgYWdhaW5zdCBVU0JfQ09ORklHX0FUVF9XQUtFVVAgaW4NCj4+Pj4gdGhlIGJt
QXR0cmlidXRlcyBjb25maWd1cmF0aW9uLg0KPj4+Pg0KPj4+PiBCUiwNCj4+Pj4gVGhpbmgNCj4+
Pg0KPj4+DQo+Pj4gSWYgd2UgaGFuZGxlIHRoaXMgaW4gY29udHJvbGxlciBkcml2ZXIsIHRoZW4g
aXQgd291bGQgZmFpbCB0byBnZXQgdGhlDQo+Pj4gcmlnaHQgaW50ZXJmYWNlIGlkIHdoZW4gbXVs
dGlwbGUgZnVuY3Rpb25zIGhhdmUgdG8gc2VuZCBmdW5jdGlvbiB3YWtlDQo+Pj4gbm90aWZpY2F0
aW9uLiBBcyBwZXIgVVNCMy4wIHNwZWMgKGJlbG93IHNuaXBwZXRzKSBhIGZ1bmN0aW9uIGNhbiBi
ZQ0KPj4+IGluZGVwZW5kZW50bHkgcGxhY2VkIGludG8gZnVuY3Rpb24gc3VzcGVuZCBzdGF0ZSB3
aXRoaW4gYSBjb21wb3NpdGUNCj4+PiBkZXZpY2UgYW5kIGVhY2ggZnVuY3Rpb24gaW4gZnVuY3Rp
b24gc3VzcGVuZCBzdGF0ZSBoYXMgdG8gc2VuZCBhDQo+Pj4gZnVuY3Rpb24gd2FrZSBub3RpZmlj
YXRpb24gdG8gZXhpdC4NCj4+Pg0KPj4+IFVTQiAzLjAgU3BlYyBTZWN0aW9uIDkuMi41LjMNCj4+
PiAiQSBmdW5jdGlvbiBtYXkgYmUgcGxhY2VkIGludG8gRnVuY3Rpb24gU3VzcGVuZCBpbmRlcGVu
ZGVudGx5IG9mIG90aGVyDQo+Pj4gZnVuY3Rpb25zIHdpdGhpbiBhIGNvbXBvc2l0ZSBkZXZpY2Ui
DQo+Pj4NCj4+PiBVU0IgMy4wIFNwZWMgU2VjdGlvbiA5LjIuNS40DQo+Pj4gIkEgZnVuY3Rpb24g
bWF5IHNpZ25hbCB0aGF0IGl0IHdhbnRzIHRvIGV4aXQgZnJvbSBGdW5jdGlvbiBTdXNwZW5kIGJ5
DQo+Pj4gc2VuZGluZyBhIEZ1bmN0aW9uIFdha2UgTm90aWZpY2F0aW9uIHRvIHRoZSBob3N0IGlm
IGl0IGlzIGVuYWJsZWQgZm9yDQo+Pj4gZnVuY3Rpb24gcmVtb3RlIHdha2V1cC4gVGhpcyBhcHBs
aWVzIHRvIHNpbmdsZSBmdW5jdGlvbiBkZXZpY2VzIGFzDQo+Pj4gd2VsbCBhcyBtdWx0aXBsZSBm
dW5jdGlvbiAoIGkuZS4sIGNvbXBvc2l0ZSkgZGV2aWNlcy4gSWYgdGhlIGxpbmsgaXMgaW4NCj4+
PiBhIG5vbi1VMCBzdGF0ZSwgdGhlbiB0aGUgZGV2aWNlIG11c3QgdHJhbnNpdGlvbiB0aGUgbGlu
ayB0byBVMCBwcmlvcg0KPj4+IHRvIHNlbmRpbmcgdGhlIHJlbW90ZSB3YWtlIG1lc3NhZ2UuIElm
IGEgcmVtb3RlIHdha2UgZXZlbnQgb2NjdXJzIGluDQo+Pj4gbXVsdGlwbGUgZnVuY3Rpb25zLCBl
YWNoIGZ1bmN0aW9uIHNoYWxsIHNlbmQgYSBGdW5jdGlvbiBXYWtlDQo+Pj4gTm90aWZpY2F0aW9u
Ig0KPj4+DQo+Pg0KPj4gT2ssIHNvIHRoZSBpc3N1ZSBoZXJlIGlzIGFkZGluZyB0aGUgYWJpbGl0
eSB0byBwYXNzIHRoZSBpbnRlcmZhY2UgbnVtYmVyDQo+PiB0byB0aGUgY29udHJvbGxlciBkcml2
ZXIgd2hlbiBzZW5kaW5nIHRoZSBkZXZpY2Ugbm90aWZpY2F0aW9uIGZ1bmN0aW9uDQo+PiB3YWtl
dXAgcmlnaHQ/IFNvdW5kcyBsaWtlIHRoZSBjYWxsYmFjayBzaG91bGQgYmUNCj4+IHNlbmRfd2Fr
ZXVwX25vdGlmaWNhdGlvbihnYWRnZXQsIGZ1bmNfaWQpIGluc3RlYWQuDQo+Pg0KPj4gQXMgZm9y
IHJlbW90ZSB3YWtldXAsIHRoZSBzcGVjIHN0YXRlcyB0aGF0ICJJZiByZW1vdGUgd2FrZSBldmVu
dCBvY2N1cnMNCj4+IGluIG11bHRpcGxlIGZ1bmN0aW9ucywgZWFjaCBmdW5jdGlvbiBzaGFsbCBz
ZW5kIGEgRnVuY3Rpb24gV2FrZQ0KPj4gTm90aWZpY2F0aW9uLiINCj4+DQo+PiBUaGUgU0VUX0ZF
QVRVUkUoRlVOQ1RJT05fU1VTUEVORCkgZG9lcyBub3QgbmVjZXNzYXJpbHkgbWVhbiB0aGUgaG9z
dA0KPj4gd2lsbCBwdXQgdGhlIGRldmljZSBpbiBTdXNwZW5kIFN0YXRlIGZvciBhIHJlbW90ZSB3
YWtlIGV2ZW50IHRvIG9jY3VyLg0KPj4gSXQgb25seSBwbGFjZXMgdGhlIGZ1bmN0aW9uIGluIEZ1
bmN0aW9uIFN1c3BlbmQuIEhvd2V2ZXIgb2Z0ZW4gdGhlIGhvc3QNCj4+IHdpbGwgcHV0IHRoZSBk
ZXZpY2UgaW4gc3VzcGVuZCBhZnRlciB0aGlzLiBUaGUgZHdjMyBkcml2ZXIgY2FuIHRyYWNrIGlm
DQo+PiB0aGUgaG9zdCBwdXRzIHRoZSBkZXZpY2UgaW4gc3VzcGVuZCBzdGF0ZSBhbmQgd2hhdCBp
bnRlcmZhY2VzIGFyZSBhcm1lZA0KPj4gZm9yIHJlbW90ZSB3YWtldXAuIElmIGEgcmVtb3RlIHdh
a2V1cCBldmVudCBvY2N1cnMsIHRoZSBkd2MzIGRyaXZlciBjYW4NCj4+IHNlbmQgRnVuY3Rpb24g
V2FrZSBOb3RpZmljYXRpb24gZm9yIGVhY2ggZnVuY3Rpb24gYXJtZWQgd2l0aCByZW1vdGUNCj4+
IHdha2V1cC4NCj4+DQo+PiBQbGVhc2UgY29ycmVjdCBtZSBpZiBJJ20gd3JvbmcuDQo+Pg0KPj4g
QWxzbywgbWFrZSBzdXJlIHRoYXQgZGV2aWNlIHJlbW90ZSB3YWtldXAgd2lsbCBzdGlsbCB3b3Jr
IGZvciBoaWdoc3BlZWQNCj4+IChub3QgZnVuY3Rpb24gcmVtb3RlIHdha2V1cCkuIEkgc2VlIHRo
aXMgY2hlY2sgd2hpY2ggZG9lc24ndCBsb29rIHJpZ2h0DQo+PiBpbiBvbmUgb2YgeW91ciBwYXRj
aGVzOg0KPj4gKyDCoMKgIGlmIChnLT5zcGVlZCA8IFVTQl9TUEVFRF9TVVBFUiAmJiAhZHdjLT5p
c19yZW1vdGVfd2FrZXVwX2VuYWJsZWQpDQo+PiArwqDCoMKgIMKgwqDCoCBkZXZfZXJyKGR3Yy0+
ZGV2LCAiJXM6cmVtb3RlIHdha2V1cCBub3Qgc3VwcG9ydGVkXG4iLCBfX2Z1bmNfXyk7DQo+PiAr
wqDCoMKgIMKgwqDCoCByZXQgPcKgIC1FUEVSTTsNCj4+ICvCoMKgwqAgwqDCoMKgIGdvdG8gb3V0
Ow0KPj4gK8KgwqDCoCB9DQo+Pg0KPj4gVGhhbmtzLA0KPj4gVGhpbmgNCj4+DQo+IA0KPiBGb3Ig
c3VwZXJzcGVlZCBjYXBhYmxlIGRldmljZXMsIHdoZW4gYSBmdW5jdGlvbiBpcyBpbiBzdXNwZW5k
IHN0YXRlIGFuZA0KPiB3YW50cyB0bw0KPiBpbml0aWF0ZSBhIHJlc3VtZSwgaXQgaGFzIHRvIHNl
bmQgYSBmdW5jdGlvbiB3YWtlIG5vdGlmaWNhdGlvbiB0byB0aGUNCj4gaG9zdCBpcnJlc3BlY3Rp
dmUNCj4gb2Ygd2hldGhlciB0aGUgZGV2aWNlIGlzIGluIFNVU1BFTkQgb3Igbm90LiBMaWtlIHlv
dSBtZW50aW9uZWQgdGhlDQo+IGRldmljZSBuZWVkIG5vdCBiZSBpbg0KPiBzdXNwZW5kIHN0YXRl
IHdoZW4gYSBmdW5jdGlvbiBpcyBzdXNwZW5kZWQuIElmIHRoZSBkZXZpY2UgaXMgaW4gc3VzcGVu
ZCwNCj4gdGhlbiBmaXJzdCB0aGUNCj4gY29udHJvbGxlciBkcml2ZXIgaGFzIHRvIHRyYW5zaXRp
b24gdGhlIGxpbmsgdG8gVTAgc3RhdGUgYmVmb3JlIHNlbmRpbmcNCj4gZnVuY3Rpb24gd2FrZSBu
b3RpZmljYXRpb24uDQoNCldhcyBJIGluY29ycmVjdD8gSSdtIG5vdCBjbGVhciBvbiB0aGUgcG9p
bnQgb2YgcmVpdGVyYXRpb24gYWJvdmUuDQoNCj4gTm90ZSB0aGF0IHRoZSBERVZJQ0VfUkVNT1RF
X1dBS0VVUCBmZWF0dXJlIGlzIGlnbm9yZWQgZm9yIHN1cGVyLXNwZWVkDQo+IGRldmljZXMgYW5k
IHRoZXkNCg0KV2UncmUgc3RpbGwgdGFsa2luZyBhYm91dCBFbmhhbmNlZCBTdXBlciBTcGVlZCBo
ZXJlLg0KDQo+IGFyZSBieSBkZWZhdWx0IHJlbW90ZSB3YWtldXAgY2FwYWJsZSBpZiBhbnkgZnVu
Y3Rpb24gd2l0aGluIHRoZSBkZXZpY2UNCj4gaXMgYXJtZWQgZm9yDQo+IGZ1bmN0aW9uIHJlbW90
ZSB3YWtldXAuDQoNCldoYXQgeW91J3JlIHNheWluZyBpcyBpZiB0aGUgaG9zdCBhcm1zIHRoZSBm
dW5jdGlvbiBmb3IgcmVtb3RlIHdha2V1cCwNCnRoZW4gdGhlIGRldmljZSBpcyByZW1vdGUgY2Fw
YWJsZS4NCg0KSG93ZXZlciwgdGhlIGltcG9ydGFudCBwb2ludCBoZXJlIGlzIHRoYXQgdGhlIGhv
c3Qgb25seSBhcm1zIGZvciByZW1vdGUNCndha2V1cCBfaWZfIHRoZSBkZXZpY2UgaXMgcmVtb3Rl
IHdha2V1cCBjYXBhYmxlLiBUaGF0IG5lZWRzIHRvIGJlIGNoZWNrZWQuDQoNCj4gDQo+IFNvIGlu
IG15IGN1cnJlbnQgaW1wbGVtZW50YXRpb24gd2hlbiB0aGUgaG9zdCBzZW5kcyBhIGZ1bmN0aW9u
IHN1c3BlbmQNCj4gU0VUX0ZFQVRVUkUoRlVOQ1RJT05fU1VTUEVORCksDQo+IHRoZSBkZXZpY2Ug
ZGVsZWdhdGVzIGl0IHRvIHRoZSByZXNwZWN0aXZlIGZ1bmN0aW9uIGRyaXZlci4gVGhlcmUgd2UN
Cj4gaW5zcGVjdCBpZiBpdCBpcyBjYXBhYmxlDQo+IG9mIGluaXRpYXRpbmcgYSBmdW5jdGlvbiBy
ZW1vdGUgd2FrZXVwLiBJZiBpdCBpcywgdGhlbiB3aGVuIGEgcmVtb3RlDQo+IHdha2V1cCBldmVu
dA0KPiBvY2N1cnMgKGluIG15IGN1cnJlbnQgaW1wbGVtZW50YXRpb24gd2hlbiBUQ1AvSVAgbGF5
ZXIgd2FudHMgdG8gc2VuZA0KPiBkYXRhIHRvIHRoZSBob3N0LiBwYXRjaCM1KSB0aGVuDQo+IHdl
IHRyaWdnZXIgYSBmdW5jdGlvbiB3YWtldXAgYnkgY2FsbGluZyB1c2JfZ2FkZ2V0X2Z1bmNfd2Fr
ZXVwKGdhZGdldCwNCj4gaWQpIGNhbGxiYWNrLiBDb250cm9sbGVyIGRyaXZlciB0aGVuDQo+IGNo
ZWNrcyBpZiB0aGUgZGV2aWNlIGlzIGluIHN1c3BlbmQgb3Igbm90LiBJZiBpdCBpcyBpbiBzdXNw
ZW5kLCBpdCBmaXJzdA0KPiBicmluZ3MgdGhlIGRldmljZSB0byBVMCBzdGF0ZQ0KDQoiYnJpbmdz
IHRoZSBkZXZpY2UgdG8gVTAgc3RhdGUiIG1lYW5zIHRoZSBkZXZpY2UgaW5pdGlhdGVzIHJlbW90
ZSB3YWtldXANCmhlcmUuDQoNCj4gYW5kIHRoZW4gc2VuZHMgYSBmdW5jdGlvbiB3YWtlIG5vdGlm
aWNhdGlvbiAodmlhDQo+IGR3YzNfc2VuZF9nYWRnZXRfZ2VuZXJpY19jb21tYW5kKCkgQVBJKSBv
bmx5IGFmdGVyIGFuDQoNClNvIG5vdyB0aGUgZHdjMyB0cmFja3Mgd2hpY2ggaW50ZXJmYWNlKHMp
IHdlcmUgYXJtZWQgZm9yIHJlbW90ZSBoZXJlPw0KDQpJIGRvbid0IHJlY2FsbCBzZWVpbmcgaXQg
aW4geW91ciBwYXRjaGVzLiBEaWQgeW91IGhhbmRsZSBhbmQgc2VuZCBkZXZpY2UNCm5vdGlmaWNh
dGlvbiBmb3IgYWxsIHRoZSBmdW5jdGlvbnMgYXJtZWQgd2l0aCByZW1vdGUgd2FrZXVwIGFmdGVy
IGRldmljZQ0Kd2FrZXVwPw0KDQoNCj4gVTAgZXZlbnQgaGFzIG9jY3VycmVkLiBJZiB0aGUgZGV2
aWNlIGlzIG5vdCBpbiBzdXNwZW5kIHRoZW4gaXQgZGlyZWN0bHkNCj4gc2VuZHMgZnVuY3Rpb24g
d2FrZSBub3RpZmljYXRpb24NCj4gdG8gdGhlIGhvc3QuIE9uY2UgdGhlIGhvc3QgcmVjZWl2ZXMg
dGhlIGZ1bmN0aW9uIHdha2Ugbm90aWZpY2F0aW9uIGl0DQo+IHNlbmRzIGEgU0VUX0ZFQVRVUkUo
RlVOQ1RJT05fU1VTUEVORCkNCj4gd2l0aCBzdXNwZW5kIGJpdCAoQklUIDApIHJlc2V0IHRvIHNp
Z25hbCBmdW5jdGlvbiByZXN1bWUuIFRoZSBjb250cm9sbGVyDQo+IGRyaXZlciB1cG9uIHJlY2Vp
dmluZyB0aGlzIHBhY2tldA0KPiBkZWxlZ2F0ZXMgdG8gdGhlIHJlc3BlY3RpdmUgZnVuY3Rpb24g
ZHJpdmVyLiBOb3RlIHRoYXQgYXQgdGhpcyBwb2ludCB0aGUNCj4gZGV2aWNlIGlzIGluIFUwIHN0
YXRlIGJ1dCBzb21lIG90aGVyDQoNCldlIGNhbid0IGFzc3VtZSB0aGF0IHRoZSBkZXZpY2UgaXMg
aW4gVTAgc3RhdGUuIFRoZXJlJ3MgYWxzbyBubw0KbWVjaGFuaXNtIGluIHlvdXIgY2hhbmdlIHRv
IGtub3cgdGhhdCBlaXRoZXIuDQoNCj4gZnVuY3Rpb24gd2l0aGluIHRoZSBkZXZpY2UgbWF5IHN0
aWxsIGJlIGluIHN1c3BlbmQgc3RhdGUgKGlmIG1vcmUgdGhhbg0KPiBvbmUgZnVuY3Rpb24gd2Fz
IHB1dCB0byBzdXNwZW5kIHN0YXRlKS4NCj4gU28gdGhlIG9ubHkgd2F5IHRvIGV4aXQgZnJvbSBm
dW5jdGlvbiBzdXNwZW5kIGlzIHZpYSBmdW5jdGlvbiByZXN1bWUNCj4gd2hpY2ggaXMgaW5kZXBl
bmRlbnQgb2YgZGV2aWNlIHN1c3BlbmQvcmVzdW1lLg0KPiANCj4gQWxzbyB0aGUgdGFzayBvZiBm
aW5kaW5nIHRoZSBpbnRlcmZhY2UgaWQgaXMgZG9uZSBieSBjb21wb3NpdGUgZHJpdmVyDQo+IGJl
Y2F1c2UgbW9zdCBmdW5jdGlvbiBkcml2ZXJzIGhhdmUNCj4gYSB0cmFuc3BvcnQgbGF5ZXIgYW5k
IHRoaXMgbGF5ZXIgaXMgdGhlIG9uZSByZXNwb25zaWJsZSBmb3IgaXNzdWluZyBhDQo+IGZ1bmN0
aW9uIHJlbW90ZSB3YWtldXAgYW5kDQo+IHRoaXMgaGFzIG5vIGRpcmVjdCByZWZlcmVuY2UgdG8g
aW50ZXJmYWNlIGlkLiBGb3IgZXhhbXBsZSB1X2V0aGVyDQo+IHRyYW5zcG9ydCBsYXllciBjYW4g
aGF2ZSBlaXRoZXIgZl9lY20gb3IgZl9ybmRpcw0KPiBhcyBpdHMgdW5kZXJseWluZyBjaGFubmVs
IGFuZCB1X2V0aGVyIGhhcyBubyBrbm93bGVkZ2Ugb2YgdGhlIGludGVyZmFjZQ0KPiBpZC9mdW5j
dGlvbiBkcml2ZXIgaXQgaXMgdXNpbmcuDQo+IA0KDQo+IEZvciBoaWdoIHNwZWVkIGRldmljZXMg
dGhlcmUgaXMgbm8gY29uY2VwdCBvZiBmdW5jdGlvbiBzdXNwZW5kIGFuZCB0aGVyZQ0KPiBpcyBv
bmx5IGRldmljZSBzdXNwZW5kLiBUaGUgYWJpbGl0eQ0KPiBvZiBhIGRldmljZSB0byBzZW5kIGEg
cmVtb3RlIHdha2V1cCB0byBleGl0IGZyb20gc3VzcGVuZCBpcyBkaWN0YXRlZCBieQ0KPiBERVZJ
Q0VfUkVNT1RFX1dBS0VVUCBmZWF0dXJlIHNlbGVjdG9yLg0KPiBUaGUgYmVsb3cgc25pcHBldCBj
b250cm9scyB0aGlzIGFzcGVjdCBhbmQgc2VuZHMgcmVtb3RlIHdha2V1cCBmb3IgaGlnaA0KPiBz
cGVlZCBkZXZpY2VzIG9ubHkgaWYgdGhleSBhcmUgcmVtb3RlIHdha2V1cCBjYXBhYmxlLg0KPiBk
d2MtPmlzX3JlbW90ZV93YWtldXBfZW5hYmxlZCBmbGFnIGlzIHNldCB3aGVuIERFVklDRV9SRU1P
VEVfV0FLRVVQIGlzDQo+IHJlY2VpdmVkLg0KPg0KDQpUaGUgZmxhZyAiaXNfcmVtb3RlX3dha2V1
cF9lbmFibGVkIiBpbXBsaWVzIHRoYXQgaXQgYXBwbGllcyBmb3IgYm90aA0KZGV2aWNlIHJlbW90
ZSB3YWtldXAgYW5kIGZ1bmN0aW9uIHJlbW90ZSB3YWtldXAuIElmIGl0IG9ubHkgbWVhbnQgZm9y
DQpmdW5jdGlvbiByZW1vdGUgd2FrZXVwLCB0aGVuIHJlbmFtZSBpdC4gQnV0IEkgdGhpbmsgeW91
IGNhbiB1c2UgdGhlIHNhbWUNCmZsYWcgZm9yIGJvdGggc2NlbmFyaW9zLg0KDQoNCj4gK8KgwqDC
oCBpZiAoZy0+c3BlZWQgPCBVU0JfU1BFRURfU1VQRVIgJiYgIWR3Yy0+aXNfcmVtb3RlX3dha2V1
cF9lbmFibGVkKQ0KPiArwqDCoMKgwqDCoMKgwqAgZGV2X2Vycihkd2MtPmRldiwgIiVzOnJlbW90
ZSB3YWtldXAgbm90IHN1cHBvcnRlZFxuIiwgX19mdW5jX18pOw0KPiArwqDCoMKgwqDCoMKgwqAg
cmV0ID3CoCAtRVBFUk07DQoNCkFsc28sIGRvbid0IHVzZSAtRVBFUk0uIFVzZSAtRUlOVkFMLg0K
DQo+ICvCoMKgwqDCoMKgwqDCoCBnb3RvIG91dDsNCj4gK8KgwqDCoCB9DQo+IA0KPiBQbGVhc2Ug
bGV0IG1lIGtub3cgeW91ciB0aG91Z2h0cyBvbiB0aGlzIGFwcHJvYWNoLiBJIHdpbGwgYWRkcmVz
cyB5b3VyDQo+IG90aGVyIGNvbW1lbnRzIGFuZCByZWN0aWZ5IHRoZSBwYXRjaGVzIGFjY29yZGlu
Z2x5Lg0KPiANCg0KDQpUbyBzdW1tYXJpemUgdGhlIHBvaW50czoNCg0KMSkgVGhlIGhvc3Qgb25s
eSBhcm1zIGZ1bmN0aW9uIHJlbW90ZSB3YWtldXAgaWYgdGhlIGRldmljZSBpcyBjYXBhYmxlIG9m
DQpyZW1vdGUgd2FrZXVwIChjaGVjayBVU0JfQ09ORklHX0FUVF9XQUtFVVAgaW4gYm1BdHRyaWJ1
dGVzIGFuZCBoYXJkd2FyZQ0KY2FwYWJpbGl0eSkNCg0KMikgSWYgdGhlIGRldmljZSBpcyBpbiBz
dXNwZW5kLCB0aGUgZGV2aWNlIGNhbiBkbyByZW1vdGUgd2FrZXVwICh0aHJvdWdoDQpMRlBTIGhh
bmRzaGFrZSkgaWYgdGhlIGZ1bmN0aW9uIGlzIGFybWVkIGZvciByZW1vdGUgd2FrZXVwICh0aHJv
dWdoDQpTRVRfRkVBVFVSRShGVU5DX1NVU1BFTkQpKS4NCg0KMykgSWYgdGhlIGxpbmsgdHJhbnNp
dGlvbnMgdG8gVTAgYWZ0ZXIgdGhlIGRldmljZSB0cmlnZ2VyaW5nIGEgcmVtb3RlDQp3YWtldXAs
IHRoZSBkZXZpY2Ugd2lsbCBhbHNvIHNlbmQgZGV2aWNlIG5vdGlmaWNhdGlvbiBmdW5jdGlvbiB3
YWtlIGZvcg0KYWxsIHRoZSBpbnRlcmZhY2VzIGFybWVkIHdpdGggcmVtb3RlIHdha2V1cC4NCg0K
NCkgSWYgdGhlIGRldmljZSBpcyBub3QgaW4gc3VzcGVuZCwgdGhlIGRldmljZSBjYW4gc2VuZCBk
ZXZpY2UNCm5vdGlmaWNhdGlvbiBmdW5jdGlvbiB3YWtlIGlmIGl0J3MgaW4gVTAuDQoNCg0KTm93
LCByZW1vdGUgd2FrZXVwIGFuZCBmdW5jdGlvbiB3YWtlIGRldmljZSBub3RpZmljYXRpb24gYXJl
IDIgc2VwYXJhdGUNCm9wZXJhdGlvbnMuIFdlIGhhdmUgdGhlIHVzYl9nYWRnZXRfb3BzLT53YWtl
dXAoKSBmb3IgcmVtb3RlIHdha2V1cC4gSQ0Kc3VnZ2VzdGVkIHRvIG1heWJlIGFkZCB1c2JfZ2Fk
Z2V0X29wcy0+c2VuZF93YWtldXBfbm90aWZpY2F0aW9uKGdhZGdldCwNCmludGZfaWQpIGZvciB0
aGUgZGV2aWNlIG5vdGlmaWNhdGlvbi4gV2hhdCB5b3UgZGlkIHdhcyBjb21iaW5pbmcgYm90aA0K
b3BlcmF0aW9ucyBpbiB1c2JfZ2FkZ2V0X29wcy0+ZnVuY193YWtldXAoKS4gVGhhdCBtYXkgb25s
eSB3b3JrIGZvcg0KcG9pbnQgNCkgKGFzc3VtaW5nIHlvdSBmaXggdGhlIFUwIGNoZWNrKSwgYnV0
IG5vdCBwb2ludCAzKS4NCg0KVG8gYmUgYWJsZSB0byBkbyAzKSwgeW91IGNhbiB0ZWFjaCB0aGUg
Y29tcG9zaXRlIGxheWVyIF93aGVuXyB0byBzZW5kDQpkZXZpY2Ugbm90aWZpY2F0aW9uIGZ1bmN0
aW9uIHdha2UgYW5kIGZvciB3aGF0IGZ1bmN0aW9ucy4gVGhpcyBjYW4gYmUNCnJldHJ5IHNlbmRp
bmcgdGhlIG5vdGlmaWNhdGlvbiB1bnRpbCBzZW5kX3dha2V1cF9ub3RpZmljYXRpb24oKSBzdWNj
ZWVkPw0KDQpJIHN1Z2dlc3RlZCB0byBkbyB0aGF0IGluIGR3YzMgZHJpdmVyIHRvIGF2b2lkIGhh
dmluZyB0byBhZGQgdGhlIGxvZ2ljDQppbiBjb21wb3NpdGUgbGF5ZXIgYXMgSSB0aGluayBpdCBp
cyBzaW1wbGVyIGluIGR3YzMuIEhvd2V2ZXIsIHRoZQ0KZG93bnNpZGUgaXMgdGhhdCBvdGhlciBV
RENzIGhhdmUgdG8gaGFuZGxlIGl0IGxpa2UgZHdjMyBhbHNvLg0KDQpOb3cgdGhhdCBJIHRoaW5r
IGFib3V0IGl0IGFnYWluLCBpdCBtYXliZSBiZXR0ZXIgdG8gZG8gaXQgaW4gdGhlDQpjb21wb3Np
dGUgZHJpdmVyIGZvciB0aGUgbG9uZyBydW4uIElmIHlvdSB3YW50IHRvIGhhbmRsZSB0aGlzIGlu
IHRoZQ0KY29tcG9zaXRlIGxheWVyLCBwbGVhc2UgZG9jdW1lbnQgYW5kIGRlc2lnbiB0aGUgbWVj
aGFuaXNtIHRvIGhhbmRsZSBhbGwNCnRoZSBwb2ludHMgYWJvdmUuDQoNClRoYW5rcywNClRoaW5o
DQoNCg==
