Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FFF533461
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 02:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242277AbiEYAk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 20:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiEYAkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 20:40:55 -0400
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5C53915E;
        Tue, 24 May 2022 17:40:54 -0700 (PDT)
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C23A645E94;
        Wed, 25 May 2022 00:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1653439254; bh=1Wh8mhfjdBxZwQHjg4MuRQp2952uiim7dBEuMG4yGcs=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=SJullVyGbf9k2YARn5GvLjULMy81sjVL2cOt151FdUtReZPeEiQmt4ANPt6kds3md
         AAqfKSMDDYrBPxaDVKh1zW53kZI1HIaaPxOsp6zb19MNlcpw1uSOhMoSwf3lJ7xgvB
         Dem52GAIHCKcbBMFRZF5wqtQ6Fd7qkcTiNQNDy9HEFvcEG0tYhClQHjJHS8YGfTqU6
         qkXftbOVjzIsQJnLmlevsBrnYIkdOwK4Z9NSwc2wOxnZXkva5t1Fq6d4dWSYBppY1Y
         VcTS+Uebs1d0y0u0dZA5tGIjL62EsLVznOiouyJy9FmQ20/OOq3MFQzk0eYTMC6df5
         pvqONFMfeKxxA==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 4BD75A025B;
        Wed, 25 May 2022 00:40:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id EC2264006B;
        Wed, 25 May 2022 00:40:51 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="PvhE2tMH";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4tJQw2urs/EiUdbgVXgi6TShtw1DeebV/F0/mY7IQka08REpCATblUsKnUuFSJSbFBvZBV5mewBHo2TsjGEBlo6AYEYcn9/hxzNVDEbZvaiTOc6pJ2MKni7v/xmt9zBWyzRIPhkXcfqLZb4+1gH8+O91SmrfOnu+kBXhG3woemEoMUfy+we7dA9YqIuBqKhbkCgmXext3iEtd+h50Oa+gdA9EuzeSTTS9KCMNkGamuH4p00lM+fXb1QzAO/R0nDZxtiitUVsnyVpbRcbS4GxgHkuy091hHSBk/NjZEYnvE1An/a0VnfUfk2OVr7LmmbcSGTdtUZAvY0uTKqdtvwpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Wh8mhfjdBxZwQHjg4MuRQp2952uiim7dBEuMG4yGcs=;
 b=SmW9vvGs3A91hNhHXyAet/JlHj7ONe/x7V9e9RAw2bbVVnOM5D/mQvAjleSkZ2PIWoJWpzpcrwdfHBOXDCjGd8EyZZgkR4H35ZW1/KzVAmfTevUDAXj+N9LmkRiysKJWHJFY7YiZskaB0P8Z6pEc4kLT4ex+esHsRfKgnq9tE4K7Si1/2Ac11Lsni0B1JRd5k3lktkFB+DFV/tx7gqmlp9SZvVVhpYW1l0rsSt+CVjcN+UanQ7b829TokrVJIjHszXQHJWGVHvlrpEGCaKIv0DhvfI7STwVPWuz2/Ref22hUMVBGhpq3kQaZL+5NtmcJA8OCCGVQKPIpv3Zw41D1ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Wh8mhfjdBxZwQHjg4MuRQp2952uiim7dBEuMG4yGcs=;
 b=PvhE2tMH3FXs8a8hbCFaLtVBkbxYq4uG4gOzGYimPtSM4mvT9sfWhxLZ7CFm5+NrdIyTKP9IGqVVMYTyB4sbBJWmxyTANQJWqLyRLiJ+jAFBnKb7ocRKPa6373ZgKxLz/9BPEm/dYMWrA5sggfTF8PS56wWBkzlVq2/PN8c0Ffs=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MN2PR12MB3039.namprd12.prod.outlook.com (2603:10b6:208:c9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Wed, 25 May
 2022 00:40:49 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::91c7:7e6b:d663:a349]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::91c7:7e6b:d663:a349%7]) with mapi id 15.20.5273.023; Wed, 25 May 2022
 00:40:42 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Mayank Rana <quic_mrana@quicinc.com>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        John Youn <John.Youn@synopsys.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>
Subject: Re: [PATCH] usb: dwc3: Fix ep0 handling when getting reset while
 doing control transfer
Thread-Topic: [PATCH] usb: dwc3: Fix ep0 handling when getting reset while
 doing control transfer
Thread-Index: AQHYX+5Z58SB+IQlLUOvFfRQIo8Rqa0u4EMA
Date:   Wed, 25 May 2022 00:40:42 +0000
Message-ID: <ac4a59de-2eae-cab3-4b28-b89582978648@synopsys.com>
References: <1651693001-29891-1-git-send-email-quic_mrana@quicinc.com>
In-Reply-To: <1651693001-29891-1-git-send-email-quic_mrana@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f537493-0df7-4662-68e9-08da3de73302
x-ms-traffictypediagnostic: MN2PR12MB3039:EE_
x-microsoft-antispam-prvs: <MN2PR12MB3039C81A8E79A4A3BBA6C267AAD69@MN2PR12MB3039.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5hCrj2Gg7NCx3oncyMJmlnfjAKdn9CluBQuWqEABG4i/VDJDgDnKiSAdc1x/whI6lsceiZis2g0vtwR+lrGj9m1FDEISDjF8oo5hj/3LbgBpOtgAHylTjlFsKnCibRuvgtz88lz77tLAseD5/QelBZLBxF2P0mlfbkkM7W0FafmetFpKY91bl83CJy5+l1++mJ/P63Fp1ZqRwXK4kjGZM7QMkr7SKYnnpfUI8c2s86PYZbWheXYmUdtXlG7h2LseTJm2gaEkQX/ylg24P7K8KnIIIxb2SD/uOijTmx6+Xh8yk2W2YcA2mT98hGbiCbdZA+7odHXi8pC8OGgcRXbsMCOzvufByxYlbtXPtvVr2UZgzgUC7cqnv+yj/kSDsishTW4t9MksObmUPlwkPOhTQax1EmhYqBhSOwjZ7aVDobhgjJG6NwNpWRBy2jYvmFJDAgBI3zu0L599LdhuWMBrDOBffmv85oXlS9+9I+zQaSd2savOFm5FFaR/8KDNadNla1rgPj4+2KbhP2UPSMnSjQUh4jAMx9ZRJlK8g9lkMKoaJ74/xFC4QwzqM2+RLCdkw7kATrJrvky0ZUmFABwJqHHoH4A/AzferUWLvmFkFNj3VYICtltRVF7ntvw6IVofmjc4xDd+1VngTfr/IQqKmSbJ3806ibt+c3jbf2dSo1kWvwiVqUfvwkhBEAH87+q7YVZtccynYkJ9qQYbXI0zKuye2psfHaIra+kw3orCb5bK7GJmb6inVeiI1q1Nu+ksFSECLDr1MeJJXz3rb7t18V38i6MXb62HXfrj8senlBE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(64756008)(4326008)(66476007)(76116006)(66556008)(83380400001)(2906002)(38100700002)(316002)(66946007)(36756003)(8936002)(8676002)(5660300002)(66446008)(6486002)(26005)(31696002)(508600001)(71200400001)(6506007)(31686004)(6512007)(54906003)(38070700005)(110136005)(186003)(86362001)(122000001)(43740500002)(45980500001)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmVFT3JXdGtCQ294ZmRIL1FxNmJJTzFtSVdTbHZEMVBWc3pQQkRwL2dFenZi?=
 =?utf-8?B?UWtGMjhZNTN3Z1ZtcUdObW8zL2wvWEs0Wmc5Yy9ZZ3k5MkVZQmFzMm1QUHlm?=
 =?utf-8?B?Wnh4VFpYVXBaY1c4WkZmejRQaHBYUzV5YmcvRmtMcDkxSXl3cys2V2tXcnJ5?=
 =?utf-8?B?ZHBxNENDM1ZteG9kS2tEV1g1amtVcHErNS9Td3NQOXhQZzJqall6OW5QZllH?=
 =?utf-8?B?V2xhcFlENmI1RGtkMmRqbDJYUjQrMGhTSVZIMGx6TUNYMnZ0RU9oUXd3bWVy?=
 =?utf-8?B?cXlzRnlBM05GN0VlWnZ2VlNmcmFieVl6TkZCQUs5NHlOY3NBMlpwczh1cHlW?=
 =?utf-8?B?WmorUW5GM2JmMTR4YU4wU3l2dFBjcStrbjkzUWtsRjVaRGpEbnBBREFYUWRI?=
 =?utf-8?B?bUlpZVo4enFyaDIyTUUzUENEZkJiTXRBYUp6Wk9MZlROWUpCRUlzSjFwR3RW?=
 =?utf-8?B?M1ByVGlocEhmcFpYS2QwNGswdDFGa2p6YjAydi9VY3hHRFVuMURIOE1XLzFu?=
 =?utf-8?B?VTRXbTJwam5DQVlkQ3NCb1FKTzJCY0RXdTczMGF1WFpySkdvSHJ6Mmk4Wi9N?=
 =?utf-8?B?eUhTTEJYZ1JYK0F1QmFmOXNzUk14S2J4NVo3d3VyUFNnY1RKUjhYTlFOSTF2?=
 =?utf-8?B?bW0xWEFDQUxQNFBkSlo5c0lETHVaR3J6TjJkVTN5aGlFcDk5ZVdFOUs4TWlZ?=
 =?utf-8?B?ME9sQW1kNTVTcnNCZ0V1K243ZU8wS0VvdEpGUnYrWmVmcXBTbmkwZTcxOXFq?=
 =?utf-8?B?U3V3TXlhTmxpY2R1bERCY1RUL1R3cHFUZ2tSeUthV1VVQStDZUZXUnBsNmM0?=
 =?utf-8?B?bFN1QzRDTWtTeFNUaTViL3pOTUplMXlySUJoenltby9CV1c3ZGJHejNFRGdM?=
 =?utf-8?B?cDJQdUQ2YVM4TWN4Ty9CWDlQMWxMWXZsZ0JrcFQvdW5ERVM0TklrZXBvb3Fs?=
 =?utf-8?B?UjBESnduOTdYaFdVNkozZzQyOTlzYmxhNXYzdXZDVTVFR2hmc0dISmNVTTcw?=
 =?utf-8?B?TjR4aHR3VExidjJCQ1JOVTFZeTB0QlRqR2xaMEs3cURkNy9remhwSEZ4SFhw?=
 =?utf-8?B?ak1TVkRRRlFVbTk5a212Rm8vOEhCcnkrbE4wMHh1V2tlbmMrckU5OEw1NU92?=
 =?utf-8?B?L0dkMTcyUkNLWmhnSm9KVHVOK0t4ZGRSOWYyc1lRa2hUaUk1Q0dGaFdGVDJx?=
 =?utf-8?B?WXVLU3RMRndPenZhMUcybG9FdWJWTm4rZXRyVVBWUTVDZ0hvSnRlT1FZa25y?=
 =?utf-8?B?bWFsTkNDSjc2MlA3bzZoSW9lbTVYUnlvWnAyelp1NkRGcEJWZGhoWUFheWZy?=
 =?utf-8?B?RmpGRGJqbmJ3UkpRWE1ZUkcvcVpINkFtdElUU3drUTJ2VTdCNyt5bGJLYS9T?=
 =?utf-8?B?WnZuTEZhb2ZXSjZOVVRsVGc1YTZGcHlqMUsyaVJxYTkxOTN6R1ArTjY2TU85?=
 =?utf-8?B?Tlk0OElkblYvTXg1d1ZCQjRiSk9mZkxYWlR6VTdxQ2tBR0xLcWlPY2hOT0pB?=
 =?utf-8?B?dnR0cUJDNXozZXNjd0F4Yk5XRkt6bkJYb2p1UDZack1rKytqT2JlNUJJR0Zn?=
 =?utf-8?B?UGMrcjBtWlJMOC9QUHJaTE1qTENSY1hNMTFLdWdoSitjTFBuSEVwVFc2V05Z?=
 =?utf-8?B?WHB4TGRwRkM3MkVjLzRreVhrL1VQNStHNUpvVDlLSFphY0J5MmJRYkVEd3Fr?=
 =?utf-8?B?VGZVK1FBWU9LUVpSQUlyYlZvVlN1K0srbEZZbmNEaXVOZVdNSm42R0tKTjhV?=
 =?utf-8?B?L0RXU0YwVDhONVdadlpwSWVSNDUxNzYwQjBUNUk4SWVESU9SNktOV0dtRlEz?=
 =?utf-8?B?d1Awc3NnUElvQnByVWFZbDJVbGJpNVA2YVp4aml6YXhNUW0zWmx5bU1EUjRZ?=
 =?utf-8?B?MWI5SnZldCt0NGtrWXgwdVNwTTEzTjhhMHdJUW9rbGRCeVVGNmRNWG5GUE5K?=
 =?utf-8?B?aXE1b1c3QmFFNk9SU1Y4ZW5vVk56b0RxcFovdHJqMXVrL3dwVjgrS05JcDJ5?=
 =?utf-8?B?ZVhSRlJsa0R2MnU0UHU0d0E2TGc1K1BzL3hBcndVMkE4NWV1cmRJT05HcHNB?=
 =?utf-8?B?dHByS0h1ZGNXUEVseEYxVjFBRUtGQXFnNXdWYlM3VjFoNGU3UUJ4NGdTUnVl?=
 =?utf-8?B?WTY2cm8wRE9ROGV5WUZHUjlNR2hINk91Sk1OMGd4dldyUWd6MzdGVDBpSW5u?=
 =?utf-8?B?b3lpeDIzYTBzN003aWFkWU4wZ1hrUmdadWtuRUQ2eG1UcjBvYno0RHVMTTd6?=
 =?utf-8?B?QUhmRDY1N1hmc2dGY00yUnZwTjBSaWVDVFUvZ3ZpRjNGT0hrOVdvTEdmVmwv?=
 =?utf-8?B?WEVLMkRuT2g2bkd4R3k3bUtNdWs1NmUwcHhwYzF5eUJad3BWRmNyUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <153179B04C004D4EA1FB35FC02ACB23F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f537493-0df7-4662-68e9-08da3de73302
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2022 00:40:42.8257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1o42kwgPDzO8msQ5gH7E4mPfbOPOAbibGL70wwbnXICCQAqrcowqAMhCWnMNCK1cI7D8nQebuE7+pFBHcRmNAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3039
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk1heWFuayBSYW5hIHdyb3RlOg0KPiBBY2NvcmRpbmcgdG8gdGhlIGRhdGFib29rIGVw
MCBzaG91bGQgYmUgaW4gc2V0dXAgcGhhc2UgZHVyaW5nIHJlc2V0Lg0KPiBJZiBob3N0IGlzc3Vl
cyByZXNldCBiZXR3ZWVuIGNvbnRyb2wgdHJhbnNmZXJzLCBlcDAgd2lsbCBiZSAgaW4gYW4NCj4g
aW52YWxpZCBzdGF0ZS4gRml4IHRoaXMgYnkgaXNzdWluZyBzdGFsbCBhbmQgcmVzdGFydCBvbiBl
cDAgaWYgaXQNCj4gaXMgbm90IGluIHNldHVwIHBoYXNlLg0KDQpJIGRvbid0IHRoaW5rIHRoZSBw
cm9ncmFtbWluZyBndWlkZSBpbmRpY2F0ZSB0byBzdGFsbCBhbmQgc3RhcnQgb24gZXAwLg0KSXQg
c2F5cyB0byAiY29tcGxldGUiIGl0LiBNYXliZSB0aGVyZSdzIGEgbWlzaW50ZXJwcmV0YXRpb24g
aGVyZS4NCg0KPiANCj4gQWxzbyBTVyBuZWVkcyB0byBjb21wbGV0ZSBwZW5kaW5nIGNvbnRyb2wg
dHJhbnNmZXIgYW5kIHNldHVwIGNvcmUgZm9yDQo+IG5leHQgc2V0dXAgc3RhZ2UgYXMgcGVyIGRh
dGEgYm9vay4gSGVuY2UgY2hlY2sgZXAwIHN0YXRlIGR1cmluZyByZXNldA0KPiBpbnRlcnJ1cHQg
aGFuZGxpbmcgYW5kIG1ha2Ugc3VyZSBhY3RpdmUgdHJhbnNmZXJzIG9uIGVwMCBvdXQvaW4NCj4g
ZW5kcG9pbnQgYXJlIHN0b3BwZWQgYnkgcXVldWluZyBFTkRYRkVSIGNvbW1hbmQgZm9yIHRoYXQg
ZW5kcG9pbnQgYW5kDQo+IHJlc3RhcnQgZXAwIG91dCBhZ2FpbiB0byByZWNlaXZlIG5leHQgc2V0
dXAgcGFja2V0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWF5YW5rIFJhbmEgPHF1aWNfbXJhbmFA
cXVpY2luYy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9lcDAuYyAgICB8IDExICsr
KysrKysrLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIHwgMjcgKysrKysrKysrKysr
KysrKysrKysrKysrKy0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5oIHwgIDIgKysNCj4g
IDMgZmlsZXMgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2VwMC5jIGIvZHJpdmVycy91c2IvZHdjMy9l
cDAuYw0KPiBpbmRleCAxMDY0YmU1Li45YjZlYmMzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3Vz
Yi9kd2MzL2VwMC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZXAwLmMNCj4gQEAgLTIxOCw3
ICsyMTgsNyBAQCBpbnQgZHdjM19nYWRnZXRfZXAwX3F1ZXVlKHN0cnVjdCB1c2JfZXAgKmVwLCBz
dHJ1Y3QgdXNiX3JlcXVlc3QgKnJlcXVlc3QsDQo+ICAJcmV0dXJuIHJldDsNCj4gIH0NCj4gIA0K
PiAtc3RhdGljIHZvaWQgZHdjM19lcDBfc3RhbGxfYW5kX3Jlc3RhcnQoc3RydWN0IGR3YzMgKmR3
YykNCj4gK3ZvaWQgZHdjM19lcDBfc3RhbGxfYW5kX3Jlc3RhcnQoc3RydWN0IGR3YzMgKmR3YykN
Cj4gIHsNCj4gIAlzdHJ1Y3QgZHdjM19lcAkJKmRlcDsNCj4gIA0KPiBAQCAtMTA4NywxMyArMTA4
NywxOCBAQCB2b2lkIGR3YzNfZXAwX3NlbmRfZGVsYXllZF9zdGF0dXMoc3RydWN0IGR3YzMgKmR3
YykNCj4gIAlfX2R3YzNfZXAwX2RvX2NvbnRyb2xfc3RhdHVzKGR3YywgZHdjLT5lcHNbZGlyZWN0
aW9uXSk7DQo+ICB9DQo+ICANCj4gLXN0YXRpYyB2b2lkIGR3YzNfZXAwX2VuZF9jb250cm9sX2Rh
dGEoc3RydWN0IGR3YzMgKmR3Yywgc3RydWN0IGR3YzNfZXAgKmRlcCkNCj4gK3ZvaWQgZHdjM19l
cDBfZW5kX2NvbnRyb2xfZGF0YShzdHJ1Y3QgZHdjMyAqZHdjLCBzdHJ1Y3QgZHdjM19lcCAqZGVw
KQ0KPiAgew0KPiAgCXN0cnVjdCBkd2MzX2dhZGdldF9lcF9jbWRfcGFyYW1zIHBhcmFtczsNCj4g
IAl1MzIJCQljbWQ7DQo+ICAJaW50CQkJcmV0Ow0KPiAgDQo+IC0JaWYgKCFkZXAtPnJlc291cmNl
X2luZGV4KQ0KPiArCS8qDQo+ICsJICogRm9yIHN0YXR1cy9EQVRBIE9VVCBzdGFnZSwgVFJCIHdp
bGwgYmUgcXVldWVkIG9uIGVwMCBvdXQNCj4gKwkgKiBlbmRwb2ludCBmb3Igd2hpY2ggcmVzb3Vy
Y2UgaW5kZXggaXMgemVyby4gSGVuY2UgYWxsb3cNCj4gKwkgKiBxdWV1aW5nIEVORFhGRVIgY29t
bWFuZCBmb3IgZXAwIG91dCBlbmRwb2ludC4NCj4gKwkgKi8NCj4gKwlpZiAoIWRlcC0+cmVzb3Vy
Y2VfaW5kZXggJiYgZGVwLT5udW1iZXIpDQo+ICAJCXJldHVybjsNCg0KVGhpcyBkb2Vzbid0IG1h
a2Ugc2Vuc2UuIFRoaXMgY29uZGl0aW9uIHdpbGwgbm90IGJlIHRydWUuIEl0J3MgYmFzaWNhbGx5
DQoNCmlmIChmYWxzZSkNCglyZXR1cm47DQoNCj4gIA0KPiAgCWNtZCA9IERXQzNfREVQQ01EX0VO
RFRSQU5TRkVSOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2Ry
aXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gaW5kZXggYWI3MjVkMi4uODJhMjEwZiAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9k
d2MzL2dhZGdldC5jDQo+IEBAIC04ODIsMTIgKzg4MiwxMyBAQCBzdGF0aWMgaW50IF9fZHdjM19n
YWRnZXRfZXBfZW5hYmxlKHN0cnVjdCBkd2MzX2VwICpkZXAsIHVuc2lnbmVkIGludCBhY3Rpb24p
DQo+ICAJCXJlZyB8PSBEV0MzX0RBTEVQRU5BX0VQKGRlcC0+bnVtYmVyKTsNCj4gIAkJZHdjM193
cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0RBTEVQRU5BLCByZWcpOw0KPiAgDQo+ICsJCWRlcC0+dHJi
X2RlcXVldWUgPSAwOw0KPiArCQlkZXAtPnRyYl9lbnF1ZXVlID0gMDsNCj4gKw0KPiAgCQlpZiAo
dXNiX2VuZHBvaW50X3hmZXJfY29udHJvbChkZXNjKSkNCj4gIAkJCWdvdG8gb3V0Ow0KPiAgDQo+
ICAJCS8qIEluaXRpYWxpemUgdGhlIFRSQiByaW5nICovDQo+IC0JCWRlcC0+dHJiX2RlcXVldWUg
PSAwOw0KPiAtCQlkZXAtPnRyYl9lbnF1ZXVlID0gMDsNCg0KVGhpcyBjaGFuZ2Ugc2hvdWxkIGJl
IGRvbmUgaW4gYSBzZXBhcmF0ZSBwYXRjaC4NCg0KPiAgCQltZW1zZXQoZGVwLT50cmJfcG9vbCwg
MCwNCj4gIAkJICAgICAgIHNpemVvZihzdHJ1Y3QgZHdjM190cmIpICogRFdDM19UUkJfTlVNKTsN
Cj4gIA0KPiBAQCAtMjc0NSw2ICsyNzQ2LDcgQEAgc3RhdGljIGludCBfX2R3YzNfZ2FkZ2V0X3N0
YXJ0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICANCj4gIAkvKiBiZWdpbiB0byByZWNlaXZlIFNFVFVQ
IHBhY2tldHMgKi8NCj4gIAlkd2MtPmVwMHN0YXRlID0gRVAwX1NFVFVQX1BIQVNFOw0KPiArCWR3
Yy0+ZXAwX2JvdW5jZWQgPSBmYWxzZTsNCg0KU2FtZSB3aXRoIHRoaXMuDQoNCj4gIAlkd2MtPmxp
bmtfc3RhdGUgPSBEV0MzX0xJTktfU1RBVEVfU1NfRElTOw0KPiAgCWR3Yy0+ZGVsYXllZF9zdGF0
dXMgPSBmYWxzZTsNCj4gIAlkd2MzX2VwMF9vdXRfc3RhcnQoZHdjKTsNCj4gQEAgLTM3NjYsNiAr
Mzc2OCwyNyBAQCBzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF9yZXNldF9pbnRlcnJ1cHQoc3RydWN0
IGR3YzMgKmR3YykNCj4gIAl9DQo+ICANCj4gIAlkd2MzX3Jlc2V0X2dhZGdldChkd2MpOw0KPiAr
DQo+ICsJLyoNCj4gKwkgKiBGcm9tIFNOUFMgZGF0YWJvb2sgc2VjdGlvbiA4LjEuMiwgdGhlIEVQ
MCBzaG91bGQgYmUgaW4gc2V0dXANCj4gKwkgKiBwaGFzZS4gU28gZW5zdXJlIHRoYXQgRVAwIGlz
IGluIHNldHVwIHBoYXNlIGJ5IGlzc3VpbmcgYSBzdGFsbA0KPiArCSAqIGFuZCByZXN0YXJ0IGlm
IEVQMCBpcyBub3QgaW4gc2V0dXAgcGhhc2UuDQo+ICsJICovDQoNCldlIHNob3VsZCBub3QgaXNz
dWUgRW5kIFRyYW5zZmVyIHRvIGNvbnRyb2wgZW5kcG9pbnQgdW5sZXNzIGl0J3MgZXJyb3INCmNh
c2Ugc3VjaCBhcyBpbnZhbGlkIGRpcmVjdGlvbi4gVGhlIGRhdGFib29rIGFsc28gc3BlY2lmeSB1
bmRlciBzZWN0aW9uDQpVU0IgcmVzZXQgaW5pdGlhbGl6YXRpb24gdG8gbm90IHNlbmQgRW5kIFRy
YW5zZmVyIHRvIGNvbnRyb2wgZW5kcG9pbnQuDQoNCj4gKwlpZiAoZHdjLT5lcDBzdGF0ZSAhPSBF
UDBfU0VUVVBfUEhBU0UpIHsNCj4gKwkJdW5zaWduZWQgaW50CWRpcjsNCj4gKw0KPiArCQlkaXIg
PSAhIWR3Yy0+ZXAwX2V4cGVjdF9pbjsNCj4gKwkJaWYgKGR3Yy0+ZXAwc3RhdGUgPT0gRVAwX0RB
VEFfUEhBU0UpDQo+ICsJCQlkd2MzX2VwMF9lbmRfY29udHJvbF9kYXRhKGR3YywgZHdjLT5lcHNb
ZGlyXSk7DQo+ICsJCWVsc2UNCj4gKwkJCWR3YzNfZXAwX2VuZF9jb250cm9sX2RhdGEoZHdjLCBk
d2MtPmVwc1shZGlyXSk7DQoNCkFsc28gbm90ZSB0aGF0IHRoZSBzdGF0dXMgc3RhZ2UgZGlyZWN0
aW9uIGNhbiBiZSBJTiBvciBPVVQgZGVwZW5kaW5nIG9uDQp0aGUgZGF0YSBkaXJlY3Rpb24uDQoN
Cj4gKw0KPiArCQlkd2MtPmVwc1swXS0+dHJiX2VucXVldWUgPSAwOw0KPiArCQlkd2MtPmVwc1sx
XS0+dHJiX2VucXVldWUgPSAwOw0KPiArDQo+ICsJCWR3YzNfZXAwX3N0YWxsX2FuZF9yZXN0YXJ0
KGR3Yyk7DQo+ICsJfQ0KPiArDQo+ICAJLyoNCj4gIAkgKiBJbiB0aGUgU3lub3BzaXMgRGVzaWdu
V2FyZSBDb3JlcyBVU0IzIERhdGFib29rIFJldi4gMy4zMGENCj4gIAkgKiBTZWN0aW9uIDQuMS4y
IFRhYmxlIDQtMiwgaXQgc3RhdGVzIHRoYXQgZHVyaW5nIGEgVVNCIHJlc2V0LCB0aGUgU1cNCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmggYi9kcml2ZXJzL3VzYi9kd2Mz
L2dhZGdldC5oDQo+IGluZGV4IGY3NjMzODAuLjU1YTU2Y2Y2NyAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy91c2IvZHdjMy9nYWRnZXQuaA0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5o
DQo+IEBAIC0xMTAsNiArMTEwLDggQEAgdm9pZCBkd2MzX2dhZGdldF9naXZlYmFjayhzdHJ1Y3Qg
ZHdjM19lcCAqZGVwLCBzdHJ1Y3QgZHdjM19yZXF1ZXN0ICpyZXEsDQo+ICB2b2lkIGR3YzNfZXAw
X2ludGVycnVwdChzdHJ1Y3QgZHdjMyAqZHdjLA0KPiAgCQljb25zdCBzdHJ1Y3QgZHdjM19ldmVu
dF9kZXBldnQgKmV2ZW50KTsNCj4gIHZvaWQgZHdjM19lcDBfb3V0X3N0YXJ0KHN0cnVjdCBkd2Mz
ICpkd2MpOw0KPiArdm9pZCBkd2MzX2VwMF9lbmRfY29udHJvbF9kYXRhKHN0cnVjdCBkd2MzICpk
d2MsIHN0cnVjdCBkd2MzX2VwICpkZXApOw0KPiArdm9pZCBkd2MzX2VwMF9zdGFsbF9hbmRfcmVz
dGFydChzdHJ1Y3QgZHdjMyAqZHdjKTsNCj4gIGludCBfX2R3YzNfZ2FkZ2V0X2VwMF9zZXRfaGFs
dChzdHJ1Y3QgdXNiX2VwICplcCwgaW50IHZhbHVlKTsNCj4gIGludCBkd2MzX2dhZGdldF9lcDBf
c2V0X2hhbHQoc3RydWN0IHVzYl9lcCAqZXAsIGludCB2YWx1ZSk7DQo+ICBpbnQgZHdjM19nYWRn
ZXRfZXAwX3F1ZXVlKHN0cnVjdCB1c2JfZXAgKmVwLCBzdHJ1Y3QgdXNiX3JlcXVlc3QgKnJlcXVl
c3QsDQoNCkhvdyB3ZSBzaG91bGQgaGFuZGxlIHRoaXMgaXMgaWYgdGhlcmUncyBhIGRpc2Nvbm5l
Y3QgaW4gdGhlIG1pZGRsZSBvZiBhDQpjb250cm9sIHRyYW5zZmVyLCBvbiB0aGUgbmV4dCBjb25u
ZWN0aW9uLCB0aGUgY29udHJvbGxlciB3aWxsIGNvbXBsZXRlDQp0aGUgRGF0YS9TdGF0dXMgVFJC
IHdpdGggIlNldHVwIFBlbmRpbmcgU3RhdHVzIiBiaXQgc2V0IGlmIHRoZSBob3N0DQppc3N1ZXMg
YSBTZXR1cCBwYWNrZXQuIEluIHRoYXQgY2FzZSwgd2Ugd291bGQgcHJlcGFyZSB0aGUgVFJCIGZv
ciB0aGUNClNldHVwIHN0YWdlIG9uIERhdGEgY29tcGxldGlvbi4NCg0KUGxlYXNlIHJldmlldyB0
aGUgY29udHJvbCB0cmFuc2ZlciBwcm9ncmFtbWluZyBmbG93IG9uIGhvdyB0byBoYW5kbGUNCnRo
aXMgY2FzZSBhbmQgZml4IGl0Lg0KDQpUaGFua3MsDQpUaGluaA0K
