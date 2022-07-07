Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC0D56A68D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 17:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236357AbiGGPCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 11:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235964AbiGGPCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 11:02:47 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A252B5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 08:02:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/85R0mj+4nRuAVR50zuJVcILhchh3jz+uxU6z2v8oGrkU83RtjOroRue9FlUW1/mo54UG/9N+3n7ZR75aNyAY+6Zf9lJrA5LAMgvLqFi3hAdDoNdiWi1OwsyN5qwwV2pPFDsThZwUs2/G183H9czj01b86HN2Ng6lIlxLhOQa+GG4p5C/0JH6PokITgniSUNhPZN2KHvwDF+ROW2hr3rHNikl2OgV0MSlL8hcck8OJDrQ33Ska++JyoRRrdJlUzGLHsl1rh9qfazkkea9HvlIA1LbvdvEu2DY93/UtkYuJ8gGLPJkyd510uEAvewpCJ4nT4ZKZOvuTP/vIm1l6B/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m87yuRd8u5fkY240sWGm7/wrbTr7o34RoXbjTkAvtGg=;
 b=JPtxX/kVcBU6366UnyzVugTJ0zz4ibEGPJTUQymKBrFpowXPdDiKaJOH6nlBVNjSCH2fgce4oMFaMSgQfW19FRNd5mg6o2OSSQ1BHAwv0Um/l2yQH2W0xtcqmc0XZJAK3h9rV0ZT3+9gWd/9bfZ9Ul4EwmV47nVD/mEM4iKZT8FK4N3vGjIww+Y2nAbNZfpd2HzWCcAvu982XF4Ah8wMzX5s7P2sYhmpBgZWvPPtboaYsQgRFTo7iZETADBIuk3zIla4OdRzpXCvL9/2/F9jXi7WmFNagRTPmF0+V+532ji1Nj4J2y31yWjA7vxJN/fDGL4XNr7ZWvhs0u1F7AUrZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m87yuRd8u5fkY240sWGm7/wrbTr7o34RoXbjTkAvtGg=;
 b=rt7LJTOJhjkKOQ7Ow/vd2oTaDm3UxiqXZNCtnLmMGkPijR5UcZiL6kzwvS8oCJPnWnHb9carN450VgIPF8ZENIvqpYtrpXtgr/BSp9XbQsITanW5dxJ7QFrESG0h6Do2HMm1AlX2lS6HTfX2C5/vjQ5tlW2b/7Tn4TiFcS8dmdk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by MN2PR12MB4318.namprd12.prod.outlook.com (2603:10b6:208:1d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 15:02:43 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::6d50:f6c5:cea4:1d95]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::6d50:f6c5:cea4:1d95%6]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 15:02:43 +0000
Message-ID: <2ad6a765-3a54-c18a-9c27-1e636d461f9b@amd.com>
Date:   Thu, 7 Jul 2022 20:35:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [ammarfaizi2-block:broonie/sound/for-next 328/353] kismet:
 WARNING: unmet direct dependencies detected for SND_SOC_ES8316 when selected
 by SND_SOC_AMD_ST_ES8336_MACH
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, Mark Brown <broonie@kernel.org>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
References: <202207071820.zgSI5DPp-lkp@intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <202207071820.zgSI5DPp-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::20) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91a2f98d-ca08-441f-2549-08da6029be78
X-MS-TrafficTypeDiagnostic: MN2PR12MB4318:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ju8f90lUtp1f0oWgGnEw1Q9XkC3TDGAfHEFGrREMwFfzi3ytE1r0PoScswn+bte2YZKTYoLWkIzWZ402zxc51zCUjm5ybttKpJ9fghxl6estnKCjbQcqt2lPG6kQpZD4L3ZwKC/PZw0drYCspCE4O15K/1tXb4olFizC9/I6JIzYuh2zdy9ac2bMPpNXjKXYNzHK0ewweVImDLjPkalTrjtXQbHV25GpLDcjQ822lD3Gj1mgl1T8y3S8uz9XY0j6lqb831+A79u7Vl9Ag6b8cHbXdrb+XNQVHCT3pLxc+k006Wy890ETSmnH4bTMF3pZprKNLcImUuatFCjwTgvPDmrfi9wqETSC6wa9qU7s75wu6sEVBjVGoGd6UrtanINteED/Fz1jHFywas6e5ZGINXD+DNBEwPrqipANjyaqi4F5PktT44RuqbM9PPxoBOCYoTKXrEsqq88wFAkeJgJ/WT5wQjX2N9vGGX5/e50hjEsxYw8heAFcp0c30Ext3yLTTxIaarioUVkdY2DZmIw3Y4L4wydYG4maHU6czX9YS/mfBEx1wqLptDY7piggkDnfyXuexiLJ34c7odoF8vakCK0AayMsZ3SIjir/MZ4Lu4bIL3QwovrMWtnjUMjki/0v4sfRlsERgtBh0X72dGVC9Jq5Eo4ZqgfRsChXqKIjKVkGAs6U8ZqHie83ZpDdd7rFsuRjQA/cSde7+6jzWkcDqKp2kIeS/GPgrvFQb4Ddnm8tRFeyP9jBlX7jEORT94laRYUSSdIYd3Devk1A7WAgP79LbPOOEAh7Y2xER5eqtOHeVtQmbO8OS4NlKsJD+DcFI5QBePd7mnKb5YJRiOAGUDtkty9YlS/csvFPkxYPEv+2/We6yu45bey6sh7THIUpZsgcmMgzO+klY5hpmLj8k5kb67bTExUMeL5zJ8mIRfs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(83380400001)(38100700002)(186003)(66946007)(110136005)(8676002)(316002)(66556008)(36756003)(4326008)(66476007)(45080400002)(31686004)(54906003)(53546011)(31696002)(478600001)(8936002)(966005)(6486002)(26005)(6666004)(86362001)(41300700001)(2906002)(6506007)(6512007)(5660300002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2F2T08yc0NOSUhVZTE2MmFRUUIzVklwazBsWDJaZDI3Sm5wVGVlWmgrRGt4?=
 =?utf-8?B?c1c1NDg5RHRLTkFabU91a0oxdm5HSTlXNnJzS3AzQXc3bmcrbUJpSmxxb3Bj?=
 =?utf-8?B?bmQ1aXBaY1l3ZTBzenFjcER2ZGh1ay9vM1BGemN3R0tZU0V2dy9zb2Q5QnhE?=
 =?utf-8?B?RzBOb2xXOUpIR2FQK04vcVBKcHFLbG5yTjNJQlhDc2ZISlg1V2ZQRmI2eFQ3?=
 =?utf-8?B?cUFBN1V4a3RVaG0vVnNib3o4ZzFwQ3pQaUllV21KQ0Zuem03dFhESkpmUllM?=
 =?utf-8?B?dUJHRExRRVB1VmpIUll2dDYrVlhRQWhpTFVnd2svT2lXSlFkbDdzUHdUaVdW?=
 =?utf-8?B?N1dwWHZEMm5MTFVFVjVINldKaDZNQnRmQW9YdnBkaTR4V21YWGF0cGZOUW40?=
 =?utf-8?B?djhxcURtdDd2Tk9jUGlRb1JFYXAzTzNaMzdzTm5TMkJjQ3kzU3d1T1lIV0Rt?=
 =?utf-8?B?bWN2YjFySkd0Y0l5djdaS2JBUncwVUVmdGw3R2I4bUpTUVEyZG1rMllSZEpZ?=
 =?utf-8?B?RlpaVStDU1ZyNlV4MXBSV1A1a1drdGdJVHI4QUYwczZ0WFFycGNIWmF1Vk1t?=
 =?utf-8?B?S3BTYlh2dHFPQ2x2VnVxaEdWOFNDeHQrUFFQQTU3Q1B6WFZJaTBOK28yaUV4?=
 =?utf-8?B?Q1E2dDJPejczY3MvQVlTQVNLZDRaOVlmNW5XZDRaKy9rTmp5NFprTlBZNlBV?=
 =?utf-8?B?OURtZFRGZithOXVOWkw4RUQyYUhpYVV1YWtFZ3lxc0gxbklmNXM5cFhEdHBk?=
 =?utf-8?B?a0JyOXRTQnRGS0ZKaDFZZ1VZMlRtOHNXMm1KbjVYalhFU0o0TUxiUkVQOFYz?=
 =?utf-8?B?MDZzRnF5WStZZDdxVmc2TW8yRU5hRlNqTVVhRUpqWTFpM2x5MHN2d09hcnhl?=
 =?utf-8?B?Mkd0a0JkYUJPdDFZSFdhNFBqaWlTSnNHOE1Yd0lzL0JnWjIyaVIyR2U1cXA1?=
 =?utf-8?B?OTM2VnpQVmp1QU9leTFoeGlWcnVmWTBnTWw5bU5YZGpDUFhycVdJWWY4S2Ft?=
 =?utf-8?B?V3JURHMzNXF4Wi9zT0JtVDB1T1FyckZYRGx6T2RLRDlCQUhqYmxibEJ0RXRE?=
 =?utf-8?B?anN3R1U3SGNDUkZXUEF2UW5yeXUxc1h3ckZiOTdCMVZucTB2RkhhSThSR1V5?=
 =?utf-8?B?S0UwZGF1eDdDZjBVVk1uU1N5c0xvcEo4TXJpbmVMNDd4R0FXNjloeVp6Visw?=
 =?utf-8?B?a1UwcmxJdlV5VUxRcDN3czZJOFY4MGR2M1NEYjdTRTJhNiswMC9RMHJMcHRC?=
 =?utf-8?B?QUlGams3ZlpzMUFrcERWQXhZaGJicnlVQi9IY1NyZGlWbHNtTU1TckhzeGdy?=
 =?utf-8?B?c1NlWnFvNXJSQ0luVCtMN3FjMVNmbUozVzhnOUZQbmUyY2JYckd2aTVEUG9V?=
 =?utf-8?B?NldROFIrOWNOYnJFYVJMOWUvNnkvWHMwcFJZT2pyMHhubjdpaWZGOWlKUGdN?=
 =?utf-8?B?VTUzM0NPUkxnSDMvODFaVmI0UmRkN09xQU1laHY3c2lRN3F3TFN6RXZNenlX?=
 =?utf-8?B?bTlGL05Pc3lVKzhvdTBIYjFOQzMydUtQRit2VE45b2krbXd0U3F6VXdWR25D?=
 =?utf-8?B?M0owU2JoMkorem5nRzFINWg2dHU5RnNZTnprS0VOTFdYSVk5VTU3Wm92a29z?=
 =?utf-8?B?TkZyajhFbldMdVYzSlJ1YTgyVGp6TUJpSDBSZFFiMElFNlRBRGlLY0d2ZW14?=
 =?utf-8?B?OU1IdmIvcUM2SGFmNnYxN09mT3ZYRHRrVjJwT25ETldqNXU1eFNaUW0yaDh6?=
 =?utf-8?B?bVNUUmVtNzVBak5SRHVNclN3VWZaa0YwY3pLWnNkTVY4WEVPMXRGZmIvRkJ0?=
 =?utf-8?B?ckRtRVJxb3FJVy8vTEU5TTl4VnJzYVlnNkFEWHVJemYwL2dON3V6c1VWZDNS?=
 =?utf-8?B?NTRRc2N6MmZmWkZnNDZxNXQxdHRXVjI1VGhOWVhYV2gzelhIKzQwU0E1NjRr?=
 =?utf-8?B?R2dldzBFQ1FmZ1Nhdks2TVo3WHlhdVZrOWdKTC9TeUttaStjc3B4R3J3V1Nh?=
 =?utf-8?B?R01JSFh1eldPNFQrRGJZUFNWaEpxRWNmZ3BvU2dJeVFwcWRXLzNkdVJCVm44?=
 =?utf-8?B?ekN3WW5ER0pEMUcyTEZCVUlMbGVaekN0ZHF1S3BmL3JpRklGN0U3c3M4UkxD?=
 =?utf-8?Q?bh2zyLH9ZaBvRS8JW5iXyyHPC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a2f98d-ca08-441f-2549-08da6029be78
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 15:02:43.5422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t8UGaoCT+iUpwH0w0NTnnhQHeBAhshEXTm1mymWq0JfZWggki+j9iN5hyo40BM2w2l0uaoBtzQslge8FR37ABg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4318
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/22 4:10 PM, kernel test robot wrote:
> tree:   https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fammarfaizi2%2Flinux-block&amp;data=05%7C01%7CVijendar.Mukunda%40amd.com%7Ce5c929894ac448ff95cc08da600523c7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637927872441384217%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=WfOiIEJdyrMjyppJFIoXcRry06%2BI9kerP8TtwWqtFEI%3D&amp;reserved=0 broonie/sound/for-next
> head:   3f4322bb413adb7f9d8b5e9005eb1b9bc85f9312
> commit: f94fa84058014f81ad526641f1b1f583ca2cf32f [328/353] ASoC: amd: enable machine driver build for Jadeite platform
> config: (https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdownload.01.org%2F0day-ci%2Farchive%2F20220707%2F202207071820.zgSI5DPp-lkp%40intel.com%2Fconfig&amp;data=05%7C01%7CVijendar.Mukunda%40amd.com%7Ce5c929894ac448ff95cc08da600523c7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637927872441384217%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=fjurvDhz2j%2B8OSeujOOUlTwIXC8%2BYhMtWtJx4xgOjLw%3D&amp;reserved=0)
> reproduce:
>         # https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fammarfaizi2%2Flinux-block%2Fcommit%2Ff94fa84058014f81ad526641f1b1f583ca2cf32f&amp;data=05%7C01%7CVijendar.Mukunda%40amd.com%7Ce5c929894ac448ff95cc08da600523c7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637927872441384217%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=mzlwMgPOXLIOa2CBS34OWL%2Fp5Gd%2BiAVq9JRMkhwSwZk%3D&amp;reserved=0
>         git remote add ammarfaizi2-block https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fammarfaizi2%2Flinux-block&amp;data=05%7C01%7CVijendar.Mukunda%40amd.com%7Ce5c929894ac448ff95cc08da600523c7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637927872441384217%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=WfOiIEJdyrMjyppJFIoXcRry06%2BI9kerP8TtwWqtFEI%3D&amp;reserved=0
>         git fetch --no-tags ammarfaizi2-block broonie/sound/for-next
>         git checkout f94fa84058014f81ad526641f1b1f583ca2cf32f
>         # 1. reproduce by kismet
>            # install kmax per https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fpaulgazz%2Fkmax%2Fblob%2Fmaster%2FREADME.md&amp;data=05%7C01%7CVijendar.Mukunda%40amd.com%7Ce5c929894ac448ff95cc08da600523c7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637927872441384217%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=5qTeSZKs2rFoblqN876F1O6nWwBn8NLgEBkLbG1y9GM%3D&amp;reserved=0
>            kismet --linux-ksrc=linux --selectees CONFIG_SND_SOC_ES8316 --selectors CONFIG_SND_SOC_AMD_ST_ES8336_MACH -a=arm64
>         # 2. reproduce by make
>            # save the config file to linux source tree
>            cd linux
>            make ARCH=arm64 olddefconfig
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> kismet warnings: (new ones prefixed by >>)
>>> kismet: WARNING: unmet direct dependencies detected for SND_SOC_ES8316 when selected by SND_SOC_AMD_ST_ES8336_MACH
>    
>    WARNING: unmet direct dependencies detected for SND_SOC_ES8316
>      Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && I2C [=n]
>      Selected by [y]:
>      - SND_SOC_AMD_ST_ES8336_MACH [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_AMD_ACP [=y] && (ACPI [=n] || COMPILE_TEST [=y]) && (I2C [=n] || COMPILE_TEST [=y])
> 

Hi Mark,

As per your suggestion, Relaxing I2C dependency with COMPILE_TEST flag
(i.e depends on I2C || COMPILE_TEST) and missing I2C dependency check
for Codec driver module causing this warning.
Will modify I2C dependency as shown below and post the patch.

depends on SND_SOC_AMD_ACP && ACPI && I2C
select SND_SOC_ES8316 if I2C

Thanks,
Vijendar
