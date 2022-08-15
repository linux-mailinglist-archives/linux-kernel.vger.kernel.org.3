Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55CA5931BF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 17:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiHOP1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 11:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiHOP1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 11:27:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8001261A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 08:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OgmVgkZQ4f9j8kJY1JYsGRyh8hUz7pYvx+5nxAbDqPw=; b=d6RBhnrKAtZIAE2UNvwWOW320t
        9WqbrT8nU2ZOLrj3UtbYrXC5Ir9wv3WItoyYZTj8yNquxvxEhGzaHzXz4aREJJXQk166X7EzzcedI
        l0/olwqn69GsH2OqYJy7bpuu7QuVMd8DkyCfSuQsmWt64vXEn48gCUDSp17+fqHGhhFD7epJJtCjm
        dN04Q0wWU29eCyhDTIrpuZ4HjE3M2LAm/cBNo9NpjWD9TGI5QY0ZdiEGNcTTre0mOVI/DCKIPd84/
        H7p9kBC4HcQccJ+ktCHTlNb88T/tE7IQJVzJ2phFt6A+KhsbHuQ3dIrw2USKz6958+Hzf7u0qI8HL
        wOmSMtcg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNbzK-005pDP-3A; Mon, 15 Aug 2022 15:26:46 +0000
Date:   Mon, 15 Aug 2022 16:26:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Charan Teja Kalla <quic_charante@quicinc.com>,
        akpm@linux-foundation.org, david@redhat.com,
        pasha.tatashin@soleen.com, sieberf@amazon.com, shakeelb@google.com,
        sjpark@amazon.de, dhowells@redhat.com, quic_pkondeti@quicinc.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH V3] mm: fix use-after free of page_ext after race with
 memory-offline
Message-ID: <YvplthTjM8Ez5DIq@casper.infradead.org>
References: <1660056403-20894-1-git-send-email-quic_charante@quicinc.com>
 <Yvpg6odyDsXrjw5i@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yvpg6odyDsXrjw5i@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 05:06:18PM +0200, Michal Hocko wrote:
> > + * This function gives proper page_ext of a memory section
> > + * during race with the offline operation on a memory block
> > + * this section falls into. Not using this function to get
> > + * page_ext of a page, in code paths where extra refcount
> > + * is not taken on that page eg: pfn walking, can lead to
> > + * use-after-free access of page_ext.
> 
> I do not think this is really useful comment, it goes into way too much
> detail about memory hotplug yet not enough to actually understand the
> interaction because there are no references to the actual
> synchronization scheme. I would go with something like:
> 
> /*
>  * Get a page_ext associated with the given page. Returns NULL if
>  * no such page_ext exists otherwise ensures that the page_ext will
>  * stay alive until page_ext_put is called.
>  * This implies a non-sleeping context.
>  */

I'd go further and turn this into kernel-doc:

/**
 * page_ext_get() - Get the extended information for a page.
 * @page: The page we're interested in.
 *
 * Ensures that the page_ext will remain valid until page_ext_put()
 * is called.
 * 
 * Return: NULL if no page_ext exists for this page.
 * Context: Any context.  Caller may not sleep until they have called
 * page_ext_put().
 */

