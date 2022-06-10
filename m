Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761E75468F6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 17:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242196AbiFJPEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 11:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237609AbiFJPEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 11:04:35 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9D32AD4;
        Fri, 10 Jun 2022 08:04:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irPbRPC22O9zH+n3neGi4jHlNX6sV0SF28MRGb6QTP7Vz8jBaBLNDGAsh0hSnsSVz3YCe3xiY3oufRp9AU20xlk7v7jNMR2e80r9TPkOn/QOKRg5P++tcDhfdCtddrSH1zNrS/HiPrwo7/VVVynIfTKX6LmgAuhHGeENy07DOoy1dNMhMF8PsHwPA6zJCQJ4UEu8J7YoH85psxcSDbDbQsFgRiZmLE00Fs7vIdoQMjI3BDkDAe7zTPzjgpSKAUQuSLLOQaYuc2luWfOsOfWQyMBeGUNXXNFUS7vsegmj4v8LlzL1xmpkgsQqZrLmy7RUynNm6n8CuJUXCEYXftPX3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEwKE5g/3W8HATNgY5SzOnlRZ9S3Vv/RbxMFbI/WjgQ=;
 b=SCZGbQ0Fj1d4d0nV5Yz7XSGOUKhRhJZr292C/SHcT/rjraVwALoIfU53bJQ9Kiw0z+xd5kc7Hzjwe9QvY6++Q7ruj0MKMTYqW+e7kvMMABiyv+7ZZdUTG1VRW8ritHmXfKSx/XFv8Aaa4amCtm6K7o4flzXUtFrPvMPfwZy7VgNenFFy3+FwEpICIqGMEmq05w9SZpqzkJSfi5Q534nXochAbnNk7shEgvpW2SPxkCE8Yu2+mOmk5Yi9vsZ4J/rq1GzlzWbNbyl27qq72D70NMZ+dp7oEaEQDG6DUJRs84BqwYpMROLWyUOnEJly55h/zbjuiL6J4RVxbCFHKzn3jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEwKE5g/3W8HATNgY5SzOnlRZ9S3Vv/RbxMFbI/WjgQ=;
 b=OyiwulDGFL/NrFbEXUA3WbCeJuFRvSgK+buT5GUE3fBleG7pBMs5xzHkzOZ7czKdjgzFglVKBHUF9SLAuw6UyVEUv24nyvUc3xegCJwr9r6bxT9h7NNnWdFJw6RK9tQQj4vpv3Ttz6SzI+khOiKDoOcFXL4MBs24QokS5isesp8=
Received: from BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22)
 by CH2PR12MB3656.namprd12.prod.outlook.com (2603:10b6:610:15::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 15:04:31 +0000
Received: from BY5PR12MB4033.namprd12.prod.outlook.com
 ([fe80::7c94:bf5f:eb5e:f3fe]) by BY5PR12MB4033.namprd12.prod.outlook.com
 ([fe80::7c94:bf5f:eb5e:f3fe%7]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 15:04:31 +0000
From:   "Neeli, Srinivas" <srinivas.neeli@amd.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>
CC:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "sgoud@xilinx.com" <sgoud@xilinx.com>,
        "shubhraj@xilinx.com" <shubhraj@xilinx.com>,
        "neelisrinivas18@gmail.com" <neelisrinivas18@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git@xilinx.com" <git@xilinx.com>
Subject: RE: [PATCH V7 3/3] rtc: zynqmp: Updated calibration value
Thread-Topic: [PATCH V7 3/3] rtc: zynqmp: Updated calibration value
Thread-Index: AQHYfL5/bKwsucXXi0SZW6Rgy02ZOa1IitOAgAAx+jA=
Date:   Fri, 10 Jun 2022 15:04:31 +0000
Message-ID: <BY5PR12MB4033DC535FF8B1230D5E860493A69@BY5PR12MB4033.namprd12.prod.outlook.com>
References: <20220610113709.2646118-1-srinivas.neeli@xilinx.com>
 <20220610113709.2646118-3-srinivas.neeli@xilinx.com>
 <YqMzK50DbPAm1+dl@mail.local>
In-Reply-To: <YqMzK50DbPAm1+dl@mail.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=af0c8305-f4dc-4fba-a063-00007eb17ae4;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-10T15:02:48Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 850d9ae7-7d46-4850-7cba-08da4af285eb
x-ms-traffictypediagnostic: CH2PR12MB3656:EE_
x-microsoft-antispam-prvs: <CH2PR12MB36562464968B72AB4BDAD5C493A69@CH2PR12MB3656.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uMm8hrHkymifeOm1k6vY0h8m29KCQK2b2IvNO0ry20Vl9tqewyZ5nWFntxyTIi3GRFzehm3OOdvWwsjE9SYq8tgJ0rptls2uaVLxf4lLys75cg4Zwr3O1rEnYPhHQmxSCQmEncNDnfXM3DCbvko1XHWbXJpyNxvlS6aE8d9nfd8lidtGcfXFHKFWnYzs5Dzb7Mf8+d2mvRwOoCglIF5mmMwwSFfSK28LjYOSD9bcMNE3ELYk5G86XR03S7RMfMq48gjLV6ilcjcmvuGlBEj9xRW4S5p5q62M2O3odeC04BY9tEmrWJ6rt6AcqFAJ+zsKQbXD6Ihs8pTQiwg90YDED4e8anmDdRvMWpXl0C950wjgQxQK3O7E+P8wr0rmUitTJbLJLsXPcrfKSF/RpSY6s8zLCOVpyEGA5QWef+AW2CV8wf4USfxv5NetSHBicejhu3Frek3PloOrA4qE/9rmmEDoCugx0k9KRkmO0l/SY4JDOCIXL6VRM0hX4H6A3DwPgHhqkWvEF9QOcfmOvPimqZLQWMa036xrKAEp1ELM1kEBURR7u68ZLT7p9Ou4g+m2Q5LzLGdCCL/AZ+lLSyENQLVhLox8JSMFIQSNx0vPzZTm6WErNLReyPyFVtKZFRS9NRR570OTZFQE3aDAqiZs9N2zm7yVIyyPtmetCObw8d0/iWRkdoIF8BWBOuafapUMKibYMhRFQZkMQLDK6KodNRqlMlzfWRde6dlWEcGVDm10wqhJs4pkircRlBtUJZ5XpgHRC2Fm7O43nNEYAB9jAbIddvhSrKhN9gI58ybZt8I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4033.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(122000001)(38070700005)(107886003)(316002)(2906002)(110136005)(54906003)(15650500001)(6506007)(55016003)(71200400001)(966005)(86362001)(52536014)(186003)(5660300002)(38100700002)(76116006)(33656002)(8936002)(66946007)(7696005)(508600001)(66556008)(83380400001)(53546011)(55236004)(66476007)(66446008)(64756008)(4326008)(9686003)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sPlJ793LHMrW4sjf5NSF2zFRbsr+lDSf0KN8S1FKO6abGG+xJQTIXU0Pgeda?=
 =?us-ascii?Q?4gaMkDeWSs0F5Jrv9ZXFz/k0p7OF8z966bAF2/7vKgdUBjqVyV4PeVqho5wi?=
 =?us-ascii?Q?ClXwZjt2NejQhbokGcxxOIUI/MSkofm9vR0S4Bi4jYEQYq/oSAqT+kkA+4ZH?=
 =?us-ascii?Q?//D21AMk7jxBbFWn1dIjlf/rGFynsTxqs4b5fklXlfr19K9mt1TY7+LxlGmi?=
 =?us-ascii?Q?4jAWRtPu6XklPI/Uslxbw9cUyLtjQIy2IwEpNfXM5aM+kE36tGMVZv/AXghV?=
 =?us-ascii?Q?38bkMBijGg8nX3QclIzkaNp6q8kUx8QVBcwamPpcM3rsXd3UgHSGId4rukjX?=
 =?us-ascii?Q?oFf8hog2CO5hTASlWUVIVidUjvSt7L7eTL3wINHPJ78SnSC/zXmfQ4tLn2wW?=
 =?us-ascii?Q?kdXOhiwI1TTwA/A7K13+7OOv5H95a5bsfLt9HMgyViA3ZntCuycwHhd9OwGf?=
 =?us-ascii?Q?6L4KIzAlKKhCE6pIpNWt3QwmeCXb9c8+ixD+Rw3+MpIGHr66LbHRlEhs7acZ?=
 =?us-ascii?Q?7IF8u5CgeBSiLlnGMDWvzBDo7kXyliHoRxC61hTUA122QtsvMMKiIN9JvwHV?=
 =?us-ascii?Q?tLilQLzygrThK5hCE+TmQTn1OTREcefx2TtZ4lSsZXLBOrumwcdEh83MAMle?=
 =?us-ascii?Q?u0QLSu/3KUHL6YLpio+ShXD72NFDZLSQnbfzNTgE+vnJtL5ZTJrsZjVRRGU/?=
 =?us-ascii?Q?kIIIciIBvzkmZKY5WxkLHmMcDfRTJtn8ALSm/mWu6WfOAu7Bn+JLlXaA3K8s?=
 =?us-ascii?Q?qrwecbRaXfUpPLumAqCVXf3z6OKlKoEbawNT5jHIm2IwmxKf77fayENvjYRw?=
 =?us-ascii?Q?XECOWGgA+eJwWXy5p6oNArvdL8k2OrI4U8QmSiUwuCT74oIrqgyCv8U+BB2R?=
 =?us-ascii?Q?FWmKVufvjMcLpwy0eSPf7TtEawZJKz91/zQbJT1HVmYf6EPcSx7g0XT5TqGw?=
 =?us-ascii?Q?tFcfe9G82EE/go0vtCHJoqJNo96wa1HNmdYfVYdil/txCZTdCmiajFj/yITC?=
 =?us-ascii?Q?UgeQLad7e49q8af94rnv0xFc6cROpLHGaef2RpCcfaiffOVg3r4bNwHaIurl?=
 =?us-ascii?Q?+o4LXVP0Dt0DN4YUvFJxwIhOeUzCd6Ag1D/sDGYDxyK+gFQsmx2ggTABa7pK?=
 =?us-ascii?Q?5TrhFmujuzKO+Whzd1Up19KmiTDuutg1o8sIJw+d/hZvLLRCuktiyXcmV9Jf?=
 =?us-ascii?Q?PeEhhtSEMNtf5zg0o+B+nH8JGsNfSMvXQQscA97soOjzO/2GV0A2KkT4/fQ5?=
 =?us-ascii?Q?G5cY+omlYVWhXxRjWRvCaUQ8oDAykNX56489EnClk8UGKpzLqnJtdndMfUCq?=
 =?us-ascii?Q?MQa58E9o5zaGnB+fP4EdklSUXiddP2N+g9y3+pbBqdQImdkHeVDZU4p2byjU?=
 =?us-ascii?Q?HERPQTaiylDFAYa7QqgK7940Ksfqy0KC/ip+m0HwxGQ3jOxFCQ8hKv5MZDp2?=
 =?us-ascii?Q?2117XOINXtEahw4BdZw5T299yT3IMDIeZh6TDBUW2Q1J7DN33dkZWLc4x15R?=
 =?us-ascii?Q?E6BbaemfJHAxruAqNcumEKTmDgFFj6bgBr0xORB1+a54a5qglprMeESN+4Ke?=
 =?us-ascii?Q?1vzC9XbkzIdbXTF+bbc/jWYuFSkKskU41+OjJ6w995bEMUSwJ6qLnbFwpDsO?=
 =?us-ascii?Q?6mngd0PHzy4401FJffEYgzRk0uMAVqKJ7kzqlVKDwlv4O8fMhUCxSCU4AlsL?=
 =?us-ascii?Q?/6kvD+i227L3SndOpHXvBLf1wrj0KIf5l/M57OAmxH4wSDCA1xpg1in+AUjN?=
 =?us-ascii?Q?dd4VKa2VFw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4033.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 850d9ae7-7d46-4850-7cba-08da4af285eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 15:04:31.5221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uTcdVLAaJsDZof5Ot4ghNLDM52Rz5hUeVN/sbEJAvoTCAPgAguJhkj+ZgJiizQIY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3656
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

Hi,

> -----Original Message-----
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Sent: Friday, June 10, 2022 5:34 PM
> To: Srinivas Neeli <srinivas.neeli@xilinx.com>
> Cc: a.zummo@towertech.it; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; michal.simek@xilinx.com;
> sgoud@xilinx.com; shubhraj@xilinx.com; Neeli, Srinivas
> <srinivas.neeli@amd.com>; neelisrinivas18@gmail.com;
> devicetree@vger.kernel.org; linux-rtc@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; git@xilinx.com
> Subject: Re: [PATCH V7 3/3] rtc: zynqmp: Updated calibration value
>
> On 10/06/2022 17:07:09+0530, Srinivas Neeli wrote:
> > As per RTC spec default calibration value is 0x7FFF.
> >
>
> Having that as a second patch breaks the calculation in your previous pat=
ch,
> really, this should just be a single patch.

Can I swap 3/3 and 2/3, Will that be fine ?.

>
> > Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
> > ---
> > Changes in V7:
> > -New patch
> > -TRM not updated yet, Internal design document contains 0x7FFF as
> > default value. TRM Will update in next release.
> > ---
> >  drivers/rtc/rtc-zynqmp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c index
> > 39b23f88ee26..1dd389b891fe 100644
> > --- a/drivers/rtc/rtc-zynqmp.c
> > +++ b/drivers/rtc/rtc-zynqmp.c
> > @@ -37,7 +37,7 @@
> >  #define RTC_OSC_EN         BIT(24)
> >  #define RTC_BATT_EN                BIT(31)
> >
> > -#define RTC_CALIB_DEF              0x198233
> > +#define RTC_CALIB_DEF              0x7FFF
> >  #define RTC_CALIB_MASK             0x1FFFFF
> >  #define RTC_ALRM_MASK          BIT(1)
> >  #define RTC_MSEC               1000
> > --
> > 2.25.1
> >
>
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
