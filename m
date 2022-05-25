Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965D65341A8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 18:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242378AbiEYQpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 12:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234192AbiEYQpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 12:45:01 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2108.outbound.protection.outlook.com [40.107.220.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C3610FEC
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 09:45:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZagqbzPmU4VVx72ey9u8QCXNdDdExN8e8vyN609nktDtcaekpztKpxX9DrWF19jk7sji23h4pIVjNB2/uz0GzHcFspGxdXtMDtNGLGcirXpzj5etQZg5pMZa9zx2nP7SSKiJqM7kHhbeF6VFrq5ZtLMPtuEn4kMVKWpnnx2KrSw5cpo2stkGqyFtaF+w6Sl6BMnq+ZtJJPObi8zT+yjUu827PK3bTpsjYBK/zJocubPQ4x8ZIevPd1+vxzHQsXI6cKhQgbLeaL5Gnhoq50Bf08o0STSwccD9DELunNmlKa+DHidkG6Q+3Su7owaP+KkbJyytKjSYTQKymBUw1vd9GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWqTmNwWUu7Jo3NpvfA1uRg5ixaZx0BbgZWCM07PLfM=;
 b=Y1KwRzCdYmlvbQ6EPOF3vkPUo6F7WIp5LZLjgfoLp4ZbTppR+c3WCiabDU8147SoqcksJkVT0ISVHLFoCI8I5jzX5KCn0/PXx5EsL0DMeY6357g9UXYKmy8hNtOo9tZiSZGN+38TYW8jBn+SZ1WWT/B+bQmhkaZnIAHECYUVe9+oc6keLD3ihLjQijcXNAOInyfHJuV7zbycBM7jo6uWP1Abvax9/j+2jcr2d7SssNh4tzs3pHq77zjq/aqLsnl93taOzLWCL3o2oQbEoebxq5UZOtKd+OqO3yE6ahgEydHaCL0J+uTvKBE0ekPBi2HiMm4TEubSNnA1cy2tkGS9NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWqTmNwWUu7Jo3NpvfA1uRg5ixaZx0BbgZWCM07PLfM=;
 b=oeL5wkhvT1KIa7Vhc8/nlKUJBavkJm0yxXXOsCgxgTTC4Jjc5hOCQkHKCKqcgZRerPZnj4QJzw59/x/ErD5/rW6dKfJHReKj3JZHL7ML5P9UFaRy24U4/jYecJj1zl5SaL3MT4QjmI9fbSxtCsg2yAzvZ0j6xNkNE27eT1jpKoU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MWHPR01MB2638.prod.exchangelabs.com (2603:10b6:300:fe::18) by
 SJ0PR01MB6192.prod.exchangelabs.com (2603:10b6:a03:291::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Wed, 25 May 2022 16:44:58 +0000
Received: from MWHPR01MB2638.prod.exchangelabs.com
 ([fe80::79bb:5790:1d28:ce4]) by MWHPR01MB2638.prod.exchangelabs.com
 ([fe80::79bb:5790:1d28:ce4%2]) with mapi id 15.20.5273.023; Wed, 25 May 2022
 16:44:58 +0000
Date:   Wed, 25 May 2022 09:44:56 -0700
From:   Darren Hart <darren@os.amperecomputing.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     "Zhouguanghui (OS Kernel)" <zhouguanghui1@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "xuqiang (M)" <xuqiang36@huawei.com>
Subject: Re: [PATCH] memblock: config the number of init memblock regions
Message-ID: <Yo5dCF/Y9ijrMj5Z@fedora>
References: <20220511010530.60962-1-zhouguanghui1@huawei.com>
 <20220510185523.3f7479b8ffc49a8a7c17d328@linux-foundation.org>
 <YntRlrwJeP40q6Hg@kernel.org>
 <73da782c847b413d9b81b0c2940ab13c@huawei.com>
 <YnypGu1Cu2xPQ1nA@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YnypGu1Cu2xPQ1nA@kernel.org>
X-ClientProxiedBy: CH0PR13CA0040.namprd13.prod.outlook.com
 (2603:10b6:610:b2::15) To MWHPR01MB2638.prod.exchangelabs.com
 (2603:10b6:300:fe::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a820e601-1160-4f0c-3748-08da3e6de75c
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6192:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR01MB619296AE11BFE574F7712122F7D69@SJ0PR01MB6192.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NCUN4fKW4Onq7XeyRgFrnfzloqlT+OVQwDJtCMD7jN9TpPowxClhePwKocentxnuzbnuMtvhd1tdhdk4ljU+Ot3qjGSGXgJHmA5DGb63jSchGbWW5g6BWoEjoxZdI7z0yHEDJYDNrBtIOzQ/tYhTisKJwBsO1VVZUDtMVbjvrn2MgthMAvsYUJCTB+6D96vyz2OkvupOOnORqjtZZuG2+PR6FSWuXckKlwDpuPuSUpcH2N54ixG5aTxff4FvPFacRC5dM4TvZ27pRVObZtfLnYcuO4+0Rj8Mo9WTB/AR7NNSG0ZCHRc12L/+Q89jRjqbSFh6d9uVgdGMfSvR1QiMb2/2QwxPSst9oHL8w6xg1Wd8uvccbquqnKsEAYC+7Z4TGv98eli3M+W7U7heO/R6tBqUc7lXtgD5HNMp7h3gM5ydbuUS+3nleuOGIPKilSlq+YerlpUkC9SiNBjjhWmeN4eP5mX2DIZaQnCyq98QkVD/FDq2UP9untfJWzrUdntQOMna+1WR/++JX8rxnrDDz4B7Ncyak3TRakceJvyWTqYRY5zkYHXPlA62NwTZ+dlDN9vq2yzFqI0/jIW106sxf/A9LUFgJUz8qxb8M//NX9ZiBKlVG1AeAe0GW8qj44WN4as4liytpwiqKG1IoZgI6GNet6+44rXY1JXhNbRB/wfb4q0T/4lgo6JxZCC+sZEClvLtiZXpoU5YRB8zMSE8Tg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR01MB2638.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(4326008)(8676002)(83380400001)(86362001)(33716001)(316002)(186003)(6486002)(508600001)(2906002)(38350700002)(38100700002)(8936002)(5660300002)(6512007)(26005)(6916009)(9686003)(54906003)(66556008)(66946007)(66476007)(52116002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDd6WnVRcEZLeGlsSURoNmp0TjFFb25yNndIZnlzM2tybTQ4L3M2dmw1Z3dM?=
 =?utf-8?B?Y1RkOFNielBxUGQyNkluUmU1VGdvb051M1RkdFB4djRPd3hxaUQzWlBwMXdE?=
 =?utf-8?B?MWNVdWhRckhCc3ZzMWU5Q2lmeFdlak1hQ2lCWGg5QkYydHN5TUNNR0Q5RXpx?=
 =?utf-8?B?K0Q0ZTBOMDhGbU5DdlZGSFJlWS9WaTZwOVUzV3IwRzNnSEJLclhMd2pXZytE?=
 =?utf-8?B?cEJnWGZScVpscjhqR2NxWWc2SWQybEpQNmIvU3crRzZiY0xlN3FqMDdFR1RQ?=
 =?utf-8?B?ejVUdVJ2MjRydDJuclRoNzhxY2kwMlByRGNmYlRMV1c3ZU1MczN0ci9XOHpq?=
 =?utf-8?B?anNLcDlVQStTV3hqcW5mZ2tObHZRU080RmRBbDNOTzRCUmRzK2pjZ3lrQW5Q?=
 =?utf-8?B?SW1tRnBpZEo1eGdzTWQrYmRxYUhHYTNRbGthbkI0d1NtWXBuUHplNzJ0dHdm?=
 =?utf-8?B?YmEzc3lwbWdPdTMwcG5xR2JsM3lLYkEzbmplQ3hjQVdpK2FPai9nMHF4eFcy?=
 =?utf-8?B?QzBmd044dGlsNk14d2NIb21ZMFZZNnhUTFRwY0Rva2VWZGhFenlMY2U3aEFJ?=
 =?utf-8?B?UUJlM2g0ZDVzY0xxWGxVQzdpNzdVUkpKaHpmMURSUytRT3BjRzFQdjBNUGQv?=
 =?utf-8?B?NmpYUmpDcjdVVVlNRS8rOVpBQ2VONlRVOGtmVitPb0F3Rmp2YStET1k3RDQ1?=
 =?utf-8?B?SGNuUS95ZzhEUm55czJ2ZVkyQnNXYm5pc0NsRm12VXk1ZDNsakk0dURiTTVn?=
 =?utf-8?B?d0hDQmZ3U1ZhQmc0UlpzWjNZc2ZNM09IOHBrNHg2RENRek9WUE9VZXVaR0dV?=
 =?utf-8?B?R2YvVXh4dm1YYmhCZnhCYWtCek1pd3F5b21NVGpQaXBsSitBWEJ4aWFOa2RV?=
 =?utf-8?B?MTB1YWNQRmlkNDBpbnZZMVl3QVdDTU5TZnp1bjFoZXJaa21VRmFqaU9rY3lM?=
 =?utf-8?B?ajhkMU9YZnVJbUsvb1FjK1JQVHkzWUluaGlXbjJkaERJY1pwS1BFMXVyUjZW?=
 =?utf-8?B?VnNSNmRZOWU2eTQzWVpPN1d1OE9ZOWp1TzRiVWRGU212TForU2EvWmNXV0Y2?=
 =?utf-8?B?S1hNSE1VNEswdnI4UkxwU3pVUXpzWkF0ZjducEhNOHIwMUFDQzMwdUVEOVhY?=
 =?utf-8?B?MVpHcERCb3E5aThFMDVLR24ybFN0Rk5oT013bnBjZTBabThCaHk5RjdCZElP?=
 =?utf-8?B?WEhlRUdhekljRDZNR1lHOFdYaEJySDFtYTJ1T3BydmM2NXFSV3dsY1NuYVZG?=
 =?utf-8?B?Q09YdHoxYkdNMG1sQzMrakdwR2tjOG1xanVuQy9tZjR4dGxScnpuWi9PcUQ1?=
 =?utf-8?B?TjVobW5wUmNsOWFBcjYxRWlLK0dJdzdDSUFXZjJuK1hYMEl3RXl0TUFtYkpy?=
 =?utf-8?B?YVRUZFA1MFloWDlGM3pzYnI4WVRvbHU1YUV3Vko3elZEWG9tQ2d5NjJEaUtz?=
 =?utf-8?B?aFMwVlBJbENtOFBaQkRuWTBrQjRISUltNjFDTmVTdkl0bEMza2NESklIbVo3?=
 =?utf-8?B?MGg3QUVFc1JFaC9OcUplT0pLMnZEUkRxSWh1MHlwR3FoRDVOWk1tQ0RKOHha?=
 =?utf-8?B?eHB4dldLbE16b1ZmUUpoUjdLalFXdzdFYnVhVTkycHdSZnRnUWtORVRNUEU1?=
 =?utf-8?B?YUlnSVI0L05QNmtwdzVnVXRDSmt4MERZZzNkakN1aFhUc3VMRHRRSVY0RHow?=
 =?utf-8?B?c0xGb0VZMjREdUNkK2JzVnBPSlFlUTlmcGUwank0U25paHRsNUF6K2J6Q1Jm?=
 =?utf-8?B?YWtQdXdXcmx1TzJjTU9CeEZTKzA4WnBrdkk2QVN5cHdadHVFVVJVRllzWHdN?=
 =?utf-8?B?VVBaQllMMjVNL1hGbzE2SG9lYkp1dXVWOFZMWi9kVWkxOUtVdlZFbzZUNEFI?=
 =?utf-8?B?QzlYTk4rb1dKanMrbzFTZnVBeWowa2FRZnNha1kvMXFuVEZrQk54T0RiZzZ3?=
 =?utf-8?B?QTFVVCs1QjYzeVQ0T0tFdzZrT2hnZjZvQ25GREFkc0t4ZDVPWmxDWUNEMWtG?=
 =?utf-8?B?L04rMGxJNWRYY3JvOUVESnlzVDBHZWZOdXh5a2RwRm5ITnJ5QXFYYUNFQWZH?=
 =?utf-8?B?RDNuUlhvdGg1R1RJbDBGNjlkREdCT3V2SXNIZFdzTC94UHVXOWtXYjQvdkli?=
 =?utf-8?B?cFpvVi9JaEExY2hUU0t3V2syMGxva2xUWEUvdHpWYUxiK3g2TkhaMUJvMVYr?=
 =?utf-8?B?Rno1MFRObnNyVDZMTlo4UTc3NUpoYzl3cjd5Nm5LNkI1Z3ExYWk2bTQ3T01w?=
 =?utf-8?B?TUREVVU3TC9JWEpUdEhONkozWUVnSUNPaXIrcmpnM0IrU2Q4N0p5N1QzYmlY?=
 =?utf-8?B?T1EwQmJkZXR2QVpqNGZrdUM5eTdrMVRtS1pzMW5vL2FUWmIrMGFXWDdXNTNr?=
 =?utf-8?Q?coTwV9/YyvKkwRC+ievBEVD5JrwQczwgKY/Nm?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a820e601-1160-4f0c-3748-08da3e6de75c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR01MB2638.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:44:58.2471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1goDBVDPdq8Y4NQVPdP4fomI9ie40cdDZwvHt+mVel2dAX5PF4FAjqCqSS4iarzw0IN4Z7nNEwnyGTXNNN6Nb7IEi7xzVr9d5zM3Cr2g2Nn3S7UzsYZPP87XL4Z0r4Uf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6192
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 09:28:42AM +0300, Mike Rapoport wrote:
> On Thu, May 12, 2022 at 02:46:25AM +0000, Zhouguanghui (OS Kernel) wrote:
> > 在 2022/5/11 14:03, Mike Rapoport 写道:
> > > On Tue, May 10, 2022 at 06:55:23PM -0700, Andrew Morton wrote:
> > >> On Wed, 11 May 2022 01:05:30 +0000 Zhou Guanghui <zhouguanghui1@huawei.com> wrote:
> > >>
> > >>> During early boot, the number of memblocks may exceed 128(some memory
> > >>> areas are not reported to the kernel due to test failures. As a result,
> > >>> contiguous memory is divided into multiple parts for reporting). If
> > >>> the size of the init memblock regions is exceeded before the array size
> > >>> can be resized, the excess memory will be lost.
> > > 
> > > I'd like to see more details about how firmware creates that sparse memory
> > > map in the changelog.
> > > 
> > 
> > The scenario is as follows: In a system using HBM, a multi-bit ECC error 
> > occurs, and the BIOS saves the corresponding area (for example, 2 MB). 
> > When the system restarts next time, these areas are isolated and not 
> > reported or reported as EFI_UNUSABLE_MEMORY. Both of them lead to an 
> > increase in the number of memblocks, whereas EFI_UNUSABLE_MEMORY leads 
> > to a larger number of memblocks.
> > 
> > For example, if the EFI_UNUSABLE_MEMORY type is reported:
> > ...
> > memory[0x92]    [0x0000200834a00000-0x0000200835bfffff], 0x0000000001200000 bytes on node 7 flags: 0x0
> > memory[0x93]    [0x0000200835c00000-0x0000200835dfffff], 0x0000000000200000 bytes on node 7 flags: 0x4
> > memory[0x94]    [0x0000200835e00000-0x00002008367fffff], 0x0000000000a00000 bytes on node 7 flags: 0x0
> > memory[0x95]    [0x0000200836800000-0x00002008369fffff], 0x0000000000200000 bytes on node 7 flags: 0x4
> > memory[0x96]    [0x0000200836a00000-0x0000200837bfffff], 0x0000000001200000 bytes on node 7 flags: 0x0
> > memory[0x97]    [0x0000200837c00000-0x0000200837dfffff], 0x0000000000200000 bytes on node 7 flags: 0x4
> > memory[0x98]    [0x0000200837e00000-0x000020087fffffff], 0x0000000048200000 bytes on node 7 flags: 0x0
> > memory[0x99]    [0x0000200880000000-0x0000200bcfffffff], 0x0000000350000000 bytes on node 6 flags: 0x0
> > memory[0x9a]    [0x0000200bd0000000-0x0000200bd01fffff], 0x0000000000200000 bytes on node 6 flags: 0x4
> > memory[0x9b]    [0x0000200bd0200000-0x0000200bd07fffff], 0x0000000000600000 bytes on node 6 flags: 0x0
> > memory[0x9c]    [0x0000200bd0800000-0x0000200bd09fffff], 0x0000000000200000 bytes on node 6 flags: 0x4
> > memory[0x9d]    [0x0000200bd0a00000-0x0000200fcfffffff], 0x00000003ff600000 bytes on node 6 flags: 0x0
> > memory[0x9e]    [0x0000200fd0000000-0x0000200fd01fffff], 0x0000000000200000 bytes on node 6 flags: 0x4
> > memory[0x9f]    [0x0000200fd0200000-0x0000200fffffffff], 0x000000002fe00000 bytes on node 6 flags: 0x0
> > ...
> 
> Thanks for the clarification of the usecase.
>  
> > >>>
> > >>> ...
> > >>>
> > >>
> > >> Can we simply increase INIT_MEMBLOCK_REGIONS to 1024 and avoid the
> > >> config option?  It appears that the overhead from this would be 60kB or
> > >> so.
> > > 
> > > 60k is not big, but using 1024 entries array for 2-4 memory banks on
> > > systems that don't report that fragmented memory map is really a waste.
> > > 
> > > We can make this per platform opt-in, like INIT_MEMBLOCK_RESERVED_REGIONS ...
> > > 
> > 
> > As I described above, is this a general scenario?
> 
> The EFI memory on arm64 is generally bad because of all those NOMAP
> carveouts spread all over the place even in cases without memory faults. So
> it would make sense to increase the number of memblock regions on arm64
> when CONFIG_EFI=y.

This seems like a reasonable approach. I would prefer not to have to increase
the default for EFI arm64 systems (and all that entails with coordinating with
distros, etc.). The point below about other arch's not needing this is a good
one too. This seems like a reasonable way make the defaults work everywhere
while only paying the price on the systems that require it.

>  
> > >> Or zero if CONFIG_ARCH_KEEP_MEMBLOCK and CONFIG_MEMORY_HOTPLUG
> > >> are cooperating.
> > > 
> > > ... or add code that will discard unused parts of memblock arrays even if
> > > CONFIG_ARCH_KEEP_MEMBLOCK=y.
> > > 
> > 
> > In scenarios where the memory usage is sensitive, should 
> > CONFIG_ARCH_KEEP_MEMBLOCK be set to n or set the number by adding config?
> 
> We are talking about 20 or so architectures that are doing well with 128
> memblock regions. I don't see why they need to be altered to accommodate
> this use-case.
>  
> > Andrew, Mike, thank you.
> 
> -- 
> Sincerely yours,
> Mike.
> 

-- 
Darren Hart
Ampere Computing / OS and Kernel
