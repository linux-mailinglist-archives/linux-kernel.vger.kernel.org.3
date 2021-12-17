Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99827478385
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 04:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbhLQDKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 22:10:19 -0500
Received: from mail-bn8nam11on2057.outbound.protection.outlook.com ([40.107.236.57]:42124
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229471AbhLQDKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 22:10:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOdrm43kJ0Bg8G9Zg4snbZt+lYQUmUSxWuDaW7AlDjBN3EevaRn838UZu30qvAHCi2Dr0UCdaxIr6djdWR1eEmTNlzFq+9HCJ9iH4VDC6yh7s+PFlMJblTfl8nRGY83MoLV20QoID4nHm0iukUs2e8xIUmtFwnGPznczMPR9K2P6opm6CpXoi4sDn3Qfj0lMd9UCublmfSjivwfSEx8irdaeLqlKNmfzNnAAwSsHzvAA3PkWe77HIcRgqh0NTlx3yUv44xOCPxCCZE285Wyyi3nuj5nZsAewSOSvqXNiBvfZOvoF9djUBiiyIYdFytyUz+qLBq/V3U4m/hOODwaWPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GceMpUy38Fqb/g0ghoLpdRigWAfxedSckTXA3vAQwo8=;
 b=h0ePJkKyF6MbamItRwDgchsEHO+KiMXQIyjrW2SUjIEFS7iF4pOUrdS5WYtxY4fmdXT+eOjCsgg6vJptG38qRK44IH2/IE+wqhAd/OYRIJS5cAxTXQMrlA/QvOlKJmTuNu/s+K6+Paxo15U799rN/Rh1yBxvb+wSQbjbERJiEKIQBg7+A04p7soeeN4j84KY2+5a/gqULc3rBjM22bBnroyycMPa3CWMDAd1JIaun5gULsVJazqF5FD0EWeRDxn8hT1rgb9SemF9jvLa+R3lcv3F19/uPS7OEhjsolCh14uXR07u2bn9u3NhaMjMgYBGZ0YHc7d5AHRNNXlLsZhsJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GceMpUy38Fqb/g0ghoLpdRigWAfxedSckTXA3vAQwo8=;
 b=ulBMyoUzchtD2eDXCRMnfUSxOfafLOrAohsG+w8agmXKoxHa0/VrtwHODEosRU5CQaPanBzOthbzPtdHpEdMN8K5jwaEYJyVTdi7UWl08BKaHBYk8Bp8tnSDiHejj1UsFR0g3I6nOe0tYe3izp2dRMzFRAA3W+xgY/dxGQ+OERw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM6PR12MB3468.namprd12.prod.outlook.com (2603:10b6:5:38::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.14; Fri, 17 Dec 2021 03:10:11 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::5d07:e475:316c:d187]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::5d07:e475:316c:d187%5]) with mapi id 15.20.4755.027; Fri, 17 Dec 2021
 03:10:11 +0000
Date:   Fri, 17 Dec 2021 11:09:43 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 02/22] x86/msr: add AMD CPPC MSR definitions
Message-ID: <Ybv/dyYTubBaC5Ay@amd.com>
References: <20211130123641.1449041-1-ray.huang@amd.com>
 <20211130123641.1449041-3-ray.huang@amd.com>
 <CAJZ5v0i_nE_LnpgkeFLscoR5fGtzCxrV8Zdon7y=Kod_SuFqtw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i_nE_LnpgkeFLscoR5fGtzCxrV8Zdon7y=Kod_SuFqtw@mail.gmail.com>
X-ClientProxiedBy: HK0PR01CA0063.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::27) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
Received: from amd.com (165.204.134.251) by HK0PR01CA0063.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::27) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Fri, 17 Dec 2021 03:10:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a46d0f9-16aa-4867-64eb-08d9c10abc81
X-MS-TrafficTypeDiagnostic: DM6PR12MB3468:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB346858B70E9F4D7D4E850132EC789@DM6PR12MB3468.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AsfmzyyBbu8Q9rnenfZOU0NgAnbj/cTZjDPap8YxJQC2dZSdOKg5pqRtGDgpKAB3cTitOKoEMP5v7VCbbH4J3/G76cxQNvtJt7Xw1hLhcbdi1c7mAEsUlkebTcZZ7vy96sTNoeYRcQc2qJYW+2F22zBmcZEmzj9B1aPOPM7sopgpIVM95fFbGSr5BQJ61OoGTcbX2g3Y2qf6bvPGESqsRzP1jpVmGhW2i35gc+18Yxn7WTh2/ElGMXFbeRFQm454YtA97Ff/rj8iFKBE/NL6n5ibykXEd14+bMaN3YW9EcWYMoJ647CnmtMPmpW9eWbFdmyWUDni3/zEogDly52hp+sIwHvJmQp8VnDvcmUdTd/fI+DpLfqEXMz4S+HIuTB4QJIwKG35VjRHTVMfXw8UJ32flOwKYHdxdRwlcg5Fd04n9CfEDJb3v4ATo/66x4feAIFMQ28tTuuFM/oc8bCe0Y5TNn7On+eGrmS06DWRyX9WIHrEapQE7fnyv/TOAHjD4utKzDO8Ou93A8CtllmdeUxeMSPuOx6nAk1KSZOysLv+WJE1XggMsOHyMLXKXUn+MGWSHl81yYD+FVXZ/CRSrR7SYF5CjVrlkNARwy5Be0nqrKnqLoLqw8rkoEsFsUqUnZFkj2H1FA4HmfwpNFz7fJEDHbUfQn2n5Aj/WaVUt5eMJCoYnG2hchqHPz6jDazCONT68zbFfDS8meWwoIzOHZp5+KaWrRaGgHPGAkaNiok=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7416002)(956004)(2616005)(54906003)(66556008)(2906002)(508600001)(110136005)(86362001)(316002)(966005)(66476007)(38100700002)(66946007)(26005)(53546011)(4326008)(186003)(8676002)(36756003)(8936002)(6666004)(55016003)(8886007)(5660300002)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EHcRj2iqfg+4rdAA1dd0tk9OgxWPOG2Q9R7OqM40ZN4cyd+HPe2YIazhA5yP?=
 =?us-ascii?Q?slXcRAPseQysTvUvUylRCSPxTwf5xwb4lkYDHeInHSxu0ZDeMGq/Zz3p+j7i?=
 =?us-ascii?Q?OgmzWMG75M2Ui1YJIiglBqTZKUsEzqf4WsUNog27wvZ6z2DvkHX4Yh+DcQYP?=
 =?us-ascii?Q?q+FIkefAaollHdgMxeo2DCBbeH5fFtL+lUnv/HSw4uUyY9sSCANVInOee5J1?=
 =?us-ascii?Q?YVnuv+SD9LKOyiOSDyb1/CtdxKSQ8w6uIckrwg9g8k1r7Txd/4OQyHfdLi9l?=
 =?us-ascii?Q?fIBFaBEi5E5TbPJnoFLFHUMPUbly7DeGPIi9hIK2gzgdSblw2FWUfoEvyWOk?=
 =?us-ascii?Q?f6wLs6A5ztGpgPIJK6VdQdTbXvupCOGXJB1rnRS743LC8oBKpN/eSz/04ZBG?=
 =?us-ascii?Q?wEGW2rob6Eh7SMaztZDG71s3IDm/dr3IxUkNa7eLM3LrSp+DUysev//fB4fO?=
 =?us-ascii?Q?KBeJYH98essGgjZkRRYAQRlGlkHK44p1o9U8iy3mlun857lOpo026GxG6L+h?=
 =?us-ascii?Q?VOxXSondhRuZrMyznBmdt1jORNcLrMcLOWaUxD8ok3Nj3G9SAUUgQvA4dIxE?=
 =?us-ascii?Q?byrPMYxLp5yB0eLsIoxi5+0TizoqK+D3+0ByfkNQIiiH1XnRLaNgLiudutjO?=
 =?us-ascii?Q?2DAS/ti+NQ76O5S85CSFpd4FVvD3mktEO4h7xTw1/4UjV0ZP8I75pAVN+eCe?=
 =?us-ascii?Q?TT1242D4OfTrEhGlDmhfafkNZ/OQGFtfJZEk9uMeDsnQWv+ex/QEtPpUJkco?=
 =?us-ascii?Q?cbQcYddeih0NCcNFFbGWzejmofebk4wOpuko6GKjTLrgYzN9urf7+sqSae5f?=
 =?us-ascii?Q?1sAwt/c9NsX6jQoSFnKs+mpnq5fejhwENdXJWI4ifeddhyig3HYlIKEj0CuP?=
 =?us-ascii?Q?NJ4nNrk1sP392uSwkL6bnCAF25T/YzBBvWNA5SePLggxjlaiVXJOfnV9Afqi?=
 =?us-ascii?Q?q1SYTjmk4ttF4gSPiwJA1Dg1QFfWjUYgfQDB031gYyyV/4IAGGN0EFENnZIv?=
 =?us-ascii?Q?AYZitd9ppT1t1O+8PaenyPrKB/1Az9HVNHW5mj0jU9RuRlQSrdE29I6riyOX?=
 =?us-ascii?Q?XfcEy7yJrlxrLTGWNvs4D0bdz2a3Fz/TsVpEv4Whj/gxDuvyd8fV//ivagdY?=
 =?us-ascii?Q?EL1q0BBEKzR5uT6vtAsk0OuxpHJuT7IRazVEBzQpYfLWzpr0kg0NmGod2ise?=
 =?us-ascii?Q?HUte5xhg92qc622kppVLWC9U3mFJIIdhtBuxILzVyenqc+B5687sdOK1/wK0?=
 =?us-ascii?Q?3GyA9fQDMRipUfZcUH4vu8VmCEaYMPGs9npTpbNtNR7L+dNuSDLEy/ev7X2s?=
 =?us-ascii?Q?DsNwm2A8IblaXpnLdbpvCup0RqHYnMdCw9vApYrLXmUtGjHJ/ELjnH1CdQy2?=
 =?us-ascii?Q?oacCS/rt+h43jCLF9q3wCYPGRJtCqRT47C5+gamb+pvH/bLAHZd9mOjZ6N7h?=
 =?us-ascii?Q?yReQ+2k5sO/dhLNZf8s2NpBi9DNbIwO5Vjz3zqlb5b4ZlxFQ/P6si05RtMgj?=
 =?us-ascii?Q?6bla4Gn77mcgcgOyOH/0rkmSGxC2sIsQ+YCo5RXZavHT5p/Bzszs7UWKsqPH?=
 =?us-ascii?Q?lyaQtPEonjP69YoKmyFdcz2mQyMc2WdwcSqdIYwVSKMI1gFT0NLX9sH0Um+9?=
 =?us-ascii?Q?qXhnyXgT5oFWJpJ1e49xMoQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a46d0f9-16aa-4867-64eb-08d9c10abc81
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 03:10:11.1378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OUvyuqgTA0zNS+f7Y/AMI3SyM9qlNbHPaKg9iOZmanxRmzC7LaPbsbdx1C4N2e982fENHHuiUc6s4zr6rq9Rhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3468
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 01:23:22AM +0800, Rafael J. Wysocki wrote:
> On Tue, Nov 30, 2021 at 1:37 PM Huang Rui <ray.huang@amd.com> wrote:
> >
> > AMD CPPC (Collaborative Processor Performance Control) function uses MSR
> > registers to manage the performance hints. So add the MSR register macro
> > here.
> >
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> 
> I guess I can take this one if there are no objections from the x86
> maintainers, but it would be nice to receive an ACK from one of them.
> 

Hi x86 maintainers, the MSR register descriptions are documented at
Processor Programming Reference (PPR) for AMD Family 19h Model 51h,
Revision A1 Processors:

https://www.amd.com/system/files/TechDocs/56569-A1-PUB.zip

Thanks,
Ray

> > ---
> >  arch/x86/include/asm/msr-index.h | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> > index 01e2650b9585..e7945ef6a8df 100644
> > --- a/arch/x86/include/asm/msr-index.h
> > +++ b/arch/x86/include/asm/msr-index.h
> > @@ -486,6 +486,23 @@
> >
> >  #define MSR_AMD64_VIRT_SPEC_CTRL       0xc001011f
> >
> > +/* AMD Collaborative Processor Performance Control MSRs */
> > +#define MSR_AMD_CPPC_CAP1              0xc00102b0
> > +#define MSR_AMD_CPPC_ENABLE            0xc00102b1
> > +#define MSR_AMD_CPPC_CAP2              0xc00102b2
> > +#define MSR_AMD_CPPC_REQ               0xc00102b3
> > +#define MSR_AMD_CPPC_STATUS            0xc00102b4
> > +
> > +#define CAP1_LOWEST_PERF(x)    (((x) >> 0) & 0xff)
> > +#define CAP1_LOWNONLIN_PERF(x) (((x) >> 8) & 0xff)
> > +#define CAP1_NOMINAL_PERF(x)   (((x) >> 16) & 0xff)
> > +#define CAP1_HIGHEST_PERF(x)   (((x) >> 24) & 0xff)
> > +
> > +#define REQ_MAX_PERF(x)                (((x) & 0xff) << 0)
> > +#define REQ_MIN_PERF(x)                (((x) & 0xff) << 8)
> > +#define REQ_DES_PERF(x)                (((x) & 0xff) << 16)
> > +#define REQ_ENERGY_PERF_PREF(x)        (((x) & 0xff) << 24)
> > +
> >  /* Fam 17h MSRs */
> >  #define MSR_F17H_IRPERF                        0xc00000e9
> >
> > --
> > 2.25.1
> >
