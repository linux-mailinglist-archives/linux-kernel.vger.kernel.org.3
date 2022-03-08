Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092EE4D1BF3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347903AbiCHPmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345008AbiCHPml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:42:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6CF5D4ECE6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646754104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J4Mi1zxnZfVXccvQzY1RMVV1+od7uM0sIlTvgeoks5k=;
        b=e3GYwO/IX0/hnsSeLvHBo10eqJ9AfuxS0u+twC8DMduSoci+HOUmzM1X9fZBIQ9ZTMYgQ7
        +GhqgRbjruOOf540BlyZUK/xJmwAbaijzvYH+jEpTn9jsnqndCnyoMNOXJP0f60Geg6WUS
        s1b2ZR8wgL6VrPOf+74Y8H5kslaZdrs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-uclafJ5QMO2SbckcCIWUYA-1; Tue, 08 Mar 2022 10:41:41 -0500
X-MC-Unique: uclafJ5QMO2SbckcCIWUYA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 155E91091DA0;
        Tue,  8 Mar 2022 15:41:40 +0000 (UTC)
Received: from [10.22.11.135] (unknown [10.22.11.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 43FD4106415F;
        Tue,  8 Mar 2022 15:41:39 +0000 (UTC)
Message-ID: <3faa2be7-3a08-ee6d-35e8-c4a35e825c77@redhat.com>
Date:   Tue, 8 Mar 2022 10:41:38 -0500
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
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YibeERR3Nmh7+9ZA@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

On 3/7/22 23:39, Roman Gushchin wrote:
> On Mon, Mar 07, 2022 at 10:30:09PM -0500, Waiman Long wrote:
>> Since commit 2c80cd57c743 ("mm/list_lru.c: fix list_lru_count_node()
>> to be race free"), we are tracking the total number of lru
>> entries in a list_lru_node in its nr_items field.  In the case of
>> memcg_drain_list_lru_node(), there is nothing to be done if nr_items
>> is 0.  We don't even need to take the nlru->lock as no new lru entry
>> could be added by a racing list_lru_add() to the draining src_idx memcg
>> at this point.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Hi Waiman!
>
> The patch makes total sense to me, however it needs to be rebased at least
> on top of "mm: list_lru: rename memcg_drain_all_list_lrus to memcg_reparent_list_lrus".
>
> Thanks!
>
>
This patch was based on the current linux-next tree which includes 
commit ff221bc26bdd ("mm: list_lru: rename memcg_drain_all_list_lrus to 
memcg_reparent_list_lrus"). I do remember to double-check linux-next 
before sending this patch out. In fact, the same patch can be applied to 
both linux and linux-next tree without problem.

Cheers,
Longman

