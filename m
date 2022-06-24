Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB39F558C61
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 02:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiFXAo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 20:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiFXAo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 20:44:57 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2053.outbound.protection.outlook.com [40.107.114.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0AC4FC6F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 17:44:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbjKbCl9G8t4o2YXK2IoIWAJ11JKDXziyJ0zvOm62H9YcMJZohZDpswqVgnNwEyUt13kSklCxgDwtoRuFasGM62VcuBwcGE+OJISsvvtAUbiC7LcZUn4cykcL+xBHJYmRgTBA/KHUV0z/YYAJzzsJEqRygcreZ/tweWC6nTopJRk4499J8xe+oKYWOmWgnt22IhwpfiLBC2KQuU2S4vM+zyBlbetF1rm7B8DdYJxsvQ4Ph6wWq+vXrtdhTxy6x7pVjyapx/4U0GOU7FqMHehLq4eKInP6BKtQOjYWVCxlNU/beV3UkwtI4UnBp27XHgG9Nnco/aE1pAHgDAwQ2YYXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1J58ue5mprrGTOBoar4kKvxSdakeNIfudhqS5wIHbM=;
 b=npSA2mDaqEukQkBk1EIawGY4MxvNxgb6An1JEVQNhyGhuIFl2RFg9aHQqaNZG9mh9xBuYIrG5V27v+WZI8ItiLvqj+4DCqLdwKuNMtfB9C5iA2pU/hJtkbrTPFQA2nlpUTsMD2bG2PdFpHElVNOn661zcRkgG0HPsMc1/pTJ6rM7E9xS0SJGKUWqzliPQf+H9d3TBC9+e72TySttEmSiRBjh8p2rFV6sH6rHkNQJMjT5zklGy/f74+mtg6NgwTIOShQ1noeOTrQCZdZ+X9tmrY81PcwroGgTY+0cxx8dJuP9myIquA7my4ac7EmXKo9uaJeExyR5ZCJeAXykHQvy7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1J58ue5mprrGTOBoar4kKvxSdakeNIfudhqS5wIHbM=;
 b=myVlv4AWtmZT1QhN6+Hn5pWId3jxwBCXeJ7oZEsu+6J9iJa1oAHgm6eGXToy4Ge8goPP6ghgShu8C9pzs+6w/3XzM8fg+W2hFhOaOSMDEaA06wwBcTGIalE7rLNXbML9BBiZcJbxUHRL9QizvCeqNUU9Bz61g2Klsi0mPc9crmo=
Received: from TYCPR01MB6948.jpnprd01.prod.outlook.com (2603:1096:400:bb::13)
 by TYCPR01MB6851.jpnprd01.prod.outlook.com (2603:1096:400:b6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Fri, 24 Jun
 2022 00:44:52 +0000
Received: from TYCPR01MB6948.jpnprd01.prod.outlook.com
 ([fe80::41c1:d812:3e8b:87f9]) by TYCPR01MB6948.jpnprd01.prod.outlook.com
 ([fe80::41c1:d812:3e8b:87f9%4]) with mapi id 15.20.5373.017; Fri, 24 Jun 2022
 00:44:52 +0000
From:   =?iso-2022-jp?B?Tk9NVVJBIEpVTklDSEkoGyRCTG5CPCEhPV8wbBsoQik=?= 
        <junichi.nomura@nec.com>
To:     "brijesh.singh@amd.com" <brijesh.singh@amd.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@suse.de" <bp@suse.de>
Subject: [Regression v5.19-rc1] crash kexec fails to boot the 2nd kernel (Re:
 [PATCH v12 38/46] x86/sev: Add SEV-SNP feature detection/setup)
Thread-Topic: [Regression v5.19-rc1] crash kexec fails to boot the 2nd kernel
 (Re: [PATCH v12 38/46] x86/sev: Add SEV-SNP feature detection/setup)
Thread-Index: AdiHYUeDOBniciIDTZqhkiEHijhZ1g==
Date:   Fri, 24 Jun 2022 00:44:52 +0000
Message-ID: <TYCPR01MB694815CD815E98945F63C99183B49@TYCPR01MB6948.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6eef3985-f441-4457-d134-08da557ac03a
x-ms-traffictypediagnostic: TYCPR01MB6851:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7X5bsp+/btKZG/Z/Z1rfDcbt0YP0PwlW7PhkTjZ5LaOYyHAH4onv1CkhRvmqGaVJHPJhCgO1k4EzVOgHARcGNjGkCq2pKgqultZgTNM+szzrtgQ5sbhqRhvRLP1LbulBwB1uznaEtsD8iMB+7oVGXpOFY1i764eHK0zxRsXIalhK1Ttg17IX7S25vhXdeoyU5bk1dp6cJwUFsfjp1szPGho6zxI5KRZwTSAxav7yuoyjUFGkx1dXQDHIdXr9eO1scTooeMZFdqmFFJaGiotYLXCSB+3l9z56mD+vWPLnqcFESIdcWIyHp48cHFjykDdUJBmqX5O5LKC5DjdAJE/p0CXbf4P/Ki9jW+nV1SMX89HFXufn6m/1GyU6btlxDEwd0EDaxgYFH1caPedvzPkaz0w0RZi809OSn58GZj43ct21R9VsAvXiHf1L4qVkLFzveQFTj6X8jycc9S9jcaUDD85M3C1qzcKzde5fdqDc/K8BBFT6MVNVAF4wLgXzQIHyx4Jjv3km0CFBXJ7Fmaq1eAbt5mrx2Ph9jQWOppf83Ex0gbxnLrMTn6Hn73FV+almmXU6rgzPyTOh1ezFQsLeHVKn4NmfdStv/+N/JjGculyMMhuovX4NGj0tzvm7SLIeDSOJF6Sin2TvLYofxmmCvySH+fPccmn8WvEC3uHnV+dgiTnW0OfprwTXQbgFWs6XL2GlrtIQhmR0wQpjRtaFxr3X+SwmcB+RcsKHJAvko9FJugQZ9EdJtXdmbSDKTu5tQ/Z1Cbg16n0bpeNyEbBOx+mDr9c6vTevLgAyWyc0vq8ChzheUb+dwT/jGPBhvZ6w
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6948.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(2906002)(6916009)(54906003)(122000001)(85182001)(41300700001)(478600001)(38070700005)(186003)(82960400001)(8936002)(5660300002)(99936003)(316002)(52536014)(38100700002)(55016003)(9686003)(66556008)(55236004)(66446008)(6506007)(7696005)(66946007)(76116006)(64756008)(66476007)(86362001)(33656002)(71200400001)(26005)(4326008)(8676002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?RFpVTkdvUXpDWHRFdzhZN2xWSW1lckpSVDFQTkV6dVJJWGZOdFhiY1ZP?=
 =?iso-2022-jp?B?U0l5cTVVZVBBV0sxeVk5d0hmQWZKYnljaFhCY3hZOU56U245Ry9HS1Nx?=
 =?iso-2022-jp?B?d2JKRHNUNWF6SmN0UGkzZnJ6Um9aZXgra2REaHUvVjdGTmJObjMrZGpJ?=
 =?iso-2022-jp?B?VkE4eWM0d3l2UDhEUEpsNW5HbVhoVmJBSkxGUkRMZDdGWlIrRVh5L1hn?=
 =?iso-2022-jp?B?NlBHczRiU01RV1MvT1U3MThXbmZjaERNZWQwNGFxU1l2U1ZCRitiU0RW?=
 =?iso-2022-jp?B?dVlFejJ2MnB3RHNSSzJqYjE4UTljTVlNQkxQeURzOHNIZWRJd1ZqY3h6?=
 =?iso-2022-jp?B?OFdxZlQ4b2RBTEp1M2w2eEZDVDhRV0grK2tGdmVhbnNEcUdmUUE5eFE5?=
 =?iso-2022-jp?B?WE9FWFhIQW1wNFJKUytta3l5Y0FXU3JrRDBDOHdjY21yTHNoWnZDRXNi?=
 =?iso-2022-jp?B?K0xVdnJYOVgxSWlKdEd0SHBpZ3pmdmpLaWxCSDByL0dtSnpzMWZIUDM2?=
 =?iso-2022-jp?B?VFVvOWdCZ3NXT21NTjlNUzFDZzUyVDBzUFoyMGVCOGxyMEczWU9pakxV?=
 =?iso-2022-jp?B?R0tiQ3M5cnJHRmZDOWZSTnpVNitKVEJ6TjFNYVpqVGkwalNxNEFqQ2tU?=
 =?iso-2022-jp?B?Tit2UGpleS8xTzdOTUJnckdVbEhiYzBOeTlIR1V2MEd2SndEUUNZaEJO?=
 =?iso-2022-jp?B?bzcvMkpPRW8vR2JKd3VxekVCeGV1cmNneUVTYmhLZStLQ0txYkFQelpl?=
 =?iso-2022-jp?B?ODhCb1NrSEtGd0JOa1ZYb2o0QnlNNW5PU0kzbm1YUUR1Mmc0Z0JiLzV3?=
 =?iso-2022-jp?B?NGpKQUdrVGNJS2JFSDVKdmxvUGV1cEVjcFJSOWRqcjc1TzJZWkFZZzZE?=
 =?iso-2022-jp?B?TkR0MkdmdmQ4SWo2QW55YlNBYzJzemRmU09aSmlrYk9scWgrNW5tMkM5?=
 =?iso-2022-jp?B?Nk1QUTZLRzc5NWZlQ01MTVpick9MN0NJZFdDVkNCamgxdnJINGNCU0Fq?=
 =?iso-2022-jp?B?eGZuR0EzWU9sS29MZ1owUnZyQ3BuNXpMUlYvaEt4ZmR6dlAvWTdEeVpP?=
 =?iso-2022-jp?B?TFplUDhkMWF2UEJ5alovSmJGb1RHQk5IV0ppUkNTVURoL05HcVg1VWNB?=
 =?iso-2022-jp?B?azBWalRXSGJNWVpKUFdlMXEyOXFVWVYvTzN6STFrNzdYQll3dDA1S0ph?=
 =?iso-2022-jp?B?UnBFc3RzYXZIci9FR2RCVk1KQWc0TFZXZGpRcE5MZnRRNCtNeGNxK0hn?=
 =?iso-2022-jp?B?QndYZkp5TUttWDVIZmhvVXZmOS9ZZ1F0WjdVVEQ5NHZKcVoxbU9nR1Y1?=
 =?iso-2022-jp?B?QTUvay83dTEySHdRZDIwdkhGaFllZldTSHk4cHZvOXpybG9LQnBDcVFr?=
 =?iso-2022-jp?B?WlZPQjVsNmg3eXN6RUpmZkJTWTNGeTJzdFQ2bnc4eFhKQmtSRlVGKzdZ?=
 =?iso-2022-jp?B?cXNBMmpKZU0zZDFlN2RLN3ZnRzhMb21GOHA2cjdFczRQeHB4TlozM2Ix?=
 =?iso-2022-jp?B?cENaOXdiVENtV2wwMVNyZnJHU2Z4S2pNM1k1KzZ0dkpOTEIwREhRV1Js?=
 =?iso-2022-jp?B?MjgyRlNsZ1dzTU42SGVhT3M0aEdMUjBRVWdzRThmamNVd0xyQ21rRGNu?=
 =?iso-2022-jp?B?SURUWUNsRDJFRC9yYldpTzIxcnRqVEJESVd2NHAyYzdhdS9XUjdjRkNT?=
 =?iso-2022-jp?B?VHd5T1o2b3c3dG1PQnVGRWN0UmxvN1djbkNPdFovYWRwSkxHL01lS29I?=
 =?iso-2022-jp?B?TldzV0xrVlI1K1lXK0ZLczFKam9LdEtqS2ZMT1dlNFNEWUdVZHBFSlF3?=
 =?iso-2022-jp?B?MjZyRUIzeFB2OTBuZGU5ZFFJVXpxcGNuNEhmNktVcjdOWFNHaTdDbHVt?=
 =?iso-2022-jp?B?R2hCYXBpUEJqQ1NQZDFCRVJrSml4YmNIUTBndmY5amd3akJScE1RNWdn?=
 =?iso-2022-jp?B?bzQ5NHFXVzJhV0JOVW01bngxam01Vy8zRjdFTkpjdkF5L3h2T2NZejVR?=
 =?iso-2022-jp?B?c1d2Qy9hb1NFSHZyWVM2ajZoNW02RWlNaVpQaVhjT25kVFZTUGhwcEJT?=
 =?iso-2022-jp?B?QVVuV1NvUEdyS2JsK0twaDZDK0FsTGhHWVM2a29NYnQ0aGNzNThOM1hx?=
 =?iso-2022-jp?B?SE54R3FmblNyN0dqanUwNkcyK09HNlkvcHM2RTU3U2x6YVJhT0tYajJJ?=
 =?iso-2022-jp?B?Mmg1Sld2djZHZFF3elVhMWFCTUlOa3JNWHI4N2NPUy9jeGhBWWxDMStC?=
 =?iso-2022-jp?B?ZUYzYzFBMzZuRGN1Mk9TVUhRZk1ZV3lDaDMwd1NQRUh4QTZkd1NvYVAv?=
 =?iso-2022-jp?B?SUNNQ1JWbzFoelF6cUM3Mit6dWtOcndGTGJDei9rem1QOTRvSVRPODJJ?=
 =?iso-2022-jp?B?M0FkTXlxd2oyOFFwZXpGSHFjTElNRHZqem13emdiWk1EZ0RzVEU4Zld5?=
 =?iso-2022-jp?B?VlZZaTRDQllqcytEdmd5NXZvb3lSYi9YWHlVMmN6NXpYL2RjYTJENTVP?=
 =?iso-2022-jp?B?b0pyaHdnNjJxa29aQTZ4SEx5SkF6REpVSFArdz09?=
Content-Type: multipart/signed;
        protocol="application/x-pkcs7-signature";
        micalg=SHA1;
        boundary="----=_NextPart_000_00B5_01D887AF.0B5B0290"
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6948.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eef3985-f441-4457-d134-08da557ac03a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2022 00:44:52.5164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WOx4B5uo2YUCDuanVM6uUftUibXM52xv558OyqiH1N6uOACX3kkBKucfyohk/7xj6C5JmmUnPRhF93IlIFbBJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6851
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_NextPart_000_00B5_01D887AF.0B5B0290
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit

I found crash kexec fails to boot the 2nd kernel since v5.19-rc1 and
git bisect points to this as a bad commit:

  commit b190a043c49af4587f5e157053f909192820522a
  Author: Michael Roth <michael.roth@amd.com>
  Date:   Thu Feb 24 10:56:18 2022 -0600

    x86/sev: Add SEV-SNP feature detection/setup

    Initial/preliminary detection of SEV-SNP is done via the Confidential
    Computing blob. Check for it prior to the normal SEV/SME feature
    initialization, and add some sanity checks to confirm it agrees with
    SEV-SNP CPUID/MSR bits.

The problem seems to occur when find_cc_blob_setup_data() walks setup_data
chain.  If the code is modified to do nothing in find_cc_blob_setup_data(),
the 2nd kernel boots fine.

On my system, the chain of setup_data looks like following on regular boot:
  setup_data: type=0x3 addr=0x9e9e5018 next=0x9e9dc018
  setup_data: type=0x3 addr=0x9e9dc018 next=0x9e9d2018
  setup_data: type=0x3 addr=0x9e9d2018 next=0x8a27b018
  setup_data: type=0x3 addr=0x8a27b018 next=0x8a218018
  setup_data: type=0x3 addr=0x8a218018 next=0x9e9a0018
  setup_data: type=0x3 addr=0x9e9a0018 next=0x8a1e6018
  setup_data: type=0x3 addr=0x8a1e6018 next=0x8a1b4018
  setup_data: type=0x3 addr=0x8a1b4018 next=0x8a182018
  setup_data: type=0x3 addr=0x8a182018 next=0x8a056018
  setup_data: type=0x3 addr=0x8a056018 next=0x8a020018
  setup_data: type=0x3 addr=0x8a020018 next=0x89fea018
  setup_data: type=0x3 addr=0x89fea018 next=0x0

OTOH, it looks like following on crash kexec boot:
  setup_data: type=0x4 addr=0x2e000000 next=0x0

Other places that parses setup_data uses early_memremap() before
accessing the data (e.g. parse_setup_data()).  I wonder if the lack of
remapping causes the problem but find_cc_blob is too early in the
boot process for early_memremap to work.

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.


------=_NextPart_000_00B5_01D887AF.0B5B0290
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIISxTCCA3Uw
ggJdoAMCAQICCwQAAAAAARVLWsOUMA0GCSqGSIb3DQEBBQUAMFcxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMRAwDgYDVQQLEwdSb290IENBMRswGQYDVQQDExJHbG9iYWxT
aWduIFJvb3QgQ0EwHhcNOTgwOTAxMTIwMDAwWhcNMjgwMTI4MTIwMDAwWjBXMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEQMA4GA1UECxMHUm9vdCBDQTEbMBkGA1UEAxMS
R2xvYmFsU2lnbiBSb290IENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA2g7mmY3O
o+NPin778YuDJWvqSB/xKrC5lREEvfBj0eJnZs8c3c8bSCvujYmOmq8pgGWr6cctEsurHExwB6E9
CjDNFY1P+N3UjFAVHO9Q7sQu9/zpUvKRfeBt1TUwjl5Dc/JB6dVq47KJOlY5OG8GPIhpWypNxadU
uGyJzJv5PMrl/Yn1EjySeJbW3HRuk0Rh0Y3HRrJ1DoboGYrVbWzVeBaVounICjjr8iQTT3NUkxOF
Ohu8HjS1iwWMuXeLsdsfIJGrCVNukM57N3S5cEeRIlFjFnmusa5BJgjIGSvRRqpI1mQq14M0/ywq
wWwZQ0oHhefTfPYhaO/q8lKff5OQzwIDAQABo0IwQDAOBgNVHQ8BAf8EBAMCAQYwDwYDVR0TAQH/
BAUwAwEB/zAdBgNVHQ4EFgQUYHtmGkUNl8qJUC99BM00qP/8/UswDQYJKoZIhvcNAQEFBQADggEB
ANZz53xPdtCNv+y6or40xSgytXz8bJwsK70JnlO/a16qEUi25Qijs8o9YU3TRgmzPsOg42NVG/K6
76054UO5OKPmL4omO++gUFb5xgr9OM3EC3BRlJeYBN/DX5TVFckUQZzEXXVkFQ3/VTDsho//De8s
uWNG9qr837xp/S4SSGSa4JXwpu8pjwGxFbUMHaX+aSxpJHges6cccWLuysiXrBddisL4R4ZuKsRW
MZXQZ4mFK/lspl1GnQyqguSZUd1wt9tWPWHkauFc1vb+Pd5BzAeuY1K/U1P0K+nH/bb3gl+F0kEY
24GzBBzFH6SAbxUgyd4MiAod1mZV4vxIySkmaeAwggROMIIDNqADAgECAg0B7l8Wnf+XNStkZdZq
MA0GCSqGSIb3DQEBCwUAMFcxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
MRAwDgYDVQQLEwdSb290IENBMRswGQYDVQQDExJHbG9iYWxTaWduIFJvb3QgQ0EwHhcNMTgwOTE5
MDAwMDAwWhcNMjgwMTI4MTIwMDAwWjBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
MzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMKR2xvYmFsU2lnbjCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAMwldpB5BngiFvXAg7aEyiie/QV2EcWtiHL8RgJDx7KKnQRfJMsu
S+FggkbhUqsMgUdwbN1k0ev1LKMPgj0MK66X17YUhhB5uzsTgHeMCOFJ0mpiLx9e+pZo34knlTif
Btc+ycsmWQ1z3rDI6SYOgxXG71uL0gRgykmmKPZpO/bLyCiR5Z2KYVc3rHQU3HTgOu5yLy6c+9C7
v/U9AOEGM+iCK65TpjoWc4zdQQ4gOsC0p6Hpsk+QLjJg6VfLuQSSaGjlOCZgdbKfd/+RFO+uIEn8
rUAVSNECMWEZXriX7613t2Saer9fwRPvm2L7DWzgVGkWqQPabumDk3F2xmmFghcCAwEAAaOCASIw
ggEeMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDAfBgNVHSMEGDAWgBRge2YaRQ2XyolQL30EzTSo//z9SzA9BggrBgEFBQcBAQQx
MC8wLQYIKwYBBQUHMAGGIWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL3Jvb3RyMTAzBgNVHR8E
LDAqMCigJqAkhiJodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QuY3JsMEcGA1UdIARAMD4w
PAYEVR0gADA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0
b3J5LzANBgkqhkiG9w0BAQsFAAOCAQEAI3Dpz+K+9VmulEJvxEMzqs0/OrlkF/JiBktI8UCIBheh
/qvRXzzGM/Lzjt0fHT7MGmCZggusx/x+mocqpX0PplfurDtqhdbevUBj+K2myIiwEvz2Qd8PCZce
OOpTn74F9D7q059QEna+CYvCC0h9Hi5R9o1T06sfQBuKju19+095VnBfDNOOG7OncA03K5eVq9rg
EmscQM7Fx37twmJY7HftcyLCivWGQ4it6hNu/dj+Qi+5fV6tGO+UkMo9J6smlJl1x8vTe/fKTNOv
USGSW4R9K58VP3TLUeiegw4WbxvnRs4jvfnkoovSOWuqeRyRLOJhJC2OKkhwkMQexejgcDCCBQ0w
ggP1oAMCAQICEHhKqRA/pb++3nUIsTSTHQAwDQYJKoZIhvcNAQELBQAwTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wHhcNMjAwOTE2MDAwMDAwWhcNMjgwOTE2MDAwMDAwWjBbMQswCQYDVQQGEwJCRTEZMBcG
A1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29u
YWxTaWduIDIgQ0EgMjAyMDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAL2wplwnLG2f
2tH0SEDAcaeICZ58np3hWKRLTcna2WfhnikjHR4g4Fw9VJ0UiLnSqPpqEOmJQjruLa1VjvxIl32J
yu83qKduq8tUaSraIAe/ztdec7pbQM+uMnUGC3vmtXv3M5AC4N7IE3DjnBWU15N/HmqrF7IqaF9b
7Dbq6j7Zwtu01rAO6ZOLil7HBY5HlBPCWbvQQymrMGcoMQTjwUAcKwOfttFsZZOpNXuhCmmjWjWV
Mt9KtwKxH99GQ6V8nwrYl57qY0ivFlNnCuKrBLY9PSUuPpoYtAkwqwp1wM7pt7YHB3B0YNKa3Es8
xFA0FqBccrqsIsIR7t7D0DZhTjMCAwEAAaOCAdowggHWMA4GA1UdDwEB/wQEAwIBhjBgBgNVHSUE
WTBXBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQBgjcUAgIGCisGAQQBgjcKAwQGCSsGAQQBgjcV
BgYKKwYBBAGCNwoDDAYIKwYBBQUHAwcGCCsGAQUFBwMRMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYD
VR0OBBYEFJYz0eZYF1s0dYqBVmTVvkjeoY/PMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i
3Ru8MHoGCCsGAQUFBwEBBG4wbDAtBggrBgEFBQcwAYYhaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5j
b20vcm9vdHIzMDsGCCsGAQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2Vy
dC9yb290LXIzLmNydDA2BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29t
L3Jvb3QtcjMuY3JsMFoGA1UdIARTMFEwCwYJKwYBBAGgMgEoMEIGCisGAQQBoDIBKAowNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDQYJKoZIhvcN
AQELBQADggEBAHQF5P1wpw3gDnfZzRFL1j8W5TkP+aP6ujiHk2L6BL1FItqh1DrW34wRnU6bRbF1
3uEYI1RfW+g7os4GH8vnCC5r4uYX5NyKvDAGbILVvgP6LULCbytsEWrSxOtUW85F/PfzlxGdc0+7
f6tkYias6b1fDQocSI/j+1k7XqT5vQCI9CnrnvoEtqr8wGQGN+GWXkR4AO4OTuEzyf6E3fuK4IlP
vsCw5XGWHf7JRZGk98YOKlg3qRDI0+E9ahTkCC/oo1AK2EuKMKT4PTSEkymtaqiliYxaMprNHdBs
Dp4iCGwb4SNjCewUmPTGLVlU+YyTt7bFR8I+HKfdgkhbhsLpxTMwggXlMIIEzaADAgECAgwO+efB
Kgmslz77fEQwDQYJKoZIhvcNAQELBQAwWzELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNp
Z24gbnYtc2ExMTAvBgNVBAMTKEdsb2JhbFNpZ24gR0NDIFIzIFBlcnNvbmFsU2lnbiAyIENBIDIw
MjAwHhcNMjExMjA2MDUxNzI2WhcNMjIxMjA3MDUxNzI2WjCB7DELMAkGA1UEBhMCSlAxDTALBgNV
BEETBDExMEExGTAXBgNVBAwTEE5FQyBHcm91cCBNZW1iZXIxDjAMBgNVBAgTBVRva3lvMQ8wDQYD
VQQHEwZNaW5hdG8xGDAWBgNVBAoTD05FQyBDb3Jwb3JhdGlvbjEnMCUGA1UECxMeTkVDIEdyb3Vw
IFN0YW5kYXJkIENlcnRpZmljYXRlMSgwJgYDVQQDEx9DQy0yMTQ5MVAzMjEyMzAsIE5PTVVSQSBK
VU5JQ0hJMSUwIwYJKoZIhvcNAQkBFhZqdW5pY2hpLm5vbXVyYUBuZWMuY29tMIIBIjANBgkqhkiG
9w0BAQEFAAOCAQ8AMIIBCgKCAQEA4Xk01AQsJLT0nBNqyIrzkwP2bWrpCq74yoIHLzvyqQrgEU2C
VYazZwQR2dRDP6tLhz83LrgJpIke1INa49/BLUJp9FAfPVTCZb0j4kftbCj5R3O/JHFpDy//9Cx4
9osgejC+Y0HmP5onVmEe4tKxG3hBFoVhLyUU+LhusvQ7SRrjYU4Bj4qjv1rhUZLzAas69+B73ehF
dA0c+fBZ3V+eAWQILmGSkbWc3uXZWK5pR0cB2ZJxC2eLlMCMdWNVyZxbt+aTC2R4Sw0FQ/iuf/4F
Ar8qFoBevR4qmyZq11asIidufyscWOhplGshENi7+rzYTd1HioynChC67q+rL0K86QIDAQABo4IC
FTCCAhEwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0
cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIw
MjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVy
c29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYm
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8E
QjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwLmNybDBJBgNVHREEQjBAgRZqdW5pY2hpLm5vbXVyYUBuZWMuY29toCYGCisGAQQBgjcU
AgOgGAwWanVuaWNoaS5ub211cmFAbmVjLmNvbTApBgNVHSUEIjAgBggrBgEFBQcDAgYIKwYBBQUH
AwQGCisGAQQBgjcUAgIwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYE
FLri8sCe/FVMIHLIr512r1mpmJmEMA0GCSqGSIb3DQEBCwUAA4IBAQCMiqvivcAx1ZHBbcdmA7/z
ZBddJ+hSWAmZE26ZTWksq+WvzX1get6KGMu+6f/KqrBcxCukH+ajNIkaFcJFh0uoJEkbhXzvyqY0
RbFVAF7OF6bC7kySTjLQUB3c1AzfAgl8/JyYf5s2kjNVqP3FqDUkW0zGa5+LOzXhfy9NBLy1ZciL
JAFB1rSkRfRiIBUZaQS0P7qwRSMu/8NckySUoGbE1Yi20dCdKRyUgAoGnhr3mVJ0MNSHwr9FTDPv
eaL3cOR0P6Qr9lE2qmHvfRJQWxW3ufPiaTeC9o0NWDW7tcLDVTrYjavXMMR0yaIr9R7XJka/hMCp
puI9qbISANymP36AMYIDgzCCA38CAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFs
U2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0Eg
MjAyMAIMDvnnwSoJrJc++3xEMAkGBSsOAwIaBQCgggHtMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTIyMDYyNDAwNDQ0OFowIwYJKoZIhvcNAQkEMRYEFOAcXLDelbOi
XFkD7pZ/lC4i/UqFMHoGCSsGAQQBgjcQBDFtMGswWzELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEds
b2JhbFNpZ24gbnYtc2ExMTAvBgNVBAMTKEdsb2JhbFNpZ24gR0NDIFIzIFBlcnNvbmFsU2lnbiAy
IENBIDIwMjACDA7558EqCayXPvt8RDB8BgsqhkiG9w0BCRACCzFtoGswWzELMAkGA1UEBhMCQkUx
GTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExMTAvBgNVBAMTKEdsb2JhbFNpZ24gR0NDIFIzIFBl
cnNvbmFsU2lnbiAyIENBIDIwMjACDA7558EqCayXPvt8RDCBkwYJKoZIhvcNAQkPMYGFMIGCMAsG
CWCGSAFlAwQBKjALBglghkgBZQMEARYwCgYIKoZIhvcNAwcwCwYJYIZIAWUDBAECMA4GCCqGSIb3
DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCGjALBglghkgBZQMEAgMwCwYJYIZIAWUDBAIC
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCfm5BQQqmvzJBsEcSCuT0jNE7OGq+tktK9
bMAa2oS6pTUNlkliYeXKKFl+rPwXvCusa5jNR7ZB89gkCyynxNsaEBgL+vPqYzdBxajEGFeGfDb6
d6GMFLrBwglJGCzAvrSnZlT+gtGvGuMsJPF6lzuJA4LafoXeR9OGjJyvtRjJlUBCml6GnTtpmobE
P8DqgD0TOR/tVlhJtOou6W+n1UljXCt4w89tOLv83h4c4ru0wKzHRcgSSQFLf95YsNPGVdo/C11H
2+e9rt0zZW/wThFQR1Pb9AGW0NwJY3YSt5JkcSHsb3R6ikeTll5EUo9sThuAR9Ssazi2sxxw6gLt
GQrdAAAAAAAA

------=_NextPart_000_00B5_01D887AF.0B5B0290--
