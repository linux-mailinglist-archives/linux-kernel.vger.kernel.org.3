Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CBE526759
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 18:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382456AbiEMQob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 12:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380256AbiEMQoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 12:44:25 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5739211C14;
        Fri, 13 May 2022 09:44:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/PinGgKFIBtFmkn0e3HNR1B7sBO62EHLhgKLAFUyYA2M0Jv0cGsfAckWQbxp4gCWX0oJyDCLH6IMEG4PzIDJuR8B3V8ph++DlQiL5bc1/thHSmUYiVQg8/h08+Zn7Ibo1xuiv3rlr/5mV7slLL8qS4kkN01uAo1dxYBZbGyUrKGd07fetYpoF5Dx7USasvM/fm7aOpg72a7WAE+rL80qarENLqdeF4yDlng4ea5xzng3rmCIlbbAzfuHZPtD0NyXKXi7mS47o8Xkonqp1KyNJpICm/Yp4o1ttcBd6O1grOZhjxdA81oadZcsjE/yATHnWGf6+X82IFelang+GzhBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkTAP6IvQhPZuMDpbvGEeF+e/CiXZGIQOHE+662Frk8=;
 b=X6DwWNbUmuu0pIaJYEAgGbqJV3/XC1Cto12z7mUQzT+In3yZETcxMr6TFGUV804e+MGprIFDjkrLyi24mhebae/qzIPM25YOM+M5bZJmNUXeqr4qIkh0ghMfhQ9VisQ2+H4DUq4W5FsjhKmo1R2OUjwiIoC0B2SRSqd8xv+uaY4sbD+kO9mSyXuTQgPRFq9lyXNuvlnsI2x0WG84PxHV+90418GUcJRkiNCsn8rxxYGBXfyAz9h/O9CoqYXda943vPregZ2IrCurzErLk0k31TOQLPmk7owQ1kptFBAArMGZPvQoNN/eP2F2zGUZ8G6Y81BUo9Gd5R5itnM3g8laIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkTAP6IvQhPZuMDpbvGEeF+e/CiXZGIQOHE+662Frk8=;
 b=LatseIbwzUirTwf3wIglHBELUYNCwhMo8kNYFllPCFTsWOeEBZJpkxDA7ToymLk/SzkZ1En5QHId9D+4GD067WqIX+FmUHP1Dqoix7AUho2lwimxJjMvOMMqfAQ48/pFNy9BRxhP8MPXf6ANIvBObSMT+Qvc6bSYpmhaebxPWiK6qPET2o2kZomxI/6afaT7OkeMY07BACL0WiZ0DXnhWw/C15XKKsDaRiBrZHYqngp0ibl+5a+eTIXP5Fqf8UYP85DZxU0bgnuEDOvzJOi28A6eIbtKRYsB6sAdgKBvHub2KfmIPGLT1AkG0oJLRuNzbrR9gHPrvTACvPHMPLbe5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DM6PR12MB3723.namprd12.prod.outlook.com (2603:10b6:5:1c8::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.14; Fri, 13 May 2022 16:44:22 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::a4b2:cd18:51b1:57e0]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::a4b2:cd18:51b1:57e0%4]) with mapi id 15.20.5250.014; Fri, 13 May 2022
 16:44:21 +0000
Message-ID: <9ed15bbb-19bd-67c4-6c53-0b49bfdf2fea@nvidia.com>
Date:   Fri, 13 May 2022 17:44:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [Patch V2 2/3] spi: dt-bindings: split peripheral prods
Content-Language: en-US
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>, broonie@kernel.org,
        thierry.reding@gmail.com, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, ashishsingha@nvidia.com,
        robh+dt@kernel.org
Cc:     skomatineni@nvidia.com, ldewangan@nvidia.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220513080828.22079-1-kyarlagadda@nvidia.com>
 <20220513080828.22079-3-kyarlagadda@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220513080828.22079-3-kyarlagadda@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0345.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::21) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27621be1-2aaf-49f3-43fa-08da34ffd49e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3723:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB37233C59969FD8DC1F18ABC2D9CA9@DM6PR12MB3723.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pBrXag76RMwiBnSRMhVRTdLbuZlAmYJvo08/fRR6db7NztuP2IrbFdmlPb3qW24lXuoqBJaW52pnO5Y0tpeOgVm87//nj3JFY+HneYXwqHUU5IAemFgjIXbfWEAUpAMUBza0WHpdGPgSGsxZsA+zs6669fyljEhx4nCt9MH41ERr07Iaw9xKQO09t3MGdwCF9vqI8bu22RO8eJxjmwFUaVGiJGz6fu6HuNjTdR4M9Q7dqLDkVGB7P65yMW5imC1EKW8yi3ctGq/LqL6iLQ6n6eJK4w+eCKqUdxkiJTrhpgmxQEJsIC69FKY56TCNO4Mvr51rtoEqqKugrOJK2TqUuSCS0hK5Tt3QQNNs5W1Pf07ZqlhLklxIXpYN/Dln9Du8OcuBzjx3U0sRLk0UQ7tsmA6ZA/h9AOWQuh9KGZXfEHU5P6CjooFlMYONL3S6FHzydUHkjp8rZuHEBu7d9jkzAeOOatcCIE7yliQRDIMxBHC1MQA3qFjDd87rd6exC6ykTNfrguR6aOIvQ3MNBNmytl1vfu5j1+7qTRXRq8nODeJG04gGaM/0tJ1OMLwOFQSU+CgQht2QZlSJ5UBVGtyMh3pT03BOst9M2VMTuXoBNkYEnP6om0KGQAfbPrYYVSpfXSwbQTsWRVX6RKlydeeGVWbxqsxsZrpL+cIN1V+q84J+jCA9iDsJuZ0rTqoR3NR82kdqP40VlMz5ct/dJ5r8heFHXjkO6tcMyNYE1zcfNN0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(6512007)(6666004)(53546011)(26005)(6506007)(55236004)(66476007)(66556008)(4326008)(558084003)(8676002)(186003)(8936002)(66946007)(36756003)(5660300002)(31686004)(2906002)(2616005)(6486002)(508600001)(31696002)(86362001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWRSdm1NekNNRFB0UGdtODFlS3pYV3ZaSXJMMElFNzlQTmFMa095MTdWd09n?=
 =?utf-8?B?UmdmOXlKUTJTbWlSdnNKeGsrQUZJTU9WSlFRWkhwbXFna09XN2k0cCttV1hP?=
 =?utf-8?B?b0lxRmdTaEU4bWpSU3l3QXVsWGc3M2V6NzJiWi83VGEwcTRURjRMbUFxakkx?=
 =?utf-8?B?VmFjcG81Y1MvWTFCcGFzOXVWdFFZbVdmNHdTVnZ4OUVZWlZiWTU0amdNQkhD?=
 =?utf-8?B?eDBGbE9Na0E2K1ZERURsR1ZaaXBlOFlkd011bWhIZjJSV01IbE9YeEhOTVJn?=
 =?utf-8?B?RXh5eHhWR0kySFhjYkZlRHlYdm4yYXFxWGNMS252U2tYVStQNzVZRmc2Skt0?=
 =?utf-8?B?QytRekdLd0VXTUhHVXRZM3p3djd4MU1QQ1FMSWQvc1JIVk9NWmZvWmxSTUI1?=
 =?utf-8?B?QXRTVXJ1d0tRQnhndlVPMlJ1dEFrZEhUaTNtdm1WZHF3WjM4cUtsV003R1Bu?=
 =?utf-8?B?SEcrWlM3RndYYmJnSWRnOVBqemtlRUtXNnBSdU1lUlVWbjhtYmtXQWJhNGxs?=
 =?utf-8?B?MUhxa01GaFZTa0FFeUoyQjcrdnpVTTc4V1ExWDZOMzFzMDFrTWIvMmRXZWhW?=
 =?utf-8?B?OXFzN2VTempYajdwaVd4ZGZidTFYRmkzU0NZZXZQQlRBRU9UNmtNRHNwMm1T?=
 =?utf-8?B?VHcvWHhkOTgrZzNlV2ZDN1BLQjBaTzBDejdrNlRTSkV3WjE1Z0dlbE83Y2Js?=
 =?utf-8?B?U1FxRUNOWTArWUxUOFZJNGk4Mi9ya2ptYVdZZVIzc0R0eFpiWWMzdjBOaW9W?=
 =?utf-8?B?Z25IM1FWZDlrZUs1K0FqN1p1WWVUZWZYeXhKaUJGbzdSQk90dDlZZjdtTXZH?=
 =?utf-8?B?RTdRSEVIejFVRVlIRmduT3J0ZWl6cEo3bW1hSnJrRmhneVNTUzZMNmlFbUhB?=
 =?utf-8?B?RE93cG1SK0s3cUwzUWpuSXFQU2R6NXJzeEFKWjBmbTkrd0VpaUZibVJ2Wms4?=
 =?utf-8?B?bWpRaVdJc3diSkw3MkV6Z1ZBVmYwZHNOVy9pcGFhSnlVYytuT0l6UTBEZFN5?=
 =?utf-8?B?SjZ4L2NjV240cFNTZm1XVDczOEJBZ1NneGxZNHRqMmoxcUlYT2crT3pjZjF2?=
 =?utf-8?B?UEpBSFhvUW43VVJGMzVHSGErcHB3NlQzZnI1bk9RUSttSldnOUhVcjdIenB4?=
 =?utf-8?B?YzZ3WkF2M3VXZnQrZm5nZERVZ1Y3b2tDY0RNaFM1Ni9qWFRaZ2lsZzNSUklt?=
 =?utf-8?B?SnhsaHlTTWpmYnJkSW05Qkl6Wkd4UnhlcmpHWHdNa2N4WmtQQktzSitGdmda?=
 =?utf-8?B?SDJQOTRzMUJvTmN6OWJyRUVSUDRhK0pacjdDTDBRQUIvRysra2dDblBweGhV?=
 =?utf-8?B?cUoyVVkycStMSXdqT1F6Q012VzNBZS8xdEpVTUVZTEVuSFZ6d3VYNUtTbEdu?=
 =?utf-8?B?NG9kNVdtZVNLNTAxQVlBdVp3M09FMFNWTjJwUWhCbjFrZHZhOHBibDRjK0Fq?=
 =?utf-8?B?WU1RNGp0MTIrTEZuSGVVbnViQ2grckt2R1R5WTJXMEhNa29CNzl6alJhRTVw?=
 =?utf-8?B?S1puN1V4dzU5eFVtcVdPMHFoWVpqOVZ4RUhIT2Y0SUcxSlBnNThxMEkzNjRW?=
 =?utf-8?B?T0RGWS9OUEcxN0s1VmlYVGhRRStkbXpoZFREN3dEM0lRYjN1bENSY2lwSTdG?=
 =?utf-8?B?YXhXeGk3SUI4RElWTjhsS1kzL1FFL1RyeGcxSFdGKzNJTkd4bkIvS2R4SjZ4?=
 =?utf-8?B?Yng4ajBaSnI1L0g5Qy9UcjdDM3k1VXBJVnRmRENIcVpzOEVHMVVnbWlJditR?=
 =?utf-8?B?YldMUFVxa08rYWs5VzBRZ0F5Q1JoRHRSOFNVUGx5RWg1cDVhMkV3WEoxTlFL?=
 =?utf-8?B?MlZWeHQzbnQ0d0R2c1MyZXg3cGRDWW5CaXB5ZUt1ai9LalFtdzg2Um9GSm9U?=
 =?utf-8?B?dXdGalFJZ0tsYWxZMGZXa3d1NUR1MytpcFk4VWI3bVVqMFFadlRqS2tYS2t1?=
 =?utf-8?B?YmRMQVZJellJMVd0alJZdE5BM1RIemJkbXBoTndFUFdPdlFrWmQxK3JBcm9y?=
 =?utf-8?B?aDltYnFqN1NqdVJvcVI2WmlwZllWOFJTR2VLT0VCcXlHeGhoZHV0ek5LNFZI?=
 =?utf-8?B?dWVLcld6MENYeC9oeVhpSTBuTFNJVXpoNkcva21kUnk5cWxXWGNyRUdUOUJD?=
 =?utf-8?B?Q1NHVE1meUdTckQ3ZE0rcE4vVCtuZ3E4VTRyL2MyQ0Vzb1NsbTZLMmEvSnRW?=
 =?utf-8?B?Z0xnR3RocWJ5cjlvdHNRV3pSVGRvTU90T0lUbmlndnFFZFBWY1hxaDdjZHps?=
 =?utf-8?B?bWFqNmRxQnd0UGxHU1hLNnRNNFdoRTJkSklhWi9OazZiUDJUY1NhdUhrL1hu?=
 =?utf-8?B?b29QQWFBblRFV2dvVW5RblRpcWQvZ1ZhZVlLM3BIWmwvRjF5bkNTd084SzFl?=
 =?utf-8?Q?+oP7fyohDs6E38EU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27621be1-2aaf-49f3-43fa-08da34ffd49e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 16:44:21.8230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8lsPz+Fahmx0sZ/1T8xVoTKWV7ou8XsIp82th0AnR9RDHFMo6DNBIJiWYhrQkvGTDqy8bfI/cDNd6Mzrioo9aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3723
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/05/2022 09:08, Krishna Yarlagadda wrote:
> Move peripheral properties for Tegra QSPI controller to
> nvidia,tegra210-quad-peripheral-props.yaml and add reference
> to spi-peripheral-props.yaml file.


An explanation of why we are doing this would help.

Cheers
Jon

-- 
nvpublic
