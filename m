Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DD6596652
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 02:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237974AbiHQAeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 20:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237719AbiHQAef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 20:34:35 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A676DAC6;
        Tue, 16 Aug 2022 17:34:33 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27GINVq1003417;
        Tue, 16 Aug 2022 17:34:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=M24ONAhEda4RSWsaodIofSo8iH/FKEUeNdIzfeVnD64=;
 b=YMfCW/+e45BkNDdzlizOEKzB7Rr302wPRDkT25iURRYYoHM/1AbBYtfp8ox7+gADleLR
 kP+rH1zmTtkyi8PJG1qRP03S8hZZ6CzaQ0TTNO+qZRJZCUcHjJuwwBYAfOtxu2k+Wt6d
 K+ObQI0S2EenAX9Px+AuU4L6l6yQRpeCKcLCZv2BBCi29c0lXvzTe13KMHSHMKcxb5FP
 NctHRT7HYClROw6+pFZgr3nJ4it7lykfK5y3OoVr6dIzrFyboN1w0Fz9O8UfWfdvrbbu
 ZREbAaAPIDB+YewEAFdTsnSHU14Iv+3uL1E1GqXI/IqAKIFzxVKEvHAMI0S0Bb7EwKZj zA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3hxakeyp69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 17:34:26 -0700
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A2491400A0;
        Wed, 17 Aug 2022 00:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1660696465; bh=M24ONAhEda4RSWsaodIofSo8iH/FKEUeNdIzfeVnD64=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Rb78KtZdgADF8aHQxFndfK6D/7sG06khLlcL80pay7f6TTvU6GFGGd8sKYGJNc1E9
         oOfJ3pzHD7JRKi++WbrZL8wb+PWcxG9uzvmKfIMDiVT3l3fxdAlMGZyzKavMrvpRd5
         YXGb6d4HTvmKe75mZrlMWIj3uhqehLHVGPB06gggSKNaq6skblooHvJbJ/v47UVgbw
         IXr40VJiLLPE1eX1WjKv3DLfFsAc2fD5tXPVj18fxXrDB/PZelOAKJ8sMatxV+FDZa
         4968k5juTeanp4fA3w28AzpaszpeLHvjkltnZ/vrysp/iA1AxF3DkjXewt+o/2WEbp
         whmdG/t8Q6Z1Q==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id B9790A0630;
        Wed, 17 Aug 2022 00:34:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0CE3C80199;
        Wed, 17 Aug 2022 00:34:23 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="LP7HbNIX";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/SdBHd8f7LG3LfliNPZ9q1jqIAc2/YXGTwQ7B4mJwfgToCNz2pAMURUqJH8g67T65Np66siCGd/nsi6L/PqbFG3kaK4g07YkJrOA+RX4vxiJ64NOMDuiqpsaOZ7+m9sPpUSuxQhcMAyZkRkPrGtnkjeAd4Y9x3yN5O2jOGqexUmxvRkBS0s9NnEKc3dcNy23QAJ0jyiYdB8sFgettNYt0htWfpzFKW0ISIDo8M2QLXr6T+VWMlgXr36QRK3BoXRkHK2ChhAx1djh1zPgOdinINXxyzYXuPFi7oiCGSkOM3l0lTSkLBghiFNcq8O25ugkG6S5OOe3Wci6n+UftpYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M24ONAhEda4RSWsaodIofSo8iH/FKEUeNdIzfeVnD64=;
 b=A90+VCUEpTG/rWTBMV06hz3NGEkZHjf/NlBTWaexivY5YFv6rmGaSPbpMP+CgH6/nKZ18smCuBm7gGqV2v1UVQzoC2PyQ/t5vG0A7C6p7xvTen7mNSR0Y/F4xbjffd9bH9/rQUhgvsU9YPLkTDs8UuAW5FTyTsQcgsZucHrm4o/j0kpFodmjJDoUydueEXZREIWTr4Y7qIv94N6H+ZRiCHIy9AJnjLiQ+QRF2PvI3NwutnQZL5emkcOQpGPgSllM6I5O84L02GNNj1A0dygvnvMAqYByd8FcpNQR+cyDvhBX/r3fxF3yTjD4e9dJ3YY4fF1waDSuvgCgrFNLubiNkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M24ONAhEda4RSWsaodIofSo8iH/FKEUeNdIzfeVnD64=;
 b=LP7HbNIX6PepapzOpeyjikGgWOtRB3RpEGdIfiSptVok8SGSqhNNyStyxT2LIrX6ISFiptzWZFNFAwywDm3QUoWrPIYJ+t6M7qiybXL7XTpX4DNs7llWEhNx357YTW484D9J3hARTokV07GNKHE/N1FCpxSqab0OvgISz7FjKBU=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Wed, 17 Aug
 2022 00:34:20 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c%7]) with mapi id 15.20.5525.011; Wed, 17 Aug 2022
 00:34:20 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH v3 6/8] usb: dwc3: Increase DWC3 controller halt timeout
Thread-Topic: [PATCH v3 6/8] usb: dwc3: Increase DWC3 controller halt timeout
Thread-Index: AQHYsO512+NttdcXskOx1IAy/v7etq2yQE+A
Date:   Wed, 17 Aug 2022 00:34:20 +0000
Message-ID: <a6db7080-0c2f-a0fc-fd89-b919d12a8253@synopsys.com>
References: <20220815213134.23783-1-quic_wcheng@quicinc.com>
 <20220815213134.23783-7-quic_wcheng@quicinc.com>
In-Reply-To: <20220815213134.23783-7-quic_wcheng@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46d3e5ea-086b-4bc3-cced-08da7fe8399e
x-ms-traffictypediagnostic: DM6PR12MB5549:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5mvNKQAAa7aMs1geUwrAt/YkcDxfT4QQi3k3UxfX52QBrxkFJCfeiHwme6kCeaTPbz3QRBSnINqjwIH2lNn1NzZ4Al9mLEleEC5Zl985lXWWEyXtVXCFd/hYDTcp60OQnhp+3IznYZDNpgNNOs0H3XZ6Q2uZWPiXyK6pe2mTqIg0eG/3uuofc0pQARlNXVnR8kEHrvn80bn8CH/CHE5Ke/1phx9ivYOxY8E7EpAUzscsN+sFX2YEIORzS2xACxCOME4CgczsdH/H25viv7a+/U7f5DWIYdFyse5aXXS9g0bxEvzDoRQofSc+TXE8aoNuvbv+T0TEfyMpCiT1kPkdTqjcsQ6Vyb6beF7qO94GP1DrVA8SmWXRMXC7EQiUhU/OVMWT1ZcbYNgAjaIIQJw8Rk0dmEUrJwY8sXNYTLJy9Sogfr5Iae3h6zaqZqHBik/0MuW6GXe5TFwbVQYqsQbKX+DegHnIXo4SCRexZQocqPDeJtK27m40JHAfy9bAKlkvtZa38Cpjrjn04E4YaPQkHYsEKdssXJ7hCqrIpHCiXyiJgqATWib8QjNVmlwV8P6bh9TNEpFAkKlINOHklIGEC1/kpvf42wFqe9aWK4yutV6fcDcxNRrEuja4V0ErorDSQge+6BJPsvGNRgj5O2xwEMyLrV/aI1Rx8fm8apM094KCZKisAiNV9jL8kfDWNjkS6RRS7JWbU7GtPlRk6Wxn1lTBkgYgAAYg+XVHyQspc94leBpqpDh5s0c8UerPW8RFJZ1ANmilxOACawERD3Zss0qQSsNICwh+cF+rwfVzFDQou/Qxx3xvWWwv5X+mWILENTbLHCY5Lw8K/DHLSgWOGPtn3ZtlI/2hJ2doG3HA4C24F13R/lZ5ULCcjHQUyOhk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(39860400002)(376002)(346002)(366004)(66946007)(316002)(31696002)(66556008)(8676002)(64756008)(83380400001)(41300700001)(66446008)(76116006)(4326008)(2906002)(110136005)(36756003)(186003)(54906003)(31686004)(2616005)(107886003)(38100700002)(122000001)(26005)(6506007)(6512007)(66476007)(6486002)(71200400001)(38070700005)(86362001)(8936002)(478600001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckhUamZ0QzNCbEd4RjhOR2xSNmY2ak5uOWVnM29ka2VpSlhienovMlgraUo5?=
 =?utf-8?B?MVNtWFlzYnZVU0ZVb0t3TkpJRXR4cUx6azlXVllUb1JmZjk4SjNickIzdVJD?=
 =?utf-8?B?QzNaNEs3YU15TmJHa1Bxa2w3alpkSG0rc1pWZDY3UWlKM0FBVGhTK3JoODV3?=
 =?utf-8?B?R2U0VGNRazFLaE51LythVE8xSWNFMHQrazQxVGtOa3NsN3QveWFpa1E5WDZY?=
 =?utf-8?B?TGRMMFlDaG1CWW9FaTVkNTZ2TjkwZUJrek9wSzNzZk92UENQM2Y2N1Z3WVRJ?=
 =?utf-8?B?UGFlOFJ2c0hUVm9KNzBpT2tOeWtRY2VjU3lXMWorK0RNZFo5ZWVVeHdBUnpI?=
 =?utf-8?B?UjFiVVBVN2gwTTJJRXVTLzhXSjBjZG5IT1VDNlljUzdWYmVNVlBuQ3R3L0ZM?=
 =?utf-8?B?NDNqbElyTU9NSDd4eFhqVmptZXcxOTFlZ0Voblg1d0JSWDM3blhhd0ZUMkFG?=
 =?utf-8?B?UkdqUk1wU3JQaDBJR1YzRTB0bVg0Z3BON0lyY2dFMGNGS3R1dXhtaDQ2MlVI?=
 =?utf-8?B?RUVPUjQ1cnZDbEtRd2c4ZTRlMjR0UWVoc2NNTlNHMU5tQ0xwZG5jVkVvUktR?=
 =?utf-8?B?N2ZFVlQ4Z3NaVUNwYkZBVGFyUWM0RWxENjFuMXR3cGNITllXdGRNNEJoK1JS?=
 =?utf-8?B?UXc2MEhrV0U1M1R2dnNuNFRweDhqTjRZOVVSM1NkMHo3V011Vm85ZVNHZXJq?=
 =?utf-8?B?V29lOW1USGpmZXo3VncrZXltT3hKNUpBWC9PeklNekJ5STAzL2hNYzBrN3pQ?=
 =?utf-8?B?SGkyN3B6T21mYnU4bVhzNkJ5SVJUQXNWTjdxTUFaeFlLKzZhNVc3SU01SjA4?=
 =?utf-8?B?bkZUNnN3Zk12a3UvWTBKMDF0MUtjeHp4aHpheTRqd0tGaDlBNGpVbzFScnZN?=
 =?utf-8?B?UndlZkVYZU8wTlFtaVRtRkFFRlBZQlRGc3RvSGZEM0lKZTZRdExlWGhROE9o?=
 =?utf-8?B?RHIrSUwvTDdqRHFaaFl2cElJWG9JdkhjUnJ5WHpsZ0s1ZHJiZGhWd0tpbFF0?=
 =?utf-8?B?YmlXOFJxRWlQcXNuOHEvby9PanR6Y0t0SUFzL1gvZVpIYmhKOXhrTEV4N2hU?=
 =?utf-8?B?bW56L2RRNWRHK0V3NFJ1T1UydllNVlVYVjNIdENUZDZMbFM0U0NhRmhTSmEw?=
 =?utf-8?B?OHZNUXlsd0U1VlF1OVYrSzBlQ1BtZDBlM240NEpDeWFJTkk3b0Q2aURCUVZ2?=
 =?utf-8?B?TVZnVlBuVEYvM3Q5Q0NEUm1BTnNsOW5PUVpwSmRwSlorcmZpbjVoRUNsbHZ2?=
 =?utf-8?B?V3ZtOFAxYXVmV0VsekNmYU92OTZRdlprVmZQTnBBY3I4NnJ5aGpvUmNkV2du?=
 =?utf-8?B?SDREV2RmYS9qSW9NVUIxVER4RmoraXNhWUhjT0RQd0NuczNwYXVlcTgzT2V4?=
 =?utf-8?B?YU5LZlE4VWozKzViMlN6aVU4akJTOVZtMlhBZitsNGhhMTBlQlI5Z3lZcjhB?=
 =?utf-8?B?OUpPUGtqMkZVYUNtUWRmZmdPL2gzUjlKeTdrVmZ6Rk5PWDMvK1RFZXVSVVZW?=
 =?utf-8?B?TnFUelpid1RWcDBIeWVEMzFNZktEZUMvNkFOZW9DbjlBYkVPTFV3OXFObnBB?=
 =?utf-8?B?eTcwakhqL0lTaCtVNk9scHAxVVBMK2NBdUMzODVneTB3dEtER2czcGRXTEYz?=
 =?utf-8?B?YlVnUmdkN2xaLzV4MFhsazl0Z0xpcDJBMlROR0pEc2pIZ3VqQ3AzR2lNeTBh?=
 =?utf-8?B?enBvMWdLdnBkNkdHZkM0T0VqWjltQVMzcWs3b0ZQS3QraXoxcFFzRE1WUkth?=
 =?utf-8?B?Q01iSVdFMmtCaVl6Uy8wNUQ3Z1FuZFk4YTcreEFXUW9NYWlzYUc0ZUliQ2xH?=
 =?utf-8?B?Z0RDN2R2djdVcUxMN2VHSFgvU2d5MS92QWNPdW8ybUJYako4MUluSmh6VG1h?=
 =?utf-8?B?L0lwaEx4WlIrRjg1YzlUYitpME1QT2hvbEtERnVObEVpTGlOMWc3aGRFNElv?=
 =?utf-8?B?UWwrYmlva1ZXdmRSd2NaMGxXMFRnam9xc3paOWI0Vm1YQ3ljWkQ5MTVDeEUr?=
 =?utf-8?B?ZXBFcCtwKzJ2ZzdOT2hEeDRKT3YvRUY4VzJwL0VtbGhuSERxdTVvTjV2R0VE?=
 =?utf-8?B?ZzRVTjE5akNCYVhFSGRGTExBVFBVaTlHQzZueTRscHZkalFSbThqVmxPdVZT?=
 =?utf-8?Q?lJOQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DF9FB9F7636364C98136468F4E9BDC9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?R0M1NHdkbElPU3RYS2k3Smp1aTZVQkx2bkpHUm1aZkVZMjFORS8vRGprUk9J?=
 =?utf-8?B?UXpsckJGU0ZJZTloN0xzTjVUb3NmUG9NaHRvWUhVRVNXbmRPQS9GeldyOXE2?=
 =?utf-8?B?NXU3aVVEWVowTkFhVm1rRkt2bU85Rjg4VXNEdjJlRHhZeGJ0czVETFdiSEZv?=
 =?utf-8?B?UmFTZjJGRmt0Mjk3Qmo1eWdTaThua3hnOE92QlVsZkxjNVFuN1ZEWm8ra0Ix?=
 =?utf-8?B?bGtFaWZnS0xCdnYzdDBIUTVuaTVWWnFhOGM0aW5uUTJ6TG5qdHJGUk9iVFlP?=
 =?utf-8?B?SlU4SjFhSlNTSVRHb01hb0JVcDVnL3ByMzlzTCtyTGYyMTd5SlU5dTQvTkNR?=
 =?utf-8?B?VU5XS2h3V3dqQVp2YnNnV0xwUVFuRzVNNlhiemU1a2Z2Z05HOTgwS1hUYyty?=
 =?utf-8?B?dzRRWjZUa3RkRVdFSVRXOWwwcFBEOU9qbUhGSVVQcFV2UTMzZlRCN1kwVkdK?=
 =?utf-8?B?ditMbFR6NkRXNE9ua1ZnT3lFNGVSQThqakR6bURYQ21HS3FBdk02dVZtUlFq?=
 =?utf-8?B?RlB1Qmlrbk1KYlFBcXEvRnRtbG9JcE01Y2FTS2tUTlpneHF5WEpnMStoYUNF?=
 =?utf-8?B?dFFRdFJLcVdTSGJxSmVUMU5STkhYT0NIVmE3RnRjTjVrQ1Q2TWliZmJ3dnha?=
 =?utf-8?B?Sm4zcy92N2M2c2Q0TXdKZllUaW9PaTJTMUNzeGVUV1FlMUh1RU5ERS9hR3Bi?=
 =?utf-8?B?aWdNTUpPc2VkY296R0Jzclp4SUsxRmxnRkhURmM3cXdYVnVlVlk1WElxdUhV?=
 =?utf-8?B?UTYvR0QzNExtMk51SURHN2Z1MW9wL1BkaXNrUEZtcTBtN1ZiMkcyTWQyVk9X?=
 =?utf-8?B?L05LKytmNXQyNkNGQXNiY3Q2STVwYjhsYy81WHB0elpiNHRXaUt5Q2FTQ2dB?=
 =?utf-8?B?dHV6M0ozODZMeTl3RDYrZ1VWbmlqWC9abmRSbGVpM0ZvMmgzMEd1a0lsRUFM?=
 =?utf-8?B?QVp2eDYxMGhUWW5DdDlZNzA5RjVYdWZCL1Vod0c4bGhFNGhZVkMwOHA2MEdZ?=
 =?utf-8?B?c3N6dXBQN2xvZlNpZUYrekdmZDAyQWU0VkVWREVSa2RlZDdCRzhrd0JQanho?=
 =?utf-8?B?dC96REJEK3VsY2Zsd1M1QUFLVW5tUTk0N09xdWMwT0NqN2g3UlNiUEpxZnAw?=
 =?utf-8?B?T3VydTFidWNBeGdUOTViUmN3eWFnWUd3K3BLbGZ3U3pCd1BYeXZXTytrMnpD?=
 =?utf-8?B?TXZ6Q1ZkVzh3b2NKQjJmOWVpWDBwQ2ZnME5qcXYwdFUrMEt2eVAxNUxLOGxu?=
 =?utf-8?B?RnBZNXpKN0VOT0hkYTFYTzY0MGZ4cThYZWljZEpBNjRlcmFrelhnRkZCaHYy?=
 =?utf-8?B?TmxXOXhOcXdGZHVOdHNvRzN4RC92bnREZ2xhQWExMUtGWFdRMndmeXovamd0?=
 =?utf-8?B?dGt5NjNaRTE1YU03cmlYOXYwTm9JT1piZXRqYTdqYmxxTjNDakZKYWxkU2RF?=
 =?utf-8?B?QUFjSEl1Yk5HNGdRS3lwc3p3N3J1UVVKUERzVk13PT0=?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d3e5ea-086b-4bc3-cced-08da7fe8399e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2022 00:34:20.1726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +5mS8qPyRHextVl7Ik7Zn/MmSA2hbH0CqQKuwBatdMx1MuhZdeXdONtI4CnfCso/5+MuGbBwI1Zs85lb/KlH4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5549
X-Proofpoint-GUID: A8KyWEDLfmi_CYi9sLjKMCIzKLANcG-P
X-Proofpoint-ORIG-GUID: A8KyWEDLfmi_CYi9sLjKMCIzKLANcG-P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_08,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 mlxlogscore=934
 impostorscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208170000
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8xNS8yMDIyLCBXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+IFNpbmNlIEVQMCB0cmFuc2FjdGlv
bnMgbmVlZCB0byBiZSBjb21wbGV0ZWQgYmVmb3JlIHRoZSBjb250cm9sbGVyIGhhbHQNCj4gc2Vx
dWVuY2UgaXMgZmluaXNoZWQsIHRoaXMgbWF5IHRha2Ugc29tZSB0aW1lIGRlcGVuZGluZyBvbiB0
aGUgaG9zdCBhbmQgdGhlDQo+IGVuYWJsZWQgZnVuY3Rpb25zLiAgSW5jcmVhc2UgdGhlIGNvbnRy
b2xsZXIgaGFsdCB0aW1lb3V0LCBzbyB0aGF0IHdlIGdpdmUNCj4gdGhlIGNvbnRyb2xsZXIgc3Vm
ZmljaWVudCB0aW1lIHRvIGhhbmRsZSBFUDAgdHJhbnNmZXJzLiAgUmVtb3ZlIHRoZSBuZWVkDQo+
IGZvciBtYWtpbmcgZHdjM19nYWRnZXRfc3VzcGVuZCgpIGFuZCBkd2MzX2dhZGdldF9yZXN1bWUo
KSB0byBiZSBjYWxsZWQgaW4NCj4gYSBzcGlubG9jay4NCg0KU291bmRzIGxpa2UgdGhlIHJlbW92
YWwgb2YgdGhlIHNwaW5fbG9jayBhbmQgdGhlIGluY3JlYXNlIG9mIGhhbHQNCnRpbWVvdXQgYXJl
IDIgc2VwYXJhdGUgY2hhbmdlLiBJdCB3b3VsZCBiZSBuaWNlIHRvIHNlcGFyYXRlIHRoaXMgcGF0
Y2gNCnNpbmNlIHRoZSAkc3ViamVjdCBvbmx5IGluZGljYXRlcyAxIG9mIHRoZW0uDQoNCj4gDQo+
IFN1Z2dlc3RlZC1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBXZXNsZXkgQ2hlbmcgPHF1aWNfd2NoZW5nQHF1aWNpbmMuY29tPg0K
PiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jICAgfCA0IC0tLS0NCj4gIGRyaXZlcnMv
dXNiL2R3YzMvZ2FkZ2V0LmMgfCA4ICsrKysrKystDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDcgaW5z
ZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Vz
Yi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IGluZGV4IGM1YzIzOGFi
MzA4My4uMjNlMTIzYTFhYjVmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUu
Yw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBAQCAtMTk3Niw5ICsxOTc2LDcg
QEAgc3RhdGljIGludCBkd2MzX3N1c3BlbmRfY29tbW9uKHN0cnVjdCBkd2MzICpkd2MsIHBtX21l
c3NhZ2VfdCBtc2cpDQo+ICAJY2FzZSBEV0MzX0dDVExfUFJUQ0FQX0RFVklDRToNCj4gIAkJaWYg
KHBtX3J1bnRpbWVfc3VzcGVuZGVkKGR3Yy0+ZGV2KSkNCj4gIAkJCWJyZWFrOw0KPiAtCQlzcGlu
X2xvY2tfaXJxc2F2ZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+ICAJCWR3YzNfZ2FkZ2V0X3N1c3Bl
bmQoZHdjKTsNCj4gLQkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZHdjLT5sb2NrLCBmbGFncyk7
DQo+ICAJCXN5bmNocm9uaXplX2lycShkd2MtPmlycV9nYWRnZXQpOw0KPiAgCQlkd2MzX2NvcmVf
ZXhpdChkd2MpOw0KPiAgCQlicmVhazsNCj4gQEAgLTIwMzksOSArMjAzNyw3IEBAIHN0YXRpYyBp
bnQgZHdjM19yZXN1bWVfY29tbW9uKHN0cnVjdCBkd2MzICpkd2MsIHBtX21lc3NhZ2VfdCBtc2cp
DQo+ICAJCQlyZXR1cm4gcmV0Ow0KPiAgDQo+ICAJCWR3YzNfc2V0X3BydGNhcChkd2MsIERXQzNf
R0NUTF9QUlRDQVBfREVWSUNFKTsNCj4gLQkJc3Bpbl9sb2NrX2lycXNhdmUoJmR3Yy0+bG9jaywg
ZmxhZ3MpOw0KPiAgCQlkd2MzX2dhZGdldF9yZXN1bWUoZHdjKTsNCj4gLQkJc3Bpbl91bmxvY2tf
aXJxcmVzdG9yZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+ICAJCWJyZWFrOw0KPiAgCWNhc2UgRFdD
M19HQ1RMX1BSVENBUF9IT1NUOg0KPiAgCQlpZiAoIVBNU0dfSVNfQVVUTyhtc2cpICYmICFkZXZp
Y2VfY2FuX3dha2V1cChkd2MtPmRldikpIHsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3
YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IGluZGV4IDdiNjZhNTQy
NTBhMC4uYjI2NjhhODNjYzI5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdl
dC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gQEAgLTI0NDQsNyArMjQ0
NCw3IEBAIHN0YXRpYyB2b2lkIF9fZHdjM19nYWRnZXRfc2V0X3NwZWVkKHN0cnVjdCBkd2MzICpk
d2MpDQo+ICBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X3J1bl9zdG9wKHN0cnVjdCBkd2MzICpkd2Ms
IGludCBpc19vbiwgaW50IHN1c3BlbmQpDQo+ICB7DQo+ICAJdTMyCQkJcmVnOw0KPiAtCXUzMgkJ
CXRpbWVvdXQgPSA1MDA7DQo+ICsJdTMyCQkJdGltZW91dCA9IDEwMDsNCj4gIA0KPiAgCWlmIChw
bV9ydW50aW1lX3N1c3BlbmRlZChkd2MtPmRldikpDQo+ICAJCXJldHVybiAwOw0KPiBAQCAtMjQ3
Nyw2ICsyNDc3LDcgQEAgc3RhdGljIGludCBkd2MzX2dhZGdldF9ydW5fc3RvcChzdHJ1Y3QgZHdj
MyAqZHdjLCBpbnQgaXNfb24sIGludCBzdXNwZW5kKQ0KPiAgCWR3YzNfZ2FkZ2V0X2RjdGxfd3Jp
dGVfc2FmZShkd2MsIHJlZyk7DQo+ICANCj4gIAlkbyB7DQo+ICsJCW1zbGVlcCgyMCk7DQoNClBv
bGxpbmcgaW50ZXJ2YWwgb2YgMjBtcyBzZWVtcyBhIGJpdCBtdWNoLiBDYW4gd2UgdXNlIHVzbGVl
cF9yYW5nZSgpDQpiZXR3ZWVuIDEtMm1zPw0KDQpUaGFua3MsDQpUaGluaA0KDQo+ICAJCXJlZyA9
IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0RTVFMpOw0KPiAgCQlyZWcgJj0gRFdDM19EU1RT
X0RFVkNUUkxITFQ7DQo+ICAJfSB3aGlsZSAoLS10aW1lb3V0ICYmICEoIWlzX29uIF4gIXJlZykp
Ow0KPiBAQCAtNDUyMCwxMiArNDUyMSwxNyBAQCB2b2lkIGR3YzNfZ2FkZ2V0X2V4aXQoc3RydWN0
IGR3YzMgKmR3YykNCj4gIA0KPiAgaW50IGR3YzNfZ2FkZ2V0X3N1c3BlbmQoc3RydWN0IGR3YzMg
KmR3YykNCj4gIHsNCj4gKwl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiArDQo+ICAJaWYgKCFkd2Mt
PmdhZGdldF9kcml2ZXIpDQo+ICAJCXJldHVybiAwOw0KPiAgDQo+ICAJZHdjM19nYWRnZXRfcnVu
X3N0b3AoZHdjLCBmYWxzZSwgZmFsc2UpOw0KPiArDQo+ICsJc3Bpbl9sb2NrX2lycXNhdmUoJmR3
Yy0+bG9jaywgZmxhZ3MpOw0KPiAgCWR3YzNfZGlzY29ubmVjdF9nYWRnZXQoZHdjKTsNCj4gIAlf
X2R3YzNfZ2FkZ2V0X3N0b3AoZHdjKTsNCj4gKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkd2Mt
PmxvY2ssIGZsYWdzKTsNCj4gIA0KPiAgCXJldHVybiAwOw0KPiAgfQ0KDQo=
