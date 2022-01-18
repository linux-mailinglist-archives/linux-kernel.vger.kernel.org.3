Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A53549205B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 08:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbiARHd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 02:33:27 -0500
Received: from mga03.intel.com ([134.134.136.65]:4272 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbiARHd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 02:33:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642491206; x=1674027206;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WkhlGSbtbbLJTP3jGD2ejRPI7+/hW1kplm+8vSHLV1g=;
  b=O2SkCQz1h/TLVut5fJGJ8xbwUMl3VPjt5/pc3Dk89r0djcd2ktvlmQKs
   bLnhTmLXownjtkXAIIssZfTPemvPXovgV63q91R2eWdPjHGmmu2eKt9A4
   DCRmlgBMlrXUkZE1oOYbhWtgPwfcErqjNIaej4hM37vVRPN60BIQLxB6t
   fS6dFnSbtyuZ2Y00aaJEsh58u5KZLDeQdALmwZJMD3EDbqggFBUgXioLv
   9rhaJDS7GKw73C58ueBrR8A92uxvAauAyqEQp2GKCOcIKY4s88vuGF3Lh
   iA+dfZ+pydHC1UY7ITV5i3Ts9UF1C87eghLs7cNa4yi/+ktDrLuLLBVLu
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="244716046"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="244716046"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 23:33:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="531663639"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga008.jf.intel.com with ESMTP; 17 Jan 2022 23:33:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 17 Jan 2022 23:33:25 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 17 Jan 2022 23:33:25 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 17 Jan 2022 23:33:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTQIFu/b0cWGEzjjBxIjEQllRcSEfHQlsNCSQSk0Q3q+il9fgCM4Pz5Ghi/99+jwYeG0cm5a51W2nyc1vf2yfEonNqDsrTxVqHU976f0RwHS1OWfAU+83MiKHsmDnBgYCV0B8FBlYGYK9ZhFLZiYD58I+TuQBoCkR+b7LsbjpULWAuv/vCEx9ZY68P4OqY1P7pgi+diC89FQl71rpqlJSqvNwpFu1L3Em8T3Oa+t3YP4F0nYR6Q3fr+WzZg0L5HhUX2BLLYveu/1yuxJePbUdVfhwoENxVX1q/FMLDFtstWIJi1p3UAwm0+ZuQwhI1wOI75cTU9WSrfL1gFZDV/JNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qUpusLyfn6Dj9QJ70vR8Ap8oo+2Vas3hZAKkMmf46I=;
 b=L0UhgYYlpHnY0ih67J7d5F5qzzodIzAyjULTx141qS6ZTzHqk7dx3D3FSNWyOdYyfhTLog1z1PxKazCSsSpwF/ZvD3yuHNtnYrxb/DWWaUOQcgufwjnCYXYaQHb/SU7yWLA0QnoX2/EpExgYds9QVoY3fM1eNVqIcxxYUsT0mBi29ghx4bFMmqMYNeX/ZjXqJQz/0xEeyl09qrA8YPbA5gwa53qarUNnf7y9m9qZdyenQ4g2eE1fft5n/ZkzX1j55foptvOS/ce+JH/2LDWEWCli+wkApYmSJPTbCWFTLeVAoNaXaWyLx3hBctsjyPbIzjtCwY4Uf/KADmlWjtjzng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by BYAPR11MB2888.namprd11.prod.outlook.com (2603:10b6:a03:8c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 18 Jan
 2022 07:33:19 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::741a:c47f:a4:bff5]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::741a:c47f:a4:bff5%6]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 07:33:19 +0000
Message-ID: <2fdfe9da-ce67-2495-f6c3-2610033437ad@intel.com>
Date:   Tue, 18 Jan 2022 15:33:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: drivers/gpu/drm/ast/ast_mode.c:1232:3: warning: Use of memory after
 it is freed [clang-analyzer-unix.Malloc]
References: <202201141416.VfNXpsi5-lkp@intel.com>
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Maxime Ripard <maxime@cerno.tech>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202201141416.VfNXpsi5-lkp@intel.com>
X-Forwarded-Message-Id: <202201141416.VfNXpsi5-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HKAPR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:203:d0::20) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02339db6-f9c3-4da5-b926-08d9da54cc79
X-MS-TrafficTypeDiagnostic: BYAPR11MB2888:EE_
X-Microsoft-Antispam-PRVS: <BYAPR11MB2888AE72C7F9D4D7A6688B59FB589@BYAPR11MB2888.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:497;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eXUwQmuF6fS/uQiJ6l4ymP0OBtyFZ4Zpdj47cS7dWbxP8ZBrlT5PiwFD277Kms4ml/s+6dPGBC4fXdefAFN1IMFT/KmzfPhWROp1A61Ogt8VJoKX11/B8rKWUDiobTysyeQdkE8g0DBHW10+QyZyy3n7UBZ8CAqIQRJUrVTYN/qd2bAeUKgihpT8ATOfbPHxlRMjom0z0+EInH1ULAAamIvvr8Zuu5rQ0ZXOSj8nMYQ8xpK/OL2MFnSZvXHAucwzavkeWh/iyiR9DRJNNZGwtmRLKfigAHpnoBSG94HlG5o2upRmNwt1lYRzH0phBImjdKOzA2cBGuPCr4bwTFsoDLwqR//3mJfuYRpt2AnQqnGi5+d1FqMBf0Q0NWdGOh9L0EnJv8iXYK7S9AKunocLGAehhzFUxa3CWHA+miPx3ZHSvHKq0w2FcysCg0TXeyVirzVuxXIdB+iPtsh+HGWr8eiSONpRmBXXvumg8LNDoY2Nmr2h22J5aqwcjmkikTfZEBx/Zd9iOru+BEskS12Ef6ez3GZBLcmS4m/v06eFuEVmVPP6Fz41iq5uSSJzcoLapK9eHVexA6O10l7IMJMPESF8wpz64TQDzNDVywaHwh3FWzbhy8AH96JMKx+b83/cNVrxR1p8Yfh3f+EookFvFAY98FVR1y/ST1yU18jZBOh512kXPiL0HlfVLFM37ReEUakfoOQFlHMC0JgxsaaKjkO8FMYegAjSm612QuW+0EcuDejXLwBjiPQdm+LNzr7ABjqVRaDD7mwBfKgEnnwRLk1Yzhpn0CnGf9DYb4SJ2cw/6QbFDglC+i4YRMB/P02KXXaWvaQ5s3x83ieskPv4Mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(6512007)(5660300002)(66946007)(8936002)(54906003)(31696002)(6916009)(31686004)(38100700002)(83380400001)(86362001)(36756003)(6666004)(4326008)(508600001)(8676002)(2906002)(6506007)(966005)(82960400001)(186003)(66556008)(6486002)(2616005)(26005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVY0NUdkMTJwK2ZUTVlMY3hGcXl6L0wyVlZkUTd3Y3YvN1ptRlVPbDhRbEsz?=
 =?utf-8?B?bnFuUXlQc05sUzVQU090MHNvTkpkTXBmZi9UQnI0ck9hdHdhdFNRSlVjNmUz?=
 =?utf-8?B?N3lTRXJ4UlVnTEhWK2RoVlJKNHJ2KzNZeE5oM2xZRmdJQ01wTzhwTm43L2VL?=
 =?utf-8?B?WkREU0oxNTEzUTltSE15K2pHbVZmbUhaa1JMNjJjN0R0WmY3bTQxVmt6dTd6?=
 =?utf-8?B?SEZYR0p4ZGNmNDRVMnNNM0lheFh3MHNXTHpDelJNbFB0WnkzY3l6QkFxaEps?=
 =?utf-8?B?UTlTbXRRVkk4K2NpdFduREtMQ0JXU0pXY2hueDd1VkVtc3dtbTZVZDhQcUh3?=
 =?utf-8?B?WkF3U2RGTGJvUVNRbk5ncXlLblFpdk9qZURaa0FxZHpvT3NlL3hhYnhWaUpN?=
 =?utf-8?B?cHVMK25qN0w4bSt4T2tCSFg0UUxIblpKcTZkRnFaNXJ4c2dCeXZLbHYvc0ZV?=
 =?utf-8?B?T3duMDVuT1g3NzFnK2xibG9wTE5GWW1oVWV1RlM4ZXF6NEVKM0tROGo1czl0?=
 =?utf-8?B?ZWlaZkNaWWozaWVka2U4N3MvUmVpUTk0Z01UOGZ3ZEg0NzlvVHUrNjQ1Qkxn?=
 =?utf-8?B?bGNOQWh5ZkI5Qmh4Z0lxSjhZbk9NMDRhYmNwdFRBZW5QU3plbHhjMWRYREZ1?=
 =?utf-8?B?bUUrNkRSeFJ4RjNHTUczUDlxTmlzNlF0YWxhaXFHMVFPT3NCYjM4NmQ3K3lo?=
 =?utf-8?B?WG1WVG8xZ0hwaUNpNk5HeExES1NCSGRpTS9kb25vbGcxVzJpRUxXRktIOVhJ?=
 =?utf-8?B?czVRdWxoWmIwQ3d3UHNXOFN2NzRnWmhkb28wdFBINkFFSG5sRTc0MGVCNUly?=
 =?utf-8?B?WWYyT3FQMjRYbEl3em83ZTNZa3luV2RlTkt4L3Z4Y1dCd1RRcFVFczNLb2Vx?=
 =?utf-8?B?MkpIRGJjVUFsWE1veFVYY3Y3U0lrVlJUZDU0WElrV3hyU1Nxd1J4Y0JwZUpY?=
 =?utf-8?B?OHFYS3VOSTdNZzN2Mnd1eEh3RG5wYThNQzlZSVNSc2lyZlhScTRUdXVHMG0r?=
 =?utf-8?B?SXUwNzlySUdhMEtROUdST0dEOWFHd1k4dE92Sk91K3pLaFhPSHU0all5cWov?=
 =?utf-8?B?elpsdW5SbmQwK2I3elM2OXNlMEk2QlVnKzhPTzBTbWYvb0Z4NHRCdTZrM3h0?=
 =?utf-8?B?aG9jTytOaFhocndCbWpmWHVnUm96WG5oNXJBd0tTcDg0YjlpMk5ZZ0VRU1lQ?=
 =?utf-8?B?NFRPUXRDM2Y0UXlNSi9KYjIzZlNTS1dsNlByTm8wMXgyUEkxTEJLQXBlTmZw?=
 =?utf-8?B?UlpLWEN3TjlPUGR0dlpxNENDZ29oRTJJOEVsWWUwVk9NU21KdzBOWWpydldW?=
 =?utf-8?B?OEl6WGlyRnliYkk4UWh6RjI0QzlyNHNvVnJpRTJnSHRvNE9NT3pBeHV3QVNu?=
 =?utf-8?B?eTJXSjVWMFpvbGFsVms0d3lDU255M0pHeGZVSHVCVmlpYndWYXZKQkI2ZlhQ?=
 =?utf-8?B?MTh0ZENmVGVBSHFEYUJDN3ZSQUNockRaRHhieWZWMVJWZEQraWpDU3JyWUVV?=
 =?utf-8?B?OXo4WFJ4TmpQb2FLMXRvRFRjVjEwMXREUERMQy9nWHk5bXlwTjhPaTJJeFFw?=
 =?utf-8?B?MTNjNThsRjUwL0ZmZUIwaGFzYTR1UXFNdU50ZzRvdVFtOGIyS3dnMVNzenIy?=
 =?utf-8?B?SmZVdDJXVXVhYXVEZUI4djEyeXByVit2UlZHUmNJQlZsVGJ2bHRSZXIzQ3dT?=
 =?utf-8?B?ZXVsTmtuSnVmSmwxcHVmTURKR0lBOFZjVGFlQWVqTVQyT254V1JReFpaaEtF?=
 =?utf-8?B?dldSYjM4dzhRYjZzMnlZeFVDNlljRHE2UEx6S2FWU0huZ3R0Y21sa084cUxs?=
 =?utf-8?B?WFgrYWU5U1FSV1N5L2I3cEVEbG5abXNJQ2VpYkxzZ0dyTWRGcUVvdVl1enR3?=
 =?utf-8?B?UGlUbDJObFA4SThPc0FYOHVSSVlySGw2cS9Oc3pnSEZCd2FNYUFJcmJIcEJX?=
 =?utf-8?B?bEl0dWREeTNBdXNKMUdJTXNvZHl3dXF6bEh4VE5OTFpPa09aYzhvSU91Vk1W?=
 =?utf-8?B?b1R0U0JVM21EWVBudkhMa0hZRit1dHdrR3hORkUvL2xMWEJRTURObzQyQnZB?=
 =?utf-8?B?Ri81cStNeUVvbCtkdUNsWXR2dml0NWhObGJ0dVhPRWJzNGs0WmV5NG91cGZm?=
 =?utf-8?B?T3hkVml6dUQvdjFsYXdZMm1LL3R0UXpMdXdaNGVzT0JBNFNnR3dBbld4TGwy?=
 =?utf-8?Q?oMBOXb5A6S50w1rqG5oCnow=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02339db6-f9c3-4da5-b926-08d9da54cc79
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 07:33:19.6491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9xEdOLIx3BsY27dr1wa9PuLSFaAhC4+voxQU7PYJxvQBXQx6kyHvUG8YU209tLxnMa/Ttc7auJh4S8B7hYvqBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2888
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fb3b0673b7d5b477ed104949450cd511337ba3c6
commit: 55dc449a7c60d3df5a8f0b71bbae9d5173c864f5 drm/ast: Handle failed I2C initialization gracefully
date:   4 weeks ago
config: riscv-randconfig-c006-20220113 (https://download.01.org/0day-ci/archive/20220114/202201141416.VfNXpsi5-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d1021978b8e7e35dcc30201ca1731d64b5a602a8)
reproduce (this is a W=1 build):
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # install riscv cross compiling tool for clang build
         # apt-get install binutils-riscv64-linux-gnu
         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=55dc449a7c60d3df5a8f0b71bbae9d5173c864f5
         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
         git fetch --no-tags linus master
         git checkout 55dc449a7c60d3df5a8f0b71bbae9d5173c864f5
         # save the config file to linux build tree
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=riscv clang-analyzer

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)

 >> drivers/gpu/drm/ast/ast_mode.c:1232:3: warning: Use of memory after it is freed [clang-analyzer-unix.Malloc]
                    drm_connector_update_edid_property(&ast_connector->base, edid);
                    ^                                                        ~~~~
    drivers/gpu/drm/ast/ast_mode.c:1217:6: note: Assuming field 'tx_chip_type' is equal to AST_TX_DP501
            if (ast->tx_chip_type == AST_TX_DP501) {
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    drivers/gpu/drm/ast/ast_mode.c:1217:2: note: Taking true branch
            if (ast->tx_chip_type == AST_TX_DP501) {
            ^
    drivers/gpu/drm/ast/ast_mode.c:1220:7: note: Assuming 'edid' is non-null
                    if (!edid)
                        ^~~~~
    drivers/gpu/drm/ast/ast_mode.c:1220:3: note: Taking false branch
                    if (!edid)
                    ^
    drivers/gpu/drm/ast/ast_mode.c:1224:7: note: Assuming 'flags' is false
                    if (flags)
                        ^~~~~
    drivers/gpu/drm/ast/ast_mode.c:1224:3: note: Taking false branch
                    if (flags)
                    ^
    drivers/gpu/drm/ast/ast_mode.c:1227:4: note: Memory is released
                            kfree(edid);
                            ^~~~~~~~~~~
    drivers/gpu/drm/ast/ast_mode.c:1229:7: note: 'flags' is false
            if (!flags && ast_connector->i2c)
                 ^~~~~
    drivers/gpu/drm/ast/ast_mode.c:1229:6: note: Left side of '&&' is true
            if (!flags && ast_connector->i2c)
                ^
    drivers/gpu/drm/ast/ast_mode.c:1229:16: note: Assuming field 'i2c' is null
            if (!flags && ast_connector->i2c)
                          ^~~~~~~~~~~~~~~~~~
    drivers/gpu/drm/ast/ast_mode.c:1229:2: note: Taking false branch
            if (!flags && ast_connector->i2c)
            ^
    drivers/gpu/drm/ast/ast_mode.c:1231:6: note: 'edid' is non-null
            if (edid) {
                ^~~~
    drivers/gpu/drm/ast/ast_mode.c:1231:2: note: Taking true branch
            if (edid) {
            ^
    drivers/gpu/drm/ast/ast_mode.c:1232:3: note: Use of memory after it is freed
                    drm_connector_update_edid_property(&ast_connector->base, edid);
                    ^                                                        ~~~~

vim +1232 drivers/gpu/drm/ast/ast_mode.c

312fec1405dd54 Dave Airlie       2012-02-29  1204
4961eb60f14553 Thomas Zimmermann 2019-11-07  1205  /*
4961eb60f14553 Thomas Zimmermann 2019-11-07  1206   * Connector
4961eb60f14553 Thomas Zimmermann 2019-11-07  1207   */
4961eb60f14553 Thomas Zimmermann 2019-11-07  1208
312fec1405dd54 Dave Airlie       2012-02-29  1209  static int ast_get_modes(struct drm_connector *connector)
312fec1405dd54 Dave Airlie       2012-02-29  1210  {
312fec1405dd54 Dave Airlie       2012-02-29  1211  	struct ast_connector *ast_connector = to_ast_connector(connector);
fa7dbd7688849d Thomas Zimmermann 2020-06-17  1212  	struct ast_private *ast = to_ast_private(connector->dev);
55dc449a7c60d3 Thomas Zimmermann 2021-12-06  1213  	struct edid *edid = NULL;
83c6620bae3f14 Dave Airlie       2014-03-28  1214  	bool flags = false;
55dc449a7c60d3 Thomas Zimmermann 2021-12-06  1215  	int ret;
6c9bd4432b2527 Gregory Williams  2021-07-30  1216
83c6620bae3f14 Dave Airlie       2014-03-28  1217  	if (ast->tx_chip_type == AST_TX_DP501) {
83c6620bae3f14 Dave Airlie       2014-03-28  1218  		ast->dp501_maxclk = 0xff;
83c6620bae3f14 Dave Airlie       2014-03-28  1219  		edid = kmalloc(128, GFP_KERNEL);
83c6620bae3f14 Dave Airlie       2014-03-28  1220  		if (!edid)
83c6620bae3f14 Dave Airlie       2014-03-28  1221  			return -ENOMEM;
312fec1405dd54 Dave Airlie       2012-02-29  1222
83c6620bae3f14 Dave Airlie       2014-03-28  1223  		flags = ast_dp501_read_edid(connector->dev, (u8 *)edid);
83c6620bae3f14 Dave Airlie       2014-03-28  1224  		if (flags)
83c6620bae3f14 Dave Airlie       2014-03-28  1225  			ast->dp501_maxclk = ast_get_dp501_max_clk(connector->dev);
83c6620bae3f14 Dave Airlie       2014-03-28  1226  		else
83c6620bae3f14 Dave Airlie       2014-03-28  1227  			kfree(edid);
83c6620bae3f14 Dave Airlie       2014-03-28  1228  	}
55dc449a7c60d3 Thomas Zimmermann 2021-12-06  1229  	if (!flags && ast_connector->i2c)
312fec1405dd54 Dave Airlie       2012-02-29  1230  		edid = drm_get_edid(connector, &ast_connector->i2c->adapter);
312fec1405dd54 Dave Airlie       2012-02-29  1231  	if (edid) {
c555f02371c338 Daniel Vetter     2018-07-09 @1232  		drm_connector_update_edid_property(&ast_connector->base, edid);
312fec1405dd54 Dave Airlie       2012-02-29  1233  		ret = drm_add_edid_modes(connector, edid);
993dcb05e47e35 Jani Nikula       2012-08-15  1234  		kfree(edid);
312fec1405dd54 Dave Airlie       2012-02-29  1235  		return ret;
6c9bd4432b2527 Gregory Williams  2021-07-30  1236  	}
c555f02371c338 Daniel Vetter     2018-07-09  1237  	drm_connector_update_edid_property(&ast_connector->base, NULL);
312fec1405dd54 Dave Airlie       2012-02-29  1238  	return 0;
312fec1405dd54 Dave Airlie       2012-02-29  1239  }
312fec1405dd54 Dave Airlie       2012-02-29  1240

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
