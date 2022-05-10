Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF61F52111B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238994AbiEJJlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238584AbiEJJky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:40:54 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2134.outbound.protection.outlook.com [40.107.117.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E39DF31;
        Tue, 10 May 2022 02:36:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+Voc02mQZY4JLsyksvpqbWXFF5Xww0qqJr1jVQHki7ZJPJPMedu8eUjLsDpF1064OjSGf97RVUGHe5NYPpe+w+DXTZIYj8+bAlWxAjD9m3RjPtTTwe1385QXp6cY8YTFQ8y4eLntjJI8r+FY51FhSLzDu9+E3yf4xQqtf0XcT7G5dKplUfKiJKbrxnXF0YIjbICZvEobSsWH8VUA1YHhEYoaHwD1PAXeZuV6eIgmVxMFzviibG9DRYCtSvri+J0rdJmQkcFmmA4FLHsi4gD2Tkveiat9qfPFAI28bCbYhu/Q+IyMBdTr+zEJzsYyRLFJuyiCyXFy6TCWi7tntlVwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsQJFUt1ZRT/7b3Eq06pFw0VvdpJI4yO/sBtEvUUsSI=;
 b=cJQC+FTAQPoR45YROb9lvISAXk6+en4nLQxZZ0B3fFQruIX35UE/s2iwCjMlgaTppHr6RLXiOcD9XmgJHmnba4FpEXmXV5rTMwFAdMeKrKCh0mpyL6+AbS5VCvQi9u+UGpI3KSAgnFGX2k29pL+Zv0g+lZUMSMSJaUIpgDKNYAbT5WlUiBxqoZr7dc8iFTkhh4l2cTL74I85sxUMDS32xcK6MFdkwpsMJFBbZXkkOkwevnXFtegfufVknLzf2zSMFD91/RNu7QYErRPugGf82QusU3sV+7IoF0m40XvUig4VGiM8meIyBCTQg6jmZhcXJylJkVwyRY+rlCzOJEuhIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsQJFUt1ZRT/7b3Eq06pFw0VvdpJI4yO/sBtEvUUsSI=;
 b=V3IS95n7nv29ENvG7XvvSkAAiZbXzMDG+1c7r1dt+tzMOzDCIb2tn/V4xMxiwXgqmuVkBPp/gjEZ5Jal6sR/sic3uWB0IM8Z8fQOKSIxsJW59GIrRxUwTGqAChoD3wO70rDdEnt2vTRhU1eI3xCDJqhCqaY+8U6ZkznMJPyyC/c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 PS1PR06MB2837.apcprd06.prod.outlook.com (2603:1096:803:42::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.23; Tue, 10 May 2022 09:36:51 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c%7]) with mapi id 15.20.5227.022; Tue, 10 May 2022
 09:36:51 +0000
Message-ID: <e58f36d3-c01d-b133-6615-be5d34fa62a1@vivo.com>
Date:   Tue, 10 May 2022 17:36:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] cpufreq: mediatek: Fix potential deadlock problem in
 mtk_cpufreq_set_target
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jia-Wei Chang <jia-wei.chang@mediatek.com>,
        "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220510090531.12438-1-wanjiabing@vivo.com>
 <20220510091212.olrvvjlx4jtm7zw2@vireshk-i7>
 <49566544-e8f2-ef38-288e-fcd276d87d3b@vivo.com>
 <20220510092822.j3z6bydurg7x5bu4@vireshk-i7>
From:   Jiabing Wan <wanjiabing@vivo.com>
Organization: vivo
In-Reply-To: <20220510092822.j3z6bydurg7x5bu4@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0021.jpnprd01.prod.outlook.com (2603:1096:404::33)
 To SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 093272c3-a58f-485b-26fb-08da32689c2f
X-MS-TrafficTypeDiagnostic: PS1PR06MB2837:EE_
X-Microsoft-Antispam-PRVS: <PS1PR06MB28376D08C62ABB2E7D64B8DEABC99@PS1PR06MB2837.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RizwF8joGOAWRCDZS6WWCoq0ca3blYmgapK0JUpsWgRIWaJegdbsY4rLYpXpAvnK9h5u6nQGHmQtgD+gFAi57vVxmJ5jHjQyG37zJHBFpauvRYz5c9sicsGIouIP/ajvU1XXVffCrzuGGBQis+BMJ2pf47CiokCHVYFNE2Nx2SlK8N5Ko1kGUvk50fw6FIvBLhvDXgySZI8XgUnrIUDqXjATOvbumwcp8LNODUD0sbMWWQLU/xph2KwDJhLybCqS5CLVkBMGPb8ktMG+XuoIBFMQQ+tkSxr/2LDxPbemeOyMg9Y58DyIUVIhB1wvm2a7qOWdFbM9La7Z1rOATmcn59E9eMnf1jACmtnb6P6IzanDuxHaapWsMBF9bvuvD+xuF5yBZG45UEjxxxapteA4gvD+12JWu6WHbGOQoVnIu+aIyeoFJo+N20JViwpPHYSnfUKhVuj0IRPcRBo3pR20AUcPWjYNB9uNV2hN32ewrXOLP0iAQaxh8SILL4bCbVoTenvp0l9kupOLeLUrMEI0xlFf4E3OKpzLaVqDS3w5C+HdNJN0UxjgCljS6K1aHO+iDjsxZvWOtMhvcasOrziSLQS0ngQ7TfVveo9ZP4EplcYj87yXyLWXBLd3JzIBjfdkOArGauKytnHkw0TFOCiZlXss2BzA+5HJ02GpQy2N8hgmYd0lQnAmTstvieFEcyj7htna2mqbHxJwHfjhTi4eSXbAYqXMxiKjHCYMCpYchceEiCv8/in92yzLTdQLdLr2WUinffoz//F1WHoL3Hs+ooDkk0H0hXfKPzogghEPGRudQde1TsG0KuZBOWvG7Z2nG9RjFGqRjyUWdLToF0JRD7teRt+FyRdxyd3dNLqrch5qEEFC5Q8fkmUQjsn1CHDb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52116002)(6512007)(6916009)(26005)(36916002)(508600001)(53546011)(6506007)(6666004)(86362001)(38100700002)(966005)(6486002)(38350700002)(54906003)(31696002)(186003)(83380400001)(2616005)(5660300002)(7416002)(36756003)(8936002)(66946007)(66556008)(31686004)(316002)(8676002)(4326008)(49246003)(2906002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVJ5RjlHdVZZeXNRWVZwdjRRY2hGNmczSFREbzZENTdZZGRFWUVTcGRWRXJW?=
 =?utf-8?B?THBnTmVnVmVZSHU0YXRYci9BMm1FVk1CWU52UnpOVW93UnpPdW5CV1FzaHFn?=
 =?utf-8?B?N01KL1VQTWptZnZ3Zk95NWNtRWJvcU9MU1B2emtYcFQ3ckRiK01sSXU0K2Mx?=
 =?utf-8?B?djJHZS84dHFmMjNDcVJqdFpvdHlMSzdDTDVIenErUU9pcm1EQWd1ZDdsc25h?=
 =?utf-8?B?Y1pVTnZWdlBhd3B0OHU4ai9aRktoUmxKTTFiZDJFWFQvMFpVV2g0cDdKTC9I?=
 =?utf-8?B?c0FQU1R2ejByTDZKc1d4UjRMY0txQ2xvMVJZMUlrMHlUMzdlc2w0aG5mOWUx?=
 =?utf-8?B?M1FIK21HTHBaeUUxTXNOSFh5MUlLczFZWVZJQ3NjZ0RPSmVySy9HTDZDOHpt?=
 =?utf-8?B?eUZETWxnamdETXpGUHcybkszZFcydnhVd3VqQWJWcVdsYzdSN3JtWlpZdW9x?=
 =?utf-8?B?SzdIQzUvSVJYWGExSnlucjAwUnRRdVB2NXF2S0MrMEFrbXVkTVBlT2NYYU83?=
 =?utf-8?B?MXFtdzBBbkpYSHo1Mm0vUTRmSGVnVGdQWDIwaHBMK3FwclpReTk3WVR0cmpK?=
 =?utf-8?B?aDdvZlAveEtkb051b3lvWWhFT0lzZlIrSHM4bTBrTFZCWkRlQlQweTZ3SC9s?=
 =?utf-8?B?OUw2TERXc3dGREUxNzZoY3JvMklsU0xkUW5QUlFCZ0ZCR3JqWXZ2Y2pndDM0?=
 =?utf-8?B?ZUNKeVUzZ2plNHNrU3ZQRE0wVzNhcEYwNkh6TkJueXE0NHZMcWYrUzI0dVVz?=
 =?utf-8?B?RnhZUm5mSFdnL3V0MmlWdzlEUE52Y0VaZ3NDMkFDdVNrMkVmeUlpNUVXa2lF?=
 =?utf-8?B?OGNUOUZqWkpmZWlkNFBPMmkrek5UaThMNGl4VGlIaUNST0ZuVzFGMEJ0QVhl?=
 =?utf-8?B?a25JN3JiZG1iZ0dpdkxmMTVkVE42d0hML1BDNW9WWWxPMjJkMWh0QStUekJT?=
 =?utf-8?B?RUlIeFNuWTRlZXd4U2pEdk9CLzhuakp0N1B5YTlqakI0VnVVcnM0bnJTdDRt?=
 =?utf-8?B?L0M1OXAyK29HV1RsS3pmYS9HbFM2d0FlWVVFdm9tNzNTS1h1YU4xMGNoakFi?=
 =?utf-8?B?WTdoOFl5blZJamhNSlBkNDZRQ2hWWENWZFk4bkQ5dTNxMGtWeHp0RHVEZUhm?=
 =?utf-8?B?SnNkNnByd0VrODNESU9DQWNCT05ESUJvRkRzNDdyK0ptT0FvUkFOdEl1YWdJ?=
 =?utf-8?B?MTlKb0ZsdFVtZ0ZuMXpSS0tHU1J6dGhudEcvbERFRU9BWEhTc3NMZGg2bHdH?=
 =?utf-8?B?RlBNOXZWVjdkUlZENlAvVzZrdGEzeE85bnRxSG1JOFhMZ01CbWpMZGZxYmNN?=
 =?utf-8?B?VVFtajJRRjJpcnQxWlBnREJCaDFhZEtLNkpnWkVUVzUzQ0JodWlWc2FTUVhi?=
 =?utf-8?B?S3NSeXA0UHZmZVRmc3FvWUNVWFcrSy9RQS84ekVsdDZYSGduT0F1MGY2WWNS?=
 =?utf-8?B?a3JxQXNOOVp4L0FKZWhhUmN2VktwSjJ2K1llODVubVUxNm9qa3ppL0IvVWsy?=
 =?utf-8?B?ajcyUFpxaHFYTnZLcTk0T0ZzZWRaY3ZUN3NIcVBmbEErblpnQkVxdlMrNURv?=
 =?utf-8?B?UGZVZ25ZOE9sQ0JCR0V6ZGU1QTBGa2l5RThOMXNUdExBYmtlbGlxVTVOZ2t5?=
 =?utf-8?B?dlV0QTRMc0ZZNFlLeUZReXhvc1krSk5SNTJlUDhTNS9ROFkwZm1obXVMbHRp?=
 =?utf-8?B?N3ZsMlBBSVJRcXYrN3B2SVBPeWJmRHFQaG9jemlRTWc2UkJzUVVpREtKWjNq?=
 =?utf-8?B?aXp5b0FZZS9xbFZWQ2NYMXNaU3RIWVBBcWdaOTRWcXRHRkFEd3lyMmdVS0pn?=
 =?utf-8?B?MTNmMi9XZFlVelVkalEwSVp3amU3WGErMjRGV0V1a1pYc0Vqc2hFMHFvS00y?=
 =?utf-8?B?V0VBVWVvYmlEa2lWbEhFNndGTE1tYTN1KzZWU216TFlZT1B4c2NRanFhcDZS?=
 =?utf-8?B?azJPb0F0ai9OY0ZVY0hNYWM1Z2JxSWFUNzJ5aVFIcVdqVHRYRFJxQ1o1Wm5K?=
 =?utf-8?B?YUhaT3BndWtIMEtWNGZZWk5ZQ2hkc0pQNDIvcEF3V3Q0Y1lGK2thUC93OTBp?=
 =?utf-8?B?bDhmOU8vTEozWEtEQ244UHBYZWE0MEIzZERZWVZMZVNaVm9hN0k2RkZ2NFls?=
 =?utf-8?B?eUx3cStvYWpwbGxJK05LU1o4Wi9sK2RyVjNTVjE5dzZ3NjRiSU5tWFBqQ09i?=
 =?utf-8?B?UDdxU2NQVEdXczV4dTNraU5FNVV3MlFZWGFTUlhoeG9kR3dVbVFGQm54VFUw?=
 =?utf-8?B?T2NmcSs3VGtycVo1RTc3K2Qwdm44d29vc0JSSXhuSk10cGNwSVBrdGlFSlY3?=
 =?utf-8?B?UXVNRWMrZU8zMVoyL0ZzakFoR093cUtxKzJ5ZnNpdHM5TFlXVWlTUT09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 093272c3-a58f-485b-26fb-08da32689c2f
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 09:36:50.7013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KFtsYQUubNgMHh7mDI8vflSD0HY1UIoXNBjqatnNzGinu6dA1Hr/aiTjBYVDJjsNkdeX8lj+S6z0aRz7U6xeNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PR06MB2837
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/5/10 17:28, Viresh Kumar wrote:
> On 10-05-22, 17:23, Jiabing Wan wrote:
>>
>> On 2022/5/10 17:12, Viresh Kumar wrote:
>>> On 10-05-22, 17:05, Wan Jiabing wrote:
>>>> Fix following coccichek error:
>>>> ./drivers/cpufreq/mediatek-cpufreq.c:199:2-8: preceding lock on line
>>>> ./drivers/cpufreq/mediatek-cpufreq.c:208:2-8: preceding lock on line
>>>>
>>>> mutex_lock is acquired but not released before return.
>>>> Use 'goto out' to help releasing the mutex_lock.
>>>>
>>>> Fixes: c210063b40ac ("cpufreq: mediatek: Add opp notification support")
>>>> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
>>> You should have added the review tag you received.
>>>
>>> Applied. Thanks.
>> Oh, yes.  I would add the "Reviewed-by:" tag only if someone sends
>> this tag to me.
> Didn't you get this ?
>
> https://lore.kernel.org/linux-mediatek/304e7eefbb57e9c938737b64fbb515201c7944b8.camel@mediatek.com/

Oh, sorry! there might be some problem in my email-server.
I didn't get this email and I also didn't see this email on LKML lore.

So I missed this email.
Sorry for my mistake.

Wan Jiabing


