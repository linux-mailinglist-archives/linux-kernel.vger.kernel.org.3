Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003455B20EB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbiIHOmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbiIHOl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:41:57 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADD6EB87A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 07:41:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbSXCbcEiHzFWtX+0Wt4Knln5dBsBbLrUCzWOBVn1E4NXxGifgbhxn1HCjWoUngAn70lqtpqy5mH0A9VSuuIkD4rqVMyMoFlh1O2RFSKK5w3WkZTBRbP8ZuxlVi/7kiqQTxD0s+l/ILCooxFpWSeWjveWCBM+JbAaUIV3qNyB9MMOJPiWztLpcpjSVHt9BH55K+E4gvlOW2Gl0Q7qTgBlaAGmAh/lYXbTmAMpOw3lE1kQvosflNmobycfpdpfCPCfjsFhomltg5il/CohzAxkLOpM3d/LOChGMg9Bn8gTO5u7X/duiA6iC8T9hC9rdnrWD8PXvkjZ65wbC9cpLYMXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9stVPSvc9avPF6W3HPS/JEnOo9xNKaKPHwMFFIIh/4=;
 b=Sm9+mdp9SDK5F65DJWEPId3fQtuhfJc8perY83HEWRkpQq+Y7ux9PyZlDV761t8L8hJdKkBsokzI0LyxVXPEclYRLMYVsAW6FAyhBI3u8MzUBhEcrr0iaTgzeVXLTWpdRBtYE16aVEGprJG2BhPp1UuPltKpiTeF19vtvVXWpH5TS9iQQMa1rg48ERU+jt5jeReyEZwq/4WsTYHic4I/CAQ9RdEOTEttrFCvvV+Of66DMhiLTnYR/dLh18gvUieycrPJgGTKt9aeeoaXrrD29MEXA1Ba+7L1VnPHiq6r7CvVua5IWOnFPkzLme6QDfDfMeqCzfhDyxfJem5lE5tfvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9stVPSvc9avPF6W3HPS/JEnOo9xNKaKPHwMFFIIh/4=;
 b=VGVPdLU46rdYYXqBGEqumUBAk5qmvd710gUYOQMG150xPoIbMQfM8I0JelU0ishP7HjUejflxu6ebnWRD1o80zl2s2dDuZPJCxWgRIiPk7/k3fRj+XI0BBIXy1+A6Um8dPtxqs+cqBoGiaRt/zENz3RN64BUO5MBp98SBlxtGgQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4431.namprd13.prod.outlook.com (2603:10b6:5:1bb::21)
 by BY5PR13MB3732.namprd13.prod.outlook.com (2603:10b6:a03:221::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 8 Sep
 2022 14:41:47 +0000
Received: from DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::2944:20ba:ee80:b9c7]) by DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::2944:20ba:ee80:b9c7%3]) with mapi id 15.20.5612.011; Thu, 8 Sep 2022
 14:41:47 +0000
Date:   Thu, 8 Sep 2022 16:41:34 +0200
From:   "niklas.soderlund@corigine.com" <niklas.soderlund@corigine.com>
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     "joe@perches.com" <joe@perches.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "apw@canonical.com" <apw@canonical.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
        "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: Re: [PATCH] checkpatch: add check for fixes: tag
Message-ID: <Yxn/HlaG00fvbLhs@oden.dyn.berto.se>
References: <20220907123547.138646-1-dev@pschenker.ch>
 <1125e8a68a709e18b594f74fc9b25b9992b1582f.camel@perches.com>
 <e6493d2b73e0551f277ae7a7964bef7e4426d7ce.camel@toradex.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6493d2b73e0551f277ae7a7964bef7e4426d7ce.camel@toradex.com>
X-ClientProxiedBy: GVX0EPF000013E1.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1::22) To DM6PR13MB4431.namprd13.prod.outlook.com
 (2603:10b6:5:1bb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4431:EE_|BY5PR13MB3732:EE_
X-MS-Office365-Filtering-Correlation-Id: fc75fe7e-9201-4bfd-4b0c-08da91a841bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xNrItwQ0DU60VgoEBjzDhmu7rQ9S045qDlqYBlMRTB0tL5FTq0vNSUxEXQ4Fpw1gNO1UldEwKDZAY62AzzuoH8e2NhYyQIKd5PiwfoPsvy1Lum6WVLLrew4WicFV1G7L02inj5B1l54pdS14tTwKwwtd1LXjeh8RF4US0zdBYOoHlvgQAIJmInAHCfvJbD9OV1GLJs/DPCDgXO+hZ7urLWrdPzg1u+WFC22gx9ObSg+esRK6qdCeIh2Wt+Uw8flSkPi/pVaGq1F0cebbl1+dRyRMSnBzhGQ3QvVALttx6+HnTl0FIdxEicXHiD6S9J10b1dpdLwxhbpDYCVI09CK6+HEaXUCgUds+Y5tvoUtj90/pGPxjeTPj8DrGkvY1fbl/LdlLp4G1R2xkgMakAxCqfftNLtzDLLL8ANWuuumfWpBo9LZfjDDyfDDjL5N0cGT/ewJXH/ozXpxiYNzQeF7jz56XZSaS4glAZdy++N3BWO8vzg5ze4tZVu5Ek7OyGjt5rfcrxkPkv4gqdO2jeyzqMrLT06cxH6Ej4zmDiBn+e/ZpW3rizNwuv6rg9weW2Tu0hDaf5bVlROmZWXrRWhDDvKv3B2UnFJFiQPNDiFucMx+9YVlhrl6fqd0HvxWFwYvhRAhPAhWTMbCmtR+TrGiFrIKmqX2ZiZM2zymbeBmQgv3Yv+LA8S4CJdCLtcbf+zoPc7Z/gb4qVWj5/PWkC6hLcGBGPXF3/8uYaXHXbrVXywXs9bAePznlbzQgfhyfyUC7sO1nzW2zhNZ14WgKnw5ly2ahHaCu81sUoiDnXPNOi8aEMvMBbaErbxHtRzKxWoFvHv/Dk1+dDLFdNEY+EycDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4431.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39830400003)(136003)(366004)(346002)(396003)(376002)(86362001)(66556008)(8676002)(66476007)(66946007)(4326008)(38100700002)(38350700002)(478600001)(9686003)(6506007)(2906002)(52116002)(6512007)(53546011)(6666004)(41300700001)(6486002)(26005)(966005)(316002)(54906003)(6916009)(186003)(5660300002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDJRYmMrWDEvOU9hSmdiUW00T0hZZGM4STlvUE5PYVVRWktySTd2WCtOVGQ4?=
 =?utf-8?B?a0ZSK0d5VEdaejhrbWpjd2hVZTJrall1a0MvekZWTlA2SVgrNm84b1dtL00v?=
 =?utf-8?B?V3RQUEoyYjFwNzcrNVo1d1ROSXNuYzhqdGlpMktiL3hDU1RCblhZK0N2Q2lM?=
 =?utf-8?B?aE95UEhmei9YcjBobFRlaHorS1pkOFdheXBzRDdaOEFQa1FUQUI5bWp1VXJV?=
 =?utf-8?B?emsvd2NNV2FVMlVvZTJkT1ZEOHZWMmZOb3I2bjhXUEhWdFl5anc1cU9tRDU4?=
 =?utf-8?B?aWVRSVdseC9IQjdVRjZBdDhtYU5ySUIvRXNNRTFsa0hhRjlrOWJFM2Y5cXBK?=
 =?utf-8?B?czh0WHFteEFiK09NVXBFU0RFSXJkbmhzUVdyUnpkdWZTSGZOUVZzMi82UGZU?=
 =?utf-8?B?WHR4ZUVUVWcyZkRoSFZsUWw1anY5MnRmNTF1b2wzMTJzd1BFSExHQ2hkdnMx?=
 =?utf-8?B?TXUxOEk5SFB4OTdJSzVvRW1nc3hGdGhrUS9ySTV1T094NzBsQmVEUlo5MHVn?=
 =?utf-8?B?cnE4NVdIRUEvTVYrUFNBZDFya2RHcTIwbjY0ZjFqbWlHZE1xR3djZGRGS1ZU?=
 =?utf-8?B?a3lkTEdrYnJsZHVVYTE0SGlnSjhlY2RCZW1uMllOVk5NK1NzdHJHN0J3bXo3?=
 =?utf-8?B?ajgxckRmMHFQMC9pZGE4SWhFbVI1eFN4a3M0MzYyRDAybUY5dzc4SzJYamFE?=
 =?utf-8?B?cS9qMTNtOGJvSHBFRmhnaTBPRXNYR2lBNkR4OEFCd3pacE5tRmtDVitDZ2pi?=
 =?utf-8?B?MmIxQ1VQRXgzdDJpNE9veERmbWRTZnIyWisvY3l2WjBpOGlVVXRvbFR0b0Fj?=
 =?utf-8?B?SzRMa093dVdyeGtPdW1VNFZZcE9KbHdXbnZyOW1FYlB6aUVpcHdsZU9WWmtq?=
 =?utf-8?B?T2lwSDhjdG1GeHYrQzVCc3BNVXkrWWtEa2VMNG52YnBDZ3M5bkRjUHUwdGFz?=
 =?utf-8?B?dFRnbkY1b2Q4RTFOZjhydXc3bHJXNlBsQ25pdkxIQzFSQTVMTE42bDhZLzFj?=
 =?utf-8?B?SkUvTmpIeStOeldqd3Juc3h3ZElTdC9uZUNkM3dMYytzRVZTNjRzWmV1MzBi?=
 =?utf-8?B?VTExV0U3RU02Yk9LNkpYQllPTlA4bThER0NacDRBMkQ0VmRtVnlCL0pWNXV1?=
 =?utf-8?B?cTNZcmVrMFdvS3FSSm5MQm9tNUtNQkpOMlVVeEFMOGJVTFVHdFVjdmw2akI2?=
 =?utf-8?B?ZG9IQURpVHE4S3E3NzhNWFA3M3JaU3l2MXQwYlpJaSsvWFdEeVlsV1h6b3Vj?=
 =?utf-8?B?cUw2T3pFQ3A5NXFMRVlENjJQTk9GMHFjUE1Ic1ZxbnZnSGJpZ2sxa1N1Y2x4?=
 =?utf-8?B?VDB5bmdqYnY4YVpHZU1JdGVCTmx5Qk9IOFYrR2syUUloM0ErRWcvNVR2ZFRq?=
 =?utf-8?B?MzBQaFFLRWRtdlNCVmNMWkYxdHBLWWpoZ3A0YnlhRStQZVpZekliVlMyRkh0?=
 =?utf-8?B?anlEV0lLVmNuNXVLR3B6NUFUZ0laRTNpMXB6NHRKUHRxQ2ZVZUdyNDFMamVS?=
 =?utf-8?B?UThlZzhreDZrQ1ovMHBvYWdZQWlUM2dUZHJqQ1B1TlBqMUhxZjM5RWZaM1ls?=
 =?utf-8?B?aVNocklSVTRrNFpuMURVajh4c2pZRzZFWlFkck5tVUp5RFRKTm5HalpHais4?=
 =?utf-8?B?ei9ySzcvOTZ0SjdxVjFVSVhPT3puWTltemQwUW1GSFQxb2tCQ09vbTVjYWRS?=
 =?utf-8?B?a1JwYlliTzRBOUd3QVNRT2dNRVBoMnRZSDlWWUVJZUZhSis5alVHQ0FHK0JU?=
 =?utf-8?B?TzJCNjZ2Q1ZIUHlYaGNXUEJQKytQc2tYZXFwNlVFZ281UHRlYmdLNFcwNUtr?=
 =?utf-8?B?cDJLcFpTUGx3czYyUDlXUjdLdFpPT0RWeEVwSDBEaG4rSHpVcUp2bUVHMjFL?=
 =?utf-8?B?d1MzbVlhU1oxcmZJcXJvUWZQSUVqdzhHL2hCVkFQRGhncUZkQStlUy9pRnMx?=
 =?utf-8?B?eVdoMmYvV1JMRDdkc1orVS91MlAxbUpPSXJHMHRlMEVWNU5Ubis5WkJwR1hl?=
 =?utf-8?B?dXU5ZFh2dnlCRUpBUjgyLzlOdXJMRzBCOVZKMXRIUkNCczN4TEVvL1ViVVM4?=
 =?utf-8?B?WDRLVW82alJSdnVzVHBUanNuRlppTUVzV3Nsa0Q3aU0vS0Y1UEp2ckVXT0JB?=
 =?utf-8?B?K3hJV0RmRlBBcGdWaElCeHpPZUJmSDU1elNFM2xieFYyUTBtQmxONTJoNUNE?=
 =?utf-8?B?c1E9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3732
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philippe,

Thanks for adding me to CC.

I missed this mail earlier today when I sent out v3 so I could not add 
you to CC, sorry about that. Please check [1] and I be sure to CC you if 
there is a v4.

1.  https://lore.kernel.org/linux-doc/20220908114325.4153436-1-niklas.soderlund@corigine.com/

On 2022-09-08 10:01:38 +0000, Philippe Schenker wrote:
> On Wed, 2022-09-07 at 08:18 -0700, Joe Perches wrote:
> > On Wed, 2022-09-07 at 14:35 +0200, Philippe Schenker wrote:
> > > From: Philippe Schenker <philippe.schenker@toradex.com>
> > > 
> > > The page about submitting patches in
> > > Documentation/process/submitting-patches.rst is very specific on how
> > > that
> > > tag should be formatted: 'Fixes: <12+ chars of sha1> (\"<title
> > > line>\")'
> > > 
> > > Add a rule that warns if this format does not match. This commit is
> > > introduced as in the past commits have been sent multiple times with
> > > having the word commit also in the Fixes: tag which had to be
> > > corrected
> > > by the maintainers. [1]
> > 
> > I preferred your first patch that added the commit description match
> > as that's a fairly common defect.
> 
> Hi Joe, thanks for your review!
> 
> This patch is my first one that I'm sending. I was not aware that Niklas
> sent the exact same thing few days earlier. Maybe you mix these two
> submissions. [1]
> 
> How do we proceed? I guess it is up to you which approach you like
> better. Niklas has good parts in his submission which I could take in or
> I contribute in his v2 of the patch.
> 
> Certainly, this shows that the check we're trying to add is helpful 🙂.
> 
> Anyway, I'll answer your comments that not already got answered by
> Stephen.
> 
> [1]
> https://lore.kernel.org/all/20220905105247.920676-1-niklas.soderlund@corigine.com/
> 
> > 
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > []
> > > @@ -3438,6 +3438,13 @@ sub process {
> > >                         }
> > >                 }
> > >  
> > > +# Check fixes tag format
> > > +               if ($in_commit_log && ($line =~ /^\s*Fixes:/i) &&
> > > +                       !($line =~ /^\s*Fixes:\s[0-9a-
> > > f]{12,40}\s\(\".*\"\)/)) {
> > 
> > All fixes lines should start in the first column.
> 
> Agree, I didn't want to make it too strict but this can be easily
> changed of course.
> 
> > 
> > This allows spaces at the start of the line and the only white space
> > allowed after Fixes: and after the SHA1 should be a space not a tab.
> 
> Agree too, I'll change the regexp accordingly if you decide to go with
> my submission.
> 
> > 
> > I think the test better if it checks for a SHA1 after fixes.
> > 
> > And IMO
> > 
> >         !(foo =~ /bar.../)
> > 
> > is better written as
> > 
> >         foo !~ /bar.../
> > 
> > so
> > 
> >                 if ($in_commit_log &&
> >                     $line =~ /^\s*Fixes:?\s*[0-9a-f]{5,}\b/i &&
> >                     $line !~ /^Fixes: [0-9a-f]{12,40} \(\".*\"\)/)) {
> > 
> > Though it's arguable that the SHA1 should _only_ be length 12
> > and not longer.
> > 
> 

-- 
Kind Regards,
Niklas Söderlund
