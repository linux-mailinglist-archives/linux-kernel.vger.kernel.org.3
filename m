Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53A24D5B6F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 07:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346776AbiCKGO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346756AbiCKGOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 01:14:54 -0500
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF2AF4D18;
        Thu, 10 Mar 2022 22:13:21 -0800 (PST)
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EBE4AC010E;
        Fri, 11 Mar 2022 06:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1646979165; bh=Ctw0mFtwfKRw+L7eaXkMlXF8PWPgioczE9n0KL1QqDU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=lq2N9Eng0bvqoM3jTQ88fvfkIn+LFBfZCP4OF1ZxC/iiDfyY0rSSPqWNP0fyzHdUF
         GzU5Ov9OIQcR85guQVACQhRAXNDHzoGwLyuBsn6lQNpAVKTg7BgIl6bbmJ8vhd7x1x
         XtMqmd/d8ODppWn5tCLlGJ8GchFq2cyDUbP54lR8MZw6vdBRS9wdMS9MAtvGxWTF2A
         PLb49R+6sGbID6OsJBS36KISbprnkKUqf0FLkK1AkVfZkHbF272lBRqczeT1B9UsbD
         LSuUS516mZmIPWO3YR0xCArM0geJK5+j1KWfDV1oUfIqkslw1nhVM3akr377spPsF2
         L7nFITXrjJxyA==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 4FB71A0079;
        Fri, 11 Mar 2022 06:12:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id C07654006B;
        Fri, 11 Mar 2022 06:12:42 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="oH5OPd/j";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8lq9+NVT/w2l8jBb/iDJTHP5TzRFo5VesNYjVPR/9YWRQrm4ktcrBpaRbl1BJzR0PQJDOY2TiboUe8L98Hs2as9ZeKz7qf6G1fK2Aw4zE1RKBnB1bRZEoCcDy3j6XBZfftUsryL0ZPt+6HrLe3+MY2/78FVFf/LasESE+W3AV17TwyLCWMY02w5OfmiYWv1Ryi5FCATx7UUW+eC0rDOWp+kZ5yoVc0Rdk94/g/ITD2+XZSUNLe73uggT8lUKEpYyB867pNeMFVRG68BrEwNDNrBaGhSHpln99GxnznIHnTfBCRvTdikOYrzDYF8c0O6vVnU3URWHcaNvIWEruA94A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ctw0mFtwfKRw+L7eaXkMlXF8PWPgioczE9n0KL1QqDU=;
 b=bTsDjxJBHaHaoGFXn34r3Grsf/w4nt/SFexex3APRBIvqq+MQqW2//U285h7N9m9BFORRLyaDdgR38iHcXQd7eTsxyTTIxi6TwdH8KCZXorN9jmLcJQuoD3unyCw8qJJhPdLSl6bi0eD2Fc1Ykl7YcIWLzLb2MyqMcFwe2GLckZDz+NoX+svpy5ev0sdHKtyz6TOIxMIjpp21atlKCWHKWXllBMje3Fi4jTIotT3ac698wCoV8Wo58kaPWpt2jx6TL2MkrEnwsFaMV7FHD1d3oUX0j3x1xrsKaf+jpWQetnc/Adh37hZlCECwx92fgQ1Z4qHIXU2lvA+vRuD/98yXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ctw0mFtwfKRw+L7eaXkMlXF8PWPgioczE9n0KL1QqDU=;
 b=oH5OPd/jP69JCld7/o6N9c0hAcpRyBLtPRVy+nBMNxZP/VaAZZgRlI9JgaVlUMERNe7QftI0h+LffMHa3nMSK9zx+sIBH8AleH3hkrYSwBt1q/7JzbNawrSh9+S0nHajwnRWVT8oIOqfp6uuQA2AU82NUFLhCCE+7iGyYvW2qXA=
Received: from BYAPR12MB3399.namprd12.prod.outlook.com (2603:10b6:a03:ad::22)
 by CY4PR12MB1382.namprd12.prod.outlook.com (2603:10b6:903:40::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Fri, 11 Mar
 2022 06:12:39 +0000
Received: from BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::3db4:25a0:68a4:c946]) by BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::3db4:25a0:68a4:c946%6]) with mapi id 15.20.5038.027; Fri, 11 Mar 2022
 06:12:38 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "amelie.delaunay@foss.st.com" <amelie.delaunay@foss.st.com>,
        "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>
Subject: Re: [PATCH v3] usb: dwc2: drd: fix soft connect when gadget is
 unconfigured
Thread-Topic: [PATCH v3] usb: dwc2: drd: fix soft connect when gadget is
 unconfigured
Thread-Index: AQHYIw1S89R4Hh4nVEmQ6a8NfJpkuKy51+eA
Date:   Fri, 11 Mar 2022 06:12:38 +0000
Message-ID: <5b33ecc2-be50-1320-9bb1-8c7a2966f835@synopsys.com>
References: <1644999135-13478-1-git-send-email-fabrice.gasnier@foss.st.com>
In-Reply-To: <1644999135-13478-1-git-send-email-fabrice.gasnier@foss.st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ec97554-5ed5-4484-a154-08da032624d5
x-ms-traffictypediagnostic: CY4PR12MB1382:EE_
x-microsoft-antispam-prvs: <CY4PR12MB13820FE71A580FD882472FFAA70C9@CY4PR12MB1382.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DWgHPxN8PZB4PvpPoHOn6Moev3DI4H14SfiRI3zc+DmParppa5o8FSsEv3WGBgFEAq+YUgzY2RBufCgb4Lr6ZifCae8as1ckLSe4OauMktpJfyhFdFl7o0Fq1D48tvhjEdK3QlQpg0Nec1fAbrcKwVWOHK9LPGRLESbE8vukXKPqZQORS5BkSQo7OGRgA04Smi6uBUih9tGetyMfznLbDJFP0IMpnPiF7QSePVRkmfl49eHei5IK1WBcPKqBwu443loakyVr7va8lOOldYhJlq8HXtODa5BzLsMRFLmsDBrNPccKceQFLFzbrAlTWbHCSnkaxYOZVcZUqU3MBde8IrtWfTCmKCjCyEFM/pQO56Ccsn5fOJinqBGrgsOwgxXhLLibsi/Tl9exGXWR15BRUE14cV95DnKLZvu0RosUKuCdmWsnKHOi9O710lNXsEi0ypPbN7PSoG4KkmxvoABePpqJ+ZYh+uGxYuafIShDEtvR4jMMEyZ8Q3on5GZ4IASV5+bSYgzET/6/m9L17nANVo0hBuCbGDaJ5vXIrqhVXTOVNYno0J1Jtiyrnz1B9t2ZTy+ejV/hQabK3yxClFB4p8m5euU6L1/us0mYWLSDv1xVvwRR2M5R8pNDNrgims8BSBZF80pOj7FqVGPZ8I29qPf5pwavOlt1GbZgWQpp+IqjaBaHDxIhtTzezFf8vD4gDMbECUD78pcZNtyFiM+jywHAH4TYlutkLa88ZrFKB3uXZTtW0O3rMtxM5j0btUP0vP/4qxAHq/yAxj+nvmWVqU2EOQlgHxMlGRyH1GNPMr2xgtEbX6+VR7yn7NJLapZQ8tG5kdjkujX0+9s6wJHEHoD8nmQ0gaNO/dGP1skKV8I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3399.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(6512007)(54906003)(36756003)(31686004)(53546011)(508600001)(26005)(71200400001)(316002)(2616005)(76116006)(83380400001)(6506007)(6486002)(966005)(2906002)(86362001)(110136005)(64756008)(122000001)(8676002)(31696002)(66476007)(66556008)(66446008)(4326008)(91956017)(66946007)(5660300002)(8936002)(38070700005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlM4cGZManBrUlNsa2NMc0xsc05OYlRuSTJSWHhYWTdyd1ROSXovb1AxUm9r?=
 =?utf-8?B?RjZBQk8yS010RkdHdW9aT3N6YUhwRGdGNUlPVk0zNEsyM0FFNElyZDNWcDJI?=
 =?utf-8?B?SS9zekIwdlV5dFRLeVoyNTZnZ1ZYVXd1K2pOOENWaVlWSHlCM2wxOEE0MGZK?=
 =?utf-8?B?Zko3UjBJU3E1WTFJQjB1ckwrZS9xbDZSQmQyUTg4aTVDclBRWlBuRm9XRERw?=
 =?utf-8?B?K2JpWGVzSGFRdTJpN3g3eUZwWnNOdk05UDk4WVhPOGlINFZLK20rbVlESTRE?=
 =?utf-8?B?dnYyTmo4REdJWFRSZU0wQVdMVnZHSjNVczFPWjZBKy9lZTI3d3RjT01EUEtO?=
 =?utf-8?B?WWY4NUsrS2ZBK3JVU25VdUFRYU1mcWYyeGFwTW9oWWw2MnVMRnZwSXZESDhv?=
 =?utf-8?B?RjZxc0hsQ0NucThoRVVmNExYRHVGZXlqWG1vY3NXekVnRXEyT1oycXVsK2I0?=
 =?utf-8?B?Wk9rSTh0QTNHeGRlYWhzMnVvQThGSWRyY1I1SkFqSzk1ZmtTK1JXUUZIdlNh?=
 =?utf-8?B?d0tPZVB4d3NVWWp6MlM1dkk4c2xVSjl1QWdnZ1FyNHI1SHZOWHZuWFppK2hG?=
 =?utf-8?B?d0RPL0NXSEFaSE1peGdZb04wa3M5M0tlUGNNUUt0UDRnYU5pTVU4NTJoekVl?=
 =?utf-8?B?ZHY5TUVuWUdCY2c0eE9iR3MxOXhKNmZkbzQxaGJYTjdSdVN5ell5TkpYdkk5?=
 =?utf-8?B?Q0JlQjBtUkFBMGdGQnhGdEtaVUVWM3JiZFZmY0piTjJTbHUwYUxvbWNFTUJZ?=
 =?utf-8?B?VlRWMy8vWXlFZUp0S1VqdW5vYjh2RlR6bmZWQXRSSEt5QVE1MVpXOEMxOWsv?=
 =?utf-8?B?cVk3d1BMMkhod3Foc1JDSzgzYTg3bFB3d1dRWm8zdUxOdkNxMktzSDNsZENC?=
 =?utf-8?B?bi9rRm42MGphYXJWNHlqNFVqWmxCUS9COEtqZE9ZbUZmOHdKaUhQczRMVWVz?=
 =?utf-8?B?RURxVWhMTWkvc3VxT3pmb2hLNmlEcDdPWHE2N3hhOFBkUFVrTmRrYzh1Y1gv?=
 =?utf-8?B?eDVKZllsN1d4OE12dVBRb3loczk4WUVYdk5VZU9IZlQrNitvbVg4d25NeEx4?=
 =?utf-8?B?dzBCZ1RFRjl6U1A3L2F1YlZ5Q0drTVZ3a0ZhcFJrQ3lWQzR3eU4yaFg1d2o3?=
 =?utf-8?B?Y3ZwdVg3Y3V3ZmNVd2FHenFadlBCdTAwRWJVWVhrZEsvWXFtVHRHYUtNejdZ?=
 =?utf-8?B?eE5ETzI3dC9IM2MwWE1UZjFtR3hXdFVSUFA2Y2tiQTVBU2F6SXJKejdka3N1?=
 =?utf-8?B?ZzEvUWRQZ0dZRVNTeVowS3J1TDFNUE5IcklUVEN5SEUzVGZ2c1kxNi9WVWRh?=
 =?utf-8?B?OStQMTNOZlRHMGI3MisyUmpkZG56NjltMDVMdGVUYTNiQUdrcUhmVjFmUFp1?=
 =?utf-8?B?T1lmWitrQmUyYjhqcHdydThIbElhbzNnU2RmUnJvU01QaG9PbjhqWUpZMGRE?=
 =?utf-8?B?RXRrYmQ3cEtJRXNCb09DREh3ZEdyNmtTVWhYK2NzRzZzQWZDVXREOG1Ea3dP?=
 =?utf-8?B?bjlaOTRSNjRMKzFSNForMGJ5dEk3UGVkRkZNUEMzZGMyUVQvbVdjQm5jVjdu?=
 =?utf-8?B?emVybUhOa0RaYldLaVdMVEFxWkdRSUlpazVTWi9CSEZLVFZvZjZQMXFVeTA1?=
 =?utf-8?B?MnBUZ1RIYmNDSXVYWnErTGdzZmRJMC9ZUHJaSGlHVTZ1b21VWUdmVDcyREht?=
 =?utf-8?B?aExGMnJKQnhNTWtYMys2RFFGeTgyVG8xU3hJVXdZcWgzRWN3QkprZUV0bXdL?=
 =?utf-8?B?YWphaXYvWjhjdDkzM3dZOHZWdmdtd0RXOWdmVEc5OFZvZS9GVi9WdFlYanJC?=
 =?utf-8?B?Y29LcDl1bGpvNzV6bzBXb3M3c0wvQWlWczVFVkFZNUdFL1R1aUN1bzJmS2FX?=
 =?utf-8?B?bERTK2Q2S3l5Njh5bHlsN1JFaDhuM1MwSkl2ZXQrR2l5SDJqV2dFdVovTW8v?=
 =?utf-8?B?NzhYU29KUlBweStHR2lENCtWMXhneUpjWHI5MnFrUFVMZlRzNFBLOXBJQngz?=
 =?utf-8?B?cUROejlXYmIvNEZVRTJYTm1HSzBvNG9BUWxCcTlpVzBaT25ZYzJxSjc4MW1S?=
 =?utf-8?B?NllieDZLYlBHRnBHUnhnSTNuSFRnV2FjTHlTZCt1Nm10dVp2TVVkSHRjcGhk?=
 =?utf-8?B?QjJMbUhZTDJ3S01qSTNlYythVFRYQXE1R0R6VkxZQmdjY1BtZkEydEhEckli?=
 =?utf-8?B?dmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44EBFA1E30204A4EA890AB043CC9DDB9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec97554-5ed5-4484-a154-08da032624d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 06:12:38.4217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OBwMXKNgb5bGAwVXKNGV7ROJOb+5LPp2zS20GsyqJHFdC6hngVUrQehrXaZyLUYToUw9+fYwzH5xmQWnv/IsmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1382
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8xNi8yMDIyIDEyOjEyIFBNLCBGYWJyaWNlIEdhc25pZXIgd3JvdGU6DQo+IFdoZW4gdGhl
IGdhZGdldCBkcml2ZXIgaGFzbid0IGJlZW4gKHlldCkgY29uZmlndXJlZCwgYW5kIHRoZSBjYWJs
ZSBpcw0KPiBjb25uZWN0ZWQgdG8gYSBIT1NULCB0aGUgU0ZURElTQ09OIGdldHMgY2xlYXJlZCB1
bmNvbmRpdGlvbmFsbHksIHNvIHRoZQ0KPiBIT1NUIHRyaWVzIHRvIGVudW1lcmF0ZSBpdC4NCj4g
QXQgdGhlIGhvc3Qgc2lkZSwgdGhpcyBjYW4gcmVzdWx0IGluIGEgc3R1Y2sgVVNCIHBvcnQgb3Ig
d29yc2UuIFdoZW4NCj4gZ2V0dGluZyBsdWNreSwgc29tZSBkbWVzZyBjYW4gYmUgb2JzZXJ2ZWQg
YXQgdGhlIGhvc3Qgc2lkZToNCj4gICBuZXcgaGlnaC1zcGVlZCBVU0IgZGV2aWNlIG51bWJlciAu
Li4NCj4gICBkZXZpY2UgZGVzY3JpcHRvciByZWFkLzY0LCBlcnJvciAtMTEwDQo+IA0KPiBGaXgg
aXQgaW4gZHJkLCBieSBjaGVja2luZyB0aGUgZW5hYmxlZCBmbGFnIGJlZm9yZSBjYWxsaW5nDQo+
IGR3YzJfaHNvdGdfY29yZV9jb25uZWN0KCkuIEl0IHdpbGwgYmUgY2FsbGVkIGxhdGVyLCBvbmNl
IGNvbmZpZ3VyZWQsDQo+IGJ5IHRoZSBub3JtYWwgZmxvdzoNCj4gLSB1ZGNfYmluZF90b19kcml2
ZXINCj4gICAtIHVzYl9nYWRnZXRfY29ubmVjdA0KPiAgICAgLSBkd2MyX2hzb3RnX3B1bGx1cA0K
PiAgICAgICAtIGR3YzJfaHNvdGdfY29yZV9jb25uZWN0DQo+IA0KPiBGaXhlczogMTdmOTM0MDI0
ZTg0ICgidXNiOiBkd2MyOiBvdmVycmlkZSBQSFkgaW5wdXQgc2lnbmFscyB3aXRoIHVzYiByb2xl
IHN3aXRjaCBzdXBwb3J0IikNCj4gU2lnbmVkLW9mZi1ieTogRmFicmljZSBHYXNuaWVyIDxmYWJy
aWNlLmdhc25pZXJAZm9zcy5zdC5jb20+DQoNCkFja2VkLWJ5OiBNaW5hcyBIYXJ1dHl1bnlhbiA8
aG1pbmFzQHN5bm9wc3lzLmNvbT4NCg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2MzoNCj4gLSByZW1v
dmUgZXh0cmEgKCkgaW4gZHdjMl9pc19kZXZpY2VfZW5hYmxlZCgpIG1hY3JvLg0KPiBDaGFuZ2Vz
IGluIHYyOg0KPiAtIEZpeCBidWlsZCBlcnJvcjogJ3N0cnVjdCBkd2MyX2hzb3RnJyBoYXMgbm8g
bWVtYmVyIG5hbWVkICdlbmFibGVkJzsNCj4gICAgYXMgcmVwb3J0ZWQgYnkgdGhlIGtlcm5lbCB0
ZXN0IHJvYm90Lg0KPiAgICBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLzIwMjIwMjExMjIzNi5Bd29PVHRITy1sa3BAaW50ZWwuY29tL19fOyEh
QTRGMlI5R19wZyFLeFlxdjR6MU5EWk05eXVfZVpPMWVFbzFaQVJOYlQxMERkUkVHbXJVT0p2SDNK
aDlzb3l3OUhkNWxja0VXd0EkDQo+ICAgIEFkZCBkd2MyX2lzX2RldmljZV9lbmFibGVkKCkgbWFj
cm8gdG8gaGFuZGxlIHRoaXMuDQo+IC0tLQ0KPiAgIGRyaXZlcnMvdXNiL2R3YzIvY29yZS5oIHwg
MiArKw0KPiAgIGRyaXZlcnMvdXNiL2R3YzIvZHJkLmMgIHwgNiArKysrLS0NCj4gICAyIGZpbGVz
IGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3VzYi9kd2MyL2NvcmUuaCBiL2RyaXZlcnMvdXNiL2R3YzIvY29yZS5oDQo+
IGluZGV4IDhhNjNkYTMuLjg4YzMzN2IgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzIv
Y29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzIvY29yZS5oDQo+IEBAIC0xNDE4LDYgKzE0
MTgsNyBAQCB2b2lkIGR3YzJfaHNvdGdfY29yZV9jb25uZWN0KHN0cnVjdCBkd2MyX2hzb3RnICpo
c290Zyk7DQo+ICAgdm9pZCBkd2MyX2hzb3RnX2Rpc2Nvbm5lY3Qoc3RydWN0IGR3YzJfaHNvdGcg
KmR3YzIpOw0KPiAgIGludCBkd2MyX2hzb3RnX3NldF90ZXN0X21vZGUoc3RydWN0IGR3YzJfaHNv
dGcgKmhzb3RnLCBpbnQgdGVzdG1vZGUpOw0KPiAgICNkZWZpbmUgZHdjMl9pc19kZXZpY2VfY29u
bmVjdGVkKGhzb3RnKSAoaHNvdGctPmNvbm5lY3RlZCkNCj4gKyNkZWZpbmUgZHdjMl9pc19kZXZp
Y2VfZW5hYmxlZChoc290ZykgKGhzb3RnLT5lbmFibGVkKQ0KPiAgIGludCBkd2MyX2JhY2t1cF9k
ZXZpY2VfcmVnaXN0ZXJzKHN0cnVjdCBkd2MyX2hzb3RnICpoc290Zyk7DQo+ICAgaW50IGR3YzJf
cmVzdG9yZV9kZXZpY2VfcmVnaXN0ZXJzKHN0cnVjdCBkd2MyX2hzb3RnICpoc290ZywgaW50IHJl
bW90ZV93YWtldXApOw0KPiAgIGludCBkd2MyX2dhZGdldF9lbnRlcl9oaWJlcm5hdGlvbihzdHJ1
Y3QgZHdjMl9oc290ZyAqaHNvdGcpOw0KPiBAQCAtMTQ1NCw2ICsxNDU1LDcgQEAgc3RhdGljIGlu
bGluZSBpbnQgZHdjMl9oc290Z19zZXRfdGVzdF9tb2RlKHN0cnVjdCBkd2MyX2hzb3RnICpoc290
ZywNCj4gICAJCQkJCSAgIGludCB0ZXN0bW9kZSkNCj4gICB7IHJldHVybiAwOyB9DQo+ICAgI2Rl
ZmluZSBkd2MyX2lzX2RldmljZV9jb25uZWN0ZWQoaHNvdGcpICgwKQ0KPiArI2RlZmluZSBkd2My
X2lzX2RldmljZV9lbmFibGVkKGhzb3RnKSAoMCkNCj4gICBzdGF0aWMgaW5saW5lIGludCBkd2My
X2JhY2t1cF9kZXZpY2VfcmVnaXN0ZXJzKHN0cnVjdCBkd2MyX2hzb3RnICpoc290ZykNCj4gICB7
IHJldHVybiAwOyB9DQo+ICAgc3RhdGljIGlubGluZSBpbnQgZHdjMl9yZXN0b3JlX2RldmljZV9y
ZWdpc3RlcnMoc3RydWN0IGR3YzJfaHNvdGcgKmhzb3RnLA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy91c2IvZHdjMi9kcmQuYyBiL2RyaXZlcnMvdXNiL2R3YzIvZHJkLmMNCj4gaW5kZXggMWIzOWM0
Ny4uZDhkNjQ5MyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMi9kcmQuYw0KPiArKysg
Yi9kcml2ZXJzL3VzYi9kd2MyL2RyZC5jDQo+IEBAIC0xMzAsOCArMTMwLDEwIEBAIHN0YXRpYyBp
bnQgZHdjMl9kcmRfcm9sZV9zd19zZXQoc3RydWN0IHVzYl9yb2xlX3N3aXRjaCAqc3csIGVudW0g
dXNiX3JvbGUgcm9sZSkNCj4gICAJCWFscmVhZHkgPSBkd2MyX292cl9hdmFsaWQoaHNvdGcsIHRy
dWUpOw0KPiAgIAl9IGVsc2UgaWYgKHJvbGUgPT0gVVNCX1JPTEVfREVWSUNFKSB7DQo+ICAgCQlh
bHJlYWR5ID0gZHdjMl9vdnJfYnZhbGlkKGhzb3RnLCB0cnVlKTsNCj4gLQkJLyogVGhpcyBjbGVh
ciBEQ1RMLlNGVERJU0NPTiBiaXQgKi8NCj4gLQkJZHdjMl9oc290Z19jb3JlX2Nvbm5lY3QoaHNv
dGcpOw0KPiArCQlpZiAoZHdjMl9pc19kZXZpY2VfZW5hYmxlZChoc290ZykpIHsNCj4gKwkJCS8q
IFRoaXMgY2xlYXIgRENUTC5TRlRESVNDT04gYml0ICovDQo+ICsJCQlkd2MyX2hzb3RnX2NvcmVf
Y29ubmVjdChoc290Zyk7DQo+ICsJCX0NCj4gICAJfSBlbHNlIHsNCj4gICAJCWlmIChkd2MyX2lz
X2RldmljZV9tb2RlKGhzb3RnKSkgew0KPiAgIAkJCWlmICghZHdjMl9vdnJfYnZhbGlkKGhzb3Rn
LCBmYWxzZSkpDQoNCg==
