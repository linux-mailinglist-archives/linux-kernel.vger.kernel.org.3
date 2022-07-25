Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2F957F9D8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 09:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiGYHGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 03:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiGYHGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 03:06:13 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2332F9FE0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 00:06:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tpj0U1bwRhq0yapZXF4ZxSIT07gOLqJvgG+vSnNdH/POt0SEJ6OGVRX8qdq5EbrEpoD+s9cXLKeuLzJq3TcF5BZuXbiX2yUI8c35j9Jer+gNUDRYGDKb5RfCP4J6YrtqYk0/rllYTx8DDbF6POj5WMeeNtuDfWDA65H3/UwsoK6dkdWaz6bKpCkMAU0s7QmyIerVqDHASBMpz44kdMsm0eCK/Hcd+D+zHRlzuEGgJmnRrDkmAfnVw+p7SnE5M87/sFXyD4qIfJ+AZQKv3qgnVcKXrubaIg4dj07LwFc1ALWSmv8+k2ZgEhkm7R1W7fy8tk4PRUnncpD2QMQvUcWUqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5T6O33q2ruZSkN7YEnJ/8fvggiIvua8zB54KQPCUdAE=;
 b=bPKaDYHCZgQ4YrQWEhS0IoBExKNc3OFxYlud44m6vBwCV6xl9431Pz1hi1o+UjY3W7LKc7LJ0j2ElUQnbmdZkY3dkuSeSCWzuyZJrCy6herNwE3pzrr8Wm2GHAblK8MpAB9NAOPxGvC01vRjv4pQIT9BOVXMxEdp9maN02qZzw5qKdUcara0sV2z6oa3FJjRvpbCdUZS81ZwlDtk7XStyQ5C5aLcp73gT42wHW+1lagGBNfV01DDWgJdBqLXto7zsoGbz4nbPJbGD67S9nbxziCMSYRr8q8lQSh9+dFowMd6TE8WLG0q2NSGWV/UMlliE74X54/KomMIAqs0+hJ45Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5T6O33q2ruZSkN7YEnJ/8fvggiIvua8zB54KQPCUdAE=;
 b=HpVjjKjC3loHOfzt/Hy/d9jnm+38rGUC0VKvG+/WIO1kstHXIzoJ4KCAfqhoC3ATij5tzIgEmBuWb5SHd5RoybCiw5m2lajNAj1vsGetZsjlirO/mphSBGzUhJ4k73/L8wHAS3e4eDY1UcZxs6kEQE8gOiJJzSYYZynQTB3SkuM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 BYAPR12MB2951.namprd12.prod.outlook.com (2603:10b6:a03:138::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Mon, 25 Jul
 2022 07:06:07 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::d4af:b726:bc18:e60c]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::d4af:b726:bc18:e60c%7]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 07:06:07 +0000
Message-ID: <a07eded4-c1d7-edf5-9c0e-dfa0c3373e4c@amd.com>
Date:   Mon, 25 Jul 2022 14:05:59 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] iommu/amd: Disable guest vapic logging during early kdump
 init
Content-Language: en-US
To:     Joerg Roedel <joro@8bytes.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220721003439.403435-1-jsnitsel@redhat.com>
 <Ytq2GRX7UJjvXk4w@8bytes.org>
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
In-Reply-To: <Ytq2GRX7UJjvXk4w@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::8)
 To DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97e775ba-57ee-4413-c038-08da6e0c2546
X-MS-TrafficTypeDiagnostic: BYAPR12MB2951:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EAqME8RdnjTmJkbJSQowkzqjx5pnvZtu8I+ndeuXpa6t+yTpk7hjsCOXB3ccXuVciKRnAymvBjlrEE6t/FjzFdBje/+vGEp4aV0uwIE6KjWICqdPH+7pbPi75mI1AjGDZW6sd+SXE3M4eDVroDiMmFFFWFJWbkj0Zg3tuozfD+LUiM+Ib142hbPYMBnHZF6o4YZfqpCGy4WgFm+9k/8u76rEGcuJOWvjjiQrinnMCXBAipL6cQ9dWvaKWtDTc8uCnZ34L1qH+dhc5NnMYjbZKxgl644pdo3hriMMhQbf7oz1BOnSdOdi6hJFQDBWvnwNFufbN9pTR0HSMHjeSXfE0osfOFkpop+SwjowfaIrzVStbX54iGLuVM1wzlXpuXOkJ8e5E87tgbVdbJEXPMokFpz71Xx2oq2mWmHrOc6tKjEAGDeKDN+/YdTh6BV4IVTw5JFequk7V1jyqlxJODR8eTqPHbTPl3HpGStFhQmCl0NSCoi85Lo1pjSTjlk5+V2A9+o5gIL8IVvVjZKtCaYSYZRtyKEreo1bYew5rT0nCSVpMDmC8ncp9j47LsUIAGPa+f1Rk2yNus7stBaotNgJkBonVFSxt5du1HrUT/we1tkq0G/9zefflcZzdDdhhaSeK87p779XMKlGpEt/kp+ELRfwmvDK04z4JPTL/XOA+Rb92+w8RQVenA8WVgrz8vpkDUMNYXZI59gAruUu/20n3iowBV9XQEydW0iHWMLONA7vTu0QWdVX9YJENc1xANK3aBCO9sCJ3X0p9N8QOvdx2tbzPtpx9v8AhXS96NZPbS83GEkx+w4OE/lPT6+udjPwDZpVBmiJz6a7N46yWYluZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(110136005)(316002)(186003)(2616005)(53546011)(6506007)(31686004)(31696002)(4326008)(86362001)(44832011)(2906002)(5660300002)(36756003)(8936002)(38100700002)(8676002)(6486002)(66476007)(66946007)(6666004)(6512007)(478600001)(66556008)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFpYMzV3MmlmK1NuVUFVUW9mek9BZzUxR3BZNlVCYnlkTkZaRWRQU1NHNUs1?=
 =?utf-8?B?MmtpZCtiWjFyRklZamNIdFo2czJnbVZlY2lNOE5CbnplWlJFcmsybk05QkVP?=
 =?utf-8?B?aUZlR2JCRnJzdnhMRzA1Y0V5V3BRamNHaU9BSnRMRU42b3BIVXQzbENDemtu?=
 =?utf-8?B?eXVPMnVzb2kzNXBGQlluc1NSWVBqOEFRcmdhazFjQ3FXMTl4NWxocS85Zi9w?=
 =?utf-8?B?b0pjNE53aVpXbVFMWDRJUkZwL1RHa2Q0cHJFWFh2ZXh5N0NCNENQdldsczZw?=
 =?utf-8?B?S0NHWEtZNTRZbnZQaXhuMHp2aVBraWN6SGEwOW1IWlpLVUpOTUNuU29MYkpI?=
 =?utf-8?B?cklBdnVYdlFjbUNWTFpEYVpUODZub0ZVWHFXWU8xRFlJTko0OGM1V0NXR3FN?=
 =?utf-8?B?Q0ZXWHM3WEg5cEtyVTUxUkIrVWNCZTZCNkpjTDFkL1VaNWFSb1Z2dUxPbnpi?=
 =?utf-8?B?VHRrMHo3ZVAwWXlDbDdCb1dSdWpZMkxEUDlTTW1MclErZTMvTUp2RmFzdnNm?=
 =?utf-8?B?VkN2djA2TmozaTl1YURXOU0ydlZHVDdqQjlZN3h1MFBTMkI1M0x0dWtTcDZv?=
 =?utf-8?B?UjdMUUlMMzJrYU1TM0tLZzFJakN6NDRpd0pXeUxRV25GeGw5bld6N2hycEJZ?=
 =?utf-8?B?bk9NYzNvenpQdUQyOUhoV3QvaUJ6ZVAwOTBWa292TC9seW1QUGZVZE16VDBm?=
 =?utf-8?B?ZldwYkxaTzNEZmFjOHpNdk1uRVFyQmRVcG5udDRXVGJ1TVNmRk9oNnVqM25O?=
 =?utf-8?B?MzdJWmZIbzBLcEtHOW5qTkJ2aGN4OUdMWnVBMkZ0UG5URUxWUUdZQU9LV0Na?=
 =?utf-8?B?L1Z2ckpzZ2FEL0lOc29RZXlqNGlycEJKbXFRNm5pUGJBQVhTdjl3QkRHMzU3?=
 =?utf-8?B?Z2FXZFR3bncrNWZrYnI3QldVeTZONlpPZTloVDZyRDBOMXRObkxmczNyYjRD?=
 =?utf-8?B?ZjBDZjZ3TnFxbkU3ODlNNzFLdWxNQ2g4SGQzUkxHSjR1US9DVk1KeFlYY0ho?=
 =?utf-8?B?Q09oTHZsUnNSTXB3VG43NU04YXF2SDB3LzV4Y25zbWF1emc3dDloM3daQW1o?=
 =?utf-8?B?aDZWVjVNZWx6ZVQxdTNWSDA3V3NtNDJ4WWNHMXdnYmZxaEJnMXhVMkt1VDFv?=
 =?utf-8?B?ek1GaFYzaUNIMzF0aDhHbnFtTkkzeEI1T1BzYU1wbytrTWFNQ0ZLNVZSbXJW?=
 =?utf-8?B?OFpLUEttNGRwUUYyWUM1ckN4WVNBWHBaOVNDWFV4ay9NQ0NoYU5uQjJhWHV5?=
 =?utf-8?B?YnV0S0xNU1hzRGpWNlRmcy90ZFUrcmNZTXd5WGtPbkQwRTRTTWFza056eEI5?=
 =?utf-8?B?NXpHMHArZExxRkZ6TVVMUlo4ZzR3N3QwSjBTNktqNGQ0bkt0TE1teHQxTE03?=
 =?utf-8?B?UEJEcGV3QVVTRDBqVC9xTHoyNDJKSmkxb2p1eWtPdDRXYlRGczhBTXRRNlZU?=
 =?utf-8?B?SE9aM1g4S1o0bzNrMyszNzBYbzhRS1Z2ZDgyV0NLenV3d1VJZlUweEhaOFhB?=
 =?utf-8?B?MFRxSXVqM0ErTWplTzNXSGU5U1oyY2NkUG5ZaGs1STdSQW16dzZ3eitndE5p?=
 =?utf-8?B?WWR0RVEvc2k2RXFhQzBqSWRUL0d6ekZFSm5INDd4MTQra3hmZm5zUUQySmth?=
 =?utf-8?B?OU8wRDBOeTYybG4vazVrMDdLZWVnaUd3VFlXcUNYUnpVcGNjZjJaZHhmTEYx?=
 =?utf-8?B?a2xqVnR6YTFhTkx4VjNWZHB0MEgyY0ltZjh3QWNuN2VtUUYzR01Jb3gvdTVo?=
 =?utf-8?B?TmdQdmVhTkY1d1k2Q3dJcDRDQ2RYZllvR0ZQaEdYbkQraU9Hbk5LWm1BMVRv?=
 =?utf-8?B?T0RNUkhjeE01QTg4bm1PT21iQWZtM3R3N3JpRjVMMmdLVWtJUS9xNVpOYk95?=
 =?utf-8?B?TEtodzNDdW10TEo5REYzMDlEK3lxbUFCYWNXRi9aYjJQSWQxNGFWTTdKWnht?=
 =?utf-8?B?OGZyOG9lWENVUkhhNWxzYkh3OWIyNlArNXJ4d0xSSWRaNVI2a2FaWCswejlX?=
 =?utf-8?B?cVoydGFWSFAvNWxaRWVMUFlxMW81TWkwUUwvcEsxMHVhM1dPWmt4aTFzUk45?=
 =?utf-8?B?UWIwcFc2R3RCbzBWY1FNTFU1Q2hvK2tvQlFaQzhjcHNRalJwZnM1cmZpQUxO?=
 =?utf-8?B?N3ZMMnFLalZLTU9yK3ZzK3dBKzBLbkNFL1JCMDU2YXE1OGt3Qi9qU1F5dmVu?=
 =?utf-8?Q?GTWjP5qsoiUbbQlVoB7sHfAn/pmkkfQHrn7EdySH9nUG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e775ba-57ee-4413-c038-08da6e0c2546
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 07:06:07.4320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L9WedZR3zFcT1GLP9C5+eZem6ctRemXoCLMiaddAeZ8lUcYJzQsShOVnfZzKyT5PhdY0v11XUYfFPCbEkN+vsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2951
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joeg / Jerry,

On 7/22/22 9:37 PM, Joerg Roedel wrote:
> On Wed, Jul 20, 2022 at 05:34:39PM -0700, Jerry Snitselaar wrote:
>> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
>> index 1d08f87e734b..2b00d7f28df7 100644
>> --- a/drivers/iommu/amd/init.c
>> +++ b/drivers/iommu/amd/init.c
>> @@ -815,6 +815,11 @@ static void free_ga_log(struct amd_iommu *iommu)
>>   #endif
>>   }
>>   
>> +static void iommu_ga_log_disable(struct amd_iommu *iommu)
>> +{
>> +	iommu_feature_disable(iommu, CONTROL_GALOG_EN);
>> +}
>> +
>>   static int iommu_ga_log_enable(struct amd_iommu *iommu)
>>   {
>>   #ifdef CONFIG_IRQ_REMAP
>> @@ -2504,6 +2509,7 @@ static void early_enable_iommus(void)
>>   		for_each_iommu(iommu) {
>>   			iommu_disable_command_buffer(iommu);
>>   			iommu_disable_event_buffer(iommu);
>> +			iommu_ga_log_disable(iommu);
>>   			iommu_enable_command_buffer(iommu);
>>   			iommu_enable_event_buffer(iommu);
>>   			iommu_enable_ga(iommu);
> 
> Looks about right, but I also let Suravee comment on this.
> 
> Disabling the GA-Log under a device still using it should hopefully not
> put it into some undefined state.

Sorry for late reply. I have been actually working on the new GAM and GALOG enabling code,
which should also address this issue as well. I'll send out the patch soon.

Regards,
Suravee
