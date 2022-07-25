Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D9E58010D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 16:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbiGYOyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 10:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbiGYOyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 10:54:22 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2100.outbound.protection.outlook.com [40.107.22.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33FF186F0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 07:54:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsRB3y+/+LfQHRR7H1Fhlje0Vz9oCwDXbIIDY92/gx/47tsk+7HyIz7dKbcGQgY/YuiFcz2kc7peRsc2HCMRBGo+zzxGMUTTPhs+FfVyh2LUzq1oE1XSbXTgGW1qNKKcKVvKqMwtb9uTuqYlLkBvY35k+csBI8Smouru2bb2rDQ9f4bSjrbPBeDgOdLlHgwNq0C1Pb0+vKQYypJ5Bo4TkpTgXMpLFnbay04WK8gBi8d7b7DelAL7YDJQpxitADX5eolTkIsjTbOU3ZAvwZMIE9u92CdwIUMTBmHPxT6iw1wtO9/ANm+OPzVD9DZ0OxEXzYAixtrW4AgyMXb2lS2iEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YR2T9IGfwT+4Uw/14J5ibbMDD9NdkGliSUZZoFNscJk=;
 b=lKfXoMBHMpGn4O9dw0IkrT8uJx0GJk6vI+8xz/4wquKmbYM1OBLAbz8Kvbn/WlGBXF+UPbyHf9RUWkcM0biEPAFl7Jc5mBm1JUh/oZ3abC0QLBVMSOv4iS9UCcXf1sdwirjCHWj2xqgKFz7VcMAwV4htM+kl0Kg1/GIqlgN+rWRorWYzJnTIhVOa7sokSY713Y3I48TCogFrbiF7xUjpSrlOsZ3WHvYW8Qz0uDmiCsYvfTof5PUpQ5ZS82ySXB+yAgNyt8mO+BXy5K0w3yyGl/Oo0U9vbpfWm7zgX9FoAFeo5q7gr65xI2ZYjRkicX1u/E18tZ6KzWKVFM3IY4sTaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YR2T9IGfwT+4Uw/14J5ibbMDD9NdkGliSUZZoFNscJk=;
 b=t9V3KTwedah5Mi1jUlPRv/QSknH/d32cn0RIi6N4/AEZIuZgwhgU6lLhZv9nOzS7PX+DQe5ld6X4Ro+68uCFUCQXfIj6vGUUrCcn4n8Wbf+wM4o9cw01nuSq5W8rOAWiBYKJXPh3l1NzHzLzuvgQ90RRsD1UlVMy05EVs54ssdU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AS4PR07MB8658.eurprd07.prod.outlook.com (2603:10a6:20b:4cd::12)
 by PR3PR07MB6491.eurprd07.prod.outlook.com (2603:10a6:102:67::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.2; Mon, 25 Jul
 2022 14:54:19 +0000
Received: from AS4PR07MB8658.eurprd07.prod.outlook.com
 ([fe80::d58d:e18d:afdb:35b8]) by AS4PR07MB8658.eurprd07.prod.outlook.com
 ([fe80::d58d:e18d:afdb:35b8%7]) with mapi id 15.20.5482.001; Mon, 25 Jul 2022
 14:54:19 +0000
Message-ID: <7caffdd6-2292-d454-7a76-5dbc30ab9c29@nokia.com>
Date:   Mon, 25 Jul 2022 16:54:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] mtd: spi-nor: Introduce erase_proto
Content-Language: en-US
To:     Tudor.Ambarus@microchip.com, p.yadav@ti.com
Cc:     linux-mtd@lists.infradead.org, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-kernel@vger.kernel.org
References: <20211209100813.61713-1-alexander.sverdlin@nokia.com>
 <20211216200535.jikqd42nohr4477n@ti.com>
 <c1a4e233-f00b-a4c4-8c28-111889f272d9@microchip.com>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
In-Reply-To: <c1a4e233-f00b-a4c4-8c28-111889f272d9@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::15) To AS4PR07MB8658.eurprd07.prod.outlook.com
 (2603:10a6:20b:4cd::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfcc4eec-0452-47fa-90ad-08da6e4d8d6d
X-MS-TrafficTypeDiagnostic: PR3PR07MB6491:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J+K9+CUjrriF0LtZXPLwNosMmyU5Wq913YroDveJ15CNvH//eNgoMje0F87mdM4nUQCoBYpNQ8aaWOfLzFdwQVudqTc2dyz9GSea9cO9XUroymDyPkqiAgyxdm2BS06+RCaSCeRHqKl6+Ul1ebLgfGHgwgxcieV8Lp+3nZVQ8nzF+CD0e3dJ1zEUuIu02e5PuEMe10K5R0CQ803Pwvybg5Q3BpGVzaWd053bH3i134y8Ycb9bgucipI44UOzdETxkkCvY3yNpgJE9vAxp7n82Fxs40G5CMqpUOeAQEhU6UXDF6kTbuI9KmUcKNbQQH1Alxz2OiIlh+5i6RVDn7ZkwtOOnjBzKpiK+2Gh+3OrKONxMD4kkhJIwvuho7EY6LmKTuHL2/VMD8MRMUE07iy0vNwrbQylTdjWcawV/cW1lOMTKbMUmkHsOI0WO2qYCbPck4xSOXzGBIWdL0/7uuJlzCtIHeGzCJ+6984w0uDalYIs/Vdq2DuZN47SEWd680XH7ltkpEskqD1KCYD97Zd9f/7uoxTF05hzEgLYo8w6jVf9eAbV/3cvOlS2/0tnIq/kuGcWmpivyzwIgNhAio6lg2LaKEm1Zg9KEc52OF2pMi8x1SfcPsD6VTn5kKPNmLhD/Zqmtj030kyiS77gWiONAAy0z6IY9SQazIW0Vgv/OlH+3oMqgmsurcG0Xwpv3MnGPEDuUugO/8xCJ0N0VrXOg/c9bhvQD/S1gtXv0ZNqybF1FJSEAiFU5Gzy4F7QQch1MzWLuE/n9dkntFVrtetORc03Zq3vclyOtp9E5JtOHMMEp38NkTXiahL4dz6l3hvgovXsHpBOKjK+6H3PNfDvPJ8LDzob2kCOcJblTydX56PZamuc5lWD+I5J8DW6jHUQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR07MB8658.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(316002)(41300700001)(6512007)(6506007)(6666004)(53546011)(26005)(186003)(966005)(6486002)(478600001)(66556008)(44832011)(2906002)(66946007)(66476007)(4326008)(5660300002)(8676002)(83380400001)(31696002)(82960400001)(36756003)(38100700002)(31686004)(86362001)(8936002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEFTaTZEd2g0STk1dzU4aGRWbUJIODNvWDBIUWx3SkhBd0JIWUc3K3FWRVRJ?=
 =?utf-8?B?SUpnOURLSVZJYUtyZkhqK1FPODhCSXk3N25sNDMwN2JCQ2xEbVN1ZHFVMjJK?=
 =?utf-8?B?bXVkR2E0QU9sT1diMkUxa1dZdlNZS3RwSkc3amptNWZiWWZrMFVYZDBiTnAv?=
 =?utf-8?B?SExLcDNCbGlNUFlDeDNWUkU3UzVaY2U0aDJQc0NlbkZySFEwR1dPeVpxbHJV?=
 =?utf-8?B?YnhmVXorNHZpd2FJMkJySURmem05ZnBVMVRDNDJKcFpNQW50NXR5UHc3dWhz?=
 =?utf-8?B?WFdiRkZrdm4xTnNlUFZoZlFkNnYvakZFQWZPZjN4OU1EWVhGVk1ESVBkZWRp?=
 =?utf-8?B?MHlsQ3lHWFVnQkFZRmkwRkhBWWdQZmtPSS9UNHA5NW11NXlUOWZCSkZBZzJX?=
 =?utf-8?B?SFdtc3hXWW1Wbi9tTm9GMlNhcFFFNnQydjFzQmFlNUFKdEFMNWtUTHNINFlw?=
 =?utf-8?B?YnRnQmozWXFqTzFDM1lKRnEzU2o1Q0dCMHdYNnp2NlQxbk5iaGZvTVFaWSsx?=
 =?utf-8?B?UFlQMUNZeU5VaHRCMnZ1b1NCR1RoeVpJSXEySVhRSFExT3VGZU8vcmhGRU1x?=
 =?utf-8?B?cGkxcE9ET2JaWHIwUjFUUEtubVU4eHpUNEg4NGNrdmRTMW1MNXV1cTExcitp?=
 =?utf-8?B?dW14cW0rN0laRlRFejdvQVREendxZHlGV1FRd2dydHZ4UjRmT3JWV1pPTEJs?=
 =?utf-8?B?RDNlUnV0MFl3Q0sxR2d0SnJNLzR6di9pY3hkdFYyemFEVWV5R0pEVHg1VjF0?=
 =?utf-8?B?MkFzL2tBTit0cXczbmZDWE1hYmNMR0VObkQ2MHlFNGNUUmxUUUJVakJNbGdy?=
 =?utf-8?B?aW43OHU1YWwxc3RsTzBNNFVhVERtZFlLeFJWcUVZVXAyMDhjQTRCM2xvTmQx?=
 =?utf-8?B?SEFGV3VabE1heWo4OFpVa2pNc3RzSlg2QjA0SUpwOXBNcm9oRDhNcFExZHJR?=
 =?utf-8?B?QUErRlU3SC9QeTZ6dC9WMm40WDRZMDU2dHhBajdhcURNd1dTNzdkWE9Ia0M4?=
 =?utf-8?B?a1FqeUlaZzV3VGF3YklVREw2QVR4L1ArTDVBRFhUY3hjOU5hTGNkVnhzNk45?=
 =?utf-8?B?S0NmR1NGUjVha0xTT2hTOUU4MkhJWEdIRkZmcEZOZWdNczRndU5uNmlnNllC?=
 =?utf-8?B?Um8xcW5UNFpnN2tFWEpneDR3d3ZKM0ZESG5GWms2eldVTi9GVkt1OEVtRERM?=
 =?utf-8?B?U2VPTGcwMWV2dWtyckJuMFE3T0JER0tjL1JCNEZiRFpJYWlhU3Ntc25UL1J6?=
 =?utf-8?B?d1c0dUhKekduUmR0cWMraXpDalE1Q2Z1ZjFIbDdReHZFMCtzOW8vVW45SnBP?=
 =?utf-8?B?QndqWExZS29HL3hXQzRsTE5SYlZzR2dzRXhQRUo2M25wcXpPY1JMTzZnV3BJ?=
 =?utf-8?B?ZEZ6eVdBYWJPRHpmcVIxM2RQSDJrdnlkanFwTFNXWkZkUE1RWkdTcjRvK3RG?=
 =?utf-8?B?VG9INkV2OU1idE80L2ZmNFQ1QnRiWlp6eFYwUzBNM0dFNU1hL1V0dlZVYVhB?=
 =?utf-8?B?bk9MdnNRaENOQ0hQVXJuQk9LLzRjbFVzRXVtdVI4QVlQOTVveUE2OVVMd0tJ?=
 =?utf-8?B?ZWFwaittQUlDSCtTbUwwN1ZOdVFQeHN3Ty9hcWRzZTZ6b3p3L0JBc0w3akhC?=
 =?utf-8?B?WE5OVVl3c0VJUzVITnRrUDZwZ3ZxampXY1hCQVBrYWFnYWVzeHBKUlY2YTVu?=
 =?utf-8?B?M2VrYlFpZGJvajdrTlVPeVNWQ2dxV0VEMnJ3WjhGSGNocHZhYk5QVU5zdzJP?=
 =?utf-8?B?TnJZWm52a0s0WjlmbWZxa1ZPaHliLytaOXpUWHZRKzJOKzJ3aHJTQjcxdUU4?=
 =?utf-8?B?SElyUitiMjlJdjdBbDZMd0dUOUJqNmFrQy9vVVk4R2RUaldBVjJ4bkszTEdn?=
 =?utf-8?B?bGZWSzlRWGJhbEhYcHppOVhqdVR4UDFGdWh6RGY5YldySFg2OHY0WG95Q0w1?=
 =?utf-8?B?WVlYWW5RTzJVSlpCRldWa2ErRDN1VzZqYU1ablV3WDFIWHpXVzRVVk54ZnNV?=
 =?utf-8?B?Z0V0R2M5MHFNVG1PZkF3c09Pdm5PL3dBN3NubDZGdjZycHZ6SXU1eFZORWEz?=
 =?utf-8?B?Nnk0Y056ZmpIcENocWhNbGVaUml4aURLeFBKaVp6dFd2TjBlS3JRWnNPa1lO?=
 =?utf-8?B?eGJZNlE3dUs1N1NTRSsyWEZIN3o1YkFjakhrdG5NM3RlclNXN21sOGk4eHNC?=
 =?utf-8?Q?dT2CT5Um2sivrR6io9W35TY=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfcc4eec-0452-47fa-90ad-08da6e4d8d6d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR07MB8658.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 14:54:19.3619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IUGmbmtxvDQc6+of8hM4KFrXSNqBXDv1LvgsO5RAvvXJs9RcRE+1dP0R8jvQPJB0bslthlYIv4ZCW2hD85+2t2w/PJEO43HnJMtXl9A/EuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6491
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor!

On 18/07/2022 18:50, Tudor.Ambarus@microchip.com wrote:
>>> @@ -2727,6 +2727,9 @@ static void spi_nor_late_init_params(struct spi_nor *nor)
>>>        */
>>>       if (nor->flags & SNOR_F_HAS_LOCK && !nor->params->locking_ops)
>>>               spi_nor_init_default_locking_ops(nor);
>>> +
>>> +     if (!nor->erase_proto)
>>> +             nor->erase_proto = nor->write_proto;
>> I get that you are trying to not break any existing flashes with this,
>> but I don't quite like it. We should keep the same initialization flow
>> with erase_proto as with write_proto, read_proto, etc. That is,
>> initialize it to SNOR_PROTO_1_1_1 in spi_nor_scan() and then let the
>> initialization procedure change it as needed.
>>
>> The problem with this is of course that it could break some flashes by
>> selecting the wrong erase. I would expect _most_ flashes to use
>> erase_proto as 1-1-1 but I of course haven't went and looked at every
>> single flash to point out the exceptions.
>>
>> I would like to hear from others if they think it is okay to do this.
>>
> Doesn't [1] solve Alexander's problem? Alexander, would you please test
> Patrice's patch and provide a Tested-by tag if everything is ok?

Yes, looks good, provided the Tested-by tag.

> Thanks,
> ta
> 
> [1] https://patchwork.ozlabs.org/project/linux-mtd/patch/20220629133013.3382393-1-patrice.chotard@foss.st.com/
> 

-- 
Best regards,
Alexander Sverdlin.
