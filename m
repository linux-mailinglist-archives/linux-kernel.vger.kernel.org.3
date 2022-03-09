Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8984D253A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 02:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiCIBKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiCIBJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:09:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FC97C7E54
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 16:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646787057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sfZ5PwvLnI4LLU34fgHb1e9AhJAkBykiEyb2Klxh090=;
        b=DSPxgnwtOTO14S3vCCucAmhRnhnNzjro6Fu3zG3H3Uvhm1z2FHXtecKXxwzBagZlODJxOG
        JZWOeMbVFQDum4o/jIFsjprf5/4U1oqN+P3yAcySkEsUit1taGSbOFCJmNHYdbcITZzRd5
        0DHbPtdaiNVbErJuQGuKRUfUQIi44+Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175-dNiZfsEjOdapE2gi6wjFvg-1; Tue, 08 Mar 2022 19:50:54 -0500
X-MC-Unique: dNiZfsEjOdapE2gi6wjFvg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C41B1006AA6;
        Wed,  9 Mar 2022 00:50:53 +0000 (UTC)
Received: from [10.22.11.135] (unknown [10.22.11.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B38D72427;
        Wed,  9 Mar 2022 00:50:52 +0000 (UTC)
Message-ID: <34bc9788-0459-9126-8aa9-e0d10e9f5b5f@redhat.com>
Date:   Tue, 8 Mar 2022 19:50:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mm/list_lru: Optimize memcg_drain_list_lru_node()
Content-Language: en-US
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
References: <20220308033009.1400464-1-longman@redhat.com>
 <YibeERR3Nmh7+9ZA@carbon.dhcp.thefacebook.com>
 <3faa2be7-3a08-ee6d-35e8-c4a35e825c77@redhat.com>
 <YifyG3ak3oNOjELK@carbon.dhcp.thefacebook.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YifyG3ak3oNOjELK@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/22 19:17, Roman Gushchin wrote:
> On Tue, Mar 08, 2022 at 10:41:38AM -0500, Waiman Long wrote:
>> On 3/7/22 23:39, Roman Gushchin wrote:
>>> On Mon, Mar 07, 2022 at 10:30:09PM -0500, Waiman Long wrote:
>>>> Since commit 2c80cd57c743 ("mm/list_lru.c: fix list_lru_count_node()
>>>> to be race free"), we are tracking the total number of lru
>>>> entries in a list_lru_node in its nr_items field.  In the case of
>>>> memcg_drain_list_lru_node(), there is nothing to be done if nr_items
>>>> is 0.  We don't even need to take the nlru->lock as no new lru entry
>>>> could be added by a racing list_lru_add() to the draining src_idx memcg
>>>> at this point.
>>>>
>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>> Hi Waiman!
>>>
>>> The patch makes total sense to me, however it needs to be rebased at least
>>> on top of "mm: list_lru: rename memcg_drain_all_list_lrus to memcg_reparent_list_lrus".
>>>
>>> Thanks!
>>>
>>>
>> This patch was based on the current linux-next tree which includes commit
>> ff221bc26bdd ("mm: list_lru: rename memcg_drain_all_list_lrus to
>> memcg_reparent_list_lrus"). I do remember to double-check linux-next before
>> sending this patch out. In fact, the same patch can be applied to both linux
>> and linux-next tree without problem.
> I'm looking at the mm tree (https://github.com/hnaz/linux-mm.git) and clearly
> see that commit "mm: list_lru: rename memcg_drain_all_list_lrus to
> memcg_reparent_list_lrus" eliminated the function with the name
> memcg_drain_list_lru_node(), which your patch is touching.
> Currently the function is located in list_lru.c and is named
> memcg_reparent_list_lru_node().
>
> linux-next is sometimes a bit behind the mm tree.

Oh, you are right. I will rebase the patch based on linux-mm.

Thanks for the suggestion.

Cheers,
Longman

