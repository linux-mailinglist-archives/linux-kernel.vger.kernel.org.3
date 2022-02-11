Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D9A4B23D7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349236AbiBKLA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:00:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348486AbiBKLA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:00:56 -0500
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20052.outbound.protection.outlook.com [40.107.2.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854CBD57
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 03:00:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCG3XYMUiKd8+PQ1eJe7DaoneQNSZe0MsoQbfA+yRVDktMrSQZdrwnB3Qil6Gp6o1+5O4S9fNbu5wCC8tKAGum36l4Lsy5uMwuRlyHmskU9IkmSH36ARv5xNl6lRWuF+LoyIJKdYl0m4bS8Gz7JSbqdgmaNwnyibYWlqTm1D1QiE/nB6yv2KoHiEfpHAxFsh9P6FqIefUx15hf8IDeSiRgtOsuxlsO1WHCsCB2VUlXKVCFTg7SCt7DEX6a6Q+O7bEesygwxYpVwJRxl7t0DulLD+H3axnmRnk87j+LtypfAuVYH28vMCw7npujJ2vdQEx1CDRYca62FW4D71mvxzXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXDJdnTuLoyOVgOt3qLQGDD9BgSjp5iE/SxqXRsiUXk=;
 b=MzIG0NumqmH+uBtpqliT/n+n3k4u6fbEKcbvA25oR963DdWif/Hy0XtRq7pV+v/axLuN8YxVAbOxdUhA9RZ/NCmWZEeWDkvqdOSjTugNwtvvk6ZSXjegg3V2CvX3WOFKTfuyDB1YescJrXAUCYbkAb/s525WRtHeuF4NfRHoooB37FWwjDgQOIXYpqvIlBdfDfcEoWsgmc661rNI7TKlFSZJ9xZdVdYVc3lUna3sgIEo1KfeSr7dLjqSiqYsJ4ip8cUPcadEuB0whFfljCSVDFs57RZIuGSMknZDLFo340mMlM4Hd4RlgrHv6/DhjC9A0NLv7crglSNP/wKMO64KLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXDJdnTuLoyOVgOt3qLQGDD9BgSjp5iE/SxqXRsiUXk=;
 b=djWS4XmscnPI9D3xH+rqQEVjeos+cAOecKGO2lSC8x17C4nSxlY7fcr2a5IgOGM9vQYJHoXsBIVANhepkcsLSaMmNLCNBxteQTAzueW0I4ktD7OEQWIq8bJ2e4xiqp7Ilr9JQs2TYYWsL1jQzpIClueWMY8gen6DcrXvKQQFHgI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by DB6PR0401MB2600.eurprd04.prod.outlook.com (2603:10a6:4:30::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Fri, 11 Feb
 2022 11:00:50 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b823:3668:e8d8:beb]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b823:3668:e8d8:beb%3]) with mapi id 15.20.4975.014; Fri, 11 Feb 2022
 11:00:50 +0000
Message-ID: <3fd4a924-1072-2063-64fe-8b2540b5f292@oss.nxp.com>
Date:   Fri, 11 Feb 2022 13:00:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 0/6] bus: fsl-mc: fixes and .shutdown() op for dprc driver
Content-Language: en-CA
To:     laurentiu.tudor@nxp.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     ioana.ciornei@nxp.com, jon@solid-run.com
References: <20220208145928.12468-1-laurentiu.tudor@nxp.com>
From:   Diana Madalina Craciun <diana.craciun@oss.nxp.com>
In-Reply-To: <20220208145928.12468-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0101.eurprd02.prod.outlook.com
 (2603:10a6:208:154::42) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed675bc9-8cad-4ae3-6934-08d9ed4dc3e3
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2600:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB6PR0401MB2600934E19A6DF8254599EB8BE309@DB6PR0401MB2600.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QW9Zpm4z60uWmIyLql26Qt16QL7Bfz+niiWmsKp/6gNDQFphmv4OBYq0QXwmkc8NibQ4Wi5eb7uP5+XZt12+tdBvxfTUGOPNaOVCpd32UoLikX4yTppz8tpjeMBk/tcuSD4AAvyIZcWsfna2HftxVh0y3Vxdwqwpbq5k+1WnQgbzAhGdot7VnSHsEQpqsIJpY9WArKGo0d5A/9btjYkEr3kW0lP58VBpgSxjOSebYIiIwwuBGZi0doGuBeXDu/yD5552BtnU2BYISi0xZRKixhSyT40/RjV04mNFoE5p7ytkATv26cjfAfDDNa/HFzZ6yGl4ps9T0XO+W3inBxBQDdvtLoJbAq/R25uzhHU2h2leYenf6Ug5bcs3gtR1Kf/qZzBydjOYw1+H1KVknfymI7Lfu/AFqsq0Z5eXne+84FGsDUHQ1xD4d2SajhpZn2MVyRWlONYtQUUan5IJFxAaFxXCGcmFdvLiNBxE1cfPsCQM9oB21G5qROf5YgXN4Wzw8Hz+qS6tvFk1fJUKSf7MBnfk/K2zS8jXKtC6+cIgKdqXZVB8CH6VxLSK8tAGzAGNjwXELsdhG7+6361rjMKPSHHBRhCt7RY7IhKSFzmtI4JJPEXtVvtYdLKijS7WvA3GNDPFeKOujeR5D9w2993pH3f1ACXXXEmQ6J5KEnKQp1Wjp4PLUcRBSnTQ7cLKOmPi4RUPNJ6q6paZxZDSwem4A4/DveIMYSsROJAjpRRsQsDMTj0RS0H5C8sMb+23ILNEnc9LezX9Bv0vYFFZSF2Eh8HpqU9j2TrqDYV7PFjna3Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31686004)(53546011)(6506007)(6512007)(2616005)(6486002)(52116002)(508600001)(186003)(26005)(83380400001)(8676002)(66946007)(4326008)(66476007)(66556008)(2906002)(4744005)(86362001)(31696002)(316002)(5660300002)(8936002)(38350700002)(38100700002)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVFyb3UvMG5HY1QyMGlFekdheVpSWStWaWQxL3g3Q1o0Y1p3OGg1Wk52bkdk?=
 =?utf-8?B?SEJ3bEF3R09qeFhjRzhDNFBLbW5MN1Rsb2I5K3Z2cGd4V05SWU9Sdk9QVG1W?=
 =?utf-8?B?VnI1K3RBSk9NbzRXWmYzdW5qdkJLQVRkM0o3R0ZUbDlBZTF1cXg3TkFXZzhT?=
 =?utf-8?B?L2tqc21SdHRRaDltM3B4Wm9mZms5RzNHaE1VNUppT2t4cnBmc0FnMjhNRGVy?=
 =?utf-8?B?YVNCZjRDQ2xPRE00UmxGckpFWW5WaThKeXdNMTgyNmRaYm52Zy9OMXBhb2Jo?=
 =?utf-8?B?ekRCVitRWVpPNFIrL2V1TEpJU3pCZ3E5UWRHRytheGtsMUZZbmJmNDVtVzVP?=
 =?utf-8?B?OWQwWUR2dVU5YmxTYk1NbTdvaXNvcll6NnZpbDI2ODlhRFYyeFdFREZVRGEv?=
 =?utf-8?B?RkkySjRLTkh1cHdZbWIrYVh1WHlvSUI1dHZFZTBZWlhXejJNa3dGOUtPbXh5?=
 =?utf-8?B?ZzAvZG13ZzdjdHlRZFEvMEVtVHRKaGlZSnhoWUR1T2hKVytGWGpqaGFaOWtG?=
 =?utf-8?B?ajkzb2paejR2UVRLcnYxWVdGWW9TT2JhV1U2NWlMcE1XelhGbHplN0ROaVIz?=
 =?utf-8?B?bi8wbDZzRTlOSEd5WStDL2h6ZGc1TUZEYS9mSGJaOUgvU21xN3drakxldW1i?=
 =?utf-8?B?U3g2NEhvL05DclNvMVBkRE94eDZPRStaTWZncnV0WktLbWtNVElXV3RQaDFr?=
 =?utf-8?B?SUpIS3lFckhIdEx6S2JJaGwrbmNLRm1HRE9yV1lBRHp1UzZtSjdkTmtsYzM1?=
 =?utf-8?B?bVY3a3BmWEEyKzhTanNVQjJJaDFLRHhnY2lmckNIdEliRUdvTTF5VVViOU5y?=
 =?utf-8?B?Q3c3VXNCdEpjMm5sYkh1UlRHTk5qVm5xaFZNWVFjaFRscXRFT3FNM0RIK1lq?=
 =?utf-8?B?MVhaWEplbXdCTmRlNk53ZXVBSXZ1eUN3RERGV1FsdGgwSlBNcVpCL0FyWHNx?=
 =?utf-8?B?aXM2MndDZEd2OHhPQWZiT0hDTXd4QldoNXlCeG55WkpoMk1PMVNhZUZtVkZV?=
 =?utf-8?B?bEZrZi9DWW8xejRlcit1WjFmeWhEYTJEMGpUbW01bWZMcnlCRXZndEVJRHlT?=
 =?utf-8?B?RkJ1bkgvUXBpcFprbXlTMmxZaWg5T3JWbEx1Wjg2Z083TWRUMm84MmZzZmtL?=
 =?utf-8?B?TWRMS2FxUDBBSFh2Rmh1NzRDdGhOT3U4akIzRysxdlZ4OWgwQ2gxdmVqZFBy?=
 =?utf-8?B?dFBSTDNHeFZBM3dlbFBhT1l1Q09ERnBlT05JaWFjNU1yWHMxYmkxalk4VFFJ?=
 =?utf-8?B?cUlmYkU3MVlXUHVZNEtDSnBIcWU4YWI1anlvdlNZRDREWVlUQWhtL2VXbmJa?=
 =?utf-8?B?UDNtUE92Q01VQ1RBc2hGdXQ0NFQvczV3TXlrd3NvWDYway9hSlB2RVV3dVFI?=
 =?utf-8?B?V21UZlUzUVY0alRWOUtyY2t6TlllZVlrRjlhNnVtT3ZVdEpLM0sybzJpK2dX?=
 =?utf-8?B?bzVVdzZ1b3dnMzZOTnBDNmN1c3lwdGZQakQvY0ZTS240NFZvNlNqMHJIRy8z?=
 =?utf-8?B?WkRYaW4vNUhMRTdWUGRpS05PMkN2NEQ1enBjOVVhblZCcS8wSGMzLzdKcTBP?=
 =?utf-8?B?TXJHYXpsYVpmU2lJcE5MYmhWK0RvZnUzWllTbWJEK1pSOHlQVTBTZ3IrUDhG?=
 =?utf-8?B?YkNHZzgwOHZpeGROenFUWTZ3RWs5eXI2dzg0TTdWczJmOU1Wd3NpK3p4UnJ1?=
 =?utf-8?B?L0JVRDFxTXY5czJOUzZITDQzUFlZeXRrYm5LYml6RkpzUGNmYUFGQ3A5NHpL?=
 =?utf-8?B?bVRPMGQ3UkFJRlRsOXBONVZER3dnUFV4VEkyM0dvRHFLWVBJRlBDWHdibnE4?=
 =?utf-8?B?ZU1Wb1FwR0xWT1JyNkhtcGR0K216eGdSdnZnVEM4aWlCdkZYOGNaRnhZbUR3?=
 =?utf-8?B?N2haVjhabnBlbmZpTGFzaE5NRWViNEVZWkdSenoySGJXWnN2UDJiZWxBSXAy?=
 =?utf-8?B?NkRjNDZqUUY1L0FCcjdCZXFSUS94MmhlKzArN1dLWGFtMm1QQnRFRTY4K1JX?=
 =?utf-8?B?cTBFaG1Edm1ybVpxdWF0RzZ3SkxjSVI3eDlGazN4YUdhMG9YMHFMQU0vWnd1?=
 =?utf-8?B?NkJRUXBPOHVyUFQraDlMWmJpZkoyQktpV05DbWQ3eGR4b09jZWdEUEhVWVRI?=
 =?utf-8?B?c1NFam5hcC94SXBoUUtRbldEWU12TGgzbFltV092cWdWUmxBMFhORnEwZXlk?=
 =?utf-8?Q?unFJ6+IrCjW7hkFwkEu7EhY=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed675bc9-8cad-4ae3-6934-08d9ed4dc3e3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 11:00:50.6861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FsD+Hs2ZU6MvMQbHOEA8p3jQnORm8FQAQoLpZbQA6j2OK1zEnFVoYUWCF8dsUid5pfka0pD6L6rkt7E4piwmxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2600
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Diana Craciun <diana.craciun@oss.nxp.com>

On 2/8/2022 4:59 PM, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>
> The patch series addresses various issues showing up on DPAA2
> driver bring down, fixing scenarios such as kexec, bind/unbind
> and halt/reboot. Most notable change is the addition of the
> .shutdown() op for the DPRC driver.
>
> Laurentiu Tudor (6):
>    bus: fsl-mc: drop useless cleanup
>    bus: fsl-mc: fix a use-after-free issue
>    bus: fsl-mc: fix double free of the root DPRC fsl-mc device
>    bus: fsl-mc: check for null irq array
>    bus: fsl-mc: move uapi misc dev create/remove in probe and remove
>    bus: fsl-mc: add .shutdown() op for DPRC driver
>
>   drivers/bus/fsl-mc/dprc-driver.c      | 61 ++++++++++++++++++++-------
>   drivers/bus/fsl-mc/fsl-mc-allocator.c | 24 -----------
>   drivers/bus/fsl-mc/fsl-mc-bus.c       | 34 +++++++++------
>   drivers/bus/fsl-mc/fsl-mc-private.h   |  2 -
>   4 files changed, 67 insertions(+), 54 deletions(-)
>
