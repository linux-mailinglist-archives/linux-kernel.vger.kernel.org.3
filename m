Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F499595555
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbiHPIbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbiHPIa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:30:56 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB53133644
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:51:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EM+l7mrQ+i6RF7GqITctCW58ioKO8fJyfzhJtjiTBhQOV2IBGv1TeHbgwIwHNdJtNSzow/cq7t+uvCtgJly3e8+AEX6iIlCQiluckCmTe/77fgIAnsuvTkqeQ0dUZB9cGUswGXxTmTlIaXsvIYNRfHxMKLTmsZD3SXKU1Ta5jDTH7jXOO6vmB/zuTv2sViCA3p43j/gYcJ5wfWuD2FcUeMwdzqfH28txAENdGoCoFjkswF76Dr7KhhEJPsjmf0rJaP38gtmWV2gyNxlN2X+4EHnOB8jQ1UorSU+x0Vss6m5kCfAJOD64IUKOeAjVk2asB18F/Hf1eFhD1qAq57BqqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOVPEDKo4w1hdDCRuD/8yTDcHI+6X0LO2KTNuyME3Ts=;
 b=YWFUVSm4Dr1p8aQcl9d4hMrpAawiJsGtz/shHe7IjhHfxkuyzSxJvnOhyW9yRqvllSWDgbtu1U6dZmndxH5QNT4NvhXVh7xQFzDM93pFeHi3tv8B4DjJY/i2NZaNM/8Mxv7Ekfd28QJ6Hr2DoRwmgmyVTAsiD0LafClWWtg6ry8fwcHWcAg9YRQlvz146LgRY0D1SWtybxfNBVnE8PmJm3mBBxKLI04vykSqg8lSczsEtVMNwLzjiIn0FiV73RxpmUmzRxSB4GICy7itKywpfwPYvDzVs+FCD2AoPxXh0AUFPNhHKx25IkOmzo+AJw27YSZYxvQy3BK2c6USITWLSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOVPEDKo4w1hdDCRuD/8yTDcHI+6X0LO2KTNuyME3Ts=;
 b=DGtjpNuFlNs9sy9T6DdT2/wG9JzyErKNsfKFuplEzTjjXCtrFAmRGaXbblFYQLzw/0X4h/jwIXGJqv47An1Y81zp2LLGa8CFXwzVhZnHvPq7BtrZe1il27qo73iaqQ2W91gN/MgX0JbzXYh550BsGxeLEiIkCSWd4/dNPrUVeXI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3661.namprd12.prod.outlook.com (2603:10b6:208:169::31)
 by CH2PR12MB4055.namprd12.prod.outlook.com (2603:10b6:610:78::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 16 Aug
 2022 05:51:00 +0000
Received: from MN2PR12MB3661.namprd12.prod.outlook.com
 ([fe80::bc80:d6e7:d73f:d955]) by MN2PR12MB3661.namprd12.prod.outlook.com
 ([fe80::bc80:d6e7:d73f:d955%5]) with mapi id 15.20.5504.027; Tue, 16 Aug 2022
 05:51:00 +0000
Message-ID: <2af89db7-4a1e-18c6-b56e-f0a7843d9b2c@amd.com>
Date:   Tue, 16 Aug 2022 11:19:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 10/13] ASoC: amd: enable Pink Sardine acp6.2 drivers build
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Syed Saba kareem <Syed.SabaKareem@amd.com>
Cc:     alsa-devel@alsa-project.org, Vijendar.Mukunda@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        mario.limonciello@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Julian Braha <julianbraha@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Bard Liao <bard.liao@intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20220812120731.788052-1-Syed.SabaKareem@amd.com>
 <20220812120731.788052-11-Syed.SabaKareem@amd.com>
 <YvZeNDg++YwEsgdI@sirena.org.uk>
From:   Syed Saba Kareem <ssabakar@amd.com>
In-Reply-To: <YvZeNDg++YwEsgdI@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0108.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::12) To MN2PR12MB3661.namprd12.prod.outlook.com
 (2603:10b6:208:169::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67446675-2d91-4417-882f-08da7f4b4c3c
X-MS-TrafficTypeDiagnostic: CH2PR12MB4055:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xuuv7wvSN0JQMegZJW501Ps3Js/hdI7uZ9AeJQ8YPXFCcyOuuHf8gNjrNDAMBB6HeYHV2jH7M8P0XeXLdQ50/iUgMj/fsvTK9Mm7RnXcmAvKUc7JsMYCRBBGj8o7Rp4mvbA1RdhYrtDzOAO2zh1CahzLqWHzxFua+ypD72iiZfqAfTCORZYbwnr8ILe7pMQr76kjYGo30QcEOW+Cz//bLvYUtgL/d/PdLB+KKzgbteEy3HtKJtRy7npDccXcv0/5rlYdXUfptPYQc35WqTB7zvyUb6HBlZCQcihnDMca0QnPD3/GtKtr6t0CtUQWiUy0tC0g2yWVu4A6j8xdxiH77X0zVy7yNo2rALfHARmPiUC4aj5kzElqnXMEdkOF16WuedcsQiavB6a5JAHS9q6d3Bd00I7kd8boGj6oWB/RVIqnWarFbzv2nZ/85UEDa+F75CZhdKaQZJbc2wtJvRVNan4bMf9uw7kRDzTUvIOAgaXerjcGSvbLSR3EviVR+uPc2iIg9DVScoM3Wo0L2fnE3GppF14usqtmYn0xPINGe9mdkw71QoQYF1nrevlXDOCtpuPtcREjvHWzAut4aO/Kqhxk7BN1sw6pxUkUxvTAttDLO9EnMExw1aphbE1jkTXfeKptsbqJsc0bG6p78DeP5COlGlPtiLWuGtLzh/6tvMc4dFWqhT2LNYXVyszYetzG/HUCOxdfr/uE/CuXKyWzhAiNcQwbgi4mTm8NR27ZsbZYnBaR+gqrscKQC/eDVW5sr9MeO+IY10doiQgVnOp1Du7wLBmroXSJE9jWzzz50BVJatdRgRG9ZenlnDdGnjTlSa4KYQyyfSK+0CQmUxhW1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3661.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(31686004)(7416002)(8936002)(186003)(2616005)(36756003)(26005)(6506007)(6512007)(53546011)(38100700002)(316002)(54906003)(558084003)(110136005)(66946007)(66476007)(2906002)(31696002)(8676002)(4326008)(41300700001)(66556008)(6636002)(6486002)(5660300002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2l5S09YT2ErbXRZejJ6ZFo5aFZuTE5pSTdsWWhHc3dFOFlyeXR1Q21DdUdl?=
 =?utf-8?B?ekZvdEdhNmROS0Z0ME9kV0lZcDNReEVPR0hZQ0QwaDFtYktNb3NEcVJGMnJ3?=
 =?utf-8?B?aHNINnBlamtYN05kQVNsM2xJQVJacE91Vkp4cnd4d2lsamI5TEo2cmREWVJI?=
 =?utf-8?B?dnFlaHZWMWMyMmZHejBIa1Z4SnI5Uk84QWdBSzdYUk40ZXI4NFRzNldjVlMy?=
 =?utf-8?B?S09sOU1WelE5NE9uc0Vmb1FzZlZFRmttRlFHem1YK1RaTkxvbml2N1Z4V0FD?=
 =?utf-8?B?Zm9jNnhPL1pSUm55TnlNWjN3eGgwNU1NN01RUE82WFI2ZmJyZ1VaV3F4RjlW?=
 =?utf-8?B?OEVUNDRiVE81cHlhK2V2LzVrWTVWRGVnRHhaQVowSWJPbTg3dS9GY2dtSGIx?=
 =?utf-8?B?a2hQMkg1L2JJMzAxN1FZQUhXVnpsZkc5TFpNb1cyZGVVaTRmZGYzM242Qi91?=
 =?utf-8?B?aVZUKzdQeUtEWHNJSlVyV3FJM2hNNktjVnV3ZjUxeGNHUlNLWEk3UmMwZ05X?=
 =?utf-8?B?cGROUHpENnJBZWtBNDNsc0x5ZVNVWGVuaGVuWXhycThlZzczK0ZZT3NDU2k5?=
 =?utf-8?B?VjF5SXpiaFNSbks2WkJIUkdQc2xZeFM0TXVEUUR2eDYwZ3Iva0I4aDJvbVJj?=
 =?utf-8?B?bzd6a3lsK01mUnRRR0xLN280VmI1ZlJmRWk0ekljQVpmVzRHUEZaQVRtaHhJ?=
 =?utf-8?B?UWxDbGdFMUwwblh0T2JJR0djUUlYcHVqblNZaHNTZ1BCempXTEpxd2wwUUM1?=
 =?utf-8?B?bi9qWnI0U08yV29TZkh2RENSYmpNYzB4U1laOGVXb1lQVHFXb2RRNkdsVlZ0?=
 =?utf-8?B?bjRZTFNid0RDSjJCOFVaS2xhS29xV0ZVd0NzcVhiYkQreVRYQ0kycU4zTkk1?=
 =?utf-8?B?dHJBMWczTGI2ODA5N1FUeS9OYS95UGhQd3JCcXZqVmh2WUpxcWtPZVh1Wnlx?=
 =?utf-8?B?QzhyQUQzTG01Qm13SGN1TUpoSi9uazU5UjlNZ2NtdUN6aG1Cc0tJVmJweFh6?=
 =?utf-8?B?RFM4OFBaR1hCQXNZTjkrSkZPRHowL1hiWjF3NFEycmgrNXc2OEpPTDFIM2sx?=
 =?utf-8?B?eklCdU1VN0Zub3ovZFI0aEt1Y1l6cjR3bWhUMjRsRDI2Ym5ndk5ORDdaOHBT?=
 =?utf-8?B?clFGQlJwZW1GM3QvNVhNVmVhUlhEdWEzLzIrZk9renUvQVFmeVJia1ArM1BN?=
 =?utf-8?B?eEZVc0FlaGdlNWhVWkZvaVk1UHVLOFh6bXk0TE84ODYyVEFiVnNZcGFIMUdX?=
 =?utf-8?B?YTlPNzZzcTVuZlpsS0dPZ2VnbDZkdk5WMStHVUdpSVc1S0RRQVVwTG5wOVho?=
 =?utf-8?B?UHI2RkNIM1o0Q3JnTTh5NXM5QTZuUzBFd1p0Z01RZGVKU0J1ZlNxRDM3SW1s?=
 =?utf-8?B?MENzTXlpL1hhR21OQ1dxRzd6T3JzMDZqcEMrZ0Q1dnBFRy9VYTZSQTdTV2Vs?=
 =?utf-8?B?ZEE3akVxbUduRWdPWUJDdEFXRUd0THhlTEErL2UvMW1xR2dsTGNiM0hWWDJy?=
 =?utf-8?B?VWFFMG4vRUJGNEpJamRlQ2grdDF0bUhmR2svRmdUTjJxMW51N1pkQVR3eGgv?=
 =?utf-8?B?bUJaQkdhME90aU5nOUIwdFlZb244WDFkNUJNUWMyM25ZMFFRRlZSNjhsOC9F?=
 =?utf-8?B?bEIzSnI3ejlUb3FlSkkranJnQ092ODZpMWpQU016Y2FqcFlpQk9KOU1oQW1u?=
 =?utf-8?B?NWQ1WEFMcVhRN3JJVmxLTndzZ0g4cmlKekM5MFdpdjVFY01jRDJxU2RCTHlL?=
 =?utf-8?B?dFFWZm9ZK2JKelN5Um9MQ0puRC9jNVQ0bUtCeHB5U1k2aXQ0ODZjRVc5cm8v?=
 =?utf-8?B?YkVHRWs2WDNDc2lpdFJta2RiZ0lWSU40dDZwL1NiZm1TTldUajk4YVFYb3hu?=
 =?utf-8?B?YzRwcitLY1NaU3FBSE42N2RPVnhoTXNKU3crb1luNVd2a1FGNnB2alhuWmNK?=
 =?utf-8?B?RlRCc3JuUlhIRXRBaFN2b3dXV3h1SVdPbGp4OW5ja0dKNnVBOFl2bm5QUy9U?=
 =?utf-8?B?SnB4RzhkdStVY0F1d1FyRURkbmR4VFNXR3N6T2tDd3duc3NCdDFNeExxdUxt?=
 =?utf-8?B?bHFsbkRTOUZlSDlWbFIrdm5DN2puY3ZvaGMrOGlPWENkMlN2RXZ4cUpPU05n?=
 =?utf-8?Q?gLy9XstVgXNFxXb0CFisR1d7g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67446675-2d91-4417-882f-08da7f4b4c3c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3661.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 05:51:00.8093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARSvdvqdpjj6ckYdf7L6qtp8jpzhMhT8kH1iS+fzcj2PFhyiPk8Bk3mnAls0ERqO0AmDUFXhDBxgNsb/w+Hpig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4055
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will fix it and Will resend the patch series.

On 8/12/22 19:35, Mark Brown wrote:
> [CAUTION: External Email]
