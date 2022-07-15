Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1628575A87
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 06:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiGOElV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 00:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiGOElS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 00:41:18 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD4F78232;
        Thu, 14 Jul 2022 21:41:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/gBlcTOKXXruMXQZsFnuC0EilUrZuJgfYDM8XVNv1dfGKMEtDTGwaazOR/jTAXTJPCUNAGFZWeWYKZNnb9fbUgRZPSr9qmI/lfygAGvoacosPpiqYYNafLWpuOmmvz0MV2APJVRQts3V7rTlWAneGwEqH5HM4Dsn9rrB0x2Cl/IQW+8Xy+zbcaX5kantKHhr9wuiCODj5UA+EWfj8w9dfkq5qT7k1XiFi8J4gKqvorhaM4SdsrTLz+minYcLbRlTfsFUHQp51MKlGY1oTPnQ71AYRQ0VaBz3ljeTYc/NiaMR4Wm1xrKvH/PEtP2i3wTQEMf7GBh0+1mA+dq738Uug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMAM+BYXFF2kx8V4g1r5txB63/6xIs7NDBVh+yuEQ5M=;
 b=WYpMP4f+1Vr6J8EHVlhjJjdlob2MUApuAkU6w85rP3uSiALdyfJe9D0HIiKJ8h1XWoxzKf7ZHqoDnfHjgkls13U0JSaqUh/pJLbnNH4nM7uLW+1n6a3XCKpPkfd32rJxfE4Yu74UvTZ2bATS2xoIPLeBwQO2ir1de9WwZUIfdrcudSQn+hXrkUF+huPiVU+XD7roK+oAVVXlK/SyD59p0qwwngnMuGCFlw6rZHQTucf4g9RHucJgpdNCRLVPliuju5rMJ06tEXCFpT97ya8r9zPzmpMjqWWVVwa/vUO/ngZ4qZtJSCrJN+T+lXrPyfxciRxgeuHG70oCK9Y8galIpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMAM+BYXFF2kx8V4g1r5txB63/6xIs7NDBVh+yuEQ5M=;
 b=Dpzw6BwUlhHX13aoPub74xsF8/tuGOra5ws3K/wrsrwXEtAxYrB8iNjEimqW+i1aqNq8+eDrbe/BG5Mjhe2Yu+X1ri7KvtUNVD5U0kGAkmMP5pzJpZq+kzfnsBfwzLiEixFyHG4GC5Tu6H5rmoq8N2/J31nsvXnum/Ey31NaCsE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CY4PR1201MB0245.namprd12.prod.outlook.com (2603:10b6:910:1e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Fri, 15 Jul
 2022 04:41:16 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::2ddb:590a:f046:b38b]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::2ddb:590a:f046:b38b%5]) with mapi id 15.20.5438.015; Fri, 15 Jul 2022
 04:41:15 +0000
Message-ID: <87d96692-7dbf-f846-f644-5a81f92efcb9@amd.com>
Date:   Fri, 15 Jul 2022 10:11:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] AMD_SFH: Add a DMI quirk entry for Chromebooks
Content-Language: en-US
To:     Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>
References: <20220714053752.5124-1-akihiko.odaki@gmail.com>
From:   Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20220714053752.5124-1-akihiko.odaki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0175.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::20) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66a38b38-b0f4-4096-7bb6-08da661c408e
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0245:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S1ZYaqEbnpPqZ9p17koIPHvaW6F8zewREdoJrmacNCu1KFTvd4yA6mvKlVFx7SaR+MPM8T1692kj8DT+fD7d495XH3V6k7II8tRiR64Yf0au+sy94+q3jfHaOICuTNpTVciJ0cZWFE68Nbh7uuG2cLBGEWhQsfGUSok4pvylshTLuwFRKVuKvUtyr4IwmsUg+AftFFzG2DC8RXNkp74OyAtpM42VH76vZ4aMjsV61DkIyQs9Jj9zplLqJu8fNiwDP8Kb/mduDRK24mm3VqxrQC4nShCH8Co2qIw1KfYNrVGTugGi6PoV4KaJsm1wsEXuI42Uh8sHqRUqLp4/9YIhBIaTgPFhinxjgCsJtPcM0dfDomgxb24htporMAWQKO9w6RCYIJRd397k8fMc1wCVQjUAYX09Qe0br7BtZFpQBFInPHlH4ia10Vl+ZgOCuzunEKWN0wC+zjyaY3S5zNjmI56GrbxcZc14I7ArEaRJbevocUoy8LzHuzSQjdTdRWXR4NuG/N3K+BjNiguy2lIGCSxiDeS3ANkgv3DfbaOCrep3OFLZ0XbTfa3fq+4fgz28FLJ436BuIK6NmddH1Fgu0B10K45fuBxMbQtqN9tu2COtfYhceIUUm83ArkweHdy606/sDF7gq6Jk05mz6vT/PfijN5j1plgxfmonJat+uMuFWolHdokiyweAe2CtCvO2E2GohWfWHW8ZbT4WMY2QcReCo8wgEqV5ooNFfJv1cSNOLKNE/Whz6f8lwfYD9qwlNOigY4tFAZmYdNzAouT9Uw1lzRPhN07Jv3KqDPIDDzFnbBFF758Kqt8NcnNVNOdyFYkPjdZ4Y72dPs/4pf9bNkeTZfW15trmP2K5ntF9o0M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(2616005)(66946007)(186003)(478600001)(31696002)(6486002)(6506007)(4744005)(53546011)(26005)(6666004)(41300700001)(6512007)(2906002)(8936002)(66476007)(5660300002)(38100700002)(316002)(36756003)(54906003)(6916009)(8676002)(31686004)(66556008)(4326008)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGdmV3hmM0k2WmZjeG15WHg4b2ovbnJ2TmJUVVlwOHZqaStUMlQzQzBOM3ND?=
 =?utf-8?B?eTl6VVp4dFFUMzFYZmM0NFp0S0FpcEg1VHhOeWhHcDVlQ3NUUFczLzhySXdl?=
 =?utf-8?B?YWpzMlZDREZpQWRCTnVkdkhHTUpYNzlsZ3VMcy9vajRhOEZFNkFZcWFVeVdG?=
 =?utf-8?B?Y1lraWc3TWhWNUkraTl1b1hWc0cvMmNvSnM3SGxtNDJJeUtVei93WW4zV1Vk?=
 =?utf-8?B?WnJSaVQ0YzQ4TlJWN3JaWFM4blhYZmlwbGVZNUVvRUZXR0hUUUp5TVNFK2Rj?=
 =?utf-8?B?dU95clBpNDVCZFdOZGxOLzZuMDgyQzY1R3BXZzNHTDhULzVoSHYyM1F1ajBl?=
 =?utf-8?B?TUQ1WEdIazI0ZUJuc1ZUOGxod3BpeUhadmU5V2J1aU1xR0xxOVd4SjRFSSt1?=
 =?utf-8?B?UFh0UkxZRFpwVkVBMXNiMzcyTy9XcjdDcHJYY0lTY1BwclFYMnh5dEMyQjBn?=
 =?utf-8?B?VUlqM0NKa1lvUGh1L3IyaDZSRlpJSzdCMmxjbnFBdVVBRnlYT3NQZnN3LzRG?=
 =?utf-8?B?SUlqSG1obnNzb3IxaWtuRW5nclZtNzdJbW9vM0M0enI0MFZNTTV4eHFaQ2xE?=
 =?utf-8?B?OWg2STBRY01EbVhGcXdLZWlMZklQZFlFWUJ1WEo2RHZGMy9FNVlZclFpbTFt?=
 =?utf-8?B?SjlrL0k0bkcxamFZNGRZbnk3ejY4R2tSTi8vUy9OZEZGN3B4bitIdUlzTVdI?=
 =?utf-8?B?cDFhdzUwM0JEQ2xsRk81clJkeHd3Z2NZUTFwcWptUkthaGxSODIrU0c0WDJF?=
 =?utf-8?B?cFNmRzZieHVWdlc0cGVSazFuQW8vQzdVbU1Ray8zVGpqWmZVbmU3d0RsNFdo?=
 =?utf-8?B?NEhGdmRPNFJJUlRiMUdUYTN3bC93MW9tcjBra2NrT0RRRFpiTXpKd1Z0YzdM?=
 =?utf-8?B?bDU0aGM2QTVwNnkycHNZS29WWWRmMWJwVzJacC9IZC93VmJuTmdjVXpCQjZT?=
 =?utf-8?B?Q0k3dHFsR3RONEp4TTYrYytzcnJoL0hEM0JGK2xLMUUzOTBjL2E2cWw0eGNk?=
 =?utf-8?B?b2ZwTGVhNUtCRzlHdldEcGVmRkJlRExvQ2MyTDNsSzh2YWtwcDduQWNFS2Qr?=
 =?utf-8?B?bzMvQ010RjVRTkhVUXhFVnE4VGNUeGxkejdvd0RIeHNFdEp5bGhJejM0RXdr?=
 =?utf-8?B?dFBlcDRncFJnbDBKZTl0ZUw1aGoxcGJ6TFhjUVQ2WjkzVUE0MThna0laaW0v?=
 =?utf-8?B?RERGTTJkWmZLdFh4Vk5EUEZVT1JNQjY3L0pQMWs0VGV1Q2FUbjNTdmE3TEwy?=
 =?utf-8?B?eHJqVWtRWXZqbHhmb0hJZmd4S3JuQW5KeFpCaTZpMjNYZzhWNThSTy9xZ25Z?=
 =?utf-8?B?K1RlZC95T0Q1ZFNxb3BwTjk1N1RXOGxNYWl4WDRxVnhXL0s4S25IVlErRThq?=
 =?utf-8?B?Z0FiZi9YZEJ2THM2MWJlZ3J0MmJ6bUpSNDZEQUEzT1B1TnlQMTA2MXpncUIx?=
 =?utf-8?B?WWNqbzltWVNhZ3EyVGdPWTFxdlNPeGV1eXFWYXVhb25OTXZLd3VPaUNGT3Rn?=
 =?utf-8?B?OEJ3TU5qbGYwMGEydlllSVZ3enZJWkdkU3ZvYjdJeGpoODREdk95Yy9uZkRw?=
 =?utf-8?B?SXNVYjRrRTZsRnFOSkNySFZsSmtkL09INzZTV013L0Q2cm02U3JvMzdVUnBL?=
 =?utf-8?B?Mlg5Y1dxMUc0RTJ4QlBFZkl5QjE4bVBGMjkxZFEzLzF4Wjg4Q01PK3R1RE1a?=
 =?utf-8?B?eE9pMWhsOWxsbkFyc3RzQkJvckdjZ2NsNjBnZ3BKZE9JaDZzL21PWFlUYUdu?=
 =?utf-8?B?S2IyanlWNkMyd2NaWU43UDVYayttU2E3NVpQZWVkNXpQY3JPTUhia1F2cFAv?=
 =?utf-8?B?dDhNT0x6b21UTmVnWVRTNGJMZDVmVVd2OGJZcXJLMTIyQm9rNHBZSHpGOTc2?=
 =?utf-8?B?TU5oNlpaSFc3SFZ4aTlkU05zblhYcmM5aXpTRm1LU0l5VFVGWGxYcmdiOXYw?=
 =?utf-8?B?Y0ZnWDVNa2RSVGJMMng3OVZ2UXVLTXoyU2VvZzhQc3NidGRWWTY4Y0RFSXVs?=
 =?utf-8?B?MGZMZE55MHVuK2JoUXV0NVpMbVBzVVJOalhPdklDNkQzc3NIOTdvbmRSemZz?=
 =?utf-8?B?b1gydDRQS0htdnZtbWdVdk9QZlpjM3J0VHA0NnNHVkhjVGpOaCsxTzBLSnBR?=
 =?utf-8?Q?zJz29OQOK8cPCBZmo0VsAWAOb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a38b38-b0f4-4096-7bb6-08da661c408e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 04:41:15.8148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e50wi0Q+Sn/OF1CbWRVcER2aFquf4PdRD9YLIjlWSo7uleuewwvKvJbwL2MR6VgbcVJO2xiRIxa3f9c69o3Crg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0245
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/14/2022 11:07 AM, Akihiko Odaki wrote:
> Google Chromebooks use Chrome OS Embedded Controller Sensor Hub instead
> of Sensor Hub Fusion and leaves MP2 uninitialized, which disables all
> functionalities, even including the registers necessary for feature
> detections.
>
> The behavior was observed with Lenovo ThinkPad C13 Yoga.
>
>
This driver should not get loaded in chrome OS by default.
Could you please provide details of Chrome OS Version and Kernel version to confirm the behavior.

Are you enabling manually CONFIG_AMD_SFH_HID config? 

Thanks,
Basavaraj

