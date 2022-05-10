Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EEE52113E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239102AbiEJJrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238957AbiEJJrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:47:13 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE1180BF7
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 02:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1652175793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FHxDje3mVmNbbMwIxADuIEN4YVX05XVSwTuZP7Tjgu8=;
        b=SEjAj5VUfBBBnMK7L7NdqUty03u0266DlHYEH6Nwb5iOFaPzsPpKvPAmHs/+i0mOjks/s6
        IOQbdcUoT9s3z9aDPMPwsWirBRF7xMWxIlGLqp1RewEHMzzddOFkSbAd/L/1X/BdmM1JoD
        NN2y3fvnL0oen2frbbsSaztf+dWvcTg=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2056.outbound.protection.outlook.com [104.47.13.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-30-zxeNnP75OL-2nZsVhVbiTw-2; Tue, 10 May 2022 11:43:12 +0200
X-MC-Unique: zxeNnP75OL-2nZsVhVbiTw-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKUzOYvFG7Bwr7g8+yBG+sLHfYzyAYDZQv16k5CjjFD8/Pnr4zOrNAkSVUTnhRf4H0mrP1SwW5lsTHYxNscYtWTaEPPqCwYQ/UP2ZbeikfN1yXoVt5oCpRq1s0SZ0YRuuDTpY8IJdi+4iHvWI3yYL46PmiqeIef+hOWdxm4ObPIh1lqJoSaqzrmoTOECmKCP8GgtQoAWO87wjxVAJgVwqpb8moL8jCOi26Dg4eiPQdO0ScY/aGT1/qLtKu6DacPrnRXyJkiMTSfHVsipQYzNgTXSs6zzwLXzPNzUL46eNyY9cXNhbtWCODA2Mn24AOHpr/FKW6NQmSfG7mPy351J2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHxDje3mVmNbbMwIxADuIEN4YVX05XVSwTuZP7Tjgu8=;
 b=QMFmthykpINJ07bXQpihDqWpM/UcPCWAJyydpP0oYdAipZjXa2sxr6DfQ46bwzd1E9ikcoR5RDTaU3F1zDChksbqlCpGA1Aa9v7fjIb1U+QymK4C40MFFxE+X/OZpQB8BoX+tPDFb7jM3Ie1tQv4ovRCWMbxS3a5qNZPeZTnswZe/MiIhH7D+NRWSPRpCxrDsc4Rnmx1A7IAE2msJ8VztT2Oml0DyJdRX0pc+U/fqM2KME+DCAKrajBLns+k7ry7dQrk/NxdyZnR1XcA2VwfES1iPTflMZD3i+E89/ITNIgF1uLVsbucPIzkeRrg2BPTmIsSAtZ3abO9kOSMjoQxzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM5PR0402MB2785.eurprd04.prod.outlook.com
 (2603:10a6:203:98::15) by PAXPR04MB8288.eurprd04.prod.outlook.com
 (2603:10a6:102:1bc::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 09:43:09 +0000
Received: from AM5PR0402MB2785.eurprd04.prod.outlook.com
 ([fe80::11f4:192a:78c9:3943]) by AM5PR0402MB2785.eurprd04.prod.outlook.com
 ([fe80::11f4:192a:78c9:3943%9]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 09:43:09 +0000
Message-ID: <55f4b515-1d1c-fd3e-0f93-4cda45261c91@suse.com>
Date:   Tue, 10 May 2022 10:43:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: linux-next: manual merge of the folio tree with the btrfs tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Matthew Wilcox <willy@infradead.org>,
        David Sterba <dsterba@suse.cz>
Cc:     David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220510183908.7571cb73@canb.auug.org.au>
From:   Filipe Manana <fdmanana@suse.com>
In-Reply-To: <20220510183908.7571cb73@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0458.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::14) To AM5PR0402MB2785.eurprd04.prod.outlook.com
 (2603:10a6:203:98::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b1d12dd-71cf-4b6c-b547-08da32697ddd
X-MS-TrafficTypeDiagnostic: PAXPR04MB8288:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <PAXPR04MB82881127C6B31F3B0554EBBAABC99@PAXPR04MB8288.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EQES0MjhGQwZnJq0A/475xRjNnnEZX/ePKoIPeJB9GC55572Gi5GCKq6swtAg0eV+wLuRzoniRug1u/va2o3/ughieQayorZKISUiwp3+5l3F6LoU9jCLdaEpOOwEYeJKq+Iwgy4hNL9/KiTC752h1k8JnGbC+Pc/ae9/OcxiiHqUjdUaQeiY3ZfBUomrEnUCXYyUndQU5med/nXvVUH+e5zLzZCHaWZmZjkBd73PbnXJk3/VcchfygQJfDAaiH5dnmxmEyZx0z0B5n1A+a3v/fTaTnOFO4U9Xa7YIF7wm+t7gTRoTuheYLdxP1qpmpGm3WxDTKtCBAMMOrCSToYDP8dzWBQgYdvDvuGSW/UB9BJ+y/PnJuLgYOlF6sExN9wPoVK2AjbUFA+8yuwT29HVGUGtin/OIW/uGzFtj4SEQ/jT3ME2yikk8KqdgIfC2z/K3Ho0IRJ8hCPUlgKP3brkwl3ae0+xoi4hrWAmzDReNwhZqhYzBrSV+gdo9yS6cIvYY/cFnnXn69apIjy32k/tH07sCjYIgI7EAyfsvKY9oGYNTsj33PzDLcH/KYIluJlp5BQF8ndF+FrNHUVne9Dm6bXT1mOpTkFLA4zlBq9Soz1j0Uua/EVgC/n7a+8DFlPDyZFk+JnaaxI53moEBYn1xNLlZlvD1DcC+d03X4cCKOWw11ej2rb6AU3yiiuuQkZaOKkypO6HmBaIZWSAlvlkTsMSgoenhrEyN2dhl56fb8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR0402MB2785.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(66476007)(31696002)(86362001)(66556008)(8676002)(8936002)(4326008)(66946007)(53546011)(6506007)(508600001)(186003)(36756003)(2616005)(6486002)(2906002)(31686004)(4744005)(38100700002)(54906003)(110136005)(316002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uks2VWhJMmV1WndkZ0ZsQlI5dUFUN0VmTGZYYjNvQ1IxVFlGdTBHRDBBekY0?=
 =?utf-8?B?cERzVkh1SUE3ZHdyMGt5Zzh5citvRXlGQTZGOWlXVjRSRVp2RGt0QmZ6RUZz?=
 =?utf-8?B?d2N5cnhCMUhqUmZxdFo4c2RtVGh0b01jUnRtUkZtOVk5T3JvSE9GSU52eWti?=
 =?utf-8?B?OFphK2NjV0pxTllkR1UraFNRMEZUWUFpbWUybkF3Uit6WGk2SThmK1dHcFV1?=
 =?utf-8?B?VzJXTnpIa3ZzaHI0Wm5yYytqZkM2OWJCSDRSckxLSjYxRWtOMU1EUnBHTTFK?=
 =?utf-8?B?VnpoTE5uSzVST2oyWm5HQXFzUWhJQTRQYmhYZFNqS25VMTY0MDY1ZlRrU0ln?=
 =?utf-8?B?N3BTQ09JdjByRGVRRFVYUk51UTVTMnhzaElCK0dIZ3VwRm1USjlzZHVjT3Nv?=
 =?utf-8?B?aDlTYVJRK0tyU3hyNXNDQXhGakFZZFJzM3RmK05EcnBUR3BxVTAzZGhoNjg5?=
 =?utf-8?B?RnFtRE9rNllBRmVaeDQ5ZmkyaXhPR2JOZWhkbFFZWkNOVVk3NHZmL0l0RDV1?=
 =?utf-8?B?akcyUlNxdU1IYnhNQVNmS3lRRFMyM3dSdWE0Mk1lQjVIQks2TU9teFpZd3c0?=
 =?utf-8?B?OHZhc29adlRmczRyaW9RU3FVTzBwSnJhOTQzbko2ZFRMQkdsRjVqOGdQMmRh?=
 =?utf-8?B?MGtGRUNiaVpsWCt5WFkyRDlXS21XQUxBQmJTbG00MStnbURaL3hmMVZnSU1C?=
 =?utf-8?B?aFpRVUhhd25oZC9Tb1RDNjFFcWRlMlh0OGpmSEVDWEVpdGlmc0ZYb1RDZUN0?=
 =?utf-8?B?Mm81Ykp2WFV6UnJ2Y2kxUjk0QldjWStzd2NZM1BBRlR0MENXMnNydmhRVkNu?=
 =?utf-8?B?WHVUZDJLSVU4ZmQ0bnRVMTRzc1VMWSs2QldNZ040WDFUYVk1UUk0VmVOdmp1?=
 =?utf-8?B?TEpJdUlWMjZxZlhDRlFENmJRdnF6cnBheEtzMEx3MjVaZ0NlVUVVNkFPeFpt?=
 =?utf-8?B?dmR0OElMbHlETkRLVXVlREdIL29VVkFwQXJWQXpva2gzUGFGOWw1KzAzcXNq?=
 =?utf-8?B?UnJkQzBkRjdGMUdpdDBxOWRUL2gxem1MT0hCRnhEcnpuck00N3JEcFNEVUZl?=
 =?utf-8?B?U1c2aUtweVZLR1pBQWpMcHltam9mS1p6ZFVWbERQUkdlcHFZbFJzazg5M01N?=
 =?utf-8?B?bEpZR2dJNUNpRVlMNnYyMGFuckNGem5UVnZZN3RiL1p2VFNybXBZdWJ1Nm9z?=
 =?utf-8?B?QUYyS2dFVXhxWlBLZXFBZy9WYXdXQmNFNkhSV1poeFVMS2tJTHdxRU5EbGl5?=
 =?utf-8?B?SXNvVDY2WFFOeXZENWg2UnAwUythTi9jRkFYSGdvdXFyaFpEZm1wcTlaVFVz?=
 =?utf-8?B?NDBjM1dlbzh1emNmZFB3dThiT25JMVBqOGl6Nm50dDhIYXA4WXpqN2Rod3pn?=
 =?utf-8?B?MzFCaVJIYmdxS2YvdVRicGQrdGdhN05UQm9iSVNCUUxEVDZnWWdFWGE0aVFp?=
 =?utf-8?B?eFpXZGFDblY1UVl1cDJGdVNOd2w1Z3FtZEE0V3Q4MEV2dmdncnZyeVN0cGpp?=
 =?utf-8?B?RndhSGxXZzFUVEp1MHRnbWlnTkhWemE4bVVRUkRMK3poZS8rWEJGRmttSm5C?=
 =?utf-8?B?MGllc0FxRVhnSlpNaysydTZDUi9xeUxBR1ZBQy8zU1F2eXJPZ05xSkpjNTZZ?=
 =?utf-8?B?cEIzSXk2T0ZFclMyT1Q2NTNjZURyNEFzeTA0Mzcvcjg3dVAyUEc2dlA3Mk16?=
 =?utf-8?B?RWVURnJTdTRFZXc2ekRVOEJpbG10YmdSOGtxUkFlZGFaNDJZaWxHVGVYMWlw?=
 =?utf-8?B?N0pKRnM1YkJwN1hUQkdDVEEweGROeFBVNlhDR2gyV1ljYk1pdjRxd1F2ZEpE?=
 =?utf-8?B?UkM5TmdJRzlRRXRlVjdoS1BlRmdsd3ozUk43d3d2L3h0bGM3S29kcCt4VVdG?=
 =?utf-8?B?TjJMcUFlMVk2dVVmL1gzVElBaldlZkhPalVOc0hCaDFsdjRhQXRhcGlpajlu?=
 =?utf-8?B?UTVNQTRMakNxMkREV2NkWGJ4YkZoRTBXOFJxWEtSUGZMSmZlMVdmRHhFZ3FV?=
 =?utf-8?B?NWczWFNsQUVySmI1eGRwN0Zqd1pQb2pTa2FmVnhSUWZPWmMwWUl2aTVTUHlK?=
 =?utf-8?B?Q3BFakVEN3dUYmRYQXFGVlpQbWxjUHFwUlZsanZXdGJUelRIWDVpcFJOOUN2?=
 =?utf-8?B?Z0poOUMzWWdadVBZTkIvZklxUlN0bERKdy9LS2RxSTNuUjJuY2MzUE04ajhO?=
 =?utf-8?B?ekZwZnBFRXUyQk1mMkhNSG5OL2lKN1A1N2FCNkE3NWJ1ZVFLeHVIWDZGeURk?=
 =?utf-8?B?Q0FRQ2ZOeTNtR0laM1U4MjJUb2E2Z1lOUGI5cDRNL3E4ZmpKSmZtSzd3L3Fm?=
 =?utf-8?B?OHJIRjgzZ3B0OGQxajVuckozeFhSdE1SY2grMk4zd2xWMnNMckhKOWV0Y0Va?=
 =?utf-8?Q?xoH/gbDSVQAvJ5NnOEJjDY9lYaAfd6poDsHZLe4E42V4Y?=
X-MS-Exchange-AntiSpam-MessageData-1: PFyZQ7c8AC6BDQ==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1d12dd-71cf-4b6c-b547-08da32697ddd
X-MS-Exchange-CrossTenant-AuthSource: AM5PR0402MB2785.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 09:43:09.2389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xRMt84WMwHZsPAs6x0oZ/jrkJmyuZzrrAfKGvcXzof/urWdzJoMwC1Lgr4zy62HmGdhB5cSpV5CN3lxzIbi2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8288
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/05/22 09:39, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the folio tree got a conflict in:
> 
>   fs/btrfs/send.c
> 
> between commit:
> 
>   d1a1a97304b4 ("btrfs: send: keep the current inode open while processing it")
> 
> from the btrfs tree and commit:
> 
>   2ebdd1df3166 ("mm/readahead: Convert page_cache_async_readahead to take a folio")
> 
> from the folio tree.
> 
> I fixed it up (I think - see below) and can carry the fix as

Looks correct to me.
Thanks.

> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.
> 

