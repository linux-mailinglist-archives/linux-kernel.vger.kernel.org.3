Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AD058A470
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 03:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237298AbiHEB07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 21:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237139AbiHEB0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 21:26:55 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138FB2CCAD;
        Thu,  4 Aug 2022 18:26:52 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 274IEAa2014028;
        Thu, 4 Aug 2022 18:26:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=iaHc42azQeHOOkMh3a+cyKOhJjhcwNXKdf+B1rUjVHw=;
 b=rc3+h3RRubGtY5F+AKCwdkriJ/g9M6U453r9fYiIvFNCBgY+Bg0dtW3FGdPzIDXLwOya
 yAxzxOb6bwWI4gNsE5CvnJzbRkHeyd4e3RO4je8TwAnXyAq9MljWsttvddn2fyXXQSpV
 2WyBkGuCppNt0hj9bh3mCpiaXDlYNCfW/ZYaIClwBZyLGrFdXbtANS8RusL7OuHupzRd
 pq0fYAg8M1g1E5FCz8p3RJ4Jq/RAHhRzZAge+U7Ek23RJh8vqqlbQNwuoUrqLPIPC6+L
 FnzNXO4CaOhSZPXpR6dabEbX1w7EFYNy/lDyLHB9JJs+WEYuYzLLR6QcZTUs1h/00wRv rw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3hn3jv72dp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Aug 2022 18:26:40 -0700
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CAD9B4005A;
        Fri,  5 Aug 2022 01:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1659662799; bh=iaHc42azQeHOOkMh3a+cyKOhJjhcwNXKdf+B1rUjVHw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=fEG6xV8u/ZSfManSyxxT+dhx0sGZQDX9Kz1usO4nFJNXsnic4Wg1B5DCYyxN6Pzbr
         luKNWua9fJmI2HOY4+GHzTRmfnT52aCdms+iwnI/JCehPSf2aKkqgfNRopqIXRt8c2
         krVL8sTDdtYJOu/Pc1VxdmHAhneR09z2bNA9gkHlBCtBofXBo/tNQb+O+SEbochZP7
         PeLJywScBRhoQAlWqG8j5bRrpPS7/G2BhU5zsEU0yvJ5ZVoC9MmkWo9DxuwTGeQMOQ
         RbXn7yd0oO5bhjlntOWY1FWWgwJJCug84zsEw7lSEspgF9nT6pajG2KcALO1j+3Ss+
         CrEqGVkpcAgRA==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id EA2FBA02C6;
        Fri,  5 Aug 2022 01:26:37 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 616A3800B4;
        Fri,  5 Aug 2022 01:26:36 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="gfAthb4K";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/PO/JLUDMvXLlmxjYMwLdZUTkeClUMEIA1r+5rQ9SPIVOVWFz5l66vrtj2G35R48UaHp8HAlDUZSeQ32jbUtvAkYn5TJ9Q67mpU5bzJ0zrrdqz/RhHkfayTDIngvHN2q0NFNlzyUptVyg1cajAtLFvUoat6yYejA94OIWpwyBWkQmeqcMzj40Aqj478cX4VQ6BHsAh7PBNKXz0F7OliJgPodgcoG0C5N9Ofs2pAXAfICERRpOSgZ4tnjYPwHgnuUjF9hYoWrmGrBzjkMpMyuUIMjH8wACnq6+aT+mf+IAVVa2Nbo/NWdU6o3zlamMkbYB1vl2JAASeOlqOXW8pjSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iaHc42azQeHOOkMh3a+cyKOhJjhcwNXKdf+B1rUjVHw=;
 b=glUNnmBfbJfRFbl+BPt8c2JnDshUiIXHurw3JyC7c/Low68jfsJVcWma4tTAC3YtCCVX415RwoJsyzAfooqsKhe9e3AfMIQh2e2/6Hg06EWmFKcp2evZD7zNSTSMrAuOQ9phM8ytZmFlBG18sj86cxtXV0jPFHatp4g3v4YOP64iC6gNnLVE+EnK5nDY7kBUZt28O7uUtkCvpGYIVJF2tn03gIBuZD24r6kbNuib7kGaUbhlFp4a4uQXYrKoJsvHXGbfiiTnGFNRTv/SpFLSHVhAXgbqoTRGiumW2l9IXUU0nwRScSgtFjtLd5fncVLvNlqpa/IDYc8ZA9Joh1c48Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaHc42azQeHOOkMh3a+cyKOhJjhcwNXKdf+B1rUjVHw=;
 b=gfAthb4Kc50ZnKJ03V2UA6y7IC3CxrG2SVwLEVy49hv6+q3a23ULLQTMpji3b8+5PxHlS41gH1NspAJyDWWXvZEdqKOEWR2cVnzlvk6WD6r+AGmzXy/5VzwN4jUkr0hiDEALxw5meFKwiU93bOILFfl1zoMqXTvaCmisOBsARp0=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CH2PR12MB3798.namprd12.prod.outlook.com (2603:10b6:610:23::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Fri, 5 Aug
 2022 01:26:33 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c%7]) with mapi id 15.20.5504.014; Fri, 5 Aug 2022
 01:26:32 +0000
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
Thread-Index: AQHYpqSxYg+mSBtinkWEjfftWY3s8a2cSDKAgAMApwCAAD6nAA==
Date:   Fri, 5 Aug 2022 01:26:32 +0000
Message-ID: <8705d52e-2181-aebd-43b8-2c8d021339c7@synopsys.com>
References: <1659467920-9095-1-git-send-email-quic_eserrao@quicinc.com>
 <1659467920-9095-3-git-send-email-quic_eserrao@quicinc.com>
 <049219f1-8c68-e4cc-7bf9-1e8c214e80aa@synopsys.com>
 <32a0765e-00d9-1a67-bf36-4060c5fcb008@quicinc.com>
In-Reply-To: <32a0765e-00d9-1a67-bf36-4060c5fcb008@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab473ca0-3776-4e7f-28dc-08da76818793
x-ms-traffictypediagnostic: CH2PR12MB3798:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R98j71Qk6Dw8x5htS/0qKPFtJSjbElFfif5+MeU+9r8fOJjY608fOMTjAT0MWpP8jYvNOk3uK0SrHpnPWK6z9Hgw29VSGimQ0i2amo4rYL7uyo2tH/7TEgaj+uUA/9BldTFaR4q0ggO4EXkgdB5tz3zU667o+NdzJg0AfVoWkJuPnGA6fcG2NxZRENXmngsIxj/avP5xyEwBlSSqGZhmmwKWJxpXNAD8LFbM+17mp+/V8tG3Zu6xkhn9AIqDObnKU/ff7yFmw7r2lMxiGkPUqC2nNXZIUWc7167Oy8GHkgVVh8zUBQhPDZdmCDeUQ+G6hK2B6TdcPee5EOWa5Zg7IbUizh5svSa2Hcrr3pmwSzeQoMuKOiXYUN6pwK9Ri+qmclt2h0Q7rHLhcvn/nLTinLL929YMT0BXQAy8M0EMYMeEbZdSq7BmAM9D2y+lMRtdNvpwRTT44QQ83MV+aODhl3iPBQPGPNPL6cTni8qwt6z9MgJAAhTBd94LDdnQZvsLt6cO4XW3magQqM4m03Ce3RUUsZ18NnKGVjbLhNQLXs+3T5pkTuwEAQrXXsikfPodWVfVZQf+O2AeRPLQSxu6CvX96f2bV+p10VlqBpMQnH0HIie5x4iS6MO6HNeeYrxc57XhHJl1nGdxN/g/XAF3iTV5RIIQU/Sbq5vmEtj2y10EN5vMRhzI7DS3xSWtejiSUZuZXTPwLtZdgAVhAn8/mI3dmQz+ZMUn9C2JvC1JHwDdwWcqJluxGe6eFcy4RO8p3yfGQeC59+xNY2Ti256Mw23i9H1tEuIMlRChWvbeSzOCi3/b4iAEc0kxFs7Frf0RJ63ntp73VbajYo0QcwzE4W3rLqWRur8uZWtgv9J6Qoinu+6MkHTlkevaUewK7dSW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(396003)(376002)(39860400002)(346002)(8936002)(54906003)(64756008)(110136005)(66946007)(2616005)(4326008)(66476007)(71200400001)(31696002)(8676002)(66446008)(66556008)(316002)(5660300002)(38070700005)(53546011)(76116006)(86362001)(186003)(83380400001)(41300700001)(38100700002)(26005)(478600001)(31686004)(36756003)(122000001)(6512007)(2906002)(6486002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkp2RG81T0V0c3RWWjR1Vnl2emVGTmZCNGdxbldCN3BQWTh6dHlQOXhkMUFy?=
 =?utf-8?B?WUk2TjhDOFdId3VPRXpWV0Z4TDVYWEpqZjBGYS9XSWZBQlplV25KZ3JhR01N?=
 =?utf-8?B?b0hhMFVDWVpFMFhsQVBhblV3NzlvRjlIT2FWdVRFVmpQdDJaVnoyWWlIVVVY?=
 =?utf-8?B?UStKeDE4azl4MkVqRktNSVBTMGk0THF6dmhVeHVvWjFLQUFGMW9XNFlITHpU?=
 =?utf-8?B?emVNT0VpN0VnZExZbklLeDNaSXdkWmxCU0s3U3J1ay83aXVFSEVEUzZSbTV0?=
 =?utf-8?B?TWVCU1lDLy9hbHdGeXBIcnYxVVA0Rjhja3NrVXhxWWFwN1RFbndKdmpLb2VK?=
 =?utf-8?B?NFRqUzRSSDNDMUQvRThhSE9HYk10aW1VYitROXFHbjZLWEVoZitWaCtqSjdi?=
 =?utf-8?B?Z0E4QmkrSWd0RXQ3ZlhweGpnRWl5SVFoT0MxbGFGWGRlRHNLRWpPOTJrdHg1?=
 =?utf-8?B?MzJnN3VyMkROOFkwU3FZUGdBb1MzanVzN0RNcFB3NTQva08waEJZc2U3K1ZB?=
 =?utf-8?B?Mi9PQ1VjY1pkN3pnSlVXWGpSVmVVdDV3Y1NyczlibjVLRG8vRjFscWxvM2lD?=
 =?utf-8?B?OXNWMGFzWXNWbHRiVGF5dTNsY1I0OXgxUXdoZWpSczY3QlFUNW9ZQXkreDJp?=
 =?utf-8?B?SWFJTXljdUc3VU1ZeEpjV2Z3Z0FzUWx1MHlTTjNIdW5zTlNpb096TGhEMlNV?=
 =?utf-8?B?eHFwRFRtR0F2YVA5aFp4c0l6ZklCamtqS1llSnZTd0NUNXpoM3hzS29EU1o2?=
 =?utf-8?B?TmliM25iOVNJUGN2eTI5L0ppSm1TVW9MbFNCZVYwSVBBU3MwSHhhS2IvdjAz?=
 =?utf-8?B?MEpiU1VucnZlVXhFaGx1cjV0ci9TQUl5VVlvTGNNby9TWkJ5ZXlDczdDMFJV?=
 =?utf-8?B?eFNjSmppVFQxWVQybGhnU2tDUmloVWtiSkphMHY2Qm1MRzdCRUlNeXZ0eGxV?=
 =?utf-8?B?bVFUVDRxR0FieFVSMkNjS3pObnhLangwMjN3VWJlQnQvYTFZNHo0TXgvTkJB?=
 =?utf-8?B?b0Z5US9lTTVJTyt1WXpXQU85QyswZ0NhbnVOOG9CYnRPaTBFRTc4UXlWWURD?=
 =?utf-8?B?WE9EaXVxYm1KaG9FZ3F2SkNrbzNtK3Z1NzhtVGFLUlZidXowNHRYK2xGQ3ds?=
 =?utf-8?B?VHNwbzB4aVZYYzBBcjNBTkZPREw4a1kxNGZlaTJoc2dHcmdRQmZTek5paGd2?=
 =?utf-8?B?cDdGNERlM0t3cis1Tzc5ZC9CYzJhZHdVdkZMOU9ENzFUQ0pCWmdDanhHTFlv?=
 =?utf-8?B?bndRc0traHhYTkJaWkxHWDBGVHMveUo0WjlyR1JEWGVnd1FXTUUweFJZSW5s?=
 =?utf-8?B?UHNCTWNNSk84bDQ3ejBDK1dPTi9hVGlPcTNFcXJVVFZNNVlHaUd2cU9Mcm1T?=
 =?utf-8?B?ODc4V0lKWHhwaHU4TGpUcFY3Z2lpMjRLbXRFZjhPMEJHcWVKUTJ6RVV5RU9Z?=
 =?utf-8?B?ZmlMS2FmaWR2NFEzUStKRDNoUmZ6U3kxM0hiakNibVl6R1k2OGRVWFUvUE9Q?=
 =?utf-8?B?Z1g2SWxqbFZtVER2dHFrVFN3aW5EU3FrbkxoM1J4M3o0a3dQbkxCYjltWHNN?=
 =?utf-8?B?QmlUWDhZck1reTZMMUNzSGJtVzhSRWxCUE5KZ2FDQVVkRnJ2aDNtVGhuTXh0?=
 =?utf-8?B?VWhrQlRNdVpYR2ZFQ0U1R0QrR0dDMU1TYnpkUWpmZks3clBySEU5TVpkdjVZ?=
 =?utf-8?B?MERWWXF6L2UwaEVSb3JZUkpnc1lvdjVrQW90REh3NXJpcTh1Sm93MWlEeDZP?=
 =?utf-8?B?bms4SGRzbEZVazg3VFMyREpiTXM3V2lXVFk4cDU2aWlDWkR4VXBtbWdSUzJ2?=
 =?utf-8?B?TERRN2s4NkxzVGVLQmRRQW9Gb29Ic0xLdFplL01TbSswa0xHQTd5V1p3cjFQ?=
 =?utf-8?B?S2M5ckN3TXN3N0JBdmZad0tKV1Y5MUFORjNjK2pIWWRUUVVtZTMwcGpjRStV?=
 =?utf-8?B?VGR4aU1KMm5Pd1VKOFdjQmo2Zk1GejFuOTRxdmltMTdmV3Z5dXZCUVYxa1BO?=
 =?utf-8?B?cVEwM3VIbERRN2N5UmtEc3JUN1dYNVFFSGs4M0J4U2FYWkVHMkF2N21NTG5i?=
 =?utf-8?B?RUlJYkgrNVd0NURMQWRkdTFSQU5DQkM4UllwTGhWS2gySnA0VTBmZmxweFdm?=
 =?utf-8?Q?Uo9IU6lfKs8/nizIpFO5V1BmX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DA7B51111B8BD48A8442E3EFD68E945@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab473ca0-3776-4e7f-28dc-08da76818793
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2022 01:26:32.3304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yWF8Qgsyrs6Eol913H5St4w2zzoj3fupiL+sIR4Y/qIQm9LZlZwHTCtfJ4nBsPwkjGZtBHUXYA2Ck3Y4BeHxLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3798
X-Proofpoint-GUID: 909DDyDDBPY8w1mGUZgrD1LQz6PJdx7u
X-Proofpoint-ORIG-GUID: 909DDyDDBPY8w1mGUZgrD1LQz6PJdx7u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-04_06,2022-08-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=587 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2208050006
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC80LzIwMjIsIEVsc29uIFNlcnJhbyB3cm90ZToNCj4NCj4NCj4gT24gOC8yLzIwMjIgNDo1
MSBQTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPj4gT24gOC8yLzIwMjIsIEVsc29uIFJveSBTZXJy
YW8gd3JvdGU6DQo+Pj4gQW4gaW50ZXJmYWNlIHdoaWNoIGlzIGluIGZ1bmN0aW9uIHN1c3BlbmQg
c3RhdGUgaGFzIHRvIHNlbmQgYSBmdW5jdGlvbg0KPj4+IHdha2V1cCBub3RpZmljYXRpb24gdG8g
dGhlIGhvc3QgaW4gY2FzZSBpdCBuZWVkcyB0byBpbml0YXRlIGFueSBkYXRhDQo+Pj4gdHJhbnNm
ZXIuIE9uZSBub3RhYmxlIGRpZmZlcmVuY2UgYmV0d2VlbiB0aGlzIGFuZCB0aGUgZXhpc3Rpbmcg
cmVtb3RlDQo+Pj4gd2FrZXVwIG1lY2hhbmlzbSBpcyB0aGF0IHRoaXMgY2FuIGJlIGNhbGxlZCBw
ZXItaW50ZXJmYWNlLCBhbmQgYSBVREMNCj4+PiB3b3VsZCBuZWVkIHRvIGtub3cgdGhlIHBhcnRp
Y3VsYXIgaW50ZXJmYWNlIG51bWJlciB0byBjb252ZXkgaW4gaXRzDQo+Pj4gRGV2aWNlIE5vdGlm
aWNhdGlvbiB0cmFuc2FjdGlvbiBwYWNrZXQuwqAgSGVuY2UsIHdlIG5lZWQgdG8gaW50cm9kdWNl
DQo+Pj4gYSBuZXcgY2FsbGJhY2sgaW4gdGhlIGdhZGdldF9vcHMgc3RydWN0dXJlIHRoYXQgVURD
IGRldmljZSBkcml2ZXJzDQo+Pj4gY2FuIGltcGxlbWVudC7CoCBTaW1pbGFybHkgYWRkIGEgY29u
dmVuaWVuY2UgZnVuY3Rpb24gaW4gdGhlIGNvbXBvc2l0ZQ0KPj4+IGRyaXZlciB3aGljaCBmdW5j
dGlvbiBkcml2ZXJzIGNhbiBjYWxsLiBBZGQgc3VwcG9ydCB0byBoYW5kbGUgc3VjaA0KPj4+IHJl
cXVlc3RzIGluIHRoZSBjb21wb3NpdGUgbGF5ZXIgYW5kIGludm9rZSB0aGUgZ2FkZ2V0IG9wLg0K
Pj4NCj4+IFNlbmRpbmcgdGhlIGZ1bmN0aW9uIHdha2Ugbm90aWZpY2F0aW9uIHNob3VsZCBiZSBk
b25lIGluIHRoZSBjb250cm9sbGVyDQo+PiBkcml2ZXIuIFRoZSBjb250cm9sbGVyIGRyaXZlciBr
bm93cyB3aGVuIGlzIHRoZSBwcm9wZXIgbGluayBzdGF0ZQ0KPj4gKFUwL09OKSB0aGUgZGV2aWNl
IGlzIGluIGFuZCB3b3VsZCBub3RpZnkgdGhlIGhvc3QgdGhlbi4NCj4+DQo+PiBXaGF0IHdlIG5l
ZWQgdG8gYWRkIGluIHRoZSB1c2JfZ2FkZ2V0IGlzIHdoZXRoZXIgdGhlIGRldmljZSBpcyByZW1v
dGUNCj4+IHdha2V1cCBjYXBhYmxlLiBTb21ldGhpbmcgbGlrZSBhIGZsYWcgdXNiX2dhZGdldC0+
cndfY2FwYWJsZS4NCj4+DQo+PiBXZSB3b3VsZCBhbHNvIG5lZWQgc29tZSBmdW5jdGlvbnMgbGlr
ZSB1c2JfZ2FkZ2V0X2VuYWJsZV9yZW1vdGVfd2FrZXVwKCkNCj4+IGFuZCB1c2JfZ2FkZ2V0X2Rp
c2FibGVfcmVtb3RlX3dha2V1cCgpIGZvciB0aGUgZ2FkZ2V0IGRyaXZlciB0byBub3RpZnkNCj4+
IHRoZSBjb250cm9sbGVyIGRyaXZlciB3aGVuIGl0IGNoZWNrcyBhZ2FpbnN0IFVTQl9DT05GSUdf
QVRUX1dBS0VVUCBpbg0KPj4gdGhlIGJtQXR0cmlidXRlcyBjb25maWd1cmF0aW9uLg0KPj4NCj4+
IEJSLA0KPj4gVGhpbmgNCj4NCj4NCj4gSWYgd2UgaGFuZGxlIHRoaXMgaW4gY29udHJvbGxlciBk
cml2ZXIsIHRoZW4gaXQgd291bGQgZmFpbCB0byBnZXQgdGhlIA0KPiByaWdodCBpbnRlcmZhY2Ug
aWQgd2hlbiBtdWx0aXBsZSBmdW5jdGlvbnMgaGF2ZSB0byBzZW5kIGZ1bmN0aW9uIHdha2UgDQo+
IG5vdGlmaWNhdGlvbi4gQXMgcGVyIFVTQjMuMCBzcGVjIChiZWxvdyBzbmlwcGV0cykgYSBmdW5j
dGlvbiBjYW4gYmUgDQo+IGluZGVwZW5kZW50bHkgcGxhY2VkIGludG8gZnVuY3Rpb24gc3VzcGVu
ZCBzdGF0ZSB3aXRoaW4gYSBjb21wb3NpdGUgDQo+IGRldmljZSBhbmQgZWFjaCBmdW5jdGlvbiBp
biBmdW5jdGlvbiBzdXNwZW5kIHN0YXRlIGhhcyB0byBzZW5kIGEgDQo+IGZ1bmN0aW9uIHdha2Ug
bm90aWZpY2F0aW9uIHRvIGV4aXQuDQo+DQo+IFVTQiAzLjAgU3BlYyBTZWN0aW9uIDkuMi41LjMN
Cj4gIkEgZnVuY3Rpb24gbWF5IGJlIHBsYWNlZCBpbnRvIEZ1bmN0aW9uIFN1c3BlbmQgaW5kZXBl
bmRlbnRseSBvZiBvdGhlciANCj4gZnVuY3Rpb25zIHdpdGhpbiBhIGNvbXBvc2l0ZSBkZXZpY2Ui
DQo+DQo+IFVTQiAzLjAgU3BlYyBTZWN0aW9uIDkuMi41LjQNCj4gIkEgZnVuY3Rpb24gbWF5IHNp
Z25hbCB0aGF0IGl0IHdhbnRzIHRvIGV4aXQgZnJvbSBGdW5jdGlvbiBTdXNwZW5kIGJ5IA0KPiBz
ZW5kaW5nIGEgRnVuY3Rpb24gV2FrZSBOb3RpZmljYXRpb24gdG8gdGhlIGhvc3QgaWYgaXQgaXMg
ZW5hYmxlZCBmb3IgDQo+IGZ1bmN0aW9uIHJlbW90ZSB3YWtldXAuIFRoaXMgYXBwbGllcyB0byBz
aW5nbGUgZnVuY3Rpb24gZGV2aWNlcyBhcyANCj4gd2VsbCBhcyBtdWx0aXBsZSBmdW5jdGlvbiAo
IGkuZS4sIGNvbXBvc2l0ZSkgZGV2aWNlcy4gSWYgdGhlIGxpbmsgaXMgaW4NCj4gYSBub24tVTAg
c3RhdGUsIHRoZW4gdGhlIGRldmljZSBtdXN0IHRyYW5zaXRpb24gdGhlIGxpbmsgdG8gVTAgcHJp
b3IgDQo+IHRvIHNlbmRpbmcgdGhlIHJlbW90ZSB3YWtlIG1lc3NhZ2UuIElmIGEgcmVtb3RlIHdh
a2UgZXZlbnQgb2NjdXJzIGluIA0KPiBtdWx0aXBsZSBmdW5jdGlvbnMsIGVhY2ggZnVuY3Rpb24g
c2hhbGwgc2VuZCBhIEZ1bmN0aW9uIFdha2UgDQo+IE5vdGlmaWNhdGlvbiINCj4NCg0KT2ssIHNv
IHRoZSBpc3N1ZSBoZXJlIGlzIGFkZGluZyB0aGUgYWJpbGl0eSB0byBwYXNzIHRoZSBpbnRlcmZh
Y2UgbnVtYmVyIA0KdG8gdGhlIGNvbnRyb2xsZXIgZHJpdmVyIHdoZW4gc2VuZGluZyB0aGUgZGV2
aWNlIG5vdGlmaWNhdGlvbiBmdW5jdGlvbiANCndha2V1cCByaWdodD8gU291bmRzIGxpa2UgdGhl
IGNhbGxiYWNrIHNob3VsZCBiZSANCnNlbmRfd2FrZXVwX25vdGlmaWNhdGlvbihnYWRnZXQsIGZ1
bmNfaWQpIGluc3RlYWQuDQoNCkFzIGZvciByZW1vdGUgd2FrZXVwLCB0aGUgc3BlYyBzdGF0ZXMg
dGhhdCAiSWYgcmVtb3RlIHdha2UgZXZlbnQgb2NjdXJzIA0KaW4gbXVsdGlwbGUgZnVuY3Rpb25z
LCBlYWNoIGZ1bmN0aW9uIHNoYWxsIHNlbmQgYSBGdW5jdGlvbiBXYWtlIA0KTm90aWZpY2F0aW9u
LiINCg0KVGhlIFNFVF9GRUFUVVJFKEZVTkNUSU9OX1NVU1BFTkQpIGRvZXMgbm90IG5lY2Vzc2Fy
aWx5IG1lYW4gdGhlIGhvc3QgDQp3aWxsIHB1dCB0aGUgZGV2aWNlIGluIFN1c3BlbmQgU3RhdGUg
Zm9yIGEgcmVtb3RlIHdha2UgZXZlbnQgdG8gb2NjdXIuIA0KSXQgb25seSBwbGFjZXMgdGhlIGZ1
bmN0aW9uIGluIEZ1bmN0aW9uIFN1c3BlbmQuIEhvd2V2ZXIgb2Z0ZW4gdGhlIGhvc3QgDQp3aWxs
IHB1dCB0aGUgZGV2aWNlIGluIHN1c3BlbmQgYWZ0ZXIgdGhpcy4gVGhlIGR3YzMgZHJpdmVyIGNh
biB0cmFjayBpZiANCnRoZSBob3N0IHB1dHMgdGhlIGRldmljZSBpbiBzdXNwZW5kIHN0YXRlIGFu
ZCB3aGF0IGludGVyZmFjZXMgYXJlIGFybWVkIA0KZm9yIHJlbW90ZSB3YWtldXAuIElmIGEgcmVt
b3RlIHdha2V1cCBldmVudCBvY2N1cnMsIHRoZSBkd2MzIGRyaXZlciBjYW4gDQpzZW5kIEZ1bmN0
aW9uIFdha2UgTm90aWZpY2F0aW9uIGZvciBlYWNoIGZ1bmN0aW9uIGFybWVkIHdpdGggcmVtb3Rl
IHdha2V1cC4NCg0KUGxlYXNlIGNvcnJlY3QgbWUgaWYgSSdtIHdyb25nLg0KDQpBbHNvLCBtYWtl
IHN1cmUgdGhhdCBkZXZpY2UgcmVtb3RlIHdha2V1cCB3aWxsIHN0aWxsIHdvcmsgZm9yIGhpZ2hz
cGVlZCANCihub3QgZnVuY3Rpb24gcmVtb3RlIHdha2V1cCkuIEkgc2VlIHRoaXMgY2hlY2sgd2hp
Y2ggZG9lc24ndCBsb29rIHJpZ2h0IA0KaW4gb25lIG9mIHlvdXIgcGF0Y2hlczoNCisgwqDCoCBp
ZiAoZy0+c3BlZWQgPCBVU0JfU1BFRURfU1VQRVIgJiYgIWR3Yy0+aXNfcmVtb3RlX3dha2V1cF9l
bmFibGVkKQ0KK8KgwqDCoCDCoMKgwqAgZGV2X2Vycihkd2MtPmRldiwgIiVzOnJlbW90ZSB3YWtl
dXAgbm90IHN1cHBvcnRlZFxuIiwgX19mdW5jX18pOw0KK8KgwqDCoCDCoMKgwqAgcmV0ID3CoCAt
RVBFUk07DQorwqDCoMKgIMKgwqDCoCBnb3RvIG91dDsNCivCoMKgwqAgfQ0KDQpUaGFua3MsDQpU
aGluaA0KDQo=
