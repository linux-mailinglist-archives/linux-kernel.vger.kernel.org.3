Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FA84D601F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347769AbiCKKvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbiCKKvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:51:52 -0500
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1721B0C4C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1646995847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AiRt42fRhEl1AlX/cCUYc0SGy1ZQxOYcHHZJYcVh7lQ=;
        b=Sr+Q4qxm6f2TeWo5XJvlPEnlupNzmYx46pfuI3QlU3wlJLhy0g14o0Mxu0Le3BWpXFA7AM
        qM1KGghfl51ztcscZaP+lomMKOa+ivv7UFrT27xoUvQ7lZaMb6kFCf7mTPT6K4lbwsjh/T
        b2di9uiBbskNm2FZFrQtnG0b2QpMb1k=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2056.outbound.protection.outlook.com [104.47.8.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-32Ee6pqvMNWgssCWxoMaRg-1; Fri, 11 Mar 2022 11:50:46 +0100
X-MC-Unique: 32Ee6pqvMNWgssCWxoMaRg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRHAk2D0ajsnTU5Gyy47om7++aHS2n5tayLZk4eWT5LPBrLUbe3a1GUbLOwtjOs78MDzcqiJjz0Mlw/AOgn1BN/MH8jjs6U+Bqvi2vstXQkudU9wP4leCvvhCEzGBxjdP0yYR394SieYq361pjUrupeSmBg7pSL2SgGgeJXH4puOdGh8ODJlcC1SuDBlXrPuIr5KPq0g6co69Mf2m0LvZ9F1zxQWBY/QiRU4L7wgvfrT09Mghh3jQ8fyz6erUIkrofKYtieQdxVxLAWQcXnba7SrsARBEzStVl1OmxK1kTW0U3c9hvgMCMrENBEqnb0fsyQQE7iT67jSfXr9qOe/fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiRt42fRhEl1AlX/cCUYc0SGy1ZQxOYcHHZJYcVh7lQ=;
 b=HTcYsFcGTGvya5ImKU99FDi+KeuXo65KuIKuUGyGyT3OK0Cf+wmJW7+d1dXsnjSOthrbqDhh3P6s9XRy0bZXgQ/Z15cHEZMSbya4iWSkrStpwmO011GvSf/c/ztKSFjwU+0idUUYsXGX9iC7T+xyfyYUaR3UGOlyZp2PIJf4eoi02jWJv/dRIRm2LsClpTsbpg0hpWO5fmETvkxjkG/mpMtECb9J9ju7HGlmUX7Vs/7DtOIEir2bN4+GLtY7piwyrA89Hg9hV1BU9VMihpve4C3rbomZJPdhgp+Euuwu6vYUUg24C3AUvHfnkaOOrEvBs4/wx9QxkHxjPQrcvJKmwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB5600.eurprd04.prod.outlook.com (2603:10a6:803:e7::16)
 by HE1PR04MB3242.eurprd04.prod.outlook.com (2603:10a6:7:1a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.26; Fri, 11 Mar
 2022 10:50:43 +0000
Received: from VI1PR04MB5600.eurprd04.prod.outlook.com
 ([fe80::e8ce:db1c:5bb0:af0]) by VI1PR04MB5600.eurprd04.prod.outlook.com
 ([fe80::e8ce:db1c:5bb0:af0%6]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 10:50:43 +0000
Message-ID: <d116558e-b13b-9091-8396-337f05db77bb@suse.com>
Date:   Fri, 11 Mar 2022 11:50:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] xen/blkfront: speed up purge_persistent_grants()
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220311103527.12931-1-jgross@suse.com>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <20220311103527.12931-1-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P194CA0037.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:84::14) To VI1PR04MB5600.eurprd04.prod.outlook.com
 (2603:10a6:803:e7::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c18a5839-a88b-4067-f567-08da034cfd85
X-MS-TrafficTypeDiagnostic: HE1PR04MB3242:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <HE1PR04MB3242358946F6362FBECC4C48B30C9@HE1PR04MB3242.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yeeDByY98DVJZ86ZhiNA6ZgHBkWVrXGK3uYX9KAVlfeiBdVGZMch7ggsHXtcDj0mIGxmzNpytTuE2a6geAwB1ySF8/SoiQ4e6zPNbEDzJkzh+bSRTt0z/W9VlDI3VHhN41HUZV5JfPnTmg5ecxFE+Bh12dce1wMdyL7c3FX9XtE1L5/0JQxXuz8RnC3Dwo8uJuSQ2sa2HV28FXNRJ+K3y49UkJtoazQvayBUT0m5zB78FHtpcneIx/7h1qO7IRhmCGrSoVPvWwtlsoPCZykNH15JFfYNQRdhXiuCfNAEn5oWWI4Qn4i2H+Bw7aM56xciP1MEKGyAlLvdOkyTBmXDa4OCZOHXgHkZa7rMF3bC/6eCpLawj7rOBc+lso2o7LyJ2TNqunKCXHdMqOFTsYRwVeML1g+u9hj4oioZ/hxflEkcVrfxfY9F8TULeUplZ6n8nQlXWI+ZiNu2jO2EaR9g+wBBAe8/zcghX4pgV10i/Ys75NV3cNR8GNv264qJW62spnrzsadjTQHWtCjW50EB/lwUzDgJvpLUQx++EWjoYTnO86TiGU3atEnujf9yyD6wIc1SVHHqBjJwKssXKhoGsDdDHvPRNkTxQn5DCEav37FX49HVbxNys0PmEqt09Rk4j8KGTySN751Qw8na8SRgL4LsWY0Lnv3hEDelsDA1LATKVV9wlrkJlXuoQaPD8bn7yMqJFuEeUfhutc3hU4swYpm1BvP/04uLW4Qx7vX5nNE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5600.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(53546011)(31696002)(37006003)(36756003)(316002)(31686004)(2906002)(38100700002)(6486002)(6862004)(66556008)(5660300002)(66946007)(66476007)(186003)(2616005)(508600001)(26005)(6512007)(6506007)(8936002)(8676002)(4326008)(86362001)(6636002)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WG1SNWQxTkFzSTljNWszRmNqNmdDR0J4dDZwWWRINDNSNG54YzUyenRDTTF0?=
 =?utf-8?B?d1JTZXlMZ2hVN2pYazdadnV6aGE3QTI5M1JzRnZVT2NlaHhtY0FwVDBvaXdm?=
 =?utf-8?B?Vm1OeHBGbFZDR0ZhQWNLTGhNVG1janltVXY1K3FBb0pmNER1UjFpN0ppem1E?=
 =?utf-8?B?STBmMmpxUUw2em1uNE9YaXh5NFVoSXZnT3lhM29FZGppa3FKcm9wN0ZlbCtQ?=
 =?utf-8?B?VzhXQVRZTEJUbHBmRDg2THQ1WEtqVk5sYkFnSnlJZ25hTUFhUEcvZEluZnNI?=
 =?utf-8?B?b1Nzb3J2VE1JdW1la1Y0dTBTVjQ2RWVzV2hsWTZpZEUwakpmTi8ramtkNm9x?=
 =?utf-8?B?SW9nMFNDblJsT282UWl6eFp1R3AxSEZ2TmJrYlBRb0dzM0UvenVCcUxEZDBT?=
 =?utf-8?B?djJVRnJKRGVYdlNqV0xnM21UYVJiOUZOWWNsOE9FTURHbVFaaXkxN0pzcTU0?=
 =?utf-8?B?TDJOcnRxcHNGRldQM08yRS9MSmwvUXYrV1V2b3BZekNzV2tXOUdHRytyMWtR?=
 =?utf-8?B?M1psVUVLMm1GK0V5WnJlL2JQSnAzL1lnTFlYN0VxeXF2bUFxWVQvT0ZjUGh2?=
 =?utf-8?B?RHlPTjZqUm5HSkMwMzV5SW40WC82NVNxb1Z6YW1TUXd0RnJsMm9vTzR0WnFK?=
 =?utf-8?B?Qytoa1paR2NVZFNhaDdDT3phU3RvV0d5MGRUdllIdFN0OXZuZ2FmWlEwM3pK?=
 =?utf-8?B?cWtGZ21NNHRiaXpJWkUrQ3ltdkg4OTBoQXJ0S1dwT2VyVmY2dUVib1NmdWpk?=
 =?utf-8?B?U0ZOWElBeEpDbUlkVTNHNVBudlRNK3c4c2ZZUXV5dzZUNlhraTUraW54N1Vn?=
 =?utf-8?B?Y1I5UGpLNWhuTytyVERDeVpLTThDcXU4OXUrRXhKVmdocnhCQWNyRGZrZHJ1?=
 =?utf-8?B?QmFzTEY0WUlXcEF1ZUFxa29Nd21WYVBRa0tJekszdVFnYXY2ZW9xT3pnOSt0?=
 =?utf-8?B?MjZVZThzVU9VTlBNQnB2QUlRdzFiODlVTGFrYlFlbXdPSTNqRStmcXJkeGJF?=
 =?utf-8?B?YjVoNTRaTEYxUDNmMG1JRG9ybi9xOGVKd3Y1WnAwMmpmL3AxS1RxUUhPcTRO?=
 =?utf-8?B?NGJlckY0NTVjc005VU5UdmlUM3M0MnZrYVFLRXc1R1lZeW1Hc1dHeFRxMTNu?=
 =?utf-8?B?a3Fxb3lDbldSdThBMEExREpObVY0RG5oTi93aURsb2UxYUMyYTVjVS8vc3JY?=
 =?utf-8?B?VExicTlUT0pLSitEYnNUTkQ0R09zRk5PU1N0c1FHQk91bldYbjdObXY4amNP?=
 =?utf-8?B?Y0EreVYvSTJlbTl3WDFOM01Sb1Y3a2NnYlduK005OXV5bldhQTRIK2RMSnJ2?=
 =?utf-8?B?WVRueFhibmFwYytXU3FDV09IajIydlNnMk1tVTF3Mk9nN1NoUm0zOG5ITTFp?=
 =?utf-8?B?SndoeW1HZ3doMnh1ajJsSzU5ZVRaSUFKQUxpZ0g0aTJJV2QrNU44QmZkQVJ4?=
 =?utf-8?B?Wm9QQ01uK0p5QjViOEhOdVlMdlA4U0xnRGN0K2RrZkNwUjh5TWNTN2VDZFhM?=
 =?utf-8?B?OFNhYkVwWWNiVXZWeC82c2N2d2hpNkhwZ3pxSEZaSjlqZit5MnBIdWZSeGJI?=
 =?utf-8?B?SFkvRjRiaFkvem5LejdSQ0dxWVhPMmtZdzVOaW9QWnRNbHZ4aE5HcG5tMkpG?=
 =?utf-8?B?NkJhT1QzM0NpZ0czN3lwSkViMW5YVmtWUSsxVFRTTVl1dmc4M2JJREpIQTZB?=
 =?utf-8?B?MERYR3VrVCsrTXJOc3VxUEdKUEtndmtlZU1WVHlrSUlWb1FFbU1OTXBaK3RB?=
 =?utf-8?B?RFhISkVDTTNVaHZQck1rL055OFlKN0dDZEw5bG9YeUswZURMcWY0TzBBOVRh?=
 =?utf-8?B?NHM4MkVMc0JsWUNNc3FuYThubDVOY0lqZnM5cjA2QlRiT0FSdzJzd1lJTWNz?=
 =?utf-8?B?dUJaTmw2RFQwOG1md3liYXU0anJyS1RuLzBIc1JmaGtKbGhKVEMxQi9NNXk0?=
 =?utf-8?B?aENrR1M4L2J1dU9vSTFWa05OQktmMUJkQzZnNjNwYlkrQ2RRYTFKWm9WeXRX?=
 =?utf-8?B?Y1RnVkdWdWlRU0gxUWFsaVNPWmg5TVJkblgvSU1tZlJFMVJEczJrS25ndXEy?=
 =?utf-8?B?V2hveGZhcEwwdmFibVZGSnFoQ3N0djZNamRVSjZJRTFTdnpIdjZQekhLNEF5?=
 =?utf-8?B?Y1FMbWRYWk1keUxoajB1S3NHRytoRlFydWZsUWhLdG5ob0c3cWwzZGlEakxm?=
 =?utf-8?Q?2sn7FBqJlyi35HK9SZpufpE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c18a5839-a88b-4067-f567-08da034cfd85
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5600.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 10:50:43.3096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NueNW4UvrgtXQQ/0qqCnx0v2KdLWBe0XKfzN2pdgn08fs1+cNfkwBgUSPxPuB6UgutblJqmt0nLaMdzilaEtHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3242
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.03.2022 11:35, Juergen Gross wrote:
> purge_persistent_grants() is scanning the grants list for persistent
> grants being no longer in use by the backend. When having found such a
> grant, it will be set to "invalid" and pushed to the tail of the list.
> 
> Instead of pushing it directly to the end of the list, add it first to
> a temporary list, avoiding to scan those entries again in the main
> list traversal. After having finished the scan, append the temporary
> list to the grant list.
> 
> Suggested-by: Jan Beulich <jbeulich@suse.com>
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Jan Beulich <jbeulich@suse.com>

