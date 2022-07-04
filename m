Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA528565382
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbiGDLbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiGDLbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:31:01 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2057.outbound.protection.outlook.com [40.107.212.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF23E087;
        Mon,  4 Jul 2022 04:31:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVohpFmaImWeUKhoxI7RTHf2WVUiA3uRqLtZVLzFWwB2CNnolDruOQ+gaLPhg/LRSu2h1Ael1T29ZPNqgo/heyWg/Xu++4cjmHI8UWMJWAvwZ5sT7ugjJsrvUncwF7j68WKDDiT2PYp+0W3l2zjFHB+bkcF2wu0qNtli/NZ5QK2ORAC2oFNluDCV+F4GobwcWB2YlWbaxuRugnCNwQk+9cdVMlvxAUkzrEGsPTeeu71LT7hkrTw10kgB0SEISRLSESGi0Hfd3Dd5zu4tWmRsv3atih4EYtWqJkIifRpzizxffo+TRiD7DnrsE3cn2vw6D0Y9bj2jpJJuQ7jKKIPySQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dmta8Fps6qlLCNJpA7zVfs9Qzn8UA7uE3/ocsEZZvBk=;
 b=iGZ5cQrbolTRz3525svkN3pm7dv+9mB3hrBX73rk506pPJHG0nL2DsfnTaiLqiOm0sBR8jbfYf0hR67tb865gsfkeZdbTqojmun4KTrdGTVLTsxV5EqyYFfRZAXwYoCC56zXrwtH7kHHts7BrTzQJ/gaeLixwvazYgGD83WhXphGIlkit2hoiavU4DH0sV7+sNzG+nA9ryqdOYj/ZHUoLEBSxrQT0tnIYgdUncVHt2EgG/kEe4DBeBNQzdW09zzq/nB2b9tY4k7c5La1vMeWI5kdBi6KUGjGDqCDhhfpnq9VQNSfwTManNZMEo2CoMN/u1McmIrDeuDqzH8V1lRuCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dmta8Fps6qlLCNJpA7zVfs9Qzn8UA7uE3/ocsEZZvBk=;
 b=Pb/hAtX6XyBSXlKKP5Ei/9pA2eoxeTvJ6G/xSfbAzjTIfGCXqGQICY/a5ku3ByWAUVNBWA6CKek/nQWQAek6xVxpVP/OzOURK58b8MPwjM+N8ySQs7SkpcCdUNr3VTLbwd4t/UugaSXfphdvFUUrqFe+qQEJsatQTAb+ro++ktY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM4PR12MB6544.namprd12.prod.outlook.com (2603:10b6:8:8d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.15; Mon, 4 Jul 2022 11:30:58 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 11:30:57 +0000
Message-ID: <79c6ad70-47d9-47fe-4bb4-33fcf356dd37@amd.com>
Date:   Mon, 4 Jul 2022 13:30:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: CONFIG_ANDROID (was: rcu_sched detected expedited stalls in
 amdgpu after suspend)
Content-Language: en-US
To:     Uladzislau Rezki <urezki@gmail.com>,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     wireguard@lists.zx2c4.com, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Joel Fernandes <joel@joelfernandes.org>, paulmck@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xinhui.Pan@amd.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Suren Baghdasaryan <surenb@google.com>, rcu@vger.kernel.org,
        Hridya Valsaraju <hridya@google.com>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        Theodore Ts'o <tytso@mit.edu>, alexander.deucher@amd.com,
        Todd Kjos <tkjos@android.com>, uladzislau.rezki@sony.com,
        Martijn Coenen <maco@android.com>, christian.koenig@amd.com,
        Christian Brauner <christian@brauner.io>
References: <1656357116.rhe0mufk6a.none.ref@localhost>
 <1656357116.rhe0mufk6a.none@localhost>
 <20220627204139.GL1790663@paulmck-ThinkPad-P17-Gen-1>
 <1656379893.q9yb069erk.none@localhost>
 <20220628041252.GV1790663@paulmck-ThinkPad-P17-Gen-1>
 <1656421946.ic03168yc3.none@localhost>
 <20220628185437.GA1790663@paulmck-ThinkPad-P17-Gen-1>
 <1656443915.mdjoauhqe0.none@localhost> <YrtgeSmwLmpzN/zw@pc638>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <YrtgeSmwLmpzN/zw@pc638>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0601CA0039.eurprd06.prod.outlook.com
 (2603:10a6:203:68::25) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0183b8bc-9e06-44e1-a2b6-08da5db0aa28
X-MS-TrafficTypeDiagnostic: DM4PR12MB6544:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ItJ6D9r60YaSSdyCrZ4wdx0PxaROt/jFeHQt6h/TDeT/XmKgKXjiw3EzpNOcYDCA7lLSyXlIXtj3ly4Wv0F5VVD4gFYuMdxbHrtXj0m9gXuH6+kOgqPC5qnimXgJE0UVpQheMD74x8cNsnWLhemCaFGYCT0jxAkm2foug+G3N8mmV8nxte0yVBRncMaBmB6y/8LwCJyAO9d3LG+lfLUaiDrUWG4R9EjXobAPGGz0vu9WJ4dW4oW78Oak4fzY0iUFKTxfTE+8HpFFdOq/HslxkSgYPVhN+cfjDj3vjKbvZgGiVLbXTdAvC4RKXT9HlkaQSHf3oei4XzsBwjAfnuVgCcPRVT9e8ivovIlkJy+Necpk67fH3eDMoHVQtU9z+8y950UNuX+ZNE/3C/gnAIc27qmPEplh81hXI86RqkEUqRBvPKwRUR12Z3htpF+BrAotQvRaKzo6+4DmRpZ0c8yA+X1/yel1+XVL7eWfrI6pupErLfDYvg2H79Nv4xDgWg7x/riannE6bBeWbimnaIbGGeYnNcw2cxLGbVmPh30Xgg7INhD7D2kzM7B7vwNieGhvvnwHNfLTfyMEketeZyEApcJQVA3uetn11zErHkHlDJ7uGhMwaFpivwEJ2uSBRYykPGwHHiZUWmSkvIQNA6rwvOmcWO3BN9xUUS2HlSKOBYIAYMOWsjTpuHLDJI4KQXnIOt9ZbaUqRFLrJF2HKaYJJldp6uqDcI1Fvf7oUypkPrUwowfofYv5pyatWZWkb7Joq5/h9UPEXxu7tGm2gl6o3Z0sjeBGvP2Fq6JxwULHZsmrHCQwk9Jm6KkoaGhkt/b4sAWkfe4ZTnnMpIZJuO1xnMfpKzyW25qn9cEbYwoh5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(110136005)(86362001)(478600001)(6486002)(31696002)(6666004)(6506007)(4326008)(31686004)(36756003)(38100700002)(316002)(8676002)(54906003)(6512007)(66946007)(66476007)(66556008)(41300700001)(186003)(2616005)(7416002)(2906002)(15650500001)(4744005)(5660300002)(8936002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NW01QXVERUJmaTJZK0JBME9velZxZjNJNFR3akdhZU95TlczbjF2c1R1cktr?=
 =?utf-8?B?RkJFTHRxN2cyNlhQdnE3SmQ3U2ZxUk0vWkhVZ1JmS0o1Zk5NalIwbFFJRy9o?=
 =?utf-8?B?STdJNi84NlA3dTFBN21YTHBSMERsQmptY2JXZGRWMGMxVHkxSzNlMHRDWTRz?=
 =?utf-8?B?RWhRSHRicTFlV3o0c0RGT0xsT0dWYXp2Sk8yOWthMndGMWhybjUwdFYxYWhM?=
 =?utf-8?B?aDFRN04rRDRZMEU1eHdxei9sU3Rhd3RQVEZ0K1Fjb3BWQ3NGeEJqTUxlZmxt?=
 =?utf-8?B?TVNXMzczVjVDVTJBczNVczREQXEzQ0NNN3VkcU01bkhHaXk5ZFB3L0N0ZEdu?=
 =?utf-8?B?eDFRcnBDek1ITXZxNmtzNkl0cTh4MUU0MlFHWVp6a1IvempPU2hQakRXeFR5?=
 =?utf-8?B?RzNld3ZsQkpzWndjemF1R1V3ZFJpSHR5T0tLMSs5aHBFdFFFdGxVa004bHo0?=
 =?utf-8?B?ZE8zVkRycmc3TkxpT25LT1RlSnBEeisxWDhqY1hmTjFwU04vMUQrZ2kvZ0JC?=
 =?utf-8?B?RklzV3ZhSjlyK3MwaksvZEZpb0ZOa0M3SzBzNndCQUxZYlhwRDg0Ny85aGdk?=
 =?utf-8?B?NnYrWmVnZ1FCK2tKdVBuYVpTRnA2RTFxbXAva2lza01BaU5DYWVXMjdKS1Mz?=
 =?utf-8?B?dnpraW1yY2toVVJJc2VGM29abmh2ZU1MTVZtMmhGdnc5U3QvbFdMNzZJRURu?=
 =?utf-8?B?LzNHV0pmSndiMFQzTDJjZ092dHdWb0FMc1hkbEZqSGhTZ01oZ2tIbm9HWVh5?=
 =?utf-8?B?Y0dERUFOVDROazE2VjVaOGpUenVSZjRrWDlxcWlZL0RZUm85dkkzOWdoV3p4?=
 =?utf-8?B?dmhYSGYrQ0FGK1hpSVNrNEEyckRweHFtMW9CZkpnVHhYM1RKTGxhdG1lTVJI?=
 =?utf-8?B?S1Z3a0tkRG9EMXhxNGk1WlFROVYvMkEzUkJITnA5TkVzSEI5WmhVbXJNVS8w?=
 =?utf-8?B?UlFmL0VzMVorL1Z4aVBKbFY1V2hGbk1kT1hFVFl6QUdRVmtET0hsRkRrUVRl?=
 =?utf-8?B?bXYzNWpDM2FmZGU1Sitpb09OTy9UeTVHOWJBYkpua242Y0RnVFg1M3FwNUtZ?=
 =?utf-8?B?MVZhbUVWNmUxMlk2SEpIMXZoSUhPT0VsZ29YUkVqSGl4QzlDQjRQd2pvdXU4?=
 =?utf-8?B?SkxOWWhmR1FxTDc4a21nYW1zY014cngyQUpoOHBlV3dPTkxCa2JNcVdjR2ZT?=
 =?utf-8?B?VDlnb2g5RWpUTFFwelk1QXE1OEplZ2pSalIxOXlqVzFaajJSZHA5cCtWblB2?=
 =?utf-8?B?bnBLeWFleThBK1Z5dWlvUi8wZ1k0ekVmblNMd2dORnBTRjl5SFVZVVZIc3Ix?=
 =?utf-8?B?TGhlMk1SMHRtWVNyb3d3S2dkM0R0Y2pYbG1sNDlwdkxlVFJoSkV6MXhLSGx4?=
 =?utf-8?B?OXZiOXY5Y0FwMng1SlpoNWhGSlVoNEloZWFTbjA3a0pldTVyZjVxdFZXSG1i?=
 =?utf-8?B?dVhlSlhlNVAwS0RqMTBubUhaajVHMXo2cFpMbm9zaVVNV3FhQ1g3YlpFRFRz?=
 =?utf-8?B?aDh5Y0ViWlZVLzUzNm5jbmZCajAxanpCOVJuTXJwZ3I5L1NwamhMSEhmbFNy?=
 =?utf-8?B?YWRKWGZLYWxqc2E5THhnSjJDVjMvdkZNL21DY280Q3pUVEdnZ0l5eGpGNXk0?=
 =?utf-8?B?OFlzMEp4YVY4dGpJc1ltZnphdUJ3aXVQWU5CdXlzK0RNcktlQWpkWDF2c0la?=
 =?utf-8?B?R0VCVFJiYXgxWTBqMnZUNXhvZHNReE9XeTBCZFlRdFBBbEYwRmFmU0I0ei9k?=
 =?utf-8?B?a3hXQStBOHZZRUl2SzFuOXNCc1BpNU1vRFMrSE5sNzhyZ00rQUcvRnJkRG5u?=
 =?utf-8?B?cXlCT28rQTIxekZRZmNqdk8zRC81U21WLyt1KzErbWkxRWRYaHJxWmpTU3FR?=
 =?utf-8?B?UGc1b1FXaVlOeVRlcG02T09yUTJoR1RFdW51OTRTM2hVQ2ZPVnp6ZFVGS1V4?=
 =?utf-8?B?ZjZ5TzRUd0hwbWt6ZXJ1b1J6enYzRS9pd0lKZmxOWmltdWpLdGd6TTZVMGRY?=
 =?utf-8?B?ei82RXhQNHk2ZmZJYzBYWEdXaktielV2ZkZLV1BHV2l1VG55eWh1c1JkaHpr?=
 =?utf-8?B?K1dTN2Vid0ZiSzRhb0FHM0Z2QXMzOUF3NHBQS2h6RkEwUkxqUnUwNXgzaXND?=
 =?utf-8?B?am9uWTA0aGdFV3duaTgraktkcGpGL1dsZEpoMUthZUhkNE9QeHVrME94SC9T?=
 =?utf-8?Q?mVTMTA7pZLMUW2xBdomQwXM7ktzBcdVfTWLM2GSRYTn0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0183b8bc-9e06-44e1-a2b6-08da5db0aa28
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 11:30:57.8638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: moc/EOWONzGhR+QG23eHV2HDwLWjvLBc22TuVQyZW5HgANNdx6Z4nuXV5TGU/c9y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6544
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

Am 28.06.22 um 22:11 schrieb Uladzislau Rezki:
>> Excerpts from Paul E. McKenney's message of June 28, 2022 2:54 pm:
>>> All you need to do to get the previous behavior is to add something like
>>> this to your defconfig file:
>>>
>>> CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=21000
>>>
>>> Any reason why this will not work for you?

sorry for jumping in so later, I was on vacation for a week.

Well when any RCU period is longer than 20ms and amdgpu in the backtrace 
my educated guess is that we messed up some timeout waiting for the hw.

We usually do wait a few us, but it can be that somebody is waiting for 
ms instead.

So there are some todos here as far as I can see and It would be helpful 
to get a cleaner backtrace if possible.

Regards,
Christian.

