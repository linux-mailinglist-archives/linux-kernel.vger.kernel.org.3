Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52DA50EDFC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 03:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240655AbiDZBPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 21:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiDZBPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 21:15:38 -0400
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66586E4F9;
        Mon, 25 Apr 2022 18:12:32 -0700 (PDT)
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id AB1B8C0C7A;
        Tue, 26 Apr 2022 01:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1650935552; bh=0zwmHCjWqGqiM6l/mjeXggBdyLoWCTsECWzzcxhCjTw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Ic2r+E9so/tyCPmbl/bE6f1q3OyVE+EZmJ56aVK4USePHIsZ1S7xhA4bysDFtlHlg
         5fLhxeKXHQ7fSi7uiJ9iRGg+s7BONHIxQgy+hykzfgjm2yb0uGY4Tnfjbp2N4a0okS
         4eXvY/y09pC8pVS3X6x3jT1iZ9q0zJAptP4GterVhstdWkUyU02gtXRSRDEgsNLgc3
         I0AG3ep0iflI3sMq2UYDjjiQY7ZoBFk+pdGV76GQidr64ovx8+IcTFvhEYw28U/2sd
         pRmhRoE+JoqVsTJgt2VtE1c/DgjkWzleC6vqU2jeWnXIPKyka8W9lnL856nSyJ1tfk
         x1dMcTW9nAblA==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 73C37A005C;
        Tue, 26 Apr 2022 01:12:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id E896F8012D;
        Tue, 26 Apr 2022 01:12:25 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="uyakpzLR";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnaQBg7DzPOjR8/59mXE37UUAK8TjvULifeJNxY5VnNZGHXKCFLAKQqitLjjPqfGyoS6x9/XQ9hooYnDLxofZHM0rh5cHt7XCek+fCcdGHtlqicjelJhMIDKCMFrfnU4LkiE4U8D6FkqpYaBpoV+Nk+ora8ITifERsSDeLNp1aiqrRsC/iHHWVULWu/xM0Bs4T/EIP3S2wEyJ2q9bkmlmUdb2MsXzVmkBO5bz7egoH5h4rhol9OXBP1+Xgl1xT/6N/CWXj7GxYcoY0grgSaRm0bgsxuPPovMNy9fn828gKQ1h00XW5yvw8Uk6EbCbW2t/cAFa8MRYfZX5hgs3DJq1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zwmHCjWqGqiM6l/mjeXggBdyLoWCTsECWzzcxhCjTw=;
 b=g+75kMyHSKYLEXMkcuceH3Ebe2pWcx4I/U2G3o0QZvc2GcJVwG8vfrJZX/A3Fzhv75IfOKSv2vcgCRMO0QgZW7VDVFf7la+nrzc3t/0z3svLj8yt+a9BWMAdL+sL/HOf9O23DxxG3OAXsSDEpgNolMLJAuJL49FS62pguJPl1ciJZ5/2tiFao1E09x7iSupXh37+AkgPs1QO8Vi8xdlZP1V+Wl7T85jAqOmA18+2zQGjqViAs3zSxIbPMxB1+MNkLeUz53QiG/0Do+GFxfto0XfzLVUbhXFsVR7tvlfyXOfYSA4SARJR8yEL0ou/oktFcczgyfy3I69RRw/+p/Ewow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zwmHCjWqGqiM6l/mjeXggBdyLoWCTsECWzzcxhCjTw=;
 b=uyakpzLRthHIMqRweItuKyI8TB68Ns71o8kGf3snMxNT4Uxs2tvuLoUThHgnl/o2aosZzwKwP9Igx4TO2LGPIXapZC1O0qO2vNM61UiJoTGmO3xmlsyYg1mt/22sMo86MNpxio4kWb2NfgpKSnRmX0axo4KFSPYOmswj/dwuPoY=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by PH0PR12MB5607.namprd12.prod.outlook.com (2603:10b6:510:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Tue, 26 Apr
 2022 01:12:17 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::d7:f2c8:c731:bdba]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::d7:f2c8:c731:bdba%5]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 01:12:17 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_kriskura@quicinc.com" <quic_kriskura@quicinc.com>,
        "quic_vpulyala@quicinc.com" <quic_vpulyala@quicinc.com>
Subject: Re: [PATCH v4 0/3] Skip phy initialization for DWC3 USB Controllers
Thread-Topic: [PATCH v4 0/3] Skip phy initialization for DWC3 USB Controllers
Thread-Index: AQHYVTzp+nheqTmOxEObuTjVewbkqaz/84sAgAF3UoA=
Date:   Tue, 26 Apr 2022 01:12:17 +0000
Message-ID: <1287c649-de62-c7d8-1c1d-a30ede7505c9@synopsys.com>
References: <1650517255-4871-1-git-send-email-quic_c_sanm@quicinc.com>
 <20220425024858.GA7052@hu-pkondeti-hyd.qualcomm.com>
In-Reply-To: <20220425024858.GA7052@hu-pkondeti-hyd.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19c68d48-20a5-489e-024e-08da2721ce61
x-ms-traffictypediagnostic: PH0PR12MB5607:EE_
x-microsoft-antispam-prvs: <PH0PR12MB56076BAFA0BD792D828C9438AAFB9@PH0PR12MB5607.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t8s6D3OkUu0D6aCIxD6EAx+42M4LDZ6rz86wcM9el/ypZ/BdD8eVZ4AiLzzbUOoyqqc+YdqfZ28AtUD1VJunjbza9GqOwIZEYluvPbftuUXp1iSEL3GzSiSarvHj4lew+bbV5Kl8wD9oYEkXIe//JSuC8zvLhwGTgmIGuB1yjs53LenAf6JWu8pmwb0bXctGdASE/tR6prY/5DQ3wWDADP+TlvFcqdTRqFH8I067oDgpGOEpg81SuyV/HrVgAir7TD2XxFMMVN1W7F7gdnktwgP9oZmjT/5rceCZbcP2tQfsY0cVlWp7FLglEkeS5bHpvSBipw/xXREcq7ORPOFiVBZsSmYoZ6qIE4NjAW+wy2+5vzLVrydHQaD2cA3DpbFjf76nKl8Ux46deX5YoCkm7S7QPMwSBfJ2vcDVI0E61A1ytTHvGCDo1QngxFNxa+vUroodOMsKZMKiKre20WWNwVuk8g/YQ5O6hJi7oc/i0+5afg1snSuzNRB/wNp3obwUlVl9B4916Q2gIULj0uLf/b8zJ5EII1XNPYEuYCkM3AHxlydoIdHbWCKEd6v3h7e5YXEZAEFb3ayGQmtbcUzMu91jybuMKJM77CaS/VJ7nDdfGZAG5bUnGnO6sAmSfEFQZNzZE2WtyeOtxkdPJrOYeZkHL55SS0QfsuTRELgU0LnNwkZHl623ON2IEve7o4R6yyix54OZyw0xO343M8cjap3Cmo7q/esjwoRjoUXjoRJ+dqT0d17m3DdQOSbR7Vhm3eXJ6gwYuR66O65PJjwHgBYGA7vWXN7qpNuZRPwPr8oMGlMYQPolbLRfY1UrD8tLU/nIiQujrbB9jiWRzHf7JSMKNc9TKhudZ+YeA/hoQHE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(71200400001)(86362001)(36756003)(38100700002)(38070700005)(83380400001)(66946007)(76116006)(54906003)(110136005)(66446008)(66556008)(64756008)(8676002)(6506007)(8936002)(4326008)(2906002)(31696002)(31686004)(316002)(186003)(2616005)(7416002)(122000001)(5660300002)(6486002)(966005)(26005)(6512007)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vm1EcWRKT2JCUlo0ZzBPRGsvdDFnQXlqU2pkek9GazRMMDF5N3NZQ1l2UlRl?=
 =?utf-8?B?cTVrTnlsblk5L2FLaTFjN0pVT2RYNC9zdzVJMStuRzg4aGs2VU5QVGVoSVVP?=
 =?utf-8?B?dmV5czJ3M2lxcVJiclpDRndtYkZtOGxkWVh4NHJ0dEdVdlNMSlh5Um5nVTcx?=
 =?utf-8?B?V2tVdzJTazhDVm12TmdrT2JneXpzKzlYeW9zS2FGOWthekNPSk5XU1NjeFgx?=
 =?utf-8?B?Z0JJOTlINnIrTGhlUURxRXd2M0FyOUlpS0JJSE43blRPZHVpQUZGTXpENnJF?=
 =?utf-8?B?QkxZcVNqOXVVeXdzeEQycTVzK1o4VmJuWlUzUFdZYjBkM3o3SUNhMDhtZXdk?=
 =?utf-8?B?SW5RNVBPSmlWTUlLQ1A3QWtNR3V6dmNHNmdoWFdJUlJiVGR5UVFYcXFONGFZ?=
 =?utf-8?B?ZUczSGV4TGJmZ3EvdHpRTkdMNC92UEZHNlZjYzA4K3d0Tjg1N0V6UG1tbVBv?=
 =?utf-8?B?b1JwQW5QKzZQVVZERHdtdGMyanVmU1FlVVQybzFJT0l0c2hKQWx4S0JCT3Vt?=
 =?utf-8?B?eE5tVGhVRXg2SFdnd3hoMmRRRU1HZU1mTFRFQ2F0RFRUVDZmSExjTUJTN0Za?=
 =?utf-8?B?SEZQTG15TWRUL2JFaXg5cHFUQ3dDYUxpTy9vQzYrOEgrTmhvU3FyT2hmaXky?=
 =?utf-8?B?UjB1dC9pSVM3ZkVwRzdjZXdVQ2ZXNEFvbFRleS9laWhBZmV1YmZQWVpXVnRv?=
 =?utf-8?B?a0d3bnppNDhjbStpemFLV2hLNUREV1VlSFkraDB6UVEvdVZ1Z0RGaHlVekdt?=
 =?utf-8?B?VmNGV0RiZklqMVN4V0ppYUZYbTVMMHBvNTZCb3hUa1RiT2t4ZC9LczQ3SkNk?=
 =?utf-8?B?SDdoOGgyNjd3TVhZSVdZT3F1bklXL1RUKzI5U3dpWXZPVHF6THZVRmZlYVIv?=
 =?utf-8?B?S1NSdmlBemFyRVhxbEwwVEdEb3d3MjF6NVF0bGxocFpONmFSbVZMaUNKOXVu?=
 =?utf-8?B?RFJJdmM3czdJYUFwMWE2Y3M1dTBtSjJJQllqSnZPSG00cFRFWXB2SXVVdGRo?=
 =?utf-8?B?UDhmSnBUaEdIVUJLZWoyam9nYWF5MVEycHh6alh5WFoyWDdnMmczMUo4dHRa?=
 =?utf-8?B?YjgvUENFS3J4Rkk1RHlWV2tFVmE4TnJxTnFkZC8zVDBHN3lFaUYzMDZnazlV?=
 =?utf-8?B?eFgzSDNONjBNNm41eVQ5UEhoOXJwSHBmNlNKME81endlZkpsMjhqSDJHT1N5?=
 =?utf-8?B?SnhPSERubWdBTjVNdUp3TitUVWR5citxSW4zNkIrYkNxZE1hTy9WMDNwNzVz?=
 =?utf-8?B?cStyM1lxdjQxVksvRGZpN2VzSVNVZ29rZEFmKzJkaUdRaFNmUUlpRC8zbnZ6?=
 =?utf-8?B?MWN6ZFVqaWhLbTVUMG1vUmRiazU1Ym5WSFRFN1JycmYvaXNudUFlQUJmbjc0?=
 =?utf-8?B?eXlOTkZtMXpPeFdaM3lSb1RVVkpRWkNpa1l4RmIrdnlDdXd2YXFJQzZqUUNu?=
 =?utf-8?B?bXo4OTlyaTQvYmFrVlZhOXVqcVQrbldsdWJrb2pCT2pwRlJSbUxmMVVSbXA3?=
 =?utf-8?B?YTRmZkQ5MDltSnlZZmE3VmZXT2dGUS9EcGJ1a2N0c2djN3VXR1prRHNhWkZq?=
 =?utf-8?B?VkN6eU1XTU95ODlYdHgyK2xieGZLbkVtUjV2U0F0clpiNlZqemszMTlPSk50?=
 =?utf-8?B?em9YY01BbGdXMlB2SEhIYktPamhiMWhXVjdxWGp4VFVQMytJa2IwMC9uWjBk?=
 =?utf-8?B?Ync1d1picmt1aGYyaWVvNml6SVk4dlBmQXA1OGoxUC8xdUV0YVdKaU53d1l5?=
 =?utf-8?B?OWRDU2dwS3Urem1iY09teXljM2lYOWthTVMzaFFCRy9adWJjUGdOa291UnBy?=
 =?utf-8?B?U281UUU0LzEvck10YnNKRWVZTWdXdnR0VlE4Uk9pblVnSjEzcUo2SlVmTTBX?=
 =?utf-8?B?RHJBbE1WdERoSHgzZ25McS9DMHYrbXlySEdZeHZPQlFaQ001TEZjUXV1Snhp?=
 =?utf-8?B?UTNKQ0Z6bVhhOWZqcTdlTjBWb05NQnFCVmN2Yzc3TW5YTFZ5R1hjNzVDMDNi?=
 =?utf-8?B?czloN1BwTGN6T0d5K1pLdlNFOXNpK0VtZzFoL1VLNnhIU2M4WmtReHFreUNU?=
 =?utf-8?B?N05hamFrbi91bFI4OEM5c25VVG5LSGo5UmVHTTNBQ1pEYnhIQURmSGgwdDRH?=
 =?utf-8?B?bWFiWW1DQ3dYajdhNklqdmVsU0pQblFRcWNxWjd0T0VMNkh3Q0VFbnhWWWJ1?=
 =?utf-8?B?dnMwdWs0QmRYRit1N2N1WUZGMjVkS2g3a2RUNzVzSGxxWDlIOUlxaGJtQnNB?=
 =?utf-8?B?eWl3NVMreWVqZ2dnb3FzZzlGcEtnZ2tUR1RIQlE4TUJPRnVUZngvR1FmRk50?=
 =?utf-8?B?Y1R5WEJRbHJTTDIvRTdObTRCbTJPM1I5VG9CVGVUcFNvWG1mQmUzUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B41EAAB30E4D0145BCFB82F94048A3AE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c68d48-20a5-489e-024e-08da2721ce61
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 01:12:17.5589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IlpBImFAU85F49yPVwu3Nv8j1C2ilb95h4U0Pwrww1XuK1IDMA6YpPCuWm/K3i4RrYdeDG4xtOkIWWFtPr/wLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5607
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNClBhdmFuIEtvbmRldGkgd3JvdGU6DQo+IEhpIE1hdGhpYXMsDQo+IA0KPiBPbiBUaHUs
IEFwciAyMSwgMjAyMiBhdCAxMDozMDo1MkFNICswNTMwLCBTYW5kZWVwIE1haGVzd2FyYW0gd3Jv
dGU6DQo+PiBSdW50aW1lIHN1c3BlbmQgb2YgcGh5IGRyaXZlcnMgd2FzIGZhaWxpbmcgZnJvbSBE
V0MzIGRyaXZlciBhcw0KPj4gcnVudGltZSB1c2FnZSB2YWx1ZSBpcyAyIGJlY2F1c2UgdGhlIHBo
eSBpcyBpbml0aWFsaXplZCBmcm9tDQo+PiBEV0MzIGNvcmUgYW5kIEhDRCBjb3JlLg0KPj4gU29t
ZSBjb250cm9sbGVycyBsaWtlIERXQzMgYW5kIENETlMzIG1hbmFnZSBwaHkgaW4gdGhlaXIgY29y
ZSBkcml2ZXJzLg0KPj4gVGhpcyBwcm9wZXJ0eSBjYW4gYmUgc2V0IHRvIGF2b2lkIHBoeSBpbml0
aWFsaXphdGlvbiBpbiBIQ0QgY29yZS4NCj4+DQo+PiB2NDoNCj4+IEFkZGVkIHRoZSBkZXZpY2Ug
dHJlZSBiaW5kaW5nIHBhdGNoIGluIHRoZSBzZXJpZXMuDQo+Pg0KPj4gdjM6DQo+PiBDb21pbmcg
YmFjayB0byB0aGlzIHNlcmllcyBiYXNlZCBvbiBkaXNjdXNzaW9uIGF0IGJlbG93IHRocmVhZA0K
Pj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5v
cmcvcHJvamVjdC9saW51eC1hcm0tbXNtL3BhdGNoLzE2NDgxMDM4MzEtMTIzNDctNC1naXQtc2Vu
ZC1lbWFpbC1xdWljX2Nfc2FubUBxdWljaW5jLmNvbS9fXzshIUE0RjJSOUdfcGchZnlrVE5UQnVL
azljaTZ6S2RjdVFOYnVaUWRWaV9IZWtVM2pldHp1ZC1QUVZoYlJhVmhoWkhLejBrX0xmRzBjZ3dh
WDRiUU01YkxJMGVwNnRZeWlrZ3ZZSzdiNVNkQSQgDQo+PiBEcm9wcGVkIHRoZSBkdCBiaW5kaW5n
cyBQQVRDSCAxLzMgaW4gdjINCj4+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczov
L3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtYXJtLW1zbS9jb3Zlci8xNjM2MzUz
NzEwLTI1NTgyLTEtZ2l0LXNlbmQtZW1haWwtcXVpY19jX3Nhbm1AcXVpY2luYy5jb20vX187ISFB
NEYyUjlHX3BnIWZ5a1ROVEJ1S2s5Y2k2ektkY3VRTmJ1WlFkVmlfSGVrVTNqZXR6dWQtUFFWaGJS
YVZoaFpIS3owa19MZkcwY2d3YVg0YlFNNWJMSTBlcDZ0WXlpa2d2YTJWWGFoT1EkICANCj4+DQo+
PiB2MjoNCj4+IFVwZGF0ZWQgdGhlIGNvbW1pdCBkZXNjcmlwdGlvbnMuDQo+PiBDaGFuZ2VkIHN1
YmplY3QgcHJlZml4IGZyb20gZHdjIHRvIGR3YzMuDQo+PiBJbmNyZWFzZWQgcHJvcHMgYXJyYXkg
c2l6ZS4NCj4+DQo+Pg0KPj4gU2FuZGVlcCBNYWhlc3dhcmFtICgzKToNCj4+ICAgZHQtYmluZGlu
Z3M6IHVzYjogdXNiLXhoY2k6IEFkZCBiaW5kaW5ncyBmb3IgdXNiLXNraXAtcGh5LWluaXQNCj4+
ICAgICBwcm9wZXJ0eQ0KPj4gICB1c2I6IGhvc3Q6IHhoY2ktcGxhdDogQWRkIGRldmljZSBwcm9w
ZXJ0eSB0byBzZXQgWEhDSV9TS0lQX1BIWV9JTklUDQo+PiAgICAgcXVpcmsNCj4+ICAgdXNiOiBk
d2MzOiBob3N0OiBTZXQgdGhlIHByb3BlcnR5IHVzYi1za2lwLXBoeS1pbml0DQo+Pg0KPj4gIERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvdXNiLXhoY2kueWFtbCB8IDQgKysr
Kw0KPj4gIGRyaXZlcnMvdXNiL2R3YzMvaG9zdC5jICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8IDQgKysrLQ0KPj4gIGRyaXZlcnMvdXNiL2hvc3QveGhjaS1wbGF0LmMgICAgICAgICAgICAg
ICAgICAgICAgICB8IDMgKysrDQo+PiAgMyBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQo+Pg0KPiANCj4gVGhpcyBpcyB0aGUgbGF0ZXN0IHNlcmllcyB3aXRo
IGJpbmRpbmdzIGFkZGVkIGFzIHBlciBHcmVnJ3MgY29tbWVudC4gQ2FuIHlvdQ0KPiBwbGVhc2Ug
cGljayB1cCB0aGlzIHNlcmllcyBpZiB5b3UgZG9uJ3QgaGF2ZSBhbnkgZnVydGhlciBjb21tZW50
cy4NCj4gDQoNCldlJ3ZlIGhhZCB0aGlzIGNvbnZlcnNhdGlvbiBnb2luZyBvbiBmb3IgYSB3aGls
ZS4gU2VlbXMgdGhlcmUncyBubyBnb29kDQpvbmUgc29sdXRpb24gd2l0aCBldmVyeW9uZSBmdWxs
eSBnZXR0aW5nIG9uLWJvYXJkLg0KDQpJJ3ZlIHRyaWVkIHRvIGdldCBzb21lIG9mIHRoZSBxdWly
a3Mgb3V0IGJlZm9yZSBhbHNvLCBidXQgcmFuIGludG8gdGhlDQpzYW1lIHByb2JsZW0uIFsxXQ0K
DQpBcyBNYXRoaWFzIG5vdGVkIFsyXSBiZWZvcmUsIG1heWJlIHdlIGNhbiBjcmVhdGUgYSBuZXcg
eGhjaS1zbnBzDQpwbGF0Zm9ybSBnbHVlIGRyaXZlci4NCg0KVGhlIHByb2JsZW0gd2l0aCB0aGUg
Y3VycmVudCBpbXBsZW1lbnRhdGlvbiBpcyBwYXNzaW5nIGR3YzMncyByZWxhdGVkDQppbmZvIHRv
IHhoY2ktcGxhdCBnZW5lcmljIGRyaXZlciBpcyB2ZXJ5IGNsdW5reS4gV2UgY2FuIHRlYWNoIHRo
ZSBuZXcNCmdsdWUgZHJpdmVyIHdpdGggYWxsIHRoZSBpbmZvIG5lY2Vzc2FyeSB0byBkcml2ZSB0
aGUgY29udHJvbGxlci4NCg0KV2UgY2FuIGp1c3QgcGFzcyB0aGUgY29udHJvbGxlcidzIHZlcnNp
b24gKGFuZCBzdWJ2ZXJzaW9uKSBhcyBhIHByb3BlcnR5DQpmb3IgcGxhdGZvcm0gZGV2aWNlLiBU
aGlzIHdheSwgd2UgY2FuOg0KDQoxKSBTZXBhcmF0ZSB0aGUgcXVpcmtzIGZyb20geGhjaS1wbGF0
IGdsdWUuIE1vc3QgY29tbW9uIHF1aXJrcyBjYW4gYmUNCmRldGVjdGVkIGp1c3QgYmFzZSBvbiB0
aGUgY29udHJvbGxlcidzIHZlcnNpb24NCg0KMikgQXZvaWQgaGF2aW5nIHRvIGNyZWF0ZSBkdXBs
aWNhdGUgInNucHMsKiIgcHJvcGVydGllcw0KDQozKSBHZXQgYWNjZXNzIHRvIHRoZSBjb21tb24g
eGhjaSBxdWlyayBmbGFncyB3aGlsZSBtYWludGFpbiBhYnN0cmFjdGlvbg0KDQo0KSBQb3RlbnRp
YWxseSBhZGQgY29tcGF0aWJpbGl0eSBzdHJpbmcgYXMgcGFydCBvZiB0aGUgY29udHJvbGxlcidz
DQp2ZXJzaW9uIGFuZCBsZXQgdGhlIGdsdWUgZHJpdmVyIGhhbmRsZSB0aGUgcmVzdA0KDQo1KSBS
ZWR1Y2UgaW50cm9kdWNpbmcgbmV3ICJxdWlya3MiIGluIHRoZSBmdXR1cmUNCg0KSSBjYW4gZ2V0
IHN0YXJ0ZWQgd2l0aCB0aGlzLiBMZXQgbWUga25vdyBpZiB5b3UgaGF2ZSBhbnkgY29tbWVudC4N
Cg0KVGhhbmtzLA0KVGhpbmgNCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXVz
Yi8wZmIxNzliOTc3Y2QxODdmMDAzYWUxOGFkZjAxYmNjZjA5ZDc0MDkyLjE2MTgwMTQyNzkuZ2l0
LlRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20vVC8jbWE1ZjdiZGYyOWNmODRiNWEwMDc3YTRhMDg1
N2NlYjVkZmUwYzg1NjQNClsyXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC11c2IvNzZl
Y2VmZDctZDI5NC00ODVhLTFlMmItZTVlNTU2ZTJhM2Y3QGxpbnV4LmludGVsLmNvbS8jUg0K
