Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C045AE3FE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 11:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbiIFJTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 05:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbiIFJTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 05:19:42 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2098.outbound.protection.outlook.com [40.107.223.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E586418B37;
        Tue,  6 Sep 2022 02:19:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThSumuE/joT3E52EaGw7pMrWqJwaCkQtRmvqFuV7rdFAb7eSjdVWZntAom/fjkQG5wq4yhwSq3ElxYUw5eh7qNAfJhsovizYKPDNVKWDjHyVNmEJW7OBjqr5TqTBHcvjfa43Txxb4L2XHg5X5oOVSNxzVVMfXR66auesn62f+IhyUB6lJeK4QacdJmozyaeWqvuSbm3ZHjjW87HwnkdjKWBBDntWprIK1qRd/+HJQfN8EK/Grrjh/Pi/NmSA/9iAiMsIIXqJ52iy5ZP3Ykq99dDJrMu91jzdCemLg+2xACSL4Mzxl7BK/ASkb5xXTUMkSloAlN1cC9feQwwaTMlgOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNCdYaujXQVmnaQGQejquyujF0XwaKE88MaiFyQ3+l4=;
 b=Pk8+NDijdOjWb9rFiQsNRhfxRQnrcOUD2uSCDlXUgBHEnPnXxXYijgyy76le0pGNZ2YRoUjAFIo2ztweQ6yjn7Cn2I5/hWdGvQ5HGXfQvI6qmn82bwbCfRIzR3yvm7AE4xK6XBBP3kipV8wC781r4I4EHI+KDhDB3lCr19JAmY391vxb7NMQItHY/QKyayW0kXs4G8GmhwMzg3sQOHM/L93R/ZfREL/k1bhFG41JMlkcyxDqTJbCXJbK0xSi7COiAHuV1M+LvfwlVk+xWuC0oWe8nVIjxhmJq3Tf4idib8rNIGc1fc+fN1l5x48rfoJbTnsVXCaEwhkLWKwzLTZUrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNCdYaujXQVmnaQGQejquyujF0XwaKE88MaiFyQ3+l4=;
 b=r6/ATYAmNMCEtUUxifGioFiW78006ozvXnnuOJJBcZExxEIvK3F6g/y7sYH82K1dlVYIX+Rc7dE6NBtvRIQa/vVnneO7PG7Ff7GRnINznqTbZkqKrut/5ZlBPECEDvqgo5RPItQwBFSJX06MAGVjWSFv3sYwsjASJru+urqeazc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4431.namprd13.prod.outlook.com (2603:10b6:5:1bb::21)
 by SN4PR13MB5277.namprd13.prod.outlook.com (2603:10b6:806:204::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 6 Sep
 2022 09:19:38 +0000
Received: from DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::2944:20ba:ee80:b9c7]) by DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::2944:20ba:ee80:b9c7%3]) with mapi id 15.20.5612.011; Tue, 6 Sep 2022
 09:19:37 +0000
Date:   Tue, 6 Sep 2022 11:19:30 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@corigine.com>
To:     Joe Perches <joe@perches.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, oss-drivers@corigine.com,
        Simon Horman <simon.horman@corigine.com>,
        Louis Peens <louis.peens@corigine.com>
Subject: Re: [PATCH] checkpatch: warn for non-standard fixes tag style
Message-ID: <YxcQou32EAGWwNhM@oden.dyn.berto.se>
References: <20220829155358.2546732-1-niklas.soderlund@corigine.com>
 <dc45a7021bb765ea34c5b9228454f255764c7bc9.camel@perches.com>
 <YxXUHPWtyrt6kNI1@sleipner.dyn.berto.se>
 <f550b468064c61e3550b50da37138802d7e9415a.camel@perches.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f550b468064c61e3550b50da37138802d7e9415a.camel@perches.com>
X-ClientProxiedBy: GV3P280CA0032.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::33) To DM6PR13MB4431.namprd13.prod.outlook.com
 (2603:10b6:5:1bb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4431:EE_|SN4PR13MB5277:EE_
X-MS-Office365-Filtering-Correlation-Id: 436d11f4-9de0-46de-6442-08da8fe8ebad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E1Fvnea1DrgZXnFSuyZFp1B+tH0zJndiv42KmE4JDLQlJi4rx/EQo13Bdyxk67f1FTZ04ft/69GSivkUf0/QdXLX4GpHGYD0zt+llokfNdP8QXxL7GiyoiTGRspH7Qx+JLa9Hr9YpOO5nRX8UMo6I195ZhIBCOVaRKwnL3z/V5Bfp2E5cPeYvew+eueaqP6KF0ugdHE8SRcSy6Cbrqd6xM/Ve9fgCBheFrpSQA+3l5II6LXFaQxCMhTARZFREmvmRrMPImeJo3pXDyquWmAiOLnJVd+eQX8LVZaqdjiafFeW6honKTxoVf5SiACkq0MjjsUsvmCtYJn3LvBannsI7p4v4/5Y94RKE3mPYpSSy1CN2pT11WKusHlcqCEgmsqbawt99GNX45CzMOgl9G72PEGlgB0bD5hZpwMGL4iE/XOczWWaemLOwJ9LAiPeF9ekW5jwVZPgub69UraqPC6Y6BTuxzVzhHCah7xt40VBiZ0LMETyYVV8pov9Av76vaP7UhtIU1WdU/HwAQQUMfaNdVb2aJKxD1xmZ0H64uwg9l5EWn9Y5d2Gr8VZnIE2AzTGgbrwDCeMES3DL//orGEMPBaeIptR7AieGEBZozF7YTVLNmx3LvvEH16rY7yUqg6GbekOVc+DrdSp8+i7gWnBJ4gzA3MKcHJAr7JXgqtogKNuQsCLIt2WnozIhdFDEQR4lSrfuWovJlR3ANzRApxVYwhqQ+tEu2HpHj+JJ6f6yQl+MVQkrii4Hmx2dBOMpFM+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4431.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39840400004)(396003)(346002)(366004)(136003)(376002)(107886003)(86362001)(6666004)(66574015)(316002)(54906003)(6916009)(41300700001)(53546011)(52116002)(6486002)(478600001)(6512007)(9686003)(6506007)(186003)(26005)(2906002)(8936002)(5660300002)(66476007)(8676002)(66556008)(4326008)(66946007)(38100700002)(38350700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?37VJ8z+ssh9Thp+Q50+8tOtl36eBcH6ZhWZV0gjiGyrW1BuVG5Lua+yzlu?=
 =?iso-8859-1?Q?KTYxq2o5wiElKl0i55BNxEcrmZhL2KbEVjKh6tAapLLK3bo7dwM17vA8yv?=
 =?iso-8859-1?Q?bzYLb8GavAir+wqYIRT9sx8ljZA38M/YMXh1oMsuS4IdJA3XLP9Pw9n/PC?=
 =?iso-8859-1?Q?YcF2MRAi8K7uzFcmD5jTsKFgIs4zFIqF9US2IIpvNgG+V42UPT4CjI1ND3?=
 =?iso-8859-1?Q?skR3tekEFQxv/kWbqXFfWjPxlQM8EauxxFjIq4z5zOMrw+fJKt+mT1g1vG?=
 =?iso-8859-1?Q?Sm9FDjbGtXWZE+AqOf2mgXj8NWQtVtZDuINHZ8gvHhp+mBOXVUyVbk03B2?=
 =?iso-8859-1?Q?vClNeWzQefUeshSWUV2JNmg3ewa2JoubjI3juPAWOdxxPUBK2NBpkTz7I5?=
 =?iso-8859-1?Q?letPf+UdQMRMevAPmoeJGoQocIPMAPt06/KQDAUVXZZhObSdXhABGJHwky?=
 =?iso-8859-1?Q?HfR7bQftP5nWJrwmqXLTX3S7TMlW7B14chrjUnRWACrJpKNUsh5vEuc6pv?=
 =?iso-8859-1?Q?sCxuGqc8KzxWIFwuVu1T/zR6Wm+3TXdLuLdGKTV4ew9Xb5YjpFdNehe2IP?=
 =?iso-8859-1?Q?k0LUNGFdGIrhfuUbjiRcav4v4X3OfCzMJa7foOsDV0GKrCH3Tn9qP23Rc/?=
 =?iso-8859-1?Q?biOIWZjvyQjp9FhGwoiNXeM2+kA14z0yeZ1aBFYnKJklycZv7Y9XStqjnv?=
 =?iso-8859-1?Q?C99mfcqAufso90KTUCV9Z8kMBTHv+uP6mmZfoVX25rNCPoKiwXHapyuW9A?=
 =?iso-8859-1?Q?UONQ6+lehX+S7S/ntqshxbZ6qdTTqCrySHaheIJL3u3ZTDWE2yd7mJnkaH?=
 =?iso-8859-1?Q?sczt+WhQbAEpHFVFi93eGmLM3Xo00B2lL6LyQr4OBzjkYdPaxWgHI3MEBv?=
 =?iso-8859-1?Q?LBENLJbJiqojHOPet5HkLkJ4lLBvvRowV+GiziCJ9eFy2i0tmZgIFK3YOo?=
 =?iso-8859-1?Q?BiHSsJgIaxry/GQuylVgnSKC5gl+LphkFieaUd2R8vMtFvM/8C5kP/tz+i?=
 =?iso-8859-1?Q?DGI2B8cgdKj//jq8LOs08Npn5/CXXNnR8iIg9AbLS+WRyEDnYQ9i/Irsz8?=
 =?iso-8859-1?Q?/N6n1WKMWxAHJKcZQo33CYriNT69qCiofXGh54+qHUCnUO5/LJ8IUDoQut?=
 =?iso-8859-1?Q?3gcSJbEkMb5IPHnjH1tSgRcMDQwnIC66RCqLjVBAry9Q6NMdZkvDd6vQ+O?=
 =?iso-8859-1?Q?cb7PWrwlVB5TZ66F3KX5EpYBleU2fbRfJMp8TRGW5PkUHFvRtgSUhtiIoX?=
 =?iso-8859-1?Q?dsCTRUH1jaQz4HQXMYwJxIwGk7O7yymeOTDSxh/ZpyYOSw/QPFbnhPRdui?=
 =?iso-8859-1?Q?iNd8w+1IEGCCCMzUa5kyJVn73Q7teZaotLKL2ZYBqkxamXzev/OzlRPzQ5?=
 =?iso-8859-1?Q?fHZBJ1UOj8yGpp+loMDeLpBiPJ3+MhtYP+WlxWN9ZA/7pqqg7jdI6wBq0N?=
 =?iso-8859-1?Q?pcY3nDWbADRWXQWUk0t5IG7SOzSWAB+gVCUrtDC4Fj969HkQIXL8FB9f8u?=
 =?iso-8859-1?Q?/dKoDQZjJcOeoHvhuB4NePBhQ6snHkO2Z7nB8gBuRPhd1YPRBYIMnvv6ar?=
 =?iso-8859-1?Q?etih2J1L0jJu8VyYm376Y6+v3bYLkq9aHz9fPt8KjtlTD6gzmvW5a9gyxS?=
 =?iso-8859-1?Q?5Qlkm3dLCSjrhHUvPbh1ymKs6i7VIaeDGzzgZRUhAfLk2ATVPl0NjYdw?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5277
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Joe,

On 2022-09-05 11:00:35 -0700, Joe Perches wrote:
> On Mon, 2022-09-05 at 12:49 +0200, Niklas Söderlund wrote:
> > Hi Joe,
> > 
> > Thanks for your feedback.
> > 
> > On 2022-08-29 23:06:43 -0400, Joe Perches wrote:
> > > > +			if ($line =~ 
> > > > /(fixes:)\s+([0-9a-f]{5,})\s+($balanced_parens)/i) {
> > > 
> > > Maybe use fixes:? so the colon is not required in poorly formed uses
> > 
> > I tried that but I think it brings more problems then it is worth. With 
> > that change the check would run for each line of the commit message that 
> > begins with the string 'fixes', not just in the tags section of the 
> > message. So it would warn for the commit message,
> 
> I think it's not a problem.
> Look at the results of:
> 
> $ git log -100000 --no-merges --format=email --grep="^fixes" -i | \
>   grep -i -P -oh '^fixes:?\s*[0-9a-f]{5,}\s*..' | \
>   sed -r -e 's/^(fixes:?\s*)[0-9a-f]+/\1/i' | \
>   sort | uniq -c | sort -rn | head -20
>   73974 Fixes:  ("
>    1345 Fixes:  ('
>     399 Fixes: 
>     246 Fixes:  (A
>     215 Fixes: ("
>     172 Fixes:  (c
>     121 Fixes:  (s
>     114 Fixes:  (d
>     110 Fixes:  (P
>      98 Fixes:  (i
>      90 Fixes:  (m
>      86 Fixes:  (n
>      78 Fixes: : 
>      57 Fixes  ("
>      51 Fixes:  "n
>      47 Fixes:  (a
>      46 Fixes:  (t
>      43 fixes:  ("
>      42 Fixes:  (p
>      41 Fixes: ('

Thanks for checking this. With this background I agree with you, there 
is no problem here. I will spin a v3 with your suggestion.
> 

-- 
Kind Regards,
Niklas Söderlund
