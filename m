Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569CF5A439B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 09:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiH2HOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 03:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiH2HOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 03:14:37 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF67D4DB04;
        Mon, 29 Aug 2022 00:14:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HY0+nQlUTq7GTRlM9UwkxzDP/KgfXV1zusjHNtBaumIuiqSGnEp7lH9sXd8bFq4A50xIAojW1K+ECDfObskTc5T0X0KqYBe+asqMaTKaw5XNYiU+T/xlA5KHdqfTpN94E6FjNY1NLmzXD1dHhbYuksqrG/IFAtiHuwBnSDKK8uHlURtm+e1OMkO3lrjvzOfa3Wo4rOjsiBnUBkYJeh215mzJTyRzTZ1knddqpYD/xGkIAzfjW8B4Mpe7YN08OnybFfu9/gNIvcaog3s1paMzqdUwbwjFgkBcZAEBAWyHjAWirBbJOvlpkzvQ7RQ5e3LyV6X+yTH33RkwiTQJHRcrrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbvYsuSsANPoxPGBVV/Xw6M5alWpbfSyzZ0YQRo/d14=;
 b=iUNb/sUev4mYx+SEUhIuDxxRf2Zuo1Cfz3Z36F8SjNbFF4IsUU4DKZLqpLdciTN6lrKTg/cFNEg9EWVfCnRizlHXk1oiFQg4WTFaAakZ8FN4FkHD73FqQCaeRTWiA7h65NW6PoRAR8tq481M7rOfSemdWbl6GqCGGZ2D8b8Gmj3BY3G6L2psGOLmWTgSSU6jlAQh967Hp+huyAp9Ves+p1IPiwR+CNyVpNHnmrt2cXOi4zSs0xJPKClJj53HwaeO7DeFaL/qSEH66X2f2zpjKYX1cXkirdtKECiTPSPdwO6nFgWrKLel+xslftlD2QLTqwGgtitTQ7OJEwqQmaP0Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbvYsuSsANPoxPGBVV/Xw6M5alWpbfSyzZ0YQRo/d14=;
 b=vI8Da9L8q9PCnn0FJohBQJp5dJeLL6xSiqqI/BuVwURzQSct90QO/uSE8i6+FWl++Xbu54rh3tThE1YS/JS6AnvpDcfF5CHcofbz+drTXCeK+2BtPSLd4BqsfOIiUh9hrvJN3PiGsBEJeZojg0FQp7E5mqiT6j41E4BMEnYenLxoRI3l+LizyMk6HafFhyACzZ68aA8PsPrdu1FKGzHmPqDFry1VwiPUFI4re5V011X3U9Ats4hH3pF/mkUTtNj5phePnGeOGpkLd7HiLbnCx8/3fTPANN6nJ2oiipujUS1hXCjsvJcb0x56j7TT86IDrJMLU4fl5FIjiMdEOkDvRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by VI1PR04MB6175.eurprd04.prod.outlook.com
 (2603:10a6:803:fb::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 07:14:34 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::69b0:d4da:39ec:4dc8]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::69b0:d4da:39ec:4dc8%3]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 07:14:34 +0000
Message-ID: <2bf2b4ee-fd8d-962d-0daa-9c8093ad331e@suse.com>
Date:   Mon, 29 Aug 2022 09:14:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH modules-next] module: Add debugfs interface to view
 unloaded tainted modules
Content-Language: en-US
To:     Aaron Tomlin <atomlin@redhat.com>, mcgrof@kernel.org
Cc:     christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, atomlin@atomlin.com
References: <20220823193225.2072649-1-atomlin@redhat.com>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20220823193225.2072649-1-atomlin@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0164.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::18) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ea0ab94-1f6c-4c4d-57ad-08da898e1feb
X-MS-TrafficTypeDiagnostic: VI1PR04MB6175:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NOZnJbU3E7exSIPZF57Qtf+nw7zJI/gn2fo+dSJvjA2E5LJ4iFL41ckVPHl48x1hNjQ76aUBEhqSoa8ah+YS3AtJfYnwlktqcaN1AVH1j1fr9cyfbhc7QiiDmj3kWeO/adgDfsq1ZG+BpZZ8MuzM+VZq3zmwiPiqFt0lQod7/CUhzRHi1/l0989b7VEBHzxECMs0XPQX9/USP6V1osu5jNyfSpnydypfy5otmTRYILsGqhuBipl7lkEgNpXBMoGmS0qLTg6ca3Q7fTEp2A31RczrASWOGAF4njmScgGetahYExVzZwBuMSuaqueJotePMon0TftSG1+8xd9yb+oqLUEeamoNPdxmkSVPgq0C6cD2WmMZYKKYIMAHz30JQCoRxuFzWqtpDRyZ6+fJSzEKzqWA8Q3pjFgeZduw6sk6ubKm0zLQYLn1kvnyITQbEH8/z7Cvc/MY9Jq97yG2cZ5uq+BJDeYeJC0sykJEkI2cS7hdYUqmkloqvT81hnkXYX2tTMw+uC1F4cSIny0DKDsDQfRxk9zVuF9xupdCI8GgsNtC+JgQL4Hn8w6y/hB7UbLa0uMSNQCFB3xnrJO+JC+h5f8KGOwiSfmFYrV7AKoD8+R/OVn/cQYLUD6ClKVnbKlTZ88wQE+r90My6CuIA38u/ko7i3qXbFvK0J7XUIdDNg1lxcow6dtMfJ4nwIY21FlwmZt0b6EH1wvo4wnnRMMhYJIcv+i8w6If9C6PLsgGb0YTylOPTThMdQN01i4HKRxZ5ouUnP5/aC6X64ErjIMsNPwKpGA0ULTaXUYHObXCb/0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(376002)(39850400004)(136003)(396003)(5660300002)(8936002)(41300700001)(55236004)(186003)(2616005)(86362001)(31696002)(6506007)(44832011)(26005)(6512007)(4744005)(83380400001)(53546011)(2906002)(36756003)(31686004)(316002)(66476007)(478600001)(38100700002)(4326008)(6486002)(66556008)(8676002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmdXa2lZNk1Jb2hLVXdia3pUcEIvWlVkc0pIT0xURkVyb2hWY3lSNHBkME42?=
 =?utf-8?B?K1A1Q2hJNUMxVlZrUEFKTmN3b0R5UFZiZ09jaFJYWUMydWxhNkhDTTVTSzRV?=
 =?utf-8?B?YTAyeTFEejJIZzVxRVpYcnJnOE50cWhxeVZYaE9ISG4zR05OWGRST250bTZx?=
 =?utf-8?B?a0p0N2RSY3pjUVIzTGNacUhrbkZLL2svUFEzSFhnYjU3VndlK0Z6UTF3Ulpj?=
 =?utf-8?B?aDdDTUx1dEFnNVg3dGtKSVJEMnFiUmwwM0ZtMlAxdXFQampSbXJlNFdGYXBS?=
 =?utf-8?B?MTFubXQ0TzVBdFk3Q0NtUEpUZVZ1RlY1THozSDlnOW1SclBBTEllVTJ0OVJs?=
 =?utf-8?B?YUFibmg2NFl6THZXOThwcWY5d1dOR3V4Q1lQS2VQa1gvazZvL1FjNXdyTnc2?=
 =?utf-8?B?ejhYTmFEUlFKbys0eTJXRUVneDZWKzk4MXFQaVliMHZYcVZybEx5NEtBWW44?=
 =?utf-8?B?QzNLVFFxN3R5THY5Z3RmKzVBdWE5L3ZLMUQ0d1hQdFRkSkFiNU5jYmtLcTRj?=
 =?utf-8?B?b3E0UDg2WVd5VTFkeWFTRFdTbzA3dlhGbXhnUDlpTkF3a3EvMHBkZlFnL2hi?=
 =?utf-8?B?aGFkcUtVMDhhY3dNV3MzRjRJc2ZlRGpwRzhXb2xDMExNZUZGVHRWZUJWMkNs?=
 =?utf-8?B?aDZWUUpjU3diZXNjMnQrVnJxblB6a2l2bDdzeXUxdjhhdy9oRDR0ajJIeFdV?=
 =?utf-8?B?OEprckhvbXcrOGlpajJ0cG51NlhFN2cvZGNVWEZvQm5rQ1EzMVV6dzEzSi9W?=
 =?utf-8?B?WVU4MkpXRU8wOXh4czZ5b1VUSmtUd3M1cVhJZS8rSlo4SkFlY01keTVkZFda?=
 =?utf-8?B?eEdoaUY2VldXN3JiZHYxUEwwcGlCSFVVTEEwemcrS3lLMFl1ZVg2OVZKRmNJ?=
 =?utf-8?B?UFUrdzJsY2JFKytTQ3FSVjIrQlA0TTE3NDFRYnVpMmlJTlVLN2tlUjdmK3hN?=
 =?utf-8?B?WWdMRUNwQiswbUJpYXZrQUZkQVIrYnVtMjNibFZpNkd5N2xKN1N3OVhIVlEy?=
 =?utf-8?B?bFNSeWRzWDE5VndjU0JyL3pGbVJPU0ErRStLNExvbGFiam1LZ20yNTlBSCtZ?=
 =?utf-8?B?aitwM1RWcjY3M1IzQ3I5WVVpV3YyUmRvdjFqYmxrQ0lrMTRnbXAxdlF3dUtL?=
 =?utf-8?B?VVk4aDZjVytkd1BiY1hXZENJaXhkR21Wd3g5UGF3N2tLM3RNYzN2MlduR0xY?=
 =?utf-8?B?dHJNRlI4ZzROa0JiUFdLRHA2WXExZmQydlR2b0sxeU45WXJjcWpXUTMzbFlO?=
 =?utf-8?B?YkxBUVozQlBCSTgrRkZvMFlXNHRLRUNFQWFMTmJ5WVRqVi9SNVZCcDkrZDN5?=
 =?utf-8?B?TEJFcWd3Q3R0K1ZHMTBOQmNLcEFRSjRyM0ZkcitoWmxIb0V6TG5OV3hKNzF4?=
 =?utf-8?B?dWlkZllESms4ZUhoYmhKSzhNMHRWYlVvSy9IQ0RLQ3FaY3ZlNmNPRGcxVTI0?=
 =?utf-8?B?Q2t5Q1VtbWM1NkVaZUFwUVJlc3BzUTJST3J1RFUvMDcrVnVIQWhCM2lsejQ2?=
 =?utf-8?B?K2xpTGZZKy95UkZQTy92SXovQ2x0U2RWMHd2TjRqeWVBNkptMHU2U1VVTE5R?=
 =?utf-8?B?ZjBKT3dPQkZjbnFtM1BQRW9Bb0hPSWVDSXZiWGh3Q21DTWNQejJGcnVsbzkz?=
 =?utf-8?B?WU5HNTdGKzYyQXNhbmswRkNzZi90YnVETHlLRGszRXlsNk9oa09mVThYY1J6?=
 =?utf-8?B?WStKT0E4QnY0MVFyS3BPb0QxTmxGZkZOY2ZvZy9uVk9rd2JhR3BGdTJSSHZH?=
 =?utf-8?B?bStoMWhZTUJjeS83WXI5eHJUa2NKQ0x4WXpWWDRaRGJZU3F0eGNwUERZRk16?=
 =?utf-8?B?UFlFZHc5SFd6enNwZE1HR3ZLL1gvdWJ5a0tqOXFENEtJaTBtQnAvYXUyak16?=
 =?utf-8?B?bUNOVDNmQUJud3ZJcGVWckV2VERrd3NyZWg0eHYrVkZyY2kvZ0NjUkFBdysz?=
 =?utf-8?B?RnZONkZTQXpGWWVWWDFVWm9IeElzcWVSV3FWT1NINWo4b2J1NytYMmNSTWdU?=
 =?utf-8?B?Vld6bjE4cXFkVUtyN0pXT3V5b20wQ3BOdUxYaEZmUXdINENwYlI1Ry9nTTBy?=
 =?utf-8?B?Y3ZvR2E1RXZYb1NjM0tYOWxtb0JhYnh3T0pOK1ppby9SOUZVTzVIT1o2VytC?=
 =?utf-8?Q?dzum6YRPYdNptPAXkq/A2kliv?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea0ab94-1f6c-4c4d-57ad-08da898e1feb
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 07:14:34.5068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OULRxu+T8UxZr8CsIkSH08O+cpcEtCHwnLtB4xaaHuBNML8nNPHjpmUMXJSg1KpuB3f47rVcAOlxa9TXfr8qPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6175
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/22 21:32, Aaron Tomlin wrote:
> [...]
> @@ -59,3 +60,68 @@ void print_unloaded_tainted_modules(void)
>  		}
>  	}
>  }
> +
> +#ifdef CONFIG_DEBUG_FS
> +static void *unloaded_tainted_modules_seq_start(struct seq_file *m, loff_t *pos)
> +{
> +	mutex_lock(&module_mutex);
> +	return seq_list_start_rcu(&unloaded_tainted_modules, *pos);
> +}

unloaded_tainted_modules looks to be a proper RCU list which makes me think
this reader could use just rcu_read_lock() instead of
mutex_lock(&module_mutex)?

Thanks,
Petr
