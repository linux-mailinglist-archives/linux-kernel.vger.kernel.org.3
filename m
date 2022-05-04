Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB96519C53
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347599AbiEDJzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245260AbiEDJzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:55:03 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB69275D1
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 02:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1651657885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RIBCT1rrFfVzuyRXT43onKwesiX0CW33peF0U3S9TdE=;
        b=kIw80h4u3qFERXjSYMeLwRV6+ftpjRiUC/CJeYqfT/Gf0PAsx32Xz+dIm7ffV/CPZ6V9PO
        ydJ6ihr7i1T8iXQDcD7Bzj2aNNmPrs4t/O6GFsHij1wWty1NEnQEli85nbVYEwUb/aPXG4
        2LfNi8nJeF9MA3UD/iSxtuU/kdBrchc=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2052.outbound.protection.outlook.com [104.47.0.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-37-2Oz4Z3rXMNy1DgS7CTeIrw-1; Wed, 04 May 2022 11:51:23 +0200
X-MC-Unique: 2Oz4Z3rXMNy1DgS7CTeIrw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KsrawYlaewBsYP4yBOBKoyCJhL+SMYv6oM+Y/gsbskaCY2gyxrLV++OFoJmxwTWkZZtrwCU7A3OgN4+WA8xmCrh2r9uI/GEWSQNNtuxfjGUDyOMrCoxG8dDgHfVgrwZz6xQuf7KYE89DTf5cTbCCCnR7srrAxK+yNULc9eIAa1P/ZYBHSIZmY+t8g5ESVUqL4XqbU3HLkX1nzEw9XnG5820WEC1GzJuRbrTB91uwPBtZJdWxoMufNtsE9CO+DLhXr+eAq4eOS3FYLv5+KhE/islw7BQ0jqYZVJcMqS3fV0A8xBSHdYHdLrWz1y0XgjN4V8y68hBGd52BrjNg+wmURg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIBCT1rrFfVzuyRXT43onKwesiX0CW33peF0U3S9TdE=;
 b=mTtSetnNUZk86stYQTLHlgHZuVj5k5/V8hjYmgXMu2pxtyp8S+yGkNYxPyQL/h8F2Ace0h/O3UlS4CBRvChv/LVVOzd7pvrKVuQCjrJZZRPlShL6k1jLhRSJZpkyhfWav3eR9yYIXJk4dqDbKk4+t6o37854Do2Mpj2zTHpvT+cfgewrZ6txYMn1UCYqxNebp4FHnQjqN7a1mgfMvwGjHl6YItWWXOhyEnlK/NiAuD+VmpMsv4Cw9qwgfMcpYuxPjKukbxkT/iQBRvpo3wKFCx713JUFZGyiHE0MIfTR1Q2lC+Ej1tTNubRTOS1QSKMoPLlwa4NENyxyWkHz3UKkeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DU2PR04MB8616.eurprd04.prod.outlook.com (2603:10a6:10:2db::16)
 by DBBPR04MB8043.eurprd04.prod.outlook.com (2603:10a6:10:1e7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Wed, 4 May
 2022 09:51:20 +0000
Received: from DU2PR04MB8616.eurprd04.prod.outlook.com
 ([fe80::5cb0:5195:4203:7c2f]) by DU2PR04MB8616.eurprd04.prod.outlook.com
 ([fe80::5cb0:5195:4203:7c2f%8]) with mapi id 15.20.5206.013; Wed, 4 May 2022
 09:51:20 +0000
Message-ID: <b73fd351-7b1e-564e-28ca-0eeb68e52773@suse.com>
Date:   Wed, 4 May 2022 11:51:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] x86/pat: add functions to query specific cache mode
 availability
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
References: <20220503132207.17234-1-jgross@suse.com>
 <20220503132207.17234-3-jgross@suse.com>
 <1d86d8ff-6878-5488-e8c4-cbe8a5e8f624@suse.com>
 <0dcb05d0-108f-6252-e768-f75b393a7f5c@suse.com>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <0dcb05d0-108f-6252-e768-f75b393a7f5c@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9P194CA0024.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:20b:46d::29) To DU2PR04MB8616.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6498b1c5-090c-4e8d-8a46-08da2db3a430
X-MS-TrafficTypeDiagnostic: DBBPR04MB8043:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <DBBPR04MB804394BA8F5C4F2E0EC46B9FB3C39@DBBPR04MB8043.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5wlZPykJ5hK/C67K1e3o37RvqG3sQR/uouJKzeCR6DICD1pet22o3YotQvRBH1/HGVnvDUn7nqZSSzpHfJu3qblZ9cSIvh6l8HppT000ysH7XQTaRiHHyQ/cbA5M5BwoVPyV3GCQbZlxv2WL4J6hOD8g5QuVO/6YgXEnqsQysfoU8EksuLjYbrblbzellvLSPe2727UBEt80grRSSTg86xioc1k6taF1DlheZ+Ot3VJQS91xIdo5i+5+/wegjiGa4uKI/Nv3VnRwm/V9MAfiqH6yK7WxffTEQFfgPD/2qBw80Q6rY4XgoNw3ikLZx1PzhR2tbWIv9QMrVLBojpP3FYFVo1AHxIH+/Njd649ZYZinghT9kJcBVZuAYkQv+CgxvrVFjNGt86XIz0KGBl6q1JtOkYfMOVyGEoyET1bbnURmd294JxBeLKvKjWnqvGfsL0Ca7vTjAwVmQym78s5wJkIK5gMdJir0xhAOsa86QeKkGUrqzSrv17lm+AM3cIOOm0p7pyo1rSn1U0WIEjnPdXhNktTkEWunU3vcTla5mhpTi/rfiWaQTeOwh7DS8ofgObSoZPJUgjeSuXhK0D5b/i1ymCgfipGjjow4R7CRGmZ7b2dfm5Mnei3XS6fBXHSxg115/fP6w8oLM/D+H1OzDrnKT2jzdaixETPPqqbUe0ChHBFhAolK6nqkhwXv7kCeN9FYH723yPjPzdqcpkNm3YZ5VTS4bEEdhcEjHYa1Lgc4c+VXJXLREzrMAaJv0GKf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8616.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(508600001)(5660300002)(186003)(8936002)(26005)(316002)(6666004)(7416002)(38100700002)(6506007)(86362001)(53546011)(31696002)(66556008)(66476007)(4326008)(6862004)(83380400001)(36756003)(8676002)(2616005)(66946007)(2906002)(54906003)(31686004)(37006003)(6636002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVNQMVhDNENaT2UzY0xSUkI5S2hvM1MxcGhWbmhrNFRGSlZjYnF5UEkrNjFM?=
 =?utf-8?B?NkJtT0dyR0NyRXFGdjhhWG5KR0pxaVpoQmpTVUE0ZlZnOHZ3RmV4aGdreDBW?=
 =?utf-8?B?SHhqMDhsNWNjWExyWDJvbVQwalI2dXFTNUQzOG9Ca21lRGQ3SmlWekJ5cFh3?=
 =?utf-8?B?NEpKU1JkU3dJYjE5eWNOczU4eDF0Rnh4Ly9JcDBScHhVclZuV0lzMDlqRVYx?=
 =?utf-8?B?RU50Y3FEL29UL2U2dHNGNU5FeTZPM3FtWXdXb1ZxUG51dWcwbEFqQksxWCti?=
 =?utf-8?B?aVV2eHZMdStmQUp2UitWbGlEbFNmM3hDaWFzOHphdXl4RURVYXd2T1g2bXZE?=
 =?utf-8?B?QVJDQzcxUnRzdkVtWkF5R1cxY1ZvbnQrRDQyVFlzOGxWMGc1ci9xTnFBbzJP?=
 =?utf-8?B?MytTOFU2RG9FSVdlbklWYi9va1hRckxSZUMrM292eVMzalZ1NXB5VXhpd0xx?=
 =?utf-8?B?S0srMUQrTFpFK3Y1dUQ3UExzcHkwYm92aDltMnRLVlhxZG1GRW9mZjY3amVj?=
 =?utf-8?B?ODVZZ2lyOFd6eHF2TFFmRHdhVVNKRFRXWGRacW9hYWM4bGlNRHFjRzBaTWFm?=
 =?utf-8?B?Vkk0UEpzaVcrK2M2RksyYjJQaWJIdnFWbVMzQnpuaElPdk1zN1R1dCtzSGVR?=
 =?utf-8?B?cHFuYWpJaEt5RnBmWmU4TXBCelhROU5MeXlsMk1xUGVUTmcyeHIweGFOcm9I?=
 =?utf-8?B?TEhwa3VZNXdjZlNEbDgyYjh6SjV3RStXam9vakw0MEN5QTUwc1V4R25ib0dS?=
 =?utf-8?B?R3BLTk95bHVrODBEcjdKRHAwL3p6dkJUQUpwUVpnTnNuL05tbTZUbG1PUXFv?=
 =?utf-8?B?MDNhNlVXU2VuWEZDYUVSczZlYnZIVEhTVUlMZVMwV2ZrSnlTT1dKaWFsMWVr?=
 =?utf-8?B?MUJ2TFozLzI2M2MxdWx3SU5tdlcwVGl3V1B4Wk1iVUhLMUgwYkZ2aTZGdWl0?=
 =?utf-8?B?LzNtYVV3UE42VVpPM1JuSFJNRzBLMm9ubUNub25sbVRGMTZGTE1OL0tKeXo2?=
 =?utf-8?B?Mzd0TFlhbmhqZnA3emtOK2lvV0trNklrNnpDa1M5Z3VjSUlFMUxWaHY3OXVV?=
 =?utf-8?B?b2ozNlgwV0JDa0tqNnFKL1k2SXp0SlBwdDdHWU5FbVlIMTFVQ2k5QlBDOHBJ?=
 =?utf-8?B?bUpiUkkwUURQUWhBRzJET2o3elRJYnZ5TFRQZkRKbVJCVExEWm9HanRRWUpF?=
 =?utf-8?B?dXB5U0ZVLzFJbWtqVTNPbkpkUlVlc1NBOXFDVFVZUHdnWVlrc3lJQkF1VzBj?=
 =?utf-8?B?MHlteTJ4YVArQ1JvcFdzekhPK1RyTEhFbUhXSy82RFdrdS8yVFJ2WGgyOFBv?=
 =?utf-8?B?SXBZUUYxS2xlS1U2Z2NDbXk1ZG9oTlBIRFJkMDA4eUNKUW1ibVZBcFNJM2tP?=
 =?utf-8?B?NUVOSmdrOWpIVlZhRXBrS0FTRXAzZlUwaDBqZDR2U3JTL3JLM1ZLUE5LcnZC?=
 =?utf-8?B?NXEvWUthdW03c0d6VXpSWWtFdlRpZG5jRy96bGJ5bTRSM3hVMm1iTlBvZmdB?=
 =?utf-8?B?cWk1elNHNkMzN3l1MVZ6cGlNUmY1OStPelZuNzdVY3ZaaGFJZjFuMFVpY0xs?=
 =?utf-8?B?elhOeFdDdXBobHVRWDRJYWJKSmh0aVZIV3BlUFQ4aS9qeTJTTkhjMzZ6cHpT?=
 =?utf-8?B?dnQ4bFp0U0VkNjBZbGJqcm43SmNud08xRmtNOXhPUjRrd0czVVJodUlPVU5F?=
 =?utf-8?B?c2dYRUJHZi9JSGMvK1o1YU1kaE1UWkN3SThqRWdEU2R4a0c2MkQ4T1MwZGtD?=
 =?utf-8?B?UUY1bllxV3BrSGxIQ3lWSEk1OGtNdXVwTlNkUzRwNUVjd1dMYXFLWk5EZWJv?=
 =?utf-8?B?Z0JqNjhCeXAxL0s3R1J4ekFJQmljTk9TL2JsazMzR0NXbGtLN1lxRDVBaVJO?=
 =?utf-8?B?dXUvY3Z4ekxIaXdZb2VsdEVsKzh2Q2lMSHVUU0NxRGU2QVhVMnU3aklRM3NE?=
 =?utf-8?B?dGxxQVhjNTdIQXBHTk4rTDRTT2RUY1VzSVNUblB2L1EvWGo4VVJmbVp1V1ZY?=
 =?utf-8?B?QlIvcmNSMDBTS1lsVVB6M3c0dTAzeTM3cWVZNW5zU2xrRVhKc2xGSmxqd1lN?=
 =?utf-8?B?QStvYmJrUHYybEFta3YxZE8xQ1lYQmJiM2ZSNGUrczMzLzE4QWJmWTlJa3Bq?=
 =?utf-8?B?cEdVZUZVTHBLYndhcS9XRkhsK1pqbEg1RFg5K2ZJSHVjSkR3UHNhb3N6T2JU?=
 =?utf-8?B?TVN4R0RLWmpxRUJzL2ZSMFBlbHZDVTdVRGFwNm5wL2dua01vUU1NeXVqUXhG?=
 =?utf-8?B?eFJYMDRCaXZuQzFPSVNsWUVXeXBMVWlNYmNXbnlJT29jT1dVUlZiY2txS3hN?=
 =?utf-8?B?TGdXNS96ZkJWemVQTXp4TlFEWmI3MXhYN1c4ZUxlbDBYTEs0bVNtQT09?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6498b1c5-090c-4e8d-8a46-08da2db3a430
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8616.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 09:51:20.4324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x18Q+h6dqK4TJ6XqYgwEsWrAjakGvYPTmq6w0o4XhpedTHIzVkbHqjeHKAcS43UmADypyJ6586HslpIWsanLHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8043
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.05.2022 11:14, Juergen Gross wrote:
> On 04.05.22 10:31, Jan Beulich wrote:
>> On 03.05.2022 15:22, Juergen Gross wrote:
>>> Some drivers are using pat_enabled() in order to test availability of
>>> special caching modes (WC and UC-). This will lead to false negatives
>>> in case the system was booted e.g. with the "nopat" variant and the
>>> BIOS did setup the PAT MSR supporting the queried mode, or if the
>>> system is running as a Xen PV guest.
>>
>> While, as per my earlier patch, I agree with the Xen PV case, I'm not
>> convinced "nopat" is supposed to honor firmware-provided settings. In
>> fact in my patch I did arrange for "nopat" to also take effect under
>> Xen PV.
> 
> Depends on what the wanted semantics for "nopat" are.
> 
> Right now "nopat" will result in the PAT MSR left unchanged and the
> cache mode translation tables be initialized accordingly.
> 
> So does "nopat" mean that the PAT MSR shouldn't be changed, or that
> PAGE_BIT_PAT will never be set?

According to the documentation for the option ("Disable PAT (page
attribute table extension of pagetables) support") I'd say the latter.

Jan

