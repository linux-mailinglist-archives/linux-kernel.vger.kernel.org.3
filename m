Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2343F490B04
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240200AbiAQPCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:02:07 -0500
Received: from mail-dm6nam11on2052.outbound.protection.outlook.com ([40.107.223.52]:35169
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234686AbiAQPCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:02:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejgZ4g/EBzMetXdtqGfOo9S3ez8O70Qy9zFkNJrl/hsnOREDFJV+RMLbvl3NzU+fL8rwBZogV5LT9Jdv9OSb12WKpIDxaqi1dHhpaWgJk9QU5ux2E1CZZxNczqDhJA1bGhHgv0h0ChFGSryRTjthI4DZ0i41teq1ubTSbQedKHCZUnIiG4K4x+krH1eqAH3bGpI5mbJCmjj3v7UiQp8ZB+4gnsad1a20W6e3XHrswtu8H8ZxxIO5UkfaKzMvwcVal5KgMV5nLIrvWr58Dh+Wa9d9YEMVRJ6HuJ1HsOu0v/puWXrVAZIYPikBvEU1qOFz+SlbqGo20I4ULMqq5CQXKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuAtDJFlb409jusSrbgIqV+q+6O4+iXOvQkPh5zkBWg=;
 b=CVrChH2GykmL0bsJQYQoONby0yZvIHLNb9PDUYeppBEhrAiaqdpTYzGlgdTfHTtEinUIGAacVWL01CCQCHDkkC3ej8+IdAWnDduvaCVxm8Z8XQ5oRHy4851JFXDwaTdzE8wKYbJSKmjZJ8H7LQzJXgTZ+km8izkV+rtYIXWTajmYR5EHB29xmCcbNsYYAKdLHZGuaigIGulMgRW5+2ZhFyxQKBM9HYnDfLwcZVz2GXiu/6L+YKwdt/m4J23wrrta0ojaveQz6zFB6KpMAhAGn3iskPPTxStOokE4RbFxzsf20tojgqek2C5ARqyEM0a+5qxvgPpjBI0HvOSa47nt/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuAtDJFlb409jusSrbgIqV+q+6O4+iXOvQkPh5zkBWg=;
 b=fNvB/c2ZN/RnEXQWjzdB2qEh8WpNEmlShCgObn98gPYfS+r0Db+St+l0yKXdmgxSrs/75Xpog/3Rwrru2I5q1bbU18kYvY5qAOnJCw3vFTHhALJr5Tw+vjWkxhAL3iGcwS1f/K4swiV7cIUrJrKqhmFBZpPRibmuy4IRrM9yoI40uUvBtd5cBiSafHIHW3MJwSEH7jTlMMBwlvrrrifERFESm5u0BQYo/YWv0e6zP2fsa4p3tW2jAGwzRLWFKJ5D47bUXNFXi5oPaWj54Lek5kkMqXmVReIdT79anllhPQt8HiJivcOoc83ZoCnHpw74rhAT/lgdbE3yxoxRYkiC5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DM6PR12MB4729.namprd12.prod.outlook.com (2603:10b6:5:7f::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.9; Mon, 17 Jan 2022 15:02:03 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b120:5877:dc4b:1a7e]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b120:5877:dc4b:1a7e%8]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 15:02:03 +0000
Subject: Re: [PATCH] usb: common: ulpi: Fix crash in ulpi_match()
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20220114100217.59541-1-jonathanh@nvidia.com>
 <YeV466hTEyDwvmyL@kuha.fi.intel.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <170d3614-97e3-8494-ac87-37d11dc48770@nvidia.com>
Date:   Mon, 17 Jan 2022 15:01:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YeV466hTEyDwvmyL@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0243.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::15)
 To CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f61c6e9-3caf-4c3f-21a0-08d9d9ca51bd
X-MS-TrafficTypeDiagnostic: DM6PR12MB4729:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB472909E4A8EBC77B0F3FD74AD9579@DM6PR12MB4729.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3K8ZTOLqXkd/N+H40d3Xwt2MOTelFg2ykANq+ggMIN87GlW/YG41tK4zOvGcnPM3UX8ZFxDWl5iMG1Q2Q3v4JRC9yZKtD3YhDzt8lPNppG7w3jwDIwzChVDzQQH1En96zdOWgFiP+OkwVxlfC7Sh9CXgbCClTnZUAfBmrJWFDXKYhXwS16iet0VAa4c2bXm7/fVpJAgNPUg5tr+m7jswcmKi733QP2nmJutmg2SndThew+VGw7eFsx3pBnELqzzdXJKaA0RJ221oCqYWvRRPmYukxKgGZ2expsnY9QvTrtkK28HcHYaMPG+uzYeFh7NTlTZsbpuRAYpQSzpxp6857UFLJWL+buTkyMmkbI9HARhV7qDeP4pz21UwgUxyrMPe+l9Ubhdzal2RWnhwmhjOC6AR9X2UL0VSXFlO4mRZAz0aZedsJQQOsjcAee2Pd4YKUH2o89zT2T0vB2V5MwuyXeLP1bpoIpYjMAc4OV9CA4kEAMY3fwSBBDkP03rlNs1A138r5Kj8YIwIkFejSpEcOc32v900UJioRwJS51ffwoW6sGtFyV/6TRJBnT/CyuOcci10tKbG7u0Ul/xsBXiLCvEjhyx+FyoHRgK0v8ZccaZFfDtLRxmfszBdLQrMS2Ua7LYn1S8V+d8ypqt9TJhK89ZLTtFPxaOT/Wxr9fYE8lzSm2iGOPESEcodsqdovrwZ6zEy5rv6UXRYg4Pg63Y2ohyvb69ZyNtb32Tf0Hz09nxVef2caL2hCdU+wJTauGFo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(6666004)(53546011)(31696002)(6486002)(55236004)(36756003)(2906002)(6916009)(26005)(8676002)(4326008)(66946007)(66476007)(8936002)(38100700002)(6506007)(83380400001)(66556008)(186003)(508600001)(54906003)(31686004)(86362001)(5660300002)(2616005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHZ6U1AxdG4yb1cyRmlrdjArVHJXbUZGd1NFZExod0dXQmlLMGVaMzhTbUR3?=
 =?utf-8?B?Zi9tc0pPUWZRQlB2cDBXTUtrdy8rZUlHVEZBZWVuTFNsdENsWVZvTkRCZjM4?=
 =?utf-8?B?OWlaNldvRnZpbUJQdC8vYzJtdFQyU3lrb1A3c01uNk5tLzdKNzR4TnIyMnZi?=
 =?utf-8?B?endGam51WGE3RzFlRkpkNzBnTEh4c3I1MlVyT2Y4cFNMWDBzb3dNZVNQN0c2?=
 =?utf-8?B?TTMzMHNIajY2d2YvdjcwWkptdHFGQ3pOcUhuRGlndDV5c01NeFBsWnVGQitI?=
 =?utf-8?B?RVZtRTczTEFqMncvUEwrN0lHcE44Q29VTEZCSmt3TFhLYTRjUzNKb3pROEt6?=
 =?utf-8?B?T3JFa05LUVkvNTVhT0pkT283YnVNbWRNcjg4SHQ0ZG15RU9reFdJUVYwVTRx?=
 =?utf-8?B?TExpeWw2S3hEb0w5L1lIZXlVaFB6US9iVUJSUzlFNmVTSHBIMjZtRGRVTE5k?=
 =?utf-8?B?SDcxeTkxSFIvQUlGc2hMVjE1MUMvSC9Na3JNSkQzempZcmdqY0JHbG8xMXdu?=
 =?utf-8?B?R3FUS21XSjNqbi9Sa3ErNVZRWEFPbFU0MnU0SEZRbWRUZ0IrQ3lnL21rSkRG?=
 =?utf-8?B?Yk9RcDl4VFpxQ00yRU5hM3ZOMWtiZDJxeFZoMGFrREVKWTNoWXNoUGliWVBV?=
 =?utf-8?B?VnYyRmxPK0ZJaGROOURnb3d1eHYwemFiWUpjQSt3V2MwYml1SFRIWG1ibDZw?=
 =?utf-8?B?VWhrR3gxMzR3ZXAzdWhPMlJzQjdZWHFwOFo3QXBlR1ZkZFE0Ky90MDJLYlNz?=
 =?utf-8?B?ZDFkb0dXQjBQL1U1L3AzVmxuaXpFcDB5ZWZ0c04xVExPWE9BbmxhcUlNU3lU?=
 =?utf-8?B?U1E0UUxjVWF1dGx1YzVEU1l3Njhkc051SzQ5OVFEcDdwbjhGUFFLM1M0eC96?=
 =?utf-8?B?eWs2YnhNdXJ6RDZ6bEIvbyt1UXAySGEzQ2RKL2xHM1JJQmlIbzFZUzlIazlU?=
 =?utf-8?B?MFdUcVhMYnh5R3NodEdrS0pReUlCdCtUcURiMzRXcXNEMi9MWnM2blFmMGFw?=
 =?utf-8?B?aFY1aFVkSXVYeTA0Uy9vRXpQVjRnQS91clgyVVZVd1NDbGJlSk4wTElJL09l?=
 =?utf-8?B?OEpaUWw1K3VDeWk0UUtaWkprUnZZQllBNUJvcnRrK1QwcFdpYUdwVExpUENN?=
 =?utf-8?B?amt0K0hHU0hiczBSNFpXQTNDUDhib3YxM21BU0N3NXpwWEQxR0NnZlpUSmVn?=
 =?utf-8?B?ZFE1L0NLS3EralhHK0hqUGp5eEpaVHN6NnplU1BzclA4UjdjU094dzMyZXZo?=
 =?utf-8?B?d0dyMksrcWlLN3hTS3hiWG9aMlZ4TTQwN3dFUGFpOE4xZ2hWT1R4ZGhEUlNu?=
 =?utf-8?B?M05rQkVPUkhlOEhSNUtoRE5sRUJHQ0RuL092cXJ2OFVOOEtSd2VTdytSRFFh?=
 =?utf-8?B?UkFranJiSXV1R2dnYVpvS3hqaGJIbVBBS2lyKzVXTzhKVmpJZ2lqczFtZUhn?=
 =?utf-8?B?Um0rTGk4L3J3RUpyaS9RczQzU1RwZjRJTzlBVkpaaXltZ0F2R3ROVTM2a0VZ?=
 =?utf-8?B?Z2M2S095QStqZm9UdzgxZ2orcDRrWDRuamJJb1hpSWt3ZnBqcnhMR2RDazhS?=
 =?utf-8?B?YU9IYklZME5Pb1BHbHgzK2pLbXBtUkpGUmZyY0pWdTB1OXY2clJubk15LzJS?=
 =?utf-8?B?Rk5TQjdRdEFIZlRLaUhXb3FXTXBOYzNBSWp3WVRoejltTjN2ZzNZNVBKR0FZ?=
 =?utf-8?B?SmdvSCt4VjM5MzdubE9ZYUw2N3VBcmhrMmJCdm9QT1lhWDBIOHFoUTIraHk2?=
 =?utf-8?B?ckNSSmNHOW10V1dicWFEVjIycWQ0YXZyTzdBM21pQ3pUeWd4Ukk5d1dmelk2?=
 =?utf-8?B?YlUxZkVJbS9hM3U2ZkpyOGJIRUNNNVNYOU1wdDcwTHNYVHkyM1pnRUJHSEh5?=
 =?utf-8?B?QXNQTnVmMkRsb2dTT3BRakRzT2NhT2NtQkM5TlJkOTZzWjRxNENpRUZ5WTNj?=
 =?utf-8?B?RzlaZmV2aTlZV2hRU21jWjluVXVRK2FLcmxIbUo1eU9vcE5WQWtualNYTnZz?=
 =?utf-8?B?VzRZeWtScGxIbmtmSEp3THB5ajhxRmpEbXdQVnVHODlhUzlreU1wZWpDVG03?=
 =?utf-8?B?d2ozWjlQTHkwUUd2SkdpS3FUQ1pRdWVVTWw0RGdFNnoxMnJJU2UyRWIxeXc3?=
 =?utf-8?B?ZmV3ZTYyRGdWYXQybVBZVSs3VEVUelFpU0ZEOWNmdjBsU1VrQk40M0VDeFVZ?=
 =?utf-8?Q?6vNrKzq8wdwkKPwOeQwms0g=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f61c6e9-3caf-4c3f-21a0-08d9d9ca51bd
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 15:02:03.0106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tZjoA/QUzMGUY/trcJaesmCJvDqR2XpQs7mj8tw1Cz7N6GPdXxbt4nIJJIhATC+a6GpHByjI4x1EJaMsPmXwbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4729
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

On 17/01/2022 14:10, Heikki Krogerus wrote:
> Hi Jon,
> 
> On Fri, Jan 14, 2022 at 10:02:17AM +0000, Jon Hunter wrote:
>> Commit 7495af930835 ("ARM: multi_v7_defconfig: Enable drivers for
>> DragonBoard 410c") enables the CONFIG_PHY_QCOM_USB_HS for the ARM
>> multi_v7_defconfig. Enabling this Kconfig is causing the kernel to crash
>> on the Tegra20 Ventana platform in the ulpi_match() function.
>>
>> The Qualcomm USB HS PHY driver that is enabled by CONFIG_PHY_QCOM_USB_HS,
>> registers a ulpi_driver but this driver does not provide an 'id_table',
>> so when ulpi_match() is called on the Tegra20 Ventana platform, it
>> crashes when attempting to deference the id_table pointer which is not
>> valid. The Qualcomm USB HS PHY driver uses device-tree for matching the
>> ULPI driver with the device and so fix this crash by using device-tree
>> for matching if the id_table is not valid.
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> 
> So is this fixing commit 7495af930835, or perhaps commit ef6a7bcfb01c
> ("usb: ulpi: Support device discovery via DT")?
> 
> I would assume ef6a7bcfb01c ("usb: ulpi: Support device discovery via
> DT"). Please include the appropriate Fixes tag.


Yes that does sound appropriate. I have added and sent an update.

Cheers
Jon

-- 
nvpublic
