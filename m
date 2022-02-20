Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006FC4BCF57
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 16:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244252AbiBTPVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 10:21:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244285AbiBTPU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 10:20:58 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A89B49FB5;
        Sun, 20 Feb 2022 07:20:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/l3srdV8SSOUdwHEEb0yw0ZfhkJrv6TjReI9wYa2sdOFpOuAgGwIRZ5/RyLvmSsQaTVf/KQwDqrc3BeMIRTm38yuWqYJrSxAphHVGKPg7TONYQRNyjf55CEXt/rD3GqySKiZif1gWo/Kvlll7boxELuIHR98H5pSuZSFZivPjWYRXq29yFiCvhDxhMX3IrlGU+FhaLLHwLcOHoe7PidtG8RwS3qG67w5OoaWdQkn/7dPjeSkQspJQALNfWJIcCbPMKzTt1QKctNewGTY7gzudHODSlRre+TyGTkwV+b6cwJJ8KqkEZiIpMuiQzog4qzBfw2AEI2O1Qj2wKRlm3h+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RcEWJU3ZOIldBHJWnxfWMCk2lLh3Fmc26KKemkkU9XE=;
 b=IfZGaE/aIYDPemOk83+Y/ZWxYSHAOa9fkN6SmI77QBDdlcTy1PIOOI2XE1ebxmh2BWR0iylHgme92swJAa0SuX50+CtAaypFQSBFtfejJVxHHxaPO3e9DPSiJBL4T9ajdTl9lbxVRHygGUx9aQWNf/uQ4+Y0Bhr/NwCrWMHA/FTAZG9mExGzt8ma5rv7yhqYMmFEFone+XLWved2FBtg2zUTkDICpUrGspPFzm03a4vbC2H834nuyFzxqZZo1HYaScgt4iSR+kOIKo+kk6BMerm5vK4inTWBdviDCRfqNXXm1sgulIsH2kbsZ5I8DT67yRozsJ+rTy4vsxJrXtRNbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcEWJU3ZOIldBHJWnxfWMCk2lLh3Fmc26KKemkkU9XE=;
 b=qAEP5xtr4eazpF9OkbJHuBRDxPfkzy/WqHo0Ll1diTCje9tObG5Ph754AQKN3c6OEkYhJD4TrbdYzBJSzChqXWCos8xv+m5AAduF/gXJPMYuVEHkXaBR2ajatcXWzeIudu/vmY3UvMrCbDAKtQ4/SwRt2OF/v/U+Id/Aa/QXEc4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 MW3PR12MB4585.namprd12.prod.outlook.com (2603:10b6:303:54::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.16; Sun, 20 Feb 2022 15:20:32 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::6cdc:ce39:9104:b1a1]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::6cdc:ce39:9104:b1a1%5]) with mapi id 15.20.4995.026; Sun, 20 Feb 2022
 15:20:32 +0000
Date:   Sun, 20 Feb 2022 23:20:09 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND v6 0/9] cpupower: Add AMD P-State Support
Message-ID: <YhJcKXo5t6E/jy8x@amd.com>
References: <20220216073558.751071-1-ray.huang@amd.com>
 <8aafb93a-772c-1806-e087-cd285694aa74@linuxfoundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aafb93a-772c-1806-e087-cd285694aa74@linuxfoundation.org>
X-ClientProxiedBy: HK2PR03CA0065.apcprd03.prod.outlook.com
 (2603:1096:202:17::35) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3091c89e-e01a-4e43-5b58-08d9f4848924
X-MS-TrafficTypeDiagnostic: MW3PR12MB4585:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4585BA14A233AA9320407A7AEC399@MW3PR12MB4585.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R9+zA0zWgxq4T9N0oc0TQlWBPesh67vgEGzM+MNC+4mot0fIQZPfM4fYy2T2EeIw0jA5Y/bRdqWDxZX2lc4SNmkdHRhfW9V3AFTQAz63VLnP1wZwRf06DEC2/TTsDkk6Iy5iEbKijEF1P59tuUhhiTKP70Sw3o1txBdLySk96vdc9mOAsLQs2Ncq6u7zn2h+7NMgmgxQlusN5PF0yr1w+bQrIEtwWJz+aJ1poHCUr14fW8JRXf8eA2zNLxO/pP8MsCBy6xybElsJN2SLGo2XElTfFmrIrzb2jLzDOX2RdMORese6wKodbADppjOmJgZxPYSK6eEfL8yLxLXZtUN4w18lQBehqNldqkPT0olV3f6igGH/2/tfHBBCiKKSInJ4XVZwEdPfkHG50B9+A6APb9EspVR2aDrmG5n48A1C35zRxvRKjjekEftQki+F41/gOXGjMu/TBDG9WNSsoLFDPGm5yv6iTKYGmGTPrEt0s63V2ow/9AbRGh2dCmb39y4w4ooVRyBNnkdvwqjRT+YN83h9f6lmAobGe32o+g8p5CZGZzJV0EA0yUDS7IngaudVWjL0aw96BEiwq2k8rIqwndY4b5doFNiQwLAFyCJWmMoWFc827nccjELLey9thoi1iEaORJ8fgJ4GHh8FaCvBeknkWcXhsv/a72QP+p7fW4Sj85h6dMohD3sXn3d+Qsq4xAGgAiPQkwn8kZtXJUTkpP2v5NDqdMHb6oW4RFeHWC5mpL4IqzWQfVugrzqFkF46X3Wp6DEsi/7VETNAYca48g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(36756003)(8676002)(4326008)(54906003)(26005)(2616005)(186003)(66946007)(66556008)(66476007)(316002)(6916009)(508600001)(7416002)(53546011)(5660300002)(6666004)(6506007)(6512007)(8936002)(38100700002)(45080400002)(2906002)(966005)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UHzpVd38hmAw18LiyL8WeSYfESfwjH9cMjpdiLg4VqxrdoIbjyquByD6IT8D?=
 =?us-ascii?Q?yI2+2tSJEQCCGmkvv1J4JNsAyp7GEYAUDUDdrHnwqWzaxrZg0blo3u3lBjjF?=
 =?us-ascii?Q?SfHz+1ViCf5EZBQEoohypLzlqVJzx20aPOXM0c98jYZtFhybI/qAZxsrvbWk?=
 =?us-ascii?Q?OQZN24i56CKRCmLb3V2rT3QCMHH1bS6Bl1TyBnjeuzsuK+MYVjcBEJSTit3y?=
 =?us-ascii?Q?WfhKxkW/cAsUN7KoQvjgzILSHVGJ4XySd2NgBKxrVb1/LnbMxNLU2bLzsrL7?=
 =?us-ascii?Q?bfXvMefMTeGhlYO3z83K9vE3x1ifsWLYM7RnsGx/0RCRWIOedvZrPklpSaLH?=
 =?us-ascii?Q?4xoj452JugKjsCiIFsy3qkGak+cmVnu43+25Wj9b+hvXypM8I6u3ix61e4U+?=
 =?us-ascii?Q?6qpPZFIkx8Tn8iC7Ou5td0fIdXJ5j89ZSBiWfJbl8OgKghCXB2mD43HflZi6?=
 =?us-ascii?Q?6MTUV+jRIUvqgD+KS7ChhduUl5jWNh0kW6vqy7YbZ6gbZ+iMTVtlLGIvtwfK?=
 =?us-ascii?Q?Q+Cnr2dNII5I2qoslZTXh0UnU7qPqGOHUwS3vuifwyr1QPO24toK3C4lVUfk?=
 =?us-ascii?Q?hbJZDjt+oEYH1TnY9orntYOAnskYnHKcdti/lAG+UT1VoMcF1eR39Yj3B0Z/?=
 =?us-ascii?Q?/b+hD7mCLcbdhyvgh4otnlOOb4gKVie1QLGmXaMnDKtust3awjMWeIU/CiYh?=
 =?us-ascii?Q?gn03Tgmqesr/LMaRA7Hlx0KmC/QxwzUR72syaV97BqNDpaVNG4DQkVFGWTZ8?=
 =?us-ascii?Q?Hl29ti0taSR5ynXVTKk7FGcPJz6zRczAJseuEGefsoN2RMYMlCBQMa8VdGk3?=
 =?us-ascii?Q?lj1gmaDp25Nhy0AqqYj0RvYwbkh5qfuHLd/nk3Q729jIb4l1J8/BOFpvmbBp?=
 =?us-ascii?Q?X/IThILC743Oq3nXKHv4LOSJeCy94sddUIyr4SvXVaO3Nx/VugBojLwy/wHB?=
 =?us-ascii?Q?/4kvEylPPA7DH+mr27aDm096gi9CSKCJgMF0O5PlHx9jvClCr0Xfwvv22xXy?=
 =?us-ascii?Q?cwn4F9sroV+HidXk7bqb/DBymKXm1UdpooWCvkg1kgn+vOTAWQ34HsKnrndl?=
 =?us-ascii?Q?gml9QQ5aTRlWvnpTznCsCK7L3Pd4sZhEbCM9WNHPCAOlBrftfzH8yAZ/BNu/?=
 =?us-ascii?Q?y8CPjpiyZpu1lnLoKKKK3Hi0WsXMHHhUfP/6NrkS7vOm5VkvFQ0vDzZOTsN1?=
 =?us-ascii?Q?aDHwsRVhY6og+v/5JW0X83c4pBVlXmBeu3USPoG/ywhlrXlWqoivG3WVFrtt?=
 =?us-ascii?Q?eS8FZcC6/sqwE2clmdlTVI+Oyf0tXG32lb095DceYhU1/nQU0sifNZGiO+z7?=
 =?us-ascii?Q?tWS1uFP5Qv1epqRn591U/manTagYeZqy1uW5Oh3LXlvyvynlVgNkJZy6KhXx?=
 =?us-ascii?Q?JRVagnWqhD3wrRS6rstKT21yqnoqGLqo4SBddx7iUsuOzzWkD/tfGyS48Wzu?=
 =?us-ascii?Q?ff7lJDONDMiUFVOVtku+SxSl48OhD04HIK/YTqILog9CH0sIe4SS/mZgRQED?=
 =?us-ascii?Q?fngrAetA0wiHJBiEDDPvWtXH8odCdEIYxpO1rEP2oPpetdgjOKRuo0FI1wPu?=
 =?us-ascii?Q?NOWt7jh1pCdncq26pwFM/IspG+Aw8cw2zIFVB1llliONeOXjevJDSqEqKyxJ?=
 =?us-ascii?Q?et/ihIfpvaWTxRBP8Abcmik=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3091c89e-e01a-4e43-5b58-08d9f4848924
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2022 15:20:32.5701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yNJuomIEAKsaoP8eaBjrHGFfWCVS75/+WtV5qcNbbQqNBqlMzLG3Wi4/dhFoNoaDp0PFdWc/ZVABTkciQKSvAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4585
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah,

I am glad to see your comments again. Thanks for your time!

On Sat, Feb 19, 2022 at 08:27:41AM +0800, Shuah Khan wrote:
> On 2/16/22 12:35 AM, Huang Rui wrote:
> > Hi Shuah,
> > 
> > Since AMD P-State kernel is merged into 5.17-rc1, I would like to continue
> > revising the AMD P-State support for the CPUPower tool. These series are
> > rebased on latest bleeding-edge, any comments are warm for me.
> > 
> > See patch series of CPUPower in below git repo:
> > V1: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Frui%2Flinux.git%2Flog%2F%3Fh%3Damd-pstate-dev-v1&amp;data=04%7C01%7Cray.huang%40amd.com%7C7f03b74e8f3044c8574008d9f33ea54e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637808272662923642%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=L9G4msSTFHOztI8Dj5en2aC229%2Bn4xZl%2BGYMOG4R2dg%3D&amp;reserved=0
> > V2: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Frui%2Flinux.git%2Flog%2F%3Fh%3Damd-pstate-dev-v2&amp;data=04%7C01%7Cray.huang%40amd.com%7C7f03b74e8f3044c8574008d9f33ea54e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637808272662923642%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=ApWETuX6J%2BK5fbHV7ym0%2BYawxD3TAIqaffOCRlBz56g%3D&amp;reserved=0
> > V3: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Frui%2Flinux.git%2Flog%2F%3Fh%3Damd-pstate-dev-v3&amp;data=04%7C01%7Cray.huang%40amd.com%7C7f03b74e8f3044c8574008d9f33ea54e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637808272662923642%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=wBn4bLwo4H8E8OIKbtIQ9Rw9AJ49ctk%2FpisN1P32Xpg%3D&amp;reserved=0
> > V4: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Frui%2Flinux.git%2Flog%2F%3Fh%3Damd-pstate-dev-v4&amp;data=04%7C01%7Cray.huang%40amd.com%7C7f03b74e8f3044c8574008d9f33ea54e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637808272662923642%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=XITGUWrl4J01mx0V12Unn0ZuODqhAbLuS2eNUIM7IBE%3D&amp;reserved=0
> > V5: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Frui%2Flinux.git%2Flog%2F%3Fh%3Damd-pstate-dev-v5&amp;data=04%7C01%7Cray.huang%40amd.com%7C7f03b74e8f3044c8574008d9f33ea54e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637808272662923642%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=D%2F2vCZrlrg3apxht1XX4GfRo1Unfc%2FMqyDX%2FRz0c%2FYU%3D&amp;reserved=0
> > V6: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Frui%2Flinux.git%2Flog%2F%3Fh%3Dcpupower-amd-pstate&amp;data=04%7C01%7Cray.huang%40amd.com%7C7f03b74e8f3044c8574008d9f33ea54e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637808272662923642%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=g%2FDKBuQirt3pB9dIXkTFbqjyz8LdWBFbhIZBYcRqD8o%3D&amp;reserved=0
> > 
> 
> A few checkpatch warns to fix. I usually ignore CHECK from checkpatch,
> but a few of them found on this series could improve the code.
> 

I will use checkpatch script to scan all patches in these series.

> Also is there a need to add/update manpages and documentation.
> 

Let me find a place to add some descriptions.

> I tested these my AMD Ryzen 7 4700G system. I didn't play with set commands
> and just the info ones.
> 
> cpupower info gave me this output. The first message is fine, but the
> second one is a bit odd. Should it just bail out right after the first
> message about "not support"
> 
> cpupower info
> 
> System does not support Intel's performance bias setting
> analyzing CPU 0:
> 

Let me take a look at this issue.

> Go ahead send me v7 for these and add any mapages/doc if necessary.
> I will get them into Linux 5.18-rc1
> 

No problem, I will address the comments and send V7.

Thanks,
Ray
