Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206AC4D25AA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 02:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiCIBEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiCIBE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:04:29 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7585725C79
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 16:41:50 -0800 (PST)
Date:   Tue, 8 Mar 2022 16:17:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646785055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/MNfsQC78m9BLUcGnHt9G4reyS0BmkH4pO0IBzHcGic=;
        b=iiptEpK8tsYEgjL8XVi48pn/op9wY7TtsUtnxroTFeWOqFXIoMOatZqnCYoDXxKl7W7IQw
        bYE7xyoRJRulF1LB4MclGhAiXOkS3OD0cFJyyTT4RJcE1loPDHGpyQXUl3ATOvujFitd01
        9e3d0hfM4SJaiun2Ua+NncKBpm77VRI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH] mm/list_lru: Optimize memcg_drain_list_lru_node()
Message-ID: <YifyG3ak3oNOjELK@carbon.dhcp.thefacebook.com>
References: <20220308033009.1400464-1-longman@redhat.com>
 <YibeERR3Nmh7+9ZA@carbon.dhcp.thefacebook.com>
 <3faa2be7-3a08-ee6d-35e8-c4a35e825c77@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3faa2be7-3a08-ee6d-35e8-c4a35e825c77@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 10:41:38AM -0500, Waiman Long wrote:
> On 3/7/22 23:39, Roman Gushchin wrote:
> > On Mon, Mar 07, 2022 at 10:30:09PM -0500, Waiman Long wrote:
> > > Since commit 2c80cd57c743 ("mm/list_lru.c: fix list_lru_count_node()
> > > to be race free"), we are tracking the total number of lru
> > > entries in a list_lru_node in its nr_items field.  In the case of
> > > memcg_drain_list_lru_node(), there is nothing to be done if nr_items
> > > is 0.  We don't even need to take the nlru->lock as no new lru entry
> > > could be added by a racing list_lru_add() to the draining src_idx memcg
> > > at this point.
> > > 
> > > Signed-off-by: Waiman Long <longman@redhat.com>
> > Hi Waiman!
> > 
> > The patch makes total sense to me, however it needs to be rebased at least
> > on top of "mm: list_lru: rename memcg_drain_all_list_lrus to memcg_reparent_list_lrus".
> > 
> > Thanks!
> > 
> > 
> This patch was based on the current linux-next tree which includes commit
> ff221bc26bdd ("mm: list_lru: rename memcg_drain_all_list_lrus to
> memcg_reparent_list_lrus"). I do remember to double-check linux-next before
> sending this patch out. In fact, the same patch can be applied to both linux
> and linux-next tree without problem.

I'm looking at the mm tree (https://github.com/hnaz/linux-mm.git) and clearly
see that commit "mm: list_lru: rename memcg_drain_all_list_lrus to
memcg_reparent_list_lrus" eliminated the function with the name
memcg_drain_list_lru_node(), which your patch is touching.
Currently the function is located in list_lru.c and is named
memcg_reparent_list_lru_node().

linux-next is sometimes a bit behind the mm tree.

Thanks!
